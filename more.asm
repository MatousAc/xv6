
user/_more:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
void scroll(struct File file);
void line(struct File file);
void quit(struct File* file);
void bi();

int main(int argc, char* argv[]) {
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	53                   	push   %ebx
       e:	51                   	push   %ecx
       f:	83 ec 20             	sub    $0x20,%esp
      12:	8b 01                	mov    (%ecx),%eax
      14:	8b 51 04             	mov    0x4(%ecx),%edx
  // arg czeching
  if (argc < 2) {
      17:	83 f8 01             	cmp    $0x1,%eax
      1a:	0f 8e 9d 00 00 00    	jle    bd <main+0xbd>
    fprintf(2, "more: bad usage\nTry 'more --help' for more information.\n");
    exit();
  } else if (argc > 2) {
      20:	83 f8 02             	cmp    $0x2,%eax
      23:	0f 85 81 00 00 00    	jne    aa <main+0xaa>
  };
  struct File file;
  file.len = 0;
  file.edited = 0;
  file.curLine = 0;
  file.filename = argv[1];
      29:	8b 42 04             	mov    0x4(%edx),%eax
  file.len = 0;
      2c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  file.edited = 0;
      33:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  file.curLine = 0;
      3a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  file.filename = argv[1];
      41:	89 45 e0             	mov    %eax,-0x20(%ebp)
  file.lines = MakeLinkedList();
      44:	e8 c7 01 00 00       	call   210 <MakeLinkedList>

  // opening file
  file.fd = open(file.filename, O_RDONLY);
      49:	52                   	push   %edx
      4a:	52                   	push   %edx
      4b:	6a 00                	push   $0x0
      4d:	ff 75 e0             	pushl  -0x20(%ebp)
  file.lines = MakeLinkedList();
      50:	89 45 ec             	mov    %eax,-0x14(%ebp)
  file.fd = open(file.filename, O_RDONLY);
      53:	e8 42 12 00 00       	call   129a <open>
  if (file.fd == -1) {
      58:	83 c4 10             	add    $0x10,%esp
  file.fd = open(file.filename, O_RDONLY);
      5b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if (file.fd == -1) {
      5e:	83 c0 01             	add    $0x1,%eax
      61:	74 6d                	je     d0 <main+0xd0>
    fprintf(2, "file could not be opened\n",  file.filename);
  } else { 
    // populate Linked List
    gatherLines(&file);
      63:	8d 45 e0             	lea    -0x20(%ebp),%eax
      66:	83 ec 0c             	sub    $0xc,%esp
      69:	50                   	push   %eax
      6a:	e8 a1 04 00 00       	call   510 <gatherLines>
      6f:	83 c4 10             	add    $0x10,%esp
  }
  close(file.fd);
      72:	83 ec 0c             	sub    $0xc,%esp
      75:	ff 75 e4             	pushl  -0x1c(%ebp)
      78:	e8 05 12 00 00       	call   1282 <close>

  // loop
  while (cmdstr[0] != 'q') {
      7d:	83 c4 10             	add    $0x10,%esp
    cmdint = (char)steal(0);
      80:	83 ec 0c             	sub    $0xc,%esp
      83:	6a 00                	push   $0x0
      85:	e8 e8 11 00 00       	call   1272 <steal>
    cmd = (char) cmdint;
		printf("cmd: %d = %c\r", cmdint, cmd);
      8a:	83 c4 0c             	add    $0xc,%esp
    cmdint = (char)steal(0);
      8d:	89 c3                	mov    %eax,%ebx
		printf("cmd: %d = %c\r", cmdint, cmd);
      8f:	0f be c0             	movsbl %al,%eax
      92:	50                   	push   %eax
      93:	50                   	push   %eax
      94:	68 cf 17 00 00       	push   $0x17cf
      99:	e8 52 15 00 00       	call   15f0 <printf>
		// if(read(0, cmdstr, 1) == 0) exit();
		if (cmd == '\0') exit();
      9e:	83 c4 10             	add    $0x10,%esp
      a1:	84 db                	test   %bl,%bl
      a3:	75 db                	jne    80 <main+0x80>
      a5:	e8 a8 11 00 00       	call   1252 <exit>
    fprintf(2, "this version of more only supports one file at a time.\n");
      aa:	51                   	push   %ecx
      ab:	51                   	push   %ecx
      ac:	68 d8 18 00 00       	push   $0x18d8
      b1:	6a 02                	push   $0x2
      b3:	e8 18 15 00 00       	call   15d0 <fprintf>
    exit();
      b8:	e8 95 11 00 00       	call   1252 <exit>
    fprintf(2, "more: bad usage\nTry 'more --help' for more information.\n");
      bd:	53                   	push   %ebx
      be:	53                   	push   %ebx
      bf:	68 9c 18 00 00       	push   $0x189c
      c4:	6a 02                	push   $0x2
      c6:	e8 05 15 00 00       	call   15d0 <fprintf>
    exit();
      cb:	e8 82 11 00 00       	call   1252 <exit>
    fprintf(2, "file could not be opened\n",  file.filename);
      d0:	50                   	push   %eax
      d1:	ff 75 e0             	pushl  -0x20(%ebp)
      d4:	68 b5 17 00 00       	push   $0x17b5
      d9:	6a 02                	push   $0x2
      db:	e8 f0 14 00 00       	call   15d0 <fprintf>
      e0:	83 c4 10             	add    $0x10,%esp
      e3:	eb 8d                	jmp    72 <main+0x72>
      e5:	66 90                	xchg   %ax,%ax
      e7:	66 90                	xchg   %ax,%ax
      e9:	66 90                	xchg   %ax,%ax
      eb:	66 90                	xchg   %ax,%ax
      ed:	66 90                	xchg   %ax,%ax
      ef:	90                   	nop

000000f0 <safestrcpy>:
#include "LinkedList.h"
#define nullptr 0

char* safestrcpy(char *s, const char *t, int n) {
      f0:	55                   	push   %ebp
      f1:	89 e5                	mov    %esp,%ebp
      f3:	56                   	push   %esi
      f4:	53                   	push   %ebx
      f5:	8b 4d 10             	mov    0x10(%ebp),%ecx
      f8:	8b 45 08             	mov    0x8(%ebp),%eax
      fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
      fe:	85 c9                	test   %ecx,%ecx
     100:	7e 26                	jle    128 <safestrcpy+0x38>
     102:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
     106:	89 c1                	mov    %eax,%ecx
     108:	eb 17                	jmp    121 <safestrcpy+0x31>
     10a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
     110:	83 c2 01             	add    $0x1,%edx
     113:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
     117:	83 c1 01             	add    $0x1,%ecx
     11a:	84 db                	test   %bl,%bl
     11c:	88 59 ff             	mov    %bl,-0x1(%ecx)
     11f:	74 04                	je     125 <safestrcpy+0x35>
     121:	39 f2                	cmp    %esi,%edx
     123:	75 eb                	jne    110 <safestrcpy+0x20>
    ;
  *s = 0;
     125:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
     128:	5b                   	pop    %ebx
     129:	5e                   	pop    %esi
     12a:	5d                   	pop    %ebp
     12b:	c3                   	ret    
     12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000130 <nullNode>:

Node* nullNode(char* data) {
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
     133:	83 ec 14             	sub    $0x14,%esp
  struct Node* node = malloc(sizeof(Node));
     136:	6a 0c                	push   $0xc
     138:	e8 63 15 00 00       	call   16a0 <malloc>
  node->prev = nullptr;
  node->data = data;
     13d:	8b 55 08             	mov    0x8(%ebp),%edx
  node->prev = nullptr;
     140:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->next = nullptr;
     146:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  node->data = data;
     14d:	89 50 04             	mov    %edx,0x4(%eax)
  return node;
}
     150:	c9                   	leave  
     151:	c3                   	ret    
     152:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000160 <nodeAt>:

Node* nodeAt(struct LinkedList* list, int pos) {
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
     163:	53                   	push   %ebx
     164:	8b 45 08             	mov    0x8(%ebp),%eax
     167:	8b 55 0c             	mov    0xc(%ebp),%edx
  // for anything past the end:
  if (pos > list->len)
     16a:	8b 48 08             	mov    0x8(%eax),%ecx
     16d:	39 d1                	cmp    %edx,%ecx
     16f:	7c 1f                	jl     190 <nodeAt+0x30>
    return list->tail->prev;
  // for anything before the beginning:
  if ((pos < 0) && ((0 - pos) > list->len))
     171:	85 d2                	test   %edx,%edx
     173:	78 2b                	js     1a0 <nodeAt+0x40>
    while (++pos != 0)
      curNode = curNode->prev;
  } // start looking from front
  else {
    int cur = 0;
    curNode = list->head->next;
     175:	8b 00                	mov    (%eax),%eax
     177:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     17a:	74 0e                	je     18a <nodeAt+0x2a>
    int cur = 0;
     17c:	31 c9                	xor    %ecx,%ecx
     17e:	66 90                	xchg   %ax,%ax
      curNode = curNode->next;
      cur++;
     180:	83 c1 01             	add    $0x1,%ecx
      curNode = curNode->next;
     183:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     186:	39 ca                	cmp    %ecx,%edx
     188:	75 f6                	jne    180 <nodeAt+0x20>
    }
  }
  return curNode;
}
     18a:	5b                   	pop    %ebx
     18b:	5d                   	pop    %ebp
     18c:	c3                   	ret    
     18d:	8d 76 00             	lea    0x0(%esi),%esi
    return list->tail->prev;
     190:	8b 40 04             	mov    0x4(%eax),%eax
}
     193:	5b                   	pop    %ebx
     194:	5d                   	pop    %ebp
    return list->tail->prev;
     195:	8b 00                	mov    (%eax),%eax
}
     197:	c3                   	ret    
     198:	90                   	nop
     199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if ((pos < 0) && ((0 - pos) > list->len))
     1a0:	89 d3                	mov    %edx,%ebx
     1a2:	f7 db                	neg    %ebx
     1a4:	39 d9                	cmp    %ebx,%ecx
     1a6:	7c 18                	jl     1c0 <nodeAt+0x60>
    while (++pos != 0)
     1a8:	83 c2 01             	add    $0x1,%edx
    curNode = list->tail;
     1ab:	8b 40 04             	mov    0x4(%eax),%eax
    while (++pos != 0)
     1ae:	74 da                	je     18a <nodeAt+0x2a>
     1b0:	83 c2 01             	add    $0x1,%edx
      curNode = curNode->prev;
     1b3:	8b 00                	mov    (%eax),%eax
    while (++pos != 0)
     1b5:	75 f9                	jne    1b0 <nodeAt+0x50>
}
     1b7:	5b                   	pop    %ebx
     1b8:	5d                   	pop    %ebp
     1b9:	c3                   	ret    
     1ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return list->head->next;
     1c0:	8b 00                	mov    (%eax),%eax
     1c2:	8b 40 08             	mov    0x8(%eax),%eax
     1c5:	eb c3                	jmp    18a <nodeAt+0x2a>
     1c7:	89 f6                	mov    %esi,%esi
     1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001d0 <destroyNode>:

void destroyNode(struct LinkedList* list, struct Node* self) {
     1d0:	55                   	push   %ebp
     1d1:	89 e5                	mov    %esp,%ebp
     1d3:	56                   	push   %esi
     1d4:	53                   	push   %ebx
     1d5:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     1d8:	8b 75 08             	mov    0x8(%ebp),%esi
    self->prev->next = self->next;
    self->next->prev = self->prev;

    free(self->data);
     1db:	83 ec 0c             	sub    $0xc,%esp
    self->prev->next = self->next;
     1de:	8b 03                	mov    (%ebx),%eax
     1e0:	8b 53 08             	mov    0x8(%ebx),%edx
     1e3:	89 50 08             	mov    %edx,0x8(%eax)
    self->next->prev = self->prev;
     1e6:	8b 43 08             	mov    0x8(%ebx),%eax
     1e9:	8b 13                	mov    (%ebx),%edx
     1eb:	89 10                	mov    %edx,(%eax)
    free(self->data);
     1ed:	ff 73 04             	pushl  0x4(%ebx)
     1f0:	e8 1b 14 00 00       	call   1610 <free>
    free(self);
     1f5:	89 1c 24             	mov    %ebx,(%esp)
     1f8:	e8 13 14 00 00       	call   1610 <free>
    list->len--;
     1fd:	83 6e 08 01          	subl   $0x1,0x8(%esi)
}
     201:	83 c4 10             	add    $0x10,%esp
     204:	8d 65 f8             	lea    -0x8(%ebp),%esp
     207:	5b                   	pop    %ebx
     208:	5e                   	pop    %esi
     209:	5d                   	pop    %ebp
     20a:	c3                   	ret    
     20b:	90                   	nop
     20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000210 <MakeLinkedList>:

LinkedList* MakeLinkedList() {
     210:	55                   	push   %ebp
     211:	89 e5                	mov    %esp,%ebp
     213:	56                   	push   %esi
     214:	53                   	push   %ebx
  struct LinkedList* list = malloc(sizeof(LinkedList));
     215:	83 ec 0c             	sub    $0xc,%esp
     218:	6a 0c                	push   $0xc
     21a:	e8 81 14 00 00       	call   16a0 <malloc>
  struct Node* node = malloc(sizeof(Node));
     21f:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  struct LinkedList* list = malloc(sizeof(LinkedList));
     226:	89 c6                	mov    %eax,%esi
  struct Node* node = malloc(sizeof(Node));
     228:	e8 73 14 00 00       	call   16a0 <malloc>
     22d:	89 c3                	mov    %eax,%ebx
  node->prev = nullptr;
     22f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->data = data;
     235:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  node->next = nullptr;
     23c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  struct Node* node = malloc(sizeof(Node));
     243:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     24a:	e8 51 14 00 00       	call   16a0 <malloc>
  node->data = data;
     24f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  Node* head = nullNode(nullptr);
  Node* tail = nullNode(nullptr);
  head->prev = nullptr;
  head->next = tail;
     256:	89 43 08             	mov    %eax,0x8(%ebx)
  head->prev = nullptr;
     259:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  tail->prev = head;
     25f:	89 18                	mov    %ebx,(%eax)
  tail->next = nullptr;
     261:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)

  list->len = 0;
  list->head = head;
  list->tail = tail;
     268:	89 46 04             	mov    %eax,0x4(%esi)
  return list;
}
     26b:	89 f0                	mov    %esi,%eax
  list->len = 0;
     26d:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
  list->head = head;
     274:	89 1e                	mov    %ebx,(%esi)
}
     276:	8d 65 f8             	lea    -0x8(%ebp),%esp
     279:	5b                   	pop    %ebx
     27a:	5e                   	pop    %esi
     27b:	5d                   	pop    %ebp
     27c:	c3                   	ret    
     27d:	8d 76 00             	lea    0x0(%esi),%esi

00000280 <insert>:

void insert(struct LinkedList* list, char* data, int pos) {
     280:	55                   	push   %ebp
     281:	89 e5                	mov    %esp,%ebp
     283:	57                   	push   %edi
     284:	56                   	push   %esi
     285:	53                   	push   %ebx
     286:	83 ec 0c             	sub    $0xc,%esp
  struct Node* atPos = nodeAt(list, pos);
     289:	ff 75 10             	pushl  0x10(%ebp)
     28c:	ff 75 08             	pushl  0x8(%ebp)
void insert(struct LinkedList* list, char* data, int pos) {
     28f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct Node* atPos = nodeAt(list, pos);
     292:	e8 c9 fe ff ff       	call   160 <nodeAt>
     297:	83 ec 04             	sub    $0x4,%esp
     29a:	89 c6                	mov    %eax,%esi
  char* newData = (char*)malloc(sizeof(char) * 1000);
     29c:	68 e8 03 00 00       	push   $0x3e8
     2a1:	e8 fa 13 00 00       	call   16a0 <malloc>
     2a6:	8d 8b e7 03 00 00    	lea    0x3e7(%ebx),%ecx
     2ac:	89 c7                	mov    %eax,%edi
     2ae:	83 c4 10             	add    $0x10,%esp
     2b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(--n > 0 && (*s++ = *t++) != 0)
     2b8:	83 c3 01             	add    $0x1,%ebx
     2bb:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     2bf:	83 c0 01             	add    $0x1,%eax
     2c2:	84 d2                	test   %dl,%dl
     2c4:	88 50 ff             	mov    %dl,-0x1(%eax)
     2c7:	74 04                	je     2cd <insert+0x4d>
     2c9:	39 d9                	cmp    %ebx,%ecx
     2cb:	75 eb                	jne    2b8 <insert+0x38>
  newData = safestrcpy(newData, data, (sizeof(char) * 1000));
  struct Node* new = malloc(sizeof(Node));
     2cd:	83 ec 0c             	sub    $0xc,%esp
  *s = 0;
     2d0:	c6 00 00             	movb   $0x0,(%eax)
  struct Node* new = malloc(sizeof(Node));
     2d3:	6a 0c                	push   $0xc
     2d5:	e8 c6 13 00 00       	call   16a0 <malloc>

  new->data = newData;
     2da:	89 78 04             	mov    %edi,0x4(%eax)
  new->prev = atPos->prev;
     2dd:	8b 16                	mov    (%esi),%edx
  new->next = atPos;
     2df:	89 70 08             	mov    %esi,0x8(%eax)
  new->prev = atPos->prev;
     2e2:	89 10                	mov    %edx,(%eax)
  new->prev->next = new;
     2e4:	89 42 08             	mov    %eax,0x8(%edx)
  atPos->prev = new;
     2e7:	89 06                	mov    %eax,(%esi)
  list->len++;
     2e9:	8b 45 08             	mov    0x8(%ebp),%eax
     2ec:	83 40 08 01          	addl   $0x1,0x8(%eax)
}
     2f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
     2f3:	5b                   	pop    %ebx
     2f4:	5e                   	pop    %esi
     2f5:	5f                   	pop    %edi
     2f6:	5d                   	pop    %ebp
     2f7:	c3                   	ret    
     2f8:	90                   	nop
     2f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000300 <prepend>:

void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
     300:	55                   	push   %ebp
     301:	89 e5                	mov    %esp,%ebp
     303:	83 ec 0c             	sub    $0xc,%esp
     306:	6a 00                	push   $0x0
     308:	ff 75 0c             	pushl  0xc(%ebp)
     30b:	ff 75 08             	pushl  0x8(%ebp)
     30e:	e8 6d ff ff ff       	call   280 <insert>
     313:	83 c4 10             	add    $0x10,%esp
     316:	c9                   	leave  
     317:	c3                   	ret    
     318:	90                   	nop
     319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000320 <append>:
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     320:	55                   	push   %ebp
     321:	89 e5                	mov    %esp,%ebp
     323:	83 ec 0c             	sub    $0xc,%esp
     326:	8b 45 08             	mov    0x8(%ebp),%eax
     329:	ff 70 08             	pushl  0x8(%eax)
     32c:	ff 75 0c             	pushl  0xc(%ebp)
     32f:	50                   	push   %eax
     330:	e8 4b ff ff ff       	call   280 <insert>
     335:	83 c4 10             	add    $0x10,%esp
     338:	c9                   	leave  
     339:	c3                   	ret    
     33a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000340 <destroyLinkedList>:

void destroyLinkedList(struct LinkedList* list) {
     340:	55                   	push   %ebp
     341:	89 e5                	mov    %esp,%ebp
     343:	56                   	push   %esi
     344:	53                   	push   %ebx
     345:	8b 75 08             	mov    0x8(%ebp),%esi
  struct Node* curNode = list->head;
     348:	8b 1e                	mov    (%esi),%ebx
  while (curNode != list->tail) {
     34a:	8b 46 04             	mov    0x4(%esi),%eax
     34d:	39 c3                	cmp    %eax,%ebx
     34f:	74 29                	je     37a <destroyLinkedList+0x3a>
     351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
     358:	8b 5b 08             	mov    0x8(%ebx),%ebx
    free(curNode->prev->data);
     35b:	83 ec 0c             	sub    $0xc,%esp
     35e:	8b 03                	mov    (%ebx),%eax
     360:	ff 70 04             	pushl  0x4(%eax)
     363:	e8 a8 12 00 00       	call   1610 <free>
    free(curNode->prev);
     368:	58                   	pop    %eax
     369:	ff 33                	pushl  (%ebx)
     36b:	e8 a0 12 00 00       	call   1610 <free>
  while (curNode != list->tail) {
     370:	8b 46 04             	mov    0x4(%esi),%eax
     373:	83 c4 10             	add    $0x10,%esp
     376:	39 d8                	cmp    %ebx,%eax
     378:	75 de                	jne    358 <destroyLinkedList+0x18>
  }
  free(curNode);
     37a:	83 ec 0c             	sub    $0xc,%esp
     37d:	50                   	push   %eax
     37e:	e8 8d 12 00 00       	call   1610 <free>
  free(list);
     383:	89 75 08             	mov    %esi,0x8(%ebp)
     386:	83 c4 10             	add    $0x10,%esp
     389:	8d 65 f8             	lea    -0x8(%ebp),%esp
     38c:	5b                   	pop    %ebx
     38d:	5e                   	pop    %esi
     38e:	5d                   	pop    %ebp
  free(list);
     38f:	e9 7c 12 00 00       	jmp    1610 <free>
     394:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     39a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003a0 <confirmation>:
#include "helpers.h"

int confirmation() {
     3a0:	55                   	push   %ebp
     3a1:	89 e5                	mov    %esp,%ebp
     3a3:	53                   	push   %ebx
  // get response
  char buf[MAXLINESIZE];
  int nbuf = sizeof(buf);
  memset(buf, 0, nbuf);
     3a4:	8d 9d 10 fc ff ff    	lea    -0x3f0(%ebp),%ebx
int confirmation() {
     3aa:	81 ec f8 03 00 00    	sub    $0x3f8,%esp
  memset(buf, 0, nbuf);
     3b0:	68 e8 03 00 00       	push   $0x3e8
     3b5:	6a 00                	push   $0x0
     3b7:	53                   	push   %ebx
     3b8:	e8 f3 0c 00 00       	call   10b0 <memset>
  gets(buf, nbuf);
     3bd:	58                   	pop    %eax
     3be:	5a                   	pop    %edx
     3bf:	68 e8 03 00 00       	push   $0x3e8
     3c4:	53                   	push   %ebx
     3c5:	e8 46 0d 00 00       	call   1110 <gets>
  // determine output
  switch (buf[0]) {
     3ca:	0f b6 85 10 fc ff ff 	movzbl -0x3f0(%ebp),%eax
     3d1:	83 c4 10             	add    $0x10,%esp
     3d4:	3c 59                	cmp    $0x59,%al
     3d6:	74 18                	je     3f0 <confirmation+0x50>
     3d8:	3c 79                	cmp    $0x79,%al
     3da:	74 14                	je     3f0 <confirmation+0x50>
  case 'Y':
  case 'y':
    return 0;
  default:
    return 1;
     3dc:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
     3e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3e4:	c9                   	leave  
     3e5:	c3                   	ret    
     3e6:	8d 76 00             	lea    0x0(%esi),%esi
     3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return 0;
     3f0:	31 c0                	xor    %eax,%eax
}
     3f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3f5:	c9                   	leave  
     3f6:	c3                   	ret    
     3f7:	89 f6                	mov    %esi,%esi
     3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <normalizeRange>:
    return 1;

  return 0;
}

int normalizeRange(File file, int* sp, int* ep) {
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	53                   	push   %ebx
     404:	8b 4d 24             	mov    0x24(%ebp),%ecx
  int l = file.len;
     407:	8b 45 18             	mov    0x18(%ebp),%eax
int normalizeRange(File file, int* sp, int* ep) {
     40a:	8b 5d 20             	mov    0x20(%ebp),%ebx
  if (*ep > l) *ep = l;
     40d:	8b 11                	mov    (%ecx),%edx
     40f:	39 c2                	cmp    %eax,%edx
     411:	7e 45                	jle    458 <normalizeRange+0x58>
     413:	89 01                	mov    %eax,(%ecx)
     415:	89 c2                	mov    %eax,%edx
  else if (*ep < 1) *ep += l + 1;
  if (*ep < 1) *ep = 1;
     417:	85 d2                	test   %edx,%edx
     419:	7f 06                	jg     421 <normalizeRange+0x21>
     41b:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)

  if (*sp > l) *sp = l;
     421:	8b 13                	mov    (%ebx),%edx
     423:	39 c2                	cmp    %eax,%edx
     425:	7e 21                	jle    448 <normalizeRange+0x48>
     427:	89 03                	mov    %eax,(%ebx)
     429:	89 c2                	mov    %eax,%edx
  else if (*sp < 1) *sp += l + 1;
  if (*sp < 1) *sp = 1;
     42b:	85 d2                	test   %edx,%edx
     42d:	7f 0b                	jg     43a <normalizeRange+0x3a>
     42f:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
     435:	ba 01 00 00 00       	mov    $0x1,%edx
  if ((*ep - *sp) < 0)
     43a:	8b 01                	mov    (%ecx),%eax
    return 1;
  return 0;
}
     43c:	5b                   	pop    %ebx
     43d:	5d                   	pop    %ebp
  if ((*ep - *sp) < 0)
     43e:	29 d0                	sub    %edx,%eax
     440:	c1 e8 1f             	shr    $0x1f,%eax
}
     443:	c3                   	ret    
     444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*sp < 1) *sp += l + 1;
     448:	85 d2                	test   %edx,%edx
     44a:	7f ee                	jg     43a <normalizeRange+0x3a>
     44c:	8d 54 10 01          	lea    0x1(%eax,%edx,1),%edx
     450:	89 13                	mov    %edx,(%ebx)
     452:	eb d7                	jmp    42b <normalizeRange+0x2b>
     454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*ep < 1) *ep += l + 1;
     458:	85 d2                	test   %edx,%edx
     45a:	7f c5                	jg     421 <normalizeRange+0x21>
     45c:	8d 54 02 01          	lea    0x1(%edx,%eax,1),%edx
     460:	89 11                	mov    %edx,(%ecx)
     462:	eb b3                	jmp    417 <normalizeRange+0x17>
     464:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     46a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000470 <numLines>:

int numLines(int start, int end) {
     470:	55                   	push   %ebp
     471:	89 e5                	mov    %esp,%ebp
  return (end - start) + 1;
     473:	8b 45 0c             	mov    0xc(%ebp),%eax
     476:	2b 45 08             	sub    0x8(%ebp),%eax
}
     479:	5d                   	pop    %ebp
  return (end - start) + 1;
     47a:	83 c0 01             	add    $0x1,%eax
}
     47d:	c3                   	ret    
     47e:	66 90                	xchg   %ax,%ax

00000480 <getLine>:
    append(file->lines, line);
    file->len++;
  }
}

int getLine(int fileptr, char line[]) {
     480:	55                   	push   %ebp
     481:	89 e5                	mov    %esp,%ebp
     483:	57                   	push   %edi
     484:	56                   	push   %esi
     485:	53                   	push   %ebx
  int len = strlen(line);
  memset(line, 0, len);
  char c[1];
  int i;
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     486:	31 ff                	xor    %edi,%edi
     488:	8d 75 e7             	lea    -0x19(%ebp),%esi
int getLine(int fileptr, char line[]) {
     48b:	83 ec 28             	sub    $0x28,%esp
     48e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int len = strlen(line);
     491:	53                   	push   %ebx
     492:	e8 e9 0b 00 00       	call   1080 <strlen>
  memset(line, 0, len);
     497:	83 c4 0c             	add    $0xc,%esp
     49a:	50                   	push   %eax
     49b:	6a 00                	push   $0x0
     49d:	53                   	push   %ebx
     49e:	e8 0d 0c 00 00       	call   10b0 <memset>
     4a3:	83 c4 10             	add    $0x10,%esp
     4a6:	eb 1e                	jmp    4c6 <getLine+0x46>
     4a8:	90                   	nop
     4a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (read(fileptr, c, 1) == 0) return strlen(line);
    if (*c == '\n') break;
     4b0:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     4b4:	3c 0a                	cmp    $0xa,%al
     4b6:	74 38                	je     4f0 <getLine+0x70>
    line[i] = *c;
     4b8:	88 04 3b             	mov    %al,(%ebx,%edi,1)
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     4bb:	83 c7 01             	add    $0x1,%edi
     4be:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
     4c4:	74 42                	je     508 <getLine+0x88>
    if (read(fileptr, c, 1) == 0) return strlen(line);
     4c6:	83 ec 04             	sub    $0x4,%esp
     4c9:	6a 01                	push   $0x1
     4cb:	56                   	push   %esi
     4cc:	ff 75 08             	pushl  0x8(%ebp)
     4cf:	e8 96 0d 00 00       	call   126a <read>
     4d4:	83 c4 10             	add    $0x10,%esp
     4d7:	85 c0                	test   %eax,%eax
     4d9:	75 d5                	jne    4b0 <getLine+0x30>
     4db:	83 ec 0c             	sub    $0xc,%esp
     4de:	53                   	push   %ebx
     4df:	e8 9c 0b 00 00       	call   1080 <strlen>
     4e4:	83 c4 10             	add    $0x10,%esp
  }
  line[i + 1] = '\0';
  return 1;
}
     4e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     4ea:	5b                   	pop    %ebx
     4eb:	5e                   	pop    %esi
     4ec:	5f                   	pop    %edi
     4ed:	5d                   	pop    %ebp
     4ee:	c3                   	ret    
     4ef:	90                   	nop
     4f0:	8d 57 01             	lea    0x1(%edi),%edx
  line[i + 1] = '\0';
     4f3:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
     4f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
     4fa:	b8 01 00 00 00       	mov    $0x1,%eax
}
     4ff:	5b                   	pop    %ebx
     500:	5e                   	pop    %esi
     501:	5f                   	pop    %edi
     502:	5d                   	pop    %ebp
     503:	c3                   	ret    
     504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     508:	ba e8 03 00 00       	mov    $0x3e8,%edx
     50d:	eb e4                	jmp    4f3 <getLine+0x73>
     50f:	90                   	nop

00000510 <gatherLines>:
void gatherLines(File* file) {
     510:	55                   	push   %ebp
     511:	89 e5                	mov    %esp,%ebp
     513:	56                   	push   %esi
     514:	53                   	push   %ebx
     515:	8d b5 10 fc ff ff    	lea    -0x3f0(%ebp),%esi
     51b:	81 ec f0 03 00 00    	sub    $0x3f0,%esp
     521:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while (getLine(file->fd, line)) {
     524:	eb 21                	jmp    547 <gatherLines+0x37>
     526:	8d 76 00             	lea    0x0(%esi),%esi
     529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    append(file->lines, line);
     530:	8b 43 0c             	mov    0xc(%ebx),%eax
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     533:	83 ec 04             	sub    $0x4,%esp
     536:	ff 70 08             	pushl  0x8(%eax)
     539:	56                   	push   %esi
     53a:	50                   	push   %eax
     53b:	e8 40 fd ff ff       	call   280 <insert>
    file->len++;
     540:	83 43 10 01          	addl   $0x1,0x10(%ebx)
     544:	83 c4 10             	add    $0x10,%esp
  while (getLine(file->fd, line)) {
     547:	83 ec 08             	sub    $0x8,%esp
     54a:	56                   	push   %esi
     54b:	ff 73 04             	pushl  0x4(%ebx)
     54e:	e8 2d ff ff ff       	call   480 <getLine>
     553:	83 c4 10             	add    $0x10,%esp
     556:	85 c0                	test   %eax,%eax
     558:	75 d6                	jne    530 <gatherLines+0x20>
}
     55a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     55d:	5b                   	pop    %ebx
     55e:	5e                   	pop    %esi
     55f:	5d                   	pop    %ebp
     560:	c3                   	ret    
     561:	eb 0d                	jmp    570 <unline>
     563:	90                   	nop
     564:	90                   	nop
     565:	90                   	nop
     566:	90                   	nop
     567:	90                   	nop
     568:	90                   	nop
     569:	90                   	nop
     56a:	90                   	nop
     56b:	90                   	nop
     56c:	90                   	nop
     56d:	90                   	nop
     56e:	90                   	nop
     56f:	90                   	nop

00000570 <unline>:
  int end = find(args, delimiter);
  substr(dest, args, 0, end);
  substr(args, args, end + 1, (int) strlen(args));
}

void unline(char* str) {
     570:	55                   	push   %ebp
     571:	89 e5                	mov    %esp,%ebp
     573:	53                   	push   %ebx
     574:	83 ec 10             	sub    $0x10,%esp
     577:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str) - 1;
     57a:	53                   	push   %ebx
     57b:	e8 00 0b 00 00       	call   1080 <strlen>
     580:	8d 50 ff             	lea    -0x1(%eax),%edx
  for (; len > 0; len--) {
     583:	83 c4 10             	add    $0x10,%esp
     586:	85 d2                	test   %edx,%edx
     588:	7e 36                	jle    5c0 <unline+0x50>
    char c = str[len];
    if (c == '\n')
     58a:	80 7c 03 ff 0a       	cmpb   $0xa,-0x1(%ebx,%eax,1)
     58f:	74 2f                	je     5c0 <unline+0x50>
     591:	8d 44 03 fe          	lea    -0x2(%ebx,%eax,1),%eax
     595:	eb 12                	jmp    5a9 <unline+0x39>
     597:	89 f6                	mov    %esi,%esi
     599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     5a0:	83 e8 01             	sub    $0x1,%eax
     5a3:	80 78 01 0a          	cmpb   $0xa,0x1(%eax)
     5a7:	74 06                	je     5af <unline+0x3f>
  for (; len > 0; len--) {
     5a9:	39 c3                	cmp    %eax,%ebx
     5ab:	89 c2                	mov    %eax,%edx
     5ad:	75 f1                	jne    5a0 <unline+0x30>
      break;
  }
  str[len] = '\0';
     5af:	c6 02 00             	movb   $0x0,(%edx)
}
     5b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5b5:	c9                   	leave  
     5b6:	c3                   	ret    
     5b7:	89 f6                	mov    %esi,%esi
     5b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     5c0:	01 da                	add    %ebx,%edx
  str[len] = '\0';
     5c2:	c6 02 00             	movb   $0x0,(%edx)
}
     5c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5c8:	c9                   	leave  
     5c9:	c3                   	ret    
     5ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005d0 <find>:


// str ops
int find(char* str, char c) {
     5d0:	55                   	push   %ebp
     5d1:	89 e5                	mov    %esp,%ebp
     5d3:	57                   	push   %edi
     5d4:	56                   	push   %esi
     5d5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     5d6:	31 db                	xor    %ebx,%ebx
int find(char* str, char c) {
     5d8:	83 ec 0c             	sub    $0xc,%esp
     5db:	8b 75 08             	mov    0x8(%ebp),%esi
     5de:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
  for (int i = 0; i < strlen(str); i++)
     5e2:	eb 0e                	jmp    5f2 <find+0x22>
     5e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     5e8:	89 f8                	mov    %edi,%eax
     5ea:	38 04 1e             	cmp    %al,(%esi,%ebx,1)
     5ed:	74 18                	je     607 <find+0x37>
  for (int i = 0; i < strlen(str); i++)
     5ef:	83 c3 01             	add    $0x1,%ebx
     5f2:	83 ec 0c             	sub    $0xc,%esp
     5f5:	56                   	push   %esi
     5f6:	e8 85 0a 00 00       	call   1080 <strlen>
     5fb:	83 c4 10             	add    $0x10,%esp
     5fe:	39 d8                	cmp    %ebx,%eax
     600:	77 e6                	ja     5e8 <find+0x18>
  return -1;
     602:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
     607:	8d 65 f4             	lea    -0xc(%ebp),%esp
     60a:	89 d8                	mov    %ebx,%eax
     60c:	5b                   	pop    %ebx
     60d:	5e                   	pop    %esi
     60e:	5f                   	pop    %edi
     60f:	5d                   	pop    %ebp
     610:	c3                   	ret    
     611:	eb 0d                	jmp    620 <substr>
     613:	90                   	nop
     614:	90                   	nop
     615:	90                   	nop
     616:	90                   	nop
     617:	90                   	nop
     618:	90                   	nop
     619:	90                   	nop
     61a:	90                   	nop
     61b:	90                   	nop
     61c:	90                   	nop
     61d:	90                   	nop
     61e:	90                   	nop
     61f:	90                   	nop

00000620 <substr>:

void substr(char* dest, char* str, int start, int end) {
     620:	55                   	push   %ebp
     621:	89 e5                	mov    %esp,%ebp
     623:	57                   	push   %edi
     624:	56                   	push   %esi
     625:	53                   	push   %ebx
     626:	83 ec 18             	sub    $0x18,%esp
     629:	8b 7d 14             	mov    0x14(%ebp),%edi
  int len = strlen(str);
     62c:	ff 75 0c             	pushl  0xc(%ebp)
void substr(char* dest, char* str, int start, int end) {
     62f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     632:	8b 75 08             	mov    0x8(%ebp),%esi
  int len = strlen(str);
     635:	e8 46 0a 00 00       	call   1080 <strlen>
     63a:	83 c4 10             	add    $0x10,%esp
     63d:	39 f8                	cmp    %edi,%eax
     63f:	0f 4e f8             	cmovle %eax,%edi
  if (end > len) end = len;
  int s = 0, i = start;
  while (i < end)
     642:	39 df                	cmp    %ebx,%edi
     644:	7e 1c                	jle    662 <substr+0x42>
     646:	8b 45 0c             	mov    0xc(%ebp),%eax
     649:	29 df                	sub    %ebx,%edi
  int s = 0, i = start;
     64b:	31 d2                	xor    %edx,%edx
     64d:	01 c3                	add    %eax,%ebx
     64f:	90                   	nop
    dest[s++] = str[i++];
     650:	83 c2 01             	add    $0x1,%edx
     653:	0f b6 44 13 ff       	movzbl -0x1(%ebx,%edx,1),%eax
  while (i < end)
     658:	39 fa                	cmp    %edi,%edx
    dest[s++] = str[i++];
     65a:	88 44 16 ff          	mov    %al,-0x1(%esi,%edx,1)
  while (i < end)
     65e:	75 f0                	jne    650 <substr+0x30>
     660:	01 d6                	add    %edx,%esi
  dest[s] = '\0';
     662:	c6 06 00             	movb   $0x0,(%esi)
}
     665:	8d 65 f4             	lea    -0xc(%ebp),%esp
     668:	5b                   	pop    %ebx
     669:	5e                   	pop    %esi
     66a:	5f                   	pop    %edi
     66b:	5d                   	pop    %ebp
     66c:	c3                   	ret    
     66d:	8d 76 00             	lea    0x0(%esi),%esi

00000670 <getArg>:
void getArg(char* dest, char* args, char delimiter) {
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	57                   	push   %edi
     674:	56                   	push   %esi
     675:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     676:	31 db                	xor    %ebx,%ebx
void getArg(char* dest, char* args, char delimiter) {
     678:	83 ec 1c             	sub    $0x1c,%esp
     67b:	8b 75 0c             	mov    0xc(%ebp),%esi
     67e:	0f b6 7d 10          	movzbl 0x10(%ebp),%edi
     682:	eb 10                	jmp    694 <getArg+0x24>
     684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     688:	89 f8                	mov    %edi,%eax
     68a:	3a 04 1e             	cmp    (%esi,%ebx,1),%al
     68d:	8d 53 01             	lea    0x1(%ebx),%edx
     690:	74 19                	je     6ab <getArg+0x3b>
     692:	89 d3                	mov    %edx,%ebx
  for (int i = 0; i < strlen(str); i++)
     694:	83 ec 0c             	sub    $0xc,%esp
     697:	56                   	push   %esi
     698:	e8 e3 09 00 00       	call   1080 <strlen>
     69d:	83 c4 10             	add    $0x10,%esp
     6a0:	39 c3                	cmp    %eax,%ebx
     6a2:	72 e4                	jb     688 <getArg+0x18>
     6a4:	31 d2                	xor    %edx,%edx
  return -1;
     6a6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  substr(dest, args, 0, end);
     6ab:	53                   	push   %ebx
     6ac:	6a 00                	push   $0x0
     6ae:	56                   	push   %esi
     6af:	ff 75 08             	pushl  0x8(%ebp)
     6b2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     6b5:	e8 66 ff ff ff       	call   620 <substr>
  substr(args, args, end + 1, (int) strlen(args));
     6ba:	89 34 24             	mov    %esi,(%esp)
     6bd:	e8 be 09 00 00       	call   1080 <strlen>
     6c2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     6c5:	50                   	push   %eax
     6c6:	52                   	push   %edx
     6c7:	56                   	push   %esi
     6c8:	56                   	push   %esi
     6c9:	e8 52 ff ff ff       	call   620 <substr>
}
     6ce:	83 c4 20             	add    $0x20,%esp
     6d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6d4:	5b                   	pop    %ebx
     6d5:	5e                   	pop    %esi
     6d6:	5f                   	pop    %edi
     6d7:	5d                   	pop    %ebp
     6d8:	c3                   	ret    
     6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006e0 <collectRange>:
int collectRange(char* args, int* startptr, int* endptr) {
     6e0:	55                   	push   %ebp
     6e1:	89 e5                	mov    %esp,%ebp
     6e3:	57                   	push   %edi
     6e4:	56                   	push   %esi
     6e5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     6e6:	31 f6                	xor    %esi,%esi
int collectRange(char* args, int* startptr, int* endptr) {
     6e8:	83 ec 2c             	sub    $0x2c,%esp
     6eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
     6ee:	eb 09                	jmp    6f9 <collectRange+0x19>
    if (str[i] == c) return i;
     6f0:	80 3c 33 3a          	cmpb   $0x3a,(%ebx,%esi,1)
     6f4:	74 42                	je     738 <collectRange+0x58>
  for (int i = 0; i < strlen(str); i++)
     6f6:	83 c6 01             	add    $0x1,%esi
     6f9:	83 ec 0c             	sub    $0xc,%esp
     6fc:	53                   	push   %ebx
     6fd:	e8 7e 09 00 00       	call   1080 <strlen>
     702:	83 c4 10             	add    $0x10,%esp
     705:	39 c6                	cmp    %eax,%esi
     707:	72 e7                	jb     6f0 <collectRange+0x10>
    if (args[0] == '-') {
     709:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     70c:	0f 84 d6 00 00 00    	je     7e8 <collectRange+0x108>
      *startptr = atoi(args);
     712:	83 ec 0c             	sub    $0xc,%esp
     715:	53                   	push   %ebx
     716:	e8 c5 0a 00 00       	call   11e0 <atoi>
     71b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     71e:	83 c4 10             	add    $0x10,%esp
     721:	89 01                	mov    %eax,(%ecx)
    *endptr = *startptr;
     723:	8b 4d 10             	mov    0x10(%ebp),%ecx
     726:	89 01                	mov    %eax,(%ecx)
    return 0;
     728:	31 c0                	xor    %eax,%eax
}
     72a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     72d:	5b                   	pop    %ebx
     72e:	5e                   	pop    %esi
     72f:	5f                   	pop    %edi
     730:	5d                   	pop    %ebp
     731:	c3                   	ret    
     732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  getArg(startstr, args, ':');
     738:	8d 75 de             	lea    -0x22(%ebp),%esi
     73b:	83 ec 04             	sub    $0x4,%esp
     73e:	6a 3a                	push   $0x3a
     740:	53                   	push   %ebx
     741:	56                   	push   %esi
     742:	e8 29 ff ff ff       	call   670 <getArg>
  if (startstr[0] == '-') {
     747:	83 c4 10             	add    $0x10,%esp
     74a:	80 7d de 2d          	cmpb   $0x2d,-0x22(%ebp)
     74e:	0f 84 3c 01 00 00    	je     890 <collectRange+0x1b0>
  int negStartFlag = 0, negEndFlag = 0;
     754:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     75b:	31 ff                	xor    %edi,%edi
  if (endstr[0] == '-') {
     75d:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     760:	0f 84 0a 01 00 00    	je     870 <collectRange+0x190>
  if (strcmp(startstr, "\0") == 0) *startptr = 1;
     766:	83 ec 08             	sub    $0x8,%esp
     769:	68 98 17 00 00       	push   $0x1798
     76e:	56                   	push   %esi
     76f:	e8 bc 08 00 00       	call   1030 <strcmp>
     774:	83 c4 10             	add    $0x10,%esp
     777:	85 c0                	test   %eax,%eax
     779:	0f 85 d1 00 00 00    	jne    850 <collectRange+0x170>
     77f:	8b 45 0c             	mov    0xc(%ebp),%eax
     782:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  if (strcmp(endstr, "\0") == 0) *endptr = -1;
     788:	83 ec 08             	sub    $0x8,%esp
     78b:	68 98 17 00 00       	push   $0x1798
     790:	53                   	push   %ebx
     791:	e8 9a 08 00 00       	call   1030 <strcmp>
     796:	83 c4 10             	add    $0x10,%esp
     799:	85 c0                	test   %eax,%eax
     79b:	0f 85 97 00 00 00    	jne    838 <collectRange+0x158>
     7a1:	8b 45 10             	mov    0x10(%ebp),%eax
     7a4:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  if (negStartFlag) *startptr = 0 - *startptr;
     7aa:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7ad:	85 c0                	test   %eax,%eax
     7af:	74 05                	je     7b6 <collectRange+0xd6>
     7b1:	8b 45 0c             	mov    0xc(%ebp),%eax
     7b4:	f7 18                	negl   (%eax)
  if (negEndFlag) *endptr = 0 - *endptr;
     7b6:	85 ff                	test   %edi,%edi
     7b8:	74 05                	je     7bf <collectRange+0xdf>
     7ba:	8b 45 10             	mov    0x10(%ebp),%eax
     7bd:	f7 18                	negl   (%eax)
  if (((*startptr > 0 && *endptr > 0) || 
     7bf:	8b 45 0c             	mov    0xc(%ebp),%eax
     7c2:	8b 00                	mov    (%eax),%eax
     7c4:	83 f8 00             	cmp    $0x0,%eax
     7c7:	7e 4f                	jle    818 <collectRange+0x138>
     7c9:	8b 55 10             	mov    0x10(%ebp),%edx
     7cc:	8b 12                	mov    (%edx),%edx
     7ce:	85 d2                	test   %edx,%edx
     7d0:	7e 55                	jle    827 <collectRange+0x147>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     7d2:	39 d0                	cmp    %edx,%eax
     7d4:	0f 9f c0             	setg   %al
}
     7d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     7da:	0f b6 c0             	movzbl %al,%eax
}
     7dd:	5b                   	pop    %ebx
     7de:	5e                   	pop    %esi
     7df:	5f                   	pop    %edi
     7e0:	5d                   	pop    %ebp
     7e1:	c3                   	ret    
     7e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      substr(args, args, 1, strlen(args));
     7e8:	83 ec 0c             	sub    $0xc,%esp
     7eb:	53                   	push   %ebx
     7ec:	e8 8f 08 00 00       	call   1080 <strlen>
     7f1:	50                   	push   %eax
     7f2:	6a 01                	push   $0x1
     7f4:	53                   	push   %ebx
     7f5:	53                   	push   %ebx
     7f6:	e8 25 fe ff ff       	call   620 <substr>
      *startptr = 0 - atoi(args);
     7fb:	83 c4 14             	add    $0x14,%esp
     7fe:	53                   	push   %ebx
     7ff:	e8 dc 09 00 00       	call   11e0 <atoi>
     804:	8b 7d 0c             	mov    0xc(%ebp),%edi
     807:	f7 d8                	neg    %eax
     809:	83 c4 10             	add    $0x10,%esp
     80c:	89 07                	mov    %eax,(%edi)
     80e:	e9 10 ff ff ff       	jmp    723 <collectRange+0x43>
     813:	90                   	nop
     814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (((*startptr > 0 && *endptr > 0) || 
     818:	0f 84 0c ff ff ff    	je     72a <collectRange+0x4a>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     81e:	8b 7d 10             	mov    0x10(%ebp),%edi
     821:	8b 17                	mov    (%edi),%edx
     823:	85 d2                	test   %edx,%edx
     825:	78 ab                	js     7d2 <collectRange+0xf2>
}
     827:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
     82a:	31 c0                	xor    %eax,%eax
}
     82c:	5b                   	pop    %ebx
     82d:	5e                   	pop    %esi
     82e:	5f                   	pop    %edi
     82f:	5d                   	pop    %ebp
     830:	c3                   	ret    
     831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else *endptr = atoi(endstr);
     838:	83 ec 0c             	sub    $0xc,%esp
     83b:	53                   	push   %ebx
     83c:	e8 9f 09 00 00       	call   11e0 <atoi>
     841:	8b 55 10             	mov    0x10(%ebp),%edx
     844:	83 c4 10             	add    $0x10,%esp
     847:	89 02                	mov    %eax,(%edx)
     849:	e9 5c ff ff ff       	jmp    7aa <collectRange+0xca>
     84e:	66 90                	xchg   %ax,%ax
  else *startptr = atoi(startstr);
     850:	83 ec 0c             	sub    $0xc,%esp
     853:	56                   	push   %esi
     854:	e8 87 09 00 00       	call   11e0 <atoi>
     859:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     85c:	83 c4 10             	add    $0x10,%esp
     85f:	89 01                	mov    %eax,(%ecx)
     861:	e9 22 ff ff ff       	jmp    788 <collectRange+0xa8>
     866:	8d 76 00             	lea    0x0(%esi),%esi
     869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    substr(endstr, endstr, 1, strlen(endstr));
     870:	83 ec 0c             	sub    $0xc,%esp
    negEndFlag = 1;
     873:	bf 01 00 00 00       	mov    $0x1,%edi
    substr(endstr, endstr, 1, strlen(endstr));
     878:	53                   	push   %ebx
     879:	e8 02 08 00 00       	call   1080 <strlen>
     87e:	50                   	push   %eax
     87f:	6a 01                	push   $0x1
     881:	53                   	push   %ebx
     882:	53                   	push   %ebx
     883:	e8 98 fd ff ff       	call   620 <substr>
     888:	83 c4 20             	add    $0x20,%esp
     88b:	e9 d6 fe ff ff       	jmp    766 <collectRange+0x86>
    substr(startstr, startstr, 1, strlen(startstr));
     890:	83 ec 0c             	sub    $0xc,%esp
     893:	56                   	push   %esi
     894:	e8 e7 07 00 00       	call   1080 <strlen>
     899:	50                   	push   %eax
     89a:	6a 01                	push   $0x1
     89c:	56                   	push   %esi
     89d:	56                   	push   %esi
     89e:	e8 7d fd ff ff       	call   620 <substr>
     8a3:	83 c4 20             	add    $0x20,%esp
    negStartFlag = 1;
     8a6:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
     8ad:	e9 a9 fe ff ff       	jmp    75b <collectRange+0x7b>
     8b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     8b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008c0 <negatoi>:


// standard str helps
int negatoi(char* str) {
     8c0:	55                   	push   %ebp
     8c1:	89 e5                	mov    %esp,%ebp
     8c3:	53                   	push   %ebx
     8c4:	83 ec 04             	sub    $0x4,%esp
     8c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (str[0] == '-') {
     8ca:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     8cd:	74 11                	je     8e0 <negatoi+0x20>
    substr(str, str, 1, strlen(str));
    return 0 - atoi(str);
  }
  return atoi(str);
}
     8cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8d2:	c9                   	leave  
  return atoi(str);
     8d3:	e9 08 09 00 00       	jmp    11e0 <atoi>
     8d8:	90                   	nop
     8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    substr(str, str, 1, strlen(str));
     8e0:	83 ec 0c             	sub    $0xc,%esp
     8e3:	53                   	push   %ebx
     8e4:	e8 97 07 00 00       	call   1080 <strlen>
     8e9:	50                   	push   %eax
     8ea:	6a 01                	push   $0x1
     8ec:	53                   	push   %ebx
     8ed:	53                   	push   %ebx
     8ee:	e8 2d fd ff ff       	call   620 <substr>
    return 0 - atoi(str);
     8f3:	83 c4 14             	add    $0x14,%esp
     8f6:	53                   	push   %ebx
     8f7:	e8 e4 08 00 00       	call   11e0 <atoi>
     8fc:	83 c4 10             	add    $0x10,%esp
     8ff:	f7 d8                	neg    %eax
}
     901:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     904:	c9                   	leave  
     905:	c3                   	ret    
     906:	8d 76 00             	lea    0x0(%esi),%esi
     909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000910 <toUpper>:

void toUpper(char* str) {
     910:	55                   	push   %ebp
     911:	89 e5                	mov    %esp,%ebp
     913:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     916:	0f b6 02             	movzbl (%edx),%eax
     919:	84 c0                	test   %al,%al
     91b:	74 1a                	je     937 <toUpper+0x27>
     91d:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'z' && c >= 'a')
     920:	8d 48 9f             	lea    -0x61(%eax),%ecx
     923:	80 f9 19             	cmp    $0x19,%cl
     926:	77 05                	ja     92d <toUpper+0x1d>
      str[i] += ('Z' - 'z');
     928:	83 e8 20             	sub    $0x20,%eax
     92b:	88 02                	mov    %al,(%edx)
     92d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     930:	0f b6 02             	movzbl (%edx),%eax
     933:	84 c0                	test   %al,%al
     935:	75 e9                	jne    920 <toUpper+0x10>
    i++;  
  }
}
     937:	5d                   	pop    %ebp
     938:	c3                   	ret    
     939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000940 <toLower>:

void toLower(char* str) {
     940:	55                   	push   %ebp
     941:	89 e5                	mov    %esp,%ebp
     943:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     946:	0f b6 02             	movzbl (%edx),%eax
     949:	84 c0                	test   %al,%al
     94b:	74 1a                	je     967 <toLower+0x27>
     94d:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'Z' && c >= 'A')
     950:	8d 48 bf             	lea    -0x41(%eax),%ecx
     953:	80 f9 19             	cmp    $0x19,%cl
     956:	77 05                	ja     95d <toLower+0x1d>
      str[i] -= ('Z' - 'z');
     958:	83 c0 20             	add    $0x20,%eax
     95b:	88 02                	mov    %al,(%edx)
     95d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     960:	0f b6 02             	movzbl (%edx),%eax
     963:	84 c0                	test   %al,%al
     965:	75 e9                	jne    950 <toLower+0x10>
    i++;  
  }
}
     967:	5d                   	pop    %ebp
     968:	c3                   	ret    
     969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000970 <lineAt>:

// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
     970:	55                   	push   %ebp
     971:	89 e5                	mov    %esp,%ebp
  return nodeAt(list, pos-1);
     973:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
}
     977:	5d                   	pop    %ebp
  return nodeAt(list, pos-1);
     978:	e9 e3 f7 ff ff       	jmp    160 <nodeAt>
     97d:	8d 76 00             	lea    0x0(%esi),%esi

00000980 <printl>:

void printl(int lineNum, char* line) {
     980:	55                   	push   %ebp
     981:	89 e5                	mov    %esp,%ebp
     983:	83 ec 08             	sub    $0x8,%esp
     986:	8b 45 08             	mov    0x8(%ebp),%eax
  if (lineNum < 10)
     989:	83 f8 09             	cmp    $0x9,%eax
     98c:	7e 3a                	jle    9c8 <printl+0x48>
    fprintf(2, "%d  : %s\n", lineNum, line);
  else if (lineNum < 100)
     98e:	83 f8 63             	cmp    $0x63,%eax
     991:	7e 1d                	jle    9b0 <printl+0x30>
    fprintf(2, "%d : %s\n", lineNum, line);
  else
    fprintf(2, "%d: %s\n", lineNum, line);
     993:	ff 75 0c             	pushl  0xc(%ebp)
     996:	50                   	push   %eax
     997:	68 ad 17 00 00       	push   $0x17ad
     99c:	6a 02                	push   $0x2
     99e:	e8 2d 0c 00 00       	call   15d0 <fprintf>
     9a3:	83 c4 10             	add    $0x10,%esp
     9a6:	c9                   	leave  
     9a7:	c3                   	ret    
     9a8:	90                   	nop
     9a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "%d : %s\n", lineNum, line);
     9b0:	ff 75 0c             	pushl  0xc(%ebp)
     9b3:	50                   	push   %eax
     9b4:	68 a4 17 00 00       	push   $0x17a4
     9b9:	6a 02                	push   $0x2
     9bb:	e8 10 0c 00 00       	call   15d0 <fprintf>
     9c0:	83 c4 10             	add    $0x10,%esp
     9c3:	c9                   	leave  
     9c4:	c3                   	ret    
     9c5:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "%d  : %s\n", lineNum, line);
     9c8:	ff 75 0c             	pushl  0xc(%ebp)
     9cb:	50                   	push   %eax
     9cc:	68 9a 17 00 00       	push   $0x179a
     9d1:	6a 02                	push   $0x2
     9d3:	e8 f8 0b 00 00       	call   15d0 <fprintf>
     9d8:	83 c4 10             	add    $0x10,%esp
     9db:	c9                   	leave  
     9dc:	c3                   	ret    
     9dd:	8d 76 00             	lea    0x0(%esi),%esi

000009e0 <forward>:
  exit();
  return 0;
}

// commands
void forward(struct File file){
     9e0:	55                   	push   %ebp
     9e1:	89 e5                	mov    %esp,%ebp
  printf("forward\r");
     9e3:	c7 45 08 e1 17 00 00 	movl   $0x17e1,0x8(%ebp)
}
     9ea:	5d                   	pop    %ebp
  printf("forward\r");
     9eb:	e9 00 0c 00 00       	jmp    15f0 <printf>

000009f0 <fastforward>:
void fastforward(struct File file){
     9f0:	55                   	push   %ebp
     9f1:	89 e5                	mov    %esp,%ebp
  printf("fastforward\r");
     9f3:	c7 45 08 dd 17 00 00 	movl   $0x17dd,0x8(%ebp)
}
     9fa:	5d                   	pop    %ebp
  printf("fastforward\r");
     9fb:	e9 f0 0b 00 00       	jmp    15f0 <printf>

00000a00 <back>:
void back(struct File file){
     a00:	55                   	push   %ebp
     a01:	89 e5                	mov    %esp,%ebp
  printf("back\r");
     a03:	c7 45 08 ea 17 00 00 	movl   $0x17ea,0x8(%ebp)
}
     a0a:	5d                   	pop    %ebp
  printf("back\r");
     a0b:	e9 e0 0b 00 00       	jmp    15f0 <printf>

00000a10 <scroll>:
void scroll(struct File file){
     a10:	55                   	push   %ebp
     a11:	89 e5                	mov    %esp,%ebp
  printf("scroll\r");
     a13:	c7 45 08 f0 17 00 00 	movl   $0x17f0,0x8(%ebp)
}
     a1a:	5d                   	pop    %ebp
  printf("scroll\r");
     a1b:	e9 d0 0b 00 00       	jmp    15f0 <printf>

00000a20 <line>:
void line(struct File file){
     a20:	55                   	push   %ebp
     a21:	89 e5                	mov    %esp,%ebp
  printf("line\r");
     a23:	c7 45 08 f8 17 00 00 	movl   $0x17f8,0x8(%ebp)
}
     a2a:	5d                   	pop    %ebp
  printf("line\r");
     a2b:	e9 c0 0b 00 00       	jmp    15f0 <printf>

00000a30 <end>:


// old commands
void end(struct File* file, char* args) {
     a30:	55                   	push   %ebp
     a31:	89 e5                	mov    %esp,%ebp
     a33:	53                   	push   %ebx
     a34:	83 ec 08             	sub    $0x8,%esp
     a37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  file->edited = 1;
  char* line = args;
  append(file->lines, line);
     a3a:	8b 43 0c             	mov    0xc(%ebx),%eax
  file->edited = 1;
     a3d:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
     a44:	ff 70 08             	pushl  0x8(%eax)
     a47:	ff 75 0c             	pushl  0xc(%ebp)
     a4a:	50                   	push   %eax
     a4b:	e8 30 f8 ff ff       	call   280 <insert>
  file->len++;
     a50:	83 43 10 01          	addl   $0x1,0x10(%ebx)
}
     a54:	83 c4 10             	add    $0x10,%esp
     a57:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a5a:	c9                   	leave  
     a5b:	c3                   	ret    
     a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a60 <add>:

void add(struct File* file, char* args) {
     a60:	55                   	push   %ebp
     a61:	89 e5                	mov    %esp,%ebp
     a63:	57                   	push   %edi
     a64:	56                   	push   %esi
     a65:	53                   	push   %ebx
     a66:	83 ec 28             	sub    $0x28,%esp
     a69:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a6c:	8b 75 0c             	mov    0xc(%ebp),%esi
  file->edited = 1;
     a6f:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
  if (strlen(args) < 1) {
     a76:	56                   	push   %esi
     a77:	e8 04 06 00 00       	call   1080 <strlen>
     a7c:	83 c4 10             	add    $0x10,%esp
     a7f:	85 c0                	test   %eax,%eax
     a81:	74 3d                	je     ac0 <add+0x60>
    fprintf(2, "you need to give a line number to insert before\n");
    return;
  }
  char lineStr[10];
  getArg(lineStr, args, ' ');
     a83:	8d 7d de             	lea    -0x22(%ebp),%edi
     a86:	83 ec 04             	sub    $0x4,%esp
     a89:	6a 20                	push   $0x20
     a8b:	56                   	push   %esi
     a8c:	57                   	push   %edi
     a8d:	e8 de fb ff ff       	call   670 <getArg>
  char* line = args;

  int lineNum = negatoi(lineStr);
     a92:	89 3c 24             	mov    %edi,(%esp)
     a95:	e8 26 fe ff ff       	call   8c0 <negatoi>
  // 1-based to 0-based insert
  insert(file->lines, line, lineNum - 1);
     a9a:	83 c4 0c             	add    $0xc,%esp
     a9d:	83 e8 01             	sub    $0x1,%eax
     aa0:	50                   	push   %eax
     aa1:	56                   	push   %esi
     aa2:	ff 73 0c             	pushl  0xc(%ebx)
     aa5:	e8 d6 f7 ff ff       	call   280 <insert>
  file->len++;
     aaa:	83 43 10 01          	addl   $0x1,0x10(%ebx)
     aae:	83 c4 10             	add    $0x10,%esp
}
     ab1:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ab4:	5b                   	pop    %ebx
     ab5:	5e                   	pop    %esi
     ab6:	5f                   	pop    %edi
     ab7:	5d                   	pop    %ebp
     ab8:	c3                   	ret    
     ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "you need to give a line number to insert before\n");
     ac0:	83 ec 08             	sub    $0x8,%esp
     ac3:	68 10 19 00 00       	push   $0x1910
     ac8:	6a 02                	push   $0x2
     aca:	e8 01 0b 00 00       	call   15d0 <fprintf>
    return;
     acf:	83 c4 10             	add    $0x10,%esp
}
     ad2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ad5:	5b                   	pop    %ebx
     ad6:	5e                   	pop    %esi
     ad7:	5f                   	pop    %edi
     ad8:	5d                   	pop    %ebp
     ad9:	c3                   	ret    
     ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000ae0 <drop>:

void drop(struct File* file, char* args) {
     ae0:	55                   	push   %ebp
     ae1:	89 e5                	mov    %esp,%ebp
     ae3:	57                   	push   %edi
     ae4:	56                   	push   %esi
     ae5:	53                   	push   %ebx
     ae6:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
     ae9:	ff 75 0c             	pushl  0xc(%ebp)
void drop(struct File* file, char* args) {
     aec:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (strlen(args) < 1) {
     aef:	e8 8c 05 00 00       	call   1080 <strlen>
     af4:	83 c4 10             	add    $0x10,%esp
     af7:	85 c0                	test   %eax,%eax
     af9:	0f 84 09 01 00 00    	je     c08 <drop+0x128>
    fprintf(2, "you need to give a range to drop\n");
    return;
  }

  int start, end;
  if (collectRange(args, &start, &end) == 1) {
     aff:	8d 75 e4             	lea    -0x1c(%ebp),%esi
     b02:	8d 7d e0             	lea    -0x20(%ebp),%edi
     b05:	83 ec 04             	sub    $0x4,%esp
     b08:	56                   	push   %esi
     b09:	57                   	push   %edi
     b0a:	ff 75 0c             	pushl  0xc(%ebp)
     b0d:	e8 ce fb ff ff       	call   6e0 <collectRange>
     b12:	83 c4 10             	add    $0x10,%esp
     b15:	83 f8 01             	cmp    $0x1,%eax
     b18:	0f 84 0a 01 00 00    	je     c28 <drop+0x148>
    fprintf(2, "error: start index is larger than end index\n");
    return;
  }
  if (normalizeRange(*file, &start, &end) == 1) {
     b1e:	56                   	push   %esi
     b1f:	57                   	push   %edi
     b20:	ff 73 14             	pushl  0x14(%ebx)
     b23:	ff 73 10             	pushl  0x10(%ebx)
     b26:	ff 73 0c             	pushl  0xc(%ebx)
     b29:	ff 73 08             	pushl  0x8(%ebx)
     b2c:	ff 73 04             	pushl  0x4(%ebx)
     b2f:	ff 33                	pushl  (%ebx)
     b31:	e8 ca f8 ff ff       	call   400 <normalizeRange>
     b36:	83 c4 20             	add    $0x20,%esp
     b39:	83 f8 01             	cmp    $0x1,%eax
     b3c:	0f 84 1e 01 00 00    	je     c60 <drop+0x180>
    fprintf(2, "error: bad input range. make sure start < end\n");
    return;
  }
  int numl = numLines(start, end);
     b42:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     b45:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return (end - start) + 1;
     b48:	89 d6                	mov    %edx,%esi
     b4a:	29 c6                	sub    %eax,%esi
     b4c:	8d 7e 01             	lea    0x1(%esi),%edi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
     b4f:	83 ff 01             	cmp    $0x1,%edi
     b52:	89 7d d4             	mov    %edi,-0x2c(%ebp)
     b55:	0f 84 ed 00 00 00    	je     c48 <drop+0x168>
  else fprintf(2, "Drop %d lines [%d:%d] (y/n)? ", numl, start, end);
     b5b:	83 ec 0c             	sub    $0xc,%esp
     b5e:	52                   	push   %edx
     b5f:	50                   	push   %eax
     b60:	ff 75 d4             	pushl  -0x2c(%ebp)
     b63:	68 13 18 00 00       	push   $0x1813
     b68:	6a 02                	push   $0x2
     b6a:	e8 61 0a 00 00       	call   15d0 <fprintf>
     b6f:	83 c4 20             	add    $0x20,%esp
  if (confirmation() != 0) return;
     b72:	e8 29 f8 ff ff       	call   3a0 <confirmation>
     b77:	85 c0                	test   %eax,%eax
     b79:	75 7f                	jne    bfa <drop+0x11a>
  return nodeAt(list, pos-1);
     b7b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  file->edited = 1;

  // drop lines
  struct Node* curNode = (lineAt(file->lines, start))->prev;
     b7e:	8b 4b 0c             	mov    0xc(%ebx),%ecx
     b81:	83 ec 08             	sub    $0x8,%esp
  file->edited = 1;
     b84:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
     b8b:	83 e8 01             	sub    $0x1,%eax
     b8e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
     b91:	50                   	push   %eax
     b92:	51                   	push   %ecx
     b93:	e8 c8 f5 ff ff       	call   160 <nodeAt>
  struct Node* curNode = (lineAt(file->lines, start))->prev;
     b98:	8b 30                	mov    (%eax),%esi
     b9a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b9d:	5a                   	pop    %edx
     b9e:	59                   	pop    %ecx
     b9f:	8b 4d d0             	mov    -0x30(%ebp),%ecx
     ba2:	83 e8 01             	sub    $0x1,%eax
     ba5:	50                   	push   %eax
     ba6:	51                   	push   %ecx
     ba7:	e8 b4 f5 ff ff       	call   160 <nodeAt>
     bac:	83 c4 10             	add    $0x10,%esp
  struct Node* stopNode = lineAt(file->lines, end);
  while (curNode != stopNode) {
     baf:	39 c6                	cmp    %eax,%esi
     bb1:	89 c7                	mov    %eax,%edi
     bb3:	8b 4d d0             	mov    -0x30(%ebp),%ecx
     bb6:	75 0b                	jne    bc3 <drop+0xe3>
     bb8:	eb 21                	jmp    bdb <drop+0xfb>
     bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     bc0:	8b 4b 0c             	mov    0xc(%ebx),%ecx
    curNode = curNode->next;
     bc3:	8b 76 08             	mov    0x8(%esi),%esi
    destroyNode(file->lines, curNode);
     bc6:	83 ec 08             	sub    $0x8,%esp
     bc9:	56                   	push   %esi
     bca:	51                   	push   %ecx
     bcb:	e8 00 f6 ff ff       	call   1d0 <destroyNode>
    file->len--;
     bd0:	83 6b 10 01          	subl   $0x1,0x10(%ebx)
  while (curNode != stopNode) {
     bd4:	83 c4 10             	add    $0x10,%esp
     bd7:	39 fe                	cmp    %edi,%esi
     bd9:	75 e5                	jne    bc0 <drop+0xe0>
  }
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
     bdb:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
     bdf:	0f 84 93 00 00 00    	je     c78 <drop+0x198>
  else fprintf(2, "%d lines dropped\n", numl);
     be5:	83 ec 04             	sub    $0x4,%esp
     be8:	ff 75 d4             	pushl  -0x2c(%ebp)
     beb:	68 42 18 00 00       	push   $0x1842
     bf0:	6a 02                	push   $0x2
     bf2:	e8 d9 09 00 00       	call   15d0 <fprintf>
     bf7:	83 c4 10             	add    $0x10,%esp
  return;
}
     bfa:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bfd:	5b                   	pop    %ebx
     bfe:	5e                   	pop    %esi
     bff:	5f                   	pop    %edi
     c00:	5d                   	pop    %ebp
     c01:	c3                   	ret    
     c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "you need to give a range to drop\n");
     c08:	83 ec 08             	sub    $0x8,%esp
     c0b:	68 44 19 00 00       	push   $0x1944
     c10:	6a 02                	push   $0x2
     c12:	e8 b9 09 00 00       	call   15d0 <fprintf>
    return;
     c17:	83 c4 10             	add    $0x10,%esp
}
     c1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c1d:	5b                   	pop    %ebx
     c1e:	5e                   	pop    %esi
     c1f:	5f                   	pop    %edi
     c20:	5d                   	pop    %ebp
     c21:	c3                   	ret    
     c22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: start index is larger than end index\n");
     c28:	83 ec 08             	sub    $0x8,%esp
     c2b:	68 68 19 00 00       	push   $0x1968
     c30:	6a 02                	push   $0x2
     c32:	e8 99 09 00 00       	call   15d0 <fprintf>
    return;
     c37:	83 c4 10             	add    $0x10,%esp
}
     c3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c3d:	5b                   	pop    %ebx
     c3e:	5e                   	pop    %esi
     c3f:	5f                   	pop    %edi
     c40:	5d                   	pop    %ebp
     c41:	c3                   	ret    
     c42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
     c48:	83 ec 04             	sub    $0x4,%esp
     c4b:	50                   	push   %eax
     c4c:	68 fe 17 00 00       	push   $0x17fe
     c51:	6a 02                	push   $0x2
     c53:	e8 78 09 00 00       	call   15d0 <fprintf>
     c58:	83 c4 10             	add    $0x10,%esp
     c5b:	e9 12 ff ff ff       	jmp    b72 <drop+0x92>
    fprintf(2, "error: bad input range. make sure start < end\n");
     c60:	83 ec 08             	sub    $0x8,%esp
     c63:	68 98 19 00 00       	push   $0x1998
     c68:	6a 02                	push   $0x2
     c6a:	e8 61 09 00 00       	call   15d0 <fprintf>
    return;
     c6f:	83 c4 10             	add    $0x10,%esp
     c72:	eb 86                	jmp    bfa <drop+0x11a>
     c74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
     c78:	83 ec 04             	sub    $0x4,%esp
     c7b:	ff 75 e0             	pushl  -0x20(%ebp)
     c7e:	68 31 18 00 00       	push   $0x1831
     c83:	6a 02                	push   $0x2
     c85:	e8 46 09 00 00       	call   15d0 <fprintf>
     c8a:	83 c4 10             	add    $0x10,%esp
     c8d:	e9 68 ff ff ff       	jmp    bfa <drop+0x11a>
     c92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ca0 <edit>:

void edit(struct File* file, char* args) {
     ca0:	55                   	push   %ebp
     ca1:	89 e5                	mov    %esp,%ebp
     ca3:	57                   	push   %edi
     ca4:	56                   	push   %esi
     ca5:	53                   	push   %ebx
     ca6:	83 ec 28             	sub    $0x28,%esp
     ca9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if (strlen(args) < 1) {
     cac:	53                   	push   %ebx
     cad:	e8 ce 03 00 00       	call   1080 <strlen>
     cb2:	83 c4 10             	add    $0x10,%esp
     cb5:	85 c0                	test   %eax,%eax
     cb7:	75 1f                	jne    cd8 <edit+0x38>
    fprintf(2, "you need to give a line number to replace\n");
     cb9:	83 ec 08             	sub    $0x8,%esp
     cbc:	68 c8 19 00 00       	push   $0x19c8
     cc1:	6a 02                	push   $0x2
     cc3:	e8 08 09 00 00       	call   15d0 <fprintf>
    return;
     cc8:	83 c4 10             	add    $0x10,%esp

  // remove
  destroyNode(file->lines, lineAt(file->lines, lineNum));
  // 1-based to 0-based insert
  insert(file->lines, line, lineNum - 1);
}
     ccb:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cce:	5b                   	pop    %ebx
     ccf:	5e                   	pop    %esi
     cd0:	5f                   	pop    %edi
     cd1:	5d                   	pop    %ebp
     cd2:	c3                   	ret    
     cd3:	90                   	nop
     cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  getArg(lineStr, args, ' ');
     cd8:	8d 75 de             	lea    -0x22(%ebp),%esi
     cdb:	83 ec 04             	sub    $0x4,%esp
     cde:	6a 20                	push   $0x20
     ce0:	53                   	push   %ebx
     ce1:	56                   	push   %esi
     ce2:	e8 89 f9 ff ff       	call   670 <getArg>
  int lineNum = negatoi(lineStr);
     ce7:	89 34 24             	mov    %esi,(%esp)
     cea:	e8 d1 fb ff ff       	call   8c0 <negatoi>
  fprintf(2, "replace line %d (y/n)? ", lineNum);
     cef:	83 c4 0c             	add    $0xc,%esp
  int lineNum = negatoi(lineStr);
     cf2:	89 c6                	mov    %eax,%esi
  fprintf(2, "replace line %d (y/n)? ", lineNum);
     cf4:	50                   	push   %eax
     cf5:	68 54 18 00 00       	push   $0x1854
     cfa:	6a 02                	push   $0x2
     cfc:	e8 cf 08 00 00       	call   15d0 <fprintf>
  if (confirmation() != 0) return;
     d01:	e8 9a f6 ff ff       	call   3a0 <confirmation>
     d06:	83 c4 10             	add    $0x10,%esp
     d09:	85 c0                	test   %eax,%eax
     d0b:	75 be                	jne    ccb <edit+0x2b>
  file->edited = 1;
     d0d:	8b 45 08             	mov    0x8(%ebp),%eax
     d10:	83 ec 08             	sub    $0x8,%esp
     d13:	83 ee 01             	sub    $0x1,%esi
  destroyNode(file->lines, lineAt(file->lines, lineNum));
     d16:	8b 78 0c             	mov    0xc(%eax),%edi
  file->edited = 1;
     d19:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
     d20:	56                   	push   %esi
     d21:	57                   	push   %edi
     d22:	e8 39 f4 ff ff       	call   160 <nodeAt>
     d27:	5a                   	pop    %edx
     d28:	59                   	pop    %ecx
  destroyNode(file->lines, lineAt(file->lines, lineNum));
     d29:	50                   	push   %eax
     d2a:	57                   	push   %edi
     d2b:	e8 a0 f4 ff ff       	call   1d0 <destroyNode>
  insert(file->lines, line, lineNum - 1);
     d30:	8b 45 08             	mov    0x8(%ebp),%eax
     d33:	83 c4 0c             	add    $0xc,%esp
     d36:	56                   	push   %esi
     d37:	53                   	push   %ebx
     d38:	ff 70 0c             	pushl  0xc(%eax)
     d3b:	e8 40 f5 ff ff       	call   280 <insert>
     d40:	83 c4 10             	add    $0x10,%esp
}
     d43:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d46:	5b                   	pop    %ebx
     d47:	5e                   	pop    %esi
     d48:	5f                   	pop    %edi
     d49:	5d                   	pop    %ebp
     d4a:	c3                   	ret    
     d4b:	90                   	nop
     d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d50 <list>:

void list(struct File file, char* args) {
     d50:	55                   	push   %ebp
     d51:	89 e5                	mov    %esp,%ebp
     d53:	57                   	push   %edi
     d54:	56                   	push   %esi
     d55:	53                   	push   %ebx
     d56:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
     d59:	ff 75 20             	pushl  0x20(%ebp)
     d5c:	8b 75 14             	mov    0x14(%ebp),%esi
     d5f:	e8 1c 03 00 00       	call   1080 <strlen>
     d64:	83 c4 10             	add    $0x10,%esp
     d67:	85 c0                	test   %eax,%eax
     d69:	75 1d                	jne    d88 <list+0x38>
    fprintf(2, "you need to give a range to list\n");
     d6b:	83 ec 08             	sub    $0x8,%esp
     d6e:	68 f4 19 00 00       	push   $0x19f4
     d73:	6a 02                	push   $0x2
     d75:	e8 56 08 00 00       	call   15d0 <fprintf>
    return;
     d7a:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
    curNode = curNode->next;
    if (curNode == file.lines->tail) return;
    printl(++lineNum, curNode->data);
  }
}
     d7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d80:	5b                   	pop    %ebx
     d81:	5e                   	pop    %esi
     d82:	5f                   	pop    %edi
     d83:	5d                   	pop    %ebp
     d84:	c3                   	ret    
     d85:	8d 76 00             	lea    0x0(%esi),%esi
  if (collectRange(args, &start, &end) == 1) {
     d88:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
     d8b:	8d 7d e0             	lea    -0x20(%ebp),%edi
     d8e:	83 ec 04             	sub    $0x4,%esp
     d91:	53                   	push   %ebx
     d92:	57                   	push   %edi
     d93:	ff 75 20             	pushl  0x20(%ebp)
     d96:	e8 45 f9 ff ff       	call   6e0 <collectRange>
     d9b:	83 c4 10             	add    $0x10,%esp
     d9e:	83 f8 01             	cmp    $0x1,%eax
     da1:	0f 84 91 00 00 00    	je     e38 <list+0xe8>
  if (normalizeRange(file, &start, &end) == 1) {
     da7:	53                   	push   %ebx
     da8:	57                   	push   %edi
     da9:	ff 75 1c             	pushl  0x1c(%ebp)
     dac:	ff 75 18             	pushl  0x18(%ebp)
     daf:	ff 75 14             	pushl  0x14(%ebp)
     db2:	ff 75 10             	pushl  0x10(%ebp)
     db5:	ff 75 0c             	pushl  0xc(%ebp)
     db8:	ff 75 08             	pushl  0x8(%ebp)
     dbb:	e8 40 f6 ff ff       	call   400 <normalizeRange>
     dc0:	83 c4 20             	add    $0x20,%esp
     dc3:	83 f8 01             	cmp    $0x1,%eax
     dc6:	0f 84 8c 00 00 00    	je     e58 <list+0x108>
  lineNum = start - 1;
     dcc:	8b 45 e0             	mov    -0x20(%ebp),%eax
     dcf:	83 ec 08             	sub    $0x8,%esp
     dd2:	8d 78 ff             	lea    -0x1(%eax),%edi
     dd5:	57                   	push   %edi
     dd6:	56                   	push   %esi
     dd7:	e8 84 f3 ff ff       	call   160 <nodeAt>
  struct Node* curNode = (lineAt(file.lines, start))->prev;
     ddc:	8b 18                	mov    (%eax),%ebx
     dde:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     de1:	5a                   	pop    %edx
     de2:	59                   	pop    %ecx
     de3:	83 e8 01             	sub    $0x1,%eax
     de6:	50                   	push   %eax
     de7:	56                   	push   %esi
     de8:	e8 73 f3 ff ff       	call   160 <nodeAt>
     ded:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
     df0:	39 d8                	cmp    %ebx,%eax
     df2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     df5:	74 86                	je     d7d <list+0x2d>
    curNode = curNode->next;
     df7:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
     dfa:	3b 5e 04             	cmp    0x4(%esi),%ebx
     dfd:	75 15                	jne    e14 <list+0xc4>
     dff:	e9 79 ff ff ff       	jmp    d7d <list+0x2d>
     e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
     e08:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
     e0b:	39 5e 04             	cmp    %ebx,0x4(%esi)
     e0e:	0f 84 69 ff ff ff    	je     d7d <list+0x2d>
    printl(++lineNum, curNode->data);
     e14:	83 ec 08             	sub    $0x8,%esp
     e17:	83 c7 01             	add    $0x1,%edi
     e1a:	ff 73 04             	pushl  0x4(%ebx)
     e1d:	57                   	push   %edi
     e1e:	e8 5d fb ff ff       	call   980 <printl>
  while (curNode != stopNode) {
     e23:	83 c4 10             	add    $0x10,%esp
     e26:	39 5d d4             	cmp    %ebx,-0x2c(%ebp)
     e29:	75 dd                	jne    e08 <list+0xb8>
}
     e2b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e2e:	5b                   	pop    %ebx
     e2f:	5e                   	pop    %esi
     e30:	5f                   	pop    %edi
     e31:	5d                   	pop    %ebp
     e32:	c3                   	ret    
     e33:	90                   	nop
     e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "error: start index is larger than end index\n");
     e38:	83 ec 08             	sub    $0x8,%esp
     e3b:	68 68 19 00 00       	push   $0x1968
     e40:	6a 02                	push   $0x2
     e42:	e8 89 07 00 00       	call   15d0 <fprintf>
    return;
     e47:	83 c4 10             	add    $0x10,%esp
}
     e4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e4d:	5b                   	pop    %ebx
     e4e:	5e                   	pop    %esi
     e4f:	5f                   	pop    %edi
     e50:	5d                   	pop    %ebp
     e51:	c3                   	ret    
     e52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: bad input range. make sure start < end\n");
     e58:	83 ec 08             	sub    $0x8,%esp
     e5b:	68 98 19 00 00       	push   $0x1998
     e60:	6a 02                	push   $0x2
     e62:	e8 69 07 00 00       	call   15d0 <fprintf>
    return;
     e67:	83 c4 10             	add    $0x10,%esp
     e6a:	e9 0e ff ff ff       	jmp    d7d <list+0x2d>
     e6f:	90                   	nop

00000e70 <show>:

void show(struct File file, char* args) {
     e70:	55                   	push   %ebp
     e71:	89 e5                	mov    %esp,%ebp
     e73:	57                   	push   %edi
     e74:	56                   	push   %esi
     e75:	53                   	push   %ebx
     e76:	83 ec 0c             	sub    $0xc,%esp
     e79:	8b 7d 14             	mov    0x14(%ebp),%edi
  struct Node* cur = file.lines->head->next;
     e7c:	8b 07                	mov    (%edi),%eax
     e7e:	8b 58 08             	mov    0x8(%eax),%ebx
  int lineNum = 1;
  while (cur != file.lines->tail) {
     e81:	3b 5f 04             	cmp    0x4(%edi),%ebx
     e84:	74 24                	je     eaa <show+0x3a>
  int lineNum = 1;
     e86:	be 01 00 00 00       	mov    $0x1,%esi
     e8b:	90                   	nop
     e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printl(lineNum, cur->data);
     e90:	83 ec 08             	sub    $0x8,%esp
     e93:	ff 73 04             	pushl  0x4(%ebx)
     e96:	56                   	push   %esi
    cur = cur->next;
    lineNum++;
     e97:	83 c6 01             	add    $0x1,%esi
    printl(lineNum, cur->data);
     e9a:	e8 e1 fa ff ff       	call   980 <printl>
    cur = cur->next;
     e9f:	8b 5b 08             	mov    0x8(%ebx),%ebx
  while (cur != file.lines->tail) {
     ea2:	83 c4 10             	add    $0x10,%esp
     ea5:	39 5f 04             	cmp    %ebx,0x4(%edi)
     ea8:	75 e6                	jne    e90 <show+0x20>
  }
}
     eaa:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ead:	5b                   	pop    %ebx
     eae:	5e                   	pop    %esi
     eaf:	5f                   	pop    %edi
     eb0:	5d                   	pop    %ebp
     eb1:	c3                   	ret    
     eb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ec0 <quit>:

void quit(struct File* file) {
     ec0:	55                   	push   %ebp
     ec1:	89 e5                	mov    %esp,%ebp
     ec3:	56                   	push   %esi
     ec4:	53                   	push   %ebx
     ec5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (file->edited == 0) return;
     ec8:	8b 4b 14             	mov    0x14(%ebx),%ecx
     ecb:	85 c9                	test   %ecx,%ecx
     ecd:	75 11                	jne    ee0 <quit+0x20>
    cur = cur->next;
  }
  close(file->fd);
  fprintf(2, "changes saved\n");
  return;
}
     ecf:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ed2:	5b                   	pop    %ebx
     ed3:	5e                   	pop    %esi
     ed4:	5d                   	pop    %ebp
     ed5:	c3                   	ret    
     ed6:	8d 76 00             	lea    0x0(%esi),%esi
     ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  fprintf(2, "save changes (y/n)? ");
     ee0:	83 ec 08             	sub    $0x8,%esp
     ee3:	68 6c 18 00 00       	push   $0x186c
     ee8:	6a 02                	push   $0x2
     eea:	e8 e1 06 00 00       	call   15d0 <fprintf>
  if (confirmation() != 0) return;
     eef:	e8 ac f4 ff ff       	call   3a0 <confirmation>
     ef4:	83 c4 10             	add    $0x10,%esp
     ef7:	85 c0                	test   %eax,%eax
     ef9:	75 d4                	jne    ecf <quit+0xf>
  if (unlink(file->filename) < 0) {
     efb:	83 ec 0c             	sub    $0xc,%esp
     efe:	ff 33                	pushl  (%ebx)
     f00:	e8 a5 03 00 00       	call   12aa <unlink>
     f05:	83 c4 10             	add    $0x10,%esp
     f08:	85 c0                	test   %eax,%eax
     f0a:	0f 88 90 00 00 00    	js     fa0 <quit+0xe0>
  file->fd = open(file->filename, O_CREATE|O_RDWR);
     f10:	83 ec 08             	sub    $0x8,%esp
     f13:	68 02 02 00 00       	push   $0x202
     f18:	ff 33                	pushl  (%ebx)
     f1a:	e8 7b 03 00 00       	call   129a <open>
  if (file->fd < 0) {
     f1f:	83 c4 10             	add    $0x10,%esp
     f22:	85 c0                	test   %eax,%eax
  file->fd = open(file->filename, O_CREATE|O_RDWR);
     f24:	89 43 04             	mov    %eax,0x4(%ebx)
  if (file->fd < 0) {
     f27:	0f 88 93 00 00 00    	js     fc0 <quit+0x100>
  struct Node* cur = file->lines->head->next;
     f2d:	8b 53 0c             	mov    0xc(%ebx),%edx
     f30:	8b 0a                	mov    (%edx),%ecx
     f32:	8b 71 08             	mov    0x8(%ecx),%esi
  while (cur != file->lines->tail) {
     f35:	3b 72 04             	cmp    0x4(%edx),%esi
     f38:	74 43                	je     f7d <quit+0xbd>
     f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    write(file->fd, cur->data, strlen(cur->data));
     f40:	83 ec 0c             	sub    $0xc,%esp
     f43:	ff 76 04             	pushl  0x4(%esi)
     f46:	e8 35 01 00 00       	call   1080 <strlen>
     f4b:	83 c4 0c             	add    $0xc,%esp
     f4e:	50                   	push   %eax
     f4f:	ff 76 04             	pushl  0x4(%esi)
     f52:	ff 73 04             	pushl  0x4(%ebx)
     f55:	e8 20 03 00 00       	call   127a <write>
    write(file->fd, "\n", sizeof(char));
     f5a:	83 c4 0c             	add    $0xc,%esp
     f5d:	6a 01                	push   $0x1
     f5f:	68 cd 17 00 00       	push   $0x17cd
     f64:	ff 73 04             	pushl  0x4(%ebx)
     f67:	e8 0e 03 00 00       	call   127a <write>
  while (cur != file->lines->tail) {
     f6c:	8b 43 0c             	mov    0xc(%ebx),%eax
    cur = cur->next;
     f6f:	8b 76 08             	mov    0x8(%esi),%esi
  while (cur != file->lines->tail) {
     f72:	83 c4 10             	add    $0x10,%esp
     f75:	39 70 04             	cmp    %esi,0x4(%eax)
     f78:	75 c6                	jne    f40 <quit+0x80>
     f7a:	8b 43 04             	mov    0x4(%ebx),%eax
  close(file->fd);
     f7d:	83 ec 0c             	sub    $0xc,%esp
     f80:	50                   	push   %eax
     f81:	e8 fc 02 00 00       	call   1282 <close>
  fprintf(2, "changes saved\n");
     f86:	58                   	pop    %eax
     f87:	5a                   	pop    %edx
     f88:	68 81 18 00 00       	push   $0x1881
     f8d:	6a 02                	push   $0x2
     f8f:	e8 3c 06 00 00       	call   15d0 <fprintf>
  return;
     f94:	83 c4 10             	add    $0x10,%esp
     f97:	e9 33 ff ff ff       	jmp    ecf <quit+0xf>
     f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "could not clear file for writing. changes lost\n");
     fa0:	83 ec 08             	sub    $0x8,%esp
     fa3:	68 18 1a 00 00       	push   $0x1a18
     fa8:	6a 02                	push   $0x2
     faa:	e8 21 06 00 00       	call   15d0 <fprintf>
    return;
     faf:	83 c4 10             	add    $0x10,%esp
     fb2:	e9 18 ff ff ff       	jmp    ecf <quit+0xf>
     fb7:	89 f6                	mov    %esi,%esi
     fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    fprintf(2, "could not open file for writing. changes lost\n");
     fc0:	83 ec 08             	sub    $0x8,%esp
     fc3:	68 48 1a 00 00       	push   $0x1a48
     fc8:	6a 02                	push   $0x2
     fca:	e8 01 06 00 00       	call   15d0 <fprintf>
    return;
     fcf:	83 c4 10             	add    $0x10,%esp
     fd2:	e9 f8 fe ff ff       	jmp    ecf <quit+0xf>
     fd7:	89 f6                	mov    %esi,%esi
     fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000fe0 <bi>:

void bi() {
     fe0:	55                   	push   %ebp
     fe1:	89 e5                	mov    %esp,%ebp
     fe3:	83 ec 10             	sub    $0x10,%esp
  fprintf(2, "bad input\n");
     fe6:	68 90 18 00 00       	push   $0x1890
     feb:	6a 02                	push   $0x2
     fed:	e8 de 05 00 00       	call   15d0 <fprintf>
}
     ff2:	83 c4 10             	add    $0x10,%esp
     ff5:	c9                   	leave  
     ff6:	c3                   	ret    
     ff7:	66 90                	xchg   %ax,%ax
     ff9:	66 90                	xchg   %ax,%ax
     ffb:	66 90                	xchg   %ax,%ax
     ffd:	66 90                	xchg   %ax,%ax
     fff:	90                   	nop

00001000 <strcpy>:
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	53                   	push   %ebx
    1004:	8b 45 08             	mov    0x8(%ebp),%eax
    1007:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    100a:	89 c2                	mov    %eax,%edx
    100c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1010:	83 c1 01             	add    $0x1,%ecx
    1013:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1017:	83 c2 01             	add    $0x1,%edx
    101a:	84 db                	test   %bl,%bl
    101c:	88 5a ff             	mov    %bl,-0x1(%edx)
    101f:	75 ef                	jne    1010 <strcpy+0x10>
    ;
  return os;
}
    1021:	5b                   	pop    %ebx
    1022:	5d                   	pop    %ebp
    1023:	c3                   	ret    
    1024:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    102a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001030 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1030:	55                   	push   %ebp
    1031:	89 e5                	mov    %esp,%ebp
    1033:	53                   	push   %ebx
    1034:	8b 55 08             	mov    0x8(%ebp),%edx
    1037:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    103a:	0f b6 02             	movzbl (%edx),%eax
    103d:	0f b6 19             	movzbl (%ecx),%ebx
    1040:	84 c0                	test   %al,%al
    1042:	75 1c                	jne    1060 <strcmp+0x30>
    1044:	eb 2a                	jmp    1070 <strcmp+0x40>
    1046:	8d 76 00             	lea    0x0(%esi),%esi
    1049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    1050:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1053:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    1056:	83 c1 01             	add    $0x1,%ecx
    1059:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    105c:	84 c0                	test   %al,%al
    105e:	74 10                	je     1070 <strcmp+0x40>
    1060:	38 d8                	cmp    %bl,%al
    1062:	74 ec                	je     1050 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    1064:	29 d8                	sub    %ebx,%eax
}
    1066:	5b                   	pop    %ebx
    1067:	5d                   	pop    %ebp
    1068:	c3                   	ret    
    1069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1070:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    1072:	29 d8                	sub    %ebx,%eax
}
    1074:	5b                   	pop    %ebx
    1075:	5d                   	pop    %ebp
    1076:	c3                   	ret    
    1077:	89 f6                	mov    %esi,%esi
    1079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001080 <strlen>:

uint
strlen(const char *s)
{
    1080:	55                   	push   %ebp
    1081:	89 e5                	mov    %esp,%ebp
    1083:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1086:	80 39 00             	cmpb   $0x0,(%ecx)
    1089:	74 15                	je     10a0 <strlen+0x20>
    108b:	31 d2                	xor    %edx,%edx
    108d:	8d 76 00             	lea    0x0(%esi),%esi
    1090:	83 c2 01             	add    $0x1,%edx
    1093:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1097:	89 d0                	mov    %edx,%eax
    1099:	75 f5                	jne    1090 <strlen+0x10>
    ;
  return n;
}
    109b:	5d                   	pop    %ebp
    109c:	c3                   	ret    
    109d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    10a0:	31 c0                	xor    %eax,%eax
}
    10a2:	5d                   	pop    %ebp
    10a3:	c3                   	ret    
    10a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000010b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10b0:	55                   	push   %ebp
    10b1:	89 e5                	mov    %esp,%ebp
    10b3:	57                   	push   %edi
    10b4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    10bd:	89 d7                	mov    %edx,%edi
    10bf:	fc                   	cld    
    10c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10c2:	89 d0                	mov    %edx,%eax
    10c4:	5f                   	pop    %edi
    10c5:	5d                   	pop    %ebp
    10c6:	c3                   	ret    
    10c7:	89 f6                	mov    %esi,%esi
    10c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010d0 <strchr>:

char*
strchr(const char *s, char c)
{
    10d0:	55                   	push   %ebp
    10d1:	89 e5                	mov    %esp,%ebp
    10d3:	53                   	push   %ebx
    10d4:	8b 45 08             	mov    0x8(%ebp),%eax
    10d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    10da:	0f b6 10             	movzbl (%eax),%edx
    10dd:	84 d2                	test   %dl,%dl
    10df:	74 1d                	je     10fe <strchr+0x2e>
    if(*s == c)
    10e1:	38 d3                	cmp    %dl,%bl
    10e3:	89 d9                	mov    %ebx,%ecx
    10e5:	75 0d                	jne    10f4 <strchr+0x24>
    10e7:	eb 17                	jmp    1100 <strchr+0x30>
    10e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10f0:	38 ca                	cmp    %cl,%dl
    10f2:	74 0c                	je     1100 <strchr+0x30>
  for(; *s; s++)
    10f4:	83 c0 01             	add    $0x1,%eax
    10f7:	0f b6 10             	movzbl (%eax),%edx
    10fa:	84 d2                	test   %dl,%dl
    10fc:	75 f2                	jne    10f0 <strchr+0x20>
      return (char*)s;
  return 0;
    10fe:	31 c0                	xor    %eax,%eax
}
    1100:	5b                   	pop    %ebx
    1101:	5d                   	pop    %ebp
    1102:	c3                   	ret    
    1103:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001110 <gets>:

char*
gets(char *buf, int max)
{
    1110:	55                   	push   %ebp
    1111:	89 e5                	mov    %esp,%ebp
    1113:	57                   	push   %edi
    1114:	56                   	push   %esi
    1115:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1116:	31 f6                	xor    %esi,%esi
    1118:	89 f3                	mov    %esi,%ebx
{
    111a:	83 ec 1c             	sub    $0x1c,%esp
    111d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1120:	eb 2f                	jmp    1151 <gets+0x41>
    1122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1128:	8d 45 e7             	lea    -0x19(%ebp),%eax
    112b:	83 ec 04             	sub    $0x4,%esp
    112e:	6a 01                	push   $0x1
    1130:	50                   	push   %eax
    1131:	6a 00                	push   $0x0
    1133:	e8 32 01 00 00       	call   126a <read>
    if(cc < 1)
    1138:	83 c4 10             	add    $0x10,%esp
    113b:	85 c0                	test   %eax,%eax
    113d:	7e 1c                	jle    115b <gets+0x4b>
      break;
    buf[i++] = c;
    113f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1143:	83 c7 01             	add    $0x1,%edi
    1146:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    1149:	3c 0a                	cmp    $0xa,%al
    114b:	74 23                	je     1170 <gets+0x60>
    114d:	3c 0d                	cmp    $0xd,%al
    114f:	74 1f                	je     1170 <gets+0x60>
  for(i=0; i+1 < max; ){
    1151:	83 c3 01             	add    $0x1,%ebx
    1154:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1157:	89 fe                	mov    %edi,%esi
    1159:	7c cd                	jl     1128 <gets+0x18>
    115b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    115d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1160:	c6 03 00             	movb   $0x0,(%ebx)
}
    1163:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1166:	5b                   	pop    %ebx
    1167:	5e                   	pop    %esi
    1168:	5f                   	pop    %edi
    1169:	5d                   	pop    %ebp
    116a:	c3                   	ret    
    116b:	90                   	nop
    116c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1170:	8b 75 08             	mov    0x8(%ebp),%esi
    1173:	8b 45 08             	mov    0x8(%ebp),%eax
    1176:	01 de                	add    %ebx,%esi
    1178:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    117a:	c6 03 00             	movb   $0x0,(%ebx)
}
    117d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1180:	5b                   	pop    %ebx
    1181:	5e                   	pop    %esi
    1182:	5f                   	pop    %edi
    1183:	5d                   	pop    %ebp
    1184:	c3                   	ret    
    1185:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001190 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
    1190:	55                   	push   %ebp
    1191:	89 e5                	mov    %esp,%ebp
    1193:	56                   	push   %esi
    1194:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1195:	83 ec 08             	sub    $0x8,%esp
    1198:	6a 00                	push   $0x0
    119a:	ff 75 08             	pushl  0x8(%ebp)
    119d:	e8 f8 00 00 00       	call   129a <open>
  if(fd < 0)
    11a2:	83 c4 10             	add    $0x10,%esp
    11a5:	85 c0                	test   %eax,%eax
    11a7:	78 27                	js     11d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    11a9:	83 ec 08             	sub    $0x8,%esp
    11ac:	ff 75 0c             	pushl  0xc(%ebp)
    11af:	89 c3                	mov    %eax,%ebx
    11b1:	50                   	push   %eax
    11b2:	e8 fb 00 00 00       	call   12b2 <fstat>
  close(fd);
    11b7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    11ba:	89 c6                	mov    %eax,%esi
  close(fd);
    11bc:	e8 c1 00 00 00       	call   1282 <close>
  return r;
    11c1:	83 c4 10             	add    $0x10,%esp
}
    11c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    11c7:	89 f0                	mov    %esi,%eax
    11c9:	5b                   	pop    %ebx
    11ca:	5e                   	pop    %esi
    11cb:	5d                   	pop    %ebp
    11cc:	c3                   	ret    
    11cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    11d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    11d5:	eb ed                	jmp    11c4 <stat+0x34>
    11d7:	89 f6                	mov    %esi,%esi
    11d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011e0 <atoi>:

int
atoi(const char *s)
{
    11e0:	55                   	push   %ebp
    11e1:	89 e5                	mov    %esp,%ebp
    11e3:	53                   	push   %ebx
    11e4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    11e7:	0f be 11             	movsbl (%ecx),%edx
    11ea:	8d 42 d0             	lea    -0x30(%edx),%eax
    11ed:	3c 09                	cmp    $0x9,%al
  n = 0;
    11ef:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    11f4:	77 1f                	ja     1215 <atoi+0x35>
    11f6:	8d 76 00             	lea    0x0(%esi),%esi
    11f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1200:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1203:	83 c1 01             	add    $0x1,%ecx
    1206:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    120a:	0f be 11             	movsbl (%ecx),%edx
    120d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1210:	80 fb 09             	cmp    $0x9,%bl
    1213:	76 eb                	jbe    1200 <atoi+0x20>
  return n;
}
    1215:	5b                   	pop    %ebx
    1216:	5d                   	pop    %ebp
    1217:	c3                   	ret    
    1218:	90                   	nop
    1219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001220 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	56                   	push   %esi
    1224:	53                   	push   %ebx
    1225:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1228:	8b 45 08             	mov    0x8(%ebp),%eax
    122b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    122e:	85 db                	test   %ebx,%ebx
    1230:	7e 14                	jle    1246 <memmove+0x26>
    1232:	31 d2                	xor    %edx,%edx
    1234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    1238:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    123c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    123f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    1242:	39 d3                	cmp    %edx,%ebx
    1244:	75 f2                	jne    1238 <memmove+0x18>
  return vdst;
}
    1246:	5b                   	pop    %ebx
    1247:	5e                   	pop    %esi
    1248:	5d                   	pop    %ebp
    1249:	c3                   	ret    

0000124a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    124a:	b8 01 00 00 00       	mov    $0x1,%eax
    124f:	cd 40                	int    $0x40
    1251:	c3                   	ret    

00001252 <exit>:
SYSCALL(exit)
    1252:	b8 02 00 00 00       	mov    $0x2,%eax
    1257:	cd 40                	int    $0x40
    1259:	c3                   	ret    

0000125a <wait>:
SYSCALL(wait)
    125a:	b8 03 00 00 00       	mov    $0x3,%eax
    125f:	cd 40                	int    $0x40
    1261:	c3                   	ret    

00001262 <pipe>:
SYSCALL(pipe)
    1262:	b8 04 00 00 00       	mov    $0x4,%eax
    1267:	cd 40                	int    $0x40
    1269:	c3                   	ret    

0000126a <read>:
SYSCALL(read)
    126a:	b8 05 00 00 00       	mov    $0x5,%eax
    126f:	cd 40                	int    $0x40
    1271:	c3                   	ret    

00001272 <steal>:
SYSCALL(steal)
    1272:	b8 17 00 00 00       	mov    $0x17,%eax
    1277:	cd 40                	int    $0x40
    1279:	c3                   	ret    

0000127a <write>:
SYSCALL(write)
    127a:	b8 10 00 00 00       	mov    $0x10,%eax
    127f:	cd 40                	int    $0x40
    1281:	c3                   	ret    

00001282 <close>:
SYSCALL(close)
    1282:	b8 15 00 00 00       	mov    $0x15,%eax
    1287:	cd 40                	int    $0x40
    1289:	c3                   	ret    

0000128a <kill>:
SYSCALL(kill)
    128a:	b8 06 00 00 00       	mov    $0x6,%eax
    128f:	cd 40                	int    $0x40
    1291:	c3                   	ret    

00001292 <exec>:
SYSCALL(exec)
    1292:	b8 07 00 00 00       	mov    $0x7,%eax
    1297:	cd 40                	int    $0x40
    1299:	c3                   	ret    

0000129a <open>:
SYSCALL(open)
    129a:	b8 0f 00 00 00       	mov    $0xf,%eax
    129f:	cd 40                	int    $0x40
    12a1:	c3                   	ret    

000012a2 <mknod>:
SYSCALL(mknod)
    12a2:	b8 11 00 00 00       	mov    $0x11,%eax
    12a7:	cd 40                	int    $0x40
    12a9:	c3                   	ret    

000012aa <unlink>:
SYSCALL(unlink)
    12aa:	b8 12 00 00 00       	mov    $0x12,%eax
    12af:	cd 40                	int    $0x40
    12b1:	c3                   	ret    

000012b2 <fstat>:
SYSCALL(fstat)
    12b2:	b8 08 00 00 00       	mov    $0x8,%eax
    12b7:	cd 40                	int    $0x40
    12b9:	c3                   	ret    

000012ba <link>:
SYSCALL(link)
    12ba:	b8 13 00 00 00       	mov    $0x13,%eax
    12bf:	cd 40                	int    $0x40
    12c1:	c3                   	ret    

000012c2 <mkdir>:
SYSCALL(mkdir)
    12c2:	b8 14 00 00 00       	mov    $0x14,%eax
    12c7:	cd 40                	int    $0x40
    12c9:	c3                   	ret    

000012ca <chdir>:
SYSCALL(chdir)
    12ca:	b8 09 00 00 00       	mov    $0x9,%eax
    12cf:	cd 40                	int    $0x40
    12d1:	c3                   	ret    

000012d2 <dup>:
SYSCALL(dup)
    12d2:	b8 0a 00 00 00       	mov    $0xa,%eax
    12d7:	cd 40                	int    $0x40
    12d9:	c3                   	ret    

000012da <getpid>:
SYSCALL(getpid)
    12da:	b8 0b 00 00 00       	mov    $0xb,%eax
    12df:	cd 40                	int    $0x40
    12e1:	c3                   	ret    

000012e2 <sbrk>:
SYSCALL(sbrk)
    12e2:	b8 0c 00 00 00       	mov    $0xc,%eax
    12e7:	cd 40                	int    $0x40
    12e9:	c3                   	ret    

000012ea <sleep>:
SYSCALL(sleep)
    12ea:	b8 0d 00 00 00       	mov    $0xd,%eax
    12ef:	cd 40                	int    $0x40
    12f1:	c3                   	ret    

000012f2 <uptime>:
SYSCALL(uptime)
    12f2:	b8 0e 00 00 00       	mov    $0xe,%eax
    12f7:	cd 40                	int    $0x40
    12f9:	c3                   	ret    

000012fa <cpuhalt>:
SYSCALL(cpuhalt)
    12fa:	b8 16 00 00 00       	mov    $0x16,%eax
    12ff:	cd 40                	int    $0x40
    1301:	c3                   	ret    
    1302:	66 90                	xchg   %ax,%ax
    1304:	66 90                	xchg   %ax,%ax
    1306:	66 90                	xchg   %ax,%ax
    1308:	66 90                	xchg   %ax,%ax
    130a:	66 90                	xchg   %ax,%ax
    130c:	66 90                	xchg   %ax,%ax
    130e:	66 90                	xchg   %ax,%ax

00001310 <printint.constprop.1>:
    1310:	55                   	push   %ebp
    1311:	89 e5                	mov    %esp,%ebp
    1313:	57                   	push   %edi
    1314:	56                   	push   %esi
    1315:	53                   	push   %ebx
    1316:	89 d6                	mov    %edx,%esi
    1318:	83 ec 3c             	sub    $0x3c,%esp
    131b:	85 c0                	test   %eax,%eax
    131d:	79 71                	jns    1390 <printint.constprop.1+0x80>
    131f:	83 e1 01             	and    $0x1,%ecx
    1322:	74 6c                	je     1390 <printint.constprop.1+0x80>
    1324:	f7 d8                	neg    %eax
    1326:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    132d:	31 c9                	xor    %ecx,%ecx
    132f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1332:	eb 06                	jmp    133a <printint.constprop.1+0x2a>
    1334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1338:	89 f9                	mov    %edi,%ecx
    133a:	31 d2                	xor    %edx,%edx
    133c:	8d 79 01             	lea    0x1(%ecx),%edi
    133f:	f7 f6                	div    %esi
    1341:	0f b6 92 80 1a 00 00 	movzbl 0x1a80(%edx),%edx
    1348:	85 c0                	test   %eax,%eax
    134a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
    134d:	75 e9                	jne    1338 <printint.constprop.1+0x28>
    134f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1352:	85 c0                	test   %eax,%eax
    1354:	74 08                	je     135e <printint.constprop.1+0x4e>
    1356:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    135b:	8d 79 02             	lea    0x2(%ecx),%edi
    135e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    1362:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1368:	0f b6 06             	movzbl (%esi),%eax
    136b:	83 ec 04             	sub    $0x4,%esp
    136e:	83 ee 01             	sub    $0x1,%esi
    1371:	6a 01                	push   $0x1
    1373:	53                   	push   %ebx
    1374:	6a 01                	push   $0x1
    1376:	88 45 d7             	mov    %al,-0x29(%ebp)
    1379:	e8 fc fe ff ff       	call   127a <write>
    137e:	83 c4 10             	add    $0x10,%esp
    1381:	39 de                	cmp    %ebx,%esi
    1383:	75 e3                	jne    1368 <printint.constprop.1+0x58>
    1385:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1388:	5b                   	pop    %ebx
    1389:	5e                   	pop    %esi
    138a:	5f                   	pop    %edi
    138b:	5d                   	pop    %ebp
    138c:	c3                   	ret    
    138d:	8d 76 00             	lea    0x0(%esi),%esi
    1390:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1397:	eb 94                	jmp    132d <printint.constprop.1+0x1d>
    1399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000013a0 <vprintf.constprop.0>:
    13a0:	55                   	push   %ebp
    13a1:	89 e5                	mov    %esp,%ebp
    13a3:	57                   	push   %edi
    13a4:	56                   	push   %esi
    13a5:	53                   	push   %ebx
    13a6:	89 d6                	mov    %edx,%esi
    13a8:	83 ec 2c             	sub    $0x2c,%esp
    13ab:	0f b6 10             	movzbl (%eax),%edx
    13ae:	84 d2                	test   %dl,%dl
    13b0:	0f 84 cd 00 00 00    	je     1483 <vprintf.constprop.0+0xe3>
    13b6:	8d 58 01             	lea    0x1(%eax),%ebx
    13b9:	31 ff                	xor    %edi,%edi
    13bb:	eb 31                	jmp    13ee <vprintf.constprop.0+0x4e>
    13bd:	8d 76 00             	lea    0x0(%esi),%esi
    13c0:	83 f8 25             	cmp    $0x25,%eax
    13c3:	0f 84 c7 00 00 00    	je     1490 <vprintf.constprop.0+0xf0>
    13c9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    13cc:	83 ec 04             	sub    $0x4,%esp
    13cf:	88 55 e4             	mov    %dl,-0x1c(%ebp)
    13d2:	6a 01                	push   $0x1
    13d4:	50                   	push   %eax
    13d5:	6a 01                	push   $0x1
    13d7:	e8 9e fe ff ff       	call   127a <write>
    13dc:	83 c4 10             	add    $0x10,%esp
    13df:	83 c3 01             	add    $0x1,%ebx
    13e2:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    13e6:	84 d2                	test   %dl,%dl
    13e8:	0f 84 95 00 00 00    	je     1483 <vprintf.constprop.0+0xe3>
    13ee:	85 ff                	test   %edi,%edi
    13f0:	0f b6 c2             	movzbl %dl,%eax
    13f3:	74 cb                	je     13c0 <vprintf.constprop.0+0x20>
    13f5:	83 ff 25             	cmp    $0x25,%edi
    13f8:	75 e5                	jne    13df <vprintf.constprop.0+0x3f>
    13fa:	83 f8 64             	cmp    $0x64,%eax
    13fd:	8d 7e 04             	lea    0x4(%esi),%edi
    1400:	b9 01 00 00 00       	mov    $0x1,%ecx
    1405:	0f 84 9a 00 00 00    	je     14a5 <vprintf.constprop.0+0x105>
    140b:	83 f8 6c             	cmp    $0x6c,%eax
    140e:	0f 84 8c 00 00 00    	je     14a0 <vprintf.constprop.0+0x100>
    1414:	83 f8 78             	cmp    $0x78,%eax
    1417:	0f 84 a3 00 00 00    	je     14c0 <vprintf.constprop.0+0x120>
    141d:	83 f8 70             	cmp    $0x70,%eax
    1420:	0f 84 ca 00 00 00    	je     14f0 <vprintf.constprop.0+0x150>
    1426:	83 f8 73             	cmp    $0x73,%eax
    1429:	0f 84 39 01 00 00    	je     1568 <vprintf.constprop.0+0x1c8>
    142f:	83 f8 63             	cmp    $0x63,%eax
    1432:	0f 84 68 01 00 00    	je     15a0 <vprintf.constprop.0+0x200>
    1438:	83 f8 25             	cmp    $0x25,%eax
    143b:	0f 84 9f 00 00 00    	je     14e0 <vprintf.constprop.0+0x140>
    1441:	8d 45 df             	lea    -0x21(%ebp),%eax
    1444:	83 ec 04             	sub    $0x4,%esp
    1447:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    144a:	6a 01                	push   $0x1
    144c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
    1450:	50                   	push   %eax
    1451:	6a 01                	push   $0x1
    1453:	e8 22 fe ff ff       	call   127a <write>
    1458:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    145c:	83 c4 0c             	add    $0xc,%esp
    145f:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1462:	6a 01                	push   $0x1
    1464:	88 55 e0             	mov    %dl,-0x20(%ebp)
    1467:	50                   	push   %eax
    1468:	6a 01                	push   $0x1
    146a:	83 c3 01             	add    $0x1,%ebx
    146d:	31 ff                	xor    %edi,%edi
    146f:	e8 06 fe ff ff       	call   127a <write>
    1474:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1478:	83 c4 10             	add    $0x10,%esp
    147b:	84 d2                	test   %dl,%dl
    147d:	0f 85 6b ff ff ff    	jne    13ee <vprintf.constprop.0+0x4e>
    1483:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1486:	5b                   	pop    %ebx
    1487:	5e                   	pop    %esi
    1488:	5f                   	pop    %edi
    1489:	5d                   	pop    %ebp
    148a:	c3                   	ret    
    148b:	90                   	nop
    148c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1490:	bf 25 00 00 00       	mov    $0x25,%edi
    1495:	e9 45 ff ff ff       	jmp    13df <vprintf.constprop.0+0x3f>
    149a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    14a0:	8d 7e 04             	lea    0x4(%esi),%edi
    14a3:	31 c9                	xor    %ecx,%ecx
    14a5:	8b 06                	mov    (%esi),%eax
    14a7:	ba 0a 00 00 00       	mov    $0xa,%edx
    14ac:	89 fe                	mov    %edi,%esi
    14ae:	31 ff                	xor    %edi,%edi
    14b0:	e8 5b fe ff ff       	call   1310 <printint.constprop.1>
    14b5:	e9 25 ff ff ff       	jmp    13df <vprintf.constprop.0+0x3f>
    14ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    14c0:	8b 06                	mov    (%esi),%eax
    14c2:	8d 7e 04             	lea    0x4(%esi),%edi
    14c5:	31 c9                	xor    %ecx,%ecx
    14c7:	ba 10 00 00 00       	mov    $0x10,%edx
    14cc:	89 fe                	mov    %edi,%esi
    14ce:	31 ff                	xor    %edi,%edi
    14d0:	e8 3b fe ff ff       	call   1310 <printint.constprop.1>
    14d5:	e9 05 ff ff ff       	jmp    13df <vprintf.constprop.0+0x3f>
    14da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    14e0:	83 ec 04             	sub    $0x4,%esp
    14e3:	88 55 e1             	mov    %dl,-0x1f(%ebp)
    14e6:	8d 45 e1             	lea    -0x1f(%ebp),%eax
    14e9:	6a 01                	push   $0x1
    14eb:	e9 77 ff ff ff       	jmp    1467 <vprintf.constprop.0+0xc7>
    14f0:	8d 46 04             	lea    0x4(%esi),%eax
    14f3:	83 ec 04             	sub    $0x4,%esp
    14f6:	8b 3e                	mov    (%esi),%edi
    14f8:	6a 01                	push   $0x1
    14fa:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
    14fe:	be 08 00 00 00       	mov    $0x8,%esi
    1503:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1506:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1509:	50                   	push   %eax
    150a:	6a 01                	push   $0x1
    150c:	e8 69 fd ff ff       	call   127a <write>
    1511:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1514:	83 c4 0c             	add    $0xc,%esp
    1517:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
    151b:	6a 01                	push   $0x1
    151d:	50                   	push   %eax
    151e:	6a 01                	push   $0x1
    1520:	e8 55 fd ff ff       	call   127a <write>
    1525:	83 c4 10             	add    $0x10,%esp
    1528:	90                   	nop
    1529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1530:	89 f8                	mov    %edi,%eax
    1532:	83 ec 04             	sub    $0x4,%esp
    1535:	c1 e7 04             	shl    $0x4,%edi
    1538:	c1 e8 1c             	shr    $0x1c,%eax
    153b:	6a 01                	push   $0x1
    153d:	0f b6 80 80 1a 00 00 	movzbl 0x1a80(%eax),%eax
    1544:	88 45 e5             	mov    %al,-0x1b(%ebp)
    1547:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    154a:	50                   	push   %eax
    154b:	6a 01                	push   $0x1
    154d:	e8 28 fd ff ff       	call   127a <write>
    1552:	83 c4 10             	add    $0x10,%esp
    1555:	83 ee 01             	sub    $0x1,%esi
    1558:	75 d6                	jne    1530 <vprintf.constprop.0+0x190>
    155a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    155d:	31 ff                	xor    %edi,%edi
    155f:	e9 7b fe ff ff       	jmp    13df <vprintf.constprop.0+0x3f>
    1564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1568:	8b 3e                	mov    (%esi),%edi
    156a:	8d 46 04             	lea    0x4(%esi),%eax
    156d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1570:	85 ff                	test   %edi,%edi
    1572:	74 50                	je     15c4 <vprintf.constprop.0+0x224>
    1574:	0f b6 07             	movzbl (%edi),%eax
    1577:	84 c0                	test   %al,%al
    1579:	74 df                	je     155a <vprintf.constprop.0+0x1ba>
    157b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
    157e:	66 90                	xchg   %ax,%ax
    1580:	83 ec 04             	sub    $0x4,%esp
    1583:	83 c7 01             	add    $0x1,%edi
    1586:	88 45 e3             	mov    %al,-0x1d(%ebp)
    1589:	6a 01                	push   $0x1
    158b:	56                   	push   %esi
    158c:	6a 01                	push   $0x1
    158e:	e8 e7 fc ff ff       	call   127a <write>
    1593:	0f b6 07             	movzbl (%edi),%eax
    1596:	83 c4 10             	add    $0x10,%esp
    1599:	84 c0                	test   %al,%al
    159b:	75 e3                	jne    1580 <vprintf.constprop.0+0x1e0>
    159d:	eb bb                	jmp    155a <vprintf.constprop.0+0x1ba>
    159f:	90                   	nop
    15a0:	8b 06                	mov    (%esi),%eax
    15a2:	83 ec 04             	sub    $0x4,%esp
    15a5:	8d 7e 04             	lea    0x4(%esi),%edi
    15a8:	6a 01                	push   $0x1
    15aa:	89 fe                	mov    %edi,%esi
    15ac:	31 ff                	xor    %edi,%edi
    15ae:	88 45 e2             	mov    %al,-0x1e(%ebp)
    15b1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    15b4:	50                   	push   %eax
    15b5:	6a 01                	push   $0x1
    15b7:	e8 be fc ff ff       	call   127a <write>
    15bc:	83 c4 10             	add    $0x10,%esp
    15bf:	e9 1b fe ff ff       	jmp    13df <vprintf.constprop.0+0x3f>
    15c4:	bf 78 1a 00 00       	mov    $0x1a78,%edi
    15c9:	b8 28 00 00 00       	mov    $0x28,%eax
    15ce:	eb ab                	jmp    157b <vprintf.constprop.0+0x1db>

000015d0 <fprintf>:
    15d0:	55                   	push   %ebp
    15d1:	89 e5                	mov    %esp,%ebp
    15d3:	83 ec 08             	sub    $0x8,%esp
    15d6:	8b 45 0c             	mov    0xc(%ebp),%eax
    15d9:	8d 55 10             	lea    0x10(%ebp),%edx
    15dc:	e8 bf fd ff ff       	call   13a0 <vprintf.constprop.0>
    15e1:	c9                   	leave  
    15e2:	c3                   	ret    
    15e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    15e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000015f0 <printf>:
    15f0:	55                   	push   %ebp
    15f1:	89 e5                	mov    %esp,%ebp
    15f3:	83 ec 08             	sub    $0x8,%esp
    15f6:	8b 45 08             	mov    0x8(%ebp),%eax
    15f9:	8d 55 0c             	lea    0xc(%ebp),%edx
    15fc:	e8 9f fd ff ff       	call   13a0 <vprintf.constprop.0>
    1601:	c9                   	leave  
    1602:	c3                   	ret    
    1603:	66 90                	xchg   %ax,%ax
    1605:	66 90                	xchg   %ax,%ax
    1607:	66 90                	xchg   %ax,%ax
    1609:	66 90                	xchg   %ax,%ax
    160b:	66 90                	xchg   %ax,%ax
    160d:	66 90                	xchg   %ax,%ax
    160f:	90                   	nop

00001610 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1610:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1611:	a1 b4 23 00 00       	mov    0x23b4,%eax
{
    1616:	89 e5                	mov    %esp,%ebp
    1618:	57                   	push   %edi
    1619:	56                   	push   %esi
    161a:	53                   	push   %ebx
    161b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    161e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1628:	39 c8                	cmp    %ecx,%eax
    162a:	8b 10                	mov    (%eax),%edx
    162c:	73 32                	jae    1660 <free+0x50>
    162e:	39 d1                	cmp    %edx,%ecx
    1630:	72 04                	jb     1636 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1632:	39 d0                	cmp    %edx,%eax
    1634:	72 32                	jb     1668 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1636:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1639:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    163c:	39 fa                	cmp    %edi,%edx
    163e:	74 30                	je     1670 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1640:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1643:	8b 50 04             	mov    0x4(%eax),%edx
    1646:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1649:	39 f1                	cmp    %esi,%ecx
    164b:	74 3a                	je     1687 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    164d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    164f:	a3 b4 23 00 00       	mov    %eax,0x23b4
}
    1654:	5b                   	pop    %ebx
    1655:	5e                   	pop    %esi
    1656:	5f                   	pop    %edi
    1657:	5d                   	pop    %ebp
    1658:	c3                   	ret    
    1659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1660:	39 d0                	cmp    %edx,%eax
    1662:	72 04                	jb     1668 <free+0x58>
    1664:	39 d1                	cmp    %edx,%ecx
    1666:	72 ce                	jb     1636 <free+0x26>
{
    1668:	89 d0                	mov    %edx,%eax
    166a:	eb bc                	jmp    1628 <free+0x18>
    166c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1670:	03 72 04             	add    0x4(%edx),%esi
    1673:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1676:	8b 10                	mov    (%eax),%edx
    1678:	8b 12                	mov    (%edx),%edx
    167a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    167d:	8b 50 04             	mov    0x4(%eax),%edx
    1680:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1683:	39 f1                	cmp    %esi,%ecx
    1685:	75 c6                	jne    164d <free+0x3d>
    p->s.size += bp->s.size;
    1687:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    168a:	a3 b4 23 00 00       	mov    %eax,0x23b4
    p->s.size += bp->s.size;
    168f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1692:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1695:	89 10                	mov    %edx,(%eax)
}
    1697:	5b                   	pop    %ebx
    1698:	5e                   	pop    %esi
    1699:	5f                   	pop    %edi
    169a:	5d                   	pop    %ebp
    169b:	c3                   	ret    
    169c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000016a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    16a0:	55                   	push   %ebp
    16a1:	89 e5                	mov    %esp,%ebp
    16a3:	57                   	push   %edi
    16a4:	56                   	push   %esi
    16a5:	53                   	push   %ebx
    16a6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    16a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    16ac:	8b 15 b4 23 00 00    	mov    0x23b4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    16b2:	8d 78 07             	lea    0x7(%eax),%edi
    16b5:	c1 ef 03             	shr    $0x3,%edi
    16b8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    16bb:	85 d2                	test   %edx,%edx
    16bd:	0f 84 9d 00 00 00    	je     1760 <malloc+0xc0>
    16c3:	8b 02                	mov    (%edx),%eax
    16c5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    16c8:	39 cf                	cmp    %ecx,%edi
    16ca:	76 6c                	jbe    1738 <malloc+0x98>
    16cc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    16d2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    16d7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    16da:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    16e1:	eb 0e                	jmp    16f1 <malloc+0x51>
    16e3:	90                   	nop
    16e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16e8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    16ea:	8b 48 04             	mov    0x4(%eax),%ecx
    16ed:	39 f9                	cmp    %edi,%ecx
    16ef:	73 47                	jae    1738 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    16f1:	39 05 b4 23 00 00    	cmp    %eax,0x23b4
    16f7:	89 c2                	mov    %eax,%edx
    16f9:	75 ed                	jne    16e8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    16fb:	83 ec 0c             	sub    $0xc,%esp
    16fe:	56                   	push   %esi
    16ff:	e8 de fb ff ff       	call   12e2 <sbrk>
  if(p == (char*)-1)
    1704:	83 c4 10             	add    $0x10,%esp
    1707:	83 f8 ff             	cmp    $0xffffffff,%eax
    170a:	74 1c                	je     1728 <malloc+0x88>
  hp->s.size = nu;
    170c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    170f:	83 ec 0c             	sub    $0xc,%esp
    1712:	83 c0 08             	add    $0x8,%eax
    1715:	50                   	push   %eax
    1716:	e8 f5 fe ff ff       	call   1610 <free>
  return freep;
    171b:	8b 15 b4 23 00 00    	mov    0x23b4,%edx
      if((p = morecore(nunits)) == 0)
    1721:	83 c4 10             	add    $0x10,%esp
    1724:	85 d2                	test   %edx,%edx
    1726:	75 c0                	jne    16e8 <malloc+0x48>
        return 0;
  }
}
    1728:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    172b:	31 c0                	xor    %eax,%eax
}
    172d:	5b                   	pop    %ebx
    172e:	5e                   	pop    %esi
    172f:	5f                   	pop    %edi
    1730:	5d                   	pop    %ebp
    1731:	c3                   	ret    
    1732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1738:	39 cf                	cmp    %ecx,%edi
    173a:	74 54                	je     1790 <malloc+0xf0>
        p->s.size -= nunits;
    173c:	29 f9                	sub    %edi,%ecx
    173e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1741:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1744:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1747:	89 15 b4 23 00 00    	mov    %edx,0x23b4
}
    174d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1750:	83 c0 08             	add    $0x8,%eax
}
    1753:	5b                   	pop    %ebx
    1754:	5e                   	pop    %esi
    1755:	5f                   	pop    %edi
    1756:	5d                   	pop    %ebp
    1757:	c3                   	ret    
    1758:	90                   	nop
    1759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1760:	c7 05 b4 23 00 00 b8 	movl   $0x23b8,0x23b4
    1767:	23 00 00 
    176a:	c7 05 b8 23 00 00 b8 	movl   $0x23b8,0x23b8
    1771:	23 00 00 
    base.s.size = 0;
    1774:	b8 b8 23 00 00       	mov    $0x23b8,%eax
    1779:	c7 05 bc 23 00 00 00 	movl   $0x0,0x23bc
    1780:	00 00 00 
    1783:	e9 44 ff ff ff       	jmp    16cc <malloc+0x2c>
    1788:	90                   	nop
    1789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1790:	8b 08                	mov    (%eax),%ecx
    1792:	89 0a                	mov    %ecx,(%edx)
    1794:	eb b1                	jmp    1747 <malloc+0xa7>
