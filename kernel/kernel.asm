
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
80100028:	bc e0 b5 10 80       	mov    $0x8010b5e0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 30 30 10 80       	mov    $0x80103030,%eax
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
80100044:	bb 14 b6 10 80       	mov    $0x8010b614,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 a0 70 10 80       	push   $0x801070a0
80100051:	68 e0 b5 10 80       	push   $0x8010b5e0
80100056:	e8 35 43 00 00       	call   80104390 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 2c fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd2c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 30 fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd30
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba dc fc 10 80       	mov    $0x8010fcdc,%edx
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
8010008b:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 a7 70 10 80       	push   $0x801070a7
80100097:	50                   	push   %eax
80100098:	e8 c3 41 00 00       	call   80104260 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d dc fc 10 80       	cmp    $0x8010fcdc,%eax
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
801000df:	68 e0 b5 10 80       	push   $0x8010b5e0
801000e4:	e8 e7 43 00 00       	call   801044d0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 30 fd 10 80    	mov    0x8010fd30,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
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
80100120:	8b 1d 2c fd 10 80    	mov    0x8010fd2c,%ebx
80100126:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
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
8010015d:	68 e0 b5 10 80       	push   $0x8010b5e0
80100162:	e8 29 44 00 00       	call   80104590 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 2e 41 00 00       	call   801042a0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 2d 21 00 00       	call   801022b0 <iderw>
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
80100193:	68 ae 70 10 80       	push   $0x801070ae
80100198:	e8 c3 02 00 00       	call   80100460 <panic>
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
801001ae:	e8 8d 41 00 00       	call   80104340 <holdingsleep>
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
801001c4:	e9 e7 20 00 00       	jmp    801022b0 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 bf 70 10 80       	push   $0x801070bf
801001d1:	e8 8a 02 00 00       	call   80100460 <panic>
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
801001ef:	e8 4c 41 00 00       	call   80104340 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 fc 40 00 00       	call   80104300 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
8010020b:	e8 c0 42 00 00       	call   801044d0 <acquire>
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
80100232:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 e0 b5 10 80 	movl   $0x8010b5e0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 2f 43 00 00       	jmp    80104590 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 c6 70 10 80       	push   $0x801070c6
80100269:	e8 f2 01 00 00       	call   80100460 <panic>
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
80100280:	e8 2b 16 00 00       	call   801018b0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
8010028c:	e8 3f 42 00 00       	call   801044d0 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 c0 ff 10 80    	mov    0x8010ffc0,%edx
801002a7:	39 15 c4 ff 10 80    	cmp    %edx,0x8010ffc4
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
801002bb:	68 40 a5 10 80       	push   $0x8010a540
801002c0:	68 c0 ff 10 80       	push   $0x8010ffc0
801002c5:	e8 46 3c 00 00       	call   80103f10 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 c0 ff 10 80    	mov    0x8010ffc0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 c4 ff 10 80    	cmp    0x8010ffc4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 90 36 00 00       	call   80103970 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 40 a5 10 80       	push   $0x8010a540
801002ef:	e8 9c 42 00 00       	call   80104590 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 d4 14 00 00       	call   801017d0 <ilock>
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
80100313:	a3 c0 ff 10 80       	mov    %eax,0x8010ffc0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 40 ff 10 80 	movsbl -0x7fef00c0(%eax),%eax
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
80100348:	68 40 a5 10 80       	push   $0x8010a540
8010034d:	e8 3e 42 00 00       	call   80104590 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 76 14 00 00       	call   801017d0 <ilock>
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
80100372:	89 15 c0 ff 10 80    	mov    %edx,0x8010ffc0
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
  singleCharMode = 1;
80100391:	c7 05 20 a5 10 80 01 	movl   $0x1,0x8010a520
80100398:	00 00 00 
{
8010039b:	89 e5                	mov    %esp,%ebp
8010039d:	56                   	push   %esi
8010039e:	53                   	push   %ebx
8010039f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c = 1;
  iunlock(ip);
801003a2:	83 ec 0c             	sub    $0xc,%esp
801003a5:	53                   	push   %ebx
801003a6:	e8 05 15 00 00       	call   801018b0 <iunlock>
  acquire(&cons.lock);
801003ab:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
801003b2:	e8 19 41 00 00       	call   801044d0 <acquire>
  if(input.r == input.w){
801003b7:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801003bc:	83 c4 10             	add    $0x10,%esp
801003bf:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
801003c5:	74 39                	je     80100400 <consolesteal+0x70>
    singleCharMode = 1;
    sleep(&input.r, &cons.lock);
    singleCharMode = 0;
  }
  c = input.buf[input.r++ % INPUT_BUF];
  release(&cons.lock);
801003c7:	83 ec 0c             	sub    $0xc,%esp
  c = input.buf[input.r++ % INPUT_BUF];
801003ca:	8d 50 01             	lea    0x1(%eax),%edx
801003cd:	83 e0 7f             	and    $0x7f,%eax
  release(&cons.lock);
801003d0:	68 40 a5 10 80       	push   $0x8010a540
  c = input.buf[input.r++ % INPUT_BUF];
801003d5:	0f be b0 40 ff 10 80 	movsbl -0x7fef00c0(%eax),%esi
801003dc:	89 15 c0 ff 10 80    	mov    %edx,0x8010ffc0
  release(&cons.lock);
801003e2:	e8 a9 41 00 00       	call   80104590 <release>
  ilock(ip);
801003e7:	89 1c 24             	mov    %ebx,(%esp)
801003ea:	e8 e1 13 00 00       	call   801017d0 <ilock>
  return c;
801003ef:	83 c4 10             	add    $0x10,%esp
}
801003f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801003f5:	89 f0                	mov    %esi,%eax
801003f7:	5b                   	pop    %ebx
801003f8:	5e                   	pop    %esi
801003f9:	5d                   	pop    %ebp
801003fa:	c3                   	ret    
801003fb:	90                   	nop
801003fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
80100400:	e8 6b 35 00 00       	call   80103970 <myproc>
80100405:	8b 40 24             	mov    0x24(%eax),%eax
80100408:	85 c0                	test   %eax,%eax
8010040a:	75 30                	jne    8010043c <consolesteal+0xac>
    sleep(&input.r, &cons.lock);
8010040c:	83 ec 08             	sub    $0x8,%esp
    singleCharMode = 1;
8010040f:	c7 05 20 a5 10 80 01 	movl   $0x1,0x8010a520
80100416:	00 00 00 
    sleep(&input.r, &cons.lock);
80100419:	68 40 a5 10 80       	push   $0x8010a540
8010041e:	68 c0 ff 10 80       	push   $0x8010ffc0
80100423:	e8 e8 3a 00 00       	call   80103f10 <sleep>
    singleCharMode = 0;
80100428:	c7 05 20 a5 10 80 00 	movl   $0x0,0x8010a520
8010042f:	00 00 00 
80100432:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
80100437:	83 c4 10             	add    $0x10,%esp
8010043a:	eb 8b                	jmp    801003c7 <consolesteal+0x37>
      release(&cons.lock);
8010043c:	83 ec 0c             	sub    $0xc,%esp
      ilock(ip);
8010043f:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&cons.lock);
80100444:	68 40 a5 10 80       	push   $0x8010a540
80100449:	e8 42 41 00 00       	call   80104590 <release>
      ilock(ip);
8010044e:	89 1c 24             	mov    %ebx,(%esp)
80100451:	e8 7a 13 00 00       	call   801017d0 <ilock>
80100456:	83 c4 10             	add    $0x10,%esp
80100459:	eb 97                	jmp    801003f2 <consolesteal+0x62>
8010045b:	90                   	nop
8010045c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100460 <panic>:
{
80100460:	55                   	push   %ebp
80100461:	89 e5                	mov    %esp,%ebp
80100463:	56                   	push   %esi
80100464:	53                   	push   %ebx
80100465:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100468:	fa                   	cli    
  cons.locking = 0;
80100469:	c7 05 74 a5 10 80 00 	movl   $0x0,0x8010a574
80100470:	00 00 00 
  getcallerpcs(&s, pcs);
80100473:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100476:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100479:	e8 42 24 00 00       	call   801028c0 <lapicid>
8010047e:	83 ec 08             	sub    $0x8,%esp
80100481:	50                   	push   %eax
80100482:	68 cd 70 10 80       	push   $0x801070cd
80100487:	e8 a4 02 00 00       	call   80100730 <cprintf>
  cprintf(s);
8010048c:	58                   	pop    %eax
8010048d:	ff 75 08             	pushl  0x8(%ebp)
80100490:	e8 9b 02 00 00       	call   80100730 <cprintf>
  cprintf("\n");
80100495:	c7 04 24 1f 7a 10 80 	movl   $0x80107a1f,(%esp)
8010049c:	e8 8f 02 00 00       	call   80100730 <cprintf>
  getcallerpcs(&s, pcs);
801004a1:	5a                   	pop    %edx
801004a2:	8d 45 08             	lea    0x8(%ebp),%eax
801004a5:	59                   	pop    %ecx
801004a6:	53                   	push   %ebx
801004a7:	50                   	push   %eax
801004a8:	e8 03 3f 00 00       	call   801043b0 <getcallerpcs>
801004ad:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801004b0:	83 ec 08             	sub    $0x8,%esp
801004b3:	ff 33                	pushl  (%ebx)
801004b5:	83 c3 04             	add    $0x4,%ebx
801004b8:	68 e1 70 10 80       	push   $0x801070e1
801004bd:	e8 6e 02 00 00       	call   80100730 <cprintf>
  for(i=0; i<10; i++)
801004c2:	83 c4 10             	add    $0x10,%esp
801004c5:	39 f3                	cmp    %esi,%ebx
801004c7:	75 e7                	jne    801004b0 <panic+0x50>
  panicked = 1; // freeze other CPU
801004c9:	c7 05 78 a5 10 80 01 	movl   $0x1,0x8010a578
801004d0:	00 00 00 
801004d3:	eb fe                	jmp    801004d3 <panic+0x73>
801004d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801004d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801004e0 <consputc>:
  if(panicked){
801004e0:	8b 0d 78 a5 10 80    	mov    0x8010a578,%ecx
801004e6:	85 c9                	test   %ecx,%ecx
801004e8:	74 06                	je     801004f0 <consputc+0x10>
801004ea:	fa                   	cli    
801004eb:	eb fe                	jmp    801004eb <consputc+0xb>
801004ed:	8d 76 00             	lea    0x0(%esi),%esi
{
801004f0:	55                   	push   %ebp
801004f1:	89 e5                	mov    %esp,%ebp
801004f3:	57                   	push   %edi
801004f4:	56                   	push   %esi
801004f5:	53                   	push   %ebx
801004f6:	89 c6                	mov    %eax,%esi
801004f8:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
801004fb:	3d 00 01 00 00       	cmp    $0x100,%eax
80100500:	0f 84 b1 00 00 00    	je     801005b7 <consputc+0xd7>
    uartputc(c);
80100506:	83 ec 0c             	sub    $0xc,%esp
80100509:	50                   	push   %eax
8010050a:	e8 91 57 00 00       	call   80105ca0 <uartputc>
8010050f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100512:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100517:	b8 0e 00 00 00       	mov    $0xe,%eax
8010051c:	89 da                	mov    %ebx,%edx
8010051e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010051f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100524:	89 ca                	mov    %ecx,%edx
80100526:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100527:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010052a:	89 da                	mov    %ebx,%edx
8010052c:	c1 e0 08             	shl    $0x8,%eax
8010052f:	89 c7                	mov    %eax,%edi
80100531:	b8 0f 00 00 00       	mov    $0xf,%eax
80100536:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100537:	89 ca                	mov    %ecx,%edx
80100539:	ec                   	in     (%dx),%al
8010053a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010053d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010053f:	83 fe 0a             	cmp    $0xa,%esi
80100542:	0f 84 f3 00 00 00    	je     8010063b <consputc+0x15b>
  else if(c == BACKSPACE){
80100548:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010054e:	0f 84 d7 00 00 00    	je     8010062b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100554:	89 f0                	mov    %esi,%eax
80100556:	0f b6 c0             	movzbl %al,%eax
80100559:	80 cc 07             	or     $0x7,%ah
8010055c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100563:	80 
80100564:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100567:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010056d:	0f 8f ab 00 00 00    	jg     8010061e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
80100573:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
80100579:	7f 66                	jg     801005e1 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010057b:	be d4 03 00 00       	mov    $0x3d4,%esi
80100580:	b8 0e 00 00 00       	mov    $0xe,%eax
80100585:	89 f2                	mov    %esi,%edx
80100587:	ee                   	out    %al,(%dx)
80100588:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
8010058d:	89 d8                	mov    %ebx,%eax
8010058f:	c1 f8 08             	sar    $0x8,%eax
80100592:	89 ca                	mov    %ecx,%edx
80100594:	ee                   	out    %al,(%dx)
80100595:	b8 0f 00 00 00       	mov    $0xf,%eax
8010059a:	89 f2                	mov    %esi,%edx
8010059c:	ee                   	out    %al,(%dx)
8010059d:	89 d8                	mov    %ebx,%eax
8010059f:	89 ca                	mov    %ecx,%edx
801005a1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801005a2:	b8 20 07 00 00       	mov    $0x720,%eax
801005a7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801005ae:	80 
}
801005af:	8d 65 f4             	lea    -0xc(%ebp),%esp
801005b2:	5b                   	pop    %ebx
801005b3:	5e                   	pop    %esi
801005b4:	5f                   	pop    %edi
801005b5:	5d                   	pop    %ebp
801005b6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801005b7:	83 ec 0c             	sub    $0xc,%esp
801005ba:	6a 08                	push   $0x8
801005bc:	e8 df 56 00 00       	call   80105ca0 <uartputc>
801005c1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801005c8:	e8 d3 56 00 00       	call   80105ca0 <uartputc>
801005cd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801005d4:	e8 c7 56 00 00       	call   80105ca0 <uartputc>
801005d9:	83 c4 10             	add    $0x10,%esp
801005dc:	e9 31 ff ff ff       	jmp    80100512 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801005e1:	52                   	push   %edx
801005e2:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
801005e7:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801005ea:	68 a0 80 0b 80       	push   $0x800b80a0
801005ef:	68 00 80 0b 80       	push   $0x800b8000
801005f4:	e8 97 40 00 00       	call   80104690 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801005f9:	b8 80 07 00 00       	mov    $0x780,%eax
801005fe:	83 c4 0c             	add    $0xc,%esp
80100601:	29 d8                	sub    %ebx,%eax
80100603:	01 c0                	add    %eax,%eax
80100605:	50                   	push   %eax
80100606:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100609:	6a 00                	push   $0x0
8010060b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100610:	50                   	push   %eax
80100611:	e8 ca 3f 00 00       	call   801045e0 <memset>
80100616:	83 c4 10             	add    $0x10,%esp
80100619:	e9 5d ff ff ff       	jmp    8010057b <consputc+0x9b>
    panic("pos under/overflow");
8010061e:	83 ec 0c             	sub    $0xc,%esp
80100621:	68 e5 70 10 80       	push   $0x801070e5
80100626:	e8 35 fe ff ff       	call   80100460 <panic>
    if(pos > 0) --pos;
8010062b:	85 db                	test   %ebx,%ebx
8010062d:	0f 84 48 ff ff ff    	je     8010057b <consputc+0x9b>
80100633:	83 eb 01             	sub    $0x1,%ebx
80100636:	e9 2c ff ff ff       	jmp    80100567 <consputc+0x87>
    pos += 80 - pos%80;
8010063b:	89 d8                	mov    %ebx,%eax
8010063d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100642:	99                   	cltd   
80100643:	f7 f9                	idiv   %ecx
80100645:	29 d1                	sub    %edx,%ecx
80100647:	01 cb                	add    %ecx,%ebx
80100649:	e9 19 ff ff ff       	jmp    80100567 <consputc+0x87>
8010064e:	66 90                	xchg   %ax,%ax

80100650 <printint>:
{
80100650:	55                   	push   %ebp
80100651:	89 e5                	mov    %esp,%ebp
80100653:	57                   	push   %edi
80100654:	56                   	push   %esi
80100655:	53                   	push   %ebx
80100656:	89 d3                	mov    %edx,%ebx
80100658:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010065b:	85 c9                	test   %ecx,%ecx
{
8010065d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100660:	74 04                	je     80100666 <printint+0x16>
80100662:	85 c0                	test   %eax,%eax
80100664:	78 5a                	js     801006c0 <printint+0x70>
    x = xx;
80100666:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010066d:	31 c9                	xor    %ecx,%ecx
8010066f:	8d 75 d7             	lea    -0x29(%ebp),%esi
80100672:	eb 06                	jmp    8010067a <printint+0x2a>
80100674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
80100678:	89 f9                	mov    %edi,%ecx
8010067a:	31 d2                	xor    %edx,%edx
8010067c:	8d 79 01             	lea    0x1(%ecx),%edi
8010067f:	f7 f3                	div    %ebx
80100681:	0f b6 92 10 71 10 80 	movzbl -0x7fef8ef0(%edx),%edx
  }while((x /= base) != 0);
80100688:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
8010068a:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
8010068d:	75 e9                	jne    80100678 <printint+0x28>
  if(sign)
8010068f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100692:	85 c0                	test   %eax,%eax
80100694:	74 08                	je     8010069e <printint+0x4e>
    buf[i++] = '-';
80100696:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
8010069b:	8d 79 02             	lea    0x2(%ecx),%edi
8010069e:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801006a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801006a8:	0f be 03             	movsbl (%ebx),%eax
801006ab:	83 eb 01             	sub    $0x1,%ebx
801006ae:	e8 2d fe ff ff       	call   801004e0 <consputc>
  while(--i >= 0)
801006b3:	39 f3                	cmp    %esi,%ebx
801006b5:	75 f1                	jne    801006a8 <printint+0x58>
}
801006b7:	83 c4 2c             	add    $0x2c,%esp
801006ba:	5b                   	pop    %ebx
801006bb:	5e                   	pop    %esi
801006bc:	5f                   	pop    %edi
801006bd:	5d                   	pop    %ebp
801006be:	c3                   	ret    
801006bf:	90                   	nop
    x = -xx;
801006c0:	f7 d8                	neg    %eax
801006c2:	eb a9                	jmp    8010066d <printint+0x1d>
801006c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801006ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801006d0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801006d0:	55                   	push   %ebp
801006d1:	89 e5                	mov    %esp,%ebp
801006d3:	57                   	push   %edi
801006d4:	56                   	push   %esi
801006d5:	53                   	push   %ebx
801006d6:	83 ec 18             	sub    $0x18,%esp
801006d9:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801006dc:	ff 75 08             	pushl  0x8(%ebp)
801006df:	e8 cc 11 00 00       	call   801018b0 <iunlock>
  acquire(&cons.lock);
801006e4:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
801006eb:	e8 e0 3d 00 00       	call   801044d0 <acquire>
  for(i = 0; i < n; i++)
801006f0:	83 c4 10             	add    $0x10,%esp
801006f3:	85 f6                	test   %esi,%esi
801006f5:	7e 18                	jle    8010070f <consolewrite+0x3f>
801006f7:	8b 7d 0c             	mov    0xc(%ebp),%edi
801006fa:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
801006fd:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100700:	0f b6 07             	movzbl (%edi),%eax
80100703:	83 c7 01             	add    $0x1,%edi
80100706:	e8 d5 fd ff ff       	call   801004e0 <consputc>
  for(i = 0; i < n; i++)
8010070b:	39 fb                	cmp    %edi,%ebx
8010070d:	75 f1                	jne    80100700 <consolewrite+0x30>
  release(&cons.lock);
8010070f:	83 ec 0c             	sub    $0xc,%esp
80100712:	68 40 a5 10 80       	push   $0x8010a540
80100717:	e8 74 3e 00 00       	call   80104590 <release>
  ilock(ip);
8010071c:	58                   	pop    %eax
8010071d:	ff 75 08             	pushl  0x8(%ebp)
80100720:	e8 ab 10 00 00       	call   801017d0 <ilock>

  return n;
}
80100725:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100728:	89 f0                	mov    %esi,%eax
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop

80100730 <cprintf>:
{
80100730:	55                   	push   %ebp
80100731:	89 e5                	mov    %esp,%ebp
80100733:	57                   	push   %edi
80100734:	56                   	push   %esi
80100735:	53                   	push   %ebx
80100736:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100739:	a1 74 a5 10 80       	mov    0x8010a574,%eax
  if(locking)
8010073e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100740:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100743:	0f 85 6f 01 00 00    	jne    801008b8 <cprintf+0x188>
  if (fmt == 0)
80100749:	8b 45 08             	mov    0x8(%ebp),%eax
8010074c:	85 c0                	test   %eax,%eax
8010074e:	89 c7                	mov    %eax,%edi
80100750:	0f 84 77 01 00 00    	je     801008cd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100756:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100759:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010075c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010075e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100761:	85 c0                	test   %eax,%eax
80100763:	75 56                	jne    801007bb <cprintf+0x8b>
80100765:	eb 79                	jmp    801007e0 <cprintf+0xb0>
80100767:	89 f6                	mov    %esi,%esi
80100769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
80100770:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
80100773:	85 d2                	test   %edx,%edx
80100775:	74 69                	je     801007e0 <cprintf+0xb0>
80100777:	83 c3 02             	add    $0x2,%ebx
    switch(c){
8010077a:	83 fa 70             	cmp    $0x70,%edx
8010077d:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
80100780:	0f 84 84 00 00 00    	je     8010080a <cprintf+0xda>
80100786:	7f 78                	jg     80100800 <cprintf+0xd0>
80100788:	83 fa 25             	cmp    $0x25,%edx
8010078b:	0f 84 ff 00 00 00    	je     80100890 <cprintf+0x160>
80100791:	83 fa 64             	cmp    $0x64,%edx
80100794:	0f 85 8e 00 00 00    	jne    80100828 <cprintf+0xf8>
      printint(*argp++, 10, 1);
8010079a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010079d:	ba 0a 00 00 00       	mov    $0xa,%edx
801007a2:	8d 48 04             	lea    0x4(%eax),%ecx
801007a5:	8b 00                	mov    (%eax),%eax
801007a7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801007aa:	b9 01 00 00 00       	mov    $0x1,%ecx
801007af:	e8 9c fe ff ff       	call   80100650 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007b4:	0f b6 06             	movzbl (%esi),%eax
801007b7:	85 c0                	test   %eax,%eax
801007b9:	74 25                	je     801007e0 <cprintf+0xb0>
801007bb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801007be:	83 f8 25             	cmp    $0x25,%eax
801007c1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801007c4:	74 aa                	je     80100770 <cprintf+0x40>
801007c6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801007c9:	e8 12 fd ff ff       	call   801004e0 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007ce:	0f b6 06             	movzbl (%esi),%eax
      continue;
801007d1:	8b 55 e0             	mov    -0x20(%ebp),%edx
801007d4:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007d6:	85 c0                	test   %eax,%eax
801007d8:	75 e1                	jne    801007bb <cprintf+0x8b>
801007da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
801007e0:	8b 45 dc             	mov    -0x24(%ebp),%eax
801007e3:	85 c0                	test   %eax,%eax
801007e5:	74 10                	je     801007f7 <cprintf+0xc7>
    release(&cons.lock);
801007e7:	83 ec 0c             	sub    $0xc,%esp
801007ea:	68 40 a5 10 80       	push   $0x8010a540
801007ef:	e8 9c 3d 00 00       	call   80104590 <release>
801007f4:	83 c4 10             	add    $0x10,%esp
}
801007f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801007fa:	5b                   	pop    %ebx
801007fb:	5e                   	pop    %esi
801007fc:	5f                   	pop    %edi
801007fd:	5d                   	pop    %ebp
801007fe:	c3                   	ret    
801007ff:	90                   	nop
    switch(c){
80100800:	83 fa 73             	cmp    $0x73,%edx
80100803:	74 43                	je     80100848 <cprintf+0x118>
80100805:	83 fa 78             	cmp    $0x78,%edx
80100808:	75 1e                	jne    80100828 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010080a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010080d:	ba 10 00 00 00       	mov    $0x10,%edx
80100812:	8d 48 04             	lea    0x4(%eax),%ecx
80100815:	8b 00                	mov    (%eax),%eax
80100817:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010081a:	31 c9                	xor    %ecx,%ecx
8010081c:	e8 2f fe ff ff       	call   80100650 <printint>
      break;
80100821:	eb 91                	jmp    801007b4 <cprintf+0x84>
80100823:	90                   	nop
80100824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100828:	b8 25 00 00 00       	mov    $0x25,%eax
8010082d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100830:	e8 ab fc ff ff       	call   801004e0 <consputc>
      consputc(c);
80100835:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100838:	89 d0                	mov    %edx,%eax
8010083a:	e8 a1 fc ff ff       	call   801004e0 <consputc>
      break;
8010083f:	e9 70 ff ff ff       	jmp    801007b4 <cprintf+0x84>
80100844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100848:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010084b:	8b 10                	mov    (%eax),%edx
8010084d:	8d 48 04             	lea    0x4(%eax),%ecx
80100850:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100853:	85 d2                	test   %edx,%edx
80100855:	74 49                	je     801008a0 <cprintf+0x170>
      for(; *s; s++)
80100857:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010085a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010085d:	84 c0                	test   %al,%al
8010085f:	0f 84 4f ff ff ff    	je     801007b4 <cprintf+0x84>
80100865:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100868:	89 d3                	mov    %edx,%ebx
8010086a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100870:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
80100873:	e8 68 fc ff ff       	call   801004e0 <consputc>
      for(; *s; s++)
80100878:	0f be 03             	movsbl (%ebx),%eax
8010087b:	84 c0                	test   %al,%al
8010087d:	75 f1                	jne    80100870 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
8010087f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100882:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80100885:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100888:	e9 27 ff ff ff       	jmp    801007b4 <cprintf+0x84>
8010088d:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
80100890:	b8 25 00 00 00       	mov    $0x25,%eax
80100895:	e8 46 fc ff ff       	call   801004e0 <consputc>
      break;
8010089a:	e9 15 ff ff ff       	jmp    801007b4 <cprintf+0x84>
8010089f:	90                   	nop
        s = "(null)";
801008a0:	ba f8 70 10 80       	mov    $0x801070f8,%edx
      for(; *s; s++)
801008a5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801008a8:	b8 28 00 00 00       	mov    $0x28,%eax
801008ad:	89 d3                	mov    %edx,%ebx
801008af:	eb bf                	jmp    80100870 <cprintf+0x140>
801008b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801008b8:	83 ec 0c             	sub    $0xc,%esp
801008bb:	68 40 a5 10 80       	push   $0x8010a540
801008c0:	e8 0b 3c 00 00       	call   801044d0 <acquire>
801008c5:	83 c4 10             	add    $0x10,%esp
801008c8:	e9 7c fe ff ff       	jmp    80100749 <cprintf+0x19>
    panic("null fmt");
801008cd:	83 ec 0c             	sub    $0xc,%esp
801008d0:	68 ff 70 10 80       	push   $0x801070ff
801008d5:	e8 86 fb ff ff       	call   80100460 <panic>
801008da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801008e0 <consoleintr>:
{
801008e0:	55                   	push   %ebp
801008e1:	89 e5                	mov    %esp,%ebp
801008e3:	57                   	push   %edi
801008e4:	56                   	push   %esi
801008e5:	53                   	push   %ebx
  int c, doprocdump = 0;
801008e6:	31 f6                	xor    %esi,%esi
{
801008e8:	83 ec 18             	sub    $0x18,%esp
801008eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801008ee:	68 40 a5 10 80       	push   $0x8010a540
801008f3:	e8 d8 3b 00 00       	call   801044d0 <acquire>
  while((c = getc()) >= 0){
801008f8:	83 c4 10             	add    $0x10,%esp
801008fb:	90                   	nop
801008fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100900:	ff d3                	call   *%ebx
80100902:	85 c0                	test   %eax,%eax
80100904:	89 c7                	mov    %eax,%edi
80100906:	78 48                	js     80100950 <consoleintr+0x70>
    switch(c){
80100908:	83 ff 10             	cmp    $0x10,%edi
8010090b:	0f 84 f7 00 00 00    	je     80100a08 <consoleintr+0x128>
80100911:	7e 5d                	jle    80100970 <consoleintr+0x90>
80100913:	83 ff 15             	cmp    $0x15,%edi
80100916:	0f 84 fc 00 00 00    	je     80100a18 <consoleintr+0x138>
8010091c:	83 ff 7f             	cmp    $0x7f,%edi
8010091f:	75 54                	jne    80100975 <consoleintr+0x95>
      if(input.e != input.w){
80100921:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100926:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010092c:	74 d2                	je     80100900 <consoleintr+0x20>
        input.e--;
8010092e:	83 e8 01             	sub    $0x1,%eax
80100931:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100936:	b8 00 01 00 00       	mov    $0x100,%eax
8010093b:	e8 a0 fb ff ff       	call   801004e0 <consputc>
  while((c = getc()) >= 0){
80100940:	ff d3                	call   *%ebx
80100942:	85 c0                	test   %eax,%eax
80100944:	89 c7                	mov    %eax,%edi
80100946:	79 c0                	jns    80100908 <consoleintr+0x28>
80100948:	90                   	nop
80100949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100950:	83 ec 0c             	sub    $0xc,%esp
80100953:	68 40 a5 10 80       	push   $0x8010a540
80100958:	e8 33 3c 00 00       	call   80104590 <release>
  if(doprocdump) {
8010095d:	83 c4 10             	add    $0x10,%esp
80100960:	85 f6                	test   %esi,%esi
80100962:	0f 85 08 01 00 00    	jne    80100a70 <consoleintr+0x190>
}
80100968:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010096b:	5b                   	pop    %ebx
8010096c:	5e                   	pop    %esi
8010096d:	5f                   	pop    %edi
8010096e:	5d                   	pop    %ebp
8010096f:	c3                   	ret    
    switch(c){
80100970:	83 ff 08             	cmp    $0x8,%edi
80100973:	74 ac                	je     80100921 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100975:	85 ff                	test   %edi,%edi
80100977:	74 87                	je     80100900 <consoleintr+0x20>
80100979:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010097e:	89 c2                	mov    %eax,%edx
80100980:	2b 15 c0 ff 10 80    	sub    0x8010ffc0,%edx
80100986:	83 fa 7f             	cmp    $0x7f,%edx
80100989:	0f 87 71 ff ff ff    	ja     80100900 <consoleintr+0x20>
8010098f:	8d 50 01             	lea    0x1(%eax),%edx
80100992:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100995:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100998:	89 15 c8 ff 10 80    	mov    %edx,0x8010ffc8
        c = (c == '\r') ? '\n' : c;
8010099e:	0f 84 dc 00 00 00    	je     80100a80 <consoleintr+0x1a0>
        input.buf[input.e++ % INPUT_BUF] = c;
801009a4:	89 f9                	mov    %edi,%ecx
801009a6:	88 88 40 ff 10 80    	mov    %cl,-0x7fef00c0(%eax)
        consputc(c);
801009ac:	89 f8                	mov    %edi,%eax
801009ae:	e8 2d fb ff ff       	call   801004e0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009b3:	83 ff 0a             	cmp    $0xa,%edi
801009b6:	0f 84 d5 00 00 00    	je     80100a91 <consoleintr+0x1b1>
801009bc:	83 ff 04             	cmp    $0x4,%edi
801009bf:	0f 84 cc 00 00 00    	je     80100a91 <consoleintr+0x1b1>
801009c5:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801009ca:	8b 15 c8 ff 10 80    	mov    0x8010ffc8,%edx
801009d0:	83 e8 80             	sub    $0xffffff80,%eax
801009d3:	39 c2                	cmp    %eax,%edx
801009d5:	0f 84 bb 00 00 00    	je     80100a96 <consoleintr+0x1b6>
        else if(singleCharMode && c > 0) {
801009db:	a1 20 a5 10 80       	mov    0x8010a520,%eax
801009e0:	85 c0                	test   %eax,%eax
801009e2:	0f 84 18 ff ff ff    	je     80100900 <consoleintr+0x20>
          wakeup(&input.r);
801009e8:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
801009eb:	89 15 c4 ff 10 80    	mov    %edx,0x8010ffc4
          wakeup(&input.r);
801009f1:	68 c0 ff 10 80       	push   $0x8010ffc0
801009f6:	e8 c5 36 00 00       	call   801040c0 <wakeup>
801009fb:	83 c4 10             	add    $0x10,%esp
801009fe:	e9 fd fe ff ff       	jmp    80100900 <consoleintr+0x20>
80100a03:	90                   	nop
80100a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100a08:	be 01 00 00 00       	mov    $0x1,%esi
80100a0d:	e9 ee fe ff ff       	jmp    80100900 <consoleintr+0x20>
80100a12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100a18:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100a1d:	39 05 c4 ff 10 80    	cmp    %eax,0x8010ffc4
80100a23:	75 2b                	jne    80100a50 <consoleintr+0x170>
80100a25:	e9 d6 fe ff ff       	jmp    80100900 <consoleintr+0x20>
80100a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100a30:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100a35:	b8 00 01 00 00       	mov    $0x100,%eax
80100a3a:	e8 a1 fa ff ff       	call   801004e0 <consputc>
      while(input.e != input.w &&
80100a3f:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100a44:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
80100a4a:	0f 84 b0 fe ff ff    	je     80100900 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100a50:	83 e8 01             	sub    $0x1,%eax
80100a53:	89 c2                	mov    %eax,%edx
80100a55:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100a58:	80 ba 40 ff 10 80 0a 	cmpb   $0xa,-0x7fef00c0(%edx)
80100a5f:	75 cf                	jne    80100a30 <consoleintr+0x150>
80100a61:	e9 9a fe ff ff       	jmp    80100900 <consoleintr+0x20>
80100a66:	8d 76 00             	lea    0x0(%esi),%esi
80100a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100a70:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a73:	5b                   	pop    %ebx
80100a74:	5e                   	pop    %esi
80100a75:	5f                   	pop    %edi
80100a76:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a77:	e9 24 37 00 00       	jmp    801041a0 <procdump>
80100a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
80100a80:	c6 80 40 ff 10 80 0a 	movb   $0xa,-0x7fef00c0(%eax)
        consputc(c);
80100a87:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a8c:	e8 4f fa ff ff       	call   801004e0 <consputc>
80100a91:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
          wakeup(&input.r);
80100a96:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a99:	a3 c4 ff 10 80       	mov    %eax,0x8010ffc4
          wakeup(&input.r);
80100a9e:	68 c0 ff 10 80       	push   $0x8010ffc0
80100aa3:	e8 18 36 00 00       	call   801040c0 <wakeup>
80100aa8:	83 c4 10             	add    $0x10,%esp
80100aab:	e9 50 fe ff ff       	jmp    80100900 <consoleintr+0x20>

80100ab0 <consoleinit>:

void
consoleinit(void)
{
80100ab0:	55                   	push   %ebp
80100ab1:	89 e5                	mov    %esp,%ebp
80100ab3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100ab6:	68 08 71 10 80       	push   $0x80107108
80100abb:	68 40 a5 10 80       	push   $0x8010a540
80100ac0:	e8 cb 38 00 00       	call   80104390 <initlock>
  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  devsw[CONSOLE].steal = consolesteal;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100ac5:	58                   	pop    %eax
80100ac6:	5a                   	pop    %edx
80100ac7:	6a 00                	push   $0x0
80100ac9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100acb:	c7 05 94 09 11 80 d0 	movl   $0x801006d0,0x80110994
80100ad2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100ad5:	c7 05 8c 09 11 80 70 	movl   $0x80100270,0x8011098c
80100adc:	02 10 80 
  devsw[CONSOLE].steal = consolesteal;
80100adf:	c7 05 90 09 11 80 90 	movl   $0x80100390,0x80110990
80100ae6:	03 10 80 
  cons.locking = 1;
80100ae9:	c7 05 74 a5 10 80 01 	movl   $0x1,0x8010a574
80100af0:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100af3:	e8 68 19 00 00       	call   80102460 <ioapicenable>
}
80100af8:	83 c4 10             	add    $0x10,%esp
80100afb:	c9                   	leave  
80100afc:	c3                   	ret    
80100afd:	66 90                	xchg   %ax,%ax
80100aff:	90                   	nop

80100b00 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100b00:	55                   	push   %ebp
80100b01:	89 e5                	mov    %esp,%ebp
80100b03:	57                   	push   %edi
80100b04:	56                   	push   %esi
80100b05:	53                   	push   %ebx
80100b06:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100b0c:	e8 5f 2e 00 00       	call   80103970 <myproc>
80100b11:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100b17:	e8 14 22 00 00       	call   80102d30 <begin_op>

  if((ip = namei(path)) == 0){
80100b1c:	83 ec 0c             	sub    $0xc,%esp
80100b1f:	ff 75 08             	pushl  0x8(%ebp)
80100b22:	e8 49 15 00 00       	call   80102070 <namei>
80100b27:	83 c4 10             	add    $0x10,%esp
80100b2a:	85 c0                	test   %eax,%eax
80100b2c:	0f 84 91 01 00 00    	je     80100cc3 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100b32:	83 ec 0c             	sub    $0xc,%esp
80100b35:	89 c3                	mov    %eax,%ebx
80100b37:	50                   	push   %eax
80100b38:	e8 93 0c 00 00       	call   801017d0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100b3d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100b43:	6a 34                	push   $0x34
80100b45:	6a 00                	push   $0x0
80100b47:	50                   	push   %eax
80100b48:	53                   	push   %ebx
80100b49:	e8 62 0f 00 00       	call   80101ab0 <readi>
80100b4e:	83 c4 20             	add    $0x20,%esp
80100b51:	83 f8 34             	cmp    $0x34,%eax
80100b54:	74 22                	je     80100b78 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100b56:	83 ec 0c             	sub    $0xc,%esp
80100b59:	53                   	push   %ebx
80100b5a:	e8 01 0f 00 00       	call   80101a60 <iunlockput>
    end_op();
80100b5f:	e8 3c 22 00 00       	call   80102da0 <end_op>
80100b64:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100b67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100b6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b6f:	5b                   	pop    %ebx
80100b70:	5e                   	pop    %esi
80100b71:	5f                   	pop    %edi
80100b72:	5d                   	pop    %ebp
80100b73:	c3                   	ret    
80100b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100b78:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b7f:	45 4c 46 
80100b82:	75 d2                	jne    80100b56 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100b84:	e8 67 62 00 00       	call   80106df0 <setupkvm>
80100b89:	85 c0                	test   %eax,%eax
80100b8b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b91:	74 c3                	je     80100b56 <exec+0x56>
  sz = 0;
80100b93:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b95:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b9c:	00 
80100b9d:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100ba3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100ba9:	0f 84 8c 02 00 00    	je     80100e3b <exec+0x33b>
80100baf:	31 f6                	xor    %esi,%esi
80100bb1:	eb 7f                	jmp    80100c32 <exec+0x132>
80100bb3:	90                   	nop
80100bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100bb8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100bbf:	75 63                	jne    80100c24 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100bc1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100bc7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100bcd:	0f 82 86 00 00 00    	jb     80100c59 <exec+0x159>
80100bd3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100bd9:	72 7e                	jb     80100c59 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100bdb:	83 ec 04             	sub    $0x4,%esp
80100bde:	50                   	push   %eax
80100bdf:	57                   	push   %edi
80100be0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100be6:	e8 25 60 00 00       	call   80106c10 <allocuvm>
80100beb:	83 c4 10             	add    $0x10,%esp
80100bee:	85 c0                	test   %eax,%eax
80100bf0:	89 c7                	mov    %eax,%edi
80100bf2:	74 65                	je     80100c59 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100bf4:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bfa:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bff:	75 58                	jne    80100c59 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c01:	83 ec 0c             	sub    $0xc,%esp
80100c04:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100c0a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100c10:	53                   	push   %ebx
80100c11:	50                   	push   %eax
80100c12:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c18:	e8 33 5f 00 00       	call   80106b50 <loaduvm>
80100c1d:	83 c4 20             	add    $0x20,%esp
80100c20:	85 c0                	test   %eax,%eax
80100c22:	78 35                	js     80100c59 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c24:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100c2b:	83 c6 01             	add    $0x1,%esi
80100c2e:	39 f0                	cmp    %esi,%eax
80100c30:	7e 3d                	jle    80100c6f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c32:	89 f0                	mov    %esi,%eax
80100c34:	6a 20                	push   $0x20
80100c36:	c1 e0 05             	shl    $0x5,%eax
80100c39:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100c3f:	50                   	push   %eax
80100c40:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100c46:	50                   	push   %eax
80100c47:	53                   	push   %ebx
80100c48:	e8 63 0e 00 00       	call   80101ab0 <readi>
80100c4d:	83 c4 10             	add    $0x10,%esp
80100c50:	83 f8 20             	cmp    $0x20,%eax
80100c53:	0f 84 5f ff ff ff    	je     80100bb8 <exec+0xb8>
    freevm(pgdir);
80100c59:	83 ec 0c             	sub    $0xc,%esp
80100c5c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c62:	e8 09 61 00 00       	call   80106d70 <freevm>
80100c67:	83 c4 10             	add    $0x10,%esp
80100c6a:	e9 e7 fe ff ff       	jmp    80100b56 <exec+0x56>
80100c6f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100c75:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100c7b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100c81:	83 ec 0c             	sub    $0xc,%esp
80100c84:	53                   	push   %ebx
80100c85:	e8 d6 0d 00 00       	call   80101a60 <iunlockput>
  end_op();
80100c8a:	e8 11 21 00 00       	call   80102da0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c8f:	83 c4 0c             	add    $0xc,%esp
80100c92:	56                   	push   %esi
80100c93:	57                   	push   %edi
80100c94:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c9a:	e8 71 5f 00 00       	call   80106c10 <allocuvm>
80100c9f:	83 c4 10             	add    $0x10,%esp
80100ca2:	85 c0                	test   %eax,%eax
80100ca4:	89 c6                	mov    %eax,%esi
80100ca6:	75 3a                	jne    80100ce2 <exec+0x1e2>
    freevm(pgdir);
80100ca8:	83 ec 0c             	sub    $0xc,%esp
80100cab:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100cb1:	e8 ba 60 00 00       	call   80106d70 <freevm>
80100cb6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100cb9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100cbe:	e9 a9 fe ff ff       	jmp    80100b6c <exec+0x6c>
    end_op();
80100cc3:	e8 d8 20 00 00       	call   80102da0 <end_op>
    cprintf("exec: fail\n");
80100cc8:	83 ec 0c             	sub    $0xc,%esp
80100ccb:	68 21 71 10 80       	push   $0x80107121
80100cd0:	e8 5b fa ff ff       	call   80100730 <cprintf>
    return -1;
80100cd5:	83 c4 10             	add    $0x10,%esp
80100cd8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100cdd:	e9 8a fe ff ff       	jmp    80100b6c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100ce2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100ce8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100ceb:	31 ff                	xor    %edi,%edi
80100ced:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cef:	50                   	push   %eax
80100cf0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100cf6:	e8 95 61 00 00       	call   80106e90 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100cfb:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cfe:	83 c4 10             	add    $0x10,%esp
80100d01:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100d07:	8b 00                	mov    (%eax),%eax
80100d09:	85 c0                	test   %eax,%eax
80100d0b:	74 70                	je     80100d7d <exec+0x27d>
80100d0d:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100d13:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100d19:	eb 0a                	jmp    80100d25 <exec+0x225>
80100d1b:	90                   	nop
80100d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100d20:	83 ff 20             	cmp    $0x20,%edi
80100d23:	74 83                	je     80100ca8 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d25:	83 ec 0c             	sub    $0xc,%esp
80100d28:	50                   	push   %eax
80100d29:	e8 d2 3a 00 00       	call   80104800 <strlen>
80100d2e:	f7 d0                	not    %eax
80100d30:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d32:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d35:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d36:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d39:	ff 34 b8             	pushl  (%eax,%edi,4)
80100d3c:	e8 bf 3a 00 00       	call   80104800 <strlen>
80100d41:	83 c0 01             	add    $0x1,%eax
80100d44:	50                   	push   %eax
80100d45:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d48:	ff 34 b8             	pushl  (%eax,%edi,4)
80100d4b:	53                   	push   %ebx
80100d4c:	56                   	push   %esi
80100d4d:	e8 9e 62 00 00       	call   80106ff0 <copyout>
80100d52:	83 c4 20             	add    $0x20,%esp
80100d55:	85 c0                	test   %eax,%eax
80100d57:	0f 88 4b ff ff ff    	js     80100ca8 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100d5d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100d60:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100d67:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100d6a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100d70:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100d73:	85 c0                	test   %eax,%eax
80100d75:	75 a9                	jne    80100d20 <exec+0x220>
80100d77:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d7d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100d84:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100d86:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100d8d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100d91:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d98:	ff ff ff 
  ustack[1] = argc;
80100d9b:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100da1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100da3:	83 c0 0c             	add    $0xc,%eax
80100da6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100da8:	50                   	push   %eax
80100da9:	52                   	push   %edx
80100daa:	53                   	push   %ebx
80100dab:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100db1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100db7:	e8 34 62 00 00       	call   80106ff0 <copyout>
80100dbc:	83 c4 10             	add    $0x10,%esp
80100dbf:	85 c0                	test   %eax,%eax
80100dc1:	0f 88 e1 fe ff ff    	js     80100ca8 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100dc7:	8b 45 08             	mov    0x8(%ebp),%eax
80100dca:	0f b6 00             	movzbl (%eax),%eax
80100dcd:	84 c0                	test   %al,%al
80100dcf:	74 17                	je     80100de8 <exec+0x2e8>
80100dd1:	8b 55 08             	mov    0x8(%ebp),%edx
80100dd4:	89 d1                	mov    %edx,%ecx
80100dd6:	83 c1 01             	add    $0x1,%ecx
80100dd9:	3c 2f                	cmp    $0x2f,%al
80100ddb:	0f b6 01             	movzbl (%ecx),%eax
80100dde:	0f 44 d1             	cmove  %ecx,%edx
80100de1:	84 c0                	test   %al,%al
80100de3:	75 f1                	jne    80100dd6 <exec+0x2d6>
80100de5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100de8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100dee:	50                   	push   %eax
80100def:	6a 10                	push   $0x10
80100df1:	ff 75 08             	pushl  0x8(%ebp)
80100df4:	89 f8                	mov    %edi,%eax
80100df6:	83 c0 70             	add    $0x70,%eax
80100df9:	50                   	push   %eax
80100dfa:	e8 c1 39 00 00       	call   801047c0 <safestrcpy>
  curproc->pgdir = pgdir;
80100dff:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100e05:	89 f9                	mov    %edi,%ecx
80100e07:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80100e0a:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->sz = sz;
80100e0d:	89 31                	mov    %esi,(%ecx)
  curproc->pgdir = pgdir;
80100e0f:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100e12:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100e18:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100e1b:	8b 41 18             	mov    0x18(%ecx),%eax
80100e1e:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100e21:	89 0c 24             	mov    %ecx,(%esp)
80100e24:	e8 97 5b 00 00       	call   801069c0 <switchuvm>
  freevm(oldpgdir);
80100e29:	89 3c 24             	mov    %edi,(%esp)
80100e2c:	e8 3f 5f 00 00       	call   80106d70 <freevm>
  return 0;
80100e31:	83 c4 10             	add    $0x10,%esp
80100e34:	31 c0                	xor    %eax,%eax
80100e36:	e9 31 fd ff ff       	jmp    80100b6c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e3b:	be 00 20 00 00       	mov    $0x2000,%esi
80100e40:	e9 3c fe ff ff       	jmp    80100c81 <exec+0x181>
80100e45:	66 90                	xchg   %ax,%ax
80100e47:	66 90                	xchg   %ax,%ax
80100e49:	66 90                	xchg   %ax,%ax
80100e4b:	66 90                	xchg   %ax,%ax
80100e4d:	66 90                	xchg   %ax,%ax
80100e4f:	90                   	nop

80100e50 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e50:	55                   	push   %ebp
80100e51:	89 e5                	mov    %esp,%ebp
80100e53:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100e56:	68 2d 71 10 80       	push   $0x8010712d
80100e5b:	68 e0 ff 10 80       	push   $0x8010ffe0
80100e60:	e8 2b 35 00 00       	call   80104390 <initlock>
}
80100e65:	83 c4 10             	add    $0x10,%esp
80100e68:	c9                   	leave  
80100e69:	c3                   	ret    
80100e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e70 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e70:	55                   	push   %ebp
80100e71:	89 e5                	mov    %esp,%ebp
80100e73:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e74:	bb 14 00 11 80       	mov    $0x80110014,%ebx
{
80100e79:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e7c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100e81:	e8 4a 36 00 00       	call   801044d0 <acquire>
80100e86:	83 c4 10             	add    $0x10,%esp
80100e89:	eb 10                	jmp    80100e9b <filealloc+0x2b>
80100e8b:	90                   	nop
80100e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e90:	83 c3 18             	add    $0x18,%ebx
80100e93:	81 fb 74 09 11 80    	cmp    $0x80110974,%ebx
80100e99:	73 25                	jae    80100ec0 <filealloc+0x50>
    if(f->ref == 0){
80100e9b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e9e:	85 c0                	test   %eax,%eax
80100ea0:	75 ee                	jne    80100e90 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100ea2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100ea5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100eac:	68 e0 ff 10 80       	push   $0x8010ffe0
80100eb1:	e8 da 36 00 00       	call   80104590 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100eb6:	89 d8                	mov    %ebx,%eax
      return f;
80100eb8:	83 c4 10             	add    $0x10,%esp
}
80100ebb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ebe:	c9                   	leave  
80100ebf:	c3                   	ret    
  release(&ftable.lock);
80100ec0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100ec3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100ec5:	68 e0 ff 10 80       	push   $0x8010ffe0
80100eca:	e8 c1 36 00 00       	call   80104590 <release>
}
80100ecf:	89 d8                	mov    %ebx,%eax
  return 0;
80100ed1:	83 c4 10             	add    $0x10,%esp
}
80100ed4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ed7:	c9                   	leave  
80100ed8:	c3                   	ret    
80100ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ee0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100ee0:	55                   	push   %ebp
80100ee1:	89 e5                	mov    %esp,%ebp
80100ee3:	53                   	push   %ebx
80100ee4:	83 ec 10             	sub    $0x10,%esp
80100ee7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100eea:	68 e0 ff 10 80       	push   $0x8010ffe0
80100eef:	e8 dc 35 00 00       	call   801044d0 <acquire>
  if(f->ref < 1)
80100ef4:	8b 43 04             	mov    0x4(%ebx),%eax
80100ef7:	83 c4 10             	add    $0x10,%esp
80100efa:	85 c0                	test   %eax,%eax
80100efc:	7e 1a                	jle    80100f18 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100efe:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100f01:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100f04:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100f07:	68 e0 ff 10 80       	push   $0x8010ffe0
80100f0c:	e8 7f 36 00 00       	call   80104590 <release>
  return f;
}
80100f11:	89 d8                	mov    %ebx,%eax
80100f13:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f16:	c9                   	leave  
80100f17:	c3                   	ret    
    panic("filedup");
80100f18:	83 ec 0c             	sub    $0xc,%esp
80100f1b:	68 34 71 10 80       	push   $0x80107134
80100f20:	e8 3b f5 ff ff       	call   80100460 <panic>
80100f25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f30 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f30:	55                   	push   %ebp
80100f31:	89 e5                	mov    %esp,%ebp
80100f33:	57                   	push   %edi
80100f34:	56                   	push   %esi
80100f35:	53                   	push   %ebx
80100f36:	83 ec 28             	sub    $0x28,%esp
80100f39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100f3c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100f41:	e8 8a 35 00 00       	call   801044d0 <acquire>
  if(f->ref < 1)
80100f46:	8b 43 04             	mov    0x4(%ebx),%eax
80100f49:	83 c4 10             	add    $0x10,%esp
80100f4c:	85 c0                	test   %eax,%eax
80100f4e:	0f 8e 9b 00 00 00    	jle    80100fef <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100f54:	83 e8 01             	sub    $0x1,%eax
80100f57:	85 c0                	test   %eax,%eax
80100f59:	89 43 04             	mov    %eax,0x4(%ebx)
80100f5c:	74 1a                	je     80100f78 <fileclose+0x48>
    release(&ftable.lock);
80100f5e:	c7 45 08 e0 ff 10 80 	movl   $0x8010ffe0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f68:	5b                   	pop    %ebx
80100f69:	5e                   	pop    %esi
80100f6a:	5f                   	pop    %edi
80100f6b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f6c:	e9 1f 36 00 00       	jmp    80104590 <release>
80100f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100f78:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100f7c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100f7e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f81:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100f84:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f8a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f8d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100f90:	68 e0 ff 10 80       	push   $0x8010ffe0
  ff = *f;
80100f95:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f98:	e8 f3 35 00 00       	call   80104590 <release>
  if(ff.type == FD_PIPE)
80100f9d:	83 c4 10             	add    $0x10,%esp
80100fa0:	83 ff 01             	cmp    $0x1,%edi
80100fa3:	74 13                	je     80100fb8 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100fa5:	83 ff 02             	cmp    $0x2,%edi
80100fa8:	74 26                	je     80100fd0 <fileclose+0xa0>
}
80100faa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fad:	5b                   	pop    %ebx
80100fae:	5e                   	pop    %esi
80100faf:	5f                   	pop    %edi
80100fb0:	5d                   	pop    %ebp
80100fb1:	c3                   	ret    
80100fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100fb8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100fbc:	83 ec 08             	sub    $0x8,%esp
80100fbf:	53                   	push   %ebx
80100fc0:	56                   	push   %esi
80100fc1:	e8 1a 25 00 00       	call   801034e0 <pipeclose>
80100fc6:	83 c4 10             	add    $0x10,%esp
80100fc9:	eb df                	jmp    80100faa <fileclose+0x7a>
80100fcb:	90                   	nop
80100fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100fd0:	e8 5b 1d 00 00       	call   80102d30 <begin_op>
    iput(ff.ip);
80100fd5:	83 ec 0c             	sub    $0xc,%esp
80100fd8:	ff 75 e0             	pushl  -0x20(%ebp)
80100fdb:	e8 20 09 00 00       	call   80101900 <iput>
    end_op();
80100fe0:	83 c4 10             	add    $0x10,%esp
}
80100fe3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fe6:	5b                   	pop    %ebx
80100fe7:	5e                   	pop    %esi
80100fe8:	5f                   	pop    %edi
80100fe9:	5d                   	pop    %ebp
    end_op();
80100fea:	e9 b1 1d 00 00       	jmp    80102da0 <end_op>
    panic("fileclose");
80100fef:	83 ec 0c             	sub    $0xc,%esp
80100ff2:	68 3c 71 10 80       	push   $0x8010713c
80100ff7:	e8 64 f4 ff ff       	call   80100460 <panic>
80100ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101000 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101000:	55                   	push   %ebp
80101001:	89 e5                	mov    %esp,%ebp
80101003:	53                   	push   %ebx
80101004:	83 ec 04             	sub    $0x4,%esp
80101007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010100a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010100d:	75 31                	jne    80101040 <filestat+0x40>
    ilock(f->ip);
8010100f:	83 ec 0c             	sub    $0xc,%esp
80101012:	ff 73 10             	pushl  0x10(%ebx)
80101015:	e8 b6 07 00 00       	call   801017d0 <ilock>
    stati(f->ip, st);
8010101a:	58                   	pop    %eax
8010101b:	5a                   	pop    %edx
8010101c:	ff 75 0c             	pushl  0xc(%ebp)
8010101f:	ff 73 10             	pushl  0x10(%ebx)
80101022:	e8 59 0a 00 00       	call   80101a80 <stati>
    iunlock(f->ip);
80101027:	59                   	pop    %ecx
80101028:	ff 73 10             	pushl  0x10(%ebx)
8010102b:	e8 80 08 00 00       	call   801018b0 <iunlock>
    return 0;
80101030:	83 c4 10             	add    $0x10,%esp
80101033:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80101035:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101038:	c9                   	leave  
80101039:	c3                   	ret    
8010103a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80101040:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101045:	eb ee                	jmp    80101035 <filestat+0x35>
80101047:	89 f6                	mov    %esi,%esi
80101049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101050 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101050:	55                   	push   %ebp
80101051:	89 e5                	mov    %esp,%ebp
80101053:	57                   	push   %edi
80101054:	56                   	push   %esi
80101055:	53                   	push   %ebx
80101056:	83 ec 0c             	sub    $0xc,%esp
80101059:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010105c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010105f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101062:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101066:	74 60                	je     801010c8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101068:	8b 03                	mov    (%ebx),%eax
8010106a:	83 f8 01             	cmp    $0x1,%eax
8010106d:	74 41                	je     801010b0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010106f:	83 f8 02             	cmp    $0x2,%eax
80101072:	75 5b                	jne    801010cf <fileread+0x7f>
    ilock(f->ip);
80101074:	83 ec 0c             	sub    $0xc,%esp
80101077:	ff 73 10             	pushl  0x10(%ebx)
8010107a:	e8 51 07 00 00       	call   801017d0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010107f:	57                   	push   %edi
80101080:	ff 73 14             	pushl  0x14(%ebx)
80101083:	56                   	push   %esi
80101084:	ff 73 10             	pushl  0x10(%ebx)
80101087:	e8 24 0a 00 00       	call   80101ab0 <readi>
8010108c:	83 c4 20             	add    $0x20,%esp
8010108f:	85 c0                	test   %eax,%eax
80101091:	89 c6                	mov    %eax,%esi
80101093:	7e 03                	jle    80101098 <fileread+0x48>
      f->off += r;
80101095:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101098:	83 ec 0c             	sub    $0xc,%esp
8010109b:	ff 73 10             	pushl  0x10(%ebx)
8010109e:	e8 0d 08 00 00       	call   801018b0 <iunlock>
    return r;
801010a3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
801010a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010a9:	89 f0                	mov    %esi,%eax
801010ab:	5b                   	pop    %ebx
801010ac:	5e                   	pop    %esi
801010ad:	5f                   	pop    %edi
801010ae:	5d                   	pop    %ebp
801010af:	c3                   	ret    
    return piperead(f->pipe, addr, n);
801010b0:	8b 43 0c             	mov    0xc(%ebx),%eax
801010b3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010b9:	5b                   	pop    %ebx
801010ba:	5e                   	pop    %esi
801010bb:	5f                   	pop    %edi
801010bc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
801010bd:	e9 ce 25 00 00       	jmp    80103690 <piperead>
801010c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801010c8:	be ff ff ff ff       	mov    $0xffffffff,%esi
801010cd:	eb d7                	jmp    801010a6 <fileread+0x56>
  panic("fileread");
801010cf:	83 ec 0c             	sub    $0xc,%esp
801010d2:	68 46 71 10 80       	push   $0x80107146
801010d7:	e8 84 f3 ff ff       	call   80100460 <panic>
801010dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801010e0 <filesteal>:

// used to read a single character from console
int
filesteal(struct file *f)
{
801010e0:	55                   	push   %ebp
801010e1:	89 e5                	mov    %esp,%ebp
801010e3:	56                   	push   %esi
801010e4:	53                   	push   %ebx
801010e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;

  if(f->readable == 0)
801010e8:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801010ec:	74 32                	je     80101120 <filesteal+0x40>
    return -1;
  if(f->type == FD_INODE){
801010ee:	83 3b 02             	cmpl   $0x2,(%ebx)
801010f1:	75 34                	jne    80101127 <filesteal+0x47>
    ilock(f->ip);
801010f3:	83 ec 0c             	sub    $0xc,%esp
801010f6:	ff 73 10             	pushl  0x10(%ebx)
801010f9:	e8 d2 06 00 00       	call   801017d0 <ilock>
    r = steali(f->ip);
801010fe:	58                   	pop    %eax
801010ff:	ff 73 10             	pushl  0x10(%ebx)
80101102:	e8 a9 0a 00 00       	call   80101bb0 <steali>
    iunlock(f->ip);
80101107:	5a                   	pop    %edx
80101108:	ff 73 10             	pushl  0x10(%ebx)
    r = steali(f->ip);
8010110b:	89 c6                	mov    %eax,%esi
    iunlock(f->ip);
8010110d:	e8 9e 07 00 00       	call   801018b0 <iunlock>
    return r;
80101112:	83 c4 10             	add    $0x10,%esp
  }
  panic("filesteal");
}
80101115:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101118:	89 f0                	mov    %esi,%eax
8010111a:	5b                   	pop    %ebx
8010111b:	5e                   	pop    %esi
8010111c:	5d                   	pop    %ebp
8010111d:	c3                   	ret    
8010111e:	66 90                	xchg   %ax,%ax
    return -1;
80101120:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101125:	eb ee                	jmp    80101115 <filesteal+0x35>
  panic("filesteal");
80101127:	83 ec 0c             	sub    $0xc,%esp
8010112a:	68 4f 71 10 80       	push   $0x8010714f
8010112f:	e8 2c f3 ff ff       	call   80100460 <panic>
80101134:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010113a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101140 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101140:	55                   	push   %ebp
80101141:	89 e5                	mov    %esp,%ebp
80101143:	57                   	push   %edi
80101144:	56                   	push   %esi
80101145:	53                   	push   %ebx
80101146:	83 ec 1c             	sub    $0x1c,%esp
80101149:	8b 75 08             	mov    0x8(%ebp),%esi
8010114c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010114f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101153:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101156:	8b 45 10             	mov    0x10(%ebp),%eax
80101159:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010115c:	0f 84 aa 00 00 00    	je     8010120c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101162:	8b 06                	mov    (%esi),%eax
80101164:	83 f8 01             	cmp    $0x1,%eax
80101167:	0f 84 c3 00 00 00    	je     80101230 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010116d:	83 f8 02             	cmp    $0x2,%eax
80101170:	0f 85 d9 00 00 00    	jne    8010124f <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101176:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101179:	31 ff                	xor    %edi,%edi
    while(i < n){
8010117b:	85 c0                	test   %eax,%eax
8010117d:	7f 34                	jg     801011b3 <filewrite+0x73>
8010117f:	e9 9c 00 00 00       	jmp    80101220 <filewrite+0xe0>
80101184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101188:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010118b:	83 ec 0c             	sub    $0xc,%esp
8010118e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101191:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101194:	e8 17 07 00 00       	call   801018b0 <iunlock>
      end_op();
80101199:	e8 02 1c 00 00       	call   80102da0 <end_op>
8010119e:	8b 45 e0             	mov    -0x20(%ebp),%eax
801011a1:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
801011a4:	39 c3                	cmp    %eax,%ebx
801011a6:	0f 85 96 00 00 00    	jne    80101242 <filewrite+0x102>
        panic("short filewrite");
      i += r;
801011ac:	01 df                	add    %ebx,%edi
    while(i < n){
801011ae:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801011b1:	7e 6d                	jle    80101220 <filewrite+0xe0>
      int n1 = n - i;
801011b3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801011b6:	b8 00 06 00 00       	mov    $0x600,%eax
801011bb:	29 fb                	sub    %edi,%ebx
801011bd:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801011c3:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801011c6:	e8 65 1b 00 00       	call   80102d30 <begin_op>
      ilock(f->ip);
801011cb:	83 ec 0c             	sub    $0xc,%esp
801011ce:	ff 76 10             	pushl  0x10(%esi)
801011d1:	e8 fa 05 00 00       	call   801017d0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801011d6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011d9:	53                   	push   %ebx
801011da:	ff 76 14             	pushl  0x14(%esi)
801011dd:	01 f8                	add    %edi,%eax
801011df:	50                   	push   %eax
801011e0:	ff 76 10             	pushl  0x10(%esi)
801011e3:	e8 08 0a 00 00       	call   80101bf0 <writei>
801011e8:	83 c4 20             	add    $0x20,%esp
801011eb:	85 c0                	test   %eax,%eax
801011ed:	7f 99                	jg     80101188 <filewrite+0x48>
      iunlock(f->ip);
801011ef:	83 ec 0c             	sub    $0xc,%esp
801011f2:	ff 76 10             	pushl  0x10(%esi)
801011f5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011f8:	e8 b3 06 00 00       	call   801018b0 <iunlock>
      end_op();
801011fd:	e8 9e 1b 00 00       	call   80102da0 <end_op>
      if(r < 0)
80101202:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101205:	83 c4 10             	add    $0x10,%esp
80101208:	85 c0                	test   %eax,%eax
8010120a:	74 98                	je     801011a4 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010120c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010120f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
80101214:	89 f8                	mov    %edi,%eax
80101216:	5b                   	pop    %ebx
80101217:	5e                   	pop    %esi
80101218:	5f                   	pop    %edi
80101219:	5d                   	pop    %ebp
8010121a:	c3                   	ret    
8010121b:	90                   	nop
8010121c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
80101220:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101223:	75 e7                	jne    8010120c <filewrite+0xcc>
}
80101225:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101228:	89 f8                	mov    %edi,%eax
8010122a:	5b                   	pop    %ebx
8010122b:	5e                   	pop    %esi
8010122c:	5f                   	pop    %edi
8010122d:	5d                   	pop    %ebp
8010122e:	c3                   	ret    
8010122f:	90                   	nop
    return pipewrite(f->pipe, addr, n);
80101230:	8b 46 0c             	mov    0xc(%esi),%eax
80101233:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101236:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101239:	5b                   	pop    %ebx
8010123a:	5e                   	pop    %esi
8010123b:	5f                   	pop    %edi
8010123c:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
8010123d:	e9 3e 23 00 00       	jmp    80103580 <pipewrite>
        panic("short filewrite");
80101242:	83 ec 0c             	sub    $0xc,%esp
80101245:	68 59 71 10 80       	push   $0x80107159
8010124a:	e8 11 f2 ff ff       	call   80100460 <panic>
  panic("filewrite");
8010124f:	83 ec 0c             	sub    $0xc,%esp
80101252:	68 5f 71 10 80       	push   $0x8010715f
80101257:	e8 04 f2 ff ff       	call   80100460 <panic>
8010125c:	66 90                	xchg   %ax,%ax
8010125e:	66 90                	xchg   %ax,%ax

80101260 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101260:	55                   	push   %ebp
80101261:	89 e5                	mov    %esp,%ebp
80101263:	56                   	push   %esi
80101264:	53                   	push   %ebx
80101265:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101267:	c1 ea 0c             	shr    $0xc,%edx
8010126a:	03 15 18 0a 11 80    	add    0x80110a18,%edx
80101270:	83 ec 08             	sub    $0x8,%esp
80101273:	52                   	push   %edx
80101274:	50                   	push   %eax
80101275:	e8 56 ee ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010127a:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010127c:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
8010127f:	ba 01 00 00 00       	mov    $0x1,%edx
80101284:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101287:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010128d:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101290:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101292:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101297:	85 d1                	test   %edx,%ecx
80101299:	74 25                	je     801012c0 <bfree+0x60>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010129b:	f7 d2                	not    %edx
8010129d:	89 c6                	mov    %eax,%esi
  log_write(bp);
8010129f:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
801012a2:	21 ca                	and    %ecx,%edx
801012a4:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
801012a8:	56                   	push   %esi
801012a9:	e8 52 1c 00 00       	call   80102f00 <log_write>
  brelse(bp);
801012ae:	89 34 24             	mov    %esi,(%esp)
801012b1:	e8 2a ef ff ff       	call   801001e0 <brelse>
}
801012b6:	83 c4 10             	add    $0x10,%esp
801012b9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801012bc:	5b                   	pop    %ebx
801012bd:	5e                   	pop    %esi
801012be:	5d                   	pop    %ebp
801012bf:	c3                   	ret    
    panic("freeing free block");
801012c0:	83 ec 0c             	sub    $0xc,%esp
801012c3:	68 69 71 10 80       	push   $0x80107169
801012c8:	e8 93 f1 ff ff       	call   80100460 <panic>
801012cd:	8d 76 00             	lea    0x0(%esi),%esi

801012d0 <balloc>:
{
801012d0:	55                   	push   %ebp
801012d1:	89 e5                	mov    %esp,%ebp
801012d3:	57                   	push   %edi
801012d4:	56                   	push   %esi
801012d5:	53                   	push   %ebx
801012d6:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
801012d9:	8b 0d 00 0a 11 80    	mov    0x80110a00,%ecx
{
801012df:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801012e2:	85 c9                	test   %ecx,%ecx
801012e4:	0f 84 87 00 00 00    	je     80101371 <balloc+0xa1>
801012ea:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801012f1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801012f4:	83 ec 08             	sub    $0x8,%esp
801012f7:	89 f0                	mov    %esi,%eax
801012f9:	c1 f8 0c             	sar    $0xc,%eax
801012fc:	03 05 18 0a 11 80    	add    0x80110a18,%eax
80101302:	50                   	push   %eax
80101303:	ff 75 d8             	pushl  -0x28(%ebp)
80101306:	e8 c5 ed ff ff       	call   801000d0 <bread>
8010130b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010130e:	a1 00 0a 11 80       	mov    0x80110a00,%eax
80101313:	83 c4 10             	add    $0x10,%esp
80101316:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101319:	31 c0                	xor    %eax,%eax
8010131b:	eb 2f                	jmp    8010134c <balloc+0x7c>
8010131d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101320:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101322:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101325:	bb 01 00 00 00       	mov    $0x1,%ebx
8010132a:	83 e1 07             	and    $0x7,%ecx
8010132d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010132f:	89 c1                	mov    %eax,%ecx
80101331:	c1 f9 03             	sar    $0x3,%ecx
80101334:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101339:	85 df                	test   %ebx,%edi
8010133b:	89 fa                	mov    %edi,%edx
8010133d:	74 41                	je     80101380 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010133f:	83 c0 01             	add    $0x1,%eax
80101342:	83 c6 01             	add    $0x1,%esi
80101345:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010134a:	74 05                	je     80101351 <balloc+0x81>
8010134c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010134f:	77 cf                	ja     80101320 <balloc+0x50>
    brelse(bp);
80101351:	83 ec 0c             	sub    $0xc,%esp
80101354:	ff 75 e4             	pushl  -0x1c(%ebp)
80101357:	e8 84 ee ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010135c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101363:	83 c4 10             	add    $0x10,%esp
80101366:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101369:	39 05 00 0a 11 80    	cmp    %eax,0x80110a00
8010136f:	77 80                	ja     801012f1 <balloc+0x21>
  panic("balloc: out of blocks");
80101371:	83 ec 0c             	sub    $0xc,%esp
80101374:	68 7c 71 10 80       	push   $0x8010717c
80101379:	e8 e2 f0 ff ff       	call   80100460 <panic>
8010137e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101380:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101383:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101386:	09 da                	or     %ebx,%edx
80101388:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010138c:	57                   	push   %edi
8010138d:	e8 6e 1b 00 00       	call   80102f00 <log_write>
        brelse(bp);
80101392:	89 3c 24             	mov    %edi,(%esp)
80101395:	e8 46 ee ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
8010139a:	58                   	pop    %eax
8010139b:	5a                   	pop    %edx
8010139c:	56                   	push   %esi
8010139d:	ff 75 d8             	pushl  -0x28(%ebp)
801013a0:	e8 2b ed ff ff       	call   801000d0 <bread>
801013a5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801013a7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013aa:	83 c4 0c             	add    $0xc,%esp
801013ad:	68 00 02 00 00       	push   $0x200
801013b2:	6a 00                	push   $0x0
801013b4:	50                   	push   %eax
801013b5:	e8 26 32 00 00       	call   801045e0 <memset>
  log_write(bp);
801013ba:	89 1c 24             	mov    %ebx,(%esp)
801013bd:	e8 3e 1b 00 00       	call   80102f00 <log_write>
  brelse(bp);
801013c2:	89 1c 24             	mov    %ebx,(%esp)
801013c5:	e8 16 ee ff ff       	call   801001e0 <brelse>
}
801013ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013cd:	89 f0                	mov    %esi,%eax
801013cf:	5b                   	pop    %ebx
801013d0:	5e                   	pop    %esi
801013d1:	5f                   	pop    %edi
801013d2:	5d                   	pop    %ebp
801013d3:	c3                   	ret    
801013d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801013da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801013e0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801013e0:	55                   	push   %ebp
801013e1:	89 e5                	mov    %esp,%ebp
801013e3:	57                   	push   %edi
801013e4:	56                   	push   %esi
801013e5:	53                   	push   %ebx
801013e6:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801013e8:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013ea:	bb 54 0a 11 80       	mov    $0x80110a54,%ebx
{
801013ef:	83 ec 28             	sub    $0x28,%esp
801013f2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801013f5:	68 20 0a 11 80       	push   $0x80110a20
801013fa:	e8 d1 30 00 00       	call   801044d0 <acquire>
801013ff:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101402:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101405:	eb 17                	jmp    8010141e <iget+0x3e>
80101407:	89 f6                	mov    %esi,%esi
80101409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101410:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101416:	81 fb 74 26 11 80    	cmp    $0x80112674,%ebx
8010141c:	73 22                	jae    80101440 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010141e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101421:	85 c9                	test   %ecx,%ecx
80101423:	7e 04                	jle    80101429 <iget+0x49>
80101425:	39 3b                	cmp    %edi,(%ebx)
80101427:	74 4f                	je     80101478 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101429:	85 f6                	test   %esi,%esi
8010142b:	75 e3                	jne    80101410 <iget+0x30>
8010142d:	85 c9                	test   %ecx,%ecx
8010142f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101432:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101438:	81 fb 74 26 11 80    	cmp    $0x80112674,%ebx
8010143e:	72 de                	jb     8010141e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101440:	85 f6                	test   %esi,%esi
80101442:	74 5b                	je     8010149f <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101444:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101447:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101449:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010144c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101453:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010145a:	68 20 0a 11 80       	push   $0x80110a20
8010145f:	e8 2c 31 00 00       	call   80104590 <release>

  return ip;
80101464:	83 c4 10             	add    $0x10,%esp
}
80101467:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010146a:	89 f0                	mov    %esi,%eax
8010146c:	5b                   	pop    %ebx
8010146d:	5e                   	pop    %esi
8010146e:	5f                   	pop    %edi
8010146f:	5d                   	pop    %ebp
80101470:	c3                   	ret    
80101471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101478:	39 53 04             	cmp    %edx,0x4(%ebx)
8010147b:	75 ac                	jne    80101429 <iget+0x49>
      release(&icache.lock);
8010147d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101480:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101483:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101485:	68 20 0a 11 80       	push   $0x80110a20
      ip->ref++;
8010148a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010148d:	e8 fe 30 00 00       	call   80104590 <release>
      return ip;
80101492:	83 c4 10             	add    $0x10,%esp
}
80101495:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101498:	89 f0                	mov    %esi,%eax
8010149a:	5b                   	pop    %ebx
8010149b:	5e                   	pop    %esi
8010149c:	5f                   	pop    %edi
8010149d:	5d                   	pop    %ebp
8010149e:	c3                   	ret    
    panic("iget: no inodes");
8010149f:	83 ec 0c             	sub    $0xc,%esp
801014a2:	68 92 71 10 80       	push   $0x80107192
801014a7:	e8 b4 ef ff ff       	call   80100460 <panic>
801014ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801014b0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801014b0:	55                   	push   %ebp
801014b1:	89 e5                	mov    %esp,%ebp
801014b3:	57                   	push   %edi
801014b4:	56                   	push   %esi
801014b5:	53                   	push   %ebx
801014b6:	89 c6                	mov    %eax,%esi
801014b8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801014bb:	83 fa 0b             	cmp    $0xb,%edx
801014be:	77 18                	ja     801014d8 <bmap+0x28>
801014c0:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
801014c3:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801014c6:	85 db                	test   %ebx,%ebx
801014c8:	74 76                	je     80101540 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801014ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014cd:	89 d8                	mov    %ebx,%eax
801014cf:	5b                   	pop    %ebx
801014d0:	5e                   	pop    %esi
801014d1:	5f                   	pop    %edi
801014d2:	5d                   	pop    %ebp
801014d3:	c3                   	ret    
801014d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
801014d8:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
801014db:	83 fb 7f             	cmp    $0x7f,%ebx
801014de:	0f 87 90 00 00 00    	ja     80101574 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
801014e4:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
801014ea:	8b 00                	mov    (%eax),%eax
801014ec:	85 d2                	test   %edx,%edx
801014ee:	74 70                	je     80101560 <bmap+0xb0>
    bp = bread(ip->dev, addr);
801014f0:	83 ec 08             	sub    $0x8,%esp
801014f3:	52                   	push   %edx
801014f4:	50                   	push   %eax
801014f5:	e8 d6 eb ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
801014fa:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801014fe:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101501:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101503:	8b 1a                	mov    (%edx),%ebx
80101505:	85 db                	test   %ebx,%ebx
80101507:	75 1d                	jne    80101526 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
80101509:	8b 06                	mov    (%esi),%eax
8010150b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010150e:	e8 bd fd ff ff       	call   801012d0 <balloc>
80101513:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101516:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101519:	89 c3                	mov    %eax,%ebx
8010151b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010151d:	57                   	push   %edi
8010151e:	e8 dd 19 00 00       	call   80102f00 <log_write>
80101523:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101526:	83 ec 0c             	sub    $0xc,%esp
80101529:	57                   	push   %edi
8010152a:	e8 b1 ec ff ff       	call   801001e0 <brelse>
8010152f:	83 c4 10             	add    $0x10,%esp
}
80101532:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101535:	89 d8                	mov    %ebx,%eax
80101537:	5b                   	pop    %ebx
80101538:	5e                   	pop    %esi
80101539:	5f                   	pop    %edi
8010153a:	5d                   	pop    %ebp
8010153b:	c3                   	ret    
8010153c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101540:	8b 00                	mov    (%eax),%eax
80101542:	e8 89 fd ff ff       	call   801012d0 <balloc>
80101547:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010154a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010154d:	89 c3                	mov    %eax,%ebx
}
8010154f:	89 d8                	mov    %ebx,%eax
80101551:	5b                   	pop    %ebx
80101552:	5e                   	pop    %esi
80101553:	5f                   	pop    %edi
80101554:	5d                   	pop    %ebp
80101555:	c3                   	ret    
80101556:	8d 76 00             	lea    0x0(%esi),%esi
80101559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101560:	e8 6b fd ff ff       	call   801012d0 <balloc>
80101565:	89 c2                	mov    %eax,%edx
80101567:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010156d:	8b 06                	mov    (%esi),%eax
8010156f:	e9 7c ff ff ff       	jmp    801014f0 <bmap+0x40>
  panic("bmap: out of range");
80101574:	83 ec 0c             	sub    $0xc,%esp
80101577:	68 a2 71 10 80       	push   $0x801071a2
8010157c:	e8 df ee ff ff       	call   80100460 <panic>
80101581:	eb 0d                	jmp    80101590 <readsb>
80101583:	90                   	nop
80101584:	90                   	nop
80101585:	90                   	nop
80101586:	90                   	nop
80101587:	90                   	nop
80101588:	90                   	nop
80101589:	90                   	nop
8010158a:	90                   	nop
8010158b:	90                   	nop
8010158c:	90                   	nop
8010158d:	90                   	nop
8010158e:	90                   	nop
8010158f:	90                   	nop

80101590 <readsb>:
{
80101590:	55                   	push   %ebp
80101591:	89 e5                	mov    %esp,%ebp
80101593:	56                   	push   %esi
80101594:	53                   	push   %ebx
80101595:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101598:	83 ec 08             	sub    $0x8,%esp
8010159b:	6a 01                	push   $0x1
8010159d:	ff 75 08             	pushl  0x8(%ebp)
801015a0:	e8 2b eb ff ff       	call   801000d0 <bread>
801015a5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801015a7:	8d 40 5c             	lea    0x5c(%eax),%eax
801015aa:	83 c4 0c             	add    $0xc,%esp
801015ad:	6a 1c                	push   $0x1c
801015af:	50                   	push   %eax
801015b0:	56                   	push   %esi
801015b1:	e8 da 30 00 00       	call   80104690 <memmove>
  brelse(bp);
801015b6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801015b9:	83 c4 10             	add    $0x10,%esp
}
801015bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015bf:	5b                   	pop    %ebx
801015c0:	5e                   	pop    %esi
801015c1:	5d                   	pop    %ebp
  brelse(bp);
801015c2:	e9 19 ec ff ff       	jmp    801001e0 <brelse>
801015c7:	89 f6                	mov    %esi,%esi
801015c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801015d0 <iinit>:
{
801015d0:	55                   	push   %ebp
801015d1:	89 e5                	mov    %esp,%ebp
801015d3:	53                   	push   %ebx
801015d4:	bb 60 0a 11 80       	mov    $0x80110a60,%ebx
801015d9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801015dc:	68 b5 71 10 80       	push   $0x801071b5
801015e1:	68 20 0a 11 80       	push   $0x80110a20
801015e6:	e8 a5 2d 00 00       	call   80104390 <initlock>
801015eb:	83 c4 10             	add    $0x10,%esp
801015ee:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801015f0:	83 ec 08             	sub    $0x8,%esp
801015f3:	68 bc 71 10 80       	push   $0x801071bc
801015f8:	53                   	push   %ebx
801015f9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801015ff:	e8 5c 2c 00 00       	call   80104260 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101604:	83 c4 10             	add    $0x10,%esp
80101607:	81 fb 80 26 11 80    	cmp    $0x80112680,%ebx
8010160d:	75 e1                	jne    801015f0 <iinit+0x20>
  readsb(dev, &sb);
8010160f:	83 ec 08             	sub    $0x8,%esp
80101612:	68 00 0a 11 80       	push   $0x80110a00
80101617:	ff 75 08             	pushl  0x8(%ebp)
8010161a:	e8 71 ff ff ff       	call   80101590 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010161f:	ff 35 18 0a 11 80    	pushl  0x80110a18
80101625:	ff 35 14 0a 11 80    	pushl  0x80110a14
8010162b:	ff 35 10 0a 11 80    	pushl  0x80110a10
80101631:	ff 35 0c 0a 11 80    	pushl  0x80110a0c
80101637:	ff 35 08 0a 11 80    	pushl  0x80110a08
8010163d:	ff 35 04 0a 11 80    	pushl  0x80110a04
80101643:	ff 35 00 0a 11 80    	pushl  0x80110a00
80101649:	68 20 72 10 80       	push   $0x80107220
8010164e:	e8 dd f0 ff ff       	call   80100730 <cprintf>
}
80101653:	83 c4 30             	add    $0x30,%esp
80101656:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101659:	c9                   	leave  
8010165a:	c3                   	ret    
8010165b:	90                   	nop
8010165c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101660 <ialloc>:
{
80101660:	55                   	push   %ebp
80101661:	89 e5                	mov    %esp,%ebp
80101663:	57                   	push   %edi
80101664:	56                   	push   %esi
80101665:	53                   	push   %ebx
80101666:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101669:	83 3d 08 0a 11 80 01 	cmpl   $0x1,0x80110a08
{
80101670:	8b 45 0c             	mov    0xc(%ebp),%eax
80101673:	8b 75 08             	mov    0x8(%ebp),%esi
80101676:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101679:	0f 86 91 00 00 00    	jbe    80101710 <ialloc+0xb0>
8010167f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101684:	eb 21                	jmp    801016a7 <ialloc+0x47>
80101686:	8d 76 00             	lea    0x0(%esi),%esi
80101689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101690:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101693:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101696:	57                   	push   %edi
80101697:	e8 44 eb ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010169c:	83 c4 10             	add    $0x10,%esp
8010169f:	39 1d 08 0a 11 80    	cmp    %ebx,0x80110a08
801016a5:	76 69                	jbe    80101710 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801016a7:	89 d8                	mov    %ebx,%eax
801016a9:	83 ec 08             	sub    $0x8,%esp
801016ac:	c1 e8 03             	shr    $0x3,%eax
801016af:	03 05 14 0a 11 80    	add    0x80110a14,%eax
801016b5:	50                   	push   %eax
801016b6:	56                   	push   %esi
801016b7:	e8 14 ea ff ff       	call   801000d0 <bread>
801016bc:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801016be:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
801016c0:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
801016c3:	83 e0 07             	and    $0x7,%eax
801016c6:	c1 e0 06             	shl    $0x6,%eax
801016c9:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801016cd:	66 83 39 00          	cmpw   $0x0,(%ecx)
801016d1:	75 bd                	jne    80101690 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801016d3:	83 ec 04             	sub    $0x4,%esp
801016d6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801016d9:	6a 40                	push   $0x40
801016db:	6a 00                	push   $0x0
801016dd:	51                   	push   %ecx
801016de:	e8 fd 2e 00 00       	call   801045e0 <memset>
      dip->type = type;
801016e3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801016e7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801016ea:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801016ed:	89 3c 24             	mov    %edi,(%esp)
801016f0:	e8 0b 18 00 00       	call   80102f00 <log_write>
      brelse(bp);
801016f5:	89 3c 24             	mov    %edi,(%esp)
801016f8:	e8 e3 ea ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801016fd:	83 c4 10             	add    $0x10,%esp
}
80101700:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101703:	89 da                	mov    %ebx,%edx
80101705:	89 f0                	mov    %esi,%eax
}
80101707:	5b                   	pop    %ebx
80101708:	5e                   	pop    %esi
80101709:	5f                   	pop    %edi
8010170a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010170b:	e9 d0 fc ff ff       	jmp    801013e0 <iget>
  panic("ialloc: no inodes");
80101710:	83 ec 0c             	sub    $0xc,%esp
80101713:	68 c2 71 10 80       	push   $0x801071c2
80101718:	e8 43 ed ff ff       	call   80100460 <panic>
8010171d:	8d 76 00             	lea    0x0(%esi),%esi

80101720 <iupdate>:
{
80101720:	55                   	push   %ebp
80101721:	89 e5                	mov    %esp,%ebp
80101723:	56                   	push   %esi
80101724:	53                   	push   %ebx
80101725:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101728:	83 ec 08             	sub    $0x8,%esp
8010172b:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010172e:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101731:	c1 e8 03             	shr    $0x3,%eax
80101734:	03 05 14 0a 11 80    	add    0x80110a14,%eax
8010173a:	50                   	push   %eax
8010173b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010173e:	e8 8d e9 ff ff       	call   801000d0 <bread>
80101743:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101745:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101748:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010174c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010174f:	83 e0 07             	and    $0x7,%eax
80101752:	c1 e0 06             	shl    $0x6,%eax
80101755:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101759:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010175c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101760:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101763:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101767:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010176b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010176f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101773:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101777:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010177a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010177d:	6a 34                	push   $0x34
8010177f:	53                   	push   %ebx
80101780:	50                   	push   %eax
80101781:	e8 0a 2f 00 00       	call   80104690 <memmove>
  log_write(bp);
80101786:	89 34 24             	mov    %esi,(%esp)
80101789:	e8 72 17 00 00       	call   80102f00 <log_write>
  brelse(bp);
8010178e:	89 75 08             	mov    %esi,0x8(%ebp)
80101791:	83 c4 10             	add    $0x10,%esp
}
80101794:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101797:	5b                   	pop    %ebx
80101798:	5e                   	pop    %esi
80101799:	5d                   	pop    %ebp
  brelse(bp);
8010179a:	e9 41 ea ff ff       	jmp    801001e0 <brelse>
8010179f:	90                   	nop

801017a0 <idup>:
{
801017a0:	55                   	push   %ebp
801017a1:	89 e5                	mov    %esp,%ebp
801017a3:	53                   	push   %ebx
801017a4:	83 ec 10             	sub    $0x10,%esp
801017a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801017aa:	68 20 0a 11 80       	push   $0x80110a20
801017af:	e8 1c 2d 00 00       	call   801044d0 <acquire>
  ip->ref++;
801017b4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017b8:	c7 04 24 20 0a 11 80 	movl   $0x80110a20,(%esp)
801017bf:	e8 cc 2d 00 00       	call   80104590 <release>
}
801017c4:	89 d8                	mov    %ebx,%eax
801017c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801017c9:	c9                   	leave  
801017ca:	c3                   	ret    
801017cb:	90                   	nop
801017cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801017d0 <ilock>:
{
801017d0:	55                   	push   %ebp
801017d1:	89 e5                	mov    %esp,%ebp
801017d3:	56                   	push   %esi
801017d4:	53                   	push   %ebx
801017d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801017d8:	85 db                	test   %ebx,%ebx
801017da:	0f 84 b7 00 00 00    	je     80101897 <ilock+0xc7>
801017e0:	8b 53 08             	mov    0x8(%ebx),%edx
801017e3:	85 d2                	test   %edx,%edx
801017e5:	0f 8e ac 00 00 00    	jle    80101897 <ilock+0xc7>
  acquiresleep(&ip->lock);
801017eb:	8d 43 0c             	lea    0xc(%ebx),%eax
801017ee:	83 ec 0c             	sub    $0xc,%esp
801017f1:	50                   	push   %eax
801017f2:	e8 a9 2a 00 00       	call   801042a0 <acquiresleep>
  if(ip->valid == 0){
801017f7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801017fa:	83 c4 10             	add    $0x10,%esp
801017fd:	85 c0                	test   %eax,%eax
801017ff:	74 0f                	je     80101810 <ilock+0x40>
}
80101801:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101804:	5b                   	pop    %ebx
80101805:	5e                   	pop    %esi
80101806:	5d                   	pop    %ebp
80101807:	c3                   	ret    
80101808:	90                   	nop
80101809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101810:	8b 43 04             	mov    0x4(%ebx),%eax
80101813:	83 ec 08             	sub    $0x8,%esp
80101816:	c1 e8 03             	shr    $0x3,%eax
80101819:	03 05 14 0a 11 80    	add    0x80110a14,%eax
8010181f:	50                   	push   %eax
80101820:	ff 33                	pushl  (%ebx)
80101822:	e8 a9 e8 ff ff       	call   801000d0 <bread>
80101827:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101829:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010182c:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010182f:	83 e0 07             	and    $0x7,%eax
80101832:	c1 e0 06             	shl    $0x6,%eax
80101835:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101839:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010183c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010183f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101843:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101847:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010184b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010184f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101853:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101857:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010185b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010185e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101861:	6a 34                	push   $0x34
80101863:	50                   	push   %eax
80101864:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101867:	50                   	push   %eax
80101868:	e8 23 2e 00 00       	call   80104690 <memmove>
    brelse(bp);
8010186d:	89 34 24             	mov    %esi,(%esp)
80101870:	e8 6b e9 ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101875:	83 c4 10             	add    $0x10,%esp
80101878:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010187d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101884:	0f 85 77 ff ff ff    	jne    80101801 <ilock+0x31>
      panic("ilock: no type");
8010188a:	83 ec 0c             	sub    $0xc,%esp
8010188d:	68 da 71 10 80       	push   $0x801071da
80101892:	e8 c9 eb ff ff       	call   80100460 <panic>
    panic("ilock");
80101897:	83 ec 0c             	sub    $0xc,%esp
8010189a:	68 d4 71 10 80       	push   $0x801071d4
8010189f:	e8 bc eb ff ff       	call   80100460 <panic>
801018a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801018aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801018b0 <iunlock>:
{
801018b0:	55                   	push   %ebp
801018b1:	89 e5                	mov    %esp,%ebp
801018b3:	56                   	push   %esi
801018b4:	53                   	push   %ebx
801018b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801018b8:	85 db                	test   %ebx,%ebx
801018ba:	74 28                	je     801018e4 <iunlock+0x34>
801018bc:	8d 73 0c             	lea    0xc(%ebx),%esi
801018bf:	83 ec 0c             	sub    $0xc,%esp
801018c2:	56                   	push   %esi
801018c3:	e8 78 2a 00 00       	call   80104340 <holdingsleep>
801018c8:	83 c4 10             	add    $0x10,%esp
801018cb:	85 c0                	test   %eax,%eax
801018cd:	74 15                	je     801018e4 <iunlock+0x34>
801018cf:	8b 43 08             	mov    0x8(%ebx),%eax
801018d2:	85 c0                	test   %eax,%eax
801018d4:	7e 0e                	jle    801018e4 <iunlock+0x34>
  releasesleep(&ip->lock);
801018d6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801018d9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018dc:	5b                   	pop    %ebx
801018dd:	5e                   	pop    %esi
801018de:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801018df:	e9 1c 2a 00 00       	jmp    80104300 <releasesleep>
    panic("iunlock");
801018e4:	83 ec 0c             	sub    $0xc,%esp
801018e7:	68 e9 71 10 80       	push   $0x801071e9
801018ec:	e8 6f eb ff ff       	call   80100460 <panic>
801018f1:	eb 0d                	jmp    80101900 <iput>
801018f3:	90                   	nop
801018f4:	90                   	nop
801018f5:	90                   	nop
801018f6:	90                   	nop
801018f7:	90                   	nop
801018f8:	90                   	nop
801018f9:	90                   	nop
801018fa:	90                   	nop
801018fb:	90                   	nop
801018fc:	90                   	nop
801018fd:	90                   	nop
801018fe:	90                   	nop
801018ff:	90                   	nop

80101900 <iput>:
{
80101900:	55                   	push   %ebp
80101901:	89 e5                	mov    %esp,%ebp
80101903:	57                   	push   %edi
80101904:	56                   	push   %esi
80101905:	53                   	push   %ebx
80101906:	83 ec 28             	sub    $0x28,%esp
80101909:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010190c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010190f:	57                   	push   %edi
80101910:	e8 8b 29 00 00       	call   801042a0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101915:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101918:	83 c4 10             	add    $0x10,%esp
8010191b:	85 d2                	test   %edx,%edx
8010191d:	74 07                	je     80101926 <iput+0x26>
8010191f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101924:	74 32                	je     80101958 <iput+0x58>
  releasesleep(&ip->lock);
80101926:	83 ec 0c             	sub    $0xc,%esp
80101929:	57                   	push   %edi
8010192a:	e8 d1 29 00 00       	call   80104300 <releasesleep>
  acquire(&icache.lock);
8010192f:	c7 04 24 20 0a 11 80 	movl   $0x80110a20,(%esp)
80101936:	e8 95 2b 00 00       	call   801044d0 <acquire>
  ip->ref--;
8010193b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010193f:	83 c4 10             	add    $0x10,%esp
80101942:	c7 45 08 20 0a 11 80 	movl   $0x80110a20,0x8(%ebp)
}
80101949:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010194c:	5b                   	pop    %ebx
8010194d:	5e                   	pop    %esi
8010194e:	5f                   	pop    %edi
8010194f:	5d                   	pop    %ebp
  release(&icache.lock);
80101950:	e9 3b 2c 00 00       	jmp    80104590 <release>
80101955:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101958:	83 ec 0c             	sub    $0xc,%esp
8010195b:	68 20 0a 11 80       	push   $0x80110a20
80101960:	e8 6b 2b 00 00       	call   801044d0 <acquire>
    int r = ip->ref;
80101965:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101968:	c7 04 24 20 0a 11 80 	movl   $0x80110a20,(%esp)
8010196f:	e8 1c 2c 00 00       	call   80104590 <release>
    if(r == 1){
80101974:	83 c4 10             	add    $0x10,%esp
80101977:	83 fe 01             	cmp    $0x1,%esi
8010197a:	75 aa                	jne    80101926 <iput+0x26>
8010197c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101982:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101985:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101988:	89 cf                	mov    %ecx,%edi
8010198a:	eb 0b                	jmp    80101997 <iput+0x97>
8010198c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101990:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101993:	39 fe                	cmp    %edi,%esi
80101995:	74 19                	je     801019b0 <iput+0xb0>
    if(ip->addrs[i]){
80101997:	8b 16                	mov    (%esi),%edx
80101999:	85 d2                	test   %edx,%edx
8010199b:	74 f3                	je     80101990 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010199d:	8b 03                	mov    (%ebx),%eax
8010199f:	e8 bc f8 ff ff       	call   80101260 <bfree>
      ip->addrs[i] = 0;
801019a4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801019aa:	eb e4                	jmp    80101990 <iput+0x90>
801019ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801019b0:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801019b6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019b9:	85 c0                	test   %eax,%eax
801019bb:	75 33                	jne    801019f0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
801019bd:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801019c0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801019c7:	53                   	push   %ebx
801019c8:	e8 53 fd ff ff       	call   80101720 <iupdate>
      ip->type = 0;
801019cd:	31 c0                	xor    %eax,%eax
801019cf:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801019d3:	89 1c 24             	mov    %ebx,(%esp)
801019d6:	e8 45 fd ff ff       	call   80101720 <iupdate>
      ip->valid = 0;
801019db:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801019e2:	83 c4 10             	add    $0x10,%esp
801019e5:	e9 3c ff ff ff       	jmp    80101926 <iput+0x26>
801019ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801019f0:	83 ec 08             	sub    $0x8,%esp
801019f3:	50                   	push   %eax
801019f4:	ff 33                	pushl  (%ebx)
801019f6:	e8 d5 e6 ff ff       	call   801000d0 <bread>
801019fb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101a01:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101a04:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101a07:	8d 70 5c             	lea    0x5c(%eax),%esi
80101a0a:	83 c4 10             	add    $0x10,%esp
80101a0d:	89 cf                	mov    %ecx,%edi
80101a0f:	eb 0e                	jmp    80101a1f <iput+0x11f>
80101a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a18:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
80101a1b:	39 fe                	cmp    %edi,%esi
80101a1d:	74 0f                	je     80101a2e <iput+0x12e>
      if(a[j])
80101a1f:	8b 16                	mov    (%esi),%edx
80101a21:	85 d2                	test   %edx,%edx
80101a23:	74 f3                	je     80101a18 <iput+0x118>
        bfree(ip->dev, a[j]);
80101a25:	8b 03                	mov    (%ebx),%eax
80101a27:	e8 34 f8 ff ff       	call   80101260 <bfree>
80101a2c:	eb ea                	jmp    80101a18 <iput+0x118>
    brelse(bp);
80101a2e:	83 ec 0c             	sub    $0xc,%esp
80101a31:	ff 75 e4             	pushl  -0x1c(%ebp)
80101a34:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a37:	e8 a4 e7 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101a3c:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101a42:	8b 03                	mov    (%ebx),%eax
80101a44:	e8 17 f8 ff ff       	call   80101260 <bfree>
    ip->addrs[NDIRECT] = 0;
80101a49:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101a50:	00 00 00 
80101a53:	83 c4 10             	add    $0x10,%esp
80101a56:	e9 62 ff ff ff       	jmp    801019bd <iput+0xbd>
80101a5b:	90                   	nop
80101a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a60 <iunlockput>:
{
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	53                   	push   %ebx
80101a64:	83 ec 10             	sub    $0x10,%esp
80101a67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101a6a:	53                   	push   %ebx
80101a6b:	e8 40 fe ff ff       	call   801018b0 <iunlock>
  iput(ip);
80101a70:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a73:	83 c4 10             	add    $0x10,%esp
}
80101a76:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a79:	c9                   	leave  
  iput(ip);
80101a7a:	e9 81 fe ff ff       	jmp    80101900 <iput>
80101a7f:	90                   	nop

80101a80 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101a80:	55                   	push   %ebp
80101a81:	89 e5                	mov    %esp,%ebp
80101a83:	8b 55 08             	mov    0x8(%ebp),%edx
80101a86:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a89:	8b 0a                	mov    (%edx),%ecx
80101a8b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a8e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a91:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101a94:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101a98:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101a9b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101a9f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101aa3:	8b 52 58             	mov    0x58(%edx),%edx
80101aa6:	89 50 10             	mov    %edx,0x10(%eax)
}
80101aa9:	5d                   	pop    %ebp
80101aaa:	c3                   	ret    
80101aab:	90                   	nop
80101aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ab0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101ab0:	55                   	push   %ebp
80101ab1:	89 e5                	mov    %esp,%ebp
80101ab3:	57                   	push   %edi
80101ab4:	56                   	push   %esi
80101ab5:	53                   	push   %ebx
80101ab6:	83 ec 1c             	sub    $0x1c,%esp
80101ab9:	8b 45 08             	mov    0x8(%ebp),%eax
80101abc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101abf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ac2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101ac7:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101aca:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101acd:	8b 75 10             	mov    0x10(%ebp),%esi
80101ad0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101ad3:	0f 84 a7 00 00 00    	je     80101b80 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101ad9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101adc:	8b 40 58             	mov    0x58(%eax),%eax
80101adf:	39 c6                	cmp    %eax,%esi
80101ae1:	0f 87 bd 00 00 00    	ja     80101ba4 <readi+0xf4>
80101ae7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101aea:	89 f9                	mov    %edi,%ecx
80101aec:	01 f1                	add    %esi,%ecx
80101aee:	0f 82 b0 00 00 00    	jb     80101ba4 <readi+0xf4>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101af4:	89 c2                	mov    %eax,%edx
80101af6:	29 f2                	sub    %esi,%edx
80101af8:	39 c8                	cmp    %ecx,%eax
80101afa:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101afd:	31 ff                	xor    %edi,%edi
80101aff:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101b01:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b04:	74 6c                	je     80101b72 <readi+0xc2>
80101b06:	8d 76 00             	lea    0x0(%esi),%esi
80101b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b10:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101b13:	89 f2                	mov    %esi,%edx
80101b15:	c1 ea 09             	shr    $0x9,%edx
80101b18:	89 d8                	mov    %ebx,%eax
80101b1a:	e8 91 f9 ff ff       	call   801014b0 <bmap>
80101b1f:	83 ec 08             	sub    $0x8,%esp
80101b22:	50                   	push   %eax
80101b23:	ff 33                	pushl  (%ebx)
80101b25:	e8 a6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b2a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b2d:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b2f:	89 f0                	mov    %esi,%eax
80101b31:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b36:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b3b:	83 c4 0c             	add    $0xc,%esp
80101b3e:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b40:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101b44:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101b47:	29 fb                	sub    %edi,%ebx
80101b49:	39 d9                	cmp    %ebx,%ecx
80101b4b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b4e:	53                   	push   %ebx
80101b4f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b50:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101b52:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b55:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101b57:	e8 34 2b 00 00       	call   80104690 <memmove>
    brelse(bp);
80101b5c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b5f:	89 14 24             	mov    %edx,(%esp)
80101b62:	e8 79 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b67:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b6a:	83 c4 10             	add    $0x10,%esp
80101b6d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b70:	77 9e                	ja     80101b10 <readi+0x60>
  }
  return n;
80101b72:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b78:	5b                   	pop    %ebx
80101b79:	5e                   	pop    %esi
80101b7a:	5f                   	pop    %edi
80101b7b:	5d                   	pop    %ebp
80101b7c:	c3                   	ret    
80101b7d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b80:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b84:	66 83 f8 09          	cmp    $0x9,%ax
80101b88:	77 1a                	ja     80101ba4 <readi+0xf4>
80101b8a:	8d 04 40             	lea    (%eax,%eax,2),%eax
80101b8d:	8b 04 85 80 09 11 80 	mov    -0x7feef680(,%eax,4),%eax
80101b94:	85 c0                	test   %eax,%eax
80101b96:	74 0c                	je     80101ba4 <readi+0xf4>
    return devsw[ip->major].read(ip, dst, n);
80101b98:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b9b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b9e:	5b                   	pop    %ebx
80101b9f:	5e                   	pop    %esi
80101ba0:	5f                   	pop    %edi
80101ba1:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101ba2:	ff e0                	jmp    *%eax
      return -1;
80101ba4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ba9:	eb ca                	jmp    80101b75 <readi+0xc5>
80101bab:	90                   	nop
80101bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101bb0 <steali>:
// Read data from inode.
// Caller must hold ip->lock.
// like readi but just reads one character from console
int
steali(struct inode *ip)
{
80101bb0:	55                   	push   %ebp
80101bb1:	89 e5                	mov    %esp,%ebp
80101bb3:	8b 45 08             	mov    0x8(%ebp),%eax
  if(ip->type == T_DEV){
80101bb6:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101bbb:	75 23                	jne    80101be0 <steali+0x30>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].steal)
80101bbd:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101bc1:	66 83 f8 09          	cmp    $0x9,%ax
80101bc5:	77 19                	ja     80101be0 <steali+0x30>
80101bc7:	8d 04 40             	lea    (%eax,%eax,2),%eax
80101bca:	8b 04 85 84 09 11 80 	mov    -0x7feef67c(,%eax,4),%eax
80101bd1:	85 c0                	test   %eax,%eax
80101bd3:	74 0b                	je     80101be0 <steali+0x30>
      return -1;
    int r = devsw[ip->major].steal(ip);
    return r;
  }
  return -1;
}
80101bd5:	5d                   	pop    %ebp
    int r = devsw[ip->major].steal(ip);
80101bd6:	ff e0                	jmp    *%eax
80101bd8:	90                   	nop
80101bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80101be0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101be5:	5d                   	pop    %ebp
80101be6:	c3                   	ret    
80101be7:	89 f6                	mov    %esi,%esi
80101be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bf0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101bf0:	55                   	push   %ebp
80101bf1:	89 e5                	mov    %esp,%ebp
80101bf3:	57                   	push   %edi
80101bf4:	56                   	push   %esi
80101bf5:	53                   	push   %ebx
80101bf6:	83 ec 1c             	sub    $0x1c,%esp
80101bf9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bfc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101bff:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c02:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101c07:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101c0a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101c0d:	8b 75 10             	mov    0x10(%ebp),%esi
80101c10:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101c13:	0f 84 b7 00 00 00    	je     80101cd0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101c19:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c1c:	39 70 58             	cmp    %esi,0x58(%eax)
80101c1f:	0f 82 eb 00 00 00    	jb     80101d10 <writei+0x120>
80101c25:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101c28:	31 d2                	xor    %edx,%edx
80101c2a:	89 f8                	mov    %edi,%eax
80101c2c:	01 f0                	add    %esi,%eax
80101c2e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101c31:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101c36:	0f 87 d4 00 00 00    	ja     80101d10 <writei+0x120>
80101c3c:	85 d2                	test   %edx,%edx
80101c3e:	0f 85 cc 00 00 00    	jne    80101d10 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c44:	85 ff                	test   %edi,%edi
80101c46:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101c4d:	74 72                	je     80101cc1 <writei+0xd1>
80101c4f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c50:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101c53:	89 f2                	mov    %esi,%edx
80101c55:	c1 ea 09             	shr    $0x9,%edx
80101c58:	89 f8                	mov    %edi,%eax
80101c5a:	e8 51 f8 ff ff       	call   801014b0 <bmap>
80101c5f:	83 ec 08             	sub    $0x8,%esp
80101c62:	50                   	push   %eax
80101c63:	ff 37                	pushl  (%edi)
80101c65:	e8 66 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c6a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c6d:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c70:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c72:	89 f0                	mov    %esi,%eax
80101c74:	b9 00 02 00 00       	mov    $0x200,%ecx
80101c79:	83 c4 0c             	add    $0xc,%esp
80101c7c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c81:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101c83:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c87:	39 d9                	cmp    %ebx,%ecx
80101c89:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101c8c:	53                   	push   %ebx
80101c8d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c90:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101c92:	50                   	push   %eax
80101c93:	e8 f8 29 00 00       	call   80104690 <memmove>
    log_write(bp);
80101c98:	89 3c 24             	mov    %edi,(%esp)
80101c9b:	e8 60 12 00 00       	call   80102f00 <log_write>
    brelse(bp);
80101ca0:	89 3c 24             	mov    %edi,(%esp)
80101ca3:	e8 38 e5 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ca8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101cab:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101cae:	83 c4 10             	add    $0x10,%esp
80101cb1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101cb4:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101cb7:	77 97                	ja     80101c50 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101cb9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101cbc:	3b 70 58             	cmp    0x58(%eax),%esi
80101cbf:	77 37                	ja     80101cf8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101cc1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101cc4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cc7:	5b                   	pop    %ebx
80101cc8:	5e                   	pop    %esi
80101cc9:	5f                   	pop    %edi
80101cca:	5d                   	pop    %ebp
80101ccb:	c3                   	ret    
80101ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101cd0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101cd4:	66 83 f8 09          	cmp    $0x9,%ax
80101cd8:	77 36                	ja     80101d10 <writei+0x120>
80101cda:	8d 04 40             	lea    (%eax,%eax,2),%eax
80101cdd:	8b 04 85 88 09 11 80 	mov    -0x7feef678(,%eax,4),%eax
80101ce4:	85 c0                	test   %eax,%eax
80101ce6:	74 28                	je     80101d10 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101ce8:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101ceb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cee:	5b                   	pop    %ebx
80101cef:	5e                   	pop    %esi
80101cf0:	5f                   	pop    %edi
80101cf1:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101cf2:	ff e0                	jmp    *%eax
80101cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101cf8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101cfb:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101cfe:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101d01:	50                   	push   %eax
80101d02:	e8 19 fa ff ff       	call   80101720 <iupdate>
80101d07:	83 c4 10             	add    $0x10,%esp
80101d0a:	eb b5                	jmp    80101cc1 <writei+0xd1>
80101d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101d10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d15:	eb ad                	jmp    80101cc4 <writei+0xd4>
80101d17:	89 f6                	mov    %esi,%esi
80101d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101d20 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101d20:	55                   	push   %ebp
80101d21:	89 e5                	mov    %esp,%ebp
80101d23:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101d26:	6a 0e                	push   $0xe
80101d28:	ff 75 0c             	pushl  0xc(%ebp)
80101d2b:	ff 75 08             	pushl  0x8(%ebp)
80101d2e:	e8 cd 29 00 00       	call   80104700 <strncmp>
}
80101d33:	c9                   	leave  
80101d34:	c3                   	ret    
80101d35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101d40 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101d40:	55                   	push   %ebp
80101d41:	89 e5                	mov    %esp,%ebp
80101d43:	57                   	push   %edi
80101d44:	56                   	push   %esi
80101d45:	53                   	push   %ebx
80101d46:	83 ec 1c             	sub    $0x1c,%esp
80101d49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101d4c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101d51:	0f 85 85 00 00 00    	jne    80101ddc <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101d57:	8b 53 58             	mov    0x58(%ebx),%edx
80101d5a:	31 ff                	xor    %edi,%edi
80101d5c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101d5f:	85 d2                	test   %edx,%edx
80101d61:	74 3e                	je     80101da1 <dirlookup+0x61>
80101d63:	90                   	nop
80101d64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d68:	6a 10                	push   $0x10
80101d6a:	57                   	push   %edi
80101d6b:	56                   	push   %esi
80101d6c:	53                   	push   %ebx
80101d6d:	e8 3e fd ff ff       	call   80101ab0 <readi>
80101d72:	83 c4 10             	add    $0x10,%esp
80101d75:	83 f8 10             	cmp    $0x10,%eax
80101d78:	75 55                	jne    80101dcf <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101d7a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d7f:	74 18                	je     80101d99 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101d81:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d84:	83 ec 04             	sub    $0x4,%esp
80101d87:	6a 0e                	push   $0xe
80101d89:	50                   	push   %eax
80101d8a:	ff 75 0c             	pushl  0xc(%ebp)
80101d8d:	e8 6e 29 00 00       	call   80104700 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101d92:	83 c4 10             	add    $0x10,%esp
80101d95:	85 c0                	test   %eax,%eax
80101d97:	74 17                	je     80101db0 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101d99:	83 c7 10             	add    $0x10,%edi
80101d9c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101d9f:	72 c7                	jb     80101d68 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101da1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101da4:	31 c0                	xor    %eax,%eax
}
80101da6:	5b                   	pop    %ebx
80101da7:	5e                   	pop    %esi
80101da8:	5f                   	pop    %edi
80101da9:	5d                   	pop    %ebp
80101daa:	c3                   	ret    
80101dab:	90                   	nop
80101dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101db0:	8b 45 10             	mov    0x10(%ebp),%eax
80101db3:	85 c0                	test   %eax,%eax
80101db5:	74 05                	je     80101dbc <dirlookup+0x7c>
        *poff = off;
80101db7:	8b 45 10             	mov    0x10(%ebp),%eax
80101dba:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101dbc:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101dc0:	8b 03                	mov    (%ebx),%eax
80101dc2:	e8 19 f6 ff ff       	call   801013e0 <iget>
}
80101dc7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dca:	5b                   	pop    %ebx
80101dcb:	5e                   	pop    %esi
80101dcc:	5f                   	pop    %edi
80101dcd:	5d                   	pop    %ebp
80101dce:	c3                   	ret    
      panic("dirlookup read");
80101dcf:	83 ec 0c             	sub    $0xc,%esp
80101dd2:	68 03 72 10 80       	push   $0x80107203
80101dd7:	e8 84 e6 ff ff       	call   80100460 <panic>
    panic("dirlookup not DIR");
80101ddc:	83 ec 0c             	sub    $0xc,%esp
80101ddf:	68 f1 71 10 80       	push   $0x801071f1
80101de4:	e8 77 e6 ff ff       	call   80100460 <panic>
80101de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101df0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101df0:	55                   	push   %ebp
80101df1:	89 e5                	mov    %esp,%ebp
80101df3:	57                   	push   %edi
80101df4:	56                   	push   %esi
80101df5:	53                   	push   %ebx
80101df6:	89 cf                	mov    %ecx,%edi
80101df8:	89 c3                	mov    %eax,%ebx
80101dfa:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101dfd:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101e00:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101e03:	0f 84 67 01 00 00    	je     80101f70 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101e09:	e8 62 1b 00 00       	call   80103970 <myproc>
  acquire(&icache.lock);
80101e0e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101e11:	8b 70 6c             	mov    0x6c(%eax),%esi
  acquire(&icache.lock);
80101e14:	68 20 0a 11 80       	push   $0x80110a20
80101e19:	e8 b2 26 00 00       	call   801044d0 <acquire>
  ip->ref++;
80101e1e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101e22:	c7 04 24 20 0a 11 80 	movl   $0x80110a20,(%esp)
80101e29:	e8 62 27 00 00       	call   80104590 <release>
80101e2e:	83 c4 10             	add    $0x10,%esp
80101e31:	eb 08                	jmp    80101e3b <namex+0x4b>
80101e33:	90                   	nop
80101e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101e38:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e3b:	0f b6 03             	movzbl (%ebx),%eax
80101e3e:	3c 2f                	cmp    $0x2f,%al
80101e40:	74 f6                	je     80101e38 <namex+0x48>
  if(*path == 0)
80101e42:	84 c0                	test   %al,%al
80101e44:	0f 84 ee 00 00 00    	je     80101f38 <namex+0x148>
  while(*path != '/' && *path != 0)
80101e4a:	0f b6 03             	movzbl (%ebx),%eax
80101e4d:	3c 2f                	cmp    $0x2f,%al
80101e4f:	0f 84 b3 00 00 00    	je     80101f08 <namex+0x118>
80101e55:	84 c0                	test   %al,%al
80101e57:	89 da                	mov    %ebx,%edx
80101e59:	75 09                	jne    80101e64 <namex+0x74>
80101e5b:	e9 a8 00 00 00       	jmp    80101f08 <namex+0x118>
80101e60:	84 c0                	test   %al,%al
80101e62:	74 0a                	je     80101e6e <namex+0x7e>
    path++;
80101e64:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101e67:	0f b6 02             	movzbl (%edx),%eax
80101e6a:	3c 2f                	cmp    $0x2f,%al
80101e6c:	75 f2                	jne    80101e60 <namex+0x70>
80101e6e:	89 d1                	mov    %edx,%ecx
80101e70:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101e72:	83 f9 0d             	cmp    $0xd,%ecx
80101e75:	0f 8e 91 00 00 00    	jle    80101f0c <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101e7b:	83 ec 04             	sub    $0x4,%esp
80101e7e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101e81:	6a 0e                	push   $0xe
80101e83:	53                   	push   %ebx
80101e84:	57                   	push   %edi
80101e85:	e8 06 28 00 00       	call   80104690 <memmove>
    path++;
80101e8a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101e8d:	83 c4 10             	add    $0x10,%esp
    path++;
80101e90:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101e92:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101e95:	75 11                	jne    80101ea8 <namex+0xb8>
80101e97:	89 f6                	mov    %esi,%esi
80101e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101ea0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101ea3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101ea6:	74 f8                	je     80101ea0 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101ea8:	83 ec 0c             	sub    $0xc,%esp
80101eab:	56                   	push   %esi
80101eac:	e8 1f f9 ff ff       	call   801017d0 <ilock>
    if(ip->type != T_DIR){
80101eb1:	83 c4 10             	add    $0x10,%esp
80101eb4:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101eb9:	0f 85 91 00 00 00    	jne    80101f50 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101ebf:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101ec2:	85 d2                	test   %edx,%edx
80101ec4:	74 09                	je     80101ecf <namex+0xdf>
80101ec6:	80 3b 00             	cmpb   $0x0,(%ebx)
80101ec9:	0f 84 b7 00 00 00    	je     80101f86 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101ecf:	83 ec 04             	sub    $0x4,%esp
80101ed2:	6a 00                	push   $0x0
80101ed4:	57                   	push   %edi
80101ed5:	56                   	push   %esi
80101ed6:	e8 65 fe ff ff       	call   80101d40 <dirlookup>
80101edb:	83 c4 10             	add    $0x10,%esp
80101ede:	85 c0                	test   %eax,%eax
80101ee0:	74 6e                	je     80101f50 <namex+0x160>
  iunlock(ip);
80101ee2:	83 ec 0c             	sub    $0xc,%esp
80101ee5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101ee8:	56                   	push   %esi
80101ee9:	e8 c2 f9 ff ff       	call   801018b0 <iunlock>
  iput(ip);
80101eee:	89 34 24             	mov    %esi,(%esp)
80101ef1:	e8 0a fa ff ff       	call   80101900 <iput>
80101ef6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101ef9:	83 c4 10             	add    $0x10,%esp
80101efc:	89 c6                	mov    %eax,%esi
80101efe:	e9 38 ff ff ff       	jmp    80101e3b <namex+0x4b>
80101f03:	90                   	nop
80101f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101f08:	89 da                	mov    %ebx,%edx
80101f0a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101f0c:	83 ec 04             	sub    $0x4,%esp
80101f0f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101f12:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101f15:	51                   	push   %ecx
80101f16:	53                   	push   %ebx
80101f17:	57                   	push   %edi
80101f18:	e8 73 27 00 00       	call   80104690 <memmove>
    name[len] = 0;
80101f1d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101f20:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101f23:	83 c4 10             	add    $0x10,%esp
80101f26:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101f2a:	89 d3                	mov    %edx,%ebx
80101f2c:	e9 61 ff ff ff       	jmp    80101e92 <namex+0xa2>
80101f31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101f38:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101f3b:	85 c0                	test   %eax,%eax
80101f3d:	75 5d                	jne    80101f9c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101f3f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f42:	89 f0                	mov    %esi,%eax
80101f44:	5b                   	pop    %ebx
80101f45:	5e                   	pop    %esi
80101f46:	5f                   	pop    %edi
80101f47:	5d                   	pop    %ebp
80101f48:	c3                   	ret    
80101f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101f50:	83 ec 0c             	sub    $0xc,%esp
80101f53:	56                   	push   %esi
80101f54:	e8 57 f9 ff ff       	call   801018b0 <iunlock>
  iput(ip);
80101f59:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101f5c:	31 f6                	xor    %esi,%esi
  iput(ip);
80101f5e:	e8 9d f9 ff ff       	call   80101900 <iput>
      return 0;
80101f63:	83 c4 10             	add    $0x10,%esp
}
80101f66:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f69:	89 f0                	mov    %esi,%eax
80101f6b:	5b                   	pop    %ebx
80101f6c:	5e                   	pop    %esi
80101f6d:	5f                   	pop    %edi
80101f6e:	5d                   	pop    %ebp
80101f6f:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101f70:	ba 01 00 00 00       	mov    $0x1,%edx
80101f75:	b8 01 00 00 00       	mov    $0x1,%eax
80101f7a:	e8 61 f4 ff ff       	call   801013e0 <iget>
80101f7f:	89 c6                	mov    %eax,%esi
80101f81:	e9 b5 fe ff ff       	jmp    80101e3b <namex+0x4b>
      iunlock(ip);
80101f86:	83 ec 0c             	sub    $0xc,%esp
80101f89:	56                   	push   %esi
80101f8a:	e8 21 f9 ff ff       	call   801018b0 <iunlock>
      return ip;
80101f8f:	83 c4 10             	add    $0x10,%esp
}
80101f92:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f95:	89 f0                	mov    %esi,%eax
80101f97:	5b                   	pop    %ebx
80101f98:	5e                   	pop    %esi
80101f99:	5f                   	pop    %edi
80101f9a:	5d                   	pop    %ebp
80101f9b:	c3                   	ret    
    iput(ip);
80101f9c:	83 ec 0c             	sub    $0xc,%esp
80101f9f:	56                   	push   %esi
    return 0;
80101fa0:	31 f6                	xor    %esi,%esi
    iput(ip);
80101fa2:	e8 59 f9 ff ff       	call   80101900 <iput>
    return 0;
80101fa7:	83 c4 10             	add    $0x10,%esp
80101faa:	eb 93                	jmp    80101f3f <namex+0x14f>
80101fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101fb0 <dirlink>:
{
80101fb0:	55                   	push   %ebp
80101fb1:	89 e5                	mov    %esp,%ebp
80101fb3:	57                   	push   %edi
80101fb4:	56                   	push   %esi
80101fb5:	53                   	push   %ebx
80101fb6:	83 ec 20             	sub    $0x20,%esp
80101fb9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101fbc:	6a 00                	push   $0x0
80101fbe:	ff 75 0c             	pushl  0xc(%ebp)
80101fc1:	53                   	push   %ebx
80101fc2:	e8 79 fd ff ff       	call   80101d40 <dirlookup>
80101fc7:	83 c4 10             	add    $0x10,%esp
80101fca:	85 c0                	test   %eax,%eax
80101fcc:	75 67                	jne    80102035 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101fce:	8b 7b 58             	mov    0x58(%ebx),%edi
80101fd1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101fd4:	85 ff                	test   %edi,%edi
80101fd6:	74 29                	je     80102001 <dirlink+0x51>
80101fd8:	31 ff                	xor    %edi,%edi
80101fda:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101fdd:	eb 09                	jmp    80101fe8 <dirlink+0x38>
80101fdf:	90                   	nop
80101fe0:	83 c7 10             	add    $0x10,%edi
80101fe3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101fe6:	73 19                	jae    80102001 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fe8:	6a 10                	push   $0x10
80101fea:	57                   	push   %edi
80101feb:	56                   	push   %esi
80101fec:	53                   	push   %ebx
80101fed:	e8 be fa ff ff       	call   80101ab0 <readi>
80101ff2:	83 c4 10             	add    $0x10,%esp
80101ff5:	83 f8 10             	cmp    $0x10,%eax
80101ff8:	75 4e                	jne    80102048 <dirlink+0x98>
    if(de.inum == 0)
80101ffa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101fff:	75 df                	jne    80101fe0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102001:	8d 45 da             	lea    -0x26(%ebp),%eax
80102004:	83 ec 04             	sub    $0x4,%esp
80102007:	6a 0e                	push   $0xe
80102009:	ff 75 0c             	pushl  0xc(%ebp)
8010200c:	50                   	push   %eax
8010200d:	e8 4e 27 00 00       	call   80104760 <strncpy>
  de.inum = inum;
80102012:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102015:	6a 10                	push   $0x10
80102017:	57                   	push   %edi
80102018:	56                   	push   %esi
80102019:	53                   	push   %ebx
  de.inum = inum;
8010201a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010201e:	e8 cd fb ff ff       	call   80101bf0 <writei>
80102023:	83 c4 20             	add    $0x20,%esp
80102026:	83 f8 10             	cmp    $0x10,%eax
80102029:	75 2a                	jne    80102055 <dirlink+0xa5>
  return 0;
8010202b:	31 c0                	xor    %eax,%eax
}
8010202d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102030:	5b                   	pop    %ebx
80102031:	5e                   	pop    %esi
80102032:	5f                   	pop    %edi
80102033:	5d                   	pop    %ebp
80102034:	c3                   	ret    
    iput(ip);
80102035:	83 ec 0c             	sub    $0xc,%esp
80102038:	50                   	push   %eax
80102039:	e8 c2 f8 ff ff       	call   80101900 <iput>
    return -1;
8010203e:	83 c4 10             	add    $0x10,%esp
80102041:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102046:	eb e5                	jmp    8010202d <dirlink+0x7d>
      panic("dirlink read");
80102048:	83 ec 0c             	sub    $0xc,%esp
8010204b:	68 12 72 10 80       	push   $0x80107212
80102050:	e8 0b e4 ff ff       	call   80100460 <panic>
    panic("dirlink");
80102055:	83 ec 0c             	sub    $0xc,%esp
80102058:	68 06 78 10 80       	push   $0x80107806
8010205d:	e8 fe e3 ff ff       	call   80100460 <panic>
80102062:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102070 <namei>:

struct inode*
namei(char *path)
{
80102070:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102071:	31 d2                	xor    %edx,%edx
{
80102073:	89 e5                	mov    %esp,%ebp
80102075:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102078:	8b 45 08             	mov    0x8(%ebp),%eax
8010207b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010207e:	e8 6d fd ff ff       	call   80101df0 <namex>
}
80102083:	c9                   	leave  
80102084:	c3                   	ret    
80102085:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102090 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102090:	55                   	push   %ebp
  return namex(path, 1, name);
80102091:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102096:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102098:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010209b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010209e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010209f:	e9 4c fd ff ff       	jmp    80101df0 <namex>
801020a4:	66 90                	xchg   %ax,%ax
801020a6:	66 90                	xchg   %ax,%ax
801020a8:	66 90                	xchg   %ax,%ax
801020aa:	66 90                	xchg   %ax,%ax
801020ac:	66 90                	xchg   %ax,%ax
801020ae:	66 90                	xchg   %ax,%ax

801020b0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801020b0:	55                   	push   %ebp
801020b1:	89 e5                	mov    %esp,%ebp
801020b3:	57                   	push   %edi
801020b4:	56                   	push   %esi
801020b5:	53                   	push   %ebx
801020b6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801020b9:	85 c0                	test   %eax,%eax
801020bb:	0f 84 b4 00 00 00    	je     80102175 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801020c1:	8b 58 08             	mov    0x8(%eax),%ebx
801020c4:	89 c6                	mov    %eax,%esi
801020c6:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
801020cc:	0f 87 96 00 00 00    	ja     80102168 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020d2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801020d7:	89 f6                	mov    %esi,%esi
801020d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020e0:	89 ca                	mov    %ecx,%edx
801020e2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020e3:	83 e0 c0             	and    $0xffffffc0,%eax
801020e6:	3c 40                	cmp    $0x40,%al
801020e8:	75 f6                	jne    801020e0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801020ea:	31 ff                	xor    %edi,%edi
801020ec:	ba f6 03 00 00       	mov    $0x3f6,%edx
801020f1:	89 f8                	mov    %edi,%eax
801020f3:	ee                   	out    %al,(%dx)
801020f4:	b8 01 00 00 00       	mov    $0x1,%eax
801020f9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801020fe:	ee                   	out    %al,(%dx)
801020ff:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102104:	89 d8                	mov    %ebx,%eax
80102106:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102107:	89 d8                	mov    %ebx,%eax
80102109:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010210e:	c1 f8 08             	sar    $0x8,%eax
80102111:	ee                   	out    %al,(%dx)
80102112:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102117:	89 f8                	mov    %edi,%eax
80102119:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010211a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
8010211e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102123:	c1 e0 04             	shl    $0x4,%eax
80102126:	83 e0 10             	and    $0x10,%eax
80102129:	83 c8 e0             	or     $0xffffffe0,%eax
8010212c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010212d:	f6 06 04             	testb  $0x4,(%esi)
80102130:	75 16                	jne    80102148 <idestart+0x98>
80102132:	b8 20 00 00 00       	mov    $0x20,%eax
80102137:	89 ca                	mov    %ecx,%edx
80102139:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010213a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010213d:	5b                   	pop    %ebx
8010213e:	5e                   	pop    %esi
8010213f:	5f                   	pop    %edi
80102140:	5d                   	pop    %ebp
80102141:	c3                   	ret    
80102142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102148:	b8 30 00 00 00       	mov    $0x30,%eax
8010214d:	89 ca                	mov    %ecx,%edx
8010214f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102150:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102155:	83 c6 5c             	add    $0x5c,%esi
80102158:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010215d:	fc                   	cld    
8010215e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102160:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102163:	5b                   	pop    %ebx
80102164:	5e                   	pop    %esi
80102165:	5f                   	pop    %edi
80102166:	5d                   	pop    %ebp
80102167:	c3                   	ret    
    panic("incorrect blockno");
80102168:	83 ec 0c             	sub    $0xc,%esp
8010216b:	68 7c 72 10 80       	push   $0x8010727c
80102170:	e8 eb e2 ff ff       	call   80100460 <panic>
    panic("idestart");
80102175:	83 ec 0c             	sub    $0xc,%esp
80102178:	68 73 72 10 80       	push   $0x80107273
8010217d:	e8 de e2 ff ff       	call   80100460 <panic>
80102182:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102190 <ideinit>:
{
80102190:	55                   	push   %ebp
80102191:	89 e5                	mov    %esp,%ebp
80102193:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102196:	68 8e 72 10 80       	push   $0x8010728e
8010219b:	68 a0 a5 10 80       	push   $0x8010a5a0
801021a0:	e8 eb 21 00 00       	call   80104390 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801021a5:	58                   	pop    %eax
801021a6:	a1 40 2d 11 80       	mov    0x80112d40,%eax
801021ab:	5a                   	pop    %edx
801021ac:	83 e8 01             	sub    $0x1,%eax
801021af:	50                   	push   %eax
801021b0:	6a 0e                	push   $0xe
801021b2:	e8 a9 02 00 00       	call   80102460 <ioapicenable>
801021b7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021ba:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021bf:	90                   	nop
801021c0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021c1:	83 e0 c0             	and    $0xffffffc0,%eax
801021c4:	3c 40                	cmp    $0x40,%al
801021c6:	75 f8                	jne    801021c0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021c8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801021cd:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021d2:	ee                   	out    %al,(%dx)
801021d3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021d8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021dd:	eb 06                	jmp    801021e5 <ideinit+0x55>
801021df:	90                   	nop
  for(i=0; i<1000; i++){
801021e0:	83 e9 01             	sub    $0x1,%ecx
801021e3:	74 0f                	je     801021f4 <ideinit+0x64>
801021e5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801021e6:	84 c0                	test   %al,%al
801021e8:	74 f6                	je     801021e0 <ideinit+0x50>
      havedisk1 = 1;
801021ea:	c7 05 80 a5 10 80 01 	movl   $0x1,0x8010a580
801021f1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021f4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801021f9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021fe:	ee                   	out    %al,(%dx)
}
801021ff:	c9                   	leave  
80102200:	c3                   	ret    
80102201:	eb 0d                	jmp    80102210 <ideintr>
80102203:	90                   	nop
80102204:	90                   	nop
80102205:	90                   	nop
80102206:	90                   	nop
80102207:	90                   	nop
80102208:	90                   	nop
80102209:	90                   	nop
8010220a:	90                   	nop
8010220b:	90                   	nop
8010220c:	90                   	nop
8010220d:	90                   	nop
8010220e:	90                   	nop
8010220f:	90                   	nop

80102210 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102210:	55                   	push   %ebp
80102211:	89 e5                	mov    %esp,%ebp
80102213:	57                   	push   %edi
80102214:	56                   	push   %esi
80102215:	53                   	push   %ebx
80102216:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102219:	68 a0 a5 10 80       	push   $0x8010a5a0
8010221e:	e8 ad 22 00 00       	call   801044d0 <acquire>

  if((b = idequeue) == 0){
80102223:	8b 1d 84 a5 10 80    	mov    0x8010a584,%ebx
80102229:	83 c4 10             	add    $0x10,%esp
8010222c:	85 db                	test   %ebx,%ebx
8010222e:	74 67                	je     80102297 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102230:	8b 43 58             	mov    0x58(%ebx),%eax
80102233:	a3 84 a5 10 80       	mov    %eax,0x8010a584

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102238:	8b 3b                	mov    (%ebx),%edi
8010223a:	f7 c7 04 00 00 00    	test   $0x4,%edi
80102240:	75 31                	jne    80102273 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102242:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102247:	89 f6                	mov    %esi,%esi
80102249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102250:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102251:	89 c6                	mov    %eax,%esi
80102253:	83 e6 c0             	and    $0xffffffc0,%esi
80102256:	89 f1                	mov    %esi,%ecx
80102258:	80 f9 40             	cmp    $0x40,%cl
8010225b:	75 f3                	jne    80102250 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010225d:	a8 21                	test   $0x21,%al
8010225f:	75 12                	jne    80102273 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
80102261:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102264:	b9 80 00 00 00       	mov    $0x80,%ecx
80102269:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010226e:	fc                   	cld    
8010226f:	f3 6d                	rep insl (%dx),%es:(%edi)
80102271:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102273:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
80102276:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102279:	89 f9                	mov    %edi,%ecx
8010227b:	83 c9 02             	or     $0x2,%ecx
8010227e:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102280:	53                   	push   %ebx
80102281:	e8 3a 1e 00 00       	call   801040c0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102286:	a1 84 a5 10 80       	mov    0x8010a584,%eax
8010228b:	83 c4 10             	add    $0x10,%esp
8010228e:	85 c0                	test   %eax,%eax
80102290:	74 05                	je     80102297 <ideintr+0x87>
    idestart(idequeue);
80102292:	e8 19 fe ff ff       	call   801020b0 <idestart>
    release(&idelock);
80102297:	83 ec 0c             	sub    $0xc,%esp
8010229a:	68 a0 a5 10 80       	push   $0x8010a5a0
8010229f:	e8 ec 22 00 00       	call   80104590 <release>

  release(&idelock);
}
801022a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022a7:	5b                   	pop    %ebx
801022a8:	5e                   	pop    %esi
801022a9:	5f                   	pop    %edi
801022aa:	5d                   	pop    %ebp
801022ab:	c3                   	ret    
801022ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801022b0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801022b0:	55                   	push   %ebp
801022b1:	89 e5                	mov    %esp,%ebp
801022b3:	53                   	push   %ebx
801022b4:	83 ec 10             	sub    $0x10,%esp
801022b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801022ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801022bd:	50                   	push   %eax
801022be:	e8 7d 20 00 00       	call   80104340 <holdingsleep>
801022c3:	83 c4 10             	add    $0x10,%esp
801022c6:	85 c0                	test   %eax,%eax
801022c8:	0f 84 c6 00 00 00    	je     80102394 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801022ce:	8b 03                	mov    (%ebx),%eax
801022d0:	83 e0 06             	and    $0x6,%eax
801022d3:	83 f8 02             	cmp    $0x2,%eax
801022d6:	0f 84 ab 00 00 00    	je     80102387 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801022dc:	8b 53 04             	mov    0x4(%ebx),%edx
801022df:	85 d2                	test   %edx,%edx
801022e1:	74 0d                	je     801022f0 <iderw+0x40>
801022e3:	a1 80 a5 10 80       	mov    0x8010a580,%eax
801022e8:	85 c0                	test   %eax,%eax
801022ea:	0f 84 b1 00 00 00    	je     801023a1 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801022f0:	83 ec 0c             	sub    $0xc,%esp
801022f3:	68 a0 a5 10 80       	push   $0x8010a5a0
801022f8:	e8 d3 21 00 00       	call   801044d0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022fd:	8b 15 84 a5 10 80    	mov    0x8010a584,%edx
80102303:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102306:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010230d:	85 d2                	test   %edx,%edx
8010230f:	75 09                	jne    8010231a <iderw+0x6a>
80102311:	eb 6d                	jmp    80102380 <iderw+0xd0>
80102313:	90                   	nop
80102314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102318:	89 c2                	mov    %eax,%edx
8010231a:	8b 42 58             	mov    0x58(%edx),%eax
8010231d:	85 c0                	test   %eax,%eax
8010231f:	75 f7                	jne    80102318 <iderw+0x68>
80102321:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102324:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102326:	39 1d 84 a5 10 80    	cmp    %ebx,0x8010a584
8010232c:	74 42                	je     80102370 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010232e:	8b 03                	mov    (%ebx),%eax
80102330:	83 e0 06             	and    $0x6,%eax
80102333:	83 f8 02             	cmp    $0x2,%eax
80102336:	74 23                	je     8010235b <iderw+0xab>
80102338:	90                   	nop
80102339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102340:	83 ec 08             	sub    $0x8,%esp
80102343:	68 a0 a5 10 80       	push   $0x8010a5a0
80102348:	53                   	push   %ebx
80102349:	e8 c2 1b 00 00       	call   80103f10 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010234e:	8b 03                	mov    (%ebx),%eax
80102350:	83 c4 10             	add    $0x10,%esp
80102353:	83 e0 06             	and    $0x6,%eax
80102356:	83 f8 02             	cmp    $0x2,%eax
80102359:	75 e5                	jne    80102340 <iderw+0x90>
  }


  release(&idelock);
8010235b:	c7 45 08 a0 a5 10 80 	movl   $0x8010a5a0,0x8(%ebp)
}
80102362:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102365:	c9                   	leave  
  release(&idelock);
80102366:	e9 25 22 00 00       	jmp    80104590 <release>
8010236b:	90                   	nop
8010236c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102370:	89 d8                	mov    %ebx,%eax
80102372:	e8 39 fd ff ff       	call   801020b0 <idestart>
80102377:	eb b5                	jmp    8010232e <iderw+0x7e>
80102379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102380:	ba 84 a5 10 80       	mov    $0x8010a584,%edx
80102385:	eb 9d                	jmp    80102324 <iderw+0x74>
    panic("iderw: nothing to do");
80102387:	83 ec 0c             	sub    $0xc,%esp
8010238a:	68 a8 72 10 80       	push   $0x801072a8
8010238f:	e8 cc e0 ff ff       	call   80100460 <panic>
    panic("iderw: buf not locked");
80102394:	83 ec 0c             	sub    $0xc,%esp
80102397:	68 92 72 10 80       	push   $0x80107292
8010239c:	e8 bf e0 ff ff       	call   80100460 <panic>
    panic("iderw: ide disk 1 not present");
801023a1:	83 ec 0c             	sub    $0xc,%esp
801023a4:	68 bd 72 10 80       	push   $0x801072bd
801023a9:	e8 b2 e0 ff ff       	call   80100460 <panic>
801023ae:	66 90                	xchg   %ax,%ax

801023b0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801023b0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801023b1:	c7 05 74 26 11 80 00 	movl   $0xfec00000,0x80112674
801023b8:	00 c0 fe 
{
801023bb:	89 e5                	mov    %esp,%ebp
801023bd:	56                   	push   %esi
801023be:	53                   	push   %ebx
  ioapic->reg = reg;
801023bf:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801023c6:	00 00 00 
  return ioapic->data;
801023c9:	a1 74 26 11 80       	mov    0x80112674,%eax
801023ce:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
801023d1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
801023d7:	8b 0d 74 26 11 80    	mov    0x80112674,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801023dd:	0f b6 15 a0 27 11 80 	movzbl 0x801127a0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801023e4:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
801023e7:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801023ea:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
801023ed:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801023f0:	39 c2                	cmp    %eax,%edx
801023f2:	74 16                	je     8010240a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801023f4:	83 ec 0c             	sub    $0xc,%esp
801023f7:	68 dc 72 10 80       	push   $0x801072dc
801023fc:	e8 2f e3 ff ff       	call   80100730 <cprintf>
80102401:	8b 0d 74 26 11 80    	mov    0x80112674,%ecx
80102407:	83 c4 10             	add    $0x10,%esp
8010240a:	83 c3 21             	add    $0x21,%ebx
{
8010240d:	ba 10 00 00 00       	mov    $0x10,%edx
80102412:	b8 20 00 00 00       	mov    $0x20,%eax
80102417:	89 f6                	mov    %esi,%esi
80102419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102420:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102422:	8b 0d 74 26 11 80    	mov    0x80112674,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102428:	89 c6                	mov    %eax,%esi
8010242a:	81 ce 00 00 01 00    	or     $0x10000,%esi
80102430:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102433:	89 71 10             	mov    %esi,0x10(%ecx)
80102436:	8d 72 01             	lea    0x1(%edx),%esi
80102439:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
8010243c:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
8010243e:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
80102440:	8b 0d 74 26 11 80    	mov    0x80112674,%ecx
80102446:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010244d:	75 d1                	jne    80102420 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010244f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102452:	5b                   	pop    %ebx
80102453:	5e                   	pop    %esi
80102454:	5d                   	pop    %ebp
80102455:	c3                   	ret    
80102456:	8d 76 00             	lea    0x0(%esi),%esi
80102459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102460 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102460:	55                   	push   %ebp
  ioapic->reg = reg;
80102461:	8b 0d 74 26 11 80    	mov    0x80112674,%ecx
{
80102467:	89 e5                	mov    %esp,%ebp
80102469:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010246c:	8d 50 20             	lea    0x20(%eax),%edx
8010246f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102473:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102475:	8b 0d 74 26 11 80    	mov    0x80112674,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010247b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010247e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102481:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102484:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102486:	a1 74 26 11 80       	mov    0x80112674,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010248b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010248e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102491:	5d                   	pop    %ebp
80102492:	c3                   	ret    
80102493:	66 90                	xchg   %ax,%ax
80102495:	66 90                	xchg   %ax,%ax
80102497:	66 90                	xchg   %ax,%ax
80102499:	66 90                	xchg   %ax,%ax
8010249b:	66 90                	xchg   %ax,%ax
8010249d:	66 90                	xchg   %ax,%ax
8010249f:	90                   	nop

801024a0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801024a0:	55                   	push   %ebp
801024a1:	89 e5                	mov    %esp,%ebp
801024a3:	53                   	push   %ebx
801024a4:	83 ec 04             	sub    $0x4,%esp
801024a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801024aa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801024b0:	75 70                	jne    80102522 <kfree+0x82>
801024b2:	81 fb e8 55 11 80    	cmp    $0x801155e8,%ebx
801024b8:	72 68                	jb     80102522 <kfree+0x82>
801024ba:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801024c0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801024c5:	77 5b                	ja     80102522 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801024c7:	83 ec 04             	sub    $0x4,%esp
801024ca:	68 00 10 00 00       	push   $0x1000
801024cf:	6a 01                	push   $0x1
801024d1:	53                   	push   %ebx
801024d2:	e8 09 21 00 00       	call   801045e0 <memset>

  if(kmem.use_lock)
801024d7:	8b 15 b4 26 11 80    	mov    0x801126b4,%edx
801024dd:	83 c4 10             	add    $0x10,%esp
801024e0:	85 d2                	test   %edx,%edx
801024e2:	75 2c                	jne    80102510 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801024e4:	a1 b8 26 11 80       	mov    0x801126b8,%eax
801024e9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801024eb:	a1 b4 26 11 80       	mov    0x801126b4,%eax
  kmem.freelist = r;
801024f0:	89 1d b8 26 11 80    	mov    %ebx,0x801126b8
  if(kmem.use_lock)
801024f6:	85 c0                	test   %eax,%eax
801024f8:	75 06                	jne    80102500 <kfree+0x60>
    release(&kmem.lock);
}
801024fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024fd:	c9                   	leave  
801024fe:	c3                   	ret    
801024ff:	90                   	nop
    release(&kmem.lock);
80102500:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102507:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010250a:	c9                   	leave  
    release(&kmem.lock);
8010250b:	e9 80 20 00 00       	jmp    80104590 <release>
    acquire(&kmem.lock);
80102510:	83 ec 0c             	sub    $0xc,%esp
80102513:	68 80 26 11 80       	push   $0x80112680
80102518:	e8 b3 1f 00 00       	call   801044d0 <acquire>
8010251d:	83 c4 10             	add    $0x10,%esp
80102520:	eb c2                	jmp    801024e4 <kfree+0x44>
    panic("kfree");
80102522:	83 ec 0c             	sub    $0xc,%esp
80102525:	68 0e 73 10 80       	push   $0x8010730e
8010252a:	e8 31 df ff ff       	call   80100460 <panic>
8010252f:	90                   	nop

80102530 <freerange>:
{
80102530:	55                   	push   %ebp
80102531:	89 e5                	mov    %esp,%ebp
80102533:	56                   	push   %esi
80102534:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102535:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102538:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010253b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102541:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102547:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010254d:	39 de                	cmp    %ebx,%esi
8010254f:	72 23                	jb     80102574 <freerange+0x44>
80102551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102558:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010255e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102561:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102567:	50                   	push   %eax
80102568:	e8 33 ff ff ff       	call   801024a0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010256d:	83 c4 10             	add    $0x10,%esp
80102570:	39 f3                	cmp    %esi,%ebx
80102572:	76 e4                	jbe    80102558 <freerange+0x28>
}
80102574:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102577:	5b                   	pop    %ebx
80102578:	5e                   	pop    %esi
80102579:	5d                   	pop    %ebp
8010257a:	c3                   	ret    
8010257b:	90                   	nop
8010257c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102580 <kinit1>:
{
80102580:	55                   	push   %ebp
80102581:	89 e5                	mov    %esp,%ebp
80102583:	56                   	push   %esi
80102584:	53                   	push   %ebx
80102585:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102588:	83 ec 08             	sub    $0x8,%esp
8010258b:	68 14 73 10 80       	push   $0x80107314
80102590:	68 80 26 11 80       	push   $0x80112680
80102595:	e8 f6 1d 00 00       	call   80104390 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010259a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010259d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801025a0:	c7 05 b4 26 11 80 00 	movl   $0x0,0x801126b4
801025a7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801025aa:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025b0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025b6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025bc:	39 de                	cmp    %ebx,%esi
801025be:	72 1c                	jb     801025dc <kinit1+0x5c>
    kfree(p);
801025c0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801025c6:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025c9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025cf:	50                   	push   %eax
801025d0:	e8 cb fe ff ff       	call   801024a0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025d5:	83 c4 10             	add    $0x10,%esp
801025d8:	39 de                	cmp    %ebx,%esi
801025da:	73 e4                	jae    801025c0 <kinit1+0x40>
}
801025dc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025df:	5b                   	pop    %ebx
801025e0:	5e                   	pop    %esi
801025e1:	5d                   	pop    %ebp
801025e2:	c3                   	ret    
801025e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801025e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025f0 <kinit2>:
{
801025f0:	55                   	push   %ebp
801025f1:	89 e5                	mov    %esp,%ebp
801025f3:	56                   	push   %esi
801025f4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801025f5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801025f8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801025fb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102601:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102607:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010260d:	39 de                	cmp    %ebx,%esi
8010260f:	72 23                	jb     80102634 <kinit2+0x44>
80102611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102618:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010261e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102621:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102627:	50                   	push   %eax
80102628:	e8 73 fe ff ff       	call   801024a0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010262d:	83 c4 10             	add    $0x10,%esp
80102630:	39 de                	cmp    %ebx,%esi
80102632:	73 e4                	jae    80102618 <kinit2+0x28>
  kmem.use_lock = 1;
80102634:	c7 05 b4 26 11 80 01 	movl   $0x1,0x801126b4
8010263b:	00 00 00 
}
8010263e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102641:	5b                   	pop    %ebx
80102642:	5e                   	pop    %esi
80102643:	5d                   	pop    %ebp
80102644:	c3                   	ret    
80102645:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102650 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102650:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102655:	85 c0                	test   %eax,%eax
80102657:	75 1f                	jne    80102678 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102659:	a1 b8 26 11 80       	mov    0x801126b8,%eax
  if(r)
8010265e:	85 c0                	test   %eax,%eax
80102660:	74 0e                	je     80102670 <kalloc+0x20>
    kmem.freelist = r->next;
80102662:	8b 10                	mov    (%eax),%edx
80102664:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
8010266a:	c3                   	ret    
8010266b:	90                   	nop
8010266c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102670:	f3 c3                	repz ret 
80102672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
80102678:	55                   	push   %ebp
80102679:	89 e5                	mov    %esp,%ebp
8010267b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010267e:	68 80 26 11 80       	push   $0x80112680
80102683:	e8 48 1e 00 00       	call   801044d0 <acquire>
  r = kmem.freelist;
80102688:	a1 b8 26 11 80       	mov    0x801126b8,%eax
  if(r)
8010268d:	83 c4 10             	add    $0x10,%esp
80102690:	8b 15 b4 26 11 80    	mov    0x801126b4,%edx
80102696:	85 c0                	test   %eax,%eax
80102698:	74 08                	je     801026a2 <kalloc+0x52>
    kmem.freelist = r->next;
8010269a:	8b 08                	mov    (%eax),%ecx
8010269c:	89 0d b8 26 11 80    	mov    %ecx,0x801126b8
  if(kmem.use_lock)
801026a2:	85 d2                	test   %edx,%edx
801026a4:	74 16                	je     801026bc <kalloc+0x6c>
    release(&kmem.lock);
801026a6:	83 ec 0c             	sub    $0xc,%esp
801026a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801026ac:	68 80 26 11 80       	push   $0x80112680
801026b1:	e8 da 1e 00 00       	call   80104590 <release>
  return (char*)r;
801026b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
801026b9:	83 c4 10             	add    $0x10,%esp
}
801026bc:	c9                   	leave  
801026bd:	c3                   	ret    
801026be:	66 90                	xchg   %ax,%ax

801026c0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026c0:	ba 64 00 00 00       	mov    $0x64,%edx
801026c5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801026c6:	a8 01                	test   $0x1,%al
801026c8:	0f 84 c2 00 00 00    	je     80102790 <kbdgetc+0xd0>
801026ce:	ba 60 00 00 00       	mov    $0x60,%edx
801026d3:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801026d4:	0f b6 d0             	movzbl %al,%edx
801026d7:	8b 0d d4 a5 10 80    	mov    0x8010a5d4,%ecx

  if(data == 0xE0){
801026dd:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
801026e3:	0f 84 7f 00 00 00    	je     80102768 <kbdgetc+0xa8>
{
801026e9:	55                   	push   %ebp
801026ea:	89 e5                	mov    %esp,%ebp
801026ec:	53                   	push   %ebx
801026ed:	89 cb                	mov    %ecx,%ebx
801026ef:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801026f2:	84 c0                	test   %al,%al
801026f4:	78 4a                	js     80102740 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801026f6:	85 db                	test   %ebx,%ebx
801026f8:	74 09                	je     80102703 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801026fa:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801026fd:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102700:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102703:	0f b6 82 40 74 10 80 	movzbl -0x7fef8bc0(%edx),%eax
8010270a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010270c:	0f b6 82 40 73 10 80 	movzbl -0x7fef8cc0(%edx),%eax
80102713:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102715:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102717:	89 0d d4 a5 10 80    	mov    %ecx,0x8010a5d4
  c = charcode[shift & (CTL | SHIFT)][data];
8010271d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102720:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102723:	8b 04 85 20 73 10 80 	mov    -0x7fef8ce0(,%eax,4),%eax
8010272a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010272e:	74 31                	je     80102761 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102730:	8d 50 9f             	lea    -0x61(%eax),%edx
80102733:	83 fa 19             	cmp    $0x19,%edx
80102736:	77 40                	ja     80102778 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102738:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010273b:	5b                   	pop    %ebx
8010273c:	5d                   	pop    %ebp
8010273d:	c3                   	ret    
8010273e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102740:	83 e0 7f             	and    $0x7f,%eax
80102743:	85 db                	test   %ebx,%ebx
80102745:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102748:	0f b6 82 40 74 10 80 	movzbl -0x7fef8bc0(%edx),%eax
8010274f:	83 c8 40             	or     $0x40,%eax
80102752:	0f b6 c0             	movzbl %al,%eax
80102755:	f7 d0                	not    %eax
80102757:	21 c1                	and    %eax,%ecx
    return 0;
80102759:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
8010275b:	89 0d d4 a5 10 80    	mov    %ecx,0x8010a5d4
}
80102761:	5b                   	pop    %ebx
80102762:	5d                   	pop    %ebp
80102763:	c3                   	ret    
80102764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102768:	83 c9 40             	or     $0x40,%ecx
    return 0;
8010276b:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
8010276d:	89 0d d4 a5 10 80    	mov    %ecx,0x8010a5d4
    return 0;
80102773:	c3                   	ret    
80102774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102778:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010277b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010277e:	5b                   	pop    %ebx
      c += 'a' - 'A';
8010277f:	83 f9 1a             	cmp    $0x1a,%ecx
80102782:	0f 42 c2             	cmovb  %edx,%eax
}
80102785:	5d                   	pop    %ebp
80102786:	c3                   	ret    
80102787:	89 f6                	mov    %esi,%esi
80102789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102790:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102795:	c3                   	ret    
80102796:	8d 76 00             	lea    0x0(%esi),%esi
80102799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027a0 <kbdintr>:

void
kbdintr(void)
{
801027a0:	55                   	push   %ebp
801027a1:	89 e5                	mov    %esp,%ebp
801027a3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801027a6:	68 c0 26 10 80       	push   $0x801026c0
801027ab:	e8 30 e1 ff ff       	call   801008e0 <consoleintr>
}
801027b0:	83 c4 10             	add    $0x10,%esp
801027b3:	c9                   	leave  
801027b4:	c3                   	ret    
801027b5:	66 90                	xchg   %ax,%ax
801027b7:	66 90                	xchg   %ax,%ax
801027b9:	66 90                	xchg   %ax,%ax
801027bb:	66 90                	xchg   %ax,%ax
801027bd:	66 90                	xchg   %ax,%ax
801027bf:	90                   	nop

801027c0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801027c0:	a1 bc 26 11 80       	mov    0x801126bc,%eax
{
801027c5:	55                   	push   %ebp
801027c6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801027c8:	85 c0                	test   %eax,%eax
801027ca:	0f 84 c8 00 00 00    	je     80102898 <lapicinit+0xd8>
  lapic[index] = value;
801027d0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801027d7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027da:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027dd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801027e4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027e7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027ea:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801027f1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801027f4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027f7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801027fe:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102801:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102804:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010280b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010280e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102811:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102818:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010281b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010281e:	8b 50 30             	mov    0x30(%eax),%edx
80102821:	c1 ea 10             	shr    $0x10,%edx
80102824:	80 fa 03             	cmp    $0x3,%dl
80102827:	77 77                	ja     801028a0 <lapicinit+0xe0>
  lapic[index] = value;
80102829:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102830:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102833:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102836:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010283d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102840:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102843:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010284a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010284d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102850:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102857:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010285a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010285d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102864:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102867:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010286a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102871:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102874:	8b 50 20             	mov    0x20(%eax),%edx
80102877:	89 f6                	mov    %esi,%esi
80102879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102880:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102886:	80 e6 10             	and    $0x10,%dh
80102889:	75 f5                	jne    80102880 <lapicinit+0xc0>
  lapic[index] = value;
8010288b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102892:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102895:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102898:	5d                   	pop    %ebp
80102899:	c3                   	ret    
8010289a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
801028a0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801028a7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801028aa:	8b 50 20             	mov    0x20(%eax),%edx
801028ad:	e9 77 ff ff ff       	jmp    80102829 <lapicinit+0x69>
801028b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028c0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801028c0:	8b 15 bc 26 11 80    	mov    0x801126bc,%edx
{
801028c6:	55                   	push   %ebp
801028c7:	31 c0                	xor    %eax,%eax
801028c9:	89 e5                	mov    %esp,%ebp
  if (!lapic)
801028cb:	85 d2                	test   %edx,%edx
801028cd:	74 06                	je     801028d5 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
801028cf:	8b 42 20             	mov    0x20(%edx),%eax
801028d2:	c1 e8 18             	shr    $0x18,%eax
}
801028d5:	5d                   	pop    %ebp
801028d6:	c3                   	ret    
801028d7:	89 f6                	mov    %esi,%esi
801028d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028e0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801028e0:	a1 bc 26 11 80       	mov    0x801126bc,%eax
{
801028e5:	55                   	push   %ebp
801028e6:	89 e5                	mov    %esp,%ebp
  if(lapic)
801028e8:	85 c0                	test   %eax,%eax
801028ea:	74 0d                	je     801028f9 <lapiceoi+0x19>
  lapic[index] = value;
801028ec:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801028f3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028f6:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
801028f9:	5d                   	pop    %ebp
801028fa:	c3                   	ret    
801028fb:	90                   	nop
801028fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102900 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102900:	55                   	push   %ebp
80102901:	89 e5                	mov    %esp,%ebp
}
80102903:	5d                   	pop    %ebp
80102904:	c3                   	ret    
80102905:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102910 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102910:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102911:	b8 0f 00 00 00       	mov    $0xf,%eax
80102916:	ba 70 00 00 00       	mov    $0x70,%edx
8010291b:	89 e5                	mov    %esp,%ebp
8010291d:	53                   	push   %ebx
8010291e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102921:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102924:	ee                   	out    %al,(%dx)
80102925:	b8 0a 00 00 00       	mov    $0xa,%eax
8010292a:	ba 71 00 00 00       	mov    $0x71,%edx
8010292f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102930:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102932:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102935:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010293b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010293d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102940:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102943:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102945:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102948:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010294e:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102953:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102959:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010295c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102963:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102966:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102969:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102970:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102973:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102976:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010297c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010297f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102985:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102988:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010298e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102991:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102997:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010299a:	5b                   	pop    %ebx
8010299b:	5d                   	pop    %ebp
8010299c:	c3                   	ret    
8010299d:	8d 76 00             	lea    0x0(%esi),%esi

801029a0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801029a0:	55                   	push   %ebp
801029a1:	b8 0b 00 00 00       	mov    $0xb,%eax
801029a6:	ba 70 00 00 00       	mov    $0x70,%edx
801029ab:	89 e5                	mov    %esp,%ebp
801029ad:	57                   	push   %edi
801029ae:	56                   	push   %esi
801029af:	53                   	push   %ebx
801029b0:	83 ec 4c             	sub    $0x4c,%esp
801029b3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029b4:	ba 71 00 00 00       	mov    $0x71,%edx
801029b9:	ec                   	in     (%dx),%al
801029ba:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029bd:	bb 70 00 00 00       	mov    $0x70,%ebx
801029c2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801029c5:	8d 76 00             	lea    0x0(%esi),%esi
801029c8:	31 c0                	xor    %eax,%eax
801029ca:	89 da                	mov    %ebx,%edx
801029cc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029cd:	b9 71 00 00 00       	mov    $0x71,%ecx
801029d2:	89 ca                	mov    %ecx,%edx
801029d4:	ec                   	in     (%dx),%al
801029d5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d8:	89 da                	mov    %ebx,%edx
801029da:	b8 02 00 00 00       	mov    $0x2,%eax
801029df:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029e0:	89 ca                	mov    %ecx,%edx
801029e2:	ec                   	in     (%dx),%al
801029e3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e6:	89 da                	mov    %ebx,%edx
801029e8:	b8 04 00 00 00       	mov    $0x4,%eax
801029ed:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ee:	89 ca                	mov    %ecx,%edx
801029f0:	ec                   	in     (%dx),%al
801029f1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029f4:	89 da                	mov    %ebx,%edx
801029f6:	b8 07 00 00 00       	mov    $0x7,%eax
801029fb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029fc:	89 ca                	mov    %ecx,%edx
801029fe:	ec                   	in     (%dx),%al
801029ff:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a02:	89 da                	mov    %ebx,%edx
80102a04:	b8 08 00 00 00       	mov    $0x8,%eax
80102a09:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a0a:	89 ca                	mov    %ecx,%edx
80102a0c:	ec                   	in     (%dx),%al
80102a0d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a0f:	89 da                	mov    %ebx,%edx
80102a11:	b8 09 00 00 00       	mov    $0x9,%eax
80102a16:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a17:	89 ca                	mov    %ecx,%edx
80102a19:	ec                   	in     (%dx),%al
80102a1a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a1c:	89 da                	mov    %ebx,%edx
80102a1e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a23:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a24:	89 ca                	mov    %ecx,%edx
80102a26:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102a27:	84 c0                	test   %al,%al
80102a29:	78 9d                	js     801029c8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102a2b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102a2f:	89 fa                	mov    %edi,%edx
80102a31:	0f b6 fa             	movzbl %dl,%edi
80102a34:	89 f2                	mov    %esi,%edx
80102a36:	0f b6 f2             	movzbl %dl,%esi
80102a39:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a3c:	89 da                	mov    %ebx,%edx
80102a3e:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102a41:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102a44:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102a48:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102a4b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102a4f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102a52:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102a56:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102a59:	31 c0                	xor    %eax,%eax
80102a5b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a5c:	89 ca                	mov    %ecx,%edx
80102a5e:	ec                   	in     (%dx),%al
80102a5f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a62:	89 da                	mov    %ebx,%edx
80102a64:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a67:	b8 02 00 00 00       	mov    $0x2,%eax
80102a6c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a6d:	89 ca                	mov    %ecx,%edx
80102a6f:	ec                   	in     (%dx),%al
80102a70:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a73:	89 da                	mov    %ebx,%edx
80102a75:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102a78:	b8 04 00 00 00       	mov    $0x4,%eax
80102a7d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a7e:	89 ca                	mov    %ecx,%edx
80102a80:	ec                   	in     (%dx),%al
80102a81:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a84:	89 da                	mov    %ebx,%edx
80102a86:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102a89:	b8 07 00 00 00       	mov    $0x7,%eax
80102a8e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a8f:	89 ca                	mov    %ecx,%edx
80102a91:	ec                   	in     (%dx),%al
80102a92:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a95:	89 da                	mov    %ebx,%edx
80102a97:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102a9a:	b8 08 00 00 00       	mov    $0x8,%eax
80102a9f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aa0:	89 ca                	mov    %ecx,%edx
80102aa2:	ec                   	in     (%dx),%al
80102aa3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aa6:	89 da                	mov    %ebx,%edx
80102aa8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102aab:	b8 09 00 00 00       	mov    $0x9,%eax
80102ab0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ab1:	89 ca                	mov    %ecx,%edx
80102ab3:	ec                   	in     (%dx),%al
80102ab4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ab7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102aba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102abd:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102ac0:	6a 18                	push   $0x18
80102ac2:	50                   	push   %eax
80102ac3:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102ac6:	50                   	push   %eax
80102ac7:	e8 64 1b 00 00       	call   80104630 <memcmp>
80102acc:	83 c4 10             	add    $0x10,%esp
80102acf:	85 c0                	test   %eax,%eax
80102ad1:	0f 85 f1 fe ff ff    	jne    801029c8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102ad7:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102adb:	75 78                	jne    80102b55 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102add:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102ae0:	89 c2                	mov    %eax,%edx
80102ae2:	83 e0 0f             	and    $0xf,%eax
80102ae5:	c1 ea 04             	shr    $0x4,%edx
80102ae8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102aeb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102aee:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102af1:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102af4:	89 c2                	mov    %eax,%edx
80102af6:	83 e0 0f             	and    $0xf,%eax
80102af9:	c1 ea 04             	shr    $0x4,%edx
80102afc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102aff:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b02:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102b05:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b08:	89 c2                	mov    %eax,%edx
80102b0a:	83 e0 0f             	and    $0xf,%eax
80102b0d:	c1 ea 04             	shr    $0x4,%edx
80102b10:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b13:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b16:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102b19:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b1c:	89 c2                	mov    %eax,%edx
80102b1e:	83 e0 0f             	and    $0xf,%eax
80102b21:	c1 ea 04             	shr    $0x4,%edx
80102b24:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b27:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b2a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102b2d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b30:	89 c2                	mov    %eax,%edx
80102b32:	83 e0 0f             	and    $0xf,%eax
80102b35:	c1 ea 04             	shr    $0x4,%edx
80102b38:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b3b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b3e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102b41:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b44:	89 c2                	mov    %eax,%edx
80102b46:	83 e0 0f             	and    $0xf,%eax
80102b49:	c1 ea 04             	shr    $0x4,%edx
80102b4c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b4f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b52:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102b55:	8b 75 08             	mov    0x8(%ebp),%esi
80102b58:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b5b:	89 06                	mov    %eax,(%esi)
80102b5d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b60:	89 46 04             	mov    %eax,0x4(%esi)
80102b63:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b66:	89 46 08             	mov    %eax,0x8(%esi)
80102b69:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b6c:	89 46 0c             	mov    %eax,0xc(%esi)
80102b6f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b72:	89 46 10             	mov    %eax,0x10(%esi)
80102b75:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b78:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102b7b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102b82:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b85:	5b                   	pop    %ebx
80102b86:	5e                   	pop    %esi
80102b87:	5f                   	pop    %edi
80102b88:	5d                   	pop    %ebp
80102b89:	c3                   	ret    
80102b8a:	66 90                	xchg   %ax,%ax
80102b8c:	66 90                	xchg   %ax,%ax
80102b8e:	66 90                	xchg   %ax,%ax

80102b90 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b90:	8b 0d 08 27 11 80    	mov    0x80112708,%ecx
80102b96:	85 c9                	test   %ecx,%ecx
80102b98:	0f 8e 8a 00 00 00    	jle    80102c28 <install_trans+0x98>
{
80102b9e:	55                   	push   %ebp
80102b9f:	89 e5                	mov    %esp,%ebp
80102ba1:	57                   	push   %edi
80102ba2:	56                   	push   %esi
80102ba3:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102ba4:	31 db                	xor    %ebx,%ebx
{
80102ba6:	83 ec 0c             	sub    $0xc,%esp
80102ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102bb0:	a1 f4 26 11 80       	mov    0x801126f4,%eax
80102bb5:	83 ec 08             	sub    $0x8,%esp
80102bb8:	01 d8                	add    %ebx,%eax
80102bba:	83 c0 01             	add    $0x1,%eax
80102bbd:	50                   	push   %eax
80102bbe:	ff 35 04 27 11 80    	pushl  0x80112704
80102bc4:	e8 07 d5 ff ff       	call   801000d0 <bread>
80102bc9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bcb:	58                   	pop    %eax
80102bcc:	5a                   	pop    %edx
80102bcd:	ff 34 9d 0c 27 11 80 	pushl  -0x7feed8f4(,%ebx,4)
80102bd4:	ff 35 04 27 11 80    	pushl  0x80112704
  for (tail = 0; tail < log.lh.n; tail++) {
80102bda:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bdd:	e8 ee d4 ff ff       	call   801000d0 <bread>
80102be2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102be4:	8d 47 5c             	lea    0x5c(%edi),%eax
80102be7:	83 c4 0c             	add    $0xc,%esp
80102bea:	68 00 02 00 00       	push   $0x200
80102bef:	50                   	push   %eax
80102bf0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102bf3:	50                   	push   %eax
80102bf4:	e8 97 1a 00 00       	call   80104690 <memmove>
    bwrite(dbuf);  // write dst to disk
80102bf9:	89 34 24             	mov    %esi,(%esp)
80102bfc:	e8 9f d5 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102c01:	89 3c 24             	mov    %edi,(%esp)
80102c04:	e8 d7 d5 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102c09:	89 34 24             	mov    %esi,(%esp)
80102c0c:	e8 cf d5 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102c11:	83 c4 10             	add    $0x10,%esp
80102c14:	39 1d 08 27 11 80    	cmp    %ebx,0x80112708
80102c1a:	7f 94                	jg     80102bb0 <install_trans+0x20>
  }
}
80102c1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c1f:	5b                   	pop    %ebx
80102c20:	5e                   	pop    %esi
80102c21:	5f                   	pop    %edi
80102c22:	5d                   	pop    %ebp
80102c23:	c3                   	ret    
80102c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c28:	f3 c3                	repz ret 
80102c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102c30 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c30:	55                   	push   %ebp
80102c31:	89 e5                	mov    %esp,%ebp
80102c33:	56                   	push   %esi
80102c34:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102c35:	83 ec 08             	sub    $0x8,%esp
80102c38:	ff 35 f4 26 11 80    	pushl  0x801126f4
80102c3e:	ff 35 04 27 11 80    	pushl  0x80112704
80102c44:	e8 87 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102c49:	8b 1d 08 27 11 80    	mov    0x80112708,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102c4f:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c52:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102c54:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102c56:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102c59:	7e 16                	jle    80102c71 <write_head+0x41>
80102c5b:	c1 e3 02             	shl    $0x2,%ebx
80102c5e:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102c60:	8b 8a 0c 27 11 80    	mov    -0x7feed8f4(%edx),%ecx
80102c66:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102c6a:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102c6d:	39 da                	cmp    %ebx,%edx
80102c6f:	75 ef                	jne    80102c60 <write_head+0x30>
  }
  bwrite(buf);
80102c71:	83 ec 0c             	sub    $0xc,%esp
80102c74:	56                   	push   %esi
80102c75:	e8 26 d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102c7a:	89 34 24             	mov    %esi,(%esp)
80102c7d:	e8 5e d5 ff ff       	call   801001e0 <brelse>
}
80102c82:	83 c4 10             	add    $0x10,%esp
80102c85:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102c88:	5b                   	pop    %ebx
80102c89:	5e                   	pop    %esi
80102c8a:	5d                   	pop    %ebp
80102c8b:	c3                   	ret    
80102c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102c90 <initlog>:
{
80102c90:	55                   	push   %ebp
80102c91:	89 e5                	mov    %esp,%ebp
80102c93:	53                   	push   %ebx
80102c94:	83 ec 2c             	sub    $0x2c,%esp
80102c97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102c9a:	68 40 75 10 80       	push   $0x80107540
80102c9f:	68 c0 26 11 80       	push   $0x801126c0
80102ca4:	e8 e7 16 00 00       	call   80104390 <initlock>
  readsb(dev, &sb);
80102ca9:	58                   	pop    %eax
80102caa:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102cad:	5a                   	pop    %edx
80102cae:	50                   	push   %eax
80102caf:	53                   	push   %ebx
80102cb0:	e8 db e8 ff ff       	call   80101590 <readsb>
  log.size = sb.nlog;
80102cb5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102cb8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102cbb:	59                   	pop    %ecx
  log.dev = dev;
80102cbc:	89 1d 04 27 11 80    	mov    %ebx,0x80112704
  log.size = sb.nlog;
80102cc2:	89 15 f8 26 11 80    	mov    %edx,0x801126f8
  log.start = sb.logstart;
80102cc8:	a3 f4 26 11 80       	mov    %eax,0x801126f4
  struct buf *buf = bread(log.dev, log.start);
80102ccd:	5a                   	pop    %edx
80102cce:	50                   	push   %eax
80102ccf:	53                   	push   %ebx
80102cd0:	e8 fb d3 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102cd5:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102cd8:	83 c4 10             	add    $0x10,%esp
80102cdb:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102cdd:	89 1d 08 27 11 80    	mov    %ebx,0x80112708
  for (i = 0; i < log.lh.n; i++) {
80102ce3:	7e 1c                	jle    80102d01 <initlog+0x71>
80102ce5:	c1 e3 02             	shl    $0x2,%ebx
80102ce8:	31 d2                	xor    %edx,%edx
80102cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102cf0:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102cf4:	83 c2 04             	add    $0x4,%edx
80102cf7:	89 8a 08 27 11 80    	mov    %ecx,-0x7feed8f8(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102cfd:	39 d3                	cmp    %edx,%ebx
80102cff:	75 ef                	jne    80102cf0 <initlog+0x60>
  brelse(buf);
80102d01:	83 ec 0c             	sub    $0xc,%esp
80102d04:	50                   	push   %eax
80102d05:	e8 d6 d4 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102d0a:	e8 81 fe ff ff       	call   80102b90 <install_trans>
  log.lh.n = 0;
80102d0f:	c7 05 08 27 11 80 00 	movl   $0x0,0x80112708
80102d16:	00 00 00 
  write_head(); // clear the log
80102d19:	e8 12 ff ff ff       	call   80102c30 <write_head>
}
80102d1e:	83 c4 10             	add    $0x10,%esp
80102d21:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d24:	c9                   	leave  
80102d25:	c3                   	ret    
80102d26:	8d 76 00             	lea    0x0(%esi),%esi
80102d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d30 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102d30:	55                   	push   %ebp
80102d31:	89 e5                	mov    %esp,%ebp
80102d33:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102d36:	68 c0 26 11 80       	push   $0x801126c0
80102d3b:	e8 90 17 00 00       	call   801044d0 <acquire>
80102d40:	83 c4 10             	add    $0x10,%esp
80102d43:	eb 18                	jmp    80102d5d <begin_op+0x2d>
80102d45:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d48:	83 ec 08             	sub    $0x8,%esp
80102d4b:	68 c0 26 11 80       	push   $0x801126c0
80102d50:	68 c0 26 11 80       	push   $0x801126c0
80102d55:	e8 b6 11 00 00       	call   80103f10 <sleep>
80102d5a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102d5d:	a1 00 27 11 80       	mov    0x80112700,%eax
80102d62:	85 c0                	test   %eax,%eax
80102d64:	75 e2                	jne    80102d48 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d66:	a1 fc 26 11 80       	mov    0x801126fc,%eax
80102d6b:	8b 15 08 27 11 80    	mov    0x80112708,%edx
80102d71:	83 c0 01             	add    $0x1,%eax
80102d74:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102d77:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102d7a:	83 fa 1e             	cmp    $0x1e,%edx
80102d7d:	7f c9                	jg     80102d48 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102d7f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102d82:	a3 fc 26 11 80       	mov    %eax,0x801126fc
      release(&log.lock);
80102d87:	68 c0 26 11 80       	push   $0x801126c0
80102d8c:	e8 ff 17 00 00       	call   80104590 <release>
      break;
    }
  }
}
80102d91:	83 c4 10             	add    $0x10,%esp
80102d94:	c9                   	leave  
80102d95:	c3                   	ret    
80102d96:	8d 76 00             	lea    0x0(%esi),%esi
80102d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102da0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102da0:	55                   	push   %ebp
80102da1:	89 e5                	mov    %esp,%ebp
80102da3:	57                   	push   %edi
80102da4:	56                   	push   %esi
80102da5:	53                   	push   %ebx
80102da6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102da9:	68 c0 26 11 80       	push   $0x801126c0
80102dae:	e8 1d 17 00 00       	call   801044d0 <acquire>
  log.outstanding -= 1;
80102db3:	a1 fc 26 11 80       	mov    0x801126fc,%eax
  if(log.committing)
80102db8:	8b 35 00 27 11 80    	mov    0x80112700,%esi
80102dbe:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102dc1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102dc4:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102dc6:	89 1d fc 26 11 80    	mov    %ebx,0x801126fc
  if(log.committing)
80102dcc:	0f 85 1a 01 00 00    	jne    80102eec <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102dd2:	85 db                	test   %ebx,%ebx
80102dd4:	0f 85 ee 00 00 00    	jne    80102ec8 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102dda:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102ddd:	c7 05 00 27 11 80 01 	movl   $0x1,0x80112700
80102de4:	00 00 00 
  release(&log.lock);
80102de7:	68 c0 26 11 80       	push   $0x801126c0
80102dec:	e8 9f 17 00 00       	call   80104590 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102df1:	8b 0d 08 27 11 80    	mov    0x80112708,%ecx
80102df7:	83 c4 10             	add    $0x10,%esp
80102dfa:	85 c9                	test   %ecx,%ecx
80102dfc:	0f 8e 85 00 00 00    	jle    80102e87 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102e02:	a1 f4 26 11 80       	mov    0x801126f4,%eax
80102e07:	83 ec 08             	sub    $0x8,%esp
80102e0a:	01 d8                	add    %ebx,%eax
80102e0c:	83 c0 01             	add    $0x1,%eax
80102e0f:	50                   	push   %eax
80102e10:	ff 35 04 27 11 80    	pushl  0x80112704
80102e16:	e8 b5 d2 ff ff       	call   801000d0 <bread>
80102e1b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e1d:	58                   	pop    %eax
80102e1e:	5a                   	pop    %edx
80102e1f:	ff 34 9d 0c 27 11 80 	pushl  -0x7feed8f4(,%ebx,4)
80102e26:	ff 35 04 27 11 80    	pushl  0x80112704
  for (tail = 0; tail < log.lh.n; tail++) {
80102e2c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e2f:	e8 9c d2 ff ff       	call   801000d0 <bread>
80102e34:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102e36:	8d 40 5c             	lea    0x5c(%eax),%eax
80102e39:	83 c4 0c             	add    $0xc,%esp
80102e3c:	68 00 02 00 00       	push   $0x200
80102e41:	50                   	push   %eax
80102e42:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e45:	50                   	push   %eax
80102e46:	e8 45 18 00 00       	call   80104690 <memmove>
    bwrite(to);  // write the log
80102e4b:	89 34 24             	mov    %esi,(%esp)
80102e4e:	e8 4d d3 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102e53:	89 3c 24             	mov    %edi,(%esp)
80102e56:	e8 85 d3 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102e5b:	89 34 24             	mov    %esi,(%esp)
80102e5e:	e8 7d d3 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102e63:	83 c4 10             	add    $0x10,%esp
80102e66:	3b 1d 08 27 11 80    	cmp    0x80112708,%ebx
80102e6c:	7c 94                	jl     80102e02 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102e6e:	e8 bd fd ff ff       	call   80102c30 <write_head>
    install_trans(); // Now install writes to home locations
80102e73:	e8 18 fd ff ff       	call   80102b90 <install_trans>
    log.lh.n = 0;
80102e78:	c7 05 08 27 11 80 00 	movl   $0x0,0x80112708
80102e7f:	00 00 00 
    write_head();    // Erase the transaction from the log
80102e82:	e8 a9 fd ff ff       	call   80102c30 <write_head>
    acquire(&log.lock);
80102e87:	83 ec 0c             	sub    $0xc,%esp
80102e8a:	68 c0 26 11 80       	push   $0x801126c0
80102e8f:	e8 3c 16 00 00       	call   801044d0 <acquire>
    wakeup(&log);
80102e94:	c7 04 24 c0 26 11 80 	movl   $0x801126c0,(%esp)
    log.committing = 0;
80102e9b:	c7 05 00 27 11 80 00 	movl   $0x0,0x80112700
80102ea2:	00 00 00 
    wakeup(&log);
80102ea5:	e8 16 12 00 00       	call   801040c0 <wakeup>
    release(&log.lock);
80102eaa:	c7 04 24 c0 26 11 80 	movl   $0x801126c0,(%esp)
80102eb1:	e8 da 16 00 00       	call   80104590 <release>
80102eb6:	83 c4 10             	add    $0x10,%esp
}
80102eb9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ebc:	5b                   	pop    %ebx
80102ebd:	5e                   	pop    %esi
80102ebe:	5f                   	pop    %edi
80102ebf:	5d                   	pop    %ebp
80102ec0:	c3                   	ret    
80102ec1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102ec8:	83 ec 0c             	sub    $0xc,%esp
80102ecb:	68 c0 26 11 80       	push   $0x801126c0
80102ed0:	e8 eb 11 00 00       	call   801040c0 <wakeup>
  release(&log.lock);
80102ed5:	c7 04 24 c0 26 11 80 	movl   $0x801126c0,(%esp)
80102edc:	e8 af 16 00 00       	call   80104590 <release>
80102ee1:	83 c4 10             	add    $0x10,%esp
}
80102ee4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ee7:	5b                   	pop    %ebx
80102ee8:	5e                   	pop    %esi
80102ee9:	5f                   	pop    %edi
80102eea:	5d                   	pop    %ebp
80102eeb:	c3                   	ret    
    panic("log.committing");
80102eec:	83 ec 0c             	sub    $0xc,%esp
80102eef:	68 44 75 10 80       	push   $0x80107544
80102ef4:	e8 67 d5 ff ff       	call   80100460 <panic>
80102ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102f00 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102f00:	55                   	push   %ebp
80102f01:	89 e5                	mov    %esp,%ebp
80102f03:	53                   	push   %ebx
80102f04:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f07:	8b 15 08 27 11 80    	mov    0x80112708,%edx
{
80102f0d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f10:	83 fa 1d             	cmp    $0x1d,%edx
80102f13:	0f 8f 9d 00 00 00    	jg     80102fb6 <log_write+0xb6>
80102f19:	a1 f8 26 11 80       	mov    0x801126f8,%eax
80102f1e:	83 e8 01             	sub    $0x1,%eax
80102f21:	39 c2                	cmp    %eax,%edx
80102f23:	0f 8d 8d 00 00 00    	jge    80102fb6 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f29:	a1 fc 26 11 80       	mov    0x801126fc,%eax
80102f2e:	85 c0                	test   %eax,%eax
80102f30:	0f 8e 8d 00 00 00    	jle    80102fc3 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f36:	83 ec 0c             	sub    $0xc,%esp
80102f39:	68 c0 26 11 80       	push   $0x801126c0
80102f3e:	e8 8d 15 00 00       	call   801044d0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102f43:	8b 0d 08 27 11 80    	mov    0x80112708,%ecx
80102f49:	83 c4 10             	add    $0x10,%esp
80102f4c:	83 f9 00             	cmp    $0x0,%ecx
80102f4f:	7e 57                	jle    80102fa8 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f51:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102f54:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f56:	3b 15 0c 27 11 80    	cmp    0x8011270c,%edx
80102f5c:	75 0b                	jne    80102f69 <log_write+0x69>
80102f5e:	eb 38                	jmp    80102f98 <log_write+0x98>
80102f60:	39 14 85 0c 27 11 80 	cmp    %edx,-0x7feed8f4(,%eax,4)
80102f67:	74 2f                	je     80102f98 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102f69:	83 c0 01             	add    $0x1,%eax
80102f6c:	39 c1                	cmp    %eax,%ecx
80102f6e:	75 f0                	jne    80102f60 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102f70:	89 14 85 0c 27 11 80 	mov    %edx,-0x7feed8f4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102f77:	83 c0 01             	add    $0x1,%eax
80102f7a:	a3 08 27 11 80       	mov    %eax,0x80112708
  b->flags |= B_DIRTY; // prevent eviction
80102f7f:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102f82:	c7 45 08 c0 26 11 80 	movl   $0x801126c0,0x8(%ebp)
}
80102f89:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f8c:	c9                   	leave  
  release(&log.lock);
80102f8d:	e9 fe 15 00 00       	jmp    80104590 <release>
80102f92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102f98:	89 14 85 0c 27 11 80 	mov    %edx,-0x7feed8f4(,%eax,4)
80102f9f:	eb de                	jmp    80102f7f <log_write+0x7f>
80102fa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fa8:	8b 43 08             	mov    0x8(%ebx),%eax
80102fab:	a3 0c 27 11 80       	mov    %eax,0x8011270c
  if (i == log.lh.n)
80102fb0:	75 cd                	jne    80102f7f <log_write+0x7f>
80102fb2:	31 c0                	xor    %eax,%eax
80102fb4:	eb c1                	jmp    80102f77 <log_write+0x77>
    panic("too big a transaction");
80102fb6:	83 ec 0c             	sub    $0xc,%esp
80102fb9:	68 53 75 10 80       	push   $0x80107553
80102fbe:	e8 9d d4 ff ff       	call   80100460 <panic>
    panic("log_write outside of trans");
80102fc3:	83 ec 0c             	sub    $0xc,%esp
80102fc6:	68 69 75 10 80       	push   $0x80107569
80102fcb:	e8 90 d4 ff ff       	call   80100460 <panic>

80102fd0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102fd0:	55                   	push   %ebp
80102fd1:	89 e5                	mov    %esp,%ebp
80102fd3:	53                   	push   %ebx
80102fd4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102fd7:	e8 74 09 00 00       	call   80103950 <cpuid>
80102fdc:	89 c3                	mov    %eax,%ebx
80102fde:	e8 6d 09 00 00       	call   80103950 <cpuid>
80102fe3:	83 ec 04             	sub    $0x4,%esp
80102fe6:	53                   	push   %ebx
80102fe7:	50                   	push   %eax
80102fe8:	68 84 75 10 80       	push   $0x80107584
80102fed:	e8 3e d7 ff ff       	call   80100730 <cprintf>
  idtinit();       // load idt register
80102ff2:	e8 b9 28 00 00       	call   801058b0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102ff7:	e8 d4 08 00 00       	call   801038d0 <mycpu>
80102ffc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102ffe:	b8 01 00 00 00       	mov    $0x1,%eax
80103003:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010300a:	e8 21 0c 00 00       	call   80103c30 <scheduler>
8010300f:	90                   	nop

80103010 <mpenter>:
{
80103010:	55                   	push   %ebp
80103011:	89 e5                	mov    %esp,%ebp
80103013:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103016:	e8 85 39 00 00       	call   801069a0 <switchkvm>
  seginit();
8010301b:	e8 f0 38 00 00       	call   80106910 <seginit>
  lapicinit();
80103020:	e8 9b f7 ff ff       	call   801027c0 <lapicinit>
  mpmain();
80103025:	e8 a6 ff ff ff       	call   80102fd0 <mpmain>
8010302a:	66 90                	xchg   %ax,%ax
8010302c:	66 90                	xchg   %ax,%ax
8010302e:	66 90                	xchg   %ax,%ax

80103030 <main>:
{
80103030:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103034:	83 e4 f0             	and    $0xfffffff0,%esp
80103037:	ff 71 fc             	pushl  -0x4(%ecx)
8010303a:	55                   	push   %ebp
8010303b:	89 e5                	mov    %esp,%ebp
8010303d:	53                   	push   %ebx
8010303e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010303f:	83 ec 08             	sub    $0x8,%esp
80103042:	68 00 00 40 80       	push   $0x80400000
80103047:	68 e8 55 11 80       	push   $0x801155e8
8010304c:	e8 2f f5 ff ff       	call   80102580 <kinit1>
  kvmalloc();      // kernel page table
80103051:	e8 1a 3e 00 00       	call   80106e70 <kvmalloc>
  mpinit();        // detect other processors
80103056:	e8 75 01 00 00       	call   801031d0 <mpinit>
  lapicinit();     // interrupt controller
8010305b:	e8 60 f7 ff ff       	call   801027c0 <lapicinit>
  seginit();       // segment descriptors
80103060:	e8 ab 38 00 00       	call   80106910 <seginit>
  picinit();       // disable pic
80103065:	e8 46 03 00 00       	call   801033b0 <picinit>
  ioapicinit();    // another interrupt controller
8010306a:	e8 41 f3 ff ff       	call   801023b0 <ioapicinit>
  consoleinit();   // console hardware
8010306f:	e8 3c da ff ff       	call   80100ab0 <consoleinit>
  uartinit();      // serial port
80103074:	e8 67 2b 00 00       	call   80105be0 <uartinit>
  pinit();         // process table
80103079:	e8 32 08 00 00       	call   801038b0 <pinit>
  tvinit();        // trap vectors
8010307e:	e8 ad 27 00 00       	call   80105830 <tvinit>
  binit();         // buffer cache
80103083:	e8 b8 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103088:	e8 c3 dd ff ff       	call   80100e50 <fileinit>
  ideinit();       // disk 
8010308d:	e8 fe f0 ff ff       	call   80102190 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_kernel_entryother_start, (uint)_binary_kernel_entryother_size);
80103092:	83 c4 0c             	add    $0xc,%esp
80103095:	68 8a 00 00 00       	push   $0x8a
8010309a:	68 8c a4 10 80       	push   $0x8010a48c
8010309f:	68 00 70 00 80       	push   $0x80007000
801030a4:	e8 e7 15 00 00       	call   80104690 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801030a9:	69 05 40 2d 11 80 b0 	imul   $0xb0,0x80112d40,%eax
801030b0:	00 00 00 
801030b3:	83 c4 10             	add    $0x10,%esp
801030b6:	05 c0 27 11 80       	add    $0x801127c0,%eax
801030bb:	3d c0 27 11 80       	cmp    $0x801127c0,%eax
801030c0:	76 71                	jbe    80103133 <main+0x103>
801030c2:	bb c0 27 11 80       	mov    $0x801127c0,%ebx
801030c7:	89 f6                	mov    %esi,%esi
801030c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
801030d0:	e8 fb 07 00 00       	call   801038d0 <mycpu>
801030d5:	39 d8                	cmp    %ebx,%eax
801030d7:	74 41                	je     8010311a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801030d9:	e8 72 f5 ff ff       	call   80102650 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
801030de:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
801030e3:	c7 05 f8 6f 00 80 10 	movl   $0x80103010,0x80006ff8
801030ea:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801030ed:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
801030f4:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801030f7:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
801030fc:	0f b6 03             	movzbl (%ebx),%eax
801030ff:	83 ec 08             	sub    $0x8,%esp
80103102:	68 00 70 00 00       	push   $0x7000
80103107:	50                   	push   %eax
80103108:	e8 03 f8 ff ff       	call   80102910 <lapicstartap>
8010310d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103110:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103116:	85 c0                	test   %eax,%eax
80103118:	74 f6                	je     80103110 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
8010311a:	69 05 40 2d 11 80 b0 	imul   $0xb0,0x80112d40,%eax
80103121:	00 00 00 
80103124:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010312a:	05 c0 27 11 80       	add    $0x801127c0,%eax
8010312f:	39 c3                	cmp    %eax,%ebx
80103131:	72 9d                	jb     801030d0 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103133:	83 ec 08             	sub    $0x8,%esp
80103136:	68 00 00 00 8e       	push   $0x8e000000
8010313b:	68 00 00 40 80       	push   $0x80400000
80103140:	e8 ab f4 ff ff       	call   801025f0 <kinit2>
  userinit();      // first user process
80103145:	e8 56 08 00 00       	call   801039a0 <userinit>
  mpmain();        // finish this processor's setup
8010314a:	e8 81 fe ff ff       	call   80102fd0 <mpmain>
8010314f:	90                   	nop

80103150 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103150:	55                   	push   %ebp
80103151:	89 e5                	mov    %esp,%ebp
80103153:	57                   	push   %edi
80103154:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103155:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010315b:	53                   	push   %ebx
  e = addr+len;
8010315c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010315f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103162:	39 de                	cmp    %ebx,%esi
80103164:	72 10                	jb     80103176 <mpsearch1+0x26>
80103166:	eb 50                	jmp    801031b8 <mpsearch1+0x68>
80103168:	90                   	nop
80103169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103170:	39 fb                	cmp    %edi,%ebx
80103172:	89 fe                	mov    %edi,%esi
80103174:	76 42                	jbe    801031b8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103176:	83 ec 04             	sub    $0x4,%esp
80103179:	8d 7e 10             	lea    0x10(%esi),%edi
8010317c:	6a 04                	push   $0x4
8010317e:	68 98 75 10 80       	push   $0x80107598
80103183:	56                   	push   %esi
80103184:	e8 a7 14 00 00       	call   80104630 <memcmp>
80103189:	83 c4 10             	add    $0x10,%esp
8010318c:	85 c0                	test   %eax,%eax
8010318e:	75 e0                	jne    80103170 <mpsearch1+0x20>
80103190:	89 f1                	mov    %esi,%ecx
80103192:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103198:	0f b6 11             	movzbl (%ecx),%edx
8010319b:	83 c1 01             	add    $0x1,%ecx
8010319e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
801031a0:	39 f9                	cmp    %edi,%ecx
801031a2:	75 f4                	jne    80103198 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031a4:	84 c0                	test   %al,%al
801031a6:	75 c8                	jne    80103170 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801031a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031ab:	89 f0                	mov    %esi,%eax
801031ad:	5b                   	pop    %ebx
801031ae:	5e                   	pop    %esi
801031af:	5f                   	pop    %edi
801031b0:	5d                   	pop    %ebp
801031b1:	c3                   	ret    
801031b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801031b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801031bb:	31 f6                	xor    %esi,%esi
}
801031bd:	89 f0                	mov    %esi,%eax
801031bf:	5b                   	pop    %ebx
801031c0:	5e                   	pop    %esi
801031c1:	5f                   	pop    %edi
801031c2:	5d                   	pop    %ebp
801031c3:	c3                   	ret    
801031c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801031ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801031d0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801031d0:	55                   	push   %ebp
801031d1:	89 e5                	mov    %esp,%ebp
801031d3:	57                   	push   %edi
801031d4:	56                   	push   %esi
801031d5:	53                   	push   %ebx
801031d6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801031d9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801031e0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801031e7:	c1 e0 08             	shl    $0x8,%eax
801031ea:	09 d0                	or     %edx,%eax
801031ec:	c1 e0 04             	shl    $0x4,%eax
801031ef:	85 c0                	test   %eax,%eax
801031f1:	75 1b                	jne    8010320e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801031f3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801031fa:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103201:	c1 e0 08             	shl    $0x8,%eax
80103204:	09 d0                	or     %edx,%eax
80103206:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103209:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010320e:	ba 00 04 00 00       	mov    $0x400,%edx
80103213:	e8 38 ff ff ff       	call   80103150 <mpsearch1>
80103218:	85 c0                	test   %eax,%eax
8010321a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010321d:	0f 84 3d 01 00 00    	je     80103360 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103223:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103226:	8b 58 04             	mov    0x4(%eax),%ebx
80103229:	85 db                	test   %ebx,%ebx
8010322b:	0f 84 4f 01 00 00    	je     80103380 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103231:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103237:	83 ec 04             	sub    $0x4,%esp
8010323a:	6a 04                	push   $0x4
8010323c:	68 b5 75 10 80       	push   $0x801075b5
80103241:	56                   	push   %esi
80103242:	e8 e9 13 00 00       	call   80104630 <memcmp>
80103247:	83 c4 10             	add    $0x10,%esp
8010324a:	85 c0                	test   %eax,%eax
8010324c:	0f 85 2e 01 00 00    	jne    80103380 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
80103252:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103259:	3c 01                	cmp    $0x1,%al
8010325b:	0f 95 c2             	setne  %dl
8010325e:	3c 04                	cmp    $0x4,%al
80103260:	0f 95 c0             	setne  %al
80103263:	20 c2                	and    %al,%dl
80103265:	0f 85 15 01 00 00    	jne    80103380 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
8010326b:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
80103272:	66 85 ff             	test   %di,%di
80103275:	74 1a                	je     80103291 <mpinit+0xc1>
80103277:	89 f0                	mov    %esi,%eax
80103279:	01 f7                	add    %esi,%edi
  sum = 0;
8010327b:	31 d2                	xor    %edx,%edx
8010327d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103280:	0f b6 08             	movzbl (%eax),%ecx
80103283:	83 c0 01             	add    $0x1,%eax
80103286:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103288:	39 c7                	cmp    %eax,%edi
8010328a:	75 f4                	jne    80103280 <mpinit+0xb0>
8010328c:	84 d2                	test   %dl,%dl
8010328e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103291:	85 f6                	test   %esi,%esi
80103293:	0f 84 e7 00 00 00    	je     80103380 <mpinit+0x1b0>
80103299:	84 d2                	test   %dl,%dl
8010329b:	0f 85 df 00 00 00    	jne    80103380 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801032a1:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801032a7:	a3 bc 26 11 80       	mov    %eax,0x801126bc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032ac:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801032b3:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
801032b9:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032be:	01 d6                	add    %edx,%esi
801032c0:	39 c6                	cmp    %eax,%esi
801032c2:	76 23                	jbe    801032e7 <mpinit+0x117>
    switch(*p){
801032c4:	0f b6 10             	movzbl (%eax),%edx
801032c7:	80 fa 04             	cmp    $0x4,%dl
801032ca:	0f 87 ca 00 00 00    	ja     8010339a <mpinit+0x1ca>
801032d0:	ff 24 95 dc 75 10 80 	jmp    *-0x7fef8a24(,%edx,4)
801032d7:	89 f6                	mov    %esi,%esi
801032d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801032e0:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032e3:	39 c6                	cmp    %eax,%esi
801032e5:	77 dd                	ja     801032c4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801032e7:	85 db                	test   %ebx,%ebx
801032e9:	0f 84 9e 00 00 00    	je     8010338d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801032ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801032f2:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
801032f6:	74 15                	je     8010330d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032f8:	b8 70 00 00 00       	mov    $0x70,%eax
801032fd:	ba 22 00 00 00       	mov    $0x22,%edx
80103302:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103303:	ba 23 00 00 00       	mov    $0x23,%edx
80103308:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103309:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010330c:	ee                   	out    %al,(%dx)
  }
}
8010330d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103310:	5b                   	pop    %ebx
80103311:	5e                   	pop    %esi
80103312:	5f                   	pop    %edi
80103313:	5d                   	pop    %ebp
80103314:	c3                   	ret    
80103315:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103318:	8b 0d 40 2d 11 80    	mov    0x80112d40,%ecx
8010331e:	83 f9 07             	cmp    $0x7,%ecx
80103321:	7f 19                	jg     8010333c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103323:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103327:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010332d:	83 c1 01             	add    $0x1,%ecx
80103330:	89 0d 40 2d 11 80    	mov    %ecx,0x80112d40
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103336:	88 97 c0 27 11 80    	mov    %dl,-0x7feed840(%edi)
      p += sizeof(struct mpproc);
8010333c:	83 c0 14             	add    $0x14,%eax
      continue;
8010333f:	e9 7c ff ff ff       	jmp    801032c0 <mpinit+0xf0>
80103344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103348:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010334c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010334f:	88 15 a0 27 11 80    	mov    %dl,0x801127a0
      continue;
80103355:	e9 66 ff ff ff       	jmp    801032c0 <mpinit+0xf0>
8010335a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
80103360:	ba 00 00 01 00       	mov    $0x10000,%edx
80103365:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010336a:	e8 e1 fd ff ff       	call   80103150 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010336f:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103371:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103374:	0f 85 a9 fe ff ff    	jne    80103223 <mpinit+0x53>
8010337a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103380:	83 ec 0c             	sub    $0xc,%esp
80103383:	68 9d 75 10 80       	push   $0x8010759d
80103388:	e8 d3 d0 ff ff       	call   80100460 <panic>
    panic("Didn't find a suitable machine");
8010338d:	83 ec 0c             	sub    $0xc,%esp
80103390:	68 bc 75 10 80       	push   $0x801075bc
80103395:	e8 c6 d0 ff ff       	call   80100460 <panic>
      ismp = 0;
8010339a:	31 db                	xor    %ebx,%ebx
8010339c:	e9 26 ff ff ff       	jmp    801032c7 <mpinit+0xf7>
801033a1:	66 90                	xchg   %ax,%ax
801033a3:	66 90                	xchg   %ax,%ax
801033a5:	66 90                	xchg   %ax,%ax
801033a7:	66 90                	xchg   %ax,%ax
801033a9:	66 90                	xchg   %ax,%ax
801033ab:	66 90                	xchg   %ax,%ax
801033ad:	66 90                	xchg   %ax,%ax
801033af:	90                   	nop

801033b0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801033b0:	55                   	push   %ebp
801033b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801033b6:	ba 21 00 00 00       	mov    $0x21,%edx
801033bb:	89 e5                	mov    %esp,%ebp
801033bd:	ee                   	out    %al,(%dx)
801033be:	ba a1 00 00 00       	mov    $0xa1,%edx
801033c3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801033c4:	5d                   	pop    %ebp
801033c5:	c3                   	ret    
801033c6:	66 90                	xchg   %ax,%ax
801033c8:	66 90                	xchg   %ax,%ax
801033ca:	66 90                	xchg   %ax,%ax
801033cc:	66 90                	xchg   %ax,%ax
801033ce:	66 90                	xchg   %ax,%ax

801033d0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801033d0:	55                   	push   %ebp
801033d1:	89 e5                	mov    %esp,%ebp
801033d3:	57                   	push   %edi
801033d4:	56                   	push   %esi
801033d5:	53                   	push   %ebx
801033d6:	83 ec 0c             	sub    $0xc,%esp
801033d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801033dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801033df:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801033e5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801033eb:	e8 80 da ff ff       	call   80100e70 <filealloc>
801033f0:	85 c0                	test   %eax,%eax
801033f2:	89 03                	mov    %eax,(%ebx)
801033f4:	74 22                	je     80103418 <pipealloc+0x48>
801033f6:	e8 75 da ff ff       	call   80100e70 <filealloc>
801033fb:	85 c0                	test   %eax,%eax
801033fd:	89 06                	mov    %eax,(%esi)
801033ff:	74 3f                	je     80103440 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103401:	e8 4a f2 ff ff       	call   80102650 <kalloc>
80103406:	85 c0                	test   %eax,%eax
80103408:	89 c7                	mov    %eax,%edi
8010340a:	75 54                	jne    80103460 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010340c:	8b 03                	mov    (%ebx),%eax
8010340e:	85 c0                	test   %eax,%eax
80103410:	75 34                	jne    80103446 <pipealloc+0x76>
80103412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103418:	8b 06                	mov    (%esi),%eax
8010341a:	85 c0                	test   %eax,%eax
8010341c:	74 0c                	je     8010342a <pipealloc+0x5a>
    fileclose(*f1);
8010341e:	83 ec 0c             	sub    $0xc,%esp
80103421:	50                   	push   %eax
80103422:	e8 09 db ff ff       	call   80100f30 <fileclose>
80103427:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010342a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010342d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103432:	5b                   	pop    %ebx
80103433:	5e                   	pop    %esi
80103434:	5f                   	pop    %edi
80103435:	5d                   	pop    %ebp
80103436:	c3                   	ret    
80103437:	89 f6                	mov    %esi,%esi
80103439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
80103440:	8b 03                	mov    (%ebx),%eax
80103442:	85 c0                	test   %eax,%eax
80103444:	74 e4                	je     8010342a <pipealloc+0x5a>
    fileclose(*f0);
80103446:	83 ec 0c             	sub    $0xc,%esp
80103449:	50                   	push   %eax
8010344a:	e8 e1 da ff ff       	call   80100f30 <fileclose>
  if(*f1)
8010344f:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
80103451:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103454:	85 c0                	test   %eax,%eax
80103456:	75 c6                	jne    8010341e <pipealloc+0x4e>
80103458:	eb d0                	jmp    8010342a <pipealloc+0x5a>
8010345a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
80103460:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
80103463:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010346a:	00 00 00 
  p->writeopen = 1;
8010346d:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103474:	00 00 00 
  p->nwrite = 0;
80103477:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010347e:	00 00 00 
  p->nread = 0;
80103481:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103488:	00 00 00 
  initlock(&p->lock, "pipe");
8010348b:	68 f0 75 10 80       	push   $0x801075f0
80103490:	50                   	push   %eax
80103491:	e8 fa 0e 00 00       	call   80104390 <initlock>
  (*f0)->type = FD_PIPE;
80103496:	8b 03                	mov    (%ebx),%eax
  return 0;
80103498:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010349b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801034a1:	8b 03                	mov    (%ebx),%eax
801034a3:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801034a7:	8b 03                	mov    (%ebx),%eax
801034a9:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801034ad:	8b 03                	mov    (%ebx),%eax
801034af:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801034b2:	8b 06                	mov    (%esi),%eax
801034b4:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801034ba:	8b 06                	mov    (%esi),%eax
801034bc:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801034c0:	8b 06                	mov    (%esi),%eax
801034c2:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801034c6:	8b 06                	mov    (%esi),%eax
801034c8:	89 78 0c             	mov    %edi,0xc(%eax)
}
801034cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801034ce:	31 c0                	xor    %eax,%eax
}
801034d0:	5b                   	pop    %ebx
801034d1:	5e                   	pop    %esi
801034d2:	5f                   	pop    %edi
801034d3:	5d                   	pop    %ebp
801034d4:	c3                   	ret    
801034d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801034d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801034e0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801034e0:	55                   	push   %ebp
801034e1:	89 e5                	mov    %esp,%ebp
801034e3:	56                   	push   %esi
801034e4:	53                   	push   %ebx
801034e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801034eb:	83 ec 0c             	sub    $0xc,%esp
801034ee:	53                   	push   %ebx
801034ef:	e8 dc 0f 00 00       	call   801044d0 <acquire>
  if(writable){
801034f4:	83 c4 10             	add    $0x10,%esp
801034f7:	85 f6                	test   %esi,%esi
801034f9:	74 45                	je     80103540 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801034fb:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103501:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103504:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010350b:	00 00 00 
    wakeup(&p->nread);
8010350e:	50                   	push   %eax
8010350f:	e8 ac 0b 00 00       	call   801040c0 <wakeup>
80103514:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103517:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010351d:	85 d2                	test   %edx,%edx
8010351f:	75 0a                	jne    8010352b <pipeclose+0x4b>
80103521:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103527:	85 c0                	test   %eax,%eax
80103529:	74 35                	je     80103560 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010352b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010352e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103531:	5b                   	pop    %ebx
80103532:	5e                   	pop    %esi
80103533:	5d                   	pop    %ebp
    release(&p->lock);
80103534:	e9 57 10 00 00       	jmp    80104590 <release>
80103539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103540:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103546:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103549:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103550:	00 00 00 
    wakeup(&p->nwrite);
80103553:	50                   	push   %eax
80103554:	e8 67 0b 00 00       	call   801040c0 <wakeup>
80103559:	83 c4 10             	add    $0x10,%esp
8010355c:	eb b9                	jmp    80103517 <pipeclose+0x37>
8010355e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103560:	83 ec 0c             	sub    $0xc,%esp
80103563:	53                   	push   %ebx
80103564:	e8 27 10 00 00       	call   80104590 <release>
    kfree((char*)p);
80103569:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010356c:	83 c4 10             	add    $0x10,%esp
}
8010356f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103572:	5b                   	pop    %ebx
80103573:	5e                   	pop    %esi
80103574:	5d                   	pop    %ebp
    kfree((char*)p);
80103575:	e9 26 ef ff ff       	jmp    801024a0 <kfree>
8010357a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103580 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103580:	55                   	push   %ebp
80103581:	89 e5                	mov    %esp,%ebp
80103583:	57                   	push   %edi
80103584:	56                   	push   %esi
80103585:	53                   	push   %ebx
80103586:	83 ec 28             	sub    $0x28,%esp
80103589:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010358c:	53                   	push   %ebx
8010358d:	e8 3e 0f 00 00       	call   801044d0 <acquire>
  for(i = 0; i < n; i++){
80103592:	8b 45 10             	mov    0x10(%ebp),%eax
80103595:	83 c4 10             	add    $0x10,%esp
80103598:	85 c0                	test   %eax,%eax
8010359a:	0f 8e c9 00 00 00    	jle    80103669 <pipewrite+0xe9>
801035a0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801035a3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801035a9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801035af:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801035b2:	03 4d 10             	add    0x10(%ebp),%ecx
801035b5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035b8:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801035be:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801035c4:	39 d0                	cmp    %edx,%eax
801035c6:	75 71                	jne    80103639 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
801035c8:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801035ce:	85 c0                	test   %eax,%eax
801035d0:	74 4e                	je     80103620 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035d2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801035d8:	eb 3a                	jmp    80103614 <pipewrite+0x94>
801035da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
801035e0:	83 ec 0c             	sub    $0xc,%esp
801035e3:	57                   	push   %edi
801035e4:	e8 d7 0a 00 00       	call   801040c0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035e9:	5a                   	pop    %edx
801035ea:	59                   	pop    %ecx
801035eb:	53                   	push   %ebx
801035ec:	56                   	push   %esi
801035ed:	e8 1e 09 00 00       	call   80103f10 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035f2:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801035f8:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801035fe:	83 c4 10             	add    $0x10,%esp
80103601:	05 00 02 00 00       	add    $0x200,%eax
80103606:	39 c2                	cmp    %eax,%edx
80103608:	75 36                	jne    80103640 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010360a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103610:	85 c0                	test   %eax,%eax
80103612:	74 0c                	je     80103620 <pipewrite+0xa0>
80103614:	e8 57 03 00 00       	call   80103970 <myproc>
80103619:	8b 40 24             	mov    0x24(%eax),%eax
8010361c:	85 c0                	test   %eax,%eax
8010361e:	74 c0                	je     801035e0 <pipewrite+0x60>
        release(&p->lock);
80103620:	83 ec 0c             	sub    $0xc,%esp
80103623:	53                   	push   %ebx
80103624:	e8 67 0f 00 00       	call   80104590 <release>
        return -1;
80103629:	83 c4 10             	add    $0x10,%esp
8010362c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103631:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103634:	5b                   	pop    %ebx
80103635:	5e                   	pop    %esi
80103636:	5f                   	pop    %edi
80103637:	5d                   	pop    %ebp
80103638:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103639:	89 c2                	mov    %eax,%edx
8010363b:	90                   	nop
8010363c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103640:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103643:	8d 42 01             	lea    0x1(%edx),%eax
80103646:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010364c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103652:	83 c6 01             	add    $0x1,%esi
80103655:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
80103659:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010365c:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010365f:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103663:	0f 85 4f ff ff ff    	jne    801035b8 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103669:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010366f:	83 ec 0c             	sub    $0xc,%esp
80103672:	50                   	push   %eax
80103673:	e8 48 0a 00 00       	call   801040c0 <wakeup>
  release(&p->lock);
80103678:	89 1c 24             	mov    %ebx,(%esp)
8010367b:	e8 10 0f 00 00       	call   80104590 <release>
  return n;
80103680:	83 c4 10             	add    $0x10,%esp
80103683:	8b 45 10             	mov    0x10(%ebp),%eax
80103686:	eb a9                	jmp    80103631 <pipewrite+0xb1>
80103688:	90                   	nop
80103689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103690 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103690:	55                   	push   %ebp
80103691:	89 e5                	mov    %esp,%ebp
80103693:	57                   	push   %edi
80103694:	56                   	push   %esi
80103695:	53                   	push   %ebx
80103696:	83 ec 18             	sub    $0x18,%esp
80103699:	8b 75 08             	mov    0x8(%ebp),%esi
8010369c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010369f:	56                   	push   %esi
801036a0:	e8 2b 0e 00 00       	call   801044d0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036a5:	83 c4 10             	add    $0x10,%esp
801036a8:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801036ae:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801036b4:	75 6a                	jne    80103720 <piperead+0x90>
801036b6:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
801036bc:	85 db                	test   %ebx,%ebx
801036be:	0f 84 c4 00 00 00    	je     80103788 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801036c4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801036ca:	eb 2d                	jmp    801036f9 <piperead+0x69>
801036cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036d0:	83 ec 08             	sub    $0x8,%esp
801036d3:	56                   	push   %esi
801036d4:	53                   	push   %ebx
801036d5:	e8 36 08 00 00       	call   80103f10 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036da:	83 c4 10             	add    $0x10,%esp
801036dd:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801036e3:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801036e9:	75 35                	jne    80103720 <piperead+0x90>
801036eb:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801036f1:	85 d2                	test   %edx,%edx
801036f3:	0f 84 8f 00 00 00    	je     80103788 <piperead+0xf8>
    if(myproc()->killed){
801036f9:	e8 72 02 00 00       	call   80103970 <myproc>
801036fe:	8b 48 24             	mov    0x24(%eax),%ecx
80103701:	85 c9                	test   %ecx,%ecx
80103703:	74 cb                	je     801036d0 <piperead+0x40>
      release(&p->lock);
80103705:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103708:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010370d:	56                   	push   %esi
8010370e:	e8 7d 0e 00 00       	call   80104590 <release>
      return -1;
80103713:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103716:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103719:	89 d8                	mov    %ebx,%eax
8010371b:	5b                   	pop    %ebx
8010371c:	5e                   	pop    %esi
8010371d:	5f                   	pop    %edi
8010371e:	5d                   	pop    %ebp
8010371f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103720:	8b 45 10             	mov    0x10(%ebp),%eax
80103723:	85 c0                	test   %eax,%eax
80103725:	7e 61                	jle    80103788 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103727:	31 db                	xor    %ebx,%ebx
80103729:	eb 13                	jmp    8010373e <piperead+0xae>
8010372b:	90                   	nop
8010372c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103730:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103736:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010373c:	74 1f                	je     8010375d <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010373e:	8d 41 01             	lea    0x1(%ecx),%eax
80103741:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103747:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010374d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103752:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103755:	83 c3 01             	add    $0x1,%ebx
80103758:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010375b:	75 d3                	jne    80103730 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010375d:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103763:	83 ec 0c             	sub    $0xc,%esp
80103766:	50                   	push   %eax
80103767:	e8 54 09 00 00       	call   801040c0 <wakeup>
  release(&p->lock);
8010376c:	89 34 24             	mov    %esi,(%esp)
8010376f:	e8 1c 0e 00 00       	call   80104590 <release>
  return i;
80103774:	83 c4 10             	add    $0x10,%esp
}
80103777:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010377a:	89 d8                	mov    %ebx,%eax
8010377c:	5b                   	pop    %ebx
8010377d:	5e                   	pop    %esi
8010377e:	5f                   	pop    %edi
8010377f:	5d                   	pop    %ebp
80103780:	c3                   	ret    
80103781:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103788:	31 db                	xor    %ebx,%ebx
8010378a:	eb d1                	jmp    8010375d <piperead+0xcd>
8010378c:	66 90                	xchg   %ax,%ax
8010378e:	66 90                	xchg   %ax,%ax

80103790 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103790:	55                   	push   %ebp
80103791:	89 e5                	mov    %esp,%ebp
80103793:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103794:	bb 94 2d 11 80       	mov    $0x80112d94,%ebx
{
80103799:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010379c:	68 60 2d 11 80       	push   $0x80112d60
801037a1:	e8 2a 0d 00 00       	call   801044d0 <acquire>
801037a6:	83 c4 10             	add    $0x10,%esp
801037a9:	eb 10                	jmp    801037bb <allocproc+0x2b>
801037ab:	90                   	nop
801037ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037b0:	83 eb 80             	sub    $0xffffff80,%ebx
801037b3:	81 fb 94 4d 11 80    	cmp    $0x80114d94,%ebx
801037b9:	73 75                	jae    80103830 <allocproc+0xa0>
    if(p->state == UNUSED)
801037bb:	8b 43 0c             	mov    0xc(%ebx),%eax
801037be:	85 c0                	test   %eax,%eax
801037c0:	75 ee                	jne    801037b0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037c2:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
801037c7:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801037ca:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801037d1:	8d 50 01             	lea    0x1(%eax),%edx
801037d4:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
801037d7:	68 60 2d 11 80       	push   $0x80112d60
  p->pid = nextpid++;
801037dc:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
801037e2:	e8 a9 0d 00 00       	call   80104590 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801037e7:	e8 64 ee ff ff       	call   80102650 <kalloc>
801037ec:	83 c4 10             	add    $0x10,%esp
801037ef:	85 c0                	test   %eax,%eax
801037f1:	89 43 08             	mov    %eax,0x8(%ebx)
801037f4:	74 53                	je     80103849 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037f6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801037fc:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
801037ff:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103804:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103807:	c7 40 14 1b 58 10 80 	movl   $0x8010581b,0x14(%eax)
  p->context = (struct context*)sp;
8010380e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103811:	6a 14                	push   $0x14
80103813:	6a 00                	push   $0x0
80103815:	50                   	push   %eax
80103816:	e8 c5 0d 00 00       	call   801045e0 <memset>
  p->context->eip = (uint)forkret;
8010381b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010381e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103821:	c7 40 10 60 38 10 80 	movl   $0x80103860,0x10(%eax)
}
80103828:	89 d8                	mov    %ebx,%eax
8010382a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010382d:	c9                   	leave  
8010382e:	c3                   	ret    
8010382f:	90                   	nop
  release(&ptable.lock);
80103830:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103833:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103835:	68 60 2d 11 80       	push   $0x80112d60
8010383a:	e8 51 0d 00 00       	call   80104590 <release>
}
8010383f:	89 d8                	mov    %ebx,%eax
  return 0;
80103841:	83 c4 10             	add    $0x10,%esp
}
80103844:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103847:	c9                   	leave  
80103848:	c3                   	ret    
    p->state = UNUSED;
80103849:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103850:	31 db                	xor    %ebx,%ebx
80103852:	eb d4                	jmp    80103828 <allocproc+0x98>
80103854:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010385a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103860 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103860:	55                   	push   %ebp
80103861:	89 e5                	mov    %esp,%ebp
80103863:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103866:	68 60 2d 11 80       	push   $0x80112d60
8010386b:	e8 20 0d 00 00       	call   80104590 <release>

  if (first) {
80103870:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103875:	83 c4 10             	add    $0x10,%esp
80103878:	85 c0                	test   %eax,%eax
8010387a:	75 04                	jne    80103880 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010387c:	c9                   	leave  
8010387d:	c3                   	ret    
8010387e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103880:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103883:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010388a:	00 00 00 
    iinit(ROOTDEV);
8010388d:	6a 01                	push   $0x1
8010388f:	e8 3c dd ff ff       	call   801015d0 <iinit>
    initlog(ROOTDEV);
80103894:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010389b:	e8 f0 f3 ff ff       	call   80102c90 <initlog>
801038a0:	83 c4 10             	add    $0x10,%esp
}
801038a3:	c9                   	leave  
801038a4:	c3                   	ret    
801038a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801038b0 <pinit>:
{
801038b0:	55                   	push   %ebp
801038b1:	89 e5                	mov    %esp,%ebp
801038b3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801038b6:	68 f5 75 10 80       	push   $0x801075f5
801038bb:	68 60 2d 11 80       	push   $0x80112d60
801038c0:	e8 cb 0a 00 00       	call   80104390 <initlock>
}
801038c5:	83 c4 10             	add    $0x10,%esp
801038c8:	c9                   	leave  
801038c9:	c3                   	ret    
801038ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801038d0 <mycpu>:
{
801038d0:	55                   	push   %ebp
801038d1:	89 e5                	mov    %esp,%ebp
801038d3:	56                   	push   %esi
801038d4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801038d5:	9c                   	pushf  
801038d6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801038d7:	f6 c4 02             	test   $0x2,%ah
801038da:	75 5e                	jne    8010393a <mycpu+0x6a>
  apicid = lapicid();
801038dc:	e8 df ef ff ff       	call   801028c0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801038e1:	8b 35 40 2d 11 80    	mov    0x80112d40,%esi
801038e7:	85 f6                	test   %esi,%esi
801038e9:	7e 42                	jle    8010392d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801038eb:	0f b6 15 c0 27 11 80 	movzbl 0x801127c0,%edx
801038f2:	39 d0                	cmp    %edx,%eax
801038f4:	74 30                	je     80103926 <mycpu+0x56>
801038f6:	b9 70 28 11 80       	mov    $0x80112870,%ecx
  for (i = 0; i < ncpu; ++i) {
801038fb:	31 d2                	xor    %edx,%edx
801038fd:	8d 76 00             	lea    0x0(%esi),%esi
80103900:	83 c2 01             	add    $0x1,%edx
80103903:	39 f2                	cmp    %esi,%edx
80103905:	74 26                	je     8010392d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103907:	0f b6 19             	movzbl (%ecx),%ebx
8010390a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103910:	39 c3                	cmp    %eax,%ebx
80103912:	75 ec                	jne    80103900 <mycpu+0x30>
80103914:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
8010391a:	05 c0 27 11 80       	add    $0x801127c0,%eax
}
8010391f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103922:	5b                   	pop    %ebx
80103923:	5e                   	pop    %esi
80103924:	5d                   	pop    %ebp
80103925:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103926:	b8 c0 27 11 80       	mov    $0x801127c0,%eax
      return &cpus[i];
8010392b:	eb f2                	jmp    8010391f <mycpu+0x4f>
  panic("unknown apicid\n");
8010392d:	83 ec 0c             	sub    $0xc,%esp
80103930:	68 fc 75 10 80       	push   $0x801075fc
80103935:	e8 26 cb ff ff       	call   80100460 <panic>
    panic("mycpu called with interrupts enabled\n");
8010393a:	83 ec 0c             	sub    $0xc,%esp
8010393d:	68 d8 76 10 80       	push   $0x801076d8
80103942:	e8 19 cb ff ff       	call   80100460 <panic>
80103947:	89 f6                	mov    %esi,%esi
80103949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103950 <cpuid>:
cpuid() {
80103950:	55                   	push   %ebp
80103951:	89 e5                	mov    %esp,%ebp
80103953:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103956:	e8 75 ff ff ff       	call   801038d0 <mycpu>
8010395b:	2d c0 27 11 80       	sub    $0x801127c0,%eax
}
80103960:	c9                   	leave  
  return mycpu()-cpus;
80103961:	c1 f8 04             	sar    $0x4,%eax
80103964:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010396a:	c3                   	ret    
8010396b:	90                   	nop
8010396c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103970 <myproc>:
myproc(void) {
80103970:	55                   	push   %ebp
80103971:	89 e5                	mov    %esp,%ebp
80103973:	53                   	push   %ebx
80103974:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103977:	e8 84 0a 00 00       	call   80104400 <pushcli>
  c = mycpu();
8010397c:	e8 4f ff ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103981:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103987:	e8 b4 0a 00 00       	call   80104440 <popcli>
}
8010398c:	83 c4 04             	add    $0x4,%esp
8010398f:	89 d8                	mov    %ebx,%eax
80103991:	5b                   	pop    %ebx
80103992:	5d                   	pop    %ebp
80103993:	c3                   	ret    
80103994:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010399a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801039a0 <userinit>:
{
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	53                   	push   %ebx
801039a4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801039a7:	e8 e4 fd ff ff       	call   80103790 <allocproc>
801039ac:	89 c3                	mov    %eax,%ebx
  initproc = p;
801039ae:	a3 d8 a5 10 80       	mov    %eax,0x8010a5d8
  if((p->pgdir = setupkvm()) == 0)
801039b3:	e8 38 34 00 00       	call   80106df0 <setupkvm>
801039b8:	85 c0                	test   %eax,%eax
801039ba:	89 43 04             	mov    %eax,0x4(%ebx)
801039bd:	0f 84 bd 00 00 00    	je     80103a80 <userinit+0xe0>
  inituvm(p->pgdir, _binary_user_initcode_start, (int)_binary_user_initcode_size);
801039c3:	83 ec 04             	sub    $0x4,%esp
801039c6:	68 2c 00 00 00       	push   $0x2c
801039cb:	68 60 a4 10 80       	push   $0x8010a460
801039d0:	50                   	push   %eax
801039d1:	e8 fa 30 00 00       	call   80106ad0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801039d6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801039d9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801039df:	6a 4c                	push   $0x4c
801039e1:	6a 00                	push   $0x0
801039e3:	ff 73 18             	pushl  0x18(%ebx)
801039e6:	e8 f5 0b 00 00       	call   801045e0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039eb:	8b 43 18             	mov    0x18(%ebx),%eax
801039ee:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039f3:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801039f8:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039fb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039ff:	8b 43 18             	mov    0x18(%ebx),%eax
80103a02:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103a06:	8b 43 18             	mov    0x18(%ebx),%eax
80103a09:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a0d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103a11:	8b 43 18             	mov    0x18(%ebx),%eax
80103a14:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a18:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103a1c:	8b 43 18             	mov    0x18(%ebx),%eax
80103a1f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103a26:	8b 43 18             	mov    0x18(%ebx),%eax
80103a29:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a30:	8b 43 18             	mov    0x18(%ebx),%eax
80103a33:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a3a:	8d 43 70             	lea    0x70(%ebx),%eax
80103a3d:	6a 10                	push   $0x10
80103a3f:	68 25 76 10 80       	push   $0x80107625
80103a44:	50                   	push   %eax
80103a45:	e8 76 0d 00 00       	call   801047c0 <safestrcpy>
  p->cwd = namei("/");
80103a4a:	c7 04 24 2e 76 10 80 	movl   $0x8010762e,(%esp)
80103a51:	e8 1a e6 ff ff       	call   80102070 <namei>
80103a56:	89 43 6c             	mov    %eax,0x6c(%ebx)
  acquire(&ptable.lock);
80103a59:	c7 04 24 60 2d 11 80 	movl   $0x80112d60,(%esp)
80103a60:	e8 6b 0a 00 00       	call   801044d0 <acquire>
  p->state = RUNNABLE;
80103a65:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103a6c:	c7 04 24 60 2d 11 80 	movl   $0x80112d60,(%esp)
80103a73:	e8 18 0b 00 00       	call   80104590 <release>
}
80103a78:	83 c4 10             	add    $0x10,%esp
80103a7b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a7e:	c9                   	leave  
80103a7f:	c3                   	ret    
    panic("userinit: out of memory?");
80103a80:	83 ec 0c             	sub    $0xc,%esp
80103a83:	68 0c 76 10 80       	push   $0x8010760c
80103a88:	e8 d3 c9 ff ff       	call   80100460 <panic>
80103a8d:	8d 76 00             	lea    0x0(%esi),%esi

80103a90 <growproc>:
{
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	56                   	push   %esi
80103a94:	53                   	push   %ebx
80103a95:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103a98:	e8 63 09 00 00       	call   80104400 <pushcli>
  c = mycpu();
80103a9d:	e8 2e fe ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103aa2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103aa8:	e8 93 09 00 00       	call   80104440 <popcli>
  if(n > 0){
80103aad:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103ab0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103ab2:	7f 1c                	jg     80103ad0 <growproc+0x40>
  } else if(n < 0){
80103ab4:	75 3a                	jne    80103af0 <growproc+0x60>
  switchuvm(curproc);
80103ab6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103ab9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103abb:	53                   	push   %ebx
80103abc:	e8 ff 2e 00 00       	call   801069c0 <switchuvm>
  return 0;
80103ac1:	83 c4 10             	add    $0x10,%esp
80103ac4:	31 c0                	xor    %eax,%eax
}
80103ac6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ac9:	5b                   	pop    %ebx
80103aca:	5e                   	pop    %esi
80103acb:	5d                   	pop    %ebp
80103acc:	c3                   	ret    
80103acd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ad0:	83 ec 04             	sub    $0x4,%esp
80103ad3:	01 c6                	add    %eax,%esi
80103ad5:	56                   	push   %esi
80103ad6:	50                   	push   %eax
80103ad7:	ff 73 04             	pushl  0x4(%ebx)
80103ada:	e8 31 31 00 00       	call   80106c10 <allocuvm>
80103adf:	83 c4 10             	add    $0x10,%esp
80103ae2:	85 c0                	test   %eax,%eax
80103ae4:	75 d0                	jne    80103ab6 <growproc+0x26>
      return -1;
80103ae6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103aeb:	eb d9                	jmp    80103ac6 <growproc+0x36>
80103aed:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103af0:	83 ec 04             	sub    $0x4,%esp
80103af3:	01 c6                	add    %eax,%esi
80103af5:	56                   	push   %esi
80103af6:	50                   	push   %eax
80103af7:	ff 73 04             	pushl  0x4(%ebx)
80103afa:	e8 41 32 00 00       	call   80106d40 <deallocuvm>
80103aff:	83 c4 10             	add    $0x10,%esp
80103b02:	85 c0                	test   %eax,%eax
80103b04:	75 b0                	jne    80103ab6 <growproc+0x26>
80103b06:	eb de                	jmp    80103ae6 <growproc+0x56>
80103b08:	90                   	nop
80103b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103b10 <fork>:
{
80103b10:	55                   	push   %ebp
80103b11:	89 e5                	mov    %esp,%ebp
80103b13:	57                   	push   %edi
80103b14:	56                   	push   %esi
80103b15:	53                   	push   %ebx
80103b16:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103b19:	e8 e2 08 00 00       	call   80104400 <pushcli>
  c = mycpu();
80103b1e:	e8 ad fd ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103b23:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b29:	e8 12 09 00 00       	call   80104440 <popcli>
  if((np = allocproc()) == 0){
80103b2e:	e8 5d fc ff ff       	call   80103790 <allocproc>
80103b33:	85 c0                	test   %eax,%eax
80103b35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b38:	0f 84 b7 00 00 00    	je     80103bf5 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b3e:	83 ec 08             	sub    $0x8,%esp
80103b41:	ff 33                	pushl  (%ebx)
80103b43:	ff 73 04             	pushl  0x4(%ebx)
80103b46:	89 c7                	mov    %eax,%edi
80103b48:	e8 73 33 00 00       	call   80106ec0 <copyuvm>
80103b4d:	83 c4 10             	add    $0x10,%esp
80103b50:	85 c0                	test   %eax,%eax
80103b52:	89 47 04             	mov    %eax,0x4(%edi)
80103b55:	0f 84 a1 00 00 00    	je     80103bfc <fork+0xec>
  np->sz = curproc->sz;
80103b5b:	8b 03                	mov    (%ebx),%eax
80103b5d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103b60:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103b62:	89 59 14             	mov    %ebx,0x14(%ecx)
80103b65:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
80103b67:	8b 79 18             	mov    0x18(%ecx),%edi
80103b6a:	8b 73 18             	mov    0x18(%ebx),%esi
80103b6d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103b72:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103b74:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103b76:	8b 40 18             	mov    0x18(%eax),%eax
80103b79:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103b80:	8b 44 b3 2c          	mov    0x2c(%ebx,%esi,4),%eax
80103b84:	85 c0                	test   %eax,%eax
80103b86:	74 13                	je     80103b9b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103b88:	83 ec 0c             	sub    $0xc,%esp
80103b8b:	50                   	push   %eax
80103b8c:	e8 4f d3 ff ff       	call   80100ee0 <filedup>
80103b91:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b94:	83 c4 10             	add    $0x10,%esp
80103b97:	89 44 b2 2c          	mov    %eax,0x2c(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103b9b:	83 c6 01             	add    $0x1,%esi
80103b9e:	83 fe 10             	cmp    $0x10,%esi
80103ba1:	75 dd                	jne    80103b80 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103ba3:	83 ec 0c             	sub    $0xc,%esp
80103ba6:	ff 73 6c             	pushl  0x6c(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ba9:	83 c3 70             	add    $0x70,%ebx
  np->cwd = idup(curproc->cwd);
80103bac:	e8 ef db ff ff       	call   801017a0 <idup>
80103bb1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103bb4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103bb7:	89 47 6c             	mov    %eax,0x6c(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103bba:	8d 47 70             	lea    0x70(%edi),%eax
80103bbd:	6a 10                	push   $0x10
80103bbf:	53                   	push   %ebx
80103bc0:	50                   	push   %eax
80103bc1:	e8 fa 0b 00 00       	call   801047c0 <safestrcpy>
  pid = np->pid;
80103bc6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103bc9:	c7 04 24 60 2d 11 80 	movl   $0x80112d60,(%esp)
80103bd0:	e8 fb 08 00 00       	call   801044d0 <acquire>
  np->state = RUNNABLE;
80103bd5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103bdc:	c7 04 24 60 2d 11 80 	movl   $0x80112d60,(%esp)
80103be3:	e8 a8 09 00 00       	call   80104590 <release>
  return pid;
80103be8:	83 c4 10             	add    $0x10,%esp
}
80103beb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bee:	89 d8                	mov    %ebx,%eax
80103bf0:	5b                   	pop    %ebx
80103bf1:	5e                   	pop    %esi
80103bf2:	5f                   	pop    %edi
80103bf3:	5d                   	pop    %ebp
80103bf4:	c3                   	ret    
    return -1;
80103bf5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103bfa:	eb ef                	jmp    80103beb <fork+0xdb>
    kfree(np->kstack);
80103bfc:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103bff:	83 ec 0c             	sub    $0xc,%esp
80103c02:	ff 73 08             	pushl  0x8(%ebx)
80103c05:	e8 96 e8 ff ff       	call   801024a0 <kfree>
    np->kstack = 0;
80103c0a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103c11:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103c18:	83 c4 10             	add    $0x10,%esp
80103c1b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103c20:	eb c9                	jmp    80103beb <fork+0xdb>
80103c22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c30 <scheduler>:
{
80103c30:	55                   	push   %ebp
80103c31:	89 e5                	mov    %esp,%ebp
80103c33:	57                   	push   %edi
80103c34:	56                   	push   %esi
80103c35:	53                   	push   %ebx
80103c36:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103c39:	e8 92 fc ff ff       	call   801038d0 <mycpu>
80103c3e:	8d 78 04             	lea    0x4(%eax),%edi
80103c41:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103c43:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103c4a:	00 00 00 
80103c4d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103c50:	fb                   	sti    
    acquire(&ptable.lock);
80103c51:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c54:	bb 94 2d 11 80       	mov    $0x80112d94,%ebx
    acquire(&ptable.lock);
80103c59:	68 60 2d 11 80       	push   $0x80112d60
80103c5e:	e8 6d 08 00 00       	call   801044d0 <acquire>
80103c63:	83 c4 10             	add    $0x10,%esp
80103c66:	8d 76 00             	lea    0x0(%esi),%esi
80103c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
80103c70:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103c74:	75 33                	jne    80103ca9 <scheduler+0x79>
      switchuvm(p);
80103c76:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103c79:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103c7f:	53                   	push   %ebx
80103c80:	e8 3b 2d 00 00       	call   801069c0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103c85:	58                   	pop    %eax
80103c86:	5a                   	pop    %edx
80103c87:	ff 73 1c             	pushl  0x1c(%ebx)
80103c8a:	57                   	push   %edi
      p->state = RUNNING;
80103c8b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103c92:	e8 84 0b 00 00       	call   8010481b <swtch>
      switchkvm();
80103c97:	e8 04 2d 00 00       	call   801069a0 <switchkvm>
      c->proc = 0;
80103c9c:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103ca3:	00 00 00 
80103ca6:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ca9:	83 eb 80             	sub    $0xffffff80,%ebx
80103cac:	81 fb 94 4d 11 80    	cmp    $0x80114d94,%ebx
80103cb2:	72 bc                	jb     80103c70 <scheduler+0x40>
    release(&ptable.lock);
80103cb4:	83 ec 0c             	sub    $0xc,%esp
80103cb7:	68 60 2d 11 80       	push   $0x80112d60
80103cbc:	e8 cf 08 00 00       	call   80104590 <release>
    sti();
80103cc1:	83 c4 10             	add    $0x10,%esp
80103cc4:	eb 8a                	jmp    80103c50 <scheduler+0x20>
80103cc6:	8d 76 00             	lea    0x0(%esi),%esi
80103cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103cd0 <sched>:
{
80103cd0:	55                   	push   %ebp
80103cd1:	89 e5                	mov    %esp,%ebp
80103cd3:	56                   	push   %esi
80103cd4:	53                   	push   %ebx
  pushcli();
80103cd5:	e8 26 07 00 00       	call   80104400 <pushcli>
  c = mycpu();
80103cda:	e8 f1 fb ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103cdf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ce5:	e8 56 07 00 00       	call   80104440 <popcli>
  if(!holding(&ptable.lock))
80103cea:	83 ec 0c             	sub    $0xc,%esp
80103ced:	68 60 2d 11 80       	push   $0x80112d60
80103cf2:	e8 a9 07 00 00       	call   801044a0 <holding>
80103cf7:	83 c4 10             	add    $0x10,%esp
80103cfa:	85 c0                	test   %eax,%eax
80103cfc:	74 4f                	je     80103d4d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103cfe:	e8 cd fb ff ff       	call   801038d0 <mycpu>
80103d03:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103d0a:	75 68                	jne    80103d74 <sched+0xa4>
  if(p->state == RUNNING)
80103d0c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103d10:	74 55                	je     80103d67 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103d12:	9c                   	pushf  
80103d13:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103d14:	f6 c4 02             	test   $0x2,%ah
80103d17:	75 41                	jne    80103d5a <sched+0x8a>
  intena = mycpu()->intena;
80103d19:	e8 b2 fb ff ff       	call   801038d0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103d1e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103d21:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103d27:	e8 a4 fb ff ff       	call   801038d0 <mycpu>
80103d2c:	83 ec 08             	sub    $0x8,%esp
80103d2f:	ff 70 04             	pushl  0x4(%eax)
80103d32:	53                   	push   %ebx
80103d33:	e8 e3 0a 00 00       	call   8010481b <swtch>
  mycpu()->intena = intena;
80103d38:	e8 93 fb ff ff       	call   801038d0 <mycpu>
}
80103d3d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103d40:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103d46:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d49:	5b                   	pop    %ebx
80103d4a:	5e                   	pop    %esi
80103d4b:	5d                   	pop    %ebp
80103d4c:	c3                   	ret    
    panic("sched ptable.lock");
80103d4d:	83 ec 0c             	sub    $0xc,%esp
80103d50:	68 30 76 10 80       	push   $0x80107630
80103d55:	e8 06 c7 ff ff       	call   80100460 <panic>
    panic("sched interruptible");
80103d5a:	83 ec 0c             	sub    $0xc,%esp
80103d5d:	68 5c 76 10 80       	push   $0x8010765c
80103d62:	e8 f9 c6 ff ff       	call   80100460 <panic>
    panic("sched running");
80103d67:	83 ec 0c             	sub    $0xc,%esp
80103d6a:	68 4e 76 10 80       	push   $0x8010764e
80103d6f:	e8 ec c6 ff ff       	call   80100460 <panic>
    panic("sched locks");
80103d74:	83 ec 0c             	sub    $0xc,%esp
80103d77:	68 42 76 10 80       	push   $0x80107642
80103d7c:	e8 df c6 ff ff       	call   80100460 <panic>
80103d81:	eb 0d                	jmp    80103d90 <exit>
80103d83:	90                   	nop
80103d84:	90                   	nop
80103d85:	90                   	nop
80103d86:	90                   	nop
80103d87:	90                   	nop
80103d88:	90                   	nop
80103d89:	90                   	nop
80103d8a:	90                   	nop
80103d8b:	90                   	nop
80103d8c:	90                   	nop
80103d8d:	90                   	nop
80103d8e:	90                   	nop
80103d8f:	90                   	nop

80103d90 <exit>:
{
80103d90:	55                   	push   %ebp
80103d91:	89 e5                	mov    %esp,%ebp
80103d93:	57                   	push   %edi
80103d94:	56                   	push   %esi
80103d95:	53                   	push   %ebx
80103d96:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103d99:	e8 62 06 00 00       	call   80104400 <pushcli>
  c = mycpu();
80103d9e:	e8 2d fb ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103da3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103da9:	e8 92 06 00 00       	call   80104440 <popcli>
  if(curproc == initproc)
80103dae:	39 35 d8 a5 10 80    	cmp    %esi,0x8010a5d8
80103db4:	8d 5e 2c             	lea    0x2c(%esi),%ebx
80103db7:	8d 7e 6c             	lea    0x6c(%esi),%edi
80103dba:	0f 84 e7 00 00 00    	je     80103ea7 <exit+0x117>
    if(curproc->ofile[fd]){
80103dc0:	8b 03                	mov    (%ebx),%eax
80103dc2:	85 c0                	test   %eax,%eax
80103dc4:	74 12                	je     80103dd8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103dc6:	83 ec 0c             	sub    $0xc,%esp
80103dc9:	50                   	push   %eax
80103dca:	e8 61 d1 ff ff       	call   80100f30 <fileclose>
      curproc->ofile[fd] = 0;
80103dcf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103dd5:	83 c4 10             	add    $0x10,%esp
80103dd8:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103ddb:	39 fb                	cmp    %edi,%ebx
80103ddd:	75 e1                	jne    80103dc0 <exit+0x30>
  begin_op();
80103ddf:	e8 4c ef ff ff       	call   80102d30 <begin_op>
  iput(curproc->cwd);
80103de4:	83 ec 0c             	sub    $0xc,%esp
80103de7:	ff 76 6c             	pushl  0x6c(%esi)
80103dea:	e8 11 db ff ff       	call   80101900 <iput>
  end_op();
80103def:	e8 ac ef ff ff       	call   80102da0 <end_op>
  curproc->cwd = 0;
80103df4:	c7 46 6c 00 00 00 00 	movl   $0x0,0x6c(%esi)
  acquire(&ptable.lock);
80103dfb:	c7 04 24 60 2d 11 80 	movl   $0x80112d60,(%esp)
80103e02:	e8 c9 06 00 00       	call   801044d0 <acquire>
  wakeup1(curproc->parent);
80103e07:	8b 56 14             	mov    0x14(%esi),%edx
80103e0a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e0d:	b8 94 2d 11 80       	mov    $0x80112d94,%eax
80103e12:	eb 0e                	jmp    80103e22 <exit+0x92>
80103e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e18:	83 e8 80             	sub    $0xffffff80,%eax
80103e1b:	3d 94 4d 11 80       	cmp    $0x80114d94,%eax
80103e20:	73 1c                	jae    80103e3e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103e22:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e26:	75 f0                	jne    80103e18 <exit+0x88>
80103e28:	3b 50 20             	cmp    0x20(%eax),%edx
80103e2b:	75 eb                	jne    80103e18 <exit+0x88>
      p->state = RUNNABLE;
80103e2d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e34:	83 e8 80             	sub    $0xffffff80,%eax
80103e37:	3d 94 4d 11 80       	cmp    $0x80114d94,%eax
80103e3c:	72 e4                	jb     80103e22 <exit+0x92>
      p->parent = initproc;
80103e3e:	8b 0d d8 a5 10 80    	mov    0x8010a5d8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e44:	ba 94 2d 11 80       	mov    $0x80112d94,%edx
80103e49:	eb 10                	jmp    80103e5b <exit+0xcb>
80103e4b:	90                   	nop
80103e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e50:	83 ea 80             	sub    $0xffffff80,%edx
80103e53:	81 fa 94 4d 11 80    	cmp    $0x80114d94,%edx
80103e59:	73 33                	jae    80103e8e <exit+0xfe>
    if(p->parent == curproc){
80103e5b:	39 72 14             	cmp    %esi,0x14(%edx)
80103e5e:	75 f0                	jne    80103e50 <exit+0xc0>
      if(p->state == ZOMBIE)
80103e60:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103e64:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103e67:	75 e7                	jne    80103e50 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e69:	b8 94 2d 11 80       	mov    $0x80112d94,%eax
80103e6e:	eb 0a                	jmp    80103e7a <exit+0xea>
80103e70:	83 e8 80             	sub    $0xffffff80,%eax
80103e73:	3d 94 4d 11 80       	cmp    $0x80114d94,%eax
80103e78:	73 d6                	jae    80103e50 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103e7a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e7e:	75 f0                	jne    80103e70 <exit+0xe0>
80103e80:	3b 48 20             	cmp    0x20(%eax),%ecx
80103e83:	75 eb                	jne    80103e70 <exit+0xe0>
      p->state = RUNNABLE;
80103e85:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e8c:	eb e2                	jmp    80103e70 <exit+0xe0>
  curproc->state = ZOMBIE;
80103e8e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103e95:	e8 36 fe ff ff       	call   80103cd0 <sched>
  panic("zombie exit");
80103e9a:	83 ec 0c             	sub    $0xc,%esp
80103e9d:	68 7d 76 10 80       	push   $0x8010767d
80103ea2:	e8 b9 c5 ff ff       	call   80100460 <panic>
    panic("init exiting");
80103ea7:	83 ec 0c             	sub    $0xc,%esp
80103eaa:	68 70 76 10 80       	push   $0x80107670
80103eaf:	e8 ac c5 ff ff       	call   80100460 <panic>
80103eb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103eba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103ec0 <yield>:
{
80103ec0:	55                   	push   %ebp
80103ec1:	89 e5                	mov    %esp,%ebp
80103ec3:	53                   	push   %ebx
80103ec4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103ec7:	68 60 2d 11 80       	push   $0x80112d60
80103ecc:	e8 ff 05 00 00       	call   801044d0 <acquire>
  pushcli();
80103ed1:	e8 2a 05 00 00       	call   80104400 <pushcli>
  c = mycpu();
80103ed6:	e8 f5 f9 ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103edb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ee1:	e8 5a 05 00 00       	call   80104440 <popcli>
  myproc()->state = RUNNABLE;
80103ee6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103eed:	e8 de fd ff ff       	call   80103cd0 <sched>
  release(&ptable.lock);
80103ef2:	c7 04 24 60 2d 11 80 	movl   $0x80112d60,(%esp)
80103ef9:	e8 92 06 00 00       	call   80104590 <release>
}
80103efe:	83 c4 10             	add    $0x10,%esp
80103f01:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f04:	c9                   	leave  
80103f05:	c3                   	ret    
80103f06:	8d 76 00             	lea    0x0(%esi),%esi
80103f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f10 <sleep>:
{
80103f10:	55                   	push   %ebp
80103f11:	89 e5                	mov    %esp,%ebp
80103f13:	57                   	push   %edi
80103f14:	56                   	push   %esi
80103f15:	53                   	push   %ebx
80103f16:	83 ec 0c             	sub    $0xc,%esp
80103f19:	8b 7d 08             	mov    0x8(%ebp),%edi
80103f1c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103f1f:	e8 dc 04 00 00       	call   80104400 <pushcli>
  c = mycpu();
80103f24:	e8 a7 f9 ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103f29:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f2f:	e8 0c 05 00 00       	call   80104440 <popcli>
  if(p == 0)
80103f34:	85 db                	test   %ebx,%ebx
80103f36:	0f 84 87 00 00 00    	je     80103fc3 <sleep+0xb3>
  if(lk == 0)
80103f3c:	85 f6                	test   %esi,%esi
80103f3e:	74 76                	je     80103fb6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103f40:	81 fe 60 2d 11 80    	cmp    $0x80112d60,%esi
80103f46:	74 50                	je     80103f98 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103f48:	83 ec 0c             	sub    $0xc,%esp
80103f4b:	68 60 2d 11 80       	push   $0x80112d60
80103f50:	e8 7b 05 00 00       	call   801044d0 <acquire>
    release(lk);
80103f55:	89 34 24             	mov    %esi,(%esp)
80103f58:	e8 33 06 00 00       	call   80104590 <release>
  p->chan = chan;
80103f5d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f60:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f67:	e8 64 fd ff ff       	call   80103cd0 <sched>
  p->chan = 0;
80103f6c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103f73:	c7 04 24 60 2d 11 80 	movl   $0x80112d60,(%esp)
80103f7a:	e8 11 06 00 00       	call   80104590 <release>
    acquire(lk);
80103f7f:	89 75 08             	mov    %esi,0x8(%ebp)
80103f82:	83 c4 10             	add    $0x10,%esp
}
80103f85:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f88:	5b                   	pop    %ebx
80103f89:	5e                   	pop    %esi
80103f8a:	5f                   	pop    %edi
80103f8b:	5d                   	pop    %ebp
    acquire(lk);
80103f8c:	e9 3f 05 00 00       	jmp    801044d0 <acquire>
80103f91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103f98:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f9b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103fa2:	e8 29 fd ff ff       	call   80103cd0 <sched>
  p->chan = 0;
80103fa7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103fae:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103fb1:	5b                   	pop    %ebx
80103fb2:	5e                   	pop    %esi
80103fb3:	5f                   	pop    %edi
80103fb4:	5d                   	pop    %ebp
80103fb5:	c3                   	ret    
    panic("sleep without lk");
80103fb6:	83 ec 0c             	sub    $0xc,%esp
80103fb9:	68 8f 76 10 80       	push   $0x8010768f
80103fbe:	e8 9d c4 ff ff       	call   80100460 <panic>
    panic("sleep");
80103fc3:	83 ec 0c             	sub    $0xc,%esp
80103fc6:	68 89 76 10 80       	push   $0x80107689
80103fcb:	e8 90 c4 ff ff       	call   80100460 <panic>

80103fd0 <wait>:
{
80103fd0:	55                   	push   %ebp
80103fd1:	89 e5                	mov    %esp,%ebp
80103fd3:	56                   	push   %esi
80103fd4:	53                   	push   %ebx
  pushcli();
80103fd5:	e8 26 04 00 00       	call   80104400 <pushcli>
  c = mycpu();
80103fda:	e8 f1 f8 ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103fdf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103fe5:	e8 56 04 00 00       	call   80104440 <popcli>
  acquire(&ptable.lock);
80103fea:	83 ec 0c             	sub    $0xc,%esp
80103fed:	68 60 2d 11 80       	push   $0x80112d60
80103ff2:	e8 d9 04 00 00       	call   801044d0 <acquire>
80103ff7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103ffa:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ffc:	bb 94 2d 11 80       	mov    $0x80112d94,%ebx
80104001:	eb 10                	jmp    80104013 <wait+0x43>
80104003:	90                   	nop
80104004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104008:	83 eb 80             	sub    $0xffffff80,%ebx
8010400b:	81 fb 94 4d 11 80    	cmp    $0x80114d94,%ebx
80104011:	73 1b                	jae    8010402e <wait+0x5e>
      if(p->parent != curproc)
80104013:	39 73 14             	cmp    %esi,0x14(%ebx)
80104016:	75 f0                	jne    80104008 <wait+0x38>
      if(p->state == ZOMBIE){
80104018:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010401c:	74 32                	je     80104050 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010401e:	83 eb 80             	sub    $0xffffff80,%ebx
      havekids = 1;
80104021:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104026:	81 fb 94 4d 11 80    	cmp    $0x80114d94,%ebx
8010402c:	72 e5                	jb     80104013 <wait+0x43>
    if(!havekids || curproc->killed){
8010402e:	85 c0                	test   %eax,%eax
80104030:	74 74                	je     801040a6 <wait+0xd6>
80104032:	8b 46 24             	mov    0x24(%esi),%eax
80104035:	85 c0                	test   %eax,%eax
80104037:	75 6d                	jne    801040a6 <wait+0xd6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104039:	83 ec 08             	sub    $0x8,%esp
8010403c:	68 60 2d 11 80       	push   $0x80112d60
80104041:	56                   	push   %esi
80104042:	e8 c9 fe ff ff       	call   80103f10 <sleep>
    havekids = 0;
80104047:	83 c4 10             	add    $0x10,%esp
8010404a:	eb ae                	jmp    80103ffa <wait+0x2a>
8010404c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80104050:	83 ec 0c             	sub    $0xc,%esp
80104053:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80104056:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104059:	e8 42 e4 ff ff       	call   801024a0 <kfree>
        freevm(p->pgdir);
8010405e:	5a                   	pop    %edx
8010405f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80104062:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104069:	e8 02 2d 00 00       	call   80106d70 <freevm>
        release(&ptable.lock);
8010406e:	c7 04 24 60 2d 11 80 	movl   $0x80112d60,(%esp)
        p->pid = 0;
80104075:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
8010407c:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104083:	c6 43 70 00          	movb   $0x0,0x70(%ebx)
        p->killed = 0;
80104087:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010408e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104095:	e8 f6 04 00 00       	call   80104590 <release>
        return pid;
8010409a:	83 c4 10             	add    $0x10,%esp
}
8010409d:	8d 65 f8             	lea    -0x8(%ebp),%esp
801040a0:	89 f0                	mov    %esi,%eax
801040a2:	5b                   	pop    %ebx
801040a3:	5e                   	pop    %esi
801040a4:	5d                   	pop    %ebp
801040a5:	c3                   	ret    
      release(&ptable.lock);
801040a6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801040a9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801040ae:	68 60 2d 11 80       	push   $0x80112d60
801040b3:	e8 d8 04 00 00       	call   80104590 <release>
      return -1;
801040b8:	83 c4 10             	add    $0x10,%esp
801040bb:	eb e0                	jmp    8010409d <wait+0xcd>
801040bd:	8d 76 00             	lea    0x0(%esi),%esi

801040c0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801040c0:	55                   	push   %ebp
801040c1:	89 e5                	mov    %esp,%ebp
801040c3:	53                   	push   %ebx
801040c4:	83 ec 10             	sub    $0x10,%esp
801040c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801040ca:	68 60 2d 11 80       	push   $0x80112d60
801040cf:	e8 fc 03 00 00       	call   801044d0 <acquire>
801040d4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040d7:	b8 94 2d 11 80       	mov    $0x80112d94,%eax
801040dc:	eb 0c                	jmp    801040ea <wakeup+0x2a>
801040de:	66 90                	xchg   %ax,%ax
801040e0:	83 e8 80             	sub    $0xffffff80,%eax
801040e3:	3d 94 4d 11 80       	cmp    $0x80114d94,%eax
801040e8:	73 1c                	jae    80104106 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
801040ea:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801040ee:	75 f0                	jne    801040e0 <wakeup+0x20>
801040f0:	3b 58 20             	cmp    0x20(%eax),%ebx
801040f3:	75 eb                	jne    801040e0 <wakeup+0x20>
      p->state = RUNNABLE;
801040f5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040fc:	83 e8 80             	sub    $0xffffff80,%eax
801040ff:	3d 94 4d 11 80       	cmp    $0x80114d94,%eax
80104104:	72 e4                	jb     801040ea <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104106:	c7 45 08 60 2d 11 80 	movl   $0x80112d60,0x8(%ebp)
}
8010410d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104110:	c9                   	leave  
  release(&ptable.lock);
80104111:	e9 7a 04 00 00       	jmp    80104590 <release>
80104116:	8d 76 00             	lea    0x0(%esi),%esi
80104119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104120 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104120:	55                   	push   %ebp
80104121:	89 e5                	mov    %esp,%ebp
80104123:	53                   	push   %ebx
80104124:	83 ec 10             	sub    $0x10,%esp
80104127:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010412a:	68 60 2d 11 80       	push   $0x80112d60
8010412f:	e8 9c 03 00 00       	call   801044d0 <acquire>
80104134:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104137:	b8 94 2d 11 80       	mov    $0x80112d94,%eax
8010413c:	eb 0c                	jmp    8010414a <kill+0x2a>
8010413e:	66 90                	xchg   %ax,%ax
80104140:	83 e8 80             	sub    $0xffffff80,%eax
80104143:	3d 94 4d 11 80       	cmp    $0x80114d94,%eax
80104148:	73 36                	jae    80104180 <kill+0x60>
    if(p->pid == pid){
8010414a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010414d:	75 f1                	jne    80104140 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010414f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104153:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010415a:	75 07                	jne    80104163 <kill+0x43>
        p->state = RUNNABLE;
8010415c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104163:	83 ec 0c             	sub    $0xc,%esp
80104166:	68 60 2d 11 80       	push   $0x80112d60
8010416b:	e8 20 04 00 00       	call   80104590 <release>
      return 0;
80104170:	83 c4 10             	add    $0x10,%esp
80104173:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104175:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104178:	c9                   	leave  
80104179:	c3                   	ret    
8010417a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104180:	83 ec 0c             	sub    $0xc,%esp
80104183:	68 60 2d 11 80       	push   $0x80112d60
80104188:	e8 03 04 00 00       	call   80104590 <release>
  return -1;
8010418d:	83 c4 10             	add    $0x10,%esp
80104190:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104195:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104198:	c9                   	leave  
80104199:	c3                   	ret    
8010419a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801041a0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801041a0:	55                   	push   %ebp
801041a1:	89 e5                	mov    %esp,%ebp
801041a3:	57                   	push   %edi
801041a4:	56                   	push   %esi
801041a5:	53                   	push   %ebx
801041a6:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041a9:	bb 94 2d 11 80       	mov    $0x80112d94,%ebx
{
801041ae:	83 ec 3c             	sub    $0x3c,%esp
801041b1:	eb 24                	jmp    801041d7 <procdump+0x37>
801041b3:	90                   	nop
801041b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801041b8:	83 ec 0c             	sub    $0xc,%esp
801041bb:	68 1f 7a 10 80       	push   $0x80107a1f
801041c0:	e8 6b c5 ff ff       	call   80100730 <cprintf>
801041c5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041c8:	83 eb 80             	sub    $0xffffff80,%ebx
801041cb:	81 fb 94 4d 11 80    	cmp    $0x80114d94,%ebx
801041d1:	0f 83 81 00 00 00    	jae    80104258 <procdump+0xb8>
    if(p->state == UNUSED)
801041d7:	8b 43 0c             	mov    0xc(%ebx),%eax
801041da:	85 c0                	test   %eax,%eax
801041dc:	74 ea                	je     801041c8 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041de:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
801041e1:	ba a0 76 10 80       	mov    $0x801076a0,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041e6:	77 11                	ja     801041f9 <procdump+0x59>
801041e8:	8b 14 85 00 77 10 80 	mov    -0x7fef8900(,%eax,4),%edx
      state = "???";
801041ef:	b8 a0 76 10 80       	mov    $0x801076a0,%eax
801041f4:	85 d2                	test   %edx,%edx
801041f6:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801041f9:	8d 43 70             	lea    0x70(%ebx),%eax
801041fc:	50                   	push   %eax
801041fd:	52                   	push   %edx
801041fe:	ff 73 10             	pushl  0x10(%ebx)
80104201:	68 a4 76 10 80       	push   $0x801076a4
80104206:	e8 25 c5 ff ff       	call   80100730 <cprintf>
    if(p->state == SLEEPING){
8010420b:	83 c4 10             	add    $0x10,%esp
8010420e:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104212:	75 a4                	jne    801041b8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104214:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104217:	83 ec 08             	sub    $0x8,%esp
8010421a:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010421d:	50                   	push   %eax
8010421e:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104221:	8b 40 0c             	mov    0xc(%eax),%eax
80104224:	83 c0 08             	add    $0x8,%eax
80104227:	50                   	push   %eax
80104228:	e8 83 01 00 00       	call   801043b0 <getcallerpcs>
8010422d:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104230:	8b 17                	mov    (%edi),%edx
80104232:	85 d2                	test   %edx,%edx
80104234:	74 82                	je     801041b8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104236:	83 ec 08             	sub    $0x8,%esp
80104239:	83 c7 04             	add    $0x4,%edi
8010423c:	52                   	push   %edx
8010423d:	68 e1 70 10 80       	push   $0x801070e1
80104242:	e8 e9 c4 ff ff       	call   80100730 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104247:	83 c4 10             	add    $0x10,%esp
8010424a:	39 fe                	cmp    %edi,%esi
8010424c:	75 e2                	jne    80104230 <procdump+0x90>
8010424e:	e9 65 ff ff ff       	jmp    801041b8 <procdump+0x18>
80104253:	90                   	nop
80104254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
}
80104258:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010425b:	5b                   	pop    %ebx
8010425c:	5e                   	pop    %esi
8010425d:	5f                   	pop    %edi
8010425e:	5d                   	pop    %ebp
8010425f:	c3                   	ret    

80104260 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	53                   	push   %ebx
80104264:	83 ec 0c             	sub    $0xc,%esp
80104267:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010426a:	68 18 77 10 80       	push   $0x80107718
8010426f:	8d 43 04             	lea    0x4(%ebx),%eax
80104272:	50                   	push   %eax
80104273:	e8 18 01 00 00       	call   80104390 <initlock>
  lk->name = name;
80104278:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010427b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104281:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104284:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010428b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010428e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104291:	c9                   	leave  
80104292:	c3                   	ret    
80104293:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042a0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	56                   	push   %esi
801042a4:	53                   	push   %ebx
801042a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801042a8:	83 ec 0c             	sub    $0xc,%esp
801042ab:	8d 73 04             	lea    0x4(%ebx),%esi
801042ae:	56                   	push   %esi
801042af:	e8 1c 02 00 00       	call   801044d0 <acquire>
  while (lk->locked) {
801042b4:	8b 13                	mov    (%ebx),%edx
801042b6:	83 c4 10             	add    $0x10,%esp
801042b9:	85 d2                	test   %edx,%edx
801042bb:	74 16                	je     801042d3 <acquiresleep+0x33>
801042bd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801042c0:	83 ec 08             	sub    $0x8,%esp
801042c3:	56                   	push   %esi
801042c4:	53                   	push   %ebx
801042c5:	e8 46 fc ff ff       	call   80103f10 <sleep>
  while (lk->locked) {
801042ca:	8b 03                	mov    (%ebx),%eax
801042cc:	83 c4 10             	add    $0x10,%esp
801042cf:	85 c0                	test   %eax,%eax
801042d1:	75 ed                	jne    801042c0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801042d3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801042d9:	e8 92 f6 ff ff       	call   80103970 <myproc>
801042de:	8b 40 10             	mov    0x10(%eax),%eax
801042e1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801042e4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801042e7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042ea:	5b                   	pop    %ebx
801042eb:	5e                   	pop    %esi
801042ec:	5d                   	pop    %ebp
  release(&lk->lk);
801042ed:	e9 9e 02 00 00       	jmp    80104590 <release>
801042f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104300 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	56                   	push   %esi
80104304:	53                   	push   %ebx
80104305:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104308:	83 ec 0c             	sub    $0xc,%esp
8010430b:	8d 73 04             	lea    0x4(%ebx),%esi
8010430e:	56                   	push   %esi
8010430f:	e8 bc 01 00 00       	call   801044d0 <acquire>
  lk->locked = 0;
80104314:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010431a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104321:	89 1c 24             	mov    %ebx,(%esp)
80104324:	e8 97 fd ff ff       	call   801040c0 <wakeup>
  release(&lk->lk);
80104329:	89 75 08             	mov    %esi,0x8(%ebp)
8010432c:	83 c4 10             	add    $0x10,%esp
}
8010432f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104332:	5b                   	pop    %ebx
80104333:	5e                   	pop    %esi
80104334:	5d                   	pop    %ebp
  release(&lk->lk);
80104335:	e9 56 02 00 00       	jmp    80104590 <release>
8010433a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104340 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	57                   	push   %edi
80104344:	56                   	push   %esi
80104345:	53                   	push   %ebx
80104346:	31 ff                	xor    %edi,%edi
80104348:	83 ec 18             	sub    $0x18,%esp
8010434b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010434e:	8d 73 04             	lea    0x4(%ebx),%esi
80104351:	56                   	push   %esi
80104352:	e8 79 01 00 00       	call   801044d0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104357:	8b 03                	mov    (%ebx),%eax
80104359:	83 c4 10             	add    $0x10,%esp
8010435c:	85 c0                	test   %eax,%eax
8010435e:	74 13                	je     80104373 <holdingsleep+0x33>
80104360:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104363:	e8 08 f6 ff ff       	call   80103970 <myproc>
80104368:	39 58 10             	cmp    %ebx,0x10(%eax)
8010436b:	0f 94 c0             	sete   %al
8010436e:	0f b6 c0             	movzbl %al,%eax
80104371:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104373:	83 ec 0c             	sub    $0xc,%esp
80104376:	56                   	push   %esi
80104377:	e8 14 02 00 00       	call   80104590 <release>
  return r;
}
8010437c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010437f:	89 f8                	mov    %edi,%eax
80104381:	5b                   	pop    %ebx
80104382:	5e                   	pop    %esi
80104383:	5f                   	pop    %edi
80104384:	5d                   	pop    %ebp
80104385:	c3                   	ret    
80104386:	66 90                	xchg   %ax,%ax
80104388:	66 90                	xchg   %ax,%ax
8010438a:	66 90                	xchg   %ax,%ax
8010438c:	66 90                	xchg   %ax,%ax
8010438e:	66 90                	xchg   %ax,%ax

80104390 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104396:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104399:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010439f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801043a2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801043a9:	5d                   	pop    %ebp
801043aa:	c3                   	ret    
801043ab:	90                   	nop
801043ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043b0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801043b0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043b1:	31 d2                	xor    %edx,%edx
{
801043b3:	89 e5                	mov    %esp,%ebp
801043b5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801043b6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801043b9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801043bc:	83 e8 08             	sub    $0x8,%eax
801043bf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801043c0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801043c6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801043cc:	77 1a                	ja     801043e8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801043ce:	8b 58 04             	mov    0x4(%eax),%ebx
801043d1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801043d4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801043d7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801043d9:	83 fa 0a             	cmp    $0xa,%edx
801043dc:	75 e2                	jne    801043c0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801043de:	5b                   	pop    %ebx
801043df:	5d                   	pop    %ebp
801043e0:	c3                   	ret    
801043e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043e8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801043eb:	83 c1 28             	add    $0x28,%ecx
801043ee:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801043f0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801043f6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801043f9:	39 c1                	cmp    %eax,%ecx
801043fb:	75 f3                	jne    801043f0 <getcallerpcs+0x40>
}
801043fd:	5b                   	pop    %ebx
801043fe:	5d                   	pop    %ebp
801043ff:	c3                   	ret    

80104400 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	53                   	push   %ebx
80104404:	83 ec 04             	sub    $0x4,%esp
80104407:	9c                   	pushf  
80104408:	5b                   	pop    %ebx
  asm volatile("cli");
80104409:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010440a:	e8 c1 f4 ff ff       	call   801038d0 <mycpu>
8010440f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104415:	85 c0                	test   %eax,%eax
80104417:	75 11                	jne    8010442a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104419:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010441f:	e8 ac f4 ff ff       	call   801038d0 <mycpu>
80104424:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010442a:	e8 a1 f4 ff ff       	call   801038d0 <mycpu>
8010442f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104436:	83 c4 04             	add    $0x4,%esp
80104439:	5b                   	pop    %ebx
8010443a:	5d                   	pop    %ebp
8010443b:	c3                   	ret    
8010443c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104440 <popcli>:

void
popcli(void)
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104446:	9c                   	pushf  
80104447:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104448:	f6 c4 02             	test   $0x2,%ah
8010444b:	75 35                	jne    80104482 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010444d:	e8 7e f4 ff ff       	call   801038d0 <mycpu>
80104452:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104459:	78 34                	js     8010448f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010445b:	e8 70 f4 ff ff       	call   801038d0 <mycpu>
80104460:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104466:	85 d2                	test   %edx,%edx
80104468:	74 06                	je     80104470 <popcli+0x30>
    sti();
}
8010446a:	c9                   	leave  
8010446b:	c3                   	ret    
8010446c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104470:	e8 5b f4 ff ff       	call   801038d0 <mycpu>
80104475:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010447b:	85 c0                	test   %eax,%eax
8010447d:	74 eb                	je     8010446a <popcli+0x2a>
  asm volatile("sti");
8010447f:	fb                   	sti    
}
80104480:	c9                   	leave  
80104481:	c3                   	ret    
    panic("popcli - interruptible");
80104482:	83 ec 0c             	sub    $0xc,%esp
80104485:	68 23 77 10 80       	push   $0x80107723
8010448a:	e8 d1 bf ff ff       	call   80100460 <panic>
    panic("popcli");
8010448f:	83 ec 0c             	sub    $0xc,%esp
80104492:	68 3a 77 10 80       	push   $0x8010773a
80104497:	e8 c4 bf ff ff       	call   80100460 <panic>
8010449c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801044a0 <holding>:
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	56                   	push   %esi
801044a4:	53                   	push   %ebx
801044a5:	8b 75 08             	mov    0x8(%ebp),%esi
801044a8:	31 db                	xor    %ebx,%ebx
  pushcli();
801044aa:	e8 51 ff ff ff       	call   80104400 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801044af:	8b 06                	mov    (%esi),%eax
801044b1:	85 c0                	test   %eax,%eax
801044b3:	74 10                	je     801044c5 <holding+0x25>
801044b5:	8b 5e 08             	mov    0x8(%esi),%ebx
801044b8:	e8 13 f4 ff ff       	call   801038d0 <mycpu>
801044bd:	39 c3                	cmp    %eax,%ebx
801044bf:	0f 94 c3             	sete   %bl
801044c2:	0f b6 db             	movzbl %bl,%ebx
  popcli();
801044c5:	e8 76 ff ff ff       	call   80104440 <popcli>
}
801044ca:	89 d8                	mov    %ebx,%eax
801044cc:	5b                   	pop    %ebx
801044cd:	5e                   	pop    %esi
801044ce:	5d                   	pop    %ebp
801044cf:	c3                   	ret    

801044d0 <acquire>:
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	56                   	push   %esi
801044d4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801044d5:	e8 26 ff ff ff       	call   80104400 <pushcli>
  if(holding(lk))
801044da:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044dd:	83 ec 0c             	sub    $0xc,%esp
801044e0:	53                   	push   %ebx
801044e1:	e8 ba ff ff ff       	call   801044a0 <holding>
801044e6:	83 c4 10             	add    $0x10,%esp
801044e9:	85 c0                	test   %eax,%eax
801044eb:	0f 85 83 00 00 00    	jne    80104574 <acquire+0xa4>
801044f1:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
801044f3:	ba 01 00 00 00       	mov    $0x1,%edx
801044f8:	eb 09                	jmp    80104503 <acquire+0x33>
801044fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104500:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104503:	89 d0                	mov    %edx,%eax
80104505:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104508:	85 c0                	test   %eax,%eax
8010450a:	75 f4                	jne    80104500 <acquire+0x30>
  __sync_synchronize();
8010450c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104511:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104514:	e8 b7 f3 ff ff       	call   801038d0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104519:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
8010451c:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
8010451f:	89 e8                	mov    %ebp,%eax
80104521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104528:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010452e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104534:	77 1a                	ja     80104550 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104536:	8b 48 04             	mov    0x4(%eax),%ecx
80104539:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
8010453c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
8010453f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104541:	83 fe 0a             	cmp    $0xa,%esi
80104544:	75 e2                	jne    80104528 <acquire+0x58>
}
80104546:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104549:	5b                   	pop    %ebx
8010454a:	5e                   	pop    %esi
8010454b:	5d                   	pop    %ebp
8010454c:	c3                   	ret    
8010454d:	8d 76 00             	lea    0x0(%esi),%esi
80104550:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104553:	83 c2 28             	add    $0x28,%edx
80104556:	8d 76 00             	lea    0x0(%esi),%esi
80104559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104560:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104566:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104569:	39 d0                	cmp    %edx,%eax
8010456b:	75 f3                	jne    80104560 <acquire+0x90>
}
8010456d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104570:	5b                   	pop    %ebx
80104571:	5e                   	pop    %esi
80104572:	5d                   	pop    %ebp
80104573:	c3                   	ret    
    panic("acquire");
80104574:	83 ec 0c             	sub    $0xc,%esp
80104577:	68 41 77 10 80       	push   $0x80107741
8010457c:	e8 df be ff ff       	call   80100460 <panic>
80104581:	eb 0d                	jmp    80104590 <release>
80104583:	90                   	nop
80104584:	90                   	nop
80104585:	90                   	nop
80104586:	90                   	nop
80104587:	90                   	nop
80104588:	90                   	nop
80104589:	90                   	nop
8010458a:	90                   	nop
8010458b:	90                   	nop
8010458c:	90                   	nop
8010458d:	90                   	nop
8010458e:	90                   	nop
8010458f:	90                   	nop

80104590 <release>:
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	53                   	push   %ebx
80104594:	83 ec 10             	sub    $0x10,%esp
80104597:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010459a:	53                   	push   %ebx
8010459b:	e8 00 ff ff ff       	call   801044a0 <holding>
801045a0:	83 c4 10             	add    $0x10,%esp
801045a3:	85 c0                	test   %eax,%eax
801045a5:	74 22                	je     801045c9 <release+0x39>
  lk->pcs[0] = 0;
801045a7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801045ae:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801045b5:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801045ba:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801045c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045c3:	c9                   	leave  
  popcli();
801045c4:	e9 77 fe ff ff       	jmp    80104440 <popcli>
    panic("release");
801045c9:	83 ec 0c             	sub    $0xc,%esp
801045cc:	68 49 77 10 80       	push   $0x80107749
801045d1:	e8 8a be ff ff       	call   80100460 <panic>
801045d6:	66 90                	xchg   %ax,%ax
801045d8:	66 90                	xchg   %ax,%ax
801045da:	66 90                	xchg   %ax,%ax
801045dc:	66 90                	xchg   %ax,%ax
801045de:	66 90                	xchg   %ax,%ax

801045e0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	57                   	push   %edi
801045e4:	53                   	push   %ebx
801045e5:	8b 55 08             	mov    0x8(%ebp),%edx
801045e8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801045eb:	f6 c2 03             	test   $0x3,%dl
801045ee:	75 05                	jne    801045f5 <memset+0x15>
801045f0:	f6 c1 03             	test   $0x3,%cl
801045f3:	74 13                	je     80104608 <memset+0x28>
  asm volatile("cld; rep stosb" :
801045f5:	89 d7                	mov    %edx,%edi
801045f7:	8b 45 0c             	mov    0xc(%ebp),%eax
801045fa:	fc                   	cld    
801045fb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801045fd:	5b                   	pop    %ebx
801045fe:	89 d0                	mov    %edx,%eax
80104600:	5f                   	pop    %edi
80104601:	5d                   	pop    %ebp
80104602:	c3                   	ret    
80104603:	90                   	nop
80104604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104608:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010460c:	c1 e9 02             	shr    $0x2,%ecx
8010460f:	89 f8                	mov    %edi,%eax
80104611:	89 fb                	mov    %edi,%ebx
80104613:	c1 e0 18             	shl    $0x18,%eax
80104616:	c1 e3 10             	shl    $0x10,%ebx
80104619:	09 d8                	or     %ebx,%eax
8010461b:	09 f8                	or     %edi,%eax
8010461d:	c1 e7 08             	shl    $0x8,%edi
80104620:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104622:	89 d7                	mov    %edx,%edi
80104624:	fc                   	cld    
80104625:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104627:	5b                   	pop    %ebx
80104628:	89 d0                	mov    %edx,%eax
8010462a:	5f                   	pop    %edi
8010462b:	5d                   	pop    %ebp
8010462c:	c3                   	ret    
8010462d:	8d 76 00             	lea    0x0(%esi),%esi

80104630 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	57                   	push   %edi
80104634:	56                   	push   %esi
80104635:	53                   	push   %ebx
80104636:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104639:	8b 75 08             	mov    0x8(%ebp),%esi
8010463c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010463f:	85 db                	test   %ebx,%ebx
80104641:	74 29                	je     8010466c <memcmp+0x3c>
    if(*s1 != *s2)
80104643:	0f b6 16             	movzbl (%esi),%edx
80104646:	0f b6 0f             	movzbl (%edi),%ecx
80104649:	38 d1                	cmp    %dl,%cl
8010464b:	75 2b                	jne    80104678 <memcmp+0x48>
8010464d:	b8 01 00 00 00       	mov    $0x1,%eax
80104652:	eb 14                	jmp    80104668 <memcmp+0x38>
80104654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104658:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
8010465c:	83 c0 01             	add    $0x1,%eax
8010465f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104664:	38 ca                	cmp    %cl,%dl
80104666:	75 10                	jne    80104678 <memcmp+0x48>
  while(n-- > 0){
80104668:	39 d8                	cmp    %ebx,%eax
8010466a:	75 ec                	jne    80104658 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010466c:	5b                   	pop    %ebx
  return 0;
8010466d:	31 c0                	xor    %eax,%eax
}
8010466f:	5e                   	pop    %esi
80104670:	5f                   	pop    %edi
80104671:	5d                   	pop    %ebp
80104672:	c3                   	ret    
80104673:	90                   	nop
80104674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104678:	0f b6 c2             	movzbl %dl,%eax
}
8010467b:	5b                   	pop    %ebx
      return *s1 - *s2;
8010467c:	29 c8                	sub    %ecx,%eax
}
8010467e:	5e                   	pop    %esi
8010467f:	5f                   	pop    %edi
80104680:	5d                   	pop    %ebp
80104681:	c3                   	ret    
80104682:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104690 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	56                   	push   %esi
80104694:	53                   	push   %ebx
80104695:	8b 45 08             	mov    0x8(%ebp),%eax
80104698:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010469b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010469e:	39 c3                	cmp    %eax,%ebx
801046a0:	73 26                	jae    801046c8 <memmove+0x38>
801046a2:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
801046a5:	39 c8                	cmp    %ecx,%eax
801046a7:	73 1f                	jae    801046c8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
801046a9:	85 f6                	test   %esi,%esi
801046ab:	8d 56 ff             	lea    -0x1(%esi),%edx
801046ae:	74 0f                	je     801046bf <memmove+0x2f>
      *--d = *--s;
801046b0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801046b4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
801046b7:	83 ea 01             	sub    $0x1,%edx
801046ba:	83 fa ff             	cmp    $0xffffffff,%edx
801046bd:	75 f1                	jne    801046b0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801046bf:	5b                   	pop    %ebx
801046c0:	5e                   	pop    %esi
801046c1:	5d                   	pop    %ebp
801046c2:	c3                   	ret    
801046c3:	90                   	nop
801046c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
801046c8:	31 d2                	xor    %edx,%edx
801046ca:	85 f6                	test   %esi,%esi
801046cc:	74 f1                	je     801046bf <memmove+0x2f>
801046ce:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
801046d0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801046d4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801046d7:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
801046da:	39 d6                	cmp    %edx,%esi
801046dc:	75 f2                	jne    801046d0 <memmove+0x40>
}
801046de:	5b                   	pop    %ebx
801046df:	5e                   	pop    %esi
801046e0:	5d                   	pop    %ebp
801046e1:	c3                   	ret    
801046e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046f0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801046f3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
801046f4:	eb 9a                	jmp    80104690 <memmove>
801046f6:	8d 76 00             	lea    0x0(%esi),%esi
801046f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104700 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	57                   	push   %edi
80104704:	56                   	push   %esi
80104705:	8b 7d 10             	mov    0x10(%ebp),%edi
80104708:	53                   	push   %ebx
80104709:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010470c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010470f:	85 ff                	test   %edi,%edi
80104711:	74 2f                	je     80104742 <strncmp+0x42>
80104713:	0f b6 01             	movzbl (%ecx),%eax
80104716:	0f b6 1e             	movzbl (%esi),%ebx
80104719:	84 c0                	test   %al,%al
8010471b:	74 37                	je     80104754 <strncmp+0x54>
8010471d:	38 c3                	cmp    %al,%bl
8010471f:	75 33                	jne    80104754 <strncmp+0x54>
80104721:	01 f7                	add    %esi,%edi
80104723:	eb 13                	jmp    80104738 <strncmp+0x38>
80104725:	8d 76 00             	lea    0x0(%esi),%esi
80104728:	0f b6 01             	movzbl (%ecx),%eax
8010472b:	84 c0                	test   %al,%al
8010472d:	74 21                	je     80104750 <strncmp+0x50>
8010472f:	0f b6 1a             	movzbl (%edx),%ebx
80104732:	89 d6                	mov    %edx,%esi
80104734:	38 d8                	cmp    %bl,%al
80104736:	75 1c                	jne    80104754 <strncmp+0x54>
    n--, p++, q++;
80104738:	8d 56 01             	lea    0x1(%esi),%edx
8010473b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
8010473e:	39 fa                	cmp    %edi,%edx
80104740:	75 e6                	jne    80104728 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104742:	5b                   	pop    %ebx
    return 0;
80104743:	31 c0                	xor    %eax,%eax
}
80104745:	5e                   	pop    %esi
80104746:	5f                   	pop    %edi
80104747:	5d                   	pop    %ebp
80104748:	c3                   	ret    
80104749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104750:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104754:	29 d8                	sub    %ebx,%eax
}
80104756:	5b                   	pop    %ebx
80104757:	5e                   	pop    %esi
80104758:	5f                   	pop    %edi
80104759:	5d                   	pop    %ebp
8010475a:	c3                   	ret    
8010475b:	90                   	nop
8010475c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104760 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	56                   	push   %esi
80104764:	53                   	push   %ebx
80104765:	8b 45 08             	mov    0x8(%ebp),%eax
80104768:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010476b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010476e:	89 c2                	mov    %eax,%edx
80104770:	eb 19                	jmp    8010478b <strncpy+0x2b>
80104772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104778:	83 c3 01             	add    $0x1,%ebx
8010477b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010477f:	83 c2 01             	add    $0x1,%edx
80104782:	84 c9                	test   %cl,%cl
80104784:	88 4a ff             	mov    %cl,-0x1(%edx)
80104787:	74 09                	je     80104792 <strncpy+0x32>
80104789:	89 f1                	mov    %esi,%ecx
8010478b:	85 c9                	test   %ecx,%ecx
8010478d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104790:	7f e6                	jg     80104778 <strncpy+0x18>
    ;
  while(n-- > 0)
80104792:	31 c9                	xor    %ecx,%ecx
80104794:	85 f6                	test   %esi,%esi
80104796:	7e 17                	jle    801047af <strncpy+0x4f>
80104798:	90                   	nop
80104799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801047a0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801047a4:	89 f3                	mov    %esi,%ebx
801047a6:	83 c1 01             	add    $0x1,%ecx
801047a9:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
801047ab:	85 db                	test   %ebx,%ebx
801047ad:	7f f1                	jg     801047a0 <strncpy+0x40>
  return os;
}
801047af:	5b                   	pop    %ebx
801047b0:	5e                   	pop    %esi
801047b1:	5d                   	pop    %ebp
801047b2:	c3                   	ret    
801047b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047c0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	56                   	push   %esi
801047c4:	53                   	push   %ebx
801047c5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801047c8:	8b 45 08             	mov    0x8(%ebp),%eax
801047cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
801047ce:	85 c9                	test   %ecx,%ecx
801047d0:	7e 26                	jle    801047f8 <safestrcpy+0x38>
801047d2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801047d6:	89 c1                	mov    %eax,%ecx
801047d8:	eb 17                	jmp    801047f1 <safestrcpy+0x31>
801047da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801047e0:	83 c2 01             	add    $0x1,%edx
801047e3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801047e7:	83 c1 01             	add    $0x1,%ecx
801047ea:	84 db                	test   %bl,%bl
801047ec:	88 59 ff             	mov    %bl,-0x1(%ecx)
801047ef:	74 04                	je     801047f5 <safestrcpy+0x35>
801047f1:	39 f2                	cmp    %esi,%edx
801047f3:	75 eb                	jne    801047e0 <safestrcpy+0x20>
    ;
  *s = 0;
801047f5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
801047f8:	5b                   	pop    %ebx
801047f9:	5e                   	pop    %esi
801047fa:	5d                   	pop    %ebp
801047fb:	c3                   	ret    
801047fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104800 <strlen>:

int
strlen(const char *s)
{
80104800:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104801:	31 c0                	xor    %eax,%eax
{
80104803:	89 e5                	mov    %esp,%ebp
80104805:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104808:	80 3a 00             	cmpb   $0x0,(%edx)
8010480b:	74 0c                	je     80104819 <strlen+0x19>
8010480d:	8d 76 00             	lea    0x0(%esi),%esi
80104810:	83 c0 01             	add    $0x1,%eax
80104813:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104817:	75 f7                	jne    80104810 <strlen+0x10>
    ;
  return n;
}
80104819:	5d                   	pop    %ebp
8010481a:	c3                   	ret    

8010481b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010481b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010481f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104823:	55                   	push   %ebp
  pushl %ebx
80104824:	53                   	push   %ebx
  pushl %esi
80104825:	56                   	push   %esi
  pushl %edi
80104826:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104827:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104829:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010482b:	5f                   	pop    %edi
  popl %esi
8010482c:	5e                   	pop    %esi
  popl %ebx
8010482d:	5b                   	pop    %ebx
  popl %ebp
8010482e:	5d                   	pop    %ebp
  ret
8010482f:	c3                   	ret    

80104830 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	53                   	push   %ebx
80104834:	83 ec 04             	sub    $0x4,%esp
80104837:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010483a:	e8 31 f1 ff ff       	call   80103970 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010483f:	8b 00                	mov    (%eax),%eax
80104841:	39 d8                	cmp    %ebx,%eax
80104843:	76 1b                	jbe    80104860 <fetchint+0x30>
80104845:	8d 53 04             	lea    0x4(%ebx),%edx
80104848:	39 d0                	cmp    %edx,%eax
8010484a:	72 14                	jb     80104860 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010484c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010484f:	8b 13                	mov    (%ebx),%edx
80104851:	89 10                	mov    %edx,(%eax)
  return 0;
80104853:	31 c0                	xor    %eax,%eax
}
80104855:	83 c4 04             	add    $0x4,%esp
80104858:	5b                   	pop    %ebx
80104859:	5d                   	pop    %ebp
8010485a:	c3                   	ret    
8010485b:	90                   	nop
8010485c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104860:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104865:	eb ee                	jmp    80104855 <fetchint+0x25>
80104867:	89 f6                	mov    %esi,%esi
80104869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104870 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	53                   	push   %ebx
80104874:	83 ec 04             	sub    $0x4,%esp
80104877:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010487a:	e8 f1 f0 ff ff       	call   80103970 <myproc>

  if(addr >= curproc->sz)
8010487f:	39 18                	cmp    %ebx,(%eax)
80104881:	76 29                	jbe    801048ac <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104883:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104886:	89 da                	mov    %ebx,%edx
80104888:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010488a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010488c:	39 c3                	cmp    %eax,%ebx
8010488e:	73 1c                	jae    801048ac <fetchstr+0x3c>
    if(*s == 0)
80104890:	80 3b 00             	cmpb   $0x0,(%ebx)
80104893:	75 10                	jne    801048a5 <fetchstr+0x35>
80104895:	eb 39                	jmp    801048d0 <fetchstr+0x60>
80104897:	89 f6                	mov    %esi,%esi
80104899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801048a0:	80 3a 00             	cmpb   $0x0,(%edx)
801048a3:	74 1b                	je     801048c0 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
801048a5:	83 c2 01             	add    $0x1,%edx
801048a8:	39 d0                	cmp    %edx,%eax
801048aa:	77 f4                	ja     801048a0 <fetchstr+0x30>
    return -1;
801048ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
801048b1:	83 c4 04             	add    $0x4,%esp
801048b4:	5b                   	pop    %ebx
801048b5:	5d                   	pop    %ebp
801048b6:	c3                   	ret    
801048b7:	89 f6                	mov    %esi,%esi
801048b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801048c0:	83 c4 04             	add    $0x4,%esp
801048c3:	89 d0                	mov    %edx,%eax
801048c5:	29 d8                	sub    %ebx,%eax
801048c7:	5b                   	pop    %ebx
801048c8:	5d                   	pop    %ebp
801048c9:	c3                   	ret    
801048ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
801048d0:	31 c0                	xor    %eax,%eax
      return s - *pp;
801048d2:	eb dd                	jmp    801048b1 <fetchstr+0x41>
801048d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801048e0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801048e0:	55                   	push   %ebp
801048e1:	89 e5                	mov    %esp,%ebp
801048e3:	56                   	push   %esi
801048e4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801048e5:	e8 86 f0 ff ff       	call   80103970 <myproc>
801048ea:	8b 40 18             	mov    0x18(%eax),%eax
801048ed:	8b 55 08             	mov    0x8(%ebp),%edx
801048f0:	8b 40 44             	mov    0x44(%eax),%eax
801048f3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801048f6:	e8 75 f0 ff ff       	call   80103970 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801048fb:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801048fd:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104900:	39 c6                	cmp    %eax,%esi
80104902:	73 1c                	jae    80104920 <argint+0x40>
80104904:	8d 53 08             	lea    0x8(%ebx),%edx
80104907:	39 d0                	cmp    %edx,%eax
80104909:	72 15                	jb     80104920 <argint+0x40>
  *ip = *(int*)(addr);
8010490b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010490e:	8b 53 04             	mov    0x4(%ebx),%edx
80104911:	89 10                	mov    %edx,(%eax)
  return 0;
80104913:	31 c0                	xor    %eax,%eax
}
80104915:	5b                   	pop    %ebx
80104916:	5e                   	pop    %esi
80104917:	5d                   	pop    %ebp
80104918:	c3                   	ret    
80104919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104920:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104925:	eb ee                	jmp    80104915 <argint+0x35>
80104927:	89 f6                	mov    %esi,%esi
80104929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104930 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	56                   	push   %esi
80104934:	53                   	push   %ebx
80104935:	83 ec 10             	sub    $0x10,%esp
80104938:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010493b:	e8 30 f0 ff ff       	call   80103970 <myproc>
80104940:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104942:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104945:	83 ec 08             	sub    $0x8,%esp
80104948:	50                   	push   %eax
80104949:	ff 75 08             	pushl  0x8(%ebp)
8010494c:	e8 8f ff ff ff       	call   801048e0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104951:	83 c4 10             	add    $0x10,%esp
80104954:	85 c0                	test   %eax,%eax
80104956:	78 28                	js     80104980 <argptr+0x50>
80104958:	85 db                	test   %ebx,%ebx
8010495a:	78 24                	js     80104980 <argptr+0x50>
8010495c:	8b 16                	mov    (%esi),%edx
8010495e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104961:	39 c2                	cmp    %eax,%edx
80104963:	76 1b                	jbe    80104980 <argptr+0x50>
80104965:	01 c3                	add    %eax,%ebx
80104967:	39 da                	cmp    %ebx,%edx
80104969:	72 15                	jb     80104980 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010496b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010496e:	89 02                	mov    %eax,(%edx)
  return 0;
80104970:	31 c0                	xor    %eax,%eax
}
80104972:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104975:	5b                   	pop    %ebx
80104976:	5e                   	pop    %esi
80104977:	5d                   	pop    %ebp
80104978:	c3                   	ret    
80104979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104980:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104985:	eb eb                	jmp    80104972 <argptr+0x42>
80104987:	89 f6                	mov    %esi,%esi
80104989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104990 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104990:	55                   	push   %ebp
80104991:	89 e5                	mov    %esp,%ebp
80104993:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104996:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104999:	50                   	push   %eax
8010499a:	ff 75 08             	pushl  0x8(%ebp)
8010499d:	e8 3e ff ff ff       	call   801048e0 <argint>
801049a2:	83 c4 10             	add    $0x10,%esp
801049a5:	85 c0                	test   %eax,%eax
801049a7:	78 17                	js     801049c0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801049a9:	83 ec 08             	sub    $0x8,%esp
801049ac:	ff 75 0c             	pushl  0xc(%ebp)
801049af:	ff 75 f4             	pushl  -0xc(%ebp)
801049b2:	e8 b9 fe ff ff       	call   80104870 <fetchstr>
801049b7:	83 c4 10             	add    $0x10,%esp
}
801049ba:	c9                   	leave  
801049bb:	c3                   	ret    
801049bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801049c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801049c5:	c9                   	leave  
801049c6:	c3                   	ret    
801049c7:	89 f6                	mov    %esi,%esi
801049c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049d0 <syscall>:
[SYS_steal]   sys_steal,
};

void
syscall(void)
{
801049d0:	55                   	push   %ebp
801049d1:	89 e5                	mov    %esp,%ebp
801049d3:	53                   	push   %ebx
801049d4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
801049d7:	e8 94 ef ff ff       	call   80103970 <myproc>
801049dc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801049de:	8b 40 18             	mov    0x18(%eax),%eax
801049e1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801049e4:	8d 50 ff             	lea    -0x1(%eax),%edx
801049e7:	83 fa 16             	cmp    $0x16,%edx
801049ea:	77 1c                	ja     80104a08 <syscall+0x38>
801049ec:	8b 14 85 80 77 10 80 	mov    -0x7fef8880(,%eax,4),%edx
801049f3:	85 d2                	test   %edx,%edx
801049f5:	74 11                	je     80104a08 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
801049f7:	ff d2                	call   *%edx
801049f9:	8b 53 18             	mov    0x18(%ebx),%edx
801049fc:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801049ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a02:	c9                   	leave  
80104a03:	c3                   	ret    
80104a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104a08:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104a09:	8d 43 70             	lea    0x70(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104a0c:	50                   	push   %eax
80104a0d:	ff 73 10             	pushl  0x10(%ebx)
80104a10:	68 51 77 10 80       	push   $0x80107751
80104a15:	e8 16 bd ff ff       	call   80100730 <cprintf>
    curproc->tf->eax = -1;
80104a1a:	8b 43 18             	mov    0x18(%ebx),%eax
80104a1d:	83 c4 10             	add    $0x10,%esp
80104a20:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104a27:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a2a:	c9                   	leave  
80104a2b:	c3                   	ret    
80104a2c:	66 90                	xchg   %ax,%ax
80104a2e:	66 90                	xchg   %ax,%ax

80104a30 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
80104a33:	57                   	push   %edi
80104a34:	56                   	push   %esi
80104a35:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a36:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104a39:	83 ec 34             	sub    $0x34,%esp
80104a3c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104a3f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104a42:	56                   	push   %esi
80104a43:	50                   	push   %eax
{
80104a44:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104a47:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104a4a:	e8 41 d6 ff ff       	call   80102090 <nameiparent>
80104a4f:	83 c4 10             	add    $0x10,%esp
80104a52:	85 c0                	test   %eax,%eax
80104a54:	0f 84 46 01 00 00    	je     80104ba0 <create+0x170>
    return 0;
  ilock(dp);
80104a5a:	83 ec 0c             	sub    $0xc,%esp
80104a5d:	89 c3                	mov    %eax,%ebx
80104a5f:	50                   	push   %eax
80104a60:	e8 6b cd ff ff       	call   801017d0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104a65:	83 c4 0c             	add    $0xc,%esp
80104a68:	6a 00                	push   $0x0
80104a6a:	56                   	push   %esi
80104a6b:	53                   	push   %ebx
80104a6c:	e8 cf d2 ff ff       	call   80101d40 <dirlookup>
80104a71:	83 c4 10             	add    $0x10,%esp
80104a74:	85 c0                	test   %eax,%eax
80104a76:	89 c7                	mov    %eax,%edi
80104a78:	74 36                	je     80104ab0 <create+0x80>
    iunlockput(dp);
80104a7a:	83 ec 0c             	sub    $0xc,%esp
80104a7d:	53                   	push   %ebx
80104a7e:	e8 dd cf ff ff       	call   80101a60 <iunlockput>
    ilock(ip);
80104a83:	89 3c 24             	mov    %edi,(%esp)
80104a86:	e8 45 cd ff ff       	call   801017d0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104a8b:	83 c4 10             	add    $0x10,%esp
80104a8e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104a93:	0f 85 97 00 00 00    	jne    80104b30 <create+0x100>
80104a99:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104a9e:	0f 85 8c 00 00 00    	jne    80104b30 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104aa4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104aa7:	89 f8                	mov    %edi,%eax
80104aa9:	5b                   	pop    %ebx
80104aaa:	5e                   	pop    %esi
80104aab:	5f                   	pop    %edi
80104aac:	5d                   	pop    %ebp
80104aad:	c3                   	ret    
80104aae:	66 90                	xchg   %ax,%ax
  if((ip = ialloc(dp->dev, type)) == 0)
80104ab0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104ab4:	83 ec 08             	sub    $0x8,%esp
80104ab7:	50                   	push   %eax
80104ab8:	ff 33                	pushl  (%ebx)
80104aba:	e8 a1 cb ff ff       	call   80101660 <ialloc>
80104abf:	83 c4 10             	add    $0x10,%esp
80104ac2:	85 c0                	test   %eax,%eax
80104ac4:	89 c7                	mov    %eax,%edi
80104ac6:	0f 84 e8 00 00 00    	je     80104bb4 <create+0x184>
  ilock(ip);
80104acc:	83 ec 0c             	sub    $0xc,%esp
80104acf:	50                   	push   %eax
80104ad0:	e8 fb cc ff ff       	call   801017d0 <ilock>
  ip->major = major;
80104ad5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104ad9:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104add:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104ae1:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104ae5:	b8 01 00 00 00       	mov    $0x1,%eax
80104aea:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104aee:	89 3c 24             	mov    %edi,(%esp)
80104af1:	e8 2a cc ff ff       	call   80101720 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104af6:	83 c4 10             	add    $0x10,%esp
80104af9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104afe:	74 50                	je     80104b50 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104b00:	83 ec 04             	sub    $0x4,%esp
80104b03:	ff 77 04             	pushl  0x4(%edi)
80104b06:	56                   	push   %esi
80104b07:	53                   	push   %ebx
80104b08:	e8 a3 d4 ff ff       	call   80101fb0 <dirlink>
80104b0d:	83 c4 10             	add    $0x10,%esp
80104b10:	85 c0                	test   %eax,%eax
80104b12:	0f 88 8f 00 00 00    	js     80104ba7 <create+0x177>
  iunlockput(dp);
80104b18:	83 ec 0c             	sub    $0xc,%esp
80104b1b:	53                   	push   %ebx
80104b1c:	e8 3f cf ff ff       	call   80101a60 <iunlockput>
  return ip;
80104b21:	83 c4 10             	add    $0x10,%esp
}
80104b24:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b27:	89 f8                	mov    %edi,%eax
80104b29:	5b                   	pop    %ebx
80104b2a:	5e                   	pop    %esi
80104b2b:	5f                   	pop    %edi
80104b2c:	5d                   	pop    %ebp
80104b2d:	c3                   	ret    
80104b2e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104b30:	83 ec 0c             	sub    $0xc,%esp
80104b33:	57                   	push   %edi
    return 0;
80104b34:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104b36:	e8 25 cf ff ff       	call   80101a60 <iunlockput>
    return 0;
80104b3b:	83 c4 10             	add    $0x10,%esp
}
80104b3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b41:	89 f8                	mov    %edi,%eax
80104b43:	5b                   	pop    %ebx
80104b44:	5e                   	pop    %esi
80104b45:	5f                   	pop    %edi
80104b46:	5d                   	pop    %ebp
80104b47:	c3                   	ret    
80104b48:	90                   	nop
80104b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104b50:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104b55:	83 ec 0c             	sub    $0xc,%esp
80104b58:	53                   	push   %ebx
80104b59:	e8 c2 cb ff ff       	call   80101720 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104b5e:	83 c4 0c             	add    $0xc,%esp
80104b61:	ff 77 04             	pushl  0x4(%edi)
80104b64:	68 fc 77 10 80       	push   $0x801077fc
80104b69:	57                   	push   %edi
80104b6a:	e8 41 d4 ff ff       	call   80101fb0 <dirlink>
80104b6f:	83 c4 10             	add    $0x10,%esp
80104b72:	85 c0                	test   %eax,%eax
80104b74:	78 1c                	js     80104b92 <create+0x162>
80104b76:	83 ec 04             	sub    $0x4,%esp
80104b79:	ff 73 04             	pushl  0x4(%ebx)
80104b7c:	68 fb 77 10 80       	push   $0x801077fb
80104b81:	57                   	push   %edi
80104b82:	e8 29 d4 ff ff       	call   80101fb0 <dirlink>
80104b87:	83 c4 10             	add    $0x10,%esp
80104b8a:	85 c0                	test   %eax,%eax
80104b8c:	0f 89 6e ff ff ff    	jns    80104b00 <create+0xd0>
      panic("create dots");
80104b92:	83 ec 0c             	sub    $0xc,%esp
80104b95:	68 ef 77 10 80       	push   $0x801077ef
80104b9a:	e8 c1 b8 ff ff       	call   80100460 <panic>
80104b9f:	90                   	nop
    return 0;
80104ba0:	31 ff                	xor    %edi,%edi
80104ba2:	e9 fd fe ff ff       	jmp    80104aa4 <create+0x74>
    panic("create: dirlink");
80104ba7:	83 ec 0c             	sub    $0xc,%esp
80104baa:	68 fe 77 10 80       	push   $0x801077fe
80104baf:	e8 ac b8 ff ff       	call   80100460 <panic>
    panic("create: ialloc");
80104bb4:	83 ec 0c             	sub    $0xc,%esp
80104bb7:	68 e0 77 10 80       	push   $0x801077e0
80104bbc:	e8 9f b8 ff ff       	call   80100460 <panic>
80104bc1:	eb 0d                	jmp    80104bd0 <argfd.constprop.0>
80104bc3:	90                   	nop
80104bc4:	90                   	nop
80104bc5:	90                   	nop
80104bc6:	90                   	nop
80104bc7:	90                   	nop
80104bc8:	90                   	nop
80104bc9:	90                   	nop
80104bca:	90                   	nop
80104bcb:	90                   	nop
80104bcc:	90                   	nop
80104bcd:	90                   	nop
80104bce:	90                   	nop
80104bcf:	90                   	nop

80104bd0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	56                   	push   %esi
80104bd4:	53                   	push   %ebx
80104bd5:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104bd7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104bda:	89 d6                	mov    %edx,%esi
80104bdc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104bdf:	50                   	push   %eax
80104be0:	6a 00                	push   $0x0
80104be2:	e8 f9 fc ff ff       	call   801048e0 <argint>
80104be7:	83 c4 10             	add    $0x10,%esp
80104bea:	85 c0                	test   %eax,%eax
80104bec:	78 2a                	js     80104c18 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104bee:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104bf2:	77 24                	ja     80104c18 <argfd.constprop.0+0x48>
80104bf4:	e8 77 ed ff ff       	call   80103970 <myproc>
80104bf9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104bfc:	8b 44 90 2c          	mov    0x2c(%eax,%edx,4),%eax
80104c00:	85 c0                	test   %eax,%eax
80104c02:	74 14                	je     80104c18 <argfd.constprop.0+0x48>
  if(pfd)
80104c04:	85 db                	test   %ebx,%ebx
80104c06:	74 02                	je     80104c0a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104c08:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104c0a:	89 06                	mov    %eax,(%esi)
  return 0;
80104c0c:	31 c0                	xor    %eax,%eax
}
80104c0e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c11:	5b                   	pop    %ebx
80104c12:	5e                   	pop    %esi
80104c13:	5d                   	pop    %ebp
80104c14:	c3                   	ret    
80104c15:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104c18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c1d:	eb ef                	jmp    80104c0e <argfd.constprop.0+0x3e>
80104c1f:	90                   	nop

80104c20 <sys_dup>:
{
80104c20:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104c21:	31 c0                	xor    %eax,%eax
{
80104c23:	89 e5                	mov    %esp,%ebp
80104c25:	56                   	push   %esi
80104c26:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104c27:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104c2a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104c2d:	e8 9e ff ff ff       	call   80104bd0 <argfd.constprop.0>
80104c32:	85 c0                	test   %eax,%eax
80104c34:	78 42                	js     80104c78 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80104c36:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104c39:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104c3b:	e8 30 ed ff ff       	call   80103970 <myproc>
80104c40:	eb 0e                	jmp    80104c50 <sys_dup+0x30>
80104c42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104c48:	83 c3 01             	add    $0x1,%ebx
80104c4b:	83 fb 10             	cmp    $0x10,%ebx
80104c4e:	74 28                	je     80104c78 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104c50:	8b 54 98 2c          	mov    0x2c(%eax,%ebx,4),%edx
80104c54:	85 d2                	test   %edx,%edx
80104c56:	75 f0                	jne    80104c48 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104c58:	89 74 98 2c          	mov    %esi,0x2c(%eax,%ebx,4)
  filedup(f);
80104c5c:	83 ec 0c             	sub    $0xc,%esp
80104c5f:	ff 75 f4             	pushl  -0xc(%ebp)
80104c62:	e8 79 c2 ff ff       	call   80100ee0 <filedup>
  return fd;
80104c67:	83 c4 10             	add    $0x10,%esp
}
80104c6a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c6d:	89 d8                	mov    %ebx,%eax
80104c6f:	5b                   	pop    %ebx
80104c70:	5e                   	pop    %esi
80104c71:	5d                   	pop    %ebp
80104c72:	c3                   	ret    
80104c73:	90                   	nop
80104c74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c78:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104c7b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104c80:	89 d8                	mov    %ebx,%eax
80104c82:	5b                   	pop    %ebx
80104c83:	5e                   	pop    %esi
80104c84:	5d                   	pop    %ebp
80104c85:	c3                   	ret    
80104c86:	8d 76 00             	lea    0x0(%esi),%esi
80104c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c90 <sys_read>:
{
80104c90:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c91:	31 c0                	xor    %eax,%eax
{
80104c93:	89 e5                	mov    %esp,%ebp
80104c95:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c98:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104c9b:	e8 30 ff ff ff       	call   80104bd0 <argfd.constprop.0>
80104ca0:	85 c0                	test   %eax,%eax
80104ca2:	78 4c                	js     80104cf0 <sys_read+0x60>
80104ca4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ca7:	83 ec 08             	sub    $0x8,%esp
80104caa:	50                   	push   %eax
80104cab:	6a 02                	push   $0x2
80104cad:	e8 2e fc ff ff       	call   801048e0 <argint>
80104cb2:	83 c4 10             	add    $0x10,%esp
80104cb5:	85 c0                	test   %eax,%eax
80104cb7:	78 37                	js     80104cf0 <sys_read+0x60>
80104cb9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104cbc:	83 ec 04             	sub    $0x4,%esp
80104cbf:	ff 75 f0             	pushl  -0x10(%ebp)
80104cc2:	50                   	push   %eax
80104cc3:	6a 01                	push   $0x1
80104cc5:	e8 66 fc ff ff       	call   80104930 <argptr>
80104cca:	83 c4 10             	add    $0x10,%esp
80104ccd:	85 c0                	test   %eax,%eax
80104ccf:	78 1f                	js     80104cf0 <sys_read+0x60>
  return fileread(f, p, n);
80104cd1:	83 ec 04             	sub    $0x4,%esp
80104cd4:	ff 75 f0             	pushl  -0x10(%ebp)
80104cd7:	ff 75 f4             	pushl  -0xc(%ebp)
80104cda:	ff 75 ec             	pushl  -0x14(%ebp)
80104cdd:	e8 6e c3 ff ff       	call   80101050 <fileread>
80104ce2:	83 c4 10             	add    $0x10,%esp
}
80104ce5:	c9                   	leave  
80104ce6:	c3                   	ret    
80104ce7:	89 f6                	mov    %esi,%esi
80104ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104cf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cf5:	c9                   	leave  
80104cf6:	c3                   	ret    
80104cf7:	89 f6                	mov    %esi,%esi
80104cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d00 <sys_steal>:
{
80104d00:	55                   	push   %ebp
  if(argfd(0, 0, &f) != 0)
80104d01:	31 c0                	xor    %eax,%eax
{
80104d03:	89 e5                	mov    %esp,%ebp
80104d05:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) != 0)
80104d08:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104d0b:	e8 c0 fe ff ff       	call   80104bd0 <argfd.constprop.0>
80104d10:	85 c0                	test   %eax,%eax
80104d12:	75 14                	jne    80104d28 <sys_steal+0x28>
  return filesteal(f);
80104d14:	83 ec 0c             	sub    $0xc,%esp
80104d17:	ff 75 f4             	pushl  -0xc(%ebp)
80104d1a:	e8 c1 c3 ff ff       	call   801010e0 <filesteal>
80104d1f:	83 c4 10             	add    $0x10,%esp
}
80104d22:	c9                   	leave  
80104d23:	c3                   	ret    
80104d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d2d:	c9                   	leave  
80104d2e:	c3                   	ret    
80104d2f:	90                   	nop

80104d30 <sys_write>:
{
80104d30:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d31:	31 c0                	xor    %eax,%eax
{
80104d33:	89 e5                	mov    %esp,%ebp
80104d35:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d38:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d3b:	e8 90 fe ff ff       	call   80104bd0 <argfd.constprop.0>
80104d40:	85 c0                	test   %eax,%eax
80104d42:	78 4c                	js     80104d90 <sys_write+0x60>
80104d44:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d47:	83 ec 08             	sub    $0x8,%esp
80104d4a:	50                   	push   %eax
80104d4b:	6a 02                	push   $0x2
80104d4d:	e8 8e fb ff ff       	call   801048e0 <argint>
80104d52:	83 c4 10             	add    $0x10,%esp
80104d55:	85 c0                	test   %eax,%eax
80104d57:	78 37                	js     80104d90 <sys_write+0x60>
80104d59:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d5c:	83 ec 04             	sub    $0x4,%esp
80104d5f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d62:	50                   	push   %eax
80104d63:	6a 01                	push   $0x1
80104d65:	e8 c6 fb ff ff       	call   80104930 <argptr>
80104d6a:	83 c4 10             	add    $0x10,%esp
80104d6d:	85 c0                	test   %eax,%eax
80104d6f:	78 1f                	js     80104d90 <sys_write+0x60>
  return filewrite(f, p, n);
80104d71:	83 ec 04             	sub    $0x4,%esp
80104d74:	ff 75 f0             	pushl  -0x10(%ebp)
80104d77:	ff 75 f4             	pushl  -0xc(%ebp)
80104d7a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d7d:	e8 be c3 ff ff       	call   80101140 <filewrite>
80104d82:	83 c4 10             	add    $0x10,%esp
}
80104d85:	c9                   	leave  
80104d86:	c3                   	ret    
80104d87:	89 f6                	mov    %esi,%esi
80104d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104d90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d95:	c9                   	leave  
80104d96:	c3                   	ret    
80104d97:	89 f6                	mov    %esi,%esi
80104d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104da0 <sys_close>:
{
80104da0:	55                   	push   %ebp
80104da1:	89 e5                	mov    %esp,%ebp
80104da3:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104da6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104da9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104dac:	e8 1f fe ff ff       	call   80104bd0 <argfd.constprop.0>
80104db1:	85 c0                	test   %eax,%eax
80104db3:	78 2b                	js     80104de0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104db5:	e8 b6 eb ff ff       	call   80103970 <myproc>
80104dba:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104dbd:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104dc0:	c7 44 90 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edx,4)
80104dc7:	00 
  fileclose(f);
80104dc8:	ff 75 f4             	pushl  -0xc(%ebp)
80104dcb:	e8 60 c1 ff ff       	call   80100f30 <fileclose>
  return 0;
80104dd0:	83 c4 10             	add    $0x10,%esp
80104dd3:	31 c0                	xor    %eax,%eax
}
80104dd5:	c9                   	leave  
80104dd6:	c3                   	ret    
80104dd7:	89 f6                	mov    %esi,%esi
80104dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104de0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104de5:	c9                   	leave  
80104de6:	c3                   	ret    
80104de7:	89 f6                	mov    %esi,%esi
80104de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104df0 <sys_fstat>:
{
80104df0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104df1:	31 c0                	xor    %eax,%eax
{
80104df3:	89 e5                	mov    %esp,%ebp
80104df5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104df8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104dfb:	e8 d0 fd ff ff       	call   80104bd0 <argfd.constprop.0>
80104e00:	85 c0                	test   %eax,%eax
80104e02:	78 2c                	js     80104e30 <sys_fstat+0x40>
80104e04:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e07:	83 ec 04             	sub    $0x4,%esp
80104e0a:	6a 14                	push   $0x14
80104e0c:	50                   	push   %eax
80104e0d:	6a 01                	push   $0x1
80104e0f:	e8 1c fb ff ff       	call   80104930 <argptr>
80104e14:	83 c4 10             	add    $0x10,%esp
80104e17:	85 c0                	test   %eax,%eax
80104e19:	78 15                	js     80104e30 <sys_fstat+0x40>
  return filestat(f, st);
80104e1b:	83 ec 08             	sub    $0x8,%esp
80104e1e:	ff 75 f4             	pushl  -0xc(%ebp)
80104e21:	ff 75 f0             	pushl  -0x10(%ebp)
80104e24:	e8 d7 c1 ff ff       	call   80101000 <filestat>
80104e29:	83 c4 10             	add    $0x10,%esp
}
80104e2c:	c9                   	leave  
80104e2d:	c3                   	ret    
80104e2e:	66 90                	xchg   %ax,%ax
    return -1;
80104e30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e35:	c9                   	leave  
80104e36:	c3                   	ret    
80104e37:	89 f6                	mov    %esi,%esi
80104e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e40 <sys_link>:
{
80104e40:	55                   	push   %ebp
80104e41:	89 e5                	mov    %esp,%ebp
80104e43:	57                   	push   %edi
80104e44:	56                   	push   %esi
80104e45:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e46:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104e49:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e4c:	50                   	push   %eax
80104e4d:	6a 00                	push   $0x0
80104e4f:	e8 3c fb ff ff       	call   80104990 <argstr>
80104e54:	83 c4 10             	add    $0x10,%esp
80104e57:	85 c0                	test   %eax,%eax
80104e59:	0f 88 fb 00 00 00    	js     80104f5a <sys_link+0x11a>
80104e5f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104e62:	83 ec 08             	sub    $0x8,%esp
80104e65:	50                   	push   %eax
80104e66:	6a 01                	push   $0x1
80104e68:	e8 23 fb ff ff       	call   80104990 <argstr>
80104e6d:	83 c4 10             	add    $0x10,%esp
80104e70:	85 c0                	test   %eax,%eax
80104e72:	0f 88 e2 00 00 00    	js     80104f5a <sys_link+0x11a>
  begin_op();
80104e78:	e8 b3 de ff ff       	call   80102d30 <begin_op>
  if((ip = namei(old)) == 0){
80104e7d:	83 ec 0c             	sub    $0xc,%esp
80104e80:	ff 75 d4             	pushl  -0x2c(%ebp)
80104e83:	e8 e8 d1 ff ff       	call   80102070 <namei>
80104e88:	83 c4 10             	add    $0x10,%esp
80104e8b:	85 c0                	test   %eax,%eax
80104e8d:	89 c3                	mov    %eax,%ebx
80104e8f:	0f 84 ea 00 00 00    	je     80104f7f <sys_link+0x13f>
  ilock(ip);
80104e95:	83 ec 0c             	sub    $0xc,%esp
80104e98:	50                   	push   %eax
80104e99:	e8 32 c9 ff ff       	call   801017d0 <ilock>
  if(ip->type == T_DIR){
80104e9e:	83 c4 10             	add    $0x10,%esp
80104ea1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104ea6:	0f 84 bb 00 00 00    	je     80104f67 <sys_link+0x127>
  ip->nlink++;
80104eac:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104eb1:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80104eb4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104eb7:	53                   	push   %ebx
80104eb8:	e8 63 c8 ff ff       	call   80101720 <iupdate>
  iunlock(ip);
80104ebd:	89 1c 24             	mov    %ebx,(%esp)
80104ec0:	e8 eb c9 ff ff       	call   801018b0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104ec5:	58                   	pop    %eax
80104ec6:	5a                   	pop    %edx
80104ec7:	57                   	push   %edi
80104ec8:	ff 75 d0             	pushl  -0x30(%ebp)
80104ecb:	e8 c0 d1 ff ff       	call   80102090 <nameiparent>
80104ed0:	83 c4 10             	add    $0x10,%esp
80104ed3:	85 c0                	test   %eax,%eax
80104ed5:	89 c6                	mov    %eax,%esi
80104ed7:	74 5b                	je     80104f34 <sys_link+0xf4>
  ilock(dp);
80104ed9:	83 ec 0c             	sub    $0xc,%esp
80104edc:	50                   	push   %eax
80104edd:	e8 ee c8 ff ff       	call   801017d0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104ee2:	83 c4 10             	add    $0x10,%esp
80104ee5:	8b 03                	mov    (%ebx),%eax
80104ee7:	39 06                	cmp    %eax,(%esi)
80104ee9:	75 3d                	jne    80104f28 <sys_link+0xe8>
80104eeb:	83 ec 04             	sub    $0x4,%esp
80104eee:	ff 73 04             	pushl  0x4(%ebx)
80104ef1:	57                   	push   %edi
80104ef2:	56                   	push   %esi
80104ef3:	e8 b8 d0 ff ff       	call   80101fb0 <dirlink>
80104ef8:	83 c4 10             	add    $0x10,%esp
80104efb:	85 c0                	test   %eax,%eax
80104efd:	78 29                	js     80104f28 <sys_link+0xe8>
  iunlockput(dp);
80104eff:	83 ec 0c             	sub    $0xc,%esp
80104f02:	56                   	push   %esi
80104f03:	e8 58 cb ff ff       	call   80101a60 <iunlockput>
  iput(ip);
80104f08:	89 1c 24             	mov    %ebx,(%esp)
80104f0b:	e8 f0 c9 ff ff       	call   80101900 <iput>
  end_op();
80104f10:	e8 8b de ff ff       	call   80102da0 <end_op>
  return 0;
80104f15:	83 c4 10             	add    $0x10,%esp
80104f18:	31 c0                	xor    %eax,%eax
}
80104f1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f1d:	5b                   	pop    %ebx
80104f1e:	5e                   	pop    %esi
80104f1f:	5f                   	pop    %edi
80104f20:	5d                   	pop    %ebp
80104f21:	c3                   	ret    
80104f22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104f28:	83 ec 0c             	sub    $0xc,%esp
80104f2b:	56                   	push   %esi
80104f2c:	e8 2f cb ff ff       	call   80101a60 <iunlockput>
    goto bad;
80104f31:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104f34:	83 ec 0c             	sub    $0xc,%esp
80104f37:	53                   	push   %ebx
80104f38:	e8 93 c8 ff ff       	call   801017d0 <ilock>
  ip->nlink--;
80104f3d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f42:	89 1c 24             	mov    %ebx,(%esp)
80104f45:	e8 d6 c7 ff ff       	call   80101720 <iupdate>
  iunlockput(ip);
80104f4a:	89 1c 24             	mov    %ebx,(%esp)
80104f4d:	e8 0e cb ff ff       	call   80101a60 <iunlockput>
  end_op();
80104f52:	e8 49 de ff ff       	call   80102da0 <end_op>
  return -1;
80104f57:	83 c4 10             	add    $0x10,%esp
}
80104f5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104f5d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f62:	5b                   	pop    %ebx
80104f63:	5e                   	pop    %esi
80104f64:	5f                   	pop    %edi
80104f65:	5d                   	pop    %ebp
80104f66:	c3                   	ret    
    iunlockput(ip);
80104f67:	83 ec 0c             	sub    $0xc,%esp
80104f6a:	53                   	push   %ebx
80104f6b:	e8 f0 ca ff ff       	call   80101a60 <iunlockput>
    end_op();
80104f70:	e8 2b de ff ff       	call   80102da0 <end_op>
    return -1;
80104f75:	83 c4 10             	add    $0x10,%esp
80104f78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f7d:	eb 9b                	jmp    80104f1a <sys_link+0xda>
    end_op();
80104f7f:	e8 1c de ff ff       	call   80102da0 <end_op>
    return -1;
80104f84:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f89:	eb 8f                	jmp    80104f1a <sys_link+0xda>
80104f8b:	90                   	nop
80104f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f90 <sys_unlink>:
{
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
80104f93:	57                   	push   %edi
80104f94:	56                   	push   %esi
80104f95:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80104f96:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80104f99:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
80104f9c:	50                   	push   %eax
80104f9d:	6a 00                	push   $0x0
80104f9f:	e8 ec f9 ff ff       	call   80104990 <argstr>
80104fa4:	83 c4 10             	add    $0x10,%esp
80104fa7:	85 c0                	test   %eax,%eax
80104fa9:	0f 88 77 01 00 00    	js     80105126 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
80104faf:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80104fb2:	e8 79 dd ff ff       	call   80102d30 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104fb7:	83 ec 08             	sub    $0x8,%esp
80104fba:	53                   	push   %ebx
80104fbb:	ff 75 c0             	pushl  -0x40(%ebp)
80104fbe:	e8 cd d0 ff ff       	call   80102090 <nameiparent>
80104fc3:	83 c4 10             	add    $0x10,%esp
80104fc6:	85 c0                	test   %eax,%eax
80104fc8:	89 c6                	mov    %eax,%esi
80104fca:	0f 84 60 01 00 00    	je     80105130 <sys_unlink+0x1a0>
  ilock(dp);
80104fd0:	83 ec 0c             	sub    $0xc,%esp
80104fd3:	50                   	push   %eax
80104fd4:	e8 f7 c7 ff ff       	call   801017d0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104fd9:	58                   	pop    %eax
80104fda:	5a                   	pop    %edx
80104fdb:	68 fc 77 10 80       	push   $0x801077fc
80104fe0:	53                   	push   %ebx
80104fe1:	e8 3a cd ff ff       	call   80101d20 <namecmp>
80104fe6:	83 c4 10             	add    $0x10,%esp
80104fe9:	85 c0                	test   %eax,%eax
80104feb:	0f 84 03 01 00 00    	je     801050f4 <sys_unlink+0x164>
80104ff1:	83 ec 08             	sub    $0x8,%esp
80104ff4:	68 fb 77 10 80       	push   $0x801077fb
80104ff9:	53                   	push   %ebx
80104ffa:	e8 21 cd ff ff       	call   80101d20 <namecmp>
80104fff:	83 c4 10             	add    $0x10,%esp
80105002:	85 c0                	test   %eax,%eax
80105004:	0f 84 ea 00 00 00    	je     801050f4 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010500a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010500d:	83 ec 04             	sub    $0x4,%esp
80105010:	50                   	push   %eax
80105011:	53                   	push   %ebx
80105012:	56                   	push   %esi
80105013:	e8 28 cd ff ff       	call   80101d40 <dirlookup>
80105018:	83 c4 10             	add    $0x10,%esp
8010501b:	85 c0                	test   %eax,%eax
8010501d:	89 c3                	mov    %eax,%ebx
8010501f:	0f 84 cf 00 00 00    	je     801050f4 <sys_unlink+0x164>
  ilock(ip);
80105025:	83 ec 0c             	sub    $0xc,%esp
80105028:	50                   	push   %eax
80105029:	e8 a2 c7 ff ff       	call   801017d0 <ilock>
  if(ip->nlink < 1)
8010502e:	83 c4 10             	add    $0x10,%esp
80105031:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105036:	0f 8e 10 01 00 00    	jle    8010514c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010503c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105041:	74 6d                	je     801050b0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105043:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105046:	83 ec 04             	sub    $0x4,%esp
80105049:	6a 10                	push   $0x10
8010504b:	6a 00                	push   $0x0
8010504d:	50                   	push   %eax
8010504e:	e8 8d f5 ff ff       	call   801045e0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105053:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105056:	6a 10                	push   $0x10
80105058:	ff 75 c4             	pushl  -0x3c(%ebp)
8010505b:	50                   	push   %eax
8010505c:	56                   	push   %esi
8010505d:	e8 8e cb ff ff       	call   80101bf0 <writei>
80105062:	83 c4 20             	add    $0x20,%esp
80105065:	83 f8 10             	cmp    $0x10,%eax
80105068:	0f 85 eb 00 00 00    	jne    80105159 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
8010506e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105073:	0f 84 97 00 00 00    	je     80105110 <sys_unlink+0x180>
  iunlockput(dp);
80105079:	83 ec 0c             	sub    $0xc,%esp
8010507c:	56                   	push   %esi
8010507d:	e8 de c9 ff ff       	call   80101a60 <iunlockput>
  ip->nlink--;
80105082:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105087:	89 1c 24             	mov    %ebx,(%esp)
8010508a:	e8 91 c6 ff ff       	call   80101720 <iupdate>
  iunlockput(ip);
8010508f:	89 1c 24             	mov    %ebx,(%esp)
80105092:	e8 c9 c9 ff ff       	call   80101a60 <iunlockput>
  end_op();
80105097:	e8 04 dd ff ff       	call   80102da0 <end_op>
  return 0;
8010509c:	83 c4 10             	add    $0x10,%esp
8010509f:	31 c0                	xor    %eax,%eax
}
801050a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050a4:	5b                   	pop    %ebx
801050a5:	5e                   	pop    %esi
801050a6:	5f                   	pop    %edi
801050a7:	5d                   	pop    %ebp
801050a8:	c3                   	ret    
801050a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801050b0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801050b4:	76 8d                	jbe    80105043 <sys_unlink+0xb3>
801050b6:	bf 20 00 00 00       	mov    $0x20,%edi
801050bb:	eb 0f                	jmp    801050cc <sys_unlink+0x13c>
801050bd:	8d 76 00             	lea    0x0(%esi),%esi
801050c0:	83 c7 10             	add    $0x10,%edi
801050c3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801050c6:	0f 83 77 ff ff ff    	jae    80105043 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801050cc:	8d 45 d8             	lea    -0x28(%ebp),%eax
801050cf:	6a 10                	push   $0x10
801050d1:	57                   	push   %edi
801050d2:	50                   	push   %eax
801050d3:	53                   	push   %ebx
801050d4:	e8 d7 c9 ff ff       	call   80101ab0 <readi>
801050d9:	83 c4 10             	add    $0x10,%esp
801050dc:	83 f8 10             	cmp    $0x10,%eax
801050df:	75 5e                	jne    8010513f <sys_unlink+0x1af>
    if(de.inum != 0)
801050e1:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801050e6:	74 d8                	je     801050c0 <sys_unlink+0x130>
    iunlockput(ip);
801050e8:	83 ec 0c             	sub    $0xc,%esp
801050eb:	53                   	push   %ebx
801050ec:	e8 6f c9 ff ff       	call   80101a60 <iunlockput>
    goto bad;
801050f1:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
801050f4:	83 ec 0c             	sub    $0xc,%esp
801050f7:	56                   	push   %esi
801050f8:	e8 63 c9 ff ff       	call   80101a60 <iunlockput>
  end_op();
801050fd:	e8 9e dc ff ff       	call   80102da0 <end_op>
  return -1;
80105102:	83 c4 10             	add    $0x10,%esp
80105105:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010510a:	eb 95                	jmp    801050a1 <sys_unlink+0x111>
8010510c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105110:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105115:	83 ec 0c             	sub    $0xc,%esp
80105118:	56                   	push   %esi
80105119:	e8 02 c6 ff ff       	call   80101720 <iupdate>
8010511e:	83 c4 10             	add    $0x10,%esp
80105121:	e9 53 ff ff ff       	jmp    80105079 <sys_unlink+0xe9>
    return -1;
80105126:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010512b:	e9 71 ff ff ff       	jmp    801050a1 <sys_unlink+0x111>
    end_op();
80105130:	e8 6b dc ff ff       	call   80102da0 <end_op>
    return -1;
80105135:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010513a:	e9 62 ff ff ff       	jmp    801050a1 <sys_unlink+0x111>
      panic("isdirempty: readi");
8010513f:	83 ec 0c             	sub    $0xc,%esp
80105142:	68 20 78 10 80       	push   $0x80107820
80105147:	e8 14 b3 ff ff       	call   80100460 <panic>
    panic("unlink: nlink < 1");
8010514c:	83 ec 0c             	sub    $0xc,%esp
8010514f:	68 0e 78 10 80       	push   $0x8010780e
80105154:	e8 07 b3 ff ff       	call   80100460 <panic>
    panic("unlink: writei");
80105159:	83 ec 0c             	sub    $0xc,%esp
8010515c:	68 32 78 10 80       	push   $0x80107832
80105161:	e8 fa b2 ff ff       	call   80100460 <panic>
80105166:	8d 76 00             	lea    0x0(%esi),%esi
80105169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105170 <sys_open>:

int
sys_open(void)
{
80105170:	55                   	push   %ebp
80105171:	89 e5                	mov    %esp,%ebp
80105173:	57                   	push   %edi
80105174:	56                   	push   %esi
80105175:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105176:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105179:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010517c:	50                   	push   %eax
8010517d:	6a 00                	push   $0x0
8010517f:	e8 0c f8 ff ff       	call   80104990 <argstr>
80105184:	83 c4 10             	add    $0x10,%esp
80105187:	85 c0                	test   %eax,%eax
80105189:	0f 88 1d 01 00 00    	js     801052ac <sys_open+0x13c>
8010518f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105192:	83 ec 08             	sub    $0x8,%esp
80105195:	50                   	push   %eax
80105196:	6a 01                	push   $0x1
80105198:	e8 43 f7 ff ff       	call   801048e0 <argint>
8010519d:	83 c4 10             	add    $0x10,%esp
801051a0:	85 c0                	test   %eax,%eax
801051a2:	0f 88 04 01 00 00    	js     801052ac <sys_open+0x13c>
    return -1;

  begin_op();
801051a8:	e8 83 db ff ff       	call   80102d30 <begin_op>

  if(omode & O_CREATE){
801051ad:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801051b1:	0f 85 a9 00 00 00    	jne    80105260 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801051b7:	83 ec 0c             	sub    $0xc,%esp
801051ba:	ff 75 e0             	pushl  -0x20(%ebp)
801051bd:	e8 ae ce ff ff       	call   80102070 <namei>
801051c2:	83 c4 10             	add    $0x10,%esp
801051c5:	85 c0                	test   %eax,%eax
801051c7:	89 c6                	mov    %eax,%esi
801051c9:	0f 84 b2 00 00 00    	je     80105281 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
801051cf:	83 ec 0c             	sub    $0xc,%esp
801051d2:	50                   	push   %eax
801051d3:	e8 f8 c5 ff ff       	call   801017d0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801051d8:	83 c4 10             	add    $0x10,%esp
801051db:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801051e0:	0f 84 aa 00 00 00    	je     80105290 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801051e6:	e8 85 bc ff ff       	call   80100e70 <filealloc>
801051eb:	85 c0                	test   %eax,%eax
801051ed:	89 c7                	mov    %eax,%edi
801051ef:	0f 84 a6 00 00 00    	je     8010529b <sys_open+0x12b>
  struct proc *curproc = myproc();
801051f5:	e8 76 e7 ff ff       	call   80103970 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801051fa:	31 db                	xor    %ebx,%ebx
801051fc:	eb 0e                	jmp    8010520c <sys_open+0x9c>
801051fe:	66 90                	xchg   %ax,%ax
80105200:	83 c3 01             	add    $0x1,%ebx
80105203:	83 fb 10             	cmp    $0x10,%ebx
80105206:	0f 84 ac 00 00 00    	je     801052b8 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
8010520c:	8b 54 98 2c          	mov    0x2c(%eax,%ebx,4),%edx
80105210:	85 d2                	test   %edx,%edx
80105212:	75 ec                	jne    80105200 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105214:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105217:	89 7c 98 2c          	mov    %edi,0x2c(%eax,%ebx,4)
  iunlock(ip);
8010521b:	56                   	push   %esi
8010521c:	e8 8f c6 ff ff       	call   801018b0 <iunlock>
  end_op();
80105221:	e8 7a db ff ff       	call   80102da0 <end_op>

  f->type = FD_INODE;
80105226:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010522c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010522f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105232:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105235:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010523c:	89 d0                	mov    %edx,%eax
8010523e:	f7 d0                	not    %eax
80105240:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105243:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105246:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105249:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010524d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105250:	89 d8                	mov    %ebx,%eax
80105252:	5b                   	pop    %ebx
80105253:	5e                   	pop    %esi
80105254:	5f                   	pop    %edi
80105255:	5d                   	pop    %ebp
80105256:	c3                   	ret    
80105257:	89 f6                	mov    %esi,%esi
80105259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105260:	83 ec 0c             	sub    $0xc,%esp
80105263:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105266:	31 c9                	xor    %ecx,%ecx
80105268:	6a 00                	push   $0x0
8010526a:	ba 02 00 00 00       	mov    $0x2,%edx
8010526f:	e8 bc f7 ff ff       	call   80104a30 <create>
    if(ip == 0){
80105274:	83 c4 10             	add    $0x10,%esp
80105277:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105279:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010527b:	0f 85 65 ff ff ff    	jne    801051e6 <sys_open+0x76>
      end_op();
80105281:	e8 1a db ff ff       	call   80102da0 <end_op>
      return -1;
80105286:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010528b:	eb c0                	jmp    8010524d <sys_open+0xdd>
8010528d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105290:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105293:	85 c9                	test   %ecx,%ecx
80105295:	0f 84 4b ff ff ff    	je     801051e6 <sys_open+0x76>
    iunlockput(ip);
8010529b:	83 ec 0c             	sub    $0xc,%esp
8010529e:	56                   	push   %esi
8010529f:	e8 bc c7 ff ff       	call   80101a60 <iunlockput>
    end_op();
801052a4:	e8 f7 da ff ff       	call   80102da0 <end_op>
    return -1;
801052a9:	83 c4 10             	add    $0x10,%esp
801052ac:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801052b1:	eb 9a                	jmp    8010524d <sys_open+0xdd>
801052b3:	90                   	nop
801052b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
801052b8:	83 ec 0c             	sub    $0xc,%esp
801052bb:	57                   	push   %edi
801052bc:	e8 6f bc ff ff       	call   80100f30 <fileclose>
801052c1:	83 c4 10             	add    $0x10,%esp
801052c4:	eb d5                	jmp    8010529b <sys_open+0x12b>
801052c6:	8d 76 00             	lea    0x0(%esi),%esi
801052c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052d0 <sys_mkdir>:

int
sys_mkdir(void)
{
801052d0:	55                   	push   %ebp
801052d1:	89 e5                	mov    %esp,%ebp
801052d3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801052d6:	e8 55 da ff ff       	call   80102d30 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801052db:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052de:	83 ec 08             	sub    $0x8,%esp
801052e1:	50                   	push   %eax
801052e2:	6a 00                	push   $0x0
801052e4:	e8 a7 f6 ff ff       	call   80104990 <argstr>
801052e9:	83 c4 10             	add    $0x10,%esp
801052ec:	85 c0                	test   %eax,%eax
801052ee:	78 30                	js     80105320 <sys_mkdir+0x50>
801052f0:	83 ec 0c             	sub    $0xc,%esp
801052f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052f6:	31 c9                	xor    %ecx,%ecx
801052f8:	6a 00                	push   $0x0
801052fa:	ba 01 00 00 00       	mov    $0x1,%edx
801052ff:	e8 2c f7 ff ff       	call   80104a30 <create>
80105304:	83 c4 10             	add    $0x10,%esp
80105307:	85 c0                	test   %eax,%eax
80105309:	74 15                	je     80105320 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010530b:	83 ec 0c             	sub    $0xc,%esp
8010530e:	50                   	push   %eax
8010530f:	e8 4c c7 ff ff       	call   80101a60 <iunlockput>
  end_op();
80105314:	e8 87 da ff ff       	call   80102da0 <end_op>
  return 0;
80105319:	83 c4 10             	add    $0x10,%esp
8010531c:	31 c0                	xor    %eax,%eax
}
8010531e:	c9                   	leave  
8010531f:	c3                   	ret    
    end_op();
80105320:	e8 7b da ff ff       	call   80102da0 <end_op>
    return -1;
80105325:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010532a:	c9                   	leave  
8010532b:	c3                   	ret    
8010532c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105330 <sys_mknod>:

int
sys_mknod(void)
{
80105330:	55                   	push   %ebp
80105331:	89 e5                	mov    %esp,%ebp
80105333:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105336:	e8 f5 d9 ff ff       	call   80102d30 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010533b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010533e:	83 ec 08             	sub    $0x8,%esp
80105341:	50                   	push   %eax
80105342:	6a 00                	push   $0x0
80105344:	e8 47 f6 ff ff       	call   80104990 <argstr>
80105349:	83 c4 10             	add    $0x10,%esp
8010534c:	85 c0                	test   %eax,%eax
8010534e:	78 60                	js     801053b0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105350:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105353:	83 ec 08             	sub    $0x8,%esp
80105356:	50                   	push   %eax
80105357:	6a 01                	push   $0x1
80105359:	e8 82 f5 ff ff       	call   801048e0 <argint>
  if((argstr(0, &path)) < 0 ||
8010535e:	83 c4 10             	add    $0x10,%esp
80105361:	85 c0                	test   %eax,%eax
80105363:	78 4b                	js     801053b0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105365:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105368:	83 ec 08             	sub    $0x8,%esp
8010536b:	50                   	push   %eax
8010536c:	6a 02                	push   $0x2
8010536e:	e8 6d f5 ff ff       	call   801048e0 <argint>
     argint(1, &major) < 0 ||
80105373:	83 c4 10             	add    $0x10,%esp
80105376:	85 c0                	test   %eax,%eax
80105378:	78 36                	js     801053b0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010537a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010537e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105381:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105385:	ba 03 00 00 00       	mov    $0x3,%edx
8010538a:	50                   	push   %eax
8010538b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010538e:	e8 9d f6 ff ff       	call   80104a30 <create>
80105393:	83 c4 10             	add    $0x10,%esp
80105396:	85 c0                	test   %eax,%eax
80105398:	74 16                	je     801053b0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010539a:	83 ec 0c             	sub    $0xc,%esp
8010539d:	50                   	push   %eax
8010539e:	e8 bd c6 ff ff       	call   80101a60 <iunlockput>
  end_op();
801053a3:	e8 f8 d9 ff ff       	call   80102da0 <end_op>
  return 0;
801053a8:	83 c4 10             	add    $0x10,%esp
801053ab:	31 c0                	xor    %eax,%eax
}
801053ad:	c9                   	leave  
801053ae:	c3                   	ret    
801053af:	90                   	nop
    end_op();
801053b0:	e8 eb d9 ff ff       	call   80102da0 <end_op>
    return -1;
801053b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053ba:	c9                   	leave  
801053bb:	c3                   	ret    
801053bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053c0 <sys_chdir>:

int
sys_chdir(void)
{
801053c0:	55                   	push   %ebp
801053c1:	89 e5                	mov    %esp,%ebp
801053c3:	56                   	push   %esi
801053c4:	53                   	push   %ebx
801053c5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801053c8:	e8 a3 e5 ff ff       	call   80103970 <myproc>
801053cd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801053cf:	e8 5c d9 ff ff       	call   80102d30 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801053d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053d7:	83 ec 08             	sub    $0x8,%esp
801053da:	50                   	push   %eax
801053db:	6a 00                	push   $0x0
801053dd:	e8 ae f5 ff ff       	call   80104990 <argstr>
801053e2:	83 c4 10             	add    $0x10,%esp
801053e5:	85 c0                	test   %eax,%eax
801053e7:	78 77                	js     80105460 <sys_chdir+0xa0>
801053e9:	83 ec 0c             	sub    $0xc,%esp
801053ec:	ff 75 f4             	pushl  -0xc(%ebp)
801053ef:	e8 7c cc ff ff       	call   80102070 <namei>
801053f4:	83 c4 10             	add    $0x10,%esp
801053f7:	85 c0                	test   %eax,%eax
801053f9:	89 c3                	mov    %eax,%ebx
801053fb:	74 63                	je     80105460 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801053fd:	83 ec 0c             	sub    $0xc,%esp
80105400:	50                   	push   %eax
80105401:	e8 ca c3 ff ff       	call   801017d0 <ilock>
  if(ip->type != T_DIR){
80105406:	83 c4 10             	add    $0x10,%esp
80105409:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010540e:	75 30                	jne    80105440 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105410:	83 ec 0c             	sub    $0xc,%esp
80105413:	53                   	push   %ebx
80105414:	e8 97 c4 ff ff       	call   801018b0 <iunlock>
  iput(curproc->cwd);
80105419:	58                   	pop    %eax
8010541a:	ff 76 6c             	pushl  0x6c(%esi)
8010541d:	e8 de c4 ff ff       	call   80101900 <iput>
  end_op();
80105422:	e8 79 d9 ff ff       	call   80102da0 <end_op>
  curproc->cwd = ip;
80105427:	89 5e 6c             	mov    %ebx,0x6c(%esi)
  return 0;
8010542a:	83 c4 10             	add    $0x10,%esp
8010542d:	31 c0                	xor    %eax,%eax
}
8010542f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105432:	5b                   	pop    %ebx
80105433:	5e                   	pop    %esi
80105434:	5d                   	pop    %ebp
80105435:	c3                   	ret    
80105436:	8d 76 00             	lea    0x0(%esi),%esi
80105439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105440:	83 ec 0c             	sub    $0xc,%esp
80105443:	53                   	push   %ebx
80105444:	e8 17 c6 ff ff       	call   80101a60 <iunlockput>
    end_op();
80105449:	e8 52 d9 ff ff       	call   80102da0 <end_op>
    return -1;
8010544e:	83 c4 10             	add    $0x10,%esp
80105451:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105456:	eb d7                	jmp    8010542f <sys_chdir+0x6f>
80105458:	90                   	nop
80105459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105460:	e8 3b d9 ff ff       	call   80102da0 <end_op>
    return -1;
80105465:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010546a:	eb c3                	jmp    8010542f <sys_chdir+0x6f>
8010546c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105470 <sys_exec>:

int
sys_exec(void)
{
80105470:	55                   	push   %ebp
80105471:	89 e5                	mov    %esp,%ebp
80105473:	57                   	push   %edi
80105474:	56                   	push   %esi
80105475:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105476:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010547c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105482:	50                   	push   %eax
80105483:	6a 00                	push   $0x0
80105485:	e8 06 f5 ff ff       	call   80104990 <argstr>
8010548a:	83 c4 10             	add    $0x10,%esp
8010548d:	85 c0                	test   %eax,%eax
8010548f:	0f 88 87 00 00 00    	js     8010551c <sys_exec+0xac>
80105495:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010549b:	83 ec 08             	sub    $0x8,%esp
8010549e:	50                   	push   %eax
8010549f:	6a 01                	push   $0x1
801054a1:	e8 3a f4 ff ff       	call   801048e0 <argint>
801054a6:	83 c4 10             	add    $0x10,%esp
801054a9:	85 c0                	test   %eax,%eax
801054ab:	78 6f                	js     8010551c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801054ad:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801054b3:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
801054b6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801054b8:	68 80 00 00 00       	push   $0x80
801054bd:	6a 00                	push   $0x0
801054bf:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801054c5:	50                   	push   %eax
801054c6:	e8 15 f1 ff ff       	call   801045e0 <memset>
801054cb:	83 c4 10             	add    $0x10,%esp
801054ce:	eb 2c                	jmp    801054fc <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
801054d0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801054d6:	85 c0                	test   %eax,%eax
801054d8:	74 56                	je     80105530 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801054da:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801054e0:	83 ec 08             	sub    $0x8,%esp
801054e3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801054e6:	52                   	push   %edx
801054e7:	50                   	push   %eax
801054e8:	e8 83 f3 ff ff       	call   80104870 <fetchstr>
801054ed:	83 c4 10             	add    $0x10,%esp
801054f0:	85 c0                	test   %eax,%eax
801054f2:	78 28                	js     8010551c <sys_exec+0xac>
  for(i=0;; i++){
801054f4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801054f7:	83 fb 20             	cmp    $0x20,%ebx
801054fa:	74 20                	je     8010551c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801054fc:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105502:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105509:	83 ec 08             	sub    $0x8,%esp
8010550c:	57                   	push   %edi
8010550d:	01 f0                	add    %esi,%eax
8010550f:	50                   	push   %eax
80105510:	e8 1b f3 ff ff       	call   80104830 <fetchint>
80105515:	83 c4 10             	add    $0x10,%esp
80105518:	85 c0                	test   %eax,%eax
8010551a:	79 b4                	jns    801054d0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010551c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010551f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105524:	5b                   	pop    %ebx
80105525:	5e                   	pop    %esi
80105526:	5f                   	pop    %edi
80105527:	5d                   	pop    %ebp
80105528:	c3                   	ret    
80105529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105530:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105536:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105539:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105540:	00 00 00 00 
  return exec(path, argv);
80105544:	50                   	push   %eax
80105545:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010554b:	e8 b0 b5 ff ff       	call   80100b00 <exec>
80105550:	83 c4 10             	add    $0x10,%esp
}
80105553:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105556:	5b                   	pop    %ebx
80105557:	5e                   	pop    %esi
80105558:	5f                   	pop    %edi
80105559:	5d                   	pop    %ebp
8010555a:	c3                   	ret    
8010555b:	90                   	nop
8010555c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105560 <sys_pipe>:

int
sys_pipe(void)
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	57                   	push   %edi
80105564:	56                   	push   %esi
80105565:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105566:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105569:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010556c:	6a 08                	push   $0x8
8010556e:	50                   	push   %eax
8010556f:	6a 00                	push   $0x0
80105571:	e8 ba f3 ff ff       	call   80104930 <argptr>
80105576:	83 c4 10             	add    $0x10,%esp
80105579:	85 c0                	test   %eax,%eax
8010557b:	0f 88 ae 00 00 00    	js     8010562f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105581:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105584:	83 ec 08             	sub    $0x8,%esp
80105587:	50                   	push   %eax
80105588:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010558b:	50                   	push   %eax
8010558c:	e8 3f de ff ff       	call   801033d0 <pipealloc>
80105591:	83 c4 10             	add    $0x10,%esp
80105594:	85 c0                	test   %eax,%eax
80105596:	0f 88 93 00 00 00    	js     8010562f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010559c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010559f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801055a1:	e8 ca e3 ff ff       	call   80103970 <myproc>
801055a6:	eb 10                	jmp    801055b8 <sys_pipe+0x58>
801055a8:	90                   	nop
801055a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
801055b0:	83 c3 01             	add    $0x1,%ebx
801055b3:	83 fb 10             	cmp    $0x10,%ebx
801055b6:	74 60                	je     80105618 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
801055b8:	8b 74 98 2c          	mov    0x2c(%eax,%ebx,4),%esi
801055bc:	85 f6                	test   %esi,%esi
801055be:	75 f0                	jne    801055b0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
801055c0:	8d 73 08             	lea    0x8(%ebx),%esi
801055c3:	89 7c b0 0c          	mov    %edi,0xc(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801055c7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801055ca:	e8 a1 e3 ff ff       	call   80103970 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801055cf:	31 d2                	xor    %edx,%edx
801055d1:	eb 0d                	jmp    801055e0 <sys_pipe+0x80>
801055d3:	90                   	nop
801055d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055d8:	83 c2 01             	add    $0x1,%edx
801055db:	83 fa 10             	cmp    $0x10,%edx
801055de:	74 28                	je     80105608 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
801055e0:	8b 4c 90 2c          	mov    0x2c(%eax,%edx,4),%ecx
801055e4:	85 c9                	test   %ecx,%ecx
801055e6:	75 f0                	jne    801055d8 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
801055e8:	89 7c 90 2c          	mov    %edi,0x2c(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801055ec:	8b 45 dc             	mov    -0x24(%ebp),%eax
801055ef:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801055f1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801055f4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801055f7:	31 c0                	xor    %eax,%eax
}
801055f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055fc:	5b                   	pop    %ebx
801055fd:	5e                   	pop    %esi
801055fe:	5f                   	pop    %edi
801055ff:	5d                   	pop    %ebp
80105600:	c3                   	ret    
80105601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105608:	e8 63 e3 ff ff       	call   80103970 <myproc>
8010560d:	c7 44 b0 0c 00 00 00 	movl   $0x0,0xc(%eax,%esi,4)
80105614:	00 
80105615:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105618:	83 ec 0c             	sub    $0xc,%esp
8010561b:	ff 75 e0             	pushl  -0x20(%ebp)
8010561e:	e8 0d b9 ff ff       	call   80100f30 <fileclose>
    fileclose(wf);
80105623:	58                   	pop    %eax
80105624:	ff 75 e4             	pushl  -0x1c(%ebp)
80105627:	e8 04 b9 ff ff       	call   80100f30 <fileclose>
    return -1;
8010562c:	83 c4 10             	add    $0x10,%esp
8010562f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105634:	eb c3                	jmp    801055f9 <sys_pipe+0x99>
80105636:	66 90                	xchg   %ax,%ax
80105638:	66 90                	xchg   %ax,%ax
8010563a:	66 90                	xchg   %ax,%ax
8010563c:	66 90                	xchg   %ax,%ax
8010563e:	66 90                	xchg   %ax,%ax

80105640 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105640:	55                   	push   %ebp
80105641:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105643:	5d                   	pop    %ebp
  return fork();
80105644:	e9 c7 e4 ff ff       	jmp    80103b10 <fork>
80105649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105650 <sys_exit>:

int
sys_exit(void)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	83 ec 08             	sub    $0x8,%esp
  exit();
80105656:	e8 35 e7 ff ff       	call   80103d90 <exit>
  return 0;  // not reached
}
8010565b:	31 c0                	xor    %eax,%eax
8010565d:	c9                   	leave  
8010565e:	c3                   	ret    
8010565f:	90                   	nop

80105660 <sys_wait>:

int
sys_wait(void)
{
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105663:	5d                   	pop    %ebp
  return wait();
80105664:	e9 67 e9 ff ff       	jmp    80103fd0 <wait>
80105669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105670 <sys_kill>:

int
sys_kill(void)
{
80105670:	55                   	push   %ebp
80105671:	89 e5                	mov    %esp,%ebp
80105673:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105676:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105679:	50                   	push   %eax
8010567a:	6a 00                	push   $0x0
8010567c:	e8 5f f2 ff ff       	call   801048e0 <argint>
80105681:	83 c4 10             	add    $0x10,%esp
80105684:	85 c0                	test   %eax,%eax
80105686:	78 18                	js     801056a0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105688:	83 ec 0c             	sub    $0xc,%esp
8010568b:	ff 75 f4             	pushl  -0xc(%ebp)
8010568e:	e8 8d ea ff ff       	call   80104120 <kill>
80105693:	83 c4 10             	add    $0x10,%esp
}
80105696:	c9                   	leave  
80105697:	c3                   	ret    
80105698:	90                   	nop
80105699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801056a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056a5:	c9                   	leave  
801056a6:	c3                   	ret    
801056a7:	89 f6                	mov    %esi,%esi
801056a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056b0 <sys_getpid>:

int
sys_getpid(void)
{
801056b0:	55                   	push   %ebp
801056b1:	89 e5                	mov    %esp,%ebp
801056b3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801056b6:	e8 b5 e2 ff ff       	call   80103970 <myproc>
801056bb:	8b 40 10             	mov    0x10(%eax),%eax
}
801056be:	c9                   	leave  
801056bf:	c3                   	ret    

801056c0 <sys_sbrk>:

int
sys_sbrk(void)
{
801056c0:	55                   	push   %ebp
801056c1:	89 e5                	mov    %esp,%ebp
801056c3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801056c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801056c7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801056ca:	50                   	push   %eax
801056cb:	6a 00                	push   $0x0
801056cd:	e8 0e f2 ff ff       	call   801048e0 <argint>
801056d2:	83 c4 10             	add    $0x10,%esp
801056d5:	85 c0                	test   %eax,%eax
801056d7:	78 27                	js     80105700 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801056d9:	e8 92 e2 ff ff       	call   80103970 <myproc>
  if(growproc(n) < 0)
801056de:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801056e1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801056e3:	ff 75 f4             	pushl  -0xc(%ebp)
801056e6:	e8 a5 e3 ff ff       	call   80103a90 <growproc>
801056eb:	83 c4 10             	add    $0x10,%esp
801056ee:	85 c0                	test   %eax,%eax
801056f0:	78 0e                	js     80105700 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801056f2:	89 d8                	mov    %ebx,%eax
801056f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056f7:	c9                   	leave  
801056f8:	c3                   	ret    
801056f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105700:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105705:	eb eb                	jmp    801056f2 <sys_sbrk+0x32>
80105707:	89 f6                	mov    %esi,%esi
80105709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105710 <sys_sleep>:

int
sys_sleep(void)
{
80105710:	55                   	push   %ebp
80105711:	89 e5                	mov    %esp,%ebp
80105713:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105714:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105717:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010571a:	50                   	push   %eax
8010571b:	6a 00                	push   $0x0
8010571d:	e8 be f1 ff ff       	call   801048e0 <argint>
80105722:	83 c4 10             	add    $0x10,%esp
80105725:	85 c0                	test   %eax,%eax
80105727:	0f 88 8a 00 00 00    	js     801057b7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010572d:	83 ec 0c             	sub    $0xc,%esp
80105730:	68 a0 4d 11 80       	push   $0x80114da0
80105735:	e8 96 ed ff ff       	call   801044d0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010573a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010573d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105740:	8b 1d e0 55 11 80    	mov    0x801155e0,%ebx
  while(ticks - ticks0 < n){
80105746:	85 d2                	test   %edx,%edx
80105748:	75 27                	jne    80105771 <sys_sleep+0x61>
8010574a:	eb 54                	jmp    801057a0 <sys_sleep+0x90>
8010574c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105750:	83 ec 08             	sub    $0x8,%esp
80105753:	68 a0 4d 11 80       	push   $0x80114da0
80105758:	68 e0 55 11 80       	push   $0x801155e0
8010575d:	e8 ae e7 ff ff       	call   80103f10 <sleep>
  while(ticks - ticks0 < n){
80105762:	a1 e0 55 11 80       	mov    0x801155e0,%eax
80105767:	83 c4 10             	add    $0x10,%esp
8010576a:	29 d8                	sub    %ebx,%eax
8010576c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010576f:	73 2f                	jae    801057a0 <sys_sleep+0x90>
    if(myproc()->killed){
80105771:	e8 fa e1 ff ff       	call   80103970 <myproc>
80105776:	8b 40 24             	mov    0x24(%eax),%eax
80105779:	85 c0                	test   %eax,%eax
8010577b:	74 d3                	je     80105750 <sys_sleep+0x40>
      release(&tickslock);
8010577d:	83 ec 0c             	sub    $0xc,%esp
80105780:	68 a0 4d 11 80       	push   $0x80114da0
80105785:	e8 06 ee ff ff       	call   80104590 <release>
      return -1;
8010578a:	83 c4 10             	add    $0x10,%esp
8010578d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105792:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105795:	c9                   	leave  
80105796:	c3                   	ret    
80105797:	89 f6                	mov    %esi,%esi
80105799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
801057a0:	83 ec 0c             	sub    $0xc,%esp
801057a3:	68 a0 4d 11 80       	push   $0x80114da0
801057a8:	e8 e3 ed ff ff       	call   80104590 <release>
  return 0;
801057ad:	83 c4 10             	add    $0x10,%esp
801057b0:	31 c0                	xor    %eax,%eax
}
801057b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057b5:	c9                   	leave  
801057b6:	c3                   	ret    
    return -1;
801057b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057bc:	eb f4                	jmp    801057b2 <sys_sleep+0xa2>
801057be:	66 90                	xchg   %ax,%ax

801057c0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	53                   	push   %ebx
801057c4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801057c7:	68 a0 4d 11 80       	push   $0x80114da0
801057cc:	e8 ff ec ff ff       	call   801044d0 <acquire>
  xticks = ticks;
801057d1:	8b 1d e0 55 11 80    	mov    0x801155e0,%ebx
  release(&tickslock);
801057d7:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801057de:	e8 ad ed ff ff       	call   80104590 <release>
  return xticks;
}
801057e3:	89 d8                	mov    %ebx,%eax
801057e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057e8:	c9                   	leave  
801057e9:	c3                   	ret    
801057ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801057f0 <sys_cpuhalt>:

//to halt or kill the virtual machine
int
sys_cpuhalt(void){
801057f0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801057f1:	b8 00 20 00 00       	mov    $0x2000,%eax
801057f6:	ba 04 06 00 00       	mov    $0x604,%edx
801057fb:	89 e5                	mov    %esp,%ebp
801057fd:	66 ef                	out    %ax,(%dx)
  //https://wiki.osdev.org/Shutdown
  outw(0x604, 0x2000);
  return 0;
}
801057ff:	31 c0                	xor    %eax,%eax
80105801:	5d                   	pop    %ebp
80105802:	c3                   	ret    

80105803 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105803:	1e                   	push   %ds
  pushl %es
80105804:	06                   	push   %es
  pushl %fs
80105805:	0f a0                	push   %fs
  pushl %gs
80105807:	0f a8                	push   %gs
  pushal
80105809:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010580a:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
8010580e:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105810:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105812:	54                   	push   %esp
  call trap
80105813:	e8 c8 00 00 00       	call   801058e0 <trap>
  addl $4, %esp
80105818:	83 c4 04             	add    $0x4,%esp

8010581b <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010581b:	61                   	popa   
  popl %gs
8010581c:	0f a9                	pop    %gs
  popl %fs
8010581e:	0f a1                	pop    %fs
  popl %es
80105820:	07                   	pop    %es
  popl %ds
80105821:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105822:	83 c4 08             	add    $0x8,%esp
  iret
80105825:	cf                   	iret   
80105826:	66 90                	xchg   %ax,%ax
80105828:	66 90                	xchg   %ax,%ax
8010582a:	66 90                	xchg   %ax,%ax
8010582c:	66 90                	xchg   %ax,%ax
8010582e:	66 90                	xchg   %ax,%ax

80105830 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105830:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105831:	31 c0                	xor    %eax,%eax
{
80105833:	89 e5                	mov    %esp,%ebp
80105835:	83 ec 08             	sub    $0x8,%esp
80105838:	90                   	nop
80105839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105840:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105847:	c7 04 c5 e2 4d 11 80 	movl   $0x8e000008,-0x7feeb21e(,%eax,8)
8010584e:	08 00 00 8e 
80105852:	66 89 14 c5 e0 4d 11 	mov    %dx,-0x7feeb220(,%eax,8)
80105859:	80 
8010585a:	c1 ea 10             	shr    $0x10,%edx
8010585d:	66 89 14 c5 e6 4d 11 	mov    %dx,-0x7feeb21a(,%eax,8)
80105864:	80 
  for(i = 0; i < 256; i++)
80105865:	83 c0 01             	add    $0x1,%eax
80105868:	3d 00 01 00 00       	cmp    $0x100,%eax
8010586d:	75 d1                	jne    80105840 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010586f:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105874:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105877:	c7 05 e2 4f 11 80 08 	movl   $0xef000008,0x80114fe2
8010587e:	00 00 ef 
  initlock(&tickslock, "time");
80105881:	68 41 78 10 80       	push   $0x80107841
80105886:	68 a0 4d 11 80       	push   $0x80114da0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010588b:	66 a3 e0 4f 11 80    	mov    %ax,0x80114fe0
80105891:	c1 e8 10             	shr    $0x10,%eax
80105894:	66 a3 e6 4f 11 80    	mov    %ax,0x80114fe6
  initlock(&tickslock, "time");
8010589a:	e8 f1 ea ff ff       	call   80104390 <initlock>
}
8010589f:	83 c4 10             	add    $0x10,%esp
801058a2:	c9                   	leave  
801058a3:	c3                   	ret    
801058a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801058aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801058b0 <idtinit>:

void
idtinit(void)
{
801058b0:	55                   	push   %ebp
  pd[0] = size-1;
801058b1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801058b6:	89 e5                	mov    %esp,%ebp
801058b8:	83 ec 10             	sub    $0x10,%esp
801058bb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801058bf:	b8 e0 4d 11 80       	mov    $0x80114de0,%eax
801058c4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801058c8:	c1 e8 10             	shr    $0x10,%eax
801058cb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801058cf:	8d 45 fa             	lea    -0x6(%ebp),%eax
801058d2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801058d5:	c9                   	leave  
801058d6:	c3                   	ret    
801058d7:	89 f6                	mov    %esi,%esi
801058d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058e0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	57                   	push   %edi
801058e4:	56                   	push   %esi
801058e5:	53                   	push   %ebx
801058e6:	83 ec 1c             	sub    $0x1c,%esp
801058e9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
801058ec:	8b 47 30             	mov    0x30(%edi),%eax
801058ef:	83 f8 40             	cmp    $0x40,%eax
801058f2:	0f 84 f0 00 00 00    	je     801059e8 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801058f8:	83 e8 20             	sub    $0x20,%eax
801058fb:	83 f8 1f             	cmp    $0x1f,%eax
801058fe:	77 10                	ja     80105910 <trap+0x30>
80105900:	ff 24 85 e8 78 10 80 	jmp    *-0x7fef8718(,%eax,4)
80105907:	89 f6                	mov    %esi,%esi
80105909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105910:	e8 5b e0 ff ff       	call   80103970 <myproc>
80105915:	85 c0                	test   %eax,%eax
80105917:	8b 5f 38             	mov    0x38(%edi),%ebx
8010591a:	0f 84 14 02 00 00    	je     80105b34 <trap+0x254>
80105920:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105924:	0f 84 0a 02 00 00    	je     80105b34 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010592a:	0f 20 d1             	mov    %cr2,%ecx
8010592d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105930:	e8 1b e0 ff ff       	call   80103950 <cpuid>
80105935:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105938:	8b 47 34             	mov    0x34(%edi),%eax
8010593b:	8b 77 30             	mov    0x30(%edi),%esi
8010593e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105941:	e8 2a e0 ff ff       	call   80103970 <myproc>
80105946:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105949:	e8 22 e0 ff ff       	call   80103970 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010594e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105951:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105954:	51                   	push   %ecx
80105955:	53                   	push   %ebx
80105956:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105957:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010595a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010595d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010595e:	83 c2 70             	add    $0x70,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105961:	52                   	push   %edx
80105962:	ff 70 10             	pushl  0x10(%eax)
80105965:	68 a4 78 10 80       	push   $0x801078a4
8010596a:	e8 c1 ad ff ff       	call   80100730 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010596f:	83 c4 20             	add    $0x20,%esp
80105972:	e8 f9 df ff ff       	call   80103970 <myproc>
80105977:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010597e:	e8 ed df ff ff       	call   80103970 <myproc>
80105983:	85 c0                	test   %eax,%eax
80105985:	74 1d                	je     801059a4 <trap+0xc4>
80105987:	e8 e4 df ff ff       	call   80103970 <myproc>
8010598c:	8b 50 24             	mov    0x24(%eax),%edx
8010598f:	85 d2                	test   %edx,%edx
80105991:	74 11                	je     801059a4 <trap+0xc4>
80105993:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105997:	83 e0 03             	and    $0x3,%eax
8010599a:	66 83 f8 03          	cmp    $0x3,%ax
8010599e:	0f 84 4c 01 00 00    	je     80105af0 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801059a4:	e8 c7 df ff ff       	call   80103970 <myproc>
801059a9:	85 c0                	test   %eax,%eax
801059ab:	74 0b                	je     801059b8 <trap+0xd8>
801059ad:	e8 be df ff ff       	call   80103970 <myproc>
801059b2:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801059b6:	74 68                	je     80105a20 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801059b8:	e8 b3 df ff ff       	call   80103970 <myproc>
801059bd:	85 c0                	test   %eax,%eax
801059bf:	74 19                	je     801059da <trap+0xfa>
801059c1:	e8 aa df ff ff       	call   80103970 <myproc>
801059c6:	8b 40 24             	mov    0x24(%eax),%eax
801059c9:	85 c0                	test   %eax,%eax
801059cb:	74 0d                	je     801059da <trap+0xfa>
801059cd:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801059d1:	83 e0 03             	and    $0x3,%eax
801059d4:	66 83 f8 03          	cmp    $0x3,%ax
801059d8:	74 37                	je     80105a11 <trap+0x131>
    exit();
}
801059da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059dd:	5b                   	pop    %ebx
801059de:	5e                   	pop    %esi
801059df:	5f                   	pop    %edi
801059e0:	5d                   	pop    %ebp
801059e1:	c3                   	ret    
801059e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
801059e8:	e8 83 df ff ff       	call   80103970 <myproc>
801059ed:	8b 58 24             	mov    0x24(%eax),%ebx
801059f0:	85 db                	test   %ebx,%ebx
801059f2:	0f 85 e8 00 00 00    	jne    80105ae0 <trap+0x200>
    myproc()->tf = tf;
801059f8:	e8 73 df ff ff       	call   80103970 <myproc>
801059fd:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105a00:	e8 cb ef ff ff       	call   801049d0 <syscall>
    if(myproc()->killed)
80105a05:	e8 66 df ff ff       	call   80103970 <myproc>
80105a0a:	8b 48 24             	mov    0x24(%eax),%ecx
80105a0d:	85 c9                	test   %ecx,%ecx
80105a0f:	74 c9                	je     801059da <trap+0xfa>
}
80105a11:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a14:	5b                   	pop    %ebx
80105a15:	5e                   	pop    %esi
80105a16:	5f                   	pop    %edi
80105a17:	5d                   	pop    %ebp
      exit();
80105a18:	e9 73 e3 ff ff       	jmp    80103d90 <exit>
80105a1d:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105a20:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105a24:	75 92                	jne    801059b8 <trap+0xd8>
    yield();
80105a26:	e8 95 e4 ff ff       	call   80103ec0 <yield>
80105a2b:	eb 8b                	jmp    801059b8 <trap+0xd8>
80105a2d:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80105a30:	e8 1b df ff ff       	call   80103950 <cpuid>
80105a35:	85 c0                	test   %eax,%eax
80105a37:	0f 84 c3 00 00 00    	je     80105b00 <trap+0x220>
    lapiceoi();
80105a3d:	e8 9e ce ff ff       	call   801028e0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a42:	e8 29 df ff ff       	call   80103970 <myproc>
80105a47:	85 c0                	test   %eax,%eax
80105a49:	0f 85 38 ff ff ff    	jne    80105987 <trap+0xa7>
80105a4f:	e9 50 ff ff ff       	jmp    801059a4 <trap+0xc4>
80105a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105a58:	e8 43 cd ff ff       	call   801027a0 <kbdintr>
    lapiceoi();
80105a5d:	e8 7e ce ff ff       	call   801028e0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a62:	e8 09 df ff ff       	call   80103970 <myproc>
80105a67:	85 c0                	test   %eax,%eax
80105a69:	0f 85 18 ff ff ff    	jne    80105987 <trap+0xa7>
80105a6f:	e9 30 ff ff ff       	jmp    801059a4 <trap+0xc4>
80105a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105a78:	e8 53 02 00 00       	call   80105cd0 <uartintr>
    lapiceoi();
80105a7d:	e8 5e ce ff ff       	call   801028e0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a82:	e8 e9 de ff ff       	call   80103970 <myproc>
80105a87:	85 c0                	test   %eax,%eax
80105a89:	0f 85 f8 fe ff ff    	jne    80105987 <trap+0xa7>
80105a8f:	e9 10 ff ff ff       	jmp    801059a4 <trap+0xc4>
80105a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105a98:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105a9c:	8b 77 38             	mov    0x38(%edi),%esi
80105a9f:	e8 ac de ff ff       	call   80103950 <cpuid>
80105aa4:	56                   	push   %esi
80105aa5:	53                   	push   %ebx
80105aa6:	50                   	push   %eax
80105aa7:	68 4c 78 10 80       	push   $0x8010784c
80105aac:	e8 7f ac ff ff       	call   80100730 <cprintf>
    lapiceoi();
80105ab1:	e8 2a ce ff ff       	call   801028e0 <lapiceoi>
    break;
80105ab6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ab9:	e8 b2 de ff ff       	call   80103970 <myproc>
80105abe:	85 c0                	test   %eax,%eax
80105ac0:	0f 85 c1 fe ff ff    	jne    80105987 <trap+0xa7>
80105ac6:	e9 d9 fe ff ff       	jmp    801059a4 <trap+0xc4>
80105acb:	90                   	nop
80105acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105ad0:	e8 3b c7 ff ff       	call   80102210 <ideintr>
80105ad5:	e9 63 ff ff ff       	jmp    80105a3d <trap+0x15d>
80105ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105ae0:	e8 ab e2 ff ff       	call   80103d90 <exit>
80105ae5:	e9 0e ff ff ff       	jmp    801059f8 <trap+0x118>
80105aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80105af0:	e8 9b e2 ff ff       	call   80103d90 <exit>
80105af5:	e9 aa fe ff ff       	jmp    801059a4 <trap+0xc4>
80105afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105b00:	83 ec 0c             	sub    $0xc,%esp
80105b03:	68 a0 4d 11 80       	push   $0x80114da0
80105b08:	e8 c3 e9 ff ff       	call   801044d0 <acquire>
      wakeup(&ticks);
80105b0d:	c7 04 24 e0 55 11 80 	movl   $0x801155e0,(%esp)
      ticks++;
80105b14:	83 05 e0 55 11 80 01 	addl   $0x1,0x801155e0
      wakeup(&ticks);
80105b1b:	e8 a0 e5 ff ff       	call   801040c0 <wakeup>
      release(&tickslock);
80105b20:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80105b27:	e8 64 ea ff ff       	call   80104590 <release>
80105b2c:	83 c4 10             	add    $0x10,%esp
80105b2f:	e9 09 ff ff ff       	jmp    80105a3d <trap+0x15d>
80105b34:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105b37:	e8 14 de ff ff       	call   80103950 <cpuid>
80105b3c:	83 ec 0c             	sub    $0xc,%esp
80105b3f:	56                   	push   %esi
80105b40:	53                   	push   %ebx
80105b41:	50                   	push   %eax
80105b42:	ff 77 30             	pushl  0x30(%edi)
80105b45:	68 70 78 10 80       	push   $0x80107870
80105b4a:	e8 e1 ab ff ff       	call   80100730 <cprintf>
      panic("trap");
80105b4f:	83 c4 14             	add    $0x14,%esp
80105b52:	68 46 78 10 80       	push   $0x80107846
80105b57:	e8 04 a9 ff ff       	call   80100460 <panic>
80105b5c:	66 90                	xchg   %ax,%ax
80105b5e:	66 90                	xchg   %ax,%ax

80105b60 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105b60:	a1 dc a5 10 80       	mov    0x8010a5dc,%eax
{
80105b65:	55                   	push   %ebp
80105b66:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105b68:	85 c0                	test   %eax,%eax
80105b6a:	74 1c                	je     80105b88 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105b6c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105b71:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105b72:	a8 01                	test   $0x1,%al
80105b74:	74 12                	je     80105b88 <uartgetc+0x28>
80105b76:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105b7b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105b7c:	0f b6 c0             	movzbl %al,%eax
}
80105b7f:	5d                   	pop    %ebp
80105b80:	c3                   	ret    
80105b81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105b88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b8d:	5d                   	pop    %ebp
80105b8e:	c3                   	ret    
80105b8f:	90                   	nop

80105b90 <uartputc.part.0>:
uartputc(int c)
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	57                   	push   %edi
80105b94:	56                   	push   %esi
80105b95:	53                   	push   %ebx
80105b96:	89 c7                	mov    %eax,%edi
80105b98:	bb 80 00 00 00       	mov    $0x80,%ebx
80105b9d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105ba2:	83 ec 0c             	sub    $0xc,%esp
80105ba5:	eb 1b                	jmp    80105bc2 <uartputc.part.0+0x32>
80105ba7:	89 f6                	mov    %esi,%esi
80105ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105bb0:	83 ec 0c             	sub    $0xc,%esp
80105bb3:	6a 0a                	push   $0xa
80105bb5:	e8 46 cd ff ff       	call   80102900 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105bba:	83 c4 10             	add    $0x10,%esp
80105bbd:	83 eb 01             	sub    $0x1,%ebx
80105bc0:	74 07                	je     80105bc9 <uartputc.part.0+0x39>
80105bc2:	89 f2                	mov    %esi,%edx
80105bc4:	ec                   	in     (%dx),%al
80105bc5:	a8 20                	test   $0x20,%al
80105bc7:	74 e7                	je     80105bb0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105bc9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105bce:	89 f8                	mov    %edi,%eax
80105bd0:	ee                   	out    %al,(%dx)
}
80105bd1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bd4:	5b                   	pop    %ebx
80105bd5:	5e                   	pop    %esi
80105bd6:	5f                   	pop    %edi
80105bd7:	5d                   	pop    %ebp
80105bd8:	c3                   	ret    
80105bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105be0 <uartinit>:
{
80105be0:	55                   	push   %ebp
80105be1:	31 c9                	xor    %ecx,%ecx
80105be3:	89 c8                	mov    %ecx,%eax
80105be5:	89 e5                	mov    %esp,%ebp
80105be7:	57                   	push   %edi
80105be8:	56                   	push   %esi
80105be9:	53                   	push   %ebx
80105bea:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105bef:	89 da                	mov    %ebx,%edx
80105bf1:	83 ec 0c             	sub    $0xc,%esp
80105bf4:	ee                   	out    %al,(%dx)
80105bf5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105bfa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105bff:	89 fa                	mov    %edi,%edx
80105c01:	ee                   	out    %al,(%dx)
80105c02:	b8 0c 00 00 00       	mov    $0xc,%eax
80105c07:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c0c:	ee                   	out    %al,(%dx)
80105c0d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105c12:	89 c8                	mov    %ecx,%eax
80105c14:	89 f2                	mov    %esi,%edx
80105c16:	ee                   	out    %al,(%dx)
80105c17:	b8 03 00 00 00       	mov    $0x3,%eax
80105c1c:	89 fa                	mov    %edi,%edx
80105c1e:	ee                   	out    %al,(%dx)
80105c1f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105c24:	89 c8                	mov    %ecx,%eax
80105c26:	ee                   	out    %al,(%dx)
80105c27:	b8 01 00 00 00       	mov    $0x1,%eax
80105c2c:	89 f2                	mov    %esi,%edx
80105c2e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c2f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c34:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105c35:	3c ff                	cmp    $0xff,%al
80105c37:	74 5a                	je     80105c93 <uartinit+0xb3>
  uart = 1;
80105c39:	c7 05 dc a5 10 80 01 	movl   $0x1,0x8010a5dc
80105c40:	00 00 00 
80105c43:	89 da                	mov    %ebx,%edx
80105c45:	ec                   	in     (%dx),%al
80105c46:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c4b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105c4c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105c4f:	bb 68 79 10 80       	mov    $0x80107968,%ebx
  ioapicenable(IRQ_COM1, 0);
80105c54:	6a 00                	push   $0x0
80105c56:	6a 04                	push   $0x4
80105c58:	e8 03 c8 ff ff       	call   80102460 <ioapicenable>
80105c5d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105c60:	b8 78 00 00 00       	mov    $0x78,%eax
80105c65:	eb 13                	jmp    80105c7a <uartinit+0x9a>
80105c67:	89 f6                	mov    %esi,%esi
80105c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105c70:	83 c3 01             	add    $0x1,%ebx
80105c73:	0f be 03             	movsbl (%ebx),%eax
80105c76:	84 c0                	test   %al,%al
80105c78:	74 19                	je     80105c93 <uartinit+0xb3>
  if(!uart)
80105c7a:	8b 15 dc a5 10 80    	mov    0x8010a5dc,%edx
80105c80:	85 d2                	test   %edx,%edx
80105c82:	74 ec                	je     80105c70 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105c84:	83 c3 01             	add    $0x1,%ebx
80105c87:	e8 04 ff ff ff       	call   80105b90 <uartputc.part.0>
80105c8c:	0f be 03             	movsbl (%ebx),%eax
80105c8f:	84 c0                	test   %al,%al
80105c91:	75 e7                	jne    80105c7a <uartinit+0x9a>
}
80105c93:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c96:	5b                   	pop    %ebx
80105c97:	5e                   	pop    %esi
80105c98:	5f                   	pop    %edi
80105c99:	5d                   	pop    %ebp
80105c9a:	c3                   	ret    
80105c9b:	90                   	nop
80105c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ca0 <uartputc>:
  if(!uart)
80105ca0:	8b 15 dc a5 10 80    	mov    0x8010a5dc,%edx
{
80105ca6:	55                   	push   %ebp
80105ca7:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105ca9:	85 d2                	test   %edx,%edx
{
80105cab:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105cae:	74 10                	je     80105cc0 <uartputc+0x20>
}
80105cb0:	5d                   	pop    %ebp
80105cb1:	e9 da fe ff ff       	jmp    80105b90 <uartputc.part.0>
80105cb6:	8d 76 00             	lea    0x0(%esi),%esi
80105cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105cc0:	5d                   	pop    %ebp
80105cc1:	c3                   	ret    
80105cc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105cd0 <uartintr>:

void
uartintr(void)
{
80105cd0:	55                   	push   %ebp
80105cd1:	89 e5                	mov    %esp,%ebp
80105cd3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105cd6:	68 60 5b 10 80       	push   $0x80105b60
80105cdb:	e8 00 ac ff ff       	call   801008e0 <consoleintr>
}
80105ce0:	83 c4 10             	add    $0x10,%esp
80105ce3:	c9                   	leave  
80105ce4:	c3                   	ret    

80105ce5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105ce5:	6a 00                	push   $0x0
  pushl $0
80105ce7:	6a 00                	push   $0x0
  jmp alltraps
80105ce9:	e9 15 fb ff ff       	jmp    80105803 <alltraps>

80105cee <vector1>:
.globl vector1
vector1:
  pushl $0
80105cee:	6a 00                	push   $0x0
  pushl $1
80105cf0:	6a 01                	push   $0x1
  jmp alltraps
80105cf2:	e9 0c fb ff ff       	jmp    80105803 <alltraps>

80105cf7 <vector2>:
.globl vector2
vector2:
  pushl $0
80105cf7:	6a 00                	push   $0x0
  pushl $2
80105cf9:	6a 02                	push   $0x2
  jmp alltraps
80105cfb:	e9 03 fb ff ff       	jmp    80105803 <alltraps>

80105d00 <vector3>:
.globl vector3
vector3:
  pushl $0
80105d00:	6a 00                	push   $0x0
  pushl $3
80105d02:	6a 03                	push   $0x3
  jmp alltraps
80105d04:	e9 fa fa ff ff       	jmp    80105803 <alltraps>

80105d09 <vector4>:
.globl vector4
vector4:
  pushl $0
80105d09:	6a 00                	push   $0x0
  pushl $4
80105d0b:	6a 04                	push   $0x4
  jmp alltraps
80105d0d:	e9 f1 fa ff ff       	jmp    80105803 <alltraps>

80105d12 <vector5>:
.globl vector5
vector5:
  pushl $0
80105d12:	6a 00                	push   $0x0
  pushl $5
80105d14:	6a 05                	push   $0x5
  jmp alltraps
80105d16:	e9 e8 fa ff ff       	jmp    80105803 <alltraps>

80105d1b <vector6>:
.globl vector6
vector6:
  pushl $0
80105d1b:	6a 00                	push   $0x0
  pushl $6
80105d1d:	6a 06                	push   $0x6
  jmp alltraps
80105d1f:	e9 df fa ff ff       	jmp    80105803 <alltraps>

80105d24 <vector7>:
.globl vector7
vector7:
  pushl $0
80105d24:	6a 00                	push   $0x0
  pushl $7
80105d26:	6a 07                	push   $0x7
  jmp alltraps
80105d28:	e9 d6 fa ff ff       	jmp    80105803 <alltraps>

80105d2d <vector8>:
.globl vector8
vector8:
  pushl $8
80105d2d:	6a 08                	push   $0x8
  jmp alltraps
80105d2f:	e9 cf fa ff ff       	jmp    80105803 <alltraps>

80105d34 <vector9>:
.globl vector9
vector9:
  pushl $0
80105d34:	6a 00                	push   $0x0
  pushl $9
80105d36:	6a 09                	push   $0x9
  jmp alltraps
80105d38:	e9 c6 fa ff ff       	jmp    80105803 <alltraps>

80105d3d <vector10>:
.globl vector10
vector10:
  pushl $10
80105d3d:	6a 0a                	push   $0xa
  jmp alltraps
80105d3f:	e9 bf fa ff ff       	jmp    80105803 <alltraps>

80105d44 <vector11>:
.globl vector11
vector11:
  pushl $11
80105d44:	6a 0b                	push   $0xb
  jmp alltraps
80105d46:	e9 b8 fa ff ff       	jmp    80105803 <alltraps>

80105d4b <vector12>:
.globl vector12
vector12:
  pushl $12
80105d4b:	6a 0c                	push   $0xc
  jmp alltraps
80105d4d:	e9 b1 fa ff ff       	jmp    80105803 <alltraps>

80105d52 <vector13>:
.globl vector13
vector13:
  pushl $13
80105d52:	6a 0d                	push   $0xd
  jmp alltraps
80105d54:	e9 aa fa ff ff       	jmp    80105803 <alltraps>

80105d59 <vector14>:
.globl vector14
vector14:
  pushl $14
80105d59:	6a 0e                	push   $0xe
  jmp alltraps
80105d5b:	e9 a3 fa ff ff       	jmp    80105803 <alltraps>

80105d60 <vector15>:
.globl vector15
vector15:
  pushl $0
80105d60:	6a 00                	push   $0x0
  pushl $15
80105d62:	6a 0f                	push   $0xf
  jmp alltraps
80105d64:	e9 9a fa ff ff       	jmp    80105803 <alltraps>

80105d69 <vector16>:
.globl vector16
vector16:
  pushl $0
80105d69:	6a 00                	push   $0x0
  pushl $16
80105d6b:	6a 10                	push   $0x10
  jmp alltraps
80105d6d:	e9 91 fa ff ff       	jmp    80105803 <alltraps>

80105d72 <vector17>:
.globl vector17
vector17:
  pushl $17
80105d72:	6a 11                	push   $0x11
  jmp alltraps
80105d74:	e9 8a fa ff ff       	jmp    80105803 <alltraps>

80105d79 <vector18>:
.globl vector18
vector18:
  pushl $0
80105d79:	6a 00                	push   $0x0
  pushl $18
80105d7b:	6a 12                	push   $0x12
  jmp alltraps
80105d7d:	e9 81 fa ff ff       	jmp    80105803 <alltraps>

80105d82 <vector19>:
.globl vector19
vector19:
  pushl $0
80105d82:	6a 00                	push   $0x0
  pushl $19
80105d84:	6a 13                	push   $0x13
  jmp alltraps
80105d86:	e9 78 fa ff ff       	jmp    80105803 <alltraps>

80105d8b <vector20>:
.globl vector20
vector20:
  pushl $0
80105d8b:	6a 00                	push   $0x0
  pushl $20
80105d8d:	6a 14                	push   $0x14
  jmp alltraps
80105d8f:	e9 6f fa ff ff       	jmp    80105803 <alltraps>

80105d94 <vector21>:
.globl vector21
vector21:
  pushl $0
80105d94:	6a 00                	push   $0x0
  pushl $21
80105d96:	6a 15                	push   $0x15
  jmp alltraps
80105d98:	e9 66 fa ff ff       	jmp    80105803 <alltraps>

80105d9d <vector22>:
.globl vector22
vector22:
  pushl $0
80105d9d:	6a 00                	push   $0x0
  pushl $22
80105d9f:	6a 16                	push   $0x16
  jmp alltraps
80105da1:	e9 5d fa ff ff       	jmp    80105803 <alltraps>

80105da6 <vector23>:
.globl vector23
vector23:
  pushl $0
80105da6:	6a 00                	push   $0x0
  pushl $23
80105da8:	6a 17                	push   $0x17
  jmp alltraps
80105daa:	e9 54 fa ff ff       	jmp    80105803 <alltraps>

80105daf <vector24>:
.globl vector24
vector24:
  pushl $0
80105daf:	6a 00                	push   $0x0
  pushl $24
80105db1:	6a 18                	push   $0x18
  jmp alltraps
80105db3:	e9 4b fa ff ff       	jmp    80105803 <alltraps>

80105db8 <vector25>:
.globl vector25
vector25:
  pushl $0
80105db8:	6a 00                	push   $0x0
  pushl $25
80105dba:	6a 19                	push   $0x19
  jmp alltraps
80105dbc:	e9 42 fa ff ff       	jmp    80105803 <alltraps>

80105dc1 <vector26>:
.globl vector26
vector26:
  pushl $0
80105dc1:	6a 00                	push   $0x0
  pushl $26
80105dc3:	6a 1a                	push   $0x1a
  jmp alltraps
80105dc5:	e9 39 fa ff ff       	jmp    80105803 <alltraps>

80105dca <vector27>:
.globl vector27
vector27:
  pushl $0
80105dca:	6a 00                	push   $0x0
  pushl $27
80105dcc:	6a 1b                	push   $0x1b
  jmp alltraps
80105dce:	e9 30 fa ff ff       	jmp    80105803 <alltraps>

80105dd3 <vector28>:
.globl vector28
vector28:
  pushl $0
80105dd3:	6a 00                	push   $0x0
  pushl $28
80105dd5:	6a 1c                	push   $0x1c
  jmp alltraps
80105dd7:	e9 27 fa ff ff       	jmp    80105803 <alltraps>

80105ddc <vector29>:
.globl vector29
vector29:
  pushl $0
80105ddc:	6a 00                	push   $0x0
  pushl $29
80105dde:	6a 1d                	push   $0x1d
  jmp alltraps
80105de0:	e9 1e fa ff ff       	jmp    80105803 <alltraps>

80105de5 <vector30>:
.globl vector30
vector30:
  pushl $0
80105de5:	6a 00                	push   $0x0
  pushl $30
80105de7:	6a 1e                	push   $0x1e
  jmp alltraps
80105de9:	e9 15 fa ff ff       	jmp    80105803 <alltraps>

80105dee <vector31>:
.globl vector31
vector31:
  pushl $0
80105dee:	6a 00                	push   $0x0
  pushl $31
80105df0:	6a 1f                	push   $0x1f
  jmp alltraps
80105df2:	e9 0c fa ff ff       	jmp    80105803 <alltraps>

80105df7 <vector32>:
.globl vector32
vector32:
  pushl $0
80105df7:	6a 00                	push   $0x0
  pushl $32
80105df9:	6a 20                	push   $0x20
  jmp alltraps
80105dfb:	e9 03 fa ff ff       	jmp    80105803 <alltraps>

80105e00 <vector33>:
.globl vector33
vector33:
  pushl $0
80105e00:	6a 00                	push   $0x0
  pushl $33
80105e02:	6a 21                	push   $0x21
  jmp alltraps
80105e04:	e9 fa f9 ff ff       	jmp    80105803 <alltraps>

80105e09 <vector34>:
.globl vector34
vector34:
  pushl $0
80105e09:	6a 00                	push   $0x0
  pushl $34
80105e0b:	6a 22                	push   $0x22
  jmp alltraps
80105e0d:	e9 f1 f9 ff ff       	jmp    80105803 <alltraps>

80105e12 <vector35>:
.globl vector35
vector35:
  pushl $0
80105e12:	6a 00                	push   $0x0
  pushl $35
80105e14:	6a 23                	push   $0x23
  jmp alltraps
80105e16:	e9 e8 f9 ff ff       	jmp    80105803 <alltraps>

80105e1b <vector36>:
.globl vector36
vector36:
  pushl $0
80105e1b:	6a 00                	push   $0x0
  pushl $36
80105e1d:	6a 24                	push   $0x24
  jmp alltraps
80105e1f:	e9 df f9 ff ff       	jmp    80105803 <alltraps>

80105e24 <vector37>:
.globl vector37
vector37:
  pushl $0
80105e24:	6a 00                	push   $0x0
  pushl $37
80105e26:	6a 25                	push   $0x25
  jmp alltraps
80105e28:	e9 d6 f9 ff ff       	jmp    80105803 <alltraps>

80105e2d <vector38>:
.globl vector38
vector38:
  pushl $0
80105e2d:	6a 00                	push   $0x0
  pushl $38
80105e2f:	6a 26                	push   $0x26
  jmp alltraps
80105e31:	e9 cd f9 ff ff       	jmp    80105803 <alltraps>

80105e36 <vector39>:
.globl vector39
vector39:
  pushl $0
80105e36:	6a 00                	push   $0x0
  pushl $39
80105e38:	6a 27                	push   $0x27
  jmp alltraps
80105e3a:	e9 c4 f9 ff ff       	jmp    80105803 <alltraps>

80105e3f <vector40>:
.globl vector40
vector40:
  pushl $0
80105e3f:	6a 00                	push   $0x0
  pushl $40
80105e41:	6a 28                	push   $0x28
  jmp alltraps
80105e43:	e9 bb f9 ff ff       	jmp    80105803 <alltraps>

80105e48 <vector41>:
.globl vector41
vector41:
  pushl $0
80105e48:	6a 00                	push   $0x0
  pushl $41
80105e4a:	6a 29                	push   $0x29
  jmp alltraps
80105e4c:	e9 b2 f9 ff ff       	jmp    80105803 <alltraps>

80105e51 <vector42>:
.globl vector42
vector42:
  pushl $0
80105e51:	6a 00                	push   $0x0
  pushl $42
80105e53:	6a 2a                	push   $0x2a
  jmp alltraps
80105e55:	e9 a9 f9 ff ff       	jmp    80105803 <alltraps>

80105e5a <vector43>:
.globl vector43
vector43:
  pushl $0
80105e5a:	6a 00                	push   $0x0
  pushl $43
80105e5c:	6a 2b                	push   $0x2b
  jmp alltraps
80105e5e:	e9 a0 f9 ff ff       	jmp    80105803 <alltraps>

80105e63 <vector44>:
.globl vector44
vector44:
  pushl $0
80105e63:	6a 00                	push   $0x0
  pushl $44
80105e65:	6a 2c                	push   $0x2c
  jmp alltraps
80105e67:	e9 97 f9 ff ff       	jmp    80105803 <alltraps>

80105e6c <vector45>:
.globl vector45
vector45:
  pushl $0
80105e6c:	6a 00                	push   $0x0
  pushl $45
80105e6e:	6a 2d                	push   $0x2d
  jmp alltraps
80105e70:	e9 8e f9 ff ff       	jmp    80105803 <alltraps>

80105e75 <vector46>:
.globl vector46
vector46:
  pushl $0
80105e75:	6a 00                	push   $0x0
  pushl $46
80105e77:	6a 2e                	push   $0x2e
  jmp alltraps
80105e79:	e9 85 f9 ff ff       	jmp    80105803 <alltraps>

80105e7e <vector47>:
.globl vector47
vector47:
  pushl $0
80105e7e:	6a 00                	push   $0x0
  pushl $47
80105e80:	6a 2f                	push   $0x2f
  jmp alltraps
80105e82:	e9 7c f9 ff ff       	jmp    80105803 <alltraps>

80105e87 <vector48>:
.globl vector48
vector48:
  pushl $0
80105e87:	6a 00                	push   $0x0
  pushl $48
80105e89:	6a 30                	push   $0x30
  jmp alltraps
80105e8b:	e9 73 f9 ff ff       	jmp    80105803 <alltraps>

80105e90 <vector49>:
.globl vector49
vector49:
  pushl $0
80105e90:	6a 00                	push   $0x0
  pushl $49
80105e92:	6a 31                	push   $0x31
  jmp alltraps
80105e94:	e9 6a f9 ff ff       	jmp    80105803 <alltraps>

80105e99 <vector50>:
.globl vector50
vector50:
  pushl $0
80105e99:	6a 00                	push   $0x0
  pushl $50
80105e9b:	6a 32                	push   $0x32
  jmp alltraps
80105e9d:	e9 61 f9 ff ff       	jmp    80105803 <alltraps>

80105ea2 <vector51>:
.globl vector51
vector51:
  pushl $0
80105ea2:	6a 00                	push   $0x0
  pushl $51
80105ea4:	6a 33                	push   $0x33
  jmp alltraps
80105ea6:	e9 58 f9 ff ff       	jmp    80105803 <alltraps>

80105eab <vector52>:
.globl vector52
vector52:
  pushl $0
80105eab:	6a 00                	push   $0x0
  pushl $52
80105ead:	6a 34                	push   $0x34
  jmp alltraps
80105eaf:	e9 4f f9 ff ff       	jmp    80105803 <alltraps>

80105eb4 <vector53>:
.globl vector53
vector53:
  pushl $0
80105eb4:	6a 00                	push   $0x0
  pushl $53
80105eb6:	6a 35                	push   $0x35
  jmp alltraps
80105eb8:	e9 46 f9 ff ff       	jmp    80105803 <alltraps>

80105ebd <vector54>:
.globl vector54
vector54:
  pushl $0
80105ebd:	6a 00                	push   $0x0
  pushl $54
80105ebf:	6a 36                	push   $0x36
  jmp alltraps
80105ec1:	e9 3d f9 ff ff       	jmp    80105803 <alltraps>

80105ec6 <vector55>:
.globl vector55
vector55:
  pushl $0
80105ec6:	6a 00                	push   $0x0
  pushl $55
80105ec8:	6a 37                	push   $0x37
  jmp alltraps
80105eca:	e9 34 f9 ff ff       	jmp    80105803 <alltraps>

80105ecf <vector56>:
.globl vector56
vector56:
  pushl $0
80105ecf:	6a 00                	push   $0x0
  pushl $56
80105ed1:	6a 38                	push   $0x38
  jmp alltraps
80105ed3:	e9 2b f9 ff ff       	jmp    80105803 <alltraps>

80105ed8 <vector57>:
.globl vector57
vector57:
  pushl $0
80105ed8:	6a 00                	push   $0x0
  pushl $57
80105eda:	6a 39                	push   $0x39
  jmp alltraps
80105edc:	e9 22 f9 ff ff       	jmp    80105803 <alltraps>

80105ee1 <vector58>:
.globl vector58
vector58:
  pushl $0
80105ee1:	6a 00                	push   $0x0
  pushl $58
80105ee3:	6a 3a                	push   $0x3a
  jmp alltraps
80105ee5:	e9 19 f9 ff ff       	jmp    80105803 <alltraps>

80105eea <vector59>:
.globl vector59
vector59:
  pushl $0
80105eea:	6a 00                	push   $0x0
  pushl $59
80105eec:	6a 3b                	push   $0x3b
  jmp alltraps
80105eee:	e9 10 f9 ff ff       	jmp    80105803 <alltraps>

80105ef3 <vector60>:
.globl vector60
vector60:
  pushl $0
80105ef3:	6a 00                	push   $0x0
  pushl $60
80105ef5:	6a 3c                	push   $0x3c
  jmp alltraps
80105ef7:	e9 07 f9 ff ff       	jmp    80105803 <alltraps>

80105efc <vector61>:
.globl vector61
vector61:
  pushl $0
80105efc:	6a 00                	push   $0x0
  pushl $61
80105efe:	6a 3d                	push   $0x3d
  jmp alltraps
80105f00:	e9 fe f8 ff ff       	jmp    80105803 <alltraps>

80105f05 <vector62>:
.globl vector62
vector62:
  pushl $0
80105f05:	6a 00                	push   $0x0
  pushl $62
80105f07:	6a 3e                	push   $0x3e
  jmp alltraps
80105f09:	e9 f5 f8 ff ff       	jmp    80105803 <alltraps>

80105f0e <vector63>:
.globl vector63
vector63:
  pushl $0
80105f0e:	6a 00                	push   $0x0
  pushl $63
80105f10:	6a 3f                	push   $0x3f
  jmp alltraps
80105f12:	e9 ec f8 ff ff       	jmp    80105803 <alltraps>

80105f17 <vector64>:
.globl vector64
vector64:
  pushl $0
80105f17:	6a 00                	push   $0x0
  pushl $64
80105f19:	6a 40                	push   $0x40
  jmp alltraps
80105f1b:	e9 e3 f8 ff ff       	jmp    80105803 <alltraps>

80105f20 <vector65>:
.globl vector65
vector65:
  pushl $0
80105f20:	6a 00                	push   $0x0
  pushl $65
80105f22:	6a 41                	push   $0x41
  jmp alltraps
80105f24:	e9 da f8 ff ff       	jmp    80105803 <alltraps>

80105f29 <vector66>:
.globl vector66
vector66:
  pushl $0
80105f29:	6a 00                	push   $0x0
  pushl $66
80105f2b:	6a 42                	push   $0x42
  jmp alltraps
80105f2d:	e9 d1 f8 ff ff       	jmp    80105803 <alltraps>

80105f32 <vector67>:
.globl vector67
vector67:
  pushl $0
80105f32:	6a 00                	push   $0x0
  pushl $67
80105f34:	6a 43                	push   $0x43
  jmp alltraps
80105f36:	e9 c8 f8 ff ff       	jmp    80105803 <alltraps>

80105f3b <vector68>:
.globl vector68
vector68:
  pushl $0
80105f3b:	6a 00                	push   $0x0
  pushl $68
80105f3d:	6a 44                	push   $0x44
  jmp alltraps
80105f3f:	e9 bf f8 ff ff       	jmp    80105803 <alltraps>

80105f44 <vector69>:
.globl vector69
vector69:
  pushl $0
80105f44:	6a 00                	push   $0x0
  pushl $69
80105f46:	6a 45                	push   $0x45
  jmp alltraps
80105f48:	e9 b6 f8 ff ff       	jmp    80105803 <alltraps>

80105f4d <vector70>:
.globl vector70
vector70:
  pushl $0
80105f4d:	6a 00                	push   $0x0
  pushl $70
80105f4f:	6a 46                	push   $0x46
  jmp alltraps
80105f51:	e9 ad f8 ff ff       	jmp    80105803 <alltraps>

80105f56 <vector71>:
.globl vector71
vector71:
  pushl $0
80105f56:	6a 00                	push   $0x0
  pushl $71
80105f58:	6a 47                	push   $0x47
  jmp alltraps
80105f5a:	e9 a4 f8 ff ff       	jmp    80105803 <alltraps>

80105f5f <vector72>:
.globl vector72
vector72:
  pushl $0
80105f5f:	6a 00                	push   $0x0
  pushl $72
80105f61:	6a 48                	push   $0x48
  jmp alltraps
80105f63:	e9 9b f8 ff ff       	jmp    80105803 <alltraps>

80105f68 <vector73>:
.globl vector73
vector73:
  pushl $0
80105f68:	6a 00                	push   $0x0
  pushl $73
80105f6a:	6a 49                	push   $0x49
  jmp alltraps
80105f6c:	e9 92 f8 ff ff       	jmp    80105803 <alltraps>

80105f71 <vector74>:
.globl vector74
vector74:
  pushl $0
80105f71:	6a 00                	push   $0x0
  pushl $74
80105f73:	6a 4a                	push   $0x4a
  jmp alltraps
80105f75:	e9 89 f8 ff ff       	jmp    80105803 <alltraps>

80105f7a <vector75>:
.globl vector75
vector75:
  pushl $0
80105f7a:	6a 00                	push   $0x0
  pushl $75
80105f7c:	6a 4b                	push   $0x4b
  jmp alltraps
80105f7e:	e9 80 f8 ff ff       	jmp    80105803 <alltraps>

80105f83 <vector76>:
.globl vector76
vector76:
  pushl $0
80105f83:	6a 00                	push   $0x0
  pushl $76
80105f85:	6a 4c                	push   $0x4c
  jmp alltraps
80105f87:	e9 77 f8 ff ff       	jmp    80105803 <alltraps>

80105f8c <vector77>:
.globl vector77
vector77:
  pushl $0
80105f8c:	6a 00                	push   $0x0
  pushl $77
80105f8e:	6a 4d                	push   $0x4d
  jmp alltraps
80105f90:	e9 6e f8 ff ff       	jmp    80105803 <alltraps>

80105f95 <vector78>:
.globl vector78
vector78:
  pushl $0
80105f95:	6a 00                	push   $0x0
  pushl $78
80105f97:	6a 4e                	push   $0x4e
  jmp alltraps
80105f99:	e9 65 f8 ff ff       	jmp    80105803 <alltraps>

80105f9e <vector79>:
.globl vector79
vector79:
  pushl $0
80105f9e:	6a 00                	push   $0x0
  pushl $79
80105fa0:	6a 4f                	push   $0x4f
  jmp alltraps
80105fa2:	e9 5c f8 ff ff       	jmp    80105803 <alltraps>

80105fa7 <vector80>:
.globl vector80
vector80:
  pushl $0
80105fa7:	6a 00                	push   $0x0
  pushl $80
80105fa9:	6a 50                	push   $0x50
  jmp alltraps
80105fab:	e9 53 f8 ff ff       	jmp    80105803 <alltraps>

80105fb0 <vector81>:
.globl vector81
vector81:
  pushl $0
80105fb0:	6a 00                	push   $0x0
  pushl $81
80105fb2:	6a 51                	push   $0x51
  jmp alltraps
80105fb4:	e9 4a f8 ff ff       	jmp    80105803 <alltraps>

80105fb9 <vector82>:
.globl vector82
vector82:
  pushl $0
80105fb9:	6a 00                	push   $0x0
  pushl $82
80105fbb:	6a 52                	push   $0x52
  jmp alltraps
80105fbd:	e9 41 f8 ff ff       	jmp    80105803 <alltraps>

80105fc2 <vector83>:
.globl vector83
vector83:
  pushl $0
80105fc2:	6a 00                	push   $0x0
  pushl $83
80105fc4:	6a 53                	push   $0x53
  jmp alltraps
80105fc6:	e9 38 f8 ff ff       	jmp    80105803 <alltraps>

80105fcb <vector84>:
.globl vector84
vector84:
  pushl $0
80105fcb:	6a 00                	push   $0x0
  pushl $84
80105fcd:	6a 54                	push   $0x54
  jmp alltraps
80105fcf:	e9 2f f8 ff ff       	jmp    80105803 <alltraps>

80105fd4 <vector85>:
.globl vector85
vector85:
  pushl $0
80105fd4:	6a 00                	push   $0x0
  pushl $85
80105fd6:	6a 55                	push   $0x55
  jmp alltraps
80105fd8:	e9 26 f8 ff ff       	jmp    80105803 <alltraps>

80105fdd <vector86>:
.globl vector86
vector86:
  pushl $0
80105fdd:	6a 00                	push   $0x0
  pushl $86
80105fdf:	6a 56                	push   $0x56
  jmp alltraps
80105fe1:	e9 1d f8 ff ff       	jmp    80105803 <alltraps>

80105fe6 <vector87>:
.globl vector87
vector87:
  pushl $0
80105fe6:	6a 00                	push   $0x0
  pushl $87
80105fe8:	6a 57                	push   $0x57
  jmp alltraps
80105fea:	e9 14 f8 ff ff       	jmp    80105803 <alltraps>

80105fef <vector88>:
.globl vector88
vector88:
  pushl $0
80105fef:	6a 00                	push   $0x0
  pushl $88
80105ff1:	6a 58                	push   $0x58
  jmp alltraps
80105ff3:	e9 0b f8 ff ff       	jmp    80105803 <alltraps>

80105ff8 <vector89>:
.globl vector89
vector89:
  pushl $0
80105ff8:	6a 00                	push   $0x0
  pushl $89
80105ffa:	6a 59                	push   $0x59
  jmp alltraps
80105ffc:	e9 02 f8 ff ff       	jmp    80105803 <alltraps>

80106001 <vector90>:
.globl vector90
vector90:
  pushl $0
80106001:	6a 00                	push   $0x0
  pushl $90
80106003:	6a 5a                	push   $0x5a
  jmp alltraps
80106005:	e9 f9 f7 ff ff       	jmp    80105803 <alltraps>

8010600a <vector91>:
.globl vector91
vector91:
  pushl $0
8010600a:	6a 00                	push   $0x0
  pushl $91
8010600c:	6a 5b                	push   $0x5b
  jmp alltraps
8010600e:	e9 f0 f7 ff ff       	jmp    80105803 <alltraps>

80106013 <vector92>:
.globl vector92
vector92:
  pushl $0
80106013:	6a 00                	push   $0x0
  pushl $92
80106015:	6a 5c                	push   $0x5c
  jmp alltraps
80106017:	e9 e7 f7 ff ff       	jmp    80105803 <alltraps>

8010601c <vector93>:
.globl vector93
vector93:
  pushl $0
8010601c:	6a 00                	push   $0x0
  pushl $93
8010601e:	6a 5d                	push   $0x5d
  jmp alltraps
80106020:	e9 de f7 ff ff       	jmp    80105803 <alltraps>

80106025 <vector94>:
.globl vector94
vector94:
  pushl $0
80106025:	6a 00                	push   $0x0
  pushl $94
80106027:	6a 5e                	push   $0x5e
  jmp alltraps
80106029:	e9 d5 f7 ff ff       	jmp    80105803 <alltraps>

8010602e <vector95>:
.globl vector95
vector95:
  pushl $0
8010602e:	6a 00                	push   $0x0
  pushl $95
80106030:	6a 5f                	push   $0x5f
  jmp alltraps
80106032:	e9 cc f7 ff ff       	jmp    80105803 <alltraps>

80106037 <vector96>:
.globl vector96
vector96:
  pushl $0
80106037:	6a 00                	push   $0x0
  pushl $96
80106039:	6a 60                	push   $0x60
  jmp alltraps
8010603b:	e9 c3 f7 ff ff       	jmp    80105803 <alltraps>

80106040 <vector97>:
.globl vector97
vector97:
  pushl $0
80106040:	6a 00                	push   $0x0
  pushl $97
80106042:	6a 61                	push   $0x61
  jmp alltraps
80106044:	e9 ba f7 ff ff       	jmp    80105803 <alltraps>

80106049 <vector98>:
.globl vector98
vector98:
  pushl $0
80106049:	6a 00                	push   $0x0
  pushl $98
8010604b:	6a 62                	push   $0x62
  jmp alltraps
8010604d:	e9 b1 f7 ff ff       	jmp    80105803 <alltraps>

80106052 <vector99>:
.globl vector99
vector99:
  pushl $0
80106052:	6a 00                	push   $0x0
  pushl $99
80106054:	6a 63                	push   $0x63
  jmp alltraps
80106056:	e9 a8 f7 ff ff       	jmp    80105803 <alltraps>

8010605b <vector100>:
.globl vector100
vector100:
  pushl $0
8010605b:	6a 00                	push   $0x0
  pushl $100
8010605d:	6a 64                	push   $0x64
  jmp alltraps
8010605f:	e9 9f f7 ff ff       	jmp    80105803 <alltraps>

80106064 <vector101>:
.globl vector101
vector101:
  pushl $0
80106064:	6a 00                	push   $0x0
  pushl $101
80106066:	6a 65                	push   $0x65
  jmp alltraps
80106068:	e9 96 f7 ff ff       	jmp    80105803 <alltraps>

8010606d <vector102>:
.globl vector102
vector102:
  pushl $0
8010606d:	6a 00                	push   $0x0
  pushl $102
8010606f:	6a 66                	push   $0x66
  jmp alltraps
80106071:	e9 8d f7 ff ff       	jmp    80105803 <alltraps>

80106076 <vector103>:
.globl vector103
vector103:
  pushl $0
80106076:	6a 00                	push   $0x0
  pushl $103
80106078:	6a 67                	push   $0x67
  jmp alltraps
8010607a:	e9 84 f7 ff ff       	jmp    80105803 <alltraps>

8010607f <vector104>:
.globl vector104
vector104:
  pushl $0
8010607f:	6a 00                	push   $0x0
  pushl $104
80106081:	6a 68                	push   $0x68
  jmp alltraps
80106083:	e9 7b f7 ff ff       	jmp    80105803 <alltraps>

80106088 <vector105>:
.globl vector105
vector105:
  pushl $0
80106088:	6a 00                	push   $0x0
  pushl $105
8010608a:	6a 69                	push   $0x69
  jmp alltraps
8010608c:	e9 72 f7 ff ff       	jmp    80105803 <alltraps>

80106091 <vector106>:
.globl vector106
vector106:
  pushl $0
80106091:	6a 00                	push   $0x0
  pushl $106
80106093:	6a 6a                	push   $0x6a
  jmp alltraps
80106095:	e9 69 f7 ff ff       	jmp    80105803 <alltraps>

8010609a <vector107>:
.globl vector107
vector107:
  pushl $0
8010609a:	6a 00                	push   $0x0
  pushl $107
8010609c:	6a 6b                	push   $0x6b
  jmp alltraps
8010609e:	e9 60 f7 ff ff       	jmp    80105803 <alltraps>

801060a3 <vector108>:
.globl vector108
vector108:
  pushl $0
801060a3:	6a 00                	push   $0x0
  pushl $108
801060a5:	6a 6c                	push   $0x6c
  jmp alltraps
801060a7:	e9 57 f7 ff ff       	jmp    80105803 <alltraps>

801060ac <vector109>:
.globl vector109
vector109:
  pushl $0
801060ac:	6a 00                	push   $0x0
  pushl $109
801060ae:	6a 6d                	push   $0x6d
  jmp alltraps
801060b0:	e9 4e f7 ff ff       	jmp    80105803 <alltraps>

801060b5 <vector110>:
.globl vector110
vector110:
  pushl $0
801060b5:	6a 00                	push   $0x0
  pushl $110
801060b7:	6a 6e                	push   $0x6e
  jmp alltraps
801060b9:	e9 45 f7 ff ff       	jmp    80105803 <alltraps>

801060be <vector111>:
.globl vector111
vector111:
  pushl $0
801060be:	6a 00                	push   $0x0
  pushl $111
801060c0:	6a 6f                	push   $0x6f
  jmp alltraps
801060c2:	e9 3c f7 ff ff       	jmp    80105803 <alltraps>

801060c7 <vector112>:
.globl vector112
vector112:
  pushl $0
801060c7:	6a 00                	push   $0x0
  pushl $112
801060c9:	6a 70                	push   $0x70
  jmp alltraps
801060cb:	e9 33 f7 ff ff       	jmp    80105803 <alltraps>

801060d0 <vector113>:
.globl vector113
vector113:
  pushl $0
801060d0:	6a 00                	push   $0x0
  pushl $113
801060d2:	6a 71                	push   $0x71
  jmp alltraps
801060d4:	e9 2a f7 ff ff       	jmp    80105803 <alltraps>

801060d9 <vector114>:
.globl vector114
vector114:
  pushl $0
801060d9:	6a 00                	push   $0x0
  pushl $114
801060db:	6a 72                	push   $0x72
  jmp alltraps
801060dd:	e9 21 f7 ff ff       	jmp    80105803 <alltraps>

801060e2 <vector115>:
.globl vector115
vector115:
  pushl $0
801060e2:	6a 00                	push   $0x0
  pushl $115
801060e4:	6a 73                	push   $0x73
  jmp alltraps
801060e6:	e9 18 f7 ff ff       	jmp    80105803 <alltraps>

801060eb <vector116>:
.globl vector116
vector116:
  pushl $0
801060eb:	6a 00                	push   $0x0
  pushl $116
801060ed:	6a 74                	push   $0x74
  jmp alltraps
801060ef:	e9 0f f7 ff ff       	jmp    80105803 <alltraps>

801060f4 <vector117>:
.globl vector117
vector117:
  pushl $0
801060f4:	6a 00                	push   $0x0
  pushl $117
801060f6:	6a 75                	push   $0x75
  jmp alltraps
801060f8:	e9 06 f7 ff ff       	jmp    80105803 <alltraps>

801060fd <vector118>:
.globl vector118
vector118:
  pushl $0
801060fd:	6a 00                	push   $0x0
  pushl $118
801060ff:	6a 76                	push   $0x76
  jmp alltraps
80106101:	e9 fd f6 ff ff       	jmp    80105803 <alltraps>

80106106 <vector119>:
.globl vector119
vector119:
  pushl $0
80106106:	6a 00                	push   $0x0
  pushl $119
80106108:	6a 77                	push   $0x77
  jmp alltraps
8010610a:	e9 f4 f6 ff ff       	jmp    80105803 <alltraps>

8010610f <vector120>:
.globl vector120
vector120:
  pushl $0
8010610f:	6a 00                	push   $0x0
  pushl $120
80106111:	6a 78                	push   $0x78
  jmp alltraps
80106113:	e9 eb f6 ff ff       	jmp    80105803 <alltraps>

80106118 <vector121>:
.globl vector121
vector121:
  pushl $0
80106118:	6a 00                	push   $0x0
  pushl $121
8010611a:	6a 79                	push   $0x79
  jmp alltraps
8010611c:	e9 e2 f6 ff ff       	jmp    80105803 <alltraps>

80106121 <vector122>:
.globl vector122
vector122:
  pushl $0
80106121:	6a 00                	push   $0x0
  pushl $122
80106123:	6a 7a                	push   $0x7a
  jmp alltraps
80106125:	e9 d9 f6 ff ff       	jmp    80105803 <alltraps>

8010612a <vector123>:
.globl vector123
vector123:
  pushl $0
8010612a:	6a 00                	push   $0x0
  pushl $123
8010612c:	6a 7b                	push   $0x7b
  jmp alltraps
8010612e:	e9 d0 f6 ff ff       	jmp    80105803 <alltraps>

80106133 <vector124>:
.globl vector124
vector124:
  pushl $0
80106133:	6a 00                	push   $0x0
  pushl $124
80106135:	6a 7c                	push   $0x7c
  jmp alltraps
80106137:	e9 c7 f6 ff ff       	jmp    80105803 <alltraps>

8010613c <vector125>:
.globl vector125
vector125:
  pushl $0
8010613c:	6a 00                	push   $0x0
  pushl $125
8010613e:	6a 7d                	push   $0x7d
  jmp alltraps
80106140:	e9 be f6 ff ff       	jmp    80105803 <alltraps>

80106145 <vector126>:
.globl vector126
vector126:
  pushl $0
80106145:	6a 00                	push   $0x0
  pushl $126
80106147:	6a 7e                	push   $0x7e
  jmp alltraps
80106149:	e9 b5 f6 ff ff       	jmp    80105803 <alltraps>

8010614e <vector127>:
.globl vector127
vector127:
  pushl $0
8010614e:	6a 00                	push   $0x0
  pushl $127
80106150:	6a 7f                	push   $0x7f
  jmp alltraps
80106152:	e9 ac f6 ff ff       	jmp    80105803 <alltraps>

80106157 <vector128>:
.globl vector128
vector128:
  pushl $0
80106157:	6a 00                	push   $0x0
  pushl $128
80106159:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010615e:	e9 a0 f6 ff ff       	jmp    80105803 <alltraps>

80106163 <vector129>:
.globl vector129
vector129:
  pushl $0
80106163:	6a 00                	push   $0x0
  pushl $129
80106165:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010616a:	e9 94 f6 ff ff       	jmp    80105803 <alltraps>

8010616f <vector130>:
.globl vector130
vector130:
  pushl $0
8010616f:	6a 00                	push   $0x0
  pushl $130
80106171:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106176:	e9 88 f6 ff ff       	jmp    80105803 <alltraps>

8010617b <vector131>:
.globl vector131
vector131:
  pushl $0
8010617b:	6a 00                	push   $0x0
  pushl $131
8010617d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106182:	e9 7c f6 ff ff       	jmp    80105803 <alltraps>

80106187 <vector132>:
.globl vector132
vector132:
  pushl $0
80106187:	6a 00                	push   $0x0
  pushl $132
80106189:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010618e:	e9 70 f6 ff ff       	jmp    80105803 <alltraps>

80106193 <vector133>:
.globl vector133
vector133:
  pushl $0
80106193:	6a 00                	push   $0x0
  pushl $133
80106195:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010619a:	e9 64 f6 ff ff       	jmp    80105803 <alltraps>

8010619f <vector134>:
.globl vector134
vector134:
  pushl $0
8010619f:	6a 00                	push   $0x0
  pushl $134
801061a1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801061a6:	e9 58 f6 ff ff       	jmp    80105803 <alltraps>

801061ab <vector135>:
.globl vector135
vector135:
  pushl $0
801061ab:	6a 00                	push   $0x0
  pushl $135
801061ad:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801061b2:	e9 4c f6 ff ff       	jmp    80105803 <alltraps>

801061b7 <vector136>:
.globl vector136
vector136:
  pushl $0
801061b7:	6a 00                	push   $0x0
  pushl $136
801061b9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801061be:	e9 40 f6 ff ff       	jmp    80105803 <alltraps>

801061c3 <vector137>:
.globl vector137
vector137:
  pushl $0
801061c3:	6a 00                	push   $0x0
  pushl $137
801061c5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801061ca:	e9 34 f6 ff ff       	jmp    80105803 <alltraps>

801061cf <vector138>:
.globl vector138
vector138:
  pushl $0
801061cf:	6a 00                	push   $0x0
  pushl $138
801061d1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801061d6:	e9 28 f6 ff ff       	jmp    80105803 <alltraps>

801061db <vector139>:
.globl vector139
vector139:
  pushl $0
801061db:	6a 00                	push   $0x0
  pushl $139
801061dd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801061e2:	e9 1c f6 ff ff       	jmp    80105803 <alltraps>

801061e7 <vector140>:
.globl vector140
vector140:
  pushl $0
801061e7:	6a 00                	push   $0x0
  pushl $140
801061e9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801061ee:	e9 10 f6 ff ff       	jmp    80105803 <alltraps>

801061f3 <vector141>:
.globl vector141
vector141:
  pushl $0
801061f3:	6a 00                	push   $0x0
  pushl $141
801061f5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801061fa:	e9 04 f6 ff ff       	jmp    80105803 <alltraps>

801061ff <vector142>:
.globl vector142
vector142:
  pushl $0
801061ff:	6a 00                	push   $0x0
  pushl $142
80106201:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106206:	e9 f8 f5 ff ff       	jmp    80105803 <alltraps>

8010620b <vector143>:
.globl vector143
vector143:
  pushl $0
8010620b:	6a 00                	push   $0x0
  pushl $143
8010620d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106212:	e9 ec f5 ff ff       	jmp    80105803 <alltraps>

80106217 <vector144>:
.globl vector144
vector144:
  pushl $0
80106217:	6a 00                	push   $0x0
  pushl $144
80106219:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010621e:	e9 e0 f5 ff ff       	jmp    80105803 <alltraps>

80106223 <vector145>:
.globl vector145
vector145:
  pushl $0
80106223:	6a 00                	push   $0x0
  pushl $145
80106225:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010622a:	e9 d4 f5 ff ff       	jmp    80105803 <alltraps>

8010622f <vector146>:
.globl vector146
vector146:
  pushl $0
8010622f:	6a 00                	push   $0x0
  pushl $146
80106231:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106236:	e9 c8 f5 ff ff       	jmp    80105803 <alltraps>

8010623b <vector147>:
.globl vector147
vector147:
  pushl $0
8010623b:	6a 00                	push   $0x0
  pushl $147
8010623d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106242:	e9 bc f5 ff ff       	jmp    80105803 <alltraps>

80106247 <vector148>:
.globl vector148
vector148:
  pushl $0
80106247:	6a 00                	push   $0x0
  pushl $148
80106249:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010624e:	e9 b0 f5 ff ff       	jmp    80105803 <alltraps>

80106253 <vector149>:
.globl vector149
vector149:
  pushl $0
80106253:	6a 00                	push   $0x0
  pushl $149
80106255:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010625a:	e9 a4 f5 ff ff       	jmp    80105803 <alltraps>

8010625f <vector150>:
.globl vector150
vector150:
  pushl $0
8010625f:	6a 00                	push   $0x0
  pushl $150
80106261:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106266:	e9 98 f5 ff ff       	jmp    80105803 <alltraps>

8010626b <vector151>:
.globl vector151
vector151:
  pushl $0
8010626b:	6a 00                	push   $0x0
  pushl $151
8010626d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106272:	e9 8c f5 ff ff       	jmp    80105803 <alltraps>

80106277 <vector152>:
.globl vector152
vector152:
  pushl $0
80106277:	6a 00                	push   $0x0
  pushl $152
80106279:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010627e:	e9 80 f5 ff ff       	jmp    80105803 <alltraps>

80106283 <vector153>:
.globl vector153
vector153:
  pushl $0
80106283:	6a 00                	push   $0x0
  pushl $153
80106285:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010628a:	e9 74 f5 ff ff       	jmp    80105803 <alltraps>

8010628f <vector154>:
.globl vector154
vector154:
  pushl $0
8010628f:	6a 00                	push   $0x0
  pushl $154
80106291:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106296:	e9 68 f5 ff ff       	jmp    80105803 <alltraps>

8010629b <vector155>:
.globl vector155
vector155:
  pushl $0
8010629b:	6a 00                	push   $0x0
  pushl $155
8010629d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801062a2:	e9 5c f5 ff ff       	jmp    80105803 <alltraps>

801062a7 <vector156>:
.globl vector156
vector156:
  pushl $0
801062a7:	6a 00                	push   $0x0
  pushl $156
801062a9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801062ae:	e9 50 f5 ff ff       	jmp    80105803 <alltraps>

801062b3 <vector157>:
.globl vector157
vector157:
  pushl $0
801062b3:	6a 00                	push   $0x0
  pushl $157
801062b5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801062ba:	e9 44 f5 ff ff       	jmp    80105803 <alltraps>

801062bf <vector158>:
.globl vector158
vector158:
  pushl $0
801062bf:	6a 00                	push   $0x0
  pushl $158
801062c1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801062c6:	e9 38 f5 ff ff       	jmp    80105803 <alltraps>

801062cb <vector159>:
.globl vector159
vector159:
  pushl $0
801062cb:	6a 00                	push   $0x0
  pushl $159
801062cd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801062d2:	e9 2c f5 ff ff       	jmp    80105803 <alltraps>

801062d7 <vector160>:
.globl vector160
vector160:
  pushl $0
801062d7:	6a 00                	push   $0x0
  pushl $160
801062d9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801062de:	e9 20 f5 ff ff       	jmp    80105803 <alltraps>

801062e3 <vector161>:
.globl vector161
vector161:
  pushl $0
801062e3:	6a 00                	push   $0x0
  pushl $161
801062e5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801062ea:	e9 14 f5 ff ff       	jmp    80105803 <alltraps>

801062ef <vector162>:
.globl vector162
vector162:
  pushl $0
801062ef:	6a 00                	push   $0x0
  pushl $162
801062f1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801062f6:	e9 08 f5 ff ff       	jmp    80105803 <alltraps>

801062fb <vector163>:
.globl vector163
vector163:
  pushl $0
801062fb:	6a 00                	push   $0x0
  pushl $163
801062fd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106302:	e9 fc f4 ff ff       	jmp    80105803 <alltraps>

80106307 <vector164>:
.globl vector164
vector164:
  pushl $0
80106307:	6a 00                	push   $0x0
  pushl $164
80106309:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010630e:	e9 f0 f4 ff ff       	jmp    80105803 <alltraps>

80106313 <vector165>:
.globl vector165
vector165:
  pushl $0
80106313:	6a 00                	push   $0x0
  pushl $165
80106315:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010631a:	e9 e4 f4 ff ff       	jmp    80105803 <alltraps>

8010631f <vector166>:
.globl vector166
vector166:
  pushl $0
8010631f:	6a 00                	push   $0x0
  pushl $166
80106321:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106326:	e9 d8 f4 ff ff       	jmp    80105803 <alltraps>

8010632b <vector167>:
.globl vector167
vector167:
  pushl $0
8010632b:	6a 00                	push   $0x0
  pushl $167
8010632d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106332:	e9 cc f4 ff ff       	jmp    80105803 <alltraps>

80106337 <vector168>:
.globl vector168
vector168:
  pushl $0
80106337:	6a 00                	push   $0x0
  pushl $168
80106339:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010633e:	e9 c0 f4 ff ff       	jmp    80105803 <alltraps>

80106343 <vector169>:
.globl vector169
vector169:
  pushl $0
80106343:	6a 00                	push   $0x0
  pushl $169
80106345:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010634a:	e9 b4 f4 ff ff       	jmp    80105803 <alltraps>

8010634f <vector170>:
.globl vector170
vector170:
  pushl $0
8010634f:	6a 00                	push   $0x0
  pushl $170
80106351:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106356:	e9 a8 f4 ff ff       	jmp    80105803 <alltraps>

8010635b <vector171>:
.globl vector171
vector171:
  pushl $0
8010635b:	6a 00                	push   $0x0
  pushl $171
8010635d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106362:	e9 9c f4 ff ff       	jmp    80105803 <alltraps>

80106367 <vector172>:
.globl vector172
vector172:
  pushl $0
80106367:	6a 00                	push   $0x0
  pushl $172
80106369:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010636e:	e9 90 f4 ff ff       	jmp    80105803 <alltraps>

80106373 <vector173>:
.globl vector173
vector173:
  pushl $0
80106373:	6a 00                	push   $0x0
  pushl $173
80106375:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010637a:	e9 84 f4 ff ff       	jmp    80105803 <alltraps>

8010637f <vector174>:
.globl vector174
vector174:
  pushl $0
8010637f:	6a 00                	push   $0x0
  pushl $174
80106381:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106386:	e9 78 f4 ff ff       	jmp    80105803 <alltraps>

8010638b <vector175>:
.globl vector175
vector175:
  pushl $0
8010638b:	6a 00                	push   $0x0
  pushl $175
8010638d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106392:	e9 6c f4 ff ff       	jmp    80105803 <alltraps>

80106397 <vector176>:
.globl vector176
vector176:
  pushl $0
80106397:	6a 00                	push   $0x0
  pushl $176
80106399:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010639e:	e9 60 f4 ff ff       	jmp    80105803 <alltraps>

801063a3 <vector177>:
.globl vector177
vector177:
  pushl $0
801063a3:	6a 00                	push   $0x0
  pushl $177
801063a5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801063aa:	e9 54 f4 ff ff       	jmp    80105803 <alltraps>

801063af <vector178>:
.globl vector178
vector178:
  pushl $0
801063af:	6a 00                	push   $0x0
  pushl $178
801063b1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801063b6:	e9 48 f4 ff ff       	jmp    80105803 <alltraps>

801063bb <vector179>:
.globl vector179
vector179:
  pushl $0
801063bb:	6a 00                	push   $0x0
  pushl $179
801063bd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801063c2:	e9 3c f4 ff ff       	jmp    80105803 <alltraps>

801063c7 <vector180>:
.globl vector180
vector180:
  pushl $0
801063c7:	6a 00                	push   $0x0
  pushl $180
801063c9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801063ce:	e9 30 f4 ff ff       	jmp    80105803 <alltraps>

801063d3 <vector181>:
.globl vector181
vector181:
  pushl $0
801063d3:	6a 00                	push   $0x0
  pushl $181
801063d5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801063da:	e9 24 f4 ff ff       	jmp    80105803 <alltraps>

801063df <vector182>:
.globl vector182
vector182:
  pushl $0
801063df:	6a 00                	push   $0x0
  pushl $182
801063e1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801063e6:	e9 18 f4 ff ff       	jmp    80105803 <alltraps>

801063eb <vector183>:
.globl vector183
vector183:
  pushl $0
801063eb:	6a 00                	push   $0x0
  pushl $183
801063ed:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801063f2:	e9 0c f4 ff ff       	jmp    80105803 <alltraps>

801063f7 <vector184>:
.globl vector184
vector184:
  pushl $0
801063f7:	6a 00                	push   $0x0
  pushl $184
801063f9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801063fe:	e9 00 f4 ff ff       	jmp    80105803 <alltraps>

80106403 <vector185>:
.globl vector185
vector185:
  pushl $0
80106403:	6a 00                	push   $0x0
  pushl $185
80106405:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010640a:	e9 f4 f3 ff ff       	jmp    80105803 <alltraps>

8010640f <vector186>:
.globl vector186
vector186:
  pushl $0
8010640f:	6a 00                	push   $0x0
  pushl $186
80106411:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106416:	e9 e8 f3 ff ff       	jmp    80105803 <alltraps>

8010641b <vector187>:
.globl vector187
vector187:
  pushl $0
8010641b:	6a 00                	push   $0x0
  pushl $187
8010641d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106422:	e9 dc f3 ff ff       	jmp    80105803 <alltraps>

80106427 <vector188>:
.globl vector188
vector188:
  pushl $0
80106427:	6a 00                	push   $0x0
  pushl $188
80106429:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010642e:	e9 d0 f3 ff ff       	jmp    80105803 <alltraps>

80106433 <vector189>:
.globl vector189
vector189:
  pushl $0
80106433:	6a 00                	push   $0x0
  pushl $189
80106435:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010643a:	e9 c4 f3 ff ff       	jmp    80105803 <alltraps>

8010643f <vector190>:
.globl vector190
vector190:
  pushl $0
8010643f:	6a 00                	push   $0x0
  pushl $190
80106441:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106446:	e9 b8 f3 ff ff       	jmp    80105803 <alltraps>

8010644b <vector191>:
.globl vector191
vector191:
  pushl $0
8010644b:	6a 00                	push   $0x0
  pushl $191
8010644d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106452:	e9 ac f3 ff ff       	jmp    80105803 <alltraps>

80106457 <vector192>:
.globl vector192
vector192:
  pushl $0
80106457:	6a 00                	push   $0x0
  pushl $192
80106459:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010645e:	e9 a0 f3 ff ff       	jmp    80105803 <alltraps>

80106463 <vector193>:
.globl vector193
vector193:
  pushl $0
80106463:	6a 00                	push   $0x0
  pushl $193
80106465:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010646a:	e9 94 f3 ff ff       	jmp    80105803 <alltraps>

8010646f <vector194>:
.globl vector194
vector194:
  pushl $0
8010646f:	6a 00                	push   $0x0
  pushl $194
80106471:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106476:	e9 88 f3 ff ff       	jmp    80105803 <alltraps>

8010647b <vector195>:
.globl vector195
vector195:
  pushl $0
8010647b:	6a 00                	push   $0x0
  pushl $195
8010647d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106482:	e9 7c f3 ff ff       	jmp    80105803 <alltraps>

80106487 <vector196>:
.globl vector196
vector196:
  pushl $0
80106487:	6a 00                	push   $0x0
  pushl $196
80106489:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010648e:	e9 70 f3 ff ff       	jmp    80105803 <alltraps>

80106493 <vector197>:
.globl vector197
vector197:
  pushl $0
80106493:	6a 00                	push   $0x0
  pushl $197
80106495:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010649a:	e9 64 f3 ff ff       	jmp    80105803 <alltraps>

8010649f <vector198>:
.globl vector198
vector198:
  pushl $0
8010649f:	6a 00                	push   $0x0
  pushl $198
801064a1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801064a6:	e9 58 f3 ff ff       	jmp    80105803 <alltraps>

801064ab <vector199>:
.globl vector199
vector199:
  pushl $0
801064ab:	6a 00                	push   $0x0
  pushl $199
801064ad:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801064b2:	e9 4c f3 ff ff       	jmp    80105803 <alltraps>

801064b7 <vector200>:
.globl vector200
vector200:
  pushl $0
801064b7:	6a 00                	push   $0x0
  pushl $200
801064b9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801064be:	e9 40 f3 ff ff       	jmp    80105803 <alltraps>

801064c3 <vector201>:
.globl vector201
vector201:
  pushl $0
801064c3:	6a 00                	push   $0x0
  pushl $201
801064c5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801064ca:	e9 34 f3 ff ff       	jmp    80105803 <alltraps>

801064cf <vector202>:
.globl vector202
vector202:
  pushl $0
801064cf:	6a 00                	push   $0x0
  pushl $202
801064d1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801064d6:	e9 28 f3 ff ff       	jmp    80105803 <alltraps>

801064db <vector203>:
.globl vector203
vector203:
  pushl $0
801064db:	6a 00                	push   $0x0
  pushl $203
801064dd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801064e2:	e9 1c f3 ff ff       	jmp    80105803 <alltraps>

801064e7 <vector204>:
.globl vector204
vector204:
  pushl $0
801064e7:	6a 00                	push   $0x0
  pushl $204
801064e9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801064ee:	e9 10 f3 ff ff       	jmp    80105803 <alltraps>

801064f3 <vector205>:
.globl vector205
vector205:
  pushl $0
801064f3:	6a 00                	push   $0x0
  pushl $205
801064f5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801064fa:	e9 04 f3 ff ff       	jmp    80105803 <alltraps>

801064ff <vector206>:
.globl vector206
vector206:
  pushl $0
801064ff:	6a 00                	push   $0x0
  pushl $206
80106501:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106506:	e9 f8 f2 ff ff       	jmp    80105803 <alltraps>

8010650b <vector207>:
.globl vector207
vector207:
  pushl $0
8010650b:	6a 00                	push   $0x0
  pushl $207
8010650d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106512:	e9 ec f2 ff ff       	jmp    80105803 <alltraps>

80106517 <vector208>:
.globl vector208
vector208:
  pushl $0
80106517:	6a 00                	push   $0x0
  pushl $208
80106519:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010651e:	e9 e0 f2 ff ff       	jmp    80105803 <alltraps>

80106523 <vector209>:
.globl vector209
vector209:
  pushl $0
80106523:	6a 00                	push   $0x0
  pushl $209
80106525:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010652a:	e9 d4 f2 ff ff       	jmp    80105803 <alltraps>

8010652f <vector210>:
.globl vector210
vector210:
  pushl $0
8010652f:	6a 00                	push   $0x0
  pushl $210
80106531:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106536:	e9 c8 f2 ff ff       	jmp    80105803 <alltraps>

8010653b <vector211>:
.globl vector211
vector211:
  pushl $0
8010653b:	6a 00                	push   $0x0
  pushl $211
8010653d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106542:	e9 bc f2 ff ff       	jmp    80105803 <alltraps>

80106547 <vector212>:
.globl vector212
vector212:
  pushl $0
80106547:	6a 00                	push   $0x0
  pushl $212
80106549:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010654e:	e9 b0 f2 ff ff       	jmp    80105803 <alltraps>

80106553 <vector213>:
.globl vector213
vector213:
  pushl $0
80106553:	6a 00                	push   $0x0
  pushl $213
80106555:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010655a:	e9 a4 f2 ff ff       	jmp    80105803 <alltraps>

8010655f <vector214>:
.globl vector214
vector214:
  pushl $0
8010655f:	6a 00                	push   $0x0
  pushl $214
80106561:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106566:	e9 98 f2 ff ff       	jmp    80105803 <alltraps>

8010656b <vector215>:
.globl vector215
vector215:
  pushl $0
8010656b:	6a 00                	push   $0x0
  pushl $215
8010656d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106572:	e9 8c f2 ff ff       	jmp    80105803 <alltraps>

80106577 <vector216>:
.globl vector216
vector216:
  pushl $0
80106577:	6a 00                	push   $0x0
  pushl $216
80106579:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010657e:	e9 80 f2 ff ff       	jmp    80105803 <alltraps>

80106583 <vector217>:
.globl vector217
vector217:
  pushl $0
80106583:	6a 00                	push   $0x0
  pushl $217
80106585:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010658a:	e9 74 f2 ff ff       	jmp    80105803 <alltraps>

8010658f <vector218>:
.globl vector218
vector218:
  pushl $0
8010658f:	6a 00                	push   $0x0
  pushl $218
80106591:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106596:	e9 68 f2 ff ff       	jmp    80105803 <alltraps>

8010659b <vector219>:
.globl vector219
vector219:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $219
8010659d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801065a2:	e9 5c f2 ff ff       	jmp    80105803 <alltraps>

801065a7 <vector220>:
.globl vector220
vector220:
  pushl $0
801065a7:	6a 00                	push   $0x0
  pushl $220
801065a9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801065ae:	e9 50 f2 ff ff       	jmp    80105803 <alltraps>

801065b3 <vector221>:
.globl vector221
vector221:
  pushl $0
801065b3:	6a 00                	push   $0x0
  pushl $221
801065b5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801065ba:	e9 44 f2 ff ff       	jmp    80105803 <alltraps>

801065bf <vector222>:
.globl vector222
vector222:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $222
801065c1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801065c6:	e9 38 f2 ff ff       	jmp    80105803 <alltraps>

801065cb <vector223>:
.globl vector223
vector223:
  pushl $0
801065cb:	6a 00                	push   $0x0
  pushl $223
801065cd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801065d2:	e9 2c f2 ff ff       	jmp    80105803 <alltraps>

801065d7 <vector224>:
.globl vector224
vector224:
  pushl $0
801065d7:	6a 00                	push   $0x0
  pushl $224
801065d9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801065de:	e9 20 f2 ff ff       	jmp    80105803 <alltraps>

801065e3 <vector225>:
.globl vector225
vector225:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $225
801065e5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801065ea:	e9 14 f2 ff ff       	jmp    80105803 <alltraps>

801065ef <vector226>:
.globl vector226
vector226:
  pushl $0
801065ef:	6a 00                	push   $0x0
  pushl $226
801065f1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801065f6:	e9 08 f2 ff ff       	jmp    80105803 <alltraps>

801065fb <vector227>:
.globl vector227
vector227:
  pushl $0
801065fb:	6a 00                	push   $0x0
  pushl $227
801065fd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106602:	e9 fc f1 ff ff       	jmp    80105803 <alltraps>

80106607 <vector228>:
.globl vector228
vector228:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $228
80106609:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010660e:	e9 f0 f1 ff ff       	jmp    80105803 <alltraps>

80106613 <vector229>:
.globl vector229
vector229:
  pushl $0
80106613:	6a 00                	push   $0x0
  pushl $229
80106615:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010661a:	e9 e4 f1 ff ff       	jmp    80105803 <alltraps>

8010661f <vector230>:
.globl vector230
vector230:
  pushl $0
8010661f:	6a 00                	push   $0x0
  pushl $230
80106621:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106626:	e9 d8 f1 ff ff       	jmp    80105803 <alltraps>

8010662b <vector231>:
.globl vector231
vector231:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $231
8010662d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106632:	e9 cc f1 ff ff       	jmp    80105803 <alltraps>

80106637 <vector232>:
.globl vector232
vector232:
  pushl $0
80106637:	6a 00                	push   $0x0
  pushl $232
80106639:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010663e:	e9 c0 f1 ff ff       	jmp    80105803 <alltraps>

80106643 <vector233>:
.globl vector233
vector233:
  pushl $0
80106643:	6a 00                	push   $0x0
  pushl $233
80106645:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010664a:	e9 b4 f1 ff ff       	jmp    80105803 <alltraps>

8010664f <vector234>:
.globl vector234
vector234:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $234
80106651:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106656:	e9 a8 f1 ff ff       	jmp    80105803 <alltraps>

8010665b <vector235>:
.globl vector235
vector235:
  pushl $0
8010665b:	6a 00                	push   $0x0
  pushl $235
8010665d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106662:	e9 9c f1 ff ff       	jmp    80105803 <alltraps>

80106667 <vector236>:
.globl vector236
vector236:
  pushl $0
80106667:	6a 00                	push   $0x0
  pushl $236
80106669:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010666e:	e9 90 f1 ff ff       	jmp    80105803 <alltraps>

80106673 <vector237>:
.globl vector237
vector237:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $237
80106675:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010667a:	e9 84 f1 ff ff       	jmp    80105803 <alltraps>

8010667f <vector238>:
.globl vector238
vector238:
  pushl $0
8010667f:	6a 00                	push   $0x0
  pushl $238
80106681:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106686:	e9 78 f1 ff ff       	jmp    80105803 <alltraps>

8010668b <vector239>:
.globl vector239
vector239:
  pushl $0
8010668b:	6a 00                	push   $0x0
  pushl $239
8010668d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106692:	e9 6c f1 ff ff       	jmp    80105803 <alltraps>

80106697 <vector240>:
.globl vector240
vector240:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $240
80106699:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010669e:	e9 60 f1 ff ff       	jmp    80105803 <alltraps>

801066a3 <vector241>:
.globl vector241
vector241:
  pushl $0
801066a3:	6a 00                	push   $0x0
  pushl $241
801066a5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801066aa:	e9 54 f1 ff ff       	jmp    80105803 <alltraps>

801066af <vector242>:
.globl vector242
vector242:
  pushl $0
801066af:	6a 00                	push   $0x0
  pushl $242
801066b1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801066b6:	e9 48 f1 ff ff       	jmp    80105803 <alltraps>

801066bb <vector243>:
.globl vector243
vector243:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $243
801066bd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801066c2:	e9 3c f1 ff ff       	jmp    80105803 <alltraps>

801066c7 <vector244>:
.globl vector244
vector244:
  pushl $0
801066c7:	6a 00                	push   $0x0
  pushl $244
801066c9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801066ce:	e9 30 f1 ff ff       	jmp    80105803 <alltraps>

801066d3 <vector245>:
.globl vector245
vector245:
  pushl $0
801066d3:	6a 00                	push   $0x0
  pushl $245
801066d5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801066da:	e9 24 f1 ff ff       	jmp    80105803 <alltraps>

801066df <vector246>:
.globl vector246
vector246:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $246
801066e1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801066e6:	e9 18 f1 ff ff       	jmp    80105803 <alltraps>

801066eb <vector247>:
.globl vector247
vector247:
  pushl $0
801066eb:	6a 00                	push   $0x0
  pushl $247
801066ed:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801066f2:	e9 0c f1 ff ff       	jmp    80105803 <alltraps>

801066f7 <vector248>:
.globl vector248
vector248:
  pushl $0
801066f7:	6a 00                	push   $0x0
  pushl $248
801066f9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801066fe:	e9 00 f1 ff ff       	jmp    80105803 <alltraps>

80106703 <vector249>:
.globl vector249
vector249:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $249
80106705:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010670a:	e9 f4 f0 ff ff       	jmp    80105803 <alltraps>

8010670f <vector250>:
.globl vector250
vector250:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $250
80106711:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106716:	e9 e8 f0 ff ff       	jmp    80105803 <alltraps>

8010671b <vector251>:
.globl vector251
vector251:
  pushl $0
8010671b:	6a 00                	push   $0x0
  pushl $251
8010671d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106722:	e9 dc f0 ff ff       	jmp    80105803 <alltraps>

80106727 <vector252>:
.globl vector252
vector252:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $252
80106729:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010672e:	e9 d0 f0 ff ff       	jmp    80105803 <alltraps>

80106733 <vector253>:
.globl vector253
vector253:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $253
80106735:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010673a:	e9 c4 f0 ff ff       	jmp    80105803 <alltraps>

8010673f <vector254>:
.globl vector254
vector254:
  pushl $0
8010673f:	6a 00                	push   $0x0
  pushl $254
80106741:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106746:	e9 b8 f0 ff ff       	jmp    80105803 <alltraps>

8010674b <vector255>:
.globl vector255
vector255:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $255
8010674d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106752:	e9 ac f0 ff ff       	jmp    80105803 <alltraps>
80106757:	66 90                	xchg   %ax,%ax
80106759:	66 90                	xchg   %ax,%ax
8010675b:	66 90                	xchg   %ax,%ax
8010675d:	66 90                	xchg   %ax,%ax
8010675f:	90                   	nop

80106760 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106760:	55                   	push   %ebp
80106761:	89 e5                	mov    %esp,%ebp
80106763:	57                   	push   %edi
80106764:	56                   	push   %esi
80106765:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106766:	89 d3                	mov    %edx,%ebx
{
80106768:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010676a:	c1 eb 16             	shr    $0x16,%ebx
8010676d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106770:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106773:	8b 06                	mov    (%esi),%eax
80106775:	a8 01                	test   $0x1,%al
80106777:	74 27                	je     801067a0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106779:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010677e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106784:	c1 ef 0a             	shr    $0xa,%edi
}
80106787:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010678a:	89 fa                	mov    %edi,%edx
8010678c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106792:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106795:	5b                   	pop    %ebx
80106796:	5e                   	pop    %esi
80106797:	5f                   	pop    %edi
80106798:	5d                   	pop    %ebp
80106799:	c3                   	ret    
8010679a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801067a0:	85 c9                	test   %ecx,%ecx
801067a2:	74 2c                	je     801067d0 <walkpgdir+0x70>
801067a4:	e8 a7 be ff ff       	call   80102650 <kalloc>
801067a9:	85 c0                	test   %eax,%eax
801067ab:	89 c3                	mov    %eax,%ebx
801067ad:	74 21                	je     801067d0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801067af:	83 ec 04             	sub    $0x4,%esp
801067b2:	68 00 10 00 00       	push   $0x1000
801067b7:	6a 00                	push   $0x0
801067b9:	50                   	push   %eax
801067ba:	e8 21 de ff ff       	call   801045e0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801067bf:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801067c5:	83 c4 10             	add    $0x10,%esp
801067c8:	83 c8 07             	or     $0x7,%eax
801067cb:	89 06                	mov    %eax,(%esi)
801067cd:	eb b5                	jmp    80106784 <walkpgdir+0x24>
801067cf:	90                   	nop
}
801067d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801067d3:	31 c0                	xor    %eax,%eax
}
801067d5:	5b                   	pop    %ebx
801067d6:	5e                   	pop    %esi
801067d7:	5f                   	pop    %edi
801067d8:	5d                   	pop    %ebp
801067d9:	c3                   	ret    
801067da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801067e0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801067e0:	55                   	push   %ebp
801067e1:	89 e5                	mov    %esp,%ebp
801067e3:	57                   	push   %edi
801067e4:	56                   	push   %esi
801067e5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801067e6:	89 d3                	mov    %edx,%ebx
801067e8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801067ee:	83 ec 1c             	sub    $0x1c,%esp
801067f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801067f4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801067f8:	8b 7d 08             	mov    0x8(%ebp),%edi
801067fb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106800:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106803:	8b 45 0c             	mov    0xc(%ebp),%eax
80106806:	29 df                	sub    %ebx,%edi
80106808:	83 c8 01             	or     $0x1,%eax
8010680b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010680e:	eb 15                	jmp    80106825 <mappages+0x45>
    if(*pte & PTE_P)
80106810:	f6 00 01             	testb  $0x1,(%eax)
80106813:	75 45                	jne    8010685a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106815:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106818:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010681b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010681d:	74 31                	je     80106850 <mappages+0x70>
      break;
    a += PGSIZE;
8010681f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106825:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106828:	b9 01 00 00 00       	mov    $0x1,%ecx
8010682d:	89 da                	mov    %ebx,%edx
8010682f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106832:	e8 29 ff ff ff       	call   80106760 <walkpgdir>
80106837:	85 c0                	test   %eax,%eax
80106839:	75 d5                	jne    80106810 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010683b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010683e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106843:	5b                   	pop    %ebx
80106844:	5e                   	pop    %esi
80106845:	5f                   	pop    %edi
80106846:	5d                   	pop    %ebp
80106847:	c3                   	ret    
80106848:	90                   	nop
80106849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106850:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106853:	31 c0                	xor    %eax,%eax
}
80106855:	5b                   	pop    %ebx
80106856:	5e                   	pop    %esi
80106857:	5f                   	pop    %edi
80106858:	5d                   	pop    %ebp
80106859:	c3                   	ret    
      panic("remap");
8010685a:	83 ec 0c             	sub    $0xc,%esp
8010685d:	68 70 79 10 80       	push   $0x80107970
80106862:	e8 f9 9b ff ff       	call   80100460 <panic>
80106867:	89 f6                	mov    %esi,%esi
80106869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106870 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106870:	55                   	push   %ebp
80106871:	89 e5                	mov    %esp,%ebp
80106873:	57                   	push   %edi
80106874:	56                   	push   %esi
80106875:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106876:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010687c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
8010687e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106884:	83 ec 1c             	sub    $0x1c,%esp
80106887:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010688a:	39 d3                	cmp    %edx,%ebx
8010688c:	73 66                	jae    801068f4 <deallocuvm.part.0+0x84>
8010688e:	89 d6                	mov    %edx,%esi
80106890:	eb 3d                	jmp    801068cf <deallocuvm.part.0+0x5f>
80106892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106898:	8b 10                	mov    (%eax),%edx
8010689a:	f6 c2 01             	test   $0x1,%dl
8010689d:	74 26                	je     801068c5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010689f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801068a5:	74 58                	je     801068ff <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801068a7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801068aa:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801068b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
801068b3:	52                   	push   %edx
801068b4:	e8 e7 bb ff ff       	call   801024a0 <kfree>
      *pte = 0;
801068b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801068bc:	83 c4 10             	add    $0x10,%esp
801068bf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801068c5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801068cb:	39 f3                	cmp    %esi,%ebx
801068cd:	73 25                	jae    801068f4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
801068cf:	31 c9                	xor    %ecx,%ecx
801068d1:	89 da                	mov    %ebx,%edx
801068d3:	89 f8                	mov    %edi,%eax
801068d5:	e8 86 fe ff ff       	call   80106760 <walkpgdir>
    if(!pte)
801068da:	85 c0                	test   %eax,%eax
801068dc:	75 ba                	jne    80106898 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801068de:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801068e4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801068ea:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801068f0:	39 f3                	cmp    %esi,%ebx
801068f2:	72 db                	jb     801068cf <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
801068f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801068f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068fa:	5b                   	pop    %ebx
801068fb:	5e                   	pop    %esi
801068fc:	5f                   	pop    %edi
801068fd:	5d                   	pop    %ebp
801068fe:	c3                   	ret    
        panic("kfree");
801068ff:	83 ec 0c             	sub    $0xc,%esp
80106902:	68 0e 73 10 80       	push   $0x8010730e
80106907:	e8 54 9b ff ff       	call   80100460 <panic>
8010690c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106910 <seginit>:
{
80106910:	55                   	push   %ebp
80106911:	89 e5                	mov    %esp,%ebp
80106913:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106916:	e8 35 d0 ff ff       	call   80103950 <cpuid>
8010691b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80106921:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106926:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010692a:	c7 80 38 28 11 80 ff 	movl   $0xffff,-0x7feed7c8(%eax)
80106931:	ff 00 00 
80106934:	c7 80 3c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7c4(%eax)
8010693b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010693e:	c7 80 40 28 11 80 ff 	movl   $0xffff,-0x7feed7c0(%eax)
80106945:	ff 00 00 
80106948:	c7 80 44 28 11 80 00 	movl   $0xcf9200,-0x7feed7bc(%eax)
8010694f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106952:	c7 80 48 28 11 80 ff 	movl   $0xffff,-0x7feed7b8(%eax)
80106959:	ff 00 00 
8010695c:	c7 80 4c 28 11 80 00 	movl   $0xcffa00,-0x7feed7b4(%eax)
80106963:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106966:	c7 80 50 28 11 80 ff 	movl   $0xffff,-0x7feed7b0(%eax)
8010696d:	ff 00 00 
80106970:	c7 80 54 28 11 80 00 	movl   $0xcff200,-0x7feed7ac(%eax)
80106977:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010697a:	05 30 28 11 80       	add    $0x80112830,%eax
  pd[1] = (uint)p;
8010697f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106983:	c1 e8 10             	shr    $0x10,%eax
80106986:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010698a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010698d:	0f 01 10             	lgdtl  (%eax)
}
80106990:	c9                   	leave  
80106991:	c3                   	ret    
80106992:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069a0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801069a0:	a1 e4 55 11 80       	mov    0x801155e4,%eax
{
801069a5:	55                   	push   %ebp
801069a6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801069a8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801069ad:	0f 22 d8             	mov    %eax,%cr3
}
801069b0:	5d                   	pop    %ebp
801069b1:	c3                   	ret    
801069b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069c0 <switchuvm>:
{
801069c0:	55                   	push   %ebp
801069c1:	89 e5                	mov    %esp,%ebp
801069c3:	57                   	push   %edi
801069c4:	56                   	push   %esi
801069c5:	53                   	push   %ebx
801069c6:	83 ec 1c             	sub    $0x1c,%esp
801069c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
801069cc:	85 db                	test   %ebx,%ebx
801069ce:	0f 84 cb 00 00 00    	je     80106a9f <switchuvm+0xdf>
  if(p->kstack == 0)
801069d4:	8b 43 08             	mov    0x8(%ebx),%eax
801069d7:	85 c0                	test   %eax,%eax
801069d9:	0f 84 da 00 00 00    	je     80106ab9 <switchuvm+0xf9>
  if(p->pgdir == 0)
801069df:	8b 43 04             	mov    0x4(%ebx),%eax
801069e2:	85 c0                	test   %eax,%eax
801069e4:	0f 84 c2 00 00 00    	je     80106aac <switchuvm+0xec>
  pushcli();
801069ea:	e8 11 da ff ff       	call   80104400 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801069ef:	e8 dc ce ff ff       	call   801038d0 <mycpu>
801069f4:	89 c6                	mov    %eax,%esi
801069f6:	e8 d5 ce ff ff       	call   801038d0 <mycpu>
801069fb:	89 c7                	mov    %eax,%edi
801069fd:	e8 ce ce ff ff       	call   801038d0 <mycpu>
80106a02:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a05:	83 c7 08             	add    $0x8,%edi
80106a08:	e8 c3 ce ff ff       	call   801038d0 <mycpu>
80106a0d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106a10:	83 c0 08             	add    $0x8,%eax
80106a13:	ba 67 00 00 00       	mov    $0x67,%edx
80106a18:	c1 e8 18             	shr    $0x18,%eax
80106a1b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106a22:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106a29:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106a2f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106a34:	83 c1 08             	add    $0x8,%ecx
80106a37:	c1 e9 10             	shr    $0x10,%ecx
80106a3a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106a40:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106a45:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106a4c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106a51:	e8 7a ce ff ff       	call   801038d0 <mycpu>
80106a56:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106a5d:	e8 6e ce ff ff       	call   801038d0 <mycpu>
80106a62:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106a66:	8b 73 08             	mov    0x8(%ebx),%esi
80106a69:	e8 62 ce ff ff       	call   801038d0 <mycpu>
80106a6e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106a74:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106a77:	e8 54 ce ff ff       	call   801038d0 <mycpu>
80106a7c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106a80:	b8 28 00 00 00       	mov    $0x28,%eax
80106a85:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106a88:	8b 43 04             	mov    0x4(%ebx),%eax
80106a8b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106a90:	0f 22 d8             	mov    %eax,%cr3
}
80106a93:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a96:	5b                   	pop    %ebx
80106a97:	5e                   	pop    %esi
80106a98:	5f                   	pop    %edi
80106a99:	5d                   	pop    %ebp
  popcli();
80106a9a:	e9 a1 d9 ff ff       	jmp    80104440 <popcli>
    panic("switchuvm: no process");
80106a9f:	83 ec 0c             	sub    $0xc,%esp
80106aa2:	68 76 79 10 80       	push   $0x80107976
80106aa7:	e8 b4 99 ff ff       	call   80100460 <panic>
    panic("switchuvm: no pgdir");
80106aac:	83 ec 0c             	sub    $0xc,%esp
80106aaf:	68 a1 79 10 80       	push   $0x801079a1
80106ab4:	e8 a7 99 ff ff       	call   80100460 <panic>
    panic("switchuvm: no kstack");
80106ab9:	83 ec 0c             	sub    $0xc,%esp
80106abc:	68 8c 79 10 80       	push   $0x8010798c
80106ac1:	e8 9a 99 ff ff       	call   80100460 <panic>
80106ac6:	8d 76 00             	lea    0x0(%esi),%esi
80106ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ad0 <inituvm>:
{
80106ad0:	55                   	push   %ebp
80106ad1:	89 e5                	mov    %esp,%ebp
80106ad3:	57                   	push   %edi
80106ad4:	56                   	push   %esi
80106ad5:	53                   	push   %ebx
80106ad6:	83 ec 1c             	sub    $0x1c,%esp
80106ad9:	8b 75 10             	mov    0x10(%ebp),%esi
80106adc:	8b 45 08             	mov    0x8(%ebp),%eax
80106adf:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106ae2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106ae8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106aeb:	77 49                	ja     80106b36 <inituvm+0x66>
  mem = kalloc();
80106aed:	e8 5e bb ff ff       	call   80102650 <kalloc>
  memset(mem, 0, PGSIZE);
80106af2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106af5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106af7:	68 00 10 00 00       	push   $0x1000
80106afc:	6a 00                	push   $0x0
80106afe:	50                   	push   %eax
80106aff:	e8 dc da ff ff       	call   801045e0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106b04:	58                   	pop    %eax
80106b05:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106b0b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106b10:	5a                   	pop    %edx
80106b11:	6a 06                	push   $0x6
80106b13:	50                   	push   %eax
80106b14:	31 d2                	xor    %edx,%edx
80106b16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b19:	e8 c2 fc ff ff       	call   801067e0 <mappages>
  memmove(mem, init, sz);
80106b1e:	89 75 10             	mov    %esi,0x10(%ebp)
80106b21:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106b24:	83 c4 10             	add    $0x10,%esp
80106b27:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106b2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b2d:	5b                   	pop    %ebx
80106b2e:	5e                   	pop    %esi
80106b2f:	5f                   	pop    %edi
80106b30:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106b31:	e9 5a db ff ff       	jmp    80104690 <memmove>
    panic("inituvm: more than a page");
80106b36:	83 ec 0c             	sub    $0xc,%esp
80106b39:	68 b5 79 10 80       	push   $0x801079b5
80106b3e:	e8 1d 99 ff ff       	call   80100460 <panic>
80106b43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b50 <loaduvm>:
{
80106b50:	55                   	push   %ebp
80106b51:	89 e5                	mov    %esp,%ebp
80106b53:	57                   	push   %edi
80106b54:	56                   	push   %esi
80106b55:	53                   	push   %ebx
80106b56:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106b59:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106b60:	0f 85 91 00 00 00    	jne    80106bf7 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106b66:	8b 75 18             	mov    0x18(%ebp),%esi
80106b69:	31 db                	xor    %ebx,%ebx
80106b6b:	85 f6                	test   %esi,%esi
80106b6d:	75 1a                	jne    80106b89 <loaduvm+0x39>
80106b6f:	eb 6f                	jmp    80106be0 <loaduvm+0x90>
80106b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b78:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b7e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106b84:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106b87:	76 57                	jbe    80106be0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106b89:	8b 55 0c             	mov    0xc(%ebp),%edx
80106b8c:	8b 45 08             	mov    0x8(%ebp),%eax
80106b8f:	31 c9                	xor    %ecx,%ecx
80106b91:	01 da                	add    %ebx,%edx
80106b93:	e8 c8 fb ff ff       	call   80106760 <walkpgdir>
80106b98:	85 c0                	test   %eax,%eax
80106b9a:	74 4e                	je     80106bea <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106b9c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106b9e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106ba1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106ba6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106bab:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106bb1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106bb4:	01 d9                	add    %ebx,%ecx
80106bb6:	05 00 00 00 80       	add    $0x80000000,%eax
80106bbb:	57                   	push   %edi
80106bbc:	51                   	push   %ecx
80106bbd:	50                   	push   %eax
80106bbe:	ff 75 10             	pushl  0x10(%ebp)
80106bc1:	e8 ea ae ff ff       	call   80101ab0 <readi>
80106bc6:	83 c4 10             	add    $0x10,%esp
80106bc9:	39 f8                	cmp    %edi,%eax
80106bcb:	74 ab                	je     80106b78 <loaduvm+0x28>
}
80106bcd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106bd5:	5b                   	pop    %ebx
80106bd6:	5e                   	pop    %esi
80106bd7:	5f                   	pop    %edi
80106bd8:	5d                   	pop    %ebp
80106bd9:	c3                   	ret    
80106bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106be0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106be3:	31 c0                	xor    %eax,%eax
}
80106be5:	5b                   	pop    %ebx
80106be6:	5e                   	pop    %esi
80106be7:	5f                   	pop    %edi
80106be8:	5d                   	pop    %ebp
80106be9:	c3                   	ret    
      panic("loaduvm: address should exist");
80106bea:	83 ec 0c             	sub    $0xc,%esp
80106bed:	68 cf 79 10 80       	push   $0x801079cf
80106bf2:	e8 69 98 ff ff       	call   80100460 <panic>
    panic("loaduvm: addr must be page aligned");
80106bf7:	83 ec 0c             	sub    $0xc,%esp
80106bfa:	68 70 7a 10 80       	push   $0x80107a70
80106bff:	e8 5c 98 ff ff       	call   80100460 <panic>
80106c04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106c10 <allocuvm>:
{
80106c10:	55                   	push   %ebp
80106c11:	89 e5                	mov    %esp,%ebp
80106c13:	57                   	push   %edi
80106c14:	56                   	push   %esi
80106c15:	53                   	push   %ebx
80106c16:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106c19:	8b 7d 10             	mov    0x10(%ebp),%edi
80106c1c:	85 ff                	test   %edi,%edi
80106c1e:	0f 88 8e 00 00 00    	js     80106cb2 <allocuvm+0xa2>
  if(newsz < oldsz)
80106c24:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106c27:	0f 82 93 00 00 00    	jb     80106cc0 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
80106c2d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106c30:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106c36:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106c3c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106c3f:	0f 86 7e 00 00 00    	jbe    80106cc3 <allocuvm+0xb3>
80106c45:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106c48:	8b 7d 08             	mov    0x8(%ebp),%edi
80106c4b:	eb 42                	jmp    80106c8f <allocuvm+0x7f>
80106c4d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106c50:	83 ec 04             	sub    $0x4,%esp
80106c53:	68 00 10 00 00       	push   $0x1000
80106c58:	6a 00                	push   $0x0
80106c5a:	50                   	push   %eax
80106c5b:	e8 80 d9 ff ff       	call   801045e0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106c60:	58                   	pop    %eax
80106c61:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106c67:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c6c:	5a                   	pop    %edx
80106c6d:	6a 06                	push   $0x6
80106c6f:	50                   	push   %eax
80106c70:	89 da                	mov    %ebx,%edx
80106c72:	89 f8                	mov    %edi,%eax
80106c74:	e8 67 fb ff ff       	call   801067e0 <mappages>
80106c79:	83 c4 10             	add    $0x10,%esp
80106c7c:	85 c0                	test   %eax,%eax
80106c7e:	78 50                	js     80106cd0 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80106c80:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c86:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106c89:	0f 86 81 00 00 00    	jbe    80106d10 <allocuvm+0x100>
    mem = kalloc();
80106c8f:	e8 bc b9 ff ff       	call   80102650 <kalloc>
    if(mem == 0){
80106c94:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106c96:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106c98:	75 b6                	jne    80106c50 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106c9a:	83 ec 0c             	sub    $0xc,%esp
80106c9d:	68 ed 79 10 80       	push   $0x801079ed
80106ca2:	e8 89 9a ff ff       	call   80100730 <cprintf>
  if(newsz >= oldsz)
80106ca7:	83 c4 10             	add    $0x10,%esp
80106caa:	8b 45 0c             	mov    0xc(%ebp),%eax
80106cad:	39 45 10             	cmp    %eax,0x10(%ebp)
80106cb0:	77 6e                	ja     80106d20 <allocuvm+0x110>
}
80106cb2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106cb5:	31 ff                	xor    %edi,%edi
}
80106cb7:	89 f8                	mov    %edi,%eax
80106cb9:	5b                   	pop    %ebx
80106cba:	5e                   	pop    %esi
80106cbb:	5f                   	pop    %edi
80106cbc:	5d                   	pop    %ebp
80106cbd:	c3                   	ret    
80106cbe:	66 90                	xchg   %ax,%ax
    return oldsz;
80106cc0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106cc3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cc6:	89 f8                	mov    %edi,%eax
80106cc8:	5b                   	pop    %ebx
80106cc9:	5e                   	pop    %esi
80106cca:	5f                   	pop    %edi
80106ccb:	5d                   	pop    %ebp
80106ccc:	c3                   	ret    
80106ccd:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106cd0:	83 ec 0c             	sub    $0xc,%esp
80106cd3:	68 05 7a 10 80       	push   $0x80107a05
80106cd8:	e8 53 9a ff ff       	call   80100730 <cprintf>
  if(newsz >= oldsz)
80106cdd:	83 c4 10             	add    $0x10,%esp
80106ce0:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ce3:	39 45 10             	cmp    %eax,0x10(%ebp)
80106ce6:	76 0d                	jbe    80106cf5 <allocuvm+0xe5>
80106ce8:	89 c1                	mov    %eax,%ecx
80106cea:	8b 55 10             	mov    0x10(%ebp),%edx
80106ced:	8b 45 08             	mov    0x8(%ebp),%eax
80106cf0:	e8 7b fb ff ff       	call   80106870 <deallocuvm.part.0>
      kfree(mem);
80106cf5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106cf8:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106cfa:	56                   	push   %esi
80106cfb:	e8 a0 b7 ff ff       	call   801024a0 <kfree>
      return 0;
80106d00:	83 c4 10             	add    $0x10,%esp
}
80106d03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d06:	89 f8                	mov    %edi,%eax
80106d08:	5b                   	pop    %ebx
80106d09:	5e                   	pop    %esi
80106d0a:	5f                   	pop    %edi
80106d0b:	5d                   	pop    %ebp
80106d0c:	c3                   	ret    
80106d0d:	8d 76 00             	lea    0x0(%esi),%esi
80106d10:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106d13:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d16:	5b                   	pop    %ebx
80106d17:	89 f8                	mov    %edi,%eax
80106d19:	5e                   	pop    %esi
80106d1a:	5f                   	pop    %edi
80106d1b:	5d                   	pop    %ebp
80106d1c:	c3                   	ret    
80106d1d:	8d 76 00             	lea    0x0(%esi),%esi
80106d20:	89 c1                	mov    %eax,%ecx
80106d22:	8b 55 10             	mov    0x10(%ebp),%edx
80106d25:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106d28:	31 ff                	xor    %edi,%edi
80106d2a:	e8 41 fb ff ff       	call   80106870 <deallocuvm.part.0>
80106d2f:	eb 92                	jmp    80106cc3 <allocuvm+0xb3>
80106d31:	eb 0d                	jmp    80106d40 <deallocuvm>
80106d33:	90                   	nop
80106d34:	90                   	nop
80106d35:	90                   	nop
80106d36:	90                   	nop
80106d37:	90                   	nop
80106d38:	90                   	nop
80106d39:	90                   	nop
80106d3a:	90                   	nop
80106d3b:	90                   	nop
80106d3c:	90                   	nop
80106d3d:	90                   	nop
80106d3e:	90                   	nop
80106d3f:	90                   	nop

80106d40 <deallocuvm>:
{
80106d40:	55                   	push   %ebp
80106d41:	89 e5                	mov    %esp,%ebp
80106d43:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d46:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106d49:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106d4c:	39 d1                	cmp    %edx,%ecx
80106d4e:	73 10                	jae    80106d60 <deallocuvm+0x20>
}
80106d50:	5d                   	pop    %ebp
80106d51:	e9 1a fb ff ff       	jmp    80106870 <deallocuvm.part.0>
80106d56:	8d 76 00             	lea    0x0(%esi),%esi
80106d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106d60:	89 d0                	mov    %edx,%eax
80106d62:	5d                   	pop    %ebp
80106d63:	c3                   	ret    
80106d64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106d70 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106d70:	55                   	push   %ebp
80106d71:	89 e5                	mov    %esp,%ebp
80106d73:	57                   	push   %edi
80106d74:	56                   	push   %esi
80106d75:	53                   	push   %ebx
80106d76:	83 ec 0c             	sub    $0xc,%esp
80106d79:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106d7c:	85 f6                	test   %esi,%esi
80106d7e:	74 59                	je     80106dd9 <freevm+0x69>
80106d80:	31 c9                	xor    %ecx,%ecx
80106d82:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106d87:	89 f0                	mov    %esi,%eax
80106d89:	e8 e2 fa ff ff       	call   80106870 <deallocuvm.part.0>
80106d8e:	89 f3                	mov    %esi,%ebx
80106d90:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106d96:	eb 0f                	jmp    80106da7 <freevm+0x37>
80106d98:	90                   	nop
80106d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106da0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106da3:	39 fb                	cmp    %edi,%ebx
80106da5:	74 23                	je     80106dca <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106da7:	8b 03                	mov    (%ebx),%eax
80106da9:	a8 01                	test   $0x1,%al
80106dab:	74 f3                	je     80106da0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106dad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106db2:	83 ec 0c             	sub    $0xc,%esp
80106db5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106db8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106dbd:	50                   	push   %eax
80106dbe:	e8 dd b6 ff ff       	call   801024a0 <kfree>
80106dc3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106dc6:	39 fb                	cmp    %edi,%ebx
80106dc8:	75 dd                	jne    80106da7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106dca:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106dcd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106dd0:	5b                   	pop    %ebx
80106dd1:	5e                   	pop    %esi
80106dd2:	5f                   	pop    %edi
80106dd3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106dd4:	e9 c7 b6 ff ff       	jmp    801024a0 <kfree>
    panic("freevm: no pgdir");
80106dd9:	83 ec 0c             	sub    $0xc,%esp
80106ddc:	68 21 7a 10 80       	push   $0x80107a21
80106de1:	e8 7a 96 ff ff       	call   80100460 <panic>
80106de6:	8d 76 00             	lea    0x0(%esi),%esi
80106de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106df0 <setupkvm>:
{
80106df0:	55                   	push   %ebp
80106df1:	89 e5                	mov    %esp,%ebp
80106df3:	56                   	push   %esi
80106df4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106df5:	e8 56 b8 ff ff       	call   80102650 <kalloc>
80106dfa:	85 c0                	test   %eax,%eax
80106dfc:	89 c6                	mov    %eax,%esi
80106dfe:	74 42                	je     80106e42 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80106e00:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106e03:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106e08:	68 00 10 00 00       	push   $0x1000
80106e0d:	6a 00                	push   $0x0
80106e0f:	50                   	push   %eax
80106e10:	e8 cb d7 ff ff       	call   801045e0 <memset>
80106e15:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106e18:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106e1b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106e1e:	83 ec 08             	sub    $0x8,%esp
80106e21:	8b 13                	mov    (%ebx),%edx
80106e23:	ff 73 0c             	pushl  0xc(%ebx)
80106e26:	50                   	push   %eax
80106e27:	29 c1                	sub    %eax,%ecx
80106e29:	89 f0                	mov    %esi,%eax
80106e2b:	e8 b0 f9 ff ff       	call   801067e0 <mappages>
80106e30:	83 c4 10             	add    $0x10,%esp
80106e33:	85 c0                	test   %eax,%eax
80106e35:	78 19                	js     80106e50 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106e37:	83 c3 10             	add    $0x10,%ebx
80106e3a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106e40:	75 d6                	jne    80106e18 <setupkvm+0x28>
}
80106e42:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106e45:	89 f0                	mov    %esi,%eax
80106e47:	5b                   	pop    %ebx
80106e48:	5e                   	pop    %esi
80106e49:	5d                   	pop    %ebp
80106e4a:	c3                   	ret    
80106e4b:	90                   	nop
80106e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106e50:	83 ec 0c             	sub    $0xc,%esp
80106e53:	56                   	push   %esi
      return 0;
80106e54:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80106e56:	e8 15 ff ff ff       	call   80106d70 <freevm>
      return 0;
80106e5b:	83 c4 10             	add    $0x10,%esp
}
80106e5e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106e61:	89 f0                	mov    %esi,%eax
80106e63:	5b                   	pop    %ebx
80106e64:	5e                   	pop    %esi
80106e65:	5d                   	pop    %ebp
80106e66:	c3                   	ret    
80106e67:	89 f6                	mov    %esi,%esi
80106e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e70 <kvmalloc>:
{
80106e70:	55                   	push   %ebp
80106e71:	89 e5                	mov    %esp,%ebp
80106e73:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106e76:	e8 75 ff ff ff       	call   80106df0 <setupkvm>
80106e7b:	a3 e4 55 11 80       	mov    %eax,0x801155e4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106e80:	05 00 00 00 80       	add    $0x80000000,%eax
80106e85:	0f 22 d8             	mov    %eax,%cr3
}
80106e88:	c9                   	leave  
80106e89:	c3                   	ret    
80106e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106e90 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106e90:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106e91:	31 c9                	xor    %ecx,%ecx
{
80106e93:	89 e5                	mov    %esp,%ebp
80106e95:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106e98:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e9b:	8b 45 08             	mov    0x8(%ebp),%eax
80106e9e:	e8 bd f8 ff ff       	call   80106760 <walkpgdir>
  if(pte == 0)
80106ea3:	85 c0                	test   %eax,%eax
80106ea5:	74 05                	je     80106eac <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106ea7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106eaa:	c9                   	leave  
80106eab:	c3                   	ret    
    panic("clearpteu");
80106eac:	83 ec 0c             	sub    $0xc,%esp
80106eaf:	68 32 7a 10 80       	push   $0x80107a32
80106eb4:	e8 a7 95 ff ff       	call   80100460 <panic>
80106eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ec0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106ec0:	55                   	push   %ebp
80106ec1:	89 e5                	mov    %esp,%ebp
80106ec3:	57                   	push   %edi
80106ec4:	56                   	push   %esi
80106ec5:	53                   	push   %ebx
80106ec6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106ec9:	e8 22 ff ff ff       	call   80106df0 <setupkvm>
80106ece:	85 c0                	test   %eax,%eax
80106ed0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106ed3:	0f 84 9f 00 00 00    	je     80106f78 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106ed9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106edc:	85 c9                	test   %ecx,%ecx
80106ede:	0f 84 94 00 00 00    	je     80106f78 <copyuvm+0xb8>
80106ee4:	31 ff                	xor    %edi,%edi
80106ee6:	eb 4a                	jmp    80106f32 <copyuvm+0x72>
80106ee8:	90                   	nop
80106ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106ef0:	83 ec 04             	sub    $0x4,%esp
80106ef3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80106ef9:	68 00 10 00 00       	push   $0x1000
80106efe:	53                   	push   %ebx
80106eff:	50                   	push   %eax
80106f00:	e8 8b d7 ff ff       	call   80104690 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106f05:	58                   	pop    %eax
80106f06:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106f0c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f11:	5a                   	pop    %edx
80106f12:	ff 75 e4             	pushl  -0x1c(%ebp)
80106f15:	50                   	push   %eax
80106f16:	89 fa                	mov    %edi,%edx
80106f18:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f1b:	e8 c0 f8 ff ff       	call   801067e0 <mappages>
80106f20:	83 c4 10             	add    $0x10,%esp
80106f23:	85 c0                	test   %eax,%eax
80106f25:	78 61                	js     80106f88 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80106f27:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106f2d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106f30:	76 46                	jbe    80106f78 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106f32:	8b 45 08             	mov    0x8(%ebp),%eax
80106f35:	31 c9                	xor    %ecx,%ecx
80106f37:	89 fa                	mov    %edi,%edx
80106f39:	e8 22 f8 ff ff       	call   80106760 <walkpgdir>
80106f3e:	85 c0                	test   %eax,%eax
80106f40:	74 61                	je     80106fa3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80106f42:	8b 00                	mov    (%eax),%eax
80106f44:	a8 01                	test   $0x1,%al
80106f46:	74 4e                	je     80106f96 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80106f48:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
80106f4a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
80106f4f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80106f55:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80106f58:	e8 f3 b6 ff ff       	call   80102650 <kalloc>
80106f5d:	85 c0                	test   %eax,%eax
80106f5f:	89 c6                	mov    %eax,%esi
80106f61:	75 8d                	jne    80106ef0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80106f63:	83 ec 0c             	sub    $0xc,%esp
80106f66:	ff 75 e0             	pushl  -0x20(%ebp)
80106f69:	e8 02 fe ff ff       	call   80106d70 <freevm>
  return 0;
80106f6e:	83 c4 10             	add    $0x10,%esp
80106f71:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80106f78:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f7b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f7e:	5b                   	pop    %ebx
80106f7f:	5e                   	pop    %esi
80106f80:	5f                   	pop    %edi
80106f81:	5d                   	pop    %ebp
80106f82:	c3                   	ret    
80106f83:	90                   	nop
80106f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80106f88:	83 ec 0c             	sub    $0xc,%esp
80106f8b:	56                   	push   %esi
80106f8c:	e8 0f b5 ff ff       	call   801024a0 <kfree>
      goto bad;
80106f91:	83 c4 10             	add    $0x10,%esp
80106f94:	eb cd                	jmp    80106f63 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80106f96:	83 ec 0c             	sub    $0xc,%esp
80106f99:	68 56 7a 10 80       	push   $0x80107a56
80106f9e:	e8 bd 94 ff ff       	call   80100460 <panic>
      panic("copyuvm: pte should exist");
80106fa3:	83 ec 0c             	sub    $0xc,%esp
80106fa6:	68 3c 7a 10 80       	push   $0x80107a3c
80106fab:	e8 b0 94 ff ff       	call   80100460 <panic>

80106fb0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106fb0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106fb1:	31 c9                	xor    %ecx,%ecx
{
80106fb3:	89 e5                	mov    %esp,%ebp
80106fb5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106fb8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106fbb:	8b 45 08             	mov    0x8(%ebp),%eax
80106fbe:	e8 9d f7 ff ff       	call   80106760 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106fc3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80106fc5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80106fc6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80106fc8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80106fcd:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80106fd0:	05 00 00 00 80       	add    $0x80000000,%eax
80106fd5:	83 fa 05             	cmp    $0x5,%edx
80106fd8:	ba 00 00 00 00       	mov    $0x0,%edx
80106fdd:	0f 45 c2             	cmovne %edx,%eax
}
80106fe0:	c3                   	ret    
80106fe1:	eb 0d                	jmp    80106ff0 <copyout>
80106fe3:	90                   	nop
80106fe4:	90                   	nop
80106fe5:	90                   	nop
80106fe6:	90                   	nop
80106fe7:	90                   	nop
80106fe8:	90                   	nop
80106fe9:	90                   	nop
80106fea:	90                   	nop
80106feb:	90                   	nop
80106fec:	90                   	nop
80106fed:	90                   	nop
80106fee:	90                   	nop
80106fef:	90                   	nop

80106ff0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106ff0:	55                   	push   %ebp
80106ff1:	89 e5                	mov    %esp,%ebp
80106ff3:	57                   	push   %edi
80106ff4:	56                   	push   %esi
80106ff5:	53                   	push   %ebx
80106ff6:	83 ec 1c             	sub    $0x1c,%esp
80106ff9:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106ffc:	8b 55 0c             	mov    0xc(%ebp),%edx
80106fff:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107002:	85 db                	test   %ebx,%ebx
80107004:	75 40                	jne    80107046 <copyout+0x56>
80107006:	eb 70                	jmp    80107078 <copyout+0x88>
80107008:	90                   	nop
80107009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107010:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107013:	89 f1                	mov    %esi,%ecx
80107015:	29 d1                	sub    %edx,%ecx
80107017:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010701d:	39 d9                	cmp    %ebx,%ecx
8010701f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107022:	29 f2                	sub    %esi,%edx
80107024:	83 ec 04             	sub    $0x4,%esp
80107027:	01 d0                	add    %edx,%eax
80107029:	51                   	push   %ecx
8010702a:	57                   	push   %edi
8010702b:	50                   	push   %eax
8010702c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010702f:	e8 5c d6 ff ff       	call   80104690 <memmove>
    len -= n;
    buf += n;
80107034:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107037:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
8010703a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107040:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107042:	29 cb                	sub    %ecx,%ebx
80107044:	74 32                	je     80107078 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107046:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107048:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010704b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010704e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107054:	56                   	push   %esi
80107055:	ff 75 08             	pushl  0x8(%ebp)
80107058:	e8 53 ff ff ff       	call   80106fb0 <uva2ka>
    if(pa0 == 0)
8010705d:	83 c4 10             	add    $0x10,%esp
80107060:	85 c0                	test   %eax,%eax
80107062:	75 ac                	jne    80107010 <copyout+0x20>
  }
  return 0;
}
80107064:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107067:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010706c:	5b                   	pop    %ebx
8010706d:	5e                   	pop    %esi
8010706e:	5f                   	pop    %edi
8010706f:	5d                   	pop    %ebp
80107070:	c3                   	ret    
80107071:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107078:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010707b:	31 c0                	xor    %eax,%eax
}
8010707d:	5b                   	pop    %ebx
8010707e:	5e                   	pop    %esi
8010707f:	5f                   	pop    %edi
80107080:	5d                   	pop    %ebp
80107081:	c3                   	ret    
