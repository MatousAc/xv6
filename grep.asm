
user/_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

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
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 39                	mov    (%ecx),%edi
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
  19:	83 ff 01             	cmp    $0x1,%edi
  1c:	7e 7c                	jle    9a <main+0x9a>
    fprintf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  1e:	8b 43 04             	mov    0x4(%ebx),%eax
  21:	83 c3 08             	add    $0x8,%ebx

  if(argc <= 2){
  24:	83 ff 02             	cmp    $0x2,%edi
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  27:	be 02 00 00 00       	mov    $0x2,%esi
  pattern = argv[1];
  2c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(argc <= 2){
  2f:	74 46                	je     77 <main+0x77>
  31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((fd = open(argv[i], 0)) < 0){
  38:	83 ec 08             	sub    $0x8,%esp
  3b:	6a 00                	push   $0x0
  3d:	ff 33                	pushl  (%ebx)
  3f:	e8 86 05 00 00       	call   5ca <open>
  44:	83 c4 10             	add    $0x10,%esp
  47:	85 c0                	test   %eax,%eax
  49:	78 3b                	js     86 <main+0x86>
      fprintf(2, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  4b:	83 ec 08             	sub    $0x8,%esp
  4e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(i = 2; i < argc; i++){
  51:	83 c6 01             	add    $0x1,%esi
    grep(pattern, fd);
  54:	50                   	push   %eax
  55:	ff 75 e0             	pushl  -0x20(%ebp)
  58:	83 c3 04             	add    $0x4,%ebx
  5b:	e8 d0 01 00 00       	call   230 <grep>
    close(fd);
  60:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  63:	89 04 24             	mov    %eax,(%esp)
  66:	e8 47 05 00 00       	call   5b2 <close>
  for(i = 2; i < argc; i++){
  6b:	83 c4 10             	add    $0x10,%esp
  6e:	39 f7                	cmp    %esi,%edi
  70:	7f c6                	jg     38 <main+0x38>
  }
  exit();
  72:	e8 0b 05 00 00       	call   582 <exit>
    grep(pattern, 0);
  77:	52                   	push   %edx
  78:	52                   	push   %edx
  79:	6a 00                	push   $0x0
  7b:	50                   	push   %eax
  7c:	e8 af 01 00 00       	call   230 <grep>
    exit();
  81:	e8 fc 04 00 00       	call   582 <exit>
      fprintf(2, "grep: cannot open %s\n", argv[i]);
  86:	50                   	push   %eax
  87:	ff 33                	pushl  (%ebx)
  89:	68 e8 0a 00 00       	push   $0xae8
  8e:	6a 02                	push   $0x2
  90:	e8 6b 08 00 00       	call   900 <fprintf>
      exit();
  95:	e8 e8 04 00 00       	call   582 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
  9a:	51                   	push   %ecx
  9b:	51                   	push   %ecx
  9c:	68 c8 0a 00 00       	push   $0xac8
  a1:	6a 02                	push   $0x2
  a3:	e8 58 08 00 00       	call   900 <fprintf>
    exit();
  a8:	e8 d5 04 00 00       	call   582 <exit>
  ad:	66 90                	xchg   %ax,%ax
  af:	90                   	nop

000000b0 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	57                   	push   %edi
  b4:	56                   	push   %esi
  b5:	53                   	push   %ebx
  b6:	83 ec 0c             	sub    $0xc,%esp
  b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  bf:	8b 7d 10             	mov    0x10(%ebp),%edi
  c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  c8:	83 ec 08             	sub    $0x8,%esp
  cb:	57                   	push   %edi
  cc:	56                   	push   %esi
  cd:	e8 3e 00 00 00       	call   110 <matchhere>
  d2:	83 c4 10             	add    $0x10,%esp
  d5:	85 c0                	test   %eax,%eax
  d7:	75 1f                	jne    f8 <matchstar+0x48>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  d9:	0f be 17             	movsbl (%edi),%edx
  dc:	84 d2                	test   %dl,%dl
  de:	74 0c                	je     ec <matchstar+0x3c>
  e0:	83 c7 01             	add    $0x1,%edi
  e3:	39 da                	cmp    %ebx,%edx
  e5:	74 e1                	je     c8 <matchstar+0x18>
  e7:	83 fb 2e             	cmp    $0x2e,%ebx
  ea:	74 dc                	je     c8 <matchstar+0x18>
  return 0;
}
  ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ef:	5b                   	pop    %ebx
  f0:	5e                   	pop    %esi
  f1:	5f                   	pop    %edi
  f2:	5d                   	pop    %ebp
  f3:	c3                   	ret    
  f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 1;
  fb:	b8 01 00 00 00       	mov    $0x1,%eax
}
 100:	5b                   	pop    %ebx
 101:	5e                   	pop    %esi
 102:	5f                   	pop    %edi
 103:	5d                   	pop    %ebp
 104:	c3                   	ret    
 105:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000110 <matchhere>:
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	56                   	push   %esi
 115:	53                   	push   %ebx
 116:	83 ec 0c             	sub    $0xc,%esp
  if(re[0] == '\0')
 119:	8b 45 08             	mov    0x8(%ebp),%eax
{
 11c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(re[0] == '\0')
 11f:	0f b6 08             	movzbl (%eax),%ecx
 122:	84 c9                	test   %cl,%cl
 124:	74 67                	je     18d <matchhere+0x7d>
  if(re[1] == '*')
 126:	0f be 40 01          	movsbl 0x1(%eax),%eax
 12a:	3c 2a                	cmp    $0x2a,%al
 12c:	74 6c                	je     19a <matchhere+0x8a>
  if(re[0] == '$' && re[1] == '\0')
 12e:	80 f9 24             	cmp    $0x24,%cl
 131:	0f b6 1f             	movzbl (%edi),%ebx
 134:	75 08                	jne    13e <matchhere+0x2e>
 136:	84 c0                	test   %al,%al
 138:	0f 84 81 00 00 00    	je     1bf <matchhere+0xaf>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 13e:	84 db                	test   %bl,%bl
 140:	74 09                	je     14b <matchhere+0x3b>
 142:	38 d9                	cmp    %bl,%cl
 144:	74 3c                	je     182 <matchhere+0x72>
 146:	80 f9 2e             	cmp    $0x2e,%cl
 149:	74 37                	je     182 <matchhere+0x72>
}
 14b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
 14e:	31 c0                	xor    %eax,%eax
}
 150:	5b                   	pop    %ebx
 151:	5e                   	pop    %esi
 152:	5f                   	pop    %edi
 153:	5d                   	pop    %ebp
 154:	c3                   	ret    
 155:	8d 76 00             	lea    0x0(%esi),%esi
  if(re[1] == '*')
 158:	8b 75 08             	mov    0x8(%ebp),%esi
 15b:	0f b6 4e 01          	movzbl 0x1(%esi),%ecx
 15f:	80 f9 2a             	cmp    $0x2a,%cl
 162:	74 3b                	je     19f <matchhere+0x8f>
  if(re[0] == '$' && re[1] == '\0')
 164:	3c 24                	cmp    $0x24,%al
 166:	75 04                	jne    16c <matchhere+0x5c>
 168:	84 c9                	test   %cl,%cl
 16a:	74 4f                	je     1bb <matchhere+0xab>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 16c:	0f b6 33             	movzbl (%ebx),%esi
 16f:	89 f2                	mov    %esi,%edx
 171:	84 d2                	test   %dl,%dl
 173:	74 d6                	je     14b <matchhere+0x3b>
 175:	3c 2e                	cmp    $0x2e,%al
 177:	89 df                	mov    %ebx,%edi
 179:	74 04                	je     17f <matchhere+0x6f>
 17b:	38 c2                	cmp    %al,%dl
 17d:	75 cc                	jne    14b <matchhere+0x3b>
 17f:	0f be c1             	movsbl %cl,%eax
    return matchhere(re+1, text+1);
 182:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  if(re[0] == '\0')
 186:	84 c0                	test   %al,%al
    return matchhere(re+1, text+1);
 188:	8d 5f 01             	lea    0x1(%edi),%ebx
  if(re[0] == '\0')
 18b:	75 cb                	jne    158 <matchhere+0x48>
    return 1;
 18d:	b8 01 00 00 00       	mov    $0x1,%eax
}
 192:	8d 65 f4             	lea    -0xc(%ebp),%esp
 195:	5b                   	pop    %ebx
 196:	5e                   	pop    %esi
 197:	5f                   	pop    %edi
 198:	5d                   	pop    %ebp
 199:	c3                   	ret    
  if(re[1] == '*')
 19a:	89 fb                	mov    %edi,%ebx
 19c:	0f be c1             	movsbl %cl,%eax
    return matchstar(re[0], re+2, text);
 19f:	8b 7d 08             	mov    0x8(%ebp),%edi
 1a2:	83 ec 04             	sub    $0x4,%esp
 1a5:	53                   	push   %ebx
 1a6:	8d 57 02             	lea    0x2(%edi),%edx
 1a9:	52                   	push   %edx
 1aa:	50                   	push   %eax
 1ab:	e8 00 ff ff ff       	call   b0 <matchstar>
 1b0:	83 c4 10             	add    $0x10,%esp
}
 1b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1b6:	5b                   	pop    %ebx
 1b7:	5e                   	pop    %esi
 1b8:	5f                   	pop    %edi
 1b9:	5d                   	pop    %ebp
 1ba:	c3                   	ret    
 1bb:	0f b6 5f 01          	movzbl 0x1(%edi),%ebx
    return *text == '\0';
 1bf:	31 c0                	xor    %eax,%eax
 1c1:	84 db                	test   %bl,%bl
 1c3:	0f 94 c0             	sete   %al
 1c6:	eb ca                	jmp    192 <matchhere+0x82>
 1c8:	90                   	nop
 1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001d0 <match>:
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	56                   	push   %esi
 1d4:	53                   	push   %ebx
 1d5:	8b 75 08             	mov    0x8(%ebp),%esi
 1d8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
 1db:	80 3e 5e             	cmpb   $0x5e,(%esi)
 1de:	75 11                	jne    1f1 <match+0x21>
 1e0:	eb 2e                	jmp    210 <match+0x40>
 1e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }while(*text++ != '\0');
 1e8:	83 c3 01             	add    $0x1,%ebx
 1eb:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
 1ef:	74 16                	je     207 <match+0x37>
    if(matchhere(re, text))
 1f1:	83 ec 08             	sub    $0x8,%esp
 1f4:	53                   	push   %ebx
 1f5:	56                   	push   %esi
 1f6:	e8 15 ff ff ff       	call   110 <matchhere>
 1fb:	83 c4 10             	add    $0x10,%esp
 1fe:	85 c0                	test   %eax,%eax
 200:	74 e6                	je     1e8 <match+0x18>
      return 1;
 202:	b8 01 00 00 00       	mov    $0x1,%eax
}
 207:	8d 65 f8             	lea    -0x8(%ebp),%esp
 20a:	5b                   	pop    %ebx
 20b:	5e                   	pop    %esi
 20c:	5d                   	pop    %ebp
 20d:	c3                   	ret    
 20e:	66 90                	xchg   %ax,%ax
    return matchhere(re+1, text);
 210:	83 c6 01             	add    $0x1,%esi
 213:	89 75 08             	mov    %esi,0x8(%ebp)
}
 216:	8d 65 f8             	lea    -0x8(%ebp),%esp
 219:	5b                   	pop    %ebx
 21a:	5e                   	pop    %esi
 21b:	5d                   	pop    %ebp
    return matchhere(re+1, text);
 21c:	e9 ef fe ff ff       	jmp    110 <matchhere>
 221:	eb 0d                	jmp    230 <grep>
 223:	90                   	nop
 224:	90                   	nop
 225:	90                   	nop
 226:	90                   	nop
 227:	90                   	nop
 228:	90                   	nop
 229:	90                   	nop
 22a:	90                   	nop
 22b:	90                   	nop
 22c:	90                   	nop
 22d:	90                   	nop
 22e:	90                   	nop
 22f:	90                   	nop

00000230 <grep>:
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	56                   	push   %esi
 235:	53                   	push   %ebx
  m = 0;
 236:	31 f6                	xor    %esi,%esi
{
 238:	83 ec 1c             	sub    $0x1c,%esp
 23b:	90                   	nop
 23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 240:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 245:	83 ec 04             	sub    $0x4,%esp
 248:	29 f0                	sub    %esi,%eax
 24a:	50                   	push   %eax
 24b:	8d 86 00 0f 00 00    	lea    0xf00(%esi),%eax
 251:	50                   	push   %eax
 252:	ff 75 0c             	pushl  0xc(%ebp)
 255:	e8 40 03 00 00       	call   59a <read>
 25a:	83 c4 10             	add    $0x10,%esp
 25d:	85 c0                	test   %eax,%eax
 25f:	0f 8e bb 00 00 00    	jle    320 <grep+0xf0>
    m += n;
 265:	01 c6                	add    %eax,%esi
    p = buf;
 267:	bb 00 0f 00 00       	mov    $0xf00,%ebx
    buf[m] = '\0';
 26c:	c6 86 00 0f 00 00 00 	movb   $0x0,0xf00(%esi)
 273:	89 75 e4             	mov    %esi,-0x1c(%ebp)
 276:	8d 76 00             	lea    0x0(%esi),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while((q = strchr(p, '\n')) != 0){
 280:	83 ec 08             	sub    $0x8,%esp
 283:	6a 0a                	push   $0xa
 285:	53                   	push   %ebx
 286:	e8 75 01 00 00       	call   400 <strchr>
 28b:	83 c4 10             	add    $0x10,%esp
 28e:	85 c0                	test   %eax,%eax
 290:	89 c6                	mov    %eax,%esi
 292:	74 44                	je     2d8 <grep+0xa8>
      if(match(pattern, p)){
 294:	83 ec 08             	sub    $0x8,%esp
      *q = 0;
 297:	c6 06 00             	movb   $0x0,(%esi)
 29a:	8d 7e 01             	lea    0x1(%esi),%edi
      if(match(pattern, p)){
 29d:	53                   	push   %ebx
 29e:	ff 75 08             	pushl  0x8(%ebp)
 2a1:	e8 2a ff ff ff       	call   1d0 <match>
 2a6:	83 c4 10             	add    $0x10,%esp
 2a9:	85 c0                	test   %eax,%eax
 2ab:	75 0b                	jne    2b8 <grep+0x88>
      p = q+1;
 2ad:	89 fb                	mov    %edi,%ebx
 2af:	eb cf                	jmp    280 <grep+0x50>
 2b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        write(1, p, q+1 - p);
 2b8:	89 f8                	mov    %edi,%eax
 2ba:	83 ec 04             	sub    $0x4,%esp
        *q = '\n';
 2bd:	c6 06 0a             	movb   $0xa,(%esi)
        write(1, p, q+1 - p);
 2c0:	29 d8                	sub    %ebx,%eax
 2c2:	50                   	push   %eax
 2c3:	53                   	push   %ebx
      p = q+1;
 2c4:	89 fb                	mov    %edi,%ebx
        write(1, p, q+1 - p);
 2c6:	6a 01                	push   $0x1
 2c8:	e8 dd 02 00 00       	call   5aa <write>
 2cd:	83 c4 10             	add    $0x10,%esp
 2d0:	eb ae                	jmp    280 <grep+0x50>
 2d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p == buf)
 2d8:	81 fb 00 0f 00 00    	cmp    $0xf00,%ebx
 2de:	8b 75 e4             	mov    -0x1c(%ebp),%esi
 2e1:	74 2d                	je     310 <grep+0xe0>
    if(m > 0){
 2e3:	85 f6                	test   %esi,%esi
 2e5:	0f 8e 55 ff ff ff    	jle    240 <grep+0x10>
      m -= p - buf;
 2eb:	89 d8                	mov    %ebx,%eax
      memmove(buf, p, m);
 2ed:	83 ec 04             	sub    $0x4,%esp
      m -= p - buf;
 2f0:	2d 00 0f 00 00       	sub    $0xf00,%eax
 2f5:	29 c6                	sub    %eax,%esi
      memmove(buf, p, m);
 2f7:	56                   	push   %esi
 2f8:	53                   	push   %ebx
 2f9:	68 00 0f 00 00       	push   $0xf00
 2fe:	e8 4d 02 00 00       	call   550 <memmove>
 303:	83 c4 10             	add    $0x10,%esp
 306:	e9 35 ff ff ff       	jmp    240 <grep+0x10>
 30b:	90                   	nop
 30c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m = 0;
 310:	31 f6                	xor    %esi,%esi
 312:	e9 29 ff ff ff       	jmp    240 <grep+0x10>
 317:	89 f6                	mov    %esi,%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
 320:	8d 65 f4             	lea    -0xc(%ebp),%esp
 323:	5b                   	pop    %ebx
 324:	5e                   	pop    %esi
 325:	5f                   	pop    %edi
 326:	5d                   	pop    %ebp
 327:	c3                   	ret    
 328:	66 90                	xchg   %ax,%ax
 32a:	66 90                	xchg   %ax,%ax
 32c:	66 90                	xchg   %ax,%ax
 32e:	66 90                	xchg   %ax,%ax

00000330 <strcpy>:
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	53                   	push   %ebx
 334:	8b 45 08             	mov    0x8(%ebp),%eax
 337:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 33a:	89 c2                	mov    %eax,%edx
 33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 340:	83 c1 01             	add    $0x1,%ecx
 343:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 347:	83 c2 01             	add    $0x1,%edx
 34a:	84 db                	test   %bl,%bl
 34c:	88 5a ff             	mov    %bl,-0x1(%edx)
 34f:	75 ef                	jne    340 <strcpy+0x10>
    ;
  return os;
}
 351:	5b                   	pop    %ebx
 352:	5d                   	pop    %ebp
 353:	c3                   	ret    
 354:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 35a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000360 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	53                   	push   %ebx
 364:	8b 55 08             	mov    0x8(%ebp),%edx
 367:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 36a:	0f b6 02             	movzbl (%edx),%eax
 36d:	0f b6 19             	movzbl (%ecx),%ebx
 370:	84 c0                	test   %al,%al
 372:	75 1c                	jne    390 <strcmp+0x30>
 374:	eb 2a                	jmp    3a0 <strcmp+0x40>
 376:	8d 76 00             	lea    0x0(%esi),%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 380:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 383:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 386:	83 c1 01             	add    $0x1,%ecx
 389:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 38c:	84 c0                	test   %al,%al
 38e:	74 10                	je     3a0 <strcmp+0x40>
 390:	38 d8                	cmp    %bl,%al
 392:	74 ec                	je     380 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 394:	29 d8                	sub    %ebx,%eax
}
 396:	5b                   	pop    %ebx
 397:	5d                   	pop    %ebp
 398:	c3                   	ret    
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3a0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 3a2:	29 d8                	sub    %ebx,%eax
}
 3a4:	5b                   	pop    %ebx
 3a5:	5d                   	pop    %ebp
 3a6:	c3                   	ret    
 3a7:	89 f6                	mov    %esi,%esi
 3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003b0 <strlen>:

uint
strlen(const char *s)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3b6:	80 39 00             	cmpb   $0x0,(%ecx)
 3b9:	74 15                	je     3d0 <strlen+0x20>
 3bb:	31 d2                	xor    %edx,%edx
 3bd:	8d 76 00             	lea    0x0(%esi),%esi
 3c0:	83 c2 01             	add    $0x1,%edx
 3c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3c7:	89 d0                	mov    %edx,%eax
 3c9:	75 f5                	jne    3c0 <strlen+0x10>
    ;
  return n;
}
 3cb:	5d                   	pop    %ebp
 3cc:	c3                   	ret    
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 3d0:	31 c0                	xor    %eax,%eax
}
 3d2:	5d                   	pop    %ebp
 3d3:	c3                   	ret    
 3d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ed:	89 d7                	mov    %edx,%edi
 3ef:	fc                   	cld    
 3f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3f2:	89 d0                	mov    %edx,%eax
 3f4:	5f                   	pop    %edi
 3f5:	5d                   	pop    %ebp
 3f6:	c3                   	ret    
 3f7:	89 f6                	mov    %esi,%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <strchr>:

char*
strchr(const char *s, char c)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	53                   	push   %ebx
 404:	8b 45 08             	mov    0x8(%ebp),%eax
 407:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 40a:	0f b6 10             	movzbl (%eax),%edx
 40d:	84 d2                	test   %dl,%dl
 40f:	74 1d                	je     42e <strchr+0x2e>
    if(*s == c)
 411:	38 d3                	cmp    %dl,%bl
 413:	89 d9                	mov    %ebx,%ecx
 415:	75 0d                	jne    424 <strchr+0x24>
 417:	eb 17                	jmp    430 <strchr+0x30>
 419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 420:	38 ca                	cmp    %cl,%dl
 422:	74 0c                	je     430 <strchr+0x30>
  for(; *s; s++)
 424:	83 c0 01             	add    $0x1,%eax
 427:	0f b6 10             	movzbl (%eax),%edx
 42a:	84 d2                	test   %dl,%dl
 42c:	75 f2                	jne    420 <strchr+0x20>
      return (char*)s;
  return 0;
 42e:	31 c0                	xor    %eax,%eax
}
 430:	5b                   	pop    %ebx
 431:	5d                   	pop    %ebp
 432:	c3                   	ret    
 433:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000440 <gets>:

char*
gets(char *buf, int max)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 446:	31 f6                	xor    %esi,%esi
 448:	89 f3                	mov    %esi,%ebx
{
 44a:	83 ec 1c             	sub    $0x1c,%esp
 44d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 450:	eb 2f                	jmp    481 <gets+0x41>
 452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 458:	8d 45 e7             	lea    -0x19(%ebp),%eax
 45b:	83 ec 04             	sub    $0x4,%esp
 45e:	6a 01                	push   $0x1
 460:	50                   	push   %eax
 461:	6a 00                	push   $0x0
 463:	e8 32 01 00 00       	call   59a <read>
    if(cc < 1)
 468:	83 c4 10             	add    $0x10,%esp
 46b:	85 c0                	test   %eax,%eax
 46d:	7e 1c                	jle    48b <gets+0x4b>
      break;
    buf[i++] = c;
 46f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 473:	83 c7 01             	add    $0x1,%edi
 476:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 479:	3c 0a                	cmp    $0xa,%al
 47b:	74 23                	je     4a0 <gets+0x60>
 47d:	3c 0d                	cmp    $0xd,%al
 47f:	74 1f                	je     4a0 <gets+0x60>
  for(i=0; i+1 < max; ){
 481:	83 c3 01             	add    $0x1,%ebx
 484:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 487:	89 fe                	mov    %edi,%esi
 489:	7c cd                	jl     458 <gets+0x18>
 48b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 48d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 490:	c6 03 00             	movb   $0x0,(%ebx)
}
 493:	8d 65 f4             	lea    -0xc(%ebp),%esp
 496:	5b                   	pop    %ebx
 497:	5e                   	pop    %esi
 498:	5f                   	pop    %edi
 499:	5d                   	pop    %ebp
 49a:	c3                   	ret    
 49b:	90                   	nop
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4a0:	8b 75 08             	mov    0x8(%ebp),%esi
 4a3:	8b 45 08             	mov    0x8(%ebp),%eax
 4a6:	01 de                	add    %ebx,%esi
 4a8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 4aa:	c6 03 00             	movb   $0x0,(%ebx)
}
 4ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4b0:	5b                   	pop    %ebx
 4b1:	5e                   	pop    %esi
 4b2:	5f                   	pop    %edi
 4b3:	5d                   	pop    %ebp
 4b4:	c3                   	ret    
 4b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004c0 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	56                   	push   %esi
 4c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4c5:	83 ec 08             	sub    $0x8,%esp
 4c8:	6a 00                	push   $0x0
 4ca:	ff 75 08             	pushl  0x8(%ebp)
 4cd:	e8 f8 00 00 00       	call   5ca <open>
  if(fd < 0)
 4d2:	83 c4 10             	add    $0x10,%esp
 4d5:	85 c0                	test   %eax,%eax
 4d7:	78 27                	js     500 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 4d9:	83 ec 08             	sub    $0x8,%esp
 4dc:	ff 75 0c             	pushl  0xc(%ebp)
 4df:	89 c3                	mov    %eax,%ebx
 4e1:	50                   	push   %eax
 4e2:	e8 fb 00 00 00       	call   5e2 <fstat>
  close(fd);
 4e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 4ea:	89 c6                	mov    %eax,%esi
  close(fd);
 4ec:	e8 c1 00 00 00       	call   5b2 <close>
  return r;
 4f1:	83 c4 10             	add    $0x10,%esp
}
 4f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4f7:	89 f0                	mov    %esi,%eax
 4f9:	5b                   	pop    %ebx
 4fa:	5e                   	pop    %esi
 4fb:	5d                   	pop    %ebp
 4fc:	c3                   	ret    
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 500:	be ff ff ff ff       	mov    $0xffffffff,%esi
 505:	eb ed                	jmp    4f4 <stat+0x34>
 507:	89 f6                	mov    %esi,%esi
 509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000510 <atoi>:

int
atoi(const char *s)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	53                   	push   %ebx
 514:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 517:	0f be 11             	movsbl (%ecx),%edx
 51a:	8d 42 d0             	lea    -0x30(%edx),%eax
 51d:	3c 09                	cmp    $0x9,%al
  n = 0;
 51f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 524:	77 1f                	ja     545 <atoi+0x35>
 526:	8d 76 00             	lea    0x0(%esi),%esi
 529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 530:	8d 04 80             	lea    (%eax,%eax,4),%eax
 533:	83 c1 01             	add    $0x1,%ecx
 536:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 53a:	0f be 11             	movsbl (%ecx),%edx
 53d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 540:	80 fb 09             	cmp    $0x9,%bl
 543:	76 eb                	jbe    530 <atoi+0x20>
  return n;
}
 545:	5b                   	pop    %ebx
 546:	5d                   	pop    %ebp
 547:	c3                   	ret    
 548:	90                   	nop
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000550 <memmove>:


void*
memmove(void *vdst, const void *vsrc, int n)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	56                   	push   %esi
 554:	53                   	push   %ebx
 555:	8b 5d 10             	mov    0x10(%ebp),%ebx
 558:	8b 45 08             	mov    0x8(%ebp),%eax
 55b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 55e:	85 db                	test   %ebx,%ebx
 560:	7e 14                	jle    576 <memmove+0x26>
 562:	31 d2                	xor    %edx,%edx
 564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 568:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 56c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 56f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 572:	39 d3                	cmp    %edx,%ebx
 574:	75 f2                	jne    568 <memmove+0x18>
  return vdst;
}
 576:	5b                   	pop    %ebx
 577:	5e                   	pop    %esi
 578:	5d                   	pop    %ebp
 579:	c3                   	ret    

0000057a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 57a:	b8 01 00 00 00       	mov    $0x1,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <exit>:
SYSCALL(exit)
 582:	b8 02 00 00 00       	mov    $0x2,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <wait>:
SYSCALL(wait)
 58a:	b8 03 00 00 00       	mov    $0x3,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <pipe>:
SYSCALL(pipe)
 592:	b8 04 00 00 00       	mov    $0x4,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <read>:
SYSCALL(read)
 59a:	b8 05 00 00 00       	mov    $0x5,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <steal>:
SYSCALL(steal)
 5a2:	b8 17 00 00 00       	mov    $0x17,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <write>:
SYSCALL(write)
 5aa:	b8 10 00 00 00       	mov    $0x10,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <close>:
SYSCALL(close)
 5b2:	b8 15 00 00 00       	mov    $0x15,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <kill>:
SYSCALL(kill)
 5ba:	b8 06 00 00 00       	mov    $0x6,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <exec>:
SYSCALL(exec)
 5c2:	b8 07 00 00 00       	mov    $0x7,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <open>:
SYSCALL(open)
 5ca:	b8 0f 00 00 00       	mov    $0xf,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    

000005d2 <mknod>:
SYSCALL(mknod)
 5d2:	b8 11 00 00 00       	mov    $0x11,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret    

000005da <unlink>:
SYSCALL(unlink)
 5da:	b8 12 00 00 00       	mov    $0x12,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    

000005e2 <fstat>:
SYSCALL(fstat)
 5e2:	b8 08 00 00 00       	mov    $0x8,%eax
 5e7:	cd 40                	int    $0x40
 5e9:	c3                   	ret    

000005ea <link>:
SYSCALL(link)
 5ea:	b8 13 00 00 00       	mov    $0x13,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret    

000005f2 <mkdir>:
SYSCALL(mkdir)
 5f2:	b8 14 00 00 00       	mov    $0x14,%eax
 5f7:	cd 40                	int    $0x40
 5f9:	c3                   	ret    

000005fa <chdir>:
SYSCALL(chdir)
 5fa:	b8 09 00 00 00       	mov    $0x9,%eax
 5ff:	cd 40                	int    $0x40
 601:	c3                   	ret    

00000602 <dup>:
SYSCALL(dup)
 602:	b8 0a 00 00 00       	mov    $0xa,%eax
 607:	cd 40                	int    $0x40
 609:	c3                   	ret    

0000060a <getpid>:
SYSCALL(getpid)
 60a:	b8 0b 00 00 00       	mov    $0xb,%eax
 60f:	cd 40                	int    $0x40
 611:	c3                   	ret    

00000612 <sbrk>:
SYSCALL(sbrk)
 612:	b8 0c 00 00 00       	mov    $0xc,%eax
 617:	cd 40                	int    $0x40
 619:	c3                   	ret    

0000061a <sleep>:
SYSCALL(sleep)
 61a:	b8 0d 00 00 00       	mov    $0xd,%eax
 61f:	cd 40                	int    $0x40
 621:	c3                   	ret    

00000622 <uptime>:
SYSCALL(uptime)
 622:	b8 0e 00 00 00       	mov    $0xe,%eax
 627:	cd 40                	int    $0x40
 629:	c3                   	ret    

0000062a <cpuhalt>:
SYSCALL(cpuhalt)
 62a:	b8 16 00 00 00       	mov    $0x16,%eax
 62f:	cd 40                	int    $0x40
 631:	c3                   	ret    
 632:	66 90                	xchg   %ax,%ax
 634:	66 90                	xchg   %ax,%ax
 636:	66 90                	xchg   %ax,%ax
 638:	66 90                	xchg   %ax,%ax
 63a:	66 90                	xchg   %ax,%ax
 63c:	66 90                	xchg   %ax,%ax
 63e:	66 90                	xchg   %ax,%ax

00000640 <printint.constprop.1>:
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
}

static void
printint(int fd, int xx, int base, int sgn)
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	56                   	push   %esi
 645:	53                   	push   %ebx
 646:	89 d6                	mov    %edx,%esi
 648:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 64b:	85 c0                	test   %eax,%eax
 64d:	79 71                	jns    6c0 <printint.constprop.1+0x80>
 64f:	83 e1 01             	and    $0x1,%ecx
 652:	74 6c                	je     6c0 <printint.constprop.1+0x80>
    neg = 1;
    x = -xx;
 654:	f7 d8                	neg    %eax
    neg = 1;
 656:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 65d:	31 c9                	xor    %ecx,%ecx
 65f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 662:	eb 06                	jmp    66a <printint.constprop.1+0x2a>
 664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 668:	89 f9                	mov    %edi,%ecx
 66a:	31 d2                	xor    %edx,%edx
 66c:	8d 79 01             	lea    0x1(%ecx),%edi
 66f:	f7 f6                	div    %esi
 671:	0f b6 92 08 0b 00 00 	movzbl 0xb08(%edx),%edx
  }while((x /= base) != 0);
 678:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 67a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 67d:	75 e9                	jne    668 <printint.constprop.1+0x28>
  if(neg)
 67f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 682:	85 c0                	test   %eax,%eax
 684:	74 08                	je     68e <printint.constprop.1+0x4e>
    buf[i++] = '-';
 686:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 68b:	8d 79 02             	lea    0x2(%ecx),%edi
 68e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 698:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 69b:	83 ec 04             	sub    $0x4,%esp
 69e:	83 ee 01             	sub    $0x1,%esi
 6a1:	6a 01                	push   $0x1
 6a3:	53                   	push   %ebx
 6a4:	6a 01                	push   $0x1
 6a6:	88 45 d7             	mov    %al,-0x29(%ebp)
 6a9:	e8 fc fe ff ff       	call   5aa <write>

  while(--i >= 0)
 6ae:	83 c4 10             	add    $0x10,%esp
 6b1:	39 de                	cmp    %ebx,%esi
 6b3:	75 e3                	jne    698 <printint.constprop.1+0x58>
    putc(fd, buf[i]);
}
 6b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6b8:	5b                   	pop    %ebx
 6b9:	5e                   	pop    %esi
 6ba:	5f                   	pop    %edi
 6bb:	5d                   	pop    %ebp
 6bc:	c3                   	ret    
 6bd:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 6c0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 6c7:	eb 94                	jmp    65d <printint.constprop.1+0x1d>
 6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006d0 <vprintf.constprop.0>:
static void vprintf(int fd, const char *fmt, va_list ap)
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	57                   	push   %edi
 6d4:	56                   	push   %esi
 6d5:	53                   	push   %ebx
 6d6:	89 d6                	mov    %edx,%esi
 6d8:	83 ec 2c             	sub    $0x2c,%esp
{
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6db:	0f b6 10             	movzbl (%eax),%edx
 6de:	84 d2                	test   %dl,%dl
 6e0:	0f 84 cd 00 00 00    	je     7b3 <vprintf.constprop.0+0xe3>
 6e6:	8d 58 01             	lea    0x1(%eax),%ebx
  state = 0;
 6e9:	31 ff                	xor    %edi,%edi
 6eb:	eb 31                	jmp    71e <vprintf.constprop.0+0x4e>
 6ed:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6f0:	83 f8 25             	cmp    $0x25,%eax
 6f3:	0f 84 c7 00 00 00    	je     7c0 <vprintf.constprop.0+0xf0>
  write(fd, &c, 1);
 6f9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6fc:	83 ec 04             	sub    $0x4,%esp
 6ff:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 702:	6a 01                	push   $0x1
 704:	50                   	push   %eax
 705:	6a 01                	push   $0x1
 707:	e8 9e fe ff ff       	call   5aa <write>
 70c:	83 c4 10             	add    $0x10,%esp
 70f:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 712:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 716:	84 d2                	test   %dl,%dl
 718:	0f 84 95 00 00 00    	je     7b3 <vprintf.constprop.0+0xe3>
    if(state == 0){
 71e:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 720:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 723:	74 cb                	je     6f0 <vprintf.constprop.0+0x20>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 725:	83 ff 25             	cmp    $0x25,%edi
 728:	75 e5                	jne    70f <vprintf.constprop.0+0x3f>
      if(c == 'd'){
 72a:	83 f8 64             	cmp    $0x64,%eax
        printint(fd, va_arg(ap, int), 10, 1);
 72d:	8d 7e 04             	lea    0x4(%esi),%edi
 730:	b9 01 00 00 00       	mov    $0x1,%ecx
      if(c == 'd'){
 735:	0f 84 9a 00 00 00    	je     7d5 <vprintf.constprop.0+0x105>
      } else if(c == 'l') {
 73b:	83 f8 6c             	cmp    $0x6c,%eax
 73e:	0f 84 8c 00 00 00    	je     7d0 <vprintf.constprop.0+0x100>
        printint(fd, va_arg(ap, uint), 10, 0);
      } else if(c == 'x') {
 744:	83 f8 78             	cmp    $0x78,%eax
 747:	0f 84 a3 00 00 00    	je     7f0 <vprintf.constprop.0+0x120>
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 74d:	83 f8 70             	cmp    $0x70,%eax
 750:	0f 84 ca 00 00 00    	je     820 <vprintf.constprop.0+0x150>
        printptr(fd, va_arg(ap, uint));
      } else if(c == 's'){
 756:	83 f8 73             	cmp    $0x73,%eax
 759:	0f 84 39 01 00 00    	je     898 <vprintf.constprop.0+0x1c8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 75f:	83 f8 63             	cmp    $0x63,%eax
 762:	0f 84 68 01 00 00    	je     8d0 <vprintf.constprop.0+0x200>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 768:	83 f8 25             	cmp    $0x25,%eax
 76b:	0f 84 9f 00 00 00    	je     810 <vprintf.constprop.0+0x140>
  write(fd, &c, 1);
 771:	8d 45 df             	lea    -0x21(%ebp),%eax
 774:	83 ec 04             	sub    $0x4,%esp
 777:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 77a:	6a 01                	push   $0x1
 77c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 780:	50                   	push   %eax
 781:	6a 01                	push   $0x1
 783:	e8 22 fe ff ff       	call   5aa <write>
 788:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 78c:	83 c4 0c             	add    $0xc,%esp
 78f:	8d 45 e0             	lea    -0x20(%ebp),%eax
 792:	6a 01                	push   $0x1
 794:	88 55 e0             	mov    %dl,-0x20(%ebp)
 797:	50                   	push   %eax
 798:	6a 01                	push   $0x1
 79a:	83 c3 01             	add    $0x1,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 79d:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 79f:	e8 06 fe ff ff       	call   5aa <write>
  for(i = 0; fmt[i]; i++){
 7a4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
  write(fd, &c, 1);
 7a8:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 7ab:	84 d2                	test   %dl,%dl
 7ad:	0f 85 6b ff ff ff    	jne    71e <vprintf.constprop.0+0x4e>
    }
  }
}
 7b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7b6:	5b                   	pop    %ebx
 7b7:	5e                   	pop    %esi
 7b8:	5f                   	pop    %edi
 7b9:	5d                   	pop    %ebp
 7ba:	c3                   	ret    
 7bb:	90                   	nop
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        state = '%';
 7c0:	bf 25 00 00 00       	mov    $0x25,%edi
 7c5:	e9 45 ff ff ff       	jmp    70f <vprintf.constprop.0+0x3f>
 7ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, uint), 10, 0);
 7d0:	8d 7e 04             	lea    0x4(%esi),%edi
 7d3:	31 c9                	xor    %ecx,%ecx
 7d5:	8b 06                	mov    (%esi),%eax
 7d7:	ba 0a 00 00 00       	mov    $0xa,%edx
 7dc:	89 fe                	mov    %edi,%esi
      state = 0;
 7de:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, uint), 10, 0);
 7e0:	e8 5b fe ff ff       	call   640 <printint.constprop.1>
 7e5:	e9 25 ff ff ff       	jmp    70f <vprintf.constprop.0+0x3f>
 7ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, int), 16, 0);
 7f0:	8b 06                	mov    (%esi),%eax
 7f2:	8d 7e 04             	lea    0x4(%esi),%edi
 7f5:	31 c9                	xor    %ecx,%ecx
 7f7:	ba 10 00 00 00       	mov    $0x10,%edx
 7fc:	89 fe                	mov    %edi,%esi
      state = 0;
 7fe:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, int), 16, 0);
 800:	e8 3b fe ff ff       	call   640 <printint.constprop.1>
 805:	e9 05 ff ff ff       	jmp    70f <vprintf.constprop.0+0x3f>
 80a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 810:	83 ec 04             	sub    $0x4,%esp
 813:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 816:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 819:	6a 01                	push   $0x1
 81b:	e9 77 ff ff ff       	jmp    797 <vprintf.constprop.0+0xc7>
        printptr(fd, va_arg(ap, uint));
 820:	8d 46 04             	lea    0x4(%esi),%eax
  write(fd, &c, 1);
 823:	83 ec 04             	sub    $0x4,%esp
        printptr(fd, va_arg(ap, uint));
 826:	8b 3e                	mov    (%esi),%edi
  write(fd, &c, 1);
 828:	6a 01                	push   $0x1
 82a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 82e:	be 08 00 00 00       	mov    $0x8,%esi
        printptr(fd, va_arg(ap, uint));
 833:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 836:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 839:	50                   	push   %eax
 83a:	6a 01                	push   $0x1
 83c:	e8 69 fd ff ff       	call   5aa <write>
 841:	8d 45 e7             	lea    -0x19(%ebp),%eax
 844:	83 c4 0c             	add    $0xc,%esp
 847:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 84b:	6a 01                	push   $0x1
 84d:	50                   	push   %eax
 84e:	6a 01                	push   $0x1
 850:	e8 55 fd ff ff       	call   5aa <write>
 855:	83 c4 10             	add    $0x10,%esp
 858:	90                   	nop
 859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
 860:	89 f8                	mov    %edi,%eax
  write(fd, &c, 1);
 862:	83 ec 04             	sub    $0x4,%esp
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
 865:	c1 e7 04             	shl    $0x4,%edi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
 868:	c1 e8 1c             	shr    $0x1c,%eax
  write(fd, &c, 1);
 86b:	6a 01                	push   $0x1
 86d:	0f b6 80 08 0b 00 00 	movzbl 0xb08(%eax),%eax
 874:	88 45 e5             	mov    %al,-0x1b(%ebp)
 877:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 87a:	50                   	push   %eax
 87b:	6a 01                	push   $0x1
 87d:	e8 28 fd ff ff       	call   5aa <write>
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
 882:	83 c4 10             	add    $0x10,%esp
 885:	83 ee 01             	sub    $0x1,%esi
 888:	75 d6                	jne    860 <vprintf.constprop.0+0x190>
        s = va_arg(ap, char*);
 88a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 88d:	31 ff                	xor    %edi,%edi
 88f:	e9 7b fe ff ff       	jmp    70f <vprintf.constprop.0+0x3f>
 894:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = va_arg(ap, char*);
 898:	8b 3e                	mov    (%esi),%edi
 89a:	8d 46 04             	lea    0x4(%esi),%eax
 89d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 8a0:	85 ff                	test   %edi,%edi
 8a2:	74 50                	je     8f4 <vprintf.constprop.0+0x224>
        while(*s != 0){
 8a4:	0f b6 07             	movzbl (%edi),%eax
 8a7:	84 c0                	test   %al,%al
 8a9:	74 df                	je     88a <vprintf.constprop.0+0x1ba>
 8ab:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 8ae:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 8b0:	83 ec 04             	sub    $0x4,%esp
          s++;
 8b3:	83 c7 01             	add    $0x1,%edi
 8b6:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 8b9:	6a 01                	push   $0x1
 8bb:	56                   	push   %esi
 8bc:	6a 01                	push   $0x1
 8be:	e8 e7 fc ff ff       	call   5aa <write>
        while(*s != 0){
 8c3:	0f b6 07             	movzbl (%edi),%eax
 8c6:	83 c4 10             	add    $0x10,%esp
 8c9:	84 c0                	test   %al,%al
 8cb:	75 e3                	jne    8b0 <vprintf.constprop.0+0x1e0>
 8cd:	eb bb                	jmp    88a <vprintf.constprop.0+0x1ba>
 8cf:	90                   	nop
        putc(fd, va_arg(ap, uint));
 8d0:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 8d2:	83 ec 04             	sub    $0x4,%esp
        putc(fd, va_arg(ap, uint));
 8d5:	8d 7e 04             	lea    0x4(%esi),%edi
  write(fd, &c, 1);
 8d8:	6a 01                	push   $0x1
        putc(fd, va_arg(ap, uint));
 8da:	89 fe                	mov    %edi,%esi
      state = 0;
 8dc:	31 ff                	xor    %edi,%edi
        putc(fd, va_arg(ap, uint));
 8de:	88 45 e2             	mov    %al,-0x1e(%ebp)
  write(fd, &c, 1);
 8e1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 8e4:	50                   	push   %eax
 8e5:	6a 01                	push   $0x1
 8e7:	e8 be fc ff ff       	call   5aa <write>
 8ec:	83 c4 10             	add    $0x10,%esp
 8ef:	e9 1b fe ff ff       	jmp    70f <vprintf.constprop.0+0x3f>
          s = "(null)";
 8f4:	bf fe 0a 00 00       	mov    $0xafe,%edi
        while(*s != 0){
 8f9:	b8 28 00 00 00       	mov    $0x28,%eax
 8fe:	eb ab                	jmp    8ab <vprintf.constprop.0+0x1db>

00000900 <fprintf>:
// Print to the given fd. Only understands %d,%x, %p, %s, %c.
void
fprintf(int fd, const char *fmt, ...)
{
 900:	55                   	push   %ebp
 901:	89 e5                	mov    %esp,%ebp
 903:	83 ec 08             	sub    $0x8,%esp
 va_list ap;
 va_start(ap, fmt); 
 vprintf(1,fmt,ap);
 906:	8b 45 0c             	mov    0xc(%ebp),%eax
 909:	8d 55 10             	lea    0x10(%ebp),%edx
 90c:	e8 bf fd ff ff       	call   6d0 <vprintf.constprop.0>
}
 911:	c9                   	leave  
 912:	c3                   	ret    
 913:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000920 <printf>:
void
printf(const char *fmt, ...)
{
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	83 ec 08             	sub    $0x8,%esp
  va_list ap;
  va_start(ap, fmt); 
  vprintf(1,fmt,ap);
 926:	8b 45 08             	mov    0x8(%ebp),%eax
 929:	8d 55 0c             	lea    0xc(%ebp),%edx
 92c:	e8 9f fd ff ff       	call   6d0 <vprintf.constprop.0>
}
 931:	c9                   	leave  
 932:	c3                   	ret    
 933:	66 90                	xchg   %ax,%ax
 935:	66 90                	xchg   %ax,%ax
 937:	66 90                	xchg   %ax,%ax
 939:	66 90                	xchg   %ax,%ax
 93b:	66 90                	xchg   %ax,%ax
 93d:	66 90                	xchg   %ax,%ax
 93f:	90                   	nop

00000940 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 940:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 941:	a1 e0 0e 00 00       	mov    0xee0,%eax
{
 946:	89 e5                	mov    %esp,%ebp
 948:	57                   	push   %edi
 949:	56                   	push   %esi
 94a:	53                   	push   %ebx
 94b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 94e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 958:	39 c8                	cmp    %ecx,%eax
 95a:	8b 10                	mov    (%eax),%edx
 95c:	73 32                	jae    990 <free+0x50>
 95e:	39 d1                	cmp    %edx,%ecx
 960:	72 04                	jb     966 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 962:	39 d0                	cmp    %edx,%eax
 964:	72 32                	jb     998 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 966:	8b 73 fc             	mov    -0x4(%ebx),%esi
 969:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 96c:	39 fa                	cmp    %edi,%edx
 96e:	74 30                	je     9a0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 970:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 973:	8b 50 04             	mov    0x4(%eax),%edx
 976:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 979:	39 f1                	cmp    %esi,%ecx
 97b:	74 3a                	je     9b7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 97d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 97f:	a3 e0 0e 00 00       	mov    %eax,0xee0
}
 984:	5b                   	pop    %ebx
 985:	5e                   	pop    %esi
 986:	5f                   	pop    %edi
 987:	5d                   	pop    %ebp
 988:	c3                   	ret    
 989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 990:	39 d0                	cmp    %edx,%eax
 992:	72 04                	jb     998 <free+0x58>
 994:	39 d1                	cmp    %edx,%ecx
 996:	72 ce                	jb     966 <free+0x26>
{
 998:	89 d0                	mov    %edx,%eax
 99a:	eb bc                	jmp    958 <free+0x18>
 99c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 9a0:	03 72 04             	add    0x4(%edx),%esi
 9a3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 9a6:	8b 10                	mov    (%eax),%edx
 9a8:	8b 12                	mov    (%edx),%edx
 9aa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 9ad:	8b 50 04             	mov    0x4(%eax),%edx
 9b0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9b3:	39 f1                	cmp    %esi,%ecx
 9b5:	75 c6                	jne    97d <free+0x3d>
    p->s.size += bp->s.size;
 9b7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 9ba:	a3 e0 0e 00 00       	mov    %eax,0xee0
    p->s.size += bp->s.size;
 9bf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9c2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 9c5:	89 10                	mov    %edx,(%eax)
}
 9c7:	5b                   	pop    %ebx
 9c8:	5e                   	pop    %esi
 9c9:	5f                   	pop    %edi
 9ca:	5d                   	pop    %ebp
 9cb:	c3                   	ret    
 9cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000009d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9d0:	55                   	push   %ebp
 9d1:	89 e5                	mov    %esp,%ebp
 9d3:	57                   	push   %edi
 9d4:	56                   	push   %esi
 9d5:	53                   	push   %ebx
 9d6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9dc:	8b 15 e0 0e 00 00    	mov    0xee0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9e2:	8d 78 07             	lea    0x7(%eax),%edi
 9e5:	c1 ef 03             	shr    $0x3,%edi
 9e8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 9eb:	85 d2                	test   %edx,%edx
 9ed:	0f 84 9d 00 00 00    	je     a90 <malloc+0xc0>
 9f3:	8b 02                	mov    (%edx),%eax
 9f5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 9f8:	39 cf                	cmp    %ecx,%edi
 9fa:	76 6c                	jbe    a68 <malloc+0x98>
 9fc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 a02:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a07:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 a0a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 a11:	eb 0e                	jmp    a21 <malloc+0x51>
 a13:	90                   	nop
 a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a18:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a1a:	8b 48 04             	mov    0x4(%eax),%ecx
 a1d:	39 f9                	cmp    %edi,%ecx
 a1f:	73 47                	jae    a68 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a21:	39 05 e0 0e 00 00    	cmp    %eax,0xee0
 a27:	89 c2                	mov    %eax,%edx
 a29:	75 ed                	jne    a18 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 a2b:	83 ec 0c             	sub    $0xc,%esp
 a2e:	56                   	push   %esi
 a2f:	e8 de fb ff ff       	call   612 <sbrk>
  if(p == (char*)-1)
 a34:	83 c4 10             	add    $0x10,%esp
 a37:	83 f8 ff             	cmp    $0xffffffff,%eax
 a3a:	74 1c                	je     a58 <malloc+0x88>
  hp->s.size = nu;
 a3c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a3f:	83 ec 0c             	sub    $0xc,%esp
 a42:	83 c0 08             	add    $0x8,%eax
 a45:	50                   	push   %eax
 a46:	e8 f5 fe ff ff       	call   940 <free>
  return freep;
 a4b:	8b 15 e0 0e 00 00    	mov    0xee0,%edx
      if((p = morecore(nunits)) == 0)
 a51:	83 c4 10             	add    $0x10,%esp
 a54:	85 d2                	test   %edx,%edx
 a56:	75 c0                	jne    a18 <malloc+0x48>
        return 0;
  }
}
 a58:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 a5b:	31 c0                	xor    %eax,%eax
}
 a5d:	5b                   	pop    %ebx
 a5e:	5e                   	pop    %esi
 a5f:	5f                   	pop    %edi
 a60:	5d                   	pop    %ebp
 a61:	c3                   	ret    
 a62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 a68:	39 cf                	cmp    %ecx,%edi
 a6a:	74 54                	je     ac0 <malloc+0xf0>
        p->s.size -= nunits;
 a6c:	29 f9                	sub    %edi,%ecx
 a6e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 a71:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a74:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 a77:	89 15 e0 0e 00 00    	mov    %edx,0xee0
}
 a7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 a80:	83 c0 08             	add    $0x8,%eax
}
 a83:	5b                   	pop    %ebx
 a84:	5e                   	pop    %esi
 a85:	5f                   	pop    %edi
 a86:	5d                   	pop    %ebp
 a87:	c3                   	ret    
 a88:	90                   	nop
 a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 a90:	c7 05 e0 0e 00 00 e4 	movl   $0xee4,0xee0
 a97:	0e 00 00 
 a9a:	c7 05 e4 0e 00 00 e4 	movl   $0xee4,0xee4
 aa1:	0e 00 00 
    base.s.size = 0;
 aa4:	b8 e4 0e 00 00       	mov    $0xee4,%eax
 aa9:	c7 05 e8 0e 00 00 00 	movl   $0x0,0xee8
 ab0:	00 00 00 
 ab3:	e9 44 ff ff ff       	jmp    9fc <malloc+0x2c>
 ab8:	90                   	nop
 ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 ac0:	8b 08                	mov    (%eax),%ecx
 ac2:	89 0a                	mov    %ecx,(%edx)
 ac4:	eb b1                	jmp    a77 <malloc+0xa7>
