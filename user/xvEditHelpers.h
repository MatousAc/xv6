#define MAXFILESIZE 71680
#define MAXLINESIZE 1000

typedef struct File {
  char* filename;
  int fd;
  struct LinkedList* lines;
  int len;
  int edited;
} File;

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
// returns 0 when there's nothing more to read
int getLine(int fileptr, char line[]);
// pareses some argumesnts out for me
void getArg(char* dest, char* args, char delimiter);
void unline(char* str); // removes trailng newline

int find(char* str, char c); // index of c in str
// copies over substring
void substr(char* dest, char* str, int start, int end);

// like atoi but handles negatives too
int negatoi(char* str);
void toUpper(char* str);
void toLower(char* str);

// returns node holing line @ position pos
Node* lineAt(struct LinkedList* list, int pos);
// helps me print for LIST and SHOW
void printl(int lineNum, char* line);