// general helpers
#include "helpers.h"
#define MAXFILESIZE 71680
#define MAXLINESIZE 1000

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

char consGetChar() {return (char) steal(0);}

// str ops
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

char* 
safestrcpy(char *s, const char *t, int n) 
{
  char *os;

  os = s;
  if(n <= 0)
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    ;
  *s = 0;
  return os;
}

// standard str helps
int isDigit(char c) {
  if (c >= '0' && c <= '9') return 1;
  else return 0;
}
int ctoi(char c) {
  return ((int) c) - 48;
}
int negatoi(char* str) {
  if (str[0] == '-') {
    substr(str, str, 1, strlen(str));
    return 0 - atoi(str);
  }
  return atoi(str);
}

/**
 * C++ version 0.4 char* style "itoa":
 * Written by Lukás Chmela
 * Released under GPLv3.
 */
char* itoa(int value, char* result, int base) {
    // check that the base if valid
    if (base < 2 || base > 36) { *result = '\0'; return result; }

    char* ptr = result, *ptr1 = result, tmp_char;
    int tmp_value;

    do {
        tmp_value = value;
        value /= base;
        *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" [35 + (tmp_value - value * base)];
    } while ( value );

    // Apply negative sign
    if (tmp_value < 0) *ptr++ = '-';
    *ptr-- = '\0';
    while(ptr1 < ptr) {
        tmp_char = *ptr;
        *ptr--= *ptr1;
        *ptr1++ = tmp_char;
    }
    return result;
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
