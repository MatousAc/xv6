// all this does is print
#include "kernel/types.h"
#include "user/user.h"

int main(int argc, char *argv[]){
    if(argc == 1){
        printf("Hey, this assignment is due on January 19. If that's today and you don't have it done, finish it!\nRemember that no one gets anywhere without putting forth the effort.\n");
    } else if(argc > 2){
        printf("Too many arguments!\n");
    } else {
        printf("Hey look, I know school is a lot, whether you're a student with too much to do in the time you'll be in college or whether you are one who doesn't know if they can financially make it. Take a breather and stop trying to get straight As or believing you aren't good enough. If you have been trying to be perfect in one way or another, make today, the day to put down your backpack.\n"); // highly modified quote from Anna Quindlen
    }
    exit();
}