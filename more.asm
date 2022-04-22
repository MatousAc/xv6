
user/_more:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
void line(File file, Terminal terminal);
void help(Terminal terminal);
static int collectNum(char c, int* numCollector);
static char getCmd();

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
      11:	83 ec 48             	sub    $0x48,%esp
      14:	8b 01                	mov    (%ecx),%eax
      16:	8b 51 04             	mov    0x4(%ecx),%edx
  // arg czeching
  if (argc < 2) {
      19:	83 f8 01             	cmp    $0x1,%eax
      1c:	0f 8e aa 02 00 00    	jle    2cc <main+0x2cc>
    fprintf(2, "more: bad usage\nTry 'more --help' for more information.\n");
    exit();
  } else if (argc > 2) {
      22:	83 f8 02             	cmp    $0x2,%eax
      25:	0f 85 e3 00 00 00    	jne    10e <main+0x10e>
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
      46:	e8 c5 06 00 00       	call   710 <MakeLinkedList>
      4b:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // opening file
  file.fd = open(file.filename, O_RDONLY);
      4e:	50                   	push   %eax
      4f:	50                   	push   %eax
      50:	6a 00                	push   $0x0
      52:	ff 75 d0             	pushl  -0x30(%ebp)
      55:	e8 30 15 00 00       	call   158a <open>
  if (file.fd == -1) {
      5a:	83 c4 10             	add    $0x10,%esp
  file.fd = open(file.filename, O_RDONLY);
      5d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  if (file.fd == -1) {
      60:	83 c0 01             	add    $0x1,%eax
      63:	0f 84 76 02 00 00    	je     2df <main+0x2df>
    fprintf(2, "file could not be opened\n",  file.filename);
  } else {
    // populate Linked List
    gatherLinesSized(&file, terminal);
      69:	b8 37 00 00 00       	mov    $0x37,%eax
      6e:	ba 19 00 00 00       	mov    $0x19,%edx
      73:	57                   	push   %edi
      74:	52                   	push   %edx
      75:	50                   	push   %eax
      76:	8d 45 d0             	lea    -0x30(%ebp),%eax
      79:	50                   	push   %eax
      7a:	89 45 b4             	mov    %eax,-0x4c(%ebp)
      7d:	e8 ee 0b 00 00       	call   c70 <gatherLinesSized>
      82:	83 c4 10             	add    $0x10,%esp
  }
  close(file.fd);
      85:	83 ec 0c             	sub    $0xc,%esp
      88:	ff 75 d4             	pushl  -0x2c(%ebp)
      8b:	e8 e2 14 00 00       	call   1572 <close>
  // loop
  char cmd = ' ', previous = ' ';
  // char previous = ' ';
  int numCollector = 0;
  int numArg = 1;
  showPage(file, terminal);
      90:	c7 45 c0 37 00 00 00 	movl   $0x37,-0x40(%ebp)
      97:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
      9e:	b9 06 00 00 00       	mov    $0x6,%ecx
      a3:	ff 75 c4             	pushl  -0x3c(%ebp)
      a6:	ff 75 c0             	pushl  -0x40(%ebp)
      a9:	8b 75 b4             	mov    -0x4c(%ebp),%esi
      ac:	83 ec 18             	sub    $0x18,%esp
      af:	89 e7                	mov    %esp,%edi
      b1:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  char cmd = ' ', previous = ' ';
      b3:	bf 20 00 00 00       	mov    $0x20,%edi
  showPage(file, terminal);
      b8:	e8 63 0f 00 00       	call   1020 <showPage>
      bd:	83 c4 30             	add    $0x30,%esp
  int numCollector = 0;
      c0:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  int numArg = 1;
      c7:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
      ce:	66 90                	xchg   %ax,%ax
  }
  line[i + 1] = '\0';
  return 1;
}

char consGetChar() {return (char) steal(0);}
      d0:	83 ec 0c             	sub    $0xc,%esp
      d3:	6a 00                	push   $0x0
      d5:	e8 88 14 00 00       	call   1562 <steal>
  return *numCollector;
}

static char getCmd() {
  char cmd = consGetChar();
  if (cmd == '\0') exit();
      da:	83 c4 10             	add    $0x10,%esp
      dd:	84 c0                	test   %al,%al
      df:	89 c3                	mov    %eax,%ebx
      e1:	0f 84 a4 00 00 00    	je     18b <main+0x18b>
  printf("\r");
      e7:	83 ec 0c             	sub    $0xc,%esp
      ea:	68 11 1e 00 00       	push   $0x1e11
      ef:	e8 ec 17 00 00       	call   18e0 <printf>
    if (cmd == '.') cmd = previous;
      f4:	83 c4 10             	add    $0x10,%esp
      f7:	80 fb 2e             	cmp    $0x2e,%bl
      fa:	0f 44 df             	cmove  %edi,%ebx
		switch (cmd) {
      fd:	8d 43 e0             	lea    -0x20(%ebx),%eax
     100:	3c 53                	cmp    $0x53,%al
     102:	77 4c                	ja     150 <main+0x150>
     104:	0f b6 c0             	movzbl %al,%eax
     107:	ff 24 85 a0 1c 00 00 	jmp    *0x1ca0(,%eax,4)
    fprintf(2, "this version of more only supports one file at a time.\n");
     10e:	50                   	push   %eax
     10f:	50                   	push   %eax
     110:	68 64 1c 00 00       	push   $0x1c64
     115:	6a 02                	push   $0x2
     117:	e8 a4 17 00 00       	call   18c0 <fprintf>
    exit();
     11c:	e8 21 14 00 00       	call   1542 <exit>
    case 'L': showPage(file, terminal); break;
     121:	c7 45 c0 37 00 00 00 	movl   $0x37,-0x40(%ebp)
     128:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
     12f:	b9 06 00 00 00       	mov    $0x6,%ecx
     134:	ff 75 c4             	pushl  -0x3c(%ebp)
     137:	ff 75 c0             	pushl  -0x40(%ebp)
     13a:	8b 75 b4             	mov    -0x4c(%ebp),%esi
     13d:	83 ec 18             	sub    $0x18,%esp
     140:	89 e7                	mov    %esp,%edi
     142:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
     144:	e8 d7 0e 00 00       	call   1020 <showPage>
     149:	83 c4 20             	add    $0x20,%esp
     14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return os;
}

// standard str helps
int isDigit(char c) {
  if (c >= '0' && c <= '9') return 1;
     150:	8d 43 d0             	lea    -0x30(%ebx),%eax
     153:	3c 09                	cmp    $0x9,%al
     155:	0f 87 65 01 00 00    	ja     2c0 <main+0x2c0>
  *numCollector *= 10;
     15b:	8b 45 bc             	mov    -0x44(%ebp),%eax
     15e:	8d 14 80             	lea    (%eax,%eax,4),%edx
		switch (cmd) {
     161:	0f be c3             	movsbl %bl,%eax
  *numCollector += ctoi(c);
     164:	8d 44 50 d0          	lea    -0x30(%eax,%edx,2),%eax
     168:	89 45 bc             	mov    %eax,-0x44(%ebp)
    numArg = (numCollector > 0) ? numCollector : 1;
     16b:	8b 45 bc             	mov    -0x44(%ebp),%eax
     16e:	ba 01 00 00 00       	mov    $0x1,%edx
     173:	85 c0                	test   %eax,%eax
     175:	0f 4f d0             	cmovg  %eax,%edx
  while (cmd != 'q' && cmd != 'Q') {
     178:	89 d8                	mov    %ebx,%eax
     17a:	83 e0 df             	and    $0xffffffdf,%eax
    numArg = (numCollector > 0) ? numCollector : 1;
     17d:	89 55 b8             	mov    %edx,-0x48(%ebp)
  while (cmd != 'q' && cmd != 'Q') {
     180:	3c 51                	cmp    $0x51,%al
     182:	74 07                	je     18b <main+0x18b>
    numArg = (numCollector > 0) ? numCollector : 1;
     184:	89 df                	mov    %ebx,%edi
     186:	e9 45 ff ff ff       	jmp    d0 <main+0xd0>
  if (cmd == '\0') exit();
     18b:	e8 b2 13 00 00       	call   1542 <exit>
    case 'H': help(terminal); printPrompt(file); break;
     190:	c7 45 c0 37 00 00 00 	movl   $0x37,-0x40(%ebp)
     197:	50                   	push   %eax
     198:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
     19f:	50                   	push   %eax
     1a0:	ff 75 c4             	pushl  -0x3c(%ebp)
     1a3:	ff 75 c0             	pushl  -0x40(%ebp)
     1a6:	e8 95 0d 00 00       	call   f40 <help>
  printf("--MORE--(%d%%)", 100 * file.curLine / file.len);
     1ab:	6b 45 d8 64          	imul   $0x64,-0x28(%ebp),%eax
     1af:	5a                   	pop    %edx
     1b0:	59                   	pop    %ecx
     1b1:	99                   	cltd   
     1b2:	f7 7d e0             	idivl  -0x20(%ebp)
     1b5:	50                   	push   %eax
     1b6:	68 50 1e 00 00       	push   $0x1e50
     1bb:	e8 20 17 00 00       	call   18e0 <printf>
  printf("[Press space to continue, 'q' to quit.]\r");
     1c0:	c7 04 24 fc 1b 00 00 	movl   $0x1bfc,(%esp)
     1c7:	e8 14 17 00 00       	call   18e0 <printf>
     1cc:	83 c4 10             	add    $0x10,%esp
     1cf:	e9 7c ff ff ff       	jmp    150 <main+0x150>
    case 'F': skip(&file, terminal, numArg); break;
     1d4:	ff 75 b8             	pushl  -0x48(%ebp)
     1d7:	c7 45 c0 37 00 00 00 	movl   $0x37,-0x40(%ebp)
     1de:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
     1e5:	ff 75 c4             	pushl  -0x3c(%ebp)
     1e8:	ff 75 c0             	pushl  -0x40(%ebp)
     1eb:	ff 75 b4             	pushl  -0x4c(%ebp)
     1ee:	e8 2d 0f 00 00       	call   1120 <skip>
     1f3:	83 c4 10             	add    $0x10,%esp
     1f6:	e9 55 ff ff ff       	jmp    150 <main+0x150>
		case '=': line(file, terminal); break;
     1fb:	c7 45 c0 37 00 00 00 	movl   $0x37,-0x40(%ebp)
     202:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
     209:	b9 06 00 00 00       	mov    $0x6,%ecx
     20e:	ff 75 c4             	pushl  -0x3c(%ebp)
     211:	ff 75 c0             	pushl  -0x40(%ebp)
     214:	8b 75 b4             	mov    -0x4c(%ebp),%esi
     217:	83 ec 18             	sub    $0x18,%esp
     21a:	89 e7                	mov    %esp,%edi
     21c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
     21e:	e8 cd 0c 00 00       	call   ef0 <line>
     223:	83 c4 20             	add    $0x20,%esp
    return 0; // not a successful addition
     226:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    numArg = (numCollector > 0) ? numCollector : 1;
     22d:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
     234:	89 df                	mov    %ebx,%edi
     236:	e9 95 fe ff ff       	jmp    d0 <main+0xd0>
		case ' ': forward(&file, terminal); break;
     23b:	c7 45 c0 37 00 00 00 	movl   $0x37,-0x40(%ebp)
     242:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
     249:	56                   	push   %esi
     24a:	ff 75 c4             	pushl  -0x3c(%ebp)
     24d:	ff 75 c0             	pushl  -0x40(%ebp)
     250:	ff 75 b4             	pushl  -0x4c(%ebp)
     253:	e8 78 0e 00 00       	call   10d0 <forward>
     258:	83 c4 10             	add    $0x10,%esp
     25b:	eb c9                	jmp    226 <main+0x226>
  showLines(*file, terminal, numLines);
     25d:	83 ec 0c             	sub    $0xc,%esp
     260:	c7 45 a8 37 00 00 00 	movl   $0x37,-0x58(%ebp)
     267:	ff 75 b8             	pushl  -0x48(%ebp)
     26a:	c7 45 ac 19 00 00 00 	movl   $0x19,-0x54(%ebp)
     271:	ff 75 ac             	pushl  -0x54(%ebp)
     274:	b9 06 00 00 00       	mov    $0x6,%ecx
     279:	ff 75 a8             	pushl  -0x58(%ebp)
     27c:	8b 75 b4             	mov    -0x4c(%ebp),%esi
     27f:	83 ec 18             	sub    $0x18,%esp
     282:	89 e7                	mov    %esp,%edi
     284:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
     286:	e8 65 0f 00 00       	call   11f0 <showLines>
  file->curLine += numLines;
     28b:	8b 45 b8             	mov    -0x48(%ebp),%eax
     28e:	83 c4 30             	add    $0x30,%esp
     291:	01 45 d8             	add    %eax,-0x28(%ebp)
     294:	e9 b7 fe ff ff       	jmp    150 <main+0x150>
    case 'B': back(&file, terminal, numArg); break;
     299:	ff 75 b8             	pushl  -0x48(%ebp)
     29c:	c7 45 c0 37 00 00 00 	movl   $0x37,-0x40(%ebp)
     2a3:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
     2aa:	ff 75 c4             	pushl  -0x3c(%ebp)
     2ad:	ff 75 c0             	pushl  -0x40(%ebp)
     2b0:	ff 75 b4             	pushl  -0x4c(%ebp)
     2b3:	e8 d8 0e 00 00       	call   1190 <back>
     2b8:	83 c4 10             	add    $0x10,%esp
     2bb:	e9 90 fe ff ff       	jmp    150 <main+0x150>
    return 0; // not a successful addition
     2c0:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
     2c7:	e9 9f fe ff ff       	jmp    16b <main+0x16b>
    fprintf(2, "more: bad usage\nTry 'more --help' for more information.\n");
     2cc:	50                   	push   %eax
     2cd:	50                   	push   %eax
     2ce:	68 28 1c 00 00       	push   $0x1c28
     2d3:	6a 02                	push   $0x2
     2d5:	e8 e6 15 00 00       	call   18c0 <fprintf>
    exit();
     2da:	e8 63 12 00 00       	call   1542 <exit>
    fprintf(2, "file could not be opened\n",  file.filename);
     2df:	50                   	push   %eax
     2e0:	ff 75 d0             	pushl  -0x30(%ebp)
     2e3:	68 79 1e 00 00       	push   $0x1e79
     2e8:	6a 02                	push   $0x2
     2ea:	e8 d1 15 00 00       	call   18c0 <fprintf>
     2ef:	8d 45 d0             	lea    -0x30(%ebp),%eax
     2f2:	83 c4 10             	add    $0x10,%esp
     2f5:	89 45 b4             	mov    %eax,-0x4c(%ebp)
     2f8:	e9 88 fd ff ff       	jmp    85 <main+0x85>
     2fd:	66 90                	xchg   %ax,%ax
     2ff:	90                   	nop

00000300 <safestrcpy.part.0>:
  while(--n > 0 && (*s++ = *t++) != 0)
     300:	83 e9 01             	sub    $0x1,%ecx
     303:	85 c9                	test   %ecx,%ecx
     305:	7e 29                	jle    330 <safestrcpy.part.0+0x30>
safestrcpy(char *s, const char *t, int n) 
     307:	55                   	push   %ebp
     308:	89 e5                	mov    %esp,%ebp
     30a:	53                   	push   %ebx
     30b:	eb 0a                	jmp    317 <safestrcpy.part.0+0x17>
     30d:	8d 76 00             	lea    0x0(%esi),%esi
  while(--n > 0 && (*s++ = *t++) != 0)
     310:	83 e9 01             	sub    $0x1,%ecx
     313:	85 c9                	test   %ecx,%ecx
     315:	7e 11                	jle    328 <safestrcpy.part.0+0x28>
     317:	83 c2 01             	add    $0x1,%edx
     31a:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
     31e:	83 c0 01             	add    $0x1,%eax
     321:	84 db                	test   %bl,%bl
     323:	88 58 ff             	mov    %bl,-0x1(%eax)
     326:	75 e8                	jne    310 <safestrcpy.part.0+0x10>
}
     328:	5b                   	pop    %ebx
  *s = 0;
     329:	c6 00 00             	movb   $0x0,(%eax)
}
     32c:	5d                   	pop    %ebp
     32d:	c3                   	ret    
     32e:	66 90                	xchg   %ax,%ax
  *s = 0;
     330:	c6 00 00             	movb   $0x0,(%eax)
     333:	c3                   	ret    
     334:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     33a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000340 <itoa.part.1>:
/**
 * C++ version 0.4 char* style "itoa":
 * Written by Lukás Chmela
 * Released under GPLv3.
 */
char* itoa(int value, char* result, int base) {
     340:	55                   	push   %ebp
     341:	89 e5                	mov    %esp,%ebp
     343:	57                   	push   %edi
     344:	56                   	push   %esi
     345:	53                   	push   %ebx
     346:	89 c6                	mov    %eax,%esi
     348:	89 c8                	mov    %ecx,%eax
     34a:	89 c3                	mov    %eax,%ebx
     34c:	89 d1                	mov    %edx,%ecx
     34e:	83 ec 04             	sub    $0x4,%esp
     351:	89 55 f0             	mov    %edx,-0x10(%ebp)
     354:	eb 0e                	jmp    364 <itoa.part.1+0x24>
     356:	8d 76 00             	lea    0x0(%esi),%esi
     359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

    do {
        tmp_value = value;
        value /= base;
        *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" [35 + (tmp_value - value * base)];
    } while ( value );
     360:	89 f9                	mov    %edi,%ecx
     362:	89 c6                	mov    %eax,%esi
     364:	89 f0                	mov    %esi,%eax
        *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" [35 + (tmp_value - value * base)];
     366:	8d 79 01             	lea    0x1(%ecx),%edi
     369:	99                   	cltd   
     36a:	f7 fb                	idiv   %ebx
     36c:	0f b6 92 ab 1a 00 00 	movzbl 0x1aab(%edx),%edx
    } while ( value );
     373:	85 c0                	test   %eax,%eax
        *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" [35 + (tmp_value - value * base)];
     375:	88 57 ff             	mov    %dl,-0x1(%edi)
    } while ( value );
     378:	75 e6                	jne    360 <itoa.part.1+0x20>

    // Apply negative sign
    if (tmp_value < 0) *ptr++ = '-';
     37a:	85 f6                	test   %esi,%esi
     37c:	8b 5d f0             	mov    -0x10(%ebp),%ebx
     37f:	79 07                	jns    388 <itoa.part.1+0x48>
     381:	8d 79 02             	lea    0x2(%ecx),%edi
     384:	c6 41 01 2d          	movb   $0x2d,0x1(%ecx)
    *ptr-- = '\0';
     388:	8d 47 ff             	lea    -0x1(%edi),%eax
     38b:	c6 07 00             	movb   $0x0,(%edi)
    while(ptr1 < ptr) {
     38e:	39 d8                	cmp    %ebx,%eax
     390:	76 1c                	jbe    3ae <itoa.part.1+0x6e>
     392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tmp_char = *ptr;
     398:	0f b6 10             	movzbl (%eax),%edx
        *ptr--= *ptr1;
     39b:	0f b6 0b             	movzbl (%ebx),%ecx
     39e:	83 e8 01             	sub    $0x1,%eax
        *ptr1++ = tmp_char;
     3a1:	83 c3 01             	add    $0x1,%ebx
    while(ptr1 < ptr) {
     3a4:	39 d8                	cmp    %ebx,%eax
        *ptr--= *ptr1;
     3a6:	88 48 01             	mov    %cl,0x1(%eax)
        *ptr1++ = tmp_char;
     3a9:	88 53 ff             	mov    %dl,-0x1(%ebx)
    while(ptr1 < ptr) {
     3ac:	77 ea                	ja     398 <itoa.part.1+0x58>
    }
    return result;
}
     3ae:	83 c4 04             	add    $0x4,%esp
     3b1:	5b                   	pop    %ebx
     3b2:	5e                   	pop    %esi
     3b3:	5f                   	pop    %edi
     3b4:	5d                   	pop    %ebp
     3b5:	c3                   	ret    
     3b6:	8d 76 00             	lea    0x0(%esi),%esi
     3b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003c0 <getLine>:
int getLine(int fileptr, char line[]) {
     3c0:	55                   	push   %ebp
     3c1:	89 e5                	mov    %esp,%ebp
     3c3:	57                   	push   %edi
     3c4:	56                   	push   %esi
     3c5:	53                   	push   %ebx
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     3c6:	31 ff                	xor    %edi,%edi
     3c8:	8d 75 e7             	lea    -0x19(%ebp),%esi
int getLine(int fileptr, char line[]) {
     3cb:	83 ec 28             	sub    $0x28,%esp
     3ce:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int len = strlen(line);
     3d1:	53                   	push   %ebx
     3d2:	e8 99 0f 00 00       	call   1370 <strlen>
  memset(line, 0, len);
     3d7:	83 c4 0c             	add    $0xc,%esp
     3da:	50                   	push   %eax
     3db:	6a 00                	push   $0x0
     3dd:	53                   	push   %ebx
     3de:	e8 bd 0f 00 00       	call   13a0 <memset>
     3e3:	83 c4 10             	add    $0x10,%esp
     3e6:	eb 1e                	jmp    406 <getLine+0x46>
     3e8:	90                   	nop
     3e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (*c == '\n') break;
     3f0:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     3f4:	3c 0a                	cmp    $0xa,%al
     3f6:	74 38                	je     430 <getLine+0x70>
    line[i] = *c;
     3f8:	88 04 3b             	mov    %al,(%ebx,%edi,1)
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     3fb:	83 c7 01             	add    $0x1,%edi
     3fe:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
     404:	74 42                	je     448 <getLine+0x88>
    if (read(fileptr, c, 1) == 0) return strlen(line);
     406:	83 ec 04             	sub    $0x4,%esp
     409:	6a 01                	push   $0x1
     40b:	56                   	push   %esi
     40c:	ff 75 08             	pushl  0x8(%ebp)
     40f:	e8 46 11 00 00       	call   155a <read>
     414:	83 c4 10             	add    $0x10,%esp
     417:	85 c0                	test   %eax,%eax
     419:	75 d5                	jne    3f0 <getLine+0x30>
     41b:	83 ec 0c             	sub    $0xc,%esp
     41e:	53                   	push   %ebx
     41f:	e8 4c 0f 00 00       	call   1370 <strlen>
     424:	83 c4 10             	add    $0x10,%esp
}
     427:	8d 65 f4             	lea    -0xc(%ebp),%esp
     42a:	5b                   	pop    %ebx
     42b:	5e                   	pop    %esi
     42c:	5f                   	pop    %edi
     42d:	5d                   	pop    %ebp
     42e:	c3                   	ret    
     42f:	90                   	nop
     430:	8d 57 01             	lea    0x1(%edi),%edx
  line[i + 1] = '\0';
     433:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
     437:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
     43a:	b8 01 00 00 00       	mov    $0x1,%eax
}
     43f:	5b                   	pop    %ebx
     440:	5e                   	pop    %esi
     441:	5f                   	pop    %edi
     442:	5d                   	pop    %ebp
     443:	c3                   	ret    
     444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     448:	ba e8 03 00 00       	mov    $0x3e8,%edx
     44d:	eb e4                	jmp    433 <getLine+0x73>
     44f:	90                   	nop

00000450 <consGetChar>:
char consGetChar() {return (char) steal(0);}
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	83 ec 14             	sub    $0x14,%esp
     456:	6a 00                	push   $0x0
     458:	e8 05 11 00 00       	call   1562 <steal>
     45d:	c9                   	leave  
     45e:	c3                   	ret    
     45f:	90                   	nop

00000460 <find>:
int find(char* str, char c) {
     460:	55                   	push   %ebp
     461:	89 e5                	mov    %esp,%ebp
     463:	57                   	push   %edi
     464:	56                   	push   %esi
     465:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     466:	31 db                	xor    %ebx,%ebx
int find(char* str, char c) {
     468:	83 ec 0c             	sub    $0xc,%esp
     46b:	8b 75 08             	mov    0x8(%ebp),%esi
     46e:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
  for (int i = 0; i < strlen(str); i++)
     472:	eb 0e                	jmp    482 <find+0x22>
     474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     478:	89 f8                	mov    %edi,%eax
     47a:	38 04 1e             	cmp    %al,(%esi,%ebx,1)
     47d:	74 18                	je     497 <find+0x37>
  for (int i = 0; i < strlen(str); i++)
     47f:	83 c3 01             	add    $0x1,%ebx
     482:	83 ec 0c             	sub    $0xc,%esp
     485:	56                   	push   %esi
     486:	e8 e5 0e 00 00       	call   1370 <strlen>
     48b:	83 c4 10             	add    $0x10,%esp
     48e:	39 d8                	cmp    %ebx,%eax
     490:	77 e6                	ja     478 <find+0x18>
  return -1;
     492:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
     497:	8d 65 f4             	lea    -0xc(%ebp),%esp
     49a:	89 d8                	mov    %ebx,%eax
     49c:	5b                   	pop    %ebx
     49d:	5e                   	pop    %esi
     49e:	5f                   	pop    %edi
     49f:	5d                   	pop    %ebp
     4a0:	c3                   	ret    
     4a1:	eb 0d                	jmp    4b0 <substr>
     4a3:	90                   	nop
     4a4:	90                   	nop
     4a5:	90                   	nop
     4a6:	90                   	nop
     4a7:	90                   	nop
     4a8:	90                   	nop
     4a9:	90                   	nop
     4aa:	90                   	nop
     4ab:	90                   	nop
     4ac:	90                   	nop
     4ad:	90                   	nop
     4ae:	90                   	nop
     4af:	90                   	nop

000004b0 <substr>:
void substr(char* dest, char* str, int start, int end) {
     4b0:	55                   	push   %ebp
     4b1:	89 e5                	mov    %esp,%ebp
     4b3:	57                   	push   %edi
     4b4:	56                   	push   %esi
     4b5:	53                   	push   %ebx
     4b6:	83 ec 18             	sub    $0x18,%esp
     4b9:	8b 7d 14             	mov    0x14(%ebp),%edi
  int len = strlen(str);
     4bc:	ff 75 0c             	pushl  0xc(%ebp)
void substr(char* dest, char* str, int start, int end) {
     4bf:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4c2:	8b 75 08             	mov    0x8(%ebp),%esi
  int len = strlen(str);
     4c5:	e8 a6 0e 00 00       	call   1370 <strlen>
     4ca:	83 c4 10             	add    $0x10,%esp
     4cd:	39 f8                	cmp    %edi,%eax
     4cf:	0f 4e f8             	cmovle %eax,%edi
  while (i < end)
     4d2:	39 df                	cmp    %ebx,%edi
     4d4:	7e 1c                	jle    4f2 <substr+0x42>
     4d6:	8b 45 0c             	mov    0xc(%ebp),%eax
     4d9:	29 df                	sub    %ebx,%edi
  int s = 0, i = start;
     4db:	31 d2                	xor    %edx,%edx
     4dd:	01 c3                	add    %eax,%ebx
     4df:	90                   	nop
    dest[s++] = str[i++];
     4e0:	83 c2 01             	add    $0x1,%edx
     4e3:	0f b6 44 13 ff       	movzbl -0x1(%ebx,%edx,1),%eax
  while (i < end)
     4e8:	39 fa                	cmp    %edi,%edx
    dest[s++] = str[i++];
     4ea:	88 44 16 ff          	mov    %al,-0x1(%esi,%edx,1)
  while (i < end)
     4ee:	75 f0                	jne    4e0 <substr+0x30>
     4f0:	01 d6                	add    %edx,%esi
  dest[s] = '\0';
     4f2:	c6 06 00             	movb   $0x0,(%esi)
}
     4f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
     4f8:	5b                   	pop    %ebx
     4f9:	5e                   	pop    %esi
     4fa:	5f                   	pop    %edi
     4fb:	5d                   	pop    %ebp
     4fc:	c3                   	ret    
     4fd:	8d 76 00             	lea    0x0(%esi),%esi

00000500 <safestrcpy>:
{
     500:	55                   	push   %ebp
     501:	89 e5                	mov    %esp,%ebp
     503:	53                   	push   %ebx
     504:	8b 4d 10             	mov    0x10(%ebp),%ecx
     507:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(n <= 0)
     50a:	85 c9                	test   %ecx,%ecx
     50c:	7e 0a                	jle    518 <safestrcpy+0x18>
     50e:	8b 55 0c             	mov    0xc(%ebp),%edx
     511:	89 d8                	mov    %ebx,%eax
     513:	e8 e8 fd ff ff       	call   300 <safestrcpy.part.0>
}
     518:	89 d8                	mov    %ebx,%eax
     51a:	5b                   	pop    %ebx
     51b:	5d                   	pop    %ebp
     51c:	c3                   	ret    
     51d:	8d 76 00             	lea    0x0(%esi),%esi

00000520 <isDigit>:
int isDigit(char c) {
     520:	55                   	push   %ebp
     521:	89 e5                	mov    %esp,%ebp
  if (c >= '0' && c <= '9') return 1;
     523:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
}
     527:	5d                   	pop    %ebp
  if (c >= '0' && c <= '9') return 1;
     528:	83 e8 30             	sub    $0x30,%eax
     52b:	3c 09                	cmp    $0x9,%al
     52d:	0f 96 c0             	setbe  %al
     530:	0f b6 c0             	movzbl %al,%eax
}
     533:	c3                   	ret    
     534:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     53a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000540 <ctoi>:
int ctoi(char c) {
     540:	55                   	push   %ebp
     541:	89 e5                	mov    %esp,%ebp
  return ((int) c) - 48;
     543:	0f be 45 08          	movsbl 0x8(%ebp),%eax
}
     547:	5d                   	pop    %ebp
  return ((int) c) - 48;
     548:	83 e8 30             	sub    $0x30,%eax
}
     54b:	c3                   	ret    
     54c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000550 <negatoi>:
int negatoi(char* str) {
     550:	55                   	push   %ebp
     551:	89 e5                	mov    %esp,%ebp
     553:	53                   	push   %ebx
     554:	83 ec 04             	sub    $0x4,%esp
     557:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (str[0] == '-') {
     55a:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     55d:	74 11                	je     570 <negatoi+0x20>
}
     55f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     562:	c9                   	leave  
  return atoi(str);
     563:	e9 68 0f 00 00       	jmp    14d0 <atoi>
     568:	90                   	nop
     569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    substr(str, str, 1, strlen(str));
     570:	83 ec 0c             	sub    $0xc,%esp
     573:	53                   	push   %ebx
     574:	e8 f7 0d 00 00       	call   1370 <strlen>
     579:	50                   	push   %eax
     57a:	6a 01                	push   $0x1
     57c:	53                   	push   %ebx
     57d:	53                   	push   %ebx
     57e:	e8 2d ff ff ff       	call   4b0 <substr>
    return 0 - atoi(str);
     583:	83 c4 14             	add    $0x14,%esp
     586:	53                   	push   %ebx
     587:	e8 44 0f 00 00       	call   14d0 <atoi>
     58c:	83 c4 10             	add    $0x10,%esp
     58f:	f7 d8                	neg    %eax
}
     591:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     594:	c9                   	leave  
     595:	c3                   	ret    
     596:	8d 76 00             	lea    0x0(%esi),%esi
     599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005a0 <itoa>:
char* itoa(int value, char* result, int base) {
     5a0:	55                   	push   %ebp
     5a1:	89 e5                	mov    %esp,%ebp
     5a3:	53                   	push   %ebx
     5a4:	8b 4d 10             	mov    0x10(%ebp),%ecx
     5a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    if (base < 2 || base > 36) { *result = '\0'; return result; }
     5aa:	8d 41 fe             	lea    -0x2(%ecx),%eax
     5ad:	83 f8 22             	cmp    $0x22,%eax
     5b0:	77 16                	ja     5c8 <itoa+0x28>
     5b2:	8b 45 08             	mov    0x8(%ebp),%eax
     5b5:	89 da                	mov    %ebx,%edx
     5b7:	e8 84 fd ff ff       	call   340 <itoa.part.1>
}
     5bc:	89 d8                	mov    %ebx,%eax
     5be:	5b                   	pop    %ebx
     5bf:	5d                   	pop    %ebp
     5c0:	c3                   	ret    
     5c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (base < 2 || base > 36) { *result = '\0'; return result; }
     5c8:	c6 03 00             	movb   $0x0,(%ebx)
}
     5cb:	89 d8                	mov    %ebx,%eax
     5cd:	5b                   	pop    %ebx
     5ce:	5d                   	pop    %ebp
     5cf:	c3                   	ret    

000005d0 <toUpper>:

void toUpper(char* str) {
     5d0:	55                   	push   %ebp
     5d1:	89 e5                	mov    %esp,%ebp
     5d3:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     5d6:	0f b6 02             	movzbl (%edx),%eax
     5d9:	84 c0                	test   %al,%al
     5db:	74 1a                	je     5f7 <toUpper+0x27>
     5dd:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'z' && c >= 'a')
     5e0:	8d 48 9f             	lea    -0x61(%eax),%ecx
     5e3:	80 f9 19             	cmp    $0x19,%cl
     5e6:	77 05                	ja     5ed <toUpper+0x1d>
      str[i] += ('Z' - 'z');
     5e8:	83 e8 20             	sub    $0x20,%eax
     5eb:	88 02                	mov    %al,(%edx)
     5ed:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     5f0:	0f b6 02             	movzbl (%edx),%eax
     5f3:	84 c0                	test   %al,%al
     5f5:	75 e9                	jne    5e0 <toUpper+0x10>
    i++;  
  }
}
     5f7:	5d                   	pop    %ebp
     5f8:	c3                   	ret    
     5f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000600 <toLower>:

void toLower(char* str) {
     600:	55                   	push   %ebp
     601:	89 e5                	mov    %esp,%ebp
     603:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     606:	0f b6 02             	movzbl (%edx),%eax
     609:	84 c0                	test   %al,%al
     60b:	74 1a                	je     627 <toLower+0x27>
     60d:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'Z' && c >= 'A')
     610:	8d 48 bf             	lea    -0x41(%eax),%ecx
     613:	80 f9 19             	cmp    $0x19,%cl
     616:	77 05                	ja     61d <toLower+0x1d>
      str[i] -= ('Z' - 'z');
     618:	83 c0 20             	add    $0x20,%eax
     61b:	88 02                	mov    %al,(%edx)
     61d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     620:	0f b6 02             	movzbl (%edx),%eax
     623:	84 c0                	test   %al,%al
     625:	75 e9                	jne    610 <toLower+0x10>
    i++;  
  }
}
     627:	5d                   	pop    %ebp
     628:	c3                   	ret    
     629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000630 <nullNode>:
#include "LinkedList.h"
// #include "helpers.h"
#define nullptr 0
// prototypes

Node* nullNode(char* data) {
     630:	55                   	push   %ebp
     631:	89 e5                	mov    %esp,%ebp
     633:	83 ec 14             	sub    $0x14,%esp
  struct Node* node = malloc(sizeof(Node));
     636:	6a 0c                	push   $0xc
     638:	e8 53 13 00 00       	call   1990 <malloc>
  node->prev = nullptr;
  node->data = data;
     63d:	8b 55 08             	mov    0x8(%ebp),%edx
  node->prev = nullptr;
     640:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->next = nullptr;
     646:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  node->data = data;
     64d:	89 50 04             	mov    %edx,0x4(%eax)
  return node;
}
     650:	c9                   	leave  
     651:	c3                   	ret    
     652:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000660 <nodeAt>:

Node* nodeAt(struct LinkedList* list, int pos) {
     660:	55                   	push   %ebp
     661:	89 e5                	mov    %esp,%ebp
     663:	53                   	push   %ebx
     664:	8b 45 08             	mov    0x8(%ebp),%eax
     667:	8b 55 0c             	mov    0xc(%ebp),%edx
  // for anything past the end:
  if (pos > list->len)
     66a:	8b 48 08             	mov    0x8(%eax),%ecx
     66d:	39 d1                	cmp    %edx,%ecx
     66f:	7c 1f                	jl     690 <nodeAt+0x30>
    return list->tail->prev;
  // for anything before the beginning:
  if ((pos < 0) && ((0 - pos) > list->len))
     671:	85 d2                	test   %edx,%edx
     673:	78 2b                	js     6a0 <nodeAt+0x40>
    while (++pos != 0)
      curNode = curNode->prev;
  } // start looking from front
  else {
    int cur = 0;
    curNode = list->head->next;
     675:	8b 00                	mov    (%eax),%eax
     677:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     67a:	74 0e                	je     68a <nodeAt+0x2a>
    int cur = 0;
     67c:	31 c9                	xor    %ecx,%ecx
     67e:	66 90                	xchg   %ax,%ax
      curNode = curNode->next;
      cur++;
     680:	83 c1 01             	add    $0x1,%ecx
      curNode = curNode->next;
     683:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     686:	39 ca                	cmp    %ecx,%edx
     688:	75 f6                	jne    680 <nodeAt+0x20>
    }
  }
  return curNode;
}
     68a:	5b                   	pop    %ebx
     68b:	5d                   	pop    %ebp
     68c:	c3                   	ret    
     68d:	8d 76 00             	lea    0x0(%esi),%esi
    return list->tail->prev;
     690:	8b 40 04             	mov    0x4(%eax),%eax
}
     693:	5b                   	pop    %ebx
     694:	5d                   	pop    %ebp
    return list->tail->prev;
     695:	8b 00                	mov    (%eax),%eax
}
     697:	c3                   	ret    
     698:	90                   	nop
     699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if ((pos < 0) && ((0 - pos) > list->len))
     6a0:	89 d3                	mov    %edx,%ebx
     6a2:	f7 db                	neg    %ebx
     6a4:	39 d9                	cmp    %ebx,%ecx
     6a6:	7c 18                	jl     6c0 <nodeAt+0x60>
    while (++pos != 0)
     6a8:	83 c2 01             	add    $0x1,%edx
    curNode = list->tail;
     6ab:	8b 40 04             	mov    0x4(%eax),%eax
    while (++pos != 0)
     6ae:	74 da                	je     68a <nodeAt+0x2a>
     6b0:	83 c2 01             	add    $0x1,%edx
      curNode = curNode->prev;
     6b3:	8b 00                	mov    (%eax),%eax
    while (++pos != 0)
     6b5:	75 f9                	jne    6b0 <nodeAt+0x50>
}
     6b7:	5b                   	pop    %ebx
     6b8:	5d                   	pop    %ebp
     6b9:	c3                   	ret    
     6ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return list->head->next;
     6c0:	8b 00                	mov    (%eax),%eax
     6c2:	8b 40 08             	mov    0x8(%eax),%eax
     6c5:	eb c3                	jmp    68a <nodeAt+0x2a>
     6c7:	89 f6                	mov    %esi,%esi
     6c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006d0 <destroyNode>:

void destroyNode(struct LinkedList* list, struct Node* self) {
     6d0:	55                   	push   %ebp
     6d1:	89 e5                	mov    %esp,%ebp
     6d3:	56                   	push   %esi
     6d4:	53                   	push   %ebx
     6d5:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     6d8:	8b 75 08             	mov    0x8(%ebp),%esi
    self->prev->next = self->next;
    self->next->prev = self->prev;

    free(self->data);
     6db:	83 ec 0c             	sub    $0xc,%esp
    self->prev->next = self->next;
     6de:	8b 03                	mov    (%ebx),%eax
     6e0:	8b 53 08             	mov    0x8(%ebx),%edx
     6e3:	89 50 08             	mov    %edx,0x8(%eax)
    self->next->prev = self->prev;
     6e6:	8b 43 08             	mov    0x8(%ebx),%eax
     6e9:	8b 13                	mov    (%ebx),%edx
     6eb:	89 10                	mov    %edx,(%eax)
    free(self->data);
     6ed:	ff 73 04             	pushl  0x4(%ebx)
     6f0:	e8 0b 12 00 00       	call   1900 <free>
    free(self);
     6f5:	89 1c 24             	mov    %ebx,(%esp)
     6f8:	e8 03 12 00 00       	call   1900 <free>
    list->len--;
     6fd:	83 6e 08 01          	subl   $0x1,0x8(%esi)
}
     701:	83 c4 10             	add    $0x10,%esp
     704:	8d 65 f8             	lea    -0x8(%ebp),%esp
     707:	5b                   	pop    %ebx
     708:	5e                   	pop    %esi
     709:	5d                   	pop    %ebp
     70a:	c3                   	ret    
     70b:	90                   	nop
     70c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000710 <MakeLinkedList>:

LinkedList* MakeLinkedList() {
     710:	55                   	push   %ebp
     711:	89 e5                	mov    %esp,%ebp
     713:	56                   	push   %esi
     714:	53                   	push   %ebx
  struct LinkedList* list = malloc(sizeof(LinkedList));
     715:	83 ec 0c             	sub    $0xc,%esp
     718:	6a 0c                	push   $0xc
     71a:	e8 71 12 00 00       	call   1990 <malloc>
  struct Node* node = malloc(sizeof(Node));
     71f:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  struct LinkedList* list = malloc(sizeof(LinkedList));
     726:	89 c6                	mov    %eax,%esi
  struct Node* node = malloc(sizeof(Node));
     728:	e8 63 12 00 00       	call   1990 <malloc>
     72d:	89 c3                	mov    %eax,%ebx
  node->prev = nullptr;
     72f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->data = data;
     735:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  node->next = nullptr;
     73c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  struct Node* node = malloc(sizeof(Node));
     743:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     74a:	e8 41 12 00 00       	call   1990 <malloc>
  node->data = data;
     74f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  Node* head = nullNode(nullptr);
  Node* tail = nullNode(nullptr);
  head->prev = nullptr;
  head->next = tail;
     756:	89 43 08             	mov    %eax,0x8(%ebx)
  head->prev = nullptr;
     759:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  tail->prev = head;
     75f:	89 18                	mov    %ebx,(%eax)
  tail->next = nullptr;
     761:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)

  list->len = 0;
  list->head = head;
  list->tail = tail;
     768:	89 46 04             	mov    %eax,0x4(%esi)
  return list;
}
     76b:	89 f0                	mov    %esi,%eax
  list->len = 0;
     76d:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
  list->head = head;
     774:	89 1e                	mov    %ebx,(%esi)
}
     776:	8d 65 f8             	lea    -0x8(%ebp),%esp
     779:	5b                   	pop    %ebx
     77a:	5e                   	pop    %esi
     77b:	5d                   	pop    %ebp
     77c:	c3                   	ret    
     77d:	8d 76 00             	lea    0x0(%esi),%esi

00000780 <insert>:

void insert(struct LinkedList* list, char* data, int pos) {
     780:	55                   	push   %ebp
     781:	89 e5                	mov    %esp,%ebp
     783:	57                   	push   %edi
     784:	56                   	push   %esi
     785:	53                   	push   %ebx
     786:	83 ec 0c             	sub    $0xc,%esp
     789:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct Node* atPos = nodeAt(list, pos);
     78c:	ff 75 10             	pushl  0x10(%ebp)
     78f:	53                   	push   %ebx
     790:	e8 cb fe ff ff       	call   660 <nodeAt>
     795:	83 ec 04             	sub    $0x4,%esp
     798:	89 c6                	mov    %eax,%esi
  char* newData = (char*)malloc(sizeof(char) * 1000);
     79a:	68 e8 03 00 00       	push   $0x3e8
     79f:	e8 ec 11 00 00       	call   1990 <malloc>
     7a4:	8b 55 0c             	mov    0xc(%ebp),%edx
     7a7:	89 c7                	mov    %eax,%edi
     7a9:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
     7ae:	e8 4d fb ff ff       	call   300 <safestrcpy.part.0>
  newData = safestrcpy(newData, data, (sizeof(char) * 1000));
  struct Node* new = malloc(sizeof(Node));
     7b3:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     7ba:	e8 d1 11 00 00       	call   1990 <malloc>

  new->data = newData;
     7bf:	89 78 04             	mov    %edi,0x4(%eax)
  new->prev = atPos->prev;
     7c2:	8b 16                	mov    (%esi),%edx
  new->next = atPos;
  new->prev->next = new;
  atPos->prev = new;
  list->len++;
}
     7c4:	83 c4 10             	add    $0x10,%esp
  new->next = atPos;
     7c7:	89 70 08             	mov    %esi,0x8(%eax)
  new->prev = atPos->prev;
     7ca:	89 10                	mov    %edx,(%eax)
  new->prev->next = new;
     7cc:	89 42 08             	mov    %eax,0x8(%edx)
  atPos->prev = new;
     7cf:	89 06                	mov    %eax,(%esi)
  list->len++;
     7d1:	83 43 08 01          	addl   $0x1,0x8(%ebx)
}
     7d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7d8:	5b                   	pop    %ebx
     7d9:	5e                   	pop    %esi
     7da:	5f                   	pop    %edi
     7db:	5d                   	pop    %ebp
     7dc:	c3                   	ret    
     7dd:	8d 76 00             	lea    0x0(%esi),%esi

000007e0 <prepend>:

void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
     7e0:	55                   	push   %ebp
     7e1:	89 e5                	mov    %esp,%ebp
     7e3:	83 ec 0c             	sub    $0xc,%esp
     7e6:	6a 00                	push   $0x0
     7e8:	ff 75 0c             	pushl  0xc(%ebp)
     7eb:	ff 75 08             	pushl  0x8(%ebp)
     7ee:	e8 8d ff ff ff       	call   780 <insert>
     7f3:	83 c4 10             	add    $0x10,%esp
     7f6:	c9                   	leave  
     7f7:	c3                   	ret    
     7f8:	90                   	nop
     7f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000800 <append>:
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     800:	55                   	push   %ebp
     801:	89 e5                	mov    %esp,%ebp
     803:	83 ec 0c             	sub    $0xc,%esp
     806:	8b 45 08             	mov    0x8(%ebp),%eax
     809:	ff 70 08             	pushl  0x8(%eax)
     80c:	ff 75 0c             	pushl  0xc(%ebp)
     80f:	50                   	push   %eax
     810:	e8 6b ff ff ff       	call   780 <insert>
     815:	83 c4 10             	add    $0x10,%esp
     818:	c9                   	leave  
     819:	c3                   	ret    
     81a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000820 <destroyLinkedList>:

void destroyLinkedList(struct LinkedList* list) {
     820:	55                   	push   %ebp
     821:	89 e5                	mov    %esp,%ebp
     823:	56                   	push   %esi
     824:	53                   	push   %ebx
     825:	8b 75 08             	mov    0x8(%ebp),%esi
  struct Node* curNode = list->head;
     828:	8b 1e                	mov    (%esi),%ebx
  while (curNode != list->tail) {
     82a:	8b 46 04             	mov    0x4(%esi),%eax
     82d:	39 c3                	cmp    %eax,%ebx
     82f:	74 29                	je     85a <destroyLinkedList+0x3a>
     831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
     838:	8b 5b 08             	mov    0x8(%ebx),%ebx
    free(curNode->prev->data);
     83b:	83 ec 0c             	sub    $0xc,%esp
     83e:	8b 03                	mov    (%ebx),%eax
     840:	ff 70 04             	pushl  0x4(%eax)
     843:	e8 b8 10 00 00       	call   1900 <free>
    free(curNode->prev);
     848:	58                   	pop    %eax
     849:	ff 33                	pushl  (%ebx)
     84b:	e8 b0 10 00 00       	call   1900 <free>
  while (curNode != list->tail) {
     850:	8b 46 04             	mov    0x4(%esi),%eax
     853:	83 c4 10             	add    $0x10,%esp
     856:	39 d8                	cmp    %ebx,%eax
     858:	75 de                	jne    838 <destroyLinkedList+0x18>
  }
  free(curNode);
     85a:	83 ec 0c             	sub    $0xc,%esp
     85d:	50                   	push   %eax
     85e:	e8 9d 10 00 00       	call   1900 <free>
  free(list);
     863:	89 75 08             	mov    %esi,0x8(%ebp)
     866:	83 c4 10             	add    $0x10,%esp
     869:	8d 65 f8             	lea    -0x8(%ebp),%esp
     86c:	5b                   	pop    %ebx
     86d:	5e                   	pop    %esi
     86e:	5d                   	pop    %ebp
  free(list);
     86f:	e9 8c 10 00 00       	jmp    1900 <free>
     874:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     87a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000880 <confirmation>:
// line-oriented text helpers
#include "textEditHelpers.h"

int confirmation() {
     880:	55                   	push   %ebp
     881:	89 e5                	mov    %esp,%ebp
     883:	53                   	push   %ebx
  // get response
  char buf[MAXLINESIZE];
  int nbuf = sizeof(buf);
  memset(buf, 0, nbuf);
     884:	8d 9d 10 fc ff ff    	lea    -0x3f0(%ebp),%ebx
int confirmation() {
     88a:	81 ec f8 03 00 00    	sub    $0x3f8,%esp
  memset(buf, 0, nbuf);
     890:	68 e8 03 00 00       	push   $0x3e8
     895:	6a 00                	push   $0x0
     897:	53                   	push   %ebx
     898:	e8 03 0b 00 00       	call   13a0 <memset>
  gets(buf, nbuf);
     89d:	58                   	pop    %eax
     89e:	5a                   	pop    %edx
     89f:	68 e8 03 00 00       	push   $0x3e8
     8a4:	53                   	push   %ebx
     8a5:	e8 56 0b 00 00       	call   1400 <gets>
  // determine output
  switch (buf[0]) {
     8aa:	0f b6 85 10 fc ff ff 	movzbl -0x3f0(%ebp),%eax
     8b1:	83 c4 10             	add    $0x10,%esp
     8b4:	3c 59                	cmp    $0x59,%al
     8b6:	74 18                	je     8d0 <confirmation+0x50>
     8b8:	3c 79                	cmp    $0x79,%al
     8ba:	74 14                	je     8d0 <confirmation+0x50>
  case 'Y':
  case 'y':
    return 0;
  default:
    return 1;
     8bc:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
     8c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8c4:	c9                   	leave  
     8c5:	c3                   	ret    
     8c6:	8d 76 00             	lea    0x0(%esi),%esi
     8c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return 0;
     8d0:	31 c0                	xor    %eax,%eax
}
     8d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8d5:	c9                   	leave  
     8d6:	c3                   	ret    
     8d7:	89 f6                	mov    %esi,%esi
     8d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008e0 <normalizeRange>:
    return 1;

  return 0;
}

int normalizeRange(File file, int* sp, int* ep) {
     8e0:	55                   	push   %ebp
     8e1:	89 e5                	mov    %esp,%ebp
     8e3:	53                   	push   %ebx
     8e4:	8b 4d 24             	mov    0x24(%ebp),%ecx
  int l = file.len;
     8e7:	8b 45 18             	mov    0x18(%ebp),%eax
int normalizeRange(File file, int* sp, int* ep) {
     8ea:	8b 5d 20             	mov    0x20(%ebp),%ebx
  if (*ep > l) *ep = l;
     8ed:	8b 11                	mov    (%ecx),%edx
     8ef:	39 c2                	cmp    %eax,%edx
     8f1:	7e 45                	jle    938 <normalizeRange+0x58>
     8f3:	89 01                	mov    %eax,(%ecx)
     8f5:	89 c2                	mov    %eax,%edx
  else if (*ep < 1) *ep += l + 1;
  if (*ep < 1) *ep = 1;
     8f7:	85 d2                	test   %edx,%edx
     8f9:	7f 06                	jg     901 <normalizeRange+0x21>
     8fb:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)

  if (*sp > l) *sp = l;
     901:	8b 13                	mov    (%ebx),%edx
     903:	39 c2                	cmp    %eax,%edx
     905:	7e 21                	jle    928 <normalizeRange+0x48>
     907:	89 03                	mov    %eax,(%ebx)
     909:	89 c2                	mov    %eax,%edx
  else if (*sp < 1) *sp += l + 1;
  if (*sp < 1) *sp = 1;
     90b:	85 d2                	test   %edx,%edx
     90d:	7f 0b                	jg     91a <normalizeRange+0x3a>
     90f:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
     915:	ba 01 00 00 00       	mov    $0x1,%edx
  if ((*ep - *sp) < 0)
     91a:	8b 01                	mov    (%ecx),%eax
    return 1;
  return 0;
}
     91c:	5b                   	pop    %ebx
     91d:	5d                   	pop    %ebp
  if ((*ep - *sp) < 0)
     91e:	29 d0                	sub    %edx,%eax
     920:	c1 e8 1f             	shr    $0x1f,%eax
}
     923:	c3                   	ret    
     924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*sp < 1) *sp += l + 1;
     928:	85 d2                	test   %edx,%edx
     92a:	7f ee                	jg     91a <normalizeRange+0x3a>
     92c:	8d 54 10 01          	lea    0x1(%eax,%edx,1),%edx
     930:	89 13                	mov    %edx,(%ebx)
     932:	eb d7                	jmp    90b <normalizeRange+0x2b>
     934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*ep < 1) *ep += l + 1;
     938:	85 d2                	test   %edx,%edx
     93a:	7f c5                	jg     901 <normalizeRange+0x21>
     93c:	8d 54 02 01          	lea    0x1(%edx,%eax,1),%edx
     940:	89 11                	mov    %edx,(%ecx)
     942:	eb b3                	jmp    8f7 <normalizeRange+0x17>
     944:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     94a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000950 <numLines>:

int numLines(int start, int end) {
     950:	55                   	push   %ebp
     951:	89 e5                	mov    %esp,%ebp
  return (end - start) + 1;
     953:	8b 45 0c             	mov    0xc(%ebp),%eax
     956:	2b 45 08             	sub    0x8(%ebp),%eax
}
     959:	5d                   	pop    %ebp
  return (end - start) + 1;
     95a:	83 c0 01             	add    $0x1,%eax
}
     95d:	c3                   	ret    
     95e:	66 90                	xchg   %ax,%ax

00000960 <gatherLines>:

// text
void gatherLines(File* file) {
     960:	55                   	push   %ebp
     961:	89 e5                	mov    %esp,%ebp
     963:	56                   	push   %esi
     964:	53                   	push   %ebx
     965:	8d b5 10 fc ff ff    	lea    -0x3f0(%ebp),%esi
     96b:	81 ec f0 03 00 00    	sub    $0x3f0,%esp
     971:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char line[MAXLINESIZE];
  while (getLine(file->fd, line)) {
     974:	eb 21                	jmp    997 <gatherLines+0x37>
     976:	8d 76 00             	lea    0x0(%esi),%esi
     979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    append(file->lines, line);
     980:	8b 43 0c             	mov    0xc(%ebx),%eax
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     983:	83 ec 04             	sub    $0x4,%esp
     986:	ff 70 08             	pushl  0x8(%eax)
     989:	56                   	push   %esi
     98a:	50                   	push   %eax
     98b:	e8 f0 fd ff ff       	call   780 <insert>
    file->len++;
     990:	83 43 10 01          	addl   $0x1,0x10(%ebx)
     994:	83 c4 10             	add    $0x10,%esp
  while (getLine(file->fd, line)) {
     997:	83 ec 08             	sub    $0x8,%esp
     99a:	56                   	push   %esi
     99b:	ff 73 04             	pushl  0x4(%ebx)
     99e:	e8 1d fa ff ff       	call   3c0 <getLine>
     9a3:	83 c4 10             	add    $0x10,%esp
     9a6:	85 c0                	test   %eax,%eax
     9a8:	75 d6                	jne    980 <gatherLines+0x20>
  }
}
     9aa:	8d 65 f8             	lea    -0x8(%ebp),%esp
     9ad:	5b                   	pop    %ebx
     9ae:	5e                   	pop    %esi
     9af:	5d                   	pop    %ebp
     9b0:	c3                   	ret    
     9b1:	eb 0d                	jmp    9c0 <getArg>
     9b3:	90                   	nop
     9b4:	90                   	nop
     9b5:	90                   	nop
     9b6:	90                   	nop
     9b7:	90                   	nop
     9b8:	90                   	nop
     9b9:	90                   	nop
     9ba:	90                   	nop
     9bb:	90                   	nop
     9bc:	90                   	nop
     9bd:	90                   	nop
     9be:	90                   	nop
     9bf:	90                   	nop

000009c0 <getArg>:

void getArg(char* dest, char* args, char delimiter) {
     9c0:	55                   	push   %ebp
     9c1:	89 e5                	mov    %esp,%ebp
     9c3:	57                   	push   %edi
     9c4:	56                   	push   %esi
     9c5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     9c6:	31 db                	xor    %ebx,%ebx
     9c8:	83 ec 1c             	sub    $0x1c,%esp
     9cb:	8b 75 0c             	mov    0xc(%ebp),%esi
     9ce:	0f b6 7d 10          	movzbl 0x10(%ebp),%edi
     9d2:	eb 10                	jmp    9e4 <getArg+0x24>
     9d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     9d8:	89 f8                	mov    %edi,%eax
     9da:	3a 04 1e             	cmp    (%esi,%ebx,1),%al
     9dd:	8d 53 01             	lea    0x1(%ebx),%edx
     9e0:	74 19                	je     9fb <getArg+0x3b>
     9e2:	89 d3                	mov    %edx,%ebx
  for (int i = 0; i < strlen(str); i++)
     9e4:	83 ec 0c             	sub    $0xc,%esp
     9e7:	56                   	push   %esi
     9e8:	e8 83 09 00 00       	call   1370 <strlen>
     9ed:	83 c4 10             	add    $0x10,%esp
     9f0:	39 c3                	cmp    %eax,%ebx
     9f2:	72 e4                	jb     9d8 <getArg+0x18>
     9f4:	31 d2                	xor    %edx,%edx
  return -1;
     9f6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  int end = find(args, delimiter);
  substr(dest, args, 0, end);
     9fb:	53                   	push   %ebx
     9fc:	6a 00                	push   $0x0
     9fe:	56                   	push   %esi
     9ff:	ff 75 08             	pushl  0x8(%ebp)
     a02:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     a05:	e8 a6 fa ff ff       	call   4b0 <substr>
  substr(args, args, end + 1, (int) strlen(args));
     a0a:	89 34 24             	mov    %esi,(%esp)
     a0d:	e8 5e 09 00 00       	call   1370 <strlen>
     a12:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     a15:	50                   	push   %eax
     a16:	52                   	push   %edx
     a17:	56                   	push   %esi
     a18:	56                   	push   %esi
     a19:	e8 92 fa ff ff       	call   4b0 <substr>
}
     a1e:	83 c4 20             	add    $0x20,%esp
     a21:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a24:	5b                   	pop    %ebx
     a25:	5e                   	pop    %esi
     a26:	5f                   	pop    %edi
     a27:	5d                   	pop    %ebp
     a28:	c3                   	ret    
     a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a30 <collectRange>:
int collectRange(char* args, int* startptr, int* endptr) {
     a30:	55                   	push   %ebp
     a31:	89 e5                	mov    %esp,%ebp
     a33:	57                   	push   %edi
     a34:	56                   	push   %esi
     a35:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     a36:	31 f6                	xor    %esi,%esi
     a38:	83 ec 2c             	sub    $0x2c,%esp
     a3b:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a3e:	eb 09                	jmp    a49 <collectRange+0x19>
    if (str[i] == c) return i;
     a40:	80 3c 33 3a          	cmpb   $0x3a,(%ebx,%esi,1)
     a44:	74 42                	je     a88 <collectRange+0x58>
  for (int i = 0; i < strlen(str); i++)
     a46:	83 c6 01             	add    $0x1,%esi
     a49:	83 ec 0c             	sub    $0xc,%esp
     a4c:	53                   	push   %ebx
     a4d:	e8 1e 09 00 00       	call   1370 <strlen>
     a52:	83 c4 10             	add    $0x10,%esp
     a55:	39 c6                	cmp    %eax,%esi
     a57:	72 e7                	jb     a40 <collectRange+0x10>
    if (args[0] == '-') {
     a59:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     a5c:	0f 84 d6 00 00 00    	je     b38 <collectRange+0x108>
      *startptr = atoi(args);
     a62:	83 ec 0c             	sub    $0xc,%esp
     a65:	53                   	push   %ebx
     a66:	e8 65 0a 00 00       	call   14d0 <atoi>
     a6b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     a6e:	83 c4 10             	add    $0x10,%esp
     a71:	89 01                	mov    %eax,(%ecx)
    *endptr = *startptr;
     a73:	8b 4d 10             	mov    0x10(%ebp),%ecx
     a76:	89 01                	mov    %eax,(%ecx)
    return 0;
     a78:	31 c0                	xor    %eax,%eax
}
     a7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a7d:	5b                   	pop    %ebx
     a7e:	5e                   	pop    %esi
     a7f:	5f                   	pop    %edi
     a80:	5d                   	pop    %ebp
     a81:	c3                   	ret    
     a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  getArg(startstr, args, ':');
     a88:	8d 75 de             	lea    -0x22(%ebp),%esi
     a8b:	83 ec 04             	sub    $0x4,%esp
     a8e:	6a 3a                	push   $0x3a
     a90:	53                   	push   %ebx
     a91:	56                   	push   %esi
     a92:	e8 29 ff ff ff       	call   9c0 <getArg>
  if (startstr[0] == '-') {
     a97:	83 c4 10             	add    $0x10,%esp
     a9a:	80 7d de 2d          	cmpb   $0x2d,-0x22(%ebp)
     a9e:	0f 84 3c 01 00 00    	je     be0 <collectRange+0x1b0>
  int negStartFlag = 0, negEndFlag = 0;
     aa4:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     aab:	31 ff                	xor    %edi,%edi
  if (endstr[0] == '-') {
     aad:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     ab0:	0f 84 0a 01 00 00    	je     bc0 <collectRange+0x190>
  if (strcmp(startstr, "\0") == 0) *startptr = 1;
     ab6:	83 ec 08             	sub    $0x8,%esp
     ab9:	68 9c 1c 00 00       	push   $0x1c9c
     abe:	56                   	push   %esi
     abf:	e8 5c 08 00 00       	call   1320 <strcmp>
     ac4:	83 c4 10             	add    $0x10,%esp
     ac7:	85 c0                	test   %eax,%eax
     ac9:	0f 85 d1 00 00 00    	jne    ba0 <collectRange+0x170>
     acf:	8b 45 0c             	mov    0xc(%ebp),%eax
     ad2:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  if (strcmp(endstr, "\0") == 0) *endptr = -1;
     ad8:	83 ec 08             	sub    $0x8,%esp
     adb:	68 9c 1c 00 00       	push   $0x1c9c
     ae0:	53                   	push   %ebx
     ae1:	e8 3a 08 00 00       	call   1320 <strcmp>
     ae6:	83 c4 10             	add    $0x10,%esp
     ae9:	85 c0                	test   %eax,%eax
     aeb:	0f 85 97 00 00 00    	jne    b88 <collectRange+0x158>
     af1:	8b 45 10             	mov    0x10(%ebp),%eax
     af4:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  if (negStartFlag) *startptr = 0 - *startptr;
     afa:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     afd:	85 c0                	test   %eax,%eax
     aff:	74 05                	je     b06 <collectRange+0xd6>
     b01:	8b 45 0c             	mov    0xc(%ebp),%eax
     b04:	f7 18                	negl   (%eax)
  if (negEndFlag) *endptr = 0 - *endptr;
     b06:	85 ff                	test   %edi,%edi
     b08:	74 05                	je     b0f <collectRange+0xdf>
     b0a:	8b 45 10             	mov    0x10(%ebp),%eax
     b0d:	f7 18                	negl   (%eax)
  if (((*startptr > 0 && *endptr > 0) || 
     b0f:	8b 45 0c             	mov    0xc(%ebp),%eax
     b12:	8b 00                	mov    (%eax),%eax
     b14:	83 f8 00             	cmp    $0x0,%eax
     b17:	7e 4f                	jle    b68 <collectRange+0x138>
     b19:	8b 55 10             	mov    0x10(%ebp),%edx
     b1c:	8b 12                	mov    (%edx),%edx
     b1e:	85 d2                	test   %edx,%edx
     b20:	7e 55                	jle    b77 <collectRange+0x147>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     b22:	39 d0                	cmp    %edx,%eax
     b24:	0f 9f c0             	setg   %al
}
     b27:	8d 65 f4             	lea    -0xc(%ebp),%esp
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     b2a:	0f b6 c0             	movzbl %al,%eax
}
     b2d:	5b                   	pop    %ebx
     b2e:	5e                   	pop    %esi
     b2f:	5f                   	pop    %edi
     b30:	5d                   	pop    %ebp
     b31:	c3                   	ret    
     b32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      substr(args, args, 1, strlen(args));
     b38:	83 ec 0c             	sub    $0xc,%esp
     b3b:	53                   	push   %ebx
     b3c:	e8 2f 08 00 00       	call   1370 <strlen>
     b41:	50                   	push   %eax
     b42:	6a 01                	push   $0x1
     b44:	53                   	push   %ebx
     b45:	53                   	push   %ebx
     b46:	e8 65 f9 ff ff       	call   4b0 <substr>
      *startptr = 0 - atoi(args);
     b4b:	83 c4 14             	add    $0x14,%esp
     b4e:	53                   	push   %ebx
     b4f:	e8 7c 09 00 00       	call   14d0 <atoi>
     b54:	8b 7d 0c             	mov    0xc(%ebp),%edi
     b57:	f7 d8                	neg    %eax
     b59:	83 c4 10             	add    $0x10,%esp
     b5c:	89 07                	mov    %eax,(%edi)
     b5e:	e9 10 ff ff ff       	jmp    a73 <collectRange+0x43>
     b63:	90                   	nop
     b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (((*startptr > 0 && *endptr > 0) || 
     b68:	0f 84 0c ff ff ff    	je     a7a <collectRange+0x4a>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     b6e:	8b 7d 10             	mov    0x10(%ebp),%edi
     b71:	8b 17                	mov    (%edi),%edx
     b73:	85 d2                	test   %edx,%edx
     b75:	78 ab                	js     b22 <collectRange+0xf2>
}
     b77:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
     b7a:	31 c0                	xor    %eax,%eax
}
     b7c:	5b                   	pop    %ebx
     b7d:	5e                   	pop    %esi
     b7e:	5f                   	pop    %edi
     b7f:	5d                   	pop    %ebp
     b80:	c3                   	ret    
     b81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else *endptr = atoi(endstr);
     b88:	83 ec 0c             	sub    $0xc,%esp
     b8b:	53                   	push   %ebx
     b8c:	e8 3f 09 00 00       	call   14d0 <atoi>
     b91:	8b 55 10             	mov    0x10(%ebp),%edx
     b94:	83 c4 10             	add    $0x10,%esp
     b97:	89 02                	mov    %eax,(%edx)
     b99:	e9 5c ff ff ff       	jmp    afa <collectRange+0xca>
     b9e:	66 90                	xchg   %ax,%ax
  else *startptr = atoi(startstr);
     ba0:	83 ec 0c             	sub    $0xc,%esp
     ba3:	56                   	push   %esi
     ba4:	e8 27 09 00 00       	call   14d0 <atoi>
     ba9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     bac:	83 c4 10             	add    $0x10,%esp
     baf:	89 01                	mov    %eax,(%ecx)
     bb1:	e9 22 ff ff ff       	jmp    ad8 <collectRange+0xa8>
     bb6:	8d 76 00             	lea    0x0(%esi),%esi
     bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    substr(endstr, endstr, 1, strlen(endstr));
     bc0:	83 ec 0c             	sub    $0xc,%esp
    negEndFlag = 1;
     bc3:	bf 01 00 00 00       	mov    $0x1,%edi
    substr(endstr, endstr, 1, strlen(endstr));
     bc8:	53                   	push   %ebx
     bc9:	e8 a2 07 00 00       	call   1370 <strlen>
     bce:	50                   	push   %eax
     bcf:	6a 01                	push   $0x1
     bd1:	53                   	push   %ebx
     bd2:	53                   	push   %ebx
     bd3:	e8 d8 f8 ff ff       	call   4b0 <substr>
     bd8:	83 c4 20             	add    $0x20,%esp
     bdb:	e9 d6 fe ff ff       	jmp    ab6 <collectRange+0x86>
    substr(startstr, startstr, 1, strlen(startstr));
     be0:	83 ec 0c             	sub    $0xc,%esp
     be3:	56                   	push   %esi
     be4:	e8 87 07 00 00       	call   1370 <strlen>
     be9:	50                   	push   %eax
     bea:	6a 01                	push   $0x1
     bec:	56                   	push   %esi
     bed:	56                   	push   %esi
     bee:	e8 bd f8 ff ff       	call   4b0 <substr>
     bf3:	83 c4 20             	add    $0x20,%esp
    negStartFlag = 1;
     bf6:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
     bfd:	e9 a9 fe ff ff       	jmp    aab <collectRange+0x7b>
     c02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c10 <unline>:

void unline(char* str) {
     c10:	55                   	push   %ebp
     c11:	89 e5                	mov    %esp,%ebp
     c13:	53                   	push   %ebx
     c14:	83 ec 10             	sub    $0x10,%esp
     c17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str) - 1;
     c1a:	53                   	push   %ebx
     c1b:	e8 50 07 00 00       	call   1370 <strlen>
     c20:	8d 50 ff             	lea    -0x1(%eax),%edx
  for (; len > 0; len--) {
     c23:	83 c4 10             	add    $0x10,%esp
     c26:	85 d2                	test   %edx,%edx
     c28:	7e 36                	jle    c60 <unline+0x50>
    char c = str[len];
    if (c == '\n')
     c2a:	80 7c 03 ff 0a       	cmpb   $0xa,-0x1(%ebx,%eax,1)
     c2f:	74 2f                	je     c60 <unline+0x50>
     c31:	8d 44 03 fe          	lea    -0x2(%ebx,%eax,1),%eax
     c35:	eb 12                	jmp    c49 <unline+0x39>
     c37:	89 f6                	mov    %esi,%esi
     c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     c40:	83 e8 01             	sub    $0x1,%eax
     c43:	80 78 01 0a          	cmpb   $0xa,0x1(%eax)
     c47:	74 06                	je     c4f <unline+0x3f>
  for (; len > 0; len--) {
     c49:	39 c3                	cmp    %eax,%ebx
     c4b:	89 c2                	mov    %eax,%edx
     c4d:	75 f1                	jne    c40 <unline+0x30>
      break;
  }
  str[len] = '\0';
     c4f:	c6 02 00             	movb   $0x0,(%edx)
}
     c52:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c55:	c9                   	leave  
     c56:	c3                   	ret    
     c57:	89 f6                	mov    %esi,%esi
     c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     c60:	01 da                	add    %ebx,%edx
  str[len] = '\0';
     c62:	c6 02 00             	movb   $0x0,(%edx)
}
     c65:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c68:	c9                   	leave  
     c69:	c3                   	ret    
     c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000c70 <gatherLinesSized>:

// int* gatherLineSized(struct File* file, Terminal terminal) {
void gatherLinesSized(struct File* file, Terminal terminal) {
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
     c73:	57                   	push   %edi
     c74:	56                   	push   %esi
     c75:	53                   	push   %ebx
     c76:	81 ec 0c 04 00 00    	sub    $0x40c,%esp
     c7c:	8b 75 0c             	mov    0xc(%ebp),%esi
     c7f:	8b 7d 08             	mov    0x8(%ebp),%edi
  while (getLine(file->fd, line)) {
    int cols = 0;
    // printf("line:\n %s\n", line + cols);
    // printf("strlen(line + cols) = %d\n", strlen(line + cols));
    for (; strlen(line + cols) > terminal.width;) {
      char piece[terminal.width + 1]; // make room for null terminator
     c82:	8d 46 10             	lea    0x10(%esi),%eax
     c85:	89 f3                	mov    %esi,%ebx
     c87:	c1 e8 04             	shr    $0x4,%eax
     c8a:	89 85 ec fb ff ff    	mov    %eax,-0x414(%ebp)
  while (getLine(file->fd, line)) {
     c90:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     c96:	83 ec 08             	sub    $0x8,%esp
     c99:	50                   	push   %eax
     c9a:	ff 77 04             	pushl  0x4(%edi)
     c9d:	e8 1e f7 ff ff       	call   3c0 <getLine>
     ca2:	83 c4 10             	add    $0x10,%esp
     ca5:	85 c0                	test   %eax,%eax
     ca7:	0f 84 83 00 00 00    	je     d30 <gatherLinesSized+0xc0>
     cad:	8d b5 00 fc ff ff    	lea    -0x400(%ebp),%esi
     cb3:	eb 4b                	jmp    d00 <gatherLinesSized+0x90>
     cb5:	8d 76 00             	lea    0x0(%esi),%esi
      char piece[terminal.width + 1]; // make room for null terminator
     cb8:	8b 85 ec fb ff ff    	mov    -0x414(%ebp),%eax
     cbe:	8d 4b 01             	lea    0x1(%ebx),%ecx
    for (; strlen(line + cols) > terminal.width;) {
     cc1:	89 a5 f4 fb ff ff    	mov    %esp,-0x40c(%ebp)
      char piece[terminal.width + 1]; // make room for null terminator
     cc7:	c1 e0 04             	shl    $0x4,%eax
     cca:	29 c4                	sub    %eax,%esp
  if(n <= 0)
     ccc:	85 c9                	test   %ecx,%ecx
     cce:	89 a5 f0 fb ff ff    	mov    %esp,-0x410(%ebp)
     cd4:	7e 09                	jle    cdf <gatherLinesSized+0x6f>
     cd6:	89 f2                	mov    %esi,%edx
     cd8:	89 e0                	mov    %esp,%eax
     cda:	e8 21 f6 ff ff       	call   300 <safestrcpy.part.0>
      safestrcpy(piece, line + cols, terminal.width + 1); 
      append(file->lines, piece);
     cdf:	8b 47 0c             	mov    0xc(%edi),%eax
     ce2:	83 ec 04             	sub    $0x4,%esp
     ce5:	01 de                	add    %ebx,%esi
     ce7:	ff 70 08             	pushl  0x8(%eax)
     cea:	ff b5 f0 fb ff ff    	pushl  -0x410(%ebp)
     cf0:	50                   	push   %eax
     cf1:	e8 8a fa ff ff       	call   780 <insert>
      file->len++;
     cf6:	83 47 10 01          	addl   $0x1,0x10(%edi)
     cfa:	8b a5 f4 fb ff ff    	mov    -0x40c(%ebp),%esp
    for (; strlen(line + cols) > terminal.width;) {
     d00:	83 ec 0c             	sub    $0xc,%esp
     d03:	56                   	push   %esi
     d04:	e8 67 06 00 00       	call   1370 <strlen>
     d09:	83 c4 10             	add    $0x10,%esp
     d0c:	39 d8                	cmp    %ebx,%eax
     d0e:	77 a8                	ja     cb8 <gatherLinesSized+0x48>
      numSplits++;
      cols += terminal.width;
      // printf("line:\n %s\n", line + cols);
      // printf("strlen(line + cols) = %d\n", strlen(line + cols));
    }
    append(file->lines, line + cols);
     d10:	8b 47 0c             	mov    0xc(%edi),%eax
     d13:	83 ec 04             	sub    $0x4,%esp
     d16:	ff 70 08             	pushl  0x8(%eax)
     d19:	56                   	push   %esi
     d1a:	50                   	push   %eax
     d1b:	e8 60 fa ff ff       	call   780 <insert>
    file->len++;
     d20:	83 47 10 01          	addl   $0x1,0x10(%edi)
     d24:	83 c4 10             	add    $0x10,%esp
     d27:	e9 64 ff ff ff       	jmp    c90 <gatherLinesSized+0x20>
     d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  // return ;
}
     d30:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d33:	5b                   	pop    %ebx
     d34:	5e                   	pop    %esi
     d35:	5f                   	pop    %edi
     d36:	5d                   	pop    %ebp
     d37:	c3                   	ret    
     d38:	90                   	nop
     d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d40 <lineAt>:


// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
     d40:	55                   	push   %ebp
     d41:	89 e5                	mov    %esp,%ebp
  return nodeAt(list, pos-1);
     d43:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
}
     d47:	5d                   	pop    %ebp
  return nodeAt(list, pos-1);
     d48:	e9 13 f9 ff ff       	jmp    660 <nodeAt>
     d4d:	8d 76 00             	lea    0x0(%esi),%esi

00000d50 <printl>:

void printl(int lineNum, char* line) {
     d50:	55                   	push   %ebp
     d51:	89 e5                	mov    %esp,%ebp
     d53:	83 ec 08             	sub    $0x8,%esp
     d56:	8b 45 08             	mov    0x8(%ebp),%eax
  if (lineNum < 10)
     d59:	83 f8 09             	cmp    $0x9,%eax
     d5c:	7e 3a                	jle    d98 <printl+0x48>
    fprintf(2, "%d  : %s\n", lineNum, line);
  else if (lineNum < 100)
     d5e:	83 f8 63             	cmp    $0x63,%eax
     d61:	7e 1d                	jle    d80 <printl+0x30>
    fprintf(2, "%d : %s\n", lineNum, line);
  else
    fprintf(2, "%d: %s\n", lineNum, line);
     d63:	ff 75 0c             	pushl  0xc(%ebp)
     d66:	50                   	push   %eax
     d67:	68 03 1e 00 00       	push   $0x1e03
     d6c:	6a 02                	push   $0x2
     d6e:	e8 4d 0b 00 00       	call   18c0 <fprintf>
     d73:	83 c4 10             	add    $0x10,%esp
}
     d76:	c9                   	leave  
     d77:	c3                   	ret    
     d78:	90                   	nop
     d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "%d : %s\n", lineNum, line);
     d80:	ff 75 0c             	pushl  0xc(%ebp)
     d83:	50                   	push   %eax
     d84:	68 fa 1d 00 00       	push   $0x1dfa
     d89:	6a 02                	push   $0x2
     d8b:	e8 30 0b 00 00       	call   18c0 <fprintf>
     d90:	83 c4 10             	add    $0x10,%esp
}
     d93:	c9                   	leave  
     d94:	c3                   	ret    
     d95:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "%d  : %s\n", lineNum, line);
     d98:	ff 75 0c             	pushl  0xc(%ebp)
     d9b:	50                   	push   %eax
     d9c:	68 f0 1d 00 00       	push   $0x1df0
     da1:	6a 02                	push   $0x2
     da3:	e8 18 0b 00 00       	call   18c0 <fprintf>
     da8:	83 c4 10             	add    $0x10,%esp
}
     dab:	c9                   	leave  
     dac:	c3                   	ret    
     dad:	8d 76 00             	lea    0x0(%esi),%esi

00000db0 <printpad>:

// prints the string with padding of a certain character
void printpad(int pad, char padChar, char* str, int alignment, int endLine) {
     db0:	55                   	push   %ebp
     db1:	89 e5                	mov    %esp,%ebp
     db3:	57                   	push   %edi
     db4:	56                   	push   %esi
     db5:	53                   	push   %ebx
     db6:	83 ec 28             	sub    $0x28,%esp
     db9:	8b 45 0c             	mov    0xc(%ebp),%eax
     dbc:	8b 7d 10             	mov    0x10(%ebp),%edi
     dbf:	8b 5d 08             	mov    0x8(%ebp),%ebx
     dc2:	8b 75 14             	mov    0x14(%ebp),%esi
     dc5:	89 45 e0             	mov    %eax,-0x20(%ebp)
     dc8:	8b 45 18             	mov    0x18(%ebp),%eax
  int len = strlen(str);
     dcb:	57                   	push   %edi
void printpad(int pad, char padChar, char* str, int alignment, int endLine) {
     dcc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int len = strlen(str);
     dcf:	e8 9c 05 00 00       	call   1370 <strlen>
  int i = pad - len;
  if (alignment == LEFT) {
     dd4:	83 c4 10             	add    $0x10,%esp
  int i = pad - len;
     dd7:	29 c3                	sub    %eax,%ebx
  if (alignment == LEFT) {
     dd9:	85 f6                	test   %esi,%esi
     ddb:	74 7b                	je     e58 <printpad+0xa8>
    printf("%s", str);
    for (; i > 0; i--)
      printf("%c", padChar);
  } else if (alignment == RIGHT) {
     ddd:	83 fe 02             	cmp    $0x2,%esi
     de0:	74 1e                	je     e00 <printpad+0x50>
    for (; i > 0; i--)
      printf("%c", padChar);
    printf("%s", str);
  } else if (alignment == CENTER) {
     de2:	83 fe 01             	cmp    $0x1,%esi
     de5:	0f 84 ad 00 00 00    	je     e98 <printpad+0xe8>
      printf("%c", padChar);
      if (i == half)
        printf("%s", str);
    }
  }
  if (endLine) {
     deb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     dee:	85 c0                	test   %eax,%eax
     df0:	75 4c                	jne    e3e <printpad+0x8e>
    printf("\n");
  }
     df2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     df5:	5b                   	pop    %ebx
     df6:	5e                   	pop    %esi
     df7:	5f                   	pop    %edi
     df8:	5d                   	pop    %ebp
     df9:	c3                   	ret    
     dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for (; i > 0; i--)
     e00:	85 db                	test   %ebx,%ebx
     e02:	7e 22                	jle    e26 <printpad+0x76>
     e04:	0f be 75 e0          	movsbl -0x20(%ebp),%esi
     e08:	90                   	nop
     e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printf("%c", padChar);
     e10:	83 ec 08             	sub    $0x8,%esp
     e13:	56                   	push   %esi
     e14:	68 0e 1e 00 00       	push   $0x1e0e
     e19:	e8 c2 0a 00 00       	call   18e0 <printf>
    for (; i > 0; i--)
     e1e:	83 c4 10             	add    $0x10,%esp
     e21:	83 eb 01             	sub    $0x1,%ebx
     e24:	75 ea                	jne    e10 <printpad+0x60>
    printf("%s", str);
     e26:	83 ec 08             	sub    $0x8,%esp
     e29:	57                   	push   %edi
     e2a:	68 0b 1e 00 00       	push   $0x1e0b
     e2f:	e8 ac 0a 00 00       	call   18e0 <printf>
  if (endLine) {
     e34:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     e37:	83 c4 10             	add    $0x10,%esp
     e3a:	85 c0                	test   %eax,%eax
     e3c:	74 b4                	je     df2 <printpad+0x42>
    printf("\n");
     e3e:	c7 45 08 91 1e 00 00 	movl   $0x1e91,0x8(%ebp)
     e45:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e48:	5b                   	pop    %ebx
     e49:	5e                   	pop    %esi
     e4a:	5f                   	pop    %edi
     e4b:	5d                   	pop    %ebp
    printf("\n");
     e4c:	e9 8f 0a 00 00       	jmp    18e0 <printf>
     e51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    printf("%s", str);
     e58:	83 ec 08             	sub    $0x8,%esp
     e5b:	57                   	push   %edi
     e5c:	68 0b 1e 00 00       	push   $0x1e0b
     e61:	e8 7a 0a 00 00       	call   18e0 <printf>
    for (; i > 0; i--)
     e66:	83 c4 10             	add    $0x10,%esp
     e69:	85 db                	test   %ebx,%ebx
     e6b:	0f 8e 7a ff ff ff    	jle    deb <printpad+0x3b>
     e71:	0f be 75 e0          	movsbl -0x20(%ebp),%esi
     e75:	8d 76 00             	lea    0x0(%esi),%esi
      printf("%c", padChar);
     e78:	83 ec 08             	sub    $0x8,%esp
     e7b:	56                   	push   %esi
     e7c:	68 0e 1e 00 00       	push   $0x1e0e
     e81:	e8 5a 0a 00 00       	call   18e0 <printf>
    for (; i > 0; i--)
     e86:	83 c4 10             	add    $0x10,%esp
     e89:	83 eb 01             	sub    $0x1,%ebx
     e8c:	75 ea                	jne    e78 <printpad+0xc8>
     e8e:	e9 58 ff ff ff       	jmp    deb <printpad+0x3b>
     e93:	90                   	nop
     e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int half = i / 2;
     e98:	89 d8                	mov    %ebx,%eax
     e9a:	c1 e8 1f             	shr    $0x1f,%eax
     e9d:	01 d8                	add    %ebx,%eax
     e9f:	d1 f8                	sar    %eax
    for (; i > 0; i--) {
     ea1:	85 db                	test   %ebx,%ebx
    int half = i / 2;
     ea3:	89 45 dc             	mov    %eax,-0x24(%ebp)
    for (; i > 0; i--) {
     ea6:	0f 8e 3f ff ff ff    	jle    deb <printpad+0x3b>
     eac:	0f be 75 e0          	movsbl -0x20(%ebp),%esi
     eb0:	eb 0f                	jmp    ec1 <printpad+0x111>
     eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     eb8:	83 eb 01             	sub    $0x1,%ebx
     ebb:	0f 84 2a ff ff ff    	je     deb <printpad+0x3b>
      printf("%c", padChar);
     ec1:	83 ec 08             	sub    $0x8,%esp
     ec4:	56                   	push   %esi
     ec5:	68 0e 1e 00 00       	push   $0x1e0e
     eca:	e8 11 0a 00 00       	call   18e0 <printf>
      if (i == half)
     ecf:	83 c4 10             	add    $0x10,%esp
     ed2:	39 5d dc             	cmp    %ebx,-0x24(%ebp)
     ed5:	75 e1                	jne    eb8 <printpad+0x108>
        printf("%s", str);
     ed7:	83 ec 08             	sub    $0x8,%esp
     eda:	57                   	push   %edi
     edb:	68 0b 1e 00 00       	push   $0x1e0b
     ee0:	e8 fb 09 00 00       	call   18e0 <printf>
     ee5:	83 c4 10             	add    $0x10,%esp
     ee8:	eb ce                	jmp    eb8 <printpad+0x108>
     eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000ef0 <line>:
void line(File file, Terminal terminal){
     ef0:	55                   	push   %ebp
     ef1:	b9 0a 00 00 00       	mov    $0xa,%ecx
     ef6:	89 e5                	mov    %esp,%ebp
     ef8:	56                   	push   %esi
     ef9:	53                   	push   %ebx
     efa:	8d 5d ee             	lea    -0x12(%ebp),%ebx
     efd:	83 ec 10             	sub    $0x10,%esp
     f00:	8b 45 10             	mov    0x10(%ebp),%eax
     f03:	8b 75 20             	mov    0x20(%ebp),%esi
     f06:	89 da                	mov    %ebx,%edx
     f08:	e8 33 f4 ff ff       	call   340 <itoa.part.1>
  printpad(terminal.width, ' ', msg, LEFT, 0);
     f0d:	83 ec 0c             	sub    $0xc,%esp
     f10:	6a 00                	push   $0x0
     f12:	6a 00                	push   $0x0
     f14:	53                   	push   %ebx
     f15:	6a 20                	push   $0x20
     f17:	56                   	push   %esi
     f18:	e8 93 fe ff ff       	call   db0 <printpad>
  printf("\r"); // we want to rewrite this line eventually
     f1d:	83 c4 14             	add    $0x14,%esp
     f20:	68 11 1e 00 00       	push   $0x1e11
     f25:	e8 b6 09 00 00       	call   18e0 <printf>
}
     f2a:	83 c4 10             	add    $0x10,%esp
     f2d:	8d 65 f8             	lea    -0x8(%ebp),%esp
     f30:	5b                   	pop    %ebx
     f31:	5e                   	pop    %esi
     f32:	5d                   	pop    %ebp
     f33:	c3                   	ret    
     f34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000f40 <help>:
void help(Terminal terminal) {
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	53                   	push   %ebx
     f44:	83 ec 10             	sub    $0x10,%esp
     f47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printpad(terminal.width, '-', "-", LEFT, 1);
     f4a:	6a 01                	push   $0x1
     f4c:	6a 00                	push   $0x0
     f4e:	68 13 1e 00 00       	push   $0x1e13
     f53:	6a 2d                	push   $0x2d
     f55:	53                   	push   %ebx
     f56:	e8 55 fe ff ff       	call   db0 <printpad>
  printf("Command       Description [Def Parameter]\n");
     f5b:	83 c4 14             	add    $0x14,%esp
     f5e:	68 d0 1a 00 00       	push   $0x1ad0
     f63:	e8 78 09 00 00       	call   18e0 <printf>
  printf("<space>       Display next page\n");
     f68:	c7 04 24 fc 1a 00 00 	movl   $0x1afc,(%esp)
     f6f:	e8 6c 09 00 00       	call   18e0 <printf>
  printf("<int> e,E,s,S Display next <int> lines [1]\n");
     f74:	c7 04 24 20 1b 00 00 	movl   $0x1b20,(%esp)
     f7b:	e8 60 09 00 00       	call   18e0 <printf>
  printf("<int> b,B     Skip back <int> screens [1]\n");
     f80:	c7 04 24 4c 1b 00 00 	movl   $0x1b4c,(%esp)
     f87:	e8 54 09 00 00       	call   18e0 <printf>
  printf("<int> f,F     Skip forward <int> screens [1]\n");
     f8c:	c7 04 24 78 1b 00 00 	movl   $0x1b78,(%esp)
     f93:	e8 48 09 00 00       	call   18e0 <printf>
  printf("=             Display current line number\n");
     f98:	c7 04 24 a8 1b 00 00 	movl   $0x1ba8,(%esp)
     f9f:	e8 3c 09 00 00       	call   18e0 <printf>
  printf(".             Repeat previous command\n");
     fa4:	c7 04 24 d4 1b 00 00 	movl   $0x1bd4,(%esp)
     fab:	e8 30 09 00 00       	call   18e0 <printf>
  printf("l or L        Redraw screen\n");
     fb0:	c7 04 24 15 1e 00 00 	movl   $0x1e15,(%esp)
     fb7:	e8 24 09 00 00       	call   18e0 <printf>
  printf("q or Q        Exit from more\n");
     fbc:	c7 04 24 32 1e 00 00 	movl   $0x1e32,(%esp)
     fc3:	e8 18 09 00 00       	call   18e0 <printf>
  printpad(terminal.width, '-', "-", LEFT, 1);
     fc8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     fcf:	6a 00                	push   $0x0
     fd1:	68 13 1e 00 00       	push   $0x1e13
     fd6:	6a 2d                	push   $0x2d
     fd8:	53                   	push   %ebx
     fd9:	e8 d2 fd ff ff       	call   db0 <printpad>
}
     fde:	83 c4 20             	add    $0x20,%esp
     fe1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fe4:	c9                   	leave  
     fe5:	c3                   	ret    
     fe6:	8d 76 00             	lea    0x0(%esi),%esi
     fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ff0 <printPrompt>:
void printPrompt(File file) {
     ff0:	55                   	push   %ebp
     ff1:	89 e5                	mov    %esp,%ebp
     ff3:	83 ec 10             	sub    $0x10,%esp
  printf("--MORE--(%d%%)", 100 * file.curLine / file.len);
     ff6:	6b 45 10 64          	imul   $0x64,0x10(%ebp),%eax
     ffa:	99                   	cltd   
     ffb:	f7 7d 18             	idivl  0x18(%ebp)
     ffe:	50                   	push   %eax
     fff:	68 50 1e 00 00       	push   $0x1e50
    1004:	e8 d7 08 00 00       	call   18e0 <printf>
  printf("[Press space to continue, 'q' to quit.]\r");
    1009:	83 c4 10             	add    $0x10,%esp
    100c:	c7 45 08 fc 1b 00 00 	movl   $0x1bfc,0x8(%ebp)
}
    1013:	c9                   	leave  
  printf("[Press space to continue, 'q' to quit.]\r");
    1014:	e9 c7 08 00 00       	jmp    18e0 <printf>
    1019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001020 <showPage>:
void showPage(File file, Terminal terminal) {
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	57                   	push   %edi
    1024:	56                   	push   %esi
    1025:	53                   	push   %ebx
    1026:	83 ec 1c             	sub    $0x1c,%esp
  struct Node* curNode = lineAt(file.lines, LINE_ON_TOP);
    1029:	8b 55 24             	mov    0x24(%ebp),%edx
    102c:	8b 45 10             	mov    0x10(%ebp),%eax
    102f:	8b 75 14             	mov    0x14(%ebp),%esi
void showPage(File file, Terminal terminal) {
    1032:	8b 7d 20             	mov    0x20(%ebp),%edi
  struct Node* curNode = lineAt(file.lines, LINE_ON_TOP);
    1035:	8d 4a ff             	lea    -0x1(%edx),%ecx
    1038:	89 45 e0             	mov    %eax,-0x20(%ebp)
    103b:	29 c8                	sub    %ecx,%eax
    103d:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  return nodeAt(list, pos-1);
    1040:	50                   	push   %eax
    1041:	56                   	push   %esi
    1042:	e8 19 f6 ff ff       	call   660 <nodeAt>
  while (termLine < TERMH_ADJ) {
    1047:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    104a:	5a                   	pop    %edx
    104b:	59                   	pop    %ecx
    104c:	85 db                	test   %ebx,%ebx
    104e:	7e 4d                	jle    109d <showPage+0x7d>
      printpad(terminal.width, ' ', curNode->data, LEFT, 1);
    1050:	83 ec 0c             	sub    $0xc,%esp
    1053:	89 c3                	mov    %eax,%ebx
    1055:	6a 01                	push   $0x1
    1057:	6a 00                	push   $0x0
    1059:	ff 70 04             	pushl  0x4(%eax)
    105c:	6a 20                	push   $0x20
    105e:	57                   	push   %edi
    105f:	e8 4c fd ff ff       	call   db0 <printpad>
    curNode = curNode->next;
    1064:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) exit();
    1067:	83 c4 20             	add    $0x20,%esp
    106a:	3b 5e 04             	cmp    0x4(%esi),%ebx
    106d:	74 5a                	je     10c9 <showPage+0xa9>
  while (termLine < TERMH_ADJ) {
    106f:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1073:	74 28                	je     109d <showPage+0x7d>
    termLine++;
    1075:	bf 01 00 00 00       	mov    $0x1,%edi
    } else printf("%s\n", curNode->data);
    107a:	83 ec 08             	sub    $0x8,%esp
    107d:	ff 73 04             	pushl  0x4(%ebx)
    termLine++;
    1080:	83 c7 01             	add    $0x1,%edi
    } else printf("%s\n", curNode->data);
    1083:	68 f6 1d 00 00       	push   $0x1df6
    1088:	e8 53 08 00 00       	call   18e0 <printf>
    curNode = curNode->next;
    108d:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) exit();
    1090:	83 c4 10             	add    $0x10,%esp
    1093:	39 5e 04             	cmp    %ebx,0x4(%esi)
    1096:	74 31                	je     10c9 <showPage+0xa9>
  while (termLine < TERMH_ADJ) {
    1098:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
    109b:	75 dd                	jne    107a <showPage+0x5a>
  printf("--MORE--(%d%%)", 100 * file.curLine / file.len);
    109d:	6b 45 e0 64          	imul   $0x64,-0x20(%ebp),%eax
    10a1:	83 ec 08             	sub    $0x8,%esp
    10a4:	99                   	cltd   
    10a5:	f7 7d 18             	idivl  0x18(%ebp)
    10a8:	50                   	push   %eax
    10a9:	68 50 1e 00 00       	push   $0x1e50
    10ae:	e8 2d 08 00 00       	call   18e0 <printf>
  printf("[Press space to continue, 'q' to quit.]\r");
    10b3:	c7 45 08 fc 1b 00 00 	movl   $0x1bfc,0x8(%ebp)
    10ba:	83 c4 10             	add    $0x10,%esp
}
    10bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10c0:	5b                   	pop    %ebx
    10c1:	5e                   	pop    %esi
    10c2:	5f                   	pop    %edi
    10c3:	5d                   	pop    %ebp
  printf("[Press space to continue, 'q' to quit.]\r");
    10c4:	e9 17 08 00 00       	jmp    18e0 <printf>
    if (curNode == file.lines->tail) exit();
    10c9:	e8 74 04 00 00       	call   1542 <exit>
    10ce:	66 90                	xchg   %ax,%ax

000010d0 <forward>:
void forward(struct File* file, Terminal terminal){
    10d0:	55                   	push   %ebp
    10d1:	89 e5                	mov    %esp,%ebp
    10d3:	56                   	push   %esi
    10d4:	53                   	push   %ebx
    10d5:	8b 45 08             	mov    0x8(%ebp),%eax
    10d8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    10db:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  file->curLine += TERMH_ADJ; // forward 1 page
    10de:	8d 53 ff             	lea    -0x1(%ebx),%edx
    10e1:	03 50 08             	add    0x8(%eax),%edx
  if (file->curLine > file->len) file->curLine = file->len;
    10e4:	8b 70 10             	mov    0x10(%eax),%esi
    10e7:	39 f2                	cmp    %esi,%edx
  file->curLine += TERMH_ADJ; // forward 1 page
    10e9:	89 50 08             	mov    %edx,0x8(%eax)
  if (file->curLine > file->len) file->curLine = file->len;
    10ec:	7e 03                	jle    10f1 <forward+0x21>
    10ee:	89 70 08             	mov    %esi,0x8(%eax)
  showPage(*file, terminal);
    10f1:	53                   	push   %ebx
    10f2:	51                   	push   %ecx
    10f3:	ff 70 14             	pushl  0x14(%eax)
    10f6:	ff 70 10             	pushl  0x10(%eax)
    10f9:	ff 70 0c             	pushl  0xc(%eax)
    10fc:	ff 70 08             	pushl  0x8(%eax)
    10ff:	ff 70 04             	pushl  0x4(%eax)
    1102:	ff 30                	pushl  (%eax)
    1104:	e8 17 ff ff ff       	call   1020 <showPage>
}
    1109:	83 c4 20             	add    $0x20,%esp
    110c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    110f:	5b                   	pop    %ebx
    1110:	5e                   	pop    %esi
    1111:	5d                   	pop    %ebp
    1112:	c3                   	ret    
    1113:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001120 <skip>:
void skip(struct File* file, Terminal terminal, int numPages){
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	57                   	push   %edi
    1124:	56                   	push   %esi
    1125:	53                   	push   %ebx
    1126:	83 ec 0c             	sub    $0xc,%esp
    1129:	8b 7d 10             	mov    0x10(%ebp),%edi
    112c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    112f:	8b 75 0c             	mov    0xc(%ebp),%esi
  file->curLine += (numPages * TERMH_ADJ); // forward x pages
    1132:	8d 47 ff             	lea    -0x1(%edi),%eax
  if (file->curLine > file->len) file->curLine = file->len;
    1135:	8b 53 10             	mov    0x10(%ebx),%edx
  file->curLine += (numPages * TERMH_ADJ); // forward x pages
    1138:	0f af 45 14          	imul   0x14(%ebp),%eax
    113c:	03 43 08             	add    0x8(%ebx),%eax
  if (file->curLine > file->len) file->curLine = file->len;
    113f:	39 d0                	cmp    %edx,%eax
  file->curLine += (numPages * TERMH_ADJ); // forward x pages
    1141:	89 43 08             	mov    %eax,0x8(%ebx)
  if (file->curLine > file->len) file->curLine = file->len;
    1144:	7e 03                	jle    1149 <skip+0x29>
    1146:	89 53 08             	mov    %edx,0x8(%ebx)
  printpad(terminal.width, ' ', msg, LEFT, 0);
    1149:	83 ec 0c             	sub    $0xc,%esp
    114c:	6a 00                	push   $0x0
    114e:	6a 00                	push   $0x0
    1150:	68 5f 1e 00 00       	push   $0x1e5f
    1155:	6a 20                	push   $0x20
    1157:	56                   	push   %esi
    1158:	e8 53 fc ff ff       	call   db0 <printpad>
  showPage(*file, terminal);
    115d:	83 c4 20             	add    $0x20,%esp
    1160:	57                   	push   %edi
    1161:	56                   	push   %esi
    1162:	ff 73 14             	pushl  0x14(%ebx)
    1165:	ff 73 10             	pushl  0x10(%ebx)
    1168:	ff 73 0c             	pushl  0xc(%ebx)
    116b:	ff 73 08             	pushl  0x8(%ebx)
    116e:	ff 73 04             	pushl  0x4(%ebx)
    1171:	ff 33                	pushl  (%ebx)
    1173:	e8 a8 fe ff ff       	call   1020 <showPage>
}
    1178:	83 c4 20             	add    $0x20,%esp
    117b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    117e:	5b                   	pop    %ebx
    117f:	5e                   	pop    %esi
    1180:	5f                   	pop    %edi
    1181:	5d                   	pop    %ebp
    1182:	c3                   	ret    
    1183:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001190 <back>:
void back(struct File* file, Terminal terminal, int numPages){
    1190:	55                   	push   %ebp
    1191:	89 e5                	mov    %esp,%ebp
    1193:	57                   	push   %edi
    1194:	56                   	push   %esi
    1195:	53                   	push   %ebx
    1196:	83 ec 18             	sub    $0x18,%esp
    1199:	8b 7d 10             	mov    0x10(%ebp),%edi
    119c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  file->curLine -= (numPages * TERMH_ADJ); // back x pages
    119f:	8b 55 14             	mov    0x14(%ebp),%edx
void back(struct File* file, Terminal terminal, int numPages){
    11a2:	8b 75 0c             	mov    0xc(%ebp),%esi
  file->curLine -= (numPages * TERMH_ADJ); // back x pages
    11a5:	8d 47 ff             	lea    -0x1(%edi),%eax
    11a8:	8b 4b 08             	mov    0x8(%ebx),%ecx
    11ab:	0f af d0             	imul   %eax,%edx
    11ae:	29 d1                	sub    %edx,%ecx
    11b0:	39 c8                	cmp    %ecx,%eax
    11b2:	0f 4e c1             	cmovle %ecx,%eax
    11b5:	89 43 08             	mov    %eax,0x8(%ebx)
  printpad(terminal.width, ' ', msg, LEFT, 0);
    11b8:	6a 00                	push   $0x0
    11ba:	6a 00                	push   $0x0
    11bc:	68 6b 1e 00 00       	push   $0x1e6b
    11c1:	6a 20                	push   $0x20
    11c3:	56                   	push   %esi
    11c4:	e8 e7 fb ff ff       	call   db0 <printpad>
  showPage(*file, terminal);
    11c9:	83 c4 20             	add    $0x20,%esp
    11cc:	57                   	push   %edi
    11cd:	56                   	push   %esi
    11ce:	ff 73 14             	pushl  0x14(%ebx)
    11d1:	ff 73 10             	pushl  0x10(%ebx)
    11d4:	ff 73 0c             	pushl  0xc(%ebx)
    11d7:	ff 73 08             	pushl  0x8(%ebx)
    11da:	ff 73 04             	pushl  0x4(%ebx)
    11dd:	ff 33                	pushl  (%ebx)
    11df:	e8 3c fe ff ff       	call   1020 <showPage>
}
    11e4:	83 c4 20             	add    $0x20,%esp
    11e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11ea:	5b                   	pop    %ebx
    11eb:	5e                   	pop    %esi
    11ec:	5f                   	pop    %edi
    11ed:	5d                   	pop    %ebp
    11ee:	c3                   	ret    
    11ef:	90                   	nop

000011f0 <showLines>:
void showLines(File file, Terminal terminal, int numLines) {
    11f0:	55                   	push   %ebp
    11f1:	89 e5                	mov    %esp,%ebp
    11f3:	57                   	push   %edi
    11f4:	56                   	push   %esi
    11f5:	53                   	push   %ebx
    11f6:	83 ec 1c             	sub    $0x1c,%esp
    11f9:	8b 45 20             	mov    0x20(%ebp),%eax
    11fc:	8b 75 14             	mov    0x14(%ebp),%esi
    11ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1202:	8b 45 10             	mov    0x10(%ebp),%eax
    1205:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1208:	83 e8 01             	sub    $0x1,%eax
    120b:	50                   	push   %eax
    120c:	56                   	push   %esi
    120d:	e8 4e f4 ff ff       	call   660 <nodeAt>
    1212:	5a                   	pop    %edx
  struct Node* curNode = (lineAt(file.lines, file.curLine))->next;
    1213:	8b 58 08             	mov    0x8(%eax),%ebx
    1216:	8b 7d 28             	mov    0x28(%ebp),%edi
  int firstLine = 1;
    1219:	ba 01 00 00 00       	mov    $0x1,%edx
    121e:	59                   	pop    %ecx
  while (numLines-- > 0) {
    121f:	eb 29                	jmp    124a <showLines+0x5a>
    1221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printpad(terminal.width, ' ', curNode->data, LEFT, 1);
    1228:	83 ec 0c             	sub    $0xc,%esp
    122b:	6a 01                	push   $0x1
    122d:	6a 00                	push   $0x0
    122f:	51                   	push   %ecx
    1230:	6a 20                	push   $0x20
    1232:	ff 75 e4             	pushl  -0x1c(%ebp)
    1235:	e8 76 fb ff ff       	call   db0 <printpad>
    123a:	83 c4 20             	add    $0x20,%esp
    curNode = curNode->next;
    123d:	8b 5b 08             	mov    0x8(%ebx),%ebx
    1240:	83 ef 01             	sub    $0x1,%edi
    1243:	31 d2                	xor    %edx,%edx
    if (curNode == file.lines->tail) exit();
    1245:	39 5e 04             	cmp    %ebx,0x4(%esi)
    1248:	74 52                	je     129c <showLines+0xac>
  while (numLines-- > 0) {
    124a:	85 ff                	test   %edi,%edi
    124c:	7e 22                	jle    1270 <showLines+0x80>
    if (firstLine) {
    124e:	85 d2                	test   %edx,%edx
    1250:	8b 4b 04             	mov    0x4(%ebx),%ecx
    1253:	75 d3                	jne    1228 <showLines+0x38>
    } else printf("%s\n", curNode->data);
    1255:	83 ec 08             	sub    $0x8,%esp
    1258:	51                   	push   %ecx
    1259:	68 f6 1d 00 00       	push   $0x1df6
    125e:	e8 7d 06 00 00       	call   18e0 <printf>
    1263:	83 c4 10             	add    $0x10,%esp
    1266:	eb d5                	jmp    123d <showLines+0x4d>
    1268:	90                   	nop
    1269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  printf("--MORE--(%d%%)", 100 * file.curLine / file.len);
    1270:	6b 45 e0 64          	imul   $0x64,-0x20(%ebp),%eax
    1274:	83 ec 08             	sub    $0x8,%esp
    1277:	99                   	cltd   
    1278:	f7 7d 18             	idivl  0x18(%ebp)
    127b:	50                   	push   %eax
    127c:	68 50 1e 00 00       	push   $0x1e50
    1281:	e8 5a 06 00 00       	call   18e0 <printf>
  printf("[Press space to continue, 'q' to quit.]\r");
    1286:	c7 45 08 fc 1b 00 00 	movl   $0x1bfc,0x8(%ebp)
    128d:	83 c4 10             	add    $0x10,%esp
}
    1290:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1293:	5b                   	pop    %ebx
    1294:	5e                   	pop    %esi
    1295:	5f                   	pop    %edi
    1296:	5d                   	pop    %ebp
  printf("[Press space to continue, 'q' to quit.]\r");
    1297:	e9 44 06 00 00       	jmp    18e0 <printf>
    if (curNode == file.lines->tail) exit();
    129c:	e8 a1 02 00 00       	call   1542 <exit>
    12a1:	eb 0d                	jmp    12b0 <scroll>
    12a3:	90                   	nop
    12a4:	90                   	nop
    12a5:	90                   	nop
    12a6:	90                   	nop
    12a7:	90                   	nop
    12a8:	90                   	nop
    12a9:	90                   	nop
    12aa:	90                   	nop
    12ab:	90                   	nop
    12ac:	90                   	nop
    12ad:	90                   	nop
    12ae:	90                   	nop
    12af:	90                   	nop

000012b0 <scroll>:
void scroll(struct File* file, Terminal terminal, int numLines){
    12b0:	55                   	push   %ebp
    12b1:	89 e5                	mov    %esp,%ebp
    12b3:	56                   	push   %esi
    12b4:	53                   	push   %ebx
    12b5:	8b 75 14             	mov    0x14(%ebp),%esi
    12b8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  showLines(*file, terminal, numLines);
    12bb:	83 ec 0c             	sub    $0xc,%esp
    12be:	56                   	push   %esi
    12bf:	ff 75 10             	pushl  0x10(%ebp)
    12c2:	ff 75 0c             	pushl  0xc(%ebp)
    12c5:	ff 73 14             	pushl  0x14(%ebx)
    12c8:	ff 73 10             	pushl  0x10(%ebx)
    12cb:	ff 73 0c             	pushl  0xc(%ebx)
    12ce:	ff 73 08             	pushl  0x8(%ebx)
    12d1:	ff 73 04             	pushl  0x4(%ebx)
    12d4:	ff 33                	pushl  (%ebx)
    12d6:	e8 15 ff ff ff       	call   11f0 <showLines>
  file->curLine += numLines;
    12db:	01 73 08             	add    %esi,0x8(%ebx)
}
    12de:	83 c4 30             	add    $0x30,%esp
    12e1:	8d 65 f8             	lea    -0x8(%ebp),%esp
    12e4:	5b                   	pop    %ebx
    12e5:	5e                   	pop    %esi
    12e6:	5d                   	pop    %ebp
    12e7:	c3                   	ret    
    12e8:	66 90                	xchg   %ax,%ax
    12ea:	66 90                	xchg   %ax,%ax
    12ec:	66 90                	xchg   %ax,%ax
    12ee:	66 90                	xchg   %ax,%ax

000012f0 <strcpy>:
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
    12f0:	55                   	push   %ebp
    12f1:	89 e5                	mov    %esp,%ebp
    12f3:	53                   	push   %ebx
    12f4:	8b 45 08             	mov    0x8(%ebp),%eax
    12f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    12fa:	89 c2                	mov    %eax,%edx
    12fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1300:	83 c1 01             	add    $0x1,%ecx
    1303:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1307:	83 c2 01             	add    $0x1,%edx
    130a:	84 db                	test   %bl,%bl
    130c:	88 5a ff             	mov    %bl,-0x1(%edx)
    130f:	75 ef                	jne    1300 <strcpy+0x10>
    ;
  return os;
}
    1311:	5b                   	pop    %ebx
    1312:	5d                   	pop    %ebp
    1313:	c3                   	ret    
    1314:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    131a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001320 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1320:	55                   	push   %ebp
    1321:	89 e5                	mov    %esp,%ebp
    1323:	53                   	push   %ebx
    1324:	8b 55 08             	mov    0x8(%ebp),%edx
    1327:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    132a:	0f b6 02             	movzbl (%edx),%eax
    132d:	0f b6 19             	movzbl (%ecx),%ebx
    1330:	84 c0                	test   %al,%al
    1332:	75 1c                	jne    1350 <strcmp+0x30>
    1334:	eb 2a                	jmp    1360 <strcmp+0x40>
    1336:	8d 76 00             	lea    0x0(%esi),%esi
    1339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    1340:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1343:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    1346:	83 c1 01             	add    $0x1,%ecx
    1349:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    134c:	84 c0                	test   %al,%al
    134e:	74 10                	je     1360 <strcmp+0x40>
    1350:	38 d8                	cmp    %bl,%al
    1352:	74 ec                	je     1340 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    1354:	29 d8                	sub    %ebx,%eax
}
    1356:	5b                   	pop    %ebx
    1357:	5d                   	pop    %ebp
    1358:	c3                   	ret    
    1359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1360:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    1362:	29 d8                	sub    %ebx,%eax
}
    1364:	5b                   	pop    %ebx
    1365:	5d                   	pop    %ebp
    1366:	c3                   	ret    
    1367:	89 f6                	mov    %esi,%esi
    1369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001370 <strlen>:

uint
strlen(const char *s)
{
    1370:	55                   	push   %ebp
    1371:	89 e5                	mov    %esp,%ebp
    1373:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1376:	80 39 00             	cmpb   $0x0,(%ecx)
    1379:	74 15                	je     1390 <strlen+0x20>
    137b:	31 d2                	xor    %edx,%edx
    137d:	8d 76 00             	lea    0x0(%esi),%esi
    1380:	83 c2 01             	add    $0x1,%edx
    1383:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1387:	89 d0                	mov    %edx,%eax
    1389:	75 f5                	jne    1380 <strlen+0x10>
    ;
  return n;
}
    138b:	5d                   	pop    %ebp
    138c:	c3                   	ret    
    138d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    1390:	31 c0                	xor    %eax,%eax
}
    1392:	5d                   	pop    %ebp
    1393:	c3                   	ret    
    1394:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    139a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000013a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    13a0:	55                   	push   %ebp
    13a1:	89 e5                	mov    %esp,%ebp
    13a3:	57                   	push   %edi
    13a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    13a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    13aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ad:	89 d7                	mov    %edx,%edi
    13af:	fc                   	cld    
    13b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    13b2:	89 d0                	mov    %edx,%eax
    13b4:	5f                   	pop    %edi
    13b5:	5d                   	pop    %ebp
    13b6:	c3                   	ret    
    13b7:	89 f6                	mov    %esi,%esi
    13b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000013c0 <strchr>:

char*
strchr(const char *s, char c)
{
    13c0:	55                   	push   %ebp
    13c1:	89 e5                	mov    %esp,%ebp
    13c3:	53                   	push   %ebx
    13c4:	8b 45 08             	mov    0x8(%ebp),%eax
    13c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    13ca:	0f b6 10             	movzbl (%eax),%edx
    13cd:	84 d2                	test   %dl,%dl
    13cf:	74 1d                	je     13ee <strchr+0x2e>
    if(*s == c)
    13d1:	38 d3                	cmp    %dl,%bl
    13d3:	89 d9                	mov    %ebx,%ecx
    13d5:	75 0d                	jne    13e4 <strchr+0x24>
    13d7:	eb 17                	jmp    13f0 <strchr+0x30>
    13d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13e0:	38 ca                	cmp    %cl,%dl
    13e2:	74 0c                	je     13f0 <strchr+0x30>
  for(; *s; s++)
    13e4:	83 c0 01             	add    $0x1,%eax
    13e7:	0f b6 10             	movzbl (%eax),%edx
    13ea:	84 d2                	test   %dl,%dl
    13ec:	75 f2                	jne    13e0 <strchr+0x20>
      return (char*)s;
  return 0;
    13ee:	31 c0                	xor    %eax,%eax
}
    13f0:	5b                   	pop    %ebx
    13f1:	5d                   	pop    %ebp
    13f2:	c3                   	ret    
    13f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    13f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001400 <gets>:

char*
gets(char *buf, int max)
{
    1400:	55                   	push   %ebp
    1401:	89 e5                	mov    %esp,%ebp
    1403:	57                   	push   %edi
    1404:	56                   	push   %esi
    1405:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1406:	31 f6                	xor    %esi,%esi
    1408:	89 f3                	mov    %esi,%ebx
{
    140a:	83 ec 1c             	sub    $0x1c,%esp
    140d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1410:	eb 2f                	jmp    1441 <gets+0x41>
    1412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1418:	8d 45 e7             	lea    -0x19(%ebp),%eax
    141b:	83 ec 04             	sub    $0x4,%esp
    141e:	6a 01                	push   $0x1
    1420:	50                   	push   %eax
    1421:	6a 00                	push   $0x0
    1423:	e8 32 01 00 00       	call   155a <read>
    if(cc < 1)
    1428:	83 c4 10             	add    $0x10,%esp
    142b:	85 c0                	test   %eax,%eax
    142d:	7e 1c                	jle    144b <gets+0x4b>
      break;
    buf[i++] = c;
    142f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1433:	83 c7 01             	add    $0x1,%edi
    1436:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    1439:	3c 0a                	cmp    $0xa,%al
    143b:	74 23                	je     1460 <gets+0x60>
    143d:	3c 0d                	cmp    $0xd,%al
    143f:	74 1f                	je     1460 <gets+0x60>
  for(i=0; i+1 < max; ){
    1441:	83 c3 01             	add    $0x1,%ebx
    1444:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1447:	89 fe                	mov    %edi,%esi
    1449:	7c cd                	jl     1418 <gets+0x18>
    144b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    144d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1450:	c6 03 00             	movb   $0x0,(%ebx)
}
    1453:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1456:	5b                   	pop    %ebx
    1457:	5e                   	pop    %esi
    1458:	5f                   	pop    %edi
    1459:	5d                   	pop    %ebp
    145a:	c3                   	ret    
    145b:	90                   	nop
    145c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1460:	8b 75 08             	mov    0x8(%ebp),%esi
    1463:	8b 45 08             	mov    0x8(%ebp),%eax
    1466:	01 de                	add    %ebx,%esi
    1468:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    146a:	c6 03 00             	movb   $0x0,(%ebx)
}
    146d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1470:	5b                   	pop    %ebx
    1471:	5e                   	pop    %esi
    1472:	5f                   	pop    %edi
    1473:	5d                   	pop    %ebp
    1474:	c3                   	ret    
    1475:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001480 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
    1480:	55                   	push   %ebp
    1481:	89 e5                	mov    %esp,%ebp
    1483:	56                   	push   %esi
    1484:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1485:	83 ec 08             	sub    $0x8,%esp
    1488:	6a 00                	push   $0x0
    148a:	ff 75 08             	pushl  0x8(%ebp)
    148d:	e8 f8 00 00 00       	call   158a <open>
  if(fd < 0)
    1492:	83 c4 10             	add    $0x10,%esp
    1495:	85 c0                	test   %eax,%eax
    1497:	78 27                	js     14c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1499:	83 ec 08             	sub    $0x8,%esp
    149c:	ff 75 0c             	pushl  0xc(%ebp)
    149f:	89 c3                	mov    %eax,%ebx
    14a1:	50                   	push   %eax
    14a2:	e8 fb 00 00 00       	call   15a2 <fstat>
  close(fd);
    14a7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    14aa:	89 c6                	mov    %eax,%esi
  close(fd);
    14ac:	e8 c1 00 00 00       	call   1572 <close>
  return r;
    14b1:	83 c4 10             	add    $0x10,%esp
}
    14b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    14b7:	89 f0                	mov    %esi,%eax
    14b9:	5b                   	pop    %ebx
    14ba:	5e                   	pop    %esi
    14bb:	5d                   	pop    %ebp
    14bc:	c3                   	ret    
    14bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    14c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    14c5:	eb ed                	jmp    14b4 <stat+0x34>
    14c7:	89 f6                	mov    %esi,%esi
    14c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000014d0 <atoi>:

int
atoi(const char *s)
{
    14d0:	55                   	push   %ebp
    14d1:	89 e5                	mov    %esp,%ebp
    14d3:	53                   	push   %ebx
    14d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    14d7:	0f be 11             	movsbl (%ecx),%edx
    14da:	8d 42 d0             	lea    -0x30(%edx),%eax
    14dd:	3c 09                	cmp    $0x9,%al
  n = 0;
    14df:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    14e4:	77 1f                	ja     1505 <atoi+0x35>
    14e6:	8d 76 00             	lea    0x0(%esi),%esi
    14e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    14f0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    14f3:	83 c1 01             	add    $0x1,%ecx
    14f6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    14fa:	0f be 11             	movsbl (%ecx),%edx
    14fd:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1500:	80 fb 09             	cmp    $0x9,%bl
    1503:	76 eb                	jbe    14f0 <atoi+0x20>
  return n;
}
    1505:	5b                   	pop    %ebx
    1506:	5d                   	pop    %ebp
    1507:	c3                   	ret    
    1508:	90                   	nop
    1509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001510 <memmove>:


void*
memmove(void *vdst, const void *vsrc, int n)
{
    1510:	55                   	push   %ebp
    1511:	89 e5                	mov    %esp,%ebp
    1513:	56                   	push   %esi
    1514:	53                   	push   %ebx
    1515:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1518:	8b 45 08             	mov    0x8(%ebp),%eax
    151b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    151e:	85 db                	test   %ebx,%ebx
    1520:	7e 14                	jle    1536 <memmove+0x26>
    1522:	31 d2                	xor    %edx,%edx
    1524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    1528:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    152c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    152f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    1532:	39 d3                	cmp    %edx,%ebx
    1534:	75 f2                	jne    1528 <memmove+0x18>
  return vdst;
}
    1536:	5b                   	pop    %ebx
    1537:	5e                   	pop    %esi
    1538:	5d                   	pop    %ebp
    1539:	c3                   	ret    

0000153a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    153a:	b8 01 00 00 00       	mov    $0x1,%eax
    153f:	cd 40                	int    $0x40
    1541:	c3                   	ret    

00001542 <exit>:
SYSCALL(exit)
    1542:	b8 02 00 00 00       	mov    $0x2,%eax
    1547:	cd 40                	int    $0x40
    1549:	c3                   	ret    

0000154a <wait>:
SYSCALL(wait)
    154a:	b8 03 00 00 00       	mov    $0x3,%eax
    154f:	cd 40                	int    $0x40
    1551:	c3                   	ret    

00001552 <pipe>:
SYSCALL(pipe)
    1552:	b8 04 00 00 00       	mov    $0x4,%eax
    1557:	cd 40                	int    $0x40
    1559:	c3                   	ret    

0000155a <read>:
SYSCALL(read)
    155a:	b8 05 00 00 00       	mov    $0x5,%eax
    155f:	cd 40                	int    $0x40
    1561:	c3                   	ret    

00001562 <steal>:
SYSCALL(steal)
    1562:	b8 17 00 00 00       	mov    $0x17,%eax
    1567:	cd 40                	int    $0x40
    1569:	c3                   	ret    

0000156a <write>:
SYSCALL(write)
    156a:	b8 10 00 00 00       	mov    $0x10,%eax
    156f:	cd 40                	int    $0x40
    1571:	c3                   	ret    

00001572 <close>:
SYSCALL(close)
    1572:	b8 15 00 00 00       	mov    $0x15,%eax
    1577:	cd 40                	int    $0x40
    1579:	c3                   	ret    

0000157a <kill>:
SYSCALL(kill)
    157a:	b8 06 00 00 00       	mov    $0x6,%eax
    157f:	cd 40                	int    $0x40
    1581:	c3                   	ret    

00001582 <exec>:
SYSCALL(exec)
    1582:	b8 07 00 00 00       	mov    $0x7,%eax
    1587:	cd 40                	int    $0x40
    1589:	c3                   	ret    

0000158a <open>:
SYSCALL(open)
    158a:	b8 0f 00 00 00       	mov    $0xf,%eax
    158f:	cd 40                	int    $0x40
    1591:	c3                   	ret    

00001592 <mknod>:
SYSCALL(mknod)
    1592:	b8 11 00 00 00       	mov    $0x11,%eax
    1597:	cd 40                	int    $0x40
    1599:	c3                   	ret    

0000159a <unlink>:
SYSCALL(unlink)
    159a:	b8 12 00 00 00       	mov    $0x12,%eax
    159f:	cd 40                	int    $0x40
    15a1:	c3                   	ret    

000015a2 <fstat>:
SYSCALL(fstat)
    15a2:	b8 08 00 00 00       	mov    $0x8,%eax
    15a7:	cd 40                	int    $0x40
    15a9:	c3                   	ret    

000015aa <link>:
SYSCALL(link)
    15aa:	b8 13 00 00 00       	mov    $0x13,%eax
    15af:	cd 40                	int    $0x40
    15b1:	c3                   	ret    

000015b2 <mkdir>:
SYSCALL(mkdir)
    15b2:	b8 14 00 00 00       	mov    $0x14,%eax
    15b7:	cd 40                	int    $0x40
    15b9:	c3                   	ret    

000015ba <chdir>:
SYSCALL(chdir)
    15ba:	b8 09 00 00 00       	mov    $0x9,%eax
    15bf:	cd 40                	int    $0x40
    15c1:	c3                   	ret    

000015c2 <dup>:
SYSCALL(dup)
    15c2:	b8 0a 00 00 00       	mov    $0xa,%eax
    15c7:	cd 40                	int    $0x40
    15c9:	c3                   	ret    

000015ca <getpid>:
SYSCALL(getpid)
    15ca:	b8 0b 00 00 00       	mov    $0xb,%eax
    15cf:	cd 40                	int    $0x40
    15d1:	c3                   	ret    

000015d2 <sbrk>:
SYSCALL(sbrk)
    15d2:	b8 0c 00 00 00       	mov    $0xc,%eax
    15d7:	cd 40                	int    $0x40
    15d9:	c3                   	ret    

000015da <sleep>:
SYSCALL(sleep)
    15da:	b8 0d 00 00 00       	mov    $0xd,%eax
    15df:	cd 40                	int    $0x40
    15e1:	c3                   	ret    

000015e2 <uptime>:
SYSCALL(uptime)
    15e2:	b8 0e 00 00 00       	mov    $0xe,%eax
    15e7:	cd 40                	int    $0x40
    15e9:	c3                   	ret    

000015ea <cpuhalt>:
SYSCALL(cpuhalt)
    15ea:	b8 16 00 00 00       	mov    $0x16,%eax
    15ef:	cd 40                	int    $0x40
    15f1:	c3                   	ret    
    15f2:	66 90                	xchg   %ax,%ax
    15f4:	66 90                	xchg   %ax,%ax
    15f6:	66 90                	xchg   %ax,%ax
    15f8:	66 90                	xchg   %ax,%ax
    15fa:	66 90                	xchg   %ax,%ax
    15fc:	66 90                	xchg   %ax,%ax
    15fe:	66 90                	xchg   %ax,%ax

00001600 <printint.constprop.1>:
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
}

static void
printint(int fd, int xx, int base, int sgn)
    1600:	55                   	push   %ebp
    1601:	89 e5                	mov    %esp,%ebp
    1603:	57                   	push   %edi
    1604:	56                   	push   %esi
    1605:	53                   	push   %ebx
    1606:	89 d6                	mov    %edx,%esi
    1608:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    160b:	85 c0                	test   %eax,%eax
    160d:	79 71                	jns    1680 <printint.constprop.1+0x80>
    160f:	83 e1 01             	and    $0x1,%ecx
    1612:	74 6c                	je     1680 <printint.constprop.1+0x80>
    neg = 1;
    x = -xx;
    1614:	f7 d8                	neg    %eax
    neg = 1;
    1616:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    161d:	31 c9                	xor    %ecx,%ecx
    161f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1622:	eb 06                	jmp    162a <printint.constprop.1+0x2a>
    1624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    1628:	89 f9                	mov    %edi,%ecx
    162a:	31 d2                	xor    %edx,%edx
    162c:	8d 79 01             	lea    0x1(%ecx),%edi
    162f:	f7 f6                	div    %esi
    1631:	0f b6 92 9c 1e 00 00 	movzbl 0x1e9c(%edx),%edx
  }while((x /= base) != 0);
    1638:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    163a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    163d:	75 e9                	jne    1628 <printint.constprop.1+0x28>
  if(neg)
    163f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1642:	85 c0                	test   %eax,%eax
    1644:	74 08                	je     164e <printint.constprop.1+0x4e>
    buf[i++] = '-';
    1646:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    164b:	8d 79 02             	lea    0x2(%ecx),%edi
    164e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    1652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1658:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    165b:	83 ec 04             	sub    $0x4,%esp
    165e:	83 ee 01             	sub    $0x1,%esi
    1661:	6a 01                	push   $0x1
    1663:	53                   	push   %ebx
    1664:	6a 01                	push   $0x1
    1666:	88 45 d7             	mov    %al,-0x29(%ebp)
    1669:	e8 fc fe ff ff       	call   156a <write>

  while(--i >= 0)
    166e:	83 c4 10             	add    $0x10,%esp
    1671:	39 de                	cmp    %ebx,%esi
    1673:	75 e3                	jne    1658 <printint.constprop.1+0x58>
    putc(fd, buf[i]);
}
    1675:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1678:	5b                   	pop    %ebx
    1679:	5e                   	pop    %esi
    167a:	5f                   	pop    %edi
    167b:	5d                   	pop    %ebp
    167c:	c3                   	ret    
    167d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
    1680:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1687:	eb 94                	jmp    161d <printint.constprop.1+0x1d>
    1689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001690 <vprintf.constprop.0>:
static void vprintf(int fd, const char *fmt, va_list ap)
    1690:	55                   	push   %ebp
    1691:	89 e5                	mov    %esp,%ebp
    1693:	57                   	push   %edi
    1694:	56                   	push   %esi
    1695:	53                   	push   %ebx
    1696:	89 d6                	mov    %edx,%esi
    1698:	83 ec 2c             	sub    $0x2c,%esp
{
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    169b:	0f b6 10             	movzbl (%eax),%edx
    169e:	84 d2                	test   %dl,%dl
    16a0:	0f 84 cd 00 00 00    	je     1773 <vprintf.constprop.0+0xe3>
    16a6:	8d 58 01             	lea    0x1(%eax),%ebx
  state = 0;
    16a9:	31 ff                	xor    %edi,%edi
    16ab:	eb 31                	jmp    16de <vprintf.constprop.0+0x4e>
    16ad:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    16b0:	83 f8 25             	cmp    $0x25,%eax
    16b3:	0f 84 c7 00 00 00    	je     1780 <vprintf.constprop.0+0xf0>
  write(fd, &c, 1);
    16b9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    16bc:	83 ec 04             	sub    $0x4,%esp
    16bf:	88 55 e4             	mov    %dl,-0x1c(%ebp)
    16c2:	6a 01                	push   $0x1
    16c4:	50                   	push   %eax
    16c5:	6a 01                	push   $0x1
    16c7:	e8 9e fe ff ff       	call   156a <write>
    16cc:	83 c4 10             	add    $0x10,%esp
    16cf:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
    16d2:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    16d6:	84 d2                	test   %dl,%dl
    16d8:	0f 84 95 00 00 00    	je     1773 <vprintf.constprop.0+0xe3>
    if(state == 0){
    16de:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    16e0:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    16e3:	74 cb                	je     16b0 <vprintf.constprop.0+0x20>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    16e5:	83 ff 25             	cmp    $0x25,%edi
    16e8:	75 e5                	jne    16cf <vprintf.constprop.0+0x3f>
      if(c == 'd'){
    16ea:	83 f8 64             	cmp    $0x64,%eax
        printint(fd, va_arg(ap, int), 10, 1);
    16ed:	8d 7e 04             	lea    0x4(%esi),%edi
    16f0:	b9 01 00 00 00       	mov    $0x1,%ecx
      if(c == 'd'){
    16f5:	0f 84 9a 00 00 00    	je     1795 <vprintf.constprop.0+0x105>
      } else if(c == 'l') {
    16fb:	83 f8 6c             	cmp    $0x6c,%eax
    16fe:	0f 84 8c 00 00 00    	je     1790 <vprintf.constprop.0+0x100>
        printint(fd, va_arg(ap, uint), 10, 0);
      } else if(c == 'x') {
    1704:	83 f8 78             	cmp    $0x78,%eax
    1707:	0f 84 a3 00 00 00    	je     17b0 <vprintf.constprop.0+0x120>
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    170d:	83 f8 70             	cmp    $0x70,%eax
    1710:	0f 84 ca 00 00 00    	je     17e0 <vprintf.constprop.0+0x150>
        printptr(fd, va_arg(ap, uint));
      } else if(c == 's'){
    1716:	83 f8 73             	cmp    $0x73,%eax
    1719:	0f 84 39 01 00 00    	je     1858 <vprintf.constprop.0+0x1c8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    171f:	83 f8 63             	cmp    $0x63,%eax
    1722:	0f 84 68 01 00 00    	je     1890 <vprintf.constprop.0+0x200>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    1728:	83 f8 25             	cmp    $0x25,%eax
    172b:	0f 84 9f 00 00 00    	je     17d0 <vprintf.constprop.0+0x140>
  write(fd, &c, 1);
    1731:	8d 45 df             	lea    -0x21(%ebp),%eax
    1734:	83 ec 04             	sub    $0x4,%esp
    1737:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    173a:	6a 01                	push   $0x1
    173c:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
    1740:	50                   	push   %eax
    1741:	6a 01                	push   $0x1
    1743:	e8 22 fe ff ff       	call   156a <write>
    1748:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    174c:	83 c4 0c             	add    $0xc,%esp
    174f:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1752:	6a 01                	push   $0x1
    1754:	88 55 e0             	mov    %dl,-0x20(%ebp)
    1757:	50                   	push   %eax
    1758:	6a 01                	push   $0x1
    175a:	83 c3 01             	add    $0x1,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    175d:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    175f:	e8 06 fe ff ff       	call   156a <write>
  for(i = 0; fmt[i]; i++){
    1764:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
  write(fd, &c, 1);
    1768:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    176b:	84 d2                	test   %dl,%dl
    176d:	0f 85 6b ff ff ff    	jne    16de <vprintf.constprop.0+0x4e>
    }
  }
}
    1773:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1776:	5b                   	pop    %ebx
    1777:	5e                   	pop    %esi
    1778:	5f                   	pop    %edi
    1779:	5d                   	pop    %ebp
    177a:	c3                   	ret    
    177b:	90                   	nop
    177c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        state = '%';
    1780:	bf 25 00 00 00       	mov    $0x25,%edi
    1785:	e9 45 ff ff ff       	jmp    16cf <vprintf.constprop.0+0x3f>
    178a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, uint), 10, 0);
    1790:	8d 7e 04             	lea    0x4(%esi),%edi
    1793:	31 c9                	xor    %ecx,%ecx
    1795:	8b 06                	mov    (%esi),%eax
    1797:	ba 0a 00 00 00       	mov    $0xa,%edx
    179c:	89 fe                	mov    %edi,%esi
      state = 0;
    179e:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, uint), 10, 0);
    17a0:	e8 5b fe ff ff       	call   1600 <printint.constprop.1>
    17a5:	e9 25 ff ff ff       	jmp    16cf <vprintf.constprop.0+0x3f>
    17aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, int), 16, 0);
    17b0:	8b 06                	mov    (%esi),%eax
    17b2:	8d 7e 04             	lea    0x4(%esi),%edi
    17b5:	31 c9                	xor    %ecx,%ecx
    17b7:	ba 10 00 00 00       	mov    $0x10,%edx
    17bc:	89 fe                	mov    %edi,%esi
      state = 0;
    17be:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, int), 16, 0);
    17c0:	e8 3b fe ff ff       	call   1600 <printint.constprop.1>
    17c5:	e9 05 ff ff ff       	jmp    16cf <vprintf.constprop.0+0x3f>
    17ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    17d0:	83 ec 04             	sub    $0x4,%esp
    17d3:	88 55 e1             	mov    %dl,-0x1f(%ebp)
    17d6:	8d 45 e1             	lea    -0x1f(%ebp),%eax
    17d9:	6a 01                	push   $0x1
    17db:	e9 77 ff ff ff       	jmp    1757 <vprintf.constprop.0+0xc7>
        printptr(fd, va_arg(ap, uint));
    17e0:	8d 46 04             	lea    0x4(%esi),%eax
  write(fd, &c, 1);
    17e3:	83 ec 04             	sub    $0x4,%esp
        printptr(fd, va_arg(ap, uint));
    17e6:	8b 3e                	mov    (%esi),%edi
  write(fd, &c, 1);
    17e8:	6a 01                	push   $0x1
    17ea:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
    17ee:	be 08 00 00 00       	mov    $0x8,%esi
        printptr(fd, va_arg(ap, uint));
    17f3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
    17f6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    17f9:	50                   	push   %eax
    17fa:	6a 01                	push   $0x1
    17fc:	e8 69 fd ff ff       	call   156a <write>
    1801:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1804:	83 c4 0c             	add    $0xc,%esp
    1807:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
    180b:	6a 01                	push   $0x1
    180d:	50                   	push   %eax
    180e:	6a 01                	push   $0x1
    1810:	e8 55 fd ff ff       	call   156a <write>
    1815:	83 c4 10             	add    $0x10,%esp
    1818:	90                   	nop
    1819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1820:	89 f8                	mov    %edi,%eax
  write(fd, &c, 1);
    1822:	83 ec 04             	sub    $0x4,%esp
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1825:	c1 e7 04             	shl    $0x4,%edi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1828:	c1 e8 1c             	shr    $0x1c,%eax
  write(fd, &c, 1);
    182b:	6a 01                	push   $0x1
    182d:	0f b6 80 9c 1e 00 00 	movzbl 0x1e9c(%eax),%eax
    1834:	88 45 e5             	mov    %al,-0x1b(%ebp)
    1837:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    183a:	50                   	push   %eax
    183b:	6a 01                	push   $0x1
    183d:	e8 28 fd ff ff       	call   156a <write>
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1842:	83 c4 10             	add    $0x10,%esp
    1845:	83 ee 01             	sub    $0x1,%esi
    1848:	75 d6                	jne    1820 <vprintf.constprop.0+0x190>
        s = va_arg(ap, char*);
    184a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
    184d:	31 ff                	xor    %edi,%edi
    184f:	e9 7b fe ff ff       	jmp    16cf <vprintf.constprop.0+0x3f>
    1854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = va_arg(ap, char*);
    1858:	8b 3e                	mov    (%esi),%edi
    185a:	8d 46 04             	lea    0x4(%esi),%eax
    185d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    1860:	85 ff                	test   %edi,%edi
    1862:	74 50                	je     18b4 <vprintf.constprop.0+0x224>
        while(*s != 0){
    1864:	0f b6 07             	movzbl (%edi),%eax
    1867:	84 c0                	test   %al,%al
    1869:	74 df                	je     184a <vprintf.constprop.0+0x1ba>
    186b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
    186e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
    1870:	83 ec 04             	sub    $0x4,%esp
          s++;
    1873:	83 c7 01             	add    $0x1,%edi
    1876:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1879:	6a 01                	push   $0x1
    187b:	56                   	push   %esi
    187c:	6a 01                	push   $0x1
    187e:	e8 e7 fc ff ff       	call   156a <write>
        while(*s != 0){
    1883:	0f b6 07             	movzbl (%edi),%eax
    1886:	83 c4 10             	add    $0x10,%esp
    1889:	84 c0                	test   %al,%al
    188b:	75 e3                	jne    1870 <vprintf.constprop.0+0x1e0>
    188d:	eb bb                	jmp    184a <vprintf.constprop.0+0x1ba>
    188f:	90                   	nop
        putc(fd, va_arg(ap, uint));
    1890:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
    1892:	83 ec 04             	sub    $0x4,%esp
        putc(fd, va_arg(ap, uint));
    1895:	8d 7e 04             	lea    0x4(%esi),%edi
  write(fd, &c, 1);
    1898:	6a 01                	push   $0x1
        putc(fd, va_arg(ap, uint));
    189a:	89 fe                	mov    %edi,%esi
      state = 0;
    189c:	31 ff                	xor    %edi,%edi
        putc(fd, va_arg(ap, uint));
    189e:	88 45 e2             	mov    %al,-0x1e(%ebp)
  write(fd, &c, 1);
    18a1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    18a4:	50                   	push   %eax
    18a5:	6a 01                	push   $0x1
    18a7:	e8 be fc ff ff       	call   156a <write>
    18ac:	83 c4 10             	add    $0x10,%esp
    18af:	e9 1b fe ff ff       	jmp    16cf <vprintf.constprop.0+0x3f>
          s = "(null)";
    18b4:	bf 93 1e 00 00       	mov    $0x1e93,%edi
        while(*s != 0){
    18b9:	b8 28 00 00 00       	mov    $0x28,%eax
    18be:	eb ab                	jmp    186b <vprintf.constprop.0+0x1db>

000018c0 <fprintf>:
// Print to the given fd. Only understands %d,%x, %p, %s, %c.
void
fprintf(int fd, const char *fmt, ...)
{
    18c0:	55                   	push   %ebp
    18c1:	89 e5                	mov    %esp,%ebp
    18c3:	83 ec 08             	sub    $0x8,%esp
 va_list ap;
 va_start(ap, fmt); 
 vprintf(1,fmt,ap);
    18c6:	8b 45 0c             	mov    0xc(%ebp),%eax
    18c9:	8d 55 10             	lea    0x10(%ebp),%edx
    18cc:	e8 bf fd ff ff       	call   1690 <vprintf.constprop.0>
}
    18d1:	c9                   	leave  
    18d2:	c3                   	ret    
    18d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    18d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000018e0 <printf>:
void
printf(const char *fmt, ...)
{
    18e0:	55                   	push   %ebp
    18e1:	89 e5                	mov    %esp,%ebp
    18e3:	83 ec 08             	sub    $0x8,%esp
  va_list ap;
  va_start(ap, fmt); 
  vprintf(1,fmt,ap);
    18e6:	8b 45 08             	mov    0x8(%ebp),%eax
    18e9:	8d 55 0c             	lea    0xc(%ebp),%edx
    18ec:	e8 9f fd ff ff       	call   1690 <vprintf.constprop.0>
}
    18f1:	c9                   	leave  
    18f2:	c3                   	ret    
    18f3:	66 90                	xchg   %ax,%ax
    18f5:	66 90                	xchg   %ax,%ax
    18f7:	66 90                	xchg   %ax,%ax
    18f9:	66 90                	xchg   %ax,%ax
    18fb:	66 90                	xchg   %ax,%ax
    18fd:	66 90                	xchg   %ax,%ax
    18ff:	90                   	nop

00001900 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1900:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1901:	a1 48 28 00 00       	mov    0x2848,%eax
{
    1906:	89 e5                	mov    %esp,%ebp
    1908:	57                   	push   %edi
    1909:	56                   	push   %esi
    190a:	53                   	push   %ebx
    190b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    190e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1918:	39 c8                	cmp    %ecx,%eax
    191a:	8b 10                	mov    (%eax),%edx
    191c:	73 32                	jae    1950 <free+0x50>
    191e:	39 d1                	cmp    %edx,%ecx
    1920:	72 04                	jb     1926 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1922:	39 d0                	cmp    %edx,%eax
    1924:	72 32                	jb     1958 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1926:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1929:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    192c:	39 fa                	cmp    %edi,%edx
    192e:	74 30                	je     1960 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1930:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1933:	8b 50 04             	mov    0x4(%eax),%edx
    1936:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1939:	39 f1                	cmp    %esi,%ecx
    193b:	74 3a                	je     1977 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    193d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    193f:	a3 48 28 00 00       	mov    %eax,0x2848
}
    1944:	5b                   	pop    %ebx
    1945:	5e                   	pop    %esi
    1946:	5f                   	pop    %edi
    1947:	5d                   	pop    %ebp
    1948:	c3                   	ret    
    1949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1950:	39 d0                	cmp    %edx,%eax
    1952:	72 04                	jb     1958 <free+0x58>
    1954:	39 d1                	cmp    %edx,%ecx
    1956:	72 ce                	jb     1926 <free+0x26>
{
    1958:	89 d0                	mov    %edx,%eax
    195a:	eb bc                	jmp    1918 <free+0x18>
    195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1960:	03 72 04             	add    0x4(%edx),%esi
    1963:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1966:	8b 10                	mov    (%eax),%edx
    1968:	8b 12                	mov    (%edx),%edx
    196a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    196d:	8b 50 04             	mov    0x4(%eax),%edx
    1970:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1973:	39 f1                	cmp    %esi,%ecx
    1975:	75 c6                	jne    193d <free+0x3d>
    p->s.size += bp->s.size;
    1977:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    197a:	a3 48 28 00 00       	mov    %eax,0x2848
    p->s.size += bp->s.size;
    197f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1982:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1985:	89 10                	mov    %edx,(%eax)
}
    1987:	5b                   	pop    %ebx
    1988:	5e                   	pop    %esi
    1989:	5f                   	pop    %edi
    198a:	5d                   	pop    %ebp
    198b:	c3                   	ret    
    198c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001990 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1990:	55                   	push   %ebp
    1991:	89 e5                	mov    %esp,%ebp
    1993:	57                   	push   %edi
    1994:	56                   	push   %esi
    1995:	53                   	push   %ebx
    1996:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1999:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    199c:	8b 15 48 28 00 00    	mov    0x2848,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    19a2:	8d 78 07             	lea    0x7(%eax),%edi
    19a5:	c1 ef 03             	shr    $0x3,%edi
    19a8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    19ab:	85 d2                	test   %edx,%edx
    19ad:	0f 84 9d 00 00 00    	je     1a50 <malloc+0xc0>
    19b3:	8b 02                	mov    (%edx),%eax
    19b5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    19b8:	39 cf                	cmp    %ecx,%edi
    19ba:	76 6c                	jbe    1a28 <malloc+0x98>
    19bc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    19c2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    19c7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    19ca:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    19d1:	eb 0e                	jmp    19e1 <malloc+0x51>
    19d3:	90                   	nop
    19d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    19d8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    19da:	8b 48 04             	mov    0x4(%eax),%ecx
    19dd:	39 f9                	cmp    %edi,%ecx
    19df:	73 47                	jae    1a28 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    19e1:	39 05 48 28 00 00    	cmp    %eax,0x2848
    19e7:	89 c2                	mov    %eax,%edx
    19e9:	75 ed                	jne    19d8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    19eb:	83 ec 0c             	sub    $0xc,%esp
    19ee:	56                   	push   %esi
    19ef:	e8 de fb ff ff       	call   15d2 <sbrk>
  if(p == (char*)-1)
    19f4:	83 c4 10             	add    $0x10,%esp
    19f7:	83 f8 ff             	cmp    $0xffffffff,%eax
    19fa:	74 1c                	je     1a18 <malloc+0x88>
  hp->s.size = nu;
    19fc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    19ff:	83 ec 0c             	sub    $0xc,%esp
    1a02:	83 c0 08             	add    $0x8,%eax
    1a05:	50                   	push   %eax
    1a06:	e8 f5 fe ff ff       	call   1900 <free>
  return freep;
    1a0b:	8b 15 48 28 00 00    	mov    0x2848,%edx
      if((p = morecore(nunits)) == 0)
    1a11:	83 c4 10             	add    $0x10,%esp
    1a14:	85 d2                	test   %edx,%edx
    1a16:	75 c0                	jne    19d8 <malloc+0x48>
        return 0;
  }
}
    1a18:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1a1b:	31 c0                	xor    %eax,%eax
}
    1a1d:	5b                   	pop    %ebx
    1a1e:	5e                   	pop    %esi
    1a1f:	5f                   	pop    %edi
    1a20:	5d                   	pop    %ebp
    1a21:	c3                   	ret    
    1a22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1a28:	39 cf                	cmp    %ecx,%edi
    1a2a:	74 54                	je     1a80 <malloc+0xf0>
        p->s.size -= nunits;
    1a2c:	29 f9                	sub    %edi,%ecx
    1a2e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1a31:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1a34:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1a37:	89 15 48 28 00 00    	mov    %edx,0x2848
}
    1a3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1a40:	83 c0 08             	add    $0x8,%eax
}
    1a43:	5b                   	pop    %ebx
    1a44:	5e                   	pop    %esi
    1a45:	5f                   	pop    %edi
    1a46:	5d                   	pop    %ebp
    1a47:	c3                   	ret    
    1a48:	90                   	nop
    1a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1a50:	c7 05 48 28 00 00 4c 	movl   $0x284c,0x2848
    1a57:	28 00 00 
    1a5a:	c7 05 4c 28 00 00 4c 	movl   $0x284c,0x284c
    1a61:	28 00 00 
    base.s.size = 0;
    1a64:	b8 4c 28 00 00       	mov    $0x284c,%eax
    1a69:	c7 05 50 28 00 00 00 	movl   $0x0,0x2850
    1a70:	00 00 00 
    1a73:	e9 44 ff ff ff       	jmp    19bc <malloc+0x2c>
    1a78:	90                   	nop
    1a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1a80:	8b 08                	mov    (%eax),%ecx
    1a82:	89 0a                	mov    %ecx,(%edx)
    1a84:	eb b1                	jmp    1a37 <malloc+0xa7>
