
user/_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	be 30 00 00 00       	mov    $0x30,%esi
  16:	31 db                	xor    %ebx,%ebx
  18:	81 ec 24 02 00 00    	sub    $0x224,%esp
  1e:	66 89 b5 e6 fd ff ff 	mov    %si,-0x21a(%ebp)
  25:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
  2b:	68 c8 08 00 00       	push   $0x8c8
  30:	c7 85 de fd ff ff 73 	movl   $0x65727473,-0x222(%ebp)
  37:	74 72 65 
  3a:	c7 85 e2 fd ff ff 73 	movl   $0x73667373,-0x21e(%ebp)
  41:	73 66 73 
  44:	e8 d7 06 00 00       	call   720 <printf>
  49:	83 c4 0c             	add    $0xc,%esp
  4c:	68 00 02 00 00       	push   $0x200
  51:	6a 61                	push   $0x61
  53:	56                   	push   %esi
  54:	e8 97 01 00 00       	call   1f0 <memset>
  59:	83 c4 10             	add    $0x10,%esp
  5c:	e8 29 03 00 00       	call   38a <fork>
  61:	85 c0                	test   %eax,%eax
  63:	0f 8f c1 00 00 00    	jg     12a <main+0x12a>
  69:	83 c3 01             	add    $0x1,%ebx
  6c:	83 fb 04             	cmp    $0x4,%ebx
  6f:	75 eb                	jne    5c <main+0x5c>
  71:	bf 04 00 00 00       	mov    $0x4,%edi
  76:	83 ec 08             	sub    $0x8,%esp
  79:	53                   	push   %ebx
  7a:	68 db 08 00 00       	push   $0x8db
  7f:	e8 9c 06 00 00       	call   720 <printf>
  84:	59                   	pop    %ecx
  85:	89 f8                	mov    %edi,%eax
  87:	00 85 e6 fd ff ff    	add    %al,-0x21a(%ebp)
  8d:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  93:	5b                   	pop    %ebx
  94:	68 02 02 00 00       	push   $0x202
  99:	50                   	push   %eax
  9a:	bb 14 00 00 00       	mov    $0x14,%ebx
  9f:	e8 2e 03 00 00       	call   3d2 <open>
  a4:	83 c4 10             	add    $0x10,%esp
  a7:	89 c7                	mov    %eax,%edi
  a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  b0:	83 ec 04             	sub    $0x4,%esp
  b3:	68 00 02 00 00       	push   $0x200
  b8:	56                   	push   %esi
  b9:	57                   	push   %edi
  ba:	e8 f3 02 00 00       	call   3b2 <write>
  bf:	83 c4 10             	add    $0x10,%esp
  c2:	83 eb 01             	sub    $0x1,%ebx
  c5:	75 e9                	jne    b0 <main+0xb0>
  c7:	83 ec 0c             	sub    $0xc,%esp
  ca:	bb 14 00 00 00       	mov    $0x14,%ebx
  cf:	57                   	push   %edi
  d0:	e8 e5 02 00 00       	call   3ba <close>
  d5:	c7 04 24 e5 08 00 00 	movl   $0x8e5,(%esp)
  dc:	e8 3f 06 00 00       	call   720 <printf>
  e1:	58                   	pop    %eax
  e2:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  e8:	5a                   	pop    %edx
  e9:	6a 00                	push   $0x0
  eb:	50                   	push   %eax
  ec:	e8 e1 02 00 00       	call   3d2 <open>
  f1:	83 c4 10             	add    $0x10,%esp
  f4:	89 c7                	mov    %eax,%edi
  f6:	8d 76 00             	lea    0x0(%esi),%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 100:	83 ec 04             	sub    $0x4,%esp
 103:	68 00 02 00 00       	push   $0x200
 108:	56                   	push   %esi
 109:	57                   	push   %edi
 10a:	e8 9b 02 00 00       	call   3aa <read>
 10f:	83 c4 10             	add    $0x10,%esp
 112:	83 eb 01             	sub    $0x1,%ebx
 115:	75 e9                	jne    100 <main+0x100>
 117:	83 ec 0c             	sub    $0xc,%esp
 11a:	57                   	push   %edi
 11b:	e8 9a 02 00 00       	call   3ba <close>
 120:	e8 75 02 00 00       	call   39a <wait>
 125:	e8 68 02 00 00       	call   392 <exit>
 12a:	89 df                	mov    %ebx,%edi
 12c:	e9 45 ff ff ff       	jmp    76 <main+0x76>
 131:	66 90                	xchg   %ax,%ax
 133:	66 90                	xchg   %ax,%ax
 135:	66 90                	xchg   %ax,%ax
 137:	66 90                	xchg   %ax,%ax
 139:	66 90                	xchg   %ax,%ax
 13b:	66 90                	xchg   %ax,%ax
 13d:	66 90                	xchg   %ax,%ax
 13f:	90                   	nop

00000140 <strcpy>:
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 45 08             	mov    0x8(%ebp),%eax
 147:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 14a:	89 c2                	mov    %eax,%edx
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 150:	83 c1 01             	add    $0x1,%ecx
 153:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 157:	83 c2 01             	add    $0x1,%edx
 15a:	84 db                	test   %bl,%bl
 15c:	88 5a ff             	mov    %bl,-0x1(%edx)
 15f:	75 ef                	jne    150 <strcpy+0x10>
 161:	5b                   	pop    %ebx
 162:	5d                   	pop    %ebp
 163:	c3                   	ret    
 164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 16a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000170 <strcmp>:
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	53                   	push   %ebx
 174:	8b 55 08             	mov    0x8(%ebp),%edx
 177:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 17a:	0f b6 02             	movzbl (%edx),%eax
 17d:	0f b6 19             	movzbl (%ecx),%ebx
 180:	84 c0                	test   %al,%al
 182:	75 1c                	jne    1a0 <strcmp+0x30>
 184:	eb 2a                	jmp    1b0 <strcmp+0x40>
 186:	8d 76 00             	lea    0x0(%esi),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 190:	83 c2 01             	add    $0x1,%edx
 193:	0f b6 02             	movzbl (%edx),%eax
 196:	83 c1 01             	add    $0x1,%ecx
 199:	0f b6 19             	movzbl (%ecx),%ebx
 19c:	84 c0                	test   %al,%al
 19e:	74 10                	je     1b0 <strcmp+0x40>
 1a0:	38 d8                	cmp    %bl,%al
 1a2:	74 ec                	je     190 <strcmp+0x20>
 1a4:	29 d8                	sub    %ebx,%eax
 1a6:	5b                   	pop    %ebx
 1a7:	5d                   	pop    %ebp
 1a8:	c3                   	ret    
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1b0:	31 c0                	xor    %eax,%eax
 1b2:	29 d8                	sub    %ebx,%eax
 1b4:	5b                   	pop    %ebx
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	89 f6                	mov    %esi,%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <strlen>:
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1c6:	80 39 00             	cmpb   $0x0,(%ecx)
 1c9:	74 15                	je     1e0 <strlen+0x20>
 1cb:	31 d2                	xor    %edx,%edx
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
 1d0:	83 c2 01             	add    $0x1,%edx
 1d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1d7:	89 d0                	mov    %edx,%eax
 1d9:	75 f5                	jne    1d0 <strlen+0x10>
 1db:	5d                   	pop    %ebp
 1dc:	c3                   	ret    
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
 1e0:	31 c0                	xor    %eax,%eax
 1e2:	5d                   	pop    %ebp
 1e3:	c3                   	ret    
 1e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001f0 <memset>:
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	8b 55 08             	mov    0x8(%ebp),%edx
 1f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fd:	89 d7                	mov    %edx,%edi
 1ff:	fc                   	cld    
 200:	f3 aa                	rep stos %al,%es:(%edi)
 202:	89 d0                	mov    %edx,%eax
 204:	5f                   	pop    %edi
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <strchr>:
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 45 08             	mov    0x8(%ebp),%eax
 217:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 21a:	0f b6 10             	movzbl (%eax),%edx
 21d:	84 d2                	test   %dl,%dl
 21f:	74 1d                	je     23e <strchr+0x2e>
 221:	38 d3                	cmp    %dl,%bl
 223:	89 d9                	mov    %ebx,%ecx
 225:	75 0d                	jne    234 <strchr+0x24>
 227:	eb 17                	jmp    240 <strchr+0x30>
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 230:	38 ca                	cmp    %cl,%dl
 232:	74 0c                	je     240 <strchr+0x30>
 234:	83 c0 01             	add    $0x1,%eax
 237:	0f b6 10             	movzbl (%eax),%edx
 23a:	84 d2                	test   %dl,%dl
 23c:	75 f2                	jne    230 <strchr+0x20>
 23e:	31 c0                	xor    %eax,%eax
 240:	5b                   	pop    %ebx
 241:	5d                   	pop    %ebp
 242:	c3                   	ret    
 243:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <gets>:
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	56                   	push   %esi
 255:	53                   	push   %ebx
 256:	31 f6                	xor    %esi,%esi
 258:	89 f3                	mov    %esi,%ebx
 25a:	83 ec 1c             	sub    $0x1c,%esp
 25d:	8b 7d 08             	mov    0x8(%ebp),%edi
 260:	eb 2f                	jmp    291 <gets+0x41>
 262:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 268:	8d 45 e7             	lea    -0x19(%ebp),%eax
 26b:	83 ec 04             	sub    $0x4,%esp
 26e:	6a 01                	push   $0x1
 270:	50                   	push   %eax
 271:	6a 00                	push   $0x0
 273:	e8 32 01 00 00       	call   3aa <read>
 278:	83 c4 10             	add    $0x10,%esp
 27b:	85 c0                	test   %eax,%eax
 27d:	7e 1c                	jle    29b <gets+0x4b>
 27f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 283:	83 c7 01             	add    $0x1,%edi
 286:	88 47 ff             	mov    %al,-0x1(%edi)
 289:	3c 0a                	cmp    $0xa,%al
 28b:	74 23                	je     2b0 <gets+0x60>
 28d:	3c 0d                	cmp    $0xd,%al
 28f:	74 1f                	je     2b0 <gets+0x60>
 291:	83 c3 01             	add    $0x1,%ebx
 294:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 297:	89 fe                	mov    %edi,%esi
 299:	7c cd                	jl     268 <gets+0x18>
 29b:	89 f3                	mov    %esi,%ebx
 29d:	8b 45 08             	mov    0x8(%ebp),%eax
 2a0:	c6 03 00             	movb   $0x0,(%ebx)
 2a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2a6:	5b                   	pop    %ebx
 2a7:	5e                   	pop    %esi
 2a8:	5f                   	pop    %edi
 2a9:	5d                   	pop    %ebp
 2aa:	c3                   	ret    
 2ab:	90                   	nop
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2b0:	8b 75 08             	mov    0x8(%ebp),%esi
 2b3:	8b 45 08             	mov    0x8(%ebp),%eax
 2b6:	01 de                	add    %ebx,%esi
 2b8:	89 f3                	mov    %esi,%ebx
 2ba:	c6 03 00             	movb   $0x0,(%ebx)
 2bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2c0:	5b                   	pop    %ebx
 2c1:	5e                   	pop    %esi
 2c2:	5f                   	pop    %edi
 2c3:	5d                   	pop    %ebp
 2c4:	c3                   	ret    
 2c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <stat>:
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	56                   	push   %esi
 2d4:	53                   	push   %ebx
 2d5:	83 ec 08             	sub    $0x8,%esp
 2d8:	6a 00                	push   $0x0
 2da:	ff 75 08             	pushl  0x8(%ebp)
 2dd:	e8 f0 00 00 00       	call   3d2 <open>
 2e2:	83 c4 10             	add    $0x10,%esp
 2e5:	85 c0                	test   %eax,%eax
 2e7:	78 27                	js     310 <stat+0x40>
 2e9:	83 ec 08             	sub    $0x8,%esp
 2ec:	ff 75 0c             	pushl  0xc(%ebp)
 2ef:	89 c3                	mov    %eax,%ebx
 2f1:	50                   	push   %eax
 2f2:	e8 f3 00 00 00       	call   3ea <fstat>
 2f7:	89 1c 24             	mov    %ebx,(%esp)
 2fa:	89 c6                	mov    %eax,%esi
 2fc:	e8 b9 00 00 00       	call   3ba <close>
 301:	83 c4 10             	add    $0x10,%esp
 304:	8d 65 f8             	lea    -0x8(%ebp),%esp
 307:	89 f0                	mov    %esi,%eax
 309:	5b                   	pop    %ebx
 30a:	5e                   	pop    %esi
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret    
 30d:	8d 76 00             	lea    0x0(%esi),%esi
 310:	be ff ff ff ff       	mov    $0xffffffff,%esi
 315:	eb ed                	jmp    304 <stat+0x34>
 317:	89 f6                	mov    %esi,%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000320 <atoi>:
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	8b 4d 08             	mov    0x8(%ebp),%ecx
 327:	0f be 11             	movsbl (%ecx),%edx
 32a:	8d 42 d0             	lea    -0x30(%edx),%eax
 32d:	3c 09                	cmp    $0x9,%al
 32f:	b8 00 00 00 00       	mov    $0x0,%eax
 334:	77 1f                	ja     355 <atoi+0x35>
 336:	8d 76 00             	lea    0x0(%esi),%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 340:	8d 04 80             	lea    (%eax,%eax,4),%eax
 343:	83 c1 01             	add    $0x1,%ecx
 346:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 34a:	0f be 11             	movsbl (%ecx),%edx
 34d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 350:	80 fb 09             	cmp    $0x9,%bl
 353:	76 eb                	jbe    340 <atoi+0x20>
 355:	5b                   	pop    %ebx
 356:	5d                   	pop    %ebp
 357:	c3                   	ret    
 358:	90                   	nop
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000360 <memmove>:
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	56                   	push   %esi
 364:	53                   	push   %ebx
 365:	8b 5d 10             	mov    0x10(%ebp),%ebx
 368:	8b 45 08             	mov    0x8(%ebp),%eax
 36b:	8b 75 0c             	mov    0xc(%ebp),%esi
 36e:	85 db                	test   %ebx,%ebx
 370:	7e 14                	jle    386 <memmove+0x26>
 372:	31 d2                	xor    %edx,%edx
 374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 378:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 37c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 37f:	83 c2 01             	add    $0x1,%edx
 382:	39 d3                	cmp    %edx,%ebx
 384:	75 f2                	jne    378 <memmove+0x18>
 386:	5b                   	pop    %ebx
 387:	5e                   	pop    %esi
 388:	5d                   	pop    %ebp
 389:	c3                   	ret    

0000038a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 38a:	b8 01 00 00 00       	mov    $0x1,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <exit>:
SYSCALL(exit)
 392:	b8 02 00 00 00       	mov    $0x2,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <wait>:
SYSCALL(wait)
 39a:	b8 03 00 00 00       	mov    $0x3,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <pipe>:
SYSCALL(pipe)
 3a2:	b8 04 00 00 00       	mov    $0x4,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <read>:
SYSCALL(read)
 3aa:	b8 05 00 00 00       	mov    $0x5,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <write>:
SYSCALL(write)
 3b2:	b8 10 00 00 00       	mov    $0x10,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <close>:
SYSCALL(close)
 3ba:	b8 15 00 00 00       	mov    $0x15,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <kill>:
SYSCALL(kill)
 3c2:	b8 06 00 00 00       	mov    $0x6,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <exec>:
SYSCALL(exec)
 3ca:	b8 07 00 00 00       	mov    $0x7,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <open>:
SYSCALL(open)
 3d2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <mknod>:
SYSCALL(mknod)
 3da:	b8 11 00 00 00       	mov    $0x11,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <unlink>:
SYSCALL(unlink)
 3e2:	b8 12 00 00 00       	mov    $0x12,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <fstat>:
SYSCALL(fstat)
 3ea:	b8 08 00 00 00       	mov    $0x8,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <link>:
SYSCALL(link)
 3f2:	b8 13 00 00 00       	mov    $0x13,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <mkdir>:
SYSCALL(mkdir)
 3fa:	b8 14 00 00 00       	mov    $0x14,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <chdir>:
SYSCALL(chdir)
 402:	b8 09 00 00 00       	mov    $0x9,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <dup>:
SYSCALL(dup)
 40a:	b8 0a 00 00 00       	mov    $0xa,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <getpid>:
SYSCALL(getpid)
 412:	b8 0b 00 00 00       	mov    $0xb,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <sbrk>:
SYSCALL(sbrk)
 41a:	b8 0c 00 00 00       	mov    $0xc,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <sleep>:
SYSCALL(sleep)
 422:	b8 0d 00 00 00       	mov    $0xd,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <uptime>:
SYSCALL(uptime)
 42a:	b8 0e 00 00 00       	mov    $0xe,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <cpuhalt>:
SYSCALL(cpuhalt)
 432:	b8 16 00 00 00       	mov    $0x16,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    
 43a:	66 90                	xchg   %ax,%ax
 43c:	66 90                	xchg   %ax,%ax
 43e:	66 90                	xchg   %ax,%ax

00000440 <printint.constprop.1>:
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
 446:	89 d6                	mov    %edx,%esi
 448:	83 ec 3c             	sub    $0x3c,%esp
 44b:	85 c0                	test   %eax,%eax
 44d:	79 71                	jns    4c0 <printint.constprop.1+0x80>
 44f:	83 e1 01             	and    $0x1,%ecx
 452:	74 6c                	je     4c0 <printint.constprop.1+0x80>
 454:	f7 d8                	neg    %eax
 456:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 45d:	31 c9                	xor    %ecx,%ecx
 45f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 462:	eb 06                	jmp    46a <printint.constprop.1+0x2a>
 464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 468:	89 f9                	mov    %edi,%ecx
 46a:	31 d2                	xor    %edx,%edx
 46c:	8d 79 01             	lea    0x1(%ecx),%edi
 46f:	f7 f6                	div    %esi
 471:	0f b6 92 f4 08 00 00 	movzbl 0x8f4(%edx),%edx
 478:	85 c0                	test   %eax,%eax
 47a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
 47d:	75 e9                	jne    468 <printint.constprop.1+0x28>
 47f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 482:	85 c0                	test   %eax,%eax
 484:	74 08                	je     48e <printint.constprop.1+0x4e>
 486:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 48b:	8d 79 02             	lea    0x2(%ecx),%edi
 48e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 492:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 498:	0f b6 06             	movzbl (%esi),%eax
 49b:	83 ec 04             	sub    $0x4,%esp
 49e:	83 ee 01             	sub    $0x1,%esi
 4a1:	6a 01                	push   $0x1
 4a3:	53                   	push   %ebx
 4a4:	6a 01                	push   $0x1
 4a6:	88 45 d7             	mov    %al,-0x29(%ebp)
 4a9:	e8 04 ff ff ff       	call   3b2 <write>
 4ae:	83 c4 10             	add    $0x10,%esp
 4b1:	39 de                	cmp    %ebx,%esi
 4b3:	75 e3                	jne    498 <printint.constprop.1+0x58>
 4b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4b8:	5b                   	pop    %ebx
 4b9:	5e                   	pop    %esi
 4ba:	5f                   	pop    %edi
 4bb:	5d                   	pop    %ebp
 4bc:	c3                   	ret    
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
 4c0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4c7:	eb 94                	jmp    45d <printint.constprop.1+0x1d>
 4c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004d0 <vprintf.constprop.0>:
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	57                   	push   %edi
 4d4:	56                   	push   %esi
 4d5:	53                   	push   %ebx
 4d6:	89 d6                	mov    %edx,%esi
 4d8:	83 ec 2c             	sub    $0x2c,%esp
 4db:	0f b6 10             	movzbl (%eax),%edx
 4de:	84 d2                	test   %dl,%dl
 4e0:	0f 84 cd 00 00 00    	je     5b3 <vprintf.constprop.0+0xe3>
 4e6:	8d 58 01             	lea    0x1(%eax),%ebx
 4e9:	31 ff                	xor    %edi,%edi
 4eb:	eb 31                	jmp    51e <vprintf.constprop.0+0x4e>
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
 4f0:	83 f8 25             	cmp    $0x25,%eax
 4f3:	0f 84 c7 00 00 00    	je     5c0 <vprintf.constprop.0+0xf0>
 4f9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4fc:	83 ec 04             	sub    $0x4,%esp
 4ff:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 502:	6a 01                	push   $0x1
 504:	50                   	push   %eax
 505:	6a 01                	push   $0x1
 507:	e8 a6 fe ff ff       	call   3b2 <write>
 50c:	83 c4 10             	add    $0x10,%esp
 50f:	83 c3 01             	add    $0x1,%ebx
 512:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 516:	84 d2                	test   %dl,%dl
 518:	0f 84 95 00 00 00    	je     5b3 <vprintf.constprop.0+0xe3>
 51e:	85 ff                	test   %edi,%edi
 520:	0f b6 c2             	movzbl %dl,%eax
 523:	74 cb                	je     4f0 <vprintf.constprop.0+0x20>
 525:	83 ff 25             	cmp    $0x25,%edi
 528:	75 e5                	jne    50f <vprintf.constprop.0+0x3f>
 52a:	83 f8 64             	cmp    $0x64,%eax
 52d:	8d 7e 04             	lea    0x4(%esi),%edi
 530:	b9 01 00 00 00       	mov    $0x1,%ecx
 535:	0f 84 9a 00 00 00    	je     5d5 <vprintf.constprop.0+0x105>
 53b:	83 f8 6c             	cmp    $0x6c,%eax
 53e:	0f 84 8c 00 00 00    	je     5d0 <vprintf.constprop.0+0x100>
 544:	83 f8 78             	cmp    $0x78,%eax
 547:	0f 84 a3 00 00 00    	je     5f0 <vprintf.constprop.0+0x120>
 54d:	83 f8 70             	cmp    $0x70,%eax
 550:	0f 84 ca 00 00 00    	je     620 <vprintf.constprop.0+0x150>
 556:	83 f8 73             	cmp    $0x73,%eax
 559:	0f 84 39 01 00 00    	je     698 <vprintf.constprop.0+0x1c8>
 55f:	83 f8 63             	cmp    $0x63,%eax
 562:	0f 84 68 01 00 00    	je     6d0 <vprintf.constprop.0+0x200>
 568:	83 f8 25             	cmp    $0x25,%eax
 56b:	0f 84 9f 00 00 00    	je     610 <vprintf.constprop.0+0x140>
 571:	8d 45 df             	lea    -0x21(%ebp),%eax
 574:	83 ec 04             	sub    $0x4,%esp
 577:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 57a:	6a 01                	push   $0x1
 57c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 580:	50                   	push   %eax
 581:	6a 01                	push   $0x1
 583:	e8 2a fe ff ff       	call   3b2 <write>
 588:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 58c:	83 c4 0c             	add    $0xc,%esp
 58f:	8d 45 e0             	lea    -0x20(%ebp),%eax
 592:	6a 01                	push   $0x1
 594:	88 55 e0             	mov    %dl,-0x20(%ebp)
 597:	50                   	push   %eax
 598:	6a 01                	push   $0x1
 59a:	83 c3 01             	add    $0x1,%ebx
 59d:	31 ff                	xor    %edi,%edi
 59f:	e8 0e fe ff ff       	call   3b2 <write>
 5a4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5a8:	83 c4 10             	add    $0x10,%esp
 5ab:	84 d2                	test   %dl,%dl
 5ad:	0f 85 6b ff ff ff    	jne    51e <vprintf.constprop.0+0x4e>
 5b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5b6:	5b                   	pop    %ebx
 5b7:	5e                   	pop    %esi
 5b8:	5f                   	pop    %edi
 5b9:	5d                   	pop    %ebp
 5ba:	c3                   	ret    
 5bb:	90                   	nop
 5bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5c0:	bf 25 00 00 00       	mov    $0x25,%edi
 5c5:	e9 45 ff ff ff       	jmp    50f <vprintf.constprop.0+0x3f>
 5ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5d0:	8d 7e 04             	lea    0x4(%esi),%edi
 5d3:	31 c9                	xor    %ecx,%ecx
 5d5:	8b 06                	mov    (%esi),%eax
 5d7:	ba 0a 00 00 00       	mov    $0xa,%edx
 5dc:	89 fe                	mov    %edi,%esi
 5de:	31 ff                	xor    %edi,%edi
 5e0:	e8 5b fe ff ff       	call   440 <printint.constprop.1>
 5e5:	e9 25 ff ff ff       	jmp    50f <vprintf.constprop.0+0x3f>
 5ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5f0:	8b 06                	mov    (%esi),%eax
 5f2:	8d 7e 04             	lea    0x4(%esi),%edi
 5f5:	31 c9                	xor    %ecx,%ecx
 5f7:	ba 10 00 00 00       	mov    $0x10,%edx
 5fc:	89 fe                	mov    %edi,%esi
 5fe:	31 ff                	xor    %edi,%edi
 600:	e8 3b fe ff ff       	call   440 <printint.constprop.1>
 605:	e9 05 ff ff ff       	jmp    50f <vprintf.constprop.0+0x3f>
 60a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 610:	83 ec 04             	sub    $0x4,%esp
 613:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 616:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 619:	6a 01                	push   $0x1
 61b:	e9 77 ff ff ff       	jmp    597 <vprintf.constprop.0+0xc7>
 620:	8d 46 04             	lea    0x4(%esi),%eax
 623:	83 ec 04             	sub    $0x4,%esp
 626:	8b 3e                	mov    (%esi),%edi
 628:	6a 01                	push   $0x1
 62a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 62e:	be 08 00 00 00       	mov    $0x8,%esi
 633:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 636:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 639:	50                   	push   %eax
 63a:	6a 01                	push   $0x1
 63c:	e8 71 fd ff ff       	call   3b2 <write>
 641:	8d 45 e7             	lea    -0x19(%ebp),%eax
 644:	83 c4 0c             	add    $0xc,%esp
 647:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 64b:	6a 01                	push   $0x1
 64d:	50                   	push   %eax
 64e:	6a 01                	push   $0x1
 650:	e8 5d fd ff ff       	call   3b2 <write>
 655:	83 c4 10             	add    $0x10,%esp
 658:	90                   	nop
 659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 660:	89 f8                	mov    %edi,%eax
 662:	83 ec 04             	sub    $0x4,%esp
 665:	c1 e7 04             	shl    $0x4,%edi
 668:	c1 e8 1c             	shr    $0x1c,%eax
 66b:	6a 01                	push   $0x1
 66d:	0f b6 80 f4 08 00 00 	movzbl 0x8f4(%eax),%eax
 674:	88 45 e5             	mov    %al,-0x1b(%ebp)
 677:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 67a:	50                   	push   %eax
 67b:	6a 01                	push   $0x1
 67d:	e8 30 fd ff ff       	call   3b2 <write>
 682:	83 c4 10             	add    $0x10,%esp
 685:	83 ee 01             	sub    $0x1,%esi
 688:	75 d6                	jne    660 <vprintf.constprop.0+0x190>
 68a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 68d:	31 ff                	xor    %edi,%edi
 68f:	e9 7b fe ff ff       	jmp    50f <vprintf.constprop.0+0x3f>
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 698:	8b 3e                	mov    (%esi),%edi
 69a:	8d 46 04             	lea    0x4(%esi),%eax
 69d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 6a0:	85 ff                	test   %edi,%edi
 6a2:	74 50                	je     6f4 <vprintf.constprop.0+0x224>
 6a4:	0f b6 07             	movzbl (%edi),%eax
 6a7:	84 c0                	test   %al,%al
 6a9:	74 df                	je     68a <vprintf.constprop.0+0x1ba>
 6ab:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 6ae:	66 90                	xchg   %ax,%ax
 6b0:	83 ec 04             	sub    $0x4,%esp
 6b3:	83 c7 01             	add    $0x1,%edi
 6b6:	88 45 e3             	mov    %al,-0x1d(%ebp)
 6b9:	6a 01                	push   $0x1
 6bb:	56                   	push   %esi
 6bc:	6a 01                	push   $0x1
 6be:	e8 ef fc ff ff       	call   3b2 <write>
 6c3:	0f b6 07             	movzbl (%edi),%eax
 6c6:	83 c4 10             	add    $0x10,%esp
 6c9:	84 c0                	test   %al,%al
 6cb:	75 e3                	jne    6b0 <vprintf.constprop.0+0x1e0>
 6cd:	eb bb                	jmp    68a <vprintf.constprop.0+0x1ba>
 6cf:	90                   	nop
 6d0:	8b 06                	mov    (%esi),%eax
 6d2:	83 ec 04             	sub    $0x4,%esp
 6d5:	8d 7e 04             	lea    0x4(%esi),%edi
 6d8:	6a 01                	push   $0x1
 6da:	89 fe                	mov    %edi,%esi
 6dc:	31 ff                	xor    %edi,%edi
 6de:	88 45 e2             	mov    %al,-0x1e(%ebp)
 6e1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6e4:	50                   	push   %eax
 6e5:	6a 01                	push   $0x1
 6e7:	e8 c6 fc ff ff       	call   3b2 <write>
 6ec:	83 c4 10             	add    $0x10,%esp
 6ef:	e9 1b fe ff ff       	jmp    50f <vprintf.constprop.0+0x3f>
 6f4:	bf eb 08 00 00       	mov    $0x8eb,%edi
 6f9:	b8 28 00 00 00       	mov    $0x28,%eax
 6fe:	eb ab                	jmp    6ab <vprintf.constprop.0+0x1db>

00000700 <fprintf>:
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	83 ec 08             	sub    $0x8,%esp
 706:	8b 45 0c             	mov    0xc(%ebp),%eax
 709:	8d 55 10             	lea    0x10(%ebp),%edx
 70c:	e8 bf fd ff ff       	call   4d0 <vprintf.constprop.0>
 711:	c9                   	leave  
 712:	c3                   	ret    
 713:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000720 <printf>:
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	83 ec 08             	sub    $0x8,%esp
 726:	8b 45 08             	mov    0x8(%ebp),%eax
 729:	8d 55 0c             	lea    0xc(%ebp),%edx
 72c:	e8 9f fd ff ff       	call   4d0 <vprintf.constprop.0>
 731:	c9                   	leave  
 732:	c3                   	ret    
 733:	66 90                	xchg   %ax,%ax
 735:	66 90                	xchg   %ax,%ax
 737:	66 90                	xchg   %ax,%ax
 739:	66 90                	xchg   %ax,%ax
 73b:	66 90                	xchg   %ax,%ax
 73d:	66 90                	xchg   %ax,%ax
 73f:	90                   	nop

00000740 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 740:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 741:	a1 e4 0b 00 00       	mov    0xbe4,%eax
{
 746:	89 e5                	mov    %esp,%ebp
 748:	57                   	push   %edi
 749:	56                   	push   %esi
 74a:	53                   	push   %ebx
 74b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 74e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 751:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 758:	39 c8                	cmp    %ecx,%eax
 75a:	8b 10                	mov    (%eax),%edx
 75c:	73 32                	jae    790 <free+0x50>
 75e:	39 d1                	cmp    %edx,%ecx
 760:	72 04                	jb     766 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 762:	39 d0                	cmp    %edx,%eax
 764:	72 32                	jb     798 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 766:	8b 73 fc             	mov    -0x4(%ebx),%esi
 769:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 76c:	39 fa                	cmp    %edi,%edx
 76e:	74 30                	je     7a0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 770:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 773:	8b 50 04             	mov    0x4(%eax),%edx
 776:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 779:	39 f1                	cmp    %esi,%ecx
 77b:	74 3a                	je     7b7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 77d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 77f:	a3 e4 0b 00 00       	mov    %eax,0xbe4
}
 784:	5b                   	pop    %ebx
 785:	5e                   	pop    %esi
 786:	5f                   	pop    %edi
 787:	5d                   	pop    %ebp
 788:	c3                   	ret    
 789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 790:	39 d0                	cmp    %edx,%eax
 792:	72 04                	jb     798 <free+0x58>
 794:	39 d1                	cmp    %edx,%ecx
 796:	72 ce                	jb     766 <free+0x26>
{
 798:	89 d0                	mov    %edx,%eax
 79a:	eb bc                	jmp    758 <free+0x18>
 79c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 7a0:	03 72 04             	add    0x4(%edx),%esi
 7a3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7a6:	8b 10                	mov    (%eax),%edx
 7a8:	8b 12                	mov    (%edx),%edx
 7aa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7ad:	8b 50 04             	mov    0x4(%eax),%edx
 7b0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7b3:	39 f1                	cmp    %esi,%ecx
 7b5:	75 c6                	jne    77d <free+0x3d>
    p->s.size += bp->s.size;
 7b7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7ba:	a3 e4 0b 00 00       	mov    %eax,0xbe4
    p->s.size += bp->s.size;
 7bf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7c2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7c5:	89 10                	mov    %edx,(%eax)
}
 7c7:	5b                   	pop    %ebx
 7c8:	5e                   	pop    %esi
 7c9:	5f                   	pop    %edi
 7ca:	5d                   	pop    %ebp
 7cb:	c3                   	ret    
 7cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7d0:	55                   	push   %ebp
 7d1:	89 e5                	mov    %esp,%ebp
 7d3:	57                   	push   %edi
 7d4:	56                   	push   %esi
 7d5:	53                   	push   %ebx
 7d6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7dc:	8b 15 e4 0b 00 00    	mov    0xbe4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e2:	8d 78 07             	lea    0x7(%eax),%edi
 7e5:	c1 ef 03             	shr    $0x3,%edi
 7e8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7eb:	85 d2                	test   %edx,%edx
 7ed:	0f 84 9d 00 00 00    	je     890 <malloc+0xc0>
 7f3:	8b 02                	mov    (%edx),%eax
 7f5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7f8:	39 cf                	cmp    %ecx,%edi
 7fa:	76 6c                	jbe    868 <malloc+0x98>
 7fc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 802:	bb 00 10 00 00       	mov    $0x1000,%ebx
 807:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 80a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 811:	eb 0e                	jmp    821 <malloc+0x51>
 813:	90                   	nop
 814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 818:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 81a:	8b 48 04             	mov    0x4(%eax),%ecx
 81d:	39 f9                	cmp    %edi,%ecx
 81f:	73 47                	jae    868 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 821:	39 05 e4 0b 00 00    	cmp    %eax,0xbe4
 827:	89 c2                	mov    %eax,%edx
 829:	75 ed                	jne    818 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 82b:	83 ec 0c             	sub    $0xc,%esp
 82e:	56                   	push   %esi
 82f:	e8 e6 fb ff ff       	call   41a <sbrk>
  if(p == (char*)-1)
 834:	83 c4 10             	add    $0x10,%esp
 837:	83 f8 ff             	cmp    $0xffffffff,%eax
 83a:	74 1c                	je     858 <malloc+0x88>
  hp->s.size = nu;
 83c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 83f:	83 ec 0c             	sub    $0xc,%esp
 842:	83 c0 08             	add    $0x8,%eax
 845:	50                   	push   %eax
 846:	e8 f5 fe ff ff       	call   740 <free>
  return freep;
 84b:	8b 15 e4 0b 00 00    	mov    0xbe4,%edx
      if((p = morecore(nunits)) == 0)
 851:	83 c4 10             	add    $0x10,%esp
 854:	85 d2                	test   %edx,%edx
 856:	75 c0                	jne    818 <malloc+0x48>
        return 0;
  }
}
 858:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 85b:	31 c0                	xor    %eax,%eax
}
 85d:	5b                   	pop    %ebx
 85e:	5e                   	pop    %esi
 85f:	5f                   	pop    %edi
 860:	5d                   	pop    %ebp
 861:	c3                   	ret    
 862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 868:	39 cf                	cmp    %ecx,%edi
 86a:	74 54                	je     8c0 <malloc+0xf0>
        p->s.size -= nunits;
 86c:	29 f9                	sub    %edi,%ecx
 86e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 871:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 874:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 877:	89 15 e4 0b 00 00    	mov    %edx,0xbe4
}
 87d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 880:	83 c0 08             	add    $0x8,%eax
}
 883:	5b                   	pop    %ebx
 884:	5e                   	pop    %esi
 885:	5f                   	pop    %edi
 886:	5d                   	pop    %ebp
 887:	c3                   	ret    
 888:	90                   	nop
 889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 890:	c7 05 e4 0b 00 00 e8 	movl   $0xbe8,0xbe4
 897:	0b 00 00 
 89a:	c7 05 e8 0b 00 00 e8 	movl   $0xbe8,0xbe8
 8a1:	0b 00 00 
    base.s.size = 0;
 8a4:	b8 e8 0b 00 00       	mov    $0xbe8,%eax
 8a9:	c7 05 ec 0b 00 00 00 	movl   $0x0,0xbec
 8b0:	00 00 00 
 8b3:	e9 44 ff ff ff       	jmp    7fc <malloc+0x2c>
 8b8:	90                   	nop
 8b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 8c0:	8b 08                	mov    (%eax),%ecx
 8c2:	89 0a                	mov    %ecx,(%edx)
 8c4:	eb b1                	jmp    877 <malloc+0xa7>
