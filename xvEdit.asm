
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
      1f:	0f 8e 47 02 00 00    	jle    26c <main+0x26c>
    fprintf(2, "specify a file you want to edit");
    exit();
  } else if (argc > 2) {
      25:	83 f8 02             	cmp    $0x2,%eax
      28:	0f 85 2b 02 00 00    	jne    259 <main+0x259>
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
      56:	f3 ab                	rep stos %eax,%es:(%edi)
    uint ino;
    short nlink;
    uint size;
  };
  struct File file;
  file.filename = argv[1];
      58:	8b 42 04             	mov    0x4(%edx),%eax
      5b:	89 c7                	mov    %eax,%edi
      5d:	89 85 fc fe ff ff    	mov    %eax,-0x104(%ebp)
  file.lines = MakeLinkedList();
      63:	e8 88 03 00 00       	call   3f0 <MakeLinkedList>
      68:	89 85 00 ff ff ff    	mov    %eax,-0x100(%ebp)
  fprintf(2, "Welcome to xvEdit!\n");
      6e:	50                   	push   %eax
      6f:	50                   	push   %eax
      70:	68 00 15 00 00       	push   $0x1500
      75:	6a 02                	push   $0x2
      77:	e8 54 12 00 00       	call   12d0 <fprintf>
  // opening
  file.fd = open(file.filename, O_RDONLY);
      7c:	58                   	pop    %eax
      7d:	5a                   	pop    %edx
      7e:	6a 00                	push   $0x0
      80:	57                   	push   %edi
      81:	e8 1c 0f 00 00       	call   fa2 <open>
  if (file.fd == -1) {
      86:	83 c4 10             	add    $0x10,%esp
  file.fd = open(file.filename, O_RDONLY);
      89:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
  if (file.fd == -1) {
      8f:	83 c0 01             	add    $0x1,%eax
      92:	0f 84 e7 01 00 00    	je     27f <main+0x27f>
    fprintf(2, "creating %s . . .\n",  file.filename);
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
    close(file.fd);
  } else { // populate Linked List
    gatherLines(file);
      98:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
      9e:	83 ec 10             	sub    $0x10,%esp
      a1:	8d b5 14 ff ff ff    	lea    -0xec(%ebp),%esi
      a7:	89 e7                	mov    %esp,%edi
      a9:	b9 03 00 00 00       	mov    $0x3,%ecx
      ae:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
      b4:	8b 85 04 ff ff ff    	mov    -0xfc(%ebp),%eax
      ba:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
      c0:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
      c6:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
      cc:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
      ce:	e8 4d 06 00 00       	call   720 <gatherLines>
      d3:	83 c4 10             	add    $0x10,%esp
  }
  close(file.fd);
      d6:	83 ec 0c             	sub    $0xc,%esp
      d9:	ff b5 04 ff ff ff    	pushl  -0xfc(%ebp)
      df:	8d 9d 20 ff ff ff    	lea    -0xe0(%ebp),%ebx
      e5:	e8 a0 0e 00 00       	call   f8a <close>
      ea:	83 c4 10             	add    $0x10,%esp
      ed:	8d 76 00             	lea    0x0(%esi),%esi

  while (cmd != QUIT) {
    fprintf(2, "xvEdit> ");
      f0:	83 ec 08             	sub    $0x8,%esp
      f3:	68 27 15 00 00       	push   $0x1527
      f8:	6a 02                	push   $0x2
      fa:	e8 d1 11 00 00       	call   12d0 <fprintf>
    memset(buf, 0, nbuf);
      ff:	83 c4 0c             	add    $0xc,%esp
     102:	6a 64                	push   $0x64
     104:	6a 00                	push   $0x0
     106:	68 c0 1d 00 00       	push   $0x1dc0
     10b:	e8 b0 0c 00 00       	call   dc0 <memset>
    gets(buf, nbuf);
     110:	58                   	pop    %eax
     111:	5a                   	pop    %edx
     112:	6a 64                	push   $0x64
     114:	68 c0 1d 00 00       	push   $0x1dc0
     119:	e8 02 0d 00 00       	call   e20 <gets>
    
    unline(buf);
     11e:	c7 04 24 c0 1d 00 00 	movl   $0x1dc0,(%esp)
     125:	e8 c6 0a 00 00       	call   bf0 <unline>
    substr(cmdstr, buf, 0, 4);
     12a:	6a 04                	push   $0x4
     12c:	6a 00                	push   $0x0
     12e:	68 c0 1d 00 00       	push   $0x1dc0
     133:	53                   	push   %ebx
     134:	e8 a7 06 00 00       	call   7e0 <substr>
  return 0;
}

void toUpper(char* str) {
  int i = 0;
  while (str[i] != '\0') {
     139:	0f b6 85 20 ff ff ff 	movzbl -0xe0(%ebp),%eax
     140:	83 c4 20             	add    $0x20,%esp
     143:	84 c0                	test   %al,%al
     145:	74 20                	je     167 <main+0x167>
     147:	89 da                	mov    %ebx,%edx
     149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
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
    substr(args, buf, strlen(cmdstr) + 1, strlen(buf));
     167:	83 ec 0c             	sub    $0xc,%esp
     16a:	68 c0 1d 00 00       	push   $0x1dc0
     16f:	e8 1c 0c 00 00       	call   d90 <strlen>
     174:	89 1c 24             	mov    %ebx,(%esp)
     177:	89 c6                	mov    %eax,%esi
     179:	e8 12 0c 00 00       	call   d90 <strlen>
     17e:	83 c0 01             	add    $0x1,%eax
     181:	56                   	push   %esi
     182:	50                   	push   %eax
     183:	8d 45 84             	lea    -0x7c(%ebp),%eax
     186:	68 c0 1d 00 00       	push   $0x1dc0
     18b:	50                   	push   %eax
     18c:	e8 4f 06 00 00       	call   7e0 <substr>
    if      (strcmp(cmdstr, "@END") == 0) {cmd = END;}
     191:	83 c4 18             	add    $0x18,%esp
     194:	68 30 15 00 00       	push   $0x1530
     199:	53                   	push   %ebx
     19a:	e8 a1 0b 00 00       	call   d40 <strcmp>
     19f:	83 c4 10             	add    $0x10,%esp
     1a2:	85 c0                	test   %eax,%eax
     1a4:	0f 84 46 ff ff ff    	je     f0 <main+0xf0>
    else if (strcmp(cmdstr, "ADD<") == 0) {cmd = ADD;}
     1aa:	50                   	push   %eax
     1ab:	50                   	push   %eax
     1ac:	68 35 15 00 00       	push   $0x1535
     1b1:	53                   	push   %ebx
     1b2:	e8 89 0b 00 00       	call   d40 <strcmp>
     1b7:	83 c4 10             	add    $0x10,%esp
     1ba:	85 c0                	test   %eax,%eax
     1bc:	0f 84 2e ff ff ff    	je     f0 <main+0xf0>
    else if (strcmp(cmdstr, "DROP") == 0) {cmd = DROP;}
     1c2:	50                   	push   %eax
     1c3:	50                   	push   %eax
     1c4:	68 3a 15 00 00       	push   $0x153a
     1c9:	53                   	push   %ebx
     1ca:	e8 71 0b 00 00       	call   d40 <strcmp>
     1cf:	83 c4 10             	add    $0x10,%esp
     1d2:	85 c0                	test   %eax,%eax
     1d4:	0f 84 16 ff ff ff    	je     f0 <main+0xf0>
    else if (strcmp(cmdstr, "EDIT") == 0) {cmd = EDIT;}
     1da:	50                   	push   %eax
     1db:	50                   	push   %eax
     1dc:	68 3f 15 00 00       	push   $0x153f
     1e1:	53                   	push   %ebx
     1e2:	e8 59 0b 00 00       	call   d40 <strcmp>
     1e7:	83 c4 10             	add    $0x10,%esp
     1ea:	85 c0                	test   %eax,%eax
     1ec:	0f 84 fe fe ff ff    	je     f0 <main+0xf0>
    else if (strcmp(cmdstr, "LIST") == 0) {cmd = LIST;}
     1f2:	50                   	push   %eax
     1f3:	50                   	push   %eax
     1f4:	68 44 15 00 00       	push   $0x1544
     1f9:	53                   	push   %ebx
     1fa:	e8 41 0b 00 00       	call   d40 <strcmp>
     1ff:	83 c4 10             	add    $0x10,%esp
     202:	85 c0                	test   %eax,%eax
     204:	0f 84 ac 00 00 00    	je     2b6 <main+0x2b6>
    else if (strcmp(cmdstr, "SHOW") == 0) {cmd = SHOW;}
     20a:	57                   	push   %edi
     20b:	57                   	push   %edi
     20c:	68 49 15 00 00       	push   $0x1549
     211:	53                   	push   %ebx
     212:	e8 29 0b 00 00       	call   d40 <strcmp>
     217:	83 c4 10             	add    $0x10,%esp
     21a:	85 c0                	test   %eax,%eax
     21c:	0f 84 f1 00 00 00    	je     313 <main+0x313>
    else if (strcmp(cmdstr, "QUIT") == 0) {cmd = QUIT;}
     222:	56                   	push   %esi
     223:	56                   	push   %esi
     224:	68 4e 15 00 00       	push   $0x154e
     229:	53                   	push   %ebx
     22a:	e8 11 0b 00 00       	call   d40 <strcmp>
     22f:	83 c4 10             	add    $0x10,%esp
     232:	85 c0                	test   %eax,%eax
     234:	0f 85 c3 00 00 00    	jne    2fd <main+0x2fd>
  close(file.fd);
     23a:	83 ec 0c             	sub    $0xc,%esp
     23d:	ff b5 04 ff ff ff    	pushl  -0xfc(%ebp)
     243:	e8 42 0d 00 00       	call   f8a <close>
  destroyLinkedList(file.lines);
     248:	59                   	pop    %ecx
     249:	ff b5 00 ff ff ff    	pushl  -0x100(%ebp)
     24f:	e8 6c 03 00 00       	call   5c0 <destroyLinkedList>
  exit();
     254:	e8 09 0d 00 00       	call   f62 <exit>
    fprintf(2, "only specify one file");
     259:	51                   	push   %ecx
     25a:	51                   	push   %ecx
     25b:	68 ea 14 00 00       	push   $0x14ea
     260:	6a 02                	push   $0x2
     262:	e8 69 10 00 00       	call   12d0 <fprintf>
    exit();
     267:	e8 f6 0c 00 00       	call   f62 <exit>
    fprintf(2, "specify a file you want to edit");
     26c:	53                   	push   %ebx
     26d:	53                   	push   %ebx
     26e:	68 f4 15 00 00       	push   $0x15f4
     273:	6a 02                	push   $0x2
     275:	e8 56 10 00 00       	call   12d0 <fprintf>
    exit();
     27a:	e8 e3 0c 00 00       	call   f62 <exit>
    fprintf(2, "creating %s . . .\n",  file.filename);
     27f:	8b bd fc fe ff ff    	mov    -0x104(%ebp),%edi
     285:	51                   	push   %ecx
     286:	57                   	push   %edi
     287:	68 14 15 00 00       	push   $0x1514
     28c:	6a 02                	push   $0x2
     28e:	e8 3d 10 00 00       	call   12d0 <fprintf>
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     293:	5b                   	pop    %ebx
     294:	5e                   	pop    %esi
     295:	68 01 02 00 00       	push   $0x201
     29a:	57                   	push   %edi
     29b:	e8 02 0d 00 00       	call   fa2 <open>
    close(file.fd);
     2a0:	89 04 24             	mov    %eax,(%esp)
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     2a3:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
    close(file.fd);
     2a9:	e8 dc 0c 00 00       	call   f8a <close>
     2ae:	83 c4 10             	add    $0x10,%esp
     2b1:	e9 20 fe ff ff       	jmp    d6 <main+0xd6>
      list(file, args);
     2b6:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
     2bc:	8d b5 14 ff ff ff    	lea    -0xec(%ebp),%esi
     2c2:	b9 03 00 00 00       	mov    $0x3,%ecx
     2c7:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
     2cd:	8b 85 04 ff ff ff    	mov    -0xfc(%ebp),%eax
     2d3:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
     2d9:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
     2df:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
     2e5:	8d 45 84             	lea    -0x7c(%ebp),%eax
     2e8:	50                   	push   %eax
     2e9:	83 ec 0c             	sub    $0xc,%esp
     2ec:	89 e7                	mov    %esp,%edi
     2ee:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
     2f0:	e8 8b 07 00 00       	call   a80 <list>
     2f5:	83 c4 10             	add    $0x10,%esp
     2f8:	e9 f3 fd ff ff       	jmp    f0 <main+0xf0>
  fprintf(2, "bad bi input\n");
     2fd:	52                   	push   %edx
     2fe:	52                   	push   %edx
     2ff:	68 98 14 00 00       	push   $0x1498
     304:	6a 02                	push   $0x2
     306:	e8 c5 0f 00 00       	call   12d0 <fprintf>
     30b:	83 c4 10             	add    $0x10,%esp
     30e:	e9 dd fd ff ff       	jmp    f0 <main+0xf0>
  struct Node* curr = file.lines->head->next;
     313:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
  int lineNum = 1;
     319:	bf 01 00 00 00       	mov    $0x1,%edi
  struct Node* curr = file.lines->head->next;
     31e:	8b 00                	mov    (%eax),%eax
     320:	8b 70 08             	mov    0x8(%eax),%esi
  while (curr != file.lines->tail) {
     323:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
     329:	3b 70 04             	cmp    0x4(%eax),%esi
     32c:	0f 84 be fd ff ff    	je     f0 <main+0xf0>
    printl(lineNum, curr->data);
     332:	50                   	push   %eax
     333:	50                   	push   %eax
     334:	ff 76 04             	pushl  0x4(%esi)
     337:	57                   	push   %edi
    lineNum++;
     338:	83 c7 01             	add    $0x1,%edi
    printl(lineNum, curr->data);
     33b:	e8 20 09 00 00       	call   c60 <printl>
    curr = curr->next;
     340:	8b 76 08             	mov    0x8(%esi),%esi
    lineNum++;
     343:	83 c4 10             	add    $0x10,%esp
     346:	eb db                	jmp    323 <main+0x323>
     348:	66 90                	xchg   %ax,%ax
     34a:	66 90                	xchg   %ax,%ax
     34c:	66 90                	xchg   %ax,%ax
     34e:	66 90                	xchg   %ax,%ax

00000350 <mystrcpy>:
#include "LinkedList.h"
#define nullptr 0

void mystrcpy(char* dest, char* src) {
     350:	55                   	push   %ebp
     351:	89 e5                	mov    %esp,%ebp
     353:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     356:	8b 45 08             	mov    0x8(%ebp),%eax
  while(*src != '\0')
     359:	0f b6 11             	movzbl (%ecx),%edx
     35c:	84 d2                	test   %dl,%dl
     35e:	74 10                	je     370 <mystrcpy+0x20>
    *(dest++) = *(src++);
     360:	83 c1 01             	add    $0x1,%ecx
     363:	83 c0 01             	add    $0x1,%eax
     366:	88 50 ff             	mov    %dl,-0x1(%eax)
  while(*src != '\0')
     369:	0f b6 11             	movzbl (%ecx),%edx
     36c:	84 d2                	test   %dl,%dl
     36e:	75 f0                	jne    360 <mystrcpy+0x10>
  *dest = '\0';
     370:	c6 00 00             	movb   $0x0,(%eax)
}
     373:	5d                   	pop    %ebp
     374:	c3                   	ret    
     375:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000380 <safestrcpy>:

char*
safestrcpy(char *s, const char *t, int n)
{
     380:	55                   	push   %ebp
     381:	89 e5                	mov    %esp,%ebp
     383:	56                   	push   %esi
     384:	53                   	push   %ebx
     385:	8b 4d 10             	mov    0x10(%ebp),%ecx
     388:	8b 45 08             	mov    0x8(%ebp),%eax
     38b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
     38e:	85 c9                	test   %ecx,%ecx
     390:	7e 26                	jle    3b8 <safestrcpy+0x38>
     392:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
     396:	89 c1                	mov    %eax,%ecx
     398:	eb 17                	jmp    3b1 <safestrcpy+0x31>
     39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
     3a0:	83 c2 01             	add    $0x1,%edx
     3a3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
     3a7:	83 c1 01             	add    $0x1,%ecx
     3aa:	84 db                	test   %bl,%bl
     3ac:	88 59 ff             	mov    %bl,-0x1(%ecx)
     3af:	74 04                	je     3b5 <safestrcpy+0x35>
     3b1:	39 f2                	cmp    %esi,%edx
     3b3:	75 eb                	jne    3a0 <safestrcpy+0x20>
    ;
  *s = 0;
     3b5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
     3b8:	5b                   	pop    %ebx
     3b9:	5e                   	pop    %esi
     3ba:	5d                   	pop    %ebp
     3bb:	c3                   	ret    
     3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003c0 <nullNode>:

Node* nullNode(char* data) {
     3c0:	55                   	push   %ebp
     3c1:	89 e5                	mov    %esp,%ebp
     3c3:	83 ec 14             	sub    $0x14,%esp
  struct Node* node = malloc(sizeof(Node));
     3c6:	6a 0c                	push   $0xc
     3c8:	e8 d3 0f 00 00       	call   13a0 <malloc>
  node->prev = nullptr;
  // char* newData = (char*)malloc(sizeof(char) * 1000);
  // mystrcpy(newData, data);
  node->data = data;// newData;
     3cd:	8b 55 08             	mov    0x8(%ebp),%edx
  node->prev = nullptr;
     3d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  // strcpy(node->data, data);
  node->next = nullptr;
     3d6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  node->data = data;// newData;
     3dd:	89 50 04             	mov    %edx,0x4(%eax)
  return node;
}
     3e0:	c9                   	leave  
     3e1:	c3                   	ret    
     3e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003f0 <MakeLinkedList>:

LinkedList* MakeLinkedList() {
     3f0:	55                   	push   %ebp
     3f1:	89 e5                	mov    %esp,%ebp
     3f3:	56                   	push   %esi
     3f4:	53                   	push   %ebx
  struct LinkedList* list = malloc(sizeof(LinkedList));
     3f5:	83 ec 0c             	sub    $0xc,%esp
     3f8:	6a 0c                	push   $0xc
     3fa:	e8 a1 0f 00 00       	call   13a0 <malloc>
  struct Node* node = malloc(sizeof(Node));
     3ff:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  struct LinkedList* list = malloc(sizeof(LinkedList));
     406:	89 c6                	mov    %eax,%esi
  struct Node* node = malloc(sizeof(Node));
     408:	e8 93 0f 00 00       	call   13a0 <malloc>
     40d:	89 c3                	mov    %eax,%ebx
  node->prev = nullptr;
     40f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->data = data;// newData;
     415:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  node->next = nullptr;
     41c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  struct Node* node = malloc(sizeof(Node));
     423:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     42a:	e8 71 0f 00 00       	call   13a0 <malloc>
  node->data = data;// newData;
     42f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  Node* head = nullNode(nullptr);
  Node* tail = nullNode(nullptr);
  head->prev = nullptr;
  head->next = tail;
     436:	89 43 08             	mov    %eax,0x8(%ebx)
  head->prev = nullptr;
     439:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  tail->prev = head;
     43f:	89 18                	mov    %ebx,(%eax)
  tail->next = nullptr;
     441:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)

  list->len = 0;
  list->head = head;
  list->tail = tail;
     448:	89 46 04             	mov    %eax,0x4(%esi)
  return list;
}
     44b:	89 f0                	mov    %esi,%eax
  list->len = 0;
     44d:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
  list->head = head;
     454:	89 1e                	mov    %ebx,(%esi)
}
     456:	8d 65 f8             	lea    -0x8(%ebp),%esp
     459:	5b                   	pop    %ebx
     45a:	5e                   	pop    %esi
     45b:	5d                   	pop    %ebp
     45c:	c3                   	ret    
     45d:	8d 76 00             	lea    0x0(%esi),%esi

00000460 <nodeAt>:

Node* nodeAt(struct LinkedList* list, int pos) {
     460:	55                   	push   %ebp
     461:	89 e5                	mov    %esp,%ebp
     463:	53                   	push   %ebx
     464:	8b 45 08             	mov    0x8(%ebp),%eax
     467:	8b 55 0c             	mov    0xc(%ebp),%edx
  // for anything past the end:
  if (pos > list->len)
     46a:	8b 48 08             	mov    0x8(%eax),%ecx
     46d:	39 d1                	cmp    %edx,%ecx
     46f:	7c 2f                	jl     4a0 <nodeAt+0x40>
    return list->tail->prev;
  // for anything before the beginning:
  if ((pos < 0) && ((0 - pos) > list->len))
     471:	85 d2                	test   %edx,%edx
     473:	78 3b                	js     4b0 <nodeAt+0x50>
  if (pos < 0) {
    curNode = list->tail;
    while (++pos != 0)
      curNode = curNode->prev;
  } // start looking from the back
  else if (pos > (list->len / 2)) {
     475:	89 cb                	mov    %ecx,%ebx
     477:	c1 eb 1f             	shr    $0x1f,%ebx
     47a:	01 cb                	add    %ecx,%ebx
     47c:	d1 fb                	sar    %ebx
     47e:	39 d3                	cmp    %edx,%ebx
     480:	7c 4e                	jl     4d0 <nodeAt+0x70>
      cur--;
    }
  } // start looking from the front
  else {
    int cur = 0;
    curNode = list->head->next;
     482:	8b 00                	mov    (%eax),%eax
    while (cur != pos) {
     484:	85 d2                	test   %edx,%edx
    curNode = list->head->next;
     486:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     489:	74 1a                	je     4a5 <nodeAt+0x45>
    int cur = 0;
     48b:	31 c9                	xor    %ecx,%ecx
     48d:	8d 76 00             	lea    0x0(%esi),%esi
      curNode = curNode->next;
      cur++;
     490:	83 c1 01             	add    $0x1,%ecx
      curNode = curNode->next;
     493:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     496:	39 ca                	cmp    %ecx,%edx
     498:	75 f6                	jne    490 <nodeAt+0x30>
    }
  }
  return curNode;
}
     49a:	5b                   	pop    %ebx
     49b:	5d                   	pop    %ebp
     49c:	c3                   	ret    
     49d:	8d 76 00             	lea    0x0(%esi),%esi
    return list->tail->prev;
     4a0:	8b 40 04             	mov    0x4(%eax),%eax
     4a3:	8b 00                	mov    (%eax),%eax
}
     4a5:	5b                   	pop    %ebx
     4a6:	5d                   	pop    %ebp
     4a7:	c3                   	ret    
     4a8:	90                   	nop
     4a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if ((pos < 0) && ((0 - pos) > list->len))
     4b0:	89 d3                	mov    %edx,%ebx
     4b2:	f7 db                	neg    %ebx
     4b4:	39 d9                	cmp    %ebx,%ecx
     4b6:	7c 38                	jl     4f0 <nodeAt+0x90>
    while (++pos != 0)
     4b8:	83 c2 01             	add    $0x1,%edx
    curNode = list->tail;
     4bb:	8b 40 04             	mov    0x4(%eax),%eax
    while (++pos != 0)
     4be:	74 e5                	je     4a5 <nodeAt+0x45>
     4c0:	83 c2 01             	add    $0x1,%edx
      curNode = curNode->prev;
     4c3:	8b 00                	mov    (%eax),%eax
    while (++pos != 0)
     4c5:	75 f9                	jne    4c0 <nodeAt+0x60>
}
     4c7:	5b                   	pop    %ebx
     4c8:	5d                   	pop    %ebp
     4c9:	c3                   	ret    
     4ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while (cur != pos) {
     4d0:	39 d1                	cmp    %edx,%ecx
    curNode = list->tail;
     4d2:	8b 40 04             	mov    0x4(%eax),%eax
    while (cur != pos) {
     4d5:	74 ce                	je     4a5 <nodeAt+0x45>
     4d7:	89 f6                	mov    %esi,%esi
     4d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      cur--;
     4e0:	83 e9 01             	sub    $0x1,%ecx
      curNode = curNode->prev;
     4e3:	8b 00                	mov    (%eax),%eax
    while (cur != pos) {
     4e5:	39 ca                	cmp    %ecx,%edx
     4e7:	75 f7                	jne    4e0 <nodeAt+0x80>
}
     4e9:	5b                   	pop    %ebx
     4ea:	5d                   	pop    %ebp
     4eb:	c3                   	ret    
     4ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return list->head->next;
     4f0:	8b 00                	mov    (%eax),%eax
     4f2:	8b 40 08             	mov    0x8(%eax),%eax
     4f5:	eb ae                	jmp    4a5 <nodeAt+0x45>
     4f7:	89 f6                	mov    %esi,%esi
     4f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000500 <insert>:

void insert(struct LinkedList* list, char* data, int pos) {
     500:	55                   	push   %ebp
     501:	89 e5                	mov    %esp,%ebp
     503:	57                   	push   %edi
     504:	56                   	push   %esi
     505:	53                   	push   %ebx
     506:	83 ec 0c             	sub    $0xc,%esp
  struct Node* atPos = nodeAt(list, pos);
     509:	ff 75 10             	pushl  0x10(%ebp)
     50c:	ff 75 08             	pushl  0x8(%ebp)
void insert(struct LinkedList* list, char* data, int pos) {
     50f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct Node* atPos = nodeAt(list, pos);
     512:	e8 49 ff ff ff       	call   460 <nodeAt>
     517:	83 ec 04             	sub    $0x4,%esp
     51a:	89 c6                	mov    %eax,%esi
  char* newData = (char*)malloc(sizeof(char) * 1000);
     51c:	68 e8 03 00 00       	push   $0x3e8
     521:	e8 7a 0e 00 00       	call   13a0 <malloc>
     526:	8d 8b e7 03 00 00    	lea    0x3e7(%ebx),%ecx
     52c:	89 c7                	mov    %eax,%edi
     52e:	83 c4 10             	add    $0x10,%esp
     531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(--n > 0 && (*s++ = *t++) != 0)
     538:	83 c3 01             	add    $0x1,%ebx
     53b:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     53f:	83 c0 01             	add    $0x1,%eax
     542:	84 d2                	test   %dl,%dl
     544:	88 50 ff             	mov    %dl,-0x1(%eax)
     547:	74 04                	je     54d <insert+0x4d>
     549:	39 d9                	cmp    %ebx,%ecx
     54b:	75 eb                	jne    538 <insert+0x38>
  newData = safestrcpy(newData, data, (sizeof(char) * 1000));
  struct Node* new = malloc(sizeof(Node));
     54d:	83 ec 0c             	sub    $0xc,%esp
  *s = 0;
     550:	c6 00 00             	movb   $0x0,(%eax)
  struct Node* new = malloc(sizeof(Node));
     553:	6a 0c                	push   $0xc
     555:	e8 46 0e 00 00       	call   13a0 <malloc>

  new->data = newData;
     55a:	89 78 04             	mov    %edi,0x4(%eax)
  new->prev = atPos->prev;
     55d:	8b 16                	mov    (%esi),%edx
  new->next = atPos;
     55f:	89 70 08             	mov    %esi,0x8(%eax)
  new->prev = atPos->prev;
     562:	89 10                	mov    %edx,(%eax)
  new->prev->next = new;
     564:	89 42 08             	mov    %eax,0x8(%edx)
  atPos->prev = new;
     567:	89 06                	mov    %eax,(%esi)
  list->len++;
     569:	8b 45 08             	mov    0x8(%ebp),%eax
     56c:	83 40 08 01          	addl   $0x1,0x8(%eax)
}
     570:	8d 65 f4             	lea    -0xc(%ebp),%esp
     573:	5b                   	pop    %ebx
     574:	5e                   	pop    %esi
     575:	5f                   	pop    %edi
     576:	5d                   	pop    %ebp
     577:	c3                   	ret    
     578:	90                   	nop
     579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000580 <prepend>:

void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
     580:	55                   	push   %ebp
     581:	89 e5                	mov    %esp,%ebp
     583:	83 ec 0c             	sub    $0xc,%esp
     586:	6a 00                	push   $0x0
     588:	ff 75 0c             	pushl  0xc(%ebp)
     58b:	ff 75 08             	pushl  0x8(%ebp)
     58e:	e8 6d ff ff ff       	call   500 <insert>
     593:	83 c4 10             	add    $0x10,%esp
     596:	c9                   	leave  
     597:	c3                   	ret    
     598:	90                   	nop
     599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005a0 <append>:
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     5a0:	55                   	push   %ebp
     5a1:	89 e5                	mov    %esp,%ebp
     5a3:	83 ec 0c             	sub    $0xc,%esp
     5a6:	8b 45 08             	mov    0x8(%ebp),%eax
     5a9:	ff 70 08             	pushl  0x8(%eax)
     5ac:	ff 75 0c             	pushl  0xc(%ebp)
     5af:	50                   	push   %eax
     5b0:	e8 4b ff ff ff       	call   500 <insert>
     5b5:	83 c4 10             	add    $0x10,%esp
     5b8:	c9                   	leave  
     5b9:	c3                   	ret    
     5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005c0 <destroyLinkedList>:

void destroyLinkedList(struct LinkedList* list) {
     5c0:	55                   	push   %ebp
     5c1:	89 e5                	mov    %esp,%ebp
     5c3:	57                   	push   %edi
     5c4:	56                   	push   %esi
     5c5:	53                   	push   %ebx
     5c6:	83 ec 0c             	sub    $0xc,%esp
     5c9:	8b 75 08             	mov    0x8(%ebp),%esi
  struct Node* destroyer = list->head;
     5cc:	8b 16                	mov    (%esi),%edx
  struct Node* traveler = destroyer->next;
  while (destroyer != list->tail) {
     5ce:	8b 46 04             	mov    0x4(%esi),%eax
     5d1:	39 c2                	cmp    %eax,%edx
  struct Node* traveler = destroyer->next;
     5d3:	8b 5a 08             	mov    0x8(%edx),%ebx
  while (destroyer != list->tail) {
     5d6:	75 0a                	jne    5e2 <destroyLinkedList+0x22>
     5d8:	eb 1e                	jmp    5f8 <destroyLinkedList+0x38>
     5da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    destroyer = traveler;
    traveler = traveler->next;
     5e0:	89 fb                	mov    %edi,%ebx
    free(destroyer);
     5e2:	83 ec 0c             	sub    $0xc,%esp
    traveler = traveler->next;
     5e5:	8b 7b 08             	mov    0x8(%ebx),%edi
    free(destroyer);
     5e8:	53                   	push   %ebx
     5e9:	e8 22 0d 00 00       	call   1310 <free>
  while (destroyer != list->tail) {
     5ee:	83 c4 10             	add    $0x10,%esp
     5f1:	39 5e 04             	cmp    %ebx,0x4(%esi)
     5f4:	75 ea                	jne    5e0 <destroyLinkedList+0x20>
     5f6:	8b 06                	mov    (%esi),%eax
  }
  free(list->head);
     5f8:	83 ec 0c             	sub    $0xc,%esp
     5fb:	50                   	push   %eax
     5fc:	e8 0f 0d 00 00       	call   1310 <free>
  free(list->tail);
     601:	58                   	pop    %eax
     602:	ff 76 04             	pushl  0x4(%esi)
     605:	e8 06 0d 00 00       	call   1310 <free>
  free(list);
     60a:	89 75 08             	mov    %esi,0x8(%ebp)
     60d:	83 c4 10             	add    $0x10,%esp
     610:	8d 65 f4             	lea    -0xc(%ebp),%esp
     613:	5b                   	pop    %ebx
     614:	5e                   	pop    %esi
     615:	5f                   	pop    %edi
     616:	5d                   	pop    %ebp
  free(list);
     617:	e9 f4 0c 00 00       	jmp    1310 <free>
     61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000620 <end>:
void end(struct File file, char* args) {
     620:	55                   	push   %ebp
     621:	89 e5                	mov    %esp,%ebp
}
     623:	5d                   	pop    %ebp
     624:	c3                   	ret    
     625:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000630 <add>:
     630:	55                   	push   %ebp
     631:	89 e5                	mov    %esp,%ebp
     633:	5d                   	pop    %ebp
     634:	c3                   	ret    
     635:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000640 <drop>:
     640:	55                   	push   %ebp
     641:	89 e5                	mov    %esp,%ebp
     643:	5d                   	pop    %ebp
     644:	c3                   	ret    
     645:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000650 <edit>:
     650:	55                   	push   %ebp
     651:	89 e5                	mov    %esp,%ebp
     653:	5d                   	pop    %ebp
     654:	c3                   	ret    
     655:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000660 <quit>:
     660:	55                   	push   %ebp
     661:	89 e5                	mov    %esp,%ebp
     663:	5d                   	pop    %ebp
     664:	c3                   	ret    
     665:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000670 <bi>:
void bi() {
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	83 ec 10             	sub    $0x10,%esp
  fprintf(2, "bad bi input\n");
     676:	68 98 14 00 00       	push   $0x1498
     67b:	6a 02                	push   $0x2
     67d:	e8 4e 0c 00 00       	call   12d0 <fprintf>
}
     682:	83 c4 10             	add    $0x10,%esp
     685:	c9                   	leave  
     686:	c3                   	ret    
     687:	89 f6                	mov    %esi,%esi
     689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000690 <getLine>:
int getLine(int fileptr, char line[]) {
     690:	55                   	push   %ebp
     691:	89 e5                	mov    %esp,%ebp
     693:	57                   	push   %edi
     694:	56                   	push   %esi
     695:	53                   	push   %ebx
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     696:	31 ff                	xor    %edi,%edi
     698:	8d 75 e7             	lea    -0x19(%ebp),%esi
int getLine(int fileptr, char line[]) {
     69b:	83 ec 28             	sub    $0x28,%esp
     69e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int len = strlen(line);
     6a1:	53                   	push   %ebx
     6a2:	e8 e9 06 00 00       	call   d90 <strlen>
  memset(line, 0, len);
     6a7:	83 c4 0c             	add    $0xc,%esp
     6aa:	50                   	push   %eax
     6ab:	6a 00                	push   $0x0
     6ad:	53                   	push   %ebx
     6ae:	e8 0d 07 00 00       	call   dc0 <memset>
     6b3:	83 c4 10             	add    $0x10,%esp
     6b6:	eb 1e                	jmp    6d6 <getLine+0x46>
     6b8:	90                   	nop
     6b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (*c == '\n') break;
     6c0:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     6c4:	3c 0a                	cmp    $0xa,%al
     6c6:	74 38                	je     700 <getLine+0x70>
    line[i] = *c;
     6c8:	88 04 3b             	mov    %al,(%ebx,%edi,1)
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     6cb:	83 c7 01             	add    $0x1,%edi
     6ce:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
     6d4:	74 42                	je     718 <getLine+0x88>
    if (read(fileptr, c, 1) == 0) return strlen(line);
     6d6:	83 ec 04             	sub    $0x4,%esp
     6d9:	6a 01                	push   $0x1
     6db:	56                   	push   %esi
     6dc:	ff 75 08             	pushl  0x8(%ebp)
     6df:	e8 96 08 00 00       	call   f7a <read>
     6e4:	83 c4 10             	add    $0x10,%esp
     6e7:	85 c0                	test   %eax,%eax
     6e9:	75 d5                	jne    6c0 <getLine+0x30>
     6eb:	83 ec 0c             	sub    $0xc,%esp
     6ee:	53                   	push   %ebx
     6ef:	e8 9c 06 00 00       	call   d90 <strlen>
     6f4:	83 c4 10             	add    $0x10,%esp
}
     6f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6fa:	5b                   	pop    %ebx
     6fb:	5e                   	pop    %esi
     6fc:	5f                   	pop    %edi
     6fd:	5d                   	pop    %ebp
     6fe:	c3                   	ret    
     6ff:	90                   	nop
     700:	8d 57 01             	lea    0x1(%edi),%edx
  line[i + 1] = '\0';
     703:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
     707:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
     70a:	b8 01 00 00 00       	mov    $0x1,%eax
}
     70f:	5b                   	pop    %ebx
     710:	5e                   	pop    %esi
     711:	5f                   	pop    %edi
     712:	5d                   	pop    %ebp
     713:	c3                   	ret    
     714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     718:	ba e8 03 00 00       	mov    $0x3e8,%edx
     71d:	eb e4                	jmp    703 <getLine+0x73>
     71f:	90                   	nop

00000720 <gatherLines>:
void gatherLines(File file) {
     720:	55                   	push   %ebp
     721:	89 e5                	mov    %esp,%ebp
     723:	57                   	push   %edi
     724:	56                   	push   %esi
     725:	53                   	push   %ebx
     726:	8d b5 00 fc ff ff    	lea    -0x400(%ebp),%esi
  int lines = 0;
     72c:	31 db                	xor    %ebx,%ebx
void gatherLines(File file) {
     72e:	81 ec fc 03 00 00    	sub    $0x3fc,%esp
     734:	8b 7d 0c             	mov    0xc(%ebp),%edi
  while (getLine(file.fd, line)) {
     737:	eb 1d                	jmp    756 <gatherLines+0x36>
     739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    append(file.lines, line);
     740:	8b 45 10             	mov    0x10(%ebp),%eax
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     743:	83 ec 04             	sub    $0x4,%esp
    lines++;
     746:	83 c3 01             	add    $0x1,%ebx
     749:	ff 70 08             	pushl  0x8(%eax)
     74c:	56                   	push   %esi
     74d:	50                   	push   %eax
     74e:	e8 ad fd ff ff       	call   500 <insert>
     753:	83 c4 10             	add    $0x10,%esp
  while (getLine(file.fd, line)) {
     756:	83 ec 08             	sub    $0x8,%esp
     759:	56                   	push   %esi
     75a:	57                   	push   %edi
     75b:	e8 30 ff ff ff       	call   690 <getLine>
     760:	83 c4 10             	add    $0x10,%esp
     763:	85 c0                	test   %eax,%eax
     765:	75 d9                	jne    740 <gatherLines+0x20>
  fprintf(2, "%d lines read from %s\n", lines, file.filename);
     767:	ff 75 08             	pushl  0x8(%ebp)
     76a:	53                   	push   %ebx
     76b:	68 a6 14 00 00       	push   $0x14a6
     770:	6a 02                	push   $0x2
     772:	e8 59 0b 00 00       	call   12d0 <fprintf>
}
     777:	83 c4 10             	add    $0x10,%esp
     77a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     77d:	5b                   	pop    %ebx
     77e:	5e                   	pop    %esi
     77f:	5f                   	pop    %edi
     780:	5d                   	pop    %ebp
     781:	c3                   	ret    
     782:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000790 <find>:
int find(char* str, char c) {
     790:	55                   	push   %ebp
     791:	89 e5                	mov    %esp,%ebp
     793:	57                   	push   %edi
     794:	56                   	push   %esi
     795:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     796:	31 db                	xor    %ebx,%ebx
int find(char* str, char c) {
     798:	83 ec 0c             	sub    $0xc,%esp
     79b:	8b 75 08             	mov    0x8(%ebp),%esi
     79e:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
  for (int i = 0; i < strlen(str); i++)
     7a2:	eb 0e                	jmp    7b2 <find+0x22>
     7a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     7a8:	89 f8                	mov    %edi,%eax
     7aa:	38 04 1e             	cmp    %al,(%esi,%ebx,1)
     7ad:	74 18                	je     7c7 <find+0x37>
  for (int i = 0; i < strlen(str); i++)
     7af:	83 c3 01             	add    $0x1,%ebx
     7b2:	83 ec 0c             	sub    $0xc,%esp
     7b5:	56                   	push   %esi
     7b6:	e8 d5 05 00 00       	call   d90 <strlen>
     7bb:	83 c4 10             	add    $0x10,%esp
     7be:	39 d8                	cmp    %ebx,%eax
     7c0:	77 e6                	ja     7a8 <find+0x18>
  return -1;
     7c2:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
     7c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7ca:	89 d8                	mov    %ebx,%eax
     7cc:	5b                   	pop    %ebx
     7cd:	5e                   	pop    %esi
     7ce:	5f                   	pop    %edi
     7cf:	5d                   	pop    %ebp
     7d0:	c3                   	ret    
     7d1:	eb 0d                	jmp    7e0 <substr>
     7d3:	90                   	nop
     7d4:	90                   	nop
     7d5:	90                   	nop
     7d6:	90                   	nop
     7d7:	90                   	nop
     7d8:	90                   	nop
     7d9:	90                   	nop
     7da:	90                   	nop
     7db:	90                   	nop
     7dc:	90                   	nop
     7dd:	90                   	nop
     7de:	90                   	nop
     7df:	90                   	nop

000007e0 <substr>:
void substr(char* dest, char* str, int start, int end) {
     7e0:	55                   	push   %ebp
     7e1:	89 e5                	mov    %esp,%ebp
     7e3:	57                   	push   %edi
     7e4:	56                   	push   %esi
     7e5:	53                   	push   %ebx
     7e6:	83 ec 18             	sub    $0x18,%esp
     7e9:	8b 7d 14             	mov    0x14(%ebp),%edi
  int len = strlen(str);
     7ec:	ff 75 0c             	pushl  0xc(%ebp)
void substr(char* dest, char* str, int start, int end) {
     7ef:	8b 5d 10             	mov    0x10(%ebp),%ebx
     7f2:	8b 75 08             	mov    0x8(%ebp),%esi
  int len = strlen(str);
     7f5:	e8 96 05 00 00       	call   d90 <strlen>
     7fa:	83 c4 10             	add    $0x10,%esp
     7fd:	39 f8                	cmp    %edi,%eax
     7ff:	0f 4e f8             	cmovle %eax,%edi
  while (i < end)
     802:	39 df                	cmp    %ebx,%edi
     804:	7e 1c                	jle    822 <substr+0x42>
     806:	8b 45 0c             	mov    0xc(%ebp),%eax
     809:	29 df                	sub    %ebx,%edi
  int s = 0, i = start;
     80b:	31 d2                	xor    %edx,%edx
     80d:	01 c3                	add    %eax,%ebx
     80f:	90                   	nop
    dest[s++] = str[i++];
     810:	83 c2 01             	add    $0x1,%edx
     813:	0f b6 44 13 ff       	movzbl -0x1(%ebx,%edx,1),%eax
  while (i < end)
     818:	39 fa                	cmp    %edi,%edx
    dest[s++] = str[i++];
     81a:	88 44 16 ff          	mov    %al,-0x1(%esi,%edx,1)
  while (i < end)
     81e:	75 f0                	jne    810 <substr+0x30>
     820:	01 d6                	add    %edx,%esi
  dest[s] = '\0';
     822:	c6 06 00             	movb   $0x0,(%esi)
}
     825:	8d 65 f4             	lea    -0xc(%ebp),%esp
     828:	5b                   	pop    %ebx
     829:	5e                   	pop    %esi
     82a:	5f                   	pop    %edi
     82b:	5d                   	pop    %ebp
     82c:	c3                   	ret    
     82d:	8d 76 00             	lea    0x0(%esi),%esi

00000830 <getArg>:
void getArg(char* dest, char* args, char delimiter) {
     830:	55                   	push   %ebp
     831:	89 e5                	mov    %esp,%ebp
     833:	57                   	push   %edi
     834:	56                   	push   %esi
     835:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     836:	31 db                	xor    %ebx,%ebx
void getArg(char* dest, char* args, char delimiter) {
     838:	83 ec 1c             	sub    $0x1c,%esp
     83b:	8b 75 0c             	mov    0xc(%ebp),%esi
     83e:	0f b6 7d 10          	movzbl 0x10(%ebp),%edi
     842:	eb 10                	jmp    854 <getArg+0x24>
     844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     848:	89 f8                	mov    %edi,%eax
     84a:	3a 04 1e             	cmp    (%esi,%ebx,1),%al
     84d:	8d 53 01             	lea    0x1(%ebx),%edx
     850:	74 19                	je     86b <getArg+0x3b>
     852:	89 d3                	mov    %edx,%ebx
  for (int i = 0; i < strlen(str); i++)
     854:	83 ec 0c             	sub    $0xc,%esp
     857:	56                   	push   %esi
     858:	e8 33 05 00 00       	call   d90 <strlen>
     85d:	83 c4 10             	add    $0x10,%esp
     860:	39 c3                	cmp    %eax,%ebx
     862:	72 e4                	jb     848 <getArg+0x18>
     864:	31 d2                	xor    %edx,%edx
  return -1;
     866:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  substr(dest, args, 0, end);
     86b:	53                   	push   %ebx
     86c:	6a 00                	push   $0x0
     86e:	56                   	push   %esi
     86f:	ff 75 08             	pushl  0x8(%ebp)
     872:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     875:	e8 66 ff ff ff       	call   7e0 <substr>
  substr(args, args, end + 1, (int) strlen(args));
     87a:	89 34 24             	mov    %esi,(%esp)
     87d:	e8 0e 05 00 00       	call   d90 <strlen>
     882:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     885:	50                   	push   %eax
     886:	52                   	push   %edx
     887:	56                   	push   %esi
     888:	56                   	push   %esi
     889:	e8 52 ff ff ff       	call   7e0 <substr>
}
     88e:	83 c4 20             	add    $0x20,%esp
     891:	8d 65 f4             	lea    -0xc(%ebp),%esp
     894:	5b                   	pop    %ebx
     895:	5e                   	pop    %esi
     896:	5f                   	pop    %edi
     897:	5d                   	pop    %ebp
     898:	c3                   	ret    
     899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008a0 <collectRange>:
int collectRange(char* args, int* startptr, int* endptr) {
     8a0:	55                   	push   %ebp
     8a1:	89 e5                	mov    %esp,%ebp
     8a3:	57                   	push   %edi
     8a4:	56                   	push   %esi
     8a5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     8a6:	31 f6                	xor    %esi,%esi
int collectRange(char* args, int* startptr, int* endptr) {
     8a8:	83 ec 2c             	sub    $0x2c,%esp
     8ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
     8ae:	eb 09                	jmp    8b9 <collectRange+0x19>
    if (str[i] == c) return i;
     8b0:	80 3c 33 3a          	cmpb   $0x3a,(%ebx,%esi,1)
     8b4:	74 42                	je     8f8 <collectRange+0x58>
  for (int i = 0; i < strlen(str); i++)
     8b6:	83 c6 01             	add    $0x1,%esi
     8b9:	83 ec 0c             	sub    $0xc,%esp
     8bc:	53                   	push   %ebx
     8bd:	e8 ce 04 00 00       	call   d90 <strlen>
     8c2:	83 c4 10             	add    $0x10,%esp
     8c5:	39 c6                	cmp    %eax,%esi
     8c7:	72 e7                	jb     8b0 <collectRange+0x10>
    if (args[0] == '-') {
     8c9:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     8cc:	0f 84 d6 00 00 00    	je     9a8 <collectRange+0x108>
      *startptr = atoi(args);
     8d2:	83 ec 0c             	sub    $0xc,%esp
     8d5:	53                   	push   %ebx
     8d6:	e8 15 06 00 00       	call   ef0 <atoi>
     8db:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     8de:	83 c4 10             	add    $0x10,%esp
     8e1:	89 01                	mov    %eax,(%ecx)
    *endptr = *startptr;
     8e3:	8b 4d 10             	mov    0x10(%ebp),%ecx
     8e6:	89 01                	mov    %eax,(%ecx)
    return 0;
     8e8:	31 c0                	xor    %eax,%eax
}
     8ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8ed:	5b                   	pop    %ebx
     8ee:	5e                   	pop    %esi
     8ef:	5f                   	pop    %edi
     8f0:	5d                   	pop    %ebp
     8f1:	c3                   	ret    
     8f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  getArg(startstr, args, ':');
     8f8:	8d 75 de             	lea    -0x22(%ebp),%esi
     8fb:	83 ec 04             	sub    $0x4,%esp
     8fe:	6a 3a                	push   $0x3a
     900:	53                   	push   %ebx
     901:	56                   	push   %esi
     902:	e8 29 ff ff ff       	call   830 <getArg>
  if (startstr[0] == '-') {
     907:	83 c4 10             	add    $0x10,%esp
     90a:	80 7d de 2d          	cmpb   $0x2d,-0x22(%ebp)
     90e:	0f 84 3c 01 00 00    	je     a50 <collectRange+0x1b0>
  int negStartFlag = 0, negEndFlag = 0;
     914:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     91b:	31 ff                	xor    %edi,%edi
  if (endstr[0] == '-') {
     91d:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     920:	0f 84 0a 01 00 00    	je     a30 <collectRange+0x190>
  if (strcmp(startstr, "\0") == 0) *startptr = 1;
     926:	83 ec 08             	sub    $0x8,%esp
     929:	68 53 15 00 00       	push   $0x1553
     92e:	56                   	push   %esi
     92f:	e8 0c 04 00 00       	call   d40 <strcmp>
     934:	83 c4 10             	add    $0x10,%esp
     937:	85 c0                	test   %eax,%eax
     939:	0f 85 d1 00 00 00    	jne    a10 <collectRange+0x170>
     93f:	8b 45 0c             	mov    0xc(%ebp),%eax
     942:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  if (strcmp(endstr, "\0") == 0) *endptr = -1;
     948:	83 ec 08             	sub    $0x8,%esp
     94b:	68 53 15 00 00       	push   $0x1553
     950:	53                   	push   %ebx
     951:	e8 ea 03 00 00       	call   d40 <strcmp>
     956:	83 c4 10             	add    $0x10,%esp
     959:	85 c0                	test   %eax,%eax
     95b:	0f 85 97 00 00 00    	jne    9f8 <collectRange+0x158>
     961:	8b 45 10             	mov    0x10(%ebp),%eax
     964:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  if (negStartFlag) *startptr = 0 - *startptr;
     96a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     96d:	85 c0                	test   %eax,%eax
     96f:	74 05                	je     976 <collectRange+0xd6>
     971:	8b 45 0c             	mov    0xc(%ebp),%eax
     974:	f7 18                	negl   (%eax)
  if (negEndFlag) *endptr = 0 - *endptr;
     976:	85 ff                	test   %edi,%edi
     978:	74 05                	je     97f <collectRange+0xdf>
     97a:	8b 45 10             	mov    0x10(%ebp),%eax
     97d:	f7 18                	negl   (%eax)
  if (((*startptr > 0 && *endptr > 0) || 
     97f:	8b 45 0c             	mov    0xc(%ebp),%eax
     982:	8b 00                	mov    (%eax),%eax
     984:	83 f8 00             	cmp    $0x0,%eax
     987:	7e 4f                	jle    9d8 <collectRange+0x138>
     989:	8b 55 10             	mov    0x10(%ebp),%edx
     98c:	8b 12                	mov    (%edx),%edx
     98e:	85 d2                	test   %edx,%edx
     990:	7e 55                	jle    9e7 <collectRange+0x147>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     992:	39 d0                	cmp    %edx,%eax
     994:	0f 9f c0             	setg   %al
}
     997:	8d 65 f4             	lea    -0xc(%ebp),%esp
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     99a:	0f b6 c0             	movzbl %al,%eax
}
     99d:	5b                   	pop    %ebx
     99e:	5e                   	pop    %esi
     99f:	5f                   	pop    %edi
     9a0:	5d                   	pop    %ebp
     9a1:	c3                   	ret    
     9a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      substr(args, args, 1, strlen(args));
     9a8:	83 ec 0c             	sub    $0xc,%esp
     9ab:	53                   	push   %ebx
     9ac:	e8 df 03 00 00       	call   d90 <strlen>
     9b1:	50                   	push   %eax
     9b2:	6a 01                	push   $0x1
     9b4:	53                   	push   %ebx
     9b5:	53                   	push   %ebx
     9b6:	e8 25 fe ff ff       	call   7e0 <substr>
      *startptr = 0 - atoi(args);
     9bb:	83 c4 14             	add    $0x14,%esp
     9be:	53                   	push   %ebx
     9bf:	e8 2c 05 00 00       	call   ef0 <atoi>
     9c4:	8b 7d 0c             	mov    0xc(%ebp),%edi
     9c7:	f7 d8                	neg    %eax
     9c9:	83 c4 10             	add    $0x10,%esp
     9cc:	89 07                	mov    %eax,(%edi)
     9ce:	e9 10 ff ff ff       	jmp    8e3 <collectRange+0x43>
     9d3:	90                   	nop
     9d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (((*startptr > 0 && *endptr > 0) || 
     9d8:	0f 84 0c ff ff ff    	je     8ea <collectRange+0x4a>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     9de:	8b 7d 10             	mov    0x10(%ebp),%edi
     9e1:	8b 17                	mov    (%edi),%edx
     9e3:	85 d2                	test   %edx,%edx
     9e5:	78 ab                	js     992 <collectRange+0xf2>
}
     9e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
     9ea:	31 c0                	xor    %eax,%eax
}
     9ec:	5b                   	pop    %ebx
     9ed:	5e                   	pop    %esi
     9ee:	5f                   	pop    %edi
     9ef:	5d                   	pop    %ebp
     9f0:	c3                   	ret    
     9f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else *endptr = atoi(endstr);
     9f8:	83 ec 0c             	sub    $0xc,%esp
     9fb:	53                   	push   %ebx
     9fc:	e8 ef 04 00 00       	call   ef0 <atoi>
     a01:	8b 55 10             	mov    0x10(%ebp),%edx
     a04:	83 c4 10             	add    $0x10,%esp
     a07:	89 02                	mov    %eax,(%edx)
     a09:	e9 5c ff ff ff       	jmp    96a <collectRange+0xca>
     a0e:	66 90                	xchg   %ax,%ax
  else *startptr = atoi(startstr);
     a10:	83 ec 0c             	sub    $0xc,%esp
     a13:	56                   	push   %esi
     a14:	e8 d7 04 00 00       	call   ef0 <atoi>
     a19:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     a1c:	83 c4 10             	add    $0x10,%esp
     a1f:	89 01                	mov    %eax,(%ecx)
     a21:	e9 22 ff ff ff       	jmp    948 <collectRange+0xa8>
     a26:	8d 76 00             	lea    0x0(%esi),%esi
     a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    substr(endstr, endstr, 1, strlen(endstr));
     a30:	83 ec 0c             	sub    $0xc,%esp
    negEndFlag = 1;
     a33:	bf 01 00 00 00       	mov    $0x1,%edi
    substr(endstr, endstr, 1, strlen(endstr));
     a38:	53                   	push   %ebx
     a39:	e8 52 03 00 00       	call   d90 <strlen>
     a3e:	50                   	push   %eax
     a3f:	6a 01                	push   $0x1
     a41:	53                   	push   %ebx
     a42:	53                   	push   %ebx
     a43:	e8 98 fd ff ff       	call   7e0 <substr>
     a48:	83 c4 20             	add    $0x20,%esp
     a4b:	e9 d6 fe ff ff       	jmp    926 <collectRange+0x86>
    substr(startstr, startstr, 1, strlen(startstr));
     a50:	83 ec 0c             	sub    $0xc,%esp
     a53:	56                   	push   %esi
     a54:	e8 37 03 00 00       	call   d90 <strlen>
     a59:	50                   	push   %eax
     a5a:	6a 01                	push   $0x1
     a5c:	56                   	push   %esi
     a5d:	56                   	push   %esi
     a5e:	e8 7d fd ff ff       	call   7e0 <substr>
     a63:	83 c4 20             	add    $0x20,%esp
    negStartFlag = 1;
     a66:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
     a6d:	e9 a9 fe ff ff       	jmp    91b <collectRange+0x7b>
     a72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a80 <list>:
void list(struct File file, char* args) {
     a80:	55                   	push   %ebp
     a81:	89 e5                	mov    %esp,%ebp
     a83:	57                   	push   %edi
     a84:	56                   	push   %esi
     a85:	53                   	push   %ebx
     a86:	83 ec 28             	sub    $0x28,%esp
     a89:	8b 5d 14             	mov    0x14(%ebp),%ebx
     a8c:	8b 75 10             	mov    0x10(%ebp),%esi
  if (strlen(args) < 1) {
     a8f:	53                   	push   %ebx
     a90:	e8 fb 02 00 00       	call   d90 <strlen>
     a95:	83 c4 10             	add    $0x10,%esp
     a98:	85 c0                	test   %eax,%eax
     a9a:	75 24                	jne    ac0 <list+0x40>
    fprintf(2, "you need to give a range to list\n");
     a9c:	83 ec 08             	sub    $0x8,%esp
     a9f:	68 58 15 00 00       	push   $0x1558
     aa4:	6a 02                	push   $0x2
     aa6:	e8 25 08 00 00       	call   12d0 <fprintf>
    return;
     aab:	83 c4 10             	add    $0x10,%esp
}
     aae:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ab1:	5b                   	pop    %ebx
     ab2:	5e                   	pop    %esi
     ab3:	5f                   	pop    %edi
     ab4:	5d                   	pop    %ebp
     ab5:	c3                   	ret    
     ab6:	8d 76 00             	lea    0x0(%esi),%esi
     ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if (collectRange(args, &start, &end) == 1) {
     ac0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     ac3:	83 ec 04             	sub    $0x4,%esp
     ac6:	50                   	push   %eax
     ac7:	8d 45 e0             	lea    -0x20(%ebp),%eax
     aca:	50                   	push   %eax
     acb:	53                   	push   %ebx
     acc:	e8 cf fd ff ff       	call   8a0 <collectRange>
     ad1:	83 c4 10             	add    $0x10,%esp
     ad4:	83 f8 01             	cmp    $0x1,%eax
     ad7:	0f 84 93 00 00 00    	je     b70 <list+0xf0>
  str[len] = '\0';
}

// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
  return nodeAt(list, pos-1);
     add:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ae0:	83 ec 08             	sub    $0x8,%esp
     ae3:	83 e8 01             	sub    $0x1,%eax
     ae6:	50                   	push   %eax
     ae7:	56                   	push   %esi
     ae8:	e8 73 f9 ff ff       	call   460 <nodeAt>
  struct Node* curNode = (lineAt(file.lines, start))->prev;
     aed:	8b 18                	mov    (%eax),%ebx
  return nodeAt(list, pos-1);
     aef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     af2:	5f                   	pop    %edi
     af3:	5a                   	pop    %edx
     af4:	83 e8 01             	sub    $0x1,%eax
     af7:	50                   	push   %eax
     af8:	56                   	push   %esi
     af9:	e8 62 f9 ff ff       	call   460 <nodeAt>
     afe:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
     b01:	39 d8                	cmp    %ebx,%eax
  return nodeAt(list, pos-1);
     b03:	89 c7                	mov    %eax,%edi
  while (curNode != stopNode) {
     b05:	74 a7                	je     aae <list+0x2e>
    curNode = curNode->next;
     b07:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) {
     b0a:	3b 5e 04             	cmp    0x4(%esi),%ebx
     b0d:	74 22                	je     b31 <list+0xb1>
     b0f:	90                   	nop
    fprintf(2, "%s\n", curNode->data);
     b10:	83 ec 04             	sub    $0x4,%esp
     b13:	ff 73 04             	pushl  0x4(%ebx)
     b16:	68 b9 14 00 00       	push   $0x14b9
     b1b:	6a 02                	push   $0x2
     b1d:	e8 ae 07 00 00       	call   12d0 <fprintf>
  while (curNode != stopNode) {
     b22:	83 c4 10             	add    $0x10,%esp
     b25:	39 df                	cmp    %ebx,%edi
     b27:	74 85                	je     aae <list+0x2e>
    curNode = curNode->next;
     b29:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) {
     b2c:	39 5e 04             	cmp    %ebx,0x4(%esi)
     b2f:	75 df                	jne    b10 <list+0x90>
      fprintf(2, "________________________________\n");
     b31:	83 ec 08             	sub    $0x8,%esp
     b34:	68 ac 15 00 00       	push   $0x15ac
     b39:	6a 02                	push   $0x2
     b3b:	e8 90 07 00 00       	call   12d0 <fprintf>
      fprintf(2, "make sure start is less than end\n");
     b40:	58                   	pop    %eax
     b41:	5a                   	pop    %edx
     b42:	68 d0 15 00 00       	push   $0x15d0
     b47:	6a 02                	push   $0x2
     b49:	e8 82 07 00 00       	call   12d0 <fprintf>
      fprintf(2, "printed till EOF\n");
     b4e:	59                   	pop    %ecx
     b4f:	5b                   	pop    %ebx
     b50:	68 bd 14 00 00       	push   $0x14bd
     b55:	6a 02                	push   $0x2
     b57:	e8 74 07 00 00       	call   12d0 <fprintf>
      return;
     b5c:	83 c4 10             	add    $0x10,%esp
}
     b5f:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b62:	5b                   	pop    %ebx
     b63:	5e                   	pop    %esi
     b64:	5f                   	pop    %edi
     b65:	5d                   	pop    %ebp
     b66:	c3                   	ret    
     b67:	89 f6                	mov    %esi,%esi
     b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    fprintf(2, "error: start index is larger than end index\n");
     b70:	83 ec 08             	sub    $0x8,%esp
     b73:	68 7c 15 00 00       	push   $0x157c
     b78:	6a 02                	push   $0x2
     b7a:	e8 51 07 00 00       	call   12d0 <fprintf>
    return;
     b7f:	83 c4 10             	add    $0x10,%esp
}
     b82:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b85:	5b                   	pop    %ebx
     b86:	5e                   	pop    %esi
     b87:	5f                   	pop    %edi
     b88:	5d                   	pop    %ebp
     b89:	c3                   	ret    
     b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000b90 <toUpper>:
void toUpper(char* str) {
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	8b 55 08             	mov    0x8(%ebp),%edx
  while (str[i] != '\0') {
     b96:	0f b6 02             	movzbl (%edx),%eax
     b99:	84 c0                	test   %al,%al
     b9b:	74 1a                	je     bb7 <toUpper+0x27>
     b9d:	8d 76 00             	lea    0x0(%esi),%esi
    if (c <= 'z' && c >= 'a')
     ba0:	8d 48 9f             	lea    -0x61(%eax),%ecx
     ba3:	80 f9 19             	cmp    $0x19,%cl
     ba6:	77 05                	ja     bad <toUpper+0x1d>
      str[i] += ('Z' - 'z');
     ba8:	83 e8 20             	sub    $0x20,%eax
     bab:	88 02                	mov    %al,(%edx)
     bad:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     bb0:	0f b6 02             	movzbl (%edx),%eax
     bb3:	84 c0                	test   %al,%al
     bb5:	75 e9                	jne    ba0 <toUpper+0x10>
}
     bb7:	5d                   	pop    %ebp
     bb8:	c3                   	ret    
     bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000bc0 <toLower>:
void toLower(char* str) {
     bc0:	55                   	push   %ebp
     bc1:	89 e5                	mov    %esp,%ebp
     bc3:	8b 55 08             	mov    0x8(%ebp),%edx
  while (str[i] != '\0') {
     bc6:	0f b6 02             	movzbl (%edx),%eax
     bc9:	84 c0                	test   %al,%al
     bcb:	74 1a                	je     be7 <toLower+0x27>
     bcd:	8d 76 00             	lea    0x0(%esi),%esi
    if (c <= 'Z' && c >= 'A')
     bd0:	8d 48 bf             	lea    -0x41(%eax),%ecx
     bd3:	80 f9 19             	cmp    $0x19,%cl
     bd6:	77 05                	ja     bdd <toLower+0x1d>
      str[i] -= ('Z' - 'z');
     bd8:	83 c0 20             	add    $0x20,%eax
     bdb:	88 02                	mov    %al,(%edx)
     bdd:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     be0:	0f b6 02             	movzbl (%edx),%eax
     be3:	84 c0                	test   %al,%al
     be5:	75 e9                	jne    bd0 <toLower+0x10>
}
     be7:	5d                   	pop    %ebp
     be8:	c3                   	ret    
     be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000bf0 <unline>:
void unline(char* str) {
     bf0:	55                   	push   %ebp
     bf1:	89 e5                	mov    %esp,%ebp
     bf3:	53                   	push   %ebx
     bf4:	83 ec 10             	sub    $0x10,%esp
     bf7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str) - 1;
     bfa:	53                   	push   %ebx
     bfb:	e8 90 01 00 00       	call   d90 <strlen>
     c00:	8d 50 ff             	lea    -0x1(%eax),%edx
  for (; len > 0; len--) {
     c03:	83 c4 10             	add    $0x10,%esp
     c06:	85 d2                	test   %edx,%edx
     c08:	7e 36                	jle    c40 <unline+0x50>
    if (c == '\n')
     c0a:	80 7c 03 ff 0a       	cmpb   $0xa,-0x1(%ebx,%eax,1)
     c0f:	74 2f                	je     c40 <unline+0x50>
     c11:	8d 44 03 fe          	lea    -0x2(%ebx,%eax,1),%eax
     c15:	eb 12                	jmp    c29 <unline+0x39>
     c17:	89 f6                	mov    %esi,%esi
     c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     c20:	83 e8 01             	sub    $0x1,%eax
     c23:	80 78 01 0a          	cmpb   $0xa,0x1(%eax)
     c27:	74 06                	je     c2f <unline+0x3f>
  for (; len > 0; len--) {
     c29:	39 c3                	cmp    %eax,%ebx
     c2b:	89 c2                	mov    %eax,%edx
     c2d:	75 f1                	jne    c20 <unline+0x30>
  str[len] = '\0';
     c2f:	c6 02 00             	movb   $0x0,(%edx)
}
     c32:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c35:	c9                   	leave  
     c36:	c3                   	ret    
     c37:	89 f6                	mov    %esi,%esi
     c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     c40:	01 da                	add    %ebx,%edx
  str[len] = '\0';
     c42:	c6 02 00             	movb   $0x0,(%edx)
}
     c45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c48:	c9                   	leave  
     c49:	c3                   	ret    
     c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000c50 <lineAt>:
Node* lineAt(struct LinkedList* list, int pos) {
     c50:	55                   	push   %ebp
     c51:	89 e5                	mov    %esp,%ebp
  return nodeAt(list, pos-1);
     c53:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
}
     c57:	5d                   	pop    %ebp
  return nodeAt(list, pos-1);
     c58:	e9 03 f8 ff ff       	jmp    460 <nodeAt>
     c5d:	8d 76 00             	lea    0x0(%esi),%esi

00000c60 <printl>:

void printl(int lineNum, char* line) {
     c60:	55                   	push   %ebp
     c61:	89 e5                	mov    %esp,%ebp
     c63:	83 ec 08             	sub    $0x8,%esp
     c66:	8b 45 08             	mov    0x8(%ebp),%eax
  if (lineNum < 10)
     c69:	83 f8 09             	cmp    $0x9,%eax
     c6c:	7e 3a                	jle    ca8 <printl+0x48>
    fprintf(2, "%d  | %s\n", lineNum, line);
  else if (lineNum < 100)
     c6e:	83 f8 63             	cmp    $0x63,%eax
     c71:	7e 1d                	jle    c90 <printl+0x30>
    fprintf(2, "%d | %s\n", lineNum, line);
  else
    fprintf(2, "%d| %s\n", lineNum, line);
     c73:	ff 75 0c             	pushl  0xc(%ebp)
     c76:	50                   	push   %eax
     c77:	68 e2 14 00 00       	push   $0x14e2
     c7c:	6a 02                	push   $0x2
     c7e:	e8 4d 06 00 00       	call   12d0 <fprintf>
     c83:	83 c4 10             	add    $0x10,%esp
     c86:	c9                   	leave  
     c87:	c3                   	ret    
     c88:	90                   	nop
     c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "%d | %s\n", lineNum, line);
     c90:	ff 75 0c             	pushl  0xc(%ebp)
     c93:	50                   	push   %eax
     c94:	68 d9 14 00 00       	push   $0x14d9
     c99:	6a 02                	push   $0x2
     c9b:	e8 30 06 00 00       	call   12d0 <fprintf>
     ca0:	83 c4 10             	add    $0x10,%esp
     ca3:	c9                   	leave  
     ca4:	c3                   	ret    
     ca5:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "%d  | %s\n", lineNum, line);
     ca8:	ff 75 0c             	pushl  0xc(%ebp)
     cab:	50                   	push   %eax
     cac:	68 cf 14 00 00       	push   $0x14cf
     cb1:	6a 02                	push   $0x2
     cb3:	e8 18 06 00 00       	call   12d0 <fprintf>
     cb8:	83 c4 10             	add    $0x10,%esp
     cbb:	c9                   	leave  
     cbc:	c3                   	ret    
     cbd:	8d 76 00             	lea    0x0(%esi),%esi

00000cc0 <show>:
void show(struct File file, char* args) {
     cc0:	55                   	push   %ebp
     cc1:	89 e5                	mov    %esp,%ebp
     cc3:	57                   	push   %edi
     cc4:	56                   	push   %esi
     cc5:	53                   	push   %ebx
     cc6:	83 ec 0c             	sub    $0xc,%esp
     cc9:	8b 7d 10             	mov    0x10(%ebp),%edi
  struct Node* curr = file.lines->head->next;
     ccc:	8b 07                	mov    (%edi),%eax
     cce:	8b 58 08             	mov    0x8(%eax),%ebx
  while (curr != file.lines->tail) {
     cd1:	3b 5f 04             	cmp    0x4(%edi),%ebx
     cd4:	74 24                	je     cfa <show+0x3a>
  int lineNum = 1;
     cd6:	be 01 00 00 00       	mov    $0x1,%esi
     cdb:	90                   	nop
     cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printl(lineNum, curr->data);
     ce0:	83 ec 08             	sub    $0x8,%esp
     ce3:	ff 73 04             	pushl  0x4(%ebx)
     ce6:	56                   	push   %esi
    lineNum++;
     ce7:	83 c6 01             	add    $0x1,%esi
    printl(lineNum, curr->data);
     cea:	e8 71 ff ff ff       	call   c60 <printl>
    curr = curr->next;
     cef:	8b 5b 08             	mov    0x8(%ebx),%ebx
  while (curr != file.lines->tail) {
     cf2:	83 c4 10             	add    $0x10,%esp
     cf5:	39 5f 04             	cmp    %ebx,0x4(%edi)
     cf8:	75 e6                	jne    ce0 <show+0x20>
}
     cfa:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cfd:	5b                   	pop    %ebx
     cfe:	5e                   	pop    %esi
     cff:	5f                   	pop    %edi
     d00:	5d                   	pop    %ebp
     d01:	c3                   	ret    
     d02:	66 90                	xchg   %ax,%ax
     d04:	66 90                	xchg   %ax,%ax
     d06:	66 90                	xchg   %ax,%ax
     d08:	66 90                	xchg   %ax,%ax
     d0a:	66 90                	xchg   %ax,%ax
     d0c:	66 90                	xchg   %ax,%ax
     d0e:	66 90                	xchg   %ax,%ax

00000d10 <strcpy>:
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	53                   	push   %ebx
     d14:	8b 45 08             	mov    0x8(%ebp),%eax
     d17:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     d1a:	89 c2                	mov    %eax,%edx
     d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d20:	83 c1 01             	add    $0x1,%ecx
     d23:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     d27:	83 c2 01             	add    $0x1,%edx
     d2a:	84 db                	test   %bl,%bl
     d2c:	88 5a ff             	mov    %bl,-0x1(%edx)
     d2f:	75 ef                	jne    d20 <strcpy+0x10>
     d31:	5b                   	pop    %ebx
     d32:	5d                   	pop    %ebp
     d33:	c3                   	ret    
     d34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     d3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000d40 <strcmp>:
     d40:	55                   	push   %ebp
     d41:	89 e5                	mov    %esp,%ebp
     d43:	53                   	push   %ebx
     d44:	8b 55 08             	mov    0x8(%ebp),%edx
     d47:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     d4a:	0f b6 02             	movzbl (%edx),%eax
     d4d:	0f b6 19             	movzbl (%ecx),%ebx
     d50:	84 c0                	test   %al,%al
     d52:	75 1c                	jne    d70 <strcmp+0x30>
     d54:	eb 2a                	jmp    d80 <strcmp+0x40>
     d56:	8d 76 00             	lea    0x0(%esi),%esi
     d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     d60:	83 c2 01             	add    $0x1,%edx
     d63:	0f b6 02             	movzbl (%edx),%eax
     d66:	83 c1 01             	add    $0x1,%ecx
     d69:	0f b6 19             	movzbl (%ecx),%ebx
     d6c:	84 c0                	test   %al,%al
     d6e:	74 10                	je     d80 <strcmp+0x40>
     d70:	38 d8                	cmp    %bl,%al
     d72:	74 ec                	je     d60 <strcmp+0x20>
     d74:	29 d8                	sub    %ebx,%eax
     d76:	5b                   	pop    %ebx
     d77:	5d                   	pop    %ebp
     d78:	c3                   	ret    
     d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d80:	31 c0                	xor    %eax,%eax
     d82:	29 d8                	sub    %ebx,%eax
     d84:	5b                   	pop    %ebx
     d85:	5d                   	pop    %ebp
     d86:	c3                   	ret    
     d87:	89 f6                	mov    %esi,%esi
     d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d90 <strlen>:
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	8b 4d 08             	mov    0x8(%ebp),%ecx
     d96:	80 39 00             	cmpb   $0x0,(%ecx)
     d99:	74 15                	je     db0 <strlen+0x20>
     d9b:	31 d2                	xor    %edx,%edx
     d9d:	8d 76 00             	lea    0x0(%esi),%esi
     da0:	83 c2 01             	add    $0x1,%edx
     da3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     da7:	89 d0                	mov    %edx,%eax
     da9:	75 f5                	jne    da0 <strlen+0x10>
     dab:	5d                   	pop    %ebp
     dac:	c3                   	ret    
     dad:	8d 76 00             	lea    0x0(%esi),%esi
     db0:	31 c0                	xor    %eax,%eax
     db2:	5d                   	pop    %ebp
     db3:	c3                   	ret    
     db4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     dba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000dc0 <memset>:
     dc0:	55                   	push   %ebp
     dc1:	89 e5                	mov    %esp,%ebp
     dc3:	57                   	push   %edi
     dc4:	8b 55 08             	mov    0x8(%ebp),%edx
     dc7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     dca:	8b 45 0c             	mov    0xc(%ebp),%eax
     dcd:	89 d7                	mov    %edx,%edi
     dcf:	fc                   	cld    
     dd0:	f3 aa                	rep stos %al,%es:(%edi)
     dd2:	89 d0                	mov    %edx,%eax
     dd4:	5f                   	pop    %edi
     dd5:	5d                   	pop    %ebp
     dd6:	c3                   	ret    
     dd7:	89 f6                	mov    %esi,%esi
     dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000de0 <strchr>:
     de0:	55                   	push   %ebp
     de1:	89 e5                	mov    %esp,%ebp
     de3:	53                   	push   %ebx
     de4:	8b 45 08             	mov    0x8(%ebp),%eax
     de7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     dea:	0f b6 10             	movzbl (%eax),%edx
     ded:	84 d2                	test   %dl,%dl
     def:	74 1d                	je     e0e <strchr+0x2e>
     df1:	38 d3                	cmp    %dl,%bl
     df3:	89 d9                	mov    %ebx,%ecx
     df5:	75 0d                	jne    e04 <strchr+0x24>
     df7:	eb 17                	jmp    e10 <strchr+0x30>
     df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e00:	38 ca                	cmp    %cl,%dl
     e02:	74 0c                	je     e10 <strchr+0x30>
     e04:	83 c0 01             	add    $0x1,%eax
     e07:	0f b6 10             	movzbl (%eax),%edx
     e0a:	84 d2                	test   %dl,%dl
     e0c:	75 f2                	jne    e00 <strchr+0x20>
     e0e:	31 c0                	xor    %eax,%eax
     e10:	5b                   	pop    %ebx
     e11:	5d                   	pop    %ebp
     e12:	c3                   	ret    
     e13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000e20 <gets>:
     e20:	55                   	push   %ebp
     e21:	89 e5                	mov    %esp,%ebp
     e23:	57                   	push   %edi
     e24:	56                   	push   %esi
     e25:	53                   	push   %ebx
     e26:	31 f6                	xor    %esi,%esi
     e28:	89 f3                	mov    %esi,%ebx
     e2a:	83 ec 1c             	sub    $0x1c,%esp
     e2d:	8b 7d 08             	mov    0x8(%ebp),%edi
     e30:	eb 2f                	jmp    e61 <gets+0x41>
     e32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e38:	8d 45 e7             	lea    -0x19(%ebp),%eax
     e3b:	83 ec 04             	sub    $0x4,%esp
     e3e:	6a 01                	push   $0x1
     e40:	50                   	push   %eax
     e41:	6a 00                	push   $0x0
     e43:	e8 32 01 00 00       	call   f7a <read>
     e48:	83 c4 10             	add    $0x10,%esp
     e4b:	85 c0                	test   %eax,%eax
     e4d:	7e 1c                	jle    e6b <gets+0x4b>
     e4f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     e53:	83 c7 01             	add    $0x1,%edi
     e56:	88 47 ff             	mov    %al,-0x1(%edi)
     e59:	3c 0a                	cmp    $0xa,%al
     e5b:	74 23                	je     e80 <gets+0x60>
     e5d:	3c 0d                	cmp    $0xd,%al
     e5f:	74 1f                	je     e80 <gets+0x60>
     e61:	83 c3 01             	add    $0x1,%ebx
     e64:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     e67:	89 fe                	mov    %edi,%esi
     e69:	7c cd                	jl     e38 <gets+0x18>
     e6b:	89 f3                	mov    %esi,%ebx
     e6d:	8b 45 08             	mov    0x8(%ebp),%eax
     e70:	c6 03 00             	movb   $0x0,(%ebx)
     e73:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e76:	5b                   	pop    %ebx
     e77:	5e                   	pop    %esi
     e78:	5f                   	pop    %edi
     e79:	5d                   	pop    %ebp
     e7a:	c3                   	ret    
     e7b:	90                   	nop
     e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e80:	8b 75 08             	mov    0x8(%ebp),%esi
     e83:	8b 45 08             	mov    0x8(%ebp),%eax
     e86:	01 de                	add    %ebx,%esi
     e88:	89 f3                	mov    %esi,%ebx
     e8a:	c6 03 00             	movb   $0x0,(%ebx)
     e8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e90:	5b                   	pop    %ebx
     e91:	5e                   	pop    %esi
     e92:	5f                   	pop    %edi
     e93:	5d                   	pop    %ebp
     e94:	c3                   	ret    
     e95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ea0 <stat>:
     ea0:	55                   	push   %ebp
     ea1:	89 e5                	mov    %esp,%ebp
     ea3:	56                   	push   %esi
     ea4:	53                   	push   %ebx
     ea5:	83 ec 08             	sub    $0x8,%esp
     ea8:	6a 00                	push   $0x0
     eaa:	ff 75 08             	pushl  0x8(%ebp)
     ead:	e8 f0 00 00 00       	call   fa2 <open>
     eb2:	83 c4 10             	add    $0x10,%esp
     eb5:	85 c0                	test   %eax,%eax
     eb7:	78 27                	js     ee0 <stat+0x40>
     eb9:	83 ec 08             	sub    $0x8,%esp
     ebc:	ff 75 0c             	pushl  0xc(%ebp)
     ebf:	89 c3                	mov    %eax,%ebx
     ec1:	50                   	push   %eax
     ec2:	e8 f3 00 00 00       	call   fba <fstat>
     ec7:	89 1c 24             	mov    %ebx,(%esp)
     eca:	89 c6                	mov    %eax,%esi
     ecc:	e8 b9 00 00 00       	call   f8a <close>
     ed1:	83 c4 10             	add    $0x10,%esp
     ed4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ed7:	89 f0                	mov    %esi,%eax
     ed9:	5b                   	pop    %ebx
     eda:	5e                   	pop    %esi
     edb:	5d                   	pop    %ebp
     edc:	c3                   	ret    
     edd:	8d 76 00             	lea    0x0(%esi),%esi
     ee0:	be ff ff ff ff       	mov    $0xffffffff,%esi
     ee5:	eb ed                	jmp    ed4 <stat+0x34>
     ee7:	89 f6                	mov    %esi,%esi
     ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ef0 <atoi>:
     ef0:	55                   	push   %ebp
     ef1:	89 e5                	mov    %esp,%ebp
     ef3:	53                   	push   %ebx
     ef4:	8b 4d 08             	mov    0x8(%ebp),%ecx
     ef7:	0f be 11             	movsbl (%ecx),%edx
     efa:	8d 42 d0             	lea    -0x30(%edx),%eax
     efd:	3c 09                	cmp    $0x9,%al
     eff:	b8 00 00 00 00       	mov    $0x0,%eax
     f04:	77 1f                	ja     f25 <atoi+0x35>
     f06:	8d 76 00             	lea    0x0(%esi),%esi
     f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     f10:	8d 04 80             	lea    (%eax,%eax,4),%eax
     f13:	83 c1 01             	add    $0x1,%ecx
     f16:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
     f1a:	0f be 11             	movsbl (%ecx),%edx
     f1d:	8d 5a d0             	lea    -0x30(%edx),%ebx
     f20:	80 fb 09             	cmp    $0x9,%bl
     f23:	76 eb                	jbe    f10 <atoi+0x20>
     f25:	5b                   	pop    %ebx
     f26:	5d                   	pop    %ebp
     f27:	c3                   	ret    
     f28:	90                   	nop
     f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000f30 <memmove>:
     f30:	55                   	push   %ebp
     f31:	89 e5                	mov    %esp,%ebp
     f33:	56                   	push   %esi
     f34:	53                   	push   %ebx
     f35:	8b 5d 10             	mov    0x10(%ebp),%ebx
     f38:	8b 45 08             	mov    0x8(%ebp),%eax
     f3b:	8b 75 0c             	mov    0xc(%ebp),%esi
     f3e:	85 db                	test   %ebx,%ebx
     f40:	7e 14                	jle    f56 <memmove+0x26>
     f42:	31 d2                	xor    %edx,%edx
     f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f48:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     f4c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     f4f:	83 c2 01             	add    $0x1,%edx
     f52:	39 d3                	cmp    %edx,%ebx
     f54:	75 f2                	jne    f48 <memmove+0x18>
     f56:	5b                   	pop    %ebx
     f57:	5e                   	pop    %esi
     f58:	5d                   	pop    %ebp
     f59:	c3                   	ret    

00000f5a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     f5a:	b8 01 00 00 00       	mov    $0x1,%eax
     f5f:	cd 40                	int    $0x40
     f61:	c3                   	ret    

00000f62 <exit>:
SYSCALL(exit)
     f62:	b8 02 00 00 00       	mov    $0x2,%eax
     f67:	cd 40                	int    $0x40
     f69:	c3                   	ret    

00000f6a <wait>:
SYSCALL(wait)
     f6a:	b8 03 00 00 00       	mov    $0x3,%eax
     f6f:	cd 40                	int    $0x40
     f71:	c3                   	ret    

00000f72 <pipe>:
SYSCALL(pipe)
     f72:	b8 04 00 00 00       	mov    $0x4,%eax
     f77:	cd 40                	int    $0x40
     f79:	c3                   	ret    

00000f7a <read>:
SYSCALL(read)
     f7a:	b8 05 00 00 00       	mov    $0x5,%eax
     f7f:	cd 40                	int    $0x40
     f81:	c3                   	ret    

00000f82 <write>:
SYSCALL(write)
     f82:	b8 10 00 00 00       	mov    $0x10,%eax
     f87:	cd 40                	int    $0x40
     f89:	c3                   	ret    

00000f8a <close>:
SYSCALL(close)
     f8a:	b8 15 00 00 00       	mov    $0x15,%eax
     f8f:	cd 40                	int    $0x40
     f91:	c3                   	ret    

00000f92 <kill>:
SYSCALL(kill)
     f92:	b8 06 00 00 00       	mov    $0x6,%eax
     f97:	cd 40                	int    $0x40
     f99:	c3                   	ret    

00000f9a <exec>:
SYSCALL(exec)
     f9a:	b8 07 00 00 00       	mov    $0x7,%eax
     f9f:	cd 40                	int    $0x40
     fa1:	c3                   	ret    

00000fa2 <open>:
SYSCALL(open)
     fa2:	b8 0f 00 00 00       	mov    $0xf,%eax
     fa7:	cd 40                	int    $0x40
     fa9:	c3                   	ret    

00000faa <mknod>:
SYSCALL(mknod)
     faa:	b8 11 00 00 00       	mov    $0x11,%eax
     faf:	cd 40                	int    $0x40
     fb1:	c3                   	ret    

00000fb2 <unlink>:
SYSCALL(unlink)
     fb2:	b8 12 00 00 00       	mov    $0x12,%eax
     fb7:	cd 40                	int    $0x40
     fb9:	c3                   	ret    

00000fba <fstat>:
SYSCALL(fstat)
     fba:	b8 08 00 00 00       	mov    $0x8,%eax
     fbf:	cd 40                	int    $0x40
     fc1:	c3                   	ret    

00000fc2 <link>:
SYSCALL(link)
     fc2:	b8 13 00 00 00       	mov    $0x13,%eax
     fc7:	cd 40                	int    $0x40
     fc9:	c3                   	ret    

00000fca <mkdir>:
SYSCALL(mkdir)
     fca:	b8 14 00 00 00       	mov    $0x14,%eax
     fcf:	cd 40                	int    $0x40
     fd1:	c3                   	ret    

00000fd2 <chdir>:
SYSCALL(chdir)
     fd2:	b8 09 00 00 00       	mov    $0x9,%eax
     fd7:	cd 40                	int    $0x40
     fd9:	c3                   	ret    

00000fda <dup>:
SYSCALL(dup)
     fda:	b8 0a 00 00 00       	mov    $0xa,%eax
     fdf:	cd 40                	int    $0x40
     fe1:	c3                   	ret    

00000fe2 <getpid>:
SYSCALL(getpid)
     fe2:	b8 0b 00 00 00       	mov    $0xb,%eax
     fe7:	cd 40                	int    $0x40
     fe9:	c3                   	ret    

00000fea <sbrk>:
SYSCALL(sbrk)
     fea:	b8 0c 00 00 00       	mov    $0xc,%eax
     fef:	cd 40                	int    $0x40
     ff1:	c3                   	ret    

00000ff2 <sleep>:
SYSCALL(sleep)
     ff2:	b8 0d 00 00 00       	mov    $0xd,%eax
     ff7:	cd 40                	int    $0x40
     ff9:	c3                   	ret    

00000ffa <uptime>:
SYSCALL(uptime)
     ffa:	b8 0e 00 00 00       	mov    $0xe,%eax
     fff:	cd 40                	int    $0x40
    1001:	c3                   	ret    

00001002 <cpuhalt>:
SYSCALL(cpuhalt)
    1002:	b8 16 00 00 00       	mov    $0x16,%eax
    1007:	cd 40                	int    $0x40
    1009:	c3                   	ret    
    100a:	66 90                	xchg   %ax,%ax
    100c:	66 90                	xchg   %ax,%ax
    100e:	66 90                	xchg   %ax,%ax

00001010 <printint.constprop.1>:
    1010:	55                   	push   %ebp
    1011:	89 e5                	mov    %esp,%ebp
    1013:	57                   	push   %edi
    1014:	56                   	push   %esi
    1015:	53                   	push   %ebx
    1016:	89 d6                	mov    %edx,%esi
    1018:	83 ec 3c             	sub    $0x3c,%esp
    101b:	85 c0                	test   %eax,%eax
    101d:	79 71                	jns    1090 <printint.constprop.1+0x80>
    101f:	83 e1 01             	and    $0x1,%ecx
    1022:	74 6c                	je     1090 <printint.constprop.1+0x80>
    1024:	f7 d8                	neg    %eax
    1026:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    102d:	31 c9                	xor    %ecx,%ecx
    102f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1032:	eb 06                	jmp    103a <printint.constprop.1+0x2a>
    1034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1038:	89 f9                	mov    %edi,%ecx
    103a:	31 d2                	xor    %edx,%edx
    103c:	8d 79 01             	lea    0x1(%ecx),%edi
    103f:	f7 f6                	div    %esi
    1041:	0f b6 92 1c 16 00 00 	movzbl 0x161c(%edx),%edx
    1048:	85 c0                	test   %eax,%eax
    104a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
    104d:	75 e9                	jne    1038 <printint.constprop.1+0x28>
    104f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1052:	85 c0                	test   %eax,%eax
    1054:	74 08                	je     105e <printint.constprop.1+0x4e>
    1056:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    105b:	8d 79 02             	lea    0x2(%ecx),%edi
    105e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    1062:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1068:	0f b6 06             	movzbl (%esi),%eax
    106b:	83 ec 04             	sub    $0x4,%esp
    106e:	83 ee 01             	sub    $0x1,%esi
    1071:	6a 01                	push   $0x1
    1073:	53                   	push   %ebx
    1074:	6a 01                	push   $0x1
    1076:	88 45 d7             	mov    %al,-0x29(%ebp)
    1079:	e8 04 ff ff ff       	call   f82 <write>
    107e:	83 c4 10             	add    $0x10,%esp
    1081:	39 de                	cmp    %ebx,%esi
    1083:	75 e3                	jne    1068 <printint.constprop.1+0x58>
    1085:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1088:	5b                   	pop    %ebx
    1089:	5e                   	pop    %esi
    108a:	5f                   	pop    %edi
    108b:	5d                   	pop    %ebp
    108c:	c3                   	ret    
    108d:	8d 76 00             	lea    0x0(%esi),%esi
    1090:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1097:	eb 94                	jmp    102d <printint.constprop.1+0x1d>
    1099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000010a0 <vprintf.constprop.0>:
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
    10a3:	57                   	push   %edi
    10a4:	56                   	push   %esi
    10a5:	53                   	push   %ebx
    10a6:	89 d6                	mov    %edx,%esi
    10a8:	83 ec 2c             	sub    $0x2c,%esp
    10ab:	0f b6 10             	movzbl (%eax),%edx
    10ae:	84 d2                	test   %dl,%dl
    10b0:	0f 84 cd 00 00 00    	je     1183 <vprintf.constprop.0+0xe3>
    10b6:	8d 58 01             	lea    0x1(%eax),%ebx
    10b9:	31 ff                	xor    %edi,%edi
    10bb:	eb 31                	jmp    10ee <vprintf.constprop.0+0x4e>
    10bd:	8d 76 00             	lea    0x0(%esi),%esi
    10c0:	83 f8 25             	cmp    $0x25,%eax
    10c3:	0f 84 c7 00 00 00    	je     1190 <vprintf.constprop.0+0xf0>
    10c9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    10cc:	83 ec 04             	sub    $0x4,%esp
    10cf:	88 55 e4             	mov    %dl,-0x1c(%ebp)
    10d2:	6a 01                	push   $0x1
    10d4:	50                   	push   %eax
    10d5:	6a 01                	push   $0x1
    10d7:	e8 a6 fe ff ff       	call   f82 <write>
    10dc:	83 c4 10             	add    $0x10,%esp
    10df:	83 c3 01             	add    $0x1,%ebx
    10e2:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    10e6:	84 d2                	test   %dl,%dl
    10e8:	0f 84 95 00 00 00    	je     1183 <vprintf.constprop.0+0xe3>
    10ee:	85 ff                	test   %edi,%edi
    10f0:	0f b6 c2             	movzbl %dl,%eax
    10f3:	74 cb                	je     10c0 <vprintf.constprop.0+0x20>
    10f5:	83 ff 25             	cmp    $0x25,%edi
    10f8:	75 e5                	jne    10df <vprintf.constprop.0+0x3f>
    10fa:	83 f8 64             	cmp    $0x64,%eax
    10fd:	8d 7e 04             	lea    0x4(%esi),%edi
    1100:	b9 01 00 00 00       	mov    $0x1,%ecx
    1105:	0f 84 9a 00 00 00    	je     11a5 <vprintf.constprop.0+0x105>
    110b:	83 f8 6c             	cmp    $0x6c,%eax
    110e:	0f 84 8c 00 00 00    	je     11a0 <vprintf.constprop.0+0x100>
    1114:	83 f8 78             	cmp    $0x78,%eax
    1117:	0f 84 a3 00 00 00    	je     11c0 <vprintf.constprop.0+0x120>
    111d:	83 f8 70             	cmp    $0x70,%eax
    1120:	0f 84 ca 00 00 00    	je     11f0 <vprintf.constprop.0+0x150>
    1126:	83 f8 73             	cmp    $0x73,%eax
    1129:	0f 84 39 01 00 00    	je     1268 <vprintf.constprop.0+0x1c8>
    112f:	83 f8 63             	cmp    $0x63,%eax
    1132:	0f 84 68 01 00 00    	je     12a0 <vprintf.constprop.0+0x200>
    1138:	83 f8 25             	cmp    $0x25,%eax
    113b:	0f 84 9f 00 00 00    	je     11e0 <vprintf.constprop.0+0x140>
    1141:	8d 45 df             	lea    -0x21(%ebp),%eax
    1144:	83 ec 04             	sub    $0x4,%esp
    1147:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    114a:	6a 01                	push   $0x1
    114c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
    1150:	50                   	push   %eax
    1151:	6a 01                	push   $0x1
    1153:	e8 2a fe ff ff       	call   f82 <write>
    1158:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    115c:	83 c4 0c             	add    $0xc,%esp
    115f:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1162:	6a 01                	push   $0x1
    1164:	88 55 e0             	mov    %dl,-0x20(%ebp)
    1167:	50                   	push   %eax
    1168:	6a 01                	push   $0x1
    116a:	83 c3 01             	add    $0x1,%ebx
    116d:	31 ff                	xor    %edi,%edi
    116f:	e8 0e fe ff ff       	call   f82 <write>
    1174:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1178:	83 c4 10             	add    $0x10,%esp
    117b:	84 d2                	test   %dl,%dl
    117d:	0f 85 6b ff ff ff    	jne    10ee <vprintf.constprop.0+0x4e>
    1183:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1186:	5b                   	pop    %ebx
    1187:	5e                   	pop    %esi
    1188:	5f                   	pop    %edi
    1189:	5d                   	pop    %ebp
    118a:	c3                   	ret    
    118b:	90                   	nop
    118c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1190:	bf 25 00 00 00       	mov    $0x25,%edi
    1195:	e9 45 ff ff ff       	jmp    10df <vprintf.constprop.0+0x3f>
    119a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11a0:	8d 7e 04             	lea    0x4(%esi),%edi
    11a3:	31 c9                	xor    %ecx,%ecx
    11a5:	8b 06                	mov    (%esi),%eax
    11a7:	ba 0a 00 00 00       	mov    $0xa,%edx
    11ac:	89 fe                	mov    %edi,%esi
    11ae:	31 ff                	xor    %edi,%edi
    11b0:	e8 5b fe ff ff       	call   1010 <printint.constprop.1>
    11b5:	e9 25 ff ff ff       	jmp    10df <vprintf.constprop.0+0x3f>
    11ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11c0:	8b 06                	mov    (%esi),%eax
    11c2:	8d 7e 04             	lea    0x4(%esi),%edi
    11c5:	31 c9                	xor    %ecx,%ecx
    11c7:	ba 10 00 00 00       	mov    $0x10,%edx
    11cc:	89 fe                	mov    %edi,%esi
    11ce:	31 ff                	xor    %edi,%edi
    11d0:	e8 3b fe ff ff       	call   1010 <printint.constprop.1>
    11d5:	e9 05 ff ff ff       	jmp    10df <vprintf.constprop.0+0x3f>
    11da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11e0:	83 ec 04             	sub    $0x4,%esp
    11e3:	88 55 e1             	mov    %dl,-0x1f(%ebp)
    11e6:	8d 45 e1             	lea    -0x1f(%ebp),%eax
    11e9:	6a 01                	push   $0x1
    11eb:	e9 77 ff ff ff       	jmp    1167 <vprintf.constprop.0+0xc7>
    11f0:	8d 46 04             	lea    0x4(%esi),%eax
    11f3:	83 ec 04             	sub    $0x4,%esp
    11f6:	8b 3e                	mov    (%esi),%edi
    11f8:	6a 01                	push   $0x1
    11fa:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
    11fe:	be 08 00 00 00       	mov    $0x8,%esi
    1203:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1206:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1209:	50                   	push   %eax
    120a:	6a 01                	push   $0x1
    120c:	e8 71 fd ff ff       	call   f82 <write>
    1211:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1214:	83 c4 0c             	add    $0xc,%esp
    1217:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
    121b:	6a 01                	push   $0x1
    121d:	50                   	push   %eax
    121e:	6a 01                	push   $0x1
    1220:	e8 5d fd ff ff       	call   f82 <write>
    1225:	83 c4 10             	add    $0x10,%esp
    1228:	90                   	nop
    1229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1230:	89 f8                	mov    %edi,%eax
    1232:	83 ec 04             	sub    $0x4,%esp
    1235:	c1 e7 04             	shl    $0x4,%edi
    1238:	c1 e8 1c             	shr    $0x1c,%eax
    123b:	6a 01                	push   $0x1
    123d:	0f b6 80 1c 16 00 00 	movzbl 0x161c(%eax),%eax
    1244:	88 45 e5             	mov    %al,-0x1b(%ebp)
    1247:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    124a:	50                   	push   %eax
    124b:	6a 01                	push   $0x1
    124d:	e8 30 fd ff ff       	call   f82 <write>
    1252:	83 c4 10             	add    $0x10,%esp
    1255:	83 ee 01             	sub    $0x1,%esi
    1258:	75 d6                	jne    1230 <vprintf.constprop.0+0x190>
    125a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    125d:	31 ff                	xor    %edi,%edi
    125f:	e9 7b fe ff ff       	jmp    10df <vprintf.constprop.0+0x3f>
    1264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1268:	8b 3e                	mov    (%esi),%edi
    126a:	8d 46 04             	lea    0x4(%esi),%eax
    126d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1270:	85 ff                	test   %edi,%edi
    1272:	74 50                	je     12c4 <vprintf.constprop.0+0x224>
    1274:	0f b6 07             	movzbl (%edi),%eax
    1277:	84 c0                	test   %al,%al
    1279:	74 df                	je     125a <vprintf.constprop.0+0x1ba>
    127b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
    127e:	66 90                	xchg   %ax,%ax
    1280:	83 ec 04             	sub    $0x4,%esp
    1283:	83 c7 01             	add    $0x1,%edi
    1286:	88 45 e3             	mov    %al,-0x1d(%ebp)
    1289:	6a 01                	push   $0x1
    128b:	56                   	push   %esi
    128c:	6a 01                	push   $0x1
    128e:	e8 ef fc ff ff       	call   f82 <write>
    1293:	0f b6 07             	movzbl (%edi),%eax
    1296:	83 c4 10             	add    $0x10,%esp
    1299:	84 c0                	test   %al,%al
    129b:	75 e3                	jne    1280 <vprintf.constprop.0+0x1e0>
    129d:	eb bb                	jmp    125a <vprintf.constprop.0+0x1ba>
    129f:	90                   	nop
    12a0:	8b 06                	mov    (%esi),%eax
    12a2:	83 ec 04             	sub    $0x4,%esp
    12a5:	8d 7e 04             	lea    0x4(%esi),%edi
    12a8:	6a 01                	push   $0x1
    12aa:	89 fe                	mov    %edi,%esi
    12ac:	31 ff                	xor    %edi,%edi
    12ae:	88 45 e2             	mov    %al,-0x1e(%ebp)
    12b1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    12b4:	50                   	push   %eax
    12b5:	6a 01                	push   $0x1
    12b7:	e8 c6 fc ff ff       	call   f82 <write>
    12bc:	83 c4 10             	add    $0x10,%esp
    12bf:	e9 1b fe ff ff       	jmp    10df <vprintf.constprop.0+0x3f>
    12c4:	bf 14 16 00 00       	mov    $0x1614,%edi
    12c9:	b8 28 00 00 00       	mov    $0x28,%eax
    12ce:	eb ab                	jmp    127b <vprintf.constprop.0+0x1db>

000012d0 <fprintf>:
    12d0:	55                   	push   %ebp
    12d1:	89 e5                	mov    %esp,%ebp
    12d3:	83 ec 08             	sub    $0x8,%esp
    12d6:	8b 45 0c             	mov    0xc(%ebp),%eax
    12d9:	8d 55 10             	lea    0x10(%ebp),%edx
    12dc:	e8 bf fd ff ff       	call   10a0 <vprintf.constprop.0>
    12e1:	c9                   	leave  
    12e2:	c3                   	ret    
    12e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    12e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000012f0 <printf>:
    12f0:	55                   	push   %ebp
    12f1:	89 e5                	mov    %esp,%ebp
    12f3:	83 ec 08             	sub    $0x8,%esp
    12f6:	8b 45 08             	mov    0x8(%ebp),%eax
    12f9:	8d 55 0c             	lea    0xc(%ebp),%edx
    12fc:	e8 9f fd ff ff       	call   10a0 <vprintf.constprop.0>
    1301:	c9                   	leave  
    1302:	c3                   	ret    
    1303:	66 90                	xchg   %ax,%ax
    1305:	66 90                	xchg   %ax,%ax
    1307:	66 90                	xchg   %ax,%ax
    1309:	66 90                	xchg   %ax,%ax
    130b:	66 90                	xchg   %ax,%ax
    130d:	66 90                	xchg   %ax,%ax
    130f:	90                   	nop

00001310 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1310:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1311:	a1 24 1e 00 00       	mov    0x1e24,%eax
{
    1316:	89 e5                	mov    %esp,%ebp
    1318:	57                   	push   %edi
    1319:	56                   	push   %esi
    131a:	53                   	push   %ebx
    131b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    131e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1328:	39 c8                	cmp    %ecx,%eax
    132a:	8b 10                	mov    (%eax),%edx
    132c:	73 32                	jae    1360 <free+0x50>
    132e:	39 d1                	cmp    %edx,%ecx
    1330:	72 04                	jb     1336 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1332:	39 d0                	cmp    %edx,%eax
    1334:	72 32                	jb     1368 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1336:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1339:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    133c:	39 fa                	cmp    %edi,%edx
    133e:	74 30                	je     1370 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1340:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1343:	8b 50 04             	mov    0x4(%eax),%edx
    1346:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1349:	39 f1                	cmp    %esi,%ecx
    134b:	74 3a                	je     1387 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    134d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    134f:	a3 24 1e 00 00       	mov    %eax,0x1e24
}
    1354:	5b                   	pop    %ebx
    1355:	5e                   	pop    %esi
    1356:	5f                   	pop    %edi
    1357:	5d                   	pop    %ebp
    1358:	c3                   	ret    
    1359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1360:	39 d0                	cmp    %edx,%eax
    1362:	72 04                	jb     1368 <free+0x58>
    1364:	39 d1                	cmp    %edx,%ecx
    1366:	72 ce                	jb     1336 <free+0x26>
{
    1368:	89 d0                	mov    %edx,%eax
    136a:	eb bc                	jmp    1328 <free+0x18>
    136c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1370:	03 72 04             	add    0x4(%edx),%esi
    1373:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1376:	8b 10                	mov    (%eax),%edx
    1378:	8b 12                	mov    (%edx),%edx
    137a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    137d:	8b 50 04             	mov    0x4(%eax),%edx
    1380:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1383:	39 f1                	cmp    %esi,%ecx
    1385:	75 c6                	jne    134d <free+0x3d>
    p->s.size += bp->s.size;
    1387:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    138a:	a3 24 1e 00 00       	mov    %eax,0x1e24
    p->s.size += bp->s.size;
    138f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1392:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1395:	89 10                	mov    %edx,(%eax)
}
    1397:	5b                   	pop    %ebx
    1398:	5e                   	pop    %esi
    1399:	5f                   	pop    %edi
    139a:	5d                   	pop    %ebp
    139b:	c3                   	ret    
    139c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000013a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    13a0:	55                   	push   %ebp
    13a1:	89 e5                	mov    %esp,%ebp
    13a3:	57                   	push   %edi
    13a4:	56                   	push   %esi
    13a5:	53                   	push   %ebx
    13a6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    13a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    13ac:	8b 15 24 1e 00 00    	mov    0x1e24,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    13b2:	8d 78 07             	lea    0x7(%eax),%edi
    13b5:	c1 ef 03             	shr    $0x3,%edi
    13b8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    13bb:	85 d2                	test   %edx,%edx
    13bd:	0f 84 9d 00 00 00    	je     1460 <malloc+0xc0>
    13c3:	8b 02                	mov    (%edx),%eax
    13c5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    13c8:	39 cf                	cmp    %ecx,%edi
    13ca:	76 6c                	jbe    1438 <malloc+0x98>
    13cc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    13d2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    13d7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    13da:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    13e1:	eb 0e                	jmp    13f1 <malloc+0x51>
    13e3:	90                   	nop
    13e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13e8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    13ea:	8b 48 04             	mov    0x4(%eax),%ecx
    13ed:	39 f9                	cmp    %edi,%ecx
    13ef:	73 47                	jae    1438 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    13f1:	39 05 24 1e 00 00    	cmp    %eax,0x1e24
    13f7:	89 c2                	mov    %eax,%edx
    13f9:	75 ed                	jne    13e8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    13fb:	83 ec 0c             	sub    $0xc,%esp
    13fe:	56                   	push   %esi
    13ff:	e8 e6 fb ff ff       	call   fea <sbrk>
  if(p == (char*)-1)
    1404:	83 c4 10             	add    $0x10,%esp
    1407:	83 f8 ff             	cmp    $0xffffffff,%eax
    140a:	74 1c                	je     1428 <malloc+0x88>
  hp->s.size = nu;
    140c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    140f:	83 ec 0c             	sub    $0xc,%esp
    1412:	83 c0 08             	add    $0x8,%eax
    1415:	50                   	push   %eax
    1416:	e8 f5 fe ff ff       	call   1310 <free>
  return freep;
    141b:	8b 15 24 1e 00 00    	mov    0x1e24,%edx
      if((p = morecore(nunits)) == 0)
    1421:	83 c4 10             	add    $0x10,%esp
    1424:	85 d2                	test   %edx,%edx
    1426:	75 c0                	jne    13e8 <malloc+0x48>
        return 0;
  }
}
    1428:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    142b:	31 c0                	xor    %eax,%eax
}
    142d:	5b                   	pop    %ebx
    142e:	5e                   	pop    %esi
    142f:	5f                   	pop    %edi
    1430:	5d                   	pop    %ebp
    1431:	c3                   	ret    
    1432:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1438:	39 cf                	cmp    %ecx,%edi
    143a:	74 54                	je     1490 <malloc+0xf0>
        p->s.size -= nunits;
    143c:	29 f9                	sub    %edi,%ecx
    143e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1441:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1444:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1447:	89 15 24 1e 00 00    	mov    %edx,0x1e24
}
    144d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1450:	83 c0 08             	add    $0x8,%eax
}
    1453:	5b                   	pop    %ebx
    1454:	5e                   	pop    %esi
    1455:	5f                   	pop    %edi
    1456:	5d                   	pop    %ebp
    1457:	c3                   	ret    
    1458:	90                   	nop
    1459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1460:	c7 05 24 1e 00 00 28 	movl   $0x1e28,0x1e24
    1467:	1e 00 00 
    146a:	c7 05 28 1e 00 00 28 	movl   $0x1e28,0x1e28
    1471:	1e 00 00 
    base.s.size = 0;
    1474:	b8 28 1e 00 00       	mov    $0x1e28,%eax
    1479:	c7 05 2c 1e 00 00 00 	movl   $0x0,0x1e2c
    1480:	00 00 00 
    1483:	e9 44 ff ff ff       	jmp    13cc <malloc+0x2c>
    1488:	90                   	nop
    1489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1490:	8b 08                	mov    (%eax),%ecx
    1492:	89 0a                	mov    %ecx,(%edx)
    1494:	eb b1                	jmp    1447 <malloc+0xa7>
