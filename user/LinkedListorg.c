#include "kernel/types.h"
#include "user/user.h"

struct Node {
  Node* prev;
  char* data;
  Node* next;
  Node(char* data) : data{data} {}
}

struct LinkedList {
  Node* head;
  Node* tail;
  int len;
  LinkedList()
  : head{new Node(nullptr)},
  tail{new Node(nullptr)},
  len {0} {
    head->prev = nullptr;
    head->next = tail;
    tail->prev = head;
    tail->next = nullptr;
  }

  Node* nodeAt(int pos) {
    if (pos > (len / 2)) {
      int cur = len;
      Node* curNode = tail;
      while (cur != pos) {
        curNode = curNode->prev;
        cur--;
      }
    }
    else {
      int cur = 0;
      Node* curNode = head->next;
      while (cur != pos) {
        curNode = curNode->next;
        cur++;
      }
    }
    return curNode;
  }

  void insert(char* data, int pos) {
    Node* atPos = nodeAt(pos);
    Node* new = new Node(data);
    new->prev = atPos->prev;
    new->next = atPos;
    atPos->prev->next = new;
    atPos->prev = new;
    len++;
  }

  void prepend(char* data) { insert(data, 0); }
  void append(char* data) { insert(data, len); }
}
