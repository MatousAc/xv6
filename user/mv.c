// I copied cp.c and modified it to do mv
#include "kernel/types.h"
#include "user/user.h"
#include "kernel/fcntl.h"
#include "kernel/stat.h" // for the unlink f(x)
int main(int argc, char *argv[]){
    char buffer[512];
    // param czech
    if(argc > 3 || argc < 3){
        fprintf(2, "incorrect number of arguments");
        exit();
    }
    //check if source and destination can open
    int src = open(argv[1], O_RDONLY);
    int dest = open(argv[2], O_CREATE|O_RDWR);
    if(src < 0){
        fprintf(2, "Cannot open file for moving: %s \n", argv[1]);
        exit();
    }
    if (dest < 0){
        fprintf(2, "Cannot place file in destination: %s \n ", argv[2]);
        exit();
    }
    // first we copy the file to the new destination
    int i;
    while((i = read(src, buffer, sizeof(buffer))) > 0){
        write(dest, buffer, i);
    }
    close(src);
    close(dest);
    // then we remove the original
    if (unlink(argv[1]) < 0)
      printf("Unable to move the file. Copy made instead.");
    exit();
}