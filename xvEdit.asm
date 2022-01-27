
user/_xvEdit:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
void substr(char* dest, char* str, int start, int end);
void toUpper(char* str);
void toLower(char* str);
void unline(char* str);

int main(int argc, char* argv[]) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	81 ec e8 00 00 00    	sub    $0xe8,%esp
  17:	8b 01                	mov    (%ecx),%eax
  19:	8b 51 04             	mov    0x4(%ecx),%edx
  // arg czeching
  if (argc < 2) {
  1c:	83 f8 01             	cmp    $0x1,%eax
  1f:	7e 25                	jle    46 <main+0x46>
    fprintf(2, "specify a file you want to edit");
    return 0;
  } else if (argc > 2) {
  21:	83 f8 02             	cmp    $0x2,%eax
  24:	74 33                	je     59 <main+0x59>
    fprintf(2, "only specify one file");
  26:	83 ec 08             	sub    $0x8,%esp
  29:	68 86 0b 00 00       	push   $0xb86
  2e:	6a 02                	push   $0x2
  30:	e8 7b 09 00 00       	call   9b0 <fprintf>
    return 0;
  35:	83 c4 10             	add    $0x10,%esp
    }
  }
  close(file.fd);
  exit();
  return 0;
}
  38:	8d 65 f0             	lea    -0x10(%ebp),%esp
  3b:	31 c0                	xor    %eax,%eax
  3d:	59                   	pop    %ecx
  3e:	5b                   	pop    %ebx
  3f:	5e                   	pop    %esi
  40:	5f                   	pop    %edi
  41:	5d                   	pop    %ebp
  42:	8d 61 fc             	lea    -0x4(%ecx),%esp
  45:	c3                   	ret    
    fprintf(2, "specify a file you want to edit");
  46:	50                   	push   %eax
  47:	50                   	push   %eax
  48:	68 04 0c 00 00       	push   $0xc04
  4d:	6a 02                	push   $0x2
  4f:	e8 5c 09 00 00       	call   9b0 <fprintf>
    return 0;
  54:	83 c4 10             	add    $0x10,%esp
  57:	eb df                	jmp    38 <main+0x38>
  char cmdstr[100] = "";
  59:	8d bd 24 ff ff ff    	lea    -0xdc(%ebp),%edi
  5f:	31 c0                	xor    %eax,%eax
  61:	b9 18 00 00 00       	mov    $0x18,%ecx
  file.filename = argv[1];
  66:	8b 5a 04             	mov    0x4(%edx),%ebx
  char cmdstr[100] = "";
  69:	c7 85 20 ff ff ff 00 	movl   $0x0,-0xe0(%ebp)
  70:	00 00 00 
  73:	f3 ab                	rep stos %eax,%es:(%edi)
  char args[100] = "";
  75:	8d 7d 88             	lea    -0x78(%ebp),%edi
  78:	b9 18 00 00 00       	mov    $0x18,%ecx
  7d:	c7 45 84 00 00 00 00 	movl   $0x0,-0x7c(%ebp)
  84:	f3 ab                	rep stos %eax,%es:(%edi)
  fprintf(2, "Welcome to xvEdit!\n");
  86:	51                   	push   %ecx
  87:	51                   	push   %ecx
  88:	68 9c 0b 00 00       	push   $0xb9c
  8d:	6a 02                	push   $0x2
  8f:	e8 1c 09 00 00       	call   9b0 <fprintf>
  file.fd = open(file.filename, O_CREATE | O_WRONLY);
  94:	5e                   	pop    %esi
  95:	5f                   	pop    %edi
  96:	68 01 02 00 00       	push   $0x201
  9b:	53                   	push   %ebx
  9c:	8d b5 20 ff ff ff    	lea    -0xe0(%ebp),%esi
  a2:	8d 5d 84             	lea    -0x7c(%ebp),%ebx
  a5:	e8 d8 05 00 00       	call   682 <open>
  aa:	83 c4 10             	add    $0x10,%esp
  ad:	89 c7                	mov    %eax,%edi
    fprintf(2, "xvEdit> ");
  af:	51                   	push   %ecx
  b0:	51                   	push   %ecx
  b1:	68 b0 0b 00 00       	push   $0xbb0
  b6:	6a 02                	push   $0x2
  b8:	e8 f3 08 00 00       	call   9b0 <fprintf>
    memset(buf, 0, nbuf);
  bd:	83 c4 0c             	add    $0xc,%esp
  c0:	6a 64                	push   $0x64
  c2:	6a 00                	push   $0x0
  c4:	68 c0 10 00 00       	push   $0x10c0
  c9:	e8 d2 03 00 00       	call   4a0 <memset>
    gets(buf, nbuf);
  ce:	58                   	pop    %eax
  cf:	5a                   	pop    %edx
  d0:	6a 64                	push   $0x64
  d2:	68 c0 10 00 00       	push   $0x10c0
  d7:	e8 24 04 00 00       	call   500 <gets>
    unline(buf);
  dc:	c7 04 24 c0 10 00 00 	movl   $0x10c0,(%esp)
  e3:	e8 a8 02 00 00       	call   390 <unline>
    substr(cmdstr, buf, 0, 4);
  e8:	6a 04                	push   $0x4
  ea:	6a 00                	push   $0x0
  ec:	68 c0 10 00 00       	push   $0x10c0
  f1:	56                   	push   %esi
  f2:	e8 e9 01 00 00       	call   2e0 <substr>
  f7:	89 f2                	mov    %esi,%edx
  f9:	83 c4 20             	add    $0x20,%esp
  fc:	eb 10                	jmp    10e <main+0x10e>

void toUpper(char* str) {
  int i = 0;
  while (str[i] != '\0') {
    char c = str[i];
    if (c <= 'z' && c >= 'a')
  fe:	8d 48 9f             	lea    -0x61(%eax),%ecx
 101:	80 f9 19             	cmp    $0x19,%cl
 104:	77 05                	ja     10b <main+0x10b>
      str[i] += ('Z' - 'z');
 106:	83 e8 20             	sub    $0x20,%eax
 109:	88 02                	mov    %al,(%edx)
 10b:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
 10e:	0f b6 02             	movzbl (%edx),%eax
 111:	84 c0                	test   %al,%al
 113:	75 e9                	jne    fe <main+0xfe>
    fprintf(2, "cmdstr: %s\n", cmdstr);
 115:	50                   	push   %eax
 116:	56                   	push   %esi
 117:	68 b9 0b 00 00       	push   $0xbb9
 11c:	6a 02                	push   $0x2
 11e:	e8 8d 08 00 00       	call   9b0 <fprintf>
    fprintf(2, "strlen(cmdstr): %d\n", strlen(cmdstr));
 123:	89 34 24             	mov    %esi,(%esp)
 126:	e8 45 03 00 00       	call   470 <strlen>
 12b:	83 c4 0c             	add    $0xc,%esp
 12e:	50                   	push   %eax
 12f:	68 c5 0b 00 00       	push   $0xbc5
 134:	6a 02                	push   $0x2
 136:	e8 75 08 00 00       	call   9b0 <fprintf>
    substr(args, buf, strlen(cmdstr) + 1, strlen(buf));
 13b:	c7 04 24 c0 10 00 00 	movl   $0x10c0,(%esp)
 142:	e8 29 03 00 00       	call   470 <strlen>
 147:	89 34 24             	mov    %esi,(%esp)
 14a:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
 150:	e8 1b 03 00 00       	call   470 <strlen>
 155:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
 15b:	83 c0 01             	add    $0x1,%eax
 15e:	52                   	push   %edx
 15f:	50                   	push   %eax
 160:	68 c0 10 00 00       	push   $0x10c0
 165:	53                   	push   %ebx
 166:	e8 75 01 00 00       	call   2e0 <substr>
    fprintf(2, "args: %s\n", args);
 16b:	83 c4 1c             	add    $0x1c,%esp
 16e:	53                   	push   %ebx
 16f:	68 d9 0b 00 00       	push   $0xbd9
 174:	6a 02                	push   $0x2
 176:	e8 35 08 00 00       	call   9b0 <fprintf>
    if      (strcmp(cmdstr, "@END") == 0) {cmd = END;}
 17b:	58                   	pop    %eax
 17c:	5a                   	pop    %edx
 17d:	68 e3 0b 00 00       	push   $0xbe3
 182:	56                   	push   %esi
 183:	e8 98 02 00 00       	call   420 <strcmp>
 188:	83 c4 10             	add    $0x10,%esp
 18b:	85 c0                	test   %eax,%eax
 18d:	74 72                	je     201 <main+0x201>
    else if (strcmp(cmdstr, "ADD<") == 0) {cmd = ADD;}
 18f:	50                   	push   %eax
 190:	50                   	push   %eax
 191:	68 e8 0b 00 00       	push   $0xbe8
 196:	56                   	push   %esi
 197:	e8 84 02 00 00       	call   420 <strcmp>
 19c:	83 c4 10             	add    $0x10,%esp
 19f:	85 c0                	test   %eax,%eax
 1a1:	74 5e                	je     201 <main+0x201>
    else if (strcmp(cmdstr, "DROP") == 0) {cmd = DROP;}
 1a3:	50                   	push   %eax
 1a4:	50                   	push   %eax
 1a5:	68 ed 0b 00 00       	push   $0xbed
 1aa:	56                   	push   %esi
 1ab:	e8 70 02 00 00       	call   420 <strcmp>
 1b0:	83 c4 10             	add    $0x10,%esp
 1b3:	85 c0                	test   %eax,%eax
 1b5:	74 4a                	je     201 <main+0x201>
    else if (strcmp(cmdstr, "EDIT") == 0) {cmd = EDIT;}
 1b7:	50                   	push   %eax
 1b8:	50                   	push   %eax
 1b9:	68 f2 0b 00 00       	push   $0xbf2
 1be:	56                   	push   %esi
 1bf:	e8 5c 02 00 00       	call   420 <strcmp>
 1c4:	83 c4 10             	add    $0x10,%esp
 1c7:	85 c0                	test   %eax,%eax
 1c9:	74 36                	je     201 <main+0x201>
    else if (strcmp(cmdstr, "LIST") == 0) {cmd = LIST;}
 1cb:	51                   	push   %ecx
 1cc:	51                   	push   %ecx
 1cd:	68 f7 0b 00 00       	push   $0xbf7
 1d2:	56                   	push   %esi
 1d3:	e8 48 02 00 00       	call   420 <strcmp>
 1d8:	83 c4 10             	add    $0x10,%esp
 1db:	85 c0                	test   %eax,%eax
 1dd:	74 22                	je     201 <main+0x201>
    else if (strcmp(cmdstr, "QUIT") == 0) {cmd = QUIT;}
 1df:	52                   	push   %edx
 1e0:	52                   	push   %edx
 1e1:	68 fc 0b 00 00       	push   $0xbfc
 1e6:	56                   	push   %esi
 1e7:	e8 34 02 00 00       	call   420 <strcmp>
 1ec:	83 c4 10             	add    $0x10,%esp
 1ef:	85 c0                	test   %eax,%eax
 1f1:	75 2a                	jne    21d <main+0x21d>
  close(file.fd);
 1f3:	83 ec 0c             	sub    $0xc,%esp
 1f6:	57                   	push   %edi
 1f7:	e8 6e 04 00 00       	call   66a <close>
  exit();
 1fc:	e8 41 04 00 00       	call   642 <exit>
  write(file.fd, args, strlen(args));
 201:	83 ec 0c             	sub    $0xc,%esp
 204:	53                   	push   %ebx
 205:	e8 66 02 00 00       	call   470 <strlen>
 20a:	83 c4 0c             	add    $0xc,%esp
 20d:	50                   	push   %eax
 20e:	53                   	push   %ebx
 20f:	57                   	push   %edi
 210:	e8 4d 04 00 00       	call   662 <write>
 215:	83 c4 10             	add    $0x10,%esp
 218:	e9 92 fe ff ff       	jmp    af <main+0xaf>
  fprintf(2, "bad bi input\n");
 21d:	50                   	push   %eax
 21e:	50                   	push   %eax
 21f:	68 78 0b 00 00       	push   $0xb78
 224:	6a 02                	push   $0x2
 226:	e8 85 07 00 00       	call   9b0 <fprintf>
 22b:	83 c4 10             	add    $0x10,%esp
 22e:	e9 7c fe ff ff       	jmp    af <main+0xaf>
 233:	66 90                	xchg   %ax,%ax
 235:	66 90                	xchg   %ax,%ax
 237:	66 90                	xchg   %ax,%ax
 239:	66 90                	xchg   %ax,%ax
 23b:	66 90                	xchg   %ax,%ax
 23d:	66 90                	xchg   %ax,%ax
 23f:	90                   	nop

00000240 <end>:
void end(struct File file, char* args) {
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	56                   	push   %esi
 244:	53                   	push   %ebx
 245:	8b 5d 10             	mov    0x10(%ebp),%ebx
 248:	8b 75 0c             	mov    0xc(%ebp),%esi
  write(file.fd, args, strlen(args));
 24b:	83 ec 0c             	sub    $0xc,%esp
 24e:	53                   	push   %ebx
 24f:	e8 1c 02 00 00       	call   470 <strlen>
 254:	89 5d 0c             	mov    %ebx,0xc(%ebp)
 257:	89 75 08             	mov    %esi,0x8(%ebp)
 25a:	83 c4 10             	add    $0x10,%esp
 25d:	89 45 10             	mov    %eax,0x10(%ebp)
}
 260:	8d 65 f8             	lea    -0x8(%ebp),%esp
 263:	5b                   	pop    %ebx
 264:	5e                   	pop    %esi
 265:	5d                   	pop    %ebp
  write(file.fd, args, strlen(args));
 266:	e9 f7 03 00 00       	jmp    662 <write>
 26b:	90                   	nop
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000270 <add>:
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	5d                   	pop    %ebp
 274:	eb ca                	jmp    240 <end>
 276:	8d 76 00             	lea    0x0(%esi),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000280 <drop>:
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	5d                   	pop    %ebp
 284:	eb ba                	jmp    240 <end>
 286:	8d 76 00             	lea    0x0(%esi),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <edit>:
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	5d                   	pop    %ebp
 294:	eb aa                	jmp    240 <end>
 296:	8d 76 00             	lea    0x0(%esi),%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002a0 <list>:
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	5d                   	pop    %ebp
 2a4:	eb 9a                	jmp    240 <end>
 2a6:	8d 76 00             	lea    0x0(%esi),%esi
 2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002b0 <quit>:
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	5d                   	pop    %ebp
 2b4:	eb 8a                	jmp    240 <end>
 2b6:	8d 76 00             	lea    0x0(%esi),%esi
 2b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002c0 <bi>:
void bi() {
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	83 ec 10             	sub    $0x10,%esp
  fprintf(2, "bad bi input\n");
 2c6:	68 78 0b 00 00       	push   $0xb78
 2cb:	6a 02                	push   $0x2
 2cd:	e8 de 06 00 00       	call   9b0 <fprintf>
}
 2d2:	83 c4 10             	add    $0x10,%esp
 2d5:	c9                   	leave  
 2d6:	c3                   	ret    
 2d7:	89 f6                	mov    %esi,%esi
 2d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002e0 <substr>:
void substr(char* dest, char* str, int start, int end) {
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	57                   	push   %edi
 2e4:	56                   	push   %esi
 2e5:	53                   	push   %ebx
 2e6:	83 ec 18             	sub    $0x18,%esp
 2e9:	8b 75 0c             	mov    0xc(%ebp),%esi
 2ec:	8b 7d 14             	mov    0x14(%ebp),%edi
 2ef:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str);
 2f2:	56                   	push   %esi
 2f3:	e8 78 01 00 00       	call   470 <strlen>
 2f8:	83 c4 10             	add    $0x10,%esp
 2fb:	39 f8                	cmp    %edi,%eax
 2fd:	0f 4e f8             	cmovle %eax,%edi
  for (int i = start; i < end; i++)
 300:	3b 7d 10             	cmp    0x10(%ebp),%edi
 303:	7e 1e                	jle    323 <substr+0x43>
 305:	8b 55 10             	mov    0x10(%ebp),%edx
    dest[s++] = str[i];
 308:	89 d8                	mov    %ebx,%eax
 30a:	29 d0                	sub    %edx,%eax
 30c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 310:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 314:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  for (int i = start; i < end; i++)
 317:	83 c2 01             	add    $0x1,%edx
 31a:	39 d7                	cmp    %edx,%edi
 31c:	75 f2                	jne    310 <substr+0x30>
 31e:	2b 7d 10             	sub    0x10(%ebp),%edi
 321:	01 fb                	add    %edi,%ebx
  dest[s] = '\0';
 323:	c6 03 00             	movb   $0x0,(%ebx)
}
 326:	8d 65 f4             	lea    -0xc(%ebp),%esp
 329:	5b                   	pop    %ebx
 32a:	5e                   	pop    %esi
 32b:	5f                   	pop    %edi
 32c:	5d                   	pop    %ebp
 32d:	c3                   	ret    
 32e:	66 90                	xchg   %ax,%ax

00000330 <toUpper>:
void toUpper(char* str) {
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	8b 55 08             	mov    0x8(%ebp),%edx
  while (str[i] != '\0') {
 336:	0f b6 02             	movzbl (%edx),%eax
 339:	84 c0                	test   %al,%al
 33b:	74 1a                	je     357 <toUpper+0x27>
 33d:	8d 76 00             	lea    0x0(%esi),%esi
    if (c <= 'z' && c >= 'a')
 340:	8d 48 9f             	lea    -0x61(%eax),%ecx
 343:	80 f9 19             	cmp    $0x19,%cl
 346:	77 05                	ja     34d <toUpper+0x1d>
      str[i] += ('Z' - 'z');
 348:	83 e8 20             	sub    $0x20,%eax
 34b:	88 02                	mov    %al,(%edx)
 34d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
 350:	0f b6 02             	movzbl (%edx),%eax
 353:	84 c0                	test   %al,%al
 355:	75 e9                	jne    340 <toUpper+0x10>
    i++;  
  }
}
 357:	5d                   	pop    %ebp
 358:	c3                   	ret    
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000360 <toLower>:

void toLower(char* str) {
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
 366:	0f b6 02             	movzbl (%edx),%eax
 369:	84 c0                	test   %al,%al
 36b:	74 1a                	je     387 <toLower+0x27>
 36d:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'Z' && c >= 'A')
 370:	8d 48 bf             	lea    -0x41(%eax),%ecx
 373:	80 f9 19             	cmp    $0x19,%cl
 376:	77 05                	ja     37d <toLower+0x1d>
      str[i] -= ('Z' - 'z');
 378:	83 c0 20             	add    $0x20,%eax
 37b:	88 02                	mov    %al,(%edx)
 37d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
 380:	0f b6 02             	movzbl (%edx),%eax
 383:	84 c0                	test   %al,%al
 385:	75 e9                	jne    370 <toLower+0x10>
    i++;  
  }
}
 387:	5d                   	pop    %ebp
 388:	c3                   	ret    
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000390 <unline>:

void unline(char* str) {
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	53                   	push   %ebx
 394:	83 ec 10             	sub    $0x10,%esp
 397:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str) - 1;
 39a:	53                   	push   %ebx
 39b:	e8 d0 00 00 00       	call   470 <strlen>
 3a0:	8d 50 ff             	lea    -0x1(%eax),%edx
  for (; len > 0; len--) {
 3a3:	83 c4 10             	add    $0x10,%esp
 3a6:	85 d2                	test   %edx,%edx
 3a8:	7e 36                	jle    3e0 <unline+0x50>
    char c = str[len];
    if (c == '\n')
 3aa:	80 7c 03 ff 0a       	cmpb   $0xa,-0x1(%ebx,%eax,1)
 3af:	74 2f                	je     3e0 <unline+0x50>
 3b1:	8d 44 03 fe          	lea    -0x2(%ebx,%eax,1),%eax
 3b5:	eb 12                	jmp    3c9 <unline+0x39>
 3b7:	89 f6                	mov    %esi,%esi
 3b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 3c0:	83 e8 01             	sub    $0x1,%eax
 3c3:	80 78 01 0a          	cmpb   $0xa,0x1(%eax)
 3c7:	74 06                	je     3cf <unline+0x3f>
  for (; len > 0; len--) {
 3c9:	39 c3                	cmp    %eax,%ebx
 3cb:	89 c2                	mov    %eax,%edx
 3cd:	75 f1                	jne    3c0 <unline+0x30>
      break;
  }
  str[len] = '\0';
 3cf:	c6 02 00             	movb   $0x0,(%edx)
 3d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3d5:	c9                   	leave  
 3d6:	c3                   	ret    
 3d7:	89 f6                	mov    %esi,%esi
 3d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 3e0:	01 da                	add    %ebx,%edx
  str[len] = '\0';
 3e2:	c6 02 00             	movb   $0x0,(%edx)
 3e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3e8:	c9                   	leave  
 3e9:	c3                   	ret    
 3ea:	66 90                	xchg   %ax,%ax
 3ec:	66 90                	xchg   %ax,%ax
 3ee:	66 90                	xchg   %ax,%ax

000003f0 <strcpy>:
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	53                   	push   %ebx
 3f4:	8b 45 08             	mov    0x8(%ebp),%eax
 3f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 3fa:	89 c2                	mov    %eax,%edx
 3fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 400:	83 c1 01             	add    $0x1,%ecx
 403:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 407:	83 c2 01             	add    $0x1,%edx
 40a:	84 db                	test   %bl,%bl
 40c:	88 5a ff             	mov    %bl,-0x1(%edx)
 40f:	75 ef                	jne    400 <strcpy+0x10>
 411:	5b                   	pop    %ebx
 412:	5d                   	pop    %ebp
 413:	c3                   	ret    
 414:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 41a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000420 <strcmp>:
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	53                   	push   %ebx
 424:	8b 55 08             	mov    0x8(%ebp),%edx
 427:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 42a:	0f b6 02             	movzbl (%edx),%eax
 42d:	0f b6 19             	movzbl (%ecx),%ebx
 430:	84 c0                	test   %al,%al
 432:	75 1c                	jne    450 <strcmp+0x30>
 434:	eb 2a                	jmp    460 <strcmp+0x40>
 436:	8d 76 00             	lea    0x0(%esi),%esi
 439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 440:	83 c2 01             	add    $0x1,%edx
 443:	0f b6 02             	movzbl (%edx),%eax
 446:	83 c1 01             	add    $0x1,%ecx
 449:	0f b6 19             	movzbl (%ecx),%ebx
 44c:	84 c0                	test   %al,%al
 44e:	74 10                	je     460 <strcmp+0x40>
 450:	38 d8                	cmp    %bl,%al
 452:	74 ec                	je     440 <strcmp+0x20>
 454:	29 d8                	sub    %ebx,%eax
 456:	5b                   	pop    %ebx
 457:	5d                   	pop    %ebp
 458:	c3                   	ret    
 459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 460:	31 c0                	xor    %eax,%eax
 462:	29 d8                	sub    %ebx,%eax
 464:	5b                   	pop    %ebx
 465:	5d                   	pop    %ebp
 466:	c3                   	ret    
 467:	89 f6                	mov    %esi,%esi
 469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000470 <strlen>:
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	8b 4d 08             	mov    0x8(%ebp),%ecx
 476:	80 39 00             	cmpb   $0x0,(%ecx)
 479:	74 15                	je     490 <strlen+0x20>
 47b:	31 d2                	xor    %edx,%edx
 47d:	8d 76 00             	lea    0x0(%esi),%esi
 480:	83 c2 01             	add    $0x1,%edx
 483:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 487:	89 d0                	mov    %edx,%eax
 489:	75 f5                	jne    480 <strlen+0x10>
 48b:	5d                   	pop    %ebp
 48c:	c3                   	ret    
 48d:	8d 76 00             	lea    0x0(%esi),%esi
 490:	31 c0                	xor    %eax,%eax
 492:	5d                   	pop    %ebp
 493:	c3                   	ret    
 494:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 49a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000004a0 <memset>:
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	8b 55 08             	mov    0x8(%ebp),%edx
 4a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 4ad:	89 d7                	mov    %edx,%edi
 4af:	fc                   	cld    
 4b0:	f3 aa                	rep stos %al,%es:(%edi)
 4b2:	89 d0                	mov    %edx,%eax
 4b4:	5f                   	pop    %edi
 4b5:	5d                   	pop    %ebp
 4b6:	c3                   	ret    
 4b7:	89 f6                	mov    %esi,%esi
 4b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004c0 <strchr>:
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	53                   	push   %ebx
 4c4:	8b 45 08             	mov    0x8(%ebp),%eax
 4c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 4ca:	0f b6 10             	movzbl (%eax),%edx
 4cd:	84 d2                	test   %dl,%dl
 4cf:	74 1d                	je     4ee <strchr+0x2e>
 4d1:	38 d3                	cmp    %dl,%bl
 4d3:	89 d9                	mov    %ebx,%ecx
 4d5:	75 0d                	jne    4e4 <strchr+0x24>
 4d7:	eb 17                	jmp    4f0 <strchr+0x30>
 4d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4e0:	38 ca                	cmp    %cl,%dl
 4e2:	74 0c                	je     4f0 <strchr+0x30>
 4e4:	83 c0 01             	add    $0x1,%eax
 4e7:	0f b6 10             	movzbl (%eax),%edx
 4ea:	84 d2                	test   %dl,%dl
 4ec:	75 f2                	jne    4e0 <strchr+0x20>
 4ee:	31 c0                	xor    %eax,%eax
 4f0:	5b                   	pop    %ebx
 4f1:	5d                   	pop    %ebp
 4f2:	c3                   	ret    
 4f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000500 <gets>:
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	57                   	push   %edi
 504:	56                   	push   %esi
 505:	53                   	push   %ebx
 506:	31 f6                	xor    %esi,%esi
 508:	89 f3                	mov    %esi,%ebx
 50a:	83 ec 1c             	sub    $0x1c,%esp
 50d:	8b 7d 08             	mov    0x8(%ebp),%edi
 510:	eb 2f                	jmp    541 <gets+0x41>
 512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 518:	8d 45 e7             	lea    -0x19(%ebp),%eax
 51b:	83 ec 04             	sub    $0x4,%esp
 51e:	6a 01                	push   $0x1
 520:	50                   	push   %eax
 521:	6a 00                	push   $0x0
 523:	e8 32 01 00 00       	call   65a <read>
 528:	83 c4 10             	add    $0x10,%esp
 52b:	85 c0                	test   %eax,%eax
 52d:	7e 1c                	jle    54b <gets+0x4b>
 52f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 533:	83 c7 01             	add    $0x1,%edi
 536:	88 47 ff             	mov    %al,-0x1(%edi)
 539:	3c 0a                	cmp    $0xa,%al
 53b:	74 23                	je     560 <gets+0x60>
 53d:	3c 0d                	cmp    $0xd,%al
 53f:	74 1f                	je     560 <gets+0x60>
 541:	83 c3 01             	add    $0x1,%ebx
 544:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 547:	89 fe                	mov    %edi,%esi
 549:	7c cd                	jl     518 <gets+0x18>
 54b:	89 f3                	mov    %esi,%ebx
 54d:	8b 45 08             	mov    0x8(%ebp),%eax
 550:	c6 03 00             	movb   $0x0,(%ebx)
 553:	8d 65 f4             	lea    -0xc(%ebp),%esp
 556:	5b                   	pop    %ebx
 557:	5e                   	pop    %esi
 558:	5f                   	pop    %edi
 559:	5d                   	pop    %ebp
 55a:	c3                   	ret    
 55b:	90                   	nop
 55c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 560:	8b 75 08             	mov    0x8(%ebp),%esi
 563:	8b 45 08             	mov    0x8(%ebp),%eax
 566:	01 de                	add    %ebx,%esi
 568:	89 f3                	mov    %esi,%ebx
 56a:	c6 03 00             	movb   $0x0,(%ebx)
 56d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 570:	5b                   	pop    %ebx
 571:	5e                   	pop    %esi
 572:	5f                   	pop    %edi
 573:	5d                   	pop    %ebp
 574:	c3                   	ret    
 575:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000580 <stat>:
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	56                   	push   %esi
 584:	53                   	push   %ebx
 585:	83 ec 08             	sub    $0x8,%esp
 588:	6a 00                	push   $0x0
 58a:	ff 75 08             	pushl  0x8(%ebp)
 58d:	e8 f0 00 00 00       	call   682 <open>
 592:	83 c4 10             	add    $0x10,%esp
 595:	85 c0                	test   %eax,%eax
 597:	78 27                	js     5c0 <stat+0x40>
 599:	83 ec 08             	sub    $0x8,%esp
 59c:	ff 75 0c             	pushl  0xc(%ebp)
 59f:	89 c3                	mov    %eax,%ebx
 5a1:	50                   	push   %eax
 5a2:	e8 f3 00 00 00       	call   69a <fstat>
 5a7:	89 1c 24             	mov    %ebx,(%esp)
 5aa:	89 c6                	mov    %eax,%esi
 5ac:	e8 b9 00 00 00       	call   66a <close>
 5b1:	83 c4 10             	add    $0x10,%esp
 5b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 5b7:	89 f0                	mov    %esi,%eax
 5b9:	5b                   	pop    %ebx
 5ba:	5e                   	pop    %esi
 5bb:	5d                   	pop    %ebp
 5bc:	c3                   	ret    
 5bd:	8d 76 00             	lea    0x0(%esi),%esi
 5c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 5c5:	eb ed                	jmp    5b4 <stat+0x34>
 5c7:	89 f6                	mov    %esi,%esi
 5c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005d0 <atoi>:
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	53                   	push   %ebx
 5d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
 5d7:	0f be 11             	movsbl (%ecx),%edx
 5da:	8d 42 d0             	lea    -0x30(%edx),%eax
 5dd:	3c 09                	cmp    $0x9,%al
 5df:	b8 00 00 00 00       	mov    $0x0,%eax
 5e4:	77 1f                	ja     605 <atoi+0x35>
 5e6:	8d 76 00             	lea    0x0(%esi),%esi
 5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 5f0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 5f3:	83 c1 01             	add    $0x1,%ecx
 5f6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 5fa:	0f be 11             	movsbl (%ecx),%edx
 5fd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 600:	80 fb 09             	cmp    $0x9,%bl
 603:	76 eb                	jbe    5f0 <atoi+0x20>
 605:	5b                   	pop    %ebx
 606:	5d                   	pop    %ebp
 607:	c3                   	ret    
 608:	90                   	nop
 609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000610 <memmove>:
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	56                   	push   %esi
 614:	53                   	push   %ebx
 615:	8b 5d 10             	mov    0x10(%ebp),%ebx
 618:	8b 45 08             	mov    0x8(%ebp),%eax
 61b:	8b 75 0c             	mov    0xc(%ebp),%esi
 61e:	85 db                	test   %ebx,%ebx
 620:	7e 14                	jle    636 <memmove+0x26>
 622:	31 d2                	xor    %edx,%edx
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 628:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 62c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 62f:	83 c2 01             	add    $0x1,%edx
 632:	39 d3                	cmp    %edx,%ebx
 634:	75 f2                	jne    628 <memmove+0x18>
 636:	5b                   	pop    %ebx
 637:	5e                   	pop    %esi
 638:	5d                   	pop    %ebp
 639:	c3                   	ret    

0000063a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 63a:	b8 01 00 00 00       	mov    $0x1,%eax
 63f:	cd 40                	int    $0x40
 641:	c3                   	ret    

00000642 <exit>:
SYSCALL(exit)
 642:	b8 02 00 00 00       	mov    $0x2,%eax
 647:	cd 40                	int    $0x40
 649:	c3                   	ret    

0000064a <wait>:
SYSCALL(wait)
 64a:	b8 03 00 00 00       	mov    $0x3,%eax
 64f:	cd 40                	int    $0x40
 651:	c3                   	ret    

00000652 <pipe>:
SYSCALL(pipe)
 652:	b8 04 00 00 00       	mov    $0x4,%eax
 657:	cd 40                	int    $0x40
 659:	c3                   	ret    

0000065a <read>:
SYSCALL(read)
 65a:	b8 05 00 00 00       	mov    $0x5,%eax
 65f:	cd 40                	int    $0x40
 661:	c3                   	ret    

00000662 <write>:
SYSCALL(write)
 662:	b8 10 00 00 00       	mov    $0x10,%eax
 667:	cd 40                	int    $0x40
 669:	c3                   	ret    

0000066a <close>:
SYSCALL(close)
 66a:	b8 15 00 00 00       	mov    $0x15,%eax
 66f:	cd 40                	int    $0x40
 671:	c3                   	ret    

00000672 <kill>:
SYSCALL(kill)
 672:	b8 06 00 00 00       	mov    $0x6,%eax
 677:	cd 40                	int    $0x40
 679:	c3                   	ret    

0000067a <exec>:
SYSCALL(exec)
 67a:	b8 07 00 00 00       	mov    $0x7,%eax
 67f:	cd 40                	int    $0x40
 681:	c3                   	ret    

00000682 <open>:
SYSCALL(open)
 682:	b8 0f 00 00 00       	mov    $0xf,%eax
 687:	cd 40                	int    $0x40
 689:	c3                   	ret    

0000068a <mknod>:
SYSCALL(mknod)
 68a:	b8 11 00 00 00       	mov    $0x11,%eax
 68f:	cd 40                	int    $0x40
 691:	c3                   	ret    

00000692 <unlink>:
SYSCALL(unlink)
 692:	b8 12 00 00 00       	mov    $0x12,%eax
 697:	cd 40                	int    $0x40
 699:	c3                   	ret    

0000069a <fstat>:
SYSCALL(fstat)
 69a:	b8 08 00 00 00       	mov    $0x8,%eax
 69f:	cd 40                	int    $0x40
 6a1:	c3                   	ret    

000006a2 <link>:
SYSCALL(link)
 6a2:	b8 13 00 00 00       	mov    $0x13,%eax
 6a7:	cd 40                	int    $0x40
 6a9:	c3                   	ret    

000006aa <mkdir>:
SYSCALL(mkdir)
 6aa:	b8 14 00 00 00       	mov    $0x14,%eax
 6af:	cd 40                	int    $0x40
 6b1:	c3                   	ret    

000006b2 <chdir>:
SYSCALL(chdir)
 6b2:	b8 09 00 00 00       	mov    $0x9,%eax
 6b7:	cd 40                	int    $0x40
 6b9:	c3                   	ret    

000006ba <dup>:
SYSCALL(dup)
 6ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 6bf:	cd 40                	int    $0x40
 6c1:	c3                   	ret    

000006c2 <getpid>:
SYSCALL(getpid)
 6c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 6c7:	cd 40                	int    $0x40
 6c9:	c3                   	ret    

000006ca <sbrk>:
SYSCALL(sbrk)
 6ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 6cf:	cd 40                	int    $0x40
 6d1:	c3                   	ret    

000006d2 <sleep>:
SYSCALL(sleep)
 6d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 6d7:	cd 40                	int    $0x40
 6d9:	c3                   	ret    

000006da <uptime>:
SYSCALL(uptime)
 6da:	b8 0e 00 00 00       	mov    $0xe,%eax
 6df:	cd 40                	int    $0x40
 6e1:	c3                   	ret    

000006e2 <cpuhalt>:
SYSCALL(cpuhalt)
 6e2:	b8 16 00 00 00       	mov    $0x16,%eax
 6e7:	cd 40                	int    $0x40
 6e9:	c3                   	ret    
 6ea:	66 90                	xchg   %ax,%ax
 6ec:	66 90                	xchg   %ax,%ax
 6ee:	66 90                	xchg   %ax,%ax

000006f0 <printint.constprop.1>:
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	57                   	push   %edi
 6f4:	56                   	push   %esi
 6f5:	53                   	push   %ebx
 6f6:	89 d6                	mov    %edx,%esi
 6f8:	83 ec 3c             	sub    $0x3c,%esp
 6fb:	85 c0                	test   %eax,%eax
 6fd:	79 71                	jns    770 <printint.constprop.1+0x80>
 6ff:	83 e1 01             	and    $0x1,%ecx
 702:	74 6c                	je     770 <printint.constprop.1+0x80>
 704:	f7 d8                	neg    %eax
 706:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 70d:	31 c9                	xor    %ecx,%ecx
 70f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 712:	eb 06                	jmp    71a <printint.constprop.1+0x2a>
 714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 718:	89 f9                	mov    %edi,%ecx
 71a:	31 d2                	xor    %edx,%edx
 71c:	8d 79 01             	lea    0x1(%ecx),%edi
 71f:	f7 f6                	div    %esi
 721:	0f b6 92 2c 0c 00 00 	movzbl 0xc2c(%edx),%edx
 728:	85 c0                	test   %eax,%eax
 72a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
 72d:	75 e9                	jne    718 <printint.constprop.1+0x28>
 72f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 732:	85 c0                	test   %eax,%eax
 734:	74 08                	je     73e <printint.constprop.1+0x4e>
 736:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 73b:	8d 79 02             	lea    0x2(%ecx),%edi
 73e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 748:	0f b6 06             	movzbl (%esi),%eax
 74b:	83 ec 04             	sub    $0x4,%esp
 74e:	83 ee 01             	sub    $0x1,%esi
 751:	6a 01                	push   $0x1
 753:	53                   	push   %ebx
 754:	6a 01                	push   $0x1
 756:	88 45 d7             	mov    %al,-0x29(%ebp)
 759:	e8 04 ff ff ff       	call   662 <write>
 75e:	83 c4 10             	add    $0x10,%esp
 761:	39 de                	cmp    %ebx,%esi
 763:	75 e3                	jne    748 <printint.constprop.1+0x58>
 765:	8d 65 f4             	lea    -0xc(%ebp),%esp
 768:	5b                   	pop    %ebx
 769:	5e                   	pop    %esi
 76a:	5f                   	pop    %edi
 76b:	5d                   	pop    %ebp
 76c:	c3                   	ret    
 76d:	8d 76 00             	lea    0x0(%esi),%esi
 770:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 777:	eb 94                	jmp    70d <printint.constprop.1+0x1d>
 779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000780 <vprintf.constprop.0>:
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	57                   	push   %edi
 784:	56                   	push   %esi
 785:	53                   	push   %ebx
 786:	89 d6                	mov    %edx,%esi
 788:	83 ec 2c             	sub    $0x2c,%esp
 78b:	0f b6 10             	movzbl (%eax),%edx
 78e:	84 d2                	test   %dl,%dl
 790:	0f 84 cd 00 00 00    	je     863 <vprintf.constprop.0+0xe3>
 796:	8d 58 01             	lea    0x1(%eax),%ebx
 799:	31 ff                	xor    %edi,%edi
 79b:	eb 31                	jmp    7ce <vprintf.constprop.0+0x4e>
 79d:	8d 76 00             	lea    0x0(%esi),%esi
 7a0:	83 f8 25             	cmp    $0x25,%eax
 7a3:	0f 84 c7 00 00 00    	je     870 <vprintf.constprop.0+0xf0>
 7a9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 7ac:	83 ec 04             	sub    $0x4,%esp
 7af:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 7b2:	6a 01                	push   $0x1
 7b4:	50                   	push   %eax
 7b5:	6a 01                	push   $0x1
 7b7:	e8 a6 fe ff ff       	call   662 <write>
 7bc:	83 c4 10             	add    $0x10,%esp
 7bf:	83 c3 01             	add    $0x1,%ebx
 7c2:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 7c6:	84 d2                	test   %dl,%dl
 7c8:	0f 84 95 00 00 00    	je     863 <vprintf.constprop.0+0xe3>
 7ce:	85 ff                	test   %edi,%edi
 7d0:	0f b6 c2             	movzbl %dl,%eax
 7d3:	74 cb                	je     7a0 <vprintf.constprop.0+0x20>
 7d5:	83 ff 25             	cmp    $0x25,%edi
 7d8:	75 e5                	jne    7bf <vprintf.constprop.0+0x3f>
 7da:	83 f8 64             	cmp    $0x64,%eax
 7dd:	8d 7e 04             	lea    0x4(%esi),%edi
 7e0:	b9 01 00 00 00       	mov    $0x1,%ecx
 7e5:	0f 84 9a 00 00 00    	je     885 <vprintf.constprop.0+0x105>
 7eb:	83 f8 6c             	cmp    $0x6c,%eax
 7ee:	0f 84 8c 00 00 00    	je     880 <vprintf.constprop.0+0x100>
 7f4:	83 f8 78             	cmp    $0x78,%eax
 7f7:	0f 84 a3 00 00 00    	je     8a0 <vprintf.constprop.0+0x120>
 7fd:	83 f8 70             	cmp    $0x70,%eax
 800:	0f 84 ca 00 00 00    	je     8d0 <vprintf.constprop.0+0x150>
 806:	83 f8 73             	cmp    $0x73,%eax
 809:	0f 84 39 01 00 00    	je     948 <vprintf.constprop.0+0x1c8>
 80f:	83 f8 63             	cmp    $0x63,%eax
 812:	0f 84 68 01 00 00    	je     980 <vprintf.constprop.0+0x200>
 818:	83 f8 25             	cmp    $0x25,%eax
 81b:	0f 84 9f 00 00 00    	je     8c0 <vprintf.constprop.0+0x140>
 821:	8d 45 df             	lea    -0x21(%ebp),%eax
 824:	83 ec 04             	sub    $0x4,%esp
 827:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 82a:	6a 01                	push   $0x1
 82c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
 830:	50                   	push   %eax
 831:	6a 01                	push   $0x1
 833:	e8 2a fe ff ff       	call   662 <write>
 838:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
 83c:	83 c4 0c             	add    $0xc,%esp
 83f:	8d 45 e0             	lea    -0x20(%ebp),%eax
 842:	6a 01                	push   $0x1
 844:	88 55 e0             	mov    %dl,-0x20(%ebp)
 847:	50                   	push   %eax
 848:	6a 01                	push   $0x1
 84a:	83 c3 01             	add    $0x1,%ebx
 84d:	31 ff                	xor    %edi,%edi
 84f:	e8 0e fe ff ff       	call   662 <write>
 854:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 858:	83 c4 10             	add    $0x10,%esp
 85b:	84 d2                	test   %dl,%dl
 85d:	0f 85 6b ff ff ff    	jne    7ce <vprintf.constprop.0+0x4e>
 863:	8d 65 f4             	lea    -0xc(%ebp),%esp
 866:	5b                   	pop    %ebx
 867:	5e                   	pop    %esi
 868:	5f                   	pop    %edi
 869:	5d                   	pop    %ebp
 86a:	c3                   	ret    
 86b:	90                   	nop
 86c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 870:	bf 25 00 00 00       	mov    $0x25,%edi
 875:	e9 45 ff ff ff       	jmp    7bf <vprintf.constprop.0+0x3f>
 87a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 880:	8d 7e 04             	lea    0x4(%esi),%edi
 883:	31 c9                	xor    %ecx,%ecx
 885:	8b 06                	mov    (%esi),%eax
 887:	ba 0a 00 00 00       	mov    $0xa,%edx
 88c:	89 fe                	mov    %edi,%esi
 88e:	31 ff                	xor    %edi,%edi
 890:	e8 5b fe ff ff       	call   6f0 <printint.constprop.1>
 895:	e9 25 ff ff ff       	jmp    7bf <vprintf.constprop.0+0x3f>
 89a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8a0:	8b 06                	mov    (%esi),%eax
 8a2:	8d 7e 04             	lea    0x4(%esi),%edi
 8a5:	31 c9                	xor    %ecx,%ecx
 8a7:	ba 10 00 00 00       	mov    $0x10,%edx
 8ac:	89 fe                	mov    %edi,%esi
 8ae:	31 ff                	xor    %edi,%edi
 8b0:	e8 3b fe ff ff       	call   6f0 <printint.constprop.1>
 8b5:	e9 05 ff ff ff       	jmp    7bf <vprintf.constprop.0+0x3f>
 8ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8c0:	83 ec 04             	sub    $0x4,%esp
 8c3:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 8c6:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 8c9:	6a 01                	push   $0x1
 8cb:	e9 77 ff ff ff       	jmp    847 <vprintf.constprop.0+0xc7>
 8d0:	8d 46 04             	lea    0x4(%esi),%eax
 8d3:	83 ec 04             	sub    $0x4,%esp
 8d6:	8b 3e                	mov    (%esi),%edi
 8d8:	6a 01                	push   $0x1
 8da:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 8de:	be 08 00 00 00       	mov    $0x8,%esi
 8e3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 8e6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 8e9:	50                   	push   %eax
 8ea:	6a 01                	push   $0x1
 8ec:	e8 71 fd ff ff       	call   662 <write>
 8f1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 8f4:	83 c4 0c             	add    $0xc,%esp
 8f7:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
 8fb:	6a 01                	push   $0x1
 8fd:	50                   	push   %eax
 8fe:	6a 01                	push   $0x1
 900:	e8 5d fd ff ff       	call   662 <write>
 905:	83 c4 10             	add    $0x10,%esp
 908:	90                   	nop
 909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 910:	89 f8                	mov    %edi,%eax
 912:	83 ec 04             	sub    $0x4,%esp
 915:	c1 e7 04             	shl    $0x4,%edi
 918:	c1 e8 1c             	shr    $0x1c,%eax
 91b:	6a 01                	push   $0x1
 91d:	0f b6 80 2c 0c 00 00 	movzbl 0xc2c(%eax),%eax
 924:	88 45 e5             	mov    %al,-0x1b(%ebp)
 927:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 92a:	50                   	push   %eax
 92b:	6a 01                	push   $0x1
 92d:	e8 30 fd ff ff       	call   662 <write>
 932:	83 c4 10             	add    $0x10,%esp
 935:	83 ee 01             	sub    $0x1,%esi
 938:	75 d6                	jne    910 <vprintf.constprop.0+0x190>
 93a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 93d:	31 ff                	xor    %edi,%edi
 93f:	e9 7b fe ff ff       	jmp    7bf <vprintf.constprop.0+0x3f>
 944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 948:	8b 3e                	mov    (%esi),%edi
 94a:	8d 46 04             	lea    0x4(%esi),%eax
 94d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 950:	85 ff                	test   %edi,%edi
 952:	74 50                	je     9a4 <vprintf.constprop.0+0x224>
 954:	0f b6 07             	movzbl (%edi),%eax
 957:	84 c0                	test   %al,%al
 959:	74 df                	je     93a <vprintf.constprop.0+0x1ba>
 95b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 95e:	66 90                	xchg   %ax,%ax
 960:	83 ec 04             	sub    $0x4,%esp
 963:	83 c7 01             	add    $0x1,%edi
 966:	88 45 e3             	mov    %al,-0x1d(%ebp)
 969:	6a 01                	push   $0x1
 96b:	56                   	push   %esi
 96c:	6a 01                	push   $0x1
 96e:	e8 ef fc ff ff       	call   662 <write>
 973:	0f b6 07             	movzbl (%edi),%eax
 976:	83 c4 10             	add    $0x10,%esp
 979:	84 c0                	test   %al,%al
 97b:	75 e3                	jne    960 <vprintf.constprop.0+0x1e0>
 97d:	eb bb                	jmp    93a <vprintf.constprop.0+0x1ba>
 97f:	90                   	nop
 980:	8b 06                	mov    (%esi),%eax
 982:	83 ec 04             	sub    $0x4,%esp
 985:	8d 7e 04             	lea    0x4(%esi),%edi
 988:	6a 01                	push   $0x1
 98a:	89 fe                	mov    %edi,%esi
 98c:	31 ff                	xor    %edi,%edi
 98e:	88 45 e2             	mov    %al,-0x1e(%ebp)
 991:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 994:	50                   	push   %eax
 995:	6a 01                	push   $0x1
 997:	e8 c6 fc ff ff       	call   662 <write>
 99c:	83 c4 10             	add    $0x10,%esp
 99f:	e9 1b fe ff ff       	jmp    7bf <vprintf.constprop.0+0x3f>
 9a4:	bf 24 0c 00 00       	mov    $0xc24,%edi
 9a9:	b8 28 00 00 00       	mov    $0x28,%eax
 9ae:	eb ab                	jmp    95b <vprintf.constprop.0+0x1db>

000009b0 <fprintf>:
 9b0:	55                   	push   %ebp
 9b1:	89 e5                	mov    %esp,%ebp
 9b3:	83 ec 08             	sub    $0x8,%esp
 9b6:	8b 45 0c             	mov    0xc(%ebp),%eax
 9b9:	8d 55 10             	lea    0x10(%ebp),%edx
 9bc:	e8 bf fd ff ff       	call   780 <vprintf.constprop.0>
 9c1:	c9                   	leave  
 9c2:	c3                   	ret    
 9c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 9c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009d0 <printf>:
 9d0:	55                   	push   %ebp
 9d1:	89 e5                	mov    %esp,%ebp
 9d3:	83 ec 08             	sub    $0x8,%esp
 9d6:	8b 45 08             	mov    0x8(%ebp),%eax
 9d9:	8d 55 0c             	lea    0xc(%ebp),%edx
 9dc:	e8 9f fd ff ff       	call   780 <vprintf.constprop.0>
 9e1:	c9                   	leave  
 9e2:	c3                   	ret    
 9e3:	66 90                	xchg   %ax,%ax
 9e5:	66 90                	xchg   %ax,%ax
 9e7:	66 90                	xchg   %ax,%ax
 9e9:	66 90                	xchg   %ax,%ax
 9eb:	66 90                	xchg   %ax,%ax
 9ed:	66 90                	xchg   %ax,%ax
 9ef:	90                   	nop

000009f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9f1:	a1 24 11 00 00       	mov    0x1124,%eax
{
 9f6:	89 e5                	mov    %esp,%ebp
 9f8:	57                   	push   %edi
 9f9:	56                   	push   %esi
 9fa:	53                   	push   %ebx
 9fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 9fe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a08:	39 c8                	cmp    %ecx,%eax
 a0a:	8b 10                	mov    (%eax),%edx
 a0c:	73 32                	jae    a40 <free+0x50>
 a0e:	39 d1                	cmp    %edx,%ecx
 a10:	72 04                	jb     a16 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a12:	39 d0                	cmp    %edx,%eax
 a14:	72 32                	jb     a48 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a16:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a19:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a1c:	39 fa                	cmp    %edi,%edx
 a1e:	74 30                	je     a50 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 a20:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a23:	8b 50 04             	mov    0x4(%eax),%edx
 a26:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a29:	39 f1                	cmp    %esi,%ecx
 a2b:	74 3a                	je     a67 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 a2d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 a2f:	a3 24 11 00 00       	mov    %eax,0x1124
}
 a34:	5b                   	pop    %ebx
 a35:	5e                   	pop    %esi
 a36:	5f                   	pop    %edi
 a37:	5d                   	pop    %ebp
 a38:	c3                   	ret    
 a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a40:	39 d0                	cmp    %edx,%eax
 a42:	72 04                	jb     a48 <free+0x58>
 a44:	39 d1                	cmp    %edx,%ecx
 a46:	72 ce                	jb     a16 <free+0x26>
{
 a48:	89 d0                	mov    %edx,%eax
 a4a:	eb bc                	jmp    a08 <free+0x18>
 a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 a50:	03 72 04             	add    0x4(%edx),%esi
 a53:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a56:	8b 10                	mov    (%eax),%edx
 a58:	8b 12                	mov    (%edx),%edx
 a5a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a5d:	8b 50 04             	mov    0x4(%eax),%edx
 a60:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a63:	39 f1                	cmp    %esi,%ecx
 a65:	75 c6                	jne    a2d <free+0x3d>
    p->s.size += bp->s.size;
 a67:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 a6a:	a3 24 11 00 00       	mov    %eax,0x1124
    p->s.size += bp->s.size;
 a6f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a72:	8b 53 f8             	mov    -0x8(%ebx),%edx
 a75:	89 10                	mov    %edx,(%eax)
}
 a77:	5b                   	pop    %ebx
 a78:	5e                   	pop    %esi
 a79:	5f                   	pop    %edi
 a7a:	5d                   	pop    %ebp
 a7b:	c3                   	ret    
 a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a80 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a80:	55                   	push   %ebp
 a81:	89 e5                	mov    %esp,%ebp
 a83:	57                   	push   %edi
 a84:	56                   	push   %esi
 a85:	53                   	push   %ebx
 a86:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a89:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a8c:	8b 15 24 11 00 00    	mov    0x1124,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a92:	8d 78 07             	lea    0x7(%eax),%edi
 a95:	c1 ef 03             	shr    $0x3,%edi
 a98:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 a9b:	85 d2                	test   %edx,%edx
 a9d:	0f 84 9d 00 00 00    	je     b40 <malloc+0xc0>
 aa3:	8b 02                	mov    (%edx),%eax
 aa5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 aa8:	39 cf                	cmp    %ecx,%edi
 aaa:	76 6c                	jbe    b18 <malloc+0x98>
 aac:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 ab2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 ab7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 aba:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 ac1:	eb 0e                	jmp    ad1 <malloc+0x51>
 ac3:	90                   	nop
 ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ac8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 aca:	8b 48 04             	mov    0x4(%eax),%ecx
 acd:	39 f9                	cmp    %edi,%ecx
 acf:	73 47                	jae    b18 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ad1:	39 05 24 11 00 00    	cmp    %eax,0x1124
 ad7:	89 c2                	mov    %eax,%edx
 ad9:	75 ed                	jne    ac8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 adb:	83 ec 0c             	sub    $0xc,%esp
 ade:	56                   	push   %esi
 adf:	e8 e6 fb ff ff       	call   6ca <sbrk>
  if(p == (char*)-1)
 ae4:	83 c4 10             	add    $0x10,%esp
 ae7:	83 f8 ff             	cmp    $0xffffffff,%eax
 aea:	74 1c                	je     b08 <malloc+0x88>
  hp->s.size = nu;
 aec:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 aef:	83 ec 0c             	sub    $0xc,%esp
 af2:	83 c0 08             	add    $0x8,%eax
 af5:	50                   	push   %eax
 af6:	e8 f5 fe ff ff       	call   9f0 <free>
  return freep;
 afb:	8b 15 24 11 00 00    	mov    0x1124,%edx
      if((p = morecore(nunits)) == 0)
 b01:	83 c4 10             	add    $0x10,%esp
 b04:	85 d2                	test   %edx,%edx
 b06:	75 c0                	jne    ac8 <malloc+0x48>
        return 0;
  }
}
 b08:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b0b:	31 c0                	xor    %eax,%eax
}
 b0d:	5b                   	pop    %ebx
 b0e:	5e                   	pop    %esi
 b0f:	5f                   	pop    %edi
 b10:	5d                   	pop    %ebp
 b11:	c3                   	ret    
 b12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 b18:	39 cf                	cmp    %ecx,%edi
 b1a:	74 54                	je     b70 <malloc+0xf0>
        p->s.size -= nunits;
 b1c:	29 f9                	sub    %edi,%ecx
 b1e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b21:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b24:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 b27:	89 15 24 11 00 00    	mov    %edx,0x1124
}
 b2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 b30:	83 c0 08             	add    $0x8,%eax
}
 b33:	5b                   	pop    %ebx
 b34:	5e                   	pop    %esi
 b35:	5f                   	pop    %edi
 b36:	5d                   	pop    %ebp
 b37:	c3                   	ret    
 b38:	90                   	nop
 b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 b40:	c7 05 24 11 00 00 28 	movl   $0x1128,0x1124
 b47:	11 00 00 
 b4a:	c7 05 28 11 00 00 28 	movl   $0x1128,0x1128
 b51:	11 00 00 
    base.s.size = 0;
 b54:	b8 28 11 00 00       	mov    $0x1128,%eax
 b59:	c7 05 2c 11 00 00 00 	movl   $0x0,0x112c
 b60:	00 00 00 
 b63:	e9 44 ff ff ff       	jmp    aac <malloc+0x2c>
 b68:	90                   	nop
 b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 b70:	8b 08                	mov    (%eax),%ecx
 b72:	89 0a                	mov    %ecx,(%edx)
 b74:	eb b1                	jmp    b27 <malloc+0xa7>
