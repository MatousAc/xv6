
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
      1c:	0f 8e 52 02 00 00    	jle    274 <main+0x274>
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
      46:	e8 75 06 00 00       	call   6c0 <MakeLinkedList>

  // opening file
  file.fd = open(file.filename, O_RDONLY);
      4b:	56                   	push   %esi
      4c:	56                   	push   %esi
      4d:	6a 00                	push   $0x0
      4f:	ff 75 d0             	pushl  -0x30(%ebp)
  file.lines = MakeLinkedList();
      52:	89 45 dc             	mov    %eax,-0x24(%ebp)
  file.fd = open(file.filename, O_RDONLY);
      55:	e8 d0 14 00 00       	call   152a <open>
  if (file.fd == -1) {
      5a:	83 c4 10             	add    $0x10,%esp
  file.fd = open(file.filename, O_RDONLY);
      5d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  if (file.fd == -1) {
      60:	83 c0 01             	add    $0x1,%eax
      63:	0f 84 1e 02 00 00    	je     287 <main+0x287>
    fprintf(2, "file could not be opened\n",  file.filename);
  } else {
    // populate Linked List
    gatherLinesSized(&file, terminal);
      69:	b8 37 00 00 00       	mov    $0x37,%eax
      6e:	ba 19 00 00 00       	mov    $0x19,%edx
      73:	51                   	push   %ecx
      74:	52                   	push   %edx
      75:	50                   	push   %eax
      76:	8d 45 d0             	lea    -0x30(%ebp),%eax
      79:	50                   	push   %eax
      7a:	89 45 b4             	mov    %eax,-0x4c(%ebp)
      7d:	e8 9e 0b 00 00       	call   c20 <gatherLinesSized>
      82:	83 c4 10             	add    $0x10,%esp
  }
  close(file.fd);
      85:	83 ec 0c             	sub    $0xc,%esp
      88:	ff 75 d4             	pushl  -0x2c(%ebp)
      8b:	e8 82 14 00 00       	call   1512 <close>
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
      b8:	e8 03 0f 00 00       	call   fc0 <showPage>
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
      d5:	e8 28 14 00 00       	call   1502 <steal>
  return *numCollector;
}

static char getCmd() {
  char cmd = consGetChar();
  if (cmd == '\0') exit();
      da:	83 c4 10             	add    $0x10,%esp
      dd:	84 c0                	test   %al,%al
      df:	89 c3                	mov    %eax,%ebx
      e1:	0f 84 93 00 00 00    	je     17a <main+0x17a>
  printf("\r");
      e7:	83 ec 0c             	sub    $0xc,%esp
      ea:	68 b1 1d 00 00       	push   $0x1db1
      ef:	e8 8c 17 00 00       	call   1880 <printf>
    if (cmd == '.') cmd = previous;
      f4:	83 c4 10             	add    $0x10,%esp
      f7:	80 fb 2e             	cmp    $0x2e,%bl
      fa:	0f 44 df             	cmove  %edi,%ebx
		switch (cmd) {
      fd:	8d 43 e0             	lea    -0x20(%ebx),%eax
     100:	3c 53                	cmp    $0x53,%al
     102:	77 3b                	ja     13f <main+0x13f>
     104:	0f b6 c0             	movzbl %al,%eax
     107:	ff 24 85 40 1c 00 00 	jmp    *0x1c40(,%eax,4)
    fprintf(2, "this version of more only supports one file at a time.\n");
     10e:	57                   	push   %edi
     10f:	57                   	push   %edi
     110:	68 04 1c 00 00       	push   $0x1c04
     115:	6a 02                	push   $0x2
     117:	e8 44 17 00 00       	call   1860 <fprintf>
    exit();
     11c:	e8 c1 13 00 00       	call   14e2 <exit>
			help(terminal);
     121:	c7 45 c0 37 00 00 00 	movl   $0x37,-0x40(%ebp)
     128:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
     12f:	50                   	push   %eax
     130:	50                   	push   %eax
     131:	ff 75 c4             	pushl  -0x3c(%ebp)
     134:	ff 75 c0             	pushl  -0x40(%ebp)
     137:	e8 b4 0d 00 00       	call   ef0 <help>
			break;
     13c:	83 c4 10             	add    $0x10,%esp
  return os;
}

// standard str helps
int isDigit(char c) {
  if (c >= '0' && c <= '9') return 1;
     13f:	8d 43 d0             	lea    -0x30(%ebx),%eax
     142:	3c 09                	cmp    $0x9,%al
     144:	0f 87 1e 01 00 00    	ja     268 <main+0x268>
  *numCollector *= 10;
     14a:	8b 45 bc             	mov    -0x44(%ebp),%eax
     14d:	8d 14 80             	lea    (%eax,%eax,4),%edx
		switch (cmd) {
     150:	0f be c3             	movsbl %bl,%eax
  *numCollector += ctoi(c);
     153:	8d 44 50 d0          	lea    -0x30(%eax,%edx,2),%eax
     157:	89 45 bc             	mov    %eax,-0x44(%ebp)
    numArg = (numCollector > 0) ? numCollector : 1;
     15a:	8b 45 bc             	mov    -0x44(%ebp),%eax
     15d:	ba 01 00 00 00       	mov    $0x1,%edx
     162:	85 c0                	test   %eax,%eax
     164:	0f 4f d0             	cmovg  %eax,%edx
  while (cmd != 'q' && cmd != 'Q') {
     167:	89 d8                	mov    %ebx,%eax
     169:	83 e0 df             	and    $0xffffffdf,%eax
    numArg = (numCollector > 0) ? numCollector : 1;
     16c:	89 55 b8             	mov    %edx,-0x48(%ebp)
  while (cmd != 'q' && cmd != 'Q') {
     16f:	3c 51                	cmp    $0x51,%al
     171:	74 07                	je     17a <main+0x17a>
    numArg = (numCollector > 0) ? numCollector : 1;
     173:	89 df                	mov    %ebx,%edi
     175:	e9 56 ff ff ff       	jmp    d0 <main+0xd0>
  if (cmd == '\0') exit();
     17a:	e8 63 13 00 00       	call   14e2 <exit>
			skip(&file, terminal, numArg);
     17f:	ff 75 b8             	pushl  -0x48(%ebp)
     182:	c7 45 c0 37 00 00 00 	movl   $0x37,-0x40(%ebp)
     189:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
     190:	ff 75 c4             	pushl  -0x3c(%ebp)
     193:	ff 75 c0             	pushl  -0x40(%ebp)
     196:	ff 75 b4             	pushl  -0x4c(%ebp)
     199:	e8 22 0f 00 00       	call   10c0 <skip>
			break;
     19e:	83 c4 10             	add    $0x10,%esp
     1a1:	eb 9c                	jmp    13f <main+0x13f>
			line(file, terminal);
     1a3:	c7 45 c0 37 00 00 00 	movl   $0x37,-0x40(%ebp)
     1aa:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
     1b1:	b9 06 00 00 00       	mov    $0x6,%ecx
     1b6:	ff 75 c4             	pushl  -0x3c(%ebp)
     1b9:	ff 75 c0             	pushl  -0x40(%ebp)
     1bc:	8b 75 b4             	mov    -0x4c(%ebp),%esi
     1bf:	83 ec 18             	sub    $0x18,%esp
     1c2:	89 e7                	mov    %esp,%edi
     1c4:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
     1c6:	e8 d5 0c 00 00       	call   ea0 <line>
			break;
     1cb:	83 c4 20             	add    $0x20,%esp
    return 0; // not a successful addition
     1ce:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    numArg = (numCollector > 0) ? numCollector : 1;
     1d5:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
     1dc:	89 df                	mov    %ebx,%edi
     1de:	e9 ed fe ff ff       	jmp    d0 <main+0xd0>
			forward(&file, terminal);
     1e3:	c7 45 c0 37 00 00 00 	movl   $0x37,-0x40(%ebp)
     1ea:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
     1f1:	52                   	push   %edx
     1f2:	ff 75 c4             	pushl  -0x3c(%ebp)
     1f5:	ff 75 c0             	pushl  -0x40(%ebp)
     1f8:	ff 75 b4             	pushl  -0x4c(%ebp)
     1fb:	e8 70 0e 00 00       	call   1070 <forward>
			break;
     200:	83 c4 10             	add    $0x10,%esp
     203:	eb c9                	jmp    1ce <main+0x1ce>
  showLines(*file, terminal, numLines);
     205:	83 ec 0c             	sub    $0xc,%esp
     208:	c7 45 a8 37 00 00 00 	movl   $0x37,-0x58(%ebp)
     20f:	ff 75 b8             	pushl  -0x48(%ebp)
     212:	c7 45 ac 19 00 00 00 	movl   $0x19,-0x54(%ebp)
     219:	ff 75 ac             	pushl  -0x54(%ebp)
     21c:	b9 06 00 00 00       	mov    $0x6,%ecx
     221:	ff 75 a8             	pushl  -0x58(%ebp)
     224:	8b 75 b4             	mov    -0x4c(%ebp),%esi
     227:	83 ec 18             	sub    $0x18,%esp
     22a:	89 e7                	mov    %esp,%edi
     22c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
     22e:	e8 5d 0f 00 00       	call   1190 <showLines>
  file->curLine += numLines;
     233:	8b 45 b8             	mov    -0x48(%ebp),%eax
     236:	83 c4 30             	add    $0x30,%esp
     239:	01 45 d8             	add    %eax,-0x28(%ebp)
     23c:	e9 fe fe ff ff       	jmp    13f <main+0x13f>
			back(&file, terminal, numArg);
     241:	ff 75 b8             	pushl  -0x48(%ebp)
     244:	c7 45 c0 37 00 00 00 	movl   $0x37,-0x40(%ebp)
     24b:	c7 45 c4 19 00 00 00 	movl   $0x19,-0x3c(%ebp)
     252:	ff 75 c4             	pushl  -0x3c(%ebp)
     255:	ff 75 c0             	pushl  -0x40(%ebp)
     258:	ff 75 b4             	pushl  -0x4c(%ebp)
     25b:	e8 d0 0e 00 00       	call   1130 <back>
			break;
     260:	83 c4 10             	add    $0x10,%esp
     263:	e9 d7 fe ff ff       	jmp    13f <main+0x13f>
    return 0; // not a successful addition
     268:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
     26f:	e9 e6 fe ff ff       	jmp    15a <main+0x15a>
    fprintf(2, "more: bad usage\nTry 'more --help' for more information.\n");
     274:	50                   	push   %eax
     275:	50                   	push   %eax
     276:	68 c8 1b 00 00       	push   $0x1bc8
     27b:	6a 02                	push   $0x2
     27d:	e8 de 15 00 00       	call   1860 <fprintf>
    exit();
     282:	e8 5b 12 00 00       	call   14e2 <exit>
    fprintf(2, "file could not be opened\n",  file.filename);
     287:	53                   	push   %ebx
     288:	ff 75 d0             	pushl  -0x30(%ebp)
     28b:	68 fd 1d 00 00       	push   $0x1dfd
     290:	6a 02                	push   $0x2
     292:	e8 c9 15 00 00       	call   1860 <fprintf>
     297:	8d 45 d0             	lea    -0x30(%ebp),%eax
     29a:	83 c4 10             	add    $0x10,%esp
     29d:	89 45 b4             	mov    %eax,-0x4c(%ebp)
     2a0:	e9 e0 fd ff ff       	jmp    85 <main+0x85>
     2a5:	66 90                	xchg   %ax,%ax
     2a7:	66 90                	xchg   %ax,%ax
     2a9:	66 90                	xchg   %ax,%ax
     2ab:	66 90                	xchg   %ax,%ax
     2ad:	66 90                	xchg   %ax,%ax
     2af:	90                   	nop

000002b0 <safestrcpy.part.0>:
  while(--n > 0 && (*s++ = *t++) != 0)
     2b0:	83 e9 01             	sub    $0x1,%ecx
     2b3:	85 c9                	test   %ecx,%ecx
     2b5:	7e 29                	jle    2e0 <safestrcpy.part.0+0x30>
safestrcpy(char *s, const char *t, int n) 
     2b7:	55                   	push   %ebp
     2b8:	89 e5                	mov    %esp,%ebp
     2ba:	53                   	push   %ebx
     2bb:	eb 0a                	jmp    2c7 <safestrcpy.part.0+0x17>
     2bd:	8d 76 00             	lea    0x0(%esi),%esi
  while(--n > 0 && (*s++ = *t++) != 0)
     2c0:	83 e9 01             	sub    $0x1,%ecx
     2c3:	85 c9                	test   %ecx,%ecx
     2c5:	7e 11                	jle    2d8 <safestrcpy.part.0+0x28>
     2c7:	83 c2 01             	add    $0x1,%edx
     2ca:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
     2ce:	83 c0 01             	add    $0x1,%eax
     2d1:	84 db                	test   %bl,%bl
     2d3:	88 58 ff             	mov    %bl,-0x1(%eax)
     2d6:	75 e8                	jne    2c0 <safestrcpy.part.0+0x10>
}
     2d8:	5b                   	pop    %ebx
  *s = 0;
     2d9:	c6 00 00             	movb   $0x0,(%eax)
}
     2dc:	5d                   	pop    %ebp
     2dd:	c3                   	ret    
     2de:	66 90                	xchg   %ax,%ax
  *s = 0;
     2e0:	c6 00 00             	movb   $0x0,(%eax)
     2e3:	c3                   	ret    
     2e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     2ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002f0 <itoa.part.1>:
/**
 * C++ version 0.4 char* style "itoa":
 * Written by Lukás Chmela
 * Released under GPLv3.
 */
char* itoa(int value, char* result, int base) {
     2f0:	55                   	push   %ebp
     2f1:	89 e5                	mov    %esp,%ebp
     2f3:	57                   	push   %edi
     2f4:	56                   	push   %esi
     2f5:	53                   	push   %ebx
     2f6:	89 c6                	mov    %eax,%esi
     2f8:	89 c8                	mov    %ecx,%eax
     2fa:	89 c3                	mov    %eax,%ebx
     2fc:	89 d1                	mov    %edx,%ecx
     2fe:	83 ec 04             	sub    $0x4,%esp
     301:	89 55 f0             	mov    %edx,-0x10(%ebp)
     304:	eb 0e                	jmp    314 <itoa.part.1+0x24>
     306:	8d 76 00             	lea    0x0(%esi),%esi
     309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

    do {
        tmp_value = value;
        value /= base;
        *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" [35 + (tmp_value - value * base)];
    } while ( value );
     310:	89 f9                	mov    %edi,%ecx
     312:	89 c6                	mov    %eax,%esi
     314:	89 f0                	mov    %esi,%eax
        *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" [35 + (tmp_value - value * base)];
     316:	8d 79 01             	lea    0x1(%ecx),%edi
     319:	99                   	cltd   
     31a:	f7 fb                	idiv   %ebx
     31c:	0f b6 92 4b 1a 00 00 	movzbl 0x1a4b(%edx),%edx
    } while ( value );
     323:	85 c0                	test   %eax,%eax
        *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" [35 + (tmp_value - value * base)];
     325:	88 57 ff             	mov    %dl,-0x1(%edi)
    } while ( value );
     328:	75 e6                	jne    310 <itoa.part.1+0x20>

    // Apply negative sign
    if (tmp_value < 0) *ptr++ = '-';
     32a:	85 f6                	test   %esi,%esi
     32c:	8b 5d f0             	mov    -0x10(%ebp),%ebx
     32f:	79 07                	jns    338 <itoa.part.1+0x48>
     331:	8d 79 02             	lea    0x2(%ecx),%edi
     334:	c6 41 01 2d          	movb   $0x2d,0x1(%ecx)
    *ptr-- = '\0';
     338:	8d 47 ff             	lea    -0x1(%edi),%eax
     33b:	c6 07 00             	movb   $0x0,(%edi)
    while(ptr1 < ptr) {
     33e:	39 d8                	cmp    %ebx,%eax
     340:	76 1c                	jbe    35e <itoa.part.1+0x6e>
     342:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tmp_char = *ptr;
     348:	0f b6 10             	movzbl (%eax),%edx
        *ptr--= *ptr1;
     34b:	0f b6 0b             	movzbl (%ebx),%ecx
     34e:	83 e8 01             	sub    $0x1,%eax
        *ptr1++ = tmp_char;
     351:	83 c3 01             	add    $0x1,%ebx
    while(ptr1 < ptr) {
     354:	39 d8                	cmp    %ebx,%eax
        *ptr--= *ptr1;
     356:	88 48 01             	mov    %cl,0x1(%eax)
        *ptr1++ = tmp_char;
     359:	88 53 ff             	mov    %dl,-0x1(%ebx)
    while(ptr1 < ptr) {
     35c:	77 ea                	ja     348 <itoa.part.1+0x58>
    }
    return result;
}
     35e:	83 c4 04             	add    $0x4,%esp
     361:	5b                   	pop    %ebx
     362:	5e                   	pop    %esi
     363:	5f                   	pop    %edi
     364:	5d                   	pop    %ebp
     365:	c3                   	ret    
     366:	8d 76 00             	lea    0x0(%esi),%esi
     369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000370 <getLine>:
int getLine(int fileptr, char line[]) {
     370:	55                   	push   %ebp
     371:	89 e5                	mov    %esp,%ebp
     373:	57                   	push   %edi
     374:	56                   	push   %esi
     375:	53                   	push   %ebx
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     376:	31 ff                	xor    %edi,%edi
     378:	8d 75 e7             	lea    -0x19(%ebp),%esi
int getLine(int fileptr, char line[]) {
     37b:	83 ec 28             	sub    $0x28,%esp
     37e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int len = strlen(line);
     381:	53                   	push   %ebx
     382:	e8 89 0f 00 00       	call   1310 <strlen>
  memset(line, 0, len);
     387:	83 c4 0c             	add    $0xc,%esp
     38a:	50                   	push   %eax
     38b:	6a 00                	push   $0x0
     38d:	53                   	push   %ebx
     38e:	e8 ad 0f 00 00       	call   1340 <memset>
     393:	83 c4 10             	add    $0x10,%esp
     396:	eb 1e                	jmp    3b6 <getLine+0x46>
     398:	90                   	nop
     399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (*c == '\n') break;
     3a0:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     3a4:	3c 0a                	cmp    $0xa,%al
     3a6:	74 38                	je     3e0 <getLine+0x70>
    line[i] = *c;
     3a8:	88 04 3b             	mov    %al,(%ebx,%edi,1)
  for (i = 0; i < MAXLINESIZE - 1; i++) {
     3ab:	83 c7 01             	add    $0x1,%edi
     3ae:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
     3b4:	74 42                	je     3f8 <getLine+0x88>
    if (read(fileptr, c, 1) == 0) return strlen(line);
     3b6:	83 ec 04             	sub    $0x4,%esp
     3b9:	6a 01                	push   $0x1
     3bb:	56                   	push   %esi
     3bc:	ff 75 08             	pushl  0x8(%ebp)
     3bf:	e8 36 11 00 00       	call   14fa <read>
     3c4:	83 c4 10             	add    $0x10,%esp
     3c7:	85 c0                	test   %eax,%eax
     3c9:	75 d5                	jne    3a0 <getLine+0x30>
     3cb:	83 ec 0c             	sub    $0xc,%esp
     3ce:	53                   	push   %ebx
     3cf:	e8 3c 0f 00 00       	call   1310 <strlen>
     3d4:	83 c4 10             	add    $0x10,%esp
}
     3d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     3da:	5b                   	pop    %ebx
     3db:	5e                   	pop    %esi
     3dc:	5f                   	pop    %edi
     3dd:	5d                   	pop    %ebp
     3de:	c3                   	ret    
     3df:	90                   	nop
     3e0:	8d 57 01             	lea    0x1(%edi),%edx
  line[i + 1] = '\0';
     3e3:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
     3e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
     3ea:	b8 01 00 00 00       	mov    $0x1,%eax
}
     3ef:	5b                   	pop    %ebx
     3f0:	5e                   	pop    %esi
     3f1:	5f                   	pop    %edi
     3f2:	5d                   	pop    %ebp
     3f3:	c3                   	ret    
     3f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     3f8:	ba e8 03 00 00       	mov    $0x3e8,%edx
     3fd:	eb e4                	jmp    3e3 <getLine+0x73>
     3ff:	90                   	nop

00000400 <consGetChar>:
char consGetChar() {return (char) steal(0);}
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	83 ec 14             	sub    $0x14,%esp
     406:	6a 00                	push   $0x0
     408:	e8 f5 10 00 00       	call   1502 <steal>
     40d:	c9                   	leave  
     40e:	c3                   	ret    
     40f:	90                   	nop

00000410 <find>:
int find(char* str, char c) {
     410:	55                   	push   %ebp
     411:	89 e5                	mov    %esp,%ebp
     413:	57                   	push   %edi
     414:	56                   	push   %esi
     415:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     416:	31 db                	xor    %ebx,%ebx
int find(char* str, char c) {
     418:	83 ec 0c             	sub    $0xc,%esp
     41b:	8b 75 08             	mov    0x8(%ebp),%esi
     41e:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
  for (int i = 0; i < strlen(str); i++)
     422:	eb 0e                	jmp    432 <find+0x22>
     424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     428:	89 f8                	mov    %edi,%eax
     42a:	38 04 1e             	cmp    %al,(%esi,%ebx,1)
     42d:	74 18                	je     447 <find+0x37>
  for (int i = 0; i < strlen(str); i++)
     42f:	83 c3 01             	add    $0x1,%ebx
     432:	83 ec 0c             	sub    $0xc,%esp
     435:	56                   	push   %esi
     436:	e8 d5 0e 00 00       	call   1310 <strlen>
     43b:	83 c4 10             	add    $0x10,%esp
     43e:	39 d8                	cmp    %ebx,%eax
     440:	77 e6                	ja     428 <find+0x18>
  return -1;
     442:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
     447:	8d 65 f4             	lea    -0xc(%ebp),%esp
     44a:	89 d8                	mov    %ebx,%eax
     44c:	5b                   	pop    %ebx
     44d:	5e                   	pop    %esi
     44e:	5f                   	pop    %edi
     44f:	5d                   	pop    %ebp
     450:	c3                   	ret    
     451:	eb 0d                	jmp    460 <substr>
     453:	90                   	nop
     454:	90                   	nop
     455:	90                   	nop
     456:	90                   	nop
     457:	90                   	nop
     458:	90                   	nop
     459:	90                   	nop
     45a:	90                   	nop
     45b:	90                   	nop
     45c:	90                   	nop
     45d:	90                   	nop
     45e:	90                   	nop
     45f:	90                   	nop

00000460 <substr>:
void substr(char* dest, char* str, int start, int end) {
     460:	55                   	push   %ebp
     461:	89 e5                	mov    %esp,%ebp
     463:	57                   	push   %edi
     464:	56                   	push   %esi
     465:	53                   	push   %ebx
     466:	83 ec 18             	sub    $0x18,%esp
     469:	8b 7d 14             	mov    0x14(%ebp),%edi
  int len = strlen(str);
     46c:	ff 75 0c             	pushl  0xc(%ebp)
void substr(char* dest, char* str, int start, int end) {
     46f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     472:	8b 75 08             	mov    0x8(%ebp),%esi
  int len = strlen(str);
     475:	e8 96 0e 00 00       	call   1310 <strlen>
     47a:	83 c4 10             	add    $0x10,%esp
     47d:	39 f8                	cmp    %edi,%eax
     47f:	0f 4e f8             	cmovle %eax,%edi
  while (i < end)
     482:	39 df                	cmp    %ebx,%edi
     484:	7e 1c                	jle    4a2 <substr+0x42>
     486:	8b 45 0c             	mov    0xc(%ebp),%eax
     489:	29 df                	sub    %ebx,%edi
  int s = 0, i = start;
     48b:	31 d2                	xor    %edx,%edx
     48d:	01 c3                	add    %eax,%ebx
     48f:	90                   	nop
    dest[s++] = str[i++];
     490:	83 c2 01             	add    $0x1,%edx
     493:	0f b6 44 13 ff       	movzbl -0x1(%ebx,%edx,1),%eax
  while (i < end)
     498:	39 fa                	cmp    %edi,%edx
    dest[s++] = str[i++];
     49a:	88 44 16 ff          	mov    %al,-0x1(%esi,%edx,1)
  while (i < end)
     49e:	75 f0                	jne    490 <substr+0x30>
     4a0:	01 d6                	add    %edx,%esi
  dest[s] = '\0';
     4a2:	c6 06 00             	movb   $0x0,(%esi)
}
     4a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
     4a8:	5b                   	pop    %ebx
     4a9:	5e                   	pop    %esi
     4aa:	5f                   	pop    %edi
     4ab:	5d                   	pop    %ebp
     4ac:	c3                   	ret    
     4ad:	8d 76 00             	lea    0x0(%esi),%esi

000004b0 <safestrcpy>:
{
     4b0:	55                   	push   %ebp
     4b1:	89 e5                	mov    %esp,%ebp
     4b3:	53                   	push   %ebx
     4b4:	8b 4d 10             	mov    0x10(%ebp),%ecx
     4b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(n <= 0)
     4ba:	85 c9                	test   %ecx,%ecx
     4bc:	7e 0a                	jle    4c8 <safestrcpy+0x18>
     4be:	8b 55 0c             	mov    0xc(%ebp),%edx
     4c1:	89 d8                	mov    %ebx,%eax
     4c3:	e8 e8 fd ff ff       	call   2b0 <safestrcpy.part.0>
}
     4c8:	89 d8                	mov    %ebx,%eax
     4ca:	5b                   	pop    %ebx
     4cb:	5d                   	pop    %ebp
     4cc:	c3                   	ret    
     4cd:	8d 76 00             	lea    0x0(%esi),%esi

000004d0 <isDigit>:
int isDigit(char c) {
     4d0:	55                   	push   %ebp
     4d1:	89 e5                	mov    %esp,%ebp
  if (c >= '0' && c <= '9') return 1;
     4d3:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
}
     4d7:	5d                   	pop    %ebp
  if (c >= '0' && c <= '9') return 1;
     4d8:	83 e8 30             	sub    $0x30,%eax
     4db:	3c 09                	cmp    $0x9,%al
     4dd:	0f 96 c0             	setbe  %al
     4e0:	0f b6 c0             	movzbl %al,%eax
}
     4e3:	c3                   	ret    
     4e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     4ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000004f0 <ctoi>:
int ctoi(char c) {
     4f0:	55                   	push   %ebp
     4f1:	89 e5                	mov    %esp,%ebp
  return ((int) c) - 48;
     4f3:	0f be 45 08          	movsbl 0x8(%ebp),%eax
}
     4f7:	5d                   	pop    %ebp
  return ((int) c) - 48;
     4f8:	83 e8 30             	sub    $0x30,%eax
}
     4fb:	c3                   	ret    
     4fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000500 <negatoi>:
int negatoi(char* str) {
     500:	55                   	push   %ebp
     501:	89 e5                	mov    %esp,%ebp
     503:	53                   	push   %ebx
     504:	83 ec 04             	sub    $0x4,%esp
     507:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (str[0] == '-') {
     50a:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     50d:	74 11                	je     520 <negatoi+0x20>
}
     50f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     512:	c9                   	leave  
  return atoi(str);
     513:	e9 58 0f 00 00       	jmp    1470 <atoi>
     518:	90                   	nop
     519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    substr(str, str, 1, strlen(str));
     520:	83 ec 0c             	sub    $0xc,%esp
     523:	53                   	push   %ebx
     524:	e8 e7 0d 00 00       	call   1310 <strlen>
     529:	50                   	push   %eax
     52a:	6a 01                	push   $0x1
     52c:	53                   	push   %ebx
     52d:	53                   	push   %ebx
     52e:	e8 2d ff ff ff       	call   460 <substr>
    return 0 - atoi(str);
     533:	83 c4 14             	add    $0x14,%esp
     536:	53                   	push   %ebx
     537:	e8 34 0f 00 00       	call   1470 <atoi>
     53c:	83 c4 10             	add    $0x10,%esp
     53f:	f7 d8                	neg    %eax
}
     541:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     544:	c9                   	leave  
     545:	c3                   	ret    
     546:	8d 76 00             	lea    0x0(%esi),%esi
     549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000550 <itoa>:
char* itoa(int value, char* result, int base) {
     550:	55                   	push   %ebp
     551:	89 e5                	mov    %esp,%ebp
     553:	53                   	push   %ebx
     554:	8b 4d 10             	mov    0x10(%ebp),%ecx
     557:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    if (base < 2 || base > 36) { *result = '\0'; return result; }
     55a:	8d 41 fe             	lea    -0x2(%ecx),%eax
     55d:	83 f8 22             	cmp    $0x22,%eax
     560:	77 16                	ja     578 <itoa+0x28>
     562:	8b 45 08             	mov    0x8(%ebp),%eax
     565:	89 da                	mov    %ebx,%edx
     567:	e8 84 fd ff ff       	call   2f0 <itoa.part.1>
}
     56c:	89 d8                	mov    %ebx,%eax
     56e:	5b                   	pop    %ebx
     56f:	5d                   	pop    %ebp
     570:	c3                   	ret    
     571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (base < 2 || base > 36) { *result = '\0'; return result; }
     578:	c6 03 00             	movb   $0x0,(%ebx)
}
     57b:	89 d8                	mov    %ebx,%eax
     57d:	5b                   	pop    %ebx
     57e:	5d                   	pop    %ebp
     57f:	c3                   	ret    

00000580 <toUpper>:

void toUpper(char* str) {
     580:	55                   	push   %ebp
     581:	89 e5                	mov    %esp,%ebp
     583:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     586:	0f b6 02             	movzbl (%edx),%eax
     589:	84 c0                	test   %al,%al
     58b:	74 1a                	je     5a7 <toUpper+0x27>
     58d:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'z' && c >= 'a')
     590:	8d 48 9f             	lea    -0x61(%eax),%ecx
     593:	80 f9 19             	cmp    $0x19,%cl
     596:	77 05                	ja     59d <toUpper+0x1d>
      str[i] += ('Z' - 'z');
     598:	83 e8 20             	sub    $0x20,%eax
     59b:	88 02                	mov    %al,(%edx)
     59d:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     5a0:	0f b6 02             	movzbl (%edx),%eax
     5a3:	84 c0                	test   %al,%al
     5a5:	75 e9                	jne    590 <toUpper+0x10>
    i++;  
  }
}
     5a7:	5d                   	pop    %ebp
     5a8:	c3                   	ret    
     5a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005b0 <toLower>:

void toLower(char* str) {
     5b0:	55                   	push   %ebp
     5b1:	89 e5                	mov    %esp,%ebp
     5b3:	8b 55 08             	mov    0x8(%ebp),%edx
  int i = 0;
  while (str[i] != '\0') {
     5b6:	0f b6 02             	movzbl (%edx),%eax
     5b9:	84 c0                	test   %al,%al
     5bb:	74 1a                	je     5d7 <toLower+0x27>
     5bd:	8d 76 00             	lea    0x0(%esi),%esi
    char c = str[i];
    if (c <= 'Z' && c >= 'A')
     5c0:	8d 48 bf             	lea    -0x41(%eax),%ecx
     5c3:	80 f9 19             	cmp    $0x19,%cl
     5c6:	77 05                	ja     5cd <toLower+0x1d>
      str[i] -= ('Z' - 'z');
     5c8:	83 c0 20             	add    $0x20,%eax
     5cb:	88 02                	mov    %al,(%edx)
     5cd:	83 c2 01             	add    $0x1,%edx
  while (str[i] != '\0') {
     5d0:	0f b6 02             	movzbl (%edx),%eax
     5d3:	84 c0                	test   %al,%al
     5d5:	75 e9                	jne    5c0 <toLower+0x10>
    i++;  
  }
}
     5d7:	5d                   	pop    %ebp
     5d8:	c3                   	ret    
     5d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005e0 <nullNode>:
#include "LinkedList.h"
// #include "helpers.h"
#define nullptr 0
// prototypes

Node* nullNode(char* data) {
     5e0:	55                   	push   %ebp
     5e1:	89 e5                	mov    %esp,%ebp
     5e3:	83 ec 14             	sub    $0x14,%esp
  struct Node* node = malloc(sizeof(Node));
     5e6:	6a 0c                	push   $0xc
     5e8:	e8 43 13 00 00       	call   1930 <malloc>
  node->prev = nullptr;
  node->data = data;
     5ed:	8b 55 08             	mov    0x8(%ebp),%edx
  node->prev = nullptr;
     5f0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->next = nullptr;
     5f6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  node->data = data;
     5fd:	89 50 04             	mov    %edx,0x4(%eax)
  return node;
}
     600:	c9                   	leave  
     601:	c3                   	ret    
     602:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000610 <nodeAt>:

Node* nodeAt(struct LinkedList* list, int pos) {
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
     613:	53                   	push   %ebx
     614:	8b 45 08             	mov    0x8(%ebp),%eax
     617:	8b 55 0c             	mov    0xc(%ebp),%edx
  // for anything past the end:
  if (pos > list->len)
     61a:	8b 48 08             	mov    0x8(%eax),%ecx
     61d:	39 d1                	cmp    %edx,%ecx
     61f:	7c 1f                	jl     640 <nodeAt+0x30>
    return list->tail->prev;
  // for anything before the beginning:
  if ((pos < 0) && ((0 - pos) > list->len))
     621:	85 d2                	test   %edx,%edx
     623:	78 2b                	js     650 <nodeAt+0x40>
    while (++pos != 0)
      curNode = curNode->prev;
  } // start looking from front
  else {
    int cur = 0;
    curNode = list->head->next;
     625:	8b 00                	mov    (%eax),%eax
     627:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     62a:	74 0e                	je     63a <nodeAt+0x2a>
    int cur = 0;
     62c:	31 c9                	xor    %ecx,%ecx
     62e:	66 90                	xchg   %ax,%ax
      curNode = curNode->next;
      cur++;
     630:	83 c1 01             	add    $0x1,%ecx
      curNode = curNode->next;
     633:	8b 40 08             	mov    0x8(%eax),%eax
    while (cur != pos) {
     636:	39 ca                	cmp    %ecx,%edx
     638:	75 f6                	jne    630 <nodeAt+0x20>
    }
  }
  return curNode;
}
     63a:	5b                   	pop    %ebx
     63b:	5d                   	pop    %ebp
     63c:	c3                   	ret    
     63d:	8d 76 00             	lea    0x0(%esi),%esi
    return list->tail->prev;
     640:	8b 40 04             	mov    0x4(%eax),%eax
}
     643:	5b                   	pop    %ebx
     644:	5d                   	pop    %ebp
    return list->tail->prev;
     645:	8b 00                	mov    (%eax),%eax
}
     647:	c3                   	ret    
     648:	90                   	nop
     649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if ((pos < 0) && ((0 - pos) > list->len))
     650:	89 d3                	mov    %edx,%ebx
     652:	f7 db                	neg    %ebx
     654:	39 d9                	cmp    %ebx,%ecx
     656:	7c 18                	jl     670 <nodeAt+0x60>
    while (++pos != 0)
     658:	83 c2 01             	add    $0x1,%edx
    curNode = list->tail;
     65b:	8b 40 04             	mov    0x4(%eax),%eax
    while (++pos != 0)
     65e:	74 da                	je     63a <nodeAt+0x2a>
     660:	83 c2 01             	add    $0x1,%edx
      curNode = curNode->prev;
     663:	8b 00                	mov    (%eax),%eax
    while (++pos != 0)
     665:	75 f9                	jne    660 <nodeAt+0x50>
}
     667:	5b                   	pop    %ebx
     668:	5d                   	pop    %ebp
     669:	c3                   	ret    
     66a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return list->head->next;
     670:	8b 00                	mov    (%eax),%eax
     672:	8b 40 08             	mov    0x8(%eax),%eax
     675:	eb c3                	jmp    63a <nodeAt+0x2a>
     677:	89 f6                	mov    %esi,%esi
     679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000680 <destroyNode>:

void destroyNode(struct LinkedList* list, struct Node* self) {
     680:	55                   	push   %ebp
     681:	89 e5                	mov    %esp,%ebp
     683:	56                   	push   %esi
     684:	53                   	push   %ebx
     685:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     688:	8b 75 08             	mov    0x8(%ebp),%esi
    self->prev->next = self->next;
    self->next->prev = self->prev;

    free(self->data);
     68b:	83 ec 0c             	sub    $0xc,%esp
    self->prev->next = self->next;
     68e:	8b 03                	mov    (%ebx),%eax
     690:	8b 53 08             	mov    0x8(%ebx),%edx
     693:	89 50 08             	mov    %edx,0x8(%eax)
    self->next->prev = self->prev;
     696:	8b 43 08             	mov    0x8(%ebx),%eax
     699:	8b 13                	mov    (%ebx),%edx
     69b:	89 10                	mov    %edx,(%eax)
    free(self->data);
     69d:	ff 73 04             	pushl  0x4(%ebx)
     6a0:	e8 fb 11 00 00       	call   18a0 <free>
    free(self);
     6a5:	89 1c 24             	mov    %ebx,(%esp)
     6a8:	e8 f3 11 00 00       	call   18a0 <free>
    list->len--;
     6ad:	83 6e 08 01          	subl   $0x1,0x8(%esi)
}
     6b1:	83 c4 10             	add    $0x10,%esp
     6b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     6b7:	5b                   	pop    %ebx
     6b8:	5e                   	pop    %esi
     6b9:	5d                   	pop    %ebp
     6ba:	c3                   	ret    
     6bb:	90                   	nop
     6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006c0 <MakeLinkedList>:

LinkedList* MakeLinkedList() {
     6c0:	55                   	push   %ebp
     6c1:	89 e5                	mov    %esp,%ebp
     6c3:	56                   	push   %esi
     6c4:	53                   	push   %ebx
  struct LinkedList* list = malloc(sizeof(LinkedList));
     6c5:	83 ec 0c             	sub    $0xc,%esp
     6c8:	6a 0c                	push   $0xc
     6ca:	e8 61 12 00 00       	call   1930 <malloc>
  struct Node* node = malloc(sizeof(Node));
     6cf:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  struct LinkedList* list = malloc(sizeof(LinkedList));
     6d6:	89 c6                	mov    %eax,%esi
  struct Node* node = malloc(sizeof(Node));
     6d8:	e8 53 12 00 00       	call   1930 <malloc>
     6dd:	89 c3                	mov    %eax,%ebx
  node->prev = nullptr;
     6df:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  node->data = data;
     6e5:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  node->next = nullptr;
     6ec:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  struct Node* node = malloc(sizeof(Node));
     6f3:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     6fa:	e8 31 12 00 00       	call   1930 <malloc>
  node->data = data;
     6ff:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  Node* head = nullNode(nullptr);
  Node* tail = nullNode(nullptr);
  head->prev = nullptr;
  head->next = tail;
     706:	89 43 08             	mov    %eax,0x8(%ebx)
  head->prev = nullptr;
     709:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  tail->prev = head;
     70f:	89 18                	mov    %ebx,(%eax)
  tail->next = nullptr;
     711:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)

  list->len = 0;
  list->head = head;
  list->tail = tail;
     718:	89 46 04             	mov    %eax,0x4(%esi)
  return list;
}
     71b:	89 f0                	mov    %esi,%eax
  list->len = 0;
     71d:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
  list->head = head;
     724:	89 1e                	mov    %ebx,(%esi)
}
     726:	8d 65 f8             	lea    -0x8(%ebp),%esp
     729:	5b                   	pop    %ebx
     72a:	5e                   	pop    %esi
     72b:	5d                   	pop    %ebp
     72c:	c3                   	ret    
     72d:	8d 76 00             	lea    0x0(%esi),%esi

00000730 <insert>:

void insert(struct LinkedList* list, char* data, int pos) {
     730:	55                   	push   %ebp
     731:	89 e5                	mov    %esp,%ebp
     733:	57                   	push   %edi
     734:	56                   	push   %esi
     735:	53                   	push   %ebx
     736:	83 ec 0c             	sub    $0xc,%esp
     739:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct Node* atPos = nodeAt(list, pos);
     73c:	ff 75 10             	pushl  0x10(%ebp)
     73f:	53                   	push   %ebx
     740:	e8 cb fe ff ff       	call   610 <nodeAt>
     745:	83 ec 04             	sub    $0x4,%esp
     748:	89 c6                	mov    %eax,%esi
  char* newData = (char*)malloc(sizeof(char) * 1000);
     74a:	68 e8 03 00 00       	push   $0x3e8
     74f:	e8 dc 11 00 00       	call   1930 <malloc>
     754:	8b 55 0c             	mov    0xc(%ebp),%edx
     757:	89 c7                	mov    %eax,%edi
     759:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
     75e:	e8 4d fb ff ff       	call   2b0 <safestrcpy.part.0>
  newData = safestrcpy(newData, data, (sizeof(char) * 1000));
  struct Node* new = malloc(sizeof(Node));
     763:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     76a:	e8 c1 11 00 00       	call   1930 <malloc>

  new->data = newData;
     76f:	89 78 04             	mov    %edi,0x4(%eax)
  new->prev = atPos->prev;
     772:	8b 16                	mov    (%esi),%edx
  new->next = atPos;
  new->prev->next = new;
  atPos->prev = new;
  list->len++;
}
     774:	83 c4 10             	add    $0x10,%esp
  new->next = atPos;
     777:	89 70 08             	mov    %esi,0x8(%eax)
  new->prev = atPos->prev;
     77a:	89 10                	mov    %edx,(%eax)
  new->prev->next = new;
     77c:	89 42 08             	mov    %eax,0x8(%edx)
  atPos->prev = new;
     77f:	89 06                	mov    %eax,(%esi)
  list->len++;
     781:	83 43 08 01          	addl   $0x1,0x8(%ebx)
}
     785:	8d 65 f4             	lea    -0xc(%ebp),%esp
     788:	5b                   	pop    %ebx
     789:	5e                   	pop    %esi
     78a:	5f                   	pop    %edi
     78b:	5d                   	pop    %ebp
     78c:	c3                   	ret    
     78d:	8d 76 00             	lea    0x0(%esi),%esi

00000790 <prepend>:

void prepend(struct LinkedList* list, char* data) { insert(list, data, 0); }
     790:	55                   	push   %ebp
     791:	89 e5                	mov    %esp,%ebp
     793:	83 ec 0c             	sub    $0xc,%esp
     796:	6a 00                	push   $0x0
     798:	ff 75 0c             	pushl  0xc(%ebp)
     79b:	ff 75 08             	pushl  0x8(%ebp)
     79e:	e8 8d ff ff ff       	call   730 <insert>
     7a3:	83 c4 10             	add    $0x10,%esp
     7a6:	c9                   	leave  
     7a7:	c3                   	ret    
     7a8:	90                   	nop
     7a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000007b0 <append>:
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     7b0:	55                   	push   %ebp
     7b1:	89 e5                	mov    %esp,%ebp
     7b3:	83 ec 0c             	sub    $0xc,%esp
     7b6:	8b 45 08             	mov    0x8(%ebp),%eax
     7b9:	ff 70 08             	pushl  0x8(%eax)
     7bc:	ff 75 0c             	pushl  0xc(%ebp)
     7bf:	50                   	push   %eax
     7c0:	e8 6b ff ff ff       	call   730 <insert>
     7c5:	83 c4 10             	add    $0x10,%esp
     7c8:	c9                   	leave  
     7c9:	c3                   	ret    
     7ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000007d0 <destroyLinkedList>:

void destroyLinkedList(struct LinkedList* list) {
     7d0:	55                   	push   %ebp
     7d1:	89 e5                	mov    %esp,%ebp
     7d3:	56                   	push   %esi
     7d4:	53                   	push   %ebx
     7d5:	8b 75 08             	mov    0x8(%ebp),%esi
  struct Node* curNode = list->head;
     7d8:	8b 1e                	mov    (%esi),%ebx
  while (curNode != list->tail) {
     7da:	8b 46 04             	mov    0x4(%esi),%eax
     7dd:	39 c3                	cmp    %eax,%ebx
     7df:	74 29                	je     80a <destroyLinkedList+0x3a>
     7e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    curNode = curNode->next;
     7e8:	8b 5b 08             	mov    0x8(%ebx),%ebx
    free(curNode->prev->data);
     7eb:	83 ec 0c             	sub    $0xc,%esp
     7ee:	8b 03                	mov    (%ebx),%eax
     7f0:	ff 70 04             	pushl  0x4(%eax)
     7f3:	e8 a8 10 00 00       	call   18a0 <free>
    free(curNode->prev);
     7f8:	58                   	pop    %eax
     7f9:	ff 33                	pushl  (%ebx)
     7fb:	e8 a0 10 00 00       	call   18a0 <free>
  while (curNode != list->tail) {
     800:	8b 46 04             	mov    0x4(%esi),%eax
     803:	83 c4 10             	add    $0x10,%esp
     806:	39 d8                	cmp    %ebx,%eax
     808:	75 de                	jne    7e8 <destroyLinkedList+0x18>
  }
  free(curNode);
     80a:	83 ec 0c             	sub    $0xc,%esp
     80d:	50                   	push   %eax
     80e:	e8 8d 10 00 00       	call   18a0 <free>
  free(list);
     813:	89 75 08             	mov    %esi,0x8(%ebp)
     816:	83 c4 10             	add    $0x10,%esp
     819:	8d 65 f8             	lea    -0x8(%ebp),%esp
     81c:	5b                   	pop    %ebx
     81d:	5e                   	pop    %esi
     81e:	5d                   	pop    %ebp
  free(list);
     81f:	e9 7c 10 00 00       	jmp    18a0 <free>
     824:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     82a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000830 <confirmation>:
// line-oriented text helpers
#include "textEditHelpers.h"

int confirmation() {
     830:	55                   	push   %ebp
     831:	89 e5                	mov    %esp,%ebp
     833:	53                   	push   %ebx
  // get response
  char buf[MAXLINESIZE];
  int nbuf = sizeof(buf);
  memset(buf, 0, nbuf);
     834:	8d 9d 10 fc ff ff    	lea    -0x3f0(%ebp),%ebx
int confirmation() {
     83a:	81 ec f8 03 00 00    	sub    $0x3f8,%esp
  memset(buf, 0, nbuf);
     840:	68 e8 03 00 00       	push   $0x3e8
     845:	6a 00                	push   $0x0
     847:	53                   	push   %ebx
     848:	e8 f3 0a 00 00       	call   1340 <memset>
  gets(buf, nbuf);
     84d:	58                   	pop    %eax
     84e:	5a                   	pop    %edx
     84f:	68 e8 03 00 00       	push   $0x3e8
     854:	53                   	push   %ebx
     855:	e8 46 0b 00 00       	call   13a0 <gets>
  // determine output
  switch (buf[0]) {
     85a:	0f b6 85 10 fc ff ff 	movzbl -0x3f0(%ebp),%eax
     861:	83 c4 10             	add    $0x10,%esp
     864:	3c 59                	cmp    $0x59,%al
     866:	74 18                	je     880 <confirmation+0x50>
     868:	3c 79                	cmp    $0x79,%al
     86a:	74 14                	je     880 <confirmation+0x50>
  case 'Y':
  case 'y':
    return 0;
  default:
    return 1;
     86c:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
     871:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     874:	c9                   	leave  
     875:	c3                   	ret    
     876:	8d 76 00             	lea    0x0(%esi),%esi
     879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return 0;
     880:	31 c0                	xor    %eax,%eax
}
     882:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     885:	c9                   	leave  
     886:	c3                   	ret    
     887:	89 f6                	mov    %esi,%esi
     889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000890 <normalizeRange>:
    return 1;

  return 0;
}

int normalizeRange(File file, int* sp, int* ep) {
     890:	55                   	push   %ebp
     891:	89 e5                	mov    %esp,%ebp
     893:	53                   	push   %ebx
     894:	8b 4d 24             	mov    0x24(%ebp),%ecx
  int l = file.len;
     897:	8b 45 18             	mov    0x18(%ebp),%eax
int normalizeRange(File file, int* sp, int* ep) {
     89a:	8b 5d 20             	mov    0x20(%ebp),%ebx
  if (*ep > l) *ep = l;
     89d:	8b 11                	mov    (%ecx),%edx
     89f:	39 c2                	cmp    %eax,%edx
     8a1:	7e 45                	jle    8e8 <normalizeRange+0x58>
     8a3:	89 01                	mov    %eax,(%ecx)
     8a5:	89 c2                	mov    %eax,%edx
  else if (*ep < 1) *ep += l + 1;
  if (*ep < 1) *ep = 1;
     8a7:	85 d2                	test   %edx,%edx
     8a9:	7f 06                	jg     8b1 <normalizeRange+0x21>
     8ab:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)

  if (*sp > l) *sp = l;
     8b1:	8b 13                	mov    (%ebx),%edx
     8b3:	39 c2                	cmp    %eax,%edx
     8b5:	7e 21                	jle    8d8 <normalizeRange+0x48>
     8b7:	89 03                	mov    %eax,(%ebx)
     8b9:	89 c2                	mov    %eax,%edx
  else if (*sp < 1) *sp += l + 1;
  if (*sp < 1) *sp = 1;
     8bb:	85 d2                	test   %edx,%edx
     8bd:	7f 0b                	jg     8ca <normalizeRange+0x3a>
     8bf:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
     8c5:	ba 01 00 00 00       	mov    $0x1,%edx
  if ((*ep - *sp) < 0)
     8ca:	8b 01                	mov    (%ecx),%eax
    return 1;
  return 0;
}
     8cc:	5b                   	pop    %ebx
     8cd:	5d                   	pop    %ebp
  if ((*ep - *sp) < 0)
     8ce:	29 d0                	sub    %edx,%eax
     8d0:	c1 e8 1f             	shr    $0x1f,%eax
}
     8d3:	c3                   	ret    
     8d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*sp < 1) *sp += l + 1;
     8d8:	85 d2                	test   %edx,%edx
     8da:	7f ee                	jg     8ca <normalizeRange+0x3a>
     8dc:	8d 54 10 01          	lea    0x1(%eax,%edx,1),%edx
     8e0:	89 13                	mov    %edx,(%ebx)
     8e2:	eb d7                	jmp    8bb <normalizeRange+0x2b>
     8e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (*ep < 1) *ep += l + 1;
     8e8:	85 d2                	test   %edx,%edx
     8ea:	7f c5                	jg     8b1 <normalizeRange+0x21>
     8ec:	8d 54 02 01          	lea    0x1(%edx,%eax,1),%edx
     8f0:	89 11                	mov    %edx,(%ecx)
     8f2:	eb b3                	jmp    8a7 <normalizeRange+0x17>
     8f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     8fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000900 <numLines>:

int numLines(int start, int end) {
     900:	55                   	push   %ebp
     901:	89 e5                	mov    %esp,%ebp
  return (end - start) + 1;
     903:	8b 45 0c             	mov    0xc(%ebp),%eax
     906:	2b 45 08             	sub    0x8(%ebp),%eax
}
     909:	5d                   	pop    %ebp
  return (end - start) + 1;
     90a:	83 c0 01             	add    $0x1,%eax
}
     90d:	c3                   	ret    
     90e:	66 90                	xchg   %ax,%ax

00000910 <gatherLines>:

// text
void gatherLines(File* file) {
     910:	55                   	push   %ebp
     911:	89 e5                	mov    %esp,%ebp
     913:	56                   	push   %esi
     914:	53                   	push   %ebx
     915:	8d b5 10 fc ff ff    	lea    -0x3f0(%ebp),%esi
     91b:	81 ec f0 03 00 00    	sub    $0x3f0,%esp
     921:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char line[MAXLINESIZE];
  while (getLine(file->fd, line)) {
     924:	eb 21                	jmp    947 <gatherLines+0x37>
     926:	8d 76 00             	lea    0x0(%esi),%esi
     929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    append(file->lines, line);
     930:	8b 43 0c             	mov    0xc(%ebx),%eax
void append(struct LinkedList* list, char* data) { insert(list, data, list->len); }
     933:	83 ec 04             	sub    $0x4,%esp
     936:	ff 70 08             	pushl  0x8(%eax)
     939:	56                   	push   %esi
     93a:	50                   	push   %eax
     93b:	e8 f0 fd ff ff       	call   730 <insert>
    file->len++;
     940:	83 43 10 01          	addl   $0x1,0x10(%ebx)
     944:	83 c4 10             	add    $0x10,%esp
  while (getLine(file->fd, line)) {
     947:	83 ec 08             	sub    $0x8,%esp
     94a:	56                   	push   %esi
     94b:	ff 73 04             	pushl  0x4(%ebx)
     94e:	e8 1d fa ff ff       	call   370 <getLine>
     953:	83 c4 10             	add    $0x10,%esp
     956:	85 c0                	test   %eax,%eax
     958:	75 d6                	jne    930 <gatherLines+0x20>
  }
}
     95a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     95d:	5b                   	pop    %ebx
     95e:	5e                   	pop    %esi
     95f:	5d                   	pop    %ebp
     960:	c3                   	ret    
     961:	eb 0d                	jmp    970 <getArg>
     963:	90                   	nop
     964:	90                   	nop
     965:	90                   	nop
     966:	90                   	nop
     967:	90                   	nop
     968:	90                   	nop
     969:	90                   	nop
     96a:	90                   	nop
     96b:	90                   	nop
     96c:	90                   	nop
     96d:	90                   	nop
     96e:	90                   	nop
     96f:	90                   	nop

00000970 <getArg>:

void getArg(char* dest, char* args, char delimiter) {
     970:	55                   	push   %ebp
     971:	89 e5                	mov    %esp,%ebp
     973:	57                   	push   %edi
     974:	56                   	push   %esi
     975:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     976:	31 db                	xor    %ebx,%ebx
     978:	83 ec 1c             	sub    $0x1c,%esp
     97b:	8b 75 0c             	mov    0xc(%ebp),%esi
     97e:	0f b6 7d 10          	movzbl 0x10(%ebp),%edi
     982:	eb 10                	jmp    994 <getArg+0x24>
     984:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (str[i] == c) return i;
     988:	89 f8                	mov    %edi,%eax
     98a:	3a 04 1e             	cmp    (%esi,%ebx,1),%al
     98d:	8d 53 01             	lea    0x1(%ebx),%edx
     990:	74 19                	je     9ab <getArg+0x3b>
     992:	89 d3                	mov    %edx,%ebx
  for (int i = 0; i < strlen(str); i++)
     994:	83 ec 0c             	sub    $0xc,%esp
     997:	56                   	push   %esi
     998:	e8 73 09 00 00       	call   1310 <strlen>
     99d:	83 c4 10             	add    $0x10,%esp
     9a0:	39 c3                	cmp    %eax,%ebx
     9a2:	72 e4                	jb     988 <getArg+0x18>
     9a4:	31 d2                	xor    %edx,%edx
  return -1;
     9a6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  int end = find(args, delimiter);
  substr(dest, args, 0, end);
     9ab:	53                   	push   %ebx
     9ac:	6a 00                	push   $0x0
     9ae:	56                   	push   %esi
     9af:	ff 75 08             	pushl  0x8(%ebp)
     9b2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     9b5:	e8 a6 fa ff ff       	call   460 <substr>
  substr(args, args, end + 1, (int) strlen(args));
     9ba:	89 34 24             	mov    %esi,(%esp)
     9bd:	e8 4e 09 00 00       	call   1310 <strlen>
     9c2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     9c5:	50                   	push   %eax
     9c6:	52                   	push   %edx
     9c7:	56                   	push   %esi
     9c8:	56                   	push   %esi
     9c9:	e8 92 fa ff ff       	call   460 <substr>
}
     9ce:	83 c4 20             	add    $0x20,%esp
     9d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9d4:	5b                   	pop    %ebx
     9d5:	5e                   	pop    %esi
     9d6:	5f                   	pop    %edi
     9d7:	5d                   	pop    %ebp
     9d8:	c3                   	ret    
     9d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000009e0 <collectRange>:
int collectRange(char* args, int* startptr, int* endptr) {
     9e0:	55                   	push   %ebp
     9e1:	89 e5                	mov    %esp,%ebp
     9e3:	57                   	push   %edi
     9e4:	56                   	push   %esi
     9e5:	53                   	push   %ebx
  for (int i = 0; i < strlen(str); i++)
     9e6:	31 f6                	xor    %esi,%esi
     9e8:	83 ec 2c             	sub    $0x2c,%esp
     9eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
     9ee:	eb 09                	jmp    9f9 <collectRange+0x19>
    if (str[i] == c) return i;
     9f0:	80 3c 33 3a          	cmpb   $0x3a,(%ebx,%esi,1)
     9f4:	74 42                	je     a38 <collectRange+0x58>
  for (int i = 0; i < strlen(str); i++)
     9f6:	83 c6 01             	add    $0x1,%esi
     9f9:	83 ec 0c             	sub    $0xc,%esp
     9fc:	53                   	push   %ebx
     9fd:	e8 0e 09 00 00       	call   1310 <strlen>
     a02:	83 c4 10             	add    $0x10,%esp
     a05:	39 c6                	cmp    %eax,%esi
     a07:	72 e7                	jb     9f0 <collectRange+0x10>
    if (args[0] == '-') {
     a09:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     a0c:	0f 84 d6 00 00 00    	je     ae8 <collectRange+0x108>
      *startptr = atoi(args);
     a12:	83 ec 0c             	sub    $0xc,%esp
     a15:	53                   	push   %ebx
     a16:	e8 55 0a 00 00       	call   1470 <atoi>
     a1b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     a1e:	83 c4 10             	add    $0x10,%esp
     a21:	89 01                	mov    %eax,(%ecx)
    *endptr = *startptr;
     a23:	8b 4d 10             	mov    0x10(%ebp),%ecx
     a26:	89 01                	mov    %eax,(%ecx)
    return 0;
     a28:	31 c0                	xor    %eax,%eax
}
     a2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a2d:	5b                   	pop    %ebx
     a2e:	5e                   	pop    %esi
     a2f:	5f                   	pop    %edi
     a30:	5d                   	pop    %ebp
     a31:	c3                   	ret    
     a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  getArg(startstr, args, ':');
     a38:	8d 75 de             	lea    -0x22(%ebp),%esi
     a3b:	83 ec 04             	sub    $0x4,%esp
     a3e:	6a 3a                	push   $0x3a
     a40:	53                   	push   %ebx
     a41:	56                   	push   %esi
     a42:	e8 29 ff ff ff       	call   970 <getArg>
  if (startstr[0] == '-') {
     a47:	83 c4 10             	add    $0x10,%esp
     a4a:	80 7d de 2d          	cmpb   $0x2d,-0x22(%ebp)
     a4e:	0f 84 3c 01 00 00    	je     b90 <collectRange+0x1b0>
  int negStartFlag = 0, negEndFlag = 0;
     a54:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     a5b:	31 ff                	xor    %edi,%edi
  if (endstr[0] == '-') {
     a5d:	80 3b 2d             	cmpb   $0x2d,(%ebx)
     a60:	0f 84 0a 01 00 00    	je     b70 <collectRange+0x190>
  if (strcmp(startstr, "\0") == 0) *startptr = 1;
     a66:	83 ec 08             	sub    $0x8,%esp
     a69:	68 3c 1c 00 00       	push   $0x1c3c
     a6e:	56                   	push   %esi
     a6f:	e8 4c 08 00 00       	call   12c0 <strcmp>
     a74:	83 c4 10             	add    $0x10,%esp
     a77:	85 c0                	test   %eax,%eax
     a79:	0f 85 d1 00 00 00    	jne    b50 <collectRange+0x170>
     a7f:	8b 45 0c             	mov    0xc(%ebp),%eax
     a82:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  if (strcmp(endstr, "\0") == 0) *endptr = -1;
     a88:	83 ec 08             	sub    $0x8,%esp
     a8b:	68 3c 1c 00 00       	push   $0x1c3c
     a90:	53                   	push   %ebx
     a91:	e8 2a 08 00 00       	call   12c0 <strcmp>
     a96:	83 c4 10             	add    $0x10,%esp
     a99:	85 c0                	test   %eax,%eax
     a9b:	0f 85 97 00 00 00    	jne    b38 <collectRange+0x158>
     aa1:	8b 45 10             	mov    0x10(%ebp),%eax
     aa4:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  if (negStartFlag) *startptr = 0 - *startptr;
     aaa:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     aad:	85 c0                	test   %eax,%eax
     aaf:	74 05                	je     ab6 <collectRange+0xd6>
     ab1:	8b 45 0c             	mov    0xc(%ebp),%eax
     ab4:	f7 18                	negl   (%eax)
  if (negEndFlag) *endptr = 0 - *endptr;
     ab6:	85 ff                	test   %edi,%edi
     ab8:	74 05                	je     abf <collectRange+0xdf>
     aba:	8b 45 10             	mov    0x10(%ebp),%eax
     abd:	f7 18                	negl   (%eax)
  if (((*startptr > 0 && *endptr > 0) || 
     abf:	8b 45 0c             	mov    0xc(%ebp),%eax
     ac2:	8b 00                	mov    (%eax),%eax
     ac4:	83 f8 00             	cmp    $0x0,%eax
     ac7:	7e 4f                	jle    b18 <collectRange+0x138>
     ac9:	8b 55 10             	mov    0x10(%ebp),%edx
     acc:	8b 12                	mov    (%edx),%edx
     ace:	85 d2                	test   %edx,%edx
     ad0:	7e 55                	jle    b27 <collectRange+0x147>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     ad2:	39 d0                	cmp    %edx,%eax
     ad4:	0f 9f c0             	setg   %al
}
     ad7:	8d 65 f4             	lea    -0xc(%ebp),%esp
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     ada:	0f b6 c0             	movzbl %al,%eax
}
     add:	5b                   	pop    %ebx
     ade:	5e                   	pop    %esi
     adf:	5f                   	pop    %edi
     ae0:	5d                   	pop    %ebp
     ae1:	c3                   	ret    
     ae2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      substr(args, args, 1, strlen(args));
     ae8:	83 ec 0c             	sub    $0xc,%esp
     aeb:	53                   	push   %ebx
     aec:	e8 1f 08 00 00       	call   1310 <strlen>
     af1:	50                   	push   %eax
     af2:	6a 01                	push   $0x1
     af4:	53                   	push   %ebx
     af5:	53                   	push   %ebx
     af6:	e8 65 f9 ff ff       	call   460 <substr>
      *startptr = 0 - atoi(args);
     afb:	83 c4 14             	add    $0x14,%esp
     afe:	53                   	push   %ebx
     aff:	e8 6c 09 00 00       	call   1470 <atoi>
     b04:	8b 7d 0c             	mov    0xc(%ebp),%edi
     b07:	f7 d8                	neg    %eax
     b09:	83 c4 10             	add    $0x10,%esp
     b0c:	89 07                	mov    %eax,(%edi)
     b0e:	e9 10 ff ff ff       	jmp    a23 <collectRange+0x43>
     b13:	90                   	nop
     b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (((*startptr > 0 && *endptr > 0) || 
     b18:	0f 84 0c ff ff ff    	je     a2a <collectRange+0x4a>
      (*startptr < 0 && *endptr < 0)) && (*startptr > *endptr))
     b1e:	8b 7d 10             	mov    0x10(%ebp),%edi
     b21:	8b 17                	mov    (%edi),%edx
     b23:	85 d2                	test   %edx,%edx
     b25:	78 ab                	js     ad2 <collectRange+0xf2>
}
     b27:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
     b2a:	31 c0                	xor    %eax,%eax
}
     b2c:	5b                   	pop    %ebx
     b2d:	5e                   	pop    %esi
     b2e:	5f                   	pop    %edi
     b2f:	5d                   	pop    %ebp
     b30:	c3                   	ret    
     b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else *endptr = atoi(endstr);
     b38:	83 ec 0c             	sub    $0xc,%esp
     b3b:	53                   	push   %ebx
     b3c:	e8 2f 09 00 00       	call   1470 <atoi>
     b41:	8b 55 10             	mov    0x10(%ebp),%edx
     b44:	83 c4 10             	add    $0x10,%esp
     b47:	89 02                	mov    %eax,(%edx)
     b49:	e9 5c ff ff ff       	jmp    aaa <collectRange+0xca>
     b4e:	66 90                	xchg   %ax,%ax
  else *startptr = atoi(startstr);
     b50:	83 ec 0c             	sub    $0xc,%esp
     b53:	56                   	push   %esi
     b54:	e8 17 09 00 00       	call   1470 <atoi>
     b59:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     b5c:	83 c4 10             	add    $0x10,%esp
     b5f:	89 01                	mov    %eax,(%ecx)
     b61:	e9 22 ff ff ff       	jmp    a88 <collectRange+0xa8>
     b66:	8d 76 00             	lea    0x0(%esi),%esi
     b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    substr(endstr, endstr, 1, strlen(endstr));
     b70:	83 ec 0c             	sub    $0xc,%esp
    negEndFlag = 1;
     b73:	bf 01 00 00 00       	mov    $0x1,%edi
    substr(endstr, endstr, 1, strlen(endstr));
     b78:	53                   	push   %ebx
     b79:	e8 92 07 00 00       	call   1310 <strlen>
     b7e:	50                   	push   %eax
     b7f:	6a 01                	push   $0x1
     b81:	53                   	push   %ebx
     b82:	53                   	push   %ebx
     b83:	e8 d8 f8 ff ff       	call   460 <substr>
     b88:	83 c4 20             	add    $0x20,%esp
     b8b:	e9 d6 fe ff ff       	jmp    a66 <collectRange+0x86>
    substr(startstr, startstr, 1, strlen(startstr));
     b90:	83 ec 0c             	sub    $0xc,%esp
     b93:	56                   	push   %esi
     b94:	e8 77 07 00 00       	call   1310 <strlen>
     b99:	50                   	push   %eax
     b9a:	6a 01                	push   $0x1
     b9c:	56                   	push   %esi
     b9d:	56                   	push   %esi
     b9e:	e8 bd f8 ff ff       	call   460 <substr>
     ba3:	83 c4 20             	add    $0x20,%esp
    negStartFlag = 1;
     ba6:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
     bad:	e9 a9 fe ff ff       	jmp    a5b <collectRange+0x7b>
     bb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bc0 <unline>:

void unline(char* str) {
     bc0:	55                   	push   %ebp
     bc1:	89 e5                	mov    %esp,%ebp
     bc3:	53                   	push   %ebx
     bc4:	83 ec 10             	sub    $0x10,%esp
     bc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int len = strlen(str) - 1;
     bca:	53                   	push   %ebx
     bcb:	e8 40 07 00 00       	call   1310 <strlen>
     bd0:	8d 50 ff             	lea    -0x1(%eax),%edx
  for (; len > 0; len--) {
     bd3:	83 c4 10             	add    $0x10,%esp
     bd6:	85 d2                	test   %edx,%edx
     bd8:	7e 36                	jle    c10 <unline+0x50>
    char c = str[len];
    if (c == '\n')
     bda:	80 7c 03 ff 0a       	cmpb   $0xa,-0x1(%ebx,%eax,1)
     bdf:	74 2f                	je     c10 <unline+0x50>
     be1:	8d 44 03 fe          	lea    -0x2(%ebx,%eax,1),%eax
     be5:	eb 12                	jmp    bf9 <unline+0x39>
     be7:	89 f6                	mov    %esi,%esi
     be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     bf0:	83 e8 01             	sub    $0x1,%eax
     bf3:	80 78 01 0a          	cmpb   $0xa,0x1(%eax)
     bf7:	74 06                	je     bff <unline+0x3f>
  for (; len > 0; len--) {
     bf9:	39 c3                	cmp    %eax,%ebx
     bfb:	89 c2                	mov    %eax,%edx
     bfd:	75 f1                	jne    bf0 <unline+0x30>
      break;
  }
  str[len] = '\0';
     bff:	c6 02 00             	movb   $0x0,(%edx)
}
     c02:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c05:	c9                   	leave  
     c06:	c3                   	ret    
     c07:	89 f6                	mov    %esi,%esi
     c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     c10:	01 da                	add    %ebx,%edx
  str[len] = '\0';
     c12:	c6 02 00             	movb   $0x0,(%edx)
}
     c15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c18:	c9                   	leave  
     c19:	c3                   	ret    
     c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000c20 <gatherLinesSized>:

// int* gatherLineSized(struct File* file, Terminal terminal) {
void gatherLinesSized(struct File* file, Terminal terminal) {
     c20:	55                   	push   %ebp
     c21:	89 e5                	mov    %esp,%ebp
     c23:	57                   	push   %edi
     c24:	56                   	push   %esi
     c25:	53                   	push   %ebx
     c26:	81 ec 0c 04 00 00    	sub    $0x40c,%esp
     c2c:	8b 75 0c             	mov    0xc(%ebp),%esi
     c2f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int numSplits = 0;
  char line[MAXLINESIZE];
  while (getLine(file->fd, line)) {
    int cols = 0;
    for (; strlen(line + cols) > terminal.width; cols += terminal.width) {
      char piece[terminal.width + 1]; // make room for null terminator
     c32:	8d 46 10             	lea    0x10(%esi),%eax
     c35:	89 f3                	mov    %esi,%ebx
     c37:	c1 e8 04             	shr    $0x4,%eax
     c3a:	89 85 ec fb ff ff    	mov    %eax,-0x414(%ebp)
  while (getLine(file->fd, line)) {
     c40:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
     c46:	83 ec 08             	sub    $0x8,%esp
     c49:	50                   	push   %eax
     c4a:	ff 77 04             	pushl  0x4(%edi)
     c4d:	e8 1e f7 ff ff       	call   370 <getLine>
     c52:	83 c4 10             	add    $0x10,%esp
     c55:	85 c0                	test   %eax,%eax
     c57:	0f 84 83 00 00 00    	je     ce0 <gatherLinesSized+0xc0>
     c5d:	8d b5 00 fc ff ff    	lea    -0x400(%ebp),%esi
     c63:	eb 4b                	jmp    cb0 <gatherLinesSized+0x90>
     c65:	8d 76 00             	lea    0x0(%esi),%esi
      char piece[terminal.width + 1]; // make room for null terminator
     c68:	8b 85 ec fb ff ff    	mov    -0x414(%ebp),%eax
     c6e:	8d 4b 01             	lea    0x1(%ebx),%ecx
    for (; strlen(line + cols) > terminal.width; cols += terminal.width) {
     c71:	89 a5 f4 fb ff ff    	mov    %esp,-0x40c(%ebp)
      char piece[terminal.width + 1]; // make room for null terminator
     c77:	c1 e0 04             	shl    $0x4,%eax
     c7a:	29 c4                	sub    %eax,%esp
  if(n <= 0)
     c7c:	85 c9                	test   %ecx,%ecx
     c7e:	89 a5 f0 fb ff ff    	mov    %esp,-0x410(%ebp)
     c84:	7e 09                	jle    c8f <gatherLinesSized+0x6f>
     c86:	89 f2                	mov    %esi,%edx
     c88:	89 e0                	mov    %esp,%eax
     c8a:	e8 21 f6 ff ff       	call   2b0 <safestrcpy.part.0>
      safestrcpy(piece, line + cols, terminal.width + 1); 
      append(file->lines, piece);
     c8f:	8b 47 0c             	mov    0xc(%edi),%eax
     c92:	83 ec 04             	sub    $0x4,%esp
     c95:	01 de                	add    %ebx,%esi
     c97:	ff 70 08             	pushl  0x8(%eax)
     c9a:	ff b5 f0 fb ff ff    	pushl  -0x410(%ebp)
     ca0:	50                   	push   %eax
     ca1:	e8 8a fa ff ff       	call   730 <insert>
      file->len++;
     ca6:	83 47 10 01          	addl   $0x1,0x10(%edi)
     caa:	8b a5 f4 fb ff ff    	mov    -0x40c(%ebp),%esp
    for (; strlen(line + cols) > terminal.width; cols += terminal.width) {
     cb0:	83 ec 0c             	sub    $0xc,%esp
     cb3:	56                   	push   %esi
     cb4:	e8 57 06 00 00       	call   1310 <strlen>
     cb9:	83 c4 10             	add    $0x10,%esp
     cbc:	39 d8                	cmp    %ebx,%eax
     cbe:	77 a8                	ja     c68 <gatherLinesSized+0x48>
      numSplits++;
    }
    append(file->lines, line + cols);
     cc0:	8b 47 0c             	mov    0xc(%edi),%eax
     cc3:	83 ec 04             	sub    $0x4,%esp
     cc6:	ff 70 08             	pushl  0x8(%eax)
     cc9:	56                   	push   %esi
     cca:	50                   	push   %eax
     ccb:	e8 60 fa ff ff       	call   730 <insert>
    file->len++;
     cd0:	83 47 10 01          	addl   $0x1,0x10(%edi)
     cd4:	83 c4 10             	add    $0x10,%esp
     cd7:	e9 64 ff ff ff       	jmp    c40 <gatherLinesSized+0x20>
     cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  // return ;
}
     ce0:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ce3:	5b                   	pop    %ebx
     ce4:	5e                   	pop    %esi
     ce5:	5f                   	pop    %edi
     ce6:	5d                   	pop    %ebp
     ce7:	c3                   	ret    
     ce8:	90                   	nop
     ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000cf0 <lineAt>:


// syntactic sugar
Node* lineAt(struct LinkedList* list, int pos) {
     cf0:	55                   	push   %ebp
     cf1:	89 e5                	mov    %esp,%ebp
  return nodeAt(list, pos-1);
     cf3:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
}
     cf7:	5d                   	pop    %ebp
  return nodeAt(list, pos-1);
     cf8:	e9 13 f9 ff ff       	jmp    610 <nodeAt>
     cfd:	8d 76 00             	lea    0x0(%esi),%esi

00000d00 <printl>:

void printl(int lineNum, char* line) {
     d00:	55                   	push   %ebp
     d01:	89 e5                	mov    %esp,%ebp
     d03:	83 ec 08             	sub    $0x8,%esp
     d06:	8b 45 08             	mov    0x8(%ebp),%eax
  if (lineNum < 10)
     d09:	83 f8 09             	cmp    $0x9,%eax
     d0c:	7e 3a                	jle    d48 <printl+0x48>
    fprintf(2, "%d  : %s\n", lineNum, line);
  else if (lineNum < 100)
     d0e:	83 f8 63             	cmp    $0x63,%eax
     d11:	7e 1d                	jle    d30 <printl+0x30>
    fprintf(2, "%d : %s\n", lineNum, line);
  else
    fprintf(2, "%d: %s\n", lineNum, line);
     d13:	ff 75 0c             	pushl  0xc(%ebp)
     d16:	50                   	push   %eax
     d17:	68 a3 1d 00 00       	push   $0x1da3
     d1c:	6a 02                	push   $0x2
     d1e:	e8 3d 0b 00 00       	call   1860 <fprintf>
     d23:	83 c4 10             	add    $0x10,%esp
}
     d26:	c9                   	leave  
     d27:	c3                   	ret    
     d28:	90                   	nop
     d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fprintf(2, "%d : %s\n", lineNum, line);
     d30:	ff 75 0c             	pushl  0xc(%ebp)
     d33:	50                   	push   %eax
     d34:	68 9a 1d 00 00       	push   $0x1d9a
     d39:	6a 02                	push   $0x2
     d3b:	e8 20 0b 00 00       	call   1860 <fprintf>
     d40:	83 c4 10             	add    $0x10,%esp
}
     d43:	c9                   	leave  
     d44:	c3                   	ret    
     d45:	8d 76 00             	lea    0x0(%esi),%esi
    fprintf(2, "%d  : %s\n", lineNum, line);
     d48:	ff 75 0c             	pushl  0xc(%ebp)
     d4b:	50                   	push   %eax
     d4c:	68 90 1d 00 00       	push   $0x1d90
     d51:	6a 02                	push   $0x2
     d53:	e8 08 0b 00 00       	call   1860 <fprintf>
     d58:	83 c4 10             	add    $0x10,%esp
}
     d5b:	c9                   	leave  
     d5c:	c3                   	ret    
     d5d:	8d 76 00             	lea    0x0(%esi),%esi

00000d60 <printpad>:

// prints the string with padding of a certain character
void printpad(int pad, char padChar, char* str, int alignment, int endLine) {
     d60:	55                   	push   %ebp
     d61:	89 e5                	mov    %esp,%ebp
     d63:	57                   	push   %edi
     d64:	56                   	push   %esi
     d65:	53                   	push   %ebx
     d66:	83 ec 28             	sub    $0x28,%esp
     d69:	8b 45 0c             	mov    0xc(%ebp),%eax
     d6c:	8b 7d 10             	mov    0x10(%ebp),%edi
     d6f:	8b 5d 08             	mov    0x8(%ebp),%ebx
     d72:	8b 75 14             	mov    0x14(%ebp),%esi
     d75:	89 45 e0             	mov    %eax,-0x20(%ebp)
     d78:	8b 45 18             	mov    0x18(%ebp),%eax
  int len = strlen(str);
     d7b:	57                   	push   %edi
void printpad(int pad, char padChar, char* str, int alignment, int endLine) {
     d7c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int len = strlen(str);
     d7f:	e8 8c 05 00 00       	call   1310 <strlen>
  int i = pad - len;
  if (alignment == LEFT) {
     d84:	83 c4 10             	add    $0x10,%esp
  int i = pad - len;
     d87:	29 c3                	sub    %eax,%ebx
  if (alignment == LEFT) {
     d89:	85 f6                	test   %esi,%esi
     d8b:	74 7b                	je     e08 <printpad+0xa8>
    printf("%s", str);
    for (; i > 0; i--)
      printf("%c", padChar);
  } else if (alignment == RIGHT) {
     d8d:	83 fe 02             	cmp    $0x2,%esi
     d90:	74 1e                	je     db0 <printpad+0x50>
    for (; i > 0; i--)
      printf("%c", padChar);
    printf("%s", str);
  } else if (alignment == CENTER) {
     d92:	83 fe 01             	cmp    $0x1,%esi
     d95:	0f 84 ad 00 00 00    	je     e48 <printpad+0xe8>
      printf("%c", padChar);
      if (i == half)
        printf("%s", str);
    }
  }
  if (endLine) {
     d9b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d9e:	85 c0                	test   %eax,%eax
     da0:	75 4c                	jne    dee <printpad+0x8e>
    printf("\n");
  }
     da2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     da5:	5b                   	pop    %ebx
     da6:	5e                   	pop    %esi
     da7:	5f                   	pop    %edi
     da8:	5d                   	pop    %ebp
     da9:	c3                   	ret    
     daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for (; i > 0; i--)
     db0:	85 db                	test   %ebx,%ebx
     db2:	7e 22                	jle    dd6 <printpad+0x76>
     db4:	0f be 75 e0          	movsbl -0x20(%ebp),%esi
     db8:	90                   	nop
     db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printf("%c", padChar);
     dc0:	83 ec 08             	sub    $0x8,%esp
     dc3:	56                   	push   %esi
     dc4:	68 ae 1d 00 00       	push   $0x1dae
     dc9:	e8 b2 0a 00 00       	call   1880 <printf>
    for (; i > 0; i--)
     dce:	83 c4 10             	add    $0x10,%esp
     dd1:	83 eb 01             	sub    $0x1,%ebx
     dd4:	75 ea                	jne    dc0 <printpad+0x60>
    printf("%s", str);
     dd6:	83 ec 08             	sub    $0x8,%esp
     dd9:	57                   	push   %edi
     dda:	68 ab 1d 00 00       	push   $0x1dab
     ddf:	e8 9c 0a 00 00       	call   1880 <printf>
  if (endLine) {
     de4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     de7:	83 c4 10             	add    $0x10,%esp
     dea:	85 c0                	test   %eax,%eax
     dec:	74 b4                	je     da2 <printpad+0x42>
    printf("\n");
     dee:	c7 45 08 15 1e 00 00 	movl   $0x1e15,0x8(%ebp)
     df5:	8d 65 f4             	lea    -0xc(%ebp),%esp
     df8:	5b                   	pop    %ebx
     df9:	5e                   	pop    %esi
     dfa:	5f                   	pop    %edi
     dfb:	5d                   	pop    %ebp
    printf("\n");
     dfc:	e9 7f 0a 00 00       	jmp    1880 <printf>
     e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    printf("%s", str);
     e08:	83 ec 08             	sub    $0x8,%esp
     e0b:	57                   	push   %edi
     e0c:	68 ab 1d 00 00       	push   $0x1dab
     e11:	e8 6a 0a 00 00       	call   1880 <printf>
    for (; i > 0; i--)
     e16:	83 c4 10             	add    $0x10,%esp
     e19:	85 db                	test   %ebx,%ebx
     e1b:	0f 8e 7a ff ff ff    	jle    d9b <printpad+0x3b>
     e21:	0f be 75 e0          	movsbl -0x20(%ebp),%esi
     e25:	8d 76 00             	lea    0x0(%esi),%esi
      printf("%c", padChar);
     e28:	83 ec 08             	sub    $0x8,%esp
     e2b:	56                   	push   %esi
     e2c:	68 ae 1d 00 00       	push   $0x1dae
     e31:	e8 4a 0a 00 00       	call   1880 <printf>
    for (; i > 0; i--)
     e36:	83 c4 10             	add    $0x10,%esp
     e39:	83 eb 01             	sub    $0x1,%ebx
     e3c:	75 ea                	jne    e28 <printpad+0xc8>
     e3e:	e9 58 ff ff ff       	jmp    d9b <printpad+0x3b>
     e43:	90                   	nop
     e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int half = i / 2;
     e48:	89 d8                	mov    %ebx,%eax
     e4a:	c1 e8 1f             	shr    $0x1f,%eax
     e4d:	01 d8                	add    %ebx,%eax
     e4f:	d1 f8                	sar    %eax
    for (; i > 0; i--) {
     e51:	85 db                	test   %ebx,%ebx
    int half = i / 2;
     e53:	89 45 dc             	mov    %eax,-0x24(%ebp)
    for (; i > 0; i--) {
     e56:	0f 8e 3f ff ff ff    	jle    d9b <printpad+0x3b>
     e5c:	0f be 75 e0          	movsbl -0x20(%ebp),%esi
     e60:	eb 0f                	jmp    e71 <printpad+0x111>
     e62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e68:	83 eb 01             	sub    $0x1,%ebx
     e6b:	0f 84 2a ff ff ff    	je     d9b <printpad+0x3b>
      printf("%c", padChar);
     e71:	83 ec 08             	sub    $0x8,%esp
     e74:	56                   	push   %esi
     e75:	68 ae 1d 00 00       	push   $0x1dae
     e7a:	e8 01 0a 00 00       	call   1880 <printf>
      if (i == half)
     e7f:	83 c4 10             	add    $0x10,%esp
     e82:	39 5d dc             	cmp    %ebx,-0x24(%ebp)
     e85:	75 e1                	jne    e68 <printpad+0x108>
        printf("%s", str);
     e87:	83 ec 08             	sub    $0x8,%esp
     e8a:	57                   	push   %edi
     e8b:	68 ab 1d 00 00       	push   $0x1dab
     e90:	e8 eb 09 00 00       	call   1880 <printf>
     e95:	83 c4 10             	add    $0x10,%esp
     e98:	eb ce                	jmp    e68 <printpad+0x108>
     e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000ea0 <line>:
void line(File file, Terminal terminal){
     ea0:	55                   	push   %ebp
     ea1:	b9 0a 00 00 00       	mov    $0xa,%ecx
     ea6:	89 e5                	mov    %esp,%ebp
     ea8:	56                   	push   %esi
     ea9:	53                   	push   %ebx
     eaa:	8d 5d ee             	lea    -0x12(%ebp),%ebx
     ead:	83 ec 10             	sub    $0x10,%esp
     eb0:	8b 45 10             	mov    0x10(%ebp),%eax
     eb3:	8b 75 20             	mov    0x20(%ebp),%esi
     eb6:	89 da                	mov    %ebx,%edx
     eb8:	e8 33 f4 ff ff       	call   2f0 <itoa.part.1>
  printpad(terminal.width, ' ', msg, LEFT, 0);
     ebd:	83 ec 0c             	sub    $0xc,%esp
     ec0:	6a 00                	push   $0x0
     ec2:	6a 00                	push   $0x0
     ec4:	53                   	push   %ebx
     ec5:	6a 20                	push   $0x20
     ec7:	56                   	push   %esi
     ec8:	e8 93 fe ff ff       	call   d60 <printpad>
  printf("\r"); // we want to rewrite this line eventually
     ecd:	83 c4 14             	add    $0x14,%esp
     ed0:	68 b1 1d 00 00       	push   $0x1db1
     ed5:	e8 a6 09 00 00       	call   1880 <printf>
}
     eda:	83 c4 10             	add    $0x10,%esp
     edd:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ee0:	5b                   	pop    %ebx
     ee1:	5e                   	pop    %esi
     ee2:	5d                   	pop    %ebp
     ee3:	c3                   	ret    
     ee4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     eea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000ef0 <help>:
void help(Terminal terminal) {
     ef0:	55                   	push   %ebp
     ef1:	89 e5                	mov    %esp,%ebp
     ef3:	53                   	push   %ebx
     ef4:	83 ec 10             	sub    $0x10,%esp
     ef7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printpad(terminal.width, '-', "-", LEFT, 1);
     efa:	6a 01                	push   $0x1
     efc:	6a 00                	push   $0x0
     efe:	68 b3 1d 00 00       	push   $0x1db3
     f03:	6a 2d                	push   $0x2d
     f05:	53                   	push   %ebx
     f06:	e8 55 fe ff ff       	call   d60 <printpad>
  printf("Command       Description [Def Parameter]\n");
     f0b:	83 c4 14             	add    $0x14,%esp
     f0e:	68 70 1a 00 00       	push   $0x1a70
     f13:	e8 68 09 00 00       	call   1880 <printf>
  printf("<space>       Display next page\n");
     f18:	c7 04 24 9c 1a 00 00 	movl   $0x1a9c,(%esp)
     f1f:	e8 5c 09 00 00       	call   1880 <printf>
  printf("<int> e,E,s,S Display next <int> lines [1]\n");
     f24:	c7 04 24 c0 1a 00 00 	movl   $0x1ac0,(%esp)
     f2b:	e8 50 09 00 00       	call   1880 <printf>
  printf("<int> b,B     Skip back <int> screens [1]\n");
     f30:	c7 04 24 ec 1a 00 00 	movl   $0x1aec,(%esp)
     f37:	e8 44 09 00 00       	call   1880 <printf>
  printf("<int> f,F     Skip forward <int> screens [1]\n");
     f3c:	c7 04 24 18 1b 00 00 	movl   $0x1b18,(%esp)
     f43:	e8 38 09 00 00       	call   1880 <printf>
  printf("=             Display current line number\n");
     f48:	c7 04 24 48 1b 00 00 	movl   $0x1b48,(%esp)
     f4f:	e8 2c 09 00 00       	call   1880 <printf>
  printf(".             Repeat previous command\n");
     f54:	c7 04 24 74 1b 00 00 	movl   $0x1b74,(%esp)
     f5b:	e8 20 09 00 00       	call   1880 <printf>
  printf("q or Q        Exit from more\n");
     f60:	c7 04 24 b5 1d 00 00 	movl   $0x1db5,(%esp)
     f67:	e8 14 09 00 00       	call   1880 <printf>
  printpad(terminal.width, '-', "-", LEFT, 1);
     f6c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f73:	6a 00                	push   $0x0
     f75:	68 b3 1d 00 00       	push   $0x1db3
     f7a:	6a 2d                	push   $0x2d
     f7c:	53                   	push   %ebx
     f7d:	e8 de fd ff ff       	call   d60 <printpad>
}
     f82:	83 c4 20             	add    $0x20,%esp
     f85:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     f88:	c9                   	leave  
     f89:	c3                   	ret    
     f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000f90 <printPrompt>:
void printPrompt(File file) {
     f90:	55                   	push   %ebp
     f91:	89 e5                	mov    %esp,%ebp
     f93:	83 ec 10             	sub    $0x10,%esp
  printf("\n--MORE--(%d%%)", 100 * file.curLine / file.len);
     f96:	6b 45 10 64          	imul   $0x64,0x10(%ebp),%eax
     f9a:	99                   	cltd   
     f9b:	f7 7d 18             	idivl  0x18(%ebp)
     f9e:	50                   	push   %eax
     f9f:	68 d3 1d 00 00       	push   $0x1dd3
     fa4:	e8 d7 08 00 00       	call   1880 <printf>
  printf("[Press space to continue, 'q' to quit.]\r");
     fa9:	83 c4 10             	add    $0x10,%esp
     fac:	c7 45 08 9c 1b 00 00 	movl   $0x1b9c,0x8(%ebp)
}
     fb3:	c9                   	leave  
  printf("[Press space to continue, 'q' to quit.]\r");
     fb4:	e9 c7 08 00 00       	jmp    1880 <printf>
     fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000fc0 <showPage>:
void showPage(File file, Terminal terminal) {
     fc0:	55                   	push   %ebp
     fc1:	89 e5                	mov    %esp,%ebp
     fc3:	57                   	push   %edi
     fc4:	56                   	push   %esi
     fc5:	53                   	push   %ebx
     fc6:	83 ec 1c             	sub    $0x1c,%esp
  struct Node* curNode = lineAt(file.lines, LINE_ON_TOP);
     fc9:	8b 55 24             	mov    0x24(%ebp),%edx
     fcc:	8b 45 10             	mov    0x10(%ebp),%eax
     fcf:	8b 75 14             	mov    0x14(%ebp),%esi
void showPage(File file, Terminal terminal) {
     fd2:	8b 7d 20             	mov    0x20(%ebp),%edi
  struct Node* curNode = lineAt(file.lines, LINE_ON_TOP);
     fd5:	8d 4a ff             	lea    -0x1(%edx),%ecx
     fd8:	89 45 e0             	mov    %eax,-0x20(%ebp)
     fdb:	29 c8                	sub    %ecx,%eax
     fdd:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  return nodeAt(list, pos-1);
     fe0:	50                   	push   %eax
     fe1:	56                   	push   %esi
     fe2:	e8 29 f6 ff ff       	call   610 <nodeAt>
  while (termLine < TERMH_ADJ) {
     fe7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
     fea:	5a                   	pop    %edx
     feb:	59                   	pop    %ecx
     fec:	85 db                	test   %ebx,%ebx
     fee:	7e 4d                	jle    103d <showPage+0x7d>
      printpad(terminal.width, ' ', curNode->data, LEFT, 0);
     ff0:	83 ec 0c             	sub    $0xc,%esp
     ff3:	89 c3                	mov    %eax,%ebx
     ff5:	6a 00                	push   $0x0
     ff7:	6a 00                	push   $0x0
     ff9:	ff 70 04             	pushl  0x4(%eax)
     ffc:	6a 20                	push   $0x20
     ffe:	57                   	push   %edi
     fff:	e8 5c fd ff ff       	call   d60 <printpad>
    curNode = curNode->next;
    1004:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) exit();
    1007:	83 c4 20             	add    $0x20,%esp
    100a:	3b 5e 04             	cmp    0x4(%esi),%ebx
    100d:	74 5a                	je     1069 <showPage+0xa9>
  while (termLine < TERMH_ADJ) {
    100f:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1013:	74 28                	je     103d <showPage+0x7d>
    termLine++;
    1015:	bf 01 00 00 00       	mov    $0x1,%edi
    } else printf("%s\n", curNode->data);
    101a:	83 ec 08             	sub    $0x8,%esp
    101d:	ff 73 04             	pushl  0x4(%ebx)
    termLine++;
    1020:	83 c7 01             	add    $0x1,%edi
    } else printf("%s\n", curNode->data);
    1023:	68 96 1d 00 00       	push   $0x1d96
    1028:	e8 53 08 00 00       	call   1880 <printf>
    curNode = curNode->next;
    102d:	8b 5b 08             	mov    0x8(%ebx),%ebx
    if (curNode == file.lines->tail) exit();
    1030:	83 c4 10             	add    $0x10,%esp
    1033:	39 5e 04             	cmp    %ebx,0x4(%esi)
    1036:	74 31                	je     1069 <showPage+0xa9>
  while (termLine < TERMH_ADJ) {
    1038:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
    103b:	75 dd                	jne    101a <showPage+0x5a>
  printf("\n--MORE--(%d%%)", 100 * file.curLine / file.len);
    103d:	6b 45 e0 64          	imul   $0x64,-0x20(%ebp),%eax
    1041:	83 ec 08             	sub    $0x8,%esp
    1044:	99                   	cltd   
    1045:	f7 7d 18             	idivl  0x18(%ebp)
    1048:	50                   	push   %eax
    1049:	68 d3 1d 00 00       	push   $0x1dd3
    104e:	e8 2d 08 00 00       	call   1880 <printf>
  printf("[Press space to continue, 'q' to quit.]\r");
    1053:	c7 45 08 9c 1b 00 00 	movl   $0x1b9c,0x8(%ebp)
    105a:	83 c4 10             	add    $0x10,%esp
}
    105d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1060:	5b                   	pop    %ebx
    1061:	5e                   	pop    %esi
    1062:	5f                   	pop    %edi
    1063:	5d                   	pop    %ebp
  printf("[Press space to continue, 'q' to quit.]\r");
    1064:	e9 17 08 00 00       	jmp    1880 <printf>
    if (curNode == file.lines->tail) exit();
    1069:	e8 74 04 00 00       	call   14e2 <exit>
    106e:	66 90                	xchg   %ax,%ax

00001070 <forward>:
void forward(struct File* file, Terminal terminal){
    1070:	55                   	push   %ebp
    1071:	89 e5                	mov    %esp,%ebp
    1073:	56                   	push   %esi
    1074:	53                   	push   %ebx
    1075:	8b 45 08             	mov    0x8(%ebp),%eax
    1078:	8b 5d 10             	mov    0x10(%ebp),%ebx
    107b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  file->curLine += TERMH_ADJ; // forward 1 page
    107e:	8d 53 ff             	lea    -0x1(%ebx),%edx
    1081:	03 50 08             	add    0x8(%eax),%edx
  if (file->curLine > file->len) file->curLine = file->len;
    1084:	8b 70 10             	mov    0x10(%eax),%esi
    1087:	39 f2                	cmp    %esi,%edx
  file->curLine += TERMH_ADJ; // forward 1 page
    1089:	89 50 08             	mov    %edx,0x8(%eax)
  if (file->curLine > file->len) file->curLine = file->len;
    108c:	7e 03                	jle    1091 <forward+0x21>
    108e:	89 70 08             	mov    %esi,0x8(%eax)
  showPage(*file, terminal);
    1091:	53                   	push   %ebx
    1092:	51                   	push   %ecx
    1093:	ff 70 14             	pushl  0x14(%eax)
    1096:	ff 70 10             	pushl  0x10(%eax)
    1099:	ff 70 0c             	pushl  0xc(%eax)
    109c:	ff 70 08             	pushl  0x8(%eax)
    109f:	ff 70 04             	pushl  0x4(%eax)
    10a2:	ff 30                	pushl  (%eax)
    10a4:	e8 17 ff ff ff       	call   fc0 <showPage>
}
    10a9:	83 c4 20             	add    $0x20,%esp
    10ac:	8d 65 f8             	lea    -0x8(%ebp),%esp
    10af:	5b                   	pop    %ebx
    10b0:	5e                   	pop    %esi
    10b1:	5d                   	pop    %ebp
    10b2:	c3                   	ret    
    10b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010c0 <skip>:
void skip(struct File* file, Terminal terminal, int numPages){
    10c0:	55                   	push   %ebp
    10c1:	89 e5                	mov    %esp,%ebp
    10c3:	57                   	push   %edi
    10c4:	56                   	push   %esi
    10c5:	53                   	push   %ebx
    10c6:	83 ec 0c             	sub    $0xc,%esp
    10c9:	8b 7d 10             	mov    0x10(%ebp),%edi
    10cc:	8b 5d 08             	mov    0x8(%ebp),%ebx
    10cf:	8b 75 0c             	mov    0xc(%ebp),%esi
  file->curLine += (numPages * TERMH_ADJ); // forward x pages
    10d2:	8d 47 ff             	lea    -0x1(%edi),%eax
  if (file->curLine > file->len) file->curLine = file->len;
    10d5:	8b 53 10             	mov    0x10(%ebx),%edx
  file->curLine += (numPages * TERMH_ADJ); // forward x pages
    10d8:	0f af 45 14          	imul   0x14(%ebp),%eax
    10dc:	03 43 08             	add    0x8(%ebx),%eax
  if (file->curLine > file->len) file->curLine = file->len;
    10df:	39 d0                	cmp    %edx,%eax
  file->curLine += (numPages * TERMH_ADJ); // forward x pages
    10e1:	89 43 08             	mov    %eax,0x8(%ebx)
  if (file->curLine > file->len) file->curLine = file->len;
    10e4:	7e 03                	jle    10e9 <skip+0x29>
    10e6:	89 53 08             	mov    %edx,0x8(%ebx)
  printpad(terminal.width, ' ', msg, LEFT, 0);
    10e9:	83 ec 0c             	sub    $0xc,%esp
    10ec:	6a 00                	push   $0x0
    10ee:	6a 00                	push   $0x0
    10f0:	68 e3 1d 00 00       	push   $0x1de3
    10f5:	6a 20                	push   $0x20
    10f7:	56                   	push   %esi
    10f8:	e8 63 fc ff ff       	call   d60 <printpad>
  showPage(*file, terminal);
    10fd:	83 c4 20             	add    $0x20,%esp
    1100:	57                   	push   %edi
    1101:	56                   	push   %esi
    1102:	ff 73 14             	pushl  0x14(%ebx)
    1105:	ff 73 10             	pushl  0x10(%ebx)
    1108:	ff 73 0c             	pushl  0xc(%ebx)
    110b:	ff 73 08             	pushl  0x8(%ebx)
    110e:	ff 73 04             	pushl  0x4(%ebx)
    1111:	ff 33                	pushl  (%ebx)
    1113:	e8 a8 fe ff ff       	call   fc0 <showPage>
}
    1118:	83 c4 20             	add    $0x20,%esp
    111b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    111e:	5b                   	pop    %ebx
    111f:	5e                   	pop    %esi
    1120:	5f                   	pop    %edi
    1121:	5d                   	pop    %ebp
    1122:	c3                   	ret    
    1123:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001130 <back>:
void back(struct File* file, Terminal terminal, int numPages){
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	57                   	push   %edi
    1134:	56                   	push   %esi
    1135:	53                   	push   %ebx
    1136:	83 ec 18             	sub    $0x18,%esp
    1139:	8b 7d 10             	mov    0x10(%ebp),%edi
    113c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  file->curLine -= (numPages * TERMH_ADJ); // back x pages
    113f:	8b 55 14             	mov    0x14(%ebp),%edx
void back(struct File* file, Terminal terminal, int numPages){
    1142:	8b 75 0c             	mov    0xc(%ebp),%esi
  file->curLine -= (numPages * TERMH_ADJ); // back x pages
    1145:	8d 47 ff             	lea    -0x1(%edi),%eax
    1148:	8b 4b 08             	mov    0x8(%ebx),%ecx
    114b:	0f af d0             	imul   %eax,%edx
    114e:	29 d1                	sub    %edx,%ecx
    1150:	39 c8                	cmp    %ecx,%eax
    1152:	0f 4e c1             	cmovle %ecx,%eax
    1155:	89 43 08             	mov    %eax,0x8(%ebx)
  printpad(terminal.width, ' ', msg, LEFT, 0);
    1158:	6a 00                	push   $0x0
    115a:	6a 00                	push   $0x0
    115c:	68 ef 1d 00 00       	push   $0x1def
    1161:	6a 20                	push   $0x20
    1163:	56                   	push   %esi
    1164:	e8 f7 fb ff ff       	call   d60 <printpad>
  showPage(*file, terminal);
    1169:	83 c4 20             	add    $0x20,%esp
    116c:	57                   	push   %edi
    116d:	56                   	push   %esi
    116e:	ff 73 14             	pushl  0x14(%ebx)
    1171:	ff 73 10             	pushl  0x10(%ebx)
    1174:	ff 73 0c             	pushl  0xc(%ebx)
    1177:	ff 73 08             	pushl  0x8(%ebx)
    117a:	ff 73 04             	pushl  0x4(%ebx)
    117d:	ff 33                	pushl  (%ebx)
    117f:	e8 3c fe ff ff       	call   fc0 <showPage>
}
    1184:	83 c4 20             	add    $0x20,%esp
    1187:	8d 65 f4             	lea    -0xc(%ebp),%esp
    118a:	5b                   	pop    %ebx
    118b:	5e                   	pop    %esi
    118c:	5f                   	pop    %edi
    118d:	5d                   	pop    %ebp
    118e:	c3                   	ret    
    118f:	90                   	nop

00001190 <showLines>:
void showLines(File file, Terminal terminal, int numLines) {
    1190:	55                   	push   %ebp
    1191:	89 e5                	mov    %esp,%ebp
    1193:	57                   	push   %edi
    1194:	56                   	push   %esi
    1195:	53                   	push   %ebx
    1196:	83 ec 1c             	sub    $0x1c,%esp
    1199:	8b 45 20             	mov    0x20(%ebp),%eax
    119c:	8b 75 14             	mov    0x14(%ebp),%esi
    119f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    11a2:	8b 45 10             	mov    0x10(%ebp),%eax
    11a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    11a8:	83 e8 01             	sub    $0x1,%eax
    11ab:	50                   	push   %eax
    11ac:	56                   	push   %esi
    11ad:	e8 5e f4 ff ff       	call   610 <nodeAt>
    11b2:	5a                   	pop    %edx
  struct Node* curNode = (lineAt(file.lines, file.curLine))->next;
    11b3:	8b 58 08             	mov    0x8(%eax),%ebx
    11b6:	8b 7d 28             	mov    0x28(%ebp),%edi
  int firstLine = 1;
    11b9:	ba 01 00 00 00       	mov    $0x1,%edx
    11be:	59                   	pop    %ecx
  while (numLines-- > 0) {
    11bf:	eb 29                	jmp    11ea <showLines+0x5a>
    11c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printpad(terminal.width, ' ', curNode->data, LEFT, 0);
    11c8:	83 ec 0c             	sub    $0xc,%esp
    11cb:	6a 00                	push   $0x0
    11cd:	6a 00                	push   $0x0
    11cf:	51                   	push   %ecx
    11d0:	6a 20                	push   $0x20
    11d2:	ff 75 e4             	pushl  -0x1c(%ebp)
    11d5:	e8 86 fb ff ff       	call   d60 <printpad>
    11da:	83 c4 20             	add    $0x20,%esp
    curNode = curNode->next;
    11dd:	8b 5b 08             	mov    0x8(%ebx),%ebx
    11e0:	83 ef 01             	sub    $0x1,%edi
    11e3:	31 d2                	xor    %edx,%edx
    if (curNode == file.lines->tail) exit();
    11e5:	39 5e 04             	cmp    %ebx,0x4(%esi)
    11e8:	74 52                	je     123c <showLines+0xac>
  while (numLines-- > 0) {
    11ea:	85 ff                	test   %edi,%edi
    11ec:	7e 22                	jle    1210 <showLines+0x80>
    if (firstLine) {
    11ee:	85 d2                	test   %edx,%edx
    11f0:	8b 4b 04             	mov    0x4(%ebx),%ecx
    11f3:	75 d3                	jne    11c8 <showLines+0x38>
    } else printf("%s\n", curNode->data);
    11f5:	83 ec 08             	sub    $0x8,%esp
    11f8:	51                   	push   %ecx
    11f9:	68 96 1d 00 00       	push   $0x1d96
    11fe:	e8 7d 06 00 00       	call   1880 <printf>
    1203:	83 c4 10             	add    $0x10,%esp
    1206:	eb d5                	jmp    11dd <showLines+0x4d>
    1208:	90                   	nop
    1209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  printf("\n--MORE--(%d%%)", 100 * file.curLine / file.len);
    1210:	6b 45 e0 64          	imul   $0x64,-0x20(%ebp),%eax
    1214:	83 ec 08             	sub    $0x8,%esp
    1217:	99                   	cltd   
    1218:	f7 7d 18             	idivl  0x18(%ebp)
    121b:	50                   	push   %eax
    121c:	68 d3 1d 00 00       	push   $0x1dd3
    1221:	e8 5a 06 00 00       	call   1880 <printf>
  printf("[Press space to continue, 'q' to quit.]\r");
    1226:	c7 45 08 9c 1b 00 00 	movl   $0x1b9c,0x8(%ebp)
    122d:	83 c4 10             	add    $0x10,%esp
}
    1230:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1233:	5b                   	pop    %ebx
    1234:	5e                   	pop    %esi
    1235:	5f                   	pop    %edi
    1236:	5d                   	pop    %ebp
  printf("[Press space to continue, 'q' to quit.]\r");
    1237:	e9 44 06 00 00       	jmp    1880 <printf>
    if (curNode == file.lines->tail) exit();
    123c:	e8 a1 02 00 00       	call   14e2 <exit>
    1241:	eb 0d                	jmp    1250 <scroll>
    1243:	90                   	nop
    1244:	90                   	nop
    1245:	90                   	nop
    1246:	90                   	nop
    1247:	90                   	nop
    1248:	90                   	nop
    1249:	90                   	nop
    124a:	90                   	nop
    124b:	90                   	nop
    124c:	90                   	nop
    124d:	90                   	nop
    124e:	90                   	nop
    124f:	90                   	nop

00001250 <scroll>:
void scroll(struct File* file, Terminal terminal, int numLines){
    1250:	55                   	push   %ebp
    1251:	89 e5                	mov    %esp,%ebp
    1253:	56                   	push   %esi
    1254:	53                   	push   %ebx
    1255:	8b 75 14             	mov    0x14(%ebp),%esi
    1258:	8b 5d 08             	mov    0x8(%ebp),%ebx
  showLines(*file, terminal, numLines);
    125b:	83 ec 0c             	sub    $0xc,%esp
    125e:	56                   	push   %esi
    125f:	ff 75 10             	pushl  0x10(%ebp)
    1262:	ff 75 0c             	pushl  0xc(%ebp)
    1265:	ff 73 14             	pushl  0x14(%ebx)
    1268:	ff 73 10             	pushl  0x10(%ebx)
    126b:	ff 73 0c             	pushl  0xc(%ebx)
    126e:	ff 73 08             	pushl  0x8(%ebx)
    1271:	ff 73 04             	pushl  0x4(%ebx)
    1274:	ff 33                	pushl  (%ebx)
    1276:	e8 15 ff ff ff       	call   1190 <showLines>
  file->curLine += numLines;
    127b:	01 73 08             	add    %esi,0x8(%ebx)
}
    127e:	83 c4 30             	add    $0x30,%esp
    1281:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1284:	5b                   	pop    %ebx
    1285:	5e                   	pop    %esi
    1286:	5d                   	pop    %ebp
    1287:	c3                   	ret    
    1288:	66 90                	xchg   %ax,%ax
    128a:	66 90                	xchg   %ax,%ax
    128c:	66 90                	xchg   %ax,%ax
    128e:	66 90                	xchg   %ax,%ax

00001290 <strcpy>:
#include "user/user.h"
#include "../kernel/x86.h"

char*
strcpy(char *s, const char *t)
{
    1290:	55                   	push   %ebp
    1291:	89 e5                	mov    %esp,%ebp
    1293:	53                   	push   %ebx
    1294:	8b 45 08             	mov    0x8(%ebp),%eax
    1297:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    129a:	89 c2                	mov    %eax,%edx
    129c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12a0:	83 c1 01             	add    $0x1,%ecx
    12a3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    12a7:	83 c2 01             	add    $0x1,%edx
    12aa:	84 db                	test   %bl,%bl
    12ac:	88 5a ff             	mov    %bl,-0x1(%edx)
    12af:	75 ef                	jne    12a0 <strcpy+0x10>
    ;
  return os;
}
    12b1:	5b                   	pop    %ebx
    12b2:	5d                   	pop    %ebp
    12b3:	c3                   	ret    
    12b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    12ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000012c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    12c0:	55                   	push   %ebp
    12c1:	89 e5                	mov    %esp,%ebp
    12c3:	53                   	push   %ebx
    12c4:	8b 55 08             	mov    0x8(%ebp),%edx
    12c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    12ca:	0f b6 02             	movzbl (%edx),%eax
    12cd:	0f b6 19             	movzbl (%ecx),%ebx
    12d0:	84 c0                	test   %al,%al
    12d2:	75 1c                	jne    12f0 <strcmp+0x30>
    12d4:	eb 2a                	jmp    1300 <strcmp+0x40>
    12d6:	8d 76 00             	lea    0x0(%esi),%esi
    12d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    12e0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    12e3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    12e6:	83 c1 01             	add    $0x1,%ecx
    12e9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    12ec:	84 c0                	test   %al,%al
    12ee:	74 10                	je     1300 <strcmp+0x40>
    12f0:	38 d8                	cmp    %bl,%al
    12f2:	74 ec                	je     12e0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    12f4:	29 d8                	sub    %ebx,%eax
}
    12f6:	5b                   	pop    %ebx
    12f7:	5d                   	pop    %ebp
    12f8:	c3                   	ret    
    12f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1300:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    1302:	29 d8                	sub    %ebx,%eax
}
    1304:	5b                   	pop    %ebx
    1305:	5d                   	pop    %ebp
    1306:	c3                   	ret    
    1307:	89 f6                	mov    %esi,%esi
    1309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001310 <strlen>:

uint
strlen(const char *s)
{
    1310:	55                   	push   %ebp
    1311:	89 e5                	mov    %esp,%ebp
    1313:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1316:	80 39 00             	cmpb   $0x0,(%ecx)
    1319:	74 15                	je     1330 <strlen+0x20>
    131b:	31 d2                	xor    %edx,%edx
    131d:	8d 76 00             	lea    0x0(%esi),%esi
    1320:	83 c2 01             	add    $0x1,%edx
    1323:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1327:	89 d0                	mov    %edx,%eax
    1329:	75 f5                	jne    1320 <strlen+0x10>
    ;
  return n;
}
    132b:	5d                   	pop    %ebp
    132c:	c3                   	ret    
    132d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    1330:	31 c0                	xor    %eax,%eax
}
    1332:	5d                   	pop    %ebp
    1333:	c3                   	ret    
    1334:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    133a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001340 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1340:	55                   	push   %ebp
    1341:	89 e5                	mov    %esp,%ebp
    1343:	57                   	push   %edi
    1344:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1347:	8b 4d 10             	mov    0x10(%ebp),%ecx
    134a:	8b 45 0c             	mov    0xc(%ebp),%eax
    134d:	89 d7                	mov    %edx,%edi
    134f:	fc                   	cld    
    1350:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1352:	89 d0                	mov    %edx,%eax
    1354:	5f                   	pop    %edi
    1355:	5d                   	pop    %ebp
    1356:	c3                   	ret    
    1357:	89 f6                	mov    %esi,%esi
    1359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001360 <strchr>:

char*
strchr(const char *s, char c)
{
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
    1363:	53                   	push   %ebx
    1364:	8b 45 08             	mov    0x8(%ebp),%eax
    1367:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    136a:	0f b6 10             	movzbl (%eax),%edx
    136d:	84 d2                	test   %dl,%dl
    136f:	74 1d                	je     138e <strchr+0x2e>
    if(*s == c)
    1371:	38 d3                	cmp    %dl,%bl
    1373:	89 d9                	mov    %ebx,%ecx
    1375:	75 0d                	jne    1384 <strchr+0x24>
    1377:	eb 17                	jmp    1390 <strchr+0x30>
    1379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1380:	38 ca                	cmp    %cl,%dl
    1382:	74 0c                	je     1390 <strchr+0x30>
  for(; *s; s++)
    1384:	83 c0 01             	add    $0x1,%eax
    1387:	0f b6 10             	movzbl (%eax),%edx
    138a:	84 d2                	test   %dl,%dl
    138c:	75 f2                	jne    1380 <strchr+0x20>
      return (char*)s;
  return 0;
    138e:	31 c0                	xor    %eax,%eax
}
    1390:	5b                   	pop    %ebx
    1391:	5d                   	pop    %ebp
    1392:	c3                   	ret    
    1393:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000013a0 <gets>:

char*
gets(char *buf, int max)
{
    13a0:	55                   	push   %ebp
    13a1:	89 e5                	mov    %esp,%ebp
    13a3:	57                   	push   %edi
    13a4:	56                   	push   %esi
    13a5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    13a6:	31 f6                	xor    %esi,%esi
    13a8:	89 f3                	mov    %esi,%ebx
{
    13aa:	83 ec 1c             	sub    $0x1c,%esp
    13ad:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    13b0:	eb 2f                	jmp    13e1 <gets+0x41>
    13b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    13b8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    13bb:	83 ec 04             	sub    $0x4,%esp
    13be:	6a 01                	push   $0x1
    13c0:	50                   	push   %eax
    13c1:	6a 00                	push   $0x0
    13c3:	e8 32 01 00 00       	call   14fa <read>
    if(cc < 1)
    13c8:	83 c4 10             	add    $0x10,%esp
    13cb:	85 c0                	test   %eax,%eax
    13cd:	7e 1c                	jle    13eb <gets+0x4b>
      break;
    buf[i++] = c;
    13cf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    13d3:	83 c7 01             	add    $0x1,%edi
    13d6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    13d9:	3c 0a                	cmp    $0xa,%al
    13db:	74 23                	je     1400 <gets+0x60>
    13dd:	3c 0d                	cmp    $0xd,%al
    13df:	74 1f                	je     1400 <gets+0x60>
  for(i=0; i+1 < max; ){
    13e1:	83 c3 01             	add    $0x1,%ebx
    13e4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    13e7:	89 fe                	mov    %edi,%esi
    13e9:	7c cd                	jl     13b8 <gets+0x18>
    13eb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    13ed:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    13f0:	c6 03 00             	movb   $0x0,(%ebx)
}
    13f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    13f6:	5b                   	pop    %ebx
    13f7:	5e                   	pop    %esi
    13f8:	5f                   	pop    %edi
    13f9:	5d                   	pop    %ebp
    13fa:	c3                   	ret    
    13fb:	90                   	nop
    13fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1400:	8b 75 08             	mov    0x8(%ebp),%esi
    1403:	8b 45 08             	mov    0x8(%ebp),%eax
    1406:	01 de                	add    %ebx,%esi
    1408:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    140a:	c6 03 00             	movb   $0x0,(%ebx)
}
    140d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1410:	5b                   	pop    %ebx
    1411:	5e                   	pop    %esi
    1412:	5f                   	pop    %edi
    1413:	5d                   	pop    %ebp
    1414:	c3                   	ret    
    1415:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001420 <stat>:
//   return filesteal();
// }

int
stat(const char *n, struct stat *st)
{
    1420:	55                   	push   %ebp
    1421:	89 e5                	mov    %esp,%ebp
    1423:	56                   	push   %esi
    1424:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1425:	83 ec 08             	sub    $0x8,%esp
    1428:	6a 00                	push   $0x0
    142a:	ff 75 08             	pushl  0x8(%ebp)
    142d:	e8 f8 00 00 00       	call   152a <open>
  if(fd < 0)
    1432:	83 c4 10             	add    $0x10,%esp
    1435:	85 c0                	test   %eax,%eax
    1437:	78 27                	js     1460 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1439:	83 ec 08             	sub    $0x8,%esp
    143c:	ff 75 0c             	pushl  0xc(%ebp)
    143f:	89 c3                	mov    %eax,%ebx
    1441:	50                   	push   %eax
    1442:	e8 fb 00 00 00       	call   1542 <fstat>
  close(fd);
    1447:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    144a:	89 c6                	mov    %eax,%esi
  close(fd);
    144c:	e8 c1 00 00 00       	call   1512 <close>
  return r;
    1451:	83 c4 10             	add    $0x10,%esp
}
    1454:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1457:	89 f0                	mov    %esi,%eax
    1459:	5b                   	pop    %ebx
    145a:	5e                   	pop    %esi
    145b:	5d                   	pop    %ebp
    145c:	c3                   	ret    
    145d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1460:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1465:	eb ed                	jmp    1454 <stat+0x34>
    1467:	89 f6                	mov    %esi,%esi
    1469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001470 <atoi>:

int
atoi(const char *s)
{
    1470:	55                   	push   %ebp
    1471:	89 e5                	mov    %esp,%ebp
    1473:	53                   	push   %ebx
    1474:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1477:	0f be 11             	movsbl (%ecx),%edx
    147a:	8d 42 d0             	lea    -0x30(%edx),%eax
    147d:	3c 09                	cmp    $0x9,%al
  n = 0;
    147f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    1484:	77 1f                	ja     14a5 <atoi+0x35>
    1486:	8d 76 00             	lea    0x0(%esi),%esi
    1489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1490:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1493:	83 c1 01             	add    $0x1,%ecx
    1496:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    149a:	0f be 11             	movsbl (%ecx),%edx
    149d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    14a0:	80 fb 09             	cmp    $0x9,%bl
    14a3:	76 eb                	jbe    1490 <atoi+0x20>
  return n;
}
    14a5:	5b                   	pop    %ebx
    14a6:	5d                   	pop    %ebp
    14a7:	c3                   	ret    
    14a8:	90                   	nop
    14a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000014b0 <memmove>:


void*
memmove(void *vdst, const void *vsrc, int n)
{
    14b0:	55                   	push   %ebp
    14b1:	89 e5                	mov    %esp,%ebp
    14b3:	56                   	push   %esi
    14b4:	53                   	push   %ebx
    14b5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    14b8:	8b 45 08             	mov    0x8(%ebp),%eax
    14bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    14be:	85 db                	test   %ebx,%ebx
    14c0:	7e 14                	jle    14d6 <memmove+0x26>
    14c2:	31 d2                	xor    %edx,%edx
    14c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    14c8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    14cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    14cf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    14d2:	39 d3                	cmp    %edx,%ebx
    14d4:	75 f2                	jne    14c8 <memmove+0x18>
  return vdst;
}
    14d6:	5b                   	pop    %ebx
    14d7:	5e                   	pop    %esi
    14d8:	5d                   	pop    %ebp
    14d9:	c3                   	ret    

000014da <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    14da:	b8 01 00 00 00       	mov    $0x1,%eax
    14df:	cd 40                	int    $0x40
    14e1:	c3                   	ret    

000014e2 <exit>:
SYSCALL(exit)
    14e2:	b8 02 00 00 00       	mov    $0x2,%eax
    14e7:	cd 40                	int    $0x40
    14e9:	c3                   	ret    

000014ea <wait>:
SYSCALL(wait)
    14ea:	b8 03 00 00 00       	mov    $0x3,%eax
    14ef:	cd 40                	int    $0x40
    14f1:	c3                   	ret    

000014f2 <pipe>:
SYSCALL(pipe)
    14f2:	b8 04 00 00 00       	mov    $0x4,%eax
    14f7:	cd 40                	int    $0x40
    14f9:	c3                   	ret    

000014fa <read>:
SYSCALL(read)
    14fa:	b8 05 00 00 00       	mov    $0x5,%eax
    14ff:	cd 40                	int    $0x40
    1501:	c3                   	ret    

00001502 <steal>:
SYSCALL(steal)
    1502:	b8 17 00 00 00       	mov    $0x17,%eax
    1507:	cd 40                	int    $0x40
    1509:	c3                   	ret    

0000150a <write>:
SYSCALL(write)
    150a:	b8 10 00 00 00       	mov    $0x10,%eax
    150f:	cd 40                	int    $0x40
    1511:	c3                   	ret    

00001512 <close>:
SYSCALL(close)
    1512:	b8 15 00 00 00       	mov    $0x15,%eax
    1517:	cd 40                	int    $0x40
    1519:	c3                   	ret    

0000151a <kill>:
SYSCALL(kill)
    151a:	b8 06 00 00 00       	mov    $0x6,%eax
    151f:	cd 40                	int    $0x40
    1521:	c3                   	ret    

00001522 <exec>:
SYSCALL(exec)
    1522:	b8 07 00 00 00       	mov    $0x7,%eax
    1527:	cd 40                	int    $0x40
    1529:	c3                   	ret    

0000152a <open>:
SYSCALL(open)
    152a:	b8 0f 00 00 00       	mov    $0xf,%eax
    152f:	cd 40                	int    $0x40
    1531:	c3                   	ret    

00001532 <mknod>:
SYSCALL(mknod)
    1532:	b8 11 00 00 00       	mov    $0x11,%eax
    1537:	cd 40                	int    $0x40
    1539:	c3                   	ret    

0000153a <unlink>:
SYSCALL(unlink)
    153a:	b8 12 00 00 00       	mov    $0x12,%eax
    153f:	cd 40                	int    $0x40
    1541:	c3                   	ret    

00001542 <fstat>:
SYSCALL(fstat)
    1542:	b8 08 00 00 00       	mov    $0x8,%eax
    1547:	cd 40                	int    $0x40
    1549:	c3                   	ret    

0000154a <link>:
SYSCALL(link)
    154a:	b8 13 00 00 00       	mov    $0x13,%eax
    154f:	cd 40                	int    $0x40
    1551:	c3                   	ret    

00001552 <mkdir>:
SYSCALL(mkdir)
    1552:	b8 14 00 00 00       	mov    $0x14,%eax
    1557:	cd 40                	int    $0x40
    1559:	c3                   	ret    

0000155a <chdir>:
SYSCALL(chdir)
    155a:	b8 09 00 00 00       	mov    $0x9,%eax
    155f:	cd 40                	int    $0x40
    1561:	c3                   	ret    

00001562 <dup>:
SYSCALL(dup)
    1562:	b8 0a 00 00 00       	mov    $0xa,%eax
    1567:	cd 40                	int    $0x40
    1569:	c3                   	ret    

0000156a <getpid>:
SYSCALL(getpid)
    156a:	b8 0b 00 00 00       	mov    $0xb,%eax
    156f:	cd 40                	int    $0x40
    1571:	c3                   	ret    

00001572 <sbrk>:
SYSCALL(sbrk)
    1572:	b8 0c 00 00 00       	mov    $0xc,%eax
    1577:	cd 40                	int    $0x40
    1579:	c3                   	ret    

0000157a <sleep>:
SYSCALL(sleep)
    157a:	b8 0d 00 00 00       	mov    $0xd,%eax
    157f:	cd 40                	int    $0x40
    1581:	c3                   	ret    

00001582 <uptime>:
SYSCALL(uptime)
    1582:	b8 0e 00 00 00       	mov    $0xe,%eax
    1587:	cd 40                	int    $0x40
    1589:	c3                   	ret    

0000158a <cpuhalt>:
SYSCALL(cpuhalt)
    158a:	b8 16 00 00 00       	mov    $0x16,%eax
    158f:	cd 40                	int    $0x40
    1591:	c3                   	ret    
    1592:	66 90                	xchg   %ax,%ax
    1594:	66 90                	xchg   %ax,%ax
    1596:	66 90                	xchg   %ax,%ax
    1598:	66 90                	xchg   %ax,%ax
    159a:	66 90                	xchg   %ax,%ax
    159c:	66 90                	xchg   %ax,%ax
    159e:	66 90                	xchg   %ax,%ax

000015a0 <printint.constprop.1>:
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
}

static void
printint(int fd, int xx, int base, int sgn)
    15a0:	55                   	push   %ebp
    15a1:	89 e5                	mov    %esp,%ebp
    15a3:	57                   	push   %edi
    15a4:	56                   	push   %esi
    15a5:	53                   	push   %ebx
    15a6:	89 d6                	mov    %edx,%esi
    15a8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    15ab:	85 c0                	test   %eax,%eax
    15ad:	79 71                	jns    1620 <printint.constprop.1+0x80>
    15af:	83 e1 01             	and    $0x1,%ecx
    15b2:	74 6c                	je     1620 <printint.constprop.1+0x80>
    neg = 1;
    x = -xx;
    15b4:	f7 d8                	neg    %eax
    neg = 1;
    15b6:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    15bd:	31 c9                	xor    %ecx,%ecx
    15bf:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    15c2:	eb 06                	jmp    15ca <printint.constprop.1+0x2a>
    15c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    15c8:	89 f9                	mov    %edi,%ecx
    15ca:	31 d2                	xor    %edx,%edx
    15cc:	8d 79 01             	lea    0x1(%ecx),%edi
    15cf:	f7 f6                	div    %esi
    15d1:	0f b6 92 20 1e 00 00 	movzbl 0x1e20(%edx),%edx
  }while((x /= base) != 0);
    15d8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    15da:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    15dd:	75 e9                	jne    15c8 <printint.constprop.1+0x28>
  if(neg)
    15df:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    15e2:	85 c0                	test   %eax,%eax
    15e4:	74 08                	je     15ee <printint.constprop.1+0x4e>
    buf[i++] = '-';
    15e6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    15eb:	8d 79 02             	lea    0x2(%ecx),%edi
    15ee:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    15f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    15f8:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    15fb:	83 ec 04             	sub    $0x4,%esp
    15fe:	83 ee 01             	sub    $0x1,%esi
    1601:	6a 01                	push   $0x1
    1603:	53                   	push   %ebx
    1604:	6a 01                	push   $0x1
    1606:	88 45 d7             	mov    %al,-0x29(%ebp)
    1609:	e8 fc fe ff ff       	call   150a <write>

  while(--i >= 0)
    160e:	83 c4 10             	add    $0x10,%esp
    1611:	39 de                	cmp    %ebx,%esi
    1613:	75 e3                	jne    15f8 <printint.constprop.1+0x58>
    putc(fd, buf[i]);
}
    1615:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1618:	5b                   	pop    %ebx
    1619:	5e                   	pop    %esi
    161a:	5f                   	pop    %edi
    161b:	5d                   	pop    %ebp
    161c:	c3                   	ret    
    161d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
    1620:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1627:	eb 94                	jmp    15bd <printint.constprop.1+0x1d>
    1629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001630 <vprintf.constprop.0>:
static void vprintf(int fd, const char *fmt, va_list ap)
    1630:	55                   	push   %ebp
    1631:	89 e5                	mov    %esp,%ebp
    1633:	57                   	push   %edi
    1634:	56                   	push   %esi
    1635:	53                   	push   %ebx
    1636:	89 d6                	mov    %edx,%esi
    1638:	83 ec 2c             	sub    $0x2c,%esp
{
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    163b:	0f b6 10             	movzbl (%eax),%edx
    163e:	84 d2                	test   %dl,%dl
    1640:	0f 84 cd 00 00 00    	je     1713 <vprintf.constprop.0+0xe3>
    1646:	8d 58 01             	lea    0x1(%eax),%ebx
  state = 0;
    1649:	31 ff                	xor    %edi,%edi
    164b:	eb 31                	jmp    167e <vprintf.constprop.0+0x4e>
    164d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1650:	83 f8 25             	cmp    $0x25,%eax
    1653:	0f 84 c7 00 00 00    	je     1720 <vprintf.constprop.0+0xf0>
  write(fd, &c, 1);
    1659:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    165c:	83 ec 04             	sub    $0x4,%esp
    165f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
    1662:	6a 01                	push   $0x1
    1664:	50                   	push   %eax
    1665:	6a 01                	push   $0x1
    1667:	e8 9e fe ff ff       	call   150a <write>
    166c:	83 c4 10             	add    $0x10,%esp
    166f:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
    1672:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1676:	84 d2                	test   %dl,%dl
    1678:	0f 84 95 00 00 00    	je     1713 <vprintf.constprop.0+0xe3>
    if(state == 0){
    167e:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    1680:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    1683:	74 cb                	je     1650 <vprintf.constprop.0+0x20>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1685:	83 ff 25             	cmp    $0x25,%edi
    1688:	75 e5                	jne    166f <vprintf.constprop.0+0x3f>
      if(c == 'd'){
    168a:	83 f8 64             	cmp    $0x64,%eax
        printint(fd, va_arg(ap, int), 10, 1);
    168d:	8d 7e 04             	lea    0x4(%esi),%edi
    1690:	b9 01 00 00 00       	mov    $0x1,%ecx
      if(c == 'd'){
    1695:	0f 84 9a 00 00 00    	je     1735 <vprintf.constprop.0+0x105>
      } else if(c == 'l') {
    169b:	83 f8 6c             	cmp    $0x6c,%eax
    169e:	0f 84 8c 00 00 00    	je     1730 <vprintf.constprop.0+0x100>
        printint(fd, va_arg(ap, uint), 10, 0);
      } else if(c == 'x') {
    16a4:	83 f8 78             	cmp    $0x78,%eax
    16a7:	0f 84 a3 00 00 00    	je     1750 <vprintf.constprop.0+0x120>
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    16ad:	83 f8 70             	cmp    $0x70,%eax
    16b0:	0f 84 ca 00 00 00    	je     1780 <vprintf.constprop.0+0x150>
        printptr(fd, va_arg(ap, uint));
      } else if(c == 's'){
    16b6:	83 f8 73             	cmp    $0x73,%eax
    16b9:	0f 84 39 01 00 00    	je     17f8 <vprintf.constprop.0+0x1c8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    16bf:	83 f8 63             	cmp    $0x63,%eax
    16c2:	0f 84 68 01 00 00    	je     1830 <vprintf.constprop.0+0x200>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    16c8:	83 f8 25             	cmp    $0x25,%eax
    16cb:	0f 84 9f 00 00 00    	je     1770 <vprintf.constprop.0+0x140>
  write(fd, &c, 1);
    16d1:	8d 45 df             	lea    -0x21(%ebp),%eax
    16d4:	83 ec 04             	sub    $0x4,%esp
    16d7:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    16da:	6a 01                	push   $0x1
    16dc:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
    16e0:	50                   	push   %eax
    16e1:	6a 01                	push   $0x1
    16e3:	e8 22 fe ff ff       	call   150a <write>
    16e8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    16ec:	83 c4 0c             	add    $0xc,%esp
    16ef:	8d 45 e0             	lea    -0x20(%ebp),%eax
    16f2:	6a 01                	push   $0x1
    16f4:	88 55 e0             	mov    %dl,-0x20(%ebp)
    16f7:	50                   	push   %eax
    16f8:	6a 01                	push   $0x1
    16fa:	83 c3 01             	add    $0x1,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    16fd:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    16ff:	e8 06 fe ff ff       	call   150a <write>
  for(i = 0; fmt[i]; i++){
    1704:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
  write(fd, &c, 1);
    1708:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    170b:	84 d2                	test   %dl,%dl
    170d:	0f 85 6b ff ff ff    	jne    167e <vprintf.constprop.0+0x4e>
    }
  }
}
    1713:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1716:	5b                   	pop    %ebx
    1717:	5e                   	pop    %esi
    1718:	5f                   	pop    %edi
    1719:	5d                   	pop    %ebp
    171a:	c3                   	ret    
    171b:	90                   	nop
    171c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        state = '%';
    1720:	bf 25 00 00 00       	mov    $0x25,%edi
    1725:	e9 45 ff ff ff       	jmp    166f <vprintf.constprop.0+0x3f>
    172a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, uint), 10, 0);
    1730:	8d 7e 04             	lea    0x4(%esi),%edi
    1733:	31 c9                	xor    %ecx,%ecx
    1735:	8b 06                	mov    (%esi),%eax
    1737:	ba 0a 00 00 00       	mov    $0xa,%edx
    173c:	89 fe                	mov    %edi,%esi
      state = 0;
    173e:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, uint), 10, 0);
    1740:	e8 5b fe ff ff       	call   15a0 <printint.constprop.1>
    1745:	e9 25 ff ff ff       	jmp    166f <vprintf.constprop.0+0x3f>
    174a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, va_arg(ap, int), 16, 0);
    1750:	8b 06                	mov    (%esi),%eax
    1752:	8d 7e 04             	lea    0x4(%esi),%edi
    1755:	31 c9                	xor    %ecx,%ecx
    1757:	ba 10 00 00 00       	mov    $0x10,%edx
    175c:	89 fe                	mov    %edi,%esi
      state = 0;
    175e:	31 ff                	xor    %edi,%edi
        printint(fd, va_arg(ap, int), 16, 0);
    1760:	e8 3b fe ff ff       	call   15a0 <printint.constprop.1>
    1765:	e9 05 ff ff ff       	jmp    166f <vprintf.constprop.0+0x3f>
    176a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1770:	83 ec 04             	sub    $0x4,%esp
    1773:	88 55 e1             	mov    %dl,-0x1f(%ebp)
    1776:	8d 45 e1             	lea    -0x1f(%ebp),%eax
    1779:	6a 01                	push   $0x1
    177b:	e9 77 ff ff ff       	jmp    16f7 <vprintf.constprop.0+0xc7>
        printptr(fd, va_arg(ap, uint));
    1780:	8d 46 04             	lea    0x4(%esi),%eax
  write(fd, &c, 1);
    1783:	83 ec 04             	sub    $0x4,%esp
        printptr(fd, va_arg(ap, uint));
    1786:	8b 3e                	mov    (%esi),%edi
  write(fd, &c, 1);
    1788:	6a 01                	push   $0x1
    178a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
    178e:	be 08 00 00 00       	mov    $0x8,%esi
        printptr(fd, va_arg(ap, uint));
    1793:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
    1796:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1799:	50                   	push   %eax
    179a:	6a 01                	push   $0x1
    179c:	e8 69 fd ff ff       	call   150a <write>
    17a1:	8d 45 e7             	lea    -0x19(%ebp),%eax
    17a4:	83 c4 0c             	add    $0xc,%esp
    17a7:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
    17ab:	6a 01                	push   $0x1
    17ad:	50                   	push   %eax
    17ae:	6a 01                	push   $0x1
    17b0:	e8 55 fd ff ff       	call   150a <write>
    17b5:	83 c4 10             	add    $0x10,%esp
    17b8:	90                   	nop
    17b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    17c0:	89 f8                	mov    %edi,%eax
  write(fd, &c, 1);
    17c2:	83 ec 04             	sub    $0x4,%esp
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    17c5:	c1 e7 04             	shl    $0x4,%edi
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    17c8:	c1 e8 1c             	shr    $0x1c,%eax
  write(fd, &c, 1);
    17cb:	6a 01                	push   $0x1
    17cd:	0f b6 80 20 1e 00 00 	movzbl 0x1e20(%eax),%eax
    17d4:	88 45 e5             	mov    %al,-0x1b(%ebp)
    17d7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    17da:	50                   	push   %eax
    17db:	6a 01                	push   $0x1
    17dd:	e8 28 fd ff ff       	call   150a <write>
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    17e2:	83 c4 10             	add    $0x10,%esp
    17e5:	83 ee 01             	sub    $0x1,%esi
    17e8:	75 d6                	jne    17c0 <vprintf.constprop.0+0x190>
        s = va_arg(ap, char*);
    17ea:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
    17ed:	31 ff                	xor    %edi,%edi
    17ef:	e9 7b fe ff ff       	jmp    166f <vprintf.constprop.0+0x3f>
    17f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = va_arg(ap, char*);
    17f8:	8b 3e                	mov    (%esi),%edi
    17fa:	8d 46 04             	lea    0x4(%esi),%eax
    17fd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    1800:	85 ff                	test   %edi,%edi
    1802:	74 50                	je     1854 <vprintf.constprop.0+0x224>
        while(*s != 0){
    1804:	0f b6 07             	movzbl (%edi),%eax
    1807:	84 c0                	test   %al,%al
    1809:	74 df                	je     17ea <vprintf.constprop.0+0x1ba>
    180b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
    180e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
    1810:	83 ec 04             	sub    $0x4,%esp
          s++;
    1813:	83 c7 01             	add    $0x1,%edi
    1816:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1819:	6a 01                	push   $0x1
    181b:	56                   	push   %esi
    181c:	6a 01                	push   $0x1
    181e:	e8 e7 fc ff ff       	call   150a <write>
        while(*s != 0){
    1823:	0f b6 07             	movzbl (%edi),%eax
    1826:	83 c4 10             	add    $0x10,%esp
    1829:	84 c0                	test   %al,%al
    182b:	75 e3                	jne    1810 <vprintf.constprop.0+0x1e0>
    182d:	eb bb                	jmp    17ea <vprintf.constprop.0+0x1ba>
    182f:	90                   	nop
        putc(fd, va_arg(ap, uint));
    1830:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
    1832:	83 ec 04             	sub    $0x4,%esp
        putc(fd, va_arg(ap, uint));
    1835:	8d 7e 04             	lea    0x4(%esi),%edi
  write(fd, &c, 1);
    1838:	6a 01                	push   $0x1
        putc(fd, va_arg(ap, uint));
    183a:	89 fe                	mov    %edi,%esi
      state = 0;
    183c:	31 ff                	xor    %edi,%edi
        putc(fd, va_arg(ap, uint));
    183e:	88 45 e2             	mov    %al,-0x1e(%ebp)
  write(fd, &c, 1);
    1841:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1844:	50                   	push   %eax
    1845:	6a 01                	push   $0x1
    1847:	e8 be fc ff ff       	call   150a <write>
    184c:	83 c4 10             	add    $0x10,%esp
    184f:	e9 1b fe ff ff       	jmp    166f <vprintf.constprop.0+0x3f>
          s = "(null)";
    1854:	bf 17 1e 00 00       	mov    $0x1e17,%edi
        while(*s != 0){
    1859:	b8 28 00 00 00       	mov    $0x28,%eax
    185e:	eb ab                	jmp    180b <vprintf.constprop.0+0x1db>

00001860 <fprintf>:
// Print to the given fd. Only understands %d,%x, %p, %s, %c.
void
fprintf(int fd, const char *fmt, ...)
{
    1860:	55                   	push   %ebp
    1861:	89 e5                	mov    %esp,%ebp
    1863:	83 ec 08             	sub    $0x8,%esp
 va_list ap;
 va_start(ap, fmt); 
 vprintf(1,fmt,ap);
    1866:	8b 45 0c             	mov    0xc(%ebp),%eax
    1869:	8d 55 10             	lea    0x10(%ebp),%edx
    186c:	e8 bf fd ff ff       	call   1630 <vprintf.constprop.0>
}
    1871:	c9                   	leave  
    1872:	c3                   	ret    
    1873:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001880 <printf>:
void
printf(const char *fmt, ...)
{
    1880:	55                   	push   %ebp
    1881:	89 e5                	mov    %esp,%ebp
    1883:	83 ec 08             	sub    $0x8,%esp
  va_list ap;
  va_start(ap, fmt); 
  vprintf(1,fmt,ap);
    1886:	8b 45 08             	mov    0x8(%ebp),%eax
    1889:	8d 55 0c             	lea    0xc(%ebp),%edx
    188c:	e8 9f fd ff ff       	call   1630 <vprintf.constprop.0>
}
    1891:	c9                   	leave  
    1892:	c3                   	ret    
    1893:	66 90                	xchg   %ax,%ax
    1895:	66 90                	xchg   %ax,%ax
    1897:	66 90                	xchg   %ax,%ax
    1899:	66 90                	xchg   %ax,%ax
    189b:	66 90                	xchg   %ax,%ax
    189d:	66 90                	xchg   %ax,%ax
    189f:	90                   	nop

000018a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    18a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18a1:	a1 cc 27 00 00       	mov    0x27cc,%eax
{
    18a6:	89 e5                	mov    %esp,%ebp
    18a8:	57                   	push   %edi
    18a9:	56                   	push   %esi
    18aa:	53                   	push   %ebx
    18ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    18ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    18b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18b8:	39 c8                	cmp    %ecx,%eax
    18ba:	8b 10                	mov    (%eax),%edx
    18bc:	73 32                	jae    18f0 <free+0x50>
    18be:	39 d1                	cmp    %edx,%ecx
    18c0:	72 04                	jb     18c6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    18c2:	39 d0                	cmp    %edx,%eax
    18c4:	72 32                	jb     18f8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    18c6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    18c9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    18cc:	39 fa                	cmp    %edi,%edx
    18ce:	74 30                	je     1900 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    18d0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    18d3:	8b 50 04             	mov    0x4(%eax),%edx
    18d6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    18d9:	39 f1                	cmp    %esi,%ecx
    18db:	74 3a                	je     1917 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    18dd:	89 08                	mov    %ecx,(%eax)
  freep = p;
    18df:	a3 cc 27 00 00       	mov    %eax,0x27cc
}
    18e4:	5b                   	pop    %ebx
    18e5:	5e                   	pop    %esi
    18e6:	5f                   	pop    %edi
    18e7:	5d                   	pop    %ebp
    18e8:	c3                   	ret    
    18e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    18f0:	39 d0                	cmp    %edx,%eax
    18f2:	72 04                	jb     18f8 <free+0x58>
    18f4:	39 d1                	cmp    %edx,%ecx
    18f6:	72 ce                	jb     18c6 <free+0x26>
{
    18f8:	89 d0                	mov    %edx,%eax
    18fa:	eb bc                	jmp    18b8 <free+0x18>
    18fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1900:	03 72 04             	add    0x4(%edx),%esi
    1903:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1906:	8b 10                	mov    (%eax),%edx
    1908:	8b 12                	mov    (%edx),%edx
    190a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    190d:	8b 50 04             	mov    0x4(%eax),%edx
    1910:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1913:	39 f1                	cmp    %esi,%ecx
    1915:	75 c6                	jne    18dd <free+0x3d>
    p->s.size += bp->s.size;
    1917:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    191a:	a3 cc 27 00 00       	mov    %eax,0x27cc
    p->s.size += bp->s.size;
    191f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1922:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1925:	89 10                	mov    %edx,(%eax)
}
    1927:	5b                   	pop    %ebx
    1928:	5e                   	pop    %esi
    1929:	5f                   	pop    %edi
    192a:	5d                   	pop    %ebp
    192b:	c3                   	ret    
    192c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001930 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1930:	55                   	push   %ebp
    1931:	89 e5                	mov    %esp,%ebp
    1933:	57                   	push   %edi
    1934:	56                   	push   %esi
    1935:	53                   	push   %ebx
    1936:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1939:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    193c:	8b 15 cc 27 00 00    	mov    0x27cc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1942:	8d 78 07             	lea    0x7(%eax),%edi
    1945:	c1 ef 03             	shr    $0x3,%edi
    1948:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    194b:	85 d2                	test   %edx,%edx
    194d:	0f 84 9d 00 00 00    	je     19f0 <malloc+0xc0>
    1953:	8b 02                	mov    (%edx),%eax
    1955:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1958:	39 cf                	cmp    %ecx,%edi
    195a:	76 6c                	jbe    19c8 <malloc+0x98>
    195c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1962:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1967:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    196a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1971:	eb 0e                	jmp    1981 <malloc+0x51>
    1973:	90                   	nop
    1974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1978:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    197a:	8b 48 04             	mov    0x4(%eax),%ecx
    197d:	39 f9                	cmp    %edi,%ecx
    197f:	73 47                	jae    19c8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1981:	39 05 cc 27 00 00    	cmp    %eax,0x27cc
    1987:	89 c2                	mov    %eax,%edx
    1989:	75 ed                	jne    1978 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    198b:	83 ec 0c             	sub    $0xc,%esp
    198e:	56                   	push   %esi
    198f:	e8 de fb ff ff       	call   1572 <sbrk>
  if(p == (char*)-1)
    1994:	83 c4 10             	add    $0x10,%esp
    1997:	83 f8 ff             	cmp    $0xffffffff,%eax
    199a:	74 1c                	je     19b8 <malloc+0x88>
  hp->s.size = nu;
    199c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    199f:	83 ec 0c             	sub    $0xc,%esp
    19a2:	83 c0 08             	add    $0x8,%eax
    19a5:	50                   	push   %eax
    19a6:	e8 f5 fe ff ff       	call   18a0 <free>
  return freep;
    19ab:	8b 15 cc 27 00 00    	mov    0x27cc,%edx
      if((p = morecore(nunits)) == 0)
    19b1:	83 c4 10             	add    $0x10,%esp
    19b4:	85 d2                	test   %edx,%edx
    19b6:	75 c0                	jne    1978 <malloc+0x48>
        return 0;
  }
}
    19b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    19bb:	31 c0                	xor    %eax,%eax
}
    19bd:	5b                   	pop    %ebx
    19be:	5e                   	pop    %esi
    19bf:	5f                   	pop    %edi
    19c0:	5d                   	pop    %ebp
    19c1:	c3                   	ret    
    19c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    19c8:	39 cf                	cmp    %ecx,%edi
    19ca:	74 54                	je     1a20 <malloc+0xf0>
        p->s.size -= nunits;
    19cc:	29 f9                	sub    %edi,%ecx
    19ce:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    19d1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    19d4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    19d7:	89 15 cc 27 00 00    	mov    %edx,0x27cc
}
    19dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    19e0:	83 c0 08             	add    $0x8,%eax
}
    19e3:	5b                   	pop    %ebx
    19e4:	5e                   	pop    %esi
    19e5:	5f                   	pop    %edi
    19e6:	5d                   	pop    %ebp
    19e7:	c3                   	ret    
    19e8:	90                   	nop
    19e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    19f0:	c7 05 cc 27 00 00 d0 	movl   $0x27d0,0x27cc
    19f7:	27 00 00 
    19fa:	c7 05 d0 27 00 00 d0 	movl   $0x27d0,0x27d0
    1a01:	27 00 00 
    base.s.size = 0;
    1a04:	b8 d0 27 00 00       	mov    $0x27d0,%eax
    1a09:	c7 05 d4 27 00 00 00 	movl   $0x0,0x27d4
    1a10:	00 00 00 
    1a13:	e9 44 ff ff ff       	jmp    195c <malloc+0x2c>
    1a18:	90                   	nop
    1a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1a20:	8b 08                	mov    (%eax),%ecx
    1a22:	89 0a                	mov    %ecx,(%edx)
    1a24:	eb b1                	jmp    19d7 <malloc+0xa7>
