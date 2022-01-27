#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "user/user.h"
#define MAXFILESIZE 71680;

enum { END, ADD, DROP, EDIT, LIST, QUIT, BI };
struct File {
  char* filename;
  int fd;
};


void end(struct File file, char* args);
void add(struct File file, char* args);
void drop(struct File file, char* args);
void edit(struct File file, char* args);
void list(struct File file, char* args);
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
    return 0;
  } else if (argc > 2) {
    fprintf(2, "only specify one file");
    return 0;
  }
  static char buf[100] = "";
  char cmdstr[100] = "";
  char args[100] = "";
  int nbuf = sizeof(buf);
  int cmd = END;
  // object we will pass around
  struct File file;
  file.filename = argv[1];
  fprintf(2, "Welcome to xvEdit!\n");
  // fprintf(2, "You get to edit %s\n", file.filename);

  // printf("This should go to the screen.\n");
  file.fd = open(file.filename, O_CREATE | O_WRONLY);

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
  exit();
  return 0;
}


void end(struct File file, char* args) {
  
  write(file.fd, args, strlen(args));
}

void add(struct File file, char* args) {
  write(file.fd, args, strlen(args));
}

void drop(struct File file, char* args) {
  write(file.fd, args, strlen(args));
}

void edit(struct File file, char* args) {
  write(file.fd, args, strlen(args));
}

void list(struct File file, char* args) {
  write(file.fd, args, strlen(args));
}

void quit(struct File file, char* args) {
  write(file.fd, args, strlen(args));
}

void bi() {
  fprintf(2, "bad bi input\n");
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