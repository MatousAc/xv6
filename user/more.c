#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "user/user.h"
#include "helpers.c"
#include "LinkedList.c"
#include "textEditHelpers.c"
// adjusted terminal height (accounts for "MORE" @ bottom)
#define TERMH_ADJ (terminal.height - 1)
#define LINE_ON_TOP ((file.curLine - TERMH_ADJ) + 1)
// prototypes - editors
void end(struct File* file, char* args);
void add(struct File* file, char* args);
void drop(struct File* file, char* args);
void edit(struct File* file, char* args);
void list(struct File file, char* args);
// pagers
void printPrompt(File file);
void showPage(File file, Terminal terminal);
void forward(struct File* file, Terminal terminal);
void skip(struct File* file, Terminal terminal);
void back(struct File* file, Terminal terminal);
void scroll(struct File* file, Terminal terminal);
void line(File file, Terminal terminal);
void help(Terminal terminal);

int main(int argc, char* argv[]) {
  // arg czeching
  if (argc < 2) {
    fprintf(2, "more: bad usage\nTry 'more --help' for more information.\n");
    exit();
  } else if (argc > 2) {
    fprintf(2, "this version of more only supports one file at a time.\n");
    exit();
  }
	
  // prep
  char cmd = ' ';
  int cmdint = 0;
  // objects we will pass around
  Terminal terminal;
  terminal.width = 100;
  terminal.height = 25;
  struct File file;
  file.len = 0;
  file.edited = 0;
  file.curLine = TERMH_ADJ; // line displayed at bottom
  file.filename = argv[1];
  file.lines = MakeLinkedList();

  // opening file
  file.fd = open(file.filename, O_RDONLY);
  if (file.fd == -1) {
    fprintf(2, "file could not be opened\n",  file.filename);
  } else {
    // populate Linked List
    gatherLinesSized(&file, terminal);
  }
  close(file.fd);

  // loop
  showPage(file, terminal);
  while (cmd != 'q' && cmd != 'Q') {
    cmdint = steal(0);
    cmd = (char) cmdint;
		// printf("cmd: %d = %c.\n", cmdint, cmd);
		if (cmd == '\0') exit();
		switch (cmd) {
		case ' ':
			forward(&file, terminal);
      showPage(file, terminal);
			break;
    case 'f':
			skip(&file, terminal);
      showPage(file, terminal);
			break;
		case 'b':
			back(&file, terminal);
      showPage(file, terminal);
			break;
		case 'e':
			scroll(&file, terminal);
      showPage(file, terminal);
			break;
		case '=':
			line(file, terminal);
			break;
    case 'h':
			help(terminal);
      showPage(file, terminal);
			break;
		default:
			break;
		}
  }
  exit();
  return 0;
}

// commands
void forward(struct File* file, Terminal terminal){
  file->curLine += TERMH_ADJ;
}
void skip(struct File* file, Terminal terminal){
  file->curLine += (2 * TERMH_ADJ);
  char* msg = "...skipping 1 page";
  printpad(terminal.width, ' ', msg, LEFT, 0);
}
void back(struct File* file, Terminal terminal){
  file->curLine -= TERMH_ADJ;
  if (file->curLine < TERMH_ADJ) file->curLine = TERMH_ADJ;
  char* msg = "...back 1 page";
  printpad(terminal.width, ' ', msg, LEFT, 0);
}
void scroll(struct File* file, Terminal terminal){
  file->curLine++;
  char* msg = "...scrolling one line";
  printpad(terminal.width, ' ', msg, LEFT, 0);
}
void line(File file, Terminal terminal){
  char msg[5];
  itoa(file.curLine, msg, 10);
  printpad(terminal.width, ' ', msg, LEFT, 0);
}
void help(Terminal terminal) {
  printpad(terminal.width, '-', "-", LEFT, 1);
  printf("<space>                 Display next k lines of text [current screen size]\n");
  printf("<return>                Display next k lines of text [1]*\n");
  printf("b or B                  Skip backwards 1 screenful of text\n");
  // printf("z                       Display next k lines of text [current screen size]*\n");
  printf("e                       Display next k lines of text [1]*\n");
  // printf("d or ctrl-D             Scroll k lines [current scroll size, initially 11]*\n");
  printf("f                       Skip forward 1 screenful of text\n");
  printf("=                       Display current line number\n");
  // printf("v                       Start up /usr/bin/vi at current line\n");
  // printf("l or L                  Redraw screen\n");
  printf("q or Q or <interrupt>   Exit from more\n");
  // printf(".                       Repeat previous command\n");
  printpad(terminal.width, '-', "-", LEFT, 1);
}

// help
void printPrompt(File file) {
  printf("\n--MORE--(%d%%)", 100 * file.curLine / file.len);
  printf("[Press space to continue, 'q' to quit.]\r");
}

void showPage(File file, Terminal terminal) {
  printpad(terminal.width, '#', "#", LEFT, 0);
  printf("curLine:    %d\n", file.curLine);
  printf("terminal.h: %d\n", terminal.height);
  printf("terminal.w: %d\n", terminal.width);
  printf("TERMH_ADJ:  %d\n", TERMH_ADJ);
  printf("TOP_LINE:   %d\n", LINE_ON_TOP);
  printf("file top: \n%s\n", (lineAt(file.lines, LINE_ON_TOP))->data);
  printpad(terminal.width, '#', "#", LEFT, 0);

  struct Node* curNode = lineAt(file.lines, LINE_ON_TOP);
  int termLine = 0; // num lines we've written to the terminal so far
  while (termLine < TERMH_ADJ) {
    printf("%s\n", curNode->data);
    curNode = curNode->next;
    termLine++;
    if (curNode == file.lines->tail) exit();
  }
  printPrompt(file);
}

// old commands
void end(struct File* file, char* args) {
  file->edited = 1;
  char* line = args;
  append(file->lines, line);
  file->len++;
}

void add(struct File* file, char* args) {
  file->edited = 1;
  if (strlen(args) < 1) {
    fprintf(2, "you need to give a line number to insert before\n");
    return;
  }
  char lineStr[10];
  getArg(lineStr, args, ' ');
  char* line = args;

  int lineNum = negatoi(lineStr);
  // 1-based to 0-based insert
  insert(file->lines, line, lineNum - 1);
  file->len++;
}

void drop(struct File* file, char* args) {
  if (strlen(args) < 1) {
    fprintf(2, "you need to give a range to drop\n");
    return;
  }

  int start, end;
  if (collectRange(args, &start, &end) == 1) {
    fprintf(2, "error: start index is larger than end index\n");
    return;
  }
  if (normalizeRange(*file, &start, &end) == 1) {
    fprintf(2, "error: bad input range. make sure start < end\n");
    return;
  }
  int numl = numLines(start, end);
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
  else fprintf(2, "Drop %d lines [%d:%d] (y/n)? ", numl, start, end);
  if (confirmation() != 0) return;
  file->edited = 1;

  // drop lines
  struct Node* curNode = (lineAt(file->lines, start))->prev;
  struct Node* stopNode = lineAt(file->lines, end);
  while (curNode != stopNode) {
    curNode = curNode->next;
    destroyNode(file->lines, curNode);
    file->len--;
  }
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
  else fprintf(2, "%d lines dropped\n", numl);
  return;
}

void edit(struct File* file, char* args) {
  if (strlen(args) < 1) {
    fprintf(2, "you need to give a line number to replace\n");
    return;
  }
  char lineStr[10];
  getArg(lineStr, args, ' ');
  char* line = args;

  int lineNum = negatoi(lineStr);
  fprintf(2, "replace line %d (y/n)? ", lineNum);
  if (confirmation() != 0) return;
  file->edited = 1;

  // remove
  destroyNode(file->lines, lineAt(file->lines, lineNum));
  // 1-based to 0-based insert
  insert(file->lines, line, lineNum - 1);
}

void list(struct File file, char* args) {
  if (strlen(args) < 1) {
    fprintf(2, "you need to give a range to list\n");
    return;
  }

  int start, end, lineNum;
  if (collectRange(args, &start, &end) == 1) {
    fprintf(2, "error: start index is larger than end index\n");
    return;
  }
  if (normalizeRange(file, &start, &end) == 1) {
    fprintf(2, "error: bad input range. make sure start < end\n");
    return;
  }
  
  lineNum = start - 1;
  struct Node* curNode = (lineAt(file.lines, start))->prev;
  struct Node* stopNode = lineAt(file.lines, end);
  while (curNode != stopNode) {
    curNode = curNode->next;
    if (curNode == file.lines->tail) return;
    printl(++lineNum, curNode->data);
  }
}

void show(struct File file, char* args) {
  struct Node* cur = file.lines->head->next;
  int lineNum = 1;
  while (cur != file.lines->tail) {
    printl(lineNum, cur->data);
    cur = cur->next;
    lineNum++;
  }
}

void quit(struct File* file) {
  if (file->edited == 0) return;
  fprintf(2, "save changes (y/n)? ");
  if (confirmation() != 0) return;

  // save contents
  if (unlink(file->filename) < 0) {
    fprintf(2, "could not clear file for writing. changes lost\n");
    return;
  }
  file->fd = open(file->filename, O_CREATE|O_RDWR);
  if (file->fd < 0) {
    fprintf(2, "could not open file for writing. changes lost\n");
    return;
  }
  struct Node* cur = file->lines->head->next;
  while (cur != file->lines->tail) {
    write(file->fd, cur->data, strlen(cur->data));
    write(file->fd, "\n", sizeof(char));
    cur = cur->next;
  }
  close(file->fd);
  fprintf(2, "changes saved\n");
  return;
}

