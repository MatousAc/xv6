#include "kernel/types.h"
#include "user/user.h"
#define MAXLINE 256
#define MAXHISTORY 1000
#define MAXARGS 10
#define ARGLEN 20

// prototypes
int launch(char** args, int background);
int cd(char** args);
int help(char** args);
int myExit(char** args);
int getLine(int in, char line[], int max);
char** split(char line[], char delim[], int* count);
char* substr(char* str, int start, int end);
int find(char* str, char delim[], int nth);
void prompt(int cmdNum);
int freeChptr(char** ptr, int len);

int main(int argc, char *argv[]){
    if (argc > 1) {
			fprintf(2, "ezsh takes no arguments\n");
    	exit();
		}
    // setup
		int len, cmdNum = 0;
		char cmd[MAXLINE];
		char** history = malloc(MAXHISTORY * sizeof(char*));
		prompt(cmdNum);
		// repl
		while ((len = getLine(1, cmd, MAXLINE)) > 0) {
			// visiting cmd history
			if (cmd != 0 && cmd[0] == '#')
				strcpy(cmd, history[atoi(cmd + 1)]);
			
			int background = 0; // indicates when to run in background
			if (cmd[strlen(cmd) - 1] == '&') {
				background = 1;
			}
			
			// parsing args
			char** args = split(cmd, " ", &argc);
			if (background == 1)
				free(args[--argc]);

			// running
			if (launch(args, background) != 0) fprintf(2, "error\n");
			// get ready for next command
			char* cmdCpy = malloc(strlen(cmd) * sizeof(char));
			strcpy(cmdCpy, cmd);
			memset(cmd, 0, strlen(cmd));
			history[cmdNum++] = cmdCpy;
			freeChptr(args, argc);
			prompt(cmdNum);
		}
		freeChptr(history, cmdNum);
		exit();
}

// executes our command
int launch(char** args, int background) {
	// built-in commands
	if (strcmp(args[0], "cd") == 0) return cd(args);
	else if (strcmp(args[0], "help") == 0) return help(args);
	else if (strcmp(args[0], "exit") == 0) return myExit(args);
	else if (strcmp(args[0], "quit") == 0) return myExit(args);

	// exec other command
	int pid = fork();
	if (pid < 0) fprintf(2, "fork failed\n");
	else if (pid == 0) { // child
		if (background) {
			close(0);
			close(1);
			close(2);
		}
		exec(args[0], args);
		fprintf(2, "exec failed, command not recognized\n");
		exit();
	} else {
		if (!background) wait();
	}
	return 0;
}

// this is to change directories. chdir changes the 
// dir of the current process. thus, we have to have
// a built-in command for this because if we used
// 'exec' we could only change the directory that 
// the child process is in, and not actually change 
// the directory that EZ Shell is running in
int cd(char** args) {
	if (chdir(args[1]) < 0) {
		fprintf(2, "could not change directory/");
		return 1;
	}
	return 0;
}

int help(char** args) {
	fprintf(2, "Welcome to the EZ Shell!\n");
	fprintf(2, "Type in a command and it's parameters.\n");
	fprintf(2, "We have 'cd' and 'exit' built in.\n");
	fprintf(2, "Other commands that are available in the regular shell should be available here.\n");
	return 0;
}

int myExit(char** args) {
	exit();
	return 1;
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

// word-by-word split on delimiter
char** split(char line[], char delim[], int* count) {
	char** dst = malloc(MAXARGS * sizeof(char*));
  int pos, prevpos = 0, index = 0;
	while ((pos = find(line, delim, index)) > 0) {
		char* arg = substr(line, prevpos, pos);
		if (strlen(arg) != 0) {
			dst[index] = arg;
			index++;
		}
		prevpos = pos + strlen(delim);
	}
	*(dst + index) = substr(line, prevpos, strlen(line));
	*count = ++index;
	return dst;
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

// returns a copy of str from start to end
char* substr(char* str, int start, int end) {
	char* dst = malloc(ARGLEN * sizeof(char));
  memset(dst, 0, ARGLEN * sizeof(char));
  int len = strlen(str);
  if (end > len) end = len;
  int s = 0, i = start;
  while (i < end)
    dst[s++] = str[i++];
  dst[s] = '\0';
	return dst;
}

int freeChptr(char** ptr, int len) {
	for (int i = 0; i < len; i++)
		free(ptr[i]);
	free(ptr);
	return 0;
}

void prompt(int cmdNum) {
  if (cmdNum < 10)
    fprintf(2, "%d   EZ$ ", cmdNum);
  else if (cmdNum < 100)
    fprintf(2, "%d  EZ$ ", cmdNum);
  else
    fprintf(2, "%d EZ$ ", cmdNum);
}
