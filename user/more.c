#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "user/user.h"
#include "helpers.c"
#include "LinkedList.c"
#include "textEditHelpers.c"
// adjusted terminal height (accounts for "MORE" @ bottom)
#define TermHeight (terminal.height - 1)
#define TopLine ((file.curLine - TermHeight) + 1)

// protptypes
void forward(struct File* file, Terminal terminal);
void skip(struct File* file, Terminal terminal, int numPages);
void back(struct File* file, Terminal terminal, int numPages);
void scroll(struct File* file, Terminal terminal, int numLines);
void line(File file, Terminal terminal);
void help(Terminal terminal);
// helpers
void printPrompt(File file, Terminal terminal);
void showPage(File file, Terminal terminal);
void showLines(File file, Terminal terminal, int numLines);
static int collectNum(char c, int* numCollector);
static char getCmd();

static void moreVersion();
static void moreBI();
static void more2Much();
static void moreHelp(Terminal terminal);

int main(int argc, char* argv[]) {
  // terminal object
  Terminal terminal;
  terminal.width = 55;
  terminal.height = 25;
  terminal.d = 0;

  char* filename;
  // arg czeching
  if (argc == 1) // more
    moreBI(); // bad input
  else if (argc > 3) // too many args
    more2Much(); // no 3+ file support
  // more -h, more -d README
  else if (argv[1][0] == '-')
    switch (argv[1][1]) {
    case 'D':
    case 'd': 
      if (argc != 3) moreBI();
      terminal.d = 1; 
      filename = argv[2]; break;
    case 'H':
    case 'h': moreHelp(terminal);
    case 'V':
    case 'v': moreVersion();
    default: 
      fprintf(2, "unrecognized flag %s\n", argv[1]); 
      exit();
    }
  else if (argc > 2) // more README dr.ac
    more2Much();
  else { // more README
    filename = argv[1];
  }
	
  // file object
  struct File file;
  file.len = 0;
  file.edited = 0;
  file.curLine = TermHeight; // line displayed at bottom
  file.filename = filename;
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
		case ' ': forward(&file, terminal); break;
    case 'f':
    case 'F': skip(&file, terminal, numArg); break;
		case 'b':
    case 'B': back(&file, terminal, numArg); break;
		case 's':
		case 'S':
		case '\n': scroll(&file, terminal, numArg); break;
		case '=': line(file, terminal); break;
    case 'h':
    case 'H': help(terminal); 
              printPrompt(file, terminal); break;
    case 'l':
    case 'L': showPage(file, terminal); break;
		default : break;
		}
    // here we keep track of number arguments
    collectNum(cmd, &numCollector);
    numArg = (numCollector > 0) ? numCollector : 1;
  }
  exit();
  return 0;
}

// basic commands
void forward(struct File* file, Terminal terminal){
  file->curLine += TermHeight; // forward 1 page
  // don't go past end of file
  if (file->curLine > file->len) file->curLine = file->len;
  showPage(*file, terminal);
}
void skip(struct File* file, Terminal terminal, int numPages){
  file->curLine += (numPages * TermHeight); // forward x pages
  // don't go past end of file
  if (file->curLine > file->len) file->curLine = file->len;
  eraseLine(terminal.width);
  printf("...skipping %d page%s\n", numPages, (numPages > 1) ? "s" : "");
  showPage(*file, terminal);
}
void back(struct File* file, Terminal terminal, int numPages){
  file->curLine -= (numPages * TermHeight); // back x pages
  // don't go past beginning of file
  if (file->curLine < TermHeight) file->curLine = TermHeight;
  eraseLine(terminal.width);
  printf("...back %d page%s\n", numPages, (numPages > 1) ? "s" : "");
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
  printf("<int> \\n,s,S  Scroll down <int> lines [1]\n");
  printf("<int> b,B     Skip back <int> pages [1]\n");
  printf("<int> f,F     Skip forward <int> pages [1]\n");
  printf("=             Display current line number\n");
  printf(".             Repeat previous command\n");
  printf("l or L        Redraw page\n");
  printf("q or Q        Exit from more\n");
  // printf("d or ctrl-D   Scroll k lines [current scroll size, initially 11]*\n");
  // printf("v             Start up /usr/bin/vi at current line\n");
  printpad(terminal.width, '-', "-", LEFT, 1);
}

// help
void showPage(File file, Terminal terminal) {
  struct Node* curNode = lineAt(file.lines, TopLine);
  int termLine = 0; // num lines we've written to the terminal so far
  int firstLine = 1;
  while (termLine < TermHeight) {
    if (firstLine) {
      firstLine = 0;
      eraseLine(terminal.width);
    }
    printf("%s\n", curNode->data);
    curNode = curNode->next;
    termLine++;
    if (curNode == file.lines->tail) exit();
  }
  printPrompt(file, terminal);
}

void showLines(File file, Terminal terminal, int numLines) {
  // get the node after our current one
  struct Node* curNode = (lineAt(file.lines, file.curLine))->next;
  int firstLine = 1;
  while (numLines-- > 0) {
    if (firstLine) {
      firstLine = 0;
      eraseLine(terminal.width);
    }
    printf("%s\n", curNode->data);
    curNode = curNode->next;
    if (curNode == file.lines->tail) exit();
  }
  printPrompt(file, terminal);
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

static void moreBI() {
  fprintf(2, "more: bad usage\nTry 'more -h' for more information.\n");
  exit();
}

static void more2Much() {
  fprintf(2, "this version of more only ");
  fprintf(2, "supports one file at a time.\n");
  exit();
}

static void moreHelp(Terminal terminal) {
  printpad(terminal.width, '-', "-", LEFT, 1);
  printf("\nUsage:\n");
  printf(" more [options] <file>...\n");
  printf("A file perusal filter for CRT viewing.\n");
  printf("Options:\n");
  printf(" -F, -d   display command explanation\n");
  // printf(" -f          count logical rather than screen lines\n");
  // printf(" -s          squeeze multiple blank lines into one\n");
  // printf(" -<number>   the number of lines per screenful\n");
  // printf(" +<number>   display file beginning from line number\n");
  printf(" -H, -h   display this help\n");
  printf(" -V, -v   display version\n");
  printpad(terminal.width, '-', "-", LEFT, 1);
  exit();
}
void printPrompt(File file, Terminal terminal) {
  printf("--MORE--(%d%%)", 100 * file.curLine / file.len);
  if (terminal.d) printf("[Press space to continue, 'q' to quit.]");
  printf("\r");
}

static void moreVersion() {
  printf("more from MatousAc-xv6 0.1.0\n");
  exit();
}

