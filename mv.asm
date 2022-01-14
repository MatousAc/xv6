
user/_mv:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
// I copied cp.c and modified it to do mv
#include "kernel/types.h"
#include "user/user.h"
#include "kernel/fcntl.h"
#include "kernel/stat.h" // for the unlink f(x)
int main(int argc, char *argv[]){
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	81 ec 18 02 00 00    	sub    $0x218,%esp
    char buffer[512];
    // param czech
    if(argc > 3 || argc < 3){
  17:	83 39 03             	cmpl   $0x3,(%ecx)
int main(int argc, char *argv[]){
  1a:	8b 79 04             	mov    0x4(%ecx),%edi
    if(argc > 3 || argc < 3){
  1d:	74 13                	je     32 <main+0x32>
        fprintf(2, "incorrect number of arguments");
  1f:	51                   	push   %ecx
  20:	51                   	push   %ecx
  21:	68 88 08 00 00       	push   $0x888
  26:	6a 02                	push   $0x2
  28:	e8 93 06 00 00       	call   6c0 <fprintf>
        exit();
  2d:	e8 20 03 00 00       	call   352 <exit>
    }
    //check if source and destination can open
    int src = open(argv[1], O_RDONLY);
  32:	56                   	push   %esi
  33:	56                   	push   %esi
  34:	6a 00                	push   $0x0
  36:	ff 77 04             	pushl  0x4(%edi)
  39:	e8 54 03 00 00       	call   392 <open>
  3e:	89 c6                	mov    %eax,%esi
    int dest = open(argv[2], O_CREATE|O_RDWR);
  40:	58                   	pop    %eax
  41:	5a                   	pop    %edx
  42:	68 02 02 00 00       	push   $0x202
  47:	ff 77 08             	pushl  0x8(%edi)
  4a:	e8 43 03 00 00       	call   392 <open>
    if(src < 0){
  4f:	83 c4 10             	add    $0x10,%esp
  52:	85 f6                	test   %esi,%esi
    int dest = open(argv[2], O_CREATE|O_RDWR);
  54:	89 85 e4 fd ff ff    	mov    %eax,-0x21c(%ebp)
    if(src < 0){
  5a:	78 67                	js     c3 <main+0xc3>
        fprintf(2, "Cannot open file for moving: %s \n", argv[1]);
        exit();
    }
    if (dest < 0){
  5c:	83 bd e4 fd ff ff 00 	cmpl   $0x0,-0x21c(%ebp)
  63:	8d 9d e8 fd ff ff    	lea    -0x218(%ebp),%ebx
  69:	79 18                	jns    83 <main+0x83>
  6b:	eb 6b                	jmp    d8 <main+0xd8>
  6d:	8d 76 00             	lea    0x0(%esi),%esi
        exit();
    }
    // first we copy the file to the new destination
    int i;
    while((i = read(src, buffer, sizeof(buffer))) > 0){
        write(dest, buffer, i);
  70:	83 ec 04             	sub    $0x4,%esp
  73:	50                   	push   %eax
  74:	53                   	push   %ebx
  75:	ff b5 e4 fd ff ff    	pushl  -0x21c(%ebp)
  7b:	e8 f2 02 00 00       	call   372 <write>
  80:	83 c4 10             	add    $0x10,%esp
    while((i = read(src, buffer, sizeof(buffer))) > 0){
  83:	83 ec 04             	sub    $0x4,%esp
  86:	68 00 02 00 00       	push   $0x200
  8b:	53                   	push   %ebx
  8c:	56                   	push   %esi
  8d:	e8 d8 02 00 00       	call   36a <read>
  92:	83 c4 10             	add    $0x10,%esp
  95:	85 c0                	test   %eax,%eax
  97:	7f d7                	jg     70 <main+0x70>
    }
    close(src);
  99:	83 ec 0c             	sub    $0xc,%esp
  9c:	56                   	push   %esi
  9d:	e8 d8 02 00 00       	call   37a <close>
    close(dest);
  a2:	58                   	pop    %eax
  a3:	ff b5 e4 fd ff ff    	pushl  -0x21c(%ebp)
  a9:	e8 cc 02 00 00       	call   37a <close>
    // then we remove the original
    if (unlink(argv[1]) < 0)
  ae:	5a                   	pop    %edx
  af:	ff 77 04             	pushl  0x4(%edi)
  b2:	e8 eb 02 00 00       	call   3a2 <unlink>
  b7:	83 c4 10             	add    $0x10,%esp
  ba:	85 c0                	test   %eax,%eax
  bc:	78 2f                	js     ed <main+0xed>
      printf("Unable to move the file. Copy made instead.");
    exit();
  be:	e8 8f 02 00 00       	call   352 <exit>
        fprintf(2, "Cannot open file for moving: %s \n", argv[1]);
  c3:	53                   	push   %ebx
  c4:	ff 77 04             	pushl  0x4(%edi)
  c7:	68 a8 08 00 00       	push   $0x8a8
  cc:	6a 02                	push   $0x2
  ce:	e8 ed 05 00 00       	call   6c0 <fprintf>
        exit();
  d3:	e8 7a 02 00 00       	call   352 <exit>
        fprintf(2, "Cannot place file in destination: %s \n ", argv[2]);
  d8:	51                   	push   %ecx
  d9:	ff 77 08             	pushl  0x8(%edi)
  dc:	68 cc 08 00 00       	push   $0x8cc
  e1:	6a 02                	push   $0x2
  e3:	e8 d8 05 00 00       	call   6c0 <fprintf>
        exit();
  e8:	e8 65 02 00 00       	call   352 <exit>
      printf("Unable to move the file. Copy made instead.");
  ed:	83 ec 0c             	sub    $0xc,%esp
  f0:	68 f4 08 00 00       	push   $0x8f4
  f5:	e8 e6 05 00 00       	call   6e0 <printf>
  fa:	83 c4 10             	add    $0x10,%esp
  fd:	eb bf                	jmp    be <main+0xbe>
  ff:	90                   	nop

00000100 <strcpy>:
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	53                   	push   %ebx
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 10a:	89 c2                	mov    %eax,%edx
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 110:	83 c1 01             	add    $0x1,%ecx
 113:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 117:	83 c2 01             	add    $0x1,%edx
 11a:	84 db                	test   %bl,%bl
 11c:	88 5a ff             	mov    %bl,-0x1(%edx)
 11f:	75 ef                	jne    110 <strcpy+0x10>
 121:	5b                   	pop    %ebx
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    
 124:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 12a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000130 <strcmp>:
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	8b 55 08             	mov    0x8(%ebp),%edx
 137:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 13a:	0f b6 02             	movzbl (%edx),%eax
 13d:	0f b6 19             	movzbl (%ecx),%ebx
 140:	84 c0                	test   %al,%al
 142:	75 1c                	jne    160 <strcmp+0x30>
 144:	eb 2a                	jmp    170 <strcmp+0x40>
 146:	8d 76 00             	lea    0x0(%esi),%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 150:	83 c2 01             	add    $0x1,%edx
 153:	0f b6 02             	movzbl (%edx),%eax
 156:	83 c1 01             	add    $0x1,%ecx
 159:	0f b6 19             	movzbl (%ecx),%ebx
 15c:	84 c0                	test   %al,%al
 15e:	74 10                	je     170 <strcmp+0x40>
 160:	38 d8                	cmp    %bl,%al
 162:	74 ec                	je     150 <strcmp+0x20>
 164:	29 d8                	sub    %ebx,%eax
 166:	5b                   	pop    %ebx
 167:	5d                   	pop    %ebp
 168:	c3                   	ret    
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 170:	31 c0                	xor    %eax,%eax
 172:	29 d8                	sub    %ebx,%eax
 174:	5b                   	pop    %ebx
 175:	5d                   	pop    %ebp
 176:	c3                   	ret    
 177:	89 f6                	mov    %esi,%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000180 <strlen>:
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	8b 4d 08             	mov    0x8(%ebp),%ecx
 186:	80 39 00             	cmpb   $0x0,(%ecx)
 189:	74 15                	je     1a0 <strlen+0x20>
 18b:	31 d2                	xor    %edx,%edx
 18d:	8d 76 00             	lea    0x0(%esi),%esi
 190:	83 c2 01             	add    $0x1,%edx
 193:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 197:	89 d0                	mov    %edx,%eax
 199:	75 f5                	jne    190 <strlen+0x10>
 19b:	5d                   	pop    %ebp
 19c:	c3                   	ret    
 19d:	8d 76 00             	lea    0x0(%esi),%esi
 1a0:	31 c0                	xor    %eax,%eax
 1a2:	5d                   	pop    %ebp
 1a3:	c3                   	ret    
 1a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001b0 <memset>:
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	57                   	push   %edi
 1b4:	8b 55 08             	mov    0x8(%ebp),%edx
 1b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 1bd:	89 d7                	mov    %edx,%edi
 1bf:	fc                   	cld    
 1c0:	f3 aa                	rep stos %al,%es:(%edi)
 1c2:	89 d0                	mov    %edx,%eax
 1c4:	5f                   	pop    %edi
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    
 1c7:	89 f6                	mov    %esi,%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001d0 <strchr>:
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	53                   	push   %ebx
 1d4:	8b 45 08             	mov    0x8(%ebp),%eax
 1d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1da:	0f b6 10             	movzbl (%eax),%edx
 1dd:	84 d2                	test   %dl,%dl
 1df:	74 1d                	je     1fe <strchr+0x2e>
 1e1:	38 d3                	cmp    %dl,%bl
 1e3:	89 d9                	mov    %ebx,%ecx
 1e5:	75 0d                	jne    1f4 <strchr+0x24>
 1e7:	eb 17                	jmp    200 <strchr+0x30>
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1f0:	38 ca                	cmp    %cl,%dl
 1f2:	74 0c                	je     200 <strchr+0x30>
 1f4:	83 c0 01             	add    $0x1,%eax
 1f7:	0f b6 10             	movzbl (%eax),%edx
 1fa:	84 d2                	test   %dl,%dl
 1fc:	75 f2                	jne    1f0 <strchr+0x20>
 1fe:	31 c0                	xor    %eax,%eax
 200:	5b                   	pop    %ebx
 201:	5d                   	pop    %ebp
 202:	c3                   	ret    
 203:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <gets>:
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	57                   	push   %edi
 214:	56                   	push   %esi
 215:	53                   	push   %ebx
 216:	31 f6                	xor    %esi,%esi
 218:	89 f3                	mov    %esi,%ebx
 21a:	83 ec 1c             	sub    $0x1c,%esp
 21d:	8b 7d 08             	mov    0x8(%ebp),%edi
 220:	eb 2f                	jmp    251 <gets+0x41>
 222:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 228:	8d 45 e7             	lea    -0x19(%ebp),%eax
 22b:	83 ec 04             	sub    $0x4,%esp
 22e:	6a 01                	push   $0x1
 230:	50                   	push   %eax
 231:	6a 00                	push   $0x0
 233:	e8 32 01 00 00       	call   36a <read>
 238:	83 c4 10             	add    $0x10,%esp
 23b:	85 c0                	test   %eax,%eax
 23d:	7e 1c                	jle    25b <gets+0x4b>
 23f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 243:	83 c7 01             	add    $0x1,%edi
 246:	88 47 ff             	mov    %al,-0x1(%edi)
 249:	3c 0a                	cmp    $0xa,%al
 24b:	74 23                	je     270 <gets+0x60>
 24d:	3c 0d                	cmp    $0xd,%al
 24f:	74 1f                	je     270 <gets+0x60>
 251:	83 c3 01             	add    $0x1,%ebx
 254:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 257:	89 fe                	mov    %edi,%esi
 259:	7c cd                	jl     228 <gets+0x18>
 25b:	89 f3                	mov    %esi,%ebx
 25d:	8b 45 08             	mov    0x8(%ebp),%eax
 260:	c6 03 00             	movb   $0x0,(%ebx)
 263:	8d 65 f4             	lea    -0xc(%ebp),%esp
 266:	5b                   	pop    %ebx
 267:	5e                   	pop    %esi
 268:	5f                   	pop    %edi
 269:	5d                   	pop    %ebp
 26a:	c3                   	ret    
 26b:	90                   	nop
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 270:	8b 75 08             	mov    0x8(%ebp),%esi
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	01 de                	add    %ebx,%esi
 278:	89 f3                	mov    %esi,%ebx
 27a:	c6 03 00             	movb   $0x0,(%ebx)
 27d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 280:	5b                   	pop    %ebx
 281:	5e                   	pop    %esi
 282:	5f                   	pop    %edi
 283:	5d                   	pop    %ebp
 284:	c3                   	ret    
 285:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <stat>:
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
 295:	83 ec 08             	sub    $0x8,%esp
 298:	6a 00                	push   $0x0
 29a:	ff 75 08             	pushl  0x8(%ebp)
 29d:	e8 f0 00 00 00       	call   392 <open>
 2a2:	83 c4 10             	add    $0x10,%esp
 2a5:	85 c0                	test   %eax,%eax
 2a7:	78 27                	js     2d0 <stat+0x40>
 2a9:	83 ec 08             	sub    $0x8,%esp
 2ac:	ff 75 0c             	pushl  0xc(%ebp)
 2af:	89 c3                	mov    %eax,%ebx
 2b1:	50                   	push   %eax
 2b2:	e8 f3 00 00 00       	call   3aa <fstat>
 2b7:	89 1c 24             	mov    %ebx,(%esp)
 2ba:	89 c6                	mov    %eax,%esi
 2bc:	e8 b9 00 00 00       	call   37a <close>
 2c1:	83 c4 10             	add    $0x10,%esp
 2c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2c7:	89 f0                	mov    %esi,%eax
 2c9:	5b                   	pop    %ebx
 2ca:	5e                   	pop    %esi
 2cb:	5d                   	pop    %ebp
 2cc:	c3                   	ret    
 2cd:	8d 76 00             	lea    0x0(%esi),%esi
 2d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2d5:	eb ed                	jmp    2c4 <stat+0x34>
 2d7:	89 f6                	mov    %esi,%esi
 2d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002e0 <atoi>:
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	53                   	push   %ebx
 2e4:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2e7:	0f be 11             	movsbl (%ecx),%edx
 2ea:	8d 42 d0             	lea    -0x30(%edx),%eax
 2ed:	3c 09                	cmp    $0x9,%al
 2ef:	b8 00 00 00 00       	mov    $0x0,%eax
 2f4:	77 1f                	ja     315 <atoi+0x35>
 2f6:	8d 76 00             	lea    0x0(%esi),%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 300:	8d 04 80             	lea    (%eax,%eax,4),%eax
 303:	83 c1 01             	add    $0x1,%ecx
 306:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 30a:	0f be 11             	movsbl (%ecx),%edx
 30d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 310:	80 fb 09             	cmp    $0x9,%bl
 313:	76 eb                	jbe    300 <atoi+0x20>
 315:	5b                   	pop    %ebx
 316:	5d                   	pop    %ebp
 317:	c3                   	ret    
 318:	90                   	nop
 319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000320 <memmove>:
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	56                   	push   %esi
 324:	53                   	push   %ebx
 325:	8b 5d 10             	mov    0x10(%ebp),%ebx
 328:	8b 45 08             	mov    0x8(%ebp),%eax
 32b:	8b 75 0c             	mov    0xc(%ebp),%esi
 32e:	85 db                	test   %ebx,%ebx
 330:	7e 14                	jle    346 <memmove+0x26>
 332:	31 d2                	xor    %edx,%edx
 334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 338:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 33c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 33f:	83 c2 01             	add    $0x1,%edx
 342:	39 d3                	cmp    %edx,%ebx
 344:	75 f2                	jne    338 <memmove+0x18>
 346:	5b                   	pop    %ebx
 347:	5e                   	pop    %esi
 348:	5d                   	pop    %ebp
 349:	c3                   	ret    

0000034a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 34a:	b8 01 00 00 00       	mov    $0x1,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <exit>:
SYSCALL(exit)
 352:	b8 02 00 00 00       	mov    $0x2,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <wait>:
SYSCALL(wait)
 35a:	b8 03 00 00 00       	mov    $0x3,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <pipe>:
SYSCALL(pipe)
 362:	b8 04 00 00 00       	mov    $0x4,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <read>:
SYSCALL(read)
 36a:	b8 05 00 00 00       	mov    $0x5,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <write>:
SYSCALL(write)
 372:	b8 10 00 00 00       	mov    $0x10,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <close>:
SYSCALL(close)
 37a:	b8 15 00 00 00       	mov    $0x15,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <kill>:
SYSCALL(kill)
 382:	b8 06 00 00 00       	mov    $0x6,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <exec>:
SYSCALL(exec)
 38a:	b8 07 00 00 00       	mov    $0x7,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <open>:
SYSCALL(open)
 392:	b8 0f 00 00 00       	mov    $0xf,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <mknod>:
SYSCALL(mknod)
 39a:	b8 11 00 00 00       	mov    $0x11,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <unlink>:
SYSCALL(unlink)
 3a2:	b8 12 00 00 00       	mov    $0x12,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <fstat>:
SYSCALL(fstat)
 3aa:	b8 08 00 00 00       	mov    $0x8,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <link>:
SYSCALL(link)
 3b2:	b8 13 00 00 00       	mov    $0x13,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <mkdir>:
SYSCALL(mkdir)
 3ba:	b8 14 00 00 00       	mov    $0x14,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <chdir>:
SYSCALL(chdir)
 3c2:	b8 09 00 00 00       	mov    $0x9,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <dup>:
SYSCALL(dup)
 3ca:	b8 0a 00 00 00       	mov    $0xa,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <getpid>:
SYSCALL(getpid)
 3d2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <sbrk>:
SYSCALL(sbrk)
 3da:	b8 0c 00 00 00       	mov    $0xc,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <sleep>:
SYSCALL(sleep)
 3e2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <uptime>:
SYSCALL(uptime)
 3ea:	b8 0e 00 00 00       	mov    $0xe,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <cpuhalt>:
SYSCALL(cpuhalt)
 3f2:	b8 16 00 00 00       	mov    $0x16,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    
 3fa:	66 90                	xchg   %ax,%ax
 3fc:	66 90                	xchg   %ax,%ax
 3fe:	66 90                	xchg   %ax,%ax

00000400 <printint.constprop.1>:
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	89 d6                	mov    %edx,%esi
 408:	83 ec 3c             	sub    $0x3c,%esp
 40b:	85 c0                	test   %eax,%eax
 40d:	79 71                	jns    480 <printint.constprop.1+0x80>
 40f:	83 e1 01             	and    $0x1,%ecx
 412:	74 6c                	je     480 <printint.constprop.1+0x80>
 414:	f7 d8                	neg    %eax
 416:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 41d:	31 c9                	xor    %ecx,%ecx
 41f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 422:	eb 06                	jmp    42a <printint.constprop.1+0x2a>
 424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 428:	89 f9                	mov    %edi,%ecx
 42a:	31 d2                	xor    %edx,%edx
 42c:	8d 79 01             	lea    0x1(%ecx),%edi
 42f:	f7 f6                	div    %esi
 431:	0f b6 92 28 09 00 00 	movzbl 0x928(%edx),%edx
 438:	85 c0                	test   %eax,%eax
 43a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
 43d:	75 e9                	jne    428 <printint.constprop.1+0x28>
 43f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 442:	85 c0                	test   %eax,%eax
 444:	74 08                	je     44e <printint.constprop.1+0x4e>
 446:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 44b:	8d 79 02             	lea    0x2(%ecx),%edi
 44e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 458:	0f b6 06             	movzbl (%esi),%eax
 45b:	83 ec 04             	sub    $0x4,%esp
 45e:	83 ee 01             	sub    $0x1,%esi
 461:	6a 01                	push   $0x1
 463:	53                   	push   %ebx
 464:	6a 01                	push   $0x1
 466:	88 45 d7             	mov    %al,-0x29(%ebp)
 469:	e8 04 ff ff ff       	call   372 <write>
 46e:	83 c4 10             	add    $0x10,%esp
 471:	39 de                	cmp    %ebx,%esi
 473:	75 e3                	jne    458 <printint.constprop.1+0x58>
 475:	8d 65 f4             	lea    -0xc(%ebp),%esp
 478:	5b                   	pop    %ebx
 479:	5e                   	pop    %esi
 47a:	5f                   	pop    %edi
 47b:	5d                   	pop    %ebp
 47c:	c3                   	ret    
 47d:	8d 76 00             	lea    0x0(%esi),%esi
 480:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 487:	eb 94                	jmp    41d <printint.constprop.1+0x1d>
 489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000490 <vprintf.constprop.0>:
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	89 d6                	mov    %edx,%esi
 498:	83 ec 2c             	sub    $0x2c,%esp
 49b:	0f b6 10             	movzbl (%eax),%edx
 49e:	84 d2                	test   %dl,%dl
 4a0:	0f 84 cd 00 00 00    	je     573 <vprintf.constprop.0+0xe3>
 4a6:	8d 58 01             	lea    0x1(%eax),%ebx
 4a9:	31 ff                	xor    %edi,%edi
 4ab:	eb 31                	jmp    4de <vprintf.constprop.0+0x4e>
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
 4b0:	83 f8 25             	cmp    $0x25,%eax
 4b3:	0f 84 c7 00 00 00    	je     580 <vprintf.constprop.0+0xf0>
 4b9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4bc:	83 ec 04             	sub    $0x4,%esp
 4bf:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 4c2:	6a 01                	push   $0x1
 4c4:	50                   	push   %eax
 4c5:	6a 01                	push   $0x1
 4c7:	e8 a6 fe ff ff       	call   372 <write>
 4cc:	83 c4 10             	add    $0x10,%esp
 4cf:	83 c3 01             	add    $0x1,%ebx
 4d2:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4d6:	84 d2                	test   %dl,%dl
 4d8:	0f 84 95 00 00 00    	je     573 <vprintf.constprop.0+0xe3>
 4de:	85 ff                	test   %edi,%edi
 4e0:	0f b6 c2             	movzbl %dl,%eax
 4e3:	74 cb                	je     4b0 <vprintf.constprop.0+0x20>
 4e5:	83 ff 25             	cmp    $0x25,%edi
 4e8:	75 e5                	jne    4cf <vprintf.constprop.0+0x3f>
 4ea:	83 f8 64             	cmp    $0x64,%eax
 4ed:	8d 7e 04             	lea    0x4(%esi),%edi
 4f0:	b9 01 00 00 00       	mov    $0x1,%ecx
 4f5:	0f 84 9a 00 00 00    	je     595 <vprintf.constprop.0+0x105>
 4fb:	83 f8 6c             	cmp    $0x6c,%eax
 4fe:	0f 84 8c 00 00 00    	je     590 <vprintf.constprop.0+0x100>
 504:	83 f8 78             	cmp    $0x78,%eax
 507:	0f 84 a3 00 00 00    	je     5b0 <vprintf.constprop.0+0x120>
 50d:	83 f8 70             	cmp    $0x70,%eax
 510:	0f 84 ca 00 00 00    	je     5e0 <vprintf.constprop.0+0x150>
 516:	83 f8 73             	cmp    $0x73,%eax
 519:	0f 84 39 01 00 00    	je     658 <vprintf.constprop.0+0x1c8>
 51f:	83 f8 63             	cmp    $0x63,%eax
 522:	0f 84 68 01 00 00    	je     690 <vprintf.constprop.0+0x200>
 528:	83 f8 25             	cmp    $0x25,%eax
 52b:	0f 84 9f 00 00 00    	je     5d0 <vprintf.constprop.0+0x140>
 531:	8d 45 df             	lea    -0x21(%ebp),%eax
 534:	83 ec 04             	sub    $0x4,%esp
 537:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 53a:	6a 01                	push   $0x1
 53c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 540:	50                   	push   %eax
 541:	6a 01                	push   $0x1
 543:	e8 2a fe ff ff       	call   372 <write>
 548:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 54c:	83 c4 0c             	add    $0xc,%esp
 54f:	8d 45 e0             	lea    -0x20(%ebp),%eax
 552:	6a 01                	push   $0x1
 554:	88 55 e0             	mov    %dl,-0x20(%ebp)
 557:	50                   	push   %eax
 558:	6a 01                	push   $0x1
 55a:	83 c3 01             	add    $0x1,%ebx
 55d:	31 ff                	xor    %edi,%edi
 55f:	e8 0e fe ff ff       	call   372 <write>
 564:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 568:	83 c4 10             	add    $0x10,%esp
 56b:	84 d2                	test   %dl,%dl
 56d:	0f 85 6b ff ff ff    	jne    4de <vprintf.constprop.0+0x4e>
 573:	8d 65 f4             	lea    -0xc(%ebp),%esp
 576:	5b                   	pop    %ebx
 577:	5e                   	pop    %esi
 578:	5f                   	pop    %edi
 579:	5d                   	pop    %ebp
 57a:	c3                   	ret    
 57b:	90                   	nop
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 580:	bf 25 00 00 00       	mov    $0x25,%edi
 585:	e9 45 ff ff ff       	jmp    4cf <vprintf.constprop.0+0x3f>
 58a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 590:	8d 7e 04             	lea    0x4(%esi),%edi
 593:	31 c9                	xor    %ecx,%ecx
 595:	8b 06                	mov    (%esi),%eax
 597:	ba 0a 00 00 00       	mov    $0xa,%edx
 59c:	89 fe                	mov    %edi,%esi
 59e:	31 ff                	xor    %edi,%edi
 5a0:	e8 5b fe ff ff       	call   400 <printint.constprop.1>
 5a5:	e9 25 ff ff ff       	jmp    4cf <vprintf.constprop.0+0x3f>
 5aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5b0:	8b 06                	mov    (%esi),%eax
 5b2:	8d 7e 04             	lea    0x4(%esi),%edi
 5b5:	31 c9                	xor    %ecx,%ecx
 5b7:	ba 10 00 00 00       	mov    $0x10,%edx
 5bc:	89 fe                	mov    %edi,%esi
 5be:	31 ff                	xor    %edi,%edi
 5c0:	e8 3b fe ff ff       	call   400 <printint.constprop.1>
 5c5:	e9 05 ff ff ff       	jmp    4cf <vprintf.constprop.0+0x3f>
 5ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5d0:	83 ec 04             	sub    $0x4,%esp
 5d3:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 5d6:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 5d9:	6a 01                	push   $0x1
 5db:	e9 77 ff ff ff       	jmp    557 <vprintf.constprop.0+0xc7>
 5e0:	8d 46 04             	lea    0x4(%esi),%eax
 5e3:	83 ec 04             	sub    $0x4,%esp
 5e6:	8b 3e                	mov    (%esi),%edi
 5e8:	6a 01                	push   $0x1
 5ea:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 5ee:	be 08 00 00 00       	mov    $0x8,%esi
 5f3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5f6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5f9:	50                   	push   %eax
 5fa:	6a 01                	push   $0x1
 5fc:	e8 71 fd ff ff       	call   372 <write>
 601:	8d 45 e7             	lea    -0x19(%ebp),%eax
 604:	83 c4 0c             	add    $0xc,%esp
 607:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 60b:	6a 01                	push   $0x1
 60d:	50                   	push   %eax
 60e:	6a 01                	push   $0x1
 610:	e8 5d fd ff ff       	call   372 <write>
 615:	83 c4 10             	add    $0x10,%esp
 618:	90                   	nop
 619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 620:	89 f8                	mov    %edi,%eax
 622:	83 ec 04             	sub    $0x4,%esp
 625:	c1 e7 04             	shl    $0x4,%edi
 628:	c1 e8 1c             	shr    $0x1c,%eax
 62b:	6a 01                	push   $0x1
 62d:	0f b6 80 28 09 00 00 	movzbl 0x928(%eax),%eax
 634:	88 45 e5             	mov    %al,-0x1b(%ebp)
 637:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 63a:	50                   	push   %eax
 63b:	6a 01                	push   $0x1
 63d:	e8 30 fd ff ff       	call   372 <write>
 642:	83 c4 10             	add    $0x10,%esp
 645:	83 ee 01             	sub    $0x1,%esi
 648:	75 d6                	jne    620 <vprintf.constprop.0+0x190>
 64a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 64d:	31 ff                	xor    %edi,%edi
 64f:	e9 7b fe ff ff       	jmp    4cf <vprintf.constprop.0+0x3f>
 654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 658:	8b 3e                	mov    (%esi),%edi
 65a:	8d 46 04             	lea    0x4(%esi),%eax
 65d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 660:	85 ff                	test   %edi,%edi
 662:	74 50                	je     6b4 <vprintf.constprop.0+0x224>
 664:	0f b6 07             	movzbl (%edi),%eax
 667:	84 c0                	test   %al,%al
 669:	74 df                	je     64a <vprintf.constprop.0+0x1ba>
 66b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 66e:	66 90                	xchg   %ax,%ax
 670:	83 ec 04             	sub    $0x4,%esp
 673:	83 c7 01             	add    $0x1,%edi
 676:	88 45 e3             	mov    %al,-0x1d(%ebp)
 679:	6a 01                	push   $0x1
 67b:	56                   	push   %esi
 67c:	6a 01                	push   $0x1
 67e:	e8 ef fc ff ff       	call   372 <write>
 683:	0f b6 07             	movzbl (%edi),%eax
 686:	83 c4 10             	add    $0x10,%esp
 689:	84 c0                	test   %al,%al
 68b:	75 e3                	jne    670 <vprintf.constprop.0+0x1e0>
 68d:	eb bb                	jmp    64a <vprintf.constprop.0+0x1ba>
 68f:	90                   	nop
 690:	8b 06                	mov    (%esi),%eax
 692:	83 ec 04             	sub    $0x4,%esp
 695:	8d 7e 04             	lea    0x4(%esi),%edi
 698:	6a 01                	push   $0x1
 69a:	89 fe                	mov    %edi,%esi
 69c:	31 ff                	xor    %edi,%edi
 69e:	88 45 e2             	mov    %al,-0x1e(%ebp)
 6a1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6a4:	50                   	push   %eax
 6a5:	6a 01                	push   $0x1
 6a7:	e8 c6 fc ff ff       	call   372 <write>
 6ac:	83 c4 10             	add    $0x10,%esp
 6af:	e9 1b fe ff ff       	jmp    4cf <vprintf.constprop.0+0x3f>
 6b4:	bf 20 09 00 00       	mov    $0x920,%edi
 6b9:	b8 28 00 00 00       	mov    $0x28,%eax
 6be:	eb ab                	jmp    66b <vprintf.constprop.0+0x1db>

000006c0 <fprintf>:
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	83 ec 08             	sub    $0x8,%esp
 6c6:	8b 45 0c             	mov    0xc(%ebp),%eax
 6c9:	8d 55 10             	lea    0x10(%ebp),%edx
 6cc:	e8 bf fd ff ff       	call   490 <vprintf.constprop.0>
 6d1:	c9                   	leave  
 6d2:	c3                   	ret    
 6d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006e0 <printf>:
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	83 ec 08             	sub    $0x8,%esp
 6e6:	8b 45 08             	mov    0x8(%ebp),%eax
 6e9:	8d 55 0c             	lea    0xc(%ebp),%edx
 6ec:	e8 9f fd ff ff       	call   490 <vprintf.constprop.0>
 6f1:	c9                   	leave  
 6f2:	c3                   	ret    
 6f3:	66 90                	xchg   %ax,%ax
 6f5:	66 90                	xchg   %ax,%ax
 6f7:	66 90                	xchg   %ax,%ax
 6f9:	66 90                	xchg   %ax,%ax
 6fb:	66 90                	xchg   %ax,%ax
 6fd:	66 90                	xchg   %ax,%ax
 6ff:	90                   	nop

00000700 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 700:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 701:	a1 18 0c 00 00       	mov    0xc18,%eax
{
 706:	89 e5                	mov    %esp,%ebp
 708:	57                   	push   %edi
 709:	56                   	push   %esi
 70a:	53                   	push   %ebx
 70b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 70e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 718:	39 c8                	cmp    %ecx,%eax
 71a:	8b 10                	mov    (%eax),%edx
 71c:	73 32                	jae    750 <free+0x50>
 71e:	39 d1                	cmp    %edx,%ecx
 720:	72 04                	jb     726 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 722:	39 d0                	cmp    %edx,%eax
 724:	72 32                	jb     758 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 726:	8b 73 fc             	mov    -0x4(%ebx),%esi
 729:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 72c:	39 fa                	cmp    %edi,%edx
 72e:	74 30                	je     760 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 730:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 733:	8b 50 04             	mov    0x4(%eax),%edx
 736:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 739:	39 f1                	cmp    %esi,%ecx
 73b:	74 3a                	je     777 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 73d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 73f:	a3 18 0c 00 00       	mov    %eax,0xc18
}
 744:	5b                   	pop    %ebx
 745:	5e                   	pop    %esi
 746:	5f                   	pop    %edi
 747:	5d                   	pop    %ebp
 748:	c3                   	ret    
 749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 750:	39 d0                	cmp    %edx,%eax
 752:	72 04                	jb     758 <free+0x58>
 754:	39 d1                	cmp    %edx,%ecx
 756:	72 ce                	jb     726 <free+0x26>
{
 758:	89 d0                	mov    %edx,%eax
 75a:	eb bc                	jmp    718 <free+0x18>
 75c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 760:	03 72 04             	add    0x4(%edx),%esi
 763:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 766:	8b 10                	mov    (%eax),%edx
 768:	8b 12                	mov    (%edx),%edx
 76a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 76d:	8b 50 04             	mov    0x4(%eax),%edx
 770:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 773:	39 f1                	cmp    %esi,%ecx
 775:	75 c6                	jne    73d <free+0x3d>
    p->s.size += bp->s.size;
 777:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 77a:	a3 18 0c 00 00       	mov    %eax,0xc18
    p->s.size += bp->s.size;
 77f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 782:	8b 53 f8             	mov    -0x8(%ebx),%edx
 785:	89 10                	mov    %edx,(%eax)
}
 787:	5b                   	pop    %ebx
 788:	5e                   	pop    %esi
 789:	5f                   	pop    %edi
 78a:	5d                   	pop    %ebp
 78b:	c3                   	ret    
 78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000790 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	57                   	push   %edi
 794:	56                   	push   %esi
 795:	53                   	push   %ebx
 796:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 799:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 79c:	8b 15 18 0c 00 00    	mov    0xc18,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a2:	8d 78 07             	lea    0x7(%eax),%edi
 7a5:	c1 ef 03             	shr    $0x3,%edi
 7a8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7ab:	85 d2                	test   %edx,%edx
 7ad:	0f 84 9d 00 00 00    	je     850 <malloc+0xc0>
 7b3:	8b 02                	mov    (%edx),%eax
 7b5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7b8:	39 cf                	cmp    %ecx,%edi
 7ba:	76 6c                	jbe    828 <malloc+0x98>
 7bc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 7c2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7c7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7ca:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7d1:	eb 0e                	jmp    7e1 <malloc+0x51>
 7d3:	90                   	nop
 7d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7da:	8b 48 04             	mov    0x4(%eax),%ecx
 7dd:	39 f9                	cmp    %edi,%ecx
 7df:	73 47                	jae    828 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7e1:	39 05 18 0c 00 00    	cmp    %eax,0xc18
 7e7:	89 c2                	mov    %eax,%edx
 7e9:	75 ed                	jne    7d8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 7eb:	83 ec 0c             	sub    $0xc,%esp
 7ee:	56                   	push   %esi
 7ef:	e8 e6 fb ff ff       	call   3da <sbrk>
  if(p == (char*)-1)
 7f4:	83 c4 10             	add    $0x10,%esp
 7f7:	83 f8 ff             	cmp    $0xffffffff,%eax
 7fa:	74 1c                	je     818 <malloc+0x88>
  hp->s.size = nu;
 7fc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7ff:	83 ec 0c             	sub    $0xc,%esp
 802:	83 c0 08             	add    $0x8,%eax
 805:	50                   	push   %eax
 806:	e8 f5 fe ff ff       	call   700 <free>
  return freep;
 80b:	8b 15 18 0c 00 00    	mov    0xc18,%edx
      if((p = morecore(nunits)) == 0)
 811:	83 c4 10             	add    $0x10,%esp
 814:	85 d2                	test   %edx,%edx
 816:	75 c0                	jne    7d8 <malloc+0x48>
        return 0;
  }
}
 818:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 81b:	31 c0                	xor    %eax,%eax
}
 81d:	5b                   	pop    %ebx
 81e:	5e                   	pop    %esi
 81f:	5f                   	pop    %edi
 820:	5d                   	pop    %ebp
 821:	c3                   	ret    
 822:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 828:	39 cf                	cmp    %ecx,%edi
 82a:	74 54                	je     880 <malloc+0xf0>
        p->s.size -= nunits;
 82c:	29 f9                	sub    %edi,%ecx
 82e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 831:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 834:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 837:	89 15 18 0c 00 00    	mov    %edx,0xc18
}
 83d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 840:	83 c0 08             	add    $0x8,%eax
}
 843:	5b                   	pop    %ebx
 844:	5e                   	pop    %esi
 845:	5f                   	pop    %edi
 846:	5d                   	pop    %ebp
 847:	c3                   	ret    
 848:	90                   	nop
 849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 850:	c7 05 18 0c 00 00 1c 	movl   $0xc1c,0xc18
 857:	0c 00 00 
 85a:	c7 05 1c 0c 00 00 1c 	movl   $0xc1c,0xc1c
 861:	0c 00 00 
    base.s.size = 0;
 864:	b8 1c 0c 00 00       	mov    $0xc1c,%eax
 869:	c7 05 20 0c 00 00 00 	movl   $0x0,0xc20
 870:	00 00 00 
 873:	e9 44 ff ff ff       	jmp    7bc <malloc+0x2c>
 878:	90                   	nop
 879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 880:	8b 08                	mov    (%eax),%ecx
 882:	89 0a                	mov    %ecx,(%edx)
 884:	eb b1                	jmp    837 <malloc+0xa7>
