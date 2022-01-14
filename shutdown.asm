
user/_shutdown:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 0c             	sub    $0xc,%esp
  11:	8b 41 04             	mov    0x4(%ecx),%eax
  14:	68 f8 07 00 00       	push   $0x7f8
  19:	ff 70 04             	pushl  0x4(%eax)
  1c:	e8 7f 00 00 00       	call   a0 <strcmp>
  21:	83 c4 10             	add    $0x10,%esp
  24:	85 c0                	test   %eax,%eax
  26:	74 35                	je     5d <main+0x5d>
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	68 fd 07 00 00       	push   $0x7fd
  30:	e8 1b 06 00 00       	call   650 <printf>
  35:	e8 80 02 00 00       	call   2ba <fork>
  3a:	83 c4 10             	add    $0x10,%esp
  3d:	85 c0                	test   %eax,%eax
  3f:	75 23                	jne    64 <main+0x64>
  41:	83 ec 0c             	sub    $0xc,%esp
  44:	68 f4 01 00 00       	push   $0x1f4
  49:	e8 04 03 00 00       	call   352 <sleep>
  4e:	e8 0f 03 00 00       	call   362 <cpuhalt>
  53:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  56:	31 c0                	xor    %eax,%eax
  58:	c9                   	leave  
  59:	8d 61 fc             	lea    -0x4(%ecx),%esp
  5c:	c3                   	ret    
  5d:	e8 00 03 00 00       	call   362 <cpuhalt>
  62:	eb c4                	jmp    28 <main+0x28>
  64:	e8 59 02 00 00       	call   2c2 <exit>
  69:	66 90                	xchg   %ax,%ax
  6b:	66 90                	xchg   %ax,%ax
  6d:	66 90                	xchg   %ax,%ax
  6f:	90                   	nop

00000070 <strcpy>:
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	8b 45 08             	mov    0x8(%ebp),%eax
  77:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  7a:	89 c2                	mov    %eax,%edx
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  80:	83 c1 01             	add    $0x1,%ecx
  83:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  87:	83 c2 01             	add    $0x1,%edx
  8a:	84 db                	test   %bl,%bl
  8c:	88 5a ff             	mov    %bl,-0x1(%edx)
  8f:	75 ef                	jne    80 <strcpy+0x10>
  91:	5b                   	pop    %ebx
  92:	5d                   	pop    %ebp
  93:	c3                   	ret    
  94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000a0 <strcmp>:
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	53                   	push   %ebx
  a4:	8b 55 08             	mov    0x8(%ebp),%edx
  a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  aa:	0f b6 02             	movzbl (%edx),%eax
  ad:	0f b6 19             	movzbl (%ecx),%ebx
  b0:	84 c0                	test   %al,%al
  b2:	75 1c                	jne    d0 <strcmp+0x30>
  b4:	eb 2a                	jmp    e0 <strcmp+0x40>
  b6:	8d 76 00             	lea    0x0(%esi),%esi
  b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  c0:	83 c2 01             	add    $0x1,%edx
  c3:	0f b6 02             	movzbl (%edx),%eax
  c6:	83 c1 01             	add    $0x1,%ecx
  c9:	0f b6 19             	movzbl (%ecx),%ebx
  cc:	84 c0                	test   %al,%al
  ce:	74 10                	je     e0 <strcmp+0x40>
  d0:	38 d8                	cmp    %bl,%al
  d2:	74 ec                	je     c0 <strcmp+0x20>
  d4:	29 d8                	sub    %ebx,%eax
  d6:	5b                   	pop    %ebx
  d7:	5d                   	pop    %ebp
  d8:	c3                   	ret    
  d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  e0:	31 c0                	xor    %eax,%eax
  e2:	29 d8                	sub    %ebx,%eax
  e4:	5b                   	pop    %ebx
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	89 f6                	mov    %esi,%esi
  e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000f0 <strlen>:
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  f6:	80 39 00             	cmpb   $0x0,(%ecx)
  f9:	74 15                	je     110 <strlen+0x20>
  fb:	31 d2                	xor    %edx,%edx
  fd:	8d 76 00             	lea    0x0(%esi),%esi
 100:	83 c2 01             	add    $0x1,%edx
 103:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 107:	89 d0                	mov    %edx,%eax
 109:	75 f5                	jne    100 <strlen+0x10>
 10b:	5d                   	pop    %ebp
 10c:	c3                   	ret    
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	31 c0                	xor    %eax,%eax
 112:	5d                   	pop    %ebp
 113:	c3                   	ret    
 114:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 11a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000120 <memset>:
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	8b 55 08             	mov    0x8(%ebp),%edx
 127:	8b 4d 10             	mov    0x10(%ebp),%ecx
 12a:	8b 45 0c             	mov    0xc(%ebp),%eax
 12d:	89 d7                	mov    %edx,%edi
 12f:	fc                   	cld    
 130:	f3 aa                	rep stos %al,%es:(%edi)
 132:	89 d0                	mov    %edx,%eax
 134:	5f                   	pop    %edi
 135:	5d                   	pop    %ebp
 136:	c3                   	ret    
 137:	89 f6                	mov    %esi,%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000140 <strchr>:
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 45 08             	mov    0x8(%ebp),%eax
 147:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 14a:	0f b6 10             	movzbl (%eax),%edx
 14d:	84 d2                	test   %dl,%dl
 14f:	74 1d                	je     16e <strchr+0x2e>
 151:	38 d3                	cmp    %dl,%bl
 153:	89 d9                	mov    %ebx,%ecx
 155:	75 0d                	jne    164 <strchr+0x24>
 157:	eb 17                	jmp    170 <strchr+0x30>
 159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 160:	38 ca                	cmp    %cl,%dl
 162:	74 0c                	je     170 <strchr+0x30>
 164:	83 c0 01             	add    $0x1,%eax
 167:	0f b6 10             	movzbl (%eax),%edx
 16a:	84 d2                	test   %dl,%dl
 16c:	75 f2                	jne    160 <strchr+0x20>
 16e:	31 c0                	xor    %eax,%eax
 170:	5b                   	pop    %ebx
 171:	5d                   	pop    %ebp
 172:	c3                   	ret    
 173:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000180 <gets>:
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	57                   	push   %edi
 184:	56                   	push   %esi
 185:	53                   	push   %ebx
 186:	31 f6                	xor    %esi,%esi
 188:	89 f3                	mov    %esi,%ebx
 18a:	83 ec 1c             	sub    $0x1c,%esp
 18d:	8b 7d 08             	mov    0x8(%ebp),%edi
 190:	eb 2f                	jmp    1c1 <gets+0x41>
 192:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 198:	8d 45 e7             	lea    -0x19(%ebp),%eax
 19b:	83 ec 04             	sub    $0x4,%esp
 19e:	6a 01                	push   $0x1
 1a0:	50                   	push   %eax
 1a1:	6a 00                	push   $0x0
 1a3:	e8 32 01 00 00       	call   2da <read>
 1a8:	83 c4 10             	add    $0x10,%esp
 1ab:	85 c0                	test   %eax,%eax
 1ad:	7e 1c                	jle    1cb <gets+0x4b>
 1af:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1b3:	83 c7 01             	add    $0x1,%edi
 1b6:	88 47 ff             	mov    %al,-0x1(%edi)
 1b9:	3c 0a                	cmp    $0xa,%al
 1bb:	74 23                	je     1e0 <gets+0x60>
 1bd:	3c 0d                	cmp    $0xd,%al
 1bf:	74 1f                	je     1e0 <gets+0x60>
 1c1:	83 c3 01             	add    $0x1,%ebx
 1c4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1c7:	89 fe                	mov    %edi,%esi
 1c9:	7c cd                	jl     198 <gets+0x18>
 1cb:	89 f3                	mov    %esi,%ebx
 1cd:	8b 45 08             	mov    0x8(%ebp),%eax
 1d0:	c6 03 00             	movb   $0x0,(%ebx)
 1d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1d6:	5b                   	pop    %ebx
 1d7:	5e                   	pop    %esi
 1d8:	5f                   	pop    %edi
 1d9:	5d                   	pop    %ebp
 1da:	c3                   	ret    
 1db:	90                   	nop
 1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e0:	8b 75 08             	mov    0x8(%ebp),%esi
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	01 de                	add    %ebx,%esi
 1e8:	89 f3                	mov    %esi,%ebx
 1ea:	c6 03 00             	movb   $0x0,(%ebx)
 1ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1f0:	5b                   	pop    %ebx
 1f1:	5e                   	pop    %esi
 1f2:	5f                   	pop    %edi
 1f3:	5d                   	pop    %ebp
 1f4:	c3                   	ret    
 1f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <stat>:
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	56                   	push   %esi
 204:	53                   	push   %ebx
 205:	83 ec 08             	sub    $0x8,%esp
 208:	6a 00                	push   $0x0
 20a:	ff 75 08             	pushl  0x8(%ebp)
 20d:	e8 f0 00 00 00       	call   302 <open>
 212:	83 c4 10             	add    $0x10,%esp
 215:	85 c0                	test   %eax,%eax
 217:	78 27                	js     240 <stat+0x40>
 219:	83 ec 08             	sub    $0x8,%esp
 21c:	ff 75 0c             	pushl  0xc(%ebp)
 21f:	89 c3                	mov    %eax,%ebx
 221:	50                   	push   %eax
 222:	e8 f3 00 00 00       	call   31a <fstat>
 227:	89 1c 24             	mov    %ebx,(%esp)
 22a:	89 c6                	mov    %eax,%esi
 22c:	e8 b9 00 00 00       	call   2ea <close>
 231:	83 c4 10             	add    $0x10,%esp
 234:	8d 65 f8             	lea    -0x8(%ebp),%esp
 237:	89 f0                	mov    %esi,%eax
 239:	5b                   	pop    %ebx
 23a:	5e                   	pop    %esi
 23b:	5d                   	pop    %ebp
 23c:	c3                   	ret    
 23d:	8d 76 00             	lea    0x0(%esi),%esi
 240:	be ff ff ff ff       	mov    $0xffffffff,%esi
 245:	eb ed                	jmp    234 <stat+0x34>
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <atoi>:
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	8b 4d 08             	mov    0x8(%ebp),%ecx
 257:	0f be 11             	movsbl (%ecx),%edx
 25a:	8d 42 d0             	lea    -0x30(%edx),%eax
 25d:	3c 09                	cmp    $0x9,%al
 25f:	b8 00 00 00 00       	mov    $0x0,%eax
 264:	77 1f                	ja     285 <atoi+0x35>
 266:	8d 76 00             	lea    0x0(%esi),%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 270:	8d 04 80             	lea    (%eax,%eax,4),%eax
 273:	83 c1 01             	add    $0x1,%ecx
 276:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 27a:	0f be 11             	movsbl (%ecx),%edx
 27d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 280:	80 fb 09             	cmp    $0x9,%bl
 283:	76 eb                	jbe    270 <atoi+0x20>
 285:	5b                   	pop    %ebx
 286:	5d                   	pop    %ebp
 287:	c3                   	ret    
 288:	90                   	nop
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000290 <memmove>:
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
 295:	8b 5d 10             	mov    0x10(%ebp),%ebx
 298:	8b 45 08             	mov    0x8(%ebp),%eax
 29b:	8b 75 0c             	mov    0xc(%ebp),%esi
 29e:	85 db                	test   %ebx,%ebx
 2a0:	7e 14                	jle    2b6 <memmove+0x26>
 2a2:	31 d2                	xor    %edx,%edx
 2a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2af:	83 c2 01             	add    $0x1,%edx
 2b2:	39 d3                	cmp    %edx,%ebx
 2b4:	75 f2                	jne    2a8 <memmove+0x18>
 2b6:	5b                   	pop    %ebx
 2b7:	5e                   	pop    %esi
 2b8:	5d                   	pop    %ebp
 2b9:	c3                   	ret    

000002ba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ba:	b8 01 00 00 00       	mov    $0x1,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <exit>:
SYSCALL(exit)
 2c2:	b8 02 00 00 00       	mov    $0x2,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <wait>:
SYSCALL(wait)
 2ca:	b8 03 00 00 00       	mov    $0x3,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <pipe>:
SYSCALL(pipe)
 2d2:	b8 04 00 00 00       	mov    $0x4,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <read>:
SYSCALL(read)
 2da:	b8 05 00 00 00       	mov    $0x5,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <write>:
SYSCALL(write)
 2e2:	b8 10 00 00 00       	mov    $0x10,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <close>:
SYSCALL(close)
 2ea:	b8 15 00 00 00       	mov    $0x15,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <kill>:
SYSCALL(kill)
 2f2:	b8 06 00 00 00       	mov    $0x6,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <exec>:
SYSCALL(exec)
 2fa:	b8 07 00 00 00       	mov    $0x7,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <open>:
SYSCALL(open)
 302:	b8 0f 00 00 00       	mov    $0xf,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <mknod>:
SYSCALL(mknod)
 30a:	b8 11 00 00 00       	mov    $0x11,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <unlink>:
SYSCALL(unlink)
 312:	b8 12 00 00 00       	mov    $0x12,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <fstat>:
SYSCALL(fstat)
 31a:	b8 08 00 00 00       	mov    $0x8,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <link>:
SYSCALL(link)
 322:	b8 13 00 00 00       	mov    $0x13,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <mkdir>:
SYSCALL(mkdir)
 32a:	b8 14 00 00 00       	mov    $0x14,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <chdir>:
SYSCALL(chdir)
 332:	b8 09 00 00 00       	mov    $0x9,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <dup>:
SYSCALL(dup)
 33a:	b8 0a 00 00 00       	mov    $0xa,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <getpid>:
SYSCALL(getpid)
 342:	b8 0b 00 00 00       	mov    $0xb,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <sbrk>:
SYSCALL(sbrk)
 34a:	b8 0c 00 00 00       	mov    $0xc,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <sleep>:
SYSCALL(sleep)
 352:	b8 0d 00 00 00       	mov    $0xd,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <uptime>:
SYSCALL(uptime)
 35a:	b8 0e 00 00 00       	mov    $0xe,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <cpuhalt>:
SYSCALL(cpuhalt)
 362:	b8 16 00 00 00       	mov    $0x16,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    
 36a:	66 90                	xchg   %ax,%ax
 36c:	66 90                	xchg   %ax,%ax
 36e:	66 90                	xchg   %ax,%ax

00000370 <printint.constprop.1>:
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
 375:	53                   	push   %ebx
 376:	89 d6                	mov    %edx,%esi
 378:	83 ec 3c             	sub    $0x3c,%esp
 37b:	85 c0                	test   %eax,%eax
 37d:	79 71                	jns    3f0 <printint.constprop.1+0x80>
 37f:	83 e1 01             	and    $0x1,%ecx
 382:	74 6c                	je     3f0 <printint.constprop.1+0x80>
 384:	f7 d8                	neg    %eax
 386:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 38d:	31 c9                	xor    %ecx,%ecx
 38f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 392:	eb 06                	jmp    39a <printint.constprop.1+0x2a>
 394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 398:	89 f9                	mov    %edi,%ecx
 39a:	31 d2                	xor    %edx,%edx
 39c:	8d 79 01             	lea    0x1(%ecx),%edi
 39f:	f7 f6                	div    %esi
 3a1:	0f b6 92 20 08 00 00 	movzbl 0x820(%edx),%edx
 3a8:	85 c0                	test   %eax,%eax
 3aa:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
 3ad:	75 e9                	jne    398 <printint.constprop.1+0x28>
 3af:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3b2:	85 c0                	test   %eax,%eax
 3b4:	74 08                	je     3be <printint.constprop.1+0x4e>
 3b6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 3bb:	8d 79 02             	lea    0x2(%ecx),%edi
 3be:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 3c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3c8:	0f b6 06             	movzbl (%esi),%eax
 3cb:	83 ec 04             	sub    $0x4,%esp
 3ce:	83 ee 01             	sub    $0x1,%esi
 3d1:	6a 01                	push   $0x1
 3d3:	53                   	push   %ebx
 3d4:	6a 01                	push   $0x1
 3d6:	88 45 d7             	mov    %al,-0x29(%ebp)
 3d9:	e8 04 ff ff ff       	call   2e2 <write>
 3de:	83 c4 10             	add    $0x10,%esp
 3e1:	39 de                	cmp    %ebx,%esi
 3e3:	75 e3                	jne    3c8 <printint.constprop.1+0x58>
 3e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3e8:	5b                   	pop    %ebx
 3e9:	5e                   	pop    %esi
 3ea:	5f                   	pop    %edi
 3eb:	5d                   	pop    %ebp
 3ec:	c3                   	ret    
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
 3f0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3f7:	eb 94                	jmp    38d <printint.constprop.1+0x1d>
 3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000400 <vprintf.constprop.0>:
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	89 d6                	mov    %edx,%esi
 408:	83 ec 2c             	sub    $0x2c,%esp
 40b:	0f b6 10             	movzbl (%eax),%edx
 40e:	84 d2                	test   %dl,%dl
 410:	0f 84 cd 00 00 00    	je     4e3 <vprintf.constprop.0+0xe3>
 416:	8d 58 01             	lea    0x1(%eax),%ebx
 419:	31 ff                	xor    %edi,%edi
 41b:	eb 31                	jmp    44e <vprintf.constprop.0+0x4e>
 41d:	8d 76 00             	lea    0x0(%esi),%esi
 420:	83 f8 25             	cmp    $0x25,%eax
 423:	0f 84 c7 00 00 00    	je     4f0 <vprintf.constprop.0+0xf0>
 429:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 42c:	83 ec 04             	sub    $0x4,%esp
 42f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 432:	6a 01                	push   $0x1
 434:	50                   	push   %eax
 435:	6a 01                	push   $0x1
 437:	e8 a6 fe ff ff       	call   2e2 <write>
 43c:	83 c4 10             	add    $0x10,%esp
 43f:	83 c3 01             	add    $0x1,%ebx
 442:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 446:	84 d2                	test   %dl,%dl
 448:	0f 84 95 00 00 00    	je     4e3 <vprintf.constprop.0+0xe3>
 44e:	85 ff                	test   %edi,%edi
 450:	0f b6 c2             	movzbl %dl,%eax
 453:	74 cb                	je     420 <vprintf.constprop.0+0x20>
 455:	83 ff 25             	cmp    $0x25,%edi
 458:	75 e5                	jne    43f <vprintf.constprop.0+0x3f>
 45a:	83 f8 64             	cmp    $0x64,%eax
 45d:	8d 7e 04             	lea    0x4(%esi),%edi
 460:	b9 01 00 00 00       	mov    $0x1,%ecx
 465:	0f 84 9a 00 00 00    	je     505 <vprintf.constprop.0+0x105>
 46b:	83 f8 6c             	cmp    $0x6c,%eax
 46e:	0f 84 8c 00 00 00    	je     500 <vprintf.constprop.0+0x100>
 474:	83 f8 78             	cmp    $0x78,%eax
 477:	0f 84 a3 00 00 00    	je     520 <vprintf.constprop.0+0x120>
 47d:	83 f8 70             	cmp    $0x70,%eax
 480:	0f 84 ca 00 00 00    	je     550 <vprintf.constprop.0+0x150>
 486:	83 f8 73             	cmp    $0x73,%eax
 489:	0f 84 39 01 00 00    	je     5c8 <vprintf.constprop.0+0x1c8>
 48f:	83 f8 63             	cmp    $0x63,%eax
 492:	0f 84 68 01 00 00    	je     600 <vprintf.constprop.0+0x200>
 498:	83 f8 25             	cmp    $0x25,%eax
 49b:	0f 84 9f 00 00 00    	je     540 <vprintf.constprop.0+0x140>
 4a1:	8d 45 df             	lea    -0x21(%ebp),%eax
 4a4:	83 ec 04             	sub    $0x4,%esp
 4a7:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 4aa:	6a 01                	push   $0x1
 4ac:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 4b0:	50                   	push   %eax
 4b1:	6a 01                	push   $0x1
 4b3:	e8 2a fe ff ff       	call   2e2 <write>
 4b8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 4bc:	83 c4 0c             	add    $0xc,%esp
 4bf:	8d 45 e0             	lea    -0x20(%ebp),%eax
 4c2:	6a 01                	push   $0x1
 4c4:	88 55 e0             	mov    %dl,-0x20(%ebp)
 4c7:	50                   	push   %eax
 4c8:	6a 01                	push   $0x1
 4ca:	83 c3 01             	add    $0x1,%ebx
 4cd:	31 ff                	xor    %edi,%edi
 4cf:	e8 0e fe ff ff       	call   2e2 <write>
 4d4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4d8:	83 c4 10             	add    $0x10,%esp
 4db:	84 d2                	test   %dl,%dl
 4dd:	0f 85 6b ff ff ff    	jne    44e <vprintf.constprop.0+0x4e>
 4e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4e6:	5b                   	pop    %ebx
 4e7:	5e                   	pop    %esi
 4e8:	5f                   	pop    %edi
 4e9:	5d                   	pop    %ebp
 4ea:	c3                   	ret    
 4eb:	90                   	nop
 4ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4f0:	bf 25 00 00 00       	mov    $0x25,%edi
 4f5:	e9 45 ff ff ff       	jmp    43f <vprintf.constprop.0+0x3f>
 4fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 500:	8d 7e 04             	lea    0x4(%esi),%edi
 503:	31 c9                	xor    %ecx,%ecx
 505:	8b 06                	mov    (%esi),%eax
 507:	ba 0a 00 00 00       	mov    $0xa,%edx
 50c:	89 fe                	mov    %edi,%esi
 50e:	31 ff                	xor    %edi,%edi
 510:	e8 5b fe ff ff       	call   370 <printint.constprop.1>
 515:	e9 25 ff ff ff       	jmp    43f <vprintf.constprop.0+0x3f>
 51a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 520:	8b 06                	mov    (%esi),%eax
 522:	8d 7e 04             	lea    0x4(%esi),%edi
 525:	31 c9                	xor    %ecx,%ecx
 527:	ba 10 00 00 00       	mov    $0x10,%edx
 52c:	89 fe                	mov    %edi,%esi
 52e:	31 ff                	xor    %edi,%edi
 530:	e8 3b fe ff ff       	call   370 <printint.constprop.1>
 535:	e9 05 ff ff ff       	jmp    43f <vprintf.constprop.0+0x3f>
 53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 540:	83 ec 04             	sub    $0x4,%esp
 543:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 546:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 549:	6a 01                	push   $0x1
 54b:	e9 77 ff ff ff       	jmp    4c7 <vprintf.constprop.0+0xc7>
 550:	8d 46 04             	lea    0x4(%esi),%eax
 553:	83 ec 04             	sub    $0x4,%esp
 556:	8b 3e                	mov    (%esi),%edi
 558:	6a 01                	push   $0x1
 55a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 55e:	be 08 00 00 00       	mov    $0x8,%esi
 563:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 566:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 569:	50                   	push   %eax
 56a:	6a 01                	push   $0x1
 56c:	e8 71 fd ff ff       	call   2e2 <write>
 571:	8d 45 e7             	lea    -0x19(%ebp),%eax
 574:	83 c4 0c             	add    $0xc,%esp
 577:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 57b:	6a 01                	push   $0x1
 57d:	50                   	push   %eax
 57e:	6a 01                	push   $0x1
 580:	e8 5d fd ff ff       	call   2e2 <write>
 585:	83 c4 10             	add    $0x10,%esp
 588:	90                   	nop
 589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 590:	89 f8                	mov    %edi,%eax
 592:	83 ec 04             	sub    $0x4,%esp
 595:	c1 e7 04             	shl    $0x4,%edi
 598:	c1 e8 1c             	shr    $0x1c,%eax
 59b:	6a 01                	push   $0x1
 59d:	0f b6 80 20 08 00 00 	movzbl 0x820(%eax),%eax
 5a4:	88 45 e5             	mov    %al,-0x1b(%ebp)
 5a7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5aa:	50                   	push   %eax
 5ab:	6a 01                	push   $0x1
 5ad:	e8 30 fd ff ff       	call   2e2 <write>
 5b2:	83 c4 10             	add    $0x10,%esp
 5b5:	83 ee 01             	sub    $0x1,%esi
 5b8:	75 d6                	jne    590 <vprintf.constprop.0+0x190>
 5ba:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 5bd:	31 ff                	xor    %edi,%edi
 5bf:	e9 7b fe ff ff       	jmp    43f <vprintf.constprop.0+0x3f>
 5c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5c8:	8b 3e                	mov    (%esi),%edi
 5ca:	8d 46 04             	lea    0x4(%esi),%eax
 5cd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5d0:	85 ff                	test   %edi,%edi
 5d2:	74 50                	je     624 <vprintf.constprop.0+0x224>
 5d4:	0f b6 07             	movzbl (%edi),%eax
 5d7:	84 c0                	test   %al,%al
 5d9:	74 df                	je     5ba <vprintf.constprop.0+0x1ba>
 5db:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 5de:	66 90                	xchg   %ax,%ax
 5e0:	83 ec 04             	sub    $0x4,%esp
 5e3:	83 c7 01             	add    $0x1,%edi
 5e6:	88 45 e3             	mov    %al,-0x1d(%ebp)
 5e9:	6a 01                	push   $0x1
 5eb:	56                   	push   %esi
 5ec:	6a 01                	push   $0x1
 5ee:	e8 ef fc ff ff       	call   2e2 <write>
 5f3:	0f b6 07             	movzbl (%edi),%eax
 5f6:	83 c4 10             	add    $0x10,%esp
 5f9:	84 c0                	test   %al,%al
 5fb:	75 e3                	jne    5e0 <vprintf.constprop.0+0x1e0>
 5fd:	eb bb                	jmp    5ba <vprintf.constprop.0+0x1ba>
 5ff:	90                   	nop
 600:	8b 06                	mov    (%esi),%eax
 602:	83 ec 04             	sub    $0x4,%esp
 605:	8d 7e 04             	lea    0x4(%esi),%edi
 608:	6a 01                	push   $0x1
 60a:	89 fe                	mov    %edi,%esi
 60c:	31 ff                	xor    %edi,%edi
 60e:	88 45 e2             	mov    %al,-0x1e(%ebp)
 611:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 614:	50                   	push   %eax
 615:	6a 01                	push   $0x1
 617:	e8 c6 fc ff ff       	call   2e2 <write>
 61c:	83 c4 10             	add    $0x10,%esp
 61f:	e9 1b fe ff ff       	jmp    43f <vprintf.constprop.0+0x3f>
 624:	bf 19 08 00 00       	mov    $0x819,%edi
 629:	b8 28 00 00 00       	mov    $0x28,%eax
 62e:	eb ab                	jmp    5db <vprintf.constprop.0+0x1db>

00000630 <fprintf>:
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	83 ec 08             	sub    $0x8,%esp
 636:	8b 45 0c             	mov    0xc(%ebp),%eax
 639:	8d 55 10             	lea    0x10(%ebp),%edx
 63c:	e8 bf fd ff ff       	call   400 <vprintf.constprop.0>
 641:	c9                   	leave  
 642:	c3                   	ret    
 643:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000650 <printf>:
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	83 ec 08             	sub    $0x8,%esp
 656:	8b 45 08             	mov    0x8(%ebp),%eax
 659:	8d 55 0c             	lea    0xc(%ebp),%edx
 65c:	e8 9f fd ff ff       	call   400 <vprintf.constprop.0>
 661:	c9                   	leave  
 662:	c3                   	ret    
 663:	66 90                	xchg   %ax,%ax
 665:	66 90                	xchg   %ax,%ax
 667:	66 90                	xchg   %ax,%ax
 669:	66 90                	xchg   %ax,%ax
 66b:	66 90                	xchg   %ax,%ax
 66d:	66 90                	xchg   %ax,%ax
 66f:	90                   	nop

00000670 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 670:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 671:	a1 10 0b 00 00       	mov    0xb10,%eax
{
 676:	89 e5                	mov    %esp,%ebp
 678:	57                   	push   %edi
 679:	56                   	push   %esi
 67a:	53                   	push   %ebx
 67b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 67e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 688:	39 c8                	cmp    %ecx,%eax
 68a:	8b 10                	mov    (%eax),%edx
 68c:	73 32                	jae    6c0 <free+0x50>
 68e:	39 d1                	cmp    %edx,%ecx
 690:	72 04                	jb     696 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 692:	39 d0                	cmp    %edx,%eax
 694:	72 32                	jb     6c8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 696:	8b 73 fc             	mov    -0x4(%ebx),%esi
 699:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 69c:	39 fa                	cmp    %edi,%edx
 69e:	74 30                	je     6d0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6a0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6a3:	8b 50 04             	mov    0x4(%eax),%edx
 6a6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6a9:	39 f1                	cmp    %esi,%ecx
 6ab:	74 3a                	je     6e7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6ad:	89 08                	mov    %ecx,(%eax)
  freep = p;
 6af:	a3 10 0b 00 00       	mov    %eax,0xb10
}
 6b4:	5b                   	pop    %ebx
 6b5:	5e                   	pop    %esi
 6b6:	5f                   	pop    %edi
 6b7:	5d                   	pop    %ebp
 6b8:	c3                   	ret    
 6b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c0:	39 d0                	cmp    %edx,%eax
 6c2:	72 04                	jb     6c8 <free+0x58>
 6c4:	39 d1                	cmp    %edx,%ecx
 6c6:	72 ce                	jb     696 <free+0x26>
{
 6c8:	89 d0                	mov    %edx,%eax
 6ca:	eb bc                	jmp    688 <free+0x18>
 6cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 6d0:	03 72 04             	add    0x4(%edx),%esi
 6d3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6d6:	8b 10                	mov    (%eax),%edx
 6d8:	8b 12                	mov    (%edx),%edx
 6da:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6dd:	8b 50 04             	mov    0x4(%eax),%edx
 6e0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6e3:	39 f1                	cmp    %esi,%ecx
 6e5:	75 c6                	jne    6ad <free+0x3d>
    p->s.size += bp->s.size;
 6e7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6ea:	a3 10 0b 00 00       	mov    %eax,0xb10
    p->s.size += bp->s.size;
 6ef:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6f2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6f5:	89 10                	mov    %edx,(%eax)
}
 6f7:	5b                   	pop    %ebx
 6f8:	5e                   	pop    %esi
 6f9:	5f                   	pop    %edi
 6fa:	5d                   	pop    %ebp
 6fb:	c3                   	ret    
 6fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000700 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	57                   	push   %edi
 704:	56                   	push   %esi
 705:	53                   	push   %ebx
 706:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 709:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 70c:	8b 15 10 0b 00 00    	mov    0xb10,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 712:	8d 78 07             	lea    0x7(%eax),%edi
 715:	c1 ef 03             	shr    $0x3,%edi
 718:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 71b:	85 d2                	test   %edx,%edx
 71d:	0f 84 9d 00 00 00    	je     7c0 <malloc+0xc0>
 723:	8b 02                	mov    (%edx),%eax
 725:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 728:	39 cf                	cmp    %ecx,%edi
 72a:	76 6c                	jbe    798 <malloc+0x98>
 72c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 732:	bb 00 10 00 00       	mov    $0x1000,%ebx
 737:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 73a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 741:	eb 0e                	jmp    751 <malloc+0x51>
 743:	90                   	nop
 744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 748:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 74a:	8b 48 04             	mov    0x4(%eax),%ecx
 74d:	39 f9                	cmp    %edi,%ecx
 74f:	73 47                	jae    798 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 751:	39 05 10 0b 00 00    	cmp    %eax,0xb10
 757:	89 c2                	mov    %eax,%edx
 759:	75 ed                	jne    748 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 75b:	83 ec 0c             	sub    $0xc,%esp
 75e:	56                   	push   %esi
 75f:	e8 e6 fb ff ff       	call   34a <sbrk>
  if(p == (char*)-1)
 764:	83 c4 10             	add    $0x10,%esp
 767:	83 f8 ff             	cmp    $0xffffffff,%eax
 76a:	74 1c                	je     788 <malloc+0x88>
  hp->s.size = nu;
 76c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 76f:	83 ec 0c             	sub    $0xc,%esp
 772:	83 c0 08             	add    $0x8,%eax
 775:	50                   	push   %eax
 776:	e8 f5 fe ff ff       	call   670 <free>
  return freep;
 77b:	8b 15 10 0b 00 00    	mov    0xb10,%edx
      if((p = morecore(nunits)) == 0)
 781:	83 c4 10             	add    $0x10,%esp
 784:	85 d2                	test   %edx,%edx
 786:	75 c0                	jne    748 <malloc+0x48>
        return 0;
  }
}
 788:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 78b:	31 c0                	xor    %eax,%eax
}
 78d:	5b                   	pop    %ebx
 78e:	5e                   	pop    %esi
 78f:	5f                   	pop    %edi
 790:	5d                   	pop    %ebp
 791:	c3                   	ret    
 792:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 798:	39 cf                	cmp    %ecx,%edi
 79a:	74 54                	je     7f0 <malloc+0xf0>
        p->s.size -= nunits;
 79c:	29 f9                	sub    %edi,%ecx
 79e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7a1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7a4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7a7:	89 15 10 0b 00 00    	mov    %edx,0xb10
}
 7ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7b0:	83 c0 08             	add    $0x8,%eax
}
 7b3:	5b                   	pop    %ebx
 7b4:	5e                   	pop    %esi
 7b5:	5f                   	pop    %edi
 7b6:	5d                   	pop    %ebp
 7b7:	c3                   	ret    
 7b8:	90                   	nop
 7b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 7c0:	c7 05 10 0b 00 00 14 	movl   $0xb14,0xb10
 7c7:	0b 00 00 
 7ca:	c7 05 14 0b 00 00 14 	movl   $0xb14,0xb14
 7d1:	0b 00 00 
    base.s.size = 0;
 7d4:	b8 14 0b 00 00       	mov    $0xb14,%eax
 7d9:	c7 05 18 0b 00 00 00 	movl   $0x0,0xb18
 7e0:	00 00 00 
 7e3:	e9 44 ff ff ff       	jmp    72c <malloc+0x2c>
 7e8:	90                   	nop
 7e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 7f0:	8b 08                	mov    (%eax),%ecx
 7f2:	89 0a                	mov    %ecx,(%edx)
 7f4:	eb b1                	jmp    7a7 <malloc+0xa7>
