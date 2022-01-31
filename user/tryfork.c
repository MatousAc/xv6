#include "../kernel/types.h"
#include "user.h"

int main(int argc, const char* argv[]) {
  printf("My pid is %d\n", getpid());
  int child_pid = fork();
  if (child_pid < 0) {
    printf("fork failed\n");
  } else if (child_pid == 0) {
    printf("this is child. pid: %d\n", getpid());
  } else {
    wait();
    printf("this is parent. pid: %d", getpid());
  }
  exit();
  return 0;
}