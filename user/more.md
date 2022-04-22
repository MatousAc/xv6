## More
***
### What I am Promising to Do
I will be adding a command-line utility called **more**.  
This is what is known as a "terminal pager." The basic Idea behind more is that you should be able to go back and forth within a file (usually a text file) by pages or by line. The pages should be based on the size of the terminal window.  
This is clearly connected to the course as it is a basic command-line utility that is built into most Operating Systems such as Linux, but it is not yet available in xv6.  

I will be focusing on implementing:  
1. paging (*space*)
2. going back one page (*b*)
3. scroll down one line (*enter*)
4. displaying line number (*=*)

### Stretch Goals
* **-s** this should condense multiple blank lines into just one  
* **xv** this opens xvEdit "at" the current line in **more** (bottom line) ("at" in xvEdit means just print that line out and wait for commands)
* going up a line **Shift+Enter/Up Arrow**
* **f** fastforward. moves two pages forward instead of one
* **h** help - shows how to use more

### Omissions
* **/** I will not be implementing searching functionality in **more**.
* I will not implement other options to the command that I have not said I would explicitly support.
* I do not plan to support viewing two files with one command.

### Tools
WSL and it's implementation of more  
Linux Hunt:  
https://linuxhint.com/linux-more-command-with-examples/  
Linux Manual/man command:  
https://man7.org/linux/man-pages/man1/more.1.html  
Geeks for Geeks:  
https://www.geeksforgeeks.org/more-command-in-linux-with-examples/  


### Adding a SysCall
You have to edit,
* user.h
* syscall.c
* sysfile.c
* file.c
* fs.c
* file.h
* console.c

