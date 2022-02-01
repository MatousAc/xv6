
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
      11:	81 ec f8 07 00 00    	sub    $0x7f8,%esp
      17:	8b 01                	mov    (%ecx),%eax
      19:	8b 51 04             	mov    0x4(%ecx),%edx
  // arg czeching
  if (argc < 2) {
      1c:	83 f8 01             	cmp    $0x1,%eax
      1f:	0f 8e a0 02 00 00    	jle    2c5 <main+0x2c5>
    fprintf(2, "specify a file you want to edit");
    exit();
  } else if (argc > 2) {
      25:	83 f8 02             	cmp    $0x2,%eax
      28:	0f 85 93 01 00 00    	jne    1c1 <main+0x1c1>
    fprintf(2, "only specify one file");
    exit();
  }
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
      5c:	c7 85 14 f8 ff ff 00 	movl   $0x0,-0x7ec(%ebp)
      63:	00 00 00 
  char args[MAXLINESIZE] = "";
      66:	f3 ab                	rep stos %eax,%es:(%edi)
  file.filename = argv[1];
      68:	8b 42 04             	mov    0x4(%edx),%eax
      6b:	89 85 08 f8 ff ff    	mov    %eax,-0x7f8(%ebp)
  file.lines = MakeLinkedList();
      71:	e8 5a 04 00 00       	call   4d0 <MakeLinkedList>
      76:	89 85 10 f8 ff ff    	mov    %eax,-0x7f0(%ebp)
  fprintf(2, "Welcome to xvEdit!\n");
      7c:	50                   	push   %eax
      7d:	50                   	push   %eax
      7e:	68 8a 1a 00 00       	push   $0x1a8a
      83:	6a 02                	push   $0x2
      85:	e8 76 17 00 00       	call   1800 <fprintf>

  // opening
  file.fd = open(file.filename, O_RDONLY);
      8a:	58                   	pop    %eax
      8b:	5a                   	pop    %edx
      8c:	6a 00                	push   $0x0
      8e:	ff b5 08 f8 ff ff    	pushl  -0x7f8(%ebp)
      94:	e8 39 14 00 00       	call   14d2 <open>
  if (file.fd == -1) {
      99:	83 c4 10             	add    $0x10,%esp
  file.fd = open(file.filename, O_RDONLY);
      9c:	89 85 0c f8 ff ff    	mov    %eax,-0x7f4(%ebp)
  if (file.fd == -1) {
      a2:	83 c0 01             	add    $0x1,%eax
      a5:	0f 84 49 02 00 00    	je     2f4 <main+0x2f4>
    fprintf(2, "creating %s...\n",  file.filename);
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
    close(file.fd);
  } else { // populate Linked List
    gatherLines(&file);
      ab:	8d 85 08 f8 ff ff    	lea    -0x7f8(%ebp),%eax
      b1:	83 ec 0c             	sub    $0xc,%esp
      b4:	50                   	push   %eax
      b5:	89 85 04 f8 ff ff    	mov    %eax,-0x7fc(%ebp)
      bb:	e8 30 06 00 00       	call   6f0 <gatherLines>
      c0:	83 c4 10             	add    $0x10,%esp
  }
  close(file.fd);
      c3:	83 ec 0c             	sub    $0xc,%esp
      c6:	ff b5 0c f8 ff ff    	pushl  -0x7f4(%ebp)
      cc:	8d 9d 18 f8 ff ff    	lea    -0x7e8(%ebp),%ebx
      d2:	e8 e3 13 00 00       	call   14ba <close>
      d7:	83 c4 10             	add    $0x10,%esp
      da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  // xvEdit>
  while (cmd != QUIT) {
    fprintf(2, "xvEdit> ");
      e0:	83 ec 08             	sub    $0x8,%esp
      e3:	68 ae 1a 00 00       	push   $0x1aae
      e8:	6a 02                	push   $0x2
      ea:	e8 11 17 00 00       	call   1800 <fprintf>
    memset(buf, 0, nbuf);
      ef:	83 c4 0c             	add    $0xc,%esp
      f2:	68 e8 03 00 00       	push   $0x3e8
      f7:	6a 00                	push   $0x0
      f9:	68 40 25 00 00       	push   $0x2540
      fe:	e8 ed 11 00 00       	call   12f0 <memset>
    gets(buf, nbuf);
     103:	5a                   	pop    %edx
     104:	59                   	pop    %ecx
     105:	68 e8 03 00 00       	push   $0x3e8
     10a:	68 40 25 00 00       	push   $0x2540
     10f:	e8 3c 12 00 00       	call   1350 <gets>
    
    unline(buf);
     114:	c7 04 24 40 25 00 00 	movl   $0x2540,(%esp)
     11b:	e8 c0 0a 00 00       	call   be0 <unline>
    substr(cmdstr, buf, 0, 4);
     120:	6a 04                	push   $0x4
     122:	6a 00                	push   $0x0
     124:	68 40 25 00 00       	push   $0x2540
     129:	53                   	push   %ebx
     12a:	e8 e1 06 00 00       	call   810 <substr>
  return atoi(str);
}

void toUpper(char* str) {
  int i = 0;
  while (str[i] != '\0') {
     12f:	0f b6 85 18 f8 ff ff 	movzbl -0x7e8(%ebp),%eax
     136:	83 c4 20             	add    $0x20,%esp
     139:	84 c0                	test   %al,%al
     13b:	74 1a                	je     157 <main+0x157>
     13d:	89 da                	mov    %ebx,%edx
     13f:	90                   	nop
    char c = str[i];
    if (c <= 'z' && c >= 'a')
     140:	8d 48 9f             	lea    -0x61(%eax),%ecx
     143:	80 f9 19             	cmp    $0x19,%cl
     146:	77 05                	ja     14d <main+0x14d>
      str[i] += ('Z' - 'z');
     148:	83 e8 20             	sub    $0x20,%eax
     14b:	88 02                	mov    %al,(%edx)
     14d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     150:	0f b6 02             	movzbl (%edx),%eax
     153:	84 c0                	test   %al,%al
     155:	75 e9                	jne    140 <main+0x140>
    toUpper(cmdstr);
    substr(args, buf, strlen(cmdstr) + 1, strlen(buf));
     157:	83 ec 0c             	sub    $0xc,%esp
     15a:	68 40 25 00 00       	push   $0x2540
     15f:	e8 5c 11 00 00       	call   12c0 <strlen>
     164:	89 1c 24             	mov    %ebx,(%esp)
     167:	89 c6                	mov    %eax,%esi
     169:	e8 52 11 00 00       	call   12c0 <strlen>
     16e:	83 c0 01             	add    $0x1,%eax
     171:	56                   	push   %esi
     172:	50                   	push   %eax
     173:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     179:	68 40 25 00 00       	push   $0x2540
     17e:	50                   	push   %eax
     17f:	e8 8c 06 00 00       	call   810 <substr>

    if      (strcmp(cmdstr, "@END") == 0) {cmd = END;}
     184:	83 c4 18             	add    $0x18,%esp
     187:	68 b7 1a 00 00       	push   $0x1ab7
     18c:	53                   	push   %ebx
     18d:	e8 de 10 00 00       	call   1270 <strcmp>
     192:	83 c4 10             	add    $0x10,%esp
     195:	85 c0                	test   %eax,%eax
     197:	75 3f                	jne    1d8 <main+0x1d8>
}

// commands
void end(struct File* file, char* args) {
  char* line = args;
  append(file->lines, line);
     199:	8b 85 10 f8 ff ff    	mov    -0x7f0(%ebp),%eax
  atPos->prev = new;
  list->len++;
}

void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     19f:	8d bd 00 fc ff ff    	lea    -0x400(%ebp),%edi
     1a5:	83 ec 04             	sub    $0x4,%esp
     1a8:	ff 70 08             	pushl  0x8(%eax)
     1ab:	57                   	push   %edi
     1ac:	50                   	push   %eax
     1ad:	e8 8e 03 00 00       	call   540 <insert>
  file->len++;
     1b2:	83 85 14 f8 ff ff 01 	addl   $0x1,-0x7ec(%ebp)
     1b9:	83 c4 10             	add    $0x10,%esp
     1bc:	e9 1f ff ff ff       	jmp    e0 <main+0xe0>
    fprintf(2, "only specify one file");
     1c1:	51                   	push   %ecx
     1c2:	51                   	push   %ecx
     1c3:	68 74 1a 00 00       	push   $0x1a74
     1c8:	6a 02                	push   $0x2
     1ca:	e8 31 16 00 00       	call   1800 <fprintf>
    exit();
     1cf:	e8 be 12 00 00       	call   1492 <exit>
     1d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if (strcmp(cmdstr, "ADD<") == 0) {cmd = ADD;}
     1d8:	83 ec 08             	sub    $0x8,%esp
     1db:	68 bc 1a 00 00       	push   $0x1abc
     1e0:	53                   	push   %ebx
     1e1:	e8 8a 10 00 00       	call   1270 <strcmp>
     1e6:	83 c4 10             	add    $0x10,%esp
     1e9:	85 c0                	test   %eax,%eax
     1eb:	0f 84 9c 00 00 00    	je     28d <main+0x28d>
    else if (strcmp(cmdstr, "DROP") == 0) {cmd = DROP;}
     1f1:	50                   	push   %eax
     1f2:	50                   	push   %eax
     1f3:	68 c1 1a 00 00       	push   $0x1ac1
     1f8:	53                   	push   %ebx
     1f9:	e8 72 10 00 00       	call   1270 <strcmp>
     1fe:	83 c4 10             	add    $0x10,%esp
     201:	85 c0                	test   %eax,%eax
     203:	0f 84 a0 00 00 00    	je     2a9 <main+0x2a9>
    else if (strcmp(cmdstr, "EDIT") == 0) {cmd = EDIT;}
     209:	50                   	push   %eax
     20a:	50                   	push   %eax
     20b:	68 c6 1a 00 00       	push   $0x1ac6
     210:	53                   	push   %ebx
     211:	e8 5a 10 00 00       	call   1270 <strcmp>
     216:	83 c4 10             	add    $0x10,%esp
     219:	85 c0                	test   %eax,%eax
     21b:	0f 84 b7 00 00 00    	je     2d8 <main+0x2d8>
    else if (strcmp(cmdstr, "LIST") == 0) {cmd = LIST;}
     221:	50                   	push   %eax
     222:	50                   	push   %eax
     223:	68 cb 1a 00 00       	push   $0x1acb
     228:	53                   	push   %ebx
     229:	e8 42 10 00 00       	call   1270 <strcmp>
     22e:	83 c4 10             	add    $0x10,%esp
     231:	85 c0                	test   %eax,%eax
     233:	0f 84 02 01 00 00    	je     33b <main+0x33b>
    else if (strcmp(cmdstr, "SHOW") == 0) {cmd = SHOW;}
     239:	50                   	push   %eax
     23a:	50                   	push   %eax
     23b:	68 d0 1a 00 00       	push   $0x1ad0
     240:	53                   	push   %ebx
     241:	e8 2a 10 00 00       	call   1270 <strcmp>
     246:	83 c4 10             	add    $0x10,%esp
     249:	85 c0                	test   %eax,%eax
     24b:	0f 85 13 01 00 00    	jne    364 <main+0x364>
     251:	8b 85 10 f8 ff ff    	mov    -0x7f0(%ebp),%eax
  }
}

void show(struct File file, char* args) {
  struct Node* cur = file.lines->head->next;
  int lineNum = 1;
     257:	bf 01 00 00 00       	mov    $0x1,%edi
     25c:	89 85 00 f8 ff ff    	mov    %eax,-0x800(%ebp)
  struct Node* cur = file.lines->head->next;
     262:	8b 00                	mov    (%eax),%eax
     264:	8b 70 08             	mov    0x8(%eax),%esi
     267:	eb 14                	jmp    27d <main+0x27d>
  while (cur != file.lines->tail) {
    printl(lineNum, cur->data);
     269:	50                   	push   %eax
     26a:	50                   	push   %eax
     26b:	ff 76 04             	pushl  0x4(%esi)
     26e:	57                   	push   %edi
    cur = cur->next;
    lineNum++;
     26f:	83 c7 01             	add    $0x1,%edi
    printl(lineNum, cur->data);
     272:	e8 d9 09 00 00       	call   c50 <printl>
    cur = cur->next;
     277:	8b 76 08             	mov    0x8(%esi),%esi
    lineNum++;
     27a:	83 c4 10             	add    $0x10,%esp
  while (cur != file.lines->tail) {
     27d:	8b 85 00 f8 ff ff    	mov    -0x800(%ebp),%eax
     283:	3b 70 04             	cmp    0x4(%eax),%esi
     286:	75 e1                	jne    269 <main+0x269>
     288:	e9 53 fe ff ff       	jmp    e0 <main+0xe0>
      add(&file, args);
     28d:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     293:	52                   	push   %edx
     294:	52                   	push   %edx
     295:	50                   	push   %eax
     296:	ff b5 04 f8 ff ff    	pushl  -0x7fc(%ebp)
     29c:	e8 3f 0a 00 00       	call   ce0 <add>
     2a1:	83 c4 10             	add    $0x10,%esp
     2a4:	e9 37 fe ff ff       	jmp    e0 <main+0xe0>
      drop(&file, args);
     2a9:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     2af:	51                   	push   %ecx
     2b0:	51                   	push   %ecx
     2b1:	50                   	push   %eax
     2b2:	ff b5 04 f8 ff ff    	pushl  -0x7fc(%ebp)
     2b8:	e8 a3 0a 00 00       	call   d60 <drop>
     2bd:	83 c4 10             	add    $0x10,%esp
     2c0:	e9 1b fe ff ff       	jmp    e0 <main+0xe0>
    fprintf(2, "specify a file you want to edit");
     2c5:	53                   	push   %ebx
     2c6:	53                   	push   %ebx
     2c7:	68 54 1c 00 00       	push   $0x1c54
     2cc:	6a 02                	push   $0x2
     2ce:	e8 2d 15 00 00       	call   1800 <fprintf>
    exit();
     2d3:	e8 ba 11 00 00       	call   1492 <exit>
      edit(&file, args);
     2d8:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     2de:	56                   	push   %esi
     2df:	56                   	push   %esi
     2e0:	50                   	push   %eax
     2e1:	ff b5 04 f8 ff ff    	pushl  -0x7fc(%ebp)
     2e7:	e8 24 0c 00 00       	call   f10 <edit>
     2ec:	83 c4 10             	add    $0x10,%esp
     2ef:	e9 ec fd ff ff       	jmp    e0 <main+0xe0>
    fprintf(2, "creating %s...\n",  file.filename);
     2f4:	53                   	push   %ebx
     2f5:	ff b5 08 f8 ff ff    	pushl  -0x7f8(%ebp)
     2fb:	68 9e 1a 00 00       	push   $0x1a9e
     300:	6a 02                	push   $0x2
     302:	e8 f9 14 00 00       	call   1800 <fprintf>
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     307:	5e                   	pop    %esi
     308:	5f                   	pop    %edi
     309:	68 01 02 00 00       	push   $0x201
     30e:	ff b5 08 f8 ff ff    	pushl  -0x7f8(%ebp)
     314:	e8 b9 11 00 00       	call   14d2 <open>
    close(file.fd);
     319:	89 04 24             	mov    %eax,(%esp)
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     31c:	89 85 0c f8 ff ff    	mov    %eax,-0x7f4(%ebp)
    close(file.fd);
     322:	e8 93 11 00 00       	call   14ba <close>
     327:	8d 85 08 f8 ff ff    	lea    -0x7f8(%ebp),%eax
     32d:	83 c4 10             	add    $0x10,%esp
     330:	89 85 04 f8 ff ff    	mov    %eax,-0x7fc(%ebp)
     336:	e9 88 fd ff ff       	jmp    c3 <main+0xc3>
      list(file, args);
     33b:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     341:	83 ec 0c             	sub    $0xc,%esp
     344:	8b b5 04 f8 ff ff    	mov    -0x7fc(%ebp),%esi
     34a:	b9 04 00 00 00       	mov    $0x4,%ecx
     34f:	50                   	push   %eax
     350:	83 ec 10             	sub    $0x10,%esp
     353:	89 e7                	mov    %esp,%edi
     355:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
     357:	e8 44 0c 00 00       	call   fa0 <list>
     35c:	83 c4 20             	add    $0x20,%esp
     35f:	e9 7c fd ff ff       	jmp    e0 <main+0xe0>
    else if (strcmp(cmdstr, "QUIT") == 0) {cmd = QUIT;}
     364:	50                   	push   %eax
     365:	50                   	push   %eax
     366:	68 d5 1a 00 00       	push   $0x1ad5
     36b:	53                   	push   %ebx
     36c:	e8 ff 0e 00 00       	call   1270 <strcmp>
     371:	83 c4 10             	add    $0x10,%esp
     374:	85 c0                	test   %eax,%eax
     376:	74 16                	je     38e <main+0x38e>
  fprintf(2, "changes saved\n");
  return;
}

void bi() {
  fprintf(2, "bad bi input\n");
     378:	50                   	push   %eax
     379:	50                   	push   %eax
     37a:	68 da 1a 00 00       	push   $0x1ada
     37f:	6a 02                	push   $0x2
     381:	e8 7a 14 00 00       	call   1800 <fprintf>
     386:	83 c4 10             	add    $0x10,%esp
     389:	e9 52 fd ff ff       	jmp    e0 <main+0xe0>
      quit(&file);
     38e:	83 ec 0c             	sub    $0xc,%esp
     391:	ff b5 04 f8 ff ff    	pushl  -0x7fc(%ebp)
     397:	e8 74 0d 00 00       	call   1110 <quit>
  close(file.fd);
     39c:	5f                   	pop    %edi
     39d:	ff b5 0c f8 ff ff    	pushl  -0x7f4(%ebp)
     3a3:	e8 12 11 00 00       	call   14ba <close>
  exit();
     3a8:	e8 e5 10 00 00       	call   1492 <exit>
     3ad:	66 90                	xchg   %ax,%ax
     3af:	90                   	nop

000003b0 <safestrcpy>:
char* safestrcpy(char *s, const char *t, int n) {
     3b0:	55                   	push   %ebp
     3b1:	89 e5                	mov    %esp,%ebp
     3b3:	56                   	push   %esi
     3b4:	53                   	push   %ebx
     3b5:	8b 4d 10             	mov    0x10(%ebp),%ecx
     3b8:	8b 45 08             	mov    0x8(%ebp),%eax
     3bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  if(n <= 0)
     3be:	85 c9                	test   %ecx,%ecx
     3c0:	7e 26                	jle    3e8 <safestrcpy+0x38>
     3c2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
     3c6:	89 c1                	mov    %eax,%ecx
     3c8:	eb 17                	jmp    3e1 <safestrcpy+0x31>
     3ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while(--n > 0 && (*s++ = *t++) != 0)
     3d0:	83 c2 01             	add    $0x1,%edx
     3d3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
     3d7:	83 c1 01             	add    $0x1,%ecx
     3da:	84 db                	test   %bl,%bl
     3dc:	88 59 ff             	mov    %bl,-0x1(%ecx)
     3df:	74 04                	je     3e5 <safestrcpy+0x35>
     3e1:	39 f2                	cmp    %esi,%edx
     3e3:	75 eb                	jne    3d0 <safestrcpy+0x20>
  *s = 0;
     3e5:	c6 01 00             	movb   $0x0,(%ecx)
}
     3e8:	5b                   	pop    %ebx
     3e9:	5e                   	pop    %esi
     3ea:	5d                   	pop    %ebp
     3eb:	c3                   	ret    
     3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003f0 <nullNode>:
Node* nullNode(char* data) {
     3f0:	55                   	push   %ebp
     3f1:	89 e5                	mov    %esp,%ebp
     3f3:	83 ec 14             	sub    $0x14,%esp
  struct Node* node = malloc(sizeof(Node));
     3f6:	6a 0c                	push   $0xc
     3f8:	e8 d3 14 00 00       	call   18d0 <malloc>
  node->data = data;
     3fd:	8b 55 08             	mov    0x8(%ebp),%edx
  node->prev = nullptr;
     400:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->next = nullptr;
     406:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  node->data = data;
     40d:	89 50 04             	mov    %edx,0x4(%eax)
}
     410:	c9                   	leave  
     411:	c3                   	ret    
     412:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000420 <nodeAt>:
Node* nodeAt(struct LinkedList* list, int pos) {
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	53                   	push   %ebx
     424:	8b 45 08             	mov    0x8(%ebp),%eax
     427:	8b 55 0c             	mov    0xc(%ebp),%edx
  if (pos > list->len)
     42a:	8b 48 08             	mov    0x8(%eax),%ecx
     42d:	39 d1                	cmp    %edx,%ecx
     42f:	7c 1f                	jl     450 <nodeAt+0x30>
  if ((pos < 0) && ((0 - pos) > list->len))
     431:	85 d2                	test   %edx,%edx
     433:	78 2b                	js     460 <nodeAt+0x40>
    curNode = list->head->next;
     435:	8b 00                	mov    (%eax),%eax
     437:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     43a:	74 0e                	je     44a <nodeAt+0x2a>
    int cur = 0;
     43c:	31 c9                	xor    %ecx,%ecx
     43e:	66 90                	xchg   %ax,%ax
      cur++;
     440:	83 c1 01             	add    $0x1,%ecx
      curNode = curNode->next;
     443:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     446:	39 ca                	cmp    %ecx,%edx
     448:	75 f6                	jne    440 <nodeAt+0x20>
}
     44a:	5b                   	pop    %ebx
     44b:	5d                   	pop    %ebp
     44c:	c3                   	ret    
     44d:	8d 76 00             	lea    0x0(%esi),%esi
    return list->tail->prev;
     450:	8b 40 04             	mov    0x4(%eax),%eax
}
     453:	5b                   	pop    %ebx
     454:	5d                   	pop    %ebp
    return list->tail->prev;
     455:	8b 00                	mov    (%eax),%eax
}
     457:	c3                   	ret    
     458:	90                   	nop
     459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if ((pos < 0) && ((0 - pos) > list->len))
     460:	89 d3                	mov    %edx,%ebx
     462:	f7 db                	neg    %ebx
     464:	39 d9                	cmp    %ebx,%ecx
     466:	7c 18                	jl     480 <nodeAt+0x60>
    while (++pos != 0)
     468:	83 c2 01             	add    $0x1,%edx
    curNode = list->tail;
     46b:	8b 40 04             	mov    0x4(%eax),%eax
    while (++pos != 0)
     46e:	74 da                	je     44a <nodeAt+0x2a>
     470:	83 c2 01             	add    $0x1,%edx
      curNode = curNode->prev;
     473:	8b 00                	mov    (%eax),%eax
    while (++pos != 0)
     475:	75 f9                	jne    470 <nodeAt+0x50>
}
     477:	5b                   	pop    %ebx
     478:	5d                   	pop    %ebp
     479:	c3                   	ret    
     47a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return list->head->next;
     480:	8b 00                	mov    (%eax),%eax
     482:	8b 40 08             	mov    0x8(%eax),%eax
     485:	eb c3                	jmp    44a <nodeAt+0x2a>
     487:	89 f6                	mov    %esi,%esi
     489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000490 <destroyNode>:
void destroyNode(struct LinkedList* list, struct Node* self) {
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	56                   	push   %esi
     494:	53                   	push   %ebx
     495:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     498:	8b 75 08             	mov    0x8(%ebp),%esi
    free(self->data);
     49b:	83 ec 0c             	sub    $0xc,%esp
    self->prev->next = self->next;
     49e:	8b 03                	mov    (%ebx),%eax
     4a0:	8b 53 08             	mov    0x8(%ebx),%edx
     4a3:	89 50 08             	mov    %edx,0x8(%eax)
    self->next->prev = self->prev;
     4a6:	8b 43 08             	mov    0x8(%ebx),%eax
     4a9:	8b 13                	mov    (%ebx),%edx
     4ab:	89 10                	mov    %edx,(%eax)
    free(self->data);
     4ad:	ff 73 04             	pushl  0x4(%ebx)
     4b0:	e8 8b 13 00 00       	call   1840 <free>
    free(self);
     4b5:	89 1c 24             	mov    %ebx,(%esp)
     4b8:	e8 83 13 00 00       	call   1840 <free>
    list->len--;
     4bd:	83 6e 08 01          	subl   $0x1,0x8(%esi)
}
     4c1:	83 c4 10             	add    $0x10,%esp
     4c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     4c7:	5b                   	pop    %ebx
     4c8:	5e                   	pop    %esi
     4c9:	5d                   	pop    %ebp
     4ca:	c3                   	ret    
     4cb:	90                   	nop
     4cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004d0 <MakeLinkedList>:
LinkedList* MakeLinkedList() {
     4d0:	55                   	push   %ebp
     4d1:	89 e5                	mov    %esp,%ebp
     4d3:	56                   	push   %esi
     4d4:	53                   	push   %ebx
  struct LinkedList* list = malloc(sizeof(LinkedList));
     4d5:	83 ec 0c             	sub    $0xc,%esp
     4d8:	6a 0c                	push   $0xc
     4da:	e8 f1 13 00 00       	call   18d0 <malloc>
  struct Node* node = malloc(sizeof(Node));
     4df:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  struct LinkedList* list = malloc(sizeof(LinkedList));
     4e6:	89 c6                	mov    %eax,%esi
  struct Node* node = malloc(sizeof(Node));
     4e8:	e8 e3 13 00 00       	call   18d0 <malloc>
     4ed:	89 c3                	mov    %eax,%ebx
  node->prev = nullptr;
     4ef:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->data = data;
     4f5:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  node->next = nullptr;
     4fc:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  struct Node* node = malloc(sizeof(Node));
     503:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     50a:	e8 c1 13 00 00       	call   18d0 <malloc>
  node->data = data;
     50f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  head->next = tail;
     516:	89 43 08             	mov    %eax,0x8(%ebx)
  head->prev = nullptr;
     519:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  tail->prev = head;
     51f:	89 18                	mov    %ebx,(%eax)
  tail->next = nullptr;
     521:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  list->tail = tail;
     528:	89 46 04             	mov    %eax,0x4(%esi)
}
     52b:	89 f0                	mov    %esi,%eax
  list->len = 0;
     52d:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
  list->head = head;
     534:	89 1e                	mov    %ebx,(%esi)
}
     536:	8d 65 f8             	lea    -0x8(%ebp),%esp
     539:	5b                   	pop    %ebx
     53a:	5e                   	pop    %esi
     53b:	5d                   	pop    %ebp
     53c:	c3                   	ret    
     53d:	8d 76 00             	lea    0x0(%esi),%esi

00000540 <insert>:
void insert(struct LinkedList* list, char* data, int pos) {
     540:	55                   	push   %ebp
     541:	89 e5                	mov    %esp,%ebp
     543:	57                   	push   %edi
     544:	56                   	push   %esi
     545:	53                   	push   %ebx
     546:	83 ec 0c             	sub    $0xc,%esp
  struct Node* atPos = nodeAt(list, pos);
     549:	ff 75 10             	pushl  0x10(%ebp)
     54c:	ff 75 08             	pushl  0x8(%ebp)
void insert(struct LinkedList* list, char* data, int pos) {
     54f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct Node* atPos = nodeAt(list, pos);
     552:	e8 c9 fe ff ff       	call   420 <nodeAt>
     557:	83 ec 04             	sub    $0x4,%esp
     55a:	89 c6                	mov    %eax,%esi
  char* newData = (char*)malloc(sizeof(char) * 1000);
     55c:	68 e8 03 00 00       	push   $0x3e8
     561:	e8 6a 13 00 00       	call   18d0 <malloc>
     566:	8d 8b e7 03 00 00    	lea    0x3e7(%ebx),%ecx
     56c:	89 c7                	mov    %eax,%edi
     56e:	83 c4 10             	add    $0x10,%esp
     571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(--n > 0 && (*s++ = *t++) != 0)
     578:	83 c3 01             	add    $0x1,%ebx
     57b:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     57f:	83 c0 01             	add    $0x1,%eax
     582:	84 d2                	test   %dl,%dl
     584:	88 50 ff             	mov    %dl,-0x1(%eax)
     587:	74 04                	je     58d <insert+0x4d>
     589:	39 d9                	cmp    %ebx,%ecx
     58b:	75 eb                	jne    578 <insert+0x38>
  struct Node* new = malloc(sizeof(Node));
     58d:	83 ec 0c             	sub    $0xc,%esp
  *s = 0;
     590:	c6 00 00             	movb   $0x0,(%eax)
  struct Node* new = malloc(sizeof(Node));
     593:	6a 0c                	push   $0xc
     595:	e8 36 13 00 00       	call   18d0 <malloc>
  new->data = newData;
     59a:	89 78 04             	mov    %edi,0x4(%eax)
  new->prev = atPos->prev;
     59d:	8b 16                	mov    (%esi),%edx
  new->next = atPos;
     59f:	89 70 08             	mov    %esi,0x8(%eax)
  new->prev = atPos->prev;
     5a2:	89 10                	mov    %edx,(%eax)
  new->prev->next = new;
     5a4:	89 42 08             	mov    %eax,0x8(%edx)
  atPos->prev = new;
     5a7:	89 06                	mov    %eax,(%esi)
  list->len++;
     5a9:	8b 45 08             	mov    0x8(%ebp),%eax
     5ac:	83 40 08 01          	addl   $0x1,0x8(%eax)
}
     5b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5b3:	5b                   	pop    %ebx
     5b4:	5e                   	pop    %esi
     5b5:	5f                   	pop    %edi
     5b6:	5d                   	pop    %ebp
     5b7:	c3                   	ret    
     5b8:	90                   	nop
     5b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005c0 <prepend>:
void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
     5c0:	55                   	push   %ebp
     5c1:	89 e5                	mov    %esp,%ebp
     5c3:	83 ec 0c             	sub    $0xc,%esp
     5c6:	6a 00                	push   $0x0
     5c8:	ff 75 0c             	pushl  0xc(%ebp)
     5cb:	ff 75 08             	pushl  0x8(%ebp)
     5ce:	e8 6d ff ff ff       	call   540 <insert>
     5d3:	83 c4 10             	add    $0x10,%esp
     5d6:	c9                   	leave  
     5d7:	c3                   	ret    
     5d8:	90                   	nop
     5d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005e0 <append>:
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     5e0:	55                   	push   %ebp
     5e1:	89 e5                	mov    %esp,%ebp
     5e3:	83 ec 0c             	sub    $0xc,%esp
     5e6:	8b 45 08             	mov    0x8(%ebp),%eax
     5e9:	ff 70 08             	pushl  0x8(%eax)
     5ec:	ff 75 0c             	pushl  0xc(%ebp)
     5ef:	50                   	push   %eax
     5f0:	e8 4b ff ff ff       	call   540 <insert>
     5f5:	83 c4 10             	add    $0x10,%esp
     5f8:	c9                   	leave  
     5f9:	c3                   	ret    
     5fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000600 <destroyLinkedList>:

void destroyLinkedList(struct LinkedList* list) {
     600:	55                   	push   %ebp
     601:	89 e5                	mov    %esp,%ebp
     603:	56                   	push   %esi
     604:	53                   	push   %ebx
     605:	8b 75 08             	mov    0x8(%ebp),%esi
  struct Node* curNode = list->head;
     608:	8b 1e                	mov    (%esi),%ebx
  while (curNode != list->tail) {
     60a:	8b 46 04             	mov    0x4(%esi),%eax
     60d:	39 c3                	cmp    %eax,%ebx
     60f:	74 29                	je     63a <destroyLinkedList+0x3a>
     611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
     618:	8b 5b 08             	mov    0x8(%ebx),%ebx
    free(curNode->prev->data);
     61b:	83 ec 0c             	sub    $0xc,%esp
     61e:	8b 03                	mov    (%ebx),%eax
     620:	ff 70 04             	pushl  0x4(%eax)
     623:	e8 18 12 00 00       	call   1840 <free>
    free(curNode->prev);
     628:	58                   	pop    %eax
     629:	ff 33                	pushl  (%ebx)
     62b:	e8 10 12 00 00       	call   1840 <free>
  while (curNode != list->tail) {
     630:	8b 46 04             	mov    0x4(%esi),%eax
     633:	83 c4 10             	add    $0x10,%esp
     636:	39 d8                	cmp    %ebx,%eax
     638:	75 de                	jne    618 <destroyLinkedList+0x18>
  }
  free(curNode);
     63a:	83 ec 0c             	sub    $0xc,%esp
     63d:	50                   	push   %eax
     63e:	e8 fd 11 00 00       	call   1840 <free>
  free(list);
     643:	89 75 08             	mov    %esi,0x8(%ebp)
     646:	83 c4 10             	add    $0x10,%esp
     649:	8d 65 f8             	lea    -0x8(%ebp),%esp
     64c:	5b                   	pop    %ebx
     64d:	5e                   	pop    %esi
     64e:	5d                   	pop    %ebp
  free(list);
     64f:	e9 ec 11 00 00       	jmp    1840 <free>
     654:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     65a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000660 <getLine>:
int getLine(int fileptr, char line[]) {
     660:	55                   	push   %ebp
     661:	89 e5                	mov    %esp,%ebp
     663:	57                   	push   %edi
     664:	56                   	push   %esi
     665:	53                   	push   %ebx
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     666:	31 ff                	xor    %edi,%edi
     668:	8d 75 e7             	lea    -0x19(%ebp),%esi
int getLine(int fileptr, char line[]) {
     66b:	83 ec 28             	sub    $0x28,%esp
     66e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int len = strlen(line);
     671:	53                   	push   %ebx
     672:	e8 49 0c 00 00       	call   12c0 <strlen>
  memset(line, 0, len);
     677:	83 c4 0c             	add    $0xc,%esp
     67a:	50                   	push   %eax
     67b:	6a 00                	push   $0x0
     67d:	53                   	push   %ebx
     67e:	e8 6d 0c 00 00       	call   12f0 <memset>
     683:	83 c4 10             	add    $0x10,%esp
     686:	eb 1e                	jmp    6a6 <getLine+0x46>
     688:	90                   	nop
     689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (*c == '\n') break;
     690:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     694:	3c 0a                	cmp    $0xa,%al
     696:	74 38                	je     6d0 <getLine+0x70>
    line[i] = *c;
     698:	88 04 3b             	mov    %al,(%ebx,%edi,1)
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     69b:	83 c7 01             	add    $0x1,%edi
     69e:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
     6a4:	74 42                	je     6e8 <getLine+0x88>
    if (read(fileptr, c, 1) == 0) return strlen(line);
     6a6:	83 ec 04             	sub    $0x4,%esp
     6a9:	6a 01                	push   $0x1
     6ab:	56                   	push   %esi
     6ac:	ff 75 08             	pushl  0x8(%ebp)
     6af:	e8 f6 0d 00 00       	call   14aa <read>
     6b4:	83 c4 10             	add    $0x10,%esp
     6b7:	85 c0                	test   %eax,%eax
     6b9:	75 d5                	jne    690 <getLine+0x30>
     6bb:	83 ec 0c             	sub    $0xc,%esp
     6be:	53                   	push   %ebx
     6bf:	e8 fc 0b 00 00       	call   12c0 <strlen>
     6c4:	83 c4 10             	add    $0x10,%esp
}
     6c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6ca:	5b                   	pop    %ebx
     6cb:	5e                   	pop    %esi
     6cc:	5f                   	pop    %edi
     6cd:	5d                   	pop    %ebp
     6ce:	c3                   	ret    
     6cf:	90                   	nop
     6d0:	8d 57 01             	lea    0x1(%edi),%edx
  line[i + 1] = '\0';
     6d3:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
     6d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
     6da:	b8 01 00 00 00       	mov    $0x1,%eax
}
     6df:	5b                   	pop    %ebx
     6e0:	5e                   	pop    %esi
     6e1:	5f                   	pop    %edi
     6e2:	5d                   	pop    %ebp
     6e3:	c3                   	ret    
     6e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     6e8:	ba e8 03 00 00       	mov    $0x3e8,%edx
     6ed:	eb e4                	jmp    6d3 <getLine+0x73>
     6ef:	90                   	nop

000006f0 <gatherLines>:
void gatherLines(File* file) {
     6f0:	55                   	push   %ebp
     6f1:	89 e5                	mov    %esp,%ebp
     6f3:	56                   	push   %esi
     6f4:	53                   	push   %ebx
     6f5:	8d b5 10 fc ff ff    	lea    -0x3f0(%ebp),%esi
     6fb:	81 ec f0 03 00 00    	sub    $0x3f0,%esp
     701:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while (getLine(file->fd, line)) {
     704:	eb 21                	jmp    727 <gatherLines+0x37>
     706:	8d 76 00             	lea    0x0(%esi),%esi
     709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    append(file->lines, line);
     710:	8b 43 08             	mov    0x8(%ebx),%eax
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     713:	83 ec 04             	sub    $0x4,%esp
     716:	ff 70 08             	pushl  0x8(%eax)
     719:	56                   	push   %esi
     71a:	50                   	push   %eax
     71b:	e8 20 fe ff ff       	call   540 <insert>
    file->len++;
     720:	83 43 0c 01          	addl   $0x1,0xc(%ebx)
     724:	83 c4 10             	add    $0x10,%esp
  while (getLine(file->fd, line)) {
     727:	83 ec 08             	sub    $0x8,%esp
     72a:	56                   	push   %esi
     72b:	ff 73 04             	pushl  0x4(%ebx)
     72e:	e8 2d ff ff ff       	call   660 <getLine>
     733:	83 c4 10             	add    $0x10,%esp
     736:	85 c0                	test   %eax,%eax
     738:	75 d6                	jne    710 <gatherLines+0x20>
  fprintf(2, "%d lines read from %s\n", file->len, file->filename);
     73a:	ff 33                	pushl  (%ebx)
     73c:	ff 73 0c             	pushl  0xc(%ebx)
     73f:	68 c8 19 00 00       	push   $0x19c8
     744:	6a 02                	push   $0x2
     746:	e8 b5 10 00 00       	call   1800 <fprintf>
}
     74b:	83 c4 10             	add    $0x10,%esp
     74e:	8d 65 f8             	lea    -0x8(%ebp),%esp
     751:	5b                   	pop    %ebx
     752:	5e                   	pop    %esi
     753:	5d                   	pop    %ebp
     754:	c3                   	ret    
     755:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000760 <confirmation>:
int confirmation() {
     760:	55                   	push   %ebp
     761:	89 e5                	mov    %esp,%ebp
     763:	53                   	push   %ebx
  memset(buf, 0, nbuf);
     764:	8d 9d 10 fc ff ff    	lea    -0x3f0(%ebp),%ebx
int confirmation() {
     76a:	81 ec f8 03 00 00    	sub    $0x3f8,%esp
  memset(buf, 0, nbuf);
     770:	68 e8 03 00 00       	push   $0x3e8
     775:	6a 00                	push   $0x0
     777:	53                   	push   %ebx
     778:	e8 73 0b 00 00       	call   12f0 <memset>
  gets(buf, nbuf);
     77d:	58                   	pop    %eax
     77e:	5a                   	pop    %edx
     77f:	68 e8 03 00 00       	push   $0x3e8
     784:	53                   	push   %ebx
     785:	e8 c6 0b 00 00       	call   1350 <gets>
  switch (buf[0]) {
     78a:	0f b6 85 10 fc ff ff 	movzbl -0x3f0(%ebp),%eax
     791:	83 c4 10             	add    $0x10,%esp
     794:	3c 59                	cmp    $0x59,%al
     796:	74 18                	je     7b0 <confirmation+0x50>
     798:	3c 79                	cmp    $0x79,%al
     79a:	74 14                	je     7b0 <confirmation+0x50>
    return 1;
     79c:	b8 01 00 00 00       	mov    $0x1,%eax
}
     7a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7a4:	c9                   	leave  
     7a5:	c3                   	ret    
     7a6:	8d 76 00             	lea    0x0(%esi),%esi
     7a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return 0;
     7b0:	31 c0                	xor    %eax,%eax
}
     7b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7b5:	c9                   	leave  
     7b6:	c3                   	ret    
     7b7:	89 f6                	mov    %esi,%esi
     7b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007c0 <find>:
int find(char* str, char c) {
     7c0:	55                   	push   %ebp
     7c1:	89 e5                	mov    %esp,%ebp
     7c3:	57                   	push   %edi
     7c4:	56                   	push   %esi
     7c5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     7c6:	31 db                	xor    %ebx,%ebx
int find(char* str, char c) {
     7c8:	83 ec 0c             	sub    $0xc,%esp
     7cb:	8b 75 08             	mov    0x8(%ebp),%esi
     7ce:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
  for (int i = 0; i < strlen(str); i++)
     7d2:	eb 0e                	jmp    7e2 <find+0x22>
     7d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     7d8:	89 f8                	mov    %edi,%eax
     7da:	38 04 1e             	cmp    %al,(%esi,%ebx,1)
     7dd:	74 18                	je     7f7 <find+0x37>
  for (int i = 0; i < strlen(str); i++)
     7df:	83 c3 01             	add    $0x1,%ebx
     7e2:	83 ec 0c             	sub    $0xc,%esp
     7e5:	56                   	push   %esi
     7e6:	e8 d5 0a 00 00       	call   12c0 <strlen>
     7eb:	83 c4 10             	add    $0x10,%esp
     7ee:	39 d8                	cmp    %ebx,%eax
     7f0:	77 e6                	ja     7d8 <find+0x18>
  return -1;
     7f2:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
     7f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7fa:	89 d8                	mov    %ebx,%eax
     7fc:	5b                   	pop    %ebx
     7fd:	5e                   	pop    %esi
     7fe:	5f                   	pop    %edi
     7ff:	5d                   	pop    %ebp
     800:	c3                   	ret    
     801:	eb 0d                	jmp    810 <substr>
     803:	90                   	nop
     804:	90                   	nop
     805:	90                   	nop
     806:	90                   	nop
     807:	90                   	nop
     808:	90                   	nop
     809:	90                   	nop
     80a:	90                   	nop
     80b:	90                   	nop
     80c:	90                   	nop
     80d:	90                   	nop
     80e:	90                   	nop
     80f:	90                   	nop

00000810 <substr>:
void substr(char* dest, char* str, int start, int end) {
     810:	55                   	push   %ebp
     811:	89 e5                	mov    %esp,%ebp
     813:	57                   	push   %edi
     814:	56                   	push   %esi
     815:	53                   	push   %ebx
     816:	83 ec 18             	sub    $0x18,%esp
     819:	8b 7d 14             	mov    0x14(%ebp),%edi
  int len = strlen(str);
     81c:	ff 75 0c             	pushl  0xc(%ebp)
void substr(char* dest, char* str, int start, int end) {
     81f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     822:	8b 75 08             	mov    0x8(%ebp),%esi
  int len = strlen(str);
     825:	e8 96 0a 00 00       	call   12c0 <strlen>
     82a:	83 c4 10             	add    $0x10,%esp
     82d:	39 f8                	cmp    %edi,%eax
     82f:	0f 4e f8             	cmovle %eax,%edi
  while (i < end)
     832:	39 df                	cmp    %ebx,%edi
     834:	7e 1c                	jle    852 <substr+0x42>
     836:	8b 45 0c             	mov    0xc(%ebp),%eax
     839:	29 df                	sub    %ebx,%edi
  int s = 0, i = start;
     83b:	31 d2                	xor    %edx,%edx
     83d:	01 c3                	add    %eax,%ebx
     83f:	90                   	nop
    dest[s++] = str[i++];
     840:	83 c2 01             	add    $0x1,%edx
     843:	0f b6 44 13 ff       	movzbl -0x1(%ebx,%edx,1),%eax
  while (i < end)
     848:	39 fa                	cmp    %edi,%edx
    dest[s++] = str[i++];
     84a:	88 44 16 ff          	mov    %al,-0x1(%esi,%edx,1)
  while (i < end)
     84e:	75 f0                	jne    840 <substr+0x30>
     850:	01 d6                	add    %edx,%esi
  dest[s] = '\0';
     852:	c6 06 00             	movb   $0x0,(%esi)
}
     855:	8d 65 f4             	lea    -0xc(%ebp),%esp
     858:	5b                   	pop    %ebx
     859:	5e                   	pop    %esi
     85a:	5f                   	pop    %edi
     85b:	5d                   	pop    %ebp
     85c:	c3                   	ret    
     85d:	8d 76 00             	lea    0x0(%esi),%esi

00000860 <getArg>:
void getArg(char* dest, char* args, char delimiter) {
     860:	55                   	push   %ebp
     861:	89 e5                	mov    %esp,%ebp
     863:	57                   	push   %edi
     864:	56                   	push   %esi
     865:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     866:	31 db                	xor    %ebx,%ebx
void getArg(char* dest, char* args, char delimiter) {
     868:	83 ec 1c             	sub    $0x1c,%esp
     86b:	8b 75 0c             	mov    0xc(%ebp),%esi
     86e:	0f b6 7d 10          	movzbl 0x10(%ebp),%edi
     872:	eb 10                	jmp    884 <getArg+0x24>
     874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     878:	89 f8                	mov    %edi,%eax
     87a:	3a 04 1e             	cmp    (%esi,%ebx,1),%al
     87d:	8d 53 01             	lea    0x1(%ebx),%edx
     880:	74 19                	je     89b <getArg+0x3b>
     882:	89 d3                	mov    %edx,%ebx
  for (int i = 0; i < strlen(str); i++)
     884:	83 ec 0c             	sub    $0xc,%esp
     887:	56                   	push   %esi
     888:	e8 33 0a 00 00       	call   12c0 <strlen>
     88d:	83 c4 10             	add    $0x10,%esp
     890:	39 c3                	cmp    %eax,%ebx
     892:	72 e4                	jb     878 <getArg+0x18>
     894:	31 d2                	xor    %edx,%edx
  return -1;
     896:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  substr(dest, args, 0, end);
     89b:	53                   	push   %ebx
     89c:	6a 00                	push   $0x0
     89e:	56                   	push   %esi
     89f:	ff 75 08             	pushl  0x8(%ebp)
     8a2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     8a5:	e8 66 ff ff ff       	call   810 <substr>
  substr(args, args, end + 1, (int) strlen(args));
     8aa:	89 34 24             	mov    %esi,(%esp)
     8ad:	e8 0e 0a 00 00       	call   12c0 <strlen>
     8b2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     8b5:	50                   	push   %eax
     8b6:	52                   	push   %edx
     8b7:	56                   	push   %esi
     8b8:	56                   	push   %esi
     8b9:	e8 52 ff ff ff       	call   810 <substr>
}
     8be:	83 c4 20             	add    $0x20,%esp
     8c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8c4:	5b                   	pop    %ebx
     8c5:	5e                   	pop    %esi
     8c6:	5f                   	pop    %edi
     8c7:	5d                   	pop    %ebp
     8c8:	c3                   	ret    
     8c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008d0 <collectRange>:
int collectRange(char* args, int* startptr, int* endptr) {
     8d0:	55                   	push   %ebp
     8d1:	89 e5                	mov    %esp,%ebp
     8d3:	57                   	push   %edi
     8d4:	56                   	push   %esi
     8d5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     8d6:	31 f6                	xor    %esi,%esi
int collectRange(char* args, int* startptr, int* endptr) {
     8d8:	83 ec 2c             	sub    $0x2c,%esp
     8db:	8b 5d 08             	mov    0x8(%ebp),%ebx
     8de:	eb 09                	jmp    8e9 <collectRange+0x19>
    if (str[i] == c) return i;
     8e0:	80 3c 33 3a          	cmpb   $0x3a,(%ebx,%esi,1)
     8e4:	74 42                	je     928 <collectRange+0x58>
  for (int i = 0; i < strlen(str); i++)
     8e6:	83 c6 01             	add    $0x1,%esi
     8e9:	83 ec 0c             	sub    $0xc,%esp
     8ec:	53                   	push   %ebx
     8ed:	e8 ce 09 00 00       	call   12c0 <strlen>
     8f2:	83 c4 10             	add    $0x10,%esp
     8f5:	39 c6                	cmp    %eax,%esi
     8f7:	72 e7                	jb     8e0 <collectRange+0x10>
    if (args[0] == '-') {
     8f9:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     8fc:	0f 84 d6 00 00 00    	je     9d8 <collectRange+0x108>
      *startptr = atoi(args);
     902:	83 ec 0c             	sub    $0xc,%esp
     905:	53                   	push   %ebx
     906:	e8 15 0b 00 00       	call   1420 <atoi>
     90b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     90e:	83 c4 10             	add    $0x10,%esp
     911:	89 01                	mov    %eax,(%ecx)
    *endptr = *startptr;
     913:	8b 4d 10             	mov    0x10(%ebp),%ecx
     916:	89 01                	mov    %eax,(%ecx)
    return 0;
     918:	31 c0                	xor    %eax,%eax
}
     91a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     91d:	5b                   	pop    %ebx
     91e:	5e                   	pop    %esi
     91f:	5f                   	pop    %edi
     920:	5d                   	pop    %ebp
     921:	c3                   	ret    
     922:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  getArg(startstr, args, ':');
     928:	8d 75 de             	lea    -0x22(%ebp),%esi
     92b:	83 ec 04             	sub    $0x4,%esp
     92e:	6a 3a                	push   $0x3a
     930:	53                   	push   %ebx
     931:	56                   	push   %esi
     932:	e8 29 ff ff ff       	call   860 <getArg>
  if (startstr[0] == '-') {
     937:	83 c4 10             	add    $0x10,%esp
     93a:	80 7d de 2d          	cmpb   $0x2d,-0x22(%ebp)
     93e:	0f 84 3c 01 00 00    	je     a80 <collectRange+0x1b0>
  int negStartFlag = 0, negEndFlag = 0;
     944:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     94b:	31 ff                	xor    %edi,%edi
  if (endstr[0] == '-') {
     94d:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     950:	0f 84 0a 01 00 00    	je     a60 <collectRange+0x190>
  if (strcmp(startstr, "\0") == 0) *startptr = 1;
     956:	83 ec 08             	sub    $0x8,%esp
     959:	68 e8 1a 00 00       	push   $0x1ae8
     95e:	56                   	push   %esi
     95f:	e8 0c 09 00 00       	call   1270 <strcmp>
     964:	83 c4 10             	add    $0x10,%esp
     967:	85 c0                	test   %eax,%eax
     969:	0f 85 d1 00 00 00    	jne    a40 <collectRange+0x170>
     96f:	8b 45 0c             	mov    0xc(%ebp),%eax
     972:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  if (strcmp(endstr, "\0") == 0) *endptr = -1;
     978:	83 ec 08             	sub    $0x8,%esp
     97b:	68 e8 1a 00 00       	push   $0x1ae8
     980:	53                   	push   %ebx
     981:	e8 ea 08 00 00       	call   1270 <strcmp>
     986:	83 c4 10             	add    $0x10,%esp
     989:	85 c0                	test   %eax,%eax
     98b:	0f 85 97 00 00 00    	jne    a28 <collectRange+0x158>
     991:	8b 45 10             	mov    0x10(%ebp),%eax
     994:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  if (negStartFlag) *startptr = 0 - *startptr;
     99a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     99d:	85 c0                	test   %eax,%eax
     99f:	74 05                	je     9a6 <collectRange+0xd6>
     9a1:	8b 45 0c             	mov    0xc(%ebp),%eax
     9a4:	f7 18                	negl   (%eax)
  if (negEndFlag) *endptr = 0 - *endptr;
     9a6:	85 ff                	test   %edi,%edi
     9a8:	74 05                	je     9af <collectRange+0xdf>
     9aa:	8b 45 10             	mov    0x10(%ebp),%eax
     9ad:	f7 18                	negl   (%eax)
  if (((*startptr > 0 && *endptr > 0) || 
     9af:	8b 45 0c             	mov    0xc(%ebp),%eax
     9b2:	8b 00                	mov    (%eax),%eax
     9b4:	83 f8 00             	cmp    $0x0,%eax
     9b7:	7e 4f                	jle    a08 <collectRange+0x138>
     9b9:	8b 55 10             	mov    0x10(%ebp),%edx
     9bc:	8b 12                	mov    (%edx),%edx
     9be:	85 d2                	test   %edx,%edx
     9c0:	7e 55                	jle    a17 <collectRange+0x147>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     9c2:	39 d0                	cmp    %edx,%eax
     9c4:	0f 9f c0             	setg   %al
}
     9c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     9ca:	0f b6 c0             	movzbl %al,%eax
}
     9cd:	5b                   	pop    %ebx
     9ce:	5e                   	pop    %esi
     9cf:	5f                   	pop    %edi
     9d0:	5d                   	pop    %ebp
     9d1:	c3                   	ret    
     9d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      substr(args, args, 1, strlen(args));
     9d8:	83 ec 0c             	sub    $0xc,%esp
     9db:	53                   	push   %ebx
     9dc:	e8 df 08 00 00       	call   12c0 <strlen>
     9e1:	50                   	push   %eax
     9e2:	6a 01                	push   $0x1
     9e4:	53                   	push   %ebx
     9e5:	53                   	push   %ebx
     9e6:	e8 25 fe ff ff       	call   810 <substr>
      *startptr = 0 - atoi(args);
     9eb:	83 c4 14             	add    $0x14,%esp
     9ee:	53                   	push   %ebx
     9ef:	e8 2c 0a 00 00       	call   1420 <atoi>
     9f4:	8b 7d 0c             	mov    0xc(%ebp),%edi
     9f7:	f7 d8                	neg    %eax
     9f9:	83 c4 10             	add    $0x10,%esp
     9fc:	89 07                	mov    %eax,(%edi)
     9fe:	e9 10 ff ff ff       	jmp    913 <collectRange+0x43>
     a03:	90                   	nop
     a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (((*startptr > 0 && *endptr > 0) || 
     a08:	0f 84 0c ff ff ff    	je     91a <collectRange+0x4a>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     a0e:	8b 7d 10             	mov    0x10(%ebp),%edi
     a11:	8b 17                	mov    (%edi),%edx
     a13:	85 d2                	test   %edx,%edx
     a15:	78 ab                	js     9c2 <collectRange+0xf2>
}
     a17:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
     a1a:	31 c0                	xor    %eax,%eax
}
     a1c:	5b                   	pop    %ebx
     a1d:	5e                   	pop    %esi
     a1e:	5f                   	pop    %edi
     a1f:	5d                   	pop    %ebp
     a20:	c3                   	ret    
     a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else *endptr = atoi(endstr);
     a28:	83 ec 0c             	sub    $0xc,%esp
     a2b:	53                   	push   %ebx
     a2c:	e8 ef 09 00 00       	call   1420 <atoi>
     a31:	8b 55 10             	mov    0x10(%ebp),%edx
     a34:	83 c4 10             	add    $0x10,%esp
     a37:	89 02                	mov    %eax,(%edx)
     a39:	e9 5c ff ff ff       	jmp    99a <collectRange+0xca>
     a3e:	66 90                	xchg   %ax,%ax
  else *startptr = atoi(startstr);
     a40:	83 ec 0c             	sub    $0xc,%esp
     a43:	56                   	push   %esi
     a44:	e8 d7 09 00 00       	call   1420 <atoi>
     a49:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     a4c:	83 c4 10             	add    $0x10,%esp
     a4f:	89 01                	mov    %eax,(%ecx)
     a51:	e9 22 ff ff ff       	jmp    978 <collectRange+0xa8>
     a56:	8d 76 00             	lea    0x0(%esi),%esi
     a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    substr(endstr, endstr, 1, strlen(endstr));
     a60:	83 ec 0c             	sub    $0xc,%esp
    negEndFlag = 1;
     a63:	bf 01 00 00 00       	mov    $0x1,%edi
    substr(endstr, endstr, 1, strlen(endstr));
     a68:	53                   	push   %ebx
     a69:	e8 52 08 00 00       	call   12c0 <strlen>
     a6e:	50                   	push   %eax
     a6f:	6a 01                	push   $0x1
     a71:	53                   	push   %ebx
     a72:	53                   	push   %ebx
     a73:	e8 98 fd ff ff       	call   810 <substr>
     a78:	83 c4 20             	add    $0x20,%esp
     a7b:	e9 d6 fe ff ff       	jmp    956 <collectRange+0x86>
    substr(startstr, startstr, 1, strlen(startstr));
     a80:	83 ec 0c             	sub    $0xc,%esp
     a83:	56                   	push   %esi
     a84:	e8 37 08 00 00       	call   12c0 <strlen>
     a89:	50                   	push   %eax
     a8a:	6a 01                	push   $0x1
     a8c:	56                   	push   %esi
     a8d:	56                   	push   %esi
     a8e:	e8 7d fd ff ff       	call   810 <substr>
     a93:	83 c4 20             	add    $0x20,%esp
    negStartFlag = 1;
     a96:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
     a9d:	e9 a9 fe ff ff       	jmp    94b <collectRange+0x7b>
     aa2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ab0 <normalizeRange>:
int normalizeRange(File file, int* sp, int* ep) {
     ab0:	55                   	push   %ebp
     ab1:	89 e5                	mov    %esp,%ebp
     ab3:	53                   	push   %ebx
     ab4:	8b 4d 1c             	mov    0x1c(%ebp),%ecx
  int l = file.len;
     ab7:	8b 45 14             	mov    0x14(%ebp),%eax
int normalizeRange(File file, int* sp, int* ep) {
     aba:	8b 5d 18             	mov    0x18(%ebp),%ebx
  if (*ep > l) *ep = l;
     abd:	8b 11                	mov    (%ecx),%edx
     abf:	39 c2                	cmp    %eax,%edx
     ac1:	7e 45                	jle    b08 <normalizeRange+0x58>
     ac3:	89 01                	mov    %eax,(%ecx)
     ac5:	89 c2                	mov    %eax,%edx
  if (*ep < 1) *ep = 1;
     ac7:	85 d2                	test   %edx,%edx
     ac9:	7f 06                	jg     ad1 <normalizeRange+0x21>
     acb:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)
  if (*sp > l) *sp = l;
     ad1:	8b 13                	mov    (%ebx),%edx
     ad3:	39 c2                	cmp    %eax,%edx
     ad5:	7e 21                	jle    af8 <normalizeRange+0x48>
     ad7:	89 03                	mov    %eax,(%ebx)
     ad9:	89 c2                	mov    %eax,%edx
  if (*sp < 1) *sp = 1;
     adb:	85 d2                	test   %edx,%edx
     add:	7f 0b                	jg     aea <normalizeRange+0x3a>
     adf:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
     ae5:	ba 01 00 00 00       	mov    $0x1,%edx
  if ((*ep - *sp) < 0)
     aea:	8b 01                	mov    (%ecx),%eax
}
     aec:	5b                   	pop    %ebx
     aed:	5d                   	pop    %ebp
  if ((*ep - *sp) < 0)
     aee:	29 d0                	sub    %edx,%eax
     af0:	c1 e8 1f             	shr    $0x1f,%eax
}
     af3:	c3                   	ret    
     af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*sp < 1) *sp += l + 1;
     af8:	85 d2                	test   %edx,%edx
     afa:	7f ee                	jg     aea <normalizeRange+0x3a>
     afc:	8d 54 10 01          	lea    0x1(%eax,%edx,1),%edx
     b00:	89 13                	mov    %edx,(%ebx)
     b02:	eb d7                	jmp    adb <normalizeRange+0x2b>
     b04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*ep < 1) *ep += l + 1;
     b08:	85 d2                	test   %edx,%edx
     b0a:	7f c5                	jg     ad1 <normalizeRange+0x21>
     b0c:	8d 54 02 01          	lea    0x1(%edx,%eax,1),%edx
     b10:	89 11                	mov    %edx,(%ecx)
     b12:	eb b3                	jmp    ac7 <normalizeRange+0x17>
     b14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b20 <numLines>:
int numLines(int start, int end) {
     b20:	55                   	push   %ebp
     b21:	89 e5                	mov    %esp,%ebp
  return (end - start) + 1;
     b23:	8b 45 0c             	mov    0xc(%ebp),%eax
     b26:	2b 45 08             	sub    0x8(%ebp),%eax
}
     b29:	5d                   	pop    %ebp
  return (end - start) + 1;
     b2a:	83 c0 01             	add    $0x1,%eax
}
     b2d:	c3                   	ret    
     b2e:	66 90                	xchg   %ax,%ax

00000b30 <negatoi>:
int negatoi(char* str) {
     b30:	55                   	push   %ebp
     b31:	89 e5                	mov    %esp,%ebp
     b33:	53                   	push   %ebx
     b34:	83 ec 04             	sub    $0x4,%esp
     b37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (str[0] == '-') {
     b3a:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     b3d:	74 11                	je     b50 <negatoi+0x20>
}
     b3f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b42:	c9                   	leave  
  return atoi(str);
     b43:	e9 d8 08 00 00       	jmp    1420 <atoi>
     b48:	90                   	nop
     b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    substr(str, str, 1, strlen(str));
     b50:	83 ec 0c             	sub    $0xc,%esp
     b53:	53                   	push   %ebx
     b54:	e8 67 07 00 00       	call   12c0 <strlen>
     b59:	50                   	push   %eax
     b5a:	6a 01                	push   $0x1
     b5c:	53                   	push   %ebx
     b5d:	53                   	push   %ebx
     b5e:	e8 ad fc ff ff       	call   810 <substr>
    return 0 - atoi(str);
     b63:	83 c4 14             	add    $0x14,%esp
     b66:	53                   	push   %ebx
     b67:	e8 b4 08 00 00       	call   1420 <atoi>
     b6c:	83 c4 10             	add    $0x10,%esp
     b6f:	f7 d8                	neg    %eax
}
     b71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b74:	c9                   	leave  
     b75:	c3                   	ret    
     b76:	8d 76 00             	lea    0x0(%esi),%esi
     b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b80 <toUpper>:
void toUpper(char* str) {
     b80:	55                   	push   %ebp
     b81:	89 e5                	mov    %esp,%ebp
     b83:	8b 55 08             	mov    0x8(%ebp),%edx
  while (str[i] != '\0') {
     b86:	0f b6 02             	movzbl (%edx),%eax
     b89:	84 c0                	test   %al,%al
     b8b:	74 1a                	je     ba7 <toUpper+0x27>
     b8d:	8d 76 00             	lea    0x0(%esi),%esi
    if (c <= 'z' && c >= 'a')
     b90:	8d 48 9f             	lea    -0x61(%eax),%ecx
     b93:	80 f9 19             	cmp    $0x19,%cl
     b96:	77 05                	ja     b9d <toUpper+0x1d>
      str[i] += ('Z' - 'z');
     b98:	83 e8 20             	sub    $0x20,%eax
     b9b:	88 02                	mov    %al,(%edx)
     b9d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     ba0:	0f b6 02             	movzbl (%edx),%eax
     ba3:	84 c0                	test   %al,%al
     ba5:	75 e9                	jne    b90 <toUpper+0x10>
    i++;  
  }
}
     ba7:	5d                   	pop    %ebp
     ba8:	c3                   	ret    
     ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000bb0 <toLower>:

void toLower(char* str) {
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     bb6:	0f b6 02             	movzbl (%edx),%eax
     bb9:	84 c0                	test   %al,%al
     bbb:	74 1a                	je     bd7 <toLower+0x27>
     bbd:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'Z' && c >= 'A')
     bc0:	8d 48 bf             	lea    -0x41(%eax),%ecx
     bc3:	80 f9 19             	cmp    $0x19,%cl
     bc6:	77 05                	ja     bcd <toLower+0x1d>
      str[i] -= ('Z' - 'z');
     bc8:	83 c0 20             	add    $0x20,%eax
     bcb:	88 02                	mov    %al,(%edx)
     bcd:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     bd0:	0f b6 02             	movzbl (%edx),%eax
     bd3:	84 c0                	test   %al,%al
     bd5:	75 e9                	jne    bc0 <toLower+0x10>
    i++;  
  }
}
     bd7:	5d                   	pop    %ebp
     bd8:	c3                   	ret    
     bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000be0 <unline>:

void unline(char* str) {
     be0:	55                   	push   %ebp
     be1:	89 e5                	mov    %esp,%ebp
     be3:	53                   	push   %ebx
     be4:	83 ec 10             	sub    $0x10,%esp
     be7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str) - 1;
     bea:	53                   	push   %ebx
     beb:	e8 d0 06 00 00       	call   12c0 <strlen>
     bf0:	8d 50 ff             	lea    -0x1(%eax),%edx
  for (; len > 0; len--) {
     bf3:	83 c4 10             	add    $0x10,%esp
     bf6:	85 d2                	test   %edx,%edx
     bf8:	7e 36                	jle    c30 <unline+0x50>
    char c = str[len];
    if (c == '\n')
     bfa:	80 7c 03 ff 0a       	cmpb   $0xa,-0x1(%ebx,%eax,1)
     bff:	74 2f                	je     c30 <unline+0x50>
     c01:	8d 44 03 fe          	lea    -0x2(%ebx,%eax,1),%eax
     c05:	eb 12                	jmp    c19 <unline+0x39>
     c07:	89 f6                	mov    %esi,%esi
     c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     c10:	83 e8 01             	sub    $0x1,%eax
     c13:	80 78 01 0a          	cmpb   $0xa,0x1(%eax)
     c17:	74 06                	je     c1f <unline+0x3f>
  for (; len > 0; len--) {
     c19:	39 c3                	cmp    %eax,%ebx
     c1b:	89 c2                	mov    %eax,%edx
     c1d:	75 f1                	jne    c10 <unline+0x30>
      break;
  }
  str[len] = '\0';
     c1f:	c6 02 00             	movb   $0x0,(%edx)
}
     c22:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c25:	c9                   	leave  
     c26:	c3                   	ret    
     c27:	89 f6                	mov    %esi,%esi
     c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     c30:	01 da                	add    %ebx,%edx
  str[len] = '\0';
     c32:	c6 02 00             	movb   $0x0,(%edx)
}
     c35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c38:	c9                   	leave  
     c39:	c3                   	ret    
     c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000c40 <lineAt>:

// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
     c40:	55                   	push   %ebp
     c41:	89 e5                	mov    %esp,%ebp
  return nodeAt(list, pos-1);
     c43:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
}
     c47:	5d                   	pop    %ebp
  return nodeAt(list, pos-1);
     c48:	e9 d3 f7 ff ff       	jmp    420 <nodeAt>
     c4d:	8d 76 00             	lea    0x0(%esi),%esi

00000c50 <printl>:

void printl(int lineNum, char* line) {
     c50:	55                   	push   %ebp
     c51:	89 e5                	mov    %esp,%ebp
     c53:	83 ec 08             	sub    $0x8,%esp
     c56:	8b 45 08             	mov    0x8(%ebp),%eax
  if (lineNum < 10)
     c59:	83 f8 09             	cmp    $0x9,%eax
     c5c:	7e 3a                	jle    c98 <printl+0x48>
    fprintf(2, "%d  | %s\n", lineNum, line);
  else if (lineNum < 100)
     c5e:	83 f8 63             	cmp    $0x63,%eax
     c61:	7e 1d                	jle    c80 <printl+0x30>
    fprintf(2, "%d | %s\n", lineNum, line);
  else
    fprintf(2, "%d| %s\n", lineNum, line);
     c63:	ff 75 0c             	pushl  0xc(%ebp)
     c66:	50                   	push   %eax
     c67:	68 f2 19 00 00       	push   $0x19f2
     c6c:	6a 02                	push   $0x2
     c6e:	e8 8d 0b 00 00       	call   1800 <fprintf>
     c73:	83 c4 10             	add    $0x10,%esp
     c76:	c9                   	leave  
     c77:	c3                   	ret    
     c78:	90                   	nop
     c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "%d | %s\n", lineNum, line);
     c80:	ff 75 0c             	pushl  0xc(%ebp)
     c83:	50                   	push   %eax
     c84:	68 e9 19 00 00       	push   $0x19e9
     c89:	6a 02                	push   $0x2
     c8b:	e8 70 0b 00 00       	call   1800 <fprintf>
     c90:	83 c4 10             	add    $0x10,%esp
     c93:	c9                   	leave  
     c94:	c3                   	ret    
     c95:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "%d  | %s\n", lineNum, line);
     c98:	ff 75 0c             	pushl  0xc(%ebp)
     c9b:	50                   	push   %eax
     c9c:	68 df 19 00 00       	push   $0x19df
     ca1:	6a 02                	push   $0x2
     ca3:	e8 58 0b 00 00       	call   1800 <fprintf>
     ca8:	83 c4 10             	add    $0x10,%esp
     cab:	c9                   	leave  
     cac:	c3                   	ret    
     cad:	8d 76 00             	lea    0x0(%esi),%esi

00000cb0 <end>:
void end(struct File* file, char* args) {
     cb0:	55                   	push   %ebp
     cb1:	89 e5                	mov    %esp,%ebp
     cb3:	53                   	push   %ebx
     cb4:	83 ec 08             	sub    $0x8,%esp
     cb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  append(file->lines, line);
     cba:	8b 43 08             	mov    0x8(%ebx),%eax
     cbd:	ff 70 08             	pushl  0x8(%eax)
     cc0:	ff 75 0c             	pushl  0xc(%ebp)
     cc3:	50                   	push   %eax
     cc4:	e8 77 f8 ff ff       	call   540 <insert>
  file->len++;
     cc9:	83 43 0c 01          	addl   $0x1,0xc(%ebx)
}
     ccd:	83 c4 10             	add    $0x10,%esp
     cd0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cd3:	c9                   	leave  
     cd4:	c3                   	ret    
     cd5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ce0 <add>:
void add(struct File* file, char* args) {
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
     ce3:	57                   	push   %edi
     ce4:	56                   	push   %esi
     ce5:	53                   	push   %ebx
     ce6:	83 ec 28             	sub    $0x28,%esp
     ce9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     cec:	8b 75 08             	mov    0x8(%ebp),%esi
  if (strlen(args) < 1) {
     cef:	53                   	push   %ebx
     cf0:	e8 cb 05 00 00       	call   12c0 <strlen>
     cf5:	83 c4 10             	add    $0x10,%esp
     cf8:	85 c0                	test   %eax,%eax
     cfa:	74 3c                	je     d38 <add+0x58>
  getArg(lineStr, args, ' ');
     cfc:	8d 7d de             	lea    -0x22(%ebp),%edi
     cff:	83 ec 04             	sub    $0x4,%esp
     d02:	6a 20                	push   $0x20
     d04:	53                   	push   %ebx
     d05:	57                   	push   %edi
     d06:	e8 55 fb ff ff       	call   860 <getArg>
  int lineNum = negatoi(lineStr);
     d0b:	89 3c 24             	mov    %edi,(%esp)
     d0e:	e8 1d fe ff ff       	call   b30 <negatoi>
  insert(file->lines, line, lineNum - 1);
     d13:	83 c4 0c             	add    $0xc,%esp
     d16:	83 e8 01             	sub    $0x1,%eax
     d19:	50                   	push   %eax
     d1a:	53                   	push   %ebx
     d1b:	ff 76 08             	pushl  0x8(%esi)
     d1e:	e8 1d f8 ff ff       	call   540 <insert>
  file->len++;
     d23:	83 46 0c 01          	addl   $0x1,0xc(%esi)
     d27:	83 c4 10             	add    $0x10,%esp
}
     d2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d2d:	5b                   	pop    %ebx
     d2e:	5e                   	pop    %esi
     d2f:	5f                   	pop    %edi
     d30:	5d                   	pop    %ebp
     d31:	c3                   	ret    
     d32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "you need to give a line number to insert before\n");
     d38:	83 ec 08             	sub    $0x8,%esp
     d3b:	68 ec 1a 00 00       	push   $0x1aec
     d40:	6a 02                	push   $0x2
     d42:	e8 b9 0a 00 00       	call   1800 <fprintf>
     d47:	83 c4 10             	add    $0x10,%esp
}
     d4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d4d:	5b                   	pop    %ebx
     d4e:	5e                   	pop    %esi
     d4f:	5f                   	pop    %edi
     d50:	5d                   	pop    %ebp
     d51:	c3                   	ret    
     d52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d60 <drop>:
void drop(struct File* file, char* args) {
     d60:	55                   	push   %ebp
     d61:	89 e5                	mov    %esp,%ebp
     d63:	57                   	push   %edi
     d64:	56                   	push   %esi
     d65:	53                   	push   %ebx
     d66:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
     d69:	ff 75 0c             	pushl  0xc(%ebp)
void drop(struct File* file, char* args) {
     d6c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (strlen(args) < 1) {
     d6f:	e8 4c 05 00 00       	call   12c0 <strlen>
     d74:	83 c4 10             	add    $0x10,%esp
     d77:	85 c0                	test   %eax,%eax
     d79:	0f 84 f9 00 00 00    	je     e78 <drop+0x118>
  if (collectRange(args, &start, &end) == 1) {
     d7f:	8d 75 e4             	lea    -0x1c(%ebp),%esi
     d82:	8d 7d e0             	lea    -0x20(%ebp),%edi
     d85:	83 ec 04             	sub    $0x4,%esp
     d88:	56                   	push   %esi
     d89:	57                   	push   %edi
     d8a:	ff 75 0c             	pushl  0xc(%ebp)
     d8d:	e8 3e fb ff ff       	call   8d0 <collectRange>
     d92:	83 c4 10             	add    $0x10,%esp
     d95:	83 f8 01             	cmp    $0x1,%eax
     d98:	0f 84 fa 00 00 00    	je     e98 <drop+0x138>
  if (normalizeRange(*file, &start, &end) == 1) {
     d9e:	83 ec 08             	sub    $0x8,%esp
     da1:	56                   	push   %esi
     da2:	57                   	push   %edi
     da3:	ff 73 0c             	pushl  0xc(%ebx)
     da6:	ff 73 08             	pushl  0x8(%ebx)
     da9:	ff 73 04             	pushl  0x4(%ebx)
     dac:	ff 33                	pushl  (%ebx)
     dae:	e8 fd fc ff ff       	call   ab0 <normalizeRange>
     db3:	83 c4 20             	add    $0x20,%esp
     db6:	83 f8 01             	cmp    $0x1,%eax
     db9:	0f 84 11 01 00 00    	je     ed0 <drop+0x170>
  int numl = numLines(start, end);
     dbf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     dc2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return (end - start) + 1;
     dc5:	89 d6                	mov    %edx,%esi
     dc7:	29 c6                	sub    %eax,%esi
     dc9:	8d 7e 01             	lea    0x1(%esi),%edi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
     dcc:	83 ff 01             	cmp    $0x1,%edi
     dcf:	89 7d d4             	mov    %edi,-0x2c(%ebp)
     dd2:	0f 84 e0 00 00 00    	je     eb8 <drop+0x158>
  else fprintf(2, "Drop %d lines [%d:%d] (y/n)? ", numl, start, end);
     dd8:	83 ec 0c             	sub    $0xc,%esp
     ddb:	52                   	push   %edx
     ddc:	50                   	push   %eax
     ddd:	ff 75 d4             	pushl  -0x2c(%ebp)
     de0:	68 0f 1a 00 00       	push   $0x1a0f
     de5:	6a 02                	push   $0x2
     de7:	e8 14 0a 00 00       	call   1800 <fprintf>
     dec:	83 c4 20             	add    $0x20,%esp
  if (confirmation() != 0) return;
     def:	e8 6c f9 ff ff       	call   760 <confirmation>
     df4:	85 c0                	test   %eax,%eax
     df6:	75 72                	jne    e6a <drop+0x10a>
  return nodeAt(list, pos-1);
     df8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  struct Node* curNode = (lineAt(file->lines, start))->prev;
     dfb:	8b 4b 08             	mov    0x8(%ebx),%ecx
     dfe:	83 ec 08             	sub    $0x8,%esp
     e01:	83 e8 01             	sub    $0x1,%eax
     e04:	89 4d d0             	mov    %ecx,-0x30(%ebp)
     e07:	50                   	push   %eax
     e08:	51                   	push   %ecx
     e09:	e8 12 f6 ff ff       	call   420 <nodeAt>
     e0e:	8b 30                	mov    (%eax),%esi
     e10:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     e13:	5a                   	pop    %edx
     e14:	59                   	pop    %ecx
     e15:	8b 4d d0             	mov    -0x30(%ebp),%ecx
     e18:	83 e8 01             	sub    $0x1,%eax
     e1b:	50                   	push   %eax
     e1c:	51                   	push   %ecx
     e1d:	e8 fe f5 ff ff       	call   420 <nodeAt>
     e22:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
     e25:	39 c6                	cmp    %eax,%esi
     e27:	89 c7                	mov    %eax,%edi
     e29:	8b 4d d0             	mov    -0x30(%ebp),%ecx
     e2c:	75 05                	jne    e33 <drop+0xd3>
     e2e:	eb 1b                	jmp    e4b <drop+0xeb>
     e30:	8b 4b 08             	mov    0x8(%ebx),%ecx
    curNode = curNode->next;
     e33:	8b 76 08             	mov    0x8(%esi),%esi
    destroyNode(file->lines, curNode);
     e36:	83 ec 08             	sub    $0x8,%esp
     e39:	56                   	push   %esi
     e3a:	51                   	push   %ecx
     e3b:	e8 50 f6 ff ff       	call   490 <destroyNode>
    file->len--;
     e40:	83 6b 0c 01          	subl   $0x1,0xc(%ebx)
  while (curNode != stopNode) {
     e44:	83 c4 10             	add    $0x10,%esp
     e47:	39 f7                	cmp    %esi,%edi
     e49:	75 e5                	jne    e30 <drop+0xd0>
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
     e4b:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
     e4f:	0f 84 93 00 00 00    	je     ee8 <drop+0x188>
  else fprintf(2, "%d lines dropped\n", numl);
     e55:	83 ec 04             	sub    $0x4,%esp
     e58:	ff 75 d4             	pushl  -0x2c(%ebp)
     e5b:	68 3e 1a 00 00       	push   $0x1a3e
     e60:	6a 02                	push   $0x2
     e62:	e8 99 09 00 00       	call   1800 <fprintf>
     e67:	83 c4 10             	add    $0x10,%esp
}
     e6a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e6d:	5b                   	pop    %ebx
     e6e:	5e                   	pop    %esi
     e6f:	5f                   	pop    %edi
     e70:	5d                   	pop    %ebp
     e71:	c3                   	ret    
     e72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "you need to give a range to drop\n");
     e78:	83 ec 08             	sub    $0x8,%esp
     e7b:	68 20 1b 00 00       	push   $0x1b20
     e80:	6a 02                	push   $0x2
     e82:	e8 79 09 00 00       	call   1800 <fprintf>
    return;
     e87:	83 c4 10             	add    $0x10,%esp
}
     e8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e8d:	5b                   	pop    %ebx
     e8e:	5e                   	pop    %esi
     e8f:	5f                   	pop    %edi
     e90:	5d                   	pop    %ebp
     e91:	c3                   	ret    
     e92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: start index is larger than end index\n");
     e98:	83 ec 08             	sub    $0x8,%esp
     e9b:	68 44 1b 00 00       	push   $0x1b44
     ea0:	6a 02                	push   $0x2
     ea2:	e8 59 09 00 00       	call   1800 <fprintf>
     ea7:	83 c4 10             	add    $0x10,%esp
}
     eaa:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ead:	5b                   	pop    %ebx
     eae:	5e                   	pop    %esi
     eaf:	5f                   	pop    %edi
     eb0:	5d                   	pop    %ebp
     eb1:	c3                   	ret    
     eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
     eb8:	83 ec 04             	sub    $0x4,%esp
     ebb:	50                   	push   %eax
     ebc:	68 fa 19 00 00       	push   $0x19fa
     ec1:	6a 02                	push   $0x2
     ec3:	e8 38 09 00 00       	call   1800 <fprintf>
     ec8:	83 c4 10             	add    $0x10,%esp
     ecb:	e9 1f ff ff ff       	jmp    def <drop+0x8f>
    fprintf(2, "error: bad input range. make sure start < end\n");
     ed0:	83 ec 08             	sub    $0x8,%esp
     ed3:	68 74 1b 00 00       	push   $0x1b74
     ed8:	6a 02                	push   $0x2
     eda:	e8 21 09 00 00       	call   1800 <fprintf>
     edf:	83 c4 10             	add    $0x10,%esp
     ee2:	eb 86                	jmp    e6a <drop+0x10a>
     ee4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
     ee8:	83 ec 04             	sub    $0x4,%esp
     eeb:	ff 75 e0             	pushl  -0x20(%ebp)
     eee:	68 2d 1a 00 00       	push   $0x1a2d
     ef3:	6a 02                	push   $0x2
     ef5:	e8 06 09 00 00       	call   1800 <fprintf>
     efa:	83 c4 10             	add    $0x10,%esp
     efd:	e9 68 ff ff ff       	jmp    e6a <drop+0x10a>
     f02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000f10 <edit>:
void edit(struct File* file, char* args) {
     f10:	55                   	push   %ebp
     f11:	89 e5                	mov    %esp,%ebp
     f13:	57                   	push   %edi
     f14:	56                   	push   %esi
     f15:	53                   	push   %ebx
     f16:	83 ec 28             	sub    $0x28,%esp
     f19:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if (strlen(args) < 1) {
     f1c:	53                   	push   %ebx
     f1d:	e8 9e 03 00 00       	call   12c0 <strlen>
     f22:	83 c4 10             	add    $0x10,%esp
     f25:	85 c0                	test   %eax,%eax
     f27:	74 57                	je     f80 <edit+0x70>
  getArg(lineStr, args, ' ');
     f29:	8d 75 de             	lea    -0x22(%ebp),%esi
     f2c:	83 ec 04             	sub    $0x4,%esp
     f2f:	6a 20                	push   $0x20
     f31:	53                   	push   %ebx
     f32:	56                   	push   %esi
     f33:	e8 28 f9 ff ff       	call   860 <getArg>
  int lineNum = negatoi(lineStr);
     f38:	89 34 24             	mov    %esi,(%esp)
     f3b:	e8 f0 fb ff ff       	call   b30 <negatoi>
  destroyNode(file->lines, lineAt(file->lines, lineNum));
     f40:	8b 55 08             	mov    0x8(%ebp),%edx
     f43:	8d 70 ff             	lea    -0x1(%eax),%esi
     f46:	58                   	pop    %eax
     f47:	8b 7a 08             	mov    0x8(%edx),%edi
     f4a:	5a                   	pop    %edx
     f4b:	56                   	push   %esi
     f4c:	57                   	push   %edi
     f4d:	e8 ce f4 ff ff       	call   420 <nodeAt>
     f52:	59                   	pop    %ecx
     f53:	5a                   	pop    %edx
     f54:	50                   	push   %eax
     f55:	57                   	push   %edi
     f56:	e8 35 f5 ff ff       	call   490 <destroyNode>
  insert(file->lines, line, lineNum - 1);
     f5b:	8b 45 08             	mov    0x8(%ebp),%eax
     f5e:	83 c4 0c             	add    $0xc,%esp
     f61:	56                   	push   %esi
     f62:	53                   	push   %ebx
     f63:	ff 70 08             	pushl  0x8(%eax)
     f66:	e8 d5 f5 ff ff       	call   540 <insert>
     f6b:	83 c4 10             	add    $0x10,%esp
}
     f6e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f71:	5b                   	pop    %ebx
     f72:	5e                   	pop    %esi
     f73:	5f                   	pop    %edi
     f74:	5d                   	pop    %ebp
     f75:	c3                   	ret    
     f76:	8d 76 00             	lea    0x0(%esi),%esi
     f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    fprintf(2, "you need to give a line number to replace\n");
     f80:	83 ec 08             	sub    $0x8,%esp
     f83:	68 a4 1b 00 00       	push   $0x1ba4
     f88:	6a 02                	push   $0x2
     f8a:	e8 71 08 00 00       	call   1800 <fprintf>
     f8f:	83 c4 10             	add    $0x10,%esp
}
     f92:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f95:	5b                   	pop    %ebx
     f96:	5e                   	pop    %esi
     f97:	5f                   	pop    %edi
     f98:	5d                   	pop    %ebp
     f99:	c3                   	ret    
     f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000fa0 <list>:
void list(struct File file, char* args) {
     fa0:	55                   	push   %ebp
     fa1:	89 e5                	mov    %esp,%ebp
     fa3:	57                   	push   %edi
     fa4:	56                   	push   %esi
     fa5:	53                   	push   %ebx
     fa6:	83 ec 28             	sub    $0x28,%esp
  if (strlen(args) < 1) {
     fa9:	ff 75 18             	pushl  0x18(%ebp)
     fac:	8b 75 10             	mov    0x10(%ebp),%esi
     faf:	e8 0c 03 00 00       	call   12c0 <strlen>
     fb4:	83 c4 10             	add    $0x10,%esp
     fb7:	85 c0                	test   %eax,%eax
     fb9:	75 1d                	jne    fd8 <list+0x38>
    fprintf(2, "you need to give a range to list\n");
     fbb:	83 ec 08             	sub    $0x8,%esp
     fbe:	68 d0 1b 00 00       	push   $0x1bd0
     fc3:	6a 02                	push   $0x2
     fc5:	e8 36 08 00 00       	call   1800 <fprintf>
    return;
     fca:	83 c4 10             	add    $0x10,%esp
}
     fcd:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fd0:	5b                   	pop    %ebx
     fd1:	5e                   	pop    %esi
     fd2:	5f                   	pop    %edi
     fd3:	5d                   	pop    %ebp
     fd4:	c3                   	ret    
     fd5:	8d 76 00             	lea    0x0(%esi),%esi
  if (collectRange(args, &start, &end) == 1) {
     fd8:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
     fdb:	8d 7d e0             	lea    -0x20(%ebp),%edi
     fde:	83 ec 04             	sub    $0x4,%esp
     fe1:	53                   	push   %ebx
     fe2:	57                   	push   %edi
     fe3:	ff 75 18             	pushl  0x18(%ebp)
     fe6:	e8 e5 f8 ff ff       	call   8d0 <collectRange>
     feb:	83 c4 10             	add    $0x10,%esp
     fee:	83 f8 01             	cmp    $0x1,%eax
     ff1:	0f 84 89 00 00 00    	je     1080 <list+0xe0>
  if (normalizeRange(file, &start, &end) == 1) {
     ff7:	83 ec 08             	sub    $0x8,%esp
     ffa:	53                   	push   %ebx
     ffb:	57                   	push   %edi
     ffc:	ff 75 14             	pushl  0x14(%ebp)
     fff:	ff 75 10             	pushl  0x10(%ebp)
    1002:	ff 75 0c             	pushl  0xc(%ebp)
    1005:	ff 75 08             	pushl  0x8(%ebp)
    1008:	e8 a3 fa ff ff       	call   ab0 <normalizeRange>
    100d:	83 c4 20             	add    $0x20,%esp
    1010:	83 f8 01             	cmp    $0x1,%eax
    1013:	0f 84 87 00 00 00    	je     10a0 <list+0x100>
    1019:	8b 45 e0             	mov    -0x20(%ebp),%eax
    101c:	83 ec 08             	sub    $0x8,%esp
    101f:	83 e8 01             	sub    $0x1,%eax
    1022:	50                   	push   %eax
    1023:	56                   	push   %esi
    1024:	e8 f7 f3 ff ff       	call   420 <nodeAt>
  struct Node* curNode = (lineAt(file.lines, start))->prev;
    1029:	8b 18                	mov    (%eax),%ebx
    102b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    102e:	5a                   	pop    %edx
    102f:	59                   	pop    %ecx
    1030:	83 e8 01             	sub    $0x1,%eax
    1033:	50                   	push   %eax
    1034:	56                   	push   %esi
    1035:	e8 e6 f3 ff ff       	call   420 <nodeAt>
    103a:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
    103d:	39 d8                	cmp    %ebx,%eax
    103f:	89 c7                	mov    %eax,%edi
    1041:	74 8a                	je     fcd <list+0x2d>
    curNode = curNode->next;
    1043:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
    1046:	3b 5e 04             	cmp    0x4(%esi),%ebx
    1049:	75 11                	jne    105c <list+0xbc>
    104b:	eb 80                	jmp    fcd <list+0x2d>
    104d:	8d 76 00             	lea    0x0(%esi),%esi
    curNode = curNode->next;
    1050:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
    1053:	39 5e 04             	cmp    %ebx,0x4(%esi)
    1056:	0f 84 71 ff ff ff    	je     fcd <list+0x2d>
    fprintf(2, "%s\n", curNode->data);
    105c:	83 ec 04             	sub    $0x4,%esp
    105f:	ff 73 04             	pushl  0x4(%ebx)
    1062:	68 db 19 00 00       	push   $0x19db
    1067:	6a 02                	push   $0x2
    1069:	e8 92 07 00 00       	call   1800 <fprintf>
  while (curNode != stopNode) {
    106e:	83 c4 10             	add    $0x10,%esp
    1071:	39 df                	cmp    %ebx,%edi
    1073:	75 db                	jne    1050 <list+0xb0>
}
    1075:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1078:	5b                   	pop    %ebx
    1079:	5e                   	pop    %esi
    107a:	5f                   	pop    %edi
    107b:	5d                   	pop    %ebp
    107c:	c3                   	ret    
    107d:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "error: start index is larger than end index\n");
    1080:	83 ec 08             	sub    $0x8,%esp
    1083:	68 44 1b 00 00       	push   $0x1b44
    1088:	6a 02                	push   $0x2
    108a:	e8 71 07 00 00       	call   1800 <fprintf>
    return;
    108f:	83 c4 10             	add    $0x10,%esp
}
    1092:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1095:	5b                   	pop    %ebx
    1096:	5e                   	pop    %esi
    1097:	5f                   	pop    %edi
    1098:	5d                   	pop    %ebp
    1099:	c3                   	ret    
    109a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: bad input range. make sure start < end\n");
    10a0:	83 ec 08             	sub    $0x8,%esp
    10a3:	68 74 1b 00 00       	push   $0x1b74
    10a8:	6a 02                	push   $0x2
    10aa:	e8 51 07 00 00       	call   1800 <fprintf>
    return;
    10af:	83 c4 10             	add    $0x10,%esp
    10b2:	e9 16 ff ff ff       	jmp    fcd <list+0x2d>
    10b7:	89 f6                	mov    %esi,%esi
    10b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010c0 <show>:
void show(struct File file, char* args) {
    10c0:	55                   	push   %ebp
    10c1:	89 e5                	mov    %esp,%ebp
    10c3:	57                   	push   %edi
    10c4:	56                   	push   %esi
    10c5:	53                   	push   %ebx
    10c6:	83 ec 0c             	sub    $0xc,%esp
    10c9:	8b 7d 10             	mov    0x10(%ebp),%edi
  struct Node* cur = file.lines->head->next;
    10cc:	8b 07                	mov    (%edi),%eax
    10ce:	8b 58 08             	mov    0x8(%eax),%ebx
  while (cur != file.lines->tail) {
    10d1:	3b 5f 04             	cmp    0x4(%edi),%ebx
    10d4:	74 24                	je     10fa <show+0x3a>
  int lineNum = 1;
    10d6:	be 01 00 00 00       	mov    $0x1,%esi
    10db:	90                   	nop
    10dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printl(lineNum, cur->data);
    10e0:	83 ec 08             	sub    $0x8,%esp
    10e3:	ff 73 04             	pushl  0x4(%ebx)
    10e6:	56                   	push   %esi
    lineNum++;
    10e7:	83 c6 01             	add    $0x1,%esi
    printl(lineNum, cur->data);
    10ea:	e8 61 fb ff ff       	call   c50 <printl>
    cur = cur->next;
    10ef:	8b 5b 08             	mov    0x8(%ebx),%ebx
  while (cur != file.lines->tail) {
    10f2:	83 c4 10             	add    $0x10,%esp
    10f5:	39 5f 04             	cmp    %ebx,0x4(%edi)
    10f8:	75 e6                	jne    10e0 <show+0x20>
}
    10fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10fd:	5b                   	pop    %ebx
    10fe:	5e                   	pop    %esi
    10ff:	5f                   	pop    %edi
    1100:	5d                   	pop    %ebp
    1101:	c3                   	ret    
    1102:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001110 <quit>:
void quit(struct File* file) {
    1110:	55                   	push   %ebp
    1111:	89 e5                	mov    %esp,%ebp
    1113:	56                   	push   %esi
    1114:	53                   	push   %ebx
    1115:	8b 75 08             	mov    0x8(%ebp),%esi
  fprintf(2, "save changes (y/n)? ");
    1118:	83 ec 08             	sub    $0x8,%esp
    111b:	68 50 1a 00 00       	push   $0x1a50
    1120:	6a 02                	push   $0x2
    1122:	e8 d9 06 00 00       	call   1800 <fprintf>
  if (confirmation() != 0) return;
    1127:	e8 34 f6 ff ff       	call   760 <confirmation>
    112c:	83 c4 10             	add    $0x10,%esp
    112f:	85 c0                	test   %eax,%eax
    1131:	74 0d                	je     1140 <quit+0x30>
}
    1133:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1136:	5b                   	pop    %ebx
    1137:	5e                   	pop    %esi
    1138:	5d                   	pop    %ebp
    1139:	c3                   	ret    
    113a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if (unlink(file->filename) < 0) {
    1140:	83 ec 0c             	sub    $0xc,%esp
    1143:	ff 36                	pushl  (%esi)
    1145:	e8 98 03 00 00       	call   14e2 <unlink>
    114a:	83 c4 10             	add    $0x10,%esp
    114d:	85 c0                	test   %eax,%eax
    114f:	0f 88 8b 00 00 00    	js     11e0 <quit+0xd0>
  file->fd = open(file->filename, O_CREATE|O_RDWR);
    1155:	83 ec 08             	sub    $0x8,%esp
    1158:	68 02 02 00 00       	push   $0x202
    115d:	ff 36                	pushl  (%esi)
    115f:	e8 6e 03 00 00       	call   14d2 <open>
  if (file->fd < 0) {
    1164:	83 c4 10             	add    $0x10,%esp
    1167:	85 c0                	test   %eax,%eax
  file->fd = open(file->filename, O_CREATE|O_RDWR);
    1169:	89 46 04             	mov    %eax,0x4(%esi)
  if (file->fd < 0) {
    116c:	0f 88 8e 00 00 00    	js     1200 <quit+0xf0>
  struct Node* cur = file->lines->head->next;
    1172:	8b 56 08             	mov    0x8(%esi),%edx
    1175:	8b 0a                	mov    (%edx),%ecx
    1177:	8b 59 08             	mov    0x8(%ecx),%ebx
  while (cur != file->lines->tail) {
    117a:	3b 5a 04             	cmp    0x4(%edx),%ebx
    117d:	74 3e                	je     11bd <quit+0xad>
    117f:	90                   	nop
    write(file->fd, cur->data, strlen(cur->data));
    1180:	83 ec 0c             	sub    $0xc,%esp
    1183:	ff 73 04             	pushl  0x4(%ebx)
    1186:	e8 35 01 00 00       	call   12c0 <strlen>
    118b:	83 c4 0c             	add    $0xc,%esp
    118e:	50                   	push   %eax
    118f:	ff 73 04             	pushl  0x4(%ebx)
    1192:	ff 76 04             	pushl  0x4(%esi)
    1195:	e8 18 03 00 00       	call   14b2 <write>
    write(file->fd, "\n", sizeof(char));
    119a:	83 c4 0c             	add    $0xc,%esp
    119d:	6a 01                	push   $0x1
    119f:	68 9c 1a 00 00       	push   $0x1a9c
    11a4:	ff 76 04             	pushl  0x4(%esi)
    11a7:	e8 06 03 00 00       	call   14b2 <write>
  while (cur != file->lines->tail) {
    11ac:	8b 46 08             	mov    0x8(%esi),%eax
    cur = cur->next;
    11af:	8b 5b 08             	mov    0x8(%ebx),%ebx
  while (cur != file->lines->tail) {
    11b2:	83 c4 10             	add    $0x10,%esp
    11b5:	3b 58 04             	cmp    0x4(%eax),%ebx
    11b8:	75 c6                	jne    1180 <quit+0x70>
    11ba:	8b 46 04             	mov    0x4(%esi),%eax
  close(file->fd);
    11bd:	83 ec 0c             	sub    $0xc,%esp
    11c0:	50                   	push   %eax
    11c1:	e8 f4 02 00 00       	call   14ba <close>
  fprintf(2, "changes saved\n");
    11c6:	58                   	pop    %eax
    11c7:	5a                   	pop    %edx
    11c8:	68 65 1a 00 00       	push   $0x1a65
    11cd:	6a 02                	push   $0x2
    11cf:	e8 2c 06 00 00       	call   1800 <fprintf>
    11d4:	83 c4 10             	add    $0x10,%esp
}
    11d7:	8d 65 f8             	lea    -0x8(%ebp),%esp
    11da:	5b                   	pop    %ebx
    11db:	5e                   	pop    %esi
    11dc:	5d                   	pop    %ebp
    11dd:	c3                   	ret    
    11de:	66 90                	xchg   %ax,%ax
    fprintf(2, "could not clear file for writing. changes lost\n");
    11e0:	83 ec 08             	sub    $0x8,%esp
    11e3:	68 f4 1b 00 00       	push   $0x1bf4
    11e8:	6a 02                	push   $0x2
    11ea:	e8 11 06 00 00       	call   1800 <fprintf>
    return;
    11ef:	83 c4 10             	add    $0x10,%esp
}
    11f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
    11f5:	5b                   	pop    %ebx
    11f6:	5e                   	pop    %esi
    11f7:	5d                   	pop    %ebp
    11f8:	c3                   	ret    
    11f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "could not open file for writing. changes lost\n");
    1200:	83 ec 08             	sub    $0x8,%esp
    1203:	68 24 1c 00 00       	push   $0x1c24
    1208:	6a 02                	push   $0x2
    120a:	e8 f1 05 00 00       	call   1800 <fprintf>
    return;
    120f:	83 c4 10             	add    $0x10,%esp
    1212:	e9 1c ff ff ff       	jmp    1133 <quit+0x23>
    1217:	89 f6                	mov    %esi,%esi
    1219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001220 <bi>:
void bi() {
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	83 ec 10             	sub    $0x10,%esp
  fprintf(2, "bad bi input\n");
    1226:	68 da 1a 00 00       	push   $0x1ada
    122b:	6a 02                	push   $0x2
    122d:	e8 ce 05 00 00       	call   1800 <fprintf>
}
    1232:	83 c4 10             	add    $0x10,%esp
    1235:	c9                   	leave  
    1236:	c3                   	ret    
    1237:	66 90                	xchg   %ax,%ax
    1239:	66 90                	xchg   %ax,%ax
    123b:	66 90                	xchg   %ax,%ax
    123d:	66 90                	xchg   %ax,%ax
    123f:	90                   	nop

00001240 <strcpy>:
    1240:	55                   	push   %ebp
    1241:	89 e5                	mov    %esp,%ebp
    1243:	53                   	push   %ebx
    1244:	8b 45 08             	mov    0x8(%ebp),%eax
    1247:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    124a:	89 c2                	mov    %eax,%edx
    124c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1250:	83 c1 01             	add    $0x1,%ecx
    1253:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1257:	83 c2 01             	add    $0x1,%edx
    125a:	84 db                	test   %bl,%bl
    125c:	88 5a ff             	mov    %bl,-0x1(%edx)
    125f:	75 ef                	jne    1250 <strcpy+0x10>
    1261:	5b                   	pop    %ebx
    1262:	5d                   	pop    %ebp
    1263:	c3                   	ret    
    1264:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    126a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001270 <strcmp>:
    1270:	55                   	push   %ebp
    1271:	89 e5                	mov    %esp,%ebp
    1273:	53                   	push   %ebx
    1274:	8b 55 08             	mov    0x8(%ebp),%edx
    1277:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    127a:	0f b6 02             	movzbl (%edx),%eax
    127d:	0f b6 19             	movzbl (%ecx),%ebx
    1280:	84 c0                	test   %al,%al
    1282:	75 1c                	jne    12a0 <strcmp+0x30>
    1284:	eb 2a                	jmp    12b0 <strcmp+0x40>
    1286:	8d 76 00             	lea    0x0(%esi),%esi
    1289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1290:	83 c2 01             	add    $0x1,%edx
    1293:	0f b6 02             	movzbl (%edx),%eax
    1296:	83 c1 01             	add    $0x1,%ecx
    1299:	0f b6 19             	movzbl (%ecx),%ebx
    129c:	84 c0                	test   %al,%al
    129e:	74 10                	je     12b0 <strcmp+0x40>
    12a0:	38 d8                	cmp    %bl,%al
    12a2:	74 ec                	je     1290 <strcmp+0x20>
    12a4:	29 d8                	sub    %ebx,%eax
    12a6:	5b                   	pop    %ebx
    12a7:	5d                   	pop    %ebp
    12a8:	c3                   	ret    
    12a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12b0:	31 c0                	xor    %eax,%eax
    12b2:	29 d8                	sub    %ebx,%eax
    12b4:	5b                   	pop    %ebx
    12b5:	5d                   	pop    %ebp
    12b6:	c3                   	ret    
    12b7:	89 f6                	mov    %esi,%esi
    12b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000012c0 <strlen>:
    12c0:	55                   	push   %ebp
    12c1:	89 e5                	mov    %esp,%ebp
    12c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    12c6:	80 39 00             	cmpb   $0x0,(%ecx)
    12c9:	74 15                	je     12e0 <strlen+0x20>
    12cb:	31 d2                	xor    %edx,%edx
    12cd:	8d 76 00             	lea    0x0(%esi),%esi
    12d0:	83 c2 01             	add    $0x1,%edx
    12d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    12d7:	89 d0                	mov    %edx,%eax
    12d9:	75 f5                	jne    12d0 <strlen+0x10>
    12db:	5d                   	pop    %ebp
    12dc:	c3                   	ret    
    12dd:	8d 76 00             	lea    0x0(%esi),%esi
    12e0:	31 c0                	xor    %eax,%eax
    12e2:	5d                   	pop    %ebp
    12e3:	c3                   	ret    
    12e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    12ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000012f0 <memset>:
    12f0:	55                   	push   %ebp
    12f1:	89 e5                	mov    %esp,%ebp
    12f3:	57                   	push   %edi
    12f4:	8b 55 08             	mov    0x8(%ebp),%edx
    12f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    12fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    12fd:	89 d7                	mov    %edx,%edi
    12ff:	fc                   	cld    
    1300:	f3 aa                	rep stos %al,%es:(%edi)
    1302:	89 d0                	mov    %edx,%eax
    1304:	5f                   	pop    %edi
    1305:	5d                   	pop    %ebp
    1306:	c3                   	ret    
    1307:	89 f6                	mov    %esi,%esi
    1309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001310 <strchr>:
    1310:	55                   	push   %ebp
    1311:	89 e5                	mov    %esp,%ebp
    1313:	53                   	push   %ebx
    1314:	8b 45 08             	mov    0x8(%ebp),%eax
    1317:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    131a:	0f b6 10             	movzbl (%eax),%edx
    131d:	84 d2                	test   %dl,%dl
    131f:	74 1d                	je     133e <strchr+0x2e>
    1321:	38 d3                	cmp    %dl,%bl
    1323:	89 d9                	mov    %ebx,%ecx
    1325:	75 0d                	jne    1334 <strchr+0x24>
    1327:	eb 17                	jmp    1340 <strchr+0x30>
    1329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1330:	38 ca                	cmp    %cl,%dl
    1332:	74 0c                	je     1340 <strchr+0x30>
    1334:	83 c0 01             	add    $0x1,%eax
    1337:	0f b6 10             	movzbl (%eax),%edx
    133a:	84 d2                	test   %dl,%dl
    133c:	75 f2                	jne    1330 <strchr+0x20>
    133e:	31 c0                	xor    %eax,%eax
    1340:	5b                   	pop    %ebx
    1341:	5d                   	pop    %ebp
    1342:	c3                   	ret    
    1343:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001350 <gets>:
    1350:	55                   	push   %ebp
    1351:	89 e5                	mov    %esp,%ebp
    1353:	57                   	push   %edi
    1354:	56                   	push   %esi
    1355:	53                   	push   %ebx
    1356:	31 f6                	xor    %esi,%esi
    1358:	89 f3                	mov    %esi,%ebx
    135a:	83 ec 1c             	sub    $0x1c,%esp
    135d:	8b 7d 08             	mov    0x8(%ebp),%edi
    1360:	eb 2f                	jmp    1391 <gets+0x41>
    1362:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1368:	8d 45 e7             	lea    -0x19(%ebp),%eax
    136b:	83 ec 04             	sub    $0x4,%esp
    136e:	6a 01                	push   $0x1
    1370:	50                   	push   %eax
    1371:	6a 00                	push   $0x0
    1373:	e8 32 01 00 00       	call   14aa <read>
    1378:	83 c4 10             	add    $0x10,%esp
    137b:	85 c0                	test   %eax,%eax
    137d:	7e 1c                	jle    139b <gets+0x4b>
    137f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1383:	83 c7 01             	add    $0x1,%edi
    1386:	88 47 ff             	mov    %al,-0x1(%edi)
    1389:	3c 0a                	cmp    $0xa,%al
    138b:	74 23                	je     13b0 <gets+0x60>
    138d:	3c 0d                	cmp    $0xd,%al
    138f:	74 1f                	je     13b0 <gets+0x60>
    1391:	83 c3 01             	add    $0x1,%ebx
    1394:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1397:	89 fe                	mov    %edi,%esi
    1399:	7c cd                	jl     1368 <gets+0x18>
    139b:	89 f3                	mov    %esi,%ebx
    139d:	8b 45 08             	mov    0x8(%ebp),%eax
    13a0:	c6 03 00             	movb   $0x0,(%ebx)
    13a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    13a6:	5b                   	pop    %ebx
    13a7:	5e                   	pop    %esi
    13a8:	5f                   	pop    %edi
    13a9:	5d                   	pop    %ebp
    13aa:	c3                   	ret    
    13ab:	90                   	nop
    13ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    13b0:	8b 75 08             	mov    0x8(%ebp),%esi
    13b3:	8b 45 08             	mov    0x8(%ebp),%eax
    13b6:	01 de                	add    %ebx,%esi
    13b8:	89 f3                	mov    %esi,%ebx
    13ba:	c6 03 00             	movb   $0x0,(%ebx)
    13bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    13c0:	5b                   	pop    %ebx
    13c1:	5e                   	pop    %esi
    13c2:	5f                   	pop    %edi
    13c3:	5d                   	pop    %ebp
    13c4:	c3                   	ret    
    13c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    13c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000013d0 <stat>:
    13d0:	55                   	push   %ebp
    13d1:	89 e5                	mov    %esp,%ebp
    13d3:	56                   	push   %esi
    13d4:	53                   	push   %ebx
    13d5:	83 ec 08             	sub    $0x8,%esp
    13d8:	6a 00                	push   $0x0
    13da:	ff 75 08             	pushl  0x8(%ebp)
    13dd:	e8 f0 00 00 00       	call   14d2 <open>
    13e2:	83 c4 10             	add    $0x10,%esp
    13e5:	85 c0                	test   %eax,%eax
    13e7:	78 27                	js     1410 <stat+0x40>
    13e9:	83 ec 08             	sub    $0x8,%esp
    13ec:	ff 75 0c             	pushl  0xc(%ebp)
    13ef:	89 c3                	mov    %eax,%ebx
    13f1:	50                   	push   %eax
    13f2:	e8 f3 00 00 00       	call   14ea <fstat>
    13f7:	89 1c 24             	mov    %ebx,(%esp)
    13fa:	89 c6                	mov    %eax,%esi
    13fc:	e8 b9 00 00 00       	call   14ba <close>
    1401:	83 c4 10             	add    $0x10,%esp
    1404:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1407:	89 f0                	mov    %esi,%eax
    1409:	5b                   	pop    %ebx
    140a:	5e                   	pop    %esi
    140b:	5d                   	pop    %ebp
    140c:	c3                   	ret    
    140d:	8d 76 00             	lea    0x0(%esi),%esi
    1410:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1415:	eb ed                	jmp    1404 <stat+0x34>
    1417:	89 f6                	mov    %esi,%esi
    1419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001420 <atoi>:
    1420:	55                   	push   %ebp
    1421:	89 e5                	mov    %esp,%ebp
    1423:	53                   	push   %ebx
    1424:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1427:	0f be 11             	movsbl (%ecx),%edx
    142a:	8d 42 d0             	lea    -0x30(%edx),%eax
    142d:	3c 09                	cmp    $0x9,%al
    142f:	b8 00 00 00 00       	mov    $0x0,%eax
    1434:	77 1f                	ja     1455 <atoi+0x35>
    1436:	8d 76 00             	lea    0x0(%esi),%esi
    1439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1440:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1443:	83 c1 01             	add    $0x1,%ecx
    1446:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
    144a:	0f be 11             	movsbl (%ecx),%edx
    144d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1450:	80 fb 09             	cmp    $0x9,%bl
    1453:	76 eb                	jbe    1440 <atoi+0x20>
    1455:	5b                   	pop    %ebx
    1456:	5d                   	pop    %ebp
    1457:	c3                   	ret    
    1458:	90                   	nop
    1459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001460 <memmove>:
    1460:	55                   	push   %ebp
    1461:	89 e5                	mov    %esp,%ebp
    1463:	56                   	push   %esi
    1464:	53                   	push   %ebx
    1465:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1468:	8b 45 08             	mov    0x8(%ebp),%eax
    146b:	8b 75 0c             	mov    0xc(%ebp),%esi
    146e:	85 db                	test   %ebx,%ebx
    1470:	7e 14                	jle    1486 <memmove+0x26>
    1472:	31 d2                	xor    %edx,%edx
    1474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1478:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    147c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    147f:	83 c2 01             	add    $0x1,%edx
    1482:	39 d3                	cmp    %edx,%ebx
    1484:	75 f2                	jne    1478 <memmove+0x18>
    1486:	5b                   	pop    %ebx
    1487:	5e                   	pop    %esi
    1488:	5d                   	pop    %ebp
    1489:	c3                   	ret    

0000148a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    148a:	b8 01 00 00 00       	mov    $0x1,%eax
    148f:	cd 40                	int    $0x40
    1491:	c3                   	ret    

00001492 <exit>:
SYSCALL(exit)
    1492:	b8 02 00 00 00       	mov    $0x2,%eax
    1497:	cd 40                	int    $0x40
    1499:	c3                   	ret    

0000149a <wait>:
SYSCALL(wait)
    149a:	b8 03 00 00 00       	mov    $0x3,%eax
    149f:	cd 40                	int    $0x40
    14a1:	c3                   	ret    

000014a2 <pipe>:
SYSCALL(pipe)
    14a2:	b8 04 00 00 00       	mov    $0x4,%eax
    14a7:	cd 40                	int    $0x40
    14a9:	c3                   	ret    

000014aa <read>:
SYSCALL(read)
    14aa:	b8 05 00 00 00       	mov    $0x5,%eax
    14af:	cd 40                	int    $0x40
    14b1:	c3                   	ret    

000014b2 <write>:
SYSCALL(write)
    14b2:	b8 10 00 00 00       	mov    $0x10,%eax
    14b7:	cd 40                	int    $0x40
    14b9:	c3                   	ret    

000014ba <close>:
SYSCALL(close)
    14ba:	b8 15 00 00 00       	mov    $0x15,%eax
    14bf:	cd 40                	int    $0x40
    14c1:	c3                   	ret    

000014c2 <kill>:
SYSCALL(kill)
    14c2:	b8 06 00 00 00       	mov    $0x6,%eax
    14c7:	cd 40                	int    $0x40
    14c9:	c3                   	ret    

000014ca <exec>:
SYSCALL(exec)
    14ca:	b8 07 00 00 00       	mov    $0x7,%eax
    14cf:	cd 40                	int    $0x40
    14d1:	c3                   	ret    

000014d2 <open>:
SYSCALL(open)
    14d2:	b8 0f 00 00 00       	mov    $0xf,%eax
    14d7:	cd 40                	int    $0x40
    14d9:	c3                   	ret    

000014da <mknod>:
SYSCALL(mknod)
    14da:	b8 11 00 00 00       	mov    $0x11,%eax
    14df:	cd 40                	int    $0x40
    14e1:	c3                   	ret    

000014e2 <unlink>:
SYSCALL(unlink)
    14e2:	b8 12 00 00 00       	mov    $0x12,%eax
    14e7:	cd 40                	int    $0x40
    14e9:	c3                   	ret    

000014ea <fstat>:
SYSCALL(fstat)
    14ea:	b8 08 00 00 00       	mov    $0x8,%eax
    14ef:	cd 40                	int    $0x40
    14f1:	c3                   	ret    

000014f2 <link>:
SYSCALL(link)
    14f2:	b8 13 00 00 00       	mov    $0x13,%eax
    14f7:	cd 40                	int    $0x40
    14f9:	c3                   	ret    

000014fa <mkdir>:
SYSCALL(mkdir)
    14fa:	b8 14 00 00 00       	mov    $0x14,%eax
    14ff:	cd 40                	int    $0x40
    1501:	c3                   	ret    

00001502 <chdir>:
SYSCALL(chdir)
    1502:	b8 09 00 00 00       	mov    $0x9,%eax
    1507:	cd 40                	int    $0x40
    1509:	c3                   	ret    

0000150a <dup>:
SYSCALL(dup)
    150a:	b8 0a 00 00 00       	mov    $0xa,%eax
    150f:	cd 40                	int    $0x40
    1511:	c3                   	ret    

00001512 <getpid>:
SYSCALL(getpid)
    1512:	b8 0b 00 00 00       	mov    $0xb,%eax
    1517:	cd 40                	int    $0x40
    1519:	c3                   	ret    

0000151a <sbrk>:
SYSCALL(sbrk)
    151a:	b8 0c 00 00 00       	mov    $0xc,%eax
    151f:	cd 40                	int    $0x40
    1521:	c3                   	ret    

00001522 <sleep>:
SYSCALL(sleep)
    1522:	b8 0d 00 00 00       	mov    $0xd,%eax
    1527:	cd 40                	int    $0x40
    1529:	c3                   	ret    

0000152a <uptime>:
SYSCALL(uptime)
    152a:	b8 0e 00 00 00       	mov    $0xe,%eax
    152f:	cd 40                	int    $0x40
    1531:	c3                   	ret    

00001532 <cpuhalt>:
SYSCALL(cpuhalt)
    1532:	b8 16 00 00 00       	mov    $0x16,%eax
    1537:	cd 40                	int    $0x40
    1539:	c3                   	ret    
    153a:	66 90                	xchg   %ax,%ax
    153c:	66 90                	xchg   %ax,%ax
    153e:	66 90                	xchg   %ax,%ax

00001540 <printint.constprop.1>:
    1540:	55                   	push   %ebp
    1541:	89 e5                	mov    %esp,%ebp
    1543:	57                   	push   %edi
    1544:	56                   	push   %esi
    1545:	53                   	push   %ebx
    1546:	89 d6                	mov    %edx,%esi
    1548:	83 ec 3c             	sub    $0x3c,%esp
    154b:	85 c0                	test   %eax,%eax
    154d:	79 71                	jns    15c0 <printint.constprop.1+0x80>
    154f:	83 e1 01             	and    $0x1,%ecx
    1552:	74 6c                	je     15c0 <printint.constprop.1+0x80>
    1554:	f7 d8                	neg    %eax
    1556:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    155d:	31 c9                	xor    %ecx,%ecx
    155f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1562:	eb 06                	jmp    156a <printint.constprop.1+0x2a>
    1564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1568:	89 f9                	mov    %edi,%ecx
    156a:	31 d2                	xor    %edx,%edx
    156c:	8d 79 01             	lea    0x1(%ecx),%edi
    156f:	f7 f6                	div    %esi
    1571:	0f b6 92 7c 1c 00 00 	movzbl 0x1c7c(%edx),%edx
    1578:	85 c0                	test   %eax,%eax
    157a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
    157d:	75 e9                	jne    1568 <printint.constprop.1+0x28>
    157f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1582:	85 c0                	test   %eax,%eax
    1584:	74 08                	je     158e <printint.constprop.1+0x4e>
    1586:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    158b:	8d 79 02             	lea    0x2(%ecx),%edi
    158e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    1592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1598:	0f b6 06             	movzbl (%esi),%eax
    159b:	83 ec 04             	sub    $0x4,%esp
    159e:	83 ee 01             	sub    $0x1,%esi
    15a1:	6a 01                	push   $0x1
    15a3:	53                   	push   %ebx
    15a4:	6a 01                	push   $0x1
    15a6:	88 45 d7             	mov    %al,-0x29(%ebp)
    15a9:	e8 04 ff ff ff       	call   14b2 <write>
    15ae:	83 c4 10             	add    $0x10,%esp
    15b1:	39 de                	cmp    %ebx,%esi
    15b3:	75 e3                	jne    1598 <printint.constprop.1+0x58>
    15b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
    15b8:	5b                   	pop    %ebx
    15b9:	5e                   	pop    %esi
    15ba:	5f                   	pop    %edi
    15bb:	5d                   	pop    %ebp
    15bc:	c3                   	ret    
    15bd:	8d 76 00             	lea    0x0(%esi),%esi
    15c0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    15c7:	eb 94                	jmp    155d <printint.constprop.1+0x1d>
    15c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000015d0 <vprintf.constprop.0>:
    15d0:	55                   	push   %ebp
    15d1:	89 e5                	mov    %esp,%ebp
    15d3:	57                   	push   %edi
    15d4:	56                   	push   %esi
    15d5:	53                   	push   %ebx
    15d6:	89 d6                	mov    %edx,%esi
    15d8:	83 ec 2c             	sub    $0x2c,%esp
    15db:	0f b6 10             	movzbl (%eax),%edx
    15de:	84 d2                	test   %dl,%dl
    15e0:	0f 84 cd 00 00 00    	je     16b3 <vprintf.constprop.0+0xe3>
    15e6:	8d 58 01             	lea    0x1(%eax),%ebx
    15e9:	31 ff                	xor    %edi,%edi
    15eb:	eb 31                	jmp    161e <vprintf.constprop.0+0x4e>
    15ed:	8d 76 00             	lea    0x0(%esi),%esi
    15f0:	83 f8 25             	cmp    $0x25,%eax
    15f3:	0f 84 c7 00 00 00    	je     16c0 <vprintf.constprop.0+0xf0>
    15f9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    15fc:	83 ec 04             	sub    $0x4,%esp
    15ff:	88 55 e4             	mov    %dl,-0x1c(%ebp)
    1602:	6a 01                	push   $0x1
    1604:	50                   	push   %eax
    1605:	6a 01                	push   $0x1
    1607:	e8 a6 fe ff ff       	call   14b2 <write>
    160c:	83 c4 10             	add    $0x10,%esp
    160f:	83 c3 01             	add    $0x1,%ebx
    1612:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1616:	84 d2                	test   %dl,%dl
    1618:	0f 84 95 00 00 00    	je     16b3 <vprintf.constprop.0+0xe3>
    161e:	85 ff                	test   %edi,%edi
    1620:	0f b6 c2             	movzbl %dl,%eax
    1623:	74 cb                	je     15f0 <vprintf.constprop.0+0x20>
    1625:	83 ff 25             	cmp    $0x25,%edi
    1628:	75 e5                	jne    160f <vprintf.constprop.0+0x3f>
    162a:	83 f8 64             	cmp    $0x64,%eax
    162d:	8d 7e 04             	lea    0x4(%esi),%edi
    1630:	b9 01 00 00 00       	mov    $0x1,%ecx
    1635:	0f 84 9a 00 00 00    	je     16d5 <vprintf.constprop.0+0x105>
    163b:	83 f8 6c             	cmp    $0x6c,%eax
    163e:	0f 84 8c 00 00 00    	je     16d0 <vprintf.constprop.0+0x100>
    1644:	83 f8 78             	cmp    $0x78,%eax
    1647:	0f 84 a3 00 00 00    	je     16f0 <vprintf.constprop.0+0x120>
    164d:	83 f8 70             	cmp    $0x70,%eax
    1650:	0f 84 ca 00 00 00    	je     1720 <vprintf.constprop.0+0x150>
    1656:	83 f8 73             	cmp    $0x73,%eax
    1659:	0f 84 39 01 00 00    	je     1798 <vprintf.constprop.0+0x1c8>
    165f:	83 f8 63             	cmp    $0x63,%eax
    1662:	0f 84 68 01 00 00    	je     17d0 <vprintf.constprop.0+0x200>
    1668:	83 f8 25             	cmp    $0x25,%eax
    166b:	0f 84 9f 00 00 00    	je     1710 <vprintf.constprop.0+0x140>
    1671:	8d 45 df             	lea    -0x21(%ebp),%eax
    1674:	83 ec 04             	sub    $0x4,%esp
    1677:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    167a:	6a 01                	push   $0x1
    167c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
    1680:	50                   	push   %eax
    1681:	6a 01                	push   $0x1
    1683:	e8 2a fe ff ff       	call   14b2 <write>
    1688:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    168c:	83 c4 0c             	add    $0xc,%esp
    168f:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1692:	6a 01                	push   $0x1
    1694:	88 55 e0             	mov    %dl,-0x20(%ebp)
    1697:	50                   	push   %eax
    1698:	6a 01                	push   $0x1
    169a:	83 c3 01             	add    $0x1,%ebx
    169d:	31 ff                	xor    %edi,%edi
    169f:	e8 0e fe ff ff       	call   14b2 <write>
    16a4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    16a8:	83 c4 10             	add    $0x10,%esp
    16ab:	84 d2                	test   %dl,%dl
    16ad:	0f 85 6b ff ff ff    	jne    161e <vprintf.constprop.0+0x4e>
    16b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16b6:	5b                   	pop    %ebx
    16b7:	5e                   	pop    %esi
    16b8:	5f                   	pop    %edi
    16b9:	5d                   	pop    %ebp
    16ba:	c3                   	ret    
    16bb:	90                   	nop
    16bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    16c0:	bf 25 00 00 00       	mov    $0x25,%edi
    16c5:	e9 45 ff ff ff       	jmp    160f <vprintf.constprop.0+0x3f>
    16ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    16d0:	8d 7e 04             	lea    0x4(%esi),%edi
    16d3:	31 c9                	xor    %ecx,%ecx
    16d5:	8b 06                	mov    (%esi),%eax
    16d7:	ba 0a 00 00 00       	mov    $0xa,%edx
    16dc:	89 fe                	mov    %edi,%esi
    16de:	31 ff                	xor    %edi,%edi
    16e0:	e8 5b fe ff ff       	call   1540 <printint.constprop.1>
    16e5:	e9 25 ff ff ff       	jmp    160f <vprintf.constprop.0+0x3f>
    16ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    16f0:	8b 06                	mov    (%esi),%eax
    16f2:	8d 7e 04             	lea    0x4(%esi),%edi
    16f5:	31 c9                	xor    %ecx,%ecx
    16f7:	ba 10 00 00 00       	mov    $0x10,%edx
    16fc:	89 fe                	mov    %edi,%esi
    16fe:	31 ff                	xor    %edi,%edi
    1700:	e8 3b fe ff ff       	call   1540 <printint.constprop.1>
    1705:	e9 05 ff ff ff       	jmp    160f <vprintf.constprop.0+0x3f>
    170a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1710:	83 ec 04             	sub    $0x4,%esp
    1713:	88 55 e1             	mov    %dl,-0x1f(%ebp)
    1716:	8d 45 e1             	lea    -0x1f(%ebp),%eax
    1719:	6a 01                	push   $0x1
    171b:	e9 77 ff ff ff       	jmp    1697 <vprintf.constprop.0+0xc7>
    1720:	8d 46 04             	lea    0x4(%esi),%eax
    1723:	83 ec 04             	sub    $0x4,%esp
    1726:	8b 3e                	mov    (%esi),%edi
    1728:	6a 01                	push   $0x1
    172a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
    172e:	be 08 00 00 00       	mov    $0x8,%esi
    1733:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1736:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1739:	50                   	push   %eax
    173a:	6a 01                	push   $0x1
    173c:	e8 71 fd ff ff       	call   14b2 <write>
    1741:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1744:	83 c4 0c             	add    $0xc,%esp
    1747:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
    174b:	6a 01                	push   $0x1
    174d:	50                   	push   %eax
    174e:	6a 01                	push   $0x1
    1750:	e8 5d fd ff ff       	call   14b2 <write>
    1755:	83 c4 10             	add    $0x10,%esp
    1758:	90                   	nop
    1759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1760:	89 f8                	mov    %edi,%eax
    1762:	83 ec 04             	sub    $0x4,%esp
    1765:	c1 e7 04             	shl    $0x4,%edi
    1768:	c1 e8 1c             	shr    $0x1c,%eax
    176b:	6a 01                	push   $0x1
    176d:	0f b6 80 7c 1c 00 00 	movzbl 0x1c7c(%eax),%eax
    1774:	88 45 e5             	mov    %al,-0x1b(%ebp)
    1777:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    177a:	50                   	push   %eax
    177b:	6a 01                	push   $0x1
    177d:	e8 30 fd ff ff       	call   14b2 <write>
    1782:	83 c4 10             	add    $0x10,%esp
    1785:	83 ee 01             	sub    $0x1,%esi
    1788:	75 d6                	jne    1760 <vprintf.constprop.0+0x190>
    178a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    178d:	31 ff                	xor    %edi,%edi
    178f:	e9 7b fe ff ff       	jmp    160f <vprintf.constprop.0+0x3f>
    1794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1798:	8b 3e                	mov    (%esi),%edi
    179a:	8d 46 04             	lea    0x4(%esi),%eax
    179d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    17a0:	85 ff                	test   %edi,%edi
    17a2:	74 50                	je     17f4 <vprintf.constprop.0+0x224>
    17a4:	0f b6 07             	movzbl (%edi),%eax
    17a7:	84 c0                	test   %al,%al
    17a9:	74 df                	je     178a <vprintf.constprop.0+0x1ba>
    17ab:	8d 75 e3             	lea    -0x1d(%ebp),%esi
    17ae:	66 90                	xchg   %ax,%ax
    17b0:	83 ec 04             	sub    $0x4,%esp
    17b3:	83 c7 01             	add    $0x1,%edi
    17b6:	88 45 e3             	mov    %al,-0x1d(%ebp)
    17b9:	6a 01                	push   $0x1
    17bb:	56                   	push   %esi
    17bc:	6a 01                	push   $0x1
    17be:	e8 ef fc ff ff       	call   14b2 <write>
    17c3:	0f b6 07             	movzbl (%edi),%eax
    17c6:	83 c4 10             	add    $0x10,%esp
    17c9:	84 c0                	test   %al,%al
    17cb:	75 e3                	jne    17b0 <vprintf.constprop.0+0x1e0>
    17cd:	eb bb                	jmp    178a <vprintf.constprop.0+0x1ba>
    17cf:	90                   	nop
    17d0:	8b 06                	mov    (%esi),%eax
    17d2:	83 ec 04             	sub    $0x4,%esp
    17d5:	8d 7e 04             	lea    0x4(%esi),%edi
    17d8:	6a 01                	push   $0x1
    17da:	89 fe                	mov    %edi,%esi
    17dc:	31 ff                	xor    %edi,%edi
    17de:	88 45 e2             	mov    %al,-0x1e(%ebp)
    17e1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    17e4:	50                   	push   %eax
    17e5:	6a 01                	push   $0x1
    17e7:	e8 c6 fc ff ff       	call   14b2 <write>
    17ec:	83 c4 10             	add    $0x10,%esp
    17ef:	e9 1b fe ff ff       	jmp    160f <vprintf.constprop.0+0x3f>
    17f4:	bf 74 1c 00 00       	mov    $0x1c74,%edi
    17f9:	b8 28 00 00 00       	mov    $0x28,%eax
    17fe:	eb ab                	jmp    17ab <vprintf.constprop.0+0x1db>

00001800 <fprintf>:
    1800:	55                   	push   %ebp
    1801:	89 e5                	mov    %esp,%ebp
    1803:	83 ec 08             	sub    $0x8,%esp
    1806:	8b 45 0c             	mov    0xc(%ebp),%eax
    1809:	8d 55 10             	lea    0x10(%ebp),%edx
    180c:	e8 bf fd ff ff       	call   15d0 <vprintf.constprop.0>
    1811:	c9                   	leave  
    1812:	c3                   	ret    
    1813:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001820 <printf>:
    1820:	55                   	push   %ebp
    1821:	89 e5                	mov    %esp,%ebp
    1823:	83 ec 08             	sub    $0x8,%esp
    1826:	8b 45 08             	mov    0x8(%ebp),%eax
    1829:	8d 55 0c             	lea    0xc(%ebp),%edx
    182c:	e8 9f fd ff ff       	call   15d0 <vprintf.constprop.0>
    1831:	c9                   	leave  
    1832:	c3                   	ret    
    1833:	66 90                	xchg   %ax,%ax
    1835:	66 90                	xchg   %ax,%ax
    1837:	66 90                	xchg   %ax,%ax
    1839:	66 90                	xchg   %ax,%ax
    183b:	66 90                	xchg   %ax,%ax
    183d:	66 90                	xchg   %ax,%ax
    183f:	90                   	nop

00001840 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1840:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1841:	a1 28 29 00 00       	mov    0x2928,%eax
{
    1846:	89 e5                	mov    %esp,%ebp
    1848:	57                   	push   %edi
    1849:	56                   	push   %esi
    184a:	53                   	push   %ebx
    184b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    184e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1858:	39 c8                	cmp    %ecx,%eax
    185a:	8b 10                	mov    (%eax),%edx
    185c:	73 32                	jae    1890 <free+0x50>
    185e:	39 d1                	cmp    %edx,%ecx
    1860:	72 04                	jb     1866 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1862:	39 d0                	cmp    %edx,%eax
    1864:	72 32                	jb     1898 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1866:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1869:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    186c:	39 fa                	cmp    %edi,%edx
    186e:	74 30                	je     18a0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1870:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1873:	8b 50 04             	mov    0x4(%eax),%edx
    1876:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1879:	39 f1                	cmp    %esi,%ecx
    187b:	74 3a                	je     18b7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    187d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    187f:	a3 28 29 00 00       	mov    %eax,0x2928
}
    1884:	5b                   	pop    %ebx
    1885:	5e                   	pop    %esi
    1886:	5f                   	pop    %edi
    1887:	5d                   	pop    %ebp
    1888:	c3                   	ret    
    1889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1890:	39 d0                	cmp    %edx,%eax
    1892:	72 04                	jb     1898 <free+0x58>
    1894:	39 d1                	cmp    %edx,%ecx
    1896:	72 ce                	jb     1866 <free+0x26>
{
    1898:	89 d0                	mov    %edx,%eax
    189a:	eb bc                	jmp    1858 <free+0x18>
    189c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    18a0:	03 72 04             	add    0x4(%edx),%esi
    18a3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    18a6:	8b 10                	mov    (%eax),%edx
    18a8:	8b 12                	mov    (%edx),%edx
    18aa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    18ad:	8b 50 04             	mov    0x4(%eax),%edx
    18b0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    18b3:	39 f1                	cmp    %esi,%ecx
    18b5:	75 c6                	jne    187d <free+0x3d>
    p->s.size += bp->s.size;
    18b7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    18ba:	a3 28 29 00 00       	mov    %eax,0x2928
    p->s.size += bp->s.size;
    18bf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    18c2:	8b 53 f8             	mov    -0x8(%ebx),%edx
    18c5:	89 10                	mov    %edx,(%eax)
}
    18c7:	5b                   	pop    %ebx
    18c8:	5e                   	pop    %esi
    18c9:	5f                   	pop    %edi
    18ca:	5d                   	pop    %ebp
    18cb:	c3                   	ret    
    18cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000018d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    18d0:	55                   	push   %ebp
    18d1:	89 e5                	mov    %esp,%ebp
    18d3:	57                   	push   %edi
    18d4:	56                   	push   %esi
    18d5:	53                   	push   %ebx
    18d6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    18d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    18dc:	8b 15 28 29 00 00    	mov    0x2928,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    18e2:	8d 78 07             	lea    0x7(%eax),%edi
    18e5:	c1 ef 03             	shr    $0x3,%edi
    18e8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    18eb:	85 d2                	test   %edx,%edx
    18ed:	0f 84 9d 00 00 00    	je     1990 <malloc+0xc0>
    18f3:	8b 02                	mov    (%edx),%eax
    18f5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    18f8:	39 cf                	cmp    %ecx,%edi
    18fa:	76 6c                	jbe    1968 <malloc+0x98>
    18fc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1902:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1907:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    190a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1911:	eb 0e                	jmp    1921 <malloc+0x51>
    1913:	90                   	nop
    1914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1918:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    191a:	8b 48 04             	mov    0x4(%eax),%ecx
    191d:	39 f9                	cmp    %edi,%ecx
    191f:	73 47                	jae    1968 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1921:	39 05 28 29 00 00    	cmp    %eax,0x2928
    1927:	89 c2                	mov    %eax,%edx
    1929:	75 ed                	jne    1918 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    192b:	83 ec 0c             	sub    $0xc,%esp
    192e:	56                   	push   %esi
    192f:	e8 e6 fb ff ff       	call   151a <sbrk>
  if(p == (char*)-1)
    1934:	83 c4 10             	add    $0x10,%esp
    1937:	83 f8 ff             	cmp    $0xffffffff,%eax
    193a:	74 1c                	je     1958 <malloc+0x88>
  hp->s.size = nu;
    193c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    193f:	83 ec 0c             	sub    $0xc,%esp
    1942:	83 c0 08             	add    $0x8,%eax
    1945:	50                   	push   %eax
    1946:	e8 f5 fe ff ff       	call   1840 <free>
  return freep;
    194b:	8b 15 28 29 00 00    	mov    0x2928,%edx
      if((p = morecore(nunits)) == 0)
    1951:	83 c4 10             	add    $0x10,%esp
    1954:	85 d2                	test   %edx,%edx
    1956:	75 c0                	jne    1918 <malloc+0x48>
        return 0;
  }
}
    1958:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    195b:	31 c0                	xor    %eax,%eax
}
    195d:	5b                   	pop    %ebx
    195e:	5e                   	pop    %esi
    195f:	5f                   	pop    %edi
    1960:	5d                   	pop    %ebp
    1961:	c3                   	ret    
    1962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1968:	39 cf                	cmp    %ecx,%edi
    196a:	74 54                	je     19c0 <malloc+0xf0>
        p->s.size -= nunits;
    196c:	29 f9                	sub    %edi,%ecx
    196e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1971:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1974:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1977:	89 15 28 29 00 00    	mov    %edx,0x2928
}
    197d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1980:	83 c0 08             	add    $0x8,%eax
}
    1983:	5b                   	pop    %ebx
    1984:	5e                   	pop    %esi
    1985:	5f                   	pop    %edi
    1986:	5d                   	pop    %ebp
    1987:	c3                   	ret    
    1988:	90                   	nop
    1989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1990:	c7 05 28 29 00 00 2c 	movl   $0x292c,0x2928
    1997:	29 00 00 
    199a:	c7 05 2c 29 00 00 2c 	movl   $0x292c,0x292c
    19a1:	29 00 00 
    base.s.size = 0;
    19a4:	b8 2c 29 00 00       	mov    $0x292c,%eax
    19a9:	c7 05 30 29 00 00 00 	movl   $0x0,0x2930
    19b0:	00 00 00 
    19b3:	e9 44 ff ff ff       	jmp    18fc <malloc+0x2c>
    19b8:	90                   	nop
    19b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    19c0:	8b 08                	mov    (%eax),%ecx
    19c2:	89 0a                	mov    %ecx,(%edx)
    19c4:	eb b1                	jmp    1977 <malloc+0xa7>
