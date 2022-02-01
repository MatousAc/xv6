
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
      11:	81 ec f8 00 00 00    	sub    $0xf8,%esp
      17:	8b 01                	mov    (%ecx),%eax
      19:	8b 51 04             	mov    0x4(%ecx),%edx
  // arg czeching
  if (argc < 2) {
      1c:	83 f8 01             	cmp    $0x1,%eax
      1f:	0f 8e 26 02 00 00    	jle    24b <main+0x24b>
    fprintf(2, "specify a file you want to edit");
    exit();
  } else if (argc > 2) {
      25:	83 f8 02             	cmp    $0x2,%eax
      28:	0f 85 0a 02 00 00    	jne    238 <main+0x238>
    fprintf(2, "only specify one file");
    exit();
  }
  static char buf[100] = "";
  char cmdstr[100] = "";
      2e:	8d bd 24 ff ff ff    	lea    -0xdc(%ebp),%edi
      34:	31 c0                	xor    %eax,%eax
      36:	b9 18 00 00 00       	mov    $0x18,%ecx
      3b:	c7 85 20 ff ff ff 00 	movl   $0x0,-0xe0(%ebp)
      42:	00 00 00 
  char args[100] = "";
      45:	c7 45 84 00 00 00 00 	movl   $0x0,-0x7c(%ebp)
  char cmdstr[100] = "";
      4c:	f3 ab                	rep stos %eax,%es:(%edi)
  char args[100] = "";
      4e:	8d 7d 88             	lea    -0x78(%ebp),%edi
      51:	b9 18 00 00 00       	mov    $0x18,%ecx
    uint ino;
    short nlink;
    uint size;
  };
  struct File file;
  file.len = 0;
      56:	c7 85 1c ff ff ff 00 	movl   $0x0,-0xe4(%ebp)
      5d:	00 00 00 
  char args[100] = "";
      60:	f3 ab                	rep stos %eax,%es:(%edi)
  file.filename = argv[1];
      62:	8b 42 04             	mov    0x4(%edx),%eax
      65:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%ebp)
  file.lines = MakeLinkedList();
      6b:	e8 e0 03 00 00       	call   450 <MakeLinkedList>
  fprintf(2, "Welcome to xvEdit!\n");
      70:	57                   	push   %edi
      71:	57                   	push   %edi
      72:	68 7d 18 00 00       	push   $0x187d
      77:	6a 02                	push   $0x2
  file.lines = MakeLinkedList();
      79:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
  fprintf(2, "Welcome to xvEdit!\n");
      7f:	e8 5c 15 00 00       	call   15e0 <fprintf>

  // opening
  file.fd = open(file.filename, O_RDONLY);
      84:	58                   	pop    %eax
      85:	5a                   	pop    %edx
      86:	6a 00                	push   $0x0
      88:	ff b5 10 ff ff ff    	pushl  -0xf0(%ebp)
      8e:	e8 1f 12 00 00       	call   12b2 <open>
  if (file.fd == -1) {
      93:	83 c4 10             	add    $0x10,%esp
  file.fd = open(file.filename, O_RDONLY);
      96:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
  if (file.fd == -1) {
      9c:	83 c0 01             	add    $0x1,%eax
      9f:	0f 84 b9 01 00 00    	je     25e <main+0x25e>
    fprintf(2, "creating %s . . .\n",  file.filename);
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
    close(file.fd);
  } else { // populate Linked List
    gatherLines(&file);
      a5:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
      ab:	83 ec 0c             	sub    $0xc,%esp
      ae:	50                   	push   %eax
      af:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
      b5:	e8 b6 05 00 00       	call   670 <gatherLines>
      ba:	83 c4 10             	add    $0x10,%esp
  }
  close(file.fd);
      bd:	83 ec 0c             	sub    $0xc,%esp
      c0:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
      c6:	8d 9d 20 ff ff ff    	lea    -0xe0(%ebp),%ebx
      cc:	e8 c9 11 00 00       	call   129a <close>
      d1:	83 c4 10             	add    $0x10,%esp
      d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // xvEdit>
  while (cmd != QUIT) {
    fprintf(2, "xvEdit> ");
      d8:	83 ec 08             	sub    $0x8,%esp
      db:	68 a4 18 00 00       	push   $0x18a4
      e0:	6a 02                	push   $0x2
      e2:	e8 f9 14 00 00       	call   15e0 <fprintf>
    memset(buf, 0, nbuf);
      e7:	83 c4 0c             	add    $0xc,%esp
      ea:	6a 64                	push   $0x64
      ec:	6a 00                	push   $0x0
      ee:	68 80 22 00 00       	push   $0x2280
      f3:	e8 d8 0f 00 00       	call   10d0 <memset>
    gets(buf, nbuf);
      f8:	58                   	pop    %eax
      f9:	5a                   	pop    %edx
      fa:	6a 64                	push   $0x64
      fc:	68 80 22 00 00       	push   $0x2280
     101:	e8 2a 10 00 00       	call   1130 <gets>
    
    unline(buf);
     106:	c7 04 24 80 22 00 00 	movl   $0x2280,(%esp)
     10d:	e8 fe 09 00 00       	call   b10 <unline>
    substr(cmdstr, buf, 0, 4);
     112:	6a 04                	push   $0x4
     114:	6a 00                	push   $0x0
     116:	68 80 22 00 00       	push   $0x2280
     11b:	53                   	push   %ebx
     11c:	e8 6f 06 00 00       	call   790 <substr>
  return (end - start) + 1;
}

void toUpper(char* str) {
  int i = 0;
  while (str[i] != '\0') {
     121:	0f b6 85 20 ff ff ff 	movzbl -0xe0(%ebp),%eax
     128:	83 c4 20             	add    $0x20,%esp
     12b:	84 c0                	test   %al,%al
     12d:	74 20                	je     14f <main+0x14f>
     12f:	89 da                	mov    %ebx,%edx
     131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    char c = str[i];
    if (c <= 'z' && c >= 'a')
     138:	8d 48 9f             	lea    -0x61(%eax),%ecx
     13b:	80 f9 19             	cmp    $0x19,%cl
     13e:	77 05                	ja     145 <main+0x145>
      str[i] += ('Z' - 'z');
     140:	83 e8 20             	sub    $0x20,%eax
     143:	88 02                	mov    %al,(%edx)
     145:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     148:	0f b6 02             	movzbl (%edx),%eax
     14b:	84 c0                	test   %al,%al
     14d:	75 e9                	jne    138 <main+0x138>
    toUpper(cmdstr);
    substr(args, buf, strlen(cmdstr) + 1, strlen(buf));
     14f:	83 ec 0c             	sub    $0xc,%esp
     152:	68 80 22 00 00       	push   $0x2280
     157:	e8 44 0f 00 00       	call   10a0 <strlen>
     15c:	89 1c 24             	mov    %ebx,(%esp)
     15f:	89 c6                	mov    %eax,%esi
     161:	e8 3a 0f 00 00       	call   10a0 <strlen>
     166:	83 c0 01             	add    $0x1,%eax
     169:	56                   	push   %esi
     16a:	50                   	push   %eax
     16b:	8d 45 84             	lea    -0x7c(%ebp),%eax
     16e:	68 80 22 00 00       	push   $0x2280
     173:	50                   	push   %eax
     174:	e8 17 06 00 00       	call   790 <substr>

    if      (strcmp(cmdstr, "@END") == 0) {cmd = END;}
     179:	83 c4 18             	add    $0x18,%esp
     17c:	68 ad 18 00 00       	push   $0x18ad
     181:	53                   	push   %ebx
     182:	e8 c9 0e 00 00       	call   1050 <strcmp>
     187:	83 c4 10             	add    $0x10,%esp
     18a:	85 c0                	test   %eax,%eax
     18c:	0f 84 46 ff ff ff    	je     d8 <main+0xd8>
    else if (strcmp(cmdstr, "ADD<") == 0) {cmd = ADD;}
     192:	50                   	push   %eax
     193:	50                   	push   %eax
     194:	68 b2 18 00 00       	push   $0x18b2
     199:	53                   	push   %ebx
     19a:	e8 b1 0e 00 00       	call   1050 <strcmp>
     19f:	83 c4 10             	add    $0x10,%esp
     1a2:	85 c0                	test   %eax,%eax
     1a4:	0f 84 2e ff ff ff    	je     d8 <main+0xd8>
    else if (strcmp(cmdstr, "DROP") == 0) {cmd = DROP;}
     1aa:	50                   	push   %eax
     1ab:	50                   	push   %eax
     1ac:	68 b7 18 00 00       	push   $0x18b7
     1b1:	53                   	push   %ebx
     1b2:	e8 99 0e 00 00       	call   1050 <strcmp>
     1b7:	83 c4 10             	add    $0x10,%esp
     1ba:	85 c0                	test   %eax,%eax
     1bc:	0f 84 02 01 00 00    	je     2c4 <main+0x2c4>
    else if (strcmp(cmdstr, "EDIT") == 0) {cmd = EDIT;}
     1c2:	50                   	push   %eax
     1c3:	50                   	push   %eax
     1c4:	68 bc 18 00 00       	push   $0x18bc
     1c9:	53                   	push   %ebx
     1ca:	e8 81 0e 00 00       	call   1050 <strcmp>
     1cf:	83 c4 10             	add    $0x10,%esp
     1d2:	85 c0                	test   %eax,%eax
     1d4:	0f 84 fe fe ff ff    	je     d8 <main+0xd8>
    else if (strcmp(cmdstr, "LIST") == 0) {cmd = LIST;}
     1da:	50                   	push   %eax
     1db:	50                   	push   %eax
     1dc:	68 c1 18 00 00       	push   $0x18c1
     1e1:	53                   	push   %ebx
     1e2:	e8 69 0e 00 00       	call   1050 <strcmp>
     1e7:	83 c4 10             	add    $0x10,%esp
     1ea:	85 c0                	test   %eax,%eax
     1ec:	0f 84 eb 00 00 00    	je     2dd <main+0x2dd>
    else if (strcmp(cmdstr, "SHOW") == 0) {cmd = SHOW;}
     1f2:	50                   	push   %eax
     1f3:	50                   	push   %eax
     1f4:	68 c6 18 00 00       	push   $0x18c6
     1f9:	53                   	push   %ebx
     1fa:	e8 51 0e 00 00       	call   1050 <strcmp>
     1ff:	83 c4 10             	add    $0x10,%esp
     202:	85 c0                	test   %eax,%eax
     204:	0f 84 f9 00 00 00    	je     303 <main+0x303>
    else if (strcmp(cmdstr, "QUIT") == 0) {cmd = QUIT;}
     20a:	57                   	push   %edi
     20b:	57                   	push   %edi
     20c:	68 cb 18 00 00       	push   $0x18cb
     211:	53                   	push   %ebx
     212:	e8 39 0e 00 00       	call   1050 <strcmp>
     217:	83 c4 10             	add    $0x10,%esp
     21a:	85 c0                	test   %eax,%eax
     21c:	0f 84 83 00 00 00    	je     2a5 <main+0x2a5>
  fprintf(2, "changes saved");
  return;
}

void bi() {
  fprintf(2, "bad bi input\n");
     222:	56                   	push   %esi
     223:	56                   	push   %esi
     224:	68 d0 18 00 00       	push   $0x18d0
     229:	6a 02                	push   $0x2
     22b:	e8 b0 13 00 00       	call   15e0 <fprintf>
     230:	83 c4 10             	add    $0x10,%esp
     233:	e9 a0 fe ff ff       	jmp    d8 <main+0xd8>
    fprintf(2, "only specify one file");
     238:	51                   	push   %ecx
     239:	51                   	push   %ecx
     23a:	68 67 18 00 00       	push   $0x1867
     23f:	6a 02                	push   $0x2
     241:	e8 9a 13 00 00       	call   15e0 <fprintf>
    exit();
     246:	e8 27 10 00 00       	call   1272 <exit>
    fprintf(2, "specify a file you want to edit");
     24b:	53                   	push   %ebx
     24c:	53                   	push   %ebx
     24d:	68 00 1a 00 00       	push   $0x1a00
     252:	6a 02                	push   $0x2
     254:	e8 87 13 00 00       	call   15e0 <fprintf>
    exit();
     259:	e8 14 10 00 00       	call   1272 <exit>
    fprintf(2, "creating %s . . .\n",  file.filename);
     25e:	51                   	push   %ecx
     25f:	ff b5 10 ff ff ff    	pushl  -0xf0(%ebp)
     265:	68 91 18 00 00       	push   $0x1891
     26a:	6a 02                	push   $0x2
     26c:	e8 6f 13 00 00       	call   15e0 <fprintf>
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     271:	5b                   	pop    %ebx
     272:	5e                   	pop    %esi
     273:	68 01 02 00 00       	push   $0x201
     278:	ff b5 10 ff ff ff    	pushl  -0xf0(%ebp)
     27e:	e8 2f 10 00 00       	call   12b2 <open>
    close(file.fd);
     283:	89 04 24             	mov    %eax,(%esp)
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     286:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
    close(file.fd);
     28c:	e8 09 10 00 00       	call   129a <close>
     291:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
     297:	83 c4 10             	add    $0x10,%esp
     29a:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
     2a0:	e9 18 fe ff ff       	jmp    bd <main+0xbd>
      quit(&file);
     2a5:	83 ec 0c             	sub    $0xc,%esp
     2a8:	ff b5 04 ff ff ff    	pushl  -0xfc(%ebp)
     2ae:	e8 3d 0c 00 00       	call   ef0 <quit>
  close(file.fd);
     2b3:	59                   	pop    %ecx
     2b4:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
     2ba:	e8 db 0f 00 00       	call   129a <close>
  exit();
     2bf:	e8 ae 0f 00 00       	call   1272 <exit>
      drop(&file, args);
     2c4:	8d 45 84             	lea    -0x7c(%ebp),%eax
     2c7:	52                   	push   %edx
     2c8:	52                   	push   %edx
     2c9:	50                   	push   %eax
     2ca:	ff b5 04 ff ff ff    	pushl  -0xfc(%ebp)
     2d0:	e8 2b 09 00 00       	call   c00 <drop>
     2d5:	83 c4 10             	add    $0x10,%esp
     2d8:	e9 fb fd ff ff       	jmp    d8 <main+0xd8>
      list(file, args);
     2dd:	8d 45 84             	lea    -0x7c(%ebp),%eax
     2e0:	83 ec 0c             	sub    $0xc,%esp
     2e3:	8b b5 04 ff ff ff    	mov    -0xfc(%ebp),%esi
     2e9:	b9 04 00 00 00       	mov    $0x4,%ecx
     2ee:	50                   	push   %eax
     2ef:	83 ec 10             	sub    $0x10,%esp
     2f2:	89 e7                	mov    %esp,%edi
     2f4:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
     2f6:	e8 95 0a 00 00       	call   d90 <list>
     2fb:	83 c4 20             	add    $0x20,%esp
     2fe:	e9 d5 fd ff ff       	jmp    d8 <main+0xd8>
     303:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
  int lineNum = 1;
     309:	bf 01 00 00 00       	mov    $0x1,%edi
  struct Node* cur = file.lines->head->next;
     30e:	8b 10                	mov    (%eax),%edx
     310:	8b 72 08             	mov    0x8(%edx),%esi
     313:	eb 20                	jmp    335 <main+0x335>
     315:	89 85 00 ff ff ff    	mov    %eax,-0x100(%ebp)
    printl(lineNum, cur->data);
     31b:	50                   	push   %eax
     31c:	50                   	push   %eax
     31d:	ff 76 04             	pushl  0x4(%esi)
     320:	57                   	push   %edi
    lineNum++;
     321:	83 c7 01             	add    $0x1,%edi
    printl(lineNum, cur->data);
     324:	e8 57 08 00 00       	call   b80 <printl>
    cur = cur->next;
     329:	8b 76 08             	mov    0x8(%esi),%esi
    lineNum++;
     32c:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
     332:	83 c4 10             	add    $0x10,%esp
  while (cur != file.lines->tail) {
     335:	3b 70 04             	cmp    0x4(%eax),%esi
     338:	75 db                	jne    315 <main+0x315>
     33a:	e9 99 fd ff ff       	jmp    d8 <main+0xd8>
     33f:	90                   	nop

00000340 <safestrcpy>:
#include "LinkedList.h"
#define nullptr 0

char* safestrcpy(char *s, const char *t, int n) {
     340:	55                   	push   %ebp
     341:	89 e5                	mov    %esp,%ebp
     343:	56                   	push   %esi
     344:	53                   	push   %ebx
     345:	8b 4d 10             	mov    0x10(%ebp),%ecx
     348:	8b 45 08             	mov    0x8(%ebp),%eax
     34b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
     34e:	85 c9                	test   %ecx,%ecx
     350:	7e 26                	jle    378 <safestrcpy+0x38>
     352:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
     356:	89 c1                	mov    %eax,%ecx
     358:	eb 17                	jmp    371 <safestrcpy+0x31>
     35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
     360:	83 c2 01             	add    $0x1,%edx
     363:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
     367:	83 c1 01             	add    $0x1,%ecx
     36a:	84 db                	test   %bl,%bl
     36c:	88 59 ff             	mov    %bl,-0x1(%ecx)
     36f:	74 04                	je     375 <safestrcpy+0x35>
     371:	39 f2                	cmp    %esi,%edx
     373:	75 eb                	jne    360 <safestrcpy+0x20>
    ;
  *s = 0;
     375:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
     378:	5b                   	pop    %ebx
     379:	5e                   	pop    %esi
     37a:	5d                   	pop    %ebp
     37b:	c3                   	ret    
     37c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000380 <nullNode>:

Node* nullNode(char* data) {
     380:	55                   	push   %ebp
     381:	89 e5                	mov    %esp,%ebp
     383:	83 ec 14             	sub    $0x14,%esp
  struct Node* node = malloc(sizeof(Node));
     386:	6a 0c                	push   $0xc
     388:	e8 23 13 00 00       	call   16b0 <malloc>
  node->prev = nullptr;
  node->data = data;
     38d:	8b 55 08             	mov    0x8(%ebp),%edx
  node->prev = nullptr;
     390:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->next = nullptr;
     396:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  node->data = data;
     39d:	89 50 04             	mov    %edx,0x4(%eax)
  return node;
}
     3a0:	c9                   	leave  
     3a1:	c3                   	ret    
     3a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003b0 <nodeAt>:

Node* nodeAt(struct LinkedList* list, int pos) {
     3b0:	55                   	push   %ebp
     3b1:	89 e5                	mov    %esp,%ebp
     3b3:	53                   	push   %ebx
     3b4:	8b 45 08             	mov    0x8(%ebp),%eax
     3b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  // for anything past the end:
  if (pos > list->len)
     3ba:	8b 48 08             	mov    0x8(%eax),%ecx
     3bd:	39 d1                	cmp    %edx,%ecx
     3bf:	7c 1f                	jl     3e0 <nodeAt+0x30>
    return list->tail->prev;
  // for anything before the beginning:
  if ((pos < 0) && ((0 - pos) > list->len))
     3c1:	85 d2                	test   %edx,%edx
     3c3:	78 2b                	js     3f0 <nodeAt+0x40>
    while (++pos != 0)
      curNode = curNode->prev;
  } // start looking from front
  else {
    int cur = 0;
    curNode = list->head->next;
     3c5:	8b 00                	mov    (%eax),%eax
     3c7:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     3ca:	74 0e                	je     3da <nodeAt+0x2a>
    int cur = 0;
     3cc:	31 c9                	xor    %ecx,%ecx
     3ce:	66 90                	xchg   %ax,%ax
      curNode = curNode->next;
      cur++;
     3d0:	83 c1 01             	add    $0x1,%ecx
      curNode = curNode->next;
     3d3:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     3d6:	39 ca                	cmp    %ecx,%edx
     3d8:	75 f6                	jne    3d0 <nodeAt+0x20>
    }
  }
  return curNode;
}
     3da:	5b                   	pop    %ebx
     3db:	5d                   	pop    %ebp
     3dc:	c3                   	ret    
     3dd:	8d 76 00             	lea    0x0(%esi),%esi
    return list->tail->prev;
     3e0:	8b 40 04             	mov    0x4(%eax),%eax
}
     3e3:	5b                   	pop    %ebx
     3e4:	5d                   	pop    %ebp
    return list->tail->prev;
     3e5:	8b 00                	mov    (%eax),%eax
}
     3e7:	c3                   	ret    
     3e8:	90                   	nop
     3e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if ((pos < 0) && ((0 - pos) > list->len))
     3f0:	89 d3                	mov    %edx,%ebx
     3f2:	f7 db                	neg    %ebx
     3f4:	39 d9                	cmp    %ebx,%ecx
     3f6:	7c 18                	jl     410 <nodeAt+0x60>
    while (++pos != 0)
     3f8:	83 c2 01             	add    $0x1,%edx
    curNode = list->tail;
     3fb:	8b 40 04             	mov    0x4(%eax),%eax
    while (++pos != 0)
     3fe:	74 da                	je     3da <nodeAt+0x2a>
     400:	83 c2 01             	add    $0x1,%edx
      curNode = curNode->prev;
     403:	8b 00                	mov    (%eax),%eax
    while (++pos != 0)
     405:	75 f9                	jne    400 <nodeAt+0x50>
}
     407:	5b                   	pop    %ebx
     408:	5d                   	pop    %ebp
     409:	c3                   	ret    
     40a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return list->head->next;
     410:	8b 00                	mov    (%eax),%eax
     412:	8b 40 08             	mov    0x8(%eax),%eax
     415:	eb c3                	jmp    3da <nodeAt+0x2a>
     417:	89 f6                	mov    %esi,%esi
     419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000420 <destroyNode>:

void destroyNode(struct Node* self) {
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	53                   	push   %ebx
     424:	83 ec 10             	sub    $0x10,%esp
     427:	8b 5d 08             	mov    0x8(%ebp),%ebx
    self->prev->next = self->next;
     42a:	8b 03                	mov    (%ebx),%eax
     42c:	8b 53 08             	mov    0x8(%ebx),%edx
     42f:	89 50 08             	mov    %edx,0x8(%eax)
    self->next->prev = self->prev;
     432:	8b 43 08             	mov    0x8(%ebx),%eax
     435:	8b 13                	mov    (%ebx),%edx
     437:	89 10                	mov    %edx,(%eax)

    free(self->data);
     439:	ff 73 04             	pushl  0x4(%ebx)
     43c:	e8 df 11 00 00       	call   1620 <free>
    free(self);
     441:	89 5d 08             	mov    %ebx,0x8(%ebp)
     444:	83 c4 10             	add    $0x10,%esp
}
     447:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     44a:	c9                   	leave  
    free(self);
     44b:	e9 d0 11 00 00       	jmp    1620 <free>

00000450 <MakeLinkedList>:

LinkedList* MakeLinkedList() {
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	56                   	push   %esi
     454:	53                   	push   %ebx
  struct LinkedList* list = malloc(sizeof(LinkedList));
     455:	83 ec 0c             	sub    $0xc,%esp
     458:	6a 0c                	push   $0xc
     45a:	e8 51 12 00 00       	call   16b0 <malloc>
  struct Node* node = malloc(sizeof(Node));
     45f:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  struct LinkedList* list = malloc(sizeof(LinkedList));
     466:	89 c6                	mov    %eax,%esi
  struct Node* node = malloc(sizeof(Node));
     468:	e8 43 12 00 00       	call   16b0 <malloc>
     46d:	89 c3                	mov    %eax,%ebx
  node->prev = nullptr;
     46f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->data = data;
     475:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  node->next = nullptr;
     47c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  struct Node* node = malloc(sizeof(Node));
     483:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     48a:	e8 21 12 00 00       	call   16b0 <malloc>
  node->data = data;
     48f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  Node* head = nullNode(nullptr);
  Node* tail = nullNode(nullptr);
  head->prev = nullptr;
  head->next = tail;
     496:	89 43 08             	mov    %eax,0x8(%ebx)
  head->prev = nullptr;
     499:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  tail->prev = head;
     49f:	89 18                	mov    %ebx,(%eax)
  tail->next = nullptr;
     4a1:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)

  list->len = 0;
  list->head = head;
  list->tail = tail;
     4a8:	89 46 04             	mov    %eax,0x4(%esi)
  return list;
}
     4ab:	89 f0                	mov    %esi,%eax
  list->len = 0;
     4ad:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
  list->head = head;
     4b4:	89 1e                	mov    %ebx,(%esi)
}
     4b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
     4b9:	5b                   	pop    %ebx
     4ba:	5e                   	pop    %esi
     4bb:	5d                   	pop    %ebp
     4bc:	c3                   	ret    
     4bd:	8d 76 00             	lea    0x0(%esi),%esi

000004c0 <insert>:

void insert(struct LinkedList* list, char* data, int pos) {
     4c0:	55                   	push   %ebp
     4c1:	89 e5                	mov    %esp,%ebp
     4c3:	57                   	push   %edi
     4c4:	56                   	push   %esi
     4c5:	53                   	push   %ebx
     4c6:	83 ec 0c             	sub    $0xc,%esp
  struct Node* atPos = nodeAt(list, pos);
     4c9:	ff 75 10             	pushl  0x10(%ebp)
     4cc:	ff 75 08             	pushl  0x8(%ebp)
void insert(struct LinkedList* list, char* data, int pos) {
     4cf:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct Node* atPos = nodeAt(list, pos);
     4d2:	e8 d9 fe ff ff       	call   3b0 <nodeAt>
     4d7:	83 ec 04             	sub    $0x4,%esp
     4da:	89 c6                	mov    %eax,%esi
  char* newData = (char*)malloc(sizeof(char) * 1000);
     4dc:	68 e8 03 00 00       	push   $0x3e8
     4e1:	e8 ca 11 00 00       	call   16b0 <malloc>
     4e6:	8d 8b e7 03 00 00    	lea    0x3e7(%ebx),%ecx
     4ec:	89 c7                	mov    %eax,%edi
     4ee:	83 c4 10             	add    $0x10,%esp
     4f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(--n > 0 && (*s++ = *t++) != 0)
     4f8:	83 c3 01             	add    $0x1,%ebx
     4fb:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     4ff:	83 c0 01             	add    $0x1,%eax
     502:	84 d2                	test   %dl,%dl
     504:	88 50 ff             	mov    %dl,-0x1(%eax)
     507:	74 04                	je     50d <insert+0x4d>
     509:	39 d9                	cmp    %ebx,%ecx
     50b:	75 eb                	jne    4f8 <insert+0x38>
  newData = safestrcpy(newData, data, (sizeof(char) * 1000));
  struct Node* new = malloc(sizeof(Node));
     50d:	83 ec 0c             	sub    $0xc,%esp
  *s = 0;
     510:	c6 00 00             	movb   $0x0,(%eax)
  struct Node* new = malloc(sizeof(Node));
     513:	6a 0c                	push   $0xc
     515:	e8 96 11 00 00       	call   16b0 <malloc>

  new->data = newData;
     51a:	89 78 04             	mov    %edi,0x4(%eax)
  new->prev = atPos->prev;
     51d:	8b 16                	mov    (%esi),%edx
  new->next = atPos;
     51f:	89 70 08             	mov    %esi,0x8(%eax)
  new->prev = atPos->prev;
     522:	89 10                	mov    %edx,(%eax)
  new->prev->next = new;
     524:	89 42 08             	mov    %eax,0x8(%edx)
  atPos->prev = new;
     527:	89 06                	mov    %eax,(%esi)
  list->len++;
     529:	8b 45 08             	mov    0x8(%ebp),%eax
     52c:	83 40 08 01          	addl   $0x1,0x8(%eax)
}
     530:	8d 65 f4             	lea    -0xc(%ebp),%esp
     533:	5b                   	pop    %ebx
     534:	5e                   	pop    %esi
     535:	5f                   	pop    %edi
     536:	5d                   	pop    %ebp
     537:	c3                   	ret    
     538:	90                   	nop
     539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000540 <prepend>:

void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
     540:	55                   	push   %ebp
     541:	89 e5                	mov    %esp,%ebp
     543:	83 ec 0c             	sub    $0xc,%esp
     546:	6a 00                	push   $0x0
     548:	ff 75 0c             	pushl  0xc(%ebp)
     54b:	ff 75 08             	pushl  0x8(%ebp)
     54e:	e8 6d ff ff ff       	call   4c0 <insert>
     553:	83 c4 10             	add    $0x10,%esp
     556:	c9                   	leave  
     557:	c3                   	ret    
     558:	90                   	nop
     559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000560 <append>:
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     560:	55                   	push   %ebp
     561:	89 e5                	mov    %esp,%ebp
     563:	83 ec 0c             	sub    $0xc,%esp
     566:	8b 45 08             	mov    0x8(%ebp),%eax
     569:	ff 70 08             	pushl  0x8(%eax)
     56c:	ff 75 0c             	pushl  0xc(%ebp)
     56f:	50                   	push   %eax
     570:	e8 4b ff ff ff       	call   4c0 <insert>
     575:	83 c4 10             	add    $0x10,%esp
     578:	c9                   	leave  
     579:	c3                   	ret    
     57a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000580 <destroyLinkedList>:

void destroyLinkedList(struct LinkedList* list) {
     580:	55                   	push   %ebp
     581:	89 e5                	mov    %esp,%ebp
     583:	56                   	push   %esi
     584:	53                   	push   %ebx
     585:	8b 75 08             	mov    0x8(%ebp),%esi
  struct Node* curNode = list->head;
     588:	8b 1e                	mov    (%esi),%ebx
  while (curNode != list->tail) {
     58a:	8b 46 04             	mov    0x4(%esi),%eax
     58d:	39 c3                	cmp    %eax,%ebx
     58f:	74 29                	je     5ba <destroyLinkedList+0x3a>
     591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
     598:	8b 5b 08             	mov    0x8(%ebx),%ebx
    free(curNode->prev->data);
     59b:	83 ec 0c             	sub    $0xc,%esp
     59e:	8b 03                	mov    (%ebx),%eax
     5a0:	ff 70 04             	pushl  0x4(%eax)
     5a3:	e8 78 10 00 00       	call   1620 <free>
    free(curNode->prev);
     5a8:	58                   	pop    %eax
     5a9:	ff 33                	pushl  (%ebx)
     5ab:	e8 70 10 00 00       	call   1620 <free>
  while (curNode != list->tail) {
     5b0:	8b 46 04             	mov    0x4(%esi),%eax
     5b3:	83 c4 10             	add    $0x10,%esp
     5b6:	39 d8                	cmp    %ebx,%eax
     5b8:	75 de                	jne    598 <destroyLinkedList+0x18>
  }
  free(curNode);
     5ba:	83 ec 0c             	sub    $0xc,%esp
     5bd:	50                   	push   %eax
     5be:	e8 5d 10 00 00       	call   1620 <free>
  free(list);
     5c3:	89 75 08             	mov    %esi,0x8(%ebp)
     5c6:	83 c4 10             	add    $0x10,%esp
     5c9:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5cc:	5b                   	pop    %ebx
     5cd:	5e                   	pop    %esi
     5ce:	5d                   	pop    %ebp
  free(list);
     5cf:	e9 4c 10 00 00       	jmp    1620 <free>
     5d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     5da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005e0 <getLine>:
int getLine(int fileptr, char line[]) {
     5e0:	55                   	push   %ebp
     5e1:	89 e5                	mov    %esp,%ebp
     5e3:	57                   	push   %edi
     5e4:	56                   	push   %esi
     5e5:	53                   	push   %ebx
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     5e6:	31 ff                	xor    %edi,%edi
     5e8:	8d 75 e7             	lea    -0x19(%ebp),%esi
int getLine(int fileptr, char line[]) {
     5eb:	83 ec 28             	sub    $0x28,%esp
     5ee:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int len = strlen(line);
     5f1:	53                   	push   %ebx
     5f2:	e8 a9 0a 00 00       	call   10a0 <strlen>
  memset(line, 0, len);
     5f7:	83 c4 0c             	add    $0xc,%esp
     5fa:	50                   	push   %eax
     5fb:	6a 00                	push   $0x0
     5fd:	53                   	push   %ebx
     5fe:	e8 cd 0a 00 00       	call   10d0 <memset>
     603:	83 c4 10             	add    $0x10,%esp
     606:	eb 1e                	jmp    626 <getLine+0x46>
     608:	90                   	nop
     609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (*c == '\n') break;
     610:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     614:	3c 0a                	cmp    $0xa,%al
     616:	74 38                	je     650 <getLine+0x70>
    line[i] = *c;
     618:	88 04 3b             	mov    %al,(%ebx,%edi,1)
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     61b:	83 c7 01             	add    $0x1,%edi
     61e:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
     624:	74 42                	je     668 <getLine+0x88>
    if (read(fileptr, c, 1) == 0) return strlen(line);
     626:	83 ec 04             	sub    $0x4,%esp
     629:	6a 01                	push   $0x1
     62b:	56                   	push   %esi
     62c:	ff 75 08             	pushl  0x8(%ebp)
     62f:	e8 56 0c 00 00       	call   128a <read>
     634:	83 c4 10             	add    $0x10,%esp
     637:	85 c0                	test   %eax,%eax
     639:	75 d5                	jne    610 <getLine+0x30>
     63b:	83 ec 0c             	sub    $0xc,%esp
     63e:	53                   	push   %ebx
     63f:	e8 5c 0a 00 00       	call   10a0 <strlen>
     644:	83 c4 10             	add    $0x10,%esp
}
     647:	8d 65 f4             	lea    -0xc(%ebp),%esp
     64a:	5b                   	pop    %ebx
     64b:	5e                   	pop    %esi
     64c:	5f                   	pop    %edi
     64d:	5d                   	pop    %ebp
     64e:	c3                   	ret    
     64f:	90                   	nop
     650:	8d 57 01             	lea    0x1(%edi),%edx
  line[i + 1] = '\0';
     653:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
     657:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
     65a:	b8 01 00 00 00       	mov    $0x1,%eax
}
     65f:	5b                   	pop    %ebx
     660:	5e                   	pop    %esi
     661:	5f                   	pop    %edi
     662:	5d                   	pop    %ebp
     663:	c3                   	ret    
     664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     668:	ba e8 03 00 00       	mov    $0x3e8,%edx
     66d:	eb e4                	jmp    653 <getLine+0x73>
     66f:	90                   	nop

00000670 <gatherLines>:
void gatherLines(File* file) {
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	56                   	push   %esi
     674:	53                   	push   %ebx
     675:	8d b5 10 fc ff ff    	lea    -0x3f0(%ebp),%esi
     67b:	81 ec f0 03 00 00    	sub    $0x3f0,%esp
     681:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while (getLine(file->fd, line)) {
     684:	eb 21                	jmp    6a7 <gatherLines+0x37>
     686:	8d 76 00             	lea    0x0(%esi),%esi
     689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    append(file->lines, line);
     690:	8b 43 08             	mov    0x8(%ebx),%eax
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     693:	83 ec 04             	sub    $0x4,%esp
     696:	ff 70 08             	pushl  0x8(%eax)
     699:	56                   	push   %esi
     69a:	50                   	push   %eax
     69b:	e8 20 fe ff ff       	call   4c0 <insert>
    file->len++;
     6a0:	83 43 0c 01          	addl   $0x1,0xc(%ebx)
     6a4:	83 c4 10             	add    $0x10,%esp
  while (getLine(file->fd, line)) {
     6a7:	83 ec 08             	sub    $0x8,%esp
     6aa:	56                   	push   %esi
     6ab:	ff 73 04             	pushl  0x4(%ebx)
     6ae:	e8 2d ff ff ff       	call   5e0 <getLine>
     6b3:	83 c4 10             	add    $0x10,%esp
     6b6:	85 c0                	test   %eax,%eax
     6b8:	75 d6                	jne    690 <gatherLines+0x20>
  fprintf(2, "%d lines read from %s\n", file->len, file->filename);
     6ba:	ff 33                	pushl  (%ebx)
     6bc:	ff 73 0c             	pushl  0xc(%ebx)
     6bf:	68 a8 17 00 00       	push   $0x17a8
     6c4:	6a 02                	push   $0x2
     6c6:	e8 15 0f 00 00       	call   15e0 <fprintf>
}
     6cb:	83 c4 10             	add    $0x10,%esp
     6ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
     6d1:	5b                   	pop    %ebx
     6d2:	5e                   	pop    %esi
     6d3:	5d                   	pop    %ebp
     6d4:	c3                   	ret    
     6d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     6d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006e0 <confirmation>:
int confirmation() {
     6e0:	55                   	push   %ebp
     6e1:	89 e5                	mov    %esp,%ebp
     6e3:	53                   	push   %ebx
  memset(buf, 0, nbuf);
     6e4:	8d 9d 10 fc ff ff    	lea    -0x3f0(%ebp),%ebx
int confirmation() {
     6ea:	81 ec f8 03 00 00    	sub    $0x3f8,%esp
  memset(buf, 0, nbuf);
     6f0:	68 e8 03 00 00       	push   $0x3e8
     6f5:	6a 00                	push   $0x0
     6f7:	53                   	push   %ebx
     6f8:	e8 d3 09 00 00       	call   10d0 <memset>
  gets(buf, nbuf);
     6fd:	58                   	pop    %eax
     6fe:	5a                   	pop    %edx
     6ff:	68 e8 03 00 00       	push   $0x3e8
     704:	53                   	push   %ebx
     705:	e8 26 0a 00 00       	call   1130 <gets>
  switch (buf[0]) {
     70a:	0f b6 85 10 fc ff ff 	movzbl -0x3f0(%ebp),%eax
     711:	83 c4 10             	add    $0x10,%esp
     714:	3c 59                	cmp    $0x59,%al
     716:	74 18                	je     730 <confirmation+0x50>
     718:	3c 79                	cmp    $0x79,%al
     71a:	74 14                	je     730 <confirmation+0x50>
    return 1;
     71c:	b8 01 00 00 00       	mov    $0x1,%eax
}
     721:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     724:	c9                   	leave  
     725:	c3                   	ret    
     726:	8d 76 00             	lea    0x0(%esi),%esi
     729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return 0;
     730:	31 c0                	xor    %eax,%eax
}
     732:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     735:	c9                   	leave  
     736:	c3                   	ret    
     737:	89 f6                	mov    %esi,%esi
     739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000740 <find>:
int find(char* str, char c) {
     740:	55                   	push   %ebp
     741:	89 e5                	mov    %esp,%ebp
     743:	57                   	push   %edi
     744:	56                   	push   %esi
     745:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     746:	31 db                	xor    %ebx,%ebx
int find(char* str, char c) {
     748:	83 ec 0c             	sub    $0xc,%esp
     74b:	8b 75 08             	mov    0x8(%ebp),%esi
     74e:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
  for (int i = 0; i < strlen(str); i++)
     752:	eb 0e                	jmp    762 <find+0x22>
     754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     758:	89 f8                	mov    %edi,%eax
     75a:	38 04 1e             	cmp    %al,(%esi,%ebx,1)
     75d:	74 18                	je     777 <find+0x37>
  for (int i = 0; i < strlen(str); i++)
     75f:	83 c3 01             	add    $0x1,%ebx
     762:	83 ec 0c             	sub    $0xc,%esp
     765:	56                   	push   %esi
     766:	e8 35 09 00 00       	call   10a0 <strlen>
     76b:	83 c4 10             	add    $0x10,%esp
     76e:	39 d8                	cmp    %ebx,%eax
     770:	77 e6                	ja     758 <find+0x18>
  return -1;
     772:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
     777:	8d 65 f4             	lea    -0xc(%ebp),%esp
     77a:	89 d8                	mov    %ebx,%eax
     77c:	5b                   	pop    %ebx
     77d:	5e                   	pop    %esi
     77e:	5f                   	pop    %edi
     77f:	5d                   	pop    %ebp
     780:	c3                   	ret    
     781:	eb 0d                	jmp    790 <substr>
     783:	90                   	nop
     784:	90                   	nop
     785:	90                   	nop
     786:	90                   	nop
     787:	90                   	nop
     788:	90                   	nop
     789:	90                   	nop
     78a:	90                   	nop
     78b:	90                   	nop
     78c:	90                   	nop
     78d:	90                   	nop
     78e:	90                   	nop
     78f:	90                   	nop

00000790 <substr>:
void substr(char* dest, char* str, int start, int end) {
     790:	55                   	push   %ebp
     791:	89 e5                	mov    %esp,%ebp
     793:	57                   	push   %edi
     794:	56                   	push   %esi
     795:	53                   	push   %ebx
     796:	83 ec 18             	sub    $0x18,%esp
     799:	8b 7d 14             	mov    0x14(%ebp),%edi
  int len = strlen(str);
     79c:	ff 75 0c             	pushl  0xc(%ebp)
void substr(char* dest, char* str, int start, int end) {
     79f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     7a2:	8b 75 08             	mov    0x8(%ebp),%esi
  int len = strlen(str);
     7a5:	e8 f6 08 00 00       	call   10a0 <strlen>
     7aa:	83 c4 10             	add    $0x10,%esp
     7ad:	39 f8                	cmp    %edi,%eax
     7af:	0f 4e f8             	cmovle %eax,%edi
  while (i < end)
     7b2:	39 df                	cmp    %ebx,%edi
     7b4:	7e 1c                	jle    7d2 <substr+0x42>
     7b6:	8b 45 0c             	mov    0xc(%ebp),%eax
     7b9:	29 df                	sub    %ebx,%edi
  int s = 0, i = start;
     7bb:	31 d2                	xor    %edx,%edx
     7bd:	01 c3                	add    %eax,%ebx
     7bf:	90                   	nop
    dest[s++] = str[i++];
     7c0:	83 c2 01             	add    $0x1,%edx
     7c3:	0f b6 44 13 ff       	movzbl -0x1(%ebx,%edx,1),%eax
  while (i < end)
     7c8:	39 fa                	cmp    %edi,%edx
    dest[s++] = str[i++];
     7ca:	88 44 16 ff          	mov    %al,-0x1(%esi,%edx,1)
  while (i < end)
     7ce:	75 f0                	jne    7c0 <substr+0x30>
     7d0:	01 d6                	add    %edx,%esi
  dest[s] = '\0';
     7d2:	c6 06 00             	movb   $0x0,(%esi)
}
     7d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7d8:	5b                   	pop    %ebx
     7d9:	5e                   	pop    %esi
     7da:	5f                   	pop    %edi
     7db:	5d                   	pop    %ebp
     7dc:	c3                   	ret    
     7dd:	8d 76 00             	lea    0x0(%esi),%esi

000007e0 <getArg>:
void getArg(char* dest, char* args, char delimiter) {
     7e0:	55                   	push   %ebp
     7e1:	89 e5                	mov    %esp,%ebp
     7e3:	57                   	push   %edi
     7e4:	56                   	push   %esi
     7e5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     7e6:	31 db                	xor    %ebx,%ebx
void getArg(char* dest, char* args, char delimiter) {
     7e8:	83 ec 1c             	sub    $0x1c,%esp
     7eb:	8b 75 0c             	mov    0xc(%ebp),%esi
     7ee:	0f b6 7d 10          	movzbl 0x10(%ebp),%edi
     7f2:	eb 10                	jmp    804 <getArg+0x24>
     7f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     7f8:	89 f8                	mov    %edi,%eax
     7fa:	3a 04 1e             	cmp    (%esi,%ebx,1),%al
     7fd:	8d 53 01             	lea    0x1(%ebx),%edx
     800:	74 19                	je     81b <getArg+0x3b>
     802:	89 d3                	mov    %edx,%ebx
  for (int i = 0; i < strlen(str); i++)
     804:	83 ec 0c             	sub    $0xc,%esp
     807:	56                   	push   %esi
     808:	e8 93 08 00 00       	call   10a0 <strlen>
     80d:	83 c4 10             	add    $0x10,%esp
     810:	39 c3                	cmp    %eax,%ebx
     812:	72 e4                	jb     7f8 <getArg+0x18>
     814:	31 d2                	xor    %edx,%edx
  return -1;
     816:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  substr(dest, args, 0, end);
     81b:	53                   	push   %ebx
     81c:	6a 00                	push   $0x0
     81e:	56                   	push   %esi
     81f:	ff 75 08             	pushl  0x8(%ebp)
     822:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     825:	e8 66 ff ff ff       	call   790 <substr>
  substr(args, args, end + 1, (int) strlen(args));
     82a:	89 34 24             	mov    %esi,(%esp)
     82d:	e8 6e 08 00 00       	call   10a0 <strlen>
     832:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     835:	50                   	push   %eax
     836:	52                   	push   %edx
     837:	56                   	push   %esi
     838:	56                   	push   %esi
     839:	e8 52 ff ff ff       	call   790 <substr>
}
     83e:	83 c4 20             	add    $0x20,%esp
     841:	8d 65 f4             	lea    -0xc(%ebp),%esp
     844:	5b                   	pop    %ebx
     845:	5e                   	pop    %esi
     846:	5f                   	pop    %edi
     847:	5d                   	pop    %ebp
     848:	c3                   	ret    
     849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000850 <collectRange>:
int collectRange(char* args, int* startptr, int* endptr) {
     850:	55                   	push   %ebp
     851:	89 e5                	mov    %esp,%ebp
     853:	57                   	push   %edi
     854:	56                   	push   %esi
     855:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     856:	31 f6                	xor    %esi,%esi
int collectRange(char* args, int* startptr, int* endptr) {
     858:	83 ec 2c             	sub    $0x2c,%esp
     85b:	8b 5d 08             	mov    0x8(%ebp),%ebx
     85e:	eb 09                	jmp    869 <collectRange+0x19>
    if (str[i] == c) return i;
     860:	80 3c 33 3a          	cmpb   $0x3a,(%ebx,%esi,1)
     864:	74 42                	je     8a8 <collectRange+0x58>
  for (int i = 0; i < strlen(str); i++)
     866:	83 c6 01             	add    $0x1,%esi
     869:	83 ec 0c             	sub    $0xc,%esp
     86c:	53                   	push   %ebx
     86d:	e8 2e 08 00 00       	call   10a0 <strlen>
     872:	83 c4 10             	add    $0x10,%esp
     875:	39 c6                	cmp    %eax,%esi
     877:	72 e7                	jb     860 <collectRange+0x10>
    if (args[0] == '-') {
     879:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     87c:	0f 84 d6 00 00 00    	je     958 <collectRange+0x108>
      *startptr = atoi(args);
     882:	83 ec 0c             	sub    $0xc,%esp
     885:	53                   	push   %ebx
     886:	e8 75 09 00 00       	call   1200 <atoi>
     88b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     88e:	83 c4 10             	add    $0x10,%esp
     891:	89 01                	mov    %eax,(%ecx)
    *endptr = *startptr;
     893:	8b 4d 10             	mov    0x10(%ebp),%ecx
     896:	89 01                	mov    %eax,(%ecx)
    return 0;
     898:	31 c0                	xor    %eax,%eax
}
     89a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     89d:	5b                   	pop    %ebx
     89e:	5e                   	pop    %esi
     89f:	5f                   	pop    %edi
     8a0:	5d                   	pop    %ebp
     8a1:	c3                   	ret    
     8a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  getArg(startstr, args, ':');
     8a8:	8d 75 de             	lea    -0x22(%ebp),%esi
     8ab:	83 ec 04             	sub    $0x4,%esp
     8ae:	6a 3a                	push   $0x3a
     8b0:	53                   	push   %ebx
     8b1:	56                   	push   %esi
     8b2:	e8 29 ff ff ff       	call   7e0 <getArg>
  if (startstr[0] == '-') {
     8b7:	83 c4 10             	add    $0x10,%esp
     8ba:	80 7d de 2d          	cmpb   $0x2d,-0x22(%ebp)
     8be:	0f 84 3c 01 00 00    	je     a00 <collectRange+0x1b0>
  int negStartFlag = 0, negEndFlag = 0;
     8c4:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     8cb:	31 ff                	xor    %edi,%edi
  if (endstr[0] == '-') {
     8cd:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     8d0:	0f 84 0a 01 00 00    	je     9e0 <collectRange+0x190>
  if (strcmp(startstr, "\0") == 0) *startptr = 1;
     8d6:	83 ec 08             	sub    $0x8,%esp
     8d9:	68 de 18 00 00       	push   $0x18de
     8de:	56                   	push   %esi
     8df:	e8 6c 07 00 00       	call   1050 <strcmp>
     8e4:	83 c4 10             	add    $0x10,%esp
     8e7:	85 c0                	test   %eax,%eax
     8e9:	0f 85 d1 00 00 00    	jne    9c0 <collectRange+0x170>
     8ef:	8b 45 0c             	mov    0xc(%ebp),%eax
     8f2:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  if (strcmp(endstr, "\0") == 0) *endptr = -1;
     8f8:	83 ec 08             	sub    $0x8,%esp
     8fb:	68 de 18 00 00       	push   $0x18de
     900:	53                   	push   %ebx
     901:	e8 4a 07 00 00       	call   1050 <strcmp>
     906:	83 c4 10             	add    $0x10,%esp
     909:	85 c0                	test   %eax,%eax
     90b:	0f 85 97 00 00 00    	jne    9a8 <collectRange+0x158>
     911:	8b 45 10             	mov    0x10(%ebp),%eax
     914:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  if (negStartFlag) *startptr = 0 - *startptr;
     91a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     91d:	85 c0                	test   %eax,%eax
     91f:	74 05                	je     926 <collectRange+0xd6>
     921:	8b 45 0c             	mov    0xc(%ebp),%eax
     924:	f7 18                	negl   (%eax)
  if (negEndFlag) *endptr = 0 - *endptr;
     926:	85 ff                	test   %edi,%edi
     928:	74 05                	je     92f <collectRange+0xdf>
     92a:	8b 45 10             	mov    0x10(%ebp),%eax
     92d:	f7 18                	negl   (%eax)
  if (((*startptr > 0 && *endptr > 0) || 
     92f:	8b 45 0c             	mov    0xc(%ebp),%eax
     932:	8b 00                	mov    (%eax),%eax
     934:	83 f8 00             	cmp    $0x0,%eax
     937:	7e 4f                	jle    988 <collectRange+0x138>
     939:	8b 55 10             	mov    0x10(%ebp),%edx
     93c:	8b 12                	mov    (%edx),%edx
     93e:	85 d2                	test   %edx,%edx
     940:	7e 55                	jle    997 <collectRange+0x147>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     942:	39 d0                	cmp    %edx,%eax
     944:	0f 9f c0             	setg   %al
}
     947:	8d 65 f4             	lea    -0xc(%ebp),%esp
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     94a:	0f b6 c0             	movzbl %al,%eax
}
     94d:	5b                   	pop    %ebx
     94e:	5e                   	pop    %esi
     94f:	5f                   	pop    %edi
     950:	5d                   	pop    %ebp
     951:	c3                   	ret    
     952:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      substr(args, args, 1, strlen(args));
     958:	83 ec 0c             	sub    $0xc,%esp
     95b:	53                   	push   %ebx
     95c:	e8 3f 07 00 00       	call   10a0 <strlen>
     961:	50                   	push   %eax
     962:	6a 01                	push   $0x1
     964:	53                   	push   %ebx
     965:	53                   	push   %ebx
     966:	e8 25 fe ff ff       	call   790 <substr>
      *startptr = 0 - atoi(args);
     96b:	83 c4 14             	add    $0x14,%esp
     96e:	53                   	push   %ebx
     96f:	e8 8c 08 00 00       	call   1200 <atoi>
     974:	8b 7d 0c             	mov    0xc(%ebp),%edi
     977:	f7 d8                	neg    %eax
     979:	83 c4 10             	add    $0x10,%esp
     97c:	89 07                	mov    %eax,(%edi)
     97e:	e9 10 ff ff ff       	jmp    893 <collectRange+0x43>
     983:	90                   	nop
     984:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (((*startptr > 0 && *endptr > 0) || 
     988:	0f 84 0c ff ff ff    	je     89a <collectRange+0x4a>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     98e:	8b 7d 10             	mov    0x10(%ebp),%edi
     991:	8b 17                	mov    (%edi),%edx
     993:	85 d2                	test   %edx,%edx
     995:	78 ab                	js     942 <collectRange+0xf2>
}
     997:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
     99a:	31 c0                	xor    %eax,%eax
}
     99c:	5b                   	pop    %ebx
     99d:	5e                   	pop    %esi
     99e:	5f                   	pop    %edi
     99f:	5d                   	pop    %ebp
     9a0:	c3                   	ret    
     9a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else *endptr = atoi(endstr);
     9a8:	83 ec 0c             	sub    $0xc,%esp
     9ab:	53                   	push   %ebx
     9ac:	e8 4f 08 00 00       	call   1200 <atoi>
     9b1:	8b 55 10             	mov    0x10(%ebp),%edx
     9b4:	83 c4 10             	add    $0x10,%esp
     9b7:	89 02                	mov    %eax,(%edx)
     9b9:	e9 5c ff ff ff       	jmp    91a <collectRange+0xca>
     9be:	66 90                	xchg   %ax,%ax
  else *startptr = atoi(startstr);
     9c0:	83 ec 0c             	sub    $0xc,%esp
     9c3:	56                   	push   %esi
     9c4:	e8 37 08 00 00       	call   1200 <atoi>
     9c9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     9cc:	83 c4 10             	add    $0x10,%esp
     9cf:	89 01                	mov    %eax,(%ecx)
     9d1:	e9 22 ff ff ff       	jmp    8f8 <collectRange+0xa8>
     9d6:	8d 76 00             	lea    0x0(%esi),%esi
     9d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    substr(endstr, endstr, 1, strlen(endstr));
     9e0:	83 ec 0c             	sub    $0xc,%esp
    negEndFlag = 1;
     9e3:	bf 01 00 00 00       	mov    $0x1,%edi
    substr(endstr, endstr, 1, strlen(endstr));
     9e8:	53                   	push   %ebx
     9e9:	e8 b2 06 00 00       	call   10a0 <strlen>
     9ee:	50                   	push   %eax
     9ef:	6a 01                	push   $0x1
     9f1:	53                   	push   %ebx
     9f2:	53                   	push   %ebx
     9f3:	e8 98 fd ff ff       	call   790 <substr>
     9f8:	83 c4 20             	add    $0x20,%esp
     9fb:	e9 d6 fe ff ff       	jmp    8d6 <collectRange+0x86>
    substr(startstr, startstr, 1, strlen(startstr));
     a00:	83 ec 0c             	sub    $0xc,%esp
     a03:	56                   	push   %esi
     a04:	e8 97 06 00 00       	call   10a0 <strlen>
     a09:	50                   	push   %eax
     a0a:	6a 01                	push   $0x1
     a0c:	56                   	push   %esi
     a0d:	56                   	push   %esi
     a0e:	e8 7d fd ff ff       	call   790 <substr>
     a13:	83 c4 20             	add    $0x20,%esp
    negStartFlag = 1;
     a16:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
     a1d:	e9 a9 fe ff ff       	jmp    8cb <collectRange+0x7b>
     a22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a30 <normalizeRange>:
int normalizeRange(File file, int* sp, int* ep) {
     a30:	55                   	push   %ebp
     a31:	89 e5                	mov    %esp,%ebp
     a33:	53                   	push   %ebx
     a34:	8b 4d 1c             	mov    0x1c(%ebp),%ecx
  int l = file.len;
     a37:	8b 45 14             	mov    0x14(%ebp),%eax
int normalizeRange(File file, int* sp, int* ep) {
     a3a:	8b 5d 18             	mov    0x18(%ebp),%ebx
  if (*ep > l) *ep = l;
     a3d:	8b 11                	mov    (%ecx),%edx
     a3f:	39 c2                	cmp    %eax,%edx
     a41:	7e 45                	jle    a88 <normalizeRange+0x58>
     a43:	89 01                	mov    %eax,(%ecx)
     a45:	89 c2                	mov    %eax,%edx
  if (*ep < 1) *ep = 1;
     a47:	85 d2                	test   %edx,%edx
     a49:	7f 06                	jg     a51 <normalizeRange+0x21>
     a4b:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)
  if (*sp > l) *sp = l;
     a51:	8b 13                	mov    (%ebx),%edx
     a53:	39 c2                	cmp    %eax,%edx
     a55:	7e 21                	jle    a78 <normalizeRange+0x48>
     a57:	89 03                	mov    %eax,(%ebx)
     a59:	89 c2                	mov    %eax,%edx
  if (*sp < 1) *sp = 1;
     a5b:	85 d2                	test   %edx,%edx
     a5d:	7f 0b                	jg     a6a <normalizeRange+0x3a>
     a5f:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
     a65:	ba 01 00 00 00       	mov    $0x1,%edx
  if ((*ep - *sp) < 0)
     a6a:	8b 01                	mov    (%ecx),%eax
}
     a6c:	5b                   	pop    %ebx
     a6d:	5d                   	pop    %ebp
  if ((*ep - *sp) < 0)
     a6e:	29 d0                	sub    %edx,%eax
     a70:	c1 e8 1f             	shr    $0x1f,%eax
}
     a73:	c3                   	ret    
     a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*sp < 1) *sp += l + 1;
     a78:	85 d2                	test   %edx,%edx
     a7a:	7f ee                	jg     a6a <normalizeRange+0x3a>
     a7c:	8d 54 10 01          	lea    0x1(%eax,%edx,1),%edx
     a80:	89 13                	mov    %edx,(%ebx)
     a82:	eb d7                	jmp    a5b <normalizeRange+0x2b>
     a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*ep < 1) *ep += l + 1;
     a88:	85 d2                	test   %edx,%edx
     a8a:	7f c5                	jg     a51 <normalizeRange+0x21>
     a8c:	8d 54 02 01          	lea    0x1(%edx,%eax,1),%edx
     a90:	89 11                	mov    %edx,(%ecx)
     a92:	eb b3                	jmp    a47 <normalizeRange+0x17>
     a94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     a9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000aa0 <numLines>:
int numLines(int start, int end) {
     aa0:	55                   	push   %ebp
     aa1:	89 e5                	mov    %esp,%ebp
  return (end - start) + 1;
     aa3:	8b 45 0c             	mov    0xc(%ebp),%eax
     aa6:	2b 45 08             	sub    0x8(%ebp),%eax
}
     aa9:	5d                   	pop    %ebp
  return (end - start) + 1;
     aaa:	83 c0 01             	add    $0x1,%eax
}
     aad:	c3                   	ret    
     aae:	66 90                	xchg   %ax,%ax

00000ab0 <toUpper>:
void toUpper(char* str) {
     ab0:	55                   	push   %ebp
     ab1:	89 e5                	mov    %esp,%ebp
     ab3:	8b 55 08             	mov    0x8(%ebp),%edx
  while (str[i] != '\0') {
     ab6:	0f b6 02             	movzbl (%edx),%eax
     ab9:	84 c0                	test   %al,%al
     abb:	74 1a                	je     ad7 <toUpper+0x27>
     abd:	8d 76 00             	lea    0x0(%esi),%esi
    if (c <= 'z' && c >= 'a')
     ac0:	8d 48 9f             	lea    -0x61(%eax),%ecx
     ac3:	80 f9 19             	cmp    $0x19,%cl
     ac6:	77 05                	ja     acd <toUpper+0x1d>
      str[i] += ('Z' - 'z');
     ac8:	83 e8 20             	sub    $0x20,%eax
     acb:	88 02                	mov    %al,(%edx)
     acd:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     ad0:	0f b6 02             	movzbl (%edx),%eax
     ad3:	84 c0                	test   %al,%al
     ad5:	75 e9                	jne    ac0 <toUpper+0x10>
    i++;  
  }
}
     ad7:	5d                   	pop    %ebp
     ad8:	c3                   	ret    
     ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ae0 <toLower>:

void toLower(char* str) {
     ae0:	55                   	push   %ebp
     ae1:	89 e5                	mov    %esp,%ebp
     ae3:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     ae6:	0f b6 02             	movzbl (%edx),%eax
     ae9:	84 c0                	test   %al,%al
     aeb:	74 1a                	je     b07 <toLower+0x27>
     aed:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'Z' && c >= 'A')
     af0:	8d 48 bf             	lea    -0x41(%eax),%ecx
     af3:	80 f9 19             	cmp    $0x19,%cl
     af6:	77 05                	ja     afd <toLower+0x1d>
      str[i] -= ('Z' - 'z');
     af8:	83 c0 20             	add    $0x20,%eax
     afb:	88 02                	mov    %al,(%edx)
     afd:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     b00:	0f b6 02             	movzbl (%edx),%eax
     b03:	84 c0                	test   %al,%al
     b05:	75 e9                	jne    af0 <toLower+0x10>
    i++;  
  }
}
     b07:	5d                   	pop    %ebp
     b08:	c3                   	ret    
     b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000b10 <unline>:

void unline(char* str) {
     b10:	55                   	push   %ebp
     b11:	89 e5                	mov    %esp,%ebp
     b13:	53                   	push   %ebx
     b14:	83 ec 10             	sub    $0x10,%esp
     b17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str) - 1;
     b1a:	53                   	push   %ebx
     b1b:	e8 80 05 00 00       	call   10a0 <strlen>
     b20:	8d 50 ff             	lea    -0x1(%eax),%edx
  for (; len > 0; len--) {
     b23:	83 c4 10             	add    $0x10,%esp
     b26:	85 d2                	test   %edx,%edx
     b28:	7e 36                	jle    b60 <unline+0x50>
    char c = str[len];
    if (c == '\n')
     b2a:	80 7c 03 ff 0a       	cmpb   $0xa,-0x1(%ebx,%eax,1)
     b2f:	74 2f                	je     b60 <unline+0x50>
     b31:	8d 44 03 fe          	lea    -0x2(%ebx,%eax,1),%eax
     b35:	eb 12                	jmp    b49 <unline+0x39>
     b37:	89 f6                	mov    %esi,%esi
     b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     b40:	83 e8 01             	sub    $0x1,%eax
     b43:	80 78 01 0a          	cmpb   $0xa,0x1(%eax)
     b47:	74 06                	je     b4f <unline+0x3f>
  for (; len > 0; len--) {
     b49:	39 c3                	cmp    %eax,%ebx
     b4b:	89 c2                	mov    %eax,%edx
     b4d:	75 f1                	jne    b40 <unline+0x30>
      break;
  }
  str[len] = '\0';
     b4f:	c6 02 00             	movb   $0x0,(%edx)
}
     b52:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b55:	c9                   	leave  
     b56:	c3                   	ret    
     b57:	89 f6                	mov    %esi,%esi
     b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     b60:	01 da                	add    %ebx,%edx
  str[len] = '\0';
     b62:	c6 02 00             	movb   $0x0,(%edx)
}
     b65:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b68:	c9                   	leave  
     b69:	c3                   	ret    
     b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000b70 <lineAt>:

// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
     b70:	55                   	push   %ebp
     b71:	89 e5                	mov    %esp,%ebp
  return nodeAt(list, pos-1);
     b73:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
}
     b77:	5d                   	pop    %ebp
  return nodeAt(list, pos-1);
     b78:	e9 33 f8 ff ff       	jmp    3b0 <nodeAt>
     b7d:	8d 76 00             	lea    0x0(%esi),%esi

00000b80 <printl>:

void printl(int lineNum, char* line) {
     b80:	55                   	push   %ebp
     b81:	89 e5                	mov    %esp,%ebp
     b83:	83 ec 08             	sub    $0x8,%esp
     b86:	8b 45 08             	mov    0x8(%ebp),%eax
  if (lineNum < 10)
     b89:	83 f8 09             	cmp    $0x9,%eax
     b8c:	7e 3a                	jle    bc8 <printl+0x48>
    fprintf(2, "%d  | %s\n", lineNum, line);
  else if (lineNum < 100)
     b8e:	83 f8 63             	cmp    $0x63,%eax
     b91:	7e 1d                	jle    bb0 <printl+0x30>
    fprintf(2, "%d | %s\n", lineNum, line);
  else
    fprintf(2, "%d| %s\n", lineNum, line);
     b93:	ff 75 0c             	pushl  0xc(%ebp)
     b96:	50                   	push   %eax
     b97:	68 d2 17 00 00       	push   $0x17d2
     b9c:	6a 02                	push   $0x2
     b9e:	e8 3d 0a 00 00       	call   15e0 <fprintf>
     ba3:	83 c4 10             	add    $0x10,%esp
     ba6:	c9                   	leave  
     ba7:	c3                   	ret    
     ba8:	90                   	nop
     ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "%d | %s\n", lineNum, line);
     bb0:	ff 75 0c             	pushl  0xc(%ebp)
     bb3:	50                   	push   %eax
     bb4:	68 c9 17 00 00       	push   $0x17c9
     bb9:	6a 02                	push   $0x2
     bbb:	e8 20 0a 00 00       	call   15e0 <fprintf>
     bc0:	83 c4 10             	add    $0x10,%esp
     bc3:	c9                   	leave  
     bc4:	c3                   	ret    
     bc5:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "%d  | %s\n", lineNum, line);
     bc8:	ff 75 0c             	pushl  0xc(%ebp)
     bcb:	50                   	push   %eax
     bcc:	68 bf 17 00 00       	push   $0x17bf
     bd1:	6a 02                	push   $0x2
     bd3:	e8 08 0a 00 00       	call   15e0 <fprintf>
     bd8:	83 c4 10             	add    $0x10,%esp
     bdb:	c9                   	leave  
     bdc:	c3                   	ret    
     bdd:	8d 76 00             	lea    0x0(%esi),%esi

00000be0 <end>:
void end(struct File* file, char* args) {
     be0:	55                   	push   %ebp
     be1:	89 e5                	mov    %esp,%ebp
}
     be3:	5d                   	pop    %ebp
     be4:	c3                   	ret    
     be5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bf0 <add>:
     bf0:	55                   	push   %ebp
     bf1:	89 e5                	mov    %esp,%ebp
     bf3:	5d                   	pop    %ebp
     bf4:	c3                   	ret    
     bf5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c00 <drop>:
void drop(struct File* file, char* args) {
     c00:	55                   	push   %ebp
     c01:	89 e5                	mov    %esp,%ebp
     c03:	57                   	push   %edi
     c04:	56                   	push   %esi
     c05:	53                   	push   %ebx
     c06:	83 ec 28             	sub    $0x28,%esp
  if (strlen(args) < 1) {
     c09:	ff 75 0c             	pushl  0xc(%ebp)
void drop(struct File* file, char* args) {
     c0c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (strlen(args) < 1) {
     c0f:	e8 8c 04 00 00       	call   10a0 <strlen>
     c14:	83 c4 10             	add    $0x10,%esp
     c17:	85 c0                	test   %eax,%eax
     c19:	0f 84 81 00 00 00    	je     ca0 <drop+0xa0>
  if (collectRange(args, &start, &end) == 1) {
     c1f:	8d 75 e4             	lea    -0x1c(%ebp),%esi
     c22:	8d 7d e0             	lea    -0x20(%ebp),%edi
     c25:	83 ec 04             	sub    $0x4,%esp
     c28:	56                   	push   %esi
     c29:	57                   	push   %edi
     c2a:	ff 75 0c             	pushl  0xc(%ebp)
     c2d:	e8 1e fc ff ff       	call   850 <collectRange>
     c32:	83 c4 10             	add    $0x10,%esp
     c35:	83 f8 01             	cmp    $0x1,%eax
     c38:	0f 84 82 00 00 00    	je     cc0 <drop+0xc0>
  if (normalizeRange(*file, &start, &end) == 1) {
     c3e:	83 ec 08             	sub    $0x8,%esp
     c41:	56                   	push   %esi
     c42:	57                   	push   %edi
     c43:	ff 73 0c             	pushl  0xc(%ebx)
     c46:	ff 73 08             	pushl  0x8(%ebx)
     c49:	ff 73 04             	pushl  0x4(%ebx)
     c4c:	ff 33                	pushl  (%ebx)
     c4e:	e8 dd fd ff ff       	call   a30 <normalizeRange>
     c53:	83 c4 20             	add    $0x20,%esp
     c56:	83 f8 01             	cmp    $0x1,%eax
     c59:	0f 84 01 01 00 00    	je     d60 <drop+0x160>
  int numl = numLines(start, end);
     c5f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     c62:	8b 55 e0             	mov    -0x20(%ebp),%edx
  return (end - start) + 1;
     c65:	89 c8                	mov    %ecx,%eax
     c67:	29 d0                	sub    %edx,%eax
     c69:	83 c0 01             	add    $0x1,%eax
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
     c6c:	83 f8 01             	cmp    $0x1,%eax
     c6f:	0f 84 cb 00 00 00    	je     d40 <drop+0x140>
  else fprintf(2, "Drop %d lines [%d:%d] (y/n)? ", numl, start, end);
     c75:	83 ec 0c             	sub    $0xc,%esp
     c78:	51                   	push   %ecx
     c79:	52                   	push   %edx
     c7a:	50                   	push   %eax
     c7b:	68 07 18 00 00       	push   $0x1807
     c80:	6a 02                	push   $0x2
     c82:	e8 59 09 00 00       	call   15e0 <fprintf>
     c87:	83 c4 20             	add    $0x20,%esp
  if (confirmation() != 0) return;
     c8a:	e8 51 fa ff ff       	call   6e0 <confirmation>
     c8f:	85 c0                	test   %eax,%eax
     c91:	74 4d                	je     ce0 <drop+0xe0>
}
     c93:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c96:	5b                   	pop    %ebx
     c97:	5e                   	pop    %esi
     c98:	5f                   	pop    %edi
     c99:	5d                   	pop    %ebp
     c9a:	c3                   	ret    
     c9b:	90                   	nop
     c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "you need to give a range to drop\n");
     ca0:	83 ec 08             	sub    $0x8,%esp
     ca3:	68 e0 18 00 00       	push   $0x18e0
     ca8:	6a 02                	push   $0x2
     caa:	e8 31 09 00 00       	call   15e0 <fprintf>
    return;
     caf:	83 c4 10             	add    $0x10,%esp
}
     cb2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cb5:	5b                   	pop    %ebx
     cb6:	5e                   	pop    %esi
     cb7:	5f                   	pop    %edi
     cb8:	5d                   	pop    %ebp
     cb9:	c3                   	ret    
     cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: start index is larger than end index\n");
     cc0:	83 ec 08             	sub    $0x8,%esp
     cc3:	68 04 19 00 00       	push   $0x1904
     cc8:	6a 02                	push   $0x2
     cca:	e8 11 09 00 00       	call   15e0 <fprintf>
     ccf:	83 c4 10             	add    $0x10,%esp
}
     cd2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cd5:	5b                   	pop    %ebx
     cd6:	5e                   	pop    %esi
     cd7:	5f                   	pop    %edi
     cd8:	5d                   	pop    %ebp
     cd9:	c3                   	ret    
     cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  fprintf(2, "dropping...\n");
     ce0:	83 ec 08             	sub    $0x8,%esp
     ce3:	68 25 18 00 00       	push   $0x1825
     ce8:	6a 02                	push   $0x2
     cea:	e8 f1 08 00 00       	call   15e0 <fprintf>
  return nodeAt(list, pos-1);
     cef:	58                   	pop    %eax
     cf0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  struct Node* curNode = (lineAt(file->lines, start))->prev;
     cf3:	8b 7b 08             	mov    0x8(%ebx),%edi
     cf6:	5a                   	pop    %edx
     cf7:	83 e8 01             	sub    $0x1,%eax
     cfa:	50                   	push   %eax
     cfb:	57                   	push   %edi
     cfc:	e8 af f6 ff ff       	call   3b0 <nodeAt>
     d01:	59                   	pop    %ecx
     d02:	5e                   	pop    %esi
     d03:	8b 30                	mov    (%eax),%esi
     d05:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d08:	83 e8 01             	sub    $0x1,%eax
     d0b:	50                   	push   %eax
     d0c:	57                   	push   %edi
     d0d:	e8 9e f6 ff ff       	call   3b0 <nodeAt>
     d12:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
     d15:	39 c6                	cmp    %eax,%esi
     d17:	89 c7                	mov    %eax,%edi
     d19:	0f 84 74 ff ff ff    	je     c93 <drop+0x93>
     d1f:	90                   	nop
    curNode = curNode->next;
     d20:	8b 76 08             	mov    0x8(%esi),%esi
    destroyNode(curNode);
     d23:	83 ec 0c             	sub    $0xc,%esp
     d26:	56                   	push   %esi
     d27:	e8 f4 f6 ff ff       	call   420 <destroyNode>
    file->len--;
     d2c:	83 6b 0c 01          	subl   $0x1,0xc(%ebx)
  while (curNode != stopNode) {
     d30:	83 c4 10             	add    $0x10,%esp
     d33:	39 f7                	cmp    %esi,%edi
     d35:	75 e9                	jne    d20 <drop+0x120>
     d37:	e9 57 ff ff ff       	jmp    c93 <drop+0x93>
     d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
     d40:	83 ec 04             	sub    $0x4,%esp
     d43:	52                   	push   %edx
     d44:	68 f2 17 00 00       	push   $0x17f2
     d49:	6a 02                	push   $0x2
     d4b:	e8 90 08 00 00       	call   15e0 <fprintf>
     d50:	83 c4 10             	add    $0x10,%esp
     d53:	e9 32 ff ff ff       	jmp    c8a <drop+0x8a>
     d58:	90                   	nop
     d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "error: bad input range\n");
     d60:	83 ec 08             	sub    $0x8,%esp
     d63:	68 da 17 00 00       	push   $0x17da
     d68:	6a 02                	push   $0x2
     d6a:	e8 71 08 00 00       	call   15e0 <fprintf>
     d6f:	83 c4 10             	add    $0x10,%esp
     d72:	e9 1c ff ff ff       	jmp    c93 <drop+0x93>
     d77:	89 f6                	mov    %esi,%esi
     d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d80 <edit>:
     d80:	55                   	push   %ebp
     d81:	89 e5                	mov    %esp,%ebp
     d83:	5d                   	pop    %ebp
     d84:	c3                   	ret    
     d85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d90 <list>:
void list(struct File file, char* args) {
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	57                   	push   %edi
     d94:	56                   	push   %esi
     d95:	53                   	push   %ebx
     d96:	83 ec 28             	sub    $0x28,%esp
     d99:	8b 5d 18             	mov    0x18(%ebp),%ebx
     d9c:	8b 75 10             	mov    0x10(%ebp),%esi
  if (strlen(args) < 1) {
     d9f:	53                   	push   %ebx
     da0:	e8 fb 02 00 00       	call   10a0 <strlen>
     da5:	83 c4 10             	add    $0x10,%esp
     da8:	85 c0                	test   %eax,%eax
     daa:	75 24                	jne    dd0 <list+0x40>
    fprintf(2, "you need to give a range to list\n");
     dac:	83 ec 08             	sub    $0x8,%esp
     daf:	68 34 19 00 00       	push   $0x1934
     db4:	6a 02                	push   $0x2
     db6:	e8 25 08 00 00       	call   15e0 <fprintf>
    return;
     dbb:	83 c4 10             	add    $0x10,%esp
}
     dbe:	8d 65 f4             	lea    -0xc(%ebp),%esp
     dc1:	5b                   	pop    %ebx
     dc2:	5e                   	pop    %esi
     dc3:	5f                   	pop    %edi
     dc4:	5d                   	pop    %ebp
     dc5:	c3                   	ret    
     dc6:	8d 76 00             	lea    0x0(%esi),%esi
     dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if (collectRange(args, &start, &end) == 1) {
     dd0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     dd3:	83 ec 04             	sub    $0x4,%esp
     dd6:	50                   	push   %eax
     dd7:	8d 45 e0             	lea    -0x20(%ebp),%eax
     dda:	50                   	push   %eax
     ddb:	53                   	push   %ebx
     ddc:	e8 6f fa ff ff       	call   850 <collectRange>
     de1:	83 c4 10             	add    $0x10,%esp
     de4:	83 f8 01             	cmp    $0x1,%eax
     de7:	0f 84 93 00 00 00    	je     e80 <list+0xf0>
     ded:	8b 45 e0             	mov    -0x20(%ebp),%eax
     df0:	83 ec 08             	sub    $0x8,%esp
     df3:	83 e8 01             	sub    $0x1,%eax
     df6:	50                   	push   %eax
     df7:	56                   	push   %esi
     df8:	e8 b3 f5 ff ff       	call   3b0 <nodeAt>
  struct Node* curNode = (lineAt(file.lines, start))->prev;
     dfd:	8b 18                	mov    (%eax),%ebx
     dff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     e02:	5f                   	pop    %edi
     e03:	5a                   	pop    %edx
     e04:	83 e8 01             	sub    $0x1,%eax
     e07:	50                   	push   %eax
     e08:	56                   	push   %esi
     e09:	e8 a2 f5 ff ff       	call   3b0 <nodeAt>
     e0e:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
     e11:	39 d8                	cmp    %ebx,%eax
     e13:	89 c7                	mov    %eax,%edi
     e15:	74 a7                	je     dbe <list+0x2e>
    curNode = curNode->next;
     e17:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) {
     e1a:	3b 5e 04             	cmp    0x4(%esi),%ebx
     e1d:	74 22                	je     e41 <list+0xb1>
     e1f:	90                   	nop
    fprintf(2, "%s\n", curNode->data);
     e20:	83 ec 04             	sub    $0x4,%esp
     e23:	ff 73 04             	pushl  0x4(%ebx)
     e26:	68 bb 17 00 00       	push   $0x17bb
     e2b:	6a 02                	push   $0x2
     e2d:	e8 ae 07 00 00       	call   15e0 <fprintf>
  while (curNode != stopNode) {
     e32:	83 c4 10             	add    $0x10,%esp
     e35:	39 df                	cmp    %ebx,%edi
     e37:	74 85                	je     dbe <list+0x2e>
    curNode = curNode->next;
     e39:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) {
     e3c:	39 5e 04             	cmp    %ebx,0x4(%esi)
     e3f:	75 df                	jne    e20 <list+0x90>
      fprintf(2, "________________________________\n");
     e41:	83 ec 08             	sub    $0x8,%esp
     e44:	68 58 19 00 00       	push   $0x1958
     e49:	6a 02                	push   $0x2
     e4b:	e8 90 07 00 00       	call   15e0 <fprintf>
      fprintf(2, "make sure start is less than end\n");
     e50:	58                   	pop    %eax
     e51:	5a                   	pop    %edx
     e52:	68 7c 19 00 00       	push   $0x197c
     e57:	6a 02                	push   $0x2
     e59:	e8 82 07 00 00       	call   15e0 <fprintf>
      fprintf(2, "printed till EOF\n");
     e5e:	59                   	pop    %ecx
     e5f:	5b                   	pop    %ebx
     e60:	68 32 18 00 00       	push   $0x1832
     e65:	6a 02                	push   $0x2
     e67:	e8 74 07 00 00       	call   15e0 <fprintf>
      return;
     e6c:	83 c4 10             	add    $0x10,%esp
}
     e6f:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e72:	5b                   	pop    %ebx
     e73:	5e                   	pop    %esi
     e74:	5f                   	pop    %edi
     e75:	5d                   	pop    %ebp
     e76:	c3                   	ret    
     e77:	89 f6                	mov    %esi,%esi
     e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    fprintf(2, "error: start index is larger than end index\n");
     e80:	83 ec 08             	sub    $0x8,%esp
     e83:	68 04 19 00 00       	push   $0x1904
     e88:	6a 02                	push   $0x2
     e8a:	e8 51 07 00 00       	call   15e0 <fprintf>
    return;
     e8f:	83 c4 10             	add    $0x10,%esp
}
     e92:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e95:	5b                   	pop    %ebx
     e96:	5e                   	pop    %esi
     e97:	5f                   	pop    %edi
     e98:	5d                   	pop    %ebp
     e99:	c3                   	ret    
     e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000ea0 <show>:
void show(struct File file, char* args) {
     ea0:	55                   	push   %ebp
     ea1:	89 e5                	mov    %esp,%ebp
     ea3:	57                   	push   %edi
     ea4:	56                   	push   %esi
     ea5:	53                   	push   %ebx
     ea6:	83 ec 0c             	sub    $0xc,%esp
     ea9:	8b 7d 10             	mov    0x10(%ebp),%edi
  struct Node* cur = file.lines->head->next;
     eac:	8b 07                	mov    (%edi),%eax
     eae:	8b 58 08             	mov    0x8(%eax),%ebx
  while (cur != file.lines->tail) {
     eb1:	3b 5f 04             	cmp    0x4(%edi),%ebx
     eb4:	74 24                	je     eda <show+0x3a>
  int lineNum = 1;
     eb6:	be 01 00 00 00       	mov    $0x1,%esi
     ebb:	90                   	nop
     ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printl(lineNum, cur->data);
     ec0:	83 ec 08             	sub    $0x8,%esp
     ec3:	ff 73 04             	pushl  0x4(%ebx)
     ec6:	56                   	push   %esi
    lineNum++;
     ec7:	83 c6 01             	add    $0x1,%esi
    printl(lineNum, cur->data);
     eca:	e8 b1 fc ff ff       	call   b80 <printl>
    cur = cur->next;
     ecf:	8b 5b 08             	mov    0x8(%ebx),%ebx
  while (cur != file.lines->tail) {
     ed2:	83 c4 10             	add    $0x10,%esp
     ed5:	39 5f 04             	cmp    %ebx,0x4(%edi)
     ed8:	75 e6                	jne    ec0 <show+0x20>
}
     eda:	8d 65 f4             	lea    -0xc(%ebp),%esp
     edd:	5b                   	pop    %ebx
     ede:	5e                   	pop    %esi
     edf:	5f                   	pop    %edi
     ee0:	5d                   	pop    %ebp
     ee1:	c3                   	ret    
     ee2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ef0 <quit>:
void quit(struct File* file) {
     ef0:	55                   	push   %ebp
     ef1:	89 e5                	mov    %esp,%ebp
     ef3:	56                   	push   %esi
     ef4:	53                   	push   %ebx
     ef5:	8b 75 08             	mov    0x8(%ebp),%esi
  fprintf(2, "save changes (y/n)? ");
     ef8:	83 ec 08             	sub    $0x8,%esp
     efb:	68 44 18 00 00       	push   $0x1844
     f00:	6a 02                	push   $0x2
     f02:	e8 d9 06 00 00       	call   15e0 <fprintf>
  if (confirmation() != 0) return;
     f07:	e8 d4 f7 ff ff       	call   6e0 <confirmation>
     f0c:	83 c4 10             	add    $0x10,%esp
     f0f:	85 c0                	test   %eax,%eax
     f11:	74 0d                	je     f20 <quit+0x30>
}
     f13:	8d 65 f8             	lea    -0x8(%ebp),%esp
     f16:	5b                   	pop    %ebx
     f17:	5e                   	pop    %esi
     f18:	5d                   	pop    %ebp
     f19:	c3                   	ret    
     f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if (unlink(file->filename) < 0) {
     f20:	83 ec 0c             	sub    $0xc,%esp
     f23:	ff 36                	pushl  (%esi)
     f25:	e8 98 03 00 00       	call   12c2 <unlink>
     f2a:	83 c4 10             	add    $0x10,%esp
     f2d:	85 c0                	test   %eax,%eax
     f2f:	0f 88 8b 00 00 00    	js     fc0 <quit+0xd0>
  file->fd = open(file->filename, O_CREATE|O_RDWR);
     f35:	83 ec 08             	sub    $0x8,%esp
     f38:	68 02 02 00 00       	push   $0x202
     f3d:	ff 36                	pushl  (%esi)
     f3f:	e8 6e 03 00 00       	call   12b2 <open>
  if (file->fd < 0) {
     f44:	83 c4 10             	add    $0x10,%esp
     f47:	85 c0                	test   %eax,%eax
  file->fd = open(file->filename, O_CREATE|O_RDWR);
     f49:	89 46 04             	mov    %eax,0x4(%esi)
  if (file->fd < 0) {
     f4c:	0f 88 8e 00 00 00    	js     fe0 <quit+0xf0>
  struct Node* cur = file->lines->head->next;
     f52:	8b 56 08             	mov    0x8(%esi),%edx
     f55:	8b 0a                	mov    (%edx),%ecx
     f57:	8b 59 08             	mov    0x8(%ecx),%ebx
  while (cur != file->lines->tail) {
     f5a:	3b 5a 04             	cmp    0x4(%edx),%ebx
     f5d:	74 3e                	je     f9d <quit+0xad>
     f5f:	90                   	nop
    write(file->fd, cur->data, strlen(cur->data));
     f60:	83 ec 0c             	sub    $0xc,%esp
     f63:	ff 73 04             	pushl  0x4(%ebx)
     f66:	e8 35 01 00 00       	call   10a0 <strlen>
     f6b:	83 c4 0c             	add    $0xc,%esp
     f6e:	50                   	push   %eax
     f6f:	ff 73 04             	pushl  0x4(%ebx)
     f72:	ff 76 04             	pushl  0x4(%esi)
     f75:	e8 18 03 00 00       	call   1292 <write>
    write(file->fd, "\n", sizeof(char));
     f7a:	83 c4 0c             	add    $0xc,%esp
     f7d:	6a 01                	push   $0x1
     f7f:	68 8f 18 00 00       	push   $0x188f
     f84:	ff 76 04             	pushl  0x4(%esi)
     f87:	e8 06 03 00 00       	call   1292 <write>
  while (cur != file->lines->tail) {
     f8c:	8b 46 08             	mov    0x8(%esi),%eax
    cur = cur->next;
     f8f:	8b 5b 08             	mov    0x8(%ebx),%ebx
  while (cur != file->lines->tail) {
     f92:	83 c4 10             	add    $0x10,%esp
     f95:	3b 58 04             	cmp    0x4(%eax),%ebx
     f98:	75 c6                	jne    f60 <quit+0x70>
     f9a:	8b 46 04             	mov    0x4(%esi),%eax
  close(file->fd);
     f9d:	83 ec 0c             	sub    $0xc,%esp
     fa0:	50                   	push   %eax
     fa1:	e8 f4 02 00 00       	call   129a <close>
  fprintf(2, "changes saved");
     fa6:	58                   	pop    %eax
     fa7:	5a                   	pop    %edx
     fa8:	68 59 18 00 00       	push   $0x1859
     fad:	6a 02                	push   $0x2
     faf:	e8 2c 06 00 00       	call   15e0 <fprintf>
     fb4:	83 c4 10             	add    $0x10,%esp
}
     fb7:	8d 65 f8             	lea    -0x8(%ebp),%esp
     fba:	5b                   	pop    %ebx
     fbb:	5e                   	pop    %esi
     fbc:	5d                   	pop    %ebp
     fbd:	c3                   	ret    
     fbe:	66 90                	xchg   %ax,%ax
    fprintf(2, "could not clear file for writing. changes lost\n");
     fc0:	83 ec 08             	sub    $0x8,%esp
     fc3:	68 a0 19 00 00       	push   $0x19a0
     fc8:	6a 02                	push   $0x2
     fca:	e8 11 06 00 00       	call   15e0 <fprintf>
    return;
     fcf:	83 c4 10             	add    $0x10,%esp
}
     fd2:	8d 65 f8             	lea    -0x8(%ebp),%esp
     fd5:	5b                   	pop    %ebx
     fd6:	5e                   	pop    %esi
     fd7:	5d                   	pop    %ebp
     fd8:	c3                   	ret    
     fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "could not open file for writing. changes lost\n");
     fe0:	83 ec 08             	sub    $0x8,%esp
     fe3:	68 d0 19 00 00       	push   $0x19d0
     fe8:	6a 02                	push   $0x2
     fea:	e8 f1 05 00 00       	call   15e0 <fprintf>
    return;
     fef:	83 c4 10             	add    $0x10,%esp
     ff2:	e9 1c ff ff ff       	jmp    f13 <quit+0x23>
     ff7:	89 f6                	mov    %esi,%esi
     ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001000 <bi>:
void bi() {
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 ec 10             	sub    $0x10,%esp
  fprintf(2, "bad bi input\n");
    1006:	68 d0 18 00 00       	push   $0x18d0
    100b:	6a 02                	push   $0x2
    100d:	e8 ce 05 00 00       	call   15e0 <fprintf>
}
    1012:	83 c4 10             	add    $0x10,%esp
    1015:	c9                   	leave  
    1016:	c3                   	ret    
    1017:	66 90                	xchg   %ax,%ax
    1019:	66 90                	xchg   %ax,%ax
    101b:	66 90                	xchg   %ax,%ax
    101d:	66 90                	xchg   %ax,%ax
    101f:	90                   	nop

00001020 <strcpy>:
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	53                   	push   %ebx
    1024:	8b 45 08             	mov    0x8(%ebp),%eax
    1027:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    102a:	89 c2                	mov    %eax,%edx
    102c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1030:	83 c1 01             	add    $0x1,%ecx
    1033:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1037:	83 c2 01             	add    $0x1,%edx
    103a:	84 db                	test   %bl,%bl
    103c:	88 5a ff             	mov    %bl,-0x1(%edx)
    103f:	75 ef                	jne    1030 <strcpy+0x10>
    1041:	5b                   	pop    %ebx
    1042:	5d                   	pop    %ebp
    1043:	c3                   	ret    
    1044:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    104a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001050 <strcmp>:
    1050:	55                   	push   %ebp
    1051:	89 e5                	mov    %esp,%ebp
    1053:	53                   	push   %ebx
    1054:	8b 55 08             	mov    0x8(%ebp),%edx
    1057:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    105a:	0f b6 02             	movzbl (%edx),%eax
    105d:	0f b6 19             	movzbl (%ecx),%ebx
    1060:	84 c0                	test   %al,%al
    1062:	75 1c                	jne    1080 <strcmp+0x30>
    1064:	eb 2a                	jmp    1090 <strcmp+0x40>
    1066:	8d 76 00             	lea    0x0(%esi),%esi
    1069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1070:	83 c2 01             	add    $0x1,%edx
    1073:	0f b6 02             	movzbl (%edx),%eax
    1076:	83 c1 01             	add    $0x1,%ecx
    1079:	0f b6 19             	movzbl (%ecx),%ebx
    107c:	84 c0                	test   %al,%al
    107e:	74 10                	je     1090 <strcmp+0x40>
    1080:	38 d8                	cmp    %bl,%al
    1082:	74 ec                	je     1070 <strcmp+0x20>
    1084:	29 d8                	sub    %ebx,%eax
    1086:	5b                   	pop    %ebx
    1087:	5d                   	pop    %ebp
    1088:	c3                   	ret    
    1089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1090:	31 c0                	xor    %eax,%eax
    1092:	29 d8                	sub    %ebx,%eax
    1094:	5b                   	pop    %ebx
    1095:	5d                   	pop    %ebp
    1096:	c3                   	ret    
    1097:	89 f6                	mov    %esi,%esi
    1099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010a0 <strlen>:
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
    10a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10a6:	80 39 00             	cmpb   $0x0,(%ecx)
    10a9:	74 15                	je     10c0 <strlen+0x20>
    10ab:	31 d2                	xor    %edx,%edx
    10ad:	8d 76 00             	lea    0x0(%esi),%esi
    10b0:	83 c2 01             	add    $0x1,%edx
    10b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    10b7:	89 d0                	mov    %edx,%eax
    10b9:	75 f5                	jne    10b0 <strlen+0x10>
    10bb:	5d                   	pop    %ebp
    10bc:	c3                   	ret    
    10bd:	8d 76 00             	lea    0x0(%esi),%esi
    10c0:	31 c0                	xor    %eax,%eax
    10c2:	5d                   	pop    %ebp
    10c3:	c3                   	ret    
    10c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000010d0 <memset>:
    10d0:	55                   	push   %ebp
    10d1:	89 e5                	mov    %esp,%ebp
    10d3:	57                   	push   %edi
    10d4:	8b 55 08             	mov    0x8(%ebp),%edx
    10d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10da:	8b 45 0c             	mov    0xc(%ebp),%eax
    10dd:	89 d7                	mov    %edx,%edi
    10df:	fc                   	cld    
    10e0:	f3 aa                	rep stos %al,%es:(%edi)
    10e2:	89 d0                	mov    %edx,%eax
    10e4:	5f                   	pop    %edi
    10e5:	5d                   	pop    %ebp
    10e6:	c3                   	ret    
    10e7:	89 f6                	mov    %esi,%esi
    10e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010f0 <strchr>:
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
    10f3:	53                   	push   %ebx
    10f4:	8b 45 08             	mov    0x8(%ebp),%eax
    10f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    10fa:	0f b6 10             	movzbl (%eax),%edx
    10fd:	84 d2                	test   %dl,%dl
    10ff:	74 1d                	je     111e <strchr+0x2e>
    1101:	38 d3                	cmp    %dl,%bl
    1103:	89 d9                	mov    %ebx,%ecx
    1105:	75 0d                	jne    1114 <strchr+0x24>
    1107:	eb 17                	jmp    1120 <strchr+0x30>
    1109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1110:	38 ca                	cmp    %cl,%dl
    1112:	74 0c                	je     1120 <strchr+0x30>
    1114:	83 c0 01             	add    $0x1,%eax
    1117:	0f b6 10             	movzbl (%eax),%edx
    111a:	84 d2                	test   %dl,%dl
    111c:	75 f2                	jne    1110 <strchr+0x20>
    111e:	31 c0                	xor    %eax,%eax
    1120:	5b                   	pop    %ebx
    1121:	5d                   	pop    %ebp
    1122:	c3                   	ret    
    1123:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001130 <gets>:
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	57                   	push   %edi
    1134:	56                   	push   %esi
    1135:	53                   	push   %ebx
    1136:	31 f6                	xor    %esi,%esi
    1138:	89 f3                	mov    %esi,%ebx
    113a:	83 ec 1c             	sub    $0x1c,%esp
    113d:	8b 7d 08             	mov    0x8(%ebp),%edi
    1140:	eb 2f                	jmp    1171 <gets+0x41>
    1142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1148:	8d 45 e7             	lea    -0x19(%ebp),%eax
    114b:	83 ec 04             	sub    $0x4,%esp
    114e:	6a 01                	push   $0x1
    1150:	50                   	push   %eax
    1151:	6a 00                	push   $0x0
    1153:	e8 32 01 00 00       	call   128a <read>
    1158:	83 c4 10             	add    $0x10,%esp
    115b:	85 c0                	test   %eax,%eax
    115d:	7e 1c                	jle    117b <gets+0x4b>
    115f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1163:	83 c7 01             	add    $0x1,%edi
    1166:	88 47 ff             	mov    %al,-0x1(%edi)
    1169:	3c 0a                	cmp    $0xa,%al
    116b:	74 23                	je     1190 <gets+0x60>
    116d:	3c 0d                	cmp    $0xd,%al
    116f:	74 1f                	je     1190 <gets+0x60>
    1171:	83 c3 01             	add    $0x1,%ebx
    1174:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1177:	89 fe                	mov    %edi,%esi
    1179:	7c cd                	jl     1148 <gets+0x18>
    117b:	89 f3                	mov    %esi,%ebx
    117d:	8b 45 08             	mov    0x8(%ebp),%eax
    1180:	c6 03 00             	movb   $0x0,(%ebx)
    1183:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1186:	5b                   	pop    %ebx
    1187:	5e                   	pop    %esi
    1188:	5f                   	pop    %edi
    1189:	5d                   	pop    %ebp
    118a:	c3                   	ret    
    118b:	90                   	nop
    118c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1190:	8b 75 08             	mov    0x8(%ebp),%esi
    1193:	8b 45 08             	mov    0x8(%ebp),%eax
    1196:	01 de                	add    %ebx,%esi
    1198:	89 f3                	mov    %esi,%ebx
    119a:	c6 03 00             	movb   $0x0,(%ebx)
    119d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11a0:	5b                   	pop    %ebx
    11a1:	5e                   	pop    %esi
    11a2:	5f                   	pop    %edi
    11a3:	5d                   	pop    %ebp
    11a4:	c3                   	ret    
    11a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011b0 <stat>:
    11b0:	55                   	push   %ebp
    11b1:	89 e5                	mov    %esp,%ebp
    11b3:	56                   	push   %esi
    11b4:	53                   	push   %ebx
    11b5:	83 ec 08             	sub    $0x8,%esp
    11b8:	6a 00                	push   $0x0
    11ba:	ff 75 08             	pushl  0x8(%ebp)
    11bd:	e8 f0 00 00 00       	call   12b2 <open>
    11c2:	83 c4 10             	add    $0x10,%esp
    11c5:	85 c0                	test   %eax,%eax
    11c7:	78 27                	js     11f0 <stat+0x40>
    11c9:	83 ec 08             	sub    $0x8,%esp
    11cc:	ff 75 0c             	pushl  0xc(%ebp)
    11cf:	89 c3                	mov    %eax,%ebx
    11d1:	50                   	push   %eax
    11d2:	e8 f3 00 00 00       	call   12ca <fstat>
    11d7:	89 1c 24             	mov    %ebx,(%esp)
    11da:	89 c6                	mov    %eax,%esi
    11dc:	e8 b9 00 00 00       	call   129a <close>
    11e1:	83 c4 10             	add    $0x10,%esp
    11e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    11e7:	89 f0                	mov    %esi,%eax
    11e9:	5b                   	pop    %ebx
    11ea:	5e                   	pop    %esi
    11eb:	5d                   	pop    %ebp
    11ec:	c3                   	ret    
    11ed:	8d 76 00             	lea    0x0(%esi),%esi
    11f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    11f5:	eb ed                	jmp    11e4 <stat+0x34>
    11f7:	89 f6                	mov    %esi,%esi
    11f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001200 <atoi>:
    1200:	55                   	push   %ebp
    1201:	89 e5                	mov    %esp,%ebp
    1203:	53                   	push   %ebx
    1204:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1207:	0f be 11             	movsbl (%ecx),%edx
    120a:	8d 42 d0             	lea    -0x30(%edx),%eax
    120d:	3c 09                	cmp    $0x9,%al
    120f:	b8 00 00 00 00       	mov    $0x0,%eax
    1214:	77 1f                	ja     1235 <atoi+0x35>
    1216:	8d 76 00             	lea    0x0(%esi),%esi
    1219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1220:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1223:	83 c1 01             	add    $0x1,%ecx
    1226:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
    122a:	0f be 11             	movsbl (%ecx),%edx
    122d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1230:	80 fb 09             	cmp    $0x9,%bl
    1233:	76 eb                	jbe    1220 <atoi+0x20>
    1235:	5b                   	pop    %ebx
    1236:	5d                   	pop    %ebp
    1237:	c3                   	ret    
    1238:	90                   	nop
    1239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001240 <memmove>:
    1240:	55                   	push   %ebp
    1241:	89 e5                	mov    %esp,%ebp
    1243:	56                   	push   %esi
    1244:	53                   	push   %ebx
    1245:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1248:	8b 45 08             	mov    0x8(%ebp),%eax
    124b:	8b 75 0c             	mov    0xc(%ebp),%esi
    124e:	85 db                	test   %ebx,%ebx
    1250:	7e 14                	jle    1266 <memmove+0x26>
    1252:	31 d2                	xor    %edx,%edx
    1254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1258:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    125c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    125f:	83 c2 01             	add    $0x1,%edx
    1262:	39 d3                	cmp    %edx,%ebx
    1264:	75 f2                	jne    1258 <memmove+0x18>
    1266:	5b                   	pop    %ebx
    1267:	5e                   	pop    %esi
    1268:	5d                   	pop    %ebp
    1269:	c3                   	ret    

0000126a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    126a:	b8 01 00 00 00       	mov    $0x1,%eax
    126f:	cd 40                	int    $0x40
    1271:	c3                   	ret    

00001272 <exit>:
SYSCALL(exit)
    1272:	b8 02 00 00 00       	mov    $0x2,%eax
    1277:	cd 40                	int    $0x40
    1279:	c3                   	ret    

0000127a <wait>:
SYSCALL(wait)
    127a:	b8 03 00 00 00       	mov    $0x3,%eax
    127f:	cd 40                	int    $0x40
    1281:	c3                   	ret    

00001282 <pipe>:
SYSCALL(pipe)
    1282:	b8 04 00 00 00       	mov    $0x4,%eax
    1287:	cd 40                	int    $0x40
    1289:	c3                   	ret    

0000128a <read>:
SYSCALL(read)
    128a:	b8 05 00 00 00       	mov    $0x5,%eax
    128f:	cd 40                	int    $0x40
    1291:	c3                   	ret    

00001292 <write>:
SYSCALL(write)
    1292:	b8 10 00 00 00       	mov    $0x10,%eax
    1297:	cd 40                	int    $0x40
    1299:	c3                   	ret    

0000129a <close>:
SYSCALL(close)
    129a:	b8 15 00 00 00       	mov    $0x15,%eax
    129f:	cd 40                	int    $0x40
    12a1:	c3                   	ret    

000012a2 <kill>:
SYSCALL(kill)
    12a2:	b8 06 00 00 00       	mov    $0x6,%eax
    12a7:	cd 40                	int    $0x40
    12a9:	c3                   	ret    

000012aa <exec>:
SYSCALL(exec)
    12aa:	b8 07 00 00 00       	mov    $0x7,%eax
    12af:	cd 40                	int    $0x40
    12b1:	c3                   	ret    

000012b2 <open>:
SYSCALL(open)
    12b2:	b8 0f 00 00 00       	mov    $0xf,%eax
    12b7:	cd 40                	int    $0x40
    12b9:	c3                   	ret    

000012ba <mknod>:
SYSCALL(mknod)
    12ba:	b8 11 00 00 00       	mov    $0x11,%eax
    12bf:	cd 40                	int    $0x40
    12c1:	c3                   	ret    

000012c2 <unlink>:
SYSCALL(unlink)
    12c2:	b8 12 00 00 00       	mov    $0x12,%eax
    12c7:	cd 40                	int    $0x40
    12c9:	c3                   	ret    

000012ca <fstat>:
SYSCALL(fstat)
    12ca:	b8 08 00 00 00       	mov    $0x8,%eax
    12cf:	cd 40                	int    $0x40
    12d1:	c3                   	ret    

000012d2 <link>:
SYSCALL(link)
    12d2:	b8 13 00 00 00       	mov    $0x13,%eax
    12d7:	cd 40                	int    $0x40
    12d9:	c3                   	ret    

000012da <mkdir>:
SYSCALL(mkdir)
    12da:	b8 14 00 00 00       	mov    $0x14,%eax
    12df:	cd 40                	int    $0x40
    12e1:	c3                   	ret    

000012e2 <chdir>:
SYSCALL(chdir)
    12e2:	b8 09 00 00 00       	mov    $0x9,%eax
    12e7:	cd 40                	int    $0x40
    12e9:	c3                   	ret    

000012ea <dup>:
SYSCALL(dup)
    12ea:	b8 0a 00 00 00       	mov    $0xa,%eax
    12ef:	cd 40                	int    $0x40
    12f1:	c3                   	ret    

000012f2 <getpid>:
SYSCALL(getpid)
    12f2:	b8 0b 00 00 00       	mov    $0xb,%eax
    12f7:	cd 40                	int    $0x40
    12f9:	c3                   	ret    

000012fa <sbrk>:
SYSCALL(sbrk)
    12fa:	b8 0c 00 00 00       	mov    $0xc,%eax
    12ff:	cd 40                	int    $0x40
    1301:	c3                   	ret    

00001302 <sleep>:
SYSCALL(sleep)
    1302:	b8 0d 00 00 00       	mov    $0xd,%eax
    1307:	cd 40                	int    $0x40
    1309:	c3                   	ret    

0000130a <uptime>:
SYSCALL(uptime)
    130a:	b8 0e 00 00 00       	mov    $0xe,%eax
    130f:	cd 40                	int    $0x40
    1311:	c3                   	ret    

00001312 <cpuhalt>:
SYSCALL(cpuhalt)
    1312:	b8 16 00 00 00       	mov    $0x16,%eax
    1317:	cd 40                	int    $0x40
    1319:	c3                   	ret    
    131a:	66 90                	xchg   %ax,%ax
    131c:	66 90                	xchg   %ax,%ax
    131e:	66 90                	xchg   %ax,%ax

00001320 <printint.constprop.1>:
    1320:	55                   	push   %ebp
    1321:	89 e5                	mov    %esp,%ebp
    1323:	57                   	push   %edi
    1324:	56                   	push   %esi
    1325:	53                   	push   %ebx
    1326:	89 d6                	mov    %edx,%esi
    1328:	83 ec 3c             	sub    $0x3c,%esp
    132b:	85 c0                	test   %eax,%eax
    132d:	79 71                	jns    13a0 <printint.constprop.1+0x80>
    132f:	83 e1 01             	and    $0x1,%ecx
    1332:	74 6c                	je     13a0 <printint.constprop.1+0x80>
    1334:	f7 d8                	neg    %eax
    1336:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    133d:	31 c9                	xor    %ecx,%ecx
    133f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1342:	eb 06                	jmp    134a <printint.constprop.1+0x2a>
    1344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1348:	89 f9                	mov    %edi,%ecx
    134a:	31 d2                	xor    %edx,%edx
    134c:	8d 79 01             	lea    0x1(%ecx),%edi
    134f:	f7 f6                	div    %esi
    1351:	0f b6 92 28 1a 00 00 	movzbl 0x1a28(%edx),%edx
    1358:	85 c0                	test   %eax,%eax
    135a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
    135d:	75 e9                	jne    1348 <printint.constprop.1+0x28>
    135f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1362:	85 c0                	test   %eax,%eax
    1364:	74 08                	je     136e <printint.constprop.1+0x4e>
    1366:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    136b:	8d 79 02             	lea    0x2(%ecx),%edi
    136e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    1372:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1378:	0f b6 06             	movzbl (%esi),%eax
    137b:	83 ec 04             	sub    $0x4,%esp
    137e:	83 ee 01             	sub    $0x1,%esi
    1381:	6a 01                	push   $0x1
    1383:	53                   	push   %ebx
    1384:	6a 01                	push   $0x1
    1386:	88 45 d7             	mov    %al,-0x29(%ebp)
    1389:	e8 04 ff ff ff       	call   1292 <write>
    138e:	83 c4 10             	add    $0x10,%esp
    1391:	39 de                	cmp    %ebx,%esi
    1393:	75 e3                	jne    1378 <printint.constprop.1+0x58>
    1395:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1398:	5b                   	pop    %ebx
    1399:	5e                   	pop    %esi
    139a:	5f                   	pop    %edi
    139b:	5d                   	pop    %ebp
    139c:	c3                   	ret    
    139d:	8d 76 00             	lea    0x0(%esi),%esi
    13a0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    13a7:	eb 94                	jmp    133d <printint.constprop.1+0x1d>
    13a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000013b0 <vprintf.constprop.0>:
    13b0:	55                   	push   %ebp
    13b1:	89 e5                	mov    %esp,%ebp
    13b3:	57                   	push   %edi
    13b4:	56                   	push   %esi
    13b5:	53                   	push   %ebx
    13b6:	89 d6                	mov    %edx,%esi
    13b8:	83 ec 2c             	sub    $0x2c,%esp
    13bb:	0f b6 10             	movzbl (%eax),%edx
    13be:	84 d2                	test   %dl,%dl
    13c0:	0f 84 cd 00 00 00    	je     1493 <vprintf.constprop.0+0xe3>
    13c6:	8d 58 01             	lea    0x1(%eax),%ebx
    13c9:	31 ff                	xor    %edi,%edi
    13cb:	eb 31                	jmp    13fe <vprintf.constprop.0+0x4e>
    13cd:	8d 76 00             	lea    0x0(%esi),%esi
    13d0:	83 f8 25             	cmp    $0x25,%eax
    13d3:	0f 84 c7 00 00 00    	je     14a0 <vprintf.constprop.0+0xf0>
    13d9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    13dc:	83 ec 04             	sub    $0x4,%esp
    13df:	88 55 e4             	mov    %dl,-0x1c(%ebp)
    13e2:	6a 01                	push   $0x1
    13e4:	50                   	push   %eax
    13e5:	6a 01                	push   $0x1
    13e7:	e8 a6 fe ff ff       	call   1292 <write>
    13ec:	83 c4 10             	add    $0x10,%esp
    13ef:	83 c3 01             	add    $0x1,%ebx
    13f2:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    13f6:	84 d2                	test   %dl,%dl
    13f8:	0f 84 95 00 00 00    	je     1493 <vprintf.constprop.0+0xe3>
    13fe:	85 ff                	test   %edi,%edi
    1400:	0f b6 c2             	movzbl %dl,%eax
    1403:	74 cb                	je     13d0 <vprintf.constprop.0+0x20>
    1405:	83 ff 25             	cmp    $0x25,%edi
    1408:	75 e5                	jne    13ef <vprintf.constprop.0+0x3f>
    140a:	83 f8 64             	cmp    $0x64,%eax
    140d:	8d 7e 04             	lea    0x4(%esi),%edi
    1410:	b9 01 00 00 00       	mov    $0x1,%ecx
    1415:	0f 84 9a 00 00 00    	je     14b5 <vprintf.constprop.0+0x105>
    141b:	83 f8 6c             	cmp    $0x6c,%eax
    141e:	0f 84 8c 00 00 00    	je     14b0 <vprintf.constprop.0+0x100>
    1424:	83 f8 78             	cmp    $0x78,%eax
    1427:	0f 84 a3 00 00 00    	je     14d0 <vprintf.constprop.0+0x120>
    142d:	83 f8 70             	cmp    $0x70,%eax
    1430:	0f 84 ca 00 00 00    	je     1500 <vprintf.constprop.0+0x150>
    1436:	83 f8 73             	cmp    $0x73,%eax
    1439:	0f 84 39 01 00 00    	je     1578 <vprintf.constprop.0+0x1c8>
    143f:	83 f8 63             	cmp    $0x63,%eax
    1442:	0f 84 68 01 00 00    	je     15b0 <vprintf.constprop.0+0x200>
    1448:	83 f8 25             	cmp    $0x25,%eax
    144b:	0f 84 9f 00 00 00    	je     14f0 <vprintf.constprop.0+0x140>
    1451:	8d 45 df             	lea    -0x21(%ebp),%eax
    1454:	83 ec 04             	sub    $0x4,%esp
    1457:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    145a:	6a 01                	push   $0x1
    145c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
    1460:	50                   	push   %eax
    1461:	6a 01                	push   $0x1
    1463:	e8 2a fe ff ff       	call   1292 <write>
    1468:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    146c:	83 c4 0c             	add    $0xc,%esp
    146f:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1472:	6a 01                	push   $0x1
    1474:	88 55 e0             	mov    %dl,-0x20(%ebp)
    1477:	50                   	push   %eax
    1478:	6a 01                	push   $0x1
    147a:	83 c3 01             	add    $0x1,%ebx
    147d:	31 ff                	xor    %edi,%edi
    147f:	e8 0e fe ff ff       	call   1292 <write>
    1484:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1488:	83 c4 10             	add    $0x10,%esp
    148b:	84 d2                	test   %dl,%dl
    148d:	0f 85 6b ff ff ff    	jne    13fe <vprintf.constprop.0+0x4e>
    1493:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1496:	5b                   	pop    %ebx
    1497:	5e                   	pop    %esi
    1498:	5f                   	pop    %edi
    1499:	5d                   	pop    %ebp
    149a:	c3                   	ret    
    149b:	90                   	nop
    149c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    14a0:	bf 25 00 00 00       	mov    $0x25,%edi
    14a5:	e9 45 ff ff ff       	jmp    13ef <vprintf.constprop.0+0x3f>
    14aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    14b0:	8d 7e 04             	lea    0x4(%esi),%edi
    14b3:	31 c9                	xor    %ecx,%ecx
    14b5:	8b 06                	mov    (%esi),%eax
    14b7:	ba 0a 00 00 00       	mov    $0xa,%edx
    14bc:	89 fe                	mov    %edi,%esi
    14be:	31 ff                	xor    %edi,%edi
    14c0:	e8 5b fe ff ff       	call   1320 <printint.constprop.1>
    14c5:	e9 25 ff ff ff       	jmp    13ef <vprintf.constprop.0+0x3f>
    14ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    14d0:	8b 06                	mov    (%esi),%eax
    14d2:	8d 7e 04             	lea    0x4(%esi),%edi
    14d5:	31 c9                	xor    %ecx,%ecx
    14d7:	ba 10 00 00 00       	mov    $0x10,%edx
    14dc:	89 fe                	mov    %edi,%esi
    14de:	31 ff                	xor    %edi,%edi
    14e0:	e8 3b fe ff ff       	call   1320 <printint.constprop.1>
    14e5:	e9 05 ff ff ff       	jmp    13ef <vprintf.constprop.0+0x3f>
    14ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    14f0:	83 ec 04             	sub    $0x4,%esp
    14f3:	88 55 e1             	mov    %dl,-0x1f(%ebp)
    14f6:	8d 45 e1             	lea    -0x1f(%ebp),%eax
    14f9:	6a 01                	push   $0x1
    14fb:	e9 77 ff ff ff       	jmp    1477 <vprintf.constprop.0+0xc7>
    1500:	8d 46 04             	lea    0x4(%esi),%eax
    1503:	83 ec 04             	sub    $0x4,%esp
    1506:	8b 3e                	mov    (%esi),%edi
    1508:	6a 01                	push   $0x1
    150a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
    150e:	be 08 00 00 00       	mov    $0x8,%esi
    1513:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1516:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1519:	50                   	push   %eax
    151a:	6a 01                	push   $0x1
    151c:	e8 71 fd ff ff       	call   1292 <write>
    1521:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1524:	83 c4 0c             	add    $0xc,%esp
    1527:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
    152b:	6a 01                	push   $0x1
    152d:	50                   	push   %eax
    152e:	6a 01                	push   $0x1
    1530:	e8 5d fd ff ff       	call   1292 <write>
    1535:	83 c4 10             	add    $0x10,%esp
    1538:	90                   	nop
    1539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1540:	89 f8                	mov    %edi,%eax
    1542:	83 ec 04             	sub    $0x4,%esp
    1545:	c1 e7 04             	shl    $0x4,%edi
    1548:	c1 e8 1c             	shr    $0x1c,%eax
    154b:	6a 01                	push   $0x1
    154d:	0f b6 80 28 1a 00 00 	movzbl 0x1a28(%eax),%eax
    1554:	88 45 e5             	mov    %al,-0x1b(%ebp)
    1557:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    155a:	50                   	push   %eax
    155b:	6a 01                	push   $0x1
    155d:	e8 30 fd ff ff       	call   1292 <write>
    1562:	83 c4 10             	add    $0x10,%esp
    1565:	83 ee 01             	sub    $0x1,%esi
    1568:	75 d6                	jne    1540 <vprintf.constprop.0+0x190>
    156a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    156d:	31 ff                	xor    %edi,%edi
    156f:	e9 7b fe ff ff       	jmp    13ef <vprintf.constprop.0+0x3f>
    1574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1578:	8b 3e                	mov    (%esi),%edi
    157a:	8d 46 04             	lea    0x4(%esi),%eax
    157d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1580:	85 ff                	test   %edi,%edi
    1582:	74 50                	je     15d4 <vprintf.constprop.0+0x224>
    1584:	0f b6 07             	movzbl (%edi),%eax
    1587:	84 c0                	test   %al,%al
    1589:	74 df                	je     156a <vprintf.constprop.0+0x1ba>
    158b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
    158e:	66 90                	xchg   %ax,%ax
    1590:	83 ec 04             	sub    $0x4,%esp
    1593:	83 c7 01             	add    $0x1,%edi
    1596:	88 45 e3             	mov    %al,-0x1d(%ebp)
    1599:	6a 01                	push   $0x1
    159b:	56                   	push   %esi
    159c:	6a 01                	push   $0x1
    159e:	e8 ef fc ff ff       	call   1292 <write>
    15a3:	0f b6 07             	movzbl (%edi),%eax
    15a6:	83 c4 10             	add    $0x10,%esp
    15a9:	84 c0                	test   %al,%al
    15ab:	75 e3                	jne    1590 <vprintf.constprop.0+0x1e0>
    15ad:	eb bb                	jmp    156a <vprintf.constprop.0+0x1ba>
    15af:	90                   	nop
    15b0:	8b 06                	mov    (%esi),%eax
    15b2:	83 ec 04             	sub    $0x4,%esp
    15b5:	8d 7e 04             	lea    0x4(%esi),%edi
    15b8:	6a 01                	push   $0x1
    15ba:	89 fe                	mov    %edi,%esi
    15bc:	31 ff                	xor    %edi,%edi
    15be:	88 45 e2             	mov    %al,-0x1e(%ebp)
    15c1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    15c4:	50                   	push   %eax
    15c5:	6a 01                	push   $0x1
    15c7:	e8 c6 fc ff ff       	call   1292 <write>
    15cc:	83 c4 10             	add    $0x10,%esp
    15cf:	e9 1b fe ff ff       	jmp    13ef <vprintf.constprop.0+0x3f>
    15d4:	bf 20 1a 00 00       	mov    $0x1a20,%edi
    15d9:	b8 28 00 00 00       	mov    $0x28,%eax
    15de:	eb ab                	jmp    158b <vprintf.constprop.0+0x1db>

000015e0 <fprintf>:
    15e0:	55                   	push   %ebp
    15e1:	89 e5                	mov    %esp,%ebp
    15e3:	83 ec 08             	sub    $0x8,%esp
    15e6:	8b 45 0c             	mov    0xc(%ebp),%eax
    15e9:	8d 55 10             	lea    0x10(%ebp),%edx
    15ec:	e8 bf fd ff ff       	call   13b0 <vprintf.constprop.0>
    15f1:	c9                   	leave  
    15f2:	c3                   	ret    
    15f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    15f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001600 <printf>:
    1600:	55                   	push   %ebp
    1601:	89 e5                	mov    %esp,%ebp
    1603:	83 ec 08             	sub    $0x8,%esp
    1606:	8b 45 08             	mov    0x8(%ebp),%eax
    1609:	8d 55 0c             	lea    0xc(%ebp),%edx
    160c:	e8 9f fd ff ff       	call   13b0 <vprintf.constprop.0>
    1611:	c9                   	leave  
    1612:	c3                   	ret    
    1613:	66 90                	xchg   %ax,%ax
    1615:	66 90                	xchg   %ax,%ax
    1617:	66 90                	xchg   %ax,%ax
    1619:	66 90                	xchg   %ax,%ax
    161b:	66 90                	xchg   %ax,%ax
    161d:	66 90                	xchg   %ax,%ax
    161f:	90                   	nop

00001620 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1620:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1621:	a1 e4 22 00 00       	mov    0x22e4,%eax
{
    1626:	89 e5                	mov    %esp,%ebp
    1628:	57                   	push   %edi
    1629:	56                   	push   %esi
    162a:	53                   	push   %ebx
    162b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    162e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1638:	39 c8                	cmp    %ecx,%eax
    163a:	8b 10                	mov    (%eax),%edx
    163c:	73 32                	jae    1670 <free+0x50>
    163e:	39 d1                	cmp    %edx,%ecx
    1640:	72 04                	jb     1646 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1642:	39 d0                	cmp    %edx,%eax
    1644:	72 32                	jb     1678 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1646:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1649:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    164c:	39 fa                	cmp    %edi,%edx
    164e:	74 30                	je     1680 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1650:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1653:	8b 50 04             	mov    0x4(%eax),%edx
    1656:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1659:	39 f1                	cmp    %esi,%ecx
    165b:	74 3a                	je     1697 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    165d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    165f:	a3 e4 22 00 00       	mov    %eax,0x22e4
}
    1664:	5b                   	pop    %ebx
    1665:	5e                   	pop    %esi
    1666:	5f                   	pop    %edi
    1667:	5d                   	pop    %ebp
    1668:	c3                   	ret    
    1669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1670:	39 d0                	cmp    %edx,%eax
    1672:	72 04                	jb     1678 <free+0x58>
    1674:	39 d1                	cmp    %edx,%ecx
    1676:	72 ce                	jb     1646 <free+0x26>
{
    1678:	89 d0                	mov    %edx,%eax
    167a:	eb bc                	jmp    1638 <free+0x18>
    167c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1680:	03 72 04             	add    0x4(%edx),%esi
    1683:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1686:	8b 10                	mov    (%eax),%edx
    1688:	8b 12                	mov    (%edx),%edx
    168a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    168d:	8b 50 04             	mov    0x4(%eax),%edx
    1690:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1693:	39 f1                	cmp    %esi,%ecx
    1695:	75 c6                	jne    165d <free+0x3d>
    p->s.size += bp->s.size;
    1697:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    169a:	a3 e4 22 00 00       	mov    %eax,0x22e4
    p->s.size += bp->s.size;
    169f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16a2:	8b 53 f8             	mov    -0x8(%ebx),%edx
    16a5:	89 10                	mov    %edx,(%eax)
}
    16a7:	5b                   	pop    %ebx
    16a8:	5e                   	pop    %esi
    16a9:	5f                   	pop    %edi
    16aa:	5d                   	pop    %ebp
    16ab:	c3                   	ret    
    16ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000016b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    16b0:	55                   	push   %ebp
    16b1:	89 e5                	mov    %esp,%ebp
    16b3:	57                   	push   %edi
    16b4:	56                   	push   %esi
    16b5:	53                   	push   %ebx
    16b6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    16b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    16bc:	8b 15 e4 22 00 00    	mov    0x22e4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    16c2:	8d 78 07             	lea    0x7(%eax),%edi
    16c5:	c1 ef 03             	shr    $0x3,%edi
    16c8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    16cb:	85 d2                	test   %edx,%edx
    16cd:	0f 84 9d 00 00 00    	je     1770 <malloc+0xc0>
    16d3:	8b 02                	mov    (%edx),%eax
    16d5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    16d8:	39 cf                	cmp    %ecx,%edi
    16da:	76 6c                	jbe    1748 <malloc+0x98>
    16dc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    16e2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    16e7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    16ea:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    16f1:	eb 0e                	jmp    1701 <malloc+0x51>
    16f3:	90                   	nop
    16f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16f8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    16fa:	8b 48 04             	mov    0x4(%eax),%ecx
    16fd:	39 f9                	cmp    %edi,%ecx
    16ff:	73 47                	jae    1748 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1701:	39 05 e4 22 00 00    	cmp    %eax,0x22e4
    1707:	89 c2                	mov    %eax,%edx
    1709:	75 ed                	jne    16f8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    170b:	83 ec 0c             	sub    $0xc,%esp
    170e:	56                   	push   %esi
    170f:	e8 e6 fb ff ff       	call   12fa <sbrk>
  if(p == (char*)-1)
    1714:	83 c4 10             	add    $0x10,%esp
    1717:	83 f8 ff             	cmp    $0xffffffff,%eax
    171a:	74 1c                	je     1738 <malloc+0x88>
  hp->s.size = nu;
    171c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    171f:	83 ec 0c             	sub    $0xc,%esp
    1722:	83 c0 08             	add    $0x8,%eax
    1725:	50                   	push   %eax
    1726:	e8 f5 fe ff ff       	call   1620 <free>
  return freep;
    172b:	8b 15 e4 22 00 00    	mov    0x22e4,%edx
      if((p = morecore(nunits)) == 0)
    1731:	83 c4 10             	add    $0x10,%esp
    1734:	85 d2                	test   %edx,%edx
    1736:	75 c0                	jne    16f8 <malloc+0x48>
        return 0;
  }
}
    1738:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    173b:	31 c0                	xor    %eax,%eax
}
    173d:	5b                   	pop    %ebx
    173e:	5e                   	pop    %esi
    173f:	5f                   	pop    %edi
    1740:	5d                   	pop    %ebp
    1741:	c3                   	ret    
    1742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1748:	39 cf                	cmp    %ecx,%edi
    174a:	74 54                	je     17a0 <malloc+0xf0>
        p->s.size -= nunits;
    174c:	29 f9                	sub    %edi,%ecx
    174e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1751:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1754:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1757:	89 15 e4 22 00 00    	mov    %edx,0x22e4
}
    175d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1760:	83 c0 08             	add    $0x8,%eax
}
    1763:	5b                   	pop    %ebx
    1764:	5e                   	pop    %esi
    1765:	5f                   	pop    %edi
    1766:	5d                   	pop    %ebp
    1767:	c3                   	ret    
    1768:	90                   	nop
    1769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1770:	c7 05 e4 22 00 00 e8 	movl   $0x22e8,0x22e4
    1777:	22 00 00 
    177a:	c7 05 e8 22 00 00 e8 	movl   $0x22e8,0x22e8
    1781:	22 00 00 
    base.s.size = 0;
    1784:	b8 e8 22 00 00       	mov    $0x22e8,%eax
    1789:	c7 05 ec 22 00 00 00 	movl   $0x0,0x22ec
    1790:	00 00 00 
    1793:	e9 44 ff ff ff       	jmp    16dc <malloc+0x2c>
    1798:	90                   	nop
    1799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    17a0:	8b 08                	mov    (%eax),%ecx
    17a2:	89 0a                	mov    %ecx,(%edx)
    17a4:	eb b1                	jmp    1757 <malloc+0xa7>
