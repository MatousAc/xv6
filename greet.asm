
user/_greet:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "kernel/types.h"
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
  25:	68 1b 08 00 00       	push   $0x81b
  2a:	e8 21 06 00 00       	call   650 <printf>
  2f:	83 c4 10             	add    $0x10,%esp
    }
    exit();
  32:	e8 7b 02 00 00       	call   2b2 <exit>
        printf("Too many arguments!\n");
  37:	83 ec 0c             	sub    $0xc,%esp
  3a:	68 06 08 00 00       	push   $0x806
  3f:	e8 0c 06 00 00       	call   650 <printf>
  44:	83 c4 10             	add    $0x10,%esp
  47:	eb e9                	jmp    32 <main+0x32>
        printf("Hello, user!\n");
  49:	83 ec 0c             	sub    $0xc,%esp
  4c:	68 f8 07 00 00       	push   $0x7f8
  51:	e8 fa 05 00 00       	call   650 <printf>
  56:	83 c4 10             	add    $0x10,%esp
  59:	eb d7                	jmp    32 <main+0x32>
  5b:	66 90                	xchg   %ax,%ax
  5d:	66 90                	xchg   %ax,%ax
  5f:	90                   	nop

00000060 <strcpy>:
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 45 08             	mov    0x8(%ebp),%eax
  67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6a:	89 c2                	mov    %eax,%edx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  70:	83 c1 01             	add    $0x1,%ecx
  73:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  77:	83 c2 01             	add    $0x1,%edx
  7a:	84 db                	test   %bl,%bl
  7c:	88 5a ff             	mov    %bl,-0x1(%edx)
  7f:	75 ef                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  81:	5b                   	pop    %ebx
  82:	5d                   	pop    %ebp
  83:	c3                   	ret    
  84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 55 08             	mov    0x8(%ebp),%edx
  97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  9a:	0f b6 02             	movzbl (%edx),%eax
  9d:	0f b6 19             	movzbl (%ecx),%ebx
  a0:	84 c0                	test   %al,%al
  a2:	75 1c                	jne    c0 <strcmp+0x30>
  a4:	eb 2a                	jmp    d0 <strcmp+0x40>
  a6:	8d 76 00             	lea    0x0(%esi),%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  b0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  b3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  b6:	83 c1 01             	add    $0x1,%ecx
  b9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  bc:	84 c0                	test   %al,%al
  be:	74 10                	je     d0 <strcmp+0x40>
  c0:	38 d8                	cmp    %bl,%al
  c2:	74 ec                	je     b0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  c4:	29 d8                	sub    %ebx,%eax
}
  c6:	5b                   	pop    %ebx
  c7:	5d                   	pop    %ebp
  c8:	c3                   	ret    
  c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  d0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  d2:	29 d8                	sub    %ebx,%eax
}
  d4:	5b                   	pop    %ebx
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    
  d7:	89 f6                	mov    %esi,%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000e0 <strlen>:

uint
strlen(const char *s)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  e6:	80 39 00             	cmpb   $0x0,(%ecx)
  e9:	74 15                	je     100 <strlen+0x20>
  eb:	31 d2                	xor    %edx,%edx
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  f0:	83 c2 01             	add    $0x1,%edx
  f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  f7:	89 d0                	mov    %edx,%eax
  f9:	75 f5                	jne    f0 <strlen+0x10>
    ;
  return n;
}
  fb:	5d                   	pop    %ebp
  fc:	c3                   	ret    
  fd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 100:	31 c0                	xor    %eax,%eax
}
 102:	5d                   	pop    %ebp
 103:	c3                   	ret    
 104:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 10a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 117:	8b 4d 10             	mov    0x10(%ebp),%ecx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 d7                	mov    %edx,%edi
 11f:	fc                   	cld    
 120:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 122:	89 d0                	mov    %edx,%eax
 124:	5f                   	pop    %edi
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    
 127:	89 f6                	mov    %esi,%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	8b 45 08             	mov    0x8(%ebp),%eax
 137:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 13a:	0f b6 10             	movzbl (%eax),%edx
 13d:	84 d2                	test   %dl,%dl
 13f:	74 1d                	je     15e <strchr+0x2e>
    if(*s == c)
 141:	38 d3                	cmp    %dl,%bl
 143:	89 d9                	mov    %ebx,%ecx
 145:	75 0d                	jne    154 <strchr+0x24>
 147:	eb 17                	jmp    160 <strchr+0x30>
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 150:	38 ca                	cmp    %cl,%dl
 152:	74 0c                	je     160 <strchr+0x30>
  for(; *s; s++)
 154:	83 c0 01             	add    $0x1,%eax
 157:	0f b6 10             	movzbl (%eax),%edx
 15a:	84 d2                	test   %dl,%dl
 15c:	75 f2                	jne    150 <strchr+0x20>
      return (char*)s;
  return 0;
 15e:	31 c0                	xor    %eax,%eax
}
 160:	5b                   	pop    %ebx
 161:	5d                   	pop    %ebp
 162:	c3                   	ret    
 163:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <gets>:

char*
gets(char *buf, int max)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	56                   	push   %esi
 175:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 176:	31 f6                	xor    %esi,%esi
 178:	89 f3                	mov    %esi,%ebx
{
 17a:	83 ec 1c             	sub    $0x1c,%esp
 17d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 180:	eb 2f                	jmp    1b1 <gets+0x41>
 182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 188:	8d 45 e7             	lea    -0x19(%ebp),%eax
 18b:	83 ec 04             	sub    $0x4,%esp
 18e:	6a 01                	push   $0x1
 190:	50                   	push   %eax
 191:	6a 00                	push   $0x0
 193:	e8 32 01 00 00       	call   2ca <read>
    if(cc < 1)
 198:	83 c4 10             	add    $0x10,%esp
 19b:	85 c0                	test   %eax,%eax
 19d:	7e 1c                	jle    1bb <gets+0x4b>
      break;
    buf[i++] = c;
 19f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1a3:	83 c7 01             	add    $0x1,%edi
 1a6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1a9:	3c 0a                	cmp    $0xa,%al
 1ab:	74 23                	je     1d0 <gets+0x60>
 1ad:	3c 0d                	cmp    $0xd,%al
 1af:	74 1f                	je     1d0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1b1:	83 c3 01             	add    $0x1,%ebx
 1b4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1b7:	89 fe                	mov    %edi,%esi
 1b9:	7c cd                	jl     188 <gets+0x18>
 1bb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1bd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1c0:	c6 03 00             	movb   $0x0,(%ebx)
}
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
  buf[i] = '\0';
 1da:	c6 03 00             	movb   $0x0,(%ebx)
}
 1dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e0:	5b                   	pop    %ebx
 1e1:	5e                   	pop    %esi
 1e2:	5f                   	pop    %edi
 1e3:	5d                   	pop    %ebp
 1e4:	c3                   	ret    
 1e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	56                   	push   %esi
 1f4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f5:	83 ec 08             	sub    $0x8,%esp
 1f8:	6a 00                	push   $0x0
 1fa:	ff 75 08             	pushl  0x8(%ebp)
 1fd:	e8 f8 00 00 00       	call   2fa <open>
  if(fd < 0)
 202:	83 c4 10             	add    $0x10,%esp
 205:	85 c0                	test   %eax,%eax
 207:	78 27                	js     230 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 209:	83 ec 08             	sub    $0x8,%esp
 20c:	ff 75 0c             	pushl  0xc(%ebp)
 20f:	89 c3                	mov    %eax,%ebx
 211:	50                   	push   %eax
 212:	e8 fb 00 00 00       	call   312 <fstat>
  close(fd);
 217:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 21a:	89 c6                	mov    %eax,%esi
  close(fd);
 21c:	e8 c1 00 00 00       	call   2e2 <close>
  return r;
 221:	83 c4 10             	add    $0x10,%esp
}
 224:	8d 65 f8             	lea    -0x8(%ebp),%esp
 227:	89 f0                	mov    %esi,%eax
 229:	5b                   	pop    %ebx
 22a:	5e                   	pop    %esi
 22b:	5d                   	pop    %ebp
 22c:	c3                   	ret    
 22d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 230:	be ff ff ff ff       	mov    $0xffffffff,%esi
 235:	eb ed                	jmp    224 <stat+0x34>
 237:	89 f6                	mov    %esi,%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <atoi>:

int
atoi(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 247:	0f be 11             	movsbl (%ecx),%edx
 24a:	8d 42 d0             	lea    -0x30(%edx),%eax
 24d:	3c 09                	cmp    $0x9,%al
  n = 0;
 24f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 254:	77 1f                	ja     275 <atoi+0x35>
 256:	8d 76 00             	lea    0x0(%esi),%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 260:	8d 04 80             	lea    (%eax,%eax,4),%eax
 263:	83 c1 01             	add    $0x1,%ecx
 266:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 26a:	0f be 11             	movsbl (%ecx),%edx
 26d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 270:	80 fb 09             	cmp    $0x9,%bl
 273:	76 eb                	jbe    260 <atoi+0x20>
  return n;
}
 275:	5b                   	pop    %ebx
 276:	5d                   	pop    %ebp
 277:	c3                   	ret    
 278:	90                   	nop
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000280 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	53                   	push   %ebx
 285:	8b 5d 10             	mov    0x10(%ebp),%ebx
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 28e:	85 db                	test   %ebx,%ebx
 290:	7e 14                	jle    2a6 <memmove+0x26>
 292:	31 d2                	xor    %edx,%edx
 294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 298:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 29c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 29f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2a2:	39 d3                	cmp    %edx,%ebx
 2a4:	75 f2                	jne    298 <memmove+0x18>
  return vdst;
}
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

000002d2 <steal>:
SYSCALL(steal)
 2d2:	b8 17 00 00 00       	mov    $0x17,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <write>:
SYSCALL(write)
 2da:	b8 10 00 00 00       	mov    $0x10,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <close>:
SYSCALL(close)
 2e2:	b8 15 00 00 00       	mov    $0x15,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <kill>:
SYSCALL(kill)
 2ea:	b8 06 00 00 00       	mov    $0x6,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <exec>:
SYSCALL(exec)
 2f2:	b8 07 00 00 00       	mov    $0x7,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <open>:
SYSCALL(open)
 2fa:	b8 0f 00 00 00       	mov    $0xf,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <mknod>:
SYSCALL(mknod)
 302:	b8 11 00 00 00       	mov    $0x11,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <unlink>:
SYSCALL(unlink)
 30a:	b8 12 00 00 00       	mov    $0x12,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <fstat>:
SYSCALL(fstat)
 312:	b8 08 00 00 00       	mov    $0x8,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <link>:
SYSCALL(link)
 31a:	b8 13 00 00 00       	mov    $0x13,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <mkdir>:
SYSCALL(mkdir)
 322:	b8 14 00 00 00       	mov    $0x14,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <chdir>:
SYSCALL(chdir)
 32a:	b8 09 00 00 00       	mov    $0x9,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <dup>:
SYSCALL(dup)
 332:	b8 0a 00 00 00       	mov    $0xa,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <getpid>:
SYSCALL(getpid)
 33a:	b8 0b 00 00 00       	mov    $0xb,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <sbrk>:
SYSCALL(sbrk)
 342:	b8 0c 00 00 00       	mov    $0xc,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <sleep>:
SYSCALL(sleep)
 34a:	b8 0d 00 00 00       	mov    $0xd,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <uptime>:
SYSCALL(uptime)
 352:	b8 0e 00 00 00       	mov    $0xe,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <cpuhalt>:
SYSCALL(cpuhalt)
 35a:	b8 16 00 00 00       	mov    $0x16,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    
 362:	66 90                	xchg   %ax,%ax
 364:	66 90                	xchg   %ax,%ax
 366:	66 90                	xchg   %ax,%ax
 368:	66 90                	xchg   %ax,%ax
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
 3a1:	0f b6 92 30 08 00 00 	movzbl 0x830(%edx),%edx
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
 3d9:	e8 fc fe ff ff       	call   2da <write>
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
 437:	e8 9e fe ff ff       	call   2da <write>
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
 4b3:	e8 22 fe ff ff       	call   2da <write>
 4b8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 4bc:	83 c4 0c             	add    $0xc,%esp
 4bf:	8d 45 e0             	lea    -0x20(%ebp),%eax
 4c2:	6a 01                	push   $0x1
 4c4:	88 55 e0             	mov    %dl,-0x20(%ebp)
 4c7:	50                   	push   %eax
 4c8:	6a 01                	push   $0x1
 4ca:	83 c3 01             	add    $0x1,%ebx
 4cd:	31 ff                	xor    %edi,%edi
 4cf:	e8 06 fe ff ff       	call   2da <write>
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
 56c:	e8 69 fd ff ff       	call   2da <write>
 571:	8d 45 e7             	lea    -0x19(%ebp),%eax
 574:	83 c4 0c             	add    $0xc,%esp
 577:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 57b:	6a 01                	push   $0x1
 57d:	50                   	push   %eax
 57e:	6a 01                	push   $0x1
 580:	e8 55 fd ff ff       	call   2da <write>
 585:	83 c4 10             	add    $0x10,%esp
 588:	90                   	nop
 589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 590:	89 f8                	mov    %edi,%eax
 592:	83 ec 04             	sub    $0x4,%esp
 595:	c1 e7 04             	shl    $0x4,%edi
 598:	c1 e8 1c             	shr    $0x1c,%eax
 59b:	6a 01                	push   $0x1
 59d:	0f b6 80 30 08 00 00 	movzbl 0x830(%eax),%eax
 5a4:	88 45 e5             	mov    %al,-0x1b(%ebp)
 5a7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5aa:	50                   	push   %eax
 5ab:	6a 01                	push   $0x1
 5ad:	e8 28 fd ff ff       	call   2da <write>
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
 5ee:	e8 e7 fc ff ff       	call   2da <write>
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
 617:	e8 be fc ff ff       	call   2da <write>
 61c:	83 c4 10             	add    $0x10,%esp
 61f:	e9 1b fe ff ff       	jmp    43f <vprintf.constprop.0+0x3f>
 624:	bf 27 08 00 00       	mov    $0x827,%edi
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
 671:	a1 14 0b 00 00       	mov    0xb14,%eax
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
 6af:	a3 14 0b 00 00       	mov    %eax,0xb14
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
 6ea:	a3 14 0b 00 00       	mov    %eax,0xb14
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
 70c:	8b 15 14 0b 00 00    	mov    0xb14,%edx
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
 751:	39 05 14 0b 00 00    	cmp    %eax,0xb14
 757:	89 c2                	mov    %eax,%edx
 759:	75 ed                	jne    748 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 75b:	83 ec 0c             	sub    $0xc,%esp
 75e:	56                   	push   %esi
 75f:	e8 de fb ff ff       	call   342 <sbrk>
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
 77b:	8b 15 14 0b 00 00    	mov    0xb14,%edx
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
 7a7:	89 15 14 0b 00 00    	mov    %edx,0xb14
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
 7c0:	c7 05 14 0b 00 00 18 	movl   $0xb18,0xb14
 7c7:	0b 00 00 
 7ca:	c7 05 18 0b 00 00 18 	movl   $0xb18,0xb18
 7d1:	0b 00 00 
    base.s.size = 0;
 7d4:	b8 18 0b 00 00       	mov    $0xb18,%eax
 7d9:	c7 05 1c 0b 00 00 00 	movl   $0x0,0xb1c
 7e0:	00 00 00 
 7e3:	e9 44 ff ff ff       	jmp    72c <malloc+0x2c>
 7e8:	90                   	nop
 7e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 7f0:	8b 08                	mov    (%eax),%ecx
 7f2:	89 0a                	mov    %ecx,(%edx)
 7f4:	eb b1                	jmp    7a7 <malloc+0xa7>
