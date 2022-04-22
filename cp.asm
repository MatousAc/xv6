
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
  21:	68 88 08 00 00       	push   $0x888
  26:	6a 02                	push   $0x2
  28:	e8 93 06 00 00       	call   6c0 <fprintf>
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
  3f:	e8 46 03 00 00       	call   38a <open>
    int destf = open(argv[2], O_CREATE|O_RDWR); // dest file
  44:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
    int srcf = open(argv[1], O_RDONLY); //src file
  4a:	89 c6                	mov    %eax,%esi
    int destf = open(argv[2], O_CREATE|O_RDWR); // dest file
  4c:	5f                   	pop    %edi
  4d:	58                   	pop    %eax
  4e:	68 02 02 00 00       	push   $0x202
  53:	ff 72 08             	pushl  0x8(%edx)
  56:	e8 2f 03 00 00       	call   38a <open>
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
  86:	e8 df 02 00 00       	call   36a <write>
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
  a8:	e8 c5 02 00 00       	call   372 <close>
    close(destf);
  ad:	89 3c 24             	mov    %edi,(%esp)
  b0:	e8 bd 02 00 00       	call   372 <close>
    exit();
  b5:	e8 88 02 00 00       	call   342 <exit>
        fprintf(2, "Cannot open source file: %s \n", argv[1]);
  ba:	51                   	push   %ecx
  bb:	ff 72 04             	pushl  0x4(%edx)
  be:	68 e0 08 00 00       	push   $0x8e0
  c3:	6a 02                	push   $0x2
  c5:	e8 f6 05 00 00       	call   6c0 <fprintf>
        exit();
  ca:	e8 73 02 00 00       	call   342 <exit>
        fprintf(2, "Cannot open / Read or write destination file: %s \n ", argv[2]);
  cf:	50                   	push   %eax
  d0:	ff 72 08             	pushl  0x8(%edx)
  d3:	68 ac 08 00 00       	push   $0x8ac
  d8:	6a 02                	push   $0x2
  da:	e8 e1 05 00 00       	call   6c0 <fprintf>
        exit();
  df:	e8 5e 02 00 00       	call   342 <exit>
  e4:	66 90                	xchg   %ax,%ax
  e6:	66 90                	xchg   %ax,%ax
  e8:	66 90                	xchg   %ax,%ax
  ea:	66 90                	xchg   %ax,%ax
  ec:	66 90                	xchg   %ax,%ax
  ee:	66 90                	xchg   %ax,%ax

000000f0 <strcpy>:
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	53                   	push   %ebx
  f4:	8b 45 08             	mov    0x8(%ebp),%eax
  f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  fa:	89 c2                	mov    %eax,%edx
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 100:	83 c1 01             	add    $0x1,%ecx
 103:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 107:	83 c2 01             	add    $0x1,%edx
 10a:	84 db                	test   %bl,%bl
 10c:	88 5a ff             	mov    %bl,-0x1(%edx)
 10f:	75 ef                	jne    100 <strcpy+0x10>
    ;
  return os;
}
 111:	5b                   	pop    %ebx
 112:	5d                   	pop    %ebp
 113:	c3                   	ret    
 114:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 11a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	53                   	push   %ebx
 124:	8b 55 08             	mov    0x8(%ebp),%edx
 127:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 12a:	0f b6 02             	movzbl (%edx),%eax
 12d:	0f b6 19             	movzbl (%ecx),%ebx
 130:	84 c0                	test   %al,%al
 132:	75 1c                	jne    150 <strcmp+0x30>
 134:	eb 2a                	jmp    160 <strcmp+0x40>
 136:	8d 76 00             	lea    0x0(%esi),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 140:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 143:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 146:	83 c1 01             	add    $0x1,%ecx
 149:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 14c:	84 c0                	test   %al,%al
 14e:	74 10                	je     160 <strcmp+0x40>
 150:	38 d8                	cmp    %bl,%al
 152:	74 ec                	je     140 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 154:	29 d8                	sub    %ebx,%eax
}
 156:	5b                   	pop    %ebx
 157:	5d                   	pop    %ebp
 158:	c3                   	ret    
 159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 160:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 162:	29 d8                	sub    %ebx,%eax
}
 164:	5b                   	pop    %ebx
 165:	5d                   	pop    %ebp
 166:	c3                   	ret    
 167:	89 f6                	mov    %esi,%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <strlen>:

uint
strlen(const char *s)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 176:	80 39 00             	cmpb   $0x0,(%ecx)
 179:	74 15                	je     190 <strlen+0x20>
 17b:	31 d2                	xor    %edx,%edx
 17d:	8d 76 00             	lea    0x0(%esi),%esi
 180:	83 c2 01             	add    $0x1,%edx
 183:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 187:	89 d0                	mov    %edx,%eax
 189:	75 f5                	jne    180 <strlen+0x10>
    ;
  return n;
}
 18b:	5d                   	pop    %ebp
 18c:	c3                   	ret    
 18d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 190:	31 c0                	xor    %eax,%eax
}
 192:	5d                   	pop    %ebp
 193:	c3                   	ret    
 194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 19a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ad:	89 d7                	mov    %edx,%edi
 1af:	fc                   	cld    
 1b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1b2:	89 d0                	mov    %edx,%eax
 1b4:	5f                   	pop    %edi
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	89 f6                	mov    %esi,%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <strchr>:

char*
strchr(const char *s, char c)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	53                   	push   %ebx
 1c4:	8b 45 08             	mov    0x8(%ebp),%eax
 1c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 1ca:	0f b6 10             	movzbl (%eax),%edx
 1cd:	84 d2                	test   %dl,%dl
 1cf:	74 1d                	je     1ee <strchr+0x2e>
    if(*s == c)
 1d1:	38 d3                	cmp    %dl,%bl
 1d3:	89 d9                	mov    %ebx,%ecx
 1d5:	75 0d                	jne    1e4 <strchr+0x24>
 1d7:	eb 17                	jmp    1f0 <strchr+0x30>
 1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1e0:	38 ca                	cmp    %cl,%dl
 1e2:	74 0c                	je     1f0 <strchr+0x30>
  for(; *s; s++)
 1e4:	83 c0 01             	add    $0x1,%eax
 1e7:	0f b6 10             	movzbl (%eax),%edx
 1ea:	84 d2                	test   %dl,%dl
 1ec:	75 f2                	jne    1e0 <strchr+0x20>
      return (char*)s;
  return 0;
 1ee:	31 c0                	xor    %eax,%eax
}
 1f0:	5b                   	pop    %ebx
 1f1:	5d                   	pop    %ebp
 1f2:	c3                   	ret    
 1f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <gets>:

char*
gets(char *buf, int max)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
 204:	56                   	push   %esi
 205:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 206:	31 f6                	xor    %esi,%esi
 208:	89 f3                	mov    %esi,%ebx
{
 20a:	83 ec 1c             	sub    $0x1c,%esp
 20d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 210:	eb 2f                	jmp    241 <gets+0x41>
 212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 218:	8d 45 e7             	lea    -0x19(%ebp),%eax
 21b:	83 ec 04             	sub    $0x4,%esp
 21e:	6a 01                	push   $0x1
 220:	50                   	push   %eax
 221:	6a 00                	push   $0x0
 223:	e8 32 01 00 00       	call   35a <read>
    if(cc < 1)
 228:	83 c4 10             	add    $0x10,%esp
 22b:	85 c0                	test   %eax,%eax
 22d:	7e 1c                	jle    24b <gets+0x4b>
      break;
    buf[i++] = c;
 22f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 233:	83 c7 01             	add    $0x1,%edi
 236:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 239:	3c 0a                	cmp    $0xa,%al
 23b:	74 23                	je     260 <gets+0x60>
 23d:	3c 0d                	cmp    $0xd,%al
 23f:	74 1f                	je     260 <gets+0x60>
  for(i=0; i+1 < max; ){
 241:	83 c3 01             	add    $0x1,%ebx
 244:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 247:	89 fe                	mov    %edi,%esi
 249:	7c cd                	jl     218 <gets+0x18>
 24b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 24d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 250:	c6 03 00             	movb   $0x0,(%ebx)
}
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
  buf[i] = '\0';
 26a:	c6 03 00             	movb   $0x0,(%ebx)
}
 26d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 270:	5b                   	pop    %ebx
 271:	5e                   	pop    %esi
 272:	5f                   	pop    %edi
 273:	5d                   	pop    %ebp
 274:	c3                   	ret    
 275:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000280 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 285:	83 ec 08             	sub    $0x8,%esp
 288:	6a 00                	push   $0x0
 28a:	ff 75 08             	pushl  0x8(%ebp)
 28d:	e8 f8 00 00 00       	call   38a <open>
  if(fd < 0)
 292:	83 c4 10             	add    $0x10,%esp
 295:	85 c0                	test   %eax,%eax
 297:	78 27                	js     2c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 299:	83 ec 08             	sub    $0x8,%esp
 29c:	ff 75 0c             	pushl  0xc(%ebp)
 29f:	89 c3                	mov    %eax,%ebx
 2a1:	50                   	push   %eax
 2a2:	e8 fb 00 00 00       	call   3a2 <fstat>
  close(fd);
 2a7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2aa:	89 c6                	mov    %eax,%esi
  close(fd);
 2ac:	e8 c1 00 00 00       	call   372 <close>
  return r;
 2b1:	83 c4 10             	add    $0x10,%esp
}
 2b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2b7:	89 f0                	mov    %esi,%eax
 2b9:	5b                   	pop    %ebx
 2ba:	5e                   	pop    %esi
 2bb:	5d                   	pop    %ebp
 2bc:	c3                   	ret    
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2c5:	eb ed                	jmp    2b4 <stat+0x34>
 2c7:	89 f6                	mov    %esi,%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <atoi>:

int
atoi(const char *s)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	53                   	push   %ebx
 2d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d7:	0f be 11             	movsbl (%ecx),%edx
 2da:	8d 42 d0             	lea    -0x30(%edx),%eax
 2dd:	3c 09                	cmp    $0x9,%al
  n = 0;
 2df:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 2e4:	77 1f                	ja     305 <atoi+0x35>
 2e6:	8d 76 00             	lea    0x0(%esi),%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 2f0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2f3:	83 c1 01             	add    $0x1,%ecx
 2f6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 2fa:	0f be 11             	movsbl (%ecx),%edx
 2fd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 300:	80 fb 09             	cmp    $0x9,%bl
 303:	76 eb                	jbe    2f0 <atoi+0x20>
  return n;
}
 305:	5b                   	pop    %ebx
 306:	5d                   	pop    %ebp
 307:	c3                   	ret    
 308:	90                   	nop
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000310 <memmove>:


void*
memmove(void *vdst, const void *vsrc, int n)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	56                   	push   %esi
 314:	53                   	push   %ebx
 315:	8b 5d 10             	mov    0x10(%ebp),%ebx
 318:	8b 45 08             	mov    0x8(%ebp),%eax
 31b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 31e:	85 db                	test   %ebx,%ebx
 320:	7e 14                	jle    336 <memmove+0x26>
 322:	31 d2                	xor    %edx,%edx
 324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 328:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 32c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 32f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 332:	39 d3                	cmp    %edx,%ebx
 334:	75 f2                	jne    328 <memmove+0x18>
  return vdst;
}
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

00000362 <steal>:
SYSCALL(steal)
 362:	b8 17 00 00 00       	mov    $0x17,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <write>:
SYSCALL(write)
 36a:	b8 10 00 00 00       	mov    $0x10,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <close>:
SYSCALL(close)
 372:	b8 15 00 00 00       	mov    $0x15,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <kill>:
SYSCALL(kill)
 37a:	b8 06 00 00 00       	mov    $0x6,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <exec>:
SYSCALL(exec)
 382:	b8 07 00 00 00       	mov    $0x7,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <open>:
SYSCALL(open)
 38a:	b8 0f 00 00 00       	mov    $0xf,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <mknod>:
SYSCALL(mknod)
 392:	b8 11 00 00 00       	mov    $0x11,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <unlink>:
SYSCALL(unlink)
 39a:	b8 12 00 00 00       	mov    $0x12,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <fstat>:
SYSCALL(fstat)
 3a2:	b8 08 00 00 00       	mov    $0x8,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <link>:
SYSCALL(link)
 3aa:	b8 13 00 00 00       	mov    $0x13,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <mkdir>:
SYSCALL(mkdir)
 3b2:	b8 14 00 00 00       	mov    $0x14,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <chdir>:
SYSCALL(chdir)
 3ba:	b8 09 00 00 00       	mov    $0x9,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <dup>:
SYSCALL(dup)
 3c2:	b8 0a 00 00 00       	mov    $0xa,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <getpid>:
SYSCALL(getpid)
 3ca:	b8 0b 00 00 00       	mov    $0xb,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <sbrk>:
SYSCALL(sbrk)
 3d2:	b8 0c 00 00 00       	mov    $0xc,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <sleep>:
SYSCALL(sleep)
 3da:	b8 0d 00 00 00       	mov    $0xd,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <uptime>:
SYSCALL(uptime)
 3e2:	b8 0e 00 00 00       	mov    $0xe,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <cpuhalt>:
SYSCALL(cpuhalt)
 3ea:	b8 16 00 00 00       	mov    $0x16,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    
 3f2:	66 90                	xchg   %ax,%ax
 3f4:	66 90                	xchg   %ax,%ax
 3f6:	66 90                	xchg   %ax,%ax
 3f8:	66 90                	xchg   %ax,%ax
 3fa:	66 90                	xchg   %ax,%ax
 3fc:	66 90                	xchg   %ax,%ax
 3fe:	66 90                	xchg   %ax,%ax

00000400 <printint.constprop.1>:
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
}

static void
printint(int fd, int xx, int base, int sgn)
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	89 d6                	mov    %edx,%esi
 408:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 40b:	85 c0                	test   %eax,%eax
 40d:	79 71                	jns    480 <printint.constprop.1+0x80>
 40f:	83 e1 01             	and    $0x1,%ecx
 412:	74 6c                	je     480 <printint.constprop.1+0x80>
    neg = 1;
    x = -xx;
 414:	f7 d8                	neg    %eax
    neg = 1;
 416:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 41d:	31 c9                	xor    %ecx,%ecx
 41f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 422:	eb 06                	jmp    42a <printint.constprop.1+0x2a>
 424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 428:	89 f9                	mov    %edi,%ecx
 42a:	31 d2                	xor    %edx,%edx
 42c:	8d 79 01             	lea    0x1(%ecx),%edi
 42f:	f7 f6                	div    %esi
 431:	0f b6 92 08 09 00 00 	movzbl 0x908(%edx),%edx
  }while((x /= base) != 0);
 438:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 43a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 43d:	75 e9                	jne    428 <printint.constprop.1+0x28>
  if(neg)
 43f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 442:	85 c0                	test   %eax,%eax
 444:	74 08                	je     44e <printint.constprop.1+0x4e>
    buf[i++] = '-';
 446:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 44b:	8d 79 02             	lea    0x2(%ecx),%edi
 44e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 458:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 45b:	83 ec 04             	sub    $0x4,%esp
 45e:	83 ee 01             	sub    $0x1,%esi
 461:	6a 01                	push   $0x1
 463:	53                   	push   %ebx
 464:	6a 01                	push   $0x1
 466:	88 45 d7             	mov    %al,-0x29(%ebp)
 469:	e8 fc fe ff ff       	call   36a <write>

  while(--i >= 0)
 46e:	83 c4 10             	add    $0x10,%esp
 471:	39 de                	cmp    %ebx,%esi
 473:	75 e3                	jne    458 <printint.constprop.1+0x58>
    putc(fd, buf[i]);
}
 475:	8d 65 f4             	lea    -0xc(%ebp),%esp
 478:	5b                   	pop    %ebx
 479:	5e                   	pop    %esi
 47a:	5f                   	pop    %edi
 47b:	5d                   	pop    %ebp
 47c:	c3                   	ret    
 47d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 480:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 487:	eb 94                	jmp    41d <printint.constprop.1+0x1d>
 489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000490 <vprintf.constprop.0>:
static void vprintf(int fd, const char *fmt, va_list ap)
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	89 d6                	mov    %edx,%esi
 498:	83 ec 2c             	sub    $0x2c,%esp
{
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 49b:	0f b6 10             	movzbl (%eax),%edx
 49e:	84 d2                	test   %dl,%dl
 4a0:	0f 84 cd 00 00 00    	je     573 <vprintf.constprop.0+0xe3>
 4a6:	8d 58 01             	lea    0x1(%eax),%ebx
  state = 0;
 4a9:	31 ff                	xor    %edi,%edi
 4ab:	eb 31                	jmp    4de <vprintf.constprop.0+0x4e>
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4b0:	83 f8 25             	cmp    $0x25,%eax
 4b3:	0f 84 c7 00 00 00    	je     580 <vprintf.constprop.0+0xf0>
  write(fd, &c, 1);
 4b9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4bc:	83 ec 04             	sub    $0x4,%esp
 4bf:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 4c2:	6a 01                	push   $0x1
 4c4:	50                   	push   %eax
 4c5:	6a 01                	push   $0x1
 4c7:	e8 9e fe ff ff       	call   36a <write>
 4cc:	83 c4 10             	add    $0x10,%esp
 4cf:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 4d2:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4d6:	84 d2                	test   %dl,%dl
 4d8:	0f 84 95 00 00 00    	je     573 <vprintf.constprop.0+0xe3>
    if(state == 0){
 4de:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 4e0:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 4e3:	74 cb                	je     4b0 <vprintf.constprop.0+0x20>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4e5:	83 ff 25             	cmp    $0x25,%edi
 4e8:	75 e5                	jne    4cf <vprintf.constprop.0+0x3f>
      if(c == 'd'){
 4ea:	83 f8 64             	cmp    $0x64,%eax
        printint(fd, va_arg(ap, int), 10, 1);
 4ed:	8d 7e 04             	lea    0x4(%esi),%edi
 4f0:	b9 01 00 00 00       	mov    $0x1,%ecx
      if(c == 'd'){
 4f5:	0f 84 9a 00 00 00    	je     595 <vprintf.constprop.0+0x105>
      } else if(c == 'l') {
 4fb:	83 f8 6c             	cmp    $0x6c,%eax
 4fe:	0f 84 8c 00 00 00    	je     590 <vprintf.constprop.0+0x100>
        printint(fd, va_arg(ap, uint), 10, 0);
      } else if(c == 'x') {
 504:	83 f8 78             	cmp    $0x78,%eax
 507:	0f 84 a3 00 00 00    	je     5b0 <vprintf.constprop.0+0x120>
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 50d:	83 f8 70             	cmp    $0x70,%eax
 510:	0f 84 ca 00 00 00    	je     5e0 <vprintf.constprop.0+0x150>
        printptr(fd, va_arg(ap, uint));
      } else if(c == 's'){
 516:	83 f8 73             	cmp    $0x73,%eax
 519:	0f 84 39 01 00 00    	je     658 <vprintf.constprop.0+0x1c8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 51f:	83 f8 63             	cmp    $0x63,%eax
 522:	0f 84 68 01 00 00    	je     690 <vprintf.constprop.0+0x200>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 528:	83 f8 25             	cmp    $0x25,%eax
 52b:	0f 84 9f 00 00 00    	je     5d0 <vprintf.constprop.0+0x140>
  write(fd, &c, 1);
 531:	8d 45 df             	lea    -0x21(%ebp),%eax
 534:	83 ec 04             	sub    $0x4,%esp
 537:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 53a:	6a 01                	push   $0x1
 53c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 540:	50                   	push   %eax
 541:	6a 01                	push   $0x1
 543:	e8 22 fe ff ff       	call   36a <write>
 548:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 54c:	83 c4 0c             	add    $0xc,%esp
 54f:	8d 45 e0             	lea    -0x20(%ebp),%eax
 552:	6a 01                	push   $0x1
 554:	88 55 e0             	mov    %dl,-0x20(%ebp)
 557:	50                   	push   %eax
 558:	6a 01                	push   $0x1
 55a:	83 c3 01             	add    $0x1,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 55d:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 55f:	e8 06 fe ff ff       	call   36a <write>
  for(i = 0; fmt[i]; i++){
 564:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
  write(fd, &c, 1);
 568:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 56b:	84 d2                	test   %dl,%dl
 56d:	0f 85 6b ff ff ff    	jne    4de <vprintf.constprop.0+0x4e>
    }
  }
}
 573:	8d 65 f4             	lea    -0xc(%ebp),%esp
 576:	5b                   	pop    %ebx
 577:	5e                   	pop    %esi
 578:	5f                   	pop    %edi
 579:	5d                   	pop    %ebp
 57a:	c3                   	ret    
 57b:	90                   	nop
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        state = '%';
 580:	bf 25 00 00 00       	mov    $0x25,%edi
 585:	e9 45 ff ff ff       	jmp    4cf <vprintf.constprop.0+0x3f>
 58a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, uint), 10, 0);
 590:	8d 7e 04             	lea    0x4(%esi),%edi
 593:	31 c9                	xor    %ecx,%ecx
 595:	8b 06                	mov    (%esi),%eax
 597:	ba 0a 00 00 00       	mov    $0xa,%edx
 59c:	89 fe                	mov    %edi,%esi
      state = 0;
 59e:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, uint), 10, 0);
 5a0:	e8 5b fe ff ff       	call   400 <printint.constprop.1>
 5a5:	e9 25 ff ff ff       	jmp    4cf <vprintf.constprop.0+0x3f>
 5aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, int), 16, 0);
 5b0:	8b 06                	mov    (%esi),%eax
 5b2:	8d 7e 04             	lea    0x4(%esi),%edi
 5b5:	31 c9                	xor    %ecx,%ecx
 5b7:	ba 10 00 00 00       	mov    $0x10,%edx
 5bc:	89 fe                	mov    %edi,%esi
      state = 0;
 5be:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, int), 16, 0);
 5c0:	e8 3b fe ff ff       	call   400 <printint.constprop.1>
 5c5:	e9 05 ff ff ff       	jmp    4cf <vprintf.constprop.0+0x3f>
 5ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5d0:	83 ec 04             	sub    $0x4,%esp
 5d3:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 5d6:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 5d9:	6a 01                	push   $0x1
 5db:	e9 77 ff ff ff       	jmp    557 <vprintf.constprop.0+0xc7>
        printptr(fd, va_arg(ap, uint));
 5e0:	8d 46 04             	lea    0x4(%esi),%eax
  write(fd, &c, 1);
 5e3:	83 ec 04             	sub    $0x4,%esp
        printptr(fd, va_arg(ap, uint));
 5e6:	8b 3e                	mov    (%esi),%edi
  write(fd, &c, 1);
 5e8:	6a 01                	push   $0x1
 5ea:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 5ee:	be 08 00 00 00       	mov    $0x8,%esi
        printptr(fd, va_arg(ap, uint));
 5f3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 5f6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5f9:	50                   	push   %eax
 5fa:	6a 01                	push   $0x1
 5fc:	e8 69 fd ff ff       	call   36a <write>
 601:	8d 45 e7             	lea    -0x19(%ebp),%eax
 604:	83 c4 0c             	add    $0xc,%esp
 607:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 60b:	6a 01                	push   $0x1
 60d:	50                   	push   %eax
 60e:	6a 01                	push   $0x1
 610:	e8 55 fd ff ff       	call   36a <write>
 615:	83 c4 10             	add    $0x10,%esp
 618:	90                   	nop
 619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
 620:	89 f8                	mov    %edi,%eax
  write(fd, &c, 1);
 622:	83 ec 04             	sub    $0x4,%esp
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
 625:	c1 e7 04             	shl    $0x4,%edi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
 628:	c1 e8 1c             	shr    $0x1c,%eax
  write(fd, &c, 1);
 62b:	6a 01                	push   $0x1
 62d:	0f b6 80 08 09 00 00 	movzbl 0x908(%eax),%eax
 634:	88 45 e5             	mov    %al,-0x1b(%ebp)
 637:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 63a:	50                   	push   %eax
 63b:	6a 01                	push   $0x1
 63d:	e8 28 fd ff ff       	call   36a <write>
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
 642:	83 c4 10             	add    $0x10,%esp
 645:	83 ee 01             	sub    $0x1,%esi
 648:	75 d6                	jne    620 <vprintf.constprop.0+0x190>
        s = va_arg(ap, char*);
 64a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 64d:	31 ff                	xor    %edi,%edi
 64f:	e9 7b fe ff ff       	jmp    4cf <vprintf.constprop.0+0x3f>
 654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = va_arg(ap, char*);
 658:	8b 3e                	mov    (%esi),%edi
 65a:	8d 46 04             	lea    0x4(%esi),%eax
 65d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 660:	85 ff                	test   %edi,%edi
 662:	74 50                	je     6b4 <vprintf.constprop.0+0x224>
        while(*s != 0){
 664:	0f b6 07             	movzbl (%edi),%eax
 667:	84 c0                	test   %al,%al
 669:	74 df                	je     64a <vprintf.constprop.0+0x1ba>
 66b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 66e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 670:	83 ec 04             	sub    $0x4,%esp
          s++;
 673:	83 c7 01             	add    $0x1,%edi
 676:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 679:	6a 01                	push   $0x1
 67b:	56                   	push   %esi
 67c:	6a 01                	push   $0x1
 67e:	e8 e7 fc ff ff       	call   36a <write>
        while(*s != 0){
 683:	0f b6 07             	movzbl (%edi),%eax
 686:	83 c4 10             	add    $0x10,%esp
 689:	84 c0                	test   %al,%al
 68b:	75 e3                	jne    670 <vprintf.constprop.0+0x1e0>
 68d:	eb bb                	jmp    64a <vprintf.constprop.0+0x1ba>
 68f:	90                   	nop
        putc(fd, va_arg(ap, uint));
 690:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 692:	83 ec 04             	sub    $0x4,%esp
        putc(fd, va_arg(ap, uint));
 695:	8d 7e 04             	lea    0x4(%esi),%edi
  write(fd, &c, 1);
 698:	6a 01                	push   $0x1
        putc(fd, va_arg(ap, uint));
 69a:	89 fe                	mov    %edi,%esi
      state = 0;
 69c:	31 ff                	xor    %edi,%edi
        putc(fd, va_arg(ap, uint));
 69e:	88 45 e2             	mov    %al,-0x1e(%ebp)
  write(fd, &c, 1);
 6a1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6a4:	50                   	push   %eax
 6a5:	6a 01                	push   $0x1
 6a7:	e8 be fc ff ff       	call   36a <write>
 6ac:	83 c4 10             	add    $0x10,%esp
 6af:	e9 1b fe ff ff       	jmp    4cf <vprintf.constprop.0+0x3f>
          s = "(null)";
 6b4:	bf fe 08 00 00       	mov    $0x8fe,%edi
        while(*s != 0){
 6b9:	b8 28 00 00 00       	mov    $0x28,%eax
 6be:	eb ab                	jmp    66b <vprintf.constprop.0+0x1db>

000006c0 <fprintf>:
// Print to the given fd. Only understands %d,%x, %p, %s, %c.
void
fprintf(int fd, const char *fmt, ...)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	83 ec 08             	sub    $0x8,%esp
 va_list ap;
 va_start(ap, fmt); 
 vprintf(1,fmt,ap);
 6c6:	8b 45 0c             	mov    0xc(%ebp),%eax
 6c9:	8d 55 10             	lea    0x10(%ebp),%edx
 6cc:	e8 bf fd ff ff       	call   490 <vprintf.constprop.0>
}
 6d1:	c9                   	leave  
 6d2:	c3                   	ret    
 6d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006e0 <printf>:
void
printf(const char *fmt, ...)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	83 ec 08             	sub    $0x8,%esp
  va_list ap;
  va_start(ap, fmt); 
  vprintf(1,fmt,ap);
 6e6:	8b 45 08             	mov    0x8(%ebp),%eax
 6e9:	8d 55 0c             	lea    0xc(%ebp),%edx
 6ec:	e8 9f fd ff ff       	call   490 <vprintf.constprop.0>
}
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
 701:	a1 f8 0b 00 00       	mov    0xbf8,%eax
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
 73f:	a3 f8 0b 00 00       	mov    %eax,0xbf8
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
 77a:	a3 f8 0b 00 00       	mov    %eax,0xbf8
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
 79c:	8b 15 f8 0b 00 00    	mov    0xbf8,%edx
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
 7e1:	39 05 f8 0b 00 00    	cmp    %eax,0xbf8
 7e7:	89 c2                	mov    %eax,%edx
 7e9:	75 ed                	jne    7d8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 7eb:	83 ec 0c             	sub    $0xc,%esp
 7ee:	56                   	push   %esi
 7ef:	e8 de fb ff ff       	call   3d2 <sbrk>
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
 80b:	8b 15 f8 0b 00 00    	mov    0xbf8,%edx
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
 837:	89 15 f8 0b 00 00    	mov    %edx,0xbf8
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
 850:	c7 05 f8 0b 00 00 fc 	movl   $0xbfc,0xbf8
 857:	0b 00 00 
 85a:	c7 05 fc 0b 00 00 fc 	movl   $0xbfc,0xbfc
 861:	0b 00 00 
    base.s.size = 0;
 864:	b8 fc 0b 00 00       	mov    $0xbfc,%eax
 869:	c7 05 00 0c 00 00 00 	movl   $0x0,0xc00
 870:	00 00 00 
 873:	e9 44 ff ff ff       	jmp    7bc <malloc+0x2c>
 878:	90                   	nop
 879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 880:	8b 08                	mov    (%eax),%ecx
 882:	89 0a                	mov    %ecx,(%edx)
 884:	eb b1                	jmp    837 <malloc+0xa7>
