
user/_more:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
void back(File file, Terminal terminal);
void scroll(File file, Terminal terminal);
void line(File file, Terminal terminal);
void help(Terminal terminal);

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
      11:	83 ec 38             	sub    $0x38,%esp
      14:	8b 01                	mov    (%ecx),%eax
      16:	8b 51 04             	mov    0x4(%ecx),%edx
  // arg czeching
  if (argc < 2) {
      19:	83 f8 01             	cmp    $0x1,%eax
      1c:	0f 8e c3 01 00 00    	jle    1e5 <main+0x1e5>
    fprintf(2, "more: bad usage\nTry 'more --help' for more information.\n");
    exit();
  } else if (argc > 2) {
      22:	83 f8 02             	cmp    $0x2,%eax
      25:	0f 85 e8 00 00 00    	jne    113 <main+0x113>
  terminal.height = 25;
  struct File file;
  file.len = 0;
  file.edited = 0;
  file.curLine = 1; // line displayed at bottoms
  file.filename = argv[1];
      2b:	8b 42 04             	mov    0x4(%edx),%eax
  file.len = 0;
      2e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  file.edited = 0;
      35:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  file.curLine = 1; // line displayed at bottoms
      3c:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  file.filename = argv[1];
      43:	89 45 cc             	mov    %eax,-0x34(%ebp)
  file.lines = MakeLinkedList();
      46:	e8 f5 02 00 00       	call   340 <MakeLinkedList>

  // opening file
  file.fd = open(file.filename, O_RDONLY);
      4b:	51                   	push   %ecx
      4c:	51                   	push   %ecx
      4d:	6a 00                	push   $0x0
      4f:	ff 75 cc             	pushl  -0x34(%ebp)
  file.lines = MakeLinkedList();
      52:	89 45 dc             	mov    %eax,-0x24(%ebp)
  file.fd = open(file.filename, O_RDONLY);
      55:	e8 c0 16 00 00       	call   171a <open>
  if (file.fd == -1) {
      5a:	83 c4 10             	add    $0x10,%esp
  file.fd = open(file.filename, O_RDONLY);
      5d:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if (file.fd == -1) {
      60:	83 c0 01             	add    $0x1,%eax
      63:	0f 84 8f 01 00 00    	je     1f8 <main+0x1f8>
    fprintf(2, "file could not be opened\n",  file.filename);
  } else { 
    // populate Linked List
    gatherLines(&file);
      69:	8d 45 cc             	lea    -0x34(%ebp),%eax
      6c:	83 ec 0c             	sub    $0xc,%esp
      6f:	50                   	push   %eax
      70:	89 45 bc             	mov    %eax,-0x44(%ebp)
      73:	e8 c8 05 00 00       	call   640 <gatherLines>
      78:	83 c4 10             	add    $0x10,%esp
  }
  close(file.fd);
      7b:	83 ec 0c             	sub    $0xc,%esp
      7e:	ff 75 d0             	pushl  -0x30(%ebp)
  char cmd = 'w';
      81:	bb 77 00 00 00       	mov    $0x77,%ebx
  close(file.fd);
      86:	e8 77 16 00 00       	call   1702 <close>

  // loop
  showPage(file, terminal);
      8b:	b8 4c 00 00 00       	mov    $0x4c,%eax
      90:	ba 19 00 00 00       	mov    $0x19,%edx
      95:	8b 75 bc             	mov    -0x44(%ebp),%esi
      98:	89 14 24             	mov    %edx,(%esp)
      9b:	50                   	push   %eax
      9c:	b9 07 00 00 00       	mov    $0x7,%ecx
      a1:	89 45 c0             	mov    %eax,-0x40(%ebp)
      a4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
      a7:	83 ec 1c             	sub    $0x1c,%esp
      aa:	89 e7                	mov    %esp,%edi
      ac:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
      ae:	e8 6d 0d 00 00       	call   e20 <showPage>
  while (cmd != 'q' && cmd != 'Q') {
      b3:	83 c4 30             	add    $0x30,%esp
      b6:	8d 76 00             	lea    0x0(%esi),%esi
      b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      c0:	83 e3 df             	and    $0xffffffdf,%ebx
      c3:	80 fb 51             	cmp    $0x51,%bl
      c6:	0f 84 8d 00 00 00    	je     159 <main+0x159>
    cmdint = steal(0);
      cc:	83 ec 0c             	sub    $0xc,%esp
      cf:	6a 00                	push   $0x0
      d1:	e8 1c 16 00 00       	call   16f2 <steal>
    cmd = (char) cmdint;
		// printf("cmd: %d = %c.\n", cmdint, cmd);
		if (cmd == '\0') exit();
      d6:	83 c4 10             	add    $0x10,%esp
      d9:	84 c0                	test   %al,%al
    cmd = (char) cmdint;
      db:	89 c3                	mov    %eax,%ebx
		if (cmd == '\0') exit();
      dd:	74 7a                	je     159 <main+0x159>
		switch (cmd) {
      df:	3c 62                	cmp    $0x62,%al
      e1:	0f 84 e2 00 00 00    	je     1c9 <main+0x1c9>
      e7:	7e 47                	jle    130 <main+0x130>
      e9:	3c 66                	cmp    $0x66,%al
      eb:	74 71                	je     15e <main+0x15e>
      ed:	3c 68                	cmp    $0x68,%al
      ef:	0f 84 b1 00 00 00    	je     1a6 <main+0x1a6>
      f5:	3c 65                	cmp    $0x65,%al
      f7:	75 c7                	jne    c0 <main+0xc0>
  char* msg = "... back";
  printpad(terminal.width, ' ', msg, LEFT, 0);
}
void scroll(File file, Terminal terminal){
  char* msg = "... scroll";
  printpad(terminal.width, ' ', msg, LEFT, 0);
      f9:	83 ec 0c             	sub    $0xc,%esp
      fc:	6a 00                	push   $0x0
      fe:	6a 00                	push   $0x0
     100:	68 60 1c 00 00       	push   $0x1c60
     105:	6a 20                	push   $0x20
     107:	6a 4c                	push   $0x4c
     109:	e8 02 0a 00 00       	call   b10 <printpad>
     10e:	83 c4 20             	add    $0x20,%esp
     111:	eb ad                	jmp    c0 <main+0xc0>
    fprintf(2, "this version of more only supports one file at a time.\n");
     113:	53                   	push   %ebx
     114:	53                   	push   %ebx
     115:	68 b0 1f 00 00       	push   $0x1fb0
     11a:	6a 02                	push   $0x2
     11c:	e8 2f 19 00 00       	call   1a50 <fprintf>
    exit();
     121:	e8 ac 15 00 00       	call   16d2 <exit>
     126:	8d 76 00             	lea    0x0(%esi),%esi
     129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		switch (cmd) {
     130:	3c 20                	cmp    $0x20,%al
     132:	0f 84 9f 00 00 00    	je     1d7 <main+0x1d7>
     138:	3c 3d                	cmp    $0x3d,%al
     13a:	75 84                	jne    c0 <main+0xc0>
}
void line(File file, Terminal terminal){
  char* msg = "... line";
  printpad(terminal.width, ' ', msg, LEFT, 0);
     13c:	83 ec 0c             	sub    $0xc,%esp
     13f:	6a 00                	push   $0x0
     141:	6a 00                	push   $0x0
     143:	68 6b 1c 00 00       	push   $0x1c6b
     148:	6a 20                	push   $0x20
     14a:	6a 4c                	push   $0x4c
     14c:	e8 bf 09 00 00       	call   b10 <printpad>
     151:	83 c4 20             	add    $0x20,%esp
     154:	e9 67 ff ff ff       	jmp    c0 <main+0xc0>
		if (cmd == '\0') exit();
     159:	e8 74 15 00 00       	call   16d2 <exit>
  printpad(terminal.width, ' ', msg, LEFT, 0);
     15e:	83 ec 0c             	sub    $0xc,%esp
     161:	6a 00                	push   $0x0
     163:	6a 00                	push   $0x0
     165:	68 47 1c 00 00       	push   $0x1c47
  printpad(terminal.width, ' ', msg, LEFT, 0);
     16a:	6a 20                	push   $0x20
     16c:	6a 4c                	push   $0x4c
     16e:	e8 9d 09 00 00       	call   b10 <printpad>
      showPage(file, terminal);
     173:	83 c4 14             	add    $0x14,%esp
     176:	c7 45 c0 4c 00 00 00 	movl   $0x4c,-0x40(%ebp)
     17d:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
     184:	ff 75 c4             	pushl  -0x3c(%ebp)
     187:	ff 75 c0             	pushl  -0x40(%ebp)
     18a:	b9 07 00 00 00       	mov    $0x7,%ecx
     18f:	8b 75 bc             	mov    -0x44(%ebp),%esi
     192:	83 ec 1c             	sub    $0x1c,%esp
     195:	89 e7                	mov    %esp,%edi
     197:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
     199:	e8 82 0c 00 00       	call   e20 <showPage>
			break;
     19e:	83 c4 30             	add    $0x30,%esp
     1a1:	e9 1a ff ff ff       	jmp    c0 <main+0xc0>
			help(terminal);
     1a6:	c7 45 c0 4c 00 00 00 	movl   $0x4c,-0x40(%ebp)
     1ad:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
     1b4:	50                   	push   %eax
     1b5:	50                   	push   %eax
     1b6:	ff 75 c4             	pushl  -0x3c(%ebp)
     1b9:	ff 75 c0             	pushl  -0x40(%ebp)
     1bc:	e8 7f 0b 00 00       	call   d40 <help>
			break;
     1c1:	83 c4 10             	add    $0x10,%esp
     1c4:	e9 f7 fe ff ff       	jmp    c0 <main+0xc0>
  printpad(terminal.width, ' ', msg, LEFT, 0);
     1c9:	83 ec 0c             	sub    $0xc,%esp
     1cc:	6a 00                	push   $0x0
     1ce:	6a 00                	push   $0x0
     1d0:	68 57 1c 00 00       	push   $0x1c57
     1d5:	eb 93                	jmp    16a <main+0x16a>
  printpad(terminal.width, ' ', msg, LEFT, 0);
     1d7:	83 ec 0c             	sub    $0xc,%esp
     1da:	6a 00                	push   $0x0
     1dc:	6a 00                	push   $0x0
     1de:	68 3b 1c 00 00       	push   $0x1c3b
     1e3:	eb 85                	jmp    16a <main+0x16a>
    fprintf(2, "more: bad usage\nTry 'more --help' for more information.\n");
     1e5:	56                   	push   %esi
     1e6:	56                   	push   %esi
     1e7:	68 74 1f 00 00       	push   $0x1f74
     1ec:	6a 02                	push   $0x2
     1ee:	e8 5d 18 00 00       	call   1a50 <fprintf>
    exit();
     1f3:	e8 da 14 00 00       	call   16d2 <exit>
    fprintf(2, "file could not be opened\n",  file.filename);
     1f8:	52                   	push   %edx
     1f9:	ff 75 cc             	pushl  -0x34(%ebp)
     1fc:	68 86 1c 00 00       	push   $0x1c86
     201:	6a 02                	push   $0x2
     203:	e8 48 18 00 00       	call   1a50 <fprintf>
     208:	8d 45 cc             	lea    -0x34(%ebp),%eax
     20b:	83 c4 10             	add    $0x10,%esp
     20e:	89 45 bc             	mov    %eax,-0x44(%ebp)
     211:	e9 65 fe ff ff       	jmp    7b <main+0x7b>
     216:	66 90                	xchg   %ax,%ax
     218:	66 90                	xchg   %ax,%ax
     21a:	66 90                	xchg   %ax,%ax
     21c:	66 90                	xchg   %ax,%ax
     21e:	66 90                	xchg   %ax,%ax

00000220 <safestrcpy>:
#include "LinkedList.h"
#define nullptr 0

char* safestrcpy(char *s, const char *t, int n) {
     220:	55                   	push   %ebp
     221:	89 e5                	mov    %esp,%ebp
     223:	56                   	push   %esi
     224:	53                   	push   %ebx
     225:	8b 4d 10             	mov    0x10(%ebp),%ecx
     228:	8b 45 08             	mov    0x8(%ebp),%eax
     22b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
     22e:	85 c9                	test   %ecx,%ecx
     230:	7e 26                	jle    258 <safestrcpy+0x38>
     232:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
     236:	89 c1                	mov    %eax,%ecx
     238:	eb 17                	jmp    251 <safestrcpy+0x31>
     23a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
     240:	83 c2 01             	add    $0x1,%edx
     243:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
     247:	83 c1 01             	add    $0x1,%ecx
     24a:	84 db                	test   %bl,%bl
     24c:	88 59 ff             	mov    %bl,-0x1(%ecx)
     24f:	74 04                	je     255 <safestrcpy+0x35>
     251:	39 f2                	cmp    %esi,%edx
     253:	75 eb                	jne    240 <safestrcpy+0x20>
    ;
  *s = 0;
     255:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
     258:	5b                   	pop    %ebx
     259:	5e                   	pop    %esi
     25a:	5d                   	pop    %ebp
     25b:	c3                   	ret    
     25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000260 <nullNode>:

Node* nullNode(char* data) {
     260:	55                   	push   %ebp
     261:	89 e5                	mov    %esp,%ebp
     263:	83 ec 14             	sub    $0x14,%esp
  struct Node* node = malloc(sizeof(Node));
     266:	6a 0c                	push   $0xc
     268:	e8 b3 18 00 00       	call   1b20 <malloc>
  node->prev = nullptr;
  node->data = data;
     26d:	8b 55 08             	mov    0x8(%ebp),%edx
  node->prev = nullptr;
     270:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->next = nullptr;
     276:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  node->data = data;
     27d:	89 50 04             	mov    %edx,0x4(%eax)
  return node;
}
     280:	c9                   	leave  
     281:	c3                   	ret    
     282:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <nodeAt>:

Node* nodeAt(struct LinkedList* list, int pos) {
     290:	55                   	push   %ebp
     291:	89 e5                	mov    %esp,%ebp
     293:	53                   	push   %ebx
     294:	8b 45 08             	mov    0x8(%ebp),%eax
     297:	8b 55 0c             	mov    0xc(%ebp),%edx
  // for anything past the end:
  if (pos > list->len)
     29a:	8b 48 08             	mov    0x8(%eax),%ecx
     29d:	39 d1                	cmp    %edx,%ecx
     29f:	7c 1f                	jl     2c0 <nodeAt+0x30>
    return list->tail->prev;
  // for anything before the beginning:
  if ((pos < 0) && ((0 - pos) > list->len))
     2a1:	85 d2                	test   %edx,%edx
     2a3:	78 2b                	js     2d0 <nodeAt+0x40>
    while (++pos != 0)
      curNode = curNode->prev;
  } // start looking from front
  else {
    int cur = 0;
    curNode = list->head->next;
     2a5:	8b 00                	mov    (%eax),%eax
     2a7:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     2aa:	74 0e                	je     2ba <nodeAt+0x2a>
    int cur = 0;
     2ac:	31 c9                	xor    %ecx,%ecx
     2ae:	66 90                	xchg   %ax,%ax
      curNode = curNode->next;
      cur++;
     2b0:	83 c1 01             	add    $0x1,%ecx
      curNode = curNode->next;
     2b3:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     2b6:	39 ca                	cmp    %ecx,%edx
     2b8:	75 f6                	jne    2b0 <nodeAt+0x20>
    }
  }
  return curNode;
}
     2ba:	5b                   	pop    %ebx
     2bb:	5d                   	pop    %ebp
     2bc:	c3                   	ret    
     2bd:	8d 76 00             	lea    0x0(%esi),%esi
    return list->tail->prev;
     2c0:	8b 40 04             	mov    0x4(%eax),%eax
}
     2c3:	5b                   	pop    %ebx
     2c4:	5d                   	pop    %ebp
    return list->tail->prev;
     2c5:	8b 00                	mov    (%eax),%eax
}
     2c7:	c3                   	ret    
     2c8:	90                   	nop
     2c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if ((pos < 0) && ((0 - pos) > list->len))
     2d0:	89 d3                	mov    %edx,%ebx
     2d2:	f7 db                	neg    %ebx
     2d4:	39 d9                	cmp    %ebx,%ecx
     2d6:	7c 18                	jl     2f0 <nodeAt+0x60>
    while (++pos != 0)
     2d8:	83 c2 01             	add    $0x1,%edx
    curNode = list->tail;
     2db:	8b 40 04             	mov    0x4(%eax),%eax
    while (++pos != 0)
     2de:	74 da                	je     2ba <nodeAt+0x2a>
     2e0:	83 c2 01             	add    $0x1,%edx
      curNode = curNode->prev;
     2e3:	8b 00                	mov    (%eax),%eax
    while (++pos != 0)
     2e5:	75 f9                	jne    2e0 <nodeAt+0x50>
}
     2e7:	5b                   	pop    %ebx
     2e8:	5d                   	pop    %ebp
     2e9:	c3                   	ret    
     2ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return list->head->next;
     2f0:	8b 00                	mov    (%eax),%eax
     2f2:	8b 40 08             	mov    0x8(%eax),%eax
     2f5:	eb c3                	jmp    2ba <nodeAt+0x2a>
     2f7:	89 f6                	mov    %esi,%esi
     2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000300 <destroyNode>:

void destroyNode(struct LinkedList* list, struct Node* self) {
     300:	55                   	push   %ebp
     301:	89 e5                	mov    %esp,%ebp
     303:	56                   	push   %esi
     304:	53                   	push   %ebx
     305:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     308:	8b 75 08             	mov    0x8(%ebp),%esi
    self->prev->next = self->next;
    self->next->prev = self->prev;

    free(self->data);
     30b:	83 ec 0c             	sub    $0xc,%esp
    self->prev->next = self->next;
     30e:	8b 03                	mov    (%ebx),%eax
     310:	8b 53 08             	mov    0x8(%ebx),%edx
     313:	89 50 08             	mov    %edx,0x8(%eax)
    self->next->prev = self->prev;
     316:	8b 43 08             	mov    0x8(%ebx),%eax
     319:	8b 13                	mov    (%ebx),%edx
     31b:	89 10                	mov    %edx,(%eax)
    free(self->data);
     31d:	ff 73 04             	pushl  0x4(%ebx)
     320:	e8 6b 17 00 00       	call   1a90 <free>
    free(self);
     325:	89 1c 24             	mov    %ebx,(%esp)
     328:	e8 63 17 00 00       	call   1a90 <free>
    list->len--;
     32d:	83 6e 08 01          	subl   $0x1,0x8(%esi)
}
     331:	83 c4 10             	add    $0x10,%esp
     334:	8d 65 f8             	lea    -0x8(%ebp),%esp
     337:	5b                   	pop    %ebx
     338:	5e                   	pop    %esi
     339:	5d                   	pop    %ebp
     33a:	c3                   	ret    
     33b:	90                   	nop
     33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000340 <MakeLinkedList>:

LinkedList* MakeLinkedList() {
     340:	55                   	push   %ebp
     341:	89 e5                	mov    %esp,%ebp
     343:	56                   	push   %esi
     344:	53                   	push   %ebx
  struct LinkedList* list = malloc(sizeof(LinkedList));
     345:	83 ec 0c             	sub    $0xc,%esp
     348:	6a 0c                	push   $0xc
     34a:	e8 d1 17 00 00       	call   1b20 <malloc>
  struct Node* node = malloc(sizeof(Node));
     34f:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  struct LinkedList* list = malloc(sizeof(LinkedList));
     356:	89 c6                	mov    %eax,%esi
  struct Node* node = malloc(sizeof(Node));
     358:	e8 c3 17 00 00       	call   1b20 <malloc>
     35d:	89 c3                	mov    %eax,%ebx
  node->prev = nullptr;
     35f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->data = data;
     365:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  node->next = nullptr;
     36c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  struct Node* node = malloc(sizeof(Node));
     373:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     37a:	e8 a1 17 00 00       	call   1b20 <malloc>
  node->data = data;
     37f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  Node* head = nullNode(nullptr);
  Node* tail = nullNode(nullptr);
  head->prev = nullptr;
  head->next = tail;
     386:	89 43 08             	mov    %eax,0x8(%ebx)
  head->prev = nullptr;
     389:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  tail->prev = head;
     38f:	89 18                	mov    %ebx,(%eax)
  tail->next = nullptr;
     391:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)

  list->len = 0;
  list->head = head;
  list->tail = tail;
     398:	89 46 04             	mov    %eax,0x4(%esi)
  return list;
}
     39b:	89 f0                	mov    %esi,%eax
  list->len = 0;
     39d:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
  list->head = head;
     3a4:	89 1e                	mov    %ebx,(%esi)
}
     3a6:	8d 65 f8             	lea    -0x8(%ebp),%esp
     3a9:	5b                   	pop    %ebx
     3aa:	5e                   	pop    %esi
     3ab:	5d                   	pop    %ebp
     3ac:	c3                   	ret    
     3ad:	8d 76 00             	lea    0x0(%esi),%esi

000003b0 <insert>:

void insert(struct LinkedList* list, char* data, int pos) {
     3b0:	55                   	push   %ebp
     3b1:	89 e5                	mov    %esp,%ebp
     3b3:	57                   	push   %edi
     3b4:	56                   	push   %esi
     3b5:	53                   	push   %ebx
     3b6:	83 ec 0c             	sub    $0xc,%esp
  struct Node* atPos = nodeAt(list, pos);
     3b9:	ff 75 10             	pushl  0x10(%ebp)
     3bc:	ff 75 08             	pushl  0x8(%ebp)
void insert(struct LinkedList* list, char* data, int pos) {
     3bf:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct Node* atPos = nodeAt(list, pos);
     3c2:	e8 c9 fe ff ff       	call   290 <nodeAt>
     3c7:	83 ec 04             	sub    $0x4,%esp
     3ca:	89 c6                	mov    %eax,%esi
  char* newData = (char*)malloc(sizeof(char) * 1000);
     3cc:	68 e8 03 00 00       	push   $0x3e8
     3d1:	e8 4a 17 00 00       	call   1b20 <malloc>
     3d6:	8d 8b e7 03 00 00    	lea    0x3e7(%ebx),%ecx
     3dc:	89 c7                	mov    %eax,%edi
     3de:	83 c4 10             	add    $0x10,%esp
     3e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(--n > 0 && (*s++ = *t++) != 0)
     3e8:	83 c3 01             	add    $0x1,%ebx
     3eb:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     3ef:	83 c0 01             	add    $0x1,%eax
     3f2:	84 d2                	test   %dl,%dl
     3f4:	88 50 ff             	mov    %dl,-0x1(%eax)
     3f7:	74 04                	je     3fd <insert+0x4d>
     3f9:	39 d9                	cmp    %ebx,%ecx
     3fb:	75 eb                	jne    3e8 <insert+0x38>
  newData = safestrcpy(newData, data, (sizeof(char) * 1000));
  struct Node* new = malloc(sizeof(Node));
     3fd:	83 ec 0c             	sub    $0xc,%esp
  *s = 0;
     400:	c6 00 00             	movb   $0x0,(%eax)
  struct Node* new = malloc(sizeof(Node));
     403:	6a 0c                	push   $0xc
     405:	e8 16 17 00 00       	call   1b20 <malloc>

  new->data = newData;
     40a:	89 78 04             	mov    %edi,0x4(%eax)
  new->prev = atPos->prev;
     40d:	8b 16                	mov    (%esi),%edx
  new->next = atPos;
     40f:	89 70 08             	mov    %esi,0x8(%eax)
  new->prev = atPos->prev;
     412:	89 10                	mov    %edx,(%eax)
  new->prev->next = new;
     414:	89 42 08             	mov    %eax,0x8(%edx)
  atPos->prev = new;
     417:	89 06                	mov    %eax,(%esi)
  list->len++;
     419:	8b 45 08             	mov    0x8(%ebp),%eax
     41c:	83 40 08 01          	addl   $0x1,0x8(%eax)
}
     420:	8d 65 f4             	lea    -0xc(%ebp),%esp
     423:	5b                   	pop    %ebx
     424:	5e                   	pop    %esi
     425:	5f                   	pop    %edi
     426:	5d                   	pop    %ebp
     427:	c3                   	ret    
     428:	90                   	nop
     429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000430 <prepend>:

void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
     430:	55                   	push   %ebp
     431:	89 e5                	mov    %esp,%ebp
     433:	83 ec 0c             	sub    $0xc,%esp
     436:	6a 00                	push   $0x0
     438:	ff 75 0c             	pushl  0xc(%ebp)
     43b:	ff 75 08             	pushl  0x8(%ebp)
     43e:	e8 6d ff ff ff       	call   3b0 <insert>
     443:	83 c4 10             	add    $0x10,%esp
     446:	c9                   	leave  
     447:	c3                   	ret    
     448:	90                   	nop
     449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000450 <append>:
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	83 ec 0c             	sub    $0xc,%esp
     456:	8b 45 08             	mov    0x8(%ebp),%eax
     459:	ff 70 08             	pushl  0x8(%eax)
     45c:	ff 75 0c             	pushl  0xc(%ebp)
     45f:	50                   	push   %eax
     460:	e8 4b ff ff ff       	call   3b0 <insert>
     465:	83 c4 10             	add    $0x10,%esp
     468:	c9                   	leave  
     469:	c3                   	ret    
     46a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000470 <destroyLinkedList>:

void destroyLinkedList(struct LinkedList* list) {
     470:	55                   	push   %ebp
     471:	89 e5                	mov    %esp,%ebp
     473:	56                   	push   %esi
     474:	53                   	push   %ebx
     475:	8b 75 08             	mov    0x8(%ebp),%esi
  struct Node* curNode = list->head;
     478:	8b 1e                	mov    (%esi),%ebx
  while (curNode != list->tail) {
     47a:	8b 46 04             	mov    0x4(%esi),%eax
     47d:	39 c3                	cmp    %eax,%ebx
     47f:	74 29                	je     4aa <destroyLinkedList+0x3a>
     481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
     488:	8b 5b 08             	mov    0x8(%ebx),%ebx
    free(curNode->prev->data);
     48b:	83 ec 0c             	sub    $0xc,%esp
     48e:	8b 03                	mov    (%ebx),%eax
     490:	ff 70 04             	pushl  0x4(%eax)
     493:	e8 f8 15 00 00       	call   1a90 <free>
    free(curNode->prev);
     498:	58                   	pop    %eax
     499:	ff 33                	pushl  (%ebx)
     49b:	e8 f0 15 00 00       	call   1a90 <free>
  while (curNode != list->tail) {
     4a0:	8b 46 04             	mov    0x4(%esi),%eax
     4a3:	83 c4 10             	add    $0x10,%esp
     4a6:	39 d8                	cmp    %ebx,%eax
     4a8:	75 de                	jne    488 <destroyLinkedList+0x18>
  }
  free(curNode);
     4aa:	83 ec 0c             	sub    $0xc,%esp
     4ad:	50                   	push   %eax
     4ae:	e8 dd 15 00 00       	call   1a90 <free>
  free(list);
     4b3:	89 75 08             	mov    %esi,0x8(%ebp)
     4b6:	83 c4 10             	add    $0x10,%esp
     4b9:	8d 65 f8             	lea    -0x8(%ebp),%esp
     4bc:	5b                   	pop    %ebx
     4bd:	5e                   	pop    %esi
     4be:	5d                   	pop    %ebp
  free(list);
     4bf:	e9 cc 15 00 00       	jmp    1a90 <free>
     4c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     4ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000004d0 <confirmation>:
#include "helpers.h"

int confirmation() {
     4d0:	55                   	push   %ebp
     4d1:	89 e5                	mov    %esp,%ebp
     4d3:	53                   	push   %ebx
  // get response
  char buf[MAXLINESIZE];
  int nbuf = sizeof(buf);
  memset(buf, 0, nbuf);
     4d4:	8d 9d 10 fc ff ff    	lea    -0x3f0(%ebp),%ebx
int confirmation() {
     4da:	81 ec f8 03 00 00    	sub    $0x3f8,%esp
  memset(buf, 0, nbuf);
     4e0:	68 e8 03 00 00       	push   $0x3e8
     4e5:	6a 00                	push   $0x0
     4e7:	53                   	push   %ebx
     4e8:	e8 43 10 00 00       	call   1530 <memset>
  gets(buf, nbuf);
     4ed:	58                   	pop    %eax
     4ee:	5a                   	pop    %edx
     4ef:	68 e8 03 00 00       	push   $0x3e8
     4f4:	53                   	push   %ebx
     4f5:	e8 96 10 00 00       	call   1590 <gets>
  // determine output
  switch (buf[0]) {
     4fa:	0f b6 85 10 fc ff ff 	movzbl -0x3f0(%ebp),%eax
     501:	83 c4 10             	add    $0x10,%esp
     504:	3c 59                	cmp    $0x59,%al
     506:	74 18                	je     520 <confirmation+0x50>
     508:	3c 79                	cmp    $0x79,%al
     50a:	74 14                	je     520 <confirmation+0x50>
  case 'Y':
  case 'y':
    return 0;
  default:
    return 1;
     50c:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
     511:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     514:	c9                   	leave  
     515:	c3                   	ret    
     516:	8d 76 00             	lea    0x0(%esi),%esi
     519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return 0;
     520:	31 c0                	xor    %eax,%eax
}
     522:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     525:	c9                   	leave  
     526:	c3                   	ret    
     527:	89 f6                	mov    %esi,%esi
     529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000530 <normalizeRange>:
    return 1;

  return 0;
}

int normalizeRange(File file, int* sp, int* ep) {
     530:	55                   	push   %ebp
     531:	89 e5                	mov    %esp,%ebp
     533:	53                   	push   %ebx
     534:	8b 4d 28             	mov    0x28(%ebp),%ecx
  int l = file.len;
     537:	8b 45 1c             	mov    0x1c(%ebp),%eax
int normalizeRange(File file, int* sp, int* ep) {
     53a:	8b 5d 24             	mov    0x24(%ebp),%ebx
  if (*ep > l) *ep = l;
     53d:	8b 11                	mov    (%ecx),%edx
     53f:	39 c2                	cmp    %eax,%edx
     541:	7e 45                	jle    588 <normalizeRange+0x58>
     543:	89 01                	mov    %eax,(%ecx)
     545:	89 c2                	mov    %eax,%edx
  else if (*ep < 1) *ep += l + 1;
  if (*ep < 1) *ep = 1;
     547:	85 d2                	test   %edx,%edx
     549:	7f 06                	jg     551 <normalizeRange+0x21>
     54b:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)

  if (*sp > l) *sp = l;
     551:	8b 13                	mov    (%ebx),%edx
     553:	39 c2                	cmp    %eax,%edx
     555:	7e 21                	jle    578 <normalizeRange+0x48>
     557:	89 03                	mov    %eax,(%ebx)
     559:	89 c2                	mov    %eax,%edx
  else if (*sp < 1) *sp += l + 1;
  if (*sp < 1) *sp = 1;
     55b:	85 d2                	test   %edx,%edx
     55d:	7f 0b                	jg     56a <normalizeRange+0x3a>
     55f:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
     565:	ba 01 00 00 00       	mov    $0x1,%edx
  if ((*ep - *sp) < 0)
     56a:	8b 01                	mov    (%ecx),%eax
    return 1;
  return 0;
}
     56c:	5b                   	pop    %ebx
     56d:	5d                   	pop    %ebp
  if ((*ep - *sp) < 0)
     56e:	29 d0                	sub    %edx,%eax
     570:	c1 e8 1f             	shr    $0x1f,%eax
}
     573:	c3                   	ret    
     574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*sp < 1) *sp += l + 1;
     578:	85 d2                	test   %edx,%edx
     57a:	7f ee                	jg     56a <normalizeRange+0x3a>
     57c:	8d 54 10 01          	lea    0x1(%eax,%edx,1),%edx
     580:	89 13                	mov    %edx,(%ebx)
     582:	eb d7                	jmp    55b <normalizeRange+0x2b>
     584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*ep < 1) *ep += l + 1;
     588:	85 d2                	test   %edx,%edx
     58a:	7f c5                	jg     551 <normalizeRange+0x21>
     58c:	8d 54 02 01          	lea    0x1(%edx,%eax,1),%edx
     590:	89 11                	mov    %edx,(%ecx)
     592:	eb b3                	jmp    547 <normalizeRange+0x17>
     594:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     59a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005a0 <numLines>:

int numLines(int start, int end) {
     5a0:	55                   	push   %ebp
     5a1:	89 e5                	mov    %esp,%ebp
  return (end - start) + 1;
     5a3:	8b 45 0c             	mov    0xc(%ebp),%eax
     5a6:	2b 45 08             	sub    0x8(%ebp),%eax
}
     5a9:	5d                   	pop    %ebp
  return (end - start) + 1;
     5aa:	83 c0 01             	add    $0x1,%eax
}
     5ad:	c3                   	ret    
     5ae:	66 90                	xchg   %ax,%ax

000005b0 <getLine>:
    append(file->lines, line);
    file->len++;
  }
}

int getLine(int fileptr, char line[]) {
     5b0:	55                   	push   %ebp
     5b1:	89 e5                	mov    %esp,%ebp
     5b3:	57                   	push   %edi
     5b4:	56                   	push   %esi
     5b5:	53                   	push   %ebx
  int len = strlen(line);
  memset(line, 0, len);
  char c[1];
  int i;
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     5b6:	31 ff                	xor    %edi,%edi
     5b8:	8d 75 e7             	lea    -0x19(%ebp),%esi
int getLine(int fileptr, char line[]) {
     5bb:	83 ec 28             	sub    $0x28,%esp
     5be:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int len = strlen(line);
     5c1:	53                   	push   %ebx
     5c2:	e8 39 0f 00 00       	call   1500 <strlen>
  memset(line, 0, len);
     5c7:	83 c4 0c             	add    $0xc,%esp
     5ca:	50                   	push   %eax
     5cb:	6a 00                	push   $0x0
     5cd:	53                   	push   %ebx
     5ce:	e8 5d 0f 00 00       	call   1530 <memset>
     5d3:	83 c4 10             	add    $0x10,%esp
     5d6:	eb 1e                	jmp    5f6 <getLine+0x46>
     5d8:	90                   	nop
     5d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (read(fileptr, c, 1) == 0) return strlen(line);
    if (*c == '\n') break;
     5e0:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     5e4:	3c 0a                	cmp    $0xa,%al
     5e6:	74 38                	je     620 <getLine+0x70>
    line[i] = *c;
     5e8:	88 04 3b             	mov    %al,(%ebx,%edi,1)
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     5eb:	83 c7 01             	add    $0x1,%edi
     5ee:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
     5f4:	74 42                	je     638 <getLine+0x88>
    if (read(fileptr, c, 1) == 0) return strlen(line);
     5f6:	83 ec 04             	sub    $0x4,%esp
     5f9:	6a 01                	push   $0x1
     5fb:	56                   	push   %esi
     5fc:	ff 75 08             	pushl  0x8(%ebp)
     5ff:	e8 e6 10 00 00       	call   16ea <read>
     604:	83 c4 10             	add    $0x10,%esp
     607:	85 c0                	test   %eax,%eax
     609:	75 d5                	jne    5e0 <getLine+0x30>
     60b:	83 ec 0c             	sub    $0xc,%esp
     60e:	53                   	push   %ebx
     60f:	e8 ec 0e 00 00       	call   1500 <strlen>
     614:	83 c4 10             	add    $0x10,%esp
  }
  line[i + 1] = '\0';
  return 1;
}
     617:	8d 65 f4             	lea    -0xc(%ebp),%esp
     61a:	5b                   	pop    %ebx
     61b:	5e                   	pop    %esi
     61c:	5f                   	pop    %edi
     61d:	5d                   	pop    %ebp
     61e:	c3                   	ret    
     61f:	90                   	nop
     620:	8d 57 01             	lea    0x1(%edi),%edx
  line[i + 1] = '\0';
     623:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
     627:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
     62a:	b8 01 00 00 00       	mov    $0x1,%eax
}
     62f:	5b                   	pop    %ebx
     630:	5e                   	pop    %esi
     631:	5f                   	pop    %edi
     632:	5d                   	pop    %ebp
     633:	c3                   	ret    
     634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     638:	ba e8 03 00 00       	mov    $0x3e8,%edx
     63d:	eb e4                	jmp    623 <getLine+0x73>
     63f:	90                   	nop

00000640 <gatherLines>:
void gatherLines(File* file) {
     640:	55                   	push   %ebp
     641:	89 e5                	mov    %esp,%ebp
     643:	56                   	push   %esi
     644:	53                   	push   %ebx
     645:	8d b5 10 fc ff ff    	lea    -0x3f0(%ebp),%esi
     64b:	81 ec f0 03 00 00    	sub    $0x3f0,%esp
     651:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while (getLine(file->fd, line)) {
     654:	eb 21                	jmp    677 <gatherLines+0x37>
     656:	8d 76 00             	lea    0x0(%esi),%esi
     659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    append(file->lines, line);
     660:	8b 43 10             	mov    0x10(%ebx),%eax
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     663:	83 ec 04             	sub    $0x4,%esp
     666:	ff 70 08             	pushl  0x8(%eax)
     669:	56                   	push   %esi
     66a:	50                   	push   %eax
     66b:	e8 40 fd ff ff       	call   3b0 <insert>
    file->len++;
     670:	83 43 14 01          	addl   $0x1,0x14(%ebx)
     674:	83 c4 10             	add    $0x10,%esp
  while (getLine(file->fd, line)) {
     677:	83 ec 08             	sub    $0x8,%esp
     67a:	56                   	push   %esi
     67b:	ff 73 04             	pushl  0x4(%ebx)
     67e:	e8 2d ff ff ff       	call   5b0 <getLine>
     683:	83 c4 10             	add    $0x10,%esp
     686:	85 c0                	test   %eax,%eax
     688:	75 d6                	jne    660 <gatherLines+0x20>
}
     68a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     68d:	5b                   	pop    %ebx
     68e:	5e                   	pop    %esi
     68f:	5d                   	pop    %ebp
     690:	c3                   	ret    
     691:	eb 0d                	jmp    6a0 <unline>
     693:	90                   	nop
     694:	90                   	nop
     695:	90                   	nop
     696:	90                   	nop
     697:	90                   	nop
     698:	90                   	nop
     699:	90                   	nop
     69a:	90                   	nop
     69b:	90                   	nop
     69c:	90                   	nop
     69d:	90                   	nop
     69e:	90                   	nop
     69f:	90                   	nop

000006a0 <unline>:
  int end = find(args, delimiter);
  substr(dest, args, 0, end);
  substr(args, args, end + 1, (int) strlen(args));
}

void unline(char* str) {
     6a0:	55                   	push   %ebp
     6a1:	89 e5                	mov    %esp,%ebp
     6a3:	53                   	push   %ebx
     6a4:	83 ec 10             	sub    $0x10,%esp
     6a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str) - 1;
     6aa:	53                   	push   %ebx
     6ab:	e8 50 0e 00 00       	call   1500 <strlen>
     6b0:	8d 50 ff             	lea    -0x1(%eax),%edx
  for (; len > 0; len--) {
     6b3:	83 c4 10             	add    $0x10,%esp
     6b6:	85 d2                	test   %edx,%edx
     6b8:	7e 36                	jle    6f0 <unline+0x50>
    char c = str[len];
    if (c == '\n')
     6ba:	80 7c 03 ff 0a       	cmpb   $0xa,-0x1(%ebx,%eax,1)
     6bf:	74 2f                	je     6f0 <unline+0x50>
     6c1:	8d 44 03 fe          	lea    -0x2(%ebx,%eax,1),%eax
     6c5:	eb 12                	jmp    6d9 <unline+0x39>
     6c7:	89 f6                	mov    %esi,%esi
     6c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     6d0:	83 e8 01             	sub    $0x1,%eax
     6d3:	80 78 01 0a          	cmpb   $0xa,0x1(%eax)
     6d7:	74 06                	je     6df <unline+0x3f>
  for (; len > 0; len--) {
     6d9:	39 c3                	cmp    %eax,%ebx
     6db:	89 c2                	mov    %eax,%edx
     6dd:	75 f1                	jne    6d0 <unline+0x30>
      break;
  }
  str[len] = '\0';
     6df:	c6 02 00             	movb   $0x0,(%edx)
}
     6e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     6e5:	c9                   	leave  
     6e6:	c3                   	ret    
     6e7:	89 f6                	mov    %esi,%esi
     6e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     6f0:	01 da                	add    %ebx,%edx
  str[len] = '\0';
     6f2:	c6 02 00             	movb   $0x0,(%edx)
}
     6f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     6f8:	c9                   	leave  
     6f9:	c3                   	ret    
     6fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000700 <find>:


// str ops
int find(char* str, char c) {
     700:	55                   	push   %ebp
     701:	89 e5                	mov    %esp,%ebp
     703:	57                   	push   %edi
     704:	56                   	push   %esi
     705:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     706:	31 db                	xor    %ebx,%ebx
int find(char* str, char c) {
     708:	83 ec 0c             	sub    $0xc,%esp
     70b:	8b 75 08             	mov    0x8(%ebp),%esi
     70e:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
  for (int i = 0; i < strlen(str); i++)
     712:	eb 0e                	jmp    722 <find+0x22>
     714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     718:	89 f8                	mov    %edi,%eax
     71a:	38 04 1e             	cmp    %al,(%esi,%ebx,1)
     71d:	74 18                	je     737 <find+0x37>
  for (int i = 0; i < strlen(str); i++)
     71f:	83 c3 01             	add    $0x1,%ebx
     722:	83 ec 0c             	sub    $0xc,%esp
     725:	56                   	push   %esi
     726:	e8 d5 0d 00 00       	call   1500 <strlen>
     72b:	83 c4 10             	add    $0x10,%esp
     72e:	39 d8                	cmp    %ebx,%eax
     730:	77 e6                	ja     718 <find+0x18>
  return -1;
     732:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
     737:	8d 65 f4             	lea    -0xc(%ebp),%esp
     73a:	89 d8                	mov    %ebx,%eax
     73c:	5b                   	pop    %ebx
     73d:	5e                   	pop    %esi
     73e:	5f                   	pop    %edi
     73f:	5d                   	pop    %ebp
     740:	c3                   	ret    
     741:	eb 0d                	jmp    750 <substr>
     743:	90                   	nop
     744:	90                   	nop
     745:	90                   	nop
     746:	90                   	nop
     747:	90                   	nop
     748:	90                   	nop
     749:	90                   	nop
     74a:	90                   	nop
     74b:	90                   	nop
     74c:	90                   	nop
     74d:	90                   	nop
     74e:	90                   	nop
     74f:	90                   	nop

00000750 <substr>:

void substr(char* dest, char* str, int start, int end) {
     750:	55                   	push   %ebp
     751:	89 e5                	mov    %esp,%ebp
     753:	57                   	push   %edi
     754:	56                   	push   %esi
     755:	53                   	push   %ebx
     756:	83 ec 18             	sub    $0x18,%esp
     759:	8b 7d 14             	mov    0x14(%ebp),%edi
  int len = strlen(str);
     75c:	ff 75 0c             	pushl  0xc(%ebp)
void substr(char* dest, char* str, int start, int end) {
     75f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     762:	8b 75 08             	mov    0x8(%ebp),%esi
  int len = strlen(str);
     765:	e8 96 0d 00 00       	call   1500 <strlen>
     76a:	83 c4 10             	add    $0x10,%esp
     76d:	39 f8                	cmp    %edi,%eax
     76f:	0f 4e f8             	cmovle %eax,%edi
  if (end > len) end = len;
  int s = 0, i = start;
  while (i < end)
     772:	39 df                	cmp    %ebx,%edi
     774:	7e 1c                	jle    792 <substr+0x42>
     776:	8b 45 0c             	mov    0xc(%ebp),%eax
     779:	29 df                	sub    %ebx,%edi
  int s = 0, i = start;
     77b:	31 d2                	xor    %edx,%edx
     77d:	01 c3                	add    %eax,%ebx
     77f:	90                   	nop
    dest[s++] = str[i++];
     780:	83 c2 01             	add    $0x1,%edx
     783:	0f b6 44 13 ff       	movzbl -0x1(%ebx,%edx,1),%eax
  while (i < end)
     788:	39 fa                	cmp    %edi,%edx
    dest[s++] = str[i++];
     78a:	88 44 16 ff          	mov    %al,-0x1(%esi,%edx,1)
  while (i < end)
     78e:	75 f0                	jne    780 <substr+0x30>
     790:	01 d6                	add    %edx,%esi
  dest[s] = '\0';
     792:	c6 06 00             	movb   $0x0,(%esi)
}
     795:	8d 65 f4             	lea    -0xc(%ebp),%esp
     798:	5b                   	pop    %ebx
     799:	5e                   	pop    %esi
     79a:	5f                   	pop    %edi
     79b:	5d                   	pop    %ebp
     79c:	c3                   	ret    
     79d:	8d 76 00             	lea    0x0(%esi),%esi

000007a0 <getArg>:
void getArg(char* dest, char* args, char delimiter) {
     7a0:	55                   	push   %ebp
     7a1:	89 e5                	mov    %esp,%ebp
     7a3:	57                   	push   %edi
     7a4:	56                   	push   %esi
     7a5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     7a6:	31 db                	xor    %ebx,%ebx
void getArg(char* dest, char* args, char delimiter) {
     7a8:	83 ec 1c             	sub    $0x1c,%esp
     7ab:	8b 75 0c             	mov    0xc(%ebp),%esi
     7ae:	0f b6 7d 10          	movzbl 0x10(%ebp),%edi
     7b2:	eb 10                	jmp    7c4 <getArg+0x24>
     7b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     7b8:	89 f8                	mov    %edi,%eax
     7ba:	3a 04 1e             	cmp    (%esi,%ebx,1),%al
     7bd:	8d 53 01             	lea    0x1(%ebx),%edx
     7c0:	74 19                	je     7db <getArg+0x3b>
     7c2:	89 d3                	mov    %edx,%ebx
  for (int i = 0; i < strlen(str); i++)
     7c4:	83 ec 0c             	sub    $0xc,%esp
     7c7:	56                   	push   %esi
     7c8:	e8 33 0d 00 00       	call   1500 <strlen>
     7cd:	83 c4 10             	add    $0x10,%esp
     7d0:	39 c3                	cmp    %eax,%ebx
     7d2:	72 e4                	jb     7b8 <getArg+0x18>
     7d4:	31 d2                	xor    %edx,%edx
  return -1;
     7d6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  substr(dest, args, 0, end);
     7db:	53                   	push   %ebx
     7dc:	6a 00                	push   $0x0
     7de:	56                   	push   %esi
     7df:	ff 75 08             	pushl  0x8(%ebp)
     7e2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     7e5:	e8 66 ff ff ff       	call   750 <substr>
  substr(args, args, end + 1, (int) strlen(args));
     7ea:	89 34 24             	mov    %esi,(%esp)
     7ed:	e8 0e 0d 00 00       	call   1500 <strlen>
     7f2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     7f5:	50                   	push   %eax
     7f6:	52                   	push   %edx
     7f7:	56                   	push   %esi
     7f8:	56                   	push   %esi
     7f9:	e8 52 ff ff ff       	call   750 <substr>
}
     7fe:	83 c4 20             	add    $0x20,%esp
     801:	8d 65 f4             	lea    -0xc(%ebp),%esp
     804:	5b                   	pop    %ebx
     805:	5e                   	pop    %esi
     806:	5f                   	pop    %edi
     807:	5d                   	pop    %ebp
     808:	c3                   	ret    
     809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000810 <collectRange>:
int collectRange(char* args, int* startptr, int* endptr) {
     810:	55                   	push   %ebp
     811:	89 e5                	mov    %esp,%ebp
     813:	57                   	push   %edi
     814:	56                   	push   %esi
     815:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     816:	31 f6                	xor    %esi,%esi
int collectRange(char* args, int* startptr, int* endptr) {
     818:	83 ec 2c             	sub    $0x2c,%esp
     81b:	8b 5d 08             	mov    0x8(%ebp),%ebx
     81e:	eb 09                	jmp    829 <collectRange+0x19>
    if (str[i] == c) return i;
     820:	80 3c 33 3a          	cmpb   $0x3a,(%ebx,%esi,1)
     824:	74 42                	je     868 <collectRange+0x58>
  for (int i = 0; i < strlen(str); i++)
     826:	83 c6 01             	add    $0x1,%esi
     829:	83 ec 0c             	sub    $0xc,%esp
     82c:	53                   	push   %ebx
     82d:	e8 ce 0c 00 00       	call   1500 <strlen>
     832:	83 c4 10             	add    $0x10,%esp
     835:	39 c6                	cmp    %eax,%esi
     837:	72 e7                	jb     820 <collectRange+0x10>
    if (args[0] == '-') {
     839:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     83c:	0f 84 d6 00 00 00    	je     918 <collectRange+0x108>
      *startptr = atoi(args);
     842:	83 ec 0c             	sub    $0xc,%esp
     845:	53                   	push   %ebx
     846:	e8 15 0e 00 00       	call   1660 <atoi>
     84b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     84e:	83 c4 10             	add    $0x10,%esp
     851:	89 01                	mov    %eax,(%ecx)
    *endptr = *startptr;
     853:	8b 4d 10             	mov    0x10(%ebp),%ecx
     856:	89 01                	mov    %eax,(%ecx)
    return 0;
     858:	31 c0                	xor    %eax,%eax
}
     85a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     85d:	5b                   	pop    %ebx
     85e:	5e                   	pop    %esi
     85f:	5f                   	pop    %edi
     860:	5d                   	pop    %ebp
     861:	c3                   	ret    
     862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  getArg(startstr, args, ':');
     868:	8d 75 de             	lea    -0x22(%ebp),%esi
     86b:	83 ec 04             	sub    $0x4,%esp
     86e:	6a 3a                	push   $0x3a
     870:	53                   	push   %ebx
     871:	56                   	push   %esi
     872:	e8 29 ff ff ff       	call   7a0 <getArg>
  if (startstr[0] == '-') {
     877:	83 c4 10             	add    $0x10,%esp
     87a:	80 7d de 2d          	cmpb   $0x2d,-0x22(%ebp)
     87e:	0f 84 3c 01 00 00    	je     9c0 <collectRange+0x1b0>
  int negStartFlag = 0, negEndFlag = 0;
     884:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     88b:	31 ff                	xor    %edi,%edi
  if (endstr[0] == '-') {
     88d:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     890:	0f 84 0a 01 00 00    	je     9a0 <collectRange+0x190>
  if (strcmp(startstr, "\0") == 0) *startptr = 1;
     896:	83 ec 08             	sub    $0x8,%esp
     899:	68 18 1c 00 00       	push   $0x1c18
     89e:	56                   	push   %esi
     89f:	e8 0c 0c 00 00       	call   14b0 <strcmp>
     8a4:	83 c4 10             	add    $0x10,%esp
     8a7:	85 c0                	test   %eax,%eax
     8a9:	0f 85 d1 00 00 00    	jne    980 <collectRange+0x170>
     8af:	8b 45 0c             	mov    0xc(%ebp),%eax
     8b2:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  if (strcmp(endstr, "\0") == 0) *endptr = -1;
     8b8:	83 ec 08             	sub    $0x8,%esp
     8bb:	68 18 1c 00 00       	push   $0x1c18
     8c0:	53                   	push   %ebx
     8c1:	e8 ea 0b 00 00       	call   14b0 <strcmp>
     8c6:	83 c4 10             	add    $0x10,%esp
     8c9:	85 c0                	test   %eax,%eax
     8cb:	0f 85 97 00 00 00    	jne    968 <collectRange+0x158>
     8d1:	8b 45 10             	mov    0x10(%ebp),%eax
     8d4:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  if (negStartFlag) *startptr = 0 - *startptr;
     8da:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     8dd:	85 c0                	test   %eax,%eax
     8df:	74 05                	je     8e6 <collectRange+0xd6>
     8e1:	8b 45 0c             	mov    0xc(%ebp),%eax
     8e4:	f7 18                	negl   (%eax)
  if (negEndFlag) *endptr = 0 - *endptr;
     8e6:	85 ff                	test   %edi,%edi
     8e8:	74 05                	je     8ef <collectRange+0xdf>
     8ea:	8b 45 10             	mov    0x10(%ebp),%eax
     8ed:	f7 18                	negl   (%eax)
  if (((*startptr > 0 && *endptr > 0) || 
     8ef:	8b 45 0c             	mov    0xc(%ebp),%eax
     8f2:	8b 00                	mov    (%eax),%eax
     8f4:	83 f8 00             	cmp    $0x0,%eax
     8f7:	7e 4f                	jle    948 <collectRange+0x138>
     8f9:	8b 55 10             	mov    0x10(%ebp),%edx
     8fc:	8b 12                	mov    (%edx),%edx
     8fe:	85 d2                	test   %edx,%edx
     900:	7e 55                	jle    957 <collectRange+0x147>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     902:	39 d0                	cmp    %edx,%eax
     904:	0f 9f c0             	setg   %al
}
     907:	8d 65 f4             	lea    -0xc(%ebp),%esp
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     90a:	0f b6 c0             	movzbl %al,%eax
}
     90d:	5b                   	pop    %ebx
     90e:	5e                   	pop    %esi
     90f:	5f                   	pop    %edi
     910:	5d                   	pop    %ebp
     911:	c3                   	ret    
     912:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      substr(args, args, 1, strlen(args));
     918:	83 ec 0c             	sub    $0xc,%esp
     91b:	53                   	push   %ebx
     91c:	e8 df 0b 00 00       	call   1500 <strlen>
     921:	50                   	push   %eax
     922:	6a 01                	push   $0x1
     924:	53                   	push   %ebx
     925:	53                   	push   %ebx
     926:	e8 25 fe ff ff       	call   750 <substr>
      *startptr = 0 - atoi(args);
     92b:	83 c4 14             	add    $0x14,%esp
     92e:	53                   	push   %ebx
     92f:	e8 2c 0d 00 00       	call   1660 <atoi>
     934:	8b 7d 0c             	mov    0xc(%ebp),%edi
     937:	f7 d8                	neg    %eax
     939:	83 c4 10             	add    $0x10,%esp
     93c:	89 07                	mov    %eax,(%edi)
     93e:	e9 10 ff ff ff       	jmp    853 <collectRange+0x43>
     943:	90                   	nop
     944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (((*startptr > 0 && *endptr > 0) || 
     948:	0f 84 0c ff ff ff    	je     85a <collectRange+0x4a>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     94e:	8b 7d 10             	mov    0x10(%ebp),%edi
     951:	8b 17                	mov    (%edi),%edx
     953:	85 d2                	test   %edx,%edx
     955:	78 ab                	js     902 <collectRange+0xf2>
}
     957:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
     95a:	31 c0                	xor    %eax,%eax
}
     95c:	5b                   	pop    %ebx
     95d:	5e                   	pop    %esi
     95e:	5f                   	pop    %edi
     95f:	5d                   	pop    %ebp
     960:	c3                   	ret    
     961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else *endptr = atoi(endstr);
     968:	83 ec 0c             	sub    $0xc,%esp
     96b:	53                   	push   %ebx
     96c:	e8 ef 0c 00 00       	call   1660 <atoi>
     971:	8b 55 10             	mov    0x10(%ebp),%edx
     974:	83 c4 10             	add    $0x10,%esp
     977:	89 02                	mov    %eax,(%edx)
     979:	e9 5c ff ff ff       	jmp    8da <collectRange+0xca>
     97e:	66 90                	xchg   %ax,%ax
  else *startptr = atoi(startstr);
     980:	83 ec 0c             	sub    $0xc,%esp
     983:	56                   	push   %esi
     984:	e8 d7 0c 00 00       	call   1660 <atoi>
     989:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     98c:	83 c4 10             	add    $0x10,%esp
     98f:	89 01                	mov    %eax,(%ecx)
     991:	e9 22 ff ff ff       	jmp    8b8 <collectRange+0xa8>
     996:	8d 76 00             	lea    0x0(%esi),%esi
     999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    substr(endstr, endstr, 1, strlen(endstr));
     9a0:	83 ec 0c             	sub    $0xc,%esp
    negEndFlag = 1;
     9a3:	bf 01 00 00 00       	mov    $0x1,%edi
    substr(endstr, endstr, 1, strlen(endstr));
     9a8:	53                   	push   %ebx
     9a9:	e8 52 0b 00 00       	call   1500 <strlen>
     9ae:	50                   	push   %eax
     9af:	6a 01                	push   $0x1
     9b1:	53                   	push   %ebx
     9b2:	53                   	push   %ebx
     9b3:	e8 98 fd ff ff       	call   750 <substr>
     9b8:	83 c4 20             	add    $0x20,%esp
     9bb:	e9 d6 fe ff ff       	jmp    896 <collectRange+0x86>
    substr(startstr, startstr, 1, strlen(startstr));
     9c0:	83 ec 0c             	sub    $0xc,%esp
     9c3:	56                   	push   %esi
     9c4:	e8 37 0b 00 00       	call   1500 <strlen>
     9c9:	50                   	push   %eax
     9ca:	6a 01                	push   $0x1
     9cc:	56                   	push   %esi
     9cd:	56                   	push   %esi
     9ce:	e8 7d fd ff ff       	call   750 <substr>
     9d3:	83 c4 20             	add    $0x20,%esp
    negStartFlag = 1;
     9d6:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
     9dd:	e9 a9 fe ff ff       	jmp    88b <collectRange+0x7b>
     9e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     9e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009f0 <negatoi>:


// standard str helps
int negatoi(char* str) {
     9f0:	55                   	push   %ebp
     9f1:	89 e5                	mov    %esp,%ebp
     9f3:	53                   	push   %ebx
     9f4:	83 ec 04             	sub    $0x4,%esp
     9f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (str[0] == '-') {
     9fa:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     9fd:	74 11                	je     a10 <negatoi+0x20>
    substr(str, str, 1, strlen(str));
    return 0 - atoi(str);
  }
  return atoi(str);
}
     9ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a02:	c9                   	leave  
  return atoi(str);
     a03:	e9 58 0c 00 00       	jmp    1660 <atoi>
     a08:	90                   	nop
     a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    substr(str, str, 1, strlen(str));
     a10:	83 ec 0c             	sub    $0xc,%esp
     a13:	53                   	push   %ebx
     a14:	e8 e7 0a 00 00       	call   1500 <strlen>
     a19:	50                   	push   %eax
     a1a:	6a 01                	push   $0x1
     a1c:	53                   	push   %ebx
     a1d:	53                   	push   %ebx
     a1e:	e8 2d fd ff ff       	call   750 <substr>
    return 0 - atoi(str);
     a23:	83 c4 14             	add    $0x14,%esp
     a26:	53                   	push   %ebx
     a27:	e8 34 0c 00 00       	call   1660 <atoi>
     a2c:	83 c4 10             	add    $0x10,%esp
     a2f:	f7 d8                	neg    %eax
}
     a31:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a34:	c9                   	leave  
     a35:	c3                   	ret    
     a36:	8d 76 00             	lea    0x0(%esi),%esi
     a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a40 <toUpper>:

void toUpper(char* str) {
     a40:	55                   	push   %ebp
     a41:	89 e5                	mov    %esp,%ebp
     a43:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     a46:	0f b6 02             	movzbl (%edx),%eax
     a49:	84 c0                	test   %al,%al
     a4b:	74 1a                	je     a67 <toUpper+0x27>
     a4d:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'z' && c >= 'a')
     a50:	8d 48 9f             	lea    -0x61(%eax),%ecx
     a53:	80 f9 19             	cmp    $0x19,%cl
     a56:	77 05                	ja     a5d <toUpper+0x1d>
      str[i] += ('Z' - 'z');
     a58:	83 e8 20             	sub    $0x20,%eax
     a5b:	88 02                	mov    %al,(%edx)
     a5d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     a60:	0f b6 02             	movzbl (%edx),%eax
     a63:	84 c0                	test   %al,%al
     a65:	75 e9                	jne    a50 <toUpper+0x10>
    i++;  
  }
}
     a67:	5d                   	pop    %ebp
     a68:	c3                   	ret    
     a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a70 <toLower>:

void toLower(char* str) {
     a70:	55                   	push   %ebp
     a71:	89 e5                	mov    %esp,%ebp
     a73:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     a76:	0f b6 02             	movzbl (%edx),%eax
     a79:	84 c0                	test   %al,%al
     a7b:	74 1a                	je     a97 <toLower+0x27>
     a7d:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'Z' && c >= 'A')
     a80:	8d 48 bf             	lea    -0x41(%eax),%ecx
     a83:	80 f9 19             	cmp    $0x19,%cl
     a86:	77 05                	ja     a8d <toLower+0x1d>
      str[i] -= ('Z' - 'z');
     a88:	83 c0 20             	add    $0x20,%eax
     a8b:	88 02                	mov    %al,(%edx)
     a8d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     a90:	0f b6 02             	movzbl (%edx),%eax
     a93:	84 c0                	test   %al,%al
     a95:	75 e9                	jne    a80 <toLower+0x10>
    i++;  
  }
}
     a97:	5d                   	pop    %ebp
     a98:	c3                   	ret    
     a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000aa0 <lineAt>:

// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
     aa0:	55                   	push   %ebp
     aa1:	89 e5                	mov    %esp,%ebp
  return nodeAt(list, pos-1);
     aa3:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
}
     aa7:	5d                   	pop    %ebp
  return nodeAt(list, pos-1);
     aa8:	e9 e3 f7 ff ff       	jmp    290 <nodeAt>
     aad:	8d 76 00             	lea    0x0(%esi),%esi

00000ab0 <printl>:

void printl(int lineNum, char* line) {
     ab0:	55                   	push   %ebp
     ab1:	89 e5                	mov    %esp,%ebp
     ab3:	83 ec 08             	sub    $0x8,%esp
     ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  if (lineNum < 10)
     ab9:	83 f8 09             	cmp    $0x9,%eax
     abc:	7e 3a                	jle    af8 <printl+0x48>
    fprintf(2, "%d  : %s\n", lineNum, line);
  else if (lineNum < 100)
     abe:	83 f8 63             	cmp    $0x63,%eax
     ac1:	7e 1d                	jle    ae0 <printl+0x30>
    fprintf(2, "%d : %s\n", lineNum, line);
  else
    fprintf(2, "%d: %s\n", lineNum, line);
     ac3:	ff 75 0c             	pushl  0xc(%ebp)
     ac6:	50                   	push   %eax
     ac7:	68 2d 1c 00 00       	push   $0x1c2d
     acc:	6a 02                	push   $0x2
     ace:	e8 7d 0f 00 00       	call   1a50 <fprintf>
     ad3:	83 c4 10             	add    $0x10,%esp
}
     ad6:	c9                   	leave  
     ad7:	c3                   	ret    
     ad8:	90                   	nop
     ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "%d : %s\n", lineNum, line);
     ae0:	ff 75 0c             	pushl  0xc(%ebp)
     ae3:	50                   	push   %eax
     ae4:	68 24 1c 00 00       	push   $0x1c24
     ae9:	6a 02                	push   $0x2
     aeb:	e8 60 0f 00 00       	call   1a50 <fprintf>
     af0:	83 c4 10             	add    $0x10,%esp
}
     af3:	c9                   	leave  
     af4:	c3                   	ret    
     af5:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "%d  : %s\n", lineNum, line);
     af8:	ff 75 0c             	pushl  0xc(%ebp)
     afb:	50                   	push   %eax
     afc:	68 1a 1c 00 00       	push   $0x1c1a
     b01:	6a 02                	push   $0x2
     b03:	e8 48 0f 00 00       	call   1a50 <fprintf>
     b08:	83 c4 10             	add    $0x10,%esp
}
     b0b:	c9                   	leave  
     b0c:	c3                   	ret    
     b0d:	8d 76 00             	lea    0x0(%esi),%esi

00000b10 <printpad>:

// prints the string with padding of a certain character
void printpad(int pad, char padChar, char* str, int alignment, int endLine) {
     b10:	55                   	push   %ebp
     b11:	89 e5                	mov    %esp,%ebp
     b13:	57                   	push   %edi
     b14:	56                   	push   %esi
     b15:	53                   	push   %ebx
     b16:	83 ec 28             	sub    $0x28,%esp
     b19:	8b 45 0c             	mov    0xc(%ebp),%eax
     b1c:	8b 7d 10             	mov    0x10(%ebp),%edi
     b1f:	8b 5d 08             	mov    0x8(%ebp),%ebx
     b22:	8b 75 14             	mov    0x14(%ebp),%esi
     b25:	89 45 e0             	mov    %eax,-0x20(%ebp)
     b28:	8b 45 18             	mov    0x18(%ebp),%eax
  int len = strlen(str);
     b2b:	57                   	push   %edi
void printpad(int pad, char padChar, char* str, int alignment, int endLine) {
     b2c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int len = strlen(str);
     b2f:	e8 cc 09 00 00       	call   1500 <strlen>
  int i = pad - len;
  if (alignment == LEFT) {
     b34:	83 c4 10             	add    $0x10,%esp
  int i = pad - len;
     b37:	29 c3                	sub    %eax,%ebx
  if (alignment == LEFT) {
     b39:	85 f6                	test   %esi,%esi
     b3b:	74 7b                	je     bb8 <printpad+0xa8>
    printf("%s", str);
    for (; i > 0; i--)
      printf("%c", padChar);
  } else if (alignment == RIGHT) {
     b3d:	83 fe 02             	cmp    $0x2,%esi
     b40:	74 1e                	je     b60 <printpad+0x50>
    for (; i > 0; i--)
      printf("%c", padChar);
    printf("%s", str);
  } else if (alignment == CENTER) {
     b42:	83 fe 01             	cmp    $0x1,%esi
     b45:	0f 84 ad 00 00 00    	je     bf8 <printpad+0xe8>
      printf("%c", padChar);
      if (i == half)
        printf("%s", str);
    }
  }
  if (endLine) {
     b4b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b4e:	85 c0                	test   %eax,%eax
     b50:	75 4c                	jne    b9e <printpad+0x8e>
    printf("\n");
  }
     b52:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b55:	5b                   	pop    %ebx
     b56:	5e                   	pop    %esi
     b57:	5f                   	pop    %edi
     b58:	5d                   	pop    %ebp
     b59:	c3                   	ret    
     b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for (; i > 0; i--)
     b60:	85 db                	test   %ebx,%ebx
     b62:	7e 22                	jle    b86 <printpad+0x76>
     b64:	0f be 75 e0          	movsbl -0x20(%ebp),%esi
     b68:	90                   	nop
     b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printf("%c", padChar);
     b70:	83 ec 08             	sub    $0x8,%esp
     b73:	56                   	push   %esi
     b74:	68 38 1c 00 00       	push   $0x1c38
     b79:	e8 f2 0e 00 00       	call   1a70 <printf>
    for (; i > 0; i--)
     b7e:	83 c4 10             	add    $0x10,%esp
     b81:	83 eb 01             	sub    $0x1,%ebx
     b84:	75 ea                	jne    b70 <printpad+0x60>
    printf("%s", str);
     b86:	83 ec 08             	sub    $0x8,%esp
     b89:	57                   	push   %edi
     b8a:	68 35 1c 00 00       	push   $0x1c35
     b8f:	e8 dc 0e 00 00       	call   1a70 <printf>
  if (endLine) {
     b94:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b97:	83 c4 10             	add    $0x10,%esp
     b9a:	85 c0                	test   %eax,%eax
     b9c:	74 b4                	je     b52 <printpad+0x42>
    printf("\n");
     b9e:	c7 45 08 9e 1c 00 00 	movl   $0x1c9e,0x8(%ebp)
     ba5:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ba8:	5b                   	pop    %ebx
     ba9:	5e                   	pop    %esi
     baa:	5f                   	pop    %edi
     bab:	5d                   	pop    %ebp
    printf("\n");
     bac:	e9 bf 0e 00 00       	jmp    1a70 <printf>
     bb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    printf("%s", str);
     bb8:	83 ec 08             	sub    $0x8,%esp
     bbb:	57                   	push   %edi
     bbc:	68 35 1c 00 00       	push   $0x1c35
     bc1:	e8 aa 0e 00 00       	call   1a70 <printf>
    for (; i > 0; i--)
     bc6:	83 c4 10             	add    $0x10,%esp
     bc9:	85 db                	test   %ebx,%ebx
     bcb:	0f 8e 7a ff ff ff    	jle    b4b <printpad+0x3b>
     bd1:	0f be 75 e0          	movsbl -0x20(%ebp),%esi
     bd5:	8d 76 00             	lea    0x0(%esi),%esi
      printf("%c", padChar);
     bd8:	83 ec 08             	sub    $0x8,%esp
     bdb:	56                   	push   %esi
     bdc:	68 38 1c 00 00       	push   $0x1c38
     be1:	e8 8a 0e 00 00       	call   1a70 <printf>
    for (; i > 0; i--)
     be6:	83 c4 10             	add    $0x10,%esp
     be9:	83 eb 01             	sub    $0x1,%ebx
     bec:	75 ea                	jne    bd8 <printpad+0xc8>
     bee:	e9 58 ff ff ff       	jmp    b4b <printpad+0x3b>
     bf3:	90                   	nop
     bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int half = i / 2;
     bf8:	89 d8                	mov    %ebx,%eax
     bfa:	c1 e8 1f             	shr    $0x1f,%eax
     bfd:	01 d8                	add    %ebx,%eax
     bff:	d1 f8                	sar    %eax
    for (; i > 0; i--) {
     c01:	85 db                	test   %ebx,%ebx
    int half = i / 2;
     c03:	89 45 dc             	mov    %eax,-0x24(%ebp)
    for (; i > 0; i--) {
     c06:	0f 8e 3f ff ff ff    	jle    b4b <printpad+0x3b>
     c0c:	0f be 75 e0          	movsbl -0x20(%ebp),%esi
     c10:	eb 0f                	jmp    c21 <printpad+0x111>
     c12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     c18:	83 eb 01             	sub    $0x1,%ebx
     c1b:	0f 84 2a ff ff ff    	je     b4b <printpad+0x3b>
      printf("%c", padChar);
     c21:	83 ec 08             	sub    $0x8,%esp
     c24:	56                   	push   %esi
     c25:	68 38 1c 00 00       	push   $0x1c38
     c2a:	e8 41 0e 00 00       	call   1a70 <printf>
      if (i == half)
     c2f:	83 c4 10             	add    $0x10,%esp
     c32:	39 5d dc             	cmp    %ebx,-0x24(%ebp)
     c35:	75 e1                	jne    c18 <printpad+0x108>
        printf("%s", str);
     c37:	83 ec 08             	sub    $0x8,%esp
     c3a:	57                   	push   %edi
     c3b:	68 35 1c 00 00       	push   $0x1c35
     c40:	e8 2b 0e 00 00       	call   1a70 <printf>
     c45:	83 c4 10             	add    $0x10,%esp
     c48:	eb ce                	jmp    c18 <printpad+0x108>
     c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000c50 <forward>:
void forward(File file, Terminal terminal){
     c50:	55                   	push   %ebp
     c51:	89 e5                	mov    %esp,%ebp
  printpad(terminal.width, ' ', msg, LEFT, 0);
     c53:	8b 45 24             	mov    0x24(%ebp),%eax
     c56:	c7 45 18 00 00 00 00 	movl   $0x0,0x18(%ebp)
     c5d:	c7 45 14 00 00 00 00 	movl   $0x0,0x14(%ebp)
     c64:	c7 45 10 3b 1c 00 00 	movl   $0x1c3b,0x10(%ebp)
     c6b:	c7 45 0c 20 00 00 00 	movl   $0x20,0xc(%ebp)
     c72:	89 45 08             	mov    %eax,0x8(%ebp)
}
     c75:	5d                   	pop    %ebp
  printpad(terminal.width, ' ', msg, LEFT, 0);
     c76:	e9 95 fe ff ff       	jmp    b10 <printpad>
     c7b:	90                   	nop
     c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000c80 <fastforward>:
void fastforward(File file, Terminal terminal){
     c80:	55                   	push   %ebp
     c81:	89 e5                	mov    %esp,%ebp
  printpad(terminal.width, ' ', msg, LEFT, 0);
     c83:	8b 45 24             	mov    0x24(%ebp),%eax
     c86:	c7 45 18 00 00 00 00 	movl   $0x0,0x18(%ebp)
     c8d:	c7 45 14 00 00 00 00 	movl   $0x0,0x14(%ebp)
     c94:	c7 45 10 47 1c 00 00 	movl   $0x1c47,0x10(%ebp)
     c9b:	c7 45 0c 20 00 00 00 	movl   $0x20,0xc(%ebp)
     ca2:	89 45 08             	mov    %eax,0x8(%ebp)
}
     ca5:	5d                   	pop    %ebp
  printpad(terminal.width, ' ', msg, LEFT, 0);
     ca6:	e9 65 fe ff ff       	jmp    b10 <printpad>
     cab:	90                   	nop
     cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000cb0 <back>:
void back(File file, Terminal terminal){
     cb0:	55                   	push   %ebp
     cb1:	89 e5                	mov    %esp,%ebp
  printpad(terminal.width, ' ', msg, LEFT, 0);
     cb3:	8b 45 24             	mov    0x24(%ebp),%eax
     cb6:	c7 45 18 00 00 00 00 	movl   $0x0,0x18(%ebp)
     cbd:	c7 45 14 00 00 00 00 	movl   $0x0,0x14(%ebp)
     cc4:	c7 45 10 57 1c 00 00 	movl   $0x1c57,0x10(%ebp)
     ccb:	c7 45 0c 20 00 00 00 	movl   $0x20,0xc(%ebp)
     cd2:	89 45 08             	mov    %eax,0x8(%ebp)
}
     cd5:	5d                   	pop    %ebp
  printpad(terminal.width, ' ', msg, LEFT, 0);
     cd6:	e9 35 fe ff ff       	jmp    b10 <printpad>
     cdb:	90                   	nop
     cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ce0 <scroll>:
void scroll(File file, Terminal terminal){
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
  printpad(terminal.width, ' ', msg, LEFT, 0);
     ce3:	8b 45 24             	mov    0x24(%ebp),%eax
     ce6:	c7 45 18 00 00 00 00 	movl   $0x0,0x18(%ebp)
     ced:	c7 45 14 00 00 00 00 	movl   $0x0,0x14(%ebp)
     cf4:	c7 45 10 60 1c 00 00 	movl   $0x1c60,0x10(%ebp)
     cfb:	c7 45 0c 20 00 00 00 	movl   $0x20,0xc(%ebp)
     d02:	89 45 08             	mov    %eax,0x8(%ebp)
}
     d05:	5d                   	pop    %ebp
  printpad(terminal.width, ' ', msg, LEFT, 0);
     d06:	e9 05 fe ff ff       	jmp    b10 <printpad>
     d0b:	90                   	nop
     d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d10 <line>:
void line(File file, Terminal terminal){
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
  printpad(terminal.width, ' ', msg, LEFT, 0);
     d13:	8b 45 24             	mov    0x24(%ebp),%eax
     d16:	c7 45 18 00 00 00 00 	movl   $0x0,0x18(%ebp)
     d1d:	c7 45 14 00 00 00 00 	movl   $0x0,0x14(%ebp)
     d24:	c7 45 10 6b 1c 00 00 	movl   $0x1c6b,0x10(%ebp)
     d2b:	c7 45 0c 20 00 00 00 	movl   $0x20,0xc(%ebp)
     d32:	89 45 08             	mov    %eax,0x8(%ebp)
}
     d35:	5d                   	pop    %ebp
  printpad(terminal.width, ' ', msg, LEFT, 0);
     d36:	e9 d5 fd ff ff       	jmp    b10 <printpad>
     d3b:	90                   	nop
     d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d40 <help>:
void help(Terminal terminal) {
     d40:	55                   	push   %ebp
     d41:	89 e5                	mov    %esp,%ebp
     d43:	53                   	push   %ebx
     d44:	83 ec 10             	sub    $0x10,%esp
     d47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printpad(terminal.width, '-', "-", LEFT, 1);
     d4a:	6a 01                	push   $0x1
     d4c:	6a 00                	push   $0x0
     d4e:	68 74 1c 00 00       	push   $0x1c74
     d53:	6a 2d                	push   $0x2d
     d55:	53                   	push   %ebx
     d56:	e8 b5 fd ff ff       	call   b10 <printpad>
  printf("<space>                 Display next k lines of text [current screen size]\n");
     d5b:	83 c4 14             	add    $0x14,%esp
     d5e:	68 34 1d 00 00       	push   $0x1d34
     d63:	e8 08 0d 00 00       	call   1a70 <printf>
  printf("z                       Display next k lines of text [current screen size]*\n");
     d68:	c7 04 24 80 1d 00 00 	movl   $0x1d80,(%esp)
     d6f:	e8 fc 0c 00 00       	call   1a70 <printf>
  printf("<return>                Display next k lines of text [1]*\n");
     d74:	c7 04 24 d0 1d 00 00 	movl   $0x1dd0,(%esp)
     d7b:	e8 f0 0c 00 00       	call   1a70 <printf>
  printf("e                       Display next k lines of text [1]*\n");
     d80:	c7 04 24 0c 1e 00 00 	movl   $0x1e0c,(%esp)
     d87:	e8 e4 0c 00 00       	call   1a70 <printf>
  // printf("d or ctrl-D             Scroll k lines [current scroll size, initially 11]*\n");
  printf("q or Q or <interrupt>   Exit from more\n");
     d8c:	c7 04 24 48 1e 00 00 	movl   $0x1e48,(%esp)
     d93:	e8 d8 0c 00 00       	call   1a70 <printf>
  printf("f                       Skip forward 1 screenful of text\n");
     d98:	c7 04 24 70 1e 00 00 	movl   $0x1e70,(%esp)
     d9f:	e8 cc 0c 00 00       	call   1a70 <printf>
  printf("b or B                  Skip backwards 1 screenful of text\n");
     da4:	c7 04 24 ac 1e 00 00 	movl   $0x1eac,(%esp)
     dab:	e8 c0 0c 00 00       	call   1a70 <printf>
  printf("=                       Display current line number\n");
     db0:	c7 04 24 e8 1e 00 00 	movl   $0x1ee8,(%esp)
     db7:	e8 b4 0c 00 00       	call   1a70 <printf>
  // printf("v                       Start up /usr/bin/vi at current line\n");
  printf("l or L                  Redraw screen\n");
     dbc:	c7 04 24 20 1f 00 00 	movl   $0x1f20,(%esp)
     dc3:	e8 a8 0c 00 00       	call   1a70 <printf>
  // printf(".                       Repeat previous command\n");
  printpad(terminal.width, '-', "-", LEFT, 1);
     dc8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     dcf:	6a 00                	push   $0x0
     dd1:	68 74 1c 00 00       	push   $0x1c74
     dd6:	6a 2d                	push   $0x2d
     dd8:	53                   	push   %ebx
     dd9:	e8 32 fd ff ff       	call   b10 <printpad>
}
     dde:	83 c4 20             	add    $0x20,%esp
     de1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     de4:	c9                   	leave  
     de5:	c3                   	ret    
     de6:	8d 76 00             	lea    0x0(%esi),%esi
     de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000df0 <printPrompt>:

// help
void printPrompt(File file) {
     df0:	55                   	push   %ebp
     df1:	89 e5                	mov    %esp,%ebp
     df3:	83 ec 10             	sub    $0x10,%esp
  printf("\n--MORE--(%d%%)", 100 * file.curLine / file.len);
     df6:	6b 45 10 64          	imul   $0x64,0x10(%ebp),%eax
     dfa:	99                   	cltd   
     dfb:	f7 7d 1c             	idivl  0x1c(%ebp)
     dfe:	50                   	push   %eax
     dff:	68 76 1c 00 00       	push   $0x1c76
     e04:	e8 67 0c 00 00       	call   1a70 <printf>
  printf("[Press space to continue, 'q' to quit.]\r");
     e09:	83 c4 10             	add    $0x10,%esp
     e0c:	c7 45 08 48 1f 00 00 	movl   $0x1f48,0x8(%ebp)
}
     e13:	c9                   	leave  
  printf("[Press space to continue, 'q' to quit.]\r");
     e14:	e9 57 0c 00 00       	jmp    1a70 <printf>
     e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000e20 <showPage>:

void showPage(File file, Terminal terminal) {
     e20:	55                   	push   %ebp
     e21:	89 e5                	mov    %esp,%ebp
     e23:	57                   	push   %edi
     e24:	56                   	push   %esi
     e25:	53                   	push   %ebx
     e26:	83 ec 1c             	sub    $0x1c,%esp
     e29:	8b 45 24             	mov    0x24(%ebp),%eax
     e2c:	8b 75 10             	mov    0x10(%ebp),%esi
     e2f:	89 45 dc             	mov    %eax,-0x24(%ebp)
     e32:	8b 45 28             	mov    0x28(%ebp),%eax
     e35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     e38:	8b 45 18             	mov    0x18(%ebp),%eax
     e3b:	89 c2                	mov    %eax,%edx
     e3d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  return nodeAt(list, pos-1);
     e40:	8d 46 ff             	lea    -0x1(%esi),%eax
     e43:	50                   	push   %eax
     e44:	52                   	push   %edx
     e45:	e8 46 f4 ff ff       	call   290 <nodeAt>
     e4a:	59                   	pop    %ecx
  // struct Node* cur = file.lines->head->next;
  struct Node* curNode = (lineAt(file.lines, file.curLine))->prev;
     e4b:	8b 38                	mov    (%eax),%edi
     e4d:	5b                   	pop    %ebx
  int termLine = 3; // num lines we've written to the terminal so far
     e4e:	bb 03 00 00 00       	mov    $0x3,%ebx
  int lineLen = 0;
  while (termLine < terminal.height) {
     e53:	eb 36                	jmp    e8b <showPage+0x6b>
     e55:	8d 76 00             	lea    0x0(%esi),%esi
    lineLen = strlen(curNode->data);
     e58:	83 ec 0c             	sub    $0xc,%esp
     e5b:	ff 77 04             	pushl  0x4(%edi)
     e5e:	83 c6 01             	add    $0x1,%esi
     e61:	e8 9a 06 00 00       	call   1500 <strlen>
    termLine += (lineLen / (terminal.width)) + 1;
     e66:	99                   	cltd   
     e67:	f7 7d dc             	idivl  -0x24(%ebp)
     e6a:	8d 5c 03 01          	lea    0x1(%ebx,%eax,1),%ebx
    printf("%s\n", curNode->data);
     e6e:	58                   	pop    %eax
     e6f:	5a                   	pop    %edx
     e70:	ff 77 04             	pushl  0x4(%edi)
     e73:	68 20 1c 00 00       	push   $0x1c20
     e78:	e8 f3 0b 00 00       	call   1a70 <printf>
    curNode = curNode->next;
    file.curLine ++;
    if (curNode == file.lines->tail) exit();
     e7d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    curNode = curNode->next;
     e80:	8b 7f 08             	mov    0x8(%edi),%edi
    if (curNode == file.lines->tail) exit();
     e83:	83 c4 10             	add    $0x10,%esp
     e86:	39 78 04             	cmp    %edi,0x4(%eax)
     e89:	74 30                	je     ebb <showPage+0x9b>
  while (termLine < terminal.height) {
     e8b:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
     e8e:	7c c8                	jl     e58 <showPage+0x38>
  printf("\n--MORE--(%d%%)", 100 * file.curLine / file.len);
     e90:	6b c6 64             	imul   $0x64,%esi,%eax
     e93:	83 ec 08             	sub    $0x8,%esp
     e96:	99                   	cltd   
     e97:	f7 7d 1c             	idivl  0x1c(%ebp)
     e9a:	50                   	push   %eax
     e9b:	68 76 1c 00 00       	push   $0x1c76
     ea0:	e8 cb 0b 00 00       	call   1a70 <printf>
  printf("[Press space to continue, 'q' to quit.]\r");
     ea5:	c7 45 08 48 1f 00 00 	movl   $0x1f48,0x8(%ebp)
     eac:	83 c4 10             	add    $0x10,%esp
  }
  printPrompt(file);  
}
     eaf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     eb2:	5b                   	pop    %ebx
     eb3:	5e                   	pop    %esi
     eb4:	5f                   	pop    %edi
     eb5:	5d                   	pop    %ebp
  printf("[Press space to continue, 'q' to quit.]\r");
     eb6:	e9 b5 0b 00 00       	jmp    1a70 <printf>
    if (curNode == file.lines->tail) exit();
     ebb:	e8 12 08 00 00       	call   16d2 <exit>

00000ec0 <end>:

// old commands
void end(struct File* file, char* args) {
     ec0:	55                   	push   %ebp
     ec1:	89 e5                	mov    %esp,%ebp
     ec3:	53                   	push   %ebx
     ec4:	83 ec 08             	sub    $0x8,%esp
     ec7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  file->edited = 1;
  char* line = args;
  append(file->lines, line);
     eca:	8b 43 10             	mov    0x10(%ebx),%eax
  file->edited = 1;
     ecd:	c7 43 18 01 00 00 00 	movl   $0x1,0x18(%ebx)
     ed4:	ff 70 08             	pushl  0x8(%eax)
     ed7:	ff 75 0c             	pushl  0xc(%ebp)
     eda:	50                   	push   %eax
     edb:	e8 d0 f4 ff ff       	call   3b0 <insert>
  file->len++;
     ee0:	83 43 14 01          	addl   $0x1,0x14(%ebx)
}
     ee4:	83 c4 10             	add    $0x10,%esp
     ee7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     eea:	c9                   	leave  
     eeb:	c3                   	ret    
     eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ef0 <add>:

void add(struct File* file, char* args) {
     ef0:	55                   	push   %ebp
     ef1:	89 e5                	mov    %esp,%ebp
     ef3:	57                   	push   %edi
     ef4:	56                   	push   %esi
     ef5:	53                   	push   %ebx
     ef6:	83 ec 28             	sub    $0x28,%esp
     ef9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     efc:	8b 75 0c             	mov    0xc(%ebp),%esi
  file->edited = 1;
     eff:	c7 43 18 01 00 00 00 	movl   $0x1,0x18(%ebx)
  if (strlen(args) < 1) {
     f06:	56                   	push   %esi
     f07:	e8 f4 05 00 00       	call   1500 <strlen>
     f0c:	83 c4 10             	add    $0x10,%esp
     f0f:	85 c0                	test   %eax,%eax
     f11:	74 3d                	je     f50 <add+0x60>
    fprintf(2, "you need to give a line number to insert before\n");
    return;
  }
  char lineStr[10];
  getArg(lineStr, args, ' ');
     f13:	8d 7d de             	lea    -0x22(%ebp),%edi
     f16:	83 ec 04             	sub    $0x4,%esp
     f19:	6a 20                	push   $0x20
     f1b:	56                   	push   %esi
     f1c:	57                   	push   %edi
     f1d:	e8 7e f8 ff ff       	call   7a0 <getArg>
  char* line = args;

  int lineNum = negatoi(lineStr);
     f22:	89 3c 24             	mov    %edi,(%esp)
     f25:	e8 c6 fa ff ff       	call   9f0 <negatoi>
  // 1-based to 0-based insert
  insert(file->lines, line, lineNum - 1);
     f2a:	83 c4 0c             	add    $0xc,%esp
     f2d:	83 e8 01             	sub    $0x1,%eax
     f30:	50                   	push   %eax
     f31:	56                   	push   %esi
     f32:	ff 73 10             	pushl  0x10(%ebx)
     f35:	e8 76 f4 ff ff       	call   3b0 <insert>
  file->len++;
     f3a:	83 43 14 01          	addl   $0x1,0x14(%ebx)
     f3e:	83 c4 10             	add    $0x10,%esp
}
     f41:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f44:	5b                   	pop    %ebx
     f45:	5e                   	pop    %esi
     f46:	5f                   	pop    %edi
     f47:	5d                   	pop    %ebp
     f48:	c3                   	ret    
     f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "you need to give a line number to insert before\n");
     f50:	83 ec 08             	sub    $0x8,%esp
     f53:	68 e8 1f 00 00       	push   $0x1fe8
     f58:	6a 02                	push   $0x2
     f5a:	e8 f1 0a 00 00       	call   1a50 <fprintf>
    return;
     f5f:	83 c4 10             	add    $0x10,%esp
}
     f62:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f65:	5b                   	pop    %ebx
     f66:	5e                   	pop    %esi
     f67:	5f                   	pop    %edi
     f68:	5d                   	pop    %ebp
     f69:	c3                   	ret    
     f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000f70 <drop>:

void drop(struct File* file, char* args) {
     f70:	55                   	push   %ebp
     f71:	89 e5                	mov    %esp,%ebp
     f73:	57                   	push   %edi
     f74:	56                   	push   %esi
     f75:	53                   	push   %ebx
     f76:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
     f79:	ff 75 0c             	pushl  0xc(%ebp)
void drop(struct File* file, char* args) {
     f7c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (strlen(args) < 1) {
     f7f:	e8 7c 05 00 00       	call   1500 <strlen>
     f84:	83 c4 10             	add    $0x10,%esp
     f87:	85 c0                	test   %eax,%eax
     f89:	0f 84 09 01 00 00    	je     1098 <drop+0x128>
    fprintf(2, "you need to give a range to drop\n");
    return;
  }

  int start, end;
  if (collectRange(args, &start, &end) == 1) {
     f8f:	8d 75 e4             	lea    -0x1c(%ebp),%esi
     f92:	8d 7d e0             	lea    -0x20(%ebp),%edi
     f95:	83 ec 04             	sub    $0x4,%esp
     f98:	56                   	push   %esi
     f99:	57                   	push   %edi
     f9a:	ff 75 0c             	pushl  0xc(%ebp)
     f9d:	e8 6e f8 ff ff       	call   810 <collectRange>
     fa2:	83 c4 10             	add    $0x10,%esp
     fa5:	83 f8 01             	cmp    $0x1,%eax
     fa8:	0f 84 0a 01 00 00    	je     10b8 <drop+0x148>
    fprintf(2, "error: start index is larger than end index\n");
    return;
  }
  if (normalizeRange(*file, &start, &end) == 1) {
     fae:	83 ec 0c             	sub    $0xc,%esp
     fb1:	56                   	push   %esi
     fb2:	57                   	push   %edi
     fb3:	ff 73 18             	pushl  0x18(%ebx)
     fb6:	ff 73 14             	pushl  0x14(%ebx)
     fb9:	ff 73 10             	pushl  0x10(%ebx)
     fbc:	ff 73 0c             	pushl  0xc(%ebx)
     fbf:	ff 73 08             	pushl  0x8(%ebx)
     fc2:	ff 73 04             	pushl  0x4(%ebx)
     fc5:	ff 33                	pushl  (%ebx)
     fc7:	e8 64 f5 ff ff       	call   530 <normalizeRange>
     fcc:	83 c4 30             	add    $0x30,%esp
     fcf:	83 f8 01             	cmp    $0x1,%eax
     fd2:	0f 84 18 01 00 00    	je     10f0 <drop+0x180>
    fprintf(2, "error: bad input range. make sure start < end\n");
    return;
  }
  int numl = numLines(start, end);
     fd8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     fdb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return (end - start) + 1;
     fde:	89 d6                	mov    %edx,%esi
     fe0:	29 c6                	sub    %eax,%esi
     fe2:	8d 7e 01             	lea    0x1(%esi),%edi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
     fe5:	83 ff 01             	cmp    $0x1,%edi
     fe8:	89 7d d4             	mov    %edi,-0x2c(%ebp)
     feb:	0f 84 e7 00 00 00    	je     10d8 <drop+0x168>
  else fprintf(2, "Drop %d lines [%d:%d] (y/n)? ", numl, start, end);
     ff1:	83 ec 0c             	sub    $0xc,%esp
     ff4:	52                   	push   %edx
     ff5:	50                   	push   %eax
     ff6:	ff 75 d4             	pushl  -0x2c(%ebp)
     ff9:	68 b5 1c 00 00       	push   $0x1cb5
     ffe:	6a 02                	push   $0x2
    1000:	e8 4b 0a 00 00       	call   1a50 <fprintf>
    1005:	83 c4 20             	add    $0x20,%esp
  if (confirmation() != 0) return;
    1008:	e8 c3 f4 ff ff       	call   4d0 <confirmation>
    100d:	85 c0                	test   %eax,%eax
    100f:	75 79                	jne    108a <drop+0x11a>
  return nodeAt(list, pos-1);
    1011:	8b 45 e0             	mov    -0x20(%ebp),%eax
  file->edited = 1;

  // drop lines
  struct Node* curNode = (lineAt(file->lines, start))->prev;
    1014:	8b 4b 10             	mov    0x10(%ebx),%ecx
    1017:	83 ec 08             	sub    $0x8,%esp
  file->edited = 1;
    101a:	c7 43 18 01 00 00 00 	movl   $0x1,0x18(%ebx)
    1021:	83 e8 01             	sub    $0x1,%eax
    1024:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    1027:	50                   	push   %eax
    1028:	51                   	push   %ecx
    1029:	e8 62 f2 ff ff       	call   290 <nodeAt>
  struct Node* curNode = (lineAt(file->lines, start))->prev;
    102e:	8b 30                	mov    (%eax),%esi
    1030:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1033:	5a                   	pop    %edx
    1034:	59                   	pop    %ecx
    1035:	8b 4d d0             	mov    -0x30(%ebp),%ecx
    1038:	83 e8 01             	sub    $0x1,%eax
    103b:	50                   	push   %eax
    103c:	51                   	push   %ecx
    103d:	e8 4e f2 ff ff       	call   290 <nodeAt>
    1042:	83 c4 10             	add    $0x10,%esp
  struct Node* stopNode = lineAt(file->lines, end);
  while (curNode != stopNode) {
    1045:	39 c6                	cmp    %eax,%esi
    1047:	89 c7                	mov    %eax,%edi
    1049:	8b 4d d0             	mov    -0x30(%ebp),%ecx
    104c:	75 05                	jne    1053 <drop+0xe3>
    104e:	eb 1b                	jmp    106b <drop+0xfb>
    1050:	8b 4b 10             	mov    0x10(%ebx),%ecx
    curNode = curNode->next;
    1053:	8b 76 08             	mov    0x8(%esi),%esi
    destroyNode(file->lines, curNode);
    1056:	83 ec 08             	sub    $0x8,%esp
    1059:	56                   	push   %esi
    105a:	51                   	push   %ecx
    105b:	e8 a0 f2 ff ff       	call   300 <destroyNode>
    file->len--;
    1060:	83 6b 14 01          	subl   $0x1,0x14(%ebx)
  while (curNode != stopNode) {
    1064:	83 c4 10             	add    $0x10,%esp
    1067:	39 fe                	cmp    %edi,%esi
    1069:	75 e5                	jne    1050 <drop+0xe0>
  }
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
    106b:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
    106f:	0f 84 93 00 00 00    	je     1108 <drop+0x198>
  else fprintf(2, "%d lines dropped\n", numl);
    1075:	83 ec 04             	sub    $0x4,%esp
    1078:	ff 75 d4             	pushl  -0x2c(%ebp)
    107b:	68 e4 1c 00 00       	push   $0x1ce4
    1080:	6a 02                	push   $0x2
    1082:	e8 c9 09 00 00       	call   1a50 <fprintf>
    1087:	83 c4 10             	add    $0x10,%esp
  return;
}
    108a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    108d:	5b                   	pop    %ebx
    108e:	5e                   	pop    %esi
    108f:	5f                   	pop    %edi
    1090:	5d                   	pop    %ebp
    1091:	c3                   	ret    
    1092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "you need to give a range to drop\n");
    1098:	83 ec 08             	sub    $0x8,%esp
    109b:	68 1c 20 00 00       	push   $0x201c
    10a0:	6a 02                	push   $0x2
    10a2:	e8 a9 09 00 00       	call   1a50 <fprintf>
    return;
    10a7:	83 c4 10             	add    $0x10,%esp
}
    10aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10ad:	5b                   	pop    %ebx
    10ae:	5e                   	pop    %esi
    10af:	5f                   	pop    %edi
    10b0:	5d                   	pop    %ebp
    10b1:	c3                   	ret    
    10b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: start index is larger than end index\n");
    10b8:	83 ec 08             	sub    $0x8,%esp
    10bb:	68 40 20 00 00       	push   $0x2040
    10c0:	6a 02                	push   $0x2
    10c2:	e8 89 09 00 00       	call   1a50 <fprintf>
    return;
    10c7:	83 c4 10             	add    $0x10,%esp
}
    10ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10cd:	5b                   	pop    %ebx
    10ce:	5e                   	pop    %esi
    10cf:	5f                   	pop    %edi
    10d0:	5d                   	pop    %ebp
    10d1:	c3                   	ret    
    10d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
    10d8:	83 ec 04             	sub    $0x4,%esp
    10db:	50                   	push   %eax
    10dc:	68 a0 1c 00 00       	push   $0x1ca0
    10e1:	6a 02                	push   $0x2
    10e3:	e8 68 09 00 00       	call   1a50 <fprintf>
    10e8:	83 c4 10             	add    $0x10,%esp
    10eb:	e9 18 ff ff ff       	jmp    1008 <drop+0x98>
    fprintf(2, "error: bad input range. make sure start < end\n");
    10f0:	83 ec 08             	sub    $0x8,%esp
    10f3:	68 70 20 00 00       	push   $0x2070
    10f8:	6a 02                	push   $0x2
    10fa:	e8 51 09 00 00       	call   1a50 <fprintf>
    return;
    10ff:	83 c4 10             	add    $0x10,%esp
    1102:	eb 86                	jmp    108a <drop+0x11a>
    1104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
    1108:	83 ec 04             	sub    $0x4,%esp
    110b:	ff 75 e0             	pushl  -0x20(%ebp)
    110e:	68 d3 1c 00 00       	push   $0x1cd3
    1113:	6a 02                	push   $0x2
    1115:	e8 36 09 00 00       	call   1a50 <fprintf>
    111a:	83 c4 10             	add    $0x10,%esp
    111d:	e9 68 ff ff ff       	jmp    108a <drop+0x11a>
    1122:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001130 <edit>:

void edit(struct File* file, char* args) {
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	57                   	push   %edi
    1134:	56                   	push   %esi
    1135:	53                   	push   %ebx
    1136:	83 ec 28             	sub    $0x28,%esp
    1139:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if (strlen(args) < 1) {
    113c:	53                   	push   %ebx
    113d:	e8 be 03 00 00       	call   1500 <strlen>
    1142:	83 c4 10             	add    $0x10,%esp
    1145:	85 c0                	test   %eax,%eax
    1147:	75 1f                	jne    1168 <edit+0x38>
    fprintf(2, "you need to give a line number to replace\n");
    1149:	83 ec 08             	sub    $0x8,%esp
    114c:	68 a0 20 00 00       	push   $0x20a0
    1151:	6a 02                	push   $0x2
    1153:	e8 f8 08 00 00       	call   1a50 <fprintf>
    return;
    1158:	83 c4 10             	add    $0x10,%esp

  // remove
  destroyNode(file->lines, lineAt(file->lines, lineNum));
  // 1-based to 0-based insert
  insert(file->lines, line, lineNum - 1);
}
    115b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    115e:	5b                   	pop    %ebx
    115f:	5e                   	pop    %esi
    1160:	5f                   	pop    %edi
    1161:	5d                   	pop    %ebp
    1162:	c3                   	ret    
    1163:	90                   	nop
    1164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  getArg(lineStr, args, ' ');
    1168:	8d 75 de             	lea    -0x22(%ebp),%esi
    116b:	83 ec 04             	sub    $0x4,%esp
    116e:	6a 20                	push   $0x20
    1170:	53                   	push   %ebx
    1171:	56                   	push   %esi
    1172:	e8 29 f6 ff ff       	call   7a0 <getArg>
  int lineNum = negatoi(lineStr);
    1177:	89 34 24             	mov    %esi,(%esp)
    117a:	e8 71 f8 ff ff       	call   9f0 <negatoi>
  fprintf(2, "replace line %d (y/n)? ", lineNum);
    117f:	83 c4 0c             	add    $0xc,%esp
  int lineNum = negatoi(lineStr);
    1182:	89 c6                	mov    %eax,%esi
  fprintf(2, "replace line %d (y/n)? ", lineNum);
    1184:	50                   	push   %eax
    1185:	68 f6 1c 00 00       	push   $0x1cf6
    118a:	6a 02                	push   $0x2
    118c:	e8 bf 08 00 00       	call   1a50 <fprintf>
  if (confirmation() != 0) return;
    1191:	e8 3a f3 ff ff       	call   4d0 <confirmation>
    1196:	83 c4 10             	add    $0x10,%esp
    1199:	85 c0                	test   %eax,%eax
    119b:	75 be                	jne    115b <edit+0x2b>
  file->edited = 1;
    119d:	8b 45 08             	mov    0x8(%ebp),%eax
    11a0:	83 ec 08             	sub    $0x8,%esp
    11a3:	83 ee 01             	sub    $0x1,%esi
  destroyNode(file->lines, lineAt(file->lines, lineNum));
    11a6:	8b 78 10             	mov    0x10(%eax),%edi
  file->edited = 1;
    11a9:	c7 40 18 01 00 00 00 	movl   $0x1,0x18(%eax)
    11b0:	56                   	push   %esi
    11b1:	57                   	push   %edi
    11b2:	e8 d9 f0 ff ff       	call   290 <nodeAt>
    11b7:	5a                   	pop    %edx
    11b8:	59                   	pop    %ecx
  destroyNode(file->lines, lineAt(file->lines, lineNum));
    11b9:	50                   	push   %eax
    11ba:	57                   	push   %edi
    11bb:	e8 40 f1 ff ff       	call   300 <destroyNode>
  insert(file->lines, line, lineNum - 1);
    11c0:	8b 45 08             	mov    0x8(%ebp),%eax
    11c3:	83 c4 0c             	add    $0xc,%esp
    11c6:	56                   	push   %esi
    11c7:	53                   	push   %ebx
    11c8:	ff 70 10             	pushl  0x10(%eax)
    11cb:	e8 e0 f1 ff ff       	call   3b0 <insert>
    11d0:	83 c4 10             	add    $0x10,%esp
}
    11d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11d6:	5b                   	pop    %ebx
    11d7:	5e                   	pop    %esi
    11d8:	5f                   	pop    %edi
    11d9:	5d                   	pop    %ebp
    11da:	c3                   	ret    
    11db:	90                   	nop
    11dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000011e0 <list>:

void list(struct File file, char* args) {
    11e0:	55                   	push   %ebp
    11e1:	89 e5                	mov    %esp,%ebp
    11e3:	57                   	push   %edi
    11e4:	56                   	push   %esi
    11e5:	53                   	push   %ebx
    11e6:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
    11e9:	ff 75 24             	pushl  0x24(%ebp)
    11ec:	8b 75 18             	mov    0x18(%ebp),%esi
    11ef:	e8 0c 03 00 00       	call   1500 <strlen>
    11f4:	83 c4 10             	add    $0x10,%esp
    11f7:	85 c0                	test   %eax,%eax
    11f9:	75 1d                	jne    1218 <list+0x38>
    fprintf(2, "you need to give a range to list\n");
    11fb:	83 ec 08             	sub    $0x8,%esp
    11fe:	68 cc 20 00 00       	push   $0x20cc
    1203:	6a 02                	push   $0x2
    1205:	e8 46 08 00 00       	call   1a50 <fprintf>
    return;
    120a:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
    curNode = curNode->next;
    if (curNode == file.lines->tail) return;
    printl(++lineNum, curNode->data);
  }
}
    120d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1210:	5b                   	pop    %ebx
    1211:	5e                   	pop    %esi
    1212:	5f                   	pop    %edi
    1213:	5d                   	pop    %ebp
    1214:	c3                   	ret    
    1215:	8d 76 00             	lea    0x0(%esi),%esi
  if (collectRange(args, &start, &end) == 1) {
    1218:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
    121b:	8d 7d e0             	lea    -0x20(%ebp),%edi
    121e:	83 ec 04             	sub    $0x4,%esp
    1221:	53                   	push   %ebx
    1222:	57                   	push   %edi
    1223:	ff 75 24             	pushl  0x24(%ebp)
    1226:	e8 e5 f5 ff ff       	call   810 <collectRange>
    122b:	83 c4 10             	add    $0x10,%esp
    122e:	83 f8 01             	cmp    $0x1,%eax
    1231:	0f 84 99 00 00 00    	je     12d0 <list+0xf0>
  if (normalizeRange(file, &start, &end) == 1) {
    1237:	83 ec 0c             	sub    $0xc,%esp
    123a:	53                   	push   %ebx
    123b:	57                   	push   %edi
    123c:	ff 75 20             	pushl  0x20(%ebp)
    123f:	ff 75 1c             	pushl  0x1c(%ebp)
    1242:	ff 75 18             	pushl  0x18(%ebp)
    1245:	ff 75 14             	pushl  0x14(%ebp)
    1248:	ff 75 10             	pushl  0x10(%ebp)
    124b:	ff 75 0c             	pushl  0xc(%ebp)
    124e:	ff 75 08             	pushl  0x8(%ebp)
    1251:	e8 da f2 ff ff       	call   530 <normalizeRange>
    1256:	83 c4 30             	add    $0x30,%esp
    1259:	83 f8 01             	cmp    $0x1,%eax
    125c:	0f 84 8e 00 00 00    	je     12f0 <list+0x110>
  lineNum = start - 1;
    1262:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1265:	83 ec 08             	sub    $0x8,%esp
    1268:	8d 78 ff             	lea    -0x1(%eax),%edi
    126b:	57                   	push   %edi
    126c:	56                   	push   %esi
    126d:	e8 1e f0 ff ff       	call   290 <nodeAt>
  struct Node* curNode = (lineAt(file.lines, start))->prev;
    1272:	8b 18                	mov    (%eax),%ebx
    1274:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1277:	5a                   	pop    %edx
    1278:	59                   	pop    %ecx
    1279:	83 e8 01             	sub    $0x1,%eax
    127c:	50                   	push   %eax
    127d:	56                   	push   %esi
    127e:	e8 0d f0 ff ff       	call   290 <nodeAt>
    1283:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
    1286:	39 d8                	cmp    %ebx,%eax
    1288:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    128b:	74 80                	je     120d <list+0x2d>
    curNode = curNode->next;
    128d:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
    1290:	3b 5e 04             	cmp    0x4(%esi),%ebx
    1293:	75 17                	jne    12ac <list+0xcc>
    1295:	e9 73 ff ff ff       	jmp    120d <list+0x2d>
    129a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    curNode = curNode->next;
    12a0:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
    12a3:	39 5e 04             	cmp    %ebx,0x4(%esi)
    12a6:	0f 84 61 ff ff ff    	je     120d <list+0x2d>
    printl(++lineNum, curNode->data);
    12ac:	83 ec 08             	sub    $0x8,%esp
    12af:	83 c7 01             	add    $0x1,%edi
    12b2:	ff 73 04             	pushl  0x4(%ebx)
    12b5:	57                   	push   %edi
    12b6:	e8 f5 f7 ff ff       	call   ab0 <printl>
  while (curNode != stopNode) {
    12bb:	83 c4 10             	add    $0x10,%esp
    12be:	39 5d d4             	cmp    %ebx,-0x2c(%ebp)
    12c1:	75 dd                	jne    12a0 <list+0xc0>
}
    12c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12c6:	5b                   	pop    %ebx
    12c7:	5e                   	pop    %esi
    12c8:	5f                   	pop    %edi
    12c9:	5d                   	pop    %ebp
    12ca:	c3                   	ret    
    12cb:	90                   	nop
    12cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "error: start index is larger than end index\n");
    12d0:	83 ec 08             	sub    $0x8,%esp
    12d3:	68 40 20 00 00       	push   $0x2040
    12d8:	6a 02                	push   $0x2
    12da:	e8 71 07 00 00       	call   1a50 <fprintf>
    return;
    12df:	83 c4 10             	add    $0x10,%esp
}
    12e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12e5:	5b                   	pop    %ebx
    12e6:	5e                   	pop    %esi
    12e7:	5f                   	pop    %edi
    12e8:	5d                   	pop    %ebp
    12e9:	c3                   	ret    
    12ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: bad input range. make sure start < end\n");
    12f0:	83 ec 08             	sub    $0x8,%esp
    12f3:	68 70 20 00 00       	push   $0x2070
    12f8:	6a 02                	push   $0x2
    12fa:	e8 51 07 00 00       	call   1a50 <fprintf>
    return;
    12ff:	83 c4 10             	add    $0x10,%esp
    1302:	e9 06 ff ff ff       	jmp    120d <list+0x2d>
    1307:	89 f6                	mov    %esi,%esi
    1309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001310 <show>:

void show(struct File file, char* args) {
    1310:	55                   	push   %ebp
    1311:	89 e5                	mov    %esp,%ebp
    1313:	57                   	push   %edi
    1314:	56                   	push   %esi
    1315:	53                   	push   %ebx
    1316:	83 ec 0c             	sub    $0xc,%esp
    1319:	8b 7d 18             	mov    0x18(%ebp),%edi
  struct Node* cur = file.lines->head->next;
    131c:	8b 07                	mov    (%edi),%eax
    131e:	8b 58 08             	mov    0x8(%eax),%ebx
  int lineNum = 1;
  while (cur != file.lines->tail) {
    1321:	3b 5f 04             	cmp    0x4(%edi),%ebx
    1324:	74 24                	je     134a <show+0x3a>
  int lineNum = 1;
    1326:	be 01 00 00 00       	mov    $0x1,%esi
    132b:	90                   	nop
    132c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printl(lineNum, cur->data);
    1330:	83 ec 08             	sub    $0x8,%esp
    1333:	ff 73 04             	pushl  0x4(%ebx)
    1336:	56                   	push   %esi
    cur = cur->next;
    lineNum++;
    1337:	83 c6 01             	add    $0x1,%esi
    printl(lineNum, cur->data);
    133a:	e8 71 f7 ff ff       	call   ab0 <printl>
    cur = cur->next;
    133f:	8b 5b 08             	mov    0x8(%ebx),%ebx
  while (cur != file.lines->tail) {
    1342:	83 c4 10             	add    $0x10,%esp
    1345:	39 5f 04             	cmp    %ebx,0x4(%edi)
    1348:	75 e6                	jne    1330 <show+0x20>
  }
}
    134a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    134d:	5b                   	pop    %ebx
    134e:	5e                   	pop    %esi
    134f:	5f                   	pop    %edi
    1350:	5d                   	pop    %ebp
    1351:	c3                   	ret    
    1352:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001360 <quit>:

void quit(struct File* file) {
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
    1363:	56                   	push   %esi
    1364:	53                   	push   %ebx
    1365:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (file->edited == 0) return;
    1368:	8b 4b 18             	mov    0x18(%ebx),%ecx
    136b:	85 c9                	test   %ecx,%ecx
    136d:	75 11                	jne    1380 <quit+0x20>
    cur = cur->next;
  }
  close(file->fd);
  fprintf(2, "changes saved\n");
  return;
}
    136f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1372:	5b                   	pop    %ebx
    1373:	5e                   	pop    %esi
    1374:	5d                   	pop    %ebp
    1375:	c3                   	ret    
    1376:	8d 76 00             	lea    0x0(%esi),%esi
    1379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  fprintf(2, "save changes (y/n)? ");
    1380:	83 ec 08             	sub    $0x8,%esp
    1383:	68 0e 1d 00 00       	push   $0x1d0e
    1388:	6a 02                	push   $0x2
    138a:	e8 c1 06 00 00       	call   1a50 <fprintf>
  if (confirmation() != 0) return;
    138f:	e8 3c f1 ff ff       	call   4d0 <confirmation>
    1394:	83 c4 10             	add    $0x10,%esp
    1397:	85 c0                	test   %eax,%eax
    1399:	75 d4                	jne    136f <quit+0xf>
  if (unlink(file->filename) < 0) {
    139b:	83 ec 0c             	sub    $0xc,%esp
    139e:	ff 33                	pushl  (%ebx)
    13a0:	e8 85 03 00 00       	call   172a <unlink>
    13a5:	83 c4 10             	add    $0x10,%esp
    13a8:	85 c0                	test   %eax,%eax
    13aa:	0f 88 90 00 00 00    	js     1440 <quit+0xe0>
  file->fd = open(file->filename, O_CREATE|O_RDWR);
    13b0:	83 ec 08             	sub    $0x8,%esp
    13b3:	68 02 02 00 00       	push   $0x202
    13b8:	ff 33                	pushl  (%ebx)
    13ba:	e8 5b 03 00 00       	call   171a <open>
  if (file->fd < 0) {
    13bf:	83 c4 10             	add    $0x10,%esp
    13c2:	85 c0                	test   %eax,%eax
  file->fd = open(file->filename, O_CREATE|O_RDWR);
    13c4:	89 43 04             	mov    %eax,0x4(%ebx)
  if (file->fd < 0) {
    13c7:	0f 88 93 00 00 00    	js     1460 <quit+0x100>
  struct Node* cur = file->lines->head->next;
    13cd:	8b 53 10             	mov    0x10(%ebx),%edx
    13d0:	8b 0a                	mov    (%edx),%ecx
    13d2:	8b 71 08             	mov    0x8(%ecx),%esi
  while (cur != file->lines->tail) {
    13d5:	3b 72 04             	cmp    0x4(%edx),%esi
    13d8:	74 43                	je     141d <quit+0xbd>
    13da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    write(file->fd, cur->data, strlen(cur->data));
    13e0:	83 ec 0c             	sub    $0xc,%esp
    13e3:	ff 76 04             	pushl  0x4(%esi)
    13e6:	e8 15 01 00 00       	call   1500 <strlen>
    13eb:	83 c4 0c             	add    $0xc,%esp
    13ee:	50                   	push   %eax
    13ef:	ff 76 04             	pushl  0x4(%esi)
    13f2:	ff 73 04             	pushl  0x4(%ebx)
    13f5:	e8 00 03 00 00       	call   16fa <write>
    write(file->fd, "\n", sizeof(char));
    13fa:	83 c4 0c             	add    $0xc,%esp
    13fd:	6a 01                	push   $0x1
    13ff:	68 9e 1c 00 00       	push   $0x1c9e
    1404:	ff 73 04             	pushl  0x4(%ebx)
    1407:	e8 ee 02 00 00       	call   16fa <write>
  while (cur != file->lines->tail) {
    140c:	8b 43 10             	mov    0x10(%ebx),%eax
    cur = cur->next;
    140f:	8b 76 08             	mov    0x8(%esi),%esi
  while (cur != file->lines->tail) {
    1412:	83 c4 10             	add    $0x10,%esp
    1415:	39 70 04             	cmp    %esi,0x4(%eax)
    1418:	75 c6                	jne    13e0 <quit+0x80>
    141a:	8b 43 04             	mov    0x4(%ebx),%eax
  close(file->fd);
    141d:	83 ec 0c             	sub    $0xc,%esp
    1420:	50                   	push   %eax
    1421:	e8 dc 02 00 00       	call   1702 <close>
  fprintf(2, "changes saved\n");
    1426:	58                   	pop    %eax
    1427:	5a                   	pop    %edx
    1428:	68 23 1d 00 00       	push   $0x1d23
    142d:	6a 02                	push   $0x2
    142f:	e8 1c 06 00 00       	call   1a50 <fprintf>
  return;
    1434:	83 c4 10             	add    $0x10,%esp
    1437:	e9 33 ff ff ff       	jmp    136f <quit+0xf>
    143c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "could not clear file for writing. changes lost\n");
    1440:	83 ec 08             	sub    $0x8,%esp
    1443:	68 f0 20 00 00       	push   $0x20f0
    1448:	6a 02                	push   $0x2
    144a:	e8 01 06 00 00       	call   1a50 <fprintf>
    return;
    144f:	83 c4 10             	add    $0x10,%esp
    1452:	e9 18 ff ff ff       	jmp    136f <quit+0xf>
    1457:	89 f6                	mov    %esi,%esi
    1459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    fprintf(2, "could not open file for writing. changes lost\n");
    1460:	83 ec 08             	sub    $0x8,%esp
    1463:	68 20 21 00 00       	push   $0x2120
    1468:	6a 02                	push   $0x2
    146a:	e8 e1 05 00 00       	call   1a50 <fprintf>
    return;
    146f:	83 c4 10             	add    $0x10,%esp
    1472:	e9 f8 fe ff ff       	jmp    136f <quit+0xf>
    1477:	66 90                	xchg   %ax,%ax
    1479:	66 90                	xchg   %ax,%ax
    147b:	66 90                	xchg   %ax,%ax
    147d:	66 90                	xchg   %ax,%ax
    147f:	90                   	nop

00001480 <strcpy>:
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
    1480:	55                   	push   %ebp
    1481:	89 e5                	mov    %esp,%ebp
    1483:	53                   	push   %ebx
    1484:	8b 45 08             	mov    0x8(%ebp),%eax
    1487:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    148a:	89 c2                	mov    %eax,%edx
    148c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1490:	83 c1 01             	add    $0x1,%ecx
    1493:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1497:	83 c2 01             	add    $0x1,%edx
    149a:	84 db                	test   %bl,%bl
    149c:	88 5a ff             	mov    %bl,-0x1(%edx)
    149f:	75 ef                	jne    1490 <strcpy+0x10>
    ;
  return os;
}
    14a1:	5b                   	pop    %ebx
    14a2:	5d                   	pop    %ebp
    14a3:	c3                   	ret    
    14a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    14aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000014b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    14b0:	55                   	push   %ebp
    14b1:	89 e5                	mov    %esp,%ebp
    14b3:	53                   	push   %ebx
    14b4:	8b 55 08             	mov    0x8(%ebp),%edx
    14b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    14ba:	0f b6 02             	movzbl (%edx),%eax
    14bd:	0f b6 19             	movzbl (%ecx),%ebx
    14c0:	84 c0                	test   %al,%al
    14c2:	75 1c                	jne    14e0 <strcmp+0x30>
    14c4:	eb 2a                	jmp    14f0 <strcmp+0x40>
    14c6:	8d 76 00             	lea    0x0(%esi),%esi
    14c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    14d0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    14d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    14d6:	83 c1 01             	add    $0x1,%ecx
    14d9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    14dc:	84 c0                	test   %al,%al
    14de:	74 10                	je     14f0 <strcmp+0x40>
    14e0:	38 d8                	cmp    %bl,%al
    14e2:	74 ec                	je     14d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    14e4:	29 d8                	sub    %ebx,%eax
}
    14e6:	5b                   	pop    %ebx
    14e7:	5d                   	pop    %ebp
    14e8:	c3                   	ret    
    14e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    14f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    14f2:	29 d8                	sub    %ebx,%eax
}
    14f4:	5b                   	pop    %ebx
    14f5:	5d                   	pop    %ebp
    14f6:	c3                   	ret    
    14f7:	89 f6                	mov    %esi,%esi
    14f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001500 <strlen>:

uint
strlen(const char *s)
{
    1500:	55                   	push   %ebp
    1501:	89 e5                	mov    %esp,%ebp
    1503:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1506:	80 39 00             	cmpb   $0x0,(%ecx)
    1509:	74 15                	je     1520 <strlen+0x20>
    150b:	31 d2                	xor    %edx,%edx
    150d:	8d 76 00             	lea    0x0(%esi),%esi
    1510:	83 c2 01             	add    $0x1,%edx
    1513:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1517:	89 d0                	mov    %edx,%eax
    1519:	75 f5                	jne    1510 <strlen+0x10>
    ;
  return n;
}
    151b:	5d                   	pop    %ebp
    151c:	c3                   	ret    
    151d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    1520:	31 c0                	xor    %eax,%eax
}
    1522:	5d                   	pop    %ebp
    1523:	c3                   	ret    
    1524:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    152a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001530 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1530:	55                   	push   %ebp
    1531:	89 e5                	mov    %esp,%ebp
    1533:	57                   	push   %edi
    1534:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1537:	8b 4d 10             	mov    0x10(%ebp),%ecx
    153a:	8b 45 0c             	mov    0xc(%ebp),%eax
    153d:	89 d7                	mov    %edx,%edi
    153f:	fc                   	cld    
    1540:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1542:	89 d0                	mov    %edx,%eax
    1544:	5f                   	pop    %edi
    1545:	5d                   	pop    %ebp
    1546:	c3                   	ret    
    1547:	89 f6                	mov    %esi,%esi
    1549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001550 <strchr>:

char*
strchr(const char *s, char c)
{
    1550:	55                   	push   %ebp
    1551:	89 e5                	mov    %esp,%ebp
    1553:	53                   	push   %ebx
    1554:	8b 45 08             	mov    0x8(%ebp),%eax
    1557:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    155a:	0f b6 10             	movzbl (%eax),%edx
    155d:	84 d2                	test   %dl,%dl
    155f:	74 1d                	je     157e <strchr+0x2e>
    if(*s == c)
    1561:	38 d3                	cmp    %dl,%bl
    1563:	89 d9                	mov    %ebx,%ecx
    1565:	75 0d                	jne    1574 <strchr+0x24>
    1567:	eb 17                	jmp    1580 <strchr+0x30>
    1569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1570:	38 ca                	cmp    %cl,%dl
    1572:	74 0c                	je     1580 <strchr+0x30>
  for(; *s; s++)
    1574:	83 c0 01             	add    $0x1,%eax
    1577:	0f b6 10             	movzbl (%eax),%edx
    157a:	84 d2                	test   %dl,%dl
    157c:	75 f2                	jne    1570 <strchr+0x20>
      return (char*)s;
  return 0;
    157e:	31 c0                	xor    %eax,%eax
}
    1580:	5b                   	pop    %ebx
    1581:	5d                   	pop    %ebp
    1582:	c3                   	ret    
    1583:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001590 <gets>:

char*
gets(char *buf, int max)
{
    1590:	55                   	push   %ebp
    1591:	89 e5                	mov    %esp,%ebp
    1593:	57                   	push   %edi
    1594:	56                   	push   %esi
    1595:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1596:	31 f6                	xor    %esi,%esi
    1598:	89 f3                	mov    %esi,%ebx
{
    159a:	83 ec 1c             	sub    $0x1c,%esp
    159d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    15a0:	eb 2f                	jmp    15d1 <gets+0x41>
    15a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    15a8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    15ab:	83 ec 04             	sub    $0x4,%esp
    15ae:	6a 01                	push   $0x1
    15b0:	50                   	push   %eax
    15b1:	6a 00                	push   $0x0
    15b3:	e8 32 01 00 00       	call   16ea <read>
    if(cc < 1)
    15b8:	83 c4 10             	add    $0x10,%esp
    15bb:	85 c0                	test   %eax,%eax
    15bd:	7e 1c                	jle    15db <gets+0x4b>
      break;
    buf[i++] = c;
    15bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    15c3:	83 c7 01             	add    $0x1,%edi
    15c6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    15c9:	3c 0a                	cmp    $0xa,%al
    15cb:	74 23                	je     15f0 <gets+0x60>
    15cd:	3c 0d                	cmp    $0xd,%al
    15cf:	74 1f                	je     15f0 <gets+0x60>
  for(i=0; i+1 < max; ){
    15d1:	83 c3 01             	add    $0x1,%ebx
    15d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    15d7:	89 fe                	mov    %edi,%esi
    15d9:	7c cd                	jl     15a8 <gets+0x18>
    15db:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    15dd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    15e0:	c6 03 00             	movb   $0x0,(%ebx)
}
    15e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    15e6:	5b                   	pop    %ebx
    15e7:	5e                   	pop    %esi
    15e8:	5f                   	pop    %edi
    15e9:	5d                   	pop    %ebp
    15ea:	c3                   	ret    
    15eb:	90                   	nop
    15ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    15f0:	8b 75 08             	mov    0x8(%ebp),%esi
    15f3:	8b 45 08             	mov    0x8(%ebp),%eax
    15f6:	01 de                	add    %ebx,%esi
    15f8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    15fa:	c6 03 00             	movb   $0x0,(%ebx)
}
    15fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1600:	5b                   	pop    %ebx
    1601:	5e                   	pop    %esi
    1602:	5f                   	pop    %edi
    1603:	5d                   	pop    %ebp
    1604:	c3                   	ret    
    1605:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001610 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
    1610:	55                   	push   %ebp
    1611:	89 e5                	mov    %esp,%ebp
    1613:	56                   	push   %esi
    1614:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1615:	83 ec 08             	sub    $0x8,%esp
    1618:	6a 00                	push   $0x0
    161a:	ff 75 08             	pushl  0x8(%ebp)
    161d:	e8 f8 00 00 00       	call   171a <open>
  if(fd < 0)
    1622:	83 c4 10             	add    $0x10,%esp
    1625:	85 c0                	test   %eax,%eax
    1627:	78 27                	js     1650 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1629:	83 ec 08             	sub    $0x8,%esp
    162c:	ff 75 0c             	pushl  0xc(%ebp)
    162f:	89 c3                	mov    %eax,%ebx
    1631:	50                   	push   %eax
    1632:	e8 fb 00 00 00       	call   1732 <fstat>
  close(fd);
    1637:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    163a:	89 c6                	mov    %eax,%esi
  close(fd);
    163c:	e8 c1 00 00 00       	call   1702 <close>
  return r;
    1641:	83 c4 10             	add    $0x10,%esp
}
    1644:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1647:	89 f0                	mov    %esi,%eax
    1649:	5b                   	pop    %ebx
    164a:	5e                   	pop    %esi
    164b:	5d                   	pop    %ebp
    164c:	c3                   	ret    
    164d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1650:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1655:	eb ed                	jmp    1644 <stat+0x34>
    1657:	89 f6                	mov    %esi,%esi
    1659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001660 <atoi>:

int
atoi(const char *s)
{
    1660:	55                   	push   %ebp
    1661:	89 e5                	mov    %esp,%ebp
    1663:	53                   	push   %ebx
    1664:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1667:	0f be 11             	movsbl (%ecx),%edx
    166a:	8d 42 d0             	lea    -0x30(%edx),%eax
    166d:	3c 09                	cmp    $0x9,%al
  n = 0;
    166f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    1674:	77 1f                	ja     1695 <atoi+0x35>
    1676:	8d 76 00             	lea    0x0(%esi),%esi
    1679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1680:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1683:	83 c1 01             	add    $0x1,%ecx
    1686:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    168a:	0f be 11             	movsbl (%ecx),%edx
    168d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1690:	80 fb 09             	cmp    $0x9,%bl
    1693:	76 eb                	jbe    1680 <atoi+0x20>
  return n;
}
    1695:	5b                   	pop    %ebx
    1696:	5d                   	pop    %ebp
    1697:	c3                   	ret    
    1698:	90                   	nop
    1699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000016a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    16a0:	55                   	push   %ebp
    16a1:	89 e5                	mov    %esp,%ebp
    16a3:	56                   	push   %esi
    16a4:	53                   	push   %ebx
    16a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    16a8:	8b 45 08             	mov    0x8(%ebp),%eax
    16ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    16ae:	85 db                	test   %ebx,%ebx
    16b0:	7e 14                	jle    16c6 <memmove+0x26>
    16b2:	31 d2                	xor    %edx,%edx
    16b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    16b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    16bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    16bf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    16c2:	39 d3                	cmp    %edx,%ebx
    16c4:	75 f2                	jne    16b8 <memmove+0x18>
  return vdst;
}
    16c6:	5b                   	pop    %ebx
    16c7:	5e                   	pop    %esi
    16c8:	5d                   	pop    %ebp
    16c9:	c3                   	ret    

000016ca <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    16ca:	b8 01 00 00 00       	mov    $0x1,%eax
    16cf:	cd 40                	int    $0x40
    16d1:	c3                   	ret    

000016d2 <exit>:
SYSCALL(exit)
    16d2:	b8 02 00 00 00       	mov    $0x2,%eax
    16d7:	cd 40                	int    $0x40
    16d9:	c3                   	ret    

000016da <wait>:
SYSCALL(wait)
    16da:	b8 03 00 00 00       	mov    $0x3,%eax
    16df:	cd 40                	int    $0x40
    16e1:	c3                   	ret    

000016e2 <pipe>:
SYSCALL(pipe)
    16e2:	b8 04 00 00 00       	mov    $0x4,%eax
    16e7:	cd 40                	int    $0x40
    16e9:	c3                   	ret    

000016ea <read>:
SYSCALL(read)
    16ea:	b8 05 00 00 00       	mov    $0x5,%eax
    16ef:	cd 40                	int    $0x40
    16f1:	c3                   	ret    

000016f2 <steal>:
SYSCALL(steal)
    16f2:	b8 17 00 00 00       	mov    $0x17,%eax
    16f7:	cd 40                	int    $0x40
    16f9:	c3                   	ret    

000016fa <write>:
SYSCALL(write)
    16fa:	b8 10 00 00 00       	mov    $0x10,%eax
    16ff:	cd 40                	int    $0x40
    1701:	c3                   	ret    

00001702 <close>:
SYSCALL(close)
    1702:	b8 15 00 00 00       	mov    $0x15,%eax
    1707:	cd 40                	int    $0x40
    1709:	c3                   	ret    

0000170a <kill>:
SYSCALL(kill)
    170a:	b8 06 00 00 00       	mov    $0x6,%eax
    170f:	cd 40                	int    $0x40
    1711:	c3                   	ret    

00001712 <exec>:
SYSCALL(exec)
    1712:	b8 07 00 00 00       	mov    $0x7,%eax
    1717:	cd 40                	int    $0x40
    1719:	c3                   	ret    

0000171a <open>:
SYSCALL(open)
    171a:	b8 0f 00 00 00       	mov    $0xf,%eax
    171f:	cd 40                	int    $0x40
    1721:	c3                   	ret    

00001722 <mknod>:
SYSCALL(mknod)
    1722:	b8 11 00 00 00       	mov    $0x11,%eax
    1727:	cd 40                	int    $0x40
    1729:	c3                   	ret    

0000172a <unlink>:
SYSCALL(unlink)
    172a:	b8 12 00 00 00       	mov    $0x12,%eax
    172f:	cd 40                	int    $0x40
    1731:	c3                   	ret    

00001732 <fstat>:
SYSCALL(fstat)
    1732:	b8 08 00 00 00       	mov    $0x8,%eax
    1737:	cd 40                	int    $0x40
    1739:	c3                   	ret    

0000173a <link>:
SYSCALL(link)
    173a:	b8 13 00 00 00       	mov    $0x13,%eax
    173f:	cd 40                	int    $0x40
    1741:	c3                   	ret    

00001742 <mkdir>:
SYSCALL(mkdir)
    1742:	b8 14 00 00 00       	mov    $0x14,%eax
    1747:	cd 40                	int    $0x40
    1749:	c3                   	ret    

0000174a <chdir>:
SYSCALL(chdir)
    174a:	b8 09 00 00 00       	mov    $0x9,%eax
    174f:	cd 40                	int    $0x40
    1751:	c3                   	ret    

00001752 <dup>:
SYSCALL(dup)
    1752:	b8 0a 00 00 00       	mov    $0xa,%eax
    1757:	cd 40                	int    $0x40
    1759:	c3                   	ret    

0000175a <getpid>:
SYSCALL(getpid)
    175a:	b8 0b 00 00 00       	mov    $0xb,%eax
    175f:	cd 40                	int    $0x40
    1761:	c3                   	ret    

00001762 <sbrk>:
SYSCALL(sbrk)
    1762:	b8 0c 00 00 00       	mov    $0xc,%eax
    1767:	cd 40                	int    $0x40
    1769:	c3                   	ret    

0000176a <sleep>:
SYSCALL(sleep)
    176a:	b8 0d 00 00 00       	mov    $0xd,%eax
    176f:	cd 40                	int    $0x40
    1771:	c3                   	ret    

00001772 <uptime>:
SYSCALL(uptime)
    1772:	b8 0e 00 00 00       	mov    $0xe,%eax
    1777:	cd 40                	int    $0x40
    1779:	c3                   	ret    

0000177a <cpuhalt>:
SYSCALL(cpuhalt)
    177a:	b8 16 00 00 00       	mov    $0x16,%eax
    177f:	cd 40                	int    $0x40
    1781:	c3                   	ret    
    1782:	66 90                	xchg   %ax,%ax
    1784:	66 90                	xchg   %ax,%ax
    1786:	66 90                	xchg   %ax,%ax
    1788:	66 90                	xchg   %ax,%ax
    178a:	66 90                	xchg   %ax,%ax
    178c:	66 90                	xchg   %ax,%ax
    178e:	66 90                	xchg   %ax,%ax

00001790 <printint.constprop.1>:
    1790:	55                   	push   %ebp
    1791:	89 e5                	mov    %esp,%ebp
    1793:	57                   	push   %edi
    1794:	56                   	push   %esi
    1795:	53                   	push   %ebx
    1796:	89 d6                	mov    %edx,%esi
    1798:	83 ec 3c             	sub    $0x3c,%esp
    179b:	85 c0                	test   %eax,%eax
    179d:	79 71                	jns    1810 <printint.constprop.1+0x80>
    179f:	83 e1 01             	and    $0x1,%ecx
    17a2:	74 6c                	je     1810 <printint.constprop.1+0x80>
    17a4:	f7 d8                	neg    %eax
    17a6:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    17ad:	31 c9                	xor    %ecx,%ecx
    17af:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    17b2:	eb 06                	jmp    17ba <printint.constprop.1+0x2a>
    17b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    17b8:	89 f9                	mov    %edi,%ecx
    17ba:	31 d2                	xor    %edx,%edx
    17bc:	8d 79 01             	lea    0x1(%ecx),%edi
    17bf:	f7 f6                	div    %esi
    17c1:	0f b6 92 58 21 00 00 	movzbl 0x2158(%edx),%edx
    17c8:	85 c0                	test   %eax,%eax
    17ca:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
    17cd:	75 e9                	jne    17b8 <printint.constprop.1+0x28>
    17cf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    17d2:	85 c0                	test   %eax,%eax
    17d4:	74 08                	je     17de <printint.constprop.1+0x4e>
    17d6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    17db:	8d 79 02             	lea    0x2(%ecx),%edi
    17de:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    17e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    17e8:	0f b6 06             	movzbl (%esi),%eax
    17eb:	83 ec 04             	sub    $0x4,%esp
    17ee:	83 ee 01             	sub    $0x1,%esi
    17f1:	6a 01                	push   $0x1
    17f3:	53                   	push   %ebx
    17f4:	6a 01                	push   $0x1
    17f6:	88 45 d7             	mov    %al,-0x29(%ebp)
    17f9:	e8 fc fe ff ff       	call   16fa <write>
    17fe:	83 c4 10             	add    $0x10,%esp
    1801:	39 de                	cmp    %ebx,%esi
    1803:	75 e3                	jne    17e8 <printint.constprop.1+0x58>
    1805:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1808:	5b                   	pop    %ebx
    1809:	5e                   	pop    %esi
    180a:	5f                   	pop    %edi
    180b:	5d                   	pop    %ebp
    180c:	c3                   	ret    
    180d:	8d 76 00             	lea    0x0(%esi),%esi
    1810:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1817:	eb 94                	jmp    17ad <printint.constprop.1+0x1d>
    1819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001820 <vprintf.constprop.0>:
    1820:	55                   	push   %ebp
    1821:	89 e5                	mov    %esp,%ebp
    1823:	57                   	push   %edi
    1824:	56                   	push   %esi
    1825:	53                   	push   %ebx
    1826:	89 d6                	mov    %edx,%esi
    1828:	83 ec 2c             	sub    $0x2c,%esp
    182b:	0f b6 10             	movzbl (%eax),%edx
    182e:	84 d2                	test   %dl,%dl
    1830:	0f 84 cd 00 00 00    	je     1903 <vprintf.constprop.0+0xe3>
    1836:	8d 58 01             	lea    0x1(%eax),%ebx
    1839:	31 ff                	xor    %edi,%edi
    183b:	eb 31                	jmp    186e <vprintf.constprop.0+0x4e>
    183d:	8d 76 00             	lea    0x0(%esi),%esi
    1840:	83 f8 25             	cmp    $0x25,%eax
    1843:	0f 84 c7 00 00 00    	je     1910 <vprintf.constprop.0+0xf0>
    1849:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    184c:	83 ec 04             	sub    $0x4,%esp
    184f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
    1852:	6a 01                	push   $0x1
    1854:	50                   	push   %eax
    1855:	6a 01                	push   $0x1
    1857:	e8 9e fe ff ff       	call   16fa <write>
    185c:	83 c4 10             	add    $0x10,%esp
    185f:	83 c3 01             	add    $0x1,%ebx
    1862:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1866:	84 d2                	test   %dl,%dl
    1868:	0f 84 95 00 00 00    	je     1903 <vprintf.constprop.0+0xe3>
    186e:	85 ff                	test   %edi,%edi
    1870:	0f b6 c2             	movzbl %dl,%eax
    1873:	74 cb                	je     1840 <vprintf.constprop.0+0x20>
    1875:	83 ff 25             	cmp    $0x25,%edi
    1878:	75 e5                	jne    185f <vprintf.constprop.0+0x3f>
    187a:	83 f8 64             	cmp    $0x64,%eax
    187d:	8d 7e 04             	lea    0x4(%esi),%edi
    1880:	b9 01 00 00 00       	mov    $0x1,%ecx
    1885:	0f 84 9a 00 00 00    	je     1925 <vprintf.constprop.0+0x105>
    188b:	83 f8 6c             	cmp    $0x6c,%eax
    188e:	0f 84 8c 00 00 00    	je     1920 <vprintf.constprop.0+0x100>
    1894:	83 f8 78             	cmp    $0x78,%eax
    1897:	0f 84 a3 00 00 00    	je     1940 <vprintf.constprop.0+0x120>
    189d:	83 f8 70             	cmp    $0x70,%eax
    18a0:	0f 84 ca 00 00 00    	je     1970 <vprintf.constprop.0+0x150>
    18a6:	83 f8 73             	cmp    $0x73,%eax
    18a9:	0f 84 39 01 00 00    	je     19e8 <vprintf.constprop.0+0x1c8>
    18af:	83 f8 63             	cmp    $0x63,%eax
    18b2:	0f 84 68 01 00 00    	je     1a20 <vprintf.constprop.0+0x200>
    18b8:	83 f8 25             	cmp    $0x25,%eax
    18bb:	0f 84 9f 00 00 00    	je     1960 <vprintf.constprop.0+0x140>
    18c1:	8d 45 df             	lea    -0x21(%ebp),%eax
    18c4:	83 ec 04             	sub    $0x4,%esp
    18c7:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    18ca:	6a 01                	push   $0x1
    18cc:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
    18d0:	50                   	push   %eax
    18d1:	6a 01                	push   $0x1
    18d3:	e8 22 fe ff ff       	call   16fa <write>
    18d8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    18dc:	83 c4 0c             	add    $0xc,%esp
    18df:	8d 45 e0             	lea    -0x20(%ebp),%eax
    18e2:	6a 01                	push   $0x1
    18e4:	88 55 e0             	mov    %dl,-0x20(%ebp)
    18e7:	50                   	push   %eax
    18e8:	6a 01                	push   $0x1
    18ea:	83 c3 01             	add    $0x1,%ebx
    18ed:	31 ff                	xor    %edi,%edi
    18ef:	e8 06 fe ff ff       	call   16fa <write>
    18f4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    18f8:	83 c4 10             	add    $0x10,%esp
    18fb:	84 d2                	test   %dl,%dl
    18fd:	0f 85 6b ff ff ff    	jne    186e <vprintf.constprop.0+0x4e>
    1903:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1906:	5b                   	pop    %ebx
    1907:	5e                   	pop    %esi
    1908:	5f                   	pop    %edi
    1909:	5d                   	pop    %ebp
    190a:	c3                   	ret    
    190b:	90                   	nop
    190c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1910:	bf 25 00 00 00       	mov    $0x25,%edi
    1915:	e9 45 ff ff ff       	jmp    185f <vprintf.constprop.0+0x3f>
    191a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1920:	8d 7e 04             	lea    0x4(%esi),%edi
    1923:	31 c9                	xor    %ecx,%ecx
    1925:	8b 06                	mov    (%esi),%eax
    1927:	ba 0a 00 00 00       	mov    $0xa,%edx
    192c:	89 fe                	mov    %edi,%esi
    192e:	31 ff                	xor    %edi,%edi
    1930:	e8 5b fe ff ff       	call   1790 <printint.constprop.1>
    1935:	e9 25 ff ff ff       	jmp    185f <vprintf.constprop.0+0x3f>
    193a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1940:	8b 06                	mov    (%esi),%eax
    1942:	8d 7e 04             	lea    0x4(%esi),%edi
    1945:	31 c9                	xor    %ecx,%ecx
    1947:	ba 10 00 00 00       	mov    $0x10,%edx
    194c:	89 fe                	mov    %edi,%esi
    194e:	31 ff                	xor    %edi,%edi
    1950:	e8 3b fe ff ff       	call   1790 <printint.constprop.1>
    1955:	e9 05 ff ff ff       	jmp    185f <vprintf.constprop.0+0x3f>
    195a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1960:	83 ec 04             	sub    $0x4,%esp
    1963:	88 55 e1             	mov    %dl,-0x1f(%ebp)
    1966:	8d 45 e1             	lea    -0x1f(%ebp),%eax
    1969:	6a 01                	push   $0x1
    196b:	e9 77 ff ff ff       	jmp    18e7 <vprintf.constprop.0+0xc7>
    1970:	8d 46 04             	lea    0x4(%esi),%eax
    1973:	83 ec 04             	sub    $0x4,%esp
    1976:	8b 3e                	mov    (%esi),%edi
    1978:	6a 01                	push   $0x1
    197a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
    197e:	be 08 00 00 00       	mov    $0x8,%esi
    1983:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1986:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1989:	50                   	push   %eax
    198a:	6a 01                	push   $0x1
    198c:	e8 69 fd ff ff       	call   16fa <write>
    1991:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1994:	83 c4 0c             	add    $0xc,%esp
    1997:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
    199b:	6a 01                	push   $0x1
    199d:	50                   	push   %eax
    199e:	6a 01                	push   $0x1
    19a0:	e8 55 fd ff ff       	call   16fa <write>
    19a5:	83 c4 10             	add    $0x10,%esp
    19a8:	90                   	nop
    19a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    19b0:	89 f8                	mov    %edi,%eax
    19b2:	83 ec 04             	sub    $0x4,%esp
    19b5:	c1 e7 04             	shl    $0x4,%edi
    19b8:	c1 e8 1c             	shr    $0x1c,%eax
    19bb:	6a 01                	push   $0x1
    19bd:	0f b6 80 58 21 00 00 	movzbl 0x2158(%eax),%eax
    19c4:	88 45 e5             	mov    %al,-0x1b(%ebp)
    19c7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19ca:	50                   	push   %eax
    19cb:	6a 01                	push   $0x1
    19cd:	e8 28 fd ff ff       	call   16fa <write>
    19d2:	83 c4 10             	add    $0x10,%esp
    19d5:	83 ee 01             	sub    $0x1,%esi
    19d8:	75 d6                	jne    19b0 <vprintf.constprop.0+0x190>
    19da:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    19dd:	31 ff                	xor    %edi,%edi
    19df:	e9 7b fe ff ff       	jmp    185f <vprintf.constprop.0+0x3f>
    19e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    19e8:	8b 3e                	mov    (%esi),%edi
    19ea:	8d 46 04             	lea    0x4(%esi),%eax
    19ed:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    19f0:	85 ff                	test   %edi,%edi
    19f2:	74 50                	je     1a44 <vprintf.constprop.0+0x224>
    19f4:	0f b6 07             	movzbl (%edi),%eax
    19f7:	84 c0                	test   %al,%al
    19f9:	74 df                	je     19da <vprintf.constprop.0+0x1ba>
    19fb:	8d 75 e3             	lea    -0x1d(%ebp),%esi
    19fe:	66 90                	xchg   %ax,%ax
    1a00:	83 ec 04             	sub    $0x4,%esp
    1a03:	83 c7 01             	add    $0x1,%edi
    1a06:	88 45 e3             	mov    %al,-0x1d(%ebp)
    1a09:	6a 01                	push   $0x1
    1a0b:	56                   	push   %esi
    1a0c:	6a 01                	push   $0x1
    1a0e:	e8 e7 fc ff ff       	call   16fa <write>
    1a13:	0f b6 07             	movzbl (%edi),%eax
    1a16:	83 c4 10             	add    $0x10,%esp
    1a19:	84 c0                	test   %al,%al
    1a1b:	75 e3                	jne    1a00 <vprintf.constprop.0+0x1e0>
    1a1d:	eb bb                	jmp    19da <vprintf.constprop.0+0x1ba>
    1a1f:	90                   	nop
    1a20:	8b 06                	mov    (%esi),%eax
    1a22:	83 ec 04             	sub    $0x4,%esp
    1a25:	8d 7e 04             	lea    0x4(%esi),%edi
    1a28:	6a 01                	push   $0x1
    1a2a:	89 fe                	mov    %edi,%esi
    1a2c:	31 ff                	xor    %edi,%edi
    1a2e:	88 45 e2             	mov    %al,-0x1e(%ebp)
    1a31:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1a34:	50                   	push   %eax
    1a35:	6a 01                	push   $0x1
    1a37:	e8 be fc ff ff       	call   16fa <write>
    1a3c:	83 c4 10             	add    $0x10,%esp
    1a3f:	e9 1b fe ff ff       	jmp    185f <vprintf.constprop.0+0x3f>
    1a44:	bf 50 21 00 00       	mov    $0x2150,%edi
    1a49:	b8 28 00 00 00       	mov    $0x28,%eax
    1a4e:	eb ab                	jmp    19fb <vprintf.constprop.0+0x1db>

00001a50 <fprintf>:
    1a50:	55                   	push   %ebp
    1a51:	89 e5                	mov    %esp,%ebp
    1a53:	83 ec 08             	sub    $0x8,%esp
    1a56:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a59:	8d 55 10             	lea    0x10(%ebp),%edx
    1a5c:	e8 bf fd ff ff       	call   1820 <vprintf.constprop.0>
    1a61:	c9                   	leave  
    1a62:	c3                   	ret    
    1a63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001a70 <printf>:
    1a70:	55                   	push   %ebp
    1a71:	89 e5                	mov    %esp,%ebp
    1a73:	83 ec 08             	sub    $0x8,%esp
    1a76:	8b 45 08             	mov    0x8(%ebp),%eax
    1a79:	8d 55 0c             	lea    0xc(%ebp),%edx
    1a7c:	e8 9f fd ff ff       	call   1820 <vprintf.constprop.0>
    1a81:	c9                   	leave  
    1a82:	c3                   	ret    
    1a83:	66 90                	xchg   %ax,%ax
    1a85:	66 90                	xchg   %ax,%ax
    1a87:	66 90                	xchg   %ax,%ax
    1a89:	66 90                	xchg   %ax,%ax
    1a8b:	66 90                	xchg   %ax,%ax
    1a8d:	66 90                	xchg   %ax,%ax
    1a8f:	90                   	nop

00001a90 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1a90:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1a91:	a1 28 2b 00 00       	mov    0x2b28,%eax
{
    1a96:	89 e5                	mov    %esp,%ebp
    1a98:	57                   	push   %edi
    1a99:	56                   	push   %esi
    1a9a:	53                   	push   %ebx
    1a9b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    1a9e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1aa8:	39 c8                	cmp    %ecx,%eax
    1aaa:	8b 10                	mov    (%eax),%edx
    1aac:	73 32                	jae    1ae0 <free+0x50>
    1aae:	39 d1                	cmp    %edx,%ecx
    1ab0:	72 04                	jb     1ab6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1ab2:	39 d0                	cmp    %edx,%eax
    1ab4:	72 32                	jb     1ae8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1ab6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1ab9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1abc:	39 fa                	cmp    %edi,%edx
    1abe:	74 30                	je     1af0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1ac0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1ac3:	8b 50 04             	mov    0x4(%eax),%edx
    1ac6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1ac9:	39 f1                	cmp    %esi,%ecx
    1acb:	74 3a                	je     1b07 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1acd:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1acf:	a3 28 2b 00 00       	mov    %eax,0x2b28
}
    1ad4:	5b                   	pop    %ebx
    1ad5:	5e                   	pop    %esi
    1ad6:	5f                   	pop    %edi
    1ad7:	5d                   	pop    %ebp
    1ad8:	c3                   	ret    
    1ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1ae0:	39 d0                	cmp    %edx,%eax
    1ae2:	72 04                	jb     1ae8 <free+0x58>
    1ae4:	39 d1                	cmp    %edx,%ecx
    1ae6:	72 ce                	jb     1ab6 <free+0x26>
{
    1ae8:	89 d0                	mov    %edx,%eax
    1aea:	eb bc                	jmp    1aa8 <free+0x18>
    1aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1af0:	03 72 04             	add    0x4(%edx),%esi
    1af3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1af6:	8b 10                	mov    (%eax),%edx
    1af8:	8b 12                	mov    (%edx),%edx
    1afa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1afd:	8b 50 04             	mov    0x4(%eax),%edx
    1b00:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1b03:	39 f1                	cmp    %esi,%ecx
    1b05:	75 c6                	jne    1acd <free+0x3d>
    p->s.size += bp->s.size;
    1b07:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    1b0a:	a3 28 2b 00 00       	mov    %eax,0x2b28
    p->s.size += bp->s.size;
    1b0f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1b12:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1b15:	89 10                	mov    %edx,(%eax)
}
    1b17:	5b                   	pop    %ebx
    1b18:	5e                   	pop    %esi
    1b19:	5f                   	pop    %edi
    1b1a:	5d                   	pop    %ebp
    1b1b:	c3                   	ret    
    1b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001b20 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1b20:	55                   	push   %ebp
    1b21:	89 e5                	mov    %esp,%ebp
    1b23:	57                   	push   %edi
    1b24:	56                   	push   %esi
    1b25:	53                   	push   %ebx
    1b26:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1b29:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    1b2c:	8b 15 28 2b 00 00    	mov    0x2b28,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1b32:	8d 78 07             	lea    0x7(%eax),%edi
    1b35:	c1 ef 03             	shr    $0x3,%edi
    1b38:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    1b3b:	85 d2                	test   %edx,%edx
    1b3d:	0f 84 9d 00 00 00    	je     1be0 <malloc+0xc0>
    1b43:	8b 02                	mov    (%edx),%eax
    1b45:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1b48:	39 cf                	cmp    %ecx,%edi
    1b4a:	76 6c                	jbe    1bb8 <malloc+0x98>
    1b4c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1b52:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1b57:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1b5a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1b61:	eb 0e                	jmp    1b71 <malloc+0x51>
    1b63:	90                   	nop
    1b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1b68:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1b6a:	8b 48 04             	mov    0x4(%eax),%ecx
    1b6d:	39 f9                	cmp    %edi,%ecx
    1b6f:	73 47                	jae    1bb8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1b71:	39 05 28 2b 00 00    	cmp    %eax,0x2b28
    1b77:	89 c2                	mov    %eax,%edx
    1b79:	75 ed                	jne    1b68 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    1b7b:	83 ec 0c             	sub    $0xc,%esp
    1b7e:	56                   	push   %esi
    1b7f:	e8 de fb ff ff       	call   1762 <sbrk>
  if(p == (char*)-1)
    1b84:	83 c4 10             	add    $0x10,%esp
    1b87:	83 f8 ff             	cmp    $0xffffffff,%eax
    1b8a:	74 1c                	je     1ba8 <malloc+0x88>
  hp->s.size = nu;
    1b8c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1b8f:	83 ec 0c             	sub    $0xc,%esp
    1b92:	83 c0 08             	add    $0x8,%eax
    1b95:	50                   	push   %eax
    1b96:	e8 f5 fe ff ff       	call   1a90 <free>
  return freep;
    1b9b:	8b 15 28 2b 00 00    	mov    0x2b28,%edx
      if((p = morecore(nunits)) == 0)
    1ba1:	83 c4 10             	add    $0x10,%esp
    1ba4:	85 d2                	test   %edx,%edx
    1ba6:	75 c0                	jne    1b68 <malloc+0x48>
        return 0;
  }
}
    1ba8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1bab:	31 c0                	xor    %eax,%eax
}
    1bad:	5b                   	pop    %ebx
    1bae:	5e                   	pop    %esi
    1baf:	5f                   	pop    %edi
    1bb0:	5d                   	pop    %ebp
    1bb1:	c3                   	ret    
    1bb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1bb8:	39 cf                	cmp    %ecx,%edi
    1bba:	74 54                	je     1c10 <malloc+0xf0>
        p->s.size -= nunits;
    1bbc:	29 f9                	sub    %edi,%ecx
    1bbe:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1bc1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1bc4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1bc7:	89 15 28 2b 00 00    	mov    %edx,0x2b28
}
    1bcd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1bd0:	83 c0 08             	add    $0x8,%eax
}
    1bd3:	5b                   	pop    %ebx
    1bd4:	5e                   	pop    %esi
    1bd5:	5f                   	pop    %edi
    1bd6:	5d                   	pop    %ebp
    1bd7:	c3                   	ret    
    1bd8:	90                   	nop
    1bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1be0:	c7 05 28 2b 00 00 2c 	movl   $0x2b2c,0x2b28
    1be7:	2b 00 00 
    1bea:	c7 05 2c 2b 00 00 2c 	movl   $0x2b2c,0x2b2c
    1bf1:	2b 00 00 
    base.s.size = 0;
    1bf4:	b8 2c 2b 00 00       	mov    $0x2b2c,%eax
    1bf9:	c7 05 30 2b 00 00 00 	movl   $0x0,0x2b30
    1c00:	00 00 00 
    1c03:	e9 44 ff ff ff       	jmp    1b4c <malloc+0x2c>
    1c08:	90                   	nop
    1c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1c10:	8b 08                	mov    (%eax),%ecx
    1c12:	89 0a                	mov    %ecx,(%edx)
    1c14:	eb b1                	jmp    1bc7 <malloc+0xa7>
