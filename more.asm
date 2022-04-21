
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
      1a:	0f 8e 19 01 00 00    	jle    139 <main+0x139>
    fprintf(2, "more: bad usage\nTry 'more --help' for more information.\n");
    exit();
  } else if (argc > 2) {
      20:	83 f8 02             	cmp    $0x2,%eax
      23:	0f 85 bf 00 00 00    	jne    e8 <main+0xe8>
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
      44:	e8 47 02 00 00       	call   290 <MakeLinkedList>

  // opening file
  file.fd = open(file.filename, O_RDONLY);
      49:	52                   	push   %edx
      4a:	52                   	push   %edx
      4b:	6a 00                	push   $0x0
      4d:	ff 75 e0             	pushl  -0x20(%ebp)
  file.lines = MakeLinkedList();
      50:	89 45 ec             	mov    %eax,-0x14(%ebp)
  file.fd = open(file.filename, O_RDONLY);
      53:	e8 c2 12 00 00       	call   131a <open>
  if (file.fd == -1) {
      58:	83 c4 10             	add    $0x10,%esp
  file.fd = open(file.filename, O_RDONLY);
      5b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if (file.fd == -1) {
      5e:	83 c0 01             	add    $0x1,%eax
      61:	0f 84 e5 00 00 00    	je     14c <main+0x14c>
    fprintf(2, "file could not be opened\n",  file.filename);
  } else { 
    // populate Linked List
    gatherLines(&file);
      67:	8d 45 e0             	lea    -0x20(%ebp),%eax
      6a:	83 ec 0c             	sub    $0xc,%esp
      6d:	50                   	push   %eax
      6e:	e8 1d 05 00 00       	call   590 <gatherLines>
      73:	83 c4 10             	add    $0x10,%esp
  }
  close(file.fd);
      76:	83 ec 0c             	sub    $0xc,%esp
      79:	ff 75 e4             	pushl  -0x1c(%ebp)
      7c:	e8 81 12 00 00       	call   1302 <close>
      81:	83 c4 10             	add    $0x10,%esp
      84:	eb 2f                	jmp    b5 <main+0xb5>
      86:	8d 76 00             	lea    0x0(%esi),%esi
      89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  while (cmdint != 113) {
    cmdint = steal(0);
    cmd = (char) cmdint;
		// printf("cmd: %d = %c.\n", cmdint, cmd);
		if (cmd == '\0') exit();
		switch (cmd) {
      90:	3c 20                	cmp    $0x20,%al
      92:	74 6c                	je     100 <main+0x100>
      94:	3c 3d                	cmp    $0x3d,%al
      96:	75 18                	jne    b0 <main+0xb0>
}
void scroll(struct File file){
  printf("scroll     \r");
}
void line(struct File file){
  printf("line       \r");
      98:	83 ec 0c             	sub    $0xc,%esp
      9b:	68 83 18 00 00       	push   $0x1883
      a0:	e8 cb 15 00 00       	call   1670 <printf>
      a5:	83 c4 10             	add    $0x10,%esp
      a8:	90                   	nop
      a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while (cmdint != 113) {
      b0:	83 fb 71             	cmp    $0x71,%ebx
      b3:	74 46                	je     fb <main+0xfb>
    cmdint = steal(0);
      b5:	83 ec 0c             	sub    $0xc,%esp
      b8:	6a 00                	push   $0x0
      ba:	e8 33 12 00 00       	call   12f2 <steal>
		if (cmd == '\0') exit();
      bf:	83 c4 10             	add    $0x10,%esp
      c2:	84 c0                	test   %al,%al
    cmdint = steal(0);
      c4:	89 c3                	mov    %eax,%ebx
		if (cmd == '\0') exit();
      c6:	74 33                	je     fb <main+0xfb>
		switch (cmd) {
      c8:	3c 62                	cmp    $0x62,%al
      ca:	74 46                	je     112 <main+0x112>
      cc:	7e c2                	jle    90 <main+0x90>
      ce:	3c 65                	cmp    $0x65,%al
      d0:	74 52                	je     124 <main+0x124>
      d2:	3c 66                	cmp    $0x66,%al
      d4:	75 da                	jne    b0 <main+0xb0>
  printf("fastforward\r");
      d6:	83 ec 0c             	sub    $0xc,%esp
      d9:	68 5c 18 00 00       	push   $0x185c
      de:	e8 8d 15 00 00       	call   1670 <printf>
      e3:	83 c4 10             	add    $0x10,%esp
      e6:	eb c8                	jmp    b0 <main+0xb0>
    fprintf(2, "this version of more only supports one file at a time.\n");
      e8:	51                   	push   %ecx
      e9:	51                   	push   %ecx
      ea:	68 6c 19 00 00       	push   $0x196c
      ef:	6a 02                	push   $0x2
      f1:	e8 5a 15 00 00       	call   1650 <fprintf>
    exit();
      f6:	e8 d7 11 00 00       	call   12d2 <exit>
		if (cmd == '\0') exit();
      fb:	e8 d2 11 00 00       	call   12d2 <exit>
  printf("forward    \r");
     100:	83 ec 0c             	sub    $0xc,%esp
     103:	68 4f 18 00 00       	push   $0x184f
     108:	e8 63 15 00 00       	call   1670 <printf>
     10d:	83 c4 10             	add    $0x10,%esp
     110:	eb 9e                	jmp    b0 <main+0xb0>
  printf("back       \r");
     112:	83 ec 0c             	sub    $0xc,%esp
     115:	68 69 18 00 00       	push   $0x1869
     11a:	e8 51 15 00 00       	call   1670 <printf>
     11f:	83 c4 10             	add    $0x10,%esp
     122:	eb 8c                	jmp    b0 <main+0xb0>
  printf("scroll     \r");
     124:	83 ec 0c             	sub    $0xc,%esp
     127:	68 76 18 00 00       	push   $0x1876
     12c:	e8 3f 15 00 00       	call   1670 <printf>
     131:	83 c4 10             	add    $0x10,%esp
     134:	e9 77 ff ff ff       	jmp    b0 <main+0xb0>
    fprintf(2, "more: bad usage\nTry 'more --help' for more information.\n");
     139:	53                   	push   %ebx
     13a:	53                   	push   %ebx
     13b:	68 30 19 00 00       	push   $0x1930
     140:	6a 02                	push   $0x2
     142:	e8 09 15 00 00       	call   1650 <fprintf>
    exit();
     147:	e8 86 11 00 00       	call   12d2 <exit>
    fprintf(2, "file could not be opened\n",  file.filename);
     14c:	50                   	push   %eax
     14d:	ff 75 e0             	pushl  -0x20(%ebp)
     150:	68 35 18 00 00       	push   $0x1835
     155:	6a 02                	push   $0x2
     157:	e8 f4 14 00 00       	call   1650 <fprintf>
     15c:	83 c4 10             	add    $0x10,%esp
     15f:	e9 12 ff ff ff       	jmp    76 <main+0x76>
     164:	66 90                	xchg   %ax,%ax
     166:	66 90                	xchg   %ax,%ax
     168:	66 90                	xchg   %ax,%ax
     16a:	66 90                	xchg   %ax,%ax
     16c:	66 90                	xchg   %ax,%ax
     16e:	66 90                	xchg   %ax,%ax

00000170 <safestrcpy>:
#include "LinkedList.h"
#define nullptr 0

char* safestrcpy(char *s, const char *t, int n) {
     170:	55                   	push   %ebp
     171:	89 e5                	mov    %esp,%ebp
     173:	56                   	push   %esi
     174:	53                   	push   %ebx
     175:	8b 4d 10             	mov    0x10(%ebp),%ecx
     178:	8b 45 08             	mov    0x8(%ebp),%eax
     17b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
     17e:	85 c9                	test   %ecx,%ecx
     180:	7e 26                	jle    1a8 <safestrcpy+0x38>
     182:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
     186:	89 c1                	mov    %eax,%ecx
     188:	eb 17                	jmp    1a1 <safestrcpy+0x31>
     18a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
     190:	83 c2 01             	add    $0x1,%edx
     193:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
     197:	83 c1 01             	add    $0x1,%ecx
     19a:	84 db                	test   %bl,%bl
     19c:	88 59 ff             	mov    %bl,-0x1(%ecx)
     19f:	74 04                	je     1a5 <safestrcpy+0x35>
     1a1:	39 f2                	cmp    %esi,%edx
     1a3:	75 eb                	jne    190 <safestrcpy+0x20>
    ;
  *s = 0;
     1a5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
     1a8:	5b                   	pop    %ebx
     1a9:	5e                   	pop    %esi
     1aa:	5d                   	pop    %ebp
     1ab:	c3                   	ret    
     1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001b0 <nullNode>:

Node* nullNode(char* data) {
     1b0:	55                   	push   %ebp
     1b1:	89 e5                	mov    %esp,%ebp
     1b3:	83 ec 14             	sub    $0x14,%esp
  struct Node* node = malloc(sizeof(Node));
     1b6:	6a 0c                	push   $0xc
     1b8:	e8 63 15 00 00       	call   1720 <malloc>
  node->prev = nullptr;
  node->data = data;
     1bd:	8b 55 08             	mov    0x8(%ebp),%edx
  node->prev = nullptr;
     1c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->next = nullptr;
     1c6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  node->data = data;
     1cd:	89 50 04             	mov    %edx,0x4(%eax)
  return node;
}
     1d0:	c9                   	leave  
     1d1:	c3                   	ret    
     1d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001e0 <nodeAt>:

Node* nodeAt(struct LinkedList* list, int pos) {
     1e0:	55                   	push   %ebp
     1e1:	89 e5                	mov    %esp,%ebp
     1e3:	53                   	push   %ebx
     1e4:	8b 45 08             	mov    0x8(%ebp),%eax
     1e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  // for anything past the end:
  if (pos > list->len)
     1ea:	8b 48 08             	mov    0x8(%eax),%ecx
     1ed:	39 d1                	cmp    %edx,%ecx
     1ef:	7c 1f                	jl     210 <nodeAt+0x30>
    return list->tail->prev;
  // for anything before the beginning:
  if ((pos < 0) && ((0 - pos) > list->len))
     1f1:	85 d2                	test   %edx,%edx
     1f3:	78 2b                	js     220 <nodeAt+0x40>
    while (++pos != 0)
      curNode = curNode->prev;
  } // start looking from front
  else {
    int cur = 0;
    curNode = list->head->next;
     1f5:	8b 00                	mov    (%eax),%eax
     1f7:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     1fa:	74 0e                	je     20a <nodeAt+0x2a>
    int cur = 0;
     1fc:	31 c9                	xor    %ecx,%ecx
     1fe:	66 90                	xchg   %ax,%ax
      curNode = curNode->next;
      cur++;
     200:	83 c1 01             	add    $0x1,%ecx
      curNode = curNode->next;
     203:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     206:	39 ca                	cmp    %ecx,%edx
     208:	75 f6                	jne    200 <nodeAt+0x20>
    }
  }
  return curNode;
}
     20a:	5b                   	pop    %ebx
     20b:	5d                   	pop    %ebp
     20c:	c3                   	ret    
     20d:	8d 76 00             	lea    0x0(%esi),%esi
    return list->tail->prev;
     210:	8b 40 04             	mov    0x4(%eax),%eax
}
     213:	5b                   	pop    %ebx
     214:	5d                   	pop    %ebp
    return list->tail->prev;
     215:	8b 00                	mov    (%eax),%eax
}
     217:	c3                   	ret    
     218:	90                   	nop
     219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if ((pos < 0) && ((0 - pos) > list->len))
     220:	89 d3                	mov    %edx,%ebx
     222:	f7 db                	neg    %ebx
     224:	39 d9                	cmp    %ebx,%ecx
     226:	7c 18                	jl     240 <nodeAt+0x60>
    while (++pos != 0)
     228:	83 c2 01             	add    $0x1,%edx
    curNode = list->tail;
     22b:	8b 40 04             	mov    0x4(%eax),%eax
    while (++pos != 0)
     22e:	74 da                	je     20a <nodeAt+0x2a>
     230:	83 c2 01             	add    $0x1,%edx
      curNode = curNode->prev;
     233:	8b 00                	mov    (%eax),%eax
    while (++pos != 0)
     235:	75 f9                	jne    230 <nodeAt+0x50>
}
     237:	5b                   	pop    %ebx
     238:	5d                   	pop    %ebp
     239:	c3                   	ret    
     23a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return list->head->next;
     240:	8b 00                	mov    (%eax),%eax
     242:	8b 40 08             	mov    0x8(%eax),%eax
     245:	eb c3                	jmp    20a <nodeAt+0x2a>
     247:	89 f6                	mov    %esi,%esi
     249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <destroyNode>:

void destroyNode(struct LinkedList* list, struct Node* self) {
     250:	55                   	push   %ebp
     251:	89 e5                	mov    %esp,%ebp
     253:	56                   	push   %esi
     254:	53                   	push   %ebx
     255:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     258:	8b 75 08             	mov    0x8(%ebp),%esi
    self->prev->next = self->next;
    self->next->prev = self->prev;

    free(self->data);
     25b:	83 ec 0c             	sub    $0xc,%esp
    self->prev->next = self->next;
     25e:	8b 03                	mov    (%ebx),%eax
     260:	8b 53 08             	mov    0x8(%ebx),%edx
     263:	89 50 08             	mov    %edx,0x8(%eax)
    self->next->prev = self->prev;
     266:	8b 43 08             	mov    0x8(%ebx),%eax
     269:	8b 13                	mov    (%ebx),%edx
     26b:	89 10                	mov    %edx,(%eax)
    free(self->data);
     26d:	ff 73 04             	pushl  0x4(%ebx)
     270:	e8 1b 14 00 00       	call   1690 <free>
    free(self);
     275:	89 1c 24             	mov    %ebx,(%esp)
     278:	e8 13 14 00 00       	call   1690 <free>
    list->len--;
     27d:	83 6e 08 01          	subl   $0x1,0x8(%esi)
}
     281:	83 c4 10             	add    $0x10,%esp
     284:	8d 65 f8             	lea    -0x8(%ebp),%esp
     287:	5b                   	pop    %ebx
     288:	5e                   	pop    %esi
     289:	5d                   	pop    %ebp
     28a:	c3                   	ret    
     28b:	90                   	nop
     28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000290 <MakeLinkedList>:

LinkedList* MakeLinkedList() {
     290:	55                   	push   %ebp
     291:	89 e5                	mov    %esp,%ebp
     293:	56                   	push   %esi
     294:	53                   	push   %ebx
  struct LinkedList* list = malloc(sizeof(LinkedList));
     295:	83 ec 0c             	sub    $0xc,%esp
     298:	6a 0c                	push   $0xc
     29a:	e8 81 14 00 00       	call   1720 <malloc>
  struct Node* node = malloc(sizeof(Node));
     29f:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  struct LinkedList* list = malloc(sizeof(LinkedList));
     2a6:	89 c6                	mov    %eax,%esi
  struct Node* node = malloc(sizeof(Node));
     2a8:	e8 73 14 00 00       	call   1720 <malloc>
     2ad:	89 c3                	mov    %eax,%ebx
  node->prev = nullptr;
     2af:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->data = data;
     2b5:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  node->next = nullptr;
     2bc:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  struct Node* node = malloc(sizeof(Node));
     2c3:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     2ca:	e8 51 14 00 00       	call   1720 <malloc>
  node->data = data;
     2cf:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  Node* head = nullNode(nullptr);
  Node* tail = nullNode(nullptr);
  head->prev = nullptr;
  head->next = tail;
     2d6:	89 43 08             	mov    %eax,0x8(%ebx)
  head->prev = nullptr;
     2d9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  tail->prev = head;
     2df:	89 18                	mov    %ebx,(%eax)
  tail->next = nullptr;
     2e1:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)

  list->len = 0;
  list->head = head;
  list->tail = tail;
     2e8:	89 46 04             	mov    %eax,0x4(%esi)
  return list;
}
     2eb:	89 f0                	mov    %esi,%eax
  list->len = 0;
     2ed:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
  list->head = head;
     2f4:	89 1e                	mov    %ebx,(%esi)
}
     2f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
     2f9:	5b                   	pop    %ebx
     2fa:	5e                   	pop    %esi
     2fb:	5d                   	pop    %ebp
     2fc:	c3                   	ret    
     2fd:	8d 76 00             	lea    0x0(%esi),%esi

00000300 <insert>:

void insert(struct LinkedList* list, char* data, int pos) {
     300:	55                   	push   %ebp
     301:	89 e5                	mov    %esp,%ebp
     303:	57                   	push   %edi
     304:	56                   	push   %esi
     305:	53                   	push   %ebx
     306:	83 ec 0c             	sub    $0xc,%esp
  struct Node* atPos = nodeAt(list, pos);
     309:	ff 75 10             	pushl  0x10(%ebp)
     30c:	ff 75 08             	pushl  0x8(%ebp)
void insert(struct LinkedList* list, char* data, int pos) {
     30f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct Node* atPos = nodeAt(list, pos);
     312:	e8 c9 fe ff ff       	call   1e0 <nodeAt>
     317:	83 ec 04             	sub    $0x4,%esp
     31a:	89 c6                	mov    %eax,%esi
  char* newData = (char*)malloc(sizeof(char) * 1000);
     31c:	68 e8 03 00 00       	push   $0x3e8
     321:	e8 fa 13 00 00       	call   1720 <malloc>
     326:	8d 8b e7 03 00 00    	lea    0x3e7(%ebx),%ecx
     32c:	89 c7                	mov    %eax,%edi
     32e:	83 c4 10             	add    $0x10,%esp
     331:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(--n > 0 && (*s++ = *t++) != 0)
     338:	83 c3 01             	add    $0x1,%ebx
     33b:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     33f:	83 c0 01             	add    $0x1,%eax
     342:	84 d2                	test   %dl,%dl
     344:	88 50 ff             	mov    %dl,-0x1(%eax)
     347:	74 04                	je     34d <insert+0x4d>
     349:	39 d9                	cmp    %ebx,%ecx
     34b:	75 eb                	jne    338 <insert+0x38>
  newData = safestrcpy(newData, data, (sizeof(char) * 1000));
  struct Node* new = malloc(sizeof(Node));
     34d:	83 ec 0c             	sub    $0xc,%esp
  *s = 0;
     350:	c6 00 00             	movb   $0x0,(%eax)
  struct Node* new = malloc(sizeof(Node));
     353:	6a 0c                	push   $0xc
     355:	e8 c6 13 00 00       	call   1720 <malloc>

  new->data = newData;
     35a:	89 78 04             	mov    %edi,0x4(%eax)
  new->prev = atPos->prev;
     35d:	8b 16                	mov    (%esi),%edx
  new->next = atPos;
     35f:	89 70 08             	mov    %esi,0x8(%eax)
  new->prev = atPos->prev;
     362:	89 10                	mov    %edx,(%eax)
  new->prev->next = new;
     364:	89 42 08             	mov    %eax,0x8(%edx)
  atPos->prev = new;
     367:	89 06                	mov    %eax,(%esi)
  list->len++;
     369:	8b 45 08             	mov    0x8(%ebp),%eax
     36c:	83 40 08 01          	addl   $0x1,0x8(%eax)
}
     370:	8d 65 f4             	lea    -0xc(%ebp),%esp
     373:	5b                   	pop    %ebx
     374:	5e                   	pop    %esi
     375:	5f                   	pop    %edi
     376:	5d                   	pop    %ebp
     377:	c3                   	ret    
     378:	90                   	nop
     379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000380 <prepend>:

void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
     380:	55                   	push   %ebp
     381:	89 e5                	mov    %esp,%ebp
     383:	83 ec 0c             	sub    $0xc,%esp
     386:	6a 00                	push   $0x0
     388:	ff 75 0c             	pushl  0xc(%ebp)
     38b:	ff 75 08             	pushl  0x8(%ebp)
     38e:	e8 6d ff ff ff       	call   300 <insert>
     393:	83 c4 10             	add    $0x10,%esp
     396:	c9                   	leave  
     397:	c3                   	ret    
     398:	90                   	nop
     399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003a0 <append>:
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     3a0:	55                   	push   %ebp
     3a1:	89 e5                	mov    %esp,%ebp
     3a3:	83 ec 0c             	sub    $0xc,%esp
     3a6:	8b 45 08             	mov    0x8(%ebp),%eax
     3a9:	ff 70 08             	pushl  0x8(%eax)
     3ac:	ff 75 0c             	pushl  0xc(%ebp)
     3af:	50                   	push   %eax
     3b0:	e8 4b ff ff ff       	call   300 <insert>
     3b5:	83 c4 10             	add    $0x10,%esp
     3b8:	c9                   	leave  
     3b9:	c3                   	ret    
     3ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003c0 <destroyLinkedList>:

void destroyLinkedList(struct LinkedList* list) {
     3c0:	55                   	push   %ebp
     3c1:	89 e5                	mov    %esp,%ebp
     3c3:	56                   	push   %esi
     3c4:	53                   	push   %ebx
     3c5:	8b 75 08             	mov    0x8(%ebp),%esi
  struct Node* curNode = list->head;
     3c8:	8b 1e                	mov    (%esi),%ebx
  while (curNode != list->tail) {
     3ca:	8b 46 04             	mov    0x4(%esi),%eax
     3cd:	39 c3                	cmp    %eax,%ebx
     3cf:	74 29                	je     3fa <destroyLinkedList+0x3a>
     3d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
     3d8:	8b 5b 08             	mov    0x8(%ebx),%ebx
    free(curNode->prev->data);
     3db:	83 ec 0c             	sub    $0xc,%esp
     3de:	8b 03                	mov    (%ebx),%eax
     3e0:	ff 70 04             	pushl  0x4(%eax)
     3e3:	e8 a8 12 00 00       	call   1690 <free>
    free(curNode->prev);
     3e8:	58                   	pop    %eax
     3e9:	ff 33                	pushl  (%ebx)
     3eb:	e8 a0 12 00 00       	call   1690 <free>
  while (curNode != list->tail) {
     3f0:	8b 46 04             	mov    0x4(%esi),%eax
     3f3:	83 c4 10             	add    $0x10,%esp
     3f6:	39 d8                	cmp    %ebx,%eax
     3f8:	75 de                	jne    3d8 <destroyLinkedList+0x18>
  }
  free(curNode);
     3fa:	83 ec 0c             	sub    $0xc,%esp
     3fd:	50                   	push   %eax
     3fe:	e8 8d 12 00 00       	call   1690 <free>
  free(list);
     403:	89 75 08             	mov    %esi,0x8(%ebp)
     406:	83 c4 10             	add    $0x10,%esp
     409:	8d 65 f8             	lea    -0x8(%ebp),%esp
     40c:	5b                   	pop    %ebx
     40d:	5e                   	pop    %esi
     40e:	5d                   	pop    %ebp
  free(list);
     40f:	e9 7c 12 00 00       	jmp    1690 <free>
     414:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     41a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000420 <confirmation>:
#include "helpers.h"

int confirmation() {
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	53                   	push   %ebx
  // get response
  char buf[MAXLINESIZE];
  int nbuf = sizeof(buf);
  memset(buf, 0, nbuf);
     424:	8d 9d 10 fc ff ff    	lea    -0x3f0(%ebp),%ebx
int confirmation() {
     42a:	81 ec f8 03 00 00    	sub    $0x3f8,%esp
  memset(buf, 0, nbuf);
     430:	68 e8 03 00 00       	push   $0x3e8
     435:	6a 00                	push   $0x0
     437:	53                   	push   %ebx
     438:	e8 f3 0c 00 00       	call   1130 <memset>
  gets(buf, nbuf);
     43d:	58                   	pop    %eax
     43e:	5a                   	pop    %edx
     43f:	68 e8 03 00 00       	push   $0x3e8
     444:	53                   	push   %ebx
     445:	e8 46 0d 00 00       	call   1190 <gets>
  // determine output
  switch (buf[0]) {
     44a:	0f b6 85 10 fc ff ff 	movzbl -0x3f0(%ebp),%eax
     451:	83 c4 10             	add    $0x10,%esp
     454:	3c 59                	cmp    $0x59,%al
     456:	74 18                	je     470 <confirmation+0x50>
     458:	3c 79                	cmp    $0x79,%al
     45a:	74 14                	je     470 <confirmation+0x50>
  case 'Y':
  case 'y':
    return 0;
  default:
    return 1;
     45c:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
     461:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     464:	c9                   	leave  
     465:	c3                   	ret    
     466:	8d 76 00             	lea    0x0(%esi),%esi
     469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return 0;
     470:	31 c0                	xor    %eax,%eax
}
     472:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     475:	c9                   	leave  
     476:	c3                   	ret    
     477:	89 f6                	mov    %esi,%esi
     479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000480 <normalizeRange>:
    return 1;

  return 0;
}

int normalizeRange(File file, int* sp, int* ep) {
     480:	55                   	push   %ebp
     481:	89 e5                	mov    %esp,%ebp
     483:	53                   	push   %ebx
     484:	8b 4d 24             	mov    0x24(%ebp),%ecx
  int l = file.len;
     487:	8b 45 18             	mov    0x18(%ebp),%eax
int normalizeRange(File file, int* sp, int* ep) {
     48a:	8b 5d 20             	mov    0x20(%ebp),%ebx
  if (*ep > l) *ep = l;
     48d:	8b 11                	mov    (%ecx),%edx
     48f:	39 c2                	cmp    %eax,%edx
     491:	7e 45                	jle    4d8 <normalizeRange+0x58>
     493:	89 01                	mov    %eax,(%ecx)
     495:	89 c2                	mov    %eax,%edx
  else if (*ep < 1) *ep += l + 1;
  if (*ep < 1) *ep = 1;
     497:	85 d2                	test   %edx,%edx
     499:	7f 06                	jg     4a1 <normalizeRange+0x21>
     49b:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)

  if (*sp > l) *sp = l;
     4a1:	8b 13                	mov    (%ebx),%edx
     4a3:	39 c2                	cmp    %eax,%edx
     4a5:	7e 21                	jle    4c8 <normalizeRange+0x48>
     4a7:	89 03                	mov    %eax,(%ebx)
     4a9:	89 c2                	mov    %eax,%edx
  else if (*sp < 1) *sp += l + 1;
  if (*sp < 1) *sp = 1;
     4ab:	85 d2                	test   %edx,%edx
     4ad:	7f 0b                	jg     4ba <normalizeRange+0x3a>
     4af:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
     4b5:	ba 01 00 00 00       	mov    $0x1,%edx
  if ((*ep - *sp) < 0)
     4ba:	8b 01                	mov    (%ecx),%eax
    return 1;
  return 0;
}
     4bc:	5b                   	pop    %ebx
     4bd:	5d                   	pop    %ebp
  if ((*ep - *sp) < 0)
     4be:	29 d0                	sub    %edx,%eax
     4c0:	c1 e8 1f             	shr    $0x1f,%eax
}
     4c3:	c3                   	ret    
     4c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*sp < 1) *sp += l + 1;
     4c8:	85 d2                	test   %edx,%edx
     4ca:	7f ee                	jg     4ba <normalizeRange+0x3a>
     4cc:	8d 54 10 01          	lea    0x1(%eax,%edx,1),%edx
     4d0:	89 13                	mov    %edx,(%ebx)
     4d2:	eb d7                	jmp    4ab <normalizeRange+0x2b>
     4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*ep < 1) *ep += l + 1;
     4d8:	85 d2                	test   %edx,%edx
     4da:	7f c5                	jg     4a1 <normalizeRange+0x21>
     4dc:	8d 54 02 01          	lea    0x1(%edx,%eax,1),%edx
     4e0:	89 11                	mov    %edx,(%ecx)
     4e2:	eb b3                	jmp    497 <normalizeRange+0x17>
     4e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     4ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000004f0 <numLines>:

int numLines(int start, int end) {
     4f0:	55                   	push   %ebp
     4f1:	89 e5                	mov    %esp,%ebp
  return (end - start) + 1;
     4f3:	8b 45 0c             	mov    0xc(%ebp),%eax
     4f6:	2b 45 08             	sub    0x8(%ebp),%eax
}
     4f9:	5d                   	pop    %ebp
  return (end - start) + 1;
     4fa:	83 c0 01             	add    $0x1,%eax
}
     4fd:	c3                   	ret    
     4fe:	66 90                	xchg   %ax,%ax

00000500 <getLine>:
    append(file->lines, line);
    file->len++;
  }
}

int getLine(int fileptr, char line[]) {
     500:	55                   	push   %ebp
     501:	89 e5                	mov    %esp,%ebp
     503:	57                   	push   %edi
     504:	56                   	push   %esi
     505:	53                   	push   %ebx
  int len = strlen(line);
  memset(line, 0, len);
  char c[1];
  int i;
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     506:	31 ff                	xor    %edi,%edi
     508:	8d 75 e7             	lea    -0x19(%ebp),%esi
int getLine(int fileptr, char line[]) {
     50b:	83 ec 28             	sub    $0x28,%esp
     50e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int len = strlen(line);
     511:	53                   	push   %ebx
     512:	e8 e9 0b 00 00       	call   1100 <strlen>
  memset(line, 0, len);
     517:	83 c4 0c             	add    $0xc,%esp
     51a:	50                   	push   %eax
     51b:	6a 00                	push   $0x0
     51d:	53                   	push   %ebx
     51e:	e8 0d 0c 00 00       	call   1130 <memset>
     523:	83 c4 10             	add    $0x10,%esp
     526:	eb 1e                	jmp    546 <getLine+0x46>
     528:	90                   	nop
     529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (read(fileptr, c, 1) == 0) return strlen(line);
    if (*c == '\n') break;
     530:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     534:	3c 0a                	cmp    $0xa,%al
     536:	74 38                	je     570 <getLine+0x70>
    line[i] = *c;
     538:	88 04 3b             	mov    %al,(%ebx,%edi,1)
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     53b:	83 c7 01             	add    $0x1,%edi
     53e:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
     544:	74 42                	je     588 <getLine+0x88>
    if (read(fileptr, c, 1) == 0) return strlen(line);
     546:	83 ec 04             	sub    $0x4,%esp
     549:	6a 01                	push   $0x1
     54b:	56                   	push   %esi
     54c:	ff 75 08             	pushl  0x8(%ebp)
     54f:	e8 96 0d 00 00       	call   12ea <read>
     554:	83 c4 10             	add    $0x10,%esp
     557:	85 c0                	test   %eax,%eax
     559:	75 d5                	jne    530 <getLine+0x30>
     55b:	83 ec 0c             	sub    $0xc,%esp
     55e:	53                   	push   %ebx
     55f:	e8 9c 0b 00 00       	call   1100 <strlen>
     564:	83 c4 10             	add    $0x10,%esp
  }
  line[i + 1] = '\0';
  return 1;
}
     567:	8d 65 f4             	lea    -0xc(%ebp),%esp
     56a:	5b                   	pop    %ebx
     56b:	5e                   	pop    %esi
     56c:	5f                   	pop    %edi
     56d:	5d                   	pop    %ebp
     56e:	c3                   	ret    
     56f:	90                   	nop
     570:	8d 57 01             	lea    0x1(%edi),%edx
  line[i + 1] = '\0';
     573:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
     577:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
     57a:	b8 01 00 00 00       	mov    $0x1,%eax
}
     57f:	5b                   	pop    %ebx
     580:	5e                   	pop    %esi
     581:	5f                   	pop    %edi
     582:	5d                   	pop    %ebp
     583:	c3                   	ret    
     584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     588:	ba e8 03 00 00       	mov    $0x3e8,%edx
     58d:	eb e4                	jmp    573 <getLine+0x73>
     58f:	90                   	nop

00000590 <gatherLines>:
void gatherLines(File* file) {
     590:	55                   	push   %ebp
     591:	89 e5                	mov    %esp,%ebp
     593:	56                   	push   %esi
     594:	53                   	push   %ebx
     595:	8d b5 10 fc ff ff    	lea    -0x3f0(%ebp),%esi
     59b:	81 ec f0 03 00 00    	sub    $0x3f0,%esp
     5a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while (getLine(file->fd, line)) {
     5a4:	eb 21                	jmp    5c7 <gatherLines+0x37>
     5a6:	8d 76 00             	lea    0x0(%esi),%esi
     5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    append(file->lines, line);
     5b0:	8b 43 0c             	mov    0xc(%ebx),%eax
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     5b3:	83 ec 04             	sub    $0x4,%esp
     5b6:	ff 70 08             	pushl  0x8(%eax)
     5b9:	56                   	push   %esi
     5ba:	50                   	push   %eax
     5bb:	e8 40 fd ff ff       	call   300 <insert>
    file->len++;
     5c0:	83 43 10 01          	addl   $0x1,0x10(%ebx)
     5c4:	83 c4 10             	add    $0x10,%esp
  while (getLine(file->fd, line)) {
     5c7:	83 ec 08             	sub    $0x8,%esp
     5ca:	56                   	push   %esi
     5cb:	ff 73 04             	pushl  0x4(%ebx)
     5ce:	e8 2d ff ff ff       	call   500 <getLine>
     5d3:	83 c4 10             	add    $0x10,%esp
     5d6:	85 c0                	test   %eax,%eax
     5d8:	75 d6                	jne    5b0 <gatherLines+0x20>
}
     5da:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5dd:	5b                   	pop    %ebx
     5de:	5e                   	pop    %esi
     5df:	5d                   	pop    %ebp
     5e0:	c3                   	ret    
     5e1:	eb 0d                	jmp    5f0 <unline>
     5e3:	90                   	nop
     5e4:	90                   	nop
     5e5:	90                   	nop
     5e6:	90                   	nop
     5e7:	90                   	nop
     5e8:	90                   	nop
     5e9:	90                   	nop
     5ea:	90                   	nop
     5eb:	90                   	nop
     5ec:	90                   	nop
     5ed:	90                   	nop
     5ee:	90                   	nop
     5ef:	90                   	nop

000005f0 <unline>:
  int end = find(args, delimiter);
  substr(dest, args, 0, end);
  substr(args, args, end + 1, (int) strlen(args));
}

void unline(char* str) {
     5f0:	55                   	push   %ebp
     5f1:	89 e5                	mov    %esp,%ebp
     5f3:	53                   	push   %ebx
     5f4:	83 ec 10             	sub    $0x10,%esp
     5f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str) - 1;
     5fa:	53                   	push   %ebx
     5fb:	e8 00 0b 00 00       	call   1100 <strlen>
     600:	8d 50 ff             	lea    -0x1(%eax),%edx
  for (; len > 0; len--) {
     603:	83 c4 10             	add    $0x10,%esp
     606:	85 d2                	test   %edx,%edx
     608:	7e 36                	jle    640 <unline+0x50>
    char c = str[len];
    if (c == '\n')
     60a:	80 7c 03 ff 0a       	cmpb   $0xa,-0x1(%ebx,%eax,1)
     60f:	74 2f                	je     640 <unline+0x50>
     611:	8d 44 03 fe          	lea    -0x2(%ebx,%eax,1),%eax
     615:	eb 12                	jmp    629 <unline+0x39>
     617:	89 f6                	mov    %esi,%esi
     619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     620:	83 e8 01             	sub    $0x1,%eax
     623:	80 78 01 0a          	cmpb   $0xa,0x1(%eax)
     627:	74 06                	je     62f <unline+0x3f>
  for (; len > 0; len--) {
     629:	39 c3                	cmp    %eax,%ebx
     62b:	89 c2                	mov    %eax,%edx
     62d:	75 f1                	jne    620 <unline+0x30>
      break;
  }
  str[len] = '\0';
     62f:	c6 02 00             	movb   $0x0,(%edx)
}
     632:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     635:	c9                   	leave  
     636:	c3                   	ret    
     637:	89 f6                	mov    %esi,%esi
     639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     640:	01 da                	add    %ebx,%edx
  str[len] = '\0';
     642:	c6 02 00             	movb   $0x0,(%edx)
}
     645:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     648:	c9                   	leave  
     649:	c3                   	ret    
     64a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000650 <find>:


// str ops
int find(char* str, char c) {
     650:	55                   	push   %ebp
     651:	89 e5                	mov    %esp,%ebp
     653:	57                   	push   %edi
     654:	56                   	push   %esi
     655:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     656:	31 db                	xor    %ebx,%ebx
int find(char* str, char c) {
     658:	83 ec 0c             	sub    $0xc,%esp
     65b:	8b 75 08             	mov    0x8(%ebp),%esi
     65e:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
  for (int i = 0; i < strlen(str); i++)
     662:	eb 0e                	jmp    672 <find+0x22>
     664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     668:	89 f8                	mov    %edi,%eax
     66a:	38 04 1e             	cmp    %al,(%esi,%ebx,1)
     66d:	74 18                	je     687 <find+0x37>
  for (int i = 0; i < strlen(str); i++)
     66f:	83 c3 01             	add    $0x1,%ebx
     672:	83 ec 0c             	sub    $0xc,%esp
     675:	56                   	push   %esi
     676:	e8 85 0a 00 00       	call   1100 <strlen>
     67b:	83 c4 10             	add    $0x10,%esp
     67e:	39 d8                	cmp    %ebx,%eax
     680:	77 e6                	ja     668 <find+0x18>
  return -1;
     682:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
     687:	8d 65 f4             	lea    -0xc(%ebp),%esp
     68a:	89 d8                	mov    %ebx,%eax
     68c:	5b                   	pop    %ebx
     68d:	5e                   	pop    %esi
     68e:	5f                   	pop    %edi
     68f:	5d                   	pop    %ebp
     690:	c3                   	ret    
     691:	eb 0d                	jmp    6a0 <substr>
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

000006a0 <substr>:

void substr(char* dest, char* str, int start, int end) {
     6a0:	55                   	push   %ebp
     6a1:	89 e5                	mov    %esp,%ebp
     6a3:	57                   	push   %edi
     6a4:	56                   	push   %esi
     6a5:	53                   	push   %ebx
     6a6:	83 ec 18             	sub    $0x18,%esp
     6a9:	8b 7d 14             	mov    0x14(%ebp),%edi
  int len = strlen(str);
     6ac:	ff 75 0c             	pushl  0xc(%ebp)
void substr(char* dest, char* str, int start, int end) {
     6af:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6b2:	8b 75 08             	mov    0x8(%ebp),%esi
  int len = strlen(str);
     6b5:	e8 46 0a 00 00       	call   1100 <strlen>
     6ba:	83 c4 10             	add    $0x10,%esp
     6bd:	39 f8                	cmp    %edi,%eax
     6bf:	0f 4e f8             	cmovle %eax,%edi
  if (end > len) end = len;
  int s = 0, i = start;
  while (i < end)
     6c2:	39 df                	cmp    %ebx,%edi
     6c4:	7e 1c                	jle    6e2 <substr+0x42>
     6c6:	8b 45 0c             	mov    0xc(%ebp),%eax
     6c9:	29 df                	sub    %ebx,%edi
  int s = 0, i = start;
     6cb:	31 d2                	xor    %edx,%edx
     6cd:	01 c3                	add    %eax,%ebx
     6cf:	90                   	nop
    dest[s++] = str[i++];
     6d0:	83 c2 01             	add    $0x1,%edx
     6d3:	0f b6 44 13 ff       	movzbl -0x1(%ebx,%edx,1),%eax
  while (i < end)
     6d8:	39 fa                	cmp    %edi,%edx
    dest[s++] = str[i++];
     6da:	88 44 16 ff          	mov    %al,-0x1(%esi,%edx,1)
  while (i < end)
     6de:	75 f0                	jne    6d0 <substr+0x30>
     6e0:	01 d6                	add    %edx,%esi
  dest[s] = '\0';
     6e2:	c6 06 00             	movb   $0x0,(%esi)
}
     6e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6e8:	5b                   	pop    %ebx
     6e9:	5e                   	pop    %esi
     6ea:	5f                   	pop    %edi
     6eb:	5d                   	pop    %ebp
     6ec:	c3                   	ret    
     6ed:	8d 76 00             	lea    0x0(%esi),%esi

000006f0 <getArg>:
void getArg(char* dest, char* args, char delimiter) {
     6f0:	55                   	push   %ebp
     6f1:	89 e5                	mov    %esp,%ebp
     6f3:	57                   	push   %edi
     6f4:	56                   	push   %esi
     6f5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     6f6:	31 db                	xor    %ebx,%ebx
void getArg(char* dest, char* args, char delimiter) {
     6f8:	83 ec 1c             	sub    $0x1c,%esp
     6fb:	8b 75 0c             	mov    0xc(%ebp),%esi
     6fe:	0f b6 7d 10          	movzbl 0x10(%ebp),%edi
     702:	eb 10                	jmp    714 <getArg+0x24>
     704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     708:	89 f8                	mov    %edi,%eax
     70a:	3a 04 1e             	cmp    (%esi,%ebx,1),%al
     70d:	8d 53 01             	lea    0x1(%ebx),%edx
     710:	74 19                	je     72b <getArg+0x3b>
     712:	89 d3                	mov    %edx,%ebx
  for (int i = 0; i < strlen(str); i++)
     714:	83 ec 0c             	sub    $0xc,%esp
     717:	56                   	push   %esi
     718:	e8 e3 09 00 00       	call   1100 <strlen>
     71d:	83 c4 10             	add    $0x10,%esp
     720:	39 c3                	cmp    %eax,%ebx
     722:	72 e4                	jb     708 <getArg+0x18>
     724:	31 d2                	xor    %edx,%edx
  return -1;
     726:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  substr(dest, args, 0, end);
     72b:	53                   	push   %ebx
     72c:	6a 00                	push   $0x0
     72e:	56                   	push   %esi
     72f:	ff 75 08             	pushl  0x8(%ebp)
     732:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     735:	e8 66 ff ff ff       	call   6a0 <substr>
  substr(args, args, end + 1, (int) strlen(args));
     73a:	89 34 24             	mov    %esi,(%esp)
     73d:	e8 be 09 00 00       	call   1100 <strlen>
     742:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     745:	50                   	push   %eax
     746:	52                   	push   %edx
     747:	56                   	push   %esi
     748:	56                   	push   %esi
     749:	e8 52 ff ff ff       	call   6a0 <substr>
}
     74e:	83 c4 20             	add    $0x20,%esp
     751:	8d 65 f4             	lea    -0xc(%ebp),%esp
     754:	5b                   	pop    %ebx
     755:	5e                   	pop    %esi
     756:	5f                   	pop    %edi
     757:	5d                   	pop    %ebp
     758:	c3                   	ret    
     759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000760 <collectRange>:
int collectRange(char* args, int* startptr, int* endptr) {
     760:	55                   	push   %ebp
     761:	89 e5                	mov    %esp,%ebp
     763:	57                   	push   %edi
     764:	56                   	push   %esi
     765:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     766:	31 f6                	xor    %esi,%esi
int collectRange(char* args, int* startptr, int* endptr) {
     768:	83 ec 2c             	sub    $0x2c,%esp
     76b:	8b 5d 08             	mov    0x8(%ebp),%ebx
     76e:	eb 09                	jmp    779 <collectRange+0x19>
    if (str[i] == c) return i;
     770:	80 3c 33 3a          	cmpb   $0x3a,(%ebx,%esi,1)
     774:	74 42                	je     7b8 <collectRange+0x58>
  for (int i = 0; i < strlen(str); i++)
     776:	83 c6 01             	add    $0x1,%esi
     779:	83 ec 0c             	sub    $0xc,%esp
     77c:	53                   	push   %ebx
     77d:	e8 7e 09 00 00       	call   1100 <strlen>
     782:	83 c4 10             	add    $0x10,%esp
     785:	39 c6                	cmp    %eax,%esi
     787:	72 e7                	jb     770 <collectRange+0x10>
    if (args[0] == '-') {
     789:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     78c:	0f 84 d6 00 00 00    	je     868 <collectRange+0x108>
      *startptr = atoi(args);
     792:	83 ec 0c             	sub    $0xc,%esp
     795:	53                   	push   %ebx
     796:	e8 c5 0a 00 00       	call   1260 <atoi>
     79b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     79e:	83 c4 10             	add    $0x10,%esp
     7a1:	89 01                	mov    %eax,(%ecx)
    *endptr = *startptr;
     7a3:	8b 4d 10             	mov    0x10(%ebp),%ecx
     7a6:	89 01                	mov    %eax,(%ecx)
    return 0;
     7a8:	31 c0                	xor    %eax,%eax
}
     7aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7ad:	5b                   	pop    %ebx
     7ae:	5e                   	pop    %esi
     7af:	5f                   	pop    %edi
     7b0:	5d                   	pop    %ebp
     7b1:	c3                   	ret    
     7b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  getArg(startstr, args, ':');
     7b8:	8d 75 de             	lea    -0x22(%ebp),%esi
     7bb:	83 ec 04             	sub    $0x4,%esp
     7be:	6a 3a                	push   $0x3a
     7c0:	53                   	push   %ebx
     7c1:	56                   	push   %esi
     7c2:	e8 29 ff ff ff       	call   6f0 <getArg>
  if (startstr[0] == '-') {
     7c7:	83 c4 10             	add    $0x10,%esp
     7ca:	80 7d de 2d          	cmpb   $0x2d,-0x22(%ebp)
     7ce:	0f 84 3c 01 00 00    	je     910 <collectRange+0x1b0>
  int negStartFlag = 0, negEndFlag = 0;
     7d4:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     7db:	31 ff                	xor    %edi,%edi
  if (endstr[0] == '-') {
     7dd:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     7e0:	0f 84 0a 01 00 00    	je     8f0 <collectRange+0x190>
  if (strcmp(startstr, "\0") == 0) *startptr = 1;
     7e6:	83 ec 08             	sub    $0x8,%esp
     7e9:	68 18 18 00 00       	push   $0x1818
     7ee:	56                   	push   %esi
     7ef:	e8 bc 08 00 00       	call   10b0 <strcmp>
     7f4:	83 c4 10             	add    $0x10,%esp
     7f7:	85 c0                	test   %eax,%eax
     7f9:	0f 85 d1 00 00 00    	jne    8d0 <collectRange+0x170>
     7ff:	8b 45 0c             	mov    0xc(%ebp),%eax
     802:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  if (strcmp(endstr, "\0") == 0) *endptr = -1;
     808:	83 ec 08             	sub    $0x8,%esp
     80b:	68 18 18 00 00       	push   $0x1818
     810:	53                   	push   %ebx
     811:	e8 9a 08 00 00       	call   10b0 <strcmp>
     816:	83 c4 10             	add    $0x10,%esp
     819:	85 c0                	test   %eax,%eax
     81b:	0f 85 97 00 00 00    	jne    8b8 <collectRange+0x158>
     821:	8b 45 10             	mov    0x10(%ebp),%eax
     824:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  if (negStartFlag) *startptr = 0 - *startptr;
     82a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     82d:	85 c0                	test   %eax,%eax
     82f:	74 05                	je     836 <collectRange+0xd6>
     831:	8b 45 0c             	mov    0xc(%ebp),%eax
     834:	f7 18                	negl   (%eax)
  if (negEndFlag) *endptr = 0 - *endptr;
     836:	85 ff                	test   %edi,%edi
     838:	74 05                	je     83f <collectRange+0xdf>
     83a:	8b 45 10             	mov    0x10(%ebp),%eax
     83d:	f7 18                	negl   (%eax)
  if (((*startptr > 0 && *endptr > 0) || 
     83f:	8b 45 0c             	mov    0xc(%ebp),%eax
     842:	8b 00                	mov    (%eax),%eax
     844:	83 f8 00             	cmp    $0x0,%eax
     847:	7e 4f                	jle    898 <collectRange+0x138>
     849:	8b 55 10             	mov    0x10(%ebp),%edx
     84c:	8b 12                	mov    (%edx),%edx
     84e:	85 d2                	test   %edx,%edx
     850:	7e 55                	jle    8a7 <collectRange+0x147>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     852:	39 d0                	cmp    %edx,%eax
     854:	0f 9f c0             	setg   %al
}
     857:	8d 65 f4             	lea    -0xc(%ebp),%esp
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     85a:	0f b6 c0             	movzbl %al,%eax
}
     85d:	5b                   	pop    %ebx
     85e:	5e                   	pop    %esi
     85f:	5f                   	pop    %edi
     860:	5d                   	pop    %ebp
     861:	c3                   	ret    
     862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      substr(args, args, 1, strlen(args));
     868:	83 ec 0c             	sub    $0xc,%esp
     86b:	53                   	push   %ebx
     86c:	e8 8f 08 00 00       	call   1100 <strlen>
     871:	50                   	push   %eax
     872:	6a 01                	push   $0x1
     874:	53                   	push   %ebx
     875:	53                   	push   %ebx
     876:	e8 25 fe ff ff       	call   6a0 <substr>
      *startptr = 0 - atoi(args);
     87b:	83 c4 14             	add    $0x14,%esp
     87e:	53                   	push   %ebx
     87f:	e8 dc 09 00 00       	call   1260 <atoi>
     884:	8b 7d 0c             	mov    0xc(%ebp),%edi
     887:	f7 d8                	neg    %eax
     889:	83 c4 10             	add    $0x10,%esp
     88c:	89 07                	mov    %eax,(%edi)
     88e:	e9 10 ff ff ff       	jmp    7a3 <collectRange+0x43>
     893:	90                   	nop
     894:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (((*startptr > 0 && *endptr > 0) || 
     898:	0f 84 0c ff ff ff    	je     7aa <collectRange+0x4a>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     89e:	8b 7d 10             	mov    0x10(%ebp),%edi
     8a1:	8b 17                	mov    (%edi),%edx
     8a3:	85 d2                	test   %edx,%edx
     8a5:	78 ab                	js     852 <collectRange+0xf2>
}
     8a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
     8aa:	31 c0                	xor    %eax,%eax
}
     8ac:	5b                   	pop    %ebx
     8ad:	5e                   	pop    %esi
     8ae:	5f                   	pop    %edi
     8af:	5d                   	pop    %ebp
     8b0:	c3                   	ret    
     8b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else *endptr = atoi(endstr);
     8b8:	83 ec 0c             	sub    $0xc,%esp
     8bb:	53                   	push   %ebx
     8bc:	e8 9f 09 00 00       	call   1260 <atoi>
     8c1:	8b 55 10             	mov    0x10(%ebp),%edx
     8c4:	83 c4 10             	add    $0x10,%esp
     8c7:	89 02                	mov    %eax,(%edx)
     8c9:	e9 5c ff ff ff       	jmp    82a <collectRange+0xca>
     8ce:	66 90                	xchg   %ax,%ax
  else *startptr = atoi(startstr);
     8d0:	83 ec 0c             	sub    $0xc,%esp
     8d3:	56                   	push   %esi
     8d4:	e8 87 09 00 00       	call   1260 <atoi>
     8d9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     8dc:	83 c4 10             	add    $0x10,%esp
     8df:	89 01                	mov    %eax,(%ecx)
     8e1:	e9 22 ff ff ff       	jmp    808 <collectRange+0xa8>
     8e6:	8d 76 00             	lea    0x0(%esi),%esi
     8e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    substr(endstr, endstr, 1, strlen(endstr));
     8f0:	83 ec 0c             	sub    $0xc,%esp
    negEndFlag = 1;
     8f3:	bf 01 00 00 00       	mov    $0x1,%edi
    substr(endstr, endstr, 1, strlen(endstr));
     8f8:	53                   	push   %ebx
     8f9:	e8 02 08 00 00       	call   1100 <strlen>
     8fe:	50                   	push   %eax
     8ff:	6a 01                	push   $0x1
     901:	53                   	push   %ebx
     902:	53                   	push   %ebx
     903:	e8 98 fd ff ff       	call   6a0 <substr>
     908:	83 c4 20             	add    $0x20,%esp
     90b:	e9 d6 fe ff ff       	jmp    7e6 <collectRange+0x86>
    substr(startstr, startstr, 1, strlen(startstr));
     910:	83 ec 0c             	sub    $0xc,%esp
     913:	56                   	push   %esi
     914:	e8 e7 07 00 00       	call   1100 <strlen>
     919:	50                   	push   %eax
     91a:	6a 01                	push   $0x1
     91c:	56                   	push   %esi
     91d:	56                   	push   %esi
     91e:	e8 7d fd ff ff       	call   6a0 <substr>
     923:	83 c4 20             	add    $0x20,%esp
    negStartFlag = 1;
     926:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
     92d:	e9 a9 fe ff ff       	jmp    7db <collectRange+0x7b>
     932:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000940 <negatoi>:


// standard str helps
int negatoi(char* str) {
     940:	55                   	push   %ebp
     941:	89 e5                	mov    %esp,%ebp
     943:	53                   	push   %ebx
     944:	83 ec 04             	sub    $0x4,%esp
     947:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (str[0] == '-') {
     94a:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     94d:	74 11                	je     960 <negatoi+0x20>
    substr(str, str, 1, strlen(str));
    return 0 - atoi(str);
  }
  return atoi(str);
}
     94f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     952:	c9                   	leave  
  return atoi(str);
     953:	e9 08 09 00 00       	jmp    1260 <atoi>
     958:	90                   	nop
     959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    substr(str, str, 1, strlen(str));
     960:	83 ec 0c             	sub    $0xc,%esp
     963:	53                   	push   %ebx
     964:	e8 97 07 00 00       	call   1100 <strlen>
     969:	50                   	push   %eax
     96a:	6a 01                	push   $0x1
     96c:	53                   	push   %ebx
     96d:	53                   	push   %ebx
     96e:	e8 2d fd ff ff       	call   6a0 <substr>
    return 0 - atoi(str);
     973:	83 c4 14             	add    $0x14,%esp
     976:	53                   	push   %ebx
     977:	e8 e4 08 00 00       	call   1260 <atoi>
     97c:	83 c4 10             	add    $0x10,%esp
     97f:	f7 d8                	neg    %eax
}
     981:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     984:	c9                   	leave  
     985:	c3                   	ret    
     986:	8d 76 00             	lea    0x0(%esi),%esi
     989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000990 <toUpper>:

void toUpper(char* str) {
     990:	55                   	push   %ebp
     991:	89 e5                	mov    %esp,%ebp
     993:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     996:	0f b6 02             	movzbl (%edx),%eax
     999:	84 c0                	test   %al,%al
     99b:	74 1a                	je     9b7 <toUpper+0x27>
     99d:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'z' && c >= 'a')
     9a0:	8d 48 9f             	lea    -0x61(%eax),%ecx
     9a3:	80 f9 19             	cmp    $0x19,%cl
     9a6:	77 05                	ja     9ad <toUpper+0x1d>
      str[i] += ('Z' - 'z');
     9a8:	83 e8 20             	sub    $0x20,%eax
     9ab:	88 02                	mov    %al,(%edx)
     9ad:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     9b0:	0f b6 02             	movzbl (%edx),%eax
     9b3:	84 c0                	test   %al,%al
     9b5:	75 e9                	jne    9a0 <toUpper+0x10>
    i++;  
  }
}
     9b7:	5d                   	pop    %ebp
     9b8:	c3                   	ret    
     9b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000009c0 <toLower>:

void toLower(char* str) {
     9c0:	55                   	push   %ebp
     9c1:	89 e5                	mov    %esp,%ebp
     9c3:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     9c6:	0f b6 02             	movzbl (%edx),%eax
     9c9:	84 c0                	test   %al,%al
     9cb:	74 1a                	je     9e7 <toLower+0x27>
     9cd:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'Z' && c >= 'A')
     9d0:	8d 48 bf             	lea    -0x41(%eax),%ecx
     9d3:	80 f9 19             	cmp    $0x19,%cl
     9d6:	77 05                	ja     9dd <toLower+0x1d>
      str[i] -= ('Z' - 'z');
     9d8:	83 c0 20             	add    $0x20,%eax
     9db:	88 02                	mov    %al,(%edx)
     9dd:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     9e0:	0f b6 02             	movzbl (%edx),%eax
     9e3:	84 c0                	test   %al,%al
     9e5:	75 e9                	jne    9d0 <toLower+0x10>
    i++;  
  }
}
     9e7:	5d                   	pop    %ebp
     9e8:	c3                   	ret    
     9e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000009f0 <lineAt>:

// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
     9f0:	55                   	push   %ebp
     9f1:	89 e5                	mov    %esp,%ebp
  return nodeAt(list, pos-1);
     9f3:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
}
     9f7:	5d                   	pop    %ebp
  return nodeAt(list, pos-1);
     9f8:	e9 e3 f7 ff ff       	jmp    1e0 <nodeAt>
     9fd:	8d 76 00             	lea    0x0(%esi),%esi

00000a00 <printl>:

void printl(int lineNum, char* line) {
     a00:	55                   	push   %ebp
     a01:	89 e5                	mov    %esp,%ebp
     a03:	83 ec 08             	sub    $0x8,%esp
     a06:	8b 45 08             	mov    0x8(%ebp),%eax
  if (lineNum < 10)
     a09:	83 f8 09             	cmp    $0x9,%eax
     a0c:	7e 3a                	jle    a48 <printl+0x48>
    fprintf(2, "%d  : %s\n", lineNum, line);
  else if (lineNum < 100)
     a0e:	83 f8 63             	cmp    $0x63,%eax
     a11:	7e 1d                	jle    a30 <printl+0x30>
    fprintf(2, "%d : %s\n", lineNum, line);
  else
    fprintf(2, "%d: %s\n", lineNum, line);
     a13:	ff 75 0c             	pushl  0xc(%ebp)
     a16:	50                   	push   %eax
     a17:	68 2d 18 00 00       	push   $0x182d
     a1c:	6a 02                	push   $0x2
     a1e:	e8 2d 0c 00 00       	call   1650 <fprintf>
     a23:	83 c4 10             	add    $0x10,%esp
     a26:	c9                   	leave  
     a27:	c3                   	ret    
     a28:	90                   	nop
     a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "%d : %s\n", lineNum, line);
     a30:	ff 75 0c             	pushl  0xc(%ebp)
     a33:	50                   	push   %eax
     a34:	68 24 18 00 00       	push   $0x1824
     a39:	6a 02                	push   $0x2
     a3b:	e8 10 0c 00 00       	call   1650 <fprintf>
     a40:	83 c4 10             	add    $0x10,%esp
     a43:	c9                   	leave  
     a44:	c3                   	ret    
     a45:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "%d  : %s\n", lineNum, line);
     a48:	ff 75 0c             	pushl  0xc(%ebp)
     a4b:	50                   	push   %eax
     a4c:	68 1a 18 00 00       	push   $0x181a
     a51:	6a 02                	push   $0x2
     a53:	e8 f8 0b 00 00       	call   1650 <fprintf>
     a58:	83 c4 10             	add    $0x10,%esp
     a5b:	c9                   	leave  
     a5c:	c3                   	ret    
     a5d:	8d 76 00             	lea    0x0(%esi),%esi

00000a60 <forward>:
void forward(struct File file){
     a60:	55                   	push   %ebp
     a61:	89 e5                	mov    %esp,%ebp
  printf("forward    \r");
     a63:	c7 45 08 4f 18 00 00 	movl   $0x184f,0x8(%ebp)
}
     a6a:	5d                   	pop    %ebp
  printf("forward    \r");
     a6b:	e9 00 0c 00 00       	jmp    1670 <printf>

00000a70 <fastforward>:
void fastforward(struct File file){
     a70:	55                   	push   %ebp
     a71:	89 e5                	mov    %esp,%ebp
  printf("fastforward\r");
     a73:	c7 45 08 5c 18 00 00 	movl   $0x185c,0x8(%ebp)
}
     a7a:	5d                   	pop    %ebp
  printf("fastforward\r");
     a7b:	e9 f0 0b 00 00       	jmp    1670 <printf>

00000a80 <back>:
void back(struct File file){
     a80:	55                   	push   %ebp
     a81:	89 e5                	mov    %esp,%ebp
  printf("back       \r");
     a83:	c7 45 08 69 18 00 00 	movl   $0x1869,0x8(%ebp)
}
     a8a:	5d                   	pop    %ebp
  printf("back       \r");
     a8b:	e9 e0 0b 00 00       	jmp    1670 <printf>

00000a90 <scroll>:
void scroll(struct File file){
     a90:	55                   	push   %ebp
     a91:	89 e5                	mov    %esp,%ebp
  printf("scroll     \r");
     a93:	c7 45 08 76 18 00 00 	movl   $0x1876,0x8(%ebp)
}
     a9a:	5d                   	pop    %ebp
  printf("scroll     \r");
     a9b:	e9 d0 0b 00 00       	jmp    1670 <printf>

00000aa0 <line>:
void line(struct File file){
     aa0:	55                   	push   %ebp
     aa1:	89 e5                	mov    %esp,%ebp
  printf("line       \r");
     aa3:	c7 45 08 83 18 00 00 	movl   $0x1883,0x8(%ebp)
}
     aaa:	5d                   	pop    %ebp
  printf("line       \r");
     aab:	e9 c0 0b 00 00       	jmp    1670 <printf>

00000ab0 <end>:


// old commands
void end(struct File* file, char* args) {
     ab0:	55                   	push   %ebp
     ab1:	89 e5                	mov    %esp,%ebp
     ab3:	53                   	push   %ebx
     ab4:	83 ec 08             	sub    $0x8,%esp
     ab7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  file->edited = 1;
  char* line = args;
  append(file->lines, line);
     aba:	8b 43 0c             	mov    0xc(%ebx),%eax
  file->edited = 1;
     abd:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
     ac4:	ff 70 08             	pushl  0x8(%eax)
     ac7:	ff 75 0c             	pushl  0xc(%ebp)
     aca:	50                   	push   %eax
     acb:	e8 30 f8 ff ff       	call   300 <insert>
  file->len++;
     ad0:	83 43 10 01          	addl   $0x1,0x10(%ebx)
}
     ad4:	83 c4 10             	add    $0x10,%esp
     ad7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ada:	c9                   	leave  
     adb:	c3                   	ret    
     adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ae0 <add>:

void add(struct File* file, char* args) {
     ae0:	55                   	push   %ebp
     ae1:	89 e5                	mov    %esp,%ebp
     ae3:	57                   	push   %edi
     ae4:	56                   	push   %esi
     ae5:	53                   	push   %ebx
     ae6:	83 ec 28             	sub    $0x28,%esp
     ae9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     aec:	8b 75 0c             	mov    0xc(%ebp),%esi
  file->edited = 1;
     aef:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
  if (strlen(args) < 1) {
     af6:	56                   	push   %esi
     af7:	e8 04 06 00 00       	call   1100 <strlen>
     afc:	83 c4 10             	add    $0x10,%esp
     aff:	85 c0                	test   %eax,%eax
     b01:	74 3d                	je     b40 <add+0x60>
    fprintf(2, "you need to give a line number to insert before\n");
    return;
  }
  char lineStr[10];
  getArg(lineStr, args, ' ');
     b03:	8d 7d de             	lea    -0x22(%ebp),%edi
     b06:	83 ec 04             	sub    $0x4,%esp
     b09:	6a 20                	push   $0x20
     b0b:	56                   	push   %esi
     b0c:	57                   	push   %edi
     b0d:	e8 de fb ff ff       	call   6f0 <getArg>
  char* line = args;

  int lineNum = negatoi(lineStr);
     b12:	89 3c 24             	mov    %edi,(%esp)
     b15:	e8 26 fe ff ff       	call   940 <negatoi>
  // 1-based to 0-based insert
  insert(file->lines, line, lineNum - 1);
     b1a:	83 c4 0c             	add    $0xc,%esp
     b1d:	83 e8 01             	sub    $0x1,%eax
     b20:	50                   	push   %eax
     b21:	56                   	push   %esi
     b22:	ff 73 0c             	pushl  0xc(%ebx)
     b25:	e8 d6 f7 ff ff       	call   300 <insert>
  file->len++;
     b2a:	83 43 10 01          	addl   $0x1,0x10(%ebx)
     b2e:	83 c4 10             	add    $0x10,%esp
}
     b31:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b34:	5b                   	pop    %ebx
     b35:	5e                   	pop    %esi
     b36:	5f                   	pop    %edi
     b37:	5d                   	pop    %ebp
     b38:	c3                   	ret    
     b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "you need to give a line number to insert before\n");
     b40:	83 ec 08             	sub    $0x8,%esp
     b43:	68 a4 19 00 00       	push   $0x19a4
     b48:	6a 02                	push   $0x2
     b4a:	e8 01 0b 00 00       	call   1650 <fprintf>
    return;
     b4f:	83 c4 10             	add    $0x10,%esp
}
     b52:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b55:	5b                   	pop    %ebx
     b56:	5e                   	pop    %esi
     b57:	5f                   	pop    %edi
     b58:	5d                   	pop    %ebp
     b59:	c3                   	ret    
     b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000b60 <drop>:

void drop(struct File* file, char* args) {
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
     b63:	57                   	push   %edi
     b64:	56                   	push   %esi
     b65:	53                   	push   %ebx
     b66:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
     b69:	ff 75 0c             	pushl  0xc(%ebp)
void drop(struct File* file, char* args) {
     b6c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (strlen(args) < 1) {
     b6f:	e8 8c 05 00 00       	call   1100 <strlen>
     b74:	83 c4 10             	add    $0x10,%esp
     b77:	85 c0                	test   %eax,%eax
     b79:	0f 84 09 01 00 00    	je     c88 <drop+0x128>
    fprintf(2, "you need to give a range to drop\n");
    return;
  }

  int start, end;
  if (collectRange(args, &start, &end) == 1) {
     b7f:	8d 75 e4             	lea    -0x1c(%ebp),%esi
     b82:	8d 7d e0             	lea    -0x20(%ebp),%edi
     b85:	83 ec 04             	sub    $0x4,%esp
     b88:	56                   	push   %esi
     b89:	57                   	push   %edi
     b8a:	ff 75 0c             	pushl  0xc(%ebp)
     b8d:	e8 ce fb ff ff       	call   760 <collectRange>
     b92:	83 c4 10             	add    $0x10,%esp
     b95:	83 f8 01             	cmp    $0x1,%eax
     b98:	0f 84 0a 01 00 00    	je     ca8 <drop+0x148>
    fprintf(2, "error: start index is larger than end index\n");
    return;
  }
  if (normalizeRange(*file, &start, &end) == 1) {
     b9e:	56                   	push   %esi
     b9f:	57                   	push   %edi
     ba0:	ff 73 14             	pushl  0x14(%ebx)
     ba3:	ff 73 10             	pushl  0x10(%ebx)
     ba6:	ff 73 0c             	pushl  0xc(%ebx)
     ba9:	ff 73 08             	pushl  0x8(%ebx)
     bac:	ff 73 04             	pushl  0x4(%ebx)
     baf:	ff 33                	pushl  (%ebx)
     bb1:	e8 ca f8 ff ff       	call   480 <normalizeRange>
     bb6:	83 c4 20             	add    $0x20,%esp
     bb9:	83 f8 01             	cmp    $0x1,%eax
     bbc:	0f 84 1e 01 00 00    	je     ce0 <drop+0x180>
    fprintf(2, "error: bad input range. make sure start < end\n");
    return;
  }
  int numl = numLines(start, end);
     bc2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     bc5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return (end - start) + 1;
     bc8:	89 d6                	mov    %edx,%esi
     bca:	29 c6                	sub    %eax,%esi
     bcc:	8d 7e 01             	lea    0x1(%esi),%edi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
     bcf:	83 ff 01             	cmp    $0x1,%edi
     bd2:	89 7d d4             	mov    %edi,-0x2c(%ebp)
     bd5:	0f 84 ed 00 00 00    	je     cc8 <drop+0x168>
  else fprintf(2, "Drop %d lines [%d:%d] (y/n)? ", numl, start, end);
     bdb:	83 ec 0c             	sub    $0xc,%esp
     bde:	52                   	push   %edx
     bdf:	50                   	push   %eax
     be0:	ff 75 d4             	pushl  -0x2c(%ebp)
     be3:	68 a5 18 00 00       	push   $0x18a5
     be8:	6a 02                	push   $0x2
     bea:	e8 61 0a 00 00       	call   1650 <fprintf>
     bef:	83 c4 20             	add    $0x20,%esp
  if (confirmation() != 0) return;
     bf2:	e8 29 f8 ff ff       	call   420 <confirmation>
     bf7:	85 c0                	test   %eax,%eax
     bf9:	75 7f                	jne    c7a <drop+0x11a>
  return nodeAt(list, pos-1);
     bfb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  file->edited = 1;

  // drop lines
  struct Node* curNode = (lineAt(file->lines, start))->prev;
     bfe:	8b 4b 0c             	mov    0xc(%ebx),%ecx
     c01:	83 ec 08             	sub    $0x8,%esp
  file->edited = 1;
     c04:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
     c0b:	83 e8 01             	sub    $0x1,%eax
     c0e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
     c11:	50                   	push   %eax
     c12:	51                   	push   %ecx
     c13:	e8 c8 f5 ff ff       	call   1e0 <nodeAt>
  struct Node* curNode = (lineAt(file->lines, start))->prev;
     c18:	8b 30                	mov    (%eax),%esi
     c1a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c1d:	5a                   	pop    %edx
     c1e:	59                   	pop    %ecx
     c1f:	8b 4d d0             	mov    -0x30(%ebp),%ecx
     c22:	83 e8 01             	sub    $0x1,%eax
     c25:	50                   	push   %eax
     c26:	51                   	push   %ecx
     c27:	e8 b4 f5 ff ff       	call   1e0 <nodeAt>
     c2c:	83 c4 10             	add    $0x10,%esp
  struct Node* stopNode = lineAt(file->lines, end);
  while (curNode != stopNode) {
     c2f:	39 c6                	cmp    %eax,%esi
     c31:	89 c7                	mov    %eax,%edi
     c33:	8b 4d d0             	mov    -0x30(%ebp),%ecx
     c36:	75 0b                	jne    c43 <drop+0xe3>
     c38:	eb 21                	jmp    c5b <drop+0xfb>
     c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     c40:	8b 4b 0c             	mov    0xc(%ebx),%ecx
    curNode = curNode->next;
     c43:	8b 76 08             	mov    0x8(%esi),%esi
    destroyNode(file->lines, curNode);
     c46:	83 ec 08             	sub    $0x8,%esp
     c49:	56                   	push   %esi
     c4a:	51                   	push   %ecx
     c4b:	e8 00 f6 ff ff       	call   250 <destroyNode>
    file->len--;
     c50:	83 6b 10 01          	subl   $0x1,0x10(%ebx)
  while (curNode != stopNode) {
     c54:	83 c4 10             	add    $0x10,%esp
     c57:	39 fe                	cmp    %edi,%esi
     c59:	75 e5                	jne    c40 <drop+0xe0>
  }
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
     c5b:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
     c5f:	0f 84 93 00 00 00    	je     cf8 <drop+0x198>
  else fprintf(2, "%d lines dropped\n", numl);
     c65:	83 ec 04             	sub    $0x4,%esp
     c68:	ff 75 d4             	pushl  -0x2c(%ebp)
     c6b:	68 d4 18 00 00       	push   $0x18d4
     c70:	6a 02                	push   $0x2
     c72:	e8 d9 09 00 00       	call   1650 <fprintf>
     c77:	83 c4 10             	add    $0x10,%esp
  return;
}
     c7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c7d:	5b                   	pop    %ebx
     c7e:	5e                   	pop    %esi
     c7f:	5f                   	pop    %edi
     c80:	5d                   	pop    %ebp
     c81:	c3                   	ret    
     c82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "you need to give a range to drop\n");
     c88:	83 ec 08             	sub    $0x8,%esp
     c8b:	68 d8 19 00 00       	push   $0x19d8
     c90:	6a 02                	push   $0x2
     c92:	e8 b9 09 00 00       	call   1650 <fprintf>
    return;
     c97:	83 c4 10             	add    $0x10,%esp
}
     c9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c9d:	5b                   	pop    %ebx
     c9e:	5e                   	pop    %esi
     c9f:	5f                   	pop    %edi
     ca0:	5d                   	pop    %ebp
     ca1:	c3                   	ret    
     ca2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: start index is larger than end index\n");
     ca8:	83 ec 08             	sub    $0x8,%esp
     cab:	68 fc 19 00 00       	push   $0x19fc
     cb0:	6a 02                	push   $0x2
     cb2:	e8 99 09 00 00       	call   1650 <fprintf>
    return;
     cb7:	83 c4 10             	add    $0x10,%esp
}
     cba:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cbd:	5b                   	pop    %ebx
     cbe:	5e                   	pop    %esi
     cbf:	5f                   	pop    %edi
     cc0:	5d                   	pop    %ebp
     cc1:	c3                   	ret    
     cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
     cc8:	83 ec 04             	sub    $0x4,%esp
     ccb:	50                   	push   %eax
     ccc:	68 90 18 00 00       	push   $0x1890
     cd1:	6a 02                	push   $0x2
     cd3:	e8 78 09 00 00       	call   1650 <fprintf>
     cd8:	83 c4 10             	add    $0x10,%esp
     cdb:	e9 12 ff ff ff       	jmp    bf2 <drop+0x92>
    fprintf(2, "error: bad input range. make sure start < end\n");
     ce0:	83 ec 08             	sub    $0x8,%esp
     ce3:	68 2c 1a 00 00       	push   $0x1a2c
     ce8:	6a 02                	push   $0x2
     cea:	e8 61 09 00 00       	call   1650 <fprintf>
    return;
     cef:	83 c4 10             	add    $0x10,%esp
     cf2:	eb 86                	jmp    c7a <drop+0x11a>
     cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
     cf8:	83 ec 04             	sub    $0x4,%esp
     cfb:	ff 75 e0             	pushl  -0x20(%ebp)
     cfe:	68 c3 18 00 00       	push   $0x18c3
     d03:	6a 02                	push   $0x2
     d05:	e8 46 09 00 00       	call   1650 <fprintf>
     d0a:	83 c4 10             	add    $0x10,%esp
     d0d:	e9 68 ff ff ff       	jmp    c7a <drop+0x11a>
     d12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d20 <edit>:

void edit(struct File* file, char* args) {
     d20:	55                   	push   %ebp
     d21:	89 e5                	mov    %esp,%ebp
     d23:	57                   	push   %edi
     d24:	56                   	push   %esi
     d25:	53                   	push   %ebx
     d26:	83 ec 28             	sub    $0x28,%esp
     d29:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if (strlen(args) < 1) {
     d2c:	53                   	push   %ebx
     d2d:	e8 ce 03 00 00       	call   1100 <strlen>
     d32:	83 c4 10             	add    $0x10,%esp
     d35:	85 c0                	test   %eax,%eax
     d37:	75 1f                	jne    d58 <edit+0x38>
    fprintf(2, "you need to give a line number to replace\n");
     d39:	83 ec 08             	sub    $0x8,%esp
     d3c:	68 5c 1a 00 00       	push   $0x1a5c
     d41:	6a 02                	push   $0x2
     d43:	e8 08 09 00 00       	call   1650 <fprintf>
    return;
     d48:	83 c4 10             	add    $0x10,%esp

  // remove
  destroyNode(file->lines, lineAt(file->lines, lineNum));
  // 1-based to 0-based insert
  insert(file->lines, line, lineNum - 1);
}
     d4b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d4e:	5b                   	pop    %ebx
     d4f:	5e                   	pop    %esi
     d50:	5f                   	pop    %edi
     d51:	5d                   	pop    %ebp
     d52:	c3                   	ret    
     d53:	90                   	nop
     d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  getArg(lineStr, args, ' ');
     d58:	8d 75 de             	lea    -0x22(%ebp),%esi
     d5b:	83 ec 04             	sub    $0x4,%esp
     d5e:	6a 20                	push   $0x20
     d60:	53                   	push   %ebx
     d61:	56                   	push   %esi
     d62:	e8 89 f9 ff ff       	call   6f0 <getArg>
  int lineNum = negatoi(lineStr);
     d67:	89 34 24             	mov    %esi,(%esp)
     d6a:	e8 d1 fb ff ff       	call   940 <negatoi>
  fprintf(2, "replace line %d (y/n)? ", lineNum);
     d6f:	83 c4 0c             	add    $0xc,%esp
  int lineNum = negatoi(lineStr);
     d72:	89 c6                	mov    %eax,%esi
  fprintf(2, "replace line %d (y/n)? ", lineNum);
     d74:	50                   	push   %eax
     d75:	68 e6 18 00 00       	push   $0x18e6
     d7a:	6a 02                	push   $0x2
     d7c:	e8 cf 08 00 00       	call   1650 <fprintf>
  if (confirmation() != 0) return;
     d81:	e8 9a f6 ff ff       	call   420 <confirmation>
     d86:	83 c4 10             	add    $0x10,%esp
     d89:	85 c0                	test   %eax,%eax
     d8b:	75 be                	jne    d4b <edit+0x2b>
  file->edited = 1;
     d8d:	8b 45 08             	mov    0x8(%ebp),%eax
     d90:	83 ec 08             	sub    $0x8,%esp
     d93:	83 ee 01             	sub    $0x1,%esi
  destroyNode(file->lines, lineAt(file->lines, lineNum));
     d96:	8b 78 0c             	mov    0xc(%eax),%edi
  file->edited = 1;
     d99:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
     da0:	56                   	push   %esi
     da1:	57                   	push   %edi
     da2:	e8 39 f4 ff ff       	call   1e0 <nodeAt>
     da7:	5a                   	pop    %edx
     da8:	59                   	pop    %ecx
  destroyNode(file->lines, lineAt(file->lines, lineNum));
     da9:	50                   	push   %eax
     daa:	57                   	push   %edi
     dab:	e8 a0 f4 ff ff       	call   250 <destroyNode>
  insert(file->lines, line, lineNum - 1);
     db0:	8b 45 08             	mov    0x8(%ebp),%eax
     db3:	83 c4 0c             	add    $0xc,%esp
     db6:	56                   	push   %esi
     db7:	53                   	push   %ebx
     db8:	ff 70 0c             	pushl  0xc(%eax)
     dbb:	e8 40 f5 ff ff       	call   300 <insert>
     dc0:	83 c4 10             	add    $0x10,%esp
}
     dc3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     dc6:	5b                   	pop    %ebx
     dc7:	5e                   	pop    %esi
     dc8:	5f                   	pop    %edi
     dc9:	5d                   	pop    %ebp
     dca:	c3                   	ret    
     dcb:	90                   	nop
     dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000dd0 <list>:

void list(struct File file, char* args) {
     dd0:	55                   	push   %ebp
     dd1:	89 e5                	mov    %esp,%ebp
     dd3:	57                   	push   %edi
     dd4:	56                   	push   %esi
     dd5:	53                   	push   %ebx
     dd6:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
     dd9:	ff 75 20             	pushl  0x20(%ebp)
     ddc:	8b 75 14             	mov    0x14(%ebp),%esi
     ddf:	e8 1c 03 00 00       	call   1100 <strlen>
     de4:	83 c4 10             	add    $0x10,%esp
     de7:	85 c0                	test   %eax,%eax
     de9:	75 1d                	jne    e08 <list+0x38>
    fprintf(2, "you need to give a range to list\n");
     deb:	83 ec 08             	sub    $0x8,%esp
     dee:	68 88 1a 00 00       	push   $0x1a88
     df3:	6a 02                	push   $0x2
     df5:	e8 56 08 00 00       	call   1650 <fprintf>
    return;
     dfa:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
    curNode = curNode->next;
    if (curNode == file.lines->tail) return;
    printl(++lineNum, curNode->data);
  }
}
     dfd:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e00:	5b                   	pop    %ebx
     e01:	5e                   	pop    %esi
     e02:	5f                   	pop    %edi
     e03:	5d                   	pop    %ebp
     e04:	c3                   	ret    
     e05:	8d 76 00             	lea    0x0(%esi),%esi
  if (collectRange(args, &start, &end) == 1) {
     e08:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
     e0b:	8d 7d e0             	lea    -0x20(%ebp),%edi
     e0e:	83 ec 04             	sub    $0x4,%esp
     e11:	53                   	push   %ebx
     e12:	57                   	push   %edi
     e13:	ff 75 20             	pushl  0x20(%ebp)
     e16:	e8 45 f9 ff ff       	call   760 <collectRange>
     e1b:	83 c4 10             	add    $0x10,%esp
     e1e:	83 f8 01             	cmp    $0x1,%eax
     e21:	0f 84 91 00 00 00    	je     eb8 <list+0xe8>
  if (normalizeRange(file, &start, &end) == 1) {
     e27:	53                   	push   %ebx
     e28:	57                   	push   %edi
     e29:	ff 75 1c             	pushl  0x1c(%ebp)
     e2c:	ff 75 18             	pushl  0x18(%ebp)
     e2f:	ff 75 14             	pushl  0x14(%ebp)
     e32:	ff 75 10             	pushl  0x10(%ebp)
     e35:	ff 75 0c             	pushl  0xc(%ebp)
     e38:	ff 75 08             	pushl  0x8(%ebp)
     e3b:	e8 40 f6 ff ff       	call   480 <normalizeRange>
     e40:	83 c4 20             	add    $0x20,%esp
     e43:	83 f8 01             	cmp    $0x1,%eax
     e46:	0f 84 8c 00 00 00    	je     ed8 <list+0x108>
  lineNum = start - 1;
     e4c:	8b 45 e0             	mov    -0x20(%ebp),%eax
     e4f:	83 ec 08             	sub    $0x8,%esp
     e52:	8d 78 ff             	lea    -0x1(%eax),%edi
     e55:	57                   	push   %edi
     e56:	56                   	push   %esi
     e57:	e8 84 f3 ff ff       	call   1e0 <nodeAt>
  struct Node* curNode = (lineAt(file.lines, start))->prev;
     e5c:	8b 18                	mov    (%eax),%ebx
     e5e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     e61:	5a                   	pop    %edx
     e62:	59                   	pop    %ecx
     e63:	83 e8 01             	sub    $0x1,%eax
     e66:	50                   	push   %eax
     e67:	56                   	push   %esi
     e68:	e8 73 f3 ff ff       	call   1e0 <nodeAt>
     e6d:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
     e70:	39 d8                	cmp    %ebx,%eax
     e72:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     e75:	74 86                	je     dfd <list+0x2d>
    curNode = curNode->next;
     e77:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
     e7a:	3b 5e 04             	cmp    0x4(%esi),%ebx
     e7d:	75 15                	jne    e94 <list+0xc4>
     e7f:	e9 79 ff ff ff       	jmp    dfd <list+0x2d>
     e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
     e88:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
     e8b:	39 5e 04             	cmp    %ebx,0x4(%esi)
     e8e:	0f 84 69 ff ff ff    	je     dfd <list+0x2d>
    printl(++lineNum, curNode->data);
     e94:	83 ec 08             	sub    $0x8,%esp
     e97:	83 c7 01             	add    $0x1,%edi
     e9a:	ff 73 04             	pushl  0x4(%ebx)
     e9d:	57                   	push   %edi
     e9e:	e8 5d fb ff ff       	call   a00 <printl>
  while (curNode != stopNode) {
     ea3:	83 c4 10             	add    $0x10,%esp
     ea6:	39 5d d4             	cmp    %ebx,-0x2c(%ebp)
     ea9:	75 dd                	jne    e88 <list+0xb8>
}
     eab:	8d 65 f4             	lea    -0xc(%ebp),%esp
     eae:	5b                   	pop    %ebx
     eaf:	5e                   	pop    %esi
     eb0:	5f                   	pop    %edi
     eb1:	5d                   	pop    %ebp
     eb2:	c3                   	ret    
     eb3:	90                   	nop
     eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "error: start index is larger than end index\n");
     eb8:	83 ec 08             	sub    $0x8,%esp
     ebb:	68 fc 19 00 00       	push   $0x19fc
     ec0:	6a 02                	push   $0x2
     ec2:	e8 89 07 00 00       	call   1650 <fprintf>
    return;
     ec7:	83 c4 10             	add    $0x10,%esp
}
     eca:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ecd:	5b                   	pop    %ebx
     ece:	5e                   	pop    %esi
     ecf:	5f                   	pop    %edi
     ed0:	5d                   	pop    %ebp
     ed1:	c3                   	ret    
     ed2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: bad input range. make sure start < end\n");
     ed8:	83 ec 08             	sub    $0x8,%esp
     edb:	68 2c 1a 00 00       	push   $0x1a2c
     ee0:	6a 02                	push   $0x2
     ee2:	e8 69 07 00 00       	call   1650 <fprintf>
    return;
     ee7:	83 c4 10             	add    $0x10,%esp
     eea:	e9 0e ff ff ff       	jmp    dfd <list+0x2d>
     eef:	90                   	nop

00000ef0 <show>:

void show(struct File file, char* args) {
     ef0:	55                   	push   %ebp
     ef1:	89 e5                	mov    %esp,%ebp
     ef3:	57                   	push   %edi
     ef4:	56                   	push   %esi
     ef5:	53                   	push   %ebx
     ef6:	83 ec 0c             	sub    $0xc,%esp
     ef9:	8b 7d 14             	mov    0x14(%ebp),%edi
  struct Node* cur = file.lines->head->next;
     efc:	8b 07                	mov    (%edi),%eax
     efe:	8b 58 08             	mov    0x8(%eax),%ebx
  int lineNum = 1;
  while (cur != file.lines->tail) {
     f01:	3b 5f 04             	cmp    0x4(%edi),%ebx
     f04:	74 24                	je     f2a <show+0x3a>
  int lineNum = 1;
     f06:	be 01 00 00 00       	mov    $0x1,%esi
     f0b:	90                   	nop
     f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printl(lineNum, cur->data);
     f10:	83 ec 08             	sub    $0x8,%esp
     f13:	ff 73 04             	pushl  0x4(%ebx)
     f16:	56                   	push   %esi
    cur = cur->next;
    lineNum++;
     f17:	83 c6 01             	add    $0x1,%esi
    printl(lineNum, cur->data);
     f1a:	e8 e1 fa ff ff       	call   a00 <printl>
    cur = cur->next;
     f1f:	8b 5b 08             	mov    0x8(%ebx),%ebx
  while (cur != file.lines->tail) {
     f22:	83 c4 10             	add    $0x10,%esp
     f25:	39 5f 04             	cmp    %ebx,0x4(%edi)
     f28:	75 e6                	jne    f10 <show+0x20>
  }
}
     f2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f2d:	5b                   	pop    %ebx
     f2e:	5e                   	pop    %esi
     f2f:	5f                   	pop    %edi
     f30:	5d                   	pop    %ebp
     f31:	c3                   	ret    
     f32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000f40 <quit>:

void quit(struct File* file) {
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	56                   	push   %esi
     f44:	53                   	push   %ebx
     f45:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (file->edited == 0) return;
     f48:	8b 4b 14             	mov    0x14(%ebx),%ecx
     f4b:	85 c9                	test   %ecx,%ecx
     f4d:	75 11                	jne    f60 <quit+0x20>
    cur = cur->next;
  }
  close(file->fd);
  fprintf(2, "changes saved\n");
  return;
}
     f4f:	8d 65 f8             	lea    -0x8(%ebp),%esp
     f52:	5b                   	pop    %ebx
     f53:	5e                   	pop    %esi
     f54:	5d                   	pop    %ebp
     f55:	c3                   	ret    
     f56:	8d 76 00             	lea    0x0(%esi),%esi
     f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  fprintf(2, "save changes (y/n)? ");
     f60:	83 ec 08             	sub    $0x8,%esp
     f63:	68 fe 18 00 00       	push   $0x18fe
     f68:	6a 02                	push   $0x2
     f6a:	e8 e1 06 00 00       	call   1650 <fprintf>
  if (confirmation() != 0) return;
     f6f:	e8 ac f4 ff ff       	call   420 <confirmation>
     f74:	83 c4 10             	add    $0x10,%esp
     f77:	85 c0                	test   %eax,%eax
     f79:	75 d4                	jne    f4f <quit+0xf>
  if (unlink(file->filename) < 0) {
     f7b:	83 ec 0c             	sub    $0xc,%esp
     f7e:	ff 33                	pushl  (%ebx)
     f80:	e8 a5 03 00 00       	call   132a <unlink>
     f85:	83 c4 10             	add    $0x10,%esp
     f88:	85 c0                	test   %eax,%eax
     f8a:	0f 88 90 00 00 00    	js     1020 <quit+0xe0>
  file->fd = open(file->filename, O_CREATE|O_RDWR);
     f90:	83 ec 08             	sub    $0x8,%esp
     f93:	68 02 02 00 00       	push   $0x202
     f98:	ff 33                	pushl  (%ebx)
     f9a:	e8 7b 03 00 00       	call   131a <open>
  if (file->fd < 0) {
     f9f:	83 c4 10             	add    $0x10,%esp
     fa2:	85 c0                	test   %eax,%eax
  file->fd = open(file->filename, O_CREATE|O_RDWR);
     fa4:	89 43 04             	mov    %eax,0x4(%ebx)
  if (file->fd < 0) {
     fa7:	0f 88 93 00 00 00    	js     1040 <quit+0x100>
  struct Node* cur = file->lines->head->next;
     fad:	8b 53 0c             	mov    0xc(%ebx),%edx
     fb0:	8b 0a                	mov    (%edx),%ecx
     fb2:	8b 71 08             	mov    0x8(%ecx),%esi
  while (cur != file->lines->tail) {
     fb5:	3b 72 04             	cmp    0x4(%edx),%esi
     fb8:	74 43                	je     ffd <quit+0xbd>
     fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    write(file->fd, cur->data, strlen(cur->data));
     fc0:	83 ec 0c             	sub    $0xc,%esp
     fc3:	ff 76 04             	pushl  0x4(%esi)
     fc6:	e8 35 01 00 00       	call   1100 <strlen>
     fcb:	83 c4 0c             	add    $0xc,%esp
     fce:	50                   	push   %eax
     fcf:	ff 76 04             	pushl  0x4(%esi)
     fd2:	ff 73 04             	pushl  0x4(%ebx)
     fd5:	e8 20 03 00 00       	call   12fa <write>
    write(file->fd, "\n", sizeof(char));
     fda:	83 c4 0c             	add    $0xc,%esp
     fdd:	6a 01                	push   $0x1
     fdf:	68 4d 18 00 00       	push   $0x184d
     fe4:	ff 73 04             	pushl  0x4(%ebx)
     fe7:	e8 0e 03 00 00       	call   12fa <write>
  while (cur != file->lines->tail) {
     fec:	8b 43 0c             	mov    0xc(%ebx),%eax
    cur = cur->next;
     fef:	8b 76 08             	mov    0x8(%esi),%esi
  while (cur != file->lines->tail) {
     ff2:	83 c4 10             	add    $0x10,%esp
     ff5:	39 70 04             	cmp    %esi,0x4(%eax)
     ff8:	75 c6                	jne    fc0 <quit+0x80>
     ffa:	8b 43 04             	mov    0x4(%ebx),%eax
  close(file->fd);
     ffd:	83 ec 0c             	sub    $0xc,%esp
    1000:	50                   	push   %eax
    1001:	e8 fc 02 00 00       	call   1302 <close>
  fprintf(2, "changes saved\n");
    1006:	58                   	pop    %eax
    1007:	5a                   	pop    %edx
    1008:	68 13 19 00 00       	push   $0x1913
    100d:	6a 02                	push   $0x2
    100f:	e8 3c 06 00 00       	call   1650 <fprintf>
  return;
    1014:	83 c4 10             	add    $0x10,%esp
    1017:	e9 33 ff ff ff       	jmp    f4f <quit+0xf>
    101c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "could not clear file for writing. changes lost\n");
    1020:	83 ec 08             	sub    $0x8,%esp
    1023:	68 ac 1a 00 00       	push   $0x1aac
    1028:	6a 02                	push   $0x2
    102a:	e8 21 06 00 00       	call   1650 <fprintf>
    return;
    102f:	83 c4 10             	add    $0x10,%esp
    1032:	e9 18 ff ff ff       	jmp    f4f <quit+0xf>
    1037:	89 f6                	mov    %esi,%esi
    1039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    fprintf(2, "could not open file for writing. changes lost\n");
    1040:	83 ec 08             	sub    $0x8,%esp
    1043:	68 dc 1a 00 00       	push   $0x1adc
    1048:	6a 02                	push   $0x2
    104a:	e8 01 06 00 00       	call   1650 <fprintf>
    return;
    104f:	83 c4 10             	add    $0x10,%esp
    1052:	e9 f8 fe ff ff       	jmp    f4f <quit+0xf>
    1057:	89 f6                	mov    %esi,%esi
    1059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001060 <bi>:

void bi() {
    1060:	55                   	push   %ebp
    1061:	89 e5                	mov    %esp,%ebp
    1063:	83 ec 10             	sub    $0x10,%esp
  fprintf(2, "bad input\n");
    1066:	68 22 19 00 00       	push   $0x1922
    106b:	6a 02                	push   $0x2
    106d:	e8 de 05 00 00       	call   1650 <fprintf>
}
    1072:	83 c4 10             	add    $0x10,%esp
    1075:	c9                   	leave  
    1076:	c3                   	ret    
    1077:	66 90                	xchg   %ax,%ax
    1079:	66 90                	xchg   %ax,%ax
    107b:	66 90                	xchg   %ax,%ax
    107d:	66 90                	xchg   %ax,%ax
    107f:	90                   	nop

00001080 <strcpy>:
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
    1080:	55                   	push   %ebp
    1081:	89 e5                	mov    %esp,%ebp
    1083:	53                   	push   %ebx
    1084:	8b 45 08             	mov    0x8(%ebp),%eax
    1087:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    108a:	89 c2                	mov    %eax,%edx
    108c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1090:	83 c1 01             	add    $0x1,%ecx
    1093:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1097:	83 c2 01             	add    $0x1,%edx
    109a:	84 db                	test   %bl,%bl
    109c:	88 5a ff             	mov    %bl,-0x1(%edx)
    109f:	75 ef                	jne    1090 <strcpy+0x10>
    ;
  return os;
}
    10a1:	5b                   	pop    %ebx
    10a2:	5d                   	pop    %ebp
    10a3:	c3                   	ret    
    10a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000010b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10b0:	55                   	push   %ebp
    10b1:	89 e5                	mov    %esp,%ebp
    10b3:	53                   	push   %ebx
    10b4:	8b 55 08             	mov    0x8(%ebp),%edx
    10b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    10ba:	0f b6 02             	movzbl (%edx),%eax
    10bd:	0f b6 19             	movzbl (%ecx),%ebx
    10c0:	84 c0                	test   %al,%al
    10c2:	75 1c                	jne    10e0 <strcmp+0x30>
    10c4:	eb 2a                	jmp    10f0 <strcmp+0x40>
    10c6:	8d 76 00             	lea    0x0(%esi),%esi
    10c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    10d0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    10d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    10d6:	83 c1 01             	add    $0x1,%ecx
    10d9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    10dc:	84 c0                	test   %al,%al
    10de:	74 10                	je     10f0 <strcmp+0x40>
    10e0:	38 d8                	cmp    %bl,%al
    10e2:	74 ec                	je     10d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    10e4:	29 d8                	sub    %ebx,%eax
}
    10e6:	5b                   	pop    %ebx
    10e7:	5d                   	pop    %ebp
    10e8:	c3                   	ret    
    10e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    10f2:	29 d8                	sub    %ebx,%eax
}
    10f4:	5b                   	pop    %ebx
    10f5:	5d                   	pop    %ebp
    10f6:	c3                   	ret    
    10f7:	89 f6                	mov    %esi,%esi
    10f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001100 <strlen>:

uint
strlen(const char *s)
{
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1106:	80 39 00             	cmpb   $0x0,(%ecx)
    1109:	74 15                	je     1120 <strlen+0x20>
    110b:	31 d2                	xor    %edx,%edx
    110d:	8d 76 00             	lea    0x0(%esi),%esi
    1110:	83 c2 01             	add    $0x1,%edx
    1113:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1117:	89 d0                	mov    %edx,%eax
    1119:	75 f5                	jne    1110 <strlen+0x10>
    ;
  return n;
}
    111b:	5d                   	pop    %ebp
    111c:	c3                   	ret    
    111d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    1120:	31 c0                	xor    %eax,%eax
}
    1122:	5d                   	pop    %ebp
    1123:	c3                   	ret    
    1124:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    112a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001130 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	57                   	push   %edi
    1134:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1137:	8b 4d 10             	mov    0x10(%ebp),%ecx
    113a:	8b 45 0c             	mov    0xc(%ebp),%eax
    113d:	89 d7                	mov    %edx,%edi
    113f:	fc                   	cld    
    1140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1142:	89 d0                	mov    %edx,%eax
    1144:	5f                   	pop    %edi
    1145:	5d                   	pop    %ebp
    1146:	c3                   	ret    
    1147:	89 f6                	mov    %esi,%esi
    1149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001150 <strchr>:

char*
strchr(const char *s, char c)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	53                   	push   %ebx
    1154:	8b 45 08             	mov    0x8(%ebp),%eax
    1157:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    115a:	0f b6 10             	movzbl (%eax),%edx
    115d:	84 d2                	test   %dl,%dl
    115f:	74 1d                	je     117e <strchr+0x2e>
    if(*s == c)
    1161:	38 d3                	cmp    %dl,%bl
    1163:	89 d9                	mov    %ebx,%ecx
    1165:	75 0d                	jne    1174 <strchr+0x24>
    1167:	eb 17                	jmp    1180 <strchr+0x30>
    1169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1170:	38 ca                	cmp    %cl,%dl
    1172:	74 0c                	je     1180 <strchr+0x30>
  for(; *s; s++)
    1174:	83 c0 01             	add    $0x1,%eax
    1177:	0f b6 10             	movzbl (%eax),%edx
    117a:	84 d2                	test   %dl,%dl
    117c:	75 f2                	jne    1170 <strchr+0x20>
      return (char*)s;
  return 0;
    117e:	31 c0                	xor    %eax,%eax
}
    1180:	5b                   	pop    %ebx
    1181:	5d                   	pop    %ebp
    1182:	c3                   	ret    
    1183:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001190 <gets>:

char*
gets(char *buf, int max)
{
    1190:	55                   	push   %ebp
    1191:	89 e5                	mov    %esp,%ebp
    1193:	57                   	push   %edi
    1194:	56                   	push   %esi
    1195:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1196:	31 f6                	xor    %esi,%esi
    1198:	89 f3                	mov    %esi,%ebx
{
    119a:	83 ec 1c             	sub    $0x1c,%esp
    119d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    11a0:	eb 2f                	jmp    11d1 <gets+0x41>
    11a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    11a8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    11ab:	83 ec 04             	sub    $0x4,%esp
    11ae:	6a 01                	push   $0x1
    11b0:	50                   	push   %eax
    11b1:	6a 00                	push   $0x0
    11b3:	e8 32 01 00 00       	call   12ea <read>
    if(cc < 1)
    11b8:	83 c4 10             	add    $0x10,%esp
    11bb:	85 c0                	test   %eax,%eax
    11bd:	7e 1c                	jle    11db <gets+0x4b>
      break;
    buf[i++] = c;
    11bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    11c3:	83 c7 01             	add    $0x1,%edi
    11c6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    11c9:	3c 0a                	cmp    $0xa,%al
    11cb:	74 23                	je     11f0 <gets+0x60>
    11cd:	3c 0d                	cmp    $0xd,%al
    11cf:	74 1f                	je     11f0 <gets+0x60>
  for(i=0; i+1 < max; ){
    11d1:	83 c3 01             	add    $0x1,%ebx
    11d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    11d7:	89 fe                	mov    %edi,%esi
    11d9:	7c cd                	jl     11a8 <gets+0x18>
    11db:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    11dd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    11e0:	c6 03 00             	movb   $0x0,(%ebx)
}
    11e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11e6:	5b                   	pop    %ebx
    11e7:	5e                   	pop    %esi
    11e8:	5f                   	pop    %edi
    11e9:	5d                   	pop    %ebp
    11ea:	c3                   	ret    
    11eb:	90                   	nop
    11ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11f0:	8b 75 08             	mov    0x8(%ebp),%esi
    11f3:	8b 45 08             	mov    0x8(%ebp),%eax
    11f6:	01 de                	add    %ebx,%esi
    11f8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    11fa:	c6 03 00             	movb   $0x0,(%ebx)
}
    11fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1200:	5b                   	pop    %ebx
    1201:	5e                   	pop    %esi
    1202:	5f                   	pop    %edi
    1203:	5d                   	pop    %ebp
    1204:	c3                   	ret    
    1205:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001210 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
    1210:	55                   	push   %ebp
    1211:	89 e5                	mov    %esp,%ebp
    1213:	56                   	push   %esi
    1214:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1215:	83 ec 08             	sub    $0x8,%esp
    1218:	6a 00                	push   $0x0
    121a:	ff 75 08             	pushl  0x8(%ebp)
    121d:	e8 f8 00 00 00       	call   131a <open>
  if(fd < 0)
    1222:	83 c4 10             	add    $0x10,%esp
    1225:	85 c0                	test   %eax,%eax
    1227:	78 27                	js     1250 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1229:	83 ec 08             	sub    $0x8,%esp
    122c:	ff 75 0c             	pushl  0xc(%ebp)
    122f:	89 c3                	mov    %eax,%ebx
    1231:	50                   	push   %eax
    1232:	e8 fb 00 00 00       	call   1332 <fstat>
  close(fd);
    1237:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    123a:	89 c6                	mov    %eax,%esi
  close(fd);
    123c:	e8 c1 00 00 00       	call   1302 <close>
  return r;
    1241:	83 c4 10             	add    $0x10,%esp
}
    1244:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1247:	89 f0                	mov    %esi,%eax
    1249:	5b                   	pop    %ebx
    124a:	5e                   	pop    %esi
    124b:	5d                   	pop    %ebp
    124c:	c3                   	ret    
    124d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1250:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1255:	eb ed                	jmp    1244 <stat+0x34>
    1257:	89 f6                	mov    %esi,%esi
    1259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001260 <atoi>:

int
atoi(const char *s)
{
    1260:	55                   	push   %ebp
    1261:	89 e5                	mov    %esp,%ebp
    1263:	53                   	push   %ebx
    1264:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1267:	0f be 11             	movsbl (%ecx),%edx
    126a:	8d 42 d0             	lea    -0x30(%edx),%eax
    126d:	3c 09                	cmp    $0x9,%al
  n = 0;
    126f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    1274:	77 1f                	ja     1295 <atoi+0x35>
    1276:	8d 76 00             	lea    0x0(%esi),%esi
    1279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1280:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1283:	83 c1 01             	add    $0x1,%ecx
    1286:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    128a:	0f be 11             	movsbl (%ecx),%edx
    128d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1290:	80 fb 09             	cmp    $0x9,%bl
    1293:	76 eb                	jbe    1280 <atoi+0x20>
  return n;
}
    1295:	5b                   	pop    %ebx
    1296:	5d                   	pop    %ebp
    1297:	c3                   	ret    
    1298:	90                   	nop
    1299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000012a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    12a0:	55                   	push   %ebp
    12a1:	89 e5                	mov    %esp,%ebp
    12a3:	56                   	push   %esi
    12a4:	53                   	push   %ebx
    12a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    12a8:	8b 45 08             	mov    0x8(%ebp),%eax
    12ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12ae:	85 db                	test   %ebx,%ebx
    12b0:	7e 14                	jle    12c6 <memmove+0x26>
    12b2:	31 d2                	xor    %edx,%edx
    12b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    12b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    12bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    12bf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    12c2:	39 d3                	cmp    %edx,%ebx
    12c4:	75 f2                	jne    12b8 <memmove+0x18>
  return vdst;
}
    12c6:	5b                   	pop    %ebx
    12c7:	5e                   	pop    %esi
    12c8:	5d                   	pop    %ebp
    12c9:	c3                   	ret    

000012ca <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12ca:	b8 01 00 00 00       	mov    $0x1,%eax
    12cf:	cd 40                	int    $0x40
    12d1:	c3                   	ret    

000012d2 <exit>:
SYSCALL(exit)
    12d2:	b8 02 00 00 00       	mov    $0x2,%eax
    12d7:	cd 40                	int    $0x40
    12d9:	c3                   	ret    

000012da <wait>:
SYSCALL(wait)
    12da:	b8 03 00 00 00       	mov    $0x3,%eax
    12df:	cd 40                	int    $0x40
    12e1:	c3                   	ret    

000012e2 <pipe>:
SYSCALL(pipe)
    12e2:	b8 04 00 00 00       	mov    $0x4,%eax
    12e7:	cd 40                	int    $0x40
    12e9:	c3                   	ret    

000012ea <read>:
SYSCALL(read)
    12ea:	b8 05 00 00 00       	mov    $0x5,%eax
    12ef:	cd 40                	int    $0x40
    12f1:	c3                   	ret    

000012f2 <steal>:
SYSCALL(steal)
    12f2:	b8 17 00 00 00       	mov    $0x17,%eax
    12f7:	cd 40                	int    $0x40
    12f9:	c3                   	ret    

000012fa <write>:
SYSCALL(write)
    12fa:	b8 10 00 00 00       	mov    $0x10,%eax
    12ff:	cd 40                	int    $0x40
    1301:	c3                   	ret    

00001302 <close>:
SYSCALL(close)
    1302:	b8 15 00 00 00       	mov    $0x15,%eax
    1307:	cd 40                	int    $0x40
    1309:	c3                   	ret    

0000130a <kill>:
SYSCALL(kill)
    130a:	b8 06 00 00 00       	mov    $0x6,%eax
    130f:	cd 40                	int    $0x40
    1311:	c3                   	ret    

00001312 <exec>:
SYSCALL(exec)
    1312:	b8 07 00 00 00       	mov    $0x7,%eax
    1317:	cd 40                	int    $0x40
    1319:	c3                   	ret    

0000131a <open>:
SYSCALL(open)
    131a:	b8 0f 00 00 00       	mov    $0xf,%eax
    131f:	cd 40                	int    $0x40
    1321:	c3                   	ret    

00001322 <mknod>:
SYSCALL(mknod)
    1322:	b8 11 00 00 00       	mov    $0x11,%eax
    1327:	cd 40                	int    $0x40
    1329:	c3                   	ret    

0000132a <unlink>:
SYSCALL(unlink)
    132a:	b8 12 00 00 00       	mov    $0x12,%eax
    132f:	cd 40                	int    $0x40
    1331:	c3                   	ret    

00001332 <fstat>:
SYSCALL(fstat)
    1332:	b8 08 00 00 00       	mov    $0x8,%eax
    1337:	cd 40                	int    $0x40
    1339:	c3                   	ret    

0000133a <link>:
SYSCALL(link)
    133a:	b8 13 00 00 00       	mov    $0x13,%eax
    133f:	cd 40                	int    $0x40
    1341:	c3                   	ret    

00001342 <mkdir>:
SYSCALL(mkdir)
    1342:	b8 14 00 00 00       	mov    $0x14,%eax
    1347:	cd 40                	int    $0x40
    1349:	c3                   	ret    

0000134a <chdir>:
SYSCALL(chdir)
    134a:	b8 09 00 00 00       	mov    $0x9,%eax
    134f:	cd 40                	int    $0x40
    1351:	c3                   	ret    

00001352 <dup>:
SYSCALL(dup)
    1352:	b8 0a 00 00 00       	mov    $0xa,%eax
    1357:	cd 40                	int    $0x40
    1359:	c3                   	ret    

0000135a <getpid>:
SYSCALL(getpid)
    135a:	b8 0b 00 00 00       	mov    $0xb,%eax
    135f:	cd 40                	int    $0x40
    1361:	c3                   	ret    

00001362 <sbrk>:
SYSCALL(sbrk)
    1362:	b8 0c 00 00 00       	mov    $0xc,%eax
    1367:	cd 40                	int    $0x40
    1369:	c3                   	ret    

0000136a <sleep>:
SYSCALL(sleep)
    136a:	b8 0d 00 00 00       	mov    $0xd,%eax
    136f:	cd 40                	int    $0x40
    1371:	c3                   	ret    

00001372 <uptime>:
SYSCALL(uptime)
    1372:	b8 0e 00 00 00       	mov    $0xe,%eax
    1377:	cd 40                	int    $0x40
    1379:	c3                   	ret    

0000137a <cpuhalt>:
SYSCALL(cpuhalt)
    137a:	b8 16 00 00 00       	mov    $0x16,%eax
    137f:	cd 40                	int    $0x40
    1381:	c3                   	ret    
    1382:	66 90                	xchg   %ax,%ax
    1384:	66 90                	xchg   %ax,%ax
    1386:	66 90                	xchg   %ax,%ax
    1388:	66 90                	xchg   %ax,%ax
    138a:	66 90                	xchg   %ax,%ax
    138c:	66 90                	xchg   %ax,%ax
    138e:	66 90                	xchg   %ax,%ax

00001390 <printint.constprop.1>:
    1390:	55                   	push   %ebp
    1391:	89 e5                	mov    %esp,%ebp
    1393:	57                   	push   %edi
    1394:	56                   	push   %esi
    1395:	53                   	push   %ebx
    1396:	89 d6                	mov    %edx,%esi
    1398:	83 ec 3c             	sub    $0x3c,%esp
    139b:	85 c0                	test   %eax,%eax
    139d:	79 71                	jns    1410 <printint.constprop.1+0x80>
    139f:	83 e1 01             	and    $0x1,%ecx
    13a2:	74 6c                	je     1410 <printint.constprop.1+0x80>
    13a4:	f7 d8                	neg    %eax
    13a6:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    13ad:	31 c9                	xor    %ecx,%ecx
    13af:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    13b2:	eb 06                	jmp    13ba <printint.constprop.1+0x2a>
    13b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    13b8:	89 f9                	mov    %edi,%ecx
    13ba:	31 d2                	xor    %edx,%edx
    13bc:	8d 79 01             	lea    0x1(%ecx),%edi
    13bf:	f7 f6                	div    %esi
    13c1:	0f b6 92 14 1b 00 00 	movzbl 0x1b14(%edx),%edx
    13c8:	85 c0                	test   %eax,%eax
    13ca:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
    13cd:	75 e9                	jne    13b8 <printint.constprop.1+0x28>
    13cf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    13d2:	85 c0                	test   %eax,%eax
    13d4:	74 08                	je     13de <printint.constprop.1+0x4e>
    13d6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    13db:	8d 79 02             	lea    0x2(%ecx),%edi
    13de:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    13e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    13e8:	0f b6 06             	movzbl (%esi),%eax
    13eb:	83 ec 04             	sub    $0x4,%esp
    13ee:	83 ee 01             	sub    $0x1,%esi
    13f1:	6a 01                	push   $0x1
    13f3:	53                   	push   %ebx
    13f4:	6a 01                	push   $0x1
    13f6:	88 45 d7             	mov    %al,-0x29(%ebp)
    13f9:	e8 fc fe ff ff       	call   12fa <write>
    13fe:	83 c4 10             	add    $0x10,%esp
    1401:	39 de                	cmp    %ebx,%esi
    1403:	75 e3                	jne    13e8 <printint.constprop.1+0x58>
    1405:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1408:	5b                   	pop    %ebx
    1409:	5e                   	pop    %esi
    140a:	5f                   	pop    %edi
    140b:	5d                   	pop    %ebp
    140c:	c3                   	ret    
    140d:	8d 76 00             	lea    0x0(%esi),%esi
    1410:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1417:	eb 94                	jmp    13ad <printint.constprop.1+0x1d>
    1419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001420 <vprintf.constprop.0>:
    1420:	55                   	push   %ebp
    1421:	89 e5                	mov    %esp,%ebp
    1423:	57                   	push   %edi
    1424:	56                   	push   %esi
    1425:	53                   	push   %ebx
    1426:	89 d6                	mov    %edx,%esi
    1428:	83 ec 2c             	sub    $0x2c,%esp
    142b:	0f b6 10             	movzbl (%eax),%edx
    142e:	84 d2                	test   %dl,%dl
    1430:	0f 84 cd 00 00 00    	je     1503 <vprintf.constprop.0+0xe3>
    1436:	8d 58 01             	lea    0x1(%eax),%ebx
    1439:	31 ff                	xor    %edi,%edi
    143b:	eb 31                	jmp    146e <vprintf.constprop.0+0x4e>
    143d:	8d 76 00             	lea    0x0(%esi),%esi
    1440:	83 f8 25             	cmp    $0x25,%eax
    1443:	0f 84 c7 00 00 00    	je     1510 <vprintf.constprop.0+0xf0>
    1449:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    144c:	83 ec 04             	sub    $0x4,%esp
    144f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
    1452:	6a 01                	push   $0x1
    1454:	50                   	push   %eax
    1455:	6a 01                	push   $0x1
    1457:	e8 9e fe ff ff       	call   12fa <write>
    145c:	83 c4 10             	add    $0x10,%esp
    145f:	83 c3 01             	add    $0x1,%ebx
    1462:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1466:	84 d2                	test   %dl,%dl
    1468:	0f 84 95 00 00 00    	je     1503 <vprintf.constprop.0+0xe3>
    146e:	85 ff                	test   %edi,%edi
    1470:	0f b6 c2             	movzbl %dl,%eax
    1473:	74 cb                	je     1440 <vprintf.constprop.0+0x20>
    1475:	83 ff 25             	cmp    $0x25,%edi
    1478:	75 e5                	jne    145f <vprintf.constprop.0+0x3f>
    147a:	83 f8 64             	cmp    $0x64,%eax
    147d:	8d 7e 04             	lea    0x4(%esi),%edi
    1480:	b9 01 00 00 00       	mov    $0x1,%ecx
    1485:	0f 84 9a 00 00 00    	je     1525 <vprintf.constprop.0+0x105>
    148b:	83 f8 6c             	cmp    $0x6c,%eax
    148e:	0f 84 8c 00 00 00    	je     1520 <vprintf.constprop.0+0x100>
    1494:	83 f8 78             	cmp    $0x78,%eax
    1497:	0f 84 a3 00 00 00    	je     1540 <vprintf.constprop.0+0x120>
    149d:	83 f8 70             	cmp    $0x70,%eax
    14a0:	0f 84 ca 00 00 00    	je     1570 <vprintf.constprop.0+0x150>
    14a6:	83 f8 73             	cmp    $0x73,%eax
    14a9:	0f 84 39 01 00 00    	je     15e8 <vprintf.constprop.0+0x1c8>
    14af:	83 f8 63             	cmp    $0x63,%eax
    14b2:	0f 84 68 01 00 00    	je     1620 <vprintf.constprop.0+0x200>
    14b8:	83 f8 25             	cmp    $0x25,%eax
    14bb:	0f 84 9f 00 00 00    	je     1560 <vprintf.constprop.0+0x140>
    14c1:	8d 45 df             	lea    -0x21(%ebp),%eax
    14c4:	83 ec 04             	sub    $0x4,%esp
    14c7:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    14ca:	6a 01                	push   $0x1
    14cc:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
    14d0:	50                   	push   %eax
    14d1:	6a 01                	push   $0x1
    14d3:	e8 22 fe ff ff       	call   12fa <write>
    14d8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    14dc:	83 c4 0c             	add    $0xc,%esp
    14df:	8d 45 e0             	lea    -0x20(%ebp),%eax
    14e2:	6a 01                	push   $0x1
    14e4:	88 55 e0             	mov    %dl,-0x20(%ebp)
    14e7:	50                   	push   %eax
    14e8:	6a 01                	push   $0x1
    14ea:	83 c3 01             	add    $0x1,%ebx
    14ed:	31 ff                	xor    %edi,%edi
    14ef:	e8 06 fe ff ff       	call   12fa <write>
    14f4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    14f8:	83 c4 10             	add    $0x10,%esp
    14fb:	84 d2                	test   %dl,%dl
    14fd:	0f 85 6b ff ff ff    	jne    146e <vprintf.constprop.0+0x4e>
    1503:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1506:	5b                   	pop    %ebx
    1507:	5e                   	pop    %esi
    1508:	5f                   	pop    %edi
    1509:	5d                   	pop    %ebp
    150a:	c3                   	ret    
    150b:	90                   	nop
    150c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1510:	bf 25 00 00 00       	mov    $0x25,%edi
    1515:	e9 45 ff ff ff       	jmp    145f <vprintf.constprop.0+0x3f>
    151a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1520:	8d 7e 04             	lea    0x4(%esi),%edi
    1523:	31 c9                	xor    %ecx,%ecx
    1525:	8b 06                	mov    (%esi),%eax
    1527:	ba 0a 00 00 00       	mov    $0xa,%edx
    152c:	89 fe                	mov    %edi,%esi
    152e:	31 ff                	xor    %edi,%edi
    1530:	e8 5b fe ff ff       	call   1390 <printint.constprop.1>
    1535:	e9 25 ff ff ff       	jmp    145f <vprintf.constprop.0+0x3f>
    153a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1540:	8b 06                	mov    (%esi),%eax
    1542:	8d 7e 04             	lea    0x4(%esi),%edi
    1545:	31 c9                	xor    %ecx,%ecx
    1547:	ba 10 00 00 00       	mov    $0x10,%edx
    154c:	89 fe                	mov    %edi,%esi
    154e:	31 ff                	xor    %edi,%edi
    1550:	e8 3b fe ff ff       	call   1390 <printint.constprop.1>
    1555:	e9 05 ff ff ff       	jmp    145f <vprintf.constprop.0+0x3f>
    155a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1560:	83 ec 04             	sub    $0x4,%esp
    1563:	88 55 e1             	mov    %dl,-0x1f(%ebp)
    1566:	8d 45 e1             	lea    -0x1f(%ebp),%eax
    1569:	6a 01                	push   $0x1
    156b:	e9 77 ff ff ff       	jmp    14e7 <vprintf.constprop.0+0xc7>
    1570:	8d 46 04             	lea    0x4(%esi),%eax
    1573:	83 ec 04             	sub    $0x4,%esp
    1576:	8b 3e                	mov    (%esi),%edi
    1578:	6a 01                	push   $0x1
    157a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
    157e:	be 08 00 00 00       	mov    $0x8,%esi
    1583:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1586:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1589:	50                   	push   %eax
    158a:	6a 01                	push   $0x1
    158c:	e8 69 fd ff ff       	call   12fa <write>
    1591:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1594:	83 c4 0c             	add    $0xc,%esp
    1597:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
    159b:	6a 01                	push   $0x1
    159d:	50                   	push   %eax
    159e:	6a 01                	push   $0x1
    15a0:	e8 55 fd ff ff       	call   12fa <write>
    15a5:	83 c4 10             	add    $0x10,%esp
    15a8:	90                   	nop
    15a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15b0:	89 f8                	mov    %edi,%eax
    15b2:	83 ec 04             	sub    $0x4,%esp
    15b5:	c1 e7 04             	shl    $0x4,%edi
    15b8:	c1 e8 1c             	shr    $0x1c,%eax
    15bb:	6a 01                	push   $0x1
    15bd:	0f b6 80 14 1b 00 00 	movzbl 0x1b14(%eax),%eax
    15c4:	88 45 e5             	mov    %al,-0x1b(%ebp)
    15c7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    15ca:	50                   	push   %eax
    15cb:	6a 01                	push   $0x1
    15cd:	e8 28 fd ff ff       	call   12fa <write>
    15d2:	83 c4 10             	add    $0x10,%esp
    15d5:	83 ee 01             	sub    $0x1,%esi
    15d8:	75 d6                	jne    15b0 <vprintf.constprop.0+0x190>
    15da:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    15dd:	31 ff                	xor    %edi,%edi
    15df:	e9 7b fe ff ff       	jmp    145f <vprintf.constprop.0+0x3f>
    15e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    15e8:	8b 3e                	mov    (%esi),%edi
    15ea:	8d 46 04             	lea    0x4(%esi),%eax
    15ed:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    15f0:	85 ff                	test   %edi,%edi
    15f2:	74 50                	je     1644 <vprintf.constprop.0+0x224>
    15f4:	0f b6 07             	movzbl (%edi),%eax
    15f7:	84 c0                	test   %al,%al
    15f9:	74 df                	je     15da <vprintf.constprop.0+0x1ba>
    15fb:	8d 75 e3             	lea    -0x1d(%ebp),%esi
    15fe:	66 90                	xchg   %ax,%ax
    1600:	83 ec 04             	sub    $0x4,%esp
    1603:	83 c7 01             	add    $0x1,%edi
    1606:	88 45 e3             	mov    %al,-0x1d(%ebp)
    1609:	6a 01                	push   $0x1
    160b:	56                   	push   %esi
    160c:	6a 01                	push   $0x1
    160e:	e8 e7 fc ff ff       	call   12fa <write>
    1613:	0f b6 07             	movzbl (%edi),%eax
    1616:	83 c4 10             	add    $0x10,%esp
    1619:	84 c0                	test   %al,%al
    161b:	75 e3                	jne    1600 <vprintf.constprop.0+0x1e0>
    161d:	eb bb                	jmp    15da <vprintf.constprop.0+0x1ba>
    161f:	90                   	nop
    1620:	8b 06                	mov    (%esi),%eax
    1622:	83 ec 04             	sub    $0x4,%esp
    1625:	8d 7e 04             	lea    0x4(%esi),%edi
    1628:	6a 01                	push   $0x1
    162a:	89 fe                	mov    %edi,%esi
    162c:	31 ff                	xor    %edi,%edi
    162e:	88 45 e2             	mov    %al,-0x1e(%ebp)
    1631:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1634:	50                   	push   %eax
    1635:	6a 01                	push   $0x1
    1637:	e8 be fc ff ff       	call   12fa <write>
    163c:	83 c4 10             	add    $0x10,%esp
    163f:	e9 1b fe ff ff       	jmp    145f <vprintf.constprop.0+0x3f>
    1644:	bf 0c 1b 00 00       	mov    $0x1b0c,%edi
    1649:	b8 28 00 00 00       	mov    $0x28,%eax
    164e:	eb ab                	jmp    15fb <vprintf.constprop.0+0x1db>

00001650 <fprintf>:
    1650:	55                   	push   %ebp
    1651:	89 e5                	mov    %esp,%ebp
    1653:	83 ec 08             	sub    $0x8,%esp
    1656:	8b 45 0c             	mov    0xc(%ebp),%eax
    1659:	8d 55 10             	lea    0x10(%ebp),%edx
    165c:	e8 bf fd ff ff       	call   1420 <vprintf.constprop.0>
    1661:	c9                   	leave  
    1662:	c3                   	ret    
    1663:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001670 <printf>:
    1670:	55                   	push   %ebp
    1671:	89 e5                	mov    %esp,%ebp
    1673:	83 ec 08             	sub    $0x8,%esp
    1676:	8b 45 08             	mov    0x8(%ebp),%eax
    1679:	8d 55 0c             	lea    0xc(%ebp),%edx
    167c:	e8 9f fd ff ff       	call   1420 <vprintf.constprop.0>
    1681:	c9                   	leave  
    1682:	c3                   	ret    
    1683:	66 90                	xchg   %ax,%ax
    1685:	66 90                	xchg   %ax,%ax
    1687:	66 90                	xchg   %ax,%ax
    1689:	66 90                	xchg   %ax,%ax
    168b:	66 90                	xchg   %ax,%ax
    168d:	66 90                	xchg   %ax,%ax
    168f:	90                   	nop

00001690 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1690:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1691:	a1 48 24 00 00       	mov    0x2448,%eax
{
    1696:	89 e5                	mov    %esp,%ebp
    1698:	57                   	push   %edi
    1699:	56                   	push   %esi
    169a:	53                   	push   %ebx
    169b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    169e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    16a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16a8:	39 c8                	cmp    %ecx,%eax
    16aa:	8b 10                	mov    (%eax),%edx
    16ac:	73 32                	jae    16e0 <free+0x50>
    16ae:	39 d1                	cmp    %edx,%ecx
    16b0:	72 04                	jb     16b6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16b2:	39 d0                	cmp    %edx,%eax
    16b4:	72 32                	jb     16e8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    16b6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    16b9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    16bc:	39 fa                	cmp    %edi,%edx
    16be:	74 30                	je     16f0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    16c0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    16c3:	8b 50 04             	mov    0x4(%eax),%edx
    16c6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    16c9:	39 f1                	cmp    %esi,%ecx
    16cb:	74 3a                	je     1707 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    16cd:	89 08                	mov    %ecx,(%eax)
  freep = p;
    16cf:	a3 48 24 00 00       	mov    %eax,0x2448
}
    16d4:	5b                   	pop    %ebx
    16d5:	5e                   	pop    %esi
    16d6:	5f                   	pop    %edi
    16d7:	5d                   	pop    %ebp
    16d8:	c3                   	ret    
    16d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16e0:	39 d0                	cmp    %edx,%eax
    16e2:	72 04                	jb     16e8 <free+0x58>
    16e4:	39 d1                	cmp    %edx,%ecx
    16e6:	72 ce                	jb     16b6 <free+0x26>
{
    16e8:	89 d0                	mov    %edx,%eax
    16ea:	eb bc                	jmp    16a8 <free+0x18>
    16ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    16f0:	03 72 04             	add    0x4(%edx),%esi
    16f3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    16f6:	8b 10                	mov    (%eax),%edx
    16f8:	8b 12                	mov    (%edx),%edx
    16fa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    16fd:	8b 50 04             	mov    0x4(%eax),%edx
    1700:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1703:	39 f1                	cmp    %esi,%ecx
    1705:	75 c6                	jne    16cd <free+0x3d>
    p->s.size += bp->s.size;
    1707:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    170a:	a3 48 24 00 00       	mov    %eax,0x2448
    p->s.size += bp->s.size;
    170f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1712:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1715:	89 10                	mov    %edx,(%eax)
}
    1717:	5b                   	pop    %ebx
    1718:	5e                   	pop    %esi
    1719:	5f                   	pop    %edi
    171a:	5d                   	pop    %ebp
    171b:	c3                   	ret    
    171c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1720:	55                   	push   %ebp
    1721:	89 e5                	mov    %esp,%ebp
    1723:	57                   	push   %edi
    1724:	56                   	push   %esi
    1725:	53                   	push   %ebx
    1726:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1729:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    172c:	8b 15 48 24 00 00    	mov    0x2448,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1732:	8d 78 07             	lea    0x7(%eax),%edi
    1735:	c1 ef 03             	shr    $0x3,%edi
    1738:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    173b:	85 d2                	test   %edx,%edx
    173d:	0f 84 9d 00 00 00    	je     17e0 <malloc+0xc0>
    1743:	8b 02                	mov    (%edx),%eax
    1745:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1748:	39 cf                	cmp    %ecx,%edi
    174a:	76 6c                	jbe    17b8 <malloc+0x98>
    174c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1752:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1757:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    175a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1761:	eb 0e                	jmp    1771 <malloc+0x51>
    1763:	90                   	nop
    1764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1768:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    176a:	8b 48 04             	mov    0x4(%eax),%ecx
    176d:	39 f9                	cmp    %edi,%ecx
    176f:	73 47                	jae    17b8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1771:	39 05 48 24 00 00    	cmp    %eax,0x2448
    1777:	89 c2                	mov    %eax,%edx
    1779:	75 ed                	jne    1768 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    177b:	83 ec 0c             	sub    $0xc,%esp
    177e:	56                   	push   %esi
    177f:	e8 de fb ff ff       	call   1362 <sbrk>
  if(p == (char*)-1)
    1784:	83 c4 10             	add    $0x10,%esp
    1787:	83 f8 ff             	cmp    $0xffffffff,%eax
    178a:	74 1c                	je     17a8 <malloc+0x88>
  hp->s.size = nu;
    178c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    178f:	83 ec 0c             	sub    $0xc,%esp
    1792:	83 c0 08             	add    $0x8,%eax
    1795:	50                   	push   %eax
    1796:	e8 f5 fe ff ff       	call   1690 <free>
  return freep;
    179b:	8b 15 48 24 00 00    	mov    0x2448,%edx
      if((p = morecore(nunits)) == 0)
    17a1:	83 c4 10             	add    $0x10,%esp
    17a4:	85 d2                	test   %edx,%edx
    17a6:	75 c0                	jne    1768 <malloc+0x48>
        return 0;
  }
}
    17a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    17ab:	31 c0                	xor    %eax,%eax
}
    17ad:	5b                   	pop    %ebx
    17ae:	5e                   	pop    %esi
    17af:	5f                   	pop    %edi
    17b0:	5d                   	pop    %ebp
    17b1:	c3                   	ret    
    17b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    17b8:	39 cf                	cmp    %ecx,%edi
    17ba:	74 54                	je     1810 <malloc+0xf0>
        p->s.size -= nunits;
    17bc:	29 f9                	sub    %edi,%ecx
    17be:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    17c1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    17c4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    17c7:	89 15 48 24 00 00    	mov    %edx,0x2448
}
    17cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    17d0:	83 c0 08             	add    $0x8,%eax
}
    17d3:	5b                   	pop    %ebx
    17d4:	5e                   	pop    %esi
    17d5:	5f                   	pop    %edi
    17d6:	5d                   	pop    %ebp
    17d7:	c3                   	ret    
    17d8:	90                   	nop
    17d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    17e0:	c7 05 48 24 00 00 4c 	movl   $0x244c,0x2448
    17e7:	24 00 00 
    17ea:	c7 05 4c 24 00 00 4c 	movl   $0x244c,0x244c
    17f1:	24 00 00 
    base.s.size = 0;
    17f4:	b8 4c 24 00 00       	mov    $0x244c,%eax
    17f9:	c7 05 50 24 00 00 00 	movl   $0x0,0x2450
    1800:	00 00 00 
    1803:	e9 44 ff ff ff       	jmp    174c <malloc+0x2c>
    1808:	90                   	nop
    1809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1810:	8b 08                	mov    (%eax),%ecx
    1812:	89 0a                	mov    %ecx,(%edx)
    1814:	eb b1                	jmp    17c7 <malloc+0xa7>
