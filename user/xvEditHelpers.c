#include "xvEditHelpers.h"
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

int negatoi(char* str) {
  if (str[0] == '-') {
    substr(str, str, 1, strlen(str));
    return 0 - atoi(str);
  }
  return atoi(str);
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