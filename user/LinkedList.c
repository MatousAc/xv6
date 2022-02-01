#include "LinkedList.h"
#define nullptr 0

char* safestrcpy(char *s, const char *t, int n) {
  char *os;

  os = s;
  if(n <= 0)
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    ;
  *s = 0;
  return os;
}

Node* nullNode(char* data) {
  struct Node* node = malloc(sizeof(Node));
  node->prev = nullptr;
  node->data = data;
  node->next = nullptr;
  return node;
}

Node* nodeAt(struct LinkedList* list, int pos) {
  // for anything past the end:
  if (pos > list->len)
    return list->tail->prev;
  // for anything before the beginning:
  if ((pos < 0) && ((0 - pos) > list->len))
    return list->head->next;
  
  struct Node* curNode;
  // negative indices
  if (pos < 0) {
    curNode = list->tail;
    while (++pos != 0)
      curNode = curNode->prev;
  } // start looking from front
  else {
    int cur = 0;
    curNode = list->head->next;
    while (cur != pos) {
      curNode = curNode->next;
      cur++;
    }
  }
  return curNode;
}

void destroyNode(struct LinkedList* list, struct Node* self) {
    self->prev->next = self->next;
    self->next->prev = self->prev;

    free(self->data);
    free(self);
    list->len--;
}

LinkedList* MakeLinkedList() {
  struct LinkedList* list = malloc(sizeof(LinkedList));
  Node* head = nullNode(nullptr);
  Node* tail = nullNode(nullptr);
  head->prev = nullptr;
  head->next = tail;
  tail->prev = head;
  tail->next = nullptr;

  list->len = 0;
  list->head = head;
  list->tail = tail;
  return list;
}

void insert(struct LinkedList* list, char* data, int pos) {
  struct Node* atPos = nodeAt(list, pos);
  char* newData = (char*)malloc(sizeof(char) * 1000);
  newData = safestrcpy(newData, data, (sizeof(char) * 1000));
  struct Node* new = malloc(sizeof(Node));

  new->data = newData;
  new->prev = atPos->prev;
  new->next = atPos;
  new->prev->next = new;
  atPos->prev = new;
  list->len++;
}

void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }

void destroyLinkedList(struct LinkedList* list) {
  struct Node* curNode = list->head;
  while (curNode != list->tail) {
    curNode = curNode->next;
    free(curNode->prev->data);
    free(curNode->prev);
  }
  free(curNode);
  free(list);
}