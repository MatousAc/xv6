
user/_iotest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "user/user.h"


int main(void) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  printf("This should go to the screen.\n");
   f:	83 ec 0c             	sub    $0xc,%esp
  12:	68 08 08 00 00       	push   $0x808
  17:	e8 44 06 00 00       	call   660 <printf>
  int fd;
  fd = open("README", O_RDONLY);
  1c:	58                   	pop    %eax
  1d:	5a                   	pop    %edx
  1e:	6a 00                	push   $0x0
  20:	68 70 08 00 00       	push   $0x870
  25:	e8 e8 02 00 00       	call   312 <open>
  printf("The fd I got for README = %d\n", fd);
  2a:	59                   	pop    %ecx
  fd = open("README", O_RDONLY);
  2b:	89 c3                	mov    %eax,%ebx
  printf("The fd I got for README = %d\n", fd);
  2d:	58                   	pop    %eax
  2e:	53                   	push   %ebx
  2f:	68 77 08 00 00       	push   $0x877
  34:	e8 27 06 00 00       	call   660 <printf>
  close(fd);
  39:	89 1c 24             	mov    %ebx,(%esp)
  3c:	e8 b9 02 00 00       	call   2fa <close>
  close(1);
  41:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  48:	e8 ad 02 00 00       	call   2fa <close>
  fd = open("output.txt", O_CREATE | O_WRONLY);
  4d:	58                   	pop    %eax
  4e:	5a                   	pop    %edx
  4f:	68 01 02 00 00       	push   $0x201
  54:	68 95 08 00 00       	push   $0x895
  59:	e8 b4 02 00 00       	call   312 <open>
  printf("Hello There! This is the IO Test!\n");
  5e:	c7 04 24 28 08 00 00 	movl   $0x828,(%esp)
  fd = open("output.txt", O_CREATE | O_WRONLY);
  65:	89 c3                	mov    %eax,%ebx
  printf("Hello There! This is the IO Test!\n");
  67:	e8 f4 05 00 00       	call   660 <printf>
  printf("The fd I got for output.txt = %d\n", fd);
  6c:	59                   	pop    %ecx
  6d:	58                   	pop    %eax
  6e:	53                   	push   %ebx
  6f:	68 4c 08 00 00       	push   $0x84c
  74:	e8 e7 05 00 00       	call   660 <printf>
  exit();
  79:	e8 54 02 00 00       	call   2d2 <exit>
  7e:	66 90                	xchg   %ax,%ax

00000080 <strcpy>:
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	53                   	push   %ebx
  84:	8b 45 08             	mov    0x8(%ebp),%eax
  87:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8a:	89 c2                	mov    %eax,%edx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  90:	83 c1 01             	add    $0x1,%ecx
  93:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  97:	83 c2 01             	add    $0x1,%edx
  9a:	84 db                	test   %bl,%bl
  9c:	88 5a ff             	mov    %bl,-0x1(%edx)
  9f:	75 ef                	jne    90 <strcpy+0x10>
  a1:	5b                   	pop    %ebx
  a2:	5d                   	pop    %ebp
  a3:	c3                   	ret    
  a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000b0 <strcmp>:
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	8b 55 08             	mov    0x8(%ebp),%edx
  b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ba:	0f b6 02             	movzbl (%edx),%eax
  bd:	0f b6 19             	movzbl (%ecx),%ebx
  c0:	84 c0                	test   %al,%al
  c2:	75 1c                	jne    e0 <strcmp+0x30>
  c4:	eb 2a                	jmp    f0 <strcmp+0x40>
  c6:	8d 76 00             	lea    0x0(%esi),%esi
  c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  d0:	83 c2 01             	add    $0x1,%edx
  d3:	0f b6 02             	movzbl (%edx),%eax
  d6:	83 c1 01             	add    $0x1,%ecx
  d9:	0f b6 19             	movzbl (%ecx),%ebx
  dc:	84 c0                	test   %al,%al
  de:	74 10                	je     f0 <strcmp+0x40>
  e0:	38 d8                	cmp    %bl,%al
  e2:	74 ec                	je     d0 <strcmp+0x20>
  e4:	29 d8                	sub    %ebx,%eax
  e6:	5b                   	pop    %ebx
  e7:	5d                   	pop    %ebp
  e8:	c3                   	ret    
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  f0:	31 c0                	xor    %eax,%eax
  f2:	29 d8                	sub    %ebx,%eax
  f4:	5b                   	pop    %ebx
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strlen>:
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 4d 08             	mov    0x8(%ebp),%ecx
 106:	80 39 00             	cmpb   $0x0,(%ecx)
 109:	74 15                	je     120 <strlen+0x20>
 10b:	31 d2                	xor    %edx,%edx
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	83 c2 01             	add    $0x1,%edx
 113:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 117:	89 d0                	mov    %edx,%eax
 119:	75 f5                	jne    110 <strlen+0x10>
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    
 11d:	8d 76 00             	lea    0x0(%esi),%esi
 120:	31 c0                	xor    %eax,%eax
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    
 124:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 12a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000130 <memset>:
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	8b 55 08             	mov    0x8(%ebp),%edx
 137:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	89 d7                	mov    %edx,%edi
 13f:	fc                   	cld    
 140:	f3 aa                	rep stos %al,%es:(%edi)
 142:	89 d0                	mov    %edx,%eax
 144:	5f                   	pop    %edi
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	89 f6                	mov    %esi,%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <strchr>:
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 45 08             	mov    0x8(%ebp),%eax
 157:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 15a:	0f b6 10             	movzbl (%eax),%edx
 15d:	84 d2                	test   %dl,%dl
 15f:	74 1d                	je     17e <strchr+0x2e>
 161:	38 d3                	cmp    %dl,%bl
 163:	89 d9                	mov    %ebx,%ecx
 165:	75 0d                	jne    174 <strchr+0x24>
 167:	eb 17                	jmp    180 <strchr+0x30>
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 170:	38 ca                	cmp    %cl,%dl
 172:	74 0c                	je     180 <strchr+0x30>
 174:	83 c0 01             	add    $0x1,%eax
 177:	0f b6 10             	movzbl (%eax),%edx
 17a:	84 d2                	test   %dl,%dl
 17c:	75 f2                	jne    170 <strchr+0x20>
 17e:	31 c0                	xor    %eax,%eax
 180:	5b                   	pop    %ebx
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
 183:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000190 <gets>:
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
 195:	53                   	push   %ebx
 196:	31 f6                	xor    %esi,%esi
 198:	89 f3                	mov    %esi,%ebx
 19a:	83 ec 1c             	sub    $0x1c,%esp
 19d:	8b 7d 08             	mov    0x8(%ebp),%edi
 1a0:	eb 2f                	jmp    1d1 <gets+0x41>
 1a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1a8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1ab:	83 ec 04             	sub    $0x4,%esp
 1ae:	6a 01                	push   $0x1
 1b0:	50                   	push   %eax
 1b1:	6a 00                	push   $0x0
 1b3:	e8 32 01 00 00       	call   2ea <read>
 1b8:	83 c4 10             	add    $0x10,%esp
 1bb:	85 c0                	test   %eax,%eax
 1bd:	7e 1c                	jle    1db <gets+0x4b>
 1bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1c3:	83 c7 01             	add    $0x1,%edi
 1c6:	88 47 ff             	mov    %al,-0x1(%edi)
 1c9:	3c 0a                	cmp    $0xa,%al
 1cb:	74 23                	je     1f0 <gets+0x60>
 1cd:	3c 0d                	cmp    $0xd,%al
 1cf:	74 1f                	je     1f0 <gets+0x60>
 1d1:	83 c3 01             	add    $0x1,%ebx
 1d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1d7:	89 fe                	mov    %edi,%esi
 1d9:	7c cd                	jl     1a8 <gets+0x18>
 1db:	89 f3                	mov    %esi,%ebx
 1dd:	8b 45 08             	mov    0x8(%ebp),%eax
 1e0:	c6 03 00             	movb   $0x0,(%ebx)
 1e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e6:	5b                   	pop    %ebx
 1e7:	5e                   	pop    %esi
 1e8:	5f                   	pop    %edi
 1e9:	5d                   	pop    %ebp
 1ea:	c3                   	ret    
 1eb:	90                   	nop
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f0:	8b 75 08             	mov    0x8(%ebp),%esi
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	01 de                	add    %ebx,%esi
 1f8:	89 f3                	mov    %esi,%ebx
 1fa:	c6 03 00             	movb   $0x0,(%ebx)
 1fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 200:	5b                   	pop    %ebx
 201:	5e                   	pop    %esi
 202:	5f                   	pop    %edi
 203:	5d                   	pop    %ebp
 204:	c3                   	ret    
 205:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <stat>:
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	56                   	push   %esi
 214:	53                   	push   %ebx
 215:	83 ec 08             	sub    $0x8,%esp
 218:	6a 00                	push   $0x0
 21a:	ff 75 08             	pushl  0x8(%ebp)
 21d:	e8 f0 00 00 00       	call   312 <open>
 222:	83 c4 10             	add    $0x10,%esp
 225:	85 c0                	test   %eax,%eax
 227:	78 27                	js     250 <stat+0x40>
 229:	83 ec 08             	sub    $0x8,%esp
 22c:	ff 75 0c             	pushl  0xc(%ebp)
 22f:	89 c3                	mov    %eax,%ebx
 231:	50                   	push   %eax
 232:	e8 f3 00 00 00       	call   32a <fstat>
 237:	89 1c 24             	mov    %ebx,(%esp)
 23a:	89 c6                	mov    %eax,%esi
 23c:	e8 b9 00 00 00       	call   2fa <close>
 241:	83 c4 10             	add    $0x10,%esp
 244:	8d 65 f8             	lea    -0x8(%ebp),%esp
 247:	89 f0                	mov    %esi,%eax
 249:	5b                   	pop    %ebx
 24a:	5e                   	pop    %esi
 24b:	5d                   	pop    %ebp
 24c:	c3                   	ret    
 24d:	8d 76 00             	lea    0x0(%esi),%esi
 250:	be ff ff ff ff       	mov    $0xffffffff,%esi
 255:	eb ed                	jmp    244 <stat+0x34>
 257:	89 f6                	mov    %esi,%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <atoi>:
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 4d 08             	mov    0x8(%ebp),%ecx
 267:	0f be 11             	movsbl (%ecx),%edx
 26a:	8d 42 d0             	lea    -0x30(%edx),%eax
 26d:	3c 09                	cmp    $0x9,%al
 26f:	b8 00 00 00 00       	mov    $0x0,%eax
 274:	77 1f                	ja     295 <atoi+0x35>
 276:	8d 76 00             	lea    0x0(%esi),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 280:	8d 04 80             	lea    (%eax,%eax,4),%eax
 283:	83 c1 01             	add    $0x1,%ecx
 286:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 28a:	0f be 11             	movsbl (%ecx),%edx
 28d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 290:	80 fb 09             	cmp    $0x9,%bl
 293:	76 eb                	jbe    280 <atoi+0x20>
 295:	5b                   	pop    %ebx
 296:	5d                   	pop    %ebp
 297:	c3                   	ret    
 298:	90                   	nop
 299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002a0 <memmove>:
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	53                   	push   %ebx
 2a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 2a8:	8b 45 08             	mov    0x8(%ebp),%eax
 2ab:	8b 75 0c             	mov    0xc(%ebp),%esi
 2ae:	85 db                	test   %ebx,%ebx
 2b0:	7e 14                	jle    2c6 <memmove+0x26>
 2b2:	31 d2                	xor    %edx,%edx
 2b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2bf:	83 c2 01             	add    $0x1,%edx
 2c2:	39 d3                	cmp    %edx,%ebx
 2c4:	75 f2                	jne    2b8 <memmove+0x18>
 2c6:	5b                   	pop    %ebx
 2c7:	5e                   	pop    %esi
 2c8:	5d                   	pop    %ebp
 2c9:	c3                   	ret    

000002ca <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ca:	b8 01 00 00 00       	mov    $0x1,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <exit>:
SYSCALL(exit)
 2d2:	b8 02 00 00 00       	mov    $0x2,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <wait>:
SYSCALL(wait)
 2da:	b8 03 00 00 00       	mov    $0x3,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <pipe>:
SYSCALL(pipe)
 2e2:	b8 04 00 00 00       	mov    $0x4,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <read>:
SYSCALL(read)
 2ea:	b8 05 00 00 00       	mov    $0x5,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <write>:
SYSCALL(write)
 2f2:	b8 10 00 00 00       	mov    $0x10,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <close>:
SYSCALL(close)
 2fa:	b8 15 00 00 00       	mov    $0x15,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <kill>:
SYSCALL(kill)
 302:	b8 06 00 00 00       	mov    $0x6,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <exec>:
SYSCALL(exec)
 30a:	b8 07 00 00 00       	mov    $0x7,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <open>:
SYSCALL(open)
 312:	b8 0f 00 00 00       	mov    $0xf,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <mknod>:
SYSCALL(mknod)
 31a:	b8 11 00 00 00       	mov    $0x11,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <unlink>:
SYSCALL(unlink)
 322:	b8 12 00 00 00       	mov    $0x12,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <fstat>:
SYSCALL(fstat)
 32a:	b8 08 00 00 00       	mov    $0x8,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <link>:
SYSCALL(link)
 332:	b8 13 00 00 00       	mov    $0x13,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <mkdir>:
SYSCALL(mkdir)
 33a:	b8 14 00 00 00       	mov    $0x14,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <chdir>:
SYSCALL(chdir)
 342:	b8 09 00 00 00       	mov    $0x9,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <dup>:
SYSCALL(dup)
 34a:	b8 0a 00 00 00       	mov    $0xa,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <getpid>:
SYSCALL(getpid)
 352:	b8 0b 00 00 00       	mov    $0xb,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <sbrk>:
SYSCALL(sbrk)
 35a:	b8 0c 00 00 00       	mov    $0xc,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <sleep>:
SYSCALL(sleep)
 362:	b8 0d 00 00 00       	mov    $0xd,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <uptime>:
SYSCALL(uptime)
 36a:	b8 0e 00 00 00       	mov    $0xe,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <cpuhalt>:
SYSCALL(cpuhalt)
 372:	b8 16 00 00 00       	mov    $0x16,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    
 37a:	66 90                	xchg   %ax,%ax
 37c:	66 90                	xchg   %ax,%ax
 37e:	66 90                	xchg   %ax,%ax

00000380 <printint.constprop.1>:
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	53                   	push   %ebx
 386:	89 d6                	mov    %edx,%esi
 388:	83 ec 3c             	sub    $0x3c,%esp
 38b:	85 c0                	test   %eax,%eax
 38d:	79 71                	jns    400 <printint.constprop.1+0x80>
 38f:	83 e1 01             	and    $0x1,%ecx
 392:	74 6c                	je     400 <printint.constprop.1+0x80>
 394:	f7 d8                	neg    %eax
 396:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 39d:	31 c9                	xor    %ecx,%ecx
 39f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3a2:	eb 06                	jmp    3aa <printint.constprop.1+0x2a>
 3a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3a8:	89 f9                	mov    %edi,%ecx
 3aa:	31 d2                	xor    %edx,%edx
 3ac:	8d 79 01             	lea    0x1(%ecx),%edi
 3af:	f7 f6                	div    %esi
 3b1:	0f b6 92 a8 08 00 00 	movzbl 0x8a8(%edx),%edx
 3b8:	85 c0                	test   %eax,%eax
 3ba:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
 3bd:	75 e9                	jne    3a8 <printint.constprop.1+0x28>
 3bf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3c2:	85 c0                	test   %eax,%eax
 3c4:	74 08                	je     3ce <printint.constprop.1+0x4e>
 3c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 3cb:	8d 79 02             	lea    0x2(%ecx),%edi
 3ce:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 3d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3d8:	0f b6 06             	movzbl (%esi),%eax
 3db:	83 ec 04             	sub    $0x4,%esp
 3de:	83 ee 01             	sub    $0x1,%esi
 3e1:	6a 01                	push   $0x1
 3e3:	53                   	push   %ebx
 3e4:	6a 01                	push   $0x1
 3e6:	88 45 d7             	mov    %al,-0x29(%ebp)
 3e9:	e8 04 ff ff ff       	call   2f2 <write>
 3ee:	83 c4 10             	add    $0x10,%esp
 3f1:	39 de                	cmp    %ebx,%esi
 3f3:	75 e3                	jne    3d8 <printint.constprop.1+0x58>
 3f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3f8:	5b                   	pop    %ebx
 3f9:	5e                   	pop    %esi
 3fa:	5f                   	pop    %edi
 3fb:	5d                   	pop    %ebp
 3fc:	c3                   	ret    
 3fd:	8d 76 00             	lea    0x0(%esi),%esi
 400:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 407:	eb 94                	jmp    39d <printint.constprop.1+0x1d>
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000410 <vprintf.constprop.0>:
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	89 d6                	mov    %edx,%esi
 418:	83 ec 2c             	sub    $0x2c,%esp
 41b:	0f b6 10             	movzbl (%eax),%edx
 41e:	84 d2                	test   %dl,%dl
 420:	0f 84 cd 00 00 00    	je     4f3 <vprintf.constprop.0+0xe3>
 426:	8d 58 01             	lea    0x1(%eax),%ebx
 429:	31 ff                	xor    %edi,%edi
 42b:	eb 31                	jmp    45e <vprintf.constprop.0+0x4e>
 42d:	8d 76 00             	lea    0x0(%esi),%esi
 430:	83 f8 25             	cmp    $0x25,%eax
 433:	0f 84 c7 00 00 00    	je     500 <vprintf.constprop.0+0xf0>
 439:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 43c:	83 ec 04             	sub    $0x4,%esp
 43f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 442:	6a 01                	push   $0x1
 444:	50                   	push   %eax
 445:	6a 01                	push   $0x1
 447:	e8 a6 fe ff ff       	call   2f2 <write>
 44c:	83 c4 10             	add    $0x10,%esp
 44f:	83 c3 01             	add    $0x1,%ebx
 452:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 456:	84 d2                	test   %dl,%dl
 458:	0f 84 95 00 00 00    	je     4f3 <vprintf.constprop.0+0xe3>
 45e:	85 ff                	test   %edi,%edi
 460:	0f b6 c2             	movzbl %dl,%eax
 463:	74 cb                	je     430 <vprintf.constprop.0+0x20>
 465:	83 ff 25             	cmp    $0x25,%edi
 468:	75 e5                	jne    44f <vprintf.constprop.0+0x3f>
 46a:	83 f8 64             	cmp    $0x64,%eax
 46d:	8d 7e 04             	lea    0x4(%esi),%edi
 470:	b9 01 00 00 00       	mov    $0x1,%ecx
 475:	0f 84 9a 00 00 00    	je     515 <vprintf.constprop.0+0x105>
 47b:	83 f8 6c             	cmp    $0x6c,%eax
 47e:	0f 84 8c 00 00 00    	je     510 <vprintf.constprop.0+0x100>
 484:	83 f8 78             	cmp    $0x78,%eax
 487:	0f 84 a3 00 00 00    	je     530 <vprintf.constprop.0+0x120>
 48d:	83 f8 70             	cmp    $0x70,%eax
 490:	0f 84 ca 00 00 00    	je     560 <vprintf.constprop.0+0x150>
 496:	83 f8 73             	cmp    $0x73,%eax
 499:	0f 84 39 01 00 00    	je     5d8 <vprintf.constprop.0+0x1c8>
 49f:	83 f8 63             	cmp    $0x63,%eax
 4a2:	0f 84 68 01 00 00    	je     610 <vprintf.constprop.0+0x200>
 4a8:	83 f8 25             	cmp    $0x25,%eax
 4ab:	0f 84 9f 00 00 00    	je     550 <vprintf.constprop.0+0x140>
 4b1:	8d 45 df             	lea    -0x21(%ebp),%eax
 4b4:	83 ec 04             	sub    $0x4,%esp
 4b7:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 4ba:	6a 01                	push   $0x1
 4bc:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 4c0:	50                   	push   %eax
 4c1:	6a 01                	push   $0x1
 4c3:	e8 2a fe ff ff       	call   2f2 <write>
 4c8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 4cc:	83 c4 0c             	add    $0xc,%esp
 4cf:	8d 45 e0             	lea    -0x20(%ebp),%eax
 4d2:	6a 01                	push   $0x1
 4d4:	88 55 e0             	mov    %dl,-0x20(%ebp)
 4d7:	50                   	push   %eax
 4d8:	6a 01                	push   $0x1
 4da:	83 c3 01             	add    $0x1,%ebx
 4dd:	31 ff                	xor    %edi,%edi
 4df:	e8 0e fe ff ff       	call   2f2 <write>
 4e4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4e8:	83 c4 10             	add    $0x10,%esp
 4eb:	84 d2                	test   %dl,%dl
 4ed:	0f 85 6b ff ff ff    	jne    45e <vprintf.constprop.0+0x4e>
 4f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4f6:	5b                   	pop    %ebx
 4f7:	5e                   	pop    %esi
 4f8:	5f                   	pop    %edi
 4f9:	5d                   	pop    %ebp
 4fa:	c3                   	ret    
 4fb:	90                   	nop
 4fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 500:	bf 25 00 00 00       	mov    $0x25,%edi
 505:	e9 45 ff ff ff       	jmp    44f <vprintf.constprop.0+0x3f>
 50a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 510:	8d 7e 04             	lea    0x4(%esi),%edi
 513:	31 c9                	xor    %ecx,%ecx
 515:	8b 06                	mov    (%esi),%eax
 517:	ba 0a 00 00 00       	mov    $0xa,%edx
 51c:	89 fe                	mov    %edi,%esi
 51e:	31 ff                	xor    %edi,%edi
 520:	e8 5b fe ff ff       	call   380 <printint.constprop.1>
 525:	e9 25 ff ff ff       	jmp    44f <vprintf.constprop.0+0x3f>
 52a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 530:	8b 06                	mov    (%esi),%eax
 532:	8d 7e 04             	lea    0x4(%esi),%edi
 535:	31 c9                	xor    %ecx,%ecx
 537:	ba 10 00 00 00       	mov    $0x10,%edx
 53c:	89 fe                	mov    %edi,%esi
 53e:	31 ff                	xor    %edi,%edi
 540:	e8 3b fe ff ff       	call   380 <printint.constprop.1>
 545:	e9 05 ff ff ff       	jmp    44f <vprintf.constprop.0+0x3f>
 54a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 550:	83 ec 04             	sub    $0x4,%esp
 553:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 556:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 559:	6a 01                	push   $0x1
 55b:	e9 77 ff ff ff       	jmp    4d7 <vprintf.constprop.0+0xc7>
 560:	8d 46 04             	lea    0x4(%esi),%eax
 563:	83 ec 04             	sub    $0x4,%esp
 566:	8b 3e                	mov    (%esi),%edi
 568:	6a 01                	push   $0x1
 56a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 56e:	be 08 00 00 00       	mov    $0x8,%esi
 573:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 576:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 579:	50                   	push   %eax
 57a:	6a 01                	push   $0x1
 57c:	e8 71 fd ff ff       	call   2f2 <write>
 581:	8d 45 e7             	lea    -0x19(%ebp),%eax
 584:	83 c4 0c             	add    $0xc,%esp
 587:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 58b:	6a 01                	push   $0x1
 58d:	50                   	push   %eax
 58e:	6a 01                	push   $0x1
 590:	e8 5d fd ff ff       	call   2f2 <write>
 595:	83 c4 10             	add    $0x10,%esp
 598:	90                   	nop
 599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5a0:	89 f8                	mov    %edi,%eax
 5a2:	83 ec 04             	sub    $0x4,%esp
 5a5:	c1 e7 04             	shl    $0x4,%edi
 5a8:	c1 e8 1c             	shr    $0x1c,%eax
 5ab:	6a 01                	push   $0x1
 5ad:	0f b6 80 a8 08 00 00 	movzbl 0x8a8(%eax),%eax
 5b4:	88 45 e5             	mov    %al,-0x1b(%ebp)
 5b7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5ba:	50                   	push   %eax
 5bb:	6a 01                	push   $0x1
 5bd:	e8 30 fd ff ff       	call   2f2 <write>
 5c2:	83 c4 10             	add    $0x10,%esp
 5c5:	83 ee 01             	sub    $0x1,%esi
 5c8:	75 d6                	jne    5a0 <vprintf.constprop.0+0x190>
 5ca:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 5cd:	31 ff                	xor    %edi,%edi
 5cf:	e9 7b fe ff ff       	jmp    44f <vprintf.constprop.0+0x3f>
 5d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5d8:	8b 3e                	mov    (%esi),%edi
 5da:	8d 46 04             	lea    0x4(%esi),%eax
 5dd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5e0:	85 ff                	test   %edi,%edi
 5e2:	74 50                	je     634 <vprintf.constprop.0+0x224>
 5e4:	0f b6 07             	movzbl (%edi),%eax
 5e7:	84 c0                	test   %al,%al
 5e9:	74 df                	je     5ca <vprintf.constprop.0+0x1ba>
 5eb:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 5ee:	66 90                	xchg   %ax,%ax
 5f0:	83 ec 04             	sub    $0x4,%esp
 5f3:	83 c7 01             	add    $0x1,%edi
 5f6:	88 45 e3             	mov    %al,-0x1d(%ebp)
 5f9:	6a 01                	push   $0x1
 5fb:	56                   	push   %esi
 5fc:	6a 01                	push   $0x1
 5fe:	e8 ef fc ff ff       	call   2f2 <write>
 603:	0f b6 07             	movzbl (%edi),%eax
 606:	83 c4 10             	add    $0x10,%esp
 609:	84 c0                	test   %al,%al
 60b:	75 e3                	jne    5f0 <vprintf.constprop.0+0x1e0>
 60d:	eb bb                	jmp    5ca <vprintf.constprop.0+0x1ba>
 60f:	90                   	nop
 610:	8b 06                	mov    (%esi),%eax
 612:	83 ec 04             	sub    $0x4,%esp
 615:	8d 7e 04             	lea    0x4(%esi),%edi
 618:	6a 01                	push   $0x1
 61a:	89 fe                	mov    %edi,%esi
 61c:	31 ff                	xor    %edi,%edi
 61e:	88 45 e2             	mov    %al,-0x1e(%ebp)
 621:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 624:	50                   	push   %eax
 625:	6a 01                	push   $0x1
 627:	e8 c6 fc ff ff       	call   2f2 <write>
 62c:	83 c4 10             	add    $0x10,%esp
 62f:	e9 1b fe ff ff       	jmp    44f <vprintf.constprop.0+0x3f>
 634:	bf a0 08 00 00       	mov    $0x8a0,%edi
 639:	b8 28 00 00 00       	mov    $0x28,%eax
 63e:	eb ab                	jmp    5eb <vprintf.constprop.0+0x1db>

00000640 <fprintf>:
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	83 ec 08             	sub    $0x8,%esp
 646:	8b 45 0c             	mov    0xc(%ebp),%eax
 649:	8d 55 10             	lea    0x10(%ebp),%edx
 64c:	e8 bf fd ff ff       	call   410 <vprintf.constprop.0>
 651:	c9                   	leave  
 652:	c3                   	ret    
 653:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000660 <printf>:
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	83 ec 08             	sub    $0x8,%esp
 666:	8b 45 08             	mov    0x8(%ebp),%eax
 669:	8d 55 0c             	lea    0xc(%ebp),%edx
 66c:	e8 9f fd ff ff       	call   410 <vprintf.constprop.0>
 671:	c9                   	leave  
 672:	c3                   	ret    
 673:	66 90                	xchg   %ax,%ax
 675:	66 90                	xchg   %ax,%ax
 677:	66 90                	xchg   %ax,%ax
 679:	66 90                	xchg   %ax,%ax
 67b:	66 90                	xchg   %ax,%ax
 67d:	66 90                	xchg   %ax,%ax
 67f:	90                   	nop

00000680 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 680:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 681:	a1 90 0b 00 00       	mov    0xb90,%eax
{
 686:	89 e5                	mov    %esp,%ebp
 688:	57                   	push   %edi
 689:	56                   	push   %esi
 68a:	53                   	push   %ebx
 68b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 68e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 698:	39 c8                	cmp    %ecx,%eax
 69a:	8b 10                	mov    (%eax),%edx
 69c:	73 32                	jae    6d0 <free+0x50>
 69e:	39 d1                	cmp    %edx,%ecx
 6a0:	72 04                	jb     6a6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a2:	39 d0                	cmp    %edx,%eax
 6a4:	72 32                	jb     6d8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6a6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6a9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ac:	39 fa                	cmp    %edi,%edx
 6ae:	74 30                	je     6e0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6b0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6b3:	8b 50 04             	mov    0x4(%eax),%edx
 6b6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6b9:	39 f1                	cmp    %esi,%ecx
 6bb:	74 3a                	je     6f7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6bd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 6bf:	a3 90 0b 00 00       	mov    %eax,0xb90
}
 6c4:	5b                   	pop    %ebx
 6c5:	5e                   	pop    %esi
 6c6:	5f                   	pop    %edi
 6c7:	5d                   	pop    %ebp
 6c8:	c3                   	ret    
 6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d0:	39 d0                	cmp    %edx,%eax
 6d2:	72 04                	jb     6d8 <free+0x58>
 6d4:	39 d1                	cmp    %edx,%ecx
 6d6:	72 ce                	jb     6a6 <free+0x26>
{
 6d8:	89 d0                	mov    %edx,%eax
 6da:	eb bc                	jmp    698 <free+0x18>
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 6e0:	03 72 04             	add    0x4(%edx),%esi
 6e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e6:	8b 10                	mov    (%eax),%edx
 6e8:	8b 12                	mov    (%edx),%edx
 6ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6ed:	8b 50 04             	mov    0x4(%eax),%edx
 6f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6f3:	39 f1                	cmp    %esi,%ecx
 6f5:	75 c6                	jne    6bd <free+0x3d>
    p->s.size += bp->s.size;
 6f7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6fa:	a3 90 0b 00 00       	mov    %eax,0xb90
    p->s.size += bp->s.size;
 6ff:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 702:	8b 53 f8             	mov    -0x8(%ebx),%edx
 705:	89 10                	mov    %edx,(%eax)
}
 707:	5b                   	pop    %ebx
 708:	5e                   	pop    %esi
 709:	5f                   	pop    %edi
 70a:	5d                   	pop    %ebp
 70b:	c3                   	ret    
 70c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000710 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	57                   	push   %edi
 714:	56                   	push   %esi
 715:	53                   	push   %ebx
 716:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 719:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 71c:	8b 15 90 0b 00 00    	mov    0xb90,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 722:	8d 78 07             	lea    0x7(%eax),%edi
 725:	c1 ef 03             	shr    $0x3,%edi
 728:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 72b:	85 d2                	test   %edx,%edx
 72d:	0f 84 9d 00 00 00    	je     7d0 <malloc+0xc0>
 733:	8b 02                	mov    (%edx),%eax
 735:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 738:	39 cf                	cmp    %ecx,%edi
 73a:	76 6c                	jbe    7a8 <malloc+0x98>
 73c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 742:	bb 00 10 00 00       	mov    $0x1000,%ebx
 747:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 74a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 751:	eb 0e                	jmp    761 <malloc+0x51>
 753:	90                   	nop
 754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 758:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 75a:	8b 48 04             	mov    0x4(%eax),%ecx
 75d:	39 f9                	cmp    %edi,%ecx
 75f:	73 47                	jae    7a8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 761:	39 05 90 0b 00 00    	cmp    %eax,0xb90
 767:	89 c2                	mov    %eax,%edx
 769:	75 ed                	jne    758 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 76b:	83 ec 0c             	sub    $0xc,%esp
 76e:	56                   	push   %esi
 76f:	e8 e6 fb ff ff       	call   35a <sbrk>
  if(p == (char*)-1)
 774:	83 c4 10             	add    $0x10,%esp
 777:	83 f8 ff             	cmp    $0xffffffff,%eax
 77a:	74 1c                	je     798 <malloc+0x88>
  hp->s.size = nu;
 77c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 77f:	83 ec 0c             	sub    $0xc,%esp
 782:	83 c0 08             	add    $0x8,%eax
 785:	50                   	push   %eax
 786:	e8 f5 fe ff ff       	call   680 <free>
  return freep;
 78b:	8b 15 90 0b 00 00    	mov    0xb90,%edx
      if((p = morecore(nunits)) == 0)
 791:	83 c4 10             	add    $0x10,%esp
 794:	85 d2                	test   %edx,%edx
 796:	75 c0                	jne    758 <malloc+0x48>
        return 0;
  }
}
 798:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 79b:	31 c0                	xor    %eax,%eax
}
 79d:	5b                   	pop    %ebx
 79e:	5e                   	pop    %esi
 79f:	5f                   	pop    %edi
 7a0:	5d                   	pop    %ebp
 7a1:	c3                   	ret    
 7a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7a8:	39 cf                	cmp    %ecx,%edi
 7aa:	74 54                	je     800 <malloc+0xf0>
        p->s.size -= nunits;
 7ac:	29 f9                	sub    %edi,%ecx
 7ae:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7b1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7b4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7b7:	89 15 90 0b 00 00    	mov    %edx,0xb90
}
 7bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7c0:	83 c0 08             	add    $0x8,%eax
}
 7c3:	5b                   	pop    %ebx
 7c4:	5e                   	pop    %esi
 7c5:	5f                   	pop    %edi
 7c6:	5d                   	pop    %ebp
 7c7:	c3                   	ret    
 7c8:	90                   	nop
 7c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 7d0:	c7 05 90 0b 00 00 94 	movl   $0xb94,0xb90
 7d7:	0b 00 00 
 7da:	c7 05 94 0b 00 00 94 	movl   $0xb94,0xb94
 7e1:	0b 00 00 
    base.s.size = 0;
 7e4:	b8 94 0b 00 00       	mov    $0xb94,%eax
 7e9:	c7 05 98 0b 00 00 00 	movl   $0x0,0xb98
 7f0:	00 00 00 
 7f3:	e9 44 ff ff ff       	jmp    73c <malloc+0x2c>
 7f8:	90                   	nop
 7f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 800:	8b 08                	mov    (%eax),%ecx
 802:	89 0a                	mov    %ecx,(%edx)
 804:	eb b1                	jmp    7b7 <malloc+0xa7>
