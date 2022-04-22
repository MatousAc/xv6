
user/_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  11:	e8 64 02 00 00       	call   27a <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 05                	push   $0x5
  1f:	e8 f6 02 00 00       	call   31a <sleep>
  24:	83 c4 10             	add    $0x10,%esp
  exit();
  27:	e8 56 02 00 00       	call   282 <exit>
  2c:	66 90                	xchg   %ax,%ax
  2e:	66 90                	xchg   %ax,%ax

00000030 <strcpy>:
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	53                   	push   %ebx
  34:	8b 45 08             	mov    0x8(%ebp),%eax
  37:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  3a:	89 c2                	mov    %eax,%edx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  40:	83 c1 01             	add    $0x1,%ecx
  43:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  47:	83 c2 01             	add    $0x1,%edx
  4a:	84 db                	test   %bl,%bl
  4c:	88 5a ff             	mov    %bl,-0x1(%edx)
  4f:	75 ef                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  51:	5b                   	pop    %ebx
  52:	5d                   	pop    %ebp
  53:	c3                   	ret    
  54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 55 08             	mov    0x8(%ebp),%edx
  67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  6a:	0f b6 02             	movzbl (%edx),%eax
  6d:	0f b6 19             	movzbl (%ecx),%ebx
  70:	84 c0                	test   %al,%al
  72:	75 1c                	jne    90 <strcmp+0x30>
  74:	eb 2a                	jmp    a0 <strcmp+0x40>
  76:	8d 76 00             	lea    0x0(%esi),%esi
  79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  80:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  83:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  86:	83 c1 01             	add    $0x1,%ecx
  89:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  8c:	84 c0                	test   %al,%al
  8e:	74 10                	je     a0 <strcmp+0x40>
  90:	38 d8                	cmp    %bl,%al
  92:	74 ec                	je     80 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  94:	29 d8                	sub    %ebx,%eax
}
  96:	5b                   	pop    %ebx
  97:	5d                   	pop    %ebp
  98:	c3                   	ret    
  99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  a0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  a2:	29 d8                	sub    %ebx,%eax
}
  a4:	5b                   	pop    %ebx
  a5:	5d                   	pop    %ebp
  a6:	c3                   	ret    
  a7:	89 f6                	mov    %esi,%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000b0 <strlen>:

uint
strlen(const char *s)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  b6:	80 39 00             	cmpb   $0x0,(%ecx)
  b9:	74 15                	je     d0 <strlen+0x20>
  bb:	31 d2                	xor    %edx,%edx
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  c0:	83 c2 01             	add    $0x1,%edx
  c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  c7:	89 d0                	mov    %edx,%eax
  c9:	75 f5                	jne    c0 <strlen+0x10>
    ;
  return n;
}
  cb:	5d                   	pop    %ebp
  cc:	c3                   	ret    
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
  d0:	31 c0                	xor    %eax,%eax
}
  d2:	5d                   	pop    %ebp
  d3:	c3                   	ret    
  d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	57                   	push   %edi
  e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  ed:	89 d7                	mov    %edx,%edi
  ef:	fc                   	cld    
  f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  f2:	89 d0                	mov    %edx,%eax
  f4:	5f                   	pop    %edi
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	53                   	push   %ebx
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 10a:	0f b6 10             	movzbl (%eax),%edx
 10d:	84 d2                	test   %dl,%dl
 10f:	74 1d                	je     12e <strchr+0x2e>
    if(*s == c)
 111:	38 d3                	cmp    %dl,%bl
 113:	89 d9                	mov    %ebx,%ecx
 115:	75 0d                	jne    124 <strchr+0x24>
 117:	eb 17                	jmp    130 <strchr+0x30>
 119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 120:	38 ca                	cmp    %cl,%dl
 122:	74 0c                	je     130 <strchr+0x30>
  for(; *s; s++)
 124:	83 c0 01             	add    $0x1,%eax
 127:	0f b6 10             	movzbl (%eax),%edx
 12a:	84 d2                	test   %dl,%dl
 12c:	75 f2                	jne    120 <strchr+0x20>
      return (char*)s;
  return 0;
 12e:	31 c0                	xor    %eax,%eax
}
 130:	5b                   	pop    %ebx
 131:	5d                   	pop    %ebp
 132:	c3                   	ret    
 133:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000140 <gets>:

char*
gets(char *buf, int max)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	56                   	push   %esi
 145:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 146:	31 f6                	xor    %esi,%esi
 148:	89 f3                	mov    %esi,%ebx
{
 14a:	83 ec 1c             	sub    $0x1c,%esp
 14d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 150:	eb 2f                	jmp    181 <gets+0x41>
 152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 158:	8d 45 e7             	lea    -0x19(%ebp),%eax
 15b:	83 ec 04             	sub    $0x4,%esp
 15e:	6a 01                	push   $0x1
 160:	50                   	push   %eax
 161:	6a 00                	push   $0x0
 163:	e8 32 01 00 00       	call   29a <read>
    if(cc < 1)
 168:	83 c4 10             	add    $0x10,%esp
 16b:	85 c0                	test   %eax,%eax
 16d:	7e 1c                	jle    18b <gets+0x4b>
      break;
    buf[i++] = c;
 16f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 173:	83 c7 01             	add    $0x1,%edi
 176:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 179:	3c 0a                	cmp    $0xa,%al
 17b:	74 23                	je     1a0 <gets+0x60>
 17d:	3c 0d                	cmp    $0xd,%al
 17f:	74 1f                	je     1a0 <gets+0x60>
  for(i=0; i+1 < max; ){
 181:	83 c3 01             	add    $0x1,%ebx
 184:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 187:	89 fe                	mov    %edi,%esi
 189:	7c cd                	jl     158 <gets+0x18>
 18b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 18d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 190:	c6 03 00             	movb   $0x0,(%ebx)
}
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
  buf[i] = '\0';
 1aa:	c6 03 00             	movb   $0x0,(%ebx)
}
 1ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1b0:	5b                   	pop    %ebx
 1b1:	5e                   	pop    %esi
 1b2:	5f                   	pop    %edi
 1b3:	5d                   	pop    %ebp
 1b4:	c3                   	ret    
 1b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	56                   	push   %esi
 1c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c5:	83 ec 08             	sub    $0x8,%esp
 1c8:	6a 00                	push   $0x0
 1ca:	ff 75 08             	pushl  0x8(%ebp)
 1cd:	e8 f8 00 00 00       	call   2ca <open>
  if(fd < 0)
 1d2:	83 c4 10             	add    $0x10,%esp
 1d5:	85 c0                	test   %eax,%eax
 1d7:	78 27                	js     200 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1d9:	83 ec 08             	sub    $0x8,%esp
 1dc:	ff 75 0c             	pushl  0xc(%ebp)
 1df:	89 c3                	mov    %eax,%ebx
 1e1:	50                   	push   %eax
 1e2:	e8 fb 00 00 00       	call   2e2 <fstat>
  close(fd);
 1e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1ea:	89 c6                	mov    %eax,%esi
  close(fd);
 1ec:	e8 c1 00 00 00       	call   2b2 <close>
  return r;
 1f1:	83 c4 10             	add    $0x10,%esp
}
 1f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1f7:	89 f0                	mov    %esi,%eax
 1f9:	5b                   	pop    %ebx
 1fa:	5e                   	pop    %esi
 1fb:	5d                   	pop    %ebp
 1fc:	c3                   	ret    
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 200:	be ff ff ff ff       	mov    $0xffffffff,%esi
 205:	eb ed                	jmp    1f4 <stat+0x34>
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <atoi>:

int
atoi(const char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 217:	0f be 11             	movsbl (%ecx),%edx
 21a:	8d 42 d0             	lea    -0x30(%edx),%eax
 21d:	3c 09                	cmp    $0x9,%al
  n = 0;
 21f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 224:	77 1f                	ja     245 <atoi+0x35>
 226:	8d 76 00             	lea    0x0(%esi),%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 230:	8d 04 80             	lea    (%eax,%eax,4),%eax
 233:	83 c1 01             	add    $0x1,%ecx
 236:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 23a:	0f be 11             	movsbl (%ecx),%edx
 23d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 240:	80 fb 09             	cmp    $0x9,%bl
 243:	76 eb                	jbe    230 <atoi+0x20>
  return n;
}
 245:	5b                   	pop    %ebx
 246:	5d                   	pop    %ebp
 247:	c3                   	ret    
 248:	90                   	nop
 249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000250 <memmove>:


void*
memmove(void *vdst, const void *vsrc, int n)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	56                   	push   %esi
 254:	53                   	push   %ebx
 255:	8b 5d 10             	mov    0x10(%ebp),%ebx
 258:	8b 45 08             	mov    0x8(%ebp),%eax
 25b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 25e:	85 db                	test   %ebx,%ebx
 260:	7e 14                	jle    276 <memmove+0x26>
 262:	31 d2                	xor    %edx,%edx
 264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 268:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 26c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 26f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 272:	39 d3                	cmp    %edx,%ebx
 274:	75 f2                	jne    268 <memmove+0x18>
  return vdst;
}
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

000002a2 <steal>:
SYSCALL(steal)
 2a2:	b8 17 00 00 00       	mov    $0x17,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <write>:
SYSCALL(write)
 2aa:	b8 10 00 00 00       	mov    $0x10,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <close>:
SYSCALL(close)
 2b2:	b8 15 00 00 00       	mov    $0x15,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <kill>:
SYSCALL(kill)
 2ba:	b8 06 00 00 00       	mov    $0x6,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <exec>:
SYSCALL(exec)
 2c2:	b8 07 00 00 00       	mov    $0x7,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <open>:
SYSCALL(open)
 2ca:	b8 0f 00 00 00       	mov    $0xf,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <mknod>:
SYSCALL(mknod)
 2d2:	b8 11 00 00 00       	mov    $0x11,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <unlink>:
SYSCALL(unlink)
 2da:	b8 12 00 00 00       	mov    $0x12,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <fstat>:
SYSCALL(fstat)
 2e2:	b8 08 00 00 00       	mov    $0x8,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <link>:
SYSCALL(link)
 2ea:	b8 13 00 00 00       	mov    $0x13,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <mkdir>:
SYSCALL(mkdir)
 2f2:	b8 14 00 00 00       	mov    $0x14,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <chdir>:
SYSCALL(chdir)
 2fa:	b8 09 00 00 00       	mov    $0x9,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <dup>:
SYSCALL(dup)
 302:	b8 0a 00 00 00       	mov    $0xa,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <getpid>:
SYSCALL(getpid)
 30a:	b8 0b 00 00 00       	mov    $0xb,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <sbrk>:
SYSCALL(sbrk)
 312:	b8 0c 00 00 00       	mov    $0xc,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <sleep>:
SYSCALL(sleep)
 31a:	b8 0d 00 00 00       	mov    $0xd,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <uptime>:
SYSCALL(uptime)
 322:	b8 0e 00 00 00       	mov    $0xe,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <cpuhalt>:
SYSCALL(cpuhalt)
 32a:	b8 16 00 00 00       	mov    $0x16,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    
 332:	66 90                	xchg   %ax,%ax
 334:	66 90                	xchg   %ax,%ax
 336:	66 90                	xchg   %ax,%ax
 338:	66 90                	xchg   %ax,%ax
 33a:	66 90                	xchg   %ax,%ax
 33c:	66 90                	xchg   %ax,%ax
 33e:	66 90                	xchg   %ax,%ax

00000340 <printint.constprop.1>:
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
}

static void
printint(int fd, int xx, int base, int sgn)
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	56                   	push   %esi
 345:	53                   	push   %ebx
 346:	89 d6                	mov    %edx,%esi
 348:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 34b:	85 c0                	test   %eax,%eax
 34d:	79 71                	jns    3c0 <printint.constprop.1+0x80>
 34f:	83 e1 01             	and    $0x1,%ecx
 352:	74 6c                	je     3c0 <printint.constprop.1+0x80>
    neg = 1;
    x = -xx;
 354:	f7 d8                	neg    %eax
    neg = 1;
 356:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 35d:	31 c9                	xor    %ecx,%ecx
 35f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 362:	eb 06                	jmp    36a <printint.constprop.1+0x2a>
 364:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 368:	89 f9                	mov    %edi,%ecx
 36a:	31 d2                	xor    %edx,%edx
 36c:	8d 79 01             	lea    0x1(%ecx),%edi
 36f:	f7 f6                	div    %esi
 371:	0f b6 92 d0 07 00 00 	movzbl 0x7d0(%edx),%edx
  }while((x /= base) != 0);
 378:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 37a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 37d:	75 e9                	jne    368 <printint.constprop.1+0x28>
  if(neg)
 37f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 382:	85 c0                	test   %eax,%eax
 384:	74 08                	je     38e <printint.constprop.1+0x4e>
    buf[i++] = '-';
 386:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 38b:	8d 79 02             	lea    0x2(%ecx),%edi
 38e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 398:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 39b:	83 ec 04             	sub    $0x4,%esp
 39e:	83 ee 01             	sub    $0x1,%esi
 3a1:	6a 01                	push   $0x1
 3a3:	53                   	push   %ebx
 3a4:	6a 01                	push   $0x1
 3a6:	88 45 d7             	mov    %al,-0x29(%ebp)
 3a9:	e8 fc fe ff ff       	call   2aa <write>

  while(--i >= 0)
 3ae:	83 c4 10             	add    $0x10,%esp
 3b1:	39 de                	cmp    %ebx,%esi
 3b3:	75 e3                	jne    398 <printint.constprop.1+0x58>
    putc(fd, buf[i]);
}
 3b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3b8:	5b                   	pop    %ebx
 3b9:	5e                   	pop    %esi
 3ba:	5f                   	pop    %edi
 3bb:	5d                   	pop    %ebp
 3bc:	c3                   	ret    
 3bd:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 3c0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3c7:	eb 94                	jmp    35d <printint.constprop.1+0x1d>
 3c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003d0 <vprintf.constprop.0>:
static void vprintf(int fd, const char *fmt, va_list ap)
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	56                   	push   %esi
 3d5:	53                   	push   %ebx
 3d6:	89 d6                	mov    %edx,%esi
 3d8:	83 ec 2c             	sub    $0x2c,%esp
{
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 3db:	0f b6 10             	movzbl (%eax),%edx
 3de:	84 d2                	test   %dl,%dl
 3e0:	0f 84 cd 00 00 00    	je     4b3 <vprintf.constprop.0+0xe3>
 3e6:	8d 58 01             	lea    0x1(%eax),%ebx
  state = 0;
 3e9:	31 ff                	xor    %edi,%edi
 3eb:	eb 31                	jmp    41e <vprintf.constprop.0+0x4e>
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3f0:	83 f8 25             	cmp    $0x25,%eax
 3f3:	0f 84 c7 00 00 00    	je     4c0 <vprintf.constprop.0+0xf0>
  write(fd, &c, 1);
 3f9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 3fc:	83 ec 04             	sub    $0x4,%esp
 3ff:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 402:	6a 01                	push   $0x1
 404:	50                   	push   %eax
 405:	6a 01                	push   $0x1
 407:	e8 9e fe ff ff       	call   2aa <write>
 40c:	83 c4 10             	add    $0x10,%esp
 40f:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 412:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 416:	84 d2                	test   %dl,%dl
 418:	0f 84 95 00 00 00    	je     4b3 <vprintf.constprop.0+0xe3>
    if(state == 0){
 41e:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 420:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 423:	74 cb                	je     3f0 <vprintf.constprop.0+0x20>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 425:	83 ff 25             	cmp    $0x25,%edi
 428:	75 e5                	jne    40f <vprintf.constprop.0+0x3f>
      if(c == 'd'){
 42a:	83 f8 64             	cmp    $0x64,%eax
        printint(fd, va_arg(ap, int), 10, 1);
 42d:	8d 7e 04             	lea    0x4(%esi),%edi
 430:	b9 01 00 00 00       	mov    $0x1,%ecx
      if(c == 'd'){
 435:	0f 84 9a 00 00 00    	je     4d5 <vprintf.constprop.0+0x105>
      } else if(c == 'l') {
 43b:	83 f8 6c             	cmp    $0x6c,%eax
 43e:	0f 84 8c 00 00 00    	je     4d0 <vprintf.constprop.0+0x100>
        printint(fd, va_arg(ap, uint), 10, 0);
      } else if(c == 'x') {
 444:	83 f8 78             	cmp    $0x78,%eax
 447:	0f 84 a3 00 00 00    	je     4f0 <vprintf.constprop.0+0x120>
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 44d:	83 f8 70             	cmp    $0x70,%eax
 450:	0f 84 ca 00 00 00    	je     520 <vprintf.constprop.0+0x150>
        printptr(fd, va_arg(ap, uint));
      } else if(c == 's'){
 456:	83 f8 73             	cmp    $0x73,%eax
 459:	0f 84 39 01 00 00    	je     598 <vprintf.constprop.0+0x1c8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 45f:	83 f8 63             	cmp    $0x63,%eax
 462:	0f 84 68 01 00 00    	je     5d0 <vprintf.constprop.0+0x200>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 468:	83 f8 25             	cmp    $0x25,%eax
 46b:	0f 84 9f 00 00 00    	je     510 <vprintf.constprop.0+0x140>
  write(fd, &c, 1);
 471:	8d 45 df             	lea    -0x21(%ebp),%eax
 474:	83 ec 04             	sub    $0x4,%esp
 477:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 47a:	6a 01                	push   $0x1
 47c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 480:	50                   	push   %eax
 481:	6a 01                	push   $0x1
 483:	e8 22 fe ff ff       	call   2aa <write>
 488:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 48c:	83 c4 0c             	add    $0xc,%esp
 48f:	8d 45 e0             	lea    -0x20(%ebp),%eax
 492:	6a 01                	push   $0x1
 494:	88 55 e0             	mov    %dl,-0x20(%ebp)
 497:	50                   	push   %eax
 498:	6a 01                	push   $0x1
 49a:	83 c3 01             	add    $0x1,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 49d:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 49f:	e8 06 fe ff ff       	call   2aa <write>
  for(i = 0; fmt[i]; i++){
 4a4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
  write(fd, &c, 1);
 4a8:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4ab:	84 d2                	test   %dl,%dl
 4ad:	0f 85 6b ff ff ff    	jne    41e <vprintf.constprop.0+0x4e>
    }
  }
}
 4b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4b6:	5b                   	pop    %ebx
 4b7:	5e                   	pop    %esi
 4b8:	5f                   	pop    %edi
 4b9:	5d                   	pop    %ebp
 4ba:	c3                   	ret    
 4bb:	90                   	nop
 4bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        state = '%';
 4c0:	bf 25 00 00 00       	mov    $0x25,%edi
 4c5:	e9 45 ff ff ff       	jmp    40f <vprintf.constprop.0+0x3f>
 4ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, uint), 10, 0);
 4d0:	8d 7e 04             	lea    0x4(%esi),%edi
 4d3:	31 c9                	xor    %ecx,%ecx
 4d5:	8b 06                	mov    (%esi),%eax
 4d7:	ba 0a 00 00 00       	mov    $0xa,%edx
 4dc:	89 fe                	mov    %edi,%esi
      state = 0;
 4de:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, uint), 10, 0);
 4e0:	e8 5b fe ff ff       	call   340 <printint.constprop.1>
 4e5:	e9 25 ff ff ff       	jmp    40f <vprintf.constprop.0+0x3f>
 4ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, int), 16, 0);
 4f0:	8b 06                	mov    (%esi),%eax
 4f2:	8d 7e 04             	lea    0x4(%esi),%edi
 4f5:	31 c9                	xor    %ecx,%ecx
 4f7:	ba 10 00 00 00       	mov    $0x10,%edx
 4fc:	89 fe                	mov    %edi,%esi
      state = 0;
 4fe:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, int), 16, 0);
 500:	e8 3b fe ff ff       	call   340 <printint.constprop.1>
 505:	e9 05 ff ff ff       	jmp    40f <vprintf.constprop.0+0x3f>
 50a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 510:	83 ec 04             	sub    $0x4,%esp
 513:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 516:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 519:	6a 01                	push   $0x1
 51b:	e9 77 ff ff ff       	jmp    497 <vprintf.constprop.0+0xc7>
        printptr(fd, va_arg(ap, uint));
 520:	8d 46 04             	lea    0x4(%esi),%eax
  write(fd, &c, 1);
 523:	83 ec 04             	sub    $0x4,%esp
        printptr(fd, va_arg(ap, uint));
 526:	8b 3e                	mov    (%esi),%edi
  write(fd, &c, 1);
 528:	6a 01                	push   $0x1
 52a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 52e:	be 08 00 00 00       	mov    $0x8,%esi
        printptr(fd, va_arg(ap, uint));
 533:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 536:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 539:	50                   	push   %eax
 53a:	6a 01                	push   $0x1
 53c:	e8 69 fd ff ff       	call   2aa <write>
 541:	8d 45 e7             	lea    -0x19(%ebp),%eax
 544:	83 c4 0c             	add    $0xc,%esp
 547:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 54b:	6a 01                	push   $0x1
 54d:	50                   	push   %eax
 54e:	6a 01                	push   $0x1
 550:	e8 55 fd ff ff       	call   2aa <write>
 555:	83 c4 10             	add    $0x10,%esp
 558:	90                   	nop
 559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
 560:	89 f8                	mov    %edi,%eax
  write(fd, &c, 1);
 562:	83 ec 04             	sub    $0x4,%esp
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
 565:	c1 e7 04             	shl    $0x4,%edi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
 568:	c1 e8 1c             	shr    $0x1c,%eax
  write(fd, &c, 1);
 56b:	6a 01                	push   $0x1
 56d:	0f b6 80 d0 07 00 00 	movzbl 0x7d0(%eax),%eax
 574:	88 45 e5             	mov    %al,-0x1b(%ebp)
 577:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 57a:	50                   	push   %eax
 57b:	6a 01                	push   $0x1
 57d:	e8 28 fd ff ff       	call   2aa <write>
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
 582:	83 c4 10             	add    $0x10,%esp
 585:	83 ee 01             	sub    $0x1,%esi
 588:	75 d6                	jne    560 <vprintf.constprop.0+0x190>
        s = va_arg(ap, char*);
 58a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 58d:	31 ff                	xor    %edi,%edi
 58f:	e9 7b fe ff ff       	jmp    40f <vprintf.constprop.0+0x3f>
 594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = va_arg(ap, char*);
 598:	8b 3e                	mov    (%esi),%edi
 59a:	8d 46 04             	lea    0x4(%esi),%eax
 59d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 5a0:	85 ff                	test   %edi,%edi
 5a2:	74 50                	je     5f4 <vprintf.constprop.0+0x224>
        while(*s != 0){
 5a4:	0f b6 07             	movzbl (%edi),%eax
 5a7:	84 c0                	test   %al,%al
 5a9:	74 df                	je     58a <vprintf.constprop.0+0x1ba>
 5ab:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 5ae:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 5b0:	83 ec 04             	sub    $0x4,%esp
          s++;
 5b3:	83 c7 01             	add    $0x1,%edi
 5b6:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 5b9:	6a 01                	push   $0x1
 5bb:	56                   	push   %esi
 5bc:	6a 01                	push   $0x1
 5be:	e8 e7 fc ff ff       	call   2aa <write>
        while(*s != 0){
 5c3:	0f b6 07             	movzbl (%edi),%eax
 5c6:	83 c4 10             	add    $0x10,%esp
 5c9:	84 c0                	test   %al,%al
 5cb:	75 e3                	jne    5b0 <vprintf.constprop.0+0x1e0>
 5cd:	eb bb                	jmp    58a <vprintf.constprop.0+0x1ba>
 5cf:	90                   	nop
        putc(fd, va_arg(ap, uint));
 5d0:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 5d2:	83 ec 04             	sub    $0x4,%esp
        putc(fd, va_arg(ap, uint));
 5d5:	8d 7e 04             	lea    0x4(%esi),%edi
  write(fd, &c, 1);
 5d8:	6a 01                	push   $0x1
        putc(fd, va_arg(ap, uint));
 5da:	89 fe                	mov    %edi,%esi
      state = 0;
 5dc:	31 ff                	xor    %edi,%edi
        putc(fd, va_arg(ap, uint));
 5de:	88 45 e2             	mov    %al,-0x1e(%ebp)
  write(fd, &c, 1);
 5e1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5e4:	50                   	push   %eax
 5e5:	6a 01                	push   $0x1
 5e7:	e8 be fc ff ff       	call   2aa <write>
 5ec:	83 c4 10             	add    $0x10,%esp
 5ef:	e9 1b fe ff ff       	jmp    40f <vprintf.constprop.0+0x3f>
          s = "(null)";
 5f4:	bf c8 07 00 00       	mov    $0x7c8,%edi
        while(*s != 0){
 5f9:	b8 28 00 00 00       	mov    $0x28,%eax
 5fe:	eb ab                	jmp    5ab <vprintf.constprop.0+0x1db>

00000600 <fprintf>:
// Print to the given fd. Only understands %d,%x, %p, %s, %c.
void
fprintf(int fd, const char *fmt, ...)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	83 ec 08             	sub    $0x8,%esp
 va_list ap;
 va_start(ap, fmt); 
 vprintf(1,fmt,ap);
 606:	8b 45 0c             	mov    0xc(%ebp),%eax
 609:	8d 55 10             	lea    0x10(%ebp),%edx
 60c:	e8 bf fd ff ff       	call   3d0 <vprintf.constprop.0>
}
 611:	c9                   	leave  
 612:	c3                   	ret    
 613:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000620 <printf>:
void
printf(const char *fmt, ...)
{
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	83 ec 08             	sub    $0x8,%esp
  va_list ap;
  va_start(ap, fmt); 
  vprintf(1,fmt,ap);
 626:	8b 45 08             	mov    0x8(%ebp),%eax
 629:	8d 55 0c             	lea    0xc(%ebp),%edx
 62c:	e8 9f fd ff ff       	call   3d0 <vprintf.constprop.0>
}
 631:	c9                   	leave  
 632:	c3                   	ret    
 633:	66 90                	xchg   %ax,%ax
 635:	66 90                	xchg   %ax,%ax
 637:	66 90                	xchg   %ax,%ax
 639:	66 90                	xchg   %ax,%ax
 63b:	66 90                	xchg   %ax,%ax
 63d:	66 90                	xchg   %ax,%ax
 63f:	90                   	nop

00000640 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 640:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 641:	a1 b4 0a 00 00       	mov    0xab4,%eax
{
 646:	89 e5                	mov    %esp,%ebp
 648:	57                   	push   %edi
 649:	56                   	push   %esi
 64a:	53                   	push   %ebx
 64b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 64e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 658:	39 c8                	cmp    %ecx,%eax
 65a:	8b 10                	mov    (%eax),%edx
 65c:	73 32                	jae    690 <free+0x50>
 65e:	39 d1                	cmp    %edx,%ecx
 660:	72 04                	jb     666 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 662:	39 d0                	cmp    %edx,%eax
 664:	72 32                	jb     698 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 666:	8b 73 fc             	mov    -0x4(%ebx),%esi
 669:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 66c:	39 fa                	cmp    %edi,%edx
 66e:	74 30                	je     6a0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 670:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 673:	8b 50 04             	mov    0x4(%eax),%edx
 676:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 679:	39 f1                	cmp    %esi,%ecx
 67b:	74 3a                	je     6b7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 67d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 67f:	a3 b4 0a 00 00       	mov    %eax,0xab4
}
 684:	5b                   	pop    %ebx
 685:	5e                   	pop    %esi
 686:	5f                   	pop    %edi
 687:	5d                   	pop    %ebp
 688:	c3                   	ret    
 689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 690:	39 d0                	cmp    %edx,%eax
 692:	72 04                	jb     698 <free+0x58>
 694:	39 d1                	cmp    %edx,%ecx
 696:	72 ce                	jb     666 <free+0x26>
{
 698:	89 d0                	mov    %edx,%eax
 69a:	eb bc                	jmp    658 <free+0x18>
 69c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 6a0:	03 72 04             	add    0x4(%edx),%esi
 6a3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6a6:	8b 10                	mov    (%eax),%edx
 6a8:	8b 12                	mov    (%edx),%edx
 6aa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6ad:	8b 50 04             	mov    0x4(%eax),%edx
 6b0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6b3:	39 f1                	cmp    %esi,%ecx
 6b5:	75 c6                	jne    67d <free+0x3d>
    p->s.size += bp->s.size;
 6b7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6ba:	a3 b4 0a 00 00       	mov    %eax,0xab4
    p->s.size += bp->s.size;
 6bf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6c2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6c5:	89 10                	mov    %edx,(%eax)
}
 6c7:	5b                   	pop    %ebx
 6c8:	5e                   	pop    %esi
 6c9:	5f                   	pop    %edi
 6ca:	5d                   	pop    %ebp
 6cb:	c3                   	ret    
 6cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	57                   	push   %edi
 6d4:	56                   	push   %esi
 6d5:	53                   	push   %ebx
 6d6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6dc:	8b 15 b4 0a 00 00    	mov    0xab4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e2:	8d 78 07             	lea    0x7(%eax),%edi
 6e5:	c1 ef 03             	shr    $0x3,%edi
 6e8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6eb:	85 d2                	test   %edx,%edx
 6ed:	0f 84 9d 00 00 00    	je     790 <malloc+0xc0>
 6f3:	8b 02                	mov    (%edx),%eax
 6f5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6f8:	39 cf                	cmp    %ecx,%edi
 6fa:	76 6c                	jbe    768 <malloc+0x98>
 6fc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 702:	bb 00 10 00 00       	mov    $0x1000,%ebx
 707:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 70a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 711:	eb 0e                	jmp    721 <malloc+0x51>
 713:	90                   	nop
 714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 718:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 71a:	8b 48 04             	mov    0x4(%eax),%ecx
 71d:	39 f9                	cmp    %edi,%ecx
 71f:	73 47                	jae    768 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 721:	39 05 b4 0a 00 00    	cmp    %eax,0xab4
 727:	89 c2                	mov    %eax,%edx
 729:	75 ed                	jne    718 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 72b:	83 ec 0c             	sub    $0xc,%esp
 72e:	56                   	push   %esi
 72f:	e8 de fb ff ff       	call   312 <sbrk>
  if(p == (char*)-1)
 734:	83 c4 10             	add    $0x10,%esp
 737:	83 f8 ff             	cmp    $0xffffffff,%eax
 73a:	74 1c                	je     758 <malloc+0x88>
  hp->s.size = nu;
 73c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 73f:	83 ec 0c             	sub    $0xc,%esp
 742:	83 c0 08             	add    $0x8,%eax
 745:	50                   	push   %eax
 746:	e8 f5 fe ff ff       	call   640 <free>
  return freep;
 74b:	8b 15 b4 0a 00 00    	mov    0xab4,%edx
      if((p = morecore(nunits)) == 0)
 751:	83 c4 10             	add    $0x10,%esp
 754:	85 d2                	test   %edx,%edx
 756:	75 c0                	jne    718 <malloc+0x48>
        return 0;
  }
}
 758:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 75b:	31 c0                	xor    %eax,%eax
}
 75d:	5b                   	pop    %ebx
 75e:	5e                   	pop    %esi
 75f:	5f                   	pop    %edi
 760:	5d                   	pop    %ebp
 761:	c3                   	ret    
 762:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 768:	39 cf                	cmp    %ecx,%edi
 76a:	74 54                	je     7c0 <malloc+0xf0>
        p->s.size -= nunits;
 76c:	29 f9                	sub    %edi,%ecx
 76e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 771:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 774:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 777:	89 15 b4 0a 00 00    	mov    %edx,0xab4
}
 77d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 780:	83 c0 08             	add    $0x8,%eax
}
 783:	5b                   	pop    %ebx
 784:	5e                   	pop    %esi
 785:	5f                   	pop    %edi
 786:	5d                   	pop    %ebp
 787:	c3                   	ret    
 788:	90                   	nop
 789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 790:	c7 05 b4 0a 00 00 b8 	movl   $0xab8,0xab4
 797:	0a 00 00 
 79a:	c7 05 b8 0a 00 00 b8 	movl   $0xab8,0xab8
 7a1:	0a 00 00 
    base.s.size = 0;
 7a4:	b8 b8 0a 00 00       	mov    $0xab8,%eax
 7a9:	c7 05 bc 0a 00 00 00 	movl   $0x0,0xabc
 7b0:	00 00 00 
 7b3:	e9 44 ff ff ff       	jmp    6fc <malloc+0x2c>
 7b8:	90                   	nop
 7b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 7c0:	8b 08                	mov    (%eax),%ecx
 7c2:	89 0a                	mov    %ecx,(%edx)
 7c4:	eb b1                	jmp    777 <malloc+0xa7>
