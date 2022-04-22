
user/_more:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
void back(struct File* file, Terminal terminal);
void scroll(struct File* file, Terminal terminal);
void line(File file, Terminal terminal);
void help(Terminal terminal);

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
      11:	83 ec 38             	sub    $0x38,%esp
      14:	8b 01                	mov    (%ecx),%eax
      16:	8b 51 04             	mov    0x4(%ecx),%edx
  // arg czeching
  if (argc < 2) {
      19:	83 f8 01             	cmp    $0x1,%eax
      1c:	0f 8e 0a 02 00 00    	jle    22c <main+0x22c>
    fprintf(2, "more: bad usage\nTry 'more --help' for more information.\n");
    exit();
  } else if (argc > 2) {
      22:	83 f8 02             	cmp    $0x2,%eax
      25:	0f 85 26 01 00 00    	jne    151 <main+0x151>
  terminal.height = 25;
  struct File file;
  file.len = 0;
  file.edited = 0;
  file.curLine = TERMH_ADJ; // line displayed at bottom
  file.filename = argv[1];
      2b:	8b 42 04             	mov    0x4(%edx),%eax
  file.len = 0;
      2e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  file.edited = 0;
      35:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  file.curLine = TERMH_ADJ; // line displayed at bottom
      3c:	c7 45 d8 18 00 00 00 	movl   $0x18,-0x28(%ebp)
  file.filename = argv[1];
      43:	89 45 d0             	mov    %eax,-0x30(%ebp)
  file.lines = MakeLinkedList();
      46:	e8 e5 05 00 00       	call   630 <MakeLinkedList>

  // opening file
  file.fd = open(file.filename, O_RDONLY);
      4b:	56                   	push   %esi
      4c:	56                   	push   %esi
      4d:	6a 00                	push   $0x0
      4f:	ff 75 d0             	pushl  -0x30(%ebp)
  file.lines = MakeLinkedList();
      52:	89 45 dc             	mov    %eax,-0x24(%ebp)
  file.fd = open(file.filename, O_RDONLY);
      55:	e8 f0 18 00 00       	call   194a <open>
  if (file.fd == -1) {
      5a:	83 c4 10             	add    $0x10,%esp
  file.fd = open(file.filename, O_RDONLY);
      5d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  if (file.fd == -1) {
      60:	83 c0 01             	add    $0x1,%eax
      63:	0f 84 d6 01 00 00    	je     23f <main+0x23f>
    fprintf(2, "file could not be opened\n",  file.filename);
  } else {
    // populate Linked List
    gatherLinesSized(&file, terminal);
      69:	b8 64 00 00 00       	mov    $0x64,%eax
      6e:	ba 19 00 00 00       	mov    $0x19,%edx
      73:	51                   	push   %ecx
      74:	52                   	push   %edx
      75:	50                   	push   %eax
      76:	8d 45 d0             	lea    -0x30(%ebp),%eax
      79:	50                   	push   %eax
      7a:	89 45 bc             	mov    %eax,-0x44(%ebp)
      7d:	e8 0e 0b 00 00       	call   b90 <gatherLinesSized>
      82:	83 c4 10             	add    $0x10,%esp
  }
  close(file.fd);
      85:	83 ec 0c             	sub    $0xc,%esp
      88:	ff 75 d4             	pushl  -0x2c(%ebp)
  char cmd = ' ';
      8b:	bb 20 00 00 00       	mov    $0x20,%ebx
  close(file.fd);
      90:	e8 9d 18 00 00       	call   1932 <close>

  // loop
  showPage(file, terminal);
      95:	c7 45 c0 64 00 00 00 	movl   $0x64,-0x40(%ebp)
      9c:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
      a3:	b9 06 00 00 00       	mov    $0x6,%ecx
      a8:	ff 75 c4             	pushl  -0x3c(%ebp)
      ab:	ff 75 c0             	pushl  -0x40(%ebp)
      ae:	8b 75 bc             	mov    -0x44(%ebp),%esi
      b1:	83 ec 18             	sub    $0x18,%esp
      b4:	89 e7                	mov    %esp,%edi
      b6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
      b8:	e8 23 0f 00 00       	call   fe0 <showPage>
  while (cmd != 'q' && cmd != 'Q') {
      bd:	83 c4 30             	add    $0x30,%esp
      c0:	83 e3 df             	and    $0xffffffdf,%ebx
      c3:	80 fb 51             	cmp    $0x51,%bl
      c6:	0f 84 80 00 00 00    	je     14c <main+0x14c>
    cmdint = steal(0);
      cc:	83 ec 0c             	sub    $0xc,%esp
      cf:	6a 00                	push   $0x0
      d1:	e8 4c 18 00 00       	call   1922 <steal>
    cmd = (char) cmdint;
		// printf("cmd: %d = %c.\n", cmdint, cmd);
		if (cmd == '\0') exit();
      d6:	83 c4 10             	add    $0x10,%esp
      d9:	84 c0                	test   %al,%al
    cmd = (char) cmdint;
      db:	89 c3                	mov    %eax,%ebx
		if (cmd == '\0') exit();
      dd:	74 6d                	je     14c <main+0x14c>
		switch (cmd) {
      df:	3c 62                	cmp    $0x62,%al
      e1:	0f 84 0d 01 00 00    	je     1f4 <main+0x1f4>
      e7:	7e 7f                	jle    168 <main+0x168>
      e9:	3c 66                	cmp    $0x66,%al
      eb:	0f 84 b3 00 00 00    	je     1a4 <main+0x1a4>
      f1:	3c 68                	cmp    $0x68,%al
      f3:	0f 84 c0 00 00 00    	je     1b9 <main+0x1b9>
      f9:	3c 65                	cmp    $0x65,%al
      fb:	75 c3                	jne    c0 <main+0xc0>
  if (file->curLine < TERMH_ADJ) file->curLine = TERMH_ADJ;
  char* msg = "...back 1 page";
  printpad(terminal.width, ' ', msg, LEFT, 0);
}
void scroll(struct File* file, Terminal terminal){
  file->curLine++;
      fd:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
  char* msg = "...scrolling one line";
  printpad(terminal.width, ' ', msg, LEFT, 0);
     101:	83 ec 0c             	sub    $0xc,%esp
     104:	6a 00                	push   $0x0
     106:	6a 00                	push   $0x0
     108:	68 84 22 00 00       	push   $0x2284
     10d:	6a 20                	push   $0x20
     10f:	6a 64                	push   $0x64
     111:	e8 ca 0b 00 00       	call   ce0 <printpad>
      showPage(file, terminal);
     116:	c7 45 c0 64 00 00 00 	movl   $0x64,-0x40(%ebp)
     11d:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
     124:	83 c4 20             	add    $0x20,%esp
     127:	ff 75 c4             	pushl  -0x3c(%ebp)
     12a:	ff 75 c0             	pushl  -0x40(%ebp)
     12d:	b9 06 00 00 00       	mov    $0x6,%ecx
     132:	8b 75 bc             	mov    -0x44(%ebp),%esi
  while (cmd != 'q' && cmd != 'Q') {
     135:	83 e3 df             	and    $0xffffffdf,%ebx
      showPage(file, terminal);
     138:	83 ec 18             	sub    $0x18,%esp
     13b:	89 e7                	mov    %esp,%edi
     13d:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
     13f:	e8 9c 0e 00 00       	call   fe0 <showPage>
			break;
     144:	83 c4 20             	add    $0x20,%esp
  while (cmd != 'q' && cmd != 'Q') {
     147:	80 fb 51             	cmp    $0x51,%bl
     14a:	75 80                	jne    cc <main+0xcc>
		if (cmd == '\0') exit();
     14c:	e8 b1 17 00 00       	call   1902 <exit>
    fprintf(2, "this version of more only supports one file at a time.\n");
     151:	57                   	push   %edi
     152:	57                   	push   %edi
     153:	68 94 20 00 00       	push   $0x2094
     158:	6a 02                	push   $0x2
     15a:	e8 21 1b 00 00       	call   1c80 <fprintf>
    exit();
     15f:	e8 9e 17 00 00       	call   1902 <exit>
     164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		switch (cmd) {
     168:	3c 20                	cmp    $0x20,%al
     16a:	0f 84 a5 00 00 00    	je     215 <main+0x215>
     170:	3c 3d                	cmp    $0x3d,%al
     172:	0f 85 48 ff ff ff    	jne    c0 <main+0xc0>
     178:	8b 45 d8             	mov    -0x28(%ebp),%eax
     17b:	8d 55 cb             	lea    -0x35(%ebp),%edx
     17e:	b9 0a 00 00 00       	mov    $0xa,%ecx
     183:	e8 18 01 00 00       	call   2a0 <itoa.part.2>
}
void line(File file, Terminal terminal){
  char msg[5];
  itoa(file.curLine, msg, 10);
  printpad(terminal.width, ' ', msg, LEFT, 0);
     188:	8d 45 cb             	lea    -0x35(%ebp),%eax
     18b:	83 ec 0c             	sub    $0xc,%esp
     18e:	6a 00                	push   $0x0
     190:	6a 00                	push   $0x0
     192:	50                   	push   %eax
     193:	6a 20                	push   $0x20
     195:	6a 64                	push   $0x64
     197:	e8 44 0b 00 00       	call   ce0 <printpad>
     19c:	83 c4 20             	add    $0x20,%esp
     19f:	e9 1c ff ff ff       	jmp    c0 <main+0xc0>
  printpad(terminal.width, ' ', msg, LEFT, 0);
     1a4:	83 ec 0c             	sub    $0xc,%esp
  file->curLine += (2 * TERMH_ADJ);
     1a7:	83 45 d8 30          	addl   $0x30,-0x28(%ebp)
  printpad(terminal.width, ' ', msg, LEFT, 0);
     1ab:	6a 00                	push   $0x0
     1ad:	6a 00                	push   $0x0
     1af:	68 62 22 00 00       	push   $0x2262
     1b4:	e9 54 ff ff ff       	jmp    10d <main+0x10d>
			help(terminal);
     1b9:	c7 45 c0 64 00 00 00 	movl   $0x64,-0x40(%ebp)
     1c0:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
     1c7:	8b 75 c0             	mov    -0x40(%ebp),%esi
     1ca:	8b 7d c4             	mov    -0x3c(%ebp),%edi
     1cd:	50                   	push   %eax
     1ce:	50                   	push   %eax
     1cf:	57                   	push   %edi
     1d0:	56                   	push   %esi
     1d1:	e8 4a 0d 00 00       	call   f20 <help>
      showPage(file, terminal);
     1d6:	57                   	push   %edi
     1d7:	56                   	push   %esi
     1d8:	b9 06 00 00 00       	mov    $0x6,%ecx
     1dd:	8b 75 bc             	mov    -0x44(%ebp),%esi
     1e0:	83 ec 18             	sub    $0x18,%esp
     1e3:	89 e7                	mov    %esp,%edi
     1e5:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
     1e7:	e8 f4 0d 00 00       	call   fe0 <showPage>
			break;
     1ec:	83 c4 30             	add    $0x30,%esp
     1ef:	e9 cc fe ff ff       	jmp    c0 <main+0xc0>
			back(&file, terminal);
     1f4:	c7 45 c0 64 00 00 00 	movl   $0x64,-0x40(%ebp)
     1fb:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
     202:	8b 75 c0             	mov    -0x40(%ebp),%esi
     205:	8b 7d c4             	mov    -0x3c(%ebp),%edi
     208:	52                   	push   %edx
     209:	57                   	push   %edi
     20a:	56                   	push   %esi
     20b:	ff 75 bc             	pushl  -0x44(%ebp)
     20e:	e8 5d 0c 00 00       	call   e70 <back>
     213:	eb c1                	jmp    1d6 <main+0x1d6>
  file->curLine += TERMH_ADJ;
     215:	83 45 d8 18          	addl   $0x18,-0x28(%ebp)
      showPage(file, terminal);
     219:	c7 45 c0 64 00 00 00 	movl   $0x64,-0x40(%ebp)
     220:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
     227:	e9 fb fe ff ff       	jmp    127 <main+0x127>
    fprintf(2, "more: bad usage\nTry 'more --help' for more information.\n");
     22c:	50                   	push   %eax
     22d:	50                   	push   %eax
     22e:	68 58 20 00 00       	push   $0x2058
     233:	6a 02                	push   $0x2
     235:	e8 46 1a 00 00       	call   1c80 <fprintf>
    exit();
     23a:	e8 c3 16 00 00       	call   1902 <exit>
    fprintf(2, "file could not be opened\n",  file.filename);
     23f:	53                   	push   %ebx
     240:	ff 75 d0             	pushl  -0x30(%ebp)
     243:	68 0d 23 00 00       	push   $0x230d
     248:	6a 02                	push   $0x2
     24a:	e8 31 1a 00 00       	call   1c80 <fprintf>
     24f:	8d 45 d0             	lea    -0x30(%ebp),%eax
     252:	83 c4 10             	add    $0x10,%esp
     255:	89 45 bc             	mov    %eax,-0x44(%ebp)
     258:	e9 28 fe ff ff       	jmp    85 <main+0x85>
     25d:	66 90                	xchg   %ax,%ax
     25f:	90                   	nop

00000260 <safestrcpy.part.0>:
  char *os;

  os = s;
  if(n <= 0)
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
     260:	83 e9 01             	sub    $0x1,%ecx
     263:	85 c9                	test   %ecx,%ecx
     265:	7e 29                	jle    290 <safestrcpy.part.0+0x30>
safestrcpy(char *s, const char *t, int n) 
     267:	55                   	push   %ebp
     268:	89 e5                	mov    %esp,%ebp
     26a:	53                   	push   %ebx
     26b:	eb 0a                	jmp    277 <safestrcpy.part.0+0x17>
     26d:	8d 76 00             	lea    0x0(%esi),%esi
  while(--n > 0 && (*s++ = *t++) != 0)
     270:	83 e9 01             	sub    $0x1,%ecx
     273:	85 c9                	test   %ecx,%ecx
     275:	7e 11                	jle    288 <safestrcpy.part.0+0x28>
     277:	83 c2 01             	add    $0x1,%edx
     27a:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
     27e:	83 c0 01             	add    $0x1,%eax
     281:	84 db                	test   %bl,%bl
     283:	88 58 ff             	mov    %bl,-0x1(%eax)
     286:	75 e8                	jne    270 <safestrcpy.part.0+0x10>
    ;
  *s = 0;
  return os;
}
     288:	5b                   	pop    %ebx
  *s = 0;
     289:	c6 00 00             	movb   $0x0,(%eax)
}
     28c:	5d                   	pop    %ebp
     28d:	c3                   	ret    
     28e:	66 90                	xchg   %ax,%ax
  *s = 0;
     290:	c6 00 00             	movb   $0x0,(%eax)
     293:	c3                   	ret    
     294:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     29a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002a0 <itoa.part.2>:
/**
 * C++ version 0.4 char* style "itoa":
 * Written by Lukás Chmela
 * Released under GPLv3.
 */
char* itoa(int value, char* result, int base) {
     2a0:	55                   	push   %ebp
     2a1:	89 e5                	mov    %esp,%ebp
     2a3:	57                   	push   %edi
     2a4:	56                   	push   %esi
     2a5:	53                   	push   %ebx
     2a6:	89 c6                	mov    %eax,%esi
     2a8:	89 c8                	mov    %ecx,%eax
     2aa:	89 c3                	mov    %eax,%ebx
     2ac:	89 d1                	mov    %edx,%ecx
     2ae:	83 ec 04             	sub    $0x4,%esp
     2b1:	89 55 f0             	mov    %edx,-0x10(%ebp)
     2b4:	eb 0e                	jmp    2c4 <itoa.part.2+0x24>
     2b6:	8d 76 00             	lea    0x0(%esi),%esi
     2b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

    do {
        tmp_value = value;
        value /= base;
        *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" [35 + (tmp_value - value * base)];
    } while ( value );
     2c0:	89 f9                	mov    %edi,%ecx
     2c2:	89 c6                	mov    %eax,%esi
     2c4:	89 f0                	mov    %esi,%eax
        *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" [35 + (tmp_value - value * base)];
     2c6:	8d 79 01             	lea    0x1(%ecx),%edi
     2c9:	99                   	cltd   
     2ca:	f7 fb                	idiv   %ebx
     2cc:	0f b6 92 6b 1e 00 00 	movzbl 0x1e6b(%edx),%edx
    } while ( value );
     2d3:	85 c0                	test   %eax,%eax
        *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" [35 + (tmp_value - value * base)];
     2d5:	88 57 ff             	mov    %dl,-0x1(%edi)
    } while ( value );
     2d8:	75 e6                	jne    2c0 <itoa.part.2+0x20>

    // Apply negative sign
    if (tmp_value < 0) *ptr++ = '-';
     2da:	85 f6                	test   %esi,%esi
     2dc:	8b 5d f0             	mov    -0x10(%ebp),%ebx
     2df:	79 07                	jns    2e8 <itoa.part.2+0x48>
     2e1:	8d 79 02             	lea    0x2(%ecx),%edi
     2e4:	c6 41 01 2d          	movb   $0x2d,0x1(%ecx)
    *ptr-- = '\0';
     2e8:	8d 47 ff             	lea    -0x1(%edi),%eax
     2eb:	c6 07 00             	movb   $0x0,(%edi)
    while(ptr1 < ptr) {
     2ee:	39 d8                	cmp    %ebx,%eax
     2f0:	76 1c                	jbe    30e <itoa.part.2+0x6e>
     2f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tmp_char = *ptr;
     2f8:	0f b6 10             	movzbl (%eax),%edx
        *ptr--= *ptr1;
     2fb:	0f b6 0b             	movzbl (%ebx),%ecx
     2fe:	83 e8 01             	sub    $0x1,%eax
        *ptr1++ = tmp_char;
     301:	83 c3 01             	add    $0x1,%ebx
    while(ptr1 < ptr) {
     304:	39 d8                	cmp    %ebx,%eax
        *ptr--= *ptr1;
     306:	88 48 01             	mov    %cl,0x1(%eax)
        *ptr1++ = tmp_char;
     309:	88 53 ff             	mov    %dl,-0x1(%ebx)
    while(ptr1 < ptr) {
     30c:	77 ea                	ja     2f8 <itoa.part.2+0x58>
    }
    return result;
}
     30e:	83 c4 04             	add    $0x4,%esp
     311:	5b                   	pop    %ebx
     312:	5e                   	pop    %esi
     313:	5f                   	pop    %edi
     314:	5d                   	pop    %ebp
     315:	c3                   	ret    
     316:	8d 76 00             	lea    0x0(%esi),%esi
     319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000320 <getLine>:
int getLine(int fileptr, char line[]) {
     320:	55                   	push   %ebp
     321:	89 e5                	mov    %esp,%ebp
     323:	57                   	push   %edi
     324:	56                   	push   %esi
     325:	53                   	push   %ebx
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     326:	31 ff                	xor    %edi,%edi
     328:	8d 75 e7             	lea    -0x19(%ebp),%esi
int getLine(int fileptr, char line[]) {
     32b:	83 ec 28             	sub    $0x28,%esp
     32e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int len = strlen(line);
     331:	53                   	push   %ebx
     332:	e8 f9 13 00 00       	call   1730 <strlen>
  memset(line, 0, len);
     337:	83 c4 0c             	add    $0xc,%esp
     33a:	50                   	push   %eax
     33b:	6a 00                	push   $0x0
     33d:	53                   	push   %ebx
     33e:	e8 1d 14 00 00       	call   1760 <memset>
     343:	83 c4 10             	add    $0x10,%esp
     346:	eb 1e                	jmp    366 <getLine+0x46>
     348:	90                   	nop
     349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (*c == '\n') break;
     350:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     354:	3c 0a                	cmp    $0xa,%al
     356:	74 38                	je     390 <getLine+0x70>
    line[i] = *c;
     358:	88 04 3b             	mov    %al,(%ebx,%edi,1)
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     35b:	83 c7 01             	add    $0x1,%edi
     35e:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
     364:	74 42                	je     3a8 <getLine+0x88>
    if (read(fileptr, c, 1) == 0) return strlen(line);
     366:	83 ec 04             	sub    $0x4,%esp
     369:	6a 01                	push   $0x1
     36b:	56                   	push   %esi
     36c:	ff 75 08             	pushl  0x8(%ebp)
     36f:	e8 a6 15 00 00       	call   191a <read>
     374:	83 c4 10             	add    $0x10,%esp
     377:	85 c0                	test   %eax,%eax
     379:	75 d5                	jne    350 <getLine+0x30>
     37b:	83 ec 0c             	sub    $0xc,%esp
     37e:	53                   	push   %ebx
     37f:	e8 ac 13 00 00       	call   1730 <strlen>
     384:	83 c4 10             	add    $0x10,%esp
}
     387:	8d 65 f4             	lea    -0xc(%ebp),%esp
     38a:	5b                   	pop    %ebx
     38b:	5e                   	pop    %esi
     38c:	5f                   	pop    %edi
     38d:	5d                   	pop    %ebp
     38e:	c3                   	ret    
     38f:	90                   	nop
     390:	8d 57 01             	lea    0x1(%edi),%edx
  line[i + 1] = '\0';
     393:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
     397:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
     39a:	b8 01 00 00 00       	mov    $0x1,%eax
}
     39f:	5b                   	pop    %ebx
     3a0:	5e                   	pop    %esi
     3a1:	5f                   	pop    %edi
     3a2:	5d                   	pop    %ebp
     3a3:	c3                   	ret    
     3a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     3a8:	ba e8 03 00 00       	mov    $0x3e8,%edx
     3ad:	eb e4                	jmp    393 <getLine+0x73>
     3af:	90                   	nop

000003b0 <find>:
int find(char* str, char c) {
     3b0:	55                   	push   %ebp
     3b1:	89 e5                	mov    %esp,%ebp
     3b3:	57                   	push   %edi
     3b4:	56                   	push   %esi
     3b5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     3b6:	31 db                	xor    %ebx,%ebx
int find(char* str, char c) {
     3b8:	83 ec 0c             	sub    $0xc,%esp
     3bb:	8b 75 08             	mov    0x8(%ebp),%esi
     3be:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
  for (int i = 0; i < strlen(str); i++)
     3c2:	eb 0e                	jmp    3d2 <find+0x22>
     3c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     3c8:	89 f8                	mov    %edi,%eax
     3ca:	38 04 1e             	cmp    %al,(%esi,%ebx,1)
     3cd:	74 18                	je     3e7 <find+0x37>
  for (int i = 0; i < strlen(str); i++)
     3cf:	83 c3 01             	add    $0x1,%ebx
     3d2:	83 ec 0c             	sub    $0xc,%esp
     3d5:	56                   	push   %esi
     3d6:	e8 55 13 00 00       	call   1730 <strlen>
     3db:	83 c4 10             	add    $0x10,%esp
     3de:	39 d8                	cmp    %ebx,%eax
     3e0:	77 e6                	ja     3c8 <find+0x18>
  return -1;
     3e2:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
     3e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     3ea:	89 d8                	mov    %ebx,%eax
     3ec:	5b                   	pop    %ebx
     3ed:	5e                   	pop    %esi
     3ee:	5f                   	pop    %edi
     3ef:	5d                   	pop    %ebp
     3f0:	c3                   	ret    
     3f1:	eb 0d                	jmp    400 <substr>
     3f3:	90                   	nop
     3f4:	90                   	nop
     3f5:	90                   	nop
     3f6:	90                   	nop
     3f7:	90                   	nop
     3f8:	90                   	nop
     3f9:	90                   	nop
     3fa:	90                   	nop
     3fb:	90                   	nop
     3fc:	90                   	nop
     3fd:	90                   	nop
     3fe:	90                   	nop
     3ff:	90                   	nop

00000400 <substr>:
void substr(char* dest, char* str, int start, int end) {
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	57                   	push   %edi
     404:	56                   	push   %esi
     405:	53                   	push   %ebx
     406:	83 ec 18             	sub    $0x18,%esp
     409:	8b 7d 14             	mov    0x14(%ebp),%edi
  int len = strlen(str);
     40c:	ff 75 0c             	pushl  0xc(%ebp)
void substr(char* dest, char* str, int start, int end) {
     40f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     412:	8b 75 08             	mov    0x8(%ebp),%esi
  int len = strlen(str);
     415:	e8 16 13 00 00       	call   1730 <strlen>
     41a:	83 c4 10             	add    $0x10,%esp
     41d:	39 f8                	cmp    %edi,%eax
     41f:	0f 4e f8             	cmovle %eax,%edi
  while (i < end)
     422:	39 df                	cmp    %ebx,%edi
     424:	7e 1c                	jle    442 <substr+0x42>
     426:	8b 45 0c             	mov    0xc(%ebp),%eax
     429:	29 df                	sub    %ebx,%edi
  int s = 0, i = start;
     42b:	31 d2                	xor    %edx,%edx
     42d:	01 c3                	add    %eax,%ebx
     42f:	90                   	nop
    dest[s++] = str[i++];
     430:	83 c2 01             	add    $0x1,%edx
     433:	0f b6 44 13 ff       	movzbl -0x1(%ebx,%edx,1),%eax
  while (i < end)
     438:	39 fa                	cmp    %edi,%edx
    dest[s++] = str[i++];
     43a:	88 44 16 ff          	mov    %al,-0x1(%esi,%edx,1)
  while (i < end)
     43e:	75 f0                	jne    430 <substr+0x30>
     440:	01 d6                	add    %edx,%esi
  dest[s] = '\0';
     442:	c6 06 00             	movb   $0x0,(%esi)
}
     445:	8d 65 f4             	lea    -0xc(%ebp),%esp
     448:	5b                   	pop    %ebx
     449:	5e                   	pop    %esi
     44a:	5f                   	pop    %edi
     44b:	5d                   	pop    %ebp
     44c:	c3                   	ret    
     44d:	8d 76 00             	lea    0x0(%esi),%esi

00000450 <safestrcpy>:
{
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	53                   	push   %ebx
     454:	8b 4d 10             	mov    0x10(%ebp),%ecx
     457:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(n <= 0)
     45a:	85 c9                	test   %ecx,%ecx
     45c:	7e 0a                	jle    468 <safestrcpy+0x18>
     45e:	8b 55 0c             	mov    0xc(%ebp),%edx
     461:	89 d8                	mov    %ebx,%eax
     463:	e8 f8 fd ff ff       	call   260 <safestrcpy.part.0>
}
     468:	89 d8                	mov    %ebx,%eax
     46a:	5b                   	pop    %ebx
     46b:	5d                   	pop    %ebp
     46c:	c3                   	ret    
     46d:	8d 76 00             	lea    0x0(%esi),%esi

00000470 <negatoi>:
int negatoi(char* str) {
     470:	55                   	push   %ebp
     471:	89 e5                	mov    %esp,%ebp
     473:	53                   	push   %ebx
     474:	83 ec 04             	sub    $0x4,%esp
     477:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (str[0] == '-') {
     47a:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     47d:	74 11                	je     490 <negatoi+0x20>
}
     47f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     482:	c9                   	leave  
  return atoi(str);
     483:	e9 08 14 00 00       	jmp    1890 <atoi>
     488:	90                   	nop
     489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    substr(str, str, 1, strlen(str));
     490:	83 ec 0c             	sub    $0xc,%esp
     493:	53                   	push   %ebx
     494:	e8 97 12 00 00       	call   1730 <strlen>
     499:	50                   	push   %eax
     49a:	6a 01                	push   $0x1
     49c:	53                   	push   %ebx
     49d:	53                   	push   %ebx
     49e:	e8 5d ff ff ff       	call   400 <substr>
    return 0 - atoi(str);
     4a3:	83 c4 14             	add    $0x14,%esp
     4a6:	53                   	push   %ebx
     4a7:	e8 e4 13 00 00       	call   1890 <atoi>
     4ac:	83 c4 10             	add    $0x10,%esp
     4af:	f7 d8                	neg    %eax
}
     4b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4b4:	c9                   	leave  
     4b5:	c3                   	ret    
     4b6:	8d 76 00             	lea    0x0(%esi),%esi
     4b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004c0 <itoa>:
char* itoa(int value, char* result, int base) {
     4c0:	55                   	push   %ebp
     4c1:	89 e5                	mov    %esp,%ebp
     4c3:	53                   	push   %ebx
     4c4:	8b 4d 10             	mov    0x10(%ebp),%ecx
     4c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    if (base < 2 || base > 36) { *result = '\0'; return result; }
     4ca:	8d 41 fe             	lea    -0x2(%ecx),%eax
     4cd:	83 f8 22             	cmp    $0x22,%eax
     4d0:	77 16                	ja     4e8 <itoa+0x28>
     4d2:	8b 45 08             	mov    0x8(%ebp),%eax
     4d5:	89 da                	mov    %ebx,%edx
     4d7:	e8 c4 fd ff ff       	call   2a0 <itoa.part.2>
}
     4dc:	89 d8                	mov    %ebx,%eax
     4de:	5b                   	pop    %ebx
     4df:	5d                   	pop    %ebp
     4e0:	c3                   	ret    
     4e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (base < 2 || base > 36) { *result = '\0'; return result; }
     4e8:	c6 03 00             	movb   $0x0,(%ebx)
}
     4eb:	89 d8                	mov    %ebx,%eax
     4ed:	5b                   	pop    %ebx
     4ee:	5d                   	pop    %ebp
     4ef:	c3                   	ret    

000004f0 <toUpper>:

void toUpper(char* str) {
     4f0:	55                   	push   %ebp
     4f1:	89 e5                	mov    %esp,%ebp
     4f3:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     4f6:	0f b6 02             	movzbl (%edx),%eax
     4f9:	84 c0                	test   %al,%al
     4fb:	74 1a                	je     517 <toUpper+0x27>
     4fd:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'z' && c >= 'a')
     500:	8d 48 9f             	lea    -0x61(%eax),%ecx
     503:	80 f9 19             	cmp    $0x19,%cl
     506:	77 05                	ja     50d <toUpper+0x1d>
      str[i] += ('Z' - 'z');
     508:	83 e8 20             	sub    $0x20,%eax
     50b:	88 02                	mov    %al,(%edx)
     50d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     510:	0f b6 02             	movzbl (%edx),%eax
     513:	84 c0                	test   %al,%al
     515:	75 e9                	jne    500 <toUpper+0x10>
    i++;  
  }
}
     517:	5d                   	pop    %ebp
     518:	c3                   	ret    
     519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000520 <toLower>:

void toLower(char* str) {
     520:	55                   	push   %ebp
     521:	89 e5                	mov    %esp,%ebp
     523:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     526:	0f b6 02             	movzbl (%edx),%eax
     529:	84 c0                	test   %al,%al
     52b:	74 1a                	je     547 <toLower+0x27>
     52d:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'Z' && c >= 'A')
     530:	8d 48 bf             	lea    -0x41(%eax),%ecx
     533:	80 f9 19             	cmp    $0x19,%cl
     536:	77 05                	ja     53d <toLower+0x1d>
      str[i] -= ('Z' - 'z');
     538:	83 c0 20             	add    $0x20,%eax
     53b:	88 02                	mov    %al,(%edx)
     53d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     540:	0f b6 02             	movzbl (%edx),%eax
     543:	84 c0                	test   %al,%al
     545:	75 e9                	jne    530 <toLower+0x10>
    i++;  
  }
}
     547:	5d                   	pop    %ebp
     548:	c3                   	ret    
     549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000550 <nullNode>:
#include "LinkedList.h"
// #include "helpers.h"
#define nullptr 0
// prototypes

Node* nullNode(char* data) {
     550:	55                   	push   %ebp
     551:	89 e5                	mov    %esp,%ebp
     553:	83 ec 14             	sub    $0x14,%esp
  struct Node* node = malloc(sizeof(Node));
     556:	6a 0c                	push   $0xc
     558:	e8 f3 17 00 00       	call   1d50 <malloc>
  node->prev = nullptr;
  node->data = data;
     55d:	8b 55 08             	mov    0x8(%ebp),%edx
  node->prev = nullptr;
     560:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->next = nullptr;
     566:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  node->data = data;
     56d:	89 50 04             	mov    %edx,0x4(%eax)
  return node;
}
     570:	c9                   	leave  
     571:	c3                   	ret    
     572:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000580 <nodeAt>:

Node* nodeAt(struct LinkedList* list, int pos) {
     580:	55                   	push   %ebp
     581:	89 e5                	mov    %esp,%ebp
     583:	53                   	push   %ebx
     584:	8b 45 08             	mov    0x8(%ebp),%eax
     587:	8b 55 0c             	mov    0xc(%ebp),%edx
  // for anything past the end:
  if (pos > list->len)
     58a:	8b 48 08             	mov    0x8(%eax),%ecx
     58d:	39 d1                	cmp    %edx,%ecx
     58f:	7c 1f                	jl     5b0 <nodeAt+0x30>
    return list->tail->prev;
  // for anything before the beginning:
  if ((pos < 0) && ((0 - pos) > list->len))
     591:	85 d2                	test   %edx,%edx
     593:	78 2b                	js     5c0 <nodeAt+0x40>
    while (++pos != 0)
      curNode = curNode->prev;
  } // start looking from front
  else {
    int cur = 0;
    curNode = list->head->next;
     595:	8b 00                	mov    (%eax),%eax
     597:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     59a:	74 0e                	je     5aa <nodeAt+0x2a>
    int cur = 0;
     59c:	31 c9                	xor    %ecx,%ecx
     59e:	66 90                	xchg   %ax,%ax
      curNode = curNode->next;
      cur++;
     5a0:	83 c1 01             	add    $0x1,%ecx
      curNode = curNode->next;
     5a3:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     5a6:	39 ca                	cmp    %ecx,%edx
     5a8:	75 f6                	jne    5a0 <nodeAt+0x20>
    }
  }
  return curNode;
}
     5aa:	5b                   	pop    %ebx
     5ab:	5d                   	pop    %ebp
     5ac:	c3                   	ret    
     5ad:	8d 76 00             	lea    0x0(%esi),%esi
    return list->tail->prev;
     5b0:	8b 40 04             	mov    0x4(%eax),%eax
}
     5b3:	5b                   	pop    %ebx
     5b4:	5d                   	pop    %ebp
    return list->tail->prev;
     5b5:	8b 00                	mov    (%eax),%eax
}
     5b7:	c3                   	ret    
     5b8:	90                   	nop
     5b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if ((pos < 0) && ((0 - pos) > list->len))
     5c0:	89 d3                	mov    %edx,%ebx
     5c2:	f7 db                	neg    %ebx
     5c4:	39 d9                	cmp    %ebx,%ecx
     5c6:	7c 18                	jl     5e0 <nodeAt+0x60>
    while (++pos != 0)
     5c8:	83 c2 01             	add    $0x1,%edx
    curNode = list->tail;
     5cb:	8b 40 04             	mov    0x4(%eax),%eax
    while (++pos != 0)
     5ce:	74 da                	je     5aa <nodeAt+0x2a>
     5d0:	83 c2 01             	add    $0x1,%edx
      curNode = curNode->prev;
     5d3:	8b 00                	mov    (%eax),%eax
    while (++pos != 0)
     5d5:	75 f9                	jne    5d0 <nodeAt+0x50>
}
     5d7:	5b                   	pop    %ebx
     5d8:	5d                   	pop    %ebp
     5d9:	c3                   	ret    
     5da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return list->head->next;
     5e0:	8b 00                	mov    (%eax),%eax
     5e2:	8b 40 08             	mov    0x8(%eax),%eax
     5e5:	eb c3                	jmp    5aa <nodeAt+0x2a>
     5e7:	89 f6                	mov    %esi,%esi
     5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005f0 <destroyNode>:

void destroyNode(struct LinkedList* list, struct Node* self) {
     5f0:	55                   	push   %ebp
     5f1:	89 e5                	mov    %esp,%ebp
     5f3:	56                   	push   %esi
     5f4:	53                   	push   %ebx
     5f5:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     5f8:	8b 75 08             	mov    0x8(%ebp),%esi
    self->prev->next = self->next;
    self->next->prev = self->prev;

    free(self->data);
     5fb:	83 ec 0c             	sub    $0xc,%esp
    self->prev->next = self->next;
     5fe:	8b 03                	mov    (%ebx),%eax
     600:	8b 53 08             	mov    0x8(%ebx),%edx
     603:	89 50 08             	mov    %edx,0x8(%eax)
    self->next->prev = self->prev;
     606:	8b 43 08             	mov    0x8(%ebx),%eax
     609:	8b 13                	mov    (%ebx),%edx
     60b:	89 10                	mov    %edx,(%eax)
    free(self->data);
     60d:	ff 73 04             	pushl  0x4(%ebx)
     610:	e8 ab 16 00 00       	call   1cc0 <free>
    free(self);
     615:	89 1c 24             	mov    %ebx,(%esp)
     618:	e8 a3 16 00 00       	call   1cc0 <free>
    list->len--;
     61d:	83 6e 08 01          	subl   $0x1,0x8(%esi)
}
     621:	83 c4 10             	add    $0x10,%esp
     624:	8d 65 f8             	lea    -0x8(%ebp),%esp
     627:	5b                   	pop    %ebx
     628:	5e                   	pop    %esi
     629:	5d                   	pop    %ebp
     62a:	c3                   	ret    
     62b:	90                   	nop
     62c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000630 <MakeLinkedList>:

LinkedList* MakeLinkedList() {
     630:	55                   	push   %ebp
     631:	89 e5                	mov    %esp,%ebp
     633:	56                   	push   %esi
     634:	53                   	push   %ebx
  struct LinkedList* list = malloc(sizeof(LinkedList));
     635:	83 ec 0c             	sub    $0xc,%esp
     638:	6a 0c                	push   $0xc
     63a:	e8 11 17 00 00       	call   1d50 <malloc>
  struct Node* node = malloc(sizeof(Node));
     63f:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  struct LinkedList* list = malloc(sizeof(LinkedList));
     646:	89 c6                	mov    %eax,%esi
  struct Node* node = malloc(sizeof(Node));
     648:	e8 03 17 00 00       	call   1d50 <malloc>
     64d:	89 c3                	mov    %eax,%ebx
  node->prev = nullptr;
     64f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->data = data;
     655:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  node->next = nullptr;
     65c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  struct Node* node = malloc(sizeof(Node));
     663:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     66a:	e8 e1 16 00 00       	call   1d50 <malloc>
  node->data = data;
     66f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  Node* head = nullNode(nullptr);
  Node* tail = nullNode(nullptr);
  head->prev = nullptr;
  head->next = tail;
     676:	89 43 08             	mov    %eax,0x8(%ebx)
  head->prev = nullptr;
     679:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  tail->prev = head;
     67f:	89 18                	mov    %ebx,(%eax)
  tail->next = nullptr;
     681:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)

  list->len = 0;
  list->head = head;
  list->tail = tail;
     688:	89 46 04             	mov    %eax,0x4(%esi)
  return list;
}
     68b:	89 f0                	mov    %esi,%eax
  list->len = 0;
     68d:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
  list->head = head;
     694:	89 1e                	mov    %ebx,(%esi)
}
     696:	8d 65 f8             	lea    -0x8(%ebp),%esp
     699:	5b                   	pop    %ebx
     69a:	5e                   	pop    %esi
     69b:	5d                   	pop    %ebp
     69c:	c3                   	ret    
     69d:	8d 76 00             	lea    0x0(%esi),%esi

000006a0 <insert>:

void insert(struct LinkedList* list, char* data, int pos) {
     6a0:	55                   	push   %ebp
     6a1:	89 e5                	mov    %esp,%ebp
     6a3:	57                   	push   %edi
     6a4:	56                   	push   %esi
     6a5:	53                   	push   %ebx
     6a6:	83 ec 0c             	sub    $0xc,%esp
     6a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct Node* atPos = nodeAt(list, pos);
     6ac:	ff 75 10             	pushl  0x10(%ebp)
     6af:	53                   	push   %ebx
     6b0:	e8 cb fe ff ff       	call   580 <nodeAt>
     6b5:	83 ec 04             	sub    $0x4,%esp
     6b8:	89 c6                	mov    %eax,%esi
  char* newData = (char*)malloc(sizeof(char) * 1000);
     6ba:	68 e8 03 00 00       	push   $0x3e8
     6bf:	e8 8c 16 00 00       	call   1d50 <malloc>
     6c4:	8b 55 0c             	mov    0xc(%ebp),%edx
     6c7:	89 c7                	mov    %eax,%edi
     6c9:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
     6ce:	e8 8d fb ff ff       	call   260 <safestrcpy.part.0>
  newData = safestrcpy(newData, data, (sizeof(char) * 1000));
  struct Node* new = malloc(sizeof(Node));
     6d3:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     6da:	e8 71 16 00 00       	call   1d50 <malloc>

  new->data = newData;
     6df:	89 78 04             	mov    %edi,0x4(%eax)
  new->prev = atPos->prev;
     6e2:	8b 16                	mov    (%esi),%edx
  new->next = atPos;
  new->prev->next = new;
  atPos->prev = new;
  list->len++;
}
     6e4:	83 c4 10             	add    $0x10,%esp
  new->next = atPos;
     6e7:	89 70 08             	mov    %esi,0x8(%eax)
  new->prev = atPos->prev;
     6ea:	89 10                	mov    %edx,(%eax)
  new->prev->next = new;
     6ec:	89 42 08             	mov    %eax,0x8(%edx)
  atPos->prev = new;
     6ef:	89 06                	mov    %eax,(%esi)
  list->len++;
     6f1:	83 43 08 01          	addl   $0x1,0x8(%ebx)
}
     6f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6f8:	5b                   	pop    %ebx
     6f9:	5e                   	pop    %esi
     6fa:	5f                   	pop    %edi
     6fb:	5d                   	pop    %ebp
     6fc:	c3                   	ret    
     6fd:	8d 76 00             	lea    0x0(%esi),%esi

00000700 <prepend>:

void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
     700:	55                   	push   %ebp
     701:	89 e5                	mov    %esp,%ebp
     703:	83 ec 0c             	sub    $0xc,%esp
     706:	6a 00                	push   $0x0
     708:	ff 75 0c             	pushl  0xc(%ebp)
     70b:	ff 75 08             	pushl  0x8(%ebp)
     70e:	e8 8d ff ff ff       	call   6a0 <insert>
     713:	83 c4 10             	add    $0x10,%esp
     716:	c9                   	leave  
     717:	c3                   	ret    
     718:	90                   	nop
     719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000720 <append>:
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     720:	55                   	push   %ebp
     721:	89 e5                	mov    %esp,%ebp
     723:	83 ec 0c             	sub    $0xc,%esp
     726:	8b 45 08             	mov    0x8(%ebp),%eax
     729:	ff 70 08             	pushl  0x8(%eax)
     72c:	ff 75 0c             	pushl  0xc(%ebp)
     72f:	50                   	push   %eax
     730:	e8 6b ff ff ff       	call   6a0 <insert>
     735:	83 c4 10             	add    $0x10,%esp
     738:	c9                   	leave  
     739:	c3                   	ret    
     73a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000740 <destroyLinkedList>:

void destroyLinkedList(struct LinkedList* list) {
     740:	55                   	push   %ebp
     741:	89 e5                	mov    %esp,%ebp
     743:	56                   	push   %esi
     744:	53                   	push   %ebx
     745:	8b 75 08             	mov    0x8(%ebp),%esi
  struct Node* curNode = list->head;
     748:	8b 1e                	mov    (%esi),%ebx
  while (curNode != list->tail) {
     74a:	8b 46 04             	mov    0x4(%esi),%eax
     74d:	39 c3                	cmp    %eax,%ebx
     74f:	74 29                	je     77a <destroyLinkedList+0x3a>
     751:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
     758:	8b 5b 08             	mov    0x8(%ebx),%ebx
    free(curNode->prev->data);
     75b:	83 ec 0c             	sub    $0xc,%esp
     75e:	8b 03                	mov    (%ebx),%eax
     760:	ff 70 04             	pushl  0x4(%eax)
     763:	e8 58 15 00 00       	call   1cc0 <free>
    free(curNode->prev);
     768:	58                   	pop    %eax
     769:	ff 33                	pushl  (%ebx)
     76b:	e8 50 15 00 00       	call   1cc0 <free>
  while (curNode != list->tail) {
     770:	8b 46 04             	mov    0x4(%esi),%eax
     773:	83 c4 10             	add    $0x10,%esp
     776:	39 d8                	cmp    %ebx,%eax
     778:	75 de                	jne    758 <destroyLinkedList+0x18>
  }
  free(curNode);
     77a:	83 ec 0c             	sub    $0xc,%esp
     77d:	50                   	push   %eax
     77e:	e8 3d 15 00 00       	call   1cc0 <free>
  free(list);
     783:	89 75 08             	mov    %esi,0x8(%ebp)
     786:	83 c4 10             	add    $0x10,%esp
     789:	8d 65 f8             	lea    -0x8(%ebp),%esp
     78c:	5b                   	pop    %ebx
     78d:	5e                   	pop    %esi
     78e:	5d                   	pop    %ebp
  free(list);
     78f:	e9 2c 15 00 00       	jmp    1cc0 <free>
     794:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     79a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000007a0 <confirmation>:
// line-oriented text helpers
#include "textEditHelpers.h"

int confirmation() {
     7a0:	55                   	push   %ebp
     7a1:	89 e5                	mov    %esp,%ebp
     7a3:	53                   	push   %ebx
  // get response
  char buf[MAXLINESIZE];
  int nbuf = sizeof(buf);
  memset(buf, 0, nbuf);
     7a4:	8d 9d 10 fc ff ff    	lea    -0x3f0(%ebp),%ebx
int confirmation() {
     7aa:	81 ec f8 03 00 00    	sub    $0x3f8,%esp
  memset(buf, 0, nbuf);
     7b0:	68 e8 03 00 00       	push   $0x3e8
     7b5:	6a 00                	push   $0x0
     7b7:	53                   	push   %ebx
     7b8:	e8 a3 0f 00 00       	call   1760 <memset>
  gets(buf, nbuf);
     7bd:	58                   	pop    %eax
     7be:	5a                   	pop    %edx
     7bf:	68 e8 03 00 00       	push   $0x3e8
     7c4:	53                   	push   %ebx
     7c5:	e8 f6 0f 00 00       	call   17c0 <gets>
  // determine output
  switch (buf[0]) {
     7ca:	0f b6 85 10 fc ff ff 	movzbl -0x3f0(%ebp),%eax
     7d1:	83 c4 10             	add    $0x10,%esp
     7d4:	3c 59                	cmp    $0x59,%al
     7d6:	74 18                	je     7f0 <confirmation+0x50>
     7d8:	3c 79                	cmp    $0x79,%al
     7da:	74 14                	je     7f0 <confirmation+0x50>
  case 'Y':
  case 'y':
    return 0;
  default:
    return 1;
     7dc:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
     7e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7e4:	c9                   	leave  
     7e5:	c3                   	ret    
     7e6:	8d 76 00             	lea    0x0(%esi),%esi
     7e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return 0;
     7f0:	31 c0                	xor    %eax,%eax
}
     7f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7f5:	c9                   	leave  
     7f6:	c3                   	ret    
     7f7:	89 f6                	mov    %esi,%esi
     7f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000800 <normalizeRange>:
    return 1;

  return 0;
}

int normalizeRange(File file, int* sp, int* ep) {
     800:	55                   	push   %ebp
     801:	89 e5                	mov    %esp,%ebp
     803:	53                   	push   %ebx
     804:	8b 4d 24             	mov    0x24(%ebp),%ecx
  int l = file.len;
     807:	8b 45 18             	mov    0x18(%ebp),%eax
int normalizeRange(File file, int* sp, int* ep) {
     80a:	8b 5d 20             	mov    0x20(%ebp),%ebx
  if (*ep > l) *ep = l;
     80d:	8b 11                	mov    (%ecx),%edx
     80f:	39 c2                	cmp    %eax,%edx
     811:	7e 45                	jle    858 <normalizeRange+0x58>
     813:	89 01                	mov    %eax,(%ecx)
     815:	89 c2                	mov    %eax,%edx
  else if (*ep < 1) *ep += l + 1;
  if (*ep < 1) *ep = 1;
     817:	85 d2                	test   %edx,%edx
     819:	7f 06                	jg     821 <normalizeRange+0x21>
     81b:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)

  if (*sp > l) *sp = l;
     821:	8b 13                	mov    (%ebx),%edx
     823:	39 c2                	cmp    %eax,%edx
     825:	7e 21                	jle    848 <normalizeRange+0x48>
     827:	89 03                	mov    %eax,(%ebx)
     829:	89 c2                	mov    %eax,%edx
  else if (*sp < 1) *sp += l + 1;
  if (*sp < 1) *sp = 1;
     82b:	85 d2                	test   %edx,%edx
     82d:	7f 0b                	jg     83a <normalizeRange+0x3a>
     82f:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
     835:	ba 01 00 00 00       	mov    $0x1,%edx
  if ((*ep - *sp) < 0)
     83a:	8b 01                	mov    (%ecx),%eax
    return 1;
  return 0;
}
     83c:	5b                   	pop    %ebx
     83d:	5d                   	pop    %ebp
  if ((*ep - *sp) < 0)
     83e:	29 d0                	sub    %edx,%eax
     840:	c1 e8 1f             	shr    $0x1f,%eax
}
     843:	c3                   	ret    
     844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*sp < 1) *sp += l + 1;
     848:	85 d2                	test   %edx,%edx
     84a:	7f ee                	jg     83a <normalizeRange+0x3a>
     84c:	8d 54 10 01          	lea    0x1(%eax,%edx,1),%edx
     850:	89 13                	mov    %edx,(%ebx)
     852:	eb d7                	jmp    82b <normalizeRange+0x2b>
     854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*ep < 1) *ep += l + 1;
     858:	85 d2                	test   %edx,%edx
     85a:	7f c5                	jg     821 <normalizeRange+0x21>
     85c:	8d 54 02 01          	lea    0x1(%edx,%eax,1),%edx
     860:	89 11                	mov    %edx,(%ecx)
     862:	eb b3                	jmp    817 <normalizeRange+0x17>
     864:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     86a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000870 <numLines>:

int numLines(int start, int end) {
     870:	55                   	push   %ebp
     871:	89 e5                	mov    %esp,%ebp
  return (end - start) + 1;
     873:	8b 45 0c             	mov    0xc(%ebp),%eax
     876:	2b 45 08             	sub    0x8(%ebp),%eax
}
     879:	5d                   	pop    %ebp
  return (end - start) + 1;
     87a:	83 c0 01             	add    $0x1,%eax
}
     87d:	c3                   	ret    
     87e:	66 90                	xchg   %ax,%ax

00000880 <gatherLines>:

// text
void gatherLines(File* file) {
     880:	55                   	push   %ebp
     881:	89 e5                	mov    %esp,%ebp
     883:	56                   	push   %esi
     884:	53                   	push   %ebx
     885:	8d b5 10 fc ff ff    	lea    -0x3f0(%ebp),%esi
     88b:	81 ec f0 03 00 00    	sub    $0x3f0,%esp
     891:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char line[MAXLINESIZE];
  while (getLine(file->fd, line)) {
     894:	eb 21                	jmp    8b7 <gatherLines+0x37>
     896:	8d 76 00             	lea    0x0(%esi),%esi
     899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    append(file->lines, line);
     8a0:	8b 43 0c             	mov    0xc(%ebx),%eax
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     8a3:	83 ec 04             	sub    $0x4,%esp
     8a6:	ff 70 08             	pushl  0x8(%eax)
     8a9:	56                   	push   %esi
     8aa:	50                   	push   %eax
     8ab:	e8 f0 fd ff ff       	call   6a0 <insert>
    file->len++;
     8b0:	83 43 10 01          	addl   $0x1,0x10(%ebx)
     8b4:	83 c4 10             	add    $0x10,%esp
  while (getLine(file->fd, line)) {
     8b7:	83 ec 08             	sub    $0x8,%esp
     8ba:	56                   	push   %esi
     8bb:	ff 73 04             	pushl  0x4(%ebx)
     8be:	e8 5d fa ff ff       	call   320 <getLine>
     8c3:	83 c4 10             	add    $0x10,%esp
     8c6:	85 c0                	test   %eax,%eax
     8c8:	75 d6                	jne    8a0 <gatherLines+0x20>
  }
}
     8ca:	8d 65 f8             	lea    -0x8(%ebp),%esp
     8cd:	5b                   	pop    %ebx
     8ce:	5e                   	pop    %esi
     8cf:	5d                   	pop    %ebp
     8d0:	c3                   	ret    
     8d1:	eb 0d                	jmp    8e0 <getArg>
     8d3:	90                   	nop
     8d4:	90                   	nop
     8d5:	90                   	nop
     8d6:	90                   	nop
     8d7:	90                   	nop
     8d8:	90                   	nop
     8d9:	90                   	nop
     8da:	90                   	nop
     8db:	90                   	nop
     8dc:	90                   	nop
     8dd:	90                   	nop
     8de:	90                   	nop
     8df:	90                   	nop

000008e0 <getArg>:

void getArg(char* dest, char* args, char delimiter) {
     8e0:	55                   	push   %ebp
     8e1:	89 e5                	mov    %esp,%ebp
     8e3:	57                   	push   %edi
     8e4:	56                   	push   %esi
     8e5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     8e6:	31 db                	xor    %ebx,%ebx
     8e8:	83 ec 1c             	sub    $0x1c,%esp
     8eb:	8b 75 0c             	mov    0xc(%ebp),%esi
     8ee:	0f b6 7d 10          	movzbl 0x10(%ebp),%edi
     8f2:	eb 10                	jmp    904 <getArg+0x24>
     8f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     8f8:	89 f8                	mov    %edi,%eax
     8fa:	3a 04 1e             	cmp    (%esi,%ebx,1),%al
     8fd:	8d 53 01             	lea    0x1(%ebx),%edx
     900:	74 19                	je     91b <getArg+0x3b>
     902:	89 d3                	mov    %edx,%ebx
  for (int i = 0; i < strlen(str); i++)
     904:	83 ec 0c             	sub    $0xc,%esp
     907:	56                   	push   %esi
     908:	e8 23 0e 00 00       	call   1730 <strlen>
     90d:	83 c4 10             	add    $0x10,%esp
     910:	39 c3                	cmp    %eax,%ebx
     912:	72 e4                	jb     8f8 <getArg+0x18>
     914:	31 d2                	xor    %edx,%edx
  return -1;
     916:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  int end = find(args, delimiter);
  substr(dest, args, 0, end);
     91b:	53                   	push   %ebx
     91c:	6a 00                	push   $0x0
     91e:	56                   	push   %esi
     91f:	ff 75 08             	pushl  0x8(%ebp)
     922:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     925:	e8 d6 fa ff ff       	call   400 <substr>
  substr(args, args, end + 1, (int) strlen(args));
     92a:	89 34 24             	mov    %esi,(%esp)
     92d:	e8 fe 0d 00 00       	call   1730 <strlen>
     932:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     935:	50                   	push   %eax
     936:	52                   	push   %edx
     937:	56                   	push   %esi
     938:	56                   	push   %esi
     939:	e8 c2 fa ff ff       	call   400 <substr>
}
     93e:	83 c4 20             	add    $0x20,%esp
     941:	8d 65 f4             	lea    -0xc(%ebp),%esp
     944:	5b                   	pop    %ebx
     945:	5e                   	pop    %esi
     946:	5f                   	pop    %edi
     947:	5d                   	pop    %ebp
     948:	c3                   	ret    
     949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000950 <collectRange>:
int collectRange(char* args, int* startptr, int* endptr) {
     950:	55                   	push   %ebp
     951:	89 e5                	mov    %esp,%ebp
     953:	57                   	push   %edi
     954:	56                   	push   %esi
     955:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     956:	31 f6                	xor    %esi,%esi
     958:	83 ec 2c             	sub    $0x2c,%esp
     95b:	8b 5d 08             	mov    0x8(%ebp),%ebx
     95e:	eb 09                	jmp    969 <collectRange+0x19>
    if (str[i] == c) return i;
     960:	80 3c 33 3a          	cmpb   $0x3a,(%ebx,%esi,1)
     964:	74 42                	je     9a8 <collectRange+0x58>
  for (int i = 0; i < strlen(str); i++)
     966:	83 c6 01             	add    $0x1,%esi
     969:	83 ec 0c             	sub    $0xc,%esp
     96c:	53                   	push   %ebx
     96d:	e8 be 0d 00 00       	call   1730 <strlen>
     972:	83 c4 10             	add    $0x10,%esp
     975:	39 c6                	cmp    %eax,%esi
     977:	72 e7                	jb     960 <collectRange+0x10>
    if (args[0] == '-') {
     979:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     97c:	0f 84 d6 00 00 00    	je     a58 <collectRange+0x108>
      *startptr = atoi(args);
     982:	83 ec 0c             	sub    $0xc,%esp
     985:	53                   	push   %ebx
     986:	e8 05 0f 00 00       	call   1890 <atoi>
     98b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     98e:	83 c4 10             	add    $0x10,%esp
     991:	89 01                	mov    %eax,(%ecx)
    *endptr = *startptr;
     993:	8b 4d 10             	mov    0x10(%ebp),%ecx
     996:	89 01                	mov    %eax,(%ecx)
    return 0;
     998:	31 c0                	xor    %eax,%eax
}
     99a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     99d:	5b                   	pop    %ebx
     99e:	5e                   	pop    %esi
     99f:	5f                   	pop    %edi
     9a0:	5d                   	pop    %ebp
     9a1:	c3                   	ret    
     9a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  getArg(startstr, args, ':');
     9a8:	8d 75 de             	lea    -0x22(%ebp),%esi
     9ab:	83 ec 04             	sub    $0x4,%esp
     9ae:	6a 3a                	push   $0x3a
     9b0:	53                   	push   %ebx
     9b1:	56                   	push   %esi
     9b2:	e8 29 ff ff ff       	call   8e0 <getArg>
  if (startstr[0] == '-') {
     9b7:	83 c4 10             	add    $0x10,%esp
     9ba:	80 7d de 2d          	cmpb   $0x2d,-0x22(%ebp)
     9be:	0f 84 3c 01 00 00    	je     b00 <collectRange+0x1b0>
  int negStartFlag = 0, negEndFlag = 0;
     9c4:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     9cb:	31 ff                	xor    %edi,%edi
  if (endstr[0] == '-') {
     9cd:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     9d0:	0f 84 0a 01 00 00    	je     ae0 <collectRange+0x190>
  if (strcmp(startstr, "\0") == 0) *startptr = 1;
     9d6:	83 ec 08             	sub    $0x8,%esp
     9d9:	68 34 22 00 00       	push   $0x2234
     9de:	56                   	push   %esi
     9df:	e8 fc 0c 00 00       	call   16e0 <strcmp>
     9e4:	83 c4 10             	add    $0x10,%esp
     9e7:	85 c0                	test   %eax,%eax
     9e9:	0f 85 d1 00 00 00    	jne    ac0 <collectRange+0x170>
     9ef:	8b 45 0c             	mov    0xc(%ebp),%eax
     9f2:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  if (strcmp(endstr, "\0") == 0) *endptr = -1;
     9f8:	83 ec 08             	sub    $0x8,%esp
     9fb:	68 34 22 00 00       	push   $0x2234
     a00:	53                   	push   %ebx
     a01:	e8 da 0c 00 00       	call   16e0 <strcmp>
     a06:	83 c4 10             	add    $0x10,%esp
     a09:	85 c0                	test   %eax,%eax
     a0b:	0f 85 97 00 00 00    	jne    aa8 <collectRange+0x158>
     a11:	8b 45 10             	mov    0x10(%ebp),%eax
     a14:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  if (negStartFlag) *startptr = 0 - *startptr;
     a1a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     a1d:	85 c0                	test   %eax,%eax
     a1f:	74 05                	je     a26 <collectRange+0xd6>
     a21:	8b 45 0c             	mov    0xc(%ebp),%eax
     a24:	f7 18                	negl   (%eax)
  if (negEndFlag) *endptr = 0 - *endptr;
     a26:	85 ff                	test   %edi,%edi
     a28:	74 05                	je     a2f <collectRange+0xdf>
     a2a:	8b 45 10             	mov    0x10(%ebp),%eax
     a2d:	f7 18                	negl   (%eax)
  if (((*startptr > 0 && *endptr > 0) || 
     a2f:	8b 45 0c             	mov    0xc(%ebp),%eax
     a32:	8b 00                	mov    (%eax),%eax
     a34:	83 f8 00             	cmp    $0x0,%eax
     a37:	7e 4f                	jle    a88 <collectRange+0x138>
     a39:	8b 55 10             	mov    0x10(%ebp),%edx
     a3c:	8b 12                	mov    (%edx),%edx
     a3e:	85 d2                	test   %edx,%edx
     a40:	7e 55                	jle    a97 <collectRange+0x147>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     a42:	39 d0                	cmp    %edx,%eax
     a44:	0f 9f c0             	setg   %al
}
     a47:	8d 65 f4             	lea    -0xc(%ebp),%esp
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     a4a:	0f b6 c0             	movzbl %al,%eax
}
     a4d:	5b                   	pop    %ebx
     a4e:	5e                   	pop    %esi
     a4f:	5f                   	pop    %edi
     a50:	5d                   	pop    %ebp
     a51:	c3                   	ret    
     a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      substr(args, args, 1, strlen(args));
     a58:	83 ec 0c             	sub    $0xc,%esp
     a5b:	53                   	push   %ebx
     a5c:	e8 cf 0c 00 00       	call   1730 <strlen>
     a61:	50                   	push   %eax
     a62:	6a 01                	push   $0x1
     a64:	53                   	push   %ebx
     a65:	53                   	push   %ebx
     a66:	e8 95 f9 ff ff       	call   400 <substr>
      *startptr = 0 - atoi(args);
     a6b:	83 c4 14             	add    $0x14,%esp
     a6e:	53                   	push   %ebx
     a6f:	e8 1c 0e 00 00       	call   1890 <atoi>
     a74:	8b 7d 0c             	mov    0xc(%ebp),%edi
     a77:	f7 d8                	neg    %eax
     a79:	83 c4 10             	add    $0x10,%esp
     a7c:	89 07                	mov    %eax,(%edi)
     a7e:	e9 10 ff ff ff       	jmp    993 <collectRange+0x43>
     a83:	90                   	nop
     a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (((*startptr > 0 && *endptr > 0) || 
     a88:	0f 84 0c ff ff ff    	je     99a <collectRange+0x4a>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     a8e:	8b 7d 10             	mov    0x10(%ebp),%edi
     a91:	8b 17                	mov    (%edi),%edx
     a93:	85 d2                	test   %edx,%edx
     a95:	78 ab                	js     a42 <collectRange+0xf2>
}
     a97:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
     a9a:	31 c0                	xor    %eax,%eax
}
     a9c:	5b                   	pop    %ebx
     a9d:	5e                   	pop    %esi
     a9e:	5f                   	pop    %edi
     a9f:	5d                   	pop    %ebp
     aa0:	c3                   	ret    
     aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else *endptr = atoi(endstr);
     aa8:	83 ec 0c             	sub    $0xc,%esp
     aab:	53                   	push   %ebx
     aac:	e8 df 0d 00 00       	call   1890 <atoi>
     ab1:	8b 55 10             	mov    0x10(%ebp),%edx
     ab4:	83 c4 10             	add    $0x10,%esp
     ab7:	89 02                	mov    %eax,(%edx)
     ab9:	e9 5c ff ff ff       	jmp    a1a <collectRange+0xca>
     abe:	66 90                	xchg   %ax,%ax
  else *startptr = atoi(startstr);
     ac0:	83 ec 0c             	sub    $0xc,%esp
     ac3:	56                   	push   %esi
     ac4:	e8 c7 0d 00 00       	call   1890 <atoi>
     ac9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     acc:	83 c4 10             	add    $0x10,%esp
     acf:	89 01                	mov    %eax,(%ecx)
     ad1:	e9 22 ff ff ff       	jmp    9f8 <collectRange+0xa8>
     ad6:	8d 76 00             	lea    0x0(%esi),%esi
     ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    substr(endstr, endstr, 1, strlen(endstr));
     ae0:	83 ec 0c             	sub    $0xc,%esp
    negEndFlag = 1;
     ae3:	bf 01 00 00 00       	mov    $0x1,%edi
    substr(endstr, endstr, 1, strlen(endstr));
     ae8:	53                   	push   %ebx
     ae9:	e8 42 0c 00 00       	call   1730 <strlen>
     aee:	50                   	push   %eax
     aef:	6a 01                	push   $0x1
     af1:	53                   	push   %ebx
     af2:	53                   	push   %ebx
     af3:	e8 08 f9 ff ff       	call   400 <substr>
     af8:	83 c4 20             	add    $0x20,%esp
     afb:	e9 d6 fe ff ff       	jmp    9d6 <collectRange+0x86>
    substr(startstr, startstr, 1, strlen(startstr));
     b00:	83 ec 0c             	sub    $0xc,%esp
     b03:	56                   	push   %esi
     b04:	e8 27 0c 00 00       	call   1730 <strlen>
     b09:	50                   	push   %eax
     b0a:	6a 01                	push   $0x1
     b0c:	56                   	push   %esi
     b0d:	56                   	push   %esi
     b0e:	e8 ed f8 ff ff       	call   400 <substr>
     b13:	83 c4 20             	add    $0x20,%esp
    negStartFlag = 1;
     b16:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
     b1d:	e9 a9 fe ff ff       	jmp    9cb <collectRange+0x7b>
     b22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b30 <unline>:

void unline(char* str) {
     b30:	55                   	push   %ebp
     b31:	89 e5                	mov    %esp,%ebp
     b33:	53                   	push   %ebx
     b34:	83 ec 10             	sub    $0x10,%esp
     b37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str) - 1;
     b3a:	53                   	push   %ebx
     b3b:	e8 f0 0b 00 00       	call   1730 <strlen>
     b40:	8d 50 ff             	lea    -0x1(%eax),%edx
  for (; len > 0; len--) {
     b43:	83 c4 10             	add    $0x10,%esp
     b46:	85 d2                	test   %edx,%edx
     b48:	7e 36                	jle    b80 <unline+0x50>
    char c = str[len];
    if (c == '\n')
     b4a:	80 7c 03 ff 0a       	cmpb   $0xa,-0x1(%ebx,%eax,1)
     b4f:	74 2f                	je     b80 <unline+0x50>
     b51:	8d 44 03 fe          	lea    -0x2(%ebx,%eax,1),%eax
     b55:	eb 12                	jmp    b69 <unline+0x39>
     b57:	89 f6                	mov    %esi,%esi
     b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     b60:	83 e8 01             	sub    $0x1,%eax
     b63:	80 78 01 0a          	cmpb   $0xa,0x1(%eax)
     b67:	74 06                	je     b6f <unline+0x3f>
  for (; len > 0; len--) {
     b69:	39 c3                	cmp    %eax,%ebx
     b6b:	89 c2                	mov    %eax,%edx
     b6d:	75 f1                	jne    b60 <unline+0x30>
      break;
  }
  str[len] = '\0';
     b6f:	c6 02 00             	movb   $0x0,(%edx)
}
     b72:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b75:	c9                   	leave  
     b76:	c3                   	ret    
     b77:	89 f6                	mov    %esi,%esi
     b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     b80:	01 da                	add    %ebx,%edx
  str[len] = '\0';
     b82:	c6 02 00             	movb   $0x0,(%edx)
}
     b85:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b88:	c9                   	leave  
     b89:	c3                   	ret    
     b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000b90 <gatherLinesSized>:

// int* gatherLineSized(struct File* file, Terminal terminal) {
void gatherLinesSized(struct File* file, Terminal terminal) {
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	57                   	push   %edi
     b94:	56                   	push   %esi
     b95:	53                   	push   %ebx
     b96:	81 ec 0c 04 00 00    	sub    $0x40c,%esp
     b9c:	8b 75 0c             	mov    0xc(%ebp),%esi
     b9f:	8b 7d 08             	mov    0x8(%ebp),%edi
  char line[MAXLINESIZE];
  while (getLine(file->fd, line)) {
    int cols = 0;
    for (; strlen(line + cols) > terminal.width; cols += terminal.width) {
      printf("line: %s\n\n", line + cols);
      char piece[terminal.width];
     ba2:	8d 46 0f             	lea    0xf(%esi),%eax
     ba5:	c1 e8 04             	shr    $0x4,%eax
     ba8:	89 85 ec fb ff ff    	mov    %eax,-0x414(%ebp)
     bae:	66 90                	xchg   %ax,%ax
  while (getLine(file->fd, line)) {
     bb0:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     bb6:	83 ec 08             	sub    $0x8,%esp
     bb9:	50                   	push   %eax
     bba:	ff 77 04             	pushl  0x4(%edi)
     bbd:	e8 5e f7 ff ff       	call   320 <getLine>
     bc2:	83 c4 10             	add    $0x10,%esp
     bc5:	85 c0                	test   %eax,%eax
     bc7:	0f 84 93 00 00 00    	je     c60 <gatherLinesSized+0xd0>
     bcd:	8d 9d 00 fc ff ff    	lea    -0x400(%ebp),%ebx
     bd3:	eb 5b                	jmp    c30 <gatherLinesSized+0xa0>
     bd5:	8d 76 00             	lea    0x0(%esi),%esi
    for (; strlen(line + cols) > terminal.width; cols += terminal.width) {
     bd8:	89 a5 f4 fb ff ff    	mov    %esp,-0x40c(%ebp)
      printf("line: %s\n\n", line + cols);
     bde:	83 ec 08             	sub    $0x8,%esp
     be1:	53                   	push   %ebx
     be2:	68 36 22 00 00       	push   $0x2236
     be7:	e8 b4 10 00 00       	call   1ca0 <printf>
      char piece[terminal.width];
     bec:	8b 85 ec fb ff ff    	mov    -0x414(%ebp),%eax
     bf2:	83 c4 10             	add    $0x10,%esp
     bf5:	c1 e0 04             	shl    $0x4,%eax
     bf8:	29 c4                	sub    %eax,%esp
  if(n <= 0)
     bfa:	85 f6                	test   %esi,%esi
     bfc:	89 a5 f0 fb ff ff    	mov    %esp,-0x410(%ebp)
     c02:	7e 0b                	jle    c0f <gatherLinesSized+0x7f>
     c04:	89 f1                	mov    %esi,%ecx
     c06:	89 da                	mov    %ebx,%edx
     c08:	89 e0                	mov    %esp,%eax
     c0a:	e8 51 f6 ff ff       	call   260 <safestrcpy.part.0>
      safestrcpy(piece, line + cols, terminal.width);
      append(file->lines, piece);
     c0f:	8b 47 0c             	mov    0xc(%edi),%eax
     c12:	83 ec 04             	sub    $0x4,%esp
     c15:	01 f3                	add    %esi,%ebx
     c17:	ff 70 08             	pushl  0x8(%eax)
     c1a:	ff b5 f0 fb ff ff    	pushl  -0x410(%ebp)
     c20:	50                   	push   %eax
     c21:	e8 7a fa ff ff       	call   6a0 <insert>
      file->len++;
     c26:	83 47 10 01          	addl   $0x1,0x10(%edi)
     c2a:	8b a5 f4 fb ff ff    	mov    -0x40c(%ebp),%esp
    for (; strlen(line + cols) > terminal.width; cols += terminal.width) {
     c30:	83 ec 0c             	sub    $0xc,%esp
     c33:	53                   	push   %ebx
     c34:	e8 f7 0a 00 00       	call   1730 <strlen>
     c39:	83 c4 10             	add    $0x10,%esp
     c3c:	39 f0                	cmp    %esi,%eax
     c3e:	77 98                	ja     bd8 <gatherLinesSized+0x48>
      numSplits++;
    }
    append(file->lines, line + cols);
     c40:	8b 47 0c             	mov    0xc(%edi),%eax
     c43:	83 ec 04             	sub    $0x4,%esp
     c46:	ff 70 08             	pushl  0x8(%eax)
     c49:	53                   	push   %ebx
     c4a:	50                   	push   %eax
     c4b:	e8 50 fa ff ff       	call   6a0 <insert>
    file->len++;
     c50:	83 47 10 01          	addl   $0x1,0x10(%edi)
     c54:	83 c4 10             	add    $0x10,%esp
     c57:	e9 54 ff ff ff       	jmp    bb0 <gatherLinesSized+0x20>
     c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  // return ;
}
     c60:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c63:	5b                   	pop    %ebx
     c64:	5e                   	pop    %esi
     c65:	5f                   	pop    %edi
     c66:	5d                   	pop    %ebp
     c67:	c3                   	ret    
     c68:	90                   	nop
     c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c70 <lineAt>:


// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
  return nodeAt(list, pos-1);
     c73:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
}
     c77:	5d                   	pop    %ebp
  return nodeAt(list, pos-1);
     c78:	e9 03 f9 ff ff       	jmp    580 <nodeAt>
     c7d:	8d 76 00             	lea    0x0(%esi),%esi

00000c80 <printl>:

void printl(int lineNum, char* line) {
     c80:	55                   	push   %ebp
     c81:	89 e5                	mov    %esp,%ebp
     c83:	83 ec 08             	sub    $0x8,%esp
     c86:	8b 45 08             	mov    0x8(%ebp),%eax
  if (lineNum < 10)
     c89:	83 f8 09             	cmp    $0x9,%eax
     c8c:	7e 3a                	jle    cc8 <printl+0x48>
    fprintf(2, "%d  : %s\n", lineNum, line);
  else if (lineNum < 100)
     c8e:	83 f8 63             	cmp    $0x63,%eax
     c91:	7e 1d                	jle    cb0 <printl+0x30>
    fprintf(2, "%d : %s\n", lineNum, line);
  else
    fprintf(2, "%d: %s\n", lineNum, line);
     c93:	ff 75 0c             	pushl  0xc(%ebp)
     c96:	50                   	push   %eax
     c97:	68 54 22 00 00       	push   $0x2254
     c9c:	6a 02                	push   $0x2
     c9e:	e8 dd 0f 00 00       	call   1c80 <fprintf>
     ca3:	83 c4 10             	add    $0x10,%esp
}
     ca6:	c9                   	leave  
     ca7:	c3                   	ret    
     ca8:	90                   	nop
     ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "%d : %s\n", lineNum, line);
     cb0:	ff 75 0c             	pushl  0xc(%ebp)
     cb3:	50                   	push   %eax
     cb4:	68 4b 22 00 00       	push   $0x224b
     cb9:	6a 02                	push   $0x2
     cbb:	e8 c0 0f 00 00       	call   1c80 <fprintf>
     cc0:	83 c4 10             	add    $0x10,%esp
}
     cc3:	c9                   	leave  
     cc4:	c3                   	ret    
     cc5:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "%d  : %s\n", lineNum, line);
     cc8:	ff 75 0c             	pushl  0xc(%ebp)
     ccb:	50                   	push   %eax
     ccc:	68 41 22 00 00       	push   $0x2241
     cd1:	6a 02                	push   $0x2
     cd3:	e8 a8 0f 00 00       	call   1c80 <fprintf>
     cd8:	83 c4 10             	add    $0x10,%esp
}
     cdb:	c9                   	leave  
     cdc:	c3                   	ret    
     cdd:	8d 76 00             	lea    0x0(%esi),%esi

00000ce0 <printpad>:

// prints the string with padding of a certain character
void printpad(int pad, char padChar, char* str, int alignment, int endLine) {
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
     ce3:	57                   	push   %edi
     ce4:	56                   	push   %esi
     ce5:	53                   	push   %ebx
     ce6:	83 ec 28             	sub    $0x28,%esp
     ce9:	8b 45 0c             	mov    0xc(%ebp),%eax
     cec:	8b 7d 10             	mov    0x10(%ebp),%edi
     cef:	8b 5d 08             	mov    0x8(%ebp),%ebx
     cf2:	8b 75 14             	mov    0x14(%ebp),%esi
     cf5:	89 45 e0             	mov    %eax,-0x20(%ebp)
     cf8:	8b 45 18             	mov    0x18(%ebp),%eax
  int len = strlen(str);
     cfb:	57                   	push   %edi
void printpad(int pad, char padChar, char* str, int alignment, int endLine) {
     cfc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int len = strlen(str);
     cff:	e8 2c 0a 00 00       	call   1730 <strlen>
  int i = pad - len;
  if (alignment == LEFT) {
     d04:	83 c4 10             	add    $0x10,%esp
  int i = pad - len;
     d07:	29 c3                	sub    %eax,%ebx
  if (alignment == LEFT) {
     d09:	85 f6                	test   %esi,%esi
     d0b:	74 7b                	je     d88 <printpad+0xa8>
    printf("%s", str);
    for (; i > 0; i--)
      printf("%c", padChar);
  } else if (alignment == RIGHT) {
     d0d:	83 fe 02             	cmp    $0x2,%esi
     d10:	74 1e                	je     d30 <printpad+0x50>
    for (; i > 0; i--)
      printf("%c", padChar);
    printf("%s", str);
  } else if (alignment == CENTER) {
     d12:	83 fe 01             	cmp    $0x1,%esi
     d15:	0f 84 ad 00 00 00    	je     dc8 <printpad+0xe8>
      printf("%c", padChar);
      if (i == half)
        printf("%s", str);
    }
  }
  if (endLine) {
     d1b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d1e:	85 c0                	test   %eax,%eax
     d20:	75 4c                	jne    d6e <printpad+0x8e>
    printf("\n");
  }
     d22:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d25:	5b                   	pop    %ebx
     d26:	5e                   	pop    %esi
     d27:	5f                   	pop    %edi
     d28:	5d                   	pop    %ebp
     d29:	c3                   	ret    
     d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for (; i > 0; i--)
     d30:	85 db                	test   %ebx,%ebx
     d32:	7e 22                	jle    d56 <printpad+0x76>
     d34:	0f be 75 e0          	movsbl -0x20(%ebp),%esi
     d38:	90                   	nop
     d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printf("%c", padChar);
     d40:	83 ec 08             	sub    $0x8,%esp
     d43:	56                   	push   %esi
     d44:	68 5f 22 00 00       	push   $0x225f
     d49:	e8 52 0f 00 00       	call   1ca0 <printf>
    for (; i > 0; i--)
     d4e:	83 c4 10             	add    $0x10,%esp
     d51:	83 eb 01             	sub    $0x1,%ebx
     d54:	75 ea                	jne    d40 <printpad+0x60>
    printf("%s", str);
     d56:	83 ec 08             	sub    $0x8,%esp
     d59:	57                   	push   %edi
     d5a:	68 5c 22 00 00       	push   $0x225c
     d5f:	e8 3c 0f 00 00       	call   1ca0 <printf>
  if (endLine) {
     d64:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d67:	83 c4 10             	add    $0x10,%esp
     d6a:	85 c0                	test   %eax,%eax
     d6c:	74 b4                	je     d22 <printpad+0x42>
    printf("\n");
     d6e:	c7 45 08 3f 22 00 00 	movl   $0x223f,0x8(%ebp)
     d75:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d78:	5b                   	pop    %ebx
     d79:	5e                   	pop    %esi
     d7a:	5f                   	pop    %edi
     d7b:	5d                   	pop    %ebp
    printf("\n");
     d7c:	e9 1f 0f 00 00       	jmp    1ca0 <printf>
     d81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    printf("%s", str);
     d88:	83 ec 08             	sub    $0x8,%esp
     d8b:	57                   	push   %edi
     d8c:	68 5c 22 00 00       	push   $0x225c
     d91:	e8 0a 0f 00 00       	call   1ca0 <printf>
    for (; i > 0; i--)
     d96:	83 c4 10             	add    $0x10,%esp
     d99:	85 db                	test   %ebx,%ebx
     d9b:	0f 8e 7a ff ff ff    	jle    d1b <printpad+0x3b>
     da1:	0f be 75 e0          	movsbl -0x20(%ebp),%esi
     da5:	8d 76 00             	lea    0x0(%esi),%esi
      printf("%c", padChar);
     da8:	83 ec 08             	sub    $0x8,%esp
     dab:	56                   	push   %esi
     dac:	68 5f 22 00 00       	push   $0x225f
     db1:	e8 ea 0e 00 00       	call   1ca0 <printf>
    for (; i > 0; i--)
     db6:	83 c4 10             	add    $0x10,%esp
     db9:	83 eb 01             	sub    $0x1,%ebx
     dbc:	75 ea                	jne    da8 <printpad+0xc8>
     dbe:	e9 58 ff ff ff       	jmp    d1b <printpad+0x3b>
     dc3:	90                   	nop
     dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int half = i / 2;
     dc8:	89 d8                	mov    %ebx,%eax
     dca:	c1 e8 1f             	shr    $0x1f,%eax
     dcd:	01 d8                	add    %ebx,%eax
     dcf:	d1 f8                	sar    %eax
    for (; i > 0; i--) {
     dd1:	85 db                	test   %ebx,%ebx
    int half = i / 2;
     dd3:	89 45 dc             	mov    %eax,-0x24(%ebp)
    for (; i > 0; i--) {
     dd6:	0f 8e 3f ff ff ff    	jle    d1b <printpad+0x3b>
     ddc:	0f be 75 e0          	movsbl -0x20(%ebp),%esi
     de0:	eb 0f                	jmp    df1 <printpad+0x111>
     de2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     de8:	83 eb 01             	sub    $0x1,%ebx
     deb:	0f 84 2a ff ff ff    	je     d1b <printpad+0x3b>
      printf("%c", padChar);
     df1:	83 ec 08             	sub    $0x8,%esp
     df4:	56                   	push   %esi
     df5:	68 5f 22 00 00       	push   $0x225f
     dfa:	e8 a1 0e 00 00       	call   1ca0 <printf>
      if (i == half)
     dff:	83 c4 10             	add    $0x10,%esp
     e02:	39 5d dc             	cmp    %ebx,-0x24(%ebp)
     e05:	75 e1                	jne    de8 <printpad+0x108>
        printf("%s", str);
     e07:	83 ec 08             	sub    $0x8,%esp
     e0a:	57                   	push   %edi
     e0b:	68 5c 22 00 00       	push   $0x225c
     e10:	e8 8b 0e 00 00       	call   1ca0 <printf>
     e15:	83 c4 10             	add    $0x10,%esp
     e18:	eb ce                	jmp    de8 <printpad+0x108>
     e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000e20 <forward>:
void forward(struct File* file, Terminal terminal){
     e20:	55                   	push   %ebp
     e21:	89 e5                	mov    %esp,%ebp
     e23:	8b 55 08             	mov    0x8(%ebp),%edx
  file->curLine += TERMH_ADJ;
     e26:	8b 45 10             	mov    0x10(%ebp),%eax
     e29:	83 e8 01             	sub    $0x1,%eax
     e2c:	01 42 08             	add    %eax,0x8(%edx)
}
     e2f:	5d                   	pop    %ebp
     e30:	c3                   	ret    
     e31:	eb 0d                	jmp    e40 <skip>
     e33:	90                   	nop
     e34:	90                   	nop
     e35:	90                   	nop
     e36:	90                   	nop
     e37:	90                   	nop
     e38:	90                   	nop
     e39:	90                   	nop
     e3a:	90                   	nop
     e3b:	90                   	nop
     e3c:	90                   	nop
     e3d:	90                   	nop
     e3e:	90                   	nop
     e3f:	90                   	nop

00000e40 <skip>:
void skip(struct File* file, Terminal terminal){
     e40:	55                   	push   %ebp
     e41:	89 e5                	mov    %esp,%ebp
     e43:	83 ec 14             	sub    $0x14,%esp
     e46:	8b 45 08             	mov    0x8(%ebp),%eax
  file->curLine += (2 * TERMH_ADJ);
     e49:	8b 55 10             	mov    0x10(%ebp),%edx
     e4c:	8d 54 12 fe          	lea    -0x2(%edx,%edx,1),%edx
     e50:	01 50 08             	add    %edx,0x8(%eax)
  printpad(terminal.width, ' ', msg, LEFT, 0);
     e53:	6a 00                	push   $0x0
     e55:	6a 00                	push   $0x0
     e57:	68 62 22 00 00       	push   $0x2262
     e5c:	6a 20                	push   $0x20
     e5e:	ff 75 0c             	pushl  0xc(%ebp)
     e61:	e8 7a fe ff ff       	call   ce0 <printpad>
}
     e66:	83 c4 20             	add    $0x20,%esp
     e69:	c9                   	leave  
     e6a:	c3                   	ret    
     e6b:	90                   	nop
     e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000e70 <back>:
void back(struct File* file, Terminal terminal){
     e70:	55                   	push   %ebp
     e71:	89 e5                	mov    %esp,%ebp
     e73:	83 ec 14             	sub    $0x14,%esp
     e76:	8b 4d 08             	mov    0x8(%ebp),%ecx
  file->curLine -= TERMH_ADJ;
     e79:	8b 45 10             	mov    0x10(%ebp),%eax
     e7c:	8b 51 08             	mov    0x8(%ecx),%edx
     e7f:	83 e8 01             	sub    $0x1,%eax
     e82:	29 c2                	sub    %eax,%edx
     e84:	39 d0                	cmp    %edx,%eax
     e86:	0f 4e c2             	cmovle %edx,%eax
     e89:	89 41 08             	mov    %eax,0x8(%ecx)
  printpad(terminal.width, ' ', msg, LEFT, 0);
     e8c:	6a 00                	push   $0x0
     e8e:	6a 00                	push   $0x0
     e90:	68 75 22 00 00       	push   $0x2275
     e95:	6a 20                	push   $0x20
     e97:	ff 75 0c             	pushl  0xc(%ebp)
     e9a:	e8 41 fe ff ff       	call   ce0 <printpad>
}
     e9f:	83 c4 20             	add    $0x20,%esp
     ea2:	c9                   	leave  
     ea3:	c3                   	ret    
     ea4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     eaa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000eb0 <scroll>:
void scroll(struct File* file, Terminal terminal){
     eb0:	55                   	push   %ebp
     eb1:	89 e5                	mov    %esp,%ebp
     eb3:	83 ec 14             	sub    $0x14,%esp
     eb6:	8b 45 08             	mov    0x8(%ebp),%eax
  file->curLine++;
     eb9:	83 40 08 01          	addl   $0x1,0x8(%eax)
  printpad(terminal.width, ' ', msg, LEFT, 0);
     ebd:	6a 00                	push   $0x0
     ebf:	6a 00                	push   $0x0
     ec1:	68 84 22 00 00       	push   $0x2284
     ec6:	6a 20                	push   $0x20
     ec8:	ff 75 0c             	pushl  0xc(%ebp)
     ecb:	e8 10 fe ff ff       	call   ce0 <printpad>
}
     ed0:	83 c4 20             	add    $0x20,%esp
     ed3:	c9                   	leave  
     ed4:	c3                   	ret    
     ed5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ee0 <line>:
void line(File file, Terminal terminal){
     ee0:	55                   	push   %ebp
     ee1:	b9 0a 00 00 00       	mov    $0xa,%ecx
     ee6:	89 e5                	mov    %esp,%ebp
     ee8:	56                   	push   %esi
     ee9:	53                   	push   %ebx
     eea:	8d 5d f3             	lea    -0xd(%ebp),%ebx
     eed:	83 ec 10             	sub    $0x10,%esp
     ef0:	8b 45 10             	mov    0x10(%ebp),%eax
     ef3:	8b 75 20             	mov    0x20(%ebp),%esi
     ef6:	89 da                	mov    %ebx,%edx
     ef8:	e8 a3 f3 ff ff       	call   2a0 <itoa.part.2>
  printpad(terminal.width, ' ', msg, LEFT, 0);
     efd:	83 ec 0c             	sub    $0xc,%esp
     f00:	6a 00                	push   $0x0
     f02:	6a 00                	push   $0x0
     f04:	53                   	push   %ebx
     f05:	6a 20                	push   $0x20
     f07:	56                   	push   %esi
     f08:	e8 d3 fd ff ff       	call   ce0 <printpad>
}
     f0d:	83 c4 20             	add    $0x20,%esp
     f10:	8d 65 f8             	lea    -0x8(%ebp),%esp
     f13:	5b                   	pop    %ebx
     f14:	5e                   	pop    %esi
     f15:	5d                   	pop    %ebp
     f16:	c3                   	ret    
     f17:	89 f6                	mov    %esi,%esi
     f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000f20 <help>:
void help(Terminal terminal) {
     f20:	55                   	push   %ebp
     f21:	89 e5                	mov    %esp,%ebp
     f23:	53                   	push   %ebx
     f24:	83 ec 10             	sub    $0x10,%esp
     f27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printpad(terminal.width, '-', "-", LEFT, 1);
     f2a:	6a 01                	push   $0x1
     f2c:	6a 00                	push   $0x0
     f2e:	68 9a 22 00 00       	push   $0x229a
     f33:	6a 2d                	push   $0x2d
     f35:	53                   	push   %ebx
     f36:	e8 a5 fd ff ff       	call   ce0 <printpad>
  printf("<space>                 Display next k lines of text [current screen size]\n");
     f3b:	83 c4 14             	add    $0x14,%esp
     f3e:	68 90 1e 00 00       	push   $0x1e90
     f43:	e8 58 0d 00 00       	call   1ca0 <printf>
  printf("<return>                Display next k lines of text [1]*\n");
     f48:	c7 04 24 dc 1e 00 00 	movl   $0x1edc,(%esp)
     f4f:	e8 4c 0d 00 00       	call   1ca0 <printf>
  printf("b or B                  Skip backwards 1 screenful of text\n");
     f54:	c7 04 24 18 1f 00 00 	movl   $0x1f18,(%esp)
     f5b:	e8 40 0d 00 00       	call   1ca0 <printf>
  // printf("z                       Display next k lines of text [current screen size]*\n");
  printf("e                       Display next k lines of text [1]*\n");
     f60:	c7 04 24 54 1f 00 00 	movl   $0x1f54,(%esp)
     f67:	e8 34 0d 00 00       	call   1ca0 <printf>
  // printf("d or ctrl-D             Scroll k lines [current scroll size, initially 11]*\n");
  printf("f                       Skip forward 1 screenful of text\n");
     f6c:	c7 04 24 90 1f 00 00 	movl   $0x1f90,(%esp)
     f73:	e8 28 0d 00 00       	call   1ca0 <printf>
  printf("=                       Display current line number\n");
     f78:	c7 04 24 cc 1f 00 00 	movl   $0x1fcc,(%esp)
     f7f:	e8 1c 0d 00 00       	call   1ca0 <printf>
  // printf("v                       Start up /usr/bin/vi at current line\n");
  // printf("l or L                  Redraw screen\n");
  printf("q or Q or <interrupt>   Exit from more\n");
     f84:	c7 04 24 04 20 00 00 	movl   $0x2004,(%esp)
     f8b:	e8 10 0d 00 00       	call   1ca0 <printf>
  // printf(".                       Repeat previous command\n");
  printpad(terminal.width, '-', "-", LEFT, 1);
     f90:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f97:	6a 00                	push   $0x0
     f99:	68 9a 22 00 00       	push   $0x229a
     f9e:	6a 2d                	push   $0x2d
     fa0:	53                   	push   %ebx
     fa1:	e8 3a fd ff ff       	call   ce0 <printpad>
}
     fa6:	83 c4 20             	add    $0x20,%esp
     fa9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fac:	c9                   	leave  
     fad:	c3                   	ret    
     fae:	66 90                	xchg   %ax,%ax

00000fb0 <printPrompt>:

// help
void printPrompt(File file) {
     fb0:	55                   	push   %ebp
     fb1:	89 e5                	mov    %esp,%ebp
     fb3:	83 ec 10             	sub    $0x10,%esp
  printf("\n--MORE--(%d%%)", 100 * file.curLine / file.len);
     fb6:	6b 45 10 64          	imul   $0x64,0x10(%ebp),%eax
     fba:	99                   	cltd   
     fbb:	f7 7d 18             	idivl  0x18(%ebp)
     fbe:	50                   	push   %eax
     fbf:	68 9c 22 00 00       	push   $0x229c
     fc4:	e8 d7 0c 00 00       	call   1ca0 <printf>
  printf("[Press space to continue, 'q' to quit.]\r");
     fc9:	83 c4 10             	add    $0x10,%esp
     fcc:	c7 45 08 2c 20 00 00 	movl   $0x202c,0x8(%ebp)
}
     fd3:	c9                   	leave  
  printf("[Press space to continue, 'q' to quit.]\r");
     fd4:	e9 c7 0c 00 00       	jmp    1ca0 <printf>
     fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000fe0 <showPage>:

void showPage(File file, Terminal terminal) {
     fe0:	55                   	push   %ebp
     fe1:	89 e5                	mov    %esp,%ebp
     fe3:	57                   	push   %edi
     fe4:	56                   	push   %esi
     fe5:	53                   	push   %ebx
     fe6:	83 ec 28             	sub    $0x28,%esp
     fe9:	8b 5d 20             	mov    0x20(%ebp),%ebx
     fec:	8b 45 10             	mov    0x10(%ebp),%eax
  printpad(terminal.width, '#', "#", LEFT, 0);
     fef:	6a 00                	push   $0x0
     ff1:	6a 00                	push   $0x0
     ff3:	68 ac 22 00 00       	push   $0x22ac
     ff8:	6a 23                	push   $0x23
     ffa:	53                   	push   %ebx
void showPage(File file, Terminal terminal) {
     ffb:	8b 7d 24             	mov    0x24(%ebp),%edi
     ffe:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1001:	8b 75 14             	mov    0x14(%ebp),%esi
  printpad(terminal.width, '#', "#", LEFT, 0);
    1004:	e8 d7 fc ff ff       	call   ce0 <printpad>
  printf("curLine:    %d\n", file.curLine);
    1009:	83 c4 18             	add    $0x18,%esp
    100c:	ff 75 e0             	pushl  -0x20(%ebp)
    100f:	68 ae 22 00 00       	push   $0x22ae
    1014:	e8 87 0c 00 00       	call   1ca0 <printf>
  printf("terminal.h: %d\n", terminal.height);
    1019:	58                   	pop    %eax
    101a:	5a                   	pop    %edx
    101b:	57                   	push   %edi
    101c:	68 be 22 00 00       	push   $0x22be
    1021:	e8 7a 0c 00 00       	call   1ca0 <printf>
  printf("terminal.w: %d\n", terminal.width);
    1026:	59                   	pop    %ecx
    1027:	58                   	pop    %eax
    1028:	53                   	push   %ebx
    1029:	68 ce 22 00 00       	push   $0x22ce
    102e:	e8 6d 0c 00 00       	call   1ca0 <printf>
  printf("TERMH_ADJ:  %d\n", TERMH_ADJ);
    1033:	58                   	pop    %eax
    1034:	8d 4f ff             	lea    -0x1(%edi),%ecx
    1037:	5a                   	pop    %edx
    1038:	51                   	push   %ecx
    1039:	68 de 22 00 00       	push   $0x22de
    103e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    1041:	e8 5a 0c 00 00       	call   1ca0 <printf>
  printf("TOP_LINE:   %d\n", LINE_ON_TOP);
    1046:	8b 7d e0             	mov    -0x20(%ebp),%edi
    1049:	2b 7d e4             	sub    -0x1c(%ebp),%edi
    104c:	59                   	pop    %ecx
    104d:	58                   	pop    %eax
    104e:	8d 47 01             	lea    0x1(%edi),%eax
    1051:	50                   	push   %eax
    1052:	68 ee 22 00 00       	push   $0x22ee
    1057:	e8 44 0c 00 00       	call   1ca0 <printf>
  return nodeAt(list, pos-1);
    105c:	58                   	pop    %eax
    105d:	5a                   	pop    %edx
    105e:	57                   	push   %edi
    105f:	56                   	push   %esi
    1060:	e8 1b f5 ff ff       	call   580 <nodeAt>
    1065:	59                   	pop    %ecx
    1066:	5a                   	pop    %edx
  printf("file top: \n%s\n", (lineAt(file.lines, LINE_ON_TOP))->data);
    1067:	ff 70 04             	pushl  0x4(%eax)
    106a:	68 fe 22 00 00       	push   $0x22fe
    106f:	e8 2c 0c 00 00       	call   1ca0 <printf>
  printpad(terminal.width, '#', "#", LEFT, 0);
    1074:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    107b:	6a 00                	push   $0x0
    107d:	68 ac 22 00 00       	push   $0x22ac
    1082:	6a 23                	push   $0x23
    1084:	53                   	push   %ebx
    1085:	e8 56 fc ff ff       	call   ce0 <printpad>
    108a:	83 c4 18             	add    $0x18,%esp
    108d:	57                   	push   %edi
    108e:	56                   	push   %esi
    108f:	e8 ec f4 ff ff       	call   580 <nodeAt>

  struct Node* curNode = lineAt(file.lines, LINE_ON_TOP);
  int termLine = 0; // num lines we've written to the terminal so far
  while (termLine < TERMH_ADJ) {
    1094:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1097:	83 c4 10             	add    $0x10,%esp
    109a:	85 c9                	test   %ecx,%ecx
    109c:	7e 2d                	jle    10cb <showPage+0xeb>
    109e:	89 c7                	mov    %eax,%edi
  int termLine = 0; // num lines we've written to the terminal so far
    10a0:	31 db                	xor    %ebx,%ebx
    10a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf("%s\n", curNode->data);
    10a8:	83 ec 08             	sub    $0x8,%esp
    10ab:	ff 77 04             	pushl  0x4(%edi)
    curNode = curNode->next;
    termLine++;
    10ae:	83 c3 01             	add    $0x1,%ebx
    printf("%s\n", curNode->data);
    10b1:	68 09 23 00 00       	push   $0x2309
    10b6:	e8 e5 0b 00 00       	call   1ca0 <printf>
    curNode = curNode->next;
    10bb:	8b 7f 08             	mov    0x8(%edi),%edi
    if (curNode == file.lines->tail) exit();
    10be:	83 c4 10             	add    $0x10,%esp
    10c1:	39 7e 04             	cmp    %edi,0x4(%esi)
    10c4:	74 31                	je     10f7 <showPage+0x117>
  while (termLine < TERMH_ADJ) {
    10c6:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
    10c9:	75 dd                	jne    10a8 <showPage+0xc8>
  printf("\n--MORE--(%d%%)", 100 * file.curLine / file.len);
    10cb:	6b 45 e0 64          	imul   $0x64,-0x20(%ebp),%eax
    10cf:	83 ec 08             	sub    $0x8,%esp
    10d2:	99                   	cltd   
    10d3:	f7 7d 18             	idivl  0x18(%ebp)
    10d6:	50                   	push   %eax
    10d7:	68 9c 22 00 00       	push   $0x229c
    10dc:	e8 bf 0b 00 00       	call   1ca0 <printf>
  printf("[Press space to continue, 'q' to quit.]\r");
    10e1:	c7 45 08 2c 20 00 00 	movl   $0x202c,0x8(%ebp)
    10e8:	83 c4 10             	add    $0x10,%esp
  }
  printPrompt(file);
}
    10eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10ee:	5b                   	pop    %ebx
    10ef:	5e                   	pop    %esi
    10f0:	5f                   	pop    %edi
    10f1:	5d                   	pop    %ebp
  printf("[Press space to continue, 'q' to quit.]\r");
    10f2:	e9 a9 0b 00 00       	jmp    1ca0 <printf>
    if (curNode == file.lines->tail) exit();
    10f7:	e8 06 08 00 00       	call   1902 <exit>
    10fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001100 <end>:

// old commands
void end(struct File* file, char* args) {
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	53                   	push   %ebx
    1104:	83 ec 08             	sub    $0x8,%esp
    1107:	8b 5d 08             	mov    0x8(%ebp),%ebx
  file->edited = 1;
  char* line = args;
  append(file->lines, line);
    110a:	8b 43 0c             	mov    0xc(%ebx),%eax
  file->edited = 1;
    110d:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
    1114:	ff 70 08             	pushl  0x8(%eax)
    1117:	ff 75 0c             	pushl  0xc(%ebp)
    111a:	50                   	push   %eax
    111b:	e8 80 f5 ff ff       	call   6a0 <insert>
  file->len++;
    1120:	83 43 10 01          	addl   $0x1,0x10(%ebx)
}
    1124:	83 c4 10             	add    $0x10,%esp
    1127:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    112a:	c9                   	leave  
    112b:	c3                   	ret    
    112c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001130 <add>:

void add(struct File* file, char* args) {
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	57                   	push   %edi
    1134:	56                   	push   %esi
    1135:	53                   	push   %ebx
    1136:	83 ec 28             	sub    $0x28,%esp
    1139:	8b 5d 08             	mov    0x8(%ebp),%ebx
    113c:	8b 75 0c             	mov    0xc(%ebp),%esi
  file->edited = 1;
    113f:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
  if (strlen(args) < 1) {
    1146:	56                   	push   %esi
    1147:	e8 e4 05 00 00       	call   1730 <strlen>
    114c:	83 c4 10             	add    $0x10,%esp
    114f:	85 c0                	test   %eax,%eax
    1151:	74 3d                	je     1190 <add+0x60>
    fprintf(2, "you need to give a line number to insert before\n");
    return;
  }
  char lineStr[10];
  getArg(lineStr, args, ' ');
    1153:	8d 7d de             	lea    -0x22(%ebp),%edi
    1156:	83 ec 04             	sub    $0x4,%esp
    1159:	6a 20                	push   $0x20
    115b:	56                   	push   %esi
    115c:	57                   	push   %edi
    115d:	e8 7e f7 ff ff       	call   8e0 <getArg>
  char* line = args;

  int lineNum = negatoi(lineStr);
    1162:	89 3c 24             	mov    %edi,(%esp)
    1165:	e8 06 f3 ff ff       	call   470 <negatoi>
  // 1-based to 0-based insert
  insert(file->lines, line, lineNum - 1);
    116a:	83 c4 0c             	add    $0xc,%esp
    116d:	83 e8 01             	sub    $0x1,%eax
    1170:	50                   	push   %eax
    1171:	56                   	push   %esi
    1172:	ff 73 0c             	pushl  0xc(%ebx)
    1175:	e8 26 f5 ff ff       	call   6a0 <insert>
  file->len++;
    117a:	83 43 10 01          	addl   $0x1,0x10(%ebx)
    117e:	83 c4 10             	add    $0x10,%esp
}
    1181:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1184:	5b                   	pop    %ebx
    1185:	5e                   	pop    %esi
    1186:	5f                   	pop    %edi
    1187:	5d                   	pop    %ebp
    1188:	c3                   	ret    
    1189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "you need to give a line number to insert before\n");
    1190:	83 ec 08             	sub    $0x8,%esp
    1193:	68 cc 20 00 00       	push   $0x20cc
    1198:	6a 02                	push   $0x2
    119a:	e8 e1 0a 00 00       	call   1c80 <fprintf>
    return;
    119f:	83 c4 10             	add    $0x10,%esp
}
    11a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11a5:	5b                   	pop    %ebx
    11a6:	5e                   	pop    %esi
    11a7:	5f                   	pop    %edi
    11a8:	5d                   	pop    %ebp
    11a9:	c3                   	ret    
    11aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000011b0 <drop>:

void drop(struct File* file, char* args) {
    11b0:	55                   	push   %ebp
    11b1:	89 e5                	mov    %esp,%ebp
    11b3:	57                   	push   %edi
    11b4:	56                   	push   %esi
    11b5:	53                   	push   %ebx
    11b6:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
    11b9:	ff 75 0c             	pushl  0xc(%ebp)
void drop(struct File* file, char* args) {
    11bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (strlen(args) < 1) {
    11bf:	e8 6c 05 00 00       	call   1730 <strlen>
    11c4:	83 c4 10             	add    $0x10,%esp
    11c7:	85 c0                	test   %eax,%eax
    11c9:	0f 84 09 01 00 00    	je     12d8 <drop+0x128>
    fprintf(2, "you need to give a range to drop\n");
    return;
  }

  int start, end;
  if (collectRange(args, &start, &end) == 1) {
    11cf:	8d 75 e4             	lea    -0x1c(%ebp),%esi
    11d2:	8d 7d e0             	lea    -0x20(%ebp),%edi
    11d5:	83 ec 04             	sub    $0x4,%esp
    11d8:	56                   	push   %esi
    11d9:	57                   	push   %edi
    11da:	ff 75 0c             	pushl  0xc(%ebp)
    11dd:	e8 6e f7 ff ff       	call   950 <collectRange>
    11e2:	83 c4 10             	add    $0x10,%esp
    11e5:	83 f8 01             	cmp    $0x1,%eax
    11e8:	0f 84 0a 01 00 00    	je     12f8 <drop+0x148>
    fprintf(2, "error: start index is larger than end index\n");
    return;
  }
  if (normalizeRange(*file, &start, &end) == 1) {
    11ee:	56                   	push   %esi
    11ef:	57                   	push   %edi
    11f0:	ff 73 14             	pushl  0x14(%ebx)
    11f3:	ff 73 10             	pushl  0x10(%ebx)
    11f6:	ff 73 0c             	pushl  0xc(%ebx)
    11f9:	ff 73 08             	pushl  0x8(%ebx)
    11fc:	ff 73 04             	pushl  0x4(%ebx)
    11ff:	ff 33                	pushl  (%ebx)
    1201:	e8 fa f5 ff ff       	call   800 <normalizeRange>
    1206:	83 c4 20             	add    $0x20,%esp
    1209:	83 f8 01             	cmp    $0x1,%eax
    120c:	0f 84 1e 01 00 00    	je     1330 <drop+0x180>
    fprintf(2, "error: bad input range. make sure start < end\n");
    return;
  }
  int numl = numLines(start, end);
    1212:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1215:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return (end - start) + 1;
    1218:	89 d6                	mov    %edx,%esi
    121a:	29 c6                	sub    %eax,%esi
    121c:	8d 7e 01             	lea    0x1(%esi),%edi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
    121f:	83 ff 01             	cmp    $0x1,%edi
    1222:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    1225:	0f 84 ed 00 00 00    	je     1318 <drop+0x168>
  else fprintf(2, "Drop %d lines [%d:%d] (y/n)? ", numl, start, end);
    122b:	83 ec 0c             	sub    $0xc,%esp
    122e:	52                   	push   %edx
    122f:	50                   	push   %eax
    1230:	ff 75 d4             	pushl  -0x2c(%ebp)
    1233:	68 3c 23 00 00       	push   $0x233c
    1238:	6a 02                	push   $0x2
    123a:	e8 41 0a 00 00       	call   1c80 <fprintf>
    123f:	83 c4 20             	add    $0x20,%esp
  if (confirmation() != 0) return;
    1242:	e8 59 f5 ff ff       	call   7a0 <confirmation>
    1247:	85 c0                	test   %eax,%eax
    1249:	75 7f                	jne    12ca <drop+0x11a>
  return nodeAt(list, pos-1);
    124b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  file->edited = 1;

  // drop lines
  struct Node* curNode = (lineAt(file->lines, start))->prev;
    124e:	8b 4b 0c             	mov    0xc(%ebx),%ecx
    1251:	83 ec 08             	sub    $0x8,%esp
  file->edited = 1;
    1254:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
    125b:	83 e8 01             	sub    $0x1,%eax
    125e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    1261:	50                   	push   %eax
    1262:	51                   	push   %ecx
    1263:	e8 18 f3 ff ff       	call   580 <nodeAt>
  struct Node* curNode = (lineAt(file->lines, start))->prev;
    1268:	8b 30                	mov    (%eax),%esi
    126a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    126d:	5a                   	pop    %edx
    126e:	59                   	pop    %ecx
    126f:	8b 4d d0             	mov    -0x30(%ebp),%ecx
    1272:	83 e8 01             	sub    $0x1,%eax
    1275:	50                   	push   %eax
    1276:	51                   	push   %ecx
    1277:	e8 04 f3 ff ff       	call   580 <nodeAt>
    127c:	83 c4 10             	add    $0x10,%esp
  struct Node* stopNode = lineAt(file->lines, end);
  while (curNode != stopNode) {
    127f:	39 c6                	cmp    %eax,%esi
    1281:	89 c7                	mov    %eax,%edi
    1283:	8b 4d d0             	mov    -0x30(%ebp),%ecx
    1286:	75 0b                	jne    1293 <drop+0xe3>
    1288:	eb 21                	jmp    12ab <drop+0xfb>
    128a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1290:	8b 4b 0c             	mov    0xc(%ebx),%ecx
    curNode = curNode->next;
    1293:	8b 76 08             	mov    0x8(%esi),%esi
    destroyNode(file->lines, curNode);
    1296:	83 ec 08             	sub    $0x8,%esp
    1299:	56                   	push   %esi
    129a:	51                   	push   %ecx
    129b:	e8 50 f3 ff ff       	call   5f0 <destroyNode>
    file->len--;
    12a0:	83 6b 10 01          	subl   $0x1,0x10(%ebx)
  while (curNode != stopNode) {
    12a4:	83 c4 10             	add    $0x10,%esp
    12a7:	39 fe                	cmp    %edi,%esi
    12a9:	75 e5                	jne    1290 <drop+0xe0>
  }
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
    12ab:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
    12af:	0f 84 93 00 00 00    	je     1348 <drop+0x198>
  else fprintf(2, "%d lines dropped\n", numl);
    12b5:	83 ec 04             	sub    $0x4,%esp
    12b8:	ff 75 d4             	pushl  -0x2c(%ebp)
    12bb:	68 6b 23 00 00       	push   $0x236b
    12c0:	6a 02                	push   $0x2
    12c2:	e8 b9 09 00 00       	call   1c80 <fprintf>
    12c7:	83 c4 10             	add    $0x10,%esp
  return;
}
    12ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12cd:	5b                   	pop    %ebx
    12ce:	5e                   	pop    %esi
    12cf:	5f                   	pop    %edi
    12d0:	5d                   	pop    %ebp
    12d1:	c3                   	ret    
    12d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "you need to give a range to drop\n");
    12d8:	83 ec 08             	sub    $0x8,%esp
    12db:	68 00 21 00 00       	push   $0x2100
    12e0:	6a 02                	push   $0x2
    12e2:	e8 99 09 00 00       	call   1c80 <fprintf>
    return;
    12e7:	83 c4 10             	add    $0x10,%esp
}
    12ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12ed:	5b                   	pop    %ebx
    12ee:	5e                   	pop    %esi
    12ef:	5f                   	pop    %edi
    12f0:	5d                   	pop    %ebp
    12f1:	c3                   	ret    
    12f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: start index is larger than end index\n");
    12f8:	83 ec 08             	sub    $0x8,%esp
    12fb:	68 24 21 00 00       	push   $0x2124
    1300:	6a 02                	push   $0x2
    1302:	e8 79 09 00 00       	call   1c80 <fprintf>
    return;
    1307:	83 c4 10             	add    $0x10,%esp
}
    130a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    130d:	5b                   	pop    %ebx
    130e:	5e                   	pop    %esi
    130f:	5f                   	pop    %edi
    1310:	5d                   	pop    %ebp
    1311:	c3                   	ret    
    1312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if (numl == 1) fprintf(2, "Drop line %d (y/n)? ", start);
    1318:	83 ec 04             	sub    $0x4,%esp
    131b:	50                   	push   %eax
    131c:	68 27 23 00 00       	push   $0x2327
    1321:	6a 02                	push   $0x2
    1323:	e8 58 09 00 00       	call   1c80 <fprintf>
    1328:	83 c4 10             	add    $0x10,%esp
    132b:	e9 12 ff ff ff       	jmp    1242 <drop+0x92>
    fprintf(2, "error: bad input range. make sure start < end\n");
    1330:	83 ec 08             	sub    $0x8,%esp
    1333:	68 54 21 00 00       	push   $0x2154
    1338:	6a 02                	push   $0x2
    133a:	e8 41 09 00 00       	call   1c80 <fprintf>
    return;
    133f:	83 c4 10             	add    $0x10,%esp
    1342:	eb 86                	jmp    12ca <drop+0x11a>
    1344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (numl == 1) fprintf(2, "line %d dropped\n", start);
    1348:	83 ec 04             	sub    $0x4,%esp
    134b:	ff 75 e0             	pushl  -0x20(%ebp)
    134e:	68 5a 23 00 00       	push   $0x235a
    1353:	6a 02                	push   $0x2
    1355:	e8 26 09 00 00       	call   1c80 <fprintf>
    135a:	83 c4 10             	add    $0x10,%esp
    135d:	e9 68 ff ff ff       	jmp    12ca <drop+0x11a>
    1362:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001370 <edit>:

void edit(struct File* file, char* args) {
    1370:	55                   	push   %ebp
    1371:	89 e5                	mov    %esp,%ebp
    1373:	57                   	push   %edi
    1374:	56                   	push   %esi
    1375:	53                   	push   %ebx
    1376:	83 ec 28             	sub    $0x28,%esp
    1379:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if (strlen(args) < 1) {
    137c:	53                   	push   %ebx
    137d:	e8 ae 03 00 00       	call   1730 <strlen>
    1382:	83 c4 10             	add    $0x10,%esp
    1385:	85 c0                	test   %eax,%eax
    1387:	75 1f                	jne    13a8 <edit+0x38>
    fprintf(2, "you need to give a line number to replace\n");
    1389:	83 ec 08             	sub    $0x8,%esp
    138c:	68 84 21 00 00       	push   $0x2184
    1391:	6a 02                	push   $0x2
    1393:	e8 e8 08 00 00       	call   1c80 <fprintf>
    return;
    1398:	83 c4 10             	add    $0x10,%esp

  // remove
  destroyNode(file->lines, lineAt(file->lines, lineNum));
  // 1-based to 0-based insert
  insert(file->lines, line, lineNum - 1);
}
    139b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    139e:	5b                   	pop    %ebx
    139f:	5e                   	pop    %esi
    13a0:	5f                   	pop    %edi
    13a1:	5d                   	pop    %ebp
    13a2:	c3                   	ret    
    13a3:	90                   	nop
    13a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  getArg(lineStr, args, ' ');
    13a8:	8d 75 de             	lea    -0x22(%ebp),%esi
    13ab:	83 ec 04             	sub    $0x4,%esp
    13ae:	6a 20                	push   $0x20
    13b0:	53                   	push   %ebx
    13b1:	56                   	push   %esi
    13b2:	e8 29 f5 ff ff       	call   8e0 <getArg>
  int lineNum = negatoi(lineStr);
    13b7:	89 34 24             	mov    %esi,(%esp)
    13ba:	e8 b1 f0 ff ff       	call   470 <negatoi>
  fprintf(2, "replace line %d (y/n)? ", lineNum);
    13bf:	83 c4 0c             	add    $0xc,%esp
  int lineNum = negatoi(lineStr);
    13c2:	89 c6                	mov    %eax,%esi
  fprintf(2, "replace line %d (y/n)? ", lineNum);
    13c4:	50                   	push   %eax
    13c5:	68 7d 23 00 00       	push   $0x237d
    13ca:	6a 02                	push   $0x2
    13cc:	e8 af 08 00 00       	call   1c80 <fprintf>
  if (confirmation() != 0) return;
    13d1:	e8 ca f3 ff ff       	call   7a0 <confirmation>
    13d6:	83 c4 10             	add    $0x10,%esp
    13d9:	85 c0                	test   %eax,%eax
    13db:	75 be                	jne    139b <edit+0x2b>
  file->edited = 1;
    13dd:	8b 45 08             	mov    0x8(%ebp),%eax
    13e0:	83 ec 08             	sub    $0x8,%esp
    13e3:	83 ee 01             	sub    $0x1,%esi
  destroyNode(file->lines, lineAt(file->lines, lineNum));
    13e6:	8b 78 0c             	mov    0xc(%eax),%edi
  file->edited = 1;
    13e9:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    13f0:	56                   	push   %esi
    13f1:	57                   	push   %edi
    13f2:	e8 89 f1 ff ff       	call   580 <nodeAt>
    13f7:	5a                   	pop    %edx
    13f8:	59                   	pop    %ecx
  destroyNode(file->lines, lineAt(file->lines, lineNum));
    13f9:	50                   	push   %eax
    13fa:	57                   	push   %edi
    13fb:	e8 f0 f1 ff ff       	call   5f0 <destroyNode>
  insert(file->lines, line, lineNum - 1);
    1400:	8b 45 08             	mov    0x8(%ebp),%eax
    1403:	83 c4 0c             	add    $0xc,%esp
    1406:	56                   	push   %esi
    1407:	53                   	push   %ebx
    1408:	ff 70 0c             	pushl  0xc(%eax)
    140b:	e8 90 f2 ff ff       	call   6a0 <insert>
    1410:	83 c4 10             	add    $0x10,%esp
}
    1413:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1416:	5b                   	pop    %ebx
    1417:	5e                   	pop    %esi
    1418:	5f                   	pop    %edi
    1419:	5d                   	pop    %ebp
    141a:	c3                   	ret    
    141b:	90                   	nop
    141c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001420 <list>:

void list(struct File file, char* args) {
    1420:	55                   	push   %ebp
    1421:	89 e5                	mov    %esp,%ebp
    1423:	57                   	push   %edi
    1424:	56                   	push   %esi
    1425:	53                   	push   %ebx
    1426:	83 ec 38             	sub    $0x38,%esp
  if (strlen(args) < 1) {
    1429:	ff 75 20             	pushl  0x20(%ebp)
    142c:	8b 75 14             	mov    0x14(%ebp),%esi
    142f:	e8 fc 02 00 00       	call   1730 <strlen>
    1434:	83 c4 10             	add    $0x10,%esp
    1437:	85 c0                	test   %eax,%eax
    1439:	75 1d                	jne    1458 <list+0x38>
    fprintf(2, "you need to give a range to list\n");
    143b:	83 ec 08             	sub    $0x8,%esp
    143e:	68 b0 21 00 00       	push   $0x21b0
    1443:	6a 02                	push   $0x2
    1445:	e8 36 08 00 00       	call   1c80 <fprintf>
    return;
    144a:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
    curNode = curNode->next;
    if (curNode == file.lines->tail) return;
    printl(++lineNum, curNode->data);
  }
}
    144d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1450:	5b                   	pop    %ebx
    1451:	5e                   	pop    %esi
    1452:	5f                   	pop    %edi
    1453:	5d                   	pop    %ebp
    1454:	c3                   	ret    
    1455:	8d 76 00             	lea    0x0(%esi),%esi
  if (collectRange(args, &start, &end) == 1) {
    1458:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
    145b:	8d 7d e0             	lea    -0x20(%ebp),%edi
    145e:	83 ec 04             	sub    $0x4,%esp
    1461:	53                   	push   %ebx
    1462:	57                   	push   %edi
    1463:	ff 75 20             	pushl  0x20(%ebp)
    1466:	e8 e5 f4 ff ff       	call   950 <collectRange>
    146b:	83 c4 10             	add    $0x10,%esp
    146e:	83 f8 01             	cmp    $0x1,%eax
    1471:	0f 84 91 00 00 00    	je     1508 <list+0xe8>
  if (normalizeRange(file, &start, &end) == 1) {
    1477:	53                   	push   %ebx
    1478:	57                   	push   %edi
    1479:	ff 75 1c             	pushl  0x1c(%ebp)
    147c:	ff 75 18             	pushl  0x18(%ebp)
    147f:	ff 75 14             	pushl  0x14(%ebp)
    1482:	ff 75 10             	pushl  0x10(%ebp)
    1485:	ff 75 0c             	pushl  0xc(%ebp)
    1488:	ff 75 08             	pushl  0x8(%ebp)
    148b:	e8 70 f3 ff ff       	call   800 <normalizeRange>
    1490:	83 c4 20             	add    $0x20,%esp
    1493:	83 f8 01             	cmp    $0x1,%eax
    1496:	0f 84 8c 00 00 00    	je     1528 <list+0x108>
  lineNum = start - 1;
    149c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    149f:	83 ec 08             	sub    $0x8,%esp
    14a2:	8d 78 ff             	lea    -0x1(%eax),%edi
    14a5:	57                   	push   %edi
    14a6:	56                   	push   %esi
    14a7:	e8 d4 f0 ff ff       	call   580 <nodeAt>
  struct Node* curNode = (lineAt(file.lines, start))->prev;
    14ac:	8b 18                	mov    (%eax),%ebx
    14ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14b1:	5a                   	pop    %edx
    14b2:	59                   	pop    %ecx
    14b3:	83 e8 01             	sub    $0x1,%eax
    14b6:	50                   	push   %eax
    14b7:	56                   	push   %esi
    14b8:	e8 c3 f0 ff ff       	call   580 <nodeAt>
    14bd:	83 c4 10             	add    $0x10,%esp
  while (curNode != stopNode) {
    14c0:	39 d8                	cmp    %ebx,%eax
    14c2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    14c5:	74 86                	je     144d <list+0x2d>
    curNode = curNode->next;
    14c7:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
    14ca:	3b 5e 04             	cmp    0x4(%esi),%ebx
    14cd:	75 15                	jne    14e4 <list+0xc4>
    14cf:	e9 79 ff ff ff       	jmp    144d <list+0x2d>
    14d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
    14d8:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) return;
    14db:	39 5e 04             	cmp    %ebx,0x4(%esi)
    14de:	0f 84 69 ff ff ff    	je     144d <list+0x2d>
    printl(++lineNum, curNode->data);
    14e4:	83 ec 08             	sub    $0x8,%esp
    14e7:	83 c7 01             	add    $0x1,%edi
    14ea:	ff 73 04             	pushl  0x4(%ebx)
    14ed:	57                   	push   %edi
    14ee:	e8 8d f7 ff ff       	call   c80 <printl>
  while (curNode != stopNode) {
    14f3:	83 c4 10             	add    $0x10,%esp
    14f6:	39 5d d4             	cmp    %ebx,-0x2c(%ebp)
    14f9:	75 dd                	jne    14d8 <list+0xb8>
}
    14fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14fe:	5b                   	pop    %ebx
    14ff:	5e                   	pop    %esi
    1500:	5f                   	pop    %edi
    1501:	5d                   	pop    %ebp
    1502:	c3                   	ret    
    1503:	90                   	nop
    1504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "error: start index is larger than end index\n");
    1508:	83 ec 08             	sub    $0x8,%esp
    150b:	68 24 21 00 00       	push   $0x2124
    1510:	6a 02                	push   $0x2
    1512:	e8 69 07 00 00       	call   1c80 <fprintf>
    return;
    1517:	83 c4 10             	add    $0x10,%esp
}
    151a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    151d:	5b                   	pop    %ebx
    151e:	5e                   	pop    %esi
    151f:	5f                   	pop    %edi
    1520:	5d                   	pop    %ebp
    1521:	c3                   	ret    
    1522:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fprintf(2, "error: bad input range. make sure start < end\n");
    1528:	83 ec 08             	sub    $0x8,%esp
    152b:	68 54 21 00 00       	push   $0x2154
    1530:	6a 02                	push   $0x2
    1532:	e8 49 07 00 00       	call   1c80 <fprintf>
    return;
    1537:	83 c4 10             	add    $0x10,%esp
    153a:	e9 0e ff ff ff       	jmp    144d <list+0x2d>
    153f:	90                   	nop

00001540 <show>:

void show(struct File file, char* args) {
    1540:	55                   	push   %ebp
    1541:	89 e5                	mov    %esp,%ebp
    1543:	57                   	push   %edi
    1544:	56                   	push   %esi
    1545:	53                   	push   %ebx
    1546:	83 ec 0c             	sub    $0xc,%esp
    1549:	8b 7d 14             	mov    0x14(%ebp),%edi
  struct Node* cur = file.lines->head->next;
    154c:	8b 07                	mov    (%edi),%eax
    154e:	8b 58 08             	mov    0x8(%eax),%ebx
  int lineNum = 1;
  while (cur != file.lines->tail) {
    1551:	3b 5f 04             	cmp    0x4(%edi),%ebx
    1554:	74 24                	je     157a <show+0x3a>
  int lineNum = 1;
    1556:	be 01 00 00 00       	mov    $0x1,%esi
    155b:	90                   	nop
    155c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printl(lineNum, cur->data);
    1560:	83 ec 08             	sub    $0x8,%esp
    1563:	ff 73 04             	pushl  0x4(%ebx)
    1566:	56                   	push   %esi
    cur = cur->next;
    lineNum++;
    1567:	83 c6 01             	add    $0x1,%esi
    printl(lineNum, cur->data);
    156a:	e8 11 f7 ff ff       	call   c80 <printl>
    cur = cur->next;
    156f:	8b 5b 08             	mov    0x8(%ebx),%ebx
  while (cur != file.lines->tail) {
    1572:	83 c4 10             	add    $0x10,%esp
    1575:	39 5f 04             	cmp    %ebx,0x4(%edi)
    1578:	75 e6                	jne    1560 <show+0x20>
  }
}
    157a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    157d:	5b                   	pop    %ebx
    157e:	5e                   	pop    %esi
    157f:	5f                   	pop    %edi
    1580:	5d                   	pop    %ebp
    1581:	c3                   	ret    
    1582:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001590 <quit>:

void quit(struct File* file) {
    1590:	55                   	push   %ebp
    1591:	89 e5                	mov    %esp,%ebp
    1593:	56                   	push   %esi
    1594:	53                   	push   %ebx
    1595:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (file->edited == 0) return;
    1598:	8b 4b 14             	mov    0x14(%ebx),%ecx
    159b:	85 c9                	test   %ecx,%ecx
    159d:	75 11                	jne    15b0 <quit+0x20>
    cur = cur->next;
  }
  close(file->fd);
  fprintf(2, "changes saved\n");
  return;
}
    159f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    15a2:	5b                   	pop    %ebx
    15a3:	5e                   	pop    %esi
    15a4:	5d                   	pop    %ebp
    15a5:	c3                   	ret    
    15a6:	8d 76 00             	lea    0x0(%esi),%esi
    15a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  fprintf(2, "save changes (y/n)? ");
    15b0:	83 ec 08             	sub    $0x8,%esp
    15b3:	68 95 23 00 00       	push   $0x2395
    15b8:	6a 02                	push   $0x2
    15ba:	e8 c1 06 00 00       	call   1c80 <fprintf>
  if (confirmation() != 0) return;
    15bf:	e8 dc f1 ff ff       	call   7a0 <confirmation>
    15c4:	83 c4 10             	add    $0x10,%esp
    15c7:	85 c0                	test   %eax,%eax
    15c9:	75 d4                	jne    159f <quit+0xf>
  if (unlink(file->filename) < 0) {
    15cb:	83 ec 0c             	sub    $0xc,%esp
    15ce:	ff 33                	pushl  (%ebx)
    15d0:	e8 85 03 00 00       	call   195a <unlink>
    15d5:	83 c4 10             	add    $0x10,%esp
    15d8:	85 c0                	test   %eax,%eax
    15da:	0f 88 90 00 00 00    	js     1670 <quit+0xe0>
  file->fd = open(file->filename, O_CREATE|O_RDWR);
    15e0:	83 ec 08             	sub    $0x8,%esp
    15e3:	68 02 02 00 00       	push   $0x202
    15e8:	ff 33                	pushl  (%ebx)
    15ea:	e8 5b 03 00 00       	call   194a <open>
  if (file->fd < 0) {
    15ef:	83 c4 10             	add    $0x10,%esp
    15f2:	85 c0                	test   %eax,%eax
  file->fd = open(file->filename, O_CREATE|O_RDWR);
    15f4:	89 43 04             	mov    %eax,0x4(%ebx)
  if (file->fd < 0) {
    15f7:	0f 88 93 00 00 00    	js     1690 <quit+0x100>
  struct Node* cur = file->lines->head->next;
    15fd:	8b 53 0c             	mov    0xc(%ebx),%edx
    1600:	8b 0a                	mov    (%edx),%ecx
    1602:	8b 71 08             	mov    0x8(%ecx),%esi
  while (cur != file->lines->tail) {
    1605:	3b 72 04             	cmp    0x4(%edx),%esi
    1608:	74 43                	je     164d <quit+0xbd>
    160a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    write(file->fd, cur->data, strlen(cur->data));
    1610:	83 ec 0c             	sub    $0xc,%esp
    1613:	ff 76 04             	pushl  0x4(%esi)
    1616:	e8 15 01 00 00       	call   1730 <strlen>
    161b:	83 c4 0c             	add    $0xc,%esp
    161e:	50                   	push   %eax
    161f:	ff 76 04             	pushl  0x4(%esi)
    1622:	ff 73 04             	pushl  0x4(%ebx)
    1625:	e8 00 03 00 00       	call   192a <write>
    write(file->fd, "\n", sizeof(char));
    162a:	83 c4 0c             	add    $0xc,%esp
    162d:	6a 01                	push   $0x1
    162f:	68 3f 22 00 00       	push   $0x223f
    1634:	ff 73 04             	pushl  0x4(%ebx)
    1637:	e8 ee 02 00 00       	call   192a <write>
  while (cur != file->lines->tail) {
    163c:	8b 43 0c             	mov    0xc(%ebx),%eax
    cur = cur->next;
    163f:	8b 76 08             	mov    0x8(%esi),%esi
  while (cur != file->lines->tail) {
    1642:	83 c4 10             	add    $0x10,%esp
    1645:	39 70 04             	cmp    %esi,0x4(%eax)
    1648:	75 c6                	jne    1610 <quit+0x80>
    164a:	8b 43 04             	mov    0x4(%ebx),%eax
  close(file->fd);
    164d:	83 ec 0c             	sub    $0xc,%esp
    1650:	50                   	push   %eax
    1651:	e8 dc 02 00 00       	call   1932 <close>
  fprintf(2, "changes saved\n");
    1656:	58                   	pop    %eax
    1657:	5a                   	pop    %edx
    1658:	68 aa 23 00 00       	push   $0x23aa
    165d:	6a 02                	push   $0x2
    165f:	e8 1c 06 00 00       	call   1c80 <fprintf>
  return;
    1664:	83 c4 10             	add    $0x10,%esp
    1667:	e9 33 ff ff ff       	jmp    159f <quit+0xf>
    166c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "could not clear file for writing. changes lost\n");
    1670:	83 ec 08             	sub    $0x8,%esp
    1673:	68 d4 21 00 00       	push   $0x21d4
    1678:	6a 02                	push   $0x2
    167a:	e8 01 06 00 00       	call   1c80 <fprintf>
    return;
    167f:	83 c4 10             	add    $0x10,%esp
    1682:	e9 18 ff ff ff       	jmp    159f <quit+0xf>
    1687:	89 f6                	mov    %esi,%esi
    1689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    fprintf(2, "could not open file for writing. changes lost\n");
    1690:	83 ec 08             	sub    $0x8,%esp
    1693:	68 04 22 00 00       	push   $0x2204
    1698:	6a 02                	push   $0x2
    169a:	e8 e1 05 00 00       	call   1c80 <fprintf>
    return;
    169f:	83 c4 10             	add    $0x10,%esp
    16a2:	e9 f8 fe ff ff       	jmp    159f <quit+0xf>
    16a7:	66 90                	xchg   %ax,%ax
    16a9:	66 90                	xchg   %ax,%ax
    16ab:	66 90                	xchg   %ax,%ax
    16ad:	66 90                	xchg   %ax,%ax
    16af:	90                   	nop

000016b0 <strcpy>:
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
    16b0:	55                   	push   %ebp
    16b1:	89 e5                	mov    %esp,%ebp
    16b3:	53                   	push   %ebx
    16b4:	8b 45 08             	mov    0x8(%ebp),%eax
    16b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    16ba:	89 c2                	mov    %eax,%edx
    16bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    16c0:	83 c1 01             	add    $0x1,%ecx
    16c3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    16c7:	83 c2 01             	add    $0x1,%edx
    16ca:	84 db                	test   %bl,%bl
    16cc:	88 5a ff             	mov    %bl,-0x1(%edx)
    16cf:	75 ef                	jne    16c0 <strcpy+0x10>
    ;
  return os;
}
    16d1:	5b                   	pop    %ebx
    16d2:	5d                   	pop    %ebp
    16d3:	c3                   	ret    
    16d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    16da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000016e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    16e0:	55                   	push   %ebp
    16e1:	89 e5                	mov    %esp,%ebp
    16e3:	53                   	push   %ebx
    16e4:	8b 55 08             	mov    0x8(%ebp),%edx
    16e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    16ea:	0f b6 02             	movzbl (%edx),%eax
    16ed:	0f b6 19             	movzbl (%ecx),%ebx
    16f0:	84 c0                	test   %al,%al
    16f2:	75 1c                	jne    1710 <strcmp+0x30>
    16f4:	eb 2a                	jmp    1720 <strcmp+0x40>
    16f6:	8d 76 00             	lea    0x0(%esi),%esi
    16f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    1700:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1703:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    1706:	83 c1 01             	add    $0x1,%ecx
    1709:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    170c:	84 c0                	test   %al,%al
    170e:	74 10                	je     1720 <strcmp+0x40>
    1710:	38 d8                	cmp    %bl,%al
    1712:	74 ec                	je     1700 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    1714:	29 d8                	sub    %ebx,%eax
}
    1716:	5b                   	pop    %ebx
    1717:	5d                   	pop    %ebp
    1718:	c3                   	ret    
    1719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1720:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    1722:	29 d8                	sub    %ebx,%eax
}
    1724:	5b                   	pop    %ebx
    1725:	5d                   	pop    %ebp
    1726:	c3                   	ret    
    1727:	89 f6                	mov    %esi,%esi
    1729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001730 <strlen>:

uint
strlen(const char *s)
{
    1730:	55                   	push   %ebp
    1731:	89 e5                	mov    %esp,%ebp
    1733:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1736:	80 39 00             	cmpb   $0x0,(%ecx)
    1739:	74 15                	je     1750 <strlen+0x20>
    173b:	31 d2                	xor    %edx,%edx
    173d:	8d 76 00             	lea    0x0(%esi),%esi
    1740:	83 c2 01             	add    $0x1,%edx
    1743:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1747:	89 d0                	mov    %edx,%eax
    1749:	75 f5                	jne    1740 <strlen+0x10>
    ;
  return n;
}
    174b:	5d                   	pop    %ebp
    174c:	c3                   	ret    
    174d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    1750:	31 c0                	xor    %eax,%eax
}
    1752:	5d                   	pop    %ebp
    1753:	c3                   	ret    
    1754:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    175a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001760 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1760:	55                   	push   %ebp
    1761:	89 e5                	mov    %esp,%ebp
    1763:	57                   	push   %edi
    1764:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1767:	8b 4d 10             	mov    0x10(%ebp),%ecx
    176a:	8b 45 0c             	mov    0xc(%ebp),%eax
    176d:	89 d7                	mov    %edx,%edi
    176f:	fc                   	cld    
    1770:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1772:	89 d0                	mov    %edx,%eax
    1774:	5f                   	pop    %edi
    1775:	5d                   	pop    %ebp
    1776:	c3                   	ret    
    1777:	89 f6                	mov    %esi,%esi
    1779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001780 <strchr>:

char*
strchr(const char *s, char c)
{
    1780:	55                   	push   %ebp
    1781:	89 e5                	mov    %esp,%ebp
    1783:	53                   	push   %ebx
    1784:	8b 45 08             	mov    0x8(%ebp),%eax
    1787:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    178a:	0f b6 10             	movzbl (%eax),%edx
    178d:	84 d2                	test   %dl,%dl
    178f:	74 1d                	je     17ae <strchr+0x2e>
    if(*s == c)
    1791:	38 d3                	cmp    %dl,%bl
    1793:	89 d9                	mov    %ebx,%ecx
    1795:	75 0d                	jne    17a4 <strchr+0x24>
    1797:	eb 17                	jmp    17b0 <strchr+0x30>
    1799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    17a0:	38 ca                	cmp    %cl,%dl
    17a2:	74 0c                	je     17b0 <strchr+0x30>
  for(; *s; s++)
    17a4:	83 c0 01             	add    $0x1,%eax
    17a7:	0f b6 10             	movzbl (%eax),%edx
    17aa:	84 d2                	test   %dl,%dl
    17ac:	75 f2                	jne    17a0 <strchr+0x20>
      return (char*)s;
  return 0;
    17ae:	31 c0                	xor    %eax,%eax
}
    17b0:	5b                   	pop    %ebx
    17b1:	5d                   	pop    %ebp
    17b2:	c3                   	ret    
    17b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    17b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000017c0 <gets>:

char*
gets(char *buf, int max)
{
    17c0:	55                   	push   %ebp
    17c1:	89 e5                	mov    %esp,%ebp
    17c3:	57                   	push   %edi
    17c4:	56                   	push   %esi
    17c5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    17c6:	31 f6                	xor    %esi,%esi
    17c8:	89 f3                	mov    %esi,%ebx
{
    17ca:	83 ec 1c             	sub    $0x1c,%esp
    17cd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    17d0:	eb 2f                	jmp    1801 <gets+0x41>
    17d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    17d8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    17db:	83 ec 04             	sub    $0x4,%esp
    17de:	6a 01                	push   $0x1
    17e0:	50                   	push   %eax
    17e1:	6a 00                	push   $0x0
    17e3:	e8 32 01 00 00       	call   191a <read>
    if(cc < 1)
    17e8:	83 c4 10             	add    $0x10,%esp
    17eb:	85 c0                	test   %eax,%eax
    17ed:	7e 1c                	jle    180b <gets+0x4b>
      break;
    buf[i++] = c;
    17ef:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    17f3:	83 c7 01             	add    $0x1,%edi
    17f6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    17f9:	3c 0a                	cmp    $0xa,%al
    17fb:	74 23                	je     1820 <gets+0x60>
    17fd:	3c 0d                	cmp    $0xd,%al
    17ff:	74 1f                	je     1820 <gets+0x60>
  for(i=0; i+1 < max; ){
    1801:	83 c3 01             	add    $0x1,%ebx
    1804:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1807:	89 fe                	mov    %edi,%esi
    1809:	7c cd                	jl     17d8 <gets+0x18>
    180b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    180d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1810:	c6 03 00             	movb   $0x0,(%ebx)
}
    1813:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1816:	5b                   	pop    %ebx
    1817:	5e                   	pop    %esi
    1818:	5f                   	pop    %edi
    1819:	5d                   	pop    %ebp
    181a:	c3                   	ret    
    181b:	90                   	nop
    181c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1820:	8b 75 08             	mov    0x8(%ebp),%esi
    1823:	8b 45 08             	mov    0x8(%ebp),%eax
    1826:	01 de                	add    %ebx,%esi
    1828:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    182a:	c6 03 00             	movb   $0x0,(%ebx)
}
    182d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1830:	5b                   	pop    %ebx
    1831:	5e                   	pop    %esi
    1832:	5f                   	pop    %edi
    1833:	5d                   	pop    %ebp
    1834:	c3                   	ret    
    1835:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001840 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
    1840:	55                   	push   %ebp
    1841:	89 e5                	mov    %esp,%ebp
    1843:	56                   	push   %esi
    1844:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1845:	83 ec 08             	sub    $0x8,%esp
    1848:	6a 00                	push   $0x0
    184a:	ff 75 08             	pushl  0x8(%ebp)
    184d:	e8 f8 00 00 00       	call   194a <open>
  if(fd < 0)
    1852:	83 c4 10             	add    $0x10,%esp
    1855:	85 c0                	test   %eax,%eax
    1857:	78 27                	js     1880 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1859:	83 ec 08             	sub    $0x8,%esp
    185c:	ff 75 0c             	pushl  0xc(%ebp)
    185f:	89 c3                	mov    %eax,%ebx
    1861:	50                   	push   %eax
    1862:	e8 fb 00 00 00       	call   1962 <fstat>
  close(fd);
    1867:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    186a:	89 c6                	mov    %eax,%esi
  close(fd);
    186c:	e8 c1 00 00 00       	call   1932 <close>
  return r;
    1871:	83 c4 10             	add    $0x10,%esp
}
    1874:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1877:	89 f0                	mov    %esi,%eax
    1879:	5b                   	pop    %ebx
    187a:	5e                   	pop    %esi
    187b:	5d                   	pop    %ebp
    187c:	c3                   	ret    
    187d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1880:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1885:	eb ed                	jmp    1874 <stat+0x34>
    1887:	89 f6                	mov    %esi,%esi
    1889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001890 <atoi>:

int
atoi(const char *s)
{
    1890:	55                   	push   %ebp
    1891:	89 e5                	mov    %esp,%ebp
    1893:	53                   	push   %ebx
    1894:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1897:	0f be 11             	movsbl (%ecx),%edx
    189a:	8d 42 d0             	lea    -0x30(%edx),%eax
    189d:	3c 09                	cmp    $0x9,%al
  n = 0;
    189f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    18a4:	77 1f                	ja     18c5 <atoi+0x35>
    18a6:	8d 76 00             	lea    0x0(%esi),%esi
    18a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    18b0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    18b3:	83 c1 01             	add    $0x1,%ecx
    18b6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    18ba:	0f be 11             	movsbl (%ecx),%edx
    18bd:	8d 5a d0             	lea    -0x30(%edx),%ebx
    18c0:	80 fb 09             	cmp    $0x9,%bl
    18c3:	76 eb                	jbe    18b0 <atoi+0x20>
  return n;
}
    18c5:	5b                   	pop    %ebx
    18c6:	5d                   	pop    %ebp
    18c7:	c3                   	ret    
    18c8:	90                   	nop
    18c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000018d0 <memmove>:


void*
memmove(void *vdst, const void *vsrc, int n)
{
    18d0:	55                   	push   %ebp
    18d1:	89 e5                	mov    %esp,%ebp
    18d3:	56                   	push   %esi
    18d4:	53                   	push   %ebx
    18d5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    18d8:	8b 45 08             	mov    0x8(%ebp),%eax
    18db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    18de:	85 db                	test   %ebx,%ebx
    18e0:	7e 14                	jle    18f6 <memmove+0x26>
    18e2:	31 d2                	xor    %edx,%edx
    18e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    18e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    18ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    18ef:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    18f2:	39 d3                	cmp    %edx,%ebx
    18f4:	75 f2                	jne    18e8 <memmove+0x18>
  return vdst;
}
    18f6:	5b                   	pop    %ebx
    18f7:	5e                   	pop    %esi
    18f8:	5d                   	pop    %ebp
    18f9:	c3                   	ret    

000018fa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    18fa:	b8 01 00 00 00       	mov    $0x1,%eax
    18ff:	cd 40                	int    $0x40
    1901:	c3                   	ret    

00001902 <exit>:
SYSCALL(exit)
    1902:	b8 02 00 00 00       	mov    $0x2,%eax
    1907:	cd 40                	int    $0x40
    1909:	c3                   	ret    

0000190a <wait>:
SYSCALL(wait)
    190a:	b8 03 00 00 00       	mov    $0x3,%eax
    190f:	cd 40                	int    $0x40
    1911:	c3                   	ret    

00001912 <pipe>:
SYSCALL(pipe)
    1912:	b8 04 00 00 00       	mov    $0x4,%eax
    1917:	cd 40                	int    $0x40
    1919:	c3                   	ret    

0000191a <read>:
SYSCALL(read)
    191a:	b8 05 00 00 00       	mov    $0x5,%eax
    191f:	cd 40                	int    $0x40
    1921:	c3                   	ret    

00001922 <steal>:
SYSCALL(steal)
    1922:	b8 17 00 00 00       	mov    $0x17,%eax
    1927:	cd 40                	int    $0x40
    1929:	c3                   	ret    

0000192a <write>:
SYSCALL(write)
    192a:	b8 10 00 00 00       	mov    $0x10,%eax
    192f:	cd 40                	int    $0x40
    1931:	c3                   	ret    

00001932 <close>:
SYSCALL(close)
    1932:	b8 15 00 00 00       	mov    $0x15,%eax
    1937:	cd 40                	int    $0x40
    1939:	c3                   	ret    

0000193a <kill>:
SYSCALL(kill)
    193a:	b8 06 00 00 00       	mov    $0x6,%eax
    193f:	cd 40                	int    $0x40
    1941:	c3                   	ret    

00001942 <exec>:
SYSCALL(exec)
    1942:	b8 07 00 00 00       	mov    $0x7,%eax
    1947:	cd 40                	int    $0x40
    1949:	c3                   	ret    

0000194a <open>:
SYSCALL(open)
    194a:	b8 0f 00 00 00       	mov    $0xf,%eax
    194f:	cd 40                	int    $0x40
    1951:	c3                   	ret    

00001952 <mknod>:
SYSCALL(mknod)
    1952:	b8 11 00 00 00       	mov    $0x11,%eax
    1957:	cd 40                	int    $0x40
    1959:	c3                   	ret    

0000195a <unlink>:
SYSCALL(unlink)
    195a:	b8 12 00 00 00       	mov    $0x12,%eax
    195f:	cd 40                	int    $0x40
    1961:	c3                   	ret    

00001962 <fstat>:
SYSCALL(fstat)
    1962:	b8 08 00 00 00       	mov    $0x8,%eax
    1967:	cd 40                	int    $0x40
    1969:	c3                   	ret    

0000196a <link>:
SYSCALL(link)
    196a:	b8 13 00 00 00       	mov    $0x13,%eax
    196f:	cd 40                	int    $0x40
    1971:	c3                   	ret    

00001972 <mkdir>:
SYSCALL(mkdir)
    1972:	b8 14 00 00 00       	mov    $0x14,%eax
    1977:	cd 40                	int    $0x40
    1979:	c3                   	ret    

0000197a <chdir>:
SYSCALL(chdir)
    197a:	b8 09 00 00 00       	mov    $0x9,%eax
    197f:	cd 40                	int    $0x40
    1981:	c3                   	ret    

00001982 <dup>:
SYSCALL(dup)
    1982:	b8 0a 00 00 00       	mov    $0xa,%eax
    1987:	cd 40                	int    $0x40
    1989:	c3                   	ret    

0000198a <getpid>:
SYSCALL(getpid)
    198a:	b8 0b 00 00 00       	mov    $0xb,%eax
    198f:	cd 40                	int    $0x40
    1991:	c3                   	ret    

00001992 <sbrk>:
SYSCALL(sbrk)
    1992:	b8 0c 00 00 00       	mov    $0xc,%eax
    1997:	cd 40                	int    $0x40
    1999:	c3                   	ret    

0000199a <sleep>:
SYSCALL(sleep)
    199a:	b8 0d 00 00 00       	mov    $0xd,%eax
    199f:	cd 40                	int    $0x40
    19a1:	c3                   	ret    

000019a2 <uptime>:
SYSCALL(uptime)
    19a2:	b8 0e 00 00 00       	mov    $0xe,%eax
    19a7:	cd 40                	int    $0x40
    19a9:	c3                   	ret    

000019aa <cpuhalt>:
SYSCALL(cpuhalt)
    19aa:	b8 16 00 00 00       	mov    $0x16,%eax
    19af:	cd 40                	int    $0x40
    19b1:	c3                   	ret    
    19b2:	66 90                	xchg   %ax,%ax
    19b4:	66 90                	xchg   %ax,%ax
    19b6:	66 90                	xchg   %ax,%ax
    19b8:	66 90                	xchg   %ax,%ax
    19ba:	66 90                	xchg   %ax,%ax
    19bc:	66 90                	xchg   %ax,%ax
    19be:	66 90                	xchg   %ax,%ax

000019c0 <printint.constprop.1>:
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
}

static void
printint(int fd, int xx, int base, int sgn)
    19c0:	55                   	push   %ebp
    19c1:	89 e5                	mov    %esp,%ebp
    19c3:	57                   	push   %edi
    19c4:	56                   	push   %esi
    19c5:	53                   	push   %ebx
    19c6:	89 d6                	mov    %edx,%esi
    19c8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    19cb:	85 c0                	test   %eax,%eax
    19cd:	79 71                	jns    1a40 <printint.constprop.1+0x80>
    19cf:	83 e1 01             	and    $0x1,%ecx
    19d2:	74 6c                	je     1a40 <printint.constprop.1+0x80>
    neg = 1;
    x = -xx;
    19d4:	f7 d8                	neg    %eax
    neg = 1;
    19d6:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    19dd:	31 c9                	xor    %ecx,%ecx
    19df:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    19e2:	eb 06                	jmp    19ea <printint.constprop.1+0x2a>
    19e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    19e8:	89 f9                	mov    %edi,%ecx
    19ea:	31 d2                	xor    %edx,%edx
    19ec:	8d 79 01             	lea    0x1(%ecx),%edi
    19ef:	f7 f6                	div    %esi
    19f1:	0f b6 92 c0 23 00 00 	movzbl 0x23c0(%edx),%edx
  }while((x /= base) != 0);
    19f8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    19fa:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    19fd:	75 e9                	jne    19e8 <printint.constprop.1+0x28>
  if(neg)
    19ff:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1a02:	85 c0                	test   %eax,%eax
    1a04:	74 08                	je     1a0e <printint.constprop.1+0x4e>
    buf[i++] = '-';
    1a06:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    1a0b:	8d 79 02             	lea    0x2(%ecx),%edi
    1a0e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    1a12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1a18:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    1a1b:	83 ec 04             	sub    $0x4,%esp
    1a1e:	83 ee 01             	sub    $0x1,%esi
    1a21:	6a 01                	push   $0x1
    1a23:	53                   	push   %ebx
    1a24:	6a 01                	push   $0x1
    1a26:	88 45 d7             	mov    %al,-0x29(%ebp)
    1a29:	e8 fc fe ff ff       	call   192a <write>

  while(--i >= 0)
    1a2e:	83 c4 10             	add    $0x10,%esp
    1a31:	39 de                	cmp    %ebx,%esi
    1a33:	75 e3                	jne    1a18 <printint.constprop.1+0x58>
    putc(fd, buf[i]);
}
    1a35:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a38:	5b                   	pop    %ebx
    1a39:	5e                   	pop    %esi
    1a3a:	5f                   	pop    %edi
    1a3b:	5d                   	pop    %ebp
    1a3c:	c3                   	ret    
    1a3d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
    1a40:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1a47:	eb 94                	jmp    19dd <printint.constprop.1+0x1d>
    1a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001a50 <vprintf.constprop.0>:
static void vprintf(int fd, const char *fmt, va_list ap)
    1a50:	55                   	push   %ebp
    1a51:	89 e5                	mov    %esp,%ebp
    1a53:	57                   	push   %edi
    1a54:	56                   	push   %esi
    1a55:	53                   	push   %ebx
    1a56:	89 d6                	mov    %edx,%esi
    1a58:	83 ec 2c             	sub    $0x2c,%esp
{
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1a5b:	0f b6 10             	movzbl (%eax),%edx
    1a5e:	84 d2                	test   %dl,%dl
    1a60:	0f 84 cd 00 00 00    	je     1b33 <vprintf.constprop.0+0xe3>
    1a66:	8d 58 01             	lea    0x1(%eax),%ebx
  state = 0;
    1a69:	31 ff                	xor    %edi,%edi
    1a6b:	eb 31                	jmp    1a9e <vprintf.constprop.0+0x4e>
    1a6d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1a70:	83 f8 25             	cmp    $0x25,%eax
    1a73:	0f 84 c7 00 00 00    	je     1b40 <vprintf.constprop.0+0xf0>
  write(fd, &c, 1);
    1a79:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1a7c:	83 ec 04             	sub    $0x4,%esp
    1a7f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
    1a82:	6a 01                	push   $0x1
    1a84:	50                   	push   %eax
    1a85:	6a 01                	push   $0x1
    1a87:	e8 9e fe ff ff       	call   192a <write>
    1a8c:	83 c4 10             	add    $0x10,%esp
    1a8f:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
    1a92:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1a96:	84 d2                	test   %dl,%dl
    1a98:	0f 84 95 00 00 00    	je     1b33 <vprintf.constprop.0+0xe3>
    if(state == 0){
    1a9e:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    1aa0:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    1aa3:	74 cb                	je     1a70 <vprintf.constprop.0+0x20>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1aa5:	83 ff 25             	cmp    $0x25,%edi
    1aa8:	75 e5                	jne    1a8f <vprintf.constprop.0+0x3f>
      if(c == 'd'){
    1aaa:	83 f8 64             	cmp    $0x64,%eax
        printint(fd, va_arg(ap, int), 10, 1);
    1aad:	8d 7e 04             	lea    0x4(%esi),%edi
    1ab0:	b9 01 00 00 00       	mov    $0x1,%ecx
      if(c == 'd'){
    1ab5:	0f 84 9a 00 00 00    	je     1b55 <vprintf.constprop.0+0x105>
      } else if(c == 'l') {
    1abb:	83 f8 6c             	cmp    $0x6c,%eax
    1abe:	0f 84 8c 00 00 00    	je     1b50 <vprintf.constprop.0+0x100>
        printint(fd, va_arg(ap, uint), 10, 0);
      } else if(c == 'x') {
    1ac4:	83 f8 78             	cmp    $0x78,%eax
    1ac7:	0f 84 a3 00 00 00    	je     1b70 <vprintf.constprop.0+0x120>
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    1acd:	83 f8 70             	cmp    $0x70,%eax
    1ad0:	0f 84 ca 00 00 00    	je     1ba0 <vprintf.constprop.0+0x150>
        printptr(fd, va_arg(ap, uint));
      } else if(c == 's'){
    1ad6:	83 f8 73             	cmp    $0x73,%eax
    1ad9:	0f 84 39 01 00 00    	je     1c18 <vprintf.constprop.0+0x1c8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1adf:	83 f8 63             	cmp    $0x63,%eax
    1ae2:	0f 84 68 01 00 00    	je     1c50 <vprintf.constprop.0+0x200>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    1ae8:	83 f8 25             	cmp    $0x25,%eax
    1aeb:	0f 84 9f 00 00 00    	je     1b90 <vprintf.constprop.0+0x140>
  write(fd, &c, 1);
    1af1:	8d 45 df             	lea    -0x21(%ebp),%eax
    1af4:	83 ec 04             	sub    $0x4,%esp
    1af7:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    1afa:	6a 01                	push   $0x1
    1afc:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
    1b00:	50                   	push   %eax
    1b01:	6a 01                	push   $0x1
    1b03:	e8 22 fe ff ff       	call   192a <write>
    1b08:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1b0c:	83 c4 0c             	add    $0xc,%esp
    1b0f:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1b12:	6a 01                	push   $0x1
    1b14:	88 55 e0             	mov    %dl,-0x20(%ebp)
    1b17:	50                   	push   %eax
    1b18:	6a 01                	push   $0x1
    1b1a:	83 c3 01             	add    $0x1,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1b1d:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    1b1f:	e8 06 fe ff ff       	call   192a <write>
  for(i = 0; fmt[i]; i++){
    1b24:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
  write(fd, &c, 1);
    1b28:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1b2b:	84 d2                	test   %dl,%dl
    1b2d:	0f 85 6b ff ff ff    	jne    1a9e <vprintf.constprop.0+0x4e>
    }
  }
}
    1b33:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b36:	5b                   	pop    %ebx
    1b37:	5e                   	pop    %esi
    1b38:	5f                   	pop    %edi
    1b39:	5d                   	pop    %ebp
    1b3a:	c3                   	ret    
    1b3b:	90                   	nop
    1b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        state = '%';
    1b40:	bf 25 00 00 00       	mov    $0x25,%edi
    1b45:	e9 45 ff ff ff       	jmp    1a8f <vprintf.constprop.0+0x3f>
    1b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, uint), 10, 0);
    1b50:	8d 7e 04             	lea    0x4(%esi),%edi
    1b53:	31 c9                	xor    %ecx,%ecx
    1b55:	8b 06                	mov    (%esi),%eax
    1b57:	ba 0a 00 00 00       	mov    $0xa,%edx
    1b5c:	89 fe                	mov    %edi,%esi
      state = 0;
    1b5e:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, uint), 10, 0);
    1b60:	e8 5b fe ff ff       	call   19c0 <printint.constprop.1>
    1b65:	e9 25 ff ff ff       	jmp    1a8f <vprintf.constprop.0+0x3f>
    1b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, int), 16, 0);
    1b70:	8b 06                	mov    (%esi),%eax
    1b72:	8d 7e 04             	lea    0x4(%esi),%edi
    1b75:	31 c9                	xor    %ecx,%ecx
    1b77:	ba 10 00 00 00       	mov    $0x10,%edx
    1b7c:	89 fe                	mov    %edi,%esi
      state = 0;
    1b7e:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, int), 16, 0);
    1b80:	e8 3b fe ff ff       	call   19c0 <printint.constprop.1>
    1b85:	e9 05 ff ff ff       	jmp    1a8f <vprintf.constprop.0+0x3f>
    1b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1b90:	83 ec 04             	sub    $0x4,%esp
    1b93:	88 55 e1             	mov    %dl,-0x1f(%ebp)
    1b96:	8d 45 e1             	lea    -0x1f(%ebp),%eax
    1b99:	6a 01                	push   $0x1
    1b9b:	e9 77 ff ff ff       	jmp    1b17 <vprintf.constprop.0+0xc7>
        printptr(fd, va_arg(ap, uint));
    1ba0:	8d 46 04             	lea    0x4(%esi),%eax
  write(fd, &c, 1);
    1ba3:	83 ec 04             	sub    $0x4,%esp
        printptr(fd, va_arg(ap, uint));
    1ba6:	8b 3e                	mov    (%esi),%edi
  write(fd, &c, 1);
    1ba8:	6a 01                	push   $0x1
    1baa:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
    1bae:	be 08 00 00 00       	mov    $0x8,%esi
        printptr(fd, va_arg(ap, uint));
    1bb3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
    1bb6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1bb9:	50                   	push   %eax
    1bba:	6a 01                	push   $0x1
    1bbc:	e8 69 fd ff ff       	call   192a <write>
    1bc1:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1bc4:	83 c4 0c             	add    $0xc,%esp
    1bc7:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
    1bcb:	6a 01                	push   $0x1
    1bcd:	50                   	push   %eax
    1bce:	6a 01                	push   $0x1
    1bd0:	e8 55 fd ff ff       	call   192a <write>
    1bd5:	83 c4 10             	add    $0x10,%esp
    1bd8:	90                   	nop
    1bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1be0:	89 f8                	mov    %edi,%eax
  write(fd, &c, 1);
    1be2:	83 ec 04             	sub    $0x4,%esp
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1be5:	c1 e7 04             	shl    $0x4,%edi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1be8:	c1 e8 1c             	shr    $0x1c,%eax
  write(fd, &c, 1);
    1beb:	6a 01                	push   $0x1
    1bed:	0f b6 80 c0 23 00 00 	movzbl 0x23c0(%eax),%eax
    1bf4:	88 45 e5             	mov    %al,-0x1b(%ebp)
    1bf7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1bfa:	50                   	push   %eax
    1bfb:	6a 01                	push   $0x1
    1bfd:	e8 28 fd ff ff       	call   192a <write>
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1c02:	83 c4 10             	add    $0x10,%esp
    1c05:	83 ee 01             	sub    $0x1,%esi
    1c08:	75 d6                	jne    1be0 <vprintf.constprop.0+0x190>
        s = va_arg(ap, char*);
    1c0a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
    1c0d:	31 ff                	xor    %edi,%edi
    1c0f:	e9 7b fe ff ff       	jmp    1a8f <vprintf.constprop.0+0x3f>
    1c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = va_arg(ap, char*);
    1c18:	8b 3e                	mov    (%esi),%edi
    1c1a:	8d 46 04             	lea    0x4(%esi),%eax
    1c1d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    1c20:	85 ff                	test   %edi,%edi
    1c22:	74 50                	je     1c74 <vprintf.constprop.0+0x224>
        while(*s != 0){
    1c24:	0f b6 07             	movzbl (%edi),%eax
    1c27:	84 c0                	test   %al,%al
    1c29:	74 df                	je     1c0a <vprintf.constprop.0+0x1ba>
    1c2b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
    1c2e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
    1c30:	83 ec 04             	sub    $0x4,%esp
          s++;
    1c33:	83 c7 01             	add    $0x1,%edi
    1c36:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1c39:	6a 01                	push   $0x1
    1c3b:	56                   	push   %esi
    1c3c:	6a 01                	push   $0x1
    1c3e:	e8 e7 fc ff ff       	call   192a <write>
        while(*s != 0){
    1c43:	0f b6 07             	movzbl (%edi),%eax
    1c46:	83 c4 10             	add    $0x10,%esp
    1c49:	84 c0                	test   %al,%al
    1c4b:	75 e3                	jne    1c30 <vprintf.constprop.0+0x1e0>
    1c4d:	eb bb                	jmp    1c0a <vprintf.constprop.0+0x1ba>
    1c4f:	90                   	nop
        putc(fd, va_arg(ap, uint));
    1c50:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
    1c52:	83 ec 04             	sub    $0x4,%esp
        putc(fd, va_arg(ap, uint));
    1c55:	8d 7e 04             	lea    0x4(%esi),%edi
  write(fd, &c, 1);
    1c58:	6a 01                	push   $0x1
        putc(fd, va_arg(ap, uint));
    1c5a:	89 fe                	mov    %edi,%esi
      state = 0;
    1c5c:	31 ff                	xor    %edi,%edi
        putc(fd, va_arg(ap, uint));
    1c5e:	88 45 e2             	mov    %al,-0x1e(%ebp)
  write(fd, &c, 1);
    1c61:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1c64:	50                   	push   %eax
    1c65:	6a 01                	push   $0x1
    1c67:	e8 be fc ff ff       	call   192a <write>
    1c6c:	83 c4 10             	add    $0x10,%esp
    1c6f:	e9 1b fe ff ff       	jmp    1a8f <vprintf.constprop.0+0x3f>
          s = "(null)";
    1c74:	bf b9 23 00 00       	mov    $0x23b9,%edi
        while(*s != 0){
    1c79:	b8 28 00 00 00       	mov    $0x28,%eax
    1c7e:	eb ab                	jmp    1c2b <vprintf.constprop.0+0x1db>

00001c80 <fprintf>:
// Print to the given fd. Only understands %d,%x, %p, %s, %c.
void
fprintf(int fd, const char *fmt, ...)
{
    1c80:	55                   	push   %ebp
    1c81:	89 e5                	mov    %esp,%ebp
    1c83:	83 ec 08             	sub    $0x8,%esp
 va_list ap;
 va_start(ap, fmt); 
 vprintf(1,fmt,ap);
    1c86:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c89:	8d 55 10             	lea    0x10(%ebp),%edx
    1c8c:	e8 bf fd ff ff       	call   1a50 <vprintf.constprop.0>
}
    1c91:	c9                   	leave  
    1c92:	c3                   	ret    
    1c93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001ca0 <printf>:
void
printf(const char *fmt, ...)
{
    1ca0:	55                   	push   %ebp
    1ca1:	89 e5                	mov    %esp,%ebp
    1ca3:	83 ec 08             	sub    $0x8,%esp
  va_list ap;
  va_start(ap, fmt); 
  vprintf(1,fmt,ap);
    1ca6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca9:	8d 55 0c             	lea    0xc(%ebp),%edx
    1cac:	e8 9f fd ff ff       	call   1a50 <vprintf.constprop.0>
}
    1cb1:	c9                   	leave  
    1cb2:	c3                   	ret    
    1cb3:	66 90                	xchg   %ax,%ax
    1cb5:	66 90                	xchg   %ax,%ax
    1cb7:	66 90                	xchg   %ax,%ax
    1cb9:	66 90                	xchg   %ax,%ax
    1cbb:	66 90                	xchg   %ax,%ax
    1cbd:	66 90                	xchg   %ax,%ax
    1cbf:	90                   	nop

00001cc0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1cc0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1cc1:	a1 40 2e 00 00       	mov    0x2e40,%eax
{
    1cc6:	89 e5                	mov    %esp,%ebp
    1cc8:	57                   	push   %edi
    1cc9:	56                   	push   %esi
    1cca:	53                   	push   %ebx
    1ccb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    1cce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1cd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1cd8:	39 c8                	cmp    %ecx,%eax
    1cda:	8b 10                	mov    (%eax),%edx
    1cdc:	73 32                	jae    1d10 <free+0x50>
    1cde:	39 d1                	cmp    %edx,%ecx
    1ce0:	72 04                	jb     1ce6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1ce2:	39 d0                	cmp    %edx,%eax
    1ce4:	72 32                	jb     1d18 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1ce6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1ce9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1cec:	39 fa                	cmp    %edi,%edx
    1cee:	74 30                	je     1d20 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1cf0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1cf3:	8b 50 04             	mov    0x4(%eax),%edx
    1cf6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1cf9:	39 f1                	cmp    %esi,%ecx
    1cfb:	74 3a                	je     1d37 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1cfd:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1cff:	a3 40 2e 00 00       	mov    %eax,0x2e40
}
    1d04:	5b                   	pop    %ebx
    1d05:	5e                   	pop    %esi
    1d06:	5f                   	pop    %edi
    1d07:	5d                   	pop    %ebp
    1d08:	c3                   	ret    
    1d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1d10:	39 d0                	cmp    %edx,%eax
    1d12:	72 04                	jb     1d18 <free+0x58>
    1d14:	39 d1                	cmp    %edx,%ecx
    1d16:	72 ce                	jb     1ce6 <free+0x26>
{
    1d18:	89 d0                	mov    %edx,%eax
    1d1a:	eb bc                	jmp    1cd8 <free+0x18>
    1d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1d20:	03 72 04             	add    0x4(%edx),%esi
    1d23:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1d26:	8b 10                	mov    (%eax),%edx
    1d28:	8b 12                	mov    (%edx),%edx
    1d2a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1d2d:	8b 50 04             	mov    0x4(%eax),%edx
    1d30:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1d33:	39 f1                	cmp    %esi,%ecx
    1d35:	75 c6                	jne    1cfd <free+0x3d>
    p->s.size += bp->s.size;
    1d37:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    1d3a:	a3 40 2e 00 00       	mov    %eax,0x2e40
    p->s.size += bp->s.size;
    1d3f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1d42:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1d45:	89 10                	mov    %edx,(%eax)
}
    1d47:	5b                   	pop    %ebx
    1d48:	5e                   	pop    %esi
    1d49:	5f                   	pop    %edi
    1d4a:	5d                   	pop    %ebp
    1d4b:	c3                   	ret    
    1d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001d50 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1d50:	55                   	push   %ebp
    1d51:	89 e5                	mov    %esp,%ebp
    1d53:	57                   	push   %edi
    1d54:	56                   	push   %esi
    1d55:	53                   	push   %ebx
    1d56:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1d59:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    1d5c:	8b 15 40 2e 00 00    	mov    0x2e40,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1d62:	8d 78 07             	lea    0x7(%eax),%edi
    1d65:	c1 ef 03             	shr    $0x3,%edi
    1d68:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    1d6b:	85 d2                	test   %edx,%edx
    1d6d:	0f 84 9d 00 00 00    	je     1e10 <malloc+0xc0>
    1d73:	8b 02                	mov    (%edx),%eax
    1d75:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1d78:	39 cf                	cmp    %ecx,%edi
    1d7a:	76 6c                	jbe    1de8 <malloc+0x98>
    1d7c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1d82:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1d87:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1d8a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1d91:	eb 0e                	jmp    1da1 <malloc+0x51>
    1d93:	90                   	nop
    1d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1d98:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1d9a:	8b 48 04             	mov    0x4(%eax),%ecx
    1d9d:	39 f9                	cmp    %edi,%ecx
    1d9f:	73 47                	jae    1de8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1da1:	39 05 40 2e 00 00    	cmp    %eax,0x2e40
    1da7:	89 c2                	mov    %eax,%edx
    1da9:	75 ed                	jne    1d98 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    1dab:	83 ec 0c             	sub    $0xc,%esp
    1dae:	56                   	push   %esi
    1daf:	e8 de fb ff ff       	call   1992 <sbrk>
  if(p == (char*)-1)
    1db4:	83 c4 10             	add    $0x10,%esp
    1db7:	83 f8 ff             	cmp    $0xffffffff,%eax
    1dba:	74 1c                	je     1dd8 <malloc+0x88>
  hp->s.size = nu;
    1dbc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1dbf:	83 ec 0c             	sub    $0xc,%esp
    1dc2:	83 c0 08             	add    $0x8,%eax
    1dc5:	50                   	push   %eax
    1dc6:	e8 f5 fe ff ff       	call   1cc0 <free>
  return freep;
    1dcb:	8b 15 40 2e 00 00    	mov    0x2e40,%edx
      if((p = morecore(nunits)) == 0)
    1dd1:	83 c4 10             	add    $0x10,%esp
    1dd4:	85 d2                	test   %edx,%edx
    1dd6:	75 c0                	jne    1d98 <malloc+0x48>
        return 0;
  }
}
    1dd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1ddb:	31 c0                	xor    %eax,%eax
}
    1ddd:	5b                   	pop    %ebx
    1dde:	5e                   	pop    %esi
    1ddf:	5f                   	pop    %edi
    1de0:	5d                   	pop    %ebp
    1de1:	c3                   	ret    
    1de2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1de8:	39 cf                	cmp    %ecx,%edi
    1dea:	74 54                	je     1e40 <malloc+0xf0>
        p->s.size -= nunits;
    1dec:	29 f9                	sub    %edi,%ecx
    1dee:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1df1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1df4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1df7:	89 15 40 2e 00 00    	mov    %edx,0x2e40
}
    1dfd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1e00:	83 c0 08             	add    $0x8,%eax
}
    1e03:	5b                   	pop    %ebx
    1e04:	5e                   	pop    %esi
    1e05:	5f                   	pop    %edi
    1e06:	5d                   	pop    %ebp
    1e07:	c3                   	ret    
    1e08:	90                   	nop
    1e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1e10:	c7 05 40 2e 00 00 44 	movl   $0x2e44,0x2e40
    1e17:	2e 00 00 
    1e1a:	c7 05 44 2e 00 00 44 	movl   $0x2e44,0x2e44
    1e21:	2e 00 00 
    base.s.size = 0;
    1e24:	b8 44 2e 00 00       	mov    $0x2e44,%eax
    1e29:	c7 05 48 2e 00 00 00 	movl   $0x0,0x2e48
    1e30:	00 00 00 
    1e33:	e9 44 ff ff ff       	jmp    1d7c <malloc+0x2c>
    1e38:	90                   	nop
    1e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1e40:	8b 08                	mov    (%eax),%ecx
    1e42:	89 0a                	mov    %ecx,(%edx)
    1e44:	eb b1                	jmp    1df7 <malloc+0xa7>
