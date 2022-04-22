
user/_shutdown:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user.h"

int main(int argc, char *argv[]){
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 0c             	sub    $0xc,%esp
  11:	8b 41 04             	mov    0x4(%ecx),%eax
    // while(i < 5000){
    //     i++;
    //     //fprintf(1,"%d\n",i);
    // }
    // i = 5; 
    if(strcmp(argv[1],"-now")==0){
  14:	68 08 08 00 00       	push   $0x808
  19:	ff 70 04             	pushl  0x4(%eax)
  1c:	e8 7f 00 00 00       	call   a0 <strcmp>
  21:	83 c4 10             	add    $0x10,%esp
  24:	85 c0                	test   %eax,%eax
  26:	74 35                	je     5d <main+0x5d>
        cpuhalt();
    }
    printf("Shutting Down in 5 seconds\n");
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	68 0d 08 00 00       	push   $0x80d
  30:	e8 2b 06 00 00       	call   660 <printf>
    if(fork()==0){
  35:	e8 80 02 00 00       	call   2ba <fork>
  3a:	83 c4 10             	add    $0x10,%esp
  3d:	85 c0                	test   %eax,%eax
  3f:	75 23                	jne    64 <main+0x64>
        sleep(500);
  41:	83 ec 0c             	sub    $0xc,%esp
  44:	68 f4 01 00 00       	push   $0x1f4
  49:	e8 0c 03 00 00       	call   35a <sleep>

        cpuhalt();
  4e:	e8 17 03 00 00       	call   36a <cpuhalt>
    }
    else{
        exit();
    }
    
  53:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  56:	31 c0                	xor    %eax,%eax
  58:	c9                   	leave  
  59:	8d 61 fc             	lea    -0x4(%ecx),%esp
  5c:	c3                   	ret    
        cpuhalt();
  5d:	e8 08 03 00 00       	call   36a <cpuhalt>
  62:	eb c4                	jmp    28 <main+0x28>
        exit();
  64:	e8 59 02 00 00       	call   2c2 <exit>
  69:	66 90                	xchg   %ax,%ax
  6b:	66 90                	xchg   %ax,%ax
  6d:	66 90                	xchg   %ax,%ax
  6f:	90                   	nop

00000070 <strcpy>:
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	8b 45 08             	mov    0x8(%ebp),%eax
  77:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7a:	89 c2                	mov    %eax,%edx
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  80:	83 c1 01             	add    $0x1,%ecx
  83:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  87:	83 c2 01             	add    $0x1,%edx
  8a:	84 db                	test   %bl,%bl
  8c:	88 5a ff             	mov    %bl,-0x1(%edx)
  8f:	75 ef                	jne    80 <strcpy+0x10>
    ;
  return os;
}
  91:	5b                   	pop    %ebx
  92:	5d                   	pop    %ebp
  93:	c3                   	ret    
  94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	53                   	push   %ebx
  a4:	8b 55 08             	mov    0x8(%ebp),%edx
  a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  aa:	0f b6 02             	movzbl (%edx),%eax
  ad:	0f b6 19             	movzbl (%ecx),%ebx
  b0:	84 c0                	test   %al,%al
  b2:	75 1c                	jne    d0 <strcmp+0x30>
  b4:	eb 2a                	jmp    e0 <strcmp+0x40>
  b6:	8d 76 00             	lea    0x0(%esi),%esi
  b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  c0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  c3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  c6:	83 c1 01             	add    $0x1,%ecx
  c9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  cc:	84 c0                	test   %al,%al
  ce:	74 10                	je     e0 <strcmp+0x40>
  d0:	38 d8                	cmp    %bl,%al
  d2:	74 ec                	je     c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  d4:	29 d8                	sub    %ebx,%eax
}
  d6:	5b                   	pop    %ebx
  d7:	5d                   	pop    %ebp
  d8:	c3                   	ret    
  d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  e0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  e2:	29 d8                	sub    %ebx,%eax
}
  e4:	5b                   	pop    %ebx
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	89 f6                	mov    %esi,%esi
  e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000f0 <strlen>:

uint
strlen(const char *s)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  f6:	80 39 00             	cmpb   $0x0,(%ecx)
  f9:	74 15                	je     110 <strlen+0x20>
  fb:	31 d2                	xor    %edx,%edx
  fd:	8d 76 00             	lea    0x0(%esi),%esi
 100:	83 c2 01             	add    $0x1,%edx
 103:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 107:	89 d0                	mov    %edx,%eax
 109:	75 f5                	jne    100 <strlen+0x10>
    ;
  return n;
}
 10b:	5d                   	pop    %ebp
 10c:	c3                   	ret    
 10d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 110:	31 c0                	xor    %eax,%eax
}
 112:	5d                   	pop    %ebp
 113:	c3                   	ret    
 114:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 11a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000120 <memset>:

void*
memset(void *dst, int c, uint n)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 127:	8b 4d 10             	mov    0x10(%ebp),%ecx
 12a:	8b 45 0c             	mov    0xc(%ebp),%eax
 12d:	89 d7                	mov    %edx,%edi
 12f:	fc                   	cld    
 130:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 132:	89 d0                	mov    %edx,%eax
 134:	5f                   	pop    %edi
 135:	5d                   	pop    %ebp
 136:	c3                   	ret    
 137:	89 f6                	mov    %esi,%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000140 <strchr>:

char*
strchr(const char *s, char c)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 45 08             	mov    0x8(%ebp),%eax
 147:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 14a:	0f b6 10             	movzbl (%eax),%edx
 14d:	84 d2                	test   %dl,%dl
 14f:	74 1d                	je     16e <strchr+0x2e>
    if(*s == c)
 151:	38 d3                	cmp    %dl,%bl
 153:	89 d9                	mov    %ebx,%ecx
 155:	75 0d                	jne    164 <strchr+0x24>
 157:	eb 17                	jmp    170 <strchr+0x30>
 159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 160:	38 ca                	cmp    %cl,%dl
 162:	74 0c                	je     170 <strchr+0x30>
  for(; *s; s++)
 164:	83 c0 01             	add    $0x1,%eax
 167:	0f b6 10             	movzbl (%eax),%edx
 16a:	84 d2                	test   %dl,%dl
 16c:	75 f2                	jne    160 <strchr+0x20>
      return (char*)s;
  return 0;
 16e:	31 c0                	xor    %eax,%eax
}
 170:	5b                   	pop    %ebx
 171:	5d                   	pop    %ebp
 172:	c3                   	ret    
 173:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000180 <gets>:

char*
gets(char *buf, int max)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	57                   	push   %edi
 184:	56                   	push   %esi
 185:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 186:	31 f6                	xor    %esi,%esi
 188:	89 f3                	mov    %esi,%ebx
{
 18a:	83 ec 1c             	sub    $0x1c,%esp
 18d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 190:	eb 2f                	jmp    1c1 <gets+0x41>
 192:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 198:	8d 45 e7             	lea    -0x19(%ebp),%eax
 19b:	83 ec 04             	sub    $0x4,%esp
 19e:	6a 01                	push   $0x1
 1a0:	50                   	push   %eax
 1a1:	6a 00                	push   $0x0
 1a3:	e8 32 01 00 00       	call   2da <read>
    if(cc < 1)
 1a8:	83 c4 10             	add    $0x10,%esp
 1ab:	85 c0                	test   %eax,%eax
 1ad:	7e 1c                	jle    1cb <gets+0x4b>
      break;
    buf[i++] = c;
 1af:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1b3:	83 c7 01             	add    $0x1,%edi
 1b6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1b9:	3c 0a                	cmp    $0xa,%al
 1bb:	74 23                	je     1e0 <gets+0x60>
 1bd:	3c 0d                	cmp    $0xd,%al
 1bf:	74 1f                	je     1e0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1c1:	83 c3 01             	add    $0x1,%ebx
 1c4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1c7:	89 fe                	mov    %edi,%esi
 1c9:	7c cd                	jl     198 <gets+0x18>
 1cb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1cd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1d0:	c6 03 00             	movb   $0x0,(%ebx)
}
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
  buf[i] = '\0';
 1ea:	c6 03 00             	movb   $0x0,(%ebx)
}
 1ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1f0:	5b                   	pop    %ebx
 1f1:	5e                   	pop    %esi
 1f2:	5f                   	pop    %edi
 1f3:	5d                   	pop    %ebp
 1f4:	c3                   	ret    
 1f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	56                   	push   %esi
 204:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 205:	83 ec 08             	sub    $0x8,%esp
 208:	6a 00                	push   $0x0
 20a:	ff 75 08             	pushl  0x8(%ebp)
 20d:	e8 f8 00 00 00       	call   30a <open>
  if(fd < 0)
 212:	83 c4 10             	add    $0x10,%esp
 215:	85 c0                	test   %eax,%eax
 217:	78 27                	js     240 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 219:	83 ec 08             	sub    $0x8,%esp
 21c:	ff 75 0c             	pushl  0xc(%ebp)
 21f:	89 c3                	mov    %eax,%ebx
 221:	50                   	push   %eax
 222:	e8 fb 00 00 00       	call   322 <fstat>
  close(fd);
 227:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 22a:	89 c6                	mov    %eax,%esi
  close(fd);
 22c:	e8 c1 00 00 00       	call   2f2 <close>
  return r;
 231:	83 c4 10             	add    $0x10,%esp
}
 234:	8d 65 f8             	lea    -0x8(%ebp),%esp
 237:	89 f0                	mov    %esi,%eax
 239:	5b                   	pop    %ebx
 23a:	5e                   	pop    %esi
 23b:	5d                   	pop    %ebp
 23c:	c3                   	ret    
 23d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 240:	be ff ff ff ff       	mov    $0xffffffff,%esi
 245:	eb ed                	jmp    234 <stat+0x34>
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <atoi>:

int
atoi(const char *s)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 257:	0f be 11             	movsbl (%ecx),%edx
 25a:	8d 42 d0             	lea    -0x30(%edx),%eax
 25d:	3c 09                	cmp    $0x9,%al
  n = 0;
 25f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 264:	77 1f                	ja     285 <atoi+0x35>
 266:	8d 76 00             	lea    0x0(%esi),%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 270:	8d 04 80             	lea    (%eax,%eax,4),%eax
 273:	83 c1 01             	add    $0x1,%ecx
 276:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 27a:	0f be 11             	movsbl (%ecx),%edx
 27d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 280:	80 fb 09             	cmp    $0x9,%bl
 283:	76 eb                	jbe    270 <atoi+0x20>
  return n;
}
 285:	5b                   	pop    %ebx
 286:	5d                   	pop    %ebp
 287:	c3                   	ret    
 288:	90                   	nop
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000290 <memmove>:


void*
memmove(void *vdst, const void *vsrc, int n)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
 295:	8b 5d 10             	mov    0x10(%ebp),%ebx
 298:	8b 45 08             	mov    0x8(%ebp),%eax
 29b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 29e:	85 db                	test   %ebx,%ebx
 2a0:	7e 14                	jle    2b6 <memmove+0x26>
 2a2:	31 d2                	xor    %edx,%edx
 2a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 2a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2af:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2b2:	39 d3                	cmp    %edx,%ebx
 2b4:	75 f2                	jne    2a8 <memmove+0x18>
  return vdst;
}
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

000002e2 <steal>:
SYSCALL(steal)
 2e2:	b8 17 00 00 00       	mov    $0x17,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <write>:
SYSCALL(write)
 2ea:	b8 10 00 00 00       	mov    $0x10,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <close>:
SYSCALL(close)
 2f2:	b8 15 00 00 00       	mov    $0x15,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <kill>:
SYSCALL(kill)
 2fa:	b8 06 00 00 00       	mov    $0x6,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <exec>:
SYSCALL(exec)
 302:	b8 07 00 00 00       	mov    $0x7,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <open>:
SYSCALL(open)
 30a:	b8 0f 00 00 00       	mov    $0xf,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <mknod>:
SYSCALL(mknod)
 312:	b8 11 00 00 00       	mov    $0x11,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <unlink>:
SYSCALL(unlink)
 31a:	b8 12 00 00 00       	mov    $0x12,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <fstat>:
SYSCALL(fstat)
 322:	b8 08 00 00 00       	mov    $0x8,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <link>:
SYSCALL(link)
 32a:	b8 13 00 00 00       	mov    $0x13,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <mkdir>:
SYSCALL(mkdir)
 332:	b8 14 00 00 00       	mov    $0x14,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <chdir>:
SYSCALL(chdir)
 33a:	b8 09 00 00 00       	mov    $0x9,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <dup>:
SYSCALL(dup)
 342:	b8 0a 00 00 00       	mov    $0xa,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <getpid>:
SYSCALL(getpid)
 34a:	b8 0b 00 00 00       	mov    $0xb,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <sbrk>:
SYSCALL(sbrk)
 352:	b8 0c 00 00 00       	mov    $0xc,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <sleep>:
SYSCALL(sleep)
 35a:	b8 0d 00 00 00       	mov    $0xd,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <uptime>:
SYSCALL(uptime)
 362:	b8 0e 00 00 00       	mov    $0xe,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <cpuhalt>:
SYSCALL(cpuhalt)
 36a:	b8 16 00 00 00       	mov    $0x16,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    
 372:	66 90                	xchg   %ax,%ax
 374:	66 90                	xchg   %ax,%ax
 376:	66 90                	xchg   %ax,%ax
 378:	66 90                	xchg   %ax,%ax
 37a:	66 90                	xchg   %ax,%ax
 37c:	66 90                	xchg   %ax,%ax
 37e:	66 90                	xchg   %ax,%ax

00000380 <printint.constprop.1>:
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
}

static void
printint(int fd, int xx, int base, int sgn)
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	53                   	push   %ebx
 386:	89 d6                	mov    %edx,%esi
 388:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 38b:	85 c0                	test   %eax,%eax
 38d:	79 71                	jns    400 <printint.constprop.1+0x80>
 38f:	83 e1 01             	and    $0x1,%ecx
 392:	74 6c                	je     400 <printint.constprop.1+0x80>
    neg = 1;
    x = -xx;
 394:	f7 d8                	neg    %eax
    neg = 1;
 396:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 39d:	31 c9                	xor    %ecx,%ecx
 39f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3a2:	eb 06                	jmp    3aa <printint.constprop.1+0x2a>
 3a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 3a8:	89 f9                	mov    %edi,%ecx
 3aa:	31 d2                	xor    %edx,%edx
 3ac:	8d 79 01             	lea    0x1(%ecx),%edi
 3af:	f7 f6                	div    %esi
 3b1:	0f b6 92 30 08 00 00 	movzbl 0x830(%edx),%edx
  }while((x /= base) != 0);
 3b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 3ba:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 3bd:	75 e9                	jne    3a8 <printint.constprop.1+0x28>
  if(neg)
 3bf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3c2:	85 c0                	test   %eax,%eax
 3c4:	74 08                	je     3ce <printint.constprop.1+0x4e>
    buf[i++] = '-';
 3c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 3cb:	8d 79 02             	lea    0x2(%ecx),%edi
 3ce:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 3d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3d8:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 3db:	83 ec 04             	sub    $0x4,%esp
 3de:	83 ee 01             	sub    $0x1,%esi
 3e1:	6a 01                	push   $0x1
 3e3:	53                   	push   %ebx
 3e4:	6a 01                	push   $0x1
 3e6:	88 45 d7             	mov    %al,-0x29(%ebp)
 3e9:	e8 fc fe ff ff       	call   2ea <write>

  while(--i >= 0)
 3ee:	83 c4 10             	add    $0x10,%esp
 3f1:	39 de                	cmp    %ebx,%esi
 3f3:	75 e3                	jne    3d8 <printint.constprop.1+0x58>
    putc(fd, buf[i]);
}
 3f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3f8:	5b                   	pop    %ebx
 3f9:	5e                   	pop    %esi
 3fa:	5f                   	pop    %edi
 3fb:	5d                   	pop    %ebp
 3fc:	c3                   	ret    
 3fd:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 400:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 407:	eb 94                	jmp    39d <printint.constprop.1+0x1d>
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000410 <vprintf.constprop.0>:
static void vprintf(int fd, const char *fmt, va_list ap)
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	89 d6                	mov    %edx,%esi
 418:	83 ec 2c             	sub    $0x2c,%esp
{
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 41b:	0f b6 10             	movzbl (%eax),%edx
 41e:	84 d2                	test   %dl,%dl
 420:	0f 84 cd 00 00 00    	je     4f3 <vprintf.constprop.0+0xe3>
 426:	8d 58 01             	lea    0x1(%eax),%ebx
  state = 0;
 429:	31 ff                	xor    %edi,%edi
 42b:	eb 31                	jmp    45e <vprintf.constprop.0+0x4e>
 42d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 430:	83 f8 25             	cmp    $0x25,%eax
 433:	0f 84 c7 00 00 00    	je     500 <vprintf.constprop.0+0xf0>
  write(fd, &c, 1);
 439:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 43c:	83 ec 04             	sub    $0x4,%esp
 43f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 442:	6a 01                	push   $0x1
 444:	50                   	push   %eax
 445:	6a 01                	push   $0x1
 447:	e8 9e fe ff ff       	call   2ea <write>
 44c:	83 c4 10             	add    $0x10,%esp
 44f:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 452:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 456:	84 d2                	test   %dl,%dl
 458:	0f 84 95 00 00 00    	je     4f3 <vprintf.constprop.0+0xe3>
    if(state == 0){
 45e:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 460:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 463:	74 cb                	je     430 <vprintf.constprop.0+0x20>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 465:	83 ff 25             	cmp    $0x25,%edi
 468:	75 e5                	jne    44f <vprintf.constprop.0+0x3f>
      if(c == 'd'){
 46a:	83 f8 64             	cmp    $0x64,%eax
        printint(fd, va_arg(ap, int), 10, 1);
 46d:	8d 7e 04             	lea    0x4(%esi),%edi
 470:	b9 01 00 00 00       	mov    $0x1,%ecx
      if(c == 'd'){
 475:	0f 84 9a 00 00 00    	je     515 <vprintf.constprop.0+0x105>
      } else if(c == 'l') {
 47b:	83 f8 6c             	cmp    $0x6c,%eax
 47e:	0f 84 8c 00 00 00    	je     510 <vprintf.constprop.0+0x100>
        printint(fd, va_arg(ap, uint), 10, 0);
      } else if(c == 'x') {
 484:	83 f8 78             	cmp    $0x78,%eax
 487:	0f 84 a3 00 00 00    	je     530 <vprintf.constprop.0+0x120>
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 48d:	83 f8 70             	cmp    $0x70,%eax
 490:	0f 84 ca 00 00 00    	je     560 <vprintf.constprop.0+0x150>
        printptr(fd, va_arg(ap, uint));
      } else if(c == 's'){
 496:	83 f8 73             	cmp    $0x73,%eax
 499:	0f 84 39 01 00 00    	je     5d8 <vprintf.constprop.0+0x1c8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 49f:	83 f8 63             	cmp    $0x63,%eax
 4a2:	0f 84 68 01 00 00    	je     610 <vprintf.constprop.0+0x200>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 4a8:	83 f8 25             	cmp    $0x25,%eax
 4ab:	0f 84 9f 00 00 00    	je     550 <vprintf.constprop.0+0x140>
  write(fd, &c, 1);
 4b1:	8d 45 df             	lea    -0x21(%ebp),%eax
 4b4:	83 ec 04             	sub    $0x4,%esp
 4b7:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 4ba:	6a 01                	push   $0x1
 4bc:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 4c0:	50                   	push   %eax
 4c1:	6a 01                	push   $0x1
 4c3:	e8 22 fe ff ff       	call   2ea <write>
 4c8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 4cc:	83 c4 0c             	add    $0xc,%esp
 4cf:	8d 45 e0             	lea    -0x20(%ebp),%eax
 4d2:	6a 01                	push   $0x1
 4d4:	88 55 e0             	mov    %dl,-0x20(%ebp)
 4d7:	50                   	push   %eax
 4d8:	6a 01                	push   $0x1
 4da:	83 c3 01             	add    $0x1,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4dd:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 4df:	e8 06 fe ff ff       	call   2ea <write>
  for(i = 0; fmt[i]; i++){
 4e4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
  write(fd, &c, 1);
 4e8:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4eb:	84 d2                	test   %dl,%dl
 4ed:	0f 85 6b ff ff ff    	jne    45e <vprintf.constprop.0+0x4e>
    }
  }
}
 4f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4f6:	5b                   	pop    %ebx
 4f7:	5e                   	pop    %esi
 4f8:	5f                   	pop    %edi
 4f9:	5d                   	pop    %ebp
 4fa:	c3                   	ret    
 4fb:	90                   	nop
 4fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        state = '%';
 500:	bf 25 00 00 00       	mov    $0x25,%edi
 505:	e9 45 ff ff ff       	jmp    44f <vprintf.constprop.0+0x3f>
 50a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, uint), 10, 0);
 510:	8d 7e 04             	lea    0x4(%esi),%edi
 513:	31 c9                	xor    %ecx,%ecx
 515:	8b 06                	mov    (%esi),%eax
 517:	ba 0a 00 00 00       	mov    $0xa,%edx
 51c:	89 fe                	mov    %edi,%esi
      state = 0;
 51e:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, uint), 10, 0);
 520:	e8 5b fe ff ff       	call   380 <printint.constprop.1>
 525:	e9 25 ff ff ff       	jmp    44f <vprintf.constprop.0+0x3f>
 52a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, int), 16, 0);
 530:	8b 06                	mov    (%esi),%eax
 532:	8d 7e 04             	lea    0x4(%esi),%edi
 535:	31 c9                	xor    %ecx,%ecx
 537:	ba 10 00 00 00       	mov    $0x10,%edx
 53c:	89 fe                	mov    %edi,%esi
      state = 0;
 53e:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, int), 16, 0);
 540:	e8 3b fe ff ff       	call   380 <printint.constprop.1>
 545:	e9 05 ff ff ff       	jmp    44f <vprintf.constprop.0+0x3f>
 54a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 550:	83 ec 04             	sub    $0x4,%esp
 553:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 556:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 559:	6a 01                	push   $0x1
 55b:	e9 77 ff ff ff       	jmp    4d7 <vprintf.constprop.0+0xc7>
        printptr(fd, va_arg(ap, uint));
 560:	8d 46 04             	lea    0x4(%esi),%eax
  write(fd, &c, 1);
 563:	83 ec 04             	sub    $0x4,%esp
        printptr(fd, va_arg(ap, uint));
 566:	8b 3e                	mov    (%esi),%edi
  write(fd, &c, 1);
 568:	6a 01                	push   $0x1
 56a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 56e:	be 08 00 00 00       	mov    $0x8,%esi
        printptr(fd, va_arg(ap, uint));
 573:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 576:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 579:	50                   	push   %eax
 57a:	6a 01                	push   $0x1
 57c:	e8 69 fd ff ff       	call   2ea <write>
 581:	8d 45 e7             	lea    -0x19(%ebp),%eax
 584:	83 c4 0c             	add    $0xc,%esp
 587:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 58b:	6a 01                	push   $0x1
 58d:	50                   	push   %eax
 58e:	6a 01                	push   $0x1
 590:	e8 55 fd ff ff       	call   2ea <write>
 595:	83 c4 10             	add    $0x10,%esp
 598:	90                   	nop
 599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
 5a0:	89 f8                	mov    %edi,%eax
  write(fd, &c, 1);
 5a2:	83 ec 04             	sub    $0x4,%esp
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
 5a5:	c1 e7 04             	shl    $0x4,%edi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
 5a8:	c1 e8 1c             	shr    $0x1c,%eax
  write(fd, &c, 1);
 5ab:	6a 01                	push   $0x1
 5ad:	0f b6 80 30 08 00 00 	movzbl 0x830(%eax),%eax
 5b4:	88 45 e5             	mov    %al,-0x1b(%ebp)
 5b7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5ba:	50                   	push   %eax
 5bb:	6a 01                	push   $0x1
 5bd:	e8 28 fd ff ff       	call   2ea <write>
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
 5c2:	83 c4 10             	add    $0x10,%esp
 5c5:	83 ee 01             	sub    $0x1,%esi
 5c8:	75 d6                	jne    5a0 <vprintf.constprop.0+0x190>
        s = va_arg(ap, char*);
 5ca:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 5cd:	31 ff                	xor    %edi,%edi
 5cf:	e9 7b fe ff ff       	jmp    44f <vprintf.constprop.0+0x3f>
 5d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = va_arg(ap, char*);
 5d8:	8b 3e                	mov    (%esi),%edi
 5da:	8d 46 04             	lea    0x4(%esi),%eax
 5dd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 5e0:	85 ff                	test   %edi,%edi
 5e2:	74 50                	je     634 <vprintf.constprop.0+0x224>
        while(*s != 0){
 5e4:	0f b6 07             	movzbl (%edi),%eax
 5e7:	84 c0                	test   %al,%al
 5e9:	74 df                	je     5ca <vprintf.constprop.0+0x1ba>
 5eb:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 5ee:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 5f0:	83 ec 04             	sub    $0x4,%esp
          s++;
 5f3:	83 c7 01             	add    $0x1,%edi
 5f6:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 5f9:	6a 01                	push   $0x1
 5fb:	56                   	push   %esi
 5fc:	6a 01                	push   $0x1
 5fe:	e8 e7 fc ff ff       	call   2ea <write>
        while(*s != 0){
 603:	0f b6 07             	movzbl (%edi),%eax
 606:	83 c4 10             	add    $0x10,%esp
 609:	84 c0                	test   %al,%al
 60b:	75 e3                	jne    5f0 <vprintf.constprop.0+0x1e0>
 60d:	eb bb                	jmp    5ca <vprintf.constprop.0+0x1ba>
 60f:	90                   	nop
        putc(fd, va_arg(ap, uint));
 610:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 612:	83 ec 04             	sub    $0x4,%esp
        putc(fd, va_arg(ap, uint));
 615:	8d 7e 04             	lea    0x4(%esi),%edi
  write(fd, &c, 1);
 618:	6a 01                	push   $0x1
        putc(fd, va_arg(ap, uint));
 61a:	89 fe                	mov    %edi,%esi
      state = 0;
 61c:	31 ff                	xor    %edi,%edi
        putc(fd, va_arg(ap, uint));
 61e:	88 45 e2             	mov    %al,-0x1e(%ebp)
  write(fd, &c, 1);
 621:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 624:	50                   	push   %eax
 625:	6a 01                	push   $0x1
 627:	e8 be fc ff ff       	call   2ea <write>
 62c:	83 c4 10             	add    $0x10,%esp
 62f:	e9 1b fe ff ff       	jmp    44f <vprintf.constprop.0+0x3f>
          s = "(null)";
 634:	bf 29 08 00 00       	mov    $0x829,%edi
        while(*s != 0){
 639:	b8 28 00 00 00       	mov    $0x28,%eax
 63e:	eb ab                	jmp    5eb <vprintf.constprop.0+0x1db>

00000640 <fprintf>:
// Print to the given fd. Only understands %d,%x, %p, %s, %c.
void
fprintf(int fd, const char *fmt, ...)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	83 ec 08             	sub    $0x8,%esp
 va_list ap;
 va_start(ap, fmt); 
 vprintf(1,fmt,ap);
 646:	8b 45 0c             	mov    0xc(%ebp),%eax
 649:	8d 55 10             	lea    0x10(%ebp),%edx
 64c:	e8 bf fd ff ff       	call   410 <vprintf.constprop.0>
}
 651:	c9                   	leave  
 652:	c3                   	ret    
 653:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000660 <printf>:
void
printf(const char *fmt, ...)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	83 ec 08             	sub    $0x8,%esp
  va_list ap;
  va_start(ap, fmt); 
  vprintf(1,fmt,ap);
 666:	8b 45 08             	mov    0x8(%ebp),%eax
 669:	8d 55 0c             	lea    0xc(%ebp),%edx
 66c:	e8 9f fd ff ff       	call   410 <vprintf.constprop.0>
}
 671:	c9                   	leave  
 672:	c3                   	ret    
 673:	66 90                	xchg   %ax,%ax
 675:	66 90                	xchg   %ax,%ax
 677:	66 90                	xchg   %ax,%ax
 679:	66 90                	xchg   %ax,%ax
 67b:	66 90                	xchg   %ax,%ax
 67d:	66 90                	xchg   %ax,%ax
 67f:	90                   	nop

00000680 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 680:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 681:	a1 20 0b 00 00       	mov    0xb20,%eax
{
 686:	89 e5                	mov    %esp,%ebp
 688:	57                   	push   %edi
 689:	56                   	push   %esi
 68a:	53                   	push   %ebx
 68b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 68e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 698:	39 c8                	cmp    %ecx,%eax
 69a:	8b 10                	mov    (%eax),%edx
 69c:	73 32                	jae    6d0 <free+0x50>
 69e:	39 d1                	cmp    %edx,%ecx
 6a0:	72 04                	jb     6a6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a2:	39 d0                	cmp    %edx,%eax
 6a4:	72 32                	jb     6d8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6a6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6a9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ac:	39 fa                	cmp    %edi,%edx
 6ae:	74 30                	je     6e0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6b0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6b3:	8b 50 04             	mov    0x4(%eax),%edx
 6b6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6b9:	39 f1                	cmp    %esi,%ecx
 6bb:	74 3a                	je     6f7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6bd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 6bf:	a3 20 0b 00 00       	mov    %eax,0xb20
}
 6c4:	5b                   	pop    %ebx
 6c5:	5e                   	pop    %esi
 6c6:	5f                   	pop    %edi
 6c7:	5d                   	pop    %ebp
 6c8:	c3                   	ret    
 6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d0:	39 d0                	cmp    %edx,%eax
 6d2:	72 04                	jb     6d8 <free+0x58>
 6d4:	39 d1                	cmp    %edx,%ecx
 6d6:	72 ce                	jb     6a6 <free+0x26>
{
 6d8:	89 d0                	mov    %edx,%eax
 6da:	eb bc                	jmp    698 <free+0x18>
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 6e0:	03 72 04             	add    0x4(%edx),%esi
 6e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e6:	8b 10                	mov    (%eax),%edx
 6e8:	8b 12                	mov    (%edx),%edx
 6ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6ed:	8b 50 04             	mov    0x4(%eax),%edx
 6f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6f3:	39 f1                	cmp    %esi,%ecx
 6f5:	75 c6                	jne    6bd <free+0x3d>
    p->s.size += bp->s.size;
 6f7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6fa:	a3 20 0b 00 00       	mov    %eax,0xb20
    p->s.size += bp->s.size;
 6ff:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 702:	8b 53 f8             	mov    -0x8(%ebx),%edx
 705:	89 10                	mov    %edx,(%eax)
}
 707:	5b                   	pop    %ebx
 708:	5e                   	pop    %esi
 709:	5f                   	pop    %edi
 70a:	5d                   	pop    %ebp
 70b:	c3                   	ret    
 70c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000710 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	57                   	push   %edi
 714:	56                   	push   %esi
 715:	53                   	push   %ebx
 716:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 719:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 71c:	8b 15 20 0b 00 00    	mov    0xb20,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 722:	8d 78 07             	lea    0x7(%eax),%edi
 725:	c1 ef 03             	shr    $0x3,%edi
 728:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 72b:	85 d2                	test   %edx,%edx
 72d:	0f 84 9d 00 00 00    	je     7d0 <malloc+0xc0>
 733:	8b 02                	mov    (%edx),%eax
 735:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 738:	39 cf                	cmp    %ecx,%edi
 73a:	76 6c                	jbe    7a8 <malloc+0x98>
 73c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 742:	bb 00 10 00 00       	mov    $0x1000,%ebx
 747:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 74a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 751:	eb 0e                	jmp    761 <malloc+0x51>
 753:	90                   	nop
 754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 758:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 75a:	8b 48 04             	mov    0x4(%eax),%ecx
 75d:	39 f9                	cmp    %edi,%ecx
 75f:	73 47                	jae    7a8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 761:	39 05 20 0b 00 00    	cmp    %eax,0xb20
 767:	89 c2                	mov    %eax,%edx
 769:	75 ed                	jne    758 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 76b:	83 ec 0c             	sub    $0xc,%esp
 76e:	56                   	push   %esi
 76f:	e8 de fb ff ff       	call   352 <sbrk>
  if(p == (char*)-1)
 774:	83 c4 10             	add    $0x10,%esp
 777:	83 f8 ff             	cmp    $0xffffffff,%eax
 77a:	74 1c                	je     798 <malloc+0x88>
  hp->s.size = nu;
 77c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 77f:	83 ec 0c             	sub    $0xc,%esp
 782:	83 c0 08             	add    $0x8,%eax
 785:	50                   	push   %eax
 786:	e8 f5 fe ff ff       	call   680 <free>
  return freep;
 78b:	8b 15 20 0b 00 00    	mov    0xb20,%edx
      if((p = morecore(nunits)) == 0)
 791:	83 c4 10             	add    $0x10,%esp
 794:	85 d2                	test   %edx,%edx
 796:	75 c0                	jne    758 <malloc+0x48>
        return 0;
  }
}
 798:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 79b:	31 c0                	xor    %eax,%eax
}
 79d:	5b                   	pop    %ebx
 79e:	5e                   	pop    %esi
 79f:	5f                   	pop    %edi
 7a0:	5d                   	pop    %ebp
 7a1:	c3                   	ret    
 7a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7a8:	39 cf                	cmp    %ecx,%edi
 7aa:	74 54                	je     800 <malloc+0xf0>
        p->s.size -= nunits;
 7ac:	29 f9                	sub    %edi,%ecx
 7ae:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7b1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7b4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7b7:	89 15 20 0b 00 00    	mov    %edx,0xb20
}
 7bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7c0:	83 c0 08             	add    $0x8,%eax
}
 7c3:	5b                   	pop    %ebx
 7c4:	5e                   	pop    %esi
 7c5:	5f                   	pop    %edi
 7c6:	5d                   	pop    %ebp
 7c7:	c3                   	ret    
 7c8:	90                   	nop
 7c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 7d0:	c7 05 20 0b 00 00 24 	movl   $0xb24,0xb20
 7d7:	0b 00 00 
 7da:	c7 05 24 0b 00 00 24 	movl   $0xb24,0xb24
 7e1:	0b 00 00 
    base.s.size = 0;
 7e4:	b8 24 0b 00 00       	mov    $0xb24,%eax
 7e9:	c7 05 28 0b 00 00 00 	movl   $0x0,0xb28
 7f0:	00 00 00 
 7f3:	e9 44 ff ff ff       	jmp    73c <malloc+0x2c>
 7f8:	90                   	nop
 7f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 800:	8b 08                	mov    (%eax),%ecx
 802:	89 0a                	mov    %ecx,(%edx)
 804:	eb b1                	jmp    7b7 <malloc+0xa7>
