//  Names: Ac Hybl, Alexander O'Connor
#include "kernel/types.h"
#include "user/user.h"

struct LinkedList {
  struct Node {
    string data;
    Node* next;
    Node* prev;
    Node(const string& item)
    : data{ item },
    next{ nullptr },
    prev{ nullptr }{}

  Node* head;
  Node* tail;

  int len;
  LinkedList();
  LinkedList(const LinkedList& other);
  ~LinkedList();

  // Returns an iterator to the first element in the list
  Iterator begin() const;

  // Returns an iterator to the position just past the end of the list
  Iterator end() const;

  void insert(const Iterator& iter, const string& item);

  // Removes the element at the position indicated by the iterator.
  // After the removal the iterator will point to the element after 
  // the removed element.
  void remove(Iterator& iter);

  // Returns an iterator to the first occurrence of the element
  // seek.  Returns the list's end iterator if seek is not present 
  // in the list.
  Iterator find(const string& seek) const;

  // Returns the number of elements in the linked list.
  int length() const;

  // Removes all the elements in the linked list.
  void clear();

  // Returns true if other contains the same elements,
  // in the same order; otherwise, returns false.
  bool operator==(const LinkedList& other) const;

  // Returns true if the content of the other list differs from 
  // this list (missing or extra elements, different element order, 
  // etc.; otherwise, returns false.
  bool operator!=(const LinkedList& other) const;
};

///// Linked List /////
LinkedList::LinkedList() // def. constructor
  : head{ nullptr },
  tail{ nullptr },
  len{ 0 } {
  head = new Node("*HEAD*");
  tail = new Node("*TAIL*");
  // set next and prev
  head->prev = nullptr;
  head->next = tail;
  tail->prev = head;
  tail->next = nullptr;
};

// Copy constructor makes a copy of the other object's list
LinkedList::LinkedList(const LinkedList& other)
  : head{ nullptr },
  tail{ nullptr },
  len{ 0 } {
  head = new Node("*HEAD*");
  head->prev = nullptr;

  Iterator previous{ head };
  for (string old_data : other) {
      Node* new_node = new Node(old_data);
      new_node->prev = previous.ptr;
      previous.ptr->next = new_node;
      previous++; len++;
  }

  tail = new Node("*TAIL*");
  tail->prev = previous.ptr;
  previous.ptr->next = tail;
}

// The destructor deallocates the memory held by the list
LinkedList::~LinkedList() {
  Node* to_del = head;
  while (to_del->next != nullptr) {
      to_del = to_del->next;
      delete to_del->prev;
  }
  delete tail;
}

// Assignment operator
LinkedList& LinkedList::operator=(const LinkedList& other) {
  clear();

  Iterator previous{ head };
  for (string old_data : other) {
      Node* new_node = new Node(old_data);
      new_node->prev = previous.ptr;
      previous.ptr->next = new_node;
      previous++; len++;
  }

  tail->prev = previous.ptr;
  previous.ptr->next = tail;

  return *this;
}

LinkedList::Iterator LinkedList::begin() const {
    return Iterator(head->next); // first element of list
}

// Returns an iterator to the position just past the end of the list
LinkedList::Iterator LinkedList::end() const {
    return Iterator(tail);
}

// Inserts an item into the list before
// the position indicated by the iterator.
// To append an item to the back of list lst, use
//      lst.insert(lst.end(), item);
// To prepend an item to the front of list lst, use
//      lst.insert(lst.begin(), item);
// The insertion does not change the iterator's position. 
void LinkedList::insert(const Iterator& iter, const string& item) {
    Node* to_insert = new Node(item);
    Node* insert_before = iter.ptr;
    to_insert->prev = insert_before->prev;
    to_insert->next = insert_before;
    to_insert->prev->next = to_insert;
    insert_before->prev = to_insert;
    len++; // keep track of length
}

void LinkedList::remove(Iterator& iter) { // removes node that iter points to
    Node* to_remove = iter.ptr;
    to_remove->prev->next = to_remove->next;
    to_remove->next->prev = to_remove->prev;
    delete to_remove; // deallocate memory
    len--; // keep track of length
}

// Returns an iterator to the first occurrence of the element
// seek.  Returns the list's end iterator if seek is not present 
// in the list.
LinkedList::Iterator LinkedList::find(const string& seek) const {
    Iterator current_node = this->begin();
    while ((current_node.ptr->data != seek) and (current_node.ptr->data != tail->data)) {
        ++current_node;
    }
    return current_node;
}

int LinkedList::length() const { // len getter
    return len;
}

void LinkedList::clear() { // clears nodes btwn head && tail
    LinkedList::Node* to_del = head->next;
    while (to_del != tail) {
        to_del = to_del->next;
        delete to_del->prev;
    }
    tail->prev = head;
    head->next = tail;
}

bool LinkedList::operator==(const LinkedList& other) const {
    if (len != other.len) return false;
    Iterator left = this->begin();
    Iterator right = other.begin();
    for (int i{ 0 }; i < len; i++) {
        if (left++.ptr->data != right++.ptr->data)
            return false;
    }
    return true;
}

bool LinkedList::operator!=(const LinkedList& other) const {
    return !(*this == other);
}


/*
std::ostream& operator<<(std::ostream& os, const LinkedList& rhs) { // stream insertion operator
    for (string elem : rhs) {
        os << elem;// +", ";
    }
    return os;
}
*/