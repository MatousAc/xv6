#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "user/user.h"
#include "LinkedList.c"
#define MAXFILESIZE 71680
#define MAXLINESIZE 1000

enum { END, ADD, DROP, EDIT, LIST, SHOW, QUIT, BI };
typedef struct File {
  char* filename;
  int fd;
  struct LinkedList* lines;
  int len;
} File;

void end(struct File* file, char* args);
void add(struct File* file, char* args);
void drop(struct File* file, char* args);
void edit(struct File* file, char* args);
void list(struct File file, char* args);
void show(struct File file, char* args);
void quit(struct File file, char* args);
void bi();
void substr(char* dest, char* str, int start, int end);
int collectRange(char* args, int* startptr, int* endptr);
int numLines(int start, int end);
int normalizeRange(File file, int* startptr, int* endptr);
int getLine(int fileptr, char line[]);
void getArg(char* dest, char* args, char delimiter);
int find(char* str, char c);
Node* lineAt(struct LinkedList* list, int pos);
void gatherLines(File* file);
int confirmation();
void toUpper(char* str);
void toLower(char* str);
void unline(char* str);
void printl(int lineNum, char* line);

int main(int argc, char* argv[]) {
  // arg czeching
  if (argc < 2) {
    fprintf(2, "specify a file you want to edit");
    exit();
  } else if (argc > 2) {
    fprintf(2, "only specify one file");
    exit();
  }
  static char buf[100] = "";
  char cmdstr[100] = "";
  char args[100] = "";
  int nbuf = sizeof(buf);
  int cmd = END;
  // objects we will pass around
  struct stat {
    short type;
    int dev;
    uint ino;
    short nlink;
    uint size;
  };
  struct File file;
  file.len = 0;
  file.filename = argv[1];
  file.lines = MakeLinkedList();
  fprintf(2, "Welcome to xvEdit!\n");

  // opening
  file.fd = open(file.filename, O_RDONLY);
  if (file.fd == -1) {
    fprintf(2, "creating %s . . .\n",  file.filename);
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
    close(file.fd);
  } else { // populate Linked List
    gatherLines(&file);
  }
  close(file.fd);

  // xvEdit>
  while (cmd != QUIT) {
    fprintf(2, "xvEdit> ");
    memset(buf, 0, nbuf);
    gets(buf, nbuf);
    
    unline(buf);
    substr(cmdstr, buf, 0, 4);
    toUpper(cmdstr);
    substr(args, buf, strlen(cmdstr) + 1, strlen(buf));
    fprintf(2, "args: %s\n", args);

    if      (strcmp(cmdstr, "@END") == 0) {cmd = END;}
    else if (strcmp(cmdstr, "ADD<") == 0) {cmd = ADD;}
    else if (strcmp(cmdstr, "DROP") == 0) {cmd = DROP;}
    else if (strcmp(cmdstr, "EDIT") == 0) {cmd = EDIT;}
    else if (strcmp(cmdstr, "LIST") == 0) {cmd = LIST;}
    else if (strcmp(cmdstr, "SHOW") == 0) {cmd = SHOW;}
    else if (strcmp(cmdstr, "QUIT") == 0) {cmd = QUIT;}
    else {cmd = BI;}
    switch (cmd) {
    case END: 
      end(&file, args);
      break;
    case ADD: 
      add(&file, args);
      break;
    case DROP:
      drop(&file, args);
      break;
    case EDIT:
      edit(&file, args);
      break;
    case LIST:
      list(file, args);
      break;
    case SHOW:
      show(file, args);
      break;
    case QUIT:
      break;
    case BI:
      bi();
      break;
    default:
      break;
    }
  }
  close(file.fd);
  // destroyLinkedList(file.lines); // FIXME
  exit();
  return 0;
}

// commands
void end(struct File* file, char* args) {
}

void add(struct File* file, char* args) {
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
    fprintf(2, "error: bad input range\n");
    return;
  }
  int numl = numLines(start, end);
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
  else fprintf(2, "Drop %d lines [%d:%d] (y/n)? ", numl, start, end);
  if (confirmation() != 0) return;

  // drop lines
  fprintf(2, "dropping...\n");
  struct Node* curNode = (lineAt(file->lines, start))->prev;
  struct Node* stopNode = lineAt(file->lines, end);
  while (curNode != stopNode) {
    curNode = curNode->next;
    destroyNode(curNode);
    file->len--;
  }
  fprintf(2, "file->len = %d\n", file->len);
  return;
}

void edit(struct File* file, char* args) {
}

void list(struct File file, char* args) {
  if (strlen(args) < 1) {
    fprintf(2, "you need to give a range to list\n");
    return;
  }

  int start, end;
  if (collectRange(args, &start, &end) == 1) {
    fprintf(2, "error: start index is larger than end index\n");
    return;
  }
  
  struct Node* curNode = (lineAt(file.lines, start))->prev;
  struct Node* stopNode = lineAt(file.lines, end);
  while (curNode != stopNode) {
    curNode = curNode->next;
    if (curNode == file.lines->tail) {
      fprintf(2, "________________________________\n");
      fprintf(2, "make sure start is less than end\n");
      fprintf(2, "printed till EOF\n");
      return;
    }
    fprintf(2, "%s\n", curNode->data);
  }
}

void show(struct File file, char* args) {
  struct Node* curr = file.lines->head->next;
  int lineNum = 1;
  while (curr != file.lines->tail) {
    printl(lineNum, curr->data);
    curr = curr->next;
    lineNum++;
  }
}

void quit(struct File file, char* args) {
  return;
}

void bi() {
  fprintf(2, "bad bi input\n");
}


// helper f(x)s
void gatherLines(File* file) {
  char line[MAXLINESIZE];
  while (getLine(file->fd, line)) {
    append(file->lines, line);
    file->len++;
  }
  fprintf(2, "%d lines read from %s\n", file->len, file->filename);
}

// grabs a single line from fileptr
int getLine(int fileptr, char line[]) {
  int len = strlen(line);
  memset(line, 0, len);
  char c[1];
  int i;
  for (i = 0; i < MAXLINESIZE - 1; i++) {
    if (read(fileptr, c, 1) == 0) return strlen(line);
    if (*c == '\n') break;
    line[i] = *c;
  }
  line[i + 1] = '\0';
  return 1;
}

void getArg(char* dest, char* args, char delimiter) {
  int end = find(args, delimiter);
  substr(dest, args, 0, end);
  substr(args, args, end + 1, (int) strlen(args));
}

// 0 = yes, 1 = no
int confirmation() {
  // get response
  char buf[MAXLINESIZE];
  int nbuf = sizeof(buf);
  memset(buf, 0, nbuf);
  gets(buf, nbuf);
  // determine output
  switch (buf[0]) {
  case 'Y':
  case 'y':
    return 0;
  default:
    return 1;
  }
}

int find(char* str, char c) {
  for (int i = 0; i < strlen(str); i++)
    if (str[i] == c) return i;
  return -1;
}

void substr(char* dest, char* str, int start, int end) {
  int len = strlen(str);
  if (end > len) end = len;
  int s = 0, i = start;
  while (i < end)
    dest[s++] = str[i++];
  dest[s] = '\0';
}

int collectRange(char* args, int* startptr, int* endptr) {
  // single number
  if (find(args, ':') == -1) {
    if (args[0] == '-') {
      substr(args, args, 1, strlen(args));
      *startptr = 0 - atoi(args);
    } else
      *startptr = atoi(args);
    *endptr = *startptr;
    return 0;
  }

  int negStartFlag = 0, negEndFlag = 0;
  char startstr[10];
  getArg(startstr, args, ':');
  char* endstr = args;

  // handling negative indices
  if (startstr[0] == '-') {
    substr(startstr, startstr, 1, strlen(startstr));
    negStartFlag = 1;
  }
  if (endstr[0] == '-') {
    substr(endstr, endstr, 1, strlen(endstr));
    negEndFlag = 1;
  }

  // handling empty indices
  if (strcmp(startstr, "\0") == 0) *startptr = 1;
  else *startptr = atoi(startstr);
  if (strcmp(endstr, "\0") == 0) *endptr = -1;
  else *endptr = atoi(endstr);

  if (negStartFlag) *startptr = 0 - *startptr;
  if (negEndFlag) *endptr = 0 - *endptr;
  if (((*startptr > 0 && *endptr > 0) || 
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
    return 1;

  // if (*startptr == 0) *startptr = 1;
  // if (*endptr == 0) *endptr = 1;
  return 0;
}

int normalizeRange(File file, int* sp, int* ep) {
  int l = file.len;
  if (*ep > l) *ep = l;
  else if (*ep < 1) *ep += l + 1;
  if (*ep < 1) *ep = 1;

  if (*sp > l) *sp = l;
  else if (*sp < 1) *sp += l + 1;
  if (*sp < 1) *sp = 1;
  if ((*ep - *sp) < 0)
    return 1;
  return 0;
}

int numLines(int start, int end) {
  return (end - start) + 1;
}

void toUpper(char* str) {
  int i = 0;
  while (str[i] != '\0') {
    char c = str[i];
    if (c <= 'z' && c >= 'a')
      str[i] += ('Z' - 'z');
    i++;  
  }
}

void toLower(char* str) {
  int i = 0;
  while (str[i] != '\0') {
    char c = str[i];
    if (c <= 'Z' && c >= 'A')
      str[i] -= ('Z' - 'z');
    i++;  
  }
}

void unline(char* str) {
  int len = strlen(str) - 1;
  for (; len > 0; len--) {
    char c = str[len];
    if (c == '\n')
      break;
  }
  str[len] = '\0';
}

// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
  return nodeAt(list, pos-1);
}

void printl(int lineNum, char* line) {
  if (lineNum < 10)
    fprintf(2, "%d  | %s\n", lineNum, line);
  else if (lineNum < 100)
    fprintf(2, "%d | %s\n", lineNum, line);
  else
    fprintf(2, "%d| %s\n", lineNum, line);
}