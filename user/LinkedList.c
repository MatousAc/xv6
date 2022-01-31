#include "LinkedList.h"
#define nullptr 0

void mystrcpy(char* dest, char* src) {
  while(*src != '\0')
    *(dest++) = *(src++);
  *dest = '\0';
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

Node* nullNode(char* data) {
  struct Node* node = malloc(sizeof(Node));
  node->prev = nullptr;
  // char* newData = (char*)malloc(sizeof(char) * 1000);
  // mystrcpy(newData, data);
  node->data = data;// newData;
  // strcpy(node->data, data);
  node->next = nullptr;
  return node;
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

Node* nodeAt(struct LinkedList* list, int pos) {
  struct Node* curNode;
  if (pos > (list->len / 2)) {
    int cur = list->len;
    curNode = list->tail;
    while (cur != pos) {
      curNode = curNode->prev;
      cur--;
    }
  }
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

void insert(struct LinkedList* list, char* data, int pos) {
  struct Node* atPos = nodeAt(list, pos);
  // if (atPos == list->head) printf("it's head\n");
  // if (atPos == list->tail) printf("it's tail\n");
  
  char* newData = (char*)malloc(sizeof(char) * 1000);
  newData = safestrcpy(newData, data, (sizeof(char) * 1000));
  struct Node* new = malloc(sizeof(Node));
  new->data = newData;

  // struct Node* new = MakeNode(data);
  // printf("atPos: %s\n", atPos->data);
  // printf("new: %s\n", new->data);
  new->prev = atPos->prev;
  new->next = atPos;
  new->prev->next = new;
  atPos->prev = new;
  list->len++;
  // printf("atPos: %s\n", atPos->data);
  // printf("new: %s\n", new->data);
  // printf("head->next: %s\n", list->head->next->data);
  // printf("tail->prev: %s\n\n\n", list->tail->prev->data);
}

void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }

void destroyLinkedList(struct LinkedList* list) {
  struct Node* destroyer = list->head;
  struct Node* traveler = destroyer->next;
  while (destroyer != list->tail) {
    destroyer = traveler;
    traveler = traveler->next;
    free(destroyer);
  }
  free(list->head);
  free(list->tail);
  free(list);
}