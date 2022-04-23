// line-oriented text helpers
#include "textEditHelpers.h"

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

// helper f(x)s
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

// text
void gatherLines(File* file) {
  char line[MAXLINESIZE];
  while (getLine(file->fd, line)) {
    append(file->lines, line);
    file->len++;
  }
}

void getArg(char* dest, char* args, char delimiter) {
  int end = find(args, delimiter);
  substr(dest, args, 0, end);
  substr(args, args, end + 1, (int) strlen(args));
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

// int* gatherLineSized(struct File* file, Terminal terminal) {
void gatherLinesSized(struct File* file, Terminal terminal) {
  // int* lineMap = malloc((MAXFILESIZE/terminal.width) * sizeof(int));
  int numSplits = 0;
  char line[MAXLINESIZE];
  while (getLine(file->fd, line)) {
    int cols = 0;
    for (; strlen(line + cols) > terminal.width; cols += terminal.width) {
      char piece[terminal.width + 1]; // make room for null terminator
      safestrcpy(piece, line + cols, terminal.width + 1); 
      append(file->lines, piece);
      file->len++;
      numSplits++;
    }
    append(file->lines, line + cols);
    file->len++;
  }
  // return ;
}

// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
  return nodeAt(list, pos-1);
}

void printl(int lineNum, char* line) {
  if (lineNum < 10)
    fprintf(2, "%d  : %s\n", lineNum, line);
  else if (lineNum < 100)
    fprintf(2, "%d : %s\n", lineNum, line);
  else
    fprintf(2, "%d: %s\n", lineNum, line);
}

// prints the string with padding of a certain character
void printpad(int pad, char padChar, char* str, int alignment, int endLine) {
  int len = strlen(str);
  int i = pad - len;
  if (alignment == LEFT) {
    printf("%s", str);
    for (; i > 0; i--)
      printf("%c", padChar);
  } else if (alignment == RIGHT) {
    for (; i > 0; i--)
      printf("%c", padChar);
    printf("%s", str);
  } else if (alignment == CENTER) {
    int half = i / 2;
    for (; i > 0; i--) {
      printf("%c", padChar);
      if (i == half)
        printf("%s", str);
    }
  }
  if (endLine) {
    printf("\n");
  }
}