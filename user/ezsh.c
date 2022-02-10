#include "kernel/types.h"
#include "user/user.h"
#include "kernel/fcntl.h"
#define MAXLINE 256
#define MAXARGS 10
#define ARGLEN 20

// prototypes
int getLine(int in, char line[], int max);
int split(char** dest, char line[], char delim[]);
void substr(char* dest, char* str, int start, int end);
int find(char* str, char delim[], int nth);

int main(int argc, char *args[]){
    if (argc > 1) {
			fprintf(2, "ezsh takes no arguments\n");
    	exit();
		}
    
		int len;
		char line[MAXLINE];
		char** input;
		fprintf(2, "EZ$ ");
		while ((len = getLine(1, line, MAXLINE)) > 0) {
			argc = split(input, line, " ");
			for (int argn = 0; argn < argc; argn++) {
				fprintf(2, "%s\t\t", input[argn]);
			}
			int pid = fork();
			if (pid < 0) fprintf(2, "fork failed\n");
			else if (pid == 0) { // child
				exec(input[0], input);
				fprintf(2, "if you see this, you are not doing things right\n");
			} else {
				int pid_wait = wait();
				fprintf(2, "%d just finished running\n", pid_wait);
			}
			fprintf(2, "EZ$ ");
		}
		
		
		exit();
}

// gets line of input from "in", puts it in
// line and returns success signal
int getLine(int in, char line[], int max) {
  int len = strlen(line);
  memset(line, 0, len);
  char c[1];
  int i;
  for (i = 0; i < max - 1; i++) {
    if (read(in, c, 1) == 0) return strlen(line);
    if (*c == '\n') break;
    line[i] = *c;
  }
  line[i + 1] = '\0';
  return 1;
}

// word-by-word split
int split(char** dest, char line[], char delim[]) {
  int pos, prevpos = 0, count = 0;
	while ((pos = find(line, delim, count)) > 0) {
		substr(dest[count], line, prevpos, pos);
		if (strlen(dest[count]) != 0) count++;
		prevpos = pos + strlen(delim);
	}
	substr(dest[count++], line, prevpos, strlen(line));
	return count;
}

// finds nth beginning of delim in str, otherwise -1
int find(char* str, char delim[], int nth) {
	int i, j;
  for (i = 0; i < strlen(str); i++) {
    if (str[i] == delim[0]) {
			for (j = i + 1; j < (i + strlen(delim)); j++) {
				if (str[j] != delim[j - i]) goto out;
			}
			if (nth-- == 0) return i;
			out:;
		}
	}
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