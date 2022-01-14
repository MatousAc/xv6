
user/_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  11:	e8 64 02 00 00       	call   27a <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0d                	jle    27 <main+0x27>
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 05                	push   $0x5
  1f:	e8 ee 02 00 00       	call   312 <sleep>
  24:	83 c4 10             	add    $0x10,%esp
  27:	e8 56 02 00 00       	call   282 <exit>
  2c:	66 90                	xchg   %ax,%ax
  2e:	66 90                	xchg   %ax,%ax

00000030 <strcpy>:
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	53                   	push   %ebx
  34:	8b 45 08             	mov    0x8(%ebp),%eax
  37:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  3a:	89 c2                	mov    %eax,%edx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  40:	83 c1 01             	add    $0x1,%ecx
  43:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  47:	83 c2 01             	add    $0x1,%edx
  4a:	84 db                	test   %bl,%bl
  4c:	88 5a ff             	mov    %bl,-0x1(%edx)
  4f:	75 ef                	jne    40 <strcpy+0x10>
  51:	5b                   	pop    %ebx
  52:	5d                   	pop    %ebp
  53:	c3                   	ret    
  54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000060 <strcmp>:
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 55 08             	mov    0x8(%ebp),%edx
  67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  6a:	0f b6 02             	movzbl (%edx),%eax
  6d:	0f b6 19             	movzbl (%ecx),%ebx
  70:	84 c0                	test   %al,%al
  72:	75 1c                	jne    90 <strcmp+0x30>
  74:	eb 2a                	jmp    a0 <strcmp+0x40>
  76:	8d 76 00             	lea    0x0(%esi),%esi
  79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  80:	83 c2 01             	add    $0x1,%edx
  83:	0f b6 02             	movzbl (%edx),%eax
  86:	83 c1 01             	add    $0x1,%ecx
  89:	0f b6 19             	movzbl (%ecx),%ebx
  8c:	84 c0                	test   %al,%al
  8e:	74 10                	je     a0 <strcmp+0x40>
  90:	38 d8                	cmp    %bl,%al
  92:	74 ec                	je     80 <strcmp+0x20>
  94:	29 d8                	sub    %ebx,%eax
  96:	5b                   	pop    %ebx
  97:	5d                   	pop    %ebp
  98:	c3                   	ret    
  99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  a0:	31 c0                	xor    %eax,%eax
  a2:	29 d8                	sub    %ebx,%eax
  a4:	5b                   	pop    %ebx
  a5:	5d                   	pop    %ebp
  a6:	c3                   	ret    
  a7:	89 f6                	mov    %esi,%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000b0 <strlen>:
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  b6:	80 39 00             	cmpb   $0x0,(%ecx)
  b9:	74 15                	je     d0 <strlen+0x20>
  bb:	31 d2                	xor    %edx,%edx
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  c0:	83 c2 01             	add    $0x1,%edx
  c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  c7:	89 d0                	mov    %edx,%eax
  c9:	75 f5                	jne    c0 <strlen+0x10>
  cb:	5d                   	pop    %ebp
  cc:	c3                   	ret    
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  d0:	31 c0                	xor    %eax,%eax
  d2:	5d                   	pop    %ebp
  d3:	c3                   	ret    
  d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000e0 <memset>:
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	57                   	push   %edi
  e4:	8b 55 08             	mov    0x8(%ebp),%edx
  e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  ed:	89 d7                	mov    %edx,%edi
  ef:	fc                   	cld    
  f0:	f3 aa                	rep stos %al,%es:(%edi)
  f2:	89 d0                	mov    %edx,%eax
  f4:	5f                   	pop    %edi
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strchr>:
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	53                   	push   %ebx
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 10a:	0f b6 10             	movzbl (%eax),%edx
 10d:	84 d2                	test   %dl,%dl
 10f:	74 1d                	je     12e <strchr+0x2e>
 111:	38 d3                	cmp    %dl,%bl
 113:	89 d9                	mov    %ebx,%ecx
 115:	75 0d                	jne    124 <strchr+0x24>
 117:	eb 17                	jmp    130 <strchr+0x30>
 119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 120:	38 ca                	cmp    %cl,%dl
 122:	74 0c                	je     130 <strchr+0x30>
 124:	83 c0 01             	add    $0x1,%eax
 127:	0f b6 10             	movzbl (%eax),%edx
 12a:	84 d2                	test   %dl,%dl
 12c:	75 f2                	jne    120 <strchr+0x20>
 12e:	31 c0                	xor    %eax,%eax
 130:	5b                   	pop    %ebx
 131:	5d                   	pop    %ebp
 132:	c3                   	ret    
 133:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000140 <gets>:
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	56                   	push   %esi
 145:	53                   	push   %ebx
 146:	31 f6                	xor    %esi,%esi
 148:	89 f3                	mov    %esi,%ebx
 14a:	83 ec 1c             	sub    $0x1c,%esp
 14d:	8b 7d 08             	mov    0x8(%ebp),%edi
 150:	eb 2f                	jmp    181 <gets+0x41>
 152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 158:	8d 45 e7             	lea    -0x19(%ebp),%eax
 15b:	83 ec 04             	sub    $0x4,%esp
 15e:	6a 01                	push   $0x1
 160:	50                   	push   %eax
 161:	6a 00                	push   $0x0
 163:	e8 32 01 00 00       	call   29a <read>
 168:	83 c4 10             	add    $0x10,%esp
 16b:	85 c0                	test   %eax,%eax
 16d:	7e 1c                	jle    18b <gets+0x4b>
 16f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 173:	83 c7 01             	add    $0x1,%edi
 176:	88 47 ff             	mov    %al,-0x1(%edi)
 179:	3c 0a                	cmp    $0xa,%al
 17b:	74 23                	je     1a0 <gets+0x60>
 17d:	3c 0d                	cmp    $0xd,%al
 17f:	74 1f                	je     1a0 <gets+0x60>
 181:	83 c3 01             	add    $0x1,%ebx
 184:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 187:	89 fe                	mov    %edi,%esi
 189:	7c cd                	jl     158 <gets+0x18>
 18b:	89 f3                	mov    %esi,%ebx
 18d:	8b 45 08             	mov    0x8(%ebp),%eax
 190:	c6 03 00             	movb   $0x0,(%ebx)
 193:	8d 65 f4             	lea    -0xc(%ebp),%esp
 196:	5b                   	pop    %ebx
 197:	5e                   	pop    %esi
 198:	5f                   	pop    %edi
 199:	5d                   	pop    %ebp
 19a:	c3                   	ret    
 19b:	90                   	nop
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a0:	8b 75 08             	mov    0x8(%ebp),%esi
 1a3:	8b 45 08             	mov    0x8(%ebp),%eax
 1a6:	01 de                	add    %ebx,%esi
 1a8:	89 f3                	mov    %esi,%ebx
 1aa:	c6 03 00             	movb   $0x0,(%ebx)
 1ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1b0:	5b                   	pop    %ebx
 1b1:	5e                   	pop    %esi
 1b2:	5f                   	pop    %edi
 1b3:	5d                   	pop    %ebp
 1b4:	c3                   	ret    
 1b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <stat>:
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	56                   	push   %esi
 1c4:	53                   	push   %ebx
 1c5:	83 ec 08             	sub    $0x8,%esp
 1c8:	6a 00                	push   $0x0
 1ca:	ff 75 08             	pushl  0x8(%ebp)
 1cd:	e8 f0 00 00 00       	call   2c2 <open>
 1d2:	83 c4 10             	add    $0x10,%esp
 1d5:	85 c0                	test   %eax,%eax
 1d7:	78 27                	js     200 <stat+0x40>
 1d9:	83 ec 08             	sub    $0x8,%esp
 1dc:	ff 75 0c             	pushl  0xc(%ebp)
 1df:	89 c3                	mov    %eax,%ebx
 1e1:	50                   	push   %eax
 1e2:	e8 f3 00 00 00       	call   2da <fstat>
 1e7:	89 1c 24             	mov    %ebx,(%esp)
 1ea:	89 c6                	mov    %eax,%esi
 1ec:	e8 b9 00 00 00       	call   2aa <close>
 1f1:	83 c4 10             	add    $0x10,%esp
 1f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1f7:	89 f0                	mov    %esi,%eax
 1f9:	5b                   	pop    %ebx
 1fa:	5e                   	pop    %esi
 1fb:	5d                   	pop    %ebp
 1fc:	c3                   	ret    
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
 200:	be ff ff ff ff       	mov    $0xffffffff,%esi
 205:	eb ed                	jmp    1f4 <stat+0x34>
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <atoi>:
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 4d 08             	mov    0x8(%ebp),%ecx
 217:	0f be 11             	movsbl (%ecx),%edx
 21a:	8d 42 d0             	lea    -0x30(%edx),%eax
 21d:	3c 09                	cmp    $0x9,%al
 21f:	b8 00 00 00 00       	mov    $0x0,%eax
 224:	77 1f                	ja     245 <atoi+0x35>
 226:	8d 76 00             	lea    0x0(%esi),%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 230:	8d 04 80             	lea    (%eax,%eax,4),%eax
 233:	83 c1 01             	add    $0x1,%ecx
 236:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 23a:	0f be 11             	movsbl (%ecx),%edx
 23d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 240:	80 fb 09             	cmp    $0x9,%bl
 243:	76 eb                	jbe    230 <atoi+0x20>
 245:	5b                   	pop    %ebx
 246:	5d                   	pop    %ebp
 247:	c3                   	ret    
 248:	90                   	nop
 249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000250 <memmove>:
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	56                   	push   %esi
 254:	53                   	push   %ebx
 255:	8b 5d 10             	mov    0x10(%ebp),%ebx
 258:	8b 45 08             	mov    0x8(%ebp),%eax
 25b:	8b 75 0c             	mov    0xc(%ebp),%esi
 25e:	85 db                	test   %ebx,%ebx
 260:	7e 14                	jle    276 <memmove+0x26>
 262:	31 d2                	xor    %edx,%edx
 264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 268:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 26c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 26f:	83 c2 01             	add    $0x1,%edx
 272:	39 d3                	cmp    %edx,%ebx
 274:	75 f2                	jne    268 <memmove+0x18>
 276:	5b                   	pop    %ebx
 277:	5e                   	pop    %esi
 278:	5d                   	pop    %ebp
 279:	c3                   	ret    

0000027a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 27a:	b8 01 00 00 00       	mov    $0x1,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <exit>:
SYSCALL(exit)
 282:	b8 02 00 00 00       	mov    $0x2,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <wait>:
SYSCALL(wait)
 28a:	b8 03 00 00 00       	mov    $0x3,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <pipe>:
SYSCALL(pipe)
 292:	b8 04 00 00 00       	mov    $0x4,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <read>:
SYSCALL(read)
 29a:	b8 05 00 00 00       	mov    $0x5,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <write>:
SYSCALL(write)
 2a2:	b8 10 00 00 00       	mov    $0x10,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <close>:
SYSCALL(close)
 2aa:	b8 15 00 00 00       	mov    $0x15,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <kill>:
SYSCALL(kill)
 2b2:	b8 06 00 00 00       	mov    $0x6,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <exec>:
SYSCALL(exec)
 2ba:	b8 07 00 00 00       	mov    $0x7,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <open>:
SYSCALL(open)
 2c2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <mknod>:
SYSCALL(mknod)
 2ca:	b8 11 00 00 00       	mov    $0x11,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <unlink>:
SYSCALL(unlink)
 2d2:	b8 12 00 00 00       	mov    $0x12,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <fstat>:
SYSCALL(fstat)
 2da:	b8 08 00 00 00       	mov    $0x8,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <link>:
SYSCALL(link)
 2e2:	b8 13 00 00 00       	mov    $0x13,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <mkdir>:
SYSCALL(mkdir)
 2ea:	b8 14 00 00 00       	mov    $0x14,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <chdir>:
SYSCALL(chdir)
 2f2:	b8 09 00 00 00       	mov    $0x9,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <dup>:
SYSCALL(dup)
 2fa:	b8 0a 00 00 00       	mov    $0xa,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <getpid>:
SYSCALL(getpid)
 302:	b8 0b 00 00 00       	mov    $0xb,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <sbrk>:
SYSCALL(sbrk)
 30a:	b8 0c 00 00 00       	mov    $0xc,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <sleep>:
SYSCALL(sleep)
 312:	b8 0d 00 00 00       	mov    $0xd,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <uptime>:
SYSCALL(uptime)
 31a:	b8 0e 00 00 00       	mov    $0xe,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <cpuhalt>:
SYSCALL(cpuhalt)
 322:	b8 16 00 00 00       	mov    $0x16,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    
 32a:	66 90                	xchg   %ax,%ax
 32c:	66 90                	xchg   %ax,%ax
 32e:	66 90                	xchg   %ax,%ax

00000330 <printint.constprop.1>:
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
 335:	53                   	push   %ebx
 336:	89 d6                	mov    %edx,%esi
 338:	83 ec 3c             	sub    $0x3c,%esp
 33b:	85 c0                	test   %eax,%eax
 33d:	79 71                	jns    3b0 <printint.constprop.1+0x80>
 33f:	83 e1 01             	and    $0x1,%ecx
 342:	74 6c                	je     3b0 <printint.constprop.1+0x80>
 344:	f7 d8                	neg    %eax
 346:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 34d:	31 c9                	xor    %ecx,%ecx
 34f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 352:	eb 06                	jmp    35a <printint.constprop.1+0x2a>
 354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 358:	89 f9                	mov    %edi,%ecx
 35a:	31 d2                	xor    %edx,%edx
 35c:	8d 79 01             	lea    0x1(%ecx),%edi
 35f:	f7 f6                	div    %esi
 361:	0f b6 92 c0 07 00 00 	movzbl 0x7c0(%edx),%edx
 368:	85 c0                	test   %eax,%eax
 36a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
 36d:	75 e9                	jne    358 <printint.constprop.1+0x28>
 36f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 372:	85 c0                	test   %eax,%eax
 374:	74 08                	je     37e <printint.constprop.1+0x4e>
 376:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 37b:	8d 79 02             	lea    0x2(%ecx),%edi
 37e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 388:	0f b6 06             	movzbl (%esi),%eax
 38b:	83 ec 04             	sub    $0x4,%esp
 38e:	83 ee 01             	sub    $0x1,%esi
 391:	6a 01                	push   $0x1
 393:	53                   	push   %ebx
 394:	6a 01                	push   $0x1
 396:	88 45 d7             	mov    %al,-0x29(%ebp)
 399:	e8 04 ff ff ff       	call   2a2 <write>
 39e:	83 c4 10             	add    $0x10,%esp
 3a1:	39 de                	cmp    %ebx,%esi
 3a3:	75 e3                	jne    388 <printint.constprop.1+0x58>
 3a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3a8:	5b                   	pop    %ebx
 3a9:	5e                   	pop    %esi
 3aa:	5f                   	pop    %edi
 3ab:	5d                   	pop    %ebp
 3ac:	c3                   	ret    
 3ad:	8d 76 00             	lea    0x0(%esi),%esi
 3b0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3b7:	eb 94                	jmp    34d <printint.constprop.1+0x1d>
 3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003c0 <vprintf.constprop.0>:
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	53                   	push   %ebx
 3c6:	89 d6                	mov    %edx,%esi
 3c8:	83 ec 2c             	sub    $0x2c,%esp
 3cb:	0f b6 10             	movzbl (%eax),%edx
 3ce:	84 d2                	test   %dl,%dl
 3d0:	0f 84 cd 00 00 00    	je     4a3 <vprintf.constprop.0+0xe3>
 3d6:	8d 58 01             	lea    0x1(%eax),%ebx
 3d9:	31 ff                	xor    %edi,%edi
 3db:	eb 31                	jmp    40e <vprintf.constprop.0+0x4e>
 3dd:	8d 76 00             	lea    0x0(%esi),%esi
 3e0:	83 f8 25             	cmp    $0x25,%eax
 3e3:	0f 84 c7 00 00 00    	je     4b0 <vprintf.constprop.0+0xf0>
 3e9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 3ec:	83 ec 04             	sub    $0x4,%esp
 3ef:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 3f2:	6a 01                	push   $0x1
 3f4:	50                   	push   %eax
 3f5:	6a 01                	push   $0x1
 3f7:	e8 a6 fe ff ff       	call   2a2 <write>
 3fc:	83 c4 10             	add    $0x10,%esp
 3ff:	83 c3 01             	add    $0x1,%ebx
 402:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 406:	84 d2                	test   %dl,%dl
 408:	0f 84 95 00 00 00    	je     4a3 <vprintf.constprop.0+0xe3>
 40e:	85 ff                	test   %edi,%edi
 410:	0f b6 c2             	movzbl %dl,%eax
 413:	74 cb                	je     3e0 <vprintf.constprop.0+0x20>
 415:	83 ff 25             	cmp    $0x25,%edi
 418:	75 e5                	jne    3ff <vprintf.constprop.0+0x3f>
 41a:	83 f8 64             	cmp    $0x64,%eax
 41d:	8d 7e 04             	lea    0x4(%esi),%edi
 420:	b9 01 00 00 00       	mov    $0x1,%ecx
 425:	0f 84 9a 00 00 00    	je     4c5 <vprintf.constprop.0+0x105>
 42b:	83 f8 6c             	cmp    $0x6c,%eax
 42e:	0f 84 8c 00 00 00    	je     4c0 <vprintf.constprop.0+0x100>
 434:	83 f8 78             	cmp    $0x78,%eax
 437:	0f 84 a3 00 00 00    	je     4e0 <vprintf.constprop.0+0x120>
 43d:	83 f8 70             	cmp    $0x70,%eax
 440:	0f 84 ca 00 00 00    	je     510 <vprintf.constprop.0+0x150>
 446:	83 f8 73             	cmp    $0x73,%eax
 449:	0f 84 39 01 00 00    	je     588 <vprintf.constprop.0+0x1c8>
 44f:	83 f8 63             	cmp    $0x63,%eax
 452:	0f 84 68 01 00 00    	je     5c0 <vprintf.constprop.0+0x200>
 458:	83 f8 25             	cmp    $0x25,%eax
 45b:	0f 84 9f 00 00 00    	je     500 <vprintf.constprop.0+0x140>
 461:	8d 45 df             	lea    -0x21(%ebp),%eax
 464:	83 ec 04             	sub    $0x4,%esp
 467:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 46a:	6a 01                	push   $0x1
 46c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 470:	50                   	push   %eax
 471:	6a 01                	push   $0x1
 473:	e8 2a fe ff ff       	call   2a2 <write>
 478:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 47c:	83 c4 0c             	add    $0xc,%esp
 47f:	8d 45 e0             	lea    -0x20(%ebp),%eax
 482:	6a 01                	push   $0x1
 484:	88 55 e0             	mov    %dl,-0x20(%ebp)
 487:	50                   	push   %eax
 488:	6a 01                	push   $0x1
 48a:	83 c3 01             	add    $0x1,%ebx
 48d:	31 ff                	xor    %edi,%edi
 48f:	e8 0e fe ff ff       	call   2a2 <write>
 494:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 498:	83 c4 10             	add    $0x10,%esp
 49b:	84 d2                	test   %dl,%dl
 49d:	0f 85 6b ff ff ff    	jne    40e <vprintf.constprop.0+0x4e>
 4a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4a6:	5b                   	pop    %ebx
 4a7:	5e                   	pop    %esi
 4a8:	5f                   	pop    %edi
 4a9:	5d                   	pop    %ebp
 4aa:	c3                   	ret    
 4ab:	90                   	nop
 4ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4b0:	bf 25 00 00 00       	mov    $0x25,%edi
 4b5:	e9 45 ff ff ff       	jmp    3ff <vprintf.constprop.0+0x3f>
 4ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4c0:	8d 7e 04             	lea    0x4(%esi),%edi
 4c3:	31 c9                	xor    %ecx,%ecx
 4c5:	8b 06                	mov    (%esi),%eax
 4c7:	ba 0a 00 00 00       	mov    $0xa,%edx
 4cc:	89 fe                	mov    %edi,%esi
 4ce:	31 ff                	xor    %edi,%edi
 4d0:	e8 5b fe ff ff       	call   330 <printint.constprop.1>
 4d5:	e9 25 ff ff ff       	jmp    3ff <vprintf.constprop.0+0x3f>
 4da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4e0:	8b 06                	mov    (%esi),%eax
 4e2:	8d 7e 04             	lea    0x4(%esi),%edi
 4e5:	31 c9                	xor    %ecx,%ecx
 4e7:	ba 10 00 00 00       	mov    $0x10,%edx
 4ec:	89 fe                	mov    %edi,%esi
 4ee:	31 ff                	xor    %edi,%edi
 4f0:	e8 3b fe ff ff       	call   330 <printint.constprop.1>
 4f5:	e9 05 ff ff ff       	jmp    3ff <vprintf.constprop.0+0x3f>
 4fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 500:	83 ec 04             	sub    $0x4,%esp
 503:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 506:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 509:	6a 01                	push   $0x1
 50b:	e9 77 ff ff ff       	jmp    487 <vprintf.constprop.0+0xc7>
 510:	8d 46 04             	lea    0x4(%esi),%eax
 513:	83 ec 04             	sub    $0x4,%esp
 516:	8b 3e                	mov    (%esi),%edi
 518:	6a 01                	push   $0x1
 51a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 51e:	be 08 00 00 00       	mov    $0x8,%esi
 523:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 526:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 529:	50                   	push   %eax
 52a:	6a 01                	push   $0x1
 52c:	e8 71 fd ff ff       	call   2a2 <write>
 531:	8d 45 e7             	lea    -0x19(%ebp),%eax
 534:	83 c4 0c             	add    $0xc,%esp
 537:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 53b:	6a 01                	push   $0x1
 53d:	50                   	push   %eax
 53e:	6a 01                	push   $0x1
 540:	e8 5d fd ff ff       	call   2a2 <write>
 545:	83 c4 10             	add    $0x10,%esp
 548:	90                   	nop
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 550:	89 f8                	mov    %edi,%eax
 552:	83 ec 04             	sub    $0x4,%esp
 555:	c1 e7 04             	shl    $0x4,%edi
 558:	c1 e8 1c             	shr    $0x1c,%eax
 55b:	6a 01                	push   $0x1
 55d:	0f b6 80 c0 07 00 00 	movzbl 0x7c0(%eax),%eax
 564:	88 45 e5             	mov    %al,-0x1b(%ebp)
 567:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 56a:	50                   	push   %eax
 56b:	6a 01                	push   $0x1
 56d:	e8 30 fd ff ff       	call   2a2 <write>
 572:	83 c4 10             	add    $0x10,%esp
 575:	83 ee 01             	sub    $0x1,%esi
 578:	75 d6                	jne    550 <vprintf.constprop.0+0x190>
 57a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 57d:	31 ff                	xor    %edi,%edi
 57f:	e9 7b fe ff ff       	jmp    3ff <vprintf.constprop.0+0x3f>
 584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 588:	8b 3e                	mov    (%esi),%edi
 58a:	8d 46 04             	lea    0x4(%esi),%eax
 58d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 590:	85 ff                	test   %edi,%edi
 592:	74 50                	je     5e4 <vprintf.constprop.0+0x224>
 594:	0f b6 07             	movzbl (%edi),%eax
 597:	84 c0                	test   %al,%al
 599:	74 df                	je     57a <vprintf.constprop.0+0x1ba>
 59b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 59e:	66 90                	xchg   %ax,%ax
 5a0:	83 ec 04             	sub    $0x4,%esp
 5a3:	83 c7 01             	add    $0x1,%edi
 5a6:	88 45 e3             	mov    %al,-0x1d(%ebp)
 5a9:	6a 01                	push   $0x1
 5ab:	56                   	push   %esi
 5ac:	6a 01                	push   $0x1
 5ae:	e8 ef fc ff ff       	call   2a2 <write>
 5b3:	0f b6 07             	movzbl (%edi),%eax
 5b6:	83 c4 10             	add    $0x10,%esp
 5b9:	84 c0                	test   %al,%al
 5bb:	75 e3                	jne    5a0 <vprintf.constprop.0+0x1e0>
 5bd:	eb bb                	jmp    57a <vprintf.constprop.0+0x1ba>
 5bf:	90                   	nop
 5c0:	8b 06                	mov    (%esi),%eax
 5c2:	83 ec 04             	sub    $0x4,%esp
 5c5:	8d 7e 04             	lea    0x4(%esi),%edi
 5c8:	6a 01                	push   $0x1
 5ca:	89 fe                	mov    %edi,%esi
 5cc:	31 ff                	xor    %edi,%edi
 5ce:	88 45 e2             	mov    %al,-0x1e(%ebp)
 5d1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5d4:	50                   	push   %eax
 5d5:	6a 01                	push   $0x1
 5d7:	e8 c6 fc ff ff       	call   2a2 <write>
 5dc:	83 c4 10             	add    $0x10,%esp
 5df:	e9 1b fe ff ff       	jmp    3ff <vprintf.constprop.0+0x3f>
 5e4:	bf b8 07 00 00       	mov    $0x7b8,%edi
 5e9:	b8 28 00 00 00       	mov    $0x28,%eax
 5ee:	eb ab                	jmp    59b <vprintf.constprop.0+0x1db>

000005f0 <fprintf>:
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	83 ec 08             	sub    $0x8,%esp
 5f6:	8b 45 0c             	mov    0xc(%ebp),%eax
 5f9:	8d 55 10             	lea    0x10(%ebp),%edx
 5fc:	e8 bf fd ff ff       	call   3c0 <vprintf.constprop.0>
 601:	c9                   	leave  
 602:	c3                   	ret    
 603:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000610 <printf>:
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	83 ec 08             	sub    $0x8,%esp
 616:	8b 45 08             	mov    0x8(%ebp),%eax
 619:	8d 55 0c             	lea    0xc(%ebp),%edx
 61c:	e8 9f fd ff ff       	call   3c0 <vprintf.constprop.0>
 621:	c9                   	leave  
 622:	c3                   	ret    
 623:	66 90                	xchg   %ax,%ax
 625:	66 90                	xchg   %ax,%ax
 627:	66 90                	xchg   %ax,%ax
 629:	66 90                	xchg   %ax,%ax
 62b:	66 90                	xchg   %ax,%ax
 62d:	66 90                	xchg   %ax,%ax
 62f:	90                   	nop

00000630 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 630:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 631:	a1 a4 0a 00 00       	mov    0xaa4,%eax
{
 636:	89 e5                	mov    %esp,%ebp
 638:	57                   	push   %edi
 639:	56                   	push   %esi
 63a:	53                   	push   %ebx
 63b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 63e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 648:	39 c8                	cmp    %ecx,%eax
 64a:	8b 10                	mov    (%eax),%edx
 64c:	73 32                	jae    680 <free+0x50>
 64e:	39 d1                	cmp    %edx,%ecx
 650:	72 04                	jb     656 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 652:	39 d0                	cmp    %edx,%eax
 654:	72 32                	jb     688 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 656:	8b 73 fc             	mov    -0x4(%ebx),%esi
 659:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 65c:	39 fa                	cmp    %edi,%edx
 65e:	74 30                	je     690 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 660:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 663:	8b 50 04             	mov    0x4(%eax),%edx
 666:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 669:	39 f1                	cmp    %esi,%ecx
 66b:	74 3a                	je     6a7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 66d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 66f:	a3 a4 0a 00 00       	mov    %eax,0xaa4
}
 674:	5b                   	pop    %ebx
 675:	5e                   	pop    %esi
 676:	5f                   	pop    %edi
 677:	5d                   	pop    %ebp
 678:	c3                   	ret    
 679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 680:	39 d0                	cmp    %edx,%eax
 682:	72 04                	jb     688 <free+0x58>
 684:	39 d1                	cmp    %edx,%ecx
 686:	72 ce                	jb     656 <free+0x26>
{
 688:	89 d0                	mov    %edx,%eax
 68a:	eb bc                	jmp    648 <free+0x18>
 68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 690:	03 72 04             	add    0x4(%edx),%esi
 693:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 696:	8b 10                	mov    (%eax),%edx
 698:	8b 12                	mov    (%edx),%edx
 69a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 69d:	8b 50 04             	mov    0x4(%eax),%edx
 6a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6a3:	39 f1                	cmp    %esi,%ecx
 6a5:	75 c6                	jne    66d <free+0x3d>
    p->s.size += bp->s.size;
 6a7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6aa:	a3 a4 0a 00 00       	mov    %eax,0xaa4
    p->s.size += bp->s.size;
 6af:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6b2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6b5:	89 10                	mov    %edx,(%eax)
}
 6b7:	5b                   	pop    %ebx
 6b8:	5e                   	pop    %esi
 6b9:	5f                   	pop    %edi
 6ba:	5d                   	pop    %ebp
 6bb:	c3                   	ret    
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
 6c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6cc:	8b 15 a4 0a 00 00    	mov    0xaa4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d2:	8d 78 07             	lea    0x7(%eax),%edi
 6d5:	c1 ef 03             	shr    $0x3,%edi
 6d8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6db:	85 d2                	test   %edx,%edx
 6dd:	0f 84 9d 00 00 00    	je     780 <malloc+0xc0>
 6e3:	8b 02                	mov    (%edx),%eax
 6e5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6e8:	39 cf                	cmp    %ecx,%edi
 6ea:	76 6c                	jbe    758 <malloc+0x98>
 6ec:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6f2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6f7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6fa:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 701:	eb 0e                	jmp    711 <malloc+0x51>
 703:	90                   	nop
 704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 708:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 70a:	8b 48 04             	mov    0x4(%eax),%ecx
 70d:	39 f9                	cmp    %edi,%ecx
 70f:	73 47                	jae    758 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 711:	39 05 a4 0a 00 00    	cmp    %eax,0xaa4
 717:	89 c2                	mov    %eax,%edx
 719:	75 ed                	jne    708 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 71b:	83 ec 0c             	sub    $0xc,%esp
 71e:	56                   	push   %esi
 71f:	e8 e6 fb ff ff       	call   30a <sbrk>
  if(p == (char*)-1)
 724:	83 c4 10             	add    $0x10,%esp
 727:	83 f8 ff             	cmp    $0xffffffff,%eax
 72a:	74 1c                	je     748 <malloc+0x88>
  hp->s.size = nu;
 72c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 72f:	83 ec 0c             	sub    $0xc,%esp
 732:	83 c0 08             	add    $0x8,%eax
 735:	50                   	push   %eax
 736:	e8 f5 fe ff ff       	call   630 <free>
  return freep;
 73b:	8b 15 a4 0a 00 00    	mov    0xaa4,%edx
      if((p = morecore(nunits)) == 0)
 741:	83 c4 10             	add    $0x10,%esp
 744:	85 d2                	test   %edx,%edx
 746:	75 c0                	jne    708 <malloc+0x48>
        return 0;
  }
}
 748:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 74b:	31 c0                	xor    %eax,%eax
}
 74d:	5b                   	pop    %ebx
 74e:	5e                   	pop    %esi
 74f:	5f                   	pop    %edi
 750:	5d                   	pop    %ebp
 751:	c3                   	ret    
 752:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 758:	39 cf                	cmp    %ecx,%edi
 75a:	74 54                	je     7b0 <malloc+0xf0>
        p->s.size -= nunits;
 75c:	29 f9                	sub    %edi,%ecx
 75e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 761:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 764:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 767:	89 15 a4 0a 00 00    	mov    %edx,0xaa4
}
 76d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 770:	83 c0 08             	add    $0x8,%eax
}
 773:	5b                   	pop    %ebx
 774:	5e                   	pop    %esi
 775:	5f                   	pop    %edi
 776:	5d                   	pop    %ebp
 777:	c3                   	ret    
 778:	90                   	nop
 779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 780:	c7 05 a4 0a 00 00 a8 	movl   $0xaa8,0xaa4
 787:	0a 00 00 
 78a:	c7 05 a8 0a 00 00 a8 	movl   $0xaa8,0xaa8
 791:	0a 00 00 
    base.s.size = 0;
 794:	b8 a8 0a 00 00       	mov    $0xaa8,%eax
 799:	c7 05 ac 0a 00 00 00 	movl   $0x0,0xaac
 7a0:	00 00 00 
 7a3:	e9 44 ff ff ff       	jmp    6ec <malloc+0x2c>
 7a8:	90                   	nop
 7a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 7b0:	8b 08                	mov    (%eax),%ecx
 7b2:	89 0a                	mov    %ecx,(%edx)
 7b4:	eb b1                	jmp    767 <malloc+0xa7>
