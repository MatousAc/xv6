
user/_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

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
  int fd, i;
  char path[] = "stressfs0";
  11:	be 30 00 00 00       	mov    $0x30,%esi
  char data[512];

  printf("stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
  16:	31 db                	xor    %ebx,%ebx
{
  18:	81 ec 24 02 00 00    	sub    $0x224,%esp
  char path[] = "stressfs0";
  1e:	66 89 b5 e6 fd ff ff 	mov    %si,-0x21a(%ebp)
  memset(data, 'a', sizeof(data));
  25:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
  printf("stressfs starting\n");
  2b:	68 d8 08 00 00       	push   $0x8d8
  char path[] = "stressfs0";
  30:	c7 85 de fd ff ff 73 	movl   $0x65727473,-0x222(%ebp)
  37:	74 72 65 
  3a:	c7 85 e2 fd ff ff 73 	movl   $0x73667373,-0x21e(%ebp)
  41:	73 66 73 
  printf("stressfs starting\n");
  44:	e8 e7 06 00 00       	call   730 <printf>
  memset(data, 'a', sizeof(data));
  49:	83 c4 0c             	add    $0xc,%esp
  4c:	68 00 02 00 00       	push   $0x200
  51:	6a 61                	push   $0x61
  53:	56                   	push   %esi
  54:	e8 97 01 00 00       	call   1f0 <memset>
  59:	83 c4 10             	add    $0x10,%esp
    if(fork() > 0)
  5c:	e8 29 03 00 00       	call   38a <fork>
  61:	85 c0                	test   %eax,%eax
  63:	0f 8f c1 00 00 00    	jg     12a <main+0x12a>
  for(i = 0; i < 4; i++)
  69:	83 c3 01             	add    $0x1,%ebx
  6c:	83 fb 04             	cmp    $0x4,%ebx
  6f:	75 eb                	jne    5c <main+0x5c>
  71:	bf 04 00 00 00       	mov    $0x4,%edi
      break;

  printf("write %d\n", i);
  76:	83 ec 08             	sub    $0x8,%esp
  79:	53                   	push   %ebx
  7a:	68 eb 08 00 00       	push   $0x8eb
  7f:	e8 ac 06 00 00       	call   730 <printf>

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  84:	59                   	pop    %ecx
  path[8] += i;
  85:	89 f8                	mov    %edi,%eax
  87:	00 85 e6 fd ff ff    	add    %al,-0x21a(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  8d:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  93:	5b                   	pop    %ebx
  94:	68 02 02 00 00       	push   $0x202
  99:	50                   	push   %eax
  9a:	bb 14 00 00 00       	mov    $0x14,%ebx
  9f:	e8 36 03 00 00       	call   3da <open>
  a4:	83 c4 10             	add    $0x10,%esp
  a7:	89 c7                	mov    %eax,%edi
  a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 20; i++)
    write(fd, data, sizeof(data));
  b0:	83 ec 04             	sub    $0x4,%esp
  b3:	68 00 02 00 00       	push   $0x200
  b8:	56                   	push   %esi
  b9:	57                   	push   %edi
  ba:	e8 fb 02 00 00       	call   3ba <write>
  for(i = 0; i < 20; i++)
  bf:	83 c4 10             	add    $0x10,%esp
  c2:	83 eb 01             	sub    $0x1,%ebx
  c5:	75 e9                	jne    b0 <main+0xb0>
  close(fd);
  c7:	83 ec 0c             	sub    $0xc,%esp

  printf("read\n");

  fd = open(path, O_RDONLY);
  ca:	bb 14 00 00 00       	mov    $0x14,%ebx
  close(fd);
  cf:	57                   	push   %edi
  d0:	e8 ed 02 00 00       	call   3c2 <close>
  printf("read\n");
  d5:	c7 04 24 f5 08 00 00 	movl   $0x8f5,(%esp)
  dc:	e8 4f 06 00 00       	call   730 <printf>
  fd = open(path, O_RDONLY);
  e1:	58                   	pop    %eax
  e2:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  e8:	5a                   	pop    %edx
  e9:	6a 00                	push   $0x0
  eb:	50                   	push   %eax
  ec:	e8 e9 02 00 00       	call   3da <open>
  f1:	83 c4 10             	add    $0x10,%esp
  f4:	89 c7                	mov    %eax,%edi
  f6:	8d 76 00             	lea    0x0(%esi),%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
 100:	83 ec 04             	sub    $0x4,%esp
 103:	68 00 02 00 00       	push   $0x200
 108:	56                   	push   %esi
 109:	57                   	push   %edi
 10a:	e8 9b 02 00 00       	call   3aa <read>
  for (i = 0; i < 20; i++)
 10f:	83 c4 10             	add    $0x10,%esp
 112:	83 eb 01             	sub    $0x1,%ebx
 115:	75 e9                	jne    100 <main+0x100>
  close(fd);
 117:	83 ec 0c             	sub    $0xc,%esp
 11a:	57                   	push   %edi
 11b:	e8 a2 02 00 00       	call   3c2 <close>

  wait();
 120:	e8 75 02 00 00       	call   39a <wait>

  exit();
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
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 45 08             	mov    0x8(%ebp),%eax
 147:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 14a:	89 c2                	mov    %eax,%edx
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 150:	83 c1 01             	add    $0x1,%ecx
 153:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 157:	83 c2 01             	add    $0x1,%edx
 15a:	84 db                	test   %bl,%bl
 15c:	88 5a ff             	mov    %bl,-0x1(%edx)
 15f:	75 ef                	jne    150 <strcpy+0x10>
    ;
  return os;
}
 161:	5b                   	pop    %ebx
 162:	5d                   	pop    %ebp
 163:	c3                   	ret    
 164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 16a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	53                   	push   %ebx
 174:	8b 55 08             	mov    0x8(%ebp),%edx
 177:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 17a:	0f b6 02             	movzbl (%edx),%eax
 17d:	0f b6 19             	movzbl (%ecx),%ebx
 180:	84 c0                	test   %al,%al
 182:	75 1c                	jne    1a0 <strcmp+0x30>
 184:	eb 2a                	jmp    1b0 <strcmp+0x40>
 186:	8d 76 00             	lea    0x0(%esi),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 190:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 193:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 196:	83 c1 01             	add    $0x1,%ecx
 199:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 19c:	84 c0                	test   %al,%al
 19e:	74 10                	je     1b0 <strcmp+0x40>
 1a0:	38 d8                	cmp    %bl,%al
 1a2:	74 ec                	je     190 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 1a4:	29 d8                	sub    %ebx,%eax
}
 1a6:	5b                   	pop    %ebx
 1a7:	5d                   	pop    %ebp
 1a8:	c3                   	ret    
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1b0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1b2:	29 d8                	sub    %ebx,%eax
}
 1b4:	5b                   	pop    %ebx
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	89 f6                	mov    %esi,%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <strlen>:

uint
strlen(const char *s)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1c6:	80 39 00             	cmpb   $0x0,(%ecx)
 1c9:	74 15                	je     1e0 <strlen+0x20>
 1cb:	31 d2                	xor    %edx,%edx
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
 1d0:	83 c2 01             	add    $0x1,%edx
 1d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1d7:	89 d0                	mov    %edx,%eax
 1d9:	75 f5                	jne    1d0 <strlen+0x10>
    ;
  return n;
}
 1db:	5d                   	pop    %ebp
 1dc:	c3                   	ret    
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 1e0:	31 c0                	xor    %eax,%eax
}
 1e2:	5d                   	pop    %ebp
 1e3:	c3                   	ret    
 1e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fd:	89 d7                	mov    %edx,%edi
 1ff:	fc                   	cld    
 200:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 202:	89 d0                	mov    %edx,%eax
 204:	5f                   	pop    %edi
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <strchr>:

char*
strchr(const char *s, char c)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 45 08             	mov    0x8(%ebp),%eax
 217:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 21a:	0f b6 10             	movzbl (%eax),%edx
 21d:	84 d2                	test   %dl,%dl
 21f:	74 1d                	je     23e <strchr+0x2e>
    if(*s == c)
 221:	38 d3                	cmp    %dl,%bl
 223:	89 d9                	mov    %ebx,%ecx
 225:	75 0d                	jne    234 <strchr+0x24>
 227:	eb 17                	jmp    240 <strchr+0x30>
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 230:	38 ca                	cmp    %cl,%dl
 232:	74 0c                	je     240 <strchr+0x30>
  for(; *s; s++)
 234:	83 c0 01             	add    $0x1,%eax
 237:	0f b6 10             	movzbl (%eax),%edx
 23a:	84 d2                	test   %dl,%dl
 23c:	75 f2                	jne    230 <strchr+0x20>
      return (char*)s;
  return 0;
 23e:	31 c0                	xor    %eax,%eax
}
 240:	5b                   	pop    %ebx
 241:	5d                   	pop    %ebp
 242:	c3                   	ret    
 243:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <gets>:

char*
gets(char *buf, int max)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	56                   	push   %esi
 255:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 256:	31 f6                	xor    %esi,%esi
 258:	89 f3                	mov    %esi,%ebx
{
 25a:	83 ec 1c             	sub    $0x1c,%esp
 25d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 260:	eb 2f                	jmp    291 <gets+0x41>
 262:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 268:	8d 45 e7             	lea    -0x19(%ebp),%eax
 26b:	83 ec 04             	sub    $0x4,%esp
 26e:	6a 01                	push   $0x1
 270:	50                   	push   %eax
 271:	6a 00                	push   $0x0
 273:	e8 32 01 00 00       	call   3aa <read>
    if(cc < 1)
 278:	83 c4 10             	add    $0x10,%esp
 27b:	85 c0                	test   %eax,%eax
 27d:	7e 1c                	jle    29b <gets+0x4b>
      break;
    buf[i++] = c;
 27f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 283:	83 c7 01             	add    $0x1,%edi
 286:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 289:	3c 0a                	cmp    $0xa,%al
 28b:	74 23                	je     2b0 <gets+0x60>
 28d:	3c 0d                	cmp    $0xd,%al
 28f:	74 1f                	je     2b0 <gets+0x60>
  for(i=0; i+1 < max; ){
 291:	83 c3 01             	add    $0x1,%ebx
 294:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 297:	89 fe                	mov    %edi,%esi
 299:	7c cd                	jl     268 <gets+0x18>
 29b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 29d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 2a0:	c6 03 00             	movb   $0x0,(%ebx)
}
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
  buf[i] = '\0';
 2ba:	c6 03 00             	movb   $0x0,(%ebx)
}
 2bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2c0:	5b                   	pop    %ebx
 2c1:	5e                   	pop    %esi
 2c2:	5f                   	pop    %edi
 2c3:	5d                   	pop    %ebp
 2c4:	c3                   	ret    
 2c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	56                   	push   %esi
 2d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d5:	83 ec 08             	sub    $0x8,%esp
 2d8:	6a 00                	push   $0x0
 2da:	ff 75 08             	pushl  0x8(%ebp)
 2dd:	e8 f8 00 00 00       	call   3da <open>
  if(fd < 0)
 2e2:	83 c4 10             	add    $0x10,%esp
 2e5:	85 c0                	test   %eax,%eax
 2e7:	78 27                	js     310 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2e9:	83 ec 08             	sub    $0x8,%esp
 2ec:	ff 75 0c             	pushl  0xc(%ebp)
 2ef:	89 c3                	mov    %eax,%ebx
 2f1:	50                   	push   %eax
 2f2:	e8 fb 00 00 00       	call   3f2 <fstat>
  close(fd);
 2f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2fa:	89 c6                	mov    %eax,%esi
  close(fd);
 2fc:	e8 c1 00 00 00       	call   3c2 <close>
  return r;
 301:	83 c4 10             	add    $0x10,%esp
}
 304:	8d 65 f8             	lea    -0x8(%ebp),%esp
 307:	89 f0                	mov    %esi,%eax
 309:	5b                   	pop    %ebx
 30a:	5e                   	pop    %esi
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret    
 30d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 310:	be ff ff ff ff       	mov    $0xffffffff,%esi
 315:	eb ed                	jmp    304 <stat+0x34>
 317:	89 f6                	mov    %esi,%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000320 <atoi>:

int
atoi(const char *s)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 327:	0f be 11             	movsbl (%ecx),%edx
 32a:	8d 42 d0             	lea    -0x30(%edx),%eax
 32d:	3c 09                	cmp    $0x9,%al
  n = 0;
 32f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 334:	77 1f                	ja     355 <atoi+0x35>
 336:	8d 76 00             	lea    0x0(%esi),%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 340:	8d 04 80             	lea    (%eax,%eax,4),%eax
 343:	83 c1 01             	add    $0x1,%ecx
 346:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 34a:	0f be 11             	movsbl (%ecx),%edx
 34d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 350:	80 fb 09             	cmp    $0x9,%bl
 353:	76 eb                	jbe    340 <atoi+0x20>
  return n;
}
 355:	5b                   	pop    %ebx
 356:	5d                   	pop    %ebp
 357:	c3                   	ret    
 358:	90                   	nop
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000360 <memmove>:


void*
memmove(void *vdst, const void *vsrc, int n)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	56                   	push   %esi
 364:	53                   	push   %ebx
 365:	8b 5d 10             	mov    0x10(%ebp),%ebx
 368:	8b 45 08             	mov    0x8(%ebp),%eax
 36b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 36e:	85 db                	test   %ebx,%ebx
 370:	7e 14                	jle    386 <memmove+0x26>
 372:	31 d2                	xor    %edx,%edx
 374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 378:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 37c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 37f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 382:	39 d3                	cmp    %edx,%ebx
 384:	75 f2                	jne    378 <memmove+0x18>
  return vdst;
}
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

000003b2 <steal>:
SYSCALL(steal)
 3b2:	b8 17 00 00 00       	mov    $0x17,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <write>:
SYSCALL(write)
 3ba:	b8 10 00 00 00       	mov    $0x10,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <close>:
SYSCALL(close)
 3c2:	b8 15 00 00 00       	mov    $0x15,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <kill>:
SYSCALL(kill)
 3ca:	b8 06 00 00 00       	mov    $0x6,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <exec>:
SYSCALL(exec)
 3d2:	b8 07 00 00 00       	mov    $0x7,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <open>:
SYSCALL(open)
 3da:	b8 0f 00 00 00       	mov    $0xf,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <mknod>:
SYSCALL(mknod)
 3e2:	b8 11 00 00 00       	mov    $0x11,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <unlink>:
SYSCALL(unlink)
 3ea:	b8 12 00 00 00       	mov    $0x12,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <fstat>:
SYSCALL(fstat)
 3f2:	b8 08 00 00 00       	mov    $0x8,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <link>:
SYSCALL(link)
 3fa:	b8 13 00 00 00       	mov    $0x13,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <mkdir>:
SYSCALL(mkdir)
 402:	b8 14 00 00 00       	mov    $0x14,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <chdir>:
SYSCALL(chdir)
 40a:	b8 09 00 00 00       	mov    $0x9,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <dup>:
SYSCALL(dup)
 412:	b8 0a 00 00 00       	mov    $0xa,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <getpid>:
SYSCALL(getpid)
 41a:	b8 0b 00 00 00       	mov    $0xb,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <sbrk>:
SYSCALL(sbrk)
 422:	b8 0c 00 00 00       	mov    $0xc,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <sleep>:
SYSCALL(sleep)
 42a:	b8 0d 00 00 00       	mov    $0xd,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <uptime>:
SYSCALL(uptime)
 432:	b8 0e 00 00 00       	mov    $0xe,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <cpuhalt>:
SYSCALL(cpuhalt)
 43a:	b8 16 00 00 00       	mov    $0x16,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    
 442:	66 90                	xchg   %ax,%ax
 444:	66 90                	xchg   %ax,%ax
 446:	66 90                	xchg   %ax,%ax
 448:	66 90                	xchg   %ax,%ax
 44a:	66 90                	xchg   %ax,%ax
 44c:	66 90                	xchg   %ax,%ax
 44e:	66 90                	xchg   %ax,%ax

00000450 <printint.constprop.1>:
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
}

static void
printint(int fd, int xx, int base, int sgn)
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	53                   	push   %ebx
 456:	89 d6                	mov    %edx,%esi
 458:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 45b:	85 c0                	test   %eax,%eax
 45d:	79 71                	jns    4d0 <printint.constprop.1+0x80>
 45f:	83 e1 01             	and    $0x1,%ecx
 462:	74 6c                	je     4d0 <printint.constprop.1+0x80>
    neg = 1;
    x = -xx;
 464:	f7 d8                	neg    %eax
    neg = 1;
 466:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 46d:	31 c9                	xor    %ecx,%ecx
 46f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 472:	eb 06                	jmp    47a <printint.constprop.1+0x2a>
 474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 478:	89 f9                	mov    %edi,%ecx
 47a:	31 d2                	xor    %edx,%edx
 47c:	8d 79 01             	lea    0x1(%ecx),%edi
 47f:	f7 f6                	div    %esi
 481:	0f b6 92 04 09 00 00 	movzbl 0x904(%edx),%edx
  }while((x /= base) != 0);
 488:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 48a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 48d:	75 e9                	jne    478 <printint.constprop.1+0x28>
  if(neg)
 48f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 492:	85 c0                	test   %eax,%eax
 494:	74 08                	je     49e <printint.constprop.1+0x4e>
    buf[i++] = '-';
 496:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 49b:	8d 79 02             	lea    0x2(%ecx),%edi
 49e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 4a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4a8:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 4ab:	83 ec 04             	sub    $0x4,%esp
 4ae:	83 ee 01             	sub    $0x1,%esi
 4b1:	6a 01                	push   $0x1
 4b3:	53                   	push   %ebx
 4b4:	6a 01                	push   $0x1
 4b6:	88 45 d7             	mov    %al,-0x29(%ebp)
 4b9:	e8 fc fe ff ff       	call   3ba <write>

  while(--i >= 0)
 4be:	83 c4 10             	add    $0x10,%esp
 4c1:	39 de                	cmp    %ebx,%esi
 4c3:	75 e3                	jne    4a8 <printint.constprop.1+0x58>
    putc(fd, buf[i]);
}
 4c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4c8:	5b                   	pop    %ebx
 4c9:	5e                   	pop    %esi
 4ca:	5f                   	pop    %edi
 4cb:	5d                   	pop    %ebp
 4cc:	c3                   	ret    
 4cd:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 4d0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4d7:	eb 94                	jmp    46d <printint.constprop.1+0x1d>
 4d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004e0 <vprintf.constprop.0>:
static void vprintf(int fd, const char *fmt, va_list ap)
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
 4e6:	89 d6                	mov    %edx,%esi
 4e8:	83 ec 2c             	sub    $0x2c,%esp
{
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4eb:	0f b6 10             	movzbl (%eax),%edx
 4ee:	84 d2                	test   %dl,%dl
 4f0:	0f 84 cd 00 00 00    	je     5c3 <vprintf.constprop.0+0xe3>
 4f6:	8d 58 01             	lea    0x1(%eax),%ebx
  state = 0;
 4f9:	31 ff                	xor    %edi,%edi
 4fb:	eb 31                	jmp    52e <vprintf.constprop.0+0x4e>
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 500:	83 f8 25             	cmp    $0x25,%eax
 503:	0f 84 c7 00 00 00    	je     5d0 <vprintf.constprop.0+0xf0>
  write(fd, &c, 1);
 509:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 50c:	83 ec 04             	sub    $0x4,%esp
 50f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 512:	6a 01                	push   $0x1
 514:	50                   	push   %eax
 515:	6a 01                	push   $0x1
 517:	e8 9e fe ff ff       	call   3ba <write>
 51c:	83 c4 10             	add    $0x10,%esp
 51f:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 522:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 526:	84 d2                	test   %dl,%dl
 528:	0f 84 95 00 00 00    	je     5c3 <vprintf.constprop.0+0xe3>
    if(state == 0){
 52e:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 530:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 533:	74 cb                	je     500 <vprintf.constprop.0+0x20>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 535:	83 ff 25             	cmp    $0x25,%edi
 538:	75 e5                	jne    51f <vprintf.constprop.0+0x3f>
      if(c == 'd'){
 53a:	83 f8 64             	cmp    $0x64,%eax
        printint(fd, va_arg(ap, int), 10, 1);
 53d:	8d 7e 04             	lea    0x4(%esi),%edi
 540:	b9 01 00 00 00       	mov    $0x1,%ecx
      if(c == 'd'){
 545:	0f 84 9a 00 00 00    	je     5e5 <vprintf.constprop.0+0x105>
      } else if(c == 'l') {
 54b:	83 f8 6c             	cmp    $0x6c,%eax
 54e:	0f 84 8c 00 00 00    	je     5e0 <vprintf.constprop.0+0x100>
        printint(fd, va_arg(ap, uint), 10, 0);
      } else if(c == 'x') {
 554:	83 f8 78             	cmp    $0x78,%eax
 557:	0f 84 a3 00 00 00    	je     600 <vprintf.constprop.0+0x120>
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 55d:	83 f8 70             	cmp    $0x70,%eax
 560:	0f 84 ca 00 00 00    	je     630 <vprintf.constprop.0+0x150>
        printptr(fd, va_arg(ap, uint));
      } else if(c == 's'){
 566:	83 f8 73             	cmp    $0x73,%eax
 569:	0f 84 39 01 00 00    	je     6a8 <vprintf.constprop.0+0x1c8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 56f:	83 f8 63             	cmp    $0x63,%eax
 572:	0f 84 68 01 00 00    	je     6e0 <vprintf.constprop.0+0x200>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 578:	83 f8 25             	cmp    $0x25,%eax
 57b:	0f 84 9f 00 00 00    	je     620 <vprintf.constprop.0+0x140>
  write(fd, &c, 1);
 581:	8d 45 df             	lea    -0x21(%ebp),%eax
 584:	83 ec 04             	sub    $0x4,%esp
 587:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 58a:	6a 01                	push   $0x1
 58c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 590:	50                   	push   %eax
 591:	6a 01                	push   $0x1
 593:	e8 22 fe ff ff       	call   3ba <write>
 598:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 59c:	83 c4 0c             	add    $0xc,%esp
 59f:	8d 45 e0             	lea    -0x20(%ebp),%eax
 5a2:	6a 01                	push   $0x1
 5a4:	88 55 e0             	mov    %dl,-0x20(%ebp)
 5a7:	50                   	push   %eax
 5a8:	6a 01                	push   $0x1
 5aa:	83 c3 01             	add    $0x1,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5ad:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 5af:	e8 06 fe ff ff       	call   3ba <write>
  for(i = 0; fmt[i]; i++){
 5b4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
  write(fd, &c, 1);
 5b8:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 5bb:	84 d2                	test   %dl,%dl
 5bd:	0f 85 6b ff ff ff    	jne    52e <vprintf.constprop.0+0x4e>
    }
  }
}
 5c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5c6:	5b                   	pop    %ebx
 5c7:	5e                   	pop    %esi
 5c8:	5f                   	pop    %edi
 5c9:	5d                   	pop    %ebp
 5ca:	c3                   	ret    
 5cb:	90                   	nop
 5cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        state = '%';
 5d0:	bf 25 00 00 00       	mov    $0x25,%edi
 5d5:	e9 45 ff ff ff       	jmp    51f <vprintf.constprop.0+0x3f>
 5da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, uint), 10, 0);
 5e0:	8d 7e 04             	lea    0x4(%esi),%edi
 5e3:	31 c9                	xor    %ecx,%ecx
 5e5:	8b 06                	mov    (%esi),%eax
 5e7:	ba 0a 00 00 00       	mov    $0xa,%edx
 5ec:	89 fe                	mov    %edi,%esi
      state = 0;
 5ee:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, uint), 10, 0);
 5f0:	e8 5b fe ff ff       	call   450 <printint.constprop.1>
 5f5:	e9 25 ff ff ff       	jmp    51f <vprintf.constprop.0+0x3f>
 5fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, int), 16, 0);
 600:	8b 06                	mov    (%esi),%eax
 602:	8d 7e 04             	lea    0x4(%esi),%edi
 605:	31 c9                	xor    %ecx,%ecx
 607:	ba 10 00 00 00       	mov    $0x10,%edx
 60c:	89 fe                	mov    %edi,%esi
      state = 0;
 60e:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, int), 16, 0);
 610:	e8 3b fe ff ff       	call   450 <printint.constprop.1>
 615:	e9 05 ff ff ff       	jmp    51f <vprintf.constprop.0+0x3f>
 61a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 620:	83 ec 04             	sub    $0x4,%esp
 623:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 626:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 629:	6a 01                	push   $0x1
 62b:	e9 77 ff ff ff       	jmp    5a7 <vprintf.constprop.0+0xc7>
        printptr(fd, va_arg(ap, uint));
 630:	8d 46 04             	lea    0x4(%esi),%eax
  write(fd, &c, 1);
 633:	83 ec 04             	sub    $0x4,%esp
        printptr(fd, va_arg(ap, uint));
 636:	8b 3e                	mov    (%esi),%edi
  write(fd, &c, 1);
 638:	6a 01                	push   $0x1
 63a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 63e:	be 08 00 00 00       	mov    $0x8,%esi
        printptr(fd, va_arg(ap, uint));
 643:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 646:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 649:	50                   	push   %eax
 64a:	6a 01                	push   $0x1
 64c:	e8 69 fd ff ff       	call   3ba <write>
 651:	8d 45 e7             	lea    -0x19(%ebp),%eax
 654:	83 c4 0c             	add    $0xc,%esp
 657:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 65b:	6a 01                	push   $0x1
 65d:	50                   	push   %eax
 65e:	6a 01                	push   $0x1
 660:	e8 55 fd ff ff       	call   3ba <write>
 665:	83 c4 10             	add    $0x10,%esp
 668:	90                   	nop
 669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
 670:	89 f8                	mov    %edi,%eax
  write(fd, &c, 1);
 672:	83 ec 04             	sub    $0x4,%esp
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
 675:	c1 e7 04             	shl    $0x4,%edi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
 678:	c1 e8 1c             	shr    $0x1c,%eax
  write(fd, &c, 1);
 67b:	6a 01                	push   $0x1
 67d:	0f b6 80 04 09 00 00 	movzbl 0x904(%eax),%eax
 684:	88 45 e5             	mov    %al,-0x1b(%ebp)
 687:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 68a:	50                   	push   %eax
 68b:	6a 01                	push   $0x1
 68d:	e8 28 fd ff ff       	call   3ba <write>
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
 692:	83 c4 10             	add    $0x10,%esp
 695:	83 ee 01             	sub    $0x1,%esi
 698:	75 d6                	jne    670 <vprintf.constprop.0+0x190>
        s = va_arg(ap, char*);
 69a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 69d:	31 ff                	xor    %edi,%edi
 69f:	e9 7b fe ff ff       	jmp    51f <vprintf.constprop.0+0x3f>
 6a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = va_arg(ap, char*);
 6a8:	8b 3e                	mov    (%esi),%edi
 6aa:	8d 46 04             	lea    0x4(%esi),%eax
 6ad:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 6b0:	85 ff                	test   %edi,%edi
 6b2:	74 50                	je     704 <vprintf.constprop.0+0x224>
        while(*s != 0){
 6b4:	0f b6 07             	movzbl (%edi),%eax
 6b7:	84 c0                	test   %al,%al
 6b9:	74 df                	je     69a <vprintf.constprop.0+0x1ba>
 6bb:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 6be:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 6c0:	83 ec 04             	sub    $0x4,%esp
          s++;
 6c3:	83 c7 01             	add    $0x1,%edi
 6c6:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 6c9:	6a 01                	push   $0x1
 6cb:	56                   	push   %esi
 6cc:	6a 01                	push   $0x1
 6ce:	e8 e7 fc ff ff       	call   3ba <write>
        while(*s != 0){
 6d3:	0f b6 07             	movzbl (%edi),%eax
 6d6:	83 c4 10             	add    $0x10,%esp
 6d9:	84 c0                	test   %al,%al
 6db:	75 e3                	jne    6c0 <vprintf.constprop.0+0x1e0>
 6dd:	eb bb                	jmp    69a <vprintf.constprop.0+0x1ba>
 6df:	90                   	nop
        putc(fd, va_arg(ap, uint));
 6e0:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 6e2:	83 ec 04             	sub    $0x4,%esp
        putc(fd, va_arg(ap, uint));
 6e5:	8d 7e 04             	lea    0x4(%esi),%edi
  write(fd, &c, 1);
 6e8:	6a 01                	push   $0x1
        putc(fd, va_arg(ap, uint));
 6ea:	89 fe                	mov    %edi,%esi
      state = 0;
 6ec:	31 ff                	xor    %edi,%edi
        putc(fd, va_arg(ap, uint));
 6ee:	88 45 e2             	mov    %al,-0x1e(%ebp)
  write(fd, &c, 1);
 6f1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6f4:	50                   	push   %eax
 6f5:	6a 01                	push   $0x1
 6f7:	e8 be fc ff ff       	call   3ba <write>
 6fc:	83 c4 10             	add    $0x10,%esp
 6ff:	e9 1b fe ff ff       	jmp    51f <vprintf.constprop.0+0x3f>
          s = "(null)";
 704:	bf fb 08 00 00       	mov    $0x8fb,%edi
        while(*s != 0){
 709:	b8 28 00 00 00       	mov    $0x28,%eax
 70e:	eb ab                	jmp    6bb <vprintf.constprop.0+0x1db>

00000710 <fprintf>:
// Print to the given fd. Only understands %d,%x, %p, %s, %c.
void
fprintf(int fd, const char *fmt, ...)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	83 ec 08             	sub    $0x8,%esp
 va_list ap;
 va_start(ap, fmt); 
 vprintf(1,fmt,ap);
 716:	8b 45 0c             	mov    0xc(%ebp),%eax
 719:	8d 55 10             	lea    0x10(%ebp),%edx
 71c:	e8 bf fd ff ff       	call   4e0 <vprintf.constprop.0>
}
 721:	c9                   	leave  
 722:	c3                   	ret    
 723:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000730 <printf>:
void
printf(const char *fmt, ...)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	83 ec 08             	sub    $0x8,%esp
  va_list ap;
  va_start(ap, fmt); 
  vprintf(1,fmt,ap);
 736:	8b 45 08             	mov    0x8(%ebp),%eax
 739:	8d 55 0c             	lea    0xc(%ebp),%edx
 73c:	e8 9f fd ff ff       	call   4e0 <vprintf.constprop.0>
}
 741:	c9                   	leave  
 742:	c3                   	ret    
 743:	66 90                	xchg   %ax,%ax
 745:	66 90                	xchg   %ax,%ax
 747:	66 90                	xchg   %ax,%ax
 749:	66 90                	xchg   %ax,%ax
 74b:	66 90                	xchg   %ax,%ax
 74d:	66 90                	xchg   %ax,%ax
 74f:	90                   	nop

00000750 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 750:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 751:	a1 f4 0b 00 00       	mov    0xbf4,%eax
{
 756:	89 e5                	mov    %esp,%ebp
 758:	57                   	push   %edi
 759:	56                   	push   %esi
 75a:	53                   	push   %ebx
 75b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 75e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 768:	39 c8                	cmp    %ecx,%eax
 76a:	8b 10                	mov    (%eax),%edx
 76c:	73 32                	jae    7a0 <free+0x50>
 76e:	39 d1                	cmp    %edx,%ecx
 770:	72 04                	jb     776 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 772:	39 d0                	cmp    %edx,%eax
 774:	72 32                	jb     7a8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 776:	8b 73 fc             	mov    -0x4(%ebx),%esi
 779:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 77c:	39 fa                	cmp    %edi,%edx
 77e:	74 30                	je     7b0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 780:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 783:	8b 50 04             	mov    0x4(%eax),%edx
 786:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 789:	39 f1                	cmp    %esi,%ecx
 78b:	74 3a                	je     7c7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 78d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 78f:	a3 f4 0b 00 00       	mov    %eax,0xbf4
}
 794:	5b                   	pop    %ebx
 795:	5e                   	pop    %esi
 796:	5f                   	pop    %edi
 797:	5d                   	pop    %ebp
 798:	c3                   	ret    
 799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a0:	39 d0                	cmp    %edx,%eax
 7a2:	72 04                	jb     7a8 <free+0x58>
 7a4:	39 d1                	cmp    %edx,%ecx
 7a6:	72 ce                	jb     776 <free+0x26>
{
 7a8:	89 d0                	mov    %edx,%eax
 7aa:	eb bc                	jmp    768 <free+0x18>
 7ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 7b0:	03 72 04             	add    0x4(%edx),%esi
 7b3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7b6:	8b 10                	mov    (%eax),%edx
 7b8:	8b 12                	mov    (%edx),%edx
 7ba:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7bd:	8b 50 04             	mov    0x4(%eax),%edx
 7c0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7c3:	39 f1                	cmp    %esi,%ecx
 7c5:	75 c6                	jne    78d <free+0x3d>
    p->s.size += bp->s.size;
 7c7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7ca:	a3 f4 0b 00 00       	mov    %eax,0xbf4
    p->s.size += bp->s.size;
 7cf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7d2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7d5:	89 10                	mov    %edx,(%eax)
}
 7d7:	5b                   	pop    %ebx
 7d8:	5e                   	pop    %esi
 7d9:	5f                   	pop    %edi
 7da:	5d                   	pop    %ebp
 7db:	c3                   	ret    
 7dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	57                   	push   %edi
 7e4:	56                   	push   %esi
 7e5:	53                   	push   %ebx
 7e6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7ec:	8b 15 f4 0b 00 00    	mov    0xbf4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f2:	8d 78 07             	lea    0x7(%eax),%edi
 7f5:	c1 ef 03             	shr    $0x3,%edi
 7f8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7fb:	85 d2                	test   %edx,%edx
 7fd:	0f 84 9d 00 00 00    	je     8a0 <malloc+0xc0>
 803:	8b 02                	mov    (%edx),%eax
 805:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 808:	39 cf                	cmp    %ecx,%edi
 80a:	76 6c                	jbe    878 <malloc+0x98>
 80c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 812:	bb 00 10 00 00       	mov    $0x1000,%ebx
 817:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 81a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 821:	eb 0e                	jmp    831 <malloc+0x51>
 823:	90                   	nop
 824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 828:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 82a:	8b 48 04             	mov    0x4(%eax),%ecx
 82d:	39 f9                	cmp    %edi,%ecx
 82f:	73 47                	jae    878 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 831:	39 05 f4 0b 00 00    	cmp    %eax,0xbf4
 837:	89 c2                	mov    %eax,%edx
 839:	75 ed                	jne    828 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 83b:	83 ec 0c             	sub    $0xc,%esp
 83e:	56                   	push   %esi
 83f:	e8 de fb ff ff       	call   422 <sbrk>
  if(p == (char*)-1)
 844:	83 c4 10             	add    $0x10,%esp
 847:	83 f8 ff             	cmp    $0xffffffff,%eax
 84a:	74 1c                	je     868 <malloc+0x88>
  hp->s.size = nu;
 84c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 84f:	83 ec 0c             	sub    $0xc,%esp
 852:	83 c0 08             	add    $0x8,%eax
 855:	50                   	push   %eax
 856:	e8 f5 fe ff ff       	call   750 <free>
  return freep;
 85b:	8b 15 f4 0b 00 00    	mov    0xbf4,%edx
      if((p = morecore(nunits)) == 0)
 861:	83 c4 10             	add    $0x10,%esp
 864:	85 d2                	test   %edx,%edx
 866:	75 c0                	jne    828 <malloc+0x48>
        return 0;
  }
}
 868:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 86b:	31 c0                	xor    %eax,%eax
}
 86d:	5b                   	pop    %ebx
 86e:	5e                   	pop    %esi
 86f:	5f                   	pop    %edi
 870:	5d                   	pop    %ebp
 871:	c3                   	ret    
 872:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 878:	39 cf                	cmp    %ecx,%edi
 87a:	74 54                	je     8d0 <malloc+0xf0>
        p->s.size -= nunits;
 87c:	29 f9                	sub    %edi,%ecx
 87e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 881:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 884:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 887:	89 15 f4 0b 00 00    	mov    %edx,0xbf4
}
 88d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 890:	83 c0 08             	add    $0x8,%eax
}
 893:	5b                   	pop    %ebx
 894:	5e                   	pop    %esi
 895:	5f                   	pop    %edi
 896:	5d                   	pop    %ebp
 897:	c3                   	ret    
 898:	90                   	nop
 899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 8a0:	c7 05 f4 0b 00 00 f8 	movl   $0xbf8,0xbf4
 8a7:	0b 00 00 
 8aa:	c7 05 f8 0b 00 00 f8 	movl   $0xbf8,0xbf8
 8b1:	0b 00 00 
    base.s.size = 0;
 8b4:	b8 f8 0b 00 00       	mov    $0xbf8,%eax
 8b9:	c7 05 fc 0b 00 00 00 	movl   $0x0,0xbfc
 8c0:	00 00 00 
 8c3:	e9 44 ff ff ff       	jmp    80c <malloc+0x2c>
 8c8:	90                   	nop
 8c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 8d0:	8b 08                	mov    (%eax),%ecx
 8d2:	89 0a                	mov    %ecx,(%edx)
 8d4:	eb b1                	jmp    887 <malloc+0xa7>
