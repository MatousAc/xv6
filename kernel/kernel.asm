
kernel/kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 f0 2f 10 80       	mov    $0x80102ff0,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 60 70 10 80       	push   $0x80107060
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 f5 42 00 00       	call   80104350 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 67 70 10 80       	push   $0x80107067
80100097:	50                   	push   %eax
80100098:	e8 83 41 00 00       	call   80104220 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 c0 b5 10 80       	push   $0x8010b5c0
801000e4:	e8 a7 43 00 00       	call   80104490 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 b5 10 80       	push   $0x8010b5c0
80100162:	e8 e9 43 00 00       	call   80104550 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ee 40 00 00       	call   80104260 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 ed 20 00 00       	call   80102270 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 6e 70 10 80       	push   $0x8010706e
80100198:	e8 a3 02 00 00       	call   80100440 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 4d 41 00 00       	call   80104300 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 a7 20 00 00       	jmp    80102270 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 7f 70 10 80       	push   $0x8010707f
801001d1:	e8 6a 02 00 00       	call   80100440 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 0c 41 00 00       	call   80104300 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 bc 40 00 00       	call   801042c0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 80 42 00 00       	call   80104490 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 ef 42 00 00       	jmp    80104550 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 86 70 10 80       	push   $0x80107086
80100269:	e8 d2 01 00 00       	call   80100440 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 eb 15 00 00       	call   80101870 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 ff 41 00 00       	call   80104490 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002a7:	39 15 a4 ff 10 80    	cmp    %edx,0x8010ffa4
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
    sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 a5 10 80       	push   $0x8010a520
801002c0:	68 a0 ff 10 80       	push   $0x8010ffa0
801002c5:	e8 06 3c 00 00       	call   80103ed0 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 ff 10 80    	cmp    0x8010ffa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 50 36 00 00       	call   80103930 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 a5 10 80       	push   $0x8010a520
801002ef:	e8 5c 42 00 00       	call   80104550 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 94 14 00 00       	call   80101790 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 20 ff 10 80 	movsbl -0x7fef00e0(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 a5 10 80       	push   $0x8010a520
8010034d:	e8 fe 41 00 00       	call   80104550 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 36 14 00 00       	call   80101790 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <consolesteal>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <consolesteal>:

// like consoleread, but just gets one character
int
consolesteal(struct inode *ip)
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	8b 5d 08             	mov    0x8(%ebp),%ebx
  // release(&cons.lock);
  // ilock(ip);
  // return c;
  
  int c = 1;
  iunlock(ip);
80100398:	83 ec 0c             	sub    $0xc,%esp
8010039b:	53                   	push   %ebx
8010039c:	e8 cf 14 00 00       	call   80101870 <iunlock>
  acquire(&cons.lock);
801003a1:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801003a8:	e8 e3 40 00 00       	call   80104490 <acquire>
  // cprintf("outside");
  // cprintf("input.r = %d", input.r);
  // cprintf("input.w = %d", input.w);
  // while(input.r == input.w){
  if(input.r == input.w){
801003ad:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801003b2:	83 c4 10             	add    $0x10,%esp
801003b5:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801003bb:	74 3b                	je     801003f8 <consolesteal+0x68>
    // cprintf("before sleep");
    sleep(&input.r, &cons.lock);
    // cprintf("after sleep");
  }
  c = input.buf[input.r++ % INPUT_BUF];
  release(&cons.lock);
801003bd:	83 ec 0c             	sub    $0xc,%esp
  c = input.buf[input.r++ % INPUT_BUF];
801003c0:	8d 50 01             	lea    0x1(%eax),%edx
801003c3:	83 e0 7f             	and    $0x7f,%eax
  release(&cons.lock);
801003c6:	68 20 a5 10 80       	push   $0x8010a520
  c = input.buf[input.r++ % INPUT_BUF];
801003cb:	0f be b0 20 ff 10 80 	movsbl -0x7fef00e0(%eax),%esi
801003d2:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
  release(&cons.lock);
801003d8:	e8 73 41 00 00       	call   80104550 <release>
  ilock(ip);
801003dd:	89 1c 24             	mov    %ebx,(%esp)
801003e0:	e8 ab 13 00 00       	call   80101790 <ilock>
  return c;
801003e5:	83 c4 10             	add    $0x10,%esp
}
801003e8:	8d 65 f8             	lea    -0x8(%ebp),%esp
801003eb:	89 f0                	mov    %esi,%eax
801003ed:	5b                   	pop    %ebx
801003ee:	5e                   	pop    %esi
801003ef:	5d                   	pop    %ebp
801003f0:	c3                   	ret    
801003f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
801003f8:	e8 33 35 00 00       	call   80103930 <myproc>
801003fd:	8b 40 24             	mov    0x24(%eax),%eax
80100400:	85 c0                	test   %eax,%eax
80100402:	75 1c                	jne    80100420 <consolesteal+0x90>
    sleep(&input.r, &cons.lock);
80100404:	83 ec 08             	sub    $0x8,%esp
80100407:	68 20 a5 10 80       	push   $0x8010a520
8010040c:	68 a0 ff 10 80       	push   $0x8010ffa0
80100411:	e8 ba 3a 00 00       	call   80103ed0 <sleep>
80100416:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
8010041b:	83 c4 10             	add    $0x10,%esp
8010041e:	eb 9d                	jmp    801003bd <consolesteal+0x2d>
      release(&cons.lock);
80100420:	83 ec 0c             	sub    $0xc,%esp
      ilock(ip);
80100423:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&cons.lock);
80100428:	68 20 a5 10 80       	push   $0x8010a520
8010042d:	e8 1e 41 00 00       	call   80104550 <release>
      ilock(ip);
80100432:	89 1c 24             	mov    %ebx,(%esp)
80100435:	e8 56 13 00 00       	call   80101790 <ilock>
8010043a:	83 c4 10             	add    $0x10,%esp
8010043d:	eb a9                	jmp    801003e8 <consolesteal+0x58>
8010043f:	90                   	nop

80100440 <panic>:
{
80100440:	55                   	push   %ebp
80100441:	89 e5                	mov    %esp,%ebp
80100443:	56                   	push   %esi
80100444:	53                   	push   %ebx
80100445:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100448:	fa                   	cli    
  cons.locking = 0;
80100449:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100450:	00 00 00 
  getcallerpcs(&s, pcs);
80100453:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100456:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100459:	e8 22 24 00 00       	call   80102880 <lapicid>
8010045e:	83 ec 08             	sub    $0x8,%esp
80100461:	50                   	push   %eax
80100462:	68 8d 70 10 80       	push   $0x8010708d
80100467:	e8 a4 02 00 00       	call   80100710 <cprintf>
  cprintf(s);
8010046c:	58                   	pop    %eax
8010046d:	ff 75 08             	pushl  0x8(%ebp)
80100470:	e8 9b 02 00 00       	call   80100710 <cprintf>
  cprintf("\n");
80100475:	c7 04 24 df 79 10 80 	movl   $0x801079df,(%esp)
8010047c:	e8 8f 02 00 00       	call   80100710 <cprintf>
  getcallerpcs(&s, pcs);
80100481:	5a                   	pop    %edx
80100482:	8d 45 08             	lea    0x8(%ebp),%eax
80100485:	59                   	pop    %ecx
80100486:	53                   	push   %ebx
80100487:	50                   	push   %eax
80100488:	e8 e3 3e 00 00       	call   80104370 <getcallerpcs>
8010048d:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
80100490:	83 ec 08             	sub    $0x8,%esp
80100493:	ff 33                	pushl  (%ebx)
80100495:	83 c3 04             	add    $0x4,%ebx
80100498:	68 a1 70 10 80       	push   $0x801070a1
8010049d:	e8 6e 02 00 00       	call   80100710 <cprintf>
  for(i=0; i<10; i++)
801004a2:	83 c4 10             	add    $0x10,%esp
801004a5:	39 f3                	cmp    %esi,%ebx
801004a7:	75 e7                	jne    80100490 <panic+0x50>
  panicked = 1; // freeze other CPU
801004a9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801004b0:	00 00 00 
801004b3:	eb fe                	jmp    801004b3 <panic+0x73>
801004b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801004b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801004c0 <consputc>:
  if(panicked){
801004c0:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
801004c6:	85 c9                	test   %ecx,%ecx
801004c8:	74 06                	je     801004d0 <consputc+0x10>
801004ca:	fa                   	cli    
801004cb:	eb fe                	jmp    801004cb <consputc+0xb>
801004cd:	8d 76 00             	lea    0x0(%esi),%esi
{
801004d0:	55                   	push   %ebp
801004d1:	89 e5                	mov    %esp,%ebp
801004d3:	57                   	push   %edi
801004d4:	56                   	push   %esi
801004d5:	53                   	push   %ebx
801004d6:	89 c6                	mov    %eax,%esi
801004d8:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
801004db:	3d 00 01 00 00       	cmp    $0x100,%eax
801004e0:	0f 84 b1 00 00 00    	je     80100597 <consputc+0xd7>
    uartputc(c);
801004e6:	83 ec 0c             	sub    $0xc,%esp
801004e9:	50                   	push   %eax
801004ea:	e8 71 57 00 00       	call   80105c60 <uartputc>
801004ef:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004f2:	bb d4 03 00 00       	mov    $0x3d4,%ebx
801004f7:	b8 0e 00 00 00       	mov    $0xe,%eax
801004fc:	89 da                	mov    %ebx,%edx
801004fe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801004ff:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100504:	89 ca                	mov    %ecx,%edx
80100506:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100507:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010050a:	89 da                	mov    %ebx,%edx
8010050c:	c1 e0 08             	shl    $0x8,%eax
8010050f:	89 c7                	mov    %eax,%edi
80100511:	b8 0f 00 00 00       	mov    $0xf,%eax
80100516:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100517:	89 ca                	mov    %ecx,%edx
80100519:	ec                   	in     (%dx),%al
8010051a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010051d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010051f:	83 fe 0a             	cmp    $0xa,%esi
80100522:	0f 84 f3 00 00 00    	je     8010061b <consputc+0x15b>
  else if(c == BACKSPACE){
80100528:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010052e:	0f 84 d7 00 00 00    	je     8010060b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100534:	89 f0                	mov    %esi,%eax
80100536:	0f b6 c0             	movzbl %al,%eax
80100539:	80 cc 07             	or     $0x7,%ah
8010053c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100543:	80 
80100544:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100547:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010054d:	0f 8f ab 00 00 00    	jg     801005fe <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
80100553:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
80100559:	7f 66                	jg     801005c1 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010055b:	be d4 03 00 00       	mov    $0x3d4,%esi
80100560:	b8 0e 00 00 00       	mov    $0xe,%eax
80100565:	89 f2                	mov    %esi,%edx
80100567:	ee                   	out    %al,(%dx)
80100568:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
8010056d:	89 d8                	mov    %ebx,%eax
8010056f:	c1 f8 08             	sar    $0x8,%eax
80100572:	89 ca                	mov    %ecx,%edx
80100574:	ee                   	out    %al,(%dx)
80100575:	b8 0f 00 00 00       	mov    $0xf,%eax
8010057a:	89 f2                	mov    %esi,%edx
8010057c:	ee                   	out    %al,(%dx)
8010057d:	89 d8                	mov    %ebx,%eax
8010057f:	89 ca                	mov    %ecx,%edx
80100581:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
80100582:	b8 20 07 00 00       	mov    $0x720,%eax
80100587:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
8010058e:	80 
}
8010058f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100592:	5b                   	pop    %ebx
80100593:	5e                   	pop    %esi
80100594:	5f                   	pop    %edi
80100595:	5d                   	pop    %ebp
80100596:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100597:	83 ec 0c             	sub    $0xc,%esp
8010059a:	6a 08                	push   $0x8
8010059c:	e8 bf 56 00 00       	call   80105c60 <uartputc>
801005a1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801005a8:	e8 b3 56 00 00       	call   80105c60 <uartputc>
801005ad:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801005b4:	e8 a7 56 00 00       	call   80105c60 <uartputc>
801005b9:	83 c4 10             	add    $0x10,%esp
801005bc:	e9 31 ff ff ff       	jmp    801004f2 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801005c1:	52                   	push   %edx
801005c2:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
801005c7:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801005ca:	68 a0 80 0b 80       	push   $0x800b80a0
801005cf:	68 00 80 0b 80       	push   $0x800b8000
801005d4:	e8 77 40 00 00       	call   80104650 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801005d9:	b8 80 07 00 00       	mov    $0x780,%eax
801005de:	83 c4 0c             	add    $0xc,%esp
801005e1:	29 d8                	sub    %ebx,%eax
801005e3:	01 c0                	add    %eax,%eax
801005e5:	50                   	push   %eax
801005e6:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
801005e9:	6a 00                	push   $0x0
801005eb:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
801005f0:	50                   	push   %eax
801005f1:	e8 aa 3f 00 00       	call   801045a0 <memset>
801005f6:	83 c4 10             	add    $0x10,%esp
801005f9:	e9 5d ff ff ff       	jmp    8010055b <consputc+0x9b>
    panic("pos under/overflow");
801005fe:	83 ec 0c             	sub    $0xc,%esp
80100601:	68 a5 70 10 80       	push   $0x801070a5
80100606:	e8 35 fe ff ff       	call   80100440 <panic>
    if(pos > 0) --pos;
8010060b:	85 db                	test   %ebx,%ebx
8010060d:	0f 84 48 ff ff ff    	je     8010055b <consputc+0x9b>
80100613:	83 eb 01             	sub    $0x1,%ebx
80100616:	e9 2c ff ff ff       	jmp    80100547 <consputc+0x87>
    pos += 80 - pos%80;
8010061b:	89 d8                	mov    %ebx,%eax
8010061d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100622:	99                   	cltd   
80100623:	f7 f9                	idiv   %ecx
80100625:	29 d1                	sub    %edx,%ecx
80100627:	01 cb                	add    %ecx,%ebx
80100629:	e9 19 ff ff ff       	jmp    80100547 <consputc+0x87>
8010062e:	66 90                	xchg   %ax,%ax

80100630 <printint>:
{
80100630:	55                   	push   %ebp
80100631:	89 e5                	mov    %esp,%ebp
80100633:	57                   	push   %edi
80100634:	56                   	push   %esi
80100635:	53                   	push   %ebx
80100636:	89 d3                	mov    %edx,%ebx
80100638:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010063b:	85 c9                	test   %ecx,%ecx
{
8010063d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100640:	74 04                	je     80100646 <printint+0x16>
80100642:	85 c0                	test   %eax,%eax
80100644:	78 5a                	js     801006a0 <printint+0x70>
    x = xx;
80100646:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010064d:	31 c9                	xor    %ecx,%ecx
8010064f:	8d 75 d7             	lea    -0x29(%ebp),%esi
80100652:	eb 06                	jmp    8010065a <printint+0x2a>
80100654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
80100658:	89 f9                	mov    %edi,%ecx
8010065a:	31 d2                	xor    %edx,%edx
8010065c:	8d 79 01             	lea    0x1(%ecx),%edi
8010065f:	f7 f3                	div    %ebx
80100661:	0f b6 92 d0 70 10 80 	movzbl -0x7fef8f30(%edx),%edx
  }while((x /= base) != 0);
80100668:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
8010066a:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
8010066d:	75 e9                	jne    80100658 <printint+0x28>
  if(sign)
8010066f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100672:	85 c0                	test   %eax,%eax
80100674:	74 08                	je     8010067e <printint+0x4e>
    buf[i++] = '-';
80100676:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
8010067b:	8d 79 02             	lea    0x2(%ecx),%edi
8010067e:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
80100682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
80100688:	0f be 03             	movsbl (%ebx),%eax
8010068b:	83 eb 01             	sub    $0x1,%ebx
8010068e:	e8 2d fe ff ff       	call   801004c0 <consputc>
  while(--i >= 0)
80100693:	39 f3                	cmp    %esi,%ebx
80100695:	75 f1                	jne    80100688 <printint+0x58>
}
80100697:	83 c4 2c             	add    $0x2c,%esp
8010069a:	5b                   	pop    %ebx
8010069b:	5e                   	pop    %esi
8010069c:	5f                   	pop    %edi
8010069d:	5d                   	pop    %ebp
8010069e:	c3                   	ret    
8010069f:	90                   	nop
    x = -xx;
801006a0:	f7 d8                	neg    %eax
801006a2:	eb a9                	jmp    8010064d <printint+0x1d>
801006a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801006aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801006b0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801006b0:	55                   	push   %ebp
801006b1:	89 e5                	mov    %esp,%ebp
801006b3:	57                   	push   %edi
801006b4:	56                   	push   %esi
801006b5:	53                   	push   %ebx
801006b6:	83 ec 18             	sub    $0x18,%esp
801006b9:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801006bc:	ff 75 08             	pushl  0x8(%ebp)
801006bf:	e8 ac 11 00 00       	call   80101870 <iunlock>
  acquire(&cons.lock);
801006c4:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801006cb:	e8 c0 3d 00 00       	call   80104490 <acquire>
  for(i = 0; i < n; i++)
801006d0:	83 c4 10             	add    $0x10,%esp
801006d3:	85 f6                	test   %esi,%esi
801006d5:	7e 18                	jle    801006ef <consolewrite+0x3f>
801006d7:	8b 7d 0c             	mov    0xc(%ebp),%edi
801006da:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
801006dd:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
801006e0:	0f b6 07             	movzbl (%edi),%eax
801006e3:	83 c7 01             	add    $0x1,%edi
801006e6:	e8 d5 fd ff ff       	call   801004c0 <consputc>
  for(i = 0; i < n; i++)
801006eb:	39 fb                	cmp    %edi,%ebx
801006ed:	75 f1                	jne    801006e0 <consolewrite+0x30>
  release(&cons.lock);
801006ef:	83 ec 0c             	sub    $0xc,%esp
801006f2:	68 20 a5 10 80       	push   $0x8010a520
801006f7:	e8 54 3e 00 00       	call   80104550 <release>
  ilock(ip);
801006fc:	58                   	pop    %eax
801006fd:	ff 75 08             	pushl  0x8(%ebp)
80100700:	e8 8b 10 00 00       	call   80101790 <ilock>

  return n;
}
80100705:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100708:	89 f0                	mov    %esi,%eax
8010070a:	5b                   	pop    %ebx
8010070b:	5e                   	pop    %esi
8010070c:	5f                   	pop    %edi
8010070d:	5d                   	pop    %ebp
8010070e:	c3                   	ret    
8010070f:	90                   	nop

80100710 <cprintf>:
{
80100710:	55                   	push   %ebp
80100711:	89 e5                	mov    %esp,%ebp
80100713:	57                   	push   %edi
80100714:	56                   	push   %esi
80100715:	53                   	push   %ebx
80100716:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100719:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010071e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100720:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100723:	0f 85 6f 01 00 00    	jne    80100898 <cprintf+0x188>
  if (fmt == 0)
80100729:	8b 45 08             	mov    0x8(%ebp),%eax
8010072c:	85 c0                	test   %eax,%eax
8010072e:	89 c7                	mov    %eax,%edi
80100730:	0f 84 77 01 00 00    	je     801008ad <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100736:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100739:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010073c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010073e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100741:	85 c0                	test   %eax,%eax
80100743:	75 56                	jne    8010079b <cprintf+0x8b>
80100745:	eb 79                	jmp    801007c0 <cprintf+0xb0>
80100747:	89 f6                	mov    %esi,%esi
80100749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
80100750:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
80100753:	85 d2                	test   %edx,%edx
80100755:	74 69                	je     801007c0 <cprintf+0xb0>
80100757:	83 c3 02             	add    $0x2,%ebx
    switch(c){
8010075a:	83 fa 70             	cmp    $0x70,%edx
8010075d:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
80100760:	0f 84 84 00 00 00    	je     801007ea <cprintf+0xda>
80100766:	7f 78                	jg     801007e0 <cprintf+0xd0>
80100768:	83 fa 25             	cmp    $0x25,%edx
8010076b:	0f 84 ff 00 00 00    	je     80100870 <cprintf+0x160>
80100771:	83 fa 64             	cmp    $0x64,%edx
80100774:	0f 85 8e 00 00 00    	jne    80100808 <cprintf+0xf8>
      printint(*argp++, 10, 1);
8010077a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077d:	ba 0a 00 00 00       	mov    $0xa,%edx
80100782:	8d 48 04             	lea    0x4(%eax),%ecx
80100785:	8b 00                	mov    (%eax),%eax
80100787:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010078a:	b9 01 00 00 00       	mov    $0x1,%ecx
8010078f:	e8 9c fe ff ff       	call   80100630 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100794:	0f b6 06             	movzbl (%esi),%eax
80100797:	85 c0                	test   %eax,%eax
80100799:	74 25                	je     801007c0 <cprintf+0xb0>
8010079b:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
8010079e:	83 f8 25             	cmp    $0x25,%eax
801007a1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801007a4:	74 aa                	je     80100750 <cprintf+0x40>
801007a6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801007a9:	e8 12 fd ff ff       	call   801004c0 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007ae:	0f b6 06             	movzbl (%esi),%eax
      continue;
801007b1:	8b 55 e0             	mov    -0x20(%ebp),%edx
801007b4:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007b6:	85 c0                	test   %eax,%eax
801007b8:	75 e1                	jne    8010079b <cprintf+0x8b>
801007ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
801007c0:	8b 45 dc             	mov    -0x24(%ebp),%eax
801007c3:	85 c0                	test   %eax,%eax
801007c5:	74 10                	je     801007d7 <cprintf+0xc7>
    release(&cons.lock);
801007c7:	83 ec 0c             	sub    $0xc,%esp
801007ca:	68 20 a5 10 80       	push   $0x8010a520
801007cf:	e8 7c 3d 00 00       	call   80104550 <release>
801007d4:	83 c4 10             	add    $0x10,%esp
}
801007d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801007da:	5b                   	pop    %ebx
801007db:	5e                   	pop    %esi
801007dc:	5f                   	pop    %edi
801007dd:	5d                   	pop    %ebp
801007de:	c3                   	ret    
801007df:	90                   	nop
    switch(c){
801007e0:	83 fa 73             	cmp    $0x73,%edx
801007e3:	74 43                	je     80100828 <cprintf+0x118>
801007e5:	83 fa 78             	cmp    $0x78,%edx
801007e8:	75 1e                	jne    80100808 <cprintf+0xf8>
      printint(*argp++, 16, 0);
801007ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801007ed:	ba 10 00 00 00       	mov    $0x10,%edx
801007f2:	8d 48 04             	lea    0x4(%eax),%ecx
801007f5:	8b 00                	mov    (%eax),%eax
801007f7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801007fa:	31 c9                	xor    %ecx,%ecx
801007fc:	e8 2f fe ff ff       	call   80100630 <printint>
      break;
80100801:	eb 91                	jmp    80100794 <cprintf+0x84>
80100803:	90                   	nop
80100804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100808:	b8 25 00 00 00       	mov    $0x25,%eax
8010080d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100810:	e8 ab fc ff ff       	call   801004c0 <consputc>
      consputc(c);
80100815:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100818:	89 d0                	mov    %edx,%eax
8010081a:	e8 a1 fc ff ff       	call   801004c0 <consputc>
      break;
8010081f:	e9 70 ff ff ff       	jmp    80100794 <cprintf+0x84>
80100824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100828:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010082b:	8b 10                	mov    (%eax),%edx
8010082d:	8d 48 04             	lea    0x4(%eax),%ecx
80100830:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100833:	85 d2                	test   %edx,%edx
80100835:	74 49                	je     80100880 <cprintf+0x170>
      for(; *s; s++)
80100837:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010083a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010083d:	84 c0                	test   %al,%al
8010083f:	0f 84 4f ff ff ff    	je     80100794 <cprintf+0x84>
80100845:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100848:	89 d3                	mov    %edx,%ebx
8010084a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100850:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
80100853:	e8 68 fc ff ff       	call   801004c0 <consputc>
      for(; *s; s++)
80100858:	0f be 03             	movsbl (%ebx),%eax
8010085b:	84 c0                	test   %al,%al
8010085d:	75 f1                	jne    80100850 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
8010085f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100862:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80100865:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100868:	e9 27 ff ff ff       	jmp    80100794 <cprintf+0x84>
8010086d:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
80100870:	b8 25 00 00 00       	mov    $0x25,%eax
80100875:	e8 46 fc ff ff       	call   801004c0 <consputc>
      break;
8010087a:	e9 15 ff ff ff       	jmp    80100794 <cprintf+0x84>
8010087f:	90                   	nop
        s = "(null)";
80100880:	ba b8 70 10 80       	mov    $0x801070b8,%edx
      for(; *s; s++)
80100885:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100888:	b8 28 00 00 00       	mov    $0x28,%eax
8010088d:	89 d3                	mov    %edx,%ebx
8010088f:	eb bf                	jmp    80100850 <cprintf+0x140>
80100891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
80100898:	83 ec 0c             	sub    $0xc,%esp
8010089b:	68 20 a5 10 80       	push   $0x8010a520
801008a0:	e8 eb 3b 00 00       	call   80104490 <acquire>
801008a5:	83 c4 10             	add    $0x10,%esp
801008a8:	e9 7c fe ff ff       	jmp    80100729 <cprintf+0x19>
    panic("null fmt");
801008ad:	83 ec 0c             	sub    $0xc,%esp
801008b0:	68 bf 70 10 80       	push   $0x801070bf
801008b5:	e8 86 fb ff ff       	call   80100440 <panic>
801008ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801008c0 <consoleintr>:
{
801008c0:	55                   	push   %ebp
801008c1:	89 e5                	mov    %esp,%ebp
801008c3:	57                   	push   %edi
801008c4:	56                   	push   %esi
801008c5:	53                   	push   %ebx
  int c, doprocdump = 0;
801008c6:	31 f6                	xor    %esi,%esi
{
801008c8:	83 ec 18             	sub    $0x18,%esp
801008cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801008ce:	68 20 a5 10 80       	push   $0x8010a520
801008d3:	e8 b8 3b 00 00       	call   80104490 <acquire>
  while((c = getc()) >= 0){
801008d8:	83 c4 10             	add    $0x10,%esp
801008db:	90                   	nop
801008dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801008e0:	ff d3                	call   *%ebx
801008e2:	85 c0                	test   %eax,%eax
801008e4:	89 c7                	mov    %eax,%edi
801008e6:	78 48                	js     80100930 <consoleintr+0x70>
    switch(c){
801008e8:	83 ff 10             	cmp    $0x10,%edi
801008eb:	0f 84 e7 00 00 00    	je     801009d8 <consoleintr+0x118>
801008f1:	7e 5d                	jle    80100950 <consoleintr+0x90>
801008f3:	83 ff 15             	cmp    $0x15,%edi
801008f6:	0f 84 ec 00 00 00    	je     801009e8 <consoleintr+0x128>
801008fc:	83 ff 7f             	cmp    $0x7f,%edi
801008ff:	75 54                	jne    80100955 <consoleintr+0x95>
      if(input.e != input.w){
80100901:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100906:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010090c:	74 d2                	je     801008e0 <consoleintr+0x20>
        input.e--;
8010090e:	83 e8 01             	sub    $0x1,%eax
80100911:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100916:	b8 00 01 00 00       	mov    $0x100,%eax
8010091b:	e8 a0 fb ff ff       	call   801004c0 <consputc>
  while((c = getc()) >= 0){
80100920:	ff d3                	call   *%ebx
80100922:	85 c0                	test   %eax,%eax
80100924:	89 c7                	mov    %eax,%edi
80100926:	79 c0                	jns    801008e8 <consoleintr+0x28>
80100928:	90                   	nop
80100929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100930:	83 ec 0c             	sub    $0xc,%esp
80100933:	68 20 a5 10 80       	push   $0x8010a520
80100938:	e8 13 3c 00 00       	call   80104550 <release>
  if(doprocdump) {
8010093d:	83 c4 10             	add    $0x10,%esp
80100940:	85 f6                	test   %esi,%esi
80100942:	0f 85 f8 00 00 00    	jne    80100a40 <consoleintr+0x180>
}
80100948:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010094b:	5b                   	pop    %ebx
8010094c:	5e                   	pop    %esi
8010094d:	5f                   	pop    %edi
8010094e:	5d                   	pop    %ebp
8010094f:	c3                   	ret    
    switch(c){
80100950:	83 ff 08             	cmp    $0x8,%edi
80100953:	74 ac                	je     80100901 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100955:	85 ff                	test   %edi,%edi
80100957:	74 87                	je     801008e0 <consoleintr+0x20>
80100959:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010095e:	89 c2                	mov    %eax,%edx
80100960:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
80100966:	83 fa 7f             	cmp    $0x7f,%edx
80100969:	0f 87 71 ff ff ff    	ja     801008e0 <consoleintr+0x20>
8010096f:	8d 50 01             	lea    0x1(%eax),%edx
80100972:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100975:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100978:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        c = (c == '\r') ? '\n' : c;
8010097e:	0f 84 cc 00 00 00    	je     80100a50 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
80100984:	89 f9                	mov    %edi,%ecx
80100986:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
8010098c:	89 f8                	mov    %edi,%eax
8010098e:	e8 2d fb ff ff       	call   801004c0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100993:	83 ff 0a             	cmp    $0xa,%edi
80100996:	0f 84 c5 00 00 00    	je     80100a61 <consoleintr+0x1a1>
8010099c:	83 ff 04             	cmp    $0x4,%edi
8010099f:	0f 84 bc 00 00 00    	je     80100a61 <consoleintr+0x1a1>
801009a5:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801009aa:	83 e8 80             	sub    $0xffffff80,%eax
801009ad:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
801009b3:	0f 85 27 ff ff ff    	jne    801008e0 <consoleintr+0x20>
          wakeup(&input.r);
801009b9:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
801009bc:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
801009c1:	68 a0 ff 10 80       	push   $0x8010ffa0
801009c6:	e8 b5 36 00 00       	call   80104080 <wakeup>
801009cb:	83 c4 10             	add    $0x10,%esp
801009ce:	e9 0d ff ff ff       	jmp    801008e0 <consoleintr+0x20>
801009d3:	90                   	nop
801009d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
801009d8:	be 01 00 00 00       	mov    $0x1,%esi
801009dd:	e9 fe fe ff ff       	jmp    801008e0 <consoleintr+0x20>
801009e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
801009e8:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801009ed:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
801009f3:	75 2b                	jne    80100a20 <consoleintr+0x160>
801009f5:	e9 e6 fe ff ff       	jmp    801008e0 <consoleintr+0x20>
801009fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100a00:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100a05:	b8 00 01 00 00       	mov    $0x100,%eax
80100a0a:	e8 b1 fa ff ff       	call   801004c0 <consputc>
      while(input.e != input.w &&
80100a0f:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100a14:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
80100a1a:	0f 84 c0 fe ff ff    	je     801008e0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100a20:	83 e8 01             	sub    $0x1,%eax
80100a23:	89 c2                	mov    %eax,%edx
80100a25:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100a28:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
80100a2f:	75 cf                	jne    80100a00 <consoleintr+0x140>
80100a31:	e9 aa fe ff ff       	jmp    801008e0 <consoleintr+0x20>
80100a36:	8d 76 00             	lea    0x0(%esi),%esi
80100a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100a40:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a43:	5b                   	pop    %ebx
80100a44:	5e                   	pop    %esi
80100a45:	5f                   	pop    %edi
80100a46:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a47:	e9 14 37 00 00       	jmp    80104160 <procdump>
80100a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
80100a50:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
80100a57:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a5c:	e8 5f fa ff ff       	call   801004c0 <consputc>
80100a61:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100a66:	e9 4e ff ff ff       	jmp    801009b9 <consoleintr+0xf9>
80100a6b:	90                   	nop
80100a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100a70 <consoleinit>:

void
consoleinit(void)
{
80100a70:	55                   	push   %ebp
80100a71:	89 e5                	mov    %esp,%ebp
80100a73:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a76:	68 c8 70 10 80       	push   $0x801070c8
80100a7b:	68 20 a5 10 80       	push   $0x8010a520
80100a80:	e8 cb 38 00 00       	call   80104350 <initlock>
  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  devsw[CONSOLE].steal = consolesteal;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a85:	58                   	pop    %eax
80100a86:	5a                   	pop    %edx
80100a87:	6a 00                	push   $0x0
80100a89:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100a8b:	c7 05 74 09 11 80 b0 	movl   $0x801006b0,0x80110974
80100a92:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100a95:	c7 05 6c 09 11 80 70 	movl   $0x80100270,0x8011096c
80100a9c:	02 10 80 
  devsw[CONSOLE].steal = consolesteal;
80100a9f:	c7 05 70 09 11 80 90 	movl   $0x80100390,0x80110970
80100aa6:	03 10 80 
  cons.locking = 1;
80100aa9:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
80100ab0:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100ab3:	e8 68 19 00 00       	call   80102420 <ioapicenable>
}
80100ab8:	83 c4 10             	add    $0x10,%esp
80100abb:	c9                   	leave  
80100abc:	c3                   	ret    
80100abd:	66 90                	xchg   %ax,%ax
80100abf:	90                   	nop

80100ac0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100ac0:	55                   	push   %ebp
80100ac1:	89 e5                	mov    %esp,%ebp
80100ac3:	57                   	push   %edi
80100ac4:	56                   	push   %esi
80100ac5:	53                   	push   %ebx
80100ac6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100acc:	e8 5f 2e 00 00       	call   80103930 <myproc>
80100ad1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100ad7:	e8 14 22 00 00       	call   80102cf0 <begin_op>

  if((ip = namei(path)) == 0){
80100adc:	83 ec 0c             	sub    $0xc,%esp
80100adf:	ff 75 08             	pushl  0x8(%ebp)
80100ae2:	e8 49 15 00 00       	call   80102030 <namei>
80100ae7:	83 c4 10             	add    $0x10,%esp
80100aea:	85 c0                	test   %eax,%eax
80100aec:	0f 84 91 01 00 00    	je     80100c83 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100af2:	83 ec 0c             	sub    $0xc,%esp
80100af5:	89 c3                	mov    %eax,%ebx
80100af7:	50                   	push   %eax
80100af8:	e8 93 0c 00 00       	call   80101790 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100afd:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100b03:	6a 34                	push   $0x34
80100b05:	6a 00                	push   $0x0
80100b07:	50                   	push   %eax
80100b08:	53                   	push   %ebx
80100b09:	e8 62 0f 00 00       	call   80101a70 <readi>
80100b0e:	83 c4 20             	add    $0x20,%esp
80100b11:	83 f8 34             	cmp    $0x34,%eax
80100b14:	74 22                	je     80100b38 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100b16:	83 ec 0c             	sub    $0xc,%esp
80100b19:	53                   	push   %ebx
80100b1a:	e8 01 0f 00 00       	call   80101a20 <iunlockput>
    end_op();
80100b1f:	e8 3c 22 00 00       	call   80102d60 <end_op>
80100b24:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100b27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100b2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b2f:	5b                   	pop    %ebx
80100b30:	5e                   	pop    %esi
80100b31:	5f                   	pop    %edi
80100b32:	5d                   	pop    %ebp
80100b33:	c3                   	ret    
80100b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100b38:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b3f:	45 4c 46 
80100b42:	75 d2                	jne    80100b16 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100b44:	e8 67 62 00 00       	call   80106db0 <setupkvm>
80100b49:	85 c0                	test   %eax,%eax
80100b4b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b51:	74 c3                	je     80100b16 <exec+0x56>
  sz = 0;
80100b53:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b55:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b5c:	00 
80100b5d:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100b63:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100b69:	0f 84 8c 02 00 00    	je     80100dfb <exec+0x33b>
80100b6f:	31 f6                	xor    %esi,%esi
80100b71:	eb 7f                	jmp    80100bf2 <exec+0x132>
80100b73:	90                   	nop
80100b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100b78:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b7f:	75 63                	jne    80100be4 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100b81:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b87:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b8d:	0f 82 86 00 00 00    	jb     80100c19 <exec+0x159>
80100b93:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b99:	72 7e                	jb     80100c19 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b9b:	83 ec 04             	sub    $0x4,%esp
80100b9e:	50                   	push   %eax
80100b9f:	57                   	push   %edi
80100ba0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100ba6:	e8 25 60 00 00       	call   80106bd0 <allocuvm>
80100bab:	83 c4 10             	add    $0x10,%esp
80100bae:	85 c0                	test   %eax,%eax
80100bb0:	89 c7                	mov    %eax,%edi
80100bb2:	74 65                	je     80100c19 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100bb4:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bba:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bbf:	75 58                	jne    80100c19 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100bc1:	83 ec 0c             	sub    $0xc,%esp
80100bc4:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100bca:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100bd0:	53                   	push   %ebx
80100bd1:	50                   	push   %eax
80100bd2:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bd8:	e8 33 5f 00 00       	call   80106b10 <loaduvm>
80100bdd:	83 c4 20             	add    $0x20,%esp
80100be0:	85 c0                	test   %eax,%eax
80100be2:	78 35                	js     80100c19 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100be4:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100beb:	83 c6 01             	add    $0x1,%esi
80100bee:	39 f0                	cmp    %esi,%eax
80100bf0:	7e 3d                	jle    80100c2f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bf2:	89 f0                	mov    %esi,%eax
80100bf4:	6a 20                	push   $0x20
80100bf6:	c1 e0 05             	shl    $0x5,%eax
80100bf9:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100bff:	50                   	push   %eax
80100c00:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100c06:	50                   	push   %eax
80100c07:	53                   	push   %ebx
80100c08:	e8 63 0e 00 00       	call   80101a70 <readi>
80100c0d:	83 c4 10             	add    $0x10,%esp
80100c10:	83 f8 20             	cmp    $0x20,%eax
80100c13:	0f 84 5f ff ff ff    	je     80100b78 <exec+0xb8>
    freevm(pgdir);
80100c19:	83 ec 0c             	sub    $0xc,%esp
80100c1c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c22:	e8 09 61 00 00       	call   80106d30 <freevm>
80100c27:	83 c4 10             	add    $0x10,%esp
80100c2a:	e9 e7 fe ff ff       	jmp    80100b16 <exec+0x56>
80100c2f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100c35:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100c3b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100c41:	83 ec 0c             	sub    $0xc,%esp
80100c44:	53                   	push   %ebx
80100c45:	e8 d6 0d 00 00       	call   80101a20 <iunlockput>
  end_op();
80100c4a:	e8 11 21 00 00       	call   80102d60 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c4f:	83 c4 0c             	add    $0xc,%esp
80100c52:	56                   	push   %esi
80100c53:	57                   	push   %edi
80100c54:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c5a:	e8 71 5f 00 00       	call   80106bd0 <allocuvm>
80100c5f:	83 c4 10             	add    $0x10,%esp
80100c62:	85 c0                	test   %eax,%eax
80100c64:	89 c6                	mov    %eax,%esi
80100c66:	75 3a                	jne    80100ca2 <exec+0x1e2>
    freevm(pgdir);
80100c68:	83 ec 0c             	sub    $0xc,%esp
80100c6b:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c71:	e8 ba 60 00 00       	call   80106d30 <freevm>
80100c76:	83 c4 10             	add    $0x10,%esp
  return -1;
80100c79:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c7e:	e9 a9 fe ff ff       	jmp    80100b2c <exec+0x6c>
    end_op();
80100c83:	e8 d8 20 00 00       	call   80102d60 <end_op>
    cprintf("exec: fail\n");
80100c88:	83 ec 0c             	sub    $0xc,%esp
80100c8b:	68 e1 70 10 80       	push   $0x801070e1
80100c90:	e8 7b fa ff ff       	call   80100710 <cprintf>
    return -1;
80100c95:	83 c4 10             	add    $0x10,%esp
80100c98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c9d:	e9 8a fe ff ff       	jmp    80100b2c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100ca2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100ca8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100cab:	31 ff                	xor    %edi,%edi
80100cad:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100caf:	50                   	push   %eax
80100cb0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100cb6:	e8 95 61 00 00       	call   80106e50 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100cbb:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cbe:	83 c4 10             	add    $0x10,%esp
80100cc1:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100cc7:	8b 00                	mov    (%eax),%eax
80100cc9:	85 c0                	test   %eax,%eax
80100ccb:	74 70                	je     80100d3d <exec+0x27d>
80100ccd:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100cd3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100cd9:	eb 0a                	jmp    80100ce5 <exec+0x225>
80100cdb:	90                   	nop
80100cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100ce0:	83 ff 20             	cmp    $0x20,%edi
80100ce3:	74 83                	je     80100c68 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ce5:	83 ec 0c             	sub    $0xc,%esp
80100ce8:	50                   	push   %eax
80100ce9:	e8 d2 3a 00 00       	call   801047c0 <strlen>
80100cee:	f7 d0                	not    %eax
80100cf0:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cf2:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cf5:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cf6:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cf9:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cfc:	e8 bf 3a 00 00       	call   801047c0 <strlen>
80100d01:	83 c0 01             	add    $0x1,%eax
80100d04:	50                   	push   %eax
80100d05:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d08:	ff 34 b8             	pushl  (%eax,%edi,4)
80100d0b:	53                   	push   %ebx
80100d0c:	56                   	push   %esi
80100d0d:	e8 9e 62 00 00       	call   80106fb0 <copyout>
80100d12:	83 c4 20             	add    $0x20,%esp
80100d15:	85 c0                	test   %eax,%eax
80100d17:	0f 88 4b ff ff ff    	js     80100c68 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100d1d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100d20:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100d27:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100d2a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100d30:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100d33:	85 c0                	test   %eax,%eax
80100d35:	75 a9                	jne    80100ce0 <exec+0x220>
80100d37:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d3d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100d44:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100d46:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100d4d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100d51:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d58:	ff ff ff 
  ustack[1] = argc;
80100d5b:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d61:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100d63:	83 c0 0c             	add    $0xc,%eax
80100d66:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d68:	50                   	push   %eax
80100d69:	52                   	push   %edx
80100d6a:	53                   	push   %ebx
80100d6b:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d71:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d77:	e8 34 62 00 00       	call   80106fb0 <copyout>
80100d7c:	83 c4 10             	add    $0x10,%esp
80100d7f:	85 c0                	test   %eax,%eax
80100d81:	0f 88 e1 fe ff ff    	js     80100c68 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100d87:	8b 45 08             	mov    0x8(%ebp),%eax
80100d8a:	0f b6 00             	movzbl (%eax),%eax
80100d8d:	84 c0                	test   %al,%al
80100d8f:	74 17                	je     80100da8 <exec+0x2e8>
80100d91:	8b 55 08             	mov    0x8(%ebp),%edx
80100d94:	89 d1                	mov    %edx,%ecx
80100d96:	83 c1 01             	add    $0x1,%ecx
80100d99:	3c 2f                	cmp    $0x2f,%al
80100d9b:	0f b6 01             	movzbl (%ecx),%eax
80100d9e:	0f 44 d1             	cmove  %ecx,%edx
80100da1:	84 c0                	test   %al,%al
80100da3:	75 f1                	jne    80100d96 <exec+0x2d6>
80100da5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100da8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100dae:	50                   	push   %eax
80100daf:	6a 10                	push   $0x10
80100db1:	ff 75 08             	pushl  0x8(%ebp)
80100db4:	89 f8                	mov    %edi,%eax
80100db6:	83 c0 70             	add    $0x70,%eax
80100db9:	50                   	push   %eax
80100dba:	e8 c1 39 00 00       	call   80104780 <safestrcpy>
  curproc->pgdir = pgdir;
80100dbf:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100dc5:	89 f9                	mov    %edi,%ecx
80100dc7:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80100dca:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->sz = sz;
80100dcd:	89 31                	mov    %esi,(%ecx)
  curproc->pgdir = pgdir;
80100dcf:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100dd2:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100dd8:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100ddb:	8b 41 18             	mov    0x18(%ecx),%eax
80100dde:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100de1:	89 0c 24             	mov    %ecx,(%esp)
80100de4:	e8 97 5b 00 00       	call   80106980 <switchuvm>
  freevm(oldpgdir);
80100de9:	89 3c 24             	mov    %edi,(%esp)
80100dec:	e8 3f 5f 00 00       	call   80106d30 <freevm>
  return 0;
80100df1:	83 c4 10             	add    $0x10,%esp
80100df4:	31 c0                	xor    %eax,%eax
80100df6:	e9 31 fd ff ff       	jmp    80100b2c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100dfb:	be 00 20 00 00       	mov    $0x2000,%esi
80100e00:	e9 3c fe ff ff       	jmp    80100c41 <exec+0x181>
80100e05:	66 90                	xchg   %ax,%ax
80100e07:	66 90                	xchg   %ax,%ax
80100e09:	66 90                	xchg   %ax,%ax
80100e0b:	66 90                	xchg   %ax,%ax
80100e0d:	66 90                	xchg   %ax,%ax
80100e0f:	90                   	nop

80100e10 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e10:	55                   	push   %ebp
80100e11:	89 e5                	mov    %esp,%ebp
80100e13:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100e16:	68 ed 70 10 80       	push   $0x801070ed
80100e1b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e20:	e8 2b 35 00 00       	call   80104350 <initlock>
}
80100e25:	83 c4 10             	add    $0x10,%esp
80100e28:	c9                   	leave  
80100e29:	c3                   	ret    
80100e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e30 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e34:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
{
80100e39:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e3c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e41:	e8 4a 36 00 00       	call   80104490 <acquire>
80100e46:	83 c4 10             	add    $0x10,%esp
80100e49:	eb 10                	jmp    80100e5b <filealloc+0x2b>
80100e4b:	90                   	nop
80100e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e50:	83 c3 18             	add    $0x18,%ebx
80100e53:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100e59:	73 25                	jae    80100e80 <filealloc+0x50>
    if(f->ref == 0){
80100e5b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e5e:	85 c0                	test   %eax,%eax
80100e60:	75 ee                	jne    80100e50 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e62:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e65:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e6c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e71:	e8 da 36 00 00       	call   80104550 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e76:	89 d8                	mov    %ebx,%eax
      return f;
80100e78:	83 c4 10             	add    $0x10,%esp
}
80100e7b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e7e:	c9                   	leave  
80100e7f:	c3                   	ret    
  release(&ftable.lock);
80100e80:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e83:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e85:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e8a:	e8 c1 36 00 00       	call   80104550 <release>
}
80100e8f:	89 d8                	mov    %ebx,%eax
  return 0;
80100e91:	83 c4 10             	add    $0x10,%esp
}
80100e94:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e97:	c9                   	leave  
80100e98:	c3                   	ret    
80100e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ea0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100ea0:	55                   	push   %ebp
80100ea1:	89 e5                	mov    %esp,%ebp
80100ea3:	53                   	push   %ebx
80100ea4:	83 ec 10             	sub    $0x10,%esp
80100ea7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100eaa:	68 c0 ff 10 80       	push   $0x8010ffc0
80100eaf:	e8 dc 35 00 00       	call   80104490 <acquire>
  if(f->ref < 1)
80100eb4:	8b 43 04             	mov    0x4(%ebx),%eax
80100eb7:	83 c4 10             	add    $0x10,%esp
80100eba:	85 c0                	test   %eax,%eax
80100ebc:	7e 1a                	jle    80100ed8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100ebe:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100ec1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100ec4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ec7:	68 c0 ff 10 80       	push   $0x8010ffc0
80100ecc:	e8 7f 36 00 00       	call   80104550 <release>
  return f;
}
80100ed1:	89 d8                	mov    %ebx,%eax
80100ed3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ed6:	c9                   	leave  
80100ed7:	c3                   	ret    
    panic("filedup");
80100ed8:	83 ec 0c             	sub    $0xc,%esp
80100edb:	68 f4 70 10 80       	push   $0x801070f4
80100ee0:	e8 5b f5 ff ff       	call   80100440 <panic>
80100ee5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100ef0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100ef0:	55                   	push   %ebp
80100ef1:	89 e5                	mov    %esp,%ebp
80100ef3:	57                   	push   %edi
80100ef4:	56                   	push   %esi
80100ef5:	53                   	push   %ebx
80100ef6:	83 ec 28             	sub    $0x28,%esp
80100ef9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100efc:	68 c0 ff 10 80       	push   $0x8010ffc0
80100f01:	e8 8a 35 00 00       	call   80104490 <acquire>
  if(f->ref < 1)
80100f06:	8b 43 04             	mov    0x4(%ebx),%eax
80100f09:	83 c4 10             	add    $0x10,%esp
80100f0c:	85 c0                	test   %eax,%eax
80100f0e:	0f 8e 9b 00 00 00    	jle    80100faf <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100f14:	83 e8 01             	sub    $0x1,%eax
80100f17:	85 c0                	test   %eax,%eax
80100f19:	89 43 04             	mov    %eax,0x4(%ebx)
80100f1c:	74 1a                	je     80100f38 <fileclose+0x48>
    release(&ftable.lock);
80100f1e:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f25:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f28:	5b                   	pop    %ebx
80100f29:	5e                   	pop    %esi
80100f2a:	5f                   	pop    %edi
80100f2b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f2c:	e9 1f 36 00 00       	jmp    80104550 <release>
80100f31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100f38:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100f3c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100f3e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f41:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100f44:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f4a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f4d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100f50:	68 c0 ff 10 80       	push   $0x8010ffc0
  ff = *f;
80100f55:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f58:	e8 f3 35 00 00       	call   80104550 <release>
  if(ff.type == FD_PIPE)
80100f5d:	83 c4 10             	add    $0x10,%esp
80100f60:	83 ff 01             	cmp    $0x1,%edi
80100f63:	74 13                	je     80100f78 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100f65:	83 ff 02             	cmp    $0x2,%edi
80100f68:	74 26                	je     80100f90 <fileclose+0xa0>
}
80100f6a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f6d:	5b                   	pop    %ebx
80100f6e:	5e                   	pop    %esi
80100f6f:	5f                   	pop    %edi
80100f70:	5d                   	pop    %ebp
80100f71:	c3                   	ret    
80100f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100f78:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f7c:	83 ec 08             	sub    $0x8,%esp
80100f7f:	53                   	push   %ebx
80100f80:	56                   	push   %esi
80100f81:	e8 1a 25 00 00       	call   801034a0 <pipeclose>
80100f86:	83 c4 10             	add    $0x10,%esp
80100f89:	eb df                	jmp    80100f6a <fileclose+0x7a>
80100f8b:	90                   	nop
80100f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100f90:	e8 5b 1d 00 00       	call   80102cf0 <begin_op>
    iput(ff.ip);
80100f95:	83 ec 0c             	sub    $0xc,%esp
80100f98:	ff 75 e0             	pushl  -0x20(%ebp)
80100f9b:	e8 20 09 00 00       	call   801018c0 <iput>
    end_op();
80100fa0:	83 c4 10             	add    $0x10,%esp
}
80100fa3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fa6:	5b                   	pop    %ebx
80100fa7:	5e                   	pop    %esi
80100fa8:	5f                   	pop    %edi
80100fa9:	5d                   	pop    %ebp
    end_op();
80100faa:	e9 b1 1d 00 00       	jmp    80102d60 <end_op>
    panic("fileclose");
80100faf:	83 ec 0c             	sub    $0xc,%esp
80100fb2:	68 fc 70 10 80       	push   $0x801070fc
80100fb7:	e8 84 f4 ff ff       	call   80100440 <panic>
80100fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fc0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100fc0:	55                   	push   %ebp
80100fc1:	89 e5                	mov    %esp,%ebp
80100fc3:	53                   	push   %ebx
80100fc4:	83 ec 04             	sub    $0x4,%esp
80100fc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100fca:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fcd:	75 31                	jne    80101000 <filestat+0x40>
    ilock(f->ip);
80100fcf:	83 ec 0c             	sub    $0xc,%esp
80100fd2:	ff 73 10             	pushl  0x10(%ebx)
80100fd5:	e8 b6 07 00 00       	call   80101790 <ilock>
    stati(f->ip, st);
80100fda:	58                   	pop    %eax
80100fdb:	5a                   	pop    %edx
80100fdc:	ff 75 0c             	pushl  0xc(%ebp)
80100fdf:	ff 73 10             	pushl  0x10(%ebx)
80100fe2:	e8 59 0a 00 00       	call   80101a40 <stati>
    iunlock(f->ip);
80100fe7:	59                   	pop    %ecx
80100fe8:	ff 73 10             	pushl  0x10(%ebx)
80100feb:	e8 80 08 00 00       	call   80101870 <iunlock>
    return 0;
80100ff0:	83 c4 10             	add    $0x10,%esp
80100ff3:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100ff5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ff8:	c9                   	leave  
80100ff9:	c3                   	ret    
80100ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80101000:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101005:	eb ee                	jmp    80100ff5 <filestat+0x35>
80101007:	89 f6                	mov    %esi,%esi
80101009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101010 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101010:	55                   	push   %ebp
80101011:	89 e5                	mov    %esp,%ebp
80101013:	57                   	push   %edi
80101014:	56                   	push   %esi
80101015:	53                   	push   %ebx
80101016:	83 ec 0c             	sub    $0xc,%esp
80101019:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010101c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010101f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101022:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101026:	74 60                	je     80101088 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101028:	8b 03                	mov    (%ebx),%eax
8010102a:	83 f8 01             	cmp    $0x1,%eax
8010102d:	74 41                	je     80101070 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010102f:	83 f8 02             	cmp    $0x2,%eax
80101032:	75 5b                	jne    8010108f <fileread+0x7f>
    ilock(f->ip);
80101034:	83 ec 0c             	sub    $0xc,%esp
80101037:	ff 73 10             	pushl  0x10(%ebx)
8010103a:	e8 51 07 00 00       	call   80101790 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010103f:	57                   	push   %edi
80101040:	ff 73 14             	pushl  0x14(%ebx)
80101043:	56                   	push   %esi
80101044:	ff 73 10             	pushl  0x10(%ebx)
80101047:	e8 24 0a 00 00       	call   80101a70 <readi>
8010104c:	83 c4 20             	add    $0x20,%esp
8010104f:	85 c0                	test   %eax,%eax
80101051:	89 c6                	mov    %eax,%esi
80101053:	7e 03                	jle    80101058 <fileread+0x48>
      f->off += r;
80101055:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101058:	83 ec 0c             	sub    $0xc,%esp
8010105b:	ff 73 10             	pushl  0x10(%ebx)
8010105e:	e8 0d 08 00 00       	call   80101870 <iunlock>
    return r;
80101063:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101066:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101069:	89 f0                	mov    %esi,%eax
8010106b:	5b                   	pop    %ebx
8010106c:	5e                   	pop    %esi
8010106d:	5f                   	pop    %edi
8010106e:	5d                   	pop    %ebp
8010106f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101070:	8b 43 0c             	mov    0xc(%ebx),%eax
80101073:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101076:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101079:	5b                   	pop    %ebx
8010107a:	5e                   	pop    %esi
8010107b:	5f                   	pop    %edi
8010107c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010107d:	e9 ce 25 00 00       	jmp    80103650 <piperead>
80101082:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101088:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010108d:	eb d7                	jmp    80101066 <fileread+0x56>
  panic("fileread");
8010108f:	83 ec 0c             	sub    $0xc,%esp
80101092:	68 06 71 10 80       	push   $0x80107106
80101097:	e8 a4 f3 ff ff       	call   80100440 <panic>
8010109c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801010a0 <filesteal>:

// Steal a char from file f.
int
filesteal(struct file *f)
{
801010a0:	55                   	push   %ebp
801010a1:	89 e5                	mov    %esp,%ebp
801010a3:	56                   	push   %esi
801010a4:	53                   	push   %ebx
801010a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;

  if(f->readable == 0)
801010a8:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801010ac:	74 32                	je     801010e0 <filesteal+0x40>
    return -1;
  if(f->type == FD_INODE){
801010ae:	83 3b 02             	cmpl   $0x2,(%ebx)
801010b1:	75 34                	jne    801010e7 <filesteal+0x47>
    ilock(f->ip);
801010b3:	83 ec 0c             	sub    $0xc,%esp
801010b6:	ff 73 10             	pushl  0x10(%ebx)
801010b9:	e8 d2 06 00 00       	call   80101790 <ilock>
    // if((r = steali(f->ip) != -1))
    //   f->off += r;
    r = steali(f->ip);
801010be:	58                   	pop    %eax
801010bf:	ff 73 10             	pushl  0x10(%ebx)
801010c2:	e8 a9 0a 00 00       	call   80101b70 <steali>
    iunlock(f->ip);
801010c7:	5a                   	pop    %edx
801010c8:	ff 73 10             	pushl  0x10(%ebx)
    r = steali(f->ip);
801010cb:	89 c6                	mov    %eax,%esi
    iunlock(f->ip);
801010cd:	e8 9e 07 00 00       	call   80101870 <iunlock>
    return r;
801010d2:	83 c4 10             	add    $0x10,%esp
  }
  panic("filesteal");
}
801010d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801010d8:	89 f0                	mov    %esi,%eax
801010da:	5b                   	pop    %ebx
801010db:	5e                   	pop    %esi
801010dc:	5d                   	pop    %ebp
801010dd:	c3                   	ret    
801010de:	66 90                	xchg   %ax,%ax
    return -1;
801010e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
801010e5:	eb ee                	jmp    801010d5 <filesteal+0x35>
  panic("filesteal");
801010e7:	83 ec 0c             	sub    $0xc,%esp
801010ea:	68 0f 71 10 80       	push   $0x8010710f
801010ef:	e8 4c f3 ff ff       	call   80100440 <panic>
801010f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801010fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101100 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	57                   	push   %edi
80101104:	56                   	push   %esi
80101105:	53                   	push   %ebx
80101106:	83 ec 1c             	sub    $0x1c,%esp
80101109:	8b 75 08             	mov    0x8(%ebp),%esi
8010110c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010110f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101113:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101116:	8b 45 10             	mov    0x10(%ebp),%eax
80101119:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010111c:	0f 84 aa 00 00 00    	je     801011cc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101122:	8b 06                	mov    (%esi),%eax
80101124:	83 f8 01             	cmp    $0x1,%eax
80101127:	0f 84 c3 00 00 00    	je     801011f0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010112d:	83 f8 02             	cmp    $0x2,%eax
80101130:	0f 85 d9 00 00 00    	jne    8010120f <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101136:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101139:	31 ff                	xor    %edi,%edi
    while(i < n){
8010113b:	85 c0                	test   %eax,%eax
8010113d:	7f 34                	jg     80101173 <filewrite+0x73>
8010113f:	e9 9c 00 00 00       	jmp    801011e0 <filewrite+0xe0>
80101144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101148:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010114b:	83 ec 0c             	sub    $0xc,%esp
8010114e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101151:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101154:	e8 17 07 00 00       	call   80101870 <iunlock>
      end_op();
80101159:	e8 02 1c 00 00       	call   80102d60 <end_op>
8010115e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101161:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101164:	39 c3                	cmp    %eax,%ebx
80101166:	0f 85 96 00 00 00    	jne    80101202 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010116c:	01 df                	add    %ebx,%edi
    while(i < n){
8010116e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101171:	7e 6d                	jle    801011e0 <filewrite+0xe0>
      int n1 = n - i;
80101173:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101176:	b8 00 06 00 00       	mov    $0x600,%eax
8010117b:	29 fb                	sub    %edi,%ebx
8010117d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101183:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101186:	e8 65 1b 00 00       	call   80102cf0 <begin_op>
      ilock(f->ip);
8010118b:	83 ec 0c             	sub    $0xc,%esp
8010118e:	ff 76 10             	pushl  0x10(%esi)
80101191:	e8 fa 05 00 00       	call   80101790 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101196:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101199:	53                   	push   %ebx
8010119a:	ff 76 14             	pushl  0x14(%esi)
8010119d:	01 f8                	add    %edi,%eax
8010119f:	50                   	push   %eax
801011a0:	ff 76 10             	pushl  0x10(%esi)
801011a3:	e8 08 0a 00 00       	call   80101bb0 <writei>
801011a8:	83 c4 20             	add    $0x20,%esp
801011ab:	85 c0                	test   %eax,%eax
801011ad:	7f 99                	jg     80101148 <filewrite+0x48>
      iunlock(f->ip);
801011af:	83 ec 0c             	sub    $0xc,%esp
801011b2:	ff 76 10             	pushl  0x10(%esi)
801011b5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011b8:	e8 b3 06 00 00       	call   80101870 <iunlock>
      end_op();
801011bd:	e8 9e 1b 00 00       	call   80102d60 <end_op>
      if(r < 0)
801011c2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801011c5:	83 c4 10             	add    $0x10,%esp
801011c8:	85 c0                	test   %eax,%eax
801011ca:	74 98                	je     80101164 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801011cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801011cf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801011d4:	89 f8                	mov    %edi,%eax
801011d6:	5b                   	pop    %ebx
801011d7:	5e                   	pop    %esi
801011d8:	5f                   	pop    %edi
801011d9:	5d                   	pop    %ebp
801011da:	c3                   	ret    
801011db:	90                   	nop
801011dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801011e0:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801011e3:	75 e7                	jne    801011cc <filewrite+0xcc>
}
801011e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011e8:	89 f8                	mov    %edi,%eax
801011ea:	5b                   	pop    %ebx
801011eb:	5e                   	pop    %esi
801011ec:	5f                   	pop    %edi
801011ed:	5d                   	pop    %ebp
801011ee:	c3                   	ret    
801011ef:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801011f0:	8b 46 0c             	mov    0xc(%esi),%eax
801011f3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011f9:	5b                   	pop    %ebx
801011fa:	5e                   	pop    %esi
801011fb:	5f                   	pop    %edi
801011fc:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801011fd:	e9 3e 23 00 00       	jmp    80103540 <pipewrite>
        panic("short filewrite");
80101202:	83 ec 0c             	sub    $0xc,%esp
80101205:	68 19 71 10 80       	push   $0x80107119
8010120a:	e8 31 f2 ff ff       	call   80100440 <panic>
  panic("filewrite");
8010120f:	83 ec 0c             	sub    $0xc,%esp
80101212:	68 1f 71 10 80       	push   $0x8010711f
80101217:	e8 24 f2 ff ff       	call   80100440 <panic>
8010121c:	66 90                	xchg   %ax,%ax
8010121e:	66 90                	xchg   %ax,%ax

80101220 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101220:	55                   	push   %ebp
80101221:	89 e5                	mov    %esp,%ebp
80101223:	56                   	push   %esi
80101224:	53                   	push   %ebx
80101225:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101227:	c1 ea 0c             	shr    $0xc,%edx
8010122a:	03 15 f8 09 11 80    	add    0x801109f8,%edx
80101230:	83 ec 08             	sub    $0x8,%esp
80101233:	52                   	push   %edx
80101234:	50                   	push   %eax
80101235:	e8 96 ee ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010123a:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010123c:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
8010123f:	ba 01 00 00 00       	mov    $0x1,%edx
80101244:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101247:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010124d:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101250:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101252:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101257:	85 d1                	test   %edx,%ecx
80101259:	74 25                	je     80101280 <bfree+0x60>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010125b:	f7 d2                	not    %edx
8010125d:	89 c6                	mov    %eax,%esi
  log_write(bp);
8010125f:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101262:	21 ca                	and    %ecx,%edx
80101264:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101268:	56                   	push   %esi
80101269:	e8 52 1c 00 00       	call   80102ec0 <log_write>
  brelse(bp);
8010126e:	89 34 24             	mov    %esi,(%esp)
80101271:	e8 6a ef ff ff       	call   801001e0 <brelse>
}
80101276:	83 c4 10             	add    $0x10,%esp
80101279:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010127c:	5b                   	pop    %ebx
8010127d:	5e                   	pop    %esi
8010127e:	5d                   	pop    %ebp
8010127f:	c3                   	ret    
    panic("freeing free block");
80101280:	83 ec 0c             	sub    $0xc,%esp
80101283:	68 29 71 10 80       	push   $0x80107129
80101288:	e8 b3 f1 ff ff       	call   80100440 <panic>
8010128d:	8d 76 00             	lea    0x0(%esi),%esi

80101290 <balloc>:
{
80101290:	55                   	push   %ebp
80101291:	89 e5                	mov    %esp,%ebp
80101293:	57                   	push   %edi
80101294:	56                   	push   %esi
80101295:	53                   	push   %ebx
80101296:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101299:	8b 0d e0 09 11 80    	mov    0x801109e0,%ecx
{
8010129f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801012a2:	85 c9                	test   %ecx,%ecx
801012a4:	0f 84 87 00 00 00    	je     80101331 <balloc+0xa1>
801012aa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801012b1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801012b4:	83 ec 08             	sub    $0x8,%esp
801012b7:	89 f0                	mov    %esi,%eax
801012b9:	c1 f8 0c             	sar    $0xc,%eax
801012bc:	03 05 f8 09 11 80    	add    0x801109f8,%eax
801012c2:	50                   	push   %eax
801012c3:	ff 75 d8             	pushl  -0x28(%ebp)
801012c6:	e8 05 ee ff ff       	call   801000d0 <bread>
801012cb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012ce:	a1 e0 09 11 80       	mov    0x801109e0,%eax
801012d3:	83 c4 10             	add    $0x10,%esp
801012d6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801012d9:	31 c0                	xor    %eax,%eax
801012db:	eb 2f                	jmp    8010130c <balloc+0x7c>
801012dd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801012e0:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012e2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801012e5:	bb 01 00 00 00       	mov    $0x1,%ebx
801012ea:	83 e1 07             	and    $0x7,%ecx
801012ed:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012ef:	89 c1                	mov    %eax,%ecx
801012f1:	c1 f9 03             	sar    $0x3,%ecx
801012f4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801012f9:	85 df                	test   %ebx,%edi
801012fb:	89 fa                	mov    %edi,%edx
801012fd:	74 41                	je     80101340 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012ff:	83 c0 01             	add    $0x1,%eax
80101302:	83 c6 01             	add    $0x1,%esi
80101305:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010130a:	74 05                	je     80101311 <balloc+0x81>
8010130c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010130f:	77 cf                	ja     801012e0 <balloc+0x50>
    brelse(bp);
80101311:	83 ec 0c             	sub    $0xc,%esp
80101314:	ff 75 e4             	pushl  -0x1c(%ebp)
80101317:	e8 c4 ee ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010131c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101323:	83 c4 10             	add    $0x10,%esp
80101326:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101329:	39 05 e0 09 11 80    	cmp    %eax,0x801109e0
8010132f:	77 80                	ja     801012b1 <balloc+0x21>
  panic("balloc: out of blocks");
80101331:	83 ec 0c             	sub    $0xc,%esp
80101334:	68 3c 71 10 80       	push   $0x8010713c
80101339:	e8 02 f1 ff ff       	call   80100440 <panic>
8010133e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101340:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101343:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101346:	09 da                	or     %ebx,%edx
80101348:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010134c:	57                   	push   %edi
8010134d:	e8 6e 1b 00 00       	call   80102ec0 <log_write>
        brelse(bp);
80101352:	89 3c 24             	mov    %edi,(%esp)
80101355:	e8 86 ee ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
8010135a:	58                   	pop    %eax
8010135b:	5a                   	pop    %edx
8010135c:	56                   	push   %esi
8010135d:	ff 75 d8             	pushl  -0x28(%ebp)
80101360:	e8 6b ed ff ff       	call   801000d0 <bread>
80101365:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101367:	8d 40 5c             	lea    0x5c(%eax),%eax
8010136a:	83 c4 0c             	add    $0xc,%esp
8010136d:	68 00 02 00 00       	push   $0x200
80101372:	6a 00                	push   $0x0
80101374:	50                   	push   %eax
80101375:	e8 26 32 00 00       	call   801045a0 <memset>
  log_write(bp);
8010137a:	89 1c 24             	mov    %ebx,(%esp)
8010137d:	e8 3e 1b 00 00       	call   80102ec0 <log_write>
  brelse(bp);
80101382:	89 1c 24             	mov    %ebx,(%esp)
80101385:	e8 56 ee ff ff       	call   801001e0 <brelse>
}
8010138a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010138d:	89 f0                	mov    %esi,%eax
8010138f:	5b                   	pop    %ebx
80101390:	5e                   	pop    %esi
80101391:	5f                   	pop    %edi
80101392:	5d                   	pop    %ebp
80101393:	c3                   	ret    
80101394:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010139a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801013a0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801013a0:	55                   	push   %ebp
801013a1:	89 e5                	mov    %esp,%ebp
801013a3:	57                   	push   %edi
801013a4:	56                   	push   %esi
801013a5:	53                   	push   %ebx
801013a6:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801013a8:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013aa:	bb 34 0a 11 80       	mov    $0x80110a34,%ebx
{
801013af:	83 ec 28             	sub    $0x28,%esp
801013b2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801013b5:	68 00 0a 11 80       	push   $0x80110a00
801013ba:	e8 d1 30 00 00       	call   80104490 <acquire>
801013bf:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013c2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801013c5:	eb 17                	jmp    801013de <iget+0x3e>
801013c7:	89 f6                	mov    %esi,%esi
801013c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801013d0:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013d6:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
801013dc:	73 22                	jae    80101400 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013de:	8b 4b 08             	mov    0x8(%ebx),%ecx
801013e1:	85 c9                	test   %ecx,%ecx
801013e3:	7e 04                	jle    801013e9 <iget+0x49>
801013e5:	39 3b                	cmp    %edi,(%ebx)
801013e7:	74 4f                	je     80101438 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801013e9:	85 f6                	test   %esi,%esi
801013eb:	75 e3                	jne    801013d0 <iget+0x30>
801013ed:	85 c9                	test   %ecx,%ecx
801013ef:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013f2:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013f8:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
801013fe:	72 de                	jb     801013de <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101400:	85 f6                	test   %esi,%esi
80101402:	74 5b                	je     8010145f <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101404:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101407:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101409:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010140c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101413:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010141a:	68 00 0a 11 80       	push   $0x80110a00
8010141f:	e8 2c 31 00 00       	call   80104550 <release>

  return ip;
80101424:	83 c4 10             	add    $0x10,%esp
}
80101427:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010142a:	89 f0                	mov    %esi,%eax
8010142c:	5b                   	pop    %ebx
8010142d:	5e                   	pop    %esi
8010142e:	5f                   	pop    %edi
8010142f:	5d                   	pop    %ebp
80101430:	c3                   	ret    
80101431:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101438:	39 53 04             	cmp    %edx,0x4(%ebx)
8010143b:	75 ac                	jne    801013e9 <iget+0x49>
      release(&icache.lock);
8010143d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101440:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101443:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101445:	68 00 0a 11 80       	push   $0x80110a00
      ip->ref++;
8010144a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010144d:	e8 fe 30 00 00       	call   80104550 <release>
      return ip;
80101452:	83 c4 10             	add    $0x10,%esp
}
80101455:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101458:	89 f0                	mov    %esi,%eax
8010145a:	5b                   	pop    %ebx
8010145b:	5e                   	pop    %esi
8010145c:	5f                   	pop    %edi
8010145d:	5d                   	pop    %ebp
8010145e:	c3                   	ret    
    panic("iget: no inodes");
8010145f:	83 ec 0c             	sub    $0xc,%esp
80101462:	68 52 71 10 80       	push   $0x80107152
80101467:	e8 d4 ef ff ff       	call   80100440 <panic>
8010146c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101470 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101470:	55                   	push   %ebp
80101471:	89 e5                	mov    %esp,%ebp
80101473:	57                   	push   %edi
80101474:	56                   	push   %esi
80101475:	53                   	push   %ebx
80101476:	89 c6                	mov    %eax,%esi
80101478:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010147b:	83 fa 0b             	cmp    $0xb,%edx
8010147e:	77 18                	ja     80101498 <bmap+0x28>
80101480:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101483:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101486:	85 db                	test   %ebx,%ebx
80101488:	74 76                	je     80101500 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010148a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010148d:	89 d8                	mov    %ebx,%eax
8010148f:	5b                   	pop    %ebx
80101490:	5e                   	pop    %esi
80101491:	5f                   	pop    %edi
80101492:	5d                   	pop    %ebp
80101493:	c3                   	ret    
80101494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101498:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010149b:	83 fb 7f             	cmp    $0x7f,%ebx
8010149e:	0f 87 90 00 00 00    	ja     80101534 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
801014a4:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
801014aa:	8b 00                	mov    (%eax),%eax
801014ac:	85 d2                	test   %edx,%edx
801014ae:	74 70                	je     80101520 <bmap+0xb0>
    bp = bread(ip->dev, addr);
801014b0:	83 ec 08             	sub    $0x8,%esp
801014b3:	52                   	push   %edx
801014b4:	50                   	push   %eax
801014b5:	e8 16 ec ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
801014ba:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801014be:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
801014c1:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801014c3:	8b 1a                	mov    (%edx),%ebx
801014c5:	85 db                	test   %ebx,%ebx
801014c7:	75 1d                	jne    801014e6 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
801014c9:	8b 06                	mov    (%esi),%eax
801014cb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801014ce:	e8 bd fd ff ff       	call   80101290 <balloc>
801014d3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801014d6:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801014d9:	89 c3                	mov    %eax,%ebx
801014db:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801014dd:	57                   	push   %edi
801014de:	e8 dd 19 00 00       	call   80102ec0 <log_write>
801014e3:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801014e6:	83 ec 0c             	sub    $0xc,%esp
801014e9:	57                   	push   %edi
801014ea:	e8 f1 ec ff ff       	call   801001e0 <brelse>
801014ef:	83 c4 10             	add    $0x10,%esp
}
801014f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014f5:	89 d8                	mov    %ebx,%eax
801014f7:	5b                   	pop    %ebx
801014f8:	5e                   	pop    %esi
801014f9:	5f                   	pop    %edi
801014fa:	5d                   	pop    %ebp
801014fb:	c3                   	ret    
801014fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101500:	8b 00                	mov    (%eax),%eax
80101502:	e8 89 fd ff ff       	call   80101290 <balloc>
80101507:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010150a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010150d:	89 c3                	mov    %eax,%ebx
}
8010150f:	89 d8                	mov    %ebx,%eax
80101511:	5b                   	pop    %ebx
80101512:	5e                   	pop    %esi
80101513:	5f                   	pop    %edi
80101514:	5d                   	pop    %ebp
80101515:	c3                   	ret    
80101516:	8d 76 00             	lea    0x0(%esi),%esi
80101519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101520:	e8 6b fd ff ff       	call   80101290 <balloc>
80101525:	89 c2                	mov    %eax,%edx
80101527:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010152d:	8b 06                	mov    (%esi),%eax
8010152f:	e9 7c ff ff ff       	jmp    801014b0 <bmap+0x40>
  panic("bmap: out of range");
80101534:	83 ec 0c             	sub    $0xc,%esp
80101537:	68 62 71 10 80       	push   $0x80107162
8010153c:	e8 ff ee ff ff       	call   80100440 <panic>
80101541:	eb 0d                	jmp    80101550 <readsb>
80101543:	90                   	nop
80101544:	90                   	nop
80101545:	90                   	nop
80101546:	90                   	nop
80101547:	90                   	nop
80101548:	90                   	nop
80101549:	90                   	nop
8010154a:	90                   	nop
8010154b:	90                   	nop
8010154c:	90                   	nop
8010154d:	90                   	nop
8010154e:	90                   	nop
8010154f:	90                   	nop

80101550 <readsb>:
{
80101550:	55                   	push   %ebp
80101551:	89 e5                	mov    %esp,%ebp
80101553:	56                   	push   %esi
80101554:	53                   	push   %ebx
80101555:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101558:	83 ec 08             	sub    $0x8,%esp
8010155b:	6a 01                	push   $0x1
8010155d:	ff 75 08             	pushl  0x8(%ebp)
80101560:	e8 6b eb ff ff       	call   801000d0 <bread>
80101565:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101567:	8d 40 5c             	lea    0x5c(%eax),%eax
8010156a:	83 c4 0c             	add    $0xc,%esp
8010156d:	6a 1c                	push   $0x1c
8010156f:	50                   	push   %eax
80101570:	56                   	push   %esi
80101571:	e8 da 30 00 00       	call   80104650 <memmove>
  brelse(bp);
80101576:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101579:	83 c4 10             	add    $0x10,%esp
}
8010157c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010157f:	5b                   	pop    %ebx
80101580:	5e                   	pop    %esi
80101581:	5d                   	pop    %ebp
  brelse(bp);
80101582:	e9 59 ec ff ff       	jmp    801001e0 <brelse>
80101587:	89 f6                	mov    %esi,%esi
80101589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101590 <iinit>:
{
80101590:	55                   	push   %ebp
80101591:	89 e5                	mov    %esp,%ebp
80101593:	53                   	push   %ebx
80101594:	bb 40 0a 11 80       	mov    $0x80110a40,%ebx
80101599:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010159c:	68 75 71 10 80       	push   $0x80107175
801015a1:	68 00 0a 11 80       	push   $0x80110a00
801015a6:	e8 a5 2d 00 00       	call   80104350 <initlock>
801015ab:	83 c4 10             	add    $0x10,%esp
801015ae:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801015b0:	83 ec 08             	sub    $0x8,%esp
801015b3:	68 7c 71 10 80       	push   $0x8010717c
801015b8:	53                   	push   %ebx
801015b9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801015bf:	e8 5c 2c 00 00       	call   80104220 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801015c4:	83 c4 10             	add    $0x10,%esp
801015c7:	81 fb 60 26 11 80    	cmp    $0x80112660,%ebx
801015cd:	75 e1                	jne    801015b0 <iinit+0x20>
  readsb(dev, &sb);
801015cf:	83 ec 08             	sub    $0x8,%esp
801015d2:	68 e0 09 11 80       	push   $0x801109e0
801015d7:	ff 75 08             	pushl  0x8(%ebp)
801015da:	e8 71 ff ff ff       	call   80101550 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801015df:	ff 35 f8 09 11 80    	pushl  0x801109f8
801015e5:	ff 35 f4 09 11 80    	pushl  0x801109f4
801015eb:	ff 35 f0 09 11 80    	pushl  0x801109f0
801015f1:	ff 35 ec 09 11 80    	pushl  0x801109ec
801015f7:	ff 35 e8 09 11 80    	pushl  0x801109e8
801015fd:	ff 35 e4 09 11 80    	pushl  0x801109e4
80101603:	ff 35 e0 09 11 80    	pushl  0x801109e0
80101609:	68 e0 71 10 80       	push   $0x801071e0
8010160e:	e8 fd f0 ff ff       	call   80100710 <cprintf>
}
80101613:	83 c4 30             	add    $0x30,%esp
80101616:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101619:	c9                   	leave  
8010161a:	c3                   	ret    
8010161b:	90                   	nop
8010161c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101620 <ialloc>:
{
80101620:	55                   	push   %ebp
80101621:	89 e5                	mov    %esp,%ebp
80101623:	57                   	push   %edi
80101624:	56                   	push   %esi
80101625:	53                   	push   %ebx
80101626:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101629:	83 3d e8 09 11 80 01 	cmpl   $0x1,0x801109e8
{
80101630:	8b 45 0c             	mov    0xc(%ebp),%eax
80101633:	8b 75 08             	mov    0x8(%ebp),%esi
80101636:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101639:	0f 86 91 00 00 00    	jbe    801016d0 <ialloc+0xb0>
8010163f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101644:	eb 21                	jmp    80101667 <ialloc+0x47>
80101646:	8d 76 00             	lea    0x0(%esi),%esi
80101649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101650:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101653:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101656:	57                   	push   %edi
80101657:	e8 84 eb ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010165c:	83 c4 10             	add    $0x10,%esp
8010165f:	39 1d e8 09 11 80    	cmp    %ebx,0x801109e8
80101665:	76 69                	jbe    801016d0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101667:	89 d8                	mov    %ebx,%eax
80101669:	83 ec 08             	sub    $0x8,%esp
8010166c:	c1 e8 03             	shr    $0x3,%eax
8010166f:	03 05 f4 09 11 80    	add    0x801109f4,%eax
80101675:	50                   	push   %eax
80101676:	56                   	push   %esi
80101677:	e8 54 ea ff ff       	call   801000d0 <bread>
8010167c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010167e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101680:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101683:	83 e0 07             	and    $0x7,%eax
80101686:	c1 e0 06             	shl    $0x6,%eax
80101689:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010168d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101691:	75 bd                	jne    80101650 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101693:	83 ec 04             	sub    $0x4,%esp
80101696:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101699:	6a 40                	push   $0x40
8010169b:	6a 00                	push   $0x0
8010169d:	51                   	push   %ecx
8010169e:	e8 fd 2e 00 00       	call   801045a0 <memset>
      dip->type = type;
801016a3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801016a7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801016aa:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801016ad:	89 3c 24             	mov    %edi,(%esp)
801016b0:	e8 0b 18 00 00       	call   80102ec0 <log_write>
      brelse(bp);
801016b5:	89 3c 24             	mov    %edi,(%esp)
801016b8:	e8 23 eb ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801016bd:	83 c4 10             	add    $0x10,%esp
}
801016c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801016c3:	89 da                	mov    %ebx,%edx
801016c5:	89 f0                	mov    %esi,%eax
}
801016c7:	5b                   	pop    %ebx
801016c8:	5e                   	pop    %esi
801016c9:	5f                   	pop    %edi
801016ca:	5d                   	pop    %ebp
      return iget(dev, inum);
801016cb:	e9 d0 fc ff ff       	jmp    801013a0 <iget>
  panic("ialloc: no inodes");
801016d0:	83 ec 0c             	sub    $0xc,%esp
801016d3:	68 82 71 10 80       	push   $0x80107182
801016d8:	e8 63 ed ff ff       	call   80100440 <panic>
801016dd:	8d 76 00             	lea    0x0(%esi),%esi

801016e0 <iupdate>:
{
801016e0:	55                   	push   %ebp
801016e1:	89 e5                	mov    %esp,%ebp
801016e3:	56                   	push   %esi
801016e4:	53                   	push   %ebx
801016e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016e8:	83 ec 08             	sub    $0x8,%esp
801016eb:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016ee:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016f1:	c1 e8 03             	shr    $0x3,%eax
801016f4:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801016fa:	50                   	push   %eax
801016fb:	ff 73 a4             	pushl  -0x5c(%ebx)
801016fe:	e8 cd e9 ff ff       	call   801000d0 <bread>
80101703:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101705:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101708:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010170c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010170f:	83 e0 07             	and    $0x7,%eax
80101712:	c1 e0 06             	shl    $0x6,%eax
80101715:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101719:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010171c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101720:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101723:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101727:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010172b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010172f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101733:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101737:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010173a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010173d:	6a 34                	push   $0x34
8010173f:	53                   	push   %ebx
80101740:	50                   	push   %eax
80101741:	e8 0a 2f 00 00       	call   80104650 <memmove>
  log_write(bp);
80101746:	89 34 24             	mov    %esi,(%esp)
80101749:	e8 72 17 00 00       	call   80102ec0 <log_write>
  brelse(bp);
8010174e:	89 75 08             	mov    %esi,0x8(%ebp)
80101751:	83 c4 10             	add    $0x10,%esp
}
80101754:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101757:	5b                   	pop    %ebx
80101758:	5e                   	pop    %esi
80101759:	5d                   	pop    %ebp
  brelse(bp);
8010175a:	e9 81 ea ff ff       	jmp    801001e0 <brelse>
8010175f:	90                   	nop

80101760 <idup>:
{
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	53                   	push   %ebx
80101764:	83 ec 10             	sub    $0x10,%esp
80101767:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010176a:	68 00 0a 11 80       	push   $0x80110a00
8010176f:	e8 1c 2d 00 00       	call   80104490 <acquire>
  ip->ref++;
80101774:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101778:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010177f:	e8 cc 2d 00 00       	call   80104550 <release>
}
80101784:	89 d8                	mov    %ebx,%eax
80101786:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101789:	c9                   	leave  
8010178a:	c3                   	ret    
8010178b:	90                   	nop
8010178c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101790 <ilock>:
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	56                   	push   %esi
80101794:	53                   	push   %ebx
80101795:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101798:	85 db                	test   %ebx,%ebx
8010179a:	0f 84 b7 00 00 00    	je     80101857 <ilock+0xc7>
801017a0:	8b 53 08             	mov    0x8(%ebx),%edx
801017a3:	85 d2                	test   %edx,%edx
801017a5:	0f 8e ac 00 00 00    	jle    80101857 <ilock+0xc7>
  acquiresleep(&ip->lock);
801017ab:	8d 43 0c             	lea    0xc(%ebx),%eax
801017ae:	83 ec 0c             	sub    $0xc,%esp
801017b1:	50                   	push   %eax
801017b2:	e8 a9 2a 00 00       	call   80104260 <acquiresleep>
  if(ip->valid == 0){
801017b7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801017ba:	83 c4 10             	add    $0x10,%esp
801017bd:	85 c0                	test   %eax,%eax
801017bf:	74 0f                	je     801017d0 <ilock+0x40>
}
801017c1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017c4:	5b                   	pop    %ebx
801017c5:	5e                   	pop    %esi
801017c6:	5d                   	pop    %ebp
801017c7:	c3                   	ret    
801017c8:	90                   	nop
801017c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017d0:	8b 43 04             	mov    0x4(%ebx),%eax
801017d3:	83 ec 08             	sub    $0x8,%esp
801017d6:	c1 e8 03             	shr    $0x3,%eax
801017d9:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801017df:	50                   	push   %eax
801017e0:	ff 33                	pushl  (%ebx)
801017e2:	e8 e9 e8 ff ff       	call   801000d0 <bread>
801017e7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017e9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017ec:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017ef:	83 e0 07             	and    $0x7,%eax
801017f2:	c1 e0 06             	shl    $0x6,%eax
801017f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801017f9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017fc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801017ff:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101803:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101807:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010180b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010180f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101813:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101817:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010181b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010181e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101821:	6a 34                	push   $0x34
80101823:	50                   	push   %eax
80101824:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101827:	50                   	push   %eax
80101828:	e8 23 2e 00 00       	call   80104650 <memmove>
    brelse(bp);
8010182d:	89 34 24             	mov    %esi,(%esp)
80101830:	e8 ab e9 ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101835:	83 c4 10             	add    $0x10,%esp
80101838:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010183d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101844:	0f 85 77 ff ff ff    	jne    801017c1 <ilock+0x31>
      panic("ilock: no type");
8010184a:	83 ec 0c             	sub    $0xc,%esp
8010184d:	68 9a 71 10 80       	push   $0x8010719a
80101852:	e8 e9 eb ff ff       	call   80100440 <panic>
    panic("ilock");
80101857:	83 ec 0c             	sub    $0xc,%esp
8010185a:	68 94 71 10 80       	push   $0x80107194
8010185f:	e8 dc eb ff ff       	call   80100440 <panic>
80101864:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010186a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101870 <iunlock>:
{
80101870:	55                   	push   %ebp
80101871:	89 e5                	mov    %esp,%ebp
80101873:	56                   	push   %esi
80101874:	53                   	push   %ebx
80101875:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101878:	85 db                	test   %ebx,%ebx
8010187a:	74 28                	je     801018a4 <iunlock+0x34>
8010187c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010187f:	83 ec 0c             	sub    $0xc,%esp
80101882:	56                   	push   %esi
80101883:	e8 78 2a 00 00       	call   80104300 <holdingsleep>
80101888:	83 c4 10             	add    $0x10,%esp
8010188b:	85 c0                	test   %eax,%eax
8010188d:	74 15                	je     801018a4 <iunlock+0x34>
8010188f:	8b 43 08             	mov    0x8(%ebx),%eax
80101892:	85 c0                	test   %eax,%eax
80101894:	7e 0e                	jle    801018a4 <iunlock+0x34>
  releasesleep(&ip->lock);
80101896:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101899:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010189c:	5b                   	pop    %ebx
8010189d:	5e                   	pop    %esi
8010189e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010189f:	e9 1c 2a 00 00       	jmp    801042c0 <releasesleep>
    panic("iunlock");
801018a4:	83 ec 0c             	sub    $0xc,%esp
801018a7:	68 a9 71 10 80       	push   $0x801071a9
801018ac:	e8 8f eb ff ff       	call   80100440 <panic>
801018b1:	eb 0d                	jmp    801018c0 <iput>
801018b3:	90                   	nop
801018b4:	90                   	nop
801018b5:	90                   	nop
801018b6:	90                   	nop
801018b7:	90                   	nop
801018b8:	90                   	nop
801018b9:	90                   	nop
801018ba:	90                   	nop
801018bb:	90                   	nop
801018bc:	90                   	nop
801018bd:	90                   	nop
801018be:	90                   	nop
801018bf:	90                   	nop

801018c0 <iput>:
{
801018c0:	55                   	push   %ebp
801018c1:	89 e5                	mov    %esp,%ebp
801018c3:	57                   	push   %edi
801018c4:	56                   	push   %esi
801018c5:	53                   	push   %ebx
801018c6:	83 ec 28             	sub    $0x28,%esp
801018c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801018cc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801018cf:	57                   	push   %edi
801018d0:	e8 8b 29 00 00       	call   80104260 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801018d5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801018d8:	83 c4 10             	add    $0x10,%esp
801018db:	85 d2                	test   %edx,%edx
801018dd:	74 07                	je     801018e6 <iput+0x26>
801018df:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801018e4:	74 32                	je     80101918 <iput+0x58>
  releasesleep(&ip->lock);
801018e6:	83 ec 0c             	sub    $0xc,%esp
801018e9:	57                   	push   %edi
801018ea:	e8 d1 29 00 00       	call   801042c0 <releasesleep>
  acquire(&icache.lock);
801018ef:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801018f6:	e8 95 2b 00 00       	call   80104490 <acquire>
  ip->ref--;
801018fb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801018ff:	83 c4 10             	add    $0x10,%esp
80101902:	c7 45 08 00 0a 11 80 	movl   $0x80110a00,0x8(%ebp)
}
80101909:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010190c:	5b                   	pop    %ebx
8010190d:	5e                   	pop    %esi
8010190e:	5f                   	pop    %edi
8010190f:	5d                   	pop    %ebp
  release(&icache.lock);
80101910:	e9 3b 2c 00 00       	jmp    80104550 <release>
80101915:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101918:	83 ec 0c             	sub    $0xc,%esp
8010191b:	68 00 0a 11 80       	push   $0x80110a00
80101920:	e8 6b 2b 00 00       	call   80104490 <acquire>
    int r = ip->ref;
80101925:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101928:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010192f:	e8 1c 2c 00 00       	call   80104550 <release>
    if(r == 1){
80101934:	83 c4 10             	add    $0x10,%esp
80101937:	83 fe 01             	cmp    $0x1,%esi
8010193a:	75 aa                	jne    801018e6 <iput+0x26>
8010193c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101942:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101945:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101948:	89 cf                	mov    %ecx,%edi
8010194a:	eb 0b                	jmp    80101957 <iput+0x97>
8010194c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101950:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101953:	39 fe                	cmp    %edi,%esi
80101955:	74 19                	je     80101970 <iput+0xb0>
    if(ip->addrs[i]){
80101957:	8b 16                	mov    (%esi),%edx
80101959:	85 d2                	test   %edx,%edx
8010195b:	74 f3                	je     80101950 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010195d:	8b 03                	mov    (%ebx),%eax
8010195f:	e8 bc f8 ff ff       	call   80101220 <bfree>
      ip->addrs[i] = 0;
80101964:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010196a:	eb e4                	jmp    80101950 <iput+0x90>
8010196c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101970:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101976:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101979:	85 c0                	test   %eax,%eax
8010197b:	75 33                	jne    801019b0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010197d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101980:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101987:	53                   	push   %ebx
80101988:	e8 53 fd ff ff       	call   801016e0 <iupdate>
      ip->type = 0;
8010198d:	31 c0                	xor    %eax,%eax
8010198f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101993:	89 1c 24             	mov    %ebx,(%esp)
80101996:	e8 45 fd ff ff       	call   801016e0 <iupdate>
      ip->valid = 0;
8010199b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801019a2:	83 c4 10             	add    $0x10,%esp
801019a5:	e9 3c ff ff ff       	jmp    801018e6 <iput+0x26>
801019aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801019b0:	83 ec 08             	sub    $0x8,%esp
801019b3:	50                   	push   %eax
801019b4:	ff 33                	pushl  (%ebx)
801019b6:	e8 15 e7 ff ff       	call   801000d0 <bread>
801019bb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801019c1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801019c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801019c7:	8d 70 5c             	lea    0x5c(%eax),%esi
801019ca:	83 c4 10             	add    $0x10,%esp
801019cd:	89 cf                	mov    %ecx,%edi
801019cf:	eb 0e                	jmp    801019df <iput+0x11f>
801019d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019d8:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
801019db:	39 fe                	cmp    %edi,%esi
801019dd:	74 0f                	je     801019ee <iput+0x12e>
      if(a[j])
801019df:	8b 16                	mov    (%esi),%edx
801019e1:	85 d2                	test   %edx,%edx
801019e3:	74 f3                	je     801019d8 <iput+0x118>
        bfree(ip->dev, a[j]);
801019e5:	8b 03                	mov    (%ebx),%eax
801019e7:	e8 34 f8 ff ff       	call   80101220 <bfree>
801019ec:	eb ea                	jmp    801019d8 <iput+0x118>
    brelse(bp);
801019ee:	83 ec 0c             	sub    $0xc,%esp
801019f1:	ff 75 e4             	pushl  -0x1c(%ebp)
801019f4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801019f7:	e8 e4 e7 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801019fc:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101a02:	8b 03                	mov    (%ebx),%eax
80101a04:	e8 17 f8 ff ff       	call   80101220 <bfree>
    ip->addrs[NDIRECT] = 0;
80101a09:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101a10:	00 00 00 
80101a13:	83 c4 10             	add    $0x10,%esp
80101a16:	e9 62 ff ff ff       	jmp    8010197d <iput+0xbd>
80101a1b:	90                   	nop
80101a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a20 <iunlockput>:
{
80101a20:	55                   	push   %ebp
80101a21:	89 e5                	mov    %esp,%ebp
80101a23:	53                   	push   %ebx
80101a24:	83 ec 10             	sub    $0x10,%esp
80101a27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101a2a:	53                   	push   %ebx
80101a2b:	e8 40 fe ff ff       	call   80101870 <iunlock>
  iput(ip);
80101a30:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a33:	83 c4 10             	add    $0x10,%esp
}
80101a36:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a39:	c9                   	leave  
  iput(ip);
80101a3a:	e9 81 fe ff ff       	jmp    801018c0 <iput>
80101a3f:	90                   	nop

80101a40 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101a40:	55                   	push   %ebp
80101a41:	89 e5                	mov    %esp,%ebp
80101a43:	8b 55 08             	mov    0x8(%ebp),%edx
80101a46:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a49:	8b 0a                	mov    (%edx),%ecx
80101a4b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a4e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a51:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101a54:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101a58:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101a5b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101a5f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101a63:	8b 52 58             	mov    0x58(%edx),%edx
80101a66:	89 50 10             	mov    %edx,0x10(%eax)
}
80101a69:	5d                   	pop    %ebp
80101a6a:	c3                   	ret    
80101a6b:	90                   	nop
80101a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a70 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a70:	55                   	push   %ebp
80101a71:	89 e5                	mov    %esp,%ebp
80101a73:	57                   	push   %edi
80101a74:	56                   	push   %esi
80101a75:	53                   	push   %ebx
80101a76:	83 ec 1c             	sub    $0x1c,%esp
80101a79:	8b 45 08             	mov    0x8(%ebp),%eax
80101a7c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a7f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a82:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a87:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101a8a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a8d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a90:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101a93:	0f 84 a7 00 00 00    	je     80101b40 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101a99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a9c:	8b 40 58             	mov    0x58(%eax),%eax
80101a9f:	39 c6                	cmp    %eax,%esi
80101aa1:	0f 87 bd 00 00 00    	ja     80101b64 <readi+0xf4>
80101aa7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101aaa:	89 f9                	mov    %edi,%ecx
80101aac:	01 f1                	add    %esi,%ecx
80101aae:	0f 82 b0 00 00 00    	jb     80101b64 <readi+0xf4>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101ab4:	89 c2                	mov    %eax,%edx
80101ab6:	29 f2                	sub    %esi,%edx
80101ab8:	39 c8                	cmp    %ecx,%eax
80101aba:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101abd:	31 ff                	xor    %edi,%edi
80101abf:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101ac1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ac4:	74 6c                	je     80101b32 <readi+0xc2>
80101ac6:	8d 76 00             	lea    0x0(%esi),%esi
80101ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ad0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101ad3:	89 f2                	mov    %esi,%edx
80101ad5:	c1 ea 09             	shr    $0x9,%edx
80101ad8:	89 d8                	mov    %ebx,%eax
80101ada:	e8 91 f9 ff ff       	call   80101470 <bmap>
80101adf:	83 ec 08             	sub    $0x8,%esp
80101ae2:	50                   	push   %eax
80101ae3:	ff 33                	pushl  (%ebx)
80101ae5:	e8 e6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101aea:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101aed:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101aef:	89 f0                	mov    %esi,%eax
80101af1:	25 ff 01 00 00       	and    $0x1ff,%eax
80101af6:	b9 00 02 00 00       	mov    $0x200,%ecx
80101afb:	83 c4 0c             	add    $0xc,%esp
80101afe:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b00:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101b04:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101b07:	29 fb                	sub    %edi,%ebx
80101b09:	39 d9                	cmp    %ebx,%ecx
80101b0b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b0e:	53                   	push   %ebx
80101b0f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b10:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101b12:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b15:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101b17:	e8 34 2b 00 00       	call   80104650 <memmove>
    brelse(bp);
80101b1c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b1f:	89 14 24             	mov    %edx,(%esp)
80101b22:	e8 b9 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b27:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b2a:	83 c4 10             	add    $0x10,%esp
80101b2d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b30:	77 9e                	ja     80101ad0 <readi+0x60>
  }
  return n;
80101b32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b38:	5b                   	pop    %ebx
80101b39:	5e                   	pop    %esi
80101b3a:	5f                   	pop    %edi
80101b3b:	5d                   	pop    %ebp
80101b3c:	c3                   	ret    
80101b3d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b44:	66 83 f8 09          	cmp    $0x9,%ax
80101b48:	77 1a                	ja     80101b64 <readi+0xf4>
80101b4a:	8d 04 40             	lea    (%eax,%eax,2),%eax
80101b4d:	8b 04 85 60 09 11 80 	mov    -0x7feef6a0(,%eax,4),%eax
80101b54:	85 c0                	test   %eax,%eax
80101b56:	74 0c                	je     80101b64 <readi+0xf4>
    return devsw[ip->major].read(ip, dst, n);
80101b58:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b5e:	5b                   	pop    %ebx
80101b5f:	5e                   	pop    %esi
80101b60:	5f                   	pop    %edi
80101b61:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101b62:	ff e0                	jmp    *%eax
      return -1;
80101b64:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b69:	eb ca                	jmp    80101b35 <readi+0xc5>
80101b6b:	90                   	nop
80101b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101b70 <steali>:
// Read data from inode.
// Caller must hold ip->lock.
// like readi but just reads one character
int
steali(struct inode *ip)
{
80101b70:	55                   	push   %ebp
80101b71:	89 e5                	mov    %esp,%ebp
80101b73:	8b 45 08             	mov    0x8(%ebp),%eax
  if(ip->type == T_DEV){
80101b76:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101b7b:	75 23                	jne    80101ba0 <steali+0x30>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].steal)
80101b7d:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b81:	66 83 f8 09          	cmp    $0x9,%ax
80101b85:	77 19                	ja     80101ba0 <steali+0x30>
80101b87:	8d 04 40             	lea    (%eax,%eax,2),%eax
80101b8a:	8b 04 85 64 09 11 80 	mov    -0x7feef69c(,%eax,4),%eax
80101b91:	85 c0                	test   %eax,%eax
80101b93:	74 0b                	je     80101ba0 <steali+0x30>
      return -1;
    int r = devsw[ip->major].steal(ip);
    return r;
  }
  return -1;
}
80101b95:	5d                   	pop    %ebp
    int r = devsw[ip->major].steal(ip);
80101b96:	ff e0                	jmp    *%eax
80101b98:	90                   	nop
80101b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80101ba0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ba5:	5d                   	pop    %ebp
80101ba6:	c3                   	ret    
80101ba7:	89 f6                	mov    %esi,%esi
80101ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bb0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101bb0:	55                   	push   %ebp
80101bb1:	89 e5                	mov    %esp,%ebp
80101bb3:	57                   	push   %edi
80101bb4:	56                   	push   %esi
80101bb5:	53                   	push   %ebx
80101bb6:	83 ec 1c             	sub    $0x1c,%esp
80101bb9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bbc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101bbf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101bc2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101bc7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101bca:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101bcd:	8b 75 10             	mov    0x10(%ebp),%esi
80101bd0:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101bd3:	0f 84 b7 00 00 00    	je     80101c90 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101bd9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bdc:	39 70 58             	cmp    %esi,0x58(%eax)
80101bdf:	0f 82 eb 00 00 00    	jb     80101cd0 <writei+0x120>
80101be5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101be8:	31 d2                	xor    %edx,%edx
80101bea:	89 f8                	mov    %edi,%eax
80101bec:	01 f0                	add    %esi,%eax
80101bee:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101bf1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101bf6:	0f 87 d4 00 00 00    	ja     80101cd0 <writei+0x120>
80101bfc:	85 d2                	test   %edx,%edx
80101bfe:	0f 85 cc 00 00 00    	jne    80101cd0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c04:	85 ff                	test   %edi,%edi
80101c06:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101c0d:	74 72                	je     80101c81 <writei+0xd1>
80101c0f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c10:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101c13:	89 f2                	mov    %esi,%edx
80101c15:	c1 ea 09             	shr    $0x9,%edx
80101c18:	89 f8                	mov    %edi,%eax
80101c1a:	e8 51 f8 ff ff       	call   80101470 <bmap>
80101c1f:	83 ec 08             	sub    $0x8,%esp
80101c22:	50                   	push   %eax
80101c23:	ff 37                	pushl  (%edi)
80101c25:	e8 a6 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c2a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c2d:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c30:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c32:	89 f0                	mov    %esi,%eax
80101c34:	b9 00 02 00 00       	mov    $0x200,%ecx
80101c39:	83 c4 0c             	add    $0xc,%esp
80101c3c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c41:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101c43:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c47:	39 d9                	cmp    %ebx,%ecx
80101c49:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101c4c:	53                   	push   %ebx
80101c4d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c50:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101c52:	50                   	push   %eax
80101c53:	e8 f8 29 00 00       	call   80104650 <memmove>
    log_write(bp);
80101c58:	89 3c 24             	mov    %edi,(%esp)
80101c5b:	e8 60 12 00 00       	call   80102ec0 <log_write>
    brelse(bp);
80101c60:	89 3c 24             	mov    %edi,(%esp)
80101c63:	e8 78 e5 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c68:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c6b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c6e:	83 c4 10             	add    $0x10,%esp
80101c71:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c74:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101c77:	77 97                	ja     80101c10 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101c79:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c7c:	3b 70 58             	cmp    0x58(%eax),%esi
80101c7f:	77 37                	ja     80101cb8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c81:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c84:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c87:	5b                   	pop    %ebx
80101c88:	5e                   	pop    %esi
80101c89:	5f                   	pop    %edi
80101c8a:	5d                   	pop    %ebp
80101c8b:	c3                   	ret    
80101c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c90:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c94:	66 83 f8 09          	cmp    $0x9,%ax
80101c98:	77 36                	ja     80101cd0 <writei+0x120>
80101c9a:	8d 04 40             	lea    (%eax,%eax,2),%eax
80101c9d:	8b 04 85 68 09 11 80 	mov    -0x7feef698(,%eax,4),%eax
80101ca4:	85 c0                	test   %eax,%eax
80101ca6:	74 28                	je     80101cd0 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101ca8:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101cab:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cae:	5b                   	pop    %ebx
80101caf:	5e                   	pop    %esi
80101cb0:	5f                   	pop    %edi
80101cb1:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101cb2:	ff e0                	jmp    *%eax
80101cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101cb8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101cbb:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101cbe:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101cc1:	50                   	push   %eax
80101cc2:	e8 19 fa ff ff       	call   801016e0 <iupdate>
80101cc7:	83 c4 10             	add    $0x10,%esp
80101cca:	eb b5                	jmp    80101c81 <writei+0xd1>
80101ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101cd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101cd5:	eb ad                	jmp    80101c84 <writei+0xd4>
80101cd7:	89 f6                	mov    %esi,%esi
80101cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ce0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101ce0:	55                   	push   %ebp
80101ce1:	89 e5                	mov    %esp,%ebp
80101ce3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101ce6:	6a 0e                	push   $0xe
80101ce8:	ff 75 0c             	pushl  0xc(%ebp)
80101ceb:	ff 75 08             	pushl  0x8(%ebp)
80101cee:	e8 cd 29 00 00       	call   801046c0 <strncmp>
}
80101cf3:	c9                   	leave  
80101cf4:	c3                   	ret    
80101cf5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101d00 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101d00:	55                   	push   %ebp
80101d01:	89 e5                	mov    %esp,%ebp
80101d03:	57                   	push   %edi
80101d04:	56                   	push   %esi
80101d05:	53                   	push   %ebx
80101d06:	83 ec 1c             	sub    $0x1c,%esp
80101d09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101d0c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101d11:	0f 85 85 00 00 00    	jne    80101d9c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101d17:	8b 53 58             	mov    0x58(%ebx),%edx
80101d1a:	31 ff                	xor    %edi,%edi
80101d1c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101d1f:	85 d2                	test   %edx,%edx
80101d21:	74 3e                	je     80101d61 <dirlookup+0x61>
80101d23:	90                   	nop
80101d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d28:	6a 10                	push   $0x10
80101d2a:	57                   	push   %edi
80101d2b:	56                   	push   %esi
80101d2c:	53                   	push   %ebx
80101d2d:	e8 3e fd ff ff       	call   80101a70 <readi>
80101d32:	83 c4 10             	add    $0x10,%esp
80101d35:	83 f8 10             	cmp    $0x10,%eax
80101d38:	75 55                	jne    80101d8f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101d3a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d3f:	74 18                	je     80101d59 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101d41:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d44:	83 ec 04             	sub    $0x4,%esp
80101d47:	6a 0e                	push   $0xe
80101d49:	50                   	push   %eax
80101d4a:	ff 75 0c             	pushl  0xc(%ebp)
80101d4d:	e8 6e 29 00 00       	call   801046c0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101d52:	83 c4 10             	add    $0x10,%esp
80101d55:	85 c0                	test   %eax,%eax
80101d57:	74 17                	je     80101d70 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101d59:	83 c7 10             	add    $0x10,%edi
80101d5c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101d5f:	72 c7                	jb     80101d28 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101d61:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101d64:	31 c0                	xor    %eax,%eax
}
80101d66:	5b                   	pop    %ebx
80101d67:	5e                   	pop    %esi
80101d68:	5f                   	pop    %edi
80101d69:	5d                   	pop    %ebp
80101d6a:	c3                   	ret    
80101d6b:	90                   	nop
80101d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101d70:	8b 45 10             	mov    0x10(%ebp),%eax
80101d73:	85 c0                	test   %eax,%eax
80101d75:	74 05                	je     80101d7c <dirlookup+0x7c>
        *poff = off;
80101d77:	8b 45 10             	mov    0x10(%ebp),%eax
80101d7a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d7c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d80:	8b 03                	mov    (%ebx),%eax
80101d82:	e8 19 f6 ff ff       	call   801013a0 <iget>
}
80101d87:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d8a:	5b                   	pop    %ebx
80101d8b:	5e                   	pop    %esi
80101d8c:	5f                   	pop    %edi
80101d8d:	5d                   	pop    %ebp
80101d8e:	c3                   	ret    
      panic("dirlookup read");
80101d8f:	83 ec 0c             	sub    $0xc,%esp
80101d92:	68 c3 71 10 80       	push   $0x801071c3
80101d97:	e8 a4 e6 ff ff       	call   80100440 <panic>
    panic("dirlookup not DIR");
80101d9c:	83 ec 0c             	sub    $0xc,%esp
80101d9f:	68 b1 71 10 80       	push   $0x801071b1
80101da4:	e8 97 e6 ff ff       	call   80100440 <panic>
80101da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101db0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101db0:	55                   	push   %ebp
80101db1:	89 e5                	mov    %esp,%ebp
80101db3:	57                   	push   %edi
80101db4:	56                   	push   %esi
80101db5:	53                   	push   %ebx
80101db6:	89 cf                	mov    %ecx,%edi
80101db8:	89 c3                	mov    %eax,%ebx
80101dba:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101dbd:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101dc0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101dc3:	0f 84 67 01 00 00    	je     80101f30 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101dc9:	e8 62 1b 00 00       	call   80103930 <myproc>
  acquire(&icache.lock);
80101dce:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101dd1:	8b 70 6c             	mov    0x6c(%eax),%esi
  acquire(&icache.lock);
80101dd4:	68 00 0a 11 80       	push   $0x80110a00
80101dd9:	e8 b2 26 00 00       	call   80104490 <acquire>
  ip->ref++;
80101dde:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101de2:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101de9:	e8 62 27 00 00       	call   80104550 <release>
80101dee:	83 c4 10             	add    $0x10,%esp
80101df1:	eb 08                	jmp    80101dfb <namex+0x4b>
80101df3:	90                   	nop
80101df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101df8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101dfb:	0f b6 03             	movzbl (%ebx),%eax
80101dfe:	3c 2f                	cmp    $0x2f,%al
80101e00:	74 f6                	je     80101df8 <namex+0x48>
  if(*path == 0)
80101e02:	84 c0                	test   %al,%al
80101e04:	0f 84 ee 00 00 00    	je     80101ef8 <namex+0x148>
  while(*path != '/' && *path != 0)
80101e0a:	0f b6 03             	movzbl (%ebx),%eax
80101e0d:	3c 2f                	cmp    $0x2f,%al
80101e0f:	0f 84 b3 00 00 00    	je     80101ec8 <namex+0x118>
80101e15:	84 c0                	test   %al,%al
80101e17:	89 da                	mov    %ebx,%edx
80101e19:	75 09                	jne    80101e24 <namex+0x74>
80101e1b:	e9 a8 00 00 00       	jmp    80101ec8 <namex+0x118>
80101e20:	84 c0                	test   %al,%al
80101e22:	74 0a                	je     80101e2e <namex+0x7e>
    path++;
80101e24:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101e27:	0f b6 02             	movzbl (%edx),%eax
80101e2a:	3c 2f                	cmp    $0x2f,%al
80101e2c:	75 f2                	jne    80101e20 <namex+0x70>
80101e2e:	89 d1                	mov    %edx,%ecx
80101e30:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101e32:	83 f9 0d             	cmp    $0xd,%ecx
80101e35:	0f 8e 91 00 00 00    	jle    80101ecc <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101e3b:	83 ec 04             	sub    $0x4,%esp
80101e3e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101e41:	6a 0e                	push   $0xe
80101e43:	53                   	push   %ebx
80101e44:	57                   	push   %edi
80101e45:	e8 06 28 00 00       	call   80104650 <memmove>
    path++;
80101e4a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101e4d:	83 c4 10             	add    $0x10,%esp
    path++;
80101e50:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101e52:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101e55:	75 11                	jne    80101e68 <namex+0xb8>
80101e57:	89 f6                	mov    %esi,%esi
80101e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101e60:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e63:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e66:	74 f8                	je     80101e60 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101e68:	83 ec 0c             	sub    $0xc,%esp
80101e6b:	56                   	push   %esi
80101e6c:	e8 1f f9 ff ff       	call   80101790 <ilock>
    if(ip->type != T_DIR){
80101e71:	83 c4 10             	add    $0x10,%esp
80101e74:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e79:	0f 85 91 00 00 00    	jne    80101f10 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e7f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101e82:	85 d2                	test   %edx,%edx
80101e84:	74 09                	je     80101e8f <namex+0xdf>
80101e86:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e89:	0f 84 b7 00 00 00    	je     80101f46 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e8f:	83 ec 04             	sub    $0x4,%esp
80101e92:	6a 00                	push   $0x0
80101e94:	57                   	push   %edi
80101e95:	56                   	push   %esi
80101e96:	e8 65 fe ff ff       	call   80101d00 <dirlookup>
80101e9b:	83 c4 10             	add    $0x10,%esp
80101e9e:	85 c0                	test   %eax,%eax
80101ea0:	74 6e                	je     80101f10 <namex+0x160>
  iunlock(ip);
80101ea2:	83 ec 0c             	sub    $0xc,%esp
80101ea5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101ea8:	56                   	push   %esi
80101ea9:	e8 c2 f9 ff ff       	call   80101870 <iunlock>
  iput(ip);
80101eae:	89 34 24             	mov    %esi,(%esp)
80101eb1:	e8 0a fa ff ff       	call   801018c0 <iput>
80101eb6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101eb9:	83 c4 10             	add    $0x10,%esp
80101ebc:	89 c6                	mov    %eax,%esi
80101ebe:	e9 38 ff ff ff       	jmp    80101dfb <namex+0x4b>
80101ec3:	90                   	nop
80101ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101ec8:	89 da                	mov    %ebx,%edx
80101eca:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101ecc:	83 ec 04             	sub    $0x4,%esp
80101ecf:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101ed2:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101ed5:	51                   	push   %ecx
80101ed6:	53                   	push   %ebx
80101ed7:	57                   	push   %edi
80101ed8:	e8 73 27 00 00       	call   80104650 <memmove>
    name[len] = 0;
80101edd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101ee0:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101ee3:	83 c4 10             	add    $0x10,%esp
80101ee6:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101eea:	89 d3                	mov    %edx,%ebx
80101eec:	e9 61 ff ff ff       	jmp    80101e52 <namex+0xa2>
80101ef1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101ef8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101efb:	85 c0                	test   %eax,%eax
80101efd:	75 5d                	jne    80101f5c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101eff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f02:	89 f0                	mov    %esi,%eax
80101f04:	5b                   	pop    %ebx
80101f05:	5e                   	pop    %esi
80101f06:	5f                   	pop    %edi
80101f07:	5d                   	pop    %ebp
80101f08:	c3                   	ret    
80101f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101f10:	83 ec 0c             	sub    $0xc,%esp
80101f13:	56                   	push   %esi
80101f14:	e8 57 f9 ff ff       	call   80101870 <iunlock>
  iput(ip);
80101f19:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101f1c:	31 f6                	xor    %esi,%esi
  iput(ip);
80101f1e:	e8 9d f9 ff ff       	call   801018c0 <iput>
      return 0;
80101f23:	83 c4 10             	add    $0x10,%esp
}
80101f26:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f29:	89 f0                	mov    %esi,%eax
80101f2b:	5b                   	pop    %ebx
80101f2c:	5e                   	pop    %esi
80101f2d:	5f                   	pop    %edi
80101f2e:	5d                   	pop    %ebp
80101f2f:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101f30:	ba 01 00 00 00       	mov    $0x1,%edx
80101f35:	b8 01 00 00 00       	mov    $0x1,%eax
80101f3a:	e8 61 f4 ff ff       	call   801013a0 <iget>
80101f3f:	89 c6                	mov    %eax,%esi
80101f41:	e9 b5 fe ff ff       	jmp    80101dfb <namex+0x4b>
      iunlock(ip);
80101f46:	83 ec 0c             	sub    $0xc,%esp
80101f49:	56                   	push   %esi
80101f4a:	e8 21 f9 ff ff       	call   80101870 <iunlock>
      return ip;
80101f4f:	83 c4 10             	add    $0x10,%esp
}
80101f52:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f55:	89 f0                	mov    %esi,%eax
80101f57:	5b                   	pop    %ebx
80101f58:	5e                   	pop    %esi
80101f59:	5f                   	pop    %edi
80101f5a:	5d                   	pop    %ebp
80101f5b:	c3                   	ret    
    iput(ip);
80101f5c:	83 ec 0c             	sub    $0xc,%esp
80101f5f:	56                   	push   %esi
    return 0;
80101f60:	31 f6                	xor    %esi,%esi
    iput(ip);
80101f62:	e8 59 f9 ff ff       	call   801018c0 <iput>
    return 0;
80101f67:	83 c4 10             	add    $0x10,%esp
80101f6a:	eb 93                	jmp    80101eff <namex+0x14f>
80101f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101f70 <dirlink>:
{
80101f70:	55                   	push   %ebp
80101f71:	89 e5                	mov    %esp,%ebp
80101f73:	57                   	push   %edi
80101f74:	56                   	push   %esi
80101f75:	53                   	push   %ebx
80101f76:	83 ec 20             	sub    $0x20,%esp
80101f79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101f7c:	6a 00                	push   $0x0
80101f7e:	ff 75 0c             	pushl  0xc(%ebp)
80101f81:	53                   	push   %ebx
80101f82:	e8 79 fd ff ff       	call   80101d00 <dirlookup>
80101f87:	83 c4 10             	add    $0x10,%esp
80101f8a:	85 c0                	test   %eax,%eax
80101f8c:	75 67                	jne    80101ff5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f8e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101f91:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f94:	85 ff                	test   %edi,%edi
80101f96:	74 29                	je     80101fc1 <dirlink+0x51>
80101f98:	31 ff                	xor    %edi,%edi
80101f9a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f9d:	eb 09                	jmp    80101fa8 <dirlink+0x38>
80101f9f:	90                   	nop
80101fa0:	83 c7 10             	add    $0x10,%edi
80101fa3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101fa6:	73 19                	jae    80101fc1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fa8:	6a 10                	push   $0x10
80101faa:	57                   	push   %edi
80101fab:	56                   	push   %esi
80101fac:	53                   	push   %ebx
80101fad:	e8 be fa ff ff       	call   80101a70 <readi>
80101fb2:	83 c4 10             	add    $0x10,%esp
80101fb5:	83 f8 10             	cmp    $0x10,%eax
80101fb8:	75 4e                	jne    80102008 <dirlink+0x98>
    if(de.inum == 0)
80101fba:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101fbf:	75 df                	jne    80101fa0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101fc1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101fc4:	83 ec 04             	sub    $0x4,%esp
80101fc7:	6a 0e                	push   $0xe
80101fc9:	ff 75 0c             	pushl  0xc(%ebp)
80101fcc:	50                   	push   %eax
80101fcd:	e8 4e 27 00 00       	call   80104720 <strncpy>
  de.inum = inum;
80101fd2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fd5:	6a 10                	push   $0x10
80101fd7:	57                   	push   %edi
80101fd8:	56                   	push   %esi
80101fd9:	53                   	push   %ebx
  de.inum = inum;
80101fda:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fde:	e8 cd fb ff ff       	call   80101bb0 <writei>
80101fe3:	83 c4 20             	add    $0x20,%esp
80101fe6:	83 f8 10             	cmp    $0x10,%eax
80101fe9:	75 2a                	jne    80102015 <dirlink+0xa5>
  return 0;
80101feb:	31 c0                	xor    %eax,%eax
}
80101fed:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ff0:	5b                   	pop    %ebx
80101ff1:	5e                   	pop    %esi
80101ff2:	5f                   	pop    %edi
80101ff3:	5d                   	pop    %ebp
80101ff4:	c3                   	ret    
    iput(ip);
80101ff5:	83 ec 0c             	sub    $0xc,%esp
80101ff8:	50                   	push   %eax
80101ff9:	e8 c2 f8 ff ff       	call   801018c0 <iput>
    return -1;
80101ffe:	83 c4 10             	add    $0x10,%esp
80102001:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102006:	eb e5                	jmp    80101fed <dirlink+0x7d>
      panic("dirlink read");
80102008:	83 ec 0c             	sub    $0xc,%esp
8010200b:	68 d2 71 10 80       	push   $0x801071d2
80102010:	e8 2b e4 ff ff       	call   80100440 <panic>
    panic("dirlink");
80102015:	83 ec 0c             	sub    $0xc,%esp
80102018:	68 c6 77 10 80       	push   $0x801077c6
8010201d:	e8 1e e4 ff ff       	call   80100440 <panic>
80102022:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102030 <namei>:

struct inode*
namei(char *path)
{
80102030:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102031:	31 d2                	xor    %edx,%edx
{
80102033:	89 e5                	mov    %esp,%ebp
80102035:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102038:	8b 45 08             	mov    0x8(%ebp),%eax
8010203b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010203e:	e8 6d fd ff ff       	call   80101db0 <namex>
}
80102043:	c9                   	leave  
80102044:	c3                   	ret    
80102045:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102050 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102050:	55                   	push   %ebp
  return namex(path, 1, name);
80102051:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102056:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102058:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010205b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010205e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010205f:	e9 4c fd ff ff       	jmp    80101db0 <namex>
80102064:	66 90                	xchg   %ax,%ax
80102066:	66 90                	xchg   %ax,%ax
80102068:	66 90                	xchg   %ax,%ax
8010206a:	66 90                	xchg   %ax,%ax
8010206c:	66 90                	xchg   %ax,%ax
8010206e:	66 90                	xchg   %ax,%ax

80102070 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102070:	55                   	push   %ebp
80102071:	89 e5                	mov    %esp,%ebp
80102073:	57                   	push   %edi
80102074:	56                   	push   %esi
80102075:	53                   	push   %ebx
80102076:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102079:	85 c0                	test   %eax,%eax
8010207b:	0f 84 b4 00 00 00    	je     80102135 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102081:	8b 58 08             	mov    0x8(%eax),%ebx
80102084:	89 c6                	mov    %eax,%esi
80102086:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
8010208c:	0f 87 96 00 00 00    	ja     80102128 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102092:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102097:	89 f6                	mov    %esi,%esi
80102099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020a0:	89 ca                	mov    %ecx,%edx
801020a2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020a3:	83 e0 c0             	and    $0xffffffc0,%eax
801020a6:	3c 40                	cmp    $0x40,%al
801020a8:	75 f6                	jne    801020a0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801020aa:	31 ff                	xor    %edi,%edi
801020ac:	ba f6 03 00 00       	mov    $0x3f6,%edx
801020b1:	89 f8                	mov    %edi,%eax
801020b3:	ee                   	out    %al,(%dx)
801020b4:	b8 01 00 00 00       	mov    $0x1,%eax
801020b9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801020be:	ee                   	out    %al,(%dx)
801020bf:	ba f3 01 00 00       	mov    $0x1f3,%edx
801020c4:	89 d8                	mov    %ebx,%eax
801020c6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801020c7:	89 d8                	mov    %ebx,%eax
801020c9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801020ce:	c1 f8 08             	sar    $0x8,%eax
801020d1:	ee                   	out    %al,(%dx)
801020d2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801020d7:	89 f8                	mov    %edi,%eax
801020d9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801020da:	0f b6 46 04          	movzbl 0x4(%esi),%eax
801020de:	ba f6 01 00 00       	mov    $0x1f6,%edx
801020e3:	c1 e0 04             	shl    $0x4,%eax
801020e6:	83 e0 10             	and    $0x10,%eax
801020e9:	83 c8 e0             	or     $0xffffffe0,%eax
801020ec:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801020ed:	f6 06 04             	testb  $0x4,(%esi)
801020f0:	75 16                	jne    80102108 <idestart+0x98>
801020f2:	b8 20 00 00 00       	mov    $0x20,%eax
801020f7:	89 ca                	mov    %ecx,%edx
801020f9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801020fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020fd:	5b                   	pop    %ebx
801020fe:	5e                   	pop    %esi
801020ff:	5f                   	pop    %edi
80102100:	5d                   	pop    %ebp
80102101:	c3                   	ret    
80102102:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102108:	b8 30 00 00 00       	mov    $0x30,%eax
8010210d:	89 ca                	mov    %ecx,%edx
8010210f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102110:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102115:	83 c6 5c             	add    $0x5c,%esi
80102118:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010211d:	fc                   	cld    
8010211e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102120:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102123:	5b                   	pop    %ebx
80102124:	5e                   	pop    %esi
80102125:	5f                   	pop    %edi
80102126:	5d                   	pop    %ebp
80102127:	c3                   	ret    
    panic("incorrect blockno");
80102128:	83 ec 0c             	sub    $0xc,%esp
8010212b:	68 3c 72 10 80       	push   $0x8010723c
80102130:	e8 0b e3 ff ff       	call   80100440 <panic>
    panic("idestart");
80102135:	83 ec 0c             	sub    $0xc,%esp
80102138:	68 33 72 10 80       	push   $0x80107233
8010213d:	e8 fe e2 ff ff       	call   80100440 <panic>
80102142:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102150 <ideinit>:
{
80102150:	55                   	push   %ebp
80102151:	89 e5                	mov    %esp,%ebp
80102153:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102156:	68 4e 72 10 80       	push   $0x8010724e
8010215b:	68 80 a5 10 80       	push   $0x8010a580
80102160:	e8 eb 21 00 00       	call   80104350 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102165:	58                   	pop    %eax
80102166:	a1 20 2d 11 80       	mov    0x80112d20,%eax
8010216b:	5a                   	pop    %edx
8010216c:	83 e8 01             	sub    $0x1,%eax
8010216f:	50                   	push   %eax
80102170:	6a 0e                	push   $0xe
80102172:	e8 a9 02 00 00       	call   80102420 <ioapicenable>
80102177:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010217a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010217f:	90                   	nop
80102180:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102181:	83 e0 c0             	and    $0xffffffc0,%eax
80102184:	3c 40                	cmp    $0x40,%al
80102186:	75 f8                	jne    80102180 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102188:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010218d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102192:	ee                   	out    %al,(%dx)
80102193:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102198:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010219d:	eb 06                	jmp    801021a5 <ideinit+0x55>
8010219f:	90                   	nop
  for(i=0; i<1000; i++){
801021a0:	83 e9 01             	sub    $0x1,%ecx
801021a3:	74 0f                	je     801021b4 <ideinit+0x64>
801021a5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801021a6:	84 c0                	test   %al,%al
801021a8:	74 f6                	je     801021a0 <ideinit+0x50>
      havedisk1 = 1;
801021aa:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
801021b1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021b4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801021b9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021be:	ee                   	out    %al,(%dx)
}
801021bf:	c9                   	leave  
801021c0:	c3                   	ret    
801021c1:	eb 0d                	jmp    801021d0 <ideintr>
801021c3:	90                   	nop
801021c4:	90                   	nop
801021c5:	90                   	nop
801021c6:	90                   	nop
801021c7:	90                   	nop
801021c8:	90                   	nop
801021c9:	90                   	nop
801021ca:	90                   	nop
801021cb:	90                   	nop
801021cc:	90                   	nop
801021cd:	90                   	nop
801021ce:	90                   	nop
801021cf:	90                   	nop

801021d0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801021d0:	55                   	push   %ebp
801021d1:	89 e5                	mov    %esp,%ebp
801021d3:	57                   	push   %edi
801021d4:	56                   	push   %esi
801021d5:	53                   	push   %ebx
801021d6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801021d9:	68 80 a5 10 80       	push   $0x8010a580
801021de:	e8 ad 22 00 00       	call   80104490 <acquire>

  if((b = idequeue) == 0){
801021e3:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
801021e9:	83 c4 10             	add    $0x10,%esp
801021ec:	85 db                	test   %ebx,%ebx
801021ee:	74 67                	je     80102257 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801021f0:	8b 43 58             	mov    0x58(%ebx),%eax
801021f3:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801021f8:	8b 3b                	mov    (%ebx),%edi
801021fa:	f7 c7 04 00 00 00    	test   $0x4,%edi
80102200:	75 31                	jne    80102233 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102202:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102207:	89 f6                	mov    %esi,%esi
80102209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102210:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102211:	89 c6                	mov    %eax,%esi
80102213:	83 e6 c0             	and    $0xffffffc0,%esi
80102216:	89 f1                	mov    %esi,%ecx
80102218:	80 f9 40             	cmp    $0x40,%cl
8010221b:	75 f3                	jne    80102210 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010221d:	a8 21                	test   $0x21,%al
8010221f:	75 12                	jne    80102233 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
80102221:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102224:	b9 80 00 00 00       	mov    $0x80,%ecx
80102229:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010222e:	fc                   	cld    
8010222f:	f3 6d                	rep insl (%dx),%es:(%edi)
80102231:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102233:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
80102236:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102239:	89 f9                	mov    %edi,%ecx
8010223b:	83 c9 02             	or     $0x2,%ecx
8010223e:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102240:	53                   	push   %ebx
80102241:	e8 3a 1e 00 00       	call   80104080 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102246:	a1 64 a5 10 80       	mov    0x8010a564,%eax
8010224b:	83 c4 10             	add    $0x10,%esp
8010224e:	85 c0                	test   %eax,%eax
80102250:	74 05                	je     80102257 <ideintr+0x87>
    idestart(idequeue);
80102252:	e8 19 fe ff ff       	call   80102070 <idestart>
    release(&idelock);
80102257:	83 ec 0c             	sub    $0xc,%esp
8010225a:	68 80 a5 10 80       	push   $0x8010a580
8010225f:	e8 ec 22 00 00       	call   80104550 <release>

  release(&idelock);
}
80102264:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102267:	5b                   	pop    %ebx
80102268:	5e                   	pop    %esi
80102269:	5f                   	pop    %edi
8010226a:	5d                   	pop    %ebp
8010226b:	c3                   	ret    
8010226c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102270 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102270:	55                   	push   %ebp
80102271:	89 e5                	mov    %esp,%ebp
80102273:	53                   	push   %ebx
80102274:	83 ec 10             	sub    $0x10,%esp
80102277:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010227a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010227d:	50                   	push   %eax
8010227e:	e8 7d 20 00 00       	call   80104300 <holdingsleep>
80102283:	83 c4 10             	add    $0x10,%esp
80102286:	85 c0                	test   %eax,%eax
80102288:	0f 84 c6 00 00 00    	je     80102354 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010228e:	8b 03                	mov    (%ebx),%eax
80102290:	83 e0 06             	and    $0x6,%eax
80102293:	83 f8 02             	cmp    $0x2,%eax
80102296:	0f 84 ab 00 00 00    	je     80102347 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010229c:	8b 53 04             	mov    0x4(%ebx),%edx
8010229f:	85 d2                	test   %edx,%edx
801022a1:	74 0d                	je     801022b0 <iderw+0x40>
801022a3:	a1 60 a5 10 80       	mov    0x8010a560,%eax
801022a8:	85 c0                	test   %eax,%eax
801022aa:	0f 84 b1 00 00 00    	je     80102361 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801022b0:	83 ec 0c             	sub    $0xc,%esp
801022b3:	68 80 a5 10 80       	push   $0x8010a580
801022b8:	e8 d3 21 00 00       	call   80104490 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022bd:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
801022c3:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
801022c6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022cd:	85 d2                	test   %edx,%edx
801022cf:	75 09                	jne    801022da <iderw+0x6a>
801022d1:	eb 6d                	jmp    80102340 <iderw+0xd0>
801022d3:	90                   	nop
801022d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801022d8:	89 c2                	mov    %eax,%edx
801022da:	8b 42 58             	mov    0x58(%edx),%eax
801022dd:	85 c0                	test   %eax,%eax
801022df:	75 f7                	jne    801022d8 <iderw+0x68>
801022e1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801022e4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801022e6:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
801022ec:	74 42                	je     80102330 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801022ee:	8b 03                	mov    (%ebx),%eax
801022f0:	83 e0 06             	and    $0x6,%eax
801022f3:	83 f8 02             	cmp    $0x2,%eax
801022f6:	74 23                	je     8010231b <iderw+0xab>
801022f8:	90                   	nop
801022f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102300:	83 ec 08             	sub    $0x8,%esp
80102303:	68 80 a5 10 80       	push   $0x8010a580
80102308:	53                   	push   %ebx
80102309:	e8 c2 1b 00 00       	call   80103ed0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010230e:	8b 03                	mov    (%ebx),%eax
80102310:	83 c4 10             	add    $0x10,%esp
80102313:	83 e0 06             	and    $0x6,%eax
80102316:	83 f8 02             	cmp    $0x2,%eax
80102319:	75 e5                	jne    80102300 <iderw+0x90>
  }


  release(&idelock);
8010231b:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
80102322:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102325:	c9                   	leave  
  release(&idelock);
80102326:	e9 25 22 00 00       	jmp    80104550 <release>
8010232b:	90                   	nop
8010232c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102330:	89 d8                	mov    %ebx,%eax
80102332:	e8 39 fd ff ff       	call   80102070 <idestart>
80102337:	eb b5                	jmp    801022ee <iderw+0x7e>
80102339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102340:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
80102345:	eb 9d                	jmp    801022e4 <iderw+0x74>
    panic("iderw: nothing to do");
80102347:	83 ec 0c             	sub    $0xc,%esp
8010234a:	68 68 72 10 80       	push   $0x80107268
8010234f:	e8 ec e0 ff ff       	call   80100440 <panic>
    panic("iderw: buf not locked");
80102354:	83 ec 0c             	sub    $0xc,%esp
80102357:	68 52 72 10 80       	push   $0x80107252
8010235c:	e8 df e0 ff ff       	call   80100440 <panic>
    panic("iderw: ide disk 1 not present");
80102361:	83 ec 0c             	sub    $0xc,%esp
80102364:	68 7d 72 10 80       	push   $0x8010727d
80102369:	e8 d2 e0 ff ff       	call   80100440 <panic>
8010236e:	66 90                	xchg   %ax,%ax

80102370 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102370:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102371:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
80102378:	00 c0 fe 
{
8010237b:	89 e5                	mov    %esp,%ebp
8010237d:	56                   	push   %esi
8010237e:	53                   	push   %ebx
  ioapic->reg = reg;
8010237f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102386:	00 00 00 
  return ioapic->data;
80102389:	a1 54 26 11 80       	mov    0x80112654,%eax
8010238e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102391:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102397:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010239d:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801023a4:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
801023a7:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801023aa:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
801023ad:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801023b0:	39 c2                	cmp    %eax,%edx
801023b2:	74 16                	je     801023ca <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801023b4:	83 ec 0c             	sub    $0xc,%esp
801023b7:	68 9c 72 10 80       	push   $0x8010729c
801023bc:	e8 4f e3 ff ff       	call   80100710 <cprintf>
801023c1:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
801023c7:	83 c4 10             	add    $0x10,%esp
801023ca:	83 c3 21             	add    $0x21,%ebx
{
801023cd:	ba 10 00 00 00       	mov    $0x10,%edx
801023d2:	b8 20 00 00 00       	mov    $0x20,%eax
801023d7:	89 f6                	mov    %esi,%esi
801023d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
801023e0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
801023e2:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801023e8:	89 c6                	mov    %eax,%esi
801023ea:	81 ce 00 00 01 00    	or     $0x10000,%esi
801023f0:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801023f3:	89 71 10             	mov    %esi,0x10(%ecx)
801023f6:	8d 72 01             	lea    0x1(%edx),%esi
801023f9:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
801023fc:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
801023fe:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
80102400:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
80102406:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010240d:	75 d1                	jne    801023e0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010240f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102412:	5b                   	pop    %ebx
80102413:	5e                   	pop    %esi
80102414:	5d                   	pop    %ebp
80102415:	c3                   	ret    
80102416:	8d 76 00             	lea    0x0(%esi),%esi
80102419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102420 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102420:	55                   	push   %ebp
  ioapic->reg = reg;
80102421:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
{
80102427:	89 e5                	mov    %esp,%ebp
80102429:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010242c:	8d 50 20             	lea    0x20(%eax),%edx
8010242f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102433:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102435:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010243b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010243e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102441:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102444:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102446:	a1 54 26 11 80       	mov    0x80112654,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010244b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010244e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102451:	5d                   	pop    %ebp
80102452:	c3                   	ret    
80102453:	66 90                	xchg   %ax,%ax
80102455:	66 90                	xchg   %ax,%ax
80102457:	66 90                	xchg   %ax,%ax
80102459:	66 90                	xchg   %ax,%ax
8010245b:	66 90                	xchg   %ax,%ax
8010245d:	66 90                	xchg   %ax,%ax
8010245f:	90                   	nop

80102460 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102460:	55                   	push   %ebp
80102461:	89 e5                	mov    %esp,%ebp
80102463:	53                   	push   %ebx
80102464:	83 ec 04             	sub    $0x4,%esp
80102467:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010246a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102470:	75 70                	jne    801024e2 <kfree+0x82>
80102472:	81 fb c8 55 11 80    	cmp    $0x801155c8,%ebx
80102478:	72 68                	jb     801024e2 <kfree+0x82>
8010247a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102480:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102485:	77 5b                	ja     801024e2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102487:	83 ec 04             	sub    $0x4,%esp
8010248a:	68 00 10 00 00       	push   $0x1000
8010248f:	6a 01                	push   $0x1
80102491:	53                   	push   %ebx
80102492:	e8 09 21 00 00       	call   801045a0 <memset>

  if(kmem.use_lock)
80102497:	8b 15 94 26 11 80    	mov    0x80112694,%edx
8010249d:	83 c4 10             	add    $0x10,%esp
801024a0:	85 d2                	test   %edx,%edx
801024a2:	75 2c                	jne    801024d0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801024a4:	a1 98 26 11 80       	mov    0x80112698,%eax
801024a9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801024ab:	a1 94 26 11 80       	mov    0x80112694,%eax
  kmem.freelist = r;
801024b0:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
  if(kmem.use_lock)
801024b6:	85 c0                	test   %eax,%eax
801024b8:	75 06                	jne    801024c0 <kfree+0x60>
    release(&kmem.lock);
}
801024ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024bd:	c9                   	leave  
801024be:	c3                   	ret    
801024bf:	90                   	nop
    release(&kmem.lock);
801024c0:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
}
801024c7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024ca:	c9                   	leave  
    release(&kmem.lock);
801024cb:	e9 80 20 00 00       	jmp    80104550 <release>
    acquire(&kmem.lock);
801024d0:	83 ec 0c             	sub    $0xc,%esp
801024d3:	68 60 26 11 80       	push   $0x80112660
801024d8:	e8 b3 1f 00 00       	call   80104490 <acquire>
801024dd:	83 c4 10             	add    $0x10,%esp
801024e0:	eb c2                	jmp    801024a4 <kfree+0x44>
    panic("kfree");
801024e2:	83 ec 0c             	sub    $0xc,%esp
801024e5:	68 ce 72 10 80       	push   $0x801072ce
801024ea:	e8 51 df ff ff       	call   80100440 <panic>
801024ef:	90                   	nop

801024f0 <freerange>:
{
801024f0:	55                   	push   %ebp
801024f1:	89 e5                	mov    %esp,%ebp
801024f3:	56                   	push   %esi
801024f4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801024f5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801024f8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801024fb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102501:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102507:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010250d:	39 de                	cmp    %ebx,%esi
8010250f:	72 23                	jb     80102534 <freerange+0x44>
80102511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102518:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010251e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102521:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102527:	50                   	push   %eax
80102528:	e8 33 ff ff ff       	call   80102460 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010252d:	83 c4 10             	add    $0x10,%esp
80102530:	39 f3                	cmp    %esi,%ebx
80102532:	76 e4                	jbe    80102518 <freerange+0x28>
}
80102534:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102537:	5b                   	pop    %ebx
80102538:	5e                   	pop    %esi
80102539:	5d                   	pop    %ebp
8010253a:	c3                   	ret    
8010253b:	90                   	nop
8010253c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102540 <kinit1>:
{
80102540:	55                   	push   %ebp
80102541:	89 e5                	mov    %esp,%ebp
80102543:	56                   	push   %esi
80102544:	53                   	push   %ebx
80102545:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102548:	83 ec 08             	sub    $0x8,%esp
8010254b:	68 d4 72 10 80       	push   $0x801072d4
80102550:	68 60 26 11 80       	push   $0x80112660
80102555:	e8 f6 1d 00 00       	call   80104350 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010255a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010255d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102560:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
80102567:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010256a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102570:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102576:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010257c:	39 de                	cmp    %ebx,%esi
8010257e:	72 1c                	jb     8010259c <kinit1+0x5c>
    kfree(p);
80102580:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102586:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102589:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010258f:	50                   	push   %eax
80102590:	e8 cb fe ff ff       	call   80102460 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102595:	83 c4 10             	add    $0x10,%esp
80102598:	39 de                	cmp    %ebx,%esi
8010259a:	73 e4                	jae    80102580 <kinit1+0x40>
}
8010259c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010259f:	5b                   	pop    %ebx
801025a0:	5e                   	pop    %esi
801025a1:	5d                   	pop    %ebp
801025a2:	c3                   	ret    
801025a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801025a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025b0 <kinit2>:
{
801025b0:	55                   	push   %ebp
801025b1:	89 e5                	mov    %esp,%ebp
801025b3:	56                   	push   %esi
801025b4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801025b5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801025b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801025bb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025cd:	39 de                	cmp    %ebx,%esi
801025cf:	72 23                	jb     801025f4 <kinit2+0x44>
801025d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801025d8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801025de:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025e7:	50                   	push   %eax
801025e8:	e8 73 fe ff ff       	call   80102460 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025ed:	83 c4 10             	add    $0x10,%esp
801025f0:	39 de                	cmp    %ebx,%esi
801025f2:	73 e4                	jae    801025d8 <kinit2+0x28>
  kmem.use_lock = 1;
801025f4:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
801025fb:	00 00 00 
}
801025fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102601:	5b                   	pop    %ebx
80102602:	5e                   	pop    %esi
80102603:	5d                   	pop    %ebp
80102604:	c3                   	ret    
80102605:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102610 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102610:	a1 94 26 11 80       	mov    0x80112694,%eax
80102615:	85 c0                	test   %eax,%eax
80102617:	75 1f                	jne    80102638 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102619:	a1 98 26 11 80       	mov    0x80112698,%eax
  if(r)
8010261e:	85 c0                	test   %eax,%eax
80102620:	74 0e                	je     80102630 <kalloc+0x20>
    kmem.freelist = r->next;
80102622:	8b 10                	mov    (%eax),%edx
80102624:	89 15 98 26 11 80    	mov    %edx,0x80112698
8010262a:	c3                   	ret    
8010262b:	90                   	nop
8010262c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102630:	f3 c3                	repz ret 
80102632:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
80102638:	55                   	push   %ebp
80102639:	89 e5                	mov    %esp,%ebp
8010263b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010263e:	68 60 26 11 80       	push   $0x80112660
80102643:	e8 48 1e 00 00       	call   80104490 <acquire>
  r = kmem.freelist;
80102648:	a1 98 26 11 80       	mov    0x80112698,%eax
  if(r)
8010264d:	83 c4 10             	add    $0x10,%esp
80102650:	8b 15 94 26 11 80    	mov    0x80112694,%edx
80102656:	85 c0                	test   %eax,%eax
80102658:	74 08                	je     80102662 <kalloc+0x52>
    kmem.freelist = r->next;
8010265a:	8b 08                	mov    (%eax),%ecx
8010265c:	89 0d 98 26 11 80    	mov    %ecx,0x80112698
  if(kmem.use_lock)
80102662:	85 d2                	test   %edx,%edx
80102664:	74 16                	je     8010267c <kalloc+0x6c>
    release(&kmem.lock);
80102666:	83 ec 0c             	sub    $0xc,%esp
80102669:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010266c:	68 60 26 11 80       	push   $0x80112660
80102671:	e8 da 1e 00 00       	call   80104550 <release>
  return (char*)r;
80102676:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102679:	83 c4 10             	add    $0x10,%esp
}
8010267c:	c9                   	leave  
8010267d:	c3                   	ret    
8010267e:	66 90                	xchg   %ax,%ax

80102680 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102680:	ba 64 00 00 00       	mov    $0x64,%edx
80102685:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102686:	a8 01                	test   $0x1,%al
80102688:	0f 84 c2 00 00 00    	je     80102750 <kbdgetc+0xd0>
8010268e:	ba 60 00 00 00       	mov    $0x60,%edx
80102693:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102694:	0f b6 d0             	movzbl %al,%edx
80102697:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx

  if(data == 0xE0){
8010269d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
801026a3:	0f 84 7f 00 00 00    	je     80102728 <kbdgetc+0xa8>
{
801026a9:	55                   	push   %ebp
801026aa:	89 e5                	mov    %esp,%ebp
801026ac:	53                   	push   %ebx
801026ad:	89 cb                	mov    %ecx,%ebx
801026af:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801026b2:	84 c0                	test   %al,%al
801026b4:	78 4a                	js     80102700 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801026b6:	85 db                	test   %ebx,%ebx
801026b8:	74 09                	je     801026c3 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801026ba:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801026bd:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
801026c0:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
801026c3:	0f b6 82 00 74 10 80 	movzbl -0x7fef8c00(%edx),%eax
801026ca:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
801026cc:	0f b6 82 00 73 10 80 	movzbl -0x7fef8d00(%edx),%eax
801026d3:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801026d5:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
801026d7:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
801026dd:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801026e0:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801026e3:	8b 04 85 e0 72 10 80 	mov    -0x7fef8d20(,%eax,4),%eax
801026ea:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801026ee:	74 31                	je     80102721 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
801026f0:	8d 50 9f             	lea    -0x61(%eax),%edx
801026f3:	83 fa 19             	cmp    $0x19,%edx
801026f6:	77 40                	ja     80102738 <kbdgetc+0xb8>
      c += 'A' - 'a';
801026f8:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801026fb:	5b                   	pop    %ebx
801026fc:	5d                   	pop    %ebp
801026fd:	c3                   	ret    
801026fe:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102700:	83 e0 7f             	and    $0x7f,%eax
80102703:	85 db                	test   %ebx,%ebx
80102705:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102708:	0f b6 82 00 74 10 80 	movzbl -0x7fef8c00(%edx),%eax
8010270f:	83 c8 40             	or     $0x40,%eax
80102712:	0f b6 c0             	movzbl %al,%eax
80102715:	f7 d0                	not    %eax
80102717:	21 c1                	and    %eax,%ecx
    return 0;
80102719:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
8010271b:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
80102721:	5b                   	pop    %ebx
80102722:	5d                   	pop    %ebp
80102723:	c3                   	ret    
80102724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102728:	83 c9 40             	or     $0x40,%ecx
    return 0;
8010272b:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
8010272d:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
    return 0;
80102733:	c3                   	ret    
80102734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102738:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010273b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010273e:	5b                   	pop    %ebx
      c += 'a' - 'A';
8010273f:	83 f9 1a             	cmp    $0x1a,%ecx
80102742:	0f 42 c2             	cmovb  %edx,%eax
}
80102745:	5d                   	pop    %ebp
80102746:	c3                   	ret    
80102747:	89 f6                	mov    %esi,%esi
80102749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102750:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102755:	c3                   	ret    
80102756:	8d 76 00             	lea    0x0(%esi),%esi
80102759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102760 <kbdintr>:

void
kbdintr(void)
{
80102760:	55                   	push   %ebp
80102761:	89 e5                	mov    %esp,%ebp
80102763:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102766:	68 80 26 10 80       	push   $0x80102680
8010276b:	e8 50 e1 ff ff       	call   801008c0 <consoleintr>
}
80102770:	83 c4 10             	add    $0x10,%esp
80102773:	c9                   	leave  
80102774:	c3                   	ret    
80102775:	66 90                	xchg   %ax,%ax
80102777:	66 90                	xchg   %ax,%ax
80102779:	66 90                	xchg   %ax,%ax
8010277b:	66 90                	xchg   %ax,%ax
8010277d:	66 90                	xchg   %ax,%ax
8010277f:	90                   	nop

80102780 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102780:	a1 9c 26 11 80       	mov    0x8011269c,%eax
{
80102785:	55                   	push   %ebp
80102786:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102788:	85 c0                	test   %eax,%eax
8010278a:	0f 84 c8 00 00 00    	je     80102858 <lapicinit+0xd8>
  lapic[index] = value;
80102790:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102797:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010279a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010279d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801027a4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027a7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027aa:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801027b1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801027b4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027b7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801027be:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801027c1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027c4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801027cb:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801027ce:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027d1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801027d8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801027db:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801027de:	8b 50 30             	mov    0x30(%eax),%edx
801027e1:	c1 ea 10             	shr    $0x10,%edx
801027e4:	80 fa 03             	cmp    $0x3,%dl
801027e7:	77 77                	ja     80102860 <lapicinit+0xe0>
  lapic[index] = value;
801027e9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801027f0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027f3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027f6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801027fd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102800:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102803:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010280a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010280d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102810:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102817:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010281a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010281d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102824:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102827:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010282a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102831:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102834:	8b 50 20             	mov    0x20(%eax),%edx
80102837:	89 f6                	mov    %esi,%esi
80102839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102840:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102846:	80 e6 10             	and    $0x10,%dh
80102849:	75 f5                	jne    80102840 <lapicinit+0xc0>
  lapic[index] = value;
8010284b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102852:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102855:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102858:	5d                   	pop    %ebp
80102859:	c3                   	ret    
8010285a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102860:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102867:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010286a:	8b 50 20             	mov    0x20(%eax),%edx
8010286d:	e9 77 ff ff ff       	jmp    801027e9 <lapicinit+0x69>
80102872:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102880 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102880:	8b 15 9c 26 11 80    	mov    0x8011269c,%edx
{
80102886:	55                   	push   %ebp
80102887:	31 c0                	xor    %eax,%eax
80102889:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010288b:	85 d2                	test   %edx,%edx
8010288d:	74 06                	je     80102895 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
8010288f:	8b 42 20             	mov    0x20(%edx),%eax
80102892:	c1 e8 18             	shr    $0x18,%eax
}
80102895:	5d                   	pop    %ebp
80102896:	c3                   	ret    
80102897:	89 f6                	mov    %esi,%esi
80102899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028a0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801028a0:	a1 9c 26 11 80       	mov    0x8011269c,%eax
{
801028a5:	55                   	push   %ebp
801028a6:	89 e5                	mov    %esp,%ebp
  if(lapic)
801028a8:	85 c0                	test   %eax,%eax
801028aa:	74 0d                	je     801028b9 <lapiceoi+0x19>
  lapic[index] = value;
801028ac:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801028b3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028b6:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
801028b9:	5d                   	pop    %ebp
801028ba:	c3                   	ret    
801028bb:	90                   	nop
801028bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801028c0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801028c0:	55                   	push   %ebp
801028c1:	89 e5                	mov    %esp,%ebp
}
801028c3:	5d                   	pop    %ebp
801028c4:	c3                   	ret    
801028c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028d0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801028d0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028d1:	b8 0f 00 00 00       	mov    $0xf,%eax
801028d6:	ba 70 00 00 00       	mov    $0x70,%edx
801028db:	89 e5                	mov    %esp,%ebp
801028dd:	53                   	push   %ebx
801028de:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801028e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801028e4:	ee                   	out    %al,(%dx)
801028e5:	b8 0a 00 00 00       	mov    $0xa,%eax
801028ea:	ba 71 00 00 00       	mov    $0x71,%edx
801028ef:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801028f0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801028f2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801028f5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801028fb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801028fd:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102900:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102903:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102905:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102908:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010290e:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102913:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102919:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010291c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102923:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102926:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102929:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102930:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102933:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102936:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010293c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010293f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102945:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102948:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010294e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102951:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102957:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010295a:	5b                   	pop    %ebx
8010295b:	5d                   	pop    %ebp
8010295c:	c3                   	ret    
8010295d:	8d 76 00             	lea    0x0(%esi),%esi

80102960 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102960:	55                   	push   %ebp
80102961:	b8 0b 00 00 00       	mov    $0xb,%eax
80102966:	ba 70 00 00 00       	mov    $0x70,%edx
8010296b:	89 e5                	mov    %esp,%ebp
8010296d:	57                   	push   %edi
8010296e:	56                   	push   %esi
8010296f:	53                   	push   %ebx
80102970:	83 ec 4c             	sub    $0x4c,%esp
80102973:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102974:	ba 71 00 00 00       	mov    $0x71,%edx
80102979:	ec                   	in     (%dx),%al
8010297a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010297d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102982:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102985:	8d 76 00             	lea    0x0(%esi),%esi
80102988:	31 c0                	xor    %eax,%eax
8010298a:	89 da                	mov    %ebx,%edx
8010298c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010298d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102992:	89 ca                	mov    %ecx,%edx
80102994:	ec                   	in     (%dx),%al
80102995:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102998:	89 da                	mov    %ebx,%edx
8010299a:	b8 02 00 00 00       	mov    $0x2,%eax
8010299f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029a0:	89 ca                	mov    %ecx,%edx
801029a2:	ec                   	in     (%dx),%al
801029a3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029a6:	89 da                	mov    %ebx,%edx
801029a8:	b8 04 00 00 00       	mov    $0x4,%eax
801029ad:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ae:	89 ca                	mov    %ecx,%edx
801029b0:	ec                   	in     (%dx),%al
801029b1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029b4:	89 da                	mov    %ebx,%edx
801029b6:	b8 07 00 00 00       	mov    $0x7,%eax
801029bb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029bc:	89 ca                	mov    %ecx,%edx
801029be:	ec                   	in     (%dx),%al
801029bf:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c2:	89 da                	mov    %ebx,%edx
801029c4:	b8 08 00 00 00       	mov    $0x8,%eax
801029c9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ca:	89 ca                	mov    %ecx,%edx
801029cc:	ec                   	in     (%dx),%al
801029cd:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029cf:	89 da                	mov    %ebx,%edx
801029d1:	b8 09 00 00 00       	mov    $0x9,%eax
801029d6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029d7:	89 ca                	mov    %ecx,%edx
801029d9:	ec                   	in     (%dx),%al
801029da:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029dc:	89 da                	mov    %ebx,%edx
801029de:	b8 0a 00 00 00       	mov    $0xa,%eax
801029e3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029e4:	89 ca                	mov    %ecx,%edx
801029e6:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801029e7:	84 c0                	test   %al,%al
801029e9:	78 9d                	js     80102988 <cmostime+0x28>
  return inb(CMOS_RETURN);
801029eb:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
801029ef:	89 fa                	mov    %edi,%edx
801029f1:	0f b6 fa             	movzbl %dl,%edi
801029f4:	89 f2                	mov    %esi,%edx
801029f6:	0f b6 f2             	movzbl %dl,%esi
801029f9:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029fc:	89 da                	mov    %ebx,%edx
801029fe:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102a01:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102a04:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102a08:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102a0b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102a0f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102a12:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102a16:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102a19:	31 c0                	xor    %eax,%eax
80102a1b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a1c:	89 ca                	mov    %ecx,%edx
80102a1e:	ec                   	in     (%dx),%al
80102a1f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a22:	89 da                	mov    %ebx,%edx
80102a24:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a27:	b8 02 00 00 00       	mov    $0x2,%eax
80102a2c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a2d:	89 ca                	mov    %ecx,%edx
80102a2f:	ec                   	in     (%dx),%al
80102a30:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a33:	89 da                	mov    %ebx,%edx
80102a35:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102a38:	b8 04 00 00 00       	mov    $0x4,%eax
80102a3d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a3e:	89 ca                	mov    %ecx,%edx
80102a40:	ec                   	in     (%dx),%al
80102a41:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a44:	89 da                	mov    %ebx,%edx
80102a46:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102a49:	b8 07 00 00 00       	mov    $0x7,%eax
80102a4e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a4f:	89 ca                	mov    %ecx,%edx
80102a51:	ec                   	in     (%dx),%al
80102a52:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a55:	89 da                	mov    %ebx,%edx
80102a57:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102a5a:	b8 08 00 00 00       	mov    $0x8,%eax
80102a5f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a60:	89 ca                	mov    %ecx,%edx
80102a62:	ec                   	in     (%dx),%al
80102a63:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a66:	89 da                	mov    %ebx,%edx
80102a68:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102a6b:	b8 09 00 00 00       	mov    $0x9,%eax
80102a70:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a71:	89 ca                	mov    %ecx,%edx
80102a73:	ec                   	in     (%dx),%al
80102a74:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a77:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102a7a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a7d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102a80:	6a 18                	push   $0x18
80102a82:	50                   	push   %eax
80102a83:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102a86:	50                   	push   %eax
80102a87:	e8 64 1b 00 00       	call   801045f0 <memcmp>
80102a8c:	83 c4 10             	add    $0x10,%esp
80102a8f:	85 c0                	test   %eax,%eax
80102a91:	0f 85 f1 fe ff ff    	jne    80102988 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102a97:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102a9b:	75 78                	jne    80102b15 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102a9d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102aa0:	89 c2                	mov    %eax,%edx
80102aa2:	83 e0 0f             	and    $0xf,%eax
80102aa5:	c1 ea 04             	shr    $0x4,%edx
80102aa8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102aab:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102aae:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102ab1:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ab4:	89 c2                	mov    %eax,%edx
80102ab6:	83 e0 0f             	and    $0xf,%eax
80102ab9:	c1 ea 04             	shr    $0x4,%edx
80102abc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102abf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ac2:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102ac5:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ac8:	89 c2                	mov    %eax,%edx
80102aca:	83 e0 0f             	and    $0xf,%eax
80102acd:	c1 ea 04             	shr    $0x4,%edx
80102ad0:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ad3:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ad6:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102ad9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102adc:	89 c2                	mov    %eax,%edx
80102ade:	83 e0 0f             	and    $0xf,%eax
80102ae1:	c1 ea 04             	shr    $0x4,%edx
80102ae4:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ae7:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102aea:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102aed:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102af0:	89 c2                	mov    %eax,%edx
80102af2:	83 e0 0f             	and    $0xf,%eax
80102af5:	c1 ea 04             	shr    $0x4,%edx
80102af8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102afb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102afe:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102b01:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b04:	89 c2                	mov    %eax,%edx
80102b06:	83 e0 0f             	and    $0xf,%eax
80102b09:	c1 ea 04             	shr    $0x4,%edx
80102b0c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b0f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b12:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102b15:	8b 75 08             	mov    0x8(%ebp),%esi
80102b18:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b1b:	89 06                	mov    %eax,(%esi)
80102b1d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b20:	89 46 04             	mov    %eax,0x4(%esi)
80102b23:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b26:	89 46 08             	mov    %eax,0x8(%esi)
80102b29:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b2c:	89 46 0c             	mov    %eax,0xc(%esi)
80102b2f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b32:	89 46 10             	mov    %eax,0x10(%esi)
80102b35:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b38:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102b3b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102b42:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b45:	5b                   	pop    %ebx
80102b46:	5e                   	pop    %esi
80102b47:	5f                   	pop    %edi
80102b48:	5d                   	pop    %ebp
80102b49:	c3                   	ret    
80102b4a:	66 90                	xchg   %ax,%ax
80102b4c:	66 90                	xchg   %ax,%ax
80102b4e:	66 90                	xchg   %ax,%ax

80102b50 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b50:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102b56:	85 c9                	test   %ecx,%ecx
80102b58:	0f 8e 8a 00 00 00    	jle    80102be8 <install_trans+0x98>
{
80102b5e:	55                   	push   %ebp
80102b5f:	89 e5                	mov    %esp,%ebp
80102b61:	57                   	push   %edi
80102b62:	56                   	push   %esi
80102b63:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102b64:	31 db                	xor    %ebx,%ebx
{
80102b66:	83 ec 0c             	sub    $0xc,%esp
80102b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102b70:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102b75:	83 ec 08             	sub    $0x8,%esp
80102b78:	01 d8                	add    %ebx,%eax
80102b7a:	83 c0 01             	add    $0x1,%eax
80102b7d:	50                   	push   %eax
80102b7e:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102b84:	e8 47 d5 ff ff       	call   801000d0 <bread>
80102b89:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b8b:	58                   	pop    %eax
80102b8c:	5a                   	pop    %edx
80102b8d:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102b94:	ff 35 e4 26 11 80    	pushl  0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102b9a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b9d:	e8 2e d5 ff ff       	call   801000d0 <bread>
80102ba2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102ba4:	8d 47 5c             	lea    0x5c(%edi),%eax
80102ba7:	83 c4 0c             	add    $0xc,%esp
80102baa:	68 00 02 00 00       	push   $0x200
80102baf:	50                   	push   %eax
80102bb0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102bb3:	50                   	push   %eax
80102bb4:	e8 97 1a 00 00       	call   80104650 <memmove>
    bwrite(dbuf);  // write dst to disk
80102bb9:	89 34 24             	mov    %esi,(%esp)
80102bbc:	e8 df d5 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102bc1:	89 3c 24             	mov    %edi,(%esp)
80102bc4:	e8 17 d6 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102bc9:	89 34 24             	mov    %esi,(%esp)
80102bcc:	e8 0f d6 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102bd1:	83 c4 10             	add    $0x10,%esp
80102bd4:	39 1d e8 26 11 80    	cmp    %ebx,0x801126e8
80102bda:	7f 94                	jg     80102b70 <install_trans+0x20>
  }
}
80102bdc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102bdf:	5b                   	pop    %ebx
80102be0:	5e                   	pop    %esi
80102be1:	5f                   	pop    %edi
80102be2:	5d                   	pop    %ebp
80102be3:	c3                   	ret    
80102be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102be8:	f3 c3                	repz ret 
80102bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102bf0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102bf0:	55                   	push   %ebp
80102bf1:	89 e5                	mov    %esp,%ebp
80102bf3:	56                   	push   %esi
80102bf4:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102bf5:	83 ec 08             	sub    $0x8,%esp
80102bf8:	ff 35 d4 26 11 80    	pushl  0x801126d4
80102bfe:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102c04:	e8 c7 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102c09:	8b 1d e8 26 11 80    	mov    0x801126e8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102c0f:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c12:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102c14:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102c16:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102c19:	7e 16                	jle    80102c31 <write_head+0x41>
80102c1b:	c1 e3 02             	shl    $0x2,%ebx
80102c1e:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102c20:	8b 8a ec 26 11 80    	mov    -0x7feed914(%edx),%ecx
80102c26:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102c2a:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102c2d:	39 da                	cmp    %ebx,%edx
80102c2f:	75 ef                	jne    80102c20 <write_head+0x30>
  }
  bwrite(buf);
80102c31:	83 ec 0c             	sub    $0xc,%esp
80102c34:	56                   	push   %esi
80102c35:	e8 66 d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102c3a:	89 34 24             	mov    %esi,(%esp)
80102c3d:	e8 9e d5 ff ff       	call   801001e0 <brelse>
}
80102c42:	83 c4 10             	add    $0x10,%esp
80102c45:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102c48:	5b                   	pop    %ebx
80102c49:	5e                   	pop    %esi
80102c4a:	5d                   	pop    %ebp
80102c4b:	c3                   	ret    
80102c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102c50 <initlog>:
{
80102c50:	55                   	push   %ebp
80102c51:	89 e5                	mov    %esp,%ebp
80102c53:	53                   	push   %ebx
80102c54:	83 ec 2c             	sub    $0x2c,%esp
80102c57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102c5a:	68 00 75 10 80       	push   $0x80107500
80102c5f:	68 a0 26 11 80       	push   $0x801126a0
80102c64:	e8 e7 16 00 00       	call   80104350 <initlock>
  readsb(dev, &sb);
80102c69:	58                   	pop    %eax
80102c6a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102c6d:	5a                   	pop    %edx
80102c6e:	50                   	push   %eax
80102c6f:	53                   	push   %ebx
80102c70:	e8 db e8 ff ff       	call   80101550 <readsb>
  log.size = sb.nlog;
80102c75:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102c78:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102c7b:	59                   	pop    %ecx
  log.dev = dev;
80102c7c:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
80102c82:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  log.start = sb.logstart;
80102c88:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  struct buf *buf = bread(log.dev, log.start);
80102c8d:	5a                   	pop    %edx
80102c8e:	50                   	push   %eax
80102c8f:	53                   	push   %ebx
80102c90:	e8 3b d4 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102c95:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102c98:	83 c4 10             	add    $0x10,%esp
80102c9b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102c9d:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102ca3:	7e 1c                	jle    80102cc1 <initlog+0x71>
80102ca5:	c1 e3 02             	shl    $0x2,%ebx
80102ca8:	31 d2                	xor    %edx,%edx
80102caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102cb0:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102cb4:	83 c2 04             	add    $0x4,%edx
80102cb7:	89 8a e8 26 11 80    	mov    %ecx,-0x7feed918(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102cbd:	39 d3                	cmp    %edx,%ebx
80102cbf:	75 ef                	jne    80102cb0 <initlog+0x60>
  brelse(buf);
80102cc1:	83 ec 0c             	sub    $0xc,%esp
80102cc4:	50                   	push   %eax
80102cc5:	e8 16 d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102cca:	e8 81 fe ff ff       	call   80102b50 <install_trans>
  log.lh.n = 0;
80102ccf:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102cd6:	00 00 00 
  write_head(); // clear the log
80102cd9:	e8 12 ff ff ff       	call   80102bf0 <write_head>
}
80102cde:	83 c4 10             	add    $0x10,%esp
80102ce1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ce4:	c9                   	leave  
80102ce5:	c3                   	ret    
80102ce6:	8d 76 00             	lea    0x0(%esi),%esi
80102ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102cf0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102cf0:	55                   	push   %ebp
80102cf1:	89 e5                	mov    %esp,%ebp
80102cf3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102cf6:	68 a0 26 11 80       	push   $0x801126a0
80102cfb:	e8 90 17 00 00       	call   80104490 <acquire>
80102d00:	83 c4 10             	add    $0x10,%esp
80102d03:	eb 18                	jmp    80102d1d <begin_op+0x2d>
80102d05:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d08:	83 ec 08             	sub    $0x8,%esp
80102d0b:	68 a0 26 11 80       	push   $0x801126a0
80102d10:	68 a0 26 11 80       	push   $0x801126a0
80102d15:	e8 b6 11 00 00       	call   80103ed0 <sleep>
80102d1a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102d1d:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102d22:	85 c0                	test   %eax,%eax
80102d24:	75 e2                	jne    80102d08 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d26:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102d2b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102d31:	83 c0 01             	add    $0x1,%eax
80102d34:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102d37:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102d3a:	83 fa 1e             	cmp    $0x1e,%edx
80102d3d:	7f c9                	jg     80102d08 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102d3f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102d42:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102d47:	68 a0 26 11 80       	push   $0x801126a0
80102d4c:	e8 ff 17 00 00       	call   80104550 <release>
      break;
    }
  }
}
80102d51:	83 c4 10             	add    $0x10,%esp
80102d54:	c9                   	leave  
80102d55:	c3                   	ret    
80102d56:	8d 76 00             	lea    0x0(%esi),%esi
80102d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d60 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102d60:	55                   	push   %ebp
80102d61:	89 e5                	mov    %esp,%ebp
80102d63:	57                   	push   %edi
80102d64:	56                   	push   %esi
80102d65:	53                   	push   %ebx
80102d66:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102d69:	68 a0 26 11 80       	push   $0x801126a0
80102d6e:	e8 1d 17 00 00       	call   80104490 <acquire>
  log.outstanding -= 1;
80102d73:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102d78:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
80102d7e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102d81:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102d84:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102d86:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
80102d8c:	0f 85 1a 01 00 00    	jne    80102eac <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102d92:	85 db                	test   %ebx,%ebx
80102d94:	0f 85 ee 00 00 00    	jne    80102e88 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d9a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102d9d:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102da4:	00 00 00 
  release(&log.lock);
80102da7:	68 a0 26 11 80       	push   $0x801126a0
80102dac:	e8 9f 17 00 00       	call   80104550 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102db1:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102db7:	83 c4 10             	add    $0x10,%esp
80102dba:	85 c9                	test   %ecx,%ecx
80102dbc:	0f 8e 85 00 00 00    	jle    80102e47 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102dc2:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102dc7:	83 ec 08             	sub    $0x8,%esp
80102dca:	01 d8                	add    %ebx,%eax
80102dcc:	83 c0 01             	add    $0x1,%eax
80102dcf:	50                   	push   %eax
80102dd0:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102dd6:	e8 f5 d2 ff ff       	call   801000d0 <bread>
80102ddb:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ddd:	58                   	pop    %eax
80102dde:	5a                   	pop    %edx
80102ddf:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102de6:	ff 35 e4 26 11 80    	pushl  0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102dec:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102def:	e8 dc d2 ff ff       	call   801000d0 <bread>
80102df4:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102df6:	8d 40 5c             	lea    0x5c(%eax),%eax
80102df9:	83 c4 0c             	add    $0xc,%esp
80102dfc:	68 00 02 00 00       	push   $0x200
80102e01:	50                   	push   %eax
80102e02:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e05:	50                   	push   %eax
80102e06:	e8 45 18 00 00       	call   80104650 <memmove>
    bwrite(to);  // write the log
80102e0b:	89 34 24             	mov    %esi,(%esp)
80102e0e:	e8 8d d3 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102e13:	89 3c 24             	mov    %edi,(%esp)
80102e16:	e8 c5 d3 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102e1b:	89 34 24             	mov    %esi,(%esp)
80102e1e:	e8 bd d3 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102e23:	83 c4 10             	add    $0x10,%esp
80102e26:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102e2c:	7c 94                	jl     80102dc2 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102e2e:	e8 bd fd ff ff       	call   80102bf0 <write_head>
    install_trans(); // Now install writes to home locations
80102e33:	e8 18 fd ff ff       	call   80102b50 <install_trans>
    log.lh.n = 0;
80102e38:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102e3f:	00 00 00 
    write_head();    // Erase the transaction from the log
80102e42:	e8 a9 fd ff ff       	call   80102bf0 <write_head>
    acquire(&log.lock);
80102e47:	83 ec 0c             	sub    $0xc,%esp
80102e4a:	68 a0 26 11 80       	push   $0x801126a0
80102e4f:	e8 3c 16 00 00       	call   80104490 <acquire>
    wakeup(&log);
80102e54:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
80102e5b:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102e62:	00 00 00 
    wakeup(&log);
80102e65:	e8 16 12 00 00       	call   80104080 <wakeup>
    release(&log.lock);
80102e6a:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e71:	e8 da 16 00 00       	call   80104550 <release>
80102e76:	83 c4 10             	add    $0x10,%esp
}
80102e79:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e7c:	5b                   	pop    %ebx
80102e7d:	5e                   	pop    %esi
80102e7e:	5f                   	pop    %edi
80102e7f:	5d                   	pop    %ebp
80102e80:	c3                   	ret    
80102e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102e88:	83 ec 0c             	sub    $0xc,%esp
80102e8b:	68 a0 26 11 80       	push   $0x801126a0
80102e90:	e8 eb 11 00 00       	call   80104080 <wakeup>
  release(&log.lock);
80102e95:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e9c:	e8 af 16 00 00       	call   80104550 <release>
80102ea1:	83 c4 10             	add    $0x10,%esp
}
80102ea4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ea7:	5b                   	pop    %ebx
80102ea8:	5e                   	pop    %esi
80102ea9:	5f                   	pop    %edi
80102eaa:	5d                   	pop    %ebp
80102eab:	c3                   	ret    
    panic("log.committing");
80102eac:	83 ec 0c             	sub    $0xc,%esp
80102eaf:	68 04 75 10 80       	push   $0x80107504
80102eb4:	e8 87 d5 ff ff       	call   80100440 <panic>
80102eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ec0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102ec0:	55                   	push   %ebp
80102ec1:	89 e5                	mov    %esp,%ebp
80102ec3:	53                   	push   %ebx
80102ec4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ec7:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
80102ecd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ed0:	83 fa 1d             	cmp    $0x1d,%edx
80102ed3:	0f 8f 9d 00 00 00    	jg     80102f76 <log_write+0xb6>
80102ed9:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102ede:	83 e8 01             	sub    $0x1,%eax
80102ee1:	39 c2                	cmp    %eax,%edx
80102ee3:	0f 8d 8d 00 00 00    	jge    80102f76 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102ee9:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102eee:	85 c0                	test   %eax,%eax
80102ef0:	0f 8e 8d 00 00 00    	jle    80102f83 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102ef6:	83 ec 0c             	sub    $0xc,%esp
80102ef9:	68 a0 26 11 80       	push   $0x801126a0
80102efe:	e8 8d 15 00 00       	call   80104490 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102f03:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102f09:	83 c4 10             	add    $0x10,%esp
80102f0c:	83 f9 00             	cmp    $0x0,%ecx
80102f0f:	7e 57                	jle    80102f68 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f11:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102f14:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f16:	3b 15 ec 26 11 80    	cmp    0x801126ec,%edx
80102f1c:	75 0b                	jne    80102f29 <log_write+0x69>
80102f1e:	eb 38                	jmp    80102f58 <log_write+0x98>
80102f20:	39 14 85 ec 26 11 80 	cmp    %edx,-0x7feed914(,%eax,4)
80102f27:	74 2f                	je     80102f58 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102f29:	83 c0 01             	add    $0x1,%eax
80102f2c:	39 c1                	cmp    %eax,%ecx
80102f2e:	75 f0                	jne    80102f20 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102f30:	89 14 85 ec 26 11 80 	mov    %edx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102f37:	83 c0 01             	add    $0x1,%eax
80102f3a:	a3 e8 26 11 80       	mov    %eax,0x801126e8
  b->flags |= B_DIRTY; // prevent eviction
80102f3f:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102f42:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102f49:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f4c:	c9                   	leave  
  release(&log.lock);
80102f4d:	e9 fe 15 00 00       	jmp    80104550 <release>
80102f52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102f58:	89 14 85 ec 26 11 80 	mov    %edx,-0x7feed914(,%eax,4)
80102f5f:	eb de                	jmp    80102f3f <log_write+0x7f>
80102f61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f68:	8b 43 08             	mov    0x8(%ebx),%eax
80102f6b:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
80102f70:	75 cd                	jne    80102f3f <log_write+0x7f>
80102f72:	31 c0                	xor    %eax,%eax
80102f74:	eb c1                	jmp    80102f37 <log_write+0x77>
    panic("too big a transaction");
80102f76:	83 ec 0c             	sub    $0xc,%esp
80102f79:	68 13 75 10 80       	push   $0x80107513
80102f7e:	e8 bd d4 ff ff       	call   80100440 <panic>
    panic("log_write outside of trans");
80102f83:	83 ec 0c             	sub    $0xc,%esp
80102f86:	68 29 75 10 80       	push   $0x80107529
80102f8b:	e8 b0 d4 ff ff       	call   80100440 <panic>

80102f90 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102f90:	55                   	push   %ebp
80102f91:	89 e5                	mov    %esp,%ebp
80102f93:	53                   	push   %ebx
80102f94:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102f97:	e8 74 09 00 00       	call   80103910 <cpuid>
80102f9c:	89 c3                	mov    %eax,%ebx
80102f9e:	e8 6d 09 00 00       	call   80103910 <cpuid>
80102fa3:	83 ec 04             	sub    $0x4,%esp
80102fa6:	53                   	push   %ebx
80102fa7:	50                   	push   %eax
80102fa8:	68 44 75 10 80       	push   $0x80107544
80102fad:	e8 5e d7 ff ff       	call   80100710 <cprintf>
  idtinit();       // load idt register
80102fb2:	e8 b9 28 00 00       	call   80105870 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102fb7:	e8 d4 08 00 00       	call   80103890 <mycpu>
80102fbc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102fbe:	b8 01 00 00 00       	mov    $0x1,%eax
80102fc3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102fca:	e8 21 0c 00 00       	call   80103bf0 <scheduler>
80102fcf:	90                   	nop

80102fd0 <mpenter>:
{
80102fd0:	55                   	push   %ebp
80102fd1:	89 e5                	mov    %esp,%ebp
80102fd3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102fd6:	e8 85 39 00 00       	call   80106960 <switchkvm>
  seginit();
80102fdb:	e8 f0 38 00 00       	call   801068d0 <seginit>
  lapicinit();
80102fe0:	e8 9b f7 ff ff       	call   80102780 <lapicinit>
  mpmain();
80102fe5:	e8 a6 ff ff ff       	call   80102f90 <mpmain>
80102fea:	66 90                	xchg   %ax,%ax
80102fec:	66 90                	xchg   %ax,%ax
80102fee:	66 90                	xchg   %ax,%ax

80102ff0 <main>:
{
80102ff0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102ff4:	83 e4 f0             	and    $0xfffffff0,%esp
80102ff7:	ff 71 fc             	pushl  -0x4(%ecx)
80102ffa:	55                   	push   %ebp
80102ffb:	89 e5                	mov    %esp,%ebp
80102ffd:	53                   	push   %ebx
80102ffe:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102fff:	83 ec 08             	sub    $0x8,%esp
80103002:	68 00 00 40 80       	push   $0x80400000
80103007:	68 c8 55 11 80       	push   $0x801155c8
8010300c:	e8 2f f5 ff ff       	call   80102540 <kinit1>
  kvmalloc();      // kernel page table
80103011:	e8 1a 3e 00 00       	call   80106e30 <kvmalloc>
  mpinit();        // detect other processors
80103016:	e8 75 01 00 00       	call   80103190 <mpinit>
  lapicinit();     // interrupt controller
8010301b:	e8 60 f7 ff ff       	call   80102780 <lapicinit>
  seginit();       // segment descriptors
80103020:	e8 ab 38 00 00       	call   801068d0 <seginit>
  picinit();       // disable pic
80103025:	e8 46 03 00 00       	call   80103370 <picinit>
  ioapicinit();    // another interrupt controller
8010302a:	e8 41 f3 ff ff       	call   80102370 <ioapicinit>
  consoleinit();   // console hardware
8010302f:	e8 3c da ff ff       	call   80100a70 <consoleinit>
  uartinit();      // serial port
80103034:	e8 67 2b 00 00       	call   80105ba0 <uartinit>
  pinit();         // process table
80103039:	e8 32 08 00 00       	call   80103870 <pinit>
  tvinit();        // trap vectors
8010303e:	e8 ad 27 00 00       	call   801057f0 <tvinit>
  binit();         // buffer cache
80103043:	e8 f8 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103048:	e8 c3 dd ff ff       	call   80100e10 <fileinit>
  ideinit();       // disk 
8010304d:	e8 fe f0 ff ff       	call   80102150 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_kernel_entryother_start, (uint)_binary_kernel_entryother_size);
80103052:	83 c4 0c             	add    $0xc,%esp
80103055:	68 8a 00 00 00       	push   $0x8a
8010305a:	68 8c a4 10 80       	push   $0x8010a48c
8010305f:	68 00 70 00 80       	push   $0x80007000
80103064:	e8 e7 15 00 00       	call   80104650 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103069:	69 05 20 2d 11 80 b0 	imul   $0xb0,0x80112d20,%eax
80103070:	00 00 00 
80103073:	83 c4 10             	add    $0x10,%esp
80103076:	05 a0 27 11 80       	add    $0x801127a0,%eax
8010307b:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
80103080:	76 71                	jbe    801030f3 <main+0x103>
80103082:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
80103087:	89 f6                	mov    %esi,%esi
80103089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103090:	e8 fb 07 00 00       	call   80103890 <mycpu>
80103095:	39 d8                	cmp    %ebx,%eax
80103097:	74 41                	je     801030da <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103099:	e8 72 f5 ff ff       	call   80102610 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
8010309e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
801030a3:	c7 05 f8 6f 00 80 d0 	movl   $0x80102fd0,0x80006ff8
801030aa:	2f 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801030ad:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
801030b4:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801030b7:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
801030bc:	0f b6 03             	movzbl (%ebx),%eax
801030bf:	83 ec 08             	sub    $0x8,%esp
801030c2:	68 00 70 00 00       	push   $0x7000
801030c7:	50                   	push   %eax
801030c8:	e8 03 f8 ff ff       	call   801028d0 <lapicstartap>
801030cd:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801030d0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801030d6:	85 c0                	test   %eax,%eax
801030d8:	74 f6                	je     801030d0 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
801030da:	69 05 20 2d 11 80 b0 	imul   $0xb0,0x80112d20,%eax
801030e1:	00 00 00 
801030e4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801030ea:	05 a0 27 11 80       	add    $0x801127a0,%eax
801030ef:	39 c3                	cmp    %eax,%ebx
801030f1:	72 9d                	jb     80103090 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801030f3:	83 ec 08             	sub    $0x8,%esp
801030f6:	68 00 00 00 8e       	push   $0x8e000000
801030fb:	68 00 00 40 80       	push   $0x80400000
80103100:	e8 ab f4 ff ff       	call   801025b0 <kinit2>
  userinit();      // first user process
80103105:	e8 56 08 00 00       	call   80103960 <userinit>
  mpmain();        // finish this processor's setup
8010310a:	e8 81 fe ff ff       	call   80102f90 <mpmain>
8010310f:	90                   	nop

80103110 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103110:	55                   	push   %ebp
80103111:	89 e5                	mov    %esp,%ebp
80103113:	57                   	push   %edi
80103114:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103115:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010311b:	53                   	push   %ebx
  e = addr+len;
8010311c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010311f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103122:	39 de                	cmp    %ebx,%esi
80103124:	72 10                	jb     80103136 <mpsearch1+0x26>
80103126:	eb 50                	jmp    80103178 <mpsearch1+0x68>
80103128:	90                   	nop
80103129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103130:	39 fb                	cmp    %edi,%ebx
80103132:	89 fe                	mov    %edi,%esi
80103134:	76 42                	jbe    80103178 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103136:	83 ec 04             	sub    $0x4,%esp
80103139:	8d 7e 10             	lea    0x10(%esi),%edi
8010313c:	6a 04                	push   $0x4
8010313e:	68 58 75 10 80       	push   $0x80107558
80103143:	56                   	push   %esi
80103144:	e8 a7 14 00 00       	call   801045f0 <memcmp>
80103149:	83 c4 10             	add    $0x10,%esp
8010314c:	85 c0                	test   %eax,%eax
8010314e:	75 e0                	jne    80103130 <mpsearch1+0x20>
80103150:	89 f1                	mov    %esi,%ecx
80103152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103158:	0f b6 11             	movzbl (%ecx),%edx
8010315b:	83 c1 01             	add    $0x1,%ecx
8010315e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103160:	39 f9                	cmp    %edi,%ecx
80103162:	75 f4                	jne    80103158 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103164:	84 c0                	test   %al,%al
80103166:	75 c8                	jne    80103130 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103168:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010316b:	89 f0                	mov    %esi,%eax
8010316d:	5b                   	pop    %ebx
8010316e:	5e                   	pop    %esi
8010316f:	5f                   	pop    %edi
80103170:	5d                   	pop    %ebp
80103171:	c3                   	ret    
80103172:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103178:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010317b:	31 f6                	xor    %esi,%esi
}
8010317d:	89 f0                	mov    %esi,%eax
8010317f:	5b                   	pop    %ebx
80103180:	5e                   	pop    %esi
80103181:	5f                   	pop    %edi
80103182:	5d                   	pop    %ebp
80103183:	c3                   	ret    
80103184:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010318a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103190 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103190:	55                   	push   %ebp
80103191:	89 e5                	mov    %esp,%ebp
80103193:	57                   	push   %edi
80103194:	56                   	push   %esi
80103195:	53                   	push   %ebx
80103196:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103199:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801031a0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801031a7:	c1 e0 08             	shl    $0x8,%eax
801031aa:	09 d0                	or     %edx,%eax
801031ac:	c1 e0 04             	shl    $0x4,%eax
801031af:	85 c0                	test   %eax,%eax
801031b1:	75 1b                	jne    801031ce <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801031b3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801031ba:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801031c1:	c1 e0 08             	shl    $0x8,%eax
801031c4:	09 d0                	or     %edx,%eax
801031c6:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801031c9:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801031ce:	ba 00 04 00 00       	mov    $0x400,%edx
801031d3:	e8 38 ff ff ff       	call   80103110 <mpsearch1>
801031d8:	85 c0                	test   %eax,%eax
801031da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801031dd:	0f 84 3d 01 00 00    	je     80103320 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801031e6:	8b 58 04             	mov    0x4(%eax),%ebx
801031e9:	85 db                	test   %ebx,%ebx
801031eb:	0f 84 4f 01 00 00    	je     80103340 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801031f1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801031f7:	83 ec 04             	sub    $0x4,%esp
801031fa:	6a 04                	push   $0x4
801031fc:	68 75 75 10 80       	push   $0x80107575
80103201:	56                   	push   %esi
80103202:	e8 e9 13 00 00       	call   801045f0 <memcmp>
80103207:	83 c4 10             	add    $0x10,%esp
8010320a:	85 c0                	test   %eax,%eax
8010320c:	0f 85 2e 01 00 00    	jne    80103340 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
80103212:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103219:	3c 01                	cmp    $0x1,%al
8010321b:	0f 95 c2             	setne  %dl
8010321e:	3c 04                	cmp    $0x4,%al
80103220:	0f 95 c0             	setne  %al
80103223:	20 c2                	and    %al,%dl
80103225:	0f 85 15 01 00 00    	jne    80103340 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
8010322b:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
80103232:	66 85 ff             	test   %di,%di
80103235:	74 1a                	je     80103251 <mpinit+0xc1>
80103237:	89 f0                	mov    %esi,%eax
80103239:	01 f7                	add    %esi,%edi
  sum = 0;
8010323b:	31 d2                	xor    %edx,%edx
8010323d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103240:	0f b6 08             	movzbl (%eax),%ecx
80103243:	83 c0 01             	add    $0x1,%eax
80103246:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103248:	39 c7                	cmp    %eax,%edi
8010324a:	75 f4                	jne    80103240 <mpinit+0xb0>
8010324c:	84 d2                	test   %dl,%dl
8010324e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103251:	85 f6                	test   %esi,%esi
80103253:	0f 84 e7 00 00 00    	je     80103340 <mpinit+0x1b0>
80103259:	84 d2                	test   %dl,%dl
8010325b:	0f 85 df 00 00 00    	jne    80103340 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103261:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103267:	a3 9c 26 11 80       	mov    %eax,0x8011269c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010326c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103273:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103279:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010327e:	01 d6                	add    %edx,%esi
80103280:	39 c6                	cmp    %eax,%esi
80103282:	76 23                	jbe    801032a7 <mpinit+0x117>
    switch(*p){
80103284:	0f b6 10             	movzbl (%eax),%edx
80103287:	80 fa 04             	cmp    $0x4,%dl
8010328a:	0f 87 ca 00 00 00    	ja     8010335a <mpinit+0x1ca>
80103290:	ff 24 95 9c 75 10 80 	jmp    *-0x7fef8a64(,%edx,4)
80103297:	89 f6                	mov    %esi,%esi
80103299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801032a0:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032a3:	39 c6                	cmp    %eax,%esi
801032a5:	77 dd                	ja     80103284 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801032a7:	85 db                	test   %ebx,%ebx
801032a9:	0f 84 9e 00 00 00    	je     8010334d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801032af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801032b2:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
801032b6:	74 15                	je     801032cd <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032b8:	b8 70 00 00 00       	mov    $0x70,%eax
801032bd:	ba 22 00 00 00       	mov    $0x22,%edx
801032c2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032c3:	ba 23 00 00 00       	mov    $0x23,%edx
801032c8:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801032c9:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032cc:	ee                   	out    %al,(%dx)
  }
}
801032cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032d0:	5b                   	pop    %ebx
801032d1:	5e                   	pop    %esi
801032d2:	5f                   	pop    %edi
801032d3:	5d                   	pop    %ebp
801032d4:	c3                   	ret    
801032d5:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
801032d8:	8b 0d 20 2d 11 80    	mov    0x80112d20,%ecx
801032de:	83 f9 07             	cmp    $0x7,%ecx
801032e1:	7f 19                	jg     801032fc <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801032e3:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801032e7:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
801032ed:	83 c1 01             	add    $0x1,%ecx
801032f0:	89 0d 20 2d 11 80    	mov    %ecx,0x80112d20
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801032f6:	88 97 a0 27 11 80    	mov    %dl,-0x7feed860(%edi)
      p += sizeof(struct mpproc);
801032fc:	83 c0 14             	add    $0x14,%eax
      continue;
801032ff:	e9 7c ff ff ff       	jmp    80103280 <mpinit+0xf0>
80103304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103308:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010330c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010330f:	88 15 80 27 11 80    	mov    %dl,0x80112780
      continue;
80103315:	e9 66 ff ff ff       	jmp    80103280 <mpinit+0xf0>
8010331a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
80103320:	ba 00 00 01 00       	mov    $0x10000,%edx
80103325:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010332a:	e8 e1 fd ff ff       	call   80103110 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010332f:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103331:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103334:	0f 85 a9 fe ff ff    	jne    801031e3 <mpinit+0x53>
8010333a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103340:	83 ec 0c             	sub    $0xc,%esp
80103343:	68 5d 75 10 80       	push   $0x8010755d
80103348:	e8 f3 d0 ff ff       	call   80100440 <panic>
    panic("Didn't find a suitable machine");
8010334d:	83 ec 0c             	sub    $0xc,%esp
80103350:	68 7c 75 10 80       	push   $0x8010757c
80103355:	e8 e6 d0 ff ff       	call   80100440 <panic>
      ismp = 0;
8010335a:	31 db                	xor    %ebx,%ebx
8010335c:	e9 26 ff ff ff       	jmp    80103287 <mpinit+0xf7>
80103361:	66 90                	xchg   %ax,%ax
80103363:	66 90                	xchg   %ax,%ax
80103365:	66 90                	xchg   %ax,%ax
80103367:	66 90                	xchg   %ax,%ax
80103369:	66 90                	xchg   %ax,%ax
8010336b:	66 90                	xchg   %ax,%ax
8010336d:	66 90                	xchg   %ax,%ax
8010336f:	90                   	nop

80103370 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103370:	55                   	push   %ebp
80103371:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103376:	ba 21 00 00 00       	mov    $0x21,%edx
8010337b:	89 e5                	mov    %esp,%ebp
8010337d:	ee                   	out    %al,(%dx)
8010337e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103383:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103384:	5d                   	pop    %ebp
80103385:	c3                   	ret    
80103386:	66 90                	xchg   %ax,%ax
80103388:	66 90                	xchg   %ax,%ax
8010338a:	66 90                	xchg   %ax,%ax
8010338c:	66 90                	xchg   %ax,%ax
8010338e:	66 90                	xchg   %ax,%ax

80103390 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103390:	55                   	push   %ebp
80103391:	89 e5                	mov    %esp,%ebp
80103393:	57                   	push   %edi
80103394:	56                   	push   %esi
80103395:	53                   	push   %ebx
80103396:	83 ec 0c             	sub    $0xc,%esp
80103399:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010339c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010339f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801033a5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801033ab:	e8 80 da ff ff       	call   80100e30 <filealloc>
801033b0:	85 c0                	test   %eax,%eax
801033b2:	89 03                	mov    %eax,(%ebx)
801033b4:	74 22                	je     801033d8 <pipealloc+0x48>
801033b6:	e8 75 da ff ff       	call   80100e30 <filealloc>
801033bb:	85 c0                	test   %eax,%eax
801033bd:	89 06                	mov    %eax,(%esi)
801033bf:	74 3f                	je     80103400 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801033c1:	e8 4a f2 ff ff       	call   80102610 <kalloc>
801033c6:	85 c0                	test   %eax,%eax
801033c8:	89 c7                	mov    %eax,%edi
801033ca:	75 54                	jne    80103420 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801033cc:	8b 03                	mov    (%ebx),%eax
801033ce:	85 c0                	test   %eax,%eax
801033d0:	75 34                	jne    80103406 <pipealloc+0x76>
801033d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
801033d8:	8b 06                	mov    (%esi),%eax
801033da:	85 c0                	test   %eax,%eax
801033dc:	74 0c                	je     801033ea <pipealloc+0x5a>
    fileclose(*f1);
801033de:	83 ec 0c             	sub    $0xc,%esp
801033e1:	50                   	push   %eax
801033e2:	e8 09 db ff ff       	call   80100ef0 <fileclose>
801033e7:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801033ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801033ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801033f2:	5b                   	pop    %ebx
801033f3:	5e                   	pop    %esi
801033f4:	5f                   	pop    %edi
801033f5:	5d                   	pop    %ebp
801033f6:	c3                   	ret    
801033f7:	89 f6                	mov    %esi,%esi
801033f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
80103400:	8b 03                	mov    (%ebx),%eax
80103402:	85 c0                	test   %eax,%eax
80103404:	74 e4                	je     801033ea <pipealloc+0x5a>
    fileclose(*f0);
80103406:	83 ec 0c             	sub    $0xc,%esp
80103409:	50                   	push   %eax
8010340a:	e8 e1 da ff ff       	call   80100ef0 <fileclose>
  if(*f1)
8010340f:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
80103411:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103414:	85 c0                	test   %eax,%eax
80103416:	75 c6                	jne    801033de <pipealloc+0x4e>
80103418:	eb d0                	jmp    801033ea <pipealloc+0x5a>
8010341a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
80103420:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
80103423:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010342a:	00 00 00 
  p->writeopen = 1;
8010342d:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103434:	00 00 00 
  p->nwrite = 0;
80103437:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010343e:	00 00 00 
  p->nread = 0;
80103441:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103448:	00 00 00 
  initlock(&p->lock, "pipe");
8010344b:	68 b0 75 10 80       	push   $0x801075b0
80103450:	50                   	push   %eax
80103451:	e8 fa 0e 00 00       	call   80104350 <initlock>
  (*f0)->type = FD_PIPE;
80103456:	8b 03                	mov    (%ebx),%eax
  return 0;
80103458:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010345b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103461:	8b 03                	mov    (%ebx),%eax
80103463:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103467:	8b 03                	mov    (%ebx),%eax
80103469:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010346d:	8b 03                	mov    (%ebx),%eax
8010346f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103472:	8b 06                	mov    (%esi),%eax
80103474:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010347a:	8b 06                	mov    (%esi),%eax
8010347c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103480:	8b 06                	mov    (%esi),%eax
80103482:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103486:	8b 06                	mov    (%esi),%eax
80103488:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010348b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010348e:	31 c0                	xor    %eax,%eax
}
80103490:	5b                   	pop    %ebx
80103491:	5e                   	pop    %esi
80103492:	5f                   	pop    %edi
80103493:	5d                   	pop    %ebp
80103494:	c3                   	ret    
80103495:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801034a0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801034a0:	55                   	push   %ebp
801034a1:	89 e5                	mov    %esp,%ebp
801034a3:	56                   	push   %esi
801034a4:	53                   	push   %ebx
801034a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034a8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801034ab:	83 ec 0c             	sub    $0xc,%esp
801034ae:	53                   	push   %ebx
801034af:	e8 dc 0f 00 00       	call   80104490 <acquire>
  if(writable){
801034b4:	83 c4 10             	add    $0x10,%esp
801034b7:	85 f6                	test   %esi,%esi
801034b9:	74 45                	je     80103500 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801034bb:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034c1:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
801034c4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801034cb:	00 00 00 
    wakeup(&p->nread);
801034ce:	50                   	push   %eax
801034cf:	e8 ac 0b 00 00       	call   80104080 <wakeup>
801034d4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801034d7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801034dd:	85 d2                	test   %edx,%edx
801034df:	75 0a                	jne    801034eb <pipeclose+0x4b>
801034e1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801034e7:	85 c0                	test   %eax,%eax
801034e9:	74 35                	je     80103520 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801034eb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801034ee:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034f1:	5b                   	pop    %ebx
801034f2:	5e                   	pop    %esi
801034f3:	5d                   	pop    %ebp
    release(&p->lock);
801034f4:	e9 57 10 00 00       	jmp    80104550 <release>
801034f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103500:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103506:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103509:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103510:	00 00 00 
    wakeup(&p->nwrite);
80103513:	50                   	push   %eax
80103514:	e8 67 0b 00 00       	call   80104080 <wakeup>
80103519:	83 c4 10             	add    $0x10,%esp
8010351c:	eb b9                	jmp    801034d7 <pipeclose+0x37>
8010351e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103520:	83 ec 0c             	sub    $0xc,%esp
80103523:	53                   	push   %ebx
80103524:	e8 27 10 00 00       	call   80104550 <release>
    kfree((char*)p);
80103529:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010352c:	83 c4 10             	add    $0x10,%esp
}
8010352f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103532:	5b                   	pop    %ebx
80103533:	5e                   	pop    %esi
80103534:	5d                   	pop    %ebp
    kfree((char*)p);
80103535:	e9 26 ef ff ff       	jmp    80102460 <kfree>
8010353a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103540 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103540:	55                   	push   %ebp
80103541:	89 e5                	mov    %esp,%ebp
80103543:	57                   	push   %edi
80103544:	56                   	push   %esi
80103545:	53                   	push   %ebx
80103546:	83 ec 28             	sub    $0x28,%esp
80103549:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010354c:	53                   	push   %ebx
8010354d:	e8 3e 0f 00 00       	call   80104490 <acquire>
  for(i = 0; i < n; i++){
80103552:	8b 45 10             	mov    0x10(%ebp),%eax
80103555:	83 c4 10             	add    $0x10,%esp
80103558:	85 c0                	test   %eax,%eax
8010355a:	0f 8e c9 00 00 00    	jle    80103629 <pipewrite+0xe9>
80103560:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103563:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103569:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010356f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103572:	03 4d 10             	add    0x10(%ebp),%ecx
80103575:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103578:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010357e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103584:	39 d0                	cmp    %edx,%eax
80103586:	75 71                	jne    801035f9 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103588:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010358e:	85 c0                	test   %eax,%eax
80103590:	74 4e                	je     801035e0 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103592:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103598:	eb 3a                	jmp    801035d4 <pipewrite+0x94>
8010359a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
801035a0:	83 ec 0c             	sub    $0xc,%esp
801035a3:	57                   	push   %edi
801035a4:	e8 d7 0a 00 00       	call   80104080 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035a9:	5a                   	pop    %edx
801035aa:	59                   	pop    %ecx
801035ab:	53                   	push   %ebx
801035ac:	56                   	push   %esi
801035ad:	e8 1e 09 00 00       	call   80103ed0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035b2:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801035b8:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801035be:	83 c4 10             	add    $0x10,%esp
801035c1:	05 00 02 00 00       	add    $0x200,%eax
801035c6:	39 c2                	cmp    %eax,%edx
801035c8:	75 36                	jne    80103600 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
801035ca:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801035d0:	85 c0                	test   %eax,%eax
801035d2:	74 0c                	je     801035e0 <pipewrite+0xa0>
801035d4:	e8 57 03 00 00       	call   80103930 <myproc>
801035d9:	8b 40 24             	mov    0x24(%eax),%eax
801035dc:	85 c0                	test   %eax,%eax
801035de:	74 c0                	je     801035a0 <pipewrite+0x60>
        release(&p->lock);
801035e0:	83 ec 0c             	sub    $0xc,%esp
801035e3:	53                   	push   %ebx
801035e4:	e8 67 0f 00 00       	call   80104550 <release>
        return -1;
801035e9:	83 c4 10             	add    $0x10,%esp
801035ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801035f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035f4:	5b                   	pop    %ebx
801035f5:	5e                   	pop    %esi
801035f6:	5f                   	pop    %edi
801035f7:	5d                   	pop    %ebp
801035f8:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035f9:	89 c2                	mov    %eax,%edx
801035fb:	90                   	nop
801035fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103600:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103603:	8d 42 01             	lea    0x1(%edx),%eax
80103606:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010360c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103612:	83 c6 01             	add    $0x1,%esi
80103615:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
80103619:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010361c:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010361f:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103623:	0f 85 4f ff ff ff    	jne    80103578 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103629:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010362f:	83 ec 0c             	sub    $0xc,%esp
80103632:	50                   	push   %eax
80103633:	e8 48 0a 00 00       	call   80104080 <wakeup>
  release(&p->lock);
80103638:	89 1c 24             	mov    %ebx,(%esp)
8010363b:	e8 10 0f 00 00       	call   80104550 <release>
  return n;
80103640:	83 c4 10             	add    $0x10,%esp
80103643:	8b 45 10             	mov    0x10(%ebp),%eax
80103646:	eb a9                	jmp    801035f1 <pipewrite+0xb1>
80103648:	90                   	nop
80103649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103650 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103650:	55                   	push   %ebp
80103651:	89 e5                	mov    %esp,%ebp
80103653:	57                   	push   %edi
80103654:	56                   	push   %esi
80103655:	53                   	push   %ebx
80103656:	83 ec 18             	sub    $0x18,%esp
80103659:	8b 75 08             	mov    0x8(%ebp),%esi
8010365c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010365f:	56                   	push   %esi
80103660:	e8 2b 0e 00 00       	call   80104490 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103665:	83 c4 10             	add    $0x10,%esp
80103668:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010366e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103674:	75 6a                	jne    801036e0 <piperead+0x90>
80103676:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010367c:	85 db                	test   %ebx,%ebx
8010367e:	0f 84 c4 00 00 00    	je     80103748 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103684:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010368a:	eb 2d                	jmp    801036b9 <piperead+0x69>
8010368c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103690:	83 ec 08             	sub    $0x8,%esp
80103693:	56                   	push   %esi
80103694:	53                   	push   %ebx
80103695:	e8 36 08 00 00       	call   80103ed0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010369a:	83 c4 10             	add    $0x10,%esp
8010369d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801036a3:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801036a9:	75 35                	jne    801036e0 <piperead+0x90>
801036ab:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801036b1:	85 d2                	test   %edx,%edx
801036b3:	0f 84 8f 00 00 00    	je     80103748 <piperead+0xf8>
    if(myproc()->killed){
801036b9:	e8 72 02 00 00       	call   80103930 <myproc>
801036be:	8b 48 24             	mov    0x24(%eax),%ecx
801036c1:	85 c9                	test   %ecx,%ecx
801036c3:	74 cb                	je     80103690 <piperead+0x40>
      release(&p->lock);
801036c5:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801036c8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801036cd:	56                   	push   %esi
801036ce:	e8 7d 0e 00 00       	call   80104550 <release>
      return -1;
801036d3:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801036d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036d9:	89 d8                	mov    %ebx,%eax
801036db:	5b                   	pop    %ebx
801036dc:	5e                   	pop    %esi
801036dd:	5f                   	pop    %edi
801036de:	5d                   	pop    %ebp
801036df:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801036e0:	8b 45 10             	mov    0x10(%ebp),%eax
801036e3:	85 c0                	test   %eax,%eax
801036e5:	7e 61                	jle    80103748 <piperead+0xf8>
    if(p->nread == p->nwrite)
801036e7:	31 db                	xor    %ebx,%ebx
801036e9:	eb 13                	jmp    801036fe <piperead+0xae>
801036eb:	90                   	nop
801036ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036f0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801036f6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801036fc:	74 1f                	je     8010371d <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801036fe:	8d 41 01             	lea    0x1(%ecx),%eax
80103701:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103707:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010370d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103712:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103715:	83 c3 01             	add    $0x1,%ebx
80103718:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010371b:	75 d3                	jne    801036f0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010371d:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103723:	83 ec 0c             	sub    $0xc,%esp
80103726:	50                   	push   %eax
80103727:	e8 54 09 00 00       	call   80104080 <wakeup>
  release(&p->lock);
8010372c:	89 34 24             	mov    %esi,(%esp)
8010372f:	e8 1c 0e 00 00       	call   80104550 <release>
  return i;
80103734:	83 c4 10             	add    $0x10,%esp
}
80103737:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010373a:	89 d8                	mov    %ebx,%eax
8010373c:	5b                   	pop    %ebx
8010373d:	5e                   	pop    %esi
8010373e:	5f                   	pop    %edi
8010373f:	5d                   	pop    %ebp
80103740:	c3                   	ret    
80103741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103748:	31 db                	xor    %ebx,%ebx
8010374a:	eb d1                	jmp    8010371d <piperead+0xcd>
8010374c:	66 90                	xchg   %ax,%ax
8010374e:	66 90                	xchg   %ax,%ax

80103750 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103750:	55                   	push   %ebp
80103751:	89 e5                	mov    %esp,%ebp
80103753:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103754:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
{
80103759:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010375c:	68 40 2d 11 80       	push   $0x80112d40
80103761:	e8 2a 0d 00 00       	call   80104490 <acquire>
80103766:	83 c4 10             	add    $0x10,%esp
80103769:	eb 10                	jmp    8010377b <allocproc+0x2b>
8010376b:	90                   	nop
8010376c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103770:	83 eb 80             	sub    $0xffffff80,%ebx
80103773:	81 fb 74 4d 11 80    	cmp    $0x80114d74,%ebx
80103779:	73 75                	jae    801037f0 <allocproc+0xa0>
    if(p->state == UNUSED)
8010377b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010377e:	85 c0                	test   %eax,%eax
80103780:	75 ee                	jne    80103770 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103782:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
80103787:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010378a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103791:	8d 50 01             	lea    0x1(%eax),%edx
80103794:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103797:	68 40 2d 11 80       	push   $0x80112d40
  p->pid = nextpid++;
8010379c:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
801037a2:	e8 a9 0d 00 00       	call   80104550 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801037a7:	e8 64 ee ff ff       	call   80102610 <kalloc>
801037ac:	83 c4 10             	add    $0x10,%esp
801037af:	85 c0                	test   %eax,%eax
801037b1:	89 43 08             	mov    %eax,0x8(%ebx)
801037b4:	74 53                	je     80103809 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037b6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801037bc:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
801037bf:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
801037c4:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801037c7:	c7 40 14 db 57 10 80 	movl   $0x801057db,0x14(%eax)
  p->context = (struct context*)sp;
801037ce:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801037d1:	6a 14                	push   $0x14
801037d3:	6a 00                	push   $0x0
801037d5:	50                   	push   %eax
801037d6:	e8 c5 0d 00 00       	call   801045a0 <memset>
  p->context->eip = (uint)forkret;
801037db:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801037de:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801037e1:	c7 40 10 20 38 10 80 	movl   $0x80103820,0x10(%eax)
}
801037e8:	89 d8                	mov    %ebx,%eax
801037ea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037ed:	c9                   	leave  
801037ee:	c3                   	ret    
801037ef:	90                   	nop
  release(&ptable.lock);
801037f0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801037f3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801037f5:	68 40 2d 11 80       	push   $0x80112d40
801037fa:	e8 51 0d 00 00       	call   80104550 <release>
}
801037ff:	89 d8                	mov    %ebx,%eax
  return 0;
80103801:	83 c4 10             	add    $0x10,%esp
}
80103804:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103807:	c9                   	leave  
80103808:	c3                   	ret    
    p->state = UNUSED;
80103809:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103810:	31 db                	xor    %ebx,%ebx
80103812:	eb d4                	jmp    801037e8 <allocproc+0x98>
80103814:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010381a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103820 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103820:	55                   	push   %ebp
80103821:	89 e5                	mov    %esp,%ebp
80103823:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103826:	68 40 2d 11 80       	push   $0x80112d40
8010382b:	e8 20 0d 00 00       	call   80104550 <release>

  if (first) {
80103830:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103835:	83 c4 10             	add    $0x10,%esp
80103838:	85 c0                	test   %eax,%eax
8010383a:	75 04                	jne    80103840 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010383c:	c9                   	leave  
8010383d:	c3                   	ret    
8010383e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103840:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103843:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010384a:	00 00 00 
    iinit(ROOTDEV);
8010384d:	6a 01                	push   $0x1
8010384f:	e8 3c dd ff ff       	call   80101590 <iinit>
    initlog(ROOTDEV);
80103854:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010385b:	e8 f0 f3 ff ff       	call   80102c50 <initlog>
80103860:	83 c4 10             	add    $0x10,%esp
}
80103863:	c9                   	leave  
80103864:	c3                   	ret    
80103865:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103870 <pinit>:
{
80103870:	55                   	push   %ebp
80103871:	89 e5                	mov    %esp,%ebp
80103873:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103876:	68 b5 75 10 80       	push   $0x801075b5
8010387b:	68 40 2d 11 80       	push   $0x80112d40
80103880:	e8 cb 0a 00 00       	call   80104350 <initlock>
}
80103885:	83 c4 10             	add    $0x10,%esp
80103888:	c9                   	leave  
80103889:	c3                   	ret    
8010388a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103890 <mycpu>:
{
80103890:	55                   	push   %ebp
80103891:	89 e5                	mov    %esp,%ebp
80103893:	56                   	push   %esi
80103894:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103895:	9c                   	pushf  
80103896:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103897:	f6 c4 02             	test   $0x2,%ah
8010389a:	75 5e                	jne    801038fa <mycpu+0x6a>
  apicid = lapicid();
8010389c:	e8 df ef ff ff       	call   80102880 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801038a1:	8b 35 20 2d 11 80    	mov    0x80112d20,%esi
801038a7:	85 f6                	test   %esi,%esi
801038a9:	7e 42                	jle    801038ed <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801038ab:	0f b6 15 a0 27 11 80 	movzbl 0x801127a0,%edx
801038b2:	39 d0                	cmp    %edx,%eax
801038b4:	74 30                	je     801038e6 <mycpu+0x56>
801038b6:	b9 50 28 11 80       	mov    $0x80112850,%ecx
  for (i = 0; i < ncpu; ++i) {
801038bb:	31 d2                	xor    %edx,%edx
801038bd:	8d 76 00             	lea    0x0(%esi),%esi
801038c0:	83 c2 01             	add    $0x1,%edx
801038c3:	39 f2                	cmp    %esi,%edx
801038c5:	74 26                	je     801038ed <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801038c7:	0f b6 19             	movzbl (%ecx),%ebx
801038ca:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801038d0:	39 c3                	cmp    %eax,%ebx
801038d2:	75 ec                	jne    801038c0 <mycpu+0x30>
801038d4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
801038da:	05 a0 27 11 80       	add    $0x801127a0,%eax
}
801038df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801038e2:	5b                   	pop    %ebx
801038e3:	5e                   	pop    %esi
801038e4:	5d                   	pop    %ebp
801038e5:	c3                   	ret    
    if (cpus[i].apicid == apicid)
801038e6:	b8 a0 27 11 80       	mov    $0x801127a0,%eax
      return &cpus[i];
801038eb:	eb f2                	jmp    801038df <mycpu+0x4f>
  panic("unknown apicid\n");
801038ed:	83 ec 0c             	sub    $0xc,%esp
801038f0:	68 bc 75 10 80       	push   $0x801075bc
801038f5:	e8 46 cb ff ff       	call   80100440 <panic>
    panic("mycpu called with interrupts enabled\n");
801038fa:	83 ec 0c             	sub    $0xc,%esp
801038fd:	68 98 76 10 80       	push   $0x80107698
80103902:	e8 39 cb ff ff       	call   80100440 <panic>
80103907:	89 f6                	mov    %esi,%esi
80103909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103910 <cpuid>:
cpuid() {
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103916:	e8 75 ff ff ff       	call   80103890 <mycpu>
8010391b:	2d a0 27 11 80       	sub    $0x801127a0,%eax
}
80103920:	c9                   	leave  
  return mycpu()-cpus;
80103921:	c1 f8 04             	sar    $0x4,%eax
80103924:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010392a:	c3                   	ret    
8010392b:	90                   	nop
8010392c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103930 <myproc>:
myproc(void) {
80103930:	55                   	push   %ebp
80103931:	89 e5                	mov    %esp,%ebp
80103933:	53                   	push   %ebx
80103934:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103937:	e8 84 0a 00 00       	call   801043c0 <pushcli>
  c = mycpu();
8010393c:	e8 4f ff ff ff       	call   80103890 <mycpu>
  p = c->proc;
80103941:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103947:	e8 b4 0a 00 00       	call   80104400 <popcli>
}
8010394c:	83 c4 04             	add    $0x4,%esp
8010394f:	89 d8                	mov    %ebx,%eax
80103951:	5b                   	pop    %ebx
80103952:	5d                   	pop    %ebp
80103953:	c3                   	ret    
80103954:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010395a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103960 <userinit>:
{
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	53                   	push   %ebx
80103964:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103967:	e8 e4 fd ff ff       	call   80103750 <allocproc>
8010396c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010396e:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
80103973:	e8 38 34 00 00       	call   80106db0 <setupkvm>
80103978:	85 c0                	test   %eax,%eax
8010397a:	89 43 04             	mov    %eax,0x4(%ebx)
8010397d:	0f 84 bd 00 00 00    	je     80103a40 <userinit+0xe0>
  inituvm(p->pgdir, _binary_user_initcode_start, (int)_binary_user_initcode_size);
80103983:	83 ec 04             	sub    $0x4,%esp
80103986:	68 2c 00 00 00       	push   $0x2c
8010398b:	68 60 a4 10 80       	push   $0x8010a460
80103990:	50                   	push   %eax
80103991:	e8 fa 30 00 00       	call   80106a90 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103996:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103999:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010399f:	6a 4c                	push   $0x4c
801039a1:	6a 00                	push   $0x0
801039a3:	ff 73 18             	pushl  0x18(%ebx)
801039a6:	e8 f5 0b 00 00       	call   801045a0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039ab:	8b 43 18             	mov    0x18(%ebx),%eax
801039ae:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039b3:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801039b8:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039bb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039bf:	8b 43 18             	mov    0x18(%ebx),%eax
801039c2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801039c6:	8b 43 18             	mov    0x18(%ebx),%eax
801039c9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039cd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801039d1:	8b 43 18             	mov    0x18(%ebx),%eax
801039d4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039d8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801039dc:	8b 43 18             	mov    0x18(%ebx),%eax
801039df:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801039e6:	8b 43 18             	mov    0x18(%ebx),%eax
801039e9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801039f0:	8b 43 18             	mov    0x18(%ebx),%eax
801039f3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801039fa:	8d 43 70             	lea    0x70(%ebx),%eax
801039fd:	6a 10                	push   $0x10
801039ff:	68 e5 75 10 80       	push   $0x801075e5
80103a04:	50                   	push   %eax
80103a05:	e8 76 0d 00 00       	call   80104780 <safestrcpy>
  p->cwd = namei("/");
80103a0a:	c7 04 24 ee 75 10 80 	movl   $0x801075ee,(%esp)
80103a11:	e8 1a e6 ff ff       	call   80102030 <namei>
80103a16:	89 43 6c             	mov    %eax,0x6c(%ebx)
  acquire(&ptable.lock);
80103a19:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103a20:	e8 6b 0a 00 00       	call   80104490 <acquire>
  p->state = RUNNABLE;
80103a25:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103a2c:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103a33:	e8 18 0b 00 00       	call   80104550 <release>
}
80103a38:	83 c4 10             	add    $0x10,%esp
80103a3b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a3e:	c9                   	leave  
80103a3f:	c3                   	ret    
    panic("userinit: out of memory?");
80103a40:	83 ec 0c             	sub    $0xc,%esp
80103a43:	68 cc 75 10 80       	push   $0x801075cc
80103a48:	e8 f3 c9 ff ff       	call   80100440 <panic>
80103a4d:	8d 76 00             	lea    0x0(%esi),%esi

80103a50 <growproc>:
{
80103a50:	55                   	push   %ebp
80103a51:	89 e5                	mov    %esp,%ebp
80103a53:	56                   	push   %esi
80103a54:	53                   	push   %ebx
80103a55:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103a58:	e8 63 09 00 00       	call   801043c0 <pushcli>
  c = mycpu();
80103a5d:	e8 2e fe ff ff       	call   80103890 <mycpu>
  p = c->proc;
80103a62:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a68:	e8 93 09 00 00       	call   80104400 <popcli>
  if(n > 0){
80103a6d:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103a70:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103a72:	7f 1c                	jg     80103a90 <growproc+0x40>
  } else if(n < 0){
80103a74:	75 3a                	jne    80103ab0 <growproc+0x60>
  switchuvm(curproc);
80103a76:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103a79:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103a7b:	53                   	push   %ebx
80103a7c:	e8 ff 2e 00 00       	call   80106980 <switchuvm>
  return 0;
80103a81:	83 c4 10             	add    $0x10,%esp
80103a84:	31 c0                	xor    %eax,%eax
}
80103a86:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a89:	5b                   	pop    %ebx
80103a8a:	5e                   	pop    %esi
80103a8b:	5d                   	pop    %ebp
80103a8c:	c3                   	ret    
80103a8d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a90:	83 ec 04             	sub    $0x4,%esp
80103a93:	01 c6                	add    %eax,%esi
80103a95:	56                   	push   %esi
80103a96:	50                   	push   %eax
80103a97:	ff 73 04             	pushl  0x4(%ebx)
80103a9a:	e8 31 31 00 00       	call   80106bd0 <allocuvm>
80103a9f:	83 c4 10             	add    $0x10,%esp
80103aa2:	85 c0                	test   %eax,%eax
80103aa4:	75 d0                	jne    80103a76 <growproc+0x26>
      return -1;
80103aa6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103aab:	eb d9                	jmp    80103a86 <growproc+0x36>
80103aad:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ab0:	83 ec 04             	sub    $0x4,%esp
80103ab3:	01 c6                	add    %eax,%esi
80103ab5:	56                   	push   %esi
80103ab6:	50                   	push   %eax
80103ab7:	ff 73 04             	pushl  0x4(%ebx)
80103aba:	e8 41 32 00 00       	call   80106d00 <deallocuvm>
80103abf:	83 c4 10             	add    $0x10,%esp
80103ac2:	85 c0                	test   %eax,%eax
80103ac4:	75 b0                	jne    80103a76 <growproc+0x26>
80103ac6:	eb de                	jmp    80103aa6 <growproc+0x56>
80103ac8:	90                   	nop
80103ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103ad0 <fork>:
{
80103ad0:	55                   	push   %ebp
80103ad1:	89 e5                	mov    %esp,%ebp
80103ad3:	57                   	push   %edi
80103ad4:	56                   	push   %esi
80103ad5:	53                   	push   %ebx
80103ad6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103ad9:	e8 e2 08 00 00       	call   801043c0 <pushcli>
  c = mycpu();
80103ade:	e8 ad fd ff ff       	call   80103890 <mycpu>
  p = c->proc;
80103ae3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ae9:	e8 12 09 00 00       	call   80104400 <popcli>
  if((np = allocproc()) == 0){
80103aee:	e8 5d fc ff ff       	call   80103750 <allocproc>
80103af3:	85 c0                	test   %eax,%eax
80103af5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103af8:	0f 84 b7 00 00 00    	je     80103bb5 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103afe:	83 ec 08             	sub    $0x8,%esp
80103b01:	ff 33                	pushl  (%ebx)
80103b03:	ff 73 04             	pushl  0x4(%ebx)
80103b06:	89 c7                	mov    %eax,%edi
80103b08:	e8 73 33 00 00       	call   80106e80 <copyuvm>
80103b0d:	83 c4 10             	add    $0x10,%esp
80103b10:	85 c0                	test   %eax,%eax
80103b12:	89 47 04             	mov    %eax,0x4(%edi)
80103b15:	0f 84 a1 00 00 00    	je     80103bbc <fork+0xec>
  np->sz = curproc->sz;
80103b1b:	8b 03                	mov    (%ebx),%eax
80103b1d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103b20:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103b22:	89 59 14             	mov    %ebx,0x14(%ecx)
80103b25:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
80103b27:	8b 79 18             	mov    0x18(%ecx),%edi
80103b2a:	8b 73 18             	mov    0x18(%ebx),%esi
80103b2d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103b32:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103b34:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103b36:	8b 40 18             	mov    0x18(%eax),%eax
80103b39:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103b40:	8b 44 b3 2c          	mov    0x2c(%ebx,%esi,4),%eax
80103b44:	85 c0                	test   %eax,%eax
80103b46:	74 13                	je     80103b5b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103b48:	83 ec 0c             	sub    $0xc,%esp
80103b4b:	50                   	push   %eax
80103b4c:	e8 4f d3 ff ff       	call   80100ea0 <filedup>
80103b51:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b54:	83 c4 10             	add    $0x10,%esp
80103b57:	89 44 b2 2c          	mov    %eax,0x2c(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103b5b:	83 c6 01             	add    $0x1,%esi
80103b5e:	83 fe 10             	cmp    $0x10,%esi
80103b61:	75 dd                	jne    80103b40 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103b63:	83 ec 0c             	sub    $0xc,%esp
80103b66:	ff 73 6c             	pushl  0x6c(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b69:	83 c3 70             	add    $0x70,%ebx
  np->cwd = idup(curproc->cwd);
80103b6c:	e8 ef db ff ff       	call   80101760 <idup>
80103b71:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b74:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103b77:	89 47 6c             	mov    %eax,0x6c(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b7a:	8d 47 70             	lea    0x70(%edi),%eax
80103b7d:	6a 10                	push   $0x10
80103b7f:	53                   	push   %ebx
80103b80:	50                   	push   %eax
80103b81:	e8 fa 0b 00 00       	call   80104780 <safestrcpy>
  pid = np->pid;
80103b86:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103b89:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103b90:	e8 fb 08 00 00       	call   80104490 <acquire>
  np->state = RUNNABLE;
80103b95:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103b9c:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103ba3:	e8 a8 09 00 00       	call   80104550 <release>
  return pid;
80103ba8:	83 c4 10             	add    $0x10,%esp
}
80103bab:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bae:	89 d8                	mov    %ebx,%eax
80103bb0:	5b                   	pop    %ebx
80103bb1:	5e                   	pop    %esi
80103bb2:	5f                   	pop    %edi
80103bb3:	5d                   	pop    %ebp
80103bb4:	c3                   	ret    
    return -1;
80103bb5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103bba:	eb ef                	jmp    80103bab <fork+0xdb>
    kfree(np->kstack);
80103bbc:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103bbf:	83 ec 0c             	sub    $0xc,%esp
80103bc2:	ff 73 08             	pushl  0x8(%ebx)
80103bc5:	e8 96 e8 ff ff       	call   80102460 <kfree>
    np->kstack = 0;
80103bca:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103bd1:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103bd8:	83 c4 10             	add    $0x10,%esp
80103bdb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103be0:	eb c9                	jmp    80103bab <fork+0xdb>
80103be2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103bf0 <scheduler>:
{
80103bf0:	55                   	push   %ebp
80103bf1:	89 e5                	mov    %esp,%ebp
80103bf3:	57                   	push   %edi
80103bf4:	56                   	push   %esi
80103bf5:	53                   	push   %ebx
80103bf6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103bf9:	e8 92 fc ff ff       	call   80103890 <mycpu>
80103bfe:	8d 78 04             	lea    0x4(%eax),%edi
80103c01:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103c03:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103c0a:	00 00 00 
80103c0d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103c10:	fb                   	sti    
    acquire(&ptable.lock);
80103c11:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c14:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
    acquire(&ptable.lock);
80103c19:	68 40 2d 11 80       	push   $0x80112d40
80103c1e:	e8 6d 08 00 00       	call   80104490 <acquire>
80103c23:	83 c4 10             	add    $0x10,%esp
80103c26:	8d 76 00             	lea    0x0(%esi),%esi
80103c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
80103c30:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103c34:	75 33                	jne    80103c69 <scheduler+0x79>
      switchuvm(p);
80103c36:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103c39:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103c3f:	53                   	push   %ebx
80103c40:	e8 3b 2d 00 00       	call   80106980 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103c45:	58                   	pop    %eax
80103c46:	5a                   	pop    %edx
80103c47:	ff 73 1c             	pushl  0x1c(%ebx)
80103c4a:	57                   	push   %edi
      p->state = RUNNING;
80103c4b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103c52:	e8 84 0b 00 00       	call   801047db <swtch>
      switchkvm();
80103c57:	e8 04 2d 00 00       	call   80106960 <switchkvm>
      c->proc = 0;
80103c5c:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103c63:	00 00 00 
80103c66:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c69:	83 eb 80             	sub    $0xffffff80,%ebx
80103c6c:	81 fb 74 4d 11 80    	cmp    $0x80114d74,%ebx
80103c72:	72 bc                	jb     80103c30 <scheduler+0x40>
    release(&ptable.lock);
80103c74:	83 ec 0c             	sub    $0xc,%esp
80103c77:	68 40 2d 11 80       	push   $0x80112d40
80103c7c:	e8 cf 08 00 00       	call   80104550 <release>
    sti();
80103c81:	83 c4 10             	add    $0x10,%esp
80103c84:	eb 8a                	jmp    80103c10 <scheduler+0x20>
80103c86:	8d 76 00             	lea    0x0(%esi),%esi
80103c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c90 <sched>:
{
80103c90:	55                   	push   %ebp
80103c91:	89 e5                	mov    %esp,%ebp
80103c93:	56                   	push   %esi
80103c94:	53                   	push   %ebx
  pushcli();
80103c95:	e8 26 07 00 00       	call   801043c0 <pushcli>
  c = mycpu();
80103c9a:	e8 f1 fb ff ff       	call   80103890 <mycpu>
  p = c->proc;
80103c9f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ca5:	e8 56 07 00 00       	call   80104400 <popcli>
  if(!holding(&ptable.lock))
80103caa:	83 ec 0c             	sub    $0xc,%esp
80103cad:	68 40 2d 11 80       	push   $0x80112d40
80103cb2:	e8 a9 07 00 00       	call   80104460 <holding>
80103cb7:	83 c4 10             	add    $0x10,%esp
80103cba:	85 c0                	test   %eax,%eax
80103cbc:	74 4f                	je     80103d0d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103cbe:	e8 cd fb ff ff       	call   80103890 <mycpu>
80103cc3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103cca:	75 68                	jne    80103d34 <sched+0xa4>
  if(p->state == RUNNING)
80103ccc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103cd0:	74 55                	je     80103d27 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103cd2:	9c                   	pushf  
80103cd3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103cd4:	f6 c4 02             	test   $0x2,%ah
80103cd7:	75 41                	jne    80103d1a <sched+0x8a>
  intena = mycpu()->intena;
80103cd9:	e8 b2 fb ff ff       	call   80103890 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103cde:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103ce1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103ce7:	e8 a4 fb ff ff       	call   80103890 <mycpu>
80103cec:	83 ec 08             	sub    $0x8,%esp
80103cef:	ff 70 04             	pushl  0x4(%eax)
80103cf2:	53                   	push   %ebx
80103cf3:	e8 e3 0a 00 00       	call   801047db <swtch>
  mycpu()->intena = intena;
80103cf8:	e8 93 fb ff ff       	call   80103890 <mycpu>
}
80103cfd:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103d00:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103d06:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d09:	5b                   	pop    %ebx
80103d0a:	5e                   	pop    %esi
80103d0b:	5d                   	pop    %ebp
80103d0c:	c3                   	ret    
    panic("sched ptable.lock");
80103d0d:	83 ec 0c             	sub    $0xc,%esp
80103d10:	68 f0 75 10 80       	push   $0x801075f0
80103d15:	e8 26 c7 ff ff       	call   80100440 <panic>
    panic("sched interruptible");
80103d1a:	83 ec 0c             	sub    $0xc,%esp
80103d1d:	68 1c 76 10 80       	push   $0x8010761c
80103d22:	e8 19 c7 ff ff       	call   80100440 <panic>
    panic("sched running");
80103d27:	83 ec 0c             	sub    $0xc,%esp
80103d2a:	68 0e 76 10 80       	push   $0x8010760e
80103d2f:	e8 0c c7 ff ff       	call   80100440 <panic>
    panic("sched locks");
80103d34:	83 ec 0c             	sub    $0xc,%esp
80103d37:	68 02 76 10 80       	push   $0x80107602
80103d3c:	e8 ff c6 ff ff       	call   80100440 <panic>
80103d41:	eb 0d                	jmp    80103d50 <exit>
80103d43:	90                   	nop
80103d44:	90                   	nop
80103d45:	90                   	nop
80103d46:	90                   	nop
80103d47:	90                   	nop
80103d48:	90                   	nop
80103d49:	90                   	nop
80103d4a:	90                   	nop
80103d4b:	90                   	nop
80103d4c:	90                   	nop
80103d4d:	90                   	nop
80103d4e:	90                   	nop
80103d4f:	90                   	nop

80103d50 <exit>:
{
80103d50:	55                   	push   %ebp
80103d51:	89 e5                	mov    %esp,%ebp
80103d53:	57                   	push   %edi
80103d54:	56                   	push   %esi
80103d55:	53                   	push   %ebx
80103d56:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103d59:	e8 62 06 00 00       	call   801043c0 <pushcli>
  c = mycpu();
80103d5e:	e8 2d fb ff ff       	call   80103890 <mycpu>
  p = c->proc;
80103d63:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103d69:	e8 92 06 00 00       	call   80104400 <popcli>
  if(curproc == initproc)
80103d6e:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103d74:	8d 5e 2c             	lea    0x2c(%esi),%ebx
80103d77:	8d 7e 6c             	lea    0x6c(%esi),%edi
80103d7a:	0f 84 e7 00 00 00    	je     80103e67 <exit+0x117>
    if(curproc->ofile[fd]){
80103d80:	8b 03                	mov    (%ebx),%eax
80103d82:	85 c0                	test   %eax,%eax
80103d84:	74 12                	je     80103d98 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103d86:	83 ec 0c             	sub    $0xc,%esp
80103d89:	50                   	push   %eax
80103d8a:	e8 61 d1 ff ff       	call   80100ef0 <fileclose>
      curproc->ofile[fd] = 0;
80103d8f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103d95:	83 c4 10             	add    $0x10,%esp
80103d98:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103d9b:	39 fb                	cmp    %edi,%ebx
80103d9d:	75 e1                	jne    80103d80 <exit+0x30>
  begin_op();
80103d9f:	e8 4c ef ff ff       	call   80102cf0 <begin_op>
  iput(curproc->cwd);
80103da4:	83 ec 0c             	sub    $0xc,%esp
80103da7:	ff 76 6c             	pushl  0x6c(%esi)
80103daa:	e8 11 db ff ff       	call   801018c0 <iput>
  end_op();
80103daf:	e8 ac ef ff ff       	call   80102d60 <end_op>
  curproc->cwd = 0;
80103db4:	c7 46 6c 00 00 00 00 	movl   $0x0,0x6c(%esi)
  acquire(&ptable.lock);
80103dbb:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103dc2:	e8 c9 06 00 00       	call   80104490 <acquire>
  wakeup1(curproc->parent);
80103dc7:	8b 56 14             	mov    0x14(%esi),%edx
80103dca:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dcd:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80103dd2:	eb 0e                	jmp    80103de2 <exit+0x92>
80103dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103dd8:	83 e8 80             	sub    $0xffffff80,%eax
80103ddb:	3d 74 4d 11 80       	cmp    $0x80114d74,%eax
80103de0:	73 1c                	jae    80103dfe <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103de2:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103de6:	75 f0                	jne    80103dd8 <exit+0x88>
80103de8:	3b 50 20             	cmp    0x20(%eax),%edx
80103deb:	75 eb                	jne    80103dd8 <exit+0x88>
      p->state = RUNNABLE;
80103ded:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103df4:	83 e8 80             	sub    $0xffffff80,%eax
80103df7:	3d 74 4d 11 80       	cmp    $0x80114d74,%eax
80103dfc:	72 e4                	jb     80103de2 <exit+0x92>
      p->parent = initproc;
80103dfe:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e04:	ba 74 2d 11 80       	mov    $0x80112d74,%edx
80103e09:	eb 10                	jmp    80103e1b <exit+0xcb>
80103e0b:	90                   	nop
80103e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e10:	83 ea 80             	sub    $0xffffff80,%edx
80103e13:	81 fa 74 4d 11 80    	cmp    $0x80114d74,%edx
80103e19:	73 33                	jae    80103e4e <exit+0xfe>
    if(p->parent == curproc){
80103e1b:	39 72 14             	cmp    %esi,0x14(%edx)
80103e1e:	75 f0                	jne    80103e10 <exit+0xc0>
      if(p->state == ZOMBIE)
80103e20:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103e24:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103e27:	75 e7                	jne    80103e10 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e29:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80103e2e:	eb 0a                	jmp    80103e3a <exit+0xea>
80103e30:	83 e8 80             	sub    $0xffffff80,%eax
80103e33:	3d 74 4d 11 80       	cmp    $0x80114d74,%eax
80103e38:	73 d6                	jae    80103e10 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103e3a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e3e:	75 f0                	jne    80103e30 <exit+0xe0>
80103e40:	3b 48 20             	cmp    0x20(%eax),%ecx
80103e43:	75 eb                	jne    80103e30 <exit+0xe0>
      p->state = RUNNABLE;
80103e45:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e4c:	eb e2                	jmp    80103e30 <exit+0xe0>
  curproc->state = ZOMBIE;
80103e4e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103e55:	e8 36 fe ff ff       	call   80103c90 <sched>
  panic("zombie exit");
80103e5a:	83 ec 0c             	sub    $0xc,%esp
80103e5d:	68 3d 76 10 80       	push   $0x8010763d
80103e62:	e8 d9 c5 ff ff       	call   80100440 <panic>
    panic("init exiting");
80103e67:	83 ec 0c             	sub    $0xc,%esp
80103e6a:	68 30 76 10 80       	push   $0x80107630
80103e6f:	e8 cc c5 ff ff       	call   80100440 <panic>
80103e74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103e80 <yield>:
{
80103e80:	55                   	push   %ebp
80103e81:	89 e5                	mov    %esp,%ebp
80103e83:	53                   	push   %ebx
80103e84:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103e87:	68 40 2d 11 80       	push   $0x80112d40
80103e8c:	e8 ff 05 00 00       	call   80104490 <acquire>
  pushcli();
80103e91:	e8 2a 05 00 00       	call   801043c0 <pushcli>
  c = mycpu();
80103e96:	e8 f5 f9 ff ff       	call   80103890 <mycpu>
  p = c->proc;
80103e9b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ea1:	e8 5a 05 00 00       	call   80104400 <popcli>
  myproc()->state = RUNNABLE;
80103ea6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103ead:	e8 de fd ff ff       	call   80103c90 <sched>
  release(&ptable.lock);
80103eb2:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103eb9:	e8 92 06 00 00       	call   80104550 <release>
}
80103ebe:	83 c4 10             	add    $0x10,%esp
80103ec1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ec4:	c9                   	leave  
80103ec5:	c3                   	ret    
80103ec6:	8d 76 00             	lea    0x0(%esi),%esi
80103ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ed0 <sleep>:
{
80103ed0:	55                   	push   %ebp
80103ed1:	89 e5                	mov    %esp,%ebp
80103ed3:	57                   	push   %edi
80103ed4:	56                   	push   %esi
80103ed5:	53                   	push   %ebx
80103ed6:	83 ec 0c             	sub    $0xc,%esp
80103ed9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103edc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103edf:	e8 dc 04 00 00       	call   801043c0 <pushcli>
  c = mycpu();
80103ee4:	e8 a7 f9 ff ff       	call   80103890 <mycpu>
  p = c->proc;
80103ee9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103eef:	e8 0c 05 00 00       	call   80104400 <popcli>
  if(p == 0)
80103ef4:	85 db                	test   %ebx,%ebx
80103ef6:	0f 84 87 00 00 00    	je     80103f83 <sleep+0xb3>
  if(lk == 0)
80103efc:	85 f6                	test   %esi,%esi
80103efe:	74 76                	je     80103f76 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103f00:	81 fe 40 2d 11 80    	cmp    $0x80112d40,%esi
80103f06:	74 50                	je     80103f58 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103f08:	83 ec 0c             	sub    $0xc,%esp
80103f0b:	68 40 2d 11 80       	push   $0x80112d40
80103f10:	e8 7b 05 00 00       	call   80104490 <acquire>
    release(lk);
80103f15:	89 34 24             	mov    %esi,(%esp)
80103f18:	e8 33 06 00 00       	call   80104550 <release>
  p->chan = chan;
80103f1d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f20:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f27:	e8 64 fd ff ff       	call   80103c90 <sched>
  p->chan = 0;
80103f2c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103f33:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103f3a:	e8 11 06 00 00       	call   80104550 <release>
    acquire(lk);
80103f3f:	89 75 08             	mov    %esi,0x8(%ebp)
80103f42:	83 c4 10             	add    $0x10,%esp
}
80103f45:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f48:	5b                   	pop    %ebx
80103f49:	5e                   	pop    %esi
80103f4a:	5f                   	pop    %edi
80103f4b:	5d                   	pop    %ebp
    acquire(lk);
80103f4c:	e9 3f 05 00 00       	jmp    80104490 <acquire>
80103f51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103f58:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f5b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f62:	e8 29 fd ff ff       	call   80103c90 <sched>
  p->chan = 0;
80103f67:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103f6e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f71:	5b                   	pop    %ebx
80103f72:	5e                   	pop    %esi
80103f73:	5f                   	pop    %edi
80103f74:	5d                   	pop    %ebp
80103f75:	c3                   	ret    
    panic("sleep without lk");
80103f76:	83 ec 0c             	sub    $0xc,%esp
80103f79:	68 4f 76 10 80       	push   $0x8010764f
80103f7e:	e8 bd c4 ff ff       	call   80100440 <panic>
    panic("sleep");
80103f83:	83 ec 0c             	sub    $0xc,%esp
80103f86:	68 49 76 10 80       	push   $0x80107649
80103f8b:	e8 b0 c4 ff ff       	call   80100440 <panic>

80103f90 <wait>:
{
80103f90:	55                   	push   %ebp
80103f91:	89 e5                	mov    %esp,%ebp
80103f93:	56                   	push   %esi
80103f94:	53                   	push   %ebx
  pushcli();
80103f95:	e8 26 04 00 00       	call   801043c0 <pushcli>
  c = mycpu();
80103f9a:	e8 f1 f8 ff ff       	call   80103890 <mycpu>
  p = c->proc;
80103f9f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103fa5:	e8 56 04 00 00       	call   80104400 <popcli>
  acquire(&ptable.lock);
80103faa:	83 ec 0c             	sub    $0xc,%esp
80103fad:	68 40 2d 11 80       	push   $0x80112d40
80103fb2:	e8 d9 04 00 00       	call   80104490 <acquire>
80103fb7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103fba:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fbc:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
80103fc1:	eb 10                	jmp    80103fd3 <wait+0x43>
80103fc3:	90                   	nop
80103fc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103fc8:	83 eb 80             	sub    $0xffffff80,%ebx
80103fcb:	81 fb 74 4d 11 80    	cmp    $0x80114d74,%ebx
80103fd1:	73 1b                	jae    80103fee <wait+0x5e>
      if(p->parent != curproc)
80103fd3:	39 73 14             	cmp    %esi,0x14(%ebx)
80103fd6:	75 f0                	jne    80103fc8 <wait+0x38>
      if(p->state == ZOMBIE){
80103fd8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103fdc:	74 32                	je     80104010 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fde:	83 eb 80             	sub    $0xffffff80,%ebx
      havekids = 1;
80103fe1:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fe6:	81 fb 74 4d 11 80    	cmp    $0x80114d74,%ebx
80103fec:	72 e5                	jb     80103fd3 <wait+0x43>
    if(!havekids || curproc->killed){
80103fee:	85 c0                	test   %eax,%eax
80103ff0:	74 74                	je     80104066 <wait+0xd6>
80103ff2:	8b 46 24             	mov    0x24(%esi),%eax
80103ff5:	85 c0                	test   %eax,%eax
80103ff7:	75 6d                	jne    80104066 <wait+0xd6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103ff9:	83 ec 08             	sub    $0x8,%esp
80103ffc:	68 40 2d 11 80       	push   $0x80112d40
80104001:	56                   	push   %esi
80104002:	e8 c9 fe ff ff       	call   80103ed0 <sleep>
    havekids = 0;
80104007:	83 c4 10             	add    $0x10,%esp
8010400a:	eb ae                	jmp    80103fba <wait+0x2a>
8010400c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80104010:	83 ec 0c             	sub    $0xc,%esp
80104013:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80104016:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104019:	e8 42 e4 ff ff       	call   80102460 <kfree>
        freevm(p->pgdir);
8010401e:	5a                   	pop    %edx
8010401f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80104022:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104029:	e8 02 2d 00 00       	call   80106d30 <freevm>
        release(&ptable.lock);
8010402e:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
        p->pid = 0;
80104035:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
8010403c:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104043:	c6 43 70 00          	movb   $0x0,0x70(%ebx)
        p->killed = 0;
80104047:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010404e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104055:	e8 f6 04 00 00       	call   80104550 <release>
        return pid;
8010405a:	83 c4 10             	add    $0x10,%esp
}
8010405d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104060:	89 f0                	mov    %esi,%eax
80104062:	5b                   	pop    %ebx
80104063:	5e                   	pop    %esi
80104064:	5d                   	pop    %ebp
80104065:	c3                   	ret    
      release(&ptable.lock);
80104066:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104069:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010406e:	68 40 2d 11 80       	push   $0x80112d40
80104073:	e8 d8 04 00 00       	call   80104550 <release>
      return -1;
80104078:	83 c4 10             	add    $0x10,%esp
8010407b:	eb e0                	jmp    8010405d <wait+0xcd>
8010407d:	8d 76 00             	lea    0x0(%esi),%esi

80104080 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104080:	55                   	push   %ebp
80104081:	89 e5                	mov    %esp,%ebp
80104083:	53                   	push   %ebx
80104084:	83 ec 10             	sub    $0x10,%esp
80104087:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010408a:	68 40 2d 11 80       	push   $0x80112d40
8010408f:	e8 fc 03 00 00       	call   80104490 <acquire>
80104094:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104097:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
8010409c:	eb 0c                	jmp    801040aa <wakeup+0x2a>
8010409e:	66 90                	xchg   %ax,%ax
801040a0:	83 e8 80             	sub    $0xffffff80,%eax
801040a3:	3d 74 4d 11 80       	cmp    $0x80114d74,%eax
801040a8:	73 1c                	jae    801040c6 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
801040aa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801040ae:	75 f0                	jne    801040a0 <wakeup+0x20>
801040b0:	3b 58 20             	cmp    0x20(%eax),%ebx
801040b3:	75 eb                	jne    801040a0 <wakeup+0x20>
      p->state = RUNNABLE;
801040b5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040bc:	83 e8 80             	sub    $0xffffff80,%eax
801040bf:	3d 74 4d 11 80       	cmp    $0x80114d74,%eax
801040c4:	72 e4                	jb     801040aa <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
801040c6:	c7 45 08 40 2d 11 80 	movl   $0x80112d40,0x8(%ebp)
}
801040cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040d0:	c9                   	leave  
  release(&ptable.lock);
801040d1:	e9 7a 04 00 00       	jmp    80104550 <release>
801040d6:	8d 76 00             	lea    0x0(%esi),%esi
801040d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801040e0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	53                   	push   %ebx
801040e4:	83 ec 10             	sub    $0x10,%esp
801040e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801040ea:	68 40 2d 11 80       	push   $0x80112d40
801040ef:	e8 9c 03 00 00       	call   80104490 <acquire>
801040f4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040f7:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
801040fc:	eb 0c                	jmp    8010410a <kill+0x2a>
801040fe:	66 90                	xchg   %ax,%ax
80104100:	83 e8 80             	sub    $0xffffff80,%eax
80104103:	3d 74 4d 11 80       	cmp    $0x80114d74,%eax
80104108:	73 36                	jae    80104140 <kill+0x60>
    if(p->pid == pid){
8010410a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010410d:	75 f1                	jne    80104100 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010410f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104113:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010411a:	75 07                	jne    80104123 <kill+0x43>
        p->state = RUNNABLE;
8010411c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104123:	83 ec 0c             	sub    $0xc,%esp
80104126:	68 40 2d 11 80       	push   $0x80112d40
8010412b:	e8 20 04 00 00       	call   80104550 <release>
      return 0;
80104130:	83 c4 10             	add    $0x10,%esp
80104133:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104135:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104138:	c9                   	leave  
80104139:	c3                   	ret    
8010413a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104140:	83 ec 0c             	sub    $0xc,%esp
80104143:	68 40 2d 11 80       	push   $0x80112d40
80104148:	e8 03 04 00 00       	call   80104550 <release>
  return -1;
8010414d:	83 c4 10             	add    $0x10,%esp
80104150:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104155:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104158:	c9                   	leave  
80104159:	c3                   	ret    
8010415a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104160 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104160:	55                   	push   %ebp
80104161:	89 e5                	mov    %esp,%ebp
80104163:	57                   	push   %edi
80104164:	56                   	push   %esi
80104165:	53                   	push   %ebx
80104166:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104169:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
{
8010416e:	83 ec 3c             	sub    $0x3c,%esp
80104171:	eb 24                	jmp    80104197 <procdump+0x37>
80104173:	90                   	nop
80104174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104178:	83 ec 0c             	sub    $0xc,%esp
8010417b:	68 df 79 10 80       	push   $0x801079df
80104180:	e8 8b c5 ff ff       	call   80100710 <cprintf>
80104185:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104188:	83 eb 80             	sub    $0xffffff80,%ebx
8010418b:	81 fb 74 4d 11 80    	cmp    $0x80114d74,%ebx
80104191:	0f 83 81 00 00 00    	jae    80104218 <procdump+0xb8>
    if(p->state == UNUSED)
80104197:	8b 43 0c             	mov    0xc(%ebx),%eax
8010419a:	85 c0                	test   %eax,%eax
8010419c:	74 ea                	je     80104188 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010419e:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
801041a1:	ba 60 76 10 80       	mov    $0x80107660,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041a6:	77 11                	ja     801041b9 <procdump+0x59>
801041a8:	8b 14 85 c0 76 10 80 	mov    -0x7fef8940(,%eax,4),%edx
      state = "???";
801041af:	b8 60 76 10 80       	mov    $0x80107660,%eax
801041b4:	85 d2                	test   %edx,%edx
801041b6:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801041b9:	8d 43 70             	lea    0x70(%ebx),%eax
801041bc:	50                   	push   %eax
801041bd:	52                   	push   %edx
801041be:	ff 73 10             	pushl  0x10(%ebx)
801041c1:	68 64 76 10 80       	push   $0x80107664
801041c6:	e8 45 c5 ff ff       	call   80100710 <cprintf>
    if(p->state == SLEEPING){
801041cb:	83 c4 10             	add    $0x10,%esp
801041ce:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
801041d2:	75 a4                	jne    80104178 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801041d4:	8d 45 c0             	lea    -0x40(%ebp),%eax
801041d7:	83 ec 08             	sub    $0x8,%esp
801041da:	8d 7d c0             	lea    -0x40(%ebp),%edi
801041dd:	50                   	push   %eax
801041de:	8b 43 1c             	mov    0x1c(%ebx),%eax
801041e1:	8b 40 0c             	mov    0xc(%eax),%eax
801041e4:	83 c0 08             	add    $0x8,%eax
801041e7:	50                   	push   %eax
801041e8:	e8 83 01 00 00       	call   80104370 <getcallerpcs>
801041ed:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801041f0:	8b 17                	mov    (%edi),%edx
801041f2:	85 d2                	test   %edx,%edx
801041f4:	74 82                	je     80104178 <procdump+0x18>
        cprintf(" %p", pc[i]);
801041f6:	83 ec 08             	sub    $0x8,%esp
801041f9:	83 c7 04             	add    $0x4,%edi
801041fc:	52                   	push   %edx
801041fd:	68 a1 70 10 80       	push   $0x801070a1
80104202:	e8 09 c5 ff ff       	call   80100710 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104207:	83 c4 10             	add    $0x10,%esp
8010420a:	39 fe                	cmp    %edi,%esi
8010420c:	75 e2                	jne    801041f0 <procdump+0x90>
8010420e:	e9 65 ff ff ff       	jmp    80104178 <procdump+0x18>
80104213:	90                   	nop
80104214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
}
80104218:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010421b:	5b                   	pop    %ebx
8010421c:	5e                   	pop    %esi
8010421d:	5f                   	pop    %edi
8010421e:	5d                   	pop    %ebp
8010421f:	c3                   	ret    

80104220 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104220:	55                   	push   %ebp
80104221:	89 e5                	mov    %esp,%ebp
80104223:	53                   	push   %ebx
80104224:	83 ec 0c             	sub    $0xc,%esp
80104227:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010422a:	68 d8 76 10 80       	push   $0x801076d8
8010422f:	8d 43 04             	lea    0x4(%ebx),%eax
80104232:	50                   	push   %eax
80104233:	e8 18 01 00 00       	call   80104350 <initlock>
  lk->name = name;
80104238:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010423b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104241:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104244:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010424b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010424e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104251:	c9                   	leave  
80104252:	c3                   	ret    
80104253:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104260 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	56                   	push   %esi
80104264:	53                   	push   %ebx
80104265:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104268:	83 ec 0c             	sub    $0xc,%esp
8010426b:	8d 73 04             	lea    0x4(%ebx),%esi
8010426e:	56                   	push   %esi
8010426f:	e8 1c 02 00 00       	call   80104490 <acquire>
  while (lk->locked) {
80104274:	8b 13                	mov    (%ebx),%edx
80104276:	83 c4 10             	add    $0x10,%esp
80104279:	85 d2                	test   %edx,%edx
8010427b:	74 16                	je     80104293 <acquiresleep+0x33>
8010427d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104280:	83 ec 08             	sub    $0x8,%esp
80104283:	56                   	push   %esi
80104284:	53                   	push   %ebx
80104285:	e8 46 fc ff ff       	call   80103ed0 <sleep>
  while (lk->locked) {
8010428a:	8b 03                	mov    (%ebx),%eax
8010428c:	83 c4 10             	add    $0x10,%esp
8010428f:	85 c0                	test   %eax,%eax
80104291:	75 ed                	jne    80104280 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104293:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104299:	e8 92 f6 ff ff       	call   80103930 <myproc>
8010429e:	8b 40 10             	mov    0x10(%eax),%eax
801042a1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801042a4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801042a7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042aa:	5b                   	pop    %ebx
801042ab:	5e                   	pop    %esi
801042ac:	5d                   	pop    %ebp
  release(&lk->lk);
801042ad:	e9 9e 02 00 00       	jmp    80104550 <release>
801042b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042c0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801042c0:	55                   	push   %ebp
801042c1:	89 e5                	mov    %esp,%ebp
801042c3:	56                   	push   %esi
801042c4:	53                   	push   %ebx
801042c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801042c8:	83 ec 0c             	sub    $0xc,%esp
801042cb:	8d 73 04             	lea    0x4(%ebx),%esi
801042ce:	56                   	push   %esi
801042cf:	e8 bc 01 00 00       	call   80104490 <acquire>
  lk->locked = 0;
801042d4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801042da:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801042e1:	89 1c 24             	mov    %ebx,(%esp)
801042e4:	e8 97 fd ff ff       	call   80104080 <wakeup>
  release(&lk->lk);
801042e9:	89 75 08             	mov    %esi,0x8(%ebp)
801042ec:	83 c4 10             	add    $0x10,%esp
}
801042ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042f2:	5b                   	pop    %ebx
801042f3:	5e                   	pop    %esi
801042f4:	5d                   	pop    %ebp
  release(&lk->lk);
801042f5:	e9 56 02 00 00       	jmp    80104550 <release>
801042fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104300 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	57                   	push   %edi
80104304:	56                   	push   %esi
80104305:	53                   	push   %ebx
80104306:	31 ff                	xor    %edi,%edi
80104308:	83 ec 18             	sub    $0x18,%esp
8010430b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010430e:	8d 73 04             	lea    0x4(%ebx),%esi
80104311:	56                   	push   %esi
80104312:	e8 79 01 00 00       	call   80104490 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104317:	8b 03                	mov    (%ebx),%eax
80104319:	83 c4 10             	add    $0x10,%esp
8010431c:	85 c0                	test   %eax,%eax
8010431e:	74 13                	je     80104333 <holdingsleep+0x33>
80104320:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104323:	e8 08 f6 ff ff       	call   80103930 <myproc>
80104328:	39 58 10             	cmp    %ebx,0x10(%eax)
8010432b:	0f 94 c0             	sete   %al
8010432e:	0f b6 c0             	movzbl %al,%eax
80104331:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104333:	83 ec 0c             	sub    $0xc,%esp
80104336:	56                   	push   %esi
80104337:	e8 14 02 00 00       	call   80104550 <release>
  return r;
}
8010433c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010433f:	89 f8                	mov    %edi,%eax
80104341:	5b                   	pop    %ebx
80104342:	5e                   	pop    %esi
80104343:	5f                   	pop    %edi
80104344:	5d                   	pop    %ebp
80104345:	c3                   	ret    
80104346:	66 90                	xchg   %ax,%ax
80104348:	66 90                	xchg   %ax,%ax
8010434a:	66 90                	xchg   %ax,%ax
8010434c:	66 90                	xchg   %ax,%ax
8010434e:	66 90                	xchg   %ax,%ax

80104350 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104350:	55                   	push   %ebp
80104351:	89 e5                	mov    %esp,%ebp
80104353:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104356:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104359:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010435f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104362:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104369:	5d                   	pop    %ebp
8010436a:	c3                   	ret    
8010436b:	90                   	nop
8010436c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104370 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104370:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104371:	31 d2                	xor    %edx,%edx
{
80104373:	89 e5                	mov    %esp,%ebp
80104375:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104376:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104379:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010437c:	83 e8 08             	sub    $0x8,%eax
8010437f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104380:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104386:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010438c:	77 1a                	ja     801043a8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010438e:	8b 58 04             	mov    0x4(%eax),%ebx
80104391:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104394:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104397:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104399:	83 fa 0a             	cmp    $0xa,%edx
8010439c:	75 e2                	jne    80104380 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010439e:	5b                   	pop    %ebx
8010439f:	5d                   	pop    %ebp
801043a0:	c3                   	ret    
801043a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043a8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801043ab:	83 c1 28             	add    $0x28,%ecx
801043ae:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801043b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801043b6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801043b9:	39 c1                	cmp    %eax,%ecx
801043bb:	75 f3                	jne    801043b0 <getcallerpcs+0x40>
}
801043bd:	5b                   	pop    %ebx
801043be:	5d                   	pop    %ebp
801043bf:	c3                   	ret    

801043c0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	53                   	push   %ebx
801043c4:	83 ec 04             	sub    $0x4,%esp
801043c7:	9c                   	pushf  
801043c8:	5b                   	pop    %ebx
  asm volatile("cli");
801043c9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801043ca:	e8 c1 f4 ff ff       	call   80103890 <mycpu>
801043cf:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801043d5:	85 c0                	test   %eax,%eax
801043d7:	75 11                	jne    801043ea <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801043d9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801043df:	e8 ac f4 ff ff       	call   80103890 <mycpu>
801043e4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801043ea:	e8 a1 f4 ff ff       	call   80103890 <mycpu>
801043ef:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801043f6:	83 c4 04             	add    $0x4,%esp
801043f9:	5b                   	pop    %ebx
801043fa:	5d                   	pop    %ebp
801043fb:	c3                   	ret    
801043fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104400 <popcli>:

void
popcli(void)
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104406:	9c                   	pushf  
80104407:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104408:	f6 c4 02             	test   $0x2,%ah
8010440b:	75 35                	jne    80104442 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010440d:	e8 7e f4 ff ff       	call   80103890 <mycpu>
80104412:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104419:	78 34                	js     8010444f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010441b:	e8 70 f4 ff ff       	call   80103890 <mycpu>
80104420:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104426:	85 d2                	test   %edx,%edx
80104428:	74 06                	je     80104430 <popcli+0x30>
    sti();
}
8010442a:	c9                   	leave  
8010442b:	c3                   	ret    
8010442c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104430:	e8 5b f4 ff ff       	call   80103890 <mycpu>
80104435:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010443b:	85 c0                	test   %eax,%eax
8010443d:	74 eb                	je     8010442a <popcli+0x2a>
  asm volatile("sti");
8010443f:	fb                   	sti    
}
80104440:	c9                   	leave  
80104441:	c3                   	ret    
    panic("popcli - interruptible");
80104442:	83 ec 0c             	sub    $0xc,%esp
80104445:	68 e3 76 10 80       	push   $0x801076e3
8010444a:	e8 f1 bf ff ff       	call   80100440 <panic>
    panic("popcli");
8010444f:	83 ec 0c             	sub    $0xc,%esp
80104452:	68 fa 76 10 80       	push   $0x801076fa
80104457:	e8 e4 bf ff ff       	call   80100440 <panic>
8010445c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104460 <holding>:
{
80104460:	55                   	push   %ebp
80104461:	89 e5                	mov    %esp,%ebp
80104463:	56                   	push   %esi
80104464:	53                   	push   %ebx
80104465:	8b 75 08             	mov    0x8(%ebp),%esi
80104468:	31 db                	xor    %ebx,%ebx
  pushcli();
8010446a:	e8 51 ff ff ff       	call   801043c0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010446f:	8b 06                	mov    (%esi),%eax
80104471:	85 c0                	test   %eax,%eax
80104473:	74 10                	je     80104485 <holding+0x25>
80104475:	8b 5e 08             	mov    0x8(%esi),%ebx
80104478:	e8 13 f4 ff ff       	call   80103890 <mycpu>
8010447d:	39 c3                	cmp    %eax,%ebx
8010447f:	0f 94 c3             	sete   %bl
80104482:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104485:	e8 76 ff ff ff       	call   80104400 <popcli>
}
8010448a:	89 d8                	mov    %ebx,%eax
8010448c:	5b                   	pop    %ebx
8010448d:	5e                   	pop    %esi
8010448e:	5d                   	pop    %ebp
8010448f:	c3                   	ret    

80104490 <acquire>:
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	56                   	push   %esi
80104494:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104495:	e8 26 ff ff ff       	call   801043c0 <pushcli>
  if(holding(lk))
8010449a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010449d:	83 ec 0c             	sub    $0xc,%esp
801044a0:	53                   	push   %ebx
801044a1:	e8 ba ff ff ff       	call   80104460 <holding>
801044a6:	83 c4 10             	add    $0x10,%esp
801044a9:	85 c0                	test   %eax,%eax
801044ab:	0f 85 83 00 00 00    	jne    80104534 <acquire+0xa4>
801044b1:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
801044b3:	ba 01 00 00 00       	mov    $0x1,%edx
801044b8:	eb 09                	jmp    801044c3 <acquire+0x33>
801044ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801044c0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044c3:	89 d0                	mov    %edx,%eax
801044c5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801044c8:	85 c0                	test   %eax,%eax
801044ca:	75 f4                	jne    801044c0 <acquire+0x30>
  __sync_synchronize();
801044cc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801044d1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044d4:	e8 b7 f3 ff ff       	call   80103890 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801044d9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
801044dc:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801044df:	89 e8                	mov    %ebp,%eax
801044e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801044e8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801044ee:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801044f4:	77 1a                	ja     80104510 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801044f6:	8b 48 04             	mov    0x4(%eax),%ecx
801044f9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
801044fc:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801044ff:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104501:	83 fe 0a             	cmp    $0xa,%esi
80104504:	75 e2                	jne    801044e8 <acquire+0x58>
}
80104506:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104509:	5b                   	pop    %ebx
8010450a:	5e                   	pop    %esi
8010450b:	5d                   	pop    %ebp
8010450c:	c3                   	ret    
8010450d:	8d 76 00             	lea    0x0(%esi),%esi
80104510:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104513:	83 c2 28             	add    $0x28,%edx
80104516:	8d 76 00             	lea    0x0(%esi),%esi
80104519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104520:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104526:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104529:	39 d0                	cmp    %edx,%eax
8010452b:	75 f3                	jne    80104520 <acquire+0x90>
}
8010452d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104530:	5b                   	pop    %ebx
80104531:	5e                   	pop    %esi
80104532:	5d                   	pop    %ebp
80104533:	c3                   	ret    
    panic("acquire");
80104534:	83 ec 0c             	sub    $0xc,%esp
80104537:	68 01 77 10 80       	push   $0x80107701
8010453c:	e8 ff be ff ff       	call   80100440 <panic>
80104541:	eb 0d                	jmp    80104550 <release>
80104543:	90                   	nop
80104544:	90                   	nop
80104545:	90                   	nop
80104546:	90                   	nop
80104547:	90                   	nop
80104548:	90                   	nop
80104549:	90                   	nop
8010454a:	90                   	nop
8010454b:	90                   	nop
8010454c:	90                   	nop
8010454d:	90                   	nop
8010454e:	90                   	nop
8010454f:	90                   	nop

80104550 <release>:
{
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	53                   	push   %ebx
80104554:	83 ec 10             	sub    $0x10,%esp
80104557:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010455a:	53                   	push   %ebx
8010455b:	e8 00 ff ff ff       	call   80104460 <holding>
80104560:	83 c4 10             	add    $0x10,%esp
80104563:	85 c0                	test   %eax,%eax
80104565:	74 22                	je     80104589 <release+0x39>
  lk->pcs[0] = 0;
80104567:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010456e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104575:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010457a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104580:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104583:	c9                   	leave  
  popcli();
80104584:	e9 77 fe ff ff       	jmp    80104400 <popcli>
    panic("release");
80104589:	83 ec 0c             	sub    $0xc,%esp
8010458c:	68 09 77 10 80       	push   $0x80107709
80104591:	e8 aa be ff ff       	call   80100440 <panic>
80104596:	66 90                	xchg   %ax,%ax
80104598:	66 90                	xchg   %ax,%ax
8010459a:	66 90                	xchg   %ax,%ax
8010459c:	66 90                	xchg   %ax,%ax
8010459e:	66 90                	xchg   %ax,%ax

801045a0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801045a0:	55                   	push   %ebp
801045a1:	89 e5                	mov    %esp,%ebp
801045a3:	57                   	push   %edi
801045a4:	53                   	push   %ebx
801045a5:	8b 55 08             	mov    0x8(%ebp),%edx
801045a8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801045ab:	f6 c2 03             	test   $0x3,%dl
801045ae:	75 05                	jne    801045b5 <memset+0x15>
801045b0:	f6 c1 03             	test   $0x3,%cl
801045b3:	74 13                	je     801045c8 <memset+0x28>
  asm volatile("cld; rep stosb" :
801045b5:	89 d7                	mov    %edx,%edi
801045b7:	8b 45 0c             	mov    0xc(%ebp),%eax
801045ba:	fc                   	cld    
801045bb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801045bd:	5b                   	pop    %ebx
801045be:	89 d0                	mov    %edx,%eax
801045c0:	5f                   	pop    %edi
801045c1:	5d                   	pop    %ebp
801045c2:	c3                   	ret    
801045c3:	90                   	nop
801045c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
801045c8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801045cc:	c1 e9 02             	shr    $0x2,%ecx
801045cf:	89 f8                	mov    %edi,%eax
801045d1:	89 fb                	mov    %edi,%ebx
801045d3:	c1 e0 18             	shl    $0x18,%eax
801045d6:	c1 e3 10             	shl    $0x10,%ebx
801045d9:	09 d8                	or     %ebx,%eax
801045db:	09 f8                	or     %edi,%eax
801045dd:	c1 e7 08             	shl    $0x8,%edi
801045e0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801045e2:	89 d7                	mov    %edx,%edi
801045e4:	fc                   	cld    
801045e5:	f3 ab                	rep stos %eax,%es:(%edi)
}
801045e7:	5b                   	pop    %ebx
801045e8:	89 d0                	mov    %edx,%eax
801045ea:	5f                   	pop    %edi
801045eb:	5d                   	pop    %ebp
801045ec:	c3                   	ret    
801045ed:	8d 76 00             	lea    0x0(%esi),%esi

801045f0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801045f0:	55                   	push   %ebp
801045f1:	89 e5                	mov    %esp,%ebp
801045f3:	57                   	push   %edi
801045f4:	56                   	push   %esi
801045f5:	53                   	push   %ebx
801045f6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801045f9:	8b 75 08             	mov    0x8(%ebp),%esi
801045fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801045ff:	85 db                	test   %ebx,%ebx
80104601:	74 29                	je     8010462c <memcmp+0x3c>
    if(*s1 != *s2)
80104603:	0f b6 16             	movzbl (%esi),%edx
80104606:	0f b6 0f             	movzbl (%edi),%ecx
80104609:	38 d1                	cmp    %dl,%cl
8010460b:	75 2b                	jne    80104638 <memcmp+0x48>
8010460d:	b8 01 00 00 00       	mov    $0x1,%eax
80104612:	eb 14                	jmp    80104628 <memcmp+0x38>
80104614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104618:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
8010461c:	83 c0 01             	add    $0x1,%eax
8010461f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104624:	38 ca                	cmp    %cl,%dl
80104626:	75 10                	jne    80104638 <memcmp+0x48>
  while(n-- > 0){
80104628:	39 d8                	cmp    %ebx,%eax
8010462a:	75 ec                	jne    80104618 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010462c:	5b                   	pop    %ebx
  return 0;
8010462d:	31 c0                	xor    %eax,%eax
}
8010462f:	5e                   	pop    %esi
80104630:	5f                   	pop    %edi
80104631:	5d                   	pop    %ebp
80104632:	c3                   	ret    
80104633:	90                   	nop
80104634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104638:	0f b6 c2             	movzbl %dl,%eax
}
8010463b:	5b                   	pop    %ebx
      return *s1 - *s2;
8010463c:	29 c8                	sub    %ecx,%eax
}
8010463e:	5e                   	pop    %esi
8010463f:	5f                   	pop    %edi
80104640:	5d                   	pop    %ebp
80104641:	c3                   	ret    
80104642:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104650 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	56                   	push   %esi
80104654:	53                   	push   %ebx
80104655:	8b 45 08             	mov    0x8(%ebp),%eax
80104658:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010465b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010465e:	39 c3                	cmp    %eax,%ebx
80104660:	73 26                	jae    80104688 <memmove+0x38>
80104662:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104665:	39 c8                	cmp    %ecx,%eax
80104667:	73 1f                	jae    80104688 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104669:	85 f6                	test   %esi,%esi
8010466b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010466e:	74 0f                	je     8010467f <memmove+0x2f>
      *--d = *--s;
80104670:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104674:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104677:	83 ea 01             	sub    $0x1,%edx
8010467a:	83 fa ff             	cmp    $0xffffffff,%edx
8010467d:	75 f1                	jne    80104670 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010467f:	5b                   	pop    %ebx
80104680:	5e                   	pop    %esi
80104681:	5d                   	pop    %ebp
80104682:	c3                   	ret    
80104683:	90                   	nop
80104684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104688:	31 d2                	xor    %edx,%edx
8010468a:	85 f6                	test   %esi,%esi
8010468c:	74 f1                	je     8010467f <memmove+0x2f>
8010468e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104690:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104694:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104697:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
8010469a:	39 d6                	cmp    %edx,%esi
8010469c:	75 f2                	jne    80104690 <memmove+0x40>
}
8010469e:	5b                   	pop    %ebx
8010469f:	5e                   	pop    %esi
801046a0:	5d                   	pop    %ebp
801046a1:	c3                   	ret    
801046a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046b0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801046b3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
801046b4:	eb 9a                	jmp    80104650 <memmove>
801046b6:	8d 76 00             	lea    0x0(%esi),%esi
801046b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046c0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	57                   	push   %edi
801046c4:	56                   	push   %esi
801046c5:	8b 7d 10             	mov    0x10(%ebp),%edi
801046c8:	53                   	push   %ebx
801046c9:	8b 4d 08             	mov    0x8(%ebp),%ecx
801046cc:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
801046cf:	85 ff                	test   %edi,%edi
801046d1:	74 2f                	je     80104702 <strncmp+0x42>
801046d3:	0f b6 01             	movzbl (%ecx),%eax
801046d6:	0f b6 1e             	movzbl (%esi),%ebx
801046d9:	84 c0                	test   %al,%al
801046db:	74 37                	je     80104714 <strncmp+0x54>
801046dd:	38 c3                	cmp    %al,%bl
801046df:	75 33                	jne    80104714 <strncmp+0x54>
801046e1:	01 f7                	add    %esi,%edi
801046e3:	eb 13                	jmp    801046f8 <strncmp+0x38>
801046e5:	8d 76 00             	lea    0x0(%esi),%esi
801046e8:	0f b6 01             	movzbl (%ecx),%eax
801046eb:	84 c0                	test   %al,%al
801046ed:	74 21                	je     80104710 <strncmp+0x50>
801046ef:	0f b6 1a             	movzbl (%edx),%ebx
801046f2:	89 d6                	mov    %edx,%esi
801046f4:	38 d8                	cmp    %bl,%al
801046f6:	75 1c                	jne    80104714 <strncmp+0x54>
    n--, p++, q++;
801046f8:	8d 56 01             	lea    0x1(%esi),%edx
801046fb:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801046fe:	39 fa                	cmp    %edi,%edx
80104700:	75 e6                	jne    801046e8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104702:	5b                   	pop    %ebx
    return 0;
80104703:	31 c0                	xor    %eax,%eax
}
80104705:	5e                   	pop    %esi
80104706:	5f                   	pop    %edi
80104707:	5d                   	pop    %ebp
80104708:	c3                   	ret    
80104709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104710:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104714:	29 d8                	sub    %ebx,%eax
}
80104716:	5b                   	pop    %ebx
80104717:	5e                   	pop    %esi
80104718:	5f                   	pop    %edi
80104719:	5d                   	pop    %ebp
8010471a:	c3                   	ret    
8010471b:	90                   	nop
8010471c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104720 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	56                   	push   %esi
80104724:	53                   	push   %ebx
80104725:	8b 45 08             	mov    0x8(%ebp),%eax
80104728:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010472b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010472e:	89 c2                	mov    %eax,%edx
80104730:	eb 19                	jmp    8010474b <strncpy+0x2b>
80104732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104738:	83 c3 01             	add    $0x1,%ebx
8010473b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010473f:	83 c2 01             	add    $0x1,%edx
80104742:	84 c9                	test   %cl,%cl
80104744:	88 4a ff             	mov    %cl,-0x1(%edx)
80104747:	74 09                	je     80104752 <strncpy+0x32>
80104749:	89 f1                	mov    %esi,%ecx
8010474b:	85 c9                	test   %ecx,%ecx
8010474d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104750:	7f e6                	jg     80104738 <strncpy+0x18>
    ;
  while(n-- > 0)
80104752:	31 c9                	xor    %ecx,%ecx
80104754:	85 f6                	test   %esi,%esi
80104756:	7e 17                	jle    8010476f <strncpy+0x4f>
80104758:	90                   	nop
80104759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104760:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104764:	89 f3                	mov    %esi,%ebx
80104766:	83 c1 01             	add    $0x1,%ecx
80104769:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
8010476b:	85 db                	test   %ebx,%ebx
8010476d:	7f f1                	jg     80104760 <strncpy+0x40>
  return os;
}
8010476f:	5b                   	pop    %ebx
80104770:	5e                   	pop    %esi
80104771:	5d                   	pop    %ebp
80104772:	c3                   	ret    
80104773:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104780 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	56                   	push   %esi
80104784:	53                   	push   %ebx
80104785:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104788:	8b 45 08             	mov    0x8(%ebp),%eax
8010478b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010478e:	85 c9                	test   %ecx,%ecx
80104790:	7e 26                	jle    801047b8 <safestrcpy+0x38>
80104792:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104796:	89 c1                	mov    %eax,%ecx
80104798:	eb 17                	jmp    801047b1 <safestrcpy+0x31>
8010479a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801047a0:	83 c2 01             	add    $0x1,%edx
801047a3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801047a7:	83 c1 01             	add    $0x1,%ecx
801047aa:	84 db                	test   %bl,%bl
801047ac:	88 59 ff             	mov    %bl,-0x1(%ecx)
801047af:	74 04                	je     801047b5 <safestrcpy+0x35>
801047b1:	39 f2                	cmp    %esi,%edx
801047b3:	75 eb                	jne    801047a0 <safestrcpy+0x20>
    ;
  *s = 0;
801047b5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
801047b8:	5b                   	pop    %ebx
801047b9:	5e                   	pop    %esi
801047ba:	5d                   	pop    %ebp
801047bb:	c3                   	ret    
801047bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047c0 <strlen>:

int
strlen(const char *s)
{
801047c0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801047c1:	31 c0                	xor    %eax,%eax
{
801047c3:	89 e5                	mov    %esp,%ebp
801047c5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
801047c8:	80 3a 00             	cmpb   $0x0,(%edx)
801047cb:	74 0c                	je     801047d9 <strlen+0x19>
801047cd:	8d 76 00             	lea    0x0(%esi),%esi
801047d0:	83 c0 01             	add    $0x1,%eax
801047d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801047d7:	75 f7                	jne    801047d0 <strlen+0x10>
    ;
  return n;
}
801047d9:	5d                   	pop    %ebp
801047da:	c3                   	ret    

801047db <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801047db:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801047df:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801047e3:	55                   	push   %ebp
  pushl %ebx
801047e4:	53                   	push   %ebx
  pushl %esi
801047e5:	56                   	push   %esi
  pushl %edi
801047e6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801047e7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801047e9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801047eb:	5f                   	pop    %edi
  popl %esi
801047ec:	5e                   	pop    %esi
  popl %ebx
801047ed:	5b                   	pop    %ebx
  popl %ebp
801047ee:	5d                   	pop    %ebp
  ret
801047ef:	c3                   	ret    

801047f0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801047f0:	55                   	push   %ebp
801047f1:	89 e5                	mov    %esp,%ebp
801047f3:	53                   	push   %ebx
801047f4:	83 ec 04             	sub    $0x4,%esp
801047f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801047fa:	e8 31 f1 ff ff       	call   80103930 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801047ff:	8b 00                	mov    (%eax),%eax
80104801:	39 d8                	cmp    %ebx,%eax
80104803:	76 1b                	jbe    80104820 <fetchint+0x30>
80104805:	8d 53 04             	lea    0x4(%ebx),%edx
80104808:	39 d0                	cmp    %edx,%eax
8010480a:	72 14                	jb     80104820 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010480c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010480f:	8b 13                	mov    (%ebx),%edx
80104811:	89 10                	mov    %edx,(%eax)
  return 0;
80104813:	31 c0                	xor    %eax,%eax
}
80104815:	83 c4 04             	add    $0x4,%esp
80104818:	5b                   	pop    %ebx
80104819:	5d                   	pop    %ebp
8010481a:	c3                   	ret    
8010481b:	90                   	nop
8010481c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104820:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104825:	eb ee                	jmp    80104815 <fetchint+0x25>
80104827:	89 f6                	mov    %esi,%esi
80104829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104830 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	53                   	push   %ebx
80104834:	83 ec 04             	sub    $0x4,%esp
80104837:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010483a:	e8 f1 f0 ff ff       	call   80103930 <myproc>

  if(addr >= curproc->sz)
8010483f:	39 18                	cmp    %ebx,(%eax)
80104841:	76 29                	jbe    8010486c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104843:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104846:	89 da                	mov    %ebx,%edx
80104848:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010484a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010484c:	39 c3                	cmp    %eax,%ebx
8010484e:	73 1c                	jae    8010486c <fetchstr+0x3c>
    if(*s == 0)
80104850:	80 3b 00             	cmpb   $0x0,(%ebx)
80104853:	75 10                	jne    80104865 <fetchstr+0x35>
80104855:	eb 39                	jmp    80104890 <fetchstr+0x60>
80104857:	89 f6                	mov    %esi,%esi
80104859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104860:	80 3a 00             	cmpb   $0x0,(%edx)
80104863:	74 1b                	je     80104880 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104865:	83 c2 01             	add    $0x1,%edx
80104868:	39 d0                	cmp    %edx,%eax
8010486a:	77 f4                	ja     80104860 <fetchstr+0x30>
    return -1;
8010486c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104871:	83 c4 04             	add    $0x4,%esp
80104874:	5b                   	pop    %ebx
80104875:	5d                   	pop    %ebp
80104876:	c3                   	ret    
80104877:	89 f6                	mov    %esi,%esi
80104879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104880:	83 c4 04             	add    $0x4,%esp
80104883:	89 d0                	mov    %edx,%eax
80104885:	29 d8                	sub    %ebx,%eax
80104887:	5b                   	pop    %ebx
80104888:	5d                   	pop    %ebp
80104889:	c3                   	ret    
8010488a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104890:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104892:	eb dd                	jmp    80104871 <fetchstr+0x41>
80104894:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010489a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801048a0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801048a0:	55                   	push   %ebp
801048a1:	89 e5                	mov    %esp,%ebp
801048a3:	56                   	push   %esi
801048a4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801048a5:	e8 86 f0 ff ff       	call   80103930 <myproc>
801048aa:	8b 40 18             	mov    0x18(%eax),%eax
801048ad:	8b 55 08             	mov    0x8(%ebp),%edx
801048b0:	8b 40 44             	mov    0x44(%eax),%eax
801048b3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801048b6:	e8 75 f0 ff ff       	call   80103930 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801048bb:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801048bd:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801048c0:	39 c6                	cmp    %eax,%esi
801048c2:	73 1c                	jae    801048e0 <argint+0x40>
801048c4:	8d 53 08             	lea    0x8(%ebx),%edx
801048c7:	39 d0                	cmp    %edx,%eax
801048c9:	72 15                	jb     801048e0 <argint+0x40>
  *ip = *(int*)(addr);
801048cb:	8b 45 0c             	mov    0xc(%ebp),%eax
801048ce:	8b 53 04             	mov    0x4(%ebx),%edx
801048d1:	89 10                	mov    %edx,(%eax)
  return 0;
801048d3:	31 c0                	xor    %eax,%eax
}
801048d5:	5b                   	pop    %ebx
801048d6:	5e                   	pop    %esi
801048d7:	5d                   	pop    %ebp
801048d8:	c3                   	ret    
801048d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801048e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801048e5:	eb ee                	jmp    801048d5 <argint+0x35>
801048e7:	89 f6                	mov    %esi,%esi
801048e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048f0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801048f0:	55                   	push   %ebp
801048f1:	89 e5                	mov    %esp,%ebp
801048f3:	56                   	push   %esi
801048f4:	53                   	push   %ebx
801048f5:	83 ec 10             	sub    $0x10,%esp
801048f8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801048fb:	e8 30 f0 ff ff       	call   80103930 <myproc>
80104900:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104902:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104905:	83 ec 08             	sub    $0x8,%esp
80104908:	50                   	push   %eax
80104909:	ff 75 08             	pushl  0x8(%ebp)
8010490c:	e8 8f ff ff ff       	call   801048a0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104911:	83 c4 10             	add    $0x10,%esp
80104914:	85 c0                	test   %eax,%eax
80104916:	78 28                	js     80104940 <argptr+0x50>
80104918:	85 db                	test   %ebx,%ebx
8010491a:	78 24                	js     80104940 <argptr+0x50>
8010491c:	8b 16                	mov    (%esi),%edx
8010491e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104921:	39 c2                	cmp    %eax,%edx
80104923:	76 1b                	jbe    80104940 <argptr+0x50>
80104925:	01 c3                	add    %eax,%ebx
80104927:	39 da                	cmp    %ebx,%edx
80104929:	72 15                	jb     80104940 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010492b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010492e:	89 02                	mov    %eax,(%edx)
  return 0;
80104930:	31 c0                	xor    %eax,%eax
}
80104932:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104935:	5b                   	pop    %ebx
80104936:	5e                   	pop    %esi
80104937:	5d                   	pop    %ebp
80104938:	c3                   	ret    
80104939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104940:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104945:	eb eb                	jmp    80104932 <argptr+0x42>
80104947:	89 f6                	mov    %esi,%esi
80104949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104950 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104956:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104959:	50                   	push   %eax
8010495a:	ff 75 08             	pushl  0x8(%ebp)
8010495d:	e8 3e ff ff ff       	call   801048a0 <argint>
80104962:	83 c4 10             	add    $0x10,%esp
80104965:	85 c0                	test   %eax,%eax
80104967:	78 17                	js     80104980 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104969:	83 ec 08             	sub    $0x8,%esp
8010496c:	ff 75 0c             	pushl  0xc(%ebp)
8010496f:	ff 75 f4             	pushl  -0xc(%ebp)
80104972:	e8 b9 fe ff ff       	call   80104830 <fetchstr>
80104977:	83 c4 10             	add    $0x10,%esp
}
8010497a:	c9                   	leave  
8010497b:	c3                   	ret    
8010497c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104980:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104985:	c9                   	leave  
80104986:	c3                   	ret    
80104987:	89 f6                	mov    %esi,%esi
80104989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104990 <syscall>:
[SYS_steal]   sys_steal,
};

void
syscall(void)
{
80104990:	55                   	push   %ebp
80104991:	89 e5                	mov    %esp,%ebp
80104993:	53                   	push   %ebx
80104994:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104997:	e8 94 ef ff ff       	call   80103930 <myproc>
8010499c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010499e:	8b 40 18             	mov    0x18(%eax),%eax
801049a1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801049a4:	8d 50 ff             	lea    -0x1(%eax),%edx
801049a7:	83 fa 16             	cmp    $0x16,%edx
801049aa:	77 1c                	ja     801049c8 <syscall+0x38>
801049ac:	8b 14 85 40 77 10 80 	mov    -0x7fef88c0(,%eax,4),%edx
801049b3:	85 d2                	test   %edx,%edx
801049b5:	74 11                	je     801049c8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
801049b7:	ff d2                	call   *%edx
801049b9:	8b 53 18             	mov    0x18(%ebx),%edx
801049bc:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801049bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049c2:	c9                   	leave  
801049c3:	c3                   	ret    
801049c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
801049c8:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801049c9:	8d 43 70             	lea    0x70(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801049cc:	50                   	push   %eax
801049cd:	ff 73 10             	pushl  0x10(%ebx)
801049d0:	68 11 77 10 80       	push   $0x80107711
801049d5:	e8 36 bd ff ff       	call   80100710 <cprintf>
    curproc->tf->eax = -1;
801049da:	8b 43 18             	mov    0x18(%ebx),%eax
801049dd:	83 c4 10             	add    $0x10,%esp
801049e0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801049e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049ea:	c9                   	leave  
801049eb:	c3                   	ret    
801049ec:	66 90                	xchg   %ax,%ax
801049ee:	66 90                	xchg   %ax,%ax

801049f0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801049f0:	55                   	push   %ebp
801049f1:	89 e5                	mov    %esp,%ebp
801049f3:	57                   	push   %edi
801049f4:	56                   	push   %esi
801049f5:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801049f6:	8d 75 da             	lea    -0x26(%ebp),%esi
{
801049f9:	83 ec 34             	sub    $0x34,%esp
801049fc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801049ff:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104a02:	56                   	push   %esi
80104a03:	50                   	push   %eax
{
80104a04:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104a07:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104a0a:	e8 41 d6 ff ff       	call   80102050 <nameiparent>
80104a0f:	83 c4 10             	add    $0x10,%esp
80104a12:	85 c0                	test   %eax,%eax
80104a14:	0f 84 46 01 00 00    	je     80104b60 <create+0x170>
    return 0;
  ilock(dp);
80104a1a:	83 ec 0c             	sub    $0xc,%esp
80104a1d:	89 c3                	mov    %eax,%ebx
80104a1f:	50                   	push   %eax
80104a20:	e8 6b cd ff ff       	call   80101790 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104a25:	83 c4 0c             	add    $0xc,%esp
80104a28:	6a 00                	push   $0x0
80104a2a:	56                   	push   %esi
80104a2b:	53                   	push   %ebx
80104a2c:	e8 cf d2 ff ff       	call   80101d00 <dirlookup>
80104a31:	83 c4 10             	add    $0x10,%esp
80104a34:	85 c0                	test   %eax,%eax
80104a36:	89 c7                	mov    %eax,%edi
80104a38:	74 36                	je     80104a70 <create+0x80>
    iunlockput(dp);
80104a3a:	83 ec 0c             	sub    $0xc,%esp
80104a3d:	53                   	push   %ebx
80104a3e:	e8 dd cf ff ff       	call   80101a20 <iunlockput>
    ilock(ip);
80104a43:	89 3c 24             	mov    %edi,(%esp)
80104a46:	e8 45 cd ff ff       	call   80101790 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104a4b:	83 c4 10             	add    $0x10,%esp
80104a4e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104a53:	0f 85 97 00 00 00    	jne    80104af0 <create+0x100>
80104a59:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104a5e:	0f 85 8c 00 00 00    	jne    80104af0 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104a64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a67:	89 f8                	mov    %edi,%eax
80104a69:	5b                   	pop    %ebx
80104a6a:	5e                   	pop    %esi
80104a6b:	5f                   	pop    %edi
80104a6c:	5d                   	pop    %ebp
80104a6d:	c3                   	ret    
80104a6e:	66 90                	xchg   %ax,%ax
  if((ip = ialloc(dp->dev, type)) == 0)
80104a70:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104a74:	83 ec 08             	sub    $0x8,%esp
80104a77:	50                   	push   %eax
80104a78:	ff 33                	pushl  (%ebx)
80104a7a:	e8 a1 cb ff ff       	call   80101620 <ialloc>
80104a7f:	83 c4 10             	add    $0x10,%esp
80104a82:	85 c0                	test   %eax,%eax
80104a84:	89 c7                	mov    %eax,%edi
80104a86:	0f 84 e8 00 00 00    	je     80104b74 <create+0x184>
  ilock(ip);
80104a8c:	83 ec 0c             	sub    $0xc,%esp
80104a8f:	50                   	push   %eax
80104a90:	e8 fb cc ff ff       	call   80101790 <ilock>
  ip->major = major;
80104a95:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104a99:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104a9d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104aa1:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104aa5:	b8 01 00 00 00       	mov    $0x1,%eax
80104aaa:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104aae:	89 3c 24             	mov    %edi,(%esp)
80104ab1:	e8 2a cc ff ff       	call   801016e0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104ab6:	83 c4 10             	add    $0x10,%esp
80104ab9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104abe:	74 50                	je     80104b10 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104ac0:	83 ec 04             	sub    $0x4,%esp
80104ac3:	ff 77 04             	pushl  0x4(%edi)
80104ac6:	56                   	push   %esi
80104ac7:	53                   	push   %ebx
80104ac8:	e8 a3 d4 ff ff       	call   80101f70 <dirlink>
80104acd:	83 c4 10             	add    $0x10,%esp
80104ad0:	85 c0                	test   %eax,%eax
80104ad2:	0f 88 8f 00 00 00    	js     80104b67 <create+0x177>
  iunlockput(dp);
80104ad8:	83 ec 0c             	sub    $0xc,%esp
80104adb:	53                   	push   %ebx
80104adc:	e8 3f cf ff ff       	call   80101a20 <iunlockput>
  return ip;
80104ae1:	83 c4 10             	add    $0x10,%esp
}
80104ae4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ae7:	89 f8                	mov    %edi,%eax
80104ae9:	5b                   	pop    %ebx
80104aea:	5e                   	pop    %esi
80104aeb:	5f                   	pop    %edi
80104aec:	5d                   	pop    %ebp
80104aed:	c3                   	ret    
80104aee:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104af0:	83 ec 0c             	sub    $0xc,%esp
80104af3:	57                   	push   %edi
    return 0;
80104af4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104af6:	e8 25 cf ff ff       	call   80101a20 <iunlockput>
    return 0;
80104afb:	83 c4 10             	add    $0x10,%esp
}
80104afe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b01:	89 f8                	mov    %edi,%eax
80104b03:	5b                   	pop    %ebx
80104b04:	5e                   	pop    %esi
80104b05:	5f                   	pop    %edi
80104b06:	5d                   	pop    %ebp
80104b07:	c3                   	ret    
80104b08:	90                   	nop
80104b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104b10:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104b15:	83 ec 0c             	sub    $0xc,%esp
80104b18:	53                   	push   %ebx
80104b19:	e8 c2 cb ff ff       	call   801016e0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104b1e:	83 c4 0c             	add    $0xc,%esp
80104b21:	ff 77 04             	pushl  0x4(%edi)
80104b24:	68 bc 77 10 80       	push   $0x801077bc
80104b29:	57                   	push   %edi
80104b2a:	e8 41 d4 ff ff       	call   80101f70 <dirlink>
80104b2f:	83 c4 10             	add    $0x10,%esp
80104b32:	85 c0                	test   %eax,%eax
80104b34:	78 1c                	js     80104b52 <create+0x162>
80104b36:	83 ec 04             	sub    $0x4,%esp
80104b39:	ff 73 04             	pushl  0x4(%ebx)
80104b3c:	68 bb 77 10 80       	push   $0x801077bb
80104b41:	57                   	push   %edi
80104b42:	e8 29 d4 ff ff       	call   80101f70 <dirlink>
80104b47:	83 c4 10             	add    $0x10,%esp
80104b4a:	85 c0                	test   %eax,%eax
80104b4c:	0f 89 6e ff ff ff    	jns    80104ac0 <create+0xd0>
      panic("create dots");
80104b52:	83 ec 0c             	sub    $0xc,%esp
80104b55:	68 af 77 10 80       	push   $0x801077af
80104b5a:	e8 e1 b8 ff ff       	call   80100440 <panic>
80104b5f:	90                   	nop
    return 0;
80104b60:	31 ff                	xor    %edi,%edi
80104b62:	e9 fd fe ff ff       	jmp    80104a64 <create+0x74>
    panic("create: dirlink");
80104b67:	83 ec 0c             	sub    $0xc,%esp
80104b6a:	68 be 77 10 80       	push   $0x801077be
80104b6f:	e8 cc b8 ff ff       	call   80100440 <panic>
    panic("create: ialloc");
80104b74:	83 ec 0c             	sub    $0xc,%esp
80104b77:	68 a0 77 10 80       	push   $0x801077a0
80104b7c:	e8 bf b8 ff ff       	call   80100440 <panic>
80104b81:	eb 0d                	jmp    80104b90 <argfd.constprop.0>
80104b83:	90                   	nop
80104b84:	90                   	nop
80104b85:	90                   	nop
80104b86:	90                   	nop
80104b87:	90                   	nop
80104b88:	90                   	nop
80104b89:	90                   	nop
80104b8a:	90                   	nop
80104b8b:	90                   	nop
80104b8c:	90                   	nop
80104b8d:	90                   	nop
80104b8e:	90                   	nop
80104b8f:	90                   	nop

80104b90 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104b90:	55                   	push   %ebp
80104b91:	89 e5                	mov    %esp,%ebp
80104b93:	56                   	push   %esi
80104b94:	53                   	push   %ebx
80104b95:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104b97:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104b9a:	89 d6                	mov    %edx,%esi
80104b9c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104b9f:	50                   	push   %eax
80104ba0:	6a 00                	push   $0x0
80104ba2:	e8 f9 fc ff ff       	call   801048a0 <argint>
80104ba7:	83 c4 10             	add    $0x10,%esp
80104baa:	85 c0                	test   %eax,%eax
80104bac:	78 2a                	js     80104bd8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104bae:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104bb2:	77 24                	ja     80104bd8 <argfd.constprop.0+0x48>
80104bb4:	e8 77 ed ff ff       	call   80103930 <myproc>
80104bb9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104bbc:	8b 44 90 2c          	mov    0x2c(%eax,%edx,4),%eax
80104bc0:	85 c0                	test   %eax,%eax
80104bc2:	74 14                	je     80104bd8 <argfd.constprop.0+0x48>
  if(pfd)
80104bc4:	85 db                	test   %ebx,%ebx
80104bc6:	74 02                	je     80104bca <argfd.constprop.0+0x3a>
    *pfd = fd;
80104bc8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104bca:	89 06                	mov    %eax,(%esi)
  return 0;
80104bcc:	31 c0                	xor    %eax,%eax
}
80104bce:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104bd1:	5b                   	pop    %ebx
80104bd2:	5e                   	pop    %esi
80104bd3:	5d                   	pop    %ebp
80104bd4:	c3                   	ret    
80104bd5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104bd8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bdd:	eb ef                	jmp    80104bce <argfd.constprop.0+0x3e>
80104bdf:	90                   	nop

80104be0 <sys_dup>:
{
80104be0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104be1:	31 c0                	xor    %eax,%eax
{
80104be3:	89 e5                	mov    %esp,%ebp
80104be5:	56                   	push   %esi
80104be6:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104be7:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104bea:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104bed:	e8 9e ff ff ff       	call   80104b90 <argfd.constprop.0>
80104bf2:	85 c0                	test   %eax,%eax
80104bf4:	78 42                	js     80104c38 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80104bf6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104bf9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104bfb:	e8 30 ed ff ff       	call   80103930 <myproc>
80104c00:	eb 0e                	jmp    80104c10 <sys_dup+0x30>
80104c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104c08:	83 c3 01             	add    $0x1,%ebx
80104c0b:	83 fb 10             	cmp    $0x10,%ebx
80104c0e:	74 28                	je     80104c38 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104c10:	8b 54 98 2c          	mov    0x2c(%eax,%ebx,4),%edx
80104c14:	85 d2                	test   %edx,%edx
80104c16:	75 f0                	jne    80104c08 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104c18:	89 74 98 2c          	mov    %esi,0x2c(%eax,%ebx,4)
  filedup(f);
80104c1c:	83 ec 0c             	sub    $0xc,%esp
80104c1f:	ff 75 f4             	pushl  -0xc(%ebp)
80104c22:	e8 79 c2 ff ff       	call   80100ea0 <filedup>
  return fd;
80104c27:	83 c4 10             	add    $0x10,%esp
}
80104c2a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c2d:	89 d8                	mov    %ebx,%eax
80104c2f:	5b                   	pop    %ebx
80104c30:	5e                   	pop    %esi
80104c31:	5d                   	pop    %ebp
80104c32:	c3                   	ret    
80104c33:	90                   	nop
80104c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c38:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104c3b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104c40:	89 d8                	mov    %ebx,%eax
80104c42:	5b                   	pop    %ebx
80104c43:	5e                   	pop    %esi
80104c44:	5d                   	pop    %ebp
80104c45:	c3                   	ret    
80104c46:	8d 76 00             	lea    0x0(%esi),%esi
80104c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c50 <sys_read>:
{
80104c50:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c51:	31 c0                	xor    %eax,%eax
{
80104c53:	89 e5                	mov    %esp,%ebp
80104c55:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c58:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104c5b:	e8 30 ff ff ff       	call   80104b90 <argfd.constprop.0>
80104c60:	85 c0                	test   %eax,%eax
80104c62:	78 4c                	js     80104cb0 <sys_read+0x60>
80104c64:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c67:	83 ec 08             	sub    $0x8,%esp
80104c6a:	50                   	push   %eax
80104c6b:	6a 02                	push   $0x2
80104c6d:	e8 2e fc ff ff       	call   801048a0 <argint>
80104c72:	83 c4 10             	add    $0x10,%esp
80104c75:	85 c0                	test   %eax,%eax
80104c77:	78 37                	js     80104cb0 <sys_read+0x60>
80104c79:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c7c:	83 ec 04             	sub    $0x4,%esp
80104c7f:	ff 75 f0             	pushl  -0x10(%ebp)
80104c82:	50                   	push   %eax
80104c83:	6a 01                	push   $0x1
80104c85:	e8 66 fc ff ff       	call   801048f0 <argptr>
80104c8a:	83 c4 10             	add    $0x10,%esp
80104c8d:	85 c0                	test   %eax,%eax
80104c8f:	78 1f                	js     80104cb0 <sys_read+0x60>
  return fileread(f, p, n);
80104c91:	83 ec 04             	sub    $0x4,%esp
80104c94:	ff 75 f0             	pushl  -0x10(%ebp)
80104c97:	ff 75 f4             	pushl  -0xc(%ebp)
80104c9a:	ff 75 ec             	pushl  -0x14(%ebp)
80104c9d:	e8 6e c3 ff ff       	call   80101010 <fileread>
80104ca2:	83 c4 10             	add    $0x10,%esp
}
80104ca5:	c9                   	leave  
80104ca6:	c3                   	ret    
80104ca7:	89 f6                	mov    %esi,%esi
80104ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104cb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cb5:	c9                   	leave  
80104cb6:	c3                   	ret    
80104cb7:	89 f6                	mov    %esi,%esi
80104cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cc0 <sys_steal>:
{
80104cc0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104cc1:	31 c0                	xor    %eax,%eax
{
80104cc3:	89 e5                	mov    %esp,%ebp
80104cc5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0)
80104cc8:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104ccb:	e8 c0 fe ff ff       	call   80104b90 <argfd.constprop.0>
80104cd0:	85 c0                	test   %eax,%eax
80104cd2:	78 14                	js     80104ce8 <sys_steal+0x28>
  return filesteal(f);
80104cd4:	83 ec 0c             	sub    $0xc,%esp
80104cd7:	ff 75 f4             	pushl  -0xc(%ebp)
80104cda:	e8 c1 c3 ff ff       	call   801010a0 <filesteal>
80104cdf:	83 c4 10             	add    $0x10,%esp
}
80104ce2:	c9                   	leave  
80104ce3:	c3                   	ret    
80104ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104ce8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ced:	c9                   	leave  
80104cee:	c3                   	ret    
80104cef:	90                   	nop

80104cf0 <sys_write>:
{
80104cf0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104cf1:	31 c0                	xor    %eax,%eax
{
80104cf3:	89 e5                	mov    %esp,%ebp
80104cf5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104cf8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104cfb:	e8 90 fe ff ff       	call   80104b90 <argfd.constprop.0>
80104d00:	85 c0                	test   %eax,%eax
80104d02:	78 4c                	js     80104d50 <sys_write+0x60>
80104d04:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d07:	83 ec 08             	sub    $0x8,%esp
80104d0a:	50                   	push   %eax
80104d0b:	6a 02                	push   $0x2
80104d0d:	e8 8e fb ff ff       	call   801048a0 <argint>
80104d12:	83 c4 10             	add    $0x10,%esp
80104d15:	85 c0                	test   %eax,%eax
80104d17:	78 37                	js     80104d50 <sys_write+0x60>
80104d19:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d1c:	83 ec 04             	sub    $0x4,%esp
80104d1f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d22:	50                   	push   %eax
80104d23:	6a 01                	push   $0x1
80104d25:	e8 c6 fb ff ff       	call   801048f0 <argptr>
80104d2a:	83 c4 10             	add    $0x10,%esp
80104d2d:	85 c0                	test   %eax,%eax
80104d2f:	78 1f                	js     80104d50 <sys_write+0x60>
  return filewrite(f, p, n);
80104d31:	83 ec 04             	sub    $0x4,%esp
80104d34:	ff 75 f0             	pushl  -0x10(%ebp)
80104d37:	ff 75 f4             	pushl  -0xc(%ebp)
80104d3a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d3d:	e8 be c3 ff ff       	call   80101100 <filewrite>
80104d42:	83 c4 10             	add    $0x10,%esp
}
80104d45:	c9                   	leave  
80104d46:	c3                   	ret    
80104d47:	89 f6                	mov    %esi,%esi
80104d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104d50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d55:	c9                   	leave  
80104d56:	c3                   	ret    
80104d57:	89 f6                	mov    %esi,%esi
80104d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d60 <sys_close>:
{
80104d60:	55                   	push   %ebp
80104d61:	89 e5                	mov    %esp,%ebp
80104d63:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104d66:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104d69:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d6c:	e8 1f fe ff ff       	call   80104b90 <argfd.constprop.0>
80104d71:	85 c0                	test   %eax,%eax
80104d73:	78 2b                	js     80104da0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104d75:	e8 b6 eb ff ff       	call   80103930 <myproc>
80104d7a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104d7d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104d80:	c7 44 90 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edx,4)
80104d87:	00 
  fileclose(f);
80104d88:	ff 75 f4             	pushl  -0xc(%ebp)
80104d8b:	e8 60 c1 ff ff       	call   80100ef0 <fileclose>
  return 0;
80104d90:	83 c4 10             	add    $0x10,%esp
80104d93:	31 c0                	xor    %eax,%eax
}
80104d95:	c9                   	leave  
80104d96:	c3                   	ret    
80104d97:	89 f6                	mov    %esi,%esi
80104d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104da0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104da5:	c9                   	leave  
80104da6:	c3                   	ret    
80104da7:	89 f6                	mov    %esi,%esi
80104da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104db0 <sys_fstat>:
{
80104db0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104db1:	31 c0                	xor    %eax,%eax
{
80104db3:	89 e5                	mov    %esp,%ebp
80104db5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104db8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104dbb:	e8 d0 fd ff ff       	call   80104b90 <argfd.constprop.0>
80104dc0:	85 c0                	test   %eax,%eax
80104dc2:	78 2c                	js     80104df0 <sys_fstat+0x40>
80104dc4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dc7:	83 ec 04             	sub    $0x4,%esp
80104dca:	6a 14                	push   $0x14
80104dcc:	50                   	push   %eax
80104dcd:	6a 01                	push   $0x1
80104dcf:	e8 1c fb ff ff       	call   801048f0 <argptr>
80104dd4:	83 c4 10             	add    $0x10,%esp
80104dd7:	85 c0                	test   %eax,%eax
80104dd9:	78 15                	js     80104df0 <sys_fstat+0x40>
  return filestat(f, st);
80104ddb:	83 ec 08             	sub    $0x8,%esp
80104dde:	ff 75 f4             	pushl  -0xc(%ebp)
80104de1:	ff 75 f0             	pushl  -0x10(%ebp)
80104de4:	e8 d7 c1 ff ff       	call   80100fc0 <filestat>
80104de9:	83 c4 10             	add    $0x10,%esp
}
80104dec:	c9                   	leave  
80104ded:	c3                   	ret    
80104dee:	66 90                	xchg   %ax,%ax
    return -1;
80104df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104df5:	c9                   	leave  
80104df6:	c3                   	ret    
80104df7:	89 f6                	mov    %esi,%esi
80104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e00 <sys_link>:
{
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	57                   	push   %edi
80104e04:	56                   	push   %esi
80104e05:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e06:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104e09:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e0c:	50                   	push   %eax
80104e0d:	6a 00                	push   $0x0
80104e0f:	e8 3c fb ff ff       	call   80104950 <argstr>
80104e14:	83 c4 10             	add    $0x10,%esp
80104e17:	85 c0                	test   %eax,%eax
80104e19:	0f 88 fb 00 00 00    	js     80104f1a <sys_link+0x11a>
80104e1f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104e22:	83 ec 08             	sub    $0x8,%esp
80104e25:	50                   	push   %eax
80104e26:	6a 01                	push   $0x1
80104e28:	e8 23 fb ff ff       	call   80104950 <argstr>
80104e2d:	83 c4 10             	add    $0x10,%esp
80104e30:	85 c0                	test   %eax,%eax
80104e32:	0f 88 e2 00 00 00    	js     80104f1a <sys_link+0x11a>
  begin_op();
80104e38:	e8 b3 de ff ff       	call   80102cf0 <begin_op>
  if((ip = namei(old)) == 0){
80104e3d:	83 ec 0c             	sub    $0xc,%esp
80104e40:	ff 75 d4             	pushl  -0x2c(%ebp)
80104e43:	e8 e8 d1 ff ff       	call   80102030 <namei>
80104e48:	83 c4 10             	add    $0x10,%esp
80104e4b:	85 c0                	test   %eax,%eax
80104e4d:	89 c3                	mov    %eax,%ebx
80104e4f:	0f 84 ea 00 00 00    	je     80104f3f <sys_link+0x13f>
  ilock(ip);
80104e55:	83 ec 0c             	sub    $0xc,%esp
80104e58:	50                   	push   %eax
80104e59:	e8 32 c9 ff ff       	call   80101790 <ilock>
  if(ip->type == T_DIR){
80104e5e:	83 c4 10             	add    $0x10,%esp
80104e61:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104e66:	0f 84 bb 00 00 00    	je     80104f27 <sys_link+0x127>
  ip->nlink++;
80104e6c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104e71:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80104e74:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104e77:	53                   	push   %ebx
80104e78:	e8 63 c8 ff ff       	call   801016e0 <iupdate>
  iunlock(ip);
80104e7d:	89 1c 24             	mov    %ebx,(%esp)
80104e80:	e8 eb c9 ff ff       	call   80101870 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104e85:	58                   	pop    %eax
80104e86:	5a                   	pop    %edx
80104e87:	57                   	push   %edi
80104e88:	ff 75 d0             	pushl  -0x30(%ebp)
80104e8b:	e8 c0 d1 ff ff       	call   80102050 <nameiparent>
80104e90:	83 c4 10             	add    $0x10,%esp
80104e93:	85 c0                	test   %eax,%eax
80104e95:	89 c6                	mov    %eax,%esi
80104e97:	74 5b                	je     80104ef4 <sys_link+0xf4>
  ilock(dp);
80104e99:	83 ec 0c             	sub    $0xc,%esp
80104e9c:	50                   	push   %eax
80104e9d:	e8 ee c8 ff ff       	call   80101790 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104ea2:	83 c4 10             	add    $0x10,%esp
80104ea5:	8b 03                	mov    (%ebx),%eax
80104ea7:	39 06                	cmp    %eax,(%esi)
80104ea9:	75 3d                	jne    80104ee8 <sys_link+0xe8>
80104eab:	83 ec 04             	sub    $0x4,%esp
80104eae:	ff 73 04             	pushl  0x4(%ebx)
80104eb1:	57                   	push   %edi
80104eb2:	56                   	push   %esi
80104eb3:	e8 b8 d0 ff ff       	call   80101f70 <dirlink>
80104eb8:	83 c4 10             	add    $0x10,%esp
80104ebb:	85 c0                	test   %eax,%eax
80104ebd:	78 29                	js     80104ee8 <sys_link+0xe8>
  iunlockput(dp);
80104ebf:	83 ec 0c             	sub    $0xc,%esp
80104ec2:	56                   	push   %esi
80104ec3:	e8 58 cb ff ff       	call   80101a20 <iunlockput>
  iput(ip);
80104ec8:	89 1c 24             	mov    %ebx,(%esp)
80104ecb:	e8 f0 c9 ff ff       	call   801018c0 <iput>
  end_op();
80104ed0:	e8 8b de ff ff       	call   80102d60 <end_op>
  return 0;
80104ed5:	83 c4 10             	add    $0x10,%esp
80104ed8:	31 c0                	xor    %eax,%eax
}
80104eda:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104edd:	5b                   	pop    %ebx
80104ede:	5e                   	pop    %esi
80104edf:	5f                   	pop    %edi
80104ee0:	5d                   	pop    %ebp
80104ee1:	c3                   	ret    
80104ee2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104ee8:	83 ec 0c             	sub    $0xc,%esp
80104eeb:	56                   	push   %esi
80104eec:	e8 2f cb ff ff       	call   80101a20 <iunlockput>
    goto bad;
80104ef1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104ef4:	83 ec 0c             	sub    $0xc,%esp
80104ef7:	53                   	push   %ebx
80104ef8:	e8 93 c8 ff ff       	call   80101790 <ilock>
  ip->nlink--;
80104efd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f02:	89 1c 24             	mov    %ebx,(%esp)
80104f05:	e8 d6 c7 ff ff       	call   801016e0 <iupdate>
  iunlockput(ip);
80104f0a:	89 1c 24             	mov    %ebx,(%esp)
80104f0d:	e8 0e cb ff ff       	call   80101a20 <iunlockput>
  end_op();
80104f12:	e8 49 de ff ff       	call   80102d60 <end_op>
  return -1;
80104f17:	83 c4 10             	add    $0x10,%esp
}
80104f1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104f1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f22:	5b                   	pop    %ebx
80104f23:	5e                   	pop    %esi
80104f24:	5f                   	pop    %edi
80104f25:	5d                   	pop    %ebp
80104f26:	c3                   	ret    
    iunlockput(ip);
80104f27:	83 ec 0c             	sub    $0xc,%esp
80104f2a:	53                   	push   %ebx
80104f2b:	e8 f0 ca ff ff       	call   80101a20 <iunlockput>
    end_op();
80104f30:	e8 2b de ff ff       	call   80102d60 <end_op>
    return -1;
80104f35:	83 c4 10             	add    $0x10,%esp
80104f38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f3d:	eb 9b                	jmp    80104eda <sys_link+0xda>
    end_op();
80104f3f:	e8 1c de ff ff       	call   80102d60 <end_op>
    return -1;
80104f44:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f49:	eb 8f                	jmp    80104eda <sys_link+0xda>
80104f4b:	90                   	nop
80104f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f50 <sys_unlink>:
{
80104f50:	55                   	push   %ebp
80104f51:	89 e5                	mov    %esp,%ebp
80104f53:	57                   	push   %edi
80104f54:	56                   	push   %esi
80104f55:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80104f56:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80104f59:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
80104f5c:	50                   	push   %eax
80104f5d:	6a 00                	push   $0x0
80104f5f:	e8 ec f9 ff ff       	call   80104950 <argstr>
80104f64:	83 c4 10             	add    $0x10,%esp
80104f67:	85 c0                	test   %eax,%eax
80104f69:	0f 88 77 01 00 00    	js     801050e6 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
80104f6f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80104f72:	e8 79 dd ff ff       	call   80102cf0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104f77:	83 ec 08             	sub    $0x8,%esp
80104f7a:	53                   	push   %ebx
80104f7b:	ff 75 c0             	pushl  -0x40(%ebp)
80104f7e:	e8 cd d0 ff ff       	call   80102050 <nameiparent>
80104f83:	83 c4 10             	add    $0x10,%esp
80104f86:	85 c0                	test   %eax,%eax
80104f88:	89 c6                	mov    %eax,%esi
80104f8a:	0f 84 60 01 00 00    	je     801050f0 <sys_unlink+0x1a0>
  ilock(dp);
80104f90:	83 ec 0c             	sub    $0xc,%esp
80104f93:	50                   	push   %eax
80104f94:	e8 f7 c7 ff ff       	call   80101790 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104f99:	58                   	pop    %eax
80104f9a:	5a                   	pop    %edx
80104f9b:	68 bc 77 10 80       	push   $0x801077bc
80104fa0:	53                   	push   %ebx
80104fa1:	e8 3a cd ff ff       	call   80101ce0 <namecmp>
80104fa6:	83 c4 10             	add    $0x10,%esp
80104fa9:	85 c0                	test   %eax,%eax
80104fab:	0f 84 03 01 00 00    	je     801050b4 <sys_unlink+0x164>
80104fb1:	83 ec 08             	sub    $0x8,%esp
80104fb4:	68 bb 77 10 80       	push   $0x801077bb
80104fb9:	53                   	push   %ebx
80104fba:	e8 21 cd ff ff       	call   80101ce0 <namecmp>
80104fbf:	83 c4 10             	add    $0x10,%esp
80104fc2:	85 c0                	test   %eax,%eax
80104fc4:	0f 84 ea 00 00 00    	je     801050b4 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
80104fca:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104fcd:	83 ec 04             	sub    $0x4,%esp
80104fd0:	50                   	push   %eax
80104fd1:	53                   	push   %ebx
80104fd2:	56                   	push   %esi
80104fd3:	e8 28 cd ff ff       	call   80101d00 <dirlookup>
80104fd8:	83 c4 10             	add    $0x10,%esp
80104fdb:	85 c0                	test   %eax,%eax
80104fdd:	89 c3                	mov    %eax,%ebx
80104fdf:	0f 84 cf 00 00 00    	je     801050b4 <sys_unlink+0x164>
  ilock(ip);
80104fe5:	83 ec 0c             	sub    $0xc,%esp
80104fe8:	50                   	push   %eax
80104fe9:	e8 a2 c7 ff ff       	call   80101790 <ilock>
  if(ip->nlink < 1)
80104fee:	83 c4 10             	add    $0x10,%esp
80104ff1:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104ff6:	0f 8e 10 01 00 00    	jle    8010510c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80104ffc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105001:	74 6d                	je     80105070 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105003:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105006:	83 ec 04             	sub    $0x4,%esp
80105009:	6a 10                	push   $0x10
8010500b:	6a 00                	push   $0x0
8010500d:	50                   	push   %eax
8010500e:	e8 8d f5 ff ff       	call   801045a0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105013:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105016:	6a 10                	push   $0x10
80105018:	ff 75 c4             	pushl  -0x3c(%ebp)
8010501b:	50                   	push   %eax
8010501c:	56                   	push   %esi
8010501d:	e8 8e cb ff ff       	call   80101bb0 <writei>
80105022:	83 c4 20             	add    $0x20,%esp
80105025:	83 f8 10             	cmp    $0x10,%eax
80105028:	0f 85 eb 00 00 00    	jne    80105119 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
8010502e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105033:	0f 84 97 00 00 00    	je     801050d0 <sys_unlink+0x180>
  iunlockput(dp);
80105039:	83 ec 0c             	sub    $0xc,%esp
8010503c:	56                   	push   %esi
8010503d:	e8 de c9 ff ff       	call   80101a20 <iunlockput>
  ip->nlink--;
80105042:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105047:	89 1c 24             	mov    %ebx,(%esp)
8010504a:	e8 91 c6 ff ff       	call   801016e0 <iupdate>
  iunlockput(ip);
8010504f:	89 1c 24             	mov    %ebx,(%esp)
80105052:	e8 c9 c9 ff ff       	call   80101a20 <iunlockput>
  end_op();
80105057:	e8 04 dd ff ff       	call   80102d60 <end_op>
  return 0;
8010505c:	83 c4 10             	add    $0x10,%esp
8010505f:	31 c0                	xor    %eax,%eax
}
80105061:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105064:	5b                   	pop    %ebx
80105065:	5e                   	pop    %esi
80105066:	5f                   	pop    %edi
80105067:	5d                   	pop    %ebp
80105068:	c3                   	ret    
80105069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105070:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105074:	76 8d                	jbe    80105003 <sys_unlink+0xb3>
80105076:	bf 20 00 00 00       	mov    $0x20,%edi
8010507b:	eb 0f                	jmp    8010508c <sys_unlink+0x13c>
8010507d:	8d 76 00             	lea    0x0(%esi),%esi
80105080:	83 c7 10             	add    $0x10,%edi
80105083:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105086:	0f 83 77 ff ff ff    	jae    80105003 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010508c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010508f:	6a 10                	push   $0x10
80105091:	57                   	push   %edi
80105092:	50                   	push   %eax
80105093:	53                   	push   %ebx
80105094:	e8 d7 c9 ff ff       	call   80101a70 <readi>
80105099:	83 c4 10             	add    $0x10,%esp
8010509c:	83 f8 10             	cmp    $0x10,%eax
8010509f:	75 5e                	jne    801050ff <sys_unlink+0x1af>
    if(de.inum != 0)
801050a1:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801050a6:	74 d8                	je     80105080 <sys_unlink+0x130>
    iunlockput(ip);
801050a8:	83 ec 0c             	sub    $0xc,%esp
801050ab:	53                   	push   %ebx
801050ac:	e8 6f c9 ff ff       	call   80101a20 <iunlockput>
    goto bad;
801050b1:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
801050b4:	83 ec 0c             	sub    $0xc,%esp
801050b7:	56                   	push   %esi
801050b8:	e8 63 c9 ff ff       	call   80101a20 <iunlockput>
  end_op();
801050bd:	e8 9e dc ff ff       	call   80102d60 <end_op>
  return -1;
801050c2:	83 c4 10             	add    $0x10,%esp
801050c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050ca:	eb 95                	jmp    80105061 <sys_unlink+0x111>
801050cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
801050d0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801050d5:	83 ec 0c             	sub    $0xc,%esp
801050d8:	56                   	push   %esi
801050d9:	e8 02 c6 ff ff       	call   801016e0 <iupdate>
801050de:	83 c4 10             	add    $0x10,%esp
801050e1:	e9 53 ff ff ff       	jmp    80105039 <sys_unlink+0xe9>
    return -1;
801050e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050eb:	e9 71 ff ff ff       	jmp    80105061 <sys_unlink+0x111>
    end_op();
801050f0:	e8 6b dc ff ff       	call   80102d60 <end_op>
    return -1;
801050f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050fa:	e9 62 ff ff ff       	jmp    80105061 <sys_unlink+0x111>
      panic("isdirempty: readi");
801050ff:	83 ec 0c             	sub    $0xc,%esp
80105102:	68 e0 77 10 80       	push   $0x801077e0
80105107:	e8 34 b3 ff ff       	call   80100440 <panic>
    panic("unlink: nlink < 1");
8010510c:	83 ec 0c             	sub    $0xc,%esp
8010510f:	68 ce 77 10 80       	push   $0x801077ce
80105114:	e8 27 b3 ff ff       	call   80100440 <panic>
    panic("unlink: writei");
80105119:	83 ec 0c             	sub    $0xc,%esp
8010511c:	68 f2 77 10 80       	push   $0x801077f2
80105121:	e8 1a b3 ff ff       	call   80100440 <panic>
80105126:	8d 76 00             	lea    0x0(%esi),%esi
80105129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105130 <sys_open>:

int
sys_open(void)
{
80105130:	55                   	push   %ebp
80105131:	89 e5                	mov    %esp,%ebp
80105133:	57                   	push   %edi
80105134:	56                   	push   %esi
80105135:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105136:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105139:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010513c:	50                   	push   %eax
8010513d:	6a 00                	push   $0x0
8010513f:	e8 0c f8 ff ff       	call   80104950 <argstr>
80105144:	83 c4 10             	add    $0x10,%esp
80105147:	85 c0                	test   %eax,%eax
80105149:	0f 88 1d 01 00 00    	js     8010526c <sys_open+0x13c>
8010514f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105152:	83 ec 08             	sub    $0x8,%esp
80105155:	50                   	push   %eax
80105156:	6a 01                	push   $0x1
80105158:	e8 43 f7 ff ff       	call   801048a0 <argint>
8010515d:	83 c4 10             	add    $0x10,%esp
80105160:	85 c0                	test   %eax,%eax
80105162:	0f 88 04 01 00 00    	js     8010526c <sys_open+0x13c>
    return -1;

  begin_op();
80105168:	e8 83 db ff ff       	call   80102cf0 <begin_op>

  if(omode & O_CREATE){
8010516d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105171:	0f 85 a9 00 00 00    	jne    80105220 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105177:	83 ec 0c             	sub    $0xc,%esp
8010517a:	ff 75 e0             	pushl  -0x20(%ebp)
8010517d:	e8 ae ce ff ff       	call   80102030 <namei>
80105182:	83 c4 10             	add    $0x10,%esp
80105185:	85 c0                	test   %eax,%eax
80105187:	89 c6                	mov    %eax,%esi
80105189:	0f 84 b2 00 00 00    	je     80105241 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
8010518f:	83 ec 0c             	sub    $0xc,%esp
80105192:	50                   	push   %eax
80105193:	e8 f8 c5 ff ff       	call   80101790 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105198:	83 c4 10             	add    $0x10,%esp
8010519b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801051a0:	0f 84 aa 00 00 00    	je     80105250 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801051a6:	e8 85 bc ff ff       	call   80100e30 <filealloc>
801051ab:	85 c0                	test   %eax,%eax
801051ad:	89 c7                	mov    %eax,%edi
801051af:	0f 84 a6 00 00 00    	je     8010525b <sys_open+0x12b>
  struct proc *curproc = myproc();
801051b5:	e8 76 e7 ff ff       	call   80103930 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801051ba:	31 db                	xor    %ebx,%ebx
801051bc:	eb 0e                	jmp    801051cc <sys_open+0x9c>
801051be:	66 90                	xchg   %ax,%ax
801051c0:	83 c3 01             	add    $0x1,%ebx
801051c3:	83 fb 10             	cmp    $0x10,%ebx
801051c6:	0f 84 ac 00 00 00    	je     80105278 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
801051cc:	8b 54 98 2c          	mov    0x2c(%eax,%ebx,4),%edx
801051d0:	85 d2                	test   %edx,%edx
801051d2:	75 ec                	jne    801051c0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801051d4:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801051d7:	89 7c 98 2c          	mov    %edi,0x2c(%eax,%ebx,4)
  iunlock(ip);
801051db:	56                   	push   %esi
801051dc:	e8 8f c6 ff ff       	call   80101870 <iunlock>
  end_op();
801051e1:	e8 7a db ff ff       	call   80102d60 <end_op>

  f->type = FD_INODE;
801051e6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801051ec:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801051ef:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801051f2:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801051f5:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801051fc:	89 d0                	mov    %edx,%eax
801051fe:	f7 d0                	not    %eax
80105200:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105203:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105206:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105209:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010520d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105210:	89 d8                	mov    %ebx,%eax
80105212:	5b                   	pop    %ebx
80105213:	5e                   	pop    %esi
80105214:	5f                   	pop    %edi
80105215:	5d                   	pop    %ebp
80105216:	c3                   	ret    
80105217:	89 f6                	mov    %esi,%esi
80105219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105220:	83 ec 0c             	sub    $0xc,%esp
80105223:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105226:	31 c9                	xor    %ecx,%ecx
80105228:	6a 00                	push   $0x0
8010522a:	ba 02 00 00 00       	mov    $0x2,%edx
8010522f:	e8 bc f7 ff ff       	call   801049f0 <create>
    if(ip == 0){
80105234:	83 c4 10             	add    $0x10,%esp
80105237:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105239:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010523b:	0f 85 65 ff ff ff    	jne    801051a6 <sys_open+0x76>
      end_op();
80105241:	e8 1a db ff ff       	call   80102d60 <end_op>
      return -1;
80105246:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010524b:	eb c0                	jmp    8010520d <sys_open+0xdd>
8010524d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105250:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105253:	85 c9                	test   %ecx,%ecx
80105255:	0f 84 4b ff ff ff    	je     801051a6 <sys_open+0x76>
    iunlockput(ip);
8010525b:	83 ec 0c             	sub    $0xc,%esp
8010525e:	56                   	push   %esi
8010525f:	e8 bc c7 ff ff       	call   80101a20 <iunlockput>
    end_op();
80105264:	e8 f7 da ff ff       	call   80102d60 <end_op>
    return -1;
80105269:	83 c4 10             	add    $0x10,%esp
8010526c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105271:	eb 9a                	jmp    8010520d <sys_open+0xdd>
80105273:	90                   	nop
80105274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105278:	83 ec 0c             	sub    $0xc,%esp
8010527b:	57                   	push   %edi
8010527c:	e8 6f bc ff ff       	call   80100ef0 <fileclose>
80105281:	83 c4 10             	add    $0x10,%esp
80105284:	eb d5                	jmp    8010525b <sys_open+0x12b>
80105286:	8d 76 00             	lea    0x0(%esi),%esi
80105289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105290 <sys_mkdir>:

int
sys_mkdir(void)
{
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105296:	e8 55 da ff ff       	call   80102cf0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010529b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010529e:	83 ec 08             	sub    $0x8,%esp
801052a1:	50                   	push   %eax
801052a2:	6a 00                	push   $0x0
801052a4:	e8 a7 f6 ff ff       	call   80104950 <argstr>
801052a9:	83 c4 10             	add    $0x10,%esp
801052ac:	85 c0                	test   %eax,%eax
801052ae:	78 30                	js     801052e0 <sys_mkdir+0x50>
801052b0:	83 ec 0c             	sub    $0xc,%esp
801052b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052b6:	31 c9                	xor    %ecx,%ecx
801052b8:	6a 00                	push   $0x0
801052ba:	ba 01 00 00 00       	mov    $0x1,%edx
801052bf:	e8 2c f7 ff ff       	call   801049f0 <create>
801052c4:	83 c4 10             	add    $0x10,%esp
801052c7:	85 c0                	test   %eax,%eax
801052c9:	74 15                	je     801052e0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801052cb:	83 ec 0c             	sub    $0xc,%esp
801052ce:	50                   	push   %eax
801052cf:	e8 4c c7 ff ff       	call   80101a20 <iunlockput>
  end_op();
801052d4:	e8 87 da ff ff       	call   80102d60 <end_op>
  return 0;
801052d9:	83 c4 10             	add    $0x10,%esp
801052dc:	31 c0                	xor    %eax,%eax
}
801052de:	c9                   	leave  
801052df:	c3                   	ret    
    end_op();
801052e0:	e8 7b da ff ff       	call   80102d60 <end_op>
    return -1;
801052e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801052ea:	c9                   	leave  
801052eb:	c3                   	ret    
801052ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801052f0 <sys_mknod>:

int
sys_mknod(void)
{
801052f0:	55                   	push   %ebp
801052f1:	89 e5                	mov    %esp,%ebp
801052f3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801052f6:	e8 f5 d9 ff ff       	call   80102cf0 <begin_op>
  if((argstr(0, &path)) < 0 ||
801052fb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801052fe:	83 ec 08             	sub    $0x8,%esp
80105301:	50                   	push   %eax
80105302:	6a 00                	push   $0x0
80105304:	e8 47 f6 ff ff       	call   80104950 <argstr>
80105309:	83 c4 10             	add    $0x10,%esp
8010530c:	85 c0                	test   %eax,%eax
8010530e:	78 60                	js     80105370 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105310:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105313:	83 ec 08             	sub    $0x8,%esp
80105316:	50                   	push   %eax
80105317:	6a 01                	push   $0x1
80105319:	e8 82 f5 ff ff       	call   801048a0 <argint>
  if((argstr(0, &path)) < 0 ||
8010531e:	83 c4 10             	add    $0x10,%esp
80105321:	85 c0                	test   %eax,%eax
80105323:	78 4b                	js     80105370 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105325:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105328:	83 ec 08             	sub    $0x8,%esp
8010532b:	50                   	push   %eax
8010532c:	6a 02                	push   $0x2
8010532e:	e8 6d f5 ff ff       	call   801048a0 <argint>
     argint(1, &major) < 0 ||
80105333:	83 c4 10             	add    $0x10,%esp
80105336:	85 c0                	test   %eax,%eax
80105338:	78 36                	js     80105370 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010533a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010533e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105341:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105345:	ba 03 00 00 00       	mov    $0x3,%edx
8010534a:	50                   	push   %eax
8010534b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010534e:	e8 9d f6 ff ff       	call   801049f0 <create>
80105353:	83 c4 10             	add    $0x10,%esp
80105356:	85 c0                	test   %eax,%eax
80105358:	74 16                	je     80105370 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010535a:	83 ec 0c             	sub    $0xc,%esp
8010535d:	50                   	push   %eax
8010535e:	e8 bd c6 ff ff       	call   80101a20 <iunlockput>
  end_op();
80105363:	e8 f8 d9 ff ff       	call   80102d60 <end_op>
  return 0;
80105368:	83 c4 10             	add    $0x10,%esp
8010536b:	31 c0                	xor    %eax,%eax
}
8010536d:	c9                   	leave  
8010536e:	c3                   	ret    
8010536f:	90                   	nop
    end_op();
80105370:	e8 eb d9 ff ff       	call   80102d60 <end_op>
    return -1;
80105375:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010537a:	c9                   	leave  
8010537b:	c3                   	ret    
8010537c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105380 <sys_chdir>:

int
sys_chdir(void)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	56                   	push   %esi
80105384:	53                   	push   %ebx
80105385:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105388:	e8 a3 e5 ff ff       	call   80103930 <myproc>
8010538d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010538f:	e8 5c d9 ff ff       	call   80102cf0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105394:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105397:	83 ec 08             	sub    $0x8,%esp
8010539a:	50                   	push   %eax
8010539b:	6a 00                	push   $0x0
8010539d:	e8 ae f5 ff ff       	call   80104950 <argstr>
801053a2:	83 c4 10             	add    $0x10,%esp
801053a5:	85 c0                	test   %eax,%eax
801053a7:	78 77                	js     80105420 <sys_chdir+0xa0>
801053a9:	83 ec 0c             	sub    $0xc,%esp
801053ac:	ff 75 f4             	pushl  -0xc(%ebp)
801053af:	e8 7c cc ff ff       	call   80102030 <namei>
801053b4:	83 c4 10             	add    $0x10,%esp
801053b7:	85 c0                	test   %eax,%eax
801053b9:	89 c3                	mov    %eax,%ebx
801053bb:	74 63                	je     80105420 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801053bd:	83 ec 0c             	sub    $0xc,%esp
801053c0:	50                   	push   %eax
801053c1:	e8 ca c3 ff ff       	call   80101790 <ilock>
  if(ip->type != T_DIR){
801053c6:	83 c4 10             	add    $0x10,%esp
801053c9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053ce:	75 30                	jne    80105400 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801053d0:	83 ec 0c             	sub    $0xc,%esp
801053d3:	53                   	push   %ebx
801053d4:	e8 97 c4 ff ff       	call   80101870 <iunlock>
  iput(curproc->cwd);
801053d9:	58                   	pop    %eax
801053da:	ff 76 6c             	pushl  0x6c(%esi)
801053dd:	e8 de c4 ff ff       	call   801018c0 <iput>
  end_op();
801053e2:	e8 79 d9 ff ff       	call   80102d60 <end_op>
  curproc->cwd = ip;
801053e7:	89 5e 6c             	mov    %ebx,0x6c(%esi)
  return 0;
801053ea:	83 c4 10             	add    $0x10,%esp
801053ed:	31 c0                	xor    %eax,%eax
}
801053ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801053f2:	5b                   	pop    %ebx
801053f3:	5e                   	pop    %esi
801053f4:	5d                   	pop    %ebp
801053f5:	c3                   	ret    
801053f6:	8d 76 00             	lea    0x0(%esi),%esi
801053f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105400:	83 ec 0c             	sub    $0xc,%esp
80105403:	53                   	push   %ebx
80105404:	e8 17 c6 ff ff       	call   80101a20 <iunlockput>
    end_op();
80105409:	e8 52 d9 ff ff       	call   80102d60 <end_op>
    return -1;
8010540e:	83 c4 10             	add    $0x10,%esp
80105411:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105416:	eb d7                	jmp    801053ef <sys_chdir+0x6f>
80105418:	90                   	nop
80105419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105420:	e8 3b d9 ff ff       	call   80102d60 <end_op>
    return -1;
80105425:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010542a:	eb c3                	jmp    801053ef <sys_chdir+0x6f>
8010542c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105430 <sys_exec>:

int
sys_exec(void)
{
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	57                   	push   %edi
80105434:	56                   	push   %esi
80105435:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105436:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010543c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105442:	50                   	push   %eax
80105443:	6a 00                	push   $0x0
80105445:	e8 06 f5 ff ff       	call   80104950 <argstr>
8010544a:	83 c4 10             	add    $0x10,%esp
8010544d:	85 c0                	test   %eax,%eax
8010544f:	0f 88 87 00 00 00    	js     801054dc <sys_exec+0xac>
80105455:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010545b:	83 ec 08             	sub    $0x8,%esp
8010545e:	50                   	push   %eax
8010545f:	6a 01                	push   $0x1
80105461:	e8 3a f4 ff ff       	call   801048a0 <argint>
80105466:	83 c4 10             	add    $0x10,%esp
80105469:	85 c0                	test   %eax,%eax
8010546b:	78 6f                	js     801054dc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010546d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105473:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105476:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105478:	68 80 00 00 00       	push   $0x80
8010547d:	6a 00                	push   $0x0
8010547f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105485:	50                   	push   %eax
80105486:	e8 15 f1 ff ff       	call   801045a0 <memset>
8010548b:	83 c4 10             	add    $0x10,%esp
8010548e:	eb 2c                	jmp    801054bc <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105490:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105496:	85 c0                	test   %eax,%eax
80105498:	74 56                	je     801054f0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010549a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801054a0:	83 ec 08             	sub    $0x8,%esp
801054a3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801054a6:	52                   	push   %edx
801054a7:	50                   	push   %eax
801054a8:	e8 83 f3 ff ff       	call   80104830 <fetchstr>
801054ad:	83 c4 10             	add    $0x10,%esp
801054b0:	85 c0                	test   %eax,%eax
801054b2:	78 28                	js     801054dc <sys_exec+0xac>
  for(i=0;; i++){
801054b4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801054b7:	83 fb 20             	cmp    $0x20,%ebx
801054ba:	74 20                	je     801054dc <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801054bc:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801054c2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801054c9:	83 ec 08             	sub    $0x8,%esp
801054cc:	57                   	push   %edi
801054cd:	01 f0                	add    %esi,%eax
801054cf:	50                   	push   %eax
801054d0:	e8 1b f3 ff ff       	call   801047f0 <fetchint>
801054d5:	83 c4 10             	add    $0x10,%esp
801054d8:	85 c0                	test   %eax,%eax
801054da:	79 b4                	jns    80105490 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801054dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801054df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054e4:	5b                   	pop    %ebx
801054e5:	5e                   	pop    %esi
801054e6:	5f                   	pop    %edi
801054e7:	5d                   	pop    %ebp
801054e8:	c3                   	ret    
801054e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801054f0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801054f6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
801054f9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105500:	00 00 00 00 
  return exec(path, argv);
80105504:	50                   	push   %eax
80105505:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010550b:	e8 b0 b5 ff ff       	call   80100ac0 <exec>
80105510:	83 c4 10             	add    $0x10,%esp
}
80105513:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105516:	5b                   	pop    %ebx
80105517:	5e                   	pop    %esi
80105518:	5f                   	pop    %edi
80105519:	5d                   	pop    %ebp
8010551a:	c3                   	ret    
8010551b:	90                   	nop
8010551c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105520 <sys_pipe>:

int
sys_pipe(void)
{
80105520:	55                   	push   %ebp
80105521:	89 e5                	mov    %esp,%ebp
80105523:	57                   	push   %edi
80105524:	56                   	push   %esi
80105525:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105526:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105529:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010552c:	6a 08                	push   $0x8
8010552e:	50                   	push   %eax
8010552f:	6a 00                	push   $0x0
80105531:	e8 ba f3 ff ff       	call   801048f0 <argptr>
80105536:	83 c4 10             	add    $0x10,%esp
80105539:	85 c0                	test   %eax,%eax
8010553b:	0f 88 ae 00 00 00    	js     801055ef <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105541:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105544:	83 ec 08             	sub    $0x8,%esp
80105547:	50                   	push   %eax
80105548:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010554b:	50                   	push   %eax
8010554c:	e8 3f de ff ff       	call   80103390 <pipealloc>
80105551:	83 c4 10             	add    $0x10,%esp
80105554:	85 c0                	test   %eax,%eax
80105556:	0f 88 93 00 00 00    	js     801055ef <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010555c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010555f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105561:	e8 ca e3 ff ff       	call   80103930 <myproc>
80105566:	eb 10                	jmp    80105578 <sys_pipe+0x58>
80105568:	90                   	nop
80105569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105570:	83 c3 01             	add    $0x1,%ebx
80105573:	83 fb 10             	cmp    $0x10,%ebx
80105576:	74 60                	je     801055d8 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105578:	8b 74 98 2c          	mov    0x2c(%eax,%ebx,4),%esi
8010557c:	85 f6                	test   %esi,%esi
8010557e:	75 f0                	jne    80105570 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105580:	8d 73 08             	lea    0x8(%ebx),%esi
80105583:	89 7c b0 0c          	mov    %edi,0xc(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105587:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010558a:	e8 a1 e3 ff ff       	call   80103930 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010558f:	31 d2                	xor    %edx,%edx
80105591:	eb 0d                	jmp    801055a0 <sys_pipe+0x80>
80105593:	90                   	nop
80105594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105598:	83 c2 01             	add    $0x1,%edx
8010559b:	83 fa 10             	cmp    $0x10,%edx
8010559e:	74 28                	je     801055c8 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
801055a0:	8b 4c 90 2c          	mov    0x2c(%eax,%edx,4),%ecx
801055a4:	85 c9                	test   %ecx,%ecx
801055a6:	75 f0                	jne    80105598 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
801055a8:	89 7c 90 2c          	mov    %edi,0x2c(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801055ac:	8b 45 dc             	mov    -0x24(%ebp),%eax
801055af:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801055b1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801055b4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801055b7:	31 c0                	xor    %eax,%eax
}
801055b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055bc:	5b                   	pop    %ebx
801055bd:	5e                   	pop    %esi
801055be:	5f                   	pop    %edi
801055bf:	5d                   	pop    %ebp
801055c0:	c3                   	ret    
801055c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
801055c8:	e8 63 e3 ff ff       	call   80103930 <myproc>
801055cd:	c7 44 b0 0c 00 00 00 	movl   $0x0,0xc(%eax,%esi,4)
801055d4:	00 
801055d5:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
801055d8:	83 ec 0c             	sub    $0xc,%esp
801055db:	ff 75 e0             	pushl  -0x20(%ebp)
801055de:	e8 0d b9 ff ff       	call   80100ef0 <fileclose>
    fileclose(wf);
801055e3:	58                   	pop    %eax
801055e4:	ff 75 e4             	pushl  -0x1c(%ebp)
801055e7:	e8 04 b9 ff ff       	call   80100ef0 <fileclose>
    return -1;
801055ec:	83 c4 10             	add    $0x10,%esp
801055ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055f4:	eb c3                	jmp    801055b9 <sys_pipe+0x99>
801055f6:	66 90                	xchg   %ax,%ax
801055f8:	66 90                	xchg   %ax,%ax
801055fa:	66 90                	xchg   %ax,%ax
801055fc:	66 90                	xchg   %ax,%ax
801055fe:	66 90                	xchg   %ax,%ax

80105600 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105603:	5d                   	pop    %ebp
  return fork();
80105604:	e9 c7 e4 ff ff       	jmp    80103ad0 <fork>
80105609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105610 <sys_exit>:

int
sys_exit(void)
{
80105610:	55                   	push   %ebp
80105611:	89 e5                	mov    %esp,%ebp
80105613:	83 ec 08             	sub    $0x8,%esp
  exit();
80105616:	e8 35 e7 ff ff       	call   80103d50 <exit>
  return 0;  // not reached
}
8010561b:	31 c0                	xor    %eax,%eax
8010561d:	c9                   	leave  
8010561e:	c3                   	ret    
8010561f:	90                   	nop

80105620 <sys_wait>:

int
sys_wait(void)
{
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105623:	5d                   	pop    %ebp
  return wait();
80105624:	e9 67 e9 ff ff       	jmp    80103f90 <wait>
80105629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105630 <sys_kill>:

int
sys_kill(void)
{
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105636:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105639:	50                   	push   %eax
8010563a:	6a 00                	push   $0x0
8010563c:	e8 5f f2 ff ff       	call   801048a0 <argint>
80105641:	83 c4 10             	add    $0x10,%esp
80105644:	85 c0                	test   %eax,%eax
80105646:	78 18                	js     80105660 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105648:	83 ec 0c             	sub    $0xc,%esp
8010564b:	ff 75 f4             	pushl  -0xc(%ebp)
8010564e:	e8 8d ea ff ff       	call   801040e0 <kill>
80105653:	83 c4 10             	add    $0x10,%esp
}
80105656:	c9                   	leave  
80105657:	c3                   	ret    
80105658:	90                   	nop
80105659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105660:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105665:	c9                   	leave  
80105666:	c3                   	ret    
80105667:	89 f6                	mov    %esi,%esi
80105669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105670 <sys_getpid>:

int
sys_getpid(void)
{
80105670:	55                   	push   %ebp
80105671:	89 e5                	mov    %esp,%ebp
80105673:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105676:	e8 b5 e2 ff ff       	call   80103930 <myproc>
8010567b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010567e:	c9                   	leave  
8010567f:	c3                   	ret    

80105680 <sys_sbrk>:

int
sys_sbrk(void)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105684:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105687:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010568a:	50                   	push   %eax
8010568b:	6a 00                	push   $0x0
8010568d:	e8 0e f2 ff ff       	call   801048a0 <argint>
80105692:	83 c4 10             	add    $0x10,%esp
80105695:	85 c0                	test   %eax,%eax
80105697:	78 27                	js     801056c0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105699:	e8 92 e2 ff ff       	call   80103930 <myproc>
  if(growproc(n) < 0)
8010569e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801056a1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801056a3:	ff 75 f4             	pushl  -0xc(%ebp)
801056a6:	e8 a5 e3 ff ff       	call   80103a50 <growproc>
801056ab:	83 c4 10             	add    $0x10,%esp
801056ae:	85 c0                	test   %eax,%eax
801056b0:	78 0e                	js     801056c0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801056b2:	89 d8                	mov    %ebx,%eax
801056b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056b7:	c9                   	leave  
801056b8:	c3                   	ret    
801056b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801056c0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801056c5:	eb eb                	jmp    801056b2 <sys_sbrk+0x32>
801056c7:	89 f6                	mov    %esi,%esi
801056c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056d0 <sys_sleep>:

int
sys_sleep(void)
{
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
801056d3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801056d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801056d7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801056da:	50                   	push   %eax
801056db:	6a 00                	push   $0x0
801056dd:	e8 be f1 ff ff       	call   801048a0 <argint>
801056e2:	83 c4 10             	add    $0x10,%esp
801056e5:	85 c0                	test   %eax,%eax
801056e7:	0f 88 8a 00 00 00    	js     80105777 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801056ed:	83 ec 0c             	sub    $0xc,%esp
801056f0:	68 80 4d 11 80       	push   $0x80114d80
801056f5:	e8 96 ed ff ff       	call   80104490 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801056fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
801056fd:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105700:	8b 1d c0 55 11 80    	mov    0x801155c0,%ebx
  while(ticks - ticks0 < n){
80105706:	85 d2                	test   %edx,%edx
80105708:	75 27                	jne    80105731 <sys_sleep+0x61>
8010570a:	eb 54                	jmp    80105760 <sys_sleep+0x90>
8010570c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105710:	83 ec 08             	sub    $0x8,%esp
80105713:	68 80 4d 11 80       	push   $0x80114d80
80105718:	68 c0 55 11 80       	push   $0x801155c0
8010571d:	e8 ae e7 ff ff       	call   80103ed0 <sleep>
  while(ticks - ticks0 < n){
80105722:	a1 c0 55 11 80       	mov    0x801155c0,%eax
80105727:	83 c4 10             	add    $0x10,%esp
8010572a:	29 d8                	sub    %ebx,%eax
8010572c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010572f:	73 2f                	jae    80105760 <sys_sleep+0x90>
    if(myproc()->killed){
80105731:	e8 fa e1 ff ff       	call   80103930 <myproc>
80105736:	8b 40 24             	mov    0x24(%eax),%eax
80105739:	85 c0                	test   %eax,%eax
8010573b:	74 d3                	je     80105710 <sys_sleep+0x40>
      release(&tickslock);
8010573d:	83 ec 0c             	sub    $0xc,%esp
80105740:	68 80 4d 11 80       	push   $0x80114d80
80105745:	e8 06 ee ff ff       	call   80104550 <release>
      return -1;
8010574a:	83 c4 10             	add    $0x10,%esp
8010574d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105752:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105755:	c9                   	leave  
80105756:	c3                   	ret    
80105757:	89 f6                	mov    %esi,%esi
80105759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105760:	83 ec 0c             	sub    $0xc,%esp
80105763:	68 80 4d 11 80       	push   $0x80114d80
80105768:	e8 e3 ed ff ff       	call   80104550 <release>
  return 0;
8010576d:	83 c4 10             	add    $0x10,%esp
80105770:	31 c0                	xor    %eax,%eax
}
80105772:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105775:	c9                   	leave  
80105776:	c3                   	ret    
    return -1;
80105777:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010577c:	eb f4                	jmp    80105772 <sys_sleep+0xa2>
8010577e:	66 90                	xchg   %ax,%ax

80105780 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	53                   	push   %ebx
80105784:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105787:	68 80 4d 11 80       	push   $0x80114d80
8010578c:	e8 ff ec ff ff       	call   80104490 <acquire>
  xticks = ticks;
80105791:	8b 1d c0 55 11 80    	mov    0x801155c0,%ebx
  release(&tickslock);
80105797:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010579e:	e8 ad ed ff ff       	call   80104550 <release>
  return xticks;
}
801057a3:	89 d8                	mov    %ebx,%eax
801057a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057a8:	c9                   	leave  
801057a9:	c3                   	ret    
801057aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801057b0 <sys_cpuhalt>:

//to halt or kill the virtual machine
int
sys_cpuhalt(void){
801057b0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801057b1:	b8 00 20 00 00       	mov    $0x2000,%eax
801057b6:	ba 04 06 00 00       	mov    $0x604,%edx
801057bb:	89 e5                	mov    %esp,%ebp
801057bd:	66 ef                	out    %ax,(%dx)
  //https://wiki.osdev.org/Shutdown
  outw(0x604, 0x2000);
  return 0;
}
801057bf:	31 c0                	xor    %eax,%eax
801057c1:	5d                   	pop    %ebp
801057c2:	c3                   	ret    

801057c3 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801057c3:	1e                   	push   %ds
  pushl %es
801057c4:	06                   	push   %es
  pushl %fs
801057c5:	0f a0                	push   %fs
  pushl %gs
801057c7:	0f a8                	push   %gs
  pushal
801057c9:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801057ca:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801057ce:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801057d0:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801057d2:	54                   	push   %esp
  call trap
801057d3:	e8 c8 00 00 00       	call   801058a0 <trap>
  addl $4, %esp
801057d8:	83 c4 04             	add    $0x4,%esp

801057db <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801057db:	61                   	popa   
  popl %gs
801057dc:	0f a9                	pop    %gs
  popl %fs
801057de:	0f a1                	pop    %fs
  popl %es
801057e0:	07                   	pop    %es
  popl %ds
801057e1:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801057e2:	83 c4 08             	add    $0x8,%esp
  iret
801057e5:	cf                   	iret   
801057e6:	66 90                	xchg   %ax,%ax
801057e8:	66 90                	xchg   %ax,%ax
801057ea:	66 90                	xchg   %ax,%ax
801057ec:	66 90                	xchg   %ax,%ax
801057ee:	66 90                	xchg   %ax,%ax

801057f0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801057f0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
801057f1:	31 c0                	xor    %eax,%eax
{
801057f3:	89 e5                	mov    %esp,%ebp
801057f5:	83 ec 08             	sub    $0x8,%esp
801057f8:	90                   	nop
801057f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105800:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105807:	c7 04 c5 c2 4d 11 80 	movl   $0x8e000008,-0x7feeb23e(,%eax,8)
8010580e:	08 00 00 8e 
80105812:	66 89 14 c5 c0 4d 11 	mov    %dx,-0x7feeb240(,%eax,8)
80105819:	80 
8010581a:	c1 ea 10             	shr    $0x10,%edx
8010581d:	66 89 14 c5 c6 4d 11 	mov    %dx,-0x7feeb23a(,%eax,8)
80105824:	80 
  for(i = 0; i < 256; i++)
80105825:	83 c0 01             	add    $0x1,%eax
80105828:	3d 00 01 00 00       	cmp    $0x100,%eax
8010582d:	75 d1                	jne    80105800 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010582f:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105834:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105837:	c7 05 c2 4f 11 80 08 	movl   $0xef000008,0x80114fc2
8010583e:	00 00 ef 
  initlock(&tickslock, "time");
80105841:	68 01 78 10 80       	push   $0x80107801
80105846:	68 80 4d 11 80       	push   $0x80114d80
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010584b:	66 a3 c0 4f 11 80    	mov    %ax,0x80114fc0
80105851:	c1 e8 10             	shr    $0x10,%eax
80105854:	66 a3 c6 4f 11 80    	mov    %ax,0x80114fc6
  initlock(&tickslock, "time");
8010585a:	e8 f1 ea ff ff       	call   80104350 <initlock>
}
8010585f:	83 c4 10             	add    $0x10,%esp
80105862:	c9                   	leave  
80105863:	c3                   	ret    
80105864:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010586a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105870 <idtinit>:

void
idtinit(void)
{
80105870:	55                   	push   %ebp
  pd[0] = size-1;
80105871:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105876:	89 e5                	mov    %esp,%ebp
80105878:	83 ec 10             	sub    $0x10,%esp
8010587b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010587f:	b8 c0 4d 11 80       	mov    $0x80114dc0,%eax
80105884:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105888:	c1 e8 10             	shr    $0x10,%eax
8010588b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010588f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105892:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105895:	c9                   	leave  
80105896:	c3                   	ret    
80105897:	89 f6                	mov    %esi,%esi
80105899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058a0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	57                   	push   %edi
801058a4:	56                   	push   %esi
801058a5:	53                   	push   %ebx
801058a6:	83 ec 1c             	sub    $0x1c,%esp
801058a9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
801058ac:	8b 47 30             	mov    0x30(%edi),%eax
801058af:	83 f8 40             	cmp    $0x40,%eax
801058b2:	0f 84 f0 00 00 00    	je     801059a8 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801058b8:	83 e8 20             	sub    $0x20,%eax
801058bb:	83 f8 1f             	cmp    $0x1f,%eax
801058be:	77 10                	ja     801058d0 <trap+0x30>
801058c0:	ff 24 85 a8 78 10 80 	jmp    *-0x7fef8758(,%eax,4)
801058c7:	89 f6                	mov    %esi,%esi
801058c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801058d0:	e8 5b e0 ff ff       	call   80103930 <myproc>
801058d5:	85 c0                	test   %eax,%eax
801058d7:	8b 5f 38             	mov    0x38(%edi),%ebx
801058da:	0f 84 14 02 00 00    	je     80105af4 <trap+0x254>
801058e0:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
801058e4:	0f 84 0a 02 00 00    	je     80105af4 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801058ea:	0f 20 d1             	mov    %cr2,%ecx
801058ed:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801058f0:	e8 1b e0 ff ff       	call   80103910 <cpuid>
801058f5:	89 45 dc             	mov    %eax,-0x24(%ebp)
801058f8:	8b 47 34             	mov    0x34(%edi),%eax
801058fb:	8b 77 30             	mov    0x30(%edi),%esi
801058fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105901:	e8 2a e0 ff ff       	call   80103930 <myproc>
80105906:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105909:	e8 22 e0 ff ff       	call   80103930 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010590e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105911:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105914:	51                   	push   %ecx
80105915:	53                   	push   %ebx
80105916:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105917:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010591a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010591d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010591e:	83 c2 70             	add    $0x70,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105921:	52                   	push   %edx
80105922:	ff 70 10             	pushl  0x10(%eax)
80105925:	68 64 78 10 80       	push   $0x80107864
8010592a:	e8 e1 ad ff ff       	call   80100710 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010592f:	83 c4 20             	add    $0x20,%esp
80105932:	e8 f9 df ff ff       	call   80103930 <myproc>
80105937:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010593e:	e8 ed df ff ff       	call   80103930 <myproc>
80105943:	85 c0                	test   %eax,%eax
80105945:	74 1d                	je     80105964 <trap+0xc4>
80105947:	e8 e4 df ff ff       	call   80103930 <myproc>
8010594c:	8b 50 24             	mov    0x24(%eax),%edx
8010594f:	85 d2                	test   %edx,%edx
80105951:	74 11                	je     80105964 <trap+0xc4>
80105953:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105957:	83 e0 03             	and    $0x3,%eax
8010595a:	66 83 f8 03          	cmp    $0x3,%ax
8010595e:	0f 84 4c 01 00 00    	je     80105ab0 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105964:	e8 c7 df ff ff       	call   80103930 <myproc>
80105969:	85 c0                	test   %eax,%eax
8010596b:	74 0b                	je     80105978 <trap+0xd8>
8010596d:	e8 be df ff ff       	call   80103930 <myproc>
80105972:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105976:	74 68                	je     801059e0 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105978:	e8 b3 df ff ff       	call   80103930 <myproc>
8010597d:	85 c0                	test   %eax,%eax
8010597f:	74 19                	je     8010599a <trap+0xfa>
80105981:	e8 aa df ff ff       	call   80103930 <myproc>
80105986:	8b 40 24             	mov    0x24(%eax),%eax
80105989:	85 c0                	test   %eax,%eax
8010598b:	74 0d                	je     8010599a <trap+0xfa>
8010598d:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105991:	83 e0 03             	and    $0x3,%eax
80105994:	66 83 f8 03          	cmp    $0x3,%ax
80105998:	74 37                	je     801059d1 <trap+0x131>
    exit();
}
8010599a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010599d:	5b                   	pop    %ebx
8010599e:	5e                   	pop    %esi
8010599f:	5f                   	pop    %edi
801059a0:	5d                   	pop    %ebp
801059a1:	c3                   	ret    
801059a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
801059a8:	e8 83 df ff ff       	call   80103930 <myproc>
801059ad:	8b 58 24             	mov    0x24(%eax),%ebx
801059b0:	85 db                	test   %ebx,%ebx
801059b2:	0f 85 e8 00 00 00    	jne    80105aa0 <trap+0x200>
    myproc()->tf = tf;
801059b8:	e8 73 df ff ff       	call   80103930 <myproc>
801059bd:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
801059c0:	e8 cb ef ff ff       	call   80104990 <syscall>
    if(myproc()->killed)
801059c5:	e8 66 df ff ff       	call   80103930 <myproc>
801059ca:	8b 48 24             	mov    0x24(%eax),%ecx
801059cd:	85 c9                	test   %ecx,%ecx
801059cf:	74 c9                	je     8010599a <trap+0xfa>
}
801059d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059d4:	5b                   	pop    %ebx
801059d5:	5e                   	pop    %esi
801059d6:	5f                   	pop    %edi
801059d7:	5d                   	pop    %ebp
      exit();
801059d8:	e9 73 e3 ff ff       	jmp    80103d50 <exit>
801059dd:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
801059e0:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
801059e4:	75 92                	jne    80105978 <trap+0xd8>
    yield();
801059e6:	e8 95 e4 ff ff       	call   80103e80 <yield>
801059eb:	eb 8b                	jmp    80105978 <trap+0xd8>
801059ed:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
801059f0:	e8 1b df ff ff       	call   80103910 <cpuid>
801059f5:	85 c0                	test   %eax,%eax
801059f7:	0f 84 c3 00 00 00    	je     80105ac0 <trap+0x220>
    lapiceoi();
801059fd:	e8 9e ce ff ff       	call   801028a0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a02:	e8 29 df ff ff       	call   80103930 <myproc>
80105a07:	85 c0                	test   %eax,%eax
80105a09:	0f 85 38 ff ff ff    	jne    80105947 <trap+0xa7>
80105a0f:	e9 50 ff ff ff       	jmp    80105964 <trap+0xc4>
80105a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105a18:	e8 43 cd ff ff       	call   80102760 <kbdintr>
    lapiceoi();
80105a1d:	e8 7e ce ff ff       	call   801028a0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a22:	e8 09 df ff ff       	call   80103930 <myproc>
80105a27:	85 c0                	test   %eax,%eax
80105a29:	0f 85 18 ff ff ff    	jne    80105947 <trap+0xa7>
80105a2f:	e9 30 ff ff ff       	jmp    80105964 <trap+0xc4>
80105a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105a38:	e8 53 02 00 00       	call   80105c90 <uartintr>
    lapiceoi();
80105a3d:	e8 5e ce ff ff       	call   801028a0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a42:	e8 e9 de ff ff       	call   80103930 <myproc>
80105a47:	85 c0                	test   %eax,%eax
80105a49:	0f 85 f8 fe ff ff    	jne    80105947 <trap+0xa7>
80105a4f:	e9 10 ff ff ff       	jmp    80105964 <trap+0xc4>
80105a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105a58:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105a5c:	8b 77 38             	mov    0x38(%edi),%esi
80105a5f:	e8 ac de ff ff       	call   80103910 <cpuid>
80105a64:	56                   	push   %esi
80105a65:	53                   	push   %ebx
80105a66:	50                   	push   %eax
80105a67:	68 0c 78 10 80       	push   $0x8010780c
80105a6c:	e8 9f ac ff ff       	call   80100710 <cprintf>
    lapiceoi();
80105a71:	e8 2a ce ff ff       	call   801028a0 <lapiceoi>
    break;
80105a76:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a79:	e8 b2 de ff ff       	call   80103930 <myproc>
80105a7e:	85 c0                	test   %eax,%eax
80105a80:	0f 85 c1 fe ff ff    	jne    80105947 <trap+0xa7>
80105a86:	e9 d9 fe ff ff       	jmp    80105964 <trap+0xc4>
80105a8b:	90                   	nop
80105a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105a90:	e8 3b c7 ff ff       	call   801021d0 <ideintr>
80105a95:	e9 63 ff ff ff       	jmp    801059fd <trap+0x15d>
80105a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105aa0:	e8 ab e2 ff ff       	call   80103d50 <exit>
80105aa5:	e9 0e ff ff ff       	jmp    801059b8 <trap+0x118>
80105aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80105ab0:	e8 9b e2 ff ff       	call   80103d50 <exit>
80105ab5:	e9 aa fe ff ff       	jmp    80105964 <trap+0xc4>
80105aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105ac0:	83 ec 0c             	sub    $0xc,%esp
80105ac3:	68 80 4d 11 80       	push   $0x80114d80
80105ac8:	e8 c3 e9 ff ff       	call   80104490 <acquire>
      wakeup(&ticks);
80105acd:	c7 04 24 c0 55 11 80 	movl   $0x801155c0,(%esp)
      ticks++;
80105ad4:	83 05 c0 55 11 80 01 	addl   $0x1,0x801155c0
      wakeup(&ticks);
80105adb:	e8 a0 e5 ff ff       	call   80104080 <wakeup>
      release(&tickslock);
80105ae0:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80105ae7:	e8 64 ea ff ff       	call   80104550 <release>
80105aec:	83 c4 10             	add    $0x10,%esp
80105aef:	e9 09 ff ff ff       	jmp    801059fd <trap+0x15d>
80105af4:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105af7:	e8 14 de ff ff       	call   80103910 <cpuid>
80105afc:	83 ec 0c             	sub    $0xc,%esp
80105aff:	56                   	push   %esi
80105b00:	53                   	push   %ebx
80105b01:	50                   	push   %eax
80105b02:	ff 77 30             	pushl  0x30(%edi)
80105b05:	68 30 78 10 80       	push   $0x80107830
80105b0a:	e8 01 ac ff ff       	call   80100710 <cprintf>
      panic("trap");
80105b0f:	83 c4 14             	add    $0x14,%esp
80105b12:	68 06 78 10 80       	push   $0x80107806
80105b17:	e8 24 a9 ff ff       	call   80100440 <panic>
80105b1c:	66 90                	xchg   %ax,%ax
80105b1e:	66 90                	xchg   %ax,%ax

80105b20 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105b20:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
{
80105b25:	55                   	push   %ebp
80105b26:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105b28:	85 c0                	test   %eax,%eax
80105b2a:	74 1c                	je     80105b48 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105b2c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105b31:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105b32:	a8 01                	test   $0x1,%al
80105b34:	74 12                	je     80105b48 <uartgetc+0x28>
80105b36:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105b3b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105b3c:	0f b6 c0             	movzbl %al,%eax
}
80105b3f:	5d                   	pop    %ebp
80105b40:	c3                   	ret    
80105b41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105b48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b4d:	5d                   	pop    %ebp
80105b4e:	c3                   	ret    
80105b4f:	90                   	nop

80105b50 <uartputc.part.0>:
uartputc(int c)
80105b50:	55                   	push   %ebp
80105b51:	89 e5                	mov    %esp,%ebp
80105b53:	57                   	push   %edi
80105b54:	56                   	push   %esi
80105b55:	53                   	push   %ebx
80105b56:	89 c7                	mov    %eax,%edi
80105b58:	bb 80 00 00 00       	mov    $0x80,%ebx
80105b5d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105b62:	83 ec 0c             	sub    $0xc,%esp
80105b65:	eb 1b                	jmp    80105b82 <uartputc.part.0+0x32>
80105b67:	89 f6                	mov    %esi,%esi
80105b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105b70:	83 ec 0c             	sub    $0xc,%esp
80105b73:	6a 0a                	push   $0xa
80105b75:	e8 46 cd ff ff       	call   801028c0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105b7a:	83 c4 10             	add    $0x10,%esp
80105b7d:	83 eb 01             	sub    $0x1,%ebx
80105b80:	74 07                	je     80105b89 <uartputc.part.0+0x39>
80105b82:	89 f2                	mov    %esi,%edx
80105b84:	ec                   	in     (%dx),%al
80105b85:	a8 20                	test   $0x20,%al
80105b87:	74 e7                	je     80105b70 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105b89:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105b8e:	89 f8                	mov    %edi,%eax
80105b90:	ee                   	out    %al,(%dx)
}
80105b91:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b94:	5b                   	pop    %ebx
80105b95:	5e                   	pop    %esi
80105b96:	5f                   	pop    %edi
80105b97:	5d                   	pop    %ebp
80105b98:	c3                   	ret    
80105b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ba0 <uartinit>:
{
80105ba0:	55                   	push   %ebp
80105ba1:	31 c9                	xor    %ecx,%ecx
80105ba3:	89 c8                	mov    %ecx,%eax
80105ba5:	89 e5                	mov    %esp,%ebp
80105ba7:	57                   	push   %edi
80105ba8:	56                   	push   %esi
80105ba9:	53                   	push   %ebx
80105baa:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105baf:	89 da                	mov    %ebx,%edx
80105bb1:	83 ec 0c             	sub    $0xc,%esp
80105bb4:	ee                   	out    %al,(%dx)
80105bb5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105bba:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105bbf:	89 fa                	mov    %edi,%edx
80105bc1:	ee                   	out    %al,(%dx)
80105bc2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105bc7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105bcc:	ee                   	out    %al,(%dx)
80105bcd:	be f9 03 00 00       	mov    $0x3f9,%esi
80105bd2:	89 c8                	mov    %ecx,%eax
80105bd4:	89 f2                	mov    %esi,%edx
80105bd6:	ee                   	out    %al,(%dx)
80105bd7:	b8 03 00 00 00       	mov    $0x3,%eax
80105bdc:	89 fa                	mov    %edi,%edx
80105bde:	ee                   	out    %al,(%dx)
80105bdf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105be4:	89 c8                	mov    %ecx,%eax
80105be6:	ee                   	out    %al,(%dx)
80105be7:	b8 01 00 00 00       	mov    $0x1,%eax
80105bec:	89 f2                	mov    %esi,%edx
80105bee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105bef:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105bf4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105bf5:	3c ff                	cmp    $0xff,%al
80105bf7:	74 5a                	je     80105c53 <uartinit+0xb3>
  uart = 1;
80105bf9:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105c00:	00 00 00 
80105c03:	89 da                	mov    %ebx,%edx
80105c05:	ec                   	in     (%dx),%al
80105c06:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c0b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105c0c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105c0f:	bb 28 79 10 80       	mov    $0x80107928,%ebx
  ioapicenable(IRQ_COM1, 0);
80105c14:	6a 00                	push   $0x0
80105c16:	6a 04                	push   $0x4
80105c18:	e8 03 c8 ff ff       	call   80102420 <ioapicenable>
80105c1d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105c20:	b8 78 00 00 00       	mov    $0x78,%eax
80105c25:	eb 13                	jmp    80105c3a <uartinit+0x9a>
80105c27:	89 f6                	mov    %esi,%esi
80105c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105c30:	83 c3 01             	add    $0x1,%ebx
80105c33:	0f be 03             	movsbl (%ebx),%eax
80105c36:	84 c0                	test   %al,%al
80105c38:	74 19                	je     80105c53 <uartinit+0xb3>
  if(!uart)
80105c3a:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105c40:	85 d2                	test   %edx,%edx
80105c42:	74 ec                	je     80105c30 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105c44:	83 c3 01             	add    $0x1,%ebx
80105c47:	e8 04 ff ff ff       	call   80105b50 <uartputc.part.0>
80105c4c:	0f be 03             	movsbl (%ebx),%eax
80105c4f:	84 c0                	test   %al,%al
80105c51:	75 e7                	jne    80105c3a <uartinit+0x9a>
}
80105c53:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c56:	5b                   	pop    %ebx
80105c57:	5e                   	pop    %esi
80105c58:	5f                   	pop    %edi
80105c59:	5d                   	pop    %ebp
80105c5a:	c3                   	ret    
80105c5b:	90                   	nop
80105c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c60 <uartputc>:
  if(!uart)
80105c60:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80105c66:	55                   	push   %ebp
80105c67:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105c69:	85 d2                	test   %edx,%edx
{
80105c6b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105c6e:	74 10                	je     80105c80 <uartputc+0x20>
}
80105c70:	5d                   	pop    %ebp
80105c71:	e9 da fe ff ff       	jmp    80105b50 <uartputc.part.0>
80105c76:	8d 76 00             	lea    0x0(%esi),%esi
80105c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105c80:	5d                   	pop    %ebp
80105c81:	c3                   	ret    
80105c82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c90 <uartintr>:

void
uartintr(void)
{
80105c90:	55                   	push   %ebp
80105c91:	89 e5                	mov    %esp,%ebp
80105c93:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105c96:	68 20 5b 10 80       	push   $0x80105b20
80105c9b:	e8 20 ac ff ff       	call   801008c0 <consoleintr>
}
80105ca0:	83 c4 10             	add    $0x10,%esp
80105ca3:	c9                   	leave  
80105ca4:	c3                   	ret    

80105ca5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105ca5:	6a 00                	push   $0x0
  pushl $0
80105ca7:	6a 00                	push   $0x0
  jmp alltraps
80105ca9:	e9 15 fb ff ff       	jmp    801057c3 <alltraps>

80105cae <vector1>:
.globl vector1
vector1:
  pushl $0
80105cae:	6a 00                	push   $0x0
  pushl $1
80105cb0:	6a 01                	push   $0x1
  jmp alltraps
80105cb2:	e9 0c fb ff ff       	jmp    801057c3 <alltraps>

80105cb7 <vector2>:
.globl vector2
vector2:
  pushl $0
80105cb7:	6a 00                	push   $0x0
  pushl $2
80105cb9:	6a 02                	push   $0x2
  jmp alltraps
80105cbb:	e9 03 fb ff ff       	jmp    801057c3 <alltraps>

80105cc0 <vector3>:
.globl vector3
vector3:
  pushl $0
80105cc0:	6a 00                	push   $0x0
  pushl $3
80105cc2:	6a 03                	push   $0x3
  jmp alltraps
80105cc4:	e9 fa fa ff ff       	jmp    801057c3 <alltraps>

80105cc9 <vector4>:
.globl vector4
vector4:
  pushl $0
80105cc9:	6a 00                	push   $0x0
  pushl $4
80105ccb:	6a 04                	push   $0x4
  jmp alltraps
80105ccd:	e9 f1 fa ff ff       	jmp    801057c3 <alltraps>

80105cd2 <vector5>:
.globl vector5
vector5:
  pushl $0
80105cd2:	6a 00                	push   $0x0
  pushl $5
80105cd4:	6a 05                	push   $0x5
  jmp alltraps
80105cd6:	e9 e8 fa ff ff       	jmp    801057c3 <alltraps>

80105cdb <vector6>:
.globl vector6
vector6:
  pushl $0
80105cdb:	6a 00                	push   $0x0
  pushl $6
80105cdd:	6a 06                	push   $0x6
  jmp alltraps
80105cdf:	e9 df fa ff ff       	jmp    801057c3 <alltraps>

80105ce4 <vector7>:
.globl vector7
vector7:
  pushl $0
80105ce4:	6a 00                	push   $0x0
  pushl $7
80105ce6:	6a 07                	push   $0x7
  jmp alltraps
80105ce8:	e9 d6 fa ff ff       	jmp    801057c3 <alltraps>

80105ced <vector8>:
.globl vector8
vector8:
  pushl $8
80105ced:	6a 08                	push   $0x8
  jmp alltraps
80105cef:	e9 cf fa ff ff       	jmp    801057c3 <alltraps>

80105cf4 <vector9>:
.globl vector9
vector9:
  pushl $0
80105cf4:	6a 00                	push   $0x0
  pushl $9
80105cf6:	6a 09                	push   $0x9
  jmp alltraps
80105cf8:	e9 c6 fa ff ff       	jmp    801057c3 <alltraps>

80105cfd <vector10>:
.globl vector10
vector10:
  pushl $10
80105cfd:	6a 0a                	push   $0xa
  jmp alltraps
80105cff:	e9 bf fa ff ff       	jmp    801057c3 <alltraps>

80105d04 <vector11>:
.globl vector11
vector11:
  pushl $11
80105d04:	6a 0b                	push   $0xb
  jmp alltraps
80105d06:	e9 b8 fa ff ff       	jmp    801057c3 <alltraps>

80105d0b <vector12>:
.globl vector12
vector12:
  pushl $12
80105d0b:	6a 0c                	push   $0xc
  jmp alltraps
80105d0d:	e9 b1 fa ff ff       	jmp    801057c3 <alltraps>

80105d12 <vector13>:
.globl vector13
vector13:
  pushl $13
80105d12:	6a 0d                	push   $0xd
  jmp alltraps
80105d14:	e9 aa fa ff ff       	jmp    801057c3 <alltraps>

80105d19 <vector14>:
.globl vector14
vector14:
  pushl $14
80105d19:	6a 0e                	push   $0xe
  jmp alltraps
80105d1b:	e9 a3 fa ff ff       	jmp    801057c3 <alltraps>

80105d20 <vector15>:
.globl vector15
vector15:
  pushl $0
80105d20:	6a 00                	push   $0x0
  pushl $15
80105d22:	6a 0f                	push   $0xf
  jmp alltraps
80105d24:	e9 9a fa ff ff       	jmp    801057c3 <alltraps>

80105d29 <vector16>:
.globl vector16
vector16:
  pushl $0
80105d29:	6a 00                	push   $0x0
  pushl $16
80105d2b:	6a 10                	push   $0x10
  jmp alltraps
80105d2d:	e9 91 fa ff ff       	jmp    801057c3 <alltraps>

80105d32 <vector17>:
.globl vector17
vector17:
  pushl $17
80105d32:	6a 11                	push   $0x11
  jmp alltraps
80105d34:	e9 8a fa ff ff       	jmp    801057c3 <alltraps>

80105d39 <vector18>:
.globl vector18
vector18:
  pushl $0
80105d39:	6a 00                	push   $0x0
  pushl $18
80105d3b:	6a 12                	push   $0x12
  jmp alltraps
80105d3d:	e9 81 fa ff ff       	jmp    801057c3 <alltraps>

80105d42 <vector19>:
.globl vector19
vector19:
  pushl $0
80105d42:	6a 00                	push   $0x0
  pushl $19
80105d44:	6a 13                	push   $0x13
  jmp alltraps
80105d46:	e9 78 fa ff ff       	jmp    801057c3 <alltraps>

80105d4b <vector20>:
.globl vector20
vector20:
  pushl $0
80105d4b:	6a 00                	push   $0x0
  pushl $20
80105d4d:	6a 14                	push   $0x14
  jmp alltraps
80105d4f:	e9 6f fa ff ff       	jmp    801057c3 <alltraps>

80105d54 <vector21>:
.globl vector21
vector21:
  pushl $0
80105d54:	6a 00                	push   $0x0
  pushl $21
80105d56:	6a 15                	push   $0x15
  jmp alltraps
80105d58:	e9 66 fa ff ff       	jmp    801057c3 <alltraps>

80105d5d <vector22>:
.globl vector22
vector22:
  pushl $0
80105d5d:	6a 00                	push   $0x0
  pushl $22
80105d5f:	6a 16                	push   $0x16
  jmp alltraps
80105d61:	e9 5d fa ff ff       	jmp    801057c3 <alltraps>

80105d66 <vector23>:
.globl vector23
vector23:
  pushl $0
80105d66:	6a 00                	push   $0x0
  pushl $23
80105d68:	6a 17                	push   $0x17
  jmp alltraps
80105d6a:	e9 54 fa ff ff       	jmp    801057c3 <alltraps>

80105d6f <vector24>:
.globl vector24
vector24:
  pushl $0
80105d6f:	6a 00                	push   $0x0
  pushl $24
80105d71:	6a 18                	push   $0x18
  jmp alltraps
80105d73:	e9 4b fa ff ff       	jmp    801057c3 <alltraps>

80105d78 <vector25>:
.globl vector25
vector25:
  pushl $0
80105d78:	6a 00                	push   $0x0
  pushl $25
80105d7a:	6a 19                	push   $0x19
  jmp alltraps
80105d7c:	e9 42 fa ff ff       	jmp    801057c3 <alltraps>

80105d81 <vector26>:
.globl vector26
vector26:
  pushl $0
80105d81:	6a 00                	push   $0x0
  pushl $26
80105d83:	6a 1a                	push   $0x1a
  jmp alltraps
80105d85:	e9 39 fa ff ff       	jmp    801057c3 <alltraps>

80105d8a <vector27>:
.globl vector27
vector27:
  pushl $0
80105d8a:	6a 00                	push   $0x0
  pushl $27
80105d8c:	6a 1b                	push   $0x1b
  jmp alltraps
80105d8e:	e9 30 fa ff ff       	jmp    801057c3 <alltraps>

80105d93 <vector28>:
.globl vector28
vector28:
  pushl $0
80105d93:	6a 00                	push   $0x0
  pushl $28
80105d95:	6a 1c                	push   $0x1c
  jmp alltraps
80105d97:	e9 27 fa ff ff       	jmp    801057c3 <alltraps>

80105d9c <vector29>:
.globl vector29
vector29:
  pushl $0
80105d9c:	6a 00                	push   $0x0
  pushl $29
80105d9e:	6a 1d                	push   $0x1d
  jmp alltraps
80105da0:	e9 1e fa ff ff       	jmp    801057c3 <alltraps>

80105da5 <vector30>:
.globl vector30
vector30:
  pushl $0
80105da5:	6a 00                	push   $0x0
  pushl $30
80105da7:	6a 1e                	push   $0x1e
  jmp alltraps
80105da9:	e9 15 fa ff ff       	jmp    801057c3 <alltraps>

80105dae <vector31>:
.globl vector31
vector31:
  pushl $0
80105dae:	6a 00                	push   $0x0
  pushl $31
80105db0:	6a 1f                	push   $0x1f
  jmp alltraps
80105db2:	e9 0c fa ff ff       	jmp    801057c3 <alltraps>

80105db7 <vector32>:
.globl vector32
vector32:
  pushl $0
80105db7:	6a 00                	push   $0x0
  pushl $32
80105db9:	6a 20                	push   $0x20
  jmp alltraps
80105dbb:	e9 03 fa ff ff       	jmp    801057c3 <alltraps>

80105dc0 <vector33>:
.globl vector33
vector33:
  pushl $0
80105dc0:	6a 00                	push   $0x0
  pushl $33
80105dc2:	6a 21                	push   $0x21
  jmp alltraps
80105dc4:	e9 fa f9 ff ff       	jmp    801057c3 <alltraps>

80105dc9 <vector34>:
.globl vector34
vector34:
  pushl $0
80105dc9:	6a 00                	push   $0x0
  pushl $34
80105dcb:	6a 22                	push   $0x22
  jmp alltraps
80105dcd:	e9 f1 f9 ff ff       	jmp    801057c3 <alltraps>

80105dd2 <vector35>:
.globl vector35
vector35:
  pushl $0
80105dd2:	6a 00                	push   $0x0
  pushl $35
80105dd4:	6a 23                	push   $0x23
  jmp alltraps
80105dd6:	e9 e8 f9 ff ff       	jmp    801057c3 <alltraps>

80105ddb <vector36>:
.globl vector36
vector36:
  pushl $0
80105ddb:	6a 00                	push   $0x0
  pushl $36
80105ddd:	6a 24                	push   $0x24
  jmp alltraps
80105ddf:	e9 df f9 ff ff       	jmp    801057c3 <alltraps>

80105de4 <vector37>:
.globl vector37
vector37:
  pushl $0
80105de4:	6a 00                	push   $0x0
  pushl $37
80105de6:	6a 25                	push   $0x25
  jmp alltraps
80105de8:	e9 d6 f9 ff ff       	jmp    801057c3 <alltraps>

80105ded <vector38>:
.globl vector38
vector38:
  pushl $0
80105ded:	6a 00                	push   $0x0
  pushl $38
80105def:	6a 26                	push   $0x26
  jmp alltraps
80105df1:	e9 cd f9 ff ff       	jmp    801057c3 <alltraps>

80105df6 <vector39>:
.globl vector39
vector39:
  pushl $0
80105df6:	6a 00                	push   $0x0
  pushl $39
80105df8:	6a 27                	push   $0x27
  jmp alltraps
80105dfa:	e9 c4 f9 ff ff       	jmp    801057c3 <alltraps>

80105dff <vector40>:
.globl vector40
vector40:
  pushl $0
80105dff:	6a 00                	push   $0x0
  pushl $40
80105e01:	6a 28                	push   $0x28
  jmp alltraps
80105e03:	e9 bb f9 ff ff       	jmp    801057c3 <alltraps>

80105e08 <vector41>:
.globl vector41
vector41:
  pushl $0
80105e08:	6a 00                	push   $0x0
  pushl $41
80105e0a:	6a 29                	push   $0x29
  jmp alltraps
80105e0c:	e9 b2 f9 ff ff       	jmp    801057c3 <alltraps>

80105e11 <vector42>:
.globl vector42
vector42:
  pushl $0
80105e11:	6a 00                	push   $0x0
  pushl $42
80105e13:	6a 2a                	push   $0x2a
  jmp alltraps
80105e15:	e9 a9 f9 ff ff       	jmp    801057c3 <alltraps>

80105e1a <vector43>:
.globl vector43
vector43:
  pushl $0
80105e1a:	6a 00                	push   $0x0
  pushl $43
80105e1c:	6a 2b                	push   $0x2b
  jmp alltraps
80105e1e:	e9 a0 f9 ff ff       	jmp    801057c3 <alltraps>

80105e23 <vector44>:
.globl vector44
vector44:
  pushl $0
80105e23:	6a 00                	push   $0x0
  pushl $44
80105e25:	6a 2c                	push   $0x2c
  jmp alltraps
80105e27:	e9 97 f9 ff ff       	jmp    801057c3 <alltraps>

80105e2c <vector45>:
.globl vector45
vector45:
  pushl $0
80105e2c:	6a 00                	push   $0x0
  pushl $45
80105e2e:	6a 2d                	push   $0x2d
  jmp alltraps
80105e30:	e9 8e f9 ff ff       	jmp    801057c3 <alltraps>

80105e35 <vector46>:
.globl vector46
vector46:
  pushl $0
80105e35:	6a 00                	push   $0x0
  pushl $46
80105e37:	6a 2e                	push   $0x2e
  jmp alltraps
80105e39:	e9 85 f9 ff ff       	jmp    801057c3 <alltraps>

80105e3e <vector47>:
.globl vector47
vector47:
  pushl $0
80105e3e:	6a 00                	push   $0x0
  pushl $47
80105e40:	6a 2f                	push   $0x2f
  jmp alltraps
80105e42:	e9 7c f9 ff ff       	jmp    801057c3 <alltraps>

80105e47 <vector48>:
.globl vector48
vector48:
  pushl $0
80105e47:	6a 00                	push   $0x0
  pushl $48
80105e49:	6a 30                	push   $0x30
  jmp alltraps
80105e4b:	e9 73 f9 ff ff       	jmp    801057c3 <alltraps>

80105e50 <vector49>:
.globl vector49
vector49:
  pushl $0
80105e50:	6a 00                	push   $0x0
  pushl $49
80105e52:	6a 31                	push   $0x31
  jmp alltraps
80105e54:	e9 6a f9 ff ff       	jmp    801057c3 <alltraps>

80105e59 <vector50>:
.globl vector50
vector50:
  pushl $0
80105e59:	6a 00                	push   $0x0
  pushl $50
80105e5b:	6a 32                	push   $0x32
  jmp alltraps
80105e5d:	e9 61 f9 ff ff       	jmp    801057c3 <alltraps>

80105e62 <vector51>:
.globl vector51
vector51:
  pushl $0
80105e62:	6a 00                	push   $0x0
  pushl $51
80105e64:	6a 33                	push   $0x33
  jmp alltraps
80105e66:	e9 58 f9 ff ff       	jmp    801057c3 <alltraps>

80105e6b <vector52>:
.globl vector52
vector52:
  pushl $0
80105e6b:	6a 00                	push   $0x0
  pushl $52
80105e6d:	6a 34                	push   $0x34
  jmp alltraps
80105e6f:	e9 4f f9 ff ff       	jmp    801057c3 <alltraps>

80105e74 <vector53>:
.globl vector53
vector53:
  pushl $0
80105e74:	6a 00                	push   $0x0
  pushl $53
80105e76:	6a 35                	push   $0x35
  jmp alltraps
80105e78:	e9 46 f9 ff ff       	jmp    801057c3 <alltraps>

80105e7d <vector54>:
.globl vector54
vector54:
  pushl $0
80105e7d:	6a 00                	push   $0x0
  pushl $54
80105e7f:	6a 36                	push   $0x36
  jmp alltraps
80105e81:	e9 3d f9 ff ff       	jmp    801057c3 <alltraps>

80105e86 <vector55>:
.globl vector55
vector55:
  pushl $0
80105e86:	6a 00                	push   $0x0
  pushl $55
80105e88:	6a 37                	push   $0x37
  jmp alltraps
80105e8a:	e9 34 f9 ff ff       	jmp    801057c3 <alltraps>

80105e8f <vector56>:
.globl vector56
vector56:
  pushl $0
80105e8f:	6a 00                	push   $0x0
  pushl $56
80105e91:	6a 38                	push   $0x38
  jmp alltraps
80105e93:	e9 2b f9 ff ff       	jmp    801057c3 <alltraps>

80105e98 <vector57>:
.globl vector57
vector57:
  pushl $0
80105e98:	6a 00                	push   $0x0
  pushl $57
80105e9a:	6a 39                	push   $0x39
  jmp alltraps
80105e9c:	e9 22 f9 ff ff       	jmp    801057c3 <alltraps>

80105ea1 <vector58>:
.globl vector58
vector58:
  pushl $0
80105ea1:	6a 00                	push   $0x0
  pushl $58
80105ea3:	6a 3a                	push   $0x3a
  jmp alltraps
80105ea5:	e9 19 f9 ff ff       	jmp    801057c3 <alltraps>

80105eaa <vector59>:
.globl vector59
vector59:
  pushl $0
80105eaa:	6a 00                	push   $0x0
  pushl $59
80105eac:	6a 3b                	push   $0x3b
  jmp alltraps
80105eae:	e9 10 f9 ff ff       	jmp    801057c3 <alltraps>

80105eb3 <vector60>:
.globl vector60
vector60:
  pushl $0
80105eb3:	6a 00                	push   $0x0
  pushl $60
80105eb5:	6a 3c                	push   $0x3c
  jmp alltraps
80105eb7:	e9 07 f9 ff ff       	jmp    801057c3 <alltraps>

80105ebc <vector61>:
.globl vector61
vector61:
  pushl $0
80105ebc:	6a 00                	push   $0x0
  pushl $61
80105ebe:	6a 3d                	push   $0x3d
  jmp alltraps
80105ec0:	e9 fe f8 ff ff       	jmp    801057c3 <alltraps>

80105ec5 <vector62>:
.globl vector62
vector62:
  pushl $0
80105ec5:	6a 00                	push   $0x0
  pushl $62
80105ec7:	6a 3e                	push   $0x3e
  jmp alltraps
80105ec9:	e9 f5 f8 ff ff       	jmp    801057c3 <alltraps>

80105ece <vector63>:
.globl vector63
vector63:
  pushl $0
80105ece:	6a 00                	push   $0x0
  pushl $63
80105ed0:	6a 3f                	push   $0x3f
  jmp alltraps
80105ed2:	e9 ec f8 ff ff       	jmp    801057c3 <alltraps>

80105ed7 <vector64>:
.globl vector64
vector64:
  pushl $0
80105ed7:	6a 00                	push   $0x0
  pushl $64
80105ed9:	6a 40                	push   $0x40
  jmp alltraps
80105edb:	e9 e3 f8 ff ff       	jmp    801057c3 <alltraps>

80105ee0 <vector65>:
.globl vector65
vector65:
  pushl $0
80105ee0:	6a 00                	push   $0x0
  pushl $65
80105ee2:	6a 41                	push   $0x41
  jmp alltraps
80105ee4:	e9 da f8 ff ff       	jmp    801057c3 <alltraps>

80105ee9 <vector66>:
.globl vector66
vector66:
  pushl $0
80105ee9:	6a 00                	push   $0x0
  pushl $66
80105eeb:	6a 42                	push   $0x42
  jmp alltraps
80105eed:	e9 d1 f8 ff ff       	jmp    801057c3 <alltraps>

80105ef2 <vector67>:
.globl vector67
vector67:
  pushl $0
80105ef2:	6a 00                	push   $0x0
  pushl $67
80105ef4:	6a 43                	push   $0x43
  jmp alltraps
80105ef6:	e9 c8 f8 ff ff       	jmp    801057c3 <alltraps>

80105efb <vector68>:
.globl vector68
vector68:
  pushl $0
80105efb:	6a 00                	push   $0x0
  pushl $68
80105efd:	6a 44                	push   $0x44
  jmp alltraps
80105eff:	e9 bf f8 ff ff       	jmp    801057c3 <alltraps>

80105f04 <vector69>:
.globl vector69
vector69:
  pushl $0
80105f04:	6a 00                	push   $0x0
  pushl $69
80105f06:	6a 45                	push   $0x45
  jmp alltraps
80105f08:	e9 b6 f8 ff ff       	jmp    801057c3 <alltraps>

80105f0d <vector70>:
.globl vector70
vector70:
  pushl $0
80105f0d:	6a 00                	push   $0x0
  pushl $70
80105f0f:	6a 46                	push   $0x46
  jmp alltraps
80105f11:	e9 ad f8 ff ff       	jmp    801057c3 <alltraps>

80105f16 <vector71>:
.globl vector71
vector71:
  pushl $0
80105f16:	6a 00                	push   $0x0
  pushl $71
80105f18:	6a 47                	push   $0x47
  jmp alltraps
80105f1a:	e9 a4 f8 ff ff       	jmp    801057c3 <alltraps>

80105f1f <vector72>:
.globl vector72
vector72:
  pushl $0
80105f1f:	6a 00                	push   $0x0
  pushl $72
80105f21:	6a 48                	push   $0x48
  jmp alltraps
80105f23:	e9 9b f8 ff ff       	jmp    801057c3 <alltraps>

80105f28 <vector73>:
.globl vector73
vector73:
  pushl $0
80105f28:	6a 00                	push   $0x0
  pushl $73
80105f2a:	6a 49                	push   $0x49
  jmp alltraps
80105f2c:	e9 92 f8 ff ff       	jmp    801057c3 <alltraps>

80105f31 <vector74>:
.globl vector74
vector74:
  pushl $0
80105f31:	6a 00                	push   $0x0
  pushl $74
80105f33:	6a 4a                	push   $0x4a
  jmp alltraps
80105f35:	e9 89 f8 ff ff       	jmp    801057c3 <alltraps>

80105f3a <vector75>:
.globl vector75
vector75:
  pushl $0
80105f3a:	6a 00                	push   $0x0
  pushl $75
80105f3c:	6a 4b                	push   $0x4b
  jmp alltraps
80105f3e:	e9 80 f8 ff ff       	jmp    801057c3 <alltraps>

80105f43 <vector76>:
.globl vector76
vector76:
  pushl $0
80105f43:	6a 00                	push   $0x0
  pushl $76
80105f45:	6a 4c                	push   $0x4c
  jmp alltraps
80105f47:	e9 77 f8 ff ff       	jmp    801057c3 <alltraps>

80105f4c <vector77>:
.globl vector77
vector77:
  pushl $0
80105f4c:	6a 00                	push   $0x0
  pushl $77
80105f4e:	6a 4d                	push   $0x4d
  jmp alltraps
80105f50:	e9 6e f8 ff ff       	jmp    801057c3 <alltraps>

80105f55 <vector78>:
.globl vector78
vector78:
  pushl $0
80105f55:	6a 00                	push   $0x0
  pushl $78
80105f57:	6a 4e                	push   $0x4e
  jmp alltraps
80105f59:	e9 65 f8 ff ff       	jmp    801057c3 <alltraps>

80105f5e <vector79>:
.globl vector79
vector79:
  pushl $0
80105f5e:	6a 00                	push   $0x0
  pushl $79
80105f60:	6a 4f                	push   $0x4f
  jmp alltraps
80105f62:	e9 5c f8 ff ff       	jmp    801057c3 <alltraps>

80105f67 <vector80>:
.globl vector80
vector80:
  pushl $0
80105f67:	6a 00                	push   $0x0
  pushl $80
80105f69:	6a 50                	push   $0x50
  jmp alltraps
80105f6b:	e9 53 f8 ff ff       	jmp    801057c3 <alltraps>

80105f70 <vector81>:
.globl vector81
vector81:
  pushl $0
80105f70:	6a 00                	push   $0x0
  pushl $81
80105f72:	6a 51                	push   $0x51
  jmp alltraps
80105f74:	e9 4a f8 ff ff       	jmp    801057c3 <alltraps>

80105f79 <vector82>:
.globl vector82
vector82:
  pushl $0
80105f79:	6a 00                	push   $0x0
  pushl $82
80105f7b:	6a 52                	push   $0x52
  jmp alltraps
80105f7d:	e9 41 f8 ff ff       	jmp    801057c3 <alltraps>

80105f82 <vector83>:
.globl vector83
vector83:
  pushl $0
80105f82:	6a 00                	push   $0x0
  pushl $83
80105f84:	6a 53                	push   $0x53
  jmp alltraps
80105f86:	e9 38 f8 ff ff       	jmp    801057c3 <alltraps>

80105f8b <vector84>:
.globl vector84
vector84:
  pushl $0
80105f8b:	6a 00                	push   $0x0
  pushl $84
80105f8d:	6a 54                	push   $0x54
  jmp alltraps
80105f8f:	e9 2f f8 ff ff       	jmp    801057c3 <alltraps>

80105f94 <vector85>:
.globl vector85
vector85:
  pushl $0
80105f94:	6a 00                	push   $0x0
  pushl $85
80105f96:	6a 55                	push   $0x55
  jmp alltraps
80105f98:	e9 26 f8 ff ff       	jmp    801057c3 <alltraps>

80105f9d <vector86>:
.globl vector86
vector86:
  pushl $0
80105f9d:	6a 00                	push   $0x0
  pushl $86
80105f9f:	6a 56                	push   $0x56
  jmp alltraps
80105fa1:	e9 1d f8 ff ff       	jmp    801057c3 <alltraps>

80105fa6 <vector87>:
.globl vector87
vector87:
  pushl $0
80105fa6:	6a 00                	push   $0x0
  pushl $87
80105fa8:	6a 57                	push   $0x57
  jmp alltraps
80105faa:	e9 14 f8 ff ff       	jmp    801057c3 <alltraps>

80105faf <vector88>:
.globl vector88
vector88:
  pushl $0
80105faf:	6a 00                	push   $0x0
  pushl $88
80105fb1:	6a 58                	push   $0x58
  jmp alltraps
80105fb3:	e9 0b f8 ff ff       	jmp    801057c3 <alltraps>

80105fb8 <vector89>:
.globl vector89
vector89:
  pushl $0
80105fb8:	6a 00                	push   $0x0
  pushl $89
80105fba:	6a 59                	push   $0x59
  jmp alltraps
80105fbc:	e9 02 f8 ff ff       	jmp    801057c3 <alltraps>

80105fc1 <vector90>:
.globl vector90
vector90:
  pushl $0
80105fc1:	6a 00                	push   $0x0
  pushl $90
80105fc3:	6a 5a                	push   $0x5a
  jmp alltraps
80105fc5:	e9 f9 f7 ff ff       	jmp    801057c3 <alltraps>

80105fca <vector91>:
.globl vector91
vector91:
  pushl $0
80105fca:	6a 00                	push   $0x0
  pushl $91
80105fcc:	6a 5b                	push   $0x5b
  jmp alltraps
80105fce:	e9 f0 f7 ff ff       	jmp    801057c3 <alltraps>

80105fd3 <vector92>:
.globl vector92
vector92:
  pushl $0
80105fd3:	6a 00                	push   $0x0
  pushl $92
80105fd5:	6a 5c                	push   $0x5c
  jmp alltraps
80105fd7:	e9 e7 f7 ff ff       	jmp    801057c3 <alltraps>

80105fdc <vector93>:
.globl vector93
vector93:
  pushl $0
80105fdc:	6a 00                	push   $0x0
  pushl $93
80105fde:	6a 5d                	push   $0x5d
  jmp alltraps
80105fe0:	e9 de f7 ff ff       	jmp    801057c3 <alltraps>

80105fe5 <vector94>:
.globl vector94
vector94:
  pushl $0
80105fe5:	6a 00                	push   $0x0
  pushl $94
80105fe7:	6a 5e                	push   $0x5e
  jmp alltraps
80105fe9:	e9 d5 f7 ff ff       	jmp    801057c3 <alltraps>

80105fee <vector95>:
.globl vector95
vector95:
  pushl $0
80105fee:	6a 00                	push   $0x0
  pushl $95
80105ff0:	6a 5f                	push   $0x5f
  jmp alltraps
80105ff2:	e9 cc f7 ff ff       	jmp    801057c3 <alltraps>

80105ff7 <vector96>:
.globl vector96
vector96:
  pushl $0
80105ff7:	6a 00                	push   $0x0
  pushl $96
80105ff9:	6a 60                	push   $0x60
  jmp alltraps
80105ffb:	e9 c3 f7 ff ff       	jmp    801057c3 <alltraps>

80106000 <vector97>:
.globl vector97
vector97:
  pushl $0
80106000:	6a 00                	push   $0x0
  pushl $97
80106002:	6a 61                	push   $0x61
  jmp alltraps
80106004:	e9 ba f7 ff ff       	jmp    801057c3 <alltraps>

80106009 <vector98>:
.globl vector98
vector98:
  pushl $0
80106009:	6a 00                	push   $0x0
  pushl $98
8010600b:	6a 62                	push   $0x62
  jmp alltraps
8010600d:	e9 b1 f7 ff ff       	jmp    801057c3 <alltraps>

80106012 <vector99>:
.globl vector99
vector99:
  pushl $0
80106012:	6a 00                	push   $0x0
  pushl $99
80106014:	6a 63                	push   $0x63
  jmp alltraps
80106016:	e9 a8 f7 ff ff       	jmp    801057c3 <alltraps>

8010601b <vector100>:
.globl vector100
vector100:
  pushl $0
8010601b:	6a 00                	push   $0x0
  pushl $100
8010601d:	6a 64                	push   $0x64
  jmp alltraps
8010601f:	e9 9f f7 ff ff       	jmp    801057c3 <alltraps>

80106024 <vector101>:
.globl vector101
vector101:
  pushl $0
80106024:	6a 00                	push   $0x0
  pushl $101
80106026:	6a 65                	push   $0x65
  jmp alltraps
80106028:	e9 96 f7 ff ff       	jmp    801057c3 <alltraps>

8010602d <vector102>:
.globl vector102
vector102:
  pushl $0
8010602d:	6a 00                	push   $0x0
  pushl $102
8010602f:	6a 66                	push   $0x66
  jmp alltraps
80106031:	e9 8d f7 ff ff       	jmp    801057c3 <alltraps>

80106036 <vector103>:
.globl vector103
vector103:
  pushl $0
80106036:	6a 00                	push   $0x0
  pushl $103
80106038:	6a 67                	push   $0x67
  jmp alltraps
8010603a:	e9 84 f7 ff ff       	jmp    801057c3 <alltraps>

8010603f <vector104>:
.globl vector104
vector104:
  pushl $0
8010603f:	6a 00                	push   $0x0
  pushl $104
80106041:	6a 68                	push   $0x68
  jmp alltraps
80106043:	e9 7b f7 ff ff       	jmp    801057c3 <alltraps>

80106048 <vector105>:
.globl vector105
vector105:
  pushl $0
80106048:	6a 00                	push   $0x0
  pushl $105
8010604a:	6a 69                	push   $0x69
  jmp alltraps
8010604c:	e9 72 f7 ff ff       	jmp    801057c3 <alltraps>

80106051 <vector106>:
.globl vector106
vector106:
  pushl $0
80106051:	6a 00                	push   $0x0
  pushl $106
80106053:	6a 6a                	push   $0x6a
  jmp alltraps
80106055:	e9 69 f7 ff ff       	jmp    801057c3 <alltraps>

8010605a <vector107>:
.globl vector107
vector107:
  pushl $0
8010605a:	6a 00                	push   $0x0
  pushl $107
8010605c:	6a 6b                	push   $0x6b
  jmp alltraps
8010605e:	e9 60 f7 ff ff       	jmp    801057c3 <alltraps>

80106063 <vector108>:
.globl vector108
vector108:
  pushl $0
80106063:	6a 00                	push   $0x0
  pushl $108
80106065:	6a 6c                	push   $0x6c
  jmp alltraps
80106067:	e9 57 f7 ff ff       	jmp    801057c3 <alltraps>

8010606c <vector109>:
.globl vector109
vector109:
  pushl $0
8010606c:	6a 00                	push   $0x0
  pushl $109
8010606e:	6a 6d                	push   $0x6d
  jmp alltraps
80106070:	e9 4e f7 ff ff       	jmp    801057c3 <alltraps>

80106075 <vector110>:
.globl vector110
vector110:
  pushl $0
80106075:	6a 00                	push   $0x0
  pushl $110
80106077:	6a 6e                	push   $0x6e
  jmp alltraps
80106079:	e9 45 f7 ff ff       	jmp    801057c3 <alltraps>

8010607e <vector111>:
.globl vector111
vector111:
  pushl $0
8010607e:	6a 00                	push   $0x0
  pushl $111
80106080:	6a 6f                	push   $0x6f
  jmp alltraps
80106082:	e9 3c f7 ff ff       	jmp    801057c3 <alltraps>

80106087 <vector112>:
.globl vector112
vector112:
  pushl $0
80106087:	6a 00                	push   $0x0
  pushl $112
80106089:	6a 70                	push   $0x70
  jmp alltraps
8010608b:	e9 33 f7 ff ff       	jmp    801057c3 <alltraps>

80106090 <vector113>:
.globl vector113
vector113:
  pushl $0
80106090:	6a 00                	push   $0x0
  pushl $113
80106092:	6a 71                	push   $0x71
  jmp alltraps
80106094:	e9 2a f7 ff ff       	jmp    801057c3 <alltraps>

80106099 <vector114>:
.globl vector114
vector114:
  pushl $0
80106099:	6a 00                	push   $0x0
  pushl $114
8010609b:	6a 72                	push   $0x72
  jmp alltraps
8010609d:	e9 21 f7 ff ff       	jmp    801057c3 <alltraps>

801060a2 <vector115>:
.globl vector115
vector115:
  pushl $0
801060a2:	6a 00                	push   $0x0
  pushl $115
801060a4:	6a 73                	push   $0x73
  jmp alltraps
801060a6:	e9 18 f7 ff ff       	jmp    801057c3 <alltraps>

801060ab <vector116>:
.globl vector116
vector116:
  pushl $0
801060ab:	6a 00                	push   $0x0
  pushl $116
801060ad:	6a 74                	push   $0x74
  jmp alltraps
801060af:	e9 0f f7 ff ff       	jmp    801057c3 <alltraps>

801060b4 <vector117>:
.globl vector117
vector117:
  pushl $0
801060b4:	6a 00                	push   $0x0
  pushl $117
801060b6:	6a 75                	push   $0x75
  jmp alltraps
801060b8:	e9 06 f7 ff ff       	jmp    801057c3 <alltraps>

801060bd <vector118>:
.globl vector118
vector118:
  pushl $0
801060bd:	6a 00                	push   $0x0
  pushl $118
801060bf:	6a 76                	push   $0x76
  jmp alltraps
801060c1:	e9 fd f6 ff ff       	jmp    801057c3 <alltraps>

801060c6 <vector119>:
.globl vector119
vector119:
  pushl $0
801060c6:	6a 00                	push   $0x0
  pushl $119
801060c8:	6a 77                	push   $0x77
  jmp alltraps
801060ca:	e9 f4 f6 ff ff       	jmp    801057c3 <alltraps>

801060cf <vector120>:
.globl vector120
vector120:
  pushl $0
801060cf:	6a 00                	push   $0x0
  pushl $120
801060d1:	6a 78                	push   $0x78
  jmp alltraps
801060d3:	e9 eb f6 ff ff       	jmp    801057c3 <alltraps>

801060d8 <vector121>:
.globl vector121
vector121:
  pushl $0
801060d8:	6a 00                	push   $0x0
  pushl $121
801060da:	6a 79                	push   $0x79
  jmp alltraps
801060dc:	e9 e2 f6 ff ff       	jmp    801057c3 <alltraps>

801060e1 <vector122>:
.globl vector122
vector122:
  pushl $0
801060e1:	6a 00                	push   $0x0
  pushl $122
801060e3:	6a 7a                	push   $0x7a
  jmp alltraps
801060e5:	e9 d9 f6 ff ff       	jmp    801057c3 <alltraps>

801060ea <vector123>:
.globl vector123
vector123:
  pushl $0
801060ea:	6a 00                	push   $0x0
  pushl $123
801060ec:	6a 7b                	push   $0x7b
  jmp alltraps
801060ee:	e9 d0 f6 ff ff       	jmp    801057c3 <alltraps>

801060f3 <vector124>:
.globl vector124
vector124:
  pushl $0
801060f3:	6a 00                	push   $0x0
  pushl $124
801060f5:	6a 7c                	push   $0x7c
  jmp alltraps
801060f7:	e9 c7 f6 ff ff       	jmp    801057c3 <alltraps>

801060fc <vector125>:
.globl vector125
vector125:
  pushl $0
801060fc:	6a 00                	push   $0x0
  pushl $125
801060fe:	6a 7d                	push   $0x7d
  jmp alltraps
80106100:	e9 be f6 ff ff       	jmp    801057c3 <alltraps>

80106105 <vector126>:
.globl vector126
vector126:
  pushl $0
80106105:	6a 00                	push   $0x0
  pushl $126
80106107:	6a 7e                	push   $0x7e
  jmp alltraps
80106109:	e9 b5 f6 ff ff       	jmp    801057c3 <alltraps>

8010610e <vector127>:
.globl vector127
vector127:
  pushl $0
8010610e:	6a 00                	push   $0x0
  pushl $127
80106110:	6a 7f                	push   $0x7f
  jmp alltraps
80106112:	e9 ac f6 ff ff       	jmp    801057c3 <alltraps>

80106117 <vector128>:
.globl vector128
vector128:
  pushl $0
80106117:	6a 00                	push   $0x0
  pushl $128
80106119:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010611e:	e9 a0 f6 ff ff       	jmp    801057c3 <alltraps>

80106123 <vector129>:
.globl vector129
vector129:
  pushl $0
80106123:	6a 00                	push   $0x0
  pushl $129
80106125:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010612a:	e9 94 f6 ff ff       	jmp    801057c3 <alltraps>

8010612f <vector130>:
.globl vector130
vector130:
  pushl $0
8010612f:	6a 00                	push   $0x0
  pushl $130
80106131:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106136:	e9 88 f6 ff ff       	jmp    801057c3 <alltraps>

8010613b <vector131>:
.globl vector131
vector131:
  pushl $0
8010613b:	6a 00                	push   $0x0
  pushl $131
8010613d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106142:	e9 7c f6 ff ff       	jmp    801057c3 <alltraps>

80106147 <vector132>:
.globl vector132
vector132:
  pushl $0
80106147:	6a 00                	push   $0x0
  pushl $132
80106149:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010614e:	e9 70 f6 ff ff       	jmp    801057c3 <alltraps>

80106153 <vector133>:
.globl vector133
vector133:
  pushl $0
80106153:	6a 00                	push   $0x0
  pushl $133
80106155:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010615a:	e9 64 f6 ff ff       	jmp    801057c3 <alltraps>

8010615f <vector134>:
.globl vector134
vector134:
  pushl $0
8010615f:	6a 00                	push   $0x0
  pushl $134
80106161:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106166:	e9 58 f6 ff ff       	jmp    801057c3 <alltraps>

8010616b <vector135>:
.globl vector135
vector135:
  pushl $0
8010616b:	6a 00                	push   $0x0
  pushl $135
8010616d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106172:	e9 4c f6 ff ff       	jmp    801057c3 <alltraps>

80106177 <vector136>:
.globl vector136
vector136:
  pushl $0
80106177:	6a 00                	push   $0x0
  pushl $136
80106179:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010617e:	e9 40 f6 ff ff       	jmp    801057c3 <alltraps>

80106183 <vector137>:
.globl vector137
vector137:
  pushl $0
80106183:	6a 00                	push   $0x0
  pushl $137
80106185:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010618a:	e9 34 f6 ff ff       	jmp    801057c3 <alltraps>

8010618f <vector138>:
.globl vector138
vector138:
  pushl $0
8010618f:	6a 00                	push   $0x0
  pushl $138
80106191:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106196:	e9 28 f6 ff ff       	jmp    801057c3 <alltraps>

8010619b <vector139>:
.globl vector139
vector139:
  pushl $0
8010619b:	6a 00                	push   $0x0
  pushl $139
8010619d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801061a2:	e9 1c f6 ff ff       	jmp    801057c3 <alltraps>

801061a7 <vector140>:
.globl vector140
vector140:
  pushl $0
801061a7:	6a 00                	push   $0x0
  pushl $140
801061a9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801061ae:	e9 10 f6 ff ff       	jmp    801057c3 <alltraps>

801061b3 <vector141>:
.globl vector141
vector141:
  pushl $0
801061b3:	6a 00                	push   $0x0
  pushl $141
801061b5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801061ba:	e9 04 f6 ff ff       	jmp    801057c3 <alltraps>

801061bf <vector142>:
.globl vector142
vector142:
  pushl $0
801061bf:	6a 00                	push   $0x0
  pushl $142
801061c1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801061c6:	e9 f8 f5 ff ff       	jmp    801057c3 <alltraps>

801061cb <vector143>:
.globl vector143
vector143:
  pushl $0
801061cb:	6a 00                	push   $0x0
  pushl $143
801061cd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801061d2:	e9 ec f5 ff ff       	jmp    801057c3 <alltraps>

801061d7 <vector144>:
.globl vector144
vector144:
  pushl $0
801061d7:	6a 00                	push   $0x0
  pushl $144
801061d9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801061de:	e9 e0 f5 ff ff       	jmp    801057c3 <alltraps>

801061e3 <vector145>:
.globl vector145
vector145:
  pushl $0
801061e3:	6a 00                	push   $0x0
  pushl $145
801061e5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801061ea:	e9 d4 f5 ff ff       	jmp    801057c3 <alltraps>

801061ef <vector146>:
.globl vector146
vector146:
  pushl $0
801061ef:	6a 00                	push   $0x0
  pushl $146
801061f1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801061f6:	e9 c8 f5 ff ff       	jmp    801057c3 <alltraps>

801061fb <vector147>:
.globl vector147
vector147:
  pushl $0
801061fb:	6a 00                	push   $0x0
  pushl $147
801061fd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106202:	e9 bc f5 ff ff       	jmp    801057c3 <alltraps>

80106207 <vector148>:
.globl vector148
vector148:
  pushl $0
80106207:	6a 00                	push   $0x0
  pushl $148
80106209:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010620e:	e9 b0 f5 ff ff       	jmp    801057c3 <alltraps>

80106213 <vector149>:
.globl vector149
vector149:
  pushl $0
80106213:	6a 00                	push   $0x0
  pushl $149
80106215:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010621a:	e9 a4 f5 ff ff       	jmp    801057c3 <alltraps>

8010621f <vector150>:
.globl vector150
vector150:
  pushl $0
8010621f:	6a 00                	push   $0x0
  pushl $150
80106221:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106226:	e9 98 f5 ff ff       	jmp    801057c3 <alltraps>

8010622b <vector151>:
.globl vector151
vector151:
  pushl $0
8010622b:	6a 00                	push   $0x0
  pushl $151
8010622d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106232:	e9 8c f5 ff ff       	jmp    801057c3 <alltraps>

80106237 <vector152>:
.globl vector152
vector152:
  pushl $0
80106237:	6a 00                	push   $0x0
  pushl $152
80106239:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010623e:	e9 80 f5 ff ff       	jmp    801057c3 <alltraps>

80106243 <vector153>:
.globl vector153
vector153:
  pushl $0
80106243:	6a 00                	push   $0x0
  pushl $153
80106245:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010624a:	e9 74 f5 ff ff       	jmp    801057c3 <alltraps>

8010624f <vector154>:
.globl vector154
vector154:
  pushl $0
8010624f:	6a 00                	push   $0x0
  pushl $154
80106251:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106256:	e9 68 f5 ff ff       	jmp    801057c3 <alltraps>

8010625b <vector155>:
.globl vector155
vector155:
  pushl $0
8010625b:	6a 00                	push   $0x0
  pushl $155
8010625d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106262:	e9 5c f5 ff ff       	jmp    801057c3 <alltraps>

80106267 <vector156>:
.globl vector156
vector156:
  pushl $0
80106267:	6a 00                	push   $0x0
  pushl $156
80106269:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010626e:	e9 50 f5 ff ff       	jmp    801057c3 <alltraps>

80106273 <vector157>:
.globl vector157
vector157:
  pushl $0
80106273:	6a 00                	push   $0x0
  pushl $157
80106275:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010627a:	e9 44 f5 ff ff       	jmp    801057c3 <alltraps>

8010627f <vector158>:
.globl vector158
vector158:
  pushl $0
8010627f:	6a 00                	push   $0x0
  pushl $158
80106281:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106286:	e9 38 f5 ff ff       	jmp    801057c3 <alltraps>

8010628b <vector159>:
.globl vector159
vector159:
  pushl $0
8010628b:	6a 00                	push   $0x0
  pushl $159
8010628d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106292:	e9 2c f5 ff ff       	jmp    801057c3 <alltraps>

80106297 <vector160>:
.globl vector160
vector160:
  pushl $0
80106297:	6a 00                	push   $0x0
  pushl $160
80106299:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010629e:	e9 20 f5 ff ff       	jmp    801057c3 <alltraps>

801062a3 <vector161>:
.globl vector161
vector161:
  pushl $0
801062a3:	6a 00                	push   $0x0
  pushl $161
801062a5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801062aa:	e9 14 f5 ff ff       	jmp    801057c3 <alltraps>

801062af <vector162>:
.globl vector162
vector162:
  pushl $0
801062af:	6a 00                	push   $0x0
  pushl $162
801062b1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801062b6:	e9 08 f5 ff ff       	jmp    801057c3 <alltraps>

801062bb <vector163>:
.globl vector163
vector163:
  pushl $0
801062bb:	6a 00                	push   $0x0
  pushl $163
801062bd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801062c2:	e9 fc f4 ff ff       	jmp    801057c3 <alltraps>

801062c7 <vector164>:
.globl vector164
vector164:
  pushl $0
801062c7:	6a 00                	push   $0x0
  pushl $164
801062c9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801062ce:	e9 f0 f4 ff ff       	jmp    801057c3 <alltraps>

801062d3 <vector165>:
.globl vector165
vector165:
  pushl $0
801062d3:	6a 00                	push   $0x0
  pushl $165
801062d5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801062da:	e9 e4 f4 ff ff       	jmp    801057c3 <alltraps>

801062df <vector166>:
.globl vector166
vector166:
  pushl $0
801062df:	6a 00                	push   $0x0
  pushl $166
801062e1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801062e6:	e9 d8 f4 ff ff       	jmp    801057c3 <alltraps>

801062eb <vector167>:
.globl vector167
vector167:
  pushl $0
801062eb:	6a 00                	push   $0x0
  pushl $167
801062ed:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801062f2:	e9 cc f4 ff ff       	jmp    801057c3 <alltraps>

801062f7 <vector168>:
.globl vector168
vector168:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $168
801062f9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801062fe:	e9 c0 f4 ff ff       	jmp    801057c3 <alltraps>

80106303 <vector169>:
.globl vector169
vector169:
  pushl $0
80106303:	6a 00                	push   $0x0
  pushl $169
80106305:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010630a:	e9 b4 f4 ff ff       	jmp    801057c3 <alltraps>

8010630f <vector170>:
.globl vector170
vector170:
  pushl $0
8010630f:	6a 00                	push   $0x0
  pushl $170
80106311:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106316:	e9 a8 f4 ff ff       	jmp    801057c3 <alltraps>

8010631b <vector171>:
.globl vector171
vector171:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $171
8010631d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106322:	e9 9c f4 ff ff       	jmp    801057c3 <alltraps>

80106327 <vector172>:
.globl vector172
vector172:
  pushl $0
80106327:	6a 00                	push   $0x0
  pushl $172
80106329:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010632e:	e9 90 f4 ff ff       	jmp    801057c3 <alltraps>

80106333 <vector173>:
.globl vector173
vector173:
  pushl $0
80106333:	6a 00                	push   $0x0
  pushl $173
80106335:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010633a:	e9 84 f4 ff ff       	jmp    801057c3 <alltraps>

8010633f <vector174>:
.globl vector174
vector174:
  pushl $0
8010633f:	6a 00                	push   $0x0
  pushl $174
80106341:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106346:	e9 78 f4 ff ff       	jmp    801057c3 <alltraps>

8010634b <vector175>:
.globl vector175
vector175:
  pushl $0
8010634b:	6a 00                	push   $0x0
  pushl $175
8010634d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106352:	e9 6c f4 ff ff       	jmp    801057c3 <alltraps>

80106357 <vector176>:
.globl vector176
vector176:
  pushl $0
80106357:	6a 00                	push   $0x0
  pushl $176
80106359:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010635e:	e9 60 f4 ff ff       	jmp    801057c3 <alltraps>

80106363 <vector177>:
.globl vector177
vector177:
  pushl $0
80106363:	6a 00                	push   $0x0
  pushl $177
80106365:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010636a:	e9 54 f4 ff ff       	jmp    801057c3 <alltraps>

8010636f <vector178>:
.globl vector178
vector178:
  pushl $0
8010636f:	6a 00                	push   $0x0
  pushl $178
80106371:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106376:	e9 48 f4 ff ff       	jmp    801057c3 <alltraps>

8010637b <vector179>:
.globl vector179
vector179:
  pushl $0
8010637b:	6a 00                	push   $0x0
  pushl $179
8010637d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106382:	e9 3c f4 ff ff       	jmp    801057c3 <alltraps>

80106387 <vector180>:
.globl vector180
vector180:
  pushl $0
80106387:	6a 00                	push   $0x0
  pushl $180
80106389:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010638e:	e9 30 f4 ff ff       	jmp    801057c3 <alltraps>

80106393 <vector181>:
.globl vector181
vector181:
  pushl $0
80106393:	6a 00                	push   $0x0
  pushl $181
80106395:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010639a:	e9 24 f4 ff ff       	jmp    801057c3 <alltraps>

8010639f <vector182>:
.globl vector182
vector182:
  pushl $0
8010639f:	6a 00                	push   $0x0
  pushl $182
801063a1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801063a6:	e9 18 f4 ff ff       	jmp    801057c3 <alltraps>

801063ab <vector183>:
.globl vector183
vector183:
  pushl $0
801063ab:	6a 00                	push   $0x0
  pushl $183
801063ad:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801063b2:	e9 0c f4 ff ff       	jmp    801057c3 <alltraps>

801063b7 <vector184>:
.globl vector184
vector184:
  pushl $0
801063b7:	6a 00                	push   $0x0
  pushl $184
801063b9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801063be:	e9 00 f4 ff ff       	jmp    801057c3 <alltraps>

801063c3 <vector185>:
.globl vector185
vector185:
  pushl $0
801063c3:	6a 00                	push   $0x0
  pushl $185
801063c5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801063ca:	e9 f4 f3 ff ff       	jmp    801057c3 <alltraps>

801063cf <vector186>:
.globl vector186
vector186:
  pushl $0
801063cf:	6a 00                	push   $0x0
  pushl $186
801063d1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801063d6:	e9 e8 f3 ff ff       	jmp    801057c3 <alltraps>

801063db <vector187>:
.globl vector187
vector187:
  pushl $0
801063db:	6a 00                	push   $0x0
  pushl $187
801063dd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801063e2:	e9 dc f3 ff ff       	jmp    801057c3 <alltraps>

801063e7 <vector188>:
.globl vector188
vector188:
  pushl $0
801063e7:	6a 00                	push   $0x0
  pushl $188
801063e9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801063ee:	e9 d0 f3 ff ff       	jmp    801057c3 <alltraps>

801063f3 <vector189>:
.globl vector189
vector189:
  pushl $0
801063f3:	6a 00                	push   $0x0
  pushl $189
801063f5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801063fa:	e9 c4 f3 ff ff       	jmp    801057c3 <alltraps>

801063ff <vector190>:
.globl vector190
vector190:
  pushl $0
801063ff:	6a 00                	push   $0x0
  pushl $190
80106401:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106406:	e9 b8 f3 ff ff       	jmp    801057c3 <alltraps>

8010640b <vector191>:
.globl vector191
vector191:
  pushl $0
8010640b:	6a 00                	push   $0x0
  pushl $191
8010640d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106412:	e9 ac f3 ff ff       	jmp    801057c3 <alltraps>

80106417 <vector192>:
.globl vector192
vector192:
  pushl $0
80106417:	6a 00                	push   $0x0
  pushl $192
80106419:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010641e:	e9 a0 f3 ff ff       	jmp    801057c3 <alltraps>

80106423 <vector193>:
.globl vector193
vector193:
  pushl $0
80106423:	6a 00                	push   $0x0
  pushl $193
80106425:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010642a:	e9 94 f3 ff ff       	jmp    801057c3 <alltraps>

8010642f <vector194>:
.globl vector194
vector194:
  pushl $0
8010642f:	6a 00                	push   $0x0
  pushl $194
80106431:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106436:	e9 88 f3 ff ff       	jmp    801057c3 <alltraps>

8010643b <vector195>:
.globl vector195
vector195:
  pushl $0
8010643b:	6a 00                	push   $0x0
  pushl $195
8010643d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106442:	e9 7c f3 ff ff       	jmp    801057c3 <alltraps>

80106447 <vector196>:
.globl vector196
vector196:
  pushl $0
80106447:	6a 00                	push   $0x0
  pushl $196
80106449:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010644e:	e9 70 f3 ff ff       	jmp    801057c3 <alltraps>

80106453 <vector197>:
.globl vector197
vector197:
  pushl $0
80106453:	6a 00                	push   $0x0
  pushl $197
80106455:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010645a:	e9 64 f3 ff ff       	jmp    801057c3 <alltraps>

8010645f <vector198>:
.globl vector198
vector198:
  pushl $0
8010645f:	6a 00                	push   $0x0
  pushl $198
80106461:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106466:	e9 58 f3 ff ff       	jmp    801057c3 <alltraps>

8010646b <vector199>:
.globl vector199
vector199:
  pushl $0
8010646b:	6a 00                	push   $0x0
  pushl $199
8010646d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106472:	e9 4c f3 ff ff       	jmp    801057c3 <alltraps>

80106477 <vector200>:
.globl vector200
vector200:
  pushl $0
80106477:	6a 00                	push   $0x0
  pushl $200
80106479:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010647e:	e9 40 f3 ff ff       	jmp    801057c3 <alltraps>

80106483 <vector201>:
.globl vector201
vector201:
  pushl $0
80106483:	6a 00                	push   $0x0
  pushl $201
80106485:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010648a:	e9 34 f3 ff ff       	jmp    801057c3 <alltraps>

8010648f <vector202>:
.globl vector202
vector202:
  pushl $0
8010648f:	6a 00                	push   $0x0
  pushl $202
80106491:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106496:	e9 28 f3 ff ff       	jmp    801057c3 <alltraps>

8010649b <vector203>:
.globl vector203
vector203:
  pushl $0
8010649b:	6a 00                	push   $0x0
  pushl $203
8010649d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801064a2:	e9 1c f3 ff ff       	jmp    801057c3 <alltraps>

801064a7 <vector204>:
.globl vector204
vector204:
  pushl $0
801064a7:	6a 00                	push   $0x0
  pushl $204
801064a9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801064ae:	e9 10 f3 ff ff       	jmp    801057c3 <alltraps>

801064b3 <vector205>:
.globl vector205
vector205:
  pushl $0
801064b3:	6a 00                	push   $0x0
  pushl $205
801064b5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801064ba:	e9 04 f3 ff ff       	jmp    801057c3 <alltraps>

801064bf <vector206>:
.globl vector206
vector206:
  pushl $0
801064bf:	6a 00                	push   $0x0
  pushl $206
801064c1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801064c6:	e9 f8 f2 ff ff       	jmp    801057c3 <alltraps>

801064cb <vector207>:
.globl vector207
vector207:
  pushl $0
801064cb:	6a 00                	push   $0x0
  pushl $207
801064cd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801064d2:	e9 ec f2 ff ff       	jmp    801057c3 <alltraps>

801064d7 <vector208>:
.globl vector208
vector208:
  pushl $0
801064d7:	6a 00                	push   $0x0
  pushl $208
801064d9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801064de:	e9 e0 f2 ff ff       	jmp    801057c3 <alltraps>

801064e3 <vector209>:
.globl vector209
vector209:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $209
801064e5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801064ea:	e9 d4 f2 ff ff       	jmp    801057c3 <alltraps>

801064ef <vector210>:
.globl vector210
vector210:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $210
801064f1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801064f6:	e9 c8 f2 ff ff       	jmp    801057c3 <alltraps>

801064fb <vector211>:
.globl vector211
vector211:
  pushl $0
801064fb:	6a 00                	push   $0x0
  pushl $211
801064fd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106502:	e9 bc f2 ff ff       	jmp    801057c3 <alltraps>

80106507 <vector212>:
.globl vector212
vector212:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $212
80106509:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010650e:	e9 b0 f2 ff ff       	jmp    801057c3 <alltraps>

80106513 <vector213>:
.globl vector213
vector213:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $213
80106515:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010651a:	e9 a4 f2 ff ff       	jmp    801057c3 <alltraps>

8010651f <vector214>:
.globl vector214
vector214:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $214
80106521:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106526:	e9 98 f2 ff ff       	jmp    801057c3 <alltraps>

8010652b <vector215>:
.globl vector215
vector215:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $215
8010652d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106532:	e9 8c f2 ff ff       	jmp    801057c3 <alltraps>

80106537 <vector216>:
.globl vector216
vector216:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $216
80106539:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010653e:	e9 80 f2 ff ff       	jmp    801057c3 <alltraps>

80106543 <vector217>:
.globl vector217
vector217:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $217
80106545:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010654a:	e9 74 f2 ff ff       	jmp    801057c3 <alltraps>

8010654f <vector218>:
.globl vector218
vector218:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $218
80106551:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106556:	e9 68 f2 ff ff       	jmp    801057c3 <alltraps>

8010655b <vector219>:
.globl vector219
vector219:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $219
8010655d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106562:	e9 5c f2 ff ff       	jmp    801057c3 <alltraps>

80106567 <vector220>:
.globl vector220
vector220:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $220
80106569:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010656e:	e9 50 f2 ff ff       	jmp    801057c3 <alltraps>

80106573 <vector221>:
.globl vector221
vector221:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $221
80106575:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010657a:	e9 44 f2 ff ff       	jmp    801057c3 <alltraps>

8010657f <vector222>:
.globl vector222
vector222:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $222
80106581:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106586:	e9 38 f2 ff ff       	jmp    801057c3 <alltraps>

8010658b <vector223>:
.globl vector223
vector223:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $223
8010658d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106592:	e9 2c f2 ff ff       	jmp    801057c3 <alltraps>

80106597 <vector224>:
.globl vector224
vector224:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $224
80106599:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010659e:	e9 20 f2 ff ff       	jmp    801057c3 <alltraps>

801065a3 <vector225>:
.globl vector225
vector225:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $225
801065a5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801065aa:	e9 14 f2 ff ff       	jmp    801057c3 <alltraps>

801065af <vector226>:
.globl vector226
vector226:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $226
801065b1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801065b6:	e9 08 f2 ff ff       	jmp    801057c3 <alltraps>

801065bb <vector227>:
.globl vector227
vector227:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $227
801065bd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801065c2:	e9 fc f1 ff ff       	jmp    801057c3 <alltraps>

801065c7 <vector228>:
.globl vector228
vector228:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $228
801065c9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801065ce:	e9 f0 f1 ff ff       	jmp    801057c3 <alltraps>

801065d3 <vector229>:
.globl vector229
vector229:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $229
801065d5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801065da:	e9 e4 f1 ff ff       	jmp    801057c3 <alltraps>

801065df <vector230>:
.globl vector230
vector230:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $230
801065e1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801065e6:	e9 d8 f1 ff ff       	jmp    801057c3 <alltraps>

801065eb <vector231>:
.globl vector231
vector231:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $231
801065ed:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801065f2:	e9 cc f1 ff ff       	jmp    801057c3 <alltraps>

801065f7 <vector232>:
.globl vector232
vector232:
  pushl $0
801065f7:	6a 00                	push   $0x0
  pushl $232
801065f9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801065fe:	e9 c0 f1 ff ff       	jmp    801057c3 <alltraps>

80106603 <vector233>:
.globl vector233
vector233:
  pushl $0
80106603:	6a 00                	push   $0x0
  pushl $233
80106605:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010660a:	e9 b4 f1 ff ff       	jmp    801057c3 <alltraps>

8010660f <vector234>:
.globl vector234
vector234:
  pushl $0
8010660f:	6a 00                	push   $0x0
  pushl $234
80106611:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106616:	e9 a8 f1 ff ff       	jmp    801057c3 <alltraps>

8010661b <vector235>:
.globl vector235
vector235:
  pushl $0
8010661b:	6a 00                	push   $0x0
  pushl $235
8010661d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106622:	e9 9c f1 ff ff       	jmp    801057c3 <alltraps>

80106627 <vector236>:
.globl vector236
vector236:
  pushl $0
80106627:	6a 00                	push   $0x0
  pushl $236
80106629:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010662e:	e9 90 f1 ff ff       	jmp    801057c3 <alltraps>

80106633 <vector237>:
.globl vector237
vector237:
  pushl $0
80106633:	6a 00                	push   $0x0
  pushl $237
80106635:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010663a:	e9 84 f1 ff ff       	jmp    801057c3 <alltraps>

8010663f <vector238>:
.globl vector238
vector238:
  pushl $0
8010663f:	6a 00                	push   $0x0
  pushl $238
80106641:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106646:	e9 78 f1 ff ff       	jmp    801057c3 <alltraps>

8010664b <vector239>:
.globl vector239
vector239:
  pushl $0
8010664b:	6a 00                	push   $0x0
  pushl $239
8010664d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106652:	e9 6c f1 ff ff       	jmp    801057c3 <alltraps>

80106657 <vector240>:
.globl vector240
vector240:
  pushl $0
80106657:	6a 00                	push   $0x0
  pushl $240
80106659:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010665e:	e9 60 f1 ff ff       	jmp    801057c3 <alltraps>

80106663 <vector241>:
.globl vector241
vector241:
  pushl $0
80106663:	6a 00                	push   $0x0
  pushl $241
80106665:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010666a:	e9 54 f1 ff ff       	jmp    801057c3 <alltraps>

8010666f <vector242>:
.globl vector242
vector242:
  pushl $0
8010666f:	6a 00                	push   $0x0
  pushl $242
80106671:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106676:	e9 48 f1 ff ff       	jmp    801057c3 <alltraps>

8010667b <vector243>:
.globl vector243
vector243:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $243
8010667d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106682:	e9 3c f1 ff ff       	jmp    801057c3 <alltraps>

80106687 <vector244>:
.globl vector244
vector244:
  pushl $0
80106687:	6a 00                	push   $0x0
  pushl $244
80106689:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010668e:	e9 30 f1 ff ff       	jmp    801057c3 <alltraps>

80106693 <vector245>:
.globl vector245
vector245:
  pushl $0
80106693:	6a 00                	push   $0x0
  pushl $245
80106695:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010669a:	e9 24 f1 ff ff       	jmp    801057c3 <alltraps>

8010669f <vector246>:
.globl vector246
vector246:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $246
801066a1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801066a6:	e9 18 f1 ff ff       	jmp    801057c3 <alltraps>

801066ab <vector247>:
.globl vector247
vector247:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $247
801066ad:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801066b2:	e9 0c f1 ff ff       	jmp    801057c3 <alltraps>

801066b7 <vector248>:
.globl vector248
vector248:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $248
801066b9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801066be:	e9 00 f1 ff ff       	jmp    801057c3 <alltraps>

801066c3 <vector249>:
.globl vector249
vector249:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $249
801066c5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801066ca:	e9 f4 f0 ff ff       	jmp    801057c3 <alltraps>

801066cf <vector250>:
.globl vector250
vector250:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $250
801066d1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801066d6:	e9 e8 f0 ff ff       	jmp    801057c3 <alltraps>

801066db <vector251>:
.globl vector251
vector251:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $251
801066dd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801066e2:	e9 dc f0 ff ff       	jmp    801057c3 <alltraps>

801066e7 <vector252>:
.globl vector252
vector252:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $252
801066e9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801066ee:	e9 d0 f0 ff ff       	jmp    801057c3 <alltraps>

801066f3 <vector253>:
.globl vector253
vector253:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $253
801066f5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801066fa:	e9 c4 f0 ff ff       	jmp    801057c3 <alltraps>

801066ff <vector254>:
.globl vector254
vector254:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $254
80106701:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106706:	e9 b8 f0 ff ff       	jmp    801057c3 <alltraps>

8010670b <vector255>:
.globl vector255
vector255:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $255
8010670d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106712:	e9 ac f0 ff ff       	jmp    801057c3 <alltraps>
80106717:	66 90                	xchg   %ax,%ax
80106719:	66 90                	xchg   %ax,%ax
8010671b:	66 90                	xchg   %ax,%ax
8010671d:	66 90                	xchg   %ax,%ax
8010671f:	90                   	nop

80106720 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106720:	55                   	push   %ebp
80106721:	89 e5                	mov    %esp,%ebp
80106723:	57                   	push   %edi
80106724:	56                   	push   %esi
80106725:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106726:	89 d3                	mov    %edx,%ebx
{
80106728:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010672a:	c1 eb 16             	shr    $0x16,%ebx
8010672d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106730:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106733:	8b 06                	mov    (%esi),%eax
80106735:	a8 01                	test   $0x1,%al
80106737:	74 27                	je     80106760 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106739:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010673e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106744:	c1 ef 0a             	shr    $0xa,%edi
}
80106747:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010674a:	89 fa                	mov    %edi,%edx
8010674c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106752:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106755:	5b                   	pop    %ebx
80106756:	5e                   	pop    %esi
80106757:	5f                   	pop    %edi
80106758:	5d                   	pop    %ebp
80106759:	c3                   	ret    
8010675a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106760:	85 c9                	test   %ecx,%ecx
80106762:	74 2c                	je     80106790 <walkpgdir+0x70>
80106764:	e8 a7 be ff ff       	call   80102610 <kalloc>
80106769:	85 c0                	test   %eax,%eax
8010676b:	89 c3                	mov    %eax,%ebx
8010676d:	74 21                	je     80106790 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010676f:	83 ec 04             	sub    $0x4,%esp
80106772:	68 00 10 00 00       	push   $0x1000
80106777:	6a 00                	push   $0x0
80106779:	50                   	push   %eax
8010677a:	e8 21 de ff ff       	call   801045a0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010677f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106785:	83 c4 10             	add    $0x10,%esp
80106788:	83 c8 07             	or     $0x7,%eax
8010678b:	89 06                	mov    %eax,(%esi)
8010678d:	eb b5                	jmp    80106744 <walkpgdir+0x24>
8010678f:	90                   	nop
}
80106790:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106793:	31 c0                	xor    %eax,%eax
}
80106795:	5b                   	pop    %ebx
80106796:	5e                   	pop    %esi
80106797:	5f                   	pop    %edi
80106798:	5d                   	pop    %ebp
80106799:	c3                   	ret    
8010679a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801067a0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801067a0:	55                   	push   %ebp
801067a1:	89 e5                	mov    %esp,%ebp
801067a3:	57                   	push   %edi
801067a4:	56                   	push   %esi
801067a5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801067a6:	89 d3                	mov    %edx,%ebx
801067a8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801067ae:	83 ec 1c             	sub    $0x1c,%esp
801067b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801067b4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801067b8:	8b 7d 08             	mov    0x8(%ebp),%edi
801067bb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801067c0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801067c3:	8b 45 0c             	mov    0xc(%ebp),%eax
801067c6:	29 df                	sub    %ebx,%edi
801067c8:	83 c8 01             	or     $0x1,%eax
801067cb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801067ce:	eb 15                	jmp    801067e5 <mappages+0x45>
    if(*pte & PTE_P)
801067d0:	f6 00 01             	testb  $0x1,(%eax)
801067d3:	75 45                	jne    8010681a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
801067d5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801067d8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
801067db:	89 30                	mov    %esi,(%eax)
    if(a == last)
801067dd:	74 31                	je     80106810 <mappages+0x70>
      break;
    a += PGSIZE;
801067df:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801067e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801067e8:	b9 01 00 00 00       	mov    $0x1,%ecx
801067ed:	89 da                	mov    %ebx,%edx
801067ef:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801067f2:	e8 29 ff ff ff       	call   80106720 <walkpgdir>
801067f7:	85 c0                	test   %eax,%eax
801067f9:	75 d5                	jne    801067d0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
801067fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801067fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106803:	5b                   	pop    %ebx
80106804:	5e                   	pop    %esi
80106805:	5f                   	pop    %edi
80106806:	5d                   	pop    %ebp
80106807:	c3                   	ret    
80106808:	90                   	nop
80106809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106810:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106813:	31 c0                	xor    %eax,%eax
}
80106815:	5b                   	pop    %ebx
80106816:	5e                   	pop    %esi
80106817:	5f                   	pop    %edi
80106818:	5d                   	pop    %ebp
80106819:	c3                   	ret    
      panic("remap");
8010681a:	83 ec 0c             	sub    $0xc,%esp
8010681d:	68 30 79 10 80       	push   $0x80107930
80106822:	e8 19 9c ff ff       	call   80100440 <panic>
80106827:	89 f6                	mov    %esi,%esi
80106829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106830 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106830:	55                   	push   %ebp
80106831:	89 e5                	mov    %esp,%ebp
80106833:	57                   	push   %edi
80106834:	56                   	push   %esi
80106835:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106836:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010683c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
8010683e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106844:	83 ec 1c             	sub    $0x1c,%esp
80106847:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010684a:	39 d3                	cmp    %edx,%ebx
8010684c:	73 66                	jae    801068b4 <deallocuvm.part.0+0x84>
8010684e:	89 d6                	mov    %edx,%esi
80106850:	eb 3d                	jmp    8010688f <deallocuvm.part.0+0x5f>
80106852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106858:	8b 10                	mov    (%eax),%edx
8010685a:	f6 c2 01             	test   $0x1,%dl
8010685d:	74 26                	je     80106885 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010685f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106865:	74 58                	je     801068bf <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106867:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010686a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106870:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106873:	52                   	push   %edx
80106874:	e8 e7 bb ff ff       	call   80102460 <kfree>
      *pte = 0;
80106879:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010687c:	83 c4 10             	add    $0x10,%esp
8010687f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106885:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010688b:	39 f3                	cmp    %esi,%ebx
8010688d:	73 25                	jae    801068b4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010688f:	31 c9                	xor    %ecx,%ecx
80106891:	89 da                	mov    %ebx,%edx
80106893:	89 f8                	mov    %edi,%eax
80106895:	e8 86 fe ff ff       	call   80106720 <walkpgdir>
    if(!pte)
8010689a:	85 c0                	test   %eax,%eax
8010689c:	75 ba                	jne    80106858 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010689e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801068a4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801068aa:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801068b0:	39 f3                	cmp    %esi,%ebx
801068b2:	72 db                	jb     8010688f <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
801068b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801068b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068ba:	5b                   	pop    %ebx
801068bb:	5e                   	pop    %esi
801068bc:	5f                   	pop    %edi
801068bd:	5d                   	pop    %ebp
801068be:	c3                   	ret    
        panic("kfree");
801068bf:	83 ec 0c             	sub    $0xc,%esp
801068c2:	68 ce 72 10 80       	push   $0x801072ce
801068c7:	e8 74 9b ff ff       	call   80100440 <panic>
801068cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801068d0 <seginit>:
{
801068d0:	55                   	push   %ebp
801068d1:	89 e5                	mov    %esp,%ebp
801068d3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801068d6:	e8 35 d0 ff ff       	call   80103910 <cpuid>
801068db:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
801068e1:	ba 2f 00 00 00       	mov    $0x2f,%edx
801068e6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801068ea:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
801068f1:	ff 00 00 
801068f4:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
801068fb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801068fe:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
80106905:	ff 00 00 
80106908:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
8010690f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106912:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
80106919:	ff 00 00 
8010691c:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
80106923:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106926:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
8010692d:	ff 00 00 
80106930:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
80106937:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010693a:	05 10 28 11 80       	add    $0x80112810,%eax
  pd[1] = (uint)p;
8010693f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106943:	c1 e8 10             	shr    $0x10,%eax
80106946:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010694a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010694d:	0f 01 10             	lgdtl  (%eax)
}
80106950:	c9                   	leave  
80106951:	c3                   	ret    
80106952:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106960 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106960:	a1 c4 55 11 80       	mov    0x801155c4,%eax
{
80106965:	55                   	push   %ebp
80106966:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106968:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010696d:	0f 22 d8             	mov    %eax,%cr3
}
80106970:	5d                   	pop    %ebp
80106971:	c3                   	ret    
80106972:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106980 <switchuvm>:
{
80106980:	55                   	push   %ebp
80106981:	89 e5                	mov    %esp,%ebp
80106983:	57                   	push   %edi
80106984:	56                   	push   %esi
80106985:	53                   	push   %ebx
80106986:	83 ec 1c             	sub    $0x1c,%esp
80106989:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
8010698c:	85 db                	test   %ebx,%ebx
8010698e:	0f 84 cb 00 00 00    	je     80106a5f <switchuvm+0xdf>
  if(p->kstack == 0)
80106994:	8b 43 08             	mov    0x8(%ebx),%eax
80106997:	85 c0                	test   %eax,%eax
80106999:	0f 84 da 00 00 00    	je     80106a79 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010699f:	8b 43 04             	mov    0x4(%ebx),%eax
801069a2:	85 c0                	test   %eax,%eax
801069a4:	0f 84 c2 00 00 00    	je     80106a6c <switchuvm+0xec>
  pushcli();
801069aa:	e8 11 da ff ff       	call   801043c0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801069af:	e8 dc ce ff ff       	call   80103890 <mycpu>
801069b4:	89 c6                	mov    %eax,%esi
801069b6:	e8 d5 ce ff ff       	call   80103890 <mycpu>
801069bb:	89 c7                	mov    %eax,%edi
801069bd:	e8 ce ce ff ff       	call   80103890 <mycpu>
801069c2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801069c5:	83 c7 08             	add    $0x8,%edi
801069c8:	e8 c3 ce ff ff       	call   80103890 <mycpu>
801069cd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801069d0:	83 c0 08             	add    $0x8,%eax
801069d3:	ba 67 00 00 00       	mov    $0x67,%edx
801069d8:	c1 e8 18             	shr    $0x18,%eax
801069db:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
801069e2:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
801069e9:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801069ef:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801069f4:	83 c1 08             	add    $0x8,%ecx
801069f7:	c1 e9 10             	shr    $0x10,%ecx
801069fa:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106a00:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106a05:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106a0c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106a11:	e8 7a ce ff ff       	call   80103890 <mycpu>
80106a16:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106a1d:	e8 6e ce ff ff       	call   80103890 <mycpu>
80106a22:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106a26:	8b 73 08             	mov    0x8(%ebx),%esi
80106a29:	e8 62 ce ff ff       	call   80103890 <mycpu>
80106a2e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106a34:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106a37:	e8 54 ce ff ff       	call   80103890 <mycpu>
80106a3c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106a40:	b8 28 00 00 00       	mov    $0x28,%eax
80106a45:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106a48:	8b 43 04             	mov    0x4(%ebx),%eax
80106a4b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106a50:	0f 22 d8             	mov    %eax,%cr3
}
80106a53:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a56:	5b                   	pop    %ebx
80106a57:	5e                   	pop    %esi
80106a58:	5f                   	pop    %edi
80106a59:	5d                   	pop    %ebp
  popcli();
80106a5a:	e9 a1 d9 ff ff       	jmp    80104400 <popcli>
    panic("switchuvm: no process");
80106a5f:	83 ec 0c             	sub    $0xc,%esp
80106a62:	68 36 79 10 80       	push   $0x80107936
80106a67:	e8 d4 99 ff ff       	call   80100440 <panic>
    panic("switchuvm: no pgdir");
80106a6c:	83 ec 0c             	sub    $0xc,%esp
80106a6f:	68 61 79 10 80       	push   $0x80107961
80106a74:	e8 c7 99 ff ff       	call   80100440 <panic>
    panic("switchuvm: no kstack");
80106a79:	83 ec 0c             	sub    $0xc,%esp
80106a7c:	68 4c 79 10 80       	push   $0x8010794c
80106a81:	e8 ba 99 ff ff       	call   80100440 <panic>
80106a86:	8d 76 00             	lea    0x0(%esi),%esi
80106a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a90 <inituvm>:
{
80106a90:	55                   	push   %ebp
80106a91:	89 e5                	mov    %esp,%ebp
80106a93:	57                   	push   %edi
80106a94:	56                   	push   %esi
80106a95:	53                   	push   %ebx
80106a96:	83 ec 1c             	sub    $0x1c,%esp
80106a99:	8b 75 10             	mov    0x10(%ebp),%esi
80106a9c:	8b 45 08             	mov    0x8(%ebp),%eax
80106a9f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106aa2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106aa8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106aab:	77 49                	ja     80106af6 <inituvm+0x66>
  mem = kalloc();
80106aad:	e8 5e bb ff ff       	call   80102610 <kalloc>
  memset(mem, 0, PGSIZE);
80106ab2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106ab5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106ab7:	68 00 10 00 00       	push   $0x1000
80106abc:	6a 00                	push   $0x0
80106abe:	50                   	push   %eax
80106abf:	e8 dc da ff ff       	call   801045a0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106ac4:	58                   	pop    %eax
80106ac5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106acb:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106ad0:	5a                   	pop    %edx
80106ad1:	6a 06                	push   $0x6
80106ad3:	50                   	push   %eax
80106ad4:	31 d2                	xor    %edx,%edx
80106ad6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ad9:	e8 c2 fc ff ff       	call   801067a0 <mappages>
  memmove(mem, init, sz);
80106ade:	89 75 10             	mov    %esi,0x10(%ebp)
80106ae1:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106ae4:	83 c4 10             	add    $0x10,%esp
80106ae7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106aea:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106aed:	5b                   	pop    %ebx
80106aee:	5e                   	pop    %esi
80106aef:	5f                   	pop    %edi
80106af0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106af1:	e9 5a db ff ff       	jmp    80104650 <memmove>
    panic("inituvm: more than a page");
80106af6:	83 ec 0c             	sub    $0xc,%esp
80106af9:	68 75 79 10 80       	push   $0x80107975
80106afe:	e8 3d 99 ff ff       	call   80100440 <panic>
80106b03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b10 <loaduvm>:
{
80106b10:	55                   	push   %ebp
80106b11:	89 e5                	mov    %esp,%ebp
80106b13:	57                   	push   %edi
80106b14:	56                   	push   %esi
80106b15:	53                   	push   %ebx
80106b16:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106b19:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106b20:	0f 85 91 00 00 00    	jne    80106bb7 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106b26:	8b 75 18             	mov    0x18(%ebp),%esi
80106b29:	31 db                	xor    %ebx,%ebx
80106b2b:	85 f6                	test   %esi,%esi
80106b2d:	75 1a                	jne    80106b49 <loaduvm+0x39>
80106b2f:	eb 6f                	jmp    80106ba0 <loaduvm+0x90>
80106b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b38:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b3e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106b44:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106b47:	76 57                	jbe    80106ba0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106b49:	8b 55 0c             	mov    0xc(%ebp),%edx
80106b4c:	8b 45 08             	mov    0x8(%ebp),%eax
80106b4f:	31 c9                	xor    %ecx,%ecx
80106b51:	01 da                	add    %ebx,%edx
80106b53:	e8 c8 fb ff ff       	call   80106720 <walkpgdir>
80106b58:	85 c0                	test   %eax,%eax
80106b5a:	74 4e                	je     80106baa <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106b5c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106b5e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106b61:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106b66:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106b6b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106b71:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106b74:	01 d9                	add    %ebx,%ecx
80106b76:	05 00 00 00 80       	add    $0x80000000,%eax
80106b7b:	57                   	push   %edi
80106b7c:	51                   	push   %ecx
80106b7d:	50                   	push   %eax
80106b7e:	ff 75 10             	pushl  0x10(%ebp)
80106b81:	e8 ea ae ff ff       	call   80101a70 <readi>
80106b86:	83 c4 10             	add    $0x10,%esp
80106b89:	39 f8                	cmp    %edi,%eax
80106b8b:	74 ab                	je     80106b38 <loaduvm+0x28>
}
80106b8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106b90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b95:	5b                   	pop    %ebx
80106b96:	5e                   	pop    %esi
80106b97:	5f                   	pop    %edi
80106b98:	5d                   	pop    %ebp
80106b99:	c3                   	ret    
80106b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106ba0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106ba3:	31 c0                	xor    %eax,%eax
}
80106ba5:	5b                   	pop    %ebx
80106ba6:	5e                   	pop    %esi
80106ba7:	5f                   	pop    %edi
80106ba8:	5d                   	pop    %ebp
80106ba9:	c3                   	ret    
      panic("loaduvm: address should exist");
80106baa:	83 ec 0c             	sub    $0xc,%esp
80106bad:	68 8f 79 10 80       	push   $0x8010798f
80106bb2:	e8 89 98 ff ff       	call   80100440 <panic>
    panic("loaduvm: addr must be page aligned");
80106bb7:	83 ec 0c             	sub    $0xc,%esp
80106bba:	68 30 7a 10 80       	push   $0x80107a30
80106bbf:	e8 7c 98 ff ff       	call   80100440 <panic>
80106bc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106bca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106bd0 <allocuvm>:
{
80106bd0:	55                   	push   %ebp
80106bd1:	89 e5                	mov    %esp,%ebp
80106bd3:	57                   	push   %edi
80106bd4:	56                   	push   %esi
80106bd5:	53                   	push   %ebx
80106bd6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106bd9:	8b 7d 10             	mov    0x10(%ebp),%edi
80106bdc:	85 ff                	test   %edi,%edi
80106bde:	0f 88 8e 00 00 00    	js     80106c72 <allocuvm+0xa2>
  if(newsz < oldsz)
80106be4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106be7:	0f 82 93 00 00 00    	jb     80106c80 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
80106bed:	8b 45 0c             	mov    0xc(%ebp),%eax
80106bf0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106bf6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106bfc:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106bff:	0f 86 7e 00 00 00    	jbe    80106c83 <allocuvm+0xb3>
80106c05:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106c08:	8b 7d 08             	mov    0x8(%ebp),%edi
80106c0b:	eb 42                	jmp    80106c4f <allocuvm+0x7f>
80106c0d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106c10:	83 ec 04             	sub    $0x4,%esp
80106c13:	68 00 10 00 00       	push   $0x1000
80106c18:	6a 00                	push   $0x0
80106c1a:	50                   	push   %eax
80106c1b:	e8 80 d9 ff ff       	call   801045a0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106c20:	58                   	pop    %eax
80106c21:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106c27:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c2c:	5a                   	pop    %edx
80106c2d:	6a 06                	push   $0x6
80106c2f:	50                   	push   %eax
80106c30:	89 da                	mov    %ebx,%edx
80106c32:	89 f8                	mov    %edi,%eax
80106c34:	e8 67 fb ff ff       	call   801067a0 <mappages>
80106c39:	83 c4 10             	add    $0x10,%esp
80106c3c:	85 c0                	test   %eax,%eax
80106c3e:	78 50                	js     80106c90 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80106c40:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c46:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106c49:	0f 86 81 00 00 00    	jbe    80106cd0 <allocuvm+0x100>
    mem = kalloc();
80106c4f:	e8 bc b9 ff ff       	call   80102610 <kalloc>
    if(mem == 0){
80106c54:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106c56:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106c58:	75 b6                	jne    80106c10 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106c5a:	83 ec 0c             	sub    $0xc,%esp
80106c5d:	68 ad 79 10 80       	push   $0x801079ad
80106c62:	e8 a9 9a ff ff       	call   80100710 <cprintf>
  if(newsz >= oldsz)
80106c67:	83 c4 10             	add    $0x10,%esp
80106c6a:	8b 45 0c             	mov    0xc(%ebp),%eax
80106c6d:	39 45 10             	cmp    %eax,0x10(%ebp)
80106c70:	77 6e                	ja     80106ce0 <allocuvm+0x110>
}
80106c72:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106c75:	31 ff                	xor    %edi,%edi
}
80106c77:	89 f8                	mov    %edi,%eax
80106c79:	5b                   	pop    %ebx
80106c7a:	5e                   	pop    %esi
80106c7b:	5f                   	pop    %edi
80106c7c:	5d                   	pop    %ebp
80106c7d:	c3                   	ret    
80106c7e:	66 90                	xchg   %ax,%ax
    return oldsz;
80106c80:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106c83:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c86:	89 f8                	mov    %edi,%eax
80106c88:	5b                   	pop    %ebx
80106c89:	5e                   	pop    %esi
80106c8a:	5f                   	pop    %edi
80106c8b:	5d                   	pop    %ebp
80106c8c:	c3                   	ret    
80106c8d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106c90:	83 ec 0c             	sub    $0xc,%esp
80106c93:	68 c5 79 10 80       	push   $0x801079c5
80106c98:	e8 73 9a ff ff       	call   80100710 <cprintf>
  if(newsz >= oldsz)
80106c9d:	83 c4 10             	add    $0x10,%esp
80106ca0:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ca3:	39 45 10             	cmp    %eax,0x10(%ebp)
80106ca6:	76 0d                	jbe    80106cb5 <allocuvm+0xe5>
80106ca8:	89 c1                	mov    %eax,%ecx
80106caa:	8b 55 10             	mov    0x10(%ebp),%edx
80106cad:	8b 45 08             	mov    0x8(%ebp),%eax
80106cb0:	e8 7b fb ff ff       	call   80106830 <deallocuvm.part.0>
      kfree(mem);
80106cb5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106cb8:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106cba:	56                   	push   %esi
80106cbb:	e8 a0 b7 ff ff       	call   80102460 <kfree>
      return 0;
80106cc0:	83 c4 10             	add    $0x10,%esp
}
80106cc3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cc6:	89 f8                	mov    %edi,%eax
80106cc8:	5b                   	pop    %ebx
80106cc9:	5e                   	pop    %esi
80106cca:	5f                   	pop    %edi
80106ccb:	5d                   	pop    %ebp
80106ccc:	c3                   	ret    
80106ccd:	8d 76 00             	lea    0x0(%esi),%esi
80106cd0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106cd3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cd6:	5b                   	pop    %ebx
80106cd7:	89 f8                	mov    %edi,%eax
80106cd9:	5e                   	pop    %esi
80106cda:	5f                   	pop    %edi
80106cdb:	5d                   	pop    %ebp
80106cdc:	c3                   	ret    
80106cdd:	8d 76 00             	lea    0x0(%esi),%esi
80106ce0:	89 c1                	mov    %eax,%ecx
80106ce2:	8b 55 10             	mov    0x10(%ebp),%edx
80106ce5:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106ce8:	31 ff                	xor    %edi,%edi
80106cea:	e8 41 fb ff ff       	call   80106830 <deallocuvm.part.0>
80106cef:	eb 92                	jmp    80106c83 <allocuvm+0xb3>
80106cf1:	eb 0d                	jmp    80106d00 <deallocuvm>
80106cf3:	90                   	nop
80106cf4:	90                   	nop
80106cf5:	90                   	nop
80106cf6:	90                   	nop
80106cf7:	90                   	nop
80106cf8:	90                   	nop
80106cf9:	90                   	nop
80106cfa:	90                   	nop
80106cfb:	90                   	nop
80106cfc:	90                   	nop
80106cfd:	90                   	nop
80106cfe:	90                   	nop
80106cff:	90                   	nop

80106d00 <deallocuvm>:
{
80106d00:	55                   	push   %ebp
80106d01:	89 e5                	mov    %esp,%ebp
80106d03:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d06:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106d09:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106d0c:	39 d1                	cmp    %edx,%ecx
80106d0e:	73 10                	jae    80106d20 <deallocuvm+0x20>
}
80106d10:	5d                   	pop    %ebp
80106d11:	e9 1a fb ff ff       	jmp    80106830 <deallocuvm.part.0>
80106d16:	8d 76 00             	lea    0x0(%esi),%esi
80106d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106d20:	89 d0                	mov    %edx,%eax
80106d22:	5d                   	pop    %ebp
80106d23:	c3                   	ret    
80106d24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106d30 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106d30:	55                   	push   %ebp
80106d31:	89 e5                	mov    %esp,%ebp
80106d33:	57                   	push   %edi
80106d34:	56                   	push   %esi
80106d35:	53                   	push   %ebx
80106d36:	83 ec 0c             	sub    $0xc,%esp
80106d39:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106d3c:	85 f6                	test   %esi,%esi
80106d3e:	74 59                	je     80106d99 <freevm+0x69>
80106d40:	31 c9                	xor    %ecx,%ecx
80106d42:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106d47:	89 f0                	mov    %esi,%eax
80106d49:	e8 e2 fa ff ff       	call   80106830 <deallocuvm.part.0>
80106d4e:	89 f3                	mov    %esi,%ebx
80106d50:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106d56:	eb 0f                	jmp    80106d67 <freevm+0x37>
80106d58:	90                   	nop
80106d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d60:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106d63:	39 fb                	cmp    %edi,%ebx
80106d65:	74 23                	je     80106d8a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106d67:	8b 03                	mov    (%ebx),%eax
80106d69:	a8 01                	test   $0x1,%al
80106d6b:	74 f3                	je     80106d60 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106d6d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106d72:	83 ec 0c             	sub    $0xc,%esp
80106d75:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106d78:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106d7d:	50                   	push   %eax
80106d7e:	e8 dd b6 ff ff       	call   80102460 <kfree>
80106d83:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106d86:	39 fb                	cmp    %edi,%ebx
80106d88:	75 dd                	jne    80106d67 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106d8a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106d8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d90:	5b                   	pop    %ebx
80106d91:	5e                   	pop    %esi
80106d92:	5f                   	pop    %edi
80106d93:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106d94:	e9 c7 b6 ff ff       	jmp    80102460 <kfree>
    panic("freevm: no pgdir");
80106d99:	83 ec 0c             	sub    $0xc,%esp
80106d9c:	68 e1 79 10 80       	push   $0x801079e1
80106da1:	e8 9a 96 ff ff       	call   80100440 <panic>
80106da6:	8d 76 00             	lea    0x0(%esi),%esi
80106da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106db0 <setupkvm>:
{
80106db0:	55                   	push   %ebp
80106db1:	89 e5                	mov    %esp,%ebp
80106db3:	56                   	push   %esi
80106db4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106db5:	e8 56 b8 ff ff       	call   80102610 <kalloc>
80106dba:	85 c0                	test   %eax,%eax
80106dbc:	89 c6                	mov    %eax,%esi
80106dbe:	74 42                	je     80106e02 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80106dc0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106dc3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106dc8:	68 00 10 00 00       	push   $0x1000
80106dcd:	6a 00                	push   $0x0
80106dcf:	50                   	push   %eax
80106dd0:	e8 cb d7 ff ff       	call   801045a0 <memset>
80106dd5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106dd8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106ddb:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106dde:	83 ec 08             	sub    $0x8,%esp
80106de1:	8b 13                	mov    (%ebx),%edx
80106de3:	ff 73 0c             	pushl  0xc(%ebx)
80106de6:	50                   	push   %eax
80106de7:	29 c1                	sub    %eax,%ecx
80106de9:	89 f0                	mov    %esi,%eax
80106deb:	e8 b0 f9 ff ff       	call   801067a0 <mappages>
80106df0:	83 c4 10             	add    $0x10,%esp
80106df3:	85 c0                	test   %eax,%eax
80106df5:	78 19                	js     80106e10 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106df7:	83 c3 10             	add    $0x10,%ebx
80106dfa:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106e00:	75 d6                	jne    80106dd8 <setupkvm+0x28>
}
80106e02:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106e05:	89 f0                	mov    %esi,%eax
80106e07:	5b                   	pop    %ebx
80106e08:	5e                   	pop    %esi
80106e09:	5d                   	pop    %ebp
80106e0a:	c3                   	ret    
80106e0b:	90                   	nop
80106e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106e10:	83 ec 0c             	sub    $0xc,%esp
80106e13:	56                   	push   %esi
      return 0;
80106e14:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80106e16:	e8 15 ff ff ff       	call   80106d30 <freevm>
      return 0;
80106e1b:	83 c4 10             	add    $0x10,%esp
}
80106e1e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106e21:	89 f0                	mov    %esi,%eax
80106e23:	5b                   	pop    %ebx
80106e24:	5e                   	pop    %esi
80106e25:	5d                   	pop    %ebp
80106e26:	c3                   	ret    
80106e27:	89 f6                	mov    %esi,%esi
80106e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e30 <kvmalloc>:
{
80106e30:	55                   	push   %ebp
80106e31:	89 e5                	mov    %esp,%ebp
80106e33:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106e36:	e8 75 ff ff ff       	call   80106db0 <setupkvm>
80106e3b:	a3 c4 55 11 80       	mov    %eax,0x801155c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106e40:	05 00 00 00 80       	add    $0x80000000,%eax
80106e45:	0f 22 d8             	mov    %eax,%cr3
}
80106e48:	c9                   	leave  
80106e49:	c3                   	ret    
80106e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106e50 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106e50:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106e51:	31 c9                	xor    %ecx,%ecx
{
80106e53:	89 e5                	mov    %esp,%ebp
80106e55:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106e58:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e5b:	8b 45 08             	mov    0x8(%ebp),%eax
80106e5e:	e8 bd f8 ff ff       	call   80106720 <walkpgdir>
  if(pte == 0)
80106e63:	85 c0                	test   %eax,%eax
80106e65:	74 05                	je     80106e6c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106e67:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106e6a:	c9                   	leave  
80106e6b:	c3                   	ret    
    panic("clearpteu");
80106e6c:	83 ec 0c             	sub    $0xc,%esp
80106e6f:	68 f2 79 10 80       	push   $0x801079f2
80106e74:	e8 c7 95 ff ff       	call   80100440 <panic>
80106e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106e80 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106e80:	55                   	push   %ebp
80106e81:	89 e5                	mov    %esp,%ebp
80106e83:	57                   	push   %edi
80106e84:	56                   	push   %esi
80106e85:	53                   	push   %ebx
80106e86:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106e89:	e8 22 ff ff ff       	call   80106db0 <setupkvm>
80106e8e:	85 c0                	test   %eax,%eax
80106e90:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106e93:	0f 84 9f 00 00 00    	je     80106f38 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106e99:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e9c:	85 c9                	test   %ecx,%ecx
80106e9e:	0f 84 94 00 00 00    	je     80106f38 <copyuvm+0xb8>
80106ea4:	31 ff                	xor    %edi,%edi
80106ea6:	eb 4a                	jmp    80106ef2 <copyuvm+0x72>
80106ea8:	90                   	nop
80106ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106eb0:	83 ec 04             	sub    $0x4,%esp
80106eb3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80106eb9:	68 00 10 00 00       	push   $0x1000
80106ebe:	53                   	push   %ebx
80106ebf:	50                   	push   %eax
80106ec0:	e8 8b d7 ff ff       	call   80104650 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106ec5:	58                   	pop    %eax
80106ec6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106ecc:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106ed1:	5a                   	pop    %edx
80106ed2:	ff 75 e4             	pushl  -0x1c(%ebp)
80106ed5:	50                   	push   %eax
80106ed6:	89 fa                	mov    %edi,%edx
80106ed8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106edb:	e8 c0 f8 ff ff       	call   801067a0 <mappages>
80106ee0:	83 c4 10             	add    $0x10,%esp
80106ee3:	85 c0                	test   %eax,%eax
80106ee5:	78 61                	js     80106f48 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80106ee7:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106eed:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106ef0:	76 46                	jbe    80106f38 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106ef2:	8b 45 08             	mov    0x8(%ebp),%eax
80106ef5:	31 c9                	xor    %ecx,%ecx
80106ef7:	89 fa                	mov    %edi,%edx
80106ef9:	e8 22 f8 ff ff       	call   80106720 <walkpgdir>
80106efe:	85 c0                	test   %eax,%eax
80106f00:	74 61                	je     80106f63 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80106f02:	8b 00                	mov    (%eax),%eax
80106f04:	a8 01                	test   $0x1,%al
80106f06:	74 4e                	je     80106f56 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80106f08:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
80106f0a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
80106f0f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80106f15:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80106f18:	e8 f3 b6 ff ff       	call   80102610 <kalloc>
80106f1d:	85 c0                	test   %eax,%eax
80106f1f:	89 c6                	mov    %eax,%esi
80106f21:	75 8d                	jne    80106eb0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80106f23:	83 ec 0c             	sub    $0xc,%esp
80106f26:	ff 75 e0             	pushl  -0x20(%ebp)
80106f29:	e8 02 fe ff ff       	call   80106d30 <freevm>
  return 0;
80106f2e:	83 c4 10             	add    $0x10,%esp
80106f31:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80106f38:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f3b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f3e:	5b                   	pop    %ebx
80106f3f:	5e                   	pop    %esi
80106f40:	5f                   	pop    %edi
80106f41:	5d                   	pop    %ebp
80106f42:	c3                   	ret    
80106f43:	90                   	nop
80106f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80106f48:	83 ec 0c             	sub    $0xc,%esp
80106f4b:	56                   	push   %esi
80106f4c:	e8 0f b5 ff ff       	call   80102460 <kfree>
      goto bad;
80106f51:	83 c4 10             	add    $0x10,%esp
80106f54:	eb cd                	jmp    80106f23 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80106f56:	83 ec 0c             	sub    $0xc,%esp
80106f59:	68 16 7a 10 80       	push   $0x80107a16
80106f5e:	e8 dd 94 ff ff       	call   80100440 <panic>
      panic("copyuvm: pte should exist");
80106f63:	83 ec 0c             	sub    $0xc,%esp
80106f66:	68 fc 79 10 80       	push   $0x801079fc
80106f6b:	e8 d0 94 ff ff       	call   80100440 <panic>

80106f70 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106f70:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106f71:	31 c9                	xor    %ecx,%ecx
{
80106f73:	89 e5                	mov    %esp,%ebp
80106f75:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106f78:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f7b:	8b 45 08             	mov    0x8(%ebp),%eax
80106f7e:	e8 9d f7 ff ff       	call   80106720 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106f83:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80106f85:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80106f86:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80106f88:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80106f8d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80106f90:	05 00 00 00 80       	add    $0x80000000,%eax
80106f95:	83 fa 05             	cmp    $0x5,%edx
80106f98:	ba 00 00 00 00       	mov    $0x0,%edx
80106f9d:	0f 45 c2             	cmovne %edx,%eax
}
80106fa0:	c3                   	ret    
80106fa1:	eb 0d                	jmp    80106fb0 <copyout>
80106fa3:	90                   	nop
80106fa4:	90                   	nop
80106fa5:	90                   	nop
80106fa6:	90                   	nop
80106fa7:	90                   	nop
80106fa8:	90                   	nop
80106fa9:	90                   	nop
80106faa:	90                   	nop
80106fab:	90                   	nop
80106fac:	90                   	nop
80106fad:	90                   	nop
80106fae:	90                   	nop
80106faf:	90                   	nop

80106fb0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106fb0:	55                   	push   %ebp
80106fb1:	89 e5                	mov    %esp,%ebp
80106fb3:	57                   	push   %edi
80106fb4:	56                   	push   %esi
80106fb5:	53                   	push   %ebx
80106fb6:	83 ec 1c             	sub    $0x1c,%esp
80106fb9:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106fbc:	8b 55 0c             	mov    0xc(%ebp),%edx
80106fbf:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106fc2:	85 db                	test   %ebx,%ebx
80106fc4:	75 40                	jne    80107006 <copyout+0x56>
80106fc6:	eb 70                	jmp    80107038 <copyout+0x88>
80106fc8:	90                   	nop
80106fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106fd0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106fd3:	89 f1                	mov    %esi,%ecx
80106fd5:	29 d1                	sub    %edx,%ecx
80106fd7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80106fdd:	39 d9                	cmp    %ebx,%ecx
80106fdf:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106fe2:	29 f2                	sub    %esi,%edx
80106fe4:	83 ec 04             	sub    $0x4,%esp
80106fe7:	01 d0                	add    %edx,%eax
80106fe9:	51                   	push   %ecx
80106fea:	57                   	push   %edi
80106feb:	50                   	push   %eax
80106fec:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80106fef:	e8 5c d6 ff ff       	call   80104650 <memmove>
    len -= n;
    buf += n;
80106ff4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80106ff7:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
80106ffa:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107000:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107002:	29 cb                	sub    %ecx,%ebx
80107004:	74 32                	je     80107038 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107006:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107008:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010700b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010700e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107014:	56                   	push   %esi
80107015:	ff 75 08             	pushl  0x8(%ebp)
80107018:	e8 53 ff ff ff       	call   80106f70 <uva2ka>
    if(pa0 == 0)
8010701d:	83 c4 10             	add    $0x10,%esp
80107020:	85 c0                	test   %eax,%eax
80107022:	75 ac                	jne    80106fd0 <copyout+0x20>
  }
  return 0;
}
80107024:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107027:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010702c:	5b                   	pop    %ebx
8010702d:	5e                   	pop    %esi
8010702e:	5f                   	pop    %edi
8010702f:	5d                   	pop    %ebp
80107030:	c3                   	ret    
80107031:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107038:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010703b:	31 c0                	xor    %eax,%eax
}
8010703d:	5b                   	pop    %ebx
8010703e:	5e                   	pop    %esi
8010703f:	5f                   	pop    %edi
80107040:	5d                   	pop    %ebp
80107041:	c3                   	ret    
