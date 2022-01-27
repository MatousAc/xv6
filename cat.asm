
user/_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

int
main(int argc, char *argv[])
{
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
  int fd, i;

  if(argc <= 1){
  21:	83 f8 01             	cmp    $0x1,%eax
{
  24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(argc <= 1){
  27:	7e 54                	jle    7d <main+0x7d>
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 66 03 00 00       	call   3a2 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	85 c0                	test   %eax,%eax
  41:	89 c7                	mov    %eax,%edi
  43:	78 24                	js     69 <main+0x69>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  45:	83 ec 0c             	sub    $0xc,%esp
  for(i = 1; i < argc; i++){
  48:	83 c6 01             	add    $0x1,%esi
  4b:	83 c3 04             	add    $0x4,%ebx
    cat(fd);
  4e:	50                   	push   %eax
  4f:	e8 3c 00 00 00       	call   90 <cat>
    close(fd);
  54:	89 3c 24             	mov    %edi,(%esp)
  57:	e8 2e 03 00 00       	call   38a <close>
  for(i = 1; i < argc; i++){
  5c:	83 c4 10             	add    $0x10,%esp
  5f:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  62:	75 cc                	jne    30 <main+0x30>
  }
  exit();
  64:	e8 f9 02 00 00       	call   362 <exit>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
  69:	50                   	push   %eax
  6a:	ff 33                	pushl  (%ebx)
  6c:	68 bb 08 00 00       	push   $0x8bb
  71:	6a 02                	push   $0x2
  73:	e8 58 06 00 00       	call   6d0 <fprintf>
      exit();
  78:	e8 e5 02 00 00       	call   362 <exit>
    cat(0);
  7d:	83 ec 0c             	sub    $0xc,%esp
  80:	6a 00                	push   $0x0
  82:	e8 09 00 00 00       	call   90 <cat>
    exit();
  87:	e8 d6 02 00 00       	call   362 <exit>
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <cat>:
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	56                   	push   %esi
  94:	53                   	push   %ebx
  95:	8b 75 08             	mov    0x8(%ebp),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  98:	eb 1d                	jmp    b7 <cat+0x27>
  9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
  a0:	83 ec 04             	sub    $0x4,%esp
  a3:	53                   	push   %ebx
  a4:	68 20 0c 00 00       	push   $0xc20
  a9:	6a 01                	push   $0x1
  ab:	e8 d2 02 00 00       	call   382 <write>
  b0:	83 c4 10             	add    $0x10,%esp
  b3:	39 d8                	cmp    %ebx,%eax
  b5:	75 26                	jne    dd <cat+0x4d>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  b7:	83 ec 04             	sub    $0x4,%esp
  ba:	68 00 02 00 00       	push   $0x200
  bf:	68 20 0c 00 00       	push   $0xc20
  c4:	56                   	push   %esi
  c5:	e8 b0 02 00 00       	call   37a <read>
  ca:	83 c4 10             	add    $0x10,%esp
  cd:	83 f8 00             	cmp    $0x0,%eax
  d0:	89 c3                	mov    %eax,%ebx
  d2:	7f cc                	jg     a0 <cat+0x10>
  if(n < 0){
  d4:	75 1b                	jne    f1 <cat+0x61>
}
  d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  d9:	5b                   	pop    %ebx
  da:	5e                   	pop    %esi
  db:	5d                   	pop    %ebp
  dc:	c3                   	ret    
      fprintf(2, "cat: write error\n");
  dd:	83 ec 08             	sub    $0x8,%esp
  e0:	68 98 08 00 00       	push   $0x898
  e5:	6a 02                	push   $0x2
  e7:	e8 e4 05 00 00       	call   6d0 <fprintf>
      exit();
  ec:	e8 71 02 00 00       	call   362 <exit>
    fprintf(2, "cat: read error\n");
  f1:	50                   	push   %eax
  f2:	50                   	push   %eax
  f3:	68 aa 08 00 00       	push   $0x8aa
  f8:	6a 02                	push   $0x2
  fa:	e8 d1 05 00 00       	call   6d0 <fprintf>
    exit();
  ff:	e8 5e 02 00 00       	call   362 <exit>
 104:	66 90                	xchg   %ax,%ax
 106:	66 90                	xchg   %ax,%ax
 108:	66 90                	xchg   %ax,%ax
 10a:	66 90                	xchg   %ax,%ax
 10c:	66 90                	xchg   %ax,%ax
 10e:	66 90                	xchg   %ax,%ax

00000110 <strcpy>:
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	53                   	push   %ebx
 114:	8b 45 08             	mov    0x8(%ebp),%eax
 117:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 11a:	89 c2                	mov    %eax,%edx
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 120:	83 c1 01             	add    $0x1,%ecx
 123:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 127:	83 c2 01             	add    $0x1,%edx
 12a:	84 db                	test   %bl,%bl
 12c:	88 5a ff             	mov    %bl,-0x1(%edx)
 12f:	75 ef                	jne    120 <strcpy+0x10>
 131:	5b                   	pop    %ebx
 132:	5d                   	pop    %ebp
 133:	c3                   	ret    
 134:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 13a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000140 <strcmp>:
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 55 08             	mov    0x8(%ebp),%edx
 147:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 14a:	0f b6 02             	movzbl (%edx),%eax
 14d:	0f b6 19             	movzbl (%ecx),%ebx
 150:	84 c0                	test   %al,%al
 152:	75 1c                	jne    170 <strcmp+0x30>
 154:	eb 2a                	jmp    180 <strcmp+0x40>
 156:	8d 76 00             	lea    0x0(%esi),%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 160:	83 c2 01             	add    $0x1,%edx
 163:	0f b6 02             	movzbl (%edx),%eax
 166:	83 c1 01             	add    $0x1,%ecx
 169:	0f b6 19             	movzbl (%ecx),%ebx
 16c:	84 c0                	test   %al,%al
 16e:	74 10                	je     180 <strcmp+0x40>
 170:	38 d8                	cmp    %bl,%al
 172:	74 ec                	je     160 <strcmp+0x20>
 174:	29 d8                	sub    %ebx,%eax
 176:	5b                   	pop    %ebx
 177:	5d                   	pop    %ebp
 178:	c3                   	ret    
 179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 180:	31 c0                	xor    %eax,%eax
 182:	29 d8                	sub    %ebx,%eax
 184:	5b                   	pop    %ebx
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
 187:	89 f6                	mov    %esi,%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000190 <strlen>:
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 4d 08             	mov    0x8(%ebp),%ecx
 196:	80 39 00             	cmpb   $0x0,(%ecx)
 199:	74 15                	je     1b0 <strlen+0x20>
 19b:	31 d2                	xor    %edx,%edx
 19d:	8d 76 00             	lea    0x0(%esi),%esi
 1a0:	83 c2 01             	add    $0x1,%edx
 1a3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1a7:	89 d0                	mov    %edx,%eax
 1a9:	75 f5                	jne    1a0 <strlen+0x10>
 1ab:	5d                   	pop    %ebp
 1ac:	c3                   	ret    
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
 1b0:	31 c0                	xor    %eax,%eax
 1b2:	5d                   	pop    %ebp
 1b3:	c3                   	ret    
 1b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001c0 <memset>:
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	57                   	push   %edi
 1c4:	8b 55 08             	mov    0x8(%ebp),%edx
 1c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 1cd:	89 d7                	mov    %edx,%edi
 1cf:	fc                   	cld    
 1d0:	f3 aa                	rep stos %al,%es:(%edi)
 1d2:	89 d0                	mov    %edx,%eax
 1d4:	5f                   	pop    %edi
 1d5:	5d                   	pop    %ebp
 1d6:	c3                   	ret    
 1d7:	89 f6                	mov    %esi,%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001e0 <strchr>:
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	53                   	push   %ebx
 1e4:	8b 45 08             	mov    0x8(%ebp),%eax
 1e7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1ea:	0f b6 10             	movzbl (%eax),%edx
 1ed:	84 d2                	test   %dl,%dl
 1ef:	74 1d                	je     20e <strchr+0x2e>
 1f1:	38 d3                	cmp    %dl,%bl
 1f3:	89 d9                	mov    %ebx,%ecx
 1f5:	75 0d                	jne    204 <strchr+0x24>
 1f7:	eb 17                	jmp    210 <strchr+0x30>
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 200:	38 ca                	cmp    %cl,%dl
 202:	74 0c                	je     210 <strchr+0x30>
 204:	83 c0 01             	add    $0x1,%eax
 207:	0f b6 10             	movzbl (%eax),%edx
 20a:	84 d2                	test   %dl,%dl
 20c:	75 f2                	jne    200 <strchr+0x20>
 20e:	31 c0                	xor    %eax,%eax
 210:	5b                   	pop    %ebx
 211:	5d                   	pop    %ebp
 212:	c3                   	ret    
 213:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000220 <gets>:
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
 225:	53                   	push   %ebx
 226:	31 f6                	xor    %esi,%esi
 228:	89 f3                	mov    %esi,%ebx
 22a:	83 ec 1c             	sub    $0x1c,%esp
 22d:	8b 7d 08             	mov    0x8(%ebp),%edi
 230:	eb 2f                	jmp    261 <gets+0x41>
 232:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 238:	8d 45 e7             	lea    -0x19(%ebp),%eax
 23b:	83 ec 04             	sub    $0x4,%esp
 23e:	6a 01                	push   $0x1
 240:	50                   	push   %eax
 241:	6a 00                	push   $0x0
 243:	e8 32 01 00 00       	call   37a <read>
 248:	83 c4 10             	add    $0x10,%esp
 24b:	85 c0                	test   %eax,%eax
 24d:	7e 1c                	jle    26b <gets+0x4b>
 24f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 253:	83 c7 01             	add    $0x1,%edi
 256:	88 47 ff             	mov    %al,-0x1(%edi)
 259:	3c 0a                	cmp    $0xa,%al
 25b:	74 23                	je     280 <gets+0x60>
 25d:	3c 0d                	cmp    $0xd,%al
 25f:	74 1f                	je     280 <gets+0x60>
 261:	83 c3 01             	add    $0x1,%ebx
 264:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 267:	89 fe                	mov    %edi,%esi
 269:	7c cd                	jl     238 <gets+0x18>
 26b:	89 f3                	mov    %esi,%ebx
 26d:	8b 45 08             	mov    0x8(%ebp),%eax
 270:	c6 03 00             	movb   $0x0,(%ebx)
 273:	8d 65 f4             	lea    -0xc(%ebp),%esp
 276:	5b                   	pop    %ebx
 277:	5e                   	pop    %esi
 278:	5f                   	pop    %edi
 279:	5d                   	pop    %ebp
 27a:	c3                   	ret    
 27b:	90                   	nop
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 280:	8b 75 08             	mov    0x8(%ebp),%esi
 283:	8b 45 08             	mov    0x8(%ebp),%eax
 286:	01 de                	add    %ebx,%esi
 288:	89 f3                	mov    %esi,%ebx
 28a:	c6 03 00             	movb   $0x0,(%ebx)
 28d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 290:	5b                   	pop    %ebx
 291:	5e                   	pop    %esi
 292:	5f                   	pop    %edi
 293:	5d                   	pop    %ebp
 294:	c3                   	ret    
 295:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002a0 <stat>:
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	53                   	push   %ebx
 2a5:	83 ec 08             	sub    $0x8,%esp
 2a8:	6a 00                	push   $0x0
 2aa:	ff 75 08             	pushl  0x8(%ebp)
 2ad:	e8 f0 00 00 00       	call   3a2 <open>
 2b2:	83 c4 10             	add    $0x10,%esp
 2b5:	85 c0                	test   %eax,%eax
 2b7:	78 27                	js     2e0 <stat+0x40>
 2b9:	83 ec 08             	sub    $0x8,%esp
 2bc:	ff 75 0c             	pushl  0xc(%ebp)
 2bf:	89 c3                	mov    %eax,%ebx
 2c1:	50                   	push   %eax
 2c2:	e8 f3 00 00 00       	call   3ba <fstat>
 2c7:	89 1c 24             	mov    %ebx,(%esp)
 2ca:	89 c6                	mov    %eax,%esi
 2cc:	e8 b9 00 00 00       	call   38a <close>
 2d1:	83 c4 10             	add    $0x10,%esp
 2d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2d7:	89 f0                	mov    %esi,%eax
 2d9:	5b                   	pop    %ebx
 2da:	5e                   	pop    %esi
 2db:	5d                   	pop    %ebp
 2dc:	c3                   	ret    
 2dd:	8d 76 00             	lea    0x0(%esi),%esi
 2e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2e5:	eb ed                	jmp    2d4 <stat+0x34>
 2e7:	89 f6                	mov    %esi,%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002f0 <atoi>:
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	53                   	push   %ebx
 2f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2f7:	0f be 11             	movsbl (%ecx),%edx
 2fa:	8d 42 d0             	lea    -0x30(%edx),%eax
 2fd:	3c 09                	cmp    $0x9,%al
 2ff:	b8 00 00 00 00       	mov    $0x0,%eax
 304:	77 1f                	ja     325 <atoi+0x35>
 306:	8d 76 00             	lea    0x0(%esi),%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 310:	8d 04 80             	lea    (%eax,%eax,4),%eax
 313:	83 c1 01             	add    $0x1,%ecx
 316:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 31a:	0f be 11             	movsbl (%ecx),%edx
 31d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 320:	80 fb 09             	cmp    $0x9,%bl
 323:	76 eb                	jbe    310 <atoi+0x20>
 325:	5b                   	pop    %ebx
 326:	5d                   	pop    %ebp
 327:	c3                   	ret    
 328:	90                   	nop
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000330 <memmove>:
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	56                   	push   %esi
 334:	53                   	push   %ebx
 335:	8b 5d 10             	mov    0x10(%ebp),%ebx
 338:	8b 45 08             	mov    0x8(%ebp),%eax
 33b:	8b 75 0c             	mov    0xc(%ebp),%esi
 33e:	85 db                	test   %ebx,%ebx
 340:	7e 14                	jle    356 <memmove+0x26>
 342:	31 d2                	xor    %edx,%edx
 344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 348:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 34c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 34f:	83 c2 01             	add    $0x1,%edx
 352:	39 d3                	cmp    %edx,%ebx
 354:	75 f2                	jne    348 <memmove+0x18>
 356:	5b                   	pop    %ebx
 357:	5e                   	pop    %esi
 358:	5d                   	pop    %ebp
 359:	c3                   	ret    

0000035a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 35a:	b8 01 00 00 00       	mov    $0x1,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <exit>:
SYSCALL(exit)
 362:	b8 02 00 00 00       	mov    $0x2,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <wait>:
SYSCALL(wait)
 36a:	b8 03 00 00 00       	mov    $0x3,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <pipe>:
SYSCALL(pipe)
 372:	b8 04 00 00 00       	mov    $0x4,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <read>:
SYSCALL(read)
 37a:	b8 05 00 00 00       	mov    $0x5,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <write>:
SYSCALL(write)
 382:	b8 10 00 00 00       	mov    $0x10,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <close>:
SYSCALL(close)
 38a:	b8 15 00 00 00       	mov    $0x15,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <kill>:
SYSCALL(kill)
 392:	b8 06 00 00 00       	mov    $0x6,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <exec>:
SYSCALL(exec)
 39a:	b8 07 00 00 00       	mov    $0x7,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <open>:
SYSCALL(open)
 3a2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <mknod>:
SYSCALL(mknod)
 3aa:	b8 11 00 00 00       	mov    $0x11,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <unlink>:
SYSCALL(unlink)
 3b2:	b8 12 00 00 00       	mov    $0x12,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <fstat>:
SYSCALL(fstat)
 3ba:	b8 08 00 00 00       	mov    $0x8,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <link>:
SYSCALL(link)
 3c2:	b8 13 00 00 00       	mov    $0x13,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <mkdir>:
SYSCALL(mkdir)
 3ca:	b8 14 00 00 00       	mov    $0x14,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <chdir>:
SYSCALL(chdir)
 3d2:	b8 09 00 00 00       	mov    $0x9,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <dup>:
SYSCALL(dup)
 3da:	b8 0a 00 00 00       	mov    $0xa,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <getpid>:
SYSCALL(getpid)
 3e2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <sbrk>:
SYSCALL(sbrk)
 3ea:	b8 0c 00 00 00       	mov    $0xc,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <sleep>:
SYSCALL(sleep)
 3f2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <uptime>:
SYSCALL(uptime)
 3fa:	b8 0e 00 00 00       	mov    $0xe,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <cpuhalt>:
SYSCALL(cpuhalt)
 402:	b8 16 00 00 00       	mov    $0x16,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    
 40a:	66 90                	xchg   %ax,%ax
 40c:	66 90                	xchg   %ax,%ax
 40e:	66 90                	xchg   %ax,%ax

00000410 <printint.constprop.1>:
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	89 d6                	mov    %edx,%esi
 418:	83 ec 3c             	sub    $0x3c,%esp
 41b:	85 c0                	test   %eax,%eax
 41d:	79 71                	jns    490 <printint.constprop.1+0x80>
 41f:	83 e1 01             	and    $0x1,%ecx
 422:	74 6c                	je     490 <printint.constprop.1+0x80>
 424:	f7 d8                	neg    %eax
 426:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 42d:	31 c9                	xor    %ecx,%ecx
 42f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 432:	eb 06                	jmp    43a <printint.constprop.1+0x2a>
 434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 438:	89 f9                	mov    %edi,%ecx
 43a:	31 d2                	xor    %edx,%edx
 43c:	8d 79 01             	lea    0x1(%ecx),%edi
 43f:	f7 f6                	div    %esi
 441:	0f b6 92 d8 08 00 00 	movzbl 0x8d8(%edx),%edx
 448:	85 c0                	test   %eax,%eax
 44a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
 44d:	75 e9                	jne    438 <printint.constprop.1+0x28>
 44f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 452:	85 c0                	test   %eax,%eax
 454:	74 08                	je     45e <printint.constprop.1+0x4e>
 456:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 45b:	8d 79 02             	lea    0x2(%ecx),%edi
 45e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 462:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 468:	0f b6 06             	movzbl (%esi),%eax
 46b:	83 ec 04             	sub    $0x4,%esp
 46e:	83 ee 01             	sub    $0x1,%esi
 471:	6a 01                	push   $0x1
 473:	53                   	push   %ebx
 474:	6a 01                	push   $0x1
 476:	88 45 d7             	mov    %al,-0x29(%ebp)
 479:	e8 04 ff ff ff       	call   382 <write>
 47e:	83 c4 10             	add    $0x10,%esp
 481:	39 de                	cmp    %ebx,%esi
 483:	75 e3                	jne    468 <printint.constprop.1+0x58>
 485:	8d 65 f4             	lea    -0xc(%ebp),%esp
 488:	5b                   	pop    %ebx
 489:	5e                   	pop    %esi
 48a:	5f                   	pop    %edi
 48b:	5d                   	pop    %ebp
 48c:	c3                   	ret    
 48d:	8d 76 00             	lea    0x0(%esi),%esi
 490:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 497:	eb 94                	jmp    42d <printint.constprop.1+0x1d>
 499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004a0 <vprintf.constprop.0>:
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	53                   	push   %ebx
 4a6:	89 d6                	mov    %edx,%esi
 4a8:	83 ec 2c             	sub    $0x2c,%esp
 4ab:	0f b6 10             	movzbl (%eax),%edx
 4ae:	84 d2                	test   %dl,%dl
 4b0:	0f 84 cd 00 00 00    	je     583 <vprintf.constprop.0+0xe3>
 4b6:	8d 58 01             	lea    0x1(%eax),%ebx
 4b9:	31 ff                	xor    %edi,%edi
 4bb:	eb 31                	jmp    4ee <vprintf.constprop.0+0x4e>
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
 4c0:	83 f8 25             	cmp    $0x25,%eax
 4c3:	0f 84 c7 00 00 00    	je     590 <vprintf.constprop.0+0xf0>
 4c9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4cc:	83 ec 04             	sub    $0x4,%esp
 4cf:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 4d2:	6a 01                	push   $0x1
 4d4:	50                   	push   %eax
 4d5:	6a 01                	push   $0x1
 4d7:	e8 a6 fe ff ff       	call   382 <write>
 4dc:	83 c4 10             	add    $0x10,%esp
 4df:	83 c3 01             	add    $0x1,%ebx
 4e2:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4e6:	84 d2                	test   %dl,%dl
 4e8:	0f 84 95 00 00 00    	je     583 <vprintf.constprop.0+0xe3>
 4ee:	85 ff                	test   %edi,%edi
 4f0:	0f b6 c2             	movzbl %dl,%eax
 4f3:	74 cb                	je     4c0 <vprintf.constprop.0+0x20>
 4f5:	83 ff 25             	cmp    $0x25,%edi
 4f8:	75 e5                	jne    4df <vprintf.constprop.0+0x3f>
 4fa:	83 f8 64             	cmp    $0x64,%eax
 4fd:	8d 7e 04             	lea    0x4(%esi),%edi
 500:	b9 01 00 00 00       	mov    $0x1,%ecx
 505:	0f 84 9a 00 00 00    	je     5a5 <vprintf.constprop.0+0x105>
 50b:	83 f8 6c             	cmp    $0x6c,%eax
 50e:	0f 84 8c 00 00 00    	je     5a0 <vprintf.constprop.0+0x100>
 514:	83 f8 78             	cmp    $0x78,%eax
 517:	0f 84 a3 00 00 00    	je     5c0 <vprintf.constprop.0+0x120>
 51d:	83 f8 70             	cmp    $0x70,%eax
 520:	0f 84 ca 00 00 00    	je     5f0 <vprintf.constprop.0+0x150>
 526:	83 f8 73             	cmp    $0x73,%eax
 529:	0f 84 39 01 00 00    	je     668 <vprintf.constprop.0+0x1c8>
 52f:	83 f8 63             	cmp    $0x63,%eax
 532:	0f 84 68 01 00 00    	je     6a0 <vprintf.constprop.0+0x200>
 538:	83 f8 25             	cmp    $0x25,%eax
 53b:	0f 84 9f 00 00 00    	je     5e0 <vprintf.constprop.0+0x140>
 541:	8d 45 df             	lea    -0x21(%ebp),%eax
 544:	83 ec 04             	sub    $0x4,%esp
 547:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 54a:	6a 01                	push   $0x1
 54c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 550:	50                   	push   %eax
 551:	6a 01                	push   $0x1
 553:	e8 2a fe ff ff       	call   382 <write>
 558:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 55c:	83 c4 0c             	add    $0xc,%esp
 55f:	8d 45 e0             	lea    -0x20(%ebp),%eax
 562:	6a 01                	push   $0x1
 564:	88 55 e0             	mov    %dl,-0x20(%ebp)
 567:	50                   	push   %eax
 568:	6a 01                	push   $0x1
 56a:	83 c3 01             	add    $0x1,%ebx
 56d:	31 ff                	xor    %edi,%edi
 56f:	e8 0e fe ff ff       	call   382 <write>
 574:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 578:	83 c4 10             	add    $0x10,%esp
 57b:	84 d2                	test   %dl,%dl
 57d:	0f 85 6b ff ff ff    	jne    4ee <vprintf.constprop.0+0x4e>
 583:	8d 65 f4             	lea    -0xc(%ebp),%esp
 586:	5b                   	pop    %ebx
 587:	5e                   	pop    %esi
 588:	5f                   	pop    %edi
 589:	5d                   	pop    %ebp
 58a:	c3                   	ret    
 58b:	90                   	nop
 58c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 590:	bf 25 00 00 00       	mov    $0x25,%edi
 595:	e9 45 ff ff ff       	jmp    4df <vprintf.constprop.0+0x3f>
 59a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5a0:	8d 7e 04             	lea    0x4(%esi),%edi
 5a3:	31 c9                	xor    %ecx,%ecx
 5a5:	8b 06                	mov    (%esi),%eax
 5a7:	ba 0a 00 00 00       	mov    $0xa,%edx
 5ac:	89 fe                	mov    %edi,%esi
 5ae:	31 ff                	xor    %edi,%edi
 5b0:	e8 5b fe ff ff       	call   410 <printint.constprop.1>
 5b5:	e9 25 ff ff ff       	jmp    4df <vprintf.constprop.0+0x3f>
 5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5c0:	8b 06                	mov    (%esi),%eax
 5c2:	8d 7e 04             	lea    0x4(%esi),%edi
 5c5:	31 c9                	xor    %ecx,%ecx
 5c7:	ba 10 00 00 00       	mov    $0x10,%edx
 5cc:	89 fe                	mov    %edi,%esi
 5ce:	31 ff                	xor    %edi,%edi
 5d0:	e8 3b fe ff ff       	call   410 <printint.constprop.1>
 5d5:	e9 05 ff ff ff       	jmp    4df <vprintf.constprop.0+0x3f>
 5da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5e0:	83 ec 04             	sub    $0x4,%esp
 5e3:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 5e6:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 5e9:	6a 01                	push   $0x1
 5eb:	e9 77 ff ff ff       	jmp    567 <vprintf.constprop.0+0xc7>
 5f0:	8d 46 04             	lea    0x4(%esi),%eax
 5f3:	83 ec 04             	sub    $0x4,%esp
 5f6:	8b 3e                	mov    (%esi),%edi
 5f8:	6a 01                	push   $0x1
 5fa:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 5fe:	be 08 00 00 00       	mov    $0x8,%esi
 603:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 606:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 609:	50                   	push   %eax
 60a:	6a 01                	push   $0x1
 60c:	e8 71 fd ff ff       	call   382 <write>
 611:	8d 45 e7             	lea    -0x19(%ebp),%eax
 614:	83 c4 0c             	add    $0xc,%esp
 617:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 61b:	6a 01                	push   $0x1
 61d:	50                   	push   %eax
 61e:	6a 01                	push   $0x1
 620:	e8 5d fd ff ff       	call   382 <write>
 625:	83 c4 10             	add    $0x10,%esp
 628:	90                   	nop
 629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 630:	89 f8                	mov    %edi,%eax
 632:	83 ec 04             	sub    $0x4,%esp
 635:	c1 e7 04             	shl    $0x4,%edi
 638:	c1 e8 1c             	shr    $0x1c,%eax
 63b:	6a 01                	push   $0x1
 63d:	0f b6 80 d8 08 00 00 	movzbl 0x8d8(%eax),%eax
 644:	88 45 e5             	mov    %al,-0x1b(%ebp)
 647:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 64a:	50                   	push   %eax
 64b:	6a 01                	push   $0x1
 64d:	e8 30 fd ff ff       	call   382 <write>
 652:	83 c4 10             	add    $0x10,%esp
 655:	83 ee 01             	sub    $0x1,%esi
 658:	75 d6                	jne    630 <vprintf.constprop.0+0x190>
 65a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 65d:	31 ff                	xor    %edi,%edi
 65f:	e9 7b fe ff ff       	jmp    4df <vprintf.constprop.0+0x3f>
 664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 668:	8b 3e                	mov    (%esi),%edi
 66a:	8d 46 04             	lea    0x4(%esi),%eax
 66d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 670:	85 ff                	test   %edi,%edi
 672:	74 50                	je     6c4 <vprintf.constprop.0+0x224>
 674:	0f b6 07             	movzbl (%edi),%eax
 677:	84 c0                	test   %al,%al
 679:	74 df                	je     65a <vprintf.constprop.0+0x1ba>
 67b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 67e:	66 90                	xchg   %ax,%ax
 680:	83 ec 04             	sub    $0x4,%esp
 683:	83 c7 01             	add    $0x1,%edi
 686:	88 45 e3             	mov    %al,-0x1d(%ebp)
 689:	6a 01                	push   $0x1
 68b:	56                   	push   %esi
 68c:	6a 01                	push   $0x1
 68e:	e8 ef fc ff ff       	call   382 <write>
 693:	0f b6 07             	movzbl (%edi),%eax
 696:	83 c4 10             	add    $0x10,%esp
 699:	84 c0                	test   %al,%al
 69b:	75 e3                	jne    680 <vprintf.constprop.0+0x1e0>
 69d:	eb bb                	jmp    65a <vprintf.constprop.0+0x1ba>
 69f:	90                   	nop
 6a0:	8b 06                	mov    (%esi),%eax
 6a2:	83 ec 04             	sub    $0x4,%esp
 6a5:	8d 7e 04             	lea    0x4(%esi),%edi
 6a8:	6a 01                	push   $0x1
 6aa:	89 fe                	mov    %edi,%esi
 6ac:	31 ff                	xor    %edi,%edi
 6ae:	88 45 e2             	mov    %al,-0x1e(%ebp)
 6b1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6b4:	50                   	push   %eax
 6b5:	6a 01                	push   $0x1
 6b7:	e8 c6 fc ff ff       	call   382 <write>
 6bc:	83 c4 10             	add    $0x10,%esp
 6bf:	e9 1b fe ff ff       	jmp    4df <vprintf.constprop.0+0x3f>
 6c4:	bf d0 08 00 00       	mov    $0x8d0,%edi
 6c9:	b8 28 00 00 00       	mov    $0x28,%eax
 6ce:	eb ab                	jmp    67b <vprintf.constprop.0+0x1db>

000006d0 <fprintf>:
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	83 ec 08             	sub    $0x8,%esp
 6d6:	8b 45 0c             	mov    0xc(%ebp),%eax
 6d9:	8d 55 10             	lea    0x10(%ebp),%edx
 6dc:	e8 bf fd ff ff       	call   4a0 <vprintf.constprop.0>
 6e1:	c9                   	leave  
 6e2:	c3                   	ret    
 6e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006f0 <printf>:
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	83 ec 08             	sub    $0x8,%esp
 6f6:	8b 45 08             	mov    0x8(%ebp),%eax
 6f9:	8d 55 0c             	lea    0xc(%ebp),%edx
 6fc:	e8 9f fd ff ff       	call   4a0 <vprintf.constprop.0>
 701:	c9                   	leave  
 702:	c3                   	ret    
 703:	66 90                	xchg   %ax,%ax
 705:	66 90                	xchg   %ax,%ax
 707:	66 90                	xchg   %ax,%ax
 709:	66 90                	xchg   %ax,%ax
 70b:	66 90                	xchg   %ax,%ax
 70d:	66 90                	xchg   %ax,%ax
 70f:	90                   	nop

00000710 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 710:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 711:	a1 00 0c 00 00       	mov    0xc00,%eax
{
 716:	89 e5                	mov    %esp,%ebp
 718:	57                   	push   %edi
 719:	56                   	push   %esi
 71a:	53                   	push   %ebx
 71b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 71e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 721:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 728:	39 c8                	cmp    %ecx,%eax
 72a:	8b 10                	mov    (%eax),%edx
 72c:	73 32                	jae    760 <free+0x50>
 72e:	39 d1                	cmp    %edx,%ecx
 730:	72 04                	jb     736 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 732:	39 d0                	cmp    %edx,%eax
 734:	72 32                	jb     768 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 736:	8b 73 fc             	mov    -0x4(%ebx),%esi
 739:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 73c:	39 fa                	cmp    %edi,%edx
 73e:	74 30                	je     770 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 740:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 743:	8b 50 04             	mov    0x4(%eax),%edx
 746:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 749:	39 f1                	cmp    %esi,%ecx
 74b:	74 3a                	je     787 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 74d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 74f:	a3 00 0c 00 00       	mov    %eax,0xc00
}
 754:	5b                   	pop    %ebx
 755:	5e                   	pop    %esi
 756:	5f                   	pop    %edi
 757:	5d                   	pop    %ebp
 758:	c3                   	ret    
 759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 760:	39 d0                	cmp    %edx,%eax
 762:	72 04                	jb     768 <free+0x58>
 764:	39 d1                	cmp    %edx,%ecx
 766:	72 ce                	jb     736 <free+0x26>
{
 768:	89 d0                	mov    %edx,%eax
 76a:	eb bc                	jmp    728 <free+0x18>
 76c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 770:	03 72 04             	add    0x4(%edx),%esi
 773:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 776:	8b 10                	mov    (%eax),%edx
 778:	8b 12                	mov    (%edx),%edx
 77a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 77d:	8b 50 04             	mov    0x4(%eax),%edx
 780:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 783:	39 f1                	cmp    %esi,%ecx
 785:	75 c6                	jne    74d <free+0x3d>
    p->s.size += bp->s.size;
 787:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 78a:	a3 00 0c 00 00       	mov    %eax,0xc00
    p->s.size += bp->s.size;
 78f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 792:	8b 53 f8             	mov    -0x8(%ebx),%edx
 795:	89 10                	mov    %edx,(%eax)
}
 797:	5b                   	pop    %ebx
 798:	5e                   	pop    %esi
 799:	5f                   	pop    %edi
 79a:	5d                   	pop    %ebp
 79b:	c3                   	ret    
 79c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7a0:	55                   	push   %ebp
 7a1:	89 e5                	mov    %esp,%ebp
 7a3:	57                   	push   %edi
 7a4:	56                   	push   %esi
 7a5:	53                   	push   %ebx
 7a6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7ac:	8b 15 00 0c 00 00    	mov    0xc00,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b2:	8d 78 07             	lea    0x7(%eax),%edi
 7b5:	c1 ef 03             	shr    $0x3,%edi
 7b8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7bb:	85 d2                	test   %edx,%edx
 7bd:	0f 84 9d 00 00 00    	je     860 <malloc+0xc0>
 7c3:	8b 02                	mov    (%edx),%eax
 7c5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7c8:	39 cf                	cmp    %ecx,%edi
 7ca:	76 6c                	jbe    838 <malloc+0x98>
 7cc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 7d2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7d7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7da:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7e1:	eb 0e                	jmp    7f1 <malloc+0x51>
 7e3:	90                   	nop
 7e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7ea:	8b 48 04             	mov    0x4(%eax),%ecx
 7ed:	39 f9                	cmp    %edi,%ecx
 7ef:	73 47                	jae    838 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7f1:	39 05 00 0c 00 00    	cmp    %eax,0xc00
 7f7:	89 c2                	mov    %eax,%edx
 7f9:	75 ed                	jne    7e8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 7fb:	83 ec 0c             	sub    $0xc,%esp
 7fe:	56                   	push   %esi
 7ff:	e8 e6 fb ff ff       	call   3ea <sbrk>
  if(p == (char*)-1)
 804:	83 c4 10             	add    $0x10,%esp
 807:	83 f8 ff             	cmp    $0xffffffff,%eax
 80a:	74 1c                	je     828 <malloc+0x88>
  hp->s.size = nu;
 80c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 80f:	83 ec 0c             	sub    $0xc,%esp
 812:	83 c0 08             	add    $0x8,%eax
 815:	50                   	push   %eax
 816:	e8 f5 fe ff ff       	call   710 <free>
  return freep;
 81b:	8b 15 00 0c 00 00    	mov    0xc00,%edx
      if((p = morecore(nunits)) == 0)
 821:	83 c4 10             	add    $0x10,%esp
 824:	85 d2                	test   %edx,%edx
 826:	75 c0                	jne    7e8 <malloc+0x48>
        return 0;
  }
}
 828:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 82b:	31 c0                	xor    %eax,%eax
}
 82d:	5b                   	pop    %ebx
 82e:	5e                   	pop    %esi
 82f:	5f                   	pop    %edi
 830:	5d                   	pop    %ebp
 831:	c3                   	ret    
 832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 838:	39 cf                	cmp    %ecx,%edi
 83a:	74 54                	je     890 <malloc+0xf0>
        p->s.size -= nunits;
 83c:	29 f9                	sub    %edi,%ecx
 83e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 841:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 844:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 847:	89 15 00 0c 00 00    	mov    %edx,0xc00
}
 84d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 850:	83 c0 08             	add    $0x8,%eax
}
 853:	5b                   	pop    %ebx
 854:	5e                   	pop    %esi
 855:	5f                   	pop    %edi
 856:	5d                   	pop    %ebp
 857:	c3                   	ret    
 858:	90                   	nop
 859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 860:	c7 05 00 0c 00 00 04 	movl   $0xc04,0xc00
 867:	0c 00 00 
 86a:	c7 05 04 0c 00 00 04 	movl   $0xc04,0xc04
 871:	0c 00 00 
    base.s.size = 0;
 874:	b8 04 0c 00 00       	mov    $0xc04,%eax
 879:	c7 05 08 0c 00 00 00 	movl   $0x0,0xc08
 880:	00 00 00 
 883:	e9 44 ff ff ff       	jmp    7cc <malloc+0x2c>
 888:	90                   	nop
 889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 890:	8b 08                	mov    (%eax),%ecx
 892:	89 0a                	mov    %ecx,(%edx)
 894:	eb b1                	jmp    847 <malloc+0xa7>
