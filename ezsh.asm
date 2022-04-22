
user/_ezsh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
char* substr(char* str, int start, int end);
int find(char* str, char delim[], int nth);
void prompt(int cmdNum);
int freeChptr(char** ptr, int len);

int main(int argc, char *argv[]){
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	81 ec 18 01 00 00    	sub    $0x118,%esp
    if (argc > 1) {
  17:	83 39 01             	cmpl   $0x1,(%ecx)
  1a:	7e 13                	jle    2f <main+0x2f>
			fprintf(2, "ezsh takes no arguments\n");
  1c:	51                   	push   %ecx
  1d:	51                   	push   %ecx
  1e:	68 d8 0e 00 00       	push   $0xed8
  23:	6a 02                	push   $0x2
  25:	e8 76 0c 00 00       	call   ca0 <fprintf>
    	exit();
  2a:	e8 f3 08 00 00       	call   922 <exit>
		}
    // setup
		int len, cmdNum = 0;
		char cmd[MAXLINE];
		char** history = malloc(MAXHISTORY * sizeof(char*));
  2f:	83 ec 0c             	sub    $0xc,%esp
  32:	89 ce                	mov    %ecx,%esi
		int len, cmdNum = 0;
  34:	31 ff                	xor    %edi,%edi
		char** history = malloc(MAXHISTORY * sizeof(char*));
  36:	68 a0 0f 00 00       	push   $0xfa0
  3b:	8d 9d e8 fe ff ff    	lea    -0x118(%ebp),%ebx
  41:	e8 2a 0d 00 00       	call   d70 <malloc>
	return 0;
}

void prompt(int cmdNum) {
  if (cmdNum < 10)
    fprintf(2, "%d   EZ$ ", cmdNum);
  46:	83 c4 0c             	add    $0xc,%esp
		char** history = malloc(MAXHISTORY * sizeof(char*));
  49:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)
    fprintf(2, "%d   EZ$ ", cmdNum);
  4f:	6a 00                	push   $0x0
  51:	68 bd 0e 00 00       	push   $0xebd
  56:	6a 02                	push   $0x2
  58:	e8 43 0c 00 00       	call   ca0 <fprintf>
  5d:	83 c4 10             	add    $0x10,%esp
  60:	89 b5 e4 fe ff ff    	mov    %esi,-0x11c(%ebp)
  66:	e9 99 00 00 00       	jmp    104 <main+0x104>
  6b:	90                   	nop
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			char** args = split(cmd, " ", &argc);
  70:	83 ec 04             	sub    $0x4,%esp
  73:	ff b5 e4 fe ff ff    	pushl  -0x11c(%ebp)
  79:	68 c5 0e 00 00       	push   $0xec5
  7e:	53                   	push   %ebx
  7f:	e8 dc 04 00 00       	call   560 <split>
  84:	83 c4 10             	add    $0x10,%esp
  87:	89 c6                	mov    %eax,%esi
			int background = 0; // indicates when to run in background
  89:	31 c0                	xor    %eax,%eax
			if (launch(args, background) != 0) fprintf(2, "error\n");
  8b:	83 ec 08             	sub    $0x8,%esp
  8e:	50                   	push   %eax
  8f:	56                   	push   %esi
  90:	e8 cb 01 00 00       	call   260 <launch>
  95:	83 c4 10             	add    $0x10,%esp
  98:	85 c0                	test   %eax,%eax
  9a:	0f 85 e8 00 00 00    	jne    188 <main+0x188>
			char* cmdCpy = malloc(strlen(cmd) * sizeof(char));
  a0:	83 ec 0c             	sub    $0xc,%esp
			history[cmdNum++] = cmdCpy;
  a3:	83 c7 01             	add    $0x1,%edi
			char* cmdCpy = malloc(strlen(cmd) * sizeof(char));
  a6:	53                   	push   %ebx
  a7:	e8 a4 06 00 00       	call   750 <strlen>
  ac:	89 04 24             	mov    %eax,(%esp)
  af:	e8 bc 0c 00 00       	call   d70 <malloc>
			strcpy(cmdCpy, cmd);
  b4:	59                   	pop    %ecx
			char* cmdCpy = malloc(strlen(cmd) * sizeof(char));
  b5:	89 c2                	mov    %eax,%edx
			strcpy(cmdCpy, cmd);
  b7:	58                   	pop    %eax
  b8:	53                   	push   %ebx
  b9:	52                   	push   %edx
  ba:	89 95 e0 fe ff ff    	mov    %edx,-0x120(%ebp)
  c0:	e8 0b 06 00 00       	call   6d0 <strcpy>
			memset(cmd, 0, strlen(cmd));
  c5:	89 1c 24             	mov    %ebx,(%esp)
  c8:	e8 83 06 00 00       	call   750 <strlen>
  cd:	83 c4 0c             	add    $0xc,%esp
  d0:	50                   	push   %eax
  d1:	6a 00                	push   $0x0
  d3:	53                   	push   %ebx
  d4:	e8 a7 06 00 00       	call   780 <memset>
			history[cmdNum++] = cmdCpy;
  d9:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  df:	8b 95 e0 fe ff ff    	mov    -0x120(%ebp),%edx
  e5:	89 54 b8 fc          	mov    %edx,-0x4(%eax,%edi,4)
			freeChptr(args, argc);
  e9:	58                   	pop    %eax
  ea:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  f0:	5a                   	pop    %edx
  f1:	ff 30                	pushl  (%eax)
  f3:	56                   	push   %esi
  f4:	e8 27 05 00 00       	call   620 <freeChptr>
			prompt(cmdNum);
  f9:	89 3c 24             	mov    %edi,(%esp)
  fc:	e8 6f 05 00 00       	call   670 <prompt>
 101:	83 c4 10             	add    $0x10,%esp
		while ((len = getLine(1, cmd, MAXLINE)) > 0) {
 104:	83 ec 04             	sub    $0x4,%esp
 107:	68 00 01 00 00       	push   $0x100
 10c:	53                   	push   %ebx
 10d:	6a 01                	push   $0x1
 10f:	e8 7c 02 00 00       	call   390 <getLine>
 114:	83 c4 10             	add    $0x10,%esp
 117:	85 c0                	test   %eax,%eax
 119:	0f 8e a8 00 00 00    	jle    1c7 <main+0x1c7>
			if (cmd != 0 && cmd[0] == '#')
 11f:	80 bd e8 fe ff ff 23 	cmpb   $0x23,-0x118(%ebp)
 126:	74 77                	je     19f <main+0x19f>
			if (cmd[strlen(cmd) - 1] == '&') {
 128:	83 ec 0c             	sub    $0xc,%esp
 12b:	53                   	push   %ebx
 12c:	e8 1f 06 00 00       	call   750 <strlen>
 131:	83 c4 10             	add    $0x10,%esp
 134:	80 bc 05 e7 fe ff ff 	cmpb   $0x26,-0x119(%ebp,%eax,1)
 13b:	26 
 13c:	0f 85 2e ff ff ff    	jne    70 <main+0x70>
			char** args = split(cmd, " ", &argc);
 142:	83 ec 04             	sub    $0x4,%esp
 145:	ff b5 e4 fe ff ff    	pushl  -0x11c(%ebp)
 14b:	68 c5 0e 00 00       	push   $0xec5
 150:	53                   	push   %ebx
 151:	e8 0a 04 00 00       	call   560 <split>
				free(args[--argc]);
 156:	8b 8d e4 fe ff ff    	mov    -0x11c(%ebp),%ecx
			char** args = split(cmd, " ", &argc);
 15c:	89 c6                	mov    %eax,%esi
				free(args[--argc]);
 15e:	8b 01                	mov    (%ecx),%eax
 160:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
 166:	83 e8 01             	sub    $0x1,%eax
 169:	89 01                	mov    %eax,(%ecx)
 16b:	59                   	pop    %ecx
 16c:	ff 34 86             	pushl  (%esi,%eax,4)
 16f:	e8 6c 0b 00 00       	call   ce0 <free>
 174:	83 c4 10             	add    $0x10,%esp
				background = 1;
 177:	b8 01 00 00 00       	mov    $0x1,%eax
 17c:	e9 0a ff ff ff       	jmp    8b <main+0x8b>
 181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if (launch(args, background) != 0) fprintf(2, "error\n");
 188:	83 ec 08             	sub    $0x8,%esp
 18b:	68 f1 0e 00 00       	push   $0xef1
 190:	6a 02                	push   $0x2
 192:	e8 09 0b 00 00       	call   ca0 <fprintf>
 197:	83 c4 10             	add    $0x10,%esp
 19a:	e9 01 ff ff ff       	jmp    a0 <main+0xa0>
				strcpy(cmd, history[atoi(cmd + 1)]);
 19f:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
 1a5:	83 ec 0c             	sub    $0xc,%esp
 1a8:	50                   	push   %eax
 1a9:	e8 02 07 00 00       	call   8b0 <atoi>
 1ae:	8b 8d dc fe ff ff    	mov    -0x124(%ebp),%ecx
 1b4:	5e                   	pop    %esi
 1b5:	5a                   	pop    %edx
 1b6:	ff 34 81             	pushl  (%ecx,%eax,4)
 1b9:	53                   	push   %ebx
 1ba:	e8 11 05 00 00       	call   6d0 <strcpy>
 1bf:	83 c4 10             	add    $0x10,%esp
 1c2:	e9 61 ff ff ff       	jmp    128 <main+0x128>
		freeChptr(history, cmdNum);
 1c7:	50                   	push   %eax
 1c8:	50                   	push   %eax
 1c9:	57                   	push   %edi
 1ca:	ff b5 dc fe ff ff    	pushl  -0x124(%ebp)
 1d0:	e8 4b 04 00 00       	call   620 <freeChptr>
		exit();
 1d5:	e8 48 07 00 00       	call   922 <exit>
 1da:	66 90                	xchg   %ax,%ax
 1dc:	66 90                	xchg   %ax,%ax
 1de:	66 90                	xchg   %ax,%ax

000001e0 <cd>:
int cd(char** args) {
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	83 ec 14             	sub    $0x14,%esp
	if (chdir(args[1]) < 0) {
 1e6:	8b 45 08             	mov    0x8(%ebp),%eax
 1e9:	ff 70 04             	pushl  0x4(%eax)
 1ec:	e8 a9 07 00 00       	call   99a <chdir>
 1f1:	83 c4 10             	add    $0x10,%esp
 1f4:	31 d2                	xor    %edx,%edx
 1f6:	85 c0                	test   %eax,%eax
 1f8:	78 06                	js     200 <cd+0x20>
}
 1fa:	89 d0                	mov    %edx,%eax
 1fc:	c9                   	leave  
 1fd:	c3                   	ret    
 1fe:	66 90                	xchg   %ax,%ax
		fprintf(2, "could not change directory/");
 200:	83 ec 08             	sub    $0x8,%esp
 203:	68 68 0e 00 00       	push   $0xe68
 208:	6a 02                	push   $0x2
 20a:	e8 91 0a 00 00       	call   ca0 <fprintf>
 20f:	ba 01 00 00 00       	mov    $0x1,%edx
 214:	83 c4 10             	add    $0x10,%esp
}
 217:	89 d0                	mov    %edx,%eax
 219:	c9                   	leave  
 21a:	c3                   	ret    
 21b:	90                   	nop
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000220 <help>:
int help(char** args) {
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	83 ec 10             	sub    $0x10,%esp
	fprintf(2, "Welcome to the EZ Shell!\n");
 226:	68 84 0e 00 00       	push   $0xe84
 22b:	6a 02                	push   $0x2
 22d:	e8 6e 0a 00 00       	call   ca0 <fprintf>
	fprintf(2, "Type in a command and it's parameters.\n");
 232:	58                   	pop    %eax
 233:	5a                   	pop    %edx
 234:	68 f8 0e 00 00       	push   $0xef8
 239:	6a 02                	push   $0x2
 23b:	e8 60 0a 00 00       	call   ca0 <fprintf>
	fprintf(2, "We have 'cd' and 'exit' built in.\n");
 240:	59                   	pop    %ecx
 241:	58                   	pop    %eax
 242:	68 20 0f 00 00       	push   $0xf20
 247:	6a 02                	push   $0x2
 249:	e8 52 0a 00 00       	call   ca0 <fprintf>
	fprintf(2, "Other commands that are available in the regular shell should be available here.\n");
 24e:	58                   	pop    %eax
 24f:	5a                   	pop    %edx
 250:	68 44 0f 00 00       	push   $0xf44
 255:	6a 02                	push   $0x2
 257:	e8 44 0a 00 00       	call   ca0 <fprintf>
}
 25c:	31 c0                	xor    %eax,%eax
 25e:	c9                   	leave  
 25f:	c3                   	ret    

00000260 <launch>:
int launch(char** args, int background) {
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	56                   	push   %esi
 264:	53                   	push   %ebx
 265:	8b 5d 08             	mov    0x8(%ebp),%ebx
 268:	8b 75 0c             	mov    0xc(%ebp),%esi
	if (strcmp(args[0], "cd") == 0) return cd(args);
 26b:	83 ec 08             	sub    $0x8,%esp
 26e:	68 9e 0e 00 00       	push   $0xe9e
 273:	ff 33                	pushl  (%ebx)
 275:	e8 86 04 00 00       	call   700 <strcmp>
 27a:	83 c4 10             	add    $0x10,%esp
 27d:	85 c0                	test   %eax,%eax
 27f:	74 6f                	je     2f0 <launch+0x90>
	else if (strcmp(args[0], "help") == 0) return help(args);
 281:	83 ec 08             	sub    $0x8,%esp
 284:	68 a1 0e 00 00       	push   $0xea1
 289:	ff 33                	pushl  (%ebx)
 28b:	e8 70 04 00 00       	call   700 <strcmp>
 290:	83 c4 10             	add    $0x10,%esp
 293:	85 c0                	test   %eax,%eax
 295:	74 49                	je     2e0 <launch+0x80>
	else if (strcmp(args[0], "exit") == 0) return myExit(args);
 297:	83 ec 08             	sub    $0x8,%esp
 29a:	68 a6 0e 00 00       	push   $0xea6
 29f:	ff 33                	pushl  (%ebx)
 2a1:	e8 5a 04 00 00       	call   700 <strcmp>
 2a6:	83 c4 10             	add    $0x10,%esp
 2a9:	85 c0                	test   %eax,%eax
 2ab:	74 77                	je     324 <launch+0xc4>
	else if (strcmp(args[0], "quit") == 0) return myExit(args);
 2ad:	83 ec 08             	sub    $0x8,%esp
 2b0:	68 ab 0e 00 00       	push   $0xeab
 2b5:	ff 33                	pushl  (%ebx)
 2b7:	e8 44 04 00 00       	call   700 <strcmp>
 2bc:	83 c4 10             	add    $0x10,%esp
 2bf:	85 c0                	test   %eax,%eax
 2c1:	74 61                	je     324 <launch+0xc4>
	int pid = fork();
 2c3:	e8 52 06 00 00       	call   91a <fork>
	if (pid < 0) fprintf(2, "fork failed\n");
 2c8:	85 c0                	test   %eax,%eax
 2ca:	78 44                	js     310 <launch+0xb0>
	else if (pid == 0) { // child
 2cc:	74 5b                	je     329 <launch+0xc9>
		if (!background) wait();
 2ce:	85 f6                	test   %esi,%esi
 2d0:	74 2e                	je     300 <launch+0xa0>
}
 2d2:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2d5:	31 c0                	xor    %eax,%eax
 2d7:	5b                   	pop    %ebx
 2d8:	5e                   	pop    %esi
 2d9:	5d                   	pop    %ebp
 2da:	c3                   	ret    
 2db:	90                   	nop
 2dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	else if (strcmp(args[0], "help") == 0) return help(args);
 2e0:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
 2e3:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2e6:	5b                   	pop    %ebx
 2e7:	5e                   	pop    %esi
 2e8:	5d                   	pop    %ebp
	else if (strcmp(args[0], "help") == 0) return help(args);
 2e9:	e9 32 ff ff ff       	jmp    220 <help>
 2ee:	66 90                	xchg   %ax,%ax
	if (strcmp(args[0], "cd") == 0) return cd(args);
 2f0:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
 2f3:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2f6:	5b                   	pop    %ebx
 2f7:	5e                   	pop    %esi
 2f8:	5d                   	pop    %ebp
	if (strcmp(args[0], "cd") == 0) return cd(args);
 2f9:	e9 e2 fe ff ff       	jmp    1e0 <cd>
 2fe:	66 90                	xchg   %ax,%ax
		if (!background) wait();
 300:	e8 25 06 00 00       	call   92a <wait>
 305:	eb cb                	jmp    2d2 <launch+0x72>
 307:	89 f6                	mov    %esi,%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	if (pid < 0) fprintf(2, "fork failed\n");
 310:	83 ec 08             	sub    $0x8,%esp
 313:	68 b0 0e 00 00       	push   $0xeb0
 318:	6a 02                	push   $0x2
 31a:	e8 81 09 00 00       	call   ca0 <fprintf>
 31f:	83 c4 10             	add    $0x10,%esp
 322:	eb ae                	jmp    2d2 <launch+0x72>
	exit();
 324:	e8 f9 05 00 00       	call   922 <exit>
		if (background) {
 329:	85 f6                	test   %esi,%esi
 32b:	75 1d                	jne    34a <launch+0xea>
		exec(args[0], args);
 32d:	50                   	push   %eax
 32e:	50                   	push   %eax
 32f:	53                   	push   %ebx
 330:	ff 33                	pushl  (%ebx)
 332:	e8 2b 06 00 00       	call   962 <exec>
		fprintf(2, "exec failed, command not recognized\n");
 337:	5a                   	pop    %edx
 338:	59                   	pop    %ecx
 339:	68 98 0f 00 00       	push   $0xf98
 33e:	6a 02                	push   $0x2
 340:	e8 5b 09 00 00       	call   ca0 <fprintf>
		exit();
 345:	e8 d8 05 00 00       	call   922 <exit>
			close(0);
 34a:	83 ec 0c             	sub    $0xc,%esp
 34d:	6a 00                	push   $0x0
 34f:	e8 fe 05 00 00       	call   952 <close>
			close(1);
 354:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 35b:	e8 f2 05 00 00       	call   952 <close>
			close(2);
 360:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 367:	e8 e6 05 00 00       	call   952 <close>
 36c:	83 c4 10             	add    $0x10,%esp
 36f:	eb bc                	jmp    32d <launch+0xcd>
 371:	eb 0d                	jmp    380 <myExit>
 373:	90                   	nop
 374:	90                   	nop
 375:	90                   	nop
 376:	90                   	nop
 377:	90                   	nop
 378:	90                   	nop
 379:	90                   	nop
 37a:	90                   	nop
 37b:	90                   	nop
 37c:	90                   	nop
 37d:	90                   	nop
 37e:	90                   	nop
 37f:	90                   	nop

00000380 <myExit>:
int myExit(char** args) {
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	83 ec 08             	sub    $0x8,%esp
	exit();
 386:	e8 97 05 00 00       	call   922 <exit>
 38b:	90                   	nop
 38c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000390 <getLine>:
int getLine(int in, char line[], int max) {
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	53                   	push   %ebx
 396:	83 ec 38             	sub    $0x38,%esp
 399:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 39c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int len = strlen(line);
 39f:	53                   	push   %ebx
 3a0:	e8 ab 03 00 00       	call   750 <strlen>
  memset(line, 0, len);
 3a5:	83 c4 0c             	add    $0xc,%esp
 3a8:	50                   	push   %eax
 3a9:	6a 00                	push   $0x0
 3ab:	53                   	push   %ebx
 3ac:	e8 cf 03 00 00       	call   780 <memset>
  for (i = 0; i < max - 1; i++) {
 3b1:	83 c4 10             	add    $0x10,%esp
 3b4:	83 ff 01             	cmp    $0x1,%edi
 3b7:	7e 77                	jle    430 <getLine+0xa0>
 3b9:	8d 47 ff             	lea    -0x1(%edi),%eax
 3bc:	31 f6                	xor    %esi,%esi
 3be:	8d 7d e7             	lea    -0x19(%ebp),%edi
 3c1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 3c4:	eb 1d                	jmp    3e3 <getLine+0x53>
 3c6:	8d 76 00             	lea    0x0(%esi),%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if (*c == '\n') break;
 3d0:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3d4:	3c 0a                	cmp    $0xa,%al
 3d6:	74 38                	je     410 <getLine+0x80>
    line[i] = *c;
 3d8:	88 04 33             	mov    %al,(%ebx,%esi,1)
  for (i = 0; i < max - 1; i++) {
 3db:	83 c6 01             	add    $0x1,%esi
 3de:	39 75 d4             	cmp    %esi,-0x2c(%ebp)
 3e1:	74 45                	je     428 <getLine+0x98>
    if (read(in, c, 1) == 0) return strlen(line);
 3e3:	83 ec 04             	sub    $0x4,%esp
 3e6:	6a 01                	push   $0x1
 3e8:	57                   	push   %edi
 3e9:	ff 75 08             	pushl  0x8(%ebp)
 3ec:	e8 49 05 00 00       	call   93a <read>
 3f1:	83 c4 10             	add    $0x10,%esp
 3f4:	85 c0                	test   %eax,%eax
 3f6:	75 d8                	jne    3d0 <getLine+0x40>
 3f8:	83 ec 0c             	sub    $0xc,%esp
 3fb:	53                   	push   %ebx
 3fc:	e8 4f 03 00 00       	call   750 <strlen>
 401:	83 c4 10             	add    $0x10,%esp
}
 404:	8d 65 f4             	lea    -0xc(%ebp),%esp
 407:	5b                   	pop    %ebx
 408:	5e                   	pop    %esi
 409:	5f                   	pop    %edi
 40a:	5d                   	pop    %ebp
 40b:	c3                   	ret    
 40c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 410:	8d 56 01             	lea    0x1(%esi),%edx
  line[i + 1] = '\0';
 413:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
 417:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
 41a:	b8 01 00 00 00       	mov    $0x1,%eax
}
 41f:	5b                   	pop    %ebx
 420:	5e                   	pop    %esi
 421:	5f                   	pop    %edi
 422:	5d                   	pop    %ebp
 423:	c3                   	ret    
 424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 428:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 42b:	83 c2 01             	add    $0x1,%edx
 42e:	eb e3                	jmp    413 <getLine+0x83>
  for (i = 0; i < max - 1; i++) {
 430:	ba 01 00 00 00       	mov    $0x1,%edx
 435:	eb dc                	jmp    413 <getLine+0x83>
 437:	89 f6                	mov    %esi,%esi
 439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000440 <find>:
int find(char* str, char delim[], int nth) {
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
  for (i = 0; i < strlen(str); i++) {
 446:	31 ff                	xor    %edi,%edi
int find(char* str, char delim[], int nth) {
 448:	83 ec 1c             	sub    $0x1c,%esp
				if (str[j] != delim[j - i]) goto out;
 44b:	8b 45 0c             	mov    0xc(%ebp),%eax
int find(char* str, char delim[], int nth) {
 44e:	8b 5d 08             	mov    0x8(%ebp),%ebx
				if (str[j] != delim[j - i]) goto out;
 451:	83 c0 01             	add    $0x1,%eax
 454:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for (i = 0; i < strlen(str); i++) {
 457:	eb 0a                	jmp    463 <find+0x23>
 459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 460:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 463:	83 ec 0c             	sub    $0xc,%esp
 466:	53                   	push   %ebx
 467:	e8 e4 02 00 00       	call   750 <strlen>
 46c:	83 c4 10             	add    $0x10,%esp
 46f:	39 f8                	cmp    %edi,%eax
 471:	76 5d                	jbe    4d0 <find+0x90>
 473:	8d 47 01             	lea    0x1(%edi),%eax
 476:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if (str[i] == delim[0]) {
 479:	8b 45 0c             	mov    0xc(%ebp),%eax
 47c:	0f b6 00             	movzbl (%eax),%eax
 47f:	38 04 3b             	cmp    %al,(%ebx,%edi,1)
 482:	75 dc                	jne    460 <find+0x20>
				if (str[j] != delim[j - i]) goto out;
 484:	8b 45 dc             	mov    -0x24(%ebp),%eax
			for (j = i + 1; j < (i + strlen(delim)); j++) {
 487:	8d 57 01             	lea    0x1(%edi),%edx
 48a:	89 d6                	mov    %edx,%esi
				if (str[j] != delim[j - i]) goto out;
 48c:	29 d0                	sub    %edx,%eax
 48e:	89 45 e0             	mov    %eax,-0x20(%ebp)
 491:	eb 14                	jmp    4a7 <find+0x67>
 493:	90                   	nop
 494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 498:	8b 45 e0             	mov    -0x20(%ebp),%eax
 49b:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
 49f:	38 04 33             	cmp    %al,(%ebx,%esi,1)
 4a2:	75 bc                	jne    460 <find+0x20>
			for (j = i + 1; j < (i + strlen(delim)); j++) {
 4a4:	83 c6 01             	add    $0x1,%esi
 4a7:	83 ec 0c             	sub    $0xc,%esp
 4aa:	ff 75 0c             	pushl  0xc(%ebp)
 4ad:	e8 9e 02 00 00       	call   750 <strlen>
 4b2:	01 f8                	add    %edi,%eax
 4b4:	83 c4 10             	add    $0x10,%esp
 4b7:	39 f0                	cmp    %esi,%eax
 4b9:	77 dd                	ja     498 <find+0x58>
			if (nth-- == 0) return i;
 4bb:	8b 45 10             	mov    0x10(%ebp),%eax
 4be:	8b 55 10             	mov    0x10(%ebp),%edx
 4c1:	83 e8 01             	sub    $0x1,%eax
 4c4:	85 d2                	test   %edx,%edx
 4c6:	74 0d                	je     4d5 <find+0x95>
			out:;
 4c8:	89 45 10             	mov    %eax,0x10(%ebp)
 4cb:	eb 93                	jmp    460 <find+0x20>
 4cd:	8d 76 00             	lea    0x0(%esi),%esi
  return -1;
 4d0:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
 4d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4d8:	89 f8                	mov    %edi,%eax
 4da:	5b                   	pop    %ebx
 4db:	5e                   	pop    %esi
 4dc:	5f                   	pop    %edi
 4dd:	5d                   	pop    %ebp
 4de:	c3                   	ret    
 4df:	90                   	nop

000004e0 <substr>:
char* substr(char* str, int start, int end) {
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
 4e6:	83 ec 18             	sub    $0x18,%esp
 4e9:	8b 7d 10             	mov    0x10(%ebp),%edi
 4ec:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	char* dst = malloc(ARGLEN * sizeof(char));
 4ef:	6a 14                	push   $0x14
 4f1:	e8 7a 08 00 00       	call   d70 <malloc>
  memset(dst, 0, ARGLEN * sizeof(char));
 4f6:	83 c4 0c             	add    $0xc,%esp
	char* dst = malloc(ARGLEN * sizeof(char));
 4f9:	89 c6                	mov    %eax,%esi
  memset(dst, 0, ARGLEN * sizeof(char));
 4fb:	6a 14                	push   $0x14
 4fd:	6a 00                	push   $0x0
 4ff:	50                   	push   %eax
 500:	e8 7b 02 00 00       	call   780 <memset>
  int len = strlen(str);
 505:	58                   	pop    %eax
 506:	ff 75 08             	pushl  0x8(%ebp)
 509:	e8 42 02 00 00       	call   750 <strlen>
 50e:	83 c4 10             	add    $0x10,%esp
 511:	39 f8                	cmp    %edi,%eax
 513:	0f 4e f8             	cmovle %eax,%edi
  while (i < end)
 516:	39 df                	cmp    %ebx,%edi
 518:	7e 36                	jle    550 <substr+0x70>
 51a:	8b 45 08             	mov    0x8(%ebp),%eax
 51d:	29 df                	sub    %ebx,%edi
  int s = 0, i = start;
 51f:	31 d2                	xor    %edx,%edx
 521:	01 c3                	add    %eax,%ebx
 523:	90                   	nop
 524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dst[s++] = str[i++];
 528:	83 c2 01             	add    $0x1,%edx
 52b:	0f b6 44 13 ff       	movzbl -0x1(%ebx,%edx,1),%eax
  while (i < end)
 530:	39 fa                	cmp    %edi,%edx
    dst[s++] = str[i++];
 532:	88 44 16 ff          	mov    %al,-0x1(%esi,%edx,1)
  while (i < end)
 536:	75 f0                	jne    528 <substr+0x48>
 538:	01 f2                	add    %esi,%edx
}
 53a:	89 f0                	mov    %esi,%eax
  dst[s] = '\0';
 53c:	c6 02 00             	movb   $0x0,(%edx)
}
 53f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 542:	5b                   	pop    %ebx
 543:	5e                   	pop    %esi
 544:	5f                   	pop    %edi
 545:	5d                   	pop    %ebp
 546:	c3                   	ret    
 547:	89 f6                	mov    %esi,%esi
 549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	char* dst = malloc(ARGLEN * sizeof(char));
 550:	89 f2                	mov    %esi,%edx
}
 552:	89 f0                	mov    %esi,%eax
  dst[s] = '\0';
 554:	c6 02 00             	movb   $0x0,(%edx)
}
 557:	8d 65 f4             	lea    -0xc(%ebp),%esp
 55a:	5b                   	pop    %ebx
 55b:	5e                   	pop    %esi
 55c:	5f                   	pop    %edi
 55d:	5d                   	pop    %ebp
 55e:	c3                   	ret    
 55f:	90                   	nop

00000560 <split>:
char** split(char line[], char delim[], int* count) {
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
  int pos, prevpos = 0, index = 0;
 566:	31 f6                	xor    %esi,%esi
 568:	31 db                	xor    %ebx,%ebx
char** split(char line[], char delim[], int* count) {
 56a:	83 ec 28             	sub    $0x28,%esp
	char** dst = malloc(MAXARGS * sizeof(char*));
 56d:	6a 28                	push   $0x28
 56f:	e8 fc 07 00 00       	call   d70 <malloc>
	while ((pos = find(line, delim, index)) > 0) {
 574:	83 c4 10             	add    $0x10,%esp
	char** dst = malloc(MAXARGS * sizeof(char*));
 577:	89 45 e0             	mov    %eax,-0x20(%ebp)
 57a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
	while ((pos = find(line, delim, index)) > 0) {
 581:	eb 44                	jmp    5c7 <split+0x67>
 583:	90                   	nop
 584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		char* arg = substr(line, prevpos, pos);
 588:	83 ec 04             	sub    $0x4,%esp
 58b:	57                   	push   %edi
 58c:	53                   	push   %ebx
 58d:	ff 75 08             	pushl  0x8(%ebp)
 590:	e8 4b ff ff ff       	call   4e0 <substr>
		if (strlen(arg) != 0) {
 595:	89 04 24             	mov    %eax,(%esp)
		char* arg = substr(line, prevpos, pos);
 598:	89 c3                	mov    %eax,%ebx
		if (strlen(arg) != 0) {
 59a:	e8 b1 01 00 00       	call   750 <strlen>
 59f:	83 c4 10             	add    $0x10,%esp
 5a2:	85 c0                	test   %eax,%eax
 5a4:	74 10                	je     5b6 <split+0x56>
			dst[index] = arg;
 5a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5a9:	89 18                	mov    %ebx,(%eax)
 5ab:	8b 45 dc             	mov    -0x24(%ebp),%eax
 5ae:	89 c6                	mov    %eax,%esi
 5b0:	83 c0 01             	add    $0x1,%eax
 5b3:	89 45 dc             	mov    %eax,-0x24(%ebp)
		prevpos = pos + strlen(delim);
 5b6:	83 ec 0c             	sub    $0xc,%esp
 5b9:	ff 75 0c             	pushl  0xc(%ebp)
 5bc:	e8 8f 01 00 00       	call   750 <strlen>
 5c1:	8d 1c 07             	lea    (%edi,%eax,1),%ebx
 5c4:	83 c4 10             	add    $0x10,%esp
	while ((pos = find(line, delim, index)) > 0) {
 5c7:	83 ec 04             	sub    $0x4,%esp
 5ca:	56                   	push   %esi
 5cb:	ff 75 0c             	pushl  0xc(%ebp)
 5ce:	ff 75 08             	pushl  0x8(%ebp)
 5d1:	e8 6a fe ff ff       	call   440 <find>
 5d6:	89 c7                	mov    %eax,%edi
 5d8:	8b 45 e0             	mov    -0x20(%ebp),%eax
 5db:	83 c4 10             	add    $0x10,%esp
 5de:	85 ff                	test   %edi,%edi
 5e0:	8d 04 b0             	lea    (%eax,%esi,4),%eax
 5e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 5e6:	7f a0                	jg     588 <split+0x28>
	*(dst + index) = substr(line, prevpos, strlen(line));
 5e8:	83 ec 0c             	sub    $0xc,%esp
 5eb:	ff 75 08             	pushl  0x8(%ebp)
 5ee:	e8 5d 01 00 00       	call   750 <strlen>
 5f3:	83 c4 0c             	add    $0xc,%esp
 5f6:	50                   	push   %eax
 5f7:	53                   	push   %ebx
 5f8:	ff 75 08             	pushl  0x8(%ebp)
 5fb:	e8 e0 fe ff ff       	call   4e0 <substr>
 600:	8b 55 e4             	mov    -0x1c(%ebp),%edx
	*count = ++index;
 603:	8b 4d dc             	mov    -0x24(%ebp),%ecx
	*(dst + index) = substr(line, prevpos, strlen(line));
 606:	89 02                	mov    %eax,(%edx)
	*count = ++index;
 608:	8b 45 10             	mov    0x10(%ebp),%eax
 60b:	89 08                	mov    %ecx,(%eax)
}
 60d:	8b 45 e0             	mov    -0x20(%ebp),%eax
 610:	8d 65 f4             	lea    -0xc(%ebp),%esp
 613:	5b                   	pop    %ebx
 614:	5e                   	pop    %esi
 615:	5f                   	pop    %edi
 616:	5d                   	pop    %ebp
 617:	c3                   	ret    
 618:	90                   	nop
 619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000620 <freeChptr>:
int freeChptr(char** ptr, int len) {
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	57                   	push   %edi
 624:	56                   	push   %esi
 625:	53                   	push   %ebx
 626:	83 ec 0c             	sub    $0xc,%esp
 629:	8b 45 0c             	mov    0xc(%ebp),%eax
 62c:	8b 7d 08             	mov    0x8(%ebp),%edi
	for (int i = 0; i < len; i++)
 62f:	85 c0                	test   %eax,%eax
 631:	7e 21                	jle    654 <freeChptr+0x34>
 633:	8d 34 87             	lea    (%edi,%eax,4),%esi
 636:	89 fb                	mov    %edi,%ebx
 638:	90                   	nop
 639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		free(ptr[i]);
 640:	83 ec 0c             	sub    $0xc,%esp
 643:	ff 33                	pushl  (%ebx)
 645:	83 c3 04             	add    $0x4,%ebx
 648:	e8 93 06 00 00       	call   ce0 <free>
	for (int i = 0; i < len; i++)
 64d:	83 c4 10             	add    $0x10,%esp
 650:	39 de                	cmp    %ebx,%esi
 652:	75 ec                	jne    640 <freeChptr+0x20>
	free(ptr);
 654:	83 ec 0c             	sub    $0xc,%esp
 657:	57                   	push   %edi
 658:	e8 83 06 00 00       	call   ce0 <free>
}
 65d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 660:	31 c0                	xor    %eax,%eax
 662:	5b                   	pop    %ebx
 663:	5e                   	pop    %esi
 664:	5f                   	pop    %edi
 665:	5d                   	pop    %ebp
 666:	c3                   	ret    
 667:	89 f6                	mov    %esi,%esi
 669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000670 <prompt>:
void prompt(int cmdNum) {
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	83 ec 08             	sub    $0x8,%esp
 676:	8b 45 08             	mov    0x8(%ebp),%eax
  if (cmdNum < 10)
 679:	83 f8 09             	cmp    $0x9,%eax
 67c:	7e 3a                	jle    6b8 <prompt+0x48>
  else if (cmdNum < 100)
 67e:	83 f8 63             	cmp    $0x63,%eax
 681:	7e 1d                	jle    6a0 <prompt+0x30>
    fprintf(2, "%d  EZ$ ", cmdNum);
  else
    fprintf(2, "%d EZ$ ", cmdNum);
 683:	83 ec 04             	sub    $0x4,%esp
 686:	50                   	push   %eax
 687:	68 d0 0e 00 00       	push   $0xed0
 68c:	6a 02                	push   $0x2
 68e:	e8 0d 06 00 00       	call   ca0 <fprintf>
 693:	83 c4 10             	add    $0x10,%esp
}
 696:	c9                   	leave  
 697:	c3                   	ret    
 698:	90                   	nop
 699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "%d  EZ$ ", cmdNum);
 6a0:	83 ec 04             	sub    $0x4,%esp
 6a3:	50                   	push   %eax
 6a4:	68 c7 0e 00 00       	push   $0xec7
 6a9:	6a 02                	push   $0x2
 6ab:	e8 f0 05 00 00       	call   ca0 <fprintf>
 6b0:	83 c4 10             	add    $0x10,%esp
}
 6b3:	c9                   	leave  
 6b4:	c3                   	ret    
 6b5:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "%d   EZ$ ", cmdNum);
 6b8:	83 ec 04             	sub    $0x4,%esp
 6bb:	50                   	push   %eax
 6bc:	68 bd 0e 00 00       	push   $0xebd
 6c1:	6a 02                	push   $0x2
 6c3:	e8 d8 05 00 00       	call   ca0 <fprintf>
 6c8:	83 c4 10             	add    $0x10,%esp
}
 6cb:	c9                   	leave  
 6cc:	c3                   	ret    
 6cd:	66 90                	xchg   %ax,%ax
 6cf:	90                   	nop

000006d0 <strcpy>:
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	53                   	push   %ebx
 6d4:	8b 45 08             	mov    0x8(%ebp),%eax
 6d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 6da:	89 c2                	mov    %eax,%edx
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6e0:	83 c1 01             	add    $0x1,%ecx
 6e3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 6e7:	83 c2 01             	add    $0x1,%edx
 6ea:	84 db                	test   %bl,%bl
 6ec:	88 5a ff             	mov    %bl,-0x1(%edx)
 6ef:	75 ef                	jne    6e0 <strcpy+0x10>
    ;
  return os;
}
 6f1:	5b                   	pop    %ebx
 6f2:	5d                   	pop    %ebp
 6f3:	c3                   	ret    
 6f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000700 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	53                   	push   %ebx
 704:	8b 55 08             	mov    0x8(%ebp),%edx
 707:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 70a:	0f b6 02             	movzbl (%edx),%eax
 70d:	0f b6 19             	movzbl (%ecx),%ebx
 710:	84 c0                	test   %al,%al
 712:	75 1c                	jne    730 <strcmp+0x30>
 714:	eb 2a                	jmp    740 <strcmp+0x40>
 716:	8d 76 00             	lea    0x0(%esi),%esi
 719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 720:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 723:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 726:	83 c1 01             	add    $0x1,%ecx
 729:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 72c:	84 c0                	test   %al,%al
 72e:	74 10                	je     740 <strcmp+0x40>
 730:	38 d8                	cmp    %bl,%al
 732:	74 ec                	je     720 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 734:	29 d8                	sub    %ebx,%eax
}
 736:	5b                   	pop    %ebx
 737:	5d                   	pop    %ebp
 738:	c3                   	ret    
 739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 740:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 742:	29 d8                	sub    %ebx,%eax
}
 744:	5b                   	pop    %ebx
 745:	5d                   	pop    %ebp
 746:	c3                   	ret    
 747:	89 f6                	mov    %esi,%esi
 749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000750 <strlen>:

uint
strlen(const char *s)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 756:	80 39 00             	cmpb   $0x0,(%ecx)
 759:	74 15                	je     770 <strlen+0x20>
 75b:	31 d2                	xor    %edx,%edx
 75d:	8d 76 00             	lea    0x0(%esi),%esi
 760:	83 c2 01             	add    $0x1,%edx
 763:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 767:	89 d0                	mov    %edx,%eax
 769:	75 f5                	jne    760 <strlen+0x10>
    ;
  return n;
}
 76b:	5d                   	pop    %ebp
 76c:	c3                   	ret    
 76d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 770:	31 c0                	xor    %eax,%eax
}
 772:	5d                   	pop    %ebp
 773:	c3                   	ret    
 774:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 77a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000780 <memset>:

void*
memset(void *dst, int c, uint n)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	57                   	push   %edi
 784:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 787:	8b 4d 10             	mov    0x10(%ebp),%ecx
 78a:	8b 45 0c             	mov    0xc(%ebp),%eax
 78d:	89 d7                	mov    %edx,%edi
 78f:	fc                   	cld    
 790:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 792:	89 d0                	mov    %edx,%eax
 794:	5f                   	pop    %edi
 795:	5d                   	pop    %ebp
 796:	c3                   	ret    
 797:	89 f6                	mov    %esi,%esi
 799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007a0 <strchr>:

char*
strchr(const char *s, char c)
{
 7a0:	55                   	push   %ebp
 7a1:	89 e5                	mov    %esp,%ebp
 7a3:	53                   	push   %ebx
 7a4:	8b 45 08             	mov    0x8(%ebp),%eax
 7a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 7aa:	0f b6 10             	movzbl (%eax),%edx
 7ad:	84 d2                	test   %dl,%dl
 7af:	74 1d                	je     7ce <strchr+0x2e>
    if(*s == c)
 7b1:	38 d3                	cmp    %dl,%bl
 7b3:	89 d9                	mov    %ebx,%ecx
 7b5:	75 0d                	jne    7c4 <strchr+0x24>
 7b7:	eb 17                	jmp    7d0 <strchr+0x30>
 7b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7c0:	38 ca                	cmp    %cl,%dl
 7c2:	74 0c                	je     7d0 <strchr+0x30>
  for(; *s; s++)
 7c4:	83 c0 01             	add    $0x1,%eax
 7c7:	0f b6 10             	movzbl (%eax),%edx
 7ca:	84 d2                	test   %dl,%dl
 7cc:	75 f2                	jne    7c0 <strchr+0x20>
      return (char*)s;
  return 0;
 7ce:	31 c0                	xor    %eax,%eax
}
 7d0:	5b                   	pop    %ebx
 7d1:	5d                   	pop    %ebp
 7d2:	c3                   	ret    
 7d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007e0 <gets>:

char*
gets(char *buf, int max)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	57                   	push   %edi
 7e4:	56                   	push   %esi
 7e5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 7e6:	31 f6                	xor    %esi,%esi
 7e8:	89 f3                	mov    %esi,%ebx
{
 7ea:	83 ec 1c             	sub    $0x1c,%esp
 7ed:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 7f0:	eb 2f                	jmp    821 <gets+0x41>
 7f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 7f8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 7fb:	83 ec 04             	sub    $0x4,%esp
 7fe:	6a 01                	push   $0x1
 800:	50                   	push   %eax
 801:	6a 00                	push   $0x0
 803:	e8 32 01 00 00       	call   93a <read>
    if(cc < 1)
 808:	83 c4 10             	add    $0x10,%esp
 80b:	85 c0                	test   %eax,%eax
 80d:	7e 1c                	jle    82b <gets+0x4b>
      break;
    buf[i++] = c;
 80f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 813:	83 c7 01             	add    $0x1,%edi
 816:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 819:	3c 0a                	cmp    $0xa,%al
 81b:	74 23                	je     840 <gets+0x60>
 81d:	3c 0d                	cmp    $0xd,%al
 81f:	74 1f                	je     840 <gets+0x60>
  for(i=0; i+1 < max; ){
 821:	83 c3 01             	add    $0x1,%ebx
 824:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 827:	89 fe                	mov    %edi,%esi
 829:	7c cd                	jl     7f8 <gets+0x18>
 82b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 82d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 830:	c6 03 00             	movb   $0x0,(%ebx)
}
 833:	8d 65 f4             	lea    -0xc(%ebp),%esp
 836:	5b                   	pop    %ebx
 837:	5e                   	pop    %esi
 838:	5f                   	pop    %edi
 839:	5d                   	pop    %ebp
 83a:	c3                   	ret    
 83b:	90                   	nop
 83c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 840:	8b 75 08             	mov    0x8(%ebp),%esi
 843:	8b 45 08             	mov    0x8(%ebp),%eax
 846:	01 de                	add    %ebx,%esi
 848:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 84a:	c6 03 00             	movb   $0x0,(%ebx)
}
 84d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 850:	5b                   	pop    %ebx
 851:	5e                   	pop    %esi
 852:	5f                   	pop    %edi
 853:	5d                   	pop    %ebp
 854:	c3                   	ret    
 855:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000860 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
 860:	55                   	push   %ebp
 861:	89 e5                	mov    %esp,%ebp
 863:	56                   	push   %esi
 864:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 865:	83 ec 08             	sub    $0x8,%esp
 868:	6a 00                	push   $0x0
 86a:	ff 75 08             	pushl  0x8(%ebp)
 86d:	e8 f8 00 00 00       	call   96a <open>
  if(fd < 0)
 872:	83 c4 10             	add    $0x10,%esp
 875:	85 c0                	test   %eax,%eax
 877:	78 27                	js     8a0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 879:	83 ec 08             	sub    $0x8,%esp
 87c:	ff 75 0c             	pushl  0xc(%ebp)
 87f:	89 c3                	mov    %eax,%ebx
 881:	50                   	push   %eax
 882:	e8 fb 00 00 00       	call   982 <fstat>
  close(fd);
 887:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 88a:	89 c6                	mov    %eax,%esi
  close(fd);
 88c:	e8 c1 00 00 00       	call   952 <close>
  return r;
 891:	83 c4 10             	add    $0x10,%esp
}
 894:	8d 65 f8             	lea    -0x8(%ebp),%esp
 897:	89 f0                	mov    %esi,%eax
 899:	5b                   	pop    %ebx
 89a:	5e                   	pop    %esi
 89b:	5d                   	pop    %ebp
 89c:	c3                   	ret    
 89d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 8a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 8a5:	eb ed                	jmp    894 <stat+0x34>
 8a7:	89 f6                	mov    %esi,%esi
 8a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008b0 <atoi>:

int
atoi(const char *s)
{
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	53                   	push   %ebx
 8b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 8b7:	0f be 11             	movsbl (%ecx),%edx
 8ba:	8d 42 d0             	lea    -0x30(%edx),%eax
 8bd:	3c 09                	cmp    $0x9,%al
  n = 0;
 8bf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 8c4:	77 1f                	ja     8e5 <atoi+0x35>
 8c6:	8d 76 00             	lea    0x0(%esi),%esi
 8c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 8d0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 8d3:	83 c1 01             	add    $0x1,%ecx
 8d6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 8da:	0f be 11             	movsbl (%ecx),%edx
 8dd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 8e0:	80 fb 09             	cmp    $0x9,%bl
 8e3:	76 eb                	jbe    8d0 <atoi+0x20>
  return n;
}
 8e5:	5b                   	pop    %ebx
 8e6:	5d                   	pop    %ebp
 8e7:	c3                   	ret    
 8e8:	90                   	nop
 8e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008f0 <memmove>:


void*
memmove(void *vdst, const void *vsrc, int n)
{
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	56                   	push   %esi
 8f4:	53                   	push   %ebx
 8f5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 8f8:	8b 45 08             	mov    0x8(%ebp),%eax
 8fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 8fe:	85 db                	test   %ebx,%ebx
 900:	7e 14                	jle    916 <memmove+0x26>
 902:	31 d2                	xor    %edx,%edx
 904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 908:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 90c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 90f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 912:	39 d3                	cmp    %edx,%ebx
 914:	75 f2                	jne    908 <memmove+0x18>
  return vdst;
}
 916:	5b                   	pop    %ebx
 917:	5e                   	pop    %esi
 918:	5d                   	pop    %ebp
 919:	c3                   	ret    

0000091a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 91a:	b8 01 00 00 00       	mov    $0x1,%eax
 91f:	cd 40                	int    $0x40
 921:	c3                   	ret    

00000922 <exit>:
SYSCALL(exit)
 922:	b8 02 00 00 00       	mov    $0x2,%eax
 927:	cd 40                	int    $0x40
 929:	c3                   	ret    

0000092a <wait>:
SYSCALL(wait)
 92a:	b8 03 00 00 00       	mov    $0x3,%eax
 92f:	cd 40                	int    $0x40
 931:	c3                   	ret    

00000932 <pipe>:
SYSCALL(pipe)
 932:	b8 04 00 00 00       	mov    $0x4,%eax
 937:	cd 40                	int    $0x40
 939:	c3                   	ret    

0000093a <read>:
SYSCALL(read)
 93a:	b8 05 00 00 00       	mov    $0x5,%eax
 93f:	cd 40                	int    $0x40
 941:	c3                   	ret    

00000942 <steal>:
SYSCALL(steal)
 942:	b8 17 00 00 00       	mov    $0x17,%eax
 947:	cd 40                	int    $0x40
 949:	c3                   	ret    

0000094a <write>:
SYSCALL(write)
 94a:	b8 10 00 00 00       	mov    $0x10,%eax
 94f:	cd 40                	int    $0x40
 951:	c3                   	ret    

00000952 <close>:
SYSCALL(close)
 952:	b8 15 00 00 00       	mov    $0x15,%eax
 957:	cd 40                	int    $0x40
 959:	c3                   	ret    

0000095a <kill>:
SYSCALL(kill)
 95a:	b8 06 00 00 00       	mov    $0x6,%eax
 95f:	cd 40                	int    $0x40
 961:	c3                   	ret    

00000962 <exec>:
SYSCALL(exec)
 962:	b8 07 00 00 00       	mov    $0x7,%eax
 967:	cd 40                	int    $0x40
 969:	c3                   	ret    

0000096a <open>:
SYSCALL(open)
 96a:	b8 0f 00 00 00       	mov    $0xf,%eax
 96f:	cd 40                	int    $0x40
 971:	c3                   	ret    

00000972 <mknod>:
SYSCALL(mknod)
 972:	b8 11 00 00 00       	mov    $0x11,%eax
 977:	cd 40                	int    $0x40
 979:	c3                   	ret    

0000097a <unlink>:
SYSCALL(unlink)
 97a:	b8 12 00 00 00       	mov    $0x12,%eax
 97f:	cd 40                	int    $0x40
 981:	c3                   	ret    

00000982 <fstat>:
SYSCALL(fstat)
 982:	b8 08 00 00 00       	mov    $0x8,%eax
 987:	cd 40                	int    $0x40
 989:	c3                   	ret    

0000098a <link>:
SYSCALL(link)
 98a:	b8 13 00 00 00       	mov    $0x13,%eax
 98f:	cd 40                	int    $0x40
 991:	c3                   	ret    

00000992 <mkdir>:
SYSCALL(mkdir)
 992:	b8 14 00 00 00       	mov    $0x14,%eax
 997:	cd 40                	int    $0x40
 999:	c3                   	ret    

0000099a <chdir>:
SYSCALL(chdir)
 99a:	b8 09 00 00 00       	mov    $0x9,%eax
 99f:	cd 40                	int    $0x40
 9a1:	c3                   	ret    

000009a2 <dup>:
SYSCALL(dup)
 9a2:	b8 0a 00 00 00       	mov    $0xa,%eax
 9a7:	cd 40                	int    $0x40
 9a9:	c3                   	ret    

000009aa <getpid>:
SYSCALL(getpid)
 9aa:	b8 0b 00 00 00       	mov    $0xb,%eax
 9af:	cd 40                	int    $0x40
 9b1:	c3                   	ret    

000009b2 <sbrk>:
SYSCALL(sbrk)
 9b2:	b8 0c 00 00 00       	mov    $0xc,%eax
 9b7:	cd 40                	int    $0x40
 9b9:	c3                   	ret    

000009ba <sleep>:
SYSCALL(sleep)
 9ba:	b8 0d 00 00 00       	mov    $0xd,%eax
 9bf:	cd 40                	int    $0x40
 9c1:	c3                   	ret    

000009c2 <uptime>:
SYSCALL(uptime)
 9c2:	b8 0e 00 00 00       	mov    $0xe,%eax
 9c7:	cd 40                	int    $0x40
 9c9:	c3                   	ret    

000009ca <cpuhalt>:
SYSCALL(cpuhalt)
 9ca:	b8 16 00 00 00       	mov    $0x16,%eax
 9cf:	cd 40                	int    $0x40
 9d1:	c3                   	ret    
 9d2:	66 90                	xchg   %ax,%ax
 9d4:	66 90                	xchg   %ax,%ax
 9d6:	66 90                	xchg   %ax,%ax
 9d8:	66 90                	xchg   %ax,%ax
 9da:	66 90                	xchg   %ax,%ax
 9dc:	66 90                	xchg   %ax,%ax
 9de:	66 90                	xchg   %ax,%ax

000009e0 <printint.constprop.1>:
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
}

static void
printint(int fd, int xx, int base, int sgn)
 9e0:	55                   	push   %ebp
 9e1:	89 e5                	mov    %esp,%ebp
 9e3:	57                   	push   %edi
 9e4:	56                   	push   %esi
 9e5:	53                   	push   %ebx
 9e6:	89 d6                	mov    %edx,%esi
 9e8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 9eb:	85 c0                	test   %eax,%eax
 9ed:	79 71                	jns    a60 <printint.constprop.1+0x80>
 9ef:	83 e1 01             	and    $0x1,%ecx
 9f2:	74 6c                	je     a60 <printint.constprop.1+0x80>
    neg = 1;
    x = -xx;
 9f4:	f7 d8                	neg    %eax
    neg = 1;
 9f6:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 9fd:	31 c9                	xor    %ecx,%ecx
 9ff:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 a02:	eb 06                	jmp    a0a <printint.constprop.1+0x2a>
 a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 a08:	89 f9                	mov    %edi,%ecx
 a0a:	31 d2                	xor    %edx,%edx
 a0c:	8d 79 01             	lea    0x1(%ecx),%edi
 a0f:	f7 f6                	div    %esi
 a11:	0f b6 92 c8 0f 00 00 	movzbl 0xfc8(%edx),%edx
  }while((x /= base) != 0);
 a18:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 a1a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 a1d:	75 e9                	jne    a08 <printint.constprop.1+0x28>
  if(neg)
 a1f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 a22:	85 c0                	test   %eax,%eax
 a24:	74 08                	je     a2e <printint.constprop.1+0x4e>
    buf[i++] = '-';
 a26:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 a2b:	8d 79 02             	lea    0x2(%ecx),%edi
 a2e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a38:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 a3b:	83 ec 04             	sub    $0x4,%esp
 a3e:	83 ee 01             	sub    $0x1,%esi
 a41:	6a 01                	push   $0x1
 a43:	53                   	push   %ebx
 a44:	6a 01                	push   $0x1
 a46:	88 45 d7             	mov    %al,-0x29(%ebp)
 a49:	e8 fc fe ff ff       	call   94a <write>

  while(--i >= 0)
 a4e:	83 c4 10             	add    $0x10,%esp
 a51:	39 de                	cmp    %ebx,%esi
 a53:	75 e3                	jne    a38 <printint.constprop.1+0x58>
    putc(fd, buf[i]);
}
 a55:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a58:	5b                   	pop    %ebx
 a59:	5e                   	pop    %esi
 a5a:	5f                   	pop    %edi
 a5b:	5d                   	pop    %ebp
 a5c:	c3                   	ret    
 a5d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 a60:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 a67:	eb 94                	jmp    9fd <printint.constprop.1+0x1d>
 a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a70 <vprintf.constprop.0>:
static void vprintf(int fd, const char *fmt, va_list ap)
 a70:	55                   	push   %ebp
 a71:	89 e5                	mov    %esp,%ebp
 a73:	57                   	push   %edi
 a74:	56                   	push   %esi
 a75:	53                   	push   %ebx
 a76:	89 d6                	mov    %edx,%esi
 a78:	83 ec 2c             	sub    $0x2c,%esp
{
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 a7b:	0f b6 10             	movzbl (%eax),%edx
 a7e:	84 d2                	test   %dl,%dl
 a80:	0f 84 cd 00 00 00    	je     b53 <vprintf.constprop.0+0xe3>
 a86:	8d 58 01             	lea    0x1(%eax),%ebx
  state = 0;
 a89:	31 ff                	xor    %edi,%edi
 a8b:	eb 31                	jmp    abe <vprintf.constprop.0+0x4e>
 a8d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 a90:	83 f8 25             	cmp    $0x25,%eax
 a93:	0f 84 c7 00 00 00    	je     b60 <vprintf.constprop.0+0xf0>
  write(fd, &c, 1);
 a99:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 a9c:	83 ec 04             	sub    $0x4,%esp
 a9f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 aa2:	6a 01                	push   $0x1
 aa4:	50                   	push   %eax
 aa5:	6a 01                	push   $0x1
 aa7:	e8 9e fe ff ff       	call   94a <write>
 aac:	83 c4 10             	add    $0x10,%esp
 aaf:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 ab2:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 ab6:	84 d2                	test   %dl,%dl
 ab8:	0f 84 95 00 00 00    	je     b53 <vprintf.constprop.0+0xe3>
    if(state == 0){
 abe:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 ac0:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 ac3:	74 cb                	je     a90 <vprintf.constprop.0+0x20>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 ac5:	83 ff 25             	cmp    $0x25,%edi
 ac8:	75 e5                	jne    aaf <vprintf.constprop.0+0x3f>
      if(c == 'd'){
 aca:	83 f8 64             	cmp    $0x64,%eax
        printint(fd, va_arg(ap, int), 10, 1);
 acd:	8d 7e 04             	lea    0x4(%esi),%edi
 ad0:	b9 01 00 00 00       	mov    $0x1,%ecx
      if(c == 'd'){
 ad5:	0f 84 9a 00 00 00    	je     b75 <vprintf.constprop.0+0x105>
      } else if(c == 'l') {
 adb:	83 f8 6c             	cmp    $0x6c,%eax
 ade:	0f 84 8c 00 00 00    	je     b70 <vprintf.constprop.0+0x100>
        printint(fd, va_arg(ap, uint), 10, 0);
      } else if(c == 'x') {
 ae4:	83 f8 78             	cmp    $0x78,%eax
 ae7:	0f 84 a3 00 00 00    	je     b90 <vprintf.constprop.0+0x120>
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 aed:	83 f8 70             	cmp    $0x70,%eax
 af0:	0f 84 ca 00 00 00    	je     bc0 <vprintf.constprop.0+0x150>
        printptr(fd, va_arg(ap, uint));
      } else if(c == 's'){
 af6:	83 f8 73             	cmp    $0x73,%eax
 af9:	0f 84 39 01 00 00    	je     c38 <vprintf.constprop.0+0x1c8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 aff:	83 f8 63             	cmp    $0x63,%eax
 b02:	0f 84 68 01 00 00    	je     c70 <vprintf.constprop.0+0x200>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 b08:	83 f8 25             	cmp    $0x25,%eax
 b0b:	0f 84 9f 00 00 00    	je     bb0 <vprintf.constprop.0+0x140>
  write(fd, &c, 1);
 b11:	8d 45 df             	lea    -0x21(%ebp),%eax
 b14:	83 ec 04             	sub    $0x4,%esp
 b17:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 b1a:	6a 01                	push   $0x1
 b1c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 b20:	50                   	push   %eax
 b21:	6a 01                	push   $0x1
 b23:	e8 22 fe ff ff       	call   94a <write>
 b28:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 b2c:	83 c4 0c             	add    $0xc,%esp
 b2f:	8d 45 e0             	lea    -0x20(%ebp),%eax
 b32:	6a 01                	push   $0x1
 b34:	88 55 e0             	mov    %dl,-0x20(%ebp)
 b37:	50                   	push   %eax
 b38:	6a 01                	push   $0x1
 b3a:	83 c3 01             	add    $0x1,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 b3d:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 b3f:	e8 06 fe ff ff       	call   94a <write>
  for(i = 0; fmt[i]; i++){
 b44:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
  write(fd, &c, 1);
 b48:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 b4b:	84 d2                	test   %dl,%dl
 b4d:	0f 85 6b ff ff ff    	jne    abe <vprintf.constprop.0+0x4e>
    }
  }
}
 b53:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b56:	5b                   	pop    %ebx
 b57:	5e                   	pop    %esi
 b58:	5f                   	pop    %edi
 b59:	5d                   	pop    %ebp
 b5a:	c3                   	ret    
 b5b:	90                   	nop
 b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        state = '%';
 b60:	bf 25 00 00 00       	mov    $0x25,%edi
 b65:	e9 45 ff ff ff       	jmp    aaf <vprintf.constprop.0+0x3f>
 b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, uint), 10, 0);
 b70:	8d 7e 04             	lea    0x4(%esi),%edi
 b73:	31 c9                	xor    %ecx,%ecx
 b75:	8b 06                	mov    (%esi),%eax
 b77:	ba 0a 00 00 00       	mov    $0xa,%edx
 b7c:	89 fe                	mov    %edi,%esi
      state = 0;
 b7e:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, uint), 10, 0);
 b80:	e8 5b fe ff ff       	call   9e0 <printint.constprop.1>
 b85:	e9 25 ff ff ff       	jmp    aaf <vprintf.constprop.0+0x3f>
 b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, int), 16, 0);
 b90:	8b 06                	mov    (%esi),%eax
 b92:	8d 7e 04             	lea    0x4(%esi),%edi
 b95:	31 c9                	xor    %ecx,%ecx
 b97:	ba 10 00 00 00       	mov    $0x10,%edx
 b9c:	89 fe                	mov    %edi,%esi
      state = 0;
 b9e:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, int), 16, 0);
 ba0:	e8 3b fe ff ff       	call   9e0 <printint.constprop.1>
 ba5:	e9 05 ff ff ff       	jmp    aaf <vprintf.constprop.0+0x3f>
 baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 bb0:	83 ec 04             	sub    $0x4,%esp
 bb3:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 bb6:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 bb9:	6a 01                	push   $0x1
 bbb:	e9 77 ff ff ff       	jmp    b37 <vprintf.constprop.0+0xc7>
        printptr(fd, va_arg(ap, uint));
 bc0:	8d 46 04             	lea    0x4(%esi),%eax
  write(fd, &c, 1);
 bc3:	83 ec 04             	sub    $0x4,%esp
        printptr(fd, va_arg(ap, uint));
 bc6:	8b 3e                	mov    (%esi),%edi
  write(fd, &c, 1);
 bc8:	6a 01                	push   $0x1
 bca:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 bce:	be 08 00 00 00       	mov    $0x8,%esi
        printptr(fd, va_arg(ap, uint));
 bd3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 bd6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 bd9:	50                   	push   %eax
 bda:	6a 01                	push   $0x1
 bdc:	e8 69 fd ff ff       	call   94a <write>
 be1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 be4:	83 c4 0c             	add    $0xc,%esp
 be7:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 beb:	6a 01                	push   $0x1
 bed:	50                   	push   %eax
 bee:	6a 01                	push   $0x1
 bf0:	e8 55 fd ff ff       	call   94a <write>
 bf5:	83 c4 10             	add    $0x10,%esp
 bf8:	90                   	nop
 bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
 c00:	89 f8                	mov    %edi,%eax
  write(fd, &c, 1);
 c02:	83 ec 04             	sub    $0x4,%esp
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
 c05:	c1 e7 04             	shl    $0x4,%edi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
 c08:	c1 e8 1c             	shr    $0x1c,%eax
  write(fd, &c, 1);
 c0b:	6a 01                	push   $0x1
 c0d:	0f b6 80 c8 0f 00 00 	movzbl 0xfc8(%eax),%eax
 c14:	88 45 e5             	mov    %al,-0x1b(%ebp)
 c17:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 c1a:	50                   	push   %eax
 c1b:	6a 01                	push   $0x1
 c1d:	e8 28 fd ff ff       	call   94a <write>
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
 c22:	83 c4 10             	add    $0x10,%esp
 c25:	83 ee 01             	sub    $0x1,%esi
 c28:	75 d6                	jne    c00 <vprintf.constprop.0+0x190>
        s = va_arg(ap, char*);
 c2a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 c2d:	31 ff                	xor    %edi,%edi
 c2f:	e9 7b fe ff ff       	jmp    aaf <vprintf.constprop.0+0x3f>
 c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = va_arg(ap, char*);
 c38:	8b 3e                	mov    (%esi),%edi
 c3a:	8d 46 04             	lea    0x4(%esi),%eax
 c3d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 c40:	85 ff                	test   %edi,%edi
 c42:	74 50                	je     c94 <vprintf.constprop.0+0x224>
        while(*s != 0){
 c44:	0f b6 07             	movzbl (%edi),%eax
 c47:	84 c0                	test   %al,%al
 c49:	74 df                	je     c2a <vprintf.constprop.0+0x1ba>
 c4b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 c4e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 c50:	83 ec 04             	sub    $0x4,%esp
          s++;
 c53:	83 c7 01             	add    $0x1,%edi
 c56:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 c59:	6a 01                	push   $0x1
 c5b:	56                   	push   %esi
 c5c:	6a 01                	push   $0x1
 c5e:	e8 e7 fc ff ff       	call   94a <write>
        while(*s != 0){
 c63:	0f b6 07             	movzbl (%edi),%eax
 c66:	83 c4 10             	add    $0x10,%esp
 c69:	84 c0                	test   %al,%al
 c6b:	75 e3                	jne    c50 <vprintf.constprop.0+0x1e0>
 c6d:	eb bb                	jmp    c2a <vprintf.constprop.0+0x1ba>
 c6f:	90                   	nop
        putc(fd, va_arg(ap, uint));
 c70:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 c72:	83 ec 04             	sub    $0x4,%esp
        putc(fd, va_arg(ap, uint));
 c75:	8d 7e 04             	lea    0x4(%esi),%edi
  write(fd, &c, 1);
 c78:	6a 01                	push   $0x1
        putc(fd, va_arg(ap, uint));
 c7a:	89 fe                	mov    %edi,%esi
      state = 0;
 c7c:	31 ff                	xor    %edi,%edi
        putc(fd, va_arg(ap, uint));
 c7e:	88 45 e2             	mov    %al,-0x1e(%ebp)
  write(fd, &c, 1);
 c81:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 c84:	50                   	push   %eax
 c85:	6a 01                	push   $0x1
 c87:	e8 be fc ff ff       	call   94a <write>
 c8c:	83 c4 10             	add    $0x10,%esp
 c8f:	e9 1b fe ff ff       	jmp    aaf <vprintf.constprop.0+0x3f>
          s = "(null)";
 c94:	bf c0 0f 00 00       	mov    $0xfc0,%edi
        while(*s != 0){
 c99:	b8 28 00 00 00       	mov    $0x28,%eax
 c9e:	eb ab                	jmp    c4b <vprintf.constprop.0+0x1db>

00000ca0 <fprintf>:
// Print to the given fd. Only understands %d,%x, %p, %s, %c.
void
fprintf(int fd, const char *fmt, ...)
{
 ca0:	55                   	push   %ebp
 ca1:	89 e5                	mov    %esp,%ebp
 ca3:	83 ec 08             	sub    $0x8,%esp
 va_list ap;
 va_start(ap, fmt); 
 vprintf(1,fmt,ap);
 ca6:	8b 45 0c             	mov    0xc(%ebp),%eax
 ca9:	8d 55 10             	lea    0x10(%ebp),%edx
 cac:	e8 bf fd ff ff       	call   a70 <vprintf.constprop.0>
}
 cb1:	c9                   	leave  
 cb2:	c3                   	ret    
 cb3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000cc0 <printf>:
void
printf(const char *fmt, ...)
{
 cc0:	55                   	push   %ebp
 cc1:	89 e5                	mov    %esp,%ebp
 cc3:	83 ec 08             	sub    $0x8,%esp
  va_list ap;
  va_start(ap, fmt); 
  vprintf(1,fmt,ap);
 cc6:	8b 45 08             	mov    0x8(%ebp),%eax
 cc9:	8d 55 0c             	lea    0xc(%ebp),%edx
 ccc:	e8 9f fd ff ff       	call   a70 <vprintf.constprop.0>
}
 cd1:	c9                   	leave  
 cd2:	c3                   	ret    
 cd3:	66 90                	xchg   %ax,%ax
 cd5:	66 90                	xchg   %ax,%ax
 cd7:	66 90                	xchg   %ax,%ax
 cd9:	66 90                	xchg   %ax,%ax
 cdb:	66 90                	xchg   %ax,%ax
 cdd:	66 90                	xchg   %ax,%ax
 cdf:	90                   	nop

00000ce0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ce0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ce1:	a1 90 14 00 00       	mov    0x1490,%eax
{
 ce6:	89 e5                	mov    %esp,%ebp
 ce8:	57                   	push   %edi
 ce9:	56                   	push   %esi
 cea:	53                   	push   %ebx
 ceb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 cee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 cf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cf8:	39 c8                	cmp    %ecx,%eax
 cfa:	8b 10                	mov    (%eax),%edx
 cfc:	73 32                	jae    d30 <free+0x50>
 cfe:	39 d1                	cmp    %edx,%ecx
 d00:	72 04                	jb     d06 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d02:	39 d0                	cmp    %edx,%eax
 d04:	72 32                	jb     d38 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 d06:	8b 73 fc             	mov    -0x4(%ebx),%esi
 d09:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 d0c:	39 fa                	cmp    %edi,%edx
 d0e:	74 30                	je     d40 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 d10:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 d13:	8b 50 04             	mov    0x4(%eax),%edx
 d16:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 d19:	39 f1                	cmp    %esi,%ecx
 d1b:	74 3a                	je     d57 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 d1d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 d1f:	a3 90 14 00 00       	mov    %eax,0x1490
}
 d24:	5b                   	pop    %ebx
 d25:	5e                   	pop    %esi
 d26:	5f                   	pop    %edi
 d27:	5d                   	pop    %ebp
 d28:	c3                   	ret    
 d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d30:	39 d0                	cmp    %edx,%eax
 d32:	72 04                	jb     d38 <free+0x58>
 d34:	39 d1                	cmp    %edx,%ecx
 d36:	72 ce                	jb     d06 <free+0x26>
{
 d38:	89 d0                	mov    %edx,%eax
 d3a:	eb bc                	jmp    cf8 <free+0x18>
 d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 d40:	03 72 04             	add    0x4(%edx),%esi
 d43:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 d46:	8b 10                	mov    (%eax),%edx
 d48:	8b 12                	mov    (%edx),%edx
 d4a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 d4d:	8b 50 04             	mov    0x4(%eax),%edx
 d50:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 d53:	39 f1                	cmp    %esi,%ecx
 d55:	75 c6                	jne    d1d <free+0x3d>
    p->s.size += bp->s.size;
 d57:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 d5a:	a3 90 14 00 00       	mov    %eax,0x1490
    p->s.size += bp->s.size;
 d5f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 d62:	8b 53 f8             	mov    -0x8(%ebx),%edx
 d65:	89 10                	mov    %edx,(%eax)
}
 d67:	5b                   	pop    %ebx
 d68:	5e                   	pop    %esi
 d69:	5f                   	pop    %edi
 d6a:	5d                   	pop    %ebp
 d6b:	c3                   	ret    
 d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d70 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 d70:	55                   	push   %ebp
 d71:	89 e5                	mov    %esp,%ebp
 d73:	57                   	push   %edi
 d74:	56                   	push   %esi
 d75:	53                   	push   %ebx
 d76:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d79:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 d7c:	8b 15 90 14 00 00    	mov    0x1490,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d82:	8d 78 07             	lea    0x7(%eax),%edi
 d85:	c1 ef 03             	shr    $0x3,%edi
 d88:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 d8b:	85 d2                	test   %edx,%edx
 d8d:	0f 84 9d 00 00 00    	je     e30 <malloc+0xc0>
 d93:	8b 02                	mov    (%edx),%eax
 d95:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 d98:	39 cf                	cmp    %ecx,%edi
 d9a:	76 6c                	jbe    e08 <malloc+0x98>
 d9c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 da2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 da7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 daa:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 db1:	eb 0e                	jmp    dc1 <malloc+0x51>
 db3:	90                   	nop
 db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 db8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 dba:	8b 48 04             	mov    0x4(%eax),%ecx
 dbd:	39 f9                	cmp    %edi,%ecx
 dbf:	73 47                	jae    e08 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 dc1:	39 05 90 14 00 00    	cmp    %eax,0x1490
 dc7:	89 c2                	mov    %eax,%edx
 dc9:	75 ed                	jne    db8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 dcb:	83 ec 0c             	sub    $0xc,%esp
 dce:	56                   	push   %esi
 dcf:	e8 de fb ff ff       	call   9b2 <sbrk>
  if(p == (char*)-1)
 dd4:	83 c4 10             	add    $0x10,%esp
 dd7:	83 f8 ff             	cmp    $0xffffffff,%eax
 dda:	74 1c                	je     df8 <malloc+0x88>
  hp->s.size = nu;
 ddc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 ddf:	83 ec 0c             	sub    $0xc,%esp
 de2:	83 c0 08             	add    $0x8,%eax
 de5:	50                   	push   %eax
 de6:	e8 f5 fe ff ff       	call   ce0 <free>
  return freep;
 deb:	8b 15 90 14 00 00    	mov    0x1490,%edx
      if((p = morecore(nunits)) == 0)
 df1:	83 c4 10             	add    $0x10,%esp
 df4:	85 d2                	test   %edx,%edx
 df6:	75 c0                	jne    db8 <malloc+0x48>
        return 0;
  }
}
 df8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 dfb:	31 c0                	xor    %eax,%eax
}
 dfd:	5b                   	pop    %ebx
 dfe:	5e                   	pop    %esi
 dff:	5f                   	pop    %edi
 e00:	5d                   	pop    %ebp
 e01:	c3                   	ret    
 e02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 e08:	39 cf                	cmp    %ecx,%edi
 e0a:	74 54                	je     e60 <malloc+0xf0>
        p->s.size -= nunits;
 e0c:	29 f9                	sub    %edi,%ecx
 e0e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 e11:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 e14:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 e17:	89 15 90 14 00 00    	mov    %edx,0x1490
}
 e1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 e20:	83 c0 08             	add    $0x8,%eax
}
 e23:	5b                   	pop    %ebx
 e24:	5e                   	pop    %esi
 e25:	5f                   	pop    %edi
 e26:	5d                   	pop    %ebp
 e27:	c3                   	ret    
 e28:	90                   	nop
 e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 e30:	c7 05 90 14 00 00 94 	movl   $0x1494,0x1490
 e37:	14 00 00 
 e3a:	c7 05 94 14 00 00 94 	movl   $0x1494,0x1494
 e41:	14 00 00 
    base.s.size = 0;
 e44:	b8 94 14 00 00       	mov    $0x1494,%eax
 e49:	c7 05 98 14 00 00 00 	movl   $0x0,0x1498
 e50:	00 00 00 
 e53:	e9 44 ff ff ff       	jmp    d9c <malloc+0x2c>
 e58:	90                   	nop
 e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 e60:	8b 08                	mov    (%eax),%ecx
 e62:	89 0a                	mov    %ecx,(%edx)
 e64:	eb b1                	jmp    e17 <malloc+0xa7>
