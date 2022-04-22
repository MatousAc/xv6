// returns 0 when there's nothing more to read
int getLine(int fileptr, char line[]);

int find(char* str, char c); // index of c in str
// copies over substring
void substr(char* dest, char* str, int start, int end);
char* safestrcpy(char *s, const char *t, int n);

// like atoi but handles negatives too
int negatoi(char* str);
// int to string
char* itoa(int value, char* result, int base);
void toUpper(char* str);
void toLower(char* str);