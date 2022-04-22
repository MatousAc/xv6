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
void showLines(File file, Terminal terminal, int numLines);
void forward(struct File* file, Terminal terminal);
void skip(struct File* file, Terminal terminal, int numPages);
void back(struct File* file, Terminal terminal, int numPages);
void scroll(struct File* file, Terminal terminal, int numLines);
void line(File file, Terminal terminal);
void help(Terminal terminal);
static int collectNum(char c, int* numCollector);
static char getCmd();

int main(int argc, char* argv[]) {
  // arg czeching
  if (argc < 2) {
    fprintf(2, "more: bad usage\nTry 'more --help' for more information.\n");
    exit();
  } else if (argc > 2) {
    fprintf(2, "this version of more only supports one file at a time.\n");
    exit();
  }
	
  // objects we will pass around
  Terminal terminal;
  terminal.width = 55;
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
  char cmd = ' ', previous = ' ';
  // char previous = ' ';
  int numCollector = 0;
  int numArg = 1;
  showPage(file, terminal);
  while (cmd != 'q' && cmd != 'Q') {
    cmd = getCmd();
		// printf("cmd: = %c.\n", cmd);
    if (cmd == '.') cmd = previous;
    else previous = cmd;
		switch (cmd) {
		case ' ':
			forward(&file, terminal);
			break;
    case 'f':
    case 'F':
			skip(&file, terminal, numArg);
			break;
		case 'b':
    case 'B':
			back(&file, terminal, numArg);
			break;
		case 's':
		case 'S':
		case 'e':
		case 'E':
			scroll(&file, terminal, numArg);
			break;
		case '=':
			line(file, terminal);
			break;
    case 'h':
    case 'H':
			help(terminal);
			break;
		default:
			break;
		}
    // here we keep track of number arguments
    collectNum(cmd, &numCollector);
    numArg = (numCollector > 0) ? numCollector : 1;
  }
  exit();
  return 0;
}

// commands
void forward(struct File* file, Terminal terminal){
  file->curLine += TERMH_ADJ; // forward 1 page
  // don't go past end of file
  if (file->curLine > file->len) file->curLine = file->len;
  showPage(*file, terminal);
}
void skip(struct File* file, Terminal terminal, int numPages){
  file->curLine += (numPages * TERMH_ADJ); // forward x pages
  // don't go past end of file
  if (file->curLine > file->len) file->curLine = file->len;
  char* msg = "...skipping";
  printpad(terminal.width, ' ', msg, LEFT, 0);
  showPage(*file, terminal);
}
void back(struct File* file, Terminal terminal, int numPages){
  file->curLine -= (numPages * TERMH_ADJ); // back x pages
  // don't go past beginning of file
  if (file->curLine < TERMH_ADJ) file->curLine = TERMH_ADJ;
  char* msg = "...back pages";
  printpad(terminal.width, ' ', msg, LEFT, 0);
  showPage(*file, terminal);
}
void scroll(struct File* file, Terminal terminal, int numLines){
  showLines(*file, terminal, numLines);
  file->curLine += numLines;
}
void line(File file, Terminal terminal){
  char msg[10];
  itoa(file.curLine, msg, 10);
  printpad(terminal.width, ' ', msg, LEFT, 0);
  printf("\r"); // we want to rewrite this line eventually
}
void help(Terminal terminal) {
  printpad(terminal.width, '-', "-", LEFT, 1);
  printf("Command       Description [Def Parameter]\n");
  printf("<space>       Display next page\n");
  printf("<int> e,E,s,S Display next <int> lines [1]\n");
  printf("<int> b,B     Skip back <int> screens [1]\n");
  printf("<int> f,F     Skip forward <int> screens [1]\n");
  printf("=             Display current line number\n");
  printf(".             Repeat previous command\n");
  printf("q or Q        Exit from more\n");
  // printf("d or ctrl-D   Scroll k lines [current scroll size, initially 11]*\n");
  // printf("v             Start up /usr/bin/vi at current line\n");
  // printf("l or L        Redraw screen\n");
  printpad(terminal.width, '-', "-", LEFT, 1);
}

// help
void printPrompt(File file) {
  printf("\n--MORE--(%d%%)", 100 * file.curLine / file.len);
  printf("[Press space to continue, 'q' to quit.]\r");
}

void showPage(File file, Terminal terminal) {
  struct Node* curNode = lineAt(file.lines, LINE_ON_TOP);
  int termLine = 0; // num lines we've written to the terminal so far
  int firstLine = 1;
  while (termLine < TERMH_ADJ) {
    if (firstLine) {
      firstLine = 0;
      printpad(terminal.width, ' ', curNode->data, LEFT, 0);
    } else printf("%s\n", curNode->data);
    curNode = curNode->next;
    termLine++;
    if (curNode == file.lines->tail) exit();
  }
  printPrompt(file);
}

void showLines(File file, Terminal terminal, int numLines) {
  // get the node after our current one
  struct Node* curNode = (lineAt(file.lines, file.curLine))->next;
  int firstLine = 1;
  while (numLines-- > 0) {
    if (firstLine) {
      firstLine = 0;
      printpad(terminal.width, ' ', curNode->data, LEFT, 0);
    } else printf("%s\n", curNode->data);
    curNode = curNode->next;
    if (curNode == file.lines->tail) exit();
  }
  printPrompt(file);
}

static int collectNum(char c, int* numCollector) {
  if (!isDigit(c)) {
    *numCollector = 0;
    return 0; // not a successful addition
  }
  *numCollector *= 10;
  *numCollector += ctoi(c);
  return *numCollector;
}

static char getCmd() {
  char cmd = consGetChar();
  if (cmd == '\0') exit();
  printf("\r");
  return cmd;
}
