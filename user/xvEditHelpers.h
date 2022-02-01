#define MAXFILESIZE 71680
#define MAXLINESIZE 1000

typedef struct File {
  char* filename;
  int fd;
  struct LinkedList* lines;
  int len;
} File;

void substr(char* dest, char* str, int start, int end);
int collectRange(char* args, int* startptr, int* endptr);
int numLines(int start, int end);
int normalizeRange(File file, int* startptr, int* endptr);
int getLine(int fileptr, char line[]);
void getArg(char* dest, char* args, char delimiter);
int find(char* str, char c);
Node* lineAt(struct LinkedList* list, int pos);
void gatherLines(File* file);
int confirmation();
void toUpper(char* str);
void toLower(char* str);
void unline(char* str);
void printl(int lineNum, char* line);
