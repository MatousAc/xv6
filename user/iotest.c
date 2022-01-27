#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "user/user.h"


int main(void) {
  printf("This should go to the screen.\n");
  int fd;
  fd = open("README", O_RDONLY);
  printf("The fd I got for README = %d\n", fd);
  close(fd);
  close(1);
  fd = open("output.txt", O_CREATE | O_WRONLY);
  printf("Hello There! This is the IO Test!\n");
  printf("The fd I got for output.txt = %d\n", fd);
  exit();
  return 0;
}