
user/_more:     file format elf32-i386


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
       d:	53                   	push   %ebx
       e:	51                   	push   %ecx
       f:	83 ec 20             	sub    $0x20,%esp
      12:	8b 01                	mov    (%ecx),%eax
      14:	8b 51 04             	mov    0x4(%ecx),%edx
  // arg czeching
  if (argc < 2) {
      17:	83 f8 01             	cmp    $0x1,%eax
      1a:	0f 8e b3 00 00 00    	jle    d3 <main+0xd3>
    fprintf(2, "more: bad usage\nTry 'more --help' for more information.\n");
    exit();
  } else if (argc > 2) {
      20:	83 f8 02             	cmp    $0x2,%eax
      23:	0f 85 97 00 00 00    	jne    c0 <main+0xc0>
    uint size;
  };
  struct File file;
  file.len = 0;
  file.edited = 0;
  file.filename = argv[1];
      29:	8b 42 04             	mov    0x4(%edx),%eax
  char cmd[1] = "w";
      2c:	c6 45 df 77          	movb   $0x77,-0x21(%ebp)
  file.len = 0;
      30:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  file.edited = 0;
      37:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  file.filename = argv[1];
      3e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  file.lines = MakeLinkedList();
      41:	e8 da 01 00 00       	call   220 <MakeLinkedList>

  // opening file
  file.fd = open(file.filename, O_RDONLY);
      46:	52                   	push   %edx
      47:	52                   	push   %edx
      48:	6a 00                	push   $0x0
      4a:	ff 75 e0             	pushl  -0x20(%ebp)
  file.lines = MakeLinkedList();
      4d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  file.fd = open(file.filename, O_RDONLY);
      50:	e8 0d 12 00 00       	call   1262 <open>
  if (file.fd == -1) {
      55:	83 c4 10             	add    $0x10,%esp
  file.fd = open(file.filename, O_RDONLY);
      58:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if (file.fd == -1) {
      5b:	83 c0 01             	add    $0x1,%eax
      5e:	0f 84 82 00 00 00    	je     e6 <main+0xe6>
    fprintf(2, "file could not be opened\n",  file.filename);
  } else { 
    // populate Linked List
    gatherLines(&file);
      64:	8d 45 e0             	lea    -0x20(%ebp),%eax
      67:	83 ec 0c             	sub    $0xc,%esp
      6a:	50                   	push   %eax
      6b:	e8 b0 04 00 00       	call   520 <gatherLines>
      70:	83 c4 10             	add    $0x10,%esp
  }
  close(file.fd);
      73:	83 ec 0c             	sub    $0xc,%esp
      76:	ff 75 e4             	pushl  -0x1c(%ebp)
      79:	e8 cc 11 00 00       	call   124a <close>

  // loop
  while (cmd[0] != 'q') {
      7e:	83 c4 10             	add    $0x10,%esp
      81:	80 7d df 71          	cmpb   $0x71,-0x21(%ebp)
      85:	74 34                	je     bb <main+0xbb>
      87:	8d 5d df             	lea    -0x21(%ebp),%ebx
      8a:	eb 1b                	jmp    a7 <main+0xa7>
      8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if(read(0, cmd, 1) == 0) exit();
		printf("%s\n", cmd);
      90:	83 ec 08             	sub    $0x8,%esp
      93:	53                   	push   %ebx
      94:	68 75 17 00 00       	push   $0x1775
      99:	e8 12 15 00 00       	call   15b0 <printf>
  while (cmd[0] != 'q') {
      9e:	83 c4 10             	add    $0x10,%esp
      a1:	80 7d df 71          	cmpb   $0x71,-0x21(%ebp)
      a5:	74 14                	je     bb <main+0xbb>
		if(read(0, cmd, 1) == 0) exit();
      a7:	83 ec 04             	sub    $0x4,%esp
      aa:	6a 01                	push   $0x1
      ac:	53                   	push   %ebx
      ad:	6a 00                	push   $0x0
      af:	e8 86 11 00 00       	call   123a <read>
      b4:	83 c4 10             	add    $0x10,%esp
      b7:	85 c0                	test   %eax,%eax
      b9:	75 d5                	jne    90 <main+0x90>
      bb:	e8 62 11 00 00       	call   1222 <exit>
    fprintf(2, "this version of more only supports one file at a time.\n");
      c0:	51                   	push   %ecx
      c1:	51                   	push   %ecx
      c2:	68 80 18 00 00       	push   $0x1880
      c7:	6a 02                	push   $0x2
      c9:	e8 c2 14 00 00       	call   1590 <fprintf>
    exit();
      ce:	e8 4f 11 00 00       	call   1222 <exit>
    fprintf(2, "more: bad usage\nTry 'more --help' for more information.\n");
      d3:	53                   	push   %ebx
      d4:	53                   	push   %ebx
      d5:	68 44 18 00 00       	push   $0x1844
      da:	6a 02                	push   $0x2
      dc:	e8 af 14 00 00       	call   1590 <fprintf>
    exit();
      e1:	e8 3c 11 00 00       	call   1222 <exit>
    fprintf(2, "file could not be opened\n",  file.filename);
      e6:	50                   	push   %eax
      e7:	ff 75 e0             	pushl  -0x20(%ebp)
      ea:	68 8a 17 00 00       	push   $0x178a
      ef:	6a 02                	push   $0x2
      f1:	e8 9a 14 00 00       	call   1590 <fprintf>
      f6:	83 c4 10             	add    $0x10,%esp
      f9:	e9 75 ff ff ff       	jmp    73 <main+0x73>
      fe:	66 90                	xchg   %ax,%ax

00000100 <safestrcpy>:
#include "LinkedList.h"
#define nullptr 0

char* safestrcpy(char *s, const char *t, int n) {
     100:	55                   	push   %ebp
     101:	89 e5                	mov    %esp,%ebp
     103:	56                   	push   %esi
     104:	53                   	push   %ebx
     105:	8b 4d 10             	mov    0x10(%ebp),%ecx
     108:	8b 45 08             	mov    0x8(%ebp),%eax
     10b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
     10e:	85 c9                	test   %ecx,%ecx
     110:	7e 26                	jle    138 <safestrcpy+0x38>
     112:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
     116:	89 c1                	mov    %eax,%ecx
     118:	eb 17                	jmp    131 <safestrcpy+0x31>
     11a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
     120:	83 c2 01             	add    $0x1,%edx
     123:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
     127:	83 c1 01             	add    $0x1,%ecx
     12a:	84 db                	test   %bl,%bl
     12c:	88 59 ff             	mov    %bl,-0x1(%ecx)
     12f:	74 04                	je     135 <safestrcpy+0x35>
     131:	39 f2                	cmp    %esi,%edx
     133:	75 eb                	jne    120 <safestrcpy+0x20>
    ;
  *s = 0;
     135:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
     138:	5b                   	pop    %ebx
     139:	5e                   	pop    %esi
     13a:	5d                   	pop    %ebp
     13b:	c3                   	ret    
     13c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000140 <nullNode>:

Node* nullNode(char* data) {
     140:	55                   	push   %ebp
     141:	89 e5                	mov    %esp,%ebp
     143:	83 ec 14             	sub    $0x14,%esp
  struct Node* node = malloc(sizeof(Node));
     146:	6a 0c                	push   $0xc
     148:	e8 13 15 00 00       	call   1660 <malloc>
  node->prev = nullptr;
  node->data = data;
     14d:	8b 55 08             	mov    0x8(%ebp),%edx
  node->prev = nullptr;
     150:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->next = nullptr;
     156:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  node->data = data;
     15d:	89 50 04             	mov    %edx,0x4(%eax)
  return node;
}
     160:	c9                   	leave  
     161:	c3                   	ret    
     162:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <nodeAt>:

Node* nodeAt(struct LinkedList* list, int pos) {
     170:	55                   	push   %ebp
     171:	89 e5                	mov    %esp,%ebp
     173:	53                   	push   %ebx
     174:	8b 45 08             	mov    0x8(%ebp),%eax
     177:	8b 55 0c             	mov    0xc(%ebp),%edx
  // for anything past the end:
  if (pos > list->len)
     17a:	8b 48 08             	mov    0x8(%eax),%ecx
     17d:	39 d1                	cmp    %edx,%ecx
     17f:	7c 1f                	jl     1a0 <nodeAt+0x30>
    return list->tail->prev;
  // for anything before the beginning:
  if ((pos < 0) && ((0 - pos) > list->len))
     181:	85 d2                	test   %edx,%edx
     183:	78 2b                	js     1b0 <nodeAt+0x40>
    while (++pos != 0)
      curNode = curNode->prev;
  } // start looking from front
  else {
    int cur = 0;
    curNode = list->head->next;
     185:	8b 00                	mov    (%eax),%eax
     187:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     18a:	74 0e                	je     19a <nodeAt+0x2a>
    int cur = 0;
     18c:	31 c9                	xor    %ecx,%ecx
     18e:	66 90                	xchg   %ax,%ax
      curNode = curNode->next;
      cur++;
     190:	83 c1 01             	add    $0x1,%ecx
      curNode = curNode->next;
     193:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     196:	39 ca                	cmp    %ecx,%edx
     198:	75 f6                	jne    190 <nodeAt+0x20>
    }
  }
  return curNode;
}
     19a:	5b                   	pop    %ebx
     19b:	5d                   	pop    %ebp
     19c:	c3                   	ret    
     19d:	8d 76 00             	lea    0x0(%esi),%esi
    return list->tail->prev;
     1a0:	8b 40 04             	mov    0x4(%eax),%eax
}
     1a3:	5b                   	pop    %ebx
     1a4:	5d                   	pop    %ebp
    return list->tail->prev;
     1a5:	8b 00                	mov    (%eax),%eax
}
     1a7:	c3                   	ret    
     1a8:	90                   	nop
     1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if ((pos < 0) && ((0 - pos) > list->len))
     1b0:	89 d3                	mov    %edx,%ebx
     1b2:	f7 db                	neg    %ebx
     1b4:	39 d9                	cmp    %ebx,%ecx
     1b6:	7c 18                	jl     1d0 <nodeAt+0x60>
    while (++pos != 0)
     1b8:	83 c2 01             	add    $0x1,%edx
    curNode = list->tail;
     1bb:	8b 40 04             	mov    0x4(%eax),%eax
    while (++pos != 0)
     1be:	74 da                	je     19a <nodeAt+0x2a>
     1c0:	83 c2 01             	add    $0x1,%edx
      curNode = curNode->prev;
     1c3:	8b 00                	mov    (%eax),%eax
    while (++pos != 0)
     1c5:	75 f9                	jne    1c0 <nodeAt+0x50>
}
     1c7:	5b                   	pop    %ebx
     1c8:	5d                   	pop    %ebp
     1c9:	c3                   	ret    
     1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return list->head->next;
     1d0:	8b 00                	mov    (%eax),%eax
     1d2:	8b 40 08             	mov    0x8(%eax),%eax
     1d5:	eb c3                	jmp    19a <nodeAt+0x2a>
     1d7:	89 f6                	mov    %esi,%esi
     1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001e0 <destroyNode>:

void destroyNode(struct LinkedList* list, struct Node* self) {
     1e0:	55                   	push   %ebp
     1e1:	89 e5                	mov    %esp,%ebp
     1e3:	56                   	push   %esi
     1e4:	53                   	push   %ebx
     1e5:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     1e8:	8b 75 08             	mov    0x8(%ebp),%esi
    self->prev->next = self->next;
    self->next->prev = self->prev;

    free(self->data);
     1eb:	83 ec 0c             	sub    $0xc,%esp
    self->prev->next = self->next;
     1ee:	8b 03                	mov    (%ebx),%eax
     1f0:	8b 53 08             	mov    0x8(%ebx),%edx
     1f3:	89 50 08             	mov    %edx,0x8(%eax)
    self->next->prev = self->prev;
     1f6:	8b 43 08             	mov    0x8(%ebx),%eax
     1f9:	8b 13                	mov    (%ebx),%edx
     1fb:	89 10                	mov    %edx,(%eax)
    free(self->data);
     1fd:	ff 73 04             	pushl  0x4(%ebx)
     200:	e8 cb 13 00 00       	call   15d0 <free>
    free(self);
     205:	89 1c 24             	mov    %ebx,(%esp)
     208:	e8 c3 13 00 00       	call   15d0 <free>
    list->len--;
     20d:	83 6e 08 01          	subl   $0x1,0x8(%esi)
}
     211:	83 c4 10             	add    $0x10,%esp
     214:	8d 65 f8             	lea    -0x8(%ebp),%esp
     217:	5b                   	pop    %ebx
     218:	5e                   	pop    %esi
     219:	5d                   	pop    %ebp
     21a:	c3                   	ret    
     21b:	90                   	nop
     21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000220 <MakeLinkedList>:

LinkedList* MakeLinkedList() {
     220:	55                   	push   %ebp
     221:	89 e5                	mov    %esp,%ebp
     223:	56                   	push   %esi
     224:	53                   	push   %ebx
  struct LinkedList* list = malloc(sizeof(LinkedList));
     225:	83 ec 0c             	sub    $0xc,%esp
     228:	6a 0c                	push   $0xc
     22a:	e8 31 14 00 00       	call   1660 <malloc>
  struct Node* node = malloc(sizeof(Node));
     22f:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  struct LinkedList* list = malloc(sizeof(LinkedList));
     236:	89 c6                	mov    %eax,%esi
  struct Node* node = malloc(sizeof(Node));
     238:	e8 23 14 00 00       	call   1660 <malloc>
     23d:	89 c3                	mov    %eax,%ebx
  node->prev = nullptr;
     23f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->data = data;
     245:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  node->next = nullptr;
     24c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  struct Node* node = malloc(sizeof(Node));
     253:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     25a:	e8 01 14 00 00       	call   1660 <malloc>
  node->data = data;
     25f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  Node* head = nullNode(nullptr);
  Node* tail = nullNode(nullptr);
  head->prev = nullptr;
  head->next = tail;
     266:	89 43 08             	mov    %eax,0x8(%ebx)
  head->prev = nullptr;
     269:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  tail->prev = head;
     26f:	89 18                	mov    %ebx,(%eax)
  tail->next = nullptr;
     271:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)

  list->len = 0;
  list->head = head;
  list->tail = tail;
     278:	89 46 04             	mov    %eax,0x4(%esi)
  return list;
}
     27b:	89 f0                	mov    %esi,%eax
  list->len = 0;
     27d:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
  list->head = head;
     284:	89 1e                	mov    %ebx,(%esi)
}
     286:	8d 65 f8             	lea    -0x8(%ebp),%esp
     289:	5b                   	pop    %ebx
     28a:	5e                   	pop    %esi
     28b:	5d                   	pop    %ebp
     28c:	c3                   	ret    
     28d:	8d 76 00             	lea    0x0(%esi),%esi

00000290 <insert>:

void insert(struct LinkedList* list, char* data, int pos) {
     290:	55                   	push   %ebp
     291:	89 e5                	mov    %esp,%ebp
     293:	57                   	push   %edi
     294:	56                   	push   %esi
     295:	53                   	push   %ebx
     296:	83 ec 0c             	sub    $0xc,%esp
  struct Node* atPos = nodeAt(list, pos);
     299:	ff 75 10             	pushl  0x10(%ebp)
     29c:	ff 75 08             	pushl  0x8(%ebp)
void insert(struct LinkedList* list, char* data, int pos) {
     29f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct Node* atPos = nodeAt(list, pos);
     2a2:	e8 c9 fe ff ff       	call   170 <nodeAt>
     2a7:	83 ec 04             	sub    $0x4,%esp
     2aa:	89 c6                	mov    %eax,%esi
  char* newData = (char*)malloc(sizeof(char) * 1000);
     2ac:	68 e8 03 00 00       	push   $0x3e8
     2b1:	e8 aa 13 00 00       	call   1660 <malloc>
     2b6:	8d 8b e7 03 00 00    	lea    0x3e7(%ebx),%ecx
     2bc:	89 c7                	mov    %eax,%edi
     2be:	83 c4 10             	add    $0x10,%esp
     2c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(--n > 0 && (*s++ = *t++) != 0)
     2c8:	83 c3 01             	add    $0x1,%ebx
     2cb:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     2cf:	83 c0 01             	add    $0x1,%eax
     2d2:	84 d2                	test   %dl,%dl
     2d4:	88 50 ff             	mov    %dl,-0x1(%eax)
     2d7:	74 04                	je     2dd <insert+0x4d>
     2d9:	39 d9                	cmp    %ebx,%ecx
     2db:	75 eb                	jne    2c8 <insert+0x38>
  newData = safestrcpy(newData, data, (sizeof(char) * 1000));
  struct Node* new = malloc(sizeof(Node));
     2dd:	83 ec 0c             	sub    $0xc,%esp
  *s = 0;
     2e0:	c6 00 00             	movb   $0x0,(%eax)
  struct Node* new = malloc(sizeof(Node));
     2e3:	6a 0c                	push   $0xc
     2e5:	e8 76 13 00 00       	call   1660 <malloc>

  new->data = newData;
     2ea:	89 78 04             	mov    %edi,0x4(%eax)
  new->prev = atPos->prev;
     2ed:	8b 16                	mov    (%esi),%edx
  new->next = atPos;
     2ef:	89 70 08             	mov    %esi,0x8(%eax)
  new->prev = atPos->prev;
     2f2:	89 10                	mov    %edx,(%eax)
  new->prev->next = new;
     2f4:	89 42 08             	mov    %eax,0x8(%edx)
  atPos->prev = new;
     2f7:	89 06                	mov    %eax,(%esi)
  list->len++;
     2f9:	8b 45 08             	mov    0x8(%ebp),%eax
     2fc:	83 40 08 01          	addl   $0x1,0x8(%eax)
}
     300:	8d 65 f4             	lea    -0xc(%ebp),%esp
     303:	5b                   	pop    %ebx
     304:	5e                   	pop    %esi
     305:	5f                   	pop    %edi
     306:	5d                   	pop    %ebp
     307:	c3                   	ret    
     308:	90                   	nop
     309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000310 <prepend>:

void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
     310:	55                   	push   %ebp
     311:	89 e5                	mov    %esp,%ebp
     313:	83 ec 0c             	sub    $0xc,%esp
     316:	6a 00                	push   $0x0
     318:	ff 75 0c             	pushl  0xc(%ebp)
     31b:	ff 75 08             	pushl  0x8(%ebp)
     31e:	e8 6d ff ff ff       	call   290 <insert>
     323:	83 c4 10             	add    $0x10,%esp
     326:	c9                   	leave  
     327:	c3                   	ret    
     328:	90                   	nop
     329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000330 <append>:
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     330:	55                   	push   %ebp
     331:	89 e5                	mov    %esp,%ebp
     333:	83 ec 0c             	sub    $0xc,%esp
     336:	8b 45 08             	mov    0x8(%ebp),%eax
     339:	ff 70 08             	pushl  0x8(%eax)
     33c:	ff 75 0c             	pushl  0xc(%ebp)
     33f:	50                   	push   %eax
     340:	e8 4b ff ff ff       	call   290 <insert>
     345:	83 c4 10             	add    $0x10,%esp
     348:	c9                   	leave  
     349:	c3                   	ret    
     34a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000350 <destroyLinkedList>:

void destroyLinkedList(struct LinkedList* list) {
     350:	55                   	push   %ebp
     351:	89 e5                	mov    %esp,%ebp
     353:	56                   	push   %esi
     354:	53                   	push   %ebx
     355:	8b 75 08             	mov    0x8(%ebp),%esi
  struct Node* curNode = list->head;
     358:	8b 1e                	mov    (%esi),%ebx
  while (curNode != list->tail) {
     35a:	8b 46 04             	mov    0x4(%esi),%eax
     35d:	39 c3                	cmp    %eax,%ebx
     35f:	74 29                	je     38a <destroyLinkedList+0x3a>
     361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
     368:	8b 5b 08             	mov    0x8(%ebx),%ebx
    free(curNode->prev->data);
     36b:	83 ec 0c             	sub    $0xc,%esp
     36e:	8b 03                	mov    (%ebx),%eax
     370:	ff 70 04             	pushl  0x4(%eax)
     373:	e8 58 12 00 00       	call   15d0 <free>
    free(curNode->prev);
     378:	58                   	pop    %eax
     379:	ff 33                	pushl  (%ebx)
     37b:	e8 50 12 00 00       	call   15d0 <free>
  while (curNode != list->tail) {
     380:	8b 46 04             	mov    0x4(%esi),%eax
     383:	83 c4 10             	add    $0x10,%esp
     386:	39 d8                	cmp    %ebx,%eax
     388:	75 de                	jne    368 <destroyLinkedList+0x18>
  }
  free(curNode);
     38a:	83 ec 0c             	sub    $0xc,%esp
     38d:	50                   	push   %eax
     38e:	e8 3d 12 00 00       	call   15d0 <free>
  free(list);
     393:	89 75 08             	mov    %esi,0x8(%ebp)
     396:	83 c4 10             	add    $0x10,%esp
     399:	8d 65 f8             	lea    -0x8(%ebp),%esp
     39c:	5b                   	pop    %ebx
     39d:	5e                   	pop    %esi
     39e:	5d                   	pop    %ebp
  free(list);
     39f:	e9 2c 12 00 00       	jmp    15d0 <free>
     3a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     3aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003b0 <confirmation>:
#include "helpers.h"

int confirmation() {
     3b0:	55                   	push   %ebp
     3b1:	89 e5                	mov    %esp,%ebp
     3b3:	53                   	push   %ebx
  // get response
  char buf[MAXLINESIZE];
  int nbuf = sizeof(buf);
  memset(buf, 0, nbuf);
     3b4:	8d 9d 10 fc ff ff    	lea    -0x3f0(%ebp),%ebx
int confirmation() {
     3ba:	81 ec f8 03 00 00    	sub    $0x3f8,%esp
  memset(buf, 0, nbuf);
     3c0:	68 e8 03 00 00       	push   $0x3e8
     3c5:	6a 00                	push   $0x0
     3c7:	53                   	push   %ebx
     3c8:	e8 b3 0c 00 00       	call   1080 <memset>
  gets(buf, nbuf);
     3cd:	58                   	pop    %eax
     3ce:	5a                   	pop    %edx
     3cf:	68 e8 03 00 00       	push   $0x3e8
     3d4:	53                   	push   %ebx
     3d5:	e8 06 0d 00 00       	call   10e0 <gets>
  // determine output
  switch (buf[0]) {
     3da:	0f b6 85 10 fc ff ff 	movzbl -0x3f0(%ebp),%eax
     3e1:	83 c4 10             	add    $0x10,%esp
     3e4:	3c 59                	cmp    $0x59,%al
     3e6:	74 18                	je     400 <confirmation+0x50>
     3e8:	3c 79                	cmp    $0x79,%al
     3ea:	74 14                	je     400 <confirmation+0x50>
  case 'Y':
  case 'y':
    return 0;
  default:
    return 1;
     3ec:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
     3f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3f4:	c9                   	leave  
     3f5:	c3                   	ret    
     3f6:	8d 76 00             	lea    0x0(%esi),%esi
     3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return 0;
     400:	31 c0                	xor    %eax,%eax
}
     402:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     405:	c9                   	leave  
     406:	c3                   	ret    
     407:	89 f6                	mov    %esi,%esi
     409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000410 <normalizeRange>:
    return 1;

  return 0;
}

int normalizeRange(File file, int* sp, int* ep) {
     410:	55                   	push   %ebp
     411:	89 e5                	mov    %esp,%ebp
     413:	53                   	push   %ebx
     414:	8b 4d 24             	mov    0x24(%ebp),%ecx
  int l = file.len;
     417:	8b 45 18             	mov    0x18(%ebp),%eax
int normalizeRange(File file, int* sp, int* ep) {
     41a:	8b 5d 20             	mov    0x20(%ebp),%ebx
  if (*ep > l) *ep = l;
     41d:	8b 11                	mov    (%ecx),%edx
     41f:	39 c2                	cmp    %eax,%edx
     421:	7e 45                	jle    468 <normalizeRange+0x58>
     423:	89 01                	mov    %eax,(%ecx)
     425:	89 c2                	mov    %eax,%edx
  else if (*ep < 1) *ep += l + 1;
  if (*ep < 1) *ep = 1;
     427:	85 d2                	test   %edx,%edx
     429:	7f 06                	jg     431 <normalizeRange+0x21>
     42b:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)

  if (*sp > l) *sp = l;
     431:	8b 13                	mov    (%ebx),%edx
     433:	39 c2                	cmp    %eax,%edx
     435:	7e 21                	jle    458 <normalizeRange+0x48>
     437:	89 03                	mov    %eax,(%ebx)
     439:	89 c2                	mov    %eax,%edx
  else if (*sp < 1) *sp += l + 1;
  if (*sp < 1) *sp = 1;
     43b:	85 d2                	test   %edx,%edx
     43d:	7f 0b                	jg     44a <normalizeRange+0x3a>
     43f:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
     445:	ba 01 00 00 00       	mov    $0x1,%edx
  if ((*ep - *sp) < 0)
     44a:	8b 01                	mov    (%ecx),%eax
    return 1;
  return 0;
}
     44c:	5b                   	pop    %ebx
     44d:	5d                   	pop    %ebp
  if ((*ep - *sp) < 0)
     44e:	29 d0                	sub    %edx,%eax
     450:	c1 e8 1f             	shr    $0x1f,%eax
}
     453:	c3                   	ret    
     454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*sp < 1) *sp += l + 1;
     458:	85 d2                	test   %edx,%edx
     45a:	7f ee                	jg     44a <normalizeRange+0x3a>
     45c:	8d 54 10 01          	lea    0x1(%eax,%edx,1),%edx
     460:	89 13                	mov    %edx,(%ebx)
     462:	eb d7                	jmp    43b <normalizeRange+0x2b>
     464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*ep < 1) *ep += l + 1;
     468:	85 d2                	test   %edx,%edx
     46a:	7f c5                	jg     431 <normalizeRange+0x21>
     46c:	8d 54 02 01          	lea    0x1(%edx,%eax,1),%edx
     470:	89 11                	mov    %edx,(%ecx)
     472:	eb b3                	jmp    427 <normalizeRange+0x17>
     474:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     47a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000480 <numLines>:

int numLines(int start, int end) {
     480:	55                   	push   %ebp
     481:	89 e5                	mov    %esp,%ebp
  return (end - start) + 1;
     483:	8b 45 0c             	mov    0xc(%ebp),%eax
     486:	2b 45 08             	sub    0x8(%ebp),%eax
}
     489:	5d                   	pop    %ebp
  return (end - start) + 1;
     48a:	83 c0 01             	add    $0x1,%eax
}
     48d:	c3                   	ret    
     48e:	66 90                	xchg   %ax,%ax

00000490 <getLine>:
    file->len++;
  }
  fprintf(2, "%d lines read from %s\n", file->len, file->filename);
}

int getLine(int fileptr, char line[]) {
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	57                   	push   %edi
     494:	56                   	push   %esi
     495:	53                   	push   %ebx
  int len = strlen(line);
  memset(line, 0, len);
  char c[1];
  int i;
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     496:	31 ff                	xor    %edi,%edi
     498:	8d 75 e7             	lea    -0x19(%ebp),%esi
int getLine(int fileptr, char line[]) {
     49b:	83 ec 28             	sub    $0x28,%esp
     49e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int len = strlen(line);
     4a1:	53                   	push   %ebx
     4a2:	e8 a9 0b 00 00       	call   1050 <strlen>
  memset(line, 0, len);
     4a7:	83 c4 0c             	add    $0xc,%esp
     4aa:	50                   	push   %eax
     4ab:	6a 00                	push   $0x0
     4ad:	53                   	push   %ebx
     4ae:	e8 cd 0b 00 00       	call   1080 <memset>
     4b3:	83 c4 10             	add    $0x10,%esp
     4b6:	eb 1e                	jmp    4d6 <getLine+0x46>
     4b8:	90                   	nop
     4b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (read(fileptr, c, 1) == 0) return strlen(line);
    if (*c == '\n') break;
     4c0:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     4c4:	3c 0a                	cmp    $0xa,%al
     4c6:	74 38                	je     500 <getLine+0x70>
    line[i] = *c;
     4c8:	88 04 3b             	mov    %al,(%ebx,%edi,1)
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     4cb:	83 c7 01             	add    $0x1,%edi
     4ce:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
     4d4:	74 42                	je     518 <getLine+0x88>
    if (read(fileptr, c, 1) == 0) return strlen(line);
     4d6:	83 ec 04             	sub    $0x4,%esp
     4d9:	6a 01                	push   $0x1
     4db:	56                   	push   %esi
     4dc:	ff 75 08             	pushl  0x8(%ebp)
     4df:	e8 56 0d 00 00       	call   123a <read>
     4e4:	83 c4 10             	add    $0x10,%esp
     4e7:	85 c0                	test   %eax,%eax
     4e9:	75 d5                	jne    4c0 <getLine+0x30>
     4eb:	83 ec 0c             	sub    $0xc,%esp
     4ee:	53                   	push   %ebx
     4ef:	e8 5c 0b 00 00       	call   1050 <strlen>
     4f4:	83 c4 10             	add    $0x10,%esp
  }
  line[i + 1] = '\0';
  return 1;
}
     4f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     4fa:	5b                   	pop    %ebx
     4fb:	5e                   	pop    %esi
     4fc:	5f                   	pop    %edi
     4fd:	5d                   	pop    %ebp
     4fe:	c3                   	ret    
     4ff:	90                   	nop
     500:	8d 57 01             	lea    0x1(%edi),%edx
  line[i + 1] = '\0';
     503:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
     507:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
     50a:	b8 01 00 00 00       	mov    $0x1,%eax
}
     50f:	5b                   	pop    %ebx
     510:	5e                   	pop    %esi
     511:	5f                   	pop    %edi
     512:	5d                   	pop    %ebp
     513:	c3                   	ret    
     514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     518:	ba e8 03 00 00       	mov    $0x3e8,%edx
     51d:	eb e4                	jmp    503 <getLine+0x73>
     51f:	90                   	nop

00000520 <gatherLines>:
void gatherLines(File* file) {
     520:	55                   	push   %ebp
     521:	89 e5                	mov    %esp,%ebp
     523:	56                   	push   %esi
     524:	53                   	push   %ebx
     525:	8d b5 10 fc ff ff    	lea    -0x3f0(%ebp),%esi
     52b:	81 ec f0 03 00 00    	sub    $0x3f0,%esp
     531:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while (getLine(file->fd, line)) {
     534:	eb 21                	jmp    557 <gatherLines+0x37>
     536:	8d 76 00             	lea    0x0(%esi),%esi
     539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    append(file->lines, line);
     540:	8b 43 0c             	mov    0xc(%ebx),%eax
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     543:	83 ec 04             	sub    $0x4,%esp
     546:	ff 70 08             	pushl  0x8(%eax)
     549:	56                   	push   %esi
     54a:	50                   	push   %eax
     54b:	e8 40 fd ff ff       	call   290 <insert>
    file->len++;
     550:	83 43 10 01          	addl   $0x1,0x10(%ebx)
     554:	83 c4 10             	add    $0x10,%esp
  while (getLine(file->fd, line)) {
     557:	83 ec 08             	sub    $0x8,%esp
     55a:	56                   	push   %esi
     55b:	ff 73 04             	pushl  0x4(%ebx)
     55e:	e8 2d ff ff ff       	call   490 <getLine>
     563:	83 c4 10             	add    $0x10,%esp
     566:	85 c0                	test   %eax,%eax
     568:	75 d6                	jne    540 <gatherLines+0x20>
  fprintf(2, "%d lines read from %s\n", file->len, file->filename);
     56a:	ff 33                	pushl  (%ebx)
     56c:	ff 73 10             	pushl  0x10(%ebx)
     56f:	68 58 17 00 00       	push   $0x1758
     574:	6a 02                	push   $0x2
     576:	e8 15 10 00 00       	call   1590 <fprintf>
}
     57b:	83 c4 10             	add    $0x10,%esp
     57e:	8d 65 f8             	lea    -0x8(%ebp),%esp
     581:	5b                   	pop    %ebx
     582:	5e                   	pop    %esi
     583:	5d                   	pop    %ebp
     584:	c3                   	ret    
     585:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000590 <unline>:
  int end = find(args, delimiter);
  substr(dest, args, 0, end);
  substr(args, args, end + 1, (int) strlen(args));
}

void unline(char* str) {
     590:	55                   	push   %ebp
     591:	89 e5                	mov    %esp,%ebp
     593:	53                   	push   %ebx
     594:	83 ec 10             	sub    $0x10,%esp
     597:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str) - 1;
     59a:	53                   	push   %ebx
     59b:	e8 b0 0a 00 00       	call   1050 <strlen>
     5a0:	8d 50 ff             	lea    -0x1(%eax),%edx
  for (; len > 0; len--) {
     5a3:	83 c4 10             	add    $0x10,%esp
     5a6:	85 d2                	test   %edx,%edx
     5a8:	7e 36                	jle    5e0 <unline+0x50>
    char c = str[len];
    if (c == '\n')
     5aa:	80 7c 03 ff 0a       	cmpb   $0xa,-0x1(%ebx,%eax,1)
     5af:	74 2f                	je     5e0 <unline+0x50>
     5b1:	8d 44 03 fe          	lea    -0x2(%ebx,%eax,1),%eax
     5b5:	eb 12                	jmp    5c9 <unline+0x39>
     5b7:	89 f6                	mov    %esi,%esi
     5b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     5c0:	83 e8 01             	sub    $0x1,%eax
     5c3:	80 78 01 0a          	cmpb   $0xa,0x1(%eax)
     5c7:	74 06                	je     5cf <unline+0x3f>
  for (; len > 0; len--) {
     5c9:	39 c3                	cmp    %eax,%ebx
     5cb:	89 c2                	mov    %eax,%edx
     5cd:	75 f1                	jne    5c0 <unline+0x30>
      break;
  }
  str[len] = '\0';
     5cf:	c6 02 00             	movb   $0x0,(%edx)
}
     5d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5d5:	c9                   	leave  
     5d6:	c3                   	ret    
     5d7:	89 f6                	mov    %esi,%esi
     5d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     5e0:	01 da                	add    %ebx,%edx
  str[len] = '\0';
     5e2:	c6 02 00             	movb   $0x0,(%edx)
}
     5e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5e8:	c9                   	leave  
     5e9:	c3                   	ret    
     5ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005f0 <find>:


// str ops
int find(char* str, char c) {
     5f0:	55                   	push   %ebp
     5f1:	89 e5                	mov    %esp,%ebp
     5f3:	57                   	push   %edi
     5f4:	56                   	push   %esi
     5f5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     5f6:	31 db                	xor    %ebx,%ebx
int find(char* str, char c) {
     5f8:	83 ec 0c             	sub    $0xc,%esp
     5fb:	8b 75 08             	mov    0x8(%ebp),%esi
     5fe:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
  for (int i = 0; i < strlen(str); i++)
     602:	eb 0e                	jmp    612 <find+0x22>
     604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     608:	89 f8                	mov    %edi,%eax
     60a:	38 04 1e             	cmp    %al,(%esi,%ebx,1)
     60d:	74 18                	je     627 <find+0x37>
  for (int i = 0; i < strlen(str); i++)
     60f:	83 c3 01             	add    $0x1,%ebx
     612:	83 ec 0c             	sub    $0xc,%esp
     615:	56                   	push   %esi
     616:	e8 35 0a 00 00       	call   1050 <strlen>
     61b:	83 c4 10             	add    $0x10,%esp
     61e:	39 d8                	cmp    %ebx,%eax
     620:	77 e6                	ja     608 <find+0x18>
  return -1;
     622:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
     627:	8d 65 f4             	lea    -0xc(%ebp),%esp
     62a:	89 d8                	mov    %ebx,%eax
     62c:	5b                   	pop    %ebx
     62d:	5e                   	pop    %esi
     62e:	5f                   	pop    %edi
     62f:	5d                   	pop    %ebp
     630:	c3                   	ret    
     631:	eb 0d                	jmp    640 <substr>
     633:	90                   	nop
     634:	90                   	nop
     635:	90                   	nop
     636:	90                   	nop
     637:	90                   	nop
     638:	90                   	nop
     639:	90                   	nop
     63a:	90                   	nop
     63b:	90                   	nop
     63c:	90                   	nop
     63d:	90                   	nop
     63e:	90                   	nop
     63f:	90                   	nop

00000640 <substr>:

void substr(char* dest, char* str, int start, int end) {
     640:	55                   	push   %ebp
     641:	89 e5                	mov    %esp,%ebp
     643:	57                   	push   %edi
     644:	56                   	push   %esi
     645:	53                   	push   %ebx
     646:	83 ec 18             	sub    $0x18,%esp
     649:	8b 7d 14             	mov    0x14(%ebp),%edi
  int len = strlen(str);
     64c:	ff 75 0c             	pushl  0xc(%ebp)
void substr(char* dest, char* str, int start, int end) {
     64f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     652:	8b 75 08             	mov    0x8(%ebp),%esi
  int len = strlen(str);
     655:	e8 f6 09 00 00       	call   1050 <strlen>
     65a:	83 c4 10             	add    $0x10,%esp
     65d:	39 f8                	cmp    %edi,%eax
     65f:	0f 4e f8             	cmovle %eax,%edi
  if (end > len) end = len;
  int s = 0, i = start;
  while (i < end)
     662:	39 df                	cmp    %ebx,%edi
     664:	7e 1c                	jle    682 <substr+0x42>
     666:	8b 45 0c             	mov    0xc(%ebp),%eax
     669:	29 df                	sub    %ebx,%edi
  int s = 0, i = start;
     66b:	31 d2                	xor    %edx,%edx
     66d:	01 c3                	add    %eax,%ebx
     66f:	90                   	nop
    dest[s++] = str[i++];
     670:	83 c2 01             	add    $0x1,%edx
     673:	0f b6 44 13 ff       	movzbl -0x1(%ebx,%edx,1),%eax
  while (i < end)
     678:	39 fa                	cmp    %edi,%edx
    dest[s++] = str[i++];
     67a:	88 44 16 ff          	mov    %al,-0x1(%esi,%edx,1)
  while (i < end)
     67e:	75 f0                	jne    670 <substr+0x30>
     680:	01 d6                	add    %edx,%esi
  dest[s] = '\0';
     682:	c6 06 00             	movb   $0x0,(%esi)
}
     685:	8d 65 f4             	lea    -0xc(%ebp),%esp
     688:	5b                   	pop    %ebx
     689:	5e                   	pop    %esi
     68a:	5f                   	pop    %edi
     68b:	5d                   	pop    %ebp
     68c:	c3                   	ret    
     68d:	8d 76 00             	lea    0x0(%esi),%esi

00000690 <getArg>:
void getArg(char* dest, char* args, char delimiter) {
     690:	55                   	push   %ebp
     691:	89 e5                	mov    %esp,%ebp
     693:	57                   	push   %edi
     694:	56                   	push   %esi
     695:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     696:	31 db                	xor    %ebx,%ebx
void getArg(char* dest, char* args, char delimiter) {
     698:	83 ec 1c             	sub    $0x1c,%esp
     69b:	8b 75 0c             	mov    0xc(%ebp),%esi
     69e:	0f b6 7d 10          	movzbl 0x10(%ebp),%edi
     6a2:	eb 10                	jmp    6b4 <getArg+0x24>
     6a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     6a8:	89 f8                	mov    %edi,%eax
     6aa:	3a 04 1e             	cmp    (%esi,%ebx,1),%al
     6ad:	8d 53 01             	lea    0x1(%ebx),%edx
     6b0:	74 19                	je     6cb <getArg+0x3b>
     6b2:	89 d3                	mov    %edx,%ebx
  for (int i = 0; i < strlen(str); i++)
     6b4:	83 ec 0c             	sub    $0xc,%esp
     6b7:	56                   	push   %esi
     6b8:	e8 93 09 00 00       	call   1050 <strlen>
     6bd:	83 c4 10             	add    $0x10,%esp
     6c0:	39 c3                	cmp    %eax,%ebx
     6c2:	72 e4                	jb     6a8 <getArg+0x18>
     6c4:	31 d2                	xor    %edx,%edx
  return -1;
     6c6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  substr(dest, args, 0, end);
     6cb:	53                   	push   %ebx
     6cc:	6a 00                	push   $0x0
     6ce:	56                   	push   %esi
     6cf:	ff 75 08             	pushl  0x8(%ebp)
     6d2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     6d5:	e8 66 ff ff ff       	call   640 <substr>
  substr(args, args, end + 1, (int) strlen(args));
     6da:	89 34 24             	mov    %esi,(%esp)
     6dd:	e8 6e 09 00 00       	call   1050 <strlen>
     6e2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     6e5:	50                   	push   %eax
     6e6:	52                   	push   %edx
     6e7:	56                   	push   %esi
     6e8:	56                   	push   %esi
     6e9:	e8 52 ff ff ff       	call   640 <substr>
}
     6ee:	83 c4 20             	add    $0x20,%esp
     6f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6f4:	5b                   	pop    %ebx
     6f5:	5e                   	pop    %esi
     6f6:	5f                   	pop    %edi
     6f7:	5d                   	pop    %ebp
     6f8:	c3                   	ret    
     6f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000700 <collectRange>:
int collectRange(char* args, int* startptr, int* endptr) {
     700:	55                   	push   %ebp
     701:	89 e5                	mov    %esp,%ebp
     703:	57                   	push   %edi
     704:	56                   	push   %esi
     705:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     706:	31 f6                	xor    %esi,%esi
int collectRange(char* args, int* startptr, int* endptr) {
     708:	83 ec 2c             	sub    $0x2c,%esp
     70b:	8b 5d 08             	mov    0x8(%ebp),%ebx
     70e:	eb 09                	jmp    719 <collectRange+0x19>
    if (str[i] == c) return i;
     710:	80 3c 33 3a          	cmpb   $0x3a,(%ebx,%esi,1)
     714:	74 42                	je     758 <collectRange+0x58>
  for (int i = 0; i < strlen(str); i++)
     716:	83 c6 01             	add    $0x1,%esi
     719:	83 ec 0c             	sub    $0xc,%esp
     71c:	53                   	push   %ebx
     71d:	e8 2e 09 00 00       	call   1050 <strlen>
     722:	83 c4 10             	add    $0x10,%esp
     725:	39 c6                	cmp    %eax,%esi
     727:	72 e7                	jb     710 <collectRange+0x10>
    if (args[0] == '-') {
     729:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     72c:	0f 84 d6 00 00 00    	je     808 <collectRange+0x108>
      *startptr = atoi(args);
     732:	83 ec 0c             	sub    $0xc,%esp
     735:	53                   	push   %ebx
     736:	e8 75 0a 00 00       	call   11b0 <atoi>
     73b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     73e:	83 c4 10             	add    $0x10,%esp
     741:	89 01                	mov    %eax,(%ecx)
    *endptr = *startptr;
     743:	8b 4d 10             	mov    0x10(%ebp),%ecx
     746:	89 01                	mov    %eax,(%ecx)
    return 0;
     748:	31 c0                	xor    %eax,%eax
}
     74a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     74d:	5b                   	pop    %ebx
     74e:	5e                   	pop    %esi
     74f:	5f                   	pop    %edi
     750:	5d                   	pop    %ebp
     751:	c3                   	ret    
     752:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  getArg(startstr, args, ':');
     758:	8d 75 de             	lea    -0x22(%ebp),%esi
     75b:	83 ec 04             	sub    $0x4,%esp
     75e:	6a 3a                	push   $0x3a
     760:	53                   	push   %ebx
     761:	56                   	push   %esi
     762:	e8 29 ff ff ff       	call   690 <getArg>
  if (startstr[0] == '-') {
     767:	83 c4 10             	add    $0x10,%esp
     76a:	80 7d de 2d          	cmpb   $0x2d,-0x22(%ebp)
     76e:	0f 84 3c 01 00 00    	je     8b0 <collectRange+0x1b0>
  int negStartFlag = 0, negEndFlag = 0;
     774:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     77b:	31 ff                	xor    %edi,%edi
  if (endstr[0] == '-') {
     77d:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     780:	0f 84 0a 01 00 00    	je     890 <collectRange+0x190>
  if (strcmp(startstr, "\0") == 0) *startptr = 1;
     786:	83 ec 08             	sub    $0x8,%esp
     789:	68 41 18 00 00       	push   $0x1841
     78e:	56                   	push   %esi
     78f:	e8 6c 08 00 00       	call   1000 <strcmp>
     794:	83 c4 10             	add    $0x10,%esp
     797:	85 c0                	test   %eax,%eax
     799:	0f 85 d1 00 00 00    	jne    870 <collectRange+0x170>
     79f:	8b 45 0c             	mov    0xc(%ebp),%eax
     7a2:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  if (strcmp(endstr, "\0") == 0) *endptr = -1;
     7a8:	83 ec 08             	sub    $0x8,%esp
     7ab:	68 41 18 00 00       	push   $0x1841
     7b0:	53                   	push   %ebx
     7b1:	e8 4a 08 00 00       	call   1000 <strcmp>
     7b6:	83 c4 10             	add    $0x10,%esp
     7b9:	85 c0                	test   %eax,%eax
     7bb:	0f 85 97 00 00 00    	jne    858 <collectRange+0x158>
     7c1:	8b 45 10             	mov    0x10(%ebp),%eax
     7c4:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  if (negStartFlag) *startptr = 0 - *startptr;
     7ca:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7cd:	85 c0                	test   %eax,%eax
     7cf:	74 05                	je     7d6 <collectRange+0xd6>
     7d1:	8b 45 0c             	mov    0xc(%ebp),%eax
     7d4:	f7 18                	negl   (%eax)
  if (negEndFlag) *endptr = 0 - *endptr;
     7d6:	85 ff                	test   %edi,%edi
     7d8:	74 05                	je     7df <collectRange+0xdf>
     7da:	8b 45 10             	mov    0x10(%ebp),%eax
     7dd:	f7 18                	negl   (%eax)
  if (((*startptr > 0 && *endptr > 0) || 
     7df:	8b 45 0c             	mov    0xc(%ebp),%eax
     7e2:	8b 00                	mov    (%eax),%eax
     7e4:	83 f8 00             	cmp    $0x0,%eax
     7e7:	7e 4f                	jle    838 <collectRange+0x138>
     7e9:	8b 55 10             	mov    0x10(%ebp),%edx
     7ec:	8b 12                	mov    (%edx),%edx
     7ee:	85 d2                	test   %edx,%edx
     7f0:	7e 55                	jle    847 <collectRange+0x147>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     7f2:	39 d0                	cmp    %edx,%eax
     7f4:	0f 9f c0             	setg   %al
}
     7f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     7fa:	0f b6 c0             	movzbl %al,%eax
}
     7fd:	5b                   	pop    %ebx
     7fe:	5e                   	pop    %esi
     7ff:	5f                   	pop    %edi
     800:	5d                   	pop    %ebp
     801:	c3                   	ret    
     802:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      substr(args, args, 1, strlen(args));
     808:	83 ec 0c             	sub    $0xc,%esp
     80b:	53                   	push   %ebx
     80c:	e8 3f 08 00 00       	call   1050 <strlen>
     811:	50                   	push   %eax
     812:	6a 01                	push   $0x1
     814:	53                   	push   %ebx
     815:	53                   	push   %ebx
     816:	e8 25 fe ff ff       	call   640 <substr>
      *startptr = 0 - atoi(args);
     81b:	83 c4 14             	add    $0x14,%esp
     81e:	53                   	push   %ebx
     81f:	e8 8c 09 00 00       	call   11b0 <atoi>
     824:	8b 7d 0c             	mov    0xc(%ebp),%edi
     827:	f7 d8                	neg    %eax
     829:	83 c4 10             	add    $0x10,%esp
     82c:	89 07                	mov    %eax,(%edi)
     82e:	e9 10 ff ff ff       	jmp    743 <collectRange+0x43>
     833:	90                   	nop
     834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (((*startptr > 0 && *endptr > 0) || 
     838:	0f 84 0c ff ff ff    	je     74a <collectRange+0x4a>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     83e:	8b 7d 10             	mov    0x10(%ebp),%edi
     841:	8b 17                	mov    (%edi),%edx
     843:	85 d2                	test   %edx,%edx
     845:	78 ab                	js     7f2 <collectRange+0xf2>
}
     847:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
     84a:	31 c0                	xor    %eax,%eax
}
     84c:	5b                   	pop    %ebx
     84d:	5e                   	pop    %esi
     84e:	5f                   	pop    %edi
     84f:	5d                   	pop    %ebp
     850:	c3                   	ret    
     851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else *endptr = atoi(endstr);
     858:	83 ec 0c             	sub    $0xc,%esp
     85b:	53                   	push   %ebx
     85c:	e8 4f 09 00 00       	call   11b0 <atoi>
     861:	8b 55 10             	mov    0x10(%ebp),%edx
     864:	83 c4 10             	add    $0x10,%esp
     867:	89 02                	mov    %eax,(%edx)
     869:	e9 5c ff ff ff       	jmp    7ca <collectRange+0xca>
     86e:	66 90                	xchg   %ax,%ax
  else *startptr = atoi(startstr);
     870:	83 ec 0c             	sub    $0xc,%esp
     873:	56                   	push   %esi
     874:	e8 37 09 00 00       	call   11b0 <atoi>
     879:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     87c:	83 c4 10             	add    $0x10,%esp
     87f:	89 01                	mov    %eax,(%ecx)
     881:	e9 22 ff ff ff       	jmp    7a8 <collectRange+0xa8>
     886:	8d 76 00             	lea    0x0(%esi),%esi
     889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    substr(endstr, endstr, 1, strlen(endstr));
     890:	83 ec 0c             	sub    $0xc,%esp
    negEndFlag = 1;
     893:	bf 01 00 00 00       	mov    $0x1,%edi
    substr(endstr, endstr, 1, strlen(endstr));
     898:	53                   	push   %ebx
     899:	e8 b2 07 00 00       	call   1050 <strlen>
     89e:	50                   	push   %eax
     89f:	6a 01                	push   $0x1
     8a1:	53                   	push   %ebx
     8a2:	53                   	push   %ebx
     8a3:	e8 98 fd ff ff       	call   640 <substr>
     8a8:	83 c4 20             	add    $0x20,%esp
     8ab:	e9 d6 fe ff ff       	jmp    786 <collectRange+0x86>
    substr(startstr, startstr, 1, strlen(startstr));
     8b0:	83 ec 0c             	sub    $0xc,%esp
     8b3:	56                   	push   %esi
     8b4:	e8 97 07 00 00       	call   1050 <strlen>
     8b9:	50                   	push   %eax
     8ba:	6a 01                	push   $0x1
     8bc:	56                   	push   %esi
     8bd:	56                   	push   %esi
     8be:	e8 7d fd ff ff       	call   640 <substr>
     8c3:	83 c4 20             	add    $0x20,%esp
    negStartFlag = 1;
     8c6:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
     8cd:	e9 a9 fe ff ff       	jmp    77b <collectRange+0x7b>
     8d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     8d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008e0 <negatoi>:


// standard str helps
int negatoi(char* str) {
     8e0:	55                   	push   %ebp
     8e1:	89 e5                	mov    %esp,%ebp
     8e3:	53                   	push   %ebx
     8e4:	83 ec 04             	sub    $0x4,%esp
     8e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (str[0] == '-') {
     8ea:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     8ed:	74 11                	je     900 <negatoi+0x20>
    substr(str, str, 1, strlen(str));
    return 0 - atoi(str);
  }
  return atoi(str);
}
     8ef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8f2:	c9                   	leave  
  return atoi(str);
     8f3:	e9 b8 08 00 00       	jmp    11b0 <atoi>
     8f8:	90                   	nop
     8f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    substr(str, str, 1, strlen(str));
     900:	83 ec 0c             	sub    $0xc,%esp
     903:	53                   	push   %ebx
     904:	e8 47 07 00 00       	call   1050 <strlen>
     909:	50                   	push   %eax
     90a:	6a 01                	push   $0x1
     90c:	53                   	push   %ebx
     90d:	53                   	push   %ebx
     90e:	e8 2d fd ff ff       	call   640 <substr>
    return 0 - atoi(str);
     913:	83 c4 14             	add    $0x14,%esp
     916:	53                   	push   %ebx
     917:	e8 94 08 00 00       	call   11b0 <atoi>
     91c:	83 c4 10             	add    $0x10,%esp
     91f:	f7 d8                	neg    %eax
}
     921:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     924:	c9                   	leave  
     925:	c3                   	ret    
     926:	8d 76 00             	lea    0x0(%esi),%esi
     929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000930 <toUpper>:

void toUpper(char* str) {
     930:	55                   	push   %ebp
     931:	89 e5                	mov    %esp,%ebp
     933:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     936:	0f b6 02             	movzbl (%edx),%eax
     939:	84 c0                	test   %al,%al
     93b:	74 1a                	je     957 <toUpper+0x27>
     93d:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'z' && c >= 'a')
     940:	8d 48 9f             	lea    -0x61(%eax),%ecx
     943:	80 f9 19             	cmp    $0x19,%cl
     946:	77 05                	ja     94d <toUpper+0x1d>
      str[i] += ('Z' - 'z');
     948:	83 e8 20             	sub    $0x20,%eax
     94b:	88 02                	mov    %al,(%edx)
     94d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     950:	0f b6 02             	movzbl (%edx),%eax
     953:	84 c0                	test   %al,%al
     955:	75 e9                	jne    940 <toUpper+0x10>
    i++;  
  }
}
     957:	5d                   	pop    %ebp
     958:	c3                   	ret    
     959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000960 <toLower>:

void toLower(char* str) {
     960:	55                   	push   %ebp
     961:	89 e5                	mov    %esp,%ebp
     963:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     966:	0f b6 02             	movzbl (%edx),%eax
     969:	84 c0                	test   %al,%al
     96b:	74 1a                	je     987 <toLower+0x27>
     96d:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'Z' && c >= 'A')
     970:	8d 48 bf             	lea    -0x41(%eax),%ecx
     973:	80 f9 19             	cmp    $0x19,%cl
     976:	77 05                	ja     97d <toLower+0x1d>
      str[i] -= ('Z' - 'z');
     978:	83 c0 20             	add    $0x20,%eax
     97b:	88 02                	mov    %al,(%edx)
     97d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     980:	0f b6 02             	movzbl (%edx),%eax
     983:	84 c0                	test   %al,%al
     985:	75 e9                	jne    970 <toLower+0x10>
    i++;  
  }
}
     987:	5d                   	pop    %ebp
     988:	c3                   	ret    
     989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000990 <lineAt>:

// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
     990:	55                   	push   %ebp
     991:	89 e5                	mov    %esp,%ebp
  return nodeAt(list, pos-1);
     993:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
}
     997:	5d                   	pop    %ebp
  return nodeAt(list, pos-1);
     998:	e9 d3 f7 ff ff       	jmp    170 <nodeAt>
     99d:	8d 76 00             	lea    0x0(%esi),%esi

000009a0 <printl>:

void printl(int lineNum, char* line) {
     9a0:	55                   	push   %ebp
     9a1:	89 e5                	mov    %esp,%ebp
     9a3:	83 ec 08             	sub    $0x8,%esp
     9a6:	8b 45 08             	mov    0x8(%ebp),%eax
  if (lineNum < 10)
     9a9:	83 f8 09             	cmp    $0x9,%eax
     9ac:	7e 3a                	jle    9e8 <printl+0x48>
    fprintf(2, "%d  : %s\n", lineNum, line);
  else if (lineNum < 100)
     9ae:	83 f8 63             	cmp    $0x63,%eax
     9b1:	7e 1d                	jle    9d0 <printl+0x30>
    fprintf(2, "%d : %s\n", lineNum, line);
  else
    fprintf(2, "%d: %s\n", lineNum, line);
     9b3:	ff 75 0c             	pushl  0xc(%ebp)
     9b6:	50                   	push   %eax
     9b7:	68 82 17 00 00       	push   $0x1782
     9bc:	6a 02                	push   $0x2
     9be:	e8 cd 0b 00 00       	call   1590 <fprintf>
     9c3:	83 c4 10             	add    $0x10,%esp
     9c6:	c9                   	leave  
     9c7:	c3                   	ret    
     9c8:	90                   	nop
     9c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "%d : %s\n", lineNum, line);
     9d0:	ff 75 0c             	pushl  0xc(%ebp)
     9d3:	50                   	push   %eax
     9d4:	68 79 17 00 00       	push   $0x1779
     9d9:	6a 02                	push   $0x2
     9db:	e8 b0 0b 00 00       	call   1590 <fprintf>
     9e0:	83 c4 10             	add    $0x10,%esp
     9e3:	c9                   	leave  
     9e4:	c3                   	ret    
     9e5:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "%d  : %s\n", lineNum, line);
     9e8:	ff 75 0c             	pushl  0xc(%ebp)
     9eb:	50                   	push   %eax
     9ec:	68 6f 17 00 00       	push   $0x176f
     9f1:	6a 02                	push   $0x2
     9f3:	e8 98 0b 00 00       	call   1590 <fprintf>
     9f8:	83 c4 10             	add    $0x10,%esp
     9fb:	c9                   	leave  
     9fc:	c3                   	ret    
     9fd:	8d 76 00             	lea    0x0(%esi),%esi

00000a00 <end>:
  exit();
  return 0;
}

// commands
void end(struct File* file, char* args) {
     a00:	55                   	push   %ebp
     a01:	89 e5                	mov    %esp,%ebp
     a03:	53                   	push   %ebx
     a04:	83 ec 08             	sub    $0x8,%esp
     a07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  file->edited = 1;
  char* line = args;
  append(file->lines, line);
     a0a:	8b 43 0c             	mov    0xc(%ebx),%eax
  file->edited = 1;
     a0d:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
     a14:	ff 70 08             	pushl  0x8(%eax)
     a17:	ff 75 0c             	pushl  0xc(%ebp)
     a1a:	50                   	push   %eax
     a1b:	e8 70 f8 ff ff       	call   290 <insert>
  file->len++;
     a20:	83 43 10 01          	addl   $0x1,0x10(%ebx)
}
     a24:	83 c4 10             	add    $0x10,%esp
     a27:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a2a:	c9                   	leave  
     a2b:	c3                   	ret    
     a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a30 <add>:

void add(struct File* file, char* args) {
     a30:	55                   	push   %ebp
     a31:	89 e5                	mov    %esp,%ebp
     a33:	57                   	push   %edi
     a34:	56                   	push   %esi
     a35:	53                   	push   %ebx
     a36:	83 ec 28             	sub    $0x28,%esp
     a39:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a3c:	8b 75 0c             	mov    0xc(%ebp),%esi
  file->edited = 1;
     a3f:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
  if (strlen(args) < 1) {
     a46:	56                   	push   %esi
     a47:	e8 04 06 00 00       	call   1050 <strlen>
     a4c:	83 c4 10             	add    $0x10,%esp
     a4f:	85 c0                	test   %eax,%eax
     a51:	74 3d                	je     a90 <add+0x60>
    fprintf(2, "you need to give a line number to insert before\n");
    return;
  }
  char lineStr[10];
  getArg(lineStr, args, ' ');
     a53:	8d 7d de             	lea    -0x22(%ebp),%edi
     a56:	83 ec 04             	sub    $0x4,%esp
     a59:	6a 20                	push   $0x20
     a5b:	56                   	push   %esi
     a5c:	57                   	push   %edi
     a5d:	e8 2e fc ff ff       	call   690 <getArg>
  char* line = args;

  int lineNum = negatoi(lineStr);
     a62:	89 3c 24             	mov    %edi,(%esp)
     a65:	e8 76 fe ff ff       	call   8e0 <negatoi>
  // 1-based to 0-based insert
  insert(file->lines, line, lineNum - 1);
     a6a:	83 c4 0c             	add    $0xc,%esp
     a6d:	83 e8 01             	sub    $0x1,%eax
     a70:	50                   	push   %eax
     a71:	56                   	push   %esi
     a72:	ff 73 0c             	pushl  0xc(%ebx)
     a75:	e8 16 f8 ff ff       	call   290 <insert>
  file->len++;
     a7a:	83 43 10 01          	addl   $0x1,0x10(%ebx)
     a7e:	83 c4 10             	add    $0x10,%esp
}
     a81:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a84:	5b                   	pop    %ebx
     a85:	5e                   	pop    %esi
     a86:	5f                   	pop    %edi
     a87:	5d                   	pop    %ebp
     a88:	c3                   	ret    
     a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "you need to give a line number to insert before\n");
     a90:	83 ec 08             	sub    $0x8,%esp
     a93:	68 b8 18 00 00       	push   $0x18b8
     a98:	6a 02                	push   $0x2
     a9a:	e8 f1 0a 00 00       	call   1590 <fprintf>
    return;
     a9f:	83 c4 10             	add    $0x10,%esp
}
     aa2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     aa5:	5b                   	pop    %ebx
     aa6:	5e                   	pop    %esi
     aa7:	5f                   	pop    %edi
     aa8:	5d                   	pop    %ebp
     aa9:	c3                   	ret    
     aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000ab0 <drop>:

void drop(struct File* file, char* args) {
     ab0:	55                   	push   %ebp
     ab1:	89 e5                	mov    %esp,%ebp
     ab3:	57                   	push   %edi
     ab4:	56                   	push   %esi
     ab5:	53                   	push   %ebx
     ab6:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
     ab9:	ff 75 0c             	pushl  0xc(%ebp)
void drop(struct File* file, char* args) {
     abc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (strlen(args) < 1) {
     abf:	e8 8c 05 00 00       	call   1050 <strlen>
     ac4:	83 c4 10             	add    $0x10,%esp
     ac7:	85 c0                	test   %eax,%eax
     ac9:	0f 84 09 01 00 00    	je     bd8 <drop+0x128>
    fprintf(2, "you need to give a range to drop\n");
    return;
  }

  int start, end;
  if (collectRange(args, &start, &end) == 1) {
     acf:	8d 75 e4             	lea    -0x1c(%ebp),%esi
     ad2:	8d 7d e0             	lea    -0x20(%ebp),%edi
     ad5:	83 ec 04             	sub    $0x4,%esp
     ad8:	56                   	push   %esi
     ad9:	57                   	push   %edi
     ada:	ff 75 0c             	pushl  0xc(%ebp)
     add:	e8 1e fc ff ff       	call   700 <collectRange>
     ae2:	83 c4 10             	add    $0x10,%esp
     ae5:	83 f8 01             	cmp    $0x1,%eax
     ae8:	0f 84 0a 01 00 00    	je     bf8 <drop+0x148>
    fprintf(2, "error: start index is larger than end index\n");
    return;
  }
  if (normalizeRange(*file, &start, &end) == 1) {
     aee:	56                   	push   %esi
     aef:	57                   	push   %edi
     af0:	ff 73 14             	pushl  0x14(%ebx)
     af3:	ff 73 10             	pushl  0x10(%ebx)
     af6:	ff 73 0c             	pushl  0xc(%ebx)
     af9:	ff 73 08             	pushl  0x8(%ebx)
     afc:	ff 73 04             	pushl  0x4(%ebx)
     aff:	ff 33                	pushl  (%ebx)
     b01:	e8 0a f9 ff ff       	call   410 <normalizeRange>
     b06:	83 c4 20             	add    $0x20,%esp
     b09:	83 f8 01             	cmp    $0x1,%eax
     b0c:	0f 84 1e 01 00 00    	je     c30 <drop+0x180>
    fprintf(2, "error: bad input range. make sure start < end\n");
    return;
  }
  int numl = numLines(start, end);
     b12:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     b15:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return (end - start) + 1;
     b18:	89 d6                	mov    %edx,%esi
     b1a:	29 c6                	sub    %eax,%esi
     b1c:	8d 7e 01             	lea    0x1(%esi),%edi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
     b1f:	83 ff 01             	cmp    $0x1,%edi
     b22:	89 7d d4             	mov    %edi,-0x2c(%ebp)
     b25:	0f 84 ed 00 00 00    	je     c18 <drop+0x168>
  else fprintf(2, "Drop %d lines [%d:%d] (y/n)? ", numl, start, end);
     b2b:	83 ec 0c             	sub    $0xc,%esp
     b2e:	52                   	push   %edx
     b2f:	50                   	push   %eax
     b30:	ff 75 d4             	pushl  -0x2c(%ebp)
     b33:	68 b9 17 00 00       	push   $0x17b9
     b38:	6a 02                	push   $0x2
     b3a:	e8 51 0a 00 00       	call   1590 <fprintf>
     b3f:	83 c4 20             	add    $0x20,%esp
  if (confirmation() != 0) return;
     b42:	e8 69 f8 ff ff       	call   3b0 <confirmation>
     b47:	85 c0                	test   %eax,%eax
     b49:	75 7f                	jne    bca <drop+0x11a>
  return nodeAt(list, pos-1);
     b4b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  file->edited = 1;

  // drop lines
  struct Node* curNode = (lineAt(file->lines, start))->prev;
     b4e:	8b 4b 0c             	mov    0xc(%ebx),%ecx
     b51:	83 ec 08             	sub    $0x8,%esp
  file->edited = 1;
     b54:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
     b5b:	83 e8 01             	sub    $0x1,%eax
     b5e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
     b61:	50                   	push   %eax
     b62:	51                   	push   %ecx
     b63:	e8 08 f6 ff ff       	call   170 <nodeAt>
  struct Node* curNode = (lineAt(file->lines, start))->prev;
     b68:	8b 30                	mov    (%eax),%esi
     b6a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b6d:	5a                   	pop    %edx
     b6e:	59                   	pop    %ecx
     b6f:	8b 4d d0             	mov    -0x30(%ebp),%ecx
     b72:	83 e8 01             	sub    $0x1,%eax
     b75:	50                   	push   %eax
     b76:	51                   	push   %ecx
     b77:	e8 f4 f5 ff ff       	call   170 <nodeAt>
     b7c:	83 c4 10             	add    $0x10,%esp
  struct Node* stopNode = lineAt(file->lines, end);
  while (curNode != stopNode) {
     b7f:	39 c6                	cmp    %eax,%esi
     b81:	89 c7                	mov    %eax,%edi
     b83:	8b 4d d0             	mov    -0x30(%ebp),%ecx
     b86:	75 0b                	jne    b93 <drop+0xe3>
     b88:	eb 21                	jmp    bab <drop+0xfb>
     b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b90:	8b 4b 0c             	mov    0xc(%ebx),%ecx
    curNode = curNode->next;
     b93:	8b 76 08             	mov    0x8(%esi),%esi
    destroyNode(file->lines, curNode);
     b96:	83 ec 08             	sub    $0x8,%esp
     b99:	56                   	push   %esi
     b9a:	51                   	push   %ecx
     b9b:	e8 40 f6 ff ff       	call   1e0 <destroyNode>
    file->len--;
     ba0:	83 6b 10 01          	subl   $0x1,0x10(%ebx)
  while (curNode != stopNode) {
     ba4:	83 c4 10             	add    $0x10,%esp
     ba7:	39 fe                	cmp    %edi,%esi
     ba9:	75 e5                	jne    b90 <drop+0xe0>
  }
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
     bab:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
     baf:	0f 84 93 00 00 00    	je     c48 <drop+0x198>
  else fprintf(2, "%d lines dropped\n", numl);
     bb5:	83 ec 04             	sub    $0x4,%esp
     bb8:	ff 75 d4             	pushl  -0x2c(%ebp)
     bbb:	68 e8 17 00 00       	push   $0x17e8
     bc0:	6a 02                	push   $0x2
     bc2:	e8 c9 09 00 00       	call   1590 <fprintf>
     bc7:	83 c4 10             	add    $0x10,%esp
  return;
}
     bca:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bcd:	5b                   	pop    %ebx
     bce:	5e                   	pop    %esi
     bcf:	5f                   	pop    %edi
     bd0:	5d                   	pop    %ebp
     bd1:	c3                   	ret    
     bd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "you need to give a range to drop\n");
     bd8:	83 ec 08             	sub    $0x8,%esp
     bdb:	68 ec 18 00 00       	push   $0x18ec
     be0:	6a 02                	push   $0x2
     be2:	e8 a9 09 00 00       	call   1590 <fprintf>
    return;
     be7:	83 c4 10             	add    $0x10,%esp
}
     bea:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bed:	5b                   	pop    %ebx
     bee:	5e                   	pop    %esi
     bef:	5f                   	pop    %edi
     bf0:	5d                   	pop    %ebp
     bf1:	c3                   	ret    
     bf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: start index is larger than end index\n");
     bf8:	83 ec 08             	sub    $0x8,%esp
     bfb:	68 10 19 00 00       	push   $0x1910
     c00:	6a 02                	push   $0x2
     c02:	e8 89 09 00 00       	call   1590 <fprintf>
    return;
     c07:	83 c4 10             	add    $0x10,%esp
}
     c0a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c0d:	5b                   	pop    %ebx
     c0e:	5e                   	pop    %esi
     c0f:	5f                   	pop    %edi
     c10:	5d                   	pop    %ebp
     c11:	c3                   	ret    
     c12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
     c18:	83 ec 04             	sub    $0x4,%esp
     c1b:	50                   	push   %eax
     c1c:	68 a4 17 00 00       	push   $0x17a4
     c21:	6a 02                	push   $0x2
     c23:	e8 68 09 00 00       	call   1590 <fprintf>
     c28:	83 c4 10             	add    $0x10,%esp
     c2b:	e9 12 ff ff ff       	jmp    b42 <drop+0x92>
    fprintf(2, "error: bad input range. make sure start < end\n");
     c30:	83 ec 08             	sub    $0x8,%esp
     c33:	68 40 19 00 00       	push   $0x1940
     c38:	6a 02                	push   $0x2
     c3a:	e8 51 09 00 00       	call   1590 <fprintf>
    return;
     c3f:	83 c4 10             	add    $0x10,%esp
     c42:	eb 86                	jmp    bca <drop+0x11a>
     c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
     c48:	83 ec 04             	sub    $0x4,%esp
     c4b:	ff 75 e0             	pushl  -0x20(%ebp)
     c4e:	68 d7 17 00 00       	push   $0x17d7
     c53:	6a 02                	push   $0x2
     c55:	e8 36 09 00 00       	call   1590 <fprintf>
     c5a:	83 c4 10             	add    $0x10,%esp
     c5d:	e9 68 ff ff ff       	jmp    bca <drop+0x11a>
     c62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c70 <edit>:

void edit(struct File* file, char* args) {
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
     c73:	57                   	push   %edi
     c74:	56                   	push   %esi
     c75:	53                   	push   %ebx
     c76:	83 ec 28             	sub    $0x28,%esp
     c79:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if (strlen(args) < 1) {
     c7c:	53                   	push   %ebx
     c7d:	e8 ce 03 00 00       	call   1050 <strlen>
     c82:	83 c4 10             	add    $0x10,%esp
     c85:	85 c0                	test   %eax,%eax
     c87:	75 1f                	jne    ca8 <edit+0x38>
    fprintf(2, "you need to give a line number to replace\n");
     c89:	83 ec 08             	sub    $0x8,%esp
     c8c:	68 70 19 00 00       	push   $0x1970
     c91:	6a 02                	push   $0x2
     c93:	e8 f8 08 00 00       	call   1590 <fprintf>
    return;
     c98:	83 c4 10             	add    $0x10,%esp

  // remove
  destroyNode(file->lines, lineAt(file->lines, lineNum));
  // 1-based to 0-based insert
  insert(file->lines, line, lineNum - 1);
}
     c9b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c9e:	5b                   	pop    %ebx
     c9f:	5e                   	pop    %esi
     ca0:	5f                   	pop    %edi
     ca1:	5d                   	pop    %ebp
     ca2:	c3                   	ret    
     ca3:	90                   	nop
     ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  getArg(lineStr, args, ' ');
     ca8:	8d 75 de             	lea    -0x22(%ebp),%esi
     cab:	83 ec 04             	sub    $0x4,%esp
     cae:	6a 20                	push   $0x20
     cb0:	53                   	push   %ebx
     cb1:	56                   	push   %esi
     cb2:	e8 d9 f9 ff ff       	call   690 <getArg>
  int lineNum = negatoi(lineStr);
     cb7:	89 34 24             	mov    %esi,(%esp)
     cba:	e8 21 fc ff ff       	call   8e0 <negatoi>
  fprintf(2, "replace line %d (y/n)? ", lineNum);
     cbf:	83 c4 0c             	add    $0xc,%esp
  int lineNum = negatoi(lineStr);
     cc2:	89 c6                	mov    %eax,%esi
  fprintf(2, "replace line %d (y/n)? ", lineNum);
     cc4:	50                   	push   %eax
     cc5:	68 fa 17 00 00       	push   $0x17fa
     cca:	6a 02                	push   $0x2
     ccc:	e8 bf 08 00 00       	call   1590 <fprintf>
  if (confirmation() != 0) return;
     cd1:	e8 da f6 ff ff       	call   3b0 <confirmation>
     cd6:	83 c4 10             	add    $0x10,%esp
     cd9:	85 c0                	test   %eax,%eax
     cdb:	75 be                	jne    c9b <edit+0x2b>
  file->edited = 1;
     cdd:	8b 45 08             	mov    0x8(%ebp),%eax
     ce0:	83 ec 08             	sub    $0x8,%esp
     ce3:	83 ee 01             	sub    $0x1,%esi
  destroyNode(file->lines, lineAt(file->lines, lineNum));
     ce6:	8b 78 0c             	mov    0xc(%eax),%edi
  file->edited = 1;
     ce9:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
     cf0:	56                   	push   %esi
     cf1:	57                   	push   %edi
     cf2:	e8 79 f4 ff ff       	call   170 <nodeAt>
     cf7:	5a                   	pop    %edx
     cf8:	59                   	pop    %ecx
  destroyNode(file->lines, lineAt(file->lines, lineNum));
     cf9:	50                   	push   %eax
     cfa:	57                   	push   %edi
     cfb:	e8 e0 f4 ff ff       	call   1e0 <destroyNode>
  insert(file->lines, line, lineNum - 1);
     d00:	8b 45 08             	mov    0x8(%ebp),%eax
     d03:	83 c4 0c             	add    $0xc,%esp
     d06:	56                   	push   %esi
     d07:	53                   	push   %ebx
     d08:	ff 70 0c             	pushl  0xc(%eax)
     d0b:	e8 80 f5 ff ff       	call   290 <insert>
     d10:	83 c4 10             	add    $0x10,%esp
}
     d13:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d16:	5b                   	pop    %ebx
     d17:	5e                   	pop    %esi
     d18:	5f                   	pop    %edi
     d19:	5d                   	pop    %ebp
     d1a:	c3                   	ret    
     d1b:	90                   	nop
     d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d20 <list>:

void list(struct File file, char* args) {
     d20:	55                   	push   %ebp
     d21:	89 e5                	mov    %esp,%ebp
     d23:	57                   	push   %edi
     d24:	56                   	push   %esi
     d25:	53                   	push   %ebx
     d26:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
     d29:	ff 75 20             	pushl  0x20(%ebp)
     d2c:	8b 75 14             	mov    0x14(%ebp),%esi
     d2f:	e8 1c 03 00 00       	call   1050 <strlen>
     d34:	83 c4 10             	add    $0x10,%esp
     d37:	85 c0                	test   %eax,%eax
     d39:	75 1d                	jne    d58 <list+0x38>
    fprintf(2, "you need to give a range to list\n");
     d3b:	83 ec 08             	sub    $0x8,%esp
     d3e:	68 9c 19 00 00       	push   $0x199c
     d43:	6a 02                	push   $0x2
     d45:	e8 46 08 00 00       	call   1590 <fprintf>
    return;
     d4a:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
    curNode = curNode->next;
    if (curNode == file.lines->tail) return;
    printl(++lineNum, curNode->data);
  }
}
     d4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d50:	5b                   	pop    %ebx
     d51:	5e                   	pop    %esi
     d52:	5f                   	pop    %edi
     d53:	5d                   	pop    %ebp
     d54:	c3                   	ret    
     d55:	8d 76 00             	lea    0x0(%esi),%esi
  if (collectRange(args, &start, &end) == 1) {
     d58:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
     d5b:	8d 7d e0             	lea    -0x20(%ebp),%edi
     d5e:	83 ec 04             	sub    $0x4,%esp
     d61:	53                   	push   %ebx
     d62:	57                   	push   %edi
     d63:	ff 75 20             	pushl  0x20(%ebp)
     d66:	e8 95 f9 ff ff       	call   700 <collectRange>
     d6b:	83 c4 10             	add    $0x10,%esp
     d6e:	83 f8 01             	cmp    $0x1,%eax
     d71:	0f 84 91 00 00 00    	je     e08 <list+0xe8>
  if (normalizeRange(file, &start, &end) == 1) {
     d77:	53                   	push   %ebx
     d78:	57                   	push   %edi
     d79:	ff 75 1c             	pushl  0x1c(%ebp)
     d7c:	ff 75 18             	pushl  0x18(%ebp)
     d7f:	ff 75 14             	pushl  0x14(%ebp)
     d82:	ff 75 10             	pushl  0x10(%ebp)
     d85:	ff 75 0c             	pushl  0xc(%ebp)
     d88:	ff 75 08             	pushl  0x8(%ebp)
     d8b:	e8 80 f6 ff ff       	call   410 <normalizeRange>
     d90:	83 c4 20             	add    $0x20,%esp
     d93:	83 f8 01             	cmp    $0x1,%eax
     d96:	0f 84 8c 00 00 00    	je     e28 <list+0x108>
  lineNum = start - 1;
     d9c:	8b 45 e0             	mov    -0x20(%ebp),%eax
     d9f:	83 ec 08             	sub    $0x8,%esp
     da2:	8d 78 ff             	lea    -0x1(%eax),%edi
     da5:	57                   	push   %edi
     da6:	56                   	push   %esi
     da7:	e8 c4 f3 ff ff       	call   170 <nodeAt>
  struct Node* curNode = (lineAt(file.lines, start))->prev;
     dac:	8b 18                	mov    (%eax),%ebx
     dae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     db1:	5a                   	pop    %edx
     db2:	59                   	pop    %ecx
     db3:	83 e8 01             	sub    $0x1,%eax
     db6:	50                   	push   %eax
     db7:	56                   	push   %esi
     db8:	e8 b3 f3 ff ff       	call   170 <nodeAt>
     dbd:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
     dc0:	39 d8                	cmp    %ebx,%eax
     dc2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     dc5:	74 86                	je     d4d <list+0x2d>
    curNode = curNode->next;
     dc7:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
     dca:	3b 5e 04             	cmp    0x4(%esi),%ebx
     dcd:	75 15                	jne    de4 <list+0xc4>
     dcf:	e9 79 ff ff ff       	jmp    d4d <list+0x2d>
     dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
     dd8:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
     ddb:	39 5e 04             	cmp    %ebx,0x4(%esi)
     dde:	0f 84 69 ff ff ff    	je     d4d <list+0x2d>
    printl(++lineNum, curNode->data);
     de4:	83 ec 08             	sub    $0x8,%esp
     de7:	83 c7 01             	add    $0x1,%edi
     dea:	ff 73 04             	pushl  0x4(%ebx)
     ded:	57                   	push   %edi
     dee:	e8 ad fb ff ff       	call   9a0 <printl>
  while (curNode != stopNode) {
     df3:	83 c4 10             	add    $0x10,%esp
     df6:	39 5d d4             	cmp    %ebx,-0x2c(%ebp)
     df9:	75 dd                	jne    dd8 <list+0xb8>
}
     dfb:	8d 65 f4             	lea    -0xc(%ebp),%esp
     dfe:	5b                   	pop    %ebx
     dff:	5e                   	pop    %esi
     e00:	5f                   	pop    %edi
     e01:	5d                   	pop    %ebp
     e02:	c3                   	ret    
     e03:	90                   	nop
     e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "error: start index is larger than end index\n");
     e08:	83 ec 08             	sub    $0x8,%esp
     e0b:	68 10 19 00 00       	push   $0x1910
     e10:	6a 02                	push   $0x2
     e12:	e8 79 07 00 00       	call   1590 <fprintf>
    return;
     e17:	83 c4 10             	add    $0x10,%esp
}
     e1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e1d:	5b                   	pop    %ebx
     e1e:	5e                   	pop    %esi
     e1f:	5f                   	pop    %edi
     e20:	5d                   	pop    %ebp
     e21:	c3                   	ret    
     e22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: bad input range. make sure start < end\n");
     e28:	83 ec 08             	sub    $0x8,%esp
     e2b:	68 40 19 00 00       	push   $0x1940
     e30:	6a 02                	push   $0x2
     e32:	e8 59 07 00 00       	call   1590 <fprintf>
    return;
     e37:	83 c4 10             	add    $0x10,%esp
     e3a:	e9 0e ff ff ff       	jmp    d4d <list+0x2d>
     e3f:	90                   	nop

00000e40 <show>:

void show(struct File file, char* args) {
     e40:	55                   	push   %ebp
     e41:	89 e5                	mov    %esp,%ebp
     e43:	57                   	push   %edi
     e44:	56                   	push   %esi
     e45:	53                   	push   %ebx
     e46:	83 ec 0c             	sub    $0xc,%esp
     e49:	8b 7d 14             	mov    0x14(%ebp),%edi
  struct Node* cur = file.lines->head->next;
     e4c:	8b 07                	mov    (%edi),%eax
     e4e:	8b 58 08             	mov    0x8(%eax),%ebx
  int lineNum = 1;
  while (cur != file.lines->tail) {
     e51:	3b 5f 04             	cmp    0x4(%edi),%ebx
     e54:	74 24                	je     e7a <show+0x3a>
  int lineNum = 1;
     e56:	be 01 00 00 00       	mov    $0x1,%esi
     e5b:	90                   	nop
     e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printl(lineNum, cur->data);
     e60:	83 ec 08             	sub    $0x8,%esp
     e63:	ff 73 04             	pushl  0x4(%ebx)
     e66:	56                   	push   %esi
    cur = cur->next;
    lineNum++;
     e67:	83 c6 01             	add    $0x1,%esi
    printl(lineNum, cur->data);
     e6a:	e8 31 fb ff ff       	call   9a0 <printl>
    cur = cur->next;
     e6f:	8b 5b 08             	mov    0x8(%ebx),%ebx
  while (cur != file.lines->tail) {
     e72:	83 c4 10             	add    $0x10,%esp
     e75:	39 5f 04             	cmp    %ebx,0x4(%edi)
     e78:	75 e6                	jne    e60 <show+0x20>
  }
}
     e7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e7d:	5b                   	pop    %ebx
     e7e:	5e                   	pop    %esi
     e7f:	5f                   	pop    %edi
     e80:	5d                   	pop    %ebp
     e81:	c3                   	ret    
     e82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000e90 <quit>:

void quit(struct File* file) {
     e90:	55                   	push   %ebp
     e91:	89 e5                	mov    %esp,%ebp
     e93:	56                   	push   %esi
     e94:	53                   	push   %ebx
     e95:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (file->edited == 0) return;
     e98:	8b 4b 14             	mov    0x14(%ebx),%ecx
     e9b:	85 c9                	test   %ecx,%ecx
     e9d:	75 11                	jne    eb0 <quit+0x20>
    cur = cur->next;
  }
  close(file->fd);
  fprintf(2, "changes saved\n");
  return;
}
     e9f:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ea2:	5b                   	pop    %ebx
     ea3:	5e                   	pop    %esi
     ea4:	5d                   	pop    %ebp
     ea5:	c3                   	ret    
     ea6:	8d 76 00             	lea    0x0(%esi),%esi
     ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  fprintf(2, "save changes (y/n)? ");
     eb0:	83 ec 08             	sub    $0x8,%esp
     eb3:	68 12 18 00 00       	push   $0x1812
     eb8:	6a 02                	push   $0x2
     eba:	e8 d1 06 00 00       	call   1590 <fprintf>
  if (confirmation() != 0) return;
     ebf:	e8 ec f4 ff ff       	call   3b0 <confirmation>
     ec4:	83 c4 10             	add    $0x10,%esp
     ec7:	85 c0                	test   %eax,%eax
     ec9:	75 d4                	jne    e9f <quit+0xf>
  if (unlink(file->filename) < 0) {
     ecb:	83 ec 0c             	sub    $0xc,%esp
     ece:	ff 33                	pushl  (%ebx)
     ed0:	e8 9d 03 00 00       	call   1272 <unlink>
     ed5:	83 c4 10             	add    $0x10,%esp
     ed8:	85 c0                	test   %eax,%eax
     eda:	0f 88 90 00 00 00    	js     f70 <quit+0xe0>
  file->fd = open(file->filename, O_CREATE|O_RDWR);
     ee0:	83 ec 08             	sub    $0x8,%esp
     ee3:	68 02 02 00 00       	push   $0x202
     ee8:	ff 33                	pushl  (%ebx)
     eea:	e8 73 03 00 00       	call   1262 <open>
  if (file->fd < 0) {
     eef:	83 c4 10             	add    $0x10,%esp
     ef2:	85 c0                	test   %eax,%eax
  file->fd = open(file->filename, O_CREATE|O_RDWR);
     ef4:	89 43 04             	mov    %eax,0x4(%ebx)
  if (file->fd < 0) {
     ef7:	0f 88 93 00 00 00    	js     f90 <quit+0x100>
  struct Node* cur = file->lines->head->next;
     efd:	8b 53 0c             	mov    0xc(%ebx),%edx
     f00:	8b 0a                	mov    (%edx),%ecx
     f02:	8b 71 08             	mov    0x8(%ecx),%esi
  while (cur != file->lines->tail) {
     f05:	3b 72 04             	cmp    0x4(%edx),%esi
     f08:	74 43                	je     f4d <quit+0xbd>
     f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    write(file->fd, cur->data, strlen(cur->data));
     f10:	83 ec 0c             	sub    $0xc,%esp
     f13:	ff 76 04             	pushl  0x4(%esi)
     f16:	e8 35 01 00 00       	call   1050 <strlen>
     f1b:	83 c4 0c             	add    $0xc,%esp
     f1e:	50                   	push   %eax
     f1f:	ff 76 04             	pushl  0x4(%esi)
     f22:	ff 73 04             	pushl  0x4(%ebx)
     f25:	e8 18 03 00 00       	call   1242 <write>
    write(file->fd, "\n", sizeof(char));
     f2a:	83 c4 0c             	add    $0xc,%esp
     f2d:	6a 01                	push   $0x1
     f2f:	68 a2 17 00 00       	push   $0x17a2
     f34:	ff 73 04             	pushl  0x4(%ebx)
     f37:	e8 06 03 00 00       	call   1242 <write>
  while (cur != file->lines->tail) {
     f3c:	8b 43 0c             	mov    0xc(%ebx),%eax
    cur = cur->next;
     f3f:	8b 76 08             	mov    0x8(%esi),%esi
  while (cur != file->lines->tail) {
     f42:	83 c4 10             	add    $0x10,%esp
     f45:	39 70 04             	cmp    %esi,0x4(%eax)
     f48:	75 c6                	jne    f10 <quit+0x80>
     f4a:	8b 43 04             	mov    0x4(%ebx),%eax
  close(file->fd);
     f4d:	83 ec 0c             	sub    $0xc,%esp
     f50:	50                   	push   %eax
     f51:	e8 f4 02 00 00       	call   124a <close>
  fprintf(2, "changes saved\n");
     f56:	58                   	pop    %eax
     f57:	5a                   	pop    %edx
     f58:	68 27 18 00 00       	push   $0x1827
     f5d:	6a 02                	push   $0x2
     f5f:	e8 2c 06 00 00       	call   1590 <fprintf>
  return;
     f64:	83 c4 10             	add    $0x10,%esp
     f67:	e9 33 ff ff ff       	jmp    e9f <quit+0xf>
     f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "could not clear file for writing. changes lost\n");
     f70:	83 ec 08             	sub    $0x8,%esp
     f73:	68 c0 19 00 00       	push   $0x19c0
     f78:	6a 02                	push   $0x2
     f7a:	e8 11 06 00 00       	call   1590 <fprintf>
    return;
     f7f:	83 c4 10             	add    $0x10,%esp
     f82:	e9 18 ff ff ff       	jmp    e9f <quit+0xf>
     f87:	89 f6                	mov    %esi,%esi
     f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    fprintf(2, "could not open file for writing. changes lost\n");
     f90:	83 ec 08             	sub    $0x8,%esp
     f93:	68 f0 19 00 00       	push   $0x19f0
     f98:	6a 02                	push   $0x2
     f9a:	e8 f1 05 00 00       	call   1590 <fprintf>
    return;
     f9f:	83 c4 10             	add    $0x10,%esp
     fa2:	e9 f8 fe ff ff       	jmp    e9f <quit+0xf>
     fa7:	89 f6                	mov    %esi,%esi
     fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000fb0 <bi>:

void bi() {
     fb0:	55                   	push   %ebp
     fb1:	89 e5                	mov    %esp,%ebp
     fb3:	83 ec 10             	sub    $0x10,%esp
  fprintf(2, "bad input\n");
     fb6:	68 36 18 00 00       	push   $0x1836
     fbb:	6a 02                	push   $0x2
     fbd:	e8 ce 05 00 00       	call   1590 <fprintf>
}
     fc2:	83 c4 10             	add    $0x10,%esp
     fc5:	c9                   	leave  
     fc6:	c3                   	ret    
     fc7:	66 90                	xchg   %ax,%ax
     fc9:	66 90                	xchg   %ax,%ax
     fcb:	66 90                	xchg   %ax,%ax
     fcd:	66 90                	xchg   %ax,%ax
     fcf:	90                   	nop

00000fd0 <strcpy>:
     fd0:	55                   	push   %ebp
     fd1:	89 e5                	mov    %esp,%ebp
     fd3:	53                   	push   %ebx
     fd4:	8b 45 08             	mov    0x8(%ebp),%eax
     fd7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     fda:	89 c2                	mov    %eax,%edx
     fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     fe0:	83 c1 01             	add    $0x1,%ecx
     fe3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     fe7:	83 c2 01             	add    $0x1,%edx
     fea:	84 db                	test   %bl,%bl
     fec:	88 5a ff             	mov    %bl,-0x1(%edx)
     fef:	75 ef                	jne    fe0 <strcpy+0x10>
     ff1:	5b                   	pop    %ebx
     ff2:	5d                   	pop    %ebp
     ff3:	c3                   	ret    
     ff4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     ffa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001000 <strcmp>:
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	53                   	push   %ebx
    1004:	8b 55 08             	mov    0x8(%ebp),%edx
    1007:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    100a:	0f b6 02             	movzbl (%edx),%eax
    100d:	0f b6 19             	movzbl (%ecx),%ebx
    1010:	84 c0                	test   %al,%al
    1012:	75 1c                	jne    1030 <strcmp+0x30>
    1014:	eb 2a                	jmp    1040 <strcmp+0x40>
    1016:	8d 76 00             	lea    0x0(%esi),%esi
    1019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1020:	83 c2 01             	add    $0x1,%edx
    1023:	0f b6 02             	movzbl (%edx),%eax
    1026:	83 c1 01             	add    $0x1,%ecx
    1029:	0f b6 19             	movzbl (%ecx),%ebx
    102c:	84 c0                	test   %al,%al
    102e:	74 10                	je     1040 <strcmp+0x40>
    1030:	38 d8                	cmp    %bl,%al
    1032:	74 ec                	je     1020 <strcmp+0x20>
    1034:	29 d8                	sub    %ebx,%eax
    1036:	5b                   	pop    %ebx
    1037:	5d                   	pop    %ebp
    1038:	c3                   	ret    
    1039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1040:	31 c0                	xor    %eax,%eax
    1042:	29 d8                	sub    %ebx,%eax
    1044:	5b                   	pop    %ebx
    1045:	5d                   	pop    %ebp
    1046:	c3                   	ret    
    1047:	89 f6                	mov    %esi,%esi
    1049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001050 <strlen>:
    1050:	55                   	push   %ebp
    1051:	89 e5                	mov    %esp,%ebp
    1053:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1056:	80 39 00             	cmpb   $0x0,(%ecx)
    1059:	74 15                	je     1070 <strlen+0x20>
    105b:	31 d2                	xor    %edx,%edx
    105d:	8d 76 00             	lea    0x0(%esi),%esi
    1060:	83 c2 01             	add    $0x1,%edx
    1063:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1067:	89 d0                	mov    %edx,%eax
    1069:	75 f5                	jne    1060 <strlen+0x10>
    106b:	5d                   	pop    %ebp
    106c:	c3                   	ret    
    106d:	8d 76 00             	lea    0x0(%esi),%esi
    1070:	31 c0                	xor    %eax,%eax
    1072:	5d                   	pop    %ebp
    1073:	c3                   	ret    
    1074:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    107a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001080 <memset>:
    1080:	55                   	push   %ebp
    1081:	89 e5                	mov    %esp,%ebp
    1083:	57                   	push   %edi
    1084:	8b 55 08             	mov    0x8(%ebp),%edx
    1087:	8b 4d 10             	mov    0x10(%ebp),%ecx
    108a:	8b 45 0c             	mov    0xc(%ebp),%eax
    108d:	89 d7                	mov    %edx,%edi
    108f:	fc                   	cld    
    1090:	f3 aa                	rep stos %al,%es:(%edi)
    1092:	89 d0                	mov    %edx,%eax
    1094:	5f                   	pop    %edi
    1095:	5d                   	pop    %ebp
    1096:	c3                   	ret    
    1097:	89 f6                	mov    %esi,%esi
    1099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010a0 <strchr>:
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
    10a3:	53                   	push   %ebx
    10a4:	8b 45 08             	mov    0x8(%ebp),%eax
    10a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    10aa:	0f b6 10             	movzbl (%eax),%edx
    10ad:	84 d2                	test   %dl,%dl
    10af:	74 1d                	je     10ce <strchr+0x2e>
    10b1:	38 d3                	cmp    %dl,%bl
    10b3:	89 d9                	mov    %ebx,%ecx
    10b5:	75 0d                	jne    10c4 <strchr+0x24>
    10b7:	eb 17                	jmp    10d0 <strchr+0x30>
    10b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10c0:	38 ca                	cmp    %cl,%dl
    10c2:	74 0c                	je     10d0 <strchr+0x30>
    10c4:	83 c0 01             	add    $0x1,%eax
    10c7:	0f b6 10             	movzbl (%eax),%edx
    10ca:	84 d2                	test   %dl,%dl
    10cc:	75 f2                	jne    10c0 <strchr+0x20>
    10ce:	31 c0                	xor    %eax,%eax
    10d0:	5b                   	pop    %ebx
    10d1:	5d                   	pop    %ebp
    10d2:	c3                   	ret    
    10d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010e0 <gets>:
    10e0:	55                   	push   %ebp
    10e1:	89 e5                	mov    %esp,%ebp
    10e3:	57                   	push   %edi
    10e4:	56                   	push   %esi
    10e5:	53                   	push   %ebx
    10e6:	31 f6                	xor    %esi,%esi
    10e8:	89 f3                	mov    %esi,%ebx
    10ea:	83 ec 1c             	sub    $0x1c,%esp
    10ed:	8b 7d 08             	mov    0x8(%ebp),%edi
    10f0:	eb 2f                	jmp    1121 <gets+0x41>
    10f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10f8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    10fb:	83 ec 04             	sub    $0x4,%esp
    10fe:	6a 01                	push   $0x1
    1100:	50                   	push   %eax
    1101:	6a 00                	push   $0x0
    1103:	e8 32 01 00 00       	call   123a <read>
    1108:	83 c4 10             	add    $0x10,%esp
    110b:	85 c0                	test   %eax,%eax
    110d:	7e 1c                	jle    112b <gets+0x4b>
    110f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1113:	83 c7 01             	add    $0x1,%edi
    1116:	88 47 ff             	mov    %al,-0x1(%edi)
    1119:	3c 0a                	cmp    $0xa,%al
    111b:	74 23                	je     1140 <gets+0x60>
    111d:	3c 0d                	cmp    $0xd,%al
    111f:	74 1f                	je     1140 <gets+0x60>
    1121:	83 c3 01             	add    $0x1,%ebx
    1124:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1127:	89 fe                	mov    %edi,%esi
    1129:	7c cd                	jl     10f8 <gets+0x18>
    112b:	89 f3                	mov    %esi,%ebx
    112d:	8b 45 08             	mov    0x8(%ebp),%eax
    1130:	c6 03 00             	movb   $0x0,(%ebx)
    1133:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1136:	5b                   	pop    %ebx
    1137:	5e                   	pop    %esi
    1138:	5f                   	pop    %edi
    1139:	5d                   	pop    %ebp
    113a:	c3                   	ret    
    113b:	90                   	nop
    113c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1140:	8b 75 08             	mov    0x8(%ebp),%esi
    1143:	8b 45 08             	mov    0x8(%ebp),%eax
    1146:	01 de                	add    %ebx,%esi
    1148:	89 f3                	mov    %esi,%ebx
    114a:	c6 03 00             	movb   $0x0,(%ebx)
    114d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1150:	5b                   	pop    %ebx
    1151:	5e                   	pop    %esi
    1152:	5f                   	pop    %edi
    1153:	5d                   	pop    %ebp
    1154:	c3                   	ret    
    1155:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001160 <stat>:
    1160:	55                   	push   %ebp
    1161:	89 e5                	mov    %esp,%ebp
    1163:	56                   	push   %esi
    1164:	53                   	push   %ebx
    1165:	83 ec 08             	sub    $0x8,%esp
    1168:	6a 00                	push   $0x0
    116a:	ff 75 08             	pushl  0x8(%ebp)
    116d:	e8 f0 00 00 00       	call   1262 <open>
    1172:	83 c4 10             	add    $0x10,%esp
    1175:	85 c0                	test   %eax,%eax
    1177:	78 27                	js     11a0 <stat+0x40>
    1179:	83 ec 08             	sub    $0x8,%esp
    117c:	ff 75 0c             	pushl  0xc(%ebp)
    117f:	89 c3                	mov    %eax,%ebx
    1181:	50                   	push   %eax
    1182:	e8 f3 00 00 00       	call   127a <fstat>
    1187:	89 1c 24             	mov    %ebx,(%esp)
    118a:	89 c6                	mov    %eax,%esi
    118c:	e8 b9 00 00 00       	call   124a <close>
    1191:	83 c4 10             	add    $0x10,%esp
    1194:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1197:	89 f0                	mov    %esi,%eax
    1199:	5b                   	pop    %ebx
    119a:	5e                   	pop    %esi
    119b:	5d                   	pop    %ebp
    119c:	c3                   	ret    
    119d:	8d 76 00             	lea    0x0(%esi),%esi
    11a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    11a5:	eb ed                	jmp    1194 <stat+0x34>
    11a7:	89 f6                	mov    %esi,%esi
    11a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011b0 <atoi>:
    11b0:	55                   	push   %ebp
    11b1:	89 e5                	mov    %esp,%ebp
    11b3:	53                   	push   %ebx
    11b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
    11b7:	0f be 11             	movsbl (%ecx),%edx
    11ba:	8d 42 d0             	lea    -0x30(%edx),%eax
    11bd:	3c 09                	cmp    $0x9,%al
    11bf:	b8 00 00 00 00       	mov    $0x0,%eax
    11c4:	77 1f                	ja     11e5 <atoi+0x35>
    11c6:	8d 76 00             	lea    0x0(%esi),%esi
    11c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    11d0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    11d3:	83 c1 01             	add    $0x1,%ecx
    11d6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
    11da:	0f be 11             	movsbl (%ecx),%edx
    11dd:	8d 5a d0             	lea    -0x30(%edx),%ebx
    11e0:	80 fb 09             	cmp    $0x9,%bl
    11e3:	76 eb                	jbe    11d0 <atoi+0x20>
    11e5:	5b                   	pop    %ebx
    11e6:	5d                   	pop    %ebp
    11e7:	c3                   	ret    
    11e8:	90                   	nop
    11e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000011f0 <memmove>:
    11f0:	55                   	push   %ebp
    11f1:	89 e5                	mov    %esp,%ebp
    11f3:	56                   	push   %esi
    11f4:	53                   	push   %ebx
    11f5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    11f8:	8b 45 08             	mov    0x8(%ebp),%eax
    11fb:	8b 75 0c             	mov    0xc(%ebp),%esi
    11fe:	85 db                	test   %ebx,%ebx
    1200:	7e 14                	jle    1216 <memmove+0x26>
    1202:	31 d2                	xor    %edx,%edx
    1204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1208:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    120c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    120f:	83 c2 01             	add    $0x1,%edx
    1212:	39 d3                	cmp    %edx,%ebx
    1214:	75 f2                	jne    1208 <memmove+0x18>
    1216:	5b                   	pop    %ebx
    1217:	5e                   	pop    %esi
    1218:	5d                   	pop    %ebp
    1219:	c3                   	ret    

0000121a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    121a:	b8 01 00 00 00       	mov    $0x1,%eax
    121f:	cd 40                	int    $0x40
    1221:	c3                   	ret    

00001222 <exit>:
SYSCALL(exit)
    1222:	b8 02 00 00 00       	mov    $0x2,%eax
    1227:	cd 40                	int    $0x40
    1229:	c3                   	ret    

0000122a <wait>:
SYSCALL(wait)
    122a:	b8 03 00 00 00       	mov    $0x3,%eax
    122f:	cd 40                	int    $0x40
    1231:	c3                   	ret    

00001232 <pipe>:
SYSCALL(pipe)
    1232:	b8 04 00 00 00       	mov    $0x4,%eax
    1237:	cd 40                	int    $0x40
    1239:	c3                   	ret    

0000123a <read>:
SYSCALL(read)
    123a:	b8 05 00 00 00       	mov    $0x5,%eax
    123f:	cd 40                	int    $0x40
    1241:	c3                   	ret    

00001242 <write>:
SYSCALL(write)
    1242:	b8 10 00 00 00       	mov    $0x10,%eax
    1247:	cd 40                	int    $0x40
    1249:	c3                   	ret    

0000124a <close>:
SYSCALL(close)
    124a:	b8 15 00 00 00       	mov    $0x15,%eax
    124f:	cd 40                	int    $0x40
    1251:	c3                   	ret    

00001252 <kill>:
SYSCALL(kill)
    1252:	b8 06 00 00 00       	mov    $0x6,%eax
    1257:	cd 40                	int    $0x40
    1259:	c3                   	ret    

0000125a <exec>:
SYSCALL(exec)
    125a:	b8 07 00 00 00       	mov    $0x7,%eax
    125f:	cd 40                	int    $0x40
    1261:	c3                   	ret    

00001262 <open>:
SYSCALL(open)
    1262:	b8 0f 00 00 00       	mov    $0xf,%eax
    1267:	cd 40                	int    $0x40
    1269:	c3                   	ret    

0000126a <mknod>:
SYSCALL(mknod)
    126a:	b8 11 00 00 00       	mov    $0x11,%eax
    126f:	cd 40                	int    $0x40
    1271:	c3                   	ret    

00001272 <unlink>:
SYSCALL(unlink)
    1272:	b8 12 00 00 00       	mov    $0x12,%eax
    1277:	cd 40                	int    $0x40
    1279:	c3                   	ret    

0000127a <fstat>:
SYSCALL(fstat)
    127a:	b8 08 00 00 00       	mov    $0x8,%eax
    127f:	cd 40                	int    $0x40
    1281:	c3                   	ret    

00001282 <link>:
SYSCALL(link)
    1282:	b8 13 00 00 00       	mov    $0x13,%eax
    1287:	cd 40                	int    $0x40
    1289:	c3                   	ret    

0000128a <mkdir>:
SYSCALL(mkdir)
    128a:	b8 14 00 00 00       	mov    $0x14,%eax
    128f:	cd 40                	int    $0x40
    1291:	c3                   	ret    

00001292 <chdir>:
SYSCALL(chdir)
    1292:	b8 09 00 00 00       	mov    $0x9,%eax
    1297:	cd 40                	int    $0x40
    1299:	c3                   	ret    

0000129a <dup>:
SYSCALL(dup)
    129a:	b8 0a 00 00 00       	mov    $0xa,%eax
    129f:	cd 40                	int    $0x40
    12a1:	c3                   	ret    

000012a2 <getpid>:
SYSCALL(getpid)
    12a2:	b8 0b 00 00 00       	mov    $0xb,%eax
    12a7:	cd 40                	int    $0x40
    12a9:	c3                   	ret    

000012aa <sbrk>:
SYSCALL(sbrk)
    12aa:	b8 0c 00 00 00       	mov    $0xc,%eax
    12af:	cd 40                	int    $0x40
    12b1:	c3                   	ret    

000012b2 <sleep>:
SYSCALL(sleep)
    12b2:	b8 0d 00 00 00       	mov    $0xd,%eax
    12b7:	cd 40                	int    $0x40
    12b9:	c3                   	ret    

000012ba <uptime>:
SYSCALL(uptime)
    12ba:	b8 0e 00 00 00       	mov    $0xe,%eax
    12bf:	cd 40                	int    $0x40
    12c1:	c3                   	ret    

000012c2 <cpuhalt>:
SYSCALL(cpuhalt)
    12c2:	b8 16 00 00 00       	mov    $0x16,%eax
    12c7:	cd 40                	int    $0x40
    12c9:	c3                   	ret    
    12ca:	66 90                	xchg   %ax,%ax
    12cc:	66 90                	xchg   %ax,%ax
    12ce:	66 90                	xchg   %ax,%ax

000012d0 <printint.constprop.1>:
    12d0:	55                   	push   %ebp
    12d1:	89 e5                	mov    %esp,%ebp
    12d3:	57                   	push   %edi
    12d4:	56                   	push   %esi
    12d5:	53                   	push   %ebx
    12d6:	89 d6                	mov    %edx,%esi
    12d8:	83 ec 3c             	sub    $0x3c,%esp
    12db:	85 c0                	test   %eax,%eax
    12dd:	79 71                	jns    1350 <printint.constprop.1+0x80>
    12df:	83 e1 01             	and    $0x1,%ecx
    12e2:	74 6c                	je     1350 <printint.constprop.1+0x80>
    12e4:	f7 d8                	neg    %eax
    12e6:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    12ed:	31 c9                	xor    %ecx,%ecx
    12ef:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    12f2:	eb 06                	jmp    12fa <printint.constprop.1+0x2a>
    12f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12f8:	89 f9                	mov    %edi,%ecx
    12fa:	31 d2                	xor    %edx,%edx
    12fc:	8d 79 01             	lea    0x1(%ecx),%edi
    12ff:	f7 f6                	div    %esi
    1301:	0f b6 92 28 1a 00 00 	movzbl 0x1a28(%edx),%edx
    1308:	85 c0                	test   %eax,%eax
    130a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
    130d:	75 e9                	jne    12f8 <printint.constprop.1+0x28>
    130f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1312:	85 c0                	test   %eax,%eax
    1314:	74 08                	je     131e <printint.constprop.1+0x4e>
    1316:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    131b:	8d 79 02             	lea    0x2(%ecx),%edi
    131e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    1322:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1328:	0f b6 06             	movzbl (%esi),%eax
    132b:	83 ec 04             	sub    $0x4,%esp
    132e:	83 ee 01             	sub    $0x1,%esi
    1331:	6a 01                	push   $0x1
    1333:	53                   	push   %ebx
    1334:	6a 01                	push   $0x1
    1336:	88 45 d7             	mov    %al,-0x29(%ebp)
    1339:	e8 04 ff ff ff       	call   1242 <write>
    133e:	83 c4 10             	add    $0x10,%esp
    1341:	39 de                	cmp    %ebx,%esi
    1343:	75 e3                	jne    1328 <printint.constprop.1+0x58>
    1345:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1348:	5b                   	pop    %ebx
    1349:	5e                   	pop    %esi
    134a:	5f                   	pop    %edi
    134b:	5d                   	pop    %ebp
    134c:	c3                   	ret    
    134d:	8d 76 00             	lea    0x0(%esi),%esi
    1350:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1357:	eb 94                	jmp    12ed <printint.constprop.1+0x1d>
    1359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001360 <vprintf.constprop.0>:
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
    1363:	57                   	push   %edi
    1364:	56                   	push   %esi
    1365:	53                   	push   %ebx
    1366:	89 d6                	mov    %edx,%esi
    1368:	83 ec 2c             	sub    $0x2c,%esp
    136b:	0f b6 10             	movzbl (%eax),%edx
    136e:	84 d2                	test   %dl,%dl
    1370:	0f 84 cd 00 00 00    	je     1443 <vprintf.constprop.0+0xe3>
    1376:	8d 58 01             	lea    0x1(%eax),%ebx
    1379:	31 ff                	xor    %edi,%edi
    137b:	eb 31                	jmp    13ae <vprintf.constprop.0+0x4e>
    137d:	8d 76 00             	lea    0x0(%esi),%esi
    1380:	83 f8 25             	cmp    $0x25,%eax
    1383:	0f 84 c7 00 00 00    	je     1450 <vprintf.constprop.0+0xf0>
    1389:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    138c:	83 ec 04             	sub    $0x4,%esp
    138f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
    1392:	6a 01                	push   $0x1
    1394:	50                   	push   %eax
    1395:	6a 01                	push   $0x1
    1397:	e8 a6 fe ff ff       	call   1242 <write>
    139c:	83 c4 10             	add    $0x10,%esp
    139f:	83 c3 01             	add    $0x1,%ebx
    13a2:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    13a6:	84 d2                	test   %dl,%dl
    13a8:	0f 84 95 00 00 00    	je     1443 <vprintf.constprop.0+0xe3>
    13ae:	85 ff                	test   %edi,%edi
    13b0:	0f b6 c2             	movzbl %dl,%eax
    13b3:	74 cb                	je     1380 <vprintf.constprop.0+0x20>
    13b5:	83 ff 25             	cmp    $0x25,%edi
    13b8:	75 e5                	jne    139f <vprintf.constprop.0+0x3f>
    13ba:	83 f8 64             	cmp    $0x64,%eax
    13bd:	8d 7e 04             	lea    0x4(%esi),%edi
    13c0:	b9 01 00 00 00       	mov    $0x1,%ecx
    13c5:	0f 84 9a 00 00 00    	je     1465 <vprintf.constprop.0+0x105>
    13cb:	83 f8 6c             	cmp    $0x6c,%eax
    13ce:	0f 84 8c 00 00 00    	je     1460 <vprintf.constprop.0+0x100>
    13d4:	83 f8 78             	cmp    $0x78,%eax
    13d7:	0f 84 a3 00 00 00    	je     1480 <vprintf.constprop.0+0x120>
    13dd:	83 f8 70             	cmp    $0x70,%eax
    13e0:	0f 84 ca 00 00 00    	je     14b0 <vprintf.constprop.0+0x150>
    13e6:	83 f8 73             	cmp    $0x73,%eax
    13e9:	0f 84 39 01 00 00    	je     1528 <vprintf.constprop.0+0x1c8>
    13ef:	83 f8 63             	cmp    $0x63,%eax
    13f2:	0f 84 68 01 00 00    	je     1560 <vprintf.constprop.0+0x200>
    13f8:	83 f8 25             	cmp    $0x25,%eax
    13fb:	0f 84 9f 00 00 00    	je     14a0 <vprintf.constprop.0+0x140>
    1401:	8d 45 df             	lea    -0x21(%ebp),%eax
    1404:	83 ec 04             	sub    $0x4,%esp
    1407:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    140a:	6a 01                	push   $0x1
    140c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
    1410:	50                   	push   %eax
    1411:	6a 01                	push   $0x1
    1413:	e8 2a fe ff ff       	call   1242 <write>
    1418:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    141c:	83 c4 0c             	add    $0xc,%esp
    141f:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1422:	6a 01                	push   $0x1
    1424:	88 55 e0             	mov    %dl,-0x20(%ebp)
    1427:	50                   	push   %eax
    1428:	6a 01                	push   $0x1
    142a:	83 c3 01             	add    $0x1,%ebx
    142d:	31 ff                	xor    %edi,%edi
    142f:	e8 0e fe ff ff       	call   1242 <write>
    1434:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1438:	83 c4 10             	add    $0x10,%esp
    143b:	84 d2                	test   %dl,%dl
    143d:	0f 85 6b ff ff ff    	jne    13ae <vprintf.constprop.0+0x4e>
    1443:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1446:	5b                   	pop    %ebx
    1447:	5e                   	pop    %esi
    1448:	5f                   	pop    %edi
    1449:	5d                   	pop    %ebp
    144a:	c3                   	ret    
    144b:	90                   	nop
    144c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1450:	bf 25 00 00 00       	mov    $0x25,%edi
    1455:	e9 45 ff ff ff       	jmp    139f <vprintf.constprop.0+0x3f>
    145a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1460:	8d 7e 04             	lea    0x4(%esi),%edi
    1463:	31 c9                	xor    %ecx,%ecx
    1465:	8b 06                	mov    (%esi),%eax
    1467:	ba 0a 00 00 00       	mov    $0xa,%edx
    146c:	89 fe                	mov    %edi,%esi
    146e:	31 ff                	xor    %edi,%edi
    1470:	e8 5b fe ff ff       	call   12d0 <printint.constprop.1>
    1475:	e9 25 ff ff ff       	jmp    139f <vprintf.constprop.0+0x3f>
    147a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1480:	8b 06                	mov    (%esi),%eax
    1482:	8d 7e 04             	lea    0x4(%esi),%edi
    1485:	31 c9                	xor    %ecx,%ecx
    1487:	ba 10 00 00 00       	mov    $0x10,%edx
    148c:	89 fe                	mov    %edi,%esi
    148e:	31 ff                	xor    %edi,%edi
    1490:	e8 3b fe ff ff       	call   12d0 <printint.constprop.1>
    1495:	e9 05 ff ff ff       	jmp    139f <vprintf.constprop.0+0x3f>
    149a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    14a0:	83 ec 04             	sub    $0x4,%esp
    14a3:	88 55 e1             	mov    %dl,-0x1f(%ebp)
    14a6:	8d 45 e1             	lea    -0x1f(%ebp),%eax
    14a9:	6a 01                	push   $0x1
    14ab:	e9 77 ff ff ff       	jmp    1427 <vprintf.constprop.0+0xc7>
    14b0:	8d 46 04             	lea    0x4(%esi),%eax
    14b3:	83 ec 04             	sub    $0x4,%esp
    14b6:	8b 3e                	mov    (%esi),%edi
    14b8:	6a 01                	push   $0x1
    14ba:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
    14be:	be 08 00 00 00       	mov    $0x8,%esi
    14c3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    14c6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    14c9:	50                   	push   %eax
    14ca:	6a 01                	push   $0x1
    14cc:	e8 71 fd ff ff       	call   1242 <write>
    14d1:	8d 45 e7             	lea    -0x19(%ebp),%eax
    14d4:	83 c4 0c             	add    $0xc,%esp
    14d7:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
    14db:	6a 01                	push   $0x1
    14dd:	50                   	push   %eax
    14de:	6a 01                	push   $0x1
    14e0:	e8 5d fd ff ff       	call   1242 <write>
    14e5:	83 c4 10             	add    $0x10,%esp
    14e8:	90                   	nop
    14e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    14f0:	89 f8                	mov    %edi,%eax
    14f2:	83 ec 04             	sub    $0x4,%esp
    14f5:	c1 e7 04             	shl    $0x4,%edi
    14f8:	c1 e8 1c             	shr    $0x1c,%eax
    14fb:	6a 01                	push   $0x1
    14fd:	0f b6 80 28 1a 00 00 	movzbl 0x1a28(%eax),%eax
    1504:	88 45 e5             	mov    %al,-0x1b(%ebp)
    1507:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    150a:	50                   	push   %eax
    150b:	6a 01                	push   $0x1
    150d:	e8 30 fd ff ff       	call   1242 <write>
    1512:	83 c4 10             	add    $0x10,%esp
    1515:	83 ee 01             	sub    $0x1,%esi
    1518:	75 d6                	jne    14f0 <vprintf.constprop.0+0x190>
    151a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    151d:	31 ff                	xor    %edi,%edi
    151f:	e9 7b fe ff ff       	jmp    139f <vprintf.constprop.0+0x3f>
    1524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1528:	8b 3e                	mov    (%esi),%edi
    152a:	8d 46 04             	lea    0x4(%esi),%eax
    152d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1530:	85 ff                	test   %edi,%edi
    1532:	74 50                	je     1584 <vprintf.constprop.0+0x224>
    1534:	0f b6 07             	movzbl (%edi),%eax
    1537:	84 c0                	test   %al,%al
    1539:	74 df                	je     151a <vprintf.constprop.0+0x1ba>
    153b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
    153e:	66 90                	xchg   %ax,%ax
    1540:	83 ec 04             	sub    $0x4,%esp
    1543:	83 c7 01             	add    $0x1,%edi
    1546:	88 45 e3             	mov    %al,-0x1d(%ebp)
    1549:	6a 01                	push   $0x1
    154b:	56                   	push   %esi
    154c:	6a 01                	push   $0x1
    154e:	e8 ef fc ff ff       	call   1242 <write>
    1553:	0f b6 07             	movzbl (%edi),%eax
    1556:	83 c4 10             	add    $0x10,%esp
    1559:	84 c0                	test   %al,%al
    155b:	75 e3                	jne    1540 <vprintf.constprop.0+0x1e0>
    155d:	eb bb                	jmp    151a <vprintf.constprop.0+0x1ba>
    155f:	90                   	nop
    1560:	8b 06                	mov    (%esi),%eax
    1562:	83 ec 04             	sub    $0x4,%esp
    1565:	8d 7e 04             	lea    0x4(%esi),%edi
    1568:	6a 01                	push   $0x1
    156a:	89 fe                	mov    %edi,%esi
    156c:	31 ff                	xor    %edi,%edi
    156e:	88 45 e2             	mov    %al,-0x1e(%ebp)
    1571:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1574:	50                   	push   %eax
    1575:	6a 01                	push   $0x1
    1577:	e8 c6 fc ff ff       	call   1242 <write>
    157c:	83 c4 10             	add    $0x10,%esp
    157f:	e9 1b fe ff ff       	jmp    139f <vprintf.constprop.0+0x3f>
    1584:	bf 20 1a 00 00       	mov    $0x1a20,%edi
    1589:	b8 28 00 00 00       	mov    $0x28,%eax
    158e:	eb ab                	jmp    153b <vprintf.constprop.0+0x1db>

00001590 <fprintf>:
    1590:	55                   	push   %ebp
    1591:	89 e5                	mov    %esp,%ebp
    1593:	83 ec 08             	sub    $0x8,%esp
    1596:	8b 45 0c             	mov    0xc(%ebp),%eax
    1599:	8d 55 10             	lea    0x10(%ebp),%edx
    159c:	e8 bf fd ff ff       	call   1360 <vprintf.constprop.0>
    15a1:	c9                   	leave  
    15a2:	c3                   	ret    
    15a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    15a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000015b0 <printf>:
    15b0:	55                   	push   %ebp
    15b1:	89 e5                	mov    %esp,%ebp
    15b3:	83 ec 08             	sub    $0x8,%esp
    15b6:	8b 45 08             	mov    0x8(%ebp),%eax
    15b9:	8d 55 0c             	lea    0xc(%ebp),%edx
    15bc:	e8 9f fd ff ff       	call   1360 <vprintf.constprop.0>
    15c1:	c9                   	leave  
    15c2:	c3                   	ret    
    15c3:	66 90                	xchg   %ax,%ax
    15c5:	66 90                	xchg   %ax,%ax
    15c7:	66 90                	xchg   %ax,%ax
    15c9:	66 90                	xchg   %ax,%ax
    15cb:	66 90                	xchg   %ax,%ax
    15cd:	66 90                	xchg   %ax,%ax
    15cf:	90                   	nop

000015d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15d1:	a1 bc 22 00 00       	mov    0x22bc,%eax
{
    15d6:	89 e5                	mov    %esp,%ebp
    15d8:	57                   	push   %edi
    15d9:	56                   	push   %esi
    15da:	53                   	push   %ebx
    15db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    15de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    15e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15e8:	39 c8                	cmp    %ecx,%eax
    15ea:	8b 10                	mov    (%eax),%edx
    15ec:	73 32                	jae    1620 <free+0x50>
    15ee:	39 d1                	cmp    %edx,%ecx
    15f0:	72 04                	jb     15f6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15f2:	39 d0                	cmp    %edx,%eax
    15f4:	72 32                	jb     1628 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    15f6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    15f9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    15fc:	39 fa                	cmp    %edi,%edx
    15fe:	74 30                	je     1630 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1600:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1603:	8b 50 04             	mov    0x4(%eax),%edx
    1606:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1609:	39 f1                	cmp    %esi,%ecx
    160b:	74 3a                	je     1647 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    160d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    160f:	a3 bc 22 00 00       	mov    %eax,0x22bc
}
    1614:	5b                   	pop    %ebx
    1615:	5e                   	pop    %esi
    1616:	5f                   	pop    %edi
    1617:	5d                   	pop    %ebp
    1618:	c3                   	ret    
    1619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1620:	39 d0                	cmp    %edx,%eax
    1622:	72 04                	jb     1628 <free+0x58>
    1624:	39 d1                	cmp    %edx,%ecx
    1626:	72 ce                	jb     15f6 <free+0x26>
{
    1628:	89 d0                	mov    %edx,%eax
    162a:	eb bc                	jmp    15e8 <free+0x18>
    162c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1630:	03 72 04             	add    0x4(%edx),%esi
    1633:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1636:	8b 10                	mov    (%eax),%edx
    1638:	8b 12                	mov    (%edx),%edx
    163a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    163d:	8b 50 04             	mov    0x4(%eax),%edx
    1640:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1643:	39 f1                	cmp    %esi,%ecx
    1645:	75 c6                	jne    160d <free+0x3d>
    p->s.size += bp->s.size;
    1647:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    164a:	a3 bc 22 00 00       	mov    %eax,0x22bc
    p->s.size += bp->s.size;
    164f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1652:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1655:	89 10                	mov    %edx,(%eax)
}
    1657:	5b                   	pop    %ebx
    1658:	5e                   	pop    %esi
    1659:	5f                   	pop    %edi
    165a:	5d                   	pop    %ebp
    165b:	c3                   	ret    
    165c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001660 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1660:	55                   	push   %ebp
    1661:	89 e5                	mov    %esp,%ebp
    1663:	57                   	push   %edi
    1664:	56                   	push   %esi
    1665:	53                   	push   %ebx
    1666:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1669:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    166c:	8b 15 bc 22 00 00    	mov    0x22bc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1672:	8d 78 07             	lea    0x7(%eax),%edi
    1675:	c1 ef 03             	shr    $0x3,%edi
    1678:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    167b:	85 d2                	test   %edx,%edx
    167d:	0f 84 9d 00 00 00    	je     1720 <malloc+0xc0>
    1683:	8b 02                	mov    (%edx),%eax
    1685:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1688:	39 cf                	cmp    %ecx,%edi
    168a:	76 6c                	jbe    16f8 <malloc+0x98>
    168c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1692:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1697:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    169a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    16a1:	eb 0e                	jmp    16b1 <malloc+0x51>
    16a3:	90                   	nop
    16a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16a8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    16aa:	8b 48 04             	mov    0x4(%eax),%ecx
    16ad:	39 f9                	cmp    %edi,%ecx
    16af:	73 47                	jae    16f8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    16b1:	39 05 bc 22 00 00    	cmp    %eax,0x22bc
    16b7:	89 c2                	mov    %eax,%edx
    16b9:	75 ed                	jne    16a8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    16bb:	83 ec 0c             	sub    $0xc,%esp
    16be:	56                   	push   %esi
    16bf:	e8 e6 fb ff ff       	call   12aa <sbrk>
  if(p == (char*)-1)
    16c4:	83 c4 10             	add    $0x10,%esp
    16c7:	83 f8 ff             	cmp    $0xffffffff,%eax
    16ca:	74 1c                	je     16e8 <malloc+0x88>
  hp->s.size = nu;
    16cc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    16cf:	83 ec 0c             	sub    $0xc,%esp
    16d2:	83 c0 08             	add    $0x8,%eax
    16d5:	50                   	push   %eax
    16d6:	e8 f5 fe ff ff       	call   15d0 <free>
  return freep;
    16db:	8b 15 bc 22 00 00    	mov    0x22bc,%edx
      if((p = morecore(nunits)) == 0)
    16e1:	83 c4 10             	add    $0x10,%esp
    16e4:	85 d2                	test   %edx,%edx
    16e6:	75 c0                	jne    16a8 <malloc+0x48>
        return 0;
  }
}
    16e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    16eb:	31 c0                	xor    %eax,%eax
}
    16ed:	5b                   	pop    %ebx
    16ee:	5e                   	pop    %esi
    16ef:	5f                   	pop    %edi
    16f0:	5d                   	pop    %ebp
    16f1:	c3                   	ret    
    16f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    16f8:	39 cf                	cmp    %ecx,%edi
    16fa:	74 54                	je     1750 <malloc+0xf0>
        p->s.size -= nunits;
    16fc:	29 f9                	sub    %edi,%ecx
    16fe:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1701:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1704:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1707:	89 15 bc 22 00 00    	mov    %edx,0x22bc
}
    170d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1710:	83 c0 08             	add    $0x8,%eax
}
    1713:	5b                   	pop    %ebx
    1714:	5e                   	pop    %esi
    1715:	5f                   	pop    %edi
    1716:	5d                   	pop    %ebp
    1717:	c3                   	ret    
    1718:	90                   	nop
    1719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1720:	c7 05 bc 22 00 00 c0 	movl   $0x22c0,0x22bc
    1727:	22 00 00 
    172a:	c7 05 c0 22 00 00 c0 	movl   $0x22c0,0x22c0
    1731:	22 00 00 
    base.s.size = 0;
    1734:	b8 c0 22 00 00       	mov    $0x22c0,%eax
    1739:	c7 05 c4 22 00 00 00 	movl   $0x0,0x22c4
    1740:	00 00 00 
    1743:	e9 44 ff ff ff       	jmp    168c <malloc+0x2c>
    1748:	90                   	nop
    1749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1750:	8b 08                	mov    (%eax),%ecx
    1752:	89 0a                	mov    %ecx,(%edx)
    1754:	eb b1                	jmp    1707 <malloc+0xa7>
