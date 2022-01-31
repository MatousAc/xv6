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
} File;

int getLine(int fileptr, char line[]);
void getArg(char* dest, char* args, char delimiter);
int find(char* str, char c);
Node* lineAt(struct LinkedList* list, int pos);
void gatherLines(File file);
void end(struct File file, char* args);
void add(struct File file, char* args);
void drop(struct File file, char* args);
void edit(struct File file, char* args);
void list(struct File file, char* args);
void show(struct File file, char* args);
void quit(struct File file, char* args);
void bi();
void substr(char* dest, char* str, int start, int end);
void toUpper(char* str);
void toLower(char* str);
void unline(char* str);

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
  // file/stats object we will pass around
  struct stat {
    short type;
    int dev;
    uint ino;
    short nlink;
    uint size;
  };
  struct File file;
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
    gatherLines(file);
  }
  close(file.fd);

  while (cmd != QUIT) {
    fprintf(2, "xvEdit> ");
    memset(buf, 0, nbuf);
    gets(buf, nbuf);
    
    unline(buf);
    substr(cmdstr, buf, 0, 4);
    toUpper(cmdstr);
    fprintf(2, "cmdstr: %s\n", cmdstr);
    fprintf(2, "strlen(cmdstr): %d\n", strlen(cmdstr));
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
      end(file, args);
      break;
    case ADD: 
      add(file, args);
      break;
    case DROP:
      drop(file, args);
      break;
    case EDIT:
      edit(file, args);
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
  destroyLinkedList(file.lines);
  exit();
  return 0;
}

void end(struct File file, char* args) {
}

void add(struct File file, char* args) {
}

void drop(struct File file, char* args) {
}

void edit(struct File file, char* args) {
}

void list(struct File file, char* args) {
  if (strlen(args) < 1) {
    fprintf(2, "you need to give a range to list");
  }
  char* start = "";
  getArg(start, args, ' ');
  fprintf(2, "start: %s\nargs: %s\n", start, args);
}

void show(struct File file, char* args) {
  struct Node* curr = file.lines->head->next;
  int lineNum = 1;
  while (curr != file.lines->tail) {
    fprintf(2, "%s\n", curr->data);
    curr = curr->next;
    lineNum++;
  }
}

void quit(struct File file, char* args) {
}

void bi() {
  fprintf(2, "bad bi input\n");
}


void gatherLines(File file) {
  char line[MAXLINESIZE];
  int lines = 0;
  while (getLine(file.fd, line)) {
    append(file.lines, line);
    lines++;
  }
  fprintf(2, "%d lines read from %s\n", lines, file.filename);
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
  // substr(args, args, end, (int) strlen(args));
}

int find(char* str, char c) {
  char* pos = strchr(str, c);
  if (*pos == 0) return -1;
  return pos - str;
}

void substr(char* dest, char* str, int start, int end) {
  int len = strlen(str);
  if (end > len) end = len;
  int s = 0;
  for (int i = start; i < end; i++)
    dest[s++] = str[i];
  dest[s] = '\0';
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
  return nodeAt(list, pos);
}
