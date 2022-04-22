
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
      85:	e8 26 07 00 00       	call   7b0 <MakeLinkedList>
  fprintf(2, "Welcome to xvEdit!\n");
      8a:	51                   	push   %ecx
      8b:	51                   	push   %ecx
      8c:	68 b3 1f 00 00       	push   $0x1fb3
      91:	6a 02                	push   $0x2
  file.lines = MakeLinkedList();
      93:	89 85 0c f8 ff ff    	mov    %eax,-0x7f4(%ebp)
  fprintf(2, "Welcome to xvEdit!\n");
      99:	e8 a2 1a 00 00       	call   1b40 <fprintf>

  // opening file
  file.fd = open(file.filename, O_RDONLY);
      9e:	5b                   	pop    %ebx
      9f:	5e                   	pop    %esi
      a0:	6a 00                	push   $0x0
      a2:	ff b5 00 f8 ff ff    	pushl  -0x800(%ebp)
      a8:	e8 5d 17 00 00       	call   180a <open>
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
      cf:	e8 2c 09 00 00       	call   a00 <gatherLines>
    fprintf(2, "%d lines read from %s\n", file.len, file.filename);
      d4:	ff b5 00 f8 ff ff    	pushl  -0x800(%ebp)
      da:	ff b5 10 f8 ff ff    	pushl  -0x7f0(%ebp)
      e0:	68 d7 1f 00 00       	push   $0x1fd7
      e5:	6a 02                	push   $0x2
      e7:	e8 54 1a 00 00       	call   1b40 <fprintf>
      ec:	83 c4 20             	add    $0x20,%esp
  }
  close(file.fd);
      ef:	83 ec 0c             	sub    $0xc,%esp
      f2:	ff b5 04 f8 ff ff    	pushl  -0x7fc(%ebp)
      f8:	8d 9d 18 f8 ff ff    	lea    -0x7e8(%ebp),%ebx
      fe:	e8 ef 16 00 00       	call   17f2 <close>
     103:	83 c4 10             	add    $0x10,%esp
     106:	8d 76 00             	lea    0x0(%esi),%esi
     109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // xvEdit>
  while (cmd != QUIT) {
    fprintf(2, "xvEdit> ");
     110:	83 ec 08             	sub    $0x8,%esp
     113:	68 ee 1f 00 00       	push   $0x1fee
     118:	6a 02                	push   $0x2
     11a:	e8 21 1a 00 00       	call   1b40 <fprintf>
    memset(buf, 0, nbuf);
     11f:	83 c4 0c             	add    $0xc,%esp
     122:	68 e8 03 00 00       	push   $0x3e8
     127:	6a 00                	push   $0x0
     129:	68 a0 29 00 00       	push   $0x29a0
     12e:	e8 ed 14 00 00       	call   1620 <memset>
    gets(buf, nbuf);
     133:	59                   	pop    %ecx
     134:	5e                   	pop    %esi
     135:	68 e8 03 00 00       	push   $0x3e8
     13a:	68 a0 29 00 00       	push   $0x29a0
     13f:	e8 3c 15 00 00       	call   1680 <gets>
    
    unline(buf);
     144:	c7 04 24 a0 29 00 00 	movl   $0x29a0,(%esp)
     14b:	e8 60 0b 00 00       	call   cb0 <unline>
    substr(cmdstr, buf, 0, 4);
     150:	6a 04                	push   $0x4
     152:	6a 00                	push   $0x0
     154:	68 a0 29 00 00       	push   $0x29a0
     159:	53                   	push   %ebx
     15a:	e8 b1 03 00 00       	call   510 <substr>
    return result;
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
     18a:	68 a0 29 00 00       	push   $0x29a0
     18f:	e8 5c 14 00 00       	call   15f0 <strlen>
     194:	89 1c 24             	mov    %ebx,(%esp)
     197:	89 c6                	mov    %eax,%esi
     199:	e8 52 14 00 00       	call   15f0 <strlen>
     19e:	83 c0 01             	add    $0x1,%eax
     1a1:	56                   	push   %esi
     1a2:	50                   	push   %eax
     1a3:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     1a9:	68 a0 29 00 00       	push   $0x29a0
     1ae:	50                   	push   %eax
     1af:	e8 5c 03 00 00       	call   510 <substr>

    if      (strcmp(cmdstr, "@END") == 0) {cmd = END;}
     1b4:	83 c4 18             	add    $0x18,%esp
     1b7:	68 f7 1f 00 00       	push   $0x1ff7
     1bc:	53                   	push   %ebx
     1bd:	e8 de 13 00 00       	call   15a0 <strcmp>
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
     1e7:	e8 34 06 00 00       	call   820 <insert>
  file->len++;
     1ec:	83 85 10 f8 ff ff 01 	addl   $0x1,-0x7f0(%ebp)
     1f3:	83 c4 10             	add    $0x10,%esp
     1f6:	e9 15 ff ff ff       	jmp    110 <main+0x110>
    fprintf(2, "only specify one file\n");
     1fb:	57                   	push   %edi
     1fc:	57                   	push   %edi
     1fd:	68 9c 1f 00 00       	push   $0x1f9c
     202:	6a 02                	push   $0x2
     204:	e8 37 19 00 00       	call   1b40 <fprintf>
    exit();
     209:	e8 b4 15 00 00       	call   17c2 <exit>
     20e:	66 90                	xchg   %ax,%ax
    else if (strcmp(cmdstr, "ADD<") == 0) {cmd = ADD;}
     210:	83 ec 08             	sub    $0x8,%esp
     213:	68 fc 1f 00 00       	push   $0x1ffc
     218:	53                   	push   %ebx
     219:	e8 82 13 00 00       	call   15a0 <strcmp>
     21e:	83 c4 10             	add    $0x10,%esp
     221:	85 c0                	test   %eax,%eax
     223:	0f 84 9c 00 00 00    	je     2c5 <main+0x2c5>
    else if (strcmp(cmdstr, "DROP") == 0) {cmd = DROP;}
     229:	52                   	push   %edx
     22a:	52                   	push   %edx
     22b:	68 01 20 00 00       	push   $0x2001
     230:	53                   	push   %ebx
     231:	e8 6a 13 00 00       	call   15a0 <strcmp>
     236:	83 c4 10             	add    $0x10,%esp
     239:	85 c0                	test   %eax,%eax
     23b:	0f 84 a0 00 00 00    	je     2e1 <main+0x2e1>
    else if (strcmp(cmdstr, "EDIT") == 0) {cmd = EDIT;}
     241:	50                   	push   %eax
     242:	50                   	push   %eax
     243:	68 06 20 00 00       	push   $0x2006
     248:	53                   	push   %ebx
     249:	e8 52 13 00 00       	call   15a0 <strcmp>
     24e:	83 c4 10             	add    $0x10,%esp
     251:	85 c0                	test   %eax,%eax
     253:	0f 84 b7 00 00 00    	je     310 <main+0x310>
    else if (strcmp(cmdstr, "LIST") == 0) {cmd = LIST;}
     259:	50                   	push   %eax
     25a:	50                   	push   %eax
     25b:	68 0b 20 00 00       	push   $0x200b
     260:	53                   	push   %ebx
     261:	e8 3a 13 00 00       	call   15a0 <strcmp>
     266:	83 c4 10             	add    $0x10,%esp
     269:	85 c0                	test   %eax,%eax
     26b:	0f 84 02 01 00 00    	je     373 <main+0x373>
    else if (strcmp(cmdstr, "SHOW") == 0) {cmd = SHOW;}
     271:	50                   	push   %eax
     272:	50                   	push   %eax
     273:	68 10 20 00 00       	push   $0x2010
     278:	53                   	push   %ebx
     279:	e8 22 13 00 00       	call   15a0 <strcmp>
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
     2aa:	e8 51 0b 00 00       	call   e00 <printl>
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
     2d4:	e8 f7 0c 00 00       	call   fd0 <add>
     2d9:	83 c4 10             	add    $0x10,%esp
     2dc:	e9 2f fe ff ff       	jmp    110 <main+0x110>
      drop(&file, args);
     2e1:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     2e7:	51                   	push   %ecx
     2e8:	51                   	push   %ecx
     2e9:	50                   	push   %eax
     2ea:	ff b5 f4 f7 ff ff    	pushl  -0x80c(%ebp)
     2f0:	e8 5b 0d 00 00       	call   1050 <drop>
     2f5:	83 c4 10             	add    $0x10,%esp
     2f8:	e9 13 fe ff ff       	jmp    110 <main+0x110>
    fprintf(2, "specify a file you want to edit\n");
     2fd:	50                   	push   %eax
     2fe:	50                   	push   %eax
     2ff:	68 b8 1e 00 00       	push   $0x1eb8
     304:	6a 02                	push   $0x2
     306:	e8 35 18 00 00       	call   1b40 <fprintf>
    exit();
     30b:	e8 b2 14 00 00       	call   17c2 <exit>
      edit(&file, args);
     310:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     316:	56                   	push   %esi
     317:	56                   	push   %esi
     318:	50                   	push   %eax
     319:	ff b5 f4 f7 ff ff    	pushl  -0x80c(%ebp)
     31f:	e8 ec 0e 00 00       	call   1210 <edit>
     324:	83 c4 10             	add    $0x10,%esp
     327:	e9 e4 fd ff ff       	jmp    110 <main+0x110>
    fprintf(2, "creating %s...\n",  file.filename);
     32c:	57                   	push   %edi
     32d:	ff b5 00 f8 ff ff    	pushl  -0x800(%ebp)
     333:	68 c7 1f 00 00       	push   $0x1fc7
     338:	6a 02                	push   $0x2
     33a:	e8 01 18 00 00       	call   1b40 <fprintf>
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     33f:	58                   	pop    %eax
     340:	5a                   	pop    %edx
     341:	68 01 02 00 00       	push   $0x201
     346:	ff b5 00 f8 ff ff    	pushl  -0x800(%ebp)
     34c:	e8 b9 14 00 00       	call   180a <open>
    close(file.fd);
     351:	89 04 24             	mov    %eax,(%esp)
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     354:	89 85 04 f8 ff ff    	mov    %eax,-0x7fc(%ebp)
    close(file.fd);
     35a:	e8 93 14 00 00       	call   17f2 <close>
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
     38d:	e8 2e 0f 00 00       	call   12c0 <list>
     392:	83 c4 20             	add    $0x20,%esp
     395:	e9 76 fd ff ff       	jmp    110 <main+0x110>
    else if (strcmp(cmdstr, "QUIT") == 0) {cmd = QUIT;}
     39a:	50                   	push   %eax
     39b:	50                   	push   %eax
     39c:	68 15 20 00 00       	push   $0x2015
     3a1:	53                   	push   %ebx
     3a2:	e8 f9 11 00 00       	call   15a0 <strcmp>
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
     3b0:	68 1a 20 00 00       	push   $0x201a
     3b5:	6a 02                	push   $0x2
     3b7:	e8 84 17 00 00       	call   1b40 <fprintf>
     3bc:	83 c4 10             	add    $0x10,%esp
     3bf:	e9 4c fd ff ff       	jmp    110 <main+0x110>
      quit(&file);
     3c4:	83 ec 0c             	sub    $0xc,%esp
     3c7:	ff b5 f4 f7 ff ff    	pushl  -0x80c(%ebp)
     3cd:	e8 5e 10 00 00       	call   1430 <quit>
  close(file.fd);
     3d2:	58                   	pop    %eax
     3d3:	ff b5 04 f8 ff ff    	pushl  -0x7fc(%ebp)
     3d9:	e8 14 14 00 00       	call   17f2 <close>
  exit();
     3de:	e8 df 13 00 00       	call   17c2 <exit>
     3e3:	66 90                	xchg   %ax,%ax
     3e5:	66 90                	xchg   %ax,%ax
     3e7:	66 90                	xchg   %ax,%ax
     3e9:	66 90                	xchg   %ax,%ax
     3eb:	66 90                	xchg   %ax,%ax
     3ed:	66 90                	xchg   %ax,%ax
     3ef:	90                   	nop

000003f0 <safestrcpy.part.0>:
  while(--n > 0 && (*s++ = *t++) != 0)
     3f0:	83 e9 01             	sub    $0x1,%ecx
     3f3:	85 c9                	test   %ecx,%ecx
     3f5:	7e 29                	jle    420 <safestrcpy.part.0+0x30>
safestrcpy(char *s, const char *t, int n) 
     3f7:	55                   	push   %ebp
     3f8:	89 e5                	mov    %esp,%ebp
     3fa:	53                   	push   %ebx
     3fb:	eb 0a                	jmp    407 <safestrcpy.part.0+0x17>
     3fd:	8d 76 00             	lea    0x0(%esi),%esi
  while(--n > 0 && (*s++ = *t++) != 0)
     400:	83 e9 01             	sub    $0x1,%ecx
     403:	85 c9                	test   %ecx,%ecx
     405:	7e 11                	jle    418 <safestrcpy.part.0+0x28>
     407:	83 c2 01             	add    $0x1,%edx
     40a:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
     40e:	83 c0 01             	add    $0x1,%eax
     411:	84 db                	test   %bl,%bl
     413:	88 58 ff             	mov    %bl,-0x1(%eax)
     416:	75 e8                	jne    400 <safestrcpy.part.0+0x10>
}
     418:	5b                   	pop    %ebx
  *s = 0;
     419:	c6 00 00             	movb   $0x0,(%eax)
}
     41c:	5d                   	pop    %ebp
     41d:	c3                   	ret    
     41e:	66 90                	xchg   %ax,%ax
  *s = 0;
     420:	c6 00 00             	movb   $0x0,(%eax)
     423:	c3                   	ret    
     424:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     42a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000430 <getLine>:
int getLine(int fileptr, char line[]) {
     430:	55                   	push   %ebp
     431:	89 e5                	mov    %esp,%ebp
     433:	57                   	push   %edi
     434:	56                   	push   %esi
     435:	53                   	push   %ebx
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     436:	31 ff                	xor    %edi,%edi
     438:	8d 75 e7             	lea    -0x19(%ebp),%esi
int getLine(int fileptr, char line[]) {
     43b:	83 ec 28             	sub    $0x28,%esp
     43e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int len = strlen(line);
     441:	53                   	push   %ebx
     442:	e8 a9 11 00 00       	call   15f0 <strlen>
  memset(line, 0, len);
     447:	83 c4 0c             	add    $0xc,%esp
     44a:	50                   	push   %eax
     44b:	6a 00                	push   $0x0
     44d:	53                   	push   %ebx
     44e:	e8 cd 11 00 00       	call   1620 <memset>
     453:	83 c4 10             	add    $0x10,%esp
     456:	eb 1e                	jmp    476 <getLine+0x46>
     458:	90                   	nop
     459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (*c == '\n') break;
     460:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     464:	3c 0a                	cmp    $0xa,%al
     466:	74 38                	je     4a0 <getLine+0x70>
    line[i] = *c;
     468:	88 04 3b             	mov    %al,(%ebx,%edi,1)
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     46b:	83 c7 01             	add    $0x1,%edi
     46e:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
     474:	74 42                	je     4b8 <getLine+0x88>
    if (read(fileptr, c, 1) == 0) return strlen(line);
     476:	83 ec 04             	sub    $0x4,%esp
     479:	6a 01                	push   $0x1
     47b:	56                   	push   %esi
     47c:	ff 75 08             	pushl  0x8(%ebp)
     47f:	e8 56 13 00 00       	call   17da <read>
     484:	83 c4 10             	add    $0x10,%esp
     487:	85 c0                	test   %eax,%eax
     489:	75 d5                	jne    460 <getLine+0x30>
     48b:	83 ec 0c             	sub    $0xc,%esp
     48e:	53                   	push   %ebx
     48f:	e8 5c 11 00 00       	call   15f0 <strlen>
     494:	83 c4 10             	add    $0x10,%esp
}
     497:	8d 65 f4             	lea    -0xc(%ebp),%esp
     49a:	5b                   	pop    %ebx
     49b:	5e                   	pop    %esi
     49c:	5f                   	pop    %edi
     49d:	5d                   	pop    %ebp
     49e:	c3                   	ret    
     49f:	90                   	nop
     4a0:	8d 57 01             	lea    0x1(%edi),%edx
  line[i + 1] = '\0';
     4a3:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
     4a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
     4aa:	b8 01 00 00 00       	mov    $0x1,%eax
}
     4af:	5b                   	pop    %ebx
     4b0:	5e                   	pop    %esi
     4b1:	5f                   	pop    %edi
     4b2:	5d                   	pop    %ebp
     4b3:	c3                   	ret    
     4b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     4b8:	ba e8 03 00 00       	mov    $0x3e8,%edx
     4bd:	eb e4                	jmp    4a3 <getLine+0x73>
     4bf:	90                   	nop

000004c0 <find>:
int find(char* str, char c) {
     4c0:	55                   	push   %ebp
     4c1:	89 e5                	mov    %esp,%ebp
     4c3:	57                   	push   %edi
     4c4:	56                   	push   %esi
     4c5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     4c6:	31 db                	xor    %ebx,%ebx
int find(char* str, char c) {
     4c8:	83 ec 0c             	sub    $0xc,%esp
     4cb:	8b 75 08             	mov    0x8(%ebp),%esi
     4ce:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
  for (int i = 0; i < strlen(str); i++)
     4d2:	eb 0e                	jmp    4e2 <find+0x22>
     4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     4d8:	89 f8                	mov    %edi,%eax
     4da:	38 04 1e             	cmp    %al,(%esi,%ebx,1)
     4dd:	74 18                	je     4f7 <find+0x37>
  for (int i = 0; i < strlen(str); i++)
     4df:	83 c3 01             	add    $0x1,%ebx
     4e2:	83 ec 0c             	sub    $0xc,%esp
     4e5:	56                   	push   %esi
     4e6:	e8 05 11 00 00       	call   15f0 <strlen>
     4eb:	83 c4 10             	add    $0x10,%esp
     4ee:	39 d8                	cmp    %ebx,%eax
     4f0:	77 e6                	ja     4d8 <find+0x18>
  return -1;
     4f2:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
     4f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     4fa:	89 d8                	mov    %ebx,%eax
     4fc:	5b                   	pop    %ebx
     4fd:	5e                   	pop    %esi
     4fe:	5f                   	pop    %edi
     4ff:	5d                   	pop    %ebp
     500:	c3                   	ret    
     501:	eb 0d                	jmp    510 <substr>
     503:	90                   	nop
     504:	90                   	nop
     505:	90                   	nop
     506:	90                   	nop
     507:	90                   	nop
     508:	90                   	nop
     509:	90                   	nop
     50a:	90                   	nop
     50b:	90                   	nop
     50c:	90                   	nop
     50d:	90                   	nop
     50e:	90                   	nop
     50f:	90                   	nop

00000510 <substr>:
void substr(char* dest, char* str, int start, int end) {
     510:	55                   	push   %ebp
     511:	89 e5                	mov    %esp,%ebp
     513:	57                   	push   %edi
     514:	56                   	push   %esi
     515:	53                   	push   %ebx
     516:	83 ec 18             	sub    $0x18,%esp
     519:	8b 7d 14             	mov    0x14(%ebp),%edi
  int len = strlen(str);
     51c:	ff 75 0c             	pushl  0xc(%ebp)
void substr(char* dest, char* str, int start, int end) {
     51f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     522:	8b 75 08             	mov    0x8(%ebp),%esi
  int len = strlen(str);
     525:	e8 c6 10 00 00       	call   15f0 <strlen>
     52a:	83 c4 10             	add    $0x10,%esp
     52d:	39 f8                	cmp    %edi,%eax
     52f:	0f 4e f8             	cmovle %eax,%edi
  while (i < end)
     532:	39 df                	cmp    %ebx,%edi
     534:	7e 1c                	jle    552 <substr+0x42>
     536:	8b 45 0c             	mov    0xc(%ebp),%eax
     539:	29 df                	sub    %ebx,%edi
  int s = 0, i = start;
     53b:	31 d2                	xor    %edx,%edx
     53d:	01 c3                	add    %eax,%ebx
     53f:	90                   	nop
    dest[s++] = str[i++];
     540:	83 c2 01             	add    $0x1,%edx
     543:	0f b6 44 13 ff       	movzbl -0x1(%ebx,%edx,1),%eax
  while (i < end)
     548:	39 fa                	cmp    %edi,%edx
    dest[s++] = str[i++];
     54a:	88 44 16 ff          	mov    %al,-0x1(%esi,%edx,1)
  while (i < end)
     54e:	75 f0                	jne    540 <substr+0x30>
     550:	01 d6                	add    %edx,%esi
  dest[s] = '\0';
     552:	c6 06 00             	movb   $0x0,(%esi)
}
     555:	8d 65 f4             	lea    -0xc(%ebp),%esp
     558:	5b                   	pop    %ebx
     559:	5e                   	pop    %esi
     55a:	5f                   	pop    %edi
     55b:	5d                   	pop    %ebp
     55c:	c3                   	ret    
     55d:	8d 76 00             	lea    0x0(%esi),%esi

00000560 <safestrcpy>:
{
     560:	55                   	push   %ebp
     561:	89 e5                	mov    %esp,%ebp
     563:	53                   	push   %ebx
     564:	8b 4d 10             	mov    0x10(%ebp),%ecx
     567:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(n <= 0)
     56a:	85 c9                	test   %ecx,%ecx
     56c:	7e 0a                	jle    578 <safestrcpy+0x18>
     56e:	8b 55 0c             	mov    0xc(%ebp),%edx
     571:	89 d8                	mov    %ebx,%eax
     573:	e8 78 fe ff ff       	call   3f0 <safestrcpy.part.0>
}
     578:	89 d8                	mov    %ebx,%eax
     57a:	5b                   	pop    %ebx
     57b:	5d                   	pop    %ebp
     57c:	c3                   	ret    
     57d:	8d 76 00             	lea    0x0(%esi),%esi

00000580 <negatoi>:
int negatoi(char* str) {
     580:	55                   	push   %ebp
     581:	89 e5                	mov    %esp,%ebp
     583:	53                   	push   %ebx
     584:	83 ec 04             	sub    $0x4,%esp
     587:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (str[0] == '-') {
     58a:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     58d:	74 11                	je     5a0 <negatoi+0x20>
}
     58f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     592:	c9                   	leave  
  return atoi(str);
     593:	e9 b8 11 00 00       	jmp    1750 <atoi>
     598:	90                   	nop
     599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    substr(str, str, 1, strlen(str));
     5a0:	83 ec 0c             	sub    $0xc,%esp
     5a3:	53                   	push   %ebx
     5a4:	e8 47 10 00 00       	call   15f0 <strlen>
     5a9:	50                   	push   %eax
     5aa:	6a 01                	push   $0x1
     5ac:	53                   	push   %ebx
     5ad:	53                   	push   %ebx
     5ae:	e8 5d ff ff ff       	call   510 <substr>
    return 0 - atoi(str);
     5b3:	83 c4 14             	add    $0x14,%esp
     5b6:	53                   	push   %ebx
     5b7:	e8 94 11 00 00       	call   1750 <atoi>
     5bc:	83 c4 10             	add    $0x10,%esp
     5bf:	f7 d8                	neg    %eax
}
     5c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5c4:	c9                   	leave  
     5c5:	c3                   	ret    
     5c6:	8d 76 00             	lea    0x0(%esi),%esi
     5c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005d0 <itoa>:
char* itoa(int value, char* result, int base) {
     5d0:	55                   	push   %ebp
     5d1:	89 e5                	mov    %esp,%ebp
     5d3:	57                   	push   %edi
     5d4:	56                   	push   %esi
     5d5:	53                   	push   %ebx
     5d6:	8b 5d 10             	mov    0x10(%ebp),%ebx
     5d9:	8b 4d 08             	mov    0x8(%ebp),%ecx
     5dc:	8b 75 0c             	mov    0xc(%ebp),%esi
    if (base < 2 || base > 36) { *result = '\0'; return result; }
     5df:	8d 43 fe             	lea    -0x2(%ebx),%eax
     5e2:	83 f8 22             	cmp    $0x22,%eax
     5e5:	76 0d                	jbe    5f4 <itoa+0x24>
     5e7:	eb 57                	jmp    640 <itoa+0x70>
     5e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5f0:	89 fe                	mov    %edi,%esi
     5f2:	89 c1                	mov    %eax,%ecx
     5f4:	89 c8                	mov    %ecx,%eax
        *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" [35 + (tmp_value - value * base)];
     5f6:	8d 7e 01             	lea    0x1(%esi),%edi
     5f9:	99                   	cltd   
     5fa:	f7 fb                	idiv   %ebx
     5fc:	0f b6 92 2b 1d 00 00 	movzbl 0x1d2b(%edx),%edx
    } while ( value );
     603:	85 c0                	test   %eax,%eax
        *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" [35 + (tmp_value - value * base)];
     605:	88 57 ff             	mov    %dl,-0x1(%edi)
    } while ( value );
     608:	75 e6                	jne    5f0 <itoa+0x20>
    if (tmp_value < 0) *ptr++ = '-';
     60a:	85 c9                	test   %ecx,%ecx
     60c:	78 42                	js     650 <itoa+0x80>
    *ptr-- = '\0';
     60e:	8d 47 ff             	lea    -0x1(%edi),%eax
    while(ptr1 < ptr) {
     611:	39 45 0c             	cmp    %eax,0xc(%ebp)
    *ptr-- = '\0';
     614:	c6 07 00             	movb   $0x0,(%edi)
    while(ptr1 < ptr) {
     617:	73 1d                	jae    636 <itoa+0x66>
     619:	8b 55 0c             	mov    0xc(%ebp),%edx
     61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        tmp_char = *ptr;
     620:	0f b6 08             	movzbl (%eax),%ecx
        *ptr--= *ptr1;
     623:	0f b6 1a             	movzbl (%edx),%ebx
     626:	83 e8 01             	sub    $0x1,%eax
        *ptr1++ = tmp_char;
     629:	83 c2 01             	add    $0x1,%edx
    while(ptr1 < ptr) {
     62c:	39 d0                	cmp    %edx,%eax
        *ptr--= *ptr1;
     62e:	88 58 01             	mov    %bl,0x1(%eax)
        *ptr1++ = tmp_char;
     631:	88 4a ff             	mov    %cl,-0x1(%edx)
    while(ptr1 < ptr) {
     634:	77 ea                	ja     620 <itoa+0x50>
}
     636:	5b                   	pop    %ebx
     637:	8b 45 0c             	mov    0xc(%ebp),%eax
     63a:	5e                   	pop    %esi
     63b:	5f                   	pop    %edi
     63c:	5d                   	pop    %ebp
     63d:	c3                   	ret    
     63e:	66 90                	xchg   %ax,%ax
    if (base < 2 || base > 36) { *result = '\0'; return result; }
     640:	c6 06 00             	movb   $0x0,(%esi)
}
     643:	8b 45 0c             	mov    0xc(%ebp),%eax
     646:	5b                   	pop    %ebx
     647:	5e                   	pop    %esi
     648:	5f                   	pop    %edi
     649:	5d                   	pop    %ebp
     64a:	c3                   	ret    
     64b:	90                   	nop
     64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (tmp_value < 0) *ptr++ = '-';
     650:	8d 7e 02             	lea    0x2(%esi),%edi
     653:	c6 46 01 2d          	movb   $0x2d,0x1(%esi)
    *ptr-- = '\0';
     657:	8d 47 ff             	lea    -0x1(%edi),%eax
    while(ptr1 < ptr) {
     65a:	39 45 0c             	cmp    %eax,0xc(%ebp)
    *ptr-- = '\0';
     65d:	c6 07 00             	movb   $0x0,(%edi)
    while(ptr1 < ptr) {
     660:	72 b7                	jb     619 <itoa+0x49>
     662:	eb d2                	jmp    636 <itoa+0x66>
     664:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     66a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000670 <toUpper>:
void toUpper(char* str) {
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	8b 55 08             	mov    0x8(%ebp),%edx
  while (str[i] != '\0') {
     676:	0f b6 02             	movzbl (%edx),%eax
     679:	84 c0                	test   %al,%al
     67b:	74 1a                	je     697 <toUpper+0x27>
     67d:	8d 76 00             	lea    0x0(%esi),%esi
    if (c <= 'z' && c >= 'a')
     680:	8d 48 9f             	lea    -0x61(%eax),%ecx
     683:	80 f9 19             	cmp    $0x19,%cl
     686:	77 05                	ja     68d <toUpper+0x1d>
      str[i] += ('Z' - 'z');
     688:	83 e8 20             	sub    $0x20,%eax
     68b:	88 02                	mov    %al,(%edx)
     68d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     690:	0f b6 02             	movzbl (%edx),%eax
     693:	84 c0                	test   %al,%al
     695:	75 e9                	jne    680 <toUpper+0x10>
    i++;  
  }
}
     697:	5d                   	pop    %ebp
     698:	c3                   	ret    
     699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006a0 <toLower>:

void toLower(char* str) {
     6a0:	55                   	push   %ebp
     6a1:	89 e5                	mov    %esp,%ebp
     6a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     6a6:	0f b6 02             	movzbl (%edx),%eax
     6a9:	84 c0                	test   %al,%al
     6ab:	74 1a                	je     6c7 <toLower+0x27>
     6ad:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'Z' && c >= 'A')
     6b0:	8d 48 bf             	lea    -0x41(%eax),%ecx
     6b3:	80 f9 19             	cmp    $0x19,%cl
     6b6:	77 05                	ja     6bd <toLower+0x1d>
      str[i] -= ('Z' - 'z');
     6b8:	83 c0 20             	add    $0x20,%eax
     6bb:	88 02                	mov    %al,(%edx)
     6bd:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     6c0:	0f b6 02             	movzbl (%edx),%eax
     6c3:	84 c0                	test   %al,%al
     6c5:	75 e9                	jne    6b0 <toLower+0x10>
    i++;  
  }
}
     6c7:	5d                   	pop    %ebp
     6c8:	c3                   	ret    
     6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006d0 <nullNode>:
Node* nullNode(char* data) {
     6d0:	55                   	push   %ebp
     6d1:	89 e5                	mov    %esp,%ebp
     6d3:	83 ec 14             	sub    $0x14,%esp
  struct Node* node = malloc(sizeof(Node));
     6d6:	6a 0c                	push   $0xc
     6d8:	e8 33 15 00 00       	call   1c10 <malloc>
  node->data = data;
     6dd:	8b 55 08             	mov    0x8(%ebp),%edx
  node->prev = nullptr;
     6e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->next = nullptr;
     6e6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  node->data = data;
     6ed:	89 50 04             	mov    %edx,0x4(%eax)
}
     6f0:	c9                   	leave  
     6f1:	c3                   	ret    
     6f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     6f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000700 <nodeAt>:
Node* nodeAt(struct LinkedList* list, int pos) {
     700:	55                   	push   %ebp
     701:	89 e5                	mov    %esp,%ebp
     703:	53                   	push   %ebx
     704:	8b 45 08             	mov    0x8(%ebp),%eax
     707:	8b 55 0c             	mov    0xc(%ebp),%edx
  if (pos > list->len)
     70a:	8b 48 08             	mov    0x8(%eax),%ecx
     70d:	39 d1                	cmp    %edx,%ecx
     70f:	7c 1f                	jl     730 <nodeAt+0x30>
  if ((pos < 0) && ((0 - pos) > list->len))
     711:	85 d2                	test   %edx,%edx
     713:	78 2b                	js     740 <nodeAt+0x40>
    curNode = list->head->next;
     715:	8b 00                	mov    (%eax),%eax
     717:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     71a:	74 0e                	je     72a <nodeAt+0x2a>
    int cur = 0;
     71c:	31 c9                	xor    %ecx,%ecx
     71e:	66 90                	xchg   %ax,%ax
      cur++;
     720:	83 c1 01             	add    $0x1,%ecx
      curNode = curNode->next;
     723:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     726:	39 ca                	cmp    %ecx,%edx
     728:	75 f6                	jne    720 <nodeAt+0x20>
}
     72a:	5b                   	pop    %ebx
     72b:	5d                   	pop    %ebp
     72c:	c3                   	ret    
     72d:	8d 76 00             	lea    0x0(%esi),%esi
    return list->tail->prev;
     730:	8b 40 04             	mov    0x4(%eax),%eax
}
     733:	5b                   	pop    %ebx
     734:	5d                   	pop    %ebp
    return list->tail->prev;
     735:	8b 00                	mov    (%eax),%eax
}
     737:	c3                   	ret    
     738:	90                   	nop
     739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if ((pos < 0) && ((0 - pos) > list->len))
     740:	89 d3                	mov    %edx,%ebx
     742:	f7 db                	neg    %ebx
     744:	39 d9                	cmp    %ebx,%ecx
     746:	7c 18                	jl     760 <nodeAt+0x60>
    while (++pos != 0)
     748:	83 c2 01             	add    $0x1,%edx
    curNode = list->tail;
     74b:	8b 40 04             	mov    0x4(%eax),%eax
    while (++pos != 0)
     74e:	74 da                	je     72a <nodeAt+0x2a>
     750:	83 c2 01             	add    $0x1,%edx
      curNode = curNode->prev;
     753:	8b 00                	mov    (%eax),%eax
    while (++pos != 0)
     755:	75 f9                	jne    750 <nodeAt+0x50>
}
     757:	5b                   	pop    %ebx
     758:	5d                   	pop    %ebp
     759:	c3                   	ret    
     75a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return list->head->next;
     760:	8b 00                	mov    (%eax),%eax
     762:	8b 40 08             	mov    0x8(%eax),%eax
     765:	eb c3                	jmp    72a <nodeAt+0x2a>
     767:	89 f6                	mov    %esi,%esi
     769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000770 <destroyNode>:
void destroyNode(struct LinkedList* list, struct Node* self) {
     770:	55                   	push   %ebp
     771:	89 e5                	mov    %esp,%ebp
     773:	56                   	push   %esi
     774:	53                   	push   %ebx
     775:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     778:	8b 75 08             	mov    0x8(%ebp),%esi
    free(self->data);
     77b:	83 ec 0c             	sub    $0xc,%esp
    self->prev->next = self->next;
     77e:	8b 03                	mov    (%ebx),%eax
     780:	8b 53 08             	mov    0x8(%ebx),%edx
     783:	89 50 08             	mov    %edx,0x8(%eax)
    self->next->prev = self->prev;
     786:	8b 43 08             	mov    0x8(%ebx),%eax
     789:	8b 13                	mov    (%ebx),%edx
     78b:	89 10                	mov    %edx,(%eax)
    free(self->data);
     78d:	ff 73 04             	pushl  0x4(%ebx)
     790:	e8 eb 13 00 00       	call   1b80 <free>
    free(self);
     795:	89 1c 24             	mov    %ebx,(%esp)
     798:	e8 e3 13 00 00       	call   1b80 <free>
    list->len--;
     79d:	83 6e 08 01          	subl   $0x1,0x8(%esi)
}
     7a1:	83 c4 10             	add    $0x10,%esp
     7a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     7a7:	5b                   	pop    %ebx
     7a8:	5e                   	pop    %esi
     7a9:	5d                   	pop    %ebp
     7aa:	c3                   	ret    
     7ab:	90                   	nop
     7ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007b0 <MakeLinkedList>:
LinkedList* MakeLinkedList() {
     7b0:	55                   	push   %ebp
     7b1:	89 e5                	mov    %esp,%ebp
     7b3:	56                   	push   %esi
     7b4:	53                   	push   %ebx
  struct LinkedList* list = malloc(sizeof(LinkedList));
     7b5:	83 ec 0c             	sub    $0xc,%esp
     7b8:	6a 0c                	push   $0xc
     7ba:	e8 51 14 00 00       	call   1c10 <malloc>
  struct Node* node = malloc(sizeof(Node));
     7bf:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  struct LinkedList* list = malloc(sizeof(LinkedList));
     7c6:	89 c6                	mov    %eax,%esi
  struct Node* node = malloc(sizeof(Node));
     7c8:	e8 43 14 00 00       	call   1c10 <malloc>
     7cd:	89 c3                	mov    %eax,%ebx
  node->prev = nullptr;
     7cf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->data = data;
     7d5:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  node->next = nullptr;
     7dc:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  struct Node* node = malloc(sizeof(Node));
     7e3:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     7ea:	e8 21 14 00 00       	call   1c10 <malloc>
  node->data = data;
     7ef:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  head->next = tail;
     7f6:	89 43 08             	mov    %eax,0x8(%ebx)
  head->prev = nullptr;
     7f9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  tail->prev = head;
     7ff:	89 18                	mov    %ebx,(%eax)
  tail->next = nullptr;
     801:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  list->tail = tail;
     808:	89 46 04             	mov    %eax,0x4(%esi)
}
     80b:	89 f0                	mov    %esi,%eax
  list->len = 0;
     80d:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
  list->head = head;
     814:	89 1e                	mov    %ebx,(%esi)
}
     816:	8d 65 f8             	lea    -0x8(%ebp),%esp
     819:	5b                   	pop    %ebx
     81a:	5e                   	pop    %esi
     81b:	5d                   	pop    %ebp
     81c:	c3                   	ret    
     81d:	8d 76 00             	lea    0x0(%esi),%esi

00000820 <insert>:
void insert(struct LinkedList* list, char* data, int pos) {
     820:	55                   	push   %ebp
     821:	89 e5                	mov    %esp,%ebp
     823:	57                   	push   %edi
     824:	56                   	push   %esi
     825:	53                   	push   %ebx
     826:	83 ec 0c             	sub    $0xc,%esp
     829:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct Node* atPos = nodeAt(list, pos);
     82c:	ff 75 10             	pushl  0x10(%ebp)
     82f:	53                   	push   %ebx
     830:	e8 cb fe ff ff       	call   700 <nodeAt>
     835:	83 ec 04             	sub    $0x4,%esp
     838:	89 c6                	mov    %eax,%esi
  char* newData = (char*)malloc(sizeof(char) * 1000);
     83a:	68 e8 03 00 00       	push   $0x3e8
     83f:	e8 cc 13 00 00       	call   1c10 <malloc>
     844:	8b 55 0c             	mov    0xc(%ebp),%edx
     847:	89 c7                	mov    %eax,%edi
     849:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
     84e:	e8 9d fb ff ff       	call   3f0 <safestrcpy.part.0>
  struct Node* new = malloc(sizeof(Node));
     853:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     85a:	e8 b1 13 00 00       	call   1c10 <malloc>
  new->data = newData;
     85f:	89 78 04             	mov    %edi,0x4(%eax)
  new->prev = atPos->prev;
     862:	8b 16                	mov    (%esi),%edx
}
     864:	83 c4 10             	add    $0x10,%esp
  new->next = atPos;
     867:	89 70 08             	mov    %esi,0x8(%eax)
  new->prev = atPos->prev;
     86a:	89 10                	mov    %edx,(%eax)
  new->prev->next = new;
     86c:	89 42 08             	mov    %eax,0x8(%edx)
  atPos->prev = new;
     86f:	89 06                	mov    %eax,(%esi)
  list->len++;
     871:	83 43 08 01          	addl   $0x1,0x8(%ebx)
}
     875:	8d 65 f4             	lea    -0xc(%ebp),%esp
     878:	5b                   	pop    %ebx
     879:	5e                   	pop    %esi
     87a:	5f                   	pop    %edi
     87b:	5d                   	pop    %ebp
     87c:	c3                   	ret    
     87d:	8d 76 00             	lea    0x0(%esi),%esi

00000880 <prepend>:
void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
     880:	55                   	push   %ebp
     881:	89 e5                	mov    %esp,%ebp
     883:	83 ec 0c             	sub    $0xc,%esp
     886:	6a 00                	push   $0x0
     888:	ff 75 0c             	pushl  0xc(%ebp)
     88b:	ff 75 08             	pushl  0x8(%ebp)
     88e:	e8 8d ff ff ff       	call   820 <insert>
     893:	83 c4 10             	add    $0x10,%esp
     896:	c9                   	leave  
     897:	c3                   	ret    
     898:	90                   	nop
     899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008a0 <append>:
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     8a0:	55                   	push   %ebp
     8a1:	89 e5                	mov    %esp,%ebp
     8a3:	83 ec 0c             	sub    $0xc,%esp
     8a6:	8b 45 08             	mov    0x8(%ebp),%eax
     8a9:	ff 70 08             	pushl  0x8(%eax)
     8ac:	ff 75 0c             	pushl  0xc(%ebp)
     8af:	50                   	push   %eax
     8b0:	e8 6b ff ff ff       	call   820 <insert>
     8b5:	83 c4 10             	add    $0x10,%esp
     8b8:	c9                   	leave  
     8b9:	c3                   	ret    
     8ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000008c0 <destroyLinkedList>:

void destroyLinkedList(struct LinkedList* list) {
     8c0:	55                   	push   %ebp
     8c1:	89 e5                	mov    %esp,%ebp
     8c3:	56                   	push   %esi
     8c4:	53                   	push   %ebx
     8c5:	8b 75 08             	mov    0x8(%ebp),%esi
  struct Node* curNode = list->head;
     8c8:	8b 1e                	mov    (%esi),%ebx
  while (curNode != list->tail) {
     8ca:	8b 46 04             	mov    0x4(%esi),%eax
     8cd:	39 c3                	cmp    %eax,%ebx
     8cf:	74 29                	je     8fa <destroyLinkedList+0x3a>
     8d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
     8d8:	8b 5b 08             	mov    0x8(%ebx),%ebx
    free(curNode->prev->data);
     8db:	83 ec 0c             	sub    $0xc,%esp
     8de:	8b 03                	mov    (%ebx),%eax
     8e0:	ff 70 04             	pushl  0x4(%eax)
     8e3:	e8 98 12 00 00       	call   1b80 <free>
    free(curNode->prev);
     8e8:	58                   	pop    %eax
     8e9:	ff 33                	pushl  (%ebx)
     8eb:	e8 90 12 00 00       	call   1b80 <free>
  while (curNode != list->tail) {
     8f0:	8b 46 04             	mov    0x4(%esi),%eax
     8f3:	83 c4 10             	add    $0x10,%esp
     8f6:	39 d8                	cmp    %ebx,%eax
     8f8:	75 de                	jne    8d8 <destroyLinkedList+0x18>
  }
  free(curNode);
     8fa:	83 ec 0c             	sub    $0xc,%esp
     8fd:	50                   	push   %eax
     8fe:	e8 7d 12 00 00       	call   1b80 <free>
  free(list);
     903:	89 75 08             	mov    %esi,0x8(%ebp)
     906:	83 c4 10             	add    $0x10,%esp
     909:	8d 65 f8             	lea    -0x8(%ebp),%esp
     90c:	5b                   	pop    %ebx
     90d:	5e                   	pop    %esi
     90e:	5d                   	pop    %ebp
  free(list);
     90f:	e9 6c 12 00 00       	jmp    1b80 <free>
     914:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     91a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000920 <confirmation>:
// line-oriented text helpers
#include "textEditHelpers.h"

int confirmation() {
     920:	55                   	push   %ebp
     921:	89 e5                	mov    %esp,%ebp
     923:	53                   	push   %ebx
  // get response
  char buf[MAXLINESIZE];
  int nbuf = sizeof(buf);
  memset(buf, 0, nbuf);
     924:	8d 9d 10 fc ff ff    	lea    -0x3f0(%ebp),%ebx
int confirmation() {
     92a:	81 ec f8 03 00 00    	sub    $0x3f8,%esp
  memset(buf, 0, nbuf);
     930:	68 e8 03 00 00       	push   $0x3e8
     935:	6a 00                	push   $0x0
     937:	53                   	push   %ebx
     938:	e8 e3 0c 00 00       	call   1620 <memset>
  gets(buf, nbuf);
     93d:	58                   	pop    %eax
     93e:	5a                   	pop    %edx
     93f:	68 e8 03 00 00       	push   $0x3e8
     944:	53                   	push   %ebx
     945:	e8 36 0d 00 00       	call   1680 <gets>
  // determine output
  switch (buf[0]) {
     94a:	0f b6 85 10 fc ff ff 	movzbl -0x3f0(%ebp),%eax
     951:	83 c4 10             	add    $0x10,%esp
     954:	3c 59                	cmp    $0x59,%al
     956:	74 18                	je     970 <confirmation+0x50>
     958:	3c 79                	cmp    $0x79,%al
     95a:	74 14                	je     970 <confirmation+0x50>
  case 'Y':
  case 'y':
    return 0;
  default:
    return 1;
     95c:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
     961:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     964:	c9                   	leave  
     965:	c3                   	ret    
     966:	8d 76 00             	lea    0x0(%esi),%esi
     969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return 0;
     970:	31 c0                	xor    %eax,%eax
}
     972:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     975:	c9                   	leave  
     976:	c3                   	ret    
     977:	89 f6                	mov    %esi,%esi
     979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000980 <normalizeRange>:
    return 1;

  return 0;
}

int normalizeRange(File file, int* sp, int* ep) {
     980:	55                   	push   %ebp
     981:	89 e5                	mov    %esp,%ebp
     983:	53                   	push   %ebx
     984:	8b 4d 24             	mov    0x24(%ebp),%ecx
  int l = file.len;
     987:	8b 45 18             	mov    0x18(%ebp),%eax
int normalizeRange(File file, int* sp, int* ep) {
     98a:	8b 5d 20             	mov    0x20(%ebp),%ebx
  if (*ep > l) *ep = l;
     98d:	8b 11                	mov    (%ecx),%edx
     98f:	39 c2                	cmp    %eax,%edx
     991:	7e 45                	jle    9d8 <normalizeRange+0x58>
     993:	89 01                	mov    %eax,(%ecx)
     995:	89 c2                	mov    %eax,%edx
  else if (*ep < 1) *ep += l + 1;
  if (*ep < 1) *ep = 1;
     997:	85 d2                	test   %edx,%edx
     999:	7f 06                	jg     9a1 <normalizeRange+0x21>
     99b:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)

  if (*sp > l) *sp = l;
     9a1:	8b 13                	mov    (%ebx),%edx
     9a3:	39 c2                	cmp    %eax,%edx
     9a5:	7e 21                	jle    9c8 <normalizeRange+0x48>
     9a7:	89 03                	mov    %eax,(%ebx)
     9a9:	89 c2                	mov    %eax,%edx
  else if (*sp < 1) *sp += l + 1;
  if (*sp < 1) *sp = 1;
     9ab:	85 d2                	test   %edx,%edx
     9ad:	7f 0b                	jg     9ba <normalizeRange+0x3a>
     9af:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
     9b5:	ba 01 00 00 00       	mov    $0x1,%edx
  if ((*ep - *sp) < 0)
     9ba:	8b 01                	mov    (%ecx),%eax
    return 1;
  return 0;
}
     9bc:	5b                   	pop    %ebx
     9bd:	5d                   	pop    %ebp
  if ((*ep - *sp) < 0)
     9be:	29 d0                	sub    %edx,%eax
     9c0:	c1 e8 1f             	shr    $0x1f,%eax
}
     9c3:	c3                   	ret    
     9c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*sp < 1) *sp += l + 1;
     9c8:	85 d2                	test   %edx,%edx
     9ca:	7f ee                	jg     9ba <normalizeRange+0x3a>
     9cc:	8d 54 10 01          	lea    0x1(%eax,%edx,1),%edx
     9d0:	89 13                	mov    %edx,(%ebx)
     9d2:	eb d7                	jmp    9ab <normalizeRange+0x2b>
     9d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*ep < 1) *ep += l + 1;
     9d8:	85 d2                	test   %edx,%edx
     9da:	7f c5                	jg     9a1 <normalizeRange+0x21>
     9dc:	8d 54 02 01          	lea    0x1(%edx,%eax,1),%edx
     9e0:	89 11                	mov    %edx,(%ecx)
     9e2:	eb b3                	jmp    997 <normalizeRange+0x17>
     9e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     9ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000009f0 <numLines>:

int numLines(int start, int end) {
     9f0:	55                   	push   %ebp
     9f1:	89 e5                	mov    %esp,%ebp
  return (end - start) + 1;
     9f3:	8b 45 0c             	mov    0xc(%ebp),%eax
     9f6:	2b 45 08             	sub    0x8(%ebp),%eax
}
     9f9:	5d                   	pop    %ebp
  return (end - start) + 1;
     9fa:	83 c0 01             	add    $0x1,%eax
}
     9fd:	c3                   	ret    
     9fe:	66 90                	xchg   %ax,%ax

00000a00 <gatherLines>:

// text
void gatherLines(File* file) {
     a00:	55                   	push   %ebp
     a01:	89 e5                	mov    %esp,%ebp
     a03:	56                   	push   %esi
     a04:	53                   	push   %ebx
     a05:	8d b5 10 fc ff ff    	lea    -0x3f0(%ebp),%esi
     a0b:	81 ec f0 03 00 00    	sub    $0x3f0,%esp
     a11:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char line[MAXLINESIZE];
  while (getLine(file->fd, line)) {
     a14:	eb 21                	jmp    a37 <gatherLines+0x37>
     a16:	8d 76 00             	lea    0x0(%esi),%esi
     a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    append(file->lines, line);
     a20:	8b 43 0c             	mov    0xc(%ebx),%eax
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     a23:	83 ec 04             	sub    $0x4,%esp
     a26:	ff 70 08             	pushl  0x8(%eax)
     a29:	56                   	push   %esi
     a2a:	50                   	push   %eax
     a2b:	e8 f0 fd ff ff       	call   820 <insert>
    file->len++;
     a30:	83 43 10 01          	addl   $0x1,0x10(%ebx)
     a34:	83 c4 10             	add    $0x10,%esp
  while (getLine(file->fd, line)) {
     a37:	83 ec 08             	sub    $0x8,%esp
     a3a:	56                   	push   %esi
     a3b:	ff 73 04             	pushl  0x4(%ebx)
     a3e:	e8 ed f9 ff ff       	call   430 <getLine>
     a43:	83 c4 10             	add    $0x10,%esp
     a46:	85 c0                	test   %eax,%eax
     a48:	75 d6                	jne    a20 <gatherLines+0x20>
  }
}
     a4a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     a4d:	5b                   	pop    %ebx
     a4e:	5e                   	pop    %esi
     a4f:	5d                   	pop    %ebp
     a50:	c3                   	ret    
     a51:	eb 0d                	jmp    a60 <getArg>
     a53:	90                   	nop
     a54:	90                   	nop
     a55:	90                   	nop
     a56:	90                   	nop
     a57:	90                   	nop
     a58:	90                   	nop
     a59:	90                   	nop
     a5a:	90                   	nop
     a5b:	90                   	nop
     a5c:	90                   	nop
     a5d:	90                   	nop
     a5e:	90                   	nop
     a5f:	90                   	nop

00000a60 <getArg>:

void getArg(char* dest, char* args, char delimiter) {
     a60:	55                   	push   %ebp
     a61:	89 e5                	mov    %esp,%ebp
     a63:	57                   	push   %edi
     a64:	56                   	push   %esi
     a65:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     a66:	31 db                	xor    %ebx,%ebx
     a68:	83 ec 1c             	sub    $0x1c,%esp
     a6b:	8b 75 0c             	mov    0xc(%ebp),%esi
     a6e:	0f b6 7d 10          	movzbl 0x10(%ebp),%edi
     a72:	eb 10                	jmp    a84 <getArg+0x24>
     a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     a78:	89 f8                	mov    %edi,%eax
     a7a:	3a 04 1e             	cmp    (%esi,%ebx,1),%al
     a7d:	8d 53 01             	lea    0x1(%ebx),%edx
     a80:	74 19                	je     a9b <getArg+0x3b>
     a82:	89 d3                	mov    %edx,%ebx
  for (int i = 0; i < strlen(str); i++)
     a84:	83 ec 0c             	sub    $0xc,%esp
     a87:	56                   	push   %esi
     a88:	e8 63 0b 00 00       	call   15f0 <strlen>
     a8d:	83 c4 10             	add    $0x10,%esp
     a90:	39 c3                	cmp    %eax,%ebx
     a92:	72 e4                	jb     a78 <getArg+0x18>
     a94:	31 d2                	xor    %edx,%edx
  return -1;
     a96:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  int end = find(args, delimiter);
  substr(dest, args, 0, end);
     a9b:	53                   	push   %ebx
     a9c:	6a 00                	push   $0x0
     a9e:	56                   	push   %esi
     a9f:	ff 75 08             	pushl  0x8(%ebp)
     aa2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     aa5:	e8 66 fa ff ff       	call   510 <substr>
  substr(args, args, end + 1, (int) strlen(args));
     aaa:	89 34 24             	mov    %esi,(%esp)
     aad:	e8 3e 0b 00 00       	call   15f0 <strlen>
     ab2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     ab5:	50                   	push   %eax
     ab6:	52                   	push   %edx
     ab7:	56                   	push   %esi
     ab8:	56                   	push   %esi
     ab9:	e8 52 fa ff ff       	call   510 <substr>
}
     abe:	83 c4 20             	add    $0x20,%esp
     ac1:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ac4:	5b                   	pop    %ebx
     ac5:	5e                   	pop    %esi
     ac6:	5f                   	pop    %edi
     ac7:	5d                   	pop    %ebp
     ac8:	c3                   	ret    
     ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ad0 <collectRange>:
int collectRange(char* args, int* startptr, int* endptr) {
     ad0:	55                   	push   %ebp
     ad1:	89 e5                	mov    %esp,%ebp
     ad3:	57                   	push   %edi
     ad4:	56                   	push   %esi
     ad5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     ad6:	31 f6                	xor    %esi,%esi
     ad8:	83 ec 2c             	sub    $0x2c,%esp
     adb:	8b 5d 08             	mov    0x8(%ebp),%ebx
     ade:	eb 09                	jmp    ae9 <collectRange+0x19>
    if (str[i] == c) return i;
     ae0:	80 3c 33 3a          	cmpb   $0x3a,(%ebx,%esi,1)
     ae4:	74 42                	je     b28 <collectRange+0x58>
  for (int i = 0; i < strlen(str); i++)
     ae6:	83 c6 01             	add    $0x1,%esi
     ae9:	83 ec 0c             	sub    $0xc,%esp
     aec:	53                   	push   %ebx
     aed:	e8 fe 0a 00 00       	call   15f0 <strlen>
     af2:	83 c4 10             	add    $0x10,%esp
     af5:	39 c6                	cmp    %eax,%esi
     af7:	72 e7                	jb     ae0 <collectRange+0x10>
    if (args[0] == '-') {
     af9:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     afc:	0f 84 d6 00 00 00    	je     bd8 <collectRange+0x108>
      *startptr = atoi(args);
     b02:	83 ec 0c             	sub    $0xc,%esp
     b05:	53                   	push   %ebx
     b06:	e8 45 0c 00 00       	call   1750 <atoi>
     b0b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     b0e:	83 c4 10             	add    $0x10,%esp
     b11:	89 01                	mov    %eax,(%ecx)
    *endptr = *startptr;
     b13:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b16:	89 01                	mov    %eax,(%ecx)
    return 0;
     b18:	31 c0                	xor    %eax,%eax
}
     b1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b1d:	5b                   	pop    %ebx
     b1e:	5e                   	pop    %esi
     b1f:	5f                   	pop    %edi
     b20:	5d                   	pop    %ebp
     b21:	c3                   	ret    
     b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  getArg(startstr, args, ':');
     b28:	8d 75 de             	lea    -0x22(%ebp),%esi
     b2b:	83 ec 04             	sub    $0x4,%esp
     b2e:	6a 3a                	push   $0x3a
     b30:	53                   	push   %ebx
     b31:	56                   	push   %esi
     b32:	e8 29 ff ff ff       	call   a60 <getArg>
  if (startstr[0] == '-') {
     b37:	83 c4 10             	add    $0x10,%esp
     b3a:	80 7d de 2d          	cmpb   $0x2d,-0x22(%ebp)
     b3e:	0f 84 3c 01 00 00    	je     c80 <collectRange+0x1b0>
  int negStartFlag = 0, negEndFlag = 0;
     b44:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     b4b:	31 ff                	xor    %edi,%edi
  if (endstr[0] == '-') {
     b4d:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     b50:	0f 84 0a 01 00 00    	je     c60 <collectRange+0x190>
  if (strcmp(startstr, "\0") == 0) *startptr = 1;
     b56:	83 ec 08             	sub    $0x8,%esp
     b59:	68 dc 1e 00 00       	push   $0x1edc
     b5e:	56                   	push   %esi
     b5f:	e8 3c 0a 00 00       	call   15a0 <strcmp>
     b64:	83 c4 10             	add    $0x10,%esp
     b67:	85 c0                	test   %eax,%eax
     b69:	0f 85 d1 00 00 00    	jne    c40 <collectRange+0x170>
     b6f:	8b 45 0c             	mov    0xc(%ebp),%eax
     b72:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  if (strcmp(endstr, "\0") == 0) *endptr = -1;
     b78:	83 ec 08             	sub    $0x8,%esp
     b7b:	68 dc 1e 00 00       	push   $0x1edc
     b80:	53                   	push   %ebx
     b81:	e8 1a 0a 00 00       	call   15a0 <strcmp>
     b86:	83 c4 10             	add    $0x10,%esp
     b89:	85 c0                	test   %eax,%eax
     b8b:	0f 85 97 00 00 00    	jne    c28 <collectRange+0x158>
     b91:	8b 45 10             	mov    0x10(%ebp),%eax
     b94:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  if (negStartFlag) *startptr = 0 - *startptr;
     b9a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     b9d:	85 c0                	test   %eax,%eax
     b9f:	74 05                	je     ba6 <collectRange+0xd6>
     ba1:	8b 45 0c             	mov    0xc(%ebp),%eax
     ba4:	f7 18                	negl   (%eax)
  if (negEndFlag) *endptr = 0 - *endptr;
     ba6:	85 ff                	test   %edi,%edi
     ba8:	74 05                	je     baf <collectRange+0xdf>
     baa:	8b 45 10             	mov    0x10(%ebp),%eax
     bad:	f7 18                	negl   (%eax)
  if (((*startptr > 0 && *endptr > 0) || 
     baf:	8b 45 0c             	mov    0xc(%ebp),%eax
     bb2:	8b 00                	mov    (%eax),%eax
     bb4:	83 f8 00             	cmp    $0x0,%eax
     bb7:	7e 4f                	jle    c08 <collectRange+0x138>
     bb9:	8b 55 10             	mov    0x10(%ebp),%edx
     bbc:	8b 12                	mov    (%edx),%edx
     bbe:	85 d2                	test   %edx,%edx
     bc0:	7e 55                	jle    c17 <collectRange+0x147>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     bc2:	39 d0                	cmp    %edx,%eax
     bc4:	0f 9f c0             	setg   %al
}
     bc7:	8d 65 f4             	lea    -0xc(%ebp),%esp
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     bca:	0f b6 c0             	movzbl %al,%eax
}
     bcd:	5b                   	pop    %ebx
     bce:	5e                   	pop    %esi
     bcf:	5f                   	pop    %edi
     bd0:	5d                   	pop    %ebp
     bd1:	c3                   	ret    
     bd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      substr(args, args, 1, strlen(args));
     bd8:	83 ec 0c             	sub    $0xc,%esp
     bdb:	53                   	push   %ebx
     bdc:	e8 0f 0a 00 00       	call   15f0 <strlen>
     be1:	50                   	push   %eax
     be2:	6a 01                	push   $0x1
     be4:	53                   	push   %ebx
     be5:	53                   	push   %ebx
     be6:	e8 25 f9 ff ff       	call   510 <substr>
      *startptr = 0 - atoi(args);
     beb:	83 c4 14             	add    $0x14,%esp
     bee:	53                   	push   %ebx
     bef:	e8 5c 0b 00 00       	call   1750 <atoi>
     bf4:	8b 7d 0c             	mov    0xc(%ebp),%edi
     bf7:	f7 d8                	neg    %eax
     bf9:	83 c4 10             	add    $0x10,%esp
     bfc:	89 07                	mov    %eax,(%edi)
     bfe:	e9 10 ff ff ff       	jmp    b13 <collectRange+0x43>
     c03:	90                   	nop
     c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (((*startptr > 0 && *endptr > 0) || 
     c08:	0f 84 0c ff ff ff    	je     b1a <collectRange+0x4a>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     c0e:	8b 7d 10             	mov    0x10(%ebp),%edi
     c11:	8b 17                	mov    (%edi),%edx
     c13:	85 d2                	test   %edx,%edx
     c15:	78 ab                	js     bc2 <collectRange+0xf2>
}
     c17:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
     c1a:	31 c0                	xor    %eax,%eax
}
     c1c:	5b                   	pop    %ebx
     c1d:	5e                   	pop    %esi
     c1e:	5f                   	pop    %edi
     c1f:	5d                   	pop    %ebp
     c20:	c3                   	ret    
     c21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else *endptr = atoi(endstr);
     c28:	83 ec 0c             	sub    $0xc,%esp
     c2b:	53                   	push   %ebx
     c2c:	e8 1f 0b 00 00       	call   1750 <atoi>
     c31:	8b 55 10             	mov    0x10(%ebp),%edx
     c34:	83 c4 10             	add    $0x10,%esp
     c37:	89 02                	mov    %eax,(%edx)
     c39:	e9 5c ff ff ff       	jmp    b9a <collectRange+0xca>
     c3e:	66 90                	xchg   %ax,%ax
  else *startptr = atoi(startstr);
     c40:	83 ec 0c             	sub    $0xc,%esp
     c43:	56                   	push   %esi
     c44:	e8 07 0b 00 00       	call   1750 <atoi>
     c49:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     c4c:	83 c4 10             	add    $0x10,%esp
     c4f:	89 01                	mov    %eax,(%ecx)
     c51:	e9 22 ff ff ff       	jmp    b78 <collectRange+0xa8>
     c56:	8d 76 00             	lea    0x0(%esi),%esi
     c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    substr(endstr, endstr, 1, strlen(endstr));
     c60:	83 ec 0c             	sub    $0xc,%esp
    negEndFlag = 1;
     c63:	bf 01 00 00 00       	mov    $0x1,%edi
    substr(endstr, endstr, 1, strlen(endstr));
     c68:	53                   	push   %ebx
     c69:	e8 82 09 00 00       	call   15f0 <strlen>
     c6e:	50                   	push   %eax
     c6f:	6a 01                	push   $0x1
     c71:	53                   	push   %ebx
     c72:	53                   	push   %ebx
     c73:	e8 98 f8 ff ff       	call   510 <substr>
     c78:	83 c4 20             	add    $0x20,%esp
     c7b:	e9 d6 fe ff ff       	jmp    b56 <collectRange+0x86>
    substr(startstr, startstr, 1, strlen(startstr));
     c80:	83 ec 0c             	sub    $0xc,%esp
     c83:	56                   	push   %esi
     c84:	e8 67 09 00 00       	call   15f0 <strlen>
     c89:	50                   	push   %eax
     c8a:	6a 01                	push   $0x1
     c8c:	56                   	push   %esi
     c8d:	56                   	push   %esi
     c8e:	e8 7d f8 ff ff       	call   510 <substr>
     c93:	83 c4 20             	add    $0x20,%esp
    negStartFlag = 1;
     c96:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
     c9d:	e9 a9 fe ff ff       	jmp    b4b <collectRange+0x7b>
     ca2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000cb0 <unline>:

void unline(char* str) {
     cb0:	55                   	push   %ebp
     cb1:	89 e5                	mov    %esp,%ebp
     cb3:	53                   	push   %ebx
     cb4:	83 ec 10             	sub    $0x10,%esp
     cb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str) - 1;
     cba:	53                   	push   %ebx
     cbb:	e8 30 09 00 00       	call   15f0 <strlen>
     cc0:	8d 50 ff             	lea    -0x1(%eax),%edx
  for (; len > 0; len--) {
     cc3:	83 c4 10             	add    $0x10,%esp
     cc6:	85 d2                	test   %edx,%edx
     cc8:	7e 36                	jle    d00 <unline+0x50>
    char c = str[len];
    if (c == '\n')
     cca:	80 7c 03 ff 0a       	cmpb   $0xa,-0x1(%ebx,%eax,1)
     ccf:	74 2f                	je     d00 <unline+0x50>
     cd1:	8d 44 03 fe          	lea    -0x2(%ebx,%eax,1),%eax
     cd5:	eb 12                	jmp    ce9 <unline+0x39>
     cd7:	89 f6                	mov    %esi,%esi
     cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     ce0:	83 e8 01             	sub    $0x1,%eax
     ce3:	80 78 01 0a          	cmpb   $0xa,0x1(%eax)
     ce7:	74 06                	je     cef <unline+0x3f>
  for (; len > 0; len--) {
     ce9:	39 c3                	cmp    %eax,%ebx
     ceb:	89 c2                	mov    %eax,%edx
     ced:	75 f1                	jne    ce0 <unline+0x30>
      break;
  }
  str[len] = '\0';
     cef:	c6 02 00             	movb   $0x0,(%edx)
}
     cf2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cf5:	c9                   	leave  
     cf6:	c3                   	ret    
     cf7:	89 f6                	mov    %esi,%esi
     cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     d00:	01 da                	add    %ebx,%edx
  str[len] = '\0';
     d02:	c6 02 00             	movb   $0x0,(%edx)
}
     d05:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d08:	c9                   	leave  
     d09:	c3                   	ret    
     d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000d10 <gatherLinesSized>:

// int* gatherLineSized(struct File* file, Terminal terminal) {
void gatherLinesSized(struct File* file, Terminal terminal) {
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	57                   	push   %edi
     d14:	56                   	push   %esi
     d15:	53                   	push   %ebx
     d16:	81 ec 0c 04 00 00    	sub    $0x40c,%esp
     d1c:	8b 75 0c             	mov    0xc(%ebp),%esi
     d1f:	8b 7d 08             	mov    0x8(%ebp),%edi
  char line[MAXLINESIZE];
  while (getLine(file->fd, line)) {
    int cols = 0;
    for (; strlen(line + cols) > terminal.width; cols += terminal.width) {
      printf("line: %s\n\n", line + cols);
      char piece[terminal.width];
     d22:	8d 46 0f             	lea    0xf(%esi),%eax
     d25:	c1 e8 04             	shr    $0x4,%eax
     d28:	89 85 ec fb ff ff    	mov    %eax,-0x414(%ebp)
     d2e:	66 90                	xchg   %ax,%ax
  while (getLine(file->fd, line)) {
     d30:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     d36:	83 ec 08             	sub    $0x8,%esp
     d39:	50                   	push   %eax
     d3a:	ff 77 04             	pushl  0x4(%edi)
     d3d:	e8 ee f6 ff ff       	call   430 <getLine>
     d42:	83 c4 10             	add    $0x10,%esp
     d45:	85 c0                	test   %eax,%eax
     d47:	0f 84 93 00 00 00    	je     de0 <gatherLinesSized+0xd0>
     d4d:	8d 9d 00 fc ff ff    	lea    -0x400(%ebp),%ebx
     d53:	eb 5b                	jmp    db0 <gatherLinesSized+0xa0>
     d55:	8d 76 00             	lea    0x0(%esi),%esi
    for (; strlen(line + cols) > terminal.width; cols += terminal.width) {
     d58:	89 a5 f4 fb ff ff    	mov    %esp,-0x40c(%ebp)
      printf("line: %s\n\n", line + cols);
     d5e:	83 ec 08             	sub    $0x8,%esp
     d61:	53                   	push   %ebx
     d62:	68 de 1e 00 00       	push   $0x1ede
     d67:	e8 f4 0d 00 00       	call   1b60 <printf>
      char piece[terminal.width];
     d6c:	8b 85 ec fb ff ff    	mov    -0x414(%ebp),%eax
     d72:	83 c4 10             	add    $0x10,%esp
     d75:	c1 e0 04             	shl    $0x4,%eax
     d78:	29 c4                	sub    %eax,%esp
  if(n <= 0)
     d7a:	85 f6                	test   %esi,%esi
     d7c:	89 a5 f0 fb ff ff    	mov    %esp,-0x410(%ebp)
     d82:	7e 0b                	jle    d8f <gatherLinesSized+0x7f>
     d84:	89 f1                	mov    %esi,%ecx
     d86:	89 da                	mov    %ebx,%edx
     d88:	89 e0                	mov    %esp,%eax
     d8a:	e8 61 f6 ff ff       	call   3f0 <safestrcpy.part.0>
      safestrcpy(piece, line + cols, terminal.width);
      append(file->lines, piece);
     d8f:	8b 47 0c             	mov    0xc(%edi),%eax
     d92:	83 ec 04             	sub    $0x4,%esp
     d95:	01 f3                	add    %esi,%ebx
     d97:	ff 70 08             	pushl  0x8(%eax)
     d9a:	ff b5 f0 fb ff ff    	pushl  -0x410(%ebp)
     da0:	50                   	push   %eax
     da1:	e8 7a fa ff ff       	call   820 <insert>
      file->len++;
     da6:	83 47 10 01          	addl   $0x1,0x10(%edi)
     daa:	8b a5 f4 fb ff ff    	mov    -0x40c(%ebp),%esp
    for (; strlen(line + cols) > terminal.width; cols += terminal.width) {
     db0:	83 ec 0c             	sub    $0xc,%esp
     db3:	53                   	push   %ebx
     db4:	e8 37 08 00 00       	call   15f0 <strlen>
     db9:	83 c4 10             	add    $0x10,%esp
     dbc:	39 f0                	cmp    %esi,%eax
     dbe:	77 98                	ja     d58 <gatherLinesSized+0x48>
      numSplits++;
    }
    append(file->lines, line + cols);
     dc0:	8b 47 0c             	mov    0xc(%edi),%eax
     dc3:	83 ec 04             	sub    $0x4,%esp
     dc6:	ff 70 08             	pushl  0x8(%eax)
     dc9:	53                   	push   %ebx
     dca:	50                   	push   %eax
     dcb:	e8 50 fa ff ff       	call   820 <insert>
    file->len++;
     dd0:	83 47 10 01          	addl   $0x1,0x10(%edi)
     dd4:	83 c4 10             	add    $0x10,%esp
     dd7:	e9 54 ff ff ff       	jmp    d30 <gatherLinesSized+0x20>
     ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  // return ;
}
     de0:	8d 65 f4             	lea    -0xc(%ebp),%esp
     de3:	5b                   	pop    %ebx
     de4:	5e                   	pop    %esi
     de5:	5f                   	pop    %edi
     de6:	5d                   	pop    %ebp
     de7:	c3                   	ret    
     de8:	90                   	nop
     de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000df0 <lineAt>:


// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
     df0:	55                   	push   %ebp
     df1:	89 e5                	mov    %esp,%ebp
  return nodeAt(list, pos-1);
     df3:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
}
     df7:	5d                   	pop    %ebp
  return nodeAt(list, pos-1);
     df8:	e9 03 f9 ff ff       	jmp    700 <nodeAt>
     dfd:	8d 76 00             	lea    0x0(%esi),%esi

00000e00 <printl>:

void printl(int lineNum, char* line) {
     e00:	55                   	push   %ebp
     e01:	89 e5                	mov    %esp,%ebp
     e03:	83 ec 08             	sub    $0x8,%esp
     e06:	8b 45 08             	mov    0x8(%ebp),%eax
  if (lineNum < 10)
     e09:	83 f8 09             	cmp    $0x9,%eax
     e0c:	7e 3a                	jle    e48 <printl+0x48>
    fprintf(2, "%d  : %s\n", lineNum, line);
  else if (lineNum < 100)
     e0e:	83 f8 63             	cmp    $0x63,%eax
     e11:	7e 1d                	jle    e30 <printl+0x30>
    fprintf(2, "%d : %s\n", lineNum, line);
  else
    fprintf(2, "%d: %s\n", lineNum, line);
     e13:	ff 75 0c             	pushl  0xc(%ebp)
     e16:	50                   	push   %eax
     e17:	68 fc 1e 00 00       	push   $0x1efc
     e1c:	6a 02                	push   $0x2
     e1e:	e8 1d 0d 00 00       	call   1b40 <fprintf>
     e23:	83 c4 10             	add    $0x10,%esp
}
     e26:	c9                   	leave  
     e27:	c3                   	ret    
     e28:	90                   	nop
     e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "%d : %s\n", lineNum, line);
     e30:	ff 75 0c             	pushl  0xc(%ebp)
     e33:	50                   	push   %eax
     e34:	68 f3 1e 00 00       	push   $0x1ef3
     e39:	6a 02                	push   $0x2
     e3b:	e8 00 0d 00 00       	call   1b40 <fprintf>
     e40:	83 c4 10             	add    $0x10,%esp
}
     e43:	c9                   	leave  
     e44:	c3                   	ret    
     e45:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "%d  : %s\n", lineNum, line);
     e48:	ff 75 0c             	pushl  0xc(%ebp)
     e4b:	50                   	push   %eax
     e4c:	68 e9 1e 00 00       	push   $0x1ee9
     e51:	6a 02                	push   $0x2
     e53:	e8 e8 0c 00 00       	call   1b40 <fprintf>
     e58:	83 c4 10             	add    $0x10,%esp
}
     e5b:	c9                   	leave  
     e5c:	c3                   	ret    
     e5d:	8d 76 00             	lea    0x0(%esi),%esi

00000e60 <printpad>:

// prints the string with padding of a certain character
void printpad(int pad, char padChar, char* str, int alignment, int endLine) {
     e60:	55                   	push   %ebp
     e61:	89 e5                	mov    %esp,%ebp
     e63:	57                   	push   %edi
     e64:	56                   	push   %esi
     e65:	53                   	push   %ebx
     e66:	83 ec 28             	sub    $0x28,%esp
     e69:	8b 45 0c             	mov    0xc(%ebp),%eax
     e6c:	8b 7d 10             	mov    0x10(%ebp),%edi
     e6f:	8b 5d 08             	mov    0x8(%ebp),%ebx
     e72:	8b 75 14             	mov    0x14(%ebp),%esi
     e75:	89 45 e0             	mov    %eax,-0x20(%ebp)
     e78:	8b 45 18             	mov    0x18(%ebp),%eax
  int len = strlen(str);
     e7b:	57                   	push   %edi
void printpad(int pad, char padChar, char* str, int alignment, int endLine) {
     e7c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int len = strlen(str);
     e7f:	e8 6c 07 00 00       	call   15f0 <strlen>
  int i = pad - len;
  if (alignment == LEFT) {
     e84:	83 c4 10             	add    $0x10,%esp
  int i = pad - len;
     e87:	29 c3                	sub    %eax,%ebx
  if (alignment == LEFT) {
     e89:	85 f6                	test   %esi,%esi
     e8b:	74 7b                	je     f08 <printpad+0xa8>
    printf("%s", str);
    for (; i > 0; i--)
      printf("%c", padChar);
  } else if (alignment == RIGHT) {
     e8d:	83 fe 02             	cmp    $0x2,%esi
     e90:	74 1e                	je     eb0 <printpad+0x50>
    for (; i > 0; i--)
      printf("%c", padChar);
    printf("%s", str);
  } else if (alignment == CENTER) {
     e92:	83 fe 01             	cmp    $0x1,%esi
     e95:	0f 84 ad 00 00 00    	je     f48 <printpad+0xe8>
      printf("%c", padChar);
      if (i == half)
        printf("%s", str);
    }
  }
  if (endLine) {
     e9b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     e9e:	85 c0                	test   %eax,%eax
     ea0:	75 4c                	jne    eee <printpad+0x8e>
    printf("\n");
  }
     ea2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ea5:	5b                   	pop    %ebx
     ea6:	5e                   	pop    %esi
     ea7:	5f                   	pop    %edi
     ea8:	5d                   	pop    %ebp
     ea9:	c3                   	ret    
     eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for (; i > 0; i--)
     eb0:	85 db                	test   %ebx,%ebx
     eb2:	7e 22                	jle    ed6 <printpad+0x76>
     eb4:	0f be 75 e0          	movsbl -0x20(%ebp),%esi
     eb8:	90                   	nop
     eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printf("%c", padChar);
     ec0:	83 ec 08             	sub    $0x8,%esp
     ec3:	56                   	push   %esi
     ec4:	68 07 1f 00 00       	push   $0x1f07
     ec9:	e8 92 0c 00 00       	call   1b60 <printf>
    for (; i > 0; i--)
     ece:	83 c4 10             	add    $0x10,%esp
     ed1:	83 eb 01             	sub    $0x1,%ebx
     ed4:	75 ea                	jne    ec0 <printpad+0x60>
    printf("%s", str);
     ed6:	83 ec 08             	sub    $0x8,%esp
     ed9:	57                   	push   %edi
     eda:	68 04 1f 00 00       	push   $0x1f04
     edf:	e8 7c 0c 00 00       	call   1b60 <printf>
  if (endLine) {
     ee4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ee7:	83 c4 10             	add    $0x10,%esp
     eea:	85 c0                	test   %eax,%eax
     eec:	74 b4                	je     ea2 <printpad+0x42>
    printf("\n");
     eee:	c7 45 08 e7 1e 00 00 	movl   $0x1ee7,0x8(%ebp)
     ef5:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ef8:	5b                   	pop    %ebx
     ef9:	5e                   	pop    %esi
     efa:	5f                   	pop    %edi
     efb:	5d                   	pop    %ebp
    printf("\n");
     efc:	e9 5f 0c 00 00       	jmp    1b60 <printf>
     f01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    printf("%s", str);
     f08:	83 ec 08             	sub    $0x8,%esp
     f0b:	57                   	push   %edi
     f0c:	68 04 1f 00 00       	push   $0x1f04
     f11:	e8 4a 0c 00 00       	call   1b60 <printf>
    for (; i > 0; i--)
     f16:	83 c4 10             	add    $0x10,%esp
     f19:	85 db                	test   %ebx,%ebx
     f1b:	0f 8e 7a ff ff ff    	jle    e9b <printpad+0x3b>
     f21:	0f be 75 e0          	movsbl -0x20(%ebp),%esi
     f25:	8d 76 00             	lea    0x0(%esi),%esi
      printf("%c", padChar);
     f28:	83 ec 08             	sub    $0x8,%esp
     f2b:	56                   	push   %esi
     f2c:	68 07 1f 00 00       	push   $0x1f07
     f31:	e8 2a 0c 00 00       	call   1b60 <printf>
    for (; i > 0; i--)
     f36:	83 c4 10             	add    $0x10,%esp
     f39:	83 eb 01             	sub    $0x1,%ebx
     f3c:	75 ea                	jne    f28 <printpad+0xc8>
     f3e:	e9 58 ff ff ff       	jmp    e9b <printpad+0x3b>
     f43:	90                   	nop
     f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int half = i / 2;
     f48:	89 d8                	mov    %ebx,%eax
     f4a:	c1 e8 1f             	shr    $0x1f,%eax
     f4d:	01 d8                	add    %ebx,%eax
     f4f:	d1 f8                	sar    %eax
    for (; i > 0; i--) {
     f51:	85 db                	test   %ebx,%ebx
    int half = i / 2;
     f53:	89 45 dc             	mov    %eax,-0x24(%ebp)
    for (; i > 0; i--) {
     f56:	0f 8e 3f ff ff ff    	jle    e9b <printpad+0x3b>
     f5c:	0f be 75 e0          	movsbl -0x20(%ebp),%esi
     f60:	eb 0f                	jmp    f71 <printpad+0x111>
     f62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f68:	83 eb 01             	sub    $0x1,%ebx
     f6b:	0f 84 2a ff ff ff    	je     e9b <printpad+0x3b>
      printf("%c", padChar);
     f71:	83 ec 08             	sub    $0x8,%esp
     f74:	56                   	push   %esi
     f75:	68 07 1f 00 00       	push   $0x1f07
     f7a:	e8 e1 0b 00 00       	call   1b60 <printf>
      if (i == half)
     f7f:	83 c4 10             	add    $0x10,%esp
     f82:	39 5d dc             	cmp    %ebx,-0x24(%ebp)
     f85:	75 e1                	jne    f68 <printpad+0x108>
        printf("%s", str);
     f87:	83 ec 08             	sub    $0x8,%esp
     f8a:	57                   	push   %edi
     f8b:	68 04 1f 00 00       	push   $0x1f04
     f90:	e8 cb 0b 00 00       	call   1b60 <printf>
     f95:	83 c4 10             	add    $0x10,%esp
     f98:	eb ce                	jmp    f68 <printpad+0x108>
     f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000fa0 <end>:
void end(struct File* file, char* args) {
     fa0:	55                   	push   %ebp
     fa1:	89 e5                	mov    %esp,%ebp
     fa3:	53                   	push   %ebx
     fa4:	83 ec 08             	sub    $0x8,%esp
     fa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  append(file->lines, line);
     faa:	8b 43 0c             	mov    0xc(%ebx),%eax
  file->edited = 1;
     fad:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
     fb4:	ff 70 08             	pushl  0x8(%eax)
     fb7:	ff 75 0c             	pushl  0xc(%ebp)
     fba:	50                   	push   %eax
     fbb:	e8 60 f8 ff ff       	call   820 <insert>
  file->len++;
     fc0:	83 43 10 01          	addl   $0x1,0x10(%ebx)
}
     fc4:	83 c4 10             	add    $0x10,%esp
     fc7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fca:	c9                   	leave  
     fcb:	c3                   	ret    
     fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000fd0 <add>:
void add(struct File* file, char* args) {
     fd0:	55                   	push   %ebp
     fd1:	89 e5                	mov    %esp,%ebp
     fd3:	57                   	push   %edi
     fd4:	56                   	push   %esi
     fd5:	53                   	push   %ebx
     fd6:	83 ec 28             	sub    $0x28,%esp
     fd9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     fdc:	8b 75 0c             	mov    0xc(%ebp),%esi
  file->edited = 1;
     fdf:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
  if (strlen(args) < 1) {
     fe6:	56                   	push   %esi
     fe7:	e8 04 06 00 00       	call   15f0 <strlen>
     fec:	83 c4 10             	add    $0x10,%esp
     fef:	85 c0                	test   %eax,%eax
     ff1:	74 3d                	je     1030 <add+0x60>
  getArg(lineStr, args, ' ');
     ff3:	8d 7d de             	lea    -0x22(%ebp),%edi
     ff6:	83 ec 04             	sub    $0x4,%esp
     ff9:	6a 20                	push   $0x20
     ffb:	56                   	push   %esi
     ffc:	57                   	push   %edi
     ffd:	e8 5e fa ff ff       	call   a60 <getArg>
  int lineNum = negatoi(lineStr);
    1002:	89 3c 24             	mov    %edi,(%esp)
    1005:	e8 76 f5 ff ff       	call   580 <negatoi>
  insert(file->lines, line, lineNum - 1);
    100a:	83 c4 0c             	add    $0xc,%esp
    100d:	83 e8 01             	sub    $0x1,%eax
    1010:	50                   	push   %eax
    1011:	56                   	push   %esi
    1012:	ff 73 0c             	pushl  0xc(%ebx)
    1015:	e8 06 f8 ff ff       	call   820 <insert>
  file->len++;
    101a:	83 43 10 01          	addl   $0x1,0x10(%ebx)
    101e:	83 c4 10             	add    $0x10,%esp
}
    1021:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1024:	5b                   	pop    %ebx
    1025:	5e                   	pop    %esi
    1026:	5f                   	pop    %edi
    1027:	5d                   	pop    %ebp
    1028:	c3                   	ret    
    1029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "you need to give a line number to insert before\n");
    1030:	83 ec 08             	sub    $0x8,%esp
    1033:	68 50 1d 00 00       	push   $0x1d50
    1038:	6a 02                	push   $0x2
    103a:	e8 01 0b 00 00       	call   1b40 <fprintf>
    103f:	83 c4 10             	add    $0x10,%esp
}
    1042:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1045:	5b                   	pop    %ebx
    1046:	5e                   	pop    %esi
    1047:	5f                   	pop    %edi
    1048:	5d                   	pop    %ebp
    1049:	c3                   	ret    
    104a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001050 <drop>:
void drop(struct File* file, char* args) {
    1050:	55                   	push   %ebp
    1051:	89 e5                	mov    %esp,%ebp
    1053:	57                   	push   %edi
    1054:	56                   	push   %esi
    1055:	53                   	push   %ebx
    1056:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
    1059:	ff 75 0c             	pushl  0xc(%ebp)
void drop(struct File* file, char* args) {
    105c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (strlen(args) < 1) {
    105f:	e8 8c 05 00 00       	call   15f0 <strlen>
    1064:	83 c4 10             	add    $0x10,%esp
    1067:	85 c0                	test   %eax,%eax
    1069:	0f 84 09 01 00 00    	je     1178 <drop+0x128>
  if (collectRange(args, &start, &end) == 1) {
    106f:	8d 75 e4             	lea    -0x1c(%ebp),%esi
    1072:	8d 7d e0             	lea    -0x20(%ebp),%edi
    1075:	83 ec 04             	sub    $0x4,%esp
    1078:	56                   	push   %esi
    1079:	57                   	push   %edi
    107a:	ff 75 0c             	pushl  0xc(%ebp)
    107d:	e8 4e fa ff ff       	call   ad0 <collectRange>
    1082:	83 c4 10             	add    $0x10,%esp
    1085:	83 f8 01             	cmp    $0x1,%eax
    1088:	0f 84 0a 01 00 00    	je     1198 <drop+0x148>
  if (normalizeRange(*file, &start, &end) == 1) {
    108e:	56                   	push   %esi
    108f:	57                   	push   %edi
    1090:	ff 73 14             	pushl  0x14(%ebx)
    1093:	ff 73 10             	pushl  0x10(%ebx)
    1096:	ff 73 0c             	pushl  0xc(%ebx)
    1099:	ff 73 08             	pushl  0x8(%ebx)
    109c:	ff 73 04             	pushl  0x4(%ebx)
    109f:	ff 33                	pushl  (%ebx)
    10a1:	e8 da f8 ff ff       	call   980 <normalizeRange>
    10a6:	83 c4 20             	add    $0x20,%esp
    10a9:	83 f8 01             	cmp    $0x1,%eax
    10ac:	0f 84 1e 01 00 00    	je     11d0 <drop+0x180>
  int numl = numLines(start, end);
    10b2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    10b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return (end - start) + 1;
    10b8:	89 d6                	mov    %edx,%esi
    10ba:	29 c6                	sub    %eax,%esi
    10bc:	8d 7e 01             	lea    0x1(%esi),%edi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
    10bf:	83 ff 01             	cmp    $0x1,%edi
    10c2:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    10c5:	0f 84 ed 00 00 00    	je     11b8 <drop+0x168>
  else fprintf(2, "Drop %d lines [%d:%d] (y/n)? ", numl, start, end);
    10cb:	83 ec 0c             	sub    $0xc,%esp
    10ce:	52                   	push   %edx
    10cf:	50                   	push   %eax
    10d0:	ff 75 d4             	pushl  -0x2c(%ebp)
    10d3:	68 1f 1f 00 00       	push   $0x1f1f
    10d8:	6a 02                	push   $0x2
    10da:	e8 61 0a 00 00       	call   1b40 <fprintf>
    10df:	83 c4 20             	add    $0x20,%esp
  if (confirmation() != 0) return;
    10e2:	e8 39 f8 ff ff       	call   920 <confirmation>
    10e7:	85 c0                	test   %eax,%eax
    10e9:	75 7f                	jne    116a <drop+0x11a>
  return nodeAt(list, pos-1);
    10eb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  struct Node* curNode = (lineAt(file->lines, start))->prev;
    10ee:	8b 4b 0c             	mov    0xc(%ebx),%ecx
    10f1:	83 ec 08             	sub    $0x8,%esp
  file->edited = 1;
    10f4:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
    10fb:	83 e8 01             	sub    $0x1,%eax
    10fe:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    1101:	50                   	push   %eax
    1102:	51                   	push   %ecx
    1103:	e8 f8 f5 ff ff       	call   700 <nodeAt>
  struct Node* curNode = (lineAt(file->lines, start))->prev;
    1108:	8b 30                	mov    (%eax),%esi
    110a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    110d:	5a                   	pop    %edx
    110e:	59                   	pop    %ecx
    110f:	8b 4d d0             	mov    -0x30(%ebp),%ecx
    1112:	83 e8 01             	sub    $0x1,%eax
    1115:	50                   	push   %eax
    1116:	51                   	push   %ecx
    1117:	e8 e4 f5 ff ff       	call   700 <nodeAt>
    111c:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
    111f:	39 c6                	cmp    %eax,%esi
    1121:	89 c7                	mov    %eax,%edi
    1123:	8b 4d d0             	mov    -0x30(%ebp),%ecx
    1126:	75 0b                	jne    1133 <drop+0xe3>
    1128:	eb 21                	jmp    114b <drop+0xfb>
    112a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1130:	8b 4b 0c             	mov    0xc(%ebx),%ecx
    curNode = curNode->next;
    1133:	8b 76 08             	mov    0x8(%esi),%esi
    destroyNode(file->lines, curNode);
    1136:	83 ec 08             	sub    $0x8,%esp
    1139:	56                   	push   %esi
    113a:	51                   	push   %ecx
    113b:	e8 30 f6 ff ff       	call   770 <destroyNode>
    file->len--;
    1140:	83 6b 10 01          	subl   $0x1,0x10(%ebx)
  while (curNode != stopNode) {
    1144:	83 c4 10             	add    $0x10,%esp
    1147:	39 f7                	cmp    %esi,%edi
    1149:	75 e5                	jne    1130 <drop+0xe0>
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
    114b:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
    114f:	0f 84 93 00 00 00    	je     11e8 <drop+0x198>
  else fprintf(2, "%d lines dropped\n", numl);
    1155:	83 ec 04             	sub    $0x4,%esp
    1158:	ff 75 d4             	pushl  -0x2c(%ebp)
    115b:	68 4e 1f 00 00       	push   $0x1f4e
    1160:	6a 02                	push   $0x2
    1162:	e8 d9 09 00 00       	call   1b40 <fprintf>
    1167:	83 c4 10             	add    $0x10,%esp
}
    116a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    116d:	5b                   	pop    %ebx
    116e:	5e                   	pop    %esi
    116f:	5f                   	pop    %edi
    1170:	5d                   	pop    %ebp
    1171:	c3                   	ret    
    1172:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "you need to give a range to drop\n");
    1178:	83 ec 08             	sub    $0x8,%esp
    117b:	68 84 1d 00 00       	push   $0x1d84
    1180:	6a 02                	push   $0x2
    1182:	e8 b9 09 00 00       	call   1b40 <fprintf>
    return;
    1187:	83 c4 10             	add    $0x10,%esp
}
    118a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    118d:	5b                   	pop    %ebx
    118e:	5e                   	pop    %esi
    118f:	5f                   	pop    %edi
    1190:	5d                   	pop    %ebp
    1191:	c3                   	ret    
    1192:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: start index is larger than end index\n");
    1198:	83 ec 08             	sub    $0x8,%esp
    119b:	68 a8 1d 00 00       	push   $0x1da8
    11a0:	6a 02                	push   $0x2
    11a2:	e8 99 09 00 00       	call   1b40 <fprintf>
    11a7:	83 c4 10             	add    $0x10,%esp
}
    11aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11ad:	5b                   	pop    %ebx
    11ae:	5e                   	pop    %esi
    11af:	5f                   	pop    %edi
    11b0:	5d                   	pop    %ebp
    11b1:	c3                   	ret    
    11b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
    11b8:	83 ec 04             	sub    $0x4,%esp
    11bb:	50                   	push   %eax
    11bc:	68 0a 1f 00 00       	push   $0x1f0a
    11c1:	6a 02                	push   $0x2
    11c3:	e8 78 09 00 00       	call   1b40 <fprintf>
    11c8:	83 c4 10             	add    $0x10,%esp
    11cb:	e9 12 ff ff ff       	jmp    10e2 <drop+0x92>
    fprintf(2, "error: bad input range. make sure start < end\n");
    11d0:	83 ec 08             	sub    $0x8,%esp
    11d3:	68 d8 1d 00 00       	push   $0x1dd8
    11d8:	6a 02                	push   $0x2
    11da:	e8 61 09 00 00       	call   1b40 <fprintf>
    11df:	83 c4 10             	add    $0x10,%esp
    11e2:	eb 86                	jmp    116a <drop+0x11a>
    11e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
    11e8:	83 ec 04             	sub    $0x4,%esp
    11eb:	ff 75 e0             	pushl  -0x20(%ebp)
    11ee:	68 3d 1f 00 00       	push   $0x1f3d
    11f3:	6a 02                	push   $0x2
    11f5:	e8 46 09 00 00       	call   1b40 <fprintf>
    11fa:	83 c4 10             	add    $0x10,%esp
    11fd:	e9 68 ff ff ff       	jmp    116a <drop+0x11a>
    1202:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001210 <edit>:
void edit(struct File* file, char* args) {
    1210:	55                   	push   %ebp
    1211:	89 e5                	mov    %esp,%ebp
    1213:	57                   	push   %edi
    1214:	56                   	push   %esi
    1215:	53                   	push   %ebx
    1216:	83 ec 28             	sub    $0x28,%esp
    1219:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if (strlen(args) < 1) {
    121c:	53                   	push   %ebx
    121d:	e8 ce 03 00 00       	call   15f0 <strlen>
    1222:	83 c4 10             	add    $0x10,%esp
    1225:	85 c0                	test   %eax,%eax
    1227:	75 1f                	jne    1248 <edit+0x38>
    fprintf(2, "you need to give a line number to replace\n");
    1229:	83 ec 08             	sub    $0x8,%esp
    122c:	68 08 1e 00 00       	push   $0x1e08
    1231:	6a 02                	push   $0x2
    1233:	e8 08 09 00 00       	call   1b40 <fprintf>
    return;
    1238:	83 c4 10             	add    $0x10,%esp
}
    123b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    123e:	5b                   	pop    %ebx
    123f:	5e                   	pop    %esi
    1240:	5f                   	pop    %edi
    1241:	5d                   	pop    %ebp
    1242:	c3                   	ret    
    1243:	90                   	nop
    1244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  getArg(lineStr, args, ' ');
    1248:	8d 75 de             	lea    -0x22(%ebp),%esi
    124b:	83 ec 04             	sub    $0x4,%esp
    124e:	6a 20                	push   $0x20
    1250:	53                   	push   %ebx
    1251:	56                   	push   %esi
    1252:	e8 09 f8 ff ff       	call   a60 <getArg>
  int lineNum = negatoi(lineStr);
    1257:	89 34 24             	mov    %esi,(%esp)
    125a:	e8 21 f3 ff ff       	call   580 <negatoi>
  fprintf(2, "replace line %d (y/n)? ", lineNum);
    125f:	83 c4 0c             	add    $0xc,%esp
  int lineNum = negatoi(lineStr);
    1262:	89 c6                	mov    %eax,%esi
  fprintf(2, "replace line %d (y/n)? ", lineNum);
    1264:	50                   	push   %eax
    1265:	68 60 1f 00 00       	push   $0x1f60
    126a:	6a 02                	push   $0x2
    126c:	e8 cf 08 00 00       	call   1b40 <fprintf>
  if (confirmation() != 0) return;
    1271:	e8 aa f6 ff ff       	call   920 <confirmation>
    1276:	83 c4 10             	add    $0x10,%esp
    1279:	85 c0                	test   %eax,%eax
    127b:	75 be                	jne    123b <edit+0x2b>
  file->edited = 1;
    127d:	8b 45 08             	mov    0x8(%ebp),%eax
    1280:	83 ec 08             	sub    $0x8,%esp
    1283:	83 ee 01             	sub    $0x1,%esi
  destroyNode(file->lines, lineAt(file->lines, lineNum));
    1286:	8b 78 0c             	mov    0xc(%eax),%edi
  file->edited = 1;
    1289:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    1290:	56                   	push   %esi
    1291:	57                   	push   %edi
    1292:	e8 69 f4 ff ff       	call   700 <nodeAt>
    1297:	5a                   	pop    %edx
    1298:	59                   	pop    %ecx
  destroyNode(file->lines, lineAt(file->lines, lineNum));
    1299:	50                   	push   %eax
    129a:	57                   	push   %edi
    129b:	e8 d0 f4 ff ff       	call   770 <destroyNode>
  insert(file->lines, line, lineNum - 1);
    12a0:	8b 45 08             	mov    0x8(%ebp),%eax
    12a3:	83 c4 0c             	add    $0xc,%esp
    12a6:	56                   	push   %esi
    12a7:	53                   	push   %ebx
    12a8:	ff 70 0c             	pushl  0xc(%eax)
    12ab:	e8 70 f5 ff ff       	call   820 <insert>
    12b0:	83 c4 10             	add    $0x10,%esp
}
    12b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12b6:	5b                   	pop    %ebx
    12b7:	5e                   	pop    %esi
    12b8:	5f                   	pop    %edi
    12b9:	5d                   	pop    %ebp
    12ba:	c3                   	ret    
    12bb:	90                   	nop
    12bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000012c0 <list>:
void list(struct File file, char* args) {
    12c0:	55                   	push   %ebp
    12c1:	89 e5                	mov    %esp,%ebp
    12c3:	57                   	push   %edi
    12c4:	56                   	push   %esi
    12c5:	53                   	push   %ebx
    12c6:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
    12c9:	ff 75 20             	pushl  0x20(%ebp)
    12cc:	8b 75 14             	mov    0x14(%ebp),%esi
    12cf:	e8 1c 03 00 00       	call   15f0 <strlen>
    12d4:	83 c4 10             	add    $0x10,%esp
    12d7:	85 c0                	test   %eax,%eax
    12d9:	75 1d                	jne    12f8 <list+0x38>
    fprintf(2, "you need to give a range to list\n");
    12db:	83 ec 08             	sub    $0x8,%esp
    12de:	68 34 1e 00 00       	push   $0x1e34
    12e3:	6a 02                	push   $0x2
    12e5:	e8 56 08 00 00       	call   1b40 <fprintf>
    return;
    12ea:	83 c4 10             	add    $0x10,%esp
}
    12ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12f0:	5b                   	pop    %ebx
    12f1:	5e                   	pop    %esi
    12f2:	5f                   	pop    %edi
    12f3:	5d                   	pop    %ebp
    12f4:	c3                   	ret    
    12f5:	8d 76 00             	lea    0x0(%esi),%esi
  if (collectRange(args, &start, &end) == 1) {
    12f8:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
    12fb:	8d 7d e0             	lea    -0x20(%ebp),%edi
    12fe:	83 ec 04             	sub    $0x4,%esp
    1301:	53                   	push   %ebx
    1302:	57                   	push   %edi
    1303:	ff 75 20             	pushl  0x20(%ebp)
    1306:	e8 c5 f7 ff ff       	call   ad0 <collectRange>
    130b:	83 c4 10             	add    $0x10,%esp
    130e:	83 f8 01             	cmp    $0x1,%eax
    1311:	0f 84 91 00 00 00    	je     13a8 <list+0xe8>
  if (normalizeRange(file, &start, &end) == 1) {
    1317:	53                   	push   %ebx
    1318:	57                   	push   %edi
    1319:	ff 75 1c             	pushl  0x1c(%ebp)
    131c:	ff 75 18             	pushl  0x18(%ebp)
    131f:	ff 75 14             	pushl  0x14(%ebp)
    1322:	ff 75 10             	pushl  0x10(%ebp)
    1325:	ff 75 0c             	pushl  0xc(%ebp)
    1328:	ff 75 08             	pushl  0x8(%ebp)
    132b:	e8 50 f6 ff ff       	call   980 <normalizeRange>
    1330:	83 c4 20             	add    $0x20,%esp
    1333:	83 f8 01             	cmp    $0x1,%eax
    1336:	0f 84 8c 00 00 00    	je     13c8 <list+0x108>
  lineNum = start - 1;
    133c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    133f:	83 ec 08             	sub    $0x8,%esp
    1342:	8d 78 ff             	lea    -0x1(%eax),%edi
    1345:	57                   	push   %edi
    1346:	56                   	push   %esi
    1347:	e8 b4 f3 ff ff       	call   700 <nodeAt>
  struct Node* curNode = (lineAt(file.lines, start))->prev;
    134c:	8b 18                	mov    (%eax),%ebx
    134e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1351:	5a                   	pop    %edx
    1352:	59                   	pop    %ecx
    1353:	83 e8 01             	sub    $0x1,%eax
    1356:	50                   	push   %eax
    1357:	56                   	push   %esi
    1358:	e8 a3 f3 ff ff       	call   700 <nodeAt>
    135d:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
    1360:	39 d8                	cmp    %ebx,%eax
    1362:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1365:	74 86                	je     12ed <list+0x2d>
    curNode = curNode->next;
    1367:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
    136a:	3b 5e 04             	cmp    0x4(%esi),%ebx
    136d:	75 15                	jne    1384 <list+0xc4>
    136f:	e9 79 ff ff ff       	jmp    12ed <list+0x2d>
    1374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
    1378:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
    137b:	39 5e 04             	cmp    %ebx,0x4(%esi)
    137e:	0f 84 69 ff ff ff    	je     12ed <list+0x2d>
    printl(++lineNum, curNode->data);
    1384:	83 ec 08             	sub    $0x8,%esp
    1387:	83 c7 01             	add    $0x1,%edi
    138a:	ff 73 04             	pushl  0x4(%ebx)
    138d:	57                   	push   %edi
    138e:	e8 6d fa ff ff       	call   e00 <printl>
  while (curNode != stopNode) {
    1393:	83 c4 10             	add    $0x10,%esp
    1396:	39 5d d4             	cmp    %ebx,-0x2c(%ebp)
    1399:	75 dd                	jne    1378 <list+0xb8>
}
    139b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    139e:	5b                   	pop    %ebx
    139f:	5e                   	pop    %esi
    13a0:	5f                   	pop    %edi
    13a1:	5d                   	pop    %ebp
    13a2:	c3                   	ret    
    13a3:	90                   	nop
    13a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "error: start index is larger than end index\n");
    13a8:	83 ec 08             	sub    $0x8,%esp
    13ab:	68 a8 1d 00 00       	push   $0x1da8
    13b0:	6a 02                	push   $0x2
    13b2:	e8 89 07 00 00       	call   1b40 <fprintf>
    return;
    13b7:	83 c4 10             	add    $0x10,%esp
}
    13ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
    13bd:	5b                   	pop    %ebx
    13be:	5e                   	pop    %esi
    13bf:	5f                   	pop    %edi
    13c0:	5d                   	pop    %ebp
    13c1:	c3                   	ret    
    13c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: bad input range. make sure start < end\n");
    13c8:	83 ec 08             	sub    $0x8,%esp
    13cb:	68 d8 1d 00 00       	push   $0x1dd8
    13d0:	6a 02                	push   $0x2
    13d2:	e8 69 07 00 00       	call   1b40 <fprintf>
    return;
    13d7:	83 c4 10             	add    $0x10,%esp
    13da:	e9 0e ff ff ff       	jmp    12ed <list+0x2d>
    13df:	90                   	nop

000013e0 <show>:
void show(struct File file, char* args) {
    13e0:	55                   	push   %ebp
    13e1:	89 e5                	mov    %esp,%ebp
    13e3:	57                   	push   %edi
    13e4:	56                   	push   %esi
    13e5:	53                   	push   %ebx
    13e6:	83 ec 0c             	sub    $0xc,%esp
    13e9:	8b 7d 14             	mov    0x14(%ebp),%edi
  struct Node* cur = file.lines->head->next;
    13ec:	8b 07                	mov    (%edi),%eax
    13ee:	8b 58 08             	mov    0x8(%eax),%ebx
  while (cur != file.lines->tail) {
    13f1:	3b 5f 04             	cmp    0x4(%edi),%ebx
    13f4:	74 24                	je     141a <show+0x3a>
  int lineNum = 1;
    13f6:	be 01 00 00 00       	mov    $0x1,%esi
    13fb:	90                   	nop
    13fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printl(lineNum, cur->data);
    1400:	83 ec 08             	sub    $0x8,%esp
    1403:	ff 73 04             	pushl  0x4(%ebx)
    1406:	56                   	push   %esi
    lineNum++;
    1407:	83 c6 01             	add    $0x1,%esi
    printl(lineNum, cur->data);
    140a:	e8 f1 f9 ff ff       	call   e00 <printl>
    cur = cur->next;
    140f:	8b 5b 08             	mov    0x8(%ebx),%ebx
  while (cur != file.lines->tail) {
    1412:	83 c4 10             	add    $0x10,%esp
    1415:	39 5f 04             	cmp    %ebx,0x4(%edi)
    1418:	75 e6                	jne    1400 <show+0x20>
}
    141a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    141d:	5b                   	pop    %ebx
    141e:	5e                   	pop    %esi
    141f:	5f                   	pop    %edi
    1420:	5d                   	pop    %ebp
    1421:	c3                   	ret    
    1422:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001430 <quit>:
void quit(struct File* file) {
    1430:	55                   	push   %ebp
    1431:	89 e5                	mov    %esp,%ebp
    1433:	56                   	push   %esi
    1434:	53                   	push   %ebx
    1435:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (file->edited == 0) return;
    1438:	8b 4b 14             	mov    0x14(%ebx),%ecx
    143b:	85 c9                	test   %ecx,%ecx
    143d:	75 11                	jne    1450 <quit+0x20>
}
    143f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1442:	5b                   	pop    %ebx
    1443:	5e                   	pop    %esi
    1444:	5d                   	pop    %ebp
    1445:	c3                   	ret    
    1446:	8d 76 00             	lea    0x0(%esi),%esi
    1449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  fprintf(2, "save changes (y/n)? ");
    1450:	83 ec 08             	sub    $0x8,%esp
    1453:	68 78 1f 00 00       	push   $0x1f78
    1458:	6a 02                	push   $0x2
    145a:	e8 e1 06 00 00       	call   1b40 <fprintf>
  if (confirmation() != 0) return;
    145f:	e8 bc f4 ff ff       	call   920 <confirmation>
    1464:	83 c4 10             	add    $0x10,%esp
    1467:	85 c0                	test   %eax,%eax
    1469:	75 d4                	jne    143f <quit+0xf>
  if (unlink(file->filename) < 0) {
    146b:	83 ec 0c             	sub    $0xc,%esp
    146e:	ff 33                	pushl  (%ebx)
    1470:	e8 a5 03 00 00       	call   181a <unlink>
    1475:	83 c4 10             	add    $0x10,%esp
    1478:	85 c0                	test   %eax,%eax
    147a:	0f 88 90 00 00 00    	js     1510 <quit+0xe0>
  file->fd = open(file->filename, O_CREATE|O_RDWR);
    1480:	83 ec 08             	sub    $0x8,%esp
    1483:	68 02 02 00 00       	push   $0x202
    1488:	ff 33                	pushl  (%ebx)
    148a:	e8 7b 03 00 00       	call   180a <open>
  if (file->fd < 0) {
    148f:	83 c4 10             	add    $0x10,%esp
    1492:	85 c0                	test   %eax,%eax
  file->fd = open(file->filename, O_CREATE|O_RDWR);
    1494:	89 43 04             	mov    %eax,0x4(%ebx)
  if (file->fd < 0) {
    1497:	0f 88 93 00 00 00    	js     1530 <quit+0x100>
  struct Node* cur = file->lines->head->next;
    149d:	8b 53 0c             	mov    0xc(%ebx),%edx
    14a0:	8b 0a                	mov    (%edx),%ecx
    14a2:	8b 71 08             	mov    0x8(%ecx),%esi
  while (cur != file->lines->tail) {
    14a5:	3b 72 04             	cmp    0x4(%edx),%esi
    14a8:	74 43                	je     14ed <quit+0xbd>
    14aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    write(file->fd, cur->data, strlen(cur->data));
    14b0:	83 ec 0c             	sub    $0xc,%esp
    14b3:	ff 76 04             	pushl  0x4(%esi)
    14b6:	e8 35 01 00 00       	call   15f0 <strlen>
    14bb:	83 c4 0c             	add    $0xc,%esp
    14be:	50                   	push   %eax
    14bf:	ff 76 04             	pushl  0x4(%esi)
    14c2:	ff 73 04             	pushl  0x4(%ebx)
    14c5:	e8 20 03 00 00       	call   17ea <write>
    write(file->fd, "\n", sizeof(char));
    14ca:	83 c4 0c             	add    $0xc,%esp
    14cd:	6a 01                	push   $0x1
    14cf:	68 e7 1e 00 00       	push   $0x1ee7
    14d4:	ff 73 04             	pushl  0x4(%ebx)
    14d7:	e8 0e 03 00 00       	call   17ea <write>
  while (cur != file->lines->tail) {
    14dc:	8b 43 0c             	mov    0xc(%ebx),%eax
    cur = cur->next;
    14df:	8b 76 08             	mov    0x8(%esi),%esi
  while (cur != file->lines->tail) {
    14e2:	83 c4 10             	add    $0x10,%esp
    14e5:	3b 70 04             	cmp    0x4(%eax),%esi
    14e8:	75 c6                	jne    14b0 <quit+0x80>
    14ea:	8b 43 04             	mov    0x4(%ebx),%eax
  close(file->fd);
    14ed:	83 ec 0c             	sub    $0xc,%esp
    14f0:	50                   	push   %eax
    14f1:	e8 fc 02 00 00       	call   17f2 <close>
  fprintf(2, "changes saved\n");
    14f6:	58                   	pop    %eax
    14f7:	5a                   	pop    %edx
    14f8:	68 8d 1f 00 00       	push   $0x1f8d
    14fd:	6a 02                	push   $0x2
    14ff:	e8 3c 06 00 00       	call   1b40 <fprintf>
    1504:	83 c4 10             	add    $0x10,%esp
    1507:	e9 33 ff ff ff       	jmp    143f <quit+0xf>
    150c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "could not clear file for writing. changes lost\n");
    1510:	83 ec 08             	sub    $0x8,%esp
    1513:	68 58 1e 00 00       	push   $0x1e58
    1518:	6a 02                	push   $0x2
    151a:	e8 21 06 00 00       	call   1b40 <fprintf>
    return;
    151f:	83 c4 10             	add    $0x10,%esp
    1522:	e9 18 ff ff ff       	jmp    143f <quit+0xf>
    1527:	89 f6                	mov    %esi,%esi
    1529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    fprintf(2, "could not open file for writing. changes lost\n");
    1530:	83 ec 08             	sub    $0x8,%esp
    1533:	68 88 1e 00 00       	push   $0x1e88
    1538:	6a 02                	push   $0x2
    153a:	e8 01 06 00 00       	call   1b40 <fprintf>
    return;
    153f:	83 c4 10             	add    $0x10,%esp
    1542:	e9 f8 fe ff ff       	jmp    143f <quit+0xf>
    1547:	89 f6                	mov    %esi,%esi
    1549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001550 <bi>:
void bi() {
    1550:	55                   	push   %ebp
    1551:	89 e5                	mov    %esp,%ebp
    1553:	83 ec 10             	sub    $0x10,%esp
  fprintf(2, "bad input\n");
    1556:	68 1a 20 00 00       	push   $0x201a
    155b:	6a 02                	push   $0x2
    155d:	e8 de 05 00 00       	call   1b40 <fprintf>
}
    1562:	83 c4 10             	add    $0x10,%esp
    1565:	c9                   	leave  
    1566:	c3                   	ret    
    1567:	66 90                	xchg   %ax,%ax
    1569:	66 90                	xchg   %ax,%ax
    156b:	66 90                	xchg   %ax,%ax
    156d:	66 90                	xchg   %ax,%ax
    156f:	90                   	nop

00001570 <strcpy>:
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
    1570:	55                   	push   %ebp
    1571:	89 e5                	mov    %esp,%ebp
    1573:	53                   	push   %ebx
    1574:	8b 45 08             	mov    0x8(%ebp),%eax
    1577:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    157a:	89 c2                	mov    %eax,%edx
    157c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1580:	83 c1 01             	add    $0x1,%ecx
    1583:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1587:	83 c2 01             	add    $0x1,%edx
    158a:	84 db                	test   %bl,%bl
    158c:	88 5a ff             	mov    %bl,-0x1(%edx)
    158f:	75 ef                	jne    1580 <strcpy+0x10>
    ;
  return os;
}
    1591:	5b                   	pop    %ebx
    1592:	5d                   	pop    %ebp
    1593:	c3                   	ret    
    1594:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    159a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000015a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    15a0:	55                   	push   %ebp
    15a1:	89 e5                	mov    %esp,%ebp
    15a3:	53                   	push   %ebx
    15a4:	8b 55 08             	mov    0x8(%ebp),%edx
    15a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    15aa:	0f b6 02             	movzbl (%edx),%eax
    15ad:	0f b6 19             	movzbl (%ecx),%ebx
    15b0:	84 c0                	test   %al,%al
    15b2:	75 1c                	jne    15d0 <strcmp+0x30>
    15b4:	eb 2a                	jmp    15e0 <strcmp+0x40>
    15b6:	8d 76 00             	lea    0x0(%esi),%esi
    15b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    15c0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    15c3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    15c6:	83 c1 01             	add    $0x1,%ecx
    15c9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    15cc:	84 c0                	test   %al,%al
    15ce:	74 10                	je     15e0 <strcmp+0x40>
    15d0:	38 d8                	cmp    %bl,%al
    15d2:	74 ec                	je     15c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    15d4:	29 d8                	sub    %ebx,%eax
}
    15d6:	5b                   	pop    %ebx
    15d7:	5d                   	pop    %ebp
    15d8:	c3                   	ret    
    15d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15e0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    15e2:	29 d8                	sub    %ebx,%eax
}
    15e4:	5b                   	pop    %ebx
    15e5:	5d                   	pop    %ebp
    15e6:	c3                   	ret    
    15e7:	89 f6                	mov    %esi,%esi
    15e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000015f0 <strlen>:

uint
strlen(const char *s)
{
    15f0:	55                   	push   %ebp
    15f1:	89 e5                	mov    %esp,%ebp
    15f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    15f6:	80 39 00             	cmpb   $0x0,(%ecx)
    15f9:	74 15                	je     1610 <strlen+0x20>
    15fb:	31 d2                	xor    %edx,%edx
    15fd:	8d 76 00             	lea    0x0(%esi),%esi
    1600:	83 c2 01             	add    $0x1,%edx
    1603:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1607:	89 d0                	mov    %edx,%eax
    1609:	75 f5                	jne    1600 <strlen+0x10>
    ;
  return n;
}
    160b:	5d                   	pop    %ebp
    160c:	c3                   	ret    
    160d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    1610:	31 c0                	xor    %eax,%eax
}
    1612:	5d                   	pop    %ebp
    1613:	c3                   	ret    
    1614:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    161a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001620 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1620:	55                   	push   %ebp
    1621:	89 e5                	mov    %esp,%ebp
    1623:	57                   	push   %edi
    1624:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1627:	8b 4d 10             	mov    0x10(%ebp),%ecx
    162a:	8b 45 0c             	mov    0xc(%ebp),%eax
    162d:	89 d7                	mov    %edx,%edi
    162f:	fc                   	cld    
    1630:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1632:	89 d0                	mov    %edx,%eax
    1634:	5f                   	pop    %edi
    1635:	5d                   	pop    %ebp
    1636:	c3                   	ret    
    1637:	89 f6                	mov    %esi,%esi
    1639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001640 <strchr>:

char*
strchr(const char *s, char c)
{
    1640:	55                   	push   %ebp
    1641:	89 e5                	mov    %esp,%ebp
    1643:	53                   	push   %ebx
    1644:	8b 45 08             	mov    0x8(%ebp),%eax
    1647:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    164a:	0f b6 10             	movzbl (%eax),%edx
    164d:	84 d2                	test   %dl,%dl
    164f:	74 1d                	je     166e <strchr+0x2e>
    if(*s == c)
    1651:	38 d3                	cmp    %dl,%bl
    1653:	89 d9                	mov    %ebx,%ecx
    1655:	75 0d                	jne    1664 <strchr+0x24>
    1657:	eb 17                	jmp    1670 <strchr+0x30>
    1659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1660:	38 ca                	cmp    %cl,%dl
    1662:	74 0c                	je     1670 <strchr+0x30>
  for(; *s; s++)
    1664:	83 c0 01             	add    $0x1,%eax
    1667:	0f b6 10             	movzbl (%eax),%edx
    166a:	84 d2                	test   %dl,%dl
    166c:	75 f2                	jne    1660 <strchr+0x20>
      return (char*)s;
  return 0;
    166e:	31 c0                	xor    %eax,%eax
}
    1670:	5b                   	pop    %ebx
    1671:	5d                   	pop    %ebp
    1672:	c3                   	ret    
    1673:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001680 <gets>:

char*
gets(char *buf, int max)
{
    1680:	55                   	push   %ebp
    1681:	89 e5                	mov    %esp,%ebp
    1683:	57                   	push   %edi
    1684:	56                   	push   %esi
    1685:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1686:	31 f6                	xor    %esi,%esi
    1688:	89 f3                	mov    %esi,%ebx
{
    168a:	83 ec 1c             	sub    $0x1c,%esp
    168d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1690:	eb 2f                	jmp    16c1 <gets+0x41>
    1692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1698:	8d 45 e7             	lea    -0x19(%ebp),%eax
    169b:	83 ec 04             	sub    $0x4,%esp
    169e:	6a 01                	push   $0x1
    16a0:	50                   	push   %eax
    16a1:	6a 00                	push   $0x0
    16a3:	e8 32 01 00 00       	call   17da <read>
    if(cc < 1)
    16a8:	83 c4 10             	add    $0x10,%esp
    16ab:	85 c0                	test   %eax,%eax
    16ad:	7e 1c                	jle    16cb <gets+0x4b>
      break;
    buf[i++] = c;
    16af:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    16b3:	83 c7 01             	add    $0x1,%edi
    16b6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    16b9:	3c 0a                	cmp    $0xa,%al
    16bb:	74 23                	je     16e0 <gets+0x60>
    16bd:	3c 0d                	cmp    $0xd,%al
    16bf:	74 1f                	je     16e0 <gets+0x60>
  for(i=0; i+1 < max; ){
    16c1:	83 c3 01             	add    $0x1,%ebx
    16c4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    16c7:	89 fe                	mov    %edi,%esi
    16c9:	7c cd                	jl     1698 <gets+0x18>
    16cb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    16cd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    16d0:	c6 03 00             	movb   $0x0,(%ebx)
}
    16d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16d6:	5b                   	pop    %ebx
    16d7:	5e                   	pop    %esi
    16d8:	5f                   	pop    %edi
    16d9:	5d                   	pop    %ebp
    16da:	c3                   	ret    
    16db:	90                   	nop
    16dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    16e0:	8b 75 08             	mov    0x8(%ebp),%esi
    16e3:	8b 45 08             	mov    0x8(%ebp),%eax
    16e6:	01 de                	add    %ebx,%esi
    16e8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    16ea:	c6 03 00             	movb   $0x0,(%ebx)
}
    16ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16f0:	5b                   	pop    %ebx
    16f1:	5e                   	pop    %esi
    16f2:	5f                   	pop    %edi
    16f3:	5d                   	pop    %ebp
    16f4:	c3                   	ret    
    16f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    16f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001700 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
    1700:	55                   	push   %ebp
    1701:	89 e5                	mov    %esp,%ebp
    1703:	56                   	push   %esi
    1704:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1705:	83 ec 08             	sub    $0x8,%esp
    1708:	6a 00                	push   $0x0
    170a:	ff 75 08             	pushl  0x8(%ebp)
    170d:	e8 f8 00 00 00       	call   180a <open>
  if(fd < 0)
    1712:	83 c4 10             	add    $0x10,%esp
    1715:	85 c0                	test   %eax,%eax
    1717:	78 27                	js     1740 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1719:	83 ec 08             	sub    $0x8,%esp
    171c:	ff 75 0c             	pushl  0xc(%ebp)
    171f:	89 c3                	mov    %eax,%ebx
    1721:	50                   	push   %eax
    1722:	e8 fb 00 00 00       	call   1822 <fstat>
  close(fd);
    1727:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    172a:	89 c6                	mov    %eax,%esi
  close(fd);
    172c:	e8 c1 00 00 00       	call   17f2 <close>
  return r;
    1731:	83 c4 10             	add    $0x10,%esp
}
    1734:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1737:	89 f0                	mov    %esi,%eax
    1739:	5b                   	pop    %ebx
    173a:	5e                   	pop    %esi
    173b:	5d                   	pop    %ebp
    173c:	c3                   	ret    
    173d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1740:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1745:	eb ed                	jmp    1734 <stat+0x34>
    1747:	89 f6                	mov    %esi,%esi
    1749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001750 <atoi>:

int
atoi(const char *s)
{
    1750:	55                   	push   %ebp
    1751:	89 e5                	mov    %esp,%ebp
    1753:	53                   	push   %ebx
    1754:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1757:	0f be 11             	movsbl (%ecx),%edx
    175a:	8d 42 d0             	lea    -0x30(%edx),%eax
    175d:	3c 09                	cmp    $0x9,%al
  n = 0;
    175f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    1764:	77 1f                	ja     1785 <atoi+0x35>
    1766:	8d 76 00             	lea    0x0(%esi),%esi
    1769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1770:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1773:	83 c1 01             	add    $0x1,%ecx
    1776:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    177a:	0f be 11             	movsbl (%ecx),%edx
    177d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1780:	80 fb 09             	cmp    $0x9,%bl
    1783:	76 eb                	jbe    1770 <atoi+0x20>
  return n;
}
    1785:	5b                   	pop    %ebx
    1786:	5d                   	pop    %ebp
    1787:	c3                   	ret    
    1788:	90                   	nop
    1789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001790 <memmove>:


void*
memmove(void *vdst, const void *vsrc, int n)
{
    1790:	55                   	push   %ebp
    1791:	89 e5                	mov    %esp,%ebp
    1793:	56                   	push   %esi
    1794:	53                   	push   %ebx
    1795:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1798:	8b 45 08             	mov    0x8(%ebp),%eax
    179b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    179e:	85 db                	test   %ebx,%ebx
    17a0:	7e 14                	jle    17b6 <memmove+0x26>
    17a2:	31 d2                	xor    %edx,%edx
    17a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    17a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    17ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    17af:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    17b2:	39 d3                	cmp    %edx,%ebx
    17b4:	75 f2                	jne    17a8 <memmove+0x18>
  return vdst;
}
    17b6:	5b                   	pop    %ebx
    17b7:	5e                   	pop    %esi
    17b8:	5d                   	pop    %ebp
    17b9:	c3                   	ret    

000017ba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    17ba:	b8 01 00 00 00       	mov    $0x1,%eax
    17bf:	cd 40                	int    $0x40
    17c1:	c3                   	ret    

000017c2 <exit>:
SYSCALL(exit)
    17c2:	b8 02 00 00 00       	mov    $0x2,%eax
    17c7:	cd 40                	int    $0x40
    17c9:	c3                   	ret    

000017ca <wait>:
SYSCALL(wait)
    17ca:	b8 03 00 00 00       	mov    $0x3,%eax
    17cf:	cd 40                	int    $0x40
    17d1:	c3                   	ret    

000017d2 <pipe>:
SYSCALL(pipe)
    17d2:	b8 04 00 00 00       	mov    $0x4,%eax
    17d7:	cd 40                	int    $0x40
    17d9:	c3                   	ret    

000017da <read>:
SYSCALL(read)
    17da:	b8 05 00 00 00       	mov    $0x5,%eax
    17df:	cd 40                	int    $0x40
    17e1:	c3                   	ret    

000017e2 <steal>:
SYSCALL(steal)
    17e2:	b8 17 00 00 00       	mov    $0x17,%eax
    17e7:	cd 40                	int    $0x40
    17e9:	c3                   	ret    

000017ea <write>:
SYSCALL(write)
    17ea:	b8 10 00 00 00       	mov    $0x10,%eax
    17ef:	cd 40                	int    $0x40
    17f1:	c3                   	ret    

000017f2 <close>:
SYSCALL(close)
    17f2:	b8 15 00 00 00       	mov    $0x15,%eax
    17f7:	cd 40                	int    $0x40
    17f9:	c3                   	ret    

000017fa <kill>:
SYSCALL(kill)
    17fa:	b8 06 00 00 00       	mov    $0x6,%eax
    17ff:	cd 40                	int    $0x40
    1801:	c3                   	ret    

00001802 <exec>:
SYSCALL(exec)
    1802:	b8 07 00 00 00       	mov    $0x7,%eax
    1807:	cd 40                	int    $0x40
    1809:	c3                   	ret    

0000180a <open>:
SYSCALL(open)
    180a:	b8 0f 00 00 00       	mov    $0xf,%eax
    180f:	cd 40                	int    $0x40
    1811:	c3                   	ret    

00001812 <mknod>:
SYSCALL(mknod)
    1812:	b8 11 00 00 00       	mov    $0x11,%eax
    1817:	cd 40                	int    $0x40
    1819:	c3                   	ret    

0000181a <unlink>:
SYSCALL(unlink)
    181a:	b8 12 00 00 00       	mov    $0x12,%eax
    181f:	cd 40                	int    $0x40
    1821:	c3                   	ret    

00001822 <fstat>:
SYSCALL(fstat)
    1822:	b8 08 00 00 00       	mov    $0x8,%eax
    1827:	cd 40                	int    $0x40
    1829:	c3                   	ret    

0000182a <link>:
SYSCALL(link)
    182a:	b8 13 00 00 00       	mov    $0x13,%eax
    182f:	cd 40                	int    $0x40
    1831:	c3                   	ret    

00001832 <mkdir>:
SYSCALL(mkdir)
    1832:	b8 14 00 00 00       	mov    $0x14,%eax
    1837:	cd 40                	int    $0x40
    1839:	c3                   	ret    

0000183a <chdir>:
SYSCALL(chdir)
    183a:	b8 09 00 00 00       	mov    $0x9,%eax
    183f:	cd 40                	int    $0x40
    1841:	c3                   	ret    

00001842 <dup>:
SYSCALL(dup)
    1842:	b8 0a 00 00 00       	mov    $0xa,%eax
    1847:	cd 40                	int    $0x40
    1849:	c3                   	ret    

0000184a <getpid>:
SYSCALL(getpid)
    184a:	b8 0b 00 00 00       	mov    $0xb,%eax
    184f:	cd 40                	int    $0x40
    1851:	c3                   	ret    

00001852 <sbrk>:
SYSCALL(sbrk)
    1852:	b8 0c 00 00 00       	mov    $0xc,%eax
    1857:	cd 40                	int    $0x40
    1859:	c3                   	ret    

0000185a <sleep>:
SYSCALL(sleep)
    185a:	b8 0d 00 00 00       	mov    $0xd,%eax
    185f:	cd 40                	int    $0x40
    1861:	c3                   	ret    

00001862 <uptime>:
SYSCALL(uptime)
    1862:	b8 0e 00 00 00       	mov    $0xe,%eax
    1867:	cd 40                	int    $0x40
    1869:	c3                   	ret    

0000186a <cpuhalt>:
SYSCALL(cpuhalt)
    186a:	b8 16 00 00 00       	mov    $0x16,%eax
    186f:	cd 40                	int    $0x40
    1871:	c3                   	ret    
    1872:	66 90                	xchg   %ax,%ax
    1874:	66 90                	xchg   %ax,%ax
    1876:	66 90                	xchg   %ax,%ax
    1878:	66 90                	xchg   %ax,%ax
    187a:	66 90                	xchg   %ax,%ax
    187c:	66 90                	xchg   %ax,%ax
    187e:	66 90                	xchg   %ax,%ax

00001880 <printint.constprop.1>:
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
}

static void
printint(int fd, int xx, int base, int sgn)
    1880:	55                   	push   %ebp
    1881:	89 e5                	mov    %esp,%ebp
    1883:	57                   	push   %edi
    1884:	56                   	push   %esi
    1885:	53                   	push   %ebx
    1886:	89 d6                	mov    %edx,%esi
    1888:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    188b:	85 c0                	test   %eax,%eax
    188d:	79 71                	jns    1900 <printint.constprop.1+0x80>
    188f:	83 e1 01             	and    $0x1,%ecx
    1892:	74 6c                	je     1900 <printint.constprop.1+0x80>
    neg = 1;
    x = -xx;
    1894:	f7 d8                	neg    %eax
    neg = 1;
    1896:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    189d:	31 c9                	xor    %ecx,%ecx
    189f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    18a2:	eb 06                	jmp    18aa <printint.constprop.1+0x2a>
    18a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    18a8:	89 f9                	mov    %edi,%ecx
    18aa:	31 d2                	xor    %edx,%edx
    18ac:	8d 79 01             	lea    0x1(%ecx),%edi
    18af:	f7 f6                	div    %esi
    18b1:	0f b6 92 2c 20 00 00 	movzbl 0x202c(%edx),%edx
  }while((x /= base) != 0);
    18b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    18ba:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    18bd:	75 e9                	jne    18a8 <printint.constprop.1+0x28>
  if(neg)
    18bf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    18c2:	85 c0                	test   %eax,%eax
    18c4:	74 08                	je     18ce <printint.constprop.1+0x4e>
    buf[i++] = '-';
    18c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    18cb:	8d 79 02             	lea    0x2(%ecx),%edi
    18ce:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    18d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    18d8:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    18db:	83 ec 04             	sub    $0x4,%esp
    18de:	83 ee 01             	sub    $0x1,%esi
    18e1:	6a 01                	push   $0x1
    18e3:	53                   	push   %ebx
    18e4:	6a 01                	push   $0x1
    18e6:	88 45 d7             	mov    %al,-0x29(%ebp)
    18e9:	e8 fc fe ff ff       	call   17ea <write>

  while(--i >= 0)
    18ee:	83 c4 10             	add    $0x10,%esp
    18f1:	39 de                	cmp    %ebx,%esi
    18f3:	75 e3                	jne    18d8 <printint.constprop.1+0x58>
    putc(fd, buf[i]);
}
    18f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
    18f8:	5b                   	pop    %ebx
    18f9:	5e                   	pop    %esi
    18fa:	5f                   	pop    %edi
    18fb:	5d                   	pop    %ebp
    18fc:	c3                   	ret    
    18fd:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
    1900:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1907:	eb 94                	jmp    189d <printint.constprop.1+0x1d>
    1909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001910 <vprintf.constprop.0>:
static void vprintf(int fd, const char *fmt, va_list ap)
    1910:	55                   	push   %ebp
    1911:	89 e5                	mov    %esp,%ebp
    1913:	57                   	push   %edi
    1914:	56                   	push   %esi
    1915:	53                   	push   %ebx
    1916:	89 d6                	mov    %edx,%esi
    1918:	83 ec 2c             	sub    $0x2c,%esp
{
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    191b:	0f b6 10             	movzbl (%eax),%edx
    191e:	84 d2                	test   %dl,%dl
    1920:	0f 84 cd 00 00 00    	je     19f3 <vprintf.constprop.0+0xe3>
    1926:	8d 58 01             	lea    0x1(%eax),%ebx
  state = 0;
    1929:	31 ff                	xor    %edi,%edi
    192b:	eb 31                	jmp    195e <vprintf.constprop.0+0x4e>
    192d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1930:	83 f8 25             	cmp    $0x25,%eax
    1933:	0f 84 c7 00 00 00    	je     1a00 <vprintf.constprop.0+0xf0>
  write(fd, &c, 1);
    1939:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    193c:	83 ec 04             	sub    $0x4,%esp
    193f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
    1942:	6a 01                	push   $0x1
    1944:	50                   	push   %eax
    1945:	6a 01                	push   $0x1
    1947:	e8 9e fe ff ff       	call   17ea <write>
    194c:	83 c4 10             	add    $0x10,%esp
    194f:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
    1952:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1956:	84 d2                	test   %dl,%dl
    1958:	0f 84 95 00 00 00    	je     19f3 <vprintf.constprop.0+0xe3>
    if(state == 0){
    195e:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    1960:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    1963:	74 cb                	je     1930 <vprintf.constprop.0+0x20>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1965:	83 ff 25             	cmp    $0x25,%edi
    1968:	75 e5                	jne    194f <vprintf.constprop.0+0x3f>
      if(c == 'd'){
    196a:	83 f8 64             	cmp    $0x64,%eax
        printint(fd, va_arg(ap, int), 10, 1);
    196d:	8d 7e 04             	lea    0x4(%esi),%edi
    1970:	b9 01 00 00 00       	mov    $0x1,%ecx
      if(c == 'd'){
    1975:	0f 84 9a 00 00 00    	je     1a15 <vprintf.constprop.0+0x105>
      } else if(c == 'l') {
    197b:	83 f8 6c             	cmp    $0x6c,%eax
    197e:	0f 84 8c 00 00 00    	je     1a10 <vprintf.constprop.0+0x100>
        printint(fd, va_arg(ap, uint), 10, 0);
      } else if(c == 'x') {
    1984:	83 f8 78             	cmp    $0x78,%eax
    1987:	0f 84 a3 00 00 00    	je     1a30 <vprintf.constprop.0+0x120>
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    198d:	83 f8 70             	cmp    $0x70,%eax
    1990:	0f 84 ca 00 00 00    	je     1a60 <vprintf.constprop.0+0x150>
        printptr(fd, va_arg(ap, uint));
      } else if(c == 's'){
    1996:	83 f8 73             	cmp    $0x73,%eax
    1999:	0f 84 39 01 00 00    	je     1ad8 <vprintf.constprop.0+0x1c8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    199f:	83 f8 63             	cmp    $0x63,%eax
    19a2:	0f 84 68 01 00 00    	je     1b10 <vprintf.constprop.0+0x200>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    19a8:	83 f8 25             	cmp    $0x25,%eax
    19ab:	0f 84 9f 00 00 00    	je     1a50 <vprintf.constprop.0+0x140>
  write(fd, &c, 1);
    19b1:	8d 45 df             	lea    -0x21(%ebp),%eax
    19b4:	83 ec 04             	sub    $0x4,%esp
    19b7:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    19ba:	6a 01                	push   $0x1
    19bc:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
    19c0:	50                   	push   %eax
    19c1:	6a 01                	push   $0x1
    19c3:	e8 22 fe ff ff       	call   17ea <write>
    19c8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    19cc:	83 c4 0c             	add    $0xc,%esp
    19cf:	8d 45 e0             	lea    -0x20(%ebp),%eax
    19d2:	6a 01                	push   $0x1
    19d4:	88 55 e0             	mov    %dl,-0x20(%ebp)
    19d7:	50                   	push   %eax
    19d8:	6a 01                	push   $0x1
    19da:	83 c3 01             	add    $0x1,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    19dd:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    19df:	e8 06 fe ff ff       	call   17ea <write>
  for(i = 0; fmt[i]; i++){
    19e4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
  write(fd, &c, 1);
    19e8:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    19eb:	84 d2                	test   %dl,%dl
    19ed:	0f 85 6b ff ff ff    	jne    195e <vprintf.constprop.0+0x4e>
    }
  }
}
    19f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19f6:	5b                   	pop    %ebx
    19f7:	5e                   	pop    %esi
    19f8:	5f                   	pop    %edi
    19f9:	5d                   	pop    %ebp
    19fa:	c3                   	ret    
    19fb:	90                   	nop
    19fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        state = '%';
    1a00:	bf 25 00 00 00       	mov    $0x25,%edi
    1a05:	e9 45 ff ff ff       	jmp    194f <vprintf.constprop.0+0x3f>
    1a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, uint), 10, 0);
    1a10:	8d 7e 04             	lea    0x4(%esi),%edi
    1a13:	31 c9                	xor    %ecx,%ecx
    1a15:	8b 06                	mov    (%esi),%eax
    1a17:	ba 0a 00 00 00       	mov    $0xa,%edx
    1a1c:	89 fe                	mov    %edi,%esi
      state = 0;
    1a1e:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, uint), 10, 0);
    1a20:	e8 5b fe ff ff       	call   1880 <printint.constprop.1>
    1a25:	e9 25 ff ff ff       	jmp    194f <vprintf.constprop.0+0x3f>
    1a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, int), 16, 0);
    1a30:	8b 06                	mov    (%esi),%eax
    1a32:	8d 7e 04             	lea    0x4(%esi),%edi
    1a35:	31 c9                	xor    %ecx,%ecx
    1a37:	ba 10 00 00 00       	mov    $0x10,%edx
    1a3c:	89 fe                	mov    %edi,%esi
      state = 0;
    1a3e:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, int), 16, 0);
    1a40:	e8 3b fe ff ff       	call   1880 <printint.constprop.1>
    1a45:	e9 05 ff ff ff       	jmp    194f <vprintf.constprop.0+0x3f>
    1a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1a50:	83 ec 04             	sub    $0x4,%esp
    1a53:	88 55 e1             	mov    %dl,-0x1f(%ebp)
    1a56:	8d 45 e1             	lea    -0x1f(%ebp),%eax
    1a59:	6a 01                	push   $0x1
    1a5b:	e9 77 ff ff ff       	jmp    19d7 <vprintf.constprop.0+0xc7>
        printptr(fd, va_arg(ap, uint));
    1a60:	8d 46 04             	lea    0x4(%esi),%eax
  write(fd, &c, 1);
    1a63:	83 ec 04             	sub    $0x4,%esp
        printptr(fd, va_arg(ap, uint));
    1a66:	8b 3e                	mov    (%esi),%edi
  write(fd, &c, 1);
    1a68:	6a 01                	push   $0x1
    1a6a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
    1a6e:	be 08 00 00 00       	mov    $0x8,%esi
        printptr(fd, va_arg(ap, uint));
    1a73:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
    1a76:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1a79:	50                   	push   %eax
    1a7a:	6a 01                	push   $0x1
    1a7c:	e8 69 fd ff ff       	call   17ea <write>
    1a81:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1a84:	83 c4 0c             	add    $0xc,%esp
    1a87:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
    1a8b:	6a 01                	push   $0x1
    1a8d:	50                   	push   %eax
    1a8e:	6a 01                	push   $0x1
    1a90:	e8 55 fd ff ff       	call   17ea <write>
    1a95:	83 c4 10             	add    $0x10,%esp
    1a98:	90                   	nop
    1a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1aa0:	89 f8                	mov    %edi,%eax
  write(fd, &c, 1);
    1aa2:	83 ec 04             	sub    $0x4,%esp
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1aa5:	c1 e7 04             	shl    $0x4,%edi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1aa8:	c1 e8 1c             	shr    $0x1c,%eax
  write(fd, &c, 1);
    1aab:	6a 01                	push   $0x1
    1aad:	0f b6 80 2c 20 00 00 	movzbl 0x202c(%eax),%eax
    1ab4:	88 45 e5             	mov    %al,-0x1b(%ebp)
    1ab7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1aba:	50                   	push   %eax
    1abb:	6a 01                	push   $0x1
    1abd:	e8 28 fd ff ff       	call   17ea <write>
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1ac2:	83 c4 10             	add    $0x10,%esp
    1ac5:	83 ee 01             	sub    $0x1,%esi
    1ac8:	75 d6                	jne    1aa0 <vprintf.constprop.0+0x190>
        s = va_arg(ap, char*);
    1aca:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
    1acd:	31 ff                	xor    %edi,%edi
    1acf:	e9 7b fe ff ff       	jmp    194f <vprintf.constprop.0+0x3f>
    1ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = va_arg(ap, char*);
    1ad8:	8b 3e                	mov    (%esi),%edi
    1ada:	8d 46 04             	lea    0x4(%esi),%eax
    1add:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    1ae0:	85 ff                	test   %edi,%edi
    1ae2:	74 50                	je     1b34 <vprintf.constprop.0+0x224>
        while(*s != 0){
    1ae4:	0f b6 07             	movzbl (%edi),%eax
    1ae7:	84 c0                	test   %al,%al
    1ae9:	74 df                	je     1aca <vprintf.constprop.0+0x1ba>
    1aeb:	8d 75 e3             	lea    -0x1d(%ebp),%esi
    1aee:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
    1af0:	83 ec 04             	sub    $0x4,%esp
          s++;
    1af3:	83 c7 01             	add    $0x1,%edi
    1af6:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1af9:	6a 01                	push   $0x1
    1afb:	56                   	push   %esi
    1afc:	6a 01                	push   $0x1
    1afe:	e8 e7 fc ff ff       	call   17ea <write>
        while(*s != 0){
    1b03:	0f b6 07             	movzbl (%edi),%eax
    1b06:	83 c4 10             	add    $0x10,%esp
    1b09:	84 c0                	test   %al,%al
    1b0b:	75 e3                	jne    1af0 <vprintf.constprop.0+0x1e0>
    1b0d:	eb bb                	jmp    1aca <vprintf.constprop.0+0x1ba>
    1b0f:	90                   	nop
        putc(fd, va_arg(ap, uint));
    1b10:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
    1b12:	83 ec 04             	sub    $0x4,%esp
        putc(fd, va_arg(ap, uint));
    1b15:	8d 7e 04             	lea    0x4(%esi),%edi
  write(fd, &c, 1);
    1b18:	6a 01                	push   $0x1
        putc(fd, va_arg(ap, uint));
    1b1a:	89 fe                	mov    %edi,%esi
      state = 0;
    1b1c:	31 ff                	xor    %edi,%edi
        putc(fd, va_arg(ap, uint));
    1b1e:	88 45 e2             	mov    %al,-0x1e(%ebp)
  write(fd, &c, 1);
    1b21:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1b24:	50                   	push   %eax
    1b25:	6a 01                	push   $0x1
    1b27:	e8 be fc ff ff       	call   17ea <write>
    1b2c:	83 c4 10             	add    $0x10,%esp
    1b2f:	e9 1b fe ff ff       	jmp    194f <vprintf.constprop.0+0x3f>
          s = "(null)";
    1b34:	bf 25 20 00 00       	mov    $0x2025,%edi
        while(*s != 0){
    1b39:	b8 28 00 00 00       	mov    $0x28,%eax
    1b3e:	eb ab                	jmp    1aeb <vprintf.constprop.0+0x1db>

00001b40 <fprintf>:
// Print to the given fd. Only understands %d,%x, %p, %s, %c.
void
fprintf(int fd, const char *fmt, ...)
{
    1b40:	55                   	push   %ebp
    1b41:	89 e5                	mov    %esp,%ebp
    1b43:	83 ec 08             	sub    $0x8,%esp
 va_list ap;
 va_start(ap, fmt); 
 vprintf(1,fmt,ap);
    1b46:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b49:	8d 55 10             	lea    0x10(%ebp),%edx
    1b4c:	e8 bf fd ff ff       	call   1910 <vprintf.constprop.0>
}
    1b51:	c9                   	leave  
    1b52:	c3                   	ret    
    1b53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001b60 <printf>:
void
printf(const char *fmt, ...)
{
    1b60:	55                   	push   %ebp
    1b61:	89 e5                	mov    %esp,%ebp
    1b63:	83 ec 08             	sub    $0x8,%esp
  va_list ap;
  va_start(ap, fmt); 
  vprintf(1,fmt,ap);
    1b66:	8b 45 08             	mov    0x8(%ebp),%eax
    1b69:	8d 55 0c             	lea    0xc(%ebp),%edx
    1b6c:	e8 9f fd ff ff       	call   1910 <vprintf.constprop.0>
}
    1b71:	c9                   	leave  
    1b72:	c3                   	ret    
    1b73:	66 90                	xchg   %ax,%ax
    1b75:	66 90                	xchg   %ax,%ax
    1b77:	66 90                	xchg   %ax,%ax
    1b79:	66 90                	xchg   %ax,%ax
    1b7b:	66 90                	xchg   %ax,%ax
    1b7d:	66 90                	xchg   %ax,%ax
    1b7f:	90                   	nop

00001b80 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1b80:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b81:	a1 88 2d 00 00       	mov    0x2d88,%eax
{
    1b86:	89 e5                	mov    %esp,%ebp
    1b88:	57                   	push   %edi
    1b89:	56                   	push   %esi
    1b8a:	53                   	push   %ebx
    1b8b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    1b8e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1b91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b98:	39 c8                	cmp    %ecx,%eax
    1b9a:	8b 10                	mov    (%eax),%edx
    1b9c:	73 32                	jae    1bd0 <free+0x50>
    1b9e:	39 d1                	cmp    %edx,%ecx
    1ba0:	72 04                	jb     1ba6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1ba2:	39 d0                	cmp    %edx,%eax
    1ba4:	72 32                	jb     1bd8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1ba6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1ba9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1bac:	39 fa                	cmp    %edi,%edx
    1bae:	74 30                	je     1be0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1bb0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1bb3:	8b 50 04             	mov    0x4(%eax),%edx
    1bb6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1bb9:	39 f1                	cmp    %esi,%ecx
    1bbb:	74 3a                	je     1bf7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1bbd:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1bbf:	a3 88 2d 00 00       	mov    %eax,0x2d88
}
    1bc4:	5b                   	pop    %ebx
    1bc5:	5e                   	pop    %esi
    1bc6:	5f                   	pop    %edi
    1bc7:	5d                   	pop    %ebp
    1bc8:	c3                   	ret    
    1bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1bd0:	39 d0                	cmp    %edx,%eax
    1bd2:	72 04                	jb     1bd8 <free+0x58>
    1bd4:	39 d1                	cmp    %edx,%ecx
    1bd6:	72 ce                	jb     1ba6 <free+0x26>
{
    1bd8:	89 d0                	mov    %edx,%eax
    1bda:	eb bc                	jmp    1b98 <free+0x18>
    1bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1be0:	03 72 04             	add    0x4(%edx),%esi
    1be3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1be6:	8b 10                	mov    (%eax),%edx
    1be8:	8b 12                	mov    (%edx),%edx
    1bea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1bed:	8b 50 04             	mov    0x4(%eax),%edx
    1bf0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1bf3:	39 f1                	cmp    %esi,%ecx
    1bf5:	75 c6                	jne    1bbd <free+0x3d>
    p->s.size += bp->s.size;
    1bf7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    1bfa:	a3 88 2d 00 00       	mov    %eax,0x2d88
    p->s.size += bp->s.size;
    1bff:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1c02:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1c05:	89 10                	mov    %edx,(%eax)
}
    1c07:	5b                   	pop    %ebx
    1c08:	5e                   	pop    %esi
    1c09:	5f                   	pop    %edi
    1c0a:	5d                   	pop    %ebp
    1c0b:	c3                   	ret    
    1c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001c10 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1c10:	55                   	push   %ebp
    1c11:	89 e5                	mov    %esp,%ebp
    1c13:	57                   	push   %edi
    1c14:	56                   	push   %esi
    1c15:	53                   	push   %ebx
    1c16:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1c19:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    1c1c:	8b 15 88 2d 00 00    	mov    0x2d88,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1c22:	8d 78 07             	lea    0x7(%eax),%edi
    1c25:	c1 ef 03             	shr    $0x3,%edi
    1c28:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    1c2b:	85 d2                	test   %edx,%edx
    1c2d:	0f 84 9d 00 00 00    	je     1cd0 <malloc+0xc0>
    1c33:	8b 02                	mov    (%edx),%eax
    1c35:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1c38:	39 cf                	cmp    %ecx,%edi
    1c3a:	76 6c                	jbe    1ca8 <malloc+0x98>
    1c3c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1c42:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1c47:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1c4a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1c51:	eb 0e                	jmp    1c61 <malloc+0x51>
    1c53:	90                   	nop
    1c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1c58:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1c5a:	8b 48 04             	mov    0x4(%eax),%ecx
    1c5d:	39 f9                	cmp    %edi,%ecx
    1c5f:	73 47                	jae    1ca8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1c61:	39 05 88 2d 00 00    	cmp    %eax,0x2d88
    1c67:	89 c2                	mov    %eax,%edx
    1c69:	75 ed                	jne    1c58 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    1c6b:	83 ec 0c             	sub    $0xc,%esp
    1c6e:	56                   	push   %esi
    1c6f:	e8 de fb ff ff       	call   1852 <sbrk>
  if(p == (char*)-1)
    1c74:	83 c4 10             	add    $0x10,%esp
    1c77:	83 f8 ff             	cmp    $0xffffffff,%eax
    1c7a:	74 1c                	je     1c98 <malloc+0x88>
  hp->s.size = nu;
    1c7c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1c7f:	83 ec 0c             	sub    $0xc,%esp
    1c82:	83 c0 08             	add    $0x8,%eax
    1c85:	50                   	push   %eax
    1c86:	e8 f5 fe ff ff       	call   1b80 <free>
  return freep;
    1c8b:	8b 15 88 2d 00 00    	mov    0x2d88,%edx
      if((p = morecore(nunits)) == 0)
    1c91:	83 c4 10             	add    $0x10,%esp
    1c94:	85 d2                	test   %edx,%edx
    1c96:	75 c0                	jne    1c58 <malloc+0x48>
        return 0;
  }
}
    1c98:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1c9b:	31 c0                	xor    %eax,%eax
}
    1c9d:	5b                   	pop    %ebx
    1c9e:	5e                   	pop    %esi
    1c9f:	5f                   	pop    %edi
    1ca0:	5d                   	pop    %ebp
    1ca1:	c3                   	ret    
    1ca2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1ca8:	39 cf                	cmp    %ecx,%edi
    1caa:	74 54                	je     1d00 <malloc+0xf0>
        p->s.size -= nunits;
    1cac:	29 f9                	sub    %edi,%ecx
    1cae:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1cb1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1cb4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1cb7:	89 15 88 2d 00 00    	mov    %edx,0x2d88
}
    1cbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1cc0:	83 c0 08             	add    $0x8,%eax
}
    1cc3:	5b                   	pop    %ebx
    1cc4:	5e                   	pop    %esi
    1cc5:	5f                   	pop    %edi
    1cc6:	5d                   	pop    %ebp
    1cc7:	c3                   	ret    
    1cc8:	90                   	nop
    1cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1cd0:	c7 05 88 2d 00 00 8c 	movl   $0x2d8c,0x2d88
    1cd7:	2d 00 00 
    1cda:	c7 05 8c 2d 00 00 8c 	movl   $0x2d8c,0x2d8c
    1ce1:	2d 00 00 
    base.s.size = 0;
    1ce4:	b8 8c 2d 00 00       	mov    $0x2d8c,%eax
    1ce9:	c7 05 90 2d 00 00 00 	movl   $0x0,0x2d90
    1cf0:	00 00 00 
    1cf3:	e9 44 ff ff ff       	jmp    1c3c <malloc+0x2c>
    1cf8:	90                   	nop
    1cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1d00:	8b 08                	mov    (%eax),%ecx
    1d02:	89 0a                	mov    %ecx,(%edx)
    1d04:	eb b1                	jmp    1cb7 <malloc+0xa7>
