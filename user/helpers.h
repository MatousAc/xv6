// returns 0 when there's nothing more to read
int getLine(int fileptr, char line[]);
char consGetChar();

int find(char* str, char c); // index of c in str
// copies over substring
void substr(char* dest, char* str, int start, int end);
char* safestrcpy(char *s, const char *t, int n);

// turns a character into digit (0-9)
int ctoi(char c);
// like atoi but handles negatives too
int negatoi(char* str);
// 0 if not digit, 1 if digit (0-9)
int isDigit(char c);
// int to string
char* itoa(int value, char* result, int base);
void toUpper(char* str);
void toLower(char* str);