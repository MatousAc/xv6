
kernel/kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp
8010002d:	b8 10 30 10 80       	mov    $0x80103010,%eax
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
8010004c:	68 80 70 10 80       	push   $0x80107080
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 15 43 00 00       	call   80104370 <initlock>
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
80100092:	68 87 70 10 80       	push   $0x80107087
80100097:	50                   	push   %eax
80100098:	e8 a3 41 00 00       	call   80104240 <initsleeplock>
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
801000e4:	e8 c7 43 00 00       	call   801044b0 <acquire>
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
80100162:	e8 09 44 00 00       	call   80104570 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 0e 41 00 00       	call   80104280 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 0d 21 00 00       	call   80102290 <iderw>
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
80100193:	68 8e 70 10 80       	push   $0x8010708e
80100198:	e8 b3 02 00 00       	call   80100450 <panic>
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
801001ae:	e8 6d 41 00 00       	call   80104320 <holdingsleep>
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
801001c4:	e9 c7 20 00 00       	jmp    80102290 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 9f 70 10 80       	push   $0x8010709f
801001d1:	e8 7a 02 00 00       	call   80100450 <panic>
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
801001ef:	e8 2c 41 00 00       	call   80104320 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 dc 40 00 00       	call   801042e0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 a0 42 00 00       	call   801044b0 <acquire>
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
8010025c:	e9 0f 43 00 00       	jmp    80104570 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 a6 70 10 80       	push   $0x801070a6
80100269:	e8 e2 01 00 00       	call   80100450 <panic>
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
80100280:	e8 0b 16 00 00       	call   80101890 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 1f 42 00 00       	call   801044b0 <acquire>
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
801002c5:	e8 26 3c 00 00       	call   80103ef0 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 ff 10 80    	cmp    0x8010ffa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 70 36 00 00       	call   80103950 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 a5 10 80       	push   $0x8010a520
801002ef:	e8 7c 42 00 00       	call   80104570 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 b4 14 00 00       	call   801017b0 <ilock>
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
8010034d:	e8 1e 42 00 00       	call   80104570 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 56 14 00 00       	call   801017b0 <ilock>
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
  int c;

  iunlock(ip);
80100398:	83 ec 0c             	sub    $0xc,%esp
8010039b:	53                   	push   %ebx
8010039c:	e8 ef 14 00 00       	call   80101890 <iunlock>
  acquire(&cons.lock);
801003a1:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801003a8:	e8 03 41 00 00       	call   801044b0 <acquire>
  while(input.r == input.w){
801003ad:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801003b2:	83 c4 10             	add    $0x10,%esp
801003b5:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
801003bb:	74 25                	je     801003e2 <consolesteal+0x52>
801003bd:	eb 59                	jmp    80100418 <consolesteal+0x88>
801003bf:	90                   	nop
    if(myproc()->killed){
      release(&cons.lock);
      ilock(ip);
      return -1;
    }
    sleep(&input.r, &cons.lock);
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	68 20 a5 10 80       	push   $0x8010a520
801003c8:	68 a0 ff 10 80       	push   $0x8010ffa0
801003cd:	e8 1e 3b 00 00       	call   80103ef0 <sleep>
  while(input.r == input.w){
801003d2:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801003d7:	83 c4 10             	add    $0x10,%esp
801003da:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801003e0:	75 36                	jne    80100418 <consolesteal+0x88>
    if(myproc()->killed){
801003e2:	e8 69 35 00 00       	call   80103950 <myproc>
801003e7:	8b 40 24             	mov    0x24(%eax),%eax
801003ea:	85 c0                	test   %eax,%eax
801003ec:	74 d2                	je     801003c0 <consolesteal+0x30>
      release(&cons.lock);
801003ee:	83 ec 0c             	sub    $0xc,%esp
      ilock(ip);
801003f1:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&cons.lock);
801003f6:	68 20 a5 10 80       	push   $0x8010a520
801003fb:	e8 70 41 00 00       	call   80104570 <release>
      ilock(ip);
80100400:	89 1c 24             	mov    %ebx,(%esp)
80100403:	e8 a8 13 00 00       	call   801017b0 <ilock>
80100408:	83 c4 10             	add    $0x10,%esp
  c = input.buf[input.r++ % INPUT_BUF];
  release(&cons.lock);
  ilock(ip);

  return (int)c;
}
8010040b:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010040e:	89 f0                	mov    %esi,%eax
80100410:	5b                   	pop    %ebx
80100411:	5e                   	pop    %esi
80100412:	5d                   	pop    %ebp
80100413:	c3                   	ret    
80100414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100418:	83 ec 0c             	sub    $0xc,%esp
  c = input.buf[input.r++ % INPUT_BUF];
8010041b:	8d 50 01             	lea    0x1(%eax),%edx
8010041e:	83 e0 7f             	and    $0x7f,%eax
80100421:	0f be b0 20 ff 10 80 	movsbl -0x7fef00e0(%eax),%esi
  release(&cons.lock);
80100428:	68 20 a5 10 80       	push   $0x8010a520
  c = input.buf[input.r++ % INPUT_BUF];
8010042d:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
  release(&cons.lock);
80100433:	e8 38 41 00 00       	call   80104570 <release>
  ilock(ip);
80100438:	89 1c 24             	mov    %ebx,(%esp)
8010043b:	e8 70 13 00 00       	call   801017b0 <ilock>
  return (int)c;
80100440:	83 c4 10             	add    $0x10,%esp
}
80100443:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100446:	89 f0                	mov    %esi,%eax
80100448:	5b                   	pop    %ebx
80100449:	5e                   	pop    %esi
8010044a:	5d                   	pop    %ebp
8010044b:	c3                   	ret    
8010044c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100450 <panic>:
{
80100450:	55                   	push   %ebp
80100451:	89 e5                	mov    %esp,%ebp
80100453:	56                   	push   %esi
80100454:	53                   	push   %ebx
80100455:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100458:	fa                   	cli    
  cons.locking = 0;
80100459:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100460:	00 00 00 
  getcallerpcs(&s, pcs);
80100463:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100466:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100469:	e8 32 24 00 00       	call   801028a0 <lapicid>
8010046e:	83 ec 08             	sub    $0x8,%esp
80100471:	50                   	push   %eax
80100472:	68 ad 70 10 80       	push   $0x801070ad
80100477:	e8 a4 02 00 00       	call   80100720 <cprintf>
  cprintf(s);
8010047c:	58                   	pop    %eax
8010047d:	ff 75 08             	pushl  0x8(%ebp)
80100480:	e8 9b 02 00 00       	call   80100720 <cprintf>
  cprintf("\n");
80100485:	c7 04 24 ff 79 10 80 	movl   $0x801079ff,(%esp)
8010048c:	e8 8f 02 00 00       	call   80100720 <cprintf>
  getcallerpcs(&s, pcs);
80100491:	5a                   	pop    %edx
80100492:	8d 45 08             	lea    0x8(%ebp),%eax
80100495:	59                   	pop    %ecx
80100496:	53                   	push   %ebx
80100497:	50                   	push   %eax
80100498:	e8 f3 3e 00 00       	call   80104390 <getcallerpcs>
8010049d:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801004a0:	83 ec 08             	sub    $0x8,%esp
801004a3:	ff 33                	pushl  (%ebx)
801004a5:	83 c3 04             	add    $0x4,%ebx
801004a8:	68 c1 70 10 80       	push   $0x801070c1
801004ad:	e8 6e 02 00 00       	call   80100720 <cprintf>
  for(i=0; i<10; i++)
801004b2:	83 c4 10             	add    $0x10,%esp
801004b5:	39 f3                	cmp    %esi,%ebx
801004b7:	75 e7                	jne    801004a0 <panic+0x50>
  panicked = 1; // freeze other CPU
801004b9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801004c0:	00 00 00 
801004c3:	eb fe                	jmp    801004c3 <panic+0x73>
801004c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801004c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801004d0 <consputc>:
  if(panicked){
801004d0:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
801004d6:	85 c9                	test   %ecx,%ecx
801004d8:	74 06                	je     801004e0 <consputc+0x10>
801004da:	fa                   	cli    
801004db:	eb fe                	jmp    801004db <consputc+0xb>
801004dd:	8d 76 00             	lea    0x0(%esi),%esi
{
801004e0:	55                   	push   %ebp
801004e1:	89 e5                	mov    %esp,%ebp
801004e3:	57                   	push   %edi
801004e4:	56                   	push   %esi
801004e5:	53                   	push   %ebx
801004e6:	89 c6                	mov    %eax,%esi
801004e8:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
801004eb:	3d 00 01 00 00       	cmp    $0x100,%eax
801004f0:	0f 84 b1 00 00 00    	je     801005a7 <consputc+0xd7>
    uartputc(c);
801004f6:	83 ec 0c             	sub    $0xc,%esp
801004f9:	50                   	push   %eax
801004fa:	e8 81 57 00 00       	call   80105c80 <uartputc>
801004ff:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100502:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100507:	b8 0e 00 00 00       	mov    $0xe,%eax
8010050c:	89 da                	mov    %ebx,%edx
8010050e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010050f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100514:	89 ca                	mov    %ecx,%edx
80100516:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100517:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010051a:	89 da                	mov    %ebx,%edx
8010051c:	c1 e0 08             	shl    $0x8,%eax
8010051f:	89 c7                	mov    %eax,%edi
80100521:	b8 0f 00 00 00       	mov    $0xf,%eax
80100526:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100527:	89 ca                	mov    %ecx,%edx
80100529:	ec                   	in     (%dx),%al
8010052a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010052d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010052f:	83 fe 0a             	cmp    $0xa,%esi
80100532:	0f 84 f3 00 00 00    	je     8010062b <consputc+0x15b>
  else if(c == BACKSPACE){
80100538:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010053e:	0f 84 d7 00 00 00    	je     8010061b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100544:	89 f0                	mov    %esi,%eax
80100546:	0f b6 c0             	movzbl %al,%eax
80100549:	80 cc 07             	or     $0x7,%ah
8010054c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100553:	80 
80100554:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100557:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010055d:	0f 8f ab 00 00 00    	jg     8010060e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
80100563:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
80100569:	7f 66                	jg     801005d1 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010056b:	be d4 03 00 00       	mov    $0x3d4,%esi
80100570:	b8 0e 00 00 00       	mov    $0xe,%eax
80100575:	89 f2                	mov    %esi,%edx
80100577:	ee                   	out    %al,(%dx)
80100578:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
8010057d:	89 d8                	mov    %ebx,%eax
8010057f:	c1 f8 08             	sar    $0x8,%eax
80100582:	89 ca                	mov    %ecx,%edx
80100584:	ee                   	out    %al,(%dx)
80100585:	b8 0f 00 00 00       	mov    $0xf,%eax
8010058a:	89 f2                	mov    %esi,%edx
8010058c:	ee                   	out    %al,(%dx)
8010058d:	89 d8                	mov    %ebx,%eax
8010058f:	89 ca                	mov    %ecx,%edx
80100591:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
80100592:	b8 20 07 00 00       	mov    $0x720,%eax
80100597:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
8010059e:	80 
}
8010059f:	8d 65 f4             	lea    -0xc(%ebp),%esp
801005a2:	5b                   	pop    %ebx
801005a3:	5e                   	pop    %esi
801005a4:	5f                   	pop    %edi
801005a5:	5d                   	pop    %ebp
801005a6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801005a7:	83 ec 0c             	sub    $0xc,%esp
801005aa:	6a 08                	push   $0x8
801005ac:	e8 cf 56 00 00       	call   80105c80 <uartputc>
801005b1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801005b8:	e8 c3 56 00 00       	call   80105c80 <uartputc>
801005bd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801005c4:	e8 b7 56 00 00       	call   80105c80 <uartputc>
801005c9:	83 c4 10             	add    $0x10,%esp
801005cc:	e9 31 ff ff ff       	jmp    80100502 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801005d1:	52                   	push   %edx
801005d2:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
801005d7:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801005da:	68 a0 80 0b 80       	push   $0x800b80a0
801005df:	68 00 80 0b 80       	push   $0x800b8000
801005e4:	e8 87 40 00 00       	call   80104670 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801005e9:	b8 80 07 00 00       	mov    $0x780,%eax
801005ee:	83 c4 0c             	add    $0xc,%esp
801005f1:	29 d8                	sub    %ebx,%eax
801005f3:	01 c0                	add    %eax,%eax
801005f5:	50                   	push   %eax
801005f6:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
801005f9:	6a 00                	push   $0x0
801005fb:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100600:	50                   	push   %eax
80100601:	e8 ba 3f 00 00       	call   801045c0 <memset>
80100606:	83 c4 10             	add    $0x10,%esp
80100609:	e9 5d ff ff ff       	jmp    8010056b <consputc+0x9b>
    panic("pos under/overflow");
8010060e:	83 ec 0c             	sub    $0xc,%esp
80100611:	68 c5 70 10 80       	push   $0x801070c5
80100616:	e8 35 fe ff ff       	call   80100450 <panic>
    if(pos > 0) --pos;
8010061b:	85 db                	test   %ebx,%ebx
8010061d:	0f 84 48 ff ff ff    	je     8010056b <consputc+0x9b>
80100623:	83 eb 01             	sub    $0x1,%ebx
80100626:	e9 2c ff ff ff       	jmp    80100557 <consputc+0x87>
    pos += 80 - pos%80;
8010062b:	89 d8                	mov    %ebx,%eax
8010062d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100632:	99                   	cltd   
80100633:	f7 f9                	idiv   %ecx
80100635:	29 d1                	sub    %edx,%ecx
80100637:	01 cb                	add    %ecx,%ebx
80100639:	e9 19 ff ff ff       	jmp    80100557 <consputc+0x87>
8010063e:	66 90                	xchg   %ax,%ax

80100640 <printint>:
{
80100640:	55                   	push   %ebp
80100641:	89 e5                	mov    %esp,%ebp
80100643:	57                   	push   %edi
80100644:	56                   	push   %esi
80100645:	53                   	push   %ebx
80100646:	89 d3                	mov    %edx,%ebx
80100648:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010064b:	85 c9                	test   %ecx,%ecx
{
8010064d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100650:	74 04                	je     80100656 <printint+0x16>
80100652:	85 c0                	test   %eax,%eax
80100654:	78 5a                	js     801006b0 <printint+0x70>
    x = xx;
80100656:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010065d:	31 c9                	xor    %ecx,%ecx
8010065f:	8d 75 d7             	lea    -0x29(%ebp),%esi
80100662:	eb 06                	jmp    8010066a <printint+0x2a>
80100664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
80100668:	89 f9                	mov    %edi,%ecx
8010066a:	31 d2                	xor    %edx,%edx
8010066c:	8d 79 01             	lea    0x1(%ecx),%edi
8010066f:	f7 f3                	div    %ebx
80100671:	0f b6 92 f0 70 10 80 	movzbl -0x7fef8f10(%edx),%edx
  }while((x /= base) != 0);
80100678:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
8010067a:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
8010067d:	75 e9                	jne    80100668 <printint+0x28>
  if(sign)
8010067f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100682:	85 c0                	test   %eax,%eax
80100684:	74 08                	je     8010068e <printint+0x4e>
    buf[i++] = '-';
80100686:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
8010068b:	8d 79 02             	lea    0x2(%ecx),%edi
8010068e:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
80100692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
80100698:	0f be 03             	movsbl (%ebx),%eax
8010069b:	83 eb 01             	sub    $0x1,%ebx
8010069e:	e8 2d fe ff ff       	call   801004d0 <consputc>
  while(--i >= 0)
801006a3:	39 f3                	cmp    %esi,%ebx
801006a5:	75 f1                	jne    80100698 <printint+0x58>
}
801006a7:	83 c4 2c             	add    $0x2c,%esp
801006aa:	5b                   	pop    %ebx
801006ab:	5e                   	pop    %esi
801006ac:	5f                   	pop    %edi
801006ad:	5d                   	pop    %ebp
801006ae:	c3                   	ret    
801006af:	90                   	nop
    x = -xx;
801006b0:	f7 d8                	neg    %eax
801006b2:	eb a9                	jmp    8010065d <printint+0x1d>
801006b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801006ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801006c0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801006c0:	55                   	push   %ebp
801006c1:	89 e5                	mov    %esp,%ebp
801006c3:	57                   	push   %edi
801006c4:	56                   	push   %esi
801006c5:	53                   	push   %ebx
801006c6:	83 ec 18             	sub    $0x18,%esp
801006c9:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801006cc:	ff 75 08             	pushl  0x8(%ebp)
801006cf:	e8 bc 11 00 00       	call   80101890 <iunlock>
  acquire(&cons.lock);
801006d4:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801006db:	e8 d0 3d 00 00       	call   801044b0 <acquire>
  for(i = 0; i < n; i++)
801006e0:	83 c4 10             	add    $0x10,%esp
801006e3:	85 f6                	test   %esi,%esi
801006e5:	7e 18                	jle    801006ff <consolewrite+0x3f>
801006e7:	8b 7d 0c             	mov    0xc(%ebp),%edi
801006ea:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
801006ed:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
801006f0:	0f b6 07             	movzbl (%edi),%eax
801006f3:	83 c7 01             	add    $0x1,%edi
801006f6:	e8 d5 fd ff ff       	call   801004d0 <consputc>
  for(i = 0; i < n; i++)
801006fb:	39 fb                	cmp    %edi,%ebx
801006fd:	75 f1                	jne    801006f0 <consolewrite+0x30>
  release(&cons.lock);
801006ff:	83 ec 0c             	sub    $0xc,%esp
80100702:	68 20 a5 10 80       	push   $0x8010a520
80100707:	e8 64 3e 00 00       	call   80104570 <release>
  ilock(ip);
8010070c:	58                   	pop    %eax
8010070d:	ff 75 08             	pushl  0x8(%ebp)
80100710:	e8 9b 10 00 00       	call   801017b0 <ilock>

  return n;
}
80100715:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100718:	89 f0                	mov    %esi,%eax
8010071a:	5b                   	pop    %ebx
8010071b:	5e                   	pop    %esi
8010071c:	5f                   	pop    %edi
8010071d:	5d                   	pop    %ebp
8010071e:	c3                   	ret    
8010071f:	90                   	nop

80100720 <cprintf>:
{
80100720:	55                   	push   %ebp
80100721:	89 e5                	mov    %esp,%ebp
80100723:	57                   	push   %edi
80100724:	56                   	push   %esi
80100725:	53                   	push   %ebx
80100726:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100729:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010072e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100730:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100733:	0f 85 6f 01 00 00    	jne    801008a8 <cprintf+0x188>
  if (fmt == 0)
80100739:	8b 45 08             	mov    0x8(%ebp),%eax
8010073c:	85 c0                	test   %eax,%eax
8010073e:	89 c7                	mov    %eax,%edi
80100740:	0f 84 77 01 00 00    	je     801008bd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100746:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100749:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010074c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010074e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100751:	85 c0                	test   %eax,%eax
80100753:	75 56                	jne    801007ab <cprintf+0x8b>
80100755:	eb 79                	jmp    801007d0 <cprintf+0xb0>
80100757:	89 f6                	mov    %esi,%esi
80100759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
80100760:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
80100763:	85 d2                	test   %edx,%edx
80100765:	74 69                	je     801007d0 <cprintf+0xb0>
80100767:	83 c3 02             	add    $0x2,%ebx
    switch(c){
8010076a:	83 fa 70             	cmp    $0x70,%edx
8010076d:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
80100770:	0f 84 84 00 00 00    	je     801007fa <cprintf+0xda>
80100776:	7f 78                	jg     801007f0 <cprintf+0xd0>
80100778:	83 fa 25             	cmp    $0x25,%edx
8010077b:	0f 84 ff 00 00 00    	je     80100880 <cprintf+0x160>
80100781:	83 fa 64             	cmp    $0x64,%edx
80100784:	0f 85 8e 00 00 00    	jne    80100818 <cprintf+0xf8>
      printint(*argp++, 10, 1);
8010078a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010078d:	ba 0a 00 00 00       	mov    $0xa,%edx
80100792:	8d 48 04             	lea    0x4(%eax),%ecx
80100795:	8b 00                	mov    (%eax),%eax
80100797:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010079a:	b9 01 00 00 00       	mov    $0x1,%ecx
8010079f:	e8 9c fe ff ff       	call   80100640 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007a4:	0f b6 06             	movzbl (%esi),%eax
801007a7:	85 c0                	test   %eax,%eax
801007a9:	74 25                	je     801007d0 <cprintf+0xb0>
801007ab:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801007ae:	83 f8 25             	cmp    $0x25,%eax
801007b1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801007b4:	74 aa                	je     80100760 <cprintf+0x40>
801007b6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801007b9:	e8 12 fd ff ff       	call   801004d0 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007be:	0f b6 06             	movzbl (%esi),%eax
      continue;
801007c1:	8b 55 e0             	mov    -0x20(%ebp),%edx
801007c4:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007c6:	85 c0                	test   %eax,%eax
801007c8:	75 e1                	jne    801007ab <cprintf+0x8b>
801007ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
801007d0:	8b 45 dc             	mov    -0x24(%ebp),%eax
801007d3:	85 c0                	test   %eax,%eax
801007d5:	74 10                	je     801007e7 <cprintf+0xc7>
    release(&cons.lock);
801007d7:	83 ec 0c             	sub    $0xc,%esp
801007da:	68 20 a5 10 80       	push   $0x8010a520
801007df:	e8 8c 3d 00 00       	call   80104570 <release>
801007e4:	83 c4 10             	add    $0x10,%esp
}
801007e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801007ea:	5b                   	pop    %ebx
801007eb:	5e                   	pop    %esi
801007ec:	5f                   	pop    %edi
801007ed:	5d                   	pop    %ebp
801007ee:	c3                   	ret    
801007ef:	90                   	nop
    switch(c){
801007f0:	83 fa 73             	cmp    $0x73,%edx
801007f3:	74 43                	je     80100838 <cprintf+0x118>
801007f5:	83 fa 78             	cmp    $0x78,%edx
801007f8:	75 1e                	jne    80100818 <cprintf+0xf8>
      printint(*argp++, 16, 0);
801007fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801007fd:	ba 10 00 00 00       	mov    $0x10,%edx
80100802:	8d 48 04             	lea    0x4(%eax),%ecx
80100805:	8b 00                	mov    (%eax),%eax
80100807:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010080a:	31 c9                	xor    %ecx,%ecx
8010080c:	e8 2f fe ff ff       	call   80100640 <printint>
      break;
80100811:	eb 91                	jmp    801007a4 <cprintf+0x84>
80100813:	90                   	nop
80100814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100818:	b8 25 00 00 00       	mov    $0x25,%eax
8010081d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100820:	e8 ab fc ff ff       	call   801004d0 <consputc>
      consputc(c);
80100825:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100828:	89 d0                	mov    %edx,%eax
8010082a:	e8 a1 fc ff ff       	call   801004d0 <consputc>
      break;
8010082f:	e9 70 ff ff ff       	jmp    801007a4 <cprintf+0x84>
80100834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100838:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010083b:	8b 10                	mov    (%eax),%edx
8010083d:	8d 48 04             	lea    0x4(%eax),%ecx
80100840:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100843:	85 d2                	test   %edx,%edx
80100845:	74 49                	je     80100890 <cprintf+0x170>
      for(; *s; s++)
80100847:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010084a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010084d:	84 c0                	test   %al,%al
8010084f:	0f 84 4f ff ff ff    	je     801007a4 <cprintf+0x84>
80100855:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100858:	89 d3                	mov    %edx,%ebx
8010085a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100860:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
80100863:	e8 68 fc ff ff       	call   801004d0 <consputc>
      for(; *s; s++)
80100868:	0f be 03             	movsbl (%ebx),%eax
8010086b:	84 c0                	test   %al,%al
8010086d:	75 f1                	jne    80100860 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
8010086f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100872:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80100875:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100878:	e9 27 ff ff ff       	jmp    801007a4 <cprintf+0x84>
8010087d:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
80100880:	b8 25 00 00 00       	mov    $0x25,%eax
80100885:	e8 46 fc ff ff       	call   801004d0 <consputc>
      break;
8010088a:	e9 15 ff ff ff       	jmp    801007a4 <cprintf+0x84>
8010088f:	90                   	nop
        s = "(null)";
80100890:	ba d8 70 10 80       	mov    $0x801070d8,%edx
      for(; *s; s++)
80100895:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100898:	b8 28 00 00 00       	mov    $0x28,%eax
8010089d:	89 d3                	mov    %edx,%ebx
8010089f:	eb bf                	jmp    80100860 <cprintf+0x140>
801008a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801008a8:	83 ec 0c             	sub    $0xc,%esp
801008ab:	68 20 a5 10 80       	push   $0x8010a520
801008b0:	e8 fb 3b 00 00       	call   801044b0 <acquire>
801008b5:	83 c4 10             	add    $0x10,%esp
801008b8:	e9 7c fe ff ff       	jmp    80100739 <cprintf+0x19>
    panic("null fmt");
801008bd:	83 ec 0c             	sub    $0xc,%esp
801008c0:	68 df 70 10 80       	push   $0x801070df
801008c5:	e8 86 fb ff ff       	call   80100450 <panic>
801008ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801008d0 <consoleintr>:
{
801008d0:	55                   	push   %ebp
801008d1:	89 e5                	mov    %esp,%ebp
801008d3:	57                   	push   %edi
801008d4:	56                   	push   %esi
801008d5:	53                   	push   %ebx
  int c, doprocdump = 0;
801008d6:	31 f6                	xor    %esi,%esi
{
801008d8:	83 ec 18             	sub    $0x18,%esp
801008db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801008de:	68 20 a5 10 80       	push   $0x8010a520
801008e3:	e8 c8 3b 00 00       	call   801044b0 <acquire>
  while((c = getc()) >= 0){
801008e8:	83 c4 10             	add    $0x10,%esp
801008eb:	90                   	nop
801008ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801008f0:	ff d3                	call   *%ebx
801008f2:	85 c0                	test   %eax,%eax
801008f4:	89 c7                	mov    %eax,%edi
801008f6:	78 48                	js     80100940 <consoleintr+0x70>
    switch(c){
801008f8:	83 ff 10             	cmp    $0x10,%edi
801008fb:	0f 84 e7 00 00 00    	je     801009e8 <consoleintr+0x118>
80100901:	7e 5d                	jle    80100960 <consoleintr+0x90>
80100903:	83 ff 15             	cmp    $0x15,%edi
80100906:	0f 84 ec 00 00 00    	je     801009f8 <consoleintr+0x128>
8010090c:	83 ff 7f             	cmp    $0x7f,%edi
8010090f:	75 54                	jne    80100965 <consoleintr+0x95>
      if(input.e != input.w){
80100911:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100916:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010091c:	74 d2                	je     801008f0 <consoleintr+0x20>
        input.e--;
8010091e:	83 e8 01             	sub    $0x1,%eax
80100921:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100926:	b8 00 01 00 00       	mov    $0x100,%eax
8010092b:	e8 a0 fb ff ff       	call   801004d0 <consputc>
  while((c = getc()) >= 0){
80100930:	ff d3                	call   *%ebx
80100932:	85 c0                	test   %eax,%eax
80100934:	89 c7                	mov    %eax,%edi
80100936:	79 c0                	jns    801008f8 <consoleintr+0x28>
80100938:	90                   	nop
80100939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100940:	83 ec 0c             	sub    $0xc,%esp
80100943:	68 20 a5 10 80       	push   $0x8010a520
80100948:	e8 23 3c 00 00       	call   80104570 <release>
  if(doprocdump) {
8010094d:	83 c4 10             	add    $0x10,%esp
80100950:	85 f6                	test   %esi,%esi
80100952:	0f 85 f8 00 00 00    	jne    80100a50 <consoleintr+0x180>
}
80100958:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010095b:	5b                   	pop    %ebx
8010095c:	5e                   	pop    %esi
8010095d:	5f                   	pop    %edi
8010095e:	5d                   	pop    %ebp
8010095f:	c3                   	ret    
    switch(c){
80100960:	83 ff 08             	cmp    $0x8,%edi
80100963:	74 ac                	je     80100911 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100965:	85 ff                	test   %edi,%edi
80100967:	74 87                	je     801008f0 <consoleintr+0x20>
80100969:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010096e:	89 c2                	mov    %eax,%edx
80100970:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
80100976:	83 fa 7f             	cmp    $0x7f,%edx
80100979:	0f 87 71 ff ff ff    	ja     801008f0 <consoleintr+0x20>
8010097f:	8d 50 01             	lea    0x1(%eax),%edx
80100982:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100985:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100988:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        c = (c == '\r') ? '\n' : c;
8010098e:	0f 84 cc 00 00 00    	je     80100a60 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
80100994:	89 f9                	mov    %edi,%ecx
80100996:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
8010099c:	89 f8                	mov    %edi,%eax
8010099e:	e8 2d fb ff ff       	call   801004d0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009a3:	83 ff 0a             	cmp    $0xa,%edi
801009a6:	0f 84 c5 00 00 00    	je     80100a71 <consoleintr+0x1a1>
801009ac:	83 ff 04             	cmp    $0x4,%edi
801009af:	0f 84 bc 00 00 00    	je     80100a71 <consoleintr+0x1a1>
801009b5:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801009ba:	83 e8 80             	sub    $0xffffff80,%eax
801009bd:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
801009c3:	0f 85 27 ff ff ff    	jne    801008f0 <consoleintr+0x20>
          wakeup(&input.r);
801009c9:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
801009cc:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
801009d1:	68 a0 ff 10 80       	push   $0x8010ffa0
801009d6:	e8 c5 36 00 00       	call   801040a0 <wakeup>
801009db:	83 c4 10             	add    $0x10,%esp
801009de:	e9 0d ff ff ff       	jmp    801008f0 <consoleintr+0x20>
801009e3:	90                   	nop
801009e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
801009e8:	be 01 00 00 00       	mov    $0x1,%esi
801009ed:	e9 fe fe ff ff       	jmp    801008f0 <consoleintr+0x20>
801009f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
801009f8:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801009fd:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
80100a03:	75 2b                	jne    80100a30 <consoleintr+0x160>
80100a05:	e9 e6 fe ff ff       	jmp    801008f0 <consoleintr+0x20>
80100a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100a10:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100a15:	b8 00 01 00 00       	mov    $0x100,%eax
80100a1a:	e8 b1 fa ff ff       	call   801004d0 <consputc>
      while(input.e != input.w &&
80100a1f:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100a24:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
80100a2a:	0f 84 c0 fe ff ff    	je     801008f0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100a30:	83 e8 01             	sub    $0x1,%eax
80100a33:	89 c2                	mov    %eax,%edx
80100a35:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100a38:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
80100a3f:	75 cf                	jne    80100a10 <consoleintr+0x140>
80100a41:	e9 aa fe ff ff       	jmp    801008f0 <consoleintr+0x20>
80100a46:	8d 76 00             	lea    0x0(%esi),%esi
80100a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100a50:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a53:	5b                   	pop    %ebx
80100a54:	5e                   	pop    %esi
80100a55:	5f                   	pop    %edi
80100a56:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a57:	e9 24 37 00 00       	jmp    80104180 <procdump>
80100a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
80100a60:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
80100a67:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a6c:	e8 5f fa ff ff       	call   801004d0 <consputc>
80100a71:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100a76:	e9 4e ff ff ff       	jmp    801009c9 <consoleintr+0xf9>
80100a7b:	90                   	nop
80100a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100a80 <consoleinit>:

void
consoleinit(void)
{
80100a80:	55                   	push   %ebp
80100a81:	89 e5                	mov    %esp,%ebp
80100a83:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a86:	68 e8 70 10 80       	push   $0x801070e8
80100a8b:	68 20 a5 10 80       	push   $0x8010a520
80100a90:	e8 db 38 00 00       	call   80104370 <initlock>
  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  devsw[CONSOLE].steal = consolesteal;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a95:	58                   	pop    %eax
80100a96:	5a                   	pop    %edx
80100a97:	6a 00                	push   $0x0
80100a99:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100a9b:	c7 05 74 09 11 80 c0 	movl   $0x801006c0,0x80110974
80100aa2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100aa5:	c7 05 6c 09 11 80 70 	movl   $0x80100270,0x8011096c
80100aac:	02 10 80 
  devsw[CONSOLE].steal = consolesteal;
80100aaf:	c7 05 70 09 11 80 90 	movl   $0x80100390,0x80110970
80100ab6:	03 10 80 
  cons.locking = 1;
80100ab9:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
80100ac0:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100ac3:	e8 78 19 00 00       	call   80102440 <ioapicenable>
}
80100ac8:	83 c4 10             	add    $0x10,%esp
80100acb:	c9                   	leave  
80100acc:	c3                   	ret    
80100acd:	66 90                	xchg   %ax,%ax
80100acf:	90                   	nop

80100ad0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100ad0:	55                   	push   %ebp
80100ad1:	89 e5                	mov    %esp,%ebp
80100ad3:	57                   	push   %edi
80100ad4:	56                   	push   %esi
80100ad5:	53                   	push   %ebx
80100ad6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100adc:	e8 6f 2e 00 00       	call   80103950 <myproc>
80100ae1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100ae7:	e8 24 22 00 00       	call   80102d10 <begin_op>

  if((ip = namei(path)) == 0){
80100aec:	83 ec 0c             	sub    $0xc,%esp
80100aef:	ff 75 08             	pushl  0x8(%ebp)
80100af2:	e8 59 15 00 00       	call   80102050 <namei>
80100af7:	83 c4 10             	add    $0x10,%esp
80100afa:	85 c0                	test   %eax,%eax
80100afc:	0f 84 91 01 00 00    	je     80100c93 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100b02:	83 ec 0c             	sub    $0xc,%esp
80100b05:	89 c3                	mov    %eax,%ebx
80100b07:	50                   	push   %eax
80100b08:	e8 a3 0c 00 00       	call   801017b0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100b0d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100b13:	6a 34                	push   $0x34
80100b15:	6a 00                	push   $0x0
80100b17:	50                   	push   %eax
80100b18:	53                   	push   %ebx
80100b19:	e8 72 0f 00 00       	call   80101a90 <readi>
80100b1e:	83 c4 20             	add    $0x20,%esp
80100b21:	83 f8 34             	cmp    $0x34,%eax
80100b24:	74 22                	je     80100b48 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100b26:	83 ec 0c             	sub    $0xc,%esp
80100b29:	53                   	push   %ebx
80100b2a:	e8 11 0f 00 00       	call   80101a40 <iunlockput>
    end_op();
80100b2f:	e8 4c 22 00 00       	call   80102d80 <end_op>
80100b34:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100b37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100b3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b3f:	5b                   	pop    %ebx
80100b40:	5e                   	pop    %esi
80100b41:	5f                   	pop    %edi
80100b42:	5d                   	pop    %ebp
80100b43:	c3                   	ret    
80100b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100b48:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b4f:	45 4c 46 
80100b52:	75 d2                	jne    80100b26 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100b54:	e8 77 62 00 00       	call   80106dd0 <setupkvm>
80100b59:	85 c0                	test   %eax,%eax
80100b5b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b61:	74 c3                	je     80100b26 <exec+0x56>
  sz = 0;
80100b63:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b65:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b6c:	00 
80100b6d:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100b73:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100b79:	0f 84 8c 02 00 00    	je     80100e0b <exec+0x33b>
80100b7f:	31 f6                	xor    %esi,%esi
80100b81:	eb 7f                	jmp    80100c02 <exec+0x132>
80100b83:	90                   	nop
80100b84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100b88:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b8f:	75 63                	jne    80100bf4 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100b91:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b97:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b9d:	0f 82 86 00 00 00    	jb     80100c29 <exec+0x159>
80100ba3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ba9:	72 7e                	jb     80100c29 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100bab:	83 ec 04             	sub    $0x4,%esp
80100bae:	50                   	push   %eax
80100baf:	57                   	push   %edi
80100bb0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bb6:	e8 35 60 00 00       	call   80106bf0 <allocuvm>
80100bbb:	83 c4 10             	add    $0x10,%esp
80100bbe:	85 c0                	test   %eax,%eax
80100bc0:	89 c7                	mov    %eax,%edi
80100bc2:	74 65                	je     80100c29 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100bc4:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bca:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bcf:	75 58                	jne    80100c29 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100bd1:	83 ec 0c             	sub    $0xc,%esp
80100bd4:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100bda:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100be0:	53                   	push   %ebx
80100be1:	50                   	push   %eax
80100be2:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100be8:	e8 43 5f 00 00       	call   80106b30 <loaduvm>
80100bed:	83 c4 20             	add    $0x20,%esp
80100bf0:	85 c0                	test   %eax,%eax
80100bf2:	78 35                	js     80100c29 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bf4:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bfb:	83 c6 01             	add    $0x1,%esi
80100bfe:	39 f0                	cmp    %esi,%eax
80100c00:	7e 3d                	jle    80100c3f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c02:	89 f0                	mov    %esi,%eax
80100c04:	6a 20                	push   $0x20
80100c06:	c1 e0 05             	shl    $0x5,%eax
80100c09:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100c0f:	50                   	push   %eax
80100c10:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100c16:	50                   	push   %eax
80100c17:	53                   	push   %ebx
80100c18:	e8 73 0e 00 00       	call   80101a90 <readi>
80100c1d:	83 c4 10             	add    $0x10,%esp
80100c20:	83 f8 20             	cmp    $0x20,%eax
80100c23:	0f 84 5f ff ff ff    	je     80100b88 <exec+0xb8>
    freevm(pgdir);
80100c29:	83 ec 0c             	sub    $0xc,%esp
80100c2c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c32:	e8 19 61 00 00       	call   80106d50 <freevm>
80100c37:	83 c4 10             	add    $0x10,%esp
80100c3a:	e9 e7 fe ff ff       	jmp    80100b26 <exec+0x56>
80100c3f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100c45:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100c4b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100c51:	83 ec 0c             	sub    $0xc,%esp
80100c54:	53                   	push   %ebx
80100c55:	e8 e6 0d 00 00       	call   80101a40 <iunlockput>
  end_op();
80100c5a:	e8 21 21 00 00       	call   80102d80 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c5f:	83 c4 0c             	add    $0xc,%esp
80100c62:	56                   	push   %esi
80100c63:	57                   	push   %edi
80100c64:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c6a:	e8 81 5f 00 00       	call   80106bf0 <allocuvm>
80100c6f:	83 c4 10             	add    $0x10,%esp
80100c72:	85 c0                	test   %eax,%eax
80100c74:	89 c6                	mov    %eax,%esi
80100c76:	75 3a                	jne    80100cb2 <exec+0x1e2>
    freevm(pgdir);
80100c78:	83 ec 0c             	sub    $0xc,%esp
80100c7b:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c81:	e8 ca 60 00 00       	call   80106d50 <freevm>
80100c86:	83 c4 10             	add    $0x10,%esp
  return -1;
80100c89:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c8e:	e9 a9 fe ff ff       	jmp    80100b3c <exec+0x6c>
    end_op();
80100c93:	e8 e8 20 00 00       	call   80102d80 <end_op>
    cprintf("exec: fail\n");
80100c98:	83 ec 0c             	sub    $0xc,%esp
80100c9b:	68 01 71 10 80       	push   $0x80107101
80100ca0:	e8 7b fa ff ff       	call   80100720 <cprintf>
    return -1;
80100ca5:	83 c4 10             	add    $0x10,%esp
80100ca8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100cad:	e9 8a fe ff ff       	jmp    80100b3c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cb2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100cb8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100cbb:	31 ff                	xor    %edi,%edi
80100cbd:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cbf:	50                   	push   %eax
80100cc0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100cc6:	e8 a5 61 00 00       	call   80106e70 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100ccb:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cce:	83 c4 10             	add    $0x10,%esp
80100cd1:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100cd7:	8b 00                	mov    (%eax),%eax
80100cd9:	85 c0                	test   %eax,%eax
80100cdb:	74 70                	je     80100d4d <exec+0x27d>
80100cdd:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100ce3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100ce9:	eb 0a                	jmp    80100cf5 <exec+0x225>
80100ceb:	90                   	nop
80100cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100cf0:	83 ff 20             	cmp    $0x20,%edi
80100cf3:	74 83                	je     80100c78 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cf5:	83 ec 0c             	sub    $0xc,%esp
80100cf8:	50                   	push   %eax
80100cf9:	e8 e2 3a 00 00       	call   801047e0 <strlen>
80100cfe:	f7 d0                	not    %eax
80100d00:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d02:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d05:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d06:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d09:	ff 34 b8             	pushl  (%eax,%edi,4)
80100d0c:	e8 cf 3a 00 00       	call   801047e0 <strlen>
80100d11:	83 c0 01             	add    $0x1,%eax
80100d14:	50                   	push   %eax
80100d15:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d18:	ff 34 b8             	pushl  (%eax,%edi,4)
80100d1b:	53                   	push   %ebx
80100d1c:	56                   	push   %esi
80100d1d:	e8 ae 62 00 00       	call   80106fd0 <copyout>
80100d22:	83 c4 20             	add    $0x20,%esp
80100d25:	85 c0                	test   %eax,%eax
80100d27:	0f 88 4b ff ff ff    	js     80100c78 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100d2d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100d30:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100d37:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100d3a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100d40:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100d43:	85 c0                	test   %eax,%eax
80100d45:	75 a9                	jne    80100cf0 <exec+0x220>
80100d47:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d4d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100d54:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100d56:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100d5d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100d61:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d68:	ff ff ff 
  ustack[1] = argc;
80100d6b:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d71:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100d73:	83 c0 0c             	add    $0xc,%eax
80100d76:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d78:	50                   	push   %eax
80100d79:	52                   	push   %edx
80100d7a:	53                   	push   %ebx
80100d7b:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d81:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d87:	e8 44 62 00 00       	call   80106fd0 <copyout>
80100d8c:	83 c4 10             	add    $0x10,%esp
80100d8f:	85 c0                	test   %eax,%eax
80100d91:	0f 88 e1 fe ff ff    	js     80100c78 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100d97:	8b 45 08             	mov    0x8(%ebp),%eax
80100d9a:	0f b6 00             	movzbl (%eax),%eax
80100d9d:	84 c0                	test   %al,%al
80100d9f:	74 17                	je     80100db8 <exec+0x2e8>
80100da1:	8b 55 08             	mov    0x8(%ebp),%edx
80100da4:	89 d1                	mov    %edx,%ecx
80100da6:	83 c1 01             	add    $0x1,%ecx
80100da9:	3c 2f                	cmp    $0x2f,%al
80100dab:	0f b6 01             	movzbl (%ecx),%eax
80100dae:	0f 44 d1             	cmove  %ecx,%edx
80100db1:	84 c0                	test   %al,%al
80100db3:	75 f1                	jne    80100da6 <exec+0x2d6>
80100db5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100db8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100dbe:	50                   	push   %eax
80100dbf:	6a 10                	push   $0x10
80100dc1:	ff 75 08             	pushl  0x8(%ebp)
80100dc4:	89 f8                	mov    %edi,%eax
80100dc6:	83 c0 70             	add    $0x70,%eax
80100dc9:	50                   	push   %eax
80100dca:	e8 d1 39 00 00       	call   801047a0 <safestrcpy>
  curproc->pgdir = pgdir;
80100dcf:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100dd5:	89 f9                	mov    %edi,%ecx
80100dd7:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80100dda:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->sz = sz;
80100ddd:	89 31                	mov    %esi,(%ecx)
  curproc->pgdir = pgdir;
80100ddf:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100de2:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100de8:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100deb:	8b 41 18             	mov    0x18(%ecx),%eax
80100dee:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100df1:	89 0c 24             	mov    %ecx,(%esp)
80100df4:	e8 a7 5b 00 00       	call   801069a0 <switchuvm>
  freevm(oldpgdir);
80100df9:	89 3c 24             	mov    %edi,(%esp)
80100dfc:	e8 4f 5f 00 00       	call   80106d50 <freevm>
  return 0;
80100e01:	83 c4 10             	add    $0x10,%esp
80100e04:	31 c0                	xor    %eax,%eax
80100e06:	e9 31 fd ff ff       	jmp    80100b3c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e0b:	be 00 20 00 00       	mov    $0x2000,%esi
80100e10:	e9 3c fe ff ff       	jmp    80100c51 <exec+0x181>
80100e15:	66 90                	xchg   %ax,%ax
80100e17:	66 90                	xchg   %ax,%ax
80100e19:	66 90                	xchg   %ax,%ax
80100e1b:	66 90                	xchg   %ax,%ax
80100e1d:	66 90                	xchg   %ax,%ax
80100e1f:	90                   	nop

80100e20 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e20:	55                   	push   %ebp
80100e21:	89 e5                	mov    %esp,%ebp
80100e23:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100e26:	68 0d 71 10 80       	push   $0x8010710d
80100e2b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e30:	e8 3b 35 00 00       	call   80104370 <initlock>
}
80100e35:	83 c4 10             	add    $0x10,%esp
80100e38:	c9                   	leave  
80100e39:	c3                   	ret    
80100e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e40 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e44:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
{
80100e49:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e4c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e51:	e8 5a 36 00 00       	call   801044b0 <acquire>
80100e56:	83 c4 10             	add    $0x10,%esp
80100e59:	eb 10                	jmp    80100e6b <filealloc+0x2b>
80100e5b:	90                   	nop
80100e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e60:	83 c3 18             	add    $0x18,%ebx
80100e63:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100e69:	73 25                	jae    80100e90 <filealloc+0x50>
    if(f->ref == 0){
80100e6b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e6e:	85 c0                	test   %eax,%eax
80100e70:	75 ee                	jne    80100e60 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e72:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e75:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e7c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e81:	e8 ea 36 00 00       	call   80104570 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e86:	89 d8                	mov    %ebx,%eax
      return f;
80100e88:	83 c4 10             	add    $0x10,%esp
}
80100e8b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e8e:	c9                   	leave  
80100e8f:	c3                   	ret    
  release(&ftable.lock);
80100e90:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e93:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e95:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e9a:	e8 d1 36 00 00       	call   80104570 <release>
}
80100e9f:	89 d8                	mov    %ebx,%eax
  return 0;
80100ea1:	83 c4 10             	add    $0x10,%esp
}
80100ea4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ea7:	c9                   	leave  
80100ea8:	c3                   	ret    
80100ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100eb0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100eb0:	55                   	push   %ebp
80100eb1:	89 e5                	mov    %esp,%ebp
80100eb3:	53                   	push   %ebx
80100eb4:	83 ec 10             	sub    $0x10,%esp
80100eb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100eba:	68 c0 ff 10 80       	push   $0x8010ffc0
80100ebf:	e8 ec 35 00 00       	call   801044b0 <acquire>
  if(f->ref < 1)
80100ec4:	8b 43 04             	mov    0x4(%ebx),%eax
80100ec7:	83 c4 10             	add    $0x10,%esp
80100eca:	85 c0                	test   %eax,%eax
80100ecc:	7e 1a                	jle    80100ee8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100ece:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100ed1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100ed4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ed7:	68 c0 ff 10 80       	push   $0x8010ffc0
80100edc:	e8 8f 36 00 00       	call   80104570 <release>
  return f;
}
80100ee1:	89 d8                	mov    %ebx,%eax
80100ee3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ee6:	c9                   	leave  
80100ee7:	c3                   	ret    
    panic("filedup");
80100ee8:	83 ec 0c             	sub    $0xc,%esp
80100eeb:	68 14 71 10 80       	push   $0x80107114
80100ef0:	e8 5b f5 ff ff       	call   80100450 <panic>
80100ef5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f00 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f00:	55                   	push   %ebp
80100f01:	89 e5                	mov    %esp,%ebp
80100f03:	57                   	push   %edi
80100f04:	56                   	push   %esi
80100f05:	53                   	push   %ebx
80100f06:	83 ec 28             	sub    $0x28,%esp
80100f09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100f0c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100f11:	e8 9a 35 00 00       	call   801044b0 <acquire>
  if(f->ref < 1)
80100f16:	8b 43 04             	mov    0x4(%ebx),%eax
80100f19:	83 c4 10             	add    $0x10,%esp
80100f1c:	85 c0                	test   %eax,%eax
80100f1e:	0f 8e 9b 00 00 00    	jle    80100fbf <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100f24:	83 e8 01             	sub    $0x1,%eax
80100f27:	85 c0                	test   %eax,%eax
80100f29:	89 43 04             	mov    %eax,0x4(%ebx)
80100f2c:	74 1a                	je     80100f48 <fileclose+0x48>
    release(&ftable.lock);
80100f2e:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f38:	5b                   	pop    %ebx
80100f39:	5e                   	pop    %esi
80100f3a:	5f                   	pop    %edi
80100f3b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f3c:	e9 2f 36 00 00       	jmp    80104570 <release>
80100f41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100f48:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100f4c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100f4e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f51:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100f54:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f5a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f5d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100f60:	68 c0 ff 10 80       	push   $0x8010ffc0
  ff = *f;
80100f65:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f68:	e8 03 36 00 00       	call   80104570 <release>
  if(ff.type == FD_PIPE)
80100f6d:	83 c4 10             	add    $0x10,%esp
80100f70:	83 ff 01             	cmp    $0x1,%edi
80100f73:	74 13                	je     80100f88 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100f75:	83 ff 02             	cmp    $0x2,%edi
80100f78:	74 26                	je     80100fa0 <fileclose+0xa0>
}
80100f7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f7d:	5b                   	pop    %ebx
80100f7e:	5e                   	pop    %esi
80100f7f:	5f                   	pop    %edi
80100f80:	5d                   	pop    %ebp
80100f81:	c3                   	ret    
80100f82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100f88:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f8c:	83 ec 08             	sub    $0x8,%esp
80100f8f:	53                   	push   %ebx
80100f90:	56                   	push   %esi
80100f91:	e8 2a 25 00 00       	call   801034c0 <pipeclose>
80100f96:	83 c4 10             	add    $0x10,%esp
80100f99:	eb df                	jmp    80100f7a <fileclose+0x7a>
80100f9b:	90                   	nop
80100f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100fa0:	e8 6b 1d 00 00       	call   80102d10 <begin_op>
    iput(ff.ip);
80100fa5:	83 ec 0c             	sub    $0xc,%esp
80100fa8:	ff 75 e0             	pushl  -0x20(%ebp)
80100fab:	e8 30 09 00 00       	call   801018e0 <iput>
    end_op();
80100fb0:	83 c4 10             	add    $0x10,%esp
}
80100fb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb6:	5b                   	pop    %ebx
80100fb7:	5e                   	pop    %esi
80100fb8:	5f                   	pop    %edi
80100fb9:	5d                   	pop    %ebp
    end_op();
80100fba:	e9 c1 1d 00 00       	jmp    80102d80 <end_op>
    panic("fileclose");
80100fbf:	83 ec 0c             	sub    $0xc,%esp
80100fc2:	68 1c 71 10 80       	push   $0x8010711c
80100fc7:	e8 84 f4 ff ff       	call   80100450 <panic>
80100fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fd0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100fd0:	55                   	push   %ebp
80100fd1:	89 e5                	mov    %esp,%ebp
80100fd3:	53                   	push   %ebx
80100fd4:	83 ec 04             	sub    $0x4,%esp
80100fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100fda:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fdd:	75 31                	jne    80101010 <filestat+0x40>
    ilock(f->ip);
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	ff 73 10             	pushl  0x10(%ebx)
80100fe5:	e8 c6 07 00 00       	call   801017b0 <ilock>
    stati(f->ip, st);
80100fea:	58                   	pop    %eax
80100feb:	5a                   	pop    %edx
80100fec:	ff 75 0c             	pushl  0xc(%ebp)
80100fef:	ff 73 10             	pushl  0x10(%ebx)
80100ff2:	e8 69 0a 00 00       	call   80101a60 <stati>
    iunlock(f->ip);
80100ff7:	59                   	pop    %ecx
80100ff8:	ff 73 10             	pushl  0x10(%ebx)
80100ffb:	e8 90 08 00 00       	call   80101890 <iunlock>
    return 0;
80101000:	83 c4 10             	add    $0x10,%esp
80101003:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80101005:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101008:	c9                   	leave  
80101009:	c3                   	ret    
8010100a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80101010:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101015:	eb ee                	jmp    80101005 <filestat+0x35>
80101017:	89 f6                	mov    %esi,%esi
80101019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101020 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101020:	55                   	push   %ebp
80101021:	89 e5                	mov    %esp,%ebp
80101023:	57                   	push   %edi
80101024:	56                   	push   %esi
80101025:	53                   	push   %ebx
80101026:	83 ec 0c             	sub    $0xc,%esp
80101029:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010102c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010102f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101032:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101036:	74 60                	je     80101098 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101038:	8b 03                	mov    (%ebx),%eax
8010103a:	83 f8 01             	cmp    $0x1,%eax
8010103d:	74 41                	je     80101080 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010103f:	83 f8 02             	cmp    $0x2,%eax
80101042:	75 5b                	jne    8010109f <fileread+0x7f>
    ilock(f->ip);
80101044:	83 ec 0c             	sub    $0xc,%esp
80101047:	ff 73 10             	pushl  0x10(%ebx)
8010104a:	e8 61 07 00 00       	call   801017b0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010104f:	57                   	push   %edi
80101050:	ff 73 14             	pushl  0x14(%ebx)
80101053:	56                   	push   %esi
80101054:	ff 73 10             	pushl  0x10(%ebx)
80101057:	e8 34 0a 00 00       	call   80101a90 <readi>
8010105c:	83 c4 20             	add    $0x20,%esp
8010105f:	85 c0                	test   %eax,%eax
80101061:	89 c6                	mov    %eax,%esi
80101063:	7e 03                	jle    80101068 <fileread+0x48>
      f->off += r;
80101065:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101068:	83 ec 0c             	sub    $0xc,%esp
8010106b:	ff 73 10             	pushl  0x10(%ebx)
8010106e:	e8 1d 08 00 00       	call   80101890 <iunlock>
    return r;
80101073:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101076:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101079:	89 f0                	mov    %esi,%eax
8010107b:	5b                   	pop    %ebx
8010107c:	5e                   	pop    %esi
8010107d:	5f                   	pop    %edi
8010107e:	5d                   	pop    %ebp
8010107f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101080:	8b 43 0c             	mov    0xc(%ebx),%eax
80101083:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101086:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101089:	5b                   	pop    %ebx
8010108a:	5e                   	pop    %esi
8010108b:	5f                   	pop    %edi
8010108c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010108d:	e9 de 25 00 00       	jmp    80103670 <piperead>
80101092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101098:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010109d:	eb d7                	jmp    80101076 <fileread+0x56>
  panic("fileread");
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	68 26 71 10 80       	push   $0x80107126
801010a7:	e8 a4 f3 ff ff       	call   80100450 <panic>
801010ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801010b0 <filesteal>:

// Steal a char from file f.
int
filesteal(struct file *f)
{
801010b0:	55                   	push   %ebp
801010b1:	89 e5                	mov    %esp,%ebp
801010b3:	56                   	push   %esi
801010b4:	53                   	push   %ebx
801010b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char r;

  if(f->readable == 0)
801010b8:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801010bc:	74 4a                	je     80101108 <filesteal+0x58>
    return '\0';
  if(f->type == FD_INODE){
801010be:	83 3b 02             	cmpl   $0x2,(%ebx)
801010c1:	75 4e                	jne    80101111 <filesteal+0x61>
    ilock(f->ip);
801010c3:	83 ec 0c             	sub    $0xc,%esp
801010c6:	ff 73 10             	pushl  0x10(%ebx)
801010c9:	e8 e2 06 00 00       	call   801017b0 <ilock>
    if((r = steali(f->ip) != '\0'))
801010ce:	58                   	pop    %eax
801010cf:	ff 73 10             	pushl  0x10(%ebx)
801010d2:	e8 b9 0a 00 00       	call   80101b90 <steali>
801010d7:	83 c4 10             	add    $0x10,%esp
801010da:	85 c0                	test   %eax,%eax
801010dc:	0f 95 c2             	setne  %dl
801010df:	89 d6                	mov    %edx,%esi
801010e1:	74 04                	je     801010e7 <filesteal+0x37>
      f->off += r;
801010e3:	83 43 14 01          	addl   $0x1,0x14(%ebx)
    iunlock(f->ip);
801010e7:	83 ec 0c             	sub    $0xc,%esp
801010ea:	ff 73 10             	pushl  0x10(%ebx)
801010ed:	e8 9e 07 00 00       	call   80101890 <iunlock>
    return r;
801010f2:	83 c4 10             	add    $0x10,%esp
  }
  panic("filesteal");
}
801010f5:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return r;
801010f8:	89 f0                	mov    %esi,%eax
801010fa:	0f b6 c0             	movzbl %al,%eax
}
801010fd:	5b                   	pop    %ebx
801010fe:	5e                   	pop    %esi
801010ff:	5d                   	pop    %ebp
80101100:	c3                   	ret    
80101101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101108:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return '\0';
8010110b:	31 c0                	xor    %eax,%eax
}
8010110d:	5b                   	pop    %ebx
8010110e:	5e                   	pop    %esi
8010110f:	5d                   	pop    %ebp
80101110:	c3                   	ret    
  panic("filesteal");
80101111:	83 ec 0c             	sub    $0xc,%esp
80101114:	68 2f 71 10 80       	push   $0x8010712f
80101119:	e8 32 f3 ff ff       	call   80100450 <panic>
8010111e:	66 90                	xchg   %ax,%ax

80101120 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101120:	55                   	push   %ebp
80101121:	89 e5                	mov    %esp,%ebp
80101123:	57                   	push   %edi
80101124:	56                   	push   %esi
80101125:	53                   	push   %ebx
80101126:	83 ec 1c             	sub    $0x1c,%esp
80101129:	8b 75 08             	mov    0x8(%ebp),%esi
8010112c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010112f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101133:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101136:	8b 45 10             	mov    0x10(%ebp),%eax
80101139:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010113c:	0f 84 aa 00 00 00    	je     801011ec <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101142:	8b 06                	mov    (%esi),%eax
80101144:	83 f8 01             	cmp    $0x1,%eax
80101147:	0f 84 c3 00 00 00    	je     80101210 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010114d:	83 f8 02             	cmp    $0x2,%eax
80101150:	0f 85 d9 00 00 00    	jne    8010122f <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101156:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101159:	31 ff                	xor    %edi,%edi
    while(i < n){
8010115b:	85 c0                	test   %eax,%eax
8010115d:	7f 34                	jg     80101193 <filewrite+0x73>
8010115f:	e9 9c 00 00 00       	jmp    80101200 <filewrite+0xe0>
80101164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101168:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010116b:	83 ec 0c             	sub    $0xc,%esp
8010116e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101171:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101174:	e8 17 07 00 00       	call   80101890 <iunlock>
      end_op();
80101179:	e8 02 1c 00 00       	call   80102d80 <end_op>
8010117e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101181:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101184:	39 c3                	cmp    %eax,%ebx
80101186:	0f 85 96 00 00 00    	jne    80101222 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010118c:	01 df                	add    %ebx,%edi
    while(i < n){
8010118e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101191:	7e 6d                	jle    80101200 <filewrite+0xe0>
      int n1 = n - i;
80101193:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101196:	b8 00 06 00 00       	mov    $0x600,%eax
8010119b:	29 fb                	sub    %edi,%ebx
8010119d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801011a3:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801011a6:	e8 65 1b 00 00       	call   80102d10 <begin_op>
      ilock(f->ip);
801011ab:	83 ec 0c             	sub    $0xc,%esp
801011ae:	ff 76 10             	pushl  0x10(%esi)
801011b1:	e8 fa 05 00 00       	call   801017b0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801011b6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011b9:	53                   	push   %ebx
801011ba:	ff 76 14             	pushl  0x14(%esi)
801011bd:	01 f8                	add    %edi,%eax
801011bf:	50                   	push   %eax
801011c0:	ff 76 10             	pushl  0x10(%esi)
801011c3:	e8 08 0a 00 00       	call   80101bd0 <writei>
801011c8:	83 c4 20             	add    $0x20,%esp
801011cb:	85 c0                	test   %eax,%eax
801011cd:	7f 99                	jg     80101168 <filewrite+0x48>
      iunlock(f->ip);
801011cf:	83 ec 0c             	sub    $0xc,%esp
801011d2:	ff 76 10             	pushl  0x10(%esi)
801011d5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011d8:	e8 b3 06 00 00       	call   80101890 <iunlock>
      end_op();
801011dd:	e8 9e 1b 00 00       	call   80102d80 <end_op>
      if(r < 0)
801011e2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801011e5:	83 c4 10             	add    $0x10,%esp
801011e8:	85 c0                	test   %eax,%eax
801011ea:	74 98                	je     80101184 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801011ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801011ef:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801011f4:	89 f8                	mov    %edi,%eax
801011f6:	5b                   	pop    %ebx
801011f7:	5e                   	pop    %esi
801011f8:	5f                   	pop    %edi
801011f9:	5d                   	pop    %ebp
801011fa:	c3                   	ret    
801011fb:	90                   	nop
801011fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
80101200:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101203:	75 e7                	jne    801011ec <filewrite+0xcc>
}
80101205:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101208:	89 f8                	mov    %edi,%eax
8010120a:	5b                   	pop    %ebx
8010120b:	5e                   	pop    %esi
8010120c:	5f                   	pop    %edi
8010120d:	5d                   	pop    %ebp
8010120e:	c3                   	ret    
8010120f:	90                   	nop
    return pipewrite(f->pipe, addr, n);
80101210:	8b 46 0c             	mov    0xc(%esi),%eax
80101213:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101216:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101219:	5b                   	pop    %ebx
8010121a:	5e                   	pop    %esi
8010121b:	5f                   	pop    %edi
8010121c:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
8010121d:	e9 3e 23 00 00       	jmp    80103560 <pipewrite>
        panic("short filewrite");
80101222:	83 ec 0c             	sub    $0xc,%esp
80101225:	68 39 71 10 80       	push   $0x80107139
8010122a:	e8 21 f2 ff ff       	call   80100450 <panic>
  panic("filewrite");
8010122f:	83 ec 0c             	sub    $0xc,%esp
80101232:	68 3f 71 10 80       	push   $0x8010713f
80101237:	e8 14 f2 ff ff       	call   80100450 <panic>
8010123c:	66 90                	xchg   %ax,%ax
8010123e:	66 90                	xchg   %ax,%ax

80101240 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101240:	55                   	push   %ebp
80101241:	89 e5                	mov    %esp,%ebp
80101243:	56                   	push   %esi
80101244:	53                   	push   %ebx
80101245:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101247:	c1 ea 0c             	shr    $0xc,%edx
8010124a:	03 15 f8 09 11 80    	add    0x801109f8,%edx
80101250:	83 ec 08             	sub    $0x8,%esp
80101253:	52                   	push   %edx
80101254:	50                   	push   %eax
80101255:	e8 76 ee ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010125a:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010125c:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
8010125f:	ba 01 00 00 00       	mov    $0x1,%edx
80101264:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101267:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010126d:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101270:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101272:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101277:	85 d1                	test   %edx,%ecx
80101279:	74 25                	je     801012a0 <bfree+0x60>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010127b:	f7 d2                	not    %edx
8010127d:	89 c6                	mov    %eax,%esi
  log_write(bp);
8010127f:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101282:	21 ca                	and    %ecx,%edx
80101284:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101288:	56                   	push   %esi
80101289:	e8 52 1c 00 00       	call   80102ee0 <log_write>
  brelse(bp);
8010128e:	89 34 24             	mov    %esi,(%esp)
80101291:	e8 4a ef ff ff       	call   801001e0 <brelse>
}
80101296:	83 c4 10             	add    $0x10,%esp
80101299:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010129c:	5b                   	pop    %ebx
8010129d:	5e                   	pop    %esi
8010129e:	5d                   	pop    %ebp
8010129f:	c3                   	ret    
    panic("freeing free block");
801012a0:	83 ec 0c             	sub    $0xc,%esp
801012a3:	68 49 71 10 80       	push   $0x80107149
801012a8:	e8 a3 f1 ff ff       	call   80100450 <panic>
801012ad:	8d 76 00             	lea    0x0(%esi),%esi

801012b0 <balloc>:
{
801012b0:	55                   	push   %ebp
801012b1:	89 e5                	mov    %esp,%ebp
801012b3:	57                   	push   %edi
801012b4:	56                   	push   %esi
801012b5:	53                   	push   %ebx
801012b6:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
801012b9:	8b 0d e0 09 11 80    	mov    0x801109e0,%ecx
{
801012bf:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801012c2:	85 c9                	test   %ecx,%ecx
801012c4:	0f 84 87 00 00 00    	je     80101351 <balloc+0xa1>
801012ca:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801012d1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801012d4:	83 ec 08             	sub    $0x8,%esp
801012d7:	89 f0                	mov    %esi,%eax
801012d9:	c1 f8 0c             	sar    $0xc,%eax
801012dc:	03 05 f8 09 11 80    	add    0x801109f8,%eax
801012e2:	50                   	push   %eax
801012e3:	ff 75 d8             	pushl  -0x28(%ebp)
801012e6:	e8 e5 ed ff ff       	call   801000d0 <bread>
801012eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012ee:	a1 e0 09 11 80       	mov    0x801109e0,%eax
801012f3:	83 c4 10             	add    $0x10,%esp
801012f6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801012f9:	31 c0                	xor    %eax,%eax
801012fb:	eb 2f                	jmp    8010132c <balloc+0x7c>
801012fd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101300:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101302:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101305:	bb 01 00 00 00       	mov    $0x1,%ebx
8010130a:	83 e1 07             	and    $0x7,%ecx
8010130d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010130f:	89 c1                	mov    %eax,%ecx
80101311:	c1 f9 03             	sar    $0x3,%ecx
80101314:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101319:	85 df                	test   %ebx,%edi
8010131b:	89 fa                	mov    %edi,%edx
8010131d:	74 41                	je     80101360 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010131f:	83 c0 01             	add    $0x1,%eax
80101322:	83 c6 01             	add    $0x1,%esi
80101325:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010132a:	74 05                	je     80101331 <balloc+0x81>
8010132c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010132f:	77 cf                	ja     80101300 <balloc+0x50>
    brelse(bp);
80101331:	83 ec 0c             	sub    $0xc,%esp
80101334:	ff 75 e4             	pushl  -0x1c(%ebp)
80101337:	e8 a4 ee ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010133c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101343:	83 c4 10             	add    $0x10,%esp
80101346:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101349:	39 05 e0 09 11 80    	cmp    %eax,0x801109e0
8010134f:	77 80                	ja     801012d1 <balloc+0x21>
  panic("balloc: out of blocks");
80101351:	83 ec 0c             	sub    $0xc,%esp
80101354:	68 5c 71 10 80       	push   $0x8010715c
80101359:	e8 f2 f0 ff ff       	call   80100450 <panic>
8010135e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101360:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101363:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101366:	09 da                	or     %ebx,%edx
80101368:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010136c:	57                   	push   %edi
8010136d:	e8 6e 1b 00 00       	call   80102ee0 <log_write>
        brelse(bp);
80101372:	89 3c 24             	mov    %edi,(%esp)
80101375:	e8 66 ee ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
8010137a:	58                   	pop    %eax
8010137b:	5a                   	pop    %edx
8010137c:	56                   	push   %esi
8010137d:	ff 75 d8             	pushl  -0x28(%ebp)
80101380:	e8 4b ed ff ff       	call   801000d0 <bread>
80101385:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101387:	8d 40 5c             	lea    0x5c(%eax),%eax
8010138a:	83 c4 0c             	add    $0xc,%esp
8010138d:	68 00 02 00 00       	push   $0x200
80101392:	6a 00                	push   $0x0
80101394:	50                   	push   %eax
80101395:	e8 26 32 00 00       	call   801045c0 <memset>
  log_write(bp);
8010139a:	89 1c 24             	mov    %ebx,(%esp)
8010139d:	e8 3e 1b 00 00       	call   80102ee0 <log_write>
  brelse(bp);
801013a2:	89 1c 24             	mov    %ebx,(%esp)
801013a5:	e8 36 ee ff ff       	call   801001e0 <brelse>
}
801013aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013ad:	89 f0                	mov    %esi,%eax
801013af:	5b                   	pop    %ebx
801013b0:	5e                   	pop    %esi
801013b1:	5f                   	pop    %edi
801013b2:	5d                   	pop    %ebp
801013b3:	c3                   	ret    
801013b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801013ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801013c0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801013c0:	55                   	push   %ebp
801013c1:	89 e5                	mov    %esp,%ebp
801013c3:	57                   	push   %edi
801013c4:	56                   	push   %esi
801013c5:	53                   	push   %ebx
801013c6:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801013c8:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013ca:	bb 34 0a 11 80       	mov    $0x80110a34,%ebx
{
801013cf:	83 ec 28             	sub    $0x28,%esp
801013d2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801013d5:	68 00 0a 11 80       	push   $0x80110a00
801013da:	e8 d1 30 00 00       	call   801044b0 <acquire>
801013df:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013e2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801013e5:	eb 17                	jmp    801013fe <iget+0x3e>
801013e7:	89 f6                	mov    %esi,%esi
801013e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801013f0:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013f6:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
801013fc:	73 22                	jae    80101420 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013fe:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101401:	85 c9                	test   %ecx,%ecx
80101403:	7e 04                	jle    80101409 <iget+0x49>
80101405:	39 3b                	cmp    %edi,(%ebx)
80101407:	74 4f                	je     80101458 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101409:	85 f6                	test   %esi,%esi
8010140b:	75 e3                	jne    801013f0 <iget+0x30>
8010140d:	85 c9                	test   %ecx,%ecx
8010140f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101412:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101418:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
8010141e:	72 de                	jb     801013fe <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101420:	85 f6                	test   %esi,%esi
80101422:	74 5b                	je     8010147f <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101424:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101427:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101429:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010142c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101433:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010143a:	68 00 0a 11 80       	push   $0x80110a00
8010143f:	e8 2c 31 00 00       	call   80104570 <release>

  return ip;
80101444:	83 c4 10             	add    $0x10,%esp
}
80101447:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010144a:	89 f0                	mov    %esi,%eax
8010144c:	5b                   	pop    %ebx
8010144d:	5e                   	pop    %esi
8010144e:	5f                   	pop    %edi
8010144f:	5d                   	pop    %ebp
80101450:	c3                   	ret    
80101451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101458:	39 53 04             	cmp    %edx,0x4(%ebx)
8010145b:	75 ac                	jne    80101409 <iget+0x49>
      release(&icache.lock);
8010145d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101460:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101463:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101465:	68 00 0a 11 80       	push   $0x80110a00
      ip->ref++;
8010146a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010146d:	e8 fe 30 00 00       	call   80104570 <release>
      return ip;
80101472:	83 c4 10             	add    $0x10,%esp
}
80101475:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101478:	89 f0                	mov    %esi,%eax
8010147a:	5b                   	pop    %ebx
8010147b:	5e                   	pop    %esi
8010147c:	5f                   	pop    %edi
8010147d:	5d                   	pop    %ebp
8010147e:	c3                   	ret    
    panic("iget: no inodes");
8010147f:	83 ec 0c             	sub    $0xc,%esp
80101482:	68 72 71 10 80       	push   $0x80107172
80101487:	e8 c4 ef ff ff       	call   80100450 <panic>
8010148c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101490 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101490:	55                   	push   %ebp
80101491:	89 e5                	mov    %esp,%ebp
80101493:	57                   	push   %edi
80101494:	56                   	push   %esi
80101495:	53                   	push   %ebx
80101496:	89 c6                	mov    %eax,%esi
80101498:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010149b:	83 fa 0b             	cmp    $0xb,%edx
8010149e:	77 18                	ja     801014b8 <bmap+0x28>
801014a0:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
801014a3:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801014a6:	85 db                	test   %ebx,%ebx
801014a8:	74 76                	je     80101520 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801014aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014ad:	89 d8                	mov    %ebx,%eax
801014af:	5b                   	pop    %ebx
801014b0:	5e                   	pop    %esi
801014b1:	5f                   	pop    %edi
801014b2:	5d                   	pop    %ebp
801014b3:	c3                   	ret    
801014b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
801014b8:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
801014bb:	83 fb 7f             	cmp    $0x7f,%ebx
801014be:	0f 87 90 00 00 00    	ja     80101554 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
801014c4:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
801014ca:	8b 00                	mov    (%eax),%eax
801014cc:	85 d2                	test   %edx,%edx
801014ce:	74 70                	je     80101540 <bmap+0xb0>
    bp = bread(ip->dev, addr);
801014d0:	83 ec 08             	sub    $0x8,%esp
801014d3:	52                   	push   %edx
801014d4:	50                   	push   %eax
801014d5:	e8 f6 eb ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
801014da:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801014de:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
801014e1:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801014e3:	8b 1a                	mov    (%edx),%ebx
801014e5:	85 db                	test   %ebx,%ebx
801014e7:	75 1d                	jne    80101506 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
801014e9:	8b 06                	mov    (%esi),%eax
801014eb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801014ee:	e8 bd fd ff ff       	call   801012b0 <balloc>
801014f3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801014f6:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801014f9:	89 c3                	mov    %eax,%ebx
801014fb:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801014fd:	57                   	push   %edi
801014fe:	e8 dd 19 00 00       	call   80102ee0 <log_write>
80101503:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101506:	83 ec 0c             	sub    $0xc,%esp
80101509:	57                   	push   %edi
8010150a:	e8 d1 ec ff ff       	call   801001e0 <brelse>
8010150f:	83 c4 10             	add    $0x10,%esp
}
80101512:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101515:	89 d8                	mov    %ebx,%eax
80101517:	5b                   	pop    %ebx
80101518:	5e                   	pop    %esi
80101519:	5f                   	pop    %edi
8010151a:	5d                   	pop    %ebp
8010151b:	c3                   	ret    
8010151c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101520:	8b 00                	mov    (%eax),%eax
80101522:	e8 89 fd ff ff       	call   801012b0 <balloc>
80101527:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010152a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010152d:	89 c3                	mov    %eax,%ebx
}
8010152f:	89 d8                	mov    %ebx,%eax
80101531:	5b                   	pop    %ebx
80101532:	5e                   	pop    %esi
80101533:	5f                   	pop    %edi
80101534:	5d                   	pop    %ebp
80101535:	c3                   	ret    
80101536:	8d 76 00             	lea    0x0(%esi),%esi
80101539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101540:	e8 6b fd ff ff       	call   801012b0 <balloc>
80101545:	89 c2                	mov    %eax,%edx
80101547:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010154d:	8b 06                	mov    (%esi),%eax
8010154f:	e9 7c ff ff ff       	jmp    801014d0 <bmap+0x40>
  panic("bmap: out of range");
80101554:	83 ec 0c             	sub    $0xc,%esp
80101557:	68 82 71 10 80       	push   $0x80107182
8010155c:	e8 ef ee ff ff       	call   80100450 <panic>
80101561:	eb 0d                	jmp    80101570 <readsb>
80101563:	90                   	nop
80101564:	90                   	nop
80101565:	90                   	nop
80101566:	90                   	nop
80101567:	90                   	nop
80101568:	90                   	nop
80101569:	90                   	nop
8010156a:	90                   	nop
8010156b:	90                   	nop
8010156c:	90                   	nop
8010156d:	90                   	nop
8010156e:	90                   	nop
8010156f:	90                   	nop

80101570 <readsb>:
{
80101570:	55                   	push   %ebp
80101571:	89 e5                	mov    %esp,%ebp
80101573:	56                   	push   %esi
80101574:	53                   	push   %ebx
80101575:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101578:	83 ec 08             	sub    $0x8,%esp
8010157b:	6a 01                	push   $0x1
8010157d:	ff 75 08             	pushl  0x8(%ebp)
80101580:	e8 4b eb ff ff       	call   801000d0 <bread>
80101585:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101587:	8d 40 5c             	lea    0x5c(%eax),%eax
8010158a:	83 c4 0c             	add    $0xc,%esp
8010158d:	6a 1c                	push   $0x1c
8010158f:	50                   	push   %eax
80101590:	56                   	push   %esi
80101591:	e8 da 30 00 00       	call   80104670 <memmove>
  brelse(bp);
80101596:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101599:	83 c4 10             	add    $0x10,%esp
}
8010159c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010159f:	5b                   	pop    %ebx
801015a0:	5e                   	pop    %esi
801015a1:	5d                   	pop    %ebp
  brelse(bp);
801015a2:	e9 39 ec ff ff       	jmp    801001e0 <brelse>
801015a7:	89 f6                	mov    %esi,%esi
801015a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801015b0 <iinit>:
{
801015b0:	55                   	push   %ebp
801015b1:	89 e5                	mov    %esp,%ebp
801015b3:	53                   	push   %ebx
801015b4:	bb 40 0a 11 80       	mov    $0x80110a40,%ebx
801015b9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801015bc:	68 95 71 10 80       	push   $0x80107195
801015c1:	68 00 0a 11 80       	push   $0x80110a00
801015c6:	e8 a5 2d 00 00       	call   80104370 <initlock>
801015cb:	83 c4 10             	add    $0x10,%esp
801015ce:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801015d0:	83 ec 08             	sub    $0x8,%esp
801015d3:	68 9c 71 10 80       	push   $0x8010719c
801015d8:	53                   	push   %ebx
801015d9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801015df:	e8 5c 2c 00 00       	call   80104240 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801015e4:	83 c4 10             	add    $0x10,%esp
801015e7:	81 fb 60 26 11 80    	cmp    $0x80112660,%ebx
801015ed:	75 e1                	jne    801015d0 <iinit+0x20>
  readsb(dev, &sb);
801015ef:	83 ec 08             	sub    $0x8,%esp
801015f2:	68 e0 09 11 80       	push   $0x801109e0
801015f7:	ff 75 08             	pushl  0x8(%ebp)
801015fa:	e8 71 ff ff ff       	call   80101570 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801015ff:	ff 35 f8 09 11 80    	pushl  0x801109f8
80101605:	ff 35 f4 09 11 80    	pushl  0x801109f4
8010160b:	ff 35 f0 09 11 80    	pushl  0x801109f0
80101611:	ff 35 ec 09 11 80    	pushl  0x801109ec
80101617:	ff 35 e8 09 11 80    	pushl  0x801109e8
8010161d:	ff 35 e4 09 11 80    	pushl  0x801109e4
80101623:	ff 35 e0 09 11 80    	pushl  0x801109e0
80101629:	68 00 72 10 80       	push   $0x80107200
8010162e:	e8 ed f0 ff ff       	call   80100720 <cprintf>
}
80101633:	83 c4 30             	add    $0x30,%esp
80101636:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101639:	c9                   	leave  
8010163a:	c3                   	ret    
8010163b:	90                   	nop
8010163c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101640 <ialloc>:
{
80101640:	55                   	push   %ebp
80101641:	89 e5                	mov    %esp,%ebp
80101643:	57                   	push   %edi
80101644:	56                   	push   %esi
80101645:	53                   	push   %ebx
80101646:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101649:	83 3d e8 09 11 80 01 	cmpl   $0x1,0x801109e8
{
80101650:	8b 45 0c             	mov    0xc(%ebp),%eax
80101653:	8b 75 08             	mov    0x8(%ebp),%esi
80101656:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101659:	0f 86 91 00 00 00    	jbe    801016f0 <ialloc+0xb0>
8010165f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101664:	eb 21                	jmp    80101687 <ialloc+0x47>
80101666:	8d 76 00             	lea    0x0(%esi),%esi
80101669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101670:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101673:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101676:	57                   	push   %edi
80101677:	e8 64 eb ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010167c:	83 c4 10             	add    $0x10,%esp
8010167f:	39 1d e8 09 11 80    	cmp    %ebx,0x801109e8
80101685:	76 69                	jbe    801016f0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101687:	89 d8                	mov    %ebx,%eax
80101689:	83 ec 08             	sub    $0x8,%esp
8010168c:	c1 e8 03             	shr    $0x3,%eax
8010168f:	03 05 f4 09 11 80    	add    0x801109f4,%eax
80101695:	50                   	push   %eax
80101696:	56                   	push   %esi
80101697:	e8 34 ea ff ff       	call   801000d0 <bread>
8010169c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010169e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
801016a0:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
801016a3:	83 e0 07             	and    $0x7,%eax
801016a6:	c1 e0 06             	shl    $0x6,%eax
801016a9:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801016ad:	66 83 39 00          	cmpw   $0x0,(%ecx)
801016b1:	75 bd                	jne    80101670 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801016b3:	83 ec 04             	sub    $0x4,%esp
801016b6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801016b9:	6a 40                	push   $0x40
801016bb:	6a 00                	push   $0x0
801016bd:	51                   	push   %ecx
801016be:	e8 fd 2e 00 00       	call   801045c0 <memset>
      dip->type = type;
801016c3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801016c7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801016ca:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801016cd:	89 3c 24             	mov    %edi,(%esp)
801016d0:	e8 0b 18 00 00       	call   80102ee0 <log_write>
      brelse(bp);
801016d5:	89 3c 24             	mov    %edi,(%esp)
801016d8:	e8 03 eb ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801016dd:	83 c4 10             	add    $0x10,%esp
}
801016e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801016e3:	89 da                	mov    %ebx,%edx
801016e5:	89 f0                	mov    %esi,%eax
}
801016e7:	5b                   	pop    %ebx
801016e8:	5e                   	pop    %esi
801016e9:	5f                   	pop    %edi
801016ea:	5d                   	pop    %ebp
      return iget(dev, inum);
801016eb:	e9 d0 fc ff ff       	jmp    801013c0 <iget>
  panic("ialloc: no inodes");
801016f0:	83 ec 0c             	sub    $0xc,%esp
801016f3:	68 a2 71 10 80       	push   $0x801071a2
801016f8:	e8 53 ed ff ff       	call   80100450 <panic>
801016fd:	8d 76 00             	lea    0x0(%esi),%esi

80101700 <iupdate>:
{
80101700:	55                   	push   %ebp
80101701:	89 e5                	mov    %esp,%ebp
80101703:	56                   	push   %esi
80101704:	53                   	push   %ebx
80101705:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101708:	83 ec 08             	sub    $0x8,%esp
8010170b:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010170e:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101711:	c1 e8 03             	shr    $0x3,%eax
80101714:	03 05 f4 09 11 80    	add    0x801109f4,%eax
8010171a:	50                   	push   %eax
8010171b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010171e:	e8 ad e9 ff ff       	call   801000d0 <bread>
80101723:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101725:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101728:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010172c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010172f:	83 e0 07             	and    $0x7,%eax
80101732:	c1 e0 06             	shl    $0x6,%eax
80101735:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101739:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010173c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101740:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101743:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101747:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010174b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010174f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101753:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101757:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010175a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010175d:	6a 34                	push   $0x34
8010175f:	53                   	push   %ebx
80101760:	50                   	push   %eax
80101761:	e8 0a 2f 00 00       	call   80104670 <memmove>
  log_write(bp);
80101766:	89 34 24             	mov    %esi,(%esp)
80101769:	e8 72 17 00 00       	call   80102ee0 <log_write>
  brelse(bp);
8010176e:	89 75 08             	mov    %esi,0x8(%ebp)
80101771:	83 c4 10             	add    $0x10,%esp
}
80101774:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101777:	5b                   	pop    %ebx
80101778:	5e                   	pop    %esi
80101779:	5d                   	pop    %ebp
  brelse(bp);
8010177a:	e9 61 ea ff ff       	jmp    801001e0 <brelse>
8010177f:	90                   	nop

80101780 <idup>:
{
80101780:	55                   	push   %ebp
80101781:	89 e5                	mov    %esp,%ebp
80101783:	53                   	push   %ebx
80101784:	83 ec 10             	sub    $0x10,%esp
80101787:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010178a:	68 00 0a 11 80       	push   $0x80110a00
8010178f:	e8 1c 2d 00 00       	call   801044b0 <acquire>
  ip->ref++;
80101794:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101798:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010179f:	e8 cc 2d 00 00       	call   80104570 <release>
}
801017a4:	89 d8                	mov    %ebx,%eax
801017a6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801017a9:	c9                   	leave  
801017aa:	c3                   	ret    
801017ab:	90                   	nop
801017ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801017b0 <ilock>:
{
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
801017b3:	56                   	push   %esi
801017b4:	53                   	push   %ebx
801017b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801017b8:	85 db                	test   %ebx,%ebx
801017ba:	0f 84 b7 00 00 00    	je     80101877 <ilock+0xc7>
801017c0:	8b 53 08             	mov    0x8(%ebx),%edx
801017c3:	85 d2                	test   %edx,%edx
801017c5:	0f 8e ac 00 00 00    	jle    80101877 <ilock+0xc7>
  acquiresleep(&ip->lock);
801017cb:	8d 43 0c             	lea    0xc(%ebx),%eax
801017ce:	83 ec 0c             	sub    $0xc,%esp
801017d1:	50                   	push   %eax
801017d2:	e8 a9 2a 00 00       	call   80104280 <acquiresleep>
  if(ip->valid == 0){
801017d7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801017da:	83 c4 10             	add    $0x10,%esp
801017dd:	85 c0                	test   %eax,%eax
801017df:	74 0f                	je     801017f0 <ilock+0x40>
}
801017e1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017e4:	5b                   	pop    %ebx
801017e5:	5e                   	pop    %esi
801017e6:	5d                   	pop    %ebp
801017e7:	c3                   	ret    
801017e8:	90                   	nop
801017e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017f0:	8b 43 04             	mov    0x4(%ebx),%eax
801017f3:	83 ec 08             	sub    $0x8,%esp
801017f6:	c1 e8 03             	shr    $0x3,%eax
801017f9:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801017ff:	50                   	push   %eax
80101800:	ff 33                	pushl  (%ebx)
80101802:	e8 c9 e8 ff ff       	call   801000d0 <bread>
80101807:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101809:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010180c:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010180f:	83 e0 07             	and    $0x7,%eax
80101812:	c1 e0 06             	shl    $0x6,%eax
80101815:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101819:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010181c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010181f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101823:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101827:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010182b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010182f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101833:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101837:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010183b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010183e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101841:	6a 34                	push   $0x34
80101843:	50                   	push   %eax
80101844:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101847:	50                   	push   %eax
80101848:	e8 23 2e 00 00       	call   80104670 <memmove>
    brelse(bp);
8010184d:	89 34 24             	mov    %esi,(%esp)
80101850:	e8 8b e9 ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101855:	83 c4 10             	add    $0x10,%esp
80101858:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010185d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101864:	0f 85 77 ff ff ff    	jne    801017e1 <ilock+0x31>
      panic("ilock: no type");
8010186a:	83 ec 0c             	sub    $0xc,%esp
8010186d:	68 ba 71 10 80       	push   $0x801071ba
80101872:	e8 d9 eb ff ff       	call   80100450 <panic>
    panic("ilock");
80101877:	83 ec 0c             	sub    $0xc,%esp
8010187a:	68 b4 71 10 80       	push   $0x801071b4
8010187f:	e8 cc eb ff ff       	call   80100450 <panic>
80101884:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010188a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101890 <iunlock>:
{
80101890:	55                   	push   %ebp
80101891:	89 e5                	mov    %esp,%ebp
80101893:	56                   	push   %esi
80101894:	53                   	push   %ebx
80101895:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101898:	85 db                	test   %ebx,%ebx
8010189a:	74 28                	je     801018c4 <iunlock+0x34>
8010189c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010189f:	83 ec 0c             	sub    $0xc,%esp
801018a2:	56                   	push   %esi
801018a3:	e8 78 2a 00 00       	call   80104320 <holdingsleep>
801018a8:	83 c4 10             	add    $0x10,%esp
801018ab:	85 c0                	test   %eax,%eax
801018ad:	74 15                	je     801018c4 <iunlock+0x34>
801018af:	8b 43 08             	mov    0x8(%ebx),%eax
801018b2:	85 c0                	test   %eax,%eax
801018b4:	7e 0e                	jle    801018c4 <iunlock+0x34>
  releasesleep(&ip->lock);
801018b6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801018b9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018bc:	5b                   	pop    %ebx
801018bd:	5e                   	pop    %esi
801018be:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801018bf:	e9 1c 2a 00 00       	jmp    801042e0 <releasesleep>
    panic("iunlock");
801018c4:	83 ec 0c             	sub    $0xc,%esp
801018c7:	68 c9 71 10 80       	push   $0x801071c9
801018cc:	e8 7f eb ff ff       	call   80100450 <panic>
801018d1:	eb 0d                	jmp    801018e0 <iput>
801018d3:	90                   	nop
801018d4:	90                   	nop
801018d5:	90                   	nop
801018d6:	90                   	nop
801018d7:	90                   	nop
801018d8:	90                   	nop
801018d9:	90                   	nop
801018da:	90                   	nop
801018db:	90                   	nop
801018dc:	90                   	nop
801018dd:	90                   	nop
801018de:	90                   	nop
801018df:	90                   	nop

801018e0 <iput>:
{
801018e0:	55                   	push   %ebp
801018e1:	89 e5                	mov    %esp,%ebp
801018e3:	57                   	push   %edi
801018e4:	56                   	push   %esi
801018e5:	53                   	push   %ebx
801018e6:	83 ec 28             	sub    $0x28,%esp
801018e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801018ec:	8d 7b 0c             	lea    0xc(%ebx),%edi
801018ef:	57                   	push   %edi
801018f0:	e8 8b 29 00 00       	call   80104280 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801018f5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801018f8:	83 c4 10             	add    $0x10,%esp
801018fb:	85 d2                	test   %edx,%edx
801018fd:	74 07                	je     80101906 <iput+0x26>
801018ff:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101904:	74 32                	je     80101938 <iput+0x58>
  releasesleep(&ip->lock);
80101906:	83 ec 0c             	sub    $0xc,%esp
80101909:	57                   	push   %edi
8010190a:	e8 d1 29 00 00       	call   801042e0 <releasesleep>
  acquire(&icache.lock);
8010190f:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101916:	e8 95 2b 00 00       	call   801044b0 <acquire>
  ip->ref--;
8010191b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010191f:	83 c4 10             	add    $0x10,%esp
80101922:	c7 45 08 00 0a 11 80 	movl   $0x80110a00,0x8(%ebp)
}
80101929:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010192c:	5b                   	pop    %ebx
8010192d:	5e                   	pop    %esi
8010192e:	5f                   	pop    %edi
8010192f:	5d                   	pop    %ebp
  release(&icache.lock);
80101930:	e9 3b 2c 00 00       	jmp    80104570 <release>
80101935:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101938:	83 ec 0c             	sub    $0xc,%esp
8010193b:	68 00 0a 11 80       	push   $0x80110a00
80101940:	e8 6b 2b 00 00       	call   801044b0 <acquire>
    int r = ip->ref;
80101945:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101948:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010194f:	e8 1c 2c 00 00       	call   80104570 <release>
    if(r == 1){
80101954:	83 c4 10             	add    $0x10,%esp
80101957:	83 fe 01             	cmp    $0x1,%esi
8010195a:	75 aa                	jne    80101906 <iput+0x26>
8010195c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101962:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101965:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101968:	89 cf                	mov    %ecx,%edi
8010196a:	eb 0b                	jmp    80101977 <iput+0x97>
8010196c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101970:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101973:	39 fe                	cmp    %edi,%esi
80101975:	74 19                	je     80101990 <iput+0xb0>
    if(ip->addrs[i]){
80101977:	8b 16                	mov    (%esi),%edx
80101979:	85 d2                	test   %edx,%edx
8010197b:	74 f3                	je     80101970 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010197d:	8b 03                	mov    (%ebx),%eax
8010197f:	e8 bc f8 ff ff       	call   80101240 <bfree>
      ip->addrs[i] = 0;
80101984:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010198a:	eb e4                	jmp    80101970 <iput+0x90>
8010198c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101990:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101996:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101999:	85 c0                	test   %eax,%eax
8010199b:	75 33                	jne    801019d0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010199d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801019a0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801019a7:	53                   	push   %ebx
801019a8:	e8 53 fd ff ff       	call   80101700 <iupdate>
      ip->type = 0;
801019ad:	31 c0                	xor    %eax,%eax
801019af:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801019b3:	89 1c 24             	mov    %ebx,(%esp)
801019b6:	e8 45 fd ff ff       	call   80101700 <iupdate>
      ip->valid = 0;
801019bb:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801019c2:	83 c4 10             	add    $0x10,%esp
801019c5:	e9 3c ff ff ff       	jmp    80101906 <iput+0x26>
801019ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801019d0:	83 ec 08             	sub    $0x8,%esp
801019d3:	50                   	push   %eax
801019d4:	ff 33                	pushl  (%ebx)
801019d6:	e8 f5 e6 ff ff       	call   801000d0 <bread>
801019db:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801019e1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801019e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801019e7:	8d 70 5c             	lea    0x5c(%eax),%esi
801019ea:	83 c4 10             	add    $0x10,%esp
801019ed:	89 cf                	mov    %ecx,%edi
801019ef:	eb 0e                	jmp    801019ff <iput+0x11f>
801019f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019f8:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
801019fb:	39 fe                	cmp    %edi,%esi
801019fd:	74 0f                	je     80101a0e <iput+0x12e>
      if(a[j])
801019ff:	8b 16                	mov    (%esi),%edx
80101a01:	85 d2                	test   %edx,%edx
80101a03:	74 f3                	je     801019f8 <iput+0x118>
        bfree(ip->dev, a[j]);
80101a05:	8b 03                	mov    (%ebx),%eax
80101a07:	e8 34 f8 ff ff       	call   80101240 <bfree>
80101a0c:	eb ea                	jmp    801019f8 <iput+0x118>
    brelse(bp);
80101a0e:	83 ec 0c             	sub    $0xc,%esp
80101a11:	ff 75 e4             	pushl  -0x1c(%ebp)
80101a14:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a17:	e8 c4 e7 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101a1c:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101a22:	8b 03                	mov    (%ebx),%eax
80101a24:	e8 17 f8 ff ff       	call   80101240 <bfree>
    ip->addrs[NDIRECT] = 0;
80101a29:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101a30:	00 00 00 
80101a33:	83 c4 10             	add    $0x10,%esp
80101a36:	e9 62 ff ff ff       	jmp    8010199d <iput+0xbd>
80101a3b:	90                   	nop
80101a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a40 <iunlockput>:
{
80101a40:	55                   	push   %ebp
80101a41:	89 e5                	mov    %esp,%ebp
80101a43:	53                   	push   %ebx
80101a44:	83 ec 10             	sub    $0x10,%esp
80101a47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101a4a:	53                   	push   %ebx
80101a4b:	e8 40 fe ff ff       	call   80101890 <iunlock>
  iput(ip);
80101a50:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a53:	83 c4 10             	add    $0x10,%esp
}
80101a56:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a59:	c9                   	leave  
  iput(ip);
80101a5a:	e9 81 fe ff ff       	jmp    801018e0 <iput>
80101a5f:	90                   	nop

80101a60 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	8b 55 08             	mov    0x8(%ebp),%edx
80101a66:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a69:	8b 0a                	mov    (%edx),%ecx
80101a6b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a6e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a71:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101a74:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101a78:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101a7b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101a7f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101a83:	8b 52 58             	mov    0x58(%edx),%edx
80101a86:	89 50 10             	mov    %edx,0x10(%eax)
}
80101a89:	5d                   	pop    %ebp
80101a8a:	c3                   	ret    
80101a8b:	90                   	nop
80101a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a90 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a90:	55                   	push   %ebp
80101a91:	89 e5                	mov    %esp,%ebp
80101a93:	57                   	push   %edi
80101a94:	56                   	push   %esi
80101a95:	53                   	push   %ebx
80101a96:	83 ec 1c             	sub    $0x1c,%esp
80101a99:	8b 45 08             	mov    0x8(%ebp),%eax
80101a9c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a9f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101aa2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101aa7:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101aaa:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101aad:	8b 75 10             	mov    0x10(%ebp),%esi
80101ab0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101ab3:	0f 84 a7 00 00 00    	je     80101b60 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101ab9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101abc:	8b 40 58             	mov    0x58(%eax),%eax
80101abf:	39 c6                	cmp    %eax,%esi
80101ac1:	0f 87 bd 00 00 00    	ja     80101b84 <readi+0xf4>
80101ac7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101aca:	89 f9                	mov    %edi,%ecx
80101acc:	01 f1                	add    %esi,%ecx
80101ace:	0f 82 b0 00 00 00    	jb     80101b84 <readi+0xf4>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101ad4:	89 c2                	mov    %eax,%edx
80101ad6:	29 f2                	sub    %esi,%edx
80101ad8:	39 c8                	cmp    %ecx,%eax
80101ada:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101add:	31 ff                	xor    %edi,%edi
80101adf:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101ae1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ae4:	74 6c                	je     80101b52 <readi+0xc2>
80101ae6:	8d 76 00             	lea    0x0(%esi),%esi
80101ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101af0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101af3:	89 f2                	mov    %esi,%edx
80101af5:	c1 ea 09             	shr    $0x9,%edx
80101af8:	89 d8                	mov    %ebx,%eax
80101afa:	e8 91 f9 ff ff       	call   80101490 <bmap>
80101aff:	83 ec 08             	sub    $0x8,%esp
80101b02:	50                   	push   %eax
80101b03:	ff 33                	pushl  (%ebx)
80101b05:	e8 c6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b0a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b0d:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b0f:	89 f0                	mov    %esi,%eax
80101b11:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b16:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b1b:	83 c4 0c             	add    $0xc,%esp
80101b1e:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b20:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101b24:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101b27:	29 fb                	sub    %edi,%ebx
80101b29:	39 d9                	cmp    %ebx,%ecx
80101b2b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b2e:	53                   	push   %ebx
80101b2f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b30:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101b32:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b35:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101b37:	e8 34 2b 00 00       	call   80104670 <memmove>
    brelse(bp);
80101b3c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b3f:	89 14 24             	mov    %edx,(%esp)
80101b42:	e8 99 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b47:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b4a:	83 c4 10             	add    $0x10,%esp
80101b4d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b50:	77 9e                	ja     80101af0 <readi+0x60>
  }
  return n;
80101b52:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b58:	5b                   	pop    %ebx
80101b59:	5e                   	pop    %esi
80101b5a:	5f                   	pop    %edi
80101b5b:	5d                   	pop    %ebp
80101b5c:	c3                   	ret    
80101b5d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b60:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b64:	66 83 f8 09          	cmp    $0x9,%ax
80101b68:	77 1a                	ja     80101b84 <readi+0xf4>
80101b6a:	8d 04 40             	lea    (%eax,%eax,2),%eax
80101b6d:	8b 04 85 60 09 11 80 	mov    -0x7feef6a0(,%eax,4),%eax
80101b74:	85 c0                	test   %eax,%eax
80101b76:	74 0c                	je     80101b84 <readi+0xf4>
    return devsw[ip->major].read(ip, dst, n);
80101b78:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b7b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b7e:	5b                   	pop    %ebx
80101b7f:	5e                   	pop    %esi
80101b80:	5f                   	pop    %edi
80101b81:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101b82:	ff e0                	jmp    *%eax
      return -1;
80101b84:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b89:	eb ca                	jmp    80101b55 <readi+0xc5>
80101b8b:	90                   	nop
80101b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101b90 <steali>:
// Read data from inode.
// Caller must hold ip->lock.
// like readi but just reads one character
int
steali(struct inode *ip)
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	8b 45 08             	mov    0x8(%ebp),%eax
  if(ip->type == T_DEV){
80101b96:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101b9b:	75 23                	jne    80101bc0 <steali+0x30>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].steal)
80101b9d:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ba1:	66 83 f8 09          	cmp    $0x9,%ax
80101ba5:	77 19                	ja     80101bc0 <steali+0x30>
80101ba7:	8d 04 40             	lea    (%eax,%eax,2),%eax
80101baa:	8b 04 85 64 09 11 80 	mov    -0x7feef69c(,%eax,4),%eax
80101bb1:	85 c0                	test   %eax,%eax
80101bb3:	74 0b                	je     80101bc0 <steali+0x30>
      return -1;
    return devsw[ip->major].steal(ip);
  }
  return -1;
}
80101bb5:	5d                   	pop    %ebp
    return devsw[ip->major].steal(ip);
80101bb6:	ff e0                	jmp    *%eax
80101bb8:	90                   	nop
80101bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80101bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101bc5:	5d                   	pop    %ebp
80101bc6:	c3                   	ret    
80101bc7:	89 f6                	mov    %esi,%esi
80101bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bd0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101bd0:	55                   	push   %ebp
80101bd1:	89 e5                	mov    %esp,%ebp
80101bd3:	57                   	push   %edi
80101bd4:	56                   	push   %esi
80101bd5:	53                   	push   %ebx
80101bd6:	83 ec 1c             	sub    $0x1c,%esp
80101bd9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bdc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101bdf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101be2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101be7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101bea:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101bed:	8b 75 10             	mov    0x10(%ebp),%esi
80101bf0:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101bf3:	0f 84 b7 00 00 00    	je     80101cb0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101bf9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bfc:	39 70 58             	cmp    %esi,0x58(%eax)
80101bff:	0f 82 eb 00 00 00    	jb     80101cf0 <writei+0x120>
80101c05:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101c08:	31 d2                	xor    %edx,%edx
80101c0a:	89 f8                	mov    %edi,%eax
80101c0c:	01 f0                	add    %esi,%eax
80101c0e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101c11:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101c16:	0f 87 d4 00 00 00    	ja     80101cf0 <writei+0x120>
80101c1c:	85 d2                	test   %edx,%edx
80101c1e:	0f 85 cc 00 00 00    	jne    80101cf0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c24:	85 ff                	test   %edi,%edi
80101c26:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101c2d:	74 72                	je     80101ca1 <writei+0xd1>
80101c2f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c30:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101c33:	89 f2                	mov    %esi,%edx
80101c35:	c1 ea 09             	shr    $0x9,%edx
80101c38:	89 f8                	mov    %edi,%eax
80101c3a:	e8 51 f8 ff ff       	call   80101490 <bmap>
80101c3f:	83 ec 08             	sub    $0x8,%esp
80101c42:	50                   	push   %eax
80101c43:	ff 37                	pushl  (%edi)
80101c45:	e8 86 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c4a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c4d:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c50:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c52:	89 f0                	mov    %esi,%eax
80101c54:	b9 00 02 00 00       	mov    $0x200,%ecx
80101c59:	83 c4 0c             	add    $0xc,%esp
80101c5c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c61:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101c63:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c67:	39 d9                	cmp    %ebx,%ecx
80101c69:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101c6c:	53                   	push   %ebx
80101c6d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c70:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101c72:	50                   	push   %eax
80101c73:	e8 f8 29 00 00       	call   80104670 <memmove>
    log_write(bp);
80101c78:	89 3c 24             	mov    %edi,(%esp)
80101c7b:	e8 60 12 00 00       	call   80102ee0 <log_write>
    brelse(bp);
80101c80:	89 3c 24             	mov    %edi,(%esp)
80101c83:	e8 58 e5 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c88:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c8b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c8e:	83 c4 10             	add    $0x10,%esp
80101c91:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c94:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101c97:	77 97                	ja     80101c30 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101c99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c9c:	3b 70 58             	cmp    0x58(%eax),%esi
80101c9f:	77 37                	ja     80101cd8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101ca1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101ca4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ca7:	5b                   	pop    %ebx
80101ca8:	5e                   	pop    %esi
80101ca9:	5f                   	pop    %edi
80101caa:	5d                   	pop    %ebp
80101cab:	c3                   	ret    
80101cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101cb0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101cb4:	66 83 f8 09          	cmp    $0x9,%ax
80101cb8:	77 36                	ja     80101cf0 <writei+0x120>
80101cba:	8d 04 40             	lea    (%eax,%eax,2),%eax
80101cbd:	8b 04 85 68 09 11 80 	mov    -0x7feef698(,%eax,4),%eax
80101cc4:	85 c0                	test   %eax,%eax
80101cc6:	74 28                	je     80101cf0 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101cc8:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101ccb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cce:	5b                   	pop    %ebx
80101ccf:	5e                   	pop    %esi
80101cd0:	5f                   	pop    %edi
80101cd1:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101cd2:	ff e0                	jmp    *%eax
80101cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101cd8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101cdb:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101cde:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101ce1:	50                   	push   %eax
80101ce2:	e8 19 fa ff ff       	call   80101700 <iupdate>
80101ce7:	83 c4 10             	add    $0x10,%esp
80101cea:	eb b5                	jmp    80101ca1 <writei+0xd1>
80101cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101cf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101cf5:	eb ad                	jmp    80101ca4 <writei+0xd4>
80101cf7:	89 f6                	mov    %esi,%esi
80101cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101d00 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101d00:	55                   	push   %ebp
80101d01:	89 e5                	mov    %esp,%ebp
80101d03:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101d06:	6a 0e                	push   $0xe
80101d08:	ff 75 0c             	pushl  0xc(%ebp)
80101d0b:	ff 75 08             	pushl  0x8(%ebp)
80101d0e:	e8 cd 29 00 00       	call   801046e0 <strncmp>
}
80101d13:	c9                   	leave  
80101d14:	c3                   	ret    
80101d15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101d20 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101d20:	55                   	push   %ebp
80101d21:	89 e5                	mov    %esp,%ebp
80101d23:	57                   	push   %edi
80101d24:	56                   	push   %esi
80101d25:	53                   	push   %ebx
80101d26:	83 ec 1c             	sub    $0x1c,%esp
80101d29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101d2c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101d31:	0f 85 85 00 00 00    	jne    80101dbc <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101d37:	8b 53 58             	mov    0x58(%ebx),%edx
80101d3a:	31 ff                	xor    %edi,%edi
80101d3c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101d3f:	85 d2                	test   %edx,%edx
80101d41:	74 3e                	je     80101d81 <dirlookup+0x61>
80101d43:	90                   	nop
80101d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d48:	6a 10                	push   $0x10
80101d4a:	57                   	push   %edi
80101d4b:	56                   	push   %esi
80101d4c:	53                   	push   %ebx
80101d4d:	e8 3e fd ff ff       	call   80101a90 <readi>
80101d52:	83 c4 10             	add    $0x10,%esp
80101d55:	83 f8 10             	cmp    $0x10,%eax
80101d58:	75 55                	jne    80101daf <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101d5a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d5f:	74 18                	je     80101d79 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101d61:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d64:	83 ec 04             	sub    $0x4,%esp
80101d67:	6a 0e                	push   $0xe
80101d69:	50                   	push   %eax
80101d6a:	ff 75 0c             	pushl  0xc(%ebp)
80101d6d:	e8 6e 29 00 00       	call   801046e0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101d72:	83 c4 10             	add    $0x10,%esp
80101d75:	85 c0                	test   %eax,%eax
80101d77:	74 17                	je     80101d90 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101d79:	83 c7 10             	add    $0x10,%edi
80101d7c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101d7f:	72 c7                	jb     80101d48 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101d81:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101d84:	31 c0                	xor    %eax,%eax
}
80101d86:	5b                   	pop    %ebx
80101d87:	5e                   	pop    %esi
80101d88:	5f                   	pop    %edi
80101d89:	5d                   	pop    %ebp
80101d8a:	c3                   	ret    
80101d8b:	90                   	nop
80101d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101d90:	8b 45 10             	mov    0x10(%ebp),%eax
80101d93:	85 c0                	test   %eax,%eax
80101d95:	74 05                	je     80101d9c <dirlookup+0x7c>
        *poff = off;
80101d97:	8b 45 10             	mov    0x10(%ebp),%eax
80101d9a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d9c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101da0:	8b 03                	mov    (%ebx),%eax
80101da2:	e8 19 f6 ff ff       	call   801013c0 <iget>
}
80101da7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101daa:	5b                   	pop    %ebx
80101dab:	5e                   	pop    %esi
80101dac:	5f                   	pop    %edi
80101dad:	5d                   	pop    %ebp
80101dae:	c3                   	ret    
      panic("dirlookup read");
80101daf:	83 ec 0c             	sub    $0xc,%esp
80101db2:	68 e3 71 10 80       	push   $0x801071e3
80101db7:	e8 94 e6 ff ff       	call   80100450 <panic>
    panic("dirlookup not DIR");
80101dbc:	83 ec 0c             	sub    $0xc,%esp
80101dbf:	68 d1 71 10 80       	push   $0x801071d1
80101dc4:	e8 87 e6 ff ff       	call   80100450 <panic>
80101dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101dd0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101dd0:	55                   	push   %ebp
80101dd1:	89 e5                	mov    %esp,%ebp
80101dd3:	57                   	push   %edi
80101dd4:	56                   	push   %esi
80101dd5:	53                   	push   %ebx
80101dd6:	89 cf                	mov    %ecx,%edi
80101dd8:	89 c3                	mov    %eax,%ebx
80101dda:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101ddd:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101de0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101de3:	0f 84 67 01 00 00    	je     80101f50 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101de9:	e8 62 1b 00 00       	call   80103950 <myproc>
  acquire(&icache.lock);
80101dee:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101df1:	8b 70 6c             	mov    0x6c(%eax),%esi
  acquire(&icache.lock);
80101df4:	68 00 0a 11 80       	push   $0x80110a00
80101df9:	e8 b2 26 00 00       	call   801044b0 <acquire>
  ip->ref++;
80101dfe:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101e02:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101e09:	e8 62 27 00 00       	call   80104570 <release>
80101e0e:	83 c4 10             	add    $0x10,%esp
80101e11:	eb 08                	jmp    80101e1b <namex+0x4b>
80101e13:	90                   	nop
80101e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101e18:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e1b:	0f b6 03             	movzbl (%ebx),%eax
80101e1e:	3c 2f                	cmp    $0x2f,%al
80101e20:	74 f6                	je     80101e18 <namex+0x48>
  if(*path == 0)
80101e22:	84 c0                	test   %al,%al
80101e24:	0f 84 ee 00 00 00    	je     80101f18 <namex+0x148>
  while(*path != '/' && *path != 0)
80101e2a:	0f b6 03             	movzbl (%ebx),%eax
80101e2d:	3c 2f                	cmp    $0x2f,%al
80101e2f:	0f 84 b3 00 00 00    	je     80101ee8 <namex+0x118>
80101e35:	84 c0                	test   %al,%al
80101e37:	89 da                	mov    %ebx,%edx
80101e39:	75 09                	jne    80101e44 <namex+0x74>
80101e3b:	e9 a8 00 00 00       	jmp    80101ee8 <namex+0x118>
80101e40:	84 c0                	test   %al,%al
80101e42:	74 0a                	je     80101e4e <namex+0x7e>
    path++;
80101e44:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101e47:	0f b6 02             	movzbl (%edx),%eax
80101e4a:	3c 2f                	cmp    $0x2f,%al
80101e4c:	75 f2                	jne    80101e40 <namex+0x70>
80101e4e:	89 d1                	mov    %edx,%ecx
80101e50:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101e52:	83 f9 0d             	cmp    $0xd,%ecx
80101e55:	0f 8e 91 00 00 00    	jle    80101eec <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101e5b:	83 ec 04             	sub    $0x4,%esp
80101e5e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101e61:	6a 0e                	push   $0xe
80101e63:	53                   	push   %ebx
80101e64:	57                   	push   %edi
80101e65:	e8 06 28 00 00       	call   80104670 <memmove>
    path++;
80101e6a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101e6d:	83 c4 10             	add    $0x10,%esp
    path++;
80101e70:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101e72:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101e75:	75 11                	jne    80101e88 <namex+0xb8>
80101e77:	89 f6                	mov    %esi,%esi
80101e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101e80:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e83:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e86:	74 f8                	je     80101e80 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101e88:	83 ec 0c             	sub    $0xc,%esp
80101e8b:	56                   	push   %esi
80101e8c:	e8 1f f9 ff ff       	call   801017b0 <ilock>
    if(ip->type != T_DIR){
80101e91:	83 c4 10             	add    $0x10,%esp
80101e94:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e99:	0f 85 91 00 00 00    	jne    80101f30 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e9f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101ea2:	85 d2                	test   %edx,%edx
80101ea4:	74 09                	je     80101eaf <namex+0xdf>
80101ea6:	80 3b 00             	cmpb   $0x0,(%ebx)
80101ea9:	0f 84 b7 00 00 00    	je     80101f66 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101eaf:	83 ec 04             	sub    $0x4,%esp
80101eb2:	6a 00                	push   $0x0
80101eb4:	57                   	push   %edi
80101eb5:	56                   	push   %esi
80101eb6:	e8 65 fe ff ff       	call   80101d20 <dirlookup>
80101ebb:	83 c4 10             	add    $0x10,%esp
80101ebe:	85 c0                	test   %eax,%eax
80101ec0:	74 6e                	je     80101f30 <namex+0x160>
  iunlock(ip);
80101ec2:	83 ec 0c             	sub    $0xc,%esp
80101ec5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101ec8:	56                   	push   %esi
80101ec9:	e8 c2 f9 ff ff       	call   80101890 <iunlock>
  iput(ip);
80101ece:	89 34 24             	mov    %esi,(%esp)
80101ed1:	e8 0a fa ff ff       	call   801018e0 <iput>
80101ed6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101ed9:	83 c4 10             	add    $0x10,%esp
80101edc:	89 c6                	mov    %eax,%esi
80101ede:	e9 38 ff ff ff       	jmp    80101e1b <namex+0x4b>
80101ee3:	90                   	nop
80101ee4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101ee8:	89 da                	mov    %ebx,%edx
80101eea:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101eec:	83 ec 04             	sub    $0x4,%esp
80101eef:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101ef2:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101ef5:	51                   	push   %ecx
80101ef6:	53                   	push   %ebx
80101ef7:	57                   	push   %edi
80101ef8:	e8 73 27 00 00       	call   80104670 <memmove>
    name[len] = 0;
80101efd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101f00:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101f03:	83 c4 10             	add    $0x10,%esp
80101f06:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101f0a:	89 d3                	mov    %edx,%ebx
80101f0c:	e9 61 ff ff ff       	jmp    80101e72 <namex+0xa2>
80101f11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101f18:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101f1b:	85 c0                	test   %eax,%eax
80101f1d:	75 5d                	jne    80101f7c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101f1f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f22:	89 f0                	mov    %esi,%eax
80101f24:	5b                   	pop    %ebx
80101f25:	5e                   	pop    %esi
80101f26:	5f                   	pop    %edi
80101f27:	5d                   	pop    %ebp
80101f28:	c3                   	ret    
80101f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101f30:	83 ec 0c             	sub    $0xc,%esp
80101f33:	56                   	push   %esi
80101f34:	e8 57 f9 ff ff       	call   80101890 <iunlock>
  iput(ip);
80101f39:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101f3c:	31 f6                	xor    %esi,%esi
  iput(ip);
80101f3e:	e8 9d f9 ff ff       	call   801018e0 <iput>
      return 0;
80101f43:	83 c4 10             	add    $0x10,%esp
}
80101f46:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f49:	89 f0                	mov    %esi,%eax
80101f4b:	5b                   	pop    %ebx
80101f4c:	5e                   	pop    %esi
80101f4d:	5f                   	pop    %edi
80101f4e:	5d                   	pop    %ebp
80101f4f:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101f50:	ba 01 00 00 00       	mov    $0x1,%edx
80101f55:	b8 01 00 00 00       	mov    $0x1,%eax
80101f5a:	e8 61 f4 ff ff       	call   801013c0 <iget>
80101f5f:	89 c6                	mov    %eax,%esi
80101f61:	e9 b5 fe ff ff       	jmp    80101e1b <namex+0x4b>
      iunlock(ip);
80101f66:	83 ec 0c             	sub    $0xc,%esp
80101f69:	56                   	push   %esi
80101f6a:	e8 21 f9 ff ff       	call   80101890 <iunlock>
      return ip;
80101f6f:	83 c4 10             	add    $0x10,%esp
}
80101f72:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f75:	89 f0                	mov    %esi,%eax
80101f77:	5b                   	pop    %ebx
80101f78:	5e                   	pop    %esi
80101f79:	5f                   	pop    %edi
80101f7a:	5d                   	pop    %ebp
80101f7b:	c3                   	ret    
    iput(ip);
80101f7c:	83 ec 0c             	sub    $0xc,%esp
80101f7f:	56                   	push   %esi
    return 0;
80101f80:	31 f6                	xor    %esi,%esi
    iput(ip);
80101f82:	e8 59 f9 ff ff       	call   801018e0 <iput>
    return 0;
80101f87:	83 c4 10             	add    $0x10,%esp
80101f8a:	eb 93                	jmp    80101f1f <namex+0x14f>
80101f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101f90 <dirlink>:
{
80101f90:	55                   	push   %ebp
80101f91:	89 e5                	mov    %esp,%ebp
80101f93:	57                   	push   %edi
80101f94:	56                   	push   %esi
80101f95:	53                   	push   %ebx
80101f96:	83 ec 20             	sub    $0x20,%esp
80101f99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101f9c:	6a 00                	push   $0x0
80101f9e:	ff 75 0c             	pushl  0xc(%ebp)
80101fa1:	53                   	push   %ebx
80101fa2:	e8 79 fd ff ff       	call   80101d20 <dirlookup>
80101fa7:	83 c4 10             	add    $0x10,%esp
80101faa:	85 c0                	test   %eax,%eax
80101fac:	75 67                	jne    80102015 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101fae:	8b 7b 58             	mov    0x58(%ebx),%edi
80101fb1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101fb4:	85 ff                	test   %edi,%edi
80101fb6:	74 29                	je     80101fe1 <dirlink+0x51>
80101fb8:	31 ff                	xor    %edi,%edi
80101fba:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101fbd:	eb 09                	jmp    80101fc8 <dirlink+0x38>
80101fbf:	90                   	nop
80101fc0:	83 c7 10             	add    $0x10,%edi
80101fc3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101fc6:	73 19                	jae    80101fe1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fc8:	6a 10                	push   $0x10
80101fca:	57                   	push   %edi
80101fcb:	56                   	push   %esi
80101fcc:	53                   	push   %ebx
80101fcd:	e8 be fa ff ff       	call   80101a90 <readi>
80101fd2:	83 c4 10             	add    $0x10,%esp
80101fd5:	83 f8 10             	cmp    $0x10,%eax
80101fd8:	75 4e                	jne    80102028 <dirlink+0x98>
    if(de.inum == 0)
80101fda:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101fdf:	75 df                	jne    80101fc0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101fe1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101fe4:	83 ec 04             	sub    $0x4,%esp
80101fe7:	6a 0e                	push   $0xe
80101fe9:	ff 75 0c             	pushl  0xc(%ebp)
80101fec:	50                   	push   %eax
80101fed:	e8 4e 27 00 00       	call   80104740 <strncpy>
  de.inum = inum;
80101ff2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ff5:	6a 10                	push   $0x10
80101ff7:	57                   	push   %edi
80101ff8:	56                   	push   %esi
80101ff9:	53                   	push   %ebx
  de.inum = inum;
80101ffa:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ffe:	e8 cd fb ff ff       	call   80101bd0 <writei>
80102003:	83 c4 20             	add    $0x20,%esp
80102006:	83 f8 10             	cmp    $0x10,%eax
80102009:	75 2a                	jne    80102035 <dirlink+0xa5>
  return 0;
8010200b:	31 c0                	xor    %eax,%eax
}
8010200d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102010:	5b                   	pop    %ebx
80102011:	5e                   	pop    %esi
80102012:	5f                   	pop    %edi
80102013:	5d                   	pop    %ebp
80102014:	c3                   	ret    
    iput(ip);
80102015:	83 ec 0c             	sub    $0xc,%esp
80102018:	50                   	push   %eax
80102019:	e8 c2 f8 ff ff       	call   801018e0 <iput>
    return -1;
8010201e:	83 c4 10             	add    $0x10,%esp
80102021:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102026:	eb e5                	jmp    8010200d <dirlink+0x7d>
      panic("dirlink read");
80102028:	83 ec 0c             	sub    $0xc,%esp
8010202b:	68 f2 71 10 80       	push   $0x801071f2
80102030:	e8 1b e4 ff ff       	call   80100450 <panic>
    panic("dirlink");
80102035:	83 ec 0c             	sub    $0xc,%esp
80102038:	68 e6 77 10 80       	push   $0x801077e6
8010203d:	e8 0e e4 ff ff       	call   80100450 <panic>
80102042:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102050 <namei>:

struct inode*
namei(char *path)
{
80102050:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102051:	31 d2                	xor    %edx,%edx
{
80102053:	89 e5                	mov    %esp,%ebp
80102055:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102058:	8b 45 08             	mov    0x8(%ebp),%eax
8010205b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010205e:	e8 6d fd ff ff       	call   80101dd0 <namex>
}
80102063:	c9                   	leave  
80102064:	c3                   	ret    
80102065:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102070 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102070:	55                   	push   %ebp
  return namex(path, 1, name);
80102071:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102076:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102078:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010207b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010207e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010207f:	e9 4c fd ff ff       	jmp    80101dd0 <namex>
80102084:	66 90                	xchg   %ax,%ax
80102086:	66 90                	xchg   %ax,%ax
80102088:	66 90                	xchg   %ax,%ax
8010208a:	66 90                	xchg   %ax,%ax
8010208c:	66 90                	xchg   %ax,%ax
8010208e:	66 90                	xchg   %ax,%ax

80102090 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102090:	55                   	push   %ebp
80102091:	89 e5                	mov    %esp,%ebp
80102093:	57                   	push   %edi
80102094:	56                   	push   %esi
80102095:	53                   	push   %ebx
80102096:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102099:	85 c0                	test   %eax,%eax
8010209b:	0f 84 b4 00 00 00    	je     80102155 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801020a1:	8b 58 08             	mov    0x8(%eax),%ebx
801020a4:	89 c6                	mov    %eax,%esi
801020a6:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
801020ac:	0f 87 96 00 00 00    	ja     80102148 <idestart+0xb8>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020b2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801020b7:	89 f6                	mov    %esi,%esi
801020b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020c0:	89 ca                	mov    %ecx,%edx
801020c2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020c3:	83 e0 c0             	and    $0xffffffc0,%eax
801020c6:	3c 40                	cmp    $0x40,%al
801020c8:	75 f6                	jne    801020c0 <idestart+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801020ca:	31 ff                	xor    %edi,%edi
801020cc:	ba f6 03 00 00       	mov    $0x3f6,%edx
801020d1:	89 f8                	mov    %edi,%eax
801020d3:	ee                   	out    %al,(%dx)
801020d4:	b8 01 00 00 00       	mov    $0x1,%eax
801020d9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801020de:	ee                   	out    %al,(%dx)
801020df:	ba f3 01 00 00       	mov    $0x1f3,%edx
801020e4:	89 d8                	mov    %ebx,%eax
801020e6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801020e7:	89 d8                	mov    %ebx,%eax
801020e9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801020ee:	c1 f8 08             	sar    $0x8,%eax
801020f1:	ee                   	out    %al,(%dx)
801020f2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801020f7:	89 f8                	mov    %edi,%eax
801020f9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801020fa:	0f b6 46 04          	movzbl 0x4(%esi),%eax
801020fe:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102103:	c1 e0 04             	shl    $0x4,%eax
80102106:	83 e0 10             	and    $0x10,%eax
80102109:	83 c8 e0             	or     $0xffffffe0,%eax
8010210c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010210d:	f6 06 04             	testb  $0x4,(%esi)
80102110:	75 16                	jne    80102128 <idestart+0x98>
80102112:	b8 20 00 00 00       	mov    $0x20,%eax
80102117:	89 ca                	mov    %ecx,%edx
80102119:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010211a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010211d:	5b                   	pop    %ebx
8010211e:	5e                   	pop    %esi
8010211f:	5f                   	pop    %edi
80102120:	5d                   	pop    %ebp
80102121:	c3                   	ret    
80102122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102128:	b8 30 00 00 00       	mov    $0x30,%eax
8010212d:	89 ca                	mov    %ecx,%edx
8010212f:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80102130:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102135:	83 c6 5c             	add    $0x5c,%esi
80102138:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010213d:	fc                   	cld    
8010213e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102140:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102143:	5b                   	pop    %ebx
80102144:	5e                   	pop    %esi
80102145:	5f                   	pop    %edi
80102146:	5d                   	pop    %ebp
80102147:	c3                   	ret    
    panic("incorrect blockno");
80102148:	83 ec 0c             	sub    $0xc,%esp
8010214b:	68 5c 72 10 80       	push   $0x8010725c
80102150:	e8 fb e2 ff ff       	call   80100450 <panic>
    panic("idestart");
80102155:	83 ec 0c             	sub    $0xc,%esp
80102158:	68 53 72 10 80       	push   $0x80107253
8010215d:	e8 ee e2 ff ff       	call   80100450 <panic>
80102162:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102170 <ideinit>:
{
80102170:	55                   	push   %ebp
80102171:	89 e5                	mov    %esp,%ebp
80102173:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102176:	68 6e 72 10 80       	push   $0x8010726e
8010217b:	68 80 a5 10 80       	push   $0x8010a580
80102180:	e8 eb 21 00 00       	call   80104370 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102185:	58                   	pop    %eax
80102186:	a1 20 2d 11 80       	mov    0x80112d20,%eax
8010218b:	5a                   	pop    %edx
8010218c:	83 e8 01             	sub    $0x1,%eax
8010218f:	50                   	push   %eax
80102190:	6a 0e                	push   $0xe
80102192:	e8 a9 02 00 00       	call   80102440 <ioapicenable>
80102197:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010219a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010219f:	90                   	nop
801021a0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021a1:	83 e0 c0             	and    $0xffffffc0,%eax
801021a4:	3c 40                	cmp    $0x40,%al
801021a6:	75 f8                	jne    801021a0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021a8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801021ad:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021b2:	ee                   	out    %al,(%dx)
801021b3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021b8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021bd:	eb 06                	jmp    801021c5 <ideinit+0x55>
801021bf:	90                   	nop
  for(i=0; i<1000; i++){
801021c0:	83 e9 01             	sub    $0x1,%ecx
801021c3:	74 0f                	je     801021d4 <ideinit+0x64>
801021c5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801021c6:	84 c0                	test   %al,%al
801021c8:	74 f6                	je     801021c0 <ideinit+0x50>
      havedisk1 = 1;
801021ca:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
801021d1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021d4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801021d9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021de:	ee                   	out    %al,(%dx)
}
801021df:	c9                   	leave  
801021e0:	c3                   	ret    
801021e1:	eb 0d                	jmp    801021f0 <ideintr>
801021e3:	90                   	nop
801021e4:	90                   	nop
801021e5:	90                   	nop
801021e6:	90                   	nop
801021e7:	90                   	nop
801021e8:	90                   	nop
801021e9:	90                   	nop
801021ea:	90                   	nop
801021eb:	90                   	nop
801021ec:	90                   	nop
801021ed:	90                   	nop
801021ee:	90                   	nop
801021ef:	90                   	nop

801021f0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801021f0:	55                   	push   %ebp
801021f1:	89 e5                	mov    %esp,%ebp
801021f3:	57                   	push   %edi
801021f4:	56                   	push   %esi
801021f5:	53                   	push   %ebx
801021f6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801021f9:	68 80 a5 10 80       	push   $0x8010a580
801021fe:	e8 ad 22 00 00       	call   801044b0 <acquire>

  if((b = idequeue) == 0){
80102203:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102209:	83 c4 10             	add    $0x10,%esp
8010220c:	85 db                	test   %ebx,%ebx
8010220e:	74 67                	je     80102277 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102210:	8b 43 58             	mov    0x58(%ebx),%eax
80102213:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102218:	8b 3b                	mov    (%ebx),%edi
8010221a:	f7 c7 04 00 00 00    	test   $0x4,%edi
80102220:	75 31                	jne    80102253 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102222:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102227:	89 f6                	mov    %esi,%esi
80102229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102230:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102231:	89 c6                	mov    %eax,%esi
80102233:	83 e6 c0             	and    $0xffffffc0,%esi
80102236:	89 f1                	mov    %esi,%ecx
80102238:	80 f9 40             	cmp    $0x40,%cl
8010223b:	75 f3                	jne    80102230 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010223d:	a8 21                	test   $0x21,%al
8010223f:	75 12                	jne    80102253 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
80102241:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102244:	b9 80 00 00 00       	mov    $0x80,%ecx
80102249:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010224e:	fc                   	cld    
8010224f:	f3 6d                	rep insl (%dx),%es:(%edi)
80102251:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102253:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
80102256:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102259:	89 f9                	mov    %edi,%ecx
8010225b:	83 c9 02             	or     $0x2,%ecx
8010225e:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102260:	53                   	push   %ebx
80102261:	e8 3a 1e 00 00       	call   801040a0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102266:	a1 64 a5 10 80       	mov    0x8010a564,%eax
8010226b:	83 c4 10             	add    $0x10,%esp
8010226e:	85 c0                	test   %eax,%eax
80102270:	74 05                	je     80102277 <ideintr+0x87>
    idestart(idequeue);
80102272:	e8 19 fe ff ff       	call   80102090 <idestart>
    release(&idelock);
80102277:	83 ec 0c             	sub    $0xc,%esp
8010227a:	68 80 a5 10 80       	push   $0x8010a580
8010227f:	e8 ec 22 00 00       	call   80104570 <release>

  release(&idelock);
}
80102284:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102287:	5b                   	pop    %ebx
80102288:	5e                   	pop    %esi
80102289:	5f                   	pop    %edi
8010228a:	5d                   	pop    %ebp
8010228b:	c3                   	ret    
8010228c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102290 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102290:	55                   	push   %ebp
80102291:	89 e5                	mov    %esp,%ebp
80102293:	53                   	push   %ebx
80102294:	83 ec 10             	sub    $0x10,%esp
80102297:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010229a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010229d:	50                   	push   %eax
8010229e:	e8 7d 20 00 00       	call   80104320 <holdingsleep>
801022a3:	83 c4 10             	add    $0x10,%esp
801022a6:	85 c0                	test   %eax,%eax
801022a8:	0f 84 c6 00 00 00    	je     80102374 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801022ae:	8b 03                	mov    (%ebx),%eax
801022b0:	83 e0 06             	and    $0x6,%eax
801022b3:	83 f8 02             	cmp    $0x2,%eax
801022b6:	0f 84 ab 00 00 00    	je     80102367 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801022bc:	8b 53 04             	mov    0x4(%ebx),%edx
801022bf:	85 d2                	test   %edx,%edx
801022c1:	74 0d                	je     801022d0 <iderw+0x40>
801022c3:	a1 60 a5 10 80       	mov    0x8010a560,%eax
801022c8:	85 c0                	test   %eax,%eax
801022ca:	0f 84 b1 00 00 00    	je     80102381 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801022d0:	83 ec 0c             	sub    $0xc,%esp
801022d3:	68 80 a5 10 80       	push   $0x8010a580
801022d8:	e8 d3 21 00 00       	call   801044b0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022dd:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
801022e3:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
801022e6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022ed:	85 d2                	test   %edx,%edx
801022ef:	75 09                	jne    801022fa <iderw+0x6a>
801022f1:	eb 6d                	jmp    80102360 <iderw+0xd0>
801022f3:	90                   	nop
801022f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801022f8:	89 c2                	mov    %eax,%edx
801022fa:	8b 42 58             	mov    0x58(%edx),%eax
801022fd:	85 c0                	test   %eax,%eax
801022ff:	75 f7                	jne    801022f8 <iderw+0x68>
80102301:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102304:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102306:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
8010230c:	74 42                	je     80102350 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010230e:	8b 03                	mov    (%ebx),%eax
80102310:	83 e0 06             	and    $0x6,%eax
80102313:	83 f8 02             	cmp    $0x2,%eax
80102316:	74 23                	je     8010233b <iderw+0xab>
80102318:	90                   	nop
80102319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102320:	83 ec 08             	sub    $0x8,%esp
80102323:	68 80 a5 10 80       	push   $0x8010a580
80102328:	53                   	push   %ebx
80102329:	e8 c2 1b 00 00       	call   80103ef0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010232e:	8b 03                	mov    (%ebx),%eax
80102330:	83 c4 10             	add    $0x10,%esp
80102333:	83 e0 06             	and    $0x6,%eax
80102336:	83 f8 02             	cmp    $0x2,%eax
80102339:	75 e5                	jne    80102320 <iderw+0x90>
  }


  release(&idelock);
8010233b:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
80102342:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102345:	c9                   	leave  
  release(&idelock);
80102346:	e9 25 22 00 00       	jmp    80104570 <release>
8010234b:	90                   	nop
8010234c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102350:	89 d8                	mov    %ebx,%eax
80102352:	e8 39 fd ff ff       	call   80102090 <idestart>
80102357:	eb b5                	jmp    8010230e <iderw+0x7e>
80102359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102360:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
80102365:	eb 9d                	jmp    80102304 <iderw+0x74>
    panic("iderw: nothing to do");
80102367:	83 ec 0c             	sub    $0xc,%esp
8010236a:	68 88 72 10 80       	push   $0x80107288
8010236f:	e8 dc e0 ff ff       	call   80100450 <panic>
    panic("iderw: buf not locked");
80102374:	83 ec 0c             	sub    $0xc,%esp
80102377:	68 72 72 10 80       	push   $0x80107272
8010237c:	e8 cf e0 ff ff       	call   80100450 <panic>
    panic("iderw: ide disk 1 not present");
80102381:	83 ec 0c             	sub    $0xc,%esp
80102384:	68 9d 72 10 80       	push   $0x8010729d
80102389:	e8 c2 e0 ff ff       	call   80100450 <panic>
8010238e:	66 90                	xchg   %ax,%ax

80102390 <ioapicinit>:
80102390:	55                   	push   %ebp
80102391:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
80102398:	00 c0 fe 
8010239b:	89 e5                	mov    %esp,%ebp
8010239d:	56                   	push   %esi
8010239e:	53                   	push   %ebx
8010239f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801023a6:	00 00 00 
801023a9:	a1 54 26 11 80       	mov    0x80112654,%eax
801023ae:	8b 58 10             	mov    0x10(%eax),%ebx
801023b1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801023b7:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
801023bd:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
801023c4:	c1 eb 10             	shr    $0x10,%ebx
801023c7:	8b 41 10             	mov    0x10(%ecx),%eax
801023ca:	0f b6 db             	movzbl %bl,%ebx
801023cd:	c1 e8 18             	shr    $0x18,%eax
801023d0:	39 c2                	cmp    %eax,%edx
801023d2:	74 16                	je     801023ea <ioapicinit+0x5a>
801023d4:	83 ec 0c             	sub    $0xc,%esp
801023d7:	68 bc 72 10 80       	push   $0x801072bc
801023dc:	e8 3f e3 ff ff       	call   80100720 <cprintf>
801023e1:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
801023e7:	83 c4 10             	add    $0x10,%esp
801023ea:	83 c3 21             	add    $0x21,%ebx
801023ed:	ba 10 00 00 00       	mov    $0x10,%edx
801023f2:	b8 20 00 00 00       	mov    $0x20,%eax
801023f7:	89 f6                	mov    %esi,%esi
801023f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102400:	89 11                	mov    %edx,(%ecx)
80102402:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
80102408:	89 c6                	mov    %eax,%esi
8010240a:	81 ce 00 00 01 00    	or     $0x10000,%esi
80102410:	83 c0 01             	add    $0x1,%eax
80102413:	89 71 10             	mov    %esi,0x10(%ecx)
80102416:	8d 72 01             	lea    0x1(%edx),%esi
80102419:	83 c2 02             	add    $0x2,%edx
8010241c:	39 d8                	cmp    %ebx,%eax
8010241e:	89 31                	mov    %esi,(%ecx)
80102420:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
80102426:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
8010242d:	75 d1                	jne    80102400 <ioapicinit+0x70>
8010242f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102432:	5b                   	pop    %ebx
80102433:	5e                   	pop    %esi
80102434:	5d                   	pop    %ebp
80102435:	c3                   	ret    
80102436:	8d 76 00             	lea    0x0(%esi),%esi
80102439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102440 <ioapicenable>:
80102440:	55                   	push   %ebp
80102441:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
80102447:	89 e5                	mov    %esp,%ebp
80102449:	8b 45 08             	mov    0x8(%ebp),%eax
8010244c:	8d 50 20             	lea    0x20(%eax),%edx
8010244f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
80102453:	89 01                	mov    %eax,(%ecx)
80102455:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
8010245b:	83 c0 01             	add    $0x1,%eax
8010245e:	89 51 10             	mov    %edx,0x10(%ecx)
80102461:	8b 55 0c             	mov    0xc(%ebp),%edx
80102464:	89 01                	mov    %eax,(%ecx)
80102466:	a1 54 26 11 80       	mov    0x80112654,%eax
8010246b:	c1 e2 18             	shl    $0x18,%edx
8010246e:	89 50 10             	mov    %edx,0x10(%eax)
80102471:	5d                   	pop    %ebp
80102472:	c3                   	ret    
80102473:	66 90                	xchg   %ax,%ax
80102475:	66 90                	xchg   %ax,%ax
80102477:	66 90                	xchg   %ax,%ax
80102479:	66 90                	xchg   %ax,%ax
8010247b:	66 90                	xchg   %ax,%ax
8010247d:	66 90                	xchg   %ax,%ax
8010247f:	90                   	nop

80102480 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102480:	55                   	push   %ebp
80102481:	89 e5                	mov    %esp,%ebp
80102483:	53                   	push   %ebx
80102484:	83 ec 04             	sub    $0x4,%esp
80102487:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010248a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102490:	75 70                	jne    80102502 <kfree+0x82>
80102492:	81 fb c8 55 11 80    	cmp    $0x801155c8,%ebx
80102498:	72 68                	jb     80102502 <kfree+0x82>
8010249a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801024a0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801024a5:	77 5b                	ja     80102502 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801024a7:	83 ec 04             	sub    $0x4,%esp
801024aa:	68 00 10 00 00       	push   $0x1000
801024af:	6a 01                	push   $0x1
801024b1:	53                   	push   %ebx
801024b2:	e8 09 21 00 00       	call   801045c0 <memset>

  if(kmem.use_lock)
801024b7:	8b 15 94 26 11 80    	mov    0x80112694,%edx
801024bd:	83 c4 10             	add    $0x10,%esp
801024c0:	85 d2                	test   %edx,%edx
801024c2:	75 2c                	jne    801024f0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801024c4:	a1 98 26 11 80       	mov    0x80112698,%eax
801024c9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801024cb:	a1 94 26 11 80       	mov    0x80112694,%eax
  kmem.freelist = r;
801024d0:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
  if(kmem.use_lock)
801024d6:	85 c0                	test   %eax,%eax
801024d8:	75 06                	jne    801024e0 <kfree+0x60>
    release(&kmem.lock);
}
801024da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024dd:	c9                   	leave  
801024de:	c3                   	ret    
801024df:	90                   	nop
    release(&kmem.lock);
801024e0:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
}
801024e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024ea:	c9                   	leave  
    release(&kmem.lock);
801024eb:	e9 80 20 00 00       	jmp    80104570 <release>
    acquire(&kmem.lock);
801024f0:	83 ec 0c             	sub    $0xc,%esp
801024f3:	68 60 26 11 80       	push   $0x80112660
801024f8:	e8 b3 1f 00 00       	call   801044b0 <acquire>
801024fd:	83 c4 10             	add    $0x10,%esp
80102500:	eb c2                	jmp    801024c4 <kfree+0x44>
    panic("kfree");
80102502:	83 ec 0c             	sub    $0xc,%esp
80102505:	68 ee 72 10 80       	push   $0x801072ee
8010250a:	e8 41 df ff ff       	call   80100450 <panic>
8010250f:	90                   	nop

80102510 <freerange>:
{
80102510:	55                   	push   %ebp
80102511:	89 e5                	mov    %esp,%ebp
80102513:	56                   	push   %esi
80102514:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102515:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102518:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010251b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102521:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102527:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010252d:	39 de                	cmp    %ebx,%esi
8010252f:	72 23                	jb     80102554 <freerange+0x44>
80102531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102538:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010253e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102541:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102547:	50                   	push   %eax
80102548:	e8 33 ff ff ff       	call   80102480 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010254d:	83 c4 10             	add    $0x10,%esp
80102550:	39 f3                	cmp    %esi,%ebx
80102552:	76 e4                	jbe    80102538 <freerange+0x28>
}
80102554:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102557:	5b                   	pop    %ebx
80102558:	5e                   	pop    %esi
80102559:	5d                   	pop    %ebp
8010255a:	c3                   	ret    
8010255b:	90                   	nop
8010255c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102560 <kinit1>:
{
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	56                   	push   %esi
80102564:	53                   	push   %ebx
80102565:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102568:	83 ec 08             	sub    $0x8,%esp
8010256b:	68 f4 72 10 80       	push   $0x801072f4
80102570:	68 60 26 11 80       	push   $0x80112660
80102575:	e8 f6 1d 00 00       	call   80104370 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010257a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010257d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102580:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
80102587:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010258a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102590:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102596:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010259c:	39 de                	cmp    %ebx,%esi
8010259e:	72 1c                	jb     801025bc <kinit1+0x5c>
    kfree(p);
801025a0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801025a6:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025a9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025af:	50                   	push   %eax
801025b0:	e8 cb fe ff ff       	call   80102480 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025b5:	83 c4 10             	add    $0x10,%esp
801025b8:	39 de                	cmp    %ebx,%esi
801025ba:	73 e4                	jae    801025a0 <kinit1+0x40>
}
801025bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025bf:	5b                   	pop    %ebx
801025c0:	5e                   	pop    %esi
801025c1:	5d                   	pop    %ebp
801025c2:	c3                   	ret    
801025c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801025c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025d0 <kinit2>:
{
801025d0:	55                   	push   %ebp
801025d1:	89 e5                	mov    %esp,%ebp
801025d3:	56                   	push   %esi
801025d4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801025d5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801025d8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801025db:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025e1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025e7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025ed:	39 de                	cmp    %ebx,%esi
801025ef:	72 23                	jb     80102614 <kinit2+0x44>
801025f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801025f8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801025fe:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102601:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102607:	50                   	push   %eax
80102608:	e8 73 fe ff ff       	call   80102480 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010260d:	83 c4 10             	add    $0x10,%esp
80102610:	39 de                	cmp    %ebx,%esi
80102612:	73 e4                	jae    801025f8 <kinit2+0x28>
  kmem.use_lock = 1;
80102614:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
8010261b:	00 00 00 
}
8010261e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102621:	5b                   	pop    %ebx
80102622:	5e                   	pop    %esi
80102623:	5d                   	pop    %ebp
80102624:	c3                   	ret    
80102625:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102630 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102630:	a1 94 26 11 80       	mov    0x80112694,%eax
80102635:	85 c0                	test   %eax,%eax
80102637:	75 1f                	jne    80102658 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102639:	a1 98 26 11 80       	mov    0x80112698,%eax
  if(r)
8010263e:	85 c0                	test   %eax,%eax
80102640:	74 0e                	je     80102650 <kalloc+0x20>
    kmem.freelist = r->next;
80102642:	8b 10                	mov    (%eax),%edx
80102644:	89 15 98 26 11 80    	mov    %edx,0x80112698
8010264a:	c3                   	ret    
8010264b:	90                   	nop
8010264c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102650:	f3 c3                	repz ret 
80102652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
80102658:	55                   	push   %ebp
80102659:	89 e5                	mov    %esp,%ebp
8010265b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010265e:	68 60 26 11 80       	push   $0x80112660
80102663:	e8 48 1e 00 00       	call   801044b0 <acquire>
  r = kmem.freelist;
80102668:	a1 98 26 11 80       	mov    0x80112698,%eax
  if(r)
8010266d:	83 c4 10             	add    $0x10,%esp
80102670:	8b 15 94 26 11 80    	mov    0x80112694,%edx
80102676:	85 c0                	test   %eax,%eax
80102678:	74 08                	je     80102682 <kalloc+0x52>
    kmem.freelist = r->next;
8010267a:	8b 08                	mov    (%eax),%ecx
8010267c:	89 0d 98 26 11 80    	mov    %ecx,0x80112698
  if(kmem.use_lock)
80102682:	85 d2                	test   %edx,%edx
80102684:	74 16                	je     8010269c <kalloc+0x6c>
    release(&kmem.lock);
80102686:	83 ec 0c             	sub    $0xc,%esp
80102689:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010268c:	68 60 26 11 80       	push   $0x80112660
80102691:	e8 da 1e 00 00       	call   80104570 <release>
  return (char*)r;
80102696:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102699:	83 c4 10             	add    $0x10,%esp
}
8010269c:	c9                   	leave  
8010269d:	c3                   	ret    
8010269e:	66 90                	xchg   %ax,%ax

801026a0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026a0:	ba 64 00 00 00       	mov    $0x64,%edx
801026a5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801026a6:	a8 01                	test   $0x1,%al
801026a8:	0f 84 c2 00 00 00    	je     80102770 <kbdgetc+0xd0>
801026ae:	ba 60 00 00 00       	mov    $0x60,%edx
801026b3:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801026b4:	0f b6 d0             	movzbl %al,%edx
801026b7:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx

  if(data == 0xE0){
801026bd:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
801026c3:	0f 84 7f 00 00 00    	je     80102748 <kbdgetc+0xa8>
{
801026c9:	55                   	push   %ebp
801026ca:	89 e5                	mov    %esp,%ebp
801026cc:	53                   	push   %ebx
801026cd:	89 cb                	mov    %ecx,%ebx
801026cf:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801026d2:	84 c0                	test   %al,%al
801026d4:	78 4a                	js     80102720 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801026d6:	85 db                	test   %ebx,%ebx
801026d8:	74 09                	je     801026e3 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801026da:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801026dd:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
801026e0:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
801026e3:	0f b6 82 20 74 10 80 	movzbl -0x7fef8be0(%edx),%eax
801026ea:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
801026ec:	0f b6 82 20 73 10 80 	movzbl -0x7fef8ce0(%edx),%eax
801026f3:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801026f5:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
801026f7:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
801026fd:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102700:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102703:	8b 04 85 00 73 10 80 	mov    -0x7fef8d00(,%eax,4),%eax
8010270a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010270e:	74 31                	je     80102741 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102710:	8d 50 9f             	lea    -0x61(%eax),%edx
80102713:	83 fa 19             	cmp    $0x19,%edx
80102716:	77 40                	ja     80102758 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102718:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010271b:	5b                   	pop    %ebx
8010271c:	5d                   	pop    %ebp
8010271d:	c3                   	ret    
8010271e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102720:	83 e0 7f             	and    $0x7f,%eax
80102723:	85 db                	test   %ebx,%ebx
80102725:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102728:	0f b6 82 20 74 10 80 	movzbl -0x7fef8be0(%edx),%eax
8010272f:	83 c8 40             	or     $0x40,%eax
80102732:	0f b6 c0             	movzbl %al,%eax
80102735:	f7 d0                	not    %eax
80102737:	21 c1                	and    %eax,%ecx
    return 0;
80102739:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
8010273b:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
80102741:	5b                   	pop    %ebx
80102742:	5d                   	pop    %ebp
80102743:	c3                   	ret    
80102744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102748:	83 c9 40             	or     $0x40,%ecx
    return 0;
8010274b:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
8010274d:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
    return 0;
80102753:	c3                   	ret    
80102754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102758:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010275b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010275e:	5b                   	pop    %ebx
      c += 'a' - 'A';
8010275f:	83 f9 1a             	cmp    $0x1a,%ecx
80102762:	0f 42 c2             	cmovb  %edx,%eax
}
80102765:	5d                   	pop    %ebp
80102766:	c3                   	ret    
80102767:	89 f6                	mov    %esi,%esi
80102769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102770:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102775:	c3                   	ret    
80102776:	8d 76 00             	lea    0x0(%esi),%esi
80102779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102780 <kbdintr>:

void
kbdintr(void)
{
80102780:	55                   	push   %ebp
80102781:	89 e5                	mov    %esp,%ebp
80102783:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102786:	68 a0 26 10 80       	push   $0x801026a0
8010278b:	e8 40 e1 ff ff       	call   801008d0 <consoleintr>
}
80102790:	83 c4 10             	add    $0x10,%esp
80102793:	c9                   	leave  
80102794:	c3                   	ret    
80102795:	66 90                	xchg   %ax,%ax
80102797:	66 90                	xchg   %ax,%ax
80102799:	66 90                	xchg   %ax,%ax
8010279b:	66 90                	xchg   %ax,%ax
8010279d:	66 90                	xchg   %ax,%ax
8010279f:	90                   	nop

801027a0 <lapicinit>:
801027a0:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801027a5:	55                   	push   %ebp
801027a6:	89 e5                	mov    %esp,%ebp
801027a8:	85 c0                	test   %eax,%eax
801027aa:	0f 84 c8 00 00 00    	je     80102878 <lapicinit+0xd8>
801027b0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801027b7:	01 00 00 
801027ba:	8b 50 20             	mov    0x20(%eax),%edx
801027bd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801027c4:	00 00 00 
801027c7:	8b 50 20             	mov    0x20(%eax),%edx
801027ca:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801027d1:	00 02 00 
801027d4:	8b 50 20             	mov    0x20(%eax),%edx
801027d7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801027de:	96 98 00 
801027e1:	8b 50 20             	mov    0x20(%eax),%edx
801027e4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801027eb:	00 01 00 
801027ee:	8b 50 20             	mov    0x20(%eax),%edx
801027f1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801027f8:	00 01 00 
801027fb:	8b 50 20             	mov    0x20(%eax),%edx
801027fe:	8b 50 30             	mov    0x30(%eax),%edx
80102801:	c1 ea 10             	shr    $0x10,%edx
80102804:	80 fa 03             	cmp    $0x3,%dl
80102807:	77 77                	ja     80102880 <lapicinit+0xe0>
80102809:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102810:	00 00 00 
80102813:	8b 50 20             	mov    0x20(%eax),%edx
80102816:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010281d:	00 00 00 
80102820:	8b 50 20             	mov    0x20(%eax),%edx
80102823:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010282a:	00 00 00 
8010282d:	8b 50 20             	mov    0x20(%eax),%edx
80102830:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102837:	00 00 00 
8010283a:	8b 50 20             	mov    0x20(%eax),%edx
8010283d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102844:	00 00 00 
80102847:	8b 50 20             	mov    0x20(%eax),%edx
8010284a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102851:	85 08 00 
80102854:	8b 50 20             	mov    0x20(%eax),%edx
80102857:	89 f6                	mov    %esi,%esi
80102859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102860:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102866:	80 e6 10             	and    $0x10,%dh
80102869:	75 f5                	jne    80102860 <lapicinit+0xc0>
8010286b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102872:	00 00 00 
80102875:	8b 40 20             	mov    0x20(%eax),%eax
80102878:	5d                   	pop    %ebp
80102879:	c3                   	ret    
8010287a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102880:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102887:	00 01 00 
8010288a:	8b 50 20             	mov    0x20(%eax),%edx
8010288d:	e9 77 ff ff ff       	jmp    80102809 <lapicinit+0x69>
80102892:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028a0 <lapicid>:
801028a0:	8b 15 9c 26 11 80    	mov    0x8011269c,%edx
801028a6:	55                   	push   %ebp
801028a7:	31 c0                	xor    %eax,%eax
801028a9:	89 e5                	mov    %esp,%ebp
801028ab:	85 d2                	test   %edx,%edx
801028ad:	74 06                	je     801028b5 <lapicid+0x15>
801028af:	8b 42 20             	mov    0x20(%edx),%eax
801028b2:	c1 e8 18             	shr    $0x18,%eax
801028b5:	5d                   	pop    %ebp
801028b6:	c3                   	ret    
801028b7:	89 f6                	mov    %esi,%esi
801028b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028c0 <lapiceoi>:
801028c0:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801028c5:	55                   	push   %ebp
801028c6:	89 e5                	mov    %esp,%ebp
801028c8:	85 c0                	test   %eax,%eax
801028ca:	74 0d                	je     801028d9 <lapiceoi+0x19>
801028cc:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801028d3:	00 00 00 
801028d6:	8b 40 20             	mov    0x20(%eax),%eax
801028d9:	5d                   	pop    %ebp
801028da:	c3                   	ret    
801028db:	90                   	nop
801028dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801028e0 <microdelay>:
801028e0:	55                   	push   %ebp
801028e1:	89 e5                	mov    %esp,%ebp
801028e3:	5d                   	pop    %ebp
801028e4:	c3                   	ret    
801028e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028f0 <lapicstartap>:
801028f0:	55                   	push   %ebp
801028f1:	b8 0f 00 00 00       	mov    $0xf,%eax
801028f6:	ba 70 00 00 00       	mov    $0x70,%edx
801028fb:	89 e5                	mov    %esp,%ebp
801028fd:	53                   	push   %ebx
801028fe:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102901:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102904:	ee                   	out    %al,(%dx)
80102905:	b8 0a 00 00 00       	mov    $0xa,%eax
8010290a:	ba 71 00 00 00       	mov    $0x71,%edx
8010290f:	ee                   	out    %al,(%dx)
80102910:	31 c0                	xor    %eax,%eax
80102912:	c1 e3 18             	shl    $0x18,%ebx
80102915:	66 a3 67 04 00 80    	mov    %ax,0x80000467
8010291b:	89 c8                	mov    %ecx,%eax
8010291d:	c1 e9 0c             	shr    $0xc,%ecx
80102920:	c1 e8 04             	shr    $0x4,%eax
80102923:	89 da                	mov    %ebx,%edx
80102925:	80 cd 06             	or     $0x6,%ch
80102928:	66 a3 69 04 00 80    	mov    %ax,0x80000469
8010292e:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102933:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
80102939:	8b 58 20             	mov    0x20(%eax),%ebx
8010293c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102943:	c5 00 00 
80102946:	8b 58 20             	mov    0x20(%eax),%ebx
80102949:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102950:	85 00 00 
80102953:	8b 58 20             	mov    0x20(%eax),%ebx
80102956:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
8010295c:	8b 58 20             	mov    0x20(%eax),%ebx
8010295f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
80102965:	8b 58 20             	mov    0x20(%eax),%ebx
80102968:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
8010296e:	8b 50 20             	mov    0x20(%eax),%edx
80102971:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
80102977:	8b 40 20             	mov    0x20(%eax),%eax
8010297a:	5b                   	pop    %ebx
8010297b:	5d                   	pop    %ebp
8010297c:	c3                   	ret    
8010297d:	8d 76 00             	lea    0x0(%esi),%esi

80102980 <cmostime>:
80102980:	55                   	push   %ebp
80102981:	b8 0b 00 00 00       	mov    $0xb,%eax
80102986:	ba 70 00 00 00       	mov    $0x70,%edx
8010298b:	89 e5                	mov    %esp,%ebp
8010298d:	57                   	push   %edi
8010298e:	56                   	push   %esi
8010298f:	53                   	push   %ebx
80102990:	83 ec 4c             	sub    $0x4c,%esp
80102993:	ee                   	out    %al,(%dx)
80102994:	ba 71 00 00 00       	mov    $0x71,%edx
80102999:	ec                   	in     (%dx),%al
8010299a:	83 e0 04             	and    $0x4,%eax
8010299d:	bb 70 00 00 00       	mov    $0x70,%ebx
801029a2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801029a5:	8d 76 00             	lea    0x0(%esi),%esi
801029a8:	31 c0                	xor    %eax,%eax
801029aa:	89 da                	mov    %ebx,%edx
801029ac:	ee                   	out    %al,(%dx)
801029ad:	b9 71 00 00 00       	mov    $0x71,%ecx
801029b2:	89 ca                	mov    %ecx,%edx
801029b4:	ec                   	in     (%dx),%al
801029b5:	88 45 b7             	mov    %al,-0x49(%ebp)
801029b8:	89 da                	mov    %ebx,%edx
801029ba:	b8 02 00 00 00       	mov    $0x2,%eax
801029bf:	ee                   	out    %al,(%dx)
801029c0:	89 ca                	mov    %ecx,%edx
801029c2:	ec                   	in     (%dx),%al
801029c3:	88 45 b6             	mov    %al,-0x4a(%ebp)
801029c6:	89 da                	mov    %ebx,%edx
801029c8:	b8 04 00 00 00       	mov    $0x4,%eax
801029cd:	ee                   	out    %al,(%dx)
801029ce:	89 ca                	mov    %ecx,%edx
801029d0:	ec                   	in     (%dx),%al
801029d1:	88 45 b5             	mov    %al,-0x4b(%ebp)
801029d4:	89 da                	mov    %ebx,%edx
801029d6:	b8 07 00 00 00       	mov    $0x7,%eax
801029db:	ee                   	out    %al,(%dx)
801029dc:	89 ca                	mov    %ecx,%edx
801029de:	ec                   	in     (%dx),%al
801029df:	88 45 b4             	mov    %al,-0x4c(%ebp)
801029e2:	89 da                	mov    %ebx,%edx
801029e4:	b8 08 00 00 00       	mov    $0x8,%eax
801029e9:	ee                   	out    %al,(%dx)
801029ea:	89 ca                	mov    %ecx,%edx
801029ec:	ec                   	in     (%dx),%al
801029ed:	89 c7                	mov    %eax,%edi
801029ef:	89 da                	mov    %ebx,%edx
801029f1:	b8 09 00 00 00       	mov    $0x9,%eax
801029f6:	ee                   	out    %al,(%dx)
801029f7:	89 ca                	mov    %ecx,%edx
801029f9:	ec                   	in     (%dx),%al
801029fa:	89 c6                	mov    %eax,%esi
801029fc:	89 da                	mov    %ebx,%edx
801029fe:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a03:	ee                   	out    %al,(%dx)
80102a04:	89 ca                	mov    %ecx,%edx
80102a06:	ec                   	in     (%dx),%al
80102a07:	84 c0                	test   %al,%al
80102a09:	78 9d                	js     801029a8 <cmostime+0x28>
80102a0b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102a0f:	89 fa                	mov    %edi,%edx
80102a11:	0f b6 fa             	movzbl %dl,%edi
80102a14:	89 f2                	mov    %esi,%edx
80102a16:	0f b6 f2             	movzbl %dl,%esi
80102a19:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102a1c:	89 da                	mov    %ebx,%edx
80102a1e:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102a21:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102a24:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102a28:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102a2b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102a2f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102a32:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102a36:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102a39:	31 c0                	xor    %eax,%eax
80102a3b:	ee                   	out    %al,(%dx)
80102a3c:	89 ca                	mov    %ecx,%edx
80102a3e:	ec                   	in     (%dx),%al
80102a3f:	0f b6 c0             	movzbl %al,%eax
80102a42:	89 da                	mov    %ebx,%edx
80102a44:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a47:	b8 02 00 00 00       	mov    $0x2,%eax
80102a4c:	ee                   	out    %al,(%dx)
80102a4d:	89 ca                	mov    %ecx,%edx
80102a4f:	ec                   	in     (%dx),%al
80102a50:	0f b6 c0             	movzbl %al,%eax
80102a53:	89 da                	mov    %ebx,%edx
80102a55:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102a58:	b8 04 00 00 00       	mov    $0x4,%eax
80102a5d:	ee                   	out    %al,(%dx)
80102a5e:	89 ca                	mov    %ecx,%edx
80102a60:	ec                   	in     (%dx),%al
80102a61:	0f b6 c0             	movzbl %al,%eax
80102a64:	89 da                	mov    %ebx,%edx
80102a66:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102a69:	b8 07 00 00 00       	mov    $0x7,%eax
80102a6e:	ee                   	out    %al,(%dx)
80102a6f:	89 ca                	mov    %ecx,%edx
80102a71:	ec                   	in     (%dx),%al
80102a72:	0f b6 c0             	movzbl %al,%eax
80102a75:	89 da                	mov    %ebx,%edx
80102a77:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102a7a:	b8 08 00 00 00       	mov    $0x8,%eax
80102a7f:	ee                   	out    %al,(%dx)
80102a80:	89 ca                	mov    %ecx,%edx
80102a82:	ec                   	in     (%dx),%al
80102a83:	0f b6 c0             	movzbl %al,%eax
80102a86:	89 da                	mov    %ebx,%edx
80102a88:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102a8b:	b8 09 00 00 00       	mov    $0x9,%eax
80102a90:	ee                   	out    %al,(%dx)
80102a91:	89 ca                	mov    %ecx,%edx
80102a93:	ec                   	in     (%dx),%al
80102a94:	0f b6 c0             	movzbl %al,%eax
80102a97:	83 ec 04             	sub    $0x4,%esp
80102a9a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102a9d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102aa0:	6a 18                	push   $0x18
80102aa2:	50                   	push   %eax
80102aa3:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102aa6:	50                   	push   %eax
80102aa7:	e8 64 1b 00 00       	call   80104610 <memcmp>
80102aac:	83 c4 10             	add    $0x10,%esp
80102aaf:	85 c0                	test   %eax,%eax
80102ab1:	0f 85 f1 fe ff ff    	jne    801029a8 <cmostime+0x28>
80102ab7:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102abb:	75 78                	jne    80102b35 <cmostime+0x1b5>
80102abd:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102ac0:	89 c2                	mov    %eax,%edx
80102ac2:	83 e0 0f             	and    $0xf,%eax
80102ac5:	c1 ea 04             	shr    $0x4,%edx
80102ac8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102acb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ace:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102ad1:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ad4:	89 c2                	mov    %eax,%edx
80102ad6:	83 e0 0f             	and    $0xf,%eax
80102ad9:	c1 ea 04             	shr    $0x4,%edx
80102adc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102adf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ae2:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102ae5:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ae8:	89 c2                	mov    %eax,%edx
80102aea:	83 e0 0f             	and    $0xf,%eax
80102aed:	c1 ea 04             	shr    $0x4,%edx
80102af0:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102af3:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102af6:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102af9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102afc:	89 c2                	mov    %eax,%edx
80102afe:	83 e0 0f             	and    $0xf,%eax
80102b01:	c1 ea 04             	shr    $0x4,%edx
80102b04:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b07:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b0a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102b0d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b10:	89 c2                	mov    %eax,%edx
80102b12:	83 e0 0f             	and    $0xf,%eax
80102b15:	c1 ea 04             	shr    $0x4,%edx
80102b18:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b1b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b1e:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102b21:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b24:	89 c2                	mov    %eax,%edx
80102b26:	83 e0 0f             	and    $0xf,%eax
80102b29:	c1 ea 04             	shr    $0x4,%edx
80102b2c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b2f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b32:	89 45 cc             	mov    %eax,-0x34(%ebp)
80102b35:	8b 75 08             	mov    0x8(%ebp),%esi
80102b38:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b3b:	89 06                	mov    %eax,(%esi)
80102b3d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b40:	89 46 04             	mov    %eax,0x4(%esi)
80102b43:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b46:	89 46 08             	mov    %eax,0x8(%esi)
80102b49:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b4c:	89 46 0c             	mov    %eax,0xc(%esi)
80102b4f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b52:	89 46 10             	mov    %eax,0x10(%esi)
80102b55:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b58:	89 46 14             	mov    %eax,0x14(%esi)
80102b5b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
80102b62:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b65:	5b                   	pop    %ebx
80102b66:	5e                   	pop    %esi
80102b67:	5f                   	pop    %edi
80102b68:	5d                   	pop    %ebp
80102b69:	c3                   	ret    
80102b6a:	66 90                	xchg   %ax,%ax
80102b6c:	66 90                	xchg   %ax,%ax
80102b6e:	66 90                	xchg   %ax,%ax

80102b70 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b70:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102b76:	85 c9                	test   %ecx,%ecx
80102b78:	0f 8e 8a 00 00 00    	jle    80102c08 <install_trans+0x98>
{
80102b7e:	55                   	push   %ebp
80102b7f:	89 e5                	mov    %esp,%ebp
80102b81:	57                   	push   %edi
80102b82:	56                   	push   %esi
80102b83:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102b84:	31 db                	xor    %ebx,%ebx
{
80102b86:	83 ec 0c             	sub    $0xc,%esp
80102b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102b90:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102b95:	83 ec 08             	sub    $0x8,%esp
80102b98:	01 d8                	add    %ebx,%eax
80102b9a:	83 c0 01             	add    $0x1,%eax
80102b9d:	50                   	push   %eax
80102b9e:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102ba4:	e8 27 d5 ff ff       	call   801000d0 <bread>
80102ba9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bab:	58                   	pop    %eax
80102bac:	5a                   	pop    %edx
80102bad:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102bb4:	ff 35 e4 26 11 80    	pushl  0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102bba:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bbd:	e8 0e d5 ff ff       	call   801000d0 <bread>
80102bc2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102bc4:	8d 47 5c             	lea    0x5c(%edi),%eax
80102bc7:	83 c4 0c             	add    $0xc,%esp
80102bca:	68 00 02 00 00       	push   $0x200
80102bcf:	50                   	push   %eax
80102bd0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102bd3:	50                   	push   %eax
80102bd4:	e8 97 1a 00 00       	call   80104670 <memmove>
    bwrite(dbuf);  // write dst to disk
80102bd9:	89 34 24             	mov    %esi,(%esp)
80102bdc:	e8 bf d5 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102be1:	89 3c 24             	mov    %edi,(%esp)
80102be4:	e8 f7 d5 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102be9:	89 34 24             	mov    %esi,(%esp)
80102bec:	e8 ef d5 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102bf1:	83 c4 10             	add    $0x10,%esp
80102bf4:	39 1d e8 26 11 80    	cmp    %ebx,0x801126e8
80102bfa:	7f 94                	jg     80102b90 <install_trans+0x20>
  }
}
80102bfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102bff:	5b                   	pop    %ebx
80102c00:	5e                   	pop    %esi
80102c01:	5f                   	pop    %edi
80102c02:	5d                   	pop    %ebp
80102c03:	c3                   	ret    
80102c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c08:	f3 c3                	repz ret 
80102c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102c10 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c10:	55                   	push   %ebp
80102c11:	89 e5                	mov    %esp,%ebp
80102c13:	56                   	push   %esi
80102c14:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102c15:	83 ec 08             	sub    $0x8,%esp
80102c18:	ff 35 d4 26 11 80    	pushl  0x801126d4
80102c1e:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102c24:	e8 a7 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102c29:	8b 1d e8 26 11 80    	mov    0x801126e8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102c2f:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c32:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102c34:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102c36:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102c39:	7e 16                	jle    80102c51 <write_head+0x41>
80102c3b:	c1 e3 02             	shl    $0x2,%ebx
80102c3e:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102c40:	8b 8a ec 26 11 80    	mov    -0x7feed914(%edx),%ecx
80102c46:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102c4a:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102c4d:	39 da                	cmp    %ebx,%edx
80102c4f:	75 ef                	jne    80102c40 <write_head+0x30>
  }
  bwrite(buf);
80102c51:	83 ec 0c             	sub    $0xc,%esp
80102c54:	56                   	push   %esi
80102c55:	e8 46 d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102c5a:	89 34 24             	mov    %esi,(%esp)
80102c5d:	e8 7e d5 ff ff       	call   801001e0 <brelse>
}
80102c62:	83 c4 10             	add    $0x10,%esp
80102c65:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102c68:	5b                   	pop    %ebx
80102c69:	5e                   	pop    %esi
80102c6a:	5d                   	pop    %ebp
80102c6b:	c3                   	ret    
80102c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102c70 <initlog>:
{
80102c70:	55                   	push   %ebp
80102c71:	89 e5                	mov    %esp,%ebp
80102c73:	53                   	push   %ebx
80102c74:	83 ec 2c             	sub    $0x2c,%esp
80102c77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102c7a:	68 20 75 10 80       	push   $0x80107520
80102c7f:	68 a0 26 11 80       	push   $0x801126a0
80102c84:	e8 e7 16 00 00       	call   80104370 <initlock>
  readsb(dev, &sb);
80102c89:	58                   	pop    %eax
80102c8a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102c8d:	5a                   	pop    %edx
80102c8e:	50                   	push   %eax
80102c8f:	53                   	push   %ebx
80102c90:	e8 db e8 ff ff       	call   80101570 <readsb>
  log.size = sb.nlog;
80102c95:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102c98:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102c9b:	59                   	pop    %ecx
  log.dev = dev;
80102c9c:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
80102ca2:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  log.start = sb.logstart;
80102ca8:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  struct buf *buf = bread(log.dev, log.start);
80102cad:	5a                   	pop    %edx
80102cae:	50                   	push   %eax
80102caf:	53                   	push   %ebx
80102cb0:	e8 1b d4 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102cb5:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102cb8:	83 c4 10             	add    $0x10,%esp
80102cbb:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102cbd:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102cc3:	7e 1c                	jle    80102ce1 <initlog+0x71>
80102cc5:	c1 e3 02             	shl    $0x2,%ebx
80102cc8:	31 d2                	xor    %edx,%edx
80102cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102cd0:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102cd4:	83 c2 04             	add    $0x4,%edx
80102cd7:	89 8a e8 26 11 80    	mov    %ecx,-0x7feed918(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102cdd:	39 d3                	cmp    %edx,%ebx
80102cdf:	75 ef                	jne    80102cd0 <initlog+0x60>
  brelse(buf);
80102ce1:	83 ec 0c             	sub    $0xc,%esp
80102ce4:	50                   	push   %eax
80102ce5:	e8 f6 d4 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102cea:	e8 81 fe ff ff       	call   80102b70 <install_trans>
  log.lh.n = 0;
80102cef:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102cf6:	00 00 00 
  write_head(); // clear the log
80102cf9:	e8 12 ff ff ff       	call   80102c10 <write_head>
}
80102cfe:	83 c4 10             	add    $0x10,%esp
80102d01:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d04:	c9                   	leave  
80102d05:	c3                   	ret    
80102d06:	8d 76 00             	lea    0x0(%esi),%esi
80102d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d10 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102d10:	55                   	push   %ebp
80102d11:	89 e5                	mov    %esp,%ebp
80102d13:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102d16:	68 a0 26 11 80       	push   $0x801126a0
80102d1b:	e8 90 17 00 00       	call   801044b0 <acquire>
80102d20:	83 c4 10             	add    $0x10,%esp
80102d23:	eb 18                	jmp    80102d3d <begin_op+0x2d>
80102d25:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d28:	83 ec 08             	sub    $0x8,%esp
80102d2b:	68 a0 26 11 80       	push   $0x801126a0
80102d30:	68 a0 26 11 80       	push   $0x801126a0
80102d35:	e8 b6 11 00 00       	call   80103ef0 <sleep>
80102d3a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102d3d:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102d42:	85 c0                	test   %eax,%eax
80102d44:	75 e2                	jne    80102d28 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d46:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102d4b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102d51:	83 c0 01             	add    $0x1,%eax
80102d54:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102d57:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102d5a:	83 fa 1e             	cmp    $0x1e,%edx
80102d5d:	7f c9                	jg     80102d28 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102d5f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102d62:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102d67:	68 a0 26 11 80       	push   $0x801126a0
80102d6c:	e8 ff 17 00 00       	call   80104570 <release>
      break;
    }
  }
}
80102d71:	83 c4 10             	add    $0x10,%esp
80102d74:	c9                   	leave  
80102d75:	c3                   	ret    
80102d76:	8d 76 00             	lea    0x0(%esi),%esi
80102d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d80 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102d80:	55                   	push   %ebp
80102d81:	89 e5                	mov    %esp,%ebp
80102d83:	57                   	push   %edi
80102d84:	56                   	push   %esi
80102d85:	53                   	push   %ebx
80102d86:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102d89:	68 a0 26 11 80       	push   $0x801126a0
80102d8e:	e8 1d 17 00 00       	call   801044b0 <acquire>
  log.outstanding -= 1;
80102d93:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102d98:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
80102d9e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102da1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102da4:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102da6:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
80102dac:	0f 85 1a 01 00 00    	jne    80102ecc <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102db2:	85 db                	test   %ebx,%ebx
80102db4:	0f 85 ee 00 00 00    	jne    80102ea8 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102dba:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102dbd:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102dc4:	00 00 00 
  release(&log.lock);
80102dc7:	68 a0 26 11 80       	push   $0x801126a0
80102dcc:	e8 9f 17 00 00       	call   80104570 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102dd1:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102dd7:	83 c4 10             	add    $0x10,%esp
80102dda:	85 c9                	test   %ecx,%ecx
80102ddc:	0f 8e 85 00 00 00    	jle    80102e67 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102de2:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102de7:	83 ec 08             	sub    $0x8,%esp
80102dea:	01 d8                	add    %ebx,%eax
80102dec:	83 c0 01             	add    $0x1,%eax
80102def:	50                   	push   %eax
80102df0:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102df6:	e8 d5 d2 ff ff       	call   801000d0 <bread>
80102dfb:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102dfd:	58                   	pop    %eax
80102dfe:	5a                   	pop    %edx
80102dff:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102e06:	ff 35 e4 26 11 80    	pushl  0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102e0c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e0f:	e8 bc d2 ff ff       	call   801000d0 <bread>
80102e14:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102e16:	8d 40 5c             	lea    0x5c(%eax),%eax
80102e19:	83 c4 0c             	add    $0xc,%esp
80102e1c:	68 00 02 00 00       	push   $0x200
80102e21:	50                   	push   %eax
80102e22:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e25:	50                   	push   %eax
80102e26:	e8 45 18 00 00       	call   80104670 <memmove>
    bwrite(to);  // write the log
80102e2b:	89 34 24             	mov    %esi,(%esp)
80102e2e:	e8 6d d3 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102e33:	89 3c 24             	mov    %edi,(%esp)
80102e36:	e8 a5 d3 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102e3b:	89 34 24             	mov    %esi,(%esp)
80102e3e:	e8 9d d3 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102e43:	83 c4 10             	add    $0x10,%esp
80102e46:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102e4c:	7c 94                	jl     80102de2 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102e4e:	e8 bd fd ff ff       	call   80102c10 <write_head>
    install_trans(); // Now install writes to home locations
80102e53:	e8 18 fd ff ff       	call   80102b70 <install_trans>
    log.lh.n = 0;
80102e58:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102e5f:	00 00 00 
    write_head();    // Erase the transaction from the log
80102e62:	e8 a9 fd ff ff       	call   80102c10 <write_head>
    acquire(&log.lock);
80102e67:	83 ec 0c             	sub    $0xc,%esp
80102e6a:	68 a0 26 11 80       	push   $0x801126a0
80102e6f:	e8 3c 16 00 00       	call   801044b0 <acquire>
    wakeup(&log);
80102e74:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
80102e7b:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102e82:	00 00 00 
    wakeup(&log);
80102e85:	e8 16 12 00 00       	call   801040a0 <wakeup>
    release(&log.lock);
80102e8a:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e91:	e8 da 16 00 00       	call   80104570 <release>
80102e96:	83 c4 10             	add    $0x10,%esp
}
80102e99:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e9c:	5b                   	pop    %ebx
80102e9d:	5e                   	pop    %esi
80102e9e:	5f                   	pop    %edi
80102e9f:	5d                   	pop    %ebp
80102ea0:	c3                   	ret    
80102ea1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102ea8:	83 ec 0c             	sub    $0xc,%esp
80102eab:	68 a0 26 11 80       	push   $0x801126a0
80102eb0:	e8 eb 11 00 00       	call   801040a0 <wakeup>
  release(&log.lock);
80102eb5:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102ebc:	e8 af 16 00 00       	call   80104570 <release>
80102ec1:	83 c4 10             	add    $0x10,%esp
}
80102ec4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ec7:	5b                   	pop    %ebx
80102ec8:	5e                   	pop    %esi
80102ec9:	5f                   	pop    %edi
80102eca:	5d                   	pop    %ebp
80102ecb:	c3                   	ret    
    panic("log.committing");
80102ecc:	83 ec 0c             	sub    $0xc,%esp
80102ecf:	68 24 75 10 80       	push   $0x80107524
80102ed4:	e8 77 d5 ff ff       	call   80100450 <panic>
80102ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ee0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102ee0:	55                   	push   %ebp
80102ee1:	89 e5                	mov    %esp,%ebp
80102ee3:	53                   	push   %ebx
80102ee4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ee7:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
80102eed:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ef0:	83 fa 1d             	cmp    $0x1d,%edx
80102ef3:	0f 8f 9d 00 00 00    	jg     80102f96 <log_write+0xb6>
80102ef9:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102efe:	83 e8 01             	sub    $0x1,%eax
80102f01:	39 c2                	cmp    %eax,%edx
80102f03:	0f 8d 8d 00 00 00    	jge    80102f96 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f09:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102f0e:	85 c0                	test   %eax,%eax
80102f10:	0f 8e 8d 00 00 00    	jle    80102fa3 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f16:	83 ec 0c             	sub    $0xc,%esp
80102f19:	68 a0 26 11 80       	push   $0x801126a0
80102f1e:	e8 8d 15 00 00       	call   801044b0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102f23:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102f29:	83 c4 10             	add    $0x10,%esp
80102f2c:	83 f9 00             	cmp    $0x0,%ecx
80102f2f:	7e 57                	jle    80102f88 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f31:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102f34:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f36:	3b 15 ec 26 11 80    	cmp    0x801126ec,%edx
80102f3c:	75 0b                	jne    80102f49 <log_write+0x69>
80102f3e:	eb 38                	jmp    80102f78 <log_write+0x98>
80102f40:	39 14 85 ec 26 11 80 	cmp    %edx,-0x7feed914(,%eax,4)
80102f47:	74 2f                	je     80102f78 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102f49:	83 c0 01             	add    $0x1,%eax
80102f4c:	39 c1                	cmp    %eax,%ecx
80102f4e:	75 f0                	jne    80102f40 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102f50:	89 14 85 ec 26 11 80 	mov    %edx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102f57:	83 c0 01             	add    $0x1,%eax
80102f5a:	a3 e8 26 11 80       	mov    %eax,0x801126e8
  b->flags |= B_DIRTY; // prevent eviction
80102f5f:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102f62:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102f69:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f6c:	c9                   	leave  
  release(&log.lock);
80102f6d:	e9 fe 15 00 00       	jmp    80104570 <release>
80102f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102f78:	89 14 85 ec 26 11 80 	mov    %edx,-0x7feed914(,%eax,4)
80102f7f:	eb de                	jmp    80102f5f <log_write+0x7f>
80102f81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f88:	8b 43 08             	mov    0x8(%ebx),%eax
80102f8b:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
80102f90:	75 cd                	jne    80102f5f <log_write+0x7f>
80102f92:	31 c0                	xor    %eax,%eax
80102f94:	eb c1                	jmp    80102f57 <log_write+0x77>
    panic("too big a transaction");
80102f96:	83 ec 0c             	sub    $0xc,%esp
80102f99:	68 33 75 10 80       	push   $0x80107533
80102f9e:	e8 ad d4 ff ff       	call   80100450 <panic>
    panic("log_write outside of trans");
80102fa3:	83 ec 0c             	sub    $0xc,%esp
80102fa6:	68 49 75 10 80       	push   $0x80107549
80102fab:	e8 a0 d4 ff ff       	call   80100450 <panic>

80102fb0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102fb0:	55                   	push   %ebp
80102fb1:	89 e5                	mov    %esp,%ebp
80102fb3:	53                   	push   %ebx
80102fb4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102fb7:	e8 74 09 00 00       	call   80103930 <cpuid>
80102fbc:	89 c3                	mov    %eax,%ebx
80102fbe:	e8 6d 09 00 00       	call   80103930 <cpuid>
80102fc3:	83 ec 04             	sub    $0x4,%esp
80102fc6:	53                   	push   %ebx
80102fc7:	50                   	push   %eax
80102fc8:	68 64 75 10 80       	push   $0x80107564
80102fcd:	e8 4e d7 ff ff       	call   80100720 <cprintf>
  idtinit();       // load idt register
80102fd2:	e8 b9 28 00 00       	call   80105890 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102fd7:	e8 d4 08 00 00       	call   801038b0 <mycpu>
80102fdc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102fde:	b8 01 00 00 00       	mov    $0x1,%eax
80102fe3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102fea:	e8 21 0c 00 00       	call   80103c10 <scheduler>
80102fef:	90                   	nop

80102ff0 <mpenter>:
{
80102ff0:	55                   	push   %ebp
80102ff1:	89 e5                	mov    %esp,%ebp
80102ff3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102ff6:	e8 85 39 00 00       	call   80106980 <switchkvm>
  seginit();
80102ffb:	e8 f0 38 00 00       	call   801068f0 <seginit>
  lapicinit();
80103000:	e8 9b f7 ff ff       	call   801027a0 <lapicinit>
  mpmain();
80103005:	e8 a6 ff ff ff       	call   80102fb0 <mpmain>
8010300a:	66 90                	xchg   %ax,%ax
8010300c:	66 90                	xchg   %ax,%ax
8010300e:	66 90                	xchg   %ax,%ax

80103010 <main>:
{
80103010:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103014:	83 e4 f0             	and    $0xfffffff0,%esp
80103017:	ff 71 fc             	pushl  -0x4(%ecx)
8010301a:	55                   	push   %ebp
8010301b:	89 e5                	mov    %esp,%ebp
8010301d:	53                   	push   %ebx
8010301e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010301f:	83 ec 08             	sub    $0x8,%esp
80103022:	68 00 00 40 80       	push   $0x80400000
80103027:	68 c8 55 11 80       	push   $0x801155c8
8010302c:	e8 2f f5 ff ff       	call   80102560 <kinit1>
  kvmalloc();      // kernel page table
80103031:	e8 1a 3e 00 00       	call   80106e50 <kvmalloc>
  mpinit();        // detect other processors
80103036:	e8 75 01 00 00       	call   801031b0 <mpinit>
  lapicinit();     // interrupt controller
8010303b:	e8 60 f7 ff ff       	call   801027a0 <lapicinit>
  seginit();       // segment descriptors
80103040:	e8 ab 38 00 00       	call   801068f0 <seginit>
  picinit();       // disable pic
80103045:	e8 46 03 00 00       	call   80103390 <picinit>
  ioapicinit();    // another interrupt controller
8010304a:	e8 41 f3 ff ff       	call   80102390 <ioapicinit>
  consoleinit();   // console hardware
8010304f:	e8 2c da ff ff       	call   80100a80 <consoleinit>
  uartinit();      // serial port
80103054:	e8 67 2b 00 00       	call   80105bc0 <uartinit>
  pinit();         // process table
80103059:	e8 32 08 00 00       	call   80103890 <pinit>
  tvinit();        // trap vectors
8010305e:	e8 ad 27 00 00       	call   80105810 <tvinit>
  binit();         // buffer cache
80103063:	e8 d8 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103068:	e8 b3 dd ff ff       	call   80100e20 <fileinit>
  ideinit();       // disk 
8010306d:	e8 fe f0 ff ff       	call   80102170 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_kernel_entryother_start, (uint)_binary_kernel_entryother_size);
80103072:	83 c4 0c             	add    $0xc,%esp
80103075:	68 8a 00 00 00       	push   $0x8a
8010307a:	68 8c a4 10 80       	push   $0x8010a48c
8010307f:	68 00 70 00 80       	push   $0x80007000
80103084:	e8 e7 15 00 00       	call   80104670 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103089:	69 05 20 2d 11 80 b0 	imul   $0xb0,0x80112d20,%eax
80103090:	00 00 00 
80103093:	83 c4 10             	add    $0x10,%esp
80103096:	05 a0 27 11 80       	add    $0x801127a0,%eax
8010309b:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
801030a0:	76 71                	jbe    80103113 <main+0x103>
801030a2:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
801030a7:	89 f6                	mov    %esi,%esi
801030a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
801030b0:	e8 fb 07 00 00       	call   801038b0 <mycpu>
801030b5:	39 d8                	cmp    %ebx,%eax
801030b7:	74 41                	je     801030fa <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801030b9:	e8 72 f5 ff ff       	call   80102630 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
801030be:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
801030c3:	c7 05 f8 6f 00 80 f0 	movl   $0x80102ff0,0x80006ff8
801030ca:	2f 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801030cd:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
801030d4:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801030d7:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
801030dc:	0f b6 03             	movzbl (%ebx),%eax
801030df:	83 ec 08             	sub    $0x8,%esp
801030e2:	68 00 70 00 00       	push   $0x7000
801030e7:	50                   	push   %eax
801030e8:	e8 03 f8 ff ff       	call   801028f0 <lapicstartap>
801030ed:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801030f0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801030f6:	85 c0                	test   %eax,%eax
801030f8:	74 f6                	je     801030f0 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
801030fa:	69 05 20 2d 11 80 b0 	imul   $0xb0,0x80112d20,%eax
80103101:	00 00 00 
80103104:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010310a:	05 a0 27 11 80       	add    $0x801127a0,%eax
8010310f:	39 c3                	cmp    %eax,%ebx
80103111:	72 9d                	jb     801030b0 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103113:	83 ec 08             	sub    $0x8,%esp
80103116:	68 00 00 00 8e       	push   $0x8e000000
8010311b:	68 00 00 40 80       	push   $0x80400000
80103120:	e8 ab f4 ff ff       	call   801025d0 <kinit2>
  userinit();      // first user process
80103125:	e8 56 08 00 00       	call   80103980 <userinit>
  mpmain();        // finish this processor's setup
8010312a:	e8 81 fe ff ff       	call   80102fb0 <mpmain>
8010312f:	90                   	nop

80103130 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103130:	55                   	push   %ebp
80103131:	89 e5                	mov    %esp,%ebp
80103133:	57                   	push   %edi
80103134:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103135:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010313b:	53                   	push   %ebx
  e = addr+len;
8010313c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010313f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103142:	39 de                	cmp    %ebx,%esi
80103144:	72 10                	jb     80103156 <mpsearch1+0x26>
80103146:	eb 50                	jmp    80103198 <mpsearch1+0x68>
80103148:	90                   	nop
80103149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103150:	39 fb                	cmp    %edi,%ebx
80103152:	89 fe                	mov    %edi,%esi
80103154:	76 42                	jbe    80103198 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103156:	83 ec 04             	sub    $0x4,%esp
80103159:	8d 7e 10             	lea    0x10(%esi),%edi
8010315c:	6a 04                	push   $0x4
8010315e:	68 78 75 10 80       	push   $0x80107578
80103163:	56                   	push   %esi
80103164:	e8 a7 14 00 00       	call   80104610 <memcmp>
80103169:	83 c4 10             	add    $0x10,%esp
8010316c:	85 c0                	test   %eax,%eax
8010316e:	75 e0                	jne    80103150 <mpsearch1+0x20>
80103170:	89 f1                	mov    %esi,%ecx
80103172:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103178:	0f b6 11             	movzbl (%ecx),%edx
8010317b:	83 c1 01             	add    $0x1,%ecx
8010317e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103180:	39 f9                	cmp    %edi,%ecx
80103182:	75 f4                	jne    80103178 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103184:	84 c0                	test   %al,%al
80103186:	75 c8                	jne    80103150 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103188:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010318b:	89 f0                	mov    %esi,%eax
8010318d:	5b                   	pop    %ebx
8010318e:	5e                   	pop    %esi
8010318f:	5f                   	pop    %edi
80103190:	5d                   	pop    %ebp
80103191:	c3                   	ret    
80103192:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103198:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010319b:	31 f6                	xor    %esi,%esi
}
8010319d:	89 f0                	mov    %esi,%eax
8010319f:	5b                   	pop    %ebx
801031a0:	5e                   	pop    %esi
801031a1:	5f                   	pop    %edi
801031a2:	5d                   	pop    %ebp
801031a3:	c3                   	ret    
801031a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801031aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801031b0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801031b0:	55                   	push   %ebp
801031b1:	89 e5                	mov    %esp,%ebp
801031b3:	57                   	push   %edi
801031b4:	56                   	push   %esi
801031b5:	53                   	push   %ebx
801031b6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801031b9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801031c0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801031c7:	c1 e0 08             	shl    $0x8,%eax
801031ca:	09 d0                	or     %edx,%eax
801031cc:	c1 e0 04             	shl    $0x4,%eax
801031cf:	85 c0                	test   %eax,%eax
801031d1:	75 1b                	jne    801031ee <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801031d3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801031da:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801031e1:	c1 e0 08             	shl    $0x8,%eax
801031e4:	09 d0                	or     %edx,%eax
801031e6:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801031e9:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801031ee:	ba 00 04 00 00       	mov    $0x400,%edx
801031f3:	e8 38 ff ff ff       	call   80103130 <mpsearch1>
801031f8:	85 c0                	test   %eax,%eax
801031fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801031fd:	0f 84 3d 01 00 00    	je     80103340 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103203:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103206:	8b 58 04             	mov    0x4(%eax),%ebx
80103209:	85 db                	test   %ebx,%ebx
8010320b:	0f 84 4f 01 00 00    	je     80103360 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103211:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103217:	83 ec 04             	sub    $0x4,%esp
8010321a:	6a 04                	push   $0x4
8010321c:	68 95 75 10 80       	push   $0x80107595
80103221:	56                   	push   %esi
80103222:	e8 e9 13 00 00       	call   80104610 <memcmp>
80103227:	83 c4 10             	add    $0x10,%esp
8010322a:	85 c0                	test   %eax,%eax
8010322c:	0f 85 2e 01 00 00    	jne    80103360 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
80103232:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103239:	3c 01                	cmp    $0x1,%al
8010323b:	0f 95 c2             	setne  %dl
8010323e:	3c 04                	cmp    $0x4,%al
80103240:	0f 95 c0             	setne  %al
80103243:	20 c2                	and    %al,%dl
80103245:	0f 85 15 01 00 00    	jne    80103360 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
8010324b:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
80103252:	66 85 ff             	test   %di,%di
80103255:	74 1a                	je     80103271 <mpinit+0xc1>
80103257:	89 f0                	mov    %esi,%eax
80103259:	01 f7                	add    %esi,%edi
  sum = 0;
8010325b:	31 d2                	xor    %edx,%edx
8010325d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103260:	0f b6 08             	movzbl (%eax),%ecx
80103263:	83 c0 01             	add    $0x1,%eax
80103266:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103268:	39 c7                	cmp    %eax,%edi
8010326a:	75 f4                	jne    80103260 <mpinit+0xb0>
8010326c:	84 d2                	test   %dl,%dl
8010326e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103271:	85 f6                	test   %esi,%esi
80103273:	0f 84 e7 00 00 00    	je     80103360 <mpinit+0x1b0>
80103279:	84 d2                	test   %dl,%dl
8010327b:	0f 85 df 00 00 00    	jne    80103360 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103281:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103287:	a3 9c 26 11 80       	mov    %eax,0x8011269c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010328c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103293:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103299:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010329e:	01 d6                	add    %edx,%esi
801032a0:	39 c6                	cmp    %eax,%esi
801032a2:	76 23                	jbe    801032c7 <mpinit+0x117>
    switch(*p){
801032a4:	0f b6 10             	movzbl (%eax),%edx
801032a7:	80 fa 04             	cmp    $0x4,%dl
801032aa:	0f 87 ca 00 00 00    	ja     8010337a <mpinit+0x1ca>
801032b0:	ff 24 95 bc 75 10 80 	jmp    *-0x7fef8a44(,%edx,4)
801032b7:	89 f6                	mov    %esi,%esi
801032b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801032c0:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032c3:	39 c6                	cmp    %eax,%esi
801032c5:	77 dd                	ja     801032a4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801032c7:	85 db                	test   %ebx,%ebx
801032c9:	0f 84 9e 00 00 00    	je     8010336d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801032cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801032d2:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
801032d6:	74 15                	je     801032ed <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032d8:	b8 70 00 00 00       	mov    $0x70,%eax
801032dd:	ba 22 00 00 00       	mov    $0x22,%edx
801032e2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032e3:	ba 23 00 00 00       	mov    $0x23,%edx
801032e8:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801032e9:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032ec:	ee                   	out    %al,(%dx)
  }
}
801032ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032f0:	5b                   	pop    %ebx
801032f1:	5e                   	pop    %esi
801032f2:	5f                   	pop    %edi
801032f3:	5d                   	pop    %ebp
801032f4:	c3                   	ret    
801032f5:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
801032f8:	8b 0d 20 2d 11 80    	mov    0x80112d20,%ecx
801032fe:	83 f9 07             	cmp    $0x7,%ecx
80103301:	7f 19                	jg     8010331c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103303:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103307:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010330d:	83 c1 01             	add    $0x1,%ecx
80103310:	89 0d 20 2d 11 80    	mov    %ecx,0x80112d20
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103316:	88 97 a0 27 11 80    	mov    %dl,-0x7feed860(%edi)
      p += sizeof(struct mpproc);
8010331c:	83 c0 14             	add    $0x14,%eax
      continue;
8010331f:	e9 7c ff ff ff       	jmp    801032a0 <mpinit+0xf0>
80103324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103328:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010332c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010332f:	88 15 80 27 11 80    	mov    %dl,0x80112780
      continue;
80103335:	e9 66 ff ff ff       	jmp    801032a0 <mpinit+0xf0>
8010333a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
80103340:	ba 00 00 01 00       	mov    $0x10000,%edx
80103345:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010334a:	e8 e1 fd ff ff       	call   80103130 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010334f:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103351:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103354:	0f 85 a9 fe ff ff    	jne    80103203 <mpinit+0x53>
8010335a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103360:	83 ec 0c             	sub    $0xc,%esp
80103363:	68 7d 75 10 80       	push   $0x8010757d
80103368:	e8 e3 d0 ff ff       	call   80100450 <panic>
    panic("Didn't find a suitable machine");
8010336d:	83 ec 0c             	sub    $0xc,%esp
80103370:	68 9c 75 10 80       	push   $0x8010759c
80103375:	e8 d6 d0 ff ff       	call   80100450 <panic>
      ismp = 0;
8010337a:	31 db                	xor    %ebx,%ebx
8010337c:	e9 26 ff ff ff       	jmp    801032a7 <mpinit+0xf7>
80103381:	66 90                	xchg   %ax,%ax
80103383:	66 90                	xchg   %ax,%ax
80103385:	66 90                	xchg   %ax,%ax
80103387:	66 90                	xchg   %ax,%ax
80103389:	66 90                	xchg   %ax,%ax
8010338b:	66 90                	xchg   %ax,%ax
8010338d:	66 90                	xchg   %ax,%ax
8010338f:	90                   	nop

80103390 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103390:	55                   	push   %ebp
80103391:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103396:	ba 21 00 00 00       	mov    $0x21,%edx
8010339b:	89 e5                	mov    %esp,%ebp
8010339d:	ee                   	out    %al,(%dx)
8010339e:	ba a1 00 00 00       	mov    $0xa1,%edx
801033a3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801033a4:	5d                   	pop    %ebp
801033a5:	c3                   	ret    
801033a6:	66 90                	xchg   %ax,%ax
801033a8:	66 90                	xchg   %ax,%ax
801033aa:	66 90                	xchg   %ax,%ax
801033ac:	66 90                	xchg   %ax,%ax
801033ae:	66 90                	xchg   %ax,%ax

801033b0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801033b0:	55                   	push   %ebp
801033b1:	89 e5                	mov    %esp,%ebp
801033b3:	57                   	push   %edi
801033b4:	56                   	push   %esi
801033b5:	53                   	push   %ebx
801033b6:	83 ec 0c             	sub    $0xc,%esp
801033b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801033bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801033bf:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801033c5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801033cb:	e8 70 da ff ff       	call   80100e40 <filealloc>
801033d0:	85 c0                	test   %eax,%eax
801033d2:	89 03                	mov    %eax,(%ebx)
801033d4:	74 22                	je     801033f8 <pipealloc+0x48>
801033d6:	e8 65 da ff ff       	call   80100e40 <filealloc>
801033db:	85 c0                	test   %eax,%eax
801033dd:	89 06                	mov    %eax,(%esi)
801033df:	74 3f                	je     80103420 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801033e1:	e8 4a f2 ff ff       	call   80102630 <kalloc>
801033e6:	85 c0                	test   %eax,%eax
801033e8:	89 c7                	mov    %eax,%edi
801033ea:	75 54                	jne    80103440 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801033ec:	8b 03                	mov    (%ebx),%eax
801033ee:	85 c0                	test   %eax,%eax
801033f0:	75 34                	jne    80103426 <pipealloc+0x76>
801033f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
801033f8:	8b 06                	mov    (%esi),%eax
801033fa:	85 c0                	test   %eax,%eax
801033fc:	74 0c                	je     8010340a <pipealloc+0x5a>
    fileclose(*f1);
801033fe:	83 ec 0c             	sub    $0xc,%esp
80103401:	50                   	push   %eax
80103402:	e8 f9 da ff ff       	call   80100f00 <fileclose>
80103407:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010340a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010340d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103412:	5b                   	pop    %ebx
80103413:	5e                   	pop    %esi
80103414:	5f                   	pop    %edi
80103415:	5d                   	pop    %ebp
80103416:	c3                   	ret    
80103417:	89 f6                	mov    %esi,%esi
80103419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
80103420:	8b 03                	mov    (%ebx),%eax
80103422:	85 c0                	test   %eax,%eax
80103424:	74 e4                	je     8010340a <pipealloc+0x5a>
    fileclose(*f0);
80103426:	83 ec 0c             	sub    $0xc,%esp
80103429:	50                   	push   %eax
8010342a:	e8 d1 da ff ff       	call   80100f00 <fileclose>
  if(*f1)
8010342f:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
80103431:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103434:	85 c0                	test   %eax,%eax
80103436:	75 c6                	jne    801033fe <pipealloc+0x4e>
80103438:	eb d0                	jmp    8010340a <pipealloc+0x5a>
8010343a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
80103440:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
80103443:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010344a:	00 00 00 
  p->writeopen = 1;
8010344d:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103454:	00 00 00 
  p->nwrite = 0;
80103457:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010345e:	00 00 00 
  p->nread = 0;
80103461:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103468:	00 00 00 
  initlock(&p->lock, "pipe");
8010346b:	68 d0 75 10 80       	push   $0x801075d0
80103470:	50                   	push   %eax
80103471:	e8 fa 0e 00 00       	call   80104370 <initlock>
  (*f0)->type = FD_PIPE;
80103476:	8b 03                	mov    (%ebx),%eax
  return 0;
80103478:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010347b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103481:	8b 03                	mov    (%ebx),%eax
80103483:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103487:	8b 03                	mov    (%ebx),%eax
80103489:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010348d:	8b 03                	mov    (%ebx),%eax
8010348f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103492:	8b 06                	mov    (%esi),%eax
80103494:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010349a:	8b 06                	mov    (%esi),%eax
8010349c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801034a0:	8b 06                	mov    (%esi),%eax
801034a2:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801034a6:	8b 06                	mov    (%esi),%eax
801034a8:	89 78 0c             	mov    %edi,0xc(%eax)
}
801034ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801034ae:	31 c0                	xor    %eax,%eax
}
801034b0:	5b                   	pop    %ebx
801034b1:	5e                   	pop    %esi
801034b2:	5f                   	pop    %edi
801034b3:	5d                   	pop    %ebp
801034b4:	c3                   	ret    
801034b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801034b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801034c0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	56                   	push   %esi
801034c4:	53                   	push   %ebx
801034c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801034cb:	83 ec 0c             	sub    $0xc,%esp
801034ce:	53                   	push   %ebx
801034cf:	e8 dc 0f 00 00       	call   801044b0 <acquire>
  if(writable){
801034d4:	83 c4 10             	add    $0x10,%esp
801034d7:	85 f6                	test   %esi,%esi
801034d9:	74 45                	je     80103520 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801034db:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034e1:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
801034e4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801034eb:	00 00 00 
    wakeup(&p->nread);
801034ee:	50                   	push   %eax
801034ef:	e8 ac 0b 00 00       	call   801040a0 <wakeup>
801034f4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801034f7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801034fd:	85 d2                	test   %edx,%edx
801034ff:	75 0a                	jne    8010350b <pipeclose+0x4b>
80103501:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103507:	85 c0                	test   %eax,%eax
80103509:	74 35                	je     80103540 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010350b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010350e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103511:	5b                   	pop    %ebx
80103512:	5e                   	pop    %esi
80103513:	5d                   	pop    %ebp
    release(&p->lock);
80103514:	e9 57 10 00 00       	jmp    80104570 <release>
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103520:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103526:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103529:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103530:	00 00 00 
    wakeup(&p->nwrite);
80103533:	50                   	push   %eax
80103534:	e8 67 0b 00 00       	call   801040a0 <wakeup>
80103539:	83 c4 10             	add    $0x10,%esp
8010353c:	eb b9                	jmp    801034f7 <pipeclose+0x37>
8010353e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103540:	83 ec 0c             	sub    $0xc,%esp
80103543:	53                   	push   %ebx
80103544:	e8 27 10 00 00       	call   80104570 <release>
    kfree((char*)p);
80103549:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010354c:	83 c4 10             	add    $0x10,%esp
}
8010354f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103552:	5b                   	pop    %ebx
80103553:	5e                   	pop    %esi
80103554:	5d                   	pop    %ebp
    kfree((char*)p);
80103555:	e9 26 ef ff ff       	jmp    80102480 <kfree>
8010355a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103560 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103560:	55                   	push   %ebp
80103561:	89 e5                	mov    %esp,%ebp
80103563:	57                   	push   %edi
80103564:	56                   	push   %esi
80103565:	53                   	push   %ebx
80103566:	83 ec 28             	sub    $0x28,%esp
80103569:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010356c:	53                   	push   %ebx
8010356d:	e8 3e 0f 00 00       	call   801044b0 <acquire>
  for(i = 0; i < n; i++){
80103572:	8b 45 10             	mov    0x10(%ebp),%eax
80103575:	83 c4 10             	add    $0x10,%esp
80103578:	85 c0                	test   %eax,%eax
8010357a:	0f 8e c9 00 00 00    	jle    80103649 <pipewrite+0xe9>
80103580:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103583:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103589:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010358f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103592:	03 4d 10             	add    0x10(%ebp),%ecx
80103595:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103598:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010359e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801035a4:	39 d0                	cmp    %edx,%eax
801035a6:	75 71                	jne    80103619 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
801035a8:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801035ae:	85 c0                	test   %eax,%eax
801035b0:	74 4e                	je     80103600 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035b2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801035b8:	eb 3a                	jmp    801035f4 <pipewrite+0x94>
801035ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
801035c0:	83 ec 0c             	sub    $0xc,%esp
801035c3:	57                   	push   %edi
801035c4:	e8 d7 0a 00 00       	call   801040a0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035c9:	5a                   	pop    %edx
801035ca:	59                   	pop    %ecx
801035cb:	53                   	push   %ebx
801035cc:	56                   	push   %esi
801035cd:	e8 1e 09 00 00       	call   80103ef0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035d2:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801035d8:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801035de:	83 c4 10             	add    $0x10,%esp
801035e1:	05 00 02 00 00       	add    $0x200,%eax
801035e6:	39 c2                	cmp    %eax,%edx
801035e8:	75 36                	jne    80103620 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
801035ea:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801035f0:	85 c0                	test   %eax,%eax
801035f2:	74 0c                	je     80103600 <pipewrite+0xa0>
801035f4:	e8 57 03 00 00       	call   80103950 <myproc>
801035f9:	8b 40 24             	mov    0x24(%eax),%eax
801035fc:	85 c0                	test   %eax,%eax
801035fe:	74 c0                	je     801035c0 <pipewrite+0x60>
        release(&p->lock);
80103600:	83 ec 0c             	sub    $0xc,%esp
80103603:	53                   	push   %ebx
80103604:	e8 67 0f 00 00       	call   80104570 <release>
        return -1;
80103609:	83 c4 10             	add    $0x10,%esp
8010360c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103611:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103614:	5b                   	pop    %ebx
80103615:	5e                   	pop    %esi
80103616:	5f                   	pop    %edi
80103617:	5d                   	pop    %ebp
80103618:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103619:	89 c2                	mov    %eax,%edx
8010361b:	90                   	nop
8010361c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103620:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103623:	8d 42 01             	lea    0x1(%edx),%eax
80103626:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010362c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103632:	83 c6 01             	add    $0x1,%esi
80103635:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
80103639:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010363c:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010363f:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103643:	0f 85 4f ff ff ff    	jne    80103598 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103649:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010364f:	83 ec 0c             	sub    $0xc,%esp
80103652:	50                   	push   %eax
80103653:	e8 48 0a 00 00       	call   801040a0 <wakeup>
  release(&p->lock);
80103658:	89 1c 24             	mov    %ebx,(%esp)
8010365b:	e8 10 0f 00 00       	call   80104570 <release>
  return n;
80103660:	83 c4 10             	add    $0x10,%esp
80103663:	8b 45 10             	mov    0x10(%ebp),%eax
80103666:	eb a9                	jmp    80103611 <pipewrite+0xb1>
80103668:	90                   	nop
80103669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103670 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103670:	55                   	push   %ebp
80103671:	89 e5                	mov    %esp,%ebp
80103673:	57                   	push   %edi
80103674:	56                   	push   %esi
80103675:	53                   	push   %ebx
80103676:	83 ec 18             	sub    $0x18,%esp
80103679:	8b 75 08             	mov    0x8(%ebp),%esi
8010367c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010367f:	56                   	push   %esi
80103680:	e8 2b 0e 00 00       	call   801044b0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103685:	83 c4 10             	add    $0x10,%esp
80103688:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010368e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103694:	75 6a                	jne    80103700 <piperead+0x90>
80103696:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010369c:	85 db                	test   %ebx,%ebx
8010369e:	0f 84 c4 00 00 00    	je     80103768 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801036a4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801036aa:	eb 2d                	jmp    801036d9 <piperead+0x69>
801036ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036b0:	83 ec 08             	sub    $0x8,%esp
801036b3:	56                   	push   %esi
801036b4:	53                   	push   %ebx
801036b5:	e8 36 08 00 00       	call   80103ef0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036ba:	83 c4 10             	add    $0x10,%esp
801036bd:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801036c3:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801036c9:	75 35                	jne    80103700 <piperead+0x90>
801036cb:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801036d1:	85 d2                	test   %edx,%edx
801036d3:	0f 84 8f 00 00 00    	je     80103768 <piperead+0xf8>
    if(myproc()->killed){
801036d9:	e8 72 02 00 00       	call   80103950 <myproc>
801036de:	8b 48 24             	mov    0x24(%eax),%ecx
801036e1:	85 c9                	test   %ecx,%ecx
801036e3:	74 cb                	je     801036b0 <piperead+0x40>
      release(&p->lock);
801036e5:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801036e8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801036ed:	56                   	push   %esi
801036ee:	e8 7d 0e 00 00       	call   80104570 <release>
      return -1;
801036f3:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801036f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036f9:	89 d8                	mov    %ebx,%eax
801036fb:	5b                   	pop    %ebx
801036fc:	5e                   	pop    %esi
801036fd:	5f                   	pop    %edi
801036fe:	5d                   	pop    %ebp
801036ff:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103700:	8b 45 10             	mov    0x10(%ebp),%eax
80103703:	85 c0                	test   %eax,%eax
80103705:	7e 61                	jle    80103768 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103707:	31 db                	xor    %ebx,%ebx
80103709:	eb 13                	jmp    8010371e <piperead+0xae>
8010370b:	90                   	nop
8010370c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103710:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103716:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010371c:	74 1f                	je     8010373d <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010371e:	8d 41 01             	lea    0x1(%ecx),%eax
80103721:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103727:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010372d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103732:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103735:	83 c3 01             	add    $0x1,%ebx
80103738:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010373b:	75 d3                	jne    80103710 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010373d:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103743:	83 ec 0c             	sub    $0xc,%esp
80103746:	50                   	push   %eax
80103747:	e8 54 09 00 00       	call   801040a0 <wakeup>
  release(&p->lock);
8010374c:	89 34 24             	mov    %esi,(%esp)
8010374f:	e8 1c 0e 00 00       	call   80104570 <release>
  return i;
80103754:	83 c4 10             	add    $0x10,%esp
}
80103757:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010375a:	89 d8                	mov    %ebx,%eax
8010375c:	5b                   	pop    %ebx
8010375d:	5e                   	pop    %esi
8010375e:	5f                   	pop    %edi
8010375f:	5d                   	pop    %ebp
80103760:	c3                   	ret    
80103761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103768:	31 db                	xor    %ebx,%ebx
8010376a:	eb d1                	jmp    8010373d <piperead+0xcd>
8010376c:	66 90                	xchg   %ax,%ax
8010376e:	66 90                	xchg   %ax,%ax

80103770 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103774:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
{
80103779:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010377c:	68 40 2d 11 80       	push   $0x80112d40
80103781:	e8 2a 0d 00 00       	call   801044b0 <acquire>
80103786:	83 c4 10             	add    $0x10,%esp
80103789:	eb 10                	jmp    8010379b <allocproc+0x2b>
8010378b:	90                   	nop
8010378c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103790:	83 eb 80             	sub    $0xffffff80,%ebx
80103793:	81 fb 74 4d 11 80    	cmp    $0x80114d74,%ebx
80103799:	73 75                	jae    80103810 <allocproc+0xa0>
    if(p->state == UNUSED)
8010379b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010379e:	85 c0                	test   %eax,%eax
801037a0:	75 ee                	jne    80103790 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037a2:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
801037a7:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801037aa:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801037b1:	8d 50 01             	lea    0x1(%eax),%edx
801037b4:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
801037b7:	68 40 2d 11 80       	push   $0x80112d40
  p->pid = nextpid++;
801037bc:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
801037c2:	e8 a9 0d 00 00       	call   80104570 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801037c7:	e8 64 ee ff ff       	call   80102630 <kalloc>
801037cc:	83 c4 10             	add    $0x10,%esp
801037cf:	85 c0                	test   %eax,%eax
801037d1:	89 43 08             	mov    %eax,0x8(%ebx)
801037d4:	74 53                	je     80103829 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037d6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801037dc:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
801037df:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
801037e4:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801037e7:	c7 40 14 fb 57 10 80 	movl   $0x801057fb,0x14(%eax)
  p->context = (struct context*)sp;
801037ee:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801037f1:	6a 14                	push   $0x14
801037f3:	6a 00                	push   $0x0
801037f5:	50                   	push   %eax
801037f6:	e8 c5 0d 00 00       	call   801045c0 <memset>
  p->context->eip = (uint)forkret;
801037fb:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801037fe:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103801:	c7 40 10 40 38 10 80 	movl   $0x80103840,0x10(%eax)
}
80103808:	89 d8                	mov    %ebx,%eax
8010380a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010380d:	c9                   	leave  
8010380e:	c3                   	ret    
8010380f:	90                   	nop
  release(&ptable.lock);
80103810:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103813:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103815:	68 40 2d 11 80       	push   $0x80112d40
8010381a:	e8 51 0d 00 00       	call   80104570 <release>
}
8010381f:	89 d8                	mov    %ebx,%eax
  return 0;
80103821:	83 c4 10             	add    $0x10,%esp
}
80103824:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103827:	c9                   	leave  
80103828:	c3                   	ret    
    p->state = UNUSED;
80103829:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103830:	31 db                	xor    %ebx,%ebx
80103832:	eb d4                	jmp    80103808 <allocproc+0x98>
80103834:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010383a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103840 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103840:	55                   	push   %ebp
80103841:	89 e5                	mov    %esp,%ebp
80103843:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103846:	68 40 2d 11 80       	push   $0x80112d40
8010384b:	e8 20 0d 00 00       	call   80104570 <release>

  if (first) {
80103850:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103855:	83 c4 10             	add    $0x10,%esp
80103858:	85 c0                	test   %eax,%eax
8010385a:	75 04                	jne    80103860 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010385c:	c9                   	leave  
8010385d:	c3                   	ret    
8010385e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103860:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103863:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010386a:	00 00 00 
    iinit(ROOTDEV);
8010386d:	6a 01                	push   $0x1
8010386f:	e8 3c dd ff ff       	call   801015b0 <iinit>
    initlog(ROOTDEV);
80103874:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010387b:	e8 f0 f3 ff ff       	call   80102c70 <initlog>
80103880:	83 c4 10             	add    $0x10,%esp
}
80103883:	c9                   	leave  
80103884:	c3                   	ret    
80103885:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103890 <pinit>:
{
80103890:	55                   	push   %ebp
80103891:	89 e5                	mov    %esp,%ebp
80103893:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103896:	68 d5 75 10 80       	push   $0x801075d5
8010389b:	68 40 2d 11 80       	push   $0x80112d40
801038a0:	e8 cb 0a 00 00       	call   80104370 <initlock>
}
801038a5:	83 c4 10             	add    $0x10,%esp
801038a8:	c9                   	leave  
801038a9:	c3                   	ret    
801038aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801038b0 <mycpu>:
{
801038b0:	55                   	push   %ebp
801038b1:	89 e5                	mov    %esp,%ebp
801038b3:	56                   	push   %esi
801038b4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801038b5:	9c                   	pushf  
801038b6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801038b7:	f6 c4 02             	test   $0x2,%ah
801038ba:	75 5e                	jne    8010391a <mycpu+0x6a>
  apicid = lapicid();
801038bc:	e8 df ef ff ff       	call   801028a0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801038c1:	8b 35 20 2d 11 80    	mov    0x80112d20,%esi
801038c7:	85 f6                	test   %esi,%esi
801038c9:	7e 42                	jle    8010390d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801038cb:	0f b6 15 a0 27 11 80 	movzbl 0x801127a0,%edx
801038d2:	39 d0                	cmp    %edx,%eax
801038d4:	74 30                	je     80103906 <mycpu+0x56>
801038d6:	b9 50 28 11 80       	mov    $0x80112850,%ecx
  for (i = 0; i < ncpu; ++i) {
801038db:	31 d2                	xor    %edx,%edx
801038dd:	8d 76 00             	lea    0x0(%esi),%esi
801038e0:	83 c2 01             	add    $0x1,%edx
801038e3:	39 f2                	cmp    %esi,%edx
801038e5:	74 26                	je     8010390d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801038e7:	0f b6 19             	movzbl (%ecx),%ebx
801038ea:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801038f0:	39 c3                	cmp    %eax,%ebx
801038f2:	75 ec                	jne    801038e0 <mycpu+0x30>
801038f4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
801038fa:	05 a0 27 11 80       	add    $0x801127a0,%eax
}
801038ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103902:	5b                   	pop    %ebx
80103903:	5e                   	pop    %esi
80103904:	5d                   	pop    %ebp
80103905:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103906:	b8 a0 27 11 80       	mov    $0x801127a0,%eax
      return &cpus[i];
8010390b:	eb f2                	jmp    801038ff <mycpu+0x4f>
  panic("unknown apicid\n");
8010390d:	83 ec 0c             	sub    $0xc,%esp
80103910:	68 dc 75 10 80       	push   $0x801075dc
80103915:	e8 36 cb ff ff       	call   80100450 <panic>
    panic("mycpu called with interrupts enabled\n");
8010391a:	83 ec 0c             	sub    $0xc,%esp
8010391d:	68 b8 76 10 80       	push   $0x801076b8
80103922:	e8 29 cb ff ff       	call   80100450 <panic>
80103927:	89 f6                	mov    %esi,%esi
80103929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103930 <cpuid>:
cpuid() {
80103930:	55                   	push   %ebp
80103931:	89 e5                	mov    %esp,%ebp
80103933:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103936:	e8 75 ff ff ff       	call   801038b0 <mycpu>
8010393b:	2d a0 27 11 80       	sub    $0x801127a0,%eax
}
80103940:	c9                   	leave  
  return mycpu()-cpus;
80103941:	c1 f8 04             	sar    $0x4,%eax
80103944:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010394a:	c3                   	ret    
8010394b:	90                   	nop
8010394c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103950 <myproc>:
myproc(void) {
80103950:	55                   	push   %ebp
80103951:	89 e5                	mov    %esp,%ebp
80103953:	53                   	push   %ebx
80103954:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103957:	e8 84 0a 00 00       	call   801043e0 <pushcli>
  c = mycpu();
8010395c:	e8 4f ff ff ff       	call   801038b0 <mycpu>
  p = c->proc;
80103961:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103967:	e8 b4 0a 00 00       	call   80104420 <popcli>
}
8010396c:	83 c4 04             	add    $0x4,%esp
8010396f:	89 d8                	mov    %ebx,%eax
80103971:	5b                   	pop    %ebx
80103972:	5d                   	pop    %ebp
80103973:	c3                   	ret    
80103974:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010397a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103980 <userinit>:
{
80103980:	55                   	push   %ebp
80103981:	89 e5                	mov    %esp,%ebp
80103983:	53                   	push   %ebx
80103984:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103987:	e8 e4 fd ff ff       	call   80103770 <allocproc>
8010398c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010398e:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
80103993:	e8 38 34 00 00       	call   80106dd0 <setupkvm>
80103998:	85 c0                	test   %eax,%eax
8010399a:	89 43 04             	mov    %eax,0x4(%ebx)
8010399d:	0f 84 bd 00 00 00    	je     80103a60 <userinit+0xe0>
  inituvm(p->pgdir, _binary_user_initcode_start, (int)_binary_user_initcode_size);
801039a3:	83 ec 04             	sub    $0x4,%esp
801039a6:	68 2c 00 00 00       	push   $0x2c
801039ab:	68 60 a4 10 80       	push   $0x8010a460
801039b0:	50                   	push   %eax
801039b1:	e8 fa 30 00 00       	call   80106ab0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801039b6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801039b9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801039bf:	6a 4c                	push   $0x4c
801039c1:	6a 00                	push   $0x0
801039c3:	ff 73 18             	pushl  0x18(%ebx)
801039c6:	e8 f5 0b 00 00       	call   801045c0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039cb:	8b 43 18             	mov    0x18(%ebx),%eax
801039ce:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039d3:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801039d8:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039db:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039df:	8b 43 18             	mov    0x18(%ebx),%eax
801039e2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801039e6:	8b 43 18             	mov    0x18(%ebx),%eax
801039e9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039ed:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801039f1:	8b 43 18             	mov    0x18(%ebx),%eax
801039f4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039f8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801039fc:	8b 43 18             	mov    0x18(%ebx),%eax
801039ff:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103a06:	8b 43 18             	mov    0x18(%ebx),%eax
80103a09:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a10:	8b 43 18             	mov    0x18(%ebx),%eax
80103a13:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a1a:	8d 43 70             	lea    0x70(%ebx),%eax
80103a1d:	6a 10                	push   $0x10
80103a1f:	68 05 76 10 80       	push   $0x80107605
80103a24:	50                   	push   %eax
80103a25:	e8 76 0d 00 00       	call   801047a0 <safestrcpy>
  p->cwd = namei("/");
80103a2a:	c7 04 24 0e 76 10 80 	movl   $0x8010760e,(%esp)
80103a31:	e8 1a e6 ff ff       	call   80102050 <namei>
80103a36:	89 43 6c             	mov    %eax,0x6c(%ebx)
  acquire(&ptable.lock);
80103a39:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103a40:	e8 6b 0a 00 00       	call   801044b0 <acquire>
  p->state = RUNNABLE;
80103a45:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103a4c:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103a53:	e8 18 0b 00 00       	call   80104570 <release>
}
80103a58:	83 c4 10             	add    $0x10,%esp
80103a5b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a5e:	c9                   	leave  
80103a5f:	c3                   	ret    
    panic("userinit: out of memory?");
80103a60:	83 ec 0c             	sub    $0xc,%esp
80103a63:	68 ec 75 10 80       	push   $0x801075ec
80103a68:	e8 e3 c9 ff ff       	call   80100450 <panic>
80103a6d:	8d 76 00             	lea    0x0(%esi),%esi

80103a70 <growproc>:
{
80103a70:	55                   	push   %ebp
80103a71:	89 e5                	mov    %esp,%ebp
80103a73:	56                   	push   %esi
80103a74:	53                   	push   %ebx
80103a75:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103a78:	e8 63 09 00 00       	call   801043e0 <pushcli>
  c = mycpu();
80103a7d:	e8 2e fe ff ff       	call   801038b0 <mycpu>
  p = c->proc;
80103a82:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a88:	e8 93 09 00 00       	call   80104420 <popcli>
  if(n > 0){
80103a8d:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103a90:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103a92:	7f 1c                	jg     80103ab0 <growproc+0x40>
  } else if(n < 0){
80103a94:	75 3a                	jne    80103ad0 <growproc+0x60>
  switchuvm(curproc);
80103a96:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103a99:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103a9b:	53                   	push   %ebx
80103a9c:	e8 ff 2e 00 00       	call   801069a0 <switchuvm>
  return 0;
80103aa1:	83 c4 10             	add    $0x10,%esp
80103aa4:	31 c0                	xor    %eax,%eax
}
80103aa6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103aa9:	5b                   	pop    %ebx
80103aaa:	5e                   	pop    %esi
80103aab:	5d                   	pop    %ebp
80103aac:	c3                   	ret    
80103aad:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ab0:	83 ec 04             	sub    $0x4,%esp
80103ab3:	01 c6                	add    %eax,%esi
80103ab5:	56                   	push   %esi
80103ab6:	50                   	push   %eax
80103ab7:	ff 73 04             	pushl  0x4(%ebx)
80103aba:	e8 31 31 00 00       	call   80106bf0 <allocuvm>
80103abf:	83 c4 10             	add    $0x10,%esp
80103ac2:	85 c0                	test   %eax,%eax
80103ac4:	75 d0                	jne    80103a96 <growproc+0x26>
      return -1;
80103ac6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103acb:	eb d9                	jmp    80103aa6 <growproc+0x36>
80103acd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ad0:	83 ec 04             	sub    $0x4,%esp
80103ad3:	01 c6                	add    %eax,%esi
80103ad5:	56                   	push   %esi
80103ad6:	50                   	push   %eax
80103ad7:	ff 73 04             	pushl  0x4(%ebx)
80103ada:	e8 41 32 00 00       	call   80106d20 <deallocuvm>
80103adf:	83 c4 10             	add    $0x10,%esp
80103ae2:	85 c0                	test   %eax,%eax
80103ae4:	75 b0                	jne    80103a96 <growproc+0x26>
80103ae6:	eb de                	jmp    80103ac6 <growproc+0x56>
80103ae8:	90                   	nop
80103ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103af0 <fork>:
{
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	57                   	push   %edi
80103af4:	56                   	push   %esi
80103af5:	53                   	push   %ebx
80103af6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103af9:	e8 e2 08 00 00       	call   801043e0 <pushcli>
  c = mycpu();
80103afe:	e8 ad fd ff ff       	call   801038b0 <mycpu>
  p = c->proc;
80103b03:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b09:	e8 12 09 00 00       	call   80104420 <popcli>
  if((np = allocproc()) == 0){
80103b0e:	e8 5d fc ff ff       	call   80103770 <allocproc>
80103b13:	85 c0                	test   %eax,%eax
80103b15:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b18:	0f 84 b7 00 00 00    	je     80103bd5 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b1e:	83 ec 08             	sub    $0x8,%esp
80103b21:	ff 33                	pushl  (%ebx)
80103b23:	ff 73 04             	pushl  0x4(%ebx)
80103b26:	89 c7                	mov    %eax,%edi
80103b28:	e8 73 33 00 00       	call   80106ea0 <copyuvm>
80103b2d:	83 c4 10             	add    $0x10,%esp
80103b30:	85 c0                	test   %eax,%eax
80103b32:	89 47 04             	mov    %eax,0x4(%edi)
80103b35:	0f 84 a1 00 00 00    	je     80103bdc <fork+0xec>
  np->sz = curproc->sz;
80103b3b:	8b 03                	mov    (%ebx),%eax
80103b3d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103b40:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103b42:	89 59 14             	mov    %ebx,0x14(%ecx)
80103b45:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
80103b47:	8b 79 18             	mov    0x18(%ecx),%edi
80103b4a:	8b 73 18             	mov    0x18(%ebx),%esi
80103b4d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103b52:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103b54:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103b56:	8b 40 18             	mov    0x18(%eax),%eax
80103b59:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103b60:	8b 44 b3 2c          	mov    0x2c(%ebx,%esi,4),%eax
80103b64:	85 c0                	test   %eax,%eax
80103b66:	74 13                	je     80103b7b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103b68:	83 ec 0c             	sub    $0xc,%esp
80103b6b:	50                   	push   %eax
80103b6c:	e8 3f d3 ff ff       	call   80100eb0 <filedup>
80103b71:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b74:	83 c4 10             	add    $0x10,%esp
80103b77:	89 44 b2 2c          	mov    %eax,0x2c(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103b7b:	83 c6 01             	add    $0x1,%esi
80103b7e:	83 fe 10             	cmp    $0x10,%esi
80103b81:	75 dd                	jne    80103b60 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103b83:	83 ec 0c             	sub    $0xc,%esp
80103b86:	ff 73 6c             	pushl  0x6c(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b89:	83 c3 70             	add    $0x70,%ebx
  np->cwd = idup(curproc->cwd);
80103b8c:	e8 ef db ff ff       	call   80101780 <idup>
80103b91:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b94:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103b97:	89 47 6c             	mov    %eax,0x6c(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b9a:	8d 47 70             	lea    0x70(%edi),%eax
80103b9d:	6a 10                	push   $0x10
80103b9f:	53                   	push   %ebx
80103ba0:	50                   	push   %eax
80103ba1:	e8 fa 0b 00 00       	call   801047a0 <safestrcpy>
  pid = np->pid;
80103ba6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103ba9:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103bb0:	e8 fb 08 00 00       	call   801044b0 <acquire>
  np->state = RUNNABLE;
80103bb5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103bbc:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103bc3:	e8 a8 09 00 00       	call   80104570 <release>
  return pid;
80103bc8:	83 c4 10             	add    $0x10,%esp
}
80103bcb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bce:	89 d8                	mov    %ebx,%eax
80103bd0:	5b                   	pop    %ebx
80103bd1:	5e                   	pop    %esi
80103bd2:	5f                   	pop    %edi
80103bd3:	5d                   	pop    %ebp
80103bd4:	c3                   	ret    
    return -1;
80103bd5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103bda:	eb ef                	jmp    80103bcb <fork+0xdb>
    kfree(np->kstack);
80103bdc:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103bdf:	83 ec 0c             	sub    $0xc,%esp
80103be2:	ff 73 08             	pushl  0x8(%ebx)
80103be5:	e8 96 e8 ff ff       	call   80102480 <kfree>
    np->kstack = 0;
80103bea:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103bf1:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103bf8:	83 c4 10             	add    $0x10,%esp
80103bfb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103c00:	eb c9                	jmp    80103bcb <fork+0xdb>
80103c02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c10 <scheduler>:
{
80103c10:	55                   	push   %ebp
80103c11:	89 e5                	mov    %esp,%ebp
80103c13:	57                   	push   %edi
80103c14:	56                   	push   %esi
80103c15:	53                   	push   %ebx
80103c16:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103c19:	e8 92 fc ff ff       	call   801038b0 <mycpu>
80103c1e:	8d 78 04             	lea    0x4(%eax),%edi
80103c21:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103c23:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103c2a:	00 00 00 
80103c2d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103c30:	fb                   	sti    
    acquire(&ptable.lock);
80103c31:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c34:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
    acquire(&ptable.lock);
80103c39:	68 40 2d 11 80       	push   $0x80112d40
80103c3e:	e8 6d 08 00 00       	call   801044b0 <acquire>
80103c43:	83 c4 10             	add    $0x10,%esp
80103c46:	8d 76 00             	lea    0x0(%esi),%esi
80103c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
80103c50:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103c54:	75 33                	jne    80103c89 <scheduler+0x79>
      switchuvm(p);
80103c56:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103c59:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103c5f:	53                   	push   %ebx
80103c60:	e8 3b 2d 00 00       	call   801069a0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103c65:	58                   	pop    %eax
80103c66:	5a                   	pop    %edx
80103c67:	ff 73 1c             	pushl  0x1c(%ebx)
80103c6a:	57                   	push   %edi
      p->state = RUNNING;
80103c6b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103c72:	e8 84 0b 00 00       	call   801047fb <swtch>
      switchkvm();
80103c77:	e8 04 2d 00 00       	call   80106980 <switchkvm>
      c->proc = 0;
80103c7c:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103c83:	00 00 00 
80103c86:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c89:	83 eb 80             	sub    $0xffffff80,%ebx
80103c8c:	81 fb 74 4d 11 80    	cmp    $0x80114d74,%ebx
80103c92:	72 bc                	jb     80103c50 <scheduler+0x40>
    release(&ptable.lock);
80103c94:	83 ec 0c             	sub    $0xc,%esp
80103c97:	68 40 2d 11 80       	push   $0x80112d40
80103c9c:	e8 cf 08 00 00       	call   80104570 <release>
    sti();
80103ca1:	83 c4 10             	add    $0x10,%esp
80103ca4:	eb 8a                	jmp    80103c30 <scheduler+0x20>
80103ca6:	8d 76 00             	lea    0x0(%esi),%esi
80103ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103cb0 <sched>:
{
80103cb0:	55                   	push   %ebp
80103cb1:	89 e5                	mov    %esp,%ebp
80103cb3:	56                   	push   %esi
80103cb4:	53                   	push   %ebx
  pushcli();
80103cb5:	e8 26 07 00 00       	call   801043e0 <pushcli>
  c = mycpu();
80103cba:	e8 f1 fb ff ff       	call   801038b0 <mycpu>
  p = c->proc;
80103cbf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cc5:	e8 56 07 00 00       	call   80104420 <popcli>
  if(!holding(&ptable.lock))
80103cca:	83 ec 0c             	sub    $0xc,%esp
80103ccd:	68 40 2d 11 80       	push   $0x80112d40
80103cd2:	e8 a9 07 00 00       	call   80104480 <holding>
80103cd7:	83 c4 10             	add    $0x10,%esp
80103cda:	85 c0                	test   %eax,%eax
80103cdc:	74 4f                	je     80103d2d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103cde:	e8 cd fb ff ff       	call   801038b0 <mycpu>
80103ce3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103cea:	75 68                	jne    80103d54 <sched+0xa4>
  if(p->state == RUNNING)
80103cec:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103cf0:	74 55                	je     80103d47 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103cf2:	9c                   	pushf  
80103cf3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103cf4:	f6 c4 02             	test   $0x2,%ah
80103cf7:	75 41                	jne    80103d3a <sched+0x8a>
  intena = mycpu()->intena;
80103cf9:	e8 b2 fb ff ff       	call   801038b0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103cfe:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103d01:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103d07:	e8 a4 fb ff ff       	call   801038b0 <mycpu>
80103d0c:	83 ec 08             	sub    $0x8,%esp
80103d0f:	ff 70 04             	pushl  0x4(%eax)
80103d12:	53                   	push   %ebx
80103d13:	e8 e3 0a 00 00       	call   801047fb <swtch>
  mycpu()->intena = intena;
80103d18:	e8 93 fb ff ff       	call   801038b0 <mycpu>
}
80103d1d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103d20:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103d26:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d29:	5b                   	pop    %ebx
80103d2a:	5e                   	pop    %esi
80103d2b:	5d                   	pop    %ebp
80103d2c:	c3                   	ret    
    panic("sched ptable.lock");
80103d2d:	83 ec 0c             	sub    $0xc,%esp
80103d30:	68 10 76 10 80       	push   $0x80107610
80103d35:	e8 16 c7 ff ff       	call   80100450 <panic>
    panic("sched interruptible");
80103d3a:	83 ec 0c             	sub    $0xc,%esp
80103d3d:	68 3c 76 10 80       	push   $0x8010763c
80103d42:	e8 09 c7 ff ff       	call   80100450 <panic>
    panic("sched running");
80103d47:	83 ec 0c             	sub    $0xc,%esp
80103d4a:	68 2e 76 10 80       	push   $0x8010762e
80103d4f:	e8 fc c6 ff ff       	call   80100450 <panic>
    panic("sched locks");
80103d54:	83 ec 0c             	sub    $0xc,%esp
80103d57:	68 22 76 10 80       	push   $0x80107622
80103d5c:	e8 ef c6 ff ff       	call   80100450 <panic>
80103d61:	eb 0d                	jmp    80103d70 <exit>
80103d63:	90                   	nop
80103d64:	90                   	nop
80103d65:	90                   	nop
80103d66:	90                   	nop
80103d67:	90                   	nop
80103d68:	90                   	nop
80103d69:	90                   	nop
80103d6a:	90                   	nop
80103d6b:	90                   	nop
80103d6c:	90                   	nop
80103d6d:	90                   	nop
80103d6e:	90                   	nop
80103d6f:	90                   	nop

80103d70 <exit>:
{
80103d70:	55                   	push   %ebp
80103d71:	89 e5                	mov    %esp,%ebp
80103d73:	57                   	push   %edi
80103d74:	56                   	push   %esi
80103d75:	53                   	push   %ebx
80103d76:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103d79:	e8 62 06 00 00       	call   801043e0 <pushcli>
  c = mycpu();
80103d7e:	e8 2d fb ff ff       	call   801038b0 <mycpu>
  p = c->proc;
80103d83:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103d89:	e8 92 06 00 00       	call   80104420 <popcli>
  if(curproc == initproc)
80103d8e:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103d94:	8d 5e 2c             	lea    0x2c(%esi),%ebx
80103d97:	8d 7e 6c             	lea    0x6c(%esi),%edi
80103d9a:	0f 84 e7 00 00 00    	je     80103e87 <exit+0x117>
    if(curproc->ofile[fd]){
80103da0:	8b 03                	mov    (%ebx),%eax
80103da2:	85 c0                	test   %eax,%eax
80103da4:	74 12                	je     80103db8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103da6:	83 ec 0c             	sub    $0xc,%esp
80103da9:	50                   	push   %eax
80103daa:	e8 51 d1 ff ff       	call   80100f00 <fileclose>
      curproc->ofile[fd] = 0;
80103daf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103db5:	83 c4 10             	add    $0x10,%esp
80103db8:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103dbb:	39 fb                	cmp    %edi,%ebx
80103dbd:	75 e1                	jne    80103da0 <exit+0x30>
  begin_op();
80103dbf:	e8 4c ef ff ff       	call   80102d10 <begin_op>
  iput(curproc->cwd);
80103dc4:	83 ec 0c             	sub    $0xc,%esp
80103dc7:	ff 76 6c             	pushl  0x6c(%esi)
80103dca:	e8 11 db ff ff       	call   801018e0 <iput>
  end_op();
80103dcf:	e8 ac ef ff ff       	call   80102d80 <end_op>
  curproc->cwd = 0;
80103dd4:	c7 46 6c 00 00 00 00 	movl   $0x0,0x6c(%esi)
  acquire(&ptable.lock);
80103ddb:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103de2:	e8 c9 06 00 00       	call   801044b0 <acquire>
  wakeup1(curproc->parent);
80103de7:	8b 56 14             	mov    0x14(%esi),%edx
80103dea:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ded:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80103df2:	eb 0e                	jmp    80103e02 <exit+0x92>
80103df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103df8:	83 e8 80             	sub    $0xffffff80,%eax
80103dfb:	3d 74 4d 11 80       	cmp    $0x80114d74,%eax
80103e00:	73 1c                	jae    80103e1e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103e02:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e06:	75 f0                	jne    80103df8 <exit+0x88>
80103e08:	3b 50 20             	cmp    0x20(%eax),%edx
80103e0b:	75 eb                	jne    80103df8 <exit+0x88>
      p->state = RUNNABLE;
80103e0d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e14:	83 e8 80             	sub    $0xffffff80,%eax
80103e17:	3d 74 4d 11 80       	cmp    $0x80114d74,%eax
80103e1c:	72 e4                	jb     80103e02 <exit+0x92>
      p->parent = initproc;
80103e1e:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e24:	ba 74 2d 11 80       	mov    $0x80112d74,%edx
80103e29:	eb 10                	jmp    80103e3b <exit+0xcb>
80103e2b:	90                   	nop
80103e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e30:	83 ea 80             	sub    $0xffffff80,%edx
80103e33:	81 fa 74 4d 11 80    	cmp    $0x80114d74,%edx
80103e39:	73 33                	jae    80103e6e <exit+0xfe>
    if(p->parent == curproc){
80103e3b:	39 72 14             	cmp    %esi,0x14(%edx)
80103e3e:	75 f0                	jne    80103e30 <exit+0xc0>
      if(p->state == ZOMBIE)
80103e40:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103e44:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103e47:	75 e7                	jne    80103e30 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e49:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80103e4e:	eb 0a                	jmp    80103e5a <exit+0xea>
80103e50:	83 e8 80             	sub    $0xffffff80,%eax
80103e53:	3d 74 4d 11 80       	cmp    $0x80114d74,%eax
80103e58:	73 d6                	jae    80103e30 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103e5a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e5e:	75 f0                	jne    80103e50 <exit+0xe0>
80103e60:	3b 48 20             	cmp    0x20(%eax),%ecx
80103e63:	75 eb                	jne    80103e50 <exit+0xe0>
      p->state = RUNNABLE;
80103e65:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e6c:	eb e2                	jmp    80103e50 <exit+0xe0>
  curproc->state = ZOMBIE;
80103e6e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103e75:	e8 36 fe ff ff       	call   80103cb0 <sched>
  panic("zombie exit");
80103e7a:	83 ec 0c             	sub    $0xc,%esp
80103e7d:	68 5d 76 10 80       	push   $0x8010765d
80103e82:	e8 c9 c5 ff ff       	call   80100450 <panic>
    panic("init exiting");
80103e87:	83 ec 0c             	sub    $0xc,%esp
80103e8a:	68 50 76 10 80       	push   $0x80107650
80103e8f:	e8 bc c5 ff ff       	call   80100450 <panic>
80103e94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103ea0 <yield>:
{
80103ea0:	55                   	push   %ebp
80103ea1:	89 e5                	mov    %esp,%ebp
80103ea3:	53                   	push   %ebx
80103ea4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103ea7:	68 40 2d 11 80       	push   $0x80112d40
80103eac:	e8 ff 05 00 00       	call   801044b0 <acquire>
  pushcli();
80103eb1:	e8 2a 05 00 00       	call   801043e0 <pushcli>
  c = mycpu();
80103eb6:	e8 f5 f9 ff ff       	call   801038b0 <mycpu>
  p = c->proc;
80103ebb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ec1:	e8 5a 05 00 00       	call   80104420 <popcli>
  myproc()->state = RUNNABLE;
80103ec6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103ecd:	e8 de fd ff ff       	call   80103cb0 <sched>
  release(&ptable.lock);
80103ed2:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103ed9:	e8 92 06 00 00       	call   80104570 <release>
}
80103ede:	83 c4 10             	add    $0x10,%esp
80103ee1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ee4:	c9                   	leave  
80103ee5:	c3                   	ret    
80103ee6:	8d 76 00             	lea    0x0(%esi),%esi
80103ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ef0 <sleep>:
{
80103ef0:	55                   	push   %ebp
80103ef1:	89 e5                	mov    %esp,%ebp
80103ef3:	57                   	push   %edi
80103ef4:	56                   	push   %esi
80103ef5:	53                   	push   %ebx
80103ef6:	83 ec 0c             	sub    $0xc,%esp
80103ef9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103efc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103eff:	e8 dc 04 00 00       	call   801043e0 <pushcli>
  c = mycpu();
80103f04:	e8 a7 f9 ff ff       	call   801038b0 <mycpu>
  p = c->proc;
80103f09:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f0f:	e8 0c 05 00 00       	call   80104420 <popcli>
  if(p == 0)
80103f14:	85 db                	test   %ebx,%ebx
80103f16:	0f 84 87 00 00 00    	je     80103fa3 <sleep+0xb3>
  if(lk == 0)
80103f1c:	85 f6                	test   %esi,%esi
80103f1e:	74 76                	je     80103f96 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103f20:	81 fe 40 2d 11 80    	cmp    $0x80112d40,%esi
80103f26:	74 50                	je     80103f78 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103f28:	83 ec 0c             	sub    $0xc,%esp
80103f2b:	68 40 2d 11 80       	push   $0x80112d40
80103f30:	e8 7b 05 00 00       	call   801044b0 <acquire>
    release(lk);
80103f35:	89 34 24             	mov    %esi,(%esp)
80103f38:	e8 33 06 00 00       	call   80104570 <release>
  p->chan = chan;
80103f3d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f40:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f47:	e8 64 fd ff ff       	call   80103cb0 <sched>
  p->chan = 0;
80103f4c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103f53:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103f5a:	e8 11 06 00 00       	call   80104570 <release>
    acquire(lk);
80103f5f:	89 75 08             	mov    %esi,0x8(%ebp)
80103f62:	83 c4 10             	add    $0x10,%esp
}
80103f65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f68:	5b                   	pop    %ebx
80103f69:	5e                   	pop    %esi
80103f6a:	5f                   	pop    %edi
80103f6b:	5d                   	pop    %ebp
    acquire(lk);
80103f6c:	e9 3f 05 00 00       	jmp    801044b0 <acquire>
80103f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103f78:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f7b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f82:	e8 29 fd ff ff       	call   80103cb0 <sched>
  p->chan = 0;
80103f87:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103f8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f91:	5b                   	pop    %ebx
80103f92:	5e                   	pop    %esi
80103f93:	5f                   	pop    %edi
80103f94:	5d                   	pop    %ebp
80103f95:	c3                   	ret    
    panic("sleep without lk");
80103f96:	83 ec 0c             	sub    $0xc,%esp
80103f99:	68 6f 76 10 80       	push   $0x8010766f
80103f9e:	e8 ad c4 ff ff       	call   80100450 <panic>
    panic("sleep");
80103fa3:	83 ec 0c             	sub    $0xc,%esp
80103fa6:	68 69 76 10 80       	push   $0x80107669
80103fab:	e8 a0 c4 ff ff       	call   80100450 <panic>

80103fb0 <wait>:
{
80103fb0:	55                   	push   %ebp
80103fb1:	89 e5                	mov    %esp,%ebp
80103fb3:	56                   	push   %esi
80103fb4:	53                   	push   %ebx
  pushcli();
80103fb5:	e8 26 04 00 00       	call   801043e0 <pushcli>
  c = mycpu();
80103fba:	e8 f1 f8 ff ff       	call   801038b0 <mycpu>
  p = c->proc;
80103fbf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103fc5:	e8 56 04 00 00       	call   80104420 <popcli>
  acquire(&ptable.lock);
80103fca:	83 ec 0c             	sub    $0xc,%esp
80103fcd:	68 40 2d 11 80       	push   $0x80112d40
80103fd2:	e8 d9 04 00 00       	call   801044b0 <acquire>
80103fd7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103fda:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fdc:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
80103fe1:	eb 10                	jmp    80103ff3 <wait+0x43>
80103fe3:	90                   	nop
80103fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103fe8:	83 eb 80             	sub    $0xffffff80,%ebx
80103feb:	81 fb 74 4d 11 80    	cmp    $0x80114d74,%ebx
80103ff1:	73 1b                	jae    8010400e <wait+0x5e>
      if(p->parent != curproc)
80103ff3:	39 73 14             	cmp    %esi,0x14(%ebx)
80103ff6:	75 f0                	jne    80103fe8 <wait+0x38>
      if(p->state == ZOMBIE){
80103ff8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103ffc:	74 32                	je     80104030 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ffe:	83 eb 80             	sub    $0xffffff80,%ebx
      havekids = 1;
80104001:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104006:	81 fb 74 4d 11 80    	cmp    $0x80114d74,%ebx
8010400c:	72 e5                	jb     80103ff3 <wait+0x43>
    if(!havekids || curproc->killed){
8010400e:	85 c0                	test   %eax,%eax
80104010:	74 74                	je     80104086 <wait+0xd6>
80104012:	8b 46 24             	mov    0x24(%esi),%eax
80104015:	85 c0                	test   %eax,%eax
80104017:	75 6d                	jne    80104086 <wait+0xd6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104019:	83 ec 08             	sub    $0x8,%esp
8010401c:	68 40 2d 11 80       	push   $0x80112d40
80104021:	56                   	push   %esi
80104022:	e8 c9 fe ff ff       	call   80103ef0 <sleep>
    havekids = 0;
80104027:	83 c4 10             	add    $0x10,%esp
8010402a:	eb ae                	jmp    80103fda <wait+0x2a>
8010402c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80104030:	83 ec 0c             	sub    $0xc,%esp
80104033:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80104036:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104039:	e8 42 e4 ff ff       	call   80102480 <kfree>
        freevm(p->pgdir);
8010403e:	5a                   	pop    %edx
8010403f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80104042:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104049:	e8 02 2d 00 00       	call   80106d50 <freevm>
        release(&ptable.lock);
8010404e:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
        p->pid = 0;
80104055:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
8010405c:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104063:	c6 43 70 00          	movb   $0x0,0x70(%ebx)
        p->killed = 0;
80104067:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010406e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104075:	e8 f6 04 00 00       	call   80104570 <release>
        return pid;
8010407a:	83 c4 10             	add    $0x10,%esp
}
8010407d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104080:	89 f0                	mov    %esi,%eax
80104082:	5b                   	pop    %ebx
80104083:	5e                   	pop    %esi
80104084:	5d                   	pop    %ebp
80104085:	c3                   	ret    
      release(&ptable.lock);
80104086:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104089:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010408e:	68 40 2d 11 80       	push   $0x80112d40
80104093:	e8 d8 04 00 00       	call   80104570 <release>
      return -1;
80104098:	83 c4 10             	add    $0x10,%esp
8010409b:	eb e0                	jmp    8010407d <wait+0xcd>
8010409d:	8d 76 00             	lea    0x0(%esi),%esi

801040a0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801040a0:	55                   	push   %ebp
801040a1:	89 e5                	mov    %esp,%ebp
801040a3:	53                   	push   %ebx
801040a4:	83 ec 10             	sub    $0x10,%esp
801040a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801040aa:	68 40 2d 11 80       	push   $0x80112d40
801040af:	e8 fc 03 00 00       	call   801044b0 <acquire>
801040b4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040b7:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
801040bc:	eb 0c                	jmp    801040ca <wakeup+0x2a>
801040be:	66 90                	xchg   %ax,%ax
801040c0:	83 e8 80             	sub    $0xffffff80,%eax
801040c3:	3d 74 4d 11 80       	cmp    $0x80114d74,%eax
801040c8:	73 1c                	jae    801040e6 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
801040ca:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801040ce:	75 f0                	jne    801040c0 <wakeup+0x20>
801040d0:	3b 58 20             	cmp    0x20(%eax),%ebx
801040d3:	75 eb                	jne    801040c0 <wakeup+0x20>
      p->state = RUNNABLE;
801040d5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040dc:	83 e8 80             	sub    $0xffffff80,%eax
801040df:	3d 74 4d 11 80       	cmp    $0x80114d74,%eax
801040e4:	72 e4                	jb     801040ca <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
801040e6:	c7 45 08 40 2d 11 80 	movl   $0x80112d40,0x8(%ebp)
}
801040ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040f0:	c9                   	leave  
  release(&ptable.lock);
801040f1:	e9 7a 04 00 00       	jmp    80104570 <release>
801040f6:	8d 76 00             	lea    0x0(%esi),%esi
801040f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104100 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104100:	55                   	push   %ebp
80104101:	89 e5                	mov    %esp,%ebp
80104103:	53                   	push   %ebx
80104104:	83 ec 10             	sub    $0x10,%esp
80104107:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010410a:	68 40 2d 11 80       	push   $0x80112d40
8010410f:	e8 9c 03 00 00       	call   801044b0 <acquire>
80104114:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104117:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
8010411c:	eb 0c                	jmp    8010412a <kill+0x2a>
8010411e:	66 90                	xchg   %ax,%ax
80104120:	83 e8 80             	sub    $0xffffff80,%eax
80104123:	3d 74 4d 11 80       	cmp    $0x80114d74,%eax
80104128:	73 36                	jae    80104160 <kill+0x60>
    if(p->pid == pid){
8010412a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010412d:	75 f1                	jne    80104120 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010412f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104133:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010413a:	75 07                	jne    80104143 <kill+0x43>
        p->state = RUNNABLE;
8010413c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104143:	83 ec 0c             	sub    $0xc,%esp
80104146:	68 40 2d 11 80       	push   $0x80112d40
8010414b:	e8 20 04 00 00       	call   80104570 <release>
      return 0;
80104150:	83 c4 10             	add    $0x10,%esp
80104153:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104155:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104158:	c9                   	leave  
80104159:	c3                   	ret    
8010415a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104160:	83 ec 0c             	sub    $0xc,%esp
80104163:	68 40 2d 11 80       	push   $0x80112d40
80104168:	e8 03 04 00 00       	call   80104570 <release>
  return -1;
8010416d:	83 c4 10             	add    $0x10,%esp
80104170:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104175:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104178:	c9                   	leave  
80104179:	c3                   	ret    
8010417a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104180 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104180:	55                   	push   %ebp
80104181:	89 e5                	mov    %esp,%ebp
80104183:	57                   	push   %edi
80104184:	56                   	push   %esi
80104185:	53                   	push   %ebx
80104186:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104189:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
{
8010418e:	83 ec 3c             	sub    $0x3c,%esp
80104191:	eb 24                	jmp    801041b7 <procdump+0x37>
80104193:	90                   	nop
80104194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104198:	83 ec 0c             	sub    $0xc,%esp
8010419b:	68 ff 79 10 80       	push   $0x801079ff
801041a0:	e8 7b c5 ff ff       	call   80100720 <cprintf>
801041a5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041a8:	83 eb 80             	sub    $0xffffff80,%ebx
801041ab:	81 fb 74 4d 11 80    	cmp    $0x80114d74,%ebx
801041b1:	0f 83 81 00 00 00    	jae    80104238 <procdump+0xb8>
    if(p->state == UNUSED)
801041b7:	8b 43 0c             	mov    0xc(%ebx),%eax
801041ba:	85 c0                	test   %eax,%eax
801041bc:	74 ea                	je     801041a8 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041be:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
801041c1:	ba 80 76 10 80       	mov    $0x80107680,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041c6:	77 11                	ja     801041d9 <procdump+0x59>
801041c8:	8b 14 85 e0 76 10 80 	mov    -0x7fef8920(,%eax,4),%edx
      state = "???";
801041cf:	b8 80 76 10 80       	mov    $0x80107680,%eax
801041d4:	85 d2                	test   %edx,%edx
801041d6:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801041d9:	8d 43 70             	lea    0x70(%ebx),%eax
801041dc:	50                   	push   %eax
801041dd:	52                   	push   %edx
801041de:	ff 73 10             	pushl  0x10(%ebx)
801041e1:	68 84 76 10 80       	push   $0x80107684
801041e6:	e8 35 c5 ff ff       	call   80100720 <cprintf>
    if(p->state == SLEEPING){
801041eb:	83 c4 10             	add    $0x10,%esp
801041ee:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
801041f2:	75 a4                	jne    80104198 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801041f4:	8d 45 c0             	lea    -0x40(%ebp),%eax
801041f7:	83 ec 08             	sub    $0x8,%esp
801041fa:	8d 7d c0             	lea    -0x40(%ebp),%edi
801041fd:	50                   	push   %eax
801041fe:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104201:	8b 40 0c             	mov    0xc(%eax),%eax
80104204:	83 c0 08             	add    $0x8,%eax
80104207:	50                   	push   %eax
80104208:	e8 83 01 00 00       	call   80104390 <getcallerpcs>
8010420d:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104210:	8b 17                	mov    (%edi),%edx
80104212:	85 d2                	test   %edx,%edx
80104214:	74 82                	je     80104198 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104216:	83 ec 08             	sub    $0x8,%esp
80104219:	83 c7 04             	add    $0x4,%edi
8010421c:	52                   	push   %edx
8010421d:	68 c1 70 10 80       	push   $0x801070c1
80104222:	e8 f9 c4 ff ff       	call   80100720 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104227:	83 c4 10             	add    $0x10,%esp
8010422a:	39 fe                	cmp    %edi,%esi
8010422c:	75 e2                	jne    80104210 <procdump+0x90>
8010422e:	e9 65 ff ff ff       	jmp    80104198 <procdump+0x18>
80104233:	90                   	nop
80104234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
}
80104238:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010423b:	5b                   	pop    %ebx
8010423c:	5e                   	pop    %esi
8010423d:	5f                   	pop    %edi
8010423e:	5d                   	pop    %ebp
8010423f:	c3                   	ret    

80104240 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	53                   	push   %ebx
80104244:	83 ec 0c             	sub    $0xc,%esp
80104247:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010424a:	68 f8 76 10 80       	push   $0x801076f8
8010424f:	8d 43 04             	lea    0x4(%ebx),%eax
80104252:	50                   	push   %eax
80104253:	e8 18 01 00 00       	call   80104370 <initlock>
  lk->name = name;
80104258:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010425b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104261:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104264:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010426b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010426e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104271:	c9                   	leave  
80104272:	c3                   	ret    
80104273:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104280 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104280:	55                   	push   %ebp
80104281:	89 e5                	mov    %esp,%ebp
80104283:	56                   	push   %esi
80104284:	53                   	push   %ebx
80104285:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104288:	83 ec 0c             	sub    $0xc,%esp
8010428b:	8d 73 04             	lea    0x4(%ebx),%esi
8010428e:	56                   	push   %esi
8010428f:	e8 1c 02 00 00       	call   801044b0 <acquire>
  while (lk->locked) {
80104294:	8b 13                	mov    (%ebx),%edx
80104296:	83 c4 10             	add    $0x10,%esp
80104299:	85 d2                	test   %edx,%edx
8010429b:	74 16                	je     801042b3 <acquiresleep+0x33>
8010429d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801042a0:	83 ec 08             	sub    $0x8,%esp
801042a3:	56                   	push   %esi
801042a4:	53                   	push   %ebx
801042a5:	e8 46 fc ff ff       	call   80103ef0 <sleep>
  while (lk->locked) {
801042aa:	8b 03                	mov    (%ebx),%eax
801042ac:	83 c4 10             	add    $0x10,%esp
801042af:	85 c0                	test   %eax,%eax
801042b1:	75 ed                	jne    801042a0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801042b3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801042b9:	e8 92 f6 ff ff       	call   80103950 <myproc>
801042be:	8b 40 10             	mov    0x10(%eax),%eax
801042c1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801042c4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801042c7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042ca:	5b                   	pop    %ebx
801042cb:	5e                   	pop    %esi
801042cc:	5d                   	pop    %ebp
  release(&lk->lk);
801042cd:	e9 9e 02 00 00       	jmp    80104570 <release>
801042d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042e0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
801042e3:	56                   	push   %esi
801042e4:	53                   	push   %ebx
801042e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801042e8:	83 ec 0c             	sub    $0xc,%esp
801042eb:	8d 73 04             	lea    0x4(%ebx),%esi
801042ee:	56                   	push   %esi
801042ef:	e8 bc 01 00 00       	call   801044b0 <acquire>
  lk->locked = 0;
801042f4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801042fa:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104301:	89 1c 24             	mov    %ebx,(%esp)
80104304:	e8 97 fd ff ff       	call   801040a0 <wakeup>
  release(&lk->lk);
80104309:	89 75 08             	mov    %esi,0x8(%ebp)
8010430c:	83 c4 10             	add    $0x10,%esp
}
8010430f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104312:	5b                   	pop    %ebx
80104313:	5e                   	pop    %esi
80104314:	5d                   	pop    %ebp
  release(&lk->lk);
80104315:	e9 56 02 00 00       	jmp    80104570 <release>
8010431a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104320 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104320:	55                   	push   %ebp
80104321:	89 e5                	mov    %esp,%ebp
80104323:	57                   	push   %edi
80104324:	56                   	push   %esi
80104325:	53                   	push   %ebx
80104326:	31 ff                	xor    %edi,%edi
80104328:	83 ec 18             	sub    $0x18,%esp
8010432b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010432e:	8d 73 04             	lea    0x4(%ebx),%esi
80104331:	56                   	push   %esi
80104332:	e8 79 01 00 00       	call   801044b0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104337:	8b 03                	mov    (%ebx),%eax
80104339:	83 c4 10             	add    $0x10,%esp
8010433c:	85 c0                	test   %eax,%eax
8010433e:	74 13                	je     80104353 <holdingsleep+0x33>
80104340:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104343:	e8 08 f6 ff ff       	call   80103950 <myproc>
80104348:	39 58 10             	cmp    %ebx,0x10(%eax)
8010434b:	0f 94 c0             	sete   %al
8010434e:	0f b6 c0             	movzbl %al,%eax
80104351:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104353:	83 ec 0c             	sub    $0xc,%esp
80104356:	56                   	push   %esi
80104357:	e8 14 02 00 00       	call   80104570 <release>
  return r;
}
8010435c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010435f:	89 f8                	mov    %edi,%eax
80104361:	5b                   	pop    %ebx
80104362:	5e                   	pop    %esi
80104363:	5f                   	pop    %edi
80104364:	5d                   	pop    %ebp
80104365:	c3                   	ret    
80104366:	66 90                	xchg   %ax,%ax
80104368:	66 90                	xchg   %ax,%ax
8010436a:	66 90                	xchg   %ax,%ax
8010436c:	66 90                	xchg   %ax,%ax
8010436e:	66 90                	xchg   %ax,%ax

80104370 <initlock>:
80104370:	55                   	push   %ebp
80104371:	89 e5                	mov    %esp,%ebp
80104373:	8b 45 08             	mov    0x8(%ebp),%eax
80104376:	8b 55 0c             	mov    0xc(%ebp),%edx
80104379:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010437f:	89 50 04             	mov    %edx,0x4(%eax)
80104382:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104389:	5d                   	pop    %ebp
8010438a:	c3                   	ret    
8010438b:	90                   	nop
8010438c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104390 <getcallerpcs>:
80104390:	55                   	push   %ebp
80104391:	31 d2                	xor    %edx,%edx
80104393:	89 e5                	mov    %esp,%ebp
80104395:	53                   	push   %ebx
80104396:	8b 45 08             	mov    0x8(%ebp),%eax
80104399:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010439c:	83 e8 08             	sub    $0x8,%eax
8010439f:	90                   	nop
801043a0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801043a6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801043ac:	77 1a                	ja     801043c8 <getcallerpcs+0x38>
801043ae:	8b 58 04             	mov    0x4(%eax),%ebx
801043b1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
801043b4:	83 c2 01             	add    $0x1,%edx
801043b7:	8b 00                	mov    (%eax),%eax
801043b9:	83 fa 0a             	cmp    $0xa,%edx
801043bc:	75 e2                	jne    801043a0 <getcallerpcs+0x10>
801043be:	5b                   	pop    %ebx
801043bf:	5d                   	pop    %ebp
801043c0:	c3                   	ret    
801043c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043c8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801043cb:	83 c1 28             	add    $0x28,%ecx
801043ce:	66 90                	xchg   %ax,%ax
801043d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801043d6:	83 c0 04             	add    $0x4,%eax
801043d9:	39 c1                	cmp    %eax,%ecx
801043db:	75 f3                	jne    801043d0 <getcallerpcs+0x40>
801043dd:	5b                   	pop    %ebx
801043de:	5d                   	pop    %ebp
801043df:	c3                   	ret    

801043e0 <pushcli>:
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	53                   	push   %ebx
801043e4:	83 ec 04             	sub    $0x4,%esp
801043e7:	9c                   	pushf  
801043e8:	5b                   	pop    %ebx
801043e9:	fa                   	cli    
801043ea:	e8 c1 f4 ff ff       	call   801038b0 <mycpu>
801043ef:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801043f5:	85 c0                	test   %eax,%eax
801043f7:	75 11                	jne    8010440a <pushcli+0x2a>
801043f9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801043ff:	e8 ac f4 ff ff       	call   801038b0 <mycpu>
80104404:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
8010440a:	e8 a1 f4 ff ff       	call   801038b0 <mycpu>
8010440f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
80104416:	83 c4 04             	add    $0x4,%esp
80104419:	5b                   	pop    %ebx
8010441a:	5d                   	pop    %ebp
8010441b:	c3                   	ret    
8010441c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104420 <popcli>:
80104420:	55                   	push   %ebp
80104421:	89 e5                	mov    %esp,%ebp
80104423:	83 ec 08             	sub    $0x8,%esp
80104426:	9c                   	pushf  
80104427:	58                   	pop    %eax
80104428:	f6 c4 02             	test   $0x2,%ah
8010442b:	75 35                	jne    80104462 <popcli+0x42>
8010442d:	e8 7e f4 ff ff       	call   801038b0 <mycpu>
80104432:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104439:	78 34                	js     8010446f <popcli+0x4f>
8010443b:	e8 70 f4 ff ff       	call   801038b0 <mycpu>
80104440:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104446:	85 d2                	test   %edx,%edx
80104448:	74 06                	je     80104450 <popcli+0x30>
8010444a:	c9                   	leave  
8010444b:	c3                   	ret    
8010444c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104450:	e8 5b f4 ff ff       	call   801038b0 <mycpu>
80104455:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010445b:	85 c0                	test   %eax,%eax
8010445d:	74 eb                	je     8010444a <popcli+0x2a>
8010445f:	fb                   	sti    
80104460:	c9                   	leave  
80104461:	c3                   	ret    
80104462:	83 ec 0c             	sub    $0xc,%esp
80104465:	68 03 77 10 80       	push   $0x80107703
8010446a:	e8 e1 bf ff ff       	call   80100450 <panic>
8010446f:	83 ec 0c             	sub    $0xc,%esp
80104472:	68 1a 77 10 80       	push   $0x8010771a
80104477:	e8 d4 bf ff ff       	call   80100450 <panic>
8010447c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104480 <holding>:
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	56                   	push   %esi
80104484:	53                   	push   %ebx
80104485:	8b 75 08             	mov    0x8(%ebp),%esi
80104488:	31 db                	xor    %ebx,%ebx
8010448a:	e8 51 ff ff ff       	call   801043e0 <pushcli>
8010448f:	8b 06                	mov    (%esi),%eax
80104491:	85 c0                	test   %eax,%eax
80104493:	74 10                	je     801044a5 <holding+0x25>
80104495:	8b 5e 08             	mov    0x8(%esi),%ebx
80104498:	e8 13 f4 ff ff       	call   801038b0 <mycpu>
8010449d:	39 c3                	cmp    %eax,%ebx
8010449f:	0f 94 c3             	sete   %bl
801044a2:	0f b6 db             	movzbl %bl,%ebx
801044a5:	e8 76 ff ff ff       	call   80104420 <popcli>
801044aa:	89 d8                	mov    %ebx,%eax
801044ac:	5b                   	pop    %ebx
801044ad:	5e                   	pop    %esi
801044ae:	5d                   	pop    %ebp
801044af:	c3                   	ret    

801044b0 <acquire>:
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp
801044b3:	56                   	push   %esi
801044b4:	53                   	push   %ebx
801044b5:	e8 26 ff ff ff       	call   801043e0 <pushcli>
801044ba:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044bd:	83 ec 0c             	sub    $0xc,%esp
801044c0:	53                   	push   %ebx
801044c1:	e8 ba ff ff ff       	call   80104480 <holding>
801044c6:	83 c4 10             	add    $0x10,%esp
801044c9:	85 c0                	test   %eax,%eax
801044cb:	0f 85 83 00 00 00    	jne    80104554 <acquire+0xa4>
801044d1:	89 c6                	mov    %eax,%esi
801044d3:	ba 01 00 00 00       	mov    $0x1,%edx
801044d8:	eb 09                	jmp    801044e3 <acquire+0x33>
801044da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801044e0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044e3:	89 d0                	mov    %edx,%eax
801044e5:	f0 87 03             	lock xchg %eax,(%ebx)
801044e8:	85 c0                	test   %eax,%eax
801044ea:	75 f4                	jne    801044e0 <acquire+0x30>
801044ec:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
801044f1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044f4:	e8 b7 f3 ff ff       	call   801038b0 <mycpu>
801044f9:	8d 53 0c             	lea    0xc(%ebx),%edx
801044fc:	89 43 08             	mov    %eax,0x8(%ebx)
801044ff:	89 e8                	mov    %ebp,%eax
80104501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104508:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010450e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104514:	77 1a                	ja     80104530 <acquire+0x80>
80104516:	8b 48 04             	mov    0x4(%eax),%ecx
80104519:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
8010451c:	83 c6 01             	add    $0x1,%esi
8010451f:	8b 00                	mov    (%eax),%eax
80104521:	83 fe 0a             	cmp    $0xa,%esi
80104524:	75 e2                	jne    80104508 <acquire+0x58>
80104526:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104529:	5b                   	pop    %ebx
8010452a:	5e                   	pop    %esi
8010452b:	5d                   	pop    %ebp
8010452c:	c3                   	ret    
8010452d:	8d 76 00             	lea    0x0(%esi),%esi
80104530:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104533:	83 c2 28             	add    $0x28,%edx
80104536:	8d 76 00             	lea    0x0(%esi),%esi
80104539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104540:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104546:	83 c0 04             	add    $0x4,%eax
80104549:	39 d0                	cmp    %edx,%eax
8010454b:	75 f3                	jne    80104540 <acquire+0x90>
8010454d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104550:	5b                   	pop    %ebx
80104551:	5e                   	pop    %esi
80104552:	5d                   	pop    %ebp
80104553:	c3                   	ret    
80104554:	83 ec 0c             	sub    $0xc,%esp
80104557:	68 21 77 10 80       	push   $0x80107721
8010455c:	e8 ef be ff ff       	call   80100450 <panic>
80104561:	eb 0d                	jmp    80104570 <release>
80104563:	90                   	nop
80104564:	90                   	nop
80104565:	90                   	nop
80104566:	90                   	nop
80104567:	90                   	nop
80104568:	90                   	nop
80104569:	90                   	nop
8010456a:	90                   	nop
8010456b:	90                   	nop
8010456c:	90                   	nop
8010456d:	90                   	nop
8010456e:	90                   	nop
8010456f:	90                   	nop

80104570 <release>:
80104570:	55                   	push   %ebp
80104571:	89 e5                	mov    %esp,%ebp
80104573:	53                   	push   %ebx
80104574:	83 ec 10             	sub    $0x10,%esp
80104577:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010457a:	53                   	push   %ebx
8010457b:	e8 00 ff ff ff       	call   80104480 <holding>
80104580:	83 c4 10             	add    $0x10,%esp
80104583:	85 c0                	test   %eax,%eax
80104585:	74 22                	je     801045a9 <release+0x39>
80104587:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
8010458e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80104595:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
8010459a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801045a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045a3:	c9                   	leave  
801045a4:	e9 77 fe ff ff       	jmp    80104420 <popcli>
801045a9:	83 ec 0c             	sub    $0xc,%esp
801045ac:	68 29 77 10 80       	push   $0x80107729
801045b1:	e8 9a be ff ff       	call   80100450 <panic>
801045b6:	66 90                	xchg   %ax,%ax
801045b8:	66 90                	xchg   %ax,%ax
801045ba:	66 90                	xchg   %ax,%ax
801045bc:	66 90                	xchg   %ax,%ax
801045be:	66 90                	xchg   %ax,%ax

801045c0 <memset>:
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	57                   	push   %edi
801045c4:	53                   	push   %ebx
801045c5:	8b 55 08             	mov    0x8(%ebp),%edx
801045c8:	8b 4d 10             	mov    0x10(%ebp),%ecx
801045cb:	f6 c2 03             	test   $0x3,%dl
801045ce:	75 05                	jne    801045d5 <memset+0x15>
801045d0:	f6 c1 03             	test   $0x3,%cl
801045d3:	74 13                	je     801045e8 <memset+0x28>
801045d5:	89 d7                	mov    %edx,%edi
801045d7:	8b 45 0c             	mov    0xc(%ebp),%eax
801045da:	fc                   	cld    
801045db:	f3 aa                	rep stos %al,%es:(%edi)
801045dd:	5b                   	pop    %ebx
801045de:	89 d0                	mov    %edx,%eax
801045e0:	5f                   	pop    %edi
801045e1:	5d                   	pop    %ebp
801045e2:	c3                   	ret    
801045e3:	90                   	nop
801045e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045e8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
801045ec:	c1 e9 02             	shr    $0x2,%ecx
801045ef:	89 f8                	mov    %edi,%eax
801045f1:	89 fb                	mov    %edi,%ebx
801045f3:	c1 e0 18             	shl    $0x18,%eax
801045f6:	c1 e3 10             	shl    $0x10,%ebx
801045f9:	09 d8                	or     %ebx,%eax
801045fb:	09 f8                	or     %edi,%eax
801045fd:	c1 e7 08             	shl    $0x8,%edi
80104600:	09 f8                	or     %edi,%eax
80104602:	89 d7                	mov    %edx,%edi
80104604:	fc                   	cld    
80104605:	f3 ab                	rep stos %eax,%es:(%edi)
80104607:	5b                   	pop    %ebx
80104608:	89 d0                	mov    %edx,%eax
8010460a:	5f                   	pop    %edi
8010460b:	5d                   	pop    %ebp
8010460c:	c3                   	ret    
8010460d:	8d 76 00             	lea    0x0(%esi),%esi

80104610 <memcmp>:
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	57                   	push   %edi
80104614:	56                   	push   %esi
80104615:	53                   	push   %ebx
80104616:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104619:	8b 75 08             	mov    0x8(%ebp),%esi
8010461c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010461f:	85 db                	test   %ebx,%ebx
80104621:	74 29                	je     8010464c <memcmp+0x3c>
80104623:	0f b6 16             	movzbl (%esi),%edx
80104626:	0f b6 0f             	movzbl (%edi),%ecx
80104629:	38 d1                	cmp    %dl,%cl
8010462b:	75 2b                	jne    80104658 <memcmp+0x48>
8010462d:	b8 01 00 00 00       	mov    $0x1,%eax
80104632:	eb 14                	jmp    80104648 <memcmp+0x38>
80104634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104638:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
8010463c:	83 c0 01             	add    $0x1,%eax
8010463f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104644:	38 ca                	cmp    %cl,%dl
80104646:	75 10                	jne    80104658 <memcmp+0x48>
80104648:	39 d8                	cmp    %ebx,%eax
8010464a:	75 ec                	jne    80104638 <memcmp+0x28>
8010464c:	5b                   	pop    %ebx
8010464d:	31 c0                	xor    %eax,%eax
8010464f:	5e                   	pop    %esi
80104650:	5f                   	pop    %edi
80104651:	5d                   	pop    %ebp
80104652:	c3                   	ret    
80104653:	90                   	nop
80104654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104658:	0f b6 c2             	movzbl %dl,%eax
8010465b:	5b                   	pop    %ebx
8010465c:	29 c8                	sub    %ecx,%eax
8010465e:	5e                   	pop    %esi
8010465f:	5f                   	pop    %edi
80104660:	5d                   	pop    %ebp
80104661:	c3                   	ret    
80104662:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104670 <memmove>:
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	56                   	push   %esi
80104674:	53                   	push   %ebx
80104675:	8b 45 08             	mov    0x8(%ebp),%eax
80104678:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010467b:	8b 75 10             	mov    0x10(%ebp),%esi
8010467e:	39 c3                	cmp    %eax,%ebx
80104680:	73 26                	jae    801046a8 <memmove+0x38>
80104682:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104685:	39 c8                	cmp    %ecx,%eax
80104687:	73 1f                	jae    801046a8 <memmove+0x38>
80104689:	85 f6                	test   %esi,%esi
8010468b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010468e:	74 0f                	je     8010469f <memmove+0x2f>
80104690:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104694:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104697:	83 ea 01             	sub    $0x1,%edx
8010469a:	83 fa ff             	cmp    $0xffffffff,%edx
8010469d:	75 f1                	jne    80104690 <memmove+0x20>
8010469f:	5b                   	pop    %ebx
801046a0:	5e                   	pop    %esi
801046a1:	5d                   	pop    %ebp
801046a2:	c3                   	ret    
801046a3:	90                   	nop
801046a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046a8:	31 d2                	xor    %edx,%edx
801046aa:	85 f6                	test   %esi,%esi
801046ac:	74 f1                	je     8010469f <memmove+0x2f>
801046ae:	66 90                	xchg   %ax,%ax
801046b0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801046b4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801046b7:	83 c2 01             	add    $0x1,%edx
801046ba:	39 d6                	cmp    %edx,%esi
801046bc:	75 f2                	jne    801046b0 <memmove+0x40>
801046be:	5b                   	pop    %ebx
801046bf:	5e                   	pop    %esi
801046c0:	5d                   	pop    %ebp
801046c1:	c3                   	ret    
801046c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046d0 <memcpy>:
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	5d                   	pop    %ebp
801046d4:	eb 9a                	jmp    80104670 <memmove>
801046d6:	8d 76 00             	lea    0x0(%esi),%esi
801046d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046e0 <strncmp>:
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	57                   	push   %edi
801046e4:	56                   	push   %esi
801046e5:	8b 7d 10             	mov    0x10(%ebp),%edi
801046e8:	53                   	push   %ebx
801046e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
801046ec:	8b 75 0c             	mov    0xc(%ebp),%esi
801046ef:	85 ff                	test   %edi,%edi
801046f1:	74 2f                	je     80104722 <strncmp+0x42>
801046f3:	0f b6 01             	movzbl (%ecx),%eax
801046f6:	0f b6 1e             	movzbl (%esi),%ebx
801046f9:	84 c0                	test   %al,%al
801046fb:	74 37                	je     80104734 <strncmp+0x54>
801046fd:	38 c3                	cmp    %al,%bl
801046ff:	75 33                	jne    80104734 <strncmp+0x54>
80104701:	01 f7                	add    %esi,%edi
80104703:	eb 13                	jmp    80104718 <strncmp+0x38>
80104705:	8d 76 00             	lea    0x0(%esi),%esi
80104708:	0f b6 01             	movzbl (%ecx),%eax
8010470b:	84 c0                	test   %al,%al
8010470d:	74 21                	je     80104730 <strncmp+0x50>
8010470f:	0f b6 1a             	movzbl (%edx),%ebx
80104712:	89 d6                	mov    %edx,%esi
80104714:	38 d8                	cmp    %bl,%al
80104716:	75 1c                	jne    80104734 <strncmp+0x54>
80104718:	8d 56 01             	lea    0x1(%esi),%edx
8010471b:	83 c1 01             	add    $0x1,%ecx
8010471e:	39 fa                	cmp    %edi,%edx
80104720:	75 e6                	jne    80104708 <strncmp+0x28>
80104722:	5b                   	pop    %ebx
80104723:	31 c0                	xor    %eax,%eax
80104725:	5e                   	pop    %esi
80104726:	5f                   	pop    %edi
80104727:	5d                   	pop    %ebp
80104728:	c3                   	ret    
80104729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104730:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
80104734:	29 d8                	sub    %ebx,%eax
80104736:	5b                   	pop    %ebx
80104737:	5e                   	pop    %esi
80104738:	5f                   	pop    %edi
80104739:	5d                   	pop    %ebp
8010473a:	c3                   	ret    
8010473b:	90                   	nop
8010473c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104740 <strncpy>:
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	56                   	push   %esi
80104744:	53                   	push   %ebx
80104745:	8b 45 08             	mov    0x8(%ebp),%eax
80104748:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010474b:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010474e:	89 c2                	mov    %eax,%edx
80104750:	eb 19                	jmp    8010476b <strncpy+0x2b>
80104752:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104758:	83 c3 01             	add    $0x1,%ebx
8010475b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010475f:	83 c2 01             	add    $0x1,%edx
80104762:	84 c9                	test   %cl,%cl
80104764:	88 4a ff             	mov    %cl,-0x1(%edx)
80104767:	74 09                	je     80104772 <strncpy+0x32>
80104769:	89 f1                	mov    %esi,%ecx
8010476b:	85 c9                	test   %ecx,%ecx
8010476d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104770:	7f e6                	jg     80104758 <strncpy+0x18>
80104772:	31 c9                	xor    %ecx,%ecx
80104774:	85 f6                	test   %esi,%esi
80104776:	7e 17                	jle    8010478f <strncpy+0x4f>
80104778:	90                   	nop
80104779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104780:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104784:	89 f3                	mov    %esi,%ebx
80104786:	83 c1 01             	add    $0x1,%ecx
80104789:	29 cb                	sub    %ecx,%ebx
8010478b:	85 db                	test   %ebx,%ebx
8010478d:	7f f1                	jg     80104780 <strncpy+0x40>
8010478f:	5b                   	pop    %ebx
80104790:	5e                   	pop    %esi
80104791:	5d                   	pop    %ebp
80104792:	c3                   	ret    
80104793:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047a0 <safestrcpy>:
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	56                   	push   %esi
801047a4:	53                   	push   %ebx
801047a5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801047a8:	8b 45 08             	mov    0x8(%ebp),%eax
801047ab:	8b 55 0c             	mov    0xc(%ebp),%edx
801047ae:	85 c9                	test   %ecx,%ecx
801047b0:	7e 26                	jle    801047d8 <safestrcpy+0x38>
801047b2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801047b6:	89 c1                	mov    %eax,%ecx
801047b8:	eb 17                	jmp    801047d1 <safestrcpy+0x31>
801047ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047c0:	83 c2 01             	add    $0x1,%edx
801047c3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801047c7:	83 c1 01             	add    $0x1,%ecx
801047ca:	84 db                	test   %bl,%bl
801047cc:	88 59 ff             	mov    %bl,-0x1(%ecx)
801047cf:	74 04                	je     801047d5 <safestrcpy+0x35>
801047d1:	39 f2                	cmp    %esi,%edx
801047d3:	75 eb                	jne    801047c0 <safestrcpy+0x20>
801047d5:	c6 01 00             	movb   $0x0,(%ecx)
801047d8:	5b                   	pop    %ebx
801047d9:	5e                   	pop    %esi
801047da:	5d                   	pop    %ebp
801047db:	c3                   	ret    
801047dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047e0 <strlen>:
801047e0:	55                   	push   %ebp
801047e1:	31 c0                	xor    %eax,%eax
801047e3:	89 e5                	mov    %esp,%ebp
801047e5:	8b 55 08             	mov    0x8(%ebp),%edx
801047e8:	80 3a 00             	cmpb   $0x0,(%edx)
801047eb:	74 0c                	je     801047f9 <strlen+0x19>
801047ed:	8d 76 00             	lea    0x0(%esi),%esi
801047f0:	83 c0 01             	add    $0x1,%eax
801047f3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801047f7:	75 f7                	jne    801047f0 <strlen+0x10>
801047f9:	5d                   	pop    %ebp
801047fa:	c3                   	ret    

801047fb <swtch>:
801047fb:	8b 44 24 04          	mov    0x4(%esp),%eax
801047ff:	8b 54 24 08          	mov    0x8(%esp),%edx
80104803:	55                   	push   %ebp
80104804:	53                   	push   %ebx
80104805:	56                   	push   %esi
80104806:	57                   	push   %edi
80104807:	89 20                	mov    %esp,(%eax)
80104809:	89 d4                	mov    %edx,%esp
8010480b:	5f                   	pop    %edi
8010480c:	5e                   	pop    %esi
8010480d:	5b                   	pop    %ebx
8010480e:	5d                   	pop    %ebp
8010480f:	c3                   	ret    

80104810 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	53                   	push   %ebx
80104814:	83 ec 04             	sub    $0x4,%esp
80104817:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010481a:	e8 31 f1 ff ff       	call   80103950 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010481f:	8b 00                	mov    (%eax),%eax
80104821:	39 d8                	cmp    %ebx,%eax
80104823:	76 1b                	jbe    80104840 <fetchint+0x30>
80104825:	8d 53 04             	lea    0x4(%ebx),%edx
80104828:	39 d0                	cmp    %edx,%eax
8010482a:	72 14                	jb     80104840 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010482c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010482f:	8b 13                	mov    (%ebx),%edx
80104831:	89 10                	mov    %edx,(%eax)
  return 0;
80104833:	31 c0                	xor    %eax,%eax
}
80104835:	83 c4 04             	add    $0x4,%esp
80104838:	5b                   	pop    %ebx
80104839:	5d                   	pop    %ebp
8010483a:	c3                   	ret    
8010483b:	90                   	nop
8010483c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104840:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104845:	eb ee                	jmp    80104835 <fetchint+0x25>
80104847:	89 f6                	mov    %esi,%esi
80104849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104850 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
80104853:	53                   	push   %ebx
80104854:	83 ec 04             	sub    $0x4,%esp
80104857:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010485a:	e8 f1 f0 ff ff       	call   80103950 <myproc>

  if(addr >= curproc->sz)
8010485f:	39 18                	cmp    %ebx,(%eax)
80104861:	76 29                	jbe    8010488c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104863:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104866:	89 da                	mov    %ebx,%edx
80104868:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010486a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010486c:	39 c3                	cmp    %eax,%ebx
8010486e:	73 1c                	jae    8010488c <fetchstr+0x3c>
    if(*s == 0)
80104870:	80 3b 00             	cmpb   $0x0,(%ebx)
80104873:	75 10                	jne    80104885 <fetchstr+0x35>
80104875:	eb 39                	jmp    801048b0 <fetchstr+0x60>
80104877:	89 f6                	mov    %esi,%esi
80104879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104880:	80 3a 00             	cmpb   $0x0,(%edx)
80104883:	74 1b                	je     801048a0 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104885:	83 c2 01             	add    $0x1,%edx
80104888:	39 d0                	cmp    %edx,%eax
8010488a:	77 f4                	ja     80104880 <fetchstr+0x30>
    return -1;
8010488c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104891:	83 c4 04             	add    $0x4,%esp
80104894:	5b                   	pop    %ebx
80104895:	5d                   	pop    %ebp
80104896:	c3                   	ret    
80104897:	89 f6                	mov    %esi,%esi
80104899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801048a0:	83 c4 04             	add    $0x4,%esp
801048a3:	89 d0                	mov    %edx,%eax
801048a5:	29 d8                	sub    %ebx,%eax
801048a7:	5b                   	pop    %ebx
801048a8:	5d                   	pop    %ebp
801048a9:	c3                   	ret    
801048aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
801048b0:	31 c0                	xor    %eax,%eax
      return s - *pp;
801048b2:	eb dd                	jmp    80104891 <fetchstr+0x41>
801048b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801048c0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	56                   	push   %esi
801048c4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801048c5:	e8 86 f0 ff ff       	call   80103950 <myproc>
801048ca:	8b 40 18             	mov    0x18(%eax),%eax
801048cd:	8b 55 08             	mov    0x8(%ebp),%edx
801048d0:	8b 40 44             	mov    0x44(%eax),%eax
801048d3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801048d6:	e8 75 f0 ff ff       	call   80103950 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801048db:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801048dd:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801048e0:	39 c6                	cmp    %eax,%esi
801048e2:	73 1c                	jae    80104900 <argint+0x40>
801048e4:	8d 53 08             	lea    0x8(%ebx),%edx
801048e7:	39 d0                	cmp    %edx,%eax
801048e9:	72 15                	jb     80104900 <argint+0x40>
  *ip = *(int*)(addr);
801048eb:	8b 45 0c             	mov    0xc(%ebp),%eax
801048ee:	8b 53 04             	mov    0x4(%ebx),%edx
801048f1:	89 10                	mov    %edx,(%eax)
  return 0;
801048f3:	31 c0                	xor    %eax,%eax
}
801048f5:	5b                   	pop    %ebx
801048f6:	5e                   	pop    %esi
801048f7:	5d                   	pop    %ebp
801048f8:	c3                   	ret    
801048f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104900:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104905:	eb ee                	jmp    801048f5 <argint+0x35>
80104907:	89 f6                	mov    %esi,%esi
80104909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104910 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	56                   	push   %esi
80104914:	53                   	push   %ebx
80104915:	83 ec 10             	sub    $0x10,%esp
80104918:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010491b:	e8 30 f0 ff ff       	call   80103950 <myproc>
80104920:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104922:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104925:	83 ec 08             	sub    $0x8,%esp
80104928:	50                   	push   %eax
80104929:	ff 75 08             	pushl  0x8(%ebp)
8010492c:	e8 8f ff ff ff       	call   801048c0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104931:	83 c4 10             	add    $0x10,%esp
80104934:	85 c0                	test   %eax,%eax
80104936:	78 28                	js     80104960 <argptr+0x50>
80104938:	85 db                	test   %ebx,%ebx
8010493a:	78 24                	js     80104960 <argptr+0x50>
8010493c:	8b 16                	mov    (%esi),%edx
8010493e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104941:	39 c2                	cmp    %eax,%edx
80104943:	76 1b                	jbe    80104960 <argptr+0x50>
80104945:	01 c3                	add    %eax,%ebx
80104947:	39 da                	cmp    %ebx,%edx
80104949:	72 15                	jb     80104960 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010494b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010494e:	89 02                	mov    %eax,(%edx)
  return 0;
80104950:	31 c0                	xor    %eax,%eax
}
80104952:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104955:	5b                   	pop    %ebx
80104956:	5e                   	pop    %esi
80104957:	5d                   	pop    %ebp
80104958:	c3                   	ret    
80104959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104960:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104965:	eb eb                	jmp    80104952 <argptr+0x42>
80104967:	89 f6                	mov    %esi,%esi
80104969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104970 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104976:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104979:	50                   	push   %eax
8010497a:	ff 75 08             	pushl  0x8(%ebp)
8010497d:	e8 3e ff ff ff       	call   801048c0 <argint>
80104982:	83 c4 10             	add    $0x10,%esp
80104985:	85 c0                	test   %eax,%eax
80104987:	78 17                	js     801049a0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104989:	83 ec 08             	sub    $0x8,%esp
8010498c:	ff 75 0c             	pushl  0xc(%ebp)
8010498f:	ff 75 f4             	pushl  -0xc(%ebp)
80104992:	e8 b9 fe ff ff       	call   80104850 <fetchstr>
80104997:	83 c4 10             	add    $0x10,%esp
}
8010499a:	c9                   	leave  
8010499b:	c3                   	ret    
8010499c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801049a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801049a5:	c9                   	leave  
801049a6:	c3                   	ret    
801049a7:	89 f6                	mov    %esi,%esi
801049a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049b0 <syscall>:
[SYS_steal]   sys_steal,
};

void
syscall(void)
{
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	53                   	push   %ebx
801049b4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
801049b7:	e8 94 ef ff ff       	call   80103950 <myproc>
801049bc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801049be:	8b 40 18             	mov    0x18(%eax),%eax
801049c1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801049c4:	8d 50 ff             	lea    -0x1(%eax),%edx
801049c7:	83 fa 16             	cmp    $0x16,%edx
801049ca:	77 1c                	ja     801049e8 <syscall+0x38>
801049cc:	8b 14 85 60 77 10 80 	mov    -0x7fef88a0(,%eax,4),%edx
801049d3:	85 d2                	test   %edx,%edx
801049d5:	74 11                	je     801049e8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
801049d7:	ff d2                	call   *%edx
801049d9:	8b 53 18             	mov    0x18(%ebx),%edx
801049dc:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801049df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049e2:	c9                   	leave  
801049e3:	c3                   	ret    
801049e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
801049e8:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801049e9:	8d 43 70             	lea    0x70(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801049ec:	50                   	push   %eax
801049ed:	ff 73 10             	pushl  0x10(%ebx)
801049f0:	68 31 77 10 80       	push   $0x80107731
801049f5:	e8 26 bd ff ff       	call   80100720 <cprintf>
    curproc->tf->eax = -1;
801049fa:	8b 43 18             	mov    0x18(%ebx),%eax
801049fd:	83 c4 10             	add    $0x10,%esp
80104a00:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104a07:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a0a:	c9                   	leave  
80104a0b:	c3                   	ret    
80104a0c:	66 90                	xchg   %ax,%ax
80104a0e:	66 90                	xchg   %ax,%ax

80104a10 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a10:	55                   	push   %ebp
80104a11:	89 e5                	mov    %esp,%ebp
80104a13:	57                   	push   %edi
80104a14:	56                   	push   %esi
80104a15:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a16:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104a19:	83 ec 34             	sub    $0x34,%esp
80104a1c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104a1f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104a22:	56                   	push   %esi
80104a23:	50                   	push   %eax
{
80104a24:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104a27:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104a2a:	e8 41 d6 ff ff       	call   80102070 <nameiparent>
80104a2f:	83 c4 10             	add    $0x10,%esp
80104a32:	85 c0                	test   %eax,%eax
80104a34:	0f 84 46 01 00 00    	je     80104b80 <create+0x170>
    return 0;
  ilock(dp);
80104a3a:	83 ec 0c             	sub    $0xc,%esp
80104a3d:	89 c3                	mov    %eax,%ebx
80104a3f:	50                   	push   %eax
80104a40:	e8 6b cd ff ff       	call   801017b0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104a45:	83 c4 0c             	add    $0xc,%esp
80104a48:	6a 00                	push   $0x0
80104a4a:	56                   	push   %esi
80104a4b:	53                   	push   %ebx
80104a4c:	e8 cf d2 ff ff       	call   80101d20 <dirlookup>
80104a51:	83 c4 10             	add    $0x10,%esp
80104a54:	85 c0                	test   %eax,%eax
80104a56:	89 c7                	mov    %eax,%edi
80104a58:	74 36                	je     80104a90 <create+0x80>
    iunlockput(dp);
80104a5a:	83 ec 0c             	sub    $0xc,%esp
80104a5d:	53                   	push   %ebx
80104a5e:	e8 dd cf ff ff       	call   80101a40 <iunlockput>
    ilock(ip);
80104a63:	89 3c 24             	mov    %edi,(%esp)
80104a66:	e8 45 cd ff ff       	call   801017b0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104a6b:	83 c4 10             	add    $0x10,%esp
80104a6e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104a73:	0f 85 97 00 00 00    	jne    80104b10 <create+0x100>
80104a79:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104a7e:	0f 85 8c 00 00 00    	jne    80104b10 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104a84:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a87:	89 f8                	mov    %edi,%eax
80104a89:	5b                   	pop    %ebx
80104a8a:	5e                   	pop    %esi
80104a8b:	5f                   	pop    %edi
80104a8c:	5d                   	pop    %ebp
80104a8d:	c3                   	ret    
80104a8e:	66 90                	xchg   %ax,%ax
  if((ip = ialloc(dp->dev, type)) == 0)
80104a90:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104a94:	83 ec 08             	sub    $0x8,%esp
80104a97:	50                   	push   %eax
80104a98:	ff 33                	pushl  (%ebx)
80104a9a:	e8 a1 cb ff ff       	call   80101640 <ialloc>
80104a9f:	83 c4 10             	add    $0x10,%esp
80104aa2:	85 c0                	test   %eax,%eax
80104aa4:	89 c7                	mov    %eax,%edi
80104aa6:	0f 84 e8 00 00 00    	je     80104b94 <create+0x184>
  ilock(ip);
80104aac:	83 ec 0c             	sub    $0xc,%esp
80104aaf:	50                   	push   %eax
80104ab0:	e8 fb cc ff ff       	call   801017b0 <ilock>
  ip->major = major;
80104ab5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104ab9:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104abd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104ac1:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104ac5:	b8 01 00 00 00       	mov    $0x1,%eax
80104aca:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104ace:	89 3c 24             	mov    %edi,(%esp)
80104ad1:	e8 2a cc ff ff       	call   80101700 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104ad6:	83 c4 10             	add    $0x10,%esp
80104ad9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104ade:	74 50                	je     80104b30 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104ae0:	83 ec 04             	sub    $0x4,%esp
80104ae3:	ff 77 04             	pushl  0x4(%edi)
80104ae6:	56                   	push   %esi
80104ae7:	53                   	push   %ebx
80104ae8:	e8 a3 d4 ff ff       	call   80101f90 <dirlink>
80104aed:	83 c4 10             	add    $0x10,%esp
80104af0:	85 c0                	test   %eax,%eax
80104af2:	0f 88 8f 00 00 00    	js     80104b87 <create+0x177>
  iunlockput(dp);
80104af8:	83 ec 0c             	sub    $0xc,%esp
80104afb:	53                   	push   %ebx
80104afc:	e8 3f cf ff ff       	call   80101a40 <iunlockput>
  return ip;
80104b01:	83 c4 10             	add    $0x10,%esp
}
80104b04:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b07:	89 f8                	mov    %edi,%eax
80104b09:	5b                   	pop    %ebx
80104b0a:	5e                   	pop    %esi
80104b0b:	5f                   	pop    %edi
80104b0c:	5d                   	pop    %ebp
80104b0d:	c3                   	ret    
80104b0e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104b10:	83 ec 0c             	sub    $0xc,%esp
80104b13:	57                   	push   %edi
    return 0;
80104b14:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104b16:	e8 25 cf ff ff       	call   80101a40 <iunlockput>
    return 0;
80104b1b:	83 c4 10             	add    $0x10,%esp
}
80104b1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b21:	89 f8                	mov    %edi,%eax
80104b23:	5b                   	pop    %ebx
80104b24:	5e                   	pop    %esi
80104b25:	5f                   	pop    %edi
80104b26:	5d                   	pop    %ebp
80104b27:	c3                   	ret    
80104b28:	90                   	nop
80104b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104b30:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104b35:	83 ec 0c             	sub    $0xc,%esp
80104b38:	53                   	push   %ebx
80104b39:	e8 c2 cb ff ff       	call   80101700 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104b3e:	83 c4 0c             	add    $0xc,%esp
80104b41:	ff 77 04             	pushl  0x4(%edi)
80104b44:	68 dc 77 10 80       	push   $0x801077dc
80104b49:	57                   	push   %edi
80104b4a:	e8 41 d4 ff ff       	call   80101f90 <dirlink>
80104b4f:	83 c4 10             	add    $0x10,%esp
80104b52:	85 c0                	test   %eax,%eax
80104b54:	78 1c                	js     80104b72 <create+0x162>
80104b56:	83 ec 04             	sub    $0x4,%esp
80104b59:	ff 73 04             	pushl  0x4(%ebx)
80104b5c:	68 db 77 10 80       	push   $0x801077db
80104b61:	57                   	push   %edi
80104b62:	e8 29 d4 ff ff       	call   80101f90 <dirlink>
80104b67:	83 c4 10             	add    $0x10,%esp
80104b6a:	85 c0                	test   %eax,%eax
80104b6c:	0f 89 6e ff ff ff    	jns    80104ae0 <create+0xd0>
      panic("create dots");
80104b72:	83 ec 0c             	sub    $0xc,%esp
80104b75:	68 cf 77 10 80       	push   $0x801077cf
80104b7a:	e8 d1 b8 ff ff       	call   80100450 <panic>
80104b7f:	90                   	nop
    return 0;
80104b80:	31 ff                	xor    %edi,%edi
80104b82:	e9 fd fe ff ff       	jmp    80104a84 <create+0x74>
    panic("create: dirlink");
80104b87:	83 ec 0c             	sub    $0xc,%esp
80104b8a:	68 de 77 10 80       	push   $0x801077de
80104b8f:	e8 bc b8 ff ff       	call   80100450 <panic>
    panic("create: ialloc");
80104b94:	83 ec 0c             	sub    $0xc,%esp
80104b97:	68 c0 77 10 80       	push   $0x801077c0
80104b9c:	e8 af b8 ff ff       	call   80100450 <panic>
80104ba1:	eb 0d                	jmp    80104bb0 <argfd.constprop.0>
80104ba3:	90                   	nop
80104ba4:	90                   	nop
80104ba5:	90                   	nop
80104ba6:	90                   	nop
80104ba7:	90                   	nop
80104ba8:	90                   	nop
80104ba9:	90                   	nop
80104baa:	90                   	nop
80104bab:	90                   	nop
80104bac:	90                   	nop
80104bad:	90                   	nop
80104bae:	90                   	nop
80104baf:	90                   	nop

80104bb0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104bb0:	55                   	push   %ebp
80104bb1:	89 e5                	mov    %esp,%ebp
80104bb3:	56                   	push   %esi
80104bb4:	53                   	push   %ebx
80104bb5:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104bb7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104bba:	89 d6                	mov    %edx,%esi
80104bbc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104bbf:	50                   	push   %eax
80104bc0:	6a 00                	push   $0x0
80104bc2:	e8 f9 fc ff ff       	call   801048c0 <argint>
80104bc7:	83 c4 10             	add    $0x10,%esp
80104bca:	85 c0                	test   %eax,%eax
80104bcc:	78 2a                	js     80104bf8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104bce:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104bd2:	77 24                	ja     80104bf8 <argfd.constprop.0+0x48>
80104bd4:	e8 77 ed ff ff       	call   80103950 <myproc>
80104bd9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104bdc:	8b 44 90 2c          	mov    0x2c(%eax,%edx,4),%eax
80104be0:	85 c0                	test   %eax,%eax
80104be2:	74 14                	je     80104bf8 <argfd.constprop.0+0x48>
  if(pfd)
80104be4:	85 db                	test   %ebx,%ebx
80104be6:	74 02                	je     80104bea <argfd.constprop.0+0x3a>
    *pfd = fd;
80104be8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104bea:	89 06                	mov    %eax,(%esi)
  return 0;
80104bec:	31 c0                	xor    %eax,%eax
}
80104bee:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104bf1:	5b                   	pop    %ebx
80104bf2:	5e                   	pop    %esi
80104bf3:	5d                   	pop    %ebp
80104bf4:	c3                   	ret    
80104bf5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104bf8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bfd:	eb ef                	jmp    80104bee <argfd.constprop.0+0x3e>
80104bff:	90                   	nop

80104c00 <sys_dup>:
{
80104c00:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104c01:	31 c0                	xor    %eax,%eax
{
80104c03:	89 e5                	mov    %esp,%ebp
80104c05:	56                   	push   %esi
80104c06:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104c07:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104c0a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104c0d:	e8 9e ff ff ff       	call   80104bb0 <argfd.constprop.0>
80104c12:	85 c0                	test   %eax,%eax
80104c14:	78 42                	js     80104c58 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80104c16:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104c19:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104c1b:	e8 30 ed ff ff       	call   80103950 <myproc>
80104c20:	eb 0e                	jmp    80104c30 <sys_dup+0x30>
80104c22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104c28:	83 c3 01             	add    $0x1,%ebx
80104c2b:	83 fb 10             	cmp    $0x10,%ebx
80104c2e:	74 28                	je     80104c58 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104c30:	8b 54 98 2c          	mov    0x2c(%eax,%ebx,4),%edx
80104c34:	85 d2                	test   %edx,%edx
80104c36:	75 f0                	jne    80104c28 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104c38:	89 74 98 2c          	mov    %esi,0x2c(%eax,%ebx,4)
  filedup(f);
80104c3c:	83 ec 0c             	sub    $0xc,%esp
80104c3f:	ff 75 f4             	pushl  -0xc(%ebp)
80104c42:	e8 69 c2 ff ff       	call   80100eb0 <filedup>
  return fd;
80104c47:	83 c4 10             	add    $0x10,%esp
}
80104c4a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c4d:	89 d8                	mov    %ebx,%eax
80104c4f:	5b                   	pop    %ebx
80104c50:	5e                   	pop    %esi
80104c51:	5d                   	pop    %ebp
80104c52:	c3                   	ret    
80104c53:	90                   	nop
80104c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c58:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104c5b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104c60:	89 d8                	mov    %ebx,%eax
80104c62:	5b                   	pop    %ebx
80104c63:	5e                   	pop    %esi
80104c64:	5d                   	pop    %ebp
80104c65:	c3                   	ret    
80104c66:	8d 76 00             	lea    0x0(%esi),%esi
80104c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c70 <sys_read>:
{
80104c70:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c71:	31 c0                	xor    %eax,%eax
{
80104c73:	89 e5                	mov    %esp,%ebp
80104c75:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c78:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104c7b:	e8 30 ff ff ff       	call   80104bb0 <argfd.constprop.0>
80104c80:	85 c0                	test   %eax,%eax
80104c82:	78 4c                	js     80104cd0 <sys_read+0x60>
80104c84:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c87:	83 ec 08             	sub    $0x8,%esp
80104c8a:	50                   	push   %eax
80104c8b:	6a 02                	push   $0x2
80104c8d:	e8 2e fc ff ff       	call   801048c0 <argint>
80104c92:	83 c4 10             	add    $0x10,%esp
80104c95:	85 c0                	test   %eax,%eax
80104c97:	78 37                	js     80104cd0 <sys_read+0x60>
80104c99:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c9c:	83 ec 04             	sub    $0x4,%esp
80104c9f:	ff 75 f0             	pushl  -0x10(%ebp)
80104ca2:	50                   	push   %eax
80104ca3:	6a 01                	push   $0x1
80104ca5:	e8 66 fc ff ff       	call   80104910 <argptr>
80104caa:	83 c4 10             	add    $0x10,%esp
80104cad:	85 c0                	test   %eax,%eax
80104caf:	78 1f                	js     80104cd0 <sys_read+0x60>
  return fileread(f, p, n);
80104cb1:	83 ec 04             	sub    $0x4,%esp
80104cb4:	ff 75 f0             	pushl  -0x10(%ebp)
80104cb7:	ff 75 f4             	pushl  -0xc(%ebp)
80104cba:	ff 75 ec             	pushl  -0x14(%ebp)
80104cbd:	e8 5e c3 ff ff       	call   80101020 <fileread>
80104cc2:	83 c4 10             	add    $0x10,%esp
}
80104cc5:	c9                   	leave  
80104cc6:	c3                   	ret    
80104cc7:	89 f6                	mov    %esi,%esi
80104cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104cd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cd5:	c9                   	leave  
80104cd6:	c3                   	ret    
80104cd7:	89 f6                	mov    %esi,%esi
80104cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ce0 <sys_steal>:
{
80104ce0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104ce1:	31 c0                	xor    %eax,%eax
{
80104ce3:	89 e5                	mov    %esp,%ebp
80104ce5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0)
80104ce8:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104ceb:	e8 c0 fe ff ff       	call   80104bb0 <argfd.constprop.0>
80104cf0:	85 c0                	test   %eax,%eax
80104cf2:	78 14                	js     80104d08 <sys_steal+0x28>
  return filesteal(f);
80104cf4:	83 ec 0c             	sub    $0xc,%esp
80104cf7:	ff 75 f4             	pushl  -0xc(%ebp)
80104cfa:	e8 b1 c3 ff ff       	call   801010b0 <filesteal>
80104cff:	83 c4 10             	add    $0x10,%esp
}
80104d02:	c9                   	leave  
80104d03:	c3                   	ret    
80104d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d0d:	c9                   	leave  
80104d0e:	c3                   	ret    
80104d0f:	90                   	nop

80104d10 <sys_write>:
{
80104d10:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d11:	31 c0                	xor    %eax,%eax
{
80104d13:	89 e5                	mov    %esp,%ebp
80104d15:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d18:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d1b:	e8 90 fe ff ff       	call   80104bb0 <argfd.constprop.0>
80104d20:	85 c0                	test   %eax,%eax
80104d22:	78 4c                	js     80104d70 <sys_write+0x60>
80104d24:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d27:	83 ec 08             	sub    $0x8,%esp
80104d2a:	50                   	push   %eax
80104d2b:	6a 02                	push   $0x2
80104d2d:	e8 8e fb ff ff       	call   801048c0 <argint>
80104d32:	83 c4 10             	add    $0x10,%esp
80104d35:	85 c0                	test   %eax,%eax
80104d37:	78 37                	js     80104d70 <sys_write+0x60>
80104d39:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d3c:	83 ec 04             	sub    $0x4,%esp
80104d3f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d42:	50                   	push   %eax
80104d43:	6a 01                	push   $0x1
80104d45:	e8 c6 fb ff ff       	call   80104910 <argptr>
80104d4a:	83 c4 10             	add    $0x10,%esp
80104d4d:	85 c0                	test   %eax,%eax
80104d4f:	78 1f                	js     80104d70 <sys_write+0x60>
  return filewrite(f, p, n);
80104d51:	83 ec 04             	sub    $0x4,%esp
80104d54:	ff 75 f0             	pushl  -0x10(%ebp)
80104d57:	ff 75 f4             	pushl  -0xc(%ebp)
80104d5a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d5d:	e8 be c3 ff ff       	call   80101120 <filewrite>
80104d62:	83 c4 10             	add    $0x10,%esp
}
80104d65:	c9                   	leave  
80104d66:	c3                   	ret    
80104d67:	89 f6                	mov    %esi,%esi
80104d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104d70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d75:	c9                   	leave  
80104d76:	c3                   	ret    
80104d77:	89 f6                	mov    %esi,%esi
80104d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d80 <sys_close>:
{
80104d80:	55                   	push   %ebp
80104d81:	89 e5                	mov    %esp,%ebp
80104d83:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104d86:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104d89:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d8c:	e8 1f fe ff ff       	call   80104bb0 <argfd.constprop.0>
80104d91:	85 c0                	test   %eax,%eax
80104d93:	78 2b                	js     80104dc0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104d95:	e8 b6 eb ff ff       	call   80103950 <myproc>
80104d9a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104d9d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104da0:	c7 44 90 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edx,4)
80104da7:	00 
  fileclose(f);
80104da8:	ff 75 f4             	pushl  -0xc(%ebp)
80104dab:	e8 50 c1 ff ff       	call   80100f00 <fileclose>
  return 0;
80104db0:	83 c4 10             	add    $0x10,%esp
80104db3:	31 c0                	xor    %eax,%eax
}
80104db5:	c9                   	leave  
80104db6:	c3                   	ret    
80104db7:	89 f6                	mov    %esi,%esi
80104db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104dc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104dc5:	c9                   	leave  
80104dc6:	c3                   	ret    
80104dc7:	89 f6                	mov    %esi,%esi
80104dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104dd0 <sys_fstat>:
{
80104dd0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104dd1:	31 c0                	xor    %eax,%eax
{
80104dd3:	89 e5                	mov    %esp,%ebp
80104dd5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104dd8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104ddb:	e8 d0 fd ff ff       	call   80104bb0 <argfd.constprop.0>
80104de0:	85 c0                	test   %eax,%eax
80104de2:	78 2c                	js     80104e10 <sys_fstat+0x40>
80104de4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104de7:	83 ec 04             	sub    $0x4,%esp
80104dea:	6a 14                	push   $0x14
80104dec:	50                   	push   %eax
80104ded:	6a 01                	push   $0x1
80104def:	e8 1c fb ff ff       	call   80104910 <argptr>
80104df4:	83 c4 10             	add    $0x10,%esp
80104df7:	85 c0                	test   %eax,%eax
80104df9:	78 15                	js     80104e10 <sys_fstat+0x40>
  return filestat(f, st);
80104dfb:	83 ec 08             	sub    $0x8,%esp
80104dfe:	ff 75 f4             	pushl  -0xc(%ebp)
80104e01:	ff 75 f0             	pushl  -0x10(%ebp)
80104e04:	e8 c7 c1 ff ff       	call   80100fd0 <filestat>
80104e09:	83 c4 10             	add    $0x10,%esp
}
80104e0c:	c9                   	leave  
80104e0d:	c3                   	ret    
80104e0e:	66 90                	xchg   %ax,%ax
    return -1;
80104e10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e15:	c9                   	leave  
80104e16:	c3                   	ret    
80104e17:	89 f6                	mov    %esi,%esi
80104e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e20 <sys_link>:
{
80104e20:	55                   	push   %ebp
80104e21:	89 e5                	mov    %esp,%ebp
80104e23:	57                   	push   %edi
80104e24:	56                   	push   %esi
80104e25:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e26:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104e29:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e2c:	50                   	push   %eax
80104e2d:	6a 00                	push   $0x0
80104e2f:	e8 3c fb ff ff       	call   80104970 <argstr>
80104e34:	83 c4 10             	add    $0x10,%esp
80104e37:	85 c0                	test   %eax,%eax
80104e39:	0f 88 fb 00 00 00    	js     80104f3a <sys_link+0x11a>
80104e3f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104e42:	83 ec 08             	sub    $0x8,%esp
80104e45:	50                   	push   %eax
80104e46:	6a 01                	push   $0x1
80104e48:	e8 23 fb ff ff       	call   80104970 <argstr>
80104e4d:	83 c4 10             	add    $0x10,%esp
80104e50:	85 c0                	test   %eax,%eax
80104e52:	0f 88 e2 00 00 00    	js     80104f3a <sys_link+0x11a>
  begin_op();
80104e58:	e8 b3 de ff ff       	call   80102d10 <begin_op>
  if((ip = namei(old)) == 0){
80104e5d:	83 ec 0c             	sub    $0xc,%esp
80104e60:	ff 75 d4             	pushl  -0x2c(%ebp)
80104e63:	e8 e8 d1 ff ff       	call   80102050 <namei>
80104e68:	83 c4 10             	add    $0x10,%esp
80104e6b:	85 c0                	test   %eax,%eax
80104e6d:	89 c3                	mov    %eax,%ebx
80104e6f:	0f 84 ea 00 00 00    	je     80104f5f <sys_link+0x13f>
  ilock(ip);
80104e75:	83 ec 0c             	sub    $0xc,%esp
80104e78:	50                   	push   %eax
80104e79:	e8 32 c9 ff ff       	call   801017b0 <ilock>
  if(ip->type == T_DIR){
80104e7e:	83 c4 10             	add    $0x10,%esp
80104e81:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104e86:	0f 84 bb 00 00 00    	je     80104f47 <sys_link+0x127>
  ip->nlink++;
80104e8c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104e91:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80104e94:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104e97:	53                   	push   %ebx
80104e98:	e8 63 c8 ff ff       	call   80101700 <iupdate>
  iunlock(ip);
80104e9d:	89 1c 24             	mov    %ebx,(%esp)
80104ea0:	e8 eb c9 ff ff       	call   80101890 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104ea5:	58                   	pop    %eax
80104ea6:	5a                   	pop    %edx
80104ea7:	57                   	push   %edi
80104ea8:	ff 75 d0             	pushl  -0x30(%ebp)
80104eab:	e8 c0 d1 ff ff       	call   80102070 <nameiparent>
80104eb0:	83 c4 10             	add    $0x10,%esp
80104eb3:	85 c0                	test   %eax,%eax
80104eb5:	89 c6                	mov    %eax,%esi
80104eb7:	74 5b                	je     80104f14 <sys_link+0xf4>
  ilock(dp);
80104eb9:	83 ec 0c             	sub    $0xc,%esp
80104ebc:	50                   	push   %eax
80104ebd:	e8 ee c8 ff ff       	call   801017b0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104ec2:	83 c4 10             	add    $0x10,%esp
80104ec5:	8b 03                	mov    (%ebx),%eax
80104ec7:	39 06                	cmp    %eax,(%esi)
80104ec9:	75 3d                	jne    80104f08 <sys_link+0xe8>
80104ecb:	83 ec 04             	sub    $0x4,%esp
80104ece:	ff 73 04             	pushl  0x4(%ebx)
80104ed1:	57                   	push   %edi
80104ed2:	56                   	push   %esi
80104ed3:	e8 b8 d0 ff ff       	call   80101f90 <dirlink>
80104ed8:	83 c4 10             	add    $0x10,%esp
80104edb:	85 c0                	test   %eax,%eax
80104edd:	78 29                	js     80104f08 <sys_link+0xe8>
  iunlockput(dp);
80104edf:	83 ec 0c             	sub    $0xc,%esp
80104ee2:	56                   	push   %esi
80104ee3:	e8 58 cb ff ff       	call   80101a40 <iunlockput>
  iput(ip);
80104ee8:	89 1c 24             	mov    %ebx,(%esp)
80104eeb:	e8 f0 c9 ff ff       	call   801018e0 <iput>
  end_op();
80104ef0:	e8 8b de ff ff       	call   80102d80 <end_op>
  return 0;
80104ef5:	83 c4 10             	add    $0x10,%esp
80104ef8:	31 c0                	xor    %eax,%eax
}
80104efa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104efd:	5b                   	pop    %ebx
80104efe:	5e                   	pop    %esi
80104eff:	5f                   	pop    %edi
80104f00:	5d                   	pop    %ebp
80104f01:	c3                   	ret    
80104f02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104f08:	83 ec 0c             	sub    $0xc,%esp
80104f0b:	56                   	push   %esi
80104f0c:	e8 2f cb ff ff       	call   80101a40 <iunlockput>
    goto bad;
80104f11:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104f14:	83 ec 0c             	sub    $0xc,%esp
80104f17:	53                   	push   %ebx
80104f18:	e8 93 c8 ff ff       	call   801017b0 <ilock>
  ip->nlink--;
80104f1d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f22:	89 1c 24             	mov    %ebx,(%esp)
80104f25:	e8 d6 c7 ff ff       	call   80101700 <iupdate>
  iunlockput(ip);
80104f2a:	89 1c 24             	mov    %ebx,(%esp)
80104f2d:	e8 0e cb ff ff       	call   80101a40 <iunlockput>
  end_op();
80104f32:	e8 49 de ff ff       	call   80102d80 <end_op>
  return -1;
80104f37:	83 c4 10             	add    $0x10,%esp
}
80104f3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104f3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f42:	5b                   	pop    %ebx
80104f43:	5e                   	pop    %esi
80104f44:	5f                   	pop    %edi
80104f45:	5d                   	pop    %ebp
80104f46:	c3                   	ret    
    iunlockput(ip);
80104f47:	83 ec 0c             	sub    $0xc,%esp
80104f4a:	53                   	push   %ebx
80104f4b:	e8 f0 ca ff ff       	call   80101a40 <iunlockput>
    end_op();
80104f50:	e8 2b de ff ff       	call   80102d80 <end_op>
    return -1;
80104f55:	83 c4 10             	add    $0x10,%esp
80104f58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f5d:	eb 9b                	jmp    80104efa <sys_link+0xda>
    end_op();
80104f5f:	e8 1c de ff ff       	call   80102d80 <end_op>
    return -1;
80104f64:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f69:	eb 8f                	jmp    80104efa <sys_link+0xda>
80104f6b:	90                   	nop
80104f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f70 <sys_unlink>:
{
80104f70:	55                   	push   %ebp
80104f71:	89 e5                	mov    %esp,%ebp
80104f73:	57                   	push   %edi
80104f74:	56                   	push   %esi
80104f75:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80104f76:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80104f79:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
80104f7c:	50                   	push   %eax
80104f7d:	6a 00                	push   $0x0
80104f7f:	e8 ec f9 ff ff       	call   80104970 <argstr>
80104f84:	83 c4 10             	add    $0x10,%esp
80104f87:	85 c0                	test   %eax,%eax
80104f89:	0f 88 77 01 00 00    	js     80105106 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
80104f8f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80104f92:	e8 79 dd ff ff       	call   80102d10 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104f97:	83 ec 08             	sub    $0x8,%esp
80104f9a:	53                   	push   %ebx
80104f9b:	ff 75 c0             	pushl  -0x40(%ebp)
80104f9e:	e8 cd d0 ff ff       	call   80102070 <nameiparent>
80104fa3:	83 c4 10             	add    $0x10,%esp
80104fa6:	85 c0                	test   %eax,%eax
80104fa8:	89 c6                	mov    %eax,%esi
80104faa:	0f 84 60 01 00 00    	je     80105110 <sys_unlink+0x1a0>
  ilock(dp);
80104fb0:	83 ec 0c             	sub    $0xc,%esp
80104fb3:	50                   	push   %eax
80104fb4:	e8 f7 c7 ff ff       	call   801017b0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104fb9:	58                   	pop    %eax
80104fba:	5a                   	pop    %edx
80104fbb:	68 dc 77 10 80       	push   $0x801077dc
80104fc0:	53                   	push   %ebx
80104fc1:	e8 3a cd ff ff       	call   80101d00 <namecmp>
80104fc6:	83 c4 10             	add    $0x10,%esp
80104fc9:	85 c0                	test   %eax,%eax
80104fcb:	0f 84 03 01 00 00    	je     801050d4 <sys_unlink+0x164>
80104fd1:	83 ec 08             	sub    $0x8,%esp
80104fd4:	68 db 77 10 80       	push   $0x801077db
80104fd9:	53                   	push   %ebx
80104fda:	e8 21 cd ff ff       	call   80101d00 <namecmp>
80104fdf:	83 c4 10             	add    $0x10,%esp
80104fe2:	85 c0                	test   %eax,%eax
80104fe4:	0f 84 ea 00 00 00    	je     801050d4 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
80104fea:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104fed:	83 ec 04             	sub    $0x4,%esp
80104ff0:	50                   	push   %eax
80104ff1:	53                   	push   %ebx
80104ff2:	56                   	push   %esi
80104ff3:	e8 28 cd ff ff       	call   80101d20 <dirlookup>
80104ff8:	83 c4 10             	add    $0x10,%esp
80104ffb:	85 c0                	test   %eax,%eax
80104ffd:	89 c3                	mov    %eax,%ebx
80104fff:	0f 84 cf 00 00 00    	je     801050d4 <sys_unlink+0x164>
  ilock(ip);
80105005:	83 ec 0c             	sub    $0xc,%esp
80105008:	50                   	push   %eax
80105009:	e8 a2 c7 ff ff       	call   801017b0 <ilock>
  if(ip->nlink < 1)
8010500e:	83 c4 10             	add    $0x10,%esp
80105011:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105016:	0f 8e 10 01 00 00    	jle    8010512c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010501c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105021:	74 6d                	je     80105090 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105023:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105026:	83 ec 04             	sub    $0x4,%esp
80105029:	6a 10                	push   $0x10
8010502b:	6a 00                	push   $0x0
8010502d:	50                   	push   %eax
8010502e:	e8 8d f5 ff ff       	call   801045c0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105033:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105036:	6a 10                	push   $0x10
80105038:	ff 75 c4             	pushl  -0x3c(%ebp)
8010503b:	50                   	push   %eax
8010503c:	56                   	push   %esi
8010503d:	e8 8e cb ff ff       	call   80101bd0 <writei>
80105042:	83 c4 20             	add    $0x20,%esp
80105045:	83 f8 10             	cmp    $0x10,%eax
80105048:	0f 85 eb 00 00 00    	jne    80105139 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
8010504e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105053:	0f 84 97 00 00 00    	je     801050f0 <sys_unlink+0x180>
  iunlockput(dp);
80105059:	83 ec 0c             	sub    $0xc,%esp
8010505c:	56                   	push   %esi
8010505d:	e8 de c9 ff ff       	call   80101a40 <iunlockput>
  ip->nlink--;
80105062:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105067:	89 1c 24             	mov    %ebx,(%esp)
8010506a:	e8 91 c6 ff ff       	call   80101700 <iupdate>
  iunlockput(ip);
8010506f:	89 1c 24             	mov    %ebx,(%esp)
80105072:	e8 c9 c9 ff ff       	call   80101a40 <iunlockput>
  end_op();
80105077:	e8 04 dd ff ff       	call   80102d80 <end_op>
  return 0;
8010507c:	83 c4 10             	add    $0x10,%esp
8010507f:	31 c0                	xor    %eax,%eax
}
80105081:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105084:	5b                   	pop    %ebx
80105085:	5e                   	pop    %esi
80105086:	5f                   	pop    %edi
80105087:	5d                   	pop    %ebp
80105088:	c3                   	ret    
80105089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105090:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105094:	76 8d                	jbe    80105023 <sys_unlink+0xb3>
80105096:	bf 20 00 00 00       	mov    $0x20,%edi
8010509b:	eb 0f                	jmp    801050ac <sys_unlink+0x13c>
8010509d:	8d 76 00             	lea    0x0(%esi),%esi
801050a0:	83 c7 10             	add    $0x10,%edi
801050a3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801050a6:	0f 83 77 ff ff ff    	jae    80105023 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801050ac:	8d 45 d8             	lea    -0x28(%ebp),%eax
801050af:	6a 10                	push   $0x10
801050b1:	57                   	push   %edi
801050b2:	50                   	push   %eax
801050b3:	53                   	push   %ebx
801050b4:	e8 d7 c9 ff ff       	call   80101a90 <readi>
801050b9:	83 c4 10             	add    $0x10,%esp
801050bc:	83 f8 10             	cmp    $0x10,%eax
801050bf:	75 5e                	jne    8010511f <sys_unlink+0x1af>
    if(de.inum != 0)
801050c1:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801050c6:	74 d8                	je     801050a0 <sys_unlink+0x130>
    iunlockput(ip);
801050c8:	83 ec 0c             	sub    $0xc,%esp
801050cb:	53                   	push   %ebx
801050cc:	e8 6f c9 ff ff       	call   80101a40 <iunlockput>
    goto bad;
801050d1:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
801050d4:	83 ec 0c             	sub    $0xc,%esp
801050d7:	56                   	push   %esi
801050d8:	e8 63 c9 ff ff       	call   80101a40 <iunlockput>
  end_op();
801050dd:	e8 9e dc ff ff       	call   80102d80 <end_op>
  return -1;
801050e2:	83 c4 10             	add    $0x10,%esp
801050e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050ea:	eb 95                	jmp    80105081 <sys_unlink+0x111>
801050ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
801050f0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801050f5:	83 ec 0c             	sub    $0xc,%esp
801050f8:	56                   	push   %esi
801050f9:	e8 02 c6 ff ff       	call   80101700 <iupdate>
801050fe:	83 c4 10             	add    $0x10,%esp
80105101:	e9 53 ff ff ff       	jmp    80105059 <sys_unlink+0xe9>
    return -1;
80105106:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010510b:	e9 71 ff ff ff       	jmp    80105081 <sys_unlink+0x111>
    end_op();
80105110:	e8 6b dc ff ff       	call   80102d80 <end_op>
    return -1;
80105115:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010511a:	e9 62 ff ff ff       	jmp    80105081 <sys_unlink+0x111>
      panic("isdirempty: readi");
8010511f:	83 ec 0c             	sub    $0xc,%esp
80105122:	68 00 78 10 80       	push   $0x80107800
80105127:	e8 24 b3 ff ff       	call   80100450 <panic>
    panic("unlink: nlink < 1");
8010512c:	83 ec 0c             	sub    $0xc,%esp
8010512f:	68 ee 77 10 80       	push   $0x801077ee
80105134:	e8 17 b3 ff ff       	call   80100450 <panic>
    panic("unlink: writei");
80105139:	83 ec 0c             	sub    $0xc,%esp
8010513c:	68 12 78 10 80       	push   $0x80107812
80105141:	e8 0a b3 ff ff       	call   80100450 <panic>
80105146:	8d 76 00             	lea    0x0(%esi),%esi
80105149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105150 <sys_open>:

int
sys_open(void)
{
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	57                   	push   %edi
80105154:	56                   	push   %esi
80105155:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105156:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105159:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010515c:	50                   	push   %eax
8010515d:	6a 00                	push   $0x0
8010515f:	e8 0c f8 ff ff       	call   80104970 <argstr>
80105164:	83 c4 10             	add    $0x10,%esp
80105167:	85 c0                	test   %eax,%eax
80105169:	0f 88 1d 01 00 00    	js     8010528c <sys_open+0x13c>
8010516f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105172:	83 ec 08             	sub    $0x8,%esp
80105175:	50                   	push   %eax
80105176:	6a 01                	push   $0x1
80105178:	e8 43 f7 ff ff       	call   801048c0 <argint>
8010517d:	83 c4 10             	add    $0x10,%esp
80105180:	85 c0                	test   %eax,%eax
80105182:	0f 88 04 01 00 00    	js     8010528c <sys_open+0x13c>
    return -1;

  begin_op();
80105188:	e8 83 db ff ff       	call   80102d10 <begin_op>

  if(omode & O_CREATE){
8010518d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105191:	0f 85 a9 00 00 00    	jne    80105240 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105197:	83 ec 0c             	sub    $0xc,%esp
8010519a:	ff 75 e0             	pushl  -0x20(%ebp)
8010519d:	e8 ae ce ff ff       	call   80102050 <namei>
801051a2:	83 c4 10             	add    $0x10,%esp
801051a5:	85 c0                	test   %eax,%eax
801051a7:	89 c6                	mov    %eax,%esi
801051a9:	0f 84 b2 00 00 00    	je     80105261 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
801051af:	83 ec 0c             	sub    $0xc,%esp
801051b2:	50                   	push   %eax
801051b3:	e8 f8 c5 ff ff       	call   801017b0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801051b8:	83 c4 10             	add    $0x10,%esp
801051bb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801051c0:	0f 84 aa 00 00 00    	je     80105270 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801051c6:	e8 75 bc ff ff       	call   80100e40 <filealloc>
801051cb:	85 c0                	test   %eax,%eax
801051cd:	89 c7                	mov    %eax,%edi
801051cf:	0f 84 a6 00 00 00    	je     8010527b <sys_open+0x12b>
  struct proc *curproc = myproc();
801051d5:	e8 76 e7 ff ff       	call   80103950 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801051da:	31 db                	xor    %ebx,%ebx
801051dc:	eb 0e                	jmp    801051ec <sys_open+0x9c>
801051de:	66 90                	xchg   %ax,%ax
801051e0:	83 c3 01             	add    $0x1,%ebx
801051e3:	83 fb 10             	cmp    $0x10,%ebx
801051e6:	0f 84 ac 00 00 00    	je     80105298 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
801051ec:	8b 54 98 2c          	mov    0x2c(%eax,%ebx,4),%edx
801051f0:	85 d2                	test   %edx,%edx
801051f2:	75 ec                	jne    801051e0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801051f4:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801051f7:	89 7c 98 2c          	mov    %edi,0x2c(%eax,%ebx,4)
  iunlock(ip);
801051fb:	56                   	push   %esi
801051fc:	e8 8f c6 ff ff       	call   80101890 <iunlock>
  end_op();
80105201:	e8 7a db ff ff       	call   80102d80 <end_op>

  f->type = FD_INODE;
80105206:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010520c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010520f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105212:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105215:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010521c:	89 d0                	mov    %edx,%eax
8010521e:	f7 d0                	not    %eax
80105220:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105223:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105226:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105229:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010522d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105230:	89 d8                	mov    %ebx,%eax
80105232:	5b                   	pop    %ebx
80105233:	5e                   	pop    %esi
80105234:	5f                   	pop    %edi
80105235:	5d                   	pop    %ebp
80105236:	c3                   	ret    
80105237:	89 f6                	mov    %esi,%esi
80105239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105240:	83 ec 0c             	sub    $0xc,%esp
80105243:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105246:	31 c9                	xor    %ecx,%ecx
80105248:	6a 00                	push   $0x0
8010524a:	ba 02 00 00 00       	mov    $0x2,%edx
8010524f:	e8 bc f7 ff ff       	call   80104a10 <create>
    if(ip == 0){
80105254:	83 c4 10             	add    $0x10,%esp
80105257:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105259:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010525b:	0f 85 65 ff ff ff    	jne    801051c6 <sys_open+0x76>
      end_op();
80105261:	e8 1a db ff ff       	call   80102d80 <end_op>
      return -1;
80105266:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010526b:	eb c0                	jmp    8010522d <sys_open+0xdd>
8010526d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105270:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105273:	85 c9                	test   %ecx,%ecx
80105275:	0f 84 4b ff ff ff    	je     801051c6 <sys_open+0x76>
    iunlockput(ip);
8010527b:	83 ec 0c             	sub    $0xc,%esp
8010527e:	56                   	push   %esi
8010527f:	e8 bc c7 ff ff       	call   80101a40 <iunlockput>
    end_op();
80105284:	e8 f7 da ff ff       	call   80102d80 <end_op>
    return -1;
80105289:	83 c4 10             	add    $0x10,%esp
8010528c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105291:	eb 9a                	jmp    8010522d <sys_open+0xdd>
80105293:	90                   	nop
80105294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105298:	83 ec 0c             	sub    $0xc,%esp
8010529b:	57                   	push   %edi
8010529c:	e8 5f bc ff ff       	call   80100f00 <fileclose>
801052a1:	83 c4 10             	add    $0x10,%esp
801052a4:	eb d5                	jmp    8010527b <sys_open+0x12b>
801052a6:	8d 76 00             	lea    0x0(%esi),%esi
801052a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052b0 <sys_mkdir>:

int
sys_mkdir(void)
{
801052b0:	55                   	push   %ebp
801052b1:	89 e5                	mov    %esp,%ebp
801052b3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801052b6:	e8 55 da ff ff       	call   80102d10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801052bb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052be:	83 ec 08             	sub    $0x8,%esp
801052c1:	50                   	push   %eax
801052c2:	6a 00                	push   $0x0
801052c4:	e8 a7 f6 ff ff       	call   80104970 <argstr>
801052c9:	83 c4 10             	add    $0x10,%esp
801052cc:	85 c0                	test   %eax,%eax
801052ce:	78 30                	js     80105300 <sys_mkdir+0x50>
801052d0:	83 ec 0c             	sub    $0xc,%esp
801052d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052d6:	31 c9                	xor    %ecx,%ecx
801052d8:	6a 00                	push   $0x0
801052da:	ba 01 00 00 00       	mov    $0x1,%edx
801052df:	e8 2c f7 ff ff       	call   80104a10 <create>
801052e4:	83 c4 10             	add    $0x10,%esp
801052e7:	85 c0                	test   %eax,%eax
801052e9:	74 15                	je     80105300 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801052eb:	83 ec 0c             	sub    $0xc,%esp
801052ee:	50                   	push   %eax
801052ef:	e8 4c c7 ff ff       	call   80101a40 <iunlockput>
  end_op();
801052f4:	e8 87 da ff ff       	call   80102d80 <end_op>
  return 0;
801052f9:	83 c4 10             	add    $0x10,%esp
801052fc:	31 c0                	xor    %eax,%eax
}
801052fe:	c9                   	leave  
801052ff:	c3                   	ret    
    end_op();
80105300:	e8 7b da ff ff       	call   80102d80 <end_op>
    return -1;
80105305:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010530a:	c9                   	leave  
8010530b:	c3                   	ret    
8010530c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105310 <sys_mknod>:

int
sys_mknod(void)
{
80105310:	55                   	push   %ebp
80105311:	89 e5                	mov    %esp,%ebp
80105313:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105316:	e8 f5 d9 ff ff       	call   80102d10 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010531b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010531e:	83 ec 08             	sub    $0x8,%esp
80105321:	50                   	push   %eax
80105322:	6a 00                	push   $0x0
80105324:	e8 47 f6 ff ff       	call   80104970 <argstr>
80105329:	83 c4 10             	add    $0x10,%esp
8010532c:	85 c0                	test   %eax,%eax
8010532e:	78 60                	js     80105390 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105330:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105333:	83 ec 08             	sub    $0x8,%esp
80105336:	50                   	push   %eax
80105337:	6a 01                	push   $0x1
80105339:	e8 82 f5 ff ff       	call   801048c0 <argint>
  if((argstr(0, &path)) < 0 ||
8010533e:	83 c4 10             	add    $0x10,%esp
80105341:	85 c0                	test   %eax,%eax
80105343:	78 4b                	js     80105390 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105345:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105348:	83 ec 08             	sub    $0x8,%esp
8010534b:	50                   	push   %eax
8010534c:	6a 02                	push   $0x2
8010534e:	e8 6d f5 ff ff       	call   801048c0 <argint>
     argint(1, &major) < 0 ||
80105353:	83 c4 10             	add    $0x10,%esp
80105356:	85 c0                	test   %eax,%eax
80105358:	78 36                	js     80105390 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010535a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010535e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105361:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105365:	ba 03 00 00 00       	mov    $0x3,%edx
8010536a:	50                   	push   %eax
8010536b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010536e:	e8 9d f6 ff ff       	call   80104a10 <create>
80105373:	83 c4 10             	add    $0x10,%esp
80105376:	85 c0                	test   %eax,%eax
80105378:	74 16                	je     80105390 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010537a:	83 ec 0c             	sub    $0xc,%esp
8010537d:	50                   	push   %eax
8010537e:	e8 bd c6 ff ff       	call   80101a40 <iunlockput>
  end_op();
80105383:	e8 f8 d9 ff ff       	call   80102d80 <end_op>
  return 0;
80105388:	83 c4 10             	add    $0x10,%esp
8010538b:	31 c0                	xor    %eax,%eax
}
8010538d:	c9                   	leave  
8010538e:	c3                   	ret    
8010538f:	90                   	nop
    end_op();
80105390:	e8 eb d9 ff ff       	call   80102d80 <end_op>
    return -1;
80105395:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010539a:	c9                   	leave  
8010539b:	c3                   	ret    
8010539c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053a0 <sys_chdir>:

int
sys_chdir(void)
{
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	56                   	push   %esi
801053a4:	53                   	push   %ebx
801053a5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801053a8:	e8 a3 e5 ff ff       	call   80103950 <myproc>
801053ad:	89 c6                	mov    %eax,%esi
  
  begin_op();
801053af:	e8 5c d9 ff ff       	call   80102d10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801053b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053b7:	83 ec 08             	sub    $0x8,%esp
801053ba:	50                   	push   %eax
801053bb:	6a 00                	push   $0x0
801053bd:	e8 ae f5 ff ff       	call   80104970 <argstr>
801053c2:	83 c4 10             	add    $0x10,%esp
801053c5:	85 c0                	test   %eax,%eax
801053c7:	78 77                	js     80105440 <sys_chdir+0xa0>
801053c9:	83 ec 0c             	sub    $0xc,%esp
801053cc:	ff 75 f4             	pushl  -0xc(%ebp)
801053cf:	e8 7c cc ff ff       	call   80102050 <namei>
801053d4:	83 c4 10             	add    $0x10,%esp
801053d7:	85 c0                	test   %eax,%eax
801053d9:	89 c3                	mov    %eax,%ebx
801053db:	74 63                	je     80105440 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801053dd:	83 ec 0c             	sub    $0xc,%esp
801053e0:	50                   	push   %eax
801053e1:	e8 ca c3 ff ff       	call   801017b0 <ilock>
  if(ip->type != T_DIR){
801053e6:	83 c4 10             	add    $0x10,%esp
801053e9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053ee:	75 30                	jne    80105420 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801053f0:	83 ec 0c             	sub    $0xc,%esp
801053f3:	53                   	push   %ebx
801053f4:	e8 97 c4 ff ff       	call   80101890 <iunlock>
  iput(curproc->cwd);
801053f9:	58                   	pop    %eax
801053fa:	ff 76 6c             	pushl  0x6c(%esi)
801053fd:	e8 de c4 ff ff       	call   801018e0 <iput>
  end_op();
80105402:	e8 79 d9 ff ff       	call   80102d80 <end_op>
  curproc->cwd = ip;
80105407:	89 5e 6c             	mov    %ebx,0x6c(%esi)
  return 0;
8010540a:	83 c4 10             	add    $0x10,%esp
8010540d:	31 c0                	xor    %eax,%eax
}
8010540f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105412:	5b                   	pop    %ebx
80105413:	5e                   	pop    %esi
80105414:	5d                   	pop    %ebp
80105415:	c3                   	ret    
80105416:	8d 76 00             	lea    0x0(%esi),%esi
80105419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105420:	83 ec 0c             	sub    $0xc,%esp
80105423:	53                   	push   %ebx
80105424:	e8 17 c6 ff ff       	call   80101a40 <iunlockput>
    end_op();
80105429:	e8 52 d9 ff ff       	call   80102d80 <end_op>
    return -1;
8010542e:	83 c4 10             	add    $0x10,%esp
80105431:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105436:	eb d7                	jmp    8010540f <sys_chdir+0x6f>
80105438:	90                   	nop
80105439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105440:	e8 3b d9 ff ff       	call   80102d80 <end_op>
    return -1;
80105445:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010544a:	eb c3                	jmp    8010540f <sys_chdir+0x6f>
8010544c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105450 <sys_exec>:

int
sys_exec(void)
{
80105450:	55                   	push   %ebp
80105451:	89 e5                	mov    %esp,%ebp
80105453:	57                   	push   %edi
80105454:	56                   	push   %esi
80105455:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105456:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010545c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105462:	50                   	push   %eax
80105463:	6a 00                	push   $0x0
80105465:	e8 06 f5 ff ff       	call   80104970 <argstr>
8010546a:	83 c4 10             	add    $0x10,%esp
8010546d:	85 c0                	test   %eax,%eax
8010546f:	0f 88 87 00 00 00    	js     801054fc <sys_exec+0xac>
80105475:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010547b:	83 ec 08             	sub    $0x8,%esp
8010547e:	50                   	push   %eax
8010547f:	6a 01                	push   $0x1
80105481:	e8 3a f4 ff ff       	call   801048c0 <argint>
80105486:	83 c4 10             	add    $0x10,%esp
80105489:	85 c0                	test   %eax,%eax
8010548b:	78 6f                	js     801054fc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010548d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105493:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105496:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105498:	68 80 00 00 00       	push   $0x80
8010549d:	6a 00                	push   $0x0
8010549f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801054a5:	50                   	push   %eax
801054a6:	e8 15 f1 ff ff       	call   801045c0 <memset>
801054ab:	83 c4 10             	add    $0x10,%esp
801054ae:	eb 2c                	jmp    801054dc <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
801054b0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801054b6:	85 c0                	test   %eax,%eax
801054b8:	74 56                	je     80105510 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801054ba:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801054c0:	83 ec 08             	sub    $0x8,%esp
801054c3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801054c6:	52                   	push   %edx
801054c7:	50                   	push   %eax
801054c8:	e8 83 f3 ff ff       	call   80104850 <fetchstr>
801054cd:	83 c4 10             	add    $0x10,%esp
801054d0:	85 c0                	test   %eax,%eax
801054d2:	78 28                	js     801054fc <sys_exec+0xac>
  for(i=0;; i++){
801054d4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801054d7:	83 fb 20             	cmp    $0x20,%ebx
801054da:	74 20                	je     801054fc <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801054dc:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801054e2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801054e9:	83 ec 08             	sub    $0x8,%esp
801054ec:	57                   	push   %edi
801054ed:	01 f0                	add    %esi,%eax
801054ef:	50                   	push   %eax
801054f0:	e8 1b f3 ff ff       	call   80104810 <fetchint>
801054f5:	83 c4 10             	add    $0x10,%esp
801054f8:	85 c0                	test   %eax,%eax
801054fa:	79 b4                	jns    801054b0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801054fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801054ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105504:	5b                   	pop    %ebx
80105505:	5e                   	pop    %esi
80105506:	5f                   	pop    %edi
80105507:	5d                   	pop    %ebp
80105508:	c3                   	ret    
80105509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105510:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105516:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105519:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105520:	00 00 00 00 
  return exec(path, argv);
80105524:	50                   	push   %eax
80105525:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010552b:	e8 a0 b5 ff ff       	call   80100ad0 <exec>
80105530:	83 c4 10             	add    $0x10,%esp
}
80105533:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105536:	5b                   	pop    %ebx
80105537:	5e                   	pop    %esi
80105538:	5f                   	pop    %edi
80105539:	5d                   	pop    %ebp
8010553a:	c3                   	ret    
8010553b:	90                   	nop
8010553c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105540 <sys_pipe>:

int
sys_pipe(void)
{
80105540:	55                   	push   %ebp
80105541:	89 e5                	mov    %esp,%ebp
80105543:	57                   	push   %edi
80105544:	56                   	push   %esi
80105545:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105546:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105549:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010554c:	6a 08                	push   $0x8
8010554e:	50                   	push   %eax
8010554f:	6a 00                	push   $0x0
80105551:	e8 ba f3 ff ff       	call   80104910 <argptr>
80105556:	83 c4 10             	add    $0x10,%esp
80105559:	85 c0                	test   %eax,%eax
8010555b:	0f 88 ae 00 00 00    	js     8010560f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105561:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105564:	83 ec 08             	sub    $0x8,%esp
80105567:	50                   	push   %eax
80105568:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010556b:	50                   	push   %eax
8010556c:	e8 3f de ff ff       	call   801033b0 <pipealloc>
80105571:	83 c4 10             	add    $0x10,%esp
80105574:	85 c0                	test   %eax,%eax
80105576:	0f 88 93 00 00 00    	js     8010560f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010557c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010557f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105581:	e8 ca e3 ff ff       	call   80103950 <myproc>
80105586:	eb 10                	jmp    80105598 <sys_pipe+0x58>
80105588:	90                   	nop
80105589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105590:	83 c3 01             	add    $0x1,%ebx
80105593:	83 fb 10             	cmp    $0x10,%ebx
80105596:	74 60                	je     801055f8 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105598:	8b 74 98 2c          	mov    0x2c(%eax,%ebx,4),%esi
8010559c:	85 f6                	test   %esi,%esi
8010559e:	75 f0                	jne    80105590 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
801055a0:	8d 73 08             	lea    0x8(%ebx),%esi
801055a3:	89 7c b0 0c          	mov    %edi,0xc(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801055a7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801055aa:	e8 a1 e3 ff ff       	call   80103950 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801055af:	31 d2                	xor    %edx,%edx
801055b1:	eb 0d                	jmp    801055c0 <sys_pipe+0x80>
801055b3:	90                   	nop
801055b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055b8:	83 c2 01             	add    $0x1,%edx
801055bb:	83 fa 10             	cmp    $0x10,%edx
801055be:	74 28                	je     801055e8 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
801055c0:	8b 4c 90 2c          	mov    0x2c(%eax,%edx,4),%ecx
801055c4:	85 c9                	test   %ecx,%ecx
801055c6:	75 f0                	jne    801055b8 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
801055c8:	89 7c 90 2c          	mov    %edi,0x2c(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801055cc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801055cf:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801055d1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801055d4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801055d7:	31 c0                	xor    %eax,%eax
}
801055d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055dc:	5b                   	pop    %ebx
801055dd:	5e                   	pop    %esi
801055de:	5f                   	pop    %edi
801055df:	5d                   	pop    %ebp
801055e0:	c3                   	ret    
801055e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
801055e8:	e8 63 e3 ff ff       	call   80103950 <myproc>
801055ed:	c7 44 b0 0c 00 00 00 	movl   $0x0,0xc(%eax,%esi,4)
801055f4:	00 
801055f5:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
801055f8:	83 ec 0c             	sub    $0xc,%esp
801055fb:	ff 75 e0             	pushl  -0x20(%ebp)
801055fe:	e8 fd b8 ff ff       	call   80100f00 <fileclose>
    fileclose(wf);
80105603:	58                   	pop    %eax
80105604:	ff 75 e4             	pushl  -0x1c(%ebp)
80105607:	e8 f4 b8 ff ff       	call   80100f00 <fileclose>
    return -1;
8010560c:	83 c4 10             	add    $0x10,%esp
8010560f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105614:	eb c3                	jmp    801055d9 <sys_pipe+0x99>
80105616:	66 90                	xchg   %ax,%ax
80105618:	66 90                	xchg   %ax,%ax
8010561a:	66 90                	xchg   %ax,%ax
8010561c:	66 90                	xchg   %ax,%ax
8010561e:	66 90                	xchg   %ax,%ax

80105620 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105623:	5d                   	pop    %ebp
  return fork();
80105624:	e9 c7 e4 ff ff       	jmp    80103af0 <fork>
80105629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105630 <sys_exit>:

int
sys_exit(void)
{
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	83 ec 08             	sub    $0x8,%esp
  exit();
80105636:	e8 35 e7 ff ff       	call   80103d70 <exit>
  return 0;  // not reached
}
8010563b:	31 c0                	xor    %eax,%eax
8010563d:	c9                   	leave  
8010563e:	c3                   	ret    
8010563f:	90                   	nop

80105640 <sys_wait>:

int
sys_wait(void)
{
80105640:	55                   	push   %ebp
80105641:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105643:	5d                   	pop    %ebp
  return wait();
80105644:	e9 67 e9 ff ff       	jmp    80103fb0 <wait>
80105649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105650 <sys_kill>:

int
sys_kill(void)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105656:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105659:	50                   	push   %eax
8010565a:	6a 00                	push   $0x0
8010565c:	e8 5f f2 ff ff       	call   801048c0 <argint>
80105661:	83 c4 10             	add    $0x10,%esp
80105664:	85 c0                	test   %eax,%eax
80105666:	78 18                	js     80105680 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105668:	83 ec 0c             	sub    $0xc,%esp
8010566b:	ff 75 f4             	pushl  -0xc(%ebp)
8010566e:	e8 8d ea ff ff       	call   80104100 <kill>
80105673:	83 c4 10             	add    $0x10,%esp
}
80105676:	c9                   	leave  
80105677:	c3                   	ret    
80105678:	90                   	nop
80105679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105680:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105685:	c9                   	leave  
80105686:	c3                   	ret    
80105687:	89 f6                	mov    %esi,%esi
80105689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105690 <sys_getpid>:

int
sys_getpid(void)
{
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
80105693:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105696:	e8 b5 e2 ff ff       	call   80103950 <myproc>
8010569b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010569e:	c9                   	leave  
8010569f:	c3                   	ret    

801056a0 <sys_sbrk>:

int
sys_sbrk(void)
{
801056a0:	55                   	push   %ebp
801056a1:	89 e5                	mov    %esp,%ebp
801056a3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801056a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801056a7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801056aa:	50                   	push   %eax
801056ab:	6a 00                	push   $0x0
801056ad:	e8 0e f2 ff ff       	call   801048c0 <argint>
801056b2:	83 c4 10             	add    $0x10,%esp
801056b5:	85 c0                	test   %eax,%eax
801056b7:	78 27                	js     801056e0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801056b9:	e8 92 e2 ff ff       	call   80103950 <myproc>
  if(growproc(n) < 0)
801056be:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801056c1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801056c3:	ff 75 f4             	pushl  -0xc(%ebp)
801056c6:	e8 a5 e3 ff ff       	call   80103a70 <growproc>
801056cb:	83 c4 10             	add    $0x10,%esp
801056ce:	85 c0                	test   %eax,%eax
801056d0:	78 0e                	js     801056e0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801056d2:	89 d8                	mov    %ebx,%eax
801056d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056d7:	c9                   	leave  
801056d8:	c3                   	ret    
801056d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801056e0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801056e5:	eb eb                	jmp    801056d2 <sys_sbrk+0x32>
801056e7:	89 f6                	mov    %esi,%esi
801056e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056f0 <sys_sleep>:

int
sys_sleep(void)
{
801056f0:	55                   	push   %ebp
801056f1:	89 e5                	mov    %esp,%ebp
801056f3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801056f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801056f7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801056fa:	50                   	push   %eax
801056fb:	6a 00                	push   $0x0
801056fd:	e8 be f1 ff ff       	call   801048c0 <argint>
80105702:	83 c4 10             	add    $0x10,%esp
80105705:	85 c0                	test   %eax,%eax
80105707:	0f 88 8a 00 00 00    	js     80105797 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010570d:	83 ec 0c             	sub    $0xc,%esp
80105710:	68 80 4d 11 80       	push   $0x80114d80
80105715:	e8 96 ed ff ff       	call   801044b0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010571a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010571d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105720:	8b 1d c0 55 11 80    	mov    0x801155c0,%ebx
  while(ticks - ticks0 < n){
80105726:	85 d2                	test   %edx,%edx
80105728:	75 27                	jne    80105751 <sys_sleep+0x61>
8010572a:	eb 54                	jmp    80105780 <sys_sleep+0x90>
8010572c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105730:	83 ec 08             	sub    $0x8,%esp
80105733:	68 80 4d 11 80       	push   $0x80114d80
80105738:	68 c0 55 11 80       	push   $0x801155c0
8010573d:	e8 ae e7 ff ff       	call   80103ef0 <sleep>
  while(ticks - ticks0 < n){
80105742:	a1 c0 55 11 80       	mov    0x801155c0,%eax
80105747:	83 c4 10             	add    $0x10,%esp
8010574a:	29 d8                	sub    %ebx,%eax
8010574c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010574f:	73 2f                	jae    80105780 <sys_sleep+0x90>
    if(myproc()->killed){
80105751:	e8 fa e1 ff ff       	call   80103950 <myproc>
80105756:	8b 40 24             	mov    0x24(%eax),%eax
80105759:	85 c0                	test   %eax,%eax
8010575b:	74 d3                	je     80105730 <sys_sleep+0x40>
      release(&tickslock);
8010575d:	83 ec 0c             	sub    $0xc,%esp
80105760:	68 80 4d 11 80       	push   $0x80114d80
80105765:	e8 06 ee ff ff       	call   80104570 <release>
      return -1;
8010576a:	83 c4 10             	add    $0x10,%esp
8010576d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105772:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105775:	c9                   	leave  
80105776:	c3                   	ret    
80105777:	89 f6                	mov    %esi,%esi
80105779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105780:	83 ec 0c             	sub    $0xc,%esp
80105783:	68 80 4d 11 80       	push   $0x80114d80
80105788:	e8 e3 ed ff ff       	call   80104570 <release>
  return 0;
8010578d:	83 c4 10             	add    $0x10,%esp
80105790:	31 c0                	xor    %eax,%eax
}
80105792:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105795:	c9                   	leave  
80105796:	c3                   	ret    
    return -1;
80105797:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010579c:	eb f4                	jmp    80105792 <sys_sleep+0xa2>
8010579e:	66 90                	xchg   %ax,%ax

801057a0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801057a0:	55                   	push   %ebp
801057a1:	89 e5                	mov    %esp,%ebp
801057a3:	53                   	push   %ebx
801057a4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801057a7:	68 80 4d 11 80       	push   $0x80114d80
801057ac:	e8 ff ec ff ff       	call   801044b0 <acquire>
  xticks = ticks;
801057b1:	8b 1d c0 55 11 80    	mov    0x801155c0,%ebx
  release(&tickslock);
801057b7:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801057be:	e8 ad ed ff ff       	call   80104570 <release>
  return xticks;
}
801057c3:	89 d8                	mov    %ebx,%eax
801057c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057c8:	c9                   	leave  
801057c9:	c3                   	ret    
801057ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801057d0 <sys_cpuhalt>:

//to halt or kill the virtual machine
int
sys_cpuhalt(void){
801057d0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801057d1:	b8 00 20 00 00       	mov    $0x2000,%eax
801057d6:	ba 04 06 00 00       	mov    $0x604,%edx
801057db:	89 e5                	mov    %esp,%ebp
801057dd:	66 ef                	out    %ax,(%dx)
  //https://wiki.osdev.org/Shutdown
  outw(0x604, 0x2000);
  return 0;
}
801057df:	31 c0                	xor    %eax,%eax
801057e1:	5d                   	pop    %ebp
801057e2:	c3                   	ret    

801057e3 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801057e3:	1e                   	push   %ds
  pushl %es
801057e4:	06                   	push   %es
  pushl %fs
801057e5:	0f a0                	push   %fs
  pushl %gs
801057e7:	0f a8                	push   %gs
  pushal
801057e9:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801057ea:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801057ee:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801057f0:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801057f2:	54                   	push   %esp
  call trap
801057f3:	e8 c8 00 00 00       	call   801058c0 <trap>
  addl $4, %esp
801057f8:	83 c4 04             	add    $0x4,%esp

801057fb <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801057fb:	61                   	popa   
  popl %gs
801057fc:	0f a9                	pop    %gs
  popl %fs
801057fe:	0f a1                	pop    %fs
  popl %es
80105800:	07                   	pop    %es
  popl %ds
80105801:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105802:	83 c4 08             	add    $0x8,%esp
  iret
80105805:	cf                   	iret   
80105806:	66 90                	xchg   %ax,%ax
80105808:	66 90                	xchg   %ax,%ax
8010580a:	66 90                	xchg   %ax,%ax
8010580c:	66 90                	xchg   %ax,%ax
8010580e:	66 90                	xchg   %ax,%ax

80105810 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105810:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105811:	31 c0                	xor    %eax,%eax
{
80105813:	89 e5                	mov    %esp,%ebp
80105815:	83 ec 08             	sub    $0x8,%esp
80105818:	90                   	nop
80105819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105820:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105827:	c7 04 c5 c2 4d 11 80 	movl   $0x8e000008,-0x7feeb23e(,%eax,8)
8010582e:	08 00 00 8e 
80105832:	66 89 14 c5 c0 4d 11 	mov    %dx,-0x7feeb240(,%eax,8)
80105839:	80 
8010583a:	c1 ea 10             	shr    $0x10,%edx
8010583d:	66 89 14 c5 c6 4d 11 	mov    %dx,-0x7feeb23a(,%eax,8)
80105844:	80 
  for(i = 0; i < 256; i++)
80105845:	83 c0 01             	add    $0x1,%eax
80105848:	3d 00 01 00 00       	cmp    $0x100,%eax
8010584d:	75 d1                	jne    80105820 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010584f:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105854:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105857:	c7 05 c2 4f 11 80 08 	movl   $0xef000008,0x80114fc2
8010585e:	00 00 ef 
  initlock(&tickslock, "time");
80105861:	68 21 78 10 80       	push   $0x80107821
80105866:	68 80 4d 11 80       	push   $0x80114d80
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010586b:	66 a3 c0 4f 11 80    	mov    %ax,0x80114fc0
80105871:	c1 e8 10             	shr    $0x10,%eax
80105874:	66 a3 c6 4f 11 80    	mov    %ax,0x80114fc6
  initlock(&tickslock, "time");
8010587a:	e8 f1 ea ff ff       	call   80104370 <initlock>
}
8010587f:	83 c4 10             	add    $0x10,%esp
80105882:	c9                   	leave  
80105883:	c3                   	ret    
80105884:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010588a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105890 <idtinit>:

void
idtinit(void)
{
80105890:	55                   	push   %ebp
  pd[0] = size-1;
80105891:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105896:	89 e5                	mov    %esp,%ebp
80105898:	83 ec 10             	sub    $0x10,%esp
8010589b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010589f:	b8 c0 4d 11 80       	mov    $0x80114dc0,%eax
801058a4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801058a8:	c1 e8 10             	shr    $0x10,%eax
801058ab:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801058af:	8d 45 fa             	lea    -0x6(%ebp),%eax
801058b2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801058b5:	c9                   	leave  
801058b6:	c3                   	ret    
801058b7:	89 f6                	mov    %esi,%esi
801058b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058c0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801058c0:	55                   	push   %ebp
801058c1:	89 e5                	mov    %esp,%ebp
801058c3:	57                   	push   %edi
801058c4:	56                   	push   %esi
801058c5:	53                   	push   %ebx
801058c6:	83 ec 1c             	sub    $0x1c,%esp
801058c9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
801058cc:	8b 47 30             	mov    0x30(%edi),%eax
801058cf:	83 f8 40             	cmp    $0x40,%eax
801058d2:	0f 84 f0 00 00 00    	je     801059c8 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801058d8:	83 e8 20             	sub    $0x20,%eax
801058db:	83 f8 1f             	cmp    $0x1f,%eax
801058de:	77 10                	ja     801058f0 <trap+0x30>
801058e0:	ff 24 85 c8 78 10 80 	jmp    *-0x7fef8738(,%eax,4)
801058e7:	89 f6                	mov    %esi,%esi
801058e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801058f0:	e8 5b e0 ff ff       	call   80103950 <myproc>
801058f5:	85 c0                	test   %eax,%eax
801058f7:	8b 5f 38             	mov    0x38(%edi),%ebx
801058fa:	0f 84 14 02 00 00    	je     80105b14 <trap+0x254>
80105900:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105904:	0f 84 0a 02 00 00    	je     80105b14 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010590a:	0f 20 d1             	mov    %cr2,%ecx
8010590d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105910:	e8 1b e0 ff ff       	call   80103930 <cpuid>
80105915:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105918:	8b 47 34             	mov    0x34(%edi),%eax
8010591b:	8b 77 30             	mov    0x30(%edi),%esi
8010591e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105921:	e8 2a e0 ff ff       	call   80103950 <myproc>
80105926:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105929:	e8 22 e0 ff ff       	call   80103950 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010592e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105931:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105934:	51                   	push   %ecx
80105935:	53                   	push   %ebx
80105936:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105937:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010593a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010593d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010593e:	83 c2 70             	add    $0x70,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105941:	52                   	push   %edx
80105942:	ff 70 10             	pushl  0x10(%eax)
80105945:	68 84 78 10 80       	push   $0x80107884
8010594a:	e8 d1 ad ff ff       	call   80100720 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010594f:	83 c4 20             	add    $0x20,%esp
80105952:	e8 f9 df ff ff       	call   80103950 <myproc>
80105957:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010595e:	e8 ed df ff ff       	call   80103950 <myproc>
80105963:	85 c0                	test   %eax,%eax
80105965:	74 1d                	je     80105984 <trap+0xc4>
80105967:	e8 e4 df ff ff       	call   80103950 <myproc>
8010596c:	8b 50 24             	mov    0x24(%eax),%edx
8010596f:	85 d2                	test   %edx,%edx
80105971:	74 11                	je     80105984 <trap+0xc4>
80105973:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105977:	83 e0 03             	and    $0x3,%eax
8010597a:	66 83 f8 03          	cmp    $0x3,%ax
8010597e:	0f 84 4c 01 00 00    	je     80105ad0 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105984:	e8 c7 df ff ff       	call   80103950 <myproc>
80105989:	85 c0                	test   %eax,%eax
8010598b:	74 0b                	je     80105998 <trap+0xd8>
8010598d:	e8 be df ff ff       	call   80103950 <myproc>
80105992:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105996:	74 68                	je     80105a00 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105998:	e8 b3 df ff ff       	call   80103950 <myproc>
8010599d:	85 c0                	test   %eax,%eax
8010599f:	74 19                	je     801059ba <trap+0xfa>
801059a1:	e8 aa df ff ff       	call   80103950 <myproc>
801059a6:	8b 40 24             	mov    0x24(%eax),%eax
801059a9:	85 c0                	test   %eax,%eax
801059ab:	74 0d                	je     801059ba <trap+0xfa>
801059ad:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801059b1:	83 e0 03             	and    $0x3,%eax
801059b4:	66 83 f8 03          	cmp    $0x3,%ax
801059b8:	74 37                	je     801059f1 <trap+0x131>
    exit();
}
801059ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059bd:	5b                   	pop    %ebx
801059be:	5e                   	pop    %esi
801059bf:	5f                   	pop    %edi
801059c0:	5d                   	pop    %ebp
801059c1:	c3                   	ret    
801059c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
801059c8:	e8 83 df ff ff       	call   80103950 <myproc>
801059cd:	8b 58 24             	mov    0x24(%eax),%ebx
801059d0:	85 db                	test   %ebx,%ebx
801059d2:	0f 85 e8 00 00 00    	jne    80105ac0 <trap+0x200>
    myproc()->tf = tf;
801059d8:	e8 73 df ff ff       	call   80103950 <myproc>
801059dd:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
801059e0:	e8 cb ef ff ff       	call   801049b0 <syscall>
    if(myproc()->killed)
801059e5:	e8 66 df ff ff       	call   80103950 <myproc>
801059ea:	8b 48 24             	mov    0x24(%eax),%ecx
801059ed:	85 c9                	test   %ecx,%ecx
801059ef:	74 c9                	je     801059ba <trap+0xfa>
}
801059f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059f4:	5b                   	pop    %ebx
801059f5:	5e                   	pop    %esi
801059f6:	5f                   	pop    %edi
801059f7:	5d                   	pop    %ebp
      exit();
801059f8:	e9 73 e3 ff ff       	jmp    80103d70 <exit>
801059fd:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105a00:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105a04:	75 92                	jne    80105998 <trap+0xd8>
    yield();
80105a06:	e8 95 e4 ff ff       	call   80103ea0 <yield>
80105a0b:	eb 8b                	jmp    80105998 <trap+0xd8>
80105a0d:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80105a10:	e8 1b df ff ff       	call   80103930 <cpuid>
80105a15:	85 c0                	test   %eax,%eax
80105a17:	0f 84 c3 00 00 00    	je     80105ae0 <trap+0x220>
    lapiceoi();
80105a1d:	e8 9e ce ff ff       	call   801028c0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a22:	e8 29 df ff ff       	call   80103950 <myproc>
80105a27:	85 c0                	test   %eax,%eax
80105a29:	0f 85 38 ff ff ff    	jne    80105967 <trap+0xa7>
80105a2f:	e9 50 ff ff ff       	jmp    80105984 <trap+0xc4>
80105a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105a38:	e8 43 cd ff ff       	call   80102780 <kbdintr>
    lapiceoi();
80105a3d:	e8 7e ce ff ff       	call   801028c0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a42:	e8 09 df ff ff       	call   80103950 <myproc>
80105a47:	85 c0                	test   %eax,%eax
80105a49:	0f 85 18 ff ff ff    	jne    80105967 <trap+0xa7>
80105a4f:	e9 30 ff ff ff       	jmp    80105984 <trap+0xc4>
80105a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105a58:	e8 53 02 00 00       	call   80105cb0 <uartintr>
    lapiceoi();
80105a5d:	e8 5e ce ff ff       	call   801028c0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a62:	e8 e9 de ff ff       	call   80103950 <myproc>
80105a67:	85 c0                	test   %eax,%eax
80105a69:	0f 85 f8 fe ff ff    	jne    80105967 <trap+0xa7>
80105a6f:	e9 10 ff ff ff       	jmp    80105984 <trap+0xc4>
80105a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105a78:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105a7c:	8b 77 38             	mov    0x38(%edi),%esi
80105a7f:	e8 ac de ff ff       	call   80103930 <cpuid>
80105a84:	56                   	push   %esi
80105a85:	53                   	push   %ebx
80105a86:	50                   	push   %eax
80105a87:	68 2c 78 10 80       	push   $0x8010782c
80105a8c:	e8 8f ac ff ff       	call   80100720 <cprintf>
    lapiceoi();
80105a91:	e8 2a ce ff ff       	call   801028c0 <lapiceoi>
    break;
80105a96:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a99:	e8 b2 de ff ff       	call   80103950 <myproc>
80105a9e:	85 c0                	test   %eax,%eax
80105aa0:	0f 85 c1 fe ff ff    	jne    80105967 <trap+0xa7>
80105aa6:	e9 d9 fe ff ff       	jmp    80105984 <trap+0xc4>
80105aab:	90                   	nop
80105aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105ab0:	e8 3b c7 ff ff       	call   801021f0 <ideintr>
80105ab5:	e9 63 ff ff ff       	jmp    80105a1d <trap+0x15d>
80105aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105ac0:	e8 ab e2 ff ff       	call   80103d70 <exit>
80105ac5:	e9 0e ff ff ff       	jmp    801059d8 <trap+0x118>
80105aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80105ad0:	e8 9b e2 ff ff       	call   80103d70 <exit>
80105ad5:	e9 aa fe ff ff       	jmp    80105984 <trap+0xc4>
80105ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105ae0:	83 ec 0c             	sub    $0xc,%esp
80105ae3:	68 80 4d 11 80       	push   $0x80114d80
80105ae8:	e8 c3 e9 ff ff       	call   801044b0 <acquire>
      wakeup(&ticks);
80105aed:	c7 04 24 c0 55 11 80 	movl   $0x801155c0,(%esp)
      ticks++;
80105af4:	83 05 c0 55 11 80 01 	addl   $0x1,0x801155c0
      wakeup(&ticks);
80105afb:	e8 a0 e5 ff ff       	call   801040a0 <wakeup>
      release(&tickslock);
80105b00:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80105b07:	e8 64 ea ff ff       	call   80104570 <release>
80105b0c:	83 c4 10             	add    $0x10,%esp
80105b0f:	e9 09 ff ff ff       	jmp    80105a1d <trap+0x15d>
80105b14:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105b17:	e8 14 de ff ff       	call   80103930 <cpuid>
80105b1c:	83 ec 0c             	sub    $0xc,%esp
80105b1f:	56                   	push   %esi
80105b20:	53                   	push   %ebx
80105b21:	50                   	push   %eax
80105b22:	ff 77 30             	pushl  0x30(%edi)
80105b25:	68 50 78 10 80       	push   $0x80107850
80105b2a:	e8 f1 ab ff ff       	call   80100720 <cprintf>
      panic("trap");
80105b2f:	83 c4 14             	add    $0x14,%esp
80105b32:	68 26 78 10 80       	push   $0x80107826
80105b37:	e8 14 a9 ff ff       	call   80100450 <panic>
80105b3c:	66 90                	xchg   %ax,%ax
80105b3e:	66 90                	xchg   %ax,%ax

80105b40 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105b40:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
{
80105b45:	55                   	push   %ebp
80105b46:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105b48:	85 c0                	test   %eax,%eax
80105b4a:	74 1c                	je     80105b68 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105b4c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105b51:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105b52:	a8 01                	test   $0x1,%al
80105b54:	74 12                	je     80105b68 <uartgetc+0x28>
80105b56:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105b5b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105b5c:	0f b6 c0             	movzbl %al,%eax
}
80105b5f:	5d                   	pop    %ebp
80105b60:	c3                   	ret    
80105b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105b68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b6d:	5d                   	pop    %ebp
80105b6e:	c3                   	ret    
80105b6f:	90                   	nop

80105b70 <uartputc.part.0>:
uartputc(int c)
80105b70:	55                   	push   %ebp
80105b71:	89 e5                	mov    %esp,%ebp
80105b73:	57                   	push   %edi
80105b74:	56                   	push   %esi
80105b75:	53                   	push   %ebx
80105b76:	89 c7                	mov    %eax,%edi
80105b78:	bb 80 00 00 00       	mov    $0x80,%ebx
80105b7d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105b82:	83 ec 0c             	sub    $0xc,%esp
80105b85:	eb 1b                	jmp    80105ba2 <uartputc.part.0+0x32>
80105b87:	89 f6                	mov    %esi,%esi
80105b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105b90:	83 ec 0c             	sub    $0xc,%esp
80105b93:	6a 0a                	push   $0xa
80105b95:	e8 46 cd ff ff       	call   801028e0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105b9a:	83 c4 10             	add    $0x10,%esp
80105b9d:	83 eb 01             	sub    $0x1,%ebx
80105ba0:	74 07                	je     80105ba9 <uartputc.part.0+0x39>
80105ba2:	89 f2                	mov    %esi,%edx
80105ba4:	ec                   	in     (%dx),%al
80105ba5:	a8 20                	test   $0x20,%al
80105ba7:	74 e7                	je     80105b90 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105ba9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105bae:	89 f8                	mov    %edi,%eax
80105bb0:	ee                   	out    %al,(%dx)
}
80105bb1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bb4:	5b                   	pop    %ebx
80105bb5:	5e                   	pop    %esi
80105bb6:	5f                   	pop    %edi
80105bb7:	5d                   	pop    %ebp
80105bb8:	c3                   	ret    
80105bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105bc0 <uartinit>:
{
80105bc0:	55                   	push   %ebp
80105bc1:	31 c9                	xor    %ecx,%ecx
80105bc3:	89 c8                	mov    %ecx,%eax
80105bc5:	89 e5                	mov    %esp,%ebp
80105bc7:	57                   	push   %edi
80105bc8:	56                   	push   %esi
80105bc9:	53                   	push   %ebx
80105bca:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105bcf:	89 da                	mov    %ebx,%edx
80105bd1:	83 ec 0c             	sub    $0xc,%esp
80105bd4:	ee                   	out    %al,(%dx)
80105bd5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105bda:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105bdf:	89 fa                	mov    %edi,%edx
80105be1:	ee                   	out    %al,(%dx)
80105be2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105be7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105bec:	ee                   	out    %al,(%dx)
80105bed:	be f9 03 00 00       	mov    $0x3f9,%esi
80105bf2:	89 c8                	mov    %ecx,%eax
80105bf4:	89 f2                	mov    %esi,%edx
80105bf6:	ee                   	out    %al,(%dx)
80105bf7:	b8 03 00 00 00       	mov    $0x3,%eax
80105bfc:	89 fa                	mov    %edi,%edx
80105bfe:	ee                   	out    %al,(%dx)
80105bff:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105c04:	89 c8                	mov    %ecx,%eax
80105c06:	ee                   	out    %al,(%dx)
80105c07:	b8 01 00 00 00       	mov    $0x1,%eax
80105c0c:	89 f2                	mov    %esi,%edx
80105c0e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c0f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c14:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105c15:	3c ff                	cmp    $0xff,%al
80105c17:	74 5a                	je     80105c73 <uartinit+0xb3>
  uart = 1;
80105c19:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105c20:	00 00 00 
80105c23:	89 da                	mov    %ebx,%edx
80105c25:	ec                   	in     (%dx),%al
80105c26:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c2b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105c2c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105c2f:	bb 48 79 10 80       	mov    $0x80107948,%ebx
  ioapicenable(IRQ_COM1, 0);
80105c34:	6a 00                	push   $0x0
80105c36:	6a 04                	push   $0x4
80105c38:	e8 03 c8 ff ff       	call   80102440 <ioapicenable>
80105c3d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105c40:	b8 78 00 00 00       	mov    $0x78,%eax
80105c45:	eb 13                	jmp    80105c5a <uartinit+0x9a>
80105c47:	89 f6                	mov    %esi,%esi
80105c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105c50:	83 c3 01             	add    $0x1,%ebx
80105c53:	0f be 03             	movsbl (%ebx),%eax
80105c56:	84 c0                	test   %al,%al
80105c58:	74 19                	je     80105c73 <uartinit+0xb3>
  if(!uart)
80105c5a:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105c60:	85 d2                	test   %edx,%edx
80105c62:	74 ec                	je     80105c50 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105c64:	83 c3 01             	add    $0x1,%ebx
80105c67:	e8 04 ff ff ff       	call   80105b70 <uartputc.part.0>
80105c6c:	0f be 03             	movsbl (%ebx),%eax
80105c6f:	84 c0                	test   %al,%al
80105c71:	75 e7                	jne    80105c5a <uartinit+0x9a>
}
80105c73:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c76:	5b                   	pop    %ebx
80105c77:	5e                   	pop    %esi
80105c78:	5f                   	pop    %edi
80105c79:	5d                   	pop    %ebp
80105c7a:	c3                   	ret    
80105c7b:	90                   	nop
80105c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c80 <uartputc>:
  if(!uart)
80105c80:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80105c86:	55                   	push   %ebp
80105c87:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105c89:	85 d2                	test   %edx,%edx
{
80105c8b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105c8e:	74 10                	je     80105ca0 <uartputc+0x20>
}
80105c90:	5d                   	pop    %ebp
80105c91:	e9 da fe ff ff       	jmp    80105b70 <uartputc.part.0>
80105c96:	8d 76 00             	lea    0x0(%esi),%esi
80105c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105ca0:	5d                   	pop    %ebp
80105ca1:	c3                   	ret    
80105ca2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105cb0 <uartintr>:

void
uartintr(void)
{
80105cb0:	55                   	push   %ebp
80105cb1:	89 e5                	mov    %esp,%ebp
80105cb3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105cb6:	68 40 5b 10 80       	push   $0x80105b40
80105cbb:	e8 10 ac ff ff       	call   801008d0 <consoleintr>
}
80105cc0:	83 c4 10             	add    $0x10,%esp
80105cc3:	c9                   	leave  
80105cc4:	c3                   	ret    

80105cc5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105cc5:	6a 00                	push   $0x0
  pushl $0
80105cc7:	6a 00                	push   $0x0
  jmp alltraps
80105cc9:	e9 15 fb ff ff       	jmp    801057e3 <alltraps>

80105cce <vector1>:
.globl vector1
vector1:
  pushl $0
80105cce:	6a 00                	push   $0x0
  pushl $1
80105cd0:	6a 01                	push   $0x1
  jmp alltraps
80105cd2:	e9 0c fb ff ff       	jmp    801057e3 <alltraps>

80105cd7 <vector2>:
.globl vector2
vector2:
  pushl $0
80105cd7:	6a 00                	push   $0x0
  pushl $2
80105cd9:	6a 02                	push   $0x2
  jmp alltraps
80105cdb:	e9 03 fb ff ff       	jmp    801057e3 <alltraps>

80105ce0 <vector3>:
.globl vector3
vector3:
  pushl $0
80105ce0:	6a 00                	push   $0x0
  pushl $3
80105ce2:	6a 03                	push   $0x3
  jmp alltraps
80105ce4:	e9 fa fa ff ff       	jmp    801057e3 <alltraps>

80105ce9 <vector4>:
.globl vector4
vector4:
  pushl $0
80105ce9:	6a 00                	push   $0x0
  pushl $4
80105ceb:	6a 04                	push   $0x4
  jmp alltraps
80105ced:	e9 f1 fa ff ff       	jmp    801057e3 <alltraps>

80105cf2 <vector5>:
.globl vector5
vector5:
  pushl $0
80105cf2:	6a 00                	push   $0x0
  pushl $5
80105cf4:	6a 05                	push   $0x5
  jmp alltraps
80105cf6:	e9 e8 fa ff ff       	jmp    801057e3 <alltraps>

80105cfb <vector6>:
.globl vector6
vector6:
  pushl $0
80105cfb:	6a 00                	push   $0x0
  pushl $6
80105cfd:	6a 06                	push   $0x6
  jmp alltraps
80105cff:	e9 df fa ff ff       	jmp    801057e3 <alltraps>

80105d04 <vector7>:
.globl vector7
vector7:
  pushl $0
80105d04:	6a 00                	push   $0x0
  pushl $7
80105d06:	6a 07                	push   $0x7
  jmp alltraps
80105d08:	e9 d6 fa ff ff       	jmp    801057e3 <alltraps>

80105d0d <vector8>:
.globl vector8
vector8:
  pushl $8
80105d0d:	6a 08                	push   $0x8
  jmp alltraps
80105d0f:	e9 cf fa ff ff       	jmp    801057e3 <alltraps>

80105d14 <vector9>:
.globl vector9
vector9:
  pushl $0
80105d14:	6a 00                	push   $0x0
  pushl $9
80105d16:	6a 09                	push   $0x9
  jmp alltraps
80105d18:	e9 c6 fa ff ff       	jmp    801057e3 <alltraps>

80105d1d <vector10>:
.globl vector10
vector10:
  pushl $10
80105d1d:	6a 0a                	push   $0xa
  jmp alltraps
80105d1f:	e9 bf fa ff ff       	jmp    801057e3 <alltraps>

80105d24 <vector11>:
.globl vector11
vector11:
  pushl $11
80105d24:	6a 0b                	push   $0xb
  jmp alltraps
80105d26:	e9 b8 fa ff ff       	jmp    801057e3 <alltraps>

80105d2b <vector12>:
.globl vector12
vector12:
  pushl $12
80105d2b:	6a 0c                	push   $0xc
  jmp alltraps
80105d2d:	e9 b1 fa ff ff       	jmp    801057e3 <alltraps>

80105d32 <vector13>:
.globl vector13
vector13:
  pushl $13
80105d32:	6a 0d                	push   $0xd
  jmp alltraps
80105d34:	e9 aa fa ff ff       	jmp    801057e3 <alltraps>

80105d39 <vector14>:
.globl vector14
vector14:
  pushl $14
80105d39:	6a 0e                	push   $0xe
  jmp alltraps
80105d3b:	e9 a3 fa ff ff       	jmp    801057e3 <alltraps>

80105d40 <vector15>:
.globl vector15
vector15:
  pushl $0
80105d40:	6a 00                	push   $0x0
  pushl $15
80105d42:	6a 0f                	push   $0xf
  jmp alltraps
80105d44:	e9 9a fa ff ff       	jmp    801057e3 <alltraps>

80105d49 <vector16>:
.globl vector16
vector16:
  pushl $0
80105d49:	6a 00                	push   $0x0
  pushl $16
80105d4b:	6a 10                	push   $0x10
  jmp alltraps
80105d4d:	e9 91 fa ff ff       	jmp    801057e3 <alltraps>

80105d52 <vector17>:
.globl vector17
vector17:
  pushl $17
80105d52:	6a 11                	push   $0x11
  jmp alltraps
80105d54:	e9 8a fa ff ff       	jmp    801057e3 <alltraps>

80105d59 <vector18>:
.globl vector18
vector18:
  pushl $0
80105d59:	6a 00                	push   $0x0
  pushl $18
80105d5b:	6a 12                	push   $0x12
  jmp alltraps
80105d5d:	e9 81 fa ff ff       	jmp    801057e3 <alltraps>

80105d62 <vector19>:
.globl vector19
vector19:
  pushl $0
80105d62:	6a 00                	push   $0x0
  pushl $19
80105d64:	6a 13                	push   $0x13
  jmp alltraps
80105d66:	e9 78 fa ff ff       	jmp    801057e3 <alltraps>

80105d6b <vector20>:
.globl vector20
vector20:
  pushl $0
80105d6b:	6a 00                	push   $0x0
  pushl $20
80105d6d:	6a 14                	push   $0x14
  jmp alltraps
80105d6f:	e9 6f fa ff ff       	jmp    801057e3 <alltraps>

80105d74 <vector21>:
.globl vector21
vector21:
  pushl $0
80105d74:	6a 00                	push   $0x0
  pushl $21
80105d76:	6a 15                	push   $0x15
  jmp alltraps
80105d78:	e9 66 fa ff ff       	jmp    801057e3 <alltraps>

80105d7d <vector22>:
.globl vector22
vector22:
  pushl $0
80105d7d:	6a 00                	push   $0x0
  pushl $22
80105d7f:	6a 16                	push   $0x16
  jmp alltraps
80105d81:	e9 5d fa ff ff       	jmp    801057e3 <alltraps>

80105d86 <vector23>:
.globl vector23
vector23:
  pushl $0
80105d86:	6a 00                	push   $0x0
  pushl $23
80105d88:	6a 17                	push   $0x17
  jmp alltraps
80105d8a:	e9 54 fa ff ff       	jmp    801057e3 <alltraps>

80105d8f <vector24>:
.globl vector24
vector24:
  pushl $0
80105d8f:	6a 00                	push   $0x0
  pushl $24
80105d91:	6a 18                	push   $0x18
  jmp alltraps
80105d93:	e9 4b fa ff ff       	jmp    801057e3 <alltraps>

80105d98 <vector25>:
.globl vector25
vector25:
  pushl $0
80105d98:	6a 00                	push   $0x0
  pushl $25
80105d9a:	6a 19                	push   $0x19
  jmp alltraps
80105d9c:	e9 42 fa ff ff       	jmp    801057e3 <alltraps>

80105da1 <vector26>:
.globl vector26
vector26:
  pushl $0
80105da1:	6a 00                	push   $0x0
  pushl $26
80105da3:	6a 1a                	push   $0x1a
  jmp alltraps
80105da5:	e9 39 fa ff ff       	jmp    801057e3 <alltraps>

80105daa <vector27>:
.globl vector27
vector27:
  pushl $0
80105daa:	6a 00                	push   $0x0
  pushl $27
80105dac:	6a 1b                	push   $0x1b
  jmp alltraps
80105dae:	e9 30 fa ff ff       	jmp    801057e3 <alltraps>

80105db3 <vector28>:
.globl vector28
vector28:
  pushl $0
80105db3:	6a 00                	push   $0x0
  pushl $28
80105db5:	6a 1c                	push   $0x1c
  jmp alltraps
80105db7:	e9 27 fa ff ff       	jmp    801057e3 <alltraps>

80105dbc <vector29>:
.globl vector29
vector29:
  pushl $0
80105dbc:	6a 00                	push   $0x0
  pushl $29
80105dbe:	6a 1d                	push   $0x1d
  jmp alltraps
80105dc0:	e9 1e fa ff ff       	jmp    801057e3 <alltraps>

80105dc5 <vector30>:
.globl vector30
vector30:
  pushl $0
80105dc5:	6a 00                	push   $0x0
  pushl $30
80105dc7:	6a 1e                	push   $0x1e
  jmp alltraps
80105dc9:	e9 15 fa ff ff       	jmp    801057e3 <alltraps>

80105dce <vector31>:
.globl vector31
vector31:
  pushl $0
80105dce:	6a 00                	push   $0x0
  pushl $31
80105dd0:	6a 1f                	push   $0x1f
  jmp alltraps
80105dd2:	e9 0c fa ff ff       	jmp    801057e3 <alltraps>

80105dd7 <vector32>:
.globl vector32
vector32:
  pushl $0
80105dd7:	6a 00                	push   $0x0
  pushl $32
80105dd9:	6a 20                	push   $0x20
  jmp alltraps
80105ddb:	e9 03 fa ff ff       	jmp    801057e3 <alltraps>

80105de0 <vector33>:
.globl vector33
vector33:
  pushl $0
80105de0:	6a 00                	push   $0x0
  pushl $33
80105de2:	6a 21                	push   $0x21
  jmp alltraps
80105de4:	e9 fa f9 ff ff       	jmp    801057e3 <alltraps>

80105de9 <vector34>:
.globl vector34
vector34:
  pushl $0
80105de9:	6a 00                	push   $0x0
  pushl $34
80105deb:	6a 22                	push   $0x22
  jmp alltraps
80105ded:	e9 f1 f9 ff ff       	jmp    801057e3 <alltraps>

80105df2 <vector35>:
.globl vector35
vector35:
  pushl $0
80105df2:	6a 00                	push   $0x0
  pushl $35
80105df4:	6a 23                	push   $0x23
  jmp alltraps
80105df6:	e9 e8 f9 ff ff       	jmp    801057e3 <alltraps>

80105dfb <vector36>:
.globl vector36
vector36:
  pushl $0
80105dfb:	6a 00                	push   $0x0
  pushl $36
80105dfd:	6a 24                	push   $0x24
  jmp alltraps
80105dff:	e9 df f9 ff ff       	jmp    801057e3 <alltraps>

80105e04 <vector37>:
.globl vector37
vector37:
  pushl $0
80105e04:	6a 00                	push   $0x0
  pushl $37
80105e06:	6a 25                	push   $0x25
  jmp alltraps
80105e08:	e9 d6 f9 ff ff       	jmp    801057e3 <alltraps>

80105e0d <vector38>:
.globl vector38
vector38:
  pushl $0
80105e0d:	6a 00                	push   $0x0
  pushl $38
80105e0f:	6a 26                	push   $0x26
  jmp alltraps
80105e11:	e9 cd f9 ff ff       	jmp    801057e3 <alltraps>

80105e16 <vector39>:
.globl vector39
vector39:
  pushl $0
80105e16:	6a 00                	push   $0x0
  pushl $39
80105e18:	6a 27                	push   $0x27
  jmp alltraps
80105e1a:	e9 c4 f9 ff ff       	jmp    801057e3 <alltraps>

80105e1f <vector40>:
.globl vector40
vector40:
  pushl $0
80105e1f:	6a 00                	push   $0x0
  pushl $40
80105e21:	6a 28                	push   $0x28
  jmp alltraps
80105e23:	e9 bb f9 ff ff       	jmp    801057e3 <alltraps>

80105e28 <vector41>:
.globl vector41
vector41:
  pushl $0
80105e28:	6a 00                	push   $0x0
  pushl $41
80105e2a:	6a 29                	push   $0x29
  jmp alltraps
80105e2c:	e9 b2 f9 ff ff       	jmp    801057e3 <alltraps>

80105e31 <vector42>:
.globl vector42
vector42:
  pushl $0
80105e31:	6a 00                	push   $0x0
  pushl $42
80105e33:	6a 2a                	push   $0x2a
  jmp alltraps
80105e35:	e9 a9 f9 ff ff       	jmp    801057e3 <alltraps>

80105e3a <vector43>:
.globl vector43
vector43:
  pushl $0
80105e3a:	6a 00                	push   $0x0
  pushl $43
80105e3c:	6a 2b                	push   $0x2b
  jmp alltraps
80105e3e:	e9 a0 f9 ff ff       	jmp    801057e3 <alltraps>

80105e43 <vector44>:
.globl vector44
vector44:
  pushl $0
80105e43:	6a 00                	push   $0x0
  pushl $44
80105e45:	6a 2c                	push   $0x2c
  jmp alltraps
80105e47:	e9 97 f9 ff ff       	jmp    801057e3 <alltraps>

80105e4c <vector45>:
.globl vector45
vector45:
  pushl $0
80105e4c:	6a 00                	push   $0x0
  pushl $45
80105e4e:	6a 2d                	push   $0x2d
  jmp alltraps
80105e50:	e9 8e f9 ff ff       	jmp    801057e3 <alltraps>

80105e55 <vector46>:
.globl vector46
vector46:
  pushl $0
80105e55:	6a 00                	push   $0x0
  pushl $46
80105e57:	6a 2e                	push   $0x2e
  jmp alltraps
80105e59:	e9 85 f9 ff ff       	jmp    801057e3 <alltraps>

80105e5e <vector47>:
.globl vector47
vector47:
  pushl $0
80105e5e:	6a 00                	push   $0x0
  pushl $47
80105e60:	6a 2f                	push   $0x2f
  jmp alltraps
80105e62:	e9 7c f9 ff ff       	jmp    801057e3 <alltraps>

80105e67 <vector48>:
.globl vector48
vector48:
  pushl $0
80105e67:	6a 00                	push   $0x0
  pushl $48
80105e69:	6a 30                	push   $0x30
  jmp alltraps
80105e6b:	e9 73 f9 ff ff       	jmp    801057e3 <alltraps>

80105e70 <vector49>:
.globl vector49
vector49:
  pushl $0
80105e70:	6a 00                	push   $0x0
  pushl $49
80105e72:	6a 31                	push   $0x31
  jmp alltraps
80105e74:	e9 6a f9 ff ff       	jmp    801057e3 <alltraps>

80105e79 <vector50>:
.globl vector50
vector50:
  pushl $0
80105e79:	6a 00                	push   $0x0
  pushl $50
80105e7b:	6a 32                	push   $0x32
  jmp alltraps
80105e7d:	e9 61 f9 ff ff       	jmp    801057e3 <alltraps>

80105e82 <vector51>:
.globl vector51
vector51:
  pushl $0
80105e82:	6a 00                	push   $0x0
  pushl $51
80105e84:	6a 33                	push   $0x33
  jmp alltraps
80105e86:	e9 58 f9 ff ff       	jmp    801057e3 <alltraps>

80105e8b <vector52>:
.globl vector52
vector52:
  pushl $0
80105e8b:	6a 00                	push   $0x0
  pushl $52
80105e8d:	6a 34                	push   $0x34
  jmp alltraps
80105e8f:	e9 4f f9 ff ff       	jmp    801057e3 <alltraps>

80105e94 <vector53>:
.globl vector53
vector53:
  pushl $0
80105e94:	6a 00                	push   $0x0
  pushl $53
80105e96:	6a 35                	push   $0x35
  jmp alltraps
80105e98:	e9 46 f9 ff ff       	jmp    801057e3 <alltraps>

80105e9d <vector54>:
.globl vector54
vector54:
  pushl $0
80105e9d:	6a 00                	push   $0x0
  pushl $54
80105e9f:	6a 36                	push   $0x36
  jmp alltraps
80105ea1:	e9 3d f9 ff ff       	jmp    801057e3 <alltraps>

80105ea6 <vector55>:
.globl vector55
vector55:
  pushl $0
80105ea6:	6a 00                	push   $0x0
  pushl $55
80105ea8:	6a 37                	push   $0x37
  jmp alltraps
80105eaa:	e9 34 f9 ff ff       	jmp    801057e3 <alltraps>

80105eaf <vector56>:
.globl vector56
vector56:
  pushl $0
80105eaf:	6a 00                	push   $0x0
  pushl $56
80105eb1:	6a 38                	push   $0x38
  jmp alltraps
80105eb3:	e9 2b f9 ff ff       	jmp    801057e3 <alltraps>

80105eb8 <vector57>:
.globl vector57
vector57:
  pushl $0
80105eb8:	6a 00                	push   $0x0
  pushl $57
80105eba:	6a 39                	push   $0x39
  jmp alltraps
80105ebc:	e9 22 f9 ff ff       	jmp    801057e3 <alltraps>

80105ec1 <vector58>:
.globl vector58
vector58:
  pushl $0
80105ec1:	6a 00                	push   $0x0
  pushl $58
80105ec3:	6a 3a                	push   $0x3a
  jmp alltraps
80105ec5:	e9 19 f9 ff ff       	jmp    801057e3 <alltraps>

80105eca <vector59>:
.globl vector59
vector59:
  pushl $0
80105eca:	6a 00                	push   $0x0
  pushl $59
80105ecc:	6a 3b                	push   $0x3b
  jmp alltraps
80105ece:	e9 10 f9 ff ff       	jmp    801057e3 <alltraps>

80105ed3 <vector60>:
.globl vector60
vector60:
  pushl $0
80105ed3:	6a 00                	push   $0x0
  pushl $60
80105ed5:	6a 3c                	push   $0x3c
  jmp alltraps
80105ed7:	e9 07 f9 ff ff       	jmp    801057e3 <alltraps>

80105edc <vector61>:
.globl vector61
vector61:
  pushl $0
80105edc:	6a 00                	push   $0x0
  pushl $61
80105ede:	6a 3d                	push   $0x3d
  jmp alltraps
80105ee0:	e9 fe f8 ff ff       	jmp    801057e3 <alltraps>

80105ee5 <vector62>:
.globl vector62
vector62:
  pushl $0
80105ee5:	6a 00                	push   $0x0
  pushl $62
80105ee7:	6a 3e                	push   $0x3e
  jmp alltraps
80105ee9:	e9 f5 f8 ff ff       	jmp    801057e3 <alltraps>

80105eee <vector63>:
.globl vector63
vector63:
  pushl $0
80105eee:	6a 00                	push   $0x0
  pushl $63
80105ef0:	6a 3f                	push   $0x3f
  jmp alltraps
80105ef2:	e9 ec f8 ff ff       	jmp    801057e3 <alltraps>

80105ef7 <vector64>:
.globl vector64
vector64:
  pushl $0
80105ef7:	6a 00                	push   $0x0
  pushl $64
80105ef9:	6a 40                	push   $0x40
  jmp alltraps
80105efb:	e9 e3 f8 ff ff       	jmp    801057e3 <alltraps>

80105f00 <vector65>:
.globl vector65
vector65:
  pushl $0
80105f00:	6a 00                	push   $0x0
  pushl $65
80105f02:	6a 41                	push   $0x41
  jmp alltraps
80105f04:	e9 da f8 ff ff       	jmp    801057e3 <alltraps>

80105f09 <vector66>:
.globl vector66
vector66:
  pushl $0
80105f09:	6a 00                	push   $0x0
  pushl $66
80105f0b:	6a 42                	push   $0x42
  jmp alltraps
80105f0d:	e9 d1 f8 ff ff       	jmp    801057e3 <alltraps>

80105f12 <vector67>:
.globl vector67
vector67:
  pushl $0
80105f12:	6a 00                	push   $0x0
  pushl $67
80105f14:	6a 43                	push   $0x43
  jmp alltraps
80105f16:	e9 c8 f8 ff ff       	jmp    801057e3 <alltraps>

80105f1b <vector68>:
.globl vector68
vector68:
  pushl $0
80105f1b:	6a 00                	push   $0x0
  pushl $68
80105f1d:	6a 44                	push   $0x44
  jmp alltraps
80105f1f:	e9 bf f8 ff ff       	jmp    801057e3 <alltraps>

80105f24 <vector69>:
.globl vector69
vector69:
  pushl $0
80105f24:	6a 00                	push   $0x0
  pushl $69
80105f26:	6a 45                	push   $0x45
  jmp alltraps
80105f28:	e9 b6 f8 ff ff       	jmp    801057e3 <alltraps>

80105f2d <vector70>:
.globl vector70
vector70:
  pushl $0
80105f2d:	6a 00                	push   $0x0
  pushl $70
80105f2f:	6a 46                	push   $0x46
  jmp alltraps
80105f31:	e9 ad f8 ff ff       	jmp    801057e3 <alltraps>

80105f36 <vector71>:
.globl vector71
vector71:
  pushl $0
80105f36:	6a 00                	push   $0x0
  pushl $71
80105f38:	6a 47                	push   $0x47
  jmp alltraps
80105f3a:	e9 a4 f8 ff ff       	jmp    801057e3 <alltraps>

80105f3f <vector72>:
.globl vector72
vector72:
  pushl $0
80105f3f:	6a 00                	push   $0x0
  pushl $72
80105f41:	6a 48                	push   $0x48
  jmp alltraps
80105f43:	e9 9b f8 ff ff       	jmp    801057e3 <alltraps>

80105f48 <vector73>:
.globl vector73
vector73:
  pushl $0
80105f48:	6a 00                	push   $0x0
  pushl $73
80105f4a:	6a 49                	push   $0x49
  jmp alltraps
80105f4c:	e9 92 f8 ff ff       	jmp    801057e3 <alltraps>

80105f51 <vector74>:
.globl vector74
vector74:
  pushl $0
80105f51:	6a 00                	push   $0x0
  pushl $74
80105f53:	6a 4a                	push   $0x4a
  jmp alltraps
80105f55:	e9 89 f8 ff ff       	jmp    801057e3 <alltraps>

80105f5a <vector75>:
.globl vector75
vector75:
  pushl $0
80105f5a:	6a 00                	push   $0x0
  pushl $75
80105f5c:	6a 4b                	push   $0x4b
  jmp alltraps
80105f5e:	e9 80 f8 ff ff       	jmp    801057e3 <alltraps>

80105f63 <vector76>:
.globl vector76
vector76:
  pushl $0
80105f63:	6a 00                	push   $0x0
  pushl $76
80105f65:	6a 4c                	push   $0x4c
  jmp alltraps
80105f67:	e9 77 f8 ff ff       	jmp    801057e3 <alltraps>

80105f6c <vector77>:
.globl vector77
vector77:
  pushl $0
80105f6c:	6a 00                	push   $0x0
  pushl $77
80105f6e:	6a 4d                	push   $0x4d
  jmp alltraps
80105f70:	e9 6e f8 ff ff       	jmp    801057e3 <alltraps>

80105f75 <vector78>:
.globl vector78
vector78:
  pushl $0
80105f75:	6a 00                	push   $0x0
  pushl $78
80105f77:	6a 4e                	push   $0x4e
  jmp alltraps
80105f79:	e9 65 f8 ff ff       	jmp    801057e3 <alltraps>

80105f7e <vector79>:
.globl vector79
vector79:
  pushl $0
80105f7e:	6a 00                	push   $0x0
  pushl $79
80105f80:	6a 4f                	push   $0x4f
  jmp alltraps
80105f82:	e9 5c f8 ff ff       	jmp    801057e3 <alltraps>

80105f87 <vector80>:
.globl vector80
vector80:
  pushl $0
80105f87:	6a 00                	push   $0x0
  pushl $80
80105f89:	6a 50                	push   $0x50
  jmp alltraps
80105f8b:	e9 53 f8 ff ff       	jmp    801057e3 <alltraps>

80105f90 <vector81>:
.globl vector81
vector81:
  pushl $0
80105f90:	6a 00                	push   $0x0
  pushl $81
80105f92:	6a 51                	push   $0x51
  jmp alltraps
80105f94:	e9 4a f8 ff ff       	jmp    801057e3 <alltraps>

80105f99 <vector82>:
.globl vector82
vector82:
  pushl $0
80105f99:	6a 00                	push   $0x0
  pushl $82
80105f9b:	6a 52                	push   $0x52
  jmp alltraps
80105f9d:	e9 41 f8 ff ff       	jmp    801057e3 <alltraps>

80105fa2 <vector83>:
.globl vector83
vector83:
  pushl $0
80105fa2:	6a 00                	push   $0x0
  pushl $83
80105fa4:	6a 53                	push   $0x53
  jmp alltraps
80105fa6:	e9 38 f8 ff ff       	jmp    801057e3 <alltraps>

80105fab <vector84>:
.globl vector84
vector84:
  pushl $0
80105fab:	6a 00                	push   $0x0
  pushl $84
80105fad:	6a 54                	push   $0x54
  jmp alltraps
80105faf:	e9 2f f8 ff ff       	jmp    801057e3 <alltraps>

80105fb4 <vector85>:
.globl vector85
vector85:
  pushl $0
80105fb4:	6a 00                	push   $0x0
  pushl $85
80105fb6:	6a 55                	push   $0x55
  jmp alltraps
80105fb8:	e9 26 f8 ff ff       	jmp    801057e3 <alltraps>

80105fbd <vector86>:
.globl vector86
vector86:
  pushl $0
80105fbd:	6a 00                	push   $0x0
  pushl $86
80105fbf:	6a 56                	push   $0x56
  jmp alltraps
80105fc1:	e9 1d f8 ff ff       	jmp    801057e3 <alltraps>

80105fc6 <vector87>:
.globl vector87
vector87:
  pushl $0
80105fc6:	6a 00                	push   $0x0
  pushl $87
80105fc8:	6a 57                	push   $0x57
  jmp alltraps
80105fca:	e9 14 f8 ff ff       	jmp    801057e3 <alltraps>

80105fcf <vector88>:
.globl vector88
vector88:
  pushl $0
80105fcf:	6a 00                	push   $0x0
  pushl $88
80105fd1:	6a 58                	push   $0x58
  jmp alltraps
80105fd3:	e9 0b f8 ff ff       	jmp    801057e3 <alltraps>

80105fd8 <vector89>:
.globl vector89
vector89:
  pushl $0
80105fd8:	6a 00                	push   $0x0
  pushl $89
80105fda:	6a 59                	push   $0x59
  jmp alltraps
80105fdc:	e9 02 f8 ff ff       	jmp    801057e3 <alltraps>

80105fe1 <vector90>:
.globl vector90
vector90:
  pushl $0
80105fe1:	6a 00                	push   $0x0
  pushl $90
80105fe3:	6a 5a                	push   $0x5a
  jmp alltraps
80105fe5:	e9 f9 f7 ff ff       	jmp    801057e3 <alltraps>

80105fea <vector91>:
.globl vector91
vector91:
  pushl $0
80105fea:	6a 00                	push   $0x0
  pushl $91
80105fec:	6a 5b                	push   $0x5b
  jmp alltraps
80105fee:	e9 f0 f7 ff ff       	jmp    801057e3 <alltraps>

80105ff3 <vector92>:
.globl vector92
vector92:
  pushl $0
80105ff3:	6a 00                	push   $0x0
  pushl $92
80105ff5:	6a 5c                	push   $0x5c
  jmp alltraps
80105ff7:	e9 e7 f7 ff ff       	jmp    801057e3 <alltraps>

80105ffc <vector93>:
.globl vector93
vector93:
  pushl $0
80105ffc:	6a 00                	push   $0x0
  pushl $93
80105ffe:	6a 5d                	push   $0x5d
  jmp alltraps
80106000:	e9 de f7 ff ff       	jmp    801057e3 <alltraps>

80106005 <vector94>:
.globl vector94
vector94:
  pushl $0
80106005:	6a 00                	push   $0x0
  pushl $94
80106007:	6a 5e                	push   $0x5e
  jmp alltraps
80106009:	e9 d5 f7 ff ff       	jmp    801057e3 <alltraps>

8010600e <vector95>:
.globl vector95
vector95:
  pushl $0
8010600e:	6a 00                	push   $0x0
  pushl $95
80106010:	6a 5f                	push   $0x5f
  jmp alltraps
80106012:	e9 cc f7 ff ff       	jmp    801057e3 <alltraps>

80106017 <vector96>:
.globl vector96
vector96:
  pushl $0
80106017:	6a 00                	push   $0x0
  pushl $96
80106019:	6a 60                	push   $0x60
  jmp alltraps
8010601b:	e9 c3 f7 ff ff       	jmp    801057e3 <alltraps>

80106020 <vector97>:
.globl vector97
vector97:
  pushl $0
80106020:	6a 00                	push   $0x0
  pushl $97
80106022:	6a 61                	push   $0x61
  jmp alltraps
80106024:	e9 ba f7 ff ff       	jmp    801057e3 <alltraps>

80106029 <vector98>:
.globl vector98
vector98:
  pushl $0
80106029:	6a 00                	push   $0x0
  pushl $98
8010602b:	6a 62                	push   $0x62
  jmp alltraps
8010602d:	e9 b1 f7 ff ff       	jmp    801057e3 <alltraps>

80106032 <vector99>:
.globl vector99
vector99:
  pushl $0
80106032:	6a 00                	push   $0x0
  pushl $99
80106034:	6a 63                	push   $0x63
  jmp alltraps
80106036:	e9 a8 f7 ff ff       	jmp    801057e3 <alltraps>

8010603b <vector100>:
.globl vector100
vector100:
  pushl $0
8010603b:	6a 00                	push   $0x0
  pushl $100
8010603d:	6a 64                	push   $0x64
  jmp alltraps
8010603f:	e9 9f f7 ff ff       	jmp    801057e3 <alltraps>

80106044 <vector101>:
.globl vector101
vector101:
  pushl $0
80106044:	6a 00                	push   $0x0
  pushl $101
80106046:	6a 65                	push   $0x65
  jmp alltraps
80106048:	e9 96 f7 ff ff       	jmp    801057e3 <alltraps>

8010604d <vector102>:
.globl vector102
vector102:
  pushl $0
8010604d:	6a 00                	push   $0x0
  pushl $102
8010604f:	6a 66                	push   $0x66
  jmp alltraps
80106051:	e9 8d f7 ff ff       	jmp    801057e3 <alltraps>

80106056 <vector103>:
.globl vector103
vector103:
  pushl $0
80106056:	6a 00                	push   $0x0
  pushl $103
80106058:	6a 67                	push   $0x67
  jmp alltraps
8010605a:	e9 84 f7 ff ff       	jmp    801057e3 <alltraps>

8010605f <vector104>:
.globl vector104
vector104:
  pushl $0
8010605f:	6a 00                	push   $0x0
  pushl $104
80106061:	6a 68                	push   $0x68
  jmp alltraps
80106063:	e9 7b f7 ff ff       	jmp    801057e3 <alltraps>

80106068 <vector105>:
.globl vector105
vector105:
  pushl $0
80106068:	6a 00                	push   $0x0
  pushl $105
8010606a:	6a 69                	push   $0x69
  jmp alltraps
8010606c:	e9 72 f7 ff ff       	jmp    801057e3 <alltraps>

80106071 <vector106>:
.globl vector106
vector106:
  pushl $0
80106071:	6a 00                	push   $0x0
  pushl $106
80106073:	6a 6a                	push   $0x6a
  jmp alltraps
80106075:	e9 69 f7 ff ff       	jmp    801057e3 <alltraps>

8010607a <vector107>:
.globl vector107
vector107:
  pushl $0
8010607a:	6a 00                	push   $0x0
  pushl $107
8010607c:	6a 6b                	push   $0x6b
  jmp alltraps
8010607e:	e9 60 f7 ff ff       	jmp    801057e3 <alltraps>

80106083 <vector108>:
.globl vector108
vector108:
  pushl $0
80106083:	6a 00                	push   $0x0
  pushl $108
80106085:	6a 6c                	push   $0x6c
  jmp alltraps
80106087:	e9 57 f7 ff ff       	jmp    801057e3 <alltraps>

8010608c <vector109>:
.globl vector109
vector109:
  pushl $0
8010608c:	6a 00                	push   $0x0
  pushl $109
8010608e:	6a 6d                	push   $0x6d
  jmp alltraps
80106090:	e9 4e f7 ff ff       	jmp    801057e3 <alltraps>

80106095 <vector110>:
.globl vector110
vector110:
  pushl $0
80106095:	6a 00                	push   $0x0
  pushl $110
80106097:	6a 6e                	push   $0x6e
  jmp alltraps
80106099:	e9 45 f7 ff ff       	jmp    801057e3 <alltraps>

8010609e <vector111>:
.globl vector111
vector111:
  pushl $0
8010609e:	6a 00                	push   $0x0
  pushl $111
801060a0:	6a 6f                	push   $0x6f
  jmp alltraps
801060a2:	e9 3c f7 ff ff       	jmp    801057e3 <alltraps>

801060a7 <vector112>:
.globl vector112
vector112:
  pushl $0
801060a7:	6a 00                	push   $0x0
  pushl $112
801060a9:	6a 70                	push   $0x70
  jmp alltraps
801060ab:	e9 33 f7 ff ff       	jmp    801057e3 <alltraps>

801060b0 <vector113>:
.globl vector113
vector113:
  pushl $0
801060b0:	6a 00                	push   $0x0
  pushl $113
801060b2:	6a 71                	push   $0x71
  jmp alltraps
801060b4:	e9 2a f7 ff ff       	jmp    801057e3 <alltraps>

801060b9 <vector114>:
.globl vector114
vector114:
  pushl $0
801060b9:	6a 00                	push   $0x0
  pushl $114
801060bb:	6a 72                	push   $0x72
  jmp alltraps
801060bd:	e9 21 f7 ff ff       	jmp    801057e3 <alltraps>

801060c2 <vector115>:
.globl vector115
vector115:
  pushl $0
801060c2:	6a 00                	push   $0x0
  pushl $115
801060c4:	6a 73                	push   $0x73
  jmp alltraps
801060c6:	e9 18 f7 ff ff       	jmp    801057e3 <alltraps>

801060cb <vector116>:
.globl vector116
vector116:
  pushl $0
801060cb:	6a 00                	push   $0x0
  pushl $116
801060cd:	6a 74                	push   $0x74
  jmp alltraps
801060cf:	e9 0f f7 ff ff       	jmp    801057e3 <alltraps>

801060d4 <vector117>:
.globl vector117
vector117:
  pushl $0
801060d4:	6a 00                	push   $0x0
  pushl $117
801060d6:	6a 75                	push   $0x75
  jmp alltraps
801060d8:	e9 06 f7 ff ff       	jmp    801057e3 <alltraps>

801060dd <vector118>:
.globl vector118
vector118:
  pushl $0
801060dd:	6a 00                	push   $0x0
  pushl $118
801060df:	6a 76                	push   $0x76
  jmp alltraps
801060e1:	e9 fd f6 ff ff       	jmp    801057e3 <alltraps>

801060e6 <vector119>:
.globl vector119
vector119:
  pushl $0
801060e6:	6a 00                	push   $0x0
  pushl $119
801060e8:	6a 77                	push   $0x77
  jmp alltraps
801060ea:	e9 f4 f6 ff ff       	jmp    801057e3 <alltraps>

801060ef <vector120>:
.globl vector120
vector120:
  pushl $0
801060ef:	6a 00                	push   $0x0
  pushl $120
801060f1:	6a 78                	push   $0x78
  jmp alltraps
801060f3:	e9 eb f6 ff ff       	jmp    801057e3 <alltraps>

801060f8 <vector121>:
.globl vector121
vector121:
  pushl $0
801060f8:	6a 00                	push   $0x0
  pushl $121
801060fa:	6a 79                	push   $0x79
  jmp alltraps
801060fc:	e9 e2 f6 ff ff       	jmp    801057e3 <alltraps>

80106101 <vector122>:
.globl vector122
vector122:
  pushl $0
80106101:	6a 00                	push   $0x0
  pushl $122
80106103:	6a 7a                	push   $0x7a
  jmp alltraps
80106105:	e9 d9 f6 ff ff       	jmp    801057e3 <alltraps>

8010610a <vector123>:
.globl vector123
vector123:
  pushl $0
8010610a:	6a 00                	push   $0x0
  pushl $123
8010610c:	6a 7b                	push   $0x7b
  jmp alltraps
8010610e:	e9 d0 f6 ff ff       	jmp    801057e3 <alltraps>

80106113 <vector124>:
.globl vector124
vector124:
  pushl $0
80106113:	6a 00                	push   $0x0
  pushl $124
80106115:	6a 7c                	push   $0x7c
  jmp alltraps
80106117:	e9 c7 f6 ff ff       	jmp    801057e3 <alltraps>

8010611c <vector125>:
.globl vector125
vector125:
  pushl $0
8010611c:	6a 00                	push   $0x0
  pushl $125
8010611e:	6a 7d                	push   $0x7d
  jmp alltraps
80106120:	e9 be f6 ff ff       	jmp    801057e3 <alltraps>

80106125 <vector126>:
.globl vector126
vector126:
  pushl $0
80106125:	6a 00                	push   $0x0
  pushl $126
80106127:	6a 7e                	push   $0x7e
  jmp alltraps
80106129:	e9 b5 f6 ff ff       	jmp    801057e3 <alltraps>

8010612e <vector127>:
.globl vector127
vector127:
  pushl $0
8010612e:	6a 00                	push   $0x0
  pushl $127
80106130:	6a 7f                	push   $0x7f
  jmp alltraps
80106132:	e9 ac f6 ff ff       	jmp    801057e3 <alltraps>

80106137 <vector128>:
.globl vector128
vector128:
  pushl $0
80106137:	6a 00                	push   $0x0
  pushl $128
80106139:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010613e:	e9 a0 f6 ff ff       	jmp    801057e3 <alltraps>

80106143 <vector129>:
.globl vector129
vector129:
  pushl $0
80106143:	6a 00                	push   $0x0
  pushl $129
80106145:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010614a:	e9 94 f6 ff ff       	jmp    801057e3 <alltraps>

8010614f <vector130>:
.globl vector130
vector130:
  pushl $0
8010614f:	6a 00                	push   $0x0
  pushl $130
80106151:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106156:	e9 88 f6 ff ff       	jmp    801057e3 <alltraps>

8010615b <vector131>:
.globl vector131
vector131:
  pushl $0
8010615b:	6a 00                	push   $0x0
  pushl $131
8010615d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106162:	e9 7c f6 ff ff       	jmp    801057e3 <alltraps>

80106167 <vector132>:
.globl vector132
vector132:
  pushl $0
80106167:	6a 00                	push   $0x0
  pushl $132
80106169:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010616e:	e9 70 f6 ff ff       	jmp    801057e3 <alltraps>

80106173 <vector133>:
.globl vector133
vector133:
  pushl $0
80106173:	6a 00                	push   $0x0
  pushl $133
80106175:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010617a:	e9 64 f6 ff ff       	jmp    801057e3 <alltraps>

8010617f <vector134>:
.globl vector134
vector134:
  pushl $0
8010617f:	6a 00                	push   $0x0
  pushl $134
80106181:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106186:	e9 58 f6 ff ff       	jmp    801057e3 <alltraps>

8010618b <vector135>:
.globl vector135
vector135:
  pushl $0
8010618b:	6a 00                	push   $0x0
  pushl $135
8010618d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106192:	e9 4c f6 ff ff       	jmp    801057e3 <alltraps>

80106197 <vector136>:
.globl vector136
vector136:
  pushl $0
80106197:	6a 00                	push   $0x0
  pushl $136
80106199:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010619e:	e9 40 f6 ff ff       	jmp    801057e3 <alltraps>

801061a3 <vector137>:
.globl vector137
vector137:
  pushl $0
801061a3:	6a 00                	push   $0x0
  pushl $137
801061a5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801061aa:	e9 34 f6 ff ff       	jmp    801057e3 <alltraps>

801061af <vector138>:
.globl vector138
vector138:
  pushl $0
801061af:	6a 00                	push   $0x0
  pushl $138
801061b1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801061b6:	e9 28 f6 ff ff       	jmp    801057e3 <alltraps>

801061bb <vector139>:
.globl vector139
vector139:
  pushl $0
801061bb:	6a 00                	push   $0x0
  pushl $139
801061bd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801061c2:	e9 1c f6 ff ff       	jmp    801057e3 <alltraps>

801061c7 <vector140>:
.globl vector140
vector140:
  pushl $0
801061c7:	6a 00                	push   $0x0
  pushl $140
801061c9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801061ce:	e9 10 f6 ff ff       	jmp    801057e3 <alltraps>

801061d3 <vector141>:
.globl vector141
vector141:
  pushl $0
801061d3:	6a 00                	push   $0x0
  pushl $141
801061d5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801061da:	e9 04 f6 ff ff       	jmp    801057e3 <alltraps>

801061df <vector142>:
.globl vector142
vector142:
  pushl $0
801061df:	6a 00                	push   $0x0
  pushl $142
801061e1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801061e6:	e9 f8 f5 ff ff       	jmp    801057e3 <alltraps>

801061eb <vector143>:
.globl vector143
vector143:
  pushl $0
801061eb:	6a 00                	push   $0x0
  pushl $143
801061ed:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801061f2:	e9 ec f5 ff ff       	jmp    801057e3 <alltraps>

801061f7 <vector144>:
.globl vector144
vector144:
  pushl $0
801061f7:	6a 00                	push   $0x0
  pushl $144
801061f9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801061fe:	e9 e0 f5 ff ff       	jmp    801057e3 <alltraps>

80106203 <vector145>:
.globl vector145
vector145:
  pushl $0
80106203:	6a 00                	push   $0x0
  pushl $145
80106205:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010620a:	e9 d4 f5 ff ff       	jmp    801057e3 <alltraps>

8010620f <vector146>:
.globl vector146
vector146:
  pushl $0
8010620f:	6a 00                	push   $0x0
  pushl $146
80106211:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106216:	e9 c8 f5 ff ff       	jmp    801057e3 <alltraps>

8010621b <vector147>:
.globl vector147
vector147:
  pushl $0
8010621b:	6a 00                	push   $0x0
  pushl $147
8010621d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106222:	e9 bc f5 ff ff       	jmp    801057e3 <alltraps>

80106227 <vector148>:
.globl vector148
vector148:
  pushl $0
80106227:	6a 00                	push   $0x0
  pushl $148
80106229:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010622e:	e9 b0 f5 ff ff       	jmp    801057e3 <alltraps>

80106233 <vector149>:
.globl vector149
vector149:
  pushl $0
80106233:	6a 00                	push   $0x0
  pushl $149
80106235:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010623a:	e9 a4 f5 ff ff       	jmp    801057e3 <alltraps>

8010623f <vector150>:
.globl vector150
vector150:
  pushl $0
8010623f:	6a 00                	push   $0x0
  pushl $150
80106241:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106246:	e9 98 f5 ff ff       	jmp    801057e3 <alltraps>

8010624b <vector151>:
.globl vector151
vector151:
  pushl $0
8010624b:	6a 00                	push   $0x0
  pushl $151
8010624d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106252:	e9 8c f5 ff ff       	jmp    801057e3 <alltraps>

80106257 <vector152>:
.globl vector152
vector152:
  pushl $0
80106257:	6a 00                	push   $0x0
  pushl $152
80106259:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010625e:	e9 80 f5 ff ff       	jmp    801057e3 <alltraps>

80106263 <vector153>:
.globl vector153
vector153:
  pushl $0
80106263:	6a 00                	push   $0x0
  pushl $153
80106265:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010626a:	e9 74 f5 ff ff       	jmp    801057e3 <alltraps>

8010626f <vector154>:
.globl vector154
vector154:
  pushl $0
8010626f:	6a 00                	push   $0x0
  pushl $154
80106271:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106276:	e9 68 f5 ff ff       	jmp    801057e3 <alltraps>

8010627b <vector155>:
.globl vector155
vector155:
  pushl $0
8010627b:	6a 00                	push   $0x0
  pushl $155
8010627d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106282:	e9 5c f5 ff ff       	jmp    801057e3 <alltraps>

80106287 <vector156>:
.globl vector156
vector156:
  pushl $0
80106287:	6a 00                	push   $0x0
  pushl $156
80106289:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010628e:	e9 50 f5 ff ff       	jmp    801057e3 <alltraps>

80106293 <vector157>:
.globl vector157
vector157:
  pushl $0
80106293:	6a 00                	push   $0x0
  pushl $157
80106295:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010629a:	e9 44 f5 ff ff       	jmp    801057e3 <alltraps>

8010629f <vector158>:
.globl vector158
vector158:
  pushl $0
8010629f:	6a 00                	push   $0x0
  pushl $158
801062a1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801062a6:	e9 38 f5 ff ff       	jmp    801057e3 <alltraps>

801062ab <vector159>:
.globl vector159
vector159:
  pushl $0
801062ab:	6a 00                	push   $0x0
  pushl $159
801062ad:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801062b2:	e9 2c f5 ff ff       	jmp    801057e3 <alltraps>

801062b7 <vector160>:
.globl vector160
vector160:
  pushl $0
801062b7:	6a 00                	push   $0x0
  pushl $160
801062b9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801062be:	e9 20 f5 ff ff       	jmp    801057e3 <alltraps>

801062c3 <vector161>:
.globl vector161
vector161:
  pushl $0
801062c3:	6a 00                	push   $0x0
  pushl $161
801062c5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801062ca:	e9 14 f5 ff ff       	jmp    801057e3 <alltraps>

801062cf <vector162>:
.globl vector162
vector162:
  pushl $0
801062cf:	6a 00                	push   $0x0
  pushl $162
801062d1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801062d6:	e9 08 f5 ff ff       	jmp    801057e3 <alltraps>

801062db <vector163>:
.globl vector163
vector163:
  pushl $0
801062db:	6a 00                	push   $0x0
  pushl $163
801062dd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801062e2:	e9 fc f4 ff ff       	jmp    801057e3 <alltraps>

801062e7 <vector164>:
.globl vector164
vector164:
  pushl $0
801062e7:	6a 00                	push   $0x0
  pushl $164
801062e9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801062ee:	e9 f0 f4 ff ff       	jmp    801057e3 <alltraps>

801062f3 <vector165>:
.globl vector165
vector165:
  pushl $0
801062f3:	6a 00                	push   $0x0
  pushl $165
801062f5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801062fa:	e9 e4 f4 ff ff       	jmp    801057e3 <alltraps>

801062ff <vector166>:
.globl vector166
vector166:
  pushl $0
801062ff:	6a 00                	push   $0x0
  pushl $166
80106301:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106306:	e9 d8 f4 ff ff       	jmp    801057e3 <alltraps>

8010630b <vector167>:
.globl vector167
vector167:
  pushl $0
8010630b:	6a 00                	push   $0x0
  pushl $167
8010630d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106312:	e9 cc f4 ff ff       	jmp    801057e3 <alltraps>

80106317 <vector168>:
.globl vector168
vector168:
  pushl $0
80106317:	6a 00                	push   $0x0
  pushl $168
80106319:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010631e:	e9 c0 f4 ff ff       	jmp    801057e3 <alltraps>

80106323 <vector169>:
.globl vector169
vector169:
  pushl $0
80106323:	6a 00                	push   $0x0
  pushl $169
80106325:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010632a:	e9 b4 f4 ff ff       	jmp    801057e3 <alltraps>

8010632f <vector170>:
.globl vector170
vector170:
  pushl $0
8010632f:	6a 00                	push   $0x0
  pushl $170
80106331:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106336:	e9 a8 f4 ff ff       	jmp    801057e3 <alltraps>

8010633b <vector171>:
.globl vector171
vector171:
  pushl $0
8010633b:	6a 00                	push   $0x0
  pushl $171
8010633d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106342:	e9 9c f4 ff ff       	jmp    801057e3 <alltraps>

80106347 <vector172>:
.globl vector172
vector172:
  pushl $0
80106347:	6a 00                	push   $0x0
  pushl $172
80106349:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010634e:	e9 90 f4 ff ff       	jmp    801057e3 <alltraps>

80106353 <vector173>:
.globl vector173
vector173:
  pushl $0
80106353:	6a 00                	push   $0x0
  pushl $173
80106355:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010635a:	e9 84 f4 ff ff       	jmp    801057e3 <alltraps>

8010635f <vector174>:
.globl vector174
vector174:
  pushl $0
8010635f:	6a 00                	push   $0x0
  pushl $174
80106361:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106366:	e9 78 f4 ff ff       	jmp    801057e3 <alltraps>

8010636b <vector175>:
.globl vector175
vector175:
  pushl $0
8010636b:	6a 00                	push   $0x0
  pushl $175
8010636d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106372:	e9 6c f4 ff ff       	jmp    801057e3 <alltraps>

80106377 <vector176>:
.globl vector176
vector176:
  pushl $0
80106377:	6a 00                	push   $0x0
  pushl $176
80106379:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010637e:	e9 60 f4 ff ff       	jmp    801057e3 <alltraps>

80106383 <vector177>:
.globl vector177
vector177:
  pushl $0
80106383:	6a 00                	push   $0x0
  pushl $177
80106385:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010638a:	e9 54 f4 ff ff       	jmp    801057e3 <alltraps>

8010638f <vector178>:
.globl vector178
vector178:
  pushl $0
8010638f:	6a 00                	push   $0x0
  pushl $178
80106391:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106396:	e9 48 f4 ff ff       	jmp    801057e3 <alltraps>

8010639b <vector179>:
.globl vector179
vector179:
  pushl $0
8010639b:	6a 00                	push   $0x0
  pushl $179
8010639d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801063a2:	e9 3c f4 ff ff       	jmp    801057e3 <alltraps>

801063a7 <vector180>:
.globl vector180
vector180:
  pushl $0
801063a7:	6a 00                	push   $0x0
  pushl $180
801063a9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801063ae:	e9 30 f4 ff ff       	jmp    801057e3 <alltraps>

801063b3 <vector181>:
.globl vector181
vector181:
  pushl $0
801063b3:	6a 00                	push   $0x0
  pushl $181
801063b5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801063ba:	e9 24 f4 ff ff       	jmp    801057e3 <alltraps>

801063bf <vector182>:
.globl vector182
vector182:
  pushl $0
801063bf:	6a 00                	push   $0x0
  pushl $182
801063c1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801063c6:	e9 18 f4 ff ff       	jmp    801057e3 <alltraps>

801063cb <vector183>:
.globl vector183
vector183:
  pushl $0
801063cb:	6a 00                	push   $0x0
  pushl $183
801063cd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801063d2:	e9 0c f4 ff ff       	jmp    801057e3 <alltraps>

801063d7 <vector184>:
.globl vector184
vector184:
  pushl $0
801063d7:	6a 00                	push   $0x0
  pushl $184
801063d9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801063de:	e9 00 f4 ff ff       	jmp    801057e3 <alltraps>

801063e3 <vector185>:
.globl vector185
vector185:
  pushl $0
801063e3:	6a 00                	push   $0x0
  pushl $185
801063e5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801063ea:	e9 f4 f3 ff ff       	jmp    801057e3 <alltraps>

801063ef <vector186>:
.globl vector186
vector186:
  pushl $0
801063ef:	6a 00                	push   $0x0
  pushl $186
801063f1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801063f6:	e9 e8 f3 ff ff       	jmp    801057e3 <alltraps>

801063fb <vector187>:
.globl vector187
vector187:
  pushl $0
801063fb:	6a 00                	push   $0x0
  pushl $187
801063fd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106402:	e9 dc f3 ff ff       	jmp    801057e3 <alltraps>

80106407 <vector188>:
.globl vector188
vector188:
  pushl $0
80106407:	6a 00                	push   $0x0
  pushl $188
80106409:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010640e:	e9 d0 f3 ff ff       	jmp    801057e3 <alltraps>

80106413 <vector189>:
.globl vector189
vector189:
  pushl $0
80106413:	6a 00                	push   $0x0
  pushl $189
80106415:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010641a:	e9 c4 f3 ff ff       	jmp    801057e3 <alltraps>

8010641f <vector190>:
.globl vector190
vector190:
  pushl $0
8010641f:	6a 00                	push   $0x0
  pushl $190
80106421:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106426:	e9 b8 f3 ff ff       	jmp    801057e3 <alltraps>

8010642b <vector191>:
.globl vector191
vector191:
  pushl $0
8010642b:	6a 00                	push   $0x0
  pushl $191
8010642d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106432:	e9 ac f3 ff ff       	jmp    801057e3 <alltraps>

80106437 <vector192>:
.globl vector192
vector192:
  pushl $0
80106437:	6a 00                	push   $0x0
  pushl $192
80106439:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010643e:	e9 a0 f3 ff ff       	jmp    801057e3 <alltraps>

80106443 <vector193>:
.globl vector193
vector193:
  pushl $0
80106443:	6a 00                	push   $0x0
  pushl $193
80106445:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010644a:	e9 94 f3 ff ff       	jmp    801057e3 <alltraps>

8010644f <vector194>:
.globl vector194
vector194:
  pushl $0
8010644f:	6a 00                	push   $0x0
  pushl $194
80106451:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106456:	e9 88 f3 ff ff       	jmp    801057e3 <alltraps>

8010645b <vector195>:
.globl vector195
vector195:
  pushl $0
8010645b:	6a 00                	push   $0x0
  pushl $195
8010645d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106462:	e9 7c f3 ff ff       	jmp    801057e3 <alltraps>

80106467 <vector196>:
.globl vector196
vector196:
  pushl $0
80106467:	6a 00                	push   $0x0
  pushl $196
80106469:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010646e:	e9 70 f3 ff ff       	jmp    801057e3 <alltraps>

80106473 <vector197>:
.globl vector197
vector197:
  pushl $0
80106473:	6a 00                	push   $0x0
  pushl $197
80106475:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010647a:	e9 64 f3 ff ff       	jmp    801057e3 <alltraps>

8010647f <vector198>:
.globl vector198
vector198:
  pushl $0
8010647f:	6a 00                	push   $0x0
  pushl $198
80106481:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106486:	e9 58 f3 ff ff       	jmp    801057e3 <alltraps>

8010648b <vector199>:
.globl vector199
vector199:
  pushl $0
8010648b:	6a 00                	push   $0x0
  pushl $199
8010648d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106492:	e9 4c f3 ff ff       	jmp    801057e3 <alltraps>

80106497 <vector200>:
.globl vector200
vector200:
  pushl $0
80106497:	6a 00                	push   $0x0
  pushl $200
80106499:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010649e:	e9 40 f3 ff ff       	jmp    801057e3 <alltraps>

801064a3 <vector201>:
.globl vector201
vector201:
  pushl $0
801064a3:	6a 00                	push   $0x0
  pushl $201
801064a5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801064aa:	e9 34 f3 ff ff       	jmp    801057e3 <alltraps>

801064af <vector202>:
.globl vector202
vector202:
  pushl $0
801064af:	6a 00                	push   $0x0
  pushl $202
801064b1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801064b6:	e9 28 f3 ff ff       	jmp    801057e3 <alltraps>

801064bb <vector203>:
.globl vector203
vector203:
  pushl $0
801064bb:	6a 00                	push   $0x0
  pushl $203
801064bd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801064c2:	e9 1c f3 ff ff       	jmp    801057e3 <alltraps>

801064c7 <vector204>:
.globl vector204
vector204:
  pushl $0
801064c7:	6a 00                	push   $0x0
  pushl $204
801064c9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801064ce:	e9 10 f3 ff ff       	jmp    801057e3 <alltraps>

801064d3 <vector205>:
.globl vector205
vector205:
  pushl $0
801064d3:	6a 00                	push   $0x0
  pushl $205
801064d5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801064da:	e9 04 f3 ff ff       	jmp    801057e3 <alltraps>

801064df <vector206>:
.globl vector206
vector206:
  pushl $0
801064df:	6a 00                	push   $0x0
  pushl $206
801064e1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801064e6:	e9 f8 f2 ff ff       	jmp    801057e3 <alltraps>

801064eb <vector207>:
.globl vector207
vector207:
  pushl $0
801064eb:	6a 00                	push   $0x0
  pushl $207
801064ed:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801064f2:	e9 ec f2 ff ff       	jmp    801057e3 <alltraps>

801064f7 <vector208>:
.globl vector208
vector208:
  pushl $0
801064f7:	6a 00                	push   $0x0
  pushl $208
801064f9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801064fe:	e9 e0 f2 ff ff       	jmp    801057e3 <alltraps>

80106503 <vector209>:
.globl vector209
vector209:
  pushl $0
80106503:	6a 00                	push   $0x0
  pushl $209
80106505:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010650a:	e9 d4 f2 ff ff       	jmp    801057e3 <alltraps>

8010650f <vector210>:
.globl vector210
vector210:
  pushl $0
8010650f:	6a 00                	push   $0x0
  pushl $210
80106511:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106516:	e9 c8 f2 ff ff       	jmp    801057e3 <alltraps>

8010651b <vector211>:
.globl vector211
vector211:
  pushl $0
8010651b:	6a 00                	push   $0x0
  pushl $211
8010651d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106522:	e9 bc f2 ff ff       	jmp    801057e3 <alltraps>

80106527 <vector212>:
.globl vector212
vector212:
  pushl $0
80106527:	6a 00                	push   $0x0
  pushl $212
80106529:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010652e:	e9 b0 f2 ff ff       	jmp    801057e3 <alltraps>

80106533 <vector213>:
.globl vector213
vector213:
  pushl $0
80106533:	6a 00                	push   $0x0
  pushl $213
80106535:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010653a:	e9 a4 f2 ff ff       	jmp    801057e3 <alltraps>

8010653f <vector214>:
.globl vector214
vector214:
  pushl $0
8010653f:	6a 00                	push   $0x0
  pushl $214
80106541:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106546:	e9 98 f2 ff ff       	jmp    801057e3 <alltraps>

8010654b <vector215>:
.globl vector215
vector215:
  pushl $0
8010654b:	6a 00                	push   $0x0
  pushl $215
8010654d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106552:	e9 8c f2 ff ff       	jmp    801057e3 <alltraps>

80106557 <vector216>:
.globl vector216
vector216:
  pushl $0
80106557:	6a 00                	push   $0x0
  pushl $216
80106559:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010655e:	e9 80 f2 ff ff       	jmp    801057e3 <alltraps>

80106563 <vector217>:
.globl vector217
vector217:
  pushl $0
80106563:	6a 00                	push   $0x0
  pushl $217
80106565:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010656a:	e9 74 f2 ff ff       	jmp    801057e3 <alltraps>

8010656f <vector218>:
.globl vector218
vector218:
  pushl $0
8010656f:	6a 00                	push   $0x0
  pushl $218
80106571:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106576:	e9 68 f2 ff ff       	jmp    801057e3 <alltraps>

8010657b <vector219>:
.globl vector219
vector219:
  pushl $0
8010657b:	6a 00                	push   $0x0
  pushl $219
8010657d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106582:	e9 5c f2 ff ff       	jmp    801057e3 <alltraps>

80106587 <vector220>:
.globl vector220
vector220:
  pushl $0
80106587:	6a 00                	push   $0x0
  pushl $220
80106589:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010658e:	e9 50 f2 ff ff       	jmp    801057e3 <alltraps>

80106593 <vector221>:
.globl vector221
vector221:
  pushl $0
80106593:	6a 00                	push   $0x0
  pushl $221
80106595:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010659a:	e9 44 f2 ff ff       	jmp    801057e3 <alltraps>

8010659f <vector222>:
.globl vector222
vector222:
  pushl $0
8010659f:	6a 00                	push   $0x0
  pushl $222
801065a1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801065a6:	e9 38 f2 ff ff       	jmp    801057e3 <alltraps>

801065ab <vector223>:
.globl vector223
vector223:
  pushl $0
801065ab:	6a 00                	push   $0x0
  pushl $223
801065ad:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801065b2:	e9 2c f2 ff ff       	jmp    801057e3 <alltraps>

801065b7 <vector224>:
.globl vector224
vector224:
  pushl $0
801065b7:	6a 00                	push   $0x0
  pushl $224
801065b9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801065be:	e9 20 f2 ff ff       	jmp    801057e3 <alltraps>

801065c3 <vector225>:
.globl vector225
vector225:
  pushl $0
801065c3:	6a 00                	push   $0x0
  pushl $225
801065c5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801065ca:	e9 14 f2 ff ff       	jmp    801057e3 <alltraps>

801065cf <vector226>:
.globl vector226
vector226:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $226
801065d1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801065d6:	e9 08 f2 ff ff       	jmp    801057e3 <alltraps>

801065db <vector227>:
.globl vector227
vector227:
  pushl $0
801065db:	6a 00                	push   $0x0
  pushl $227
801065dd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801065e2:	e9 fc f1 ff ff       	jmp    801057e3 <alltraps>

801065e7 <vector228>:
.globl vector228
vector228:
  pushl $0
801065e7:	6a 00                	push   $0x0
  pushl $228
801065e9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801065ee:	e9 f0 f1 ff ff       	jmp    801057e3 <alltraps>

801065f3 <vector229>:
.globl vector229
vector229:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $229
801065f5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801065fa:	e9 e4 f1 ff ff       	jmp    801057e3 <alltraps>

801065ff <vector230>:
.globl vector230
vector230:
  pushl $0
801065ff:	6a 00                	push   $0x0
  pushl $230
80106601:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106606:	e9 d8 f1 ff ff       	jmp    801057e3 <alltraps>

8010660b <vector231>:
.globl vector231
vector231:
  pushl $0
8010660b:	6a 00                	push   $0x0
  pushl $231
8010660d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106612:	e9 cc f1 ff ff       	jmp    801057e3 <alltraps>

80106617 <vector232>:
.globl vector232
vector232:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $232
80106619:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010661e:	e9 c0 f1 ff ff       	jmp    801057e3 <alltraps>

80106623 <vector233>:
.globl vector233
vector233:
  pushl $0
80106623:	6a 00                	push   $0x0
  pushl $233
80106625:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010662a:	e9 b4 f1 ff ff       	jmp    801057e3 <alltraps>

8010662f <vector234>:
.globl vector234
vector234:
  pushl $0
8010662f:	6a 00                	push   $0x0
  pushl $234
80106631:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106636:	e9 a8 f1 ff ff       	jmp    801057e3 <alltraps>

8010663b <vector235>:
.globl vector235
vector235:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $235
8010663d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106642:	e9 9c f1 ff ff       	jmp    801057e3 <alltraps>

80106647 <vector236>:
.globl vector236
vector236:
  pushl $0
80106647:	6a 00                	push   $0x0
  pushl $236
80106649:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010664e:	e9 90 f1 ff ff       	jmp    801057e3 <alltraps>

80106653 <vector237>:
.globl vector237
vector237:
  pushl $0
80106653:	6a 00                	push   $0x0
  pushl $237
80106655:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010665a:	e9 84 f1 ff ff       	jmp    801057e3 <alltraps>

8010665f <vector238>:
.globl vector238
vector238:
  pushl $0
8010665f:	6a 00                	push   $0x0
  pushl $238
80106661:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106666:	e9 78 f1 ff ff       	jmp    801057e3 <alltraps>

8010666b <vector239>:
.globl vector239
vector239:
  pushl $0
8010666b:	6a 00                	push   $0x0
  pushl $239
8010666d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106672:	e9 6c f1 ff ff       	jmp    801057e3 <alltraps>

80106677 <vector240>:
.globl vector240
vector240:
  pushl $0
80106677:	6a 00                	push   $0x0
  pushl $240
80106679:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010667e:	e9 60 f1 ff ff       	jmp    801057e3 <alltraps>

80106683 <vector241>:
.globl vector241
vector241:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $241
80106685:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010668a:	e9 54 f1 ff ff       	jmp    801057e3 <alltraps>

8010668f <vector242>:
.globl vector242
vector242:
  pushl $0
8010668f:	6a 00                	push   $0x0
  pushl $242
80106691:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106696:	e9 48 f1 ff ff       	jmp    801057e3 <alltraps>

8010669b <vector243>:
.globl vector243
vector243:
  pushl $0
8010669b:	6a 00                	push   $0x0
  pushl $243
8010669d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801066a2:	e9 3c f1 ff ff       	jmp    801057e3 <alltraps>

801066a7 <vector244>:
.globl vector244
vector244:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $244
801066a9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801066ae:	e9 30 f1 ff ff       	jmp    801057e3 <alltraps>

801066b3 <vector245>:
.globl vector245
vector245:
  pushl $0
801066b3:	6a 00                	push   $0x0
  pushl $245
801066b5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801066ba:	e9 24 f1 ff ff       	jmp    801057e3 <alltraps>

801066bf <vector246>:
.globl vector246
vector246:
  pushl $0
801066bf:	6a 00                	push   $0x0
  pushl $246
801066c1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801066c6:	e9 18 f1 ff ff       	jmp    801057e3 <alltraps>

801066cb <vector247>:
.globl vector247
vector247:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $247
801066cd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801066d2:	e9 0c f1 ff ff       	jmp    801057e3 <alltraps>

801066d7 <vector248>:
.globl vector248
vector248:
  pushl $0
801066d7:	6a 00                	push   $0x0
  pushl $248
801066d9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801066de:	e9 00 f1 ff ff       	jmp    801057e3 <alltraps>

801066e3 <vector249>:
.globl vector249
vector249:
  pushl $0
801066e3:	6a 00                	push   $0x0
  pushl $249
801066e5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801066ea:	e9 f4 f0 ff ff       	jmp    801057e3 <alltraps>

801066ef <vector250>:
.globl vector250
vector250:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $250
801066f1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801066f6:	e9 e8 f0 ff ff       	jmp    801057e3 <alltraps>

801066fb <vector251>:
.globl vector251
vector251:
  pushl $0
801066fb:	6a 00                	push   $0x0
  pushl $251
801066fd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106702:	e9 dc f0 ff ff       	jmp    801057e3 <alltraps>

80106707 <vector252>:
.globl vector252
vector252:
  pushl $0
80106707:	6a 00                	push   $0x0
  pushl $252
80106709:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010670e:	e9 d0 f0 ff ff       	jmp    801057e3 <alltraps>

80106713 <vector253>:
.globl vector253
vector253:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $253
80106715:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010671a:	e9 c4 f0 ff ff       	jmp    801057e3 <alltraps>

8010671f <vector254>:
.globl vector254
vector254:
  pushl $0
8010671f:	6a 00                	push   $0x0
  pushl $254
80106721:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106726:	e9 b8 f0 ff ff       	jmp    801057e3 <alltraps>

8010672b <vector255>:
.globl vector255
vector255:
  pushl $0
8010672b:	6a 00                	push   $0x0
  pushl $255
8010672d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106732:	e9 ac f0 ff ff       	jmp    801057e3 <alltraps>
80106737:	66 90                	xchg   %ax,%ax
80106739:	66 90                	xchg   %ax,%ax
8010673b:	66 90                	xchg   %ax,%ax
8010673d:	66 90                	xchg   %ax,%ax
8010673f:	90                   	nop

80106740 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106740:	55                   	push   %ebp
80106741:	89 e5                	mov    %esp,%ebp
80106743:	57                   	push   %edi
80106744:	56                   	push   %esi
80106745:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106746:	89 d3                	mov    %edx,%ebx
{
80106748:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010674a:	c1 eb 16             	shr    $0x16,%ebx
8010674d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106750:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106753:	8b 06                	mov    (%esi),%eax
80106755:	a8 01                	test   $0x1,%al
80106757:	74 27                	je     80106780 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106759:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010675e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106764:	c1 ef 0a             	shr    $0xa,%edi
}
80106767:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010676a:	89 fa                	mov    %edi,%edx
8010676c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106772:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106775:	5b                   	pop    %ebx
80106776:	5e                   	pop    %esi
80106777:	5f                   	pop    %edi
80106778:	5d                   	pop    %ebp
80106779:	c3                   	ret    
8010677a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106780:	85 c9                	test   %ecx,%ecx
80106782:	74 2c                	je     801067b0 <walkpgdir+0x70>
80106784:	e8 a7 be ff ff       	call   80102630 <kalloc>
80106789:	85 c0                	test   %eax,%eax
8010678b:	89 c3                	mov    %eax,%ebx
8010678d:	74 21                	je     801067b0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010678f:	83 ec 04             	sub    $0x4,%esp
80106792:	68 00 10 00 00       	push   $0x1000
80106797:	6a 00                	push   $0x0
80106799:	50                   	push   %eax
8010679a:	e8 21 de ff ff       	call   801045c0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010679f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801067a5:	83 c4 10             	add    $0x10,%esp
801067a8:	83 c8 07             	or     $0x7,%eax
801067ab:	89 06                	mov    %eax,(%esi)
801067ad:	eb b5                	jmp    80106764 <walkpgdir+0x24>
801067af:	90                   	nop
}
801067b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801067b3:	31 c0                	xor    %eax,%eax
}
801067b5:	5b                   	pop    %ebx
801067b6:	5e                   	pop    %esi
801067b7:	5f                   	pop    %edi
801067b8:	5d                   	pop    %ebp
801067b9:	c3                   	ret    
801067ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801067c0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801067c0:	55                   	push   %ebp
801067c1:	89 e5                	mov    %esp,%ebp
801067c3:	57                   	push   %edi
801067c4:	56                   	push   %esi
801067c5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801067c6:	89 d3                	mov    %edx,%ebx
801067c8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801067ce:	83 ec 1c             	sub    $0x1c,%esp
801067d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801067d4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801067d8:	8b 7d 08             	mov    0x8(%ebp),%edi
801067db:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801067e0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801067e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801067e6:	29 df                	sub    %ebx,%edi
801067e8:	83 c8 01             	or     $0x1,%eax
801067eb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801067ee:	eb 15                	jmp    80106805 <mappages+0x45>
    if(*pte & PTE_P)
801067f0:	f6 00 01             	testb  $0x1,(%eax)
801067f3:	75 45                	jne    8010683a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
801067f5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801067f8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
801067fb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801067fd:	74 31                	je     80106830 <mappages+0x70>
      break;
    a += PGSIZE;
801067ff:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106805:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106808:	b9 01 00 00 00       	mov    $0x1,%ecx
8010680d:	89 da                	mov    %ebx,%edx
8010680f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106812:	e8 29 ff ff ff       	call   80106740 <walkpgdir>
80106817:	85 c0                	test   %eax,%eax
80106819:	75 d5                	jne    801067f0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010681b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010681e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106823:	5b                   	pop    %ebx
80106824:	5e                   	pop    %esi
80106825:	5f                   	pop    %edi
80106826:	5d                   	pop    %ebp
80106827:	c3                   	ret    
80106828:	90                   	nop
80106829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106830:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106833:	31 c0                	xor    %eax,%eax
}
80106835:	5b                   	pop    %ebx
80106836:	5e                   	pop    %esi
80106837:	5f                   	pop    %edi
80106838:	5d                   	pop    %ebp
80106839:	c3                   	ret    
      panic("remap");
8010683a:	83 ec 0c             	sub    $0xc,%esp
8010683d:	68 50 79 10 80       	push   $0x80107950
80106842:	e8 09 9c ff ff       	call   80100450 <panic>
80106847:	89 f6                	mov    %esi,%esi
80106849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106850 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106850:	55                   	push   %ebp
80106851:	89 e5                	mov    %esp,%ebp
80106853:	57                   	push   %edi
80106854:	56                   	push   %esi
80106855:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106856:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010685c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
8010685e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106864:	83 ec 1c             	sub    $0x1c,%esp
80106867:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010686a:	39 d3                	cmp    %edx,%ebx
8010686c:	73 66                	jae    801068d4 <deallocuvm.part.0+0x84>
8010686e:	89 d6                	mov    %edx,%esi
80106870:	eb 3d                	jmp    801068af <deallocuvm.part.0+0x5f>
80106872:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106878:	8b 10                	mov    (%eax),%edx
8010687a:	f6 c2 01             	test   $0x1,%dl
8010687d:	74 26                	je     801068a5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010687f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106885:	74 58                	je     801068df <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106887:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010688a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106890:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106893:	52                   	push   %edx
80106894:	e8 e7 bb ff ff       	call   80102480 <kfree>
      *pte = 0;
80106899:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010689c:	83 c4 10             	add    $0x10,%esp
8010689f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801068a5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801068ab:	39 f3                	cmp    %esi,%ebx
801068ad:	73 25                	jae    801068d4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
801068af:	31 c9                	xor    %ecx,%ecx
801068b1:	89 da                	mov    %ebx,%edx
801068b3:	89 f8                	mov    %edi,%eax
801068b5:	e8 86 fe ff ff       	call   80106740 <walkpgdir>
    if(!pte)
801068ba:	85 c0                	test   %eax,%eax
801068bc:	75 ba                	jne    80106878 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801068be:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801068c4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801068ca:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801068d0:	39 f3                	cmp    %esi,%ebx
801068d2:	72 db                	jb     801068af <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
801068d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801068d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068da:	5b                   	pop    %ebx
801068db:	5e                   	pop    %esi
801068dc:	5f                   	pop    %edi
801068dd:	5d                   	pop    %ebp
801068de:	c3                   	ret    
        panic("kfree");
801068df:	83 ec 0c             	sub    $0xc,%esp
801068e2:	68 ee 72 10 80       	push   $0x801072ee
801068e7:	e8 64 9b ff ff       	call   80100450 <panic>
801068ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801068f0 <seginit>:
{
801068f0:	55                   	push   %ebp
801068f1:	89 e5                	mov    %esp,%ebp
801068f3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801068f6:	e8 35 d0 ff ff       	call   80103930 <cpuid>
801068fb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80106901:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106906:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010690a:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
80106911:	ff 00 00 
80106914:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
8010691b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010691e:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
80106925:	ff 00 00 
80106928:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
8010692f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106932:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
80106939:	ff 00 00 
8010693c:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
80106943:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106946:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
8010694d:	ff 00 00 
80106950:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
80106957:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010695a:	05 10 28 11 80       	add    $0x80112810,%eax
  pd[1] = (uint)p;
8010695f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106963:	c1 e8 10             	shr    $0x10,%eax
80106966:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010696a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010696d:	0f 01 10             	lgdtl  (%eax)
}
80106970:	c9                   	leave  
80106971:	c3                   	ret    
80106972:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106980 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106980:	a1 c4 55 11 80       	mov    0x801155c4,%eax
{
80106985:	55                   	push   %ebp
80106986:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106988:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010698d:	0f 22 d8             	mov    %eax,%cr3
}
80106990:	5d                   	pop    %ebp
80106991:	c3                   	ret    
80106992:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069a0 <switchuvm>:
{
801069a0:	55                   	push   %ebp
801069a1:	89 e5                	mov    %esp,%ebp
801069a3:	57                   	push   %edi
801069a4:	56                   	push   %esi
801069a5:	53                   	push   %ebx
801069a6:	83 ec 1c             	sub    $0x1c,%esp
801069a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
801069ac:	85 db                	test   %ebx,%ebx
801069ae:	0f 84 cb 00 00 00    	je     80106a7f <switchuvm+0xdf>
  if(p->kstack == 0)
801069b4:	8b 43 08             	mov    0x8(%ebx),%eax
801069b7:	85 c0                	test   %eax,%eax
801069b9:	0f 84 da 00 00 00    	je     80106a99 <switchuvm+0xf9>
  if(p->pgdir == 0)
801069bf:	8b 43 04             	mov    0x4(%ebx),%eax
801069c2:	85 c0                	test   %eax,%eax
801069c4:	0f 84 c2 00 00 00    	je     80106a8c <switchuvm+0xec>
  pushcli();
801069ca:	e8 11 da ff ff       	call   801043e0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801069cf:	e8 dc ce ff ff       	call   801038b0 <mycpu>
801069d4:	89 c6                	mov    %eax,%esi
801069d6:	e8 d5 ce ff ff       	call   801038b0 <mycpu>
801069db:	89 c7                	mov    %eax,%edi
801069dd:	e8 ce ce ff ff       	call   801038b0 <mycpu>
801069e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801069e5:	83 c7 08             	add    $0x8,%edi
801069e8:	e8 c3 ce ff ff       	call   801038b0 <mycpu>
801069ed:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801069f0:	83 c0 08             	add    $0x8,%eax
801069f3:	ba 67 00 00 00       	mov    $0x67,%edx
801069f8:	c1 e8 18             	shr    $0x18,%eax
801069fb:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106a02:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106a09:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106a0f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106a14:	83 c1 08             	add    $0x8,%ecx
80106a17:	c1 e9 10             	shr    $0x10,%ecx
80106a1a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106a20:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106a25:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106a2c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106a31:	e8 7a ce ff ff       	call   801038b0 <mycpu>
80106a36:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106a3d:	e8 6e ce ff ff       	call   801038b0 <mycpu>
80106a42:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106a46:	8b 73 08             	mov    0x8(%ebx),%esi
80106a49:	e8 62 ce ff ff       	call   801038b0 <mycpu>
80106a4e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106a54:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106a57:	e8 54 ce ff ff       	call   801038b0 <mycpu>
80106a5c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106a60:	b8 28 00 00 00       	mov    $0x28,%eax
80106a65:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106a68:	8b 43 04             	mov    0x4(%ebx),%eax
80106a6b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106a70:	0f 22 d8             	mov    %eax,%cr3
}
80106a73:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a76:	5b                   	pop    %ebx
80106a77:	5e                   	pop    %esi
80106a78:	5f                   	pop    %edi
80106a79:	5d                   	pop    %ebp
  popcli();
80106a7a:	e9 a1 d9 ff ff       	jmp    80104420 <popcli>
    panic("switchuvm: no process");
80106a7f:	83 ec 0c             	sub    $0xc,%esp
80106a82:	68 56 79 10 80       	push   $0x80107956
80106a87:	e8 c4 99 ff ff       	call   80100450 <panic>
    panic("switchuvm: no pgdir");
80106a8c:	83 ec 0c             	sub    $0xc,%esp
80106a8f:	68 81 79 10 80       	push   $0x80107981
80106a94:	e8 b7 99 ff ff       	call   80100450 <panic>
    panic("switchuvm: no kstack");
80106a99:	83 ec 0c             	sub    $0xc,%esp
80106a9c:	68 6c 79 10 80       	push   $0x8010796c
80106aa1:	e8 aa 99 ff ff       	call   80100450 <panic>
80106aa6:	8d 76 00             	lea    0x0(%esi),%esi
80106aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ab0 <inituvm>:
{
80106ab0:	55                   	push   %ebp
80106ab1:	89 e5                	mov    %esp,%ebp
80106ab3:	57                   	push   %edi
80106ab4:	56                   	push   %esi
80106ab5:	53                   	push   %ebx
80106ab6:	83 ec 1c             	sub    $0x1c,%esp
80106ab9:	8b 75 10             	mov    0x10(%ebp),%esi
80106abc:	8b 45 08             	mov    0x8(%ebp),%eax
80106abf:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106ac2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106ac8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106acb:	77 49                	ja     80106b16 <inituvm+0x66>
  mem = kalloc();
80106acd:	e8 5e bb ff ff       	call   80102630 <kalloc>
  memset(mem, 0, PGSIZE);
80106ad2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106ad5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106ad7:	68 00 10 00 00       	push   $0x1000
80106adc:	6a 00                	push   $0x0
80106ade:	50                   	push   %eax
80106adf:	e8 dc da ff ff       	call   801045c0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106ae4:	58                   	pop    %eax
80106ae5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106aeb:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106af0:	5a                   	pop    %edx
80106af1:	6a 06                	push   $0x6
80106af3:	50                   	push   %eax
80106af4:	31 d2                	xor    %edx,%edx
80106af6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106af9:	e8 c2 fc ff ff       	call   801067c0 <mappages>
  memmove(mem, init, sz);
80106afe:	89 75 10             	mov    %esi,0x10(%ebp)
80106b01:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106b04:	83 c4 10             	add    $0x10,%esp
80106b07:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106b0a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b0d:	5b                   	pop    %ebx
80106b0e:	5e                   	pop    %esi
80106b0f:	5f                   	pop    %edi
80106b10:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106b11:	e9 5a db ff ff       	jmp    80104670 <memmove>
    panic("inituvm: more than a page");
80106b16:	83 ec 0c             	sub    $0xc,%esp
80106b19:	68 95 79 10 80       	push   $0x80107995
80106b1e:	e8 2d 99 ff ff       	call   80100450 <panic>
80106b23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b30 <loaduvm>:
{
80106b30:	55                   	push   %ebp
80106b31:	89 e5                	mov    %esp,%ebp
80106b33:	57                   	push   %edi
80106b34:	56                   	push   %esi
80106b35:	53                   	push   %ebx
80106b36:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106b39:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106b40:	0f 85 91 00 00 00    	jne    80106bd7 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106b46:	8b 75 18             	mov    0x18(%ebp),%esi
80106b49:	31 db                	xor    %ebx,%ebx
80106b4b:	85 f6                	test   %esi,%esi
80106b4d:	75 1a                	jne    80106b69 <loaduvm+0x39>
80106b4f:	eb 6f                	jmp    80106bc0 <loaduvm+0x90>
80106b51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b58:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b5e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106b64:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106b67:	76 57                	jbe    80106bc0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106b69:	8b 55 0c             	mov    0xc(%ebp),%edx
80106b6c:	8b 45 08             	mov    0x8(%ebp),%eax
80106b6f:	31 c9                	xor    %ecx,%ecx
80106b71:	01 da                	add    %ebx,%edx
80106b73:	e8 c8 fb ff ff       	call   80106740 <walkpgdir>
80106b78:	85 c0                	test   %eax,%eax
80106b7a:	74 4e                	je     80106bca <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106b7c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106b7e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106b81:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106b86:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106b8b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106b91:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106b94:	01 d9                	add    %ebx,%ecx
80106b96:	05 00 00 00 80       	add    $0x80000000,%eax
80106b9b:	57                   	push   %edi
80106b9c:	51                   	push   %ecx
80106b9d:	50                   	push   %eax
80106b9e:	ff 75 10             	pushl  0x10(%ebp)
80106ba1:	e8 ea ae ff ff       	call   80101a90 <readi>
80106ba6:	83 c4 10             	add    $0x10,%esp
80106ba9:	39 f8                	cmp    %edi,%eax
80106bab:	74 ab                	je     80106b58 <loaduvm+0x28>
}
80106bad:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106bb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106bb5:	5b                   	pop    %ebx
80106bb6:	5e                   	pop    %esi
80106bb7:	5f                   	pop    %edi
80106bb8:	5d                   	pop    %ebp
80106bb9:	c3                   	ret    
80106bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106bc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106bc3:	31 c0                	xor    %eax,%eax
}
80106bc5:	5b                   	pop    %ebx
80106bc6:	5e                   	pop    %esi
80106bc7:	5f                   	pop    %edi
80106bc8:	5d                   	pop    %ebp
80106bc9:	c3                   	ret    
      panic("loaduvm: address should exist");
80106bca:	83 ec 0c             	sub    $0xc,%esp
80106bcd:	68 af 79 10 80       	push   $0x801079af
80106bd2:	e8 79 98 ff ff       	call   80100450 <panic>
    panic("loaduvm: addr must be page aligned");
80106bd7:	83 ec 0c             	sub    $0xc,%esp
80106bda:	68 50 7a 10 80       	push   $0x80107a50
80106bdf:	e8 6c 98 ff ff       	call   80100450 <panic>
80106be4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106bea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106bf0 <allocuvm>:
{
80106bf0:	55                   	push   %ebp
80106bf1:	89 e5                	mov    %esp,%ebp
80106bf3:	57                   	push   %edi
80106bf4:	56                   	push   %esi
80106bf5:	53                   	push   %ebx
80106bf6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106bf9:	8b 7d 10             	mov    0x10(%ebp),%edi
80106bfc:	85 ff                	test   %edi,%edi
80106bfe:	0f 88 8e 00 00 00    	js     80106c92 <allocuvm+0xa2>
  if(newsz < oldsz)
80106c04:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106c07:	0f 82 93 00 00 00    	jb     80106ca0 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
80106c0d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106c10:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106c16:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106c1c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106c1f:	0f 86 7e 00 00 00    	jbe    80106ca3 <allocuvm+0xb3>
80106c25:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106c28:	8b 7d 08             	mov    0x8(%ebp),%edi
80106c2b:	eb 42                	jmp    80106c6f <allocuvm+0x7f>
80106c2d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106c30:	83 ec 04             	sub    $0x4,%esp
80106c33:	68 00 10 00 00       	push   $0x1000
80106c38:	6a 00                	push   $0x0
80106c3a:	50                   	push   %eax
80106c3b:	e8 80 d9 ff ff       	call   801045c0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106c40:	58                   	pop    %eax
80106c41:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106c47:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c4c:	5a                   	pop    %edx
80106c4d:	6a 06                	push   $0x6
80106c4f:	50                   	push   %eax
80106c50:	89 da                	mov    %ebx,%edx
80106c52:	89 f8                	mov    %edi,%eax
80106c54:	e8 67 fb ff ff       	call   801067c0 <mappages>
80106c59:	83 c4 10             	add    $0x10,%esp
80106c5c:	85 c0                	test   %eax,%eax
80106c5e:	78 50                	js     80106cb0 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80106c60:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c66:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106c69:	0f 86 81 00 00 00    	jbe    80106cf0 <allocuvm+0x100>
    mem = kalloc();
80106c6f:	e8 bc b9 ff ff       	call   80102630 <kalloc>
    if(mem == 0){
80106c74:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106c76:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106c78:	75 b6                	jne    80106c30 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106c7a:	83 ec 0c             	sub    $0xc,%esp
80106c7d:	68 cd 79 10 80       	push   $0x801079cd
80106c82:	e8 99 9a ff ff       	call   80100720 <cprintf>
  if(newsz >= oldsz)
80106c87:	83 c4 10             	add    $0x10,%esp
80106c8a:	8b 45 0c             	mov    0xc(%ebp),%eax
80106c8d:	39 45 10             	cmp    %eax,0x10(%ebp)
80106c90:	77 6e                	ja     80106d00 <allocuvm+0x110>
}
80106c92:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106c95:	31 ff                	xor    %edi,%edi
}
80106c97:	89 f8                	mov    %edi,%eax
80106c99:	5b                   	pop    %ebx
80106c9a:	5e                   	pop    %esi
80106c9b:	5f                   	pop    %edi
80106c9c:	5d                   	pop    %ebp
80106c9d:	c3                   	ret    
80106c9e:	66 90                	xchg   %ax,%ax
    return oldsz;
80106ca0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106ca3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ca6:	89 f8                	mov    %edi,%eax
80106ca8:	5b                   	pop    %ebx
80106ca9:	5e                   	pop    %esi
80106caa:	5f                   	pop    %edi
80106cab:	5d                   	pop    %ebp
80106cac:	c3                   	ret    
80106cad:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106cb0:	83 ec 0c             	sub    $0xc,%esp
80106cb3:	68 e5 79 10 80       	push   $0x801079e5
80106cb8:	e8 63 9a ff ff       	call   80100720 <cprintf>
  if(newsz >= oldsz)
80106cbd:	83 c4 10             	add    $0x10,%esp
80106cc0:	8b 45 0c             	mov    0xc(%ebp),%eax
80106cc3:	39 45 10             	cmp    %eax,0x10(%ebp)
80106cc6:	76 0d                	jbe    80106cd5 <allocuvm+0xe5>
80106cc8:	89 c1                	mov    %eax,%ecx
80106cca:	8b 55 10             	mov    0x10(%ebp),%edx
80106ccd:	8b 45 08             	mov    0x8(%ebp),%eax
80106cd0:	e8 7b fb ff ff       	call   80106850 <deallocuvm.part.0>
      kfree(mem);
80106cd5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106cd8:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106cda:	56                   	push   %esi
80106cdb:	e8 a0 b7 ff ff       	call   80102480 <kfree>
      return 0;
80106ce0:	83 c4 10             	add    $0x10,%esp
}
80106ce3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ce6:	89 f8                	mov    %edi,%eax
80106ce8:	5b                   	pop    %ebx
80106ce9:	5e                   	pop    %esi
80106cea:	5f                   	pop    %edi
80106ceb:	5d                   	pop    %ebp
80106cec:	c3                   	ret    
80106ced:	8d 76 00             	lea    0x0(%esi),%esi
80106cf0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106cf3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cf6:	5b                   	pop    %ebx
80106cf7:	89 f8                	mov    %edi,%eax
80106cf9:	5e                   	pop    %esi
80106cfa:	5f                   	pop    %edi
80106cfb:	5d                   	pop    %ebp
80106cfc:	c3                   	ret    
80106cfd:	8d 76 00             	lea    0x0(%esi),%esi
80106d00:	89 c1                	mov    %eax,%ecx
80106d02:	8b 55 10             	mov    0x10(%ebp),%edx
80106d05:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106d08:	31 ff                	xor    %edi,%edi
80106d0a:	e8 41 fb ff ff       	call   80106850 <deallocuvm.part.0>
80106d0f:	eb 92                	jmp    80106ca3 <allocuvm+0xb3>
80106d11:	eb 0d                	jmp    80106d20 <deallocuvm>
80106d13:	90                   	nop
80106d14:	90                   	nop
80106d15:	90                   	nop
80106d16:	90                   	nop
80106d17:	90                   	nop
80106d18:	90                   	nop
80106d19:	90                   	nop
80106d1a:	90                   	nop
80106d1b:	90                   	nop
80106d1c:	90                   	nop
80106d1d:	90                   	nop
80106d1e:	90                   	nop
80106d1f:	90                   	nop

80106d20 <deallocuvm>:
{
80106d20:	55                   	push   %ebp
80106d21:	89 e5                	mov    %esp,%ebp
80106d23:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d26:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106d29:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106d2c:	39 d1                	cmp    %edx,%ecx
80106d2e:	73 10                	jae    80106d40 <deallocuvm+0x20>
}
80106d30:	5d                   	pop    %ebp
80106d31:	e9 1a fb ff ff       	jmp    80106850 <deallocuvm.part.0>
80106d36:	8d 76 00             	lea    0x0(%esi),%esi
80106d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106d40:	89 d0                	mov    %edx,%eax
80106d42:	5d                   	pop    %ebp
80106d43:	c3                   	ret    
80106d44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106d50 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106d50:	55                   	push   %ebp
80106d51:	89 e5                	mov    %esp,%ebp
80106d53:	57                   	push   %edi
80106d54:	56                   	push   %esi
80106d55:	53                   	push   %ebx
80106d56:	83 ec 0c             	sub    $0xc,%esp
80106d59:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106d5c:	85 f6                	test   %esi,%esi
80106d5e:	74 59                	je     80106db9 <freevm+0x69>
80106d60:	31 c9                	xor    %ecx,%ecx
80106d62:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106d67:	89 f0                	mov    %esi,%eax
80106d69:	e8 e2 fa ff ff       	call   80106850 <deallocuvm.part.0>
80106d6e:	89 f3                	mov    %esi,%ebx
80106d70:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106d76:	eb 0f                	jmp    80106d87 <freevm+0x37>
80106d78:	90                   	nop
80106d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d80:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106d83:	39 fb                	cmp    %edi,%ebx
80106d85:	74 23                	je     80106daa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106d87:	8b 03                	mov    (%ebx),%eax
80106d89:	a8 01                	test   $0x1,%al
80106d8b:	74 f3                	je     80106d80 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106d8d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106d92:	83 ec 0c             	sub    $0xc,%esp
80106d95:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106d98:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106d9d:	50                   	push   %eax
80106d9e:	e8 dd b6 ff ff       	call   80102480 <kfree>
80106da3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106da6:	39 fb                	cmp    %edi,%ebx
80106da8:	75 dd                	jne    80106d87 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106daa:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106dad:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106db0:	5b                   	pop    %ebx
80106db1:	5e                   	pop    %esi
80106db2:	5f                   	pop    %edi
80106db3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106db4:	e9 c7 b6 ff ff       	jmp    80102480 <kfree>
    panic("freevm: no pgdir");
80106db9:	83 ec 0c             	sub    $0xc,%esp
80106dbc:	68 01 7a 10 80       	push   $0x80107a01
80106dc1:	e8 8a 96 ff ff       	call   80100450 <panic>
80106dc6:	8d 76 00             	lea    0x0(%esi),%esi
80106dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106dd0 <setupkvm>:
{
80106dd0:	55                   	push   %ebp
80106dd1:	89 e5                	mov    %esp,%ebp
80106dd3:	56                   	push   %esi
80106dd4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106dd5:	e8 56 b8 ff ff       	call   80102630 <kalloc>
80106dda:	85 c0                	test   %eax,%eax
80106ddc:	89 c6                	mov    %eax,%esi
80106dde:	74 42                	je     80106e22 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80106de0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106de3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106de8:	68 00 10 00 00       	push   $0x1000
80106ded:	6a 00                	push   $0x0
80106def:	50                   	push   %eax
80106df0:	e8 cb d7 ff ff       	call   801045c0 <memset>
80106df5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106df8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106dfb:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106dfe:	83 ec 08             	sub    $0x8,%esp
80106e01:	8b 13                	mov    (%ebx),%edx
80106e03:	ff 73 0c             	pushl  0xc(%ebx)
80106e06:	50                   	push   %eax
80106e07:	29 c1                	sub    %eax,%ecx
80106e09:	89 f0                	mov    %esi,%eax
80106e0b:	e8 b0 f9 ff ff       	call   801067c0 <mappages>
80106e10:	83 c4 10             	add    $0x10,%esp
80106e13:	85 c0                	test   %eax,%eax
80106e15:	78 19                	js     80106e30 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106e17:	83 c3 10             	add    $0x10,%ebx
80106e1a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106e20:	75 d6                	jne    80106df8 <setupkvm+0x28>
}
80106e22:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106e25:	89 f0                	mov    %esi,%eax
80106e27:	5b                   	pop    %ebx
80106e28:	5e                   	pop    %esi
80106e29:	5d                   	pop    %ebp
80106e2a:	c3                   	ret    
80106e2b:	90                   	nop
80106e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106e30:	83 ec 0c             	sub    $0xc,%esp
80106e33:	56                   	push   %esi
      return 0;
80106e34:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80106e36:	e8 15 ff ff ff       	call   80106d50 <freevm>
      return 0;
80106e3b:	83 c4 10             	add    $0x10,%esp
}
80106e3e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106e41:	89 f0                	mov    %esi,%eax
80106e43:	5b                   	pop    %ebx
80106e44:	5e                   	pop    %esi
80106e45:	5d                   	pop    %ebp
80106e46:	c3                   	ret    
80106e47:	89 f6                	mov    %esi,%esi
80106e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e50 <kvmalloc>:
{
80106e50:	55                   	push   %ebp
80106e51:	89 e5                	mov    %esp,%ebp
80106e53:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106e56:	e8 75 ff ff ff       	call   80106dd0 <setupkvm>
80106e5b:	a3 c4 55 11 80       	mov    %eax,0x801155c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106e60:	05 00 00 00 80       	add    $0x80000000,%eax
80106e65:	0f 22 d8             	mov    %eax,%cr3
}
80106e68:	c9                   	leave  
80106e69:	c3                   	ret    
80106e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106e70 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106e70:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106e71:	31 c9                	xor    %ecx,%ecx
{
80106e73:	89 e5                	mov    %esp,%ebp
80106e75:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106e78:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e7b:	8b 45 08             	mov    0x8(%ebp),%eax
80106e7e:	e8 bd f8 ff ff       	call   80106740 <walkpgdir>
  if(pte == 0)
80106e83:	85 c0                	test   %eax,%eax
80106e85:	74 05                	je     80106e8c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106e87:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106e8a:	c9                   	leave  
80106e8b:	c3                   	ret    
    panic("clearpteu");
80106e8c:	83 ec 0c             	sub    $0xc,%esp
80106e8f:	68 12 7a 10 80       	push   $0x80107a12
80106e94:	e8 b7 95 ff ff       	call   80100450 <panic>
80106e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ea0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106ea0:	55                   	push   %ebp
80106ea1:	89 e5                	mov    %esp,%ebp
80106ea3:	57                   	push   %edi
80106ea4:	56                   	push   %esi
80106ea5:	53                   	push   %ebx
80106ea6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106ea9:	e8 22 ff ff ff       	call   80106dd0 <setupkvm>
80106eae:	85 c0                	test   %eax,%eax
80106eb0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106eb3:	0f 84 9f 00 00 00    	je     80106f58 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106eb9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106ebc:	85 c9                	test   %ecx,%ecx
80106ebe:	0f 84 94 00 00 00    	je     80106f58 <copyuvm+0xb8>
80106ec4:	31 ff                	xor    %edi,%edi
80106ec6:	eb 4a                	jmp    80106f12 <copyuvm+0x72>
80106ec8:	90                   	nop
80106ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106ed0:	83 ec 04             	sub    $0x4,%esp
80106ed3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80106ed9:	68 00 10 00 00       	push   $0x1000
80106ede:	53                   	push   %ebx
80106edf:	50                   	push   %eax
80106ee0:	e8 8b d7 ff ff       	call   80104670 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106ee5:	58                   	pop    %eax
80106ee6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106eec:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106ef1:	5a                   	pop    %edx
80106ef2:	ff 75 e4             	pushl  -0x1c(%ebp)
80106ef5:	50                   	push   %eax
80106ef6:	89 fa                	mov    %edi,%edx
80106ef8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106efb:	e8 c0 f8 ff ff       	call   801067c0 <mappages>
80106f00:	83 c4 10             	add    $0x10,%esp
80106f03:	85 c0                	test   %eax,%eax
80106f05:	78 61                	js     80106f68 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80106f07:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106f0d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106f10:	76 46                	jbe    80106f58 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106f12:	8b 45 08             	mov    0x8(%ebp),%eax
80106f15:	31 c9                	xor    %ecx,%ecx
80106f17:	89 fa                	mov    %edi,%edx
80106f19:	e8 22 f8 ff ff       	call   80106740 <walkpgdir>
80106f1e:	85 c0                	test   %eax,%eax
80106f20:	74 61                	je     80106f83 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80106f22:	8b 00                	mov    (%eax),%eax
80106f24:	a8 01                	test   $0x1,%al
80106f26:	74 4e                	je     80106f76 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80106f28:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
80106f2a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
80106f2f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80106f35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80106f38:	e8 f3 b6 ff ff       	call   80102630 <kalloc>
80106f3d:	85 c0                	test   %eax,%eax
80106f3f:	89 c6                	mov    %eax,%esi
80106f41:	75 8d                	jne    80106ed0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80106f43:	83 ec 0c             	sub    $0xc,%esp
80106f46:	ff 75 e0             	pushl  -0x20(%ebp)
80106f49:	e8 02 fe ff ff       	call   80106d50 <freevm>
  return 0;
80106f4e:	83 c4 10             	add    $0x10,%esp
80106f51:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80106f58:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f5e:	5b                   	pop    %ebx
80106f5f:	5e                   	pop    %esi
80106f60:	5f                   	pop    %edi
80106f61:	5d                   	pop    %ebp
80106f62:	c3                   	ret    
80106f63:	90                   	nop
80106f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80106f68:	83 ec 0c             	sub    $0xc,%esp
80106f6b:	56                   	push   %esi
80106f6c:	e8 0f b5 ff ff       	call   80102480 <kfree>
      goto bad;
80106f71:	83 c4 10             	add    $0x10,%esp
80106f74:	eb cd                	jmp    80106f43 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80106f76:	83 ec 0c             	sub    $0xc,%esp
80106f79:	68 36 7a 10 80       	push   $0x80107a36
80106f7e:	e8 cd 94 ff ff       	call   80100450 <panic>
      panic("copyuvm: pte should exist");
80106f83:	83 ec 0c             	sub    $0xc,%esp
80106f86:	68 1c 7a 10 80       	push   $0x80107a1c
80106f8b:	e8 c0 94 ff ff       	call   80100450 <panic>

80106f90 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106f90:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106f91:	31 c9                	xor    %ecx,%ecx
{
80106f93:	89 e5                	mov    %esp,%ebp
80106f95:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106f98:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f9b:	8b 45 08             	mov    0x8(%ebp),%eax
80106f9e:	e8 9d f7 ff ff       	call   80106740 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106fa3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80106fa5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80106fa6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80106fa8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80106fad:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80106fb0:	05 00 00 00 80       	add    $0x80000000,%eax
80106fb5:	83 fa 05             	cmp    $0x5,%edx
80106fb8:	ba 00 00 00 00       	mov    $0x0,%edx
80106fbd:	0f 45 c2             	cmovne %edx,%eax
}
80106fc0:	c3                   	ret    
80106fc1:	eb 0d                	jmp    80106fd0 <copyout>
80106fc3:	90                   	nop
80106fc4:	90                   	nop
80106fc5:	90                   	nop
80106fc6:	90                   	nop
80106fc7:	90                   	nop
80106fc8:	90                   	nop
80106fc9:	90                   	nop
80106fca:	90                   	nop
80106fcb:	90                   	nop
80106fcc:	90                   	nop
80106fcd:	90                   	nop
80106fce:	90                   	nop
80106fcf:	90                   	nop

80106fd0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106fd0:	55                   	push   %ebp
80106fd1:	89 e5                	mov    %esp,%ebp
80106fd3:	57                   	push   %edi
80106fd4:	56                   	push   %esi
80106fd5:	53                   	push   %ebx
80106fd6:	83 ec 1c             	sub    $0x1c,%esp
80106fd9:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106fdc:	8b 55 0c             	mov    0xc(%ebp),%edx
80106fdf:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106fe2:	85 db                	test   %ebx,%ebx
80106fe4:	75 40                	jne    80107026 <copyout+0x56>
80106fe6:	eb 70                	jmp    80107058 <copyout+0x88>
80106fe8:	90                   	nop
80106fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106ff0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106ff3:	89 f1                	mov    %esi,%ecx
80106ff5:	29 d1                	sub    %edx,%ecx
80106ff7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80106ffd:	39 d9                	cmp    %ebx,%ecx
80106fff:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107002:	29 f2                	sub    %esi,%edx
80107004:	83 ec 04             	sub    $0x4,%esp
80107007:	01 d0                	add    %edx,%eax
80107009:	51                   	push   %ecx
8010700a:	57                   	push   %edi
8010700b:	50                   	push   %eax
8010700c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010700f:	e8 5c d6 ff ff       	call   80104670 <memmove>
    len -= n;
    buf += n;
80107014:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107017:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
8010701a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107020:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107022:	29 cb                	sub    %ecx,%ebx
80107024:	74 32                	je     80107058 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107026:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107028:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010702b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010702e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107034:	56                   	push   %esi
80107035:	ff 75 08             	pushl  0x8(%ebp)
80107038:	e8 53 ff ff ff       	call   80106f90 <uva2ka>
    if(pa0 == 0)
8010703d:	83 c4 10             	add    $0x10,%esp
80107040:	85 c0                	test   %eax,%eax
80107042:	75 ac                	jne    80106ff0 <copyout+0x20>
  }
  return 0;
}
80107044:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107047:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010704c:	5b                   	pop    %ebx
8010704d:	5e                   	pop    %esi
8010704e:	5f                   	pop    %edi
8010704f:	5d                   	pop    %ebp
80107050:	c3                   	ret    
80107051:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107058:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010705b:	31 c0                	xor    %eax,%eax
}
8010705d:	5b                   	pop    %ebx
8010705e:	5e                   	pop    %esi
8010705f:	5f                   	pop    %edi
80107060:	5d                   	pop    %ebp
80107061:	c3                   	ret    
