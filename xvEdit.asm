
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
      85:	e8 66 07 00 00       	call   7f0 <MakeLinkedList>
  fprintf(2, "Welcome to xvEdit!\n");
      8a:	51                   	push   %ecx
      8b:	51                   	push   %ecx
      8c:	68 d8 1f 00 00       	push   $0x1fd8
      91:	6a 02                	push   $0x2
  file.lines = MakeLinkedList();
      93:	89 85 0c f8 ff ff    	mov    %eax,-0x7f4(%ebp)
  fprintf(2, "Welcome to xvEdit!\n");
      99:	e8 d2 1a 00 00       	call   1b70 <fprintf>

  // opening file
  file.fd = open(file.filename, O_RDONLY);
      9e:	5b                   	pop    %ebx
      9f:	5e                   	pop    %esi
      a0:	6a 00                	push   $0x0
      a2:	ff b5 00 f8 ff ff    	pushl  -0x800(%ebp)
      a8:	e8 8d 17 00 00       	call   183a <open>
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
      cf:	e8 6c 09 00 00       	call   a40 <gatherLines>
    fprintf(2, "%d lines read from %s\n", file.len, file.filename);
      d4:	ff b5 00 f8 ff ff    	pushl  -0x800(%ebp)
      da:	ff b5 10 f8 ff ff    	pushl  -0x7f0(%ebp)
      e0:	68 fc 1f 00 00       	push   $0x1ffc
      e5:	6a 02                	push   $0x2
      e7:	e8 84 1a 00 00       	call   1b70 <fprintf>
      ec:	83 c4 20             	add    $0x20,%esp
  }
  close(file.fd);
      ef:	83 ec 0c             	sub    $0xc,%esp
      f2:	ff b5 04 f8 ff ff    	pushl  -0x7fc(%ebp)
      f8:	8d 9d 18 f8 ff ff    	lea    -0x7e8(%ebp),%ebx
      fe:	e8 1f 17 00 00       	call   1822 <close>
     103:	83 c4 10             	add    $0x10,%esp
     106:	8d 76 00             	lea    0x0(%esi),%esi
     109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // xvEdit>
  while (cmd != QUIT) {
    fprintf(2, "xvEdit> ");
     110:	83 ec 08             	sub    $0x8,%esp
     113:	68 13 20 00 00       	push   $0x2013
     118:	6a 02                	push   $0x2
     11a:	e8 51 1a 00 00       	call   1b70 <fprintf>
    memset(buf, 0, nbuf);
     11f:	83 c4 0c             	add    $0xc,%esp
     122:	68 e8 03 00 00       	push   $0x3e8
     127:	6a 00                	push   $0x0
     129:	68 20 2a 00 00       	push   $0x2a20
     12e:	e8 1d 15 00 00       	call   1650 <memset>
    gets(buf, nbuf);
     133:	59                   	pop    %ecx
     134:	5e                   	pop    %esi
     135:	68 e8 03 00 00       	push   $0x3e8
     13a:	68 20 2a 00 00       	push   $0x2a20
     13f:	e8 6c 15 00 00       	call   16b0 <gets>
    
    unline(buf);
     144:	c7 04 24 20 2a 00 00 	movl   $0x2a20,(%esp)
     14b:	e8 a0 0b 00 00       	call   cf0 <unline>
    substr(cmdstr, buf, 0, 4);
     150:	6a 04                	push   $0x4
     152:	6a 00                	push   $0x0
     154:	68 20 2a 00 00       	push   $0x2a20
     159:	53                   	push   %ebx
     15a:	e8 c1 03 00 00       	call   520 <substr>
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
     18a:	68 20 2a 00 00       	push   $0x2a20
     18f:	e8 8c 14 00 00       	call   1620 <strlen>
     194:	89 1c 24             	mov    %ebx,(%esp)
     197:	89 c6                	mov    %eax,%esi
     199:	e8 82 14 00 00       	call   1620 <strlen>
     19e:	83 c0 01             	add    $0x1,%eax
     1a1:	56                   	push   %esi
     1a2:	50                   	push   %eax
     1a3:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     1a9:	68 20 2a 00 00       	push   $0x2a20
     1ae:	50                   	push   %eax
     1af:	e8 6c 03 00 00       	call   520 <substr>

    if      (strcmp(cmdstr, "@END") == 0) {cmd = END;}
     1b4:	83 c4 18             	add    $0x18,%esp
     1b7:	68 1c 20 00 00       	push   $0x201c
     1bc:	53                   	push   %ebx
     1bd:	e8 0e 14 00 00       	call   15d0 <strcmp>
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
     1e7:	e8 74 06 00 00       	call   860 <insert>
  file->len++;
     1ec:	83 85 10 f8 ff ff 01 	addl   $0x1,-0x7f0(%ebp)
     1f3:	83 c4 10             	add    $0x10,%esp
     1f6:	e9 15 ff ff ff       	jmp    110 <main+0x110>
    fprintf(2, "only specify one file\n");
     1fb:	57                   	push   %edi
     1fc:	57                   	push   %edi
     1fd:	68 c1 1f 00 00       	push   $0x1fc1
     202:	6a 02                	push   $0x2
     204:	e8 67 19 00 00       	call   1b70 <fprintf>
    exit();
     209:	e8 e4 15 00 00       	call   17f2 <exit>
     20e:	66 90                	xchg   %ax,%ax
    else if (strcmp(cmdstr, "ADD<") == 0) {cmd = ADD;}
     210:	83 ec 08             	sub    $0x8,%esp
     213:	68 21 20 00 00       	push   $0x2021
     218:	53                   	push   %ebx
     219:	e8 b2 13 00 00       	call   15d0 <strcmp>
     21e:	83 c4 10             	add    $0x10,%esp
     221:	85 c0                	test   %eax,%eax
     223:	0f 84 9c 00 00 00    	je     2c5 <main+0x2c5>
    else if (strcmp(cmdstr, "DROP") == 0) {cmd = DROP;}
     229:	52                   	push   %edx
     22a:	52                   	push   %edx
     22b:	68 26 20 00 00       	push   $0x2026
     230:	53                   	push   %ebx
     231:	e8 9a 13 00 00       	call   15d0 <strcmp>
     236:	83 c4 10             	add    $0x10,%esp
     239:	85 c0                	test   %eax,%eax
     23b:	0f 84 a0 00 00 00    	je     2e1 <main+0x2e1>
    else if (strcmp(cmdstr, "EDIT") == 0) {cmd = EDIT;}
     241:	50                   	push   %eax
     242:	50                   	push   %eax
     243:	68 2b 20 00 00       	push   $0x202b
     248:	53                   	push   %ebx
     249:	e8 82 13 00 00       	call   15d0 <strcmp>
     24e:	83 c4 10             	add    $0x10,%esp
     251:	85 c0                	test   %eax,%eax
     253:	0f 84 b7 00 00 00    	je     310 <main+0x310>
    else if (strcmp(cmdstr, "LIST") == 0) {cmd = LIST;}
     259:	50                   	push   %eax
     25a:	50                   	push   %eax
     25b:	68 30 20 00 00       	push   $0x2030
     260:	53                   	push   %ebx
     261:	e8 6a 13 00 00       	call   15d0 <strcmp>
     266:	83 c4 10             	add    $0x10,%esp
     269:	85 c0                	test   %eax,%eax
     26b:	0f 84 02 01 00 00    	je     373 <main+0x373>
    else if (strcmp(cmdstr, "SHOW") == 0) {cmd = SHOW;}
     271:	50                   	push   %eax
     272:	50                   	push   %eax
     273:	68 35 20 00 00       	push   $0x2035
     278:	53                   	push   %ebx
     279:	e8 52 13 00 00       	call   15d0 <strcmp>
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
     2aa:	e8 81 0b 00 00       	call   e30 <printl>
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
     2d4:	e8 27 0d 00 00       	call   1000 <add>
     2d9:	83 c4 10             	add    $0x10,%esp
     2dc:	e9 2f fe ff ff       	jmp    110 <main+0x110>
      drop(&file, args);
     2e1:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     2e7:	51                   	push   %ecx
     2e8:	51                   	push   %ecx
     2e9:	50                   	push   %eax
     2ea:	ff b5 f4 f7 ff ff    	pushl  -0x80c(%ebp)
     2f0:	e8 8b 0d 00 00       	call   1080 <drop>
     2f5:	83 c4 10             	add    $0x10,%esp
     2f8:	e9 13 fe ff ff       	jmp    110 <main+0x110>
    fprintf(2, "specify a file you want to edit\n");
     2fd:	50                   	push   %eax
     2fe:	50                   	push   %eax
     2ff:	68 e8 1e 00 00       	push   $0x1ee8
     304:	6a 02                	push   $0x2
     306:	e8 65 18 00 00       	call   1b70 <fprintf>
    exit();
     30b:	e8 e2 14 00 00       	call   17f2 <exit>
      edit(&file, args);
     310:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     316:	56                   	push   %esi
     317:	56                   	push   %esi
     318:	50                   	push   %eax
     319:	ff b5 f4 f7 ff ff    	pushl  -0x80c(%ebp)
     31f:	e8 1c 0f 00 00       	call   1240 <edit>
     324:	83 c4 10             	add    $0x10,%esp
     327:	e9 e4 fd ff ff       	jmp    110 <main+0x110>
    fprintf(2, "creating %s...\n",  file.filename);
     32c:	57                   	push   %edi
     32d:	ff b5 00 f8 ff ff    	pushl  -0x800(%ebp)
     333:	68 ec 1f 00 00       	push   $0x1fec
     338:	6a 02                	push   $0x2
     33a:	e8 31 18 00 00       	call   1b70 <fprintf>
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     33f:	58                   	pop    %eax
     340:	5a                   	pop    %edx
     341:	68 01 02 00 00       	push   $0x201
     346:	ff b5 00 f8 ff ff    	pushl  -0x800(%ebp)
     34c:	e8 e9 14 00 00       	call   183a <open>
    close(file.fd);
     351:	89 04 24             	mov    %eax,(%esp)
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     354:	89 85 04 f8 ff ff    	mov    %eax,-0x7fc(%ebp)
    close(file.fd);
     35a:	e8 c3 14 00 00       	call   1822 <close>
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
     38d:	e8 5e 0f 00 00       	call   12f0 <list>
     392:	83 c4 20             	add    $0x20,%esp
     395:	e9 76 fd ff ff       	jmp    110 <main+0x110>
    else if (strcmp(cmdstr, "QUIT") == 0) {cmd = QUIT;}
     39a:	50                   	push   %eax
     39b:	50                   	push   %eax
     39c:	68 3a 20 00 00       	push   $0x203a
     3a1:	53                   	push   %ebx
     3a2:	e8 29 12 00 00       	call   15d0 <strcmp>
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
     3b0:	68 3f 20 00 00       	push   $0x203f
     3b5:	6a 02                	push   $0x2
     3b7:	e8 b4 17 00 00       	call   1b70 <fprintf>
     3bc:	83 c4 10             	add    $0x10,%esp
     3bf:	e9 4c fd ff ff       	jmp    110 <main+0x110>
      quit(&file);
     3c4:	83 ec 0c             	sub    $0xc,%esp
     3c7:	ff b5 f4 f7 ff ff    	pushl  -0x80c(%ebp)
     3cd:	e8 8e 10 00 00       	call   1460 <quit>
  close(file.fd);
     3d2:	58                   	pop    %eax
     3d3:	ff b5 04 f8 ff ff    	pushl  -0x7fc(%ebp)
     3d9:	e8 44 14 00 00       	call   1822 <close>
  exit();
     3de:	e8 0f 14 00 00       	call   17f2 <exit>
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
     442:	e8 d9 11 00 00       	call   1620 <strlen>
  memset(line, 0, len);
     447:	83 c4 0c             	add    $0xc,%esp
     44a:	50                   	push   %eax
     44b:	6a 00                	push   $0x0
     44d:	53                   	push   %ebx
     44e:	e8 fd 11 00 00       	call   1650 <memset>
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
     47f:	e8 86 13 00 00       	call   180a <read>
     484:	83 c4 10             	add    $0x10,%esp
     487:	85 c0                	test   %eax,%eax
     489:	75 d5                	jne    460 <getLine+0x30>
     48b:	83 ec 0c             	sub    $0xc,%esp
     48e:	53                   	push   %ebx
     48f:	e8 8c 11 00 00       	call   1620 <strlen>
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

000004c0 <consGetChar>:
char consGetChar() {return (char) steal(0);}
     4c0:	55                   	push   %ebp
     4c1:	89 e5                	mov    %esp,%ebp
     4c3:	83 ec 14             	sub    $0x14,%esp
     4c6:	6a 00                	push   $0x0
     4c8:	e8 45 13 00 00       	call   1812 <steal>
     4cd:	c9                   	leave  
     4ce:	c3                   	ret    
     4cf:	90                   	nop

000004d0 <find>:
int find(char* str, char c) {
     4d0:	55                   	push   %ebp
     4d1:	89 e5                	mov    %esp,%ebp
     4d3:	57                   	push   %edi
     4d4:	56                   	push   %esi
     4d5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     4d6:	31 db                	xor    %ebx,%ebx
int find(char* str, char c) {
     4d8:	83 ec 0c             	sub    $0xc,%esp
     4db:	8b 75 08             	mov    0x8(%ebp),%esi
     4de:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
  for (int i = 0; i < strlen(str); i++)
     4e2:	eb 0e                	jmp    4f2 <find+0x22>
     4e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     4e8:	89 f8                	mov    %edi,%eax
     4ea:	38 04 1e             	cmp    %al,(%esi,%ebx,1)
     4ed:	74 18                	je     507 <find+0x37>
  for (int i = 0; i < strlen(str); i++)
     4ef:	83 c3 01             	add    $0x1,%ebx
     4f2:	83 ec 0c             	sub    $0xc,%esp
     4f5:	56                   	push   %esi
     4f6:	e8 25 11 00 00       	call   1620 <strlen>
     4fb:	83 c4 10             	add    $0x10,%esp
     4fe:	39 d8                	cmp    %ebx,%eax
     500:	77 e6                	ja     4e8 <find+0x18>
  return -1;
     502:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
     507:	8d 65 f4             	lea    -0xc(%ebp),%esp
     50a:	89 d8                	mov    %ebx,%eax
     50c:	5b                   	pop    %ebx
     50d:	5e                   	pop    %esi
     50e:	5f                   	pop    %edi
     50f:	5d                   	pop    %ebp
     510:	c3                   	ret    
     511:	eb 0d                	jmp    520 <substr>
     513:	90                   	nop
     514:	90                   	nop
     515:	90                   	nop
     516:	90                   	nop
     517:	90                   	nop
     518:	90                   	nop
     519:	90                   	nop
     51a:	90                   	nop
     51b:	90                   	nop
     51c:	90                   	nop
     51d:	90                   	nop
     51e:	90                   	nop
     51f:	90                   	nop

00000520 <substr>:
void substr(char* dest, char* str, int start, int end) {
     520:	55                   	push   %ebp
     521:	89 e5                	mov    %esp,%ebp
     523:	57                   	push   %edi
     524:	56                   	push   %esi
     525:	53                   	push   %ebx
     526:	83 ec 18             	sub    $0x18,%esp
     529:	8b 7d 14             	mov    0x14(%ebp),%edi
  int len = strlen(str);
     52c:	ff 75 0c             	pushl  0xc(%ebp)
void substr(char* dest, char* str, int start, int end) {
     52f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     532:	8b 75 08             	mov    0x8(%ebp),%esi
  int len = strlen(str);
     535:	e8 e6 10 00 00       	call   1620 <strlen>
     53a:	83 c4 10             	add    $0x10,%esp
     53d:	39 f8                	cmp    %edi,%eax
     53f:	0f 4e f8             	cmovle %eax,%edi
  while (i < end)
     542:	39 df                	cmp    %ebx,%edi
     544:	7e 1c                	jle    562 <substr+0x42>
     546:	8b 45 0c             	mov    0xc(%ebp),%eax
     549:	29 df                	sub    %ebx,%edi
  int s = 0, i = start;
     54b:	31 d2                	xor    %edx,%edx
     54d:	01 c3                	add    %eax,%ebx
     54f:	90                   	nop
    dest[s++] = str[i++];
     550:	83 c2 01             	add    $0x1,%edx
     553:	0f b6 44 13 ff       	movzbl -0x1(%ebx,%edx,1),%eax
  while (i < end)
     558:	39 fa                	cmp    %edi,%edx
    dest[s++] = str[i++];
     55a:	88 44 16 ff          	mov    %al,-0x1(%esi,%edx,1)
  while (i < end)
     55e:	75 f0                	jne    550 <substr+0x30>
     560:	01 d6                	add    %edx,%esi
  dest[s] = '\0';
     562:	c6 06 00             	movb   $0x0,(%esi)
}
     565:	8d 65 f4             	lea    -0xc(%ebp),%esp
     568:	5b                   	pop    %ebx
     569:	5e                   	pop    %esi
     56a:	5f                   	pop    %edi
     56b:	5d                   	pop    %ebp
     56c:	c3                   	ret    
     56d:	8d 76 00             	lea    0x0(%esi),%esi

00000570 <safestrcpy>:
{
     570:	55                   	push   %ebp
     571:	89 e5                	mov    %esp,%ebp
     573:	53                   	push   %ebx
     574:	8b 4d 10             	mov    0x10(%ebp),%ecx
     577:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(n <= 0)
     57a:	85 c9                	test   %ecx,%ecx
     57c:	7e 0a                	jle    588 <safestrcpy+0x18>
     57e:	8b 55 0c             	mov    0xc(%ebp),%edx
     581:	89 d8                	mov    %ebx,%eax
     583:	e8 68 fe ff ff       	call   3f0 <safestrcpy.part.0>
}
     588:	89 d8                	mov    %ebx,%eax
     58a:	5b                   	pop    %ebx
     58b:	5d                   	pop    %ebp
     58c:	c3                   	ret    
     58d:	8d 76 00             	lea    0x0(%esi),%esi

00000590 <isDigit>:
int isDigit(char c) {
     590:	55                   	push   %ebp
     591:	89 e5                	mov    %esp,%ebp
  if (c >= '0' && c <= '9') return 1;
     593:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
}
     597:	5d                   	pop    %ebp
  if (c >= '0' && c <= '9') return 1;
     598:	83 e8 30             	sub    $0x30,%eax
     59b:	3c 09                	cmp    $0x9,%al
     59d:	0f 96 c0             	setbe  %al
     5a0:	0f b6 c0             	movzbl %al,%eax
}
     5a3:	c3                   	ret    
     5a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     5aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005b0 <ctoi>:
int ctoi(char c) {
     5b0:	55                   	push   %ebp
     5b1:	89 e5                	mov    %esp,%ebp
  return ((int) c) - 48;
     5b3:	0f be 45 08          	movsbl 0x8(%ebp),%eax
}
     5b7:	5d                   	pop    %ebp
  return ((int) c) - 48;
     5b8:	83 e8 30             	sub    $0x30,%eax
}
     5bb:	c3                   	ret    
     5bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005c0 <negatoi>:
int negatoi(char* str) {
     5c0:	55                   	push   %ebp
     5c1:	89 e5                	mov    %esp,%ebp
     5c3:	53                   	push   %ebx
     5c4:	83 ec 04             	sub    $0x4,%esp
     5c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (str[0] == '-') {
     5ca:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     5cd:	74 11                	je     5e0 <negatoi+0x20>
}
     5cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5d2:	c9                   	leave  
  return atoi(str);
     5d3:	e9 a8 11 00 00       	jmp    1780 <atoi>
     5d8:	90                   	nop
     5d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    substr(str, str, 1, strlen(str));
     5e0:	83 ec 0c             	sub    $0xc,%esp
     5e3:	53                   	push   %ebx
     5e4:	e8 37 10 00 00       	call   1620 <strlen>
     5e9:	50                   	push   %eax
     5ea:	6a 01                	push   $0x1
     5ec:	53                   	push   %ebx
     5ed:	53                   	push   %ebx
     5ee:	e8 2d ff ff ff       	call   520 <substr>
    return 0 - atoi(str);
     5f3:	83 c4 14             	add    $0x14,%esp
     5f6:	53                   	push   %ebx
     5f7:	e8 84 11 00 00       	call   1780 <atoi>
     5fc:	83 c4 10             	add    $0x10,%esp
     5ff:	f7 d8                	neg    %eax
}
     601:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     604:	c9                   	leave  
     605:	c3                   	ret    
     606:	8d 76 00             	lea    0x0(%esi),%esi
     609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000610 <itoa>:
char* itoa(int value, char* result, int base) {
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
     613:	57                   	push   %edi
     614:	56                   	push   %esi
     615:	53                   	push   %ebx
     616:	8b 5d 10             	mov    0x10(%ebp),%ebx
     619:	8b 4d 08             	mov    0x8(%ebp),%ecx
     61c:	8b 75 0c             	mov    0xc(%ebp),%esi
    if (base < 2 || base > 36) { *result = '\0'; return result; }
     61f:	8d 43 fe             	lea    -0x2(%ebx),%eax
     622:	83 f8 22             	cmp    $0x22,%eax
     625:	76 0d                	jbe    634 <itoa+0x24>
     627:	eb 57                	jmp    680 <itoa+0x70>
     629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     630:	89 fe                	mov    %edi,%esi
     632:	89 c1                	mov    %eax,%ecx
     634:	89 c8                	mov    %ecx,%eax
        *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" [35 + (tmp_value - value * base)];
     636:	8d 7e 01             	lea    0x1(%esi),%edi
     639:	99                   	cltd   
     63a:	f7 fb                	idiv   %ebx
     63c:	0f b6 92 5b 1d 00 00 	movzbl 0x1d5b(%edx),%edx
    } while ( value );
     643:	85 c0                	test   %eax,%eax
        *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" [35 + (tmp_value - value * base)];
     645:	88 57 ff             	mov    %dl,-0x1(%edi)
    } while ( value );
     648:	75 e6                	jne    630 <itoa+0x20>
    if (tmp_value < 0) *ptr++ = '-';
     64a:	85 c9                	test   %ecx,%ecx
     64c:	78 42                	js     690 <itoa+0x80>
    *ptr-- = '\0';
     64e:	8d 47 ff             	lea    -0x1(%edi),%eax
    while(ptr1 < ptr) {
     651:	39 45 0c             	cmp    %eax,0xc(%ebp)
    *ptr-- = '\0';
     654:	c6 07 00             	movb   $0x0,(%edi)
    while(ptr1 < ptr) {
     657:	73 1d                	jae    676 <itoa+0x66>
     659:	8b 55 0c             	mov    0xc(%ebp),%edx
     65c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        tmp_char = *ptr;
     660:	0f b6 08             	movzbl (%eax),%ecx
        *ptr--= *ptr1;
     663:	0f b6 1a             	movzbl (%edx),%ebx
     666:	83 e8 01             	sub    $0x1,%eax
        *ptr1++ = tmp_char;
     669:	83 c2 01             	add    $0x1,%edx
    while(ptr1 < ptr) {
     66c:	39 d0                	cmp    %edx,%eax
        *ptr--= *ptr1;
     66e:	88 58 01             	mov    %bl,0x1(%eax)
        *ptr1++ = tmp_char;
     671:	88 4a ff             	mov    %cl,-0x1(%edx)
    while(ptr1 < ptr) {
     674:	77 ea                	ja     660 <itoa+0x50>
}
     676:	5b                   	pop    %ebx
     677:	8b 45 0c             	mov    0xc(%ebp),%eax
     67a:	5e                   	pop    %esi
     67b:	5f                   	pop    %edi
     67c:	5d                   	pop    %ebp
     67d:	c3                   	ret    
     67e:	66 90                	xchg   %ax,%ax
    if (base < 2 || base > 36) { *result = '\0'; return result; }
     680:	c6 06 00             	movb   $0x0,(%esi)
}
     683:	8b 45 0c             	mov    0xc(%ebp),%eax
     686:	5b                   	pop    %ebx
     687:	5e                   	pop    %esi
     688:	5f                   	pop    %edi
     689:	5d                   	pop    %ebp
     68a:	c3                   	ret    
     68b:	90                   	nop
     68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (tmp_value < 0) *ptr++ = '-';
     690:	8d 7e 02             	lea    0x2(%esi),%edi
     693:	c6 46 01 2d          	movb   $0x2d,0x1(%esi)
    *ptr-- = '\0';
     697:	8d 47 ff             	lea    -0x1(%edi),%eax
    while(ptr1 < ptr) {
     69a:	39 45 0c             	cmp    %eax,0xc(%ebp)
    *ptr-- = '\0';
     69d:	c6 07 00             	movb   $0x0,(%edi)
    while(ptr1 < ptr) {
     6a0:	72 b7                	jb     659 <itoa+0x49>
     6a2:	eb d2                	jmp    676 <itoa+0x66>
     6a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     6aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000006b0 <toUpper>:
void toUpper(char* str) {
     6b0:	55                   	push   %ebp
     6b1:	89 e5                	mov    %esp,%ebp
     6b3:	8b 55 08             	mov    0x8(%ebp),%edx
  while (str[i] != '\0') {
     6b6:	0f b6 02             	movzbl (%edx),%eax
     6b9:	84 c0                	test   %al,%al
     6bb:	74 1a                	je     6d7 <toUpper+0x27>
     6bd:	8d 76 00             	lea    0x0(%esi),%esi
    if (c <= 'z' && c >= 'a')
     6c0:	8d 48 9f             	lea    -0x61(%eax),%ecx
     6c3:	80 f9 19             	cmp    $0x19,%cl
     6c6:	77 05                	ja     6cd <toUpper+0x1d>
      str[i] += ('Z' - 'z');
     6c8:	83 e8 20             	sub    $0x20,%eax
     6cb:	88 02                	mov    %al,(%edx)
     6cd:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     6d0:	0f b6 02             	movzbl (%edx),%eax
     6d3:	84 c0                	test   %al,%al
     6d5:	75 e9                	jne    6c0 <toUpper+0x10>
    i++;  
  }
}
     6d7:	5d                   	pop    %ebp
     6d8:	c3                   	ret    
     6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006e0 <toLower>:

void toLower(char* str) {
     6e0:	55                   	push   %ebp
     6e1:	89 e5                	mov    %esp,%ebp
     6e3:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     6e6:	0f b6 02             	movzbl (%edx),%eax
     6e9:	84 c0                	test   %al,%al
     6eb:	74 1a                	je     707 <toLower+0x27>
     6ed:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'Z' && c >= 'A')
     6f0:	8d 48 bf             	lea    -0x41(%eax),%ecx
     6f3:	80 f9 19             	cmp    $0x19,%cl
     6f6:	77 05                	ja     6fd <toLower+0x1d>
      str[i] -= ('Z' - 'z');
     6f8:	83 c0 20             	add    $0x20,%eax
     6fb:	88 02                	mov    %al,(%edx)
     6fd:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     700:	0f b6 02             	movzbl (%edx),%eax
     703:	84 c0                	test   %al,%al
     705:	75 e9                	jne    6f0 <toLower+0x10>
    i++;  
  }
}
     707:	5d                   	pop    %ebp
     708:	c3                   	ret    
     709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000710 <nullNode>:
Node* nullNode(char* data) {
     710:	55                   	push   %ebp
     711:	89 e5                	mov    %esp,%ebp
     713:	83 ec 14             	sub    $0x14,%esp
  struct Node* node = malloc(sizeof(Node));
     716:	6a 0c                	push   $0xc
     718:	e8 23 15 00 00       	call   1c40 <malloc>
  node->data = data;
     71d:	8b 55 08             	mov    0x8(%ebp),%edx
  node->prev = nullptr;
     720:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->next = nullptr;
     726:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  node->data = data;
     72d:	89 50 04             	mov    %edx,0x4(%eax)
}
     730:	c9                   	leave  
     731:	c3                   	ret    
     732:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000740 <nodeAt>:
Node* nodeAt(struct LinkedList* list, int pos) {
     740:	55                   	push   %ebp
     741:	89 e5                	mov    %esp,%ebp
     743:	53                   	push   %ebx
     744:	8b 45 08             	mov    0x8(%ebp),%eax
     747:	8b 55 0c             	mov    0xc(%ebp),%edx
  if (pos > list->len)
     74a:	8b 48 08             	mov    0x8(%eax),%ecx
     74d:	39 d1                	cmp    %edx,%ecx
     74f:	7c 1f                	jl     770 <nodeAt+0x30>
  if ((pos < 0) && ((0 - pos) > list->len))
     751:	85 d2                	test   %edx,%edx
     753:	78 2b                	js     780 <nodeAt+0x40>
    curNode = list->head->next;
     755:	8b 00                	mov    (%eax),%eax
     757:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     75a:	74 0e                	je     76a <nodeAt+0x2a>
    int cur = 0;
     75c:	31 c9                	xor    %ecx,%ecx
     75e:	66 90                	xchg   %ax,%ax
      cur++;
     760:	83 c1 01             	add    $0x1,%ecx
      curNode = curNode->next;
     763:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     766:	39 ca                	cmp    %ecx,%edx
     768:	75 f6                	jne    760 <nodeAt+0x20>
}
     76a:	5b                   	pop    %ebx
     76b:	5d                   	pop    %ebp
     76c:	c3                   	ret    
     76d:	8d 76 00             	lea    0x0(%esi),%esi
    return list->tail->prev;
     770:	8b 40 04             	mov    0x4(%eax),%eax
}
     773:	5b                   	pop    %ebx
     774:	5d                   	pop    %ebp
    return list->tail->prev;
     775:	8b 00                	mov    (%eax),%eax
}
     777:	c3                   	ret    
     778:	90                   	nop
     779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if ((pos < 0) && ((0 - pos) > list->len))
     780:	89 d3                	mov    %edx,%ebx
     782:	f7 db                	neg    %ebx
     784:	39 d9                	cmp    %ebx,%ecx
     786:	7c 18                	jl     7a0 <nodeAt+0x60>
    while (++pos != 0)
     788:	83 c2 01             	add    $0x1,%edx
    curNode = list->tail;
     78b:	8b 40 04             	mov    0x4(%eax),%eax
    while (++pos != 0)
     78e:	74 da                	je     76a <nodeAt+0x2a>
     790:	83 c2 01             	add    $0x1,%edx
      curNode = curNode->prev;
     793:	8b 00                	mov    (%eax),%eax
    while (++pos != 0)
     795:	75 f9                	jne    790 <nodeAt+0x50>
}
     797:	5b                   	pop    %ebx
     798:	5d                   	pop    %ebp
     799:	c3                   	ret    
     79a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return list->head->next;
     7a0:	8b 00                	mov    (%eax),%eax
     7a2:	8b 40 08             	mov    0x8(%eax),%eax
     7a5:	eb c3                	jmp    76a <nodeAt+0x2a>
     7a7:	89 f6                	mov    %esi,%esi
     7a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007b0 <destroyNode>:
void destroyNode(struct LinkedList* list, struct Node* self) {
     7b0:	55                   	push   %ebp
     7b1:	89 e5                	mov    %esp,%ebp
     7b3:	56                   	push   %esi
     7b4:	53                   	push   %ebx
     7b5:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     7b8:	8b 75 08             	mov    0x8(%ebp),%esi
    free(self->data);
     7bb:	83 ec 0c             	sub    $0xc,%esp
    self->prev->next = self->next;
     7be:	8b 03                	mov    (%ebx),%eax
     7c0:	8b 53 08             	mov    0x8(%ebx),%edx
     7c3:	89 50 08             	mov    %edx,0x8(%eax)
    self->next->prev = self->prev;
     7c6:	8b 43 08             	mov    0x8(%ebx),%eax
     7c9:	8b 13                	mov    (%ebx),%edx
     7cb:	89 10                	mov    %edx,(%eax)
    free(self->data);
     7cd:	ff 73 04             	pushl  0x4(%ebx)
     7d0:	e8 db 13 00 00       	call   1bb0 <free>
    free(self);
     7d5:	89 1c 24             	mov    %ebx,(%esp)
     7d8:	e8 d3 13 00 00       	call   1bb0 <free>
    list->len--;
     7dd:	83 6e 08 01          	subl   $0x1,0x8(%esi)
}
     7e1:	83 c4 10             	add    $0x10,%esp
     7e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     7e7:	5b                   	pop    %ebx
     7e8:	5e                   	pop    %esi
     7e9:	5d                   	pop    %ebp
     7ea:	c3                   	ret    
     7eb:	90                   	nop
     7ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007f0 <MakeLinkedList>:
LinkedList* MakeLinkedList() {
     7f0:	55                   	push   %ebp
     7f1:	89 e5                	mov    %esp,%ebp
     7f3:	56                   	push   %esi
     7f4:	53                   	push   %ebx
  struct LinkedList* list = malloc(sizeof(LinkedList));
     7f5:	83 ec 0c             	sub    $0xc,%esp
     7f8:	6a 0c                	push   $0xc
     7fa:	e8 41 14 00 00       	call   1c40 <malloc>
  struct Node* node = malloc(sizeof(Node));
     7ff:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  struct LinkedList* list = malloc(sizeof(LinkedList));
     806:	89 c6                	mov    %eax,%esi
  struct Node* node = malloc(sizeof(Node));
     808:	e8 33 14 00 00       	call   1c40 <malloc>
     80d:	89 c3                	mov    %eax,%ebx
  node->prev = nullptr;
     80f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->data = data;
     815:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  node->next = nullptr;
     81c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  struct Node* node = malloc(sizeof(Node));
     823:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     82a:	e8 11 14 00 00       	call   1c40 <malloc>
  node->data = data;
     82f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  head->next = tail;
     836:	89 43 08             	mov    %eax,0x8(%ebx)
  head->prev = nullptr;
     839:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  tail->prev = head;
     83f:	89 18                	mov    %ebx,(%eax)
  tail->next = nullptr;
     841:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  list->tail = tail;
     848:	89 46 04             	mov    %eax,0x4(%esi)
}
     84b:	89 f0                	mov    %esi,%eax
  list->len = 0;
     84d:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
  list->head = head;
     854:	89 1e                	mov    %ebx,(%esi)
}
     856:	8d 65 f8             	lea    -0x8(%ebp),%esp
     859:	5b                   	pop    %ebx
     85a:	5e                   	pop    %esi
     85b:	5d                   	pop    %ebp
     85c:	c3                   	ret    
     85d:	8d 76 00             	lea    0x0(%esi),%esi

00000860 <insert>:
void insert(struct LinkedList* list, char* data, int pos) {
     860:	55                   	push   %ebp
     861:	89 e5                	mov    %esp,%ebp
     863:	57                   	push   %edi
     864:	56                   	push   %esi
     865:	53                   	push   %ebx
     866:	83 ec 0c             	sub    $0xc,%esp
     869:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct Node* atPos = nodeAt(list, pos);
     86c:	ff 75 10             	pushl  0x10(%ebp)
     86f:	53                   	push   %ebx
     870:	e8 cb fe ff ff       	call   740 <nodeAt>
     875:	83 ec 04             	sub    $0x4,%esp
     878:	89 c6                	mov    %eax,%esi
  char* newData = (char*)malloc(sizeof(char) * 1000);
     87a:	68 e8 03 00 00       	push   $0x3e8
     87f:	e8 bc 13 00 00       	call   1c40 <malloc>
     884:	8b 55 0c             	mov    0xc(%ebp),%edx
     887:	89 c7                	mov    %eax,%edi
     889:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
     88e:	e8 5d fb ff ff       	call   3f0 <safestrcpy.part.0>
  struct Node* new = malloc(sizeof(Node));
     893:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     89a:	e8 a1 13 00 00       	call   1c40 <malloc>
  new->data = newData;
     89f:	89 78 04             	mov    %edi,0x4(%eax)
  new->prev = atPos->prev;
     8a2:	8b 16                	mov    (%esi),%edx
}
     8a4:	83 c4 10             	add    $0x10,%esp
  new->next = atPos;
     8a7:	89 70 08             	mov    %esi,0x8(%eax)
  new->prev = atPos->prev;
     8aa:	89 10                	mov    %edx,(%eax)
  new->prev->next = new;
     8ac:	89 42 08             	mov    %eax,0x8(%edx)
  atPos->prev = new;
     8af:	89 06                	mov    %eax,(%esi)
  list->len++;
     8b1:	83 43 08 01          	addl   $0x1,0x8(%ebx)
}
     8b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8b8:	5b                   	pop    %ebx
     8b9:	5e                   	pop    %esi
     8ba:	5f                   	pop    %edi
     8bb:	5d                   	pop    %ebp
     8bc:	c3                   	ret    
     8bd:	8d 76 00             	lea    0x0(%esi),%esi

000008c0 <prepend>:
void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
     8c0:	55                   	push   %ebp
     8c1:	89 e5                	mov    %esp,%ebp
     8c3:	83 ec 0c             	sub    $0xc,%esp
     8c6:	6a 00                	push   $0x0
     8c8:	ff 75 0c             	pushl  0xc(%ebp)
     8cb:	ff 75 08             	pushl  0x8(%ebp)
     8ce:	e8 8d ff ff ff       	call   860 <insert>
     8d3:	83 c4 10             	add    $0x10,%esp
     8d6:	c9                   	leave  
     8d7:	c3                   	ret    
     8d8:	90                   	nop
     8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008e0 <append>:
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     8e0:	55                   	push   %ebp
     8e1:	89 e5                	mov    %esp,%ebp
     8e3:	83 ec 0c             	sub    $0xc,%esp
     8e6:	8b 45 08             	mov    0x8(%ebp),%eax
     8e9:	ff 70 08             	pushl  0x8(%eax)
     8ec:	ff 75 0c             	pushl  0xc(%ebp)
     8ef:	50                   	push   %eax
     8f0:	e8 6b ff ff ff       	call   860 <insert>
     8f5:	83 c4 10             	add    $0x10,%esp
     8f8:	c9                   	leave  
     8f9:	c3                   	ret    
     8fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000900 <destroyLinkedList>:

void destroyLinkedList(struct LinkedList* list) {
     900:	55                   	push   %ebp
     901:	89 e5                	mov    %esp,%ebp
     903:	56                   	push   %esi
     904:	53                   	push   %ebx
     905:	8b 75 08             	mov    0x8(%ebp),%esi
  struct Node* curNode = list->head;
     908:	8b 1e                	mov    (%esi),%ebx
  while (curNode != list->tail) {
     90a:	8b 46 04             	mov    0x4(%esi),%eax
     90d:	39 c3                	cmp    %eax,%ebx
     90f:	74 29                	je     93a <destroyLinkedList+0x3a>
     911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
     918:	8b 5b 08             	mov    0x8(%ebx),%ebx
    free(curNode->prev->data);
     91b:	83 ec 0c             	sub    $0xc,%esp
     91e:	8b 03                	mov    (%ebx),%eax
     920:	ff 70 04             	pushl  0x4(%eax)
     923:	e8 88 12 00 00       	call   1bb0 <free>
    free(curNode->prev);
     928:	58                   	pop    %eax
     929:	ff 33                	pushl  (%ebx)
     92b:	e8 80 12 00 00       	call   1bb0 <free>
  while (curNode != list->tail) {
     930:	8b 46 04             	mov    0x4(%esi),%eax
     933:	83 c4 10             	add    $0x10,%esp
     936:	39 d8                	cmp    %ebx,%eax
     938:	75 de                	jne    918 <destroyLinkedList+0x18>
  }
  free(curNode);
     93a:	83 ec 0c             	sub    $0xc,%esp
     93d:	50                   	push   %eax
     93e:	e8 6d 12 00 00       	call   1bb0 <free>
  free(list);
     943:	89 75 08             	mov    %esi,0x8(%ebp)
     946:	83 c4 10             	add    $0x10,%esp
     949:	8d 65 f8             	lea    -0x8(%ebp),%esp
     94c:	5b                   	pop    %ebx
     94d:	5e                   	pop    %esi
     94e:	5d                   	pop    %ebp
  free(list);
     94f:	e9 5c 12 00 00       	jmp    1bb0 <free>
     954:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     95a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000960 <confirmation>:
// line-oriented text helpers
#include "textEditHelpers.h"

int confirmation() {
     960:	55                   	push   %ebp
     961:	89 e5                	mov    %esp,%ebp
     963:	53                   	push   %ebx
  // get response
  char buf[MAXLINESIZE];
  int nbuf = sizeof(buf);
  memset(buf, 0, nbuf);
     964:	8d 9d 10 fc ff ff    	lea    -0x3f0(%ebp),%ebx
int confirmation() {
     96a:	81 ec f8 03 00 00    	sub    $0x3f8,%esp
  memset(buf, 0, nbuf);
     970:	68 e8 03 00 00       	push   $0x3e8
     975:	6a 00                	push   $0x0
     977:	53                   	push   %ebx
     978:	e8 d3 0c 00 00       	call   1650 <memset>
  gets(buf, nbuf);
     97d:	58                   	pop    %eax
     97e:	5a                   	pop    %edx
     97f:	68 e8 03 00 00       	push   $0x3e8
     984:	53                   	push   %ebx
     985:	e8 26 0d 00 00       	call   16b0 <gets>
  // determine output
  switch (buf[0]) {
     98a:	0f b6 85 10 fc ff ff 	movzbl -0x3f0(%ebp),%eax
     991:	83 c4 10             	add    $0x10,%esp
     994:	3c 59                	cmp    $0x59,%al
     996:	74 18                	je     9b0 <confirmation+0x50>
     998:	3c 79                	cmp    $0x79,%al
     99a:	74 14                	je     9b0 <confirmation+0x50>
  case 'Y':
  case 'y':
    return 0;
  default:
    return 1;
     99c:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
     9a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     9a4:	c9                   	leave  
     9a5:	c3                   	ret    
     9a6:	8d 76 00             	lea    0x0(%esi),%esi
     9a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return 0;
     9b0:	31 c0                	xor    %eax,%eax
}
     9b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     9b5:	c9                   	leave  
     9b6:	c3                   	ret    
     9b7:	89 f6                	mov    %esi,%esi
     9b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009c0 <normalizeRange>:
    return 1;

  return 0;
}

int normalizeRange(File file, int* sp, int* ep) {
     9c0:	55                   	push   %ebp
     9c1:	89 e5                	mov    %esp,%ebp
     9c3:	53                   	push   %ebx
     9c4:	8b 4d 24             	mov    0x24(%ebp),%ecx
  int l = file.len;
     9c7:	8b 45 18             	mov    0x18(%ebp),%eax
int normalizeRange(File file, int* sp, int* ep) {
     9ca:	8b 5d 20             	mov    0x20(%ebp),%ebx
  if (*ep > l) *ep = l;
     9cd:	8b 11                	mov    (%ecx),%edx
     9cf:	39 c2                	cmp    %eax,%edx
     9d1:	7e 45                	jle    a18 <normalizeRange+0x58>
     9d3:	89 01                	mov    %eax,(%ecx)
     9d5:	89 c2                	mov    %eax,%edx
  else if (*ep < 1) *ep += l + 1;
  if (*ep < 1) *ep = 1;
     9d7:	85 d2                	test   %edx,%edx
     9d9:	7f 06                	jg     9e1 <normalizeRange+0x21>
     9db:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)

  if (*sp > l) *sp = l;
     9e1:	8b 13                	mov    (%ebx),%edx
     9e3:	39 c2                	cmp    %eax,%edx
     9e5:	7e 21                	jle    a08 <normalizeRange+0x48>
     9e7:	89 03                	mov    %eax,(%ebx)
     9e9:	89 c2                	mov    %eax,%edx
  else if (*sp < 1) *sp += l + 1;
  if (*sp < 1) *sp = 1;
     9eb:	85 d2                	test   %edx,%edx
     9ed:	7f 0b                	jg     9fa <normalizeRange+0x3a>
     9ef:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
     9f5:	ba 01 00 00 00       	mov    $0x1,%edx
  if ((*ep - *sp) < 0)
     9fa:	8b 01                	mov    (%ecx),%eax
    return 1;
  return 0;
}
     9fc:	5b                   	pop    %ebx
     9fd:	5d                   	pop    %ebp
  if ((*ep - *sp) < 0)
     9fe:	29 d0                	sub    %edx,%eax
     a00:	c1 e8 1f             	shr    $0x1f,%eax
}
     a03:	c3                   	ret    
     a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*sp < 1) *sp += l + 1;
     a08:	85 d2                	test   %edx,%edx
     a0a:	7f ee                	jg     9fa <normalizeRange+0x3a>
     a0c:	8d 54 10 01          	lea    0x1(%eax,%edx,1),%edx
     a10:	89 13                	mov    %edx,(%ebx)
     a12:	eb d7                	jmp    9eb <normalizeRange+0x2b>
     a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*ep < 1) *ep += l + 1;
     a18:	85 d2                	test   %edx,%edx
     a1a:	7f c5                	jg     9e1 <normalizeRange+0x21>
     a1c:	8d 54 02 01          	lea    0x1(%edx,%eax,1),%edx
     a20:	89 11                	mov    %edx,(%ecx)
     a22:	eb b3                	jmp    9d7 <normalizeRange+0x17>
     a24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     a2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000a30 <numLines>:

int numLines(int start, int end) {
     a30:	55                   	push   %ebp
     a31:	89 e5                	mov    %esp,%ebp
  return (end - start) + 1;
     a33:	8b 45 0c             	mov    0xc(%ebp),%eax
     a36:	2b 45 08             	sub    0x8(%ebp),%eax
}
     a39:	5d                   	pop    %ebp
  return (end - start) + 1;
     a3a:	83 c0 01             	add    $0x1,%eax
}
     a3d:	c3                   	ret    
     a3e:	66 90                	xchg   %ax,%ax

00000a40 <gatherLines>:

// text
void gatherLines(File* file) {
     a40:	55                   	push   %ebp
     a41:	89 e5                	mov    %esp,%ebp
     a43:	56                   	push   %esi
     a44:	53                   	push   %ebx
     a45:	8d b5 10 fc ff ff    	lea    -0x3f0(%ebp),%esi
     a4b:	81 ec f0 03 00 00    	sub    $0x3f0,%esp
     a51:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char line[MAXLINESIZE];
  while (getLine(file->fd, line)) {
     a54:	eb 21                	jmp    a77 <gatherLines+0x37>
     a56:	8d 76 00             	lea    0x0(%esi),%esi
     a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    append(file->lines, line);
     a60:	8b 43 0c             	mov    0xc(%ebx),%eax
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     a63:	83 ec 04             	sub    $0x4,%esp
     a66:	ff 70 08             	pushl  0x8(%eax)
     a69:	56                   	push   %esi
     a6a:	50                   	push   %eax
     a6b:	e8 f0 fd ff ff       	call   860 <insert>
    file->len++;
     a70:	83 43 10 01          	addl   $0x1,0x10(%ebx)
     a74:	83 c4 10             	add    $0x10,%esp
  while (getLine(file->fd, line)) {
     a77:	83 ec 08             	sub    $0x8,%esp
     a7a:	56                   	push   %esi
     a7b:	ff 73 04             	pushl  0x4(%ebx)
     a7e:	e8 ad f9 ff ff       	call   430 <getLine>
     a83:	83 c4 10             	add    $0x10,%esp
     a86:	85 c0                	test   %eax,%eax
     a88:	75 d6                	jne    a60 <gatherLines+0x20>
  }
}
     a8a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     a8d:	5b                   	pop    %ebx
     a8e:	5e                   	pop    %esi
     a8f:	5d                   	pop    %ebp
     a90:	c3                   	ret    
     a91:	eb 0d                	jmp    aa0 <getArg>
     a93:	90                   	nop
     a94:	90                   	nop
     a95:	90                   	nop
     a96:	90                   	nop
     a97:	90                   	nop
     a98:	90                   	nop
     a99:	90                   	nop
     a9a:	90                   	nop
     a9b:	90                   	nop
     a9c:	90                   	nop
     a9d:	90                   	nop
     a9e:	90                   	nop
     a9f:	90                   	nop

00000aa0 <getArg>:

void getArg(char* dest, char* args, char delimiter) {
     aa0:	55                   	push   %ebp
     aa1:	89 e5                	mov    %esp,%ebp
     aa3:	57                   	push   %edi
     aa4:	56                   	push   %esi
     aa5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     aa6:	31 db                	xor    %ebx,%ebx
     aa8:	83 ec 1c             	sub    $0x1c,%esp
     aab:	8b 75 0c             	mov    0xc(%ebp),%esi
     aae:	0f b6 7d 10          	movzbl 0x10(%ebp),%edi
     ab2:	eb 10                	jmp    ac4 <getArg+0x24>
     ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     ab8:	89 f8                	mov    %edi,%eax
     aba:	3a 04 1e             	cmp    (%esi,%ebx,1),%al
     abd:	8d 53 01             	lea    0x1(%ebx),%edx
     ac0:	74 19                	je     adb <getArg+0x3b>
     ac2:	89 d3                	mov    %edx,%ebx
  for (int i = 0; i < strlen(str); i++)
     ac4:	83 ec 0c             	sub    $0xc,%esp
     ac7:	56                   	push   %esi
     ac8:	e8 53 0b 00 00       	call   1620 <strlen>
     acd:	83 c4 10             	add    $0x10,%esp
     ad0:	39 c3                	cmp    %eax,%ebx
     ad2:	72 e4                	jb     ab8 <getArg+0x18>
     ad4:	31 d2                	xor    %edx,%edx
  return -1;
     ad6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  int end = find(args, delimiter);
  substr(dest, args, 0, end);
     adb:	53                   	push   %ebx
     adc:	6a 00                	push   $0x0
     ade:	56                   	push   %esi
     adf:	ff 75 08             	pushl  0x8(%ebp)
     ae2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     ae5:	e8 36 fa ff ff       	call   520 <substr>
  substr(args, args, end + 1, (int) strlen(args));
     aea:	89 34 24             	mov    %esi,(%esp)
     aed:	e8 2e 0b 00 00       	call   1620 <strlen>
     af2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     af5:	50                   	push   %eax
     af6:	52                   	push   %edx
     af7:	56                   	push   %esi
     af8:	56                   	push   %esi
     af9:	e8 22 fa ff ff       	call   520 <substr>
}
     afe:	83 c4 20             	add    $0x20,%esp
     b01:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b04:	5b                   	pop    %ebx
     b05:	5e                   	pop    %esi
     b06:	5f                   	pop    %edi
     b07:	5d                   	pop    %ebp
     b08:	c3                   	ret    
     b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000b10 <collectRange>:
int collectRange(char* args, int* startptr, int* endptr) {
     b10:	55                   	push   %ebp
     b11:	89 e5                	mov    %esp,%ebp
     b13:	57                   	push   %edi
     b14:	56                   	push   %esi
     b15:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     b16:	31 f6                	xor    %esi,%esi
     b18:	83 ec 2c             	sub    $0x2c,%esp
     b1b:	8b 5d 08             	mov    0x8(%ebp),%ebx
     b1e:	eb 09                	jmp    b29 <collectRange+0x19>
    if (str[i] == c) return i;
     b20:	80 3c 33 3a          	cmpb   $0x3a,(%ebx,%esi,1)
     b24:	74 42                	je     b68 <collectRange+0x58>
  for (int i = 0; i < strlen(str); i++)
     b26:	83 c6 01             	add    $0x1,%esi
     b29:	83 ec 0c             	sub    $0xc,%esp
     b2c:	53                   	push   %ebx
     b2d:	e8 ee 0a 00 00       	call   1620 <strlen>
     b32:	83 c4 10             	add    $0x10,%esp
     b35:	39 c6                	cmp    %eax,%esi
     b37:	72 e7                	jb     b20 <collectRange+0x10>
    if (args[0] == '-') {
     b39:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     b3c:	0f 84 d6 00 00 00    	je     c18 <collectRange+0x108>
      *startptr = atoi(args);
     b42:	83 ec 0c             	sub    $0xc,%esp
     b45:	53                   	push   %ebx
     b46:	e8 35 0c 00 00       	call   1780 <atoi>
     b4b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     b4e:	83 c4 10             	add    $0x10,%esp
     b51:	89 01                	mov    %eax,(%ecx)
    *endptr = *startptr;
     b53:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b56:	89 01                	mov    %eax,(%ecx)
    return 0;
     b58:	31 c0                	xor    %eax,%eax
}
     b5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b5d:	5b                   	pop    %ebx
     b5e:	5e                   	pop    %esi
     b5f:	5f                   	pop    %edi
     b60:	5d                   	pop    %ebp
     b61:	c3                   	ret    
     b62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  getArg(startstr, args, ':');
     b68:	8d 75 de             	lea    -0x22(%ebp),%esi
     b6b:	83 ec 04             	sub    $0x4,%esp
     b6e:	6a 3a                	push   $0x3a
     b70:	53                   	push   %ebx
     b71:	56                   	push   %esi
     b72:	e8 29 ff ff ff       	call   aa0 <getArg>
  if (startstr[0] == '-') {
     b77:	83 c4 10             	add    $0x10,%esp
     b7a:	80 7d de 2d          	cmpb   $0x2d,-0x22(%ebp)
     b7e:	0f 84 3c 01 00 00    	je     cc0 <collectRange+0x1b0>
  int negStartFlag = 0, negEndFlag = 0;
     b84:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     b8b:	31 ff                	xor    %edi,%edi
  if (endstr[0] == '-') {
     b8d:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     b90:	0f 84 0a 01 00 00    	je     ca0 <collectRange+0x190>
  if (strcmp(startstr, "\0") == 0) *startptr = 1;
     b96:	83 ec 08             	sub    $0x8,%esp
     b99:	68 0c 1f 00 00       	push   $0x1f0c
     b9e:	56                   	push   %esi
     b9f:	e8 2c 0a 00 00       	call   15d0 <strcmp>
     ba4:	83 c4 10             	add    $0x10,%esp
     ba7:	85 c0                	test   %eax,%eax
     ba9:	0f 85 d1 00 00 00    	jne    c80 <collectRange+0x170>
     baf:	8b 45 0c             	mov    0xc(%ebp),%eax
     bb2:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  if (strcmp(endstr, "\0") == 0) *endptr = -1;
     bb8:	83 ec 08             	sub    $0x8,%esp
     bbb:	68 0c 1f 00 00       	push   $0x1f0c
     bc0:	53                   	push   %ebx
     bc1:	e8 0a 0a 00 00       	call   15d0 <strcmp>
     bc6:	83 c4 10             	add    $0x10,%esp
     bc9:	85 c0                	test   %eax,%eax
     bcb:	0f 85 97 00 00 00    	jne    c68 <collectRange+0x158>
     bd1:	8b 45 10             	mov    0x10(%ebp),%eax
     bd4:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  if (negStartFlag) *startptr = 0 - *startptr;
     bda:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     bdd:	85 c0                	test   %eax,%eax
     bdf:	74 05                	je     be6 <collectRange+0xd6>
     be1:	8b 45 0c             	mov    0xc(%ebp),%eax
     be4:	f7 18                	negl   (%eax)
  if (negEndFlag) *endptr = 0 - *endptr;
     be6:	85 ff                	test   %edi,%edi
     be8:	74 05                	je     bef <collectRange+0xdf>
     bea:	8b 45 10             	mov    0x10(%ebp),%eax
     bed:	f7 18                	negl   (%eax)
  if (((*startptr > 0 && *endptr > 0) || 
     bef:	8b 45 0c             	mov    0xc(%ebp),%eax
     bf2:	8b 00                	mov    (%eax),%eax
     bf4:	83 f8 00             	cmp    $0x0,%eax
     bf7:	7e 4f                	jle    c48 <collectRange+0x138>
     bf9:	8b 55 10             	mov    0x10(%ebp),%edx
     bfc:	8b 12                	mov    (%edx),%edx
     bfe:	85 d2                	test   %edx,%edx
     c00:	7e 55                	jle    c57 <collectRange+0x147>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     c02:	39 d0                	cmp    %edx,%eax
     c04:	0f 9f c0             	setg   %al
}
     c07:	8d 65 f4             	lea    -0xc(%ebp),%esp
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     c0a:	0f b6 c0             	movzbl %al,%eax
}
     c0d:	5b                   	pop    %ebx
     c0e:	5e                   	pop    %esi
     c0f:	5f                   	pop    %edi
     c10:	5d                   	pop    %ebp
     c11:	c3                   	ret    
     c12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      substr(args, args, 1, strlen(args));
     c18:	83 ec 0c             	sub    $0xc,%esp
     c1b:	53                   	push   %ebx
     c1c:	e8 ff 09 00 00       	call   1620 <strlen>
     c21:	50                   	push   %eax
     c22:	6a 01                	push   $0x1
     c24:	53                   	push   %ebx
     c25:	53                   	push   %ebx
     c26:	e8 f5 f8 ff ff       	call   520 <substr>
      *startptr = 0 - atoi(args);
     c2b:	83 c4 14             	add    $0x14,%esp
     c2e:	53                   	push   %ebx
     c2f:	e8 4c 0b 00 00       	call   1780 <atoi>
     c34:	8b 7d 0c             	mov    0xc(%ebp),%edi
     c37:	f7 d8                	neg    %eax
     c39:	83 c4 10             	add    $0x10,%esp
     c3c:	89 07                	mov    %eax,(%edi)
     c3e:	e9 10 ff ff ff       	jmp    b53 <collectRange+0x43>
     c43:	90                   	nop
     c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (((*startptr > 0 && *endptr > 0) || 
     c48:	0f 84 0c ff ff ff    	je     b5a <collectRange+0x4a>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     c4e:	8b 7d 10             	mov    0x10(%ebp),%edi
     c51:	8b 17                	mov    (%edi),%edx
     c53:	85 d2                	test   %edx,%edx
     c55:	78 ab                	js     c02 <collectRange+0xf2>
}
     c57:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
     c5a:	31 c0                	xor    %eax,%eax
}
     c5c:	5b                   	pop    %ebx
     c5d:	5e                   	pop    %esi
     c5e:	5f                   	pop    %edi
     c5f:	5d                   	pop    %ebp
     c60:	c3                   	ret    
     c61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else *endptr = atoi(endstr);
     c68:	83 ec 0c             	sub    $0xc,%esp
     c6b:	53                   	push   %ebx
     c6c:	e8 0f 0b 00 00       	call   1780 <atoi>
     c71:	8b 55 10             	mov    0x10(%ebp),%edx
     c74:	83 c4 10             	add    $0x10,%esp
     c77:	89 02                	mov    %eax,(%edx)
     c79:	e9 5c ff ff ff       	jmp    bda <collectRange+0xca>
     c7e:	66 90                	xchg   %ax,%ax
  else *startptr = atoi(startstr);
     c80:	83 ec 0c             	sub    $0xc,%esp
     c83:	56                   	push   %esi
     c84:	e8 f7 0a 00 00       	call   1780 <atoi>
     c89:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     c8c:	83 c4 10             	add    $0x10,%esp
     c8f:	89 01                	mov    %eax,(%ecx)
     c91:	e9 22 ff ff ff       	jmp    bb8 <collectRange+0xa8>
     c96:	8d 76 00             	lea    0x0(%esi),%esi
     c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    substr(endstr, endstr, 1, strlen(endstr));
     ca0:	83 ec 0c             	sub    $0xc,%esp
    negEndFlag = 1;
     ca3:	bf 01 00 00 00       	mov    $0x1,%edi
    substr(endstr, endstr, 1, strlen(endstr));
     ca8:	53                   	push   %ebx
     ca9:	e8 72 09 00 00       	call   1620 <strlen>
     cae:	50                   	push   %eax
     caf:	6a 01                	push   $0x1
     cb1:	53                   	push   %ebx
     cb2:	53                   	push   %ebx
     cb3:	e8 68 f8 ff ff       	call   520 <substr>
     cb8:	83 c4 20             	add    $0x20,%esp
     cbb:	e9 d6 fe ff ff       	jmp    b96 <collectRange+0x86>
    substr(startstr, startstr, 1, strlen(startstr));
     cc0:	83 ec 0c             	sub    $0xc,%esp
     cc3:	56                   	push   %esi
     cc4:	e8 57 09 00 00       	call   1620 <strlen>
     cc9:	50                   	push   %eax
     cca:	6a 01                	push   $0x1
     ccc:	56                   	push   %esi
     ccd:	56                   	push   %esi
     cce:	e8 4d f8 ff ff       	call   520 <substr>
     cd3:	83 c4 20             	add    $0x20,%esp
    negStartFlag = 1;
     cd6:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
     cdd:	e9 a9 fe ff ff       	jmp    b8b <collectRange+0x7b>
     ce2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000cf0 <unline>:

void unline(char* str) {
     cf0:	55                   	push   %ebp
     cf1:	89 e5                	mov    %esp,%ebp
     cf3:	53                   	push   %ebx
     cf4:	83 ec 10             	sub    $0x10,%esp
     cf7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str) - 1;
     cfa:	53                   	push   %ebx
     cfb:	e8 20 09 00 00       	call   1620 <strlen>
     d00:	8d 50 ff             	lea    -0x1(%eax),%edx
  for (; len > 0; len--) {
     d03:	83 c4 10             	add    $0x10,%esp
     d06:	85 d2                	test   %edx,%edx
     d08:	7e 36                	jle    d40 <unline+0x50>
    char c = str[len];
    if (c == '\n')
     d0a:	80 7c 03 ff 0a       	cmpb   $0xa,-0x1(%ebx,%eax,1)
     d0f:	74 2f                	je     d40 <unline+0x50>
     d11:	8d 44 03 fe          	lea    -0x2(%ebx,%eax,1),%eax
     d15:	eb 12                	jmp    d29 <unline+0x39>
     d17:	89 f6                	mov    %esi,%esi
     d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     d20:	83 e8 01             	sub    $0x1,%eax
     d23:	80 78 01 0a          	cmpb   $0xa,0x1(%eax)
     d27:	74 06                	je     d2f <unline+0x3f>
  for (; len > 0; len--) {
     d29:	39 c3                	cmp    %eax,%ebx
     d2b:	89 c2                	mov    %eax,%edx
     d2d:	75 f1                	jne    d20 <unline+0x30>
      break;
  }
  str[len] = '\0';
     d2f:	c6 02 00             	movb   $0x0,(%edx)
}
     d32:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d35:	c9                   	leave  
     d36:	c3                   	ret    
     d37:	89 f6                	mov    %esi,%esi
     d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     d40:	01 da                	add    %ebx,%edx
  str[len] = '\0';
     d42:	c6 02 00             	movb   $0x0,(%edx)
}
     d45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d48:	c9                   	leave  
     d49:	c3                   	ret    
     d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000d50 <gatherLinesSized>:

// int* gatherLineSized(struct File* file, Terminal terminal) {
void gatherLinesSized(struct File* file, Terminal terminal) {
     d50:	55                   	push   %ebp
     d51:	89 e5                	mov    %esp,%ebp
     d53:	57                   	push   %edi
     d54:	56                   	push   %esi
     d55:	53                   	push   %ebx
     d56:	81 ec 0c 04 00 00    	sub    $0x40c,%esp
     d5c:	8b 75 0c             	mov    0xc(%ebp),%esi
     d5f:	8b 7d 08             	mov    0x8(%ebp),%edi
  while (getLine(file->fd, line)) {
    int cols = 0;
    // printf("line:\n %s\n", line + cols);
    // printf("strlen(line + cols) = %d\n", strlen(line + cols));
    for (; strlen(line + cols) > terminal.width;) {
      char piece[terminal.width + 1]; // make room for null terminator
     d62:	8d 46 10             	lea    0x10(%esi),%eax
     d65:	89 f3                	mov    %esi,%ebx
     d67:	c1 e8 04             	shr    $0x4,%eax
     d6a:	89 85 ec fb ff ff    	mov    %eax,-0x414(%ebp)
  while (getLine(file->fd, line)) {
     d70:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     d76:	83 ec 08             	sub    $0x8,%esp
     d79:	50                   	push   %eax
     d7a:	ff 77 04             	pushl  0x4(%edi)
     d7d:	e8 ae f6 ff ff       	call   430 <getLine>
     d82:	83 c4 10             	add    $0x10,%esp
     d85:	85 c0                	test   %eax,%eax
     d87:	0f 84 83 00 00 00    	je     e10 <gatherLinesSized+0xc0>
     d8d:	8d b5 00 fc ff ff    	lea    -0x400(%ebp),%esi
     d93:	eb 4b                	jmp    de0 <gatherLinesSized+0x90>
     d95:	8d 76 00             	lea    0x0(%esi),%esi
      char piece[terminal.width + 1]; // make room for null terminator
     d98:	8b 85 ec fb ff ff    	mov    -0x414(%ebp),%eax
     d9e:	8d 4b 01             	lea    0x1(%ebx),%ecx
    for (; strlen(line + cols) > terminal.width;) {
     da1:	89 a5 f4 fb ff ff    	mov    %esp,-0x40c(%ebp)
      char piece[terminal.width + 1]; // make room for null terminator
     da7:	c1 e0 04             	shl    $0x4,%eax
     daa:	29 c4                	sub    %eax,%esp
  if(n <= 0)
     dac:	85 c9                	test   %ecx,%ecx
     dae:	89 a5 f0 fb ff ff    	mov    %esp,-0x410(%ebp)
     db4:	7e 09                	jle    dbf <gatherLinesSized+0x6f>
     db6:	89 f2                	mov    %esi,%edx
     db8:	89 e0                	mov    %esp,%eax
     dba:	e8 31 f6 ff ff       	call   3f0 <safestrcpy.part.0>
      safestrcpy(piece, line + cols, terminal.width + 1); 
      append(file->lines, piece);
     dbf:	8b 47 0c             	mov    0xc(%edi),%eax
     dc2:	83 ec 04             	sub    $0x4,%esp
     dc5:	01 de                	add    %ebx,%esi
     dc7:	ff 70 08             	pushl  0x8(%eax)
     dca:	ff b5 f0 fb ff ff    	pushl  -0x410(%ebp)
     dd0:	50                   	push   %eax
     dd1:	e8 8a fa ff ff       	call   860 <insert>
      file->len++;
     dd6:	83 47 10 01          	addl   $0x1,0x10(%edi)
     dda:	8b a5 f4 fb ff ff    	mov    -0x40c(%ebp),%esp
    for (; strlen(line + cols) > terminal.width;) {
     de0:	83 ec 0c             	sub    $0xc,%esp
     de3:	56                   	push   %esi
     de4:	e8 37 08 00 00       	call   1620 <strlen>
     de9:	83 c4 10             	add    $0x10,%esp
     dec:	39 d8                	cmp    %ebx,%eax
     dee:	77 a8                	ja     d98 <gatherLinesSized+0x48>
      numSplits++;
      cols += terminal.width;
      // printf("line:\n %s\n", line + cols);
      // printf("strlen(line + cols) = %d\n", strlen(line + cols));
    }
    append(file->lines, line + cols);
     df0:	8b 47 0c             	mov    0xc(%edi),%eax
     df3:	83 ec 04             	sub    $0x4,%esp
     df6:	ff 70 08             	pushl  0x8(%eax)
     df9:	56                   	push   %esi
     dfa:	50                   	push   %eax
     dfb:	e8 60 fa ff ff       	call   860 <insert>
    file->len++;
     e00:	83 47 10 01          	addl   $0x1,0x10(%edi)
     e04:	83 c4 10             	add    $0x10,%esp
     e07:	e9 64 ff ff ff       	jmp    d70 <gatherLinesSized+0x20>
     e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  // return ;
}
     e10:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e13:	5b                   	pop    %ebx
     e14:	5e                   	pop    %esi
     e15:	5f                   	pop    %edi
     e16:	5d                   	pop    %ebp
     e17:	c3                   	ret    
     e18:	90                   	nop
     e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000e20 <lineAt>:


// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
     e20:	55                   	push   %ebp
     e21:	89 e5                	mov    %esp,%ebp
  return nodeAt(list, pos-1);
     e23:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
}
     e27:	5d                   	pop    %ebp
  return nodeAt(list, pos-1);
     e28:	e9 13 f9 ff ff       	jmp    740 <nodeAt>
     e2d:	8d 76 00             	lea    0x0(%esi),%esi

00000e30 <printl>:

void printl(int lineNum, char* line) {
     e30:	55                   	push   %ebp
     e31:	89 e5                	mov    %esp,%ebp
     e33:	83 ec 08             	sub    $0x8,%esp
     e36:	8b 45 08             	mov    0x8(%ebp),%eax
  if (lineNum < 10)
     e39:	83 f8 09             	cmp    $0x9,%eax
     e3c:	7e 3a                	jle    e78 <printl+0x48>
    fprintf(2, "%d  : %s\n", lineNum, line);
  else if (lineNum < 100)
     e3e:	83 f8 63             	cmp    $0x63,%eax
     e41:	7e 1d                	jle    e60 <printl+0x30>
    fprintf(2, "%d : %s\n", lineNum, line);
  else
    fprintf(2, "%d: %s\n", lineNum, line);
     e43:	ff 75 0c             	pushl  0xc(%ebp)
     e46:	50                   	push   %eax
     e47:	68 21 1f 00 00       	push   $0x1f21
     e4c:	6a 02                	push   $0x2
     e4e:	e8 1d 0d 00 00       	call   1b70 <fprintf>
     e53:	83 c4 10             	add    $0x10,%esp
}
     e56:	c9                   	leave  
     e57:	c3                   	ret    
     e58:	90                   	nop
     e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "%d : %s\n", lineNum, line);
     e60:	ff 75 0c             	pushl  0xc(%ebp)
     e63:	50                   	push   %eax
     e64:	68 18 1f 00 00       	push   $0x1f18
     e69:	6a 02                	push   $0x2
     e6b:	e8 00 0d 00 00       	call   1b70 <fprintf>
     e70:	83 c4 10             	add    $0x10,%esp
}
     e73:	c9                   	leave  
     e74:	c3                   	ret    
     e75:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "%d  : %s\n", lineNum, line);
     e78:	ff 75 0c             	pushl  0xc(%ebp)
     e7b:	50                   	push   %eax
     e7c:	68 0e 1f 00 00       	push   $0x1f0e
     e81:	6a 02                	push   $0x2
     e83:	e8 e8 0c 00 00       	call   1b70 <fprintf>
     e88:	83 c4 10             	add    $0x10,%esp
}
     e8b:	c9                   	leave  
     e8c:	c3                   	ret    
     e8d:	8d 76 00             	lea    0x0(%esi),%esi

00000e90 <printpad>:

// prints the string with padding of a certain character
void printpad(int pad, char padChar, char* str, int alignment, int endLine) {
     e90:	55                   	push   %ebp
     e91:	89 e5                	mov    %esp,%ebp
     e93:	57                   	push   %edi
     e94:	56                   	push   %esi
     e95:	53                   	push   %ebx
     e96:	83 ec 28             	sub    $0x28,%esp
     e99:	8b 45 0c             	mov    0xc(%ebp),%eax
     e9c:	8b 7d 10             	mov    0x10(%ebp),%edi
     e9f:	8b 5d 08             	mov    0x8(%ebp),%ebx
     ea2:	8b 75 14             	mov    0x14(%ebp),%esi
     ea5:	89 45 e0             	mov    %eax,-0x20(%ebp)
     ea8:	8b 45 18             	mov    0x18(%ebp),%eax
  int len = strlen(str);
     eab:	57                   	push   %edi
void printpad(int pad, char padChar, char* str, int alignment, int endLine) {
     eac:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int len = strlen(str);
     eaf:	e8 6c 07 00 00       	call   1620 <strlen>
  int i = pad - len;
  if (alignment == LEFT) {
     eb4:	83 c4 10             	add    $0x10,%esp
  int i = pad - len;
     eb7:	29 c3                	sub    %eax,%ebx
  if (alignment == LEFT) {
     eb9:	85 f6                	test   %esi,%esi
     ebb:	74 7b                	je     f38 <printpad+0xa8>
    printf("%s", str);
    for (; i > 0; i--)
      printf("%c", padChar);
  } else if (alignment == RIGHT) {
     ebd:	83 fe 02             	cmp    $0x2,%esi
     ec0:	74 1e                	je     ee0 <printpad+0x50>
    for (; i > 0; i--)
      printf("%c", padChar);
    printf("%s", str);
  } else if (alignment == CENTER) {
     ec2:	83 fe 01             	cmp    $0x1,%esi
     ec5:	0f 84 ad 00 00 00    	je     f78 <printpad+0xe8>
      printf("%c", padChar);
      if (i == half)
        printf("%s", str);
    }
  }
  if (endLine) {
     ecb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ece:	85 c0                	test   %eax,%eax
     ed0:	75 4c                	jne    f1e <printpad+0x8e>
    printf("\n");
  }
     ed2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ed5:	5b                   	pop    %ebx
     ed6:	5e                   	pop    %esi
     ed7:	5f                   	pop    %edi
     ed8:	5d                   	pop    %ebp
     ed9:	c3                   	ret    
     eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for (; i > 0; i--)
     ee0:	85 db                	test   %ebx,%ebx
     ee2:	7e 22                	jle    f06 <printpad+0x76>
     ee4:	0f be 75 e0          	movsbl -0x20(%ebp),%esi
     ee8:	90                   	nop
     ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printf("%c", padChar);
     ef0:	83 ec 08             	sub    $0x8,%esp
     ef3:	56                   	push   %esi
     ef4:	68 2c 1f 00 00       	push   $0x1f2c
     ef9:	e8 92 0c 00 00       	call   1b90 <printf>
    for (; i > 0; i--)
     efe:	83 c4 10             	add    $0x10,%esp
     f01:	83 eb 01             	sub    $0x1,%ebx
     f04:	75 ea                	jne    ef0 <printpad+0x60>
    printf("%s", str);
     f06:	83 ec 08             	sub    $0x8,%esp
     f09:	57                   	push   %edi
     f0a:	68 29 1f 00 00       	push   $0x1f29
     f0f:	e8 7c 0c 00 00       	call   1b90 <printf>
  if (endLine) {
     f14:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f17:	83 c4 10             	add    $0x10,%esp
     f1a:	85 c0                	test   %eax,%eax
     f1c:	74 b4                	je     ed2 <printpad+0x42>
    printf("\n");
     f1e:	c7 45 08 ea 1f 00 00 	movl   $0x1fea,0x8(%ebp)
     f25:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f28:	5b                   	pop    %ebx
     f29:	5e                   	pop    %esi
     f2a:	5f                   	pop    %edi
     f2b:	5d                   	pop    %ebp
    printf("\n");
     f2c:	e9 5f 0c 00 00       	jmp    1b90 <printf>
     f31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    printf("%s", str);
     f38:	83 ec 08             	sub    $0x8,%esp
     f3b:	57                   	push   %edi
     f3c:	68 29 1f 00 00       	push   $0x1f29
     f41:	e8 4a 0c 00 00       	call   1b90 <printf>
    for (; i > 0; i--)
     f46:	83 c4 10             	add    $0x10,%esp
     f49:	85 db                	test   %ebx,%ebx
     f4b:	0f 8e 7a ff ff ff    	jle    ecb <printpad+0x3b>
     f51:	0f be 75 e0          	movsbl -0x20(%ebp),%esi
     f55:	8d 76 00             	lea    0x0(%esi),%esi
      printf("%c", padChar);
     f58:	83 ec 08             	sub    $0x8,%esp
     f5b:	56                   	push   %esi
     f5c:	68 2c 1f 00 00       	push   $0x1f2c
     f61:	e8 2a 0c 00 00       	call   1b90 <printf>
    for (; i > 0; i--)
     f66:	83 c4 10             	add    $0x10,%esp
     f69:	83 eb 01             	sub    $0x1,%ebx
     f6c:	75 ea                	jne    f58 <printpad+0xc8>
     f6e:	e9 58 ff ff ff       	jmp    ecb <printpad+0x3b>
     f73:	90                   	nop
     f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int half = i / 2;
     f78:	89 d8                	mov    %ebx,%eax
     f7a:	c1 e8 1f             	shr    $0x1f,%eax
     f7d:	01 d8                	add    %ebx,%eax
     f7f:	d1 f8                	sar    %eax
    for (; i > 0; i--) {
     f81:	85 db                	test   %ebx,%ebx
    int half = i / 2;
     f83:	89 45 dc             	mov    %eax,-0x24(%ebp)
    for (; i > 0; i--) {
     f86:	0f 8e 3f ff ff ff    	jle    ecb <printpad+0x3b>
     f8c:	0f be 75 e0          	movsbl -0x20(%ebp),%esi
     f90:	eb 0f                	jmp    fa1 <printpad+0x111>
     f92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f98:	83 eb 01             	sub    $0x1,%ebx
     f9b:	0f 84 2a ff ff ff    	je     ecb <printpad+0x3b>
      printf("%c", padChar);
     fa1:	83 ec 08             	sub    $0x8,%esp
     fa4:	56                   	push   %esi
     fa5:	68 2c 1f 00 00       	push   $0x1f2c
     faa:	e8 e1 0b 00 00       	call   1b90 <printf>
      if (i == half)
     faf:	83 c4 10             	add    $0x10,%esp
     fb2:	39 5d dc             	cmp    %ebx,-0x24(%ebp)
     fb5:	75 e1                	jne    f98 <printpad+0x108>
        printf("%s", str);
     fb7:	83 ec 08             	sub    $0x8,%esp
     fba:	57                   	push   %edi
     fbb:	68 29 1f 00 00       	push   $0x1f29
     fc0:	e8 cb 0b 00 00       	call   1b90 <printf>
     fc5:	83 c4 10             	add    $0x10,%esp
     fc8:	eb ce                	jmp    f98 <printpad+0x108>
     fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000fd0 <end>:
void end(struct File* file, char* args) {
     fd0:	55                   	push   %ebp
     fd1:	89 e5                	mov    %esp,%ebp
     fd3:	53                   	push   %ebx
     fd4:	83 ec 08             	sub    $0x8,%esp
     fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  append(file->lines, line);
     fda:	8b 43 0c             	mov    0xc(%ebx),%eax
  file->edited = 1;
     fdd:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
     fe4:	ff 70 08             	pushl  0x8(%eax)
     fe7:	ff 75 0c             	pushl  0xc(%ebp)
     fea:	50                   	push   %eax
     feb:	e8 70 f8 ff ff       	call   860 <insert>
  file->len++;
     ff0:	83 43 10 01          	addl   $0x1,0x10(%ebx)
}
     ff4:	83 c4 10             	add    $0x10,%esp
     ff7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ffa:	c9                   	leave  
     ffb:	c3                   	ret    
     ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001000 <add>:
void add(struct File* file, char* args) {
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	57                   	push   %edi
    1004:	56                   	push   %esi
    1005:	53                   	push   %ebx
    1006:	83 ec 28             	sub    $0x28,%esp
    1009:	8b 5d 08             	mov    0x8(%ebp),%ebx
    100c:	8b 75 0c             	mov    0xc(%ebp),%esi
  file->edited = 1;
    100f:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
  if (strlen(args) < 1) {
    1016:	56                   	push   %esi
    1017:	e8 04 06 00 00       	call   1620 <strlen>
    101c:	83 c4 10             	add    $0x10,%esp
    101f:	85 c0                	test   %eax,%eax
    1021:	74 3d                	je     1060 <add+0x60>
  getArg(lineStr, args, ' ');
    1023:	8d 7d de             	lea    -0x22(%ebp),%edi
    1026:	83 ec 04             	sub    $0x4,%esp
    1029:	6a 20                	push   $0x20
    102b:	56                   	push   %esi
    102c:	57                   	push   %edi
    102d:	e8 6e fa ff ff       	call   aa0 <getArg>
  int lineNum = negatoi(lineStr);
    1032:	89 3c 24             	mov    %edi,(%esp)
    1035:	e8 86 f5 ff ff       	call   5c0 <negatoi>
  insert(file->lines, line, lineNum - 1);
    103a:	83 c4 0c             	add    $0xc,%esp
    103d:	83 e8 01             	sub    $0x1,%eax
    1040:	50                   	push   %eax
    1041:	56                   	push   %esi
    1042:	ff 73 0c             	pushl  0xc(%ebx)
    1045:	e8 16 f8 ff ff       	call   860 <insert>
  file->len++;
    104a:	83 43 10 01          	addl   $0x1,0x10(%ebx)
    104e:	83 c4 10             	add    $0x10,%esp
}
    1051:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1054:	5b                   	pop    %ebx
    1055:	5e                   	pop    %esi
    1056:	5f                   	pop    %edi
    1057:	5d                   	pop    %ebp
    1058:	c3                   	ret    
    1059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "you need to give a line number to insert before\n");
    1060:	83 ec 08             	sub    $0x8,%esp
    1063:	68 80 1d 00 00       	push   $0x1d80
    1068:	6a 02                	push   $0x2
    106a:	e8 01 0b 00 00       	call   1b70 <fprintf>
    106f:	83 c4 10             	add    $0x10,%esp
}
    1072:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1075:	5b                   	pop    %ebx
    1076:	5e                   	pop    %esi
    1077:	5f                   	pop    %edi
    1078:	5d                   	pop    %ebp
    1079:	c3                   	ret    
    107a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001080 <drop>:
void drop(struct File* file, char* args) {
    1080:	55                   	push   %ebp
    1081:	89 e5                	mov    %esp,%ebp
    1083:	57                   	push   %edi
    1084:	56                   	push   %esi
    1085:	53                   	push   %ebx
    1086:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
    1089:	ff 75 0c             	pushl  0xc(%ebp)
void drop(struct File* file, char* args) {
    108c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (strlen(args) < 1) {
    108f:	e8 8c 05 00 00       	call   1620 <strlen>
    1094:	83 c4 10             	add    $0x10,%esp
    1097:	85 c0                	test   %eax,%eax
    1099:	0f 84 09 01 00 00    	je     11a8 <drop+0x128>
  if (collectRange(args, &start, &end) == 1) {
    109f:	8d 75 e4             	lea    -0x1c(%ebp),%esi
    10a2:	8d 7d e0             	lea    -0x20(%ebp),%edi
    10a5:	83 ec 04             	sub    $0x4,%esp
    10a8:	56                   	push   %esi
    10a9:	57                   	push   %edi
    10aa:	ff 75 0c             	pushl  0xc(%ebp)
    10ad:	e8 5e fa ff ff       	call   b10 <collectRange>
    10b2:	83 c4 10             	add    $0x10,%esp
    10b5:	83 f8 01             	cmp    $0x1,%eax
    10b8:	0f 84 0a 01 00 00    	je     11c8 <drop+0x148>
  if (normalizeRange(*file, &start, &end) == 1) {
    10be:	56                   	push   %esi
    10bf:	57                   	push   %edi
    10c0:	ff 73 14             	pushl  0x14(%ebx)
    10c3:	ff 73 10             	pushl  0x10(%ebx)
    10c6:	ff 73 0c             	pushl  0xc(%ebx)
    10c9:	ff 73 08             	pushl  0x8(%ebx)
    10cc:	ff 73 04             	pushl  0x4(%ebx)
    10cf:	ff 33                	pushl  (%ebx)
    10d1:	e8 ea f8 ff ff       	call   9c0 <normalizeRange>
    10d6:	83 c4 20             	add    $0x20,%esp
    10d9:	83 f8 01             	cmp    $0x1,%eax
    10dc:	0f 84 1e 01 00 00    	je     1200 <drop+0x180>
  int numl = numLines(start, end);
    10e2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    10e5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return (end - start) + 1;
    10e8:	89 d6                	mov    %edx,%esi
    10ea:	29 c6                	sub    %eax,%esi
    10ec:	8d 7e 01             	lea    0x1(%esi),%edi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
    10ef:	83 ff 01             	cmp    $0x1,%edi
    10f2:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    10f5:	0f 84 ed 00 00 00    	je     11e8 <drop+0x168>
  else fprintf(2, "Drop %d lines [%d:%d] (y/n)? ", numl, start, end);
    10fb:	83 ec 0c             	sub    $0xc,%esp
    10fe:	52                   	push   %edx
    10ff:	50                   	push   %eax
    1100:	ff 75 d4             	pushl  -0x2c(%ebp)
    1103:	68 44 1f 00 00       	push   $0x1f44
    1108:	6a 02                	push   $0x2
    110a:	e8 61 0a 00 00       	call   1b70 <fprintf>
    110f:	83 c4 20             	add    $0x20,%esp
  if (confirmation() != 0) return;
    1112:	e8 49 f8 ff ff       	call   960 <confirmation>
    1117:	85 c0                	test   %eax,%eax
    1119:	75 7f                	jne    119a <drop+0x11a>
  return nodeAt(list, pos-1);
    111b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  struct Node* curNode = (lineAt(file->lines, start))->prev;
    111e:	8b 4b 0c             	mov    0xc(%ebx),%ecx
    1121:	83 ec 08             	sub    $0x8,%esp
  file->edited = 1;
    1124:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
    112b:	83 e8 01             	sub    $0x1,%eax
    112e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    1131:	50                   	push   %eax
    1132:	51                   	push   %ecx
    1133:	e8 08 f6 ff ff       	call   740 <nodeAt>
  struct Node* curNode = (lineAt(file->lines, start))->prev;
    1138:	8b 30                	mov    (%eax),%esi
    113a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    113d:	5a                   	pop    %edx
    113e:	59                   	pop    %ecx
    113f:	8b 4d d0             	mov    -0x30(%ebp),%ecx
    1142:	83 e8 01             	sub    $0x1,%eax
    1145:	50                   	push   %eax
    1146:	51                   	push   %ecx
    1147:	e8 f4 f5 ff ff       	call   740 <nodeAt>
    114c:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
    114f:	39 c6                	cmp    %eax,%esi
    1151:	89 c7                	mov    %eax,%edi
    1153:	8b 4d d0             	mov    -0x30(%ebp),%ecx
    1156:	75 0b                	jne    1163 <drop+0xe3>
    1158:	eb 21                	jmp    117b <drop+0xfb>
    115a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1160:	8b 4b 0c             	mov    0xc(%ebx),%ecx
    curNode = curNode->next;
    1163:	8b 76 08             	mov    0x8(%esi),%esi
    destroyNode(file->lines, curNode);
    1166:	83 ec 08             	sub    $0x8,%esp
    1169:	56                   	push   %esi
    116a:	51                   	push   %ecx
    116b:	e8 40 f6 ff ff       	call   7b0 <destroyNode>
    file->len--;
    1170:	83 6b 10 01          	subl   $0x1,0x10(%ebx)
  while (curNode != stopNode) {
    1174:	83 c4 10             	add    $0x10,%esp
    1177:	39 f7                	cmp    %esi,%edi
    1179:	75 e5                	jne    1160 <drop+0xe0>
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
    117b:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
    117f:	0f 84 93 00 00 00    	je     1218 <drop+0x198>
  else fprintf(2, "%d lines dropped\n", numl);
    1185:	83 ec 04             	sub    $0x4,%esp
    1188:	ff 75 d4             	pushl  -0x2c(%ebp)
    118b:	68 73 1f 00 00       	push   $0x1f73
    1190:	6a 02                	push   $0x2
    1192:	e8 d9 09 00 00       	call   1b70 <fprintf>
    1197:	83 c4 10             	add    $0x10,%esp
}
    119a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    119d:	5b                   	pop    %ebx
    119e:	5e                   	pop    %esi
    119f:	5f                   	pop    %edi
    11a0:	5d                   	pop    %ebp
    11a1:	c3                   	ret    
    11a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "you need to give a range to drop\n");
    11a8:	83 ec 08             	sub    $0x8,%esp
    11ab:	68 b4 1d 00 00       	push   $0x1db4
    11b0:	6a 02                	push   $0x2
    11b2:	e8 b9 09 00 00       	call   1b70 <fprintf>
    return;
    11b7:	83 c4 10             	add    $0x10,%esp
}
    11ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11bd:	5b                   	pop    %ebx
    11be:	5e                   	pop    %esi
    11bf:	5f                   	pop    %edi
    11c0:	5d                   	pop    %ebp
    11c1:	c3                   	ret    
    11c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: start index is larger than end index\n");
    11c8:	83 ec 08             	sub    $0x8,%esp
    11cb:	68 d8 1d 00 00       	push   $0x1dd8
    11d0:	6a 02                	push   $0x2
    11d2:	e8 99 09 00 00       	call   1b70 <fprintf>
    11d7:	83 c4 10             	add    $0x10,%esp
}
    11da:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11dd:	5b                   	pop    %ebx
    11de:	5e                   	pop    %esi
    11df:	5f                   	pop    %edi
    11e0:	5d                   	pop    %ebp
    11e1:	c3                   	ret    
    11e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
    11e8:	83 ec 04             	sub    $0x4,%esp
    11eb:	50                   	push   %eax
    11ec:	68 2f 1f 00 00       	push   $0x1f2f
    11f1:	6a 02                	push   $0x2
    11f3:	e8 78 09 00 00       	call   1b70 <fprintf>
    11f8:	83 c4 10             	add    $0x10,%esp
    11fb:	e9 12 ff ff ff       	jmp    1112 <drop+0x92>
    fprintf(2, "error: bad input range. make sure start < end\n");
    1200:	83 ec 08             	sub    $0x8,%esp
    1203:	68 08 1e 00 00       	push   $0x1e08
    1208:	6a 02                	push   $0x2
    120a:	e8 61 09 00 00       	call   1b70 <fprintf>
    120f:	83 c4 10             	add    $0x10,%esp
    1212:	eb 86                	jmp    119a <drop+0x11a>
    1214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
    1218:	83 ec 04             	sub    $0x4,%esp
    121b:	ff 75 e0             	pushl  -0x20(%ebp)
    121e:	68 62 1f 00 00       	push   $0x1f62
    1223:	6a 02                	push   $0x2
    1225:	e8 46 09 00 00       	call   1b70 <fprintf>
    122a:	83 c4 10             	add    $0x10,%esp
    122d:	e9 68 ff ff ff       	jmp    119a <drop+0x11a>
    1232:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001240 <edit>:
void edit(struct File* file, char* args) {
    1240:	55                   	push   %ebp
    1241:	89 e5                	mov    %esp,%ebp
    1243:	57                   	push   %edi
    1244:	56                   	push   %esi
    1245:	53                   	push   %ebx
    1246:	83 ec 28             	sub    $0x28,%esp
    1249:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if (strlen(args) < 1) {
    124c:	53                   	push   %ebx
    124d:	e8 ce 03 00 00       	call   1620 <strlen>
    1252:	83 c4 10             	add    $0x10,%esp
    1255:	85 c0                	test   %eax,%eax
    1257:	75 1f                	jne    1278 <edit+0x38>
    fprintf(2, "you need to give a line number to replace\n");
    1259:	83 ec 08             	sub    $0x8,%esp
    125c:	68 38 1e 00 00       	push   $0x1e38
    1261:	6a 02                	push   $0x2
    1263:	e8 08 09 00 00       	call   1b70 <fprintf>
    return;
    1268:	83 c4 10             	add    $0x10,%esp
}
    126b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    126e:	5b                   	pop    %ebx
    126f:	5e                   	pop    %esi
    1270:	5f                   	pop    %edi
    1271:	5d                   	pop    %ebp
    1272:	c3                   	ret    
    1273:	90                   	nop
    1274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  getArg(lineStr, args, ' ');
    1278:	8d 75 de             	lea    -0x22(%ebp),%esi
    127b:	83 ec 04             	sub    $0x4,%esp
    127e:	6a 20                	push   $0x20
    1280:	53                   	push   %ebx
    1281:	56                   	push   %esi
    1282:	e8 19 f8 ff ff       	call   aa0 <getArg>
  int lineNum = negatoi(lineStr);
    1287:	89 34 24             	mov    %esi,(%esp)
    128a:	e8 31 f3 ff ff       	call   5c0 <negatoi>
  fprintf(2, "replace line %d (y/n)? ", lineNum);
    128f:	83 c4 0c             	add    $0xc,%esp
  int lineNum = negatoi(lineStr);
    1292:	89 c6                	mov    %eax,%esi
  fprintf(2, "replace line %d (y/n)? ", lineNum);
    1294:	50                   	push   %eax
    1295:	68 85 1f 00 00       	push   $0x1f85
    129a:	6a 02                	push   $0x2
    129c:	e8 cf 08 00 00       	call   1b70 <fprintf>
  if (confirmation() != 0) return;
    12a1:	e8 ba f6 ff ff       	call   960 <confirmation>
    12a6:	83 c4 10             	add    $0x10,%esp
    12a9:	85 c0                	test   %eax,%eax
    12ab:	75 be                	jne    126b <edit+0x2b>
  file->edited = 1;
    12ad:	8b 45 08             	mov    0x8(%ebp),%eax
    12b0:	83 ec 08             	sub    $0x8,%esp
    12b3:	83 ee 01             	sub    $0x1,%esi
  destroyNode(file->lines, lineAt(file->lines, lineNum));
    12b6:	8b 78 0c             	mov    0xc(%eax),%edi
  file->edited = 1;
    12b9:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    12c0:	56                   	push   %esi
    12c1:	57                   	push   %edi
    12c2:	e8 79 f4 ff ff       	call   740 <nodeAt>
    12c7:	5a                   	pop    %edx
    12c8:	59                   	pop    %ecx
  destroyNode(file->lines, lineAt(file->lines, lineNum));
    12c9:	50                   	push   %eax
    12ca:	57                   	push   %edi
    12cb:	e8 e0 f4 ff ff       	call   7b0 <destroyNode>
  insert(file->lines, line, lineNum - 1);
    12d0:	8b 45 08             	mov    0x8(%ebp),%eax
    12d3:	83 c4 0c             	add    $0xc,%esp
    12d6:	56                   	push   %esi
    12d7:	53                   	push   %ebx
    12d8:	ff 70 0c             	pushl  0xc(%eax)
    12db:	e8 80 f5 ff ff       	call   860 <insert>
    12e0:	83 c4 10             	add    $0x10,%esp
}
    12e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12e6:	5b                   	pop    %ebx
    12e7:	5e                   	pop    %esi
    12e8:	5f                   	pop    %edi
    12e9:	5d                   	pop    %ebp
    12ea:	c3                   	ret    
    12eb:	90                   	nop
    12ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000012f0 <list>:
void list(struct File file, char* args) {
    12f0:	55                   	push   %ebp
    12f1:	89 e5                	mov    %esp,%ebp
    12f3:	57                   	push   %edi
    12f4:	56                   	push   %esi
    12f5:	53                   	push   %ebx
    12f6:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
    12f9:	ff 75 20             	pushl  0x20(%ebp)
    12fc:	8b 75 14             	mov    0x14(%ebp),%esi
    12ff:	e8 1c 03 00 00       	call   1620 <strlen>
    1304:	83 c4 10             	add    $0x10,%esp
    1307:	85 c0                	test   %eax,%eax
    1309:	75 1d                	jne    1328 <list+0x38>
    fprintf(2, "you need to give a range to list\n");
    130b:	83 ec 08             	sub    $0x8,%esp
    130e:	68 64 1e 00 00       	push   $0x1e64
    1313:	6a 02                	push   $0x2
    1315:	e8 56 08 00 00       	call   1b70 <fprintf>
    return;
    131a:	83 c4 10             	add    $0x10,%esp
}
    131d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1320:	5b                   	pop    %ebx
    1321:	5e                   	pop    %esi
    1322:	5f                   	pop    %edi
    1323:	5d                   	pop    %ebp
    1324:	c3                   	ret    
    1325:	8d 76 00             	lea    0x0(%esi),%esi
  if (collectRange(args, &start, &end) == 1) {
    1328:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
    132b:	8d 7d e0             	lea    -0x20(%ebp),%edi
    132e:	83 ec 04             	sub    $0x4,%esp
    1331:	53                   	push   %ebx
    1332:	57                   	push   %edi
    1333:	ff 75 20             	pushl  0x20(%ebp)
    1336:	e8 d5 f7 ff ff       	call   b10 <collectRange>
    133b:	83 c4 10             	add    $0x10,%esp
    133e:	83 f8 01             	cmp    $0x1,%eax
    1341:	0f 84 91 00 00 00    	je     13d8 <list+0xe8>
  if (normalizeRange(file, &start, &end) == 1) {
    1347:	53                   	push   %ebx
    1348:	57                   	push   %edi
    1349:	ff 75 1c             	pushl  0x1c(%ebp)
    134c:	ff 75 18             	pushl  0x18(%ebp)
    134f:	ff 75 14             	pushl  0x14(%ebp)
    1352:	ff 75 10             	pushl  0x10(%ebp)
    1355:	ff 75 0c             	pushl  0xc(%ebp)
    1358:	ff 75 08             	pushl  0x8(%ebp)
    135b:	e8 60 f6 ff ff       	call   9c0 <normalizeRange>
    1360:	83 c4 20             	add    $0x20,%esp
    1363:	83 f8 01             	cmp    $0x1,%eax
    1366:	0f 84 8c 00 00 00    	je     13f8 <list+0x108>
  lineNum = start - 1;
    136c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    136f:	83 ec 08             	sub    $0x8,%esp
    1372:	8d 78 ff             	lea    -0x1(%eax),%edi
    1375:	57                   	push   %edi
    1376:	56                   	push   %esi
    1377:	e8 c4 f3 ff ff       	call   740 <nodeAt>
  struct Node* curNode = (lineAt(file.lines, start))->prev;
    137c:	8b 18                	mov    (%eax),%ebx
    137e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1381:	5a                   	pop    %edx
    1382:	59                   	pop    %ecx
    1383:	83 e8 01             	sub    $0x1,%eax
    1386:	50                   	push   %eax
    1387:	56                   	push   %esi
    1388:	e8 b3 f3 ff ff       	call   740 <nodeAt>
    138d:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
    1390:	39 d8                	cmp    %ebx,%eax
    1392:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1395:	74 86                	je     131d <list+0x2d>
    curNode = curNode->next;
    1397:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
    139a:	3b 5e 04             	cmp    0x4(%esi),%ebx
    139d:	75 15                	jne    13b4 <list+0xc4>
    139f:	e9 79 ff ff ff       	jmp    131d <list+0x2d>
    13a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
    13a8:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
    13ab:	39 5e 04             	cmp    %ebx,0x4(%esi)
    13ae:	0f 84 69 ff ff ff    	je     131d <list+0x2d>
    printl(++lineNum, curNode->data);
    13b4:	83 ec 08             	sub    $0x8,%esp
    13b7:	83 c7 01             	add    $0x1,%edi
    13ba:	ff 73 04             	pushl  0x4(%ebx)
    13bd:	57                   	push   %edi
    13be:	e8 6d fa ff ff       	call   e30 <printl>
  while (curNode != stopNode) {
    13c3:	83 c4 10             	add    $0x10,%esp
    13c6:	39 5d d4             	cmp    %ebx,-0x2c(%ebp)
    13c9:	75 dd                	jne    13a8 <list+0xb8>
}
    13cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    13ce:	5b                   	pop    %ebx
    13cf:	5e                   	pop    %esi
    13d0:	5f                   	pop    %edi
    13d1:	5d                   	pop    %ebp
    13d2:	c3                   	ret    
    13d3:	90                   	nop
    13d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "error: start index is larger than end index\n");
    13d8:	83 ec 08             	sub    $0x8,%esp
    13db:	68 d8 1d 00 00       	push   $0x1dd8
    13e0:	6a 02                	push   $0x2
    13e2:	e8 89 07 00 00       	call   1b70 <fprintf>
    return;
    13e7:	83 c4 10             	add    $0x10,%esp
}
    13ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
    13ed:	5b                   	pop    %ebx
    13ee:	5e                   	pop    %esi
    13ef:	5f                   	pop    %edi
    13f0:	5d                   	pop    %ebp
    13f1:	c3                   	ret    
    13f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: bad input range. make sure start < end\n");
    13f8:	83 ec 08             	sub    $0x8,%esp
    13fb:	68 08 1e 00 00       	push   $0x1e08
    1400:	6a 02                	push   $0x2
    1402:	e8 69 07 00 00       	call   1b70 <fprintf>
    return;
    1407:	83 c4 10             	add    $0x10,%esp
    140a:	e9 0e ff ff ff       	jmp    131d <list+0x2d>
    140f:	90                   	nop

00001410 <show>:
void show(struct File file, char* args) {
    1410:	55                   	push   %ebp
    1411:	89 e5                	mov    %esp,%ebp
    1413:	57                   	push   %edi
    1414:	56                   	push   %esi
    1415:	53                   	push   %ebx
    1416:	83 ec 0c             	sub    $0xc,%esp
    1419:	8b 7d 14             	mov    0x14(%ebp),%edi
  struct Node* cur = file.lines->head->next;
    141c:	8b 07                	mov    (%edi),%eax
    141e:	8b 58 08             	mov    0x8(%eax),%ebx
  while (cur != file.lines->tail) {
    1421:	3b 5f 04             	cmp    0x4(%edi),%ebx
    1424:	74 24                	je     144a <show+0x3a>
  int lineNum = 1;
    1426:	be 01 00 00 00       	mov    $0x1,%esi
    142b:	90                   	nop
    142c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printl(lineNum, cur->data);
    1430:	83 ec 08             	sub    $0x8,%esp
    1433:	ff 73 04             	pushl  0x4(%ebx)
    1436:	56                   	push   %esi
    lineNum++;
    1437:	83 c6 01             	add    $0x1,%esi
    printl(lineNum, cur->data);
    143a:	e8 f1 f9 ff ff       	call   e30 <printl>
    cur = cur->next;
    143f:	8b 5b 08             	mov    0x8(%ebx),%ebx
  while (cur != file.lines->tail) {
    1442:	83 c4 10             	add    $0x10,%esp
    1445:	39 5f 04             	cmp    %ebx,0x4(%edi)
    1448:	75 e6                	jne    1430 <show+0x20>
}
    144a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    144d:	5b                   	pop    %ebx
    144e:	5e                   	pop    %esi
    144f:	5f                   	pop    %edi
    1450:	5d                   	pop    %ebp
    1451:	c3                   	ret    
    1452:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001460 <quit>:
void quit(struct File* file) {
    1460:	55                   	push   %ebp
    1461:	89 e5                	mov    %esp,%ebp
    1463:	56                   	push   %esi
    1464:	53                   	push   %ebx
    1465:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (file->edited == 0) return;
    1468:	8b 4b 14             	mov    0x14(%ebx),%ecx
    146b:	85 c9                	test   %ecx,%ecx
    146d:	75 11                	jne    1480 <quit+0x20>
}
    146f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1472:	5b                   	pop    %ebx
    1473:	5e                   	pop    %esi
    1474:	5d                   	pop    %ebp
    1475:	c3                   	ret    
    1476:	8d 76 00             	lea    0x0(%esi),%esi
    1479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  fprintf(2, "save changes (y/n)? ");
    1480:	83 ec 08             	sub    $0x8,%esp
    1483:	68 9d 1f 00 00       	push   $0x1f9d
    1488:	6a 02                	push   $0x2
    148a:	e8 e1 06 00 00       	call   1b70 <fprintf>
  if (confirmation() != 0) return;
    148f:	e8 cc f4 ff ff       	call   960 <confirmation>
    1494:	83 c4 10             	add    $0x10,%esp
    1497:	85 c0                	test   %eax,%eax
    1499:	75 d4                	jne    146f <quit+0xf>
  if (unlink(file->filename) < 0) {
    149b:	83 ec 0c             	sub    $0xc,%esp
    149e:	ff 33                	pushl  (%ebx)
    14a0:	e8 a5 03 00 00       	call   184a <unlink>
    14a5:	83 c4 10             	add    $0x10,%esp
    14a8:	85 c0                	test   %eax,%eax
    14aa:	0f 88 90 00 00 00    	js     1540 <quit+0xe0>
  file->fd = open(file->filename, O_CREATE|O_RDWR);
    14b0:	83 ec 08             	sub    $0x8,%esp
    14b3:	68 02 02 00 00       	push   $0x202
    14b8:	ff 33                	pushl  (%ebx)
    14ba:	e8 7b 03 00 00       	call   183a <open>
  if (file->fd < 0) {
    14bf:	83 c4 10             	add    $0x10,%esp
    14c2:	85 c0                	test   %eax,%eax
  file->fd = open(file->filename, O_CREATE|O_RDWR);
    14c4:	89 43 04             	mov    %eax,0x4(%ebx)
  if (file->fd < 0) {
    14c7:	0f 88 93 00 00 00    	js     1560 <quit+0x100>
  struct Node* cur = file->lines->head->next;
    14cd:	8b 53 0c             	mov    0xc(%ebx),%edx
    14d0:	8b 0a                	mov    (%edx),%ecx
    14d2:	8b 71 08             	mov    0x8(%ecx),%esi
  while (cur != file->lines->tail) {
    14d5:	3b 72 04             	cmp    0x4(%edx),%esi
    14d8:	74 43                	je     151d <quit+0xbd>
    14da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    write(file->fd, cur->data, strlen(cur->data));
    14e0:	83 ec 0c             	sub    $0xc,%esp
    14e3:	ff 76 04             	pushl  0x4(%esi)
    14e6:	e8 35 01 00 00       	call   1620 <strlen>
    14eb:	83 c4 0c             	add    $0xc,%esp
    14ee:	50                   	push   %eax
    14ef:	ff 76 04             	pushl  0x4(%esi)
    14f2:	ff 73 04             	pushl  0x4(%ebx)
    14f5:	e8 20 03 00 00       	call   181a <write>
    write(file->fd, "\n", sizeof(char));
    14fa:	83 c4 0c             	add    $0xc,%esp
    14fd:	6a 01                	push   $0x1
    14ff:	68 ea 1f 00 00       	push   $0x1fea
    1504:	ff 73 04             	pushl  0x4(%ebx)
    1507:	e8 0e 03 00 00       	call   181a <write>
  while (cur != file->lines->tail) {
    150c:	8b 43 0c             	mov    0xc(%ebx),%eax
    cur = cur->next;
    150f:	8b 76 08             	mov    0x8(%esi),%esi
  while (cur != file->lines->tail) {
    1512:	83 c4 10             	add    $0x10,%esp
    1515:	3b 70 04             	cmp    0x4(%eax),%esi
    1518:	75 c6                	jne    14e0 <quit+0x80>
    151a:	8b 43 04             	mov    0x4(%ebx),%eax
  close(file->fd);
    151d:	83 ec 0c             	sub    $0xc,%esp
    1520:	50                   	push   %eax
    1521:	e8 fc 02 00 00       	call   1822 <close>
  fprintf(2, "changes saved\n");
    1526:	58                   	pop    %eax
    1527:	5a                   	pop    %edx
    1528:	68 b2 1f 00 00       	push   $0x1fb2
    152d:	6a 02                	push   $0x2
    152f:	e8 3c 06 00 00       	call   1b70 <fprintf>
    1534:	83 c4 10             	add    $0x10,%esp
    1537:	e9 33 ff ff ff       	jmp    146f <quit+0xf>
    153c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "could not clear file for writing. changes lost\n");
    1540:	83 ec 08             	sub    $0x8,%esp
    1543:	68 88 1e 00 00       	push   $0x1e88
    1548:	6a 02                	push   $0x2
    154a:	e8 21 06 00 00       	call   1b70 <fprintf>
    return;
    154f:	83 c4 10             	add    $0x10,%esp
    1552:	e9 18 ff ff ff       	jmp    146f <quit+0xf>
    1557:	89 f6                	mov    %esi,%esi
    1559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    fprintf(2, "could not open file for writing. changes lost\n");
    1560:	83 ec 08             	sub    $0x8,%esp
    1563:	68 b8 1e 00 00       	push   $0x1eb8
    1568:	6a 02                	push   $0x2
    156a:	e8 01 06 00 00       	call   1b70 <fprintf>
    return;
    156f:	83 c4 10             	add    $0x10,%esp
    1572:	e9 f8 fe ff ff       	jmp    146f <quit+0xf>
    1577:	89 f6                	mov    %esi,%esi
    1579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001580 <bi>:
void bi() {
    1580:	55                   	push   %ebp
    1581:	89 e5                	mov    %esp,%ebp
    1583:	83 ec 10             	sub    $0x10,%esp
  fprintf(2, "bad input\n");
    1586:	68 3f 20 00 00       	push   $0x203f
    158b:	6a 02                	push   $0x2
    158d:	e8 de 05 00 00       	call   1b70 <fprintf>
}
    1592:	83 c4 10             	add    $0x10,%esp
    1595:	c9                   	leave  
    1596:	c3                   	ret    
    1597:	66 90                	xchg   %ax,%ax
    1599:	66 90                	xchg   %ax,%ax
    159b:	66 90                	xchg   %ax,%ax
    159d:	66 90                	xchg   %ax,%ax
    159f:	90                   	nop

000015a0 <strcpy>:
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
    15a0:	55                   	push   %ebp
    15a1:	89 e5                	mov    %esp,%ebp
    15a3:	53                   	push   %ebx
    15a4:	8b 45 08             	mov    0x8(%ebp),%eax
    15a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    15aa:	89 c2                	mov    %eax,%edx
    15ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    15b0:	83 c1 01             	add    $0x1,%ecx
    15b3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    15b7:	83 c2 01             	add    $0x1,%edx
    15ba:	84 db                	test   %bl,%bl
    15bc:	88 5a ff             	mov    %bl,-0x1(%edx)
    15bf:	75 ef                	jne    15b0 <strcpy+0x10>
    ;
  return os;
}
    15c1:	5b                   	pop    %ebx
    15c2:	5d                   	pop    %ebp
    15c3:	c3                   	ret    
    15c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    15ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000015d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    15d0:	55                   	push   %ebp
    15d1:	89 e5                	mov    %esp,%ebp
    15d3:	53                   	push   %ebx
    15d4:	8b 55 08             	mov    0x8(%ebp),%edx
    15d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    15da:	0f b6 02             	movzbl (%edx),%eax
    15dd:	0f b6 19             	movzbl (%ecx),%ebx
    15e0:	84 c0                	test   %al,%al
    15e2:	75 1c                	jne    1600 <strcmp+0x30>
    15e4:	eb 2a                	jmp    1610 <strcmp+0x40>
    15e6:	8d 76 00             	lea    0x0(%esi),%esi
    15e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    15f0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    15f3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    15f6:	83 c1 01             	add    $0x1,%ecx
    15f9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    15fc:	84 c0                	test   %al,%al
    15fe:	74 10                	je     1610 <strcmp+0x40>
    1600:	38 d8                	cmp    %bl,%al
    1602:	74 ec                	je     15f0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    1604:	29 d8                	sub    %ebx,%eax
}
    1606:	5b                   	pop    %ebx
    1607:	5d                   	pop    %ebp
    1608:	c3                   	ret    
    1609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1610:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    1612:	29 d8                	sub    %ebx,%eax
}
    1614:	5b                   	pop    %ebx
    1615:	5d                   	pop    %ebp
    1616:	c3                   	ret    
    1617:	89 f6                	mov    %esi,%esi
    1619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001620 <strlen>:

uint
strlen(const char *s)
{
    1620:	55                   	push   %ebp
    1621:	89 e5                	mov    %esp,%ebp
    1623:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1626:	80 39 00             	cmpb   $0x0,(%ecx)
    1629:	74 15                	je     1640 <strlen+0x20>
    162b:	31 d2                	xor    %edx,%edx
    162d:	8d 76 00             	lea    0x0(%esi),%esi
    1630:	83 c2 01             	add    $0x1,%edx
    1633:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1637:	89 d0                	mov    %edx,%eax
    1639:	75 f5                	jne    1630 <strlen+0x10>
    ;
  return n;
}
    163b:	5d                   	pop    %ebp
    163c:	c3                   	ret    
    163d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    1640:	31 c0                	xor    %eax,%eax
}
    1642:	5d                   	pop    %ebp
    1643:	c3                   	ret    
    1644:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    164a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001650 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1650:	55                   	push   %ebp
    1651:	89 e5                	mov    %esp,%ebp
    1653:	57                   	push   %edi
    1654:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1657:	8b 4d 10             	mov    0x10(%ebp),%ecx
    165a:	8b 45 0c             	mov    0xc(%ebp),%eax
    165d:	89 d7                	mov    %edx,%edi
    165f:	fc                   	cld    
    1660:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1662:	89 d0                	mov    %edx,%eax
    1664:	5f                   	pop    %edi
    1665:	5d                   	pop    %ebp
    1666:	c3                   	ret    
    1667:	89 f6                	mov    %esi,%esi
    1669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001670 <strchr>:

char*
strchr(const char *s, char c)
{
    1670:	55                   	push   %ebp
    1671:	89 e5                	mov    %esp,%ebp
    1673:	53                   	push   %ebx
    1674:	8b 45 08             	mov    0x8(%ebp),%eax
    1677:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    167a:	0f b6 10             	movzbl (%eax),%edx
    167d:	84 d2                	test   %dl,%dl
    167f:	74 1d                	je     169e <strchr+0x2e>
    if(*s == c)
    1681:	38 d3                	cmp    %dl,%bl
    1683:	89 d9                	mov    %ebx,%ecx
    1685:	75 0d                	jne    1694 <strchr+0x24>
    1687:	eb 17                	jmp    16a0 <strchr+0x30>
    1689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1690:	38 ca                	cmp    %cl,%dl
    1692:	74 0c                	je     16a0 <strchr+0x30>
  for(; *s; s++)
    1694:	83 c0 01             	add    $0x1,%eax
    1697:	0f b6 10             	movzbl (%eax),%edx
    169a:	84 d2                	test   %dl,%dl
    169c:	75 f2                	jne    1690 <strchr+0x20>
      return (char*)s;
  return 0;
    169e:	31 c0                	xor    %eax,%eax
}
    16a0:	5b                   	pop    %ebx
    16a1:	5d                   	pop    %ebp
    16a2:	c3                   	ret    
    16a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    16a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000016b0 <gets>:

char*
gets(char *buf, int max)
{
    16b0:	55                   	push   %ebp
    16b1:	89 e5                	mov    %esp,%ebp
    16b3:	57                   	push   %edi
    16b4:	56                   	push   %esi
    16b5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    16b6:	31 f6                	xor    %esi,%esi
    16b8:	89 f3                	mov    %esi,%ebx
{
    16ba:	83 ec 1c             	sub    $0x1c,%esp
    16bd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    16c0:	eb 2f                	jmp    16f1 <gets+0x41>
    16c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    16c8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    16cb:	83 ec 04             	sub    $0x4,%esp
    16ce:	6a 01                	push   $0x1
    16d0:	50                   	push   %eax
    16d1:	6a 00                	push   $0x0
    16d3:	e8 32 01 00 00       	call   180a <read>
    if(cc < 1)
    16d8:	83 c4 10             	add    $0x10,%esp
    16db:	85 c0                	test   %eax,%eax
    16dd:	7e 1c                	jle    16fb <gets+0x4b>
      break;
    buf[i++] = c;
    16df:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    16e3:	83 c7 01             	add    $0x1,%edi
    16e6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    16e9:	3c 0a                	cmp    $0xa,%al
    16eb:	74 23                	je     1710 <gets+0x60>
    16ed:	3c 0d                	cmp    $0xd,%al
    16ef:	74 1f                	je     1710 <gets+0x60>
  for(i=0; i+1 < max; ){
    16f1:	83 c3 01             	add    $0x1,%ebx
    16f4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    16f7:	89 fe                	mov    %edi,%esi
    16f9:	7c cd                	jl     16c8 <gets+0x18>
    16fb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    16fd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1700:	c6 03 00             	movb   $0x0,(%ebx)
}
    1703:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1706:	5b                   	pop    %ebx
    1707:	5e                   	pop    %esi
    1708:	5f                   	pop    %edi
    1709:	5d                   	pop    %ebp
    170a:	c3                   	ret    
    170b:	90                   	nop
    170c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1710:	8b 75 08             	mov    0x8(%ebp),%esi
    1713:	8b 45 08             	mov    0x8(%ebp),%eax
    1716:	01 de                	add    %ebx,%esi
    1718:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    171a:	c6 03 00             	movb   $0x0,(%ebx)
}
    171d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1720:	5b                   	pop    %ebx
    1721:	5e                   	pop    %esi
    1722:	5f                   	pop    %edi
    1723:	5d                   	pop    %ebp
    1724:	c3                   	ret    
    1725:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001730 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
    1730:	55                   	push   %ebp
    1731:	89 e5                	mov    %esp,%ebp
    1733:	56                   	push   %esi
    1734:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1735:	83 ec 08             	sub    $0x8,%esp
    1738:	6a 00                	push   $0x0
    173a:	ff 75 08             	pushl  0x8(%ebp)
    173d:	e8 f8 00 00 00       	call   183a <open>
  if(fd < 0)
    1742:	83 c4 10             	add    $0x10,%esp
    1745:	85 c0                	test   %eax,%eax
    1747:	78 27                	js     1770 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1749:	83 ec 08             	sub    $0x8,%esp
    174c:	ff 75 0c             	pushl  0xc(%ebp)
    174f:	89 c3                	mov    %eax,%ebx
    1751:	50                   	push   %eax
    1752:	e8 fb 00 00 00       	call   1852 <fstat>
  close(fd);
    1757:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    175a:	89 c6                	mov    %eax,%esi
  close(fd);
    175c:	e8 c1 00 00 00       	call   1822 <close>
  return r;
    1761:	83 c4 10             	add    $0x10,%esp
}
    1764:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1767:	89 f0                	mov    %esi,%eax
    1769:	5b                   	pop    %ebx
    176a:	5e                   	pop    %esi
    176b:	5d                   	pop    %ebp
    176c:	c3                   	ret    
    176d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1770:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1775:	eb ed                	jmp    1764 <stat+0x34>
    1777:	89 f6                	mov    %esi,%esi
    1779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001780 <atoi>:

int
atoi(const char *s)
{
    1780:	55                   	push   %ebp
    1781:	89 e5                	mov    %esp,%ebp
    1783:	53                   	push   %ebx
    1784:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1787:	0f be 11             	movsbl (%ecx),%edx
    178a:	8d 42 d0             	lea    -0x30(%edx),%eax
    178d:	3c 09                	cmp    $0x9,%al
  n = 0;
    178f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    1794:	77 1f                	ja     17b5 <atoi+0x35>
    1796:	8d 76 00             	lea    0x0(%esi),%esi
    1799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    17a0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    17a3:	83 c1 01             	add    $0x1,%ecx
    17a6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    17aa:	0f be 11             	movsbl (%ecx),%edx
    17ad:	8d 5a d0             	lea    -0x30(%edx),%ebx
    17b0:	80 fb 09             	cmp    $0x9,%bl
    17b3:	76 eb                	jbe    17a0 <atoi+0x20>
  return n;
}
    17b5:	5b                   	pop    %ebx
    17b6:	5d                   	pop    %ebp
    17b7:	c3                   	ret    
    17b8:	90                   	nop
    17b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000017c0 <memmove>:


void*
memmove(void *vdst, const void *vsrc, int n)
{
    17c0:	55                   	push   %ebp
    17c1:	89 e5                	mov    %esp,%ebp
    17c3:	56                   	push   %esi
    17c4:	53                   	push   %ebx
    17c5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    17c8:	8b 45 08             	mov    0x8(%ebp),%eax
    17cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    17ce:	85 db                	test   %ebx,%ebx
    17d0:	7e 14                	jle    17e6 <memmove+0x26>
    17d2:	31 d2                	xor    %edx,%edx
    17d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    17d8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    17dc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    17df:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    17e2:	39 d3                	cmp    %edx,%ebx
    17e4:	75 f2                	jne    17d8 <memmove+0x18>
  return vdst;
}
    17e6:	5b                   	pop    %ebx
    17e7:	5e                   	pop    %esi
    17e8:	5d                   	pop    %ebp
    17e9:	c3                   	ret    

000017ea <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    17ea:	b8 01 00 00 00       	mov    $0x1,%eax
    17ef:	cd 40                	int    $0x40
    17f1:	c3                   	ret    

000017f2 <exit>:
SYSCALL(exit)
    17f2:	b8 02 00 00 00       	mov    $0x2,%eax
    17f7:	cd 40                	int    $0x40
    17f9:	c3                   	ret    

000017fa <wait>:
SYSCALL(wait)
    17fa:	b8 03 00 00 00       	mov    $0x3,%eax
    17ff:	cd 40                	int    $0x40
    1801:	c3                   	ret    

00001802 <pipe>:
SYSCALL(pipe)
    1802:	b8 04 00 00 00       	mov    $0x4,%eax
    1807:	cd 40                	int    $0x40
    1809:	c3                   	ret    

0000180a <read>:
SYSCALL(read)
    180a:	b8 05 00 00 00       	mov    $0x5,%eax
    180f:	cd 40                	int    $0x40
    1811:	c3                   	ret    

00001812 <steal>:
SYSCALL(steal)
    1812:	b8 17 00 00 00       	mov    $0x17,%eax
    1817:	cd 40                	int    $0x40
    1819:	c3                   	ret    

0000181a <write>:
SYSCALL(write)
    181a:	b8 10 00 00 00       	mov    $0x10,%eax
    181f:	cd 40                	int    $0x40
    1821:	c3                   	ret    

00001822 <close>:
SYSCALL(close)
    1822:	b8 15 00 00 00       	mov    $0x15,%eax
    1827:	cd 40                	int    $0x40
    1829:	c3                   	ret    

0000182a <kill>:
SYSCALL(kill)
    182a:	b8 06 00 00 00       	mov    $0x6,%eax
    182f:	cd 40                	int    $0x40
    1831:	c3                   	ret    

00001832 <exec>:
SYSCALL(exec)
    1832:	b8 07 00 00 00       	mov    $0x7,%eax
    1837:	cd 40                	int    $0x40
    1839:	c3                   	ret    

0000183a <open>:
SYSCALL(open)
    183a:	b8 0f 00 00 00       	mov    $0xf,%eax
    183f:	cd 40                	int    $0x40
    1841:	c3                   	ret    

00001842 <mknod>:
SYSCALL(mknod)
    1842:	b8 11 00 00 00       	mov    $0x11,%eax
    1847:	cd 40                	int    $0x40
    1849:	c3                   	ret    

0000184a <unlink>:
SYSCALL(unlink)
    184a:	b8 12 00 00 00       	mov    $0x12,%eax
    184f:	cd 40                	int    $0x40
    1851:	c3                   	ret    

00001852 <fstat>:
SYSCALL(fstat)
    1852:	b8 08 00 00 00       	mov    $0x8,%eax
    1857:	cd 40                	int    $0x40
    1859:	c3                   	ret    

0000185a <link>:
SYSCALL(link)
    185a:	b8 13 00 00 00       	mov    $0x13,%eax
    185f:	cd 40                	int    $0x40
    1861:	c3                   	ret    

00001862 <mkdir>:
SYSCALL(mkdir)
    1862:	b8 14 00 00 00       	mov    $0x14,%eax
    1867:	cd 40                	int    $0x40
    1869:	c3                   	ret    

0000186a <chdir>:
SYSCALL(chdir)
    186a:	b8 09 00 00 00       	mov    $0x9,%eax
    186f:	cd 40                	int    $0x40
    1871:	c3                   	ret    

00001872 <dup>:
SYSCALL(dup)
    1872:	b8 0a 00 00 00       	mov    $0xa,%eax
    1877:	cd 40                	int    $0x40
    1879:	c3                   	ret    

0000187a <getpid>:
SYSCALL(getpid)
    187a:	b8 0b 00 00 00       	mov    $0xb,%eax
    187f:	cd 40                	int    $0x40
    1881:	c3                   	ret    

00001882 <sbrk>:
SYSCALL(sbrk)
    1882:	b8 0c 00 00 00       	mov    $0xc,%eax
    1887:	cd 40                	int    $0x40
    1889:	c3                   	ret    

0000188a <sleep>:
SYSCALL(sleep)
    188a:	b8 0d 00 00 00       	mov    $0xd,%eax
    188f:	cd 40                	int    $0x40
    1891:	c3                   	ret    

00001892 <uptime>:
SYSCALL(uptime)
    1892:	b8 0e 00 00 00       	mov    $0xe,%eax
    1897:	cd 40                	int    $0x40
    1899:	c3                   	ret    

0000189a <cpuhalt>:
SYSCALL(cpuhalt)
    189a:	b8 16 00 00 00       	mov    $0x16,%eax
    189f:	cd 40                	int    $0x40
    18a1:	c3                   	ret    
    18a2:	66 90                	xchg   %ax,%ax
    18a4:	66 90                	xchg   %ax,%ax
    18a6:	66 90                	xchg   %ax,%ax
    18a8:	66 90                	xchg   %ax,%ax
    18aa:	66 90                	xchg   %ax,%ax
    18ac:	66 90                	xchg   %ax,%ax
    18ae:	66 90                	xchg   %ax,%ax

000018b0 <printint.constprop.1>:
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
}

static void
printint(int fd, int xx, int base, int sgn)
    18b0:	55                   	push   %ebp
    18b1:	89 e5                	mov    %esp,%ebp
    18b3:	57                   	push   %edi
    18b4:	56                   	push   %esi
    18b5:	53                   	push   %ebx
    18b6:	89 d6                	mov    %edx,%esi
    18b8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    18bb:	85 c0                	test   %eax,%eax
    18bd:	79 71                	jns    1930 <printint.constprop.1+0x80>
    18bf:	83 e1 01             	and    $0x1,%ecx
    18c2:	74 6c                	je     1930 <printint.constprop.1+0x80>
    neg = 1;
    x = -xx;
    18c4:	f7 d8                	neg    %eax
    neg = 1;
    18c6:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    18cd:	31 c9                	xor    %ecx,%ecx
    18cf:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    18d2:	eb 06                	jmp    18da <printint.constprop.1+0x2a>
    18d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    18d8:	89 f9                	mov    %edi,%ecx
    18da:	31 d2                	xor    %edx,%edx
    18dc:	8d 79 01             	lea    0x1(%ecx),%edi
    18df:	f7 f6                	div    %esi
    18e1:	0f b6 92 54 20 00 00 	movzbl 0x2054(%edx),%edx
  }while((x /= base) != 0);
    18e8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    18ea:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    18ed:	75 e9                	jne    18d8 <printint.constprop.1+0x28>
  if(neg)
    18ef:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    18f2:	85 c0                	test   %eax,%eax
    18f4:	74 08                	je     18fe <printint.constprop.1+0x4e>
    buf[i++] = '-';
    18f6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    18fb:	8d 79 02             	lea    0x2(%ecx),%edi
    18fe:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    1902:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1908:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    190b:	83 ec 04             	sub    $0x4,%esp
    190e:	83 ee 01             	sub    $0x1,%esi
    1911:	6a 01                	push   $0x1
    1913:	53                   	push   %ebx
    1914:	6a 01                	push   $0x1
    1916:	88 45 d7             	mov    %al,-0x29(%ebp)
    1919:	e8 fc fe ff ff       	call   181a <write>

  while(--i >= 0)
    191e:	83 c4 10             	add    $0x10,%esp
    1921:	39 de                	cmp    %ebx,%esi
    1923:	75 e3                	jne    1908 <printint.constprop.1+0x58>
    putc(fd, buf[i]);
}
    1925:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1928:	5b                   	pop    %ebx
    1929:	5e                   	pop    %esi
    192a:	5f                   	pop    %edi
    192b:	5d                   	pop    %ebp
    192c:	c3                   	ret    
    192d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
    1930:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1937:	eb 94                	jmp    18cd <printint.constprop.1+0x1d>
    1939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001940 <vprintf.constprop.0>:
static void vprintf(int fd, const char *fmt, va_list ap)
    1940:	55                   	push   %ebp
    1941:	89 e5                	mov    %esp,%ebp
    1943:	57                   	push   %edi
    1944:	56                   	push   %esi
    1945:	53                   	push   %ebx
    1946:	89 d6                	mov    %edx,%esi
    1948:	83 ec 2c             	sub    $0x2c,%esp
{
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    194b:	0f b6 10             	movzbl (%eax),%edx
    194e:	84 d2                	test   %dl,%dl
    1950:	0f 84 cd 00 00 00    	je     1a23 <vprintf.constprop.0+0xe3>
    1956:	8d 58 01             	lea    0x1(%eax),%ebx
  state = 0;
    1959:	31 ff                	xor    %edi,%edi
    195b:	eb 31                	jmp    198e <vprintf.constprop.0+0x4e>
    195d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1960:	83 f8 25             	cmp    $0x25,%eax
    1963:	0f 84 c7 00 00 00    	je     1a30 <vprintf.constprop.0+0xf0>
  write(fd, &c, 1);
    1969:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    196c:	83 ec 04             	sub    $0x4,%esp
    196f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
    1972:	6a 01                	push   $0x1
    1974:	50                   	push   %eax
    1975:	6a 01                	push   $0x1
    1977:	e8 9e fe ff ff       	call   181a <write>
    197c:	83 c4 10             	add    $0x10,%esp
    197f:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
    1982:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1986:	84 d2                	test   %dl,%dl
    1988:	0f 84 95 00 00 00    	je     1a23 <vprintf.constprop.0+0xe3>
    if(state == 0){
    198e:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    1990:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    1993:	74 cb                	je     1960 <vprintf.constprop.0+0x20>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1995:	83 ff 25             	cmp    $0x25,%edi
    1998:	75 e5                	jne    197f <vprintf.constprop.0+0x3f>
      if(c == 'd'){
    199a:	83 f8 64             	cmp    $0x64,%eax
        printint(fd, va_arg(ap, int), 10, 1);
    199d:	8d 7e 04             	lea    0x4(%esi),%edi
    19a0:	b9 01 00 00 00       	mov    $0x1,%ecx
      if(c == 'd'){
    19a5:	0f 84 9a 00 00 00    	je     1a45 <vprintf.constprop.0+0x105>
      } else if(c == 'l') {
    19ab:	83 f8 6c             	cmp    $0x6c,%eax
    19ae:	0f 84 8c 00 00 00    	je     1a40 <vprintf.constprop.0+0x100>
        printint(fd, va_arg(ap, uint), 10, 0);
      } else if(c == 'x') {
    19b4:	83 f8 78             	cmp    $0x78,%eax
    19b7:	0f 84 a3 00 00 00    	je     1a60 <vprintf.constprop.0+0x120>
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    19bd:	83 f8 70             	cmp    $0x70,%eax
    19c0:	0f 84 ca 00 00 00    	je     1a90 <vprintf.constprop.0+0x150>
        printptr(fd, va_arg(ap, uint));
      } else if(c == 's'){
    19c6:	83 f8 73             	cmp    $0x73,%eax
    19c9:	0f 84 39 01 00 00    	je     1b08 <vprintf.constprop.0+0x1c8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    19cf:	83 f8 63             	cmp    $0x63,%eax
    19d2:	0f 84 68 01 00 00    	je     1b40 <vprintf.constprop.0+0x200>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    19d8:	83 f8 25             	cmp    $0x25,%eax
    19db:	0f 84 9f 00 00 00    	je     1a80 <vprintf.constprop.0+0x140>
  write(fd, &c, 1);
    19e1:	8d 45 df             	lea    -0x21(%ebp),%eax
    19e4:	83 ec 04             	sub    $0x4,%esp
    19e7:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    19ea:	6a 01                	push   $0x1
    19ec:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
    19f0:	50                   	push   %eax
    19f1:	6a 01                	push   $0x1
    19f3:	e8 22 fe ff ff       	call   181a <write>
    19f8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    19fc:	83 c4 0c             	add    $0xc,%esp
    19ff:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1a02:	6a 01                	push   $0x1
    1a04:	88 55 e0             	mov    %dl,-0x20(%ebp)
    1a07:	50                   	push   %eax
    1a08:	6a 01                	push   $0x1
    1a0a:	83 c3 01             	add    $0x1,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1a0d:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    1a0f:	e8 06 fe ff ff       	call   181a <write>
  for(i = 0; fmt[i]; i++){
    1a14:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
  write(fd, &c, 1);
    1a18:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1a1b:	84 d2                	test   %dl,%dl
    1a1d:	0f 85 6b ff ff ff    	jne    198e <vprintf.constprop.0+0x4e>
    }
  }
}
    1a23:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a26:	5b                   	pop    %ebx
    1a27:	5e                   	pop    %esi
    1a28:	5f                   	pop    %edi
    1a29:	5d                   	pop    %ebp
    1a2a:	c3                   	ret    
    1a2b:	90                   	nop
    1a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        state = '%';
    1a30:	bf 25 00 00 00       	mov    $0x25,%edi
    1a35:	e9 45 ff ff ff       	jmp    197f <vprintf.constprop.0+0x3f>
    1a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, uint), 10, 0);
    1a40:	8d 7e 04             	lea    0x4(%esi),%edi
    1a43:	31 c9                	xor    %ecx,%ecx
    1a45:	8b 06                	mov    (%esi),%eax
    1a47:	ba 0a 00 00 00       	mov    $0xa,%edx
    1a4c:	89 fe                	mov    %edi,%esi
      state = 0;
    1a4e:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, uint), 10, 0);
    1a50:	e8 5b fe ff ff       	call   18b0 <printint.constprop.1>
    1a55:	e9 25 ff ff ff       	jmp    197f <vprintf.constprop.0+0x3f>
    1a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, int), 16, 0);
    1a60:	8b 06                	mov    (%esi),%eax
    1a62:	8d 7e 04             	lea    0x4(%esi),%edi
    1a65:	31 c9                	xor    %ecx,%ecx
    1a67:	ba 10 00 00 00       	mov    $0x10,%edx
    1a6c:	89 fe                	mov    %edi,%esi
      state = 0;
    1a6e:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, int), 16, 0);
    1a70:	e8 3b fe ff ff       	call   18b0 <printint.constprop.1>
    1a75:	e9 05 ff ff ff       	jmp    197f <vprintf.constprop.0+0x3f>
    1a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1a80:	83 ec 04             	sub    $0x4,%esp
    1a83:	88 55 e1             	mov    %dl,-0x1f(%ebp)
    1a86:	8d 45 e1             	lea    -0x1f(%ebp),%eax
    1a89:	6a 01                	push   $0x1
    1a8b:	e9 77 ff ff ff       	jmp    1a07 <vprintf.constprop.0+0xc7>
        printptr(fd, va_arg(ap, uint));
    1a90:	8d 46 04             	lea    0x4(%esi),%eax
  write(fd, &c, 1);
    1a93:	83 ec 04             	sub    $0x4,%esp
        printptr(fd, va_arg(ap, uint));
    1a96:	8b 3e                	mov    (%esi),%edi
  write(fd, &c, 1);
    1a98:	6a 01                	push   $0x1
    1a9a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
    1a9e:	be 08 00 00 00       	mov    $0x8,%esi
        printptr(fd, va_arg(ap, uint));
    1aa3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
    1aa6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1aa9:	50                   	push   %eax
    1aaa:	6a 01                	push   $0x1
    1aac:	e8 69 fd ff ff       	call   181a <write>
    1ab1:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1ab4:	83 c4 0c             	add    $0xc,%esp
    1ab7:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
    1abb:	6a 01                	push   $0x1
    1abd:	50                   	push   %eax
    1abe:	6a 01                	push   $0x1
    1ac0:	e8 55 fd ff ff       	call   181a <write>
    1ac5:	83 c4 10             	add    $0x10,%esp
    1ac8:	90                   	nop
    1ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1ad0:	89 f8                	mov    %edi,%eax
  write(fd, &c, 1);
    1ad2:	83 ec 04             	sub    $0x4,%esp
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1ad5:	c1 e7 04             	shl    $0x4,%edi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1ad8:	c1 e8 1c             	shr    $0x1c,%eax
  write(fd, &c, 1);
    1adb:	6a 01                	push   $0x1
    1add:	0f b6 80 54 20 00 00 	movzbl 0x2054(%eax),%eax
    1ae4:	88 45 e5             	mov    %al,-0x1b(%ebp)
    1ae7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1aea:	50                   	push   %eax
    1aeb:	6a 01                	push   $0x1
    1aed:	e8 28 fd ff ff       	call   181a <write>
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1af2:	83 c4 10             	add    $0x10,%esp
    1af5:	83 ee 01             	sub    $0x1,%esi
    1af8:	75 d6                	jne    1ad0 <vprintf.constprop.0+0x190>
        s = va_arg(ap, char*);
    1afa:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
    1afd:	31 ff                	xor    %edi,%edi
    1aff:	e9 7b fe ff ff       	jmp    197f <vprintf.constprop.0+0x3f>
    1b04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = va_arg(ap, char*);
    1b08:	8b 3e                	mov    (%esi),%edi
    1b0a:	8d 46 04             	lea    0x4(%esi),%eax
    1b0d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    1b10:	85 ff                	test   %edi,%edi
    1b12:	74 50                	je     1b64 <vprintf.constprop.0+0x224>
        while(*s != 0){
    1b14:	0f b6 07             	movzbl (%edi),%eax
    1b17:	84 c0                	test   %al,%al
    1b19:	74 df                	je     1afa <vprintf.constprop.0+0x1ba>
    1b1b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
    1b1e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
    1b20:	83 ec 04             	sub    $0x4,%esp
          s++;
    1b23:	83 c7 01             	add    $0x1,%edi
    1b26:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1b29:	6a 01                	push   $0x1
    1b2b:	56                   	push   %esi
    1b2c:	6a 01                	push   $0x1
    1b2e:	e8 e7 fc ff ff       	call   181a <write>
        while(*s != 0){
    1b33:	0f b6 07             	movzbl (%edi),%eax
    1b36:	83 c4 10             	add    $0x10,%esp
    1b39:	84 c0                	test   %al,%al
    1b3b:	75 e3                	jne    1b20 <vprintf.constprop.0+0x1e0>
    1b3d:	eb bb                	jmp    1afa <vprintf.constprop.0+0x1ba>
    1b3f:	90                   	nop
        putc(fd, va_arg(ap, uint));
    1b40:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
    1b42:	83 ec 04             	sub    $0x4,%esp
        putc(fd, va_arg(ap, uint));
    1b45:	8d 7e 04             	lea    0x4(%esi),%edi
  write(fd, &c, 1);
    1b48:	6a 01                	push   $0x1
        putc(fd, va_arg(ap, uint));
    1b4a:	89 fe                	mov    %edi,%esi
      state = 0;
    1b4c:	31 ff                	xor    %edi,%edi
        putc(fd, va_arg(ap, uint));
    1b4e:	88 45 e2             	mov    %al,-0x1e(%ebp)
  write(fd, &c, 1);
    1b51:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1b54:	50                   	push   %eax
    1b55:	6a 01                	push   $0x1
    1b57:	e8 be fc ff ff       	call   181a <write>
    1b5c:	83 c4 10             	add    $0x10,%esp
    1b5f:	e9 1b fe ff ff       	jmp    197f <vprintf.constprop.0+0x3f>
          s = "(null)";
    1b64:	bf 4a 20 00 00       	mov    $0x204a,%edi
        while(*s != 0){
    1b69:	b8 28 00 00 00       	mov    $0x28,%eax
    1b6e:	eb ab                	jmp    1b1b <vprintf.constprop.0+0x1db>

00001b70 <fprintf>:
// Print to the given fd. Only understands %d,%x, %p, %s, %c.
void
fprintf(int fd, const char *fmt, ...)
{
    1b70:	55                   	push   %ebp
    1b71:	89 e5                	mov    %esp,%ebp
    1b73:	83 ec 08             	sub    $0x8,%esp
 va_list ap;
 va_start(ap, fmt); 
 vprintf(1,fmt,ap);
    1b76:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b79:	8d 55 10             	lea    0x10(%ebp),%edx
    1b7c:	e8 bf fd ff ff       	call   1940 <vprintf.constprop.0>
}
    1b81:	c9                   	leave  
    1b82:	c3                   	ret    
    1b83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001b90 <printf>:
void
printf(const char *fmt, ...)
{
    1b90:	55                   	push   %ebp
    1b91:	89 e5                	mov    %esp,%ebp
    1b93:	83 ec 08             	sub    $0x8,%esp
  va_list ap;
  va_start(ap, fmt); 
  vprintf(1,fmt,ap);
    1b96:	8b 45 08             	mov    0x8(%ebp),%eax
    1b99:	8d 55 0c             	lea    0xc(%ebp),%edx
    1b9c:	e8 9f fd ff ff       	call   1940 <vprintf.constprop.0>
}
    1ba1:	c9                   	leave  
    1ba2:	c3                   	ret    
    1ba3:	66 90                	xchg   %ax,%ax
    1ba5:	66 90                	xchg   %ax,%ax
    1ba7:	66 90                	xchg   %ax,%ax
    1ba9:	66 90                	xchg   %ax,%ax
    1bab:	66 90                	xchg   %ax,%ax
    1bad:	66 90                	xchg   %ax,%ax
    1baf:	90                   	nop

00001bb0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1bb0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1bb1:	a1 08 2e 00 00       	mov    0x2e08,%eax
{
    1bb6:	89 e5                	mov    %esp,%ebp
    1bb8:	57                   	push   %edi
    1bb9:	56                   	push   %esi
    1bba:	53                   	push   %ebx
    1bbb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    1bbe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1bc8:	39 c8                	cmp    %ecx,%eax
    1bca:	8b 10                	mov    (%eax),%edx
    1bcc:	73 32                	jae    1c00 <free+0x50>
    1bce:	39 d1                	cmp    %edx,%ecx
    1bd0:	72 04                	jb     1bd6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1bd2:	39 d0                	cmp    %edx,%eax
    1bd4:	72 32                	jb     1c08 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1bd6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1bd9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1bdc:	39 fa                	cmp    %edi,%edx
    1bde:	74 30                	je     1c10 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1be0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1be3:	8b 50 04             	mov    0x4(%eax),%edx
    1be6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1be9:	39 f1                	cmp    %esi,%ecx
    1beb:	74 3a                	je     1c27 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1bed:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1bef:	a3 08 2e 00 00       	mov    %eax,0x2e08
}
    1bf4:	5b                   	pop    %ebx
    1bf5:	5e                   	pop    %esi
    1bf6:	5f                   	pop    %edi
    1bf7:	5d                   	pop    %ebp
    1bf8:	c3                   	ret    
    1bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1c00:	39 d0                	cmp    %edx,%eax
    1c02:	72 04                	jb     1c08 <free+0x58>
    1c04:	39 d1                	cmp    %edx,%ecx
    1c06:	72 ce                	jb     1bd6 <free+0x26>
{
    1c08:	89 d0                	mov    %edx,%eax
    1c0a:	eb bc                	jmp    1bc8 <free+0x18>
    1c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1c10:	03 72 04             	add    0x4(%edx),%esi
    1c13:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1c16:	8b 10                	mov    (%eax),%edx
    1c18:	8b 12                	mov    (%edx),%edx
    1c1a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1c1d:	8b 50 04             	mov    0x4(%eax),%edx
    1c20:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1c23:	39 f1                	cmp    %esi,%ecx
    1c25:	75 c6                	jne    1bed <free+0x3d>
    p->s.size += bp->s.size;
    1c27:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    1c2a:	a3 08 2e 00 00       	mov    %eax,0x2e08
    p->s.size += bp->s.size;
    1c2f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1c32:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1c35:	89 10                	mov    %edx,(%eax)
}
    1c37:	5b                   	pop    %ebx
    1c38:	5e                   	pop    %esi
    1c39:	5f                   	pop    %edi
    1c3a:	5d                   	pop    %ebp
    1c3b:	c3                   	ret    
    1c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001c40 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1c40:	55                   	push   %ebp
    1c41:	89 e5                	mov    %esp,%ebp
    1c43:	57                   	push   %edi
    1c44:	56                   	push   %esi
    1c45:	53                   	push   %ebx
    1c46:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1c49:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    1c4c:	8b 15 08 2e 00 00    	mov    0x2e08,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1c52:	8d 78 07             	lea    0x7(%eax),%edi
    1c55:	c1 ef 03             	shr    $0x3,%edi
    1c58:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    1c5b:	85 d2                	test   %edx,%edx
    1c5d:	0f 84 9d 00 00 00    	je     1d00 <malloc+0xc0>
    1c63:	8b 02                	mov    (%edx),%eax
    1c65:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1c68:	39 cf                	cmp    %ecx,%edi
    1c6a:	76 6c                	jbe    1cd8 <malloc+0x98>
    1c6c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1c72:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1c77:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1c7a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1c81:	eb 0e                	jmp    1c91 <malloc+0x51>
    1c83:	90                   	nop
    1c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1c88:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1c8a:	8b 48 04             	mov    0x4(%eax),%ecx
    1c8d:	39 f9                	cmp    %edi,%ecx
    1c8f:	73 47                	jae    1cd8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1c91:	39 05 08 2e 00 00    	cmp    %eax,0x2e08
    1c97:	89 c2                	mov    %eax,%edx
    1c99:	75 ed                	jne    1c88 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    1c9b:	83 ec 0c             	sub    $0xc,%esp
    1c9e:	56                   	push   %esi
    1c9f:	e8 de fb ff ff       	call   1882 <sbrk>
  if(p == (char*)-1)
    1ca4:	83 c4 10             	add    $0x10,%esp
    1ca7:	83 f8 ff             	cmp    $0xffffffff,%eax
    1caa:	74 1c                	je     1cc8 <malloc+0x88>
  hp->s.size = nu;
    1cac:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1caf:	83 ec 0c             	sub    $0xc,%esp
    1cb2:	83 c0 08             	add    $0x8,%eax
    1cb5:	50                   	push   %eax
    1cb6:	e8 f5 fe ff ff       	call   1bb0 <free>
  return freep;
    1cbb:	8b 15 08 2e 00 00    	mov    0x2e08,%edx
      if((p = morecore(nunits)) == 0)
    1cc1:	83 c4 10             	add    $0x10,%esp
    1cc4:	85 d2                	test   %edx,%edx
    1cc6:	75 c0                	jne    1c88 <malloc+0x48>
        return 0;
  }
}
    1cc8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1ccb:	31 c0                	xor    %eax,%eax
}
    1ccd:	5b                   	pop    %ebx
    1cce:	5e                   	pop    %esi
    1ccf:	5f                   	pop    %edi
    1cd0:	5d                   	pop    %ebp
    1cd1:	c3                   	ret    
    1cd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1cd8:	39 cf                	cmp    %ecx,%edi
    1cda:	74 54                	je     1d30 <malloc+0xf0>
        p->s.size -= nunits;
    1cdc:	29 f9                	sub    %edi,%ecx
    1cde:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1ce1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1ce4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1ce7:	89 15 08 2e 00 00    	mov    %edx,0x2e08
}
    1ced:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1cf0:	83 c0 08             	add    $0x8,%eax
}
    1cf3:	5b                   	pop    %ebx
    1cf4:	5e                   	pop    %esi
    1cf5:	5f                   	pop    %edi
    1cf6:	5d                   	pop    %ebp
    1cf7:	c3                   	ret    
    1cf8:	90                   	nop
    1cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1d00:	c7 05 08 2e 00 00 0c 	movl   $0x2e0c,0x2e08
    1d07:	2e 00 00 
    1d0a:	c7 05 0c 2e 00 00 0c 	movl   $0x2e0c,0x2e0c
    1d11:	2e 00 00 
    base.s.size = 0;
    1d14:	b8 0c 2e 00 00       	mov    $0x2e0c,%eax
    1d19:	c7 05 10 2e 00 00 00 	movl   $0x0,0x2e10
    1d20:	00 00 00 
    1d23:	e9 44 ff ff ff       	jmp    1c6c <malloc+0x2c>
    1d28:	90                   	nop
    1d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1d30:	8b 08                	mov    (%eax),%ecx
    1d32:	89 0a                	mov    %ecx,(%edx)
    1d34:	eb b1                	jmp    1ce7 <malloc+0xa7>
