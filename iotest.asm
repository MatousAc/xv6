
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
  12:	68 18 08 00 00       	push   $0x818
  17:	e8 54 06 00 00       	call   670 <printf>
  int fd;
  fd = open("README", O_RDONLY);
  1c:	58                   	pop    %eax
  1d:	5a                   	pop    %edx
  1e:	6a 00                	push   $0x0
  20:	68 80 08 00 00       	push   $0x880
  25:	e8 f0 02 00 00       	call   31a <open>
  printf("The fd I got for README = %d\n", fd);
  2a:	59                   	pop    %ecx
  fd = open("README", O_RDONLY);
  2b:	89 c3                	mov    %eax,%ebx
  printf("The fd I got for README = %d\n", fd);
  2d:	58                   	pop    %eax
  2e:	53                   	push   %ebx
  2f:	68 87 08 00 00       	push   $0x887
  34:	e8 37 06 00 00       	call   670 <printf>
  close(fd);
  39:	89 1c 24             	mov    %ebx,(%esp)
  3c:	e8 c1 02 00 00       	call   302 <close>
  close(1);
  41:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  48:	e8 b5 02 00 00       	call   302 <close>
  fd = open("output.txt", O_CREATE | O_WRONLY);
  4d:	58                   	pop    %eax
  4e:	5a                   	pop    %edx
  4f:	68 01 02 00 00       	push   $0x201
  54:	68 a5 08 00 00       	push   $0x8a5
  59:	e8 bc 02 00 00       	call   31a <open>
  printf("Hello There! This is the IO Test!\n");
  5e:	c7 04 24 38 08 00 00 	movl   $0x838,(%esp)
  fd = open("output.txt", O_CREATE | O_WRONLY);
  65:	89 c3                	mov    %eax,%ebx
  printf("Hello There! This is the IO Test!\n");
  67:	e8 04 06 00 00       	call   670 <printf>
  printf("The fd I got for output.txt = %d\n", fd);
  6c:	59                   	pop    %ecx
  6d:	58                   	pop    %eax
  6e:	53                   	push   %ebx
  6f:	68 5c 08 00 00       	push   $0x85c
  74:	e8 f7 05 00 00       	call   670 <printf>
  exit();
  79:	e8 54 02 00 00       	call   2d2 <exit>
  7e:	66 90                	xchg   %ax,%ax

00000080 <strcpy>:
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	53                   	push   %ebx
  84:	8b 45 08             	mov    0x8(%ebp),%eax
  87:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  8a:	89 c2                	mov    %eax,%edx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  90:	83 c1 01             	add    $0x1,%ecx
  93:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  97:	83 c2 01             	add    $0x1,%edx
  9a:	84 db                	test   %bl,%bl
  9c:	88 5a ff             	mov    %bl,-0x1(%edx)
  9f:	75 ef                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  a1:	5b                   	pop    %ebx
  a2:	5d                   	pop    %ebp
  a3:	c3                   	ret    
  a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	8b 55 08             	mov    0x8(%ebp),%edx
  b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  ba:	0f b6 02             	movzbl (%edx),%eax
  bd:	0f b6 19             	movzbl (%ecx),%ebx
  c0:	84 c0                	test   %al,%al
  c2:	75 1c                	jne    e0 <strcmp+0x30>
  c4:	eb 2a                	jmp    f0 <strcmp+0x40>
  c6:	8d 76 00             	lea    0x0(%esi),%esi
  c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  d0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  d6:	83 c1 01             	add    $0x1,%ecx
  d9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  dc:	84 c0                	test   %al,%al
  de:	74 10                	je     f0 <strcmp+0x40>
  e0:	38 d8                	cmp    %bl,%al
  e2:	74 ec                	je     d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  e4:	29 d8                	sub    %ebx,%eax
}
  e6:	5b                   	pop    %ebx
  e7:	5d                   	pop    %ebp
  e8:	c3                   	ret    
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  f2:	29 d8                	sub    %ebx,%eax
}
  f4:	5b                   	pop    %ebx
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strlen>:

uint
strlen(const char *s)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 106:	80 39 00             	cmpb   $0x0,(%ecx)
 109:	74 15                	je     120 <strlen+0x20>
 10b:	31 d2                	xor    %edx,%edx
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	83 c2 01             	add    $0x1,%edx
 113:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 117:	89 d0                	mov    %edx,%eax
 119:	75 f5                	jne    110 <strlen+0x10>
    ;
  return n;
}
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    
 11d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 120:	31 c0                	xor    %eax,%eax
}
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    
 124:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 12a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 137:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	89 d7                	mov    %edx,%edi
 13f:	fc                   	cld    
 140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 142:	89 d0                	mov    %edx,%eax
 144:	5f                   	pop    %edi
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	89 f6                	mov    %esi,%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 45 08             	mov    0x8(%ebp),%eax
 157:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 15a:	0f b6 10             	movzbl (%eax),%edx
 15d:	84 d2                	test   %dl,%dl
 15f:	74 1d                	je     17e <strchr+0x2e>
    if(*s == c)
 161:	38 d3                	cmp    %dl,%bl
 163:	89 d9                	mov    %ebx,%ecx
 165:	75 0d                	jne    174 <strchr+0x24>
 167:	eb 17                	jmp    180 <strchr+0x30>
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 170:	38 ca                	cmp    %cl,%dl
 172:	74 0c                	je     180 <strchr+0x30>
  for(; *s; s++)
 174:	83 c0 01             	add    $0x1,%eax
 177:	0f b6 10             	movzbl (%eax),%edx
 17a:	84 d2                	test   %dl,%dl
 17c:	75 f2                	jne    170 <strchr+0x20>
      return (char*)s;
  return 0;
 17e:	31 c0                	xor    %eax,%eax
}
 180:	5b                   	pop    %ebx
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
 183:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
 195:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 196:	31 f6                	xor    %esi,%esi
 198:	89 f3                	mov    %esi,%ebx
{
 19a:	83 ec 1c             	sub    $0x1c,%esp
 19d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 1a0:	eb 2f                	jmp    1d1 <gets+0x41>
 1a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 1a8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1ab:	83 ec 04             	sub    $0x4,%esp
 1ae:	6a 01                	push   $0x1
 1b0:	50                   	push   %eax
 1b1:	6a 00                	push   $0x0
 1b3:	e8 32 01 00 00       	call   2ea <read>
    if(cc < 1)
 1b8:	83 c4 10             	add    $0x10,%esp
 1bb:	85 c0                	test   %eax,%eax
 1bd:	7e 1c                	jle    1db <gets+0x4b>
      break;
    buf[i++] = c;
 1bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1c3:	83 c7 01             	add    $0x1,%edi
 1c6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1c9:	3c 0a                	cmp    $0xa,%al
 1cb:	74 23                	je     1f0 <gets+0x60>
 1cd:	3c 0d                	cmp    $0xd,%al
 1cf:	74 1f                	je     1f0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1d1:	83 c3 01             	add    $0x1,%ebx
 1d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1d7:	89 fe                	mov    %edi,%esi
 1d9:	7c cd                	jl     1a8 <gets+0x18>
 1db:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1dd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1e0:	c6 03 00             	movb   $0x0,(%ebx)
}
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
  buf[i] = '\0';
 1fa:	c6 03 00             	movb   $0x0,(%ebx)
}
 1fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 200:	5b                   	pop    %ebx
 201:	5e                   	pop    %esi
 202:	5f                   	pop    %edi
 203:	5d                   	pop    %ebp
 204:	c3                   	ret    
 205:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	56                   	push   %esi
 214:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 215:	83 ec 08             	sub    $0x8,%esp
 218:	6a 00                	push   $0x0
 21a:	ff 75 08             	pushl  0x8(%ebp)
 21d:	e8 f8 00 00 00       	call   31a <open>
  if(fd < 0)
 222:	83 c4 10             	add    $0x10,%esp
 225:	85 c0                	test   %eax,%eax
 227:	78 27                	js     250 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 229:	83 ec 08             	sub    $0x8,%esp
 22c:	ff 75 0c             	pushl  0xc(%ebp)
 22f:	89 c3                	mov    %eax,%ebx
 231:	50                   	push   %eax
 232:	e8 fb 00 00 00       	call   332 <fstat>
  close(fd);
 237:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 23a:	89 c6                	mov    %eax,%esi
  close(fd);
 23c:	e8 c1 00 00 00       	call   302 <close>
  return r;
 241:	83 c4 10             	add    $0x10,%esp
}
 244:	8d 65 f8             	lea    -0x8(%ebp),%esp
 247:	89 f0                	mov    %esi,%eax
 249:	5b                   	pop    %ebx
 24a:	5e                   	pop    %esi
 24b:	5d                   	pop    %ebp
 24c:	c3                   	ret    
 24d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 250:	be ff ff ff ff       	mov    $0xffffffff,%esi
 255:	eb ed                	jmp    244 <stat+0x34>
 257:	89 f6                	mov    %esi,%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <atoi>:

int
atoi(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 267:	0f be 11             	movsbl (%ecx),%edx
 26a:	8d 42 d0             	lea    -0x30(%edx),%eax
 26d:	3c 09                	cmp    $0x9,%al
  n = 0;
 26f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 274:	77 1f                	ja     295 <atoi+0x35>
 276:	8d 76 00             	lea    0x0(%esi),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 280:	8d 04 80             	lea    (%eax,%eax,4),%eax
 283:	83 c1 01             	add    $0x1,%ecx
 286:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 28a:	0f be 11             	movsbl (%ecx),%edx
 28d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 290:	80 fb 09             	cmp    $0x9,%bl
 293:	76 eb                	jbe    280 <atoi+0x20>
  return n;
}
 295:	5b                   	pop    %ebx
 296:	5d                   	pop    %ebp
 297:	c3                   	ret    
 298:	90                   	nop
 299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	53                   	push   %ebx
 2a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 2a8:	8b 45 08             	mov    0x8(%ebp),%eax
 2ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ae:	85 db                	test   %ebx,%ebx
 2b0:	7e 14                	jle    2c6 <memmove+0x26>
 2b2:	31 d2                	xor    %edx,%edx
 2b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 2b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2bf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2c2:	39 d3                	cmp    %edx,%ebx
 2c4:	75 f2                	jne    2b8 <memmove+0x18>
  return vdst;
}
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

000002f2 <steal>:
SYSCALL(steal)
 2f2:	b8 17 00 00 00       	mov    $0x17,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <write>:
SYSCALL(write)
 2fa:	b8 10 00 00 00       	mov    $0x10,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <close>:
SYSCALL(close)
 302:	b8 15 00 00 00       	mov    $0x15,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <kill>:
SYSCALL(kill)
 30a:	b8 06 00 00 00       	mov    $0x6,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <exec>:
SYSCALL(exec)
 312:	b8 07 00 00 00       	mov    $0x7,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <open>:
SYSCALL(open)
 31a:	b8 0f 00 00 00       	mov    $0xf,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <mknod>:
SYSCALL(mknod)
 322:	b8 11 00 00 00       	mov    $0x11,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <unlink>:
SYSCALL(unlink)
 32a:	b8 12 00 00 00       	mov    $0x12,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <fstat>:
SYSCALL(fstat)
 332:	b8 08 00 00 00       	mov    $0x8,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <link>:
SYSCALL(link)
 33a:	b8 13 00 00 00       	mov    $0x13,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <mkdir>:
SYSCALL(mkdir)
 342:	b8 14 00 00 00       	mov    $0x14,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <chdir>:
SYSCALL(chdir)
 34a:	b8 09 00 00 00       	mov    $0x9,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <dup>:
SYSCALL(dup)
 352:	b8 0a 00 00 00       	mov    $0xa,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <getpid>:
SYSCALL(getpid)
 35a:	b8 0b 00 00 00       	mov    $0xb,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <sbrk>:
SYSCALL(sbrk)
 362:	b8 0c 00 00 00       	mov    $0xc,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <sleep>:
SYSCALL(sleep)
 36a:	b8 0d 00 00 00       	mov    $0xd,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <uptime>:
SYSCALL(uptime)
 372:	b8 0e 00 00 00       	mov    $0xe,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <cpuhalt>:
SYSCALL(cpuhalt)
 37a:	b8 16 00 00 00       	mov    $0x16,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    
 382:	66 90                	xchg   %ax,%ax
 384:	66 90                	xchg   %ax,%ax
 386:	66 90                	xchg   %ax,%ax
 388:	66 90                	xchg   %ax,%ax
 38a:	66 90                	xchg   %ax,%ax
 38c:	66 90                	xchg   %ax,%ax
 38e:	66 90                	xchg   %ax,%ax

00000390 <printint.constprop.1>:
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	53                   	push   %ebx
 396:	89 d6                	mov    %edx,%esi
 398:	83 ec 3c             	sub    $0x3c,%esp
 39b:	85 c0                	test   %eax,%eax
 39d:	79 71                	jns    410 <printint.constprop.1+0x80>
 39f:	83 e1 01             	and    $0x1,%ecx
 3a2:	74 6c                	je     410 <printint.constprop.1+0x80>
 3a4:	f7 d8                	neg    %eax
 3a6:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 3ad:	31 c9                	xor    %ecx,%ecx
 3af:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3b2:	eb 06                	jmp    3ba <printint.constprop.1+0x2a>
 3b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3b8:	89 f9                	mov    %edi,%ecx
 3ba:	31 d2                	xor    %edx,%edx
 3bc:	8d 79 01             	lea    0x1(%ecx),%edi
 3bf:	f7 f6                	div    %esi
 3c1:	0f b6 92 b8 08 00 00 	movzbl 0x8b8(%edx),%edx
 3c8:	85 c0                	test   %eax,%eax
 3ca:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
 3cd:	75 e9                	jne    3b8 <printint.constprop.1+0x28>
 3cf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3d2:	85 c0                	test   %eax,%eax
 3d4:	74 08                	je     3de <printint.constprop.1+0x4e>
 3d6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 3db:	8d 79 02             	lea    0x2(%ecx),%edi
 3de:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 3e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3e8:	0f b6 06             	movzbl (%esi),%eax
 3eb:	83 ec 04             	sub    $0x4,%esp
 3ee:	83 ee 01             	sub    $0x1,%esi
 3f1:	6a 01                	push   $0x1
 3f3:	53                   	push   %ebx
 3f4:	6a 01                	push   $0x1
 3f6:	88 45 d7             	mov    %al,-0x29(%ebp)
 3f9:	e8 fc fe ff ff       	call   2fa <write>
 3fe:	83 c4 10             	add    $0x10,%esp
 401:	39 de                	cmp    %ebx,%esi
 403:	75 e3                	jne    3e8 <printint.constprop.1+0x58>
 405:	8d 65 f4             	lea    -0xc(%ebp),%esp
 408:	5b                   	pop    %ebx
 409:	5e                   	pop    %esi
 40a:	5f                   	pop    %edi
 40b:	5d                   	pop    %ebp
 40c:	c3                   	ret    
 40d:	8d 76 00             	lea    0x0(%esi),%esi
 410:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 417:	eb 94                	jmp    3ad <printint.constprop.1+0x1d>
 419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000420 <vprintf.constprop.0>:
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	89 d6                	mov    %edx,%esi
 428:	83 ec 2c             	sub    $0x2c,%esp
 42b:	0f b6 10             	movzbl (%eax),%edx
 42e:	84 d2                	test   %dl,%dl
 430:	0f 84 cd 00 00 00    	je     503 <vprintf.constprop.0+0xe3>
 436:	8d 58 01             	lea    0x1(%eax),%ebx
 439:	31 ff                	xor    %edi,%edi
 43b:	eb 31                	jmp    46e <vprintf.constprop.0+0x4e>
 43d:	8d 76 00             	lea    0x0(%esi),%esi
 440:	83 f8 25             	cmp    $0x25,%eax
 443:	0f 84 c7 00 00 00    	je     510 <vprintf.constprop.0+0xf0>
 449:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 44c:	83 ec 04             	sub    $0x4,%esp
 44f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 452:	6a 01                	push   $0x1
 454:	50                   	push   %eax
 455:	6a 01                	push   $0x1
 457:	e8 9e fe ff ff       	call   2fa <write>
 45c:	83 c4 10             	add    $0x10,%esp
 45f:	83 c3 01             	add    $0x1,%ebx
 462:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 466:	84 d2                	test   %dl,%dl
 468:	0f 84 95 00 00 00    	je     503 <vprintf.constprop.0+0xe3>
 46e:	85 ff                	test   %edi,%edi
 470:	0f b6 c2             	movzbl %dl,%eax
 473:	74 cb                	je     440 <vprintf.constprop.0+0x20>
 475:	83 ff 25             	cmp    $0x25,%edi
 478:	75 e5                	jne    45f <vprintf.constprop.0+0x3f>
 47a:	83 f8 64             	cmp    $0x64,%eax
 47d:	8d 7e 04             	lea    0x4(%esi),%edi
 480:	b9 01 00 00 00       	mov    $0x1,%ecx
 485:	0f 84 9a 00 00 00    	je     525 <vprintf.constprop.0+0x105>
 48b:	83 f8 6c             	cmp    $0x6c,%eax
 48e:	0f 84 8c 00 00 00    	je     520 <vprintf.constprop.0+0x100>
 494:	83 f8 78             	cmp    $0x78,%eax
 497:	0f 84 a3 00 00 00    	je     540 <vprintf.constprop.0+0x120>
 49d:	83 f8 70             	cmp    $0x70,%eax
 4a0:	0f 84 ca 00 00 00    	je     570 <vprintf.constprop.0+0x150>
 4a6:	83 f8 73             	cmp    $0x73,%eax
 4a9:	0f 84 39 01 00 00    	je     5e8 <vprintf.constprop.0+0x1c8>
 4af:	83 f8 63             	cmp    $0x63,%eax
 4b2:	0f 84 68 01 00 00    	je     620 <vprintf.constprop.0+0x200>
 4b8:	83 f8 25             	cmp    $0x25,%eax
 4bb:	0f 84 9f 00 00 00    	je     560 <vprintf.constprop.0+0x140>
 4c1:	8d 45 df             	lea    -0x21(%ebp),%eax
 4c4:	83 ec 04             	sub    $0x4,%esp
 4c7:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 4ca:	6a 01                	push   $0x1
 4cc:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 4d0:	50                   	push   %eax
 4d1:	6a 01                	push   $0x1
 4d3:	e8 22 fe ff ff       	call   2fa <write>
 4d8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 4dc:	83 c4 0c             	add    $0xc,%esp
 4df:	8d 45 e0             	lea    -0x20(%ebp),%eax
 4e2:	6a 01                	push   $0x1
 4e4:	88 55 e0             	mov    %dl,-0x20(%ebp)
 4e7:	50                   	push   %eax
 4e8:	6a 01                	push   $0x1
 4ea:	83 c3 01             	add    $0x1,%ebx
 4ed:	31 ff                	xor    %edi,%edi
 4ef:	e8 06 fe ff ff       	call   2fa <write>
 4f4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4f8:	83 c4 10             	add    $0x10,%esp
 4fb:	84 d2                	test   %dl,%dl
 4fd:	0f 85 6b ff ff ff    	jne    46e <vprintf.constprop.0+0x4e>
 503:	8d 65 f4             	lea    -0xc(%ebp),%esp
 506:	5b                   	pop    %ebx
 507:	5e                   	pop    %esi
 508:	5f                   	pop    %edi
 509:	5d                   	pop    %ebp
 50a:	c3                   	ret    
 50b:	90                   	nop
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 510:	bf 25 00 00 00       	mov    $0x25,%edi
 515:	e9 45 ff ff ff       	jmp    45f <vprintf.constprop.0+0x3f>
 51a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 520:	8d 7e 04             	lea    0x4(%esi),%edi
 523:	31 c9                	xor    %ecx,%ecx
 525:	8b 06                	mov    (%esi),%eax
 527:	ba 0a 00 00 00       	mov    $0xa,%edx
 52c:	89 fe                	mov    %edi,%esi
 52e:	31 ff                	xor    %edi,%edi
 530:	e8 5b fe ff ff       	call   390 <printint.constprop.1>
 535:	e9 25 ff ff ff       	jmp    45f <vprintf.constprop.0+0x3f>
 53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 540:	8b 06                	mov    (%esi),%eax
 542:	8d 7e 04             	lea    0x4(%esi),%edi
 545:	31 c9                	xor    %ecx,%ecx
 547:	ba 10 00 00 00       	mov    $0x10,%edx
 54c:	89 fe                	mov    %edi,%esi
 54e:	31 ff                	xor    %edi,%edi
 550:	e8 3b fe ff ff       	call   390 <printint.constprop.1>
 555:	e9 05 ff ff ff       	jmp    45f <vprintf.constprop.0+0x3f>
 55a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 560:	83 ec 04             	sub    $0x4,%esp
 563:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 566:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 569:	6a 01                	push   $0x1
 56b:	e9 77 ff ff ff       	jmp    4e7 <vprintf.constprop.0+0xc7>
 570:	8d 46 04             	lea    0x4(%esi),%eax
 573:	83 ec 04             	sub    $0x4,%esp
 576:	8b 3e                	mov    (%esi),%edi
 578:	6a 01                	push   $0x1
 57a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 57e:	be 08 00 00 00       	mov    $0x8,%esi
 583:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 586:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 589:	50                   	push   %eax
 58a:	6a 01                	push   $0x1
 58c:	e8 69 fd ff ff       	call   2fa <write>
 591:	8d 45 e7             	lea    -0x19(%ebp),%eax
 594:	83 c4 0c             	add    $0xc,%esp
 597:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 59b:	6a 01                	push   $0x1
 59d:	50                   	push   %eax
 59e:	6a 01                	push   $0x1
 5a0:	e8 55 fd ff ff       	call   2fa <write>
 5a5:	83 c4 10             	add    $0x10,%esp
 5a8:	90                   	nop
 5a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5b0:	89 f8                	mov    %edi,%eax
 5b2:	83 ec 04             	sub    $0x4,%esp
 5b5:	c1 e7 04             	shl    $0x4,%edi
 5b8:	c1 e8 1c             	shr    $0x1c,%eax
 5bb:	6a 01                	push   $0x1
 5bd:	0f b6 80 b8 08 00 00 	movzbl 0x8b8(%eax),%eax
 5c4:	88 45 e5             	mov    %al,-0x1b(%ebp)
 5c7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5ca:	50                   	push   %eax
 5cb:	6a 01                	push   $0x1
 5cd:	e8 28 fd ff ff       	call   2fa <write>
 5d2:	83 c4 10             	add    $0x10,%esp
 5d5:	83 ee 01             	sub    $0x1,%esi
 5d8:	75 d6                	jne    5b0 <vprintf.constprop.0+0x190>
 5da:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 5dd:	31 ff                	xor    %edi,%edi
 5df:	e9 7b fe ff ff       	jmp    45f <vprintf.constprop.0+0x3f>
 5e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5e8:	8b 3e                	mov    (%esi),%edi
 5ea:	8d 46 04             	lea    0x4(%esi),%eax
 5ed:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5f0:	85 ff                	test   %edi,%edi
 5f2:	74 50                	je     644 <vprintf.constprop.0+0x224>
 5f4:	0f b6 07             	movzbl (%edi),%eax
 5f7:	84 c0                	test   %al,%al
 5f9:	74 df                	je     5da <vprintf.constprop.0+0x1ba>
 5fb:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 5fe:	66 90                	xchg   %ax,%ax
 600:	83 ec 04             	sub    $0x4,%esp
 603:	83 c7 01             	add    $0x1,%edi
 606:	88 45 e3             	mov    %al,-0x1d(%ebp)
 609:	6a 01                	push   $0x1
 60b:	56                   	push   %esi
 60c:	6a 01                	push   $0x1
 60e:	e8 e7 fc ff ff       	call   2fa <write>
 613:	0f b6 07             	movzbl (%edi),%eax
 616:	83 c4 10             	add    $0x10,%esp
 619:	84 c0                	test   %al,%al
 61b:	75 e3                	jne    600 <vprintf.constprop.0+0x1e0>
 61d:	eb bb                	jmp    5da <vprintf.constprop.0+0x1ba>
 61f:	90                   	nop
 620:	8b 06                	mov    (%esi),%eax
 622:	83 ec 04             	sub    $0x4,%esp
 625:	8d 7e 04             	lea    0x4(%esi),%edi
 628:	6a 01                	push   $0x1
 62a:	89 fe                	mov    %edi,%esi
 62c:	31 ff                	xor    %edi,%edi
 62e:	88 45 e2             	mov    %al,-0x1e(%ebp)
 631:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 634:	50                   	push   %eax
 635:	6a 01                	push   $0x1
 637:	e8 be fc ff ff       	call   2fa <write>
 63c:	83 c4 10             	add    $0x10,%esp
 63f:	e9 1b fe ff ff       	jmp    45f <vprintf.constprop.0+0x3f>
 644:	bf b0 08 00 00       	mov    $0x8b0,%edi
 649:	b8 28 00 00 00       	mov    $0x28,%eax
 64e:	eb ab                	jmp    5fb <vprintf.constprop.0+0x1db>

00000650 <fprintf>:
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	83 ec 08             	sub    $0x8,%esp
 656:	8b 45 0c             	mov    0xc(%ebp),%eax
 659:	8d 55 10             	lea    0x10(%ebp),%edx
 65c:	e8 bf fd ff ff       	call   420 <vprintf.constprop.0>
 661:	c9                   	leave  
 662:	c3                   	ret    
 663:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000670 <printf>:
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	83 ec 08             	sub    $0x8,%esp
 676:	8b 45 08             	mov    0x8(%ebp),%eax
 679:	8d 55 0c             	lea    0xc(%ebp),%edx
 67c:	e8 9f fd ff ff       	call   420 <vprintf.constprop.0>
 681:	c9                   	leave  
 682:	c3                   	ret    
 683:	66 90                	xchg   %ax,%ax
 685:	66 90                	xchg   %ax,%ax
 687:	66 90                	xchg   %ax,%ax
 689:	66 90                	xchg   %ax,%ax
 68b:	66 90                	xchg   %ax,%ax
 68d:	66 90                	xchg   %ax,%ax
 68f:	90                   	nop

00000690 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 690:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 691:	a1 a0 0b 00 00       	mov    0xba0,%eax
{
 696:	89 e5                	mov    %esp,%ebp
 698:	57                   	push   %edi
 699:	56                   	push   %esi
 69a:	53                   	push   %ebx
 69b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 69e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 6a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a8:	39 c8                	cmp    %ecx,%eax
 6aa:	8b 10                	mov    (%eax),%edx
 6ac:	73 32                	jae    6e0 <free+0x50>
 6ae:	39 d1                	cmp    %edx,%ecx
 6b0:	72 04                	jb     6b6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b2:	39 d0                	cmp    %edx,%eax
 6b4:	72 32                	jb     6e8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6b6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6b9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6bc:	39 fa                	cmp    %edi,%edx
 6be:	74 30                	je     6f0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6c0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6c3:	8b 50 04             	mov    0x4(%eax),%edx
 6c6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6c9:	39 f1                	cmp    %esi,%ecx
 6cb:	74 3a                	je     707 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6cd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 6cf:	a3 a0 0b 00 00       	mov    %eax,0xba0
}
 6d4:	5b                   	pop    %ebx
 6d5:	5e                   	pop    %esi
 6d6:	5f                   	pop    %edi
 6d7:	5d                   	pop    %ebp
 6d8:	c3                   	ret    
 6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e0:	39 d0                	cmp    %edx,%eax
 6e2:	72 04                	jb     6e8 <free+0x58>
 6e4:	39 d1                	cmp    %edx,%ecx
 6e6:	72 ce                	jb     6b6 <free+0x26>
{
 6e8:	89 d0                	mov    %edx,%eax
 6ea:	eb bc                	jmp    6a8 <free+0x18>
 6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 6f0:	03 72 04             	add    0x4(%edx),%esi
 6f3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f6:	8b 10                	mov    (%eax),%edx
 6f8:	8b 12                	mov    (%edx),%edx
 6fa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6fd:	8b 50 04             	mov    0x4(%eax),%edx
 700:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 703:	39 f1                	cmp    %esi,%ecx
 705:	75 c6                	jne    6cd <free+0x3d>
    p->s.size += bp->s.size;
 707:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 70a:	a3 a0 0b 00 00       	mov    %eax,0xba0
    p->s.size += bp->s.size;
 70f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 712:	8b 53 f8             	mov    -0x8(%ebx),%edx
 715:	89 10                	mov    %edx,(%eax)
}
 717:	5b                   	pop    %ebx
 718:	5e                   	pop    %esi
 719:	5f                   	pop    %edi
 71a:	5d                   	pop    %ebp
 71b:	c3                   	ret    
 71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
 726:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 729:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 72c:	8b 15 a0 0b 00 00    	mov    0xba0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 732:	8d 78 07             	lea    0x7(%eax),%edi
 735:	c1 ef 03             	shr    $0x3,%edi
 738:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 73b:	85 d2                	test   %edx,%edx
 73d:	0f 84 9d 00 00 00    	je     7e0 <malloc+0xc0>
 743:	8b 02                	mov    (%edx),%eax
 745:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 748:	39 cf                	cmp    %ecx,%edi
 74a:	76 6c                	jbe    7b8 <malloc+0x98>
 74c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 752:	bb 00 10 00 00       	mov    $0x1000,%ebx
 757:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 75a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 761:	eb 0e                	jmp    771 <malloc+0x51>
 763:	90                   	nop
 764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 768:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 76a:	8b 48 04             	mov    0x4(%eax),%ecx
 76d:	39 f9                	cmp    %edi,%ecx
 76f:	73 47                	jae    7b8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 771:	39 05 a0 0b 00 00    	cmp    %eax,0xba0
 777:	89 c2                	mov    %eax,%edx
 779:	75 ed                	jne    768 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 77b:	83 ec 0c             	sub    $0xc,%esp
 77e:	56                   	push   %esi
 77f:	e8 de fb ff ff       	call   362 <sbrk>
  if(p == (char*)-1)
 784:	83 c4 10             	add    $0x10,%esp
 787:	83 f8 ff             	cmp    $0xffffffff,%eax
 78a:	74 1c                	je     7a8 <malloc+0x88>
  hp->s.size = nu;
 78c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 78f:	83 ec 0c             	sub    $0xc,%esp
 792:	83 c0 08             	add    $0x8,%eax
 795:	50                   	push   %eax
 796:	e8 f5 fe ff ff       	call   690 <free>
  return freep;
 79b:	8b 15 a0 0b 00 00    	mov    0xba0,%edx
      if((p = morecore(nunits)) == 0)
 7a1:	83 c4 10             	add    $0x10,%esp
 7a4:	85 d2                	test   %edx,%edx
 7a6:	75 c0                	jne    768 <malloc+0x48>
        return 0;
  }
}
 7a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7ab:	31 c0                	xor    %eax,%eax
}
 7ad:	5b                   	pop    %ebx
 7ae:	5e                   	pop    %esi
 7af:	5f                   	pop    %edi
 7b0:	5d                   	pop    %ebp
 7b1:	c3                   	ret    
 7b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7b8:	39 cf                	cmp    %ecx,%edi
 7ba:	74 54                	je     810 <malloc+0xf0>
        p->s.size -= nunits;
 7bc:	29 f9                	sub    %edi,%ecx
 7be:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7c1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7c4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7c7:	89 15 a0 0b 00 00    	mov    %edx,0xba0
}
 7cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7d0:	83 c0 08             	add    $0x8,%eax
}
 7d3:	5b                   	pop    %ebx
 7d4:	5e                   	pop    %esi
 7d5:	5f                   	pop    %edi
 7d6:	5d                   	pop    %ebp
 7d7:	c3                   	ret    
 7d8:	90                   	nop
 7d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 7e0:	c7 05 a0 0b 00 00 a4 	movl   $0xba4,0xba0
 7e7:	0b 00 00 
 7ea:	c7 05 a4 0b 00 00 a4 	movl   $0xba4,0xba4
 7f1:	0b 00 00 
    base.s.size = 0;
 7f4:	b8 a4 0b 00 00       	mov    $0xba4,%eax
 7f9:	c7 05 a8 0b 00 00 00 	movl   $0x0,0xba8
 800:	00 00 00 
 803:	e9 44 ff ff ff       	jmp    74c <malloc+0x2c>
 808:	90                   	nop
 809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 810:	8b 08                	mov    (%eax),%ecx
 812:	89 0a                	mov    %ecx,(%edx)
 814:	eb b1                	jmp    7c7 <malloc+0xa7>
