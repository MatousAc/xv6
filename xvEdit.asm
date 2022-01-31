
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
      70:	68 99 13 00 00       	push   $0x1399
      75:	6a 02                	push   $0x2
      77:	e8 f4 10 00 00       	call   1170 <fprintf>
  // opening
  file.fd = open(file.filename, O_RDONLY);
      7c:	58                   	pop    %eax
      7d:	5a                   	pop    %edx
      7e:	6a 00                	push   $0x0
      80:	57                   	push   %edi
      81:	e8 bc 0d 00 00       	call   e42 <open>
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
      ce:	e8 2d 06 00 00       	call   700 <gatherLines>
      d3:	83 c4 10             	add    $0x10,%esp
  }
  close(file.fd);
      d6:	83 ec 0c             	sub    $0xc,%esp
      d9:	ff b5 04 ff ff ff    	pushl  -0xfc(%ebp)
      df:	8d 9d 20 ff ff ff    	lea    -0xe0(%ebp),%ebx
      e5:	e8 40 0d 00 00       	call   e2a <close>
      ea:	83 c4 10             	add    $0x10,%esp
      ed:	8d 76 00             	lea    0x0(%esi),%esi

  while (cmd != QUIT) {
    fprintf(2, "xvEdit> ");
      f0:	83 ec 08             	sub    $0x8,%esp
      f3:	68 c0 13 00 00       	push   $0x13c0
      f8:	6a 02                	push   $0x2
      fa:	e8 71 10 00 00       	call   1170 <fprintf>
    memset(buf, 0, nbuf);
      ff:	83 c4 0c             	add    $0xc,%esp
     102:	6a 64                	push   $0x64
     104:	6a 00                	push   $0x0
     106:	68 a0 1b 00 00       	push   $0x1ba0
     10b:	e8 50 0b 00 00       	call   c60 <memset>
    gets(buf, nbuf);
     110:	58                   	pop    %eax
     111:	5a                   	pop    %edx
     112:	6a 64                	push   $0x64
     114:	68 a0 1b 00 00       	push   $0x1ba0
     119:	e8 a2 0b 00 00       	call   cc0 <gets>
    
    unline(buf);
     11e:	c7 04 24 a0 1b 00 00 	movl   $0x1ba0,(%esp)
     125:	e8 46 09 00 00       	call   a70 <unline>
    substr(cmdstr, buf, 0, 4);
     12a:	6a 04                	push   $0x4
     12c:	6a 00                	push   $0x0
     12e:	68 a0 1b 00 00       	push   $0x1ba0
     133:	53                   	push   %ebx
     134:	e8 87 06 00 00       	call   7c0 <substr>
  return 1;
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
     16a:	68 a0 1b 00 00       	push   $0x1ba0
     16f:	e8 bc 0a 00 00       	call   c30 <strlen>
     174:	89 1c 24             	mov    %ebx,(%esp)
     177:	89 c6                	mov    %eax,%esi
     179:	e8 b2 0a 00 00       	call   c30 <strlen>
     17e:	83 c0 01             	add    $0x1,%eax
     181:	56                   	push   %esi
     182:	50                   	push   %eax
     183:	8d 45 84             	lea    -0x7c(%ebp),%eax
     186:	68 a0 1b 00 00       	push   $0x1ba0
     18b:	50                   	push   %eax
     18c:	e8 2f 06 00 00       	call   7c0 <substr>
    if      (strcmp(cmdstr, "@END") == 0) {cmd = END;}
     191:	83 c4 18             	add    $0x18,%esp
     194:	68 c9 13 00 00       	push   $0x13c9
     199:	53                   	push   %ebx
     19a:	e8 41 0a 00 00       	call   be0 <strcmp>
     19f:	83 c4 10             	add    $0x10,%esp
     1a2:	85 c0                	test   %eax,%eax
     1a4:	0f 84 46 ff ff ff    	je     f0 <main+0xf0>
    else if (strcmp(cmdstr, "ADD<") == 0) {cmd = ADD;}
     1aa:	50                   	push   %eax
     1ab:	50                   	push   %eax
     1ac:	68 ce 13 00 00       	push   $0x13ce
     1b1:	53                   	push   %ebx
     1b2:	e8 29 0a 00 00       	call   be0 <strcmp>
     1b7:	83 c4 10             	add    $0x10,%esp
     1ba:	85 c0                	test   %eax,%eax
     1bc:	0f 84 2e ff ff ff    	je     f0 <main+0xf0>
    else if (strcmp(cmdstr, "DROP") == 0) {cmd = DROP;}
     1c2:	50                   	push   %eax
     1c3:	50                   	push   %eax
     1c4:	68 d3 13 00 00       	push   $0x13d3
     1c9:	53                   	push   %ebx
     1ca:	e8 11 0a 00 00       	call   be0 <strcmp>
     1cf:	83 c4 10             	add    $0x10,%esp
     1d2:	85 c0                	test   %eax,%eax
     1d4:	0f 84 16 ff ff ff    	je     f0 <main+0xf0>
    else if (strcmp(cmdstr, "EDIT") == 0) {cmd = EDIT;}
     1da:	50                   	push   %eax
     1db:	50                   	push   %eax
     1dc:	68 d8 13 00 00       	push   $0x13d8
     1e1:	53                   	push   %ebx
     1e2:	e8 f9 09 00 00       	call   be0 <strcmp>
     1e7:	83 c4 10             	add    $0x10,%esp
     1ea:	85 c0                	test   %eax,%eax
     1ec:	0f 84 fe fe ff ff    	je     f0 <main+0xf0>
    else if (strcmp(cmdstr, "LIST") == 0) {cmd = LIST;}
     1f2:	50                   	push   %eax
     1f3:	50                   	push   %eax
     1f4:	68 dd 13 00 00       	push   $0x13dd
     1f9:	53                   	push   %ebx
     1fa:	e8 e1 09 00 00       	call   be0 <strcmp>
     1ff:	83 c4 10             	add    $0x10,%esp
     202:	85 c0                	test   %eax,%eax
     204:	0f 84 ac 00 00 00    	je     2b6 <main+0x2b6>
    else if (strcmp(cmdstr, "SHOW") == 0) {cmd = SHOW;}
     20a:	57                   	push   %edi
     20b:	57                   	push   %edi
     20c:	68 e2 13 00 00       	push   $0x13e2
     211:	53                   	push   %ebx
     212:	e8 c9 09 00 00       	call   be0 <strcmp>
     217:	83 c4 10             	add    $0x10,%esp
     21a:	85 c0                	test   %eax,%eax
     21c:	0f 84 f1 00 00 00    	je     313 <main+0x313>
    else if (strcmp(cmdstr, "QUIT") == 0) {cmd = QUIT;}
     222:	56                   	push   %esi
     223:	56                   	push   %esi
     224:	68 e7 13 00 00       	push   $0x13e7
     229:	53                   	push   %ebx
     22a:	e8 b1 09 00 00       	call   be0 <strcmp>
     22f:	83 c4 10             	add    $0x10,%esp
     232:	85 c0                	test   %eax,%eax
     234:	0f 85 c3 00 00 00    	jne    2fd <main+0x2fd>
  close(file.fd);
     23a:	83 ec 0c             	sub    $0xc,%esp
     23d:	ff b5 04 ff ff ff    	pushl  -0xfc(%ebp)
     243:	e8 e2 0b 00 00       	call   e2a <close>
  destroyLinkedList(file.lines);
     248:	59                   	pop    %ecx
     249:	ff b5 00 ff ff ff    	pushl  -0x100(%ebp)
     24f:	e8 4c 03 00 00       	call   5a0 <destroyLinkedList>
  exit();
     254:	e8 a9 0b 00 00       	call   e02 <exit>
    fprintf(2, "only specify one file");
     259:	51                   	push   %ecx
     25a:	51                   	push   %ecx
     25b:	68 83 13 00 00       	push   $0x1383
     260:	6a 02                	push   $0x2
     262:	e8 09 0f 00 00       	call   1170 <fprintf>
    exit();
     267:	e8 96 0b 00 00       	call   e02 <exit>
    fprintf(2, "specify a file you want to edit");
     26c:	53                   	push   %ebx
     26d:	53                   	push   %ebx
     26e:	68 14 14 00 00       	push   $0x1414
     273:	6a 02                	push   $0x2
     275:	e8 f6 0e 00 00       	call   1170 <fprintf>
    exit();
     27a:	e8 83 0b 00 00       	call   e02 <exit>
    fprintf(2, "creating %s . . .\n",  file.filename);
     27f:	8b bd fc fe ff ff    	mov    -0x104(%ebp),%edi
     285:	51                   	push   %ecx
     286:	57                   	push   %edi
     287:	68 ad 13 00 00       	push   $0x13ad
     28c:	6a 02                	push   $0x2
     28e:	e8 dd 0e 00 00       	call   1170 <fprintf>
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     293:	5b                   	pop    %ebx
     294:	5e                   	pop    %esi
     295:	68 01 02 00 00       	push   $0x201
     29a:	57                   	push   %edi
     29b:	e8 a2 0b 00 00       	call   e42 <open>
    close(file.fd);
     2a0:	89 04 24             	mov    %eax,(%esp)
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     2a3:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
    close(file.fd);
     2a9:	e8 7c 0b 00 00       	call   e2a <close>
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
     2f0:	e8 7b 06 00 00       	call   970 <list>
     2f5:	83 c4 10             	add    $0x10,%esp
     2f8:	e9 f3 fd ff ff       	jmp    f0 <main+0xf0>
  fprintf(2, "bad bi input\n");
     2fd:	52                   	push   %edx
     2fe:	52                   	push   %edx
     2ff:	68 38 13 00 00       	push   $0x1338
     304:	6a 02                	push   $0x2
     306:	e8 65 0e 00 00       	call   1170 <fprintf>
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
     33b:	e8 a0 07 00 00       	call   ae0 <printl>
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
     3c8:	e8 73 0e 00 00       	call   1240 <malloc>
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
     3fa:	e8 41 0e 00 00       	call   1240 <malloc>
  struct Node* node = malloc(sizeof(Node));
     3ff:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  struct LinkedList* list = malloc(sizeof(LinkedList));
     406:	89 c6                	mov    %eax,%esi
  struct Node* node = malloc(sizeof(Node));
     408:	e8 33 0e 00 00       	call   1240 <malloc>
     40d:	89 c3                	mov    %eax,%ebx
  node->prev = nullptr;
     40f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->data = data;// newData;
     415:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  node->next = nullptr;
     41c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  struct Node* node = malloc(sizeof(Node));
     423:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     42a:	e8 11 0e 00 00       	call   1240 <malloc>
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
     464:	8b 55 0c             	mov    0xc(%ebp),%edx
     467:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct Node* curNode;
  if (pos < 0) {
     46a:	85 d2                	test   %edx,%edx
     46c:	78 52                	js     4c0 <nodeAt+0x60>
    curNode = list->tail;
    while (++pos != 0)
      curNode = curNode->prev;
  }
  else if (pos > (list->len / 2)) {
     46e:	8b 4b 08             	mov    0x8(%ebx),%ecx
     471:	89 c8                	mov    %ecx,%eax
     473:	c1 e8 1f             	shr    $0x1f,%eax
     476:	01 c8                	add    %ecx,%eax
     478:	d1 f8                	sar    %eax
     47a:	39 d0                	cmp    %edx,%eax
     47c:	7c 22                	jl     4a0 <nodeAt+0x40>
      cur--;
    }
  }
  else {
    int cur = 0;
    curNode = list->head->next;
     47e:	8b 03                	mov    (%ebx),%eax
    while (cur != pos) {
     480:	85 d2                	test   %edx,%edx
    curNode = list->head->next;
     482:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     485:	74 13                	je     49a <nodeAt+0x3a>
    int cur = 0;
     487:	31 c9                	xor    %ecx,%ecx
     489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
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
    while (cur != pos) {
     4a0:	39 d1                	cmp    %edx,%ecx
    curNode = list->tail;
     4a2:	8b 43 04             	mov    0x4(%ebx),%eax
    while (cur != pos) {
     4a5:	74 f3                	je     49a <nodeAt+0x3a>
     4a7:	89 f6                	mov    %esi,%esi
     4a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      cur--;
     4b0:	83 e9 01             	sub    $0x1,%ecx
      curNode = curNode->prev;
     4b3:	8b 00                	mov    (%eax),%eax
    while (cur != pos) {
     4b5:	39 ca                	cmp    %ecx,%edx
     4b7:	75 f7                	jne    4b0 <nodeAt+0x50>
}
     4b9:	5b                   	pop    %ebx
     4ba:	5d                   	pop    %ebp
     4bb:	c3                   	ret    
     4bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while (++pos != 0)
     4c0:	83 c2 01             	add    $0x1,%edx
    curNode = list->tail;
     4c3:	8b 43 04             	mov    0x4(%ebx),%eax
    while (++pos != 0)
     4c6:	74 d2                	je     49a <nodeAt+0x3a>
     4c8:	90                   	nop
     4c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     4d0:	83 c2 01             	add    $0x1,%edx
      curNode = curNode->prev;
     4d3:	8b 00                	mov    (%eax),%eax
    while (++pos != 0)
     4d5:	75 f9                	jne    4d0 <nodeAt+0x70>
}
     4d7:	5b                   	pop    %ebx
     4d8:	5d                   	pop    %ebp
     4d9:	c3                   	ret    
     4da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000004e0 <insert>:

void insert(struct LinkedList* list, char* data, int pos) {
     4e0:	55                   	push   %ebp
     4e1:	89 e5                	mov    %esp,%ebp
     4e3:	57                   	push   %edi
     4e4:	56                   	push   %esi
     4e5:	53                   	push   %ebx
     4e6:	83 ec 0c             	sub    $0xc,%esp
  struct Node* atPos = nodeAt(list, pos);
     4e9:	ff 75 10             	pushl  0x10(%ebp)
     4ec:	ff 75 08             	pushl  0x8(%ebp)
void insert(struct LinkedList* list, char* data, int pos) {
     4ef:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct Node* atPos = nodeAt(list, pos);
     4f2:	e8 69 ff ff ff       	call   460 <nodeAt>
     4f7:	83 ec 04             	sub    $0x4,%esp
     4fa:	89 c6                	mov    %eax,%esi
  char* newData = (char*)malloc(sizeof(char) * 1000);
     4fc:	68 e8 03 00 00       	push   $0x3e8
     501:	e8 3a 0d 00 00       	call   1240 <malloc>
     506:	8d 8b e7 03 00 00    	lea    0x3e7(%ebx),%ecx
     50c:	89 c7                	mov    %eax,%edi
     50e:	83 c4 10             	add    $0x10,%esp
     511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(--n > 0 && (*s++ = *t++) != 0)
     518:	83 c3 01             	add    $0x1,%ebx
     51b:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     51f:	83 c0 01             	add    $0x1,%eax
     522:	84 d2                	test   %dl,%dl
     524:	88 50 ff             	mov    %dl,-0x1(%eax)
     527:	74 04                	je     52d <insert+0x4d>
     529:	39 d9                	cmp    %ebx,%ecx
     52b:	75 eb                	jne    518 <insert+0x38>
  newData = safestrcpy(newData, data, (sizeof(char) * 1000));
  struct Node* new = malloc(sizeof(Node));
     52d:	83 ec 0c             	sub    $0xc,%esp
  *s = 0;
     530:	c6 00 00             	movb   $0x0,(%eax)
  struct Node* new = malloc(sizeof(Node));
     533:	6a 0c                	push   $0xc
     535:	e8 06 0d 00 00       	call   1240 <malloc>

  new->data = newData;
     53a:	89 78 04             	mov    %edi,0x4(%eax)
  new->prev = atPos->prev;
     53d:	8b 16                	mov    (%esi),%edx
  new->next = atPos;
     53f:	89 70 08             	mov    %esi,0x8(%eax)
  new->prev = atPos->prev;
     542:	89 10                	mov    %edx,(%eax)
  new->prev->next = new;
     544:	89 42 08             	mov    %eax,0x8(%edx)
  atPos->prev = new;
     547:	89 06                	mov    %eax,(%esi)
  list->len++;
     549:	8b 45 08             	mov    0x8(%ebp),%eax
     54c:	83 40 08 01          	addl   $0x1,0x8(%eax)
}
     550:	8d 65 f4             	lea    -0xc(%ebp),%esp
     553:	5b                   	pop    %ebx
     554:	5e                   	pop    %esi
     555:	5f                   	pop    %edi
     556:	5d                   	pop    %ebp
     557:	c3                   	ret    
     558:	90                   	nop
     559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000560 <prepend>:

void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
     560:	55                   	push   %ebp
     561:	89 e5                	mov    %esp,%ebp
     563:	83 ec 0c             	sub    $0xc,%esp
     566:	6a 00                	push   $0x0
     568:	ff 75 0c             	pushl  0xc(%ebp)
     56b:	ff 75 08             	pushl  0x8(%ebp)
     56e:	e8 6d ff ff ff       	call   4e0 <insert>
     573:	83 c4 10             	add    $0x10,%esp
     576:	c9                   	leave  
     577:	c3                   	ret    
     578:	90                   	nop
     579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000580 <append>:
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     580:	55                   	push   %ebp
     581:	89 e5                	mov    %esp,%ebp
     583:	83 ec 0c             	sub    $0xc,%esp
     586:	8b 45 08             	mov    0x8(%ebp),%eax
     589:	ff 70 08             	pushl  0x8(%eax)
     58c:	ff 75 0c             	pushl  0xc(%ebp)
     58f:	50                   	push   %eax
     590:	e8 4b ff ff ff       	call   4e0 <insert>
     595:	83 c4 10             	add    $0x10,%esp
     598:	c9                   	leave  
     599:	c3                   	ret    
     59a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005a0 <destroyLinkedList>:

void destroyLinkedList(struct LinkedList* list) {
     5a0:	55                   	push   %ebp
     5a1:	89 e5                	mov    %esp,%ebp
     5a3:	57                   	push   %edi
     5a4:	56                   	push   %esi
     5a5:	53                   	push   %ebx
     5a6:	83 ec 0c             	sub    $0xc,%esp
     5a9:	8b 75 08             	mov    0x8(%ebp),%esi
  struct Node* destroyer = list->head;
     5ac:	8b 16                	mov    (%esi),%edx
  struct Node* traveler = destroyer->next;
  while (destroyer != list->tail) {
     5ae:	8b 46 04             	mov    0x4(%esi),%eax
     5b1:	39 c2                	cmp    %eax,%edx
  struct Node* traveler = destroyer->next;
     5b3:	8b 5a 08             	mov    0x8(%edx),%ebx
  while (destroyer != list->tail) {
     5b6:	75 0a                	jne    5c2 <destroyLinkedList+0x22>
     5b8:	eb 1e                	jmp    5d8 <destroyLinkedList+0x38>
     5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    destroyer = traveler;
    traveler = traveler->next;
     5c0:	89 fb                	mov    %edi,%ebx
    free(destroyer);
     5c2:	83 ec 0c             	sub    $0xc,%esp
    traveler = traveler->next;
     5c5:	8b 7b 08             	mov    0x8(%ebx),%edi
    free(destroyer);
     5c8:	53                   	push   %ebx
     5c9:	e8 e2 0b 00 00       	call   11b0 <free>
  while (destroyer != list->tail) {
     5ce:	83 c4 10             	add    $0x10,%esp
     5d1:	39 5e 04             	cmp    %ebx,0x4(%esi)
     5d4:	75 ea                	jne    5c0 <destroyLinkedList+0x20>
     5d6:	8b 06                	mov    (%esi),%eax
  }
  free(list->head);
     5d8:	83 ec 0c             	sub    $0xc,%esp
     5db:	50                   	push   %eax
     5dc:	e8 cf 0b 00 00       	call   11b0 <free>
  free(list->tail);
     5e1:	58                   	pop    %eax
     5e2:	ff 76 04             	pushl  0x4(%esi)
     5e5:	e8 c6 0b 00 00       	call   11b0 <free>
  free(list);
     5ea:	89 75 08             	mov    %esi,0x8(%ebp)
     5ed:	83 c4 10             	add    $0x10,%esp
     5f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5f3:	5b                   	pop    %ebx
     5f4:	5e                   	pop    %esi
     5f5:	5f                   	pop    %edi
     5f6:	5d                   	pop    %ebp
  free(list);
     5f7:	e9 b4 0b 00 00       	jmp    11b0 <free>
     5fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000600 <end>:
void end(struct File file, char* args) {
     600:	55                   	push   %ebp
     601:	89 e5                	mov    %esp,%ebp
}
     603:	5d                   	pop    %ebp
     604:	c3                   	ret    
     605:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000610 <add>:
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
     613:	5d                   	pop    %ebp
     614:	c3                   	ret    
     615:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000620 <drop>:
     620:	55                   	push   %ebp
     621:	89 e5                	mov    %esp,%ebp
     623:	5d                   	pop    %ebp
     624:	c3                   	ret    
     625:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000630 <edit>:
     630:	55                   	push   %ebp
     631:	89 e5                	mov    %esp,%ebp
     633:	5d                   	pop    %ebp
     634:	c3                   	ret    
     635:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000640 <quit>:
     640:	55                   	push   %ebp
     641:	89 e5                	mov    %esp,%ebp
     643:	5d                   	pop    %ebp
     644:	c3                   	ret    
     645:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000650 <bi>:
void bi() {
     650:	55                   	push   %ebp
     651:	89 e5                	mov    %esp,%ebp
     653:	83 ec 10             	sub    $0x10,%esp
  fprintf(2, "bad bi input\n");
     656:	68 38 13 00 00       	push   $0x1338
     65b:	6a 02                	push   $0x2
     65d:	e8 0e 0b 00 00       	call   1170 <fprintf>
}
     662:	83 c4 10             	add    $0x10,%esp
     665:	c9                   	leave  
     666:	c3                   	ret    
     667:	89 f6                	mov    %esi,%esi
     669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000670 <getLine>:
int getLine(int fileptr, char line[]) {
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	57                   	push   %edi
     674:	56                   	push   %esi
     675:	53                   	push   %ebx
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     676:	31 ff                	xor    %edi,%edi
     678:	8d 75 e7             	lea    -0x19(%ebp),%esi
int getLine(int fileptr, char line[]) {
     67b:	83 ec 28             	sub    $0x28,%esp
     67e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int len = strlen(line);
     681:	53                   	push   %ebx
     682:	e8 a9 05 00 00       	call   c30 <strlen>
  memset(line, 0, len);
     687:	83 c4 0c             	add    $0xc,%esp
     68a:	50                   	push   %eax
     68b:	6a 00                	push   $0x0
     68d:	53                   	push   %ebx
     68e:	e8 cd 05 00 00       	call   c60 <memset>
     693:	83 c4 10             	add    $0x10,%esp
     696:	eb 1e                	jmp    6b6 <getLine+0x46>
     698:	90                   	nop
     699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (*c == '\n') break;
     6a0:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     6a4:	3c 0a                	cmp    $0xa,%al
     6a6:	74 38                	je     6e0 <getLine+0x70>
    line[i] = *c;
     6a8:	88 04 3b             	mov    %al,(%ebx,%edi,1)
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     6ab:	83 c7 01             	add    $0x1,%edi
     6ae:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
     6b4:	74 42                	je     6f8 <getLine+0x88>
    if (read(fileptr, c, 1) == 0) return strlen(line);
     6b6:	83 ec 04             	sub    $0x4,%esp
     6b9:	6a 01                	push   $0x1
     6bb:	56                   	push   %esi
     6bc:	ff 75 08             	pushl  0x8(%ebp)
     6bf:	e8 56 07 00 00       	call   e1a <read>
     6c4:	83 c4 10             	add    $0x10,%esp
     6c7:	85 c0                	test   %eax,%eax
     6c9:	75 d5                	jne    6a0 <getLine+0x30>
     6cb:	83 ec 0c             	sub    $0xc,%esp
     6ce:	53                   	push   %ebx
     6cf:	e8 5c 05 00 00       	call   c30 <strlen>
     6d4:	83 c4 10             	add    $0x10,%esp
}
     6d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6da:	5b                   	pop    %ebx
     6db:	5e                   	pop    %esi
     6dc:	5f                   	pop    %edi
     6dd:	5d                   	pop    %ebp
     6de:	c3                   	ret    
     6df:	90                   	nop
     6e0:	8d 57 01             	lea    0x1(%edi),%edx
  line[i + 1] = '\0';
     6e3:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
     6e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
     6ea:	b8 01 00 00 00       	mov    $0x1,%eax
}
     6ef:	5b                   	pop    %ebx
     6f0:	5e                   	pop    %esi
     6f1:	5f                   	pop    %edi
     6f2:	5d                   	pop    %ebp
     6f3:	c3                   	ret    
     6f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     6f8:	ba e8 03 00 00       	mov    $0x3e8,%edx
     6fd:	eb e4                	jmp    6e3 <getLine+0x73>
     6ff:	90                   	nop

00000700 <gatherLines>:
void gatherLines(File file) {
     700:	55                   	push   %ebp
     701:	89 e5                	mov    %esp,%ebp
     703:	57                   	push   %edi
     704:	56                   	push   %esi
     705:	53                   	push   %ebx
     706:	8d b5 00 fc ff ff    	lea    -0x400(%ebp),%esi
  int lines = 0;
     70c:	31 db                	xor    %ebx,%ebx
void gatherLines(File file) {
     70e:	81 ec fc 03 00 00    	sub    $0x3fc,%esp
     714:	8b 7d 0c             	mov    0xc(%ebp),%edi
  while (getLine(file.fd, line)) {
     717:	eb 1d                	jmp    736 <gatherLines+0x36>
     719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    append(file.lines, line);
     720:	8b 45 10             	mov    0x10(%ebp),%eax
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     723:	83 ec 04             	sub    $0x4,%esp
    lines++;
     726:	83 c3 01             	add    $0x1,%ebx
     729:	ff 70 08             	pushl  0x8(%eax)
     72c:	56                   	push   %esi
     72d:	50                   	push   %eax
     72e:	e8 ad fd ff ff       	call   4e0 <insert>
     733:	83 c4 10             	add    $0x10,%esp
  while (getLine(file.fd, line)) {
     736:	83 ec 08             	sub    $0x8,%esp
     739:	56                   	push   %esi
     73a:	57                   	push   %edi
     73b:	e8 30 ff ff ff       	call   670 <getLine>
     740:	83 c4 10             	add    $0x10,%esp
     743:	85 c0                	test   %eax,%eax
     745:	75 d9                	jne    720 <gatherLines+0x20>
  fprintf(2, "%d lines read from %s\n", lines, file.filename);
     747:	ff 75 08             	pushl  0x8(%ebp)
     74a:	53                   	push   %ebx
     74b:	68 46 13 00 00       	push   $0x1346
     750:	6a 02                	push   $0x2
     752:	e8 19 0a 00 00       	call   1170 <fprintf>
}
     757:	83 c4 10             	add    $0x10,%esp
     75a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     75d:	5b                   	pop    %ebx
     75e:	5e                   	pop    %esi
     75f:	5f                   	pop    %edi
     760:	5d                   	pop    %ebp
     761:	c3                   	ret    
     762:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000770 <find>:
int find(char* str, char c) {
     770:	55                   	push   %ebp
     771:	89 e5                	mov    %esp,%ebp
     773:	57                   	push   %edi
     774:	56                   	push   %esi
     775:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     776:	31 db                	xor    %ebx,%ebx
int find(char* str, char c) {
     778:	83 ec 0c             	sub    $0xc,%esp
     77b:	8b 75 08             	mov    0x8(%ebp),%esi
     77e:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
  for (int i = 0; i < strlen(str); i++)
     782:	eb 0e                	jmp    792 <find+0x22>
     784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     788:	89 f8                	mov    %edi,%eax
     78a:	38 04 1e             	cmp    %al,(%esi,%ebx,1)
     78d:	74 18                	je     7a7 <find+0x37>
  for (int i = 0; i < strlen(str); i++)
     78f:	83 c3 01             	add    $0x1,%ebx
     792:	83 ec 0c             	sub    $0xc,%esp
     795:	56                   	push   %esi
     796:	e8 95 04 00 00       	call   c30 <strlen>
     79b:	83 c4 10             	add    $0x10,%esp
     79e:	39 d8                	cmp    %ebx,%eax
     7a0:	77 e6                	ja     788 <find+0x18>
  return -1;
     7a2:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
     7a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7aa:	89 d8                	mov    %ebx,%eax
     7ac:	5b                   	pop    %ebx
     7ad:	5e                   	pop    %esi
     7ae:	5f                   	pop    %edi
     7af:	5d                   	pop    %ebp
     7b0:	c3                   	ret    
     7b1:	eb 0d                	jmp    7c0 <substr>
     7b3:	90                   	nop
     7b4:	90                   	nop
     7b5:	90                   	nop
     7b6:	90                   	nop
     7b7:	90                   	nop
     7b8:	90                   	nop
     7b9:	90                   	nop
     7ba:	90                   	nop
     7bb:	90                   	nop
     7bc:	90                   	nop
     7bd:	90                   	nop
     7be:	90                   	nop
     7bf:	90                   	nop

000007c0 <substr>:
void substr(char* dest, char* str, int start, int end) {
     7c0:	55                   	push   %ebp
     7c1:	89 e5                	mov    %esp,%ebp
     7c3:	57                   	push   %edi
     7c4:	56                   	push   %esi
     7c5:	53                   	push   %ebx
     7c6:	83 ec 18             	sub    $0x18,%esp
     7c9:	8b 75 0c             	mov    0xc(%ebp),%esi
     7cc:	8b 7d 14             	mov    0x14(%ebp),%edi
     7cf:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str);
     7d2:	56                   	push   %esi
     7d3:	e8 58 04 00 00       	call   c30 <strlen>
     7d8:	83 c4 10             	add    $0x10,%esp
     7db:	39 f8                	cmp    %edi,%eax
     7dd:	0f 4e f8             	cmovle %eax,%edi
  for (int i = start; i < end; i++)
     7e0:	3b 7d 10             	cmp    0x10(%ebp),%edi
     7e3:	7e 1e                	jle    803 <substr+0x43>
     7e5:	8b 55 10             	mov    0x10(%ebp),%edx
    dest[s++] = str[i];
     7e8:	89 d8                	mov    %ebx,%eax
     7ea:	29 d0                	sub    %edx,%eax
     7ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     7f0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     7f4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  for (int i = start; i < end; i++)
     7f7:	83 c2 01             	add    $0x1,%edx
     7fa:	39 d7                	cmp    %edx,%edi
     7fc:	75 f2                	jne    7f0 <substr+0x30>
     7fe:	2b 7d 10             	sub    0x10(%ebp),%edi
     801:	01 fb                	add    %edi,%ebx
  dest[s] = '\0';
     803:	c6 03 00             	movb   $0x0,(%ebx)
}
     806:	8d 65 f4             	lea    -0xc(%ebp),%esp
     809:	5b                   	pop    %ebx
     80a:	5e                   	pop    %esi
     80b:	5f                   	pop    %edi
     80c:	5d                   	pop    %ebp
     80d:	c3                   	ret    
     80e:	66 90                	xchg   %ax,%ax

00000810 <getArg>:
void getArg(char* dest, char* args, char delimiter) {
     810:	55                   	push   %ebp
     811:	89 e5                	mov    %esp,%ebp
     813:	57                   	push   %edi
     814:	56                   	push   %esi
     815:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     816:	31 db                	xor    %ebx,%ebx
void getArg(char* dest, char* args, char delimiter) {
     818:	83 ec 1c             	sub    $0x1c,%esp
     81b:	8b 75 0c             	mov    0xc(%ebp),%esi
     81e:	0f b6 7d 10          	movzbl 0x10(%ebp),%edi
     822:	eb 10                	jmp    834 <getArg+0x24>
     824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     828:	89 f8                	mov    %edi,%eax
     82a:	3a 04 1e             	cmp    (%esi,%ebx,1),%al
     82d:	8d 53 01             	lea    0x1(%ebx),%edx
     830:	74 19                	je     84b <getArg+0x3b>
     832:	89 d3                	mov    %edx,%ebx
  for (int i = 0; i < strlen(str); i++)
     834:	83 ec 0c             	sub    $0xc,%esp
     837:	56                   	push   %esi
     838:	e8 f3 03 00 00       	call   c30 <strlen>
     83d:	83 c4 10             	add    $0x10,%esp
     840:	39 c3                	cmp    %eax,%ebx
     842:	72 e4                	jb     828 <getArg+0x18>
     844:	31 d2                	xor    %edx,%edx
  return -1;
     846:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  substr(dest, args, 0, end);
     84b:	53                   	push   %ebx
     84c:	6a 00                	push   $0x0
     84e:	56                   	push   %esi
     84f:	ff 75 08             	pushl  0x8(%ebp)
     852:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     855:	e8 66 ff ff ff       	call   7c0 <substr>
  substr(args, args, end + 1, (int) strlen(args));
     85a:	89 34 24             	mov    %esi,(%esp)
     85d:	e8 ce 03 00 00       	call   c30 <strlen>
     862:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     865:	50                   	push   %eax
     866:	52                   	push   %edx
     867:	56                   	push   %esi
     868:	56                   	push   %esi
     869:	e8 52 ff ff ff       	call   7c0 <substr>
}
     86e:	83 c4 20             	add    $0x20,%esp
     871:	8d 65 f4             	lea    -0xc(%ebp),%esp
     874:	5b                   	pop    %ebx
     875:	5e                   	pop    %esi
     876:	5f                   	pop    %edi
     877:	5d                   	pop    %ebp
     878:	c3                   	ret    
     879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000880 <collectRange>:
int collectRange(char* args, int* startptr, int* endptr) {
     880:	55                   	push   %ebp
     881:	89 e5                	mov    %esp,%ebp
     883:	57                   	push   %edi
     884:	56                   	push   %esi
     885:	53                   	push   %ebx
     886:	31 ff                	xor    %edi,%edi
     888:	83 ec 10             	sub    $0x10,%esp
     88b:	8b 5d 08             	mov    0x8(%ebp),%ebx
     88e:	8b 75 0c             	mov    0xc(%ebp),%esi
  getArg(startstr, args, ':');
     891:	6a 3a                	push   $0x3a
     893:	53                   	push   %ebx
     894:	68 ac 13 00 00       	push   $0x13ac
     899:	e8 72 ff ff ff       	call   810 <getArg>
  if (endstr[0] == '-') {
     89e:	83 c4 10             	add    $0x10,%esp
     8a1:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     8a4:	0f 84 9e 00 00 00    	je     948 <collectRange+0xc8>
  if (strcmp(startstr, "\0") == 0) *startptr = 1;
     8aa:	83 ec 08             	sub    $0x8,%esp
     8ad:	68 ec 13 00 00       	push   $0x13ec
     8b2:	68 ac 13 00 00       	push   $0x13ac
     8b7:	e8 24 03 00 00       	call   be0 <strcmp>
     8bc:	83 c4 10             	add    $0x10,%esp
     8bf:	85 c0                	test   %eax,%eax
     8c1:	75 55                	jne    918 <collectRange+0x98>
     8c3:	c7 06 01 00 00 00    	movl   $0x1,(%esi)
  if (strcmp(endstr, "\0") == 0) *endptr = -1;
     8c9:	83 ec 08             	sub    $0x8,%esp
     8cc:	68 ec 13 00 00       	push   $0x13ec
     8d1:	53                   	push   %ebx
     8d2:	e8 09 03 00 00       	call   be0 <strcmp>
     8d7:	83 c4 10             	add    $0x10,%esp
     8da:	85 c0                	test   %eax,%eax
     8dc:	75 52                	jne    930 <collectRange+0xb0>
     8de:	8b 45 10             	mov    0x10(%ebp),%eax
     8e1:	ba ff ff ff ff       	mov    $0xffffffff,%edx
     8e6:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  if (negEndFlag) *endptr = 0 - *endptr;
     8ec:	85 ff                	test   %edi,%edi
     8ee:	74 07                	je     8f7 <collectRange+0x77>
     8f0:	8b 45 10             	mov    0x10(%ebp),%eax
     8f3:	f7 da                	neg    %edx
     8f5:	89 10                	mov    %edx,(%eax)
  if ((*startptr > *endptr) && (*endptr > 0)) {
     8f7:	39 16                	cmp    %edx,(%esi)
     8f9:	0f 9f c0             	setg   %al
     8fc:	85 d2                	test   %edx,%edx
     8fe:	0f 9f c2             	setg   %dl
}
     901:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if ((*startptr > *endptr) && (*endptr > 0)) {
     904:	21 d0                	and    %edx,%eax
     906:	83 f0 01             	xor    $0x1,%eax
}
     909:	5b                   	pop    %ebx
  return 1;
     90a:	0f b6 c0             	movzbl %al,%eax
}
     90d:	5e                   	pop    %esi
     90e:	5f                   	pop    %edi
     90f:	5d                   	pop    %ebp
     910:	c3                   	ret    
     911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else *startptr = atoi(startstr);
     918:	83 ec 0c             	sub    $0xc,%esp
     91b:	68 ac 13 00 00       	push   $0x13ac
     920:	e8 6b 04 00 00       	call   d90 <atoi>
     925:	83 c4 10             	add    $0x10,%esp
     928:	89 06                	mov    %eax,(%esi)
     92a:	eb 9d                	jmp    8c9 <collectRange+0x49>
     92c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else *endptr = atoi(endstr);
     930:	83 ec 0c             	sub    $0xc,%esp
     933:	53                   	push   %ebx
     934:	e8 57 04 00 00       	call   d90 <atoi>
     939:	89 c2                	mov    %eax,%edx
     93b:	8b 45 10             	mov    0x10(%ebp),%eax
     93e:	83 c4 10             	add    $0x10,%esp
     941:	89 10                	mov    %edx,(%eax)
     943:	eb a7                	jmp    8ec <collectRange+0x6c>
     945:	8d 76 00             	lea    0x0(%esi),%esi
    substr(endstr, endstr, 1, strlen(endstr));
     948:	83 ec 0c             	sub    $0xc,%esp
    negEndFlag = 1;
     94b:	bf 01 00 00 00       	mov    $0x1,%edi
    substr(endstr, endstr, 1, strlen(endstr));
     950:	53                   	push   %ebx
     951:	e8 da 02 00 00       	call   c30 <strlen>
     956:	50                   	push   %eax
     957:	6a 01                	push   $0x1
     959:	53                   	push   %ebx
     95a:	53                   	push   %ebx
     95b:	e8 60 fe ff ff       	call   7c0 <substr>
     960:	83 c4 20             	add    $0x20,%esp
     963:	e9 42 ff ff ff       	jmp    8aa <collectRange+0x2a>
     968:	90                   	nop
     969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000970 <list>:
void list(struct File file, char* args) {
     970:	55                   	push   %ebp
     971:	89 e5                	mov    %esp,%ebp
     973:	56                   	push   %esi
     974:	53                   	push   %ebx
     975:	83 ec 1c             	sub    $0x1c,%esp
     978:	8b 5d 14             	mov    0x14(%ebp),%ebx
     97b:	8b 75 10             	mov    0x10(%ebp),%esi
  if (strlen(args) < 1) {
     97e:	53                   	push   %ebx
     97f:	e8 ac 02 00 00       	call   c30 <strlen>
     984:	83 c4 10             	add    $0x10,%esp
     987:	85 c0                	test   %eax,%eax
     989:	74 6d                	je     9f8 <list+0x88>
  if (!collectRange(args, &start, &end)) return;
     98b:	8d 45 f4             	lea    -0xc(%ebp),%eax
     98e:	83 ec 04             	sub    $0x4,%esp
     991:	50                   	push   %eax
     992:	8d 45 f0             	lea    -0x10(%ebp),%eax
     995:	50                   	push   %eax
     996:	53                   	push   %ebx
     997:	e8 e4 fe ff ff       	call   880 <collectRange>
     99c:	83 c4 10             	add    $0x10,%esp
     99f:	85 c0                	test   %eax,%eax
     9a1:	74 49                	je     9ec <list+0x7c>
  str[len] = '\0';
}

// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
  return nodeAt(list, pos-1);
     9a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9a6:	83 ec 08             	sub    $0x8,%esp
     9a9:	83 e8 01             	sub    $0x1,%eax
     9ac:	50                   	push   %eax
     9ad:	56                   	push   %esi
     9ae:	e8 ad fa ff ff       	call   460 <nodeAt>
  struct Node* curNode = (lineAt(file.lines, start))->prev;
     9b3:	8b 18                	mov    (%eax),%ebx
  return nodeAt(list, pos-1);
     9b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9b8:	5a                   	pop    %edx
     9b9:	59                   	pop    %ecx
     9ba:	83 e8 01             	sub    $0x1,%eax
     9bd:	50                   	push   %eax
     9be:	56                   	push   %esi
     9bf:	e8 9c fa ff ff       	call   460 <nodeAt>
     9c4:	83 c4 10             	add    $0x10,%esp
  while (curNode != endNode) {
     9c7:	39 d8                	cmp    %ebx,%eax
  return nodeAt(list, pos-1);
     9c9:	89 c6                	mov    %eax,%esi
  while (curNode != endNode) {
     9cb:	74 1f                	je     9ec <list+0x7c>
     9cd:	8d 76 00             	lea    0x0(%esi),%esi
    curNode = curNode->next;
     9d0:	8b 5b 08             	mov    0x8(%ebx),%ebx
    fprintf(2, "%s\n", curNode->data);
     9d3:	83 ec 04             	sub    $0x4,%esp
     9d6:	ff 73 04             	pushl  0x4(%ebx)
     9d9:	68 59 13 00 00       	push   $0x1359
     9de:	6a 02                	push   $0x2
     9e0:	e8 8b 07 00 00       	call   1170 <fprintf>
  while (curNode != endNode) {
     9e5:	83 c4 10             	add    $0x10,%esp
     9e8:	39 de                	cmp    %ebx,%esi
     9ea:	75 e4                	jne    9d0 <list+0x60>
}
     9ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
     9ef:	5b                   	pop    %ebx
     9f0:	5e                   	pop    %esi
     9f1:	5d                   	pop    %ebp
     9f2:	c3                   	ret    
     9f3:	90                   	nop
     9f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "you need to give a range to list");
     9f8:	83 ec 08             	sub    $0x8,%esp
     9fb:	68 f0 13 00 00       	push   $0x13f0
     a00:	6a 02                	push   $0x2
     a02:	e8 69 07 00 00       	call   1170 <fprintf>
     a07:	83 c4 10             	add    $0x10,%esp
     a0a:	e9 7c ff ff ff       	jmp    98b <list+0x1b>
     a0f:	90                   	nop

00000a10 <toUpper>:
void toUpper(char* str) {
     a10:	55                   	push   %ebp
     a11:	89 e5                	mov    %esp,%ebp
     a13:	8b 55 08             	mov    0x8(%ebp),%edx
  while (str[i] != '\0') {
     a16:	0f b6 02             	movzbl (%edx),%eax
     a19:	84 c0                	test   %al,%al
     a1b:	74 1a                	je     a37 <toUpper+0x27>
     a1d:	8d 76 00             	lea    0x0(%esi),%esi
    if (c <= 'z' && c >= 'a')
     a20:	8d 48 9f             	lea    -0x61(%eax),%ecx
     a23:	80 f9 19             	cmp    $0x19,%cl
     a26:	77 05                	ja     a2d <toUpper+0x1d>
      str[i] += ('Z' - 'z');
     a28:	83 e8 20             	sub    $0x20,%eax
     a2b:	88 02                	mov    %al,(%edx)
     a2d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     a30:	0f b6 02             	movzbl (%edx),%eax
     a33:	84 c0                	test   %al,%al
     a35:	75 e9                	jne    a20 <toUpper+0x10>
}
     a37:	5d                   	pop    %ebp
     a38:	c3                   	ret    
     a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a40 <toLower>:
void toLower(char* str) {
     a40:	55                   	push   %ebp
     a41:	89 e5                	mov    %esp,%ebp
     a43:	8b 55 08             	mov    0x8(%ebp),%edx
  while (str[i] != '\0') {
     a46:	0f b6 02             	movzbl (%edx),%eax
     a49:	84 c0                	test   %al,%al
     a4b:	74 1a                	je     a67 <toLower+0x27>
     a4d:	8d 76 00             	lea    0x0(%esi),%esi
    if (c <= 'Z' && c >= 'A')
     a50:	8d 48 bf             	lea    -0x41(%eax),%ecx
     a53:	80 f9 19             	cmp    $0x19,%cl
     a56:	77 05                	ja     a5d <toLower+0x1d>
      str[i] -= ('Z' - 'z');
     a58:	83 c0 20             	add    $0x20,%eax
     a5b:	88 02                	mov    %al,(%edx)
     a5d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     a60:	0f b6 02             	movzbl (%edx),%eax
     a63:	84 c0                	test   %al,%al
     a65:	75 e9                	jne    a50 <toLower+0x10>
}
     a67:	5d                   	pop    %ebp
     a68:	c3                   	ret    
     a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a70 <unline>:
void unline(char* str) {
     a70:	55                   	push   %ebp
     a71:	89 e5                	mov    %esp,%ebp
     a73:	53                   	push   %ebx
     a74:	83 ec 10             	sub    $0x10,%esp
     a77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str) - 1;
     a7a:	53                   	push   %ebx
     a7b:	e8 b0 01 00 00       	call   c30 <strlen>
     a80:	8d 50 ff             	lea    -0x1(%eax),%edx
  for (; len > 0; len--) {
     a83:	83 c4 10             	add    $0x10,%esp
     a86:	85 d2                	test   %edx,%edx
     a88:	7e 36                	jle    ac0 <unline+0x50>
    if (c == '\n')
     a8a:	80 7c 03 ff 0a       	cmpb   $0xa,-0x1(%ebx,%eax,1)
     a8f:	74 2f                	je     ac0 <unline+0x50>
     a91:	8d 44 03 fe          	lea    -0x2(%ebx,%eax,1),%eax
     a95:	eb 12                	jmp    aa9 <unline+0x39>
     a97:	89 f6                	mov    %esi,%esi
     a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     aa0:	83 e8 01             	sub    $0x1,%eax
     aa3:	80 78 01 0a          	cmpb   $0xa,0x1(%eax)
     aa7:	74 06                	je     aaf <unline+0x3f>
  for (; len > 0; len--) {
     aa9:	39 c3                	cmp    %eax,%ebx
     aab:	89 c2                	mov    %eax,%edx
     aad:	75 f1                	jne    aa0 <unline+0x30>
  str[len] = '\0';
     aaf:	c6 02 00             	movb   $0x0,(%edx)
}
     ab2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ab5:	c9                   	leave  
     ab6:	c3                   	ret    
     ab7:	89 f6                	mov    %esi,%esi
     ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     ac0:	01 da                	add    %ebx,%edx
  str[len] = '\0';
     ac2:	c6 02 00             	movb   $0x0,(%edx)
}
     ac5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ac8:	c9                   	leave  
     ac9:	c3                   	ret    
     aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000ad0 <lineAt>:
Node* lineAt(struct LinkedList* list, int pos) {
     ad0:	55                   	push   %ebp
     ad1:	89 e5                	mov    %esp,%ebp
  return nodeAt(list, pos-1);
     ad3:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
}
     ad7:	5d                   	pop    %ebp
  return nodeAt(list, pos-1);
     ad8:	e9 83 f9 ff ff       	jmp    460 <nodeAt>
     add:	8d 76 00             	lea    0x0(%esi),%esi

00000ae0 <printl>:

void printl(int lineNum, char* line) {
     ae0:	55                   	push   %ebp
     ae1:	89 e5                	mov    %esp,%ebp
     ae3:	83 ec 08             	sub    $0x8,%esp
     ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  if (lineNum < 10)
     ae9:	83 f8 09             	cmp    $0x9,%eax
     aec:	7e 3a                	jle    b28 <printl+0x48>
    fprintf(2, "%d   | %s\n", lineNum, line);
  else if (lineNum < 100)
     aee:	83 f8 63             	cmp    $0x63,%eax
     af1:	7e 1d                	jle    b10 <printl+0x30>
    fprintf(2, "%d  | %s\n", lineNum, line);
  else if (lineNum < 1000)
     af3:	3d e7 03 00 00       	cmp    $0x3e7,%eax
     af8:	7e 46                	jle    b40 <printl+0x60>
    fprintf(2, "%d | %s\n", lineNum, line);
  else
    fprintf(2, "%d| %s\n", lineNum, line);
     afa:	ff 75 0c             	pushl  0xc(%ebp)
     afd:	50                   	push   %eax
     afe:	68 7b 13 00 00       	push   $0x137b
     b03:	6a 02                	push   $0x2
     b05:	e8 66 06 00 00       	call   1170 <fprintf>
     b0a:	83 c4 10             	add    $0x10,%esp
     b0d:	c9                   	leave  
     b0e:	c3                   	ret    
     b0f:	90                   	nop
    fprintf(2, "%d  | %s\n", lineNum, line);
     b10:	ff 75 0c             	pushl  0xc(%ebp)
     b13:	50                   	push   %eax
     b14:	68 68 13 00 00       	push   $0x1368
     b19:	6a 02                	push   $0x2
     b1b:	e8 50 06 00 00       	call   1170 <fprintf>
     b20:	83 c4 10             	add    $0x10,%esp
     b23:	c9                   	leave  
     b24:	c3                   	ret    
     b25:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "%d   | %s\n", lineNum, line);
     b28:	ff 75 0c             	pushl  0xc(%ebp)
     b2b:	50                   	push   %eax
     b2c:	68 5d 13 00 00       	push   $0x135d
     b31:	6a 02                	push   $0x2
     b33:	e8 38 06 00 00       	call   1170 <fprintf>
     b38:	83 c4 10             	add    $0x10,%esp
     b3b:	c9                   	leave  
     b3c:	c3                   	ret    
     b3d:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "%d | %s\n", lineNum, line);
     b40:	ff 75 0c             	pushl  0xc(%ebp)
     b43:	50                   	push   %eax
     b44:	68 72 13 00 00       	push   $0x1372
     b49:	6a 02                	push   $0x2
     b4b:	e8 20 06 00 00       	call   1170 <fprintf>
     b50:	83 c4 10             	add    $0x10,%esp
     b53:	c9                   	leave  
     b54:	c3                   	ret    
     b55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b60 <show>:
void show(struct File file, char* args) {
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
     b63:	57                   	push   %edi
     b64:	56                   	push   %esi
     b65:	53                   	push   %ebx
     b66:	83 ec 0c             	sub    $0xc,%esp
     b69:	8b 7d 10             	mov    0x10(%ebp),%edi
  struct Node* curr = file.lines->head->next;
     b6c:	8b 07                	mov    (%edi),%eax
     b6e:	8b 58 08             	mov    0x8(%eax),%ebx
  while (curr != file.lines->tail) {
     b71:	3b 5f 04             	cmp    0x4(%edi),%ebx
     b74:	74 24                	je     b9a <show+0x3a>
  int lineNum = 1;
     b76:	be 01 00 00 00       	mov    $0x1,%esi
     b7b:	90                   	nop
     b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printl(lineNum, curr->data);
     b80:	83 ec 08             	sub    $0x8,%esp
     b83:	ff 73 04             	pushl  0x4(%ebx)
     b86:	56                   	push   %esi
    lineNum++;
     b87:	83 c6 01             	add    $0x1,%esi
    printl(lineNum, curr->data);
     b8a:	e8 51 ff ff ff       	call   ae0 <printl>
    curr = curr->next;
     b8f:	8b 5b 08             	mov    0x8(%ebx),%ebx
  while (curr != file.lines->tail) {
     b92:	83 c4 10             	add    $0x10,%esp
     b95:	39 5f 04             	cmp    %ebx,0x4(%edi)
     b98:	75 e6                	jne    b80 <show+0x20>
}
     b9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b9d:	5b                   	pop    %ebx
     b9e:	5e                   	pop    %esi
     b9f:	5f                   	pop    %edi
     ba0:	5d                   	pop    %ebp
     ba1:	c3                   	ret    
     ba2:	66 90                	xchg   %ax,%ax
     ba4:	66 90                	xchg   %ax,%ax
     ba6:	66 90                	xchg   %ax,%ax
     ba8:	66 90                	xchg   %ax,%ax
     baa:	66 90                	xchg   %ax,%ax
     bac:	66 90                	xchg   %ax,%ax
     bae:	66 90                	xchg   %ax,%ax

00000bb0 <strcpy>:
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	53                   	push   %ebx
     bb4:	8b 45 08             	mov    0x8(%ebp),%eax
     bb7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     bba:	89 c2                	mov    %eax,%edx
     bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     bc0:	83 c1 01             	add    $0x1,%ecx
     bc3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     bc7:	83 c2 01             	add    $0x1,%edx
     bca:	84 db                	test   %bl,%bl
     bcc:	88 5a ff             	mov    %bl,-0x1(%edx)
     bcf:	75 ef                	jne    bc0 <strcpy+0x10>
     bd1:	5b                   	pop    %ebx
     bd2:	5d                   	pop    %ebp
     bd3:	c3                   	ret    
     bd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     bda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000be0 <strcmp>:
     be0:	55                   	push   %ebp
     be1:	89 e5                	mov    %esp,%ebp
     be3:	53                   	push   %ebx
     be4:	8b 55 08             	mov    0x8(%ebp),%edx
     be7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     bea:	0f b6 02             	movzbl (%edx),%eax
     bed:	0f b6 19             	movzbl (%ecx),%ebx
     bf0:	84 c0                	test   %al,%al
     bf2:	75 1c                	jne    c10 <strcmp+0x30>
     bf4:	eb 2a                	jmp    c20 <strcmp+0x40>
     bf6:	8d 76 00             	lea    0x0(%esi),%esi
     bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     c00:	83 c2 01             	add    $0x1,%edx
     c03:	0f b6 02             	movzbl (%edx),%eax
     c06:	83 c1 01             	add    $0x1,%ecx
     c09:	0f b6 19             	movzbl (%ecx),%ebx
     c0c:	84 c0                	test   %al,%al
     c0e:	74 10                	je     c20 <strcmp+0x40>
     c10:	38 d8                	cmp    %bl,%al
     c12:	74 ec                	je     c00 <strcmp+0x20>
     c14:	29 d8                	sub    %ebx,%eax
     c16:	5b                   	pop    %ebx
     c17:	5d                   	pop    %ebp
     c18:	c3                   	ret    
     c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c20:	31 c0                	xor    %eax,%eax
     c22:	29 d8                	sub    %ebx,%eax
     c24:	5b                   	pop    %ebx
     c25:	5d                   	pop    %ebp
     c26:	c3                   	ret    
     c27:	89 f6                	mov    %esi,%esi
     c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c30 <strlen>:
     c30:	55                   	push   %ebp
     c31:	89 e5                	mov    %esp,%ebp
     c33:	8b 4d 08             	mov    0x8(%ebp),%ecx
     c36:	80 39 00             	cmpb   $0x0,(%ecx)
     c39:	74 15                	je     c50 <strlen+0x20>
     c3b:	31 d2                	xor    %edx,%edx
     c3d:	8d 76 00             	lea    0x0(%esi),%esi
     c40:	83 c2 01             	add    $0x1,%edx
     c43:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     c47:	89 d0                	mov    %edx,%eax
     c49:	75 f5                	jne    c40 <strlen+0x10>
     c4b:	5d                   	pop    %ebp
     c4c:	c3                   	ret    
     c4d:	8d 76 00             	lea    0x0(%esi),%esi
     c50:	31 c0                	xor    %eax,%eax
     c52:	5d                   	pop    %ebp
     c53:	c3                   	ret    
     c54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     c5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000c60 <memset>:
     c60:	55                   	push   %ebp
     c61:	89 e5                	mov    %esp,%ebp
     c63:	57                   	push   %edi
     c64:	8b 55 08             	mov    0x8(%ebp),%edx
     c67:	8b 4d 10             	mov    0x10(%ebp),%ecx
     c6a:	8b 45 0c             	mov    0xc(%ebp),%eax
     c6d:	89 d7                	mov    %edx,%edi
     c6f:	fc                   	cld    
     c70:	f3 aa                	rep stos %al,%es:(%edi)
     c72:	89 d0                	mov    %edx,%eax
     c74:	5f                   	pop    %edi
     c75:	5d                   	pop    %ebp
     c76:	c3                   	ret    
     c77:	89 f6                	mov    %esi,%esi
     c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c80 <strchr>:
     c80:	55                   	push   %ebp
     c81:	89 e5                	mov    %esp,%ebp
     c83:	53                   	push   %ebx
     c84:	8b 45 08             	mov    0x8(%ebp),%eax
     c87:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     c8a:	0f b6 10             	movzbl (%eax),%edx
     c8d:	84 d2                	test   %dl,%dl
     c8f:	74 1d                	je     cae <strchr+0x2e>
     c91:	38 d3                	cmp    %dl,%bl
     c93:	89 d9                	mov    %ebx,%ecx
     c95:	75 0d                	jne    ca4 <strchr+0x24>
     c97:	eb 17                	jmp    cb0 <strchr+0x30>
     c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ca0:	38 ca                	cmp    %cl,%dl
     ca2:	74 0c                	je     cb0 <strchr+0x30>
     ca4:	83 c0 01             	add    $0x1,%eax
     ca7:	0f b6 10             	movzbl (%eax),%edx
     caa:	84 d2                	test   %dl,%dl
     cac:	75 f2                	jne    ca0 <strchr+0x20>
     cae:	31 c0                	xor    %eax,%eax
     cb0:	5b                   	pop    %ebx
     cb1:	5d                   	pop    %ebp
     cb2:	c3                   	ret    
     cb3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000cc0 <gets>:
     cc0:	55                   	push   %ebp
     cc1:	89 e5                	mov    %esp,%ebp
     cc3:	57                   	push   %edi
     cc4:	56                   	push   %esi
     cc5:	53                   	push   %ebx
     cc6:	31 f6                	xor    %esi,%esi
     cc8:	89 f3                	mov    %esi,%ebx
     cca:	83 ec 1c             	sub    $0x1c,%esp
     ccd:	8b 7d 08             	mov    0x8(%ebp),%edi
     cd0:	eb 2f                	jmp    d01 <gets+0x41>
     cd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     cd8:	8d 45 e7             	lea    -0x19(%ebp),%eax
     cdb:	83 ec 04             	sub    $0x4,%esp
     cde:	6a 01                	push   $0x1
     ce0:	50                   	push   %eax
     ce1:	6a 00                	push   $0x0
     ce3:	e8 32 01 00 00       	call   e1a <read>
     ce8:	83 c4 10             	add    $0x10,%esp
     ceb:	85 c0                	test   %eax,%eax
     ced:	7e 1c                	jle    d0b <gets+0x4b>
     cef:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     cf3:	83 c7 01             	add    $0x1,%edi
     cf6:	88 47 ff             	mov    %al,-0x1(%edi)
     cf9:	3c 0a                	cmp    $0xa,%al
     cfb:	74 23                	je     d20 <gets+0x60>
     cfd:	3c 0d                	cmp    $0xd,%al
     cff:	74 1f                	je     d20 <gets+0x60>
     d01:	83 c3 01             	add    $0x1,%ebx
     d04:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     d07:	89 fe                	mov    %edi,%esi
     d09:	7c cd                	jl     cd8 <gets+0x18>
     d0b:	89 f3                	mov    %esi,%ebx
     d0d:	8b 45 08             	mov    0x8(%ebp),%eax
     d10:	c6 03 00             	movb   $0x0,(%ebx)
     d13:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d16:	5b                   	pop    %ebx
     d17:	5e                   	pop    %esi
     d18:	5f                   	pop    %edi
     d19:	5d                   	pop    %ebp
     d1a:	c3                   	ret    
     d1b:	90                   	nop
     d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d20:	8b 75 08             	mov    0x8(%ebp),%esi
     d23:	8b 45 08             	mov    0x8(%ebp),%eax
     d26:	01 de                	add    %ebx,%esi
     d28:	89 f3                	mov    %esi,%ebx
     d2a:	c6 03 00             	movb   $0x0,(%ebx)
     d2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d30:	5b                   	pop    %ebx
     d31:	5e                   	pop    %esi
     d32:	5f                   	pop    %edi
     d33:	5d                   	pop    %ebp
     d34:	c3                   	ret    
     d35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d40 <stat>:
     d40:	55                   	push   %ebp
     d41:	89 e5                	mov    %esp,%ebp
     d43:	56                   	push   %esi
     d44:	53                   	push   %ebx
     d45:	83 ec 08             	sub    $0x8,%esp
     d48:	6a 00                	push   $0x0
     d4a:	ff 75 08             	pushl  0x8(%ebp)
     d4d:	e8 f0 00 00 00       	call   e42 <open>
     d52:	83 c4 10             	add    $0x10,%esp
     d55:	85 c0                	test   %eax,%eax
     d57:	78 27                	js     d80 <stat+0x40>
     d59:	83 ec 08             	sub    $0x8,%esp
     d5c:	ff 75 0c             	pushl  0xc(%ebp)
     d5f:	89 c3                	mov    %eax,%ebx
     d61:	50                   	push   %eax
     d62:	e8 f3 00 00 00       	call   e5a <fstat>
     d67:	89 1c 24             	mov    %ebx,(%esp)
     d6a:	89 c6                	mov    %eax,%esi
     d6c:	e8 b9 00 00 00       	call   e2a <close>
     d71:	83 c4 10             	add    $0x10,%esp
     d74:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d77:	89 f0                	mov    %esi,%eax
     d79:	5b                   	pop    %ebx
     d7a:	5e                   	pop    %esi
     d7b:	5d                   	pop    %ebp
     d7c:	c3                   	ret    
     d7d:	8d 76 00             	lea    0x0(%esi),%esi
     d80:	be ff ff ff ff       	mov    $0xffffffff,%esi
     d85:	eb ed                	jmp    d74 <stat+0x34>
     d87:	89 f6                	mov    %esi,%esi
     d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d90 <atoi>:
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	53                   	push   %ebx
     d94:	8b 4d 08             	mov    0x8(%ebp),%ecx
     d97:	0f be 11             	movsbl (%ecx),%edx
     d9a:	8d 42 d0             	lea    -0x30(%edx),%eax
     d9d:	3c 09                	cmp    $0x9,%al
     d9f:	b8 00 00 00 00       	mov    $0x0,%eax
     da4:	77 1f                	ja     dc5 <atoi+0x35>
     da6:	8d 76 00             	lea    0x0(%esi),%esi
     da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     db0:	8d 04 80             	lea    (%eax,%eax,4),%eax
     db3:	83 c1 01             	add    $0x1,%ecx
     db6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
     dba:	0f be 11             	movsbl (%ecx),%edx
     dbd:	8d 5a d0             	lea    -0x30(%edx),%ebx
     dc0:	80 fb 09             	cmp    $0x9,%bl
     dc3:	76 eb                	jbe    db0 <atoi+0x20>
     dc5:	5b                   	pop    %ebx
     dc6:	5d                   	pop    %ebp
     dc7:	c3                   	ret    
     dc8:	90                   	nop
     dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000dd0 <memmove>:
     dd0:	55                   	push   %ebp
     dd1:	89 e5                	mov    %esp,%ebp
     dd3:	56                   	push   %esi
     dd4:	53                   	push   %ebx
     dd5:	8b 5d 10             	mov    0x10(%ebp),%ebx
     dd8:	8b 45 08             	mov    0x8(%ebp),%eax
     ddb:	8b 75 0c             	mov    0xc(%ebp),%esi
     dde:	85 db                	test   %ebx,%ebx
     de0:	7e 14                	jle    df6 <memmove+0x26>
     de2:	31 d2                	xor    %edx,%edx
     de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     de8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     dec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     def:	83 c2 01             	add    $0x1,%edx
     df2:	39 d3                	cmp    %edx,%ebx
     df4:	75 f2                	jne    de8 <memmove+0x18>
     df6:	5b                   	pop    %ebx
     df7:	5e                   	pop    %esi
     df8:	5d                   	pop    %ebp
     df9:	c3                   	ret    

00000dfa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     dfa:	b8 01 00 00 00       	mov    $0x1,%eax
     dff:	cd 40                	int    $0x40
     e01:	c3                   	ret    

00000e02 <exit>:
SYSCALL(exit)
     e02:	b8 02 00 00 00       	mov    $0x2,%eax
     e07:	cd 40                	int    $0x40
     e09:	c3                   	ret    

00000e0a <wait>:
SYSCALL(wait)
     e0a:	b8 03 00 00 00       	mov    $0x3,%eax
     e0f:	cd 40                	int    $0x40
     e11:	c3                   	ret    

00000e12 <pipe>:
SYSCALL(pipe)
     e12:	b8 04 00 00 00       	mov    $0x4,%eax
     e17:	cd 40                	int    $0x40
     e19:	c3                   	ret    

00000e1a <read>:
SYSCALL(read)
     e1a:	b8 05 00 00 00       	mov    $0x5,%eax
     e1f:	cd 40                	int    $0x40
     e21:	c3                   	ret    

00000e22 <write>:
SYSCALL(write)
     e22:	b8 10 00 00 00       	mov    $0x10,%eax
     e27:	cd 40                	int    $0x40
     e29:	c3                   	ret    

00000e2a <close>:
SYSCALL(close)
     e2a:	b8 15 00 00 00       	mov    $0x15,%eax
     e2f:	cd 40                	int    $0x40
     e31:	c3                   	ret    

00000e32 <kill>:
SYSCALL(kill)
     e32:	b8 06 00 00 00       	mov    $0x6,%eax
     e37:	cd 40                	int    $0x40
     e39:	c3                   	ret    

00000e3a <exec>:
SYSCALL(exec)
     e3a:	b8 07 00 00 00       	mov    $0x7,%eax
     e3f:	cd 40                	int    $0x40
     e41:	c3                   	ret    

00000e42 <open>:
SYSCALL(open)
     e42:	b8 0f 00 00 00       	mov    $0xf,%eax
     e47:	cd 40                	int    $0x40
     e49:	c3                   	ret    

00000e4a <mknod>:
SYSCALL(mknod)
     e4a:	b8 11 00 00 00       	mov    $0x11,%eax
     e4f:	cd 40                	int    $0x40
     e51:	c3                   	ret    

00000e52 <unlink>:
SYSCALL(unlink)
     e52:	b8 12 00 00 00       	mov    $0x12,%eax
     e57:	cd 40                	int    $0x40
     e59:	c3                   	ret    

00000e5a <fstat>:
SYSCALL(fstat)
     e5a:	b8 08 00 00 00       	mov    $0x8,%eax
     e5f:	cd 40                	int    $0x40
     e61:	c3                   	ret    

00000e62 <link>:
SYSCALL(link)
     e62:	b8 13 00 00 00       	mov    $0x13,%eax
     e67:	cd 40                	int    $0x40
     e69:	c3                   	ret    

00000e6a <mkdir>:
SYSCALL(mkdir)
     e6a:	b8 14 00 00 00       	mov    $0x14,%eax
     e6f:	cd 40                	int    $0x40
     e71:	c3                   	ret    

00000e72 <chdir>:
SYSCALL(chdir)
     e72:	b8 09 00 00 00       	mov    $0x9,%eax
     e77:	cd 40                	int    $0x40
     e79:	c3                   	ret    

00000e7a <dup>:
SYSCALL(dup)
     e7a:	b8 0a 00 00 00       	mov    $0xa,%eax
     e7f:	cd 40                	int    $0x40
     e81:	c3                   	ret    

00000e82 <getpid>:
SYSCALL(getpid)
     e82:	b8 0b 00 00 00       	mov    $0xb,%eax
     e87:	cd 40                	int    $0x40
     e89:	c3                   	ret    

00000e8a <sbrk>:
SYSCALL(sbrk)
     e8a:	b8 0c 00 00 00       	mov    $0xc,%eax
     e8f:	cd 40                	int    $0x40
     e91:	c3                   	ret    

00000e92 <sleep>:
SYSCALL(sleep)
     e92:	b8 0d 00 00 00       	mov    $0xd,%eax
     e97:	cd 40                	int    $0x40
     e99:	c3                   	ret    

00000e9a <uptime>:
SYSCALL(uptime)
     e9a:	b8 0e 00 00 00       	mov    $0xe,%eax
     e9f:	cd 40                	int    $0x40
     ea1:	c3                   	ret    

00000ea2 <cpuhalt>:
SYSCALL(cpuhalt)
     ea2:	b8 16 00 00 00       	mov    $0x16,%eax
     ea7:	cd 40                	int    $0x40
     ea9:	c3                   	ret    
     eaa:	66 90                	xchg   %ax,%ax
     eac:	66 90                	xchg   %ax,%ax
     eae:	66 90                	xchg   %ax,%ax

00000eb0 <printint.constprop.1>:
     eb0:	55                   	push   %ebp
     eb1:	89 e5                	mov    %esp,%ebp
     eb3:	57                   	push   %edi
     eb4:	56                   	push   %esi
     eb5:	53                   	push   %ebx
     eb6:	89 d6                	mov    %edx,%esi
     eb8:	83 ec 3c             	sub    $0x3c,%esp
     ebb:	85 c0                	test   %eax,%eax
     ebd:	79 71                	jns    f30 <printint.constprop.1+0x80>
     ebf:	83 e1 01             	and    $0x1,%ecx
     ec2:	74 6c                	je     f30 <printint.constprop.1+0x80>
     ec4:	f7 d8                	neg    %eax
     ec6:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
     ecd:	31 c9                	xor    %ecx,%ecx
     ecf:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     ed2:	eb 06                	jmp    eda <printint.constprop.1+0x2a>
     ed4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ed8:	89 f9                	mov    %edi,%ecx
     eda:	31 d2                	xor    %edx,%edx
     edc:	8d 79 01             	lea    0x1(%ecx),%edi
     edf:	f7 f6                	div    %esi
     ee1:	0f b6 92 3c 14 00 00 	movzbl 0x143c(%edx),%edx
     ee8:	85 c0                	test   %eax,%eax
     eea:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
     eed:	75 e9                	jne    ed8 <printint.constprop.1+0x28>
     eef:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     ef2:	85 c0                	test   %eax,%eax
     ef4:	74 08                	je     efe <printint.constprop.1+0x4e>
     ef6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     efb:	8d 79 02             	lea    0x2(%ecx),%edi
     efe:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
     f02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f08:	0f b6 06             	movzbl (%esi),%eax
     f0b:	83 ec 04             	sub    $0x4,%esp
     f0e:	83 ee 01             	sub    $0x1,%esi
     f11:	6a 01                	push   $0x1
     f13:	53                   	push   %ebx
     f14:	6a 01                	push   $0x1
     f16:	88 45 d7             	mov    %al,-0x29(%ebp)
     f19:	e8 04 ff ff ff       	call   e22 <write>
     f1e:	83 c4 10             	add    $0x10,%esp
     f21:	39 de                	cmp    %ebx,%esi
     f23:	75 e3                	jne    f08 <printint.constprop.1+0x58>
     f25:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f28:	5b                   	pop    %ebx
     f29:	5e                   	pop    %esi
     f2a:	5f                   	pop    %edi
     f2b:	5d                   	pop    %ebp
     f2c:	c3                   	ret    
     f2d:	8d 76 00             	lea    0x0(%esi),%esi
     f30:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     f37:	eb 94                	jmp    ecd <printint.constprop.1+0x1d>
     f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000f40 <vprintf.constprop.0>:
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	57                   	push   %edi
     f44:	56                   	push   %esi
     f45:	53                   	push   %ebx
     f46:	89 d6                	mov    %edx,%esi
     f48:	83 ec 2c             	sub    $0x2c,%esp
     f4b:	0f b6 10             	movzbl (%eax),%edx
     f4e:	84 d2                	test   %dl,%dl
     f50:	0f 84 cd 00 00 00    	je     1023 <vprintf.constprop.0+0xe3>
     f56:	8d 58 01             	lea    0x1(%eax),%ebx
     f59:	31 ff                	xor    %edi,%edi
     f5b:	eb 31                	jmp    f8e <vprintf.constprop.0+0x4e>
     f5d:	8d 76 00             	lea    0x0(%esi),%esi
     f60:	83 f8 25             	cmp    $0x25,%eax
     f63:	0f 84 c7 00 00 00    	je     1030 <vprintf.constprop.0+0xf0>
     f69:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     f6c:	83 ec 04             	sub    $0x4,%esp
     f6f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
     f72:	6a 01                	push   $0x1
     f74:	50                   	push   %eax
     f75:	6a 01                	push   $0x1
     f77:	e8 a6 fe ff ff       	call   e22 <write>
     f7c:	83 c4 10             	add    $0x10,%esp
     f7f:	83 c3 01             	add    $0x1,%ebx
     f82:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     f86:	84 d2                	test   %dl,%dl
     f88:	0f 84 95 00 00 00    	je     1023 <vprintf.constprop.0+0xe3>
     f8e:	85 ff                	test   %edi,%edi
     f90:	0f b6 c2             	movzbl %dl,%eax
     f93:	74 cb                	je     f60 <vprintf.constprop.0+0x20>
     f95:	83 ff 25             	cmp    $0x25,%edi
     f98:	75 e5                	jne    f7f <vprintf.constprop.0+0x3f>
     f9a:	83 f8 64             	cmp    $0x64,%eax
     f9d:	8d 7e 04             	lea    0x4(%esi),%edi
     fa0:	b9 01 00 00 00       	mov    $0x1,%ecx
     fa5:	0f 84 9a 00 00 00    	je     1045 <vprintf.constprop.0+0x105>
     fab:	83 f8 6c             	cmp    $0x6c,%eax
     fae:	0f 84 8c 00 00 00    	je     1040 <vprintf.constprop.0+0x100>
     fb4:	83 f8 78             	cmp    $0x78,%eax
     fb7:	0f 84 a3 00 00 00    	je     1060 <vprintf.constprop.0+0x120>
     fbd:	83 f8 70             	cmp    $0x70,%eax
     fc0:	0f 84 ca 00 00 00    	je     1090 <vprintf.constprop.0+0x150>
     fc6:	83 f8 73             	cmp    $0x73,%eax
     fc9:	0f 84 39 01 00 00    	je     1108 <vprintf.constprop.0+0x1c8>
     fcf:	83 f8 63             	cmp    $0x63,%eax
     fd2:	0f 84 68 01 00 00    	je     1140 <vprintf.constprop.0+0x200>
     fd8:	83 f8 25             	cmp    $0x25,%eax
     fdb:	0f 84 9f 00 00 00    	je     1080 <vprintf.constprop.0+0x140>
     fe1:	8d 45 df             	lea    -0x21(%ebp),%eax
     fe4:	83 ec 04             	sub    $0x4,%esp
     fe7:	88 55 d4             	mov    %dl,-0x2c(%ebp)
     fea:	6a 01                	push   $0x1
     fec:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
     ff0:	50                   	push   %eax
     ff1:	6a 01                	push   $0x1
     ff3:	e8 2a fe ff ff       	call   e22 <write>
     ff8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
     ffc:	83 c4 0c             	add    $0xc,%esp
     fff:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1002:	6a 01                	push   $0x1
    1004:	88 55 e0             	mov    %dl,-0x20(%ebp)
    1007:	50                   	push   %eax
    1008:	6a 01                	push   $0x1
    100a:	83 c3 01             	add    $0x1,%ebx
    100d:	31 ff                	xor    %edi,%edi
    100f:	e8 0e fe ff ff       	call   e22 <write>
    1014:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1018:	83 c4 10             	add    $0x10,%esp
    101b:	84 d2                	test   %dl,%dl
    101d:	0f 85 6b ff ff ff    	jne    f8e <vprintf.constprop.0+0x4e>
    1023:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1026:	5b                   	pop    %ebx
    1027:	5e                   	pop    %esi
    1028:	5f                   	pop    %edi
    1029:	5d                   	pop    %ebp
    102a:	c3                   	ret    
    102b:	90                   	nop
    102c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1030:	bf 25 00 00 00       	mov    $0x25,%edi
    1035:	e9 45 ff ff ff       	jmp    f7f <vprintf.constprop.0+0x3f>
    103a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1040:	8d 7e 04             	lea    0x4(%esi),%edi
    1043:	31 c9                	xor    %ecx,%ecx
    1045:	8b 06                	mov    (%esi),%eax
    1047:	ba 0a 00 00 00       	mov    $0xa,%edx
    104c:	89 fe                	mov    %edi,%esi
    104e:	31 ff                	xor    %edi,%edi
    1050:	e8 5b fe ff ff       	call   eb0 <printint.constprop.1>
    1055:	e9 25 ff ff ff       	jmp    f7f <vprintf.constprop.0+0x3f>
    105a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1060:	8b 06                	mov    (%esi),%eax
    1062:	8d 7e 04             	lea    0x4(%esi),%edi
    1065:	31 c9                	xor    %ecx,%ecx
    1067:	ba 10 00 00 00       	mov    $0x10,%edx
    106c:	89 fe                	mov    %edi,%esi
    106e:	31 ff                	xor    %edi,%edi
    1070:	e8 3b fe ff ff       	call   eb0 <printint.constprop.1>
    1075:	e9 05 ff ff ff       	jmp    f7f <vprintf.constprop.0+0x3f>
    107a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1080:	83 ec 04             	sub    $0x4,%esp
    1083:	88 55 e1             	mov    %dl,-0x1f(%ebp)
    1086:	8d 45 e1             	lea    -0x1f(%ebp),%eax
    1089:	6a 01                	push   $0x1
    108b:	e9 77 ff ff ff       	jmp    1007 <vprintf.constprop.0+0xc7>
    1090:	8d 46 04             	lea    0x4(%esi),%eax
    1093:	83 ec 04             	sub    $0x4,%esp
    1096:	8b 3e                	mov    (%esi),%edi
    1098:	6a 01                	push   $0x1
    109a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
    109e:	be 08 00 00 00       	mov    $0x8,%esi
    10a3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    10a6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    10a9:	50                   	push   %eax
    10aa:	6a 01                	push   $0x1
    10ac:	e8 71 fd ff ff       	call   e22 <write>
    10b1:	8d 45 e7             	lea    -0x19(%ebp),%eax
    10b4:	83 c4 0c             	add    $0xc,%esp
    10b7:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
    10bb:	6a 01                	push   $0x1
    10bd:	50                   	push   %eax
    10be:	6a 01                	push   $0x1
    10c0:	e8 5d fd ff ff       	call   e22 <write>
    10c5:	83 c4 10             	add    $0x10,%esp
    10c8:	90                   	nop
    10c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10d0:	89 f8                	mov    %edi,%eax
    10d2:	83 ec 04             	sub    $0x4,%esp
    10d5:	c1 e7 04             	shl    $0x4,%edi
    10d8:	c1 e8 1c             	shr    $0x1c,%eax
    10db:	6a 01                	push   $0x1
    10dd:	0f b6 80 3c 14 00 00 	movzbl 0x143c(%eax),%eax
    10e4:	88 45 e5             	mov    %al,-0x1b(%ebp)
    10e7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    10ea:	50                   	push   %eax
    10eb:	6a 01                	push   $0x1
    10ed:	e8 30 fd ff ff       	call   e22 <write>
    10f2:	83 c4 10             	add    $0x10,%esp
    10f5:	83 ee 01             	sub    $0x1,%esi
    10f8:	75 d6                	jne    10d0 <vprintf.constprop.0+0x190>
    10fa:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    10fd:	31 ff                	xor    %edi,%edi
    10ff:	e9 7b fe ff ff       	jmp    f7f <vprintf.constprop.0+0x3f>
    1104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1108:	8b 3e                	mov    (%esi),%edi
    110a:	8d 46 04             	lea    0x4(%esi),%eax
    110d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1110:	85 ff                	test   %edi,%edi
    1112:	74 50                	je     1164 <vprintf.constprop.0+0x224>
    1114:	0f b6 07             	movzbl (%edi),%eax
    1117:	84 c0                	test   %al,%al
    1119:	74 df                	je     10fa <vprintf.constprop.0+0x1ba>
    111b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
    111e:	66 90                	xchg   %ax,%ax
    1120:	83 ec 04             	sub    $0x4,%esp
    1123:	83 c7 01             	add    $0x1,%edi
    1126:	88 45 e3             	mov    %al,-0x1d(%ebp)
    1129:	6a 01                	push   $0x1
    112b:	56                   	push   %esi
    112c:	6a 01                	push   $0x1
    112e:	e8 ef fc ff ff       	call   e22 <write>
    1133:	0f b6 07             	movzbl (%edi),%eax
    1136:	83 c4 10             	add    $0x10,%esp
    1139:	84 c0                	test   %al,%al
    113b:	75 e3                	jne    1120 <vprintf.constprop.0+0x1e0>
    113d:	eb bb                	jmp    10fa <vprintf.constprop.0+0x1ba>
    113f:	90                   	nop
    1140:	8b 06                	mov    (%esi),%eax
    1142:	83 ec 04             	sub    $0x4,%esp
    1145:	8d 7e 04             	lea    0x4(%esi),%edi
    1148:	6a 01                	push   $0x1
    114a:	89 fe                	mov    %edi,%esi
    114c:	31 ff                	xor    %edi,%edi
    114e:	88 45 e2             	mov    %al,-0x1e(%ebp)
    1151:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1154:	50                   	push   %eax
    1155:	6a 01                	push   $0x1
    1157:	e8 c6 fc ff ff       	call   e22 <write>
    115c:	83 c4 10             	add    $0x10,%esp
    115f:	e9 1b fe ff ff       	jmp    f7f <vprintf.constprop.0+0x3f>
    1164:	bf 34 14 00 00       	mov    $0x1434,%edi
    1169:	b8 28 00 00 00       	mov    $0x28,%eax
    116e:	eb ab                	jmp    111b <vprintf.constprop.0+0x1db>

00001170 <fprintf>:
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	83 ec 08             	sub    $0x8,%esp
    1176:	8b 45 0c             	mov    0xc(%ebp),%eax
    1179:	8d 55 10             	lea    0x10(%ebp),%edx
    117c:	e8 bf fd ff ff       	call   f40 <vprintf.constprop.0>
    1181:	c9                   	leave  
    1182:	c3                   	ret    
    1183:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001190 <printf>:
    1190:	55                   	push   %ebp
    1191:	89 e5                	mov    %esp,%ebp
    1193:	83 ec 08             	sub    $0x8,%esp
    1196:	8b 45 08             	mov    0x8(%ebp),%eax
    1199:	8d 55 0c             	lea    0xc(%ebp),%edx
    119c:	e8 9f fd ff ff       	call   f40 <vprintf.constprop.0>
    11a1:	c9                   	leave  
    11a2:	c3                   	ret    
    11a3:	66 90                	xchg   %ax,%ax
    11a5:	66 90                	xchg   %ax,%ax
    11a7:	66 90                	xchg   %ax,%ax
    11a9:	66 90                	xchg   %ax,%ax
    11ab:	66 90                	xchg   %ax,%ax
    11ad:	66 90                	xchg   %ax,%ax
    11af:	90                   	nop

000011b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    11b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11b1:	a1 04 1c 00 00       	mov    0x1c04,%eax
{
    11b6:	89 e5                	mov    %esp,%ebp
    11b8:	57                   	push   %edi
    11b9:	56                   	push   %esi
    11ba:	53                   	push   %ebx
    11bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    11be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    11c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11c8:	39 c8                	cmp    %ecx,%eax
    11ca:	8b 10                	mov    (%eax),%edx
    11cc:	73 32                	jae    1200 <free+0x50>
    11ce:	39 d1                	cmp    %edx,%ecx
    11d0:	72 04                	jb     11d6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11d2:	39 d0                	cmp    %edx,%eax
    11d4:	72 32                	jb     1208 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    11d6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    11d9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    11dc:	39 fa                	cmp    %edi,%edx
    11de:	74 30                	je     1210 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    11e0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    11e3:	8b 50 04             	mov    0x4(%eax),%edx
    11e6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    11e9:	39 f1                	cmp    %esi,%ecx
    11eb:	74 3a                	je     1227 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    11ed:	89 08                	mov    %ecx,(%eax)
  freep = p;
    11ef:	a3 04 1c 00 00       	mov    %eax,0x1c04
}
    11f4:	5b                   	pop    %ebx
    11f5:	5e                   	pop    %esi
    11f6:	5f                   	pop    %edi
    11f7:	5d                   	pop    %ebp
    11f8:	c3                   	ret    
    11f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1200:	39 d0                	cmp    %edx,%eax
    1202:	72 04                	jb     1208 <free+0x58>
    1204:	39 d1                	cmp    %edx,%ecx
    1206:	72 ce                	jb     11d6 <free+0x26>
{
    1208:	89 d0                	mov    %edx,%eax
    120a:	eb bc                	jmp    11c8 <free+0x18>
    120c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1210:	03 72 04             	add    0x4(%edx),%esi
    1213:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1216:	8b 10                	mov    (%eax),%edx
    1218:	8b 12                	mov    (%edx),%edx
    121a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    121d:	8b 50 04             	mov    0x4(%eax),%edx
    1220:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1223:	39 f1                	cmp    %esi,%ecx
    1225:	75 c6                	jne    11ed <free+0x3d>
    p->s.size += bp->s.size;
    1227:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    122a:	a3 04 1c 00 00       	mov    %eax,0x1c04
    p->s.size += bp->s.size;
    122f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1232:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1235:	89 10                	mov    %edx,(%eax)
}
    1237:	5b                   	pop    %ebx
    1238:	5e                   	pop    %esi
    1239:	5f                   	pop    %edi
    123a:	5d                   	pop    %ebp
    123b:	c3                   	ret    
    123c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001240 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1240:	55                   	push   %ebp
    1241:	89 e5                	mov    %esp,%ebp
    1243:	57                   	push   %edi
    1244:	56                   	push   %esi
    1245:	53                   	push   %ebx
    1246:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1249:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    124c:	8b 15 04 1c 00 00    	mov    0x1c04,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1252:	8d 78 07             	lea    0x7(%eax),%edi
    1255:	c1 ef 03             	shr    $0x3,%edi
    1258:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    125b:	85 d2                	test   %edx,%edx
    125d:	0f 84 9d 00 00 00    	je     1300 <malloc+0xc0>
    1263:	8b 02                	mov    (%edx),%eax
    1265:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1268:	39 cf                	cmp    %ecx,%edi
    126a:	76 6c                	jbe    12d8 <malloc+0x98>
    126c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1272:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1277:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    127a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1281:	eb 0e                	jmp    1291 <malloc+0x51>
    1283:	90                   	nop
    1284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1288:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    128a:	8b 48 04             	mov    0x4(%eax),%ecx
    128d:	39 f9                	cmp    %edi,%ecx
    128f:	73 47                	jae    12d8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1291:	39 05 04 1c 00 00    	cmp    %eax,0x1c04
    1297:	89 c2                	mov    %eax,%edx
    1299:	75 ed                	jne    1288 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    129b:	83 ec 0c             	sub    $0xc,%esp
    129e:	56                   	push   %esi
    129f:	e8 e6 fb ff ff       	call   e8a <sbrk>
  if(p == (char*)-1)
    12a4:	83 c4 10             	add    $0x10,%esp
    12a7:	83 f8 ff             	cmp    $0xffffffff,%eax
    12aa:	74 1c                	je     12c8 <malloc+0x88>
  hp->s.size = nu;
    12ac:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    12af:	83 ec 0c             	sub    $0xc,%esp
    12b2:	83 c0 08             	add    $0x8,%eax
    12b5:	50                   	push   %eax
    12b6:	e8 f5 fe ff ff       	call   11b0 <free>
  return freep;
    12bb:	8b 15 04 1c 00 00    	mov    0x1c04,%edx
      if((p = morecore(nunits)) == 0)
    12c1:	83 c4 10             	add    $0x10,%esp
    12c4:	85 d2                	test   %edx,%edx
    12c6:	75 c0                	jne    1288 <malloc+0x48>
        return 0;
  }
}
    12c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    12cb:	31 c0                	xor    %eax,%eax
}
    12cd:	5b                   	pop    %ebx
    12ce:	5e                   	pop    %esi
    12cf:	5f                   	pop    %edi
    12d0:	5d                   	pop    %ebp
    12d1:	c3                   	ret    
    12d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    12d8:	39 cf                	cmp    %ecx,%edi
    12da:	74 54                	je     1330 <malloc+0xf0>
        p->s.size -= nunits;
    12dc:	29 f9                	sub    %edi,%ecx
    12de:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    12e1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    12e4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    12e7:	89 15 04 1c 00 00    	mov    %edx,0x1c04
}
    12ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    12f0:	83 c0 08             	add    $0x8,%eax
}
    12f3:	5b                   	pop    %ebx
    12f4:	5e                   	pop    %esi
    12f5:	5f                   	pop    %edi
    12f6:	5d                   	pop    %ebp
    12f7:	c3                   	ret    
    12f8:	90                   	nop
    12f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1300:	c7 05 04 1c 00 00 08 	movl   $0x1c08,0x1c04
    1307:	1c 00 00 
    130a:	c7 05 08 1c 00 00 08 	movl   $0x1c08,0x1c08
    1311:	1c 00 00 
    base.s.size = 0;
    1314:	b8 08 1c 00 00       	mov    $0x1c08,%eax
    1319:	c7 05 0c 1c 00 00 00 	movl   $0x0,0x1c0c
    1320:	00 00 00 
    1323:	e9 44 ff ff ff       	jmp    126c <malloc+0x2c>
    1328:	90                   	nop
    1329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1330:	8b 08                	mov    (%eax),%ecx
    1332:	89 0a                	mov    %ecx,(%edx)
    1334:	eb b1                	jmp    12e7 <malloc+0xa7>
