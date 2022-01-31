#include "kernel/types.h"
#include "user/user.h"

// Node
typedef struct Node {
  struct Node* prev;
  char* data;
  struct Node* next;
} Node;

// Linked List
typedef struct LinkedList {
  struct Node* head;
  struct Node* tail;
  int len;
} LinkedList;
