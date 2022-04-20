
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
      1f:	0f 8e b8 02 00 00    	jle    2dd <main+0x2dd>
    fprintf(2, "specify a file you want to edit\n");
    exit();
  } else if (argc > 2) {
      25:	83 f8 02             	cmp    $0x2,%eax
      28:	0f 85 ad 01 00 00    	jne    1db <main+0x1db>
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
      85:	e8 66 04 00 00       	call   4f0 <MakeLinkedList>
  fprintf(2, "Welcome to xvEdit!\n");
      8a:	51                   	push   %ecx
      8b:	51                   	push   %ecx
      8c:	68 03 1b 00 00       	push   $0x1b03
      91:	6a 02                	push   $0x2
  file.lines = MakeLinkedList();
      93:	89 85 0c f8 ff ff    	mov    %eax,-0x7f4(%ebp)
  fprintf(2, "Welcome to xvEdit!\n");
      99:	e8 c2 17 00 00       	call   1860 <fprintf>

  // opening file
  file.fd = open(file.filename, O_RDONLY);
      9e:	5b                   	pop    %ebx
      9f:	5e                   	pop    %esi
      a0:	6a 00                	push   $0x0
      a2:	ff b5 00 f8 ff ff    	pushl  -0x800(%ebp)
      a8:	e8 85 14 00 00       	call   1532 <open>
  if (file.fd == -1) {
      ad:	83 c4 10             	add    $0x10,%esp
  file.fd = open(file.filename, O_RDONLY);
      b0:	89 85 04 f8 ff ff    	mov    %eax,-0x7fc(%ebp)
  if (file.fd == -1) {
      b6:	83 c0 01             	add    $0x1,%eax
      b9:	0f 84 4d 02 00 00    	je     30c <main+0x30c>
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
      cf:	e8 1c 07 00 00       	call   7f0 <gatherLines>
      d4:	83 c4 10             	add    $0x10,%esp
  }
  close(file.fd);
      d7:	83 ec 0c             	sub    $0xc,%esp
      da:	ff b5 04 f8 ff ff    	pushl  -0x7fc(%ebp)
      e0:	8d 9d 18 f8 ff ff    	lea    -0x7e8(%ebp),%ebx
      e6:	e8 2f 14 00 00       	call   151a <close>
      eb:	83 c4 10             	add    $0x10,%esp
      ee:	66 90                	xchg   %ax,%ax

  // xvEdit>
  while (cmd != QUIT) {
    fprintf(2, "xvEdit> ");
      f0:	83 ec 08             	sub    $0x8,%esp
      f3:	68 27 1b 00 00       	push   $0x1b27
      f8:	6a 02                	push   $0x2
      fa:	e8 61 17 00 00       	call   1860 <fprintf>
    memset(buf, 0, nbuf);
      ff:	83 c4 0c             	add    $0xc,%esp
     102:	68 e8 03 00 00       	push   $0x3e8
     107:	6a 00                	push   $0x0
     109:	68 a0 25 00 00       	push   $0x25a0
     10e:	e8 3d 12 00 00       	call   1350 <memset>
    gets(buf, nbuf);
     113:	59                   	pop    %ecx
     114:	5e                   	pop    %esi
     115:	68 e8 03 00 00       	push   $0x3e8
     11a:	68 a0 25 00 00       	push   $0x25a0
     11f:	e8 8c 12 00 00       	call   13b0 <gets>
    
    unline(buf);
     124:	c7 04 24 a0 25 00 00 	movl   $0x25a0,(%esp)
     12b:	e8 30 07 00 00       	call   860 <unline>
    substr(cmdstr, buf, 0, 4);
     130:	6a 04                	push   $0x4
     132:	6a 00                	push   $0x0
     134:	68 a0 25 00 00       	push   $0x25a0
     139:	53                   	push   %ebx
     13a:	e8 d1 07 00 00       	call   910 <substr>
  return atoi(str);
}

void toUpper(char* str) {
  int i = 0;
  while (str[i] != '\0') {
     13f:	0f b6 85 18 f8 ff ff 	movzbl -0x7e8(%ebp),%eax
     146:	83 c4 20             	add    $0x20,%esp
     149:	84 c0                	test   %al,%al
     14b:	74 1a                	je     167 <main+0x167>
     14d:	89 da                	mov    %ebx,%edx
     14f:	90                   	nop
    char c = str[i];
    if (c <= 'z' && c >= 'a')
     150:	8d 48 9f             	lea    -0x61(%eax),%ecx
     153:	80 f9 19             	cmp    $0x19,%cl
     156:	77 05                	ja     15d <main+0x15d>
      str[i] += ('Z' - 'z');
     158:	83 e8 20             	sub    $0x20,%eax
     15b:	88 02                	mov    %al,(%edx)
     15d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     160:	0f b6 02             	movzbl (%edx),%eax
     163:	84 c0                	test   %al,%al
     165:	75 e9                	jne    150 <main+0x150>
    toUpper(cmdstr);
    substr(args, buf, strlen(cmdstr) + 1, strlen(buf));
     167:	83 ec 0c             	sub    $0xc,%esp
     16a:	68 a0 25 00 00       	push   $0x25a0
     16f:	e8 ac 11 00 00       	call   1320 <strlen>
     174:	89 1c 24             	mov    %ebx,(%esp)
     177:	89 c6                	mov    %eax,%esi
     179:	e8 a2 11 00 00       	call   1320 <strlen>
     17e:	83 c0 01             	add    $0x1,%eax
     181:	56                   	push   %esi
     182:	50                   	push   %eax
     183:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     189:	68 a0 25 00 00       	push   $0x25a0
     18e:	50                   	push   %eax
     18f:	e8 7c 07 00 00       	call   910 <substr>

    if      (strcmp(cmdstr, "@END") == 0) {cmd = END;}
     194:	83 c4 18             	add    $0x18,%esp
     197:	68 30 1b 00 00       	push   $0x1b30
     19c:	53                   	push   %ebx
     19d:	e8 2e 11 00 00       	call   12d0 <strcmp>
     1a2:	83 c4 10             	add    $0x10,%esp
     1a5:	85 c0                	test   %eax,%eax
     1a7:	75 47                	jne    1f0 <main+0x1f0>

// commands
void end(struct File* file, char* args) {
  file->edited = 1;
  char* line = args;
  append(file->lines, line);
     1a9:	8b 85 0c f8 ff ff    	mov    -0x7f4(%ebp),%eax
  atPos->prev = new;
  list->len++;
}

void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     1af:	8d bd 00 fc ff ff    	lea    -0x400(%ebp),%edi
     1b5:	83 ec 04             	sub    $0x4,%esp
  file->edited = 1;
     1b8:	c7 85 14 f8 ff ff 01 	movl   $0x1,-0x7ec(%ebp)
     1bf:	00 00 00 
     1c2:	ff 70 08             	pushl  0x8(%eax)
     1c5:	57                   	push   %edi
     1c6:	50                   	push   %eax
     1c7:	e8 94 03 00 00       	call   560 <insert>
  file->len++;
     1cc:	83 85 10 f8 ff ff 01 	addl   $0x1,-0x7f0(%ebp)
     1d3:	83 c4 10             	add    $0x10,%esp
     1d6:	e9 15 ff ff ff       	jmp    f0 <main+0xf0>
    fprintf(2, "only specify one file\n");
     1db:	57                   	push   %edi
     1dc:	57                   	push   %edi
     1dd:	68 ec 1a 00 00       	push   $0x1aec
     1e2:	6a 02                	push   $0x2
     1e4:	e8 77 16 00 00       	call   1860 <fprintf>
    exit();
     1e9:	e8 04 13 00 00       	call   14f2 <exit>
     1ee:	66 90                	xchg   %ax,%ax
    else if (strcmp(cmdstr, "ADD<") == 0) {cmd = ADD;}
     1f0:	83 ec 08             	sub    $0x8,%esp
     1f3:	68 35 1b 00 00       	push   $0x1b35
     1f8:	53                   	push   %ebx
     1f9:	e8 d2 10 00 00       	call   12d0 <strcmp>
     1fe:	83 c4 10             	add    $0x10,%esp
     201:	85 c0                	test   %eax,%eax
     203:	0f 84 9c 00 00 00    	je     2a5 <main+0x2a5>
    else if (strcmp(cmdstr, "DROP") == 0) {cmd = DROP;}
     209:	52                   	push   %edx
     20a:	52                   	push   %edx
     20b:	68 3a 1b 00 00       	push   $0x1b3a
     210:	53                   	push   %ebx
     211:	e8 ba 10 00 00       	call   12d0 <strcmp>
     216:	83 c4 10             	add    $0x10,%esp
     219:	85 c0                	test   %eax,%eax
     21b:	0f 84 a0 00 00 00    	je     2c1 <main+0x2c1>
    else if (strcmp(cmdstr, "EDIT") == 0) {cmd = EDIT;}
     221:	50                   	push   %eax
     222:	50                   	push   %eax
     223:	68 3f 1b 00 00       	push   $0x1b3f
     228:	53                   	push   %ebx
     229:	e8 a2 10 00 00       	call   12d0 <strcmp>
     22e:	83 c4 10             	add    $0x10,%esp
     231:	85 c0                	test   %eax,%eax
     233:	0f 84 b7 00 00 00    	je     2f0 <main+0x2f0>
    else if (strcmp(cmdstr, "LIST") == 0) {cmd = LIST;}
     239:	50                   	push   %eax
     23a:	50                   	push   %eax
     23b:	68 44 1b 00 00       	push   $0x1b44
     240:	53                   	push   %ebx
     241:	e8 8a 10 00 00       	call   12d0 <strcmp>
     246:	83 c4 10             	add    $0x10,%esp
     249:	85 c0                	test   %eax,%eax
     24b:	0f 84 02 01 00 00    	je     353 <main+0x353>
    else if (strcmp(cmdstr, "SHOW") == 0) {cmd = SHOW;}
     251:	50                   	push   %eax
     252:	50                   	push   %eax
     253:	68 49 1b 00 00       	push   $0x1b49
     258:	53                   	push   %ebx
     259:	e8 72 10 00 00       	call   12d0 <strcmp>
     25e:	83 c4 10             	add    $0x10,%esp
     261:	85 c0                	test   %eax,%eax
     263:	0f 85 11 01 00 00    	jne    37a <main+0x37a>
     269:	8b 85 0c f8 ff ff    	mov    -0x7f4(%ebp),%eax
  }
}

void show(struct File file, char* args) {
  struct Node* cur = file.lines->head->next;
  int lineNum = 1;
     26f:	bf 01 00 00 00       	mov    $0x1,%edi
     274:	89 85 f0 f7 ff ff    	mov    %eax,-0x810(%ebp)
  struct Node* cur = file.lines->head->next;
     27a:	8b 00                	mov    (%eax),%eax
     27c:	8b 70 08             	mov    0x8(%eax),%esi
     27f:	eb 14                	jmp    295 <main+0x295>
  while (cur != file.lines->tail) {
    printl(lineNum, cur->data);
     281:	50                   	push   %eax
     282:	50                   	push   %eax
     283:	ff 76 04             	pushl  0x4(%esi)
     286:	57                   	push   %edi
    cur = cur->next;
    lineNum++;
     287:	83 c7 01             	add    $0x1,%edi
    printl(lineNum, cur->data);
     28a:	e8 e1 09 00 00       	call   c70 <printl>
    cur = cur->next;
     28f:	8b 76 08             	mov    0x8(%esi),%esi
    lineNum++;
     292:	83 c4 10             	add    $0x10,%esp
  while (cur != file.lines->tail) {
     295:	8b 85 f0 f7 ff ff    	mov    -0x810(%ebp),%eax
     29b:	3b 70 04             	cmp    0x4(%eax),%esi
     29e:	75 e1                	jne    281 <main+0x281>
     2a0:	e9 4b fe ff ff       	jmp    f0 <main+0xf0>
      add(&file, args);
     2a5:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     2ab:	52                   	push   %edx
     2ac:	52                   	push   %edx
     2ad:	50                   	push   %eax
     2ae:	ff b5 f4 f7 ff ff    	pushl  -0x80c(%ebp)
     2b4:	e8 47 0a 00 00       	call   d00 <add>
     2b9:	83 c4 10             	add    $0x10,%esp
     2bc:	e9 2f fe ff ff       	jmp    f0 <main+0xf0>
      drop(&file, args);
     2c1:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     2c7:	51                   	push   %ecx
     2c8:	51                   	push   %ecx
     2c9:	50                   	push   %eax
     2ca:	ff b5 f4 f7 ff ff    	pushl  -0x80c(%ebp)
     2d0:	e8 ab 0a 00 00       	call   d80 <drop>
     2d5:	83 c4 10             	add    $0x10,%esp
     2d8:	e9 13 fe ff ff       	jmp    f0 <main+0xf0>
    fprintf(2, "specify a file you want to edit\n");
     2dd:	50                   	push   %eax
     2de:	50                   	push   %eax
     2df:	68 c8 1c 00 00       	push   $0x1cc8
     2e4:	6a 02                	push   $0x2
     2e6:	e8 75 15 00 00       	call   1860 <fprintf>
    exit();
     2eb:	e8 02 12 00 00       	call   14f2 <exit>
      edit(&file, args);
     2f0:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     2f6:	56                   	push   %esi
     2f7:	56                   	push   %esi
     2f8:	50                   	push   %eax
     2f9:	ff b5 f4 f7 ff ff    	pushl  -0x80c(%ebp)
     2ff:	e8 3c 0c 00 00       	call   f40 <edit>
     304:	83 c4 10             	add    $0x10,%esp
     307:	e9 e4 fd ff ff       	jmp    f0 <main+0xf0>
    fprintf(2, "creating %s...\n",  file.filename);
     30c:	57                   	push   %edi
     30d:	ff b5 00 f8 ff ff    	pushl  -0x800(%ebp)
     313:	68 17 1b 00 00       	push   $0x1b17
     318:	6a 02                	push   $0x2
     31a:	e8 41 15 00 00       	call   1860 <fprintf>
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     31f:	58                   	pop    %eax
     320:	5a                   	pop    %edx
     321:	68 01 02 00 00       	push   $0x201
     326:	ff b5 00 f8 ff ff    	pushl  -0x800(%ebp)
     32c:	e8 01 12 00 00       	call   1532 <open>
    close(file.fd);
     331:	89 04 24             	mov    %eax,(%esp)
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     334:	89 85 04 f8 ff ff    	mov    %eax,-0x7fc(%ebp)
    close(file.fd);
     33a:	e8 db 11 00 00       	call   151a <close>
     33f:	8d 85 00 f8 ff ff    	lea    -0x800(%ebp),%eax
     345:	83 c4 10             	add    $0x10,%esp
     348:	89 85 f4 f7 ff ff    	mov    %eax,-0x80c(%ebp)
     34e:	e9 84 fd ff ff       	jmp    d7 <main+0xd7>
      list(file, args);
     353:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     359:	57                   	push   %edi
     35a:	8b b5 f4 f7 ff ff    	mov    -0x80c(%ebp),%esi
     360:	b9 06 00 00 00       	mov    $0x6,%ecx
     365:	50                   	push   %eax
     366:	83 ec 18             	sub    $0x18,%esp
     369:	89 e7                	mov    %esp,%edi
     36b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
     36d:	e8 7e 0c 00 00       	call   ff0 <list>
     372:	83 c4 20             	add    $0x20,%esp
     375:	e9 76 fd ff ff       	jmp    f0 <main+0xf0>
    else if (strcmp(cmdstr, "QUIT") == 0) {cmd = QUIT;}
     37a:	50                   	push   %eax
     37b:	50                   	push   %eax
     37c:	68 4e 1b 00 00       	push   $0x1b4e
     381:	53                   	push   %ebx
     382:	e8 49 0f 00 00       	call   12d0 <strcmp>
     387:	83 c4 10             	add    $0x10,%esp
     38a:	85 c0                	test   %eax,%eax
     38c:	74 16                	je     3a4 <main+0x3a4>
  fprintf(2, "changes saved\n");
  return;
}

void bi() {
  fprintf(2, "bad input\n");
     38e:	50                   	push   %eax
     38f:	50                   	push   %eax
     390:	68 53 1b 00 00       	push   $0x1b53
     395:	6a 02                	push   $0x2
     397:	e8 c4 14 00 00       	call   1860 <fprintf>
     39c:	83 c4 10             	add    $0x10,%esp
     39f:	e9 4c fd ff ff       	jmp    f0 <main+0xf0>
      quit(&file);
     3a4:	83 ec 0c             	sub    $0xc,%esp
     3a7:	ff b5 f4 f7 ff ff    	pushl  -0x80c(%ebp)
     3ad:	e8 ae 0d 00 00       	call   1160 <quit>
  close(file.fd);
     3b2:	58                   	pop    %eax
     3b3:	ff b5 04 f8 ff ff    	pushl  -0x7fc(%ebp)
     3b9:	e8 5c 11 00 00       	call   151a <close>
  exit();
     3be:	e8 2f 11 00 00       	call   14f2 <exit>
     3c3:	66 90                	xchg   %ax,%ax
     3c5:	66 90                	xchg   %ax,%ax
     3c7:	66 90                	xchg   %ax,%ax
     3c9:	66 90                	xchg   %ax,%ax
     3cb:	66 90                	xchg   %ax,%ax
     3cd:	66 90                	xchg   %ax,%ax
     3cf:	90                   	nop

000003d0 <safestrcpy>:
char* safestrcpy(char *s, const char *t, int n) {
     3d0:	55                   	push   %ebp
     3d1:	89 e5                	mov    %esp,%ebp
     3d3:	56                   	push   %esi
     3d4:	53                   	push   %ebx
     3d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
     3d8:	8b 45 08             	mov    0x8(%ebp),%eax
     3db:	8b 55 0c             	mov    0xc(%ebp),%edx
  if(n <= 0)
     3de:	85 c9                	test   %ecx,%ecx
     3e0:	7e 26                	jle    408 <safestrcpy+0x38>
     3e2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
     3e6:	89 c1                	mov    %eax,%ecx
     3e8:	eb 17                	jmp    401 <safestrcpy+0x31>
     3ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while(--n > 0 && (*s++ = *t++) != 0)
     3f0:	83 c2 01             	add    $0x1,%edx
     3f3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
     3f7:	83 c1 01             	add    $0x1,%ecx
     3fa:	84 db                	test   %bl,%bl
     3fc:	88 59 ff             	mov    %bl,-0x1(%ecx)
     3ff:	74 04                	je     405 <safestrcpy+0x35>
     401:	39 f2                	cmp    %esi,%edx
     403:	75 eb                	jne    3f0 <safestrcpy+0x20>
  *s = 0;
     405:	c6 01 00             	movb   $0x0,(%ecx)
}
     408:	5b                   	pop    %ebx
     409:	5e                   	pop    %esi
     40a:	5d                   	pop    %ebp
     40b:	c3                   	ret    
     40c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000410 <nullNode>:
Node* nullNode(char* data) {
     410:	55                   	push   %ebp
     411:	89 e5                	mov    %esp,%ebp
     413:	83 ec 14             	sub    $0x14,%esp
  struct Node* node = malloc(sizeof(Node));
     416:	6a 0c                	push   $0xc
     418:	e8 13 15 00 00       	call   1930 <malloc>
  node->data = data;
     41d:	8b 55 08             	mov    0x8(%ebp),%edx
  node->prev = nullptr;
     420:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->next = nullptr;
     426:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  node->data = data;
     42d:	89 50 04             	mov    %edx,0x4(%eax)
}
     430:	c9                   	leave  
     431:	c3                   	ret    
     432:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000440 <nodeAt>:
Node* nodeAt(struct LinkedList* list, int pos) {
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	53                   	push   %ebx
     444:	8b 45 08             	mov    0x8(%ebp),%eax
     447:	8b 55 0c             	mov    0xc(%ebp),%edx
  if (pos > list->len)
     44a:	8b 48 08             	mov    0x8(%eax),%ecx
     44d:	39 d1                	cmp    %edx,%ecx
     44f:	7c 1f                	jl     470 <nodeAt+0x30>
  if ((pos < 0) && ((0 - pos) > list->len))
     451:	85 d2                	test   %edx,%edx
     453:	78 2b                	js     480 <nodeAt+0x40>
    curNode = list->head->next;
     455:	8b 00                	mov    (%eax),%eax
     457:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     45a:	74 0e                	je     46a <nodeAt+0x2a>
    int cur = 0;
     45c:	31 c9                	xor    %ecx,%ecx
     45e:	66 90                	xchg   %ax,%ax
      cur++;
     460:	83 c1 01             	add    $0x1,%ecx
      curNode = curNode->next;
     463:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     466:	39 ca                	cmp    %ecx,%edx
     468:	75 f6                	jne    460 <nodeAt+0x20>
}
     46a:	5b                   	pop    %ebx
     46b:	5d                   	pop    %ebp
     46c:	c3                   	ret    
     46d:	8d 76 00             	lea    0x0(%esi),%esi
    return list->tail->prev;
     470:	8b 40 04             	mov    0x4(%eax),%eax
}
     473:	5b                   	pop    %ebx
     474:	5d                   	pop    %ebp
    return list->tail->prev;
     475:	8b 00                	mov    (%eax),%eax
}
     477:	c3                   	ret    
     478:	90                   	nop
     479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if ((pos < 0) && ((0 - pos) > list->len))
     480:	89 d3                	mov    %edx,%ebx
     482:	f7 db                	neg    %ebx
     484:	39 d9                	cmp    %ebx,%ecx
     486:	7c 18                	jl     4a0 <nodeAt+0x60>
    while (++pos != 0)
     488:	83 c2 01             	add    $0x1,%edx
    curNode = list->tail;
     48b:	8b 40 04             	mov    0x4(%eax),%eax
    while (++pos != 0)
     48e:	74 da                	je     46a <nodeAt+0x2a>
     490:	83 c2 01             	add    $0x1,%edx
      curNode = curNode->prev;
     493:	8b 00                	mov    (%eax),%eax
    while (++pos != 0)
     495:	75 f9                	jne    490 <nodeAt+0x50>
}
     497:	5b                   	pop    %ebx
     498:	5d                   	pop    %ebp
     499:	c3                   	ret    
     49a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return list->head->next;
     4a0:	8b 00                	mov    (%eax),%eax
     4a2:	8b 40 08             	mov    0x8(%eax),%eax
     4a5:	eb c3                	jmp    46a <nodeAt+0x2a>
     4a7:	89 f6                	mov    %esi,%esi
     4a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004b0 <destroyNode>:
void destroyNode(struct LinkedList* list, struct Node* self) {
     4b0:	55                   	push   %ebp
     4b1:	89 e5                	mov    %esp,%ebp
     4b3:	56                   	push   %esi
     4b4:	53                   	push   %ebx
     4b5:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     4b8:	8b 75 08             	mov    0x8(%ebp),%esi
    free(self->data);
     4bb:	83 ec 0c             	sub    $0xc,%esp
    self->prev->next = self->next;
     4be:	8b 03                	mov    (%ebx),%eax
     4c0:	8b 53 08             	mov    0x8(%ebx),%edx
     4c3:	89 50 08             	mov    %edx,0x8(%eax)
    self->next->prev = self->prev;
     4c6:	8b 43 08             	mov    0x8(%ebx),%eax
     4c9:	8b 13                	mov    (%ebx),%edx
     4cb:	89 10                	mov    %edx,(%eax)
    free(self->data);
     4cd:	ff 73 04             	pushl  0x4(%ebx)
     4d0:	e8 cb 13 00 00       	call   18a0 <free>
    free(self);
     4d5:	89 1c 24             	mov    %ebx,(%esp)
     4d8:	e8 c3 13 00 00       	call   18a0 <free>
    list->len--;
     4dd:	83 6e 08 01          	subl   $0x1,0x8(%esi)
}
     4e1:	83 c4 10             	add    $0x10,%esp
     4e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     4e7:	5b                   	pop    %ebx
     4e8:	5e                   	pop    %esi
     4e9:	5d                   	pop    %ebp
     4ea:	c3                   	ret    
     4eb:	90                   	nop
     4ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004f0 <MakeLinkedList>:
LinkedList* MakeLinkedList() {
     4f0:	55                   	push   %ebp
     4f1:	89 e5                	mov    %esp,%ebp
     4f3:	56                   	push   %esi
     4f4:	53                   	push   %ebx
  struct LinkedList* list = malloc(sizeof(LinkedList));
     4f5:	83 ec 0c             	sub    $0xc,%esp
     4f8:	6a 0c                	push   $0xc
     4fa:	e8 31 14 00 00       	call   1930 <malloc>
  struct Node* node = malloc(sizeof(Node));
     4ff:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  struct LinkedList* list = malloc(sizeof(LinkedList));
     506:	89 c6                	mov    %eax,%esi
  struct Node* node = malloc(sizeof(Node));
     508:	e8 23 14 00 00       	call   1930 <malloc>
     50d:	89 c3                	mov    %eax,%ebx
  node->prev = nullptr;
     50f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->data = data;
     515:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  node->next = nullptr;
     51c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  struct Node* node = malloc(sizeof(Node));
     523:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     52a:	e8 01 14 00 00       	call   1930 <malloc>
  node->data = data;
     52f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  head->next = tail;
     536:	89 43 08             	mov    %eax,0x8(%ebx)
  head->prev = nullptr;
     539:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  tail->prev = head;
     53f:	89 18                	mov    %ebx,(%eax)
  tail->next = nullptr;
     541:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  list->tail = tail;
     548:	89 46 04             	mov    %eax,0x4(%esi)
}
     54b:	89 f0                	mov    %esi,%eax
  list->len = 0;
     54d:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
  list->head = head;
     554:	89 1e                	mov    %ebx,(%esi)
}
     556:	8d 65 f8             	lea    -0x8(%ebp),%esp
     559:	5b                   	pop    %ebx
     55a:	5e                   	pop    %esi
     55b:	5d                   	pop    %ebp
     55c:	c3                   	ret    
     55d:	8d 76 00             	lea    0x0(%esi),%esi

00000560 <insert>:
void insert(struct LinkedList* list, char* data, int pos) {
     560:	55                   	push   %ebp
     561:	89 e5                	mov    %esp,%ebp
     563:	57                   	push   %edi
     564:	56                   	push   %esi
     565:	53                   	push   %ebx
     566:	83 ec 0c             	sub    $0xc,%esp
  struct Node* atPos = nodeAt(list, pos);
     569:	ff 75 10             	pushl  0x10(%ebp)
     56c:	ff 75 08             	pushl  0x8(%ebp)
void insert(struct LinkedList* list, char* data, int pos) {
     56f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct Node* atPos = nodeAt(list, pos);
     572:	e8 c9 fe ff ff       	call   440 <nodeAt>
     577:	83 ec 04             	sub    $0x4,%esp
     57a:	89 c6                	mov    %eax,%esi
  char* newData = (char*)malloc(sizeof(char) * 1000);
     57c:	68 e8 03 00 00       	push   $0x3e8
     581:	e8 aa 13 00 00       	call   1930 <malloc>
     586:	8d 8b e7 03 00 00    	lea    0x3e7(%ebx),%ecx
     58c:	89 c7                	mov    %eax,%edi
     58e:	83 c4 10             	add    $0x10,%esp
     591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(--n > 0 && (*s++ = *t++) != 0)
     598:	83 c3 01             	add    $0x1,%ebx
     59b:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     59f:	83 c0 01             	add    $0x1,%eax
     5a2:	84 d2                	test   %dl,%dl
     5a4:	88 50 ff             	mov    %dl,-0x1(%eax)
     5a7:	74 04                	je     5ad <insert+0x4d>
     5a9:	39 d9                	cmp    %ebx,%ecx
     5ab:	75 eb                	jne    598 <insert+0x38>
  struct Node* new = malloc(sizeof(Node));
     5ad:	83 ec 0c             	sub    $0xc,%esp
  *s = 0;
     5b0:	c6 00 00             	movb   $0x0,(%eax)
  struct Node* new = malloc(sizeof(Node));
     5b3:	6a 0c                	push   $0xc
     5b5:	e8 76 13 00 00       	call   1930 <malloc>
  new->data = newData;
     5ba:	89 78 04             	mov    %edi,0x4(%eax)
  new->prev = atPos->prev;
     5bd:	8b 16                	mov    (%esi),%edx
  new->next = atPos;
     5bf:	89 70 08             	mov    %esi,0x8(%eax)
  new->prev = atPos->prev;
     5c2:	89 10                	mov    %edx,(%eax)
  new->prev->next = new;
     5c4:	89 42 08             	mov    %eax,0x8(%edx)
  atPos->prev = new;
     5c7:	89 06                	mov    %eax,(%esi)
  list->len++;
     5c9:	8b 45 08             	mov    0x8(%ebp),%eax
     5cc:	83 40 08 01          	addl   $0x1,0x8(%eax)
}
     5d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5d3:	5b                   	pop    %ebx
     5d4:	5e                   	pop    %esi
     5d5:	5f                   	pop    %edi
     5d6:	5d                   	pop    %ebp
     5d7:	c3                   	ret    
     5d8:	90                   	nop
     5d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005e0 <prepend>:
void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
     5e0:	55                   	push   %ebp
     5e1:	89 e5                	mov    %esp,%ebp
     5e3:	83 ec 0c             	sub    $0xc,%esp
     5e6:	6a 00                	push   $0x0
     5e8:	ff 75 0c             	pushl  0xc(%ebp)
     5eb:	ff 75 08             	pushl  0x8(%ebp)
     5ee:	e8 6d ff ff ff       	call   560 <insert>
     5f3:	83 c4 10             	add    $0x10,%esp
     5f6:	c9                   	leave  
     5f7:	c3                   	ret    
     5f8:	90                   	nop
     5f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000600 <append>:
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     600:	55                   	push   %ebp
     601:	89 e5                	mov    %esp,%ebp
     603:	83 ec 0c             	sub    $0xc,%esp
     606:	8b 45 08             	mov    0x8(%ebp),%eax
     609:	ff 70 08             	pushl  0x8(%eax)
     60c:	ff 75 0c             	pushl  0xc(%ebp)
     60f:	50                   	push   %eax
     610:	e8 4b ff ff ff       	call   560 <insert>
     615:	83 c4 10             	add    $0x10,%esp
     618:	c9                   	leave  
     619:	c3                   	ret    
     61a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000620 <destroyLinkedList>:

void destroyLinkedList(struct LinkedList* list) {
     620:	55                   	push   %ebp
     621:	89 e5                	mov    %esp,%ebp
     623:	56                   	push   %esi
     624:	53                   	push   %ebx
     625:	8b 75 08             	mov    0x8(%ebp),%esi
  struct Node* curNode = list->head;
     628:	8b 1e                	mov    (%esi),%ebx
  while (curNode != list->tail) {
     62a:	8b 46 04             	mov    0x4(%esi),%eax
     62d:	39 c3                	cmp    %eax,%ebx
     62f:	74 29                	je     65a <destroyLinkedList+0x3a>
     631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
     638:	8b 5b 08             	mov    0x8(%ebx),%ebx
    free(curNode->prev->data);
     63b:	83 ec 0c             	sub    $0xc,%esp
     63e:	8b 03                	mov    (%ebx),%eax
     640:	ff 70 04             	pushl  0x4(%eax)
     643:	e8 58 12 00 00       	call   18a0 <free>
    free(curNode->prev);
     648:	58                   	pop    %eax
     649:	ff 33                	pushl  (%ebx)
     64b:	e8 50 12 00 00       	call   18a0 <free>
  while (curNode != list->tail) {
     650:	8b 46 04             	mov    0x4(%esi),%eax
     653:	83 c4 10             	add    $0x10,%esp
     656:	39 d8                	cmp    %ebx,%eax
     658:	75 de                	jne    638 <destroyLinkedList+0x18>
  }
  free(curNode);
     65a:	83 ec 0c             	sub    $0xc,%esp
     65d:	50                   	push   %eax
     65e:	e8 3d 12 00 00       	call   18a0 <free>
  free(list);
     663:	89 75 08             	mov    %esi,0x8(%ebp)
     666:	83 c4 10             	add    $0x10,%esp
     669:	8d 65 f8             	lea    -0x8(%ebp),%esp
     66c:	5b                   	pop    %ebx
     66d:	5e                   	pop    %esi
     66e:	5d                   	pop    %ebp
  free(list);
     66f:	e9 2c 12 00 00       	jmp    18a0 <free>
     674:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     67a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000680 <confirmation>:
int confirmation() {
     680:	55                   	push   %ebp
     681:	89 e5                	mov    %esp,%ebp
     683:	53                   	push   %ebx
  memset(buf, 0, nbuf);
     684:	8d 9d 10 fc ff ff    	lea    -0x3f0(%ebp),%ebx
int confirmation() {
     68a:	81 ec f8 03 00 00    	sub    $0x3f8,%esp
  memset(buf, 0, nbuf);
     690:	68 e8 03 00 00       	push   $0x3e8
     695:	6a 00                	push   $0x0
     697:	53                   	push   %ebx
     698:	e8 b3 0c 00 00       	call   1350 <memset>
  gets(buf, nbuf);
     69d:	58                   	pop    %eax
     69e:	5a                   	pop    %edx
     69f:	68 e8 03 00 00       	push   $0x3e8
     6a4:	53                   	push   %ebx
     6a5:	e8 06 0d 00 00       	call   13b0 <gets>
  switch (buf[0]) {
     6aa:	0f b6 85 10 fc ff ff 	movzbl -0x3f0(%ebp),%eax
     6b1:	83 c4 10             	add    $0x10,%esp
     6b4:	3c 59                	cmp    $0x59,%al
     6b6:	74 18                	je     6d0 <confirmation+0x50>
     6b8:	3c 79                	cmp    $0x79,%al
     6ba:	74 14                	je     6d0 <confirmation+0x50>
    return 1;
     6bc:	b8 01 00 00 00       	mov    $0x1,%eax
}
     6c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     6c4:	c9                   	leave  
     6c5:	c3                   	ret    
     6c6:	8d 76 00             	lea    0x0(%esi),%esi
     6c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return 0;
     6d0:	31 c0                	xor    %eax,%eax
}
     6d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     6d5:	c9                   	leave  
     6d6:	c3                   	ret    
     6d7:	89 f6                	mov    %esi,%esi
     6d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006e0 <normalizeRange>:
int normalizeRange(File file, int* sp, int* ep) {
     6e0:	55                   	push   %ebp
     6e1:	89 e5                	mov    %esp,%ebp
     6e3:	53                   	push   %ebx
     6e4:	8b 4d 24             	mov    0x24(%ebp),%ecx
  int l = file.len;
     6e7:	8b 45 18             	mov    0x18(%ebp),%eax
int normalizeRange(File file, int* sp, int* ep) {
     6ea:	8b 5d 20             	mov    0x20(%ebp),%ebx
  if (*ep > l) *ep = l;
     6ed:	8b 11                	mov    (%ecx),%edx
     6ef:	39 c2                	cmp    %eax,%edx
     6f1:	7e 45                	jle    738 <normalizeRange+0x58>
     6f3:	89 01                	mov    %eax,(%ecx)
     6f5:	89 c2                	mov    %eax,%edx
  if (*ep < 1) *ep = 1;
     6f7:	85 d2                	test   %edx,%edx
     6f9:	7f 06                	jg     701 <normalizeRange+0x21>
     6fb:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)
  if (*sp > l) *sp = l;
     701:	8b 13                	mov    (%ebx),%edx
     703:	39 c2                	cmp    %eax,%edx
     705:	7e 21                	jle    728 <normalizeRange+0x48>
     707:	89 03                	mov    %eax,(%ebx)
     709:	89 c2                	mov    %eax,%edx
  if (*sp < 1) *sp = 1;
     70b:	85 d2                	test   %edx,%edx
     70d:	7f 0b                	jg     71a <normalizeRange+0x3a>
     70f:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
     715:	ba 01 00 00 00       	mov    $0x1,%edx
  if ((*ep - *sp) < 0)
     71a:	8b 01                	mov    (%ecx),%eax
}
     71c:	5b                   	pop    %ebx
     71d:	5d                   	pop    %ebp
  if ((*ep - *sp) < 0)
     71e:	29 d0                	sub    %edx,%eax
     720:	c1 e8 1f             	shr    $0x1f,%eax
}
     723:	c3                   	ret    
     724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*sp < 1) *sp += l + 1;
     728:	85 d2                	test   %edx,%edx
     72a:	7f ee                	jg     71a <normalizeRange+0x3a>
     72c:	8d 54 10 01          	lea    0x1(%eax,%edx,1),%edx
     730:	89 13                	mov    %edx,(%ebx)
     732:	eb d7                	jmp    70b <normalizeRange+0x2b>
     734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*ep < 1) *ep += l + 1;
     738:	85 d2                	test   %edx,%edx
     73a:	7f c5                	jg     701 <normalizeRange+0x21>
     73c:	8d 54 02 01          	lea    0x1(%edx,%eax,1),%edx
     740:	89 11                	mov    %edx,(%ecx)
     742:	eb b3                	jmp    6f7 <normalizeRange+0x17>
     744:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     74a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000750 <numLines>:
int numLines(int start, int end) {
     750:	55                   	push   %ebp
     751:	89 e5                	mov    %esp,%ebp
  return (end - start) + 1;
     753:	8b 45 0c             	mov    0xc(%ebp),%eax
     756:	2b 45 08             	sub    0x8(%ebp),%eax
}
     759:	5d                   	pop    %ebp
  return (end - start) + 1;
     75a:	83 c0 01             	add    $0x1,%eax
}
     75d:	c3                   	ret    
     75e:	66 90                	xchg   %ax,%ax

00000760 <getLine>:
int getLine(int fileptr, char line[]) {
     760:	55                   	push   %ebp
     761:	89 e5                	mov    %esp,%ebp
     763:	57                   	push   %edi
     764:	56                   	push   %esi
     765:	53                   	push   %ebx
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     766:	31 ff                	xor    %edi,%edi
     768:	8d 75 e7             	lea    -0x19(%ebp),%esi
int getLine(int fileptr, char line[]) {
     76b:	83 ec 28             	sub    $0x28,%esp
     76e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int len = strlen(line);
     771:	53                   	push   %ebx
     772:	e8 a9 0b 00 00       	call   1320 <strlen>
  memset(line, 0, len);
     777:	83 c4 0c             	add    $0xc,%esp
     77a:	50                   	push   %eax
     77b:	6a 00                	push   $0x0
     77d:	53                   	push   %ebx
     77e:	e8 cd 0b 00 00       	call   1350 <memset>
     783:	83 c4 10             	add    $0x10,%esp
     786:	eb 1e                	jmp    7a6 <getLine+0x46>
     788:	90                   	nop
     789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (*c == '\n') break;
     790:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     794:	3c 0a                	cmp    $0xa,%al
     796:	74 38                	je     7d0 <getLine+0x70>
    line[i] = *c;
     798:	88 04 3b             	mov    %al,(%ebx,%edi,1)
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     79b:	83 c7 01             	add    $0x1,%edi
     79e:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
     7a4:	74 42                	je     7e8 <getLine+0x88>
    if (read(fileptr, c, 1) == 0) return strlen(line);
     7a6:	83 ec 04             	sub    $0x4,%esp
     7a9:	6a 01                	push   $0x1
     7ab:	56                   	push   %esi
     7ac:	ff 75 08             	pushl  0x8(%ebp)
     7af:	e8 56 0d 00 00       	call   150a <read>
     7b4:	83 c4 10             	add    $0x10,%esp
     7b7:	85 c0                	test   %eax,%eax
     7b9:	75 d5                	jne    790 <getLine+0x30>
     7bb:	83 ec 0c             	sub    $0xc,%esp
     7be:	53                   	push   %ebx
     7bf:	e8 5c 0b 00 00       	call   1320 <strlen>
     7c4:	83 c4 10             	add    $0x10,%esp
}
     7c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7ca:	5b                   	pop    %ebx
     7cb:	5e                   	pop    %esi
     7cc:	5f                   	pop    %edi
     7cd:	5d                   	pop    %ebp
     7ce:	c3                   	ret    
     7cf:	90                   	nop
     7d0:	8d 57 01             	lea    0x1(%edi),%edx
  line[i + 1] = '\0';
     7d3:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
     7d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
     7da:	b8 01 00 00 00       	mov    $0x1,%eax
}
     7df:	5b                   	pop    %ebx
     7e0:	5e                   	pop    %esi
     7e1:	5f                   	pop    %edi
     7e2:	5d                   	pop    %ebp
     7e3:	c3                   	ret    
     7e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     7e8:	ba e8 03 00 00       	mov    $0x3e8,%edx
     7ed:	eb e4                	jmp    7d3 <getLine+0x73>
     7ef:	90                   	nop

000007f0 <gatherLines>:
void gatherLines(File* file) {
     7f0:	55                   	push   %ebp
     7f1:	89 e5                	mov    %esp,%ebp
     7f3:	56                   	push   %esi
     7f4:	53                   	push   %ebx
     7f5:	8d b5 10 fc ff ff    	lea    -0x3f0(%ebp),%esi
     7fb:	81 ec f0 03 00 00    	sub    $0x3f0,%esp
     801:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while (getLine(file->fd, line)) {
     804:	eb 21                	jmp    827 <gatherLines+0x37>
     806:	8d 76 00             	lea    0x0(%esi),%esi
     809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    append(file->lines, line);
     810:	8b 43 0c             	mov    0xc(%ebx),%eax
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     813:	83 ec 04             	sub    $0x4,%esp
     816:	ff 70 08             	pushl  0x8(%eax)
     819:	56                   	push   %esi
     81a:	50                   	push   %eax
     81b:	e8 40 fd ff ff       	call   560 <insert>
    file->len++;
     820:	83 43 10 01          	addl   $0x1,0x10(%ebx)
     824:	83 c4 10             	add    $0x10,%esp
  while (getLine(file->fd, line)) {
     827:	83 ec 08             	sub    $0x8,%esp
     82a:	56                   	push   %esi
     82b:	ff 73 04             	pushl  0x4(%ebx)
     82e:	e8 2d ff ff ff       	call   760 <getLine>
     833:	83 c4 10             	add    $0x10,%esp
     836:	85 c0                	test   %eax,%eax
     838:	75 d6                	jne    810 <gatherLines+0x20>
  fprintf(2, "%d lines read from %s\n", file->len, file->filename);
     83a:	ff 33                	pushl  (%ebx)
     83c:	ff 73 10             	pushl  0x10(%ebx)
     83f:	68 28 1a 00 00       	push   $0x1a28
     844:	6a 02                	push   $0x2
     846:	e8 15 10 00 00       	call   1860 <fprintf>
}
     84b:	83 c4 10             	add    $0x10,%esp
     84e:	8d 65 f8             	lea    -0x8(%ebp),%esp
     851:	5b                   	pop    %ebx
     852:	5e                   	pop    %esi
     853:	5d                   	pop    %ebp
     854:	c3                   	ret    
     855:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000860 <unline>:
void unline(char* str) {
     860:	55                   	push   %ebp
     861:	89 e5                	mov    %esp,%ebp
     863:	53                   	push   %ebx
     864:	83 ec 10             	sub    $0x10,%esp
     867:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str) - 1;
     86a:	53                   	push   %ebx
     86b:	e8 b0 0a 00 00       	call   1320 <strlen>
     870:	8d 50 ff             	lea    -0x1(%eax),%edx
  for (; len > 0; len--) {
     873:	83 c4 10             	add    $0x10,%esp
     876:	85 d2                	test   %edx,%edx
     878:	7e 36                	jle    8b0 <unline+0x50>
    if (c == '\n')
     87a:	80 7c 03 ff 0a       	cmpb   $0xa,-0x1(%ebx,%eax,1)
     87f:	74 2f                	je     8b0 <unline+0x50>
     881:	8d 44 03 fe          	lea    -0x2(%ebx,%eax,1),%eax
     885:	eb 12                	jmp    899 <unline+0x39>
     887:	89 f6                	mov    %esi,%esi
     889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     890:	83 e8 01             	sub    $0x1,%eax
     893:	80 78 01 0a          	cmpb   $0xa,0x1(%eax)
     897:	74 06                	je     89f <unline+0x3f>
  for (; len > 0; len--) {
     899:	39 c3                	cmp    %eax,%ebx
     89b:	89 c2                	mov    %eax,%edx
     89d:	75 f1                	jne    890 <unline+0x30>
  str[len] = '\0';
     89f:	c6 02 00             	movb   $0x0,(%edx)
}
     8a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8a5:	c9                   	leave  
     8a6:	c3                   	ret    
     8a7:	89 f6                	mov    %esi,%esi
     8a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     8b0:	01 da                	add    %ebx,%edx
  str[len] = '\0';
     8b2:	c6 02 00             	movb   $0x0,(%edx)
}
     8b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8b8:	c9                   	leave  
     8b9:	c3                   	ret    
     8ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000008c0 <find>:
int find(char* str, char c) {
     8c0:	55                   	push   %ebp
     8c1:	89 e5                	mov    %esp,%ebp
     8c3:	57                   	push   %edi
     8c4:	56                   	push   %esi
     8c5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     8c6:	31 db                	xor    %ebx,%ebx
int find(char* str, char c) {
     8c8:	83 ec 0c             	sub    $0xc,%esp
     8cb:	8b 75 08             	mov    0x8(%ebp),%esi
     8ce:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
  for (int i = 0; i < strlen(str); i++)
     8d2:	eb 0e                	jmp    8e2 <find+0x22>
     8d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     8d8:	89 f8                	mov    %edi,%eax
     8da:	38 04 1e             	cmp    %al,(%esi,%ebx,1)
     8dd:	74 18                	je     8f7 <find+0x37>
  for (int i = 0; i < strlen(str); i++)
     8df:	83 c3 01             	add    $0x1,%ebx
     8e2:	83 ec 0c             	sub    $0xc,%esp
     8e5:	56                   	push   %esi
     8e6:	e8 35 0a 00 00       	call   1320 <strlen>
     8eb:	83 c4 10             	add    $0x10,%esp
     8ee:	39 d8                	cmp    %ebx,%eax
     8f0:	77 e6                	ja     8d8 <find+0x18>
  return -1;
     8f2:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
     8f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8fa:	89 d8                	mov    %ebx,%eax
     8fc:	5b                   	pop    %ebx
     8fd:	5e                   	pop    %esi
     8fe:	5f                   	pop    %edi
     8ff:	5d                   	pop    %ebp
     900:	c3                   	ret    
     901:	eb 0d                	jmp    910 <substr>
     903:	90                   	nop
     904:	90                   	nop
     905:	90                   	nop
     906:	90                   	nop
     907:	90                   	nop
     908:	90                   	nop
     909:	90                   	nop
     90a:	90                   	nop
     90b:	90                   	nop
     90c:	90                   	nop
     90d:	90                   	nop
     90e:	90                   	nop
     90f:	90                   	nop

00000910 <substr>:
void substr(char* dest, char* str, int start, int end) {
     910:	55                   	push   %ebp
     911:	89 e5                	mov    %esp,%ebp
     913:	57                   	push   %edi
     914:	56                   	push   %esi
     915:	53                   	push   %ebx
     916:	83 ec 18             	sub    $0x18,%esp
     919:	8b 7d 14             	mov    0x14(%ebp),%edi
  int len = strlen(str);
     91c:	ff 75 0c             	pushl  0xc(%ebp)
void substr(char* dest, char* str, int start, int end) {
     91f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     922:	8b 75 08             	mov    0x8(%ebp),%esi
  int len = strlen(str);
     925:	e8 f6 09 00 00       	call   1320 <strlen>
     92a:	83 c4 10             	add    $0x10,%esp
     92d:	39 f8                	cmp    %edi,%eax
     92f:	0f 4e f8             	cmovle %eax,%edi
  while (i < end)
     932:	39 df                	cmp    %ebx,%edi
     934:	7e 1c                	jle    952 <substr+0x42>
     936:	8b 45 0c             	mov    0xc(%ebp),%eax
     939:	29 df                	sub    %ebx,%edi
  int s = 0, i = start;
     93b:	31 d2                	xor    %edx,%edx
     93d:	01 c3                	add    %eax,%ebx
     93f:	90                   	nop
    dest[s++] = str[i++];
     940:	83 c2 01             	add    $0x1,%edx
     943:	0f b6 44 13 ff       	movzbl -0x1(%ebx,%edx,1),%eax
  while (i < end)
     948:	39 fa                	cmp    %edi,%edx
    dest[s++] = str[i++];
     94a:	88 44 16 ff          	mov    %al,-0x1(%esi,%edx,1)
  while (i < end)
     94e:	75 f0                	jne    940 <substr+0x30>
     950:	01 d6                	add    %edx,%esi
  dest[s] = '\0';
     952:	c6 06 00             	movb   $0x0,(%esi)
}
     955:	8d 65 f4             	lea    -0xc(%ebp),%esp
     958:	5b                   	pop    %ebx
     959:	5e                   	pop    %esi
     95a:	5f                   	pop    %edi
     95b:	5d                   	pop    %ebp
     95c:	c3                   	ret    
     95d:	8d 76 00             	lea    0x0(%esi),%esi

00000960 <getArg>:
void getArg(char* dest, char* args, char delimiter) {
     960:	55                   	push   %ebp
     961:	89 e5                	mov    %esp,%ebp
     963:	57                   	push   %edi
     964:	56                   	push   %esi
     965:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     966:	31 db                	xor    %ebx,%ebx
void getArg(char* dest, char* args, char delimiter) {
     968:	83 ec 1c             	sub    $0x1c,%esp
     96b:	8b 75 0c             	mov    0xc(%ebp),%esi
     96e:	0f b6 7d 10          	movzbl 0x10(%ebp),%edi
     972:	eb 10                	jmp    984 <getArg+0x24>
     974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     978:	89 f8                	mov    %edi,%eax
     97a:	3a 04 1e             	cmp    (%esi,%ebx,1),%al
     97d:	8d 53 01             	lea    0x1(%ebx),%edx
     980:	74 19                	je     99b <getArg+0x3b>
     982:	89 d3                	mov    %edx,%ebx
  for (int i = 0; i < strlen(str); i++)
     984:	83 ec 0c             	sub    $0xc,%esp
     987:	56                   	push   %esi
     988:	e8 93 09 00 00       	call   1320 <strlen>
     98d:	83 c4 10             	add    $0x10,%esp
     990:	39 c3                	cmp    %eax,%ebx
     992:	72 e4                	jb     978 <getArg+0x18>
     994:	31 d2                	xor    %edx,%edx
  return -1;
     996:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  substr(dest, args, 0, end);
     99b:	53                   	push   %ebx
     99c:	6a 00                	push   $0x0
     99e:	56                   	push   %esi
     99f:	ff 75 08             	pushl  0x8(%ebp)
     9a2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     9a5:	e8 66 ff ff ff       	call   910 <substr>
  substr(args, args, end + 1, (int) strlen(args));
     9aa:	89 34 24             	mov    %esi,(%esp)
     9ad:	e8 6e 09 00 00       	call   1320 <strlen>
     9b2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     9b5:	50                   	push   %eax
     9b6:	52                   	push   %edx
     9b7:	56                   	push   %esi
     9b8:	56                   	push   %esi
     9b9:	e8 52 ff ff ff       	call   910 <substr>
}
     9be:	83 c4 20             	add    $0x20,%esp
     9c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9c4:	5b                   	pop    %ebx
     9c5:	5e                   	pop    %esi
     9c6:	5f                   	pop    %edi
     9c7:	5d                   	pop    %ebp
     9c8:	c3                   	ret    
     9c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000009d0 <collectRange>:
int collectRange(char* args, int* startptr, int* endptr) {
     9d0:	55                   	push   %ebp
     9d1:	89 e5                	mov    %esp,%ebp
     9d3:	57                   	push   %edi
     9d4:	56                   	push   %esi
     9d5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     9d6:	31 f6                	xor    %esi,%esi
int collectRange(char* args, int* startptr, int* endptr) {
     9d8:	83 ec 2c             	sub    $0x2c,%esp
     9db:	8b 5d 08             	mov    0x8(%ebp),%ebx
     9de:	eb 09                	jmp    9e9 <collectRange+0x19>
    if (str[i] == c) return i;
     9e0:	80 3c 33 3a          	cmpb   $0x3a,(%ebx,%esi,1)
     9e4:	74 42                	je     a28 <collectRange+0x58>
  for (int i = 0; i < strlen(str); i++)
     9e6:	83 c6 01             	add    $0x1,%esi
     9e9:	83 ec 0c             	sub    $0xc,%esp
     9ec:	53                   	push   %ebx
     9ed:	e8 2e 09 00 00       	call   1320 <strlen>
     9f2:	83 c4 10             	add    $0x10,%esp
     9f5:	39 c6                	cmp    %eax,%esi
     9f7:	72 e7                	jb     9e0 <collectRange+0x10>
    if (args[0] == '-') {
     9f9:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     9fc:	0f 84 d6 00 00 00    	je     ad8 <collectRange+0x108>
      *startptr = atoi(args);
     a02:	83 ec 0c             	sub    $0xc,%esp
     a05:	53                   	push   %ebx
     a06:	e8 75 0a 00 00       	call   1480 <atoi>
     a0b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     a0e:	83 c4 10             	add    $0x10,%esp
     a11:	89 01                	mov    %eax,(%ecx)
    *endptr = *startptr;
     a13:	8b 4d 10             	mov    0x10(%ebp),%ecx
     a16:	89 01                	mov    %eax,(%ecx)
    return 0;
     a18:	31 c0                	xor    %eax,%eax
}
     a1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a1d:	5b                   	pop    %ebx
     a1e:	5e                   	pop    %esi
     a1f:	5f                   	pop    %edi
     a20:	5d                   	pop    %ebp
     a21:	c3                   	ret    
     a22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  getArg(startstr, args, ':');
     a28:	8d 75 de             	lea    -0x22(%ebp),%esi
     a2b:	83 ec 04             	sub    $0x4,%esp
     a2e:	6a 3a                	push   $0x3a
     a30:	53                   	push   %ebx
     a31:	56                   	push   %esi
     a32:	e8 29 ff ff ff       	call   960 <getArg>
  if (startstr[0] == '-') {
     a37:	83 c4 10             	add    $0x10,%esp
     a3a:	80 7d de 2d          	cmpb   $0x2d,-0x22(%ebp)
     a3e:	0f 84 3c 01 00 00    	je     b80 <collectRange+0x1b0>
  int negStartFlag = 0, negEndFlag = 0;
     a44:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     a4b:	31 ff                	xor    %edi,%edi
  if (endstr[0] == '-') {
     a4d:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     a50:	0f 84 0a 01 00 00    	je     b60 <collectRange+0x190>
  if (strcmp(startstr, "\0") == 0) *startptr = 1;
     a56:	83 ec 08             	sub    $0x8,%esp
     a59:	68 5e 1b 00 00       	push   $0x1b5e
     a5e:	56                   	push   %esi
     a5f:	e8 6c 08 00 00       	call   12d0 <strcmp>
     a64:	83 c4 10             	add    $0x10,%esp
     a67:	85 c0                	test   %eax,%eax
     a69:	0f 85 d1 00 00 00    	jne    b40 <collectRange+0x170>
     a6f:	8b 45 0c             	mov    0xc(%ebp),%eax
     a72:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  if (strcmp(endstr, "\0") == 0) *endptr = -1;
     a78:	83 ec 08             	sub    $0x8,%esp
     a7b:	68 5e 1b 00 00       	push   $0x1b5e
     a80:	53                   	push   %ebx
     a81:	e8 4a 08 00 00       	call   12d0 <strcmp>
     a86:	83 c4 10             	add    $0x10,%esp
     a89:	85 c0                	test   %eax,%eax
     a8b:	0f 85 97 00 00 00    	jne    b28 <collectRange+0x158>
     a91:	8b 45 10             	mov    0x10(%ebp),%eax
     a94:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  if (negStartFlag) *startptr = 0 - *startptr;
     a9a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     a9d:	85 c0                	test   %eax,%eax
     a9f:	74 05                	je     aa6 <collectRange+0xd6>
     aa1:	8b 45 0c             	mov    0xc(%ebp),%eax
     aa4:	f7 18                	negl   (%eax)
  if (negEndFlag) *endptr = 0 - *endptr;
     aa6:	85 ff                	test   %edi,%edi
     aa8:	74 05                	je     aaf <collectRange+0xdf>
     aaa:	8b 45 10             	mov    0x10(%ebp),%eax
     aad:	f7 18                	negl   (%eax)
  if (((*startptr > 0 && *endptr > 0) || 
     aaf:	8b 45 0c             	mov    0xc(%ebp),%eax
     ab2:	8b 00                	mov    (%eax),%eax
     ab4:	83 f8 00             	cmp    $0x0,%eax
     ab7:	7e 4f                	jle    b08 <collectRange+0x138>
     ab9:	8b 55 10             	mov    0x10(%ebp),%edx
     abc:	8b 12                	mov    (%edx),%edx
     abe:	85 d2                	test   %edx,%edx
     ac0:	7e 55                	jle    b17 <collectRange+0x147>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     ac2:	39 d0                	cmp    %edx,%eax
     ac4:	0f 9f c0             	setg   %al
}
     ac7:	8d 65 f4             	lea    -0xc(%ebp),%esp
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     aca:	0f b6 c0             	movzbl %al,%eax
}
     acd:	5b                   	pop    %ebx
     ace:	5e                   	pop    %esi
     acf:	5f                   	pop    %edi
     ad0:	5d                   	pop    %ebp
     ad1:	c3                   	ret    
     ad2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      substr(args, args, 1, strlen(args));
     ad8:	83 ec 0c             	sub    $0xc,%esp
     adb:	53                   	push   %ebx
     adc:	e8 3f 08 00 00       	call   1320 <strlen>
     ae1:	50                   	push   %eax
     ae2:	6a 01                	push   $0x1
     ae4:	53                   	push   %ebx
     ae5:	53                   	push   %ebx
     ae6:	e8 25 fe ff ff       	call   910 <substr>
      *startptr = 0 - atoi(args);
     aeb:	83 c4 14             	add    $0x14,%esp
     aee:	53                   	push   %ebx
     aef:	e8 8c 09 00 00       	call   1480 <atoi>
     af4:	8b 7d 0c             	mov    0xc(%ebp),%edi
     af7:	f7 d8                	neg    %eax
     af9:	83 c4 10             	add    $0x10,%esp
     afc:	89 07                	mov    %eax,(%edi)
     afe:	e9 10 ff ff ff       	jmp    a13 <collectRange+0x43>
     b03:	90                   	nop
     b04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (((*startptr > 0 && *endptr > 0) || 
     b08:	0f 84 0c ff ff ff    	je     a1a <collectRange+0x4a>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     b0e:	8b 7d 10             	mov    0x10(%ebp),%edi
     b11:	8b 17                	mov    (%edi),%edx
     b13:	85 d2                	test   %edx,%edx
     b15:	78 ab                	js     ac2 <collectRange+0xf2>
}
     b17:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
     b1a:	31 c0                	xor    %eax,%eax
}
     b1c:	5b                   	pop    %ebx
     b1d:	5e                   	pop    %esi
     b1e:	5f                   	pop    %edi
     b1f:	5d                   	pop    %ebp
     b20:	c3                   	ret    
     b21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else *endptr = atoi(endstr);
     b28:	83 ec 0c             	sub    $0xc,%esp
     b2b:	53                   	push   %ebx
     b2c:	e8 4f 09 00 00       	call   1480 <atoi>
     b31:	8b 55 10             	mov    0x10(%ebp),%edx
     b34:	83 c4 10             	add    $0x10,%esp
     b37:	89 02                	mov    %eax,(%edx)
     b39:	e9 5c ff ff ff       	jmp    a9a <collectRange+0xca>
     b3e:	66 90                	xchg   %ax,%ax
  else *startptr = atoi(startstr);
     b40:	83 ec 0c             	sub    $0xc,%esp
     b43:	56                   	push   %esi
     b44:	e8 37 09 00 00       	call   1480 <atoi>
     b49:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     b4c:	83 c4 10             	add    $0x10,%esp
     b4f:	89 01                	mov    %eax,(%ecx)
     b51:	e9 22 ff ff ff       	jmp    a78 <collectRange+0xa8>
     b56:	8d 76 00             	lea    0x0(%esi),%esi
     b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    substr(endstr, endstr, 1, strlen(endstr));
     b60:	83 ec 0c             	sub    $0xc,%esp
    negEndFlag = 1;
     b63:	bf 01 00 00 00       	mov    $0x1,%edi
    substr(endstr, endstr, 1, strlen(endstr));
     b68:	53                   	push   %ebx
     b69:	e8 b2 07 00 00       	call   1320 <strlen>
     b6e:	50                   	push   %eax
     b6f:	6a 01                	push   $0x1
     b71:	53                   	push   %ebx
     b72:	53                   	push   %ebx
     b73:	e8 98 fd ff ff       	call   910 <substr>
     b78:	83 c4 20             	add    $0x20,%esp
     b7b:	e9 d6 fe ff ff       	jmp    a56 <collectRange+0x86>
    substr(startstr, startstr, 1, strlen(startstr));
     b80:	83 ec 0c             	sub    $0xc,%esp
     b83:	56                   	push   %esi
     b84:	e8 97 07 00 00       	call   1320 <strlen>
     b89:	50                   	push   %eax
     b8a:	6a 01                	push   $0x1
     b8c:	56                   	push   %esi
     b8d:	56                   	push   %esi
     b8e:	e8 7d fd ff ff       	call   910 <substr>
     b93:	83 c4 20             	add    $0x20,%esp
    negStartFlag = 1;
     b96:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
     b9d:	e9 a9 fe ff ff       	jmp    a4b <collectRange+0x7b>
     ba2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bb0 <negatoi>:
int negatoi(char* str) {
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	53                   	push   %ebx
     bb4:	83 ec 04             	sub    $0x4,%esp
     bb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (str[0] == '-') {
     bba:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     bbd:	74 11                	je     bd0 <negatoi+0x20>
}
     bbf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bc2:	c9                   	leave  
  return atoi(str);
     bc3:	e9 b8 08 00 00       	jmp    1480 <atoi>
     bc8:	90                   	nop
     bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    substr(str, str, 1, strlen(str));
     bd0:	83 ec 0c             	sub    $0xc,%esp
     bd3:	53                   	push   %ebx
     bd4:	e8 47 07 00 00       	call   1320 <strlen>
     bd9:	50                   	push   %eax
     bda:	6a 01                	push   $0x1
     bdc:	53                   	push   %ebx
     bdd:	53                   	push   %ebx
     bde:	e8 2d fd ff ff       	call   910 <substr>
    return 0 - atoi(str);
     be3:	83 c4 14             	add    $0x14,%esp
     be6:	53                   	push   %ebx
     be7:	e8 94 08 00 00       	call   1480 <atoi>
     bec:	83 c4 10             	add    $0x10,%esp
     bef:	f7 d8                	neg    %eax
}
     bf1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bf4:	c9                   	leave  
     bf5:	c3                   	ret    
     bf6:	8d 76 00             	lea    0x0(%esi),%esi
     bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c00 <toUpper>:
void toUpper(char* str) {
     c00:	55                   	push   %ebp
     c01:	89 e5                	mov    %esp,%ebp
     c03:	8b 55 08             	mov    0x8(%ebp),%edx
  while (str[i] != '\0') {
     c06:	0f b6 02             	movzbl (%edx),%eax
     c09:	84 c0                	test   %al,%al
     c0b:	74 1a                	je     c27 <toUpper+0x27>
     c0d:	8d 76 00             	lea    0x0(%esi),%esi
    if (c <= 'z' && c >= 'a')
     c10:	8d 48 9f             	lea    -0x61(%eax),%ecx
     c13:	80 f9 19             	cmp    $0x19,%cl
     c16:	77 05                	ja     c1d <toUpper+0x1d>
      str[i] += ('Z' - 'z');
     c18:	83 e8 20             	sub    $0x20,%eax
     c1b:	88 02                	mov    %al,(%edx)
     c1d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     c20:	0f b6 02             	movzbl (%edx),%eax
     c23:	84 c0                	test   %al,%al
     c25:	75 e9                	jne    c10 <toUpper+0x10>
    i++;  
  }
}
     c27:	5d                   	pop    %ebp
     c28:	c3                   	ret    
     c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c30 <toLower>:

void toLower(char* str) {
     c30:	55                   	push   %ebp
     c31:	89 e5                	mov    %esp,%ebp
     c33:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     c36:	0f b6 02             	movzbl (%edx),%eax
     c39:	84 c0                	test   %al,%al
     c3b:	74 1a                	je     c57 <toLower+0x27>
     c3d:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'Z' && c >= 'A')
     c40:	8d 48 bf             	lea    -0x41(%eax),%ecx
     c43:	80 f9 19             	cmp    $0x19,%cl
     c46:	77 05                	ja     c4d <toLower+0x1d>
      str[i] -= ('Z' - 'z');
     c48:	83 c0 20             	add    $0x20,%eax
     c4b:	88 02                	mov    %al,(%edx)
     c4d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     c50:	0f b6 02             	movzbl (%edx),%eax
     c53:	84 c0                	test   %al,%al
     c55:	75 e9                	jne    c40 <toLower+0x10>
    i++;  
  }
}
     c57:	5d                   	pop    %ebp
     c58:	c3                   	ret    
     c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c60 <lineAt>:

// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
     c60:	55                   	push   %ebp
     c61:	89 e5                	mov    %esp,%ebp
  return nodeAt(list, pos-1);
     c63:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
}
     c67:	5d                   	pop    %ebp
  return nodeAt(list, pos-1);
     c68:	e9 d3 f7 ff ff       	jmp    440 <nodeAt>
     c6d:	8d 76 00             	lea    0x0(%esi),%esi

00000c70 <printl>:

void printl(int lineNum, char* line) {
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
     c73:	83 ec 08             	sub    $0x8,%esp
     c76:	8b 45 08             	mov    0x8(%ebp),%eax
  if (lineNum < 10)
     c79:	83 f8 09             	cmp    $0x9,%eax
     c7c:	7e 3a                	jle    cb8 <printl+0x48>
    fprintf(2, "%d  : %s\n", lineNum, line);
  else if (lineNum < 100)
     c7e:	83 f8 63             	cmp    $0x63,%eax
     c81:	7e 1d                	jle    ca0 <printl+0x30>
    fprintf(2, "%d : %s\n", lineNum, line);
  else
    fprintf(2, "%d: %s\n", lineNum, line);
     c83:	ff 75 0c             	pushl  0xc(%ebp)
     c86:	50                   	push   %eax
     c87:	68 52 1a 00 00       	push   $0x1a52
     c8c:	6a 02                	push   $0x2
     c8e:	e8 cd 0b 00 00       	call   1860 <fprintf>
     c93:	83 c4 10             	add    $0x10,%esp
     c96:	c9                   	leave  
     c97:	c3                   	ret    
     c98:	90                   	nop
     c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "%d : %s\n", lineNum, line);
     ca0:	ff 75 0c             	pushl  0xc(%ebp)
     ca3:	50                   	push   %eax
     ca4:	68 49 1a 00 00       	push   $0x1a49
     ca9:	6a 02                	push   $0x2
     cab:	e8 b0 0b 00 00       	call   1860 <fprintf>
     cb0:	83 c4 10             	add    $0x10,%esp
     cb3:	c9                   	leave  
     cb4:	c3                   	ret    
     cb5:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "%d  : %s\n", lineNum, line);
     cb8:	ff 75 0c             	pushl  0xc(%ebp)
     cbb:	50                   	push   %eax
     cbc:	68 3f 1a 00 00       	push   $0x1a3f
     cc1:	6a 02                	push   $0x2
     cc3:	e8 98 0b 00 00       	call   1860 <fprintf>
     cc8:	83 c4 10             	add    $0x10,%esp
     ccb:	c9                   	leave  
     ccc:	c3                   	ret    
     ccd:	8d 76 00             	lea    0x0(%esi),%esi

00000cd0 <end>:
void end(struct File* file, char* args) {
     cd0:	55                   	push   %ebp
     cd1:	89 e5                	mov    %esp,%ebp
     cd3:	53                   	push   %ebx
     cd4:	83 ec 08             	sub    $0x8,%esp
     cd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  append(file->lines, line);
     cda:	8b 43 0c             	mov    0xc(%ebx),%eax
  file->edited = 1;
     cdd:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
     ce4:	ff 70 08             	pushl  0x8(%eax)
     ce7:	ff 75 0c             	pushl  0xc(%ebp)
     cea:	50                   	push   %eax
     ceb:	e8 70 f8 ff ff       	call   560 <insert>
  file->len++;
     cf0:	83 43 10 01          	addl   $0x1,0x10(%ebx)
}
     cf4:	83 c4 10             	add    $0x10,%esp
     cf7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cfa:	c9                   	leave  
     cfb:	c3                   	ret    
     cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d00 <add>:
void add(struct File* file, char* args) {
     d00:	55                   	push   %ebp
     d01:	89 e5                	mov    %esp,%ebp
     d03:	57                   	push   %edi
     d04:	56                   	push   %esi
     d05:	53                   	push   %ebx
     d06:	83 ec 28             	sub    $0x28,%esp
     d09:	8b 5d 08             	mov    0x8(%ebp),%ebx
     d0c:	8b 75 0c             	mov    0xc(%ebp),%esi
  file->edited = 1;
     d0f:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
  if (strlen(args) < 1) {
     d16:	56                   	push   %esi
     d17:	e8 04 06 00 00       	call   1320 <strlen>
     d1c:	83 c4 10             	add    $0x10,%esp
     d1f:	85 c0                	test   %eax,%eax
     d21:	74 3d                	je     d60 <add+0x60>
  getArg(lineStr, args, ' ');
     d23:	8d 7d de             	lea    -0x22(%ebp),%edi
     d26:	83 ec 04             	sub    $0x4,%esp
     d29:	6a 20                	push   $0x20
     d2b:	56                   	push   %esi
     d2c:	57                   	push   %edi
     d2d:	e8 2e fc ff ff       	call   960 <getArg>
  int lineNum = negatoi(lineStr);
     d32:	89 3c 24             	mov    %edi,(%esp)
     d35:	e8 76 fe ff ff       	call   bb0 <negatoi>
  insert(file->lines, line, lineNum - 1);
     d3a:	83 c4 0c             	add    $0xc,%esp
     d3d:	83 e8 01             	sub    $0x1,%eax
     d40:	50                   	push   %eax
     d41:	56                   	push   %esi
     d42:	ff 73 0c             	pushl  0xc(%ebx)
     d45:	e8 16 f8 ff ff       	call   560 <insert>
  file->len++;
     d4a:	83 43 10 01          	addl   $0x1,0x10(%ebx)
     d4e:	83 c4 10             	add    $0x10,%esp
}
     d51:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d54:	5b                   	pop    %ebx
     d55:	5e                   	pop    %esi
     d56:	5f                   	pop    %edi
     d57:	5d                   	pop    %ebp
     d58:	c3                   	ret    
     d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "you need to give a line number to insert before\n");
     d60:	83 ec 08             	sub    $0x8,%esp
     d63:	68 60 1b 00 00       	push   $0x1b60
     d68:	6a 02                	push   $0x2
     d6a:	e8 f1 0a 00 00       	call   1860 <fprintf>
     d6f:	83 c4 10             	add    $0x10,%esp
}
     d72:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d75:	5b                   	pop    %ebx
     d76:	5e                   	pop    %esi
     d77:	5f                   	pop    %edi
     d78:	5d                   	pop    %ebp
     d79:	c3                   	ret    
     d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000d80 <drop>:
void drop(struct File* file, char* args) {
     d80:	55                   	push   %ebp
     d81:	89 e5                	mov    %esp,%ebp
     d83:	57                   	push   %edi
     d84:	56                   	push   %esi
     d85:	53                   	push   %ebx
     d86:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
     d89:	ff 75 0c             	pushl  0xc(%ebp)
void drop(struct File* file, char* args) {
     d8c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (strlen(args) < 1) {
     d8f:	e8 8c 05 00 00       	call   1320 <strlen>
     d94:	83 c4 10             	add    $0x10,%esp
     d97:	85 c0                	test   %eax,%eax
     d99:	0f 84 09 01 00 00    	je     ea8 <drop+0x128>
  if (collectRange(args, &start, &end) == 1) {
     d9f:	8d 75 e4             	lea    -0x1c(%ebp),%esi
     da2:	8d 7d e0             	lea    -0x20(%ebp),%edi
     da5:	83 ec 04             	sub    $0x4,%esp
     da8:	56                   	push   %esi
     da9:	57                   	push   %edi
     daa:	ff 75 0c             	pushl  0xc(%ebp)
     dad:	e8 1e fc ff ff       	call   9d0 <collectRange>
     db2:	83 c4 10             	add    $0x10,%esp
     db5:	83 f8 01             	cmp    $0x1,%eax
     db8:	0f 84 0a 01 00 00    	je     ec8 <drop+0x148>
  if (normalizeRange(*file, &start, &end) == 1) {
     dbe:	56                   	push   %esi
     dbf:	57                   	push   %edi
     dc0:	ff 73 14             	pushl  0x14(%ebx)
     dc3:	ff 73 10             	pushl  0x10(%ebx)
     dc6:	ff 73 0c             	pushl  0xc(%ebx)
     dc9:	ff 73 08             	pushl  0x8(%ebx)
     dcc:	ff 73 04             	pushl  0x4(%ebx)
     dcf:	ff 33                	pushl  (%ebx)
     dd1:	e8 0a f9 ff ff       	call   6e0 <normalizeRange>
     dd6:	83 c4 20             	add    $0x20,%esp
     dd9:	83 f8 01             	cmp    $0x1,%eax
     ddc:	0f 84 1e 01 00 00    	je     f00 <drop+0x180>
  int numl = numLines(start, end);
     de2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     de5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return (end - start) + 1;
     de8:	89 d6                	mov    %edx,%esi
     dea:	29 c6                	sub    %eax,%esi
     dec:	8d 7e 01             	lea    0x1(%esi),%edi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
     def:	83 ff 01             	cmp    $0x1,%edi
     df2:	89 7d d4             	mov    %edi,-0x2c(%ebp)
     df5:	0f 84 ed 00 00 00    	je     ee8 <drop+0x168>
  else fprintf(2, "Drop %d lines [%d:%d] (y/n)? ", numl, start, end);
     dfb:	83 ec 0c             	sub    $0xc,%esp
     dfe:	52                   	push   %edx
     dff:	50                   	push   %eax
     e00:	ff 75 d4             	pushl  -0x2c(%ebp)
     e03:	68 6f 1a 00 00       	push   $0x1a6f
     e08:	6a 02                	push   $0x2
     e0a:	e8 51 0a 00 00       	call   1860 <fprintf>
     e0f:	83 c4 20             	add    $0x20,%esp
  if (confirmation() != 0) return;
     e12:	e8 69 f8 ff ff       	call   680 <confirmation>
     e17:	85 c0                	test   %eax,%eax
     e19:	75 7f                	jne    e9a <drop+0x11a>
  return nodeAt(list, pos-1);
     e1b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  struct Node* curNode = (lineAt(file->lines, start))->prev;
     e1e:	8b 4b 0c             	mov    0xc(%ebx),%ecx
     e21:	83 ec 08             	sub    $0x8,%esp
  file->edited = 1;
     e24:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
     e2b:	83 e8 01             	sub    $0x1,%eax
     e2e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
     e31:	50                   	push   %eax
     e32:	51                   	push   %ecx
     e33:	e8 08 f6 ff ff       	call   440 <nodeAt>
  struct Node* curNode = (lineAt(file->lines, start))->prev;
     e38:	8b 30                	mov    (%eax),%esi
     e3a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     e3d:	5a                   	pop    %edx
     e3e:	59                   	pop    %ecx
     e3f:	8b 4d d0             	mov    -0x30(%ebp),%ecx
     e42:	83 e8 01             	sub    $0x1,%eax
     e45:	50                   	push   %eax
     e46:	51                   	push   %ecx
     e47:	e8 f4 f5 ff ff       	call   440 <nodeAt>
     e4c:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
     e4f:	39 c6                	cmp    %eax,%esi
     e51:	89 c7                	mov    %eax,%edi
     e53:	8b 4d d0             	mov    -0x30(%ebp),%ecx
     e56:	75 0b                	jne    e63 <drop+0xe3>
     e58:	eb 21                	jmp    e7b <drop+0xfb>
     e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e60:	8b 4b 0c             	mov    0xc(%ebx),%ecx
    curNode = curNode->next;
     e63:	8b 76 08             	mov    0x8(%esi),%esi
    destroyNode(file->lines, curNode);
     e66:	83 ec 08             	sub    $0x8,%esp
     e69:	56                   	push   %esi
     e6a:	51                   	push   %ecx
     e6b:	e8 40 f6 ff ff       	call   4b0 <destroyNode>
    file->len--;
     e70:	83 6b 10 01          	subl   $0x1,0x10(%ebx)
  while (curNode != stopNode) {
     e74:	83 c4 10             	add    $0x10,%esp
     e77:	39 f7                	cmp    %esi,%edi
     e79:	75 e5                	jne    e60 <drop+0xe0>
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
     e7b:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
     e7f:	0f 84 93 00 00 00    	je     f18 <drop+0x198>
  else fprintf(2, "%d lines dropped\n", numl);
     e85:	83 ec 04             	sub    $0x4,%esp
     e88:	ff 75 d4             	pushl  -0x2c(%ebp)
     e8b:	68 9e 1a 00 00       	push   $0x1a9e
     e90:	6a 02                	push   $0x2
     e92:	e8 c9 09 00 00       	call   1860 <fprintf>
     e97:	83 c4 10             	add    $0x10,%esp
}
     e9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e9d:	5b                   	pop    %ebx
     e9e:	5e                   	pop    %esi
     e9f:	5f                   	pop    %edi
     ea0:	5d                   	pop    %ebp
     ea1:	c3                   	ret    
     ea2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "you need to give a range to drop\n");
     ea8:	83 ec 08             	sub    $0x8,%esp
     eab:	68 94 1b 00 00       	push   $0x1b94
     eb0:	6a 02                	push   $0x2
     eb2:	e8 a9 09 00 00       	call   1860 <fprintf>
    return;
     eb7:	83 c4 10             	add    $0x10,%esp
}
     eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ebd:	5b                   	pop    %ebx
     ebe:	5e                   	pop    %esi
     ebf:	5f                   	pop    %edi
     ec0:	5d                   	pop    %ebp
     ec1:	c3                   	ret    
     ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: start index is larger than end index\n");
     ec8:	83 ec 08             	sub    $0x8,%esp
     ecb:	68 b8 1b 00 00       	push   $0x1bb8
     ed0:	6a 02                	push   $0x2
     ed2:	e8 89 09 00 00       	call   1860 <fprintf>
     ed7:	83 c4 10             	add    $0x10,%esp
}
     eda:	8d 65 f4             	lea    -0xc(%ebp),%esp
     edd:	5b                   	pop    %ebx
     ede:	5e                   	pop    %esi
     edf:	5f                   	pop    %edi
     ee0:	5d                   	pop    %ebp
     ee1:	c3                   	ret    
     ee2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
     ee8:	83 ec 04             	sub    $0x4,%esp
     eeb:	50                   	push   %eax
     eec:	68 5a 1a 00 00       	push   $0x1a5a
     ef1:	6a 02                	push   $0x2
     ef3:	e8 68 09 00 00       	call   1860 <fprintf>
     ef8:	83 c4 10             	add    $0x10,%esp
     efb:	e9 12 ff ff ff       	jmp    e12 <drop+0x92>
    fprintf(2, "error: bad input range. make sure start < end\n");
     f00:	83 ec 08             	sub    $0x8,%esp
     f03:	68 e8 1b 00 00       	push   $0x1be8
     f08:	6a 02                	push   $0x2
     f0a:	e8 51 09 00 00       	call   1860 <fprintf>
     f0f:	83 c4 10             	add    $0x10,%esp
     f12:	eb 86                	jmp    e9a <drop+0x11a>
     f14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
     f18:	83 ec 04             	sub    $0x4,%esp
     f1b:	ff 75 e0             	pushl  -0x20(%ebp)
     f1e:	68 8d 1a 00 00       	push   $0x1a8d
     f23:	6a 02                	push   $0x2
     f25:	e8 36 09 00 00       	call   1860 <fprintf>
     f2a:	83 c4 10             	add    $0x10,%esp
     f2d:	e9 68 ff ff ff       	jmp    e9a <drop+0x11a>
     f32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000f40 <edit>:
void edit(struct File* file, char* args) {
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	57                   	push   %edi
     f44:	56                   	push   %esi
     f45:	53                   	push   %ebx
     f46:	83 ec 28             	sub    $0x28,%esp
     f49:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if (strlen(args) < 1) {
     f4c:	53                   	push   %ebx
     f4d:	e8 ce 03 00 00       	call   1320 <strlen>
     f52:	83 c4 10             	add    $0x10,%esp
     f55:	85 c0                	test   %eax,%eax
     f57:	75 1f                	jne    f78 <edit+0x38>
    fprintf(2, "you need to give a line number to replace\n");
     f59:	83 ec 08             	sub    $0x8,%esp
     f5c:	68 18 1c 00 00       	push   $0x1c18
     f61:	6a 02                	push   $0x2
     f63:	e8 f8 08 00 00       	call   1860 <fprintf>
    return;
     f68:	83 c4 10             	add    $0x10,%esp
}
     f6b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f6e:	5b                   	pop    %ebx
     f6f:	5e                   	pop    %esi
     f70:	5f                   	pop    %edi
     f71:	5d                   	pop    %ebp
     f72:	c3                   	ret    
     f73:	90                   	nop
     f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  getArg(lineStr, args, ' ');
     f78:	8d 75 de             	lea    -0x22(%ebp),%esi
     f7b:	83 ec 04             	sub    $0x4,%esp
     f7e:	6a 20                	push   $0x20
     f80:	53                   	push   %ebx
     f81:	56                   	push   %esi
     f82:	e8 d9 f9 ff ff       	call   960 <getArg>
  int lineNum = negatoi(lineStr);
     f87:	89 34 24             	mov    %esi,(%esp)
     f8a:	e8 21 fc ff ff       	call   bb0 <negatoi>
  fprintf(2, "replace line %d (y/n)? ", lineNum);
     f8f:	83 c4 0c             	add    $0xc,%esp
  int lineNum = negatoi(lineStr);
     f92:	89 c6                	mov    %eax,%esi
  fprintf(2, "replace line %d (y/n)? ", lineNum);
     f94:	50                   	push   %eax
     f95:	68 b0 1a 00 00       	push   $0x1ab0
     f9a:	6a 02                	push   $0x2
     f9c:	e8 bf 08 00 00       	call   1860 <fprintf>
  if (confirmation() != 0) return;
     fa1:	e8 da f6 ff ff       	call   680 <confirmation>
     fa6:	83 c4 10             	add    $0x10,%esp
     fa9:	85 c0                	test   %eax,%eax
     fab:	75 be                	jne    f6b <edit+0x2b>
  file->edited = 1;
     fad:	8b 45 08             	mov    0x8(%ebp),%eax
     fb0:	83 ec 08             	sub    $0x8,%esp
     fb3:	83 ee 01             	sub    $0x1,%esi
  destroyNode(file->lines, lineAt(file->lines, lineNum));
     fb6:	8b 78 0c             	mov    0xc(%eax),%edi
  file->edited = 1;
     fb9:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
     fc0:	56                   	push   %esi
     fc1:	57                   	push   %edi
     fc2:	e8 79 f4 ff ff       	call   440 <nodeAt>
     fc7:	5a                   	pop    %edx
     fc8:	59                   	pop    %ecx
  destroyNode(file->lines, lineAt(file->lines, lineNum));
     fc9:	50                   	push   %eax
     fca:	57                   	push   %edi
     fcb:	e8 e0 f4 ff ff       	call   4b0 <destroyNode>
  insert(file->lines, line, lineNum - 1);
     fd0:	8b 45 08             	mov    0x8(%ebp),%eax
     fd3:	83 c4 0c             	add    $0xc,%esp
     fd6:	56                   	push   %esi
     fd7:	53                   	push   %ebx
     fd8:	ff 70 0c             	pushl  0xc(%eax)
     fdb:	e8 80 f5 ff ff       	call   560 <insert>
     fe0:	83 c4 10             	add    $0x10,%esp
}
     fe3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fe6:	5b                   	pop    %ebx
     fe7:	5e                   	pop    %esi
     fe8:	5f                   	pop    %edi
     fe9:	5d                   	pop    %ebp
     fea:	c3                   	ret    
     feb:	90                   	nop
     fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ff0 <list>:
void list(struct File file, char* args) {
     ff0:	55                   	push   %ebp
     ff1:	89 e5                	mov    %esp,%ebp
     ff3:	57                   	push   %edi
     ff4:	56                   	push   %esi
     ff5:	53                   	push   %ebx
     ff6:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
     ff9:	ff 75 20             	pushl  0x20(%ebp)
     ffc:	8b 75 14             	mov    0x14(%ebp),%esi
     fff:	e8 1c 03 00 00       	call   1320 <strlen>
    1004:	83 c4 10             	add    $0x10,%esp
    1007:	85 c0                	test   %eax,%eax
    1009:	75 1d                	jne    1028 <list+0x38>
    fprintf(2, "you need to give a range to list\n");
    100b:	83 ec 08             	sub    $0x8,%esp
    100e:	68 44 1c 00 00       	push   $0x1c44
    1013:	6a 02                	push   $0x2
    1015:	e8 46 08 00 00       	call   1860 <fprintf>
    return;
    101a:	83 c4 10             	add    $0x10,%esp
}
    101d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1020:	5b                   	pop    %ebx
    1021:	5e                   	pop    %esi
    1022:	5f                   	pop    %edi
    1023:	5d                   	pop    %ebp
    1024:	c3                   	ret    
    1025:	8d 76 00             	lea    0x0(%esi),%esi
  if (collectRange(args, &start, &end) == 1) {
    1028:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
    102b:	8d 7d e0             	lea    -0x20(%ebp),%edi
    102e:	83 ec 04             	sub    $0x4,%esp
    1031:	53                   	push   %ebx
    1032:	57                   	push   %edi
    1033:	ff 75 20             	pushl  0x20(%ebp)
    1036:	e8 95 f9 ff ff       	call   9d0 <collectRange>
    103b:	83 c4 10             	add    $0x10,%esp
    103e:	83 f8 01             	cmp    $0x1,%eax
    1041:	0f 84 91 00 00 00    	je     10d8 <list+0xe8>
  if (normalizeRange(file, &start, &end) == 1) {
    1047:	53                   	push   %ebx
    1048:	57                   	push   %edi
    1049:	ff 75 1c             	pushl  0x1c(%ebp)
    104c:	ff 75 18             	pushl  0x18(%ebp)
    104f:	ff 75 14             	pushl  0x14(%ebp)
    1052:	ff 75 10             	pushl  0x10(%ebp)
    1055:	ff 75 0c             	pushl  0xc(%ebp)
    1058:	ff 75 08             	pushl  0x8(%ebp)
    105b:	e8 80 f6 ff ff       	call   6e0 <normalizeRange>
    1060:	83 c4 20             	add    $0x20,%esp
    1063:	83 f8 01             	cmp    $0x1,%eax
    1066:	0f 84 8c 00 00 00    	je     10f8 <list+0x108>
  lineNum = start - 1;
    106c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    106f:	83 ec 08             	sub    $0x8,%esp
    1072:	8d 78 ff             	lea    -0x1(%eax),%edi
    1075:	57                   	push   %edi
    1076:	56                   	push   %esi
    1077:	e8 c4 f3 ff ff       	call   440 <nodeAt>
  struct Node* curNode = (lineAt(file.lines, start))->prev;
    107c:	8b 18                	mov    (%eax),%ebx
    107e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1081:	5a                   	pop    %edx
    1082:	59                   	pop    %ecx
    1083:	83 e8 01             	sub    $0x1,%eax
    1086:	50                   	push   %eax
    1087:	56                   	push   %esi
    1088:	e8 b3 f3 ff ff       	call   440 <nodeAt>
    108d:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
    1090:	39 d8                	cmp    %ebx,%eax
    1092:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1095:	74 86                	je     101d <list+0x2d>
    curNode = curNode->next;
    1097:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
    109a:	3b 5e 04             	cmp    0x4(%esi),%ebx
    109d:	75 15                	jne    10b4 <list+0xc4>
    109f:	e9 79 ff ff ff       	jmp    101d <list+0x2d>
    10a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
    10a8:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
    10ab:	39 5e 04             	cmp    %ebx,0x4(%esi)
    10ae:	0f 84 69 ff ff ff    	je     101d <list+0x2d>
    printl(++lineNum, curNode->data);
    10b4:	83 ec 08             	sub    $0x8,%esp
    10b7:	83 c7 01             	add    $0x1,%edi
    10ba:	ff 73 04             	pushl  0x4(%ebx)
    10bd:	57                   	push   %edi
    10be:	e8 ad fb ff ff       	call   c70 <printl>
  while (curNode != stopNode) {
    10c3:	83 c4 10             	add    $0x10,%esp
    10c6:	39 5d d4             	cmp    %ebx,-0x2c(%ebp)
    10c9:	75 dd                	jne    10a8 <list+0xb8>
}
    10cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10ce:	5b                   	pop    %ebx
    10cf:	5e                   	pop    %esi
    10d0:	5f                   	pop    %edi
    10d1:	5d                   	pop    %ebp
    10d2:	c3                   	ret    
    10d3:	90                   	nop
    10d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "error: start index is larger than end index\n");
    10d8:	83 ec 08             	sub    $0x8,%esp
    10db:	68 b8 1b 00 00       	push   $0x1bb8
    10e0:	6a 02                	push   $0x2
    10e2:	e8 79 07 00 00       	call   1860 <fprintf>
    return;
    10e7:	83 c4 10             	add    $0x10,%esp
}
    10ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10ed:	5b                   	pop    %ebx
    10ee:	5e                   	pop    %esi
    10ef:	5f                   	pop    %edi
    10f0:	5d                   	pop    %ebp
    10f1:	c3                   	ret    
    10f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: bad input range. make sure start < end\n");
    10f8:	83 ec 08             	sub    $0x8,%esp
    10fb:	68 e8 1b 00 00       	push   $0x1be8
    1100:	6a 02                	push   $0x2
    1102:	e8 59 07 00 00       	call   1860 <fprintf>
    return;
    1107:	83 c4 10             	add    $0x10,%esp
    110a:	e9 0e ff ff ff       	jmp    101d <list+0x2d>
    110f:	90                   	nop

00001110 <show>:
void show(struct File file, char* args) {
    1110:	55                   	push   %ebp
    1111:	89 e5                	mov    %esp,%ebp
    1113:	57                   	push   %edi
    1114:	56                   	push   %esi
    1115:	53                   	push   %ebx
    1116:	83 ec 0c             	sub    $0xc,%esp
    1119:	8b 7d 14             	mov    0x14(%ebp),%edi
  struct Node* cur = file.lines->head->next;
    111c:	8b 07                	mov    (%edi),%eax
    111e:	8b 58 08             	mov    0x8(%eax),%ebx
  while (cur != file.lines->tail) {
    1121:	3b 5f 04             	cmp    0x4(%edi),%ebx
    1124:	74 24                	je     114a <show+0x3a>
  int lineNum = 1;
    1126:	be 01 00 00 00       	mov    $0x1,%esi
    112b:	90                   	nop
    112c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printl(lineNum, cur->data);
    1130:	83 ec 08             	sub    $0x8,%esp
    1133:	ff 73 04             	pushl  0x4(%ebx)
    1136:	56                   	push   %esi
    lineNum++;
    1137:	83 c6 01             	add    $0x1,%esi
    printl(lineNum, cur->data);
    113a:	e8 31 fb ff ff       	call   c70 <printl>
    cur = cur->next;
    113f:	8b 5b 08             	mov    0x8(%ebx),%ebx
  while (cur != file.lines->tail) {
    1142:	83 c4 10             	add    $0x10,%esp
    1145:	39 5f 04             	cmp    %ebx,0x4(%edi)
    1148:	75 e6                	jne    1130 <show+0x20>
}
    114a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    114d:	5b                   	pop    %ebx
    114e:	5e                   	pop    %esi
    114f:	5f                   	pop    %edi
    1150:	5d                   	pop    %ebp
    1151:	c3                   	ret    
    1152:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001160 <quit>:
void quit(struct File* file) {
    1160:	55                   	push   %ebp
    1161:	89 e5                	mov    %esp,%ebp
    1163:	56                   	push   %esi
    1164:	53                   	push   %ebx
    1165:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (file->edited == 0) return;
    1168:	8b 4b 14             	mov    0x14(%ebx),%ecx
    116b:	85 c9                	test   %ecx,%ecx
    116d:	75 11                	jne    1180 <quit+0x20>
}
    116f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1172:	5b                   	pop    %ebx
    1173:	5e                   	pop    %esi
    1174:	5d                   	pop    %ebp
    1175:	c3                   	ret    
    1176:	8d 76 00             	lea    0x0(%esi),%esi
    1179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  fprintf(2, "save changes (y/n)? ");
    1180:	83 ec 08             	sub    $0x8,%esp
    1183:	68 c8 1a 00 00       	push   $0x1ac8
    1188:	6a 02                	push   $0x2
    118a:	e8 d1 06 00 00       	call   1860 <fprintf>
  if (confirmation() != 0) return;
    118f:	e8 ec f4 ff ff       	call   680 <confirmation>
    1194:	83 c4 10             	add    $0x10,%esp
    1197:	85 c0                	test   %eax,%eax
    1199:	75 d4                	jne    116f <quit+0xf>
  if (unlink(file->filename) < 0) {
    119b:	83 ec 0c             	sub    $0xc,%esp
    119e:	ff 33                	pushl  (%ebx)
    11a0:	e8 9d 03 00 00       	call   1542 <unlink>
    11a5:	83 c4 10             	add    $0x10,%esp
    11a8:	85 c0                	test   %eax,%eax
    11aa:	0f 88 90 00 00 00    	js     1240 <quit+0xe0>
  file->fd = open(file->filename, O_CREATE|O_RDWR);
    11b0:	83 ec 08             	sub    $0x8,%esp
    11b3:	68 02 02 00 00       	push   $0x202
    11b8:	ff 33                	pushl  (%ebx)
    11ba:	e8 73 03 00 00       	call   1532 <open>
  if (file->fd < 0) {
    11bf:	83 c4 10             	add    $0x10,%esp
    11c2:	85 c0                	test   %eax,%eax
  file->fd = open(file->filename, O_CREATE|O_RDWR);
    11c4:	89 43 04             	mov    %eax,0x4(%ebx)
  if (file->fd < 0) {
    11c7:	0f 88 93 00 00 00    	js     1260 <quit+0x100>
  struct Node* cur = file->lines->head->next;
    11cd:	8b 53 0c             	mov    0xc(%ebx),%edx
    11d0:	8b 0a                	mov    (%edx),%ecx
    11d2:	8b 71 08             	mov    0x8(%ecx),%esi
  while (cur != file->lines->tail) {
    11d5:	3b 72 04             	cmp    0x4(%edx),%esi
    11d8:	74 43                	je     121d <quit+0xbd>
    11da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    write(file->fd, cur->data, strlen(cur->data));
    11e0:	83 ec 0c             	sub    $0xc,%esp
    11e3:	ff 76 04             	pushl  0x4(%esi)
    11e6:	e8 35 01 00 00       	call   1320 <strlen>
    11eb:	83 c4 0c             	add    $0xc,%esp
    11ee:	50                   	push   %eax
    11ef:	ff 76 04             	pushl  0x4(%esi)
    11f2:	ff 73 04             	pushl  0x4(%ebx)
    11f5:	e8 18 03 00 00       	call   1512 <write>
    write(file->fd, "\n", sizeof(char));
    11fa:	83 c4 0c             	add    $0xc,%esp
    11fd:	6a 01                	push   $0x1
    11ff:	68 15 1b 00 00       	push   $0x1b15
    1204:	ff 73 04             	pushl  0x4(%ebx)
    1207:	e8 06 03 00 00       	call   1512 <write>
  while (cur != file->lines->tail) {
    120c:	8b 43 0c             	mov    0xc(%ebx),%eax
    cur = cur->next;
    120f:	8b 76 08             	mov    0x8(%esi),%esi
  while (cur != file->lines->tail) {
    1212:	83 c4 10             	add    $0x10,%esp
    1215:	3b 70 04             	cmp    0x4(%eax),%esi
    1218:	75 c6                	jne    11e0 <quit+0x80>
    121a:	8b 43 04             	mov    0x4(%ebx),%eax
  close(file->fd);
    121d:	83 ec 0c             	sub    $0xc,%esp
    1220:	50                   	push   %eax
    1221:	e8 f4 02 00 00       	call   151a <close>
  fprintf(2, "changes saved\n");
    1226:	58                   	pop    %eax
    1227:	5a                   	pop    %edx
    1228:	68 dd 1a 00 00       	push   $0x1add
    122d:	6a 02                	push   $0x2
    122f:	e8 2c 06 00 00       	call   1860 <fprintf>
    1234:	83 c4 10             	add    $0x10,%esp
    1237:	e9 33 ff ff ff       	jmp    116f <quit+0xf>
    123c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "could not clear file for writing. changes lost\n");
    1240:	83 ec 08             	sub    $0x8,%esp
    1243:	68 68 1c 00 00       	push   $0x1c68
    1248:	6a 02                	push   $0x2
    124a:	e8 11 06 00 00       	call   1860 <fprintf>
    return;
    124f:	83 c4 10             	add    $0x10,%esp
    1252:	e9 18 ff ff ff       	jmp    116f <quit+0xf>
    1257:	89 f6                	mov    %esi,%esi
    1259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    fprintf(2, "could not open file for writing. changes lost\n");
    1260:	83 ec 08             	sub    $0x8,%esp
    1263:	68 98 1c 00 00       	push   $0x1c98
    1268:	6a 02                	push   $0x2
    126a:	e8 f1 05 00 00       	call   1860 <fprintf>
    return;
    126f:	83 c4 10             	add    $0x10,%esp
    1272:	e9 f8 fe ff ff       	jmp    116f <quit+0xf>
    1277:	89 f6                	mov    %esi,%esi
    1279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001280 <bi>:
void bi() {
    1280:	55                   	push   %ebp
    1281:	89 e5                	mov    %esp,%ebp
    1283:	83 ec 10             	sub    $0x10,%esp
  fprintf(2, "bad input\n");
    1286:	68 53 1b 00 00       	push   $0x1b53
    128b:	6a 02                	push   $0x2
    128d:	e8 ce 05 00 00       	call   1860 <fprintf>
}
    1292:	83 c4 10             	add    $0x10,%esp
    1295:	c9                   	leave  
    1296:	c3                   	ret    
    1297:	66 90                	xchg   %ax,%ax
    1299:	66 90                	xchg   %ax,%ax
    129b:	66 90                	xchg   %ax,%ax
    129d:	66 90                	xchg   %ax,%ax
    129f:	90                   	nop

000012a0 <strcpy>:
    12a0:	55                   	push   %ebp
    12a1:	89 e5                	mov    %esp,%ebp
    12a3:	53                   	push   %ebx
    12a4:	8b 45 08             	mov    0x8(%ebp),%eax
    12a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    12aa:	89 c2                	mov    %eax,%edx
    12ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12b0:	83 c1 01             	add    $0x1,%ecx
    12b3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    12b7:	83 c2 01             	add    $0x1,%edx
    12ba:	84 db                	test   %bl,%bl
    12bc:	88 5a ff             	mov    %bl,-0x1(%edx)
    12bf:	75 ef                	jne    12b0 <strcpy+0x10>
    12c1:	5b                   	pop    %ebx
    12c2:	5d                   	pop    %ebp
    12c3:	c3                   	ret    
    12c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    12ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000012d0 <strcmp>:
    12d0:	55                   	push   %ebp
    12d1:	89 e5                	mov    %esp,%ebp
    12d3:	53                   	push   %ebx
    12d4:	8b 55 08             	mov    0x8(%ebp),%edx
    12d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    12da:	0f b6 02             	movzbl (%edx),%eax
    12dd:	0f b6 19             	movzbl (%ecx),%ebx
    12e0:	84 c0                	test   %al,%al
    12e2:	75 1c                	jne    1300 <strcmp+0x30>
    12e4:	eb 2a                	jmp    1310 <strcmp+0x40>
    12e6:	8d 76 00             	lea    0x0(%esi),%esi
    12e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    12f0:	83 c2 01             	add    $0x1,%edx
    12f3:	0f b6 02             	movzbl (%edx),%eax
    12f6:	83 c1 01             	add    $0x1,%ecx
    12f9:	0f b6 19             	movzbl (%ecx),%ebx
    12fc:	84 c0                	test   %al,%al
    12fe:	74 10                	je     1310 <strcmp+0x40>
    1300:	38 d8                	cmp    %bl,%al
    1302:	74 ec                	je     12f0 <strcmp+0x20>
    1304:	29 d8                	sub    %ebx,%eax
    1306:	5b                   	pop    %ebx
    1307:	5d                   	pop    %ebp
    1308:	c3                   	ret    
    1309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1310:	31 c0                	xor    %eax,%eax
    1312:	29 d8                	sub    %ebx,%eax
    1314:	5b                   	pop    %ebx
    1315:	5d                   	pop    %ebp
    1316:	c3                   	ret    
    1317:	89 f6                	mov    %esi,%esi
    1319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001320 <strlen>:
    1320:	55                   	push   %ebp
    1321:	89 e5                	mov    %esp,%ebp
    1323:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1326:	80 39 00             	cmpb   $0x0,(%ecx)
    1329:	74 15                	je     1340 <strlen+0x20>
    132b:	31 d2                	xor    %edx,%edx
    132d:	8d 76 00             	lea    0x0(%esi),%esi
    1330:	83 c2 01             	add    $0x1,%edx
    1333:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1337:	89 d0                	mov    %edx,%eax
    1339:	75 f5                	jne    1330 <strlen+0x10>
    133b:	5d                   	pop    %ebp
    133c:	c3                   	ret    
    133d:	8d 76 00             	lea    0x0(%esi),%esi
    1340:	31 c0                	xor    %eax,%eax
    1342:	5d                   	pop    %ebp
    1343:	c3                   	ret    
    1344:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    134a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001350 <memset>:
    1350:	55                   	push   %ebp
    1351:	89 e5                	mov    %esp,%ebp
    1353:	57                   	push   %edi
    1354:	8b 55 08             	mov    0x8(%ebp),%edx
    1357:	8b 4d 10             	mov    0x10(%ebp),%ecx
    135a:	8b 45 0c             	mov    0xc(%ebp),%eax
    135d:	89 d7                	mov    %edx,%edi
    135f:	fc                   	cld    
    1360:	f3 aa                	rep stos %al,%es:(%edi)
    1362:	89 d0                	mov    %edx,%eax
    1364:	5f                   	pop    %edi
    1365:	5d                   	pop    %ebp
    1366:	c3                   	ret    
    1367:	89 f6                	mov    %esi,%esi
    1369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001370 <strchr>:
    1370:	55                   	push   %ebp
    1371:	89 e5                	mov    %esp,%ebp
    1373:	53                   	push   %ebx
    1374:	8b 45 08             	mov    0x8(%ebp),%eax
    1377:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    137a:	0f b6 10             	movzbl (%eax),%edx
    137d:	84 d2                	test   %dl,%dl
    137f:	74 1d                	je     139e <strchr+0x2e>
    1381:	38 d3                	cmp    %dl,%bl
    1383:	89 d9                	mov    %ebx,%ecx
    1385:	75 0d                	jne    1394 <strchr+0x24>
    1387:	eb 17                	jmp    13a0 <strchr+0x30>
    1389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1390:	38 ca                	cmp    %cl,%dl
    1392:	74 0c                	je     13a0 <strchr+0x30>
    1394:	83 c0 01             	add    $0x1,%eax
    1397:	0f b6 10             	movzbl (%eax),%edx
    139a:	84 d2                	test   %dl,%dl
    139c:	75 f2                	jne    1390 <strchr+0x20>
    139e:	31 c0                	xor    %eax,%eax
    13a0:	5b                   	pop    %ebx
    13a1:	5d                   	pop    %ebp
    13a2:	c3                   	ret    
    13a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    13a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000013b0 <gets>:
    13b0:	55                   	push   %ebp
    13b1:	89 e5                	mov    %esp,%ebp
    13b3:	57                   	push   %edi
    13b4:	56                   	push   %esi
    13b5:	53                   	push   %ebx
    13b6:	31 f6                	xor    %esi,%esi
    13b8:	89 f3                	mov    %esi,%ebx
    13ba:	83 ec 1c             	sub    $0x1c,%esp
    13bd:	8b 7d 08             	mov    0x8(%ebp),%edi
    13c0:	eb 2f                	jmp    13f1 <gets+0x41>
    13c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    13c8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    13cb:	83 ec 04             	sub    $0x4,%esp
    13ce:	6a 01                	push   $0x1
    13d0:	50                   	push   %eax
    13d1:	6a 00                	push   $0x0
    13d3:	e8 32 01 00 00       	call   150a <read>
    13d8:	83 c4 10             	add    $0x10,%esp
    13db:	85 c0                	test   %eax,%eax
    13dd:	7e 1c                	jle    13fb <gets+0x4b>
    13df:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    13e3:	83 c7 01             	add    $0x1,%edi
    13e6:	88 47 ff             	mov    %al,-0x1(%edi)
    13e9:	3c 0a                	cmp    $0xa,%al
    13eb:	74 23                	je     1410 <gets+0x60>
    13ed:	3c 0d                	cmp    $0xd,%al
    13ef:	74 1f                	je     1410 <gets+0x60>
    13f1:	83 c3 01             	add    $0x1,%ebx
    13f4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    13f7:	89 fe                	mov    %edi,%esi
    13f9:	7c cd                	jl     13c8 <gets+0x18>
    13fb:	89 f3                	mov    %esi,%ebx
    13fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1400:	c6 03 00             	movb   $0x0,(%ebx)
    1403:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1406:	5b                   	pop    %ebx
    1407:	5e                   	pop    %esi
    1408:	5f                   	pop    %edi
    1409:	5d                   	pop    %ebp
    140a:	c3                   	ret    
    140b:	90                   	nop
    140c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1410:	8b 75 08             	mov    0x8(%ebp),%esi
    1413:	8b 45 08             	mov    0x8(%ebp),%eax
    1416:	01 de                	add    %ebx,%esi
    1418:	89 f3                	mov    %esi,%ebx
    141a:	c6 03 00             	movb   $0x0,(%ebx)
    141d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1420:	5b                   	pop    %ebx
    1421:	5e                   	pop    %esi
    1422:	5f                   	pop    %edi
    1423:	5d                   	pop    %ebp
    1424:	c3                   	ret    
    1425:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001430 <stat>:
    1430:	55                   	push   %ebp
    1431:	89 e5                	mov    %esp,%ebp
    1433:	56                   	push   %esi
    1434:	53                   	push   %ebx
    1435:	83 ec 08             	sub    $0x8,%esp
    1438:	6a 00                	push   $0x0
    143a:	ff 75 08             	pushl  0x8(%ebp)
    143d:	e8 f0 00 00 00       	call   1532 <open>
    1442:	83 c4 10             	add    $0x10,%esp
    1445:	85 c0                	test   %eax,%eax
    1447:	78 27                	js     1470 <stat+0x40>
    1449:	83 ec 08             	sub    $0x8,%esp
    144c:	ff 75 0c             	pushl  0xc(%ebp)
    144f:	89 c3                	mov    %eax,%ebx
    1451:	50                   	push   %eax
    1452:	e8 f3 00 00 00       	call   154a <fstat>
    1457:	89 1c 24             	mov    %ebx,(%esp)
    145a:	89 c6                	mov    %eax,%esi
    145c:	e8 b9 00 00 00       	call   151a <close>
    1461:	83 c4 10             	add    $0x10,%esp
    1464:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1467:	89 f0                	mov    %esi,%eax
    1469:	5b                   	pop    %ebx
    146a:	5e                   	pop    %esi
    146b:	5d                   	pop    %ebp
    146c:	c3                   	ret    
    146d:	8d 76 00             	lea    0x0(%esi),%esi
    1470:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1475:	eb ed                	jmp    1464 <stat+0x34>
    1477:	89 f6                	mov    %esi,%esi
    1479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001480 <atoi>:
    1480:	55                   	push   %ebp
    1481:	89 e5                	mov    %esp,%ebp
    1483:	53                   	push   %ebx
    1484:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1487:	0f be 11             	movsbl (%ecx),%edx
    148a:	8d 42 d0             	lea    -0x30(%edx),%eax
    148d:	3c 09                	cmp    $0x9,%al
    148f:	b8 00 00 00 00       	mov    $0x0,%eax
    1494:	77 1f                	ja     14b5 <atoi+0x35>
    1496:	8d 76 00             	lea    0x0(%esi),%esi
    1499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    14a0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    14a3:	83 c1 01             	add    $0x1,%ecx
    14a6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
    14aa:	0f be 11             	movsbl (%ecx),%edx
    14ad:	8d 5a d0             	lea    -0x30(%edx),%ebx
    14b0:	80 fb 09             	cmp    $0x9,%bl
    14b3:	76 eb                	jbe    14a0 <atoi+0x20>
    14b5:	5b                   	pop    %ebx
    14b6:	5d                   	pop    %ebp
    14b7:	c3                   	ret    
    14b8:	90                   	nop
    14b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000014c0 <memmove>:
    14c0:	55                   	push   %ebp
    14c1:	89 e5                	mov    %esp,%ebp
    14c3:	56                   	push   %esi
    14c4:	53                   	push   %ebx
    14c5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    14c8:	8b 45 08             	mov    0x8(%ebp),%eax
    14cb:	8b 75 0c             	mov    0xc(%ebp),%esi
    14ce:	85 db                	test   %ebx,%ebx
    14d0:	7e 14                	jle    14e6 <memmove+0x26>
    14d2:	31 d2                	xor    %edx,%edx
    14d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    14d8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    14dc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    14df:	83 c2 01             	add    $0x1,%edx
    14e2:	39 d3                	cmp    %edx,%ebx
    14e4:	75 f2                	jne    14d8 <memmove+0x18>
    14e6:	5b                   	pop    %ebx
    14e7:	5e                   	pop    %esi
    14e8:	5d                   	pop    %ebp
    14e9:	c3                   	ret    

000014ea <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    14ea:	b8 01 00 00 00       	mov    $0x1,%eax
    14ef:	cd 40                	int    $0x40
    14f1:	c3                   	ret    

000014f2 <exit>:
SYSCALL(exit)
    14f2:	b8 02 00 00 00       	mov    $0x2,%eax
    14f7:	cd 40                	int    $0x40
    14f9:	c3                   	ret    

000014fa <wait>:
SYSCALL(wait)
    14fa:	b8 03 00 00 00       	mov    $0x3,%eax
    14ff:	cd 40                	int    $0x40
    1501:	c3                   	ret    

00001502 <pipe>:
SYSCALL(pipe)
    1502:	b8 04 00 00 00       	mov    $0x4,%eax
    1507:	cd 40                	int    $0x40
    1509:	c3                   	ret    

0000150a <read>:
SYSCALL(read)
    150a:	b8 05 00 00 00       	mov    $0x5,%eax
    150f:	cd 40                	int    $0x40
    1511:	c3                   	ret    

00001512 <write>:
SYSCALL(write)
    1512:	b8 10 00 00 00       	mov    $0x10,%eax
    1517:	cd 40                	int    $0x40
    1519:	c3                   	ret    

0000151a <close>:
SYSCALL(close)
    151a:	b8 15 00 00 00       	mov    $0x15,%eax
    151f:	cd 40                	int    $0x40
    1521:	c3                   	ret    

00001522 <kill>:
SYSCALL(kill)
    1522:	b8 06 00 00 00       	mov    $0x6,%eax
    1527:	cd 40                	int    $0x40
    1529:	c3                   	ret    

0000152a <exec>:
SYSCALL(exec)
    152a:	b8 07 00 00 00       	mov    $0x7,%eax
    152f:	cd 40                	int    $0x40
    1531:	c3                   	ret    

00001532 <open>:
SYSCALL(open)
    1532:	b8 0f 00 00 00       	mov    $0xf,%eax
    1537:	cd 40                	int    $0x40
    1539:	c3                   	ret    

0000153a <mknod>:
SYSCALL(mknod)
    153a:	b8 11 00 00 00       	mov    $0x11,%eax
    153f:	cd 40                	int    $0x40
    1541:	c3                   	ret    

00001542 <unlink>:
SYSCALL(unlink)
    1542:	b8 12 00 00 00       	mov    $0x12,%eax
    1547:	cd 40                	int    $0x40
    1549:	c3                   	ret    

0000154a <fstat>:
SYSCALL(fstat)
    154a:	b8 08 00 00 00       	mov    $0x8,%eax
    154f:	cd 40                	int    $0x40
    1551:	c3                   	ret    

00001552 <link>:
SYSCALL(link)
    1552:	b8 13 00 00 00       	mov    $0x13,%eax
    1557:	cd 40                	int    $0x40
    1559:	c3                   	ret    

0000155a <mkdir>:
SYSCALL(mkdir)
    155a:	b8 14 00 00 00       	mov    $0x14,%eax
    155f:	cd 40                	int    $0x40
    1561:	c3                   	ret    

00001562 <chdir>:
SYSCALL(chdir)
    1562:	b8 09 00 00 00       	mov    $0x9,%eax
    1567:	cd 40                	int    $0x40
    1569:	c3                   	ret    

0000156a <dup>:
SYSCALL(dup)
    156a:	b8 0a 00 00 00       	mov    $0xa,%eax
    156f:	cd 40                	int    $0x40
    1571:	c3                   	ret    

00001572 <getpid>:
SYSCALL(getpid)
    1572:	b8 0b 00 00 00       	mov    $0xb,%eax
    1577:	cd 40                	int    $0x40
    1579:	c3                   	ret    

0000157a <sbrk>:
SYSCALL(sbrk)
    157a:	b8 0c 00 00 00       	mov    $0xc,%eax
    157f:	cd 40                	int    $0x40
    1581:	c3                   	ret    

00001582 <sleep>:
SYSCALL(sleep)
    1582:	b8 0d 00 00 00       	mov    $0xd,%eax
    1587:	cd 40                	int    $0x40
    1589:	c3                   	ret    

0000158a <uptime>:
SYSCALL(uptime)
    158a:	b8 0e 00 00 00       	mov    $0xe,%eax
    158f:	cd 40                	int    $0x40
    1591:	c3                   	ret    

00001592 <cpuhalt>:
SYSCALL(cpuhalt)
    1592:	b8 16 00 00 00       	mov    $0x16,%eax
    1597:	cd 40                	int    $0x40
    1599:	c3                   	ret    
    159a:	66 90                	xchg   %ax,%ax
    159c:	66 90                	xchg   %ax,%ax
    159e:	66 90                	xchg   %ax,%ax

000015a0 <printint.constprop.1>:
    15a0:	55                   	push   %ebp
    15a1:	89 e5                	mov    %esp,%ebp
    15a3:	57                   	push   %edi
    15a4:	56                   	push   %esi
    15a5:	53                   	push   %ebx
    15a6:	89 d6                	mov    %edx,%esi
    15a8:	83 ec 3c             	sub    $0x3c,%esp
    15ab:	85 c0                	test   %eax,%eax
    15ad:	79 71                	jns    1620 <printint.constprop.1+0x80>
    15af:	83 e1 01             	and    $0x1,%ecx
    15b2:	74 6c                	je     1620 <printint.constprop.1+0x80>
    15b4:	f7 d8                	neg    %eax
    15b6:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    15bd:	31 c9                	xor    %ecx,%ecx
    15bf:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    15c2:	eb 06                	jmp    15ca <printint.constprop.1+0x2a>
    15c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    15c8:	89 f9                	mov    %edi,%ecx
    15ca:	31 d2                	xor    %edx,%edx
    15cc:	8d 79 01             	lea    0x1(%ecx),%edi
    15cf:	f7 f6                	div    %esi
    15d1:	0f b6 92 f4 1c 00 00 	movzbl 0x1cf4(%edx),%edx
    15d8:	85 c0                	test   %eax,%eax
    15da:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
    15dd:	75 e9                	jne    15c8 <printint.constprop.1+0x28>
    15df:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    15e2:	85 c0                	test   %eax,%eax
    15e4:	74 08                	je     15ee <printint.constprop.1+0x4e>
    15e6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    15eb:	8d 79 02             	lea    0x2(%ecx),%edi
    15ee:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    15f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    15f8:	0f b6 06             	movzbl (%esi),%eax
    15fb:	83 ec 04             	sub    $0x4,%esp
    15fe:	83 ee 01             	sub    $0x1,%esi
    1601:	6a 01                	push   $0x1
    1603:	53                   	push   %ebx
    1604:	6a 01                	push   $0x1
    1606:	88 45 d7             	mov    %al,-0x29(%ebp)
    1609:	e8 04 ff ff ff       	call   1512 <write>
    160e:	83 c4 10             	add    $0x10,%esp
    1611:	39 de                	cmp    %ebx,%esi
    1613:	75 e3                	jne    15f8 <printint.constprop.1+0x58>
    1615:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1618:	5b                   	pop    %ebx
    1619:	5e                   	pop    %esi
    161a:	5f                   	pop    %edi
    161b:	5d                   	pop    %ebp
    161c:	c3                   	ret    
    161d:	8d 76 00             	lea    0x0(%esi),%esi
    1620:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1627:	eb 94                	jmp    15bd <printint.constprop.1+0x1d>
    1629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001630 <vprintf.constprop.0>:
    1630:	55                   	push   %ebp
    1631:	89 e5                	mov    %esp,%ebp
    1633:	57                   	push   %edi
    1634:	56                   	push   %esi
    1635:	53                   	push   %ebx
    1636:	89 d6                	mov    %edx,%esi
    1638:	83 ec 2c             	sub    $0x2c,%esp
    163b:	0f b6 10             	movzbl (%eax),%edx
    163e:	84 d2                	test   %dl,%dl
    1640:	0f 84 cd 00 00 00    	je     1713 <vprintf.constprop.0+0xe3>
    1646:	8d 58 01             	lea    0x1(%eax),%ebx
    1649:	31 ff                	xor    %edi,%edi
    164b:	eb 31                	jmp    167e <vprintf.constprop.0+0x4e>
    164d:	8d 76 00             	lea    0x0(%esi),%esi
    1650:	83 f8 25             	cmp    $0x25,%eax
    1653:	0f 84 c7 00 00 00    	je     1720 <vprintf.constprop.0+0xf0>
    1659:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    165c:	83 ec 04             	sub    $0x4,%esp
    165f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
    1662:	6a 01                	push   $0x1
    1664:	50                   	push   %eax
    1665:	6a 01                	push   $0x1
    1667:	e8 a6 fe ff ff       	call   1512 <write>
    166c:	83 c4 10             	add    $0x10,%esp
    166f:	83 c3 01             	add    $0x1,%ebx
    1672:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1676:	84 d2                	test   %dl,%dl
    1678:	0f 84 95 00 00 00    	je     1713 <vprintf.constprop.0+0xe3>
    167e:	85 ff                	test   %edi,%edi
    1680:	0f b6 c2             	movzbl %dl,%eax
    1683:	74 cb                	je     1650 <vprintf.constprop.0+0x20>
    1685:	83 ff 25             	cmp    $0x25,%edi
    1688:	75 e5                	jne    166f <vprintf.constprop.0+0x3f>
    168a:	83 f8 64             	cmp    $0x64,%eax
    168d:	8d 7e 04             	lea    0x4(%esi),%edi
    1690:	b9 01 00 00 00       	mov    $0x1,%ecx
    1695:	0f 84 9a 00 00 00    	je     1735 <vprintf.constprop.0+0x105>
    169b:	83 f8 6c             	cmp    $0x6c,%eax
    169e:	0f 84 8c 00 00 00    	je     1730 <vprintf.constprop.0+0x100>
    16a4:	83 f8 78             	cmp    $0x78,%eax
    16a7:	0f 84 a3 00 00 00    	je     1750 <vprintf.constprop.0+0x120>
    16ad:	83 f8 70             	cmp    $0x70,%eax
    16b0:	0f 84 ca 00 00 00    	je     1780 <vprintf.constprop.0+0x150>
    16b6:	83 f8 73             	cmp    $0x73,%eax
    16b9:	0f 84 39 01 00 00    	je     17f8 <vprintf.constprop.0+0x1c8>
    16bf:	83 f8 63             	cmp    $0x63,%eax
    16c2:	0f 84 68 01 00 00    	je     1830 <vprintf.constprop.0+0x200>
    16c8:	83 f8 25             	cmp    $0x25,%eax
    16cb:	0f 84 9f 00 00 00    	je     1770 <vprintf.constprop.0+0x140>
    16d1:	8d 45 df             	lea    -0x21(%ebp),%eax
    16d4:	83 ec 04             	sub    $0x4,%esp
    16d7:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    16da:	6a 01                	push   $0x1
    16dc:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
    16e0:	50                   	push   %eax
    16e1:	6a 01                	push   $0x1
    16e3:	e8 2a fe ff ff       	call   1512 <write>
    16e8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    16ec:	83 c4 0c             	add    $0xc,%esp
    16ef:	8d 45 e0             	lea    -0x20(%ebp),%eax
    16f2:	6a 01                	push   $0x1
    16f4:	88 55 e0             	mov    %dl,-0x20(%ebp)
    16f7:	50                   	push   %eax
    16f8:	6a 01                	push   $0x1
    16fa:	83 c3 01             	add    $0x1,%ebx
    16fd:	31 ff                	xor    %edi,%edi
    16ff:	e8 0e fe ff ff       	call   1512 <write>
    1704:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1708:	83 c4 10             	add    $0x10,%esp
    170b:	84 d2                	test   %dl,%dl
    170d:	0f 85 6b ff ff ff    	jne    167e <vprintf.constprop.0+0x4e>
    1713:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1716:	5b                   	pop    %ebx
    1717:	5e                   	pop    %esi
    1718:	5f                   	pop    %edi
    1719:	5d                   	pop    %ebp
    171a:	c3                   	ret    
    171b:	90                   	nop
    171c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1720:	bf 25 00 00 00       	mov    $0x25,%edi
    1725:	e9 45 ff ff ff       	jmp    166f <vprintf.constprop.0+0x3f>
    172a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1730:	8d 7e 04             	lea    0x4(%esi),%edi
    1733:	31 c9                	xor    %ecx,%ecx
    1735:	8b 06                	mov    (%esi),%eax
    1737:	ba 0a 00 00 00       	mov    $0xa,%edx
    173c:	89 fe                	mov    %edi,%esi
    173e:	31 ff                	xor    %edi,%edi
    1740:	e8 5b fe ff ff       	call   15a0 <printint.constprop.1>
    1745:	e9 25 ff ff ff       	jmp    166f <vprintf.constprop.0+0x3f>
    174a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1750:	8b 06                	mov    (%esi),%eax
    1752:	8d 7e 04             	lea    0x4(%esi),%edi
    1755:	31 c9                	xor    %ecx,%ecx
    1757:	ba 10 00 00 00       	mov    $0x10,%edx
    175c:	89 fe                	mov    %edi,%esi
    175e:	31 ff                	xor    %edi,%edi
    1760:	e8 3b fe ff ff       	call   15a0 <printint.constprop.1>
    1765:	e9 05 ff ff ff       	jmp    166f <vprintf.constprop.0+0x3f>
    176a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1770:	83 ec 04             	sub    $0x4,%esp
    1773:	88 55 e1             	mov    %dl,-0x1f(%ebp)
    1776:	8d 45 e1             	lea    -0x1f(%ebp),%eax
    1779:	6a 01                	push   $0x1
    177b:	e9 77 ff ff ff       	jmp    16f7 <vprintf.constprop.0+0xc7>
    1780:	8d 46 04             	lea    0x4(%esi),%eax
    1783:	83 ec 04             	sub    $0x4,%esp
    1786:	8b 3e                	mov    (%esi),%edi
    1788:	6a 01                	push   $0x1
    178a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
    178e:	be 08 00 00 00       	mov    $0x8,%esi
    1793:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1796:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1799:	50                   	push   %eax
    179a:	6a 01                	push   $0x1
    179c:	e8 71 fd ff ff       	call   1512 <write>
    17a1:	8d 45 e7             	lea    -0x19(%ebp),%eax
    17a4:	83 c4 0c             	add    $0xc,%esp
    17a7:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
    17ab:	6a 01                	push   $0x1
    17ad:	50                   	push   %eax
    17ae:	6a 01                	push   $0x1
    17b0:	e8 5d fd ff ff       	call   1512 <write>
    17b5:	83 c4 10             	add    $0x10,%esp
    17b8:	90                   	nop
    17b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    17c0:	89 f8                	mov    %edi,%eax
    17c2:	83 ec 04             	sub    $0x4,%esp
    17c5:	c1 e7 04             	shl    $0x4,%edi
    17c8:	c1 e8 1c             	shr    $0x1c,%eax
    17cb:	6a 01                	push   $0x1
    17cd:	0f b6 80 f4 1c 00 00 	movzbl 0x1cf4(%eax),%eax
    17d4:	88 45 e5             	mov    %al,-0x1b(%ebp)
    17d7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    17da:	50                   	push   %eax
    17db:	6a 01                	push   $0x1
    17dd:	e8 30 fd ff ff       	call   1512 <write>
    17e2:	83 c4 10             	add    $0x10,%esp
    17e5:	83 ee 01             	sub    $0x1,%esi
    17e8:	75 d6                	jne    17c0 <vprintf.constprop.0+0x190>
    17ea:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    17ed:	31 ff                	xor    %edi,%edi
    17ef:	e9 7b fe ff ff       	jmp    166f <vprintf.constprop.0+0x3f>
    17f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    17f8:	8b 3e                	mov    (%esi),%edi
    17fa:	8d 46 04             	lea    0x4(%esi),%eax
    17fd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1800:	85 ff                	test   %edi,%edi
    1802:	74 50                	je     1854 <vprintf.constprop.0+0x224>
    1804:	0f b6 07             	movzbl (%edi),%eax
    1807:	84 c0                	test   %al,%al
    1809:	74 df                	je     17ea <vprintf.constprop.0+0x1ba>
    180b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
    180e:	66 90                	xchg   %ax,%ax
    1810:	83 ec 04             	sub    $0x4,%esp
    1813:	83 c7 01             	add    $0x1,%edi
    1816:	88 45 e3             	mov    %al,-0x1d(%ebp)
    1819:	6a 01                	push   $0x1
    181b:	56                   	push   %esi
    181c:	6a 01                	push   $0x1
    181e:	e8 ef fc ff ff       	call   1512 <write>
    1823:	0f b6 07             	movzbl (%edi),%eax
    1826:	83 c4 10             	add    $0x10,%esp
    1829:	84 c0                	test   %al,%al
    182b:	75 e3                	jne    1810 <vprintf.constprop.0+0x1e0>
    182d:	eb bb                	jmp    17ea <vprintf.constprop.0+0x1ba>
    182f:	90                   	nop
    1830:	8b 06                	mov    (%esi),%eax
    1832:	83 ec 04             	sub    $0x4,%esp
    1835:	8d 7e 04             	lea    0x4(%esi),%edi
    1838:	6a 01                	push   $0x1
    183a:	89 fe                	mov    %edi,%esi
    183c:	31 ff                	xor    %edi,%edi
    183e:	88 45 e2             	mov    %al,-0x1e(%ebp)
    1841:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1844:	50                   	push   %eax
    1845:	6a 01                	push   $0x1
    1847:	e8 c6 fc ff ff       	call   1512 <write>
    184c:	83 c4 10             	add    $0x10,%esp
    184f:	e9 1b fe ff ff       	jmp    166f <vprintf.constprop.0+0x3f>
    1854:	bf ec 1c 00 00       	mov    $0x1cec,%edi
    1859:	b8 28 00 00 00       	mov    $0x28,%eax
    185e:	eb ab                	jmp    180b <vprintf.constprop.0+0x1db>

00001860 <fprintf>:
    1860:	55                   	push   %ebp
    1861:	89 e5                	mov    %esp,%ebp
    1863:	83 ec 08             	sub    $0x8,%esp
    1866:	8b 45 0c             	mov    0xc(%ebp),%eax
    1869:	8d 55 10             	lea    0x10(%ebp),%edx
    186c:	e8 bf fd ff ff       	call   1630 <vprintf.constprop.0>
    1871:	c9                   	leave  
    1872:	c3                   	ret    
    1873:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001880 <printf>:
    1880:	55                   	push   %ebp
    1881:	89 e5                	mov    %esp,%ebp
    1883:	83 ec 08             	sub    $0x8,%esp
    1886:	8b 45 08             	mov    0x8(%ebp),%eax
    1889:	8d 55 0c             	lea    0xc(%ebp),%edx
    188c:	e8 9f fd ff ff       	call   1630 <vprintf.constprop.0>
    1891:	c9                   	leave  
    1892:	c3                   	ret    
    1893:	66 90                	xchg   %ax,%ax
    1895:	66 90                	xchg   %ax,%ax
    1897:	66 90                	xchg   %ax,%ax
    1899:	66 90                	xchg   %ax,%ax
    189b:	66 90                	xchg   %ax,%ax
    189d:	66 90                	xchg   %ax,%ax
    189f:	90                   	nop

000018a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    18a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18a1:	a1 88 29 00 00       	mov    0x2988,%eax
{
    18a6:	89 e5                	mov    %esp,%ebp
    18a8:	57                   	push   %edi
    18a9:	56                   	push   %esi
    18aa:	53                   	push   %ebx
    18ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    18ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    18b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18b8:	39 c8                	cmp    %ecx,%eax
    18ba:	8b 10                	mov    (%eax),%edx
    18bc:	73 32                	jae    18f0 <free+0x50>
    18be:	39 d1                	cmp    %edx,%ecx
    18c0:	72 04                	jb     18c6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    18c2:	39 d0                	cmp    %edx,%eax
    18c4:	72 32                	jb     18f8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    18c6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    18c9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    18cc:	39 fa                	cmp    %edi,%edx
    18ce:	74 30                	je     1900 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    18d0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    18d3:	8b 50 04             	mov    0x4(%eax),%edx
    18d6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    18d9:	39 f1                	cmp    %esi,%ecx
    18db:	74 3a                	je     1917 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    18dd:	89 08                	mov    %ecx,(%eax)
  freep = p;
    18df:	a3 88 29 00 00       	mov    %eax,0x2988
}
    18e4:	5b                   	pop    %ebx
    18e5:	5e                   	pop    %esi
    18e6:	5f                   	pop    %edi
    18e7:	5d                   	pop    %ebp
    18e8:	c3                   	ret    
    18e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    18f0:	39 d0                	cmp    %edx,%eax
    18f2:	72 04                	jb     18f8 <free+0x58>
    18f4:	39 d1                	cmp    %edx,%ecx
    18f6:	72 ce                	jb     18c6 <free+0x26>
{
    18f8:	89 d0                	mov    %edx,%eax
    18fa:	eb bc                	jmp    18b8 <free+0x18>
    18fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1900:	03 72 04             	add    0x4(%edx),%esi
    1903:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1906:	8b 10                	mov    (%eax),%edx
    1908:	8b 12                	mov    (%edx),%edx
    190a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    190d:	8b 50 04             	mov    0x4(%eax),%edx
    1910:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1913:	39 f1                	cmp    %esi,%ecx
    1915:	75 c6                	jne    18dd <free+0x3d>
    p->s.size += bp->s.size;
    1917:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    191a:	a3 88 29 00 00       	mov    %eax,0x2988
    p->s.size += bp->s.size;
    191f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1922:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1925:	89 10                	mov    %edx,(%eax)
}
    1927:	5b                   	pop    %ebx
    1928:	5e                   	pop    %esi
    1929:	5f                   	pop    %edi
    192a:	5d                   	pop    %ebp
    192b:	c3                   	ret    
    192c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001930 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1930:	55                   	push   %ebp
    1931:	89 e5                	mov    %esp,%ebp
    1933:	57                   	push   %edi
    1934:	56                   	push   %esi
    1935:	53                   	push   %ebx
    1936:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1939:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    193c:	8b 15 88 29 00 00    	mov    0x2988,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1942:	8d 78 07             	lea    0x7(%eax),%edi
    1945:	c1 ef 03             	shr    $0x3,%edi
    1948:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    194b:	85 d2                	test   %edx,%edx
    194d:	0f 84 9d 00 00 00    	je     19f0 <malloc+0xc0>
    1953:	8b 02                	mov    (%edx),%eax
    1955:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1958:	39 cf                	cmp    %ecx,%edi
    195a:	76 6c                	jbe    19c8 <malloc+0x98>
    195c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1962:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1967:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    196a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1971:	eb 0e                	jmp    1981 <malloc+0x51>
    1973:	90                   	nop
    1974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1978:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    197a:	8b 48 04             	mov    0x4(%eax),%ecx
    197d:	39 f9                	cmp    %edi,%ecx
    197f:	73 47                	jae    19c8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1981:	39 05 88 29 00 00    	cmp    %eax,0x2988
    1987:	89 c2                	mov    %eax,%edx
    1989:	75 ed                	jne    1978 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    198b:	83 ec 0c             	sub    $0xc,%esp
    198e:	56                   	push   %esi
    198f:	e8 e6 fb ff ff       	call   157a <sbrk>
  if(p == (char*)-1)
    1994:	83 c4 10             	add    $0x10,%esp
    1997:	83 f8 ff             	cmp    $0xffffffff,%eax
    199a:	74 1c                	je     19b8 <malloc+0x88>
  hp->s.size = nu;
    199c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    199f:	83 ec 0c             	sub    $0xc,%esp
    19a2:	83 c0 08             	add    $0x8,%eax
    19a5:	50                   	push   %eax
    19a6:	e8 f5 fe ff ff       	call   18a0 <free>
  return freep;
    19ab:	8b 15 88 29 00 00    	mov    0x2988,%edx
      if((p = morecore(nunits)) == 0)
    19b1:	83 c4 10             	add    $0x10,%esp
    19b4:	85 d2                	test   %edx,%edx
    19b6:	75 c0                	jne    1978 <malloc+0x48>
        return 0;
  }
}
    19b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    19bb:	31 c0                	xor    %eax,%eax
}
    19bd:	5b                   	pop    %ebx
    19be:	5e                   	pop    %esi
    19bf:	5f                   	pop    %edi
    19c0:	5d                   	pop    %ebp
    19c1:	c3                   	ret    
    19c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    19c8:	39 cf                	cmp    %ecx,%edi
    19ca:	74 54                	je     1a20 <malloc+0xf0>
        p->s.size -= nunits;
    19cc:	29 f9                	sub    %edi,%ecx
    19ce:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    19d1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    19d4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    19d7:	89 15 88 29 00 00    	mov    %edx,0x2988
}
    19dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    19e0:	83 c0 08             	add    $0x8,%eax
}
    19e3:	5b                   	pop    %ebx
    19e4:	5e                   	pop    %esi
    19e5:	5f                   	pop    %edi
    19e6:	5d                   	pop    %ebp
    19e7:	c3                   	ret    
    19e8:	90                   	nop
    19e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    19f0:	c7 05 88 29 00 00 8c 	movl   $0x298c,0x2988
    19f7:	29 00 00 
    19fa:	c7 05 8c 29 00 00 8c 	movl   $0x298c,0x298c
    1a01:	29 00 00 
    base.s.size = 0;
    1a04:	b8 8c 29 00 00       	mov    $0x298c,%eax
    1a09:	c7 05 90 29 00 00 00 	movl   $0x0,0x2990
    1a10:	00 00 00 
    1a13:	e9 44 ff ff ff       	jmp    195c <malloc+0x2c>
    1a18:	90                   	nop
    1a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1a20:	8b 08                	mov    (%eax),%ecx
    1a22:	89 0a                	mov    %ecx,(%edx)
    1a24:	eb b1                	jmp    19d7 <malloc+0xa7>
