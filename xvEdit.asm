
user/_xvEdit:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
void substr(char* dest, char* str, int start, int end);
void toUpper(char* str);
void toLower(char* str);
void unline(char* str);

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
      1f:	0f 8e 80 02 00 00    	jle    2a5 <main+0x2a5>
    fprintf(2, "specify a file you want to edit");
    exit();
  } else if (argc > 2) {
      25:	83 f8 02             	cmp    $0x2,%eax
      28:	0f 85 64 02 00 00    	jne    292 <main+0x292>
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
      63:	e8 b8 03 00 00       	call   420 <MakeLinkedList>
  fprintf(2, "Welcome to xvEdit!\n");
      68:	51                   	push   %ecx
      69:	51                   	push   %ecx
      6a:	68 87 11 00 00       	push   $0x1187
      6f:	6a 02                	push   $0x2
  file.lines = MakeLinkedList();
      71:	89 85 00 ff ff ff    	mov    %eax,-0x100(%ebp)
  fprintf(2, "Welcome to xvEdit!\n");
      77:	e8 f4 0e 00 00       	call   f70 <fprintf>
  // opening
  file.fd = open(file.filename, O_RDONLY);
      7c:	5b                   	pop    %ebx
      7d:	5e                   	pop    %esi
      7e:	6a 00                	push   $0x0
      80:	57                   	push   %edi
      81:	e8 bc 0b 00 00       	call   c42 <open>
  if (file.fd == -1) {
      86:	83 c4 10             	add    $0x10,%esp
  file.fd = open(file.filename, O_RDONLY);
      89:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
  if (file.fd == -1) {
      8f:	83 c0 01             	add    $0x1,%eax
      92:	0f 84 20 02 00 00    	je     2b8 <main+0x2b8>
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
      ce:	e8 7d 06 00 00       	call   750 <gatherLines>
      d3:	83 c4 10             	add    $0x10,%esp
  }
  close(file.fd);
      d6:	83 ec 0c             	sub    $0xc,%esp
      d9:	ff b5 04 ff ff ff    	pushl  -0xfc(%ebp)
      df:	8d 9d 20 ff ff ff    	lea    -0xe0(%ebp),%ebx
      e5:	e8 40 0b 00 00       	call   c2a <close>
      ea:	83 c4 10             	add    $0x10,%esp
      ed:	8d 76 00             	lea    0x0(%esi),%esi

  while (cmd != QUIT) {
    fprintf(2, "xvEdit> ");
      f0:	83 ec 08             	sub    $0x8,%esp
      f3:	68 ae 11 00 00       	push   $0x11ae
      f8:	6a 02                	push   $0x2
      fa:	e8 71 0e 00 00       	call   f70 <fprintf>
    memset(buf, 0, nbuf);
      ff:	83 c4 0c             	add    $0xc,%esp
     102:	6a 64                	push   $0x64
     104:	6a 00                	push   $0x0
     106:	68 20 19 00 00       	push   $0x1920
     10b:	e8 50 09 00 00       	call   a60 <memset>
    gets(buf, nbuf);
     110:	59                   	pop    %ecx
     111:	5e                   	pop    %esi
     112:	6a 64                	push   $0x64
     114:	68 20 19 00 00       	push   $0x1920
     119:	e8 a2 09 00 00       	call   ac0 <gets>
    
    unline(buf);
     11e:	c7 04 24 20 19 00 00 	movl   $0x1920,(%esp)
     125:	e8 16 08 00 00       	call   940 <unline>
    substr(cmdstr, buf, 0, 4);
     12a:	6a 04                	push   $0x4
     12c:	6a 00                	push   $0x0
     12e:	68 20 19 00 00       	push   $0x1920
     133:	53                   	push   %ebx
     134:	e8 b7 06 00 00       	call   7f0 <substr>
  dest[s] = '\0';
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
    fprintf(2, "cmdstr: %s\n", cmdstr);
     167:	83 ec 04             	sub    $0x4,%esp
     16a:	53                   	push   %ebx
     16b:	68 b7 11 00 00       	push   $0x11b7
     170:	6a 02                	push   $0x2
     172:	e8 f9 0d 00 00       	call   f70 <fprintf>
    fprintf(2, "strlen(cmdstr): %d\n", strlen(cmdstr));
     177:	89 1c 24             	mov    %ebx,(%esp)
     17a:	e8 b1 08 00 00       	call   a30 <strlen>
     17f:	83 c4 0c             	add    $0xc,%esp
     182:	50                   	push   %eax
     183:	68 c3 11 00 00       	push   $0x11c3
     188:	6a 02                	push   $0x2
     18a:	e8 e1 0d 00 00       	call   f70 <fprintf>
    substr(args, buf, strlen(cmdstr) + 1, strlen(buf));
     18f:	c7 04 24 20 19 00 00 	movl   $0x1920,(%esp)
     196:	e8 95 08 00 00       	call   a30 <strlen>
     19b:	89 1c 24             	mov    %ebx,(%esp)
     19e:	89 c6                	mov    %eax,%esi
     1a0:	e8 8b 08 00 00       	call   a30 <strlen>
     1a5:	83 c0 01             	add    $0x1,%eax
     1a8:	56                   	push   %esi
     1a9:	50                   	push   %eax
     1aa:	8d 45 84             	lea    -0x7c(%ebp),%eax
     1ad:	68 20 19 00 00       	push   $0x1920
     1b2:	50                   	push   %eax
     1b3:	e8 38 06 00 00       	call   7f0 <substr>
    fprintf(2, "args: %s\n", args);
     1b8:	8d 45 84             	lea    -0x7c(%ebp),%eax
     1bb:	83 c4 1c             	add    $0x1c,%esp
     1be:	50                   	push   %eax
     1bf:	68 67 11 00 00       	push   $0x1167
     1c4:	6a 02                	push   $0x2
     1c6:	e8 a5 0d 00 00       	call   f70 <fprintf>
    if      (strcmp(cmdstr, "@END") == 0) {cmd = END;}
     1cb:	58                   	pop    %eax
     1cc:	5a                   	pop    %edx
     1cd:	68 d7 11 00 00       	push   $0x11d7
     1d2:	53                   	push   %ebx
     1d3:	e8 08 08 00 00       	call   9e0 <strcmp>
     1d8:	83 c4 10             	add    $0x10,%esp
     1db:	85 c0                	test   %eax,%eax
     1dd:	0f 84 0d ff ff ff    	je     f0 <main+0xf0>
    else if (strcmp(cmdstr, "ADD<") == 0) {cmd = ADD;}
     1e3:	50                   	push   %eax
     1e4:	50                   	push   %eax
     1e5:	68 dc 11 00 00       	push   $0x11dc
     1ea:	53                   	push   %ebx
     1eb:	e8 f0 07 00 00       	call   9e0 <strcmp>
     1f0:	83 c4 10             	add    $0x10,%esp
     1f3:	85 c0                	test   %eax,%eax
     1f5:	0f 84 f5 fe ff ff    	je     f0 <main+0xf0>
    else if (strcmp(cmdstr, "DROP") == 0) {cmd = DROP;}
     1fb:	50                   	push   %eax
     1fc:	50                   	push   %eax
     1fd:	68 e1 11 00 00       	push   $0x11e1
     202:	53                   	push   %ebx
     203:	e8 d8 07 00 00       	call   9e0 <strcmp>
     208:	83 c4 10             	add    $0x10,%esp
     20b:	85 c0                	test   %eax,%eax
     20d:	0f 84 dd fe ff ff    	je     f0 <main+0xf0>
    else if (strcmp(cmdstr, "EDIT") == 0) {cmd = EDIT;}
     213:	50                   	push   %eax
     214:	50                   	push   %eax
     215:	68 e6 11 00 00       	push   $0x11e6
     21a:	53                   	push   %ebx
     21b:	e8 c0 07 00 00       	call   9e0 <strcmp>
     220:	83 c4 10             	add    $0x10,%esp
     223:	85 c0                	test   %eax,%eax
     225:	0f 84 c5 fe ff ff    	je     f0 <main+0xf0>
    else if (strcmp(cmdstr, "LIST") == 0) {cmd = LIST;}
     22b:	50                   	push   %eax
     22c:	50                   	push   %eax
     22d:	68 eb 11 00 00       	push   $0x11eb
     232:	53                   	push   %ebx
     233:	e8 a8 07 00 00       	call   9e0 <strcmp>
     238:	83 c4 10             	add    $0x10,%esp
     23b:	85 c0                	test   %eax,%eax
     23d:	0f 84 ac 00 00 00    	je     2ef <main+0x2ef>
    else if (strcmp(cmdstr, "SHOW") == 0) {cmd = SHOW;}
     243:	57                   	push   %edi
     244:	57                   	push   %edi
     245:	68 f0 11 00 00       	push   $0x11f0
     24a:	53                   	push   %ebx
     24b:	e8 90 07 00 00       	call   9e0 <strcmp>
     250:	83 c4 10             	add    $0x10,%esp
     253:	85 c0                	test   %eax,%eax
     255:	0f 84 f1 00 00 00    	je     34c <main+0x34c>
    else if (strcmp(cmdstr, "QUIT") == 0) {cmd = QUIT;}
     25b:	56                   	push   %esi
     25c:	56                   	push   %esi
     25d:	68 f5 11 00 00       	push   $0x11f5
     262:	53                   	push   %ebx
     263:	e8 78 07 00 00       	call   9e0 <strcmp>
     268:	83 c4 10             	add    $0x10,%esp
     26b:	85 c0                	test   %eax,%eax
     26d:	0f 85 c3 00 00 00    	jne    336 <main+0x336>
  close(file.fd);
     273:	83 ec 0c             	sub    $0xc,%esp
     276:	ff b5 04 ff ff ff    	pushl  -0xfc(%ebp)
     27c:	e8 a9 09 00 00       	call   c2a <close>
  destroyLinkedList(file.lines);
     281:	59                   	pop    %ecx
     282:	ff b5 00 ff ff ff    	pushl  -0x100(%ebp)
     288:	e8 23 03 00 00       	call   5b0 <destroyLinkedList>
  exit();
     28d:	e8 70 09 00 00       	call   c02 <exit>
    fprintf(2, "only specify one file");
     292:	57                   	push   %edi
     293:	57                   	push   %edi
     294:	68 71 11 00 00       	push   $0x1171
     299:	6a 02                	push   $0x2
     29b:	e8 d0 0c 00 00       	call   f70 <fprintf>
    exit();
     2a0:	e8 5d 09 00 00       	call   c02 <exit>
    fprintf(2, "specify a file you want to edit");
     2a5:	50                   	push   %eax
     2a6:	50                   	push   %eax
     2a7:	68 20 12 00 00       	push   $0x1220
     2ac:	6a 02                	push   $0x2
     2ae:	e8 bd 0c 00 00       	call   f70 <fprintf>
    exit();
     2b3:	e8 4a 09 00 00       	call   c02 <exit>
    fprintf(2, "creating %s . . .\n",  file.filename);
     2b8:	57                   	push   %edi
     2b9:	8b bd fc fe ff ff    	mov    -0x104(%ebp),%edi
     2bf:	57                   	push   %edi
     2c0:	68 9b 11 00 00       	push   $0x119b
     2c5:	6a 02                	push   $0x2
     2c7:	e8 a4 0c 00 00       	call   f70 <fprintf>
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     2cc:	58                   	pop    %eax
     2cd:	5a                   	pop    %edx
     2ce:	68 01 02 00 00       	push   $0x201
     2d3:	57                   	push   %edi
     2d4:	e8 69 09 00 00       	call   c42 <open>
    close(file.fd);
     2d9:	89 04 24             	mov    %eax,(%esp)
    file.fd = open(file.filename, O_CREATE | O_WRONLY);
     2dc:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
    close(file.fd);
     2e2:	e8 43 09 00 00       	call   c2a <close>
     2e7:	83 c4 10             	add    $0x10,%esp
     2ea:	e9 e7 fd ff ff       	jmp    d6 <main+0xd6>
      list(file, args);
     2ef:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
     2f5:	8d b5 14 ff ff ff    	lea    -0xec(%ebp),%esi
     2fb:	b9 03 00 00 00       	mov    $0x3,%ecx
     300:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
     306:	8b 85 04 ff ff ff    	mov    -0xfc(%ebp),%eax
     30c:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
     312:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
     318:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
     31e:	8d 45 84             	lea    -0x7c(%ebp),%eax
     321:	50                   	push   %eax
     322:	83 ec 0c             	sub    $0xc,%esp
     325:	89 e7                	mov    %esp,%edi
     327:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
     329:	e8 52 05 00 00       	call   880 <list>
     32e:	83 c4 10             	add    $0x10,%esp
     331:	e9 ba fd ff ff       	jmp    f0 <main+0xf0>
  fprintf(2, "bad bi input\n");
     336:	52                   	push   %edx
     337:	52                   	push   %edx
     338:	68 38 11 00 00       	push   $0x1138
     33d:	6a 02                	push   $0x2
     33f:	e8 2c 0c 00 00       	call   f70 <fprintf>
     344:	83 c4 10             	add    $0x10,%esp
     347:	e9 a4 fd ff ff       	jmp    f0 <main+0xf0>
  struct Node* curr = file.lines->head->next;
     34c:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
     352:	8b 00                	mov    (%eax),%eax
     354:	8b 70 08             	mov    0x8(%eax),%esi
  while (curr != file.lines->tail) {
     357:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
     35d:	3b 70 04             	cmp    0x4(%eax),%esi
     360:	0f 84 8a fd ff ff    	je     f0 <main+0xf0>
    fprintf(2, "%s\n", curr->data);
     366:	50                   	push   %eax
     367:	ff 76 04             	pushl  0x4(%esi)
     36a:	68 bf 11 00 00       	push   $0x11bf
     36f:	6a 02                	push   $0x2
     371:	e8 fa 0b 00 00       	call   f70 <fprintf>
    curr = curr->next;
     376:	8b 76 08             	mov    0x8(%esi),%esi
     379:	83 c4 10             	add    $0x10,%esp
     37c:	eb d9                	jmp    357 <main+0x357>
     37e:	66 90                	xchg   %ax,%ax

00000380 <mystrcpy>:
#include "LinkedList.h"
#define nullptr 0

void mystrcpy(char* dest, char* src) {
     380:	55                   	push   %ebp
     381:	89 e5                	mov    %esp,%ebp
     383:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     386:	8b 45 08             	mov    0x8(%ebp),%eax
  while(*src != '\0')
     389:	0f b6 11             	movzbl (%ecx),%edx
     38c:	84 d2                	test   %dl,%dl
     38e:	74 10                	je     3a0 <mystrcpy+0x20>
    *(dest++) = *(src++);
     390:	83 c1 01             	add    $0x1,%ecx
     393:	83 c0 01             	add    $0x1,%eax
     396:	88 50 ff             	mov    %dl,-0x1(%eax)
  while(*src != '\0')
     399:	0f b6 11             	movzbl (%ecx),%edx
     39c:	84 d2                	test   %dl,%dl
     39e:	75 f0                	jne    390 <mystrcpy+0x10>
  *dest = '\0';
     3a0:	c6 00 00             	movb   $0x0,(%eax)
}
     3a3:	5d                   	pop    %ebp
     3a4:	c3                   	ret    
     3a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003b0 <safestrcpy>:

char*
safestrcpy(char *s, const char *t, int n)
{
     3b0:	55                   	push   %ebp
     3b1:	89 e5                	mov    %esp,%ebp
     3b3:	56                   	push   %esi
     3b4:	53                   	push   %ebx
     3b5:	8b 4d 10             	mov    0x10(%ebp),%ecx
     3b8:	8b 45 08             	mov    0x8(%ebp),%eax
     3bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
     3be:	85 c9                	test   %ecx,%ecx
     3c0:	7e 26                	jle    3e8 <safestrcpy+0x38>
     3c2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
     3c6:	89 c1                	mov    %eax,%ecx
     3c8:	eb 17                	jmp    3e1 <safestrcpy+0x31>
     3ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
     3d0:	83 c2 01             	add    $0x1,%edx
     3d3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
     3d7:	83 c1 01             	add    $0x1,%ecx
     3da:	84 db                	test   %bl,%bl
     3dc:	88 59 ff             	mov    %bl,-0x1(%ecx)
     3df:	74 04                	je     3e5 <safestrcpy+0x35>
     3e1:	39 f2                	cmp    %esi,%edx
     3e3:	75 eb                	jne    3d0 <safestrcpy+0x20>
    ;
  *s = 0;
     3e5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
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
     3f8:	e8 43 0c 00 00       	call   1040 <malloc>
  node->prev = nullptr;
  // char* newData = (char*)malloc(sizeof(char) * 1000);
  // mystrcpy(newData, data);
  node->data = data;// newData;
     3fd:	8b 55 08             	mov    0x8(%ebp),%edx
  node->prev = nullptr;
     400:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  // strcpy(node->data, data);
  node->next = nullptr;
     406:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  node->data = data;// newData;
     40d:	89 50 04             	mov    %edx,0x4(%eax)
  return node;
}
     410:	c9                   	leave  
     411:	c3                   	ret    
     412:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000420 <MakeLinkedList>:

LinkedList* MakeLinkedList() {
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	56                   	push   %esi
     424:	53                   	push   %ebx
  struct LinkedList* list = malloc(sizeof(LinkedList));
     425:	83 ec 0c             	sub    $0xc,%esp
     428:	6a 0c                	push   $0xc
     42a:	e8 11 0c 00 00       	call   1040 <malloc>
  struct Node* node = malloc(sizeof(Node));
     42f:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  struct LinkedList* list = malloc(sizeof(LinkedList));
     436:	89 c6                	mov    %eax,%esi
  struct Node* node = malloc(sizeof(Node));
     438:	e8 03 0c 00 00       	call   1040 <malloc>
     43d:	89 c3                	mov    %eax,%ebx
  node->prev = nullptr;
     43f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->data = data;// newData;
     445:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  node->next = nullptr;
     44c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  struct Node* node = malloc(sizeof(Node));
     453:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     45a:	e8 e1 0b 00 00       	call   1040 <malloc>
  node->data = data;// newData;
     45f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  Node* head = nullNode(nullptr);
  Node* tail = nullNode(nullptr);
  head->prev = nullptr;
  head->next = tail;
     466:	89 43 08             	mov    %eax,0x8(%ebx)
  head->prev = nullptr;
     469:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  tail->prev = head;
     46f:	89 18                	mov    %ebx,(%eax)
  tail->next = nullptr;
     471:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)

  list->len = 0;
  list->head = head;
  list->tail = tail;
     478:	89 46 04             	mov    %eax,0x4(%esi)
  return list;
}
     47b:	89 f0                	mov    %esi,%eax
  list->len = 0;
     47d:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
  list->head = head;
     484:	89 1e                	mov    %ebx,(%esi)
}
     486:	8d 65 f8             	lea    -0x8(%ebp),%esp
     489:	5b                   	pop    %ebx
     48a:	5e                   	pop    %esi
     48b:	5d                   	pop    %ebp
     48c:	c3                   	ret    
     48d:	8d 76 00             	lea    0x0(%esi),%esi

00000490 <nodeAt>:

Node* nodeAt(struct LinkedList* list, int pos) {
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	53                   	push   %ebx
     494:	8b 5d 08             	mov    0x8(%ebp),%ebx
     497:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  struct Node* curNode;
  if (pos > (list->len / 2)) {
     49a:	8b 53 08             	mov    0x8(%ebx),%edx
     49d:	89 d0                	mov    %edx,%eax
     49f:	c1 e8 1f             	shr    $0x1f,%eax
     4a2:	01 d0                	add    %edx,%eax
     4a4:	d1 f8                	sar    %eax
     4a6:	39 c8                	cmp    %ecx,%eax
     4a8:	7d 1e                	jge    4c8 <nodeAt+0x38>
    int cur = list->len;
    curNode = list->tail;
    while (cur != pos) {
     4aa:	39 ca                	cmp    %ecx,%edx
    curNode = list->tail;
     4ac:	8b 43 04             	mov    0x4(%ebx),%eax
    while (cur != pos) {
     4af:	74 10                	je     4c1 <nodeAt+0x31>
     4b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      curNode = curNode->prev;
      cur--;
     4b8:	83 ea 01             	sub    $0x1,%edx
      curNode = curNode->prev;
     4bb:	8b 00                	mov    (%eax),%eax
    while (cur != pos) {
     4bd:	39 d1                	cmp    %edx,%ecx
     4bf:	75 f7                	jne    4b8 <nodeAt+0x28>
      curNode = curNode->next;
      cur++;
    }
  }
  return curNode;
}
     4c1:	5b                   	pop    %ebx
     4c2:	5d                   	pop    %ebp
     4c3:	c3                   	ret    
     4c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    curNode = list->head->next;
     4c8:	8b 03                	mov    (%ebx),%eax
    while (cur != pos) {
     4ca:	85 c9                	test   %ecx,%ecx
    curNode = list->head->next;
     4cc:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     4cf:	74 f0                	je     4c1 <nodeAt+0x31>
    int cur = 0;
     4d1:	31 d2                	xor    %edx,%edx
     4d3:	90                   	nop
     4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cur++;
     4d8:	83 c2 01             	add    $0x1,%edx
      curNode = curNode->next;
     4db:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     4de:	39 d1                	cmp    %edx,%ecx
     4e0:	75 f6                	jne    4d8 <nodeAt+0x48>
}
     4e2:	5b                   	pop    %ebx
     4e3:	5d                   	pop    %ebp
     4e4:	c3                   	ret    
     4e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     4e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004f0 <insert>:

void insert(struct LinkedList* list, char* data, int pos) {
     4f0:	55                   	push   %ebp
     4f1:	89 e5                	mov    %esp,%ebp
     4f3:	57                   	push   %edi
     4f4:	56                   	push   %esi
     4f5:	53                   	push   %ebx
     4f6:	83 ec 0c             	sub    $0xc,%esp
  struct Node* atPos = nodeAt(list, pos);
     4f9:	ff 75 10             	pushl  0x10(%ebp)
     4fc:	ff 75 08             	pushl  0x8(%ebp)
void insert(struct LinkedList* list, char* data, int pos) {
     4ff:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct Node* atPos = nodeAt(list, pos);
     502:	e8 89 ff ff ff       	call   490 <nodeAt>
     507:	83 ec 04             	sub    $0x4,%esp
     50a:	89 c6                	mov    %eax,%esi
  // if (atPos == list->head) printf("it's head\n");
  // if (atPos == list->tail) printf("it's tail\n");
  
  char* newData = (char*)malloc(sizeof(char) * 1000);
     50c:	68 e8 03 00 00       	push   $0x3e8
     511:	e8 2a 0b 00 00       	call   1040 <malloc>
     516:	8d 8b e7 03 00 00    	lea    0x3e7(%ebx),%ecx
     51c:	89 c7                	mov    %eax,%edi
     51e:	83 c4 10             	add    $0x10,%esp
     521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(--n > 0 && (*s++ = *t++) != 0)
     528:	83 c3 01             	add    $0x1,%ebx
     52b:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     52f:	83 c0 01             	add    $0x1,%eax
     532:	84 d2                	test   %dl,%dl
     534:	88 50 ff             	mov    %dl,-0x1(%eax)
     537:	74 04                	je     53d <insert+0x4d>
     539:	39 d9                	cmp    %ebx,%ecx
     53b:	75 eb                	jne    528 <insert+0x38>
  newData = safestrcpy(newData, data, (sizeof(char) * 1000));
  struct Node* new = malloc(sizeof(Node));
     53d:	83 ec 0c             	sub    $0xc,%esp
  *s = 0;
     540:	c6 00 00             	movb   $0x0,(%eax)
  struct Node* new = malloc(sizeof(Node));
     543:	6a 0c                	push   $0xc
     545:	e8 f6 0a 00 00       	call   1040 <malloc>
  new->data = newData;
     54a:	89 78 04             	mov    %edi,0x4(%eax)

  // struct Node* new = MakeNode(data);
  // printf("atPos: %s\n", atPos->data);
  // printf("new: %s\n", new->data);
  new->prev = atPos->prev;
     54d:	8b 16                	mov    (%esi),%edx
  new->next = atPos;
     54f:	89 70 08             	mov    %esi,0x8(%eax)
  new->prev = atPos->prev;
     552:	89 10                	mov    %edx,(%eax)
  new->prev->next = new;
     554:	89 42 08             	mov    %eax,0x8(%edx)
  atPos->prev = new;
     557:	89 06                	mov    %eax,(%esi)
  list->len++;
     559:	8b 45 08             	mov    0x8(%ebp),%eax
     55c:	83 40 08 01          	addl   $0x1,0x8(%eax)
  // printf("atPos: %s\n", atPos->data);
  // printf("new: %s\n", new->data);
  // printf("head->next: %s\n", list->head->next->data);
  // printf("tail->prev: %s\n\n\n", list->tail->prev->data);
}
     560:	8d 65 f4             	lea    -0xc(%ebp),%esp
     563:	5b                   	pop    %ebx
     564:	5e                   	pop    %esi
     565:	5f                   	pop    %edi
     566:	5d                   	pop    %ebp
     567:	c3                   	ret    
     568:	90                   	nop
     569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000570 <prepend>:

void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
     570:	55                   	push   %ebp
     571:	89 e5                	mov    %esp,%ebp
     573:	83 ec 0c             	sub    $0xc,%esp
     576:	6a 00                	push   $0x0
     578:	ff 75 0c             	pushl  0xc(%ebp)
     57b:	ff 75 08             	pushl  0x8(%ebp)
     57e:	e8 6d ff ff ff       	call   4f0 <insert>
     583:	83 c4 10             	add    $0x10,%esp
     586:	c9                   	leave  
     587:	c3                   	ret    
     588:	90                   	nop
     589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000590 <append>:
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     590:	55                   	push   %ebp
     591:	89 e5                	mov    %esp,%ebp
     593:	83 ec 0c             	sub    $0xc,%esp
     596:	8b 45 08             	mov    0x8(%ebp),%eax
     599:	ff 70 08             	pushl  0x8(%eax)
     59c:	ff 75 0c             	pushl  0xc(%ebp)
     59f:	50                   	push   %eax
     5a0:	e8 4b ff ff ff       	call   4f0 <insert>
     5a5:	83 c4 10             	add    $0x10,%esp
     5a8:	c9                   	leave  
     5a9:	c3                   	ret    
     5aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005b0 <destroyLinkedList>:

void destroyLinkedList(struct LinkedList* list) {
     5b0:	55                   	push   %ebp
     5b1:	89 e5                	mov    %esp,%ebp
     5b3:	57                   	push   %edi
     5b4:	56                   	push   %esi
     5b5:	53                   	push   %ebx
     5b6:	83 ec 0c             	sub    $0xc,%esp
     5b9:	8b 75 08             	mov    0x8(%ebp),%esi
  struct Node* destroyer = list->head;
     5bc:	8b 16                	mov    (%esi),%edx
  struct Node* traveler = destroyer->next;
  while (destroyer != list->tail) {
     5be:	8b 46 04             	mov    0x4(%esi),%eax
     5c1:	39 c2                	cmp    %eax,%edx
  struct Node* traveler = destroyer->next;
     5c3:	8b 5a 08             	mov    0x8(%edx),%ebx
  while (destroyer != list->tail) {
     5c6:	75 0a                	jne    5d2 <destroyLinkedList+0x22>
     5c8:	eb 1e                	jmp    5e8 <destroyLinkedList+0x38>
     5ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    destroyer = traveler;
    traveler = traveler->next;
     5d0:	89 fb                	mov    %edi,%ebx
    free(destroyer);
     5d2:	83 ec 0c             	sub    $0xc,%esp
    traveler = traveler->next;
     5d5:	8b 7b 08             	mov    0x8(%ebx),%edi
    free(destroyer);
     5d8:	53                   	push   %ebx
     5d9:	e8 d2 09 00 00       	call   fb0 <free>
  while (destroyer != list->tail) {
     5de:	83 c4 10             	add    $0x10,%esp
     5e1:	39 5e 04             	cmp    %ebx,0x4(%esi)
     5e4:	75 ea                	jne    5d0 <destroyLinkedList+0x20>
     5e6:	8b 06                	mov    (%esi),%eax
  }
  free(list->head);
     5e8:	83 ec 0c             	sub    $0xc,%esp
     5eb:	50                   	push   %eax
     5ec:	e8 bf 09 00 00       	call   fb0 <free>
  free(list->tail);
     5f1:	58                   	pop    %eax
     5f2:	ff 76 04             	pushl  0x4(%esi)
     5f5:	e8 b6 09 00 00       	call   fb0 <free>
  free(list);
     5fa:	89 75 08             	mov    %esi,0x8(%ebp)
     5fd:	83 c4 10             	add    $0x10,%esp
     600:	8d 65 f4             	lea    -0xc(%ebp),%esp
     603:	5b                   	pop    %ebx
     604:	5e                   	pop    %esi
     605:	5f                   	pop    %edi
     606:	5d                   	pop    %ebp
  free(list);
     607:	e9 a4 09 00 00       	jmp    fb0 <free>
     60c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000610 <end>:
void end(struct File file, char* args) {
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
}
     613:	5d                   	pop    %ebp
     614:	c3                   	ret    
     615:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000620 <add>:
     620:	55                   	push   %ebp
     621:	89 e5                	mov    %esp,%ebp
     623:	5d                   	pop    %ebp
     624:	c3                   	ret    
     625:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000630 <drop>:
     630:	55                   	push   %ebp
     631:	89 e5                	mov    %esp,%ebp
     633:	5d                   	pop    %ebp
     634:	c3                   	ret    
     635:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000640 <edit>:
     640:	55                   	push   %ebp
     641:	89 e5                	mov    %esp,%ebp
     643:	5d                   	pop    %ebp
     644:	c3                   	ret    
     645:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000650 <show>:
void show(struct File file, char* args) {
     650:	55                   	push   %ebp
     651:	89 e5                	mov    %esp,%ebp
     653:	56                   	push   %esi
     654:	53                   	push   %ebx
     655:	8b 75 10             	mov    0x10(%ebp),%esi
  struct Node* curr = file.lines->head->next;
     658:	8b 06                	mov    (%esi),%eax
     65a:	8b 58 08             	mov    0x8(%eax),%ebx
  while (curr != file.lines->tail) {
     65d:	3b 5e 04             	cmp    0x4(%esi),%ebx
     660:	74 23                	je     685 <show+0x35>
     662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "%s\n", curr->data);
     668:	83 ec 04             	sub    $0x4,%esp
     66b:	ff 73 04             	pushl  0x4(%ebx)
     66e:	68 bf 11 00 00       	push   $0x11bf
     673:	6a 02                	push   $0x2
     675:	e8 f6 08 00 00       	call   f70 <fprintf>
    curr = curr->next;
     67a:	8b 5b 08             	mov    0x8(%ebx),%ebx
  while (curr != file.lines->tail) {
     67d:	83 c4 10             	add    $0x10,%esp
     680:	39 5e 04             	cmp    %ebx,0x4(%esi)
     683:	75 e3                	jne    668 <show+0x18>
}
     685:	8d 65 f8             	lea    -0x8(%ebp),%esp
     688:	5b                   	pop    %ebx
     689:	5e                   	pop    %esi
     68a:	5d                   	pop    %ebp
     68b:	c3                   	ret    
     68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000690 <quit>:
     690:	55                   	push   %ebp
     691:	89 e5                	mov    %esp,%ebp
     693:	5d                   	pop    %ebp
     694:	c3                   	ret    
     695:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006a0 <bi>:
void bi() {
     6a0:	55                   	push   %ebp
     6a1:	89 e5                	mov    %esp,%ebp
     6a3:	83 ec 10             	sub    $0x10,%esp
  fprintf(2, "bad bi input\n");
     6a6:	68 38 11 00 00       	push   $0x1138
     6ab:	6a 02                	push   $0x2
     6ad:	e8 be 08 00 00       	call   f70 <fprintf>
}
     6b2:	83 c4 10             	add    $0x10,%esp
     6b5:	c9                   	leave  
     6b6:	c3                   	ret    
     6b7:	89 f6                	mov    %esi,%esi
     6b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006c0 <getLine>:
int getLine(int fileptr, char line[]) {
     6c0:	55                   	push   %ebp
     6c1:	89 e5                	mov    %esp,%ebp
     6c3:	57                   	push   %edi
     6c4:	56                   	push   %esi
     6c5:	53                   	push   %ebx
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     6c6:	31 ff                	xor    %edi,%edi
     6c8:	8d 75 e7             	lea    -0x19(%ebp),%esi
int getLine(int fileptr, char line[]) {
     6cb:	83 ec 28             	sub    $0x28,%esp
     6ce:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int len = strlen(line);
     6d1:	53                   	push   %ebx
     6d2:	e8 59 03 00 00       	call   a30 <strlen>
  memset(line, 0, len);
     6d7:	83 c4 0c             	add    $0xc,%esp
     6da:	50                   	push   %eax
     6db:	6a 00                	push   $0x0
     6dd:	53                   	push   %ebx
     6de:	e8 7d 03 00 00       	call   a60 <memset>
     6e3:	83 c4 10             	add    $0x10,%esp
     6e6:	eb 1e                	jmp    706 <getLine+0x46>
     6e8:	90                   	nop
     6e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (*c == '\n') break;
     6f0:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     6f4:	3c 0a                	cmp    $0xa,%al
     6f6:	74 38                	je     730 <getLine+0x70>
    line[i] = *c;
     6f8:	88 04 3b             	mov    %al,(%ebx,%edi,1)
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     6fb:	83 c7 01             	add    $0x1,%edi
     6fe:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
     704:	74 42                	je     748 <getLine+0x88>
    if (read(fileptr, c, 1) == 0) return strlen(line);
     706:	83 ec 04             	sub    $0x4,%esp
     709:	6a 01                	push   $0x1
     70b:	56                   	push   %esi
     70c:	ff 75 08             	pushl  0x8(%ebp)
     70f:	e8 06 05 00 00       	call   c1a <read>
     714:	83 c4 10             	add    $0x10,%esp
     717:	85 c0                	test   %eax,%eax
     719:	75 d5                	jne    6f0 <getLine+0x30>
     71b:	83 ec 0c             	sub    $0xc,%esp
     71e:	53                   	push   %ebx
     71f:	e8 0c 03 00 00       	call   a30 <strlen>
     724:	83 c4 10             	add    $0x10,%esp
}
     727:	8d 65 f4             	lea    -0xc(%ebp),%esp
     72a:	5b                   	pop    %ebx
     72b:	5e                   	pop    %esi
     72c:	5f                   	pop    %edi
     72d:	5d                   	pop    %ebp
     72e:	c3                   	ret    
     72f:	90                   	nop
     730:	8d 57 01             	lea    0x1(%edi),%edx
  line[i + 1] = '\0';
     733:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
     737:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
     73a:	b8 01 00 00 00       	mov    $0x1,%eax
}
     73f:	5b                   	pop    %ebx
     740:	5e                   	pop    %esi
     741:	5f                   	pop    %edi
     742:	5d                   	pop    %ebp
     743:	c3                   	ret    
     744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     748:	ba e8 03 00 00       	mov    $0x3e8,%edx
     74d:	eb e4                	jmp    733 <getLine+0x73>
     74f:	90                   	nop

00000750 <gatherLines>:
void gatherLines(File file) {
     750:	55                   	push   %ebp
     751:	89 e5                	mov    %esp,%ebp
     753:	57                   	push   %edi
     754:	56                   	push   %esi
     755:	53                   	push   %ebx
     756:	8d b5 00 fc ff ff    	lea    -0x400(%ebp),%esi
  int lines = 0;
     75c:	31 db                	xor    %ebx,%ebx
void gatherLines(File file) {
     75e:	81 ec fc 03 00 00    	sub    $0x3fc,%esp
     764:	8b 7d 0c             	mov    0xc(%ebp),%edi
  while (getLine(file.fd, line)) {
     767:	eb 1d                	jmp    786 <gatherLines+0x36>
     769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    append(file.lines, line);
     770:	8b 45 10             	mov    0x10(%ebp),%eax
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     773:	83 ec 04             	sub    $0x4,%esp
    lines++;
     776:	83 c3 01             	add    $0x1,%ebx
     779:	ff 70 08             	pushl  0x8(%eax)
     77c:	56                   	push   %esi
     77d:	50                   	push   %eax
     77e:	e8 6d fd ff ff       	call   4f0 <insert>
     783:	83 c4 10             	add    $0x10,%esp
  while (getLine(file.fd, line)) {
     786:	83 ec 08             	sub    $0x8,%esp
     789:	56                   	push   %esi
     78a:	57                   	push   %edi
     78b:	e8 30 ff ff ff       	call   6c0 <getLine>
     790:	83 c4 10             	add    $0x10,%esp
     793:	85 c0                	test   %eax,%eax
     795:	75 d9                	jne    770 <gatherLines+0x20>
  fprintf(2, "%d lines read from %s\n", lines, file.filename);
     797:	ff 75 08             	pushl  0x8(%ebp)
     79a:	53                   	push   %ebx
     79b:	68 46 11 00 00       	push   $0x1146
     7a0:	6a 02                	push   $0x2
     7a2:	e8 c9 07 00 00       	call   f70 <fprintf>
}
     7a7:	83 c4 10             	add    $0x10,%esp
     7aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7ad:	5b                   	pop    %ebx
     7ae:	5e                   	pop    %esi
     7af:	5f                   	pop    %edi
     7b0:	5d                   	pop    %ebp
     7b1:	c3                   	ret    
     7b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     7b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007c0 <find>:
int find(char* str, char c) {
     7c0:	55                   	push   %ebp
     7c1:	89 e5                	mov    %esp,%ebp
     7c3:	53                   	push   %ebx
     7c4:	83 ec 0c             	sub    $0xc,%esp
  char* pos = strchr(str, c);
     7c7:	0f be 45 0c          	movsbl 0xc(%ebp),%eax
int find(char* str, char c) {
     7cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char* pos = strchr(str, c);
     7ce:	50                   	push   %eax
     7cf:	53                   	push   %ebx
     7d0:	e8 ab 02 00 00       	call   a80 <strchr>
  if (*pos == 0) return -1;
     7d5:	83 c4 10             	add    $0x10,%esp
     7d8:	80 38 00             	cmpb   $0x0,(%eax)
     7db:	74 0b                	je     7e8 <find+0x28>
  return pos - str;
     7dd:	29 d8                	sub    %ebx,%eax
}
     7df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7e2:	c9                   	leave  
     7e3:	c3                   	ret    
     7e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (*pos == 0) return -1;
     7e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     7ed:	eb f0                	jmp    7df <find+0x1f>
     7ef:	90                   	nop

000007f0 <substr>:
void substr(char* dest, char* str, int start, int end) {
     7f0:	55                   	push   %ebp
     7f1:	89 e5                	mov    %esp,%ebp
     7f3:	57                   	push   %edi
     7f4:	56                   	push   %esi
     7f5:	53                   	push   %ebx
     7f6:	83 ec 18             	sub    $0x18,%esp
     7f9:	8b 75 0c             	mov    0xc(%ebp),%esi
     7fc:	8b 7d 14             	mov    0x14(%ebp),%edi
     7ff:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str);
     802:	56                   	push   %esi
     803:	e8 28 02 00 00       	call   a30 <strlen>
     808:	83 c4 10             	add    $0x10,%esp
     80b:	39 f8                	cmp    %edi,%eax
     80d:	0f 4e f8             	cmovle %eax,%edi
  for (int i = start; i < end; i++)
     810:	3b 7d 10             	cmp    0x10(%ebp),%edi
     813:	7e 1e                	jle    833 <substr+0x43>
     815:	8b 55 10             	mov    0x10(%ebp),%edx
    dest[s++] = str[i];
     818:	89 d8                	mov    %ebx,%eax
     81a:	29 d0                	sub    %edx,%eax
     81c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     820:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     824:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  for (int i = start; i < end; i++)
     827:	83 c2 01             	add    $0x1,%edx
     82a:	39 d7                	cmp    %edx,%edi
     82c:	75 f2                	jne    820 <substr+0x30>
     82e:	2b 7d 10             	sub    0x10(%ebp),%edi
     831:	01 fb                	add    %edi,%ebx
  dest[s] = '\0';
     833:	c6 03 00             	movb   $0x0,(%ebx)
}
     836:	8d 65 f4             	lea    -0xc(%ebp),%esp
     839:	5b                   	pop    %ebx
     83a:	5e                   	pop    %esi
     83b:	5f                   	pop    %edi
     83c:	5d                   	pop    %ebp
     83d:	c3                   	ret    
     83e:	66 90                	xchg   %ax,%ax

00000840 <getArg>:
void getArg(char* dest, char* args, char delimiter) {
     840:	55                   	push   %ebp
     841:	89 e5                	mov    %esp,%ebp
     843:	53                   	push   %ebx
     844:	83 ec 0c             	sub    $0xc,%esp
  int end = find(args, delimiter);
     847:	0f be 45 10          	movsbl 0x10(%ebp),%eax
void getArg(char* dest, char* args, char delimiter) {
     84b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char* pos = strchr(str, c);
     84e:	50                   	push   %eax
     84f:	53                   	push   %ebx
     850:	e8 2b 02 00 00       	call   a80 <strchr>
  return pos - str;
     855:	89 c2                	mov    %eax,%edx
  if (*pos == 0) return -1;
     857:	83 c4 10             	add    $0x10,%esp
  return pos - str;
     85a:	29 da                	sub    %ebx,%edx
     85c:	80 38 00             	cmpb   $0x0,(%eax)
     85f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     864:	0f 45 c2             	cmovne %edx,%eax
  substr(dest, args, 0, end);
     867:	50                   	push   %eax
     868:	6a 00                	push   $0x0
     86a:	53                   	push   %ebx
     86b:	ff 75 08             	pushl  0x8(%ebp)
     86e:	e8 7d ff ff ff       	call   7f0 <substr>
}
     873:	83 c4 10             	add    $0x10,%esp
     876:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     879:	c9                   	leave  
     87a:	c3                   	ret    
     87b:	90                   	nop
     87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000880 <list>:
void list(struct File file, char* args) {
     880:	55                   	push   %ebp
     881:	89 e5                	mov    %esp,%ebp
     883:	53                   	push   %ebx
     884:	83 ec 10             	sub    $0x10,%esp
     887:	8b 5d 14             	mov    0x14(%ebp),%ebx
  if (strlen(args) < 1) {
     88a:	53                   	push   %ebx
     88b:	e8 a0 01 00 00       	call   a30 <strlen>
     890:	83 c4 10             	add    $0x10,%esp
     893:	85 c0                	test   %eax,%eax
     895:	75 12                	jne    8a9 <list+0x29>
    fprintf(2, "you need to give a range to list");
     897:	83 ec 08             	sub    $0x8,%esp
     89a:	68 fc 11 00 00       	push   $0x11fc
     89f:	6a 02                	push   $0x2
     8a1:	e8 ca 06 00 00       	call   f70 <fprintf>
     8a6:	83 c4 10             	add    $0x10,%esp
  getArg(start, args, ' ');
     8a9:	83 ec 04             	sub    $0x4,%esp
     8ac:	6a 20                	push   $0x20
     8ae:	53                   	push   %ebx
     8af:	68 9a 11 00 00       	push   $0x119a
     8b4:	e8 87 ff ff ff       	call   840 <getArg>
  fprintf(2, "start: %s\nargs: %s\n", start, args);
     8b9:	89 5d 14             	mov    %ebx,0x14(%ebp)
     8bc:	83 c4 10             	add    $0x10,%esp
     8bf:	c7 45 10 9a 11 00 00 	movl   $0x119a,0x10(%ebp)
     8c6:	c7 45 0c 5d 11 00 00 	movl   $0x115d,0xc(%ebp)
     8cd:	c7 45 08 02 00 00 00 	movl   $0x2,0x8(%ebp)
}
     8d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8d7:	c9                   	leave  
  fprintf(2, "start: %s\nargs: %s\n", start, args);
     8d8:	e9 93 06 00 00       	jmp    f70 <fprintf>
     8dd:	8d 76 00             	lea    0x0(%esi),%esi

000008e0 <toUpper>:
void toUpper(char* str) {
     8e0:	55                   	push   %ebp
     8e1:	89 e5                	mov    %esp,%ebp
     8e3:	8b 55 08             	mov    0x8(%ebp),%edx
  while (str[i] != '\0') {
     8e6:	0f b6 02             	movzbl (%edx),%eax
     8e9:	84 c0                	test   %al,%al
     8eb:	74 1a                	je     907 <toUpper+0x27>
     8ed:	8d 76 00             	lea    0x0(%esi),%esi
    if (c <= 'z' && c >= 'a')
     8f0:	8d 48 9f             	lea    -0x61(%eax),%ecx
     8f3:	80 f9 19             	cmp    $0x19,%cl
     8f6:	77 05                	ja     8fd <toUpper+0x1d>
      str[i] += ('Z' - 'z');
     8f8:	83 e8 20             	sub    $0x20,%eax
     8fb:	88 02                	mov    %al,(%edx)
     8fd:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     900:	0f b6 02             	movzbl (%edx),%eax
     903:	84 c0                	test   %al,%al
     905:	75 e9                	jne    8f0 <toUpper+0x10>
    i++;  
  }
}
     907:	5d                   	pop    %ebp
     908:	c3                   	ret    
     909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000910 <toLower>:

void toLower(char* str) {
     910:	55                   	push   %ebp
     911:	89 e5                	mov    %esp,%ebp
     913:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     916:	0f b6 02             	movzbl (%edx),%eax
     919:	84 c0                	test   %al,%al
     91b:	74 1a                	je     937 <toLower+0x27>
     91d:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'Z' && c >= 'A')
     920:	8d 48 bf             	lea    -0x41(%eax),%ecx
     923:	80 f9 19             	cmp    $0x19,%cl
     926:	77 05                	ja     92d <toLower+0x1d>
      str[i] -= ('Z' - 'z');
     928:	83 c0 20             	add    $0x20,%eax
     92b:	88 02                	mov    %al,(%edx)
     92d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     930:	0f b6 02             	movzbl (%edx),%eax
     933:	84 c0                	test   %al,%al
     935:	75 e9                	jne    920 <toLower+0x10>
    i++;  
  }
}
     937:	5d                   	pop    %ebp
     938:	c3                   	ret    
     939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000940 <unline>:

void unline(char* str) {
     940:	55                   	push   %ebp
     941:	89 e5                	mov    %esp,%ebp
     943:	53                   	push   %ebx
     944:	83 ec 10             	sub    $0x10,%esp
     947:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str) - 1;
     94a:	53                   	push   %ebx
     94b:	e8 e0 00 00 00       	call   a30 <strlen>
     950:	8d 50 ff             	lea    -0x1(%eax),%edx
  for (; len > 0; len--) {
     953:	83 c4 10             	add    $0x10,%esp
     956:	85 d2                	test   %edx,%edx
     958:	7e 36                	jle    990 <unline+0x50>
    char c = str[len];
    if (c == '\n')
     95a:	80 7c 03 ff 0a       	cmpb   $0xa,-0x1(%ebx,%eax,1)
     95f:	74 2f                	je     990 <unline+0x50>
     961:	8d 44 03 fe          	lea    -0x2(%ebx,%eax,1),%eax
     965:	eb 12                	jmp    979 <unline+0x39>
     967:	89 f6                	mov    %esi,%esi
     969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     970:	83 e8 01             	sub    $0x1,%eax
     973:	80 78 01 0a          	cmpb   $0xa,0x1(%eax)
     977:	74 06                	je     97f <unline+0x3f>
  for (; len > 0; len--) {
     979:	39 c3                	cmp    %eax,%ebx
     97b:	89 c2                	mov    %eax,%edx
     97d:	75 f1                	jne    970 <unline+0x30>
      break;
  }
  str[len] = '\0';
     97f:	c6 02 00             	movb   $0x0,(%edx)
}
     982:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     985:	c9                   	leave  
     986:	c3                   	ret    
     987:	89 f6                	mov    %esi,%esi
     989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     990:	01 da                	add    %ebx,%edx
  str[len] = '\0';
     992:	c6 02 00             	movb   $0x0,(%edx)
}
     995:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     998:	c9                   	leave  
     999:	c3                   	ret    
     99a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000009a0 <lineAt>:

// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
     9a0:	55                   	push   %ebp
     9a1:	89 e5                	mov    %esp,%ebp
  return nodeAt(list, pos);
}
     9a3:	5d                   	pop    %ebp
  return nodeAt(list, pos);
     9a4:	e9 e7 fa ff ff       	jmp    490 <nodeAt>
     9a9:	66 90                	xchg   %ax,%ax
     9ab:	66 90                	xchg   %ax,%ax
     9ad:	66 90                	xchg   %ax,%ax
     9af:	90                   	nop

000009b0 <strcpy>:
     9b0:	55                   	push   %ebp
     9b1:	89 e5                	mov    %esp,%ebp
     9b3:	53                   	push   %ebx
     9b4:	8b 45 08             	mov    0x8(%ebp),%eax
     9b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     9ba:	89 c2                	mov    %eax,%edx
     9bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     9c0:	83 c1 01             	add    $0x1,%ecx
     9c3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     9c7:	83 c2 01             	add    $0x1,%edx
     9ca:	84 db                	test   %bl,%bl
     9cc:	88 5a ff             	mov    %bl,-0x1(%edx)
     9cf:	75 ef                	jne    9c0 <strcpy+0x10>
     9d1:	5b                   	pop    %ebx
     9d2:	5d                   	pop    %ebp
     9d3:	c3                   	ret    
     9d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     9da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000009e0 <strcmp>:
     9e0:	55                   	push   %ebp
     9e1:	89 e5                	mov    %esp,%ebp
     9e3:	53                   	push   %ebx
     9e4:	8b 55 08             	mov    0x8(%ebp),%edx
     9e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     9ea:	0f b6 02             	movzbl (%edx),%eax
     9ed:	0f b6 19             	movzbl (%ecx),%ebx
     9f0:	84 c0                	test   %al,%al
     9f2:	75 1c                	jne    a10 <strcmp+0x30>
     9f4:	eb 2a                	jmp    a20 <strcmp+0x40>
     9f6:	8d 76 00             	lea    0x0(%esi),%esi
     9f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     a00:	83 c2 01             	add    $0x1,%edx
     a03:	0f b6 02             	movzbl (%edx),%eax
     a06:	83 c1 01             	add    $0x1,%ecx
     a09:	0f b6 19             	movzbl (%ecx),%ebx
     a0c:	84 c0                	test   %al,%al
     a0e:	74 10                	je     a20 <strcmp+0x40>
     a10:	38 d8                	cmp    %bl,%al
     a12:	74 ec                	je     a00 <strcmp+0x20>
     a14:	29 d8                	sub    %ebx,%eax
     a16:	5b                   	pop    %ebx
     a17:	5d                   	pop    %ebp
     a18:	c3                   	ret    
     a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a20:	31 c0                	xor    %eax,%eax
     a22:	29 d8                	sub    %ebx,%eax
     a24:	5b                   	pop    %ebx
     a25:	5d                   	pop    %ebp
     a26:	c3                   	ret    
     a27:	89 f6                	mov    %esi,%esi
     a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a30 <strlen>:
     a30:	55                   	push   %ebp
     a31:	89 e5                	mov    %esp,%ebp
     a33:	8b 4d 08             	mov    0x8(%ebp),%ecx
     a36:	80 39 00             	cmpb   $0x0,(%ecx)
     a39:	74 15                	je     a50 <strlen+0x20>
     a3b:	31 d2                	xor    %edx,%edx
     a3d:	8d 76 00             	lea    0x0(%esi),%esi
     a40:	83 c2 01             	add    $0x1,%edx
     a43:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     a47:	89 d0                	mov    %edx,%eax
     a49:	75 f5                	jne    a40 <strlen+0x10>
     a4b:	5d                   	pop    %ebp
     a4c:	c3                   	ret    
     a4d:	8d 76 00             	lea    0x0(%esi),%esi
     a50:	31 c0                	xor    %eax,%eax
     a52:	5d                   	pop    %ebp
     a53:	c3                   	ret    
     a54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     a5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000a60 <memset>:
     a60:	55                   	push   %ebp
     a61:	89 e5                	mov    %esp,%ebp
     a63:	57                   	push   %edi
     a64:	8b 55 08             	mov    0x8(%ebp),%edx
     a67:	8b 4d 10             	mov    0x10(%ebp),%ecx
     a6a:	8b 45 0c             	mov    0xc(%ebp),%eax
     a6d:	89 d7                	mov    %edx,%edi
     a6f:	fc                   	cld    
     a70:	f3 aa                	rep stos %al,%es:(%edi)
     a72:	89 d0                	mov    %edx,%eax
     a74:	5f                   	pop    %edi
     a75:	5d                   	pop    %ebp
     a76:	c3                   	ret    
     a77:	89 f6                	mov    %esi,%esi
     a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a80 <strchr>:
     a80:	55                   	push   %ebp
     a81:	89 e5                	mov    %esp,%ebp
     a83:	53                   	push   %ebx
     a84:	8b 45 08             	mov    0x8(%ebp),%eax
     a87:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     a8a:	0f b6 10             	movzbl (%eax),%edx
     a8d:	84 d2                	test   %dl,%dl
     a8f:	74 1d                	je     aae <strchr+0x2e>
     a91:	38 d3                	cmp    %dl,%bl
     a93:	89 d9                	mov    %ebx,%ecx
     a95:	75 0d                	jne    aa4 <strchr+0x24>
     a97:	eb 17                	jmp    ab0 <strchr+0x30>
     a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     aa0:	38 ca                	cmp    %cl,%dl
     aa2:	74 0c                	je     ab0 <strchr+0x30>
     aa4:	83 c0 01             	add    $0x1,%eax
     aa7:	0f b6 10             	movzbl (%eax),%edx
     aaa:	84 d2                	test   %dl,%dl
     aac:	75 f2                	jne    aa0 <strchr+0x20>
     aae:	31 c0                	xor    %eax,%eax
     ab0:	5b                   	pop    %ebx
     ab1:	5d                   	pop    %ebp
     ab2:	c3                   	ret    
     ab3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ac0 <gets>:
     ac0:	55                   	push   %ebp
     ac1:	89 e5                	mov    %esp,%ebp
     ac3:	57                   	push   %edi
     ac4:	56                   	push   %esi
     ac5:	53                   	push   %ebx
     ac6:	31 f6                	xor    %esi,%esi
     ac8:	89 f3                	mov    %esi,%ebx
     aca:	83 ec 1c             	sub    $0x1c,%esp
     acd:	8b 7d 08             	mov    0x8(%ebp),%edi
     ad0:	eb 2f                	jmp    b01 <gets+0x41>
     ad2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     ad8:	8d 45 e7             	lea    -0x19(%ebp),%eax
     adb:	83 ec 04             	sub    $0x4,%esp
     ade:	6a 01                	push   $0x1
     ae0:	50                   	push   %eax
     ae1:	6a 00                	push   $0x0
     ae3:	e8 32 01 00 00       	call   c1a <read>
     ae8:	83 c4 10             	add    $0x10,%esp
     aeb:	85 c0                	test   %eax,%eax
     aed:	7e 1c                	jle    b0b <gets+0x4b>
     aef:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     af3:	83 c7 01             	add    $0x1,%edi
     af6:	88 47 ff             	mov    %al,-0x1(%edi)
     af9:	3c 0a                	cmp    $0xa,%al
     afb:	74 23                	je     b20 <gets+0x60>
     afd:	3c 0d                	cmp    $0xd,%al
     aff:	74 1f                	je     b20 <gets+0x60>
     b01:	83 c3 01             	add    $0x1,%ebx
     b04:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     b07:	89 fe                	mov    %edi,%esi
     b09:	7c cd                	jl     ad8 <gets+0x18>
     b0b:	89 f3                	mov    %esi,%ebx
     b0d:	8b 45 08             	mov    0x8(%ebp),%eax
     b10:	c6 03 00             	movb   $0x0,(%ebx)
     b13:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b16:	5b                   	pop    %ebx
     b17:	5e                   	pop    %esi
     b18:	5f                   	pop    %edi
     b19:	5d                   	pop    %ebp
     b1a:	c3                   	ret    
     b1b:	90                   	nop
     b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     b20:	8b 75 08             	mov    0x8(%ebp),%esi
     b23:	8b 45 08             	mov    0x8(%ebp),%eax
     b26:	01 de                	add    %ebx,%esi
     b28:	89 f3                	mov    %esi,%ebx
     b2a:	c6 03 00             	movb   $0x0,(%ebx)
     b2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b30:	5b                   	pop    %ebx
     b31:	5e                   	pop    %esi
     b32:	5f                   	pop    %edi
     b33:	5d                   	pop    %ebp
     b34:	c3                   	ret    
     b35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b40 <stat>:
     b40:	55                   	push   %ebp
     b41:	89 e5                	mov    %esp,%ebp
     b43:	56                   	push   %esi
     b44:	53                   	push   %ebx
     b45:	83 ec 08             	sub    $0x8,%esp
     b48:	6a 00                	push   $0x0
     b4a:	ff 75 08             	pushl  0x8(%ebp)
     b4d:	e8 f0 00 00 00       	call   c42 <open>
     b52:	83 c4 10             	add    $0x10,%esp
     b55:	85 c0                	test   %eax,%eax
     b57:	78 27                	js     b80 <stat+0x40>
     b59:	83 ec 08             	sub    $0x8,%esp
     b5c:	ff 75 0c             	pushl  0xc(%ebp)
     b5f:	89 c3                	mov    %eax,%ebx
     b61:	50                   	push   %eax
     b62:	e8 f3 00 00 00       	call   c5a <fstat>
     b67:	89 1c 24             	mov    %ebx,(%esp)
     b6a:	89 c6                	mov    %eax,%esi
     b6c:	e8 b9 00 00 00       	call   c2a <close>
     b71:	83 c4 10             	add    $0x10,%esp
     b74:	8d 65 f8             	lea    -0x8(%ebp),%esp
     b77:	89 f0                	mov    %esi,%eax
     b79:	5b                   	pop    %ebx
     b7a:	5e                   	pop    %esi
     b7b:	5d                   	pop    %ebp
     b7c:	c3                   	ret    
     b7d:	8d 76 00             	lea    0x0(%esi),%esi
     b80:	be ff ff ff ff       	mov    $0xffffffff,%esi
     b85:	eb ed                	jmp    b74 <stat+0x34>
     b87:	89 f6                	mov    %esi,%esi
     b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b90 <atoi>:
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	53                   	push   %ebx
     b94:	8b 4d 08             	mov    0x8(%ebp),%ecx
     b97:	0f be 11             	movsbl (%ecx),%edx
     b9a:	8d 42 d0             	lea    -0x30(%edx),%eax
     b9d:	3c 09                	cmp    $0x9,%al
     b9f:	b8 00 00 00 00       	mov    $0x0,%eax
     ba4:	77 1f                	ja     bc5 <atoi+0x35>
     ba6:	8d 76 00             	lea    0x0(%esi),%esi
     ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     bb0:	8d 04 80             	lea    (%eax,%eax,4),%eax
     bb3:	83 c1 01             	add    $0x1,%ecx
     bb6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
     bba:	0f be 11             	movsbl (%ecx),%edx
     bbd:	8d 5a d0             	lea    -0x30(%edx),%ebx
     bc0:	80 fb 09             	cmp    $0x9,%bl
     bc3:	76 eb                	jbe    bb0 <atoi+0x20>
     bc5:	5b                   	pop    %ebx
     bc6:	5d                   	pop    %ebp
     bc7:	c3                   	ret    
     bc8:	90                   	nop
     bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000bd0 <memmove>:
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
     bd3:	56                   	push   %esi
     bd4:	53                   	push   %ebx
     bd5:	8b 5d 10             	mov    0x10(%ebp),%ebx
     bd8:	8b 45 08             	mov    0x8(%ebp),%eax
     bdb:	8b 75 0c             	mov    0xc(%ebp),%esi
     bde:	85 db                	test   %ebx,%ebx
     be0:	7e 14                	jle    bf6 <memmove+0x26>
     be2:	31 d2                	xor    %edx,%edx
     be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     be8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     bec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     bef:	83 c2 01             	add    $0x1,%edx
     bf2:	39 d3                	cmp    %edx,%ebx
     bf4:	75 f2                	jne    be8 <memmove+0x18>
     bf6:	5b                   	pop    %ebx
     bf7:	5e                   	pop    %esi
     bf8:	5d                   	pop    %ebp
     bf9:	c3                   	ret    

00000bfa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     bfa:	b8 01 00 00 00       	mov    $0x1,%eax
     bff:	cd 40                	int    $0x40
     c01:	c3                   	ret    

00000c02 <exit>:
SYSCALL(exit)
     c02:	b8 02 00 00 00       	mov    $0x2,%eax
     c07:	cd 40                	int    $0x40
     c09:	c3                   	ret    

00000c0a <wait>:
SYSCALL(wait)
     c0a:	b8 03 00 00 00       	mov    $0x3,%eax
     c0f:	cd 40                	int    $0x40
     c11:	c3                   	ret    

00000c12 <pipe>:
SYSCALL(pipe)
     c12:	b8 04 00 00 00       	mov    $0x4,%eax
     c17:	cd 40                	int    $0x40
     c19:	c3                   	ret    

00000c1a <read>:
SYSCALL(read)
     c1a:	b8 05 00 00 00       	mov    $0x5,%eax
     c1f:	cd 40                	int    $0x40
     c21:	c3                   	ret    

00000c22 <write>:
SYSCALL(write)
     c22:	b8 10 00 00 00       	mov    $0x10,%eax
     c27:	cd 40                	int    $0x40
     c29:	c3                   	ret    

00000c2a <close>:
SYSCALL(close)
     c2a:	b8 15 00 00 00       	mov    $0x15,%eax
     c2f:	cd 40                	int    $0x40
     c31:	c3                   	ret    

00000c32 <kill>:
SYSCALL(kill)
     c32:	b8 06 00 00 00       	mov    $0x6,%eax
     c37:	cd 40                	int    $0x40
     c39:	c3                   	ret    

00000c3a <exec>:
SYSCALL(exec)
     c3a:	b8 07 00 00 00       	mov    $0x7,%eax
     c3f:	cd 40                	int    $0x40
     c41:	c3                   	ret    

00000c42 <open>:
SYSCALL(open)
     c42:	b8 0f 00 00 00       	mov    $0xf,%eax
     c47:	cd 40                	int    $0x40
     c49:	c3                   	ret    

00000c4a <mknod>:
SYSCALL(mknod)
     c4a:	b8 11 00 00 00       	mov    $0x11,%eax
     c4f:	cd 40                	int    $0x40
     c51:	c3                   	ret    

00000c52 <unlink>:
SYSCALL(unlink)
     c52:	b8 12 00 00 00       	mov    $0x12,%eax
     c57:	cd 40                	int    $0x40
     c59:	c3                   	ret    

00000c5a <fstat>:
SYSCALL(fstat)
     c5a:	b8 08 00 00 00       	mov    $0x8,%eax
     c5f:	cd 40                	int    $0x40
     c61:	c3                   	ret    

00000c62 <link>:
SYSCALL(link)
     c62:	b8 13 00 00 00       	mov    $0x13,%eax
     c67:	cd 40                	int    $0x40
     c69:	c3                   	ret    

00000c6a <mkdir>:
SYSCALL(mkdir)
     c6a:	b8 14 00 00 00       	mov    $0x14,%eax
     c6f:	cd 40                	int    $0x40
     c71:	c3                   	ret    

00000c72 <chdir>:
SYSCALL(chdir)
     c72:	b8 09 00 00 00       	mov    $0x9,%eax
     c77:	cd 40                	int    $0x40
     c79:	c3                   	ret    

00000c7a <dup>:
SYSCALL(dup)
     c7a:	b8 0a 00 00 00       	mov    $0xa,%eax
     c7f:	cd 40                	int    $0x40
     c81:	c3                   	ret    

00000c82 <getpid>:
SYSCALL(getpid)
     c82:	b8 0b 00 00 00       	mov    $0xb,%eax
     c87:	cd 40                	int    $0x40
     c89:	c3                   	ret    

00000c8a <sbrk>:
SYSCALL(sbrk)
     c8a:	b8 0c 00 00 00       	mov    $0xc,%eax
     c8f:	cd 40                	int    $0x40
     c91:	c3                   	ret    

00000c92 <sleep>:
SYSCALL(sleep)
     c92:	b8 0d 00 00 00       	mov    $0xd,%eax
     c97:	cd 40                	int    $0x40
     c99:	c3                   	ret    

00000c9a <uptime>:
SYSCALL(uptime)
     c9a:	b8 0e 00 00 00       	mov    $0xe,%eax
     c9f:	cd 40                	int    $0x40
     ca1:	c3                   	ret    

00000ca2 <cpuhalt>:
SYSCALL(cpuhalt)
     ca2:	b8 16 00 00 00       	mov    $0x16,%eax
     ca7:	cd 40                	int    $0x40
     ca9:	c3                   	ret    
     caa:	66 90                	xchg   %ax,%ax
     cac:	66 90                	xchg   %ax,%ax
     cae:	66 90                	xchg   %ax,%ax

00000cb0 <printint.constprop.1>:
     cb0:	55                   	push   %ebp
     cb1:	89 e5                	mov    %esp,%ebp
     cb3:	57                   	push   %edi
     cb4:	56                   	push   %esi
     cb5:	53                   	push   %ebx
     cb6:	89 d6                	mov    %edx,%esi
     cb8:	83 ec 3c             	sub    $0x3c,%esp
     cbb:	85 c0                	test   %eax,%eax
     cbd:	79 71                	jns    d30 <printint.constprop.1+0x80>
     cbf:	83 e1 01             	and    $0x1,%ecx
     cc2:	74 6c                	je     d30 <printint.constprop.1+0x80>
     cc4:	f7 d8                	neg    %eax
     cc6:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
     ccd:	31 c9                	xor    %ecx,%ecx
     ccf:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     cd2:	eb 06                	jmp    cda <printint.constprop.1+0x2a>
     cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     cd8:	89 f9                	mov    %edi,%ecx
     cda:	31 d2                	xor    %edx,%edx
     cdc:	8d 79 01             	lea    0x1(%ecx),%edi
     cdf:	f7 f6                	div    %esi
     ce1:	0f b6 92 48 12 00 00 	movzbl 0x1248(%edx),%edx
     ce8:	85 c0                	test   %eax,%eax
     cea:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
     ced:	75 e9                	jne    cd8 <printint.constprop.1+0x28>
     cef:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     cf2:	85 c0                	test   %eax,%eax
     cf4:	74 08                	je     cfe <printint.constprop.1+0x4e>
     cf6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     cfb:	8d 79 02             	lea    0x2(%ecx),%edi
     cfe:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
     d02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     d08:	0f b6 06             	movzbl (%esi),%eax
     d0b:	83 ec 04             	sub    $0x4,%esp
     d0e:	83 ee 01             	sub    $0x1,%esi
     d11:	6a 01                	push   $0x1
     d13:	53                   	push   %ebx
     d14:	6a 01                	push   $0x1
     d16:	88 45 d7             	mov    %al,-0x29(%ebp)
     d19:	e8 04 ff ff ff       	call   c22 <write>
     d1e:	83 c4 10             	add    $0x10,%esp
     d21:	39 de                	cmp    %ebx,%esi
     d23:	75 e3                	jne    d08 <printint.constprop.1+0x58>
     d25:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d28:	5b                   	pop    %ebx
     d29:	5e                   	pop    %esi
     d2a:	5f                   	pop    %edi
     d2b:	5d                   	pop    %ebp
     d2c:	c3                   	ret    
     d2d:	8d 76 00             	lea    0x0(%esi),%esi
     d30:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     d37:	eb 94                	jmp    ccd <printint.constprop.1+0x1d>
     d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d40 <vprintf.constprop.0>:
     d40:	55                   	push   %ebp
     d41:	89 e5                	mov    %esp,%ebp
     d43:	57                   	push   %edi
     d44:	56                   	push   %esi
     d45:	53                   	push   %ebx
     d46:	89 d6                	mov    %edx,%esi
     d48:	83 ec 2c             	sub    $0x2c,%esp
     d4b:	0f b6 10             	movzbl (%eax),%edx
     d4e:	84 d2                	test   %dl,%dl
     d50:	0f 84 cd 00 00 00    	je     e23 <vprintf.constprop.0+0xe3>
     d56:	8d 58 01             	lea    0x1(%eax),%ebx
     d59:	31 ff                	xor    %edi,%edi
     d5b:	eb 31                	jmp    d8e <vprintf.constprop.0+0x4e>
     d5d:	8d 76 00             	lea    0x0(%esi),%esi
     d60:	83 f8 25             	cmp    $0x25,%eax
     d63:	0f 84 c7 00 00 00    	je     e30 <vprintf.constprop.0+0xf0>
     d69:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     d6c:	83 ec 04             	sub    $0x4,%esp
     d6f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
     d72:	6a 01                	push   $0x1
     d74:	50                   	push   %eax
     d75:	6a 01                	push   $0x1
     d77:	e8 a6 fe ff ff       	call   c22 <write>
     d7c:	83 c4 10             	add    $0x10,%esp
     d7f:	83 c3 01             	add    $0x1,%ebx
     d82:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     d86:	84 d2                	test   %dl,%dl
     d88:	0f 84 95 00 00 00    	je     e23 <vprintf.constprop.0+0xe3>
     d8e:	85 ff                	test   %edi,%edi
     d90:	0f b6 c2             	movzbl %dl,%eax
     d93:	74 cb                	je     d60 <vprintf.constprop.0+0x20>
     d95:	83 ff 25             	cmp    $0x25,%edi
     d98:	75 e5                	jne    d7f <vprintf.constprop.0+0x3f>
     d9a:	83 f8 64             	cmp    $0x64,%eax
     d9d:	8d 7e 04             	lea    0x4(%esi),%edi
     da0:	b9 01 00 00 00       	mov    $0x1,%ecx
     da5:	0f 84 9a 00 00 00    	je     e45 <vprintf.constprop.0+0x105>
     dab:	83 f8 6c             	cmp    $0x6c,%eax
     dae:	0f 84 8c 00 00 00    	je     e40 <vprintf.constprop.0+0x100>
     db4:	83 f8 78             	cmp    $0x78,%eax
     db7:	0f 84 a3 00 00 00    	je     e60 <vprintf.constprop.0+0x120>
     dbd:	83 f8 70             	cmp    $0x70,%eax
     dc0:	0f 84 ca 00 00 00    	je     e90 <vprintf.constprop.0+0x150>
     dc6:	83 f8 73             	cmp    $0x73,%eax
     dc9:	0f 84 39 01 00 00    	je     f08 <vprintf.constprop.0+0x1c8>
     dcf:	83 f8 63             	cmp    $0x63,%eax
     dd2:	0f 84 68 01 00 00    	je     f40 <vprintf.constprop.0+0x200>
     dd8:	83 f8 25             	cmp    $0x25,%eax
     ddb:	0f 84 9f 00 00 00    	je     e80 <vprintf.constprop.0+0x140>
     de1:	8d 45 df             	lea    -0x21(%ebp),%eax
     de4:	83 ec 04             	sub    $0x4,%esp
     de7:	88 55 d4             	mov    %dl,-0x2c(%ebp)
     dea:	6a 01                	push   $0x1
     dec:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
     df0:	50                   	push   %eax
     df1:	6a 01                	push   $0x1
     df3:	e8 2a fe ff ff       	call   c22 <write>
     df8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
     dfc:	83 c4 0c             	add    $0xc,%esp
     dff:	8d 45 e0             	lea    -0x20(%ebp),%eax
     e02:	6a 01                	push   $0x1
     e04:	88 55 e0             	mov    %dl,-0x20(%ebp)
     e07:	50                   	push   %eax
     e08:	6a 01                	push   $0x1
     e0a:	83 c3 01             	add    $0x1,%ebx
     e0d:	31 ff                	xor    %edi,%edi
     e0f:	e8 0e fe ff ff       	call   c22 <write>
     e14:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     e18:	83 c4 10             	add    $0x10,%esp
     e1b:	84 d2                	test   %dl,%dl
     e1d:	0f 85 6b ff ff ff    	jne    d8e <vprintf.constprop.0+0x4e>
     e23:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e26:	5b                   	pop    %ebx
     e27:	5e                   	pop    %esi
     e28:	5f                   	pop    %edi
     e29:	5d                   	pop    %ebp
     e2a:	c3                   	ret    
     e2b:	90                   	nop
     e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e30:	bf 25 00 00 00       	mov    $0x25,%edi
     e35:	e9 45 ff ff ff       	jmp    d7f <vprintf.constprop.0+0x3f>
     e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e40:	8d 7e 04             	lea    0x4(%esi),%edi
     e43:	31 c9                	xor    %ecx,%ecx
     e45:	8b 06                	mov    (%esi),%eax
     e47:	ba 0a 00 00 00       	mov    $0xa,%edx
     e4c:	89 fe                	mov    %edi,%esi
     e4e:	31 ff                	xor    %edi,%edi
     e50:	e8 5b fe ff ff       	call   cb0 <printint.constprop.1>
     e55:	e9 25 ff ff ff       	jmp    d7f <vprintf.constprop.0+0x3f>
     e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e60:	8b 06                	mov    (%esi),%eax
     e62:	8d 7e 04             	lea    0x4(%esi),%edi
     e65:	31 c9                	xor    %ecx,%ecx
     e67:	ba 10 00 00 00       	mov    $0x10,%edx
     e6c:	89 fe                	mov    %edi,%esi
     e6e:	31 ff                	xor    %edi,%edi
     e70:	e8 3b fe ff ff       	call   cb0 <printint.constprop.1>
     e75:	e9 05 ff ff ff       	jmp    d7f <vprintf.constprop.0+0x3f>
     e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e80:	83 ec 04             	sub    $0x4,%esp
     e83:	88 55 e1             	mov    %dl,-0x1f(%ebp)
     e86:	8d 45 e1             	lea    -0x1f(%ebp),%eax
     e89:	6a 01                	push   $0x1
     e8b:	e9 77 ff ff ff       	jmp    e07 <vprintf.constprop.0+0xc7>
     e90:	8d 46 04             	lea    0x4(%esi),%eax
     e93:	83 ec 04             	sub    $0x4,%esp
     e96:	8b 3e                	mov    (%esi),%edi
     e98:	6a 01                	push   $0x1
     e9a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
     e9e:	be 08 00 00 00       	mov    $0x8,%esi
     ea3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     ea6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     ea9:	50                   	push   %eax
     eaa:	6a 01                	push   $0x1
     eac:	e8 71 fd ff ff       	call   c22 <write>
     eb1:	8d 45 e7             	lea    -0x19(%ebp),%eax
     eb4:	83 c4 0c             	add    $0xc,%esp
     eb7:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
     ebb:	6a 01                	push   $0x1
     ebd:	50                   	push   %eax
     ebe:	6a 01                	push   $0x1
     ec0:	e8 5d fd ff ff       	call   c22 <write>
     ec5:	83 c4 10             	add    $0x10,%esp
     ec8:	90                   	nop
     ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ed0:	89 f8                	mov    %edi,%eax
     ed2:	83 ec 04             	sub    $0x4,%esp
     ed5:	c1 e7 04             	shl    $0x4,%edi
     ed8:	c1 e8 1c             	shr    $0x1c,%eax
     edb:	6a 01                	push   $0x1
     edd:	0f b6 80 48 12 00 00 	movzbl 0x1248(%eax),%eax
     ee4:	88 45 e5             	mov    %al,-0x1b(%ebp)
     ee7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
     eea:	50                   	push   %eax
     eeb:	6a 01                	push   $0x1
     eed:	e8 30 fd ff ff       	call   c22 <write>
     ef2:	83 c4 10             	add    $0x10,%esp
     ef5:	83 ee 01             	sub    $0x1,%esi
     ef8:	75 d6                	jne    ed0 <vprintf.constprop.0+0x190>
     efa:	8b 75 d4             	mov    -0x2c(%ebp),%esi
     efd:	31 ff                	xor    %edi,%edi
     eff:	e9 7b fe ff ff       	jmp    d7f <vprintf.constprop.0+0x3f>
     f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f08:	8b 3e                	mov    (%esi),%edi
     f0a:	8d 46 04             	lea    0x4(%esi),%eax
     f0d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     f10:	85 ff                	test   %edi,%edi
     f12:	74 50                	je     f64 <vprintf.constprop.0+0x224>
     f14:	0f b6 07             	movzbl (%edi),%eax
     f17:	84 c0                	test   %al,%al
     f19:	74 df                	je     efa <vprintf.constprop.0+0x1ba>
     f1b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
     f1e:	66 90                	xchg   %ax,%ax
     f20:	83 ec 04             	sub    $0x4,%esp
     f23:	83 c7 01             	add    $0x1,%edi
     f26:	88 45 e3             	mov    %al,-0x1d(%ebp)
     f29:	6a 01                	push   $0x1
     f2b:	56                   	push   %esi
     f2c:	6a 01                	push   $0x1
     f2e:	e8 ef fc ff ff       	call   c22 <write>
     f33:	0f b6 07             	movzbl (%edi),%eax
     f36:	83 c4 10             	add    $0x10,%esp
     f39:	84 c0                	test   %al,%al
     f3b:	75 e3                	jne    f20 <vprintf.constprop.0+0x1e0>
     f3d:	eb bb                	jmp    efa <vprintf.constprop.0+0x1ba>
     f3f:	90                   	nop
     f40:	8b 06                	mov    (%esi),%eax
     f42:	83 ec 04             	sub    $0x4,%esp
     f45:	8d 7e 04             	lea    0x4(%esi),%edi
     f48:	6a 01                	push   $0x1
     f4a:	89 fe                	mov    %edi,%esi
     f4c:	31 ff                	xor    %edi,%edi
     f4e:	88 45 e2             	mov    %al,-0x1e(%ebp)
     f51:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     f54:	50                   	push   %eax
     f55:	6a 01                	push   $0x1
     f57:	e8 c6 fc ff ff       	call   c22 <write>
     f5c:	83 c4 10             	add    $0x10,%esp
     f5f:	e9 1b fe ff ff       	jmp    d7f <vprintf.constprop.0+0x3f>
     f64:	bf 40 12 00 00       	mov    $0x1240,%edi
     f69:	b8 28 00 00 00       	mov    $0x28,%eax
     f6e:	eb ab                	jmp    f1b <vprintf.constprop.0+0x1db>

00000f70 <fprintf>:
     f70:	55                   	push   %ebp
     f71:	89 e5                	mov    %esp,%ebp
     f73:	83 ec 08             	sub    $0x8,%esp
     f76:	8b 45 0c             	mov    0xc(%ebp),%eax
     f79:	8d 55 10             	lea    0x10(%ebp),%edx
     f7c:	e8 bf fd ff ff       	call   d40 <vprintf.constprop.0>
     f81:	c9                   	leave  
     f82:	c3                   	ret    
     f83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000f90 <printf>:
     f90:	55                   	push   %ebp
     f91:	89 e5                	mov    %esp,%ebp
     f93:	83 ec 08             	sub    $0x8,%esp
     f96:	8b 45 08             	mov    0x8(%ebp),%eax
     f99:	8d 55 0c             	lea    0xc(%ebp),%edx
     f9c:	e8 9f fd ff ff       	call   d40 <vprintf.constprop.0>
     fa1:	c9                   	leave  
     fa2:	c3                   	ret    
     fa3:	66 90                	xchg   %ax,%ax
     fa5:	66 90                	xchg   %ax,%ax
     fa7:	66 90                	xchg   %ax,%ax
     fa9:	66 90                	xchg   %ax,%ax
     fab:	66 90                	xchg   %ax,%ax
     fad:	66 90                	xchg   %ax,%ax
     faf:	90                   	nop

00000fb0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     fb0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fb1:	a1 84 19 00 00       	mov    0x1984,%eax
{
     fb6:	89 e5                	mov    %esp,%ebp
     fb8:	57                   	push   %edi
     fb9:	56                   	push   %esi
     fba:	53                   	push   %ebx
     fbb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
     fbe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
     fc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fc8:	39 c8                	cmp    %ecx,%eax
     fca:	8b 10                	mov    (%eax),%edx
     fcc:	73 32                	jae    1000 <free+0x50>
     fce:	39 d1                	cmp    %edx,%ecx
     fd0:	72 04                	jb     fd6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fd2:	39 d0                	cmp    %edx,%eax
     fd4:	72 32                	jb     1008 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
     fd6:	8b 73 fc             	mov    -0x4(%ebx),%esi
     fd9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
     fdc:	39 fa                	cmp    %edi,%edx
     fde:	74 30                	je     1010 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
     fe0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
     fe3:	8b 50 04             	mov    0x4(%eax),%edx
     fe6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
     fe9:	39 f1                	cmp    %esi,%ecx
     feb:	74 3a                	je     1027 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
     fed:	89 08                	mov    %ecx,(%eax)
  freep = p;
     fef:	a3 84 19 00 00       	mov    %eax,0x1984
}
     ff4:	5b                   	pop    %ebx
     ff5:	5e                   	pop    %esi
     ff6:	5f                   	pop    %edi
     ff7:	5d                   	pop    %ebp
     ff8:	c3                   	ret    
     ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1000:	39 d0                	cmp    %edx,%eax
    1002:	72 04                	jb     1008 <free+0x58>
    1004:	39 d1                	cmp    %edx,%ecx
    1006:	72 ce                	jb     fd6 <free+0x26>
{
    1008:	89 d0                	mov    %edx,%eax
    100a:	eb bc                	jmp    fc8 <free+0x18>
    100c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1010:	03 72 04             	add    0x4(%edx),%esi
    1013:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1016:	8b 10                	mov    (%eax),%edx
    1018:	8b 12                	mov    (%edx),%edx
    101a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    101d:	8b 50 04             	mov    0x4(%eax),%edx
    1020:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1023:	39 f1                	cmp    %esi,%ecx
    1025:	75 c6                	jne    fed <free+0x3d>
    p->s.size += bp->s.size;
    1027:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    102a:	a3 84 19 00 00       	mov    %eax,0x1984
    p->s.size += bp->s.size;
    102f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1032:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1035:	89 10                	mov    %edx,(%eax)
}
    1037:	5b                   	pop    %ebx
    1038:	5e                   	pop    %esi
    1039:	5f                   	pop    %edi
    103a:	5d                   	pop    %ebp
    103b:	c3                   	ret    
    103c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001040 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1040:	55                   	push   %ebp
    1041:	89 e5                	mov    %esp,%ebp
    1043:	57                   	push   %edi
    1044:	56                   	push   %esi
    1045:	53                   	push   %ebx
    1046:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1049:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    104c:	8b 15 84 19 00 00    	mov    0x1984,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1052:	8d 78 07             	lea    0x7(%eax),%edi
    1055:	c1 ef 03             	shr    $0x3,%edi
    1058:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    105b:	85 d2                	test   %edx,%edx
    105d:	0f 84 9d 00 00 00    	je     1100 <malloc+0xc0>
    1063:	8b 02                	mov    (%edx),%eax
    1065:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1068:	39 cf                	cmp    %ecx,%edi
    106a:	76 6c                	jbe    10d8 <malloc+0x98>
    106c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1072:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1077:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    107a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1081:	eb 0e                	jmp    1091 <malloc+0x51>
    1083:	90                   	nop
    1084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1088:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    108a:	8b 48 04             	mov    0x4(%eax),%ecx
    108d:	39 f9                	cmp    %edi,%ecx
    108f:	73 47                	jae    10d8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1091:	39 05 84 19 00 00    	cmp    %eax,0x1984
    1097:	89 c2                	mov    %eax,%edx
    1099:	75 ed                	jne    1088 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    109b:	83 ec 0c             	sub    $0xc,%esp
    109e:	56                   	push   %esi
    109f:	e8 e6 fb ff ff       	call   c8a <sbrk>
  if(p == (char*)-1)
    10a4:	83 c4 10             	add    $0x10,%esp
    10a7:	83 f8 ff             	cmp    $0xffffffff,%eax
    10aa:	74 1c                	je     10c8 <malloc+0x88>
  hp->s.size = nu;
    10ac:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    10af:	83 ec 0c             	sub    $0xc,%esp
    10b2:	83 c0 08             	add    $0x8,%eax
    10b5:	50                   	push   %eax
    10b6:	e8 f5 fe ff ff       	call   fb0 <free>
  return freep;
    10bb:	8b 15 84 19 00 00    	mov    0x1984,%edx
      if((p = morecore(nunits)) == 0)
    10c1:	83 c4 10             	add    $0x10,%esp
    10c4:	85 d2                	test   %edx,%edx
    10c6:	75 c0                	jne    1088 <malloc+0x48>
        return 0;
  }
}
    10c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    10cb:	31 c0                	xor    %eax,%eax
}
    10cd:	5b                   	pop    %ebx
    10ce:	5e                   	pop    %esi
    10cf:	5f                   	pop    %edi
    10d0:	5d                   	pop    %ebp
    10d1:	c3                   	ret    
    10d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    10d8:	39 cf                	cmp    %ecx,%edi
    10da:	74 54                	je     1130 <malloc+0xf0>
        p->s.size -= nunits;
    10dc:	29 f9                	sub    %edi,%ecx
    10de:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    10e1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    10e4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    10e7:	89 15 84 19 00 00    	mov    %edx,0x1984
}
    10ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    10f0:	83 c0 08             	add    $0x8,%eax
}
    10f3:	5b                   	pop    %ebx
    10f4:	5e                   	pop    %esi
    10f5:	5f                   	pop    %edi
    10f6:	5d                   	pop    %ebp
    10f7:	c3                   	ret    
    10f8:	90                   	nop
    10f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1100:	c7 05 84 19 00 00 88 	movl   $0x1988,0x1984
    1107:	19 00 00 
    110a:	c7 05 88 19 00 00 88 	movl   $0x1988,0x1988
    1111:	19 00 00 
    base.s.size = 0;
    1114:	b8 88 19 00 00       	mov    $0x1988,%eax
    1119:	c7 05 8c 19 00 00 00 	movl   $0x0,0x198c
    1120:	00 00 00 
    1123:	e9 44 ff ff ff       	jmp    106c <malloc+0x2c>
    1128:	90                   	nop
    1129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1130:	8b 08                	mov    (%eax),%ecx
    1132:	89 0a                	mov    %ecx,(%edx)
    1134:	eb b1                	jmp    10e7 <malloc+0xa7>
