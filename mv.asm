
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
  21:	68 98 08 00 00       	push   $0x898
  26:	6a 02                	push   $0x2
  28:	e8 a3 06 00 00       	call   6d0 <fprintf>
        exit();
  2d:	e8 20 03 00 00       	call   352 <exit>
    }
    //check if source and destination can open
    int src = open(argv[1], O_RDONLY);
  32:	56                   	push   %esi
  33:	56                   	push   %esi
  34:	6a 00                	push   $0x0
  36:	ff 77 04             	pushl  0x4(%edi)
  39:	e8 5c 03 00 00       	call   39a <open>
  3e:	89 c6                	mov    %eax,%esi
    int dest = open(argv[2], O_CREATE|O_RDWR);
  40:	58                   	pop    %eax
  41:	5a                   	pop    %edx
  42:	68 02 02 00 00       	push   $0x202
  47:	ff 77 08             	pushl  0x8(%edi)
  4a:	e8 4b 03 00 00       	call   39a <open>
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
  7b:	e8 fa 02 00 00       	call   37a <write>
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
  9d:	e8 e0 02 00 00       	call   382 <close>
    close(dest);
  a2:	58                   	pop    %eax
  a3:	ff b5 e4 fd ff ff    	pushl  -0x21c(%ebp)
  a9:	e8 d4 02 00 00       	call   382 <close>
    // then we remove the original
    if (unlink(argv[1]) < 0)
  ae:	5a                   	pop    %edx
  af:	ff 77 04             	pushl  0x4(%edi)
  b2:	e8 f3 02 00 00       	call   3aa <unlink>
  b7:	83 c4 10             	add    $0x10,%esp
  ba:	85 c0                	test   %eax,%eax
  bc:	78 2f                	js     ed <main+0xed>
      printf("Unable to move the file. Copy made instead.");
    exit();
  be:	e8 8f 02 00 00       	call   352 <exit>
        fprintf(2, "Cannot open file for moving: %s \n", argv[1]);
  c3:	53                   	push   %ebx
  c4:	ff 77 04             	pushl  0x4(%edi)
  c7:	68 b8 08 00 00       	push   $0x8b8
  cc:	6a 02                	push   $0x2
  ce:	e8 fd 05 00 00       	call   6d0 <fprintf>
        exit();
  d3:	e8 7a 02 00 00       	call   352 <exit>
        fprintf(2, "Cannot place file in destination: %s \n ", argv[2]);
  d8:	51                   	push   %ecx
  d9:	ff 77 08             	pushl  0x8(%edi)
  dc:	68 dc 08 00 00       	push   $0x8dc
  e1:	6a 02                	push   $0x2
  e3:	e8 e8 05 00 00       	call   6d0 <fprintf>
        exit();
  e8:	e8 65 02 00 00       	call   352 <exit>
      printf("Unable to move the file. Copy made instead.");
  ed:	83 ec 0c             	sub    $0xc,%esp
  f0:	68 04 09 00 00       	push   $0x904
  f5:	e8 f6 05 00 00       	call   6f0 <printf>
  fa:	83 c4 10             	add    $0x10,%esp
  fd:	eb bf                	jmp    be <main+0xbe>
  ff:	90                   	nop

00000100 <strcpy>:
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	53                   	push   %ebx
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 10a:	89 c2                	mov    %eax,%edx
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 110:	83 c1 01             	add    $0x1,%ecx
 113:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 117:	83 c2 01             	add    $0x1,%edx
 11a:	84 db                	test   %bl,%bl
 11c:	88 5a ff             	mov    %bl,-0x1(%edx)
 11f:	75 ef                	jne    110 <strcpy+0x10>
    ;
  return os;
}
 121:	5b                   	pop    %ebx
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    
 124:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 12a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	8b 55 08             	mov    0x8(%ebp),%edx
 137:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 13a:	0f b6 02             	movzbl (%edx),%eax
 13d:	0f b6 19             	movzbl (%ecx),%ebx
 140:	84 c0                	test   %al,%al
 142:	75 1c                	jne    160 <strcmp+0x30>
 144:	eb 2a                	jmp    170 <strcmp+0x40>
 146:	8d 76 00             	lea    0x0(%esi),%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 150:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 153:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 156:	83 c1 01             	add    $0x1,%ecx
 159:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 15c:	84 c0                	test   %al,%al
 15e:	74 10                	je     170 <strcmp+0x40>
 160:	38 d8                	cmp    %bl,%al
 162:	74 ec                	je     150 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 164:	29 d8                	sub    %ebx,%eax
}
 166:	5b                   	pop    %ebx
 167:	5d                   	pop    %ebp
 168:	c3                   	ret    
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 170:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 172:	29 d8                	sub    %ebx,%eax
}
 174:	5b                   	pop    %ebx
 175:	5d                   	pop    %ebp
 176:	c3                   	ret    
 177:	89 f6                	mov    %esi,%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000180 <strlen>:

uint
strlen(const char *s)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 186:	80 39 00             	cmpb   $0x0,(%ecx)
 189:	74 15                	je     1a0 <strlen+0x20>
 18b:	31 d2                	xor    %edx,%edx
 18d:	8d 76 00             	lea    0x0(%esi),%esi
 190:	83 c2 01             	add    $0x1,%edx
 193:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 197:	89 d0                	mov    %edx,%eax
 199:	75 f5                	jne    190 <strlen+0x10>
    ;
  return n;
}
 19b:	5d                   	pop    %ebp
 19c:	c3                   	ret    
 19d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 1a0:	31 c0                	xor    %eax,%eax
}
 1a2:	5d                   	pop    %ebp
 1a3:	c3                   	ret    
 1a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	57                   	push   %edi
 1b4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 1bd:	89 d7                	mov    %edx,%edi
 1bf:	fc                   	cld    
 1c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1c2:	89 d0                	mov    %edx,%eax
 1c4:	5f                   	pop    %edi
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    
 1c7:	89 f6                	mov    %esi,%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001d0 <strchr>:

char*
strchr(const char *s, char c)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	53                   	push   %ebx
 1d4:	8b 45 08             	mov    0x8(%ebp),%eax
 1d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 1da:	0f b6 10             	movzbl (%eax),%edx
 1dd:	84 d2                	test   %dl,%dl
 1df:	74 1d                	je     1fe <strchr+0x2e>
    if(*s == c)
 1e1:	38 d3                	cmp    %dl,%bl
 1e3:	89 d9                	mov    %ebx,%ecx
 1e5:	75 0d                	jne    1f4 <strchr+0x24>
 1e7:	eb 17                	jmp    200 <strchr+0x30>
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1f0:	38 ca                	cmp    %cl,%dl
 1f2:	74 0c                	je     200 <strchr+0x30>
  for(; *s; s++)
 1f4:	83 c0 01             	add    $0x1,%eax
 1f7:	0f b6 10             	movzbl (%eax),%edx
 1fa:	84 d2                	test   %dl,%dl
 1fc:	75 f2                	jne    1f0 <strchr+0x20>
      return (char*)s;
  return 0;
 1fe:	31 c0                	xor    %eax,%eax
}
 200:	5b                   	pop    %ebx
 201:	5d                   	pop    %ebp
 202:	c3                   	ret    
 203:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <gets>:

char*
gets(char *buf, int max)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	57                   	push   %edi
 214:	56                   	push   %esi
 215:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 216:	31 f6                	xor    %esi,%esi
 218:	89 f3                	mov    %esi,%ebx
{
 21a:	83 ec 1c             	sub    $0x1c,%esp
 21d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 220:	eb 2f                	jmp    251 <gets+0x41>
 222:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 228:	8d 45 e7             	lea    -0x19(%ebp),%eax
 22b:	83 ec 04             	sub    $0x4,%esp
 22e:	6a 01                	push   $0x1
 230:	50                   	push   %eax
 231:	6a 00                	push   $0x0
 233:	e8 32 01 00 00       	call   36a <read>
    if(cc < 1)
 238:	83 c4 10             	add    $0x10,%esp
 23b:	85 c0                	test   %eax,%eax
 23d:	7e 1c                	jle    25b <gets+0x4b>
      break;
    buf[i++] = c;
 23f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 243:	83 c7 01             	add    $0x1,%edi
 246:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 249:	3c 0a                	cmp    $0xa,%al
 24b:	74 23                	je     270 <gets+0x60>
 24d:	3c 0d                	cmp    $0xd,%al
 24f:	74 1f                	je     270 <gets+0x60>
  for(i=0; i+1 < max; ){
 251:	83 c3 01             	add    $0x1,%ebx
 254:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 257:	89 fe                	mov    %edi,%esi
 259:	7c cd                	jl     228 <gets+0x18>
 25b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 25d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 260:	c6 03 00             	movb   $0x0,(%ebx)
}
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
  buf[i] = '\0';
 27a:	c6 03 00             	movb   $0x0,(%ebx)
}
 27d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 280:	5b                   	pop    %ebx
 281:	5e                   	pop    %esi
 282:	5f                   	pop    %edi
 283:	5d                   	pop    %ebp
 284:	c3                   	ret    
 285:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 295:	83 ec 08             	sub    $0x8,%esp
 298:	6a 00                	push   $0x0
 29a:	ff 75 08             	pushl  0x8(%ebp)
 29d:	e8 f8 00 00 00       	call   39a <open>
  if(fd < 0)
 2a2:	83 c4 10             	add    $0x10,%esp
 2a5:	85 c0                	test   %eax,%eax
 2a7:	78 27                	js     2d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2a9:	83 ec 08             	sub    $0x8,%esp
 2ac:	ff 75 0c             	pushl  0xc(%ebp)
 2af:	89 c3                	mov    %eax,%ebx
 2b1:	50                   	push   %eax
 2b2:	e8 fb 00 00 00       	call   3b2 <fstat>
  close(fd);
 2b7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2ba:	89 c6                	mov    %eax,%esi
  close(fd);
 2bc:	e8 c1 00 00 00       	call   382 <close>
  return r;
 2c1:	83 c4 10             	add    $0x10,%esp
}
 2c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2c7:	89 f0                	mov    %esi,%eax
 2c9:	5b                   	pop    %ebx
 2ca:	5e                   	pop    %esi
 2cb:	5d                   	pop    %ebp
 2cc:	c3                   	ret    
 2cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2d5:	eb ed                	jmp    2c4 <stat+0x34>
 2d7:	89 f6                	mov    %esi,%esi
 2d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002e0 <atoi>:

int
atoi(const char *s)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	53                   	push   %ebx
 2e4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e7:	0f be 11             	movsbl (%ecx),%edx
 2ea:	8d 42 d0             	lea    -0x30(%edx),%eax
 2ed:	3c 09                	cmp    $0x9,%al
  n = 0;
 2ef:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 2f4:	77 1f                	ja     315 <atoi+0x35>
 2f6:	8d 76 00             	lea    0x0(%esi),%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 300:	8d 04 80             	lea    (%eax,%eax,4),%eax
 303:	83 c1 01             	add    $0x1,%ecx
 306:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 30a:	0f be 11             	movsbl (%ecx),%edx
 30d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 310:	80 fb 09             	cmp    $0x9,%bl
 313:	76 eb                	jbe    300 <atoi+0x20>
  return n;
}
 315:	5b                   	pop    %ebx
 316:	5d                   	pop    %ebp
 317:	c3                   	ret    
 318:	90                   	nop
 319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000320 <memmove>:


void*
memmove(void *vdst, const void *vsrc, int n)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	56                   	push   %esi
 324:	53                   	push   %ebx
 325:	8b 5d 10             	mov    0x10(%ebp),%ebx
 328:	8b 45 08             	mov    0x8(%ebp),%eax
 32b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 32e:	85 db                	test   %ebx,%ebx
 330:	7e 14                	jle    346 <memmove+0x26>
 332:	31 d2                	xor    %edx,%edx
 334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 338:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 33c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 33f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 342:	39 d3                	cmp    %edx,%ebx
 344:	75 f2                	jne    338 <memmove+0x18>
  return vdst;
}
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

00000372 <steal>:
SYSCALL(steal)
 372:	b8 17 00 00 00       	mov    $0x17,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <write>:
SYSCALL(write)
 37a:	b8 10 00 00 00       	mov    $0x10,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <close>:
SYSCALL(close)
 382:	b8 15 00 00 00       	mov    $0x15,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <kill>:
SYSCALL(kill)
 38a:	b8 06 00 00 00       	mov    $0x6,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <exec>:
SYSCALL(exec)
 392:	b8 07 00 00 00       	mov    $0x7,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <open>:
SYSCALL(open)
 39a:	b8 0f 00 00 00       	mov    $0xf,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <mknod>:
SYSCALL(mknod)
 3a2:	b8 11 00 00 00       	mov    $0x11,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <unlink>:
SYSCALL(unlink)
 3aa:	b8 12 00 00 00       	mov    $0x12,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <fstat>:
SYSCALL(fstat)
 3b2:	b8 08 00 00 00       	mov    $0x8,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <link>:
SYSCALL(link)
 3ba:	b8 13 00 00 00       	mov    $0x13,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <mkdir>:
SYSCALL(mkdir)
 3c2:	b8 14 00 00 00       	mov    $0x14,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <chdir>:
SYSCALL(chdir)
 3ca:	b8 09 00 00 00       	mov    $0x9,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <dup>:
SYSCALL(dup)
 3d2:	b8 0a 00 00 00       	mov    $0xa,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <getpid>:
SYSCALL(getpid)
 3da:	b8 0b 00 00 00       	mov    $0xb,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <sbrk>:
SYSCALL(sbrk)
 3e2:	b8 0c 00 00 00       	mov    $0xc,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <sleep>:
SYSCALL(sleep)
 3ea:	b8 0d 00 00 00       	mov    $0xd,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <uptime>:
SYSCALL(uptime)
 3f2:	b8 0e 00 00 00       	mov    $0xe,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <cpuhalt>:
SYSCALL(cpuhalt)
 3fa:	b8 16 00 00 00       	mov    $0x16,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    
 402:	66 90                	xchg   %ax,%ax
 404:	66 90                	xchg   %ax,%ax
 406:	66 90                	xchg   %ax,%ax
 408:	66 90                	xchg   %ax,%ax
 40a:	66 90                	xchg   %ax,%ax
 40c:	66 90                	xchg   %ax,%ax
 40e:	66 90                	xchg   %ax,%ax

00000410 <printint.constprop.1>:
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
}

static void
printint(int fd, int xx, int base, int sgn)
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	89 d6                	mov    %edx,%esi
 418:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 41b:	85 c0                	test   %eax,%eax
 41d:	79 71                	jns    490 <printint.constprop.1+0x80>
 41f:	83 e1 01             	and    $0x1,%ecx
 422:	74 6c                	je     490 <printint.constprop.1+0x80>
    neg = 1;
    x = -xx;
 424:	f7 d8                	neg    %eax
    neg = 1;
 426:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 42d:	31 c9                	xor    %ecx,%ecx
 42f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 432:	eb 06                	jmp    43a <printint.constprop.1+0x2a>
 434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 438:	89 f9                	mov    %edi,%ecx
 43a:	31 d2                	xor    %edx,%edx
 43c:	8d 79 01             	lea    0x1(%ecx),%edi
 43f:	f7 f6                	div    %esi
 441:	0f b6 92 38 09 00 00 	movzbl 0x938(%edx),%edx
  }while((x /= base) != 0);
 448:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 44a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 44d:	75 e9                	jne    438 <printint.constprop.1+0x28>
  if(neg)
 44f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 452:	85 c0                	test   %eax,%eax
 454:	74 08                	je     45e <printint.constprop.1+0x4e>
    buf[i++] = '-';
 456:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 45b:	8d 79 02             	lea    0x2(%ecx),%edi
 45e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 462:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 468:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 46b:	83 ec 04             	sub    $0x4,%esp
 46e:	83 ee 01             	sub    $0x1,%esi
 471:	6a 01                	push   $0x1
 473:	53                   	push   %ebx
 474:	6a 01                	push   $0x1
 476:	88 45 d7             	mov    %al,-0x29(%ebp)
 479:	e8 fc fe ff ff       	call   37a <write>

  while(--i >= 0)
 47e:	83 c4 10             	add    $0x10,%esp
 481:	39 de                	cmp    %ebx,%esi
 483:	75 e3                	jne    468 <printint.constprop.1+0x58>
    putc(fd, buf[i]);
}
 485:	8d 65 f4             	lea    -0xc(%ebp),%esp
 488:	5b                   	pop    %ebx
 489:	5e                   	pop    %esi
 48a:	5f                   	pop    %edi
 48b:	5d                   	pop    %ebp
 48c:	c3                   	ret    
 48d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 490:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 497:	eb 94                	jmp    42d <printint.constprop.1+0x1d>
 499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004a0 <vprintf.constprop.0>:
static void vprintf(int fd, const char *fmt, va_list ap)
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	53                   	push   %ebx
 4a6:	89 d6                	mov    %edx,%esi
 4a8:	83 ec 2c             	sub    $0x2c,%esp
{
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4ab:	0f b6 10             	movzbl (%eax),%edx
 4ae:	84 d2                	test   %dl,%dl
 4b0:	0f 84 cd 00 00 00    	je     583 <vprintf.constprop.0+0xe3>
 4b6:	8d 58 01             	lea    0x1(%eax),%ebx
  state = 0;
 4b9:	31 ff                	xor    %edi,%edi
 4bb:	eb 31                	jmp    4ee <vprintf.constprop.0+0x4e>
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4c0:	83 f8 25             	cmp    $0x25,%eax
 4c3:	0f 84 c7 00 00 00    	je     590 <vprintf.constprop.0+0xf0>
  write(fd, &c, 1);
 4c9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4cc:	83 ec 04             	sub    $0x4,%esp
 4cf:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 4d2:	6a 01                	push   $0x1
 4d4:	50                   	push   %eax
 4d5:	6a 01                	push   $0x1
 4d7:	e8 9e fe ff ff       	call   37a <write>
 4dc:	83 c4 10             	add    $0x10,%esp
 4df:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 4e2:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4e6:	84 d2                	test   %dl,%dl
 4e8:	0f 84 95 00 00 00    	je     583 <vprintf.constprop.0+0xe3>
    if(state == 0){
 4ee:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 4f0:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 4f3:	74 cb                	je     4c0 <vprintf.constprop.0+0x20>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4f5:	83 ff 25             	cmp    $0x25,%edi
 4f8:	75 e5                	jne    4df <vprintf.constprop.0+0x3f>
      if(c == 'd'){
 4fa:	83 f8 64             	cmp    $0x64,%eax
        printint(fd, va_arg(ap, int), 10, 1);
 4fd:	8d 7e 04             	lea    0x4(%esi),%edi
 500:	b9 01 00 00 00       	mov    $0x1,%ecx
      if(c == 'd'){
 505:	0f 84 9a 00 00 00    	je     5a5 <vprintf.constprop.0+0x105>
      } else if(c == 'l') {
 50b:	83 f8 6c             	cmp    $0x6c,%eax
 50e:	0f 84 8c 00 00 00    	je     5a0 <vprintf.constprop.0+0x100>
        printint(fd, va_arg(ap, uint), 10, 0);
      } else if(c == 'x') {
 514:	83 f8 78             	cmp    $0x78,%eax
 517:	0f 84 a3 00 00 00    	je     5c0 <vprintf.constprop.0+0x120>
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 51d:	83 f8 70             	cmp    $0x70,%eax
 520:	0f 84 ca 00 00 00    	je     5f0 <vprintf.constprop.0+0x150>
        printptr(fd, va_arg(ap, uint));
      } else if(c == 's'){
 526:	83 f8 73             	cmp    $0x73,%eax
 529:	0f 84 39 01 00 00    	je     668 <vprintf.constprop.0+0x1c8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 52f:	83 f8 63             	cmp    $0x63,%eax
 532:	0f 84 68 01 00 00    	je     6a0 <vprintf.constprop.0+0x200>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 538:	83 f8 25             	cmp    $0x25,%eax
 53b:	0f 84 9f 00 00 00    	je     5e0 <vprintf.constprop.0+0x140>
  write(fd, &c, 1);
 541:	8d 45 df             	lea    -0x21(%ebp),%eax
 544:	83 ec 04             	sub    $0x4,%esp
 547:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 54a:	6a 01                	push   $0x1
 54c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 550:	50                   	push   %eax
 551:	6a 01                	push   $0x1
 553:	e8 22 fe ff ff       	call   37a <write>
 558:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 55c:	83 c4 0c             	add    $0xc,%esp
 55f:	8d 45 e0             	lea    -0x20(%ebp),%eax
 562:	6a 01                	push   $0x1
 564:	88 55 e0             	mov    %dl,-0x20(%ebp)
 567:	50                   	push   %eax
 568:	6a 01                	push   $0x1
 56a:	83 c3 01             	add    $0x1,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 56d:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 56f:	e8 06 fe ff ff       	call   37a <write>
  for(i = 0; fmt[i]; i++){
 574:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
  write(fd, &c, 1);
 578:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 57b:	84 d2                	test   %dl,%dl
 57d:	0f 85 6b ff ff ff    	jne    4ee <vprintf.constprop.0+0x4e>
    }
  }
}
 583:	8d 65 f4             	lea    -0xc(%ebp),%esp
 586:	5b                   	pop    %ebx
 587:	5e                   	pop    %esi
 588:	5f                   	pop    %edi
 589:	5d                   	pop    %ebp
 58a:	c3                   	ret    
 58b:	90                   	nop
 58c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        state = '%';
 590:	bf 25 00 00 00       	mov    $0x25,%edi
 595:	e9 45 ff ff ff       	jmp    4df <vprintf.constprop.0+0x3f>
 59a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, uint), 10, 0);
 5a0:	8d 7e 04             	lea    0x4(%esi),%edi
 5a3:	31 c9                	xor    %ecx,%ecx
 5a5:	8b 06                	mov    (%esi),%eax
 5a7:	ba 0a 00 00 00       	mov    $0xa,%edx
 5ac:	89 fe                	mov    %edi,%esi
      state = 0;
 5ae:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, uint), 10, 0);
 5b0:	e8 5b fe ff ff       	call   410 <printint.constprop.1>
 5b5:	e9 25 ff ff ff       	jmp    4df <vprintf.constprop.0+0x3f>
 5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, int), 16, 0);
 5c0:	8b 06                	mov    (%esi),%eax
 5c2:	8d 7e 04             	lea    0x4(%esi),%edi
 5c5:	31 c9                	xor    %ecx,%ecx
 5c7:	ba 10 00 00 00       	mov    $0x10,%edx
 5cc:	89 fe                	mov    %edi,%esi
      state = 0;
 5ce:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, int), 16, 0);
 5d0:	e8 3b fe ff ff       	call   410 <printint.constprop.1>
 5d5:	e9 05 ff ff ff       	jmp    4df <vprintf.constprop.0+0x3f>
 5da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5e0:	83 ec 04             	sub    $0x4,%esp
 5e3:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 5e6:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 5e9:	6a 01                	push   $0x1
 5eb:	e9 77 ff ff ff       	jmp    567 <vprintf.constprop.0+0xc7>
        printptr(fd, va_arg(ap, uint));
 5f0:	8d 46 04             	lea    0x4(%esi),%eax
  write(fd, &c, 1);
 5f3:	83 ec 04             	sub    $0x4,%esp
        printptr(fd, va_arg(ap, uint));
 5f6:	8b 3e                	mov    (%esi),%edi
  write(fd, &c, 1);
 5f8:	6a 01                	push   $0x1
 5fa:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 5fe:	be 08 00 00 00       	mov    $0x8,%esi
        printptr(fd, va_arg(ap, uint));
 603:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 606:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 609:	50                   	push   %eax
 60a:	6a 01                	push   $0x1
 60c:	e8 69 fd ff ff       	call   37a <write>
 611:	8d 45 e7             	lea    -0x19(%ebp),%eax
 614:	83 c4 0c             	add    $0xc,%esp
 617:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 61b:	6a 01                	push   $0x1
 61d:	50                   	push   %eax
 61e:	6a 01                	push   $0x1
 620:	e8 55 fd ff ff       	call   37a <write>
 625:	83 c4 10             	add    $0x10,%esp
 628:	90                   	nop
 629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
 630:	89 f8                	mov    %edi,%eax
  write(fd, &c, 1);
 632:	83 ec 04             	sub    $0x4,%esp
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
 635:	c1 e7 04             	shl    $0x4,%edi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
 638:	c1 e8 1c             	shr    $0x1c,%eax
  write(fd, &c, 1);
 63b:	6a 01                	push   $0x1
 63d:	0f b6 80 38 09 00 00 	movzbl 0x938(%eax),%eax
 644:	88 45 e5             	mov    %al,-0x1b(%ebp)
 647:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 64a:	50                   	push   %eax
 64b:	6a 01                	push   $0x1
 64d:	e8 28 fd ff ff       	call   37a <write>
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
 652:	83 c4 10             	add    $0x10,%esp
 655:	83 ee 01             	sub    $0x1,%esi
 658:	75 d6                	jne    630 <vprintf.constprop.0+0x190>
        s = va_arg(ap, char*);
 65a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 65d:	31 ff                	xor    %edi,%edi
 65f:	e9 7b fe ff ff       	jmp    4df <vprintf.constprop.0+0x3f>
 664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = va_arg(ap, char*);
 668:	8b 3e                	mov    (%esi),%edi
 66a:	8d 46 04             	lea    0x4(%esi),%eax
 66d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 670:	85 ff                	test   %edi,%edi
 672:	74 50                	je     6c4 <vprintf.constprop.0+0x224>
        while(*s != 0){
 674:	0f b6 07             	movzbl (%edi),%eax
 677:	84 c0                	test   %al,%al
 679:	74 df                	je     65a <vprintf.constprop.0+0x1ba>
 67b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 67e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 680:	83 ec 04             	sub    $0x4,%esp
          s++;
 683:	83 c7 01             	add    $0x1,%edi
 686:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 689:	6a 01                	push   $0x1
 68b:	56                   	push   %esi
 68c:	6a 01                	push   $0x1
 68e:	e8 e7 fc ff ff       	call   37a <write>
        while(*s != 0){
 693:	0f b6 07             	movzbl (%edi),%eax
 696:	83 c4 10             	add    $0x10,%esp
 699:	84 c0                	test   %al,%al
 69b:	75 e3                	jne    680 <vprintf.constprop.0+0x1e0>
 69d:	eb bb                	jmp    65a <vprintf.constprop.0+0x1ba>
 69f:	90                   	nop
        putc(fd, va_arg(ap, uint));
 6a0:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 6a2:	83 ec 04             	sub    $0x4,%esp
        putc(fd, va_arg(ap, uint));
 6a5:	8d 7e 04             	lea    0x4(%esi),%edi
  write(fd, &c, 1);
 6a8:	6a 01                	push   $0x1
        putc(fd, va_arg(ap, uint));
 6aa:	89 fe                	mov    %edi,%esi
      state = 0;
 6ac:	31 ff                	xor    %edi,%edi
        putc(fd, va_arg(ap, uint));
 6ae:	88 45 e2             	mov    %al,-0x1e(%ebp)
  write(fd, &c, 1);
 6b1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6b4:	50                   	push   %eax
 6b5:	6a 01                	push   $0x1
 6b7:	e8 be fc ff ff       	call   37a <write>
 6bc:	83 c4 10             	add    $0x10,%esp
 6bf:	e9 1b fe ff ff       	jmp    4df <vprintf.constprop.0+0x3f>
          s = "(null)";
 6c4:	bf 30 09 00 00       	mov    $0x930,%edi
        while(*s != 0){
 6c9:	b8 28 00 00 00       	mov    $0x28,%eax
 6ce:	eb ab                	jmp    67b <vprintf.constprop.0+0x1db>

000006d0 <fprintf>:
// Print to the given fd. Only understands %d,%x, %p, %s, %c.
void
fprintf(int fd, const char *fmt, ...)
{
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	83 ec 08             	sub    $0x8,%esp
 va_list ap;
 va_start(ap, fmt); 
 vprintf(1,fmt,ap);
 6d6:	8b 45 0c             	mov    0xc(%ebp),%eax
 6d9:	8d 55 10             	lea    0x10(%ebp),%edx
 6dc:	e8 bf fd ff ff       	call   4a0 <vprintf.constprop.0>
}
 6e1:	c9                   	leave  
 6e2:	c3                   	ret    
 6e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006f0 <printf>:
void
printf(const char *fmt, ...)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	83 ec 08             	sub    $0x8,%esp
  va_list ap;
  va_start(ap, fmt); 
  vprintf(1,fmt,ap);
 6f6:	8b 45 08             	mov    0x8(%ebp),%eax
 6f9:	8d 55 0c             	lea    0xc(%ebp),%edx
 6fc:	e8 9f fd ff ff       	call   4a0 <vprintf.constprop.0>
}
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
 711:	a1 28 0c 00 00       	mov    0xc28,%eax
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
 74f:	a3 28 0c 00 00       	mov    %eax,0xc28
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
 78a:	a3 28 0c 00 00       	mov    %eax,0xc28
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
 7ac:	8b 15 28 0c 00 00    	mov    0xc28,%edx
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
 7f1:	39 05 28 0c 00 00    	cmp    %eax,0xc28
 7f7:	89 c2                	mov    %eax,%edx
 7f9:	75 ed                	jne    7e8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 7fb:	83 ec 0c             	sub    $0xc,%esp
 7fe:	56                   	push   %esi
 7ff:	e8 de fb ff ff       	call   3e2 <sbrk>
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
 81b:	8b 15 28 0c 00 00    	mov    0xc28,%edx
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
 847:	89 15 28 0c 00 00    	mov    %edx,0xc28
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
 860:	c7 05 28 0c 00 00 2c 	movl   $0xc2c,0xc28
 867:	0c 00 00 
 86a:	c7 05 2c 0c 00 00 2c 	movl   $0xc2c,0xc2c
 871:	0c 00 00 
    base.s.size = 0;
 874:	b8 2c 0c 00 00       	mov    $0xc2c,%eax
 879:	c7 05 30 0c 00 00 00 	movl   $0x0,0xc30
 880:	00 00 00 
 883:	e9 44 ff ff ff       	jmp    7cc <malloc+0x2c>
 888:	90                   	nop
 889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 890:	8b 08                	mov    (%eax),%ecx
 892:	89 0a                	mov    %ecx,(%edx)
 894:	eb b1                	jmp    847 <malloc+0xa7>
