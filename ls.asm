
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
  44:	68 f0 0a 00 00       	push   $0xaf0
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
  ae:	68 5c 0e 00 00       	push   $0xe5c
  b3:	e8 88 04 00 00       	call   540 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  b8:	89 1c 24             	mov    %ebx,(%esp)
  bb:	e8 e0 02 00 00       	call   3a0 <strlen>
  c0:	89 1c 24             	mov    %ebx,(%esp)
  c3:	89 c6                	mov    %eax,%esi
  return buf;
  c5:	bb 5c 0e 00 00       	mov    $0xe5c,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  ca:	e8 d1 02 00 00       	call   3a0 <strlen>
  cf:	ba 0e 00 00 00       	mov    $0xe,%edx
  d4:	83 c4 0c             	add    $0xc,%esp
  d7:	05 5c 0e 00 00       	add    $0xe5c,%eax
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
 112:	e8 9b 04 00 00       	call   5b2 <open>
 117:	83 c4 10             	add    $0x10,%esp
 11a:	85 c0                	test   %eax,%eax
 11c:	78 4a                	js     168 <ls+0x68>
  if(fstat(fd, &st) < 0){
 11e:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 124:	83 ec 08             	sub    $0x8,%esp
 127:	89 c3                	mov    %eax,%ebx
 129:	56                   	push   %esi
 12a:	50                   	push   %eax
 12b:	e8 9a 04 00 00       	call   5ca <fstat>
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
 152:	e8 43 04 00 00       	call   59a <close>
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
 16c:	68 a8 0a 00 00       	push   $0xaa8
 171:	6a 02                	push   $0x2
 173:	e8 68 07 00 00       	call   8e0 <fprintf>
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
 1b0:	68 d0 0a 00 00       	push   $0xad0
 1b5:	e8 46 07 00 00       	call   900 <printf>
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
 1d9:	68 dd 0a 00 00       	push   $0xadd
 1de:	6a 02                	push   $0x2
 1e0:	e8 fb 06 00 00       	call   8e0 <fprintf>
      break;
 1e5:	83 c4 10             	add    $0x10,%esp
 1e8:	e9 61 ff ff ff       	jmp    14e <ls+0x4e>
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "ls: cannot stat %s\n", path);
 1f0:	83 ec 04             	sub    $0x4,%esp
 1f3:	57                   	push   %edi
 1f4:	68 bc 0a 00 00       	push   $0xabc
 1f9:	6a 02                	push   $0x2
 1fb:	e8 e0 06 00 00       	call   8e0 <fprintf>
    close(fd);
 200:	89 1c 24             	mov    %ebx,(%esp)
 203:	e8 92 03 00 00       	call   59a <close>
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
 2ee:	68 d0 0a 00 00       	push   $0xad0
 2f3:	e8 08 06 00 00       	call   900 <printf>
 2f8:	83 c4 20             	add    $0x20,%esp
 2fb:	e9 50 ff ff ff       	jmp    250 <ls+0x150>
        fprintf(2, "ls: cannot stat %s\n", buf);
 300:	83 ec 04             	sub    $0x4,%esp
 303:	57                   	push   %edi
 304:	68 bc 0a 00 00       	push   $0xabc
 309:	6a 02                	push   $0x2
 30b:	e8 d0 05 00 00       	call   8e0 <fprintf>
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
 4bd:	e8 f0 00 00 00       	call   5b2 <open>
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
 4d2:	e8 f3 00 00 00       	call   5ca <fstat>
  close(fd);
 4d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 4da:	89 c6                	mov    %eax,%esi
  close(fd);
 4dc:	e8 b9 00 00 00       	call   59a <close>
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

00000592 <write>:
SYSCALL(write)
 592:	b8 10 00 00 00       	mov    $0x10,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <close>:
SYSCALL(close)
 59a:	b8 15 00 00 00       	mov    $0x15,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <kill>:
SYSCALL(kill)
 5a2:	b8 06 00 00 00       	mov    $0x6,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <exec>:
SYSCALL(exec)
 5aa:	b8 07 00 00 00       	mov    $0x7,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <open>:
SYSCALL(open)
 5b2:	b8 0f 00 00 00       	mov    $0xf,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <mknod>:
SYSCALL(mknod)
 5ba:	b8 11 00 00 00       	mov    $0x11,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <unlink>:
SYSCALL(unlink)
 5c2:	b8 12 00 00 00       	mov    $0x12,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <fstat>:
SYSCALL(fstat)
 5ca:	b8 08 00 00 00       	mov    $0x8,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    

000005d2 <link>:
SYSCALL(link)
 5d2:	b8 13 00 00 00       	mov    $0x13,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret    

000005da <mkdir>:
SYSCALL(mkdir)
 5da:	b8 14 00 00 00       	mov    $0x14,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    

000005e2 <chdir>:
SYSCALL(chdir)
 5e2:	b8 09 00 00 00       	mov    $0x9,%eax
 5e7:	cd 40                	int    $0x40
 5e9:	c3                   	ret    

000005ea <dup>:
SYSCALL(dup)
 5ea:	b8 0a 00 00 00       	mov    $0xa,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret    

000005f2 <getpid>:
SYSCALL(getpid)
 5f2:	b8 0b 00 00 00       	mov    $0xb,%eax
 5f7:	cd 40                	int    $0x40
 5f9:	c3                   	ret    

000005fa <sbrk>:
SYSCALL(sbrk)
 5fa:	b8 0c 00 00 00       	mov    $0xc,%eax
 5ff:	cd 40                	int    $0x40
 601:	c3                   	ret    

00000602 <sleep>:
SYSCALL(sleep)
 602:	b8 0d 00 00 00       	mov    $0xd,%eax
 607:	cd 40                	int    $0x40
 609:	c3                   	ret    

0000060a <uptime>:
SYSCALL(uptime)
 60a:	b8 0e 00 00 00       	mov    $0xe,%eax
 60f:	cd 40                	int    $0x40
 611:	c3                   	ret    

00000612 <cpuhalt>:
SYSCALL(cpuhalt)
 612:	b8 16 00 00 00       	mov    $0x16,%eax
 617:	cd 40                	int    $0x40
 619:	c3                   	ret    
 61a:	66 90                	xchg   %ax,%ax
 61c:	66 90                	xchg   %ax,%ax
 61e:	66 90                	xchg   %ax,%ax

00000620 <printint.constprop.1>:
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
}

static void
printint(int fd, int xx, int base, int sgn)
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	57                   	push   %edi
 624:	56                   	push   %esi
 625:	53                   	push   %ebx
 626:	89 d6                	mov    %edx,%esi
 628:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 62b:	85 c0                	test   %eax,%eax
 62d:	79 71                	jns    6a0 <printint.constprop.1+0x80>
 62f:	83 e1 01             	and    $0x1,%ecx
 632:	74 6c                	je     6a0 <printint.constprop.1+0x80>
    neg = 1;
    x = -xx;
 634:	f7 d8                	neg    %eax
    neg = 1;
 636:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 63d:	31 c9                	xor    %ecx,%ecx
 63f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 642:	eb 06                	jmp    64a <printint.constprop.1+0x2a>
 644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 648:	89 f9                	mov    %edi,%ecx
 64a:	31 d2                	xor    %edx,%edx
 64c:	8d 79 01             	lea    0x1(%ecx),%edi
 64f:	f7 f6                	div    %esi
 651:	0f b6 92 fc 0a 00 00 	movzbl 0xafc(%edx),%edx
  }while((x /= base) != 0);
 658:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 65a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 65d:	75 e9                	jne    648 <printint.constprop.1+0x28>
  if(neg)
 65f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 662:	85 c0                	test   %eax,%eax
 664:	74 08                	je     66e <printint.constprop.1+0x4e>
    buf[i++] = '-';
 666:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 66b:	8d 79 02             	lea    0x2(%ecx),%edi
 66e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 678:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 67b:	83 ec 04             	sub    $0x4,%esp
 67e:	83 ee 01             	sub    $0x1,%esi
 681:	6a 01                	push   $0x1
 683:	53                   	push   %ebx
 684:	6a 01                	push   $0x1
 686:	88 45 d7             	mov    %al,-0x29(%ebp)
 689:	e8 04 ff ff ff       	call   592 <write>

  while(--i >= 0)
 68e:	83 c4 10             	add    $0x10,%esp
 691:	39 de                	cmp    %ebx,%esi
 693:	75 e3                	jne    678 <printint.constprop.1+0x58>
    putc(fd, buf[i]);
}
 695:	8d 65 f4             	lea    -0xc(%ebp),%esp
 698:	5b                   	pop    %ebx
 699:	5e                   	pop    %esi
 69a:	5f                   	pop    %edi
 69b:	5d                   	pop    %ebp
 69c:	c3                   	ret    
 69d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 6a0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 6a7:	eb 94                	jmp    63d <printint.constprop.1+0x1d>
 6a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006b0 <vprintf.constprop.0>:
static void vprintf(int fd, const char *fmt, va_list ap)
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	56                   	push   %esi
 6b5:	53                   	push   %ebx
 6b6:	89 d6                	mov    %edx,%esi
 6b8:	83 ec 2c             	sub    $0x2c,%esp
{
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6bb:	0f b6 10             	movzbl (%eax),%edx
 6be:	84 d2                	test   %dl,%dl
 6c0:	0f 84 cd 00 00 00    	je     793 <vprintf.constprop.0+0xe3>
 6c6:	8d 58 01             	lea    0x1(%eax),%ebx
  state = 0;
 6c9:	31 ff                	xor    %edi,%edi
 6cb:	eb 31                	jmp    6fe <vprintf.constprop.0+0x4e>
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6d0:	83 f8 25             	cmp    $0x25,%eax
 6d3:	0f 84 c7 00 00 00    	je     7a0 <vprintf.constprop.0+0xf0>
  write(fd, &c, 1);
 6d9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6dc:	83 ec 04             	sub    $0x4,%esp
 6df:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 6e2:	6a 01                	push   $0x1
 6e4:	50                   	push   %eax
 6e5:	6a 01                	push   $0x1
 6e7:	e8 a6 fe ff ff       	call   592 <write>
 6ec:	83 c4 10             	add    $0x10,%esp
 6ef:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 6f2:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 6f6:	84 d2                	test   %dl,%dl
 6f8:	0f 84 95 00 00 00    	je     793 <vprintf.constprop.0+0xe3>
    if(state == 0){
 6fe:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 700:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 703:	74 cb                	je     6d0 <vprintf.constprop.0+0x20>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 705:	83 ff 25             	cmp    $0x25,%edi
 708:	75 e5                	jne    6ef <vprintf.constprop.0+0x3f>
      if(c == 'd'){
 70a:	83 f8 64             	cmp    $0x64,%eax
        printint(fd, va_arg(ap, int), 10, 1);
 70d:	8d 7e 04             	lea    0x4(%esi),%edi
 710:	b9 01 00 00 00       	mov    $0x1,%ecx
      if(c == 'd'){
 715:	0f 84 9a 00 00 00    	je     7b5 <vprintf.constprop.0+0x105>
      } else if(c == 'l') {
 71b:	83 f8 6c             	cmp    $0x6c,%eax
 71e:	0f 84 8c 00 00 00    	je     7b0 <vprintf.constprop.0+0x100>
        printint(fd, va_arg(ap, uint), 10, 0);
      } else if(c == 'x') {
 724:	83 f8 78             	cmp    $0x78,%eax
 727:	0f 84 a3 00 00 00    	je     7d0 <vprintf.constprop.0+0x120>
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 72d:	83 f8 70             	cmp    $0x70,%eax
 730:	0f 84 ca 00 00 00    	je     800 <vprintf.constprop.0+0x150>
        printptr(fd, va_arg(ap, uint));
      } else if(c == 's'){
 736:	83 f8 73             	cmp    $0x73,%eax
 739:	0f 84 39 01 00 00    	je     878 <vprintf.constprop.0+0x1c8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 73f:	83 f8 63             	cmp    $0x63,%eax
 742:	0f 84 68 01 00 00    	je     8b0 <vprintf.constprop.0+0x200>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 748:	83 f8 25             	cmp    $0x25,%eax
 74b:	0f 84 9f 00 00 00    	je     7f0 <vprintf.constprop.0+0x140>
  write(fd, &c, 1);
 751:	8d 45 df             	lea    -0x21(%ebp),%eax
 754:	83 ec 04             	sub    $0x4,%esp
 757:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 75a:	6a 01                	push   $0x1
 75c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 760:	50                   	push   %eax
 761:	6a 01                	push   $0x1
 763:	e8 2a fe ff ff       	call   592 <write>
 768:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 76c:	83 c4 0c             	add    $0xc,%esp
 76f:	8d 45 e0             	lea    -0x20(%ebp),%eax
 772:	6a 01                	push   $0x1
 774:	88 55 e0             	mov    %dl,-0x20(%ebp)
 777:	50                   	push   %eax
 778:	6a 01                	push   $0x1
 77a:	83 c3 01             	add    $0x1,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 77d:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 77f:	e8 0e fe ff ff       	call   592 <write>
  for(i = 0; fmt[i]; i++){
 784:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
  write(fd, &c, 1);
 788:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 78b:	84 d2                	test   %dl,%dl
 78d:	0f 85 6b ff ff ff    	jne    6fe <vprintf.constprop.0+0x4e>
    }
  }
}
 793:	8d 65 f4             	lea    -0xc(%ebp),%esp
 796:	5b                   	pop    %ebx
 797:	5e                   	pop    %esi
 798:	5f                   	pop    %edi
 799:	5d                   	pop    %ebp
 79a:	c3                   	ret    
 79b:	90                   	nop
 79c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        state = '%';
 7a0:	bf 25 00 00 00       	mov    $0x25,%edi
 7a5:	e9 45 ff ff ff       	jmp    6ef <vprintf.constprop.0+0x3f>
 7aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, uint), 10, 0);
 7b0:	8d 7e 04             	lea    0x4(%esi),%edi
 7b3:	31 c9                	xor    %ecx,%ecx
 7b5:	8b 06                	mov    (%esi),%eax
 7b7:	ba 0a 00 00 00       	mov    $0xa,%edx
 7bc:	89 fe                	mov    %edi,%esi
      state = 0;
 7be:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, uint), 10, 0);
 7c0:	e8 5b fe ff ff       	call   620 <printint.constprop.1>
 7c5:	e9 25 ff ff ff       	jmp    6ef <vprintf.constprop.0+0x3f>
 7ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, int), 16, 0);
 7d0:	8b 06                	mov    (%esi),%eax
 7d2:	8d 7e 04             	lea    0x4(%esi),%edi
 7d5:	31 c9                	xor    %ecx,%ecx
 7d7:	ba 10 00 00 00       	mov    $0x10,%edx
 7dc:	89 fe                	mov    %edi,%esi
      state = 0;
 7de:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, int), 16, 0);
 7e0:	e8 3b fe ff ff       	call   620 <printint.constprop.1>
 7e5:	e9 05 ff ff ff       	jmp    6ef <vprintf.constprop.0+0x3f>
 7ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 7f0:	83 ec 04             	sub    $0x4,%esp
 7f3:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 7f6:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 7f9:	6a 01                	push   $0x1
 7fb:	e9 77 ff ff ff       	jmp    777 <vprintf.constprop.0+0xc7>
        printptr(fd, va_arg(ap, uint));
 800:	8d 46 04             	lea    0x4(%esi),%eax
  write(fd, &c, 1);
 803:	83 ec 04             	sub    $0x4,%esp
        printptr(fd, va_arg(ap, uint));
 806:	8b 3e                	mov    (%esi),%edi
  write(fd, &c, 1);
 808:	6a 01                	push   $0x1
 80a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 80e:	be 08 00 00 00       	mov    $0x8,%esi
        printptr(fd, va_arg(ap, uint));
 813:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 816:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 819:	50                   	push   %eax
 81a:	6a 01                	push   $0x1
 81c:	e8 71 fd ff ff       	call   592 <write>
 821:	8d 45 e7             	lea    -0x19(%ebp),%eax
 824:	83 c4 0c             	add    $0xc,%esp
 827:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 82b:	6a 01                	push   $0x1
 82d:	50                   	push   %eax
 82e:	6a 01                	push   $0x1
 830:	e8 5d fd ff ff       	call   592 <write>
 835:	83 c4 10             	add    $0x10,%esp
 838:	90                   	nop
 839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
 840:	89 f8                	mov    %edi,%eax
  write(fd, &c, 1);
 842:	83 ec 04             	sub    $0x4,%esp
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
 845:	c1 e7 04             	shl    $0x4,%edi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
 848:	c1 e8 1c             	shr    $0x1c,%eax
  write(fd, &c, 1);
 84b:	6a 01                	push   $0x1
 84d:	0f b6 80 fc 0a 00 00 	movzbl 0xafc(%eax),%eax
 854:	88 45 e5             	mov    %al,-0x1b(%ebp)
 857:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 85a:	50                   	push   %eax
 85b:	6a 01                	push   $0x1
 85d:	e8 30 fd ff ff       	call   592 <write>
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
 862:	83 c4 10             	add    $0x10,%esp
 865:	83 ee 01             	sub    $0x1,%esi
 868:	75 d6                	jne    840 <vprintf.constprop.0+0x190>
        s = va_arg(ap, char*);
 86a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 86d:	31 ff                	xor    %edi,%edi
 86f:	e9 7b fe ff ff       	jmp    6ef <vprintf.constprop.0+0x3f>
 874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = va_arg(ap, char*);
 878:	8b 3e                	mov    (%esi),%edi
 87a:	8d 46 04             	lea    0x4(%esi),%eax
 87d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 880:	85 ff                	test   %edi,%edi
 882:	74 50                	je     8d4 <vprintf.constprop.0+0x224>
        while(*s != 0){
 884:	0f b6 07             	movzbl (%edi),%eax
 887:	84 c0                	test   %al,%al
 889:	74 df                	je     86a <vprintf.constprop.0+0x1ba>
 88b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 88e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 890:	83 ec 04             	sub    $0x4,%esp
          s++;
 893:	83 c7 01             	add    $0x1,%edi
 896:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 899:	6a 01                	push   $0x1
 89b:	56                   	push   %esi
 89c:	6a 01                	push   $0x1
 89e:	e8 ef fc ff ff       	call   592 <write>
        while(*s != 0){
 8a3:	0f b6 07             	movzbl (%edi),%eax
 8a6:	83 c4 10             	add    $0x10,%esp
 8a9:	84 c0                	test   %al,%al
 8ab:	75 e3                	jne    890 <vprintf.constprop.0+0x1e0>
 8ad:	eb bb                	jmp    86a <vprintf.constprop.0+0x1ba>
 8af:	90                   	nop
        putc(fd, va_arg(ap, uint));
 8b0:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 8b2:	83 ec 04             	sub    $0x4,%esp
        putc(fd, va_arg(ap, uint));
 8b5:	8d 7e 04             	lea    0x4(%esi),%edi
  write(fd, &c, 1);
 8b8:	6a 01                	push   $0x1
        putc(fd, va_arg(ap, uint));
 8ba:	89 fe                	mov    %edi,%esi
      state = 0;
 8bc:	31 ff                	xor    %edi,%edi
        putc(fd, va_arg(ap, uint));
 8be:	88 45 e2             	mov    %al,-0x1e(%ebp)
  write(fd, &c, 1);
 8c1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 8c4:	50                   	push   %eax
 8c5:	6a 01                	push   $0x1
 8c7:	e8 c6 fc ff ff       	call   592 <write>
 8cc:	83 c4 10             	add    $0x10,%esp
 8cf:	e9 1b fe ff ff       	jmp    6ef <vprintf.constprop.0+0x3f>
          s = "(null)";
 8d4:	bf f2 0a 00 00       	mov    $0xaf2,%edi
        while(*s != 0){
 8d9:	b8 28 00 00 00       	mov    $0x28,%eax
 8de:	eb ab                	jmp    88b <vprintf.constprop.0+0x1db>

000008e0 <fprintf>:
// Print to the given fd. Only understands %d,%x, %p, %s, %c.
void
fprintf(int fd, const char *fmt, ...)
{
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	83 ec 08             	sub    $0x8,%esp
 va_list ap;
 va_start(ap, fmt); 
 vprintf(1,fmt,ap);
 8e6:	8b 45 0c             	mov    0xc(%ebp),%eax
 8e9:	8d 55 10             	lea    0x10(%ebp),%edx
 8ec:	e8 bf fd ff ff       	call   6b0 <vprintf.constprop.0>
}
 8f1:	c9                   	leave  
 8f2:	c3                   	ret    
 8f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000900 <printf>:
void
printf(const char *fmt, ...)
{
 900:	55                   	push   %ebp
 901:	89 e5                	mov    %esp,%ebp
 903:	83 ec 08             	sub    $0x8,%esp
  va_list ap;
  va_start(ap, fmt); 
  vprintf(1,fmt,ap);
 906:	8b 45 08             	mov    0x8(%ebp),%eax
 909:	8d 55 0c             	lea    0xc(%ebp),%edx
 90c:	e8 9f fd ff ff       	call   6b0 <vprintf.constprop.0>
}
 911:	c9                   	leave  
 912:	c3                   	ret    
 913:	66 90                	xchg   %ax,%ax
 915:	66 90                	xchg   %ax,%ax
 917:	66 90                	xchg   %ax,%ax
 919:	66 90                	xchg   %ax,%ax
 91b:	66 90                	xchg   %ax,%ax
 91d:	66 90                	xchg   %ax,%ax
 91f:	90                   	nop

00000920 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 920:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 921:	a1 6c 0e 00 00       	mov    0xe6c,%eax
{
 926:	89 e5                	mov    %esp,%ebp
 928:	57                   	push   %edi
 929:	56                   	push   %esi
 92a:	53                   	push   %ebx
 92b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 92e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 938:	39 c8                	cmp    %ecx,%eax
 93a:	8b 10                	mov    (%eax),%edx
 93c:	73 32                	jae    970 <free+0x50>
 93e:	39 d1                	cmp    %edx,%ecx
 940:	72 04                	jb     946 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 942:	39 d0                	cmp    %edx,%eax
 944:	72 32                	jb     978 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 946:	8b 73 fc             	mov    -0x4(%ebx),%esi
 949:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 94c:	39 fa                	cmp    %edi,%edx
 94e:	74 30                	je     980 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 950:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 953:	8b 50 04             	mov    0x4(%eax),%edx
 956:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 959:	39 f1                	cmp    %esi,%ecx
 95b:	74 3a                	je     997 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 95d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 95f:	a3 6c 0e 00 00       	mov    %eax,0xe6c
}
 964:	5b                   	pop    %ebx
 965:	5e                   	pop    %esi
 966:	5f                   	pop    %edi
 967:	5d                   	pop    %ebp
 968:	c3                   	ret    
 969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 970:	39 d0                	cmp    %edx,%eax
 972:	72 04                	jb     978 <free+0x58>
 974:	39 d1                	cmp    %edx,%ecx
 976:	72 ce                	jb     946 <free+0x26>
{
 978:	89 d0                	mov    %edx,%eax
 97a:	eb bc                	jmp    938 <free+0x18>
 97c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 980:	03 72 04             	add    0x4(%edx),%esi
 983:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 986:	8b 10                	mov    (%eax),%edx
 988:	8b 12                	mov    (%edx),%edx
 98a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 98d:	8b 50 04             	mov    0x4(%eax),%edx
 990:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 993:	39 f1                	cmp    %esi,%ecx
 995:	75 c6                	jne    95d <free+0x3d>
    p->s.size += bp->s.size;
 997:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 99a:	a3 6c 0e 00 00       	mov    %eax,0xe6c
    p->s.size += bp->s.size;
 99f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9a2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 9a5:	89 10                	mov    %edx,(%eax)
}
 9a7:	5b                   	pop    %ebx
 9a8:	5e                   	pop    %esi
 9a9:	5f                   	pop    %edi
 9aa:	5d                   	pop    %ebp
 9ab:	c3                   	ret    
 9ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000009b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9b0:	55                   	push   %ebp
 9b1:	89 e5                	mov    %esp,%ebp
 9b3:	57                   	push   %edi
 9b4:	56                   	push   %esi
 9b5:	53                   	push   %ebx
 9b6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9bc:	8b 15 6c 0e 00 00    	mov    0xe6c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9c2:	8d 78 07             	lea    0x7(%eax),%edi
 9c5:	c1 ef 03             	shr    $0x3,%edi
 9c8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 9cb:	85 d2                	test   %edx,%edx
 9cd:	0f 84 9d 00 00 00    	je     a70 <malloc+0xc0>
 9d3:	8b 02                	mov    (%edx),%eax
 9d5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 9d8:	39 cf                	cmp    %ecx,%edi
 9da:	76 6c                	jbe    a48 <malloc+0x98>
 9dc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 9e2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 9e7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 9ea:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 9f1:	eb 0e                	jmp    a01 <malloc+0x51>
 9f3:	90                   	nop
 9f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9f8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 9fa:	8b 48 04             	mov    0x4(%eax),%ecx
 9fd:	39 f9                	cmp    %edi,%ecx
 9ff:	73 47                	jae    a48 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a01:	39 05 6c 0e 00 00    	cmp    %eax,0xe6c
 a07:	89 c2                	mov    %eax,%edx
 a09:	75 ed                	jne    9f8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 a0b:	83 ec 0c             	sub    $0xc,%esp
 a0e:	56                   	push   %esi
 a0f:	e8 e6 fb ff ff       	call   5fa <sbrk>
  if(p == (char*)-1)
 a14:	83 c4 10             	add    $0x10,%esp
 a17:	83 f8 ff             	cmp    $0xffffffff,%eax
 a1a:	74 1c                	je     a38 <malloc+0x88>
  hp->s.size = nu;
 a1c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a1f:	83 ec 0c             	sub    $0xc,%esp
 a22:	83 c0 08             	add    $0x8,%eax
 a25:	50                   	push   %eax
 a26:	e8 f5 fe ff ff       	call   920 <free>
  return freep;
 a2b:	8b 15 6c 0e 00 00    	mov    0xe6c,%edx
      if((p = morecore(nunits)) == 0)
 a31:	83 c4 10             	add    $0x10,%esp
 a34:	85 d2                	test   %edx,%edx
 a36:	75 c0                	jne    9f8 <malloc+0x48>
        return 0;
  }
}
 a38:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 a3b:	31 c0                	xor    %eax,%eax
}
 a3d:	5b                   	pop    %ebx
 a3e:	5e                   	pop    %esi
 a3f:	5f                   	pop    %edi
 a40:	5d                   	pop    %ebp
 a41:	c3                   	ret    
 a42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 a48:	39 cf                	cmp    %ecx,%edi
 a4a:	74 54                	je     aa0 <malloc+0xf0>
        p->s.size -= nunits;
 a4c:	29 f9                	sub    %edi,%ecx
 a4e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 a51:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a54:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 a57:	89 15 6c 0e 00 00    	mov    %edx,0xe6c
}
 a5d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 a60:	83 c0 08             	add    $0x8,%eax
}
 a63:	5b                   	pop    %ebx
 a64:	5e                   	pop    %esi
 a65:	5f                   	pop    %edi
 a66:	5d                   	pop    %ebp
 a67:	c3                   	ret    
 a68:	90                   	nop
 a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 a70:	c7 05 6c 0e 00 00 70 	movl   $0xe70,0xe6c
 a77:	0e 00 00 
 a7a:	c7 05 70 0e 00 00 70 	movl   $0xe70,0xe70
 a81:	0e 00 00 
    base.s.size = 0;
 a84:	b8 70 0e 00 00       	mov    $0xe70,%eax
 a89:	c7 05 74 0e 00 00 00 	movl   $0x0,0xe74
 a90:	00 00 00 
 a93:	e9 44 ff ff ff       	jmp    9dc <malloc+0x2c>
 a98:	90                   	nop
 a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 aa0:	8b 08                	mov    (%eax),%ecx
 aa2:	89 0a                	mov    %ecx,(%edx)
 aa4:	eb b1                	jmp    a57 <malloc+0xa7>
