#define MAXFILESIZE 71680
#define MAXLINESIZE 1000

typedef struct File {
  char* filename;
  int fd;
  int curLine;
  struct LinkedList* lines;
  int len;
  int edited;
} File;

typedef struct {
  int width;
  int height;
} Terminal;

typedef enum {
  LEFT,
  CENTER,
  RIGHT
} Alignment;

// user confirm. 0 = yes, 1 = no
int confirmation();

// gets a range from the args
int collectRange(char* args, int* startptr, int* endptr);
// makes range positive and checks it's validity
int normalizeRange(File file, int* startptr, int* endptr);
// returns the number of lines in a range
int numLines(int start, int end);

// populates LinkedList with lines from the file
void gatherLines(File* file);
// grabs a single line from fileptr

// pareses some argumesnts out for me
void getArg(char* dest, char* args, char delimiter);
void unline(char* str); // removes trailng newline
// splits the file's lines up it they exceed terminal wicth
// returns array mapping current line numbers to old line numbers
// int* gatherLineSized(struct File* file, Terminal terminal);
void gatherLinesSized(struct File* file, Terminal terminal);

// returns node holing line @ position pos
Node* lineAt(struct LinkedList* list, int pos);
// helps me print for LIST and SHOW
void printl(int lineNum, char* line);