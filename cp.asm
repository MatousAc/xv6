
user/_cp:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "kernel/types.h"
#include "user/user.h"
#include "kernel/fcntl.h"
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
    // Make sure the usage is correct by first checking for correct number of perameters
    if(argc > 3 || argc < 3){
  17:	83 39 03             	cmpl   $0x3,(%ecx)
int main(int argc, char *argv[]){
  1a:	8b 51 04             	mov    0x4(%ecx),%edx
    if(argc > 3 || argc < 3){
  1d:	74 13                	je     32 <main+0x32>
        fprintf(2, "Not the correct usage of command cp");
  1f:	50                   	push   %eax
  20:	50                   	push   %eax
  21:	68 78 08 00 00       	push   $0x878
  26:	6a 02                	push   $0x2
  28:	e8 83 06 00 00       	call   6b0 <fprintf>
        exit();
  2d:	e8 10 03 00 00       	call   342 <exit>
        //OR CALL man cp
    }
    //check if source and destination can open
    int srcf = open(argv[1], O_RDONLY); //src file
  32:	53                   	push   %ebx
  33:	53                   	push   %ebx
  34:	6a 00                	push   $0x0
  36:	ff 72 04             	pushl  0x4(%edx)
  39:	89 95 e4 fd ff ff    	mov    %edx,-0x21c(%ebp)
  3f:	e8 3e 03 00 00       	call   382 <open>
    int destf = open(argv[2], O_CREATE|O_RDWR); // dest file
  44:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
    int srcf = open(argv[1], O_RDONLY); //src file
  4a:	89 c6                	mov    %eax,%esi
    int destf = open(argv[2], O_CREATE|O_RDWR); // dest file
  4c:	5f                   	pop    %edi
  4d:	58                   	pop    %eax
  4e:	68 02 02 00 00       	push   $0x202
  53:	ff 72 08             	pushl  0x8(%edx)
  56:	e8 27 03 00 00       	call   382 <open>
    if(srcf < 0){
  5b:	83 c4 10             	add    $0x10,%esp
  5e:	85 f6                	test   %esi,%esi
    int destf = open(argv[2], O_CREATE|O_RDWR); // dest file
  60:	89 c7                	mov    %eax,%edi
    if(srcf < 0){
  62:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
  68:	78 50                	js     ba <main+0xba>
        fprintf(2, "Cannot open source file: %s \n", argv[1]);
        exit();
    }
    if (destf < 0){
  6a:	85 c0                	test   %eax,%eax
  6c:	8d 9d e8 fd ff ff    	lea    -0x218(%ebp),%ebx
  72:	79 1a                	jns    8e <main+0x8e>
  74:	eb 59                	jmp    cf <main+0xcf>
  76:	8d 76 00             	lea    0x0(%esi),%esi
  79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        fprintf(2, "Cannot open / Read or write destination file: %s \n ", argv[2]);
        exit();
    }
    int i;
    while((i = read(srcf, buffer, sizeof(buffer))) > 0){
        write(destf, buffer, i);
  80:	83 ec 04             	sub    $0x4,%esp
  83:	50                   	push   %eax
  84:	53                   	push   %ebx
  85:	57                   	push   %edi
  86:	e8 d7 02 00 00       	call   362 <write>
  8b:	83 c4 10             	add    $0x10,%esp
    while((i = read(srcf, buffer, sizeof(buffer))) > 0){
  8e:	83 ec 04             	sub    $0x4,%esp
  91:	68 00 02 00 00       	push   $0x200
  96:	53                   	push   %ebx
  97:	56                   	push   %esi
  98:	e8 bd 02 00 00       	call   35a <read>
  9d:	83 c4 10             	add    $0x10,%esp
  a0:	85 c0                	test   %eax,%eax
  a2:	7f dc                	jg     80 <main+0x80>
    }
    close(srcf);
  a4:	83 ec 0c             	sub    $0xc,%esp
  a7:	56                   	push   %esi
  a8:	e8 bd 02 00 00       	call   36a <close>
    close(destf);
  ad:	89 3c 24             	mov    %edi,(%esp)
  b0:	e8 b5 02 00 00       	call   36a <close>
    exit();
  b5:	e8 88 02 00 00       	call   342 <exit>
        fprintf(2, "Cannot open source file: %s \n", argv[1]);
  ba:	51                   	push   %ecx
  bb:	ff 72 04             	pushl  0x4(%edx)
  be:	68 d0 08 00 00       	push   $0x8d0
  c3:	6a 02                	push   $0x2
  c5:	e8 e6 05 00 00       	call   6b0 <fprintf>
        exit();
  ca:	e8 73 02 00 00       	call   342 <exit>
        fprintf(2, "Cannot open / Read or write destination file: %s \n ", argv[2]);
  cf:	50                   	push   %eax
  d0:	ff 72 08             	pushl  0x8(%edx)
  d3:	68 9c 08 00 00       	push   $0x89c
  d8:	6a 02                	push   $0x2
  da:	e8 d1 05 00 00       	call   6b0 <fprintf>
        exit();
  df:	e8 5e 02 00 00       	call   342 <exit>
  e4:	66 90                	xchg   %ax,%ax
  e6:	66 90                	xchg   %ax,%ax
  e8:	66 90                	xchg   %ax,%ax
  ea:	66 90                	xchg   %ax,%ax
  ec:	66 90                	xchg   %ax,%ax
  ee:	66 90                	xchg   %ax,%ax

000000f0 <strcpy>:
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	53                   	push   %ebx
  f4:	8b 45 08             	mov    0x8(%ebp),%eax
  f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  fa:	89 c2                	mov    %eax,%edx
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 100:	83 c1 01             	add    $0x1,%ecx
 103:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 107:	83 c2 01             	add    $0x1,%edx
 10a:	84 db                	test   %bl,%bl
 10c:	88 5a ff             	mov    %bl,-0x1(%edx)
 10f:	75 ef                	jne    100 <strcpy+0x10>
 111:	5b                   	pop    %ebx
 112:	5d                   	pop    %ebp
 113:	c3                   	ret    
 114:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 11a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000120 <strcmp>:
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	53                   	push   %ebx
 124:	8b 55 08             	mov    0x8(%ebp),%edx
 127:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 12a:	0f b6 02             	movzbl (%edx),%eax
 12d:	0f b6 19             	movzbl (%ecx),%ebx
 130:	84 c0                	test   %al,%al
 132:	75 1c                	jne    150 <strcmp+0x30>
 134:	eb 2a                	jmp    160 <strcmp+0x40>
 136:	8d 76 00             	lea    0x0(%esi),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 140:	83 c2 01             	add    $0x1,%edx
 143:	0f b6 02             	movzbl (%edx),%eax
 146:	83 c1 01             	add    $0x1,%ecx
 149:	0f b6 19             	movzbl (%ecx),%ebx
 14c:	84 c0                	test   %al,%al
 14e:	74 10                	je     160 <strcmp+0x40>
 150:	38 d8                	cmp    %bl,%al
 152:	74 ec                	je     140 <strcmp+0x20>
 154:	29 d8                	sub    %ebx,%eax
 156:	5b                   	pop    %ebx
 157:	5d                   	pop    %ebp
 158:	c3                   	ret    
 159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 160:	31 c0                	xor    %eax,%eax
 162:	29 d8                	sub    %ebx,%eax
 164:	5b                   	pop    %ebx
 165:	5d                   	pop    %ebp
 166:	c3                   	ret    
 167:	89 f6                	mov    %esi,%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <strlen>:
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 4d 08             	mov    0x8(%ebp),%ecx
 176:	80 39 00             	cmpb   $0x0,(%ecx)
 179:	74 15                	je     190 <strlen+0x20>
 17b:	31 d2                	xor    %edx,%edx
 17d:	8d 76 00             	lea    0x0(%esi),%esi
 180:	83 c2 01             	add    $0x1,%edx
 183:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 187:	89 d0                	mov    %edx,%eax
 189:	75 f5                	jne    180 <strlen+0x10>
 18b:	5d                   	pop    %ebp
 18c:	c3                   	ret    
 18d:	8d 76 00             	lea    0x0(%esi),%esi
 190:	31 c0                	xor    %eax,%eax
 192:	5d                   	pop    %ebp
 193:	c3                   	ret    
 194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 19a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001a0 <memset>:
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	8b 55 08             	mov    0x8(%ebp),%edx
 1a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ad:	89 d7                	mov    %edx,%edi
 1af:	fc                   	cld    
 1b0:	f3 aa                	rep stos %al,%es:(%edi)
 1b2:	89 d0                	mov    %edx,%eax
 1b4:	5f                   	pop    %edi
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	89 f6                	mov    %esi,%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <strchr>:
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	53                   	push   %ebx
 1c4:	8b 45 08             	mov    0x8(%ebp),%eax
 1c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1ca:	0f b6 10             	movzbl (%eax),%edx
 1cd:	84 d2                	test   %dl,%dl
 1cf:	74 1d                	je     1ee <strchr+0x2e>
 1d1:	38 d3                	cmp    %dl,%bl
 1d3:	89 d9                	mov    %ebx,%ecx
 1d5:	75 0d                	jne    1e4 <strchr+0x24>
 1d7:	eb 17                	jmp    1f0 <strchr+0x30>
 1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1e0:	38 ca                	cmp    %cl,%dl
 1e2:	74 0c                	je     1f0 <strchr+0x30>
 1e4:	83 c0 01             	add    $0x1,%eax
 1e7:	0f b6 10             	movzbl (%eax),%edx
 1ea:	84 d2                	test   %dl,%dl
 1ec:	75 f2                	jne    1e0 <strchr+0x20>
 1ee:	31 c0                	xor    %eax,%eax
 1f0:	5b                   	pop    %ebx
 1f1:	5d                   	pop    %ebp
 1f2:	c3                   	ret    
 1f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <gets>:
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
 204:	56                   	push   %esi
 205:	53                   	push   %ebx
 206:	31 f6                	xor    %esi,%esi
 208:	89 f3                	mov    %esi,%ebx
 20a:	83 ec 1c             	sub    $0x1c,%esp
 20d:	8b 7d 08             	mov    0x8(%ebp),%edi
 210:	eb 2f                	jmp    241 <gets+0x41>
 212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 218:	8d 45 e7             	lea    -0x19(%ebp),%eax
 21b:	83 ec 04             	sub    $0x4,%esp
 21e:	6a 01                	push   $0x1
 220:	50                   	push   %eax
 221:	6a 00                	push   $0x0
 223:	e8 32 01 00 00       	call   35a <read>
 228:	83 c4 10             	add    $0x10,%esp
 22b:	85 c0                	test   %eax,%eax
 22d:	7e 1c                	jle    24b <gets+0x4b>
 22f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 233:	83 c7 01             	add    $0x1,%edi
 236:	88 47 ff             	mov    %al,-0x1(%edi)
 239:	3c 0a                	cmp    $0xa,%al
 23b:	74 23                	je     260 <gets+0x60>
 23d:	3c 0d                	cmp    $0xd,%al
 23f:	74 1f                	je     260 <gets+0x60>
 241:	83 c3 01             	add    $0x1,%ebx
 244:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 247:	89 fe                	mov    %edi,%esi
 249:	7c cd                	jl     218 <gets+0x18>
 24b:	89 f3                	mov    %esi,%ebx
 24d:	8b 45 08             	mov    0x8(%ebp),%eax
 250:	c6 03 00             	movb   $0x0,(%ebx)
 253:	8d 65 f4             	lea    -0xc(%ebp),%esp
 256:	5b                   	pop    %ebx
 257:	5e                   	pop    %esi
 258:	5f                   	pop    %edi
 259:	5d                   	pop    %ebp
 25a:	c3                   	ret    
 25b:	90                   	nop
 25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 260:	8b 75 08             	mov    0x8(%ebp),%esi
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	01 de                	add    %ebx,%esi
 268:	89 f3                	mov    %esi,%ebx
 26a:	c6 03 00             	movb   $0x0,(%ebx)
 26d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 270:	5b                   	pop    %ebx
 271:	5e                   	pop    %esi
 272:	5f                   	pop    %edi
 273:	5d                   	pop    %ebp
 274:	c3                   	ret    
 275:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000280 <stat>:
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	53                   	push   %ebx
 285:	83 ec 08             	sub    $0x8,%esp
 288:	6a 00                	push   $0x0
 28a:	ff 75 08             	pushl  0x8(%ebp)
 28d:	e8 f0 00 00 00       	call   382 <open>
 292:	83 c4 10             	add    $0x10,%esp
 295:	85 c0                	test   %eax,%eax
 297:	78 27                	js     2c0 <stat+0x40>
 299:	83 ec 08             	sub    $0x8,%esp
 29c:	ff 75 0c             	pushl  0xc(%ebp)
 29f:	89 c3                	mov    %eax,%ebx
 2a1:	50                   	push   %eax
 2a2:	e8 f3 00 00 00       	call   39a <fstat>
 2a7:	89 1c 24             	mov    %ebx,(%esp)
 2aa:	89 c6                	mov    %eax,%esi
 2ac:	e8 b9 00 00 00       	call   36a <close>
 2b1:	83 c4 10             	add    $0x10,%esp
 2b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2b7:	89 f0                	mov    %esi,%eax
 2b9:	5b                   	pop    %ebx
 2ba:	5e                   	pop    %esi
 2bb:	5d                   	pop    %ebp
 2bc:	c3                   	ret    
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
 2c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2c5:	eb ed                	jmp    2b4 <stat+0x34>
 2c7:	89 f6                	mov    %esi,%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <atoi>:
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	53                   	push   %ebx
 2d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2d7:	0f be 11             	movsbl (%ecx),%edx
 2da:	8d 42 d0             	lea    -0x30(%edx),%eax
 2dd:	3c 09                	cmp    $0x9,%al
 2df:	b8 00 00 00 00       	mov    $0x0,%eax
 2e4:	77 1f                	ja     305 <atoi+0x35>
 2e6:	8d 76 00             	lea    0x0(%esi),%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 2f0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2f3:	83 c1 01             	add    $0x1,%ecx
 2f6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 2fa:	0f be 11             	movsbl (%ecx),%edx
 2fd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 300:	80 fb 09             	cmp    $0x9,%bl
 303:	76 eb                	jbe    2f0 <atoi+0x20>
 305:	5b                   	pop    %ebx
 306:	5d                   	pop    %ebp
 307:	c3                   	ret    
 308:	90                   	nop
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000310 <memmove>:
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	56                   	push   %esi
 314:	53                   	push   %ebx
 315:	8b 5d 10             	mov    0x10(%ebp),%ebx
 318:	8b 45 08             	mov    0x8(%ebp),%eax
 31b:	8b 75 0c             	mov    0xc(%ebp),%esi
 31e:	85 db                	test   %ebx,%ebx
 320:	7e 14                	jle    336 <memmove+0x26>
 322:	31 d2                	xor    %edx,%edx
 324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 328:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 32c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 32f:	83 c2 01             	add    $0x1,%edx
 332:	39 d3                	cmp    %edx,%ebx
 334:	75 f2                	jne    328 <memmove+0x18>
 336:	5b                   	pop    %ebx
 337:	5e                   	pop    %esi
 338:	5d                   	pop    %ebp
 339:	c3                   	ret    

0000033a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 33a:	b8 01 00 00 00       	mov    $0x1,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <exit>:
SYSCALL(exit)
 342:	b8 02 00 00 00       	mov    $0x2,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <wait>:
SYSCALL(wait)
 34a:	b8 03 00 00 00       	mov    $0x3,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <pipe>:
SYSCALL(pipe)
 352:	b8 04 00 00 00       	mov    $0x4,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <read>:
SYSCALL(read)
 35a:	b8 05 00 00 00       	mov    $0x5,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <write>:
SYSCALL(write)
 362:	b8 10 00 00 00       	mov    $0x10,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <close>:
SYSCALL(close)
 36a:	b8 15 00 00 00       	mov    $0x15,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <kill>:
SYSCALL(kill)
 372:	b8 06 00 00 00       	mov    $0x6,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <exec>:
SYSCALL(exec)
 37a:	b8 07 00 00 00       	mov    $0x7,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <open>:
SYSCALL(open)
 382:	b8 0f 00 00 00       	mov    $0xf,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <mknod>:
SYSCALL(mknod)
 38a:	b8 11 00 00 00       	mov    $0x11,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <unlink>:
SYSCALL(unlink)
 392:	b8 12 00 00 00       	mov    $0x12,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <fstat>:
SYSCALL(fstat)
 39a:	b8 08 00 00 00       	mov    $0x8,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <link>:
SYSCALL(link)
 3a2:	b8 13 00 00 00       	mov    $0x13,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <mkdir>:
SYSCALL(mkdir)
 3aa:	b8 14 00 00 00       	mov    $0x14,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <chdir>:
SYSCALL(chdir)
 3b2:	b8 09 00 00 00       	mov    $0x9,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <dup>:
SYSCALL(dup)
 3ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <getpid>:
SYSCALL(getpid)
 3c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <sbrk>:
SYSCALL(sbrk)
 3ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <sleep>:
SYSCALL(sleep)
 3d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <uptime>:
SYSCALL(uptime)
 3da:	b8 0e 00 00 00       	mov    $0xe,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <cpuhalt>:
SYSCALL(cpuhalt)
 3e2:	b8 16 00 00 00       	mov    $0x16,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    
 3ea:	66 90                	xchg   %ax,%ax
 3ec:	66 90                	xchg   %ax,%ax
 3ee:	66 90                	xchg   %ax,%ax

000003f0 <printint.constprop.1>:
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
 3f6:	89 d6                	mov    %edx,%esi
 3f8:	83 ec 3c             	sub    $0x3c,%esp
 3fb:	85 c0                	test   %eax,%eax
 3fd:	79 71                	jns    470 <printint.constprop.1+0x80>
 3ff:	83 e1 01             	and    $0x1,%ecx
 402:	74 6c                	je     470 <printint.constprop.1+0x80>
 404:	f7 d8                	neg    %eax
 406:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 40d:	31 c9                	xor    %ecx,%ecx
 40f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 412:	eb 06                	jmp    41a <printint.constprop.1+0x2a>
 414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 418:	89 f9                	mov    %edi,%ecx
 41a:	31 d2                	xor    %edx,%edx
 41c:	8d 79 01             	lea    0x1(%ecx),%edi
 41f:	f7 f6                	div    %esi
 421:	0f b6 92 f8 08 00 00 	movzbl 0x8f8(%edx),%edx
 428:	85 c0                	test   %eax,%eax
 42a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
 42d:	75 e9                	jne    418 <printint.constprop.1+0x28>
 42f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 432:	85 c0                	test   %eax,%eax
 434:	74 08                	je     43e <printint.constprop.1+0x4e>
 436:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 43b:	8d 79 02             	lea    0x2(%ecx),%edi
 43e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 442:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 448:	0f b6 06             	movzbl (%esi),%eax
 44b:	83 ec 04             	sub    $0x4,%esp
 44e:	83 ee 01             	sub    $0x1,%esi
 451:	6a 01                	push   $0x1
 453:	53                   	push   %ebx
 454:	6a 01                	push   $0x1
 456:	88 45 d7             	mov    %al,-0x29(%ebp)
 459:	e8 04 ff ff ff       	call   362 <write>
 45e:	83 c4 10             	add    $0x10,%esp
 461:	39 de                	cmp    %ebx,%esi
 463:	75 e3                	jne    448 <printint.constprop.1+0x58>
 465:	8d 65 f4             	lea    -0xc(%ebp),%esp
 468:	5b                   	pop    %ebx
 469:	5e                   	pop    %esi
 46a:	5f                   	pop    %edi
 46b:	5d                   	pop    %ebp
 46c:	c3                   	ret    
 46d:	8d 76 00             	lea    0x0(%esi),%esi
 470:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 477:	eb 94                	jmp    40d <printint.constprop.1+0x1d>
 479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000480 <vprintf.constprop.0>:
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	89 d6                	mov    %edx,%esi
 488:	83 ec 2c             	sub    $0x2c,%esp
 48b:	0f b6 10             	movzbl (%eax),%edx
 48e:	84 d2                	test   %dl,%dl
 490:	0f 84 cd 00 00 00    	je     563 <vprintf.constprop.0+0xe3>
 496:	8d 58 01             	lea    0x1(%eax),%ebx
 499:	31 ff                	xor    %edi,%edi
 49b:	eb 31                	jmp    4ce <vprintf.constprop.0+0x4e>
 49d:	8d 76 00             	lea    0x0(%esi),%esi
 4a0:	83 f8 25             	cmp    $0x25,%eax
 4a3:	0f 84 c7 00 00 00    	je     570 <vprintf.constprop.0+0xf0>
 4a9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4ac:	83 ec 04             	sub    $0x4,%esp
 4af:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 4b2:	6a 01                	push   $0x1
 4b4:	50                   	push   %eax
 4b5:	6a 01                	push   $0x1
 4b7:	e8 a6 fe ff ff       	call   362 <write>
 4bc:	83 c4 10             	add    $0x10,%esp
 4bf:	83 c3 01             	add    $0x1,%ebx
 4c2:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4c6:	84 d2                	test   %dl,%dl
 4c8:	0f 84 95 00 00 00    	je     563 <vprintf.constprop.0+0xe3>
 4ce:	85 ff                	test   %edi,%edi
 4d0:	0f b6 c2             	movzbl %dl,%eax
 4d3:	74 cb                	je     4a0 <vprintf.constprop.0+0x20>
 4d5:	83 ff 25             	cmp    $0x25,%edi
 4d8:	75 e5                	jne    4bf <vprintf.constprop.0+0x3f>
 4da:	83 f8 64             	cmp    $0x64,%eax
 4dd:	8d 7e 04             	lea    0x4(%esi),%edi
 4e0:	b9 01 00 00 00       	mov    $0x1,%ecx
 4e5:	0f 84 9a 00 00 00    	je     585 <vprintf.constprop.0+0x105>
 4eb:	83 f8 6c             	cmp    $0x6c,%eax
 4ee:	0f 84 8c 00 00 00    	je     580 <vprintf.constprop.0+0x100>
 4f4:	83 f8 78             	cmp    $0x78,%eax
 4f7:	0f 84 a3 00 00 00    	je     5a0 <vprintf.constprop.0+0x120>
 4fd:	83 f8 70             	cmp    $0x70,%eax
 500:	0f 84 ca 00 00 00    	je     5d0 <vprintf.constprop.0+0x150>
 506:	83 f8 73             	cmp    $0x73,%eax
 509:	0f 84 39 01 00 00    	je     648 <vprintf.constprop.0+0x1c8>
 50f:	83 f8 63             	cmp    $0x63,%eax
 512:	0f 84 68 01 00 00    	je     680 <vprintf.constprop.0+0x200>
 518:	83 f8 25             	cmp    $0x25,%eax
 51b:	0f 84 9f 00 00 00    	je     5c0 <vprintf.constprop.0+0x140>
 521:	8d 45 df             	lea    -0x21(%ebp),%eax
 524:	83 ec 04             	sub    $0x4,%esp
 527:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 52a:	6a 01                	push   $0x1
 52c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 530:	50                   	push   %eax
 531:	6a 01                	push   $0x1
 533:	e8 2a fe ff ff       	call   362 <write>
 538:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 53c:	83 c4 0c             	add    $0xc,%esp
 53f:	8d 45 e0             	lea    -0x20(%ebp),%eax
 542:	6a 01                	push   $0x1
 544:	88 55 e0             	mov    %dl,-0x20(%ebp)
 547:	50                   	push   %eax
 548:	6a 01                	push   $0x1
 54a:	83 c3 01             	add    $0x1,%ebx
 54d:	31 ff                	xor    %edi,%edi
 54f:	e8 0e fe ff ff       	call   362 <write>
 554:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 558:	83 c4 10             	add    $0x10,%esp
 55b:	84 d2                	test   %dl,%dl
 55d:	0f 85 6b ff ff ff    	jne    4ce <vprintf.constprop.0+0x4e>
 563:	8d 65 f4             	lea    -0xc(%ebp),%esp
 566:	5b                   	pop    %ebx
 567:	5e                   	pop    %esi
 568:	5f                   	pop    %edi
 569:	5d                   	pop    %ebp
 56a:	c3                   	ret    
 56b:	90                   	nop
 56c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 570:	bf 25 00 00 00       	mov    $0x25,%edi
 575:	e9 45 ff ff ff       	jmp    4bf <vprintf.constprop.0+0x3f>
 57a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 580:	8d 7e 04             	lea    0x4(%esi),%edi
 583:	31 c9                	xor    %ecx,%ecx
 585:	8b 06                	mov    (%esi),%eax
 587:	ba 0a 00 00 00       	mov    $0xa,%edx
 58c:	89 fe                	mov    %edi,%esi
 58e:	31 ff                	xor    %edi,%edi
 590:	e8 5b fe ff ff       	call   3f0 <printint.constprop.1>
 595:	e9 25 ff ff ff       	jmp    4bf <vprintf.constprop.0+0x3f>
 59a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5a0:	8b 06                	mov    (%esi),%eax
 5a2:	8d 7e 04             	lea    0x4(%esi),%edi
 5a5:	31 c9                	xor    %ecx,%ecx
 5a7:	ba 10 00 00 00       	mov    $0x10,%edx
 5ac:	89 fe                	mov    %edi,%esi
 5ae:	31 ff                	xor    %edi,%edi
 5b0:	e8 3b fe ff ff       	call   3f0 <printint.constprop.1>
 5b5:	e9 05 ff ff ff       	jmp    4bf <vprintf.constprop.0+0x3f>
 5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5c0:	83 ec 04             	sub    $0x4,%esp
 5c3:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 5c6:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 5c9:	6a 01                	push   $0x1
 5cb:	e9 77 ff ff ff       	jmp    547 <vprintf.constprop.0+0xc7>
 5d0:	8d 46 04             	lea    0x4(%esi),%eax
 5d3:	83 ec 04             	sub    $0x4,%esp
 5d6:	8b 3e                	mov    (%esi),%edi
 5d8:	6a 01                	push   $0x1
 5da:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 5de:	be 08 00 00 00       	mov    $0x8,%esi
 5e3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5e6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5e9:	50                   	push   %eax
 5ea:	6a 01                	push   $0x1
 5ec:	e8 71 fd ff ff       	call   362 <write>
 5f1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5f4:	83 c4 0c             	add    $0xc,%esp
 5f7:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 5fb:	6a 01                	push   $0x1
 5fd:	50                   	push   %eax
 5fe:	6a 01                	push   $0x1
 600:	e8 5d fd ff ff       	call   362 <write>
 605:	83 c4 10             	add    $0x10,%esp
 608:	90                   	nop
 609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 610:	89 f8                	mov    %edi,%eax
 612:	83 ec 04             	sub    $0x4,%esp
 615:	c1 e7 04             	shl    $0x4,%edi
 618:	c1 e8 1c             	shr    $0x1c,%eax
 61b:	6a 01                	push   $0x1
 61d:	0f b6 80 f8 08 00 00 	movzbl 0x8f8(%eax),%eax
 624:	88 45 e5             	mov    %al,-0x1b(%ebp)
 627:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 62a:	50                   	push   %eax
 62b:	6a 01                	push   $0x1
 62d:	e8 30 fd ff ff       	call   362 <write>
 632:	83 c4 10             	add    $0x10,%esp
 635:	83 ee 01             	sub    $0x1,%esi
 638:	75 d6                	jne    610 <vprintf.constprop.0+0x190>
 63a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 63d:	31 ff                	xor    %edi,%edi
 63f:	e9 7b fe ff ff       	jmp    4bf <vprintf.constprop.0+0x3f>
 644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 648:	8b 3e                	mov    (%esi),%edi
 64a:	8d 46 04             	lea    0x4(%esi),%eax
 64d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 650:	85 ff                	test   %edi,%edi
 652:	74 50                	je     6a4 <vprintf.constprop.0+0x224>
 654:	0f b6 07             	movzbl (%edi),%eax
 657:	84 c0                	test   %al,%al
 659:	74 df                	je     63a <vprintf.constprop.0+0x1ba>
 65b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 65e:	66 90                	xchg   %ax,%ax
 660:	83 ec 04             	sub    $0x4,%esp
 663:	83 c7 01             	add    $0x1,%edi
 666:	88 45 e3             	mov    %al,-0x1d(%ebp)
 669:	6a 01                	push   $0x1
 66b:	56                   	push   %esi
 66c:	6a 01                	push   $0x1
 66e:	e8 ef fc ff ff       	call   362 <write>
 673:	0f b6 07             	movzbl (%edi),%eax
 676:	83 c4 10             	add    $0x10,%esp
 679:	84 c0                	test   %al,%al
 67b:	75 e3                	jne    660 <vprintf.constprop.0+0x1e0>
 67d:	eb bb                	jmp    63a <vprintf.constprop.0+0x1ba>
 67f:	90                   	nop
 680:	8b 06                	mov    (%esi),%eax
 682:	83 ec 04             	sub    $0x4,%esp
 685:	8d 7e 04             	lea    0x4(%esi),%edi
 688:	6a 01                	push   $0x1
 68a:	89 fe                	mov    %edi,%esi
 68c:	31 ff                	xor    %edi,%edi
 68e:	88 45 e2             	mov    %al,-0x1e(%ebp)
 691:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 694:	50                   	push   %eax
 695:	6a 01                	push   $0x1
 697:	e8 c6 fc ff ff       	call   362 <write>
 69c:	83 c4 10             	add    $0x10,%esp
 69f:	e9 1b fe ff ff       	jmp    4bf <vprintf.constprop.0+0x3f>
 6a4:	bf ee 08 00 00       	mov    $0x8ee,%edi
 6a9:	b8 28 00 00 00       	mov    $0x28,%eax
 6ae:	eb ab                	jmp    65b <vprintf.constprop.0+0x1db>

000006b0 <fprintf>:
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	83 ec 08             	sub    $0x8,%esp
 6b6:	8b 45 0c             	mov    0xc(%ebp),%eax
 6b9:	8d 55 10             	lea    0x10(%ebp),%edx
 6bc:	e8 bf fd ff ff       	call   480 <vprintf.constprop.0>
 6c1:	c9                   	leave  
 6c2:	c3                   	ret    
 6c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006d0 <printf>:
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	83 ec 08             	sub    $0x8,%esp
 6d6:	8b 45 08             	mov    0x8(%ebp),%eax
 6d9:	8d 55 0c             	lea    0xc(%ebp),%edx
 6dc:	e8 9f fd ff ff       	call   480 <vprintf.constprop.0>
 6e1:	c9                   	leave  
 6e2:	c3                   	ret    
 6e3:	66 90                	xchg   %ax,%ax
 6e5:	66 90                	xchg   %ax,%ax
 6e7:	66 90                	xchg   %ax,%ax
 6e9:	66 90                	xchg   %ax,%ax
 6eb:	66 90                	xchg   %ax,%ax
 6ed:	66 90                	xchg   %ax,%ax
 6ef:	90                   	nop

000006f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f1:	a1 e8 0b 00 00       	mov    0xbe8,%eax
{
 6f6:	89 e5                	mov    %esp,%ebp
 6f8:	57                   	push   %edi
 6f9:	56                   	push   %esi
 6fa:	53                   	push   %ebx
 6fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6fe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 708:	39 c8                	cmp    %ecx,%eax
 70a:	8b 10                	mov    (%eax),%edx
 70c:	73 32                	jae    740 <free+0x50>
 70e:	39 d1                	cmp    %edx,%ecx
 710:	72 04                	jb     716 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 712:	39 d0                	cmp    %edx,%eax
 714:	72 32                	jb     748 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 716:	8b 73 fc             	mov    -0x4(%ebx),%esi
 719:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 71c:	39 fa                	cmp    %edi,%edx
 71e:	74 30                	je     750 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 720:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 723:	8b 50 04             	mov    0x4(%eax),%edx
 726:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 729:	39 f1                	cmp    %esi,%ecx
 72b:	74 3a                	je     767 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 72d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 72f:	a3 e8 0b 00 00       	mov    %eax,0xbe8
}
 734:	5b                   	pop    %ebx
 735:	5e                   	pop    %esi
 736:	5f                   	pop    %edi
 737:	5d                   	pop    %ebp
 738:	c3                   	ret    
 739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 740:	39 d0                	cmp    %edx,%eax
 742:	72 04                	jb     748 <free+0x58>
 744:	39 d1                	cmp    %edx,%ecx
 746:	72 ce                	jb     716 <free+0x26>
{
 748:	89 d0                	mov    %edx,%eax
 74a:	eb bc                	jmp    708 <free+0x18>
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 750:	03 72 04             	add    0x4(%edx),%esi
 753:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 756:	8b 10                	mov    (%eax),%edx
 758:	8b 12                	mov    (%edx),%edx
 75a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 75d:	8b 50 04             	mov    0x4(%eax),%edx
 760:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 763:	39 f1                	cmp    %esi,%ecx
 765:	75 c6                	jne    72d <free+0x3d>
    p->s.size += bp->s.size;
 767:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 76a:	a3 e8 0b 00 00       	mov    %eax,0xbe8
    p->s.size += bp->s.size;
 76f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 772:	8b 53 f8             	mov    -0x8(%ebx),%edx
 775:	89 10                	mov    %edx,(%eax)
}
 777:	5b                   	pop    %ebx
 778:	5e                   	pop    %esi
 779:	5f                   	pop    %edi
 77a:	5d                   	pop    %ebp
 77b:	c3                   	ret    
 77c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000780 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	57                   	push   %edi
 784:	56                   	push   %esi
 785:	53                   	push   %ebx
 786:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 789:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 78c:	8b 15 e8 0b 00 00    	mov    0xbe8,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 792:	8d 78 07             	lea    0x7(%eax),%edi
 795:	c1 ef 03             	shr    $0x3,%edi
 798:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 79b:	85 d2                	test   %edx,%edx
 79d:	0f 84 9d 00 00 00    	je     840 <malloc+0xc0>
 7a3:	8b 02                	mov    (%edx),%eax
 7a5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7a8:	39 cf                	cmp    %ecx,%edi
 7aa:	76 6c                	jbe    818 <malloc+0x98>
 7ac:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 7b2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7b7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7ba:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7c1:	eb 0e                	jmp    7d1 <malloc+0x51>
 7c3:	90                   	nop
 7c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7ca:	8b 48 04             	mov    0x4(%eax),%ecx
 7cd:	39 f9                	cmp    %edi,%ecx
 7cf:	73 47                	jae    818 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7d1:	39 05 e8 0b 00 00    	cmp    %eax,0xbe8
 7d7:	89 c2                	mov    %eax,%edx
 7d9:	75 ed                	jne    7c8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 7db:	83 ec 0c             	sub    $0xc,%esp
 7de:	56                   	push   %esi
 7df:	e8 e6 fb ff ff       	call   3ca <sbrk>
  if(p == (char*)-1)
 7e4:	83 c4 10             	add    $0x10,%esp
 7e7:	83 f8 ff             	cmp    $0xffffffff,%eax
 7ea:	74 1c                	je     808 <malloc+0x88>
  hp->s.size = nu;
 7ec:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7ef:	83 ec 0c             	sub    $0xc,%esp
 7f2:	83 c0 08             	add    $0x8,%eax
 7f5:	50                   	push   %eax
 7f6:	e8 f5 fe ff ff       	call   6f0 <free>
  return freep;
 7fb:	8b 15 e8 0b 00 00    	mov    0xbe8,%edx
      if((p = morecore(nunits)) == 0)
 801:	83 c4 10             	add    $0x10,%esp
 804:	85 d2                	test   %edx,%edx
 806:	75 c0                	jne    7c8 <malloc+0x48>
        return 0;
  }
}
 808:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 80b:	31 c0                	xor    %eax,%eax
}
 80d:	5b                   	pop    %ebx
 80e:	5e                   	pop    %esi
 80f:	5f                   	pop    %edi
 810:	5d                   	pop    %ebp
 811:	c3                   	ret    
 812:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 818:	39 cf                	cmp    %ecx,%edi
 81a:	74 54                	je     870 <malloc+0xf0>
        p->s.size -= nunits;
 81c:	29 f9                	sub    %edi,%ecx
 81e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 821:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 824:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 827:	89 15 e8 0b 00 00    	mov    %edx,0xbe8
}
 82d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 830:	83 c0 08             	add    $0x8,%eax
}
 833:	5b                   	pop    %ebx
 834:	5e                   	pop    %esi
 835:	5f                   	pop    %edi
 836:	5d                   	pop    %ebp
 837:	c3                   	ret    
 838:	90                   	nop
 839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 840:	c7 05 e8 0b 00 00 ec 	movl   $0xbec,0xbe8
 847:	0b 00 00 
 84a:	c7 05 ec 0b 00 00 ec 	movl   $0xbec,0xbec
 851:	0b 00 00 
    base.s.size = 0;
 854:	b8 ec 0b 00 00       	mov    $0xbec,%eax
 859:	c7 05 f0 0b 00 00 00 	movl   $0x0,0xbf0
 860:	00 00 00 
 863:	e9 44 ff ff ff       	jmp    7ac <malloc+0x2c>
 868:	90                   	nop
 869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 870:	8b 08                	mov    (%eax),%ecx
 872:	89 0a                	mov    %ecx,(%edx)
 874:	eb b1                	jmp    827 <malloc+0xa7>
