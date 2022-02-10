
user/_ezsh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
int getLine(int in, char line[], int max);
char** split(char line[], char delim[], int* count);
char* substr(char* str, int start, int end);
int find(char* str, char delim[], int nth);

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
  11:	81 ec 08 01 00 00    	sub    $0x108,%esp
    if (argc > 1) {
  17:	83 39 01             	cmpl   $0x1,(%ecx)
  1a:	7e 13                	jle    2f <main+0x2f>
			fprintf(2, "ezsh takes no arguments\n");
  1c:	56                   	push   %esi
  1d:	56                   	push   %esi
  1e:	68 bd 0c 00 00       	push   $0xcbd
  23:	6a 02                	push   $0x2
  25:	e8 76 0a 00 00       	call   aa0 <fprintf>
    	exit();
  2a:	e8 03 07 00 00       	call   732 <exit>
		}
    
		int len;
		char line[MAXLINE];
		fprintf(2, "EZ$ ");
  2f:	53                   	push   %ebx
  30:	53                   	push   %ebx
  31:	89 ce                	mov    %ecx,%esi
  33:	68 d6 0c 00 00       	push   $0xcd6
  38:	6a 02                	push   $0x2
  3a:	8d 9d e8 fe ff ff    	lea    -0x118(%ebp),%ebx
  40:	e8 5b 0a 00 00       	call   aa0 <fprintf>
		while ((len = getLine(1, line, MAXLINE)) > 0) {
  45:	83 c4 10             	add    $0x10,%esp
  48:	eb 18                	jmp    62 <main+0x62>
  4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			int waitFlag = 1;
			if (line[strlen(line) - 1] == '&') waitFlag = 0;
			char** args = split(line, " ", &argc);
			if (launch(args, waitFlag) != 0) fprintf(2, "error\n");
			fprintf(2, "EZ$ ");
  50:	83 ec 08             	sub    $0x8,%esp
  53:	68 d6 0c 00 00       	push   $0xcd6
  58:	6a 02                	push   $0x2
  5a:	e8 41 0a 00 00       	call   aa0 <fprintf>
  5f:	83 c4 10             	add    $0x10,%esp
		while ((len = getLine(1, line, MAXLINE)) > 0) {
  62:	83 ec 04             	sub    $0x4,%esp
  65:	68 00 01 00 00       	push   $0x100
  6a:	53                   	push   %ebx
  6b:	6a 01                	push   $0x1
  6d:	e8 de 01 00 00       	call   250 <getLine>
  72:	83 c4 10             	add    $0x10,%esp
  75:	85 c0                	test   %eax,%eax
  77:	7e 4c                	jle    c5 <main+0xc5>
			if (line[strlen(line) - 1] == '&') waitFlag = 0;
  79:	83 ec 0c             	sub    $0xc,%esp
  7c:	53                   	push   %ebx
  7d:	e8 de 04 00 00       	call   560 <strlen>
  82:	83 c4 0c             	add    $0xc,%esp
  85:	80 bc 05 e7 fe ff ff 	cmpb   $0x26,-0x119(%ebp,%eax,1)
  8c:	26 
			char** args = split(line, " ", &argc);
  8d:	56                   	push   %esi
  8e:	68 d9 0c 00 00       	push   $0xcd9
  93:	53                   	push   %ebx
			if (line[strlen(line) - 1] == '&') waitFlag = 0;
  94:	0f 95 c0             	setne  %al
  97:	0f b6 c0             	movzbl %al,%eax
  9a:	89 c7                	mov    %eax,%edi
			char** args = split(line, " ", &argc);
  9c:	e8 7f 03 00 00       	call   420 <split>
			if (launch(args, waitFlag) != 0) fprintf(2, "error\n");
  a1:	5a                   	pop    %edx
  a2:	59                   	pop    %ecx
  a3:	57                   	push   %edi
  a4:	50                   	push   %eax
  a5:	e8 a6 00 00 00       	call   150 <launch>
  aa:	83 c4 10             	add    $0x10,%esp
  ad:	85 c0                	test   %eax,%eax
  af:	74 9f                	je     50 <main+0x50>
  b1:	83 ec 08             	sub    $0x8,%esp
  b4:	68 db 0c 00 00       	push   $0xcdb
  b9:	6a 02                	push   $0x2
  bb:	e8 e0 09 00 00       	call   aa0 <fprintf>
  c0:	83 c4 10             	add    $0x10,%esp
  c3:	eb 8b                	jmp    50 <main+0x50>
		}
		exit();
  c5:	e8 68 06 00 00       	call   732 <exit>
  ca:	66 90                	xchg   %ax,%ax
  cc:	66 90                	xchg   %ax,%ax
  ce:	66 90                	xchg   %ax,%ax

000000d0 <cd>:
// dir of the current process. thus, we have to have
// a built-in command for this because if we used
// 'exec' we could only change the directory that 
// the child process is in, and not actually change 
// the directory that EZ Shell is running in
int cd(char** args) {
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	83 ec 14             	sub    $0x14,%esp
	if (chdir(args[1]) < 0) {
  d6:	8b 45 08             	mov    0x8(%ebp),%eax
  d9:	ff 70 04             	pushl  0x4(%eax)
  dc:	e8 c1 06 00 00       	call   7a2 <chdir>
  e1:	83 c4 10             	add    $0x10,%esp
  e4:	31 d2                	xor    %edx,%edx
  e6:	85 c0                	test   %eax,%eax
  e8:	78 06                	js     f0 <cd+0x20>
		fprintf(2, "could not change directory/");
		return 1;
	}
	return 0;
}
  ea:	89 d0                	mov    %edx,%eax
  ec:	c9                   	leave  
  ed:	c3                   	ret    
  ee:	66 90                	xchg   %ax,%ax
		fprintf(2, "could not change directory/");
  f0:	83 ec 08             	sub    $0x8,%esp
  f3:	68 68 0c 00 00       	push   $0xc68
  f8:	6a 02                	push   $0x2
  fa:	e8 a1 09 00 00       	call   aa0 <fprintf>
  ff:	ba 01 00 00 00       	mov    $0x1,%edx
 104:	83 c4 10             	add    $0x10,%esp
}
 107:	89 d0                	mov    %edx,%eax
 109:	c9                   	leave  
 10a:	c3                   	ret    
 10b:	90                   	nop
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000110 <help>:

int help(char** args) {
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	83 ec 10             	sub    $0x10,%esp
	fprintf(2, "Welcome to the EZ Shell!\n");
 116:	68 84 0c 00 00       	push   $0xc84
 11b:	6a 02                	push   $0x2
 11d:	e8 7e 09 00 00       	call   aa0 <fprintf>
	fprintf(2, "Type in a command and it's parameters.\n");
 122:	58                   	pop    %eax
 123:	5a                   	pop    %edx
 124:	68 e4 0c 00 00       	push   $0xce4
 129:	6a 02                	push   $0x2
 12b:	e8 70 09 00 00       	call   aa0 <fprintf>
	fprintf(2, "We have 'cd' and 'quit' built in.");
 130:	59                   	pop    %ecx
 131:	58                   	pop    %eax
 132:	68 0c 0d 00 00       	push   $0xd0c
 137:	6a 02                	push   $0x2
 139:	e8 62 09 00 00       	call   aa0 <fprintf>
	fprintf(2, " Otherwise, other commands that are available in the regular shell should be available here.\n");
 13e:	58                   	pop    %eax
 13f:	5a                   	pop    %edx
 140:	68 30 0d 00 00       	push   $0xd30
 145:	6a 02                	push   $0x2
 147:	e8 54 09 00 00       	call   aa0 <fprintf>
	return 0;
}
 14c:	31 c0                	xor    %eax,%eax
 14e:	c9                   	leave  
 14f:	c3                   	ret    

00000150 <launch>:
int launch(char** args, int waitFlag) {
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	56                   	push   %esi
 154:	53                   	push   %ebx
 155:	8b 5d 08             	mov    0x8(%ebp),%ebx
 158:	8b 75 0c             	mov    0xc(%ebp),%esi
	if (strcmp(args[0], "cd") == 0) return cd(args);
 15b:	83 ec 08             	sub    $0x8,%esp
 15e:	68 9e 0c 00 00       	push   $0xc9e
 163:	ff 33                	pushl  (%ebx)
 165:	e8 a6 03 00 00       	call   510 <strcmp>
 16a:	83 c4 10             	add    $0x10,%esp
 16d:	85 c0                	test   %eax,%eax
 16f:	74 6f                	je     1e0 <launch+0x90>
	else if (strcmp(args[0], "help") == 0) return help(args);
 171:	83 ec 08             	sub    $0x8,%esp
 174:	68 a1 0c 00 00       	push   $0xca1
 179:	ff 33                	pushl  (%ebx)
 17b:	e8 90 03 00 00       	call   510 <strcmp>
 180:	83 c4 10             	add    $0x10,%esp
 183:	85 c0                	test   %eax,%eax
 185:	74 49                	je     1d0 <launch+0x80>
	else if (strcmp(args[0], "exit") == 0) return quit(args);
 187:	83 ec 08             	sub    $0x8,%esp
 18a:	68 a6 0c 00 00       	push   $0xca6
 18f:	ff 33                	pushl  (%ebx)
 191:	e8 7a 03 00 00       	call   510 <strcmp>
 196:	83 c4 10             	add    $0x10,%esp
 199:	85 c0                	test   %eax,%eax
 19b:	74 77                	je     214 <launch+0xc4>
	else if (strcmp(args[0], "quit") == 0) return quit(args);
 19d:	83 ec 08             	sub    $0x8,%esp
 1a0:	68 ab 0c 00 00       	push   $0xcab
 1a5:	ff 33                	pushl  (%ebx)
 1a7:	e8 64 03 00 00       	call   510 <strcmp>
 1ac:	83 c4 10             	add    $0x10,%esp
 1af:	85 c0                	test   %eax,%eax
 1b1:	74 61                	je     214 <launch+0xc4>
	int pid = fork();
 1b3:	e8 72 05 00 00       	call   72a <fork>
	if (pid < 0) fprintf(2, "fork failed\n");
 1b8:	85 c0                	test   %eax,%eax
 1ba:	78 44                	js     200 <launch+0xb0>
	else if (pid == 0) { // child
 1bc:	74 5b                	je     219 <launch+0xc9>
		if (waitFlag)
 1be:	85 f6                	test   %esi,%esi
 1c0:	75 2e                	jne    1f0 <launch+0xa0>
}
 1c2:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1c5:	31 c0                	xor    %eax,%eax
 1c7:	5b                   	pop    %ebx
 1c8:	5e                   	pop    %esi
 1c9:	5d                   	pop    %ebp
 1ca:	c3                   	ret    
 1cb:	90                   	nop
 1cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	else if (strcmp(args[0], "help") == 0) return help(args);
 1d0:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
 1d3:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1d6:	5b                   	pop    %ebx
 1d7:	5e                   	pop    %esi
 1d8:	5d                   	pop    %ebp
	else if (strcmp(args[0], "help") == 0) return help(args);
 1d9:	e9 32 ff ff ff       	jmp    110 <help>
 1de:	66 90                	xchg   %ax,%ax
	if (strcmp(args[0], "cd") == 0) return cd(args);
 1e0:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
 1e3:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1e6:	5b                   	pop    %ebx
 1e7:	5e                   	pop    %esi
 1e8:	5d                   	pop    %ebp
	if (strcmp(args[0], "cd") == 0) return cd(args);
 1e9:	e9 e2 fe ff ff       	jmp    d0 <cd>
 1ee:	66 90                	xchg   %ax,%ax
			wait();
 1f0:	e8 45 05 00 00       	call   73a <wait>
 1f5:	eb cb                	jmp    1c2 <launch+0x72>
 1f7:	89 f6                	mov    %esi,%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	if (pid < 0) fprintf(2, "fork failed\n");
 200:	83 ec 08             	sub    $0x8,%esp
 203:	68 b0 0c 00 00       	push   $0xcb0
 208:	6a 02                	push   $0x2
 20a:	e8 91 08 00 00       	call   aa0 <fprintf>
 20f:	83 c4 10             	add    $0x10,%esp
 212:	eb ae                	jmp    1c2 <launch+0x72>

int quit(char** args) {
	exit();
 214:	e8 19 05 00 00       	call   732 <exit>
		exec(args[0], args);
 219:	50                   	push   %eax
 21a:	50                   	push   %eax
 21b:	53                   	push   %ebx
 21c:	ff 33                	pushl  (%ebx)
 21e:	e8 47 05 00 00       	call   76a <exec>
		fprintf(2, "exec failed, command not recognized\n");
 223:	5a                   	pop    %edx
 224:	59                   	pop    %ecx
 225:	68 90 0d 00 00       	push   $0xd90
 22a:	6a 02                	push   $0x2
 22c:	e8 6f 08 00 00       	call   aa0 <fprintf>
		exit();
 231:	e8 fc 04 00 00       	call   732 <exit>
 236:	8d 76 00             	lea    0x0(%esi),%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <quit>:
int quit(char** args) {
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	83 ec 08             	sub    $0x8,%esp
	exit();
 246:	e8 e7 04 00 00       	call   732 <exit>
 24b:	90                   	nop
 24c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000250 <getLine>:
	return 1;
}

// gets line of input from "in", puts it in
// line and returns success signal
int getLine(int in, char line[], int max) {
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	56                   	push   %esi
 255:	53                   	push   %ebx
 256:	83 ec 38             	sub    $0x38,%esp
 259:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 25c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int len = strlen(line);
 25f:	53                   	push   %ebx
 260:	e8 fb 02 00 00       	call   560 <strlen>
  memset(line, 0, len);
 265:	83 c4 0c             	add    $0xc,%esp
 268:	50                   	push   %eax
 269:	6a 00                	push   $0x0
 26b:	53                   	push   %ebx
 26c:	e8 1f 03 00 00       	call   590 <memset>
  char c[1];
  int i;
  for (i = 0; i < max - 1; i++) {
 271:	83 c4 10             	add    $0x10,%esp
 274:	83 ff 01             	cmp    $0x1,%edi
 277:	7e 77                	jle    2f0 <getLine+0xa0>
 279:	8d 47 ff             	lea    -0x1(%edi),%eax
 27c:	31 f6                	xor    %esi,%esi
 27e:	8d 7d e7             	lea    -0x19(%ebp),%edi
 281:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 284:	eb 1d                	jmp    2a3 <getLine+0x53>
 286:	8d 76 00             	lea    0x0(%esi),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if (read(in, c, 1) == 0) return strlen(line);
    if (*c == '\n') break;
 290:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 294:	3c 0a                	cmp    $0xa,%al
 296:	74 38                	je     2d0 <getLine+0x80>
    line[i] = *c;
 298:	88 04 33             	mov    %al,(%ebx,%esi,1)
  for (i = 0; i < max - 1; i++) {
 29b:	83 c6 01             	add    $0x1,%esi
 29e:	39 75 d4             	cmp    %esi,-0x2c(%ebp)
 2a1:	74 45                	je     2e8 <getLine+0x98>
    if (read(in, c, 1) == 0) return strlen(line);
 2a3:	83 ec 04             	sub    $0x4,%esp
 2a6:	6a 01                	push   $0x1
 2a8:	57                   	push   %edi
 2a9:	ff 75 08             	pushl  0x8(%ebp)
 2ac:	e8 99 04 00 00       	call   74a <read>
 2b1:	83 c4 10             	add    $0x10,%esp
 2b4:	85 c0                	test   %eax,%eax
 2b6:	75 d8                	jne    290 <getLine+0x40>
 2b8:	83 ec 0c             	sub    $0xc,%esp
 2bb:	53                   	push   %ebx
 2bc:	e8 9f 02 00 00       	call   560 <strlen>
 2c1:	83 c4 10             	add    $0x10,%esp
  }
  line[i + 1] = '\0';
  return 1;
}
 2c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2c7:	5b                   	pop    %ebx
 2c8:	5e                   	pop    %esi
 2c9:	5f                   	pop    %edi
 2ca:	5d                   	pop    %ebp
 2cb:	c3                   	ret    
 2cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2d0:	8d 56 01             	lea    0x1(%esi),%edx
  line[i + 1] = '\0';
 2d3:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
 2d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
 2da:	b8 01 00 00 00       	mov    $0x1,%eax
}
 2df:	5b                   	pop    %ebx
 2e0:	5e                   	pop    %esi
 2e1:	5f                   	pop    %edi
 2e2:	5d                   	pop    %ebp
 2e3:	c3                   	ret    
 2e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2e8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 2eb:	83 c2 01             	add    $0x1,%edx
 2ee:	eb e3                	jmp    2d3 <getLine+0x83>
  for (i = 0; i < max - 1; i++) {
 2f0:	ba 01 00 00 00       	mov    $0x1,%edx
 2f5:	eb dc                	jmp    2d3 <getLine+0x83>
 2f7:	89 f6                	mov    %esi,%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000300 <find>:
	*count = ++index;
	return dst;
}

// finds nth beginning of delim in str, otherwise -1
int find(char* str, char delim[], int nth) {
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	57                   	push   %edi
 304:	56                   	push   %esi
 305:	53                   	push   %ebx
	int i, j;
  for (i = 0; i < strlen(str); i++) {
 306:	31 ff                	xor    %edi,%edi
int find(char* str, char delim[], int nth) {
 308:	83 ec 1c             	sub    $0x1c,%esp
    if (str[i] == delim[0]) {
			for (j = i + 1; j < (i + strlen(delim)); j++) {
				if (str[j] != delim[j - i]) goto out;
 30b:	8b 45 0c             	mov    0xc(%ebp),%eax
int find(char* str, char delim[], int nth) {
 30e:	8b 5d 08             	mov    0x8(%ebp),%ebx
				if (str[j] != delim[j - i]) goto out;
 311:	83 c0 01             	add    $0x1,%eax
 314:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for (i = 0; i < strlen(str); i++) {
 317:	eb 0a                	jmp    323 <find+0x23>
 319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 320:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 323:	83 ec 0c             	sub    $0xc,%esp
 326:	53                   	push   %ebx
 327:	e8 34 02 00 00       	call   560 <strlen>
 32c:	83 c4 10             	add    $0x10,%esp
 32f:	39 f8                	cmp    %edi,%eax
 331:	76 5d                	jbe    390 <find+0x90>
 333:	8d 47 01             	lea    0x1(%edi),%eax
 336:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if (str[i] == delim[0]) {
 339:	8b 45 0c             	mov    0xc(%ebp),%eax
 33c:	0f b6 00             	movzbl (%eax),%eax
 33f:	38 04 3b             	cmp    %al,(%ebx,%edi,1)
 342:	75 dc                	jne    320 <find+0x20>
				if (str[j] != delim[j - i]) goto out;
 344:	8b 45 dc             	mov    -0x24(%ebp),%eax
			for (j = i + 1; j < (i + strlen(delim)); j++) {
 347:	8d 57 01             	lea    0x1(%edi),%edx
 34a:	89 d6                	mov    %edx,%esi
				if (str[j] != delim[j - i]) goto out;
 34c:	29 d0                	sub    %edx,%eax
 34e:	89 45 e0             	mov    %eax,-0x20(%ebp)
 351:	eb 14                	jmp    367 <find+0x67>
 353:	90                   	nop
 354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 358:	8b 45 e0             	mov    -0x20(%ebp),%eax
 35b:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
 35f:	38 04 33             	cmp    %al,(%ebx,%esi,1)
 362:	75 bc                	jne    320 <find+0x20>
			for (j = i + 1; j < (i + strlen(delim)); j++) {
 364:	83 c6 01             	add    $0x1,%esi
 367:	83 ec 0c             	sub    $0xc,%esp
 36a:	ff 75 0c             	pushl  0xc(%ebp)
 36d:	e8 ee 01 00 00       	call   560 <strlen>
 372:	01 f8                	add    %edi,%eax
 374:	83 c4 10             	add    $0x10,%esp
 377:	39 f0                	cmp    %esi,%eax
 379:	77 dd                	ja     358 <find+0x58>
			}
			if (nth-- == 0) return i;
 37b:	8b 45 10             	mov    0x10(%ebp),%eax
 37e:	8b 55 10             	mov    0x10(%ebp),%edx
 381:	83 e8 01             	sub    $0x1,%eax
 384:	85 d2                	test   %edx,%edx
 386:	74 0d                	je     395 <find+0x95>
			out:;
 388:	89 45 10             	mov    %eax,0x10(%ebp)
 38b:	eb 93                	jmp    320 <find+0x20>
 38d:	8d 76 00             	lea    0x0(%esi),%esi
		}
	}
  return -1;
 390:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
 395:	8d 65 f4             	lea    -0xc(%ebp),%esp
 398:	89 f8                	mov    %edi,%eax
 39a:	5b                   	pop    %ebx
 39b:	5e                   	pop    %esi
 39c:	5f                   	pop    %edi
 39d:	5d                   	pop    %ebp
 39e:	c3                   	ret    
 39f:	90                   	nop

000003a0 <substr>:

// returns a copy of str from start to end
char* substr(char* str, int start, int end) {
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
 3a5:	53                   	push   %ebx
 3a6:	83 ec 18             	sub    $0x18,%esp
 3a9:	8b 7d 10             	mov    0x10(%ebp),%edi
 3ac:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	char* dst = malloc(ARGLEN * sizeof(char));
 3af:	6a 14                	push   $0x14
 3b1:	e8 ba 07 00 00       	call   b70 <malloc>
  memset(dst, 0, ARGLEN * sizeof(char));
 3b6:	83 c4 0c             	add    $0xc,%esp
	char* dst = malloc(ARGLEN * sizeof(char));
 3b9:	89 c6                	mov    %eax,%esi
  memset(dst, 0, ARGLEN * sizeof(char));
 3bb:	6a 14                	push   $0x14
 3bd:	6a 00                	push   $0x0
 3bf:	50                   	push   %eax
 3c0:	e8 cb 01 00 00       	call   590 <memset>
  int len = strlen(str);
 3c5:	58                   	pop    %eax
 3c6:	ff 75 08             	pushl  0x8(%ebp)
 3c9:	e8 92 01 00 00       	call   560 <strlen>
 3ce:	83 c4 10             	add    $0x10,%esp
 3d1:	39 f8                	cmp    %edi,%eax
 3d3:	0f 4e f8             	cmovle %eax,%edi
  if (end > len) end = len;
  int s = 0, i = start;
  while (i < end)
 3d6:	39 df                	cmp    %ebx,%edi
 3d8:	7e 36                	jle    410 <substr+0x70>
 3da:	8b 45 08             	mov    0x8(%ebp),%eax
 3dd:	29 df                	sub    %ebx,%edi
  int s = 0, i = start;
 3df:	31 d2                	xor    %edx,%edx
 3e1:	01 c3                	add    %eax,%ebx
 3e3:	90                   	nop
 3e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dst[s++] = str[i++];
 3e8:	83 c2 01             	add    $0x1,%edx
 3eb:	0f b6 44 13 ff       	movzbl -0x1(%ebx,%edx,1),%eax
  while (i < end)
 3f0:	39 fa                	cmp    %edi,%edx
    dst[s++] = str[i++];
 3f2:	88 44 16 ff          	mov    %al,-0x1(%esi,%edx,1)
  while (i < end)
 3f6:	75 f0                	jne    3e8 <substr+0x48>
 3f8:	01 f2                	add    %esi,%edx
  dst[s] = '\0';
	return dst;
 3fa:	89 f0                	mov    %esi,%eax
  dst[s] = '\0';
 3fc:	c6 02 00             	movb   $0x0,(%edx)
 3ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
 402:	5b                   	pop    %ebx
 403:	5e                   	pop    %esi
 404:	5f                   	pop    %edi
 405:	5d                   	pop    %ebp
 406:	c3                   	ret    
 407:	89 f6                	mov    %esi,%esi
 409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	char* dst = malloc(ARGLEN * sizeof(char));
 410:	89 f2                	mov    %esi,%edx
 412:	89 f0                	mov    %esi,%eax
  dst[s] = '\0';
 414:	c6 02 00             	movb   $0x0,(%edx)
 417:	8d 65 f4             	lea    -0xc(%ebp),%esp
 41a:	5b                   	pop    %ebx
 41b:	5e                   	pop    %esi
 41c:	5f                   	pop    %edi
 41d:	5d                   	pop    %ebp
 41e:	c3                   	ret    
 41f:	90                   	nop

00000420 <split>:
char** split(char line[], char delim[], int* count) {
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
  int pos, prevpos = 0, index = 0;
 426:	31 f6                	xor    %esi,%esi
 428:	31 db                	xor    %ebx,%ebx
char** split(char line[], char delim[], int* count) {
 42a:	83 ec 28             	sub    $0x28,%esp
	char** dst = malloc(MAXARGS * sizeof(char*));
 42d:	6a 28                	push   $0x28
 42f:	e8 3c 07 00 00       	call   b70 <malloc>
	while ((pos = find(line, delim, index)) > 0) {
 434:	83 c4 10             	add    $0x10,%esp
	char** dst = malloc(MAXARGS * sizeof(char*));
 437:	89 45 e0             	mov    %eax,-0x20(%ebp)
 43a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
	while ((pos = find(line, delim, index)) > 0) {
 441:	eb 44                	jmp    487 <split+0x67>
 443:	90                   	nop
 444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		char* arg = substr(line, prevpos, pos);
 448:	83 ec 04             	sub    $0x4,%esp
 44b:	57                   	push   %edi
 44c:	53                   	push   %ebx
 44d:	ff 75 08             	pushl  0x8(%ebp)
 450:	e8 4b ff ff ff       	call   3a0 <substr>
		if (strlen(arg) != 0) {
 455:	89 04 24             	mov    %eax,(%esp)
		char* arg = substr(line, prevpos, pos);
 458:	89 c3                	mov    %eax,%ebx
		if (strlen(arg) != 0) {
 45a:	e8 01 01 00 00       	call   560 <strlen>
 45f:	83 c4 10             	add    $0x10,%esp
 462:	85 c0                	test   %eax,%eax
 464:	74 10                	je     476 <split+0x56>
			dst[index] = arg;
 466:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 469:	89 18                	mov    %ebx,(%eax)
 46b:	8b 45 dc             	mov    -0x24(%ebp),%eax
 46e:	89 c6                	mov    %eax,%esi
 470:	83 c0 01             	add    $0x1,%eax
 473:	89 45 dc             	mov    %eax,-0x24(%ebp)
		prevpos = pos + strlen(delim);
 476:	83 ec 0c             	sub    $0xc,%esp
 479:	ff 75 0c             	pushl  0xc(%ebp)
 47c:	e8 df 00 00 00       	call   560 <strlen>
 481:	8d 1c 07             	lea    (%edi,%eax,1),%ebx
 484:	83 c4 10             	add    $0x10,%esp
	while ((pos = find(line, delim, index)) > 0) {
 487:	83 ec 04             	sub    $0x4,%esp
 48a:	56                   	push   %esi
 48b:	ff 75 0c             	pushl  0xc(%ebp)
 48e:	ff 75 08             	pushl  0x8(%ebp)
 491:	e8 6a fe ff ff       	call   300 <find>
 496:	89 c7                	mov    %eax,%edi
 498:	8b 45 e0             	mov    -0x20(%ebp),%eax
 49b:	83 c4 10             	add    $0x10,%esp
 49e:	85 ff                	test   %edi,%edi
 4a0:	8d 04 b0             	lea    (%eax,%esi,4),%eax
 4a3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 4a6:	7f a0                	jg     448 <split+0x28>
	*(dst + index) = substr(line, prevpos, strlen(line));
 4a8:	83 ec 0c             	sub    $0xc,%esp
 4ab:	ff 75 08             	pushl  0x8(%ebp)
 4ae:	e8 ad 00 00 00       	call   560 <strlen>
 4b3:	83 c4 0c             	add    $0xc,%esp
 4b6:	50                   	push   %eax
 4b7:	53                   	push   %ebx
 4b8:	ff 75 08             	pushl  0x8(%ebp)
 4bb:	e8 e0 fe ff ff       	call   3a0 <substr>
 4c0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
	*count = ++index;
 4c3:	8b 4d dc             	mov    -0x24(%ebp),%ecx
	*(dst + index) = substr(line, prevpos, strlen(line));
 4c6:	89 02                	mov    %eax,(%edx)
	*count = ++index;
 4c8:	8b 45 10             	mov    0x10(%ebp),%eax
 4cb:	89 08                	mov    %ecx,(%eax)
}
 4cd:	8b 45 e0             	mov    -0x20(%ebp),%eax
 4d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4d3:	5b                   	pop    %ebx
 4d4:	5e                   	pop    %esi
 4d5:	5f                   	pop    %edi
 4d6:	5d                   	pop    %ebp
 4d7:	c3                   	ret    
 4d8:	66 90                	xchg   %ax,%ax
 4da:	66 90                	xchg   %ax,%ax
 4dc:	66 90                	xchg   %ax,%ax
 4de:	66 90                	xchg   %ax,%ax

000004e0 <strcpy>:
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	53                   	push   %ebx
 4e4:	8b 45 08             	mov    0x8(%ebp),%eax
 4e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 4ea:	89 c2                	mov    %eax,%edx
 4ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4f0:	83 c1 01             	add    $0x1,%ecx
 4f3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 4f7:	83 c2 01             	add    $0x1,%edx
 4fa:	84 db                	test   %bl,%bl
 4fc:	88 5a ff             	mov    %bl,-0x1(%edx)
 4ff:	75 ef                	jne    4f0 <strcpy+0x10>
 501:	5b                   	pop    %ebx
 502:	5d                   	pop    %ebp
 503:	c3                   	ret    
 504:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 50a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000510 <strcmp>:
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	53                   	push   %ebx
 514:	8b 55 08             	mov    0x8(%ebp),%edx
 517:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 51a:	0f b6 02             	movzbl (%edx),%eax
 51d:	0f b6 19             	movzbl (%ecx),%ebx
 520:	84 c0                	test   %al,%al
 522:	75 1c                	jne    540 <strcmp+0x30>
 524:	eb 2a                	jmp    550 <strcmp+0x40>
 526:	8d 76 00             	lea    0x0(%esi),%esi
 529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 530:	83 c2 01             	add    $0x1,%edx
 533:	0f b6 02             	movzbl (%edx),%eax
 536:	83 c1 01             	add    $0x1,%ecx
 539:	0f b6 19             	movzbl (%ecx),%ebx
 53c:	84 c0                	test   %al,%al
 53e:	74 10                	je     550 <strcmp+0x40>
 540:	38 d8                	cmp    %bl,%al
 542:	74 ec                	je     530 <strcmp+0x20>
 544:	29 d8                	sub    %ebx,%eax
 546:	5b                   	pop    %ebx
 547:	5d                   	pop    %ebp
 548:	c3                   	ret    
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 550:	31 c0                	xor    %eax,%eax
 552:	29 d8                	sub    %ebx,%eax
 554:	5b                   	pop    %ebx
 555:	5d                   	pop    %ebp
 556:	c3                   	ret    
 557:	89 f6                	mov    %esi,%esi
 559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000560 <strlen>:
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	8b 4d 08             	mov    0x8(%ebp),%ecx
 566:	80 39 00             	cmpb   $0x0,(%ecx)
 569:	74 15                	je     580 <strlen+0x20>
 56b:	31 d2                	xor    %edx,%edx
 56d:	8d 76 00             	lea    0x0(%esi),%esi
 570:	83 c2 01             	add    $0x1,%edx
 573:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 577:	89 d0                	mov    %edx,%eax
 579:	75 f5                	jne    570 <strlen+0x10>
 57b:	5d                   	pop    %ebp
 57c:	c3                   	ret    
 57d:	8d 76 00             	lea    0x0(%esi),%esi
 580:	31 c0                	xor    %eax,%eax
 582:	5d                   	pop    %ebp
 583:	c3                   	ret    
 584:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 58a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000590 <memset>:
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	57                   	push   %edi
 594:	8b 55 08             	mov    0x8(%ebp),%edx
 597:	8b 4d 10             	mov    0x10(%ebp),%ecx
 59a:	8b 45 0c             	mov    0xc(%ebp),%eax
 59d:	89 d7                	mov    %edx,%edi
 59f:	fc                   	cld    
 5a0:	f3 aa                	rep stos %al,%es:(%edi)
 5a2:	89 d0                	mov    %edx,%eax
 5a4:	5f                   	pop    %edi
 5a5:	5d                   	pop    %ebp
 5a6:	c3                   	ret    
 5a7:	89 f6                	mov    %esi,%esi
 5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005b0 <strchr>:
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	53                   	push   %ebx
 5b4:	8b 45 08             	mov    0x8(%ebp),%eax
 5b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 5ba:	0f b6 10             	movzbl (%eax),%edx
 5bd:	84 d2                	test   %dl,%dl
 5bf:	74 1d                	je     5de <strchr+0x2e>
 5c1:	38 d3                	cmp    %dl,%bl
 5c3:	89 d9                	mov    %ebx,%ecx
 5c5:	75 0d                	jne    5d4 <strchr+0x24>
 5c7:	eb 17                	jmp    5e0 <strchr+0x30>
 5c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5d0:	38 ca                	cmp    %cl,%dl
 5d2:	74 0c                	je     5e0 <strchr+0x30>
 5d4:	83 c0 01             	add    $0x1,%eax
 5d7:	0f b6 10             	movzbl (%eax),%edx
 5da:	84 d2                	test   %dl,%dl
 5dc:	75 f2                	jne    5d0 <strchr+0x20>
 5de:	31 c0                	xor    %eax,%eax
 5e0:	5b                   	pop    %ebx
 5e1:	5d                   	pop    %ebp
 5e2:	c3                   	ret    
 5e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005f0 <gets>:
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	57                   	push   %edi
 5f4:	56                   	push   %esi
 5f5:	53                   	push   %ebx
 5f6:	31 f6                	xor    %esi,%esi
 5f8:	89 f3                	mov    %esi,%ebx
 5fa:	83 ec 1c             	sub    $0x1c,%esp
 5fd:	8b 7d 08             	mov    0x8(%ebp),%edi
 600:	eb 2f                	jmp    631 <gets+0x41>
 602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 608:	8d 45 e7             	lea    -0x19(%ebp),%eax
 60b:	83 ec 04             	sub    $0x4,%esp
 60e:	6a 01                	push   $0x1
 610:	50                   	push   %eax
 611:	6a 00                	push   $0x0
 613:	e8 32 01 00 00       	call   74a <read>
 618:	83 c4 10             	add    $0x10,%esp
 61b:	85 c0                	test   %eax,%eax
 61d:	7e 1c                	jle    63b <gets+0x4b>
 61f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 623:	83 c7 01             	add    $0x1,%edi
 626:	88 47 ff             	mov    %al,-0x1(%edi)
 629:	3c 0a                	cmp    $0xa,%al
 62b:	74 23                	je     650 <gets+0x60>
 62d:	3c 0d                	cmp    $0xd,%al
 62f:	74 1f                	je     650 <gets+0x60>
 631:	83 c3 01             	add    $0x1,%ebx
 634:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 637:	89 fe                	mov    %edi,%esi
 639:	7c cd                	jl     608 <gets+0x18>
 63b:	89 f3                	mov    %esi,%ebx
 63d:	8b 45 08             	mov    0x8(%ebp),%eax
 640:	c6 03 00             	movb   $0x0,(%ebx)
 643:	8d 65 f4             	lea    -0xc(%ebp),%esp
 646:	5b                   	pop    %ebx
 647:	5e                   	pop    %esi
 648:	5f                   	pop    %edi
 649:	5d                   	pop    %ebp
 64a:	c3                   	ret    
 64b:	90                   	nop
 64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 650:	8b 75 08             	mov    0x8(%ebp),%esi
 653:	8b 45 08             	mov    0x8(%ebp),%eax
 656:	01 de                	add    %ebx,%esi
 658:	89 f3                	mov    %esi,%ebx
 65a:	c6 03 00             	movb   $0x0,(%ebx)
 65d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 660:	5b                   	pop    %ebx
 661:	5e                   	pop    %esi
 662:	5f                   	pop    %edi
 663:	5d                   	pop    %ebp
 664:	c3                   	ret    
 665:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000670 <stat>:
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	56                   	push   %esi
 674:	53                   	push   %ebx
 675:	83 ec 08             	sub    $0x8,%esp
 678:	6a 00                	push   $0x0
 67a:	ff 75 08             	pushl  0x8(%ebp)
 67d:	e8 f0 00 00 00       	call   772 <open>
 682:	83 c4 10             	add    $0x10,%esp
 685:	85 c0                	test   %eax,%eax
 687:	78 27                	js     6b0 <stat+0x40>
 689:	83 ec 08             	sub    $0x8,%esp
 68c:	ff 75 0c             	pushl  0xc(%ebp)
 68f:	89 c3                	mov    %eax,%ebx
 691:	50                   	push   %eax
 692:	e8 f3 00 00 00       	call   78a <fstat>
 697:	89 1c 24             	mov    %ebx,(%esp)
 69a:	89 c6                	mov    %eax,%esi
 69c:	e8 b9 00 00 00       	call   75a <close>
 6a1:	83 c4 10             	add    $0x10,%esp
 6a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6a7:	89 f0                	mov    %esi,%eax
 6a9:	5b                   	pop    %ebx
 6aa:	5e                   	pop    %esi
 6ab:	5d                   	pop    %ebp
 6ac:	c3                   	ret    
 6ad:	8d 76 00             	lea    0x0(%esi),%esi
 6b0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 6b5:	eb ed                	jmp    6a4 <stat+0x34>
 6b7:	89 f6                	mov    %esi,%esi
 6b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006c0 <atoi>:
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	53                   	push   %ebx
 6c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
 6c7:	0f be 11             	movsbl (%ecx),%edx
 6ca:	8d 42 d0             	lea    -0x30(%edx),%eax
 6cd:	3c 09                	cmp    $0x9,%al
 6cf:	b8 00 00 00 00       	mov    $0x0,%eax
 6d4:	77 1f                	ja     6f5 <atoi+0x35>
 6d6:	8d 76 00             	lea    0x0(%esi),%esi
 6d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 6e0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 6e3:	83 c1 01             	add    $0x1,%ecx
 6e6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 6ea:	0f be 11             	movsbl (%ecx),%edx
 6ed:	8d 5a d0             	lea    -0x30(%edx),%ebx
 6f0:	80 fb 09             	cmp    $0x9,%bl
 6f3:	76 eb                	jbe    6e0 <atoi+0x20>
 6f5:	5b                   	pop    %ebx
 6f6:	5d                   	pop    %ebp
 6f7:	c3                   	ret    
 6f8:	90                   	nop
 6f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000700 <memmove>:
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	56                   	push   %esi
 704:	53                   	push   %ebx
 705:	8b 5d 10             	mov    0x10(%ebp),%ebx
 708:	8b 45 08             	mov    0x8(%ebp),%eax
 70b:	8b 75 0c             	mov    0xc(%ebp),%esi
 70e:	85 db                	test   %ebx,%ebx
 710:	7e 14                	jle    726 <memmove+0x26>
 712:	31 d2                	xor    %edx,%edx
 714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 718:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 71c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 71f:	83 c2 01             	add    $0x1,%edx
 722:	39 d3                	cmp    %edx,%ebx
 724:	75 f2                	jne    718 <memmove+0x18>
 726:	5b                   	pop    %ebx
 727:	5e                   	pop    %esi
 728:	5d                   	pop    %ebp
 729:	c3                   	ret    

0000072a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 72a:	b8 01 00 00 00       	mov    $0x1,%eax
 72f:	cd 40                	int    $0x40
 731:	c3                   	ret    

00000732 <exit>:
SYSCALL(exit)
 732:	b8 02 00 00 00       	mov    $0x2,%eax
 737:	cd 40                	int    $0x40
 739:	c3                   	ret    

0000073a <wait>:
SYSCALL(wait)
 73a:	b8 03 00 00 00       	mov    $0x3,%eax
 73f:	cd 40                	int    $0x40
 741:	c3                   	ret    

00000742 <pipe>:
SYSCALL(pipe)
 742:	b8 04 00 00 00       	mov    $0x4,%eax
 747:	cd 40                	int    $0x40
 749:	c3                   	ret    

0000074a <read>:
SYSCALL(read)
 74a:	b8 05 00 00 00       	mov    $0x5,%eax
 74f:	cd 40                	int    $0x40
 751:	c3                   	ret    

00000752 <write>:
SYSCALL(write)
 752:	b8 10 00 00 00       	mov    $0x10,%eax
 757:	cd 40                	int    $0x40
 759:	c3                   	ret    

0000075a <close>:
SYSCALL(close)
 75a:	b8 15 00 00 00       	mov    $0x15,%eax
 75f:	cd 40                	int    $0x40
 761:	c3                   	ret    

00000762 <kill>:
SYSCALL(kill)
 762:	b8 06 00 00 00       	mov    $0x6,%eax
 767:	cd 40                	int    $0x40
 769:	c3                   	ret    

0000076a <exec>:
SYSCALL(exec)
 76a:	b8 07 00 00 00       	mov    $0x7,%eax
 76f:	cd 40                	int    $0x40
 771:	c3                   	ret    

00000772 <open>:
SYSCALL(open)
 772:	b8 0f 00 00 00       	mov    $0xf,%eax
 777:	cd 40                	int    $0x40
 779:	c3                   	ret    

0000077a <mknod>:
SYSCALL(mknod)
 77a:	b8 11 00 00 00       	mov    $0x11,%eax
 77f:	cd 40                	int    $0x40
 781:	c3                   	ret    

00000782 <unlink>:
SYSCALL(unlink)
 782:	b8 12 00 00 00       	mov    $0x12,%eax
 787:	cd 40                	int    $0x40
 789:	c3                   	ret    

0000078a <fstat>:
SYSCALL(fstat)
 78a:	b8 08 00 00 00       	mov    $0x8,%eax
 78f:	cd 40                	int    $0x40
 791:	c3                   	ret    

00000792 <link>:
SYSCALL(link)
 792:	b8 13 00 00 00       	mov    $0x13,%eax
 797:	cd 40                	int    $0x40
 799:	c3                   	ret    

0000079a <mkdir>:
SYSCALL(mkdir)
 79a:	b8 14 00 00 00       	mov    $0x14,%eax
 79f:	cd 40                	int    $0x40
 7a1:	c3                   	ret    

000007a2 <chdir>:
SYSCALL(chdir)
 7a2:	b8 09 00 00 00       	mov    $0x9,%eax
 7a7:	cd 40                	int    $0x40
 7a9:	c3                   	ret    

000007aa <dup>:
SYSCALL(dup)
 7aa:	b8 0a 00 00 00       	mov    $0xa,%eax
 7af:	cd 40                	int    $0x40
 7b1:	c3                   	ret    

000007b2 <getpid>:
SYSCALL(getpid)
 7b2:	b8 0b 00 00 00       	mov    $0xb,%eax
 7b7:	cd 40                	int    $0x40
 7b9:	c3                   	ret    

000007ba <sbrk>:
SYSCALL(sbrk)
 7ba:	b8 0c 00 00 00       	mov    $0xc,%eax
 7bf:	cd 40                	int    $0x40
 7c1:	c3                   	ret    

000007c2 <sleep>:
SYSCALL(sleep)
 7c2:	b8 0d 00 00 00       	mov    $0xd,%eax
 7c7:	cd 40                	int    $0x40
 7c9:	c3                   	ret    

000007ca <uptime>:
SYSCALL(uptime)
 7ca:	b8 0e 00 00 00       	mov    $0xe,%eax
 7cf:	cd 40                	int    $0x40
 7d1:	c3                   	ret    

000007d2 <cpuhalt>:
SYSCALL(cpuhalt)
 7d2:	b8 16 00 00 00       	mov    $0x16,%eax
 7d7:	cd 40                	int    $0x40
 7d9:	c3                   	ret    
 7da:	66 90                	xchg   %ax,%ax
 7dc:	66 90                	xchg   %ax,%ax
 7de:	66 90                	xchg   %ax,%ax

000007e0 <printint.constprop.1>:
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	57                   	push   %edi
 7e4:	56                   	push   %esi
 7e5:	53                   	push   %ebx
 7e6:	89 d6                	mov    %edx,%esi
 7e8:	83 ec 3c             	sub    $0x3c,%esp
 7eb:	85 c0                	test   %eax,%eax
 7ed:	79 71                	jns    860 <printint.constprop.1+0x80>
 7ef:	83 e1 01             	and    $0x1,%ecx
 7f2:	74 6c                	je     860 <printint.constprop.1+0x80>
 7f4:	f7 d8                	neg    %eax
 7f6:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 7fd:	31 c9                	xor    %ecx,%ecx
 7ff:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 802:	eb 06                	jmp    80a <printint.constprop.1+0x2a>
 804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 808:	89 f9                	mov    %edi,%ecx
 80a:	31 d2                	xor    %edx,%edx
 80c:	8d 79 01             	lea    0x1(%ecx),%edi
 80f:	f7 f6                	div    %esi
 811:	0f b6 92 c0 0d 00 00 	movzbl 0xdc0(%edx),%edx
 818:	85 c0                	test   %eax,%eax
 81a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
 81d:	75 e9                	jne    808 <printint.constprop.1+0x28>
 81f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 822:	85 c0                	test   %eax,%eax
 824:	74 08                	je     82e <printint.constprop.1+0x4e>
 826:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 82b:	8d 79 02             	lea    0x2(%ecx),%edi
 82e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 838:	0f b6 06             	movzbl (%esi),%eax
 83b:	83 ec 04             	sub    $0x4,%esp
 83e:	83 ee 01             	sub    $0x1,%esi
 841:	6a 01                	push   $0x1
 843:	53                   	push   %ebx
 844:	6a 01                	push   $0x1
 846:	88 45 d7             	mov    %al,-0x29(%ebp)
 849:	e8 04 ff ff ff       	call   752 <write>
 84e:	83 c4 10             	add    $0x10,%esp
 851:	39 de                	cmp    %ebx,%esi
 853:	75 e3                	jne    838 <printint.constprop.1+0x58>
 855:	8d 65 f4             	lea    -0xc(%ebp),%esp
 858:	5b                   	pop    %ebx
 859:	5e                   	pop    %esi
 85a:	5f                   	pop    %edi
 85b:	5d                   	pop    %ebp
 85c:	c3                   	ret    
 85d:	8d 76 00             	lea    0x0(%esi),%esi
 860:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 867:	eb 94                	jmp    7fd <printint.constprop.1+0x1d>
 869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000870 <vprintf.constprop.0>:
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	57                   	push   %edi
 874:	56                   	push   %esi
 875:	53                   	push   %ebx
 876:	89 d6                	mov    %edx,%esi
 878:	83 ec 2c             	sub    $0x2c,%esp
 87b:	0f b6 10             	movzbl (%eax),%edx
 87e:	84 d2                	test   %dl,%dl
 880:	0f 84 cd 00 00 00    	je     953 <vprintf.constprop.0+0xe3>
 886:	8d 58 01             	lea    0x1(%eax),%ebx
 889:	31 ff                	xor    %edi,%edi
 88b:	eb 31                	jmp    8be <vprintf.constprop.0+0x4e>
 88d:	8d 76 00             	lea    0x0(%esi),%esi
 890:	83 f8 25             	cmp    $0x25,%eax
 893:	0f 84 c7 00 00 00    	je     960 <vprintf.constprop.0+0xf0>
 899:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 89c:	83 ec 04             	sub    $0x4,%esp
 89f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 8a2:	6a 01                	push   $0x1
 8a4:	50                   	push   %eax
 8a5:	6a 01                	push   $0x1
 8a7:	e8 a6 fe ff ff       	call   752 <write>
 8ac:	83 c4 10             	add    $0x10,%esp
 8af:	83 c3 01             	add    $0x1,%ebx
 8b2:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 8b6:	84 d2                	test   %dl,%dl
 8b8:	0f 84 95 00 00 00    	je     953 <vprintf.constprop.0+0xe3>
 8be:	85 ff                	test   %edi,%edi
 8c0:	0f b6 c2             	movzbl %dl,%eax
 8c3:	74 cb                	je     890 <vprintf.constprop.0+0x20>
 8c5:	83 ff 25             	cmp    $0x25,%edi
 8c8:	75 e5                	jne    8af <vprintf.constprop.0+0x3f>
 8ca:	83 f8 64             	cmp    $0x64,%eax
 8cd:	8d 7e 04             	lea    0x4(%esi),%edi
 8d0:	b9 01 00 00 00       	mov    $0x1,%ecx
 8d5:	0f 84 9a 00 00 00    	je     975 <vprintf.constprop.0+0x105>
 8db:	83 f8 6c             	cmp    $0x6c,%eax
 8de:	0f 84 8c 00 00 00    	je     970 <vprintf.constprop.0+0x100>
 8e4:	83 f8 78             	cmp    $0x78,%eax
 8e7:	0f 84 a3 00 00 00    	je     990 <vprintf.constprop.0+0x120>
 8ed:	83 f8 70             	cmp    $0x70,%eax
 8f0:	0f 84 ca 00 00 00    	je     9c0 <vprintf.constprop.0+0x150>
 8f6:	83 f8 73             	cmp    $0x73,%eax
 8f9:	0f 84 39 01 00 00    	je     a38 <vprintf.constprop.0+0x1c8>
 8ff:	83 f8 63             	cmp    $0x63,%eax
 902:	0f 84 68 01 00 00    	je     a70 <vprintf.constprop.0+0x200>
 908:	83 f8 25             	cmp    $0x25,%eax
 90b:	0f 84 9f 00 00 00    	je     9b0 <vprintf.constprop.0+0x140>
 911:	8d 45 df             	lea    -0x21(%ebp),%eax
 914:	83 ec 04             	sub    $0x4,%esp
 917:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 91a:	6a 01                	push   $0x1
 91c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 920:	50                   	push   %eax
 921:	6a 01                	push   $0x1
 923:	e8 2a fe ff ff       	call   752 <write>
 928:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 92c:	83 c4 0c             	add    $0xc,%esp
 92f:	8d 45 e0             	lea    -0x20(%ebp),%eax
 932:	6a 01                	push   $0x1
 934:	88 55 e0             	mov    %dl,-0x20(%ebp)
 937:	50                   	push   %eax
 938:	6a 01                	push   $0x1
 93a:	83 c3 01             	add    $0x1,%ebx
 93d:	31 ff                	xor    %edi,%edi
 93f:	e8 0e fe ff ff       	call   752 <write>
 944:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 948:	83 c4 10             	add    $0x10,%esp
 94b:	84 d2                	test   %dl,%dl
 94d:	0f 85 6b ff ff ff    	jne    8be <vprintf.constprop.0+0x4e>
 953:	8d 65 f4             	lea    -0xc(%ebp),%esp
 956:	5b                   	pop    %ebx
 957:	5e                   	pop    %esi
 958:	5f                   	pop    %edi
 959:	5d                   	pop    %ebp
 95a:	c3                   	ret    
 95b:	90                   	nop
 95c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 960:	bf 25 00 00 00       	mov    $0x25,%edi
 965:	e9 45 ff ff ff       	jmp    8af <vprintf.constprop.0+0x3f>
 96a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 970:	8d 7e 04             	lea    0x4(%esi),%edi
 973:	31 c9                	xor    %ecx,%ecx
 975:	8b 06                	mov    (%esi),%eax
 977:	ba 0a 00 00 00       	mov    $0xa,%edx
 97c:	89 fe                	mov    %edi,%esi
 97e:	31 ff                	xor    %edi,%edi
 980:	e8 5b fe ff ff       	call   7e0 <printint.constprop.1>
 985:	e9 25 ff ff ff       	jmp    8af <vprintf.constprop.0+0x3f>
 98a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 990:	8b 06                	mov    (%esi),%eax
 992:	8d 7e 04             	lea    0x4(%esi),%edi
 995:	31 c9                	xor    %ecx,%ecx
 997:	ba 10 00 00 00       	mov    $0x10,%edx
 99c:	89 fe                	mov    %edi,%esi
 99e:	31 ff                	xor    %edi,%edi
 9a0:	e8 3b fe ff ff       	call   7e0 <printint.constprop.1>
 9a5:	e9 05 ff ff ff       	jmp    8af <vprintf.constprop.0+0x3f>
 9aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 9b0:	83 ec 04             	sub    $0x4,%esp
 9b3:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 9b6:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 9b9:	6a 01                	push   $0x1
 9bb:	e9 77 ff ff ff       	jmp    937 <vprintf.constprop.0+0xc7>
 9c0:	8d 46 04             	lea    0x4(%esi),%eax
 9c3:	83 ec 04             	sub    $0x4,%esp
 9c6:	8b 3e                	mov    (%esi),%edi
 9c8:	6a 01                	push   $0x1
 9ca:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 9ce:	be 08 00 00 00       	mov    $0x8,%esi
 9d3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 9d6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 9d9:	50                   	push   %eax
 9da:	6a 01                	push   $0x1
 9dc:	e8 71 fd ff ff       	call   752 <write>
 9e1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 9e4:	83 c4 0c             	add    $0xc,%esp
 9e7:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 9eb:	6a 01                	push   $0x1
 9ed:	50                   	push   %eax
 9ee:	6a 01                	push   $0x1
 9f0:	e8 5d fd ff ff       	call   752 <write>
 9f5:	83 c4 10             	add    $0x10,%esp
 9f8:	90                   	nop
 9f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a00:	89 f8                	mov    %edi,%eax
 a02:	83 ec 04             	sub    $0x4,%esp
 a05:	c1 e7 04             	shl    $0x4,%edi
 a08:	c1 e8 1c             	shr    $0x1c,%eax
 a0b:	6a 01                	push   $0x1
 a0d:	0f b6 80 c0 0d 00 00 	movzbl 0xdc0(%eax),%eax
 a14:	88 45 e5             	mov    %al,-0x1b(%ebp)
 a17:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 a1a:	50                   	push   %eax
 a1b:	6a 01                	push   $0x1
 a1d:	e8 30 fd ff ff       	call   752 <write>
 a22:	83 c4 10             	add    $0x10,%esp
 a25:	83 ee 01             	sub    $0x1,%esi
 a28:	75 d6                	jne    a00 <vprintf.constprop.0+0x190>
 a2a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 a2d:	31 ff                	xor    %edi,%edi
 a2f:	e9 7b fe ff ff       	jmp    8af <vprintf.constprop.0+0x3f>
 a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a38:	8b 3e                	mov    (%esi),%edi
 a3a:	8d 46 04             	lea    0x4(%esi),%eax
 a3d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 a40:	85 ff                	test   %edi,%edi
 a42:	74 50                	je     a94 <vprintf.constprop.0+0x224>
 a44:	0f b6 07             	movzbl (%edi),%eax
 a47:	84 c0                	test   %al,%al
 a49:	74 df                	je     a2a <vprintf.constprop.0+0x1ba>
 a4b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 a4e:	66 90                	xchg   %ax,%ax
 a50:	83 ec 04             	sub    $0x4,%esp
 a53:	83 c7 01             	add    $0x1,%edi
 a56:	88 45 e3             	mov    %al,-0x1d(%ebp)
 a59:	6a 01                	push   $0x1
 a5b:	56                   	push   %esi
 a5c:	6a 01                	push   $0x1
 a5e:	e8 ef fc ff ff       	call   752 <write>
 a63:	0f b6 07             	movzbl (%edi),%eax
 a66:	83 c4 10             	add    $0x10,%esp
 a69:	84 c0                	test   %al,%al
 a6b:	75 e3                	jne    a50 <vprintf.constprop.0+0x1e0>
 a6d:	eb bb                	jmp    a2a <vprintf.constprop.0+0x1ba>
 a6f:	90                   	nop
 a70:	8b 06                	mov    (%esi),%eax
 a72:	83 ec 04             	sub    $0x4,%esp
 a75:	8d 7e 04             	lea    0x4(%esi),%edi
 a78:	6a 01                	push   $0x1
 a7a:	89 fe                	mov    %edi,%esi
 a7c:	31 ff                	xor    %edi,%edi
 a7e:	88 45 e2             	mov    %al,-0x1e(%ebp)
 a81:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 a84:	50                   	push   %eax
 a85:	6a 01                	push   $0x1
 a87:	e8 c6 fc ff ff       	call   752 <write>
 a8c:	83 c4 10             	add    $0x10,%esp
 a8f:	e9 1b fe ff ff       	jmp    8af <vprintf.constprop.0+0x3f>
 a94:	bf b8 0d 00 00       	mov    $0xdb8,%edi
 a99:	b8 28 00 00 00       	mov    $0x28,%eax
 a9e:	eb ab                	jmp    a4b <vprintf.constprop.0+0x1db>

00000aa0 <fprintf>:
 aa0:	55                   	push   %ebp
 aa1:	89 e5                	mov    %esp,%ebp
 aa3:	83 ec 08             	sub    $0x8,%esp
 aa6:	8b 45 0c             	mov    0xc(%ebp),%eax
 aa9:	8d 55 10             	lea    0x10(%ebp),%edx
 aac:	e8 bf fd ff ff       	call   870 <vprintf.constprop.0>
 ab1:	c9                   	leave  
 ab2:	c3                   	ret    
 ab3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ac0 <printf>:
 ac0:	55                   	push   %ebp
 ac1:	89 e5                	mov    %esp,%ebp
 ac3:	83 ec 08             	sub    $0x8,%esp
 ac6:	8b 45 08             	mov    0x8(%ebp),%eax
 ac9:	8d 55 0c             	lea    0xc(%ebp),%edx
 acc:	e8 9f fd ff ff       	call   870 <vprintf.constprop.0>
 ad1:	c9                   	leave  
 ad2:	c3                   	ret    
 ad3:	66 90                	xchg   %ax,%ax
 ad5:	66 90                	xchg   %ax,%ax
 ad7:	66 90                	xchg   %ax,%ax
 ad9:	66 90                	xchg   %ax,%ax
 adb:	66 90                	xchg   %ax,%ax
 add:	66 90                	xchg   %ax,%ax
 adf:	90                   	nop

00000ae0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ae0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ae1:	a1 2c 12 00 00       	mov    0x122c,%eax
{
 ae6:	89 e5                	mov    %esp,%ebp
 ae8:	57                   	push   %edi
 ae9:	56                   	push   %esi
 aea:	53                   	push   %ebx
 aeb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 aee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 af1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 af8:	39 c8                	cmp    %ecx,%eax
 afa:	8b 10                	mov    (%eax),%edx
 afc:	73 32                	jae    b30 <free+0x50>
 afe:	39 d1                	cmp    %edx,%ecx
 b00:	72 04                	jb     b06 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b02:	39 d0                	cmp    %edx,%eax
 b04:	72 32                	jb     b38 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b06:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b09:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 b0c:	39 fa                	cmp    %edi,%edx
 b0e:	74 30                	je     b40 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 b10:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b13:	8b 50 04             	mov    0x4(%eax),%edx
 b16:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b19:	39 f1                	cmp    %esi,%ecx
 b1b:	74 3a                	je     b57 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 b1d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 b1f:	a3 2c 12 00 00       	mov    %eax,0x122c
}
 b24:	5b                   	pop    %ebx
 b25:	5e                   	pop    %esi
 b26:	5f                   	pop    %edi
 b27:	5d                   	pop    %ebp
 b28:	c3                   	ret    
 b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b30:	39 d0                	cmp    %edx,%eax
 b32:	72 04                	jb     b38 <free+0x58>
 b34:	39 d1                	cmp    %edx,%ecx
 b36:	72 ce                	jb     b06 <free+0x26>
{
 b38:	89 d0                	mov    %edx,%eax
 b3a:	eb bc                	jmp    af8 <free+0x18>
 b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 b40:	03 72 04             	add    0x4(%edx),%esi
 b43:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b46:	8b 10                	mov    (%eax),%edx
 b48:	8b 12                	mov    (%edx),%edx
 b4a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b4d:	8b 50 04             	mov    0x4(%eax),%edx
 b50:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b53:	39 f1                	cmp    %esi,%ecx
 b55:	75 c6                	jne    b1d <free+0x3d>
    p->s.size += bp->s.size;
 b57:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 b5a:	a3 2c 12 00 00       	mov    %eax,0x122c
    p->s.size += bp->s.size;
 b5f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b62:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b65:	89 10                	mov    %edx,(%eax)
}
 b67:	5b                   	pop    %ebx
 b68:	5e                   	pop    %esi
 b69:	5f                   	pop    %edi
 b6a:	5d                   	pop    %ebp
 b6b:	c3                   	ret    
 b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b70 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b70:	55                   	push   %ebp
 b71:	89 e5                	mov    %esp,%ebp
 b73:	57                   	push   %edi
 b74:	56                   	push   %esi
 b75:	53                   	push   %ebx
 b76:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b79:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b7c:	8b 15 2c 12 00 00    	mov    0x122c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b82:	8d 78 07             	lea    0x7(%eax),%edi
 b85:	c1 ef 03             	shr    $0x3,%edi
 b88:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 b8b:	85 d2                	test   %edx,%edx
 b8d:	0f 84 9d 00 00 00    	je     c30 <malloc+0xc0>
 b93:	8b 02                	mov    (%edx),%eax
 b95:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 b98:	39 cf                	cmp    %ecx,%edi
 b9a:	76 6c                	jbe    c08 <malloc+0x98>
 b9c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 ba2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 ba7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 baa:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 bb1:	eb 0e                	jmp    bc1 <malloc+0x51>
 bb3:	90                   	nop
 bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bb8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 bba:	8b 48 04             	mov    0x4(%eax),%ecx
 bbd:	39 f9                	cmp    %edi,%ecx
 bbf:	73 47                	jae    c08 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bc1:	39 05 2c 12 00 00    	cmp    %eax,0x122c
 bc7:	89 c2                	mov    %eax,%edx
 bc9:	75 ed                	jne    bb8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 bcb:	83 ec 0c             	sub    $0xc,%esp
 bce:	56                   	push   %esi
 bcf:	e8 e6 fb ff ff       	call   7ba <sbrk>
  if(p == (char*)-1)
 bd4:	83 c4 10             	add    $0x10,%esp
 bd7:	83 f8 ff             	cmp    $0xffffffff,%eax
 bda:	74 1c                	je     bf8 <malloc+0x88>
  hp->s.size = nu;
 bdc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 bdf:	83 ec 0c             	sub    $0xc,%esp
 be2:	83 c0 08             	add    $0x8,%eax
 be5:	50                   	push   %eax
 be6:	e8 f5 fe ff ff       	call   ae0 <free>
  return freep;
 beb:	8b 15 2c 12 00 00    	mov    0x122c,%edx
      if((p = morecore(nunits)) == 0)
 bf1:	83 c4 10             	add    $0x10,%esp
 bf4:	85 d2                	test   %edx,%edx
 bf6:	75 c0                	jne    bb8 <malloc+0x48>
        return 0;
  }
}
 bf8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 bfb:	31 c0                	xor    %eax,%eax
}
 bfd:	5b                   	pop    %ebx
 bfe:	5e                   	pop    %esi
 bff:	5f                   	pop    %edi
 c00:	5d                   	pop    %ebp
 c01:	c3                   	ret    
 c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 c08:	39 cf                	cmp    %ecx,%edi
 c0a:	74 54                	je     c60 <malloc+0xf0>
        p->s.size -= nunits;
 c0c:	29 f9                	sub    %edi,%ecx
 c0e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 c11:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 c14:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 c17:	89 15 2c 12 00 00    	mov    %edx,0x122c
}
 c1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 c20:	83 c0 08             	add    $0x8,%eax
}
 c23:	5b                   	pop    %ebx
 c24:	5e                   	pop    %esi
 c25:	5f                   	pop    %edi
 c26:	5d                   	pop    %ebp
 c27:	c3                   	ret    
 c28:	90                   	nop
 c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 c30:	c7 05 2c 12 00 00 30 	movl   $0x1230,0x122c
 c37:	12 00 00 
 c3a:	c7 05 30 12 00 00 30 	movl   $0x1230,0x1230
 c41:	12 00 00 
    base.s.size = 0;
 c44:	b8 30 12 00 00       	mov    $0x1230,%eax
 c49:	c7 05 34 12 00 00 00 	movl   $0x0,0x1234
 c50:	00 00 00 
 c53:	e9 44 ff ff ff       	jmp    b9c <malloc+0x2c>
 c58:	90                   	nop
 c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 c60:	8b 08                	mov    (%eax),%ecx
 c62:	89 0a                	mov    %ecx,(%edx)
 c64:	eb b1                	jmp    c17 <malloc+0xa7>
