
user/_wc:     file format elf32-i386


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
  11:	be 01 00 00 00       	mov    $0x1,%esi
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	83 c3 04             	add    $0x4,%ebx
  21:	83 f8 01             	cmp    $0x1,%eax
  24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  27:	7e 56                	jle    7f <main+0x7f>
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 d6 03 00 00       	call   412 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	85 c0                	test   %eax,%eax
  41:	89 c7                	mov    %eax,%edi
  43:	78 26                	js     6b <main+0x6b>
  45:	83 ec 08             	sub    $0x8,%esp
  48:	ff 33                	pushl  (%ebx)
  4a:	83 c6 01             	add    $0x1,%esi
  4d:	50                   	push   %eax
  4e:	83 c3 04             	add    $0x4,%ebx
  51:	e8 4a 00 00 00       	call   a0 <wc>
  56:	89 3c 24             	mov    %edi,(%esp)
  59:	e8 9c 03 00 00       	call   3fa <close>
  5e:	83 c4 10             	add    $0x10,%esp
  61:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  64:	75 ca                	jne    30 <main+0x30>
  66:	e8 67 03 00 00       	call   3d2 <exit>
  6b:	50                   	push   %eax
  6c:	ff 33                	pushl  (%ebx)
  6e:	68 2b 09 00 00       	push   $0x92b
  73:	6a 02                	push   $0x2
  75:	e8 c6 06 00 00       	call   740 <fprintf>
  7a:	e8 53 03 00 00       	call   3d2 <exit>
  7f:	52                   	push   %edx
  80:	52                   	push   %edx
  81:	68 1d 09 00 00       	push   $0x91d
  86:	6a 00                	push   $0x0
  88:	e8 13 00 00 00       	call   a0 <wc>
  8d:	e8 40 03 00 00       	call   3d2 <exit>
  92:	66 90                	xchg   %ax,%ax
  94:	66 90                	xchg   %ax,%ax
  96:	66 90                	xchg   %ax,%ax
  98:	66 90                	xchg   %ax,%ax
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <wc>:
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  a5:	53                   	push   %ebx
  a6:	31 db                	xor    %ebx,%ebx
  a8:	83 ec 1c             	sub    $0x1c,%esp
  ab:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  b2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  b9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  c0:	83 ec 04             	sub    $0x4,%esp
  c3:	68 00 02 00 00       	push   $0x200
  c8:	68 a0 0c 00 00       	push   $0xca0
  cd:	ff 75 08             	pushl  0x8(%ebp)
  d0:	e8 15 03 00 00       	call   3ea <read>
  d5:	83 c4 10             	add    $0x10,%esp
  d8:	83 f8 00             	cmp    $0x0,%eax
  db:	89 c6                	mov    %eax,%esi
  dd:	7e 61                	jle    140 <wc+0xa0>
  df:	31 ff                	xor    %edi,%edi
  e1:	eb 13                	jmp    f6 <wc+0x56>
  e3:	90                   	nop
  e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  e8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  ef:	83 c7 01             	add    $0x1,%edi
  f2:	39 fe                	cmp    %edi,%esi
  f4:	74 42                	je     138 <wc+0x98>
  f6:	0f be 87 a0 0c 00 00 	movsbl 0xca0(%edi),%eax
  fd:	31 c9                	xor    %ecx,%ecx
  ff:	3c 0a                	cmp    $0xa,%al
 101:	0f 94 c1             	sete   %cl
 104:	83 ec 08             	sub    $0x8,%esp
 107:	50                   	push   %eax
 108:	68 08 09 00 00       	push   $0x908
 10d:	01 cb                	add    %ecx,%ebx
 10f:	e8 3c 01 00 00       	call   250 <strchr>
 114:	83 c4 10             	add    $0x10,%esp
 117:	85 c0                	test   %eax,%eax
 119:	75 cd                	jne    e8 <wc+0x48>
 11b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 11e:	85 d2                	test   %edx,%edx
 120:	75 cd                	jne    ef <wc+0x4f>
 122:	83 c7 01             	add    $0x1,%edi
 125:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
 129:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
 130:	39 fe                	cmp    %edi,%esi
 132:	75 c2                	jne    f6 <wc+0x56>
 134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 138:	01 75 e0             	add    %esi,-0x20(%ebp)
 13b:	eb 83                	jmp    c0 <wc+0x20>
 13d:	8d 76 00             	lea    0x0(%esi),%esi
 140:	75 22                	jne    164 <wc+0xc4>
 142:	83 ec 0c             	sub    $0xc,%esp
 145:	ff 75 0c             	pushl  0xc(%ebp)
 148:	ff 75 e0             	pushl  -0x20(%ebp)
 14b:	ff 75 dc             	pushl  -0x24(%ebp)
 14e:	53                   	push   %ebx
 14f:	68 1e 09 00 00       	push   $0x91e
 154:	e8 07 06 00 00       	call   760 <printf>
 159:	83 c4 20             	add    $0x20,%esp
 15c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 15f:	5b                   	pop    %ebx
 160:	5e                   	pop    %esi
 161:	5f                   	pop    %edi
 162:	5d                   	pop    %ebp
 163:	c3                   	ret    
 164:	50                   	push   %eax
 165:	50                   	push   %eax
 166:	68 0e 09 00 00       	push   $0x90e
 16b:	6a 02                	push   $0x2
 16d:	e8 ce 05 00 00       	call   740 <fprintf>
 172:	e8 5b 02 00 00       	call   3d2 <exit>
 177:	66 90                	xchg   %ax,%ax
 179:	66 90                	xchg   %ax,%ax
 17b:	66 90                	xchg   %ax,%ax
 17d:	66 90                	xchg   %ax,%ax
 17f:	90                   	nop

00000180 <strcpy>:
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	53                   	push   %ebx
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 18a:	89 c2                	mov    %eax,%edx
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 190:	83 c1 01             	add    $0x1,%ecx
 193:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 197:	83 c2 01             	add    $0x1,%edx
 19a:	84 db                	test   %bl,%bl
 19c:	88 5a ff             	mov    %bl,-0x1(%edx)
 19f:	75 ef                	jne    190 <strcpy+0x10>
 1a1:	5b                   	pop    %ebx
 1a2:	5d                   	pop    %ebp
 1a3:	c3                   	ret    
 1a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001b0 <strcmp>:
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	53                   	push   %ebx
 1b4:	8b 55 08             	mov    0x8(%ebp),%edx
 1b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1ba:	0f b6 02             	movzbl (%edx),%eax
 1bd:	0f b6 19             	movzbl (%ecx),%ebx
 1c0:	84 c0                	test   %al,%al
 1c2:	75 1c                	jne    1e0 <strcmp+0x30>
 1c4:	eb 2a                	jmp    1f0 <strcmp+0x40>
 1c6:	8d 76 00             	lea    0x0(%esi),%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 1d0:	83 c2 01             	add    $0x1,%edx
 1d3:	0f b6 02             	movzbl (%edx),%eax
 1d6:	83 c1 01             	add    $0x1,%ecx
 1d9:	0f b6 19             	movzbl (%ecx),%ebx
 1dc:	84 c0                	test   %al,%al
 1de:	74 10                	je     1f0 <strcmp+0x40>
 1e0:	38 d8                	cmp    %bl,%al
 1e2:	74 ec                	je     1d0 <strcmp+0x20>
 1e4:	29 d8                	sub    %ebx,%eax
 1e6:	5b                   	pop    %ebx
 1e7:	5d                   	pop    %ebp
 1e8:	c3                   	ret    
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1f0:	31 c0                	xor    %eax,%eax
 1f2:	29 d8                	sub    %ebx,%eax
 1f4:	5b                   	pop    %ebx
 1f5:	5d                   	pop    %ebp
 1f6:	c3                   	ret    
 1f7:	89 f6                	mov    %esi,%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <strlen>:
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 4d 08             	mov    0x8(%ebp),%ecx
 206:	80 39 00             	cmpb   $0x0,(%ecx)
 209:	74 15                	je     220 <strlen+0x20>
 20b:	31 d2                	xor    %edx,%edx
 20d:	8d 76 00             	lea    0x0(%esi),%esi
 210:	83 c2 01             	add    $0x1,%edx
 213:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 217:	89 d0                	mov    %edx,%eax
 219:	75 f5                	jne    210 <strlen+0x10>
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret    
 21d:	8d 76 00             	lea    0x0(%esi),%esi
 220:	31 c0                	xor    %eax,%eax
 222:	5d                   	pop    %ebp
 223:	c3                   	ret    
 224:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 22a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000230 <memset>:
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	8b 55 08             	mov    0x8(%ebp),%edx
 237:	8b 4d 10             	mov    0x10(%ebp),%ecx
 23a:	8b 45 0c             	mov    0xc(%ebp),%eax
 23d:	89 d7                	mov    %edx,%edi
 23f:	fc                   	cld    
 240:	f3 aa                	rep stos %al,%es:(%edi)
 242:	89 d0                	mov    %edx,%eax
 244:	5f                   	pop    %edi
 245:	5d                   	pop    %ebp
 246:	c3                   	ret    
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <strchr>:
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 25a:	0f b6 10             	movzbl (%eax),%edx
 25d:	84 d2                	test   %dl,%dl
 25f:	74 1d                	je     27e <strchr+0x2e>
 261:	38 d3                	cmp    %dl,%bl
 263:	89 d9                	mov    %ebx,%ecx
 265:	75 0d                	jne    274 <strchr+0x24>
 267:	eb 17                	jmp    280 <strchr+0x30>
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 270:	38 ca                	cmp    %cl,%dl
 272:	74 0c                	je     280 <strchr+0x30>
 274:	83 c0 01             	add    $0x1,%eax
 277:	0f b6 10             	movzbl (%eax),%edx
 27a:	84 d2                	test   %dl,%dl
 27c:	75 f2                	jne    270 <strchr+0x20>
 27e:	31 c0                	xor    %eax,%eax
 280:	5b                   	pop    %ebx
 281:	5d                   	pop    %ebp
 282:	c3                   	ret    
 283:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <gets>:
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	56                   	push   %esi
 295:	53                   	push   %ebx
 296:	31 f6                	xor    %esi,%esi
 298:	89 f3                	mov    %esi,%ebx
 29a:	83 ec 1c             	sub    $0x1c,%esp
 29d:	8b 7d 08             	mov    0x8(%ebp),%edi
 2a0:	eb 2f                	jmp    2d1 <gets+0x41>
 2a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2a8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2ab:	83 ec 04             	sub    $0x4,%esp
 2ae:	6a 01                	push   $0x1
 2b0:	50                   	push   %eax
 2b1:	6a 00                	push   $0x0
 2b3:	e8 32 01 00 00       	call   3ea <read>
 2b8:	83 c4 10             	add    $0x10,%esp
 2bb:	85 c0                	test   %eax,%eax
 2bd:	7e 1c                	jle    2db <gets+0x4b>
 2bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2c3:	83 c7 01             	add    $0x1,%edi
 2c6:	88 47 ff             	mov    %al,-0x1(%edi)
 2c9:	3c 0a                	cmp    $0xa,%al
 2cb:	74 23                	je     2f0 <gets+0x60>
 2cd:	3c 0d                	cmp    $0xd,%al
 2cf:	74 1f                	je     2f0 <gets+0x60>
 2d1:	83 c3 01             	add    $0x1,%ebx
 2d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2d7:	89 fe                	mov    %edi,%esi
 2d9:	7c cd                	jl     2a8 <gets+0x18>
 2db:	89 f3                	mov    %esi,%ebx
 2dd:	8b 45 08             	mov    0x8(%ebp),%eax
 2e0:	c6 03 00             	movb   $0x0,(%ebx)
 2e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2e6:	5b                   	pop    %ebx
 2e7:	5e                   	pop    %esi
 2e8:	5f                   	pop    %edi
 2e9:	5d                   	pop    %ebp
 2ea:	c3                   	ret    
 2eb:	90                   	nop
 2ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2f0:	8b 75 08             	mov    0x8(%ebp),%esi
 2f3:	8b 45 08             	mov    0x8(%ebp),%eax
 2f6:	01 de                	add    %ebx,%esi
 2f8:	89 f3                	mov    %esi,%ebx
 2fa:	c6 03 00             	movb   $0x0,(%ebx)
 2fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 300:	5b                   	pop    %ebx
 301:	5e                   	pop    %esi
 302:	5f                   	pop    %edi
 303:	5d                   	pop    %ebp
 304:	c3                   	ret    
 305:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000310 <stat>:
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	56                   	push   %esi
 314:	53                   	push   %ebx
 315:	83 ec 08             	sub    $0x8,%esp
 318:	6a 00                	push   $0x0
 31a:	ff 75 08             	pushl  0x8(%ebp)
 31d:	e8 f0 00 00 00       	call   412 <open>
 322:	83 c4 10             	add    $0x10,%esp
 325:	85 c0                	test   %eax,%eax
 327:	78 27                	js     350 <stat+0x40>
 329:	83 ec 08             	sub    $0x8,%esp
 32c:	ff 75 0c             	pushl  0xc(%ebp)
 32f:	89 c3                	mov    %eax,%ebx
 331:	50                   	push   %eax
 332:	e8 f3 00 00 00       	call   42a <fstat>
 337:	89 1c 24             	mov    %ebx,(%esp)
 33a:	89 c6                	mov    %eax,%esi
 33c:	e8 b9 00 00 00       	call   3fa <close>
 341:	83 c4 10             	add    $0x10,%esp
 344:	8d 65 f8             	lea    -0x8(%ebp),%esp
 347:	89 f0                	mov    %esi,%eax
 349:	5b                   	pop    %ebx
 34a:	5e                   	pop    %esi
 34b:	5d                   	pop    %ebp
 34c:	c3                   	ret    
 34d:	8d 76 00             	lea    0x0(%esi),%esi
 350:	be ff ff ff ff       	mov    $0xffffffff,%esi
 355:	eb ed                	jmp    344 <stat+0x34>
 357:	89 f6                	mov    %esi,%esi
 359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000360 <atoi>:
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	53                   	push   %ebx
 364:	8b 4d 08             	mov    0x8(%ebp),%ecx
 367:	0f be 11             	movsbl (%ecx),%edx
 36a:	8d 42 d0             	lea    -0x30(%edx),%eax
 36d:	3c 09                	cmp    $0x9,%al
 36f:	b8 00 00 00 00       	mov    $0x0,%eax
 374:	77 1f                	ja     395 <atoi+0x35>
 376:	8d 76 00             	lea    0x0(%esi),%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 380:	8d 04 80             	lea    (%eax,%eax,4),%eax
 383:	83 c1 01             	add    $0x1,%ecx
 386:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 38a:	0f be 11             	movsbl (%ecx),%edx
 38d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 390:	80 fb 09             	cmp    $0x9,%bl
 393:	76 eb                	jbe    380 <atoi+0x20>
 395:	5b                   	pop    %ebx
 396:	5d                   	pop    %ebp
 397:	c3                   	ret    
 398:	90                   	nop
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003a0 <memmove>:
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	56                   	push   %esi
 3a4:	53                   	push   %ebx
 3a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3a8:	8b 45 08             	mov    0x8(%ebp),%eax
 3ab:	8b 75 0c             	mov    0xc(%ebp),%esi
 3ae:	85 db                	test   %ebx,%ebx
 3b0:	7e 14                	jle    3c6 <memmove+0x26>
 3b2:	31 d2                	xor    %edx,%edx
 3b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3bf:	83 c2 01             	add    $0x1,%edx
 3c2:	39 d3                	cmp    %edx,%ebx
 3c4:	75 f2                	jne    3b8 <memmove+0x18>
 3c6:	5b                   	pop    %ebx
 3c7:	5e                   	pop    %esi
 3c8:	5d                   	pop    %ebp
 3c9:	c3                   	ret    

000003ca <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3ca:	b8 01 00 00 00       	mov    $0x1,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <exit>:
SYSCALL(exit)
 3d2:	b8 02 00 00 00       	mov    $0x2,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <wait>:
SYSCALL(wait)
 3da:	b8 03 00 00 00       	mov    $0x3,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <pipe>:
SYSCALL(pipe)
 3e2:	b8 04 00 00 00       	mov    $0x4,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <read>:
SYSCALL(read)
 3ea:	b8 05 00 00 00       	mov    $0x5,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <write>:
SYSCALL(write)
 3f2:	b8 10 00 00 00       	mov    $0x10,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <close>:
SYSCALL(close)
 3fa:	b8 15 00 00 00       	mov    $0x15,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <kill>:
SYSCALL(kill)
 402:	b8 06 00 00 00       	mov    $0x6,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <exec>:
SYSCALL(exec)
 40a:	b8 07 00 00 00       	mov    $0x7,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <open>:
SYSCALL(open)
 412:	b8 0f 00 00 00       	mov    $0xf,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <mknod>:
SYSCALL(mknod)
 41a:	b8 11 00 00 00       	mov    $0x11,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <unlink>:
SYSCALL(unlink)
 422:	b8 12 00 00 00       	mov    $0x12,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <fstat>:
SYSCALL(fstat)
 42a:	b8 08 00 00 00       	mov    $0x8,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <link>:
SYSCALL(link)
 432:	b8 13 00 00 00       	mov    $0x13,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <mkdir>:
SYSCALL(mkdir)
 43a:	b8 14 00 00 00       	mov    $0x14,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <chdir>:
SYSCALL(chdir)
 442:	b8 09 00 00 00       	mov    $0x9,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <dup>:
SYSCALL(dup)
 44a:	b8 0a 00 00 00       	mov    $0xa,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <getpid>:
SYSCALL(getpid)
 452:	b8 0b 00 00 00       	mov    $0xb,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <sbrk>:
SYSCALL(sbrk)
 45a:	b8 0c 00 00 00       	mov    $0xc,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <sleep>:
SYSCALL(sleep)
 462:	b8 0d 00 00 00       	mov    $0xd,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <uptime>:
SYSCALL(uptime)
 46a:	b8 0e 00 00 00       	mov    $0xe,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <cpuhalt>:
SYSCALL(cpuhalt)
 472:	b8 16 00 00 00       	mov    $0x16,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    
 47a:	66 90                	xchg   %ax,%ax
 47c:	66 90                	xchg   %ax,%ax
 47e:	66 90                	xchg   %ax,%ax

00000480 <printint.constprop.1>:
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	89 d6                	mov    %edx,%esi
 488:	83 ec 3c             	sub    $0x3c,%esp
 48b:	85 c0                	test   %eax,%eax
 48d:	79 71                	jns    500 <printint.constprop.1+0x80>
 48f:	83 e1 01             	and    $0x1,%ecx
 492:	74 6c                	je     500 <printint.constprop.1+0x80>
 494:	f7 d8                	neg    %eax
 496:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 49d:	31 c9                	xor    %ecx,%ecx
 49f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4a2:	eb 06                	jmp    4aa <printint.constprop.1+0x2a>
 4a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4a8:	89 f9                	mov    %edi,%ecx
 4aa:	31 d2                	xor    %edx,%edx
 4ac:	8d 79 01             	lea    0x1(%ecx),%edi
 4af:	f7 f6                	div    %esi
 4b1:	0f b6 92 48 09 00 00 	movzbl 0x948(%edx),%edx
 4b8:	85 c0                	test   %eax,%eax
 4ba:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
 4bd:	75 e9                	jne    4a8 <printint.constprop.1+0x28>
 4bf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4c2:	85 c0                	test   %eax,%eax
 4c4:	74 08                	je     4ce <printint.constprop.1+0x4e>
 4c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 4cb:	8d 79 02             	lea    0x2(%ecx),%edi
 4ce:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 4d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4d8:	0f b6 06             	movzbl (%esi),%eax
 4db:	83 ec 04             	sub    $0x4,%esp
 4de:	83 ee 01             	sub    $0x1,%esi
 4e1:	6a 01                	push   $0x1
 4e3:	53                   	push   %ebx
 4e4:	6a 01                	push   $0x1
 4e6:	88 45 d7             	mov    %al,-0x29(%ebp)
 4e9:	e8 04 ff ff ff       	call   3f2 <write>
 4ee:	83 c4 10             	add    $0x10,%esp
 4f1:	39 de                	cmp    %ebx,%esi
 4f3:	75 e3                	jne    4d8 <printint.constprop.1+0x58>
 4f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4f8:	5b                   	pop    %ebx
 4f9:	5e                   	pop    %esi
 4fa:	5f                   	pop    %edi
 4fb:	5d                   	pop    %ebp
 4fc:	c3                   	ret    
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
 500:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 507:	eb 94                	jmp    49d <printint.constprop.1+0x1d>
 509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000510 <vprintf.constprop.0>:
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	57                   	push   %edi
 514:	56                   	push   %esi
 515:	53                   	push   %ebx
 516:	89 d6                	mov    %edx,%esi
 518:	83 ec 2c             	sub    $0x2c,%esp
 51b:	0f b6 10             	movzbl (%eax),%edx
 51e:	84 d2                	test   %dl,%dl
 520:	0f 84 cd 00 00 00    	je     5f3 <vprintf.constprop.0+0xe3>
 526:	8d 58 01             	lea    0x1(%eax),%ebx
 529:	31 ff                	xor    %edi,%edi
 52b:	eb 31                	jmp    55e <vprintf.constprop.0+0x4e>
 52d:	8d 76 00             	lea    0x0(%esi),%esi
 530:	83 f8 25             	cmp    $0x25,%eax
 533:	0f 84 c7 00 00 00    	je     600 <vprintf.constprop.0+0xf0>
 539:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 53c:	83 ec 04             	sub    $0x4,%esp
 53f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 542:	6a 01                	push   $0x1
 544:	50                   	push   %eax
 545:	6a 01                	push   $0x1
 547:	e8 a6 fe ff ff       	call   3f2 <write>
 54c:	83 c4 10             	add    $0x10,%esp
 54f:	83 c3 01             	add    $0x1,%ebx
 552:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 556:	84 d2                	test   %dl,%dl
 558:	0f 84 95 00 00 00    	je     5f3 <vprintf.constprop.0+0xe3>
 55e:	85 ff                	test   %edi,%edi
 560:	0f b6 c2             	movzbl %dl,%eax
 563:	74 cb                	je     530 <vprintf.constprop.0+0x20>
 565:	83 ff 25             	cmp    $0x25,%edi
 568:	75 e5                	jne    54f <vprintf.constprop.0+0x3f>
 56a:	83 f8 64             	cmp    $0x64,%eax
 56d:	8d 7e 04             	lea    0x4(%esi),%edi
 570:	b9 01 00 00 00       	mov    $0x1,%ecx
 575:	0f 84 9a 00 00 00    	je     615 <vprintf.constprop.0+0x105>
 57b:	83 f8 6c             	cmp    $0x6c,%eax
 57e:	0f 84 8c 00 00 00    	je     610 <vprintf.constprop.0+0x100>
 584:	83 f8 78             	cmp    $0x78,%eax
 587:	0f 84 a3 00 00 00    	je     630 <vprintf.constprop.0+0x120>
 58d:	83 f8 70             	cmp    $0x70,%eax
 590:	0f 84 ca 00 00 00    	je     660 <vprintf.constprop.0+0x150>
 596:	83 f8 73             	cmp    $0x73,%eax
 599:	0f 84 39 01 00 00    	je     6d8 <vprintf.constprop.0+0x1c8>
 59f:	83 f8 63             	cmp    $0x63,%eax
 5a2:	0f 84 68 01 00 00    	je     710 <vprintf.constprop.0+0x200>
 5a8:	83 f8 25             	cmp    $0x25,%eax
 5ab:	0f 84 9f 00 00 00    	je     650 <vprintf.constprop.0+0x140>
 5b1:	8d 45 df             	lea    -0x21(%ebp),%eax
 5b4:	83 ec 04             	sub    $0x4,%esp
 5b7:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 5ba:	6a 01                	push   $0x1
 5bc:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 5c0:	50                   	push   %eax
 5c1:	6a 01                	push   $0x1
 5c3:	e8 2a fe ff ff       	call   3f2 <write>
 5c8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 5cc:	83 c4 0c             	add    $0xc,%esp
 5cf:	8d 45 e0             	lea    -0x20(%ebp),%eax
 5d2:	6a 01                	push   $0x1
 5d4:	88 55 e0             	mov    %dl,-0x20(%ebp)
 5d7:	50                   	push   %eax
 5d8:	6a 01                	push   $0x1
 5da:	83 c3 01             	add    $0x1,%ebx
 5dd:	31 ff                	xor    %edi,%edi
 5df:	e8 0e fe ff ff       	call   3f2 <write>
 5e4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5e8:	83 c4 10             	add    $0x10,%esp
 5eb:	84 d2                	test   %dl,%dl
 5ed:	0f 85 6b ff ff ff    	jne    55e <vprintf.constprop.0+0x4e>
 5f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5f6:	5b                   	pop    %ebx
 5f7:	5e                   	pop    %esi
 5f8:	5f                   	pop    %edi
 5f9:	5d                   	pop    %ebp
 5fa:	c3                   	ret    
 5fb:	90                   	nop
 5fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 600:	bf 25 00 00 00       	mov    $0x25,%edi
 605:	e9 45 ff ff ff       	jmp    54f <vprintf.constprop.0+0x3f>
 60a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 610:	8d 7e 04             	lea    0x4(%esi),%edi
 613:	31 c9                	xor    %ecx,%ecx
 615:	8b 06                	mov    (%esi),%eax
 617:	ba 0a 00 00 00       	mov    $0xa,%edx
 61c:	89 fe                	mov    %edi,%esi
 61e:	31 ff                	xor    %edi,%edi
 620:	e8 5b fe ff ff       	call   480 <printint.constprop.1>
 625:	e9 25 ff ff ff       	jmp    54f <vprintf.constprop.0+0x3f>
 62a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 630:	8b 06                	mov    (%esi),%eax
 632:	8d 7e 04             	lea    0x4(%esi),%edi
 635:	31 c9                	xor    %ecx,%ecx
 637:	ba 10 00 00 00       	mov    $0x10,%edx
 63c:	89 fe                	mov    %edi,%esi
 63e:	31 ff                	xor    %edi,%edi
 640:	e8 3b fe ff ff       	call   480 <printint.constprop.1>
 645:	e9 05 ff ff ff       	jmp    54f <vprintf.constprop.0+0x3f>
 64a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 650:	83 ec 04             	sub    $0x4,%esp
 653:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 656:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 659:	6a 01                	push   $0x1
 65b:	e9 77 ff ff ff       	jmp    5d7 <vprintf.constprop.0+0xc7>
 660:	8d 46 04             	lea    0x4(%esi),%eax
 663:	83 ec 04             	sub    $0x4,%esp
 666:	8b 3e                	mov    (%esi),%edi
 668:	6a 01                	push   $0x1
 66a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 66e:	be 08 00 00 00       	mov    $0x8,%esi
 673:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 676:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 679:	50                   	push   %eax
 67a:	6a 01                	push   $0x1
 67c:	e8 71 fd ff ff       	call   3f2 <write>
 681:	8d 45 e7             	lea    -0x19(%ebp),%eax
 684:	83 c4 0c             	add    $0xc,%esp
 687:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 68b:	6a 01                	push   $0x1
 68d:	50                   	push   %eax
 68e:	6a 01                	push   $0x1
 690:	e8 5d fd ff ff       	call   3f2 <write>
 695:	83 c4 10             	add    $0x10,%esp
 698:	90                   	nop
 699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6a0:	89 f8                	mov    %edi,%eax
 6a2:	83 ec 04             	sub    $0x4,%esp
 6a5:	c1 e7 04             	shl    $0x4,%edi
 6a8:	c1 e8 1c             	shr    $0x1c,%eax
 6ab:	6a 01                	push   $0x1
 6ad:	0f b6 80 48 09 00 00 	movzbl 0x948(%eax),%eax
 6b4:	88 45 e5             	mov    %al,-0x1b(%ebp)
 6b7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 6ba:	50                   	push   %eax
 6bb:	6a 01                	push   $0x1
 6bd:	e8 30 fd ff ff       	call   3f2 <write>
 6c2:	83 c4 10             	add    $0x10,%esp
 6c5:	83 ee 01             	sub    $0x1,%esi
 6c8:	75 d6                	jne    6a0 <vprintf.constprop.0+0x190>
 6ca:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 6cd:	31 ff                	xor    %edi,%edi
 6cf:	e9 7b fe ff ff       	jmp    54f <vprintf.constprop.0+0x3f>
 6d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6d8:	8b 3e                	mov    (%esi),%edi
 6da:	8d 46 04             	lea    0x4(%esi),%eax
 6dd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 6e0:	85 ff                	test   %edi,%edi
 6e2:	74 50                	je     734 <vprintf.constprop.0+0x224>
 6e4:	0f b6 07             	movzbl (%edi),%eax
 6e7:	84 c0                	test   %al,%al
 6e9:	74 df                	je     6ca <vprintf.constprop.0+0x1ba>
 6eb:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 6ee:	66 90                	xchg   %ax,%ax
 6f0:	83 ec 04             	sub    $0x4,%esp
 6f3:	83 c7 01             	add    $0x1,%edi
 6f6:	88 45 e3             	mov    %al,-0x1d(%ebp)
 6f9:	6a 01                	push   $0x1
 6fb:	56                   	push   %esi
 6fc:	6a 01                	push   $0x1
 6fe:	e8 ef fc ff ff       	call   3f2 <write>
 703:	0f b6 07             	movzbl (%edi),%eax
 706:	83 c4 10             	add    $0x10,%esp
 709:	84 c0                	test   %al,%al
 70b:	75 e3                	jne    6f0 <vprintf.constprop.0+0x1e0>
 70d:	eb bb                	jmp    6ca <vprintf.constprop.0+0x1ba>
 70f:	90                   	nop
 710:	8b 06                	mov    (%esi),%eax
 712:	83 ec 04             	sub    $0x4,%esp
 715:	8d 7e 04             	lea    0x4(%esi),%edi
 718:	6a 01                	push   $0x1
 71a:	89 fe                	mov    %edi,%esi
 71c:	31 ff                	xor    %edi,%edi
 71e:	88 45 e2             	mov    %al,-0x1e(%ebp)
 721:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 724:	50                   	push   %eax
 725:	6a 01                	push   $0x1
 727:	e8 c6 fc ff ff       	call   3f2 <write>
 72c:	83 c4 10             	add    $0x10,%esp
 72f:	e9 1b fe ff ff       	jmp    54f <vprintf.constprop.0+0x3f>
 734:	bf 3f 09 00 00       	mov    $0x93f,%edi
 739:	b8 28 00 00 00       	mov    $0x28,%eax
 73e:	eb ab                	jmp    6eb <vprintf.constprop.0+0x1db>

00000740 <fprintf>:
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	83 ec 08             	sub    $0x8,%esp
 746:	8b 45 0c             	mov    0xc(%ebp),%eax
 749:	8d 55 10             	lea    0x10(%ebp),%edx
 74c:	e8 bf fd ff ff       	call   510 <vprintf.constprop.0>
 751:	c9                   	leave  
 752:	c3                   	ret    
 753:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000760 <printf>:
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	83 ec 08             	sub    $0x8,%esp
 766:	8b 45 08             	mov    0x8(%ebp),%eax
 769:	8d 55 0c             	lea    0xc(%ebp),%edx
 76c:	e8 9f fd ff ff       	call   510 <vprintf.constprop.0>
 771:	c9                   	leave  
 772:	c3                   	ret    
 773:	66 90                	xchg   %ax,%ax
 775:	66 90                	xchg   %ax,%ax
 777:	66 90                	xchg   %ax,%ax
 779:	66 90                	xchg   %ax,%ax
 77b:	66 90                	xchg   %ax,%ax
 77d:	66 90                	xchg   %ax,%ax
 77f:	90                   	nop

00000780 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 780:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 781:	a1 80 0c 00 00       	mov    0xc80,%eax
{
 786:	89 e5                	mov    %esp,%ebp
 788:	57                   	push   %edi
 789:	56                   	push   %esi
 78a:	53                   	push   %ebx
 78b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 78e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 798:	39 c8                	cmp    %ecx,%eax
 79a:	8b 10                	mov    (%eax),%edx
 79c:	73 32                	jae    7d0 <free+0x50>
 79e:	39 d1                	cmp    %edx,%ecx
 7a0:	72 04                	jb     7a6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a2:	39 d0                	cmp    %edx,%eax
 7a4:	72 32                	jb     7d8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7a6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7a9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7ac:	39 fa                	cmp    %edi,%edx
 7ae:	74 30                	je     7e0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7b0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7b3:	8b 50 04             	mov    0x4(%eax),%edx
 7b6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7b9:	39 f1                	cmp    %esi,%ecx
 7bb:	74 3a                	je     7f7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7bd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 7bf:	a3 80 0c 00 00       	mov    %eax,0xc80
}
 7c4:	5b                   	pop    %ebx
 7c5:	5e                   	pop    %esi
 7c6:	5f                   	pop    %edi
 7c7:	5d                   	pop    %ebp
 7c8:	c3                   	ret    
 7c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d0:	39 d0                	cmp    %edx,%eax
 7d2:	72 04                	jb     7d8 <free+0x58>
 7d4:	39 d1                	cmp    %edx,%ecx
 7d6:	72 ce                	jb     7a6 <free+0x26>
{
 7d8:	89 d0                	mov    %edx,%eax
 7da:	eb bc                	jmp    798 <free+0x18>
 7dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 7e0:	03 72 04             	add    0x4(%edx),%esi
 7e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7e6:	8b 10                	mov    (%eax),%edx
 7e8:	8b 12                	mov    (%edx),%edx
 7ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7ed:	8b 50 04             	mov    0x4(%eax),%edx
 7f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7f3:	39 f1                	cmp    %esi,%ecx
 7f5:	75 c6                	jne    7bd <free+0x3d>
    p->s.size += bp->s.size;
 7f7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7fa:	a3 80 0c 00 00       	mov    %eax,0xc80
    p->s.size += bp->s.size;
 7ff:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 802:	8b 53 f8             	mov    -0x8(%ebx),%edx
 805:	89 10                	mov    %edx,(%eax)
}
 807:	5b                   	pop    %ebx
 808:	5e                   	pop    %esi
 809:	5f                   	pop    %edi
 80a:	5d                   	pop    %ebp
 80b:	c3                   	ret    
 80c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000810 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	57                   	push   %edi
 814:	56                   	push   %esi
 815:	53                   	push   %ebx
 816:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 819:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 81c:	8b 15 80 0c 00 00    	mov    0xc80,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 822:	8d 78 07             	lea    0x7(%eax),%edi
 825:	c1 ef 03             	shr    $0x3,%edi
 828:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 82b:	85 d2                	test   %edx,%edx
 82d:	0f 84 9d 00 00 00    	je     8d0 <malloc+0xc0>
 833:	8b 02                	mov    (%edx),%eax
 835:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 838:	39 cf                	cmp    %ecx,%edi
 83a:	76 6c                	jbe    8a8 <malloc+0x98>
 83c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 842:	bb 00 10 00 00       	mov    $0x1000,%ebx
 847:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 84a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 851:	eb 0e                	jmp    861 <malloc+0x51>
 853:	90                   	nop
 854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 858:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 85a:	8b 48 04             	mov    0x4(%eax),%ecx
 85d:	39 f9                	cmp    %edi,%ecx
 85f:	73 47                	jae    8a8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 861:	39 05 80 0c 00 00    	cmp    %eax,0xc80
 867:	89 c2                	mov    %eax,%edx
 869:	75 ed                	jne    858 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 86b:	83 ec 0c             	sub    $0xc,%esp
 86e:	56                   	push   %esi
 86f:	e8 e6 fb ff ff       	call   45a <sbrk>
  if(p == (char*)-1)
 874:	83 c4 10             	add    $0x10,%esp
 877:	83 f8 ff             	cmp    $0xffffffff,%eax
 87a:	74 1c                	je     898 <malloc+0x88>
  hp->s.size = nu;
 87c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 87f:	83 ec 0c             	sub    $0xc,%esp
 882:	83 c0 08             	add    $0x8,%eax
 885:	50                   	push   %eax
 886:	e8 f5 fe ff ff       	call   780 <free>
  return freep;
 88b:	8b 15 80 0c 00 00    	mov    0xc80,%edx
      if((p = morecore(nunits)) == 0)
 891:	83 c4 10             	add    $0x10,%esp
 894:	85 d2                	test   %edx,%edx
 896:	75 c0                	jne    858 <malloc+0x48>
        return 0;
  }
}
 898:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 89b:	31 c0                	xor    %eax,%eax
}
 89d:	5b                   	pop    %ebx
 89e:	5e                   	pop    %esi
 89f:	5f                   	pop    %edi
 8a0:	5d                   	pop    %ebp
 8a1:	c3                   	ret    
 8a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 8a8:	39 cf                	cmp    %ecx,%edi
 8aa:	74 54                	je     900 <malloc+0xf0>
        p->s.size -= nunits;
 8ac:	29 f9                	sub    %edi,%ecx
 8ae:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8b1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8b4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 8b7:	89 15 80 0c 00 00    	mov    %edx,0xc80
}
 8bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 8c0:	83 c0 08             	add    $0x8,%eax
}
 8c3:	5b                   	pop    %ebx
 8c4:	5e                   	pop    %esi
 8c5:	5f                   	pop    %edi
 8c6:	5d                   	pop    %ebp
 8c7:	c3                   	ret    
 8c8:	90                   	nop
 8c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 8d0:	c7 05 80 0c 00 00 84 	movl   $0xc84,0xc80
 8d7:	0c 00 00 
 8da:	c7 05 84 0c 00 00 84 	movl   $0xc84,0xc84
 8e1:	0c 00 00 
    base.s.size = 0;
 8e4:	b8 84 0c 00 00       	mov    $0xc84,%eax
 8e9:	c7 05 88 0c 00 00 00 	movl   $0x0,0xc88
 8f0:	00 00 00 
 8f3:	e9 44 ff ff ff       	jmp    83c <malloc+0x2c>
 8f8:	90                   	nop
 8f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 900:	8b 08                	mov    (%eax),%ecx
 902:	89 0a                	mov    %ecx,(%edx)
 904:	eb b1                	jmp    8b7 <malloc+0xa7>
