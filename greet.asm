
user/_greet:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user/user.h"




int main(int argc, char *argv[]){
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  11:	8b 01                	mov    (%ecx),%eax
  13:	8b 51 04             	mov    0x4(%ecx),%edx
    if(argc == 1){
  16:	83 f8 01             	cmp    $0x1,%eax
  19:	74 2e                	je     49 <main+0x49>
        printf("Hello, user!\n");
    }
    else if(argc > 3){
  1b:	83 f8 03             	cmp    $0x3,%eax
  1e:	7f 17                	jg     37 <main+0x37>
        printf("Too many arguments!\n");
    }
    else{
        printf("Hello, %s \n", argv[1]);
  20:	50                   	push   %eax
  21:	50                   	push   %eax
  22:	ff 72 04             	pushl  0x4(%edx)
  25:	68 0b 08 00 00       	push   $0x80b
  2a:	e8 11 06 00 00       	call   640 <printf>
  2f:	83 c4 10             	add    $0x10,%esp
    }
    exit();
  32:	e8 7b 02 00 00       	call   2b2 <exit>
        printf("Too many arguments!\n");
  37:	83 ec 0c             	sub    $0xc,%esp
  3a:	68 f6 07 00 00       	push   $0x7f6
  3f:	e8 fc 05 00 00       	call   640 <printf>
  44:	83 c4 10             	add    $0x10,%esp
  47:	eb e9                	jmp    32 <main+0x32>
        printf("Hello, user!\n");
  49:	83 ec 0c             	sub    $0xc,%esp
  4c:	68 e8 07 00 00       	push   $0x7e8
  51:	e8 ea 05 00 00       	call   640 <printf>
  56:	83 c4 10             	add    $0x10,%esp
  59:	eb d7                	jmp    32 <main+0x32>
  5b:	66 90                	xchg   %ax,%ax
  5d:	66 90                	xchg   %ax,%ax
  5f:	90                   	nop

00000060 <strcpy>:
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 45 08             	mov    0x8(%ebp),%eax
  67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  6a:	89 c2                	mov    %eax,%edx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  70:	83 c1 01             	add    $0x1,%ecx
  73:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  77:	83 c2 01             	add    $0x1,%edx
  7a:	84 db                	test   %bl,%bl
  7c:	88 5a ff             	mov    %bl,-0x1(%edx)
  7f:	75 ef                	jne    70 <strcpy+0x10>
  81:	5b                   	pop    %ebx
  82:	5d                   	pop    %ebp
  83:	c3                   	ret    
  84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000090 <strcmp>:
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 55 08             	mov    0x8(%ebp),%edx
  97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  9a:	0f b6 02             	movzbl (%edx),%eax
  9d:	0f b6 19             	movzbl (%ecx),%ebx
  a0:	84 c0                	test   %al,%al
  a2:	75 1c                	jne    c0 <strcmp+0x30>
  a4:	eb 2a                	jmp    d0 <strcmp+0x40>
  a6:	8d 76 00             	lea    0x0(%esi),%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  b0:	83 c2 01             	add    $0x1,%edx
  b3:	0f b6 02             	movzbl (%edx),%eax
  b6:	83 c1 01             	add    $0x1,%ecx
  b9:	0f b6 19             	movzbl (%ecx),%ebx
  bc:	84 c0                	test   %al,%al
  be:	74 10                	je     d0 <strcmp+0x40>
  c0:	38 d8                	cmp    %bl,%al
  c2:	74 ec                	je     b0 <strcmp+0x20>
  c4:	29 d8                	sub    %ebx,%eax
  c6:	5b                   	pop    %ebx
  c7:	5d                   	pop    %ebp
  c8:	c3                   	ret    
  c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  d0:	31 c0                	xor    %eax,%eax
  d2:	29 d8                	sub    %ebx,%eax
  d4:	5b                   	pop    %ebx
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    
  d7:	89 f6                	mov    %esi,%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000e0 <strlen>:
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  e6:	80 39 00             	cmpb   $0x0,(%ecx)
  e9:	74 15                	je     100 <strlen+0x20>
  eb:	31 d2                	xor    %edx,%edx
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  f0:	83 c2 01             	add    $0x1,%edx
  f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  f7:	89 d0                	mov    %edx,%eax
  f9:	75 f5                	jne    f0 <strlen+0x10>
  fb:	5d                   	pop    %ebp
  fc:	c3                   	ret    
  fd:	8d 76 00             	lea    0x0(%esi),%esi
 100:	31 c0                	xor    %eax,%eax
 102:	5d                   	pop    %ebp
 103:	c3                   	ret    
 104:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 10a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000110 <memset>:
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	8b 55 08             	mov    0x8(%ebp),%edx
 117:	8b 4d 10             	mov    0x10(%ebp),%ecx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 d7                	mov    %edx,%edi
 11f:	fc                   	cld    
 120:	f3 aa                	rep stos %al,%es:(%edi)
 122:	89 d0                	mov    %edx,%eax
 124:	5f                   	pop    %edi
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    
 127:	89 f6                	mov    %esi,%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <strchr>:
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	8b 45 08             	mov    0x8(%ebp),%eax
 137:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 13a:	0f b6 10             	movzbl (%eax),%edx
 13d:	84 d2                	test   %dl,%dl
 13f:	74 1d                	je     15e <strchr+0x2e>
 141:	38 d3                	cmp    %dl,%bl
 143:	89 d9                	mov    %ebx,%ecx
 145:	75 0d                	jne    154 <strchr+0x24>
 147:	eb 17                	jmp    160 <strchr+0x30>
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 150:	38 ca                	cmp    %cl,%dl
 152:	74 0c                	je     160 <strchr+0x30>
 154:	83 c0 01             	add    $0x1,%eax
 157:	0f b6 10             	movzbl (%eax),%edx
 15a:	84 d2                	test   %dl,%dl
 15c:	75 f2                	jne    150 <strchr+0x20>
 15e:	31 c0                	xor    %eax,%eax
 160:	5b                   	pop    %ebx
 161:	5d                   	pop    %ebp
 162:	c3                   	ret    
 163:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <gets>:
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	56                   	push   %esi
 175:	53                   	push   %ebx
 176:	31 f6                	xor    %esi,%esi
 178:	89 f3                	mov    %esi,%ebx
 17a:	83 ec 1c             	sub    $0x1c,%esp
 17d:	8b 7d 08             	mov    0x8(%ebp),%edi
 180:	eb 2f                	jmp    1b1 <gets+0x41>
 182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 188:	8d 45 e7             	lea    -0x19(%ebp),%eax
 18b:	83 ec 04             	sub    $0x4,%esp
 18e:	6a 01                	push   $0x1
 190:	50                   	push   %eax
 191:	6a 00                	push   $0x0
 193:	e8 32 01 00 00       	call   2ca <read>
 198:	83 c4 10             	add    $0x10,%esp
 19b:	85 c0                	test   %eax,%eax
 19d:	7e 1c                	jle    1bb <gets+0x4b>
 19f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1a3:	83 c7 01             	add    $0x1,%edi
 1a6:	88 47 ff             	mov    %al,-0x1(%edi)
 1a9:	3c 0a                	cmp    $0xa,%al
 1ab:	74 23                	je     1d0 <gets+0x60>
 1ad:	3c 0d                	cmp    $0xd,%al
 1af:	74 1f                	je     1d0 <gets+0x60>
 1b1:	83 c3 01             	add    $0x1,%ebx
 1b4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1b7:	89 fe                	mov    %edi,%esi
 1b9:	7c cd                	jl     188 <gets+0x18>
 1bb:	89 f3                	mov    %esi,%ebx
 1bd:	8b 45 08             	mov    0x8(%ebp),%eax
 1c0:	c6 03 00             	movb   $0x0,(%ebx)
 1c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1c6:	5b                   	pop    %ebx
 1c7:	5e                   	pop    %esi
 1c8:	5f                   	pop    %edi
 1c9:	5d                   	pop    %ebp
 1ca:	c3                   	ret    
 1cb:	90                   	nop
 1cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d0:	8b 75 08             	mov    0x8(%ebp),%esi
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	01 de                	add    %ebx,%esi
 1d8:	89 f3                	mov    %esi,%ebx
 1da:	c6 03 00             	movb   $0x0,(%ebx)
 1dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e0:	5b                   	pop    %ebx
 1e1:	5e                   	pop    %esi
 1e2:	5f                   	pop    %edi
 1e3:	5d                   	pop    %ebp
 1e4:	c3                   	ret    
 1e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <stat>:
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	56                   	push   %esi
 1f4:	53                   	push   %ebx
 1f5:	83 ec 08             	sub    $0x8,%esp
 1f8:	6a 00                	push   $0x0
 1fa:	ff 75 08             	pushl  0x8(%ebp)
 1fd:	e8 f0 00 00 00       	call   2f2 <open>
 202:	83 c4 10             	add    $0x10,%esp
 205:	85 c0                	test   %eax,%eax
 207:	78 27                	js     230 <stat+0x40>
 209:	83 ec 08             	sub    $0x8,%esp
 20c:	ff 75 0c             	pushl  0xc(%ebp)
 20f:	89 c3                	mov    %eax,%ebx
 211:	50                   	push   %eax
 212:	e8 f3 00 00 00       	call   30a <fstat>
 217:	89 1c 24             	mov    %ebx,(%esp)
 21a:	89 c6                	mov    %eax,%esi
 21c:	e8 b9 00 00 00       	call   2da <close>
 221:	83 c4 10             	add    $0x10,%esp
 224:	8d 65 f8             	lea    -0x8(%ebp),%esp
 227:	89 f0                	mov    %esi,%eax
 229:	5b                   	pop    %ebx
 22a:	5e                   	pop    %esi
 22b:	5d                   	pop    %ebp
 22c:	c3                   	ret    
 22d:	8d 76 00             	lea    0x0(%esi),%esi
 230:	be ff ff ff ff       	mov    $0xffffffff,%esi
 235:	eb ed                	jmp    224 <stat+0x34>
 237:	89 f6                	mov    %esi,%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <atoi>:
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	8b 4d 08             	mov    0x8(%ebp),%ecx
 247:	0f be 11             	movsbl (%ecx),%edx
 24a:	8d 42 d0             	lea    -0x30(%edx),%eax
 24d:	3c 09                	cmp    $0x9,%al
 24f:	b8 00 00 00 00       	mov    $0x0,%eax
 254:	77 1f                	ja     275 <atoi+0x35>
 256:	8d 76 00             	lea    0x0(%esi),%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 260:	8d 04 80             	lea    (%eax,%eax,4),%eax
 263:	83 c1 01             	add    $0x1,%ecx
 266:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 26a:	0f be 11             	movsbl (%ecx),%edx
 26d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 270:	80 fb 09             	cmp    $0x9,%bl
 273:	76 eb                	jbe    260 <atoi+0x20>
 275:	5b                   	pop    %ebx
 276:	5d                   	pop    %ebp
 277:	c3                   	ret    
 278:	90                   	nop
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000280 <memmove>:
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	53                   	push   %ebx
 285:	8b 5d 10             	mov    0x10(%ebp),%ebx
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	8b 75 0c             	mov    0xc(%ebp),%esi
 28e:	85 db                	test   %ebx,%ebx
 290:	7e 14                	jle    2a6 <memmove+0x26>
 292:	31 d2                	xor    %edx,%edx
 294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 298:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 29c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 29f:	83 c2 01             	add    $0x1,%edx
 2a2:	39 d3                	cmp    %edx,%ebx
 2a4:	75 f2                	jne    298 <memmove+0x18>
 2a6:	5b                   	pop    %ebx
 2a7:	5e                   	pop    %esi
 2a8:	5d                   	pop    %ebp
 2a9:	c3                   	ret    

000002aa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2aa:	b8 01 00 00 00       	mov    $0x1,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <exit>:
SYSCALL(exit)
 2b2:	b8 02 00 00 00       	mov    $0x2,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <wait>:
SYSCALL(wait)
 2ba:	b8 03 00 00 00       	mov    $0x3,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <pipe>:
SYSCALL(pipe)
 2c2:	b8 04 00 00 00       	mov    $0x4,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <read>:
SYSCALL(read)
 2ca:	b8 05 00 00 00       	mov    $0x5,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <write>:
SYSCALL(write)
 2d2:	b8 10 00 00 00       	mov    $0x10,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <close>:
SYSCALL(close)
 2da:	b8 15 00 00 00       	mov    $0x15,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <kill>:
SYSCALL(kill)
 2e2:	b8 06 00 00 00       	mov    $0x6,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <exec>:
SYSCALL(exec)
 2ea:	b8 07 00 00 00       	mov    $0x7,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <open>:
SYSCALL(open)
 2f2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <mknod>:
SYSCALL(mknod)
 2fa:	b8 11 00 00 00       	mov    $0x11,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <unlink>:
SYSCALL(unlink)
 302:	b8 12 00 00 00       	mov    $0x12,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <fstat>:
SYSCALL(fstat)
 30a:	b8 08 00 00 00       	mov    $0x8,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <link>:
SYSCALL(link)
 312:	b8 13 00 00 00       	mov    $0x13,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <mkdir>:
SYSCALL(mkdir)
 31a:	b8 14 00 00 00       	mov    $0x14,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <chdir>:
SYSCALL(chdir)
 322:	b8 09 00 00 00       	mov    $0x9,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <dup>:
SYSCALL(dup)
 32a:	b8 0a 00 00 00       	mov    $0xa,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <getpid>:
SYSCALL(getpid)
 332:	b8 0b 00 00 00       	mov    $0xb,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <sbrk>:
SYSCALL(sbrk)
 33a:	b8 0c 00 00 00       	mov    $0xc,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <sleep>:
SYSCALL(sleep)
 342:	b8 0d 00 00 00       	mov    $0xd,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <uptime>:
SYSCALL(uptime)
 34a:	b8 0e 00 00 00       	mov    $0xe,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <cpuhalt>:
SYSCALL(cpuhalt)
 352:	b8 16 00 00 00       	mov    $0x16,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    
 35a:	66 90                	xchg   %ax,%ax
 35c:	66 90                	xchg   %ax,%ax
 35e:	66 90                	xchg   %ax,%ax

00000360 <printint.constprop.1>:
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	53                   	push   %ebx
 366:	89 d6                	mov    %edx,%esi
 368:	83 ec 3c             	sub    $0x3c,%esp
 36b:	85 c0                	test   %eax,%eax
 36d:	79 71                	jns    3e0 <printint.constprop.1+0x80>
 36f:	83 e1 01             	and    $0x1,%ecx
 372:	74 6c                	je     3e0 <printint.constprop.1+0x80>
 374:	f7 d8                	neg    %eax
 376:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 37d:	31 c9                	xor    %ecx,%ecx
 37f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 382:	eb 06                	jmp    38a <printint.constprop.1+0x2a>
 384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 388:	89 f9                	mov    %edi,%ecx
 38a:	31 d2                	xor    %edx,%edx
 38c:	8d 79 01             	lea    0x1(%ecx),%edi
 38f:	f7 f6                	div    %esi
 391:	0f b6 92 20 08 00 00 	movzbl 0x820(%edx),%edx
 398:	85 c0                	test   %eax,%eax
 39a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
 39d:	75 e9                	jne    388 <printint.constprop.1+0x28>
 39f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3a2:	85 c0                	test   %eax,%eax
 3a4:	74 08                	je     3ae <printint.constprop.1+0x4e>
 3a6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 3ab:	8d 79 02             	lea    0x2(%ecx),%edi
 3ae:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 3b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3b8:	0f b6 06             	movzbl (%esi),%eax
 3bb:	83 ec 04             	sub    $0x4,%esp
 3be:	83 ee 01             	sub    $0x1,%esi
 3c1:	6a 01                	push   $0x1
 3c3:	53                   	push   %ebx
 3c4:	6a 01                	push   $0x1
 3c6:	88 45 d7             	mov    %al,-0x29(%ebp)
 3c9:	e8 04 ff ff ff       	call   2d2 <write>
 3ce:	83 c4 10             	add    $0x10,%esp
 3d1:	39 de                	cmp    %ebx,%esi
 3d3:	75 e3                	jne    3b8 <printint.constprop.1+0x58>
 3d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3d8:	5b                   	pop    %ebx
 3d9:	5e                   	pop    %esi
 3da:	5f                   	pop    %edi
 3db:	5d                   	pop    %ebp
 3dc:	c3                   	ret    
 3dd:	8d 76 00             	lea    0x0(%esi),%esi
 3e0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3e7:	eb 94                	jmp    37d <printint.constprop.1+0x1d>
 3e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003f0 <vprintf.constprop.0>:
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
 3f6:	89 d6                	mov    %edx,%esi
 3f8:	83 ec 2c             	sub    $0x2c,%esp
 3fb:	0f b6 10             	movzbl (%eax),%edx
 3fe:	84 d2                	test   %dl,%dl
 400:	0f 84 cd 00 00 00    	je     4d3 <vprintf.constprop.0+0xe3>
 406:	8d 58 01             	lea    0x1(%eax),%ebx
 409:	31 ff                	xor    %edi,%edi
 40b:	eb 31                	jmp    43e <vprintf.constprop.0+0x4e>
 40d:	8d 76 00             	lea    0x0(%esi),%esi
 410:	83 f8 25             	cmp    $0x25,%eax
 413:	0f 84 c7 00 00 00    	je     4e0 <vprintf.constprop.0+0xf0>
 419:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 41c:	83 ec 04             	sub    $0x4,%esp
 41f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 422:	6a 01                	push   $0x1
 424:	50                   	push   %eax
 425:	6a 01                	push   $0x1
 427:	e8 a6 fe ff ff       	call   2d2 <write>
 42c:	83 c4 10             	add    $0x10,%esp
 42f:	83 c3 01             	add    $0x1,%ebx
 432:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 436:	84 d2                	test   %dl,%dl
 438:	0f 84 95 00 00 00    	je     4d3 <vprintf.constprop.0+0xe3>
 43e:	85 ff                	test   %edi,%edi
 440:	0f b6 c2             	movzbl %dl,%eax
 443:	74 cb                	je     410 <vprintf.constprop.0+0x20>
 445:	83 ff 25             	cmp    $0x25,%edi
 448:	75 e5                	jne    42f <vprintf.constprop.0+0x3f>
 44a:	83 f8 64             	cmp    $0x64,%eax
 44d:	8d 7e 04             	lea    0x4(%esi),%edi
 450:	b9 01 00 00 00       	mov    $0x1,%ecx
 455:	0f 84 9a 00 00 00    	je     4f5 <vprintf.constprop.0+0x105>
 45b:	83 f8 6c             	cmp    $0x6c,%eax
 45e:	0f 84 8c 00 00 00    	je     4f0 <vprintf.constprop.0+0x100>
 464:	83 f8 78             	cmp    $0x78,%eax
 467:	0f 84 a3 00 00 00    	je     510 <vprintf.constprop.0+0x120>
 46d:	83 f8 70             	cmp    $0x70,%eax
 470:	0f 84 ca 00 00 00    	je     540 <vprintf.constprop.0+0x150>
 476:	83 f8 73             	cmp    $0x73,%eax
 479:	0f 84 39 01 00 00    	je     5b8 <vprintf.constprop.0+0x1c8>
 47f:	83 f8 63             	cmp    $0x63,%eax
 482:	0f 84 68 01 00 00    	je     5f0 <vprintf.constprop.0+0x200>
 488:	83 f8 25             	cmp    $0x25,%eax
 48b:	0f 84 9f 00 00 00    	je     530 <vprintf.constprop.0+0x140>
 491:	8d 45 df             	lea    -0x21(%ebp),%eax
 494:	83 ec 04             	sub    $0x4,%esp
 497:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 49a:	6a 01                	push   $0x1
 49c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 4a0:	50                   	push   %eax
 4a1:	6a 01                	push   $0x1
 4a3:	e8 2a fe ff ff       	call   2d2 <write>
 4a8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 4ac:	83 c4 0c             	add    $0xc,%esp
 4af:	8d 45 e0             	lea    -0x20(%ebp),%eax
 4b2:	6a 01                	push   $0x1
 4b4:	88 55 e0             	mov    %dl,-0x20(%ebp)
 4b7:	50                   	push   %eax
 4b8:	6a 01                	push   $0x1
 4ba:	83 c3 01             	add    $0x1,%ebx
 4bd:	31 ff                	xor    %edi,%edi
 4bf:	e8 0e fe ff ff       	call   2d2 <write>
 4c4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4c8:	83 c4 10             	add    $0x10,%esp
 4cb:	84 d2                	test   %dl,%dl
 4cd:	0f 85 6b ff ff ff    	jne    43e <vprintf.constprop.0+0x4e>
 4d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4d6:	5b                   	pop    %ebx
 4d7:	5e                   	pop    %esi
 4d8:	5f                   	pop    %edi
 4d9:	5d                   	pop    %ebp
 4da:	c3                   	ret    
 4db:	90                   	nop
 4dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4e0:	bf 25 00 00 00       	mov    $0x25,%edi
 4e5:	e9 45 ff ff ff       	jmp    42f <vprintf.constprop.0+0x3f>
 4ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4f0:	8d 7e 04             	lea    0x4(%esi),%edi
 4f3:	31 c9                	xor    %ecx,%ecx
 4f5:	8b 06                	mov    (%esi),%eax
 4f7:	ba 0a 00 00 00       	mov    $0xa,%edx
 4fc:	89 fe                	mov    %edi,%esi
 4fe:	31 ff                	xor    %edi,%edi
 500:	e8 5b fe ff ff       	call   360 <printint.constprop.1>
 505:	e9 25 ff ff ff       	jmp    42f <vprintf.constprop.0+0x3f>
 50a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 510:	8b 06                	mov    (%esi),%eax
 512:	8d 7e 04             	lea    0x4(%esi),%edi
 515:	31 c9                	xor    %ecx,%ecx
 517:	ba 10 00 00 00       	mov    $0x10,%edx
 51c:	89 fe                	mov    %edi,%esi
 51e:	31 ff                	xor    %edi,%edi
 520:	e8 3b fe ff ff       	call   360 <printint.constprop.1>
 525:	e9 05 ff ff ff       	jmp    42f <vprintf.constprop.0+0x3f>
 52a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 530:	83 ec 04             	sub    $0x4,%esp
 533:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 536:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 539:	6a 01                	push   $0x1
 53b:	e9 77 ff ff ff       	jmp    4b7 <vprintf.constprop.0+0xc7>
 540:	8d 46 04             	lea    0x4(%esi),%eax
 543:	83 ec 04             	sub    $0x4,%esp
 546:	8b 3e                	mov    (%esi),%edi
 548:	6a 01                	push   $0x1
 54a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 54e:	be 08 00 00 00       	mov    $0x8,%esi
 553:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 556:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 559:	50                   	push   %eax
 55a:	6a 01                	push   $0x1
 55c:	e8 71 fd ff ff       	call   2d2 <write>
 561:	8d 45 e7             	lea    -0x19(%ebp),%eax
 564:	83 c4 0c             	add    $0xc,%esp
 567:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 56b:	6a 01                	push   $0x1
 56d:	50                   	push   %eax
 56e:	6a 01                	push   $0x1
 570:	e8 5d fd ff ff       	call   2d2 <write>
 575:	83 c4 10             	add    $0x10,%esp
 578:	90                   	nop
 579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 580:	89 f8                	mov    %edi,%eax
 582:	83 ec 04             	sub    $0x4,%esp
 585:	c1 e7 04             	shl    $0x4,%edi
 588:	c1 e8 1c             	shr    $0x1c,%eax
 58b:	6a 01                	push   $0x1
 58d:	0f b6 80 20 08 00 00 	movzbl 0x820(%eax),%eax
 594:	88 45 e5             	mov    %al,-0x1b(%ebp)
 597:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 59a:	50                   	push   %eax
 59b:	6a 01                	push   $0x1
 59d:	e8 30 fd ff ff       	call   2d2 <write>
 5a2:	83 c4 10             	add    $0x10,%esp
 5a5:	83 ee 01             	sub    $0x1,%esi
 5a8:	75 d6                	jne    580 <vprintf.constprop.0+0x190>
 5aa:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 5ad:	31 ff                	xor    %edi,%edi
 5af:	e9 7b fe ff ff       	jmp    42f <vprintf.constprop.0+0x3f>
 5b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5b8:	8b 3e                	mov    (%esi),%edi
 5ba:	8d 46 04             	lea    0x4(%esi),%eax
 5bd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5c0:	85 ff                	test   %edi,%edi
 5c2:	74 50                	je     614 <vprintf.constprop.0+0x224>
 5c4:	0f b6 07             	movzbl (%edi),%eax
 5c7:	84 c0                	test   %al,%al
 5c9:	74 df                	je     5aa <vprintf.constprop.0+0x1ba>
 5cb:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 5ce:	66 90                	xchg   %ax,%ax
 5d0:	83 ec 04             	sub    $0x4,%esp
 5d3:	83 c7 01             	add    $0x1,%edi
 5d6:	88 45 e3             	mov    %al,-0x1d(%ebp)
 5d9:	6a 01                	push   $0x1
 5db:	56                   	push   %esi
 5dc:	6a 01                	push   $0x1
 5de:	e8 ef fc ff ff       	call   2d2 <write>
 5e3:	0f b6 07             	movzbl (%edi),%eax
 5e6:	83 c4 10             	add    $0x10,%esp
 5e9:	84 c0                	test   %al,%al
 5eb:	75 e3                	jne    5d0 <vprintf.constprop.0+0x1e0>
 5ed:	eb bb                	jmp    5aa <vprintf.constprop.0+0x1ba>
 5ef:	90                   	nop
 5f0:	8b 06                	mov    (%esi),%eax
 5f2:	83 ec 04             	sub    $0x4,%esp
 5f5:	8d 7e 04             	lea    0x4(%esi),%edi
 5f8:	6a 01                	push   $0x1
 5fa:	89 fe                	mov    %edi,%esi
 5fc:	31 ff                	xor    %edi,%edi
 5fe:	88 45 e2             	mov    %al,-0x1e(%ebp)
 601:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 604:	50                   	push   %eax
 605:	6a 01                	push   $0x1
 607:	e8 c6 fc ff ff       	call   2d2 <write>
 60c:	83 c4 10             	add    $0x10,%esp
 60f:	e9 1b fe ff ff       	jmp    42f <vprintf.constprop.0+0x3f>
 614:	bf 17 08 00 00       	mov    $0x817,%edi
 619:	b8 28 00 00 00       	mov    $0x28,%eax
 61e:	eb ab                	jmp    5cb <vprintf.constprop.0+0x1db>

00000620 <fprintf>:
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	83 ec 08             	sub    $0x8,%esp
 626:	8b 45 0c             	mov    0xc(%ebp),%eax
 629:	8d 55 10             	lea    0x10(%ebp),%edx
 62c:	e8 bf fd ff ff       	call   3f0 <vprintf.constprop.0>
 631:	c9                   	leave  
 632:	c3                   	ret    
 633:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000640 <printf>:
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	83 ec 08             	sub    $0x8,%esp
 646:	8b 45 08             	mov    0x8(%ebp),%eax
 649:	8d 55 0c             	lea    0xc(%ebp),%edx
 64c:	e8 9f fd ff ff       	call   3f0 <vprintf.constprop.0>
 651:	c9                   	leave  
 652:	c3                   	ret    
 653:	66 90                	xchg   %ax,%ax
 655:	66 90                	xchg   %ax,%ax
 657:	66 90                	xchg   %ax,%ax
 659:	66 90                	xchg   %ax,%ax
 65b:	66 90                	xchg   %ax,%ax
 65d:	66 90                	xchg   %ax,%ax
 65f:	90                   	nop

00000660 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 660:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 661:	a1 04 0b 00 00       	mov    0xb04,%eax
{
 666:	89 e5                	mov    %esp,%ebp
 668:	57                   	push   %edi
 669:	56                   	push   %esi
 66a:	53                   	push   %ebx
 66b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 66e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 678:	39 c8                	cmp    %ecx,%eax
 67a:	8b 10                	mov    (%eax),%edx
 67c:	73 32                	jae    6b0 <free+0x50>
 67e:	39 d1                	cmp    %edx,%ecx
 680:	72 04                	jb     686 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 682:	39 d0                	cmp    %edx,%eax
 684:	72 32                	jb     6b8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 686:	8b 73 fc             	mov    -0x4(%ebx),%esi
 689:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 68c:	39 fa                	cmp    %edi,%edx
 68e:	74 30                	je     6c0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 690:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 693:	8b 50 04             	mov    0x4(%eax),%edx
 696:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 699:	39 f1                	cmp    %esi,%ecx
 69b:	74 3a                	je     6d7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 69d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 69f:	a3 04 0b 00 00       	mov    %eax,0xb04
}
 6a4:	5b                   	pop    %ebx
 6a5:	5e                   	pop    %esi
 6a6:	5f                   	pop    %edi
 6a7:	5d                   	pop    %ebp
 6a8:	c3                   	ret    
 6a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b0:	39 d0                	cmp    %edx,%eax
 6b2:	72 04                	jb     6b8 <free+0x58>
 6b4:	39 d1                	cmp    %edx,%ecx
 6b6:	72 ce                	jb     686 <free+0x26>
{
 6b8:	89 d0                	mov    %edx,%eax
 6ba:	eb bc                	jmp    678 <free+0x18>
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 6c0:	03 72 04             	add    0x4(%edx),%esi
 6c3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6c6:	8b 10                	mov    (%eax),%edx
 6c8:	8b 12                	mov    (%edx),%edx
 6ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6cd:	8b 50 04             	mov    0x4(%eax),%edx
 6d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6d3:	39 f1                	cmp    %esi,%ecx
 6d5:	75 c6                	jne    69d <free+0x3d>
    p->s.size += bp->s.size;
 6d7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6da:	a3 04 0b 00 00       	mov    %eax,0xb04
    p->s.size += bp->s.size;
 6df:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6e2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6e5:	89 10                	mov    %edx,(%eax)
}
 6e7:	5b                   	pop    %ebx
 6e8:	5e                   	pop    %esi
 6e9:	5f                   	pop    %edi
 6ea:	5d                   	pop    %ebp
 6eb:	c3                   	ret    
 6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	57                   	push   %edi
 6f4:	56                   	push   %esi
 6f5:	53                   	push   %ebx
 6f6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6fc:	8b 15 04 0b 00 00    	mov    0xb04,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 702:	8d 78 07             	lea    0x7(%eax),%edi
 705:	c1 ef 03             	shr    $0x3,%edi
 708:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 70b:	85 d2                	test   %edx,%edx
 70d:	0f 84 9d 00 00 00    	je     7b0 <malloc+0xc0>
 713:	8b 02                	mov    (%edx),%eax
 715:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 718:	39 cf                	cmp    %ecx,%edi
 71a:	76 6c                	jbe    788 <malloc+0x98>
 71c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 722:	bb 00 10 00 00       	mov    $0x1000,%ebx
 727:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 72a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 731:	eb 0e                	jmp    741 <malloc+0x51>
 733:	90                   	nop
 734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 738:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 73a:	8b 48 04             	mov    0x4(%eax),%ecx
 73d:	39 f9                	cmp    %edi,%ecx
 73f:	73 47                	jae    788 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 741:	39 05 04 0b 00 00    	cmp    %eax,0xb04
 747:	89 c2                	mov    %eax,%edx
 749:	75 ed                	jne    738 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 74b:	83 ec 0c             	sub    $0xc,%esp
 74e:	56                   	push   %esi
 74f:	e8 e6 fb ff ff       	call   33a <sbrk>
  if(p == (char*)-1)
 754:	83 c4 10             	add    $0x10,%esp
 757:	83 f8 ff             	cmp    $0xffffffff,%eax
 75a:	74 1c                	je     778 <malloc+0x88>
  hp->s.size = nu;
 75c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 75f:	83 ec 0c             	sub    $0xc,%esp
 762:	83 c0 08             	add    $0x8,%eax
 765:	50                   	push   %eax
 766:	e8 f5 fe ff ff       	call   660 <free>
  return freep;
 76b:	8b 15 04 0b 00 00    	mov    0xb04,%edx
      if((p = morecore(nunits)) == 0)
 771:	83 c4 10             	add    $0x10,%esp
 774:	85 d2                	test   %edx,%edx
 776:	75 c0                	jne    738 <malloc+0x48>
        return 0;
  }
}
 778:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 77b:	31 c0                	xor    %eax,%eax
}
 77d:	5b                   	pop    %ebx
 77e:	5e                   	pop    %esi
 77f:	5f                   	pop    %edi
 780:	5d                   	pop    %ebp
 781:	c3                   	ret    
 782:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 788:	39 cf                	cmp    %ecx,%edi
 78a:	74 54                	je     7e0 <malloc+0xf0>
        p->s.size -= nunits;
 78c:	29 f9                	sub    %edi,%ecx
 78e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 791:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 794:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 797:	89 15 04 0b 00 00    	mov    %edx,0xb04
}
 79d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7a0:	83 c0 08             	add    $0x8,%eax
}
 7a3:	5b                   	pop    %ebx
 7a4:	5e                   	pop    %esi
 7a5:	5f                   	pop    %edi
 7a6:	5d                   	pop    %ebp
 7a7:	c3                   	ret    
 7a8:	90                   	nop
 7a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 7b0:	c7 05 04 0b 00 00 08 	movl   $0xb08,0xb04
 7b7:	0b 00 00 
 7ba:	c7 05 08 0b 00 00 08 	movl   $0xb08,0xb08
 7c1:	0b 00 00 
    base.s.size = 0;
 7c4:	b8 08 0b 00 00       	mov    $0xb08,%eax
 7c9:	c7 05 0c 0b 00 00 00 	movl   $0x0,0xb0c
 7d0:	00 00 00 
 7d3:	e9 44 ff ff ff       	jmp    71c <malloc+0x2c>
 7d8:	90                   	nop
 7d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 7e0:	8b 08                	mov    (%eax),%ecx
 7e2:	89 0a                	mov    %ecx,(%edx)
 7e4:	eb b1                	jmp    797 <malloc+0xa7>
