
user/_xvEdit:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
void list(struct File file, char* args);
void show(struct File file, char* args);
void quit(struct File* file);
void bi();

int main(int argc, char* argv[]) {
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	57                   	push   %edi
       e:	56                   	push   %esi
       f:	53                   	push   %ebx
      10:	51                   	push   %ecx
      11:	81 ec 08 08 00 00    	sub    $0x808,%esp
      17:	8b 01                	mov    (%ecx),%eax
      19:	8b 51 04             	mov    0x4(%ecx),%edx
  // arg czeching
  if (argc < 2) {
      1c:	83 f8 01             	cmp    $0x1,%eax
      1f:	0f 8e d8 02 00 00    	jle    2fd <main+0x2fd>
    fprintf(2, "specify a file you want to edit\n");
    exit();
  } else if (argc > 2) {
      25:	83 f8 02             	cmp    $0x2,%eax
      28:	0f 85 cd 01 00 00    	jne    1fb <main+0x1fb>
    fprintf(2, "only specify one file\n");
    exit();
  }
  // prep
  static char buf[MAXLINESIZE] = "";
  char cmdstr[MAXLINESIZE] = "";
      2e:	8d bd 1c f8 ff ff    	lea    -0x7e4(%ebp),%edi
      34:	31 c0                	xor    %eax,%eax
      36:	b9 f9 00 00 00       	mov    $0xf9,%ecx
      3b:	c7 85 18 f8 ff ff 00 	movl   $0x0,-0x7e8(%ebp)
      42:	00 00 00 
  char args[MAXLINESIZE] = "";
      45:	c7 85 00 fc ff ff 00 	movl   $0x0,-0x400(%ebp)
      4c:	00 00 00 
  char cmdstr[MAXLINESIZE] = "";
      4f:	f3 ab                	rep stos %eax,%es:(%edi)
  char args[MAXLINESIZE] = "";
      51:	8d bd 04 fc ff ff    	lea    -0x3fc(%ebp),%edi
      57:	b9 f9 00 00 00       	mov    $0xf9,%ecx
    uint ino;
    short nlink;
    uint size;
  };
  struct File file;
  file.len = 0;
      5c:	c7 85 10 f8 ff ff 00 	movl   $0x0,-0x7f0(%ebp)
      63:	00 00 00 
  file.edited = 0;
      66:	c7 85 14 f8 ff ff 00 	movl   $0x0,-0x7ec(%ebp)
      6d:	00 00 00 
  file.curLine = 0;
      70:	c7 85 08 f8 ff ff 00 	movl   $0x0,-0x7f8(%ebp)
      77:	00 00 00 
  char args[MAXLINESIZE] = "";
      7a:	f3 ab                	rep stos %eax,%es:(%edi)
  file.filename = argv[1];
      7c:	8b 42 04             	mov    0x4(%edx),%eax
      7f:	89 85 00 f8 ff ff    	mov    %eax,-0x800(%ebp)
  file.lines = MakeLinkedList();
      85:	e8 86 04 00 00       	call   510 <MakeLinkedList>
  fprintf(2, "Welcome to xvEdit!\n");
      8a:	51                   	push   %ecx
      8b:	51                   	push   %ecx
      8c:	68 0e 1b 00 00       	push   $0x1b0e
      91:	6a 02                	push   $0x2
  file.lines = MakeLinkedList();
      93:	89 85 0c f8 ff ff    	mov    %eax,-0x7f4(%ebp)
  fprintf(2, "Welcome to xvEdit!\n");
      99:	e8 e2 17 00 00       	call   1880 <fprintf>

  // opening file
  file.fd = open(file.filename, O_RDONLY);
      9e:	5b                   	pop    %ebx
      9f:	5e                   	pop    %esi
      a0:	6a 00                	push   $0x0
      a2:	ff b5 00 f8 ff ff    	pushl  -0x800(%ebp)
      a8:	e8 9d 14 00 00       	call   154a <open>
  if (file.fd == -1) {
      ad:	83 c4 10             	add    $0x10,%esp
  file.fd = open(file.filename, O_RDONLY);
      b0:	89 85 04 f8 ff ff    	mov    %eax,-0x7fc(%ebp)
  if (file.fd == -1) {
      b6:	83 c0 01             	add    $0x1,%eax
      b9:	0f 84 6d 02 00 00    	je     32c <main+0x32c>
    fprintf(2, "creating %s...\n",  file.filename);
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
    close(file.fd);
  } else { 
    // populate Linked List
    gatherLines(&file);
      bf:	8d 85 00 f8 ff ff    	lea    -0x800(%ebp),%eax
      c5:	83 ec 0c             	sub    $0xc,%esp
      c8:	50                   	push   %eax
      c9:	89 85 f4 f7 ff ff    	mov    %eax,-0x80c(%ebp)
      cf:	e8 3c 07 00 00       	call   810 <gatherLines>
    fprintf(2, "%d lines read from %s\n", file.len, file.filename);
      d4:	ff b5 00 f8 ff ff    	pushl  -0x800(%ebp)
      da:	ff b5 10 f8 ff ff    	pushl  -0x7f0(%ebp)
      e0:	68 32 1b 00 00       	push   $0x1b32
      e5:	6a 02                	push   $0x2
      e7:	e8 94 17 00 00       	call   1880 <fprintf>
      ec:	83 c4 20             	add    $0x20,%esp
  }
  close(file.fd);
      ef:	83 ec 0c             	sub    $0xc,%esp
      f2:	ff b5 04 f8 ff ff    	pushl  -0x7fc(%ebp)
      f8:	8d 9d 18 f8 ff ff    	lea    -0x7e8(%ebp),%ebx
      fe:	e8 2f 14 00 00       	call   1532 <close>
     103:	83 c4 10             	add    $0x10,%esp
     106:	8d 76 00             	lea    0x0(%esi),%esi
     109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // xvEdit>
  while (cmd != QUIT) {
    fprintf(2, "xvEdit> ");
     110:	83 ec 08             	sub    $0x8,%esp
     113:	68 49 1b 00 00       	push   $0x1b49
     118:	6a 02                	push   $0x2
     11a:	e8 61 17 00 00       	call   1880 <fprintf>
    memset(buf, 0, nbuf);
     11f:	83 c4 0c             	add    $0xc,%esp
     122:	68 e8 03 00 00       	push   $0x3e8
     127:	6a 00                	push   $0x0
     129:	68 c0 25 00 00       	push   $0x25c0
     12e:	e8 2d 12 00 00       	call   1360 <memset>
    gets(buf, nbuf);
     133:	59                   	pop    %ecx
     134:	5e                   	pop    %esi
     135:	68 e8 03 00 00       	push   $0x3e8
     13a:	68 c0 25 00 00       	push   $0x25c0
     13f:	e8 7c 12 00 00       	call   13c0 <gets>
    
    unline(buf);
     144:	c7 04 24 c0 25 00 00 	movl   $0x25c0,(%esp)
     14b:	e8 20 07 00 00       	call   870 <unline>
    substr(cmdstr, buf, 0, 4);
     150:	6a 04                	push   $0x4
     152:	6a 00                	push   $0x0
     154:	68 c0 25 00 00       	push   $0x25c0
     159:	53                   	push   %ebx
     15a:	e8 c1 07 00 00       	call   920 <substr>
  return atoi(str);
}

void toUpper(char* str) {
  int i = 0;
  while (str[i] != '\0') {
     15f:	0f b6 85 18 f8 ff ff 	movzbl -0x7e8(%ebp),%eax
     166:	83 c4 20             	add    $0x20,%esp
     169:	84 c0                	test   %al,%al
     16b:	74 1a                	je     187 <main+0x187>
     16d:	89 da                	mov    %ebx,%edx
     16f:	90                   	nop
    char c = str[i];
    if (c <= 'z' && c >= 'a')
     170:	8d 48 9f             	lea    -0x61(%eax),%ecx
     173:	80 f9 19             	cmp    $0x19,%cl
     176:	77 05                	ja     17d <main+0x17d>
      str[i] += ('Z' - 'z');
     178:	83 e8 20             	sub    $0x20,%eax
     17b:	88 02                	mov    %al,(%edx)
     17d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     180:	0f b6 02             	movzbl (%edx),%eax
     183:	84 c0                	test   %al,%al
     185:	75 e9                	jne    170 <main+0x170>
    toUpper(cmdstr);
    substr(args, buf, strlen(cmdstr) + 1, strlen(buf));
     187:	83 ec 0c             	sub    $0xc,%esp
     18a:	68 c0 25 00 00       	push   $0x25c0
     18f:	e8 9c 11 00 00       	call   1330 <strlen>
     194:	89 1c 24             	mov    %ebx,(%esp)
     197:	89 c6                	mov    %eax,%esi
     199:	e8 92 11 00 00       	call   1330 <strlen>
     19e:	83 c0 01             	add    $0x1,%eax
     1a1:	56                   	push   %esi
     1a2:	50                   	push   %eax
     1a3:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     1a9:	68 c0 25 00 00       	push   $0x25c0
     1ae:	50                   	push   %eax
     1af:	e8 6c 07 00 00       	call   920 <substr>

    if      (strcmp(cmdstr, "@END") == 0) {cmd = END;}
     1b4:	83 c4 18             	add    $0x18,%esp
     1b7:	68 52 1b 00 00       	push   $0x1b52
     1bc:	53                   	push   %ebx
     1bd:	e8 1e 11 00 00       	call   12e0 <strcmp>
     1c2:	83 c4 10             	add    $0x10,%esp
     1c5:	85 c0                	test   %eax,%eax
     1c7:	75 47                	jne    210 <main+0x210>

// commands
void end(struct File* file, char* args) {
  file->edited = 1;
  char* line = args;
  append(file->lines, line);
     1c9:	8b 85 0c f8 ff ff    	mov    -0x7f4(%ebp),%eax
  atPos->prev = new;
  list->len++;
}

void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     1cf:	8d bd 00 fc ff ff    	lea    -0x400(%ebp),%edi
     1d5:	83 ec 04             	sub    $0x4,%esp
  file->edited = 1;
     1d8:	c7 85 14 f8 ff ff 01 	movl   $0x1,-0x7ec(%ebp)
     1df:	00 00 00 
     1e2:	ff 70 08             	pushl  0x8(%eax)
     1e5:	57                   	push   %edi
     1e6:	50                   	push   %eax
     1e7:	e8 94 03 00 00       	call   580 <insert>
  file->len++;
     1ec:	83 85 10 f8 ff ff 01 	addl   $0x1,-0x7f0(%ebp)
     1f3:	83 c4 10             	add    $0x10,%esp
     1f6:	e9 15 ff ff ff       	jmp    110 <main+0x110>
    fprintf(2, "only specify one file\n");
     1fb:	57                   	push   %edi
     1fc:	57                   	push   %edi
     1fd:	68 f7 1a 00 00       	push   $0x1af7
     202:	6a 02                	push   $0x2
     204:	e8 77 16 00 00       	call   1880 <fprintf>
    exit();
     209:	e8 f4 12 00 00       	call   1502 <exit>
     20e:	66 90                	xchg   %ax,%ax
    else if (strcmp(cmdstr, "ADD<") == 0) {cmd = ADD;}
     210:	83 ec 08             	sub    $0x8,%esp
     213:	68 57 1b 00 00       	push   $0x1b57
     218:	53                   	push   %ebx
     219:	e8 c2 10 00 00       	call   12e0 <strcmp>
     21e:	83 c4 10             	add    $0x10,%esp
     221:	85 c0                	test   %eax,%eax
     223:	0f 84 9c 00 00 00    	je     2c5 <main+0x2c5>
    else if (strcmp(cmdstr, "DROP") == 0) {cmd = DROP;}
     229:	52                   	push   %edx
     22a:	52                   	push   %edx
     22b:	68 5c 1b 00 00       	push   $0x1b5c
     230:	53                   	push   %ebx
     231:	e8 aa 10 00 00       	call   12e0 <strcmp>
     236:	83 c4 10             	add    $0x10,%esp
     239:	85 c0                	test   %eax,%eax
     23b:	0f 84 a0 00 00 00    	je     2e1 <main+0x2e1>
    else if (strcmp(cmdstr, "EDIT") == 0) {cmd = EDIT;}
     241:	50                   	push   %eax
     242:	50                   	push   %eax
     243:	68 61 1b 00 00       	push   $0x1b61
     248:	53                   	push   %ebx
     249:	e8 92 10 00 00       	call   12e0 <strcmp>
     24e:	83 c4 10             	add    $0x10,%esp
     251:	85 c0                	test   %eax,%eax
     253:	0f 84 b7 00 00 00    	je     310 <main+0x310>
    else if (strcmp(cmdstr, "LIST") == 0) {cmd = LIST;}
     259:	50                   	push   %eax
     25a:	50                   	push   %eax
     25b:	68 66 1b 00 00       	push   $0x1b66
     260:	53                   	push   %ebx
     261:	e8 7a 10 00 00       	call   12e0 <strcmp>
     266:	83 c4 10             	add    $0x10,%esp
     269:	85 c0                	test   %eax,%eax
     26b:	0f 84 02 01 00 00    	je     373 <main+0x373>
    else if (strcmp(cmdstr, "SHOW") == 0) {cmd = SHOW;}
     271:	50                   	push   %eax
     272:	50                   	push   %eax
     273:	68 6b 1b 00 00       	push   $0x1b6b
     278:	53                   	push   %ebx
     279:	e8 62 10 00 00       	call   12e0 <strcmp>
     27e:	83 c4 10             	add    $0x10,%esp
     281:	85 c0                	test   %eax,%eax
     283:	0f 85 11 01 00 00    	jne    39a <main+0x39a>
     289:	8b 85 0c f8 ff ff    	mov    -0x7f4(%ebp),%eax
  }
}

void show(struct File file, char* args) {
  struct Node* cur = file.lines->head->next;
  int lineNum = 1;
     28f:	bf 01 00 00 00       	mov    $0x1,%edi
     294:	89 85 f0 f7 ff ff    	mov    %eax,-0x810(%ebp)
  struct Node* cur = file.lines->head->next;
     29a:	8b 00                	mov    (%eax),%eax
     29c:	8b 70 08             	mov    0x8(%eax),%esi
     29f:	eb 14                	jmp    2b5 <main+0x2b5>
  while (cur != file.lines->tail) {
    printl(lineNum, cur->data);
     2a1:	50                   	push   %eax
     2a2:	50                   	push   %eax
     2a3:	ff 76 04             	pushl  0x4(%esi)
     2a6:	57                   	push   %edi
    cur = cur->next;
    lineNum++;
     2a7:	83 c7 01             	add    $0x1,%edi
    printl(lineNum, cur->data);
     2aa:	e8 d1 09 00 00       	call   c80 <printl>
    cur = cur->next;
     2af:	8b 76 08             	mov    0x8(%esi),%esi
    lineNum++;
     2b2:	83 c4 10             	add    $0x10,%esp
  while (cur != file.lines->tail) {
     2b5:	8b 85 f0 f7 ff ff    	mov    -0x810(%ebp),%eax
     2bb:	3b 70 04             	cmp    0x4(%eax),%esi
     2be:	75 e1                	jne    2a1 <main+0x2a1>
     2c0:	e9 4b fe ff ff       	jmp    110 <main+0x110>
      add(&file, args);
     2c5:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     2cb:	52                   	push   %edx
     2cc:	52                   	push   %edx
     2cd:	50                   	push   %eax
     2ce:	ff b5 f4 f7 ff ff    	pushl  -0x80c(%ebp)
     2d4:	e8 37 0a 00 00       	call   d10 <add>
     2d9:	83 c4 10             	add    $0x10,%esp
     2dc:	e9 2f fe ff ff       	jmp    110 <main+0x110>
      drop(&file, args);
     2e1:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     2e7:	51                   	push   %ecx
     2e8:	51                   	push   %ecx
     2e9:	50                   	push   %eax
     2ea:	ff b5 f4 f7 ff ff    	pushl  -0x80c(%ebp)
     2f0:	e8 9b 0a 00 00       	call   d90 <drop>
     2f5:	83 c4 10             	add    $0x10,%esp
     2f8:	e9 13 fe ff ff       	jmp    110 <main+0x110>
    fprintf(2, "specify a file you want to edit\n");
     2fd:	50                   	push   %eax
     2fe:	50                   	push   %eax
     2ff:	68 e8 1c 00 00       	push   $0x1ce8
     304:	6a 02                	push   $0x2
     306:	e8 75 15 00 00       	call   1880 <fprintf>
    exit();
     30b:	e8 f2 11 00 00       	call   1502 <exit>
      edit(&file, args);
     310:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     316:	56                   	push   %esi
     317:	56                   	push   %esi
     318:	50                   	push   %eax
     319:	ff b5 f4 f7 ff ff    	pushl  -0x80c(%ebp)
     31f:	e8 2c 0c 00 00       	call   f50 <edit>
     324:	83 c4 10             	add    $0x10,%esp
     327:	e9 e4 fd ff ff       	jmp    110 <main+0x110>
    fprintf(2, "creating %s...\n",  file.filename);
     32c:	57                   	push   %edi
     32d:	ff b5 00 f8 ff ff    	pushl  -0x800(%ebp)
     333:	68 22 1b 00 00       	push   $0x1b22
     338:	6a 02                	push   $0x2
     33a:	e8 41 15 00 00       	call   1880 <fprintf>
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     33f:	58                   	pop    %eax
     340:	5a                   	pop    %edx
     341:	68 01 02 00 00       	push   $0x201
     346:	ff b5 00 f8 ff ff    	pushl  -0x800(%ebp)
     34c:	e8 f9 11 00 00       	call   154a <open>
    close(file.fd);
     351:	89 04 24             	mov    %eax,(%esp)
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     354:	89 85 04 f8 ff ff    	mov    %eax,-0x7fc(%ebp)
    close(file.fd);
     35a:	e8 d3 11 00 00       	call   1532 <close>
     35f:	8d 85 00 f8 ff ff    	lea    -0x800(%ebp),%eax
     365:	83 c4 10             	add    $0x10,%esp
     368:	89 85 f4 f7 ff ff    	mov    %eax,-0x80c(%ebp)
     36e:	e9 7c fd ff ff       	jmp    ef <main+0xef>
      list(file, args);
     373:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     379:	57                   	push   %edi
     37a:	8b b5 f4 f7 ff ff    	mov    -0x80c(%ebp),%esi
     380:	b9 06 00 00 00       	mov    $0x6,%ecx
     385:	50                   	push   %eax
     386:	83 ec 18             	sub    $0x18,%esp
     389:	89 e7                	mov    %esp,%edi
     38b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
     38d:	e8 6e 0c 00 00       	call   1000 <list>
     392:	83 c4 20             	add    $0x20,%esp
     395:	e9 76 fd ff ff       	jmp    110 <main+0x110>
    else if (strcmp(cmdstr, "QUIT") == 0) {cmd = QUIT;}
     39a:	50                   	push   %eax
     39b:	50                   	push   %eax
     39c:	68 70 1b 00 00       	push   $0x1b70
     3a1:	53                   	push   %ebx
     3a2:	e8 39 0f 00 00       	call   12e0 <strcmp>
     3a7:	83 c4 10             	add    $0x10,%esp
     3aa:	85 c0                	test   %eax,%eax
     3ac:	74 16                	je     3c4 <main+0x3c4>
  fprintf(2, "changes saved\n");
  return;
}

void bi() {
  fprintf(2, "bad input\n");
     3ae:	50                   	push   %eax
     3af:	50                   	push   %eax
     3b0:	68 75 1b 00 00       	push   $0x1b75
     3b5:	6a 02                	push   $0x2
     3b7:	e8 c4 14 00 00       	call   1880 <fprintf>
     3bc:	83 c4 10             	add    $0x10,%esp
     3bf:	e9 4c fd ff ff       	jmp    110 <main+0x110>
      quit(&file);
     3c4:	83 ec 0c             	sub    $0xc,%esp
     3c7:	ff b5 f4 f7 ff ff    	pushl  -0x80c(%ebp)
     3cd:	e8 9e 0d 00 00       	call   1170 <quit>
  close(file.fd);
     3d2:	58                   	pop    %eax
     3d3:	ff b5 04 f8 ff ff    	pushl  -0x7fc(%ebp)
     3d9:	e8 54 11 00 00       	call   1532 <close>
  exit();
     3de:	e8 1f 11 00 00       	call   1502 <exit>
     3e3:	66 90                	xchg   %ax,%ax
     3e5:	66 90                	xchg   %ax,%ax
     3e7:	66 90                	xchg   %ax,%ax
     3e9:	66 90                	xchg   %ax,%ax
     3eb:	66 90                	xchg   %ax,%ax
     3ed:	66 90                	xchg   %ax,%ax
     3ef:	90                   	nop

000003f0 <safestrcpy>:
char* safestrcpy(char *s, const char *t, int n) {
     3f0:	55                   	push   %ebp
     3f1:	89 e5                	mov    %esp,%ebp
     3f3:	56                   	push   %esi
     3f4:	53                   	push   %ebx
     3f5:	8b 4d 10             	mov    0x10(%ebp),%ecx
     3f8:	8b 45 08             	mov    0x8(%ebp),%eax
     3fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  if(n <= 0)
     3fe:	85 c9                	test   %ecx,%ecx
     400:	7e 26                	jle    428 <safestrcpy+0x38>
     402:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
     406:	89 c1                	mov    %eax,%ecx
     408:	eb 17                	jmp    421 <safestrcpy+0x31>
     40a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while(--n > 0 && (*s++ = *t++) != 0)
     410:	83 c2 01             	add    $0x1,%edx
     413:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
     417:	83 c1 01             	add    $0x1,%ecx
     41a:	84 db                	test   %bl,%bl
     41c:	88 59 ff             	mov    %bl,-0x1(%ecx)
     41f:	74 04                	je     425 <safestrcpy+0x35>
     421:	39 f2                	cmp    %esi,%edx
     423:	75 eb                	jne    410 <safestrcpy+0x20>
  *s = 0;
     425:	c6 01 00             	movb   $0x0,(%ecx)
}
     428:	5b                   	pop    %ebx
     429:	5e                   	pop    %esi
     42a:	5d                   	pop    %ebp
     42b:	c3                   	ret    
     42c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000430 <nullNode>:
Node* nullNode(char* data) {
     430:	55                   	push   %ebp
     431:	89 e5                	mov    %esp,%ebp
     433:	83 ec 14             	sub    $0x14,%esp
  struct Node* node = malloc(sizeof(Node));
     436:	6a 0c                	push   $0xc
     438:	e8 13 15 00 00       	call   1950 <malloc>
  node->data = data;
     43d:	8b 55 08             	mov    0x8(%ebp),%edx
  node->prev = nullptr;
     440:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->next = nullptr;
     446:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  node->data = data;
     44d:	89 50 04             	mov    %edx,0x4(%eax)
}
     450:	c9                   	leave  
     451:	c3                   	ret    
     452:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000460 <nodeAt>:
Node* nodeAt(struct LinkedList* list, int pos) {
     460:	55                   	push   %ebp
     461:	89 e5                	mov    %esp,%ebp
     463:	53                   	push   %ebx
     464:	8b 45 08             	mov    0x8(%ebp),%eax
     467:	8b 55 0c             	mov    0xc(%ebp),%edx
  if (pos > list->len)
     46a:	8b 48 08             	mov    0x8(%eax),%ecx
     46d:	39 d1                	cmp    %edx,%ecx
     46f:	7c 1f                	jl     490 <nodeAt+0x30>
  if ((pos < 0) && ((0 - pos) > list->len))
     471:	85 d2                	test   %edx,%edx
     473:	78 2b                	js     4a0 <nodeAt+0x40>
    curNode = list->head->next;
     475:	8b 00                	mov    (%eax),%eax
     477:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     47a:	74 0e                	je     48a <nodeAt+0x2a>
    int cur = 0;
     47c:	31 c9                	xor    %ecx,%ecx
     47e:	66 90                	xchg   %ax,%ax
      cur++;
     480:	83 c1 01             	add    $0x1,%ecx
      curNode = curNode->next;
     483:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     486:	39 ca                	cmp    %ecx,%edx
     488:	75 f6                	jne    480 <nodeAt+0x20>
}
     48a:	5b                   	pop    %ebx
     48b:	5d                   	pop    %ebp
     48c:	c3                   	ret    
     48d:	8d 76 00             	lea    0x0(%esi),%esi
    return list->tail->prev;
     490:	8b 40 04             	mov    0x4(%eax),%eax
}
     493:	5b                   	pop    %ebx
     494:	5d                   	pop    %ebp
    return list->tail->prev;
     495:	8b 00                	mov    (%eax),%eax
}
     497:	c3                   	ret    
     498:	90                   	nop
     499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if ((pos < 0) && ((0 - pos) > list->len))
     4a0:	89 d3                	mov    %edx,%ebx
     4a2:	f7 db                	neg    %ebx
     4a4:	39 d9                	cmp    %ebx,%ecx
     4a6:	7c 18                	jl     4c0 <nodeAt+0x60>
    while (++pos != 0)
     4a8:	83 c2 01             	add    $0x1,%edx
    curNode = list->tail;
     4ab:	8b 40 04             	mov    0x4(%eax),%eax
    while (++pos != 0)
     4ae:	74 da                	je     48a <nodeAt+0x2a>
     4b0:	83 c2 01             	add    $0x1,%edx
      curNode = curNode->prev;
     4b3:	8b 00                	mov    (%eax),%eax
    while (++pos != 0)
     4b5:	75 f9                	jne    4b0 <nodeAt+0x50>
}
     4b7:	5b                   	pop    %ebx
     4b8:	5d                   	pop    %ebp
     4b9:	c3                   	ret    
     4ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return list->head->next;
     4c0:	8b 00                	mov    (%eax),%eax
     4c2:	8b 40 08             	mov    0x8(%eax),%eax
     4c5:	eb c3                	jmp    48a <nodeAt+0x2a>
     4c7:	89 f6                	mov    %esi,%esi
     4c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004d0 <destroyNode>:
void destroyNode(struct LinkedList* list, struct Node* self) {
     4d0:	55                   	push   %ebp
     4d1:	89 e5                	mov    %esp,%ebp
     4d3:	56                   	push   %esi
     4d4:	53                   	push   %ebx
     4d5:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     4d8:	8b 75 08             	mov    0x8(%ebp),%esi
    free(self->data);
     4db:	83 ec 0c             	sub    $0xc,%esp
    self->prev->next = self->next;
     4de:	8b 03                	mov    (%ebx),%eax
     4e0:	8b 53 08             	mov    0x8(%ebx),%edx
     4e3:	89 50 08             	mov    %edx,0x8(%eax)
    self->next->prev = self->prev;
     4e6:	8b 43 08             	mov    0x8(%ebx),%eax
     4e9:	8b 13                	mov    (%ebx),%edx
     4eb:	89 10                	mov    %edx,(%eax)
    free(self->data);
     4ed:	ff 73 04             	pushl  0x4(%ebx)
     4f0:	e8 cb 13 00 00       	call   18c0 <free>
    free(self);
     4f5:	89 1c 24             	mov    %ebx,(%esp)
     4f8:	e8 c3 13 00 00       	call   18c0 <free>
    list->len--;
     4fd:	83 6e 08 01          	subl   $0x1,0x8(%esi)
}
     501:	83 c4 10             	add    $0x10,%esp
     504:	8d 65 f8             	lea    -0x8(%ebp),%esp
     507:	5b                   	pop    %ebx
     508:	5e                   	pop    %esi
     509:	5d                   	pop    %ebp
     50a:	c3                   	ret    
     50b:	90                   	nop
     50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000510 <MakeLinkedList>:
LinkedList* MakeLinkedList() {
     510:	55                   	push   %ebp
     511:	89 e5                	mov    %esp,%ebp
     513:	56                   	push   %esi
     514:	53                   	push   %ebx
  struct LinkedList* list = malloc(sizeof(LinkedList));
     515:	83 ec 0c             	sub    $0xc,%esp
     518:	6a 0c                	push   $0xc
     51a:	e8 31 14 00 00       	call   1950 <malloc>
  struct Node* node = malloc(sizeof(Node));
     51f:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  struct LinkedList* list = malloc(sizeof(LinkedList));
     526:	89 c6                	mov    %eax,%esi
  struct Node* node = malloc(sizeof(Node));
     528:	e8 23 14 00 00       	call   1950 <malloc>
     52d:	89 c3                	mov    %eax,%ebx
  node->prev = nullptr;
     52f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->data = data;
     535:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  node->next = nullptr;
     53c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  struct Node* node = malloc(sizeof(Node));
     543:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     54a:	e8 01 14 00 00       	call   1950 <malloc>
  node->data = data;
     54f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  head->next = tail;
     556:	89 43 08             	mov    %eax,0x8(%ebx)
  head->prev = nullptr;
     559:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  tail->prev = head;
     55f:	89 18                	mov    %ebx,(%eax)
  tail->next = nullptr;
     561:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  list->tail = tail;
     568:	89 46 04             	mov    %eax,0x4(%esi)
}
     56b:	89 f0                	mov    %esi,%eax
  list->len = 0;
     56d:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
  list->head = head;
     574:	89 1e                	mov    %ebx,(%esi)
}
     576:	8d 65 f8             	lea    -0x8(%ebp),%esp
     579:	5b                   	pop    %ebx
     57a:	5e                   	pop    %esi
     57b:	5d                   	pop    %ebp
     57c:	c3                   	ret    
     57d:	8d 76 00             	lea    0x0(%esi),%esi

00000580 <insert>:
void insert(struct LinkedList* list, char* data, int pos) {
     580:	55                   	push   %ebp
     581:	89 e5                	mov    %esp,%ebp
     583:	57                   	push   %edi
     584:	56                   	push   %esi
     585:	53                   	push   %ebx
     586:	83 ec 0c             	sub    $0xc,%esp
  struct Node* atPos = nodeAt(list, pos);
     589:	ff 75 10             	pushl  0x10(%ebp)
     58c:	ff 75 08             	pushl  0x8(%ebp)
void insert(struct LinkedList* list, char* data, int pos) {
     58f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct Node* atPos = nodeAt(list, pos);
     592:	e8 c9 fe ff ff       	call   460 <nodeAt>
     597:	83 ec 04             	sub    $0x4,%esp
     59a:	89 c6                	mov    %eax,%esi
  char* newData = (char*)malloc(sizeof(char) * 1000);
     59c:	68 e8 03 00 00       	push   $0x3e8
     5a1:	e8 aa 13 00 00       	call   1950 <malloc>
     5a6:	8d 8b e7 03 00 00    	lea    0x3e7(%ebx),%ecx
     5ac:	89 c7                	mov    %eax,%edi
     5ae:	83 c4 10             	add    $0x10,%esp
     5b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(--n > 0 && (*s++ = *t++) != 0)
     5b8:	83 c3 01             	add    $0x1,%ebx
     5bb:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     5bf:	83 c0 01             	add    $0x1,%eax
     5c2:	84 d2                	test   %dl,%dl
     5c4:	88 50 ff             	mov    %dl,-0x1(%eax)
     5c7:	74 04                	je     5cd <insert+0x4d>
     5c9:	39 d9                	cmp    %ebx,%ecx
     5cb:	75 eb                	jne    5b8 <insert+0x38>
  struct Node* new = malloc(sizeof(Node));
     5cd:	83 ec 0c             	sub    $0xc,%esp
  *s = 0;
     5d0:	c6 00 00             	movb   $0x0,(%eax)
  struct Node* new = malloc(sizeof(Node));
     5d3:	6a 0c                	push   $0xc
     5d5:	e8 76 13 00 00       	call   1950 <malloc>
  new->data = newData;
     5da:	89 78 04             	mov    %edi,0x4(%eax)
  new->prev = atPos->prev;
     5dd:	8b 16                	mov    (%esi),%edx
  new->next = atPos;
     5df:	89 70 08             	mov    %esi,0x8(%eax)
  new->prev = atPos->prev;
     5e2:	89 10                	mov    %edx,(%eax)
  new->prev->next = new;
     5e4:	89 42 08             	mov    %eax,0x8(%edx)
  atPos->prev = new;
     5e7:	89 06                	mov    %eax,(%esi)
  list->len++;
     5e9:	8b 45 08             	mov    0x8(%ebp),%eax
     5ec:	83 40 08 01          	addl   $0x1,0x8(%eax)
}
     5f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5f3:	5b                   	pop    %ebx
     5f4:	5e                   	pop    %esi
     5f5:	5f                   	pop    %edi
     5f6:	5d                   	pop    %ebp
     5f7:	c3                   	ret    
     5f8:	90                   	nop
     5f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000600 <prepend>:
void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
     600:	55                   	push   %ebp
     601:	89 e5                	mov    %esp,%ebp
     603:	83 ec 0c             	sub    $0xc,%esp
     606:	6a 00                	push   $0x0
     608:	ff 75 0c             	pushl  0xc(%ebp)
     60b:	ff 75 08             	pushl  0x8(%ebp)
     60e:	e8 6d ff ff ff       	call   580 <insert>
     613:	83 c4 10             	add    $0x10,%esp
     616:	c9                   	leave  
     617:	c3                   	ret    
     618:	90                   	nop
     619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000620 <append>:
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     620:	55                   	push   %ebp
     621:	89 e5                	mov    %esp,%ebp
     623:	83 ec 0c             	sub    $0xc,%esp
     626:	8b 45 08             	mov    0x8(%ebp),%eax
     629:	ff 70 08             	pushl  0x8(%eax)
     62c:	ff 75 0c             	pushl  0xc(%ebp)
     62f:	50                   	push   %eax
     630:	e8 4b ff ff ff       	call   580 <insert>
     635:	83 c4 10             	add    $0x10,%esp
     638:	c9                   	leave  
     639:	c3                   	ret    
     63a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000640 <destroyLinkedList>:

void destroyLinkedList(struct LinkedList* list) {
     640:	55                   	push   %ebp
     641:	89 e5                	mov    %esp,%ebp
     643:	56                   	push   %esi
     644:	53                   	push   %ebx
     645:	8b 75 08             	mov    0x8(%ebp),%esi
  struct Node* curNode = list->head;
     648:	8b 1e                	mov    (%esi),%ebx
  while (curNode != list->tail) {
     64a:	8b 46 04             	mov    0x4(%esi),%eax
     64d:	39 c3                	cmp    %eax,%ebx
     64f:	74 29                	je     67a <destroyLinkedList+0x3a>
     651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
     658:	8b 5b 08             	mov    0x8(%ebx),%ebx
    free(curNode->prev->data);
     65b:	83 ec 0c             	sub    $0xc,%esp
     65e:	8b 03                	mov    (%ebx),%eax
     660:	ff 70 04             	pushl  0x4(%eax)
     663:	e8 58 12 00 00       	call   18c0 <free>
    free(curNode->prev);
     668:	58                   	pop    %eax
     669:	ff 33                	pushl  (%ebx)
     66b:	e8 50 12 00 00       	call   18c0 <free>
  while (curNode != list->tail) {
     670:	8b 46 04             	mov    0x4(%esi),%eax
     673:	83 c4 10             	add    $0x10,%esp
     676:	39 d8                	cmp    %ebx,%eax
     678:	75 de                	jne    658 <destroyLinkedList+0x18>
  }
  free(curNode);
     67a:	83 ec 0c             	sub    $0xc,%esp
     67d:	50                   	push   %eax
     67e:	e8 3d 12 00 00       	call   18c0 <free>
  free(list);
     683:	89 75 08             	mov    %esi,0x8(%ebp)
     686:	83 c4 10             	add    $0x10,%esp
     689:	8d 65 f8             	lea    -0x8(%ebp),%esp
     68c:	5b                   	pop    %ebx
     68d:	5e                   	pop    %esi
     68e:	5d                   	pop    %ebp
  free(list);
     68f:	e9 2c 12 00 00       	jmp    18c0 <free>
     694:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     69a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000006a0 <confirmation>:
int confirmation() {
     6a0:	55                   	push   %ebp
     6a1:	89 e5                	mov    %esp,%ebp
     6a3:	53                   	push   %ebx
  memset(buf, 0, nbuf);
     6a4:	8d 9d 10 fc ff ff    	lea    -0x3f0(%ebp),%ebx
int confirmation() {
     6aa:	81 ec f8 03 00 00    	sub    $0x3f8,%esp
  memset(buf, 0, nbuf);
     6b0:	68 e8 03 00 00       	push   $0x3e8
     6b5:	6a 00                	push   $0x0
     6b7:	53                   	push   %ebx
     6b8:	e8 a3 0c 00 00       	call   1360 <memset>
  gets(buf, nbuf);
     6bd:	58                   	pop    %eax
     6be:	5a                   	pop    %edx
     6bf:	68 e8 03 00 00       	push   $0x3e8
     6c4:	53                   	push   %ebx
     6c5:	e8 f6 0c 00 00       	call   13c0 <gets>
  switch (buf[0]) {
     6ca:	0f b6 85 10 fc ff ff 	movzbl -0x3f0(%ebp),%eax
     6d1:	83 c4 10             	add    $0x10,%esp
     6d4:	3c 59                	cmp    $0x59,%al
     6d6:	74 18                	je     6f0 <confirmation+0x50>
     6d8:	3c 79                	cmp    $0x79,%al
     6da:	74 14                	je     6f0 <confirmation+0x50>
    return 1;
     6dc:	b8 01 00 00 00       	mov    $0x1,%eax
}
     6e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     6e4:	c9                   	leave  
     6e5:	c3                   	ret    
     6e6:	8d 76 00             	lea    0x0(%esi),%esi
     6e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return 0;
     6f0:	31 c0                	xor    %eax,%eax
}
     6f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     6f5:	c9                   	leave  
     6f6:	c3                   	ret    
     6f7:	89 f6                	mov    %esi,%esi
     6f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000700 <normalizeRange>:
int normalizeRange(File file, int* sp, int* ep) {
     700:	55                   	push   %ebp
     701:	89 e5                	mov    %esp,%ebp
     703:	53                   	push   %ebx
     704:	8b 4d 24             	mov    0x24(%ebp),%ecx
  int l = file.len;
     707:	8b 45 18             	mov    0x18(%ebp),%eax
int normalizeRange(File file, int* sp, int* ep) {
     70a:	8b 5d 20             	mov    0x20(%ebp),%ebx
  if (*ep > l) *ep = l;
     70d:	8b 11                	mov    (%ecx),%edx
     70f:	39 c2                	cmp    %eax,%edx
     711:	7e 45                	jle    758 <normalizeRange+0x58>
     713:	89 01                	mov    %eax,(%ecx)
     715:	89 c2                	mov    %eax,%edx
  if (*ep < 1) *ep = 1;
     717:	85 d2                	test   %edx,%edx
     719:	7f 06                	jg     721 <normalizeRange+0x21>
     71b:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)
  if (*sp > l) *sp = l;
     721:	8b 13                	mov    (%ebx),%edx
     723:	39 c2                	cmp    %eax,%edx
     725:	7e 21                	jle    748 <normalizeRange+0x48>
     727:	89 03                	mov    %eax,(%ebx)
     729:	89 c2                	mov    %eax,%edx
  if (*sp < 1) *sp = 1;
     72b:	85 d2                	test   %edx,%edx
     72d:	7f 0b                	jg     73a <normalizeRange+0x3a>
     72f:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
     735:	ba 01 00 00 00       	mov    $0x1,%edx
  if ((*ep - *sp) < 0)
     73a:	8b 01                	mov    (%ecx),%eax
}
     73c:	5b                   	pop    %ebx
     73d:	5d                   	pop    %ebp
  if ((*ep - *sp) < 0)
     73e:	29 d0                	sub    %edx,%eax
     740:	c1 e8 1f             	shr    $0x1f,%eax
}
     743:	c3                   	ret    
     744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*sp < 1) *sp += l + 1;
     748:	85 d2                	test   %edx,%edx
     74a:	7f ee                	jg     73a <normalizeRange+0x3a>
     74c:	8d 54 10 01          	lea    0x1(%eax,%edx,1),%edx
     750:	89 13                	mov    %edx,(%ebx)
     752:	eb d7                	jmp    72b <normalizeRange+0x2b>
     754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*ep < 1) *ep += l + 1;
     758:	85 d2                	test   %edx,%edx
     75a:	7f c5                	jg     721 <normalizeRange+0x21>
     75c:	8d 54 02 01          	lea    0x1(%edx,%eax,1),%edx
     760:	89 11                	mov    %edx,(%ecx)
     762:	eb b3                	jmp    717 <normalizeRange+0x17>
     764:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     76a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000770 <numLines>:
int numLines(int start, int end) {
     770:	55                   	push   %ebp
     771:	89 e5                	mov    %esp,%ebp
  return (end - start) + 1;
     773:	8b 45 0c             	mov    0xc(%ebp),%eax
     776:	2b 45 08             	sub    0x8(%ebp),%eax
}
     779:	5d                   	pop    %ebp
  return (end - start) + 1;
     77a:	83 c0 01             	add    $0x1,%eax
}
     77d:	c3                   	ret    
     77e:	66 90                	xchg   %ax,%ax

00000780 <getLine>:
int getLine(int fileptr, char line[]) {
     780:	55                   	push   %ebp
     781:	89 e5                	mov    %esp,%ebp
     783:	57                   	push   %edi
     784:	56                   	push   %esi
     785:	53                   	push   %ebx
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     786:	31 ff                	xor    %edi,%edi
     788:	8d 75 e7             	lea    -0x19(%ebp),%esi
int getLine(int fileptr, char line[]) {
     78b:	83 ec 28             	sub    $0x28,%esp
     78e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int len = strlen(line);
     791:	53                   	push   %ebx
     792:	e8 99 0b 00 00       	call   1330 <strlen>
  memset(line, 0, len);
     797:	83 c4 0c             	add    $0xc,%esp
     79a:	50                   	push   %eax
     79b:	6a 00                	push   $0x0
     79d:	53                   	push   %ebx
     79e:	e8 bd 0b 00 00       	call   1360 <memset>
     7a3:	83 c4 10             	add    $0x10,%esp
     7a6:	eb 1e                	jmp    7c6 <getLine+0x46>
     7a8:	90                   	nop
     7a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (*c == '\n') break;
     7b0:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     7b4:	3c 0a                	cmp    $0xa,%al
     7b6:	74 38                	je     7f0 <getLine+0x70>
    line[i] = *c;
     7b8:	88 04 3b             	mov    %al,(%ebx,%edi,1)
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     7bb:	83 c7 01             	add    $0x1,%edi
     7be:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
     7c4:	74 42                	je     808 <getLine+0x88>
    if (read(fileptr, c, 1) == 0) return strlen(line);
     7c6:	83 ec 04             	sub    $0x4,%esp
     7c9:	6a 01                	push   $0x1
     7cb:	56                   	push   %esi
     7cc:	ff 75 08             	pushl  0x8(%ebp)
     7cf:	e8 46 0d 00 00       	call   151a <read>
     7d4:	83 c4 10             	add    $0x10,%esp
     7d7:	85 c0                	test   %eax,%eax
     7d9:	75 d5                	jne    7b0 <getLine+0x30>
     7db:	83 ec 0c             	sub    $0xc,%esp
     7de:	53                   	push   %ebx
     7df:	e8 4c 0b 00 00       	call   1330 <strlen>
     7e4:	83 c4 10             	add    $0x10,%esp
}
     7e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7ea:	5b                   	pop    %ebx
     7eb:	5e                   	pop    %esi
     7ec:	5f                   	pop    %edi
     7ed:	5d                   	pop    %ebp
     7ee:	c3                   	ret    
     7ef:	90                   	nop
     7f0:	8d 57 01             	lea    0x1(%edi),%edx
  line[i + 1] = '\0';
     7f3:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
     7f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
     7fa:	b8 01 00 00 00       	mov    $0x1,%eax
}
     7ff:	5b                   	pop    %ebx
     800:	5e                   	pop    %esi
     801:	5f                   	pop    %edi
     802:	5d                   	pop    %ebp
     803:	c3                   	ret    
     804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     808:	ba e8 03 00 00       	mov    $0x3e8,%edx
     80d:	eb e4                	jmp    7f3 <getLine+0x73>
     80f:	90                   	nop

00000810 <gatherLines>:
void gatherLines(File* file) {
     810:	55                   	push   %ebp
     811:	89 e5                	mov    %esp,%ebp
     813:	56                   	push   %esi
     814:	53                   	push   %ebx
     815:	8d b5 10 fc ff ff    	lea    -0x3f0(%ebp),%esi
     81b:	81 ec f0 03 00 00    	sub    $0x3f0,%esp
     821:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while (getLine(file->fd, line)) {
     824:	eb 21                	jmp    847 <gatherLines+0x37>
     826:	8d 76 00             	lea    0x0(%esi),%esi
     829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    append(file->lines, line);
     830:	8b 43 0c             	mov    0xc(%ebx),%eax
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     833:	83 ec 04             	sub    $0x4,%esp
     836:	ff 70 08             	pushl  0x8(%eax)
     839:	56                   	push   %esi
     83a:	50                   	push   %eax
     83b:	e8 40 fd ff ff       	call   580 <insert>
    file->len++;
     840:	83 43 10 01          	addl   $0x1,0x10(%ebx)
     844:	83 c4 10             	add    $0x10,%esp
  while (getLine(file->fd, line)) {
     847:	83 ec 08             	sub    $0x8,%esp
     84a:	56                   	push   %esi
     84b:	ff 73 04             	pushl  0x4(%ebx)
     84e:	e8 2d ff ff ff       	call   780 <getLine>
     853:	83 c4 10             	add    $0x10,%esp
     856:	85 c0                	test   %eax,%eax
     858:	75 d6                	jne    830 <gatherLines+0x20>
}
     85a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     85d:	5b                   	pop    %ebx
     85e:	5e                   	pop    %esi
     85f:	5d                   	pop    %ebp
     860:	c3                   	ret    
     861:	eb 0d                	jmp    870 <unline>
     863:	90                   	nop
     864:	90                   	nop
     865:	90                   	nop
     866:	90                   	nop
     867:	90                   	nop
     868:	90                   	nop
     869:	90                   	nop
     86a:	90                   	nop
     86b:	90                   	nop
     86c:	90                   	nop
     86d:	90                   	nop
     86e:	90                   	nop
     86f:	90                   	nop

00000870 <unline>:
void unline(char* str) {
     870:	55                   	push   %ebp
     871:	89 e5                	mov    %esp,%ebp
     873:	53                   	push   %ebx
     874:	83 ec 10             	sub    $0x10,%esp
     877:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str) - 1;
     87a:	53                   	push   %ebx
     87b:	e8 b0 0a 00 00       	call   1330 <strlen>
     880:	8d 50 ff             	lea    -0x1(%eax),%edx
  for (; len > 0; len--) {
     883:	83 c4 10             	add    $0x10,%esp
     886:	85 d2                	test   %edx,%edx
     888:	7e 36                	jle    8c0 <unline+0x50>
    if (c == '\n')
     88a:	80 7c 03 ff 0a       	cmpb   $0xa,-0x1(%ebx,%eax,1)
     88f:	74 2f                	je     8c0 <unline+0x50>
     891:	8d 44 03 fe          	lea    -0x2(%ebx,%eax,1),%eax
     895:	eb 12                	jmp    8a9 <unline+0x39>
     897:	89 f6                	mov    %esi,%esi
     899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     8a0:	83 e8 01             	sub    $0x1,%eax
     8a3:	80 78 01 0a          	cmpb   $0xa,0x1(%eax)
     8a7:	74 06                	je     8af <unline+0x3f>
  for (; len > 0; len--) {
     8a9:	39 c3                	cmp    %eax,%ebx
     8ab:	89 c2                	mov    %eax,%edx
     8ad:	75 f1                	jne    8a0 <unline+0x30>
  str[len] = '\0';
     8af:	c6 02 00             	movb   $0x0,(%edx)
}
     8b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8b5:	c9                   	leave  
     8b6:	c3                   	ret    
     8b7:	89 f6                	mov    %esi,%esi
     8b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     8c0:	01 da                	add    %ebx,%edx
  str[len] = '\0';
     8c2:	c6 02 00             	movb   $0x0,(%edx)
}
     8c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8c8:	c9                   	leave  
     8c9:	c3                   	ret    
     8ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000008d0 <find>:
int find(char* str, char c) {
     8d0:	55                   	push   %ebp
     8d1:	89 e5                	mov    %esp,%ebp
     8d3:	57                   	push   %edi
     8d4:	56                   	push   %esi
     8d5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     8d6:	31 db                	xor    %ebx,%ebx
int find(char* str, char c) {
     8d8:	83 ec 0c             	sub    $0xc,%esp
     8db:	8b 75 08             	mov    0x8(%ebp),%esi
     8de:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
  for (int i = 0; i < strlen(str); i++)
     8e2:	eb 0e                	jmp    8f2 <find+0x22>
     8e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     8e8:	89 f8                	mov    %edi,%eax
     8ea:	38 04 1e             	cmp    %al,(%esi,%ebx,1)
     8ed:	74 18                	je     907 <find+0x37>
  for (int i = 0; i < strlen(str); i++)
     8ef:	83 c3 01             	add    $0x1,%ebx
     8f2:	83 ec 0c             	sub    $0xc,%esp
     8f5:	56                   	push   %esi
     8f6:	e8 35 0a 00 00       	call   1330 <strlen>
     8fb:	83 c4 10             	add    $0x10,%esp
     8fe:	39 d8                	cmp    %ebx,%eax
     900:	77 e6                	ja     8e8 <find+0x18>
  return -1;
     902:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
     907:	8d 65 f4             	lea    -0xc(%ebp),%esp
     90a:	89 d8                	mov    %ebx,%eax
     90c:	5b                   	pop    %ebx
     90d:	5e                   	pop    %esi
     90e:	5f                   	pop    %edi
     90f:	5d                   	pop    %ebp
     910:	c3                   	ret    
     911:	eb 0d                	jmp    920 <substr>
     913:	90                   	nop
     914:	90                   	nop
     915:	90                   	nop
     916:	90                   	nop
     917:	90                   	nop
     918:	90                   	nop
     919:	90                   	nop
     91a:	90                   	nop
     91b:	90                   	nop
     91c:	90                   	nop
     91d:	90                   	nop
     91e:	90                   	nop
     91f:	90                   	nop

00000920 <substr>:
void substr(char* dest, char* str, int start, int end) {
     920:	55                   	push   %ebp
     921:	89 e5                	mov    %esp,%ebp
     923:	57                   	push   %edi
     924:	56                   	push   %esi
     925:	53                   	push   %ebx
     926:	83 ec 18             	sub    $0x18,%esp
     929:	8b 7d 14             	mov    0x14(%ebp),%edi
  int len = strlen(str);
     92c:	ff 75 0c             	pushl  0xc(%ebp)
void substr(char* dest, char* str, int start, int end) {
     92f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     932:	8b 75 08             	mov    0x8(%ebp),%esi
  int len = strlen(str);
     935:	e8 f6 09 00 00       	call   1330 <strlen>
     93a:	83 c4 10             	add    $0x10,%esp
     93d:	39 f8                	cmp    %edi,%eax
     93f:	0f 4e f8             	cmovle %eax,%edi
  while (i < end)
     942:	39 df                	cmp    %ebx,%edi
     944:	7e 1c                	jle    962 <substr+0x42>
     946:	8b 45 0c             	mov    0xc(%ebp),%eax
     949:	29 df                	sub    %ebx,%edi
  int s = 0, i = start;
     94b:	31 d2                	xor    %edx,%edx
     94d:	01 c3                	add    %eax,%ebx
     94f:	90                   	nop
    dest[s++] = str[i++];
     950:	83 c2 01             	add    $0x1,%edx
     953:	0f b6 44 13 ff       	movzbl -0x1(%ebx,%edx,1),%eax
  while (i < end)
     958:	39 fa                	cmp    %edi,%edx
    dest[s++] = str[i++];
     95a:	88 44 16 ff          	mov    %al,-0x1(%esi,%edx,1)
  while (i < end)
     95e:	75 f0                	jne    950 <substr+0x30>
     960:	01 d6                	add    %edx,%esi
  dest[s] = '\0';
     962:	c6 06 00             	movb   $0x0,(%esi)
}
     965:	8d 65 f4             	lea    -0xc(%ebp),%esp
     968:	5b                   	pop    %ebx
     969:	5e                   	pop    %esi
     96a:	5f                   	pop    %edi
     96b:	5d                   	pop    %ebp
     96c:	c3                   	ret    
     96d:	8d 76 00             	lea    0x0(%esi),%esi

00000970 <getArg>:
void getArg(char* dest, char* args, char delimiter) {
     970:	55                   	push   %ebp
     971:	89 e5                	mov    %esp,%ebp
     973:	57                   	push   %edi
     974:	56                   	push   %esi
     975:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     976:	31 db                	xor    %ebx,%ebx
void getArg(char* dest, char* args, char delimiter) {
     978:	83 ec 1c             	sub    $0x1c,%esp
     97b:	8b 75 0c             	mov    0xc(%ebp),%esi
     97e:	0f b6 7d 10          	movzbl 0x10(%ebp),%edi
     982:	eb 10                	jmp    994 <getArg+0x24>
     984:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     988:	89 f8                	mov    %edi,%eax
     98a:	3a 04 1e             	cmp    (%esi,%ebx,1),%al
     98d:	8d 53 01             	lea    0x1(%ebx),%edx
     990:	74 19                	je     9ab <getArg+0x3b>
     992:	89 d3                	mov    %edx,%ebx
  for (int i = 0; i < strlen(str); i++)
     994:	83 ec 0c             	sub    $0xc,%esp
     997:	56                   	push   %esi
     998:	e8 93 09 00 00       	call   1330 <strlen>
     99d:	83 c4 10             	add    $0x10,%esp
     9a0:	39 c3                	cmp    %eax,%ebx
     9a2:	72 e4                	jb     988 <getArg+0x18>
     9a4:	31 d2                	xor    %edx,%edx
  return -1;
     9a6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  substr(dest, args, 0, end);
     9ab:	53                   	push   %ebx
     9ac:	6a 00                	push   $0x0
     9ae:	56                   	push   %esi
     9af:	ff 75 08             	pushl  0x8(%ebp)
     9b2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     9b5:	e8 66 ff ff ff       	call   920 <substr>
  substr(args, args, end + 1, (int) strlen(args));
     9ba:	89 34 24             	mov    %esi,(%esp)
     9bd:	e8 6e 09 00 00       	call   1330 <strlen>
     9c2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     9c5:	50                   	push   %eax
     9c6:	52                   	push   %edx
     9c7:	56                   	push   %esi
     9c8:	56                   	push   %esi
     9c9:	e8 52 ff ff ff       	call   920 <substr>
}
     9ce:	83 c4 20             	add    $0x20,%esp
     9d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9d4:	5b                   	pop    %ebx
     9d5:	5e                   	pop    %esi
     9d6:	5f                   	pop    %edi
     9d7:	5d                   	pop    %ebp
     9d8:	c3                   	ret    
     9d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000009e0 <collectRange>:
int collectRange(char* args, int* startptr, int* endptr) {
     9e0:	55                   	push   %ebp
     9e1:	89 e5                	mov    %esp,%ebp
     9e3:	57                   	push   %edi
     9e4:	56                   	push   %esi
     9e5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     9e6:	31 f6                	xor    %esi,%esi
int collectRange(char* args, int* startptr, int* endptr) {
     9e8:	83 ec 2c             	sub    $0x2c,%esp
     9eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
     9ee:	eb 09                	jmp    9f9 <collectRange+0x19>
    if (str[i] == c) return i;
     9f0:	80 3c 33 3a          	cmpb   $0x3a,(%ebx,%esi,1)
     9f4:	74 42                	je     a38 <collectRange+0x58>
  for (int i = 0; i < strlen(str); i++)
     9f6:	83 c6 01             	add    $0x1,%esi
     9f9:	83 ec 0c             	sub    $0xc,%esp
     9fc:	53                   	push   %ebx
     9fd:	e8 2e 09 00 00       	call   1330 <strlen>
     a02:	83 c4 10             	add    $0x10,%esp
     a05:	39 c6                	cmp    %eax,%esi
     a07:	72 e7                	jb     9f0 <collectRange+0x10>
    if (args[0] == '-') {
     a09:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     a0c:	0f 84 d6 00 00 00    	je     ae8 <collectRange+0x108>
      *startptr = atoi(args);
     a12:	83 ec 0c             	sub    $0xc,%esp
     a15:	53                   	push   %ebx
     a16:	e8 75 0a 00 00       	call   1490 <atoi>
     a1b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     a1e:	83 c4 10             	add    $0x10,%esp
     a21:	89 01                	mov    %eax,(%ecx)
    *endptr = *startptr;
     a23:	8b 4d 10             	mov    0x10(%ebp),%ecx
     a26:	89 01                	mov    %eax,(%ecx)
    return 0;
     a28:	31 c0                	xor    %eax,%eax
}
     a2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a2d:	5b                   	pop    %ebx
     a2e:	5e                   	pop    %esi
     a2f:	5f                   	pop    %edi
     a30:	5d                   	pop    %ebp
     a31:	c3                   	ret    
     a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  getArg(startstr, args, ':');
     a38:	8d 75 de             	lea    -0x22(%ebp),%esi
     a3b:	83 ec 04             	sub    $0x4,%esp
     a3e:	6a 3a                	push   $0x3a
     a40:	53                   	push   %ebx
     a41:	56                   	push   %esi
     a42:	e8 29 ff ff ff       	call   970 <getArg>
  if (startstr[0] == '-') {
     a47:	83 c4 10             	add    $0x10,%esp
     a4a:	80 7d de 2d          	cmpb   $0x2d,-0x22(%ebp)
     a4e:	0f 84 3c 01 00 00    	je     b90 <collectRange+0x1b0>
  int negStartFlag = 0, negEndFlag = 0;
     a54:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     a5b:	31 ff                	xor    %edi,%edi
  if (endstr[0] == '-') {
     a5d:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     a60:	0f 84 0a 01 00 00    	je     b70 <collectRange+0x190>
  if (strcmp(startstr, "\0") == 0) *startptr = 1;
     a66:	83 ec 08             	sub    $0x8,%esp
     a69:	68 48 1a 00 00       	push   $0x1a48
     a6e:	56                   	push   %esi
     a6f:	e8 6c 08 00 00       	call   12e0 <strcmp>
     a74:	83 c4 10             	add    $0x10,%esp
     a77:	85 c0                	test   %eax,%eax
     a79:	0f 85 d1 00 00 00    	jne    b50 <collectRange+0x170>
     a7f:	8b 45 0c             	mov    0xc(%ebp),%eax
     a82:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  if (strcmp(endstr, "\0") == 0) *endptr = -1;
     a88:	83 ec 08             	sub    $0x8,%esp
     a8b:	68 48 1a 00 00       	push   $0x1a48
     a90:	53                   	push   %ebx
     a91:	e8 4a 08 00 00       	call   12e0 <strcmp>
     a96:	83 c4 10             	add    $0x10,%esp
     a99:	85 c0                	test   %eax,%eax
     a9b:	0f 85 97 00 00 00    	jne    b38 <collectRange+0x158>
     aa1:	8b 45 10             	mov    0x10(%ebp),%eax
     aa4:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  if (negStartFlag) *startptr = 0 - *startptr;
     aaa:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     aad:	85 c0                	test   %eax,%eax
     aaf:	74 05                	je     ab6 <collectRange+0xd6>
     ab1:	8b 45 0c             	mov    0xc(%ebp),%eax
     ab4:	f7 18                	negl   (%eax)
  if (negEndFlag) *endptr = 0 - *endptr;
     ab6:	85 ff                	test   %edi,%edi
     ab8:	74 05                	je     abf <collectRange+0xdf>
     aba:	8b 45 10             	mov    0x10(%ebp),%eax
     abd:	f7 18                	negl   (%eax)
  if (((*startptr > 0 && *endptr > 0) || 
     abf:	8b 45 0c             	mov    0xc(%ebp),%eax
     ac2:	8b 00                	mov    (%eax),%eax
     ac4:	83 f8 00             	cmp    $0x0,%eax
     ac7:	7e 4f                	jle    b18 <collectRange+0x138>
     ac9:	8b 55 10             	mov    0x10(%ebp),%edx
     acc:	8b 12                	mov    (%edx),%edx
     ace:	85 d2                	test   %edx,%edx
     ad0:	7e 55                	jle    b27 <collectRange+0x147>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     ad2:	39 d0                	cmp    %edx,%eax
     ad4:	0f 9f c0             	setg   %al
}
     ad7:	8d 65 f4             	lea    -0xc(%ebp),%esp
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     ada:	0f b6 c0             	movzbl %al,%eax
}
     add:	5b                   	pop    %ebx
     ade:	5e                   	pop    %esi
     adf:	5f                   	pop    %edi
     ae0:	5d                   	pop    %ebp
     ae1:	c3                   	ret    
     ae2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      substr(args, args, 1, strlen(args));
     ae8:	83 ec 0c             	sub    $0xc,%esp
     aeb:	53                   	push   %ebx
     aec:	e8 3f 08 00 00       	call   1330 <strlen>
     af1:	50                   	push   %eax
     af2:	6a 01                	push   $0x1
     af4:	53                   	push   %ebx
     af5:	53                   	push   %ebx
     af6:	e8 25 fe ff ff       	call   920 <substr>
      *startptr = 0 - atoi(args);
     afb:	83 c4 14             	add    $0x14,%esp
     afe:	53                   	push   %ebx
     aff:	e8 8c 09 00 00       	call   1490 <atoi>
     b04:	8b 7d 0c             	mov    0xc(%ebp),%edi
     b07:	f7 d8                	neg    %eax
     b09:	83 c4 10             	add    $0x10,%esp
     b0c:	89 07                	mov    %eax,(%edi)
     b0e:	e9 10 ff ff ff       	jmp    a23 <collectRange+0x43>
     b13:	90                   	nop
     b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (((*startptr > 0 && *endptr > 0) || 
     b18:	0f 84 0c ff ff ff    	je     a2a <collectRange+0x4a>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     b1e:	8b 7d 10             	mov    0x10(%ebp),%edi
     b21:	8b 17                	mov    (%edi),%edx
     b23:	85 d2                	test   %edx,%edx
     b25:	78 ab                	js     ad2 <collectRange+0xf2>
}
     b27:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
     b2a:	31 c0                	xor    %eax,%eax
}
     b2c:	5b                   	pop    %ebx
     b2d:	5e                   	pop    %esi
     b2e:	5f                   	pop    %edi
     b2f:	5d                   	pop    %ebp
     b30:	c3                   	ret    
     b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else *endptr = atoi(endstr);
     b38:	83 ec 0c             	sub    $0xc,%esp
     b3b:	53                   	push   %ebx
     b3c:	e8 4f 09 00 00       	call   1490 <atoi>
     b41:	8b 55 10             	mov    0x10(%ebp),%edx
     b44:	83 c4 10             	add    $0x10,%esp
     b47:	89 02                	mov    %eax,(%edx)
     b49:	e9 5c ff ff ff       	jmp    aaa <collectRange+0xca>
     b4e:	66 90                	xchg   %ax,%ax
  else *startptr = atoi(startstr);
     b50:	83 ec 0c             	sub    $0xc,%esp
     b53:	56                   	push   %esi
     b54:	e8 37 09 00 00       	call   1490 <atoi>
     b59:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     b5c:	83 c4 10             	add    $0x10,%esp
     b5f:	89 01                	mov    %eax,(%ecx)
     b61:	e9 22 ff ff ff       	jmp    a88 <collectRange+0xa8>
     b66:	8d 76 00             	lea    0x0(%esi),%esi
     b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    substr(endstr, endstr, 1, strlen(endstr));
     b70:	83 ec 0c             	sub    $0xc,%esp
    negEndFlag = 1;
     b73:	bf 01 00 00 00       	mov    $0x1,%edi
    substr(endstr, endstr, 1, strlen(endstr));
     b78:	53                   	push   %ebx
     b79:	e8 b2 07 00 00       	call   1330 <strlen>
     b7e:	50                   	push   %eax
     b7f:	6a 01                	push   $0x1
     b81:	53                   	push   %ebx
     b82:	53                   	push   %ebx
     b83:	e8 98 fd ff ff       	call   920 <substr>
     b88:	83 c4 20             	add    $0x20,%esp
     b8b:	e9 d6 fe ff ff       	jmp    a66 <collectRange+0x86>
    substr(startstr, startstr, 1, strlen(startstr));
     b90:	83 ec 0c             	sub    $0xc,%esp
     b93:	56                   	push   %esi
     b94:	e8 97 07 00 00       	call   1330 <strlen>
     b99:	50                   	push   %eax
     b9a:	6a 01                	push   $0x1
     b9c:	56                   	push   %esi
     b9d:	56                   	push   %esi
     b9e:	e8 7d fd ff ff       	call   920 <substr>
     ba3:	83 c4 20             	add    $0x20,%esp
    negStartFlag = 1;
     ba6:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
     bad:	e9 a9 fe ff ff       	jmp    a5b <collectRange+0x7b>
     bb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bc0 <negatoi>:
int negatoi(char* str) {
     bc0:	55                   	push   %ebp
     bc1:	89 e5                	mov    %esp,%ebp
     bc3:	53                   	push   %ebx
     bc4:	83 ec 04             	sub    $0x4,%esp
     bc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (str[0] == '-') {
     bca:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     bcd:	74 11                	je     be0 <negatoi+0x20>
}
     bcf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bd2:	c9                   	leave  
  return atoi(str);
     bd3:	e9 b8 08 00 00       	jmp    1490 <atoi>
     bd8:	90                   	nop
     bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    substr(str, str, 1, strlen(str));
     be0:	83 ec 0c             	sub    $0xc,%esp
     be3:	53                   	push   %ebx
     be4:	e8 47 07 00 00       	call   1330 <strlen>
     be9:	50                   	push   %eax
     bea:	6a 01                	push   $0x1
     bec:	53                   	push   %ebx
     bed:	53                   	push   %ebx
     bee:	e8 2d fd ff ff       	call   920 <substr>
    return 0 - atoi(str);
     bf3:	83 c4 14             	add    $0x14,%esp
     bf6:	53                   	push   %ebx
     bf7:	e8 94 08 00 00       	call   1490 <atoi>
     bfc:	83 c4 10             	add    $0x10,%esp
     bff:	f7 d8                	neg    %eax
}
     c01:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c04:	c9                   	leave  
     c05:	c3                   	ret    
     c06:	8d 76 00             	lea    0x0(%esi),%esi
     c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c10 <toUpper>:
void toUpper(char* str) {
     c10:	55                   	push   %ebp
     c11:	89 e5                	mov    %esp,%ebp
     c13:	8b 55 08             	mov    0x8(%ebp),%edx
  while (str[i] != '\0') {
     c16:	0f b6 02             	movzbl (%edx),%eax
     c19:	84 c0                	test   %al,%al
     c1b:	74 1a                	je     c37 <toUpper+0x27>
     c1d:	8d 76 00             	lea    0x0(%esi),%esi
    if (c <= 'z' && c >= 'a')
     c20:	8d 48 9f             	lea    -0x61(%eax),%ecx
     c23:	80 f9 19             	cmp    $0x19,%cl
     c26:	77 05                	ja     c2d <toUpper+0x1d>
      str[i] += ('Z' - 'z');
     c28:	83 e8 20             	sub    $0x20,%eax
     c2b:	88 02                	mov    %al,(%edx)
     c2d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     c30:	0f b6 02             	movzbl (%edx),%eax
     c33:	84 c0                	test   %al,%al
     c35:	75 e9                	jne    c20 <toUpper+0x10>
    i++;  
  }
}
     c37:	5d                   	pop    %ebp
     c38:	c3                   	ret    
     c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c40 <toLower>:

void toLower(char* str) {
     c40:	55                   	push   %ebp
     c41:	89 e5                	mov    %esp,%ebp
     c43:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     c46:	0f b6 02             	movzbl (%edx),%eax
     c49:	84 c0                	test   %al,%al
     c4b:	74 1a                	je     c67 <toLower+0x27>
     c4d:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'Z' && c >= 'A')
     c50:	8d 48 bf             	lea    -0x41(%eax),%ecx
     c53:	80 f9 19             	cmp    $0x19,%cl
     c56:	77 05                	ja     c5d <toLower+0x1d>
      str[i] -= ('Z' - 'z');
     c58:	83 c0 20             	add    $0x20,%eax
     c5b:	88 02                	mov    %al,(%edx)
     c5d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     c60:	0f b6 02             	movzbl (%edx),%eax
     c63:	84 c0                	test   %al,%al
     c65:	75 e9                	jne    c50 <toLower+0x10>
    i++;  
  }
}
     c67:	5d                   	pop    %ebp
     c68:	c3                   	ret    
     c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c70 <lineAt>:

// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
  return nodeAt(list, pos-1);
     c73:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
}
     c77:	5d                   	pop    %ebp
  return nodeAt(list, pos-1);
     c78:	e9 e3 f7 ff ff       	jmp    460 <nodeAt>
     c7d:	8d 76 00             	lea    0x0(%esi),%esi

00000c80 <printl>:

void printl(int lineNum, char* line) {
     c80:	55                   	push   %ebp
     c81:	89 e5                	mov    %esp,%ebp
     c83:	83 ec 08             	sub    $0x8,%esp
     c86:	8b 45 08             	mov    0x8(%ebp),%eax
  if (lineNum < 10)
     c89:	83 f8 09             	cmp    $0x9,%eax
     c8c:	7e 3a                	jle    cc8 <printl+0x48>
    fprintf(2, "%d  : %s\n", lineNum, line);
  else if (lineNum < 100)
     c8e:	83 f8 63             	cmp    $0x63,%eax
     c91:	7e 1d                	jle    cb0 <printl+0x30>
    fprintf(2, "%d : %s\n", lineNum, line);
  else
    fprintf(2, "%d: %s\n", lineNum, line);
     c93:	ff 75 0c             	pushl  0xc(%ebp)
     c96:	50                   	push   %eax
     c97:	68 5d 1a 00 00       	push   $0x1a5d
     c9c:	6a 02                	push   $0x2
     c9e:	e8 dd 0b 00 00       	call   1880 <fprintf>
     ca3:	83 c4 10             	add    $0x10,%esp
}
     ca6:	c9                   	leave  
     ca7:	c3                   	ret    
     ca8:	90                   	nop
     ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "%d : %s\n", lineNum, line);
     cb0:	ff 75 0c             	pushl  0xc(%ebp)
     cb3:	50                   	push   %eax
     cb4:	68 54 1a 00 00       	push   $0x1a54
     cb9:	6a 02                	push   $0x2
     cbb:	e8 c0 0b 00 00       	call   1880 <fprintf>
     cc0:	83 c4 10             	add    $0x10,%esp
}
     cc3:	c9                   	leave  
     cc4:	c3                   	ret    
     cc5:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "%d  : %s\n", lineNum, line);
     cc8:	ff 75 0c             	pushl  0xc(%ebp)
     ccb:	50                   	push   %eax
     ccc:	68 4a 1a 00 00       	push   $0x1a4a
     cd1:	6a 02                	push   $0x2
     cd3:	e8 a8 0b 00 00       	call   1880 <fprintf>
     cd8:	83 c4 10             	add    $0x10,%esp
}
     cdb:	c9                   	leave  
     cdc:	c3                   	ret    
     cdd:	8d 76 00             	lea    0x0(%esi),%esi

00000ce0 <end>:
void end(struct File* file, char* args) {
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
     ce3:	53                   	push   %ebx
     ce4:	83 ec 08             	sub    $0x8,%esp
     ce7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  append(file->lines, line);
     cea:	8b 43 0c             	mov    0xc(%ebx),%eax
  file->edited = 1;
     ced:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
     cf4:	ff 70 08             	pushl  0x8(%eax)
     cf7:	ff 75 0c             	pushl  0xc(%ebp)
     cfa:	50                   	push   %eax
     cfb:	e8 80 f8 ff ff       	call   580 <insert>
  file->len++;
     d00:	83 43 10 01          	addl   $0x1,0x10(%ebx)
}
     d04:	83 c4 10             	add    $0x10,%esp
     d07:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d0a:	c9                   	leave  
     d0b:	c3                   	ret    
     d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d10 <add>:
void add(struct File* file, char* args) {
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	57                   	push   %edi
     d14:	56                   	push   %esi
     d15:	53                   	push   %ebx
     d16:	83 ec 28             	sub    $0x28,%esp
     d19:	8b 5d 08             	mov    0x8(%ebp),%ebx
     d1c:	8b 75 0c             	mov    0xc(%ebp),%esi
  file->edited = 1;
     d1f:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
  if (strlen(args) < 1) {
     d26:	56                   	push   %esi
     d27:	e8 04 06 00 00       	call   1330 <strlen>
     d2c:	83 c4 10             	add    $0x10,%esp
     d2f:	85 c0                	test   %eax,%eax
     d31:	74 3d                	je     d70 <add+0x60>
  getArg(lineStr, args, ' ');
     d33:	8d 7d de             	lea    -0x22(%ebp),%edi
     d36:	83 ec 04             	sub    $0x4,%esp
     d39:	6a 20                	push   $0x20
     d3b:	56                   	push   %esi
     d3c:	57                   	push   %edi
     d3d:	e8 2e fc ff ff       	call   970 <getArg>
  int lineNum = negatoi(lineStr);
     d42:	89 3c 24             	mov    %edi,(%esp)
     d45:	e8 76 fe ff ff       	call   bc0 <negatoi>
  insert(file->lines, line, lineNum - 1);
     d4a:	83 c4 0c             	add    $0xc,%esp
     d4d:	83 e8 01             	sub    $0x1,%eax
     d50:	50                   	push   %eax
     d51:	56                   	push   %esi
     d52:	ff 73 0c             	pushl  0xc(%ebx)
     d55:	e8 26 f8 ff ff       	call   580 <insert>
  file->len++;
     d5a:	83 43 10 01          	addl   $0x1,0x10(%ebx)
     d5e:	83 c4 10             	add    $0x10,%esp
}
     d61:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d64:	5b                   	pop    %ebx
     d65:	5e                   	pop    %esi
     d66:	5f                   	pop    %edi
     d67:	5d                   	pop    %ebp
     d68:	c3                   	ret    
     d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "you need to give a line number to insert before\n");
     d70:	83 ec 08             	sub    $0x8,%esp
     d73:	68 80 1b 00 00       	push   $0x1b80
     d78:	6a 02                	push   $0x2
     d7a:	e8 01 0b 00 00       	call   1880 <fprintf>
     d7f:	83 c4 10             	add    $0x10,%esp
}
     d82:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d85:	5b                   	pop    %ebx
     d86:	5e                   	pop    %esi
     d87:	5f                   	pop    %edi
     d88:	5d                   	pop    %ebp
     d89:	c3                   	ret    
     d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000d90 <drop>:
void drop(struct File* file, char* args) {
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	57                   	push   %edi
     d94:	56                   	push   %esi
     d95:	53                   	push   %ebx
     d96:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
     d99:	ff 75 0c             	pushl  0xc(%ebp)
void drop(struct File* file, char* args) {
     d9c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (strlen(args) < 1) {
     d9f:	e8 8c 05 00 00       	call   1330 <strlen>
     da4:	83 c4 10             	add    $0x10,%esp
     da7:	85 c0                	test   %eax,%eax
     da9:	0f 84 09 01 00 00    	je     eb8 <drop+0x128>
  if (collectRange(args, &start, &end) == 1) {
     daf:	8d 75 e4             	lea    -0x1c(%ebp),%esi
     db2:	8d 7d e0             	lea    -0x20(%ebp),%edi
     db5:	83 ec 04             	sub    $0x4,%esp
     db8:	56                   	push   %esi
     db9:	57                   	push   %edi
     dba:	ff 75 0c             	pushl  0xc(%ebp)
     dbd:	e8 1e fc ff ff       	call   9e0 <collectRange>
     dc2:	83 c4 10             	add    $0x10,%esp
     dc5:	83 f8 01             	cmp    $0x1,%eax
     dc8:	0f 84 0a 01 00 00    	je     ed8 <drop+0x148>
  if (normalizeRange(*file, &start, &end) == 1) {
     dce:	56                   	push   %esi
     dcf:	57                   	push   %edi
     dd0:	ff 73 14             	pushl  0x14(%ebx)
     dd3:	ff 73 10             	pushl  0x10(%ebx)
     dd6:	ff 73 0c             	pushl  0xc(%ebx)
     dd9:	ff 73 08             	pushl  0x8(%ebx)
     ddc:	ff 73 04             	pushl  0x4(%ebx)
     ddf:	ff 33                	pushl  (%ebx)
     de1:	e8 1a f9 ff ff       	call   700 <normalizeRange>
     de6:	83 c4 20             	add    $0x20,%esp
     de9:	83 f8 01             	cmp    $0x1,%eax
     dec:	0f 84 1e 01 00 00    	je     f10 <drop+0x180>
  int numl = numLines(start, end);
     df2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     df5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return (end - start) + 1;
     df8:	89 d6                	mov    %edx,%esi
     dfa:	29 c6                	sub    %eax,%esi
     dfc:	8d 7e 01             	lea    0x1(%esi),%edi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
     dff:	83 ff 01             	cmp    $0x1,%edi
     e02:	89 7d d4             	mov    %edi,-0x2c(%ebp)
     e05:	0f 84 ed 00 00 00    	je     ef8 <drop+0x168>
  else fprintf(2, "Drop %d lines [%d:%d] (y/n)? ", numl, start, end);
     e0b:	83 ec 0c             	sub    $0xc,%esp
     e0e:	52                   	push   %edx
     e0f:	50                   	push   %eax
     e10:	ff 75 d4             	pushl  -0x2c(%ebp)
     e13:	68 7a 1a 00 00       	push   $0x1a7a
     e18:	6a 02                	push   $0x2
     e1a:	e8 61 0a 00 00       	call   1880 <fprintf>
     e1f:	83 c4 20             	add    $0x20,%esp
  if (confirmation() != 0) return;
     e22:	e8 79 f8 ff ff       	call   6a0 <confirmation>
     e27:	85 c0                	test   %eax,%eax
     e29:	75 7f                	jne    eaa <drop+0x11a>
  return nodeAt(list, pos-1);
     e2b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  struct Node* curNode = (lineAt(file->lines, start))->prev;
     e2e:	8b 4b 0c             	mov    0xc(%ebx),%ecx
     e31:	83 ec 08             	sub    $0x8,%esp
  file->edited = 1;
     e34:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
     e3b:	83 e8 01             	sub    $0x1,%eax
     e3e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
     e41:	50                   	push   %eax
     e42:	51                   	push   %ecx
     e43:	e8 18 f6 ff ff       	call   460 <nodeAt>
  struct Node* curNode = (lineAt(file->lines, start))->prev;
     e48:	8b 30                	mov    (%eax),%esi
     e4a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     e4d:	5a                   	pop    %edx
     e4e:	59                   	pop    %ecx
     e4f:	8b 4d d0             	mov    -0x30(%ebp),%ecx
     e52:	83 e8 01             	sub    $0x1,%eax
     e55:	50                   	push   %eax
     e56:	51                   	push   %ecx
     e57:	e8 04 f6 ff ff       	call   460 <nodeAt>
     e5c:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
     e5f:	39 c6                	cmp    %eax,%esi
     e61:	89 c7                	mov    %eax,%edi
     e63:	8b 4d d0             	mov    -0x30(%ebp),%ecx
     e66:	75 0b                	jne    e73 <drop+0xe3>
     e68:	eb 21                	jmp    e8b <drop+0xfb>
     e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e70:	8b 4b 0c             	mov    0xc(%ebx),%ecx
    curNode = curNode->next;
     e73:	8b 76 08             	mov    0x8(%esi),%esi
    destroyNode(file->lines, curNode);
     e76:	83 ec 08             	sub    $0x8,%esp
     e79:	56                   	push   %esi
     e7a:	51                   	push   %ecx
     e7b:	e8 50 f6 ff ff       	call   4d0 <destroyNode>
    file->len--;
     e80:	83 6b 10 01          	subl   $0x1,0x10(%ebx)
  while (curNode != stopNode) {
     e84:	83 c4 10             	add    $0x10,%esp
     e87:	39 f7                	cmp    %esi,%edi
     e89:	75 e5                	jne    e70 <drop+0xe0>
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
     e8b:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
     e8f:	0f 84 93 00 00 00    	je     f28 <drop+0x198>
  else fprintf(2, "%d lines dropped\n", numl);
     e95:	83 ec 04             	sub    $0x4,%esp
     e98:	ff 75 d4             	pushl  -0x2c(%ebp)
     e9b:	68 a9 1a 00 00       	push   $0x1aa9
     ea0:	6a 02                	push   $0x2
     ea2:	e8 d9 09 00 00       	call   1880 <fprintf>
     ea7:	83 c4 10             	add    $0x10,%esp
}
     eaa:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ead:	5b                   	pop    %ebx
     eae:	5e                   	pop    %esi
     eaf:	5f                   	pop    %edi
     eb0:	5d                   	pop    %ebp
     eb1:	c3                   	ret    
     eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "you need to give a range to drop\n");
     eb8:	83 ec 08             	sub    $0x8,%esp
     ebb:	68 b4 1b 00 00       	push   $0x1bb4
     ec0:	6a 02                	push   $0x2
     ec2:	e8 b9 09 00 00       	call   1880 <fprintf>
    return;
     ec7:	83 c4 10             	add    $0x10,%esp
}
     eca:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ecd:	5b                   	pop    %ebx
     ece:	5e                   	pop    %esi
     ecf:	5f                   	pop    %edi
     ed0:	5d                   	pop    %ebp
     ed1:	c3                   	ret    
     ed2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: start index is larger than end index\n");
     ed8:	83 ec 08             	sub    $0x8,%esp
     edb:	68 d8 1b 00 00       	push   $0x1bd8
     ee0:	6a 02                	push   $0x2
     ee2:	e8 99 09 00 00       	call   1880 <fprintf>
     ee7:	83 c4 10             	add    $0x10,%esp
}
     eea:	8d 65 f4             	lea    -0xc(%ebp),%esp
     eed:	5b                   	pop    %ebx
     eee:	5e                   	pop    %esi
     eef:	5f                   	pop    %edi
     ef0:	5d                   	pop    %ebp
     ef1:	c3                   	ret    
     ef2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
     ef8:	83 ec 04             	sub    $0x4,%esp
     efb:	50                   	push   %eax
     efc:	68 65 1a 00 00       	push   $0x1a65
     f01:	6a 02                	push   $0x2
     f03:	e8 78 09 00 00       	call   1880 <fprintf>
     f08:	83 c4 10             	add    $0x10,%esp
     f0b:	e9 12 ff ff ff       	jmp    e22 <drop+0x92>
    fprintf(2, "error: bad input range. make sure start < end\n");
     f10:	83 ec 08             	sub    $0x8,%esp
     f13:	68 08 1c 00 00       	push   $0x1c08
     f18:	6a 02                	push   $0x2
     f1a:	e8 61 09 00 00       	call   1880 <fprintf>
     f1f:	83 c4 10             	add    $0x10,%esp
     f22:	eb 86                	jmp    eaa <drop+0x11a>
     f24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
     f28:	83 ec 04             	sub    $0x4,%esp
     f2b:	ff 75 e0             	pushl  -0x20(%ebp)
     f2e:	68 98 1a 00 00       	push   $0x1a98
     f33:	6a 02                	push   $0x2
     f35:	e8 46 09 00 00       	call   1880 <fprintf>
     f3a:	83 c4 10             	add    $0x10,%esp
     f3d:	e9 68 ff ff ff       	jmp    eaa <drop+0x11a>
     f42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000f50 <edit>:
void edit(struct File* file, char* args) {
     f50:	55                   	push   %ebp
     f51:	89 e5                	mov    %esp,%ebp
     f53:	57                   	push   %edi
     f54:	56                   	push   %esi
     f55:	53                   	push   %ebx
     f56:	83 ec 28             	sub    $0x28,%esp
     f59:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if (strlen(args) < 1) {
     f5c:	53                   	push   %ebx
     f5d:	e8 ce 03 00 00       	call   1330 <strlen>
     f62:	83 c4 10             	add    $0x10,%esp
     f65:	85 c0                	test   %eax,%eax
     f67:	75 1f                	jne    f88 <edit+0x38>
    fprintf(2, "you need to give a line number to replace\n");
     f69:	83 ec 08             	sub    $0x8,%esp
     f6c:	68 38 1c 00 00       	push   $0x1c38
     f71:	6a 02                	push   $0x2
     f73:	e8 08 09 00 00       	call   1880 <fprintf>
    return;
     f78:	83 c4 10             	add    $0x10,%esp
}
     f7b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f7e:	5b                   	pop    %ebx
     f7f:	5e                   	pop    %esi
     f80:	5f                   	pop    %edi
     f81:	5d                   	pop    %ebp
     f82:	c3                   	ret    
     f83:	90                   	nop
     f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  getArg(lineStr, args, ' ');
     f88:	8d 75 de             	lea    -0x22(%ebp),%esi
     f8b:	83 ec 04             	sub    $0x4,%esp
     f8e:	6a 20                	push   $0x20
     f90:	53                   	push   %ebx
     f91:	56                   	push   %esi
     f92:	e8 d9 f9 ff ff       	call   970 <getArg>
  int lineNum = negatoi(lineStr);
     f97:	89 34 24             	mov    %esi,(%esp)
     f9a:	e8 21 fc ff ff       	call   bc0 <negatoi>
  fprintf(2, "replace line %d (y/n)? ", lineNum);
     f9f:	83 c4 0c             	add    $0xc,%esp
  int lineNum = negatoi(lineStr);
     fa2:	89 c6                	mov    %eax,%esi
  fprintf(2, "replace line %d (y/n)? ", lineNum);
     fa4:	50                   	push   %eax
     fa5:	68 bb 1a 00 00       	push   $0x1abb
     faa:	6a 02                	push   $0x2
     fac:	e8 cf 08 00 00       	call   1880 <fprintf>
  if (confirmation() != 0) return;
     fb1:	e8 ea f6 ff ff       	call   6a0 <confirmation>
     fb6:	83 c4 10             	add    $0x10,%esp
     fb9:	85 c0                	test   %eax,%eax
     fbb:	75 be                	jne    f7b <edit+0x2b>
  file->edited = 1;
     fbd:	8b 45 08             	mov    0x8(%ebp),%eax
     fc0:	83 ec 08             	sub    $0x8,%esp
     fc3:	83 ee 01             	sub    $0x1,%esi
  destroyNode(file->lines, lineAt(file->lines, lineNum));
     fc6:	8b 78 0c             	mov    0xc(%eax),%edi
  file->edited = 1;
     fc9:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
     fd0:	56                   	push   %esi
     fd1:	57                   	push   %edi
     fd2:	e8 89 f4 ff ff       	call   460 <nodeAt>
     fd7:	5a                   	pop    %edx
     fd8:	59                   	pop    %ecx
  destroyNode(file->lines, lineAt(file->lines, lineNum));
     fd9:	50                   	push   %eax
     fda:	57                   	push   %edi
     fdb:	e8 f0 f4 ff ff       	call   4d0 <destroyNode>
  insert(file->lines, line, lineNum - 1);
     fe0:	8b 45 08             	mov    0x8(%ebp),%eax
     fe3:	83 c4 0c             	add    $0xc,%esp
     fe6:	56                   	push   %esi
     fe7:	53                   	push   %ebx
     fe8:	ff 70 0c             	pushl  0xc(%eax)
     feb:	e8 90 f5 ff ff       	call   580 <insert>
     ff0:	83 c4 10             	add    $0x10,%esp
}
     ff3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ff6:	5b                   	pop    %ebx
     ff7:	5e                   	pop    %esi
     ff8:	5f                   	pop    %edi
     ff9:	5d                   	pop    %ebp
     ffa:	c3                   	ret    
     ffb:	90                   	nop
     ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001000 <list>:
void list(struct File file, char* args) {
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	57                   	push   %edi
    1004:	56                   	push   %esi
    1005:	53                   	push   %ebx
    1006:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
    1009:	ff 75 20             	pushl  0x20(%ebp)
    100c:	8b 75 14             	mov    0x14(%ebp),%esi
    100f:	e8 1c 03 00 00       	call   1330 <strlen>
    1014:	83 c4 10             	add    $0x10,%esp
    1017:	85 c0                	test   %eax,%eax
    1019:	75 1d                	jne    1038 <list+0x38>
    fprintf(2, "you need to give a range to list\n");
    101b:	83 ec 08             	sub    $0x8,%esp
    101e:	68 64 1c 00 00       	push   $0x1c64
    1023:	6a 02                	push   $0x2
    1025:	e8 56 08 00 00       	call   1880 <fprintf>
    return;
    102a:	83 c4 10             	add    $0x10,%esp
}
    102d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1030:	5b                   	pop    %ebx
    1031:	5e                   	pop    %esi
    1032:	5f                   	pop    %edi
    1033:	5d                   	pop    %ebp
    1034:	c3                   	ret    
    1035:	8d 76 00             	lea    0x0(%esi),%esi
  if (collectRange(args, &start, &end) == 1) {
    1038:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
    103b:	8d 7d e0             	lea    -0x20(%ebp),%edi
    103e:	83 ec 04             	sub    $0x4,%esp
    1041:	53                   	push   %ebx
    1042:	57                   	push   %edi
    1043:	ff 75 20             	pushl  0x20(%ebp)
    1046:	e8 95 f9 ff ff       	call   9e0 <collectRange>
    104b:	83 c4 10             	add    $0x10,%esp
    104e:	83 f8 01             	cmp    $0x1,%eax
    1051:	0f 84 91 00 00 00    	je     10e8 <list+0xe8>
  if (normalizeRange(file, &start, &end) == 1) {
    1057:	53                   	push   %ebx
    1058:	57                   	push   %edi
    1059:	ff 75 1c             	pushl  0x1c(%ebp)
    105c:	ff 75 18             	pushl  0x18(%ebp)
    105f:	ff 75 14             	pushl  0x14(%ebp)
    1062:	ff 75 10             	pushl  0x10(%ebp)
    1065:	ff 75 0c             	pushl  0xc(%ebp)
    1068:	ff 75 08             	pushl  0x8(%ebp)
    106b:	e8 90 f6 ff ff       	call   700 <normalizeRange>
    1070:	83 c4 20             	add    $0x20,%esp
    1073:	83 f8 01             	cmp    $0x1,%eax
    1076:	0f 84 8c 00 00 00    	je     1108 <list+0x108>
  lineNum = start - 1;
    107c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    107f:	83 ec 08             	sub    $0x8,%esp
    1082:	8d 78 ff             	lea    -0x1(%eax),%edi
    1085:	57                   	push   %edi
    1086:	56                   	push   %esi
    1087:	e8 d4 f3 ff ff       	call   460 <nodeAt>
  struct Node* curNode = (lineAt(file.lines, start))->prev;
    108c:	8b 18                	mov    (%eax),%ebx
    108e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1091:	5a                   	pop    %edx
    1092:	59                   	pop    %ecx
    1093:	83 e8 01             	sub    $0x1,%eax
    1096:	50                   	push   %eax
    1097:	56                   	push   %esi
    1098:	e8 c3 f3 ff ff       	call   460 <nodeAt>
    109d:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
    10a0:	39 d8                	cmp    %ebx,%eax
    10a2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    10a5:	74 86                	je     102d <list+0x2d>
    curNode = curNode->next;
    10a7:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
    10aa:	3b 5e 04             	cmp    0x4(%esi),%ebx
    10ad:	75 15                	jne    10c4 <list+0xc4>
    10af:	e9 79 ff ff ff       	jmp    102d <list+0x2d>
    10b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
    10b8:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
    10bb:	39 5e 04             	cmp    %ebx,0x4(%esi)
    10be:	0f 84 69 ff ff ff    	je     102d <list+0x2d>
    printl(++lineNum, curNode->data);
    10c4:	83 ec 08             	sub    $0x8,%esp
    10c7:	83 c7 01             	add    $0x1,%edi
    10ca:	ff 73 04             	pushl  0x4(%ebx)
    10cd:	57                   	push   %edi
    10ce:	e8 ad fb ff ff       	call   c80 <printl>
  while (curNode != stopNode) {
    10d3:	83 c4 10             	add    $0x10,%esp
    10d6:	39 5d d4             	cmp    %ebx,-0x2c(%ebp)
    10d9:	75 dd                	jne    10b8 <list+0xb8>
}
    10db:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10de:	5b                   	pop    %ebx
    10df:	5e                   	pop    %esi
    10e0:	5f                   	pop    %edi
    10e1:	5d                   	pop    %ebp
    10e2:	c3                   	ret    
    10e3:	90                   	nop
    10e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "error: start index is larger than end index\n");
    10e8:	83 ec 08             	sub    $0x8,%esp
    10eb:	68 d8 1b 00 00       	push   $0x1bd8
    10f0:	6a 02                	push   $0x2
    10f2:	e8 89 07 00 00       	call   1880 <fprintf>
    return;
    10f7:	83 c4 10             	add    $0x10,%esp
}
    10fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10fd:	5b                   	pop    %ebx
    10fe:	5e                   	pop    %esi
    10ff:	5f                   	pop    %edi
    1100:	5d                   	pop    %ebp
    1101:	c3                   	ret    
    1102:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: bad input range. make sure start < end\n");
    1108:	83 ec 08             	sub    $0x8,%esp
    110b:	68 08 1c 00 00       	push   $0x1c08
    1110:	6a 02                	push   $0x2
    1112:	e8 69 07 00 00       	call   1880 <fprintf>
    return;
    1117:	83 c4 10             	add    $0x10,%esp
    111a:	e9 0e ff ff ff       	jmp    102d <list+0x2d>
    111f:	90                   	nop

00001120 <show>:
void show(struct File file, char* args) {
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	57                   	push   %edi
    1124:	56                   	push   %esi
    1125:	53                   	push   %ebx
    1126:	83 ec 0c             	sub    $0xc,%esp
    1129:	8b 7d 14             	mov    0x14(%ebp),%edi
  struct Node* cur = file.lines->head->next;
    112c:	8b 07                	mov    (%edi),%eax
    112e:	8b 58 08             	mov    0x8(%eax),%ebx
  while (cur != file.lines->tail) {
    1131:	3b 5f 04             	cmp    0x4(%edi),%ebx
    1134:	74 24                	je     115a <show+0x3a>
  int lineNum = 1;
    1136:	be 01 00 00 00       	mov    $0x1,%esi
    113b:	90                   	nop
    113c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printl(lineNum, cur->data);
    1140:	83 ec 08             	sub    $0x8,%esp
    1143:	ff 73 04             	pushl  0x4(%ebx)
    1146:	56                   	push   %esi
    lineNum++;
    1147:	83 c6 01             	add    $0x1,%esi
    printl(lineNum, cur->data);
    114a:	e8 31 fb ff ff       	call   c80 <printl>
    cur = cur->next;
    114f:	8b 5b 08             	mov    0x8(%ebx),%ebx
  while (cur != file.lines->tail) {
    1152:	83 c4 10             	add    $0x10,%esp
    1155:	39 5f 04             	cmp    %ebx,0x4(%edi)
    1158:	75 e6                	jne    1140 <show+0x20>
}
    115a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    115d:	5b                   	pop    %ebx
    115e:	5e                   	pop    %esi
    115f:	5f                   	pop    %edi
    1160:	5d                   	pop    %ebp
    1161:	c3                   	ret    
    1162:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001170 <quit>:
void quit(struct File* file) {
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	56                   	push   %esi
    1174:	53                   	push   %ebx
    1175:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (file->edited == 0) return;
    1178:	8b 4b 14             	mov    0x14(%ebx),%ecx
    117b:	85 c9                	test   %ecx,%ecx
    117d:	75 11                	jne    1190 <quit+0x20>
}
    117f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1182:	5b                   	pop    %ebx
    1183:	5e                   	pop    %esi
    1184:	5d                   	pop    %ebp
    1185:	c3                   	ret    
    1186:	8d 76 00             	lea    0x0(%esi),%esi
    1189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  fprintf(2, "save changes (y/n)? ");
    1190:	83 ec 08             	sub    $0x8,%esp
    1193:	68 d3 1a 00 00       	push   $0x1ad3
    1198:	6a 02                	push   $0x2
    119a:	e8 e1 06 00 00       	call   1880 <fprintf>
  if (confirmation() != 0) return;
    119f:	e8 fc f4 ff ff       	call   6a0 <confirmation>
    11a4:	83 c4 10             	add    $0x10,%esp
    11a7:	85 c0                	test   %eax,%eax
    11a9:	75 d4                	jne    117f <quit+0xf>
  if (unlink(file->filename) < 0) {
    11ab:	83 ec 0c             	sub    $0xc,%esp
    11ae:	ff 33                	pushl  (%ebx)
    11b0:	e8 a5 03 00 00       	call   155a <unlink>
    11b5:	83 c4 10             	add    $0x10,%esp
    11b8:	85 c0                	test   %eax,%eax
    11ba:	0f 88 90 00 00 00    	js     1250 <quit+0xe0>
  file->fd = open(file->filename, O_CREATE|O_RDWR);
    11c0:	83 ec 08             	sub    $0x8,%esp
    11c3:	68 02 02 00 00       	push   $0x202
    11c8:	ff 33                	pushl  (%ebx)
    11ca:	e8 7b 03 00 00       	call   154a <open>
  if (file->fd < 0) {
    11cf:	83 c4 10             	add    $0x10,%esp
    11d2:	85 c0                	test   %eax,%eax
  file->fd = open(file->filename, O_CREATE|O_RDWR);
    11d4:	89 43 04             	mov    %eax,0x4(%ebx)
  if (file->fd < 0) {
    11d7:	0f 88 93 00 00 00    	js     1270 <quit+0x100>
  struct Node* cur = file->lines->head->next;
    11dd:	8b 53 0c             	mov    0xc(%ebx),%edx
    11e0:	8b 0a                	mov    (%edx),%ecx
    11e2:	8b 71 08             	mov    0x8(%ecx),%esi
  while (cur != file->lines->tail) {
    11e5:	3b 72 04             	cmp    0x4(%edx),%esi
    11e8:	74 43                	je     122d <quit+0xbd>
    11ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    write(file->fd, cur->data, strlen(cur->data));
    11f0:	83 ec 0c             	sub    $0xc,%esp
    11f3:	ff 76 04             	pushl  0x4(%esi)
    11f6:	e8 35 01 00 00       	call   1330 <strlen>
    11fb:	83 c4 0c             	add    $0xc,%esp
    11fe:	50                   	push   %eax
    11ff:	ff 76 04             	pushl  0x4(%esi)
    1202:	ff 73 04             	pushl  0x4(%ebx)
    1205:	e8 20 03 00 00       	call   152a <write>
    write(file->fd, "\n", sizeof(char));
    120a:	83 c4 0c             	add    $0xc,%esp
    120d:	6a 01                	push   $0x1
    120f:	68 20 1b 00 00       	push   $0x1b20
    1214:	ff 73 04             	pushl  0x4(%ebx)
    1217:	e8 0e 03 00 00       	call   152a <write>
  while (cur != file->lines->tail) {
    121c:	8b 43 0c             	mov    0xc(%ebx),%eax
    cur = cur->next;
    121f:	8b 76 08             	mov    0x8(%esi),%esi
  while (cur != file->lines->tail) {
    1222:	83 c4 10             	add    $0x10,%esp
    1225:	3b 70 04             	cmp    0x4(%eax),%esi
    1228:	75 c6                	jne    11f0 <quit+0x80>
    122a:	8b 43 04             	mov    0x4(%ebx),%eax
  close(file->fd);
    122d:	83 ec 0c             	sub    $0xc,%esp
    1230:	50                   	push   %eax
    1231:	e8 fc 02 00 00       	call   1532 <close>
  fprintf(2, "changes saved\n");
    1236:	58                   	pop    %eax
    1237:	5a                   	pop    %edx
    1238:	68 e8 1a 00 00       	push   $0x1ae8
    123d:	6a 02                	push   $0x2
    123f:	e8 3c 06 00 00       	call   1880 <fprintf>
    1244:	83 c4 10             	add    $0x10,%esp
    1247:	e9 33 ff ff ff       	jmp    117f <quit+0xf>
    124c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "could not clear file for writing. changes lost\n");
    1250:	83 ec 08             	sub    $0x8,%esp
    1253:	68 88 1c 00 00       	push   $0x1c88
    1258:	6a 02                	push   $0x2
    125a:	e8 21 06 00 00       	call   1880 <fprintf>
    return;
    125f:	83 c4 10             	add    $0x10,%esp
    1262:	e9 18 ff ff ff       	jmp    117f <quit+0xf>
    1267:	89 f6                	mov    %esi,%esi
    1269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    fprintf(2, "could not open file for writing. changes lost\n");
    1270:	83 ec 08             	sub    $0x8,%esp
    1273:	68 b8 1c 00 00       	push   $0x1cb8
    1278:	6a 02                	push   $0x2
    127a:	e8 01 06 00 00       	call   1880 <fprintf>
    return;
    127f:	83 c4 10             	add    $0x10,%esp
    1282:	e9 f8 fe ff ff       	jmp    117f <quit+0xf>
    1287:	89 f6                	mov    %esi,%esi
    1289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001290 <bi>:
void bi() {
    1290:	55                   	push   %ebp
    1291:	89 e5                	mov    %esp,%ebp
    1293:	83 ec 10             	sub    $0x10,%esp
  fprintf(2, "bad input\n");
    1296:	68 75 1b 00 00       	push   $0x1b75
    129b:	6a 02                	push   $0x2
    129d:	e8 de 05 00 00       	call   1880 <fprintf>
}
    12a2:	83 c4 10             	add    $0x10,%esp
    12a5:	c9                   	leave  
    12a6:	c3                   	ret    
    12a7:	66 90                	xchg   %ax,%ax
    12a9:	66 90                	xchg   %ax,%ax
    12ab:	66 90                	xchg   %ax,%ax
    12ad:	66 90                	xchg   %ax,%ax
    12af:	90                   	nop

000012b0 <strcpy>:
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
    12b0:	55                   	push   %ebp
    12b1:	89 e5                	mov    %esp,%ebp
    12b3:	53                   	push   %ebx
    12b4:	8b 45 08             	mov    0x8(%ebp),%eax
    12b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    12ba:	89 c2                	mov    %eax,%edx
    12bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12c0:	83 c1 01             	add    $0x1,%ecx
    12c3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    12c7:	83 c2 01             	add    $0x1,%edx
    12ca:	84 db                	test   %bl,%bl
    12cc:	88 5a ff             	mov    %bl,-0x1(%edx)
    12cf:	75 ef                	jne    12c0 <strcpy+0x10>
    ;
  return os;
}
    12d1:	5b                   	pop    %ebx
    12d2:	5d                   	pop    %ebp
    12d3:	c3                   	ret    
    12d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    12da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000012e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    12e0:	55                   	push   %ebp
    12e1:	89 e5                	mov    %esp,%ebp
    12e3:	53                   	push   %ebx
    12e4:	8b 55 08             	mov    0x8(%ebp),%edx
    12e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    12ea:	0f b6 02             	movzbl (%edx),%eax
    12ed:	0f b6 19             	movzbl (%ecx),%ebx
    12f0:	84 c0                	test   %al,%al
    12f2:	75 1c                	jne    1310 <strcmp+0x30>
    12f4:	eb 2a                	jmp    1320 <strcmp+0x40>
    12f6:	8d 76 00             	lea    0x0(%esi),%esi
    12f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    1300:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1303:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    1306:	83 c1 01             	add    $0x1,%ecx
    1309:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    130c:	84 c0                	test   %al,%al
    130e:	74 10                	je     1320 <strcmp+0x40>
    1310:	38 d8                	cmp    %bl,%al
    1312:	74 ec                	je     1300 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    1314:	29 d8                	sub    %ebx,%eax
}
    1316:	5b                   	pop    %ebx
    1317:	5d                   	pop    %ebp
    1318:	c3                   	ret    
    1319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1320:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    1322:	29 d8                	sub    %ebx,%eax
}
    1324:	5b                   	pop    %ebx
    1325:	5d                   	pop    %ebp
    1326:	c3                   	ret    
    1327:	89 f6                	mov    %esi,%esi
    1329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001330 <strlen>:

uint
strlen(const char *s)
{
    1330:	55                   	push   %ebp
    1331:	89 e5                	mov    %esp,%ebp
    1333:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1336:	80 39 00             	cmpb   $0x0,(%ecx)
    1339:	74 15                	je     1350 <strlen+0x20>
    133b:	31 d2                	xor    %edx,%edx
    133d:	8d 76 00             	lea    0x0(%esi),%esi
    1340:	83 c2 01             	add    $0x1,%edx
    1343:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1347:	89 d0                	mov    %edx,%eax
    1349:	75 f5                	jne    1340 <strlen+0x10>
    ;
  return n;
}
    134b:	5d                   	pop    %ebp
    134c:	c3                   	ret    
    134d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    1350:	31 c0                	xor    %eax,%eax
}
    1352:	5d                   	pop    %ebp
    1353:	c3                   	ret    
    1354:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    135a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001360 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
    1363:	57                   	push   %edi
    1364:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1367:	8b 4d 10             	mov    0x10(%ebp),%ecx
    136a:	8b 45 0c             	mov    0xc(%ebp),%eax
    136d:	89 d7                	mov    %edx,%edi
    136f:	fc                   	cld    
    1370:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1372:	89 d0                	mov    %edx,%eax
    1374:	5f                   	pop    %edi
    1375:	5d                   	pop    %ebp
    1376:	c3                   	ret    
    1377:	89 f6                	mov    %esi,%esi
    1379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001380 <strchr>:

char*
strchr(const char *s, char c)
{
    1380:	55                   	push   %ebp
    1381:	89 e5                	mov    %esp,%ebp
    1383:	53                   	push   %ebx
    1384:	8b 45 08             	mov    0x8(%ebp),%eax
    1387:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    138a:	0f b6 10             	movzbl (%eax),%edx
    138d:	84 d2                	test   %dl,%dl
    138f:	74 1d                	je     13ae <strchr+0x2e>
    if(*s == c)
    1391:	38 d3                	cmp    %dl,%bl
    1393:	89 d9                	mov    %ebx,%ecx
    1395:	75 0d                	jne    13a4 <strchr+0x24>
    1397:	eb 17                	jmp    13b0 <strchr+0x30>
    1399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13a0:	38 ca                	cmp    %cl,%dl
    13a2:	74 0c                	je     13b0 <strchr+0x30>
  for(; *s; s++)
    13a4:	83 c0 01             	add    $0x1,%eax
    13a7:	0f b6 10             	movzbl (%eax),%edx
    13aa:	84 d2                	test   %dl,%dl
    13ac:	75 f2                	jne    13a0 <strchr+0x20>
      return (char*)s;
  return 0;
    13ae:	31 c0                	xor    %eax,%eax
}
    13b0:	5b                   	pop    %ebx
    13b1:	5d                   	pop    %ebp
    13b2:	c3                   	ret    
    13b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    13b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000013c0 <gets>:

char*
gets(char *buf, int max)
{
    13c0:	55                   	push   %ebp
    13c1:	89 e5                	mov    %esp,%ebp
    13c3:	57                   	push   %edi
    13c4:	56                   	push   %esi
    13c5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    13c6:	31 f6                	xor    %esi,%esi
    13c8:	89 f3                	mov    %esi,%ebx
{
    13ca:	83 ec 1c             	sub    $0x1c,%esp
    13cd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    13d0:	eb 2f                	jmp    1401 <gets+0x41>
    13d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    13d8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    13db:	83 ec 04             	sub    $0x4,%esp
    13de:	6a 01                	push   $0x1
    13e0:	50                   	push   %eax
    13e1:	6a 00                	push   $0x0
    13e3:	e8 32 01 00 00       	call   151a <read>
    if(cc < 1)
    13e8:	83 c4 10             	add    $0x10,%esp
    13eb:	85 c0                	test   %eax,%eax
    13ed:	7e 1c                	jle    140b <gets+0x4b>
      break;
    buf[i++] = c;
    13ef:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    13f3:	83 c7 01             	add    $0x1,%edi
    13f6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    13f9:	3c 0a                	cmp    $0xa,%al
    13fb:	74 23                	je     1420 <gets+0x60>
    13fd:	3c 0d                	cmp    $0xd,%al
    13ff:	74 1f                	je     1420 <gets+0x60>
  for(i=0; i+1 < max; ){
    1401:	83 c3 01             	add    $0x1,%ebx
    1404:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1407:	89 fe                	mov    %edi,%esi
    1409:	7c cd                	jl     13d8 <gets+0x18>
    140b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    140d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1410:	c6 03 00             	movb   $0x0,(%ebx)
}
    1413:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1416:	5b                   	pop    %ebx
    1417:	5e                   	pop    %esi
    1418:	5f                   	pop    %edi
    1419:	5d                   	pop    %ebp
    141a:	c3                   	ret    
    141b:	90                   	nop
    141c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1420:	8b 75 08             	mov    0x8(%ebp),%esi
    1423:	8b 45 08             	mov    0x8(%ebp),%eax
    1426:	01 de                	add    %ebx,%esi
    1428:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    142a:	c6 03 00             	movb   $0x0,(%ebx)
}
    142d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1430:	5b                   	pop    %ebx
    1431:	5e                   	pop    %esi
    1432:	5f                   	pop    %edi
    1433:	5d                   	pop    %ebp
    1434:	c3                   	ret    
    1435:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001440 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
    1440:	55                   	push   %ebp
    1441:	89 e5                	mov    %esp,%ebp
    1443:	56                   	push   %esi
    1444:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1445:	83 ec 08             	sub    $0x8,%esp
    1448:	6a 00                	push   $0x0
    144a:	ff 75 08             	pushl  0x8(%ebp)
    144d:	e8 f8 00 00 00       	call   154a <open>
  if(fd < 0)
    1452:	83 c4 10             	add    $0x10,%esp
    1455:	85 c0                	test   %eax,%eax
    1457:	78 27                	js     1480 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1459:	83 ec 08             	sub    $0x8,%esp
    145c:	ff 75 0c             	pushl  0xc(%ebp)
    145f:	89 c3                	mov    %eax,%ebx
    1461:	50                   	push   %eax
    1462:	e8 fb 00 00 00       	call   1562 <fstat>
  close(fd);
    1467:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    146a:	89 c6                	mov    %eax,%esi
  close(fd);
    146c:	e8 c1 00 00 00       	call   1532 <close>
  return r;
    1471:	83 c4 10             	add    $0x10,%esp
}
    1474:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1477:	89 f0                	mov    %esi,%eax
    1479:	5b                   	pop    %ebx
    147a:	5e                   	pop    %esi
    147b:	5d                   	pop    %ebp
    147c:	c3                   	ret    
    147d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1480:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1485:	eb ed                	jmp    1474 <stat+0x34>
    1487:	89 f6                	mov    %esi,%esi
    1489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001490 <atoi>:

int
atoi(const char *s)
{
    1490:	55                   	push   %ebp
    1491:	89 e5                	mov    %esp,%ebp
    1493:	53                   	push   %ebx
    1494:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1497:	0f be 11             	movsbl (%ecx),%edx
    149a:	8d 42 d0             	lea    -0x30(%edx),%eax
    149d:	3c 09                	cmp    $0x9,%al
  n = 0;
    149f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    14a4:	77 1f                	ja     14c5 <atoi+0x35>
    14a6:	8d 76 00             	lea    0x0(%esi),%esi
    14a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    14b0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    14b3:	83 c1 01             	add    $0x1,%ecx
    14b6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    14ba:	0f be 11             	movsbl (%ecx),%edx
    14bd:	8d 5a d0             	lea    -0x30(%edx),%ebx
    14c0:	80 fb 09             	cmp    $0x9,%bl
    14c3:	76 eb                	jbe    14b0 <atoi+0x20>
  return n;
}
    14c5:	5b                   	pop    %ebx
    14c6:	5d                   	pop    %ebp
    14c7:	c3                   	ret    
    14c8:	90                   	nop
    14c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000014d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    14d0:	55                   	push   %ebp
    14d1:	89 e5                	mov    %esp,%ebp
    14d3:	56                   	push   %esi
    14d4:	53                   	push   %ebx
    14d5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    14d8:	8b 45 08             	mov    0x8(%ebp),%eax
    14db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    14de:	85 db                	test   %ebx,%ebx
    14e0:	7e 14                	jle    14f6 <memmove+0x26>
    14e2:	31 d2                	xor    %edx,%edx
    14e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    14e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    14ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    14ef:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    14f2:	39 d3                	cmp    %edx,%ebx
    14f4:	75 f2                	jne    14e8 <memmove+0x18>
  return vdst;
}
    14f6:	5b                   	pop    %ebx
    14f7:	5e                   	pop    %esi
    14f8:	5d                   	pop    %ebp
    14f9:	c3                   	ret    

000014fa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    14fa:	b8 01 00 00 00       	mov    $0x1,%eax
    14ff:	cd 40                	int    $0x40
    1501:	c3                   	ret    

00001502 <exit>:
SYSCALL(exit)
    1502:	b8 02 00 00 00       	mov    $0x2,%eax
    1507:	cd 40                	int    $0x40
    1509:	c3                   	ret    

0000150a <wait>:
SYSCALL(wait)
    150a:	b8 03 00 00 00       	mov    $0x3,%eax
    150f:	cd 40                	int    $0x40
    1511:	c3                   	ret    

00001512 <pipe>:
SYSCALL(pipe)
    1512:	b8 04 00 00 00       	mov    $0x4,%eax
    1517:	cd 40                	int    $0x40
    1519:	c3                   	ret    

0000151a <read>:
SYSCALL(read)
    151a:	b8 05 00 00 00       	mov    $0x5,%eax
    151f:	cd 40                	int    $0x40
    1521:	c3                   	ret    

00001522 <steal>:
SYSCALL(steal)
    1522:	b8 17 00 00 00       	mov    $0x17,%eax
    1527:	cd 40                	int    $0x40
    1529:	c3                   	ret    

0000152a <write>:
SYSCALL(write)
    152a:	b8 10 00 00 00       	mov    $0x10,%eax
    152f:	cd 40                	int    $0x40
    1531:	c3                   	ret    

00001532 <close>:
SYSCALL(close)
    1532:	b8 15 00 00 00       	mov    $0x15,%eax
    1537:	cd 40                	int    $0x40
    1539:	c3                   	ret    

0000153a <kill>:
SYSCALL(kill)
    153a:	b8 06 00 00 00       	mov    $0x6,%eax
    153f:	cd 40                	int    $0x40
    1541:	c3                   	ret    

00001542 <exec>:
SYSCALL(exec)
    1542:	b8 07 00 00 00       	mov    $0x7,%eax
    1547:	cd 40                	int    $0x40
    1549:	c3                   	ret    

0000154a <open>:
SYSCALL(open)
    154a:	b8 0f 00 00 00       	mov    $0xf,%eax
    154f:	cd 40                	int    $0x40
    1551:	c3                   	ret    

00001552 <mknod>:
SYSCALL(mknod)
    1552:	b8 11 00 00 00       	mov    $0x11,%eax
    1557:	cd 40                	int    $0x40
    1559:	c3                   	ret    

0000155a <unlink>:
SYSCALL(unlink)
    155a:	b8 12 00 00 00       	mov    $0x12,%eax
    155f:	cd 40                	int    $0x40
    1561:	c3                   	ret    

00001562 <fstat>:
SYSCALL(fstat)
    1562:	b8 08 00 00 00       	mov    $0x8,%eax
    1567:	cd 40                	int    $0x40
    1569:	c3                   	ret    

0000156a <link>:
SYSCALL(link)
    156a:	b8 13 00 00 00       	mov    $0x13,%eax
    156f:	cd 40                	int    $0x40
    1571:	c3                   	ret    

00001572 <mkdir>:
SYSCALL(mkdir)
    1572:	b8 14 00 00 00       	mov    $0x14,%eax
    1577:	cd 40                	int    $0x40
    1579:	c3                   	ret    

0000157a <chdir>:
SYSCALL(chdir)
    157a:	b8 09 00 00 00       	mov    $0x9,%eax
    157f:	cd 40                	int    $0x40
    1581:	c3                   	ret    

00001582 <dup>:
SYSCALL(dup)
    1582:	b8 0a 00 00 00       	mov    $0xa,%eax
    1587:	cd 40                	int    $0x40
    1589:	c3                   	ret    

0000158a <getpid>:
SYSCALL(getpid)
    158a:	b8 0b 00 00 00       	mov    $0xb,%eax
    158f:	cd 40                	int    $0x40
    1591:	c3                   	ret    

00001592 <sbrk>:
SYSCALL(sbrk)
    1592:	b8 0c 00 00 00       	mov    $0xc,%eax
    1597:	cd 40                	int    $0x40
    1599:	c3                   	ret    

0000159a <sleep>:
SYSCALL(sleep)
    159a:	b8 0d 00 00 00       	mov    $0xd,%eax
    159f:	cd 40                	int    $0x40
    15a1:	c3                   	ret    

000015a2 <uptime>:
SYSCALL(uptime)
    15a2:	b8 0e 00 00 00       	mov    $0xe,%eax
    15a7:	cd 40                	int    $0x40
    15a9:	c3                   	ret    

000015aa <cpuhalt>:
SYSCALL(cpuhalt)
    15aa:	b8 16 00 00 00       	mov    $0x16,%eax
    15af:	cd 40                	int    $0x40
    15b1:	c3                   	ret    
    15b2:	66 90                	xchg   %ax,%ax
    15b4:	66 90                	xchg   %ax,%ax
    15b6:	66 90                	xchg   %ax,%ax
    15b8:	66 90                	xchg   %ax,%ax
    15ba:	66 90                	xchg   %ax,%ax
    15bc:	66 90                	xchg   %ax,%ax
    15be:	66 90                	xchg   %ax,%ax

000015c0 <printint.constprop.1>:
    15c0:	55                   	push   %ebp
    15c1:	89 e5                	mov    %esp,%ebp
    15c3:	57                   	push   %edi
    15c4:	56                   	push   %esi
    15c5:	53                   	push   %ebx
    15c6:	89 d6                	mov    %edx,%esi
    15c8:	83 ec 3c             	sub    $0x3c,%esp
    15cb:	85 c0                	test   %eax,%eax
    15cd:	79 71                	jns    1640 <printint.constprop.1+0x80>
    15cf:	83 e1 01             	and    $0x1,%ecx
    15d2:	74 6c                	je     1640 <printint.constprop.1+0x80>
    15d4:	f7 d8                	neg    %eax
    15d6:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    15dd:	31 c9                	xor    %ecx,%ecx
    15df:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    15e2:	eb 06                	jmp    15ea <printint.constprop.1+0x2a>
    15e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    15e8:	89 f9                	mov    %edi,%ecx
    15ea:	31 d2                	xor    %edx,%edx
    15ec:	8d 79 01             	lea    0x1(%ecx),%edi
    15ef:	f7 f6                	div    %esi
    15f1:	0f b6 92 14 1d 00 00 	movzbl 0x1d14(%edx),%edx
    15f8:	85 c0                	test   %eax,%eax
    15fa:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
    15fd:	75 e9                	jne    15e8 <printint.constprop.1+0x28>
    15ff:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1602:	85 c0                	test   %eax,%eax
    1604:	74 08                	je     160e <printint.constprop.1+0x4e>
    1606:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    160b:	8d 79 02             	lea    0x2(%ecx),%edi
    160e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    1612:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1618:	0f b6 06             	movzbl (%esi),%eax
    161b:	83 ec 04             	sub    $0x4,%esp
    161e:	83 ee 01             	sub    $0x1,%esi
    1621:	6a 01                	push   $0x1
    1623:	53                   	push   %ebx
    1624:	6a 01                	push   $0x1
    1626:	88 45 d7             	mov    %al,-0x29(%ebp)
    1629:	e8 fc fe ff ff       	call   152a <write>
    162e:	83 c4 10             	add    $0x10,%esp
    1631:	39 de                	cmp    %ebx,%esi
    1633:	75 e3                	jne    1618 <printint.constprop.1+0x58>
    1635:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1638:	5b                   	pop    %ebx
    1639:	5e                   	pop    %esi
    163a:	5f                   	pop    %edi
    163b:	5d                   	pop    %ebp
    163c:	c3                   	ret    
    163d:	8d 76 00             	lea    0x0(%esi),%esi
    1640:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1647:	eb 94                	jmp    15dd <printint.constprop.1+0x1d>
    1649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001650 <vprintf.constprop.0>:
    1650:	55                   	push   %ebp
    1651:	89 e5                	mov    %esp,%ebp
    1653:	57                   	push   %edi
    1654:	56                   	push   %esi
    1655:	53                   	push   %ebx
    1656:	89 d6                	mov    %edx,%esi
    1658:	83 ec 2c             	sub    $0x2c,%esp
    165b:	0f b6 10             	movzbl (%eax),%edx
    165e:	84 d2                	test   %dl,%dl
    1660:	0f 84 cd 00 00 00    	je     1733 <vprintf.constprop.0+0xe3>
    1666:	8d 58 01             	lea    0x1(%eax),%ebx
    1669:	31 ff                	xor    %edi,%edi
    166b:	eb 31                	jmp    169e <vprintf.constprop.0+0x4e>
    166d:	8d 76 00             	lea    0x0(%esi),%esi
    1670:	83 f8 25             	cmp    $0x25,%eax
    1673:	0f 84 c7 00 00 00    	je     1740 <vprintf.constprop.0+0xf0>
    1679:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    167c:	83 ec 04             	sub    $0x4,%esp
    167f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
    1682:	6a 01                	push   $0x1
    1684:	50                   	push   %eax
    1685:	6a 01                	push   $0x1
    1687:	e8 9e fe ff ff       	call   152a <write>
    168c:	83 c4 10             	add    $0x10,%esp
    168f:	83 c3 01             	add    $0x1,%ebx
    1692:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1696:	84 d2                	test   %dl,%dl
    1698:	0f 84 95 00 00 00    	je     1733 <vprintf.constprop.0+0xe3>
    169e:	85 ff                	test   %edi,%edi
    16a0:	0f b6 c2             	movzbl %dl,%eax
    16a3:	74 cb                	je     1670 <vprintf.constprop.0+0x20>
    16a5:	83 ff 25             	cmp    $0x25,%edi
    16a8:	75 e5                	jne    168f <vprintf.constprop.0+0x3f>
    16aa:	83 f8 64             	cmp    $0x64,%eax
    16ad:	8d 7e 04             	lea    0x4(%esi),%edi
    16b0:	b9 01 00 00 00       	mov    $0x1,%ecx
    16b5:	0f 84 9a 00 00 00    	je     1755 <vprintf.constprop.0+0x105>
    16bb:	83 f8 6c             	cmp    $0x6c,%eax
    16be:	0f 84 8c 00 00 00    	je     1750 <vprintf.constprop.0+0x100>
    16c4:	83 f8 78             	cmp    $0x78,%eax
    16c7:	0f 84 a3 00 00 00    	je     1770 <vprintf.constprop.0+0x120>
    16cd:	83 f8 70             	cmp    $0x70,%eax
    16d0:	0f 84 ca 00 00 00    	je     17a0 <vprintf.constprop.0+0x150>
    16d6:	83 f8 73             	cmp    $0x73,%eax
    16d9:	0f 84 39 01 00 00    	je     1818 <vprintf.constprop.0+0x1c8>
    16df:	83 f8 63             	cmp    $0x63,%eax
    16e2:	0f 84 68 01 00 00    	je     1850 <vprintf.constprop.0+0x200>
    16e8:	83 f8 25             	cmp    $0x25,%eax
    16eb:	0f 84 9f 00 00 00    	je     1790 <vprintf.constprop.0+0x140>
    16f1:	8d 45 df             	lea    -0x21(%ebp),%eax
    16f4:	83 ec 04             	sub    $0x4,%esp
    16f7:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    16fa:	6a 01                	push   $0x1
    16fc:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
    1700:	50                   	push   %eax
    1701:	6a 01                	push   $0x1
    1703:	e8 22 fe ff ff       	call   152a <write>
    1708:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    170c:	83 c4 0c             	add    $0xc,%esp
    170f:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1712:	6a 01                	push   $0x1
    1714:	88 55 e0             	mov    %dl,-0x20(%ebp)
    1717:	50                   	push   %eax
    1718:	6a 01                	push   $0x1
    171a:	83 c3 01             	add    $0x1,%ebx
    171d:	31 ff                	xor    %edi,%edi
    171f:	e8 06 fe ff ff       	call   152a <write>
    1724:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1728:	83 c4 10             	add    $0x10,%esp
    172b:	84 d2                	test   %dl,%dl
    172d:	0f 85 6b ff ff ff    	jne    169e <vprintf.constprop.0+0x4e>
    1733:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1736:	5b                   	pop    %ebx
    1737:	5e                   	pop    %esi
    1738:	5f                   	pop    %edi
    1739:	5d                   	pop    %ebp
    173a:	c3                   	ret    
    173b:	90                   	nop
    173c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1740:	bf 25 00 00 00       	mov    $0x25,%edi
    1745:	e9 45 ff ff ff       	jmp    168f <vprintf.constprop.0+0x3f>
    174a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1750:	8d 7e 04             	lea    0x4(%esi),%edi
    1753:	31 c9                	xor    %ecx,%ecx
    1755:	8b 06                	mov    (%esi),%eax
    1757:	ba 0a 00 00 00       	mov    $0xa,%edx
    175c:	89 fe                	mov    %edi,%esi
    175e:	31 ff                	xor    %edi,%edi
    1760:	e8 5b fe ff ff       	call   15c0 <printint.constprop.1>
    1765:	e9 25 ff ff ff       	jmp    168f <vprintf.constprop.0+0x3f>
    176a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1770:	8b 06                	mov    (%esi),%eax
    1772:	8d 7e 04             	lea    0x4(%esi),%edi
    1775:	31 c9                	xor    %ecx,%ecx
    1777:	ba 10 00 00 00       	mov    $0x10,%edx
    177c:	89 fe                	mov    %edi,%esi
    177e:	31 ff                	xor    %edi,%edi
    1780:	e8 3b fe ff ff       	call   15c0 <printint.constprop.1>
    1785:	e9 05 ff ff ff       	jmp    168f <vprintf.constprop.0+0x3f>
    178a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1790:	83 ec 04             	sub    $0x4,%esp
    1793:	88 55 e1             	mov    %dl,-0x1f(%ebp)
    1796:	8d 45 e1             	lea    -0x1f(%ebp),%eax
    1799:	6a 01                	push   $0x1
    179b:	e9 77 ff ff ff       	jmp    1717 <vprintf.constprop.0+0xc7>
    17a0:	8d 46 04             	lea    0x4(%esi),%eax
    17a3:	83 ec 04             	sub    $0x4,%esp
    17a6:	8b 3e                	mov    (%esi),%edi
    17a8:	6a 01                	push   $0x1
    17aa:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
    17ae:	be 08 00 00 00       	mov    $0x8,%esi
    17b3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    17b6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    17b9:	50                   	push   %eax
    17ba:	6a 01                	push   $0x1
    17bc:	e8 69 fd ff ff       	call   152a <write>
    17c1:	8d 45 e7             	lea    -0x19(%ebp),%eax
    17c4:	83 c4 0c             	add    $0xc,%esp
    17c7:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
    17cb:	6a 01                	push   $0x1
    17cd:	50                   	push   %eax
    17ce:	6a 01                	push   $0x1
    17d0:	e8 55 fd ff ff       	call   152a <write>
    17d5:	83 c4 10             	add    $0x10,%esp
    17d8:	90                   	nop
    17d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    17e0:	89 f8                	mov    %edi,%eax
    17e2:	83 ec 04             	sub    $0x4,%esp
    17e5:	c1 e7 04             	shl    $0x4,%edi
    17e8:	c1 e8 1c             	shr    $0x1c,%eax
    17eb:	6a 01                	push   $0x1
    17ed:	0f b6 80 14 1d 00 00 	movzbl 0x1d14(%eax),%eax
    17f4:	88 45 e5             	mov    %al,-0x1b(%ebp)
    17f7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    17fa:	50                   	push   %eax
    17fb:	6a 01                	push   $0x1
    17fd:	e8 28 fd ff ff       	call   152a <write>
    1802:	83 c4 10             	add    $0x10,%esp
    1805:	83 ee 01             	sub    $0x1,%esi
    1808:	75 d6                	jne    17e0 <vprintf.constprop.0+0x190>
    180a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    180d:	31 ff                	xor    %edi,%edi
    180f:	e9 7b fe ff ff       	jmp    168f <vprintf.constprop.0+0x3f>
    1814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1818:	8b 3e                	mov    (%esi),%edi
    181a:	8d 46 04             	lea    0x4(%esi),%eax
    181d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1820:	85 ff                	test   %edi,%edi
    1822:	74 50                	je     1874 <vprintf.constprop.0+0x224>
    1824:	0f b6 07             	movzbl (%edi),%eax
    1827:	84 c0                	test   %al,%al
    1829:	74 df                	je     180a <vprintf.constprop.0+0x1ba>
    182b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
    182e:	66 90                	xchg   %ax,%ax
    1830:	83 ec 04             	sub    $0x4,%esp
    1833:	83 c7 01             	add    $0x1,%edi
    1836:	88 45 e3             	mov    %al,-0x1d(%ebp)
    1839:	6a 01                	push   $0x1
    183b:	56                   	push   %esi
    183c:	6a 01                	push   $0x1
    183e:	e8 e7 fc ff ff       	call   152a <write>
    1843:	0f b6 07             	movzbl (%edi),%eax
    1846:	83 c4 10             	add    $0x10,%esp
    1849:	84 c0                	test   %al,%al
    184b:	75 e3                	jne    1830 <vprintf.constprop.0+0x1e0>
    184d:	eb bb                	jmp    180a <vprintf.constprop.0+0x1ba>
    184f:	90                   	nop
    1850:	8b 06                	mov    (%esi),%eax
    1852:	83 ec 04             	sub    $0x4,%esp
    1855:	8d 7e 04             	lea    0x4(%esi),%edi
    1858:	6a 01                	push   $0x1
    185a:	89 fe                	mov    %edi,%esi
    185c:	31 ff                	xor    %edi,%edi
    185e:	88 45 e2             	mov    %al,-0x1e(%ebp)
    1861:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1864:	50                   	push   %eax
    1865:	6a 01                	push   $0x1
    1867:	e8 be fc ff ff       	call   152a <write>
    186c:	83 c4 10             	add    $0x10,%esp
    186f:	e9 1b fe ff ff       	jmp    168f <vprintf.constprop.0+0x3f>
    1874:	bf 0c 1d 00 00       	mov    $0x1d0c,%edi
    1879:	b8 28 00 00 00       	mov    $0x28,%eax
    187e:	eb ab                	jmp    182b <vprintf.constprop.0+0x1db>

00001880 <fprintf>:
    1880:	55                   	push   %ebp
    1881:	89 e5                	mov    %esp,%ebp
    1883:	83 ec 08             	sub    $0x8,%esp
    1886:	8b 45 0c             	mov    0xc(%ebp),%eax
    1889:	8d 55 10             	lea    0x10(%ebp),%edx
    188c:	e8 bf fd ff ff       	call   1650 <vprintf.constprop.0>
    1891:	c9                   	leave  
    1892:	c3                   	ret    
    1893:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000018a0 <printf>:
    18a0:	55                   	push   %ebp
    18a1:	89 e5                	mov    %esp,%ebp
    18a3:	83 ec 08             	sub    $0x8,%esp
    18a6:	8b 45 08             	mov    0x8(%ebp),%eax
    18a9:	8d 55 0c             	lea    0xc(%ebp),%edx
    18ac:	e8 9f fd ff ff       	call   1650 <vprintf.constprop.0>
    18b1:	c9                   	leave  
    18b2:	c3                   	ret    
    18b3:	66 90                	xchg   %ax,%ax
    18b5:	66 90                	xchg   %ax,%ax
    18b7:	66 90                	xchg   %ax,%ax
    18b9:	66 90                	xchg   %ax,%ax
    18bb:	66 90                	xchg   %ax,%ax
    18bd:	66 90                	xchg   %ax,%ax
    18bf:	90                   	nop

000018c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    18c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18c1:	a1 a8 29 00 00       	mov    0x29a8,%eax
{
    18c6:	89 e5                	mov    %esp,%ebp
    18c8:	57                   	push   %edi
    18c9:	56                   	push   %esi
    18ca:	53                   	push   %ebx
    18cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    18ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    18d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18d8:	39 c8                	cmp    %ecx,%eax
    18da:	8b 10                	mov    (%eax),%edx
    18dc:	73 32                	jae    1910 <free+0x50>
    18de:	39 d1                	cmp    %edx,%ecx
    18e0:	72 04                	jb     18e6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    18e2:	39 d0                	cmp    %edx,%eax
    18e4:	72 32                	jb     1918 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    18e6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    18e9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    18ec:	39 fa                	cmp    %edi,%edx
    18ee:	74 30                	je     1920 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    18f0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    18f3:	8b 50 04             	mov    0x4(%eax),%edx
    18f6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    18f9:	39 f1                	cmp    %esi,%ecx
    18fb:	74 3a                	je     1937 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    18fd:	89 08                	mov    %ecx,(%eax)
  freep = p;
    18ff:	a3 a8 29 00 00       	mov    %eax,0x29a8
}
    1904:	5b                   	pop    %ebx
    1905:	5e                   	pop    %esi
    1906:	5f                   	pop    %edi
    1907:	5d                   	pop    %ebp
    1908:	c3                   	ret    
    1909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1910:	39 d0                	cmp    %edx,%eax
    1912:	72 04                	jb     1918 <free+0x58>
    1914:	39 d1                	cmp    %edx,%ecx
    1916:	72 ce                	jb     18e6 <free+0x26>
{
    1918:	89 d0                	mov    %edx,%eax
    191a:	eb bc                	jmp    18d8 <free+0x18>
    191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1920:	03 72 04             	add    0x4(%edx),%esi
    1923:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1926:	8b 10                	mov    (%eax),%edx
    1928:	8b 12                	mov    (%edx),%edx
    192a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    192d:	8b 50 04             	mov    0x4(%eax),%edx
    1930:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1933:	39 f1                	cmp    %esi,%ecx
    1935:	75 c6                	jne    18fd <free+0x3d>
    p->s.size += bp->s.size;
    1937:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    193a:	a3 a8 29 00 00       	mov    %eax,0x29a8
    p->s.size += bp->s.size;
    193f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1942:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1945:	89 10                	mov    %edx,(%eax)
}
    1947:	5b                   	pop    %ebx
    1948:	5e                   	pop    %esi
    1949:	5f                   	pop    %edi
    194a:	5d                   	pop    %ebp
    194b:	c3                   	ret    
    194c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001950 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1950:	55                   	push   %ebp
    1951:	89 e5                	mov    %esp,%ebp
    1953:	57                   	push   %edi
    1954:	56                   	push   %esi
    1955:	53                   	push   %ebx
    1956:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1959:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    195c:	8b 15 a8 29 00 00    	mov    0x29a8,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1962:	8d 78 07             	lea    0x7(%eax),%edi
    1965:	c1 ef 03             	shr    $0x3,%edi
    1968:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    196b:	85 d2                	test   %edx,%edx
    196d:	0f 84 9d 00 00 00    	je     1a10 <malloc+0xc0>
    1973:	8b 02                	mov    (%edx),%eax
    1975:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1978:	39 cf                	cmp    %ecx,%edi
    197a:	76 6c                	jbe    19e8 <malloc+0x98>
    197c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1982:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1987:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    198a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1991:	eb 0e                	jmp    19a1 <malloc+0x51>
    1993:	90                   	nop
    1994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1998:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    199a:	8b 48 04             	mov    0x4(%eax),%ecx
    199d:	39 f9                	cmp    %edi,%ecx
    199f:	73 47                	jae    19e8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    19a1:	39 05 a8 29 00 00    	cmp    %eax,0x29a8
    19a7:	89 c2                	mov    %eax,%edx
    19a9:	75 ed                	jne    1998 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    19ab:	83 ec 0c             	sub    $0xc,%esp
    19ae:	56                   	push   %esi
    19af:	e8 de fb ff ff       	call   1592 <sbrk>
  if(p == (char*)-1)
    19b4:	83 c4 10             	add    $0x10,%esp
    19b7:	83 f8 ff             	cmp    $0xffffffff,%eax
    19ba:	74 1c                	je     19d8 <malloc+0x88>
  hp->s.size = nu;
    19bc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    19bf:	83 ec 0c             	sub    $0xc,%esp
    19c2:	83 c0 08             	add    $0x8,%eax
    19c5:	50                   	push   %eax
    19c6:	e8 f5 fe ff ff       	call   18c0 <free>
  return freep;
    19cb:	8b 15 a8 29 00 00    	mov    0x29a8,%edx
      if((p = morecore(nunits)) == 0)
    19d1:	83 c4 10             	add    $0x10,%esp
    19d4:	85 d2                	test   %edx,%edx
    19d6:	75 c0                	jne    1998 <malloc+0x48>
        return 0;
  }
}
    19d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    19db:	31 c0                	xor    %eax,%eax
}
    19dd:	5b                   	pop    %ebx
    19de:	5e                   	pop    %esi
    19df:	5f                   	pop    %edi
    19e0:	5d                   	pop    %ebp
    19e1:	c3                   	ret    
    19e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    19e8:	39 cf                	cmp    %ecx,%edi
    19ea:	74 54                	je     1a40 <malloc+0xf0>
        p->s.size -= nunits;
    19ec:	29 f9                	sub    %edi,%ecx
    19ee:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    19f1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    19f4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    19f7:	89 15 a8 29 00 00    	mov    %edx,0x29a8
}
    19fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1a00:	83 c0 08             	add    $0x8,%eax
}
    1a03:	5b                   	pop    %ebx
    1a04:	5e                   	pop    %esi
    1a05:	5f                   	pop    %edi
    1a06:	5d                   	pop    %ebp
    1a07:	c3                   	ret    
    1a08:	90                   	nop
    1a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1a10:	c7 05 a8 29 00 00 ac 	movl   $0x29ac,0x29a8
    1a17:	29 00 00 
    1a1a:	c7 05 ac 29 00 00 ac 	movl   $0x29ac,0x29ac
    1a21:	29 00 00 
    base.s.size = 0;
    1a24:	b8 ac 29 00 00       	mov    $0x29ac,%eax
    1a29:	c7 05 b0 29 00 00 00 	movl   $0x0,0x29b0
    1a30:	00 00 00 
    1a33:	e9 44 ff ff ff       	jmp    197c <malloc+0x2c>
    1a38:	90                   	nop
    1a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1a40:	8b 08                	mov    (%eax),%ecx
    1a42:	89 0a                	mov    %ecx,(%edx)
    1a44:	eb b1                	jmp    19f7 <malloc+0xa7>
