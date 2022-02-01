
user/_xvEdit:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
void toUpper(char* str);
void toLower(char* str);
void unline(char* str);
void printl(int lineNum, char* line);

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
      1f:	0f 8e 2d 02 00 00    	jle    252 <main+0x252>
    fprintf(2, "specify a file you want to edit");
    exit();
  } else if (argc > 2) {
      25:	83 f8 02             	cmp    $0x2,%eax
      28:	0f 85 11 02 00 00    	jne    23f <main+0x23f>
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
      70:	51                   	push   %ecx
      71:	51                   	push   %ecx
      72:	68 b8 17 00 00       	push   $0x17b8
      77:	6a 02                	push   $0x2
  file.lines = MakeLinkedList();
      79:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
  fprintf(2, "Welcome to xvEdit!\n");
      7f:	e8 9c 14 00 00       	call   1520 <fprintf>

  // opening
  file.fd = open(file.filename, O_RDONLY);
      84:	5b                   	pop    %ebx
      85:	5e                   	pop    %esi
      86:	6a 00                	push   $0x0
      88:	ff b5 10 ff ff ff    	pushl  -0xf0(%ebp)
      8e:	e8 5f 11 00 00       	call   11f2 <open>
  if (file.fd == -1) {
      93:	83 c4 10             	add    $0x10,%esp
  file.fd = open(file.filename, O_RDONLY);
      96:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
  if (file.fd == -1) {
      9c:	83 c0 01             	add    $0x1,%eax
      9f:	0f 84 c0 01 00 00    	je     265 <main+0x265>
    fprintf(2, "creating %s . . .\n",  file.filename);
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
    close(file.fd);
  } else { // populate Linked List
    gatherLines(&file);
      a5:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
      ab:	83 ec 0c             	sub    $0xc,%esp
      ae:	50                   	push   %eax
      af:	e8 2c 06 00 00       	call   6e0 <gatherLines>
      b4:	83 c4 10             	add    $0x10,%esp
  }
  close(file.fd);
      b7:	83 ec 0c             	sub    $0xc,%esp
      ba:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
      c0:	8d 9d 20 ff ff ff    	lea    -0xe0(%ebp),%ebx
      c6:	e8 0f 11 00 00       	call   11da <close>
      cb:	83 c4 10             	add    $0x10,%esp
      ce:	66 90                	xchg   %ax,%ax

  // xvEdit>
  while (cmd != QUIT) {
    fprintf(2, "xvEdit> ");
      d0:	83 ec 08             	sub    $0x8,%esp
      d3:	68 df 17 00 00       	push   $0x17df
      d8:	6a 02                	push   $0x2
      da:	e8 41 14 00 00       	call   1520 <fprintf>
    memset(buf, 0, nbuf);
      df:	83 c4 0c             	add    $0xc,%esp
      e2:	6a 64                	push   $0x64
      e4:	6a 00                	push   $0x0
      e6:	68 40 21 00 00       	push   $0x2140
      eb:	e8 20 0f 00 00       	call   1010 <memset>
    gets(buf, nbuf);
      f0:	59                   	pop    %ecx
      f1:	5e                   	pop    %esi
      f2:	6a 64                	push   $0x64
      f4:	68 40 21 00 00       	push   $0x2140
      f9:	e8 72 0f 00 00       	call   1070 <gets>
    
    unline(buf);
      fe:	c7 04 24 40 21 00 00 	movl   $0x2140,(%esp)
     105:	e8 36 0d 00 00       	call   e40 <unline>
    substr(cmdstr, buf, 0, 4);
     10a:	6a 04                	push   $0x4
     10c:	6a 00                	push   $0x0
     10e:	68 40 21 00 00       	push   $0x2140
     113:	53                   	push   %ebx
     114:	e8 e7 06 00 00       	call   800 <substr>
  return (end - start) + 1;
}

void toUpper(char* str) {
  int i = 0;
  while (str[i] != '\0') {
     119:	0f b6 85 20 ff ff ff 	movzbl -0xe0(%ebp),%eax
     120:	83 c4 20             	add    $0x20,%esp
     123:	84 c0                	test   %al,%al
     125:	74 20                	je     147 <main+0x147>
     127:	89 da                	mov    %ebx,%edx
     129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    char c = str[i];
    if (c <= 'z' && c >= 'a')
     130:	8d 48 9f             	lea    -0x61(%eax),%ecx
     133:	80 f9 19             	cmp    $0x19,%cl
     136:	77 05                	ja     13d <main+0x13d>
      str[i] += ('Z' - 'z');
     138:	83 e8 20             	sub    $0x20,%eax
     13b:	88 02                	mov    %al,(%edx)
     13d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     140:	0f b6 02             	movzbl (%edx),%eax
     143:	84 c0                	test   %al,%al
     145:	75 e9                	jne    130 <main+0x130>
    substr(args, buf, strlen(cmdstr) + 1, strlen(buf));
     147:	83 ec 0c             	sub    $0xc,%esp
     14a:	68 40 21 00 00       	push   $0x2140
     14f:	e8 8c 0e 00 00       	call   fe0 <strlen>
     154:	89 1c 24             	mov    %ebx,(%esp)
     157:	89 c6                	mov    %eax,%esi
     159:	e8 82 0e 00 00       	call   fe0 <strlen>
     15e:	83 c0 01             	add    $0x1,%eax
     161:	56                   	push   %esi
     162:	50                   	push   %eax
     163:	8d 45 84             	lea    -0x7c(%ebp),%eax
     166:	68 40 21 00 00       	push   $0x2140
     16b:	50                   	push   %eax
     16c:	e8 8f 06 00 00       	call   800 <substr>
    fprintf(2, "args: %s\n", args);
     171:	8d 45 84             	lea    -0x7c(%ebp),%eax
     174:	83 c4 1c             	add    $0x1c,%esp
     177:	50                   	push   %eax
     178:	68 e8 17 00 00       	push   $0x17e8
     17d:	6a 02                	push   $0x2
     17f:	e8 9c 13 00 00       	call   1520 <fprintf>
    if      (strcmp(cmdstr, "@END") == 0) {cmd = END;}
     184:	58                   	pop    %eax
     185:	5a                   	pop    %edx
     186:	68 f2 17 00 00       	push   $0x17f2
     18b:	53                   	push   %ebx
     18c:	e8 ff 0d 00 00       	call   f90 <strcmp>
     191:	83 c4 10             	add    $0x10,%esp
     194:	85 c0                	test   %eax,%eax
     196:	0f 84 34 ff ff ff    	je     d0 <main+0xd0>
    else if (strcmp(cmdstr, "ADD<") == 0) {cmd = ADD;}
     19c:	50                   	push   %eax
     19d:	50                   	push   %eax
     19e:	68 f7 17 00 00       	push   $0x17f7
     1a3:	53                   	push   %ebx
     1a4:	e8 e7 0d 00 00       	call   f90 <strcmp>
     1a9:	83 c4 10             	add    $0x10,%esp
     1ac:	85 c0                	test   %eax,%eax
     1ae:	0f 84 1c ff ff ff    	je     d0 <main+0xd0>
    else if (strcmp(cmdstr, "DROP") == 0) {cmd = DROP;}
     1b4:	50                   	push   %eax
     1b5:	50                   	push   %eax
     1b6:	68 fc 17 00 00       	push   $0x17fc
     1bb:	53                   	push   %ebx
     1bc:	e8 cf 0d 00 00       	call   f90 <strcmp>
     1c1:	83 c4 10             	add    $0x10,%esp
     1c4:	85 c0                	test   %eax,%eax
     1c6:	0f 84 d4 00 00 00    	je     2a0 <main+0x2a0>
    else if (strcmp(cmdstr, "EDIT") == 0) {cmd = EDIT;}
     1cc:	50                   	push   %eax
     1cd:	50                   	push   %eax
     1ce:	68 01 18 00 00       	push   $0x1801
     1d3:	53                   	push   %ebx
     1d4:	e8 b7 0d 00 00       	call   f90 <strcmp>
     1d9:	83 c4 10             	add    $0x10,%esp
     1dc:	85 c0                	test   %eax,%eax
     1de:	0f 84 ec fe ff ff    	je     d0 <main+0xd0>
    else if (strcmp(cmdstr, "LIST") == 0) {cmd = LIST;}
     1e4:	50                   	push   %eax
     1e5:	50                   	push   %eax
     1e6:	68 06 18 00 00       	push   $0x1806
     1eb:	53                   	push   %ebx
     1ec:	e8 9f 0d 00 00       	call   f90 <strcmp>
     1f1:	83 c4 10             	add    $0x10,%esp
     1f4:	85 c0                	test   %eax,%eax
     1f6:	0f 84 be 00 00 00    	je     2ba <main+0x2ba>
    else if (strcmp(cmdstr, "SHOW") == 0) {cmd = SHOW;}
     1fc:	57                   	push   %edi
     1fd:	57                   	push   %edi
     1fe:	68 0b 18 00 00       	push   $0x180b
     203:	53                   	push   %ebx
     204:	e8 87 0d 00 00       	call   f90 <strcmp>
     209:	83 c4 10             	add    $0x10,%esp
     20c:	85 c0                	test   %eax,%eax
     20e:	0f 84 e2 00 00 00    	je     2f6 <main+0x2f6>
    else if (strcmp(cmdstr, "QUIT") == 0) {cmd = QUIT;}
     214:	56                   	push   %esi
     215:	56                   	push   %esi
     216:	68 10 18 00 00       	push   $0x1810
     21b:	53                   	push   %ebx
     21c:	e8 6f 0d 00 00       	call   f90 <strcmp>
     221:	83 c4 10             	add    $0x10,%esp
     224:	85 c0                	test   %eax,%eax
     226:	0f 85 b4 00 00 00    	jne    2e0 <main+0x2e0>
  close(file.fd);
     22c:	83 ec 0c             	sub    $0xc,%esp
     22f:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
     235:	e8 a0 0f 00 00       	call   11da <close>
  exit();
     23a:	e8 73 0f 00 00       	call   11b2 <exit>
    fprintf(2, "only specify one file");
     23f:	57                   	push   %edi
     240:	57                   	push   %edi
     241:	68 a2 17 00 00       	push   $0x17a2
     246:	6a 02                	push   $0x2
     248:	e8 d3 12 00 00       	call   1520 <fprintf>
    exit();
     24d:	e8 60 0f 00 00       	call   11b2 <exit>
    fprintf(2, "specify a file you want to edit");
     252:	50                   	push   %eax
     253:	50                   	push   %eax
     254:	68 d8 18 00 00       	push   $0x18d8
     259:	6a 02                	push   $0x2
     25b:	e8 c0 12 00 00       	call   1520 <fprintf>
    exit();
     260:	e8 4d 0f 00 00       	call   11b2 <exit>
    fprintf(2, "creating %s . . .\n",  file.filename);
     265:	57                   	push   %edi
     266:	ff b5 10 ff ff ff    	pushl  -0xf0(%ebp)
     26c:	68 cc 17 00 00       	push   $0x17cc
     271:	6a 02                	push   $0x2
     273:	e8 a8 12 00 00       	call   1520 <fprintf>
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     278:	58                   	pop    %eax
     279:	5a                   	pop    %edx
     27a:	68 01 02 00 00       	push   $0x201
     27f:	ff b5 10 ff ff ff    	pushl  -0xf0(%ebp)
     285:	e8 68 0f 00 00       	call   11f2 <open>
    close(file.fd);
     28a:	89 04 24             	mov    %eax,(%esp)
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     28d:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
    close(file.fd);
     293:	e8 42 0f 00 00       	call   11da <close>
     298:	83 c4 10             	add    $0x10,%esp
     29b:	e9 17 fe ff ff       	jmp    b7 <main+0xb7>
      drop(&file, args);
     2a0:	8d 45 84             	lea    -0x7c(%ebp),%eax
     2a3:	52                   	push   %edx
     2a4:	52                   	push   %edx
     2a5:	50                   	push   %eax
     2a6:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
     2ac:	50                   	push   %eax
     2ad:	e8 6e 09 00 00       	call   c20 <drop>
     2b2:	83 c4 10             	add    $0x10,%esp
     2b5:	e9 16 fe ff ff       	jmp    d0 <main+0xd0>
      list(file, args);
     2ba:	8d 45 84             	lea    -0x7c(%ebp),%eax
     2bd:	83 ec 0c             	sub    $0xc,%esp
     2c0:	8d b5 10 ff ff ff    	lea    -0xf0(%ebp),%esi
     2c6:	b9 04 00 00 00       	mov    $0x4,%ecx
     2cb:	50                   	push   %eax
     2cc:	83 ec 10             	sub    $0x10,%esp
     2cf:	89 e7                	mov    %esp,%edi
     2d1:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
     2d3:	e8 c8 07 00 00       	call   aa0 <list>
     2d8:	83 c4 20             	add    $0x20,%esp
     2db:	e9 f0 fd ff ff       	jmp    d0 <main+0xd0>
  fprintf(2, "bad bi input\n");
     2e0:	51                   	push   %ecx
     2e1:	51                   	push   %ecx
     2e2:	68 e8 16 00 00       	push   $0x16e8
     2e7:	6a 02                	push   $0x2
     2e9:	e8 32 12 00 00       	call   1520 <fprintf>
     2ee:	83 c4 10             	add    $0x10,%esp
     2f1:	e9 da fd ff ff       	jmp    d0 <main+0xd0>
     2f6:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
  int lineNum = 1;
     2fc:	bf 01 00 00 00       	mov    $0x1,%edi
  struct Node* curr = file.lines->head->next;
     301:	8b 10                	mov    (%eax),%edx
     303:	8b 72 08             	mov    0x8(%edx),%esi
     306:	eb 20                	jmp    328 <main+0x328>
     308:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
    printl(lineNum, curr->data);
     30e:	50                   	push   %eax
     30f:	50                   	push   %eax
     310:	ff 76 04             	pushl  0x4(%esi)
     313:	57                   	push   %edi
    lineNum++;
     314:	83 c7 01             	add    $0x1,%edi
    printl(lineNum, curr->data);
     317:	e8 94 0b 00 00       	call   eb0 <printl>
    curr = curr->next;
     31c:	8b 76 08             	mov    0x8(%esi),%esi
    lineNum++;
     31f:	8b 85 04 ff ff ff    	mov    -0xfc(%ebp),%eax
     325:	83 c4 10             	add    $0x10,%esp
  while (curr != file.lines->tail) {
     328:	3b 70 04             	cmp    0x4(%eax),%esi
     32b:	75 db                	jne    308 <main+0x308>
     32d:	e9 9e fd ff ff       	jmp    d0 <main+0xd0>
     332:	66 90                	xchg   %ax,%ax
     334:	66 90                	xchg   %ax,%ax
     336:	66 90                	xchg   %ax,%ax
     338:	66 90                	xchg   %ax,%ax
     33a:	66 90                	xchg   %ax,%ax
     33c:	66 90                	xchg   %ax,%ax
     33e:	66 90                	xchg   %ax,%ax

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
     388:	e8 63 12 00 00       	call   15f0 <malloc>
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
     43c:	e8 1f 11 00 00       	call   1560 <free>
    free(self);
     441:	89 5d 08             	mov    %ebx,0x8(%ebp)
     444:	83 c4 10             	add    $0x10,%esp
}
     447:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     44a:	c9                   	leave  
    free(self);
     44b:	e9 10 11 00 00       	jmp    1560 <free>

00000450 <MakeLinkedList>:

LinkedList* MakeLinkedList() {
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	56                   	push   %esi
     454:	53                   	push   %ebx
  struct LinkedList* list = malloc(sizeof(LinkedList));
     455:	83 ec 0c             	sub    $0xc,%esp
     458:	6a 0c                	push   $0xc
     45a:	e8 91 11 00 00       	call   15f0 <malloc>
  struct Node* node = malloc(sizeof(Node));
     45f:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  struct LinkedList* list = malloc(sizeof(LinkedList));
     466:	89 c6                	mov    %eax,%esi
  struct Node* node = malloc(sizeof(Node));
     468:	e8 83 11 00 00       	call   15f0 <malloc>
     46d:	89 c3                	mov    %eax,%ebx
  node->prev = nullptr;
     46f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->data = data;
     475:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  node->next = nullptr;
     47c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  struct Node* node = malloc(sizeof(Node));
     483:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     48a:	e8 61 11 00 00       	call   15f0 <malloc>
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
     4e1:	e8 0a 11 00 00       	call   15f0 <malloc>
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
     515:	e8 d6 10 00 00       	call   15f0 <malloc>

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
     583:	57                   	push   %edi
     584:	56                   	push   %esi
     585:	53                   	push   %ebx
     586:	83 ec 0c             	sub    $0xc,%esp
     589:	8b 75 08             	mov    0x8(%ebp),%esi
  struct Node* destroyer = list->head;
     58c:	8b 16                	mov    (%esi),%edx
  struct Node* traveler = destroyer->next;
  while (destroyer != list->tail) {
     58e:	8b 46 04             	mov    0x4(%esi),%eax
     591:	39 c2                	cmp    %eax,%edx
  struct Node* traveler = destroyer->next;
     593:	8b 5a 08             	mov    0x8(%edx),%ebx
  while (destroyer != list->tail) {
     596:	75 0a                	jne    5a2 <destroyLinkedList+0x22>
     598:	eb 28                	jmp    5c2 <destroyLinkedList+0x42>
     59a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    destroyer = traveler;
    traveler = traveler->next;
     5a0:	89 fb                	mov    %edi,%ebx
    free(destroyer->data);
     5a2:	83 ec 0c             	sub    $0xc,%esp
    traveler = traveler->next;
     5a5:	8b 7b 08             	mov    0x8(%ebx),%edi
    free(destroyer->data);
     5a8:	ff 73 04             	pushl  0x4(%ebx)
     5ab:	e8 b0 0f 00 00       	call   1560 <free>
    free(destroyer);
     5b0:	89 1c 24             	mov    %ebx,(%esp)
     5b3:	e8 a8 0f 00 00       	call   1560 <free>
  while (destroyer != list->tail) {
     5b8:	83 c4 10             	add    $0x10,%esp
     5bb:	39 5e 04             	cmp    %ebx,0x4(%esi)
     5be:	75 e0                	jne    5a0 <destroyLinkedList+0x20>
     5c0:	8b 06                	mov    (%esi),%eax
  }
  free(list->head);
     5c2:	83 ec 0c             	sub    $0xc,%esp
     5c5:	50                   	push   %eax
     5c6:	e8 95 0f 00 00       	call   1560 <free>
  free(list->tail);
     5cb:	58                   	pop    %eax
     5cc:	ff 76 04             	pushl  0x4(%esi)
     5cf:	e8 8c 0f 00 00       	call   1560 <free>
  free(list);
     5d4:	89 75 08             	mov    %esi,0x8(%ebp)
     5d7:	83 c4 10             	add    $0x10,%esp
     5da:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5dd:	5b                   	pop    %ebx
     5de:	5e                   	pop    %esi
     5df:	5f                   	pop    %edi
     5e0:	5d                   	pop    %ebp
  free(list);
     5e1:	e9 7a 0f 00 00       	jmp    1560 <free>
     5e6:	8d 76 00             	lea    0x0(%esi),%esi
     5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005f0 <end>:
void end(struct File* file, char* args) {
     5f0:	55                   	push   %ebp
     5f1:	89 e5                	mov    %esp,%ebp
}
     5f3:	5d                   	pop    %ebp
     5f4:	c3                   	ret    
     5f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     5f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000600 <add>:
     600:	55                   	push   %ebp
     601:	89 e5                	mov    %esp,%ebp
     603:	5d                   	pop    %ebp
     604:	c3                   	ret    
     605:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000610 <edit>:
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
     613:	5d                   	pop    %ebp
     614:	c3                   	ret    
     615:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000620 <quit>:
void quit(struct File file, char* args) {
     620:	55                   	push   %ebp
     621:	89 e5                	mov    %esp,%ebp
}
     623:	5d                   	pop    %ebp
     624:	c3                   	ret    
     625:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000630 <bi>:
void bi() {
     630:	55                   	push   %ebp
     631:	89 e5                	mov    %esp,%ebp
     633:	83 ec 10             	sub    $0x10,%esp
  fprintf(2, "bad bi input\n");
     636:	68 e8 16 00 00       	push   $0x16e8
     63b:	6a 02                	push   $0x2
     63d:	e8 de 0e 00 00       	call   1520 <fprintf>
}
     642:	83 c4 10             	add    $0x10,%esp
     645:	c9                   	leave  
     646:	c3                   	ret    
     647:	89 f6                	mov    %esi,%esi
     649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000650 <getLine>:
int getLine(int fileptr, char line[]) {
     650:	55                   	push   %ebp
     651:	89 e5                	mov    %esp,%ebp
     653:	57                   	push   %edi
     654:	56                   	push   %esi
     655:	53                   	push   %ebx
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     656:	31 ff                	xor    %edi,%edi
     658:	8d 75 e7             	lea    -0x19(%ebp),%esi
int getLine(int fileptr, char line[]) {
     65b:	83 ec 28             	sub    $0x28,%esp
     65e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int len = strlen(line);
     661:	53                   	push   %ebx
     662:	e8 79 09 00 00       	call   fe0 <strlen>
  memset(line, 0, len);
     667:	83 c4 0c             	add    $0xc,%esp
     66a:	50                   	push   %eax
     66b:	6a 00                	push   $0x0
     66d:	53                   	push   %ebx
     66e:	e8 9d 09 00 00       	call   1010 <memset>
     673:	83 c4 10             	add    $0x10,%esp
     676:	eb 1e                	jmp    696 <getLine+0x46>
     678:	90                   	nop
     679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (*c == '\n') break;
     680:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     684:	3c 0a                	cmp    $0xa,%al
     686:	74 38                	je     6c0 <getLine+0x70>
    line[i] = *c;
     688:	88 04 3b             	mov    %al,(%ebx,%edi,1)
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     68b:	83 c7 01             	add    $0x1,%edi
     68e:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
     694:	74 42                	je     6d8 <getLine+0x88>
    if (read(fileptr, c, 1) == 0) return strlen(line);
     696:	83 ec 04             	sub    $0x4,%esp
     699:	6a 01                	push   $0x1
     69b:	56                   	push   %esi
     69c:	ff 75 08             	pushl  0x8(%ebp)
     69f:	e8 26 0b 00 00       	call   11ca <read>
     6a4:	83 c4 10             	add    $0x10,%esp
     6a7:	85 c0                	test   %eax,%eax
     6a9:	75 d5                	jne    680 <getLine+0x30>
     6ab:	83 ec 0c             	sub    $0xc,%esp
     6ae:	53                   	push   %ebx
     6af:	e8 2c 09 00 00       	call   fe0 <strlen>
     6b4:	83 c4 10             	add    $0x10,%esp
}
     6b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6ba:	5b                   	pop    %ebx
     6bb:	5e                   	pop    %esi
     6bc:	5f                   	pop    %edi
     6bd:	5d                   	pop    %ebp
     6be:	c3                   	ret    
     6bf:	90                   	nop
     6c0:	8d 57 01             	lea    0x1(%edi),%edx
  line[i + 1] = '\0';
     6c3:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
     6c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
     6ca:	b8 01 00 00 00       	mov    $0x1,%eax
}
     6cf:	5b                   	pop    %ebx
     6d0:	5e                   	pop    %esi
     6d1:	5f                   	pop    %edi
     6d2:	5d                   	pop    %ebp
     6d3:	c3                   	ret    
     6d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     6d8:	ba e8 03 00 00       	mov    $0x3e8,%edx
     6dd:	eb e4                	jmp    6c3 <getLine+0x73>
     6df:	90                   	nop

000006e0 <gatherLines>:
void gatherLines(File* file) {
     6e0:	55                   	push   %ebp
     6e1:	89 e5                	mov    %esp,%ebp
     6e3:	56                   	push   %esi
     6e4:	53                   	push   %ebx
     6e5:	8d b5 10 fc ff ff    	lea    -0x3f0(%ebp),%esi
     6eb:	81 ec f0 03 00 00    	sub    $0x3f0,%esp
     6f1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while (getLine(file->fd, line)) {
     6f4:	eb 21                	jmp    717 <gatherLines+0x37>
     6f6:	8d 76 00             	lea    0x0(%esi),%esi
     6f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    append(file->lines, line);
     700:	8b 43 08             	mov    0x8(%ebx),%eax
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     703:	83 ec 04             	sub    $0x4,%esp
     706:	ff 70 08             	pushl  0x8(%eax)
     709:	56                   	push   %esi
     70a:	50                   	push   %eax
     70b:	e8 b0 fd ff ff       	call   4c0 <insert>
    file->len++;
     710:	83 43 0c 01          	addl   $0x1,0xc(%ebx)
     714:	83 c4 10             	add    $0x10,%esp
  while (getLine(file->fd, line)) {
     717:	83 ec 08             	sub    $0x8,%esp
     71a:	56                   	push   %esi
     71b:	ff 73 04             	pushl  0x4(%ebx)
     71e:	e8 2d ff ff ff       	call   650 <getLine>
     723:	83 c4 10             	add    $0x10,%esp
     726:	85 c0                	test   %eax,%eax
     728:	75 d6                	jne    700 <gatherLines+0x20>
  fprintf(2, "%d lines read from %s\n", file->len, file->filename);
     72a:	ff 33                	pushl  (%ebx)
     72c:	ff 73 0c             	pushl  0xc(%ebx)
     72f:	68 f6 16 00 00       	push   $0x16f6
     734:	6a 02                	push   $0x2
     736:	e8 e5 0d 00 00       	call   1520 <fprintf>
}
     73b:	83 c4 10             	add    $0x10,%esp
     73e:	8d 65 f8             	lea    -0x8(%ebp),%esp
     741:	5b                   	pop    %ebx
     742:	5e                   	pop    %esi
     743:	5d                   	pop    %ebp
     744:	c3                   	ret    
     745:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000750 <confirmation>:
int confirmation() {
     750:	55                   	push   %ebp
     751:	89 e5                	mov    %esp,%ebp
     753:	53                   	push   %ebx
  memset(buf, 0, nbuf);
     754:	8d 9d 10 fc ff ff    	lea    -0x3f0(%ebp),%ebx
int confirmation() {
     75a:	81 ec f8 03 00 00    	sub    $0x3f8,%esp
  memset(buf, 0, nbuf);
     760:	68 e8 03 00 00       	push   $0x3e8
     765:	6a 00                	push   $0x0
     767:	53                   	push   %ebx
     768:	e8 a3 08 00 00       	call   1010 <memset>
  gets(buf, nbuf);
     76d:	58                   	pop    %eax
     76e:	5a                   	pop    %edx
     76f:	68 e8 03 00 00       	push   $0x3e8
     774:	53                   	push   %ebx
     775:	e8 f6 08 00 00       	call   1070 <gets>
  switch (buf[0]) {
     77a:	0f b6 85 10 fc ff ff 	movzbl -0x3f0(%ebp),%eax
     781:	83 c4 10             	add    $0x10,%esp
     784:	3c 59                	cmp    $0x59,%al
     786:	74 18                	je     7a0 <confirmation+0x50>
     788:	3c 79                	cmp    $0x79,%al
     78a:	74 14                	je     7a0 <confirmation+0x50>
    return 1;
     78c:	b8 01 00 00 00       	mov    $0x1,%eax
}
     791:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     794:	c9                   	leave  
     795:	c3                   	ret    
     796:	8d 76 00             	lea    0x0(%esi),%esi
     799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return 0;
     7a0:	31 c0                	xor    %eax,%eax
}
     7a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7a5:	c9                   	leave  
     7a6:	c3                   	ret    
     7a7:	89 f6                	mov    %esi,%esi
     7a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007b0 <find>:
int find(char* str, char c) {
     7b0:	55                   	push   %ebp
     7b1:	89 e5                	mov    %esp,%ebp
     7b3:	57                   	push   %edi
     7b4:	56                   	push   %esi
     7b5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     7b6:	31 db                	xor    %ebx,%ebx
int find(char* str, char c) {
     7b8:	83 ec 0c             	sub    $0xc,%esp
     7bb:	8b 75 08             	mov    0x8(%ebp),%esi
     7be:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
  for (int i = 0; i < strlen(str); i++)
     7c2:	eb 0e                	jmp    7d2 <find+0x22>
     7c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     7c8:	89 f8                	mov    %edi,%eax
     7ca:	38 04 1e             	cmp    %al,(%esi,%ebx,1)
     7cd:	74 18                	je     7e7 <find+0x37>
  for (int i = 0; i < strlen(str); i++)
     7cf:	83 c3 01             	add    $0x1,%ebx
     7d2:	83 ec 0c             	sub    $0xc,%esp
     7d5:	56                   	push   %esi
     7d6:	e8 05 08 00 00       	call   fe0 <strlen>
     7db:	83 c4 10             	add    $0x10,%esp
     7de:	39 d8                	cmp    %ebx,%eax
     7e0:	77 e6                	ja     7c8 <find+0x18>
  return -1;
     7e2:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
     7e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7ea:	89 d8                	mov    %ebx,%eax
     7ec:	5b                   	pop    %ebx
     7ed:	5e                   	pop    %esi
     7ee:	5f                   	pop    %edi
     7ef:	5d                   	pop    %ebp
     7f0:	c3                   	ret    
     7f1:	eb 0d                	jmp    800 <substr>
     7f3:	90                   	nop
     7f4:	90                   	nop
     7f5:	90                   	nop
     7f6:	90                   	nop
     7f7:	90                   	nop
     7f8:	90                   	nop
     7f9:	90                   	nop
     7fa:	90                   	nop
     7fb:	90                   	nop
     7fc:	90                   	nop
     7fd:	90                   	nop
     7fe:	90                   	nop
     7ff:	90                   	nop

00000800 <substr>:
void substr(char* dest, char* str, int start, int end) {
     800:	55                   	push   %ebp
     801:	89 e5                	mov    %esp,%ebp
     803:	57                   	push   %edi
     804:	56                   	push   %esi
     805:	53                   	push   %ebx
     806:	83 ec 18             	sub    $0x18,%esp
     809:	8b 7d 14             	mov    0x14(%ebp),%edi
  int len = strlen(str);
     80c:	ff 75 0c             	pushl  0xc(%ebp)
void substr(char* dest, char* str, int start, int end) {
     80f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     812:	8b 75 08             	mov    0x8(%ebp),%esi
  int len = strlen(str);
     815:	e8 c6 07 00 00       	call   fe0 <strlen>
     81a:	83 c4 10             	add    $0x10,%esp
     81d:	39 f8                	cmp    %edi,%eax
     81f:	0f 4e f8             	cmovle %eax,%edi
  while (i < end)
     822:	39 df                	cmp    %ebx,%edi
     824:	7e 1c                	jle    842 <substr+0x42>
     826:	8b 45 0c             	mov    0xc(%ebp),%eax
     829:	29 df                	sub    %ebx,%edi
  int s = 0, i = start;
     82b:	31 d2                	xor    %edx,%edx
     82d:	01 c3                	add    %eax,%ebx
     82f:	90                   	nop
    dest[s++] = str[i++];
     830:	83 c2 01             	add    $0x1,%edx
     833:	0f b6 44 13 ff       	movzbl -0x1(%ebx,%edx,1),%eax
  while (i < end)
     838:	39 fa                	cmp    %edi,%edx
    dest[s++] = str[i++];
     83a:	88 44 16 ff          	mov    %al,-0x1(%esi,%edx,1)
  while (i < end)
     83e:	75 f0                	jne    830 <substr+0x30>
     840:	01 d6                	add    %edx,%esi
  dest[s] = '\0';
     842:	c6 06 00             	movb   $0x0,(%esi)
}
     845:	8d 65 f4             	lea    -0xc(%ebp),%esp
     848:	5b                   	pop    %ebx
     849:	5e                   	pop    %esi
     84a:	5f                   	pop    %edi
     84b:	5d                   	pop    %ebp
     84c:	c3                   	ret    
     84d:	8d 76 00             	lea    0x0(%esi),%esi

00000850 <getArg>:
void getArg(char* dest, char* args, char delimiter) {
     850:	55                   	push   %ebp
     851:	89 e5                	mov    %esp,%ebp
     853:	57                   	push   %edi
     854:	56                   	push   %esi
     855:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     856:	31 db                	xor    %ebx,%ebx
void getArg(char* dest, char* args, char delimiter) {
     858:	83 ec 1c             	sub    $0x1c,%esp
     85b:	8b 75 0c             	mov    0xc(%ebp),%esi
     85e:	0f b6 7d 10          	movzbl 0x10(%ebp),%edi
     862:	eb 10                	jmp    874 <getArg+0x24>
     864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     868:	89 f8                	mov    %edi,%eax
     86a:	3a 04 1e             	cmp    (%esi,%ebx,1),%al
     86d:	8d 53 01             	lea    0x1(%ebx),%edx
     870:	74 19                	je     88b <getArg+0x3b>
     872:	89 d3                	mov    %edx,%ebx
  for (int i = 0; i < strlen(str); i++)
     874:	83 ec 0c             	sub    $0xc,%esp
     877:	56                   	push   %esi
     878:	e8 63 07 00 00       	call   fe0 <strlen>
     87d:	83 c4 10             	add    $0x10,%esp
     880:	39 c3                	cmp    %eax,%ebx
     882:	72 e4                	jb     868 <getArg+0x18>
     884:	31 d2                	xor    %edx,%edx
  return -1;
     886:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  substr(dest, args, 0, end);
     88b:	53                   	push   %ebx
     88c:	6a 00                	push   $0x0
     88e:	56                   	push   %esi
     88f:	ff 75 08             	pushl  0x8(%ebp)
     892:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     895:	e8 66 ff ff ff       	call   800 <substr>
  substr(args, args, end + 1, (int) strlen(args));
     89a:	89 34 24             	mov    %esi,(%esp)
     89d:	e8 3e 07 00 00       	call   fe0 <strlen>
     8a2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     8a5:	50                   	push   %eax
     8a6:	52                   	push   %edx
     8a7:	56                   	push   %esi
     8a8:	56                   	push   %esi
     8a9:	e8 52 ff ff ff       	call   800 <substr>
}
     8ae:	83 c4 20             	add    $0x20,%esp
     8b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8b4:	5b                   	pop    %ebx
     8b5:	5e                   	pop    %esi
     8b6:	5f                   	pop    %edi
     8b7:	5d                   	pop    %ebp
     8b8:	c3                   	ret    
     8b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008c0 <collectRange>:
int collectRange(char* args, int* startptr, int* endptr) {
     8c0:	55                   	push   %ebp
     8c1:	89 e5                	mov    %esp,%ebp
     8c3:	57                   	push   %edi
     8c4:	56                   	push   %esi
     8c5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     8c6:	31 f6                	xor    %esi,%esi
int collectRange(char* args, int* startptr, int* endptr) {
     8c8:	83 ec 2c             	sub    $0x2c,%esp
     8cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
     8ce:	eb 09                	jmp    8d9 <collectRange+0x19>
    if (str[i] == c) return i;
     8d0:	80 3c 33 3a          	cmpb   $0x3a,(%ebx,%esi,1)
     8d4:	74 42                	je     918 <collectRange+0x58>
  for (int i = 0; i < strlen(str); i++)
     8d6:	83 c6 01             	add    $0x1,%esi
     8d9:	83 ec 0c             	sub    $0xc,%esp
     8dc:	53                   	push   %ebx
     8dd:	e8 fe 06 00 00       	call   fe0 <strlen>
     8e2:	83 c4 10             	add    $0x10,%esp
     8e5:	39 c6                	cmp    %eax,%esi
     8e7:	72 e7                	jb     8d0 <collectRange+0x10>
    if (args[0] == '-') {
     8e9:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     8ec:	0f 84 d6 00 00 00    	je     9c8 <collectRange+0x108>
      *startptr = atoi(args);
     8f2:	83 ec 0c             	sub    $0xc,%esp
     8f5:	53                   	push   %ebx
     8f6:	e8 45 08 00 00       	call   1140 <atoi>
     8fb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     8fe:	83 c4 10             	add    $0x10,%esp
     901:	89 01                	mov    %eax,(%ecx)
    *endptr = *startptr;
     903:	8b 4d 10             	mov    0x10(%ebp),%ecx
     906:	89 01                	mov    %eax,(%ecx)
    return 0;
     908:	31 c0                	xor    %eax,%eax
}
     90a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     90d:	5b                   	pop    %ebx
     90e:	5e                   	pop    %esi
     90f:	5f                   	pop    %edi
     910:	5d                   	pop    %ebp
     911:	c3                   	ret    
     912:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  getArg(startstr, args, ':');
     918:	8d 75 de             	lea    -0x22(%ebp),%esi
     91b:	83 ec 04             	sub    $0x4,%esp
     91e:	6a 3a                	push   $0x3a
     920:	53                   	push   %ebx
     921:	56                   	push   %esi
     922:	e8 29 ff ff ff       	call   850 <getArg>
  if (startstr[0] == '-') {
     927:	83 c4 10             	add    $0x10,%esp
     92a:	80 7d de 2d          	cmpb   $0x2d,-0x22(%ebp)
     92e:	0f 84 3c 01 00 00    	je     a70 <collectRange+0x1b0>
  int negStartFlag = 0, negEndFlag = 0;
     934:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     93b:	31 ff                	xor    %edi,%edi
  if (endstr[0] == '-') {
     93d:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     940:	0f 84 0a 01 00 00    	je     a50 <collectRange+0x190>
  if (strcmp(startstr, "\0") == 0) *startptr = 1;
     946:	83 ec 08             	sub    $0x8,%esp
     949:	68 15 18 00 00       	push   $0x1815
     94e:	56                   	push   %esi
     94f:	e8 3c 06 00 00       	call   f90 <strcmp>
     954:	83 c4 10             	add    $0x10,%esp
     957:	85 c0                	test   %eax,%eax
     959:	0f 85 d1 00 00 00    	jne    a30 <collectRange+0x170>
     95f:	8b 45 0c             	mov    0xc(%ebp),%eax
     962:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  if (strcmp(endstr, "\0") == 0) *endptr = -1;
     968:	83 ec 08             	sub    $0x8,%esp
     96b:	68 15 18 00 00       	push   $0x1815
     970:	53                   	push   %ebx
     971:	e8 1a 06 00 00       	call   f90 <strcmp>
     976:	83 c4 10             	add    $0x10,%esp
     979:	85 c0                	test   %eax,%eax
     97b:	0f 85 97 00 00 00    	jne    a18 <collectRange+0x158>
     981:	8b 45 10             	mov    0x10(%ebp),%eax
     984:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  if (negStartFlag) *startptr = 0 - *startptr;
     98a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     98d:	85 c0                	test   %eax,%eax
     98f:	74 05                	je     996 <collectRange+0xd6>
     991:	8b 45 0c             	mov    0xc(%ebp),%eax
     994:	f7 18                	negl   (%eax)
  if (negEndFlag) *endptr = 0 - *endptr;
     996:	85 ff                	test   %edi,%edi
     998:	74 05                	je     99f <collectRange+0xdf>
     99a:	8b 45 10             	mov    0x10(%ebp),%eax
     99d:	f7 18                	negl   (%eax)
  if (((*startptr > 0 && *endptr > 0) || 
     99f:	8b 45 0c             	mov    0xc(%ebp),%eax
     9a2:	8b 00                	mov    (%eax),%eax
     9a4:	83 f8 00             	cmp    $0x0,%eax
     9a7:	7e 4f                	jle    9f8 <collectRange+0x138>
     9a9:	8b 55 10             	mov    0x10(%ebp),%edx
     9ac:	8b 12                	mov    (%edx),%edx
     9ae:	85 d2                	test   %edx,%edx
     9b0:	7e 55                	jle    a07 <collectRange+0x147>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     9b2:	39 d0                	cmp    %edx,%eax
     9b4:	0f 9f c0             	setg   %al
}
     9b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     9ba:	0f b6 c0             	movzbl %al,%eax
}
     9bd:	5b                   	pop    %ebx
     9be:	5e                   	pop    %esi
     9bf:	5f                   	pop    %edi
     9c0:	5d                   	pop    %ebp
     9c1:	c3                   	ret    
     9c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      substr(args, args, 1, strlen(args));
     9c8:	83 ec 0c             	sub    $0xc,%esp
     9cb:	53                   	push   %ebx
     9cc:	e8 0f 06 00 00       	call   fe0 <strlen>
     9d1:	50                   	push   %eax
     9d2:	6a 01                	push   $0x1
     9d4:	53                   	push   %ebx
     9d5:	53                   	push   %ebx
     9d6:	e8 25 fe ff ff       	call   800 <substr>
      *startptr = 0 - atoi(args);
     9db:	83 c4 14             	add    $0x14,%esp
     9de:	53                   	push   %ebx
     9df:	e8 5c 07 00 00       	call   1140 <atoi>
     9e4:	8b 7d 0c             	mov    0xc(%ebp),%edi
     9e7:	f7 d8                	neg    %eax
     9e9:	83 c4 10             	add    $0x10,%esp
     9ec:	89 07                	mov    %eax,(%edi)
     9ee:	e9 10 ff ff ff       	jmp    903 <collectRange+0x43>
     9f3:	90                   	nop
     9f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (((*startptr > 0 && *endptr > 0) || 
     9f8:	0f 84 0c ff ff ff    	je     90a <collectRange+0x4a>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     9fe:	8b 7d 10             	mov    0x10(%ebp),%edi
     a01:	8b 17                	mov    (%edi),%edx
     a03:	85 d2                	test   %edx,%edx
     a05:	78 ab                	js     9b2 <collectRange+0xf2>
}
     a07:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
     a0a:	31 c0                	xor    %eax,%eax
}
     a0c:	5b                   	pop    %ebx
     a0d:	5e                   	pop    %esi
     a0e:	5f                   	pop    %edi
     a0f:	5d                   	pop    %ebp
     a10:	c3                   	ret    
     a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else *endptr = atoi(endstr);
     a18:	83 ec 0c             	sub    $0xc,%esp
     a1b:	53                   	push   %ebx
     a1c:	e8 1f 07 00 00       	call   1140 <atoi>
     a21:	8b 55 10             	mov    0x10(%ebp),%edx
     a24:	83 c4 10             	add    $0x10,%esp
     a27:	89 02                	mov    %eax,(%edx)
     a29:	e9 5c ff ff ff       	jmp    98a <collectRange+0xca>
     a2e:	66 90                	xchg   %ax,%ax
  else *startptr = atoi(startstr);
     a30:	83 ec 0c             	sub    $0xc,%esp
     a33:	56                   	push   %esi
     a34:	e8 07 07 00 00       	call   1140 <atoi>
     a39:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     a3c:	83 c4 10             	add    $0x10,%esp
     a3f:	89 01                	mov    %eax,(%ecx)
     a41:	e9 22 ff ff ff       	jmp    968 <collectRange+0xa8>
     a46:	8d 76 00             	lea    0x0(%esi),%esi
     a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    substr(endstr, endstr, 1, strlen(endstr));
     a50:	83 ec 0c             	sub    $0xc,%esp
    negEndFlag = 1;
     a53:	bf 01 00 00 00       	mov    $0x1,%edi
    substr(endstr, endstr, 1, strlen(endstr));
     a58:	53                   	push   %ebx
     a59:	e8 82 05 00 00       	call   fe0 <strlen>
     a5e:	50                   	push   %eax
     a5f:	6a 01                	push   $0x1
     a61:	53                   	push   %ebx
     a62:	53                   	push   %ebx
     a63:	e8 98 fd ff ff       	call   800 <substr>
     a68:	83 c4 20             	add    $0x20,%esp
     a6b:	e9 d6 fe ff ff       	jmp    946 <collectRange+0x86>
    substr(startstr, startstr, 1, strlen(startstr));
     a70:	83 ec 0c             	sub    $0xc,%esp
     a73:	56                   	push   %esi
     a74:	e8 67 05 00 00       	call   fe0 <strlen>
     a79:	50                   	push   %eax
     a7a:	6a 01                	push   $0x1
     a7c:	56                   	push   %esi
     a7d:	56                   	push   %esi
     a7e:	e8 7d fd ff ff       	call   800 <substr>
     a83:	83 c4 20             	add    $0x20,%esp
    negStartFlag = 1;
     a86:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
     a8d:	e9 a9 fe ff ff       	jmp    93b <collectRange+0x7b>
     a92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000aa0 <list>:
void list(struct File file, char* args) {
     aa0:	55                   	push   %ebp
     aa1:	89 e5                	mov    %esp,%ebp
     aa3:	57                   	push   %edi
     aa4:	56                   	push   %esi
     aa5:	53                   	push   %ebx
     aa6:	83 ec 28             	sub    $0x28,%esp
     aa9:	8b 5d 18             	mov    0x18(%ebp),%ebx
     aac:	8b 75 10             	mov    0x10(%ebp),%esi
  if (strlen(args) < 1) {
     aaf:	53                   	push   %ebx
     ab0:	e8 2b 05 00 00       	call   fe0 <strlen>
     ab5:	83 c4 10             	add    $0x10,%esp
     ab8:	85 c0                	test   %eax,%eax
     aba:	75 24                	jne    ae0 <list+0x40>
    fprintf(2, "you need to give a range to list\n");
     abc:	83 ec 08             	sub    $0x8,%esp
     abf:	68 18 18 00 00       	push   $0x1818
     ac4:	6a 02                	push   $0x2
     ac6:	e8 55 0a 00 00       	call   1520 <fprintf>
    return;
     acb:	83 c4 10             	add    $0x10,%esp
}
     ace:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ad1:	5b                   	pop    %ebx
     ad2:	5e                   	pop    %esi
     ad3:	5f                   	pop    %edi
     ad4:	5d                   	pop    %ebp
     ad5:	c3                   	ret    
     ad6:	8d 76 00             	lea    0x0(%esi),%esi
     ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if (collectRange(args, &start, &end) == 1) {
     ae0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     ae3:	83 ec 04             	sub    $0x4,%esp
     ae6:	50                   	push   %eax
     ae7:	8d 45 e0             	lea    -0x20(%ebp),%eax
     aea:	50                   	push   %eax
     aeb:	53                   	push   %ebx
     aec:	e8 cf fd ff ff       	call   8c0 <collectRange>
     af1:	83 c4 10             	add    $0x10,%esp
     af4:	83 f8 01             	cmp    $0x1,%eax
     af7:	0f 84 93 00 00 00    	je     b90 <list+0xf0>
  str[len] = '\0';
}

// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
  return nodeAt(list, pos-1);
     afd:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b00:	83 ec 08             	sub    $0x8,%esp
     b03:	83 e8 01             	sub    $0x1,%eax
     b06:	50                   	push   %eax
     b07:	56                   	push   %esi
     b08:	e8 a3 f8 ff ff       	call   3b0 <nodeAt>
  struct Node* curNode = (lineAt(file.lines, start))->prev;
     b0d:	8b 18                	mov    (%eax),%ebx
  return nodeAt(list, pos-1);
     b0f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b12:	5f                   	pop    %edi
     b13:	5a                   	pop    %edx
     b14:	83 e8 01             	sub    $0x1,%eax
     b17:	50                   	push   %eax
     b18:	56                   	push   %esi
     b19:	e8 92 f8 ff ff       	call   3b0 <nodeAt>
     b1e:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
     b21:	39 d8                	cmp    %ebx,%eax
  return nodeAt(list, pos-1);
     b23:	89 c7                	mov    %eax,%edi
  while (curNode != stopNode) {
     b25:	74 a7                	je     ace <list+0x2e>
    curNode = curNode->next;
     b27:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) {
     b2a:	3b 5e 04             	cmp    0x4(%esi),%ebx
     b2d:	74 22                	je     b51 <list+0xb1>
     b2f:	90                   	nop
    fprintf(2, "%s\n", curNode->data);
     b30:	83 ec 04             	sub    $0x4,%esp
     b33:	ff 73 04             	pushl  0x4(%ebx)
     b36:	68 ee 17 00 00       	push   $0x17ee
     b3b:	6a 02                	push   $0x2
     b3d:	e8 de 09 00 00       	call   1520 <fprintf>
  while (curNode != stopNode) {
     b42:	83 c4 10             	add    $0x10,%esp
     b45:	39 df                	cmp    %ebx,%edi
     b47:	74 85                	je     ace <list+0x2e>
    curNode = curNode->next;
     b49:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) {
     b4c:	39 5e 04             	cmp    %ebx,0x4(%esi)
     b4f:	75 df                	jne    b30 <list+0x90>
      fprintf(2, "________________________________\n");
     b51:	83 ec 08             	sub    $0x8,%esp
     b54:	68 6c 18 00 00       	push   $0x186c
     b59:	6a 02                	push   $0x2
     b5b:	e8 c0 09 00 00       	call   1520 <fprintf>
      fprintf(2, "make sure start is less than end\n");
     b60:	58                   	pop    %eax
     b61:	5a                   	pop    %edx
     b62:	68 90 18 00 00       	push   $0x1890
     b67:	6a 02                	push   $0x2
     b69:	e8 b2 09 00 00       	call   1520 <fprintf>
      fprintf(2, "printed till EOF\n");
     b6e:	59                   	pop    %ecx
     b6f:	5b                   	pop    %ebx
     b70:	68 0d 17 00 00       	push   $0x170d
     b75:	6a 02                	push   $0x2
     b77:	e8 a4 09 00 00       	call   1520 <fprintf>
      return;
     b7c:	83 c4 10             	add    $0x10,%esp
}
     b7f:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b82:	5b                   	pop    %ebx
     b83:	5e                   	pop    %esi
     b84:	5f                   	pop    %edi
     b85:	5d                   	pop    %ebp
     b86:	c3                   	ret    
     b87:	89 f6                	mov    %esi,%esi
     b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    fprintf(2, "error: start index is larger than end index\n");
     b90:	83 ec 08             	sub    $0x8,%esp
     b93:	68 3c 18 00 00       	push   $0x183c
     b98:	6a 02                	push   $0x2
     b9a:	e8 81 09 00 00       	call   1520 <fprintf>
    return;
     b9f:	83 c4 10             	add    $0x10,%esp
}
     ba2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ba5:	5b                   	pop    %ebx
     ba6:	5e                   	pop    %esi
     ba7:	5f                   	pop    %edi
     ba8:	5d                   	pop    %ebp
     ba9:	c3                   	ret    
     baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000bb0 <normalizeRange>:
int normalizeRange(File file, int* sp, int* ep) {
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	53                   	push   %ebx
     bb4:	8b 4d 1c             	mov    0x1c(%ebp),%ecx
  int l = file.len;
     bb7:	8b 45 14             	mov    0x14(%ebp),%eax
int normalizeRange(File file, int* sp, int* ep) {
     bba:	8b 5d 18             	mov    0x18(%ebp),%ebx
  if (*ep > l) *ep = l;
     bbd:	8b 11                	mov    (%ecx),%edx
     bbf:	39 c2                	cmp    %eax,%edx
     bc1:	7e 45                	jle    c08 <normalizeRange+0x58>
     bc3:	89 01                	mov    %eax,(%ecx)
     bc5:	89 c2                	mov    %eax,%edx
  if (*ep < 1) *ep = 1;
     bc7:	85 d2                	test   %edx,%edx
     bc9:	7f 06                	jg     bd1 <normalizeRange+0x21>
     bcb:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)
  if (*sp > l) *sp = l;
     bd1:	8b 13                	mov    (%ebx),%edx
     bd3:	39 c2                	cmp    %eax,%edx
     bd5:	7e 21                	jle    bf8 <normalizeRange+0x48>
     bd7:	89 03                	mov    %eax,(%ebx)
     bd9:	89 c2                	mov    %eax,%edx
  if (*sp < 1) *sp = 1;
     bdb:	85 d2                	test   %edx,%edx
     bdd:	7f 0b                	jg     bea <normalizeRange+0x3a>
     bdf:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
     be5:	ba 01 00 00 00       	mov    $0x1,%edx
  if ((*ep - *sp) < 0)
     bea:	8b 01                	mov    (%ecx),%eax
}
     bec:	5b                   	pop    %ebx
     bed:	5d                   	pop    %ebp
  if ((*ep - *sp) < 0)
     bee:	29 d0                	sub    %edx,%eax
     bf0:	c1 e8 1f             	shr    $0x1f,%eax
}
     bf3:	c3                   	ret    
     bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*sp < 1) *sp += l + 1;
     bf8:	85 d2                	test   %edx,%edx
     bfa:	7f ee                	jg     bea <normalizeRange+0x3a>
     bfc:	8d 54 10 01          	lea    0x1(%eax,%edx,1),%edx
     c00:	89 13                	mov    %edx,(%ebx)
     c02:	eb d7                	jmp    bdb <normalizeRange+0x2b>
     c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*ep < 1) *ep += l + 1;
     c08:	85 d2                	test   %edx,%edx
     c0a:	7f c5                	jg     bd1 <normalizeRange+0x21>
     c0c:	8d 54 02 01          	lea    0x1(%edx,%eax,1),%edx
     c10:	89 11                	mov    %edx,(%ecx)
     c12:	eb b3                	jmp    bc7 <normalizeRange+0x17>
     c14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     c1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000c20 <drop>:
void drop(struct File* file, char* args) {
     c20:	55                   	push   %ebp
     c21:	89 e5                	mov    %esp,%ebp
     c23:	57                   	push   %edi
     c24:	56                   	push   %esi
     c25:	53                   	push   %ebx
     c26:	83 ec 28             	sub    $0x28,%esp
  if (strlen(args) < 1) {
     c29:	ff 75 0c             	pushl  0xc(%ebp)
void drop(struct File* file, char* args) {
     c2c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (strlen(args) < 1) {
     c2f:	e8 ac 03 00 00       	call   fe0 <strlen>
     c34:	83 c4 10             	add    $0x10,%esp
     c37:	85 c0                	test   %eax,%eax
     c39:	0f 84 81 00 00 00    	je     cc0 <drop+0xa0>
  if (collectRange(args, &start, &end) == 1) {
     c3f:	8d 75 e4             	lea    -0x1c(%ebp),%esi
     c42:	8d 7d e0             	lea    -0x20(%ebp),%edi
     c45:	83 ec 04             	sub    $0x4,%esp
     c48:	56                   	push   %esi
     c49:	57                   	push   %edi
     c4a:	ff 75 0c             	pushl  0xc(%ebp)
     c4d:	e8 6e fc ff ff       	call   8c0 <collectRange>
     c52:	83 c4 10             	add    $0x10,%esp
     c55:	83 f8 01             	cmp    $0x1,%eax
     c58:	0f 84 82 00 00 00    	je     ce0 <drop+0xc0>
  if (normalizeRange(*file, &start, &end) == 1) {
     c5e:	83 ec 08             	sub    $0x8,%esp
     c61:	56                   	push   %esi
     c62:	57                   	push   %edi
     c63:	ff 73 0c             	pushl  0xc(%ebx)
     c66:	ff 73 08             	pushl  0x8(%ebx)
     c69:	ff 73 04             	pushl  0x4(%ebx)
     c6c:	ff 33                	pushl  (%ebx)
     c6e:	e8 3d ff ff ff       	call   bb0 <normalizeRange>
     c73:	83 c4 20             	add    $0x20,%esp
     c76:	83 f8 01             	cmp    $0x1,%eax
     c79:	0f 84 21 01 00 00    	je     da0 <drop+0x180>
  int numl = numLines(start, end);
     c7f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     c82:	8b 55 e0             	mov    -0x20(%ebp),%edx
  return (end - start) + 1;
     c85:	89 c8                	mov    %ecx,%eax
     c87:	29 d0                	sub    %edx,%eax
     c89:	83 c0 01             	add    $0x1,%eax
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
     c8c:	83 f8 01             	cmp    $0x1,%eax
     c8f:	0f 84 eb 00 00 00    	je     d80 <drop+0x160>
  else fprintf(2, "Drop %d lines [%d:%d] (y/n)? ", numl, start, end);
     c95:	83 ec 0c             	sub    $0xc,%esp
     c98:	51                   	push   %ecx
     c99:	52                   	push   %edx
     c9a:	50                   	push   %eax
     c9b:	68 4c 17 00 00       	push   $0x174c
     ca0:	6a 02                	push   $0x2
     ca2:	e8 79 08 00 00       	call   1520 <fprintf>
     ca7:	83 c4 20             	add    $0x20,%esp
  if (confirmation() != 0) return;
     caa:	e8 a1 fa ff ff       	call   750 <confirmation>
     caf:	85 c0                	test   %eax,%eax
     cb1:	74 4d                	je     d00 <drop+0xe0>
}
     cb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cb6:	5b                   	pop    %ebx
     cb7:	5e                   	pop    %esi
     cb8:	5f                   	pop    %edi
     cb9:	5d                   	pop    %ebp
     cba:	c3                   	ret    
     cbb:	90                   	nop
     cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "you need to give a range to drop\n");
     cc0:	83 ec 08             	sub    $0x8,%esp
     cc3:	68 b4 18 00 00       	push   $0x18b4
     cc8:	6a 02                	push   $0x2
     cca:	e8 51 08 00 00       	call   1520 <fprintf>
    return;
     ccf:	83 c4 10             	add    $0x10,%esp
}
     cd2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cd5:	5b                   	pop    %ebx
     cd6:	5e                   	pop    %esi
     cd7:	5f                   	pop    %edi
     cd8:	5d                   	pop    %ebp
     cd9:	c3                   	ret    
     cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: start index is larger than end index\n");
     ce0:	83 ec 08             	sub    $0x8,%esp
     ce3:	68 3c 18 00 00       	push   $0x183c
     ce8:	6a 02                	push   $0x2
     cea:	e8 31 08 00 00       	call   1520 <fprintf>
     cef:	83 c4 10             	add    $0x10,%esp
}
     cf2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cf5:	5b                   	pop    %ebx
     cf6:	5e                   	pop    %esi
     cf7:	5f                   	pop    %edi
     cf8:	5d                   	pop    %ebp
     cf9:	c3                   	ret    
     cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  fprintf(2, "dropping...\n");
     d00:	83 ec 08             	sub    $0x8,%esp
     d03:	68 6a 17 00 00       	push   $0x176a
     d08:	6a 02                	push   $0x2
     d0a:	e8 11 08 00 00       	call   1520 <fprintf>
  return nodeAt(list, pos-1);
     d0f:	58                   	pop    %eax
     d10:	8b 45 e0             	mov    -0x20(%ebp),%eax
  struct Node* curNode = (lineAt(file->lines, start))->prev;
     d13:	8b 7b 08             	mov    0x8(%ebx),%edi
  return nodeAt(list, pos-1);
     d16:	5a                   	pop    %edx
     d17:	83 e8 01             	sub    $0x1,%eax
     d1a:	50                   	push   %eax
     d1b:	57                   	push   %edi
     d1c:	e8 8f f6 ff ff       	call   3b0 <nodeAt>
     d21:	59                   	pop    %ecx
     d22:	5e                   	pop    %esi
  struct Node* curNode = (lineAt(file->lines, start))->prev;
     d23:	8b 30                	mov    (%eax),%esi
  return nodeAt(list, pos-1);
     d25:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d28:	83 e8 01             	sub    $0x1,%eax
     d2b:	50                   	push   %eax
     d2c:	57                   	push   %edi
     d2d:	e8 7e f6 ff ff       	call   3b0 <nodeAt>
     d32:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
     d35:	39 c6                	cmp    %eax,%esi
  return nodeAt(list, pos-1);
     d37:	89 c7                	mov    %eax,%edi
  while (curNode != stopNode) {
     d39:	0f 84 81 00 00 00    	je     dc0 <drop+0x1a0>
     d3f:	90                   	nop
    curNode = curNode->next;
     d40:	8b 76 08             	mov    0x8(%esi),%esi
    destroyNode(curNode);
     d43:	83 ec 0c             	sub    $0xc,%esp
     d46:	56                   	push   %esi
     d47:	e8 d4 f6 ff ff       	call   420 <destroyNode>
    file->len--;
     d4c:	8b 43 0c             	mov    0xc(%ebx),%eax
  while (curNode != stopNode) {
     d4f:	83 c4 10             	add    $0x10,%esp
    file->len--;
     d52:	83 e8 01             	sub    $0x1,%eax
  while (curNode != stopNode) {
     d55:	39 f7                	cmp    %esi,%edi
    file->len--;
     d57:	89 43 0c             	mov    %eax,0xc(%ebx)
  while (curNode != stopNode) {
     d5a:	75 e4                	jne    d40 <drop+0x120>
  fprintf(2, "file->len = %d\n", file->len);
     d5c:	83 ec 04             	sub    $0x4,%esp
     d5f:	50                   	push   %eax
     d60:	68 77 17 00 00       	push   $0x1777
     d65:	6a 02                	push   $0x2
     d67:	e8 b4 07 00 00       	call   1520 <fprintf>
     d6c:	83 c4 10             	add    $0x10,%esp
}
     d6f:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d72:	5b                   	pop    %ebx
     d73:	5e                   	pop    %esi
     d74:	5f                   	pop    %edi
     d75:	5d                   	pop    %ebp
     d76:	c3                   	ret    
     d77:	89 f6                	mov    %esi,%esi
     d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
     d80:	83 ec 04             	sub    $0x4,%esp
     d83:	52                   	push   %edx
     d84:	68 37 17 00 00       	push   $0x1737
     d89:	6a 02                	push   $0x2
     d8b:	e8 90 07 00 00       	call   1520 <fprintf>
     d90:	83 c4 10             	add    $0x10,%esp
     d93:	e9 12 ff ff ff       	jmp    caa <drop+0x8a>
     d98:	90                   	nop
     d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "error: bad input range\n");
     da0:	83 ec 08             	sub    $0x8,%esp
     da3:	68 1f 17 00 00       	push   $0x171f
     da8:	6a 02                	push   $0x2
     daa:	e8 71 07 00 00       	call   1520 <fprintf>
     daf:	83 c4 10             	add    $0x10,%esp
     db2:	e9 fc fe ff ff       	jmp    cb3 <drop+0x93>
     db7:	89 f6                	mov    %esi,%esi
     db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     dc0:	8b 43 0c             	mov    0xc(%ebx),%eax
     dc3:	eb 97                	jmp    d5c <drop+0x13c>
     dc5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000dd0 <numLines>:
int numLines(int start, int end) {
     dd0:	55                   	push   %ebp
     dd1:	89 e5                	mov    %esp,%ebp
  return (end - start) + 1;
     dd3:	8b 45 0c             	mov    0xc(%ebp),%eax
     dd6:	2b 45 08             	sub    0x8(%ebp),%eax
}
     dd9:	5d                   	pop    %ebp
  return (end - start) + 1;
     dda:	83 c0 01             	add    $0x1,%eax
}
     ddd:	c3                   	ret    
     dde:	66 90                	xchg   %ax,%ax

00000de0 <toUpper>:
void toUpper(char* str) {
     de0:	55                   	push   %ebp
     de1:	89 e5                	mov    %esp,%ebp
     de3:	8b 55 08             	mov    0x8(%ebp),%edx
  while (str[i] != '\0') {
     de6:	0f b6 02             	movzbl (%edx),%eax
     de9:	84 c0                	test   %al,%al
     deb:	74 1a                	je     e07 <toUpper+0x27>
     ded:	8d 76 00             	lea    0x0(%esi),%esi
    if (c <= 'z' && c >= 'a')
     df0:	8d 48 9f             	lea    -0x61(%eax),%ecx
     df3:	80 f9 19             	cmp    $0x19,%cl
     df6:	77 05                	ja     dfd <toUpper+0x1d>
      str[i] += ('Z' - 'z');
     df8:	83 e8 20             	sub    $0x20,%eax
     dfb:	88 02                	mov    %al,(%edx)
     dfd:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     e00:	0f b6 02             	movzbl (%edx),%eax
     e03:	84 c0                	test   %al,%al
     e05:	75 e9                	jne    df0 <toUpper+0x10>
}
     e07:	5d                   	pop    %ebp
     e08:	c3                   	ret    
     e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000e10 <toLower>:
void toLower(char* str) {
     e10:	55                   	push   %ebp
     e11:	89 e5                	mov    %esp,%ebp
     e13:	8b 55 08             	mov    0x8(%ebp),%edx
  while (str[i] != '\0') {
     e16:	0f b6 02             	movzbl (%edx),%eax
     e19:	84 c0                	test   %al,%al
     e1b:	74 1a                	je     e37 <toLower+0x27>
     e1d:	8d 76 00             	lea    0x0(%esi),%esi
    if (c <= 'Z' && c >= 'A')
     e20:	8d 48 bf             	lea    -0x41(%eax),%ecx
     e23:	80 f9 19             	cmp    $0x19,%cl
     e26:	77 05                	ja     e2d <toLower+0x1d>
      str[i] -= ('Z' - 'z');
     e28:	83 c0 20             	add    $0x20,%eax
     e2b:	88 02                	mov    %al,(%edx)
     e2d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     e30:	0f b6 02             	movzbl (%edx),%eax
     e33:	84 c0                	test   %al,%al
     e35:	75 e9                	jne    e20 <toLower+0x10>
}
     e37:	5d                   	pop    %ebp
     e38:	c3                   	ret    
     e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000e40 <unline>:
void unline(char* str) {
     e40:	55                   	push   %ebp
     e41:	89 e5                	mov    %esp,%ebp
     e43:	53                   	push   %ebx
     e44:	83 ec 10             	sub    $0x10,%esp
     e47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str) - 1;
     e4a:	53                   	push   %ebx
     e4b:	e8 90 01 00 00       	call   fe0 <strlen>
     e50:	8d 50 ff             	lea    -0x1(%eax),%edx
  for (; len > 0; len--) {
     e53:	83 c4 10             	add    $0x10,%esp
     e56:	85 d2                	test   %edx,%edx
     e58:	7e 36                	jle    e90 <unline+0x50>
    if (c == '\n')
     e5a:	80 7c 03 ff 0a       	cmpb   $0xa,-0x1(%ebx,%eax,1)
     e5f:	74 2f                	je     e90 <unline+0x50>
     e61:	8d 44 03 fe          	lea    -0x2(%ebx,%eax,1),%eax
     e65:	eb 12                	jmp    e79 <unline+0x39>
     e67:	89 f6                	mov    %esi,%esi
     e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     e70:	83 e8 01             	sub    $0x1,%eax
     e73:	80 78 01 0a          	cmpb   $0xa,0x1(%eax)
     e77:	74 06                	je     e7f <unline+0x3f>
  for (; len > 0; len--) {
     e79:	39 c3                	cmp    %eax,%ebx
     e7b:	89 c2                	mov    %eax,%edx
     e7d:	75 f1                	jne    e70 <unline+0x30>
  str[len] = '\0';
     e7f:	c6 02 00             	movb   $0x0,(%edx)
}
     e82:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e85:	c9                   	leave  
     e86:	c3                   	ret    
     e87:	89 f6                	mov    %esi,%esi
     e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     e90:	01 da                	add    %ebx,%edx
  str[len] = '\0';
     e92:	c6 02 00             	movb   $0x0,(%edx)
}
     e95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e98:	c9                   	leave  
     e99:	c3                   	ret    
     e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000ea0 <lineAt>:
Node* lineAt(struct LinkedList* list, int pos) {
     ea0:	55                   	push   %ebp
     ea1:	89 e5                	mov    %esp,%ebp
  return nodeAt(list, pos-1);
     ea3:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
}
     ea7:	5d                   	pop    %ebp
  return nodeAt(list, pos-1);
     ea8:	e9 03 f5 ff ff       	jmp    3b0 <nodeAt>
     ead:	8d 76 00             	lea    0x0(%esi),%esi

00000eb0 <printl>:

void printl(int lineNum, char* line) {
     eb0:	55                   	push   %ebp
     eb1:	89 e5                	mov    %esp,%ebp
     eb3:	83 ec 08             	sub    $0x8,%esp
     eb6:	8b 45 08             	mov    0x8(%ebp),%eax
  if (lineNum < 10)
     eb9:	83 f8 09             	cmp    $0x9,%eax
     ebc:	7e 3a                	jle    ef8 <printl+0x48>
    fprintf(2, "%d  | %s\n", lineNum, line);
  else if (lineNum < 100)
     ebe:	83 f8 63             	cmp    $0x63,%eax
     ec1:	7e 1d                	jle    ee0 <printl+0x30>
    fprintf(2, "%d | %s\n", lineNum, line);
  else
    fprintf(2, "%d| %s\n", lineNum, line);
     ec3:	ff 75 0c             	pushl  0xc(%ebp)
     ec6:	50                   	push   %eax
     ec7:	68 9a 17 00 00       	push   $0x179a
     ecc:	6a 02                	push   $0x2
     ece:	e8 4d 06 00 00       	call   1520 <fprintf>
     ed3:	83 c4 10             	add    $0x10,%esp
     ed6:	c9                   	leave  
     ed7:	c3                   	ret    
     ed8:	90                   	nop
     ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "%d | %s\n", lineNum, line);
     ee0:	ff 75 0c             	pushl  0xc(%ebp)
     ee3:	50                   	push   %eax
     ee4:	68 91 17 00 00       	push   $0x1791
     ee9:	6a 02                	push   $0x2
     eeb:	e8 30 06 00 00       	call   1520 <fprintf>
     ef0:	83 c4 10             	add    $0x10,%esp
     ef3:	c9                   	leave  
     ef4:	c3                   	ret    
     ef5:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "%d  | %s\n", lineNum, line);
     ef8:	ff 75 0c             	pushl  0xc(%ebp)
     efb:	50                   	push   %eax
     efc:	68 87 17 00 00       	push   $0x1787
     f01:	6a 02                	push   $0x2
     f03:	e8 18 06 00 00       	call   1520 <fprintf>
     f08:	83 c4 10             	add    $0x10,%esp
     f0b:	c9                   	leave  
     f0c:	c3                   	ret    
     f0d:	8d 76 00             	lea    0x0(%esi),%esi

00000f10 <show>:
void show(struct File file, char* args) {
     f10:	55                   	push   %ebp
     f11:	89 e5                	mov    %esp,%ebp
     f13:	57                   	push   %edi
     f14:	56                   	push   %esi
     f15:	53                   	push   %ebx
     f16:	83 ec 0c             	sub    $0xc,%esp
     f19:	8b 7d 10             	mov    0x10(%ebp),%edi
  struct Node* curr = file.lines->head->next;
     f1c:	8b 07                	mov    (%edi),%eax
     f1e:	8b 58 08             	mov    0x8(%eax),%ebx
  while (curr != file.lines->tail) {
     f21:	3b 5f 04             	cmp    0x4(%edi),%ebx
     f24:	74 24                	je     f4a <show+0x3a>
  int lineNum = 1;
     f26:	be 01 00 00 00       	mov    $0x1,%esi
     f2b:	90                   	nop
     f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printl(lineNum, curr->data);
     f30:	83 ec 08             	sub    $0x8,%esp
     f33:	ff 73 04             	pushl  0x4(%ebx)
     f36:	56                   	push   %esi
    lineNum++;
     f37:	83 c6 01             	add    $0x1,%esi
    printl(lineNum, curr->data);
     f3a:	e8 71 ff ff ff       	call   eb0 <printl>
    curr = curr->next;
     f3f:	8b 5b 08             	mov    0x8(%ebx),%ebx
  while (curr != file.lines->tail) {
     f42:	83 c4 10             	add    $0x10,%esp
     f45:	39 5f 04             	cmp    %ebx,0x4(%edi)
     f48:	75 e6                	jne    f30 <show+0x20>
}
     f4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f4d:	5b                   	pop    %ebx
     f4e:	5e                   	pop    %esi
     f4f:	5f                   	pop    %edi
     f50:	5d                   	pop    %ebp
     f51:	c3                   	ret    
     f52:	66 90                	xchg   %ax,%ax
     f54:	66 90                	xchg   %ax,%ax
     f56:	66 90                	xchg   %ax,%ax
     f58:	66 90                	xchg   %ax,%ax
     f5a:	66 90                	xchg   %ax,%ax
     f5c:	66 90                	xchg   %ax,%ax
     f5e:	66 90                	xchg   %ax,%ax

00000f60 <strcpy>:
     f60:	55                   	push   %ebp
     f61:	89 e5                	mov    %esp,%ebp
     f63:	53                   	push   %ebx
     f64:	8b 45 08             	mov    0x8(%ebp),%eax
     f67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     f6a:	89 c2                	mov    %eax,%edx
     f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f70:	83 c1 01             	add    $0x1,%ecx
     f73:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     f77:	83 c2 01             	add    $0x1,%edx
     f7a:	84 db                	test   %bl,%bl
     f7c:	88 5a ff             	mov    %bl,-0x1(%edx)
     f7f:	75 ef                	jne    f70 <strcpy+0x10>
     f81:	5b                   	pop    %ebx
     f82:	5d                   	pop    %ebp
     f83:	c3                   	ret    
     f84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000f90 <strcmp>:
     f90:	55                   	push   %ebp
     f91:	89 e5                	mov    %esp,%ebp
     f93:	53                   	push   %ebx
     f94:	8b 55 08             	mov    0x8(%ebp),%edx
     f97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     f9a:	0f b6 02             	movzbl (%edx),%eax
     f9d:	0f b6 19             	movzbl (%ecx),%ebx
     fa0:	84 c0                	test   %al,%al
     fa2:	75 1c                	jne    fc0 <strcmp+0x30>
     fa4:	eb 2a                	jmp    fd0 <strcmp+0x40>
     fa6:	8d 76 00             	lea    0x0(%esi),%esi
     fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     fb0:	83 c2 01             	add    $0x1,%edx
     fb3:	0f b6 02             	movzbl (%edx),%eax
     fb6:	83 c1 01             	add    $0x1,%ecx
     fb9:	0f b6 19             	movzbl (%ecx),%ebx
     fbc:	84 c0                	test   %al,%al
     fbe:	74 10                	je     fd0 <strcmp+0x40>
     fc0:	38 d8                	cmp    %bl,%al
     fc2:	74 ec                	je     fb0 <strcmp+0x20>
     fc4:	29 d8                	sub    %ebx,%eax
     fc6:	5b                   	pop    %ebx
     fc7:	5d                   	pop    %ebp
     fc8:	c3                   	ret    
     fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fd0:	31 c0                	xor    %eax,%eax
     fd2:	29 d8                	sub    %ebx,%eax
     fd4:	5b                   	pop    %ebx
     fd5:	5d                   	pop    %ebp
     fd6:	c3                   	ret    
     fd7:	89 f6                	mov    %esi,%esi
     fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000fe0 <strlen>:
     fe0:	55                   	push   %ebp
     fe1:	89 e5                	mov    %esp,%ebp
     fe3:	8b 4d 08             	mov    0x8(%ebp),%ecx
     fe6:	80 39 00             	cmpb   $0x0,(%ecx)
     fe9:	74 15                	je     1000 <strlen+0x20>
     feb:	31 d2                	xor    %edx,%edx
     fed:	8d 76 00             	lea    0x0(%esi),%esi
     ff0:	83 c2 01             	add    $0x1,%edx
     ff3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     ff7:	89 d0                	mov    %edx,%eax
     ff9:	75 f5                	jne    ff0 <strlen+0x10>
     ffb:	5d                   	pop    %ebp
     ffc:	c3                   	ret    
     ffd:	8d 76 00             	lea    0x0(%esi),%esi
    1000:	31 c0                	xor    %eax,%eax
    1002:	5d                   	pop    %ebp
    1003:	c3                   	ret    
    1004:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    100a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001010 <memset>:
    1010:	55                   	push   %ebp
    1011:	89 e5                	mov    %esp,%ebp
    1013:	57                   	push   %edi
    1014:	8b 55 08             	mov    0x8(%ebp),%edx
    1017:	8b 4d 10             	mov    0x10(%ebp),%ecx
    101a:	8b 45 0c             	mov    0xc(%ebp),%eax
    101d:	89 d7                	mov    %edx,%edi
    101f:	fc                   	cld    
    1020:	f3 aa                	rep stos %al,%es:(%edi)
    1022:	89 d0                	mov    %edx,%eax
    1024:	5f                   	pop    %edi
    1025:	5d                   	pop    %ebp
    1026:	c3                   	ret    
    1027:	89 f6                	mov    %esi,%esi
    1029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001030 <strchr>:
    1030:	55                   	push   %ebp
    1031:	89 e5                	mov    %esp,%ebp
    1033:	53                   	push   %ebx
    1034:	8b 45 08             	mov    0x8(%ebp),%eax
    1037:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    103a:	0f b6 10             	movzbl (%eax),%edx
    103d:	84 d2                	test   %dl,%dl
    103f:	74 1d                	je     105e <strchr+0x2e>
    1041:	38 d3                	cmp    %dl,%bl
    1043:	89 d9                	mov    %ebx,%ecx
    1045:	75 0d                	jne    1054 <strchr+0x24>
    1047:	eb 17                	jmp    1060 <strchr+0x30>
    1049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1050:	38 ca                	cmp    %cl,%dl
    1052:	74 0c                	je     1060 <strchr+0x30>
    1054:	83 c0 01             	add    $0x1,%eax
    1057:	0f b6 10             	movzbl (%eax),%edx
    105a:	84 d2                	test   %dl,%dl
    105c:	75 f2                	jne    1050 <strchr+0x20>
    105e:	31 c0                	xor    %eax,%eax
    1060:	5b                   	pop    %ebx
    1061:	5d                   	pop    %ebp
    1062:	c3                   	ret    
    1063:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001070 <gets>:
    1070:	55                   	push   %ebp
    1071:	89 e5                	mov    %esp,%ebp
    1073:	57                   	push   %edi
    1074:	56                   	push   %esi
    1075:	53                   	push   %ebx
    1076:	31 f6                	xor    %esi,%esi
    1078:	89 f3                	mov    %esi,%ebx
    107a:	83 ec 1c             	sub    $0x1c,%esp
    107d:	8b 7d 08             	mov    0x8(%ebp),%edi
    1080:	eb 2f                	jmp    10b1 <gets+0x41>
    1082:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1088:	8d 45 e7             	lea    -0x19(%ebp),%eax
    108b:	83 ec 04             	sub    $0x4,%esp
    108e:	6a 01                	push   $0x1
    1090:	50                   	push   %eax
    1091:	6a 00                	push   $0x0
    1093:	e8 32 01 00 00       	call   11ca <read>
    1098:	83 c4 10             	add    $0x10,%esp
    109b:	85 c0                	test   %eax,%eax
    109d:	7e 1c                	jle    10bb <gets+0x4b>
    109f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    10a3:	83 c7 01             	add    $0x1,%edi
    10a6:	88 47 ff             	mov    %al,-0x1(%edi)
    10a9:	3c 0a                	cmp    $0xa,%al
    10ab:	74 23                	je     10d0 <gets+0x60>
    10ad:	3c 0d                	cmp    $0xd,%al
    10af:	74 1f                	je     10d0 <gets+0x60>
    10b1:	83 c3 01             	add    $0x1,%ebx
    10b4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    10b7:	89 fe                	mov    %edi,%esi
    10b9:	7c cd                	jl     1088 <gets+0x18>
    10bb:	89 f3                	mov    %esi,%ebx
    10bd:	8b 45 08             	mov    0x8(%ebp),%eax
    10c0:	c6 03 00             	movb   $0x0,(%ebx)
    10c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10c6:	5b                   	pop    %ebx
    10c7:	5e                   	pop    %esi
    10c8:	5f                   	pop    %edi
    10c9:	5d                   	pop    %ebp
    10ca:	c3                   	ret    
    10cb:	90                   	nop
    10cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10d0:	8b 75 08             	mov    0x8(%ebp),%esi
    10d3:	8b 45 08             	mov    0x8(%ebp),%eax
    10d6:	01 de                	add    %ebx,%esi
    10d8:	89 f3                	mov    %esi,%ebx
    10da:	c6 03 00             	movb   $0x0,(%ebx)
    10dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10e0:	5b                   	pop    %ebx
    10e1:	5e                   	pop    %esi
    10e2:	5f                   	pop    %edi
    10e3:	5d                   	pop    %ebp
    10e4:	c3                   	ret    
    10e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010f0 <stat>:
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
    10f3:	56                   	push   %esi
    10f4:	53                   	push   %ebx
    10f5:	83 ec 08             	sub    $0x8,%esp
    10f8:	6a 00                	push   $0x0
    10fa:	ff 75 08             	pushl  0x8(%ebp)
    10fd:	e8 f0 00 00 00       	call   11f2 <open>
    1102:	83 c4 10             	add    $0x10,%esp
    1105:	85 c0                	test   %eax,%eax
    1107:	78 27                	js     1130 <stat+0x40>
    1109:	83 ec 08             	sub    $0x8,%esp
    110c:	ff 75 0c             	pushl  0xc(%ebp)
    110f:	89 c3                	mov    %eax,%ebx
    1111:	50                   	push   %eax
    1112:	e8 f3 00 00 00       	call   120a <fstat>
    1117:	89 1c 24             	mov    %ebx,(%esp)
    111a:	89 c6                	mov    %eax,%esi
    111c:	e8 b9 00 00 00       	call   11da <close>
    1121:	83 c4 10             	add    $0x10,%esp
    1124:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1127:	89 f0                	mov    %esi,%eax
    1129:	5b                   	pop    %ebx
    112a:	5e                   	pop    %esi
    112b:	5d                   	pop    %ebp
    112c:	c3                   	ret    
    112d:	8d 76 00             	lea    0x0(%esi),%esi
    1130:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1135:	eb ed                	jmp    1124 <stat+0x34>
    1137:	89 f6                	mov    %esi,%esi
    1139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001140 <atoi>:
    1140:	55                   	push   %ebp
    1141:	89 e5                	mov    %esp,%ebp
    1143:	53                   	push   %ebx
    1144:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1147:	0f be 11             	movsbl (%ecx),%edx
    114a:	8d 42 d0             	lea    -0x30(%edx),%eax
    114d:	3c 09                	cmp    $0x9,%al
    114f:	b8 00 00 00 00       	mov    $0x0,%eax
    1154:	77 1f                	ja     1175 <atoi+0x35>
    1156:	8d 76 00             	lea    0x0(%esi),%esi
    1159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1160:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1163:	83 c1 01             	add    $0x1,%ecx
    1166:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
    116a:	0f be 11             	movsbl (%ecx),%edx
    116d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1170:	80 fb 09             	cmp    $0x9,%bl
    1173:	76 eb                	jbe    1160 <atoi+0x20>
    1175:	5b                   	pop    %ebx
    1176:	5d                   	pop    %ebp
    1177:	c3                   	ret    
    1178:	90                   	nop
    1179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001180 <memmove>:
    1180:	55                   	push   %ebp
    1181:	89 e5                	mov    %esp,%ebp
    1183:	56                   	push   %esi
    1184:	53                   	push   %ebx
    1185:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1188:	8b 45 08             	mov    0x8(%ebp),%eax
    118b:	8b 75 0c             	mov    0xc(%ebp),%esi
    118e:	85 db                	test   %ebx,%ebx
    1190:	7e 14                	jle    11a6 <memmove+0x26>
    1192:	31 d2                	xor    %edx,%edx
    1194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1198:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    119c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    119f:	83 c2 01             	add    $0x1,%edx
    11a2:	39 d3                	cmp    %edx,%ebx
    11a4:	75 f2                	jne    1198 <memmove+0x18>
    11a6:	5b                   	pop    %ebx
    11a7:	5e                   	pop    %esi
    11a8:	5d                   	pop    %ebp
    11a9:	c3                   	ret    

000011aa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    11aa:	b8 01 00 00 00       	mov    $0x1,%eax
    11af:	cd 40                	int    $0x40
    11b1:	c3                   	ret    

000011b2 <exit>:
SYSCALL(exit)
    11b2:	b8 02 00 00 00       	mov    $0x2,%eax
    11b7:	cd 40                	int    $0x40
    11b9:	c3                   	ret    

000011ba <wait>:
SYSCALL(wait)
    11ba:	b8 03 00 00 00       	mov    $0x3,%eax
    11bf:	cd 40                	int    $0x40
    11c1:	c3                   	ret    

000011c2 <pipe>:
SYSCALL(pipe)
    11c2:	b8 04 00 00 00       	mov    $0x4,%eax
    11c7:	cd 40                	int    $0x40
    11c9:	c3                   	ret    

000011ca <read>:
SYSCALL(read)
    11ca:	b8 05 00 00 00       	mov    $0x5,%eax
    11cf:	cd 40                	int    $0x40
    11d1:	c3                   	ret    

000011d2 <write>:
SYSCALL(write)
    11d2:	b8 10 00 00 00       	mov    $0x10,%eax
    11d7:	cd 40                	int    $0x40
    11d9:	c3                   	ret    

000011da <close>:
SYSCALL(close)
    11da:	b8 15 00 00 00       	mov    $0x15,%eax
    11df:	cd 40                	int    $0x40
    11e1:	c3                   	ret    

000011e2 <kill>:
SYSCALL(kill)
    11e2:	b8 06 00 00 00       	mov    $0x6,%eax
    11e7:	cd 40                	int    $0x40
    11e9:	c3                   	ret    

000011ea <exec>:
SYSCALL(exec)
    11ea:	b8 07 00 00 00       	mov    $0x7,%eax
    11ef:	cd 40                	int    $0x40
    11f1:	c3                   	ret    

000011f2 <open>:
SYSCALL(open)
    11f2:	b8 0f 00 00 00       	mov    $0xf,%eax
    11f7:	cd 40                	int    $0x40
    11f9:	c3                   	ret    

000011fa <mknod>:
SYSCALL(mknod)
    11fa:	b8 11 00 00 00       	mov    $0x11,%eax
    11ff:	cd 40                	int    $0x40
    1201:	c3                   	ret    

00001202 <unlink>:
SYSCALL(unlink)
    1202:	b8 12 00 00 00       	mov    $0x12,%eax
    1207:	cd 40                	int    $0x40
    1209:	c3                   	ret    

0000120a <fstat>:
SYSCALL(fstat)
    120a:	b8 08 00 00 00       	mov    $0x8,%eax
    120f:	cd 40                	int    $0x40
    1211:	c3                   	ret    

00001212 <link>:
SYSCALL(link)
    1212:	b8 13 00 00 00       	mov    $0x13,%eax
    1217:	cd 40                	int    $0x40
    1219:	c3                   	ret    

0000121a <mkdir>:
SYSCALL(mkdir)
    121a:	b8 14 00 00 00       	mov    $0x14,%eax
    121f:	cd 40                	int    $0x40
    1221:	c3                   	ret    

00001222 <chdir>:
SYSCALL(chdir)
    1222:	b8 09 00 00 00       	mov    $0x9,%eax
    1227:	cd 40                	int    $0x40
    1229:	c3                   	ret    

0000122a <dup>:
SYSCALL(dup)
    122a:	b8 0a 00 00 00       	mov    $0xa,%eax
    122f:	cd 40                	int    $0x40
    1231:	c3                   	ret    

00001232 <getpid>:
SYSCALL(getpid)
    1232:	b8 0b 00 00 00       	mov    $0xb,%eax
    1237:	cd 40                	int    $0x40
    1239:	c3                   	ret    

0000123a <sbrk>:
SYSCALL(sbrk)
    123a:	b8 0c 00 00 00       	mov    $0xc,%eax
    123f:	cd 40                	int    $0x40
    1241:	c3                   	ret    

00001242 <sleep>:
SYSCALL(sleep)
    1242:	b8 0d 00 00 00       	mov    $0xd,%eax
    1247:	cd 40                	int    $0x40
    1249:	c3                   	ret    

0000124a <uptime>:
SYSCALL(uptime)
    124a:	b8 0e 00 00 00       	mov    $0xe,%eax
    124f:	cd 40                	int    $0x40
    1251:	c3                   	ret    

00001252 <cpuhalt>:
SYSCALL(cpuhalt)
    1252:	b8 16 00 00 00       	mov    $0x16,%eax
    1257:	cd 40                	int    $0x40
    1259:	c3                   	ret    
    125a:	66 90                	xchg   %ax,%ax
    125c:	66 90                	xchg   %ax,%ax
    125e:	66 90                	xchg   %ax,%ax

00001260 <printint.constprop.1>:
    1260:	55                   	push   %ebp
    1261:	89 e5                	mov    %esp,%ebp
    1263:	57                   	push   %edi
    1264:	56                   	push   %esi
    1265:	53                   	push   %ebx
    1266:	89 d6                	mov    %edx,%esi
    1268:	83 ec 3c             	sub    $0x3c,%esp
    126b:	85 c0                	test   %eax,%eax
    126d:	79 71                	jns    12e0 <printint.constprop.1+0x80>
    126f:	83 e1 01             	and    $0x1,%ecx
    1272:	74 6c                	je     12e0 <printint.constprop.1+0x80>
    1274:	f7 d8                	neg    %eax
    1276:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    127d:	31 c9                	xor    %ecx,%ecx
    127f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1282:	eb 06                	jmp    128a <printint.constprop.1+0x2a>
    1284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1288:	89 f9                	mov    %edi,%ecx
    128a:	31 d2                	xor    %edx,%edx
    128c:	8d 79 01             	lea    0x1(%ecx),%edi
    128f:	f7 f6                	div    %esi
    1291:	0f b6 92 00 19 00 00 	movzbl 0x1900(%edx),%edx
    1298:	85 c0                	test   %eax,%eax
    129a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
    129d:	75 e9                	jne    1288 <printint.constprop.1+0x28>
    129f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    12a2:	85 c0                	test   %eax,%eax
    12a4:	74 08                	je     12ae <printint.constprop.1+0x4e>
    12a6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    12ab:	8d 79 02             	lea    0x2(%ecx),%edi
    12ae:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    12b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    12b8:	0f b6 06             	movzbl (%esi),%eax
    12bb:	83 ec 04             	sub    $0x4,%esp
    12be:	83 ee 01             	sub    $0x1,%esi
    12c1:	6a 01                	push   $0x1
    12c3:	53                   	push   %ebx
    12c4:	6a 01                	push   $0x1
    12c6:	88 45 d7             	mov    %al,-0x29(%ebp)
    12c9:	e8 04 ff ff ff       	call   11d2 <write>
    12ce:	83 c4 10             	add    $0x10,%esp
    12d1:	39 de                	cmp    %ebx,%esi
    12d3:	75 e3                	jne    12b8 <printint.constprop.1+0x58>
    12d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12d8:	5b                   	pop    %ebx
    12d9:	5e                   	pop    %esi
    12da:	5f                   	pop    %edi
    12db:	5d                   	pop    %ebp
    12dc:	c3                   	ret    
    12dd:	8d 76 00             	lea    0x0(%esi),%esi
    12e0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    12e7:	eb 94                	jmp    127d <printint.constprop.1+0x1d>
    12e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000012f0 <vprintf.constprop.0>:
    12f0:	55                   	push   %ebp
    12f1:	89 e5                	mov    %esp,%ebp
    12f3:	57                   	push   %edi
    12f4:	56                   	push   %esi
    12f5:	53                   	push   %ebx
    12f6:	89 d6                	mov    %edx,%esi
    12f8:	83 ec 2c             	sub    $0x2c,%esp
    12fb:	0f b6 10             	movzbl (%eax),%edx
    12fe:	84 d2                	test   %dl,%dl
    1300:	0f 84 cd 00 00 00    	je     13d3 <vprintf.constprop.0+0xe3>
    1306:	8d 58 01             	lea    0x1(%eax),%ebx
    1309:	31 ff                	xor    %edi,%edi
    130b:	eb 31                	jmp    133e <vprintf.constprop.0+0x4e>
    130d:	8d 76 00             	lea    0x0(%esi),%esi
    1310:	83 f8 25             	cmp    $0x25,%eax
    1313:	0f 84 c7 00 00 00    	je     13e0 <vprintf.constprop.0+0xf0>
    1319:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    131c:	83 ec 04             	sub    $0x4,%esp
    131f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
    1322:	6a 01                	push   $0x1
    1324:	50                   	push   %eax
    1325:	6a 01                	push   $0x1
    1327:	e8 a6 fe ff ff       	call   11d2 <write>
    132c:	83 c4 10             	add    $0x10,%esp
    132f:	83 c3 01             	add    $0x1,%ebx
    1332:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1336:	84 d2                	test   %dl,%dl
    1338:	0f 84 95 00 00 00    	je     13d3 <vprintf.constprop.0+0xe3>
    133e:	85 ff                	test   %edi,%edi
    1340:	0f b6 c2             	movzbl %dl,%eax
    1343:	74 cb                	je     1310 <vprintf.constprop.0+0x20>
    1345:	83 ff 25             	cmp    $0x25,%edi
    1348:	75 e5                	jne    132f <vprintf.constprop.0+0x3f>
    134a:	83 f8 64             	cmp    $0x64,%eax
    134d:	8d 7e 04             	lea    0x4(%esi),%edi
    1350:	b9 01 00 00 00       	mov    $0x1,%ecx
    1355:	0f 84 9a 00 00 00    	je     13f5 <vprintf.constprop.0+0x105>
    135b:	83 f8 6c             	cmp    $0x6c,%eax
    135e:	0f 84 8c 00 00 00    	je     13f0 <vprintf.constprop.0+0x100>
    1364:	83 f8 78             	cmp    $0x78,%eax
    1367:	0f 84 a3 00 00 00    	je     1410 <vprintf.constprop.0+0x120>
    136d:	83 f8 70             	cmp    $0x70,%eax
    1370:	0f 84 ca 00 00 00    	je     1440 <vprintf.constprop.0+0x150>
    1376:	83 f8 73             	cmp    $0x73,%eax
    1379:	0f 84 39 01 00 00    	je     14b8 <vprintf.constprop.0+0x1c8>
    137f:	83 f8 63             	cmp    $0x63,%eax
    1382:	0f 84 68 01 00 00    	je     14f0 <vprintf.constprop.0+0x200>
    1388:	83 f8 25             	cmp    $0x25,%eax
    138b:	0f 84 9f 00 00 00    	je     1430 <vprintf.constprop.0+0x140>
    1391:	8d 45 df             	lea    -0x21(%ebp),%eax
    1394:	83 ec 04             	sub    $0x4,%esp
    1397:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    139a:	6a 01                	push   $0x1
    139c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
    13a0:	50                   	push   %eax
    13a1:	6a 01                	push   $0x1
    13a3:	e8 2a fe ff ff       	call   11d2 <write>
    13a8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    13ac:	83 c4 0c             	add    $0xc,%esp
    13af:	8d 45 e0             	lea    -0x20(%ebp),%eax
    13b2:	6a 01                	push   $0x1
    13b4:	88 55 e0             	mov    %dl,-0x20(%ebp)
    13b7:	50                   	push   %eax
    13b8:	6a 01                	push   $0x1
    13ba:	83 c3 01             	add    $0x1,%ebx
    13bd:	31 ff                	xor    %edi,%edi
    13bf:	e8 0e fe ff ff       	call   11d2 <write>
    13c4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    13c8:	83 c4 10             	add    $0x10,%esp
    13cb:	84 d2                	test   %dl,%dl
    13cd:	0f 85 6b ff ff ff    	jne    133e <vprintf.constprop.0+0x4e>
    13d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    13d6:	5b                   	pop    %ebx
    13d7:	5e                   	pop    %esi
    13d8:	5f                   	pop    %edi
    13d9:	5d                   	pop    %ebp
    13da:	c3                   	ret    
    13db:	90                   	nop
    13dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    13e0:	bf 25 00 00 00       	mov    $0x25,%edi
    13e5:	e9 45 ff ff ff       	jmp    132f <vprintf.constprop.0+0x3f>
    13ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    13f0:	8d 7e 04             	lea    0x4(%esi),%edi
    13f3:	31 c9                	xor    %ecx,%ecx
    13f5:	8b 06                	mov    (%esi),%eax
    13f7:	ba 0a 00 00 00       	mov    $0xa,%edx
    13fc:	89 fe                	mov    %edi,%esi
    13fe:	31 ff                	xor    %edi,%edi
    1400:	e8 5b fe ff ff       	call   1260 <printint.constprop.1>
    1405:	e9 25 ff ff ff       	jmp    132f <vprintf.constprop.0+0x3f>
    140a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1410:	8b 06                	mov    (%esi),%eax
    1412:	8d 7e 04             	lea    0x4(%esi),%edi
    1415:	31 c9                	xor    %ecx,%ecx
    1417:	ba 10 00 00 00       	mov    $0x10,%edx
    141c:	89 fe                	mov    %edi,%esi
    141e:	31 ff                	xor    %edi,%edi
    1420:	e8 3b fe ff ff       	call   1260 <printint.constprop.1>
    1425:	e9 05 ff ff ff       	jmp    132f <vprintf.constprop.0+0x3f>
    142a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1430:	83 ec 04             	sub    $0x4,%esp
    1433:	88 55 e1             	mov    %dl,-0x1f(%ebp)
    1436:	8d 45 e1             	lea    -0x1f(%ebp),%eax
    1439:	6a 01                	push   $0x1
    143b:	e9 77 ff ff ff       	jmp    13b7 <vprintf.constprop.0+0xc7>
    1440:	8d 46 04             	lea    0x4(%esi),%eax
    1443:	83 ec 04             	sub    $0x4,%esp
    1446:	8b 3e                	mov    (%esi),%edi
    1448:	6a 01                	push   $0x1
    144a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
    144e:	be 08 00 00 00       	mov    $0x8,%esi
    1453:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1456:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1459:	50                   	push   %eax
    145a:	6a 01                	push   $0x1
    145c:	e8 71 fd ff ff       	call   11d2 <write>
    1461:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1464:	83 c4 0c             	add    $0xc,%esp
    1467:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
    146b:	6a 01                	push   $0x1
    146d:	50                   	push   %eax
    146e:	6a 01                	push   $0x1
    1470:	e8 5d fd ff ff       	call   11d2 <write>
    1475:	83 c4 10             	add    $0x10,%esp
    1478:	90                   	nop
    1479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1480:	89 f8                	mov    %edi,%eax
    1482:	83 ec 04             	sub    $0x4,%esp
    1485:	c1 e7 04             	shl    $0x4,%edi
    1488:	c1 e8 1c             	shr    $0x1c,%eax
    148b:	6a 01                	push   $0x1
    148d:	0f b6 80 00 19 00 00 	movzbl 0x1900(%eax),%eax
    1494:	88 45 e5             	mov    %al,-0x1b(%ebp)
    1497:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    149a:	50                   	push   %eax
    149b:	6a 01                	push   $0x1
    149d:	e8 30 fd ff ff       	call   11d2 <write>
    14a2:	83 c4 10             	add    $0x10,%esp
    14a5:	83 ee 01             	sub    $0x1,%esi
    14a8:	75 d6                	jne    1480 <vprintf.constprop.0+0x190>
    14aa:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    14ad:	31 ff                	xor    %edi,%edi
    14af:	e9 7b fe ff ff       	jmp    132f <vprintf.constprop.0+0x3f>
    14b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    14b8:	8b 3e                	mov    (%esi),%edi
    14ba:	8d 46 04             	lea    0x4(%esi),%eax
    14bd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    14c0:	85 ff                	test   %edi,%edi
    14c2:	74 50                	je     1514 <vprintf.constprop.0+0x224>
    14c4:	0f b6 07             	movzbl (%edi),%eax
    14c7:	84 c0                	test   %al,%al
    14c9:	74 df                	je     14aa <vprintf.constprop.0+0x1ba>
    14cb:	8d 75 e3             	lea    -0x1d(%ebp),%esi
    14ce:	66 90                	xchg   %ax,%ax
    14d0:	83 ec 04             	sub    $0x4,%esp
    14d3:	83 c7 01             	add    $0x1,%edi
    14d6:	88 45 e3             	mov    %al,-0x1d(%ebp)
    14d9:	6a 01                	push   $0x1
    14db:	56                   	push   %esi
    14dc:	6a 01                	push   $0x1
    14de:	e8 ef fc ff ff       	call   11d2 <write>
    14e3:	0f b6 07             	movzbl (%edi),%eax
    14e6:	83 c4 10             	add    $0x10,%esp
    14e9:	84 c0                	test   %al,%al
    14eb:	75 e3                	jne    14d0 <vprintf.constprop.0+0x1e0>
    14ed:	eb bb                	jmp    14aa <vprintf.constprop.0+0x1ba>
    14ef:	90                   	nop
    14f0:	8b 06                	mov    (%esi),%eax
    14f2:	83 ec 04             	sub    $0x4,%esp
    14f5:	8d 7e 04             	lea    0x4(%esi),%edi
    14f8:	6a 01                	push   $0x1
    14fa:	89 fe                	mov    %edi,%esi
    14fc:	31 ff                	xor    %edi,%edi
    14fe:	88 45 e2             	mov    %al,-0x1e(%ebp)
    1501:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1504:	50                   	push   %eax
    1505:	6a 01                	push   $0x1
    1507:	e8 c6 fc ff ff       	call   11d2 <write>
    150c:	83 c4 10             	add    $0x10,%esp
    150f:	e9 1b fe ff ff       	jmp    132f <vprintf.constprop.0+0x3f>
    1514:	bf f8 18 00 00       	mov    $0x18f8,%edi
    1519:	b8 28 00 00 00       	mov    $0x28,%eax
    151e:	eb ab                	jmp    14cb <vprintf.constprop.0+0x1db>

00001520 <fprintf>:
    1520:	55                   	push   %ebp
    1521:	89 e5                	mov    %esp,%ebp
    1523:	83 ec 08             	sub    $0x8,%esp
    1526:	8b 45 0c             	mov    0xc(%ebp),%eax
    1529:	8d 55 10             	lea    0x10(%ebp),%edx
    152c:	e8 bf fd ff ff       	call   12f0 <vprintf.constprop.0>
    1531:	c9                   	leave  
    1532:	c3                   	ret    
    1533:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001540 <printf>:
    1540:	55                   	push   %ebp
    1541:	89 e5                	mov    %esp,%ebp
    1543:	83 ec 08             	sub    $0x8,%esp
    1546:	8b 45 08             	mov    0x8(%ebp),%eax
    1549:	8d 55 0c             	lea    0xc(%ebp),%edx
    154c:	e8 9f fd ff ff       	call   12f0 <vprintf.constprop.0>
    1551:	c9                   	leave  
    1552:	c3                   	ret    
    1553:	66 90                	xchg   %ax,%ax
    1555:	66 90                	xchg   %ax,%ax
    1557:	66 90                	xchg   %ax,%ax
    1559:	66 90                	xchg   %ax,%ax
    155b:	66 90                	xchg   %ax,%ax
    155d:	66 90                	xchg   %ax,%ax
    155f:	90                   	nop

00001560 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1560:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1561:	a1 a4 21 00 00       	mov    0x21a4,%eax
{
    1566:	89 e5                	mov    %esp,%ebp
    1568:	57                   	push   %edi
    1569:	56                   	push   %esi
    156a:	53                   	push   %ebx
    156b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    156e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1578:	39 c8                	cmp    %ecx,%eax
    157a:	8b 10                	mov    (%eax),%edx
    157c:	73 32                	jae    15b0 <free+0x50>
    157e:	39 d1                	cmp    %edx,%ecx
    1580:	72 04                	jb     1586 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1582:	39 d0                	cmp    %edx,%eax
    1584:	72 32                	jb     15b8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1586:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1589:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    158c:	39 fa                	cmp    %edi,%edx
    158e:	74 30                	je     15c0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1590:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1593:	8b 50 04             	mov    0x4(%eax),%edx
    1596:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1599:	39 f1                	cmp    %esi,%ecx
    159b:	74 3a                	je     15d7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    159d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    159f:	a3 a4 21 00 00       	mov    %eax,0x21a4
}
    15a4:	5b                   	pop    %ebx
    15a5:	5e                   	pop    %esi
    15a6:	5f                   	pop    %edi
    15a7:	5d                   	pop    %ebp
    15a8:	c3                   	ret    
    15a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15b0:	39 d0                	cmp    %edx,%eax
    15b2:	72 04                	jb     15b8 <free+0x58>
    15b4:	39 d1                	cmp    %edx,%ecx
    15b6:	72 ce                	jb     1586 <free+0x26>
{
    15b8:	89 d0                	mov    %edx,%eax
    15ba:	eb bc                	jmp    1578 <free+0x18>
    15bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    15c0:	03 72 04             	add    0x4(%edx),%esi
    15c3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    15c6:	8b 10                	mov    (%eax),%edx
    15c8:	8b 12                	mov    (%edx),%edx
    15ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    15cd:	8b 50 04             	mov    0x4(%eax),%edx
    15d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    15d3:	39 f1                	cmp    %esi,%ecx
    15d5:	75 c6                	jne    159d <free+0x3d>
    p->s.size += bp->s.size;
    15d7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    15da:	a3 a4 21 00 00       	mov    %eax,0x21a4
    p->s.size += bp->s.size;
    15df:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    15e2:	8b 53 f8             	mov    -0x8(%ebx),%edx
    15e5:	89 10                	mov    %edx,(%eax)
}
    15e7:	5b                   	pop    %ebx
    15e8:	5e                   	pop    %esi
    15e9:	5f                   	pop    %edi
    15ea:	5d                   	pop    %ebp
    15eb:	c3                   	ret    
    15ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000015f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    15f0:	55                   	push   %ebp
    15f1:	89 e5                	mov    %esp,%ebp
    15f3:	57                   	push   %edi
    15f4:	56                   	push   %esi
    15f5:	53                   	push   %ebx
    15f6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    15f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    15fc:	8b 15 a4 21 00 00    	mov    0x21a4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1602:	8d 78 07             	lea    0x7(%eax),%edi
    1605:	c1 ef 03             	shr    $0x3,%edi
    1608:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    160b:	85 d2                	test   %edx,%edx
    160d:	0f 84 9d 00 00 00    	je     16b0 <malloc+0xc0>
    1613:	8b 02                	mov    (%edx),%eax
    1615:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1618:	39 cf                	cmp    %ecx,%edi
    161a:	76 6c                	jbe    1688 <malloc+0x98>
    161c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1622:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1627:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    162a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1631:	eb 0e                	jmp    1641 <malloc+0x51>
    1633:	90                   	nop
    1634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1638:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    163a:	8b 48 04             	mov    0x4(%eax),%ecx
    163d:	39 f9                	cmp    %edi,%ecx
    163f:	73 47                	jae    1688 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1641:	39 05 a4 21 00 00    	cmp    %eax,0x21a4
    1647:	89 c2                	mov    %eax,%edx
    1649:	75 ed                	jne    1638 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    164b:	83 ec 0c             	sub    $0xc,%esp
    164e:	56                   	push   %esi
    164f:	e8 e6 fb ff ff       	call   123a <sbrk>
  if(p == (char*)-1)
    1654:	83 c4 10             	add    $0x10,%esp
    1657:	83 f8 ff             	cmp    $0xffffffff,%eax
    165a:	74 1c                	je     1678 <malloc+0x88>
  hp->s.size = nu;
    165c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    165f:	83 ec 0c             	sub    $0xc,%esp
    1662:	83 c0 08             	add    $0x8,%eax
    1665:	50                   	push   %eax
    1666:	e8 f5 fe ff ff       	call   1560 <free>
  return freep;
    166b:	8b 15 a4 21 00 00    	mov    0x21a4,%edx
      if((p = morecore(nunits)) == 0)
    1671:	83 c4 10             	add    $0x10,%esp
    1674:	85 d2                	test   %edx,%edx
    1676:	75 c0                	jne    1638 <malloc+0x48>
        return 0;
  }
}
    1678:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    167b:	31 c0                	xor    %eax,%eax
}
    167d:	5b                   	pop    %ebx
    167e:	5e                   	pop    %esi
    167f:	5f                   	pop    %edi
    1680:	5d                   	pop    %ebp
    1681:	c3                   	ret    
    1682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1688:	39 cf                	cmp    %ecx,%edi
    168a:	74 54                	je     16e0 <malloc+0xf0>
        p->s.size -= nunits;
    168c:	29 f9                	sub    %edi,%ecx
    168e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1691:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1694:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1697:	89 15 a4 21 00 00    	mov    %edx,0x21a4
}
    169d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    16a0:	83 c0 08             	add    $0x8,%eax
}
    16a3:	5b                   	pop    %ebx
    16a4:	5e                   	pop    %esi
    16a5:	5f                   	pop    %edi
    16a6:	5d                   	pop    %ebp
    16a7:	c3                   	ret    
    16a8:	90                   	nop
    16a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    16b0:	c7 05 a4 21 00 00 a8 	movl   $0x21a8,0x21a4
    16b7:	21 00 00 
    16ba:	c7 05 a8 21 00 00 a8 	movl   $0x21a8,0x21a8
    16c1:	21 00 00 
    base.s.size = 0;
    16c4:	b8 a8 21 00 00       	mov    $0x21a8,%eax
    16c9:	c7 05 ac 21 00 00 00 	movl   $0x0,0x21ac
    16d0:	00 00 00 
    16d3:	e9 44 ff ff ff       	jmp    161c <malloc+0x2c>
    16d8:	90                   	nop
    16d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    16e0:	8b 08                	mov    (%eax),%ecx
    16e2:	89 0a                	mov    %ecx,(%edx)
    16e4:	eb b1                	jmp    1697 <malloc+0xa7>
