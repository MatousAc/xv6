#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "user/user.h"
#include "helpers.c"
#include "LinkedList.c"
#include "textEditHelpers.c"

enum { END, ADD, DROP, EDIT, LIST, SHOW, QUIT, BI };

void end(struct File* file, char* args);
void add(struct File* file, char* args);
void drop(struct File* file, char* args);
void edit(struct File* file, char* args);
void list(struct File file, char* args);
void show(struct File file, char* args);
void quit(struct File* file);
void bi();

int main(int argc, char* argv[]) {
  // arg czeching
  if (argc < 2) {
    fprintf(2, "specify a file you want to edit\n");
    exit();
  } else if (argc > 2) {
    fprintf(2, "only specify one file\n");
    exit();
  }
  // prep
  static char buf[MAXLINESIZE] = "";
  char cmdstr[MAXLINESIZE] = "";
  char args[MAXLINESIZE] = "";
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
  file.edited = 0;
  file.curLine = 0;
  file.filename = argv[1];
  file.lines = MakeLinkedList();
  fprintf(2, "Welcome to xvEdit!\n");

  // opening file
  file.fd = open(file.filename, O_RDONLY);
  if (file.fd == -1) {
    fprintf(2, "creating %s...\n",  file.filename);
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
    close(file.fd);
  } else { 
    // populate Linked List
    gatherLines(&file);
    fprintf(2, "%d lines read from %s\n", file.len, file.filename);
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
      quit(&file);
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

// commands
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

void bi() {
  fprintf(2, "bad input\n");
}
