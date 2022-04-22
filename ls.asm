
user/_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 0c             	sub    $0xc,%esp
  13:	8b 01                	mov    (%ecx),%eax
  15:	8b 51 04             	mov    0x4(%ecx),%edx
  int i;

  if(argc < 2){
  18:	83 f8 01             	cmp    $0x1,%eax
  1b:	7e 24                	jle    41 <main+0x41>
  1d:	8d 5a 04             	lea    0x4(%edx),%ebx
  20:	8d 34 82             	lea    (%edx,%eax,4),%esi
  23:	90                   	nop
  24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	ff 33                	pushl  (%ebx)
  2d:	83 c3 04             	add    $0x4,%ebx
  30:	e8 cb 00 00 00       	call   100 <ls>
  for(i=1; i<argc; i++)
  35:	83 c4 10             	add    $0x10,%esp
  38:	39 f3                	cmp    %esi,%ebx
  3a:	75 ec                	jne    28 <main+0x28>
  exit();
  3c:	e8 31 05 00 00       	call   572 <exit>
    ls(".");
  41:	83 ec 0c             	sub    $0xc,%esp
  44:	68 00 0b 00 00       	push   $0xb00
  49:	e8 b2 00 00 00       	call   100 <ls>
    exit();
  4e:	e8 1f 05 00 00       	call   572 <exit>
  53:	66 90                	xchg   %ax,%ax
  55:	66 90                	xchg   %ax,%ax
  57:	66 90                	xchg   %ax,%ax
  59:	66 90                	xchg   %ax,%ax
  5b:	66 90                	xchg   %ax,%ax
  5d:	66 90                	xchg   %ax,%ax
  5f:	90                   	nop

00000060 <fmtname>:
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	56                   	push   %esi
  64:	53                   	push   %ebx
  65:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  68:	83 ec 0c             	sub    $0xc,%esp
  6b:	53                   	push   %ebx
  6c:	e8 2f 03 00 00       	call   3a0 <strlen>
  71:	83 c4 10             	add    $0x10,%esp
  74:	01 d8                	add    %ebx,%eax
  76:	73 0f                	jae    87 <fmtname+0x27>
  78:	eb 12                	jmp    8c <fmtname+0x2c>
  7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  80:	83 e8 01             	sub    $0x1,%eax
  83:	39 c3                	cmp    %eax,%ebx
  85:	77 05                	ja     8c <fmtname+0x2c>
  87:	80 38 2f             	cmpb   $0x2f,(%eax)
  8a:	75 f4                	jne    80 <fmtname+0x20>
  p++;
  8c:	8d 58 01             	lea    0x1(%eax),%ebx
  if(strlen(p) >= DIRSIZ)
  8f:	83 ec 0c             	sub    $0xc,%esp
  92:	53                   	push   %ebx
  93:	e8 08 03 00 00       	call   3a0 <strlen>
  98:	83 c4 10             	add    $0x10,%esp
  9b:	83 f8 0d             	cmp    $0xd,%eax
  9e:	77 4a                	ja     ea <fmtname+0x8a>
  memmove(buf, p, strlen(p));
  a0:	83 ec 0c             	sub    $0xc,%esp
  a3:	53                   	push   %ebx
  a4:	e8 f7 02 00 00       	call   3a0 <strlen>
  a9:	83 c4 0c             	add    $0xc,%esp
  ac:	50                   	push   %eax
  ad:	53                   	push   %ebx
  ae:	68 6c 0e 00 00       	push   $0xe6c
  b3:	e8 88 04 00 00       	call   540 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  b8:	89 1c 24             	mov    %ebx,(%esp)
  bb:	e8 e0 02 00 00       	call   3a0 <strlen>
  c0:	89 1c 24             	mov    %ebx,(%esp)
  c3:	89 c6                	mov    %eax,%esi
  return buf;
  c5:	bb 6c 0e 00 00       	mov    $0xe6c,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  ca:	e8 d1 02 00 00       	call   3a0 <strlen>
  cf:	ba 0e 00 00 00       	mov    $0xe,%edx
  d4:	83 c4 0c             	add    $0xc,%esp
  d7:	05 6c 0e 00 00       	add    $0xe6c,%eax
  dc:	29 f2                	sub    %esi,%edx
  de:	52                   	push   %edx
  df:	6a 20                	push   $0x20
  e1:	50                   	push   %eax
  e2:	e8 e9 02 00 00       	call   3d0 <memset>
  return buf;
  e7:	83 c4 10             	add    $0x10,%esp
}
  ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
  ed:	89 d8                	mov    %ebx,%eax
  ef:	5b                   	pop    %ebx
  f0:	5e                   	pop    %esi
  f1:	5d                   	pop    %ebp
  f2:	c3                   	ret    
  f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <ls>:
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	57                   	push   %edi
 104:	56                   	push   %esi
 105:	53                   	push   %ebx
 106:	81 ec 64 02 00 00    	sub    $0x264,%esp
 10c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
 10f:	6a 00                	push   $0x0
 111:	57                   	push   %edi
 112:	e8 a3 04 00 00       	call   5ba <open>
 117:	83 c4 10             	add    $0x10,%esp
 11a:	85 c0                	test   %eax,%eax
 11c:	78 4a                	js     168 <ls+0x68>
  if(fstat(fd, &st) < 0){
 11e:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 124:	83 ec 08             	sub    $0x8,%esp
 127:	89 c3                	mov    %eax,%ebx
 129:	56                   	push   %esi
 12a:	50                   	push   %eax
 12b:	e8 a2 04 00 00       	call   5d2 <fstat>
 130:	83 c4 10             	add    $0x10,%esp
 133:	85 c0                	test   %eax,%eax
 135:	0f 88 b5 00 00 00    	js     1f0 <ls+0xf0>
  switch(st.type){
 13b:	0f b7 85 d4 fd ff ff 	movzwl -0x22c(%ebp),%eax
 142:	66 83 f8 01          	cmp    $0x1,%ax
 146:	74 78                	je     1c0 <ls+0xc0>
 148:	66 83 f8 02          	cmp    $0x2,%ax
 14c:	74 3a                	je     188 <ls+0x88>
  close(fd);
 14e:	83 ec 0c             	sub    $0xc,%esp
 151:	53                   	push   %ebx
 152:	e8 4b 04 00 00       	call   5a2 <close>
 157:	83 c4 10             	add    $0x10,%esp
}
 15a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 15d:	5b                   	pop    %ebx
 15e:	5e                   	pop    %esi
 15f:	5f                   	pop    %edi
 160:	5d                   	pop    %ebp
 161:	c3                   	ret    
 162:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "ls: cannot open %s\n", path);
 168:	83 ec 04             	sub    $0x4,%esp
 16b:	57                   	push   %edi
 16c:	68 b8 0a 00 00       	push   $0xab8
 171:	6a 02                	push   $0x2
 173:	e8 78 07 00 00       	call   8f0 <fprintf>
    return;
 178:	83 c4 10             	add    $0x10,%esp
}
 17b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 17e:	5b                   	pop    %ebx
 17f:	5e                   	pop    %esi
 180:	5f                   	pop    %edi
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
 183:	90                   	nop
 184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf("%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 188:	83 ec 0c             	sub    $0xc,%esp
 18b:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 191:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 197:	57                   	push   %edi
 198:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 19e:	e8 bd fe ff ff       	call   60 <fmtname>
 1a3:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 1a9:	89 14 24             	mov    %edx,(%esp)
 1ac:	56                   	push   %esi
 1ad:	6a 02                	push   $0x2
 1af:	50                   	push   %eax
 1b0:	68 e0 0a 00 00       	push   $0xae0
 1b5:	e8 56 07 00 00       	call   910 <printf>
    break;
 1ba:	83 c4 20             	add    $0x20,%esp
 1bd:	eb 8f                	jmp    14e <ls+0x4e>
 1bf:	90                   	nop
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1c0:	83 ec 0c             	sub    $0xc,%esp
 1c3:	57                   	push   %edi
 1c4:	e8 d7 01 00 00       	call   3a0 <strlen>
 1c9:	83 c0 10             	add    $0x10,%eax
 1cc:	83 c4 10             	add    $0x10,%esp
 1cf:	3d 00 02 00 00       	cmp    $0x200,%eax
 1d4:	76 42                	jbe    218 <ls+0x118>
      fprintf(2, "ls: path too long\n");
 1d6:	83 ec 08             	sub    $0x8,%esp
 1d9:	68 ed 0a 00 00       	push   $0xaed
 1de:	6a 02                	push   $0x2
 1e0:	e8 0b 07 00 00       	call   8f0 <fprintf>
      break;
 1e5:	83 c4 10             	add    $0x10,%esp
 1e8:	e9 61 ff ff ff       	jmp    14e <ls+0x4e>
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "ls: cannot stat %s\n", path);
 1f0:	83 ec 04             	sub    $0x4,%esp
 1f3:	57                   	push   %edi
 1f4:	68 cc 0a 00 00       	push   $0xacc
 1f9:	6a 02                	push   $0x2
 1fb:	e8 f0 06 00 00       	call   8f0 <fprintf>
    close(fd);
 200:	89 1c 24             	mov    %ebx,(%esp)
 203:	e8 9a 03 00 00       	call   5a2 <close>
    return;
 208:	83 c4 10             	add    $0x10,%esp
}
 20b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 20e:	5b                   	pop    %ebx
 20f:	5e                   	pop    %esi
 210:	5f                   	pop    %edi
 211:	5d                   	pop    %ebp
 212:	c3                   	ret    
 213:	90                   	nop
 214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    strcpy(buf, path);
 218:	83 ec 08             	sub    $0x8,%esp
 21b:	57                   	push   %edi
 21c:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
 222:	57                   	push   %edi
 223:	e8 f8 00 00 00       	call   320 <strcpy>
    p = buf+strlen(buf);
 228:	89 3c 24             	mov    %edi,(%esp)
 22b:	e8 70 01 00 00       	call   3a0 <strlen>
 230:	01 f8                	add    %edi,%eax
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 232:	83 c4 10             	add    $0x10,%esp
    *p++ = '/';
 235:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 238:	89 85 a8 fd ff ff    	mov    %eax,-0x258(%ebp)
    *p++ = '/';
 23e:	c6 00 2f             	movb   $0x2f,(%eax)
 241:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 250:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 256:	83 ec 04             	sub    $0x4,%esp
 259:	6a 10                	push   $0x10
 25b:	50                   	push   %eax
 25c:	53                   	push   %ebx
 25d:	e8 28 03 00 00       	call   58a <read>
 262:	83 c4 10             	add    $0x10,%esp
 265:	83 f8 10             	cmp    $0x10,%eax
 268:	0f 85 e0 fe ff ff    	jne    14e <ls+0x4e>
      if(de.inum == 0)
 26e:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 275:	00 
 276:	74 d8                	je     250 <ls+0x150>
      memmove(p, de.name, DIRSIZ);
 278:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 27e:	83 ec 04             	sub    $0x4,%esp
 281:	6a 0e                	push   $0xe
 283:	50                   	push   %eax
 284:	ff b5 a4 fd ff ff    	pushl  -0x25c(%ebp)
 28a:	e8 b1 02 00 00       	call   540 <memmove>
      p[DIRSIZ] = 0;
 28f:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
 295:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 299:	58                   	pop    %eax
 29a:	5a                   	pop    %edx
 29b:	56                   	push   %esi
 29c:	57                   	push   %edi
 29d:	e8 0e 02 00 00       	call   4b0 <stat>
 2a2:	83 c4 10             	add    $0x10,%esp
 2a5:	85 c0                	test   %eax,%eax
 2a7:	78 57                	js     300 <ls+0x200>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 2a9:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 2b0:	83 ec 0c             	sub    $0xc,%esp
 2b3:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 2b9:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 2bf:	57                   	push   %edi
 2c0:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 2c6:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 2cc:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 2d2:	e8 89 fd ff ff       	call   60 <fmtname>
 2d7:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
 2dd:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 2e3:	89 0c 24             	mov    %ecx,(%esp)
 2e6:	52                   	push   %edx
 2e7:	ff b5 b4 fd ff ff    	pushl  -0x24c(%ebp)
 2ed:	50                   	push   %eax
 2ee:	68 e0 0a 00 00       	push   $0xae0
 2f3:	e8 18 06 00 00       	call   910 <printf>
 2f8:	83 c4 20             	add    $0x20,%esp
 2fb:	e9 50 ff ff ff       	jmp    250 <ls+0x150>
        fprintf(2, "ls: cannot stat %s\n", buf);
 300:	83 ec 04             	sub    $0x4,%esp
 303:	57                   	push   %edi
 304:	68 cc 0a 00 00       	push   $0xacc
 309:	6a 02                	push   $0x2
 30b:	e8 e0 05 00 00       	call   8f0 <fprintf>
        continue;
 310:	83 c4 10             	add    $0x10,%esp
 313:	e9 38 ff ff ff       	jmp    250 <ls+0x150>
 318:	66 90                	xchg   %ax,%ax
 31a:	66 90                	xchg   %ax,%ax
 31c:	66 90                	xchg   %ax,%ax
 31e:	66 90                	xchg   %ax,%ax

00000320 <strcpy>:
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	8b 45 08             	mov    0x8(%ebp),%eax
 327:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 32a:	89 c2                	mov    %eax,%edx
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 330:	83 c1 01             	add    $0x1,%ecx
 333:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 337:	83 c2 01             	add    $0x1,%edx
 33a:	84 db                	test   %bl,%bl
 33c:	88 5a ff             	mov    %bl,-0x1(%edx)
 33f:	75 ef                	jne    330 <strcpy+0x10>
    ;
  return os;
}
 341:	5b                   	pop    %ebx
 342:	5d                   	pop    %ebp
 343:	c3                   	ret    
 344:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 34a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000350 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	53                   	push   %ebx
 354:	8b 55 08             	mov    0x8(%ebp),%edx
 357:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 35a:	0f b6 02             	movzbl (%edx),%eax
 35d:	0f b6 19             	movzbl (%ecx),%ebx
 360:	84 c0                	test   %al,%al
 362:	75 1c                	jne    380 <strcmp+0x30>
 364:	eb 2a                	jmp    390 <strcmp+0x40>
 366:	8d 76 00             	lea    0x0(%esi),%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 370:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 373:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 376:	83 c1 01             	add    $0x1,%ecx
 379:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 37c:	84 c0                	test   %al,%al
 37e:	74 10                	je     390 <strcmp+0x40>
 380:	38 d8                	cmp    %bl,%al
 382:	74 ec                	je     370 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 384:	29 d8                	sub    %ebx,%eax
}
 386:	5b                   	pop    %ebx
 387:	5d                   	pop    %ebp
 388:	c3                   	ret    
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 390:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 392:	29 d8                	sub    %ebx,%eax
}
 394:	5b                   	pop    %ebx
 395:	5d                   	pop    %ebp
 396:	c3                   	ret    
 397:	89 f6                	mov    %esi,%esi
 399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003a0 <strlen>:

uint
strlen(const char *s)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3a6:	80 39 00             	cmpb   $0x0,(%ecx)
 3a9:	74 15                	je     3c0 <strlen+0x20>
 3ab:	31 d2                	xor    %edx,%edx
 3ad:	8d 76 00             	lea    0x0(%esi),%esi
 3b0:	83 c2 01             	add    $0x1,%edx
 3b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3b7:	89 d0                	mov    %edx,%eax
 3b9:	75 f5                	jne    3b0 <strlen+0x10>
    ;
  return n;
}
 3bb:	5d                   	pop    %ebp
 3bc:	c3                   	ret    
 3bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 3c0:	31 c0                	xor    %eax,%eax
}
 3c2:	5d                   	pop    %ebp
 3c3:	c3                   	ret    
 3c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3da:	8b 45 0c             	mov    0xc(%ebp),%eax
 3dd:	89 d7                	mov    %edx,%edi
 3df:	fc                   	cld    
 3e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3e2:	89 d0                	mov    %edx,%eax
 3e4:	5f                   	pop    %edi
 3e5:	5d                   	pop    %ebp
 3e6:	c3                   	ret    
 3e7:	89 f6                	mov    %esi,%esi
 3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003f0 <strchr>:

char*
strchr(const char *s, char c)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	53                   	push   %ebx
 3f4:	8b 45 08             	mov    0x8(%ebp),%eax
 3f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 3fa:	0f b6 10             	movzbl (%eax),%edx
 3fd:	84 d2                	test   %dl,%dl
 3ff:	74 1d                	je     41e <strchr+0x2e>
    if(*s == c)
 401:	38 d3                	cmp    %dl,%bl
 403:	89 d9                	mov    %ebx,%ecx
 405:	75 0d                	jne    414 <strchr+0x24>
 407:	eb 17                	jmp    420 <strchr+0x30>
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 410:	38 ca                	cmp    %cl,%dl
 412:	74 0c                	je     420 <strchr+0x30>
  for(; *s; s++)
 414:	83 c0 01             	add    $0x1,%eax
 417:	0f b6 10             	movzbl (%eax),%edx
 41a:	84 d2                	test   %dl,%dl
 41c:	75 f2                	jne    410 <strchr+0x20>
      return (char*)s;
  return 0;
 41e:	31 c0                	xor    %eax,%eax
}
 420:	5b                   	pop    %ebx
 421:	5d                   	pop    %ebp
 422:	c3                   	ret    
 423:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000430 <gets>:

char*
gets(char *buf, int max)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 436:	31 f6                	xor    %esi,%esi
 438:	89 f3                	mov    %esi,%ebx
{
 43a:	83 ec 1c             	sub    $0x1c,%esp
 43d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 440:	eb 2f                	jmp    471 <gets+0x41>
 442:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 448:	8d 45 e7             	lea    -0x19(%ebp),%eax
 44b:	83 ec 04             	sub    $0x4,%esp
 44e:	6a 01                	push   $0x1
 450:	50                   	push   %eax
 451:	6a 00                	push   $0x0
 453:	e8 32 01 00 00       	call   58a <read>
    if(cc < 1)
 458:	83 c4 10             	add    $0x10,%esp
 45b:	85 c0                	test   %eax,%eax
 45d:	7e 1c                	jle    47b <gets+0x4b>
      break;
    buf[i++] = c;
 45f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 463:	83 c7 01             	add    $0x1,%edi
 466:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 469:	3c 0a                	cmp    $0xa,%al
 46b:	74 23                	je     490 <gets+0x60>
 46d:	3c 0d                	cmp    $0xd,%al
 46f:	74 1f                	je     490 <gets+0x60>
  for(i=0; i+1 < max; ){
 471:	83 c3 01             	add    $0x1,%ebx
 474:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 477:	89 fe                	mov    %edi,%esi
 479:	7c cd                	jl     448 <gets+0x18>
 47b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 47d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 480:	c6 03 00             	movb   $0x0,(%ebx)
}
 483:	8d 65 f4             	lea    -0xc(%ebp),%esp
 486:	5b                   	pop    %ebx
 487:	5e                   	pop    %esi
 488:	5f                   	pop    %edi
 489:	5d                   	pop    %ebp
 48a:	c3                   	ret    
 48b:	90                   	nop
 48c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 490:	8b 75 08             	mov    0x8(%ebp),%esi
 493:	8b 45 08             	mov    0x8(%ebp),%eax
 496:	01 de                	add    %ebx,%esi
 498:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 49a:	c6 03 00             	movb   $0x0,(%ebx)
}
 49d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4a0:	5b                   	pop    %ebx
 4a1:	5e                   	pop    %esi
 4a2:	5f                   	pop    %edi
 4a3:	5d                   	pop    %ebp
 4a4:	c3                   	ret    
 4a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004b0 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	56                   	push   %esi
 4b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4b5:	83 ec 08             	sub    $0x8,%esp
 4b8:	6a 00                	push   $0x0
 4ba:	ff 75 08             	pushl  0x8(%ebp)
 4bd:	e8 f8 00 00 00       	call   5ba <open>
  if(fd < 0)
 4c2:	83 c4 10             	add    $0x10,%esp
 4c5:	85 c0                	test   %eax,%eax
 4c7:	78 27                	js     4f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 4c9:	83 ec 08             	sub    $0x8,%esp
 4cc:	ff 75 0c             	pushl  0xc(%ebp)
 4cf:	89 c3                	mov    %eax,%ebx
 4d1:	50                   	push   %eax
 4d2:	e8 fb 00 00 00       	call   5d2 <fstat>
  close(fd);
 4d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 4da:	89 c6                	mov    %eax,%esi
  close(fd);
 4dc:	e8 c1 00 00 00       	call   5a2 <close>
  return r;
 4e1:	83 c4 10             	add    $0x10,%esp
}
 4e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4e7:	89 f0                	mov    %esi,%eax
 4e9:	5b                   	pop    %ebx
 4ea:	5e                   	pop    %esi
 4eb:	5d                   	pop    %ebp
 4ec:	c3                   	ret    
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 4f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 4f5:	eb ed                	jmp    4e4 <stat+0x34>
 4f7:	89 f6                	mov    %esi,%esi
 4f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000500 <atoi>:

int
atoi(const char *s)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	53                   	push   %ebx
 504:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 507:	0f be 11             	movsbl (%ecx),%edx
 50a:	8d 42 d0             	lea    -0x30(%edx),%eax
 50d:	3c 09                	cmp    $0x9,%al
  n = 0;
 50f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 514:	77 1f                	ja     535 <atoi+0x35>
 516:	8d 76 00             	lea    0x0(%esi),%esi
 519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 520:	8d 04 80             	lea    (%eax,%eax,4),%eax
 523:	83 c1 01             	add    $0x1,%ecx
 526:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 52a:	0f be 11             	movsbl (%ecx),%edx
 52d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 530:	80 fb 09             	cmp    $0x9,%bl
 533:	76 eb                	jbe    520 <atoi+0x20>
  return n;
}
 535:	5b                   	pop    %ebx
 536:	5d                   	pop    %ebp
 537:	c3                   	ret    
 538:	90                   	nop
 539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000540 <memmove>:


void*
memmove(void *vdst, const void *vsrc, int n)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	56                   	push   %esi
 544:	53                   	push   %ebx
 545:	8b 5d 10             	mov    0x10(%ebp),%ebx
 548:	8b 45 08             	mov    0x8(%ebp),%eax
 54b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 54e:	85 db                	test   %ebx,%ebx
 550:	7e 14                	jle    566 <memmove+0x26>
 552:	31 d2                	xor    %edx,%edx
 554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 558:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 55c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 55f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 562:	39 d3                	cmp    %edx,%ebx
 564:	75 f2                	jne    558 <memmove+0x18>
  return vdst;
}
 566:	5b                   	pop    %ebx
 567:	5e                   	pop    %esi
 568:	5d                   	pop    %ebp
 569:	c3                   	ret    

0000056a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 56a:	b8 01 00 00 00       	mov    $0x1,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <exit>:
SYSCALL(exit)
 572:	b8 02 00 00 00       	mov    $0x2,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <wait>:
SYSCALL(wait)
 57a:	b8 03 00 00 00       	mov    $0x3,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <pipe>:
SYSCALL(pipe)
 582:	b8 04 00 00 00       	mov    $0x4,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <read>:
SYSCALL(read)
 58a:	b8 05 00 00 00       	mov    $0x5,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <steal>:
SYSCALL(steal)
 592:	b8 17 00 00 00       	mov    $0x17,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <write>:
SYSCALL(write)
 59a:	b8 10 00 00 00       	mov    $0x10,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <close>:
SYSCALL(close)
 5a2:	b8 15 00 00 00       	mov    $0x15,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <kill>:
SYSCALL(kill)
 5aa:	b8 06 00 00 00       	mov    $0x6,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <exec>:
SYSCALL(exec)
 5b2:	b8 07 00 00 00       	mov    $0x7,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <open>:
SYSCALL(open)
 5ba:	b8 0f 00 00 00       	mov    $0xf,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <mknod>:
SYSCALL(mknod)
 5c2:	b8 11 00 00 00       	mov    $0x11,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <unlink>:
SYSCALL(unlink)
 5ca:	b8 12 00 00 00       	mov    $0x12,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    

000005d2 <fstat>:
SYSCALL(fstat)
 5d2:	b8 08 00 00 00       	mov    $0x8,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret    

000005da <link>:
SYSCALL(link)
 5da:	b8 13 00 00 00       	mov    $0x13,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    

000005e2 <mkdir>:
SYSCALL(mkdir)
 5e2:	b8 14 00 00 00       	mov    $0x14,%eax
 5e7:	cd 40                	int    $0x40
 5e9:	c3                   	ret    

000005ea <chdir>:
SYSCALL(chdir)
 5ea:	b8 09 00 00 00       	mov    $0x9,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret    

000005f2 <dup>:
SYSCALL(dup)
 5f2:	b8 0a 00 00 00       	mov    $0xa,%eax
 5f7:	cd 40                	int    $0x40
 5f9:	c3                   	ret    

000005fa <getpid>:
SYSCALL(getpid)
 5fa:	b8 0b 00 00 00       	mov    $0xb,%eax
 5ff:	cd 40                	int    $0x40
 601:	c3                   	ret    

00000602 <sbrk>:
SYSCALL(sbrk)
 602:	b8 0c 00 00 00       	mov    $0xc,%eax
 607:	cd 40                	int    $0x40
 609:	c3                   	ret    

0000060a <sleep>:
SYSCALL(sleep)
 60a:	b8 0d 00 00 00       	mov    $0xd,%eax
 60f:	cd 40                	int    $0x40
 611:	c3                   	ret    

00000612 <uptime>:
SYSCALL(uptime)
 612:	b8 0e 00 00 00       	mov    $0xe,%eax
 617:	cd 40                	int    $0x40
 619:	c3                   	ret    

0000061a <cpuhalt>:
SYSCALL(cpuhalt)
 61a:	b8 16 00 00 00       	mov    $0x16,%eax
 61f:	cd 40                	int    $0x40
 621:	c3                   	ret    
 622:	66 90                	xchg   %ax,%ax
 624:	66 90                	xchg   %ax,%ax
 626:	66 90                	xchg   %ax,%ax
 628:	66 90                	xchg   %ax,%ax
 62a:	66 90                	xchg   %ax,%ax
 62c:	66 90                	xchg   %ax,%ax
 62e:	66 90                	xchg   %ax,%ax

00000630 <printint.constprop.1>:
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
}

static void
printint(int fd, int xx, int base, int sgn)
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	57                   	push   %edi
 634:	56                   	push   %esi
 635:	53                   	push   %ebx
 636:	89 d6                	mov    %edx,%esi
 638:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 63b:	85 c0                	test   %eax,%eax
 63d:	79 71                	jns    6b0 <printint.constprop.1+0x80>
 63f:	83 e1 01             	and    $0x1,%ecx
 642:	74 6c                	je     6b0 <printint.constprop.1+0x80>
    neg = 1;
    x = -xx;
 644:	f7 d8                	neg    %eax
    neg = 1;
 646:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 64d:	31 c9                	xor    %ecx,%ecx
 64f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 652:	eb 06                	jmp    65a <printint.constprop.1+0x2a>
 654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 658:	89 f9                	mov    %edi,%ecx
 65a:	31 d2                	xor    %edx,%edx
 65c:	8d 79 01             	lea    0x1(%ecx),%edi
 65f:	f7 f6                	div    %esi
 661:	0f b6 92 0c 0b 00 00 	movzbl 0xb0c(%edx),%edx
  }while((x /= base) != 0);
 668:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 66a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 66d:	75 e9                	jne    658 <printint.constprop.1+0x28>
  if(neg)
 66f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 672:	85 c0                	test   %eax,%eax
 674:	74 08                	je     67e <printint.constprop.1+0x4e>
    buf[i++] = '-';
 676:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 67b:	8d 79 02             	lea    0x2(%ecx),%edi
 67e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 688:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 68b:	83 ec 04             	sub    $0x4,%esp
 68e:	83 ee 01             	sub    $0x1,%esi
 691:	6a 01                	push   $0x1
 693:	53                   	push   %ebx
 694:	6a 01                	push   $0x1
 696:	88 45 d7             	mov    %al,-0x29(%ebp)
 699:	e8 fc fe ff ff       	call   59a <write>

  while(--i >= 0)
 69e:	83 c4 10             	add    $0x10,%esp
 6a1:	39 de                	cmp    %ebx,%esi
 6a3:	75 e3                	jne    688 <printint.constprop.1+0x58>
    putc(fd, buf[i]);
}
 6a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6a8:	5b                   	pop    %ebx
 6a9:	5e                   	pop    %esi
 6aa:	5f                   	pop    %edi
 6ab:	5d                   	pop    %ebp
 6ac:	c3                   	ret    
 6ad:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 6b0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 6b7:	eb 94                	jmp    64d <printint.constprop.1+0x1d>
 6b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006c0 <vprintf.constprop.0>:
static void vprintf(int fd, const char *fmt, va_list ap)
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
 6c6:	89 d6                	mov    %edx,%esi
 6c8:	83 ec 2c             	sub    $0x2c,%esp
{
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6cb:	0f b6 10             	movzbl (%eax),%edx
 6ce:	84 d2                	test   %dl,%dl
 6d0:	0f 84 cd 00 00 00    	je     7a3 <vprintf.constprop.0+0xe3>
 6d6:	8d 58 01             	lea    0x1(%eax),%ebx
  state = 0;
 6d9:	31 ff                	xor    %edi,%edi
 6db:	eb 31                	jmp    70e <vprintf.constprop.0+0x4e>
 6dd:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6e0:	83 f8 25             	cmp    $0x25,%eax
 6e3:	0f 84 c7 00 00 00    	je     7b0 <vprintf.constprop.0+0xf0>
  write(fd, &c, 1);
 6e9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6ec:	83 ec 04             	sub    $0x4,%esp
 6ef:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 6f2:	6a 01                	push   $0x1
 6f4:	50                   	push   %eax
 6f5:	6a 01                	push   $0x1
 6f7:	e8 9e fe ff ff       	call   59a <write>
 6fc:	83 c4 10             	add    $0x10,%esp
 6ff:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 702:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 706:	84 d2                	test   %dl,%dl
 708:	0f 84 95 00 00 00    	je     7a3 <vprintf.constprop.0+0xe3>
    if(state == 0){
 70e:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 710:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 713:	74 cb                	je     6e0 <vprintf.constprop.0+0x20>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 715:	83 ff 25             	cmp    $0x25,%edi
 718:	75 e5                	jne    6ff <vprintf.constprop.0+0x3f>
      if(c == 'd'){
 71a:	83 f8 64             	cmp    $0x64,%eax
        printint(fd, va_arg(ap, int), 10, 1);
 71d:	8d 7e 04             	lea    0x4(%esi),%edi
 720:	b9 01 00 00 00       	mov    $0x1,%ecx
      if(c == 'd'){
 725:	0f 84 9a 00 00 00    	je     7c5 <vprintf.constprop.0+0x105>
      } else if(c == 'l') {
 72b:	83 f8 6c             	cmp    $0x6c,%eax
 72e:	0f 84 8c 00 00 00    	je     7c0 <vprintf.constprop.0+0x100>
        printint(fd, va_arg(ap, uint), 10, 0);
      } else if(c == 'x') {
 734:	83 f8 78             	cmp    $0x78,%eax
 737:	0f 84 a3 00 00 00    	je     7e0 <vprintf.constprop.0+0x120>
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 73d:	83 f8 70             	cmp    $0x70,%eax
 740:	0f 84 ca 00 00 00    	je     810 <vprintf.constprop.0+0x150>
        printptr(fd, va_arg(ap, uint));
      } else if(c == 's'){
 746:	83 f8 73             	cmp    $0x73,%eax
 749:	0f 84 39 01 00 00    	je     888 <vprintf.constprop.0+0x1c8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 74f:	83 f8 63             	cmp    $0x63,%eax
 752:	0f 84 68 01 00 00    	je     8c0 <vprintf.constprop.0+0x200>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 758:	83 f8 25             	cmp    $0x25,%eax
 75b:	0f 84 9f 00 00 00    	je     800 <vprintf.constprop.0+0x140>
  write(fd, &c, 1);
 761:	8d 45 df             	lea    -0x21(%ebp),%eax
 764:	83 ec 04             	sub    $0x4,%esp
 767:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 76a:	6a 01                	push   $0x1
 76c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 770:	50                   	push   %eax
 771:	6a 01                	push   $0x1
 773:	e8 22 fe ff ff       	call   59a <write>
 778:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 77c:	83 c4 0c             	add    $0xc,%esp
 77f:	8d 45 e0             	lea    -0x20(%ebp),%eax
 782:	6a 01                	push   $0x1
 784:	88 55 e0             	mov    %dl,-0x20(%ebp)
 787:	50                   	push   %eax
 788:	6a 01                	push   $0x1
 78a:	83 c3 01             	add    $0x1,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 78d:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 78f:	e8 06 fe ff ff       	call   59a <write>
  for(i = 0; fmt[i]; i++){
 794:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
  write(fd, &c, 1);
 798:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 79b:	84 d2                	test   %dl,%dl
 79d:	0f 85 6b ff ff ff    	jne    70e <vprintf.constprop.0+0x4e>
    }
  }
}
 7a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7a6:	5b                   	pop    %ebx
 7a7:	5e                   	pop    %esi
 7a8:	5f                   	pop    %edi
 7a9:	5d                   	pop    %ebp
 7aa:	c3                   	ret    
 7ab:	90                   	nop
 7ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        state = '%';
 7b0:	bf 25 00 00 00       	mov    $0x25,%edi
 7b5:	e9 45 ff ff ff       	jmp    6ff <vprintf.constprop.0+0x3f>
 7ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, uint), 10, 0);
 7c0:	8d 7e 04             	lea    0x4(%esi),%edi
 7c3:	31 c9                	xor    %ecx,%ecx
 7c5:	8b 06                	mov    (%esi),%eax
 7c7:	ba 0a 00 00 00       	mov    $0xa,%edx
 7cc:	89 fe                	mov    %edi,%esi
      state = 0;
 7ce:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, uint), 10, 0);
 7d0:	e8 5b fe ff ff       	call   630 <printint.constprop.1>
 7d5:	e9 25 ff ff ff       	jmp    6ff <vprintf.constprop.0+0x3f>
 7da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, int), 16, 0);
 7e0:	8b 06                	mov    (%esi),%eax
 7e2:	8d 7e 04             	lea    0x4(%esi),%edi
 7e5:	31 c9                	xor    %ecx,%ecx
 7e7:	ba 10 00 00 00       	mov    $0x10,%edx
 7ec:	89 fe                	mov    %edi,%esi
      state = 0;
 7ee:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, int), 16, 0);
 7f0:	e8 3b fe ff ff       	call   630 <printint.constprop.1>
 7f5:	e9 05 ff ff ff       	jmp    6ff <vprintf.constprop.0+0x3f>
 7fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 800:	83 ec 04             	sub    $0x4,%esp
 803:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 806:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 809:	6a 01                	push   $0x1
 80b:	e9 77 ff ff ff       	jmp    787 <vprintf.constprop.0+0xc7>
        printptr(fd, va_arg(ap, uint));
 810:	8d 46 04             	lea    0x4(%esi),%eax
  write(fd, &c, 1);
 813:	83 ec 04             	sub    $0x4,%esp
        printptr(fd, va_arg(ap, uint));
 816:	8b 3e                	mov    (%esi),%edi
  write(fd, &c, 1);
 818:	6a 01                	push   $0x1
 81a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 81e:	be 08 00 00 00       	mov    $0x8,%esi
        printptr(fd, va_arg(ap, uint));
 823:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 826:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 829:	50                   	push   %eax
 82a:	6a 01                	push   $0x1
 82c:	e8 69 fd ff ff       	call   59a <write>
 831:	8d 45 e7             	lea    -0x19(%ebp),%eax
 834:	83 c4 0c             	add    $0xc,%esp
 837:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 83b:	6a 01                	push   $0x1
 83d:	50                   	push   %eax
 83e:	6a 01                	push   $0x1
 840:	e8 55 fd ff ff       	call   59a <write>
 845:	83 c4 10             	add    $0x10,%esp
 848:	90                   	nop
 849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
 850:	89 f8                	mov    %edi,%eax
  write(fd, &c, 1);
 852:	83 ec 04             	sub    $0x4,%esp
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
 855:	c1 e7 04             	shl    $0x4,%edi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
 858:	c1 e8 1c             	shr    $0x1c,%eax
  write(fd, &c, 1);
 85b:	6a 01                	push   $0x1
 85d:	0f b6 80 0c 0b 00 00 	movzbl 0xb0c(%eax),%eax
 864:	88 45 e5             	mov    %al,-0x1b(%ebp)
 867:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 86a:	50                   	push   %eax
 86b:	6a 01                	push   $0x1
 86d:	e8 28 fd ff ff       	call   59a <write>
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
 872:	83 c4 10             	add    $0x10,%esp
 875:	83 ee 01             	sub    $0x1,%esi
 878:	75 d6                	jne    850 <vprintf.constprop.0+0x190>
        s = va_arg(ap, char*);
 87a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 87d:	31 ff                	xor    %edi,%edi
 87f:	e9 7b fe ff ff       	jmp    6ff <vprintf.constprop.0+0x3f>
 884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = va_arg(ap, char*);
 888:	8b 3e                	mov    (%esi),%edi
 88a:	8d 46 04             	lea    0x4(%esi),%eax
 88d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 890:	85 ff                	test   %edi,%edi
 892:	74 50                	je     8e4 <vprintf.constprop.0+0x224>
        while(*s != 0){
 894:	0f b6 07             	movzbl (%edi),%eax
 897:	84 c0                	test   %al,%al
 899:	74 df                	je     87a <vprintf.constprop.0+0x1ba>
 89b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 89e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 8a0:	83 ec 04             	sub    $0x4,%esp
          s++;
 8a3:	83 c7 01             	add    $0x1,%edi
 8a6:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 8a9:	6a 01                	push   $0x1
 8ab:	56                   	push   %esi
 8ac:	6a 01                	push   $0x1
 8ae:	e8 e7 fc ff ff       	call   59a <write>
        while(*s != 0){
 8b3:	0f b6 07             	movzbl (%edi),%eax
 8b6:	83 c4 10             	add    $0x10,%esp
 8b9:	84 c0                	test   %al,%al
 8bb:	75 e3                	jne    8a0 <vprintf.constprop.0+0x1e0>
 8bd:	eb bb                	jmp    87a <vprintf.constprop.0+0x1ba>
 8bf:	90                   	nop
        putc(fd, va_arg(ap, uint));
 8c0:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 8c2:	83 ec 04             	sub    $0x4,%esp
        putc(fd, va_arg(ap, uint));
 8c5:	8d 7e 04             	lea    0x4(%esi),%edi
  write(fd, &c, 1);
 8c8:	6a 01                	push   $0x1
        putc(fd, va_arg(ap, uint));
 8ca:	89 fe                	mov    %edi,%esi
      state = 0;
 8cc:	31 ff                	xor    %edi,%edi
        putc(fd, va_arg(ap, uint));
 8ce:	88 45 e2             	mov    %al,-0x1e(%ebp)
  write(fd, &c, 1);
 8d1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 8d4:	50                   	push   %eax
 8d5:	6a 01                	push   $0x1
 8d7:	e8 be fc ff ff       	call   59a <write>
 8dc:	83 c4 10             	add    $0x10,%esp
 8df:	e9 1b fe ff ff       	jmp    6ff <vprintf.constprop.0+0x3f>
          s = "(null)";
 8e4:	bf 02 0b 00 00       	mov    $0xb02,%edi
        while(*s != 0){
 8e9:	b8 28 00 00 00       	mov    $0x28,%eax
 8ee:	eb ab                	jmp    89b <vprintf.constprop.0+0x1db>

000008f0 <fprintf>:
// Print to the given fd. Only understands %d,%x, %p, %s, %c.
void
fprintf(int fd, const char *fmt, ...)
{
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	83 ec 08             	sub    $0x8,%esp
 va_list ap;
 va_start(ap, fmt); 
 vprintf(1,fmt,ap);
 8f6:	8b 45 0c             	mov    0xc(%ebp),%eax
 8f9:	8d 55 10             	lea    0x10(%ebp),%edx
 8fc:	e8 bf fd ff ff       	call   6c0 <vprintf.constprop.0>
}
 901:	c9                   	leave  
 902:	c3                   	ret    
 903:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000910 <printf>:
void
printf(const char *fmt, ...)
{
 910:	55                   	push   %ebp
 911:	89 e5                	mov    %esp,%ebp
 913:	83 ec 08             	sub    $0x8,%esp
  va_list ap;
  va_start(ap, fmt); 
  vprintf(1,fmt,ap);
 916:	8b 45 08             	mov    0x8(%ebp),%eax
 919:	8d 55 0c             	lea    0xc(%ebp),%edx
 91c:	e8 9f fd ff ff       	call   6c0 <vprintf.constprop.0>
}
 921:	c9                   	leave  
 922:	c3                   	ret    
 923:	66 90                	xchg   %ax,%ax
 925:	66 90                	xchg   %ax,%ax
 927:	66 90                	xchg   %ax,%ax
 929:	66 90                	xchg   %ax,%ax
 92b:	66 90                	xchg   %ax,%ax
 92d:	66 90                	xchg   %ax,%ax
 92f:	90                   	nop

00000930 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 930:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 931:	a1 7c 0e 00 00       	mov    0xe7c,%eax
{
 936:	89 e5                	mov    %esp,%ebp
 938:	57                   	push   %edi
 939:	56                   	push   %esi
 93a:	53                   	push   %ebx
 93b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 93e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 941:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 948:	39 c8                	cmp    %ecx,%eax
 94a:	8b 10                	mov    (%eax),%edx
 94c:	73 32                	jae    980 <free+0x50>
 94e:	39 d1                	cmp    %edx,%ecx
 950:	72 04                	jb     956 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 952:	39 d0                	cmp    %edx,%eax
 954:	72 32                	jb     988 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 956:	8b 73 fc             	mov    -0x4(%ebx),%esi
 959:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 95c:	39 fa                	cmp    %edi,%edx
 95e:	74 30                	je     990 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 960:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 963:	8b 50 04             	mov    0x4(%eax),%edx
 966:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 969:	39 f1                	cmp    %esi,%ecx
 96b:	74 3a                	je     9a7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 96d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 96f:	a3 7c 0e 00 00       	mov    %eax,0xe7c
}
 974:	5b                   	pop    %ebx
 975:	5e                   	pop    %esi
 976:	5f                   	pop    %edi
 977:	5d                   	pop    %ebp
 978:	c3                   	ret    
 979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 980:	39 d0                	cmp    %edx,%eax
 982:	72 04                	jb     988 <free+0x58>
 984:	39 d1                	cmp    %edx,%ecx
 986:	72 ce                	jb     956 <free+0x26>
{
 988:	89 d0                	mov    %edx,%eax
 98a:	eb bc                	jmp    948 <free+0x18>
 98c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 990:	03 72 04             	add    0x4(%edx),%esi
 993:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 996:	8b 10                	mov    (%eax),%edx
 998:	8b 12                	mov    (%edx),%edx
 99a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 99d:	8b 50 04             	mov    0x4(%eax),%edx
 9a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9a3:	39 f1                	cmp    %esi,%ecx
 9a5:	75 c6                	jne    96d <free+0x3d>
    p->s.size += bp->s.size;
 9a7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 9aa:	a3 7c 0e 00 00       	mov    %eax,0xe7c
    p->s.size += bp->s.size;
 9af:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9b2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 9b5:	89 10                	mov    %edx,(%eax)
}
 9b7:	5b                   	pop    %ebx
 9b8:	5e                   	pop    %esi
 9b9:	5f                   	pop    %edi
 9ba:	5d                   	pop    %ebp
 9bb:	c3                   	ret    
 9bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000009c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
 9c3:	57                   	push   %edi
 9c4:	56                   	push   %esi
 9c5:	53                   	push   %ebx
 9c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9cc:	8b 15 7c 0e 00 00    	mov    0xe7c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9d2:	8d 78 07             	lea    0x7(%eax),%edi
 9d5:	c1 ef 03             	shr    $0x3,%edi
 9d8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 9db:	85 d2                	test   %edx,%edx
 9dd:	0f 84 9d 00 00 00    	je     a80 <malloc+0xc0>
 9e3:	8b 02                	mov    (%edx),%eax
 9e5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 9e8:	39 cf                	cmp    %ecx,%edi
 9ea:	76 6c                	jbe    a58 <malloc+0x98>
 9ec:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 9f2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 9f7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 9fa:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 a01:	eb 0e                	jmp    a11 <malloc+0x51>
 a03:	90                   	nop
 a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a08:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a0a:	8b 48 04             	mov    0x4(%eax),%ecx
 a0d:	39 f9                	cmp    %edi,%ecx
 a0f:	73 47                	jae    a58 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a11:	39 05 7c 0e 00 00    	cmp    %eax,0xe7c
 a17:	89 c2                	mov    %eax,%edx
 a19:	75 ed                	jne    a08 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 a1b:	83 ec 0c             	sub    $0xc,%esp
 a1e:	56                   	push   %esi
 a1f:	e8 de fb ff ff       	call   602 <sbrk>
  if(p == (char*)-1)
 a24:	83 c4 10             	add    $0x10,%esp
 a27:	83 f8 ff             	cmp    $0xffffffff,%eax
 a2a:	74 1c                	je     a48 <malloc+0x88>
  hp->s.size = nu;
 a2c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a2f:	83 ec 0c             	sub    $0xc,%esp
 a32:	83 c0 08             	add    $0x8,%eax
 a35:	50                   	push   %eax
 a36:	e8 f5 fe ff ff       	call   930 <free>
  return freep;
 a3b:	8b 15 7c 0e 00 00    	mov    0xe7c,%edx
      if((p = morecore(nunits)) == 0)
 a41:	83 c4 10             	add    $0x10,%esp
 a44:	85 d2                	test   %edx,%edx
 a46:	75 c0                	jne    a08 <malloc+0x48>
        return 0;
  }
}
 a48:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 a4b:	31 c0                	xor    %eax,%eax
}
 a4d:	5b                   	pop    %ebx
 a4e:	5e                   	pop    %esi
 a4f:	5f                   	pop    %edi
 a50:	5d                   	pop    %ebp
 a51:	c3                   	ret    
 a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 a58:	39 cf                	cmp    %ecx,%edi
 a5a:	74 54                	je     ab0 <malloc+0xf0>
        p->s.size -= nunits;
 a5c:	29 f9                	sub    %edi,%ecx
 a5e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 a61:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a64:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 a67:	89 15 7c 0e 00 00    	mov    %edx,0xe7c
}
 a6d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 a70:	83 c0 08             	add    $0x8,%eax
}
 a73:	5b                   	pop    %ebx
 a74:	5e                   	pop    %esi
 a75:	5f                   	pop    %edi
 a76:	5d                   	pop    %ebp
 a77:	c3                   	ret    
 a78:	90                   	nop
 a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 a80:	c7 05 7c 0e 00 00 80 	movl   $0xe80,0xe7c
 a87:	0e 00 00 
 a8a:	c7 05 80 0e 00 00 80 	movl   $0xe80,0xe80
 a91:	0e 00 00 
    base.s.size = 0;
 a94:	b8 80 0e 00 00       	mov    $0xe80,%eax
 a99:	c7 05 84 0e 00 00 00 	movl   $0x0,0xe84
 aa0:	00 00 00 
 aa3:	e9 44 ff ff ff       	jmp    9ec <malloc+0x2c>
 aa8:	90                   	nop
 aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 ab0:	8b 08                	mov    (%eax),%ecx
 ab2:	89 0a                	mov    %ecx,(%edx)
 ab4:	eb b1                	jmp    a67 <malloc+0xa7>
