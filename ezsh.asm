
user/_ezsh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
int getLine(int in, char line[], int max);
int split(char dest[MAXARGS][ARGLEN], char line[], char delim[]);
void substr(char* dest, char* str, int start, int end);
int find(char* str, char delim[], int nth);

int main(int argc, char *args[]){
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	81 ec d8 01 00 00    	sub    $0x1d8,%esp
    if (argc > 1) {
  17:	83 39 01             	cmpl   $0x1,(%ecx)
  1a:	7e 13                	jle    2f <main+0x2f>
			fprintf(2, "ezsh takes no arguments");
  1c:	52                   	push   %edx
  1d:	52                   	push   %edx
  1e:	68 a8 0a 00 00       	push   $0xaa8
  23:	6a 02                	push   $0x2
  25:	e8 b6 08 00 00       	call   8e0 <fprintf>
    	exit();
  2a:	e8 43 05 00 00       	call   572 <exit>
		}
    
		int len;
		char line[MAXLINE];
		char input[MAXARGS][ARGLEN];
		fprintf(2, "\nEZ$ ");
  2f:	50                   	push   %eax
  30:	50                   	push   %eax
		while ((len = getLine(1, line, MAXLINE)) > 0) {
			argc = split(input, line, " ");
  31:	8d b5 20 fe ff ff    	lea    -0x1e0(%ebp),%esi
		fprintf(2, "\nEZ$ ");
  37:	68 c0 0a 00 00       	push   $0xac0
  3c:	6a 02                	push   $0x2
  3e:	e8 9d 08 00 00       	call   8e0 <fprintf>
		while ((len = getLine(1, line, MAXLINE)) > 0) {
  43:	83 c4 10             	add    $0x10,%esp
  46:	8d 76 00             	lea    0x0(%esi),%esi
  49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  50:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
  56:	83 ec 04             	sub    $0x4,%esp
  59:	68 00 01 00 00       	push   $0x100
  5e:	50                   	push   %eax
  5f:	6a 01                	push   $0x1
  61:	e8 6a 00 00 00       	call   d0 <getLine>
  66:	83 c4 10             	add    $0x10,%esp
  69:	85 c0                	test   %eax,%eax
  6b:	7e 59                	jle    c6 <main+0xc6>
			argc = split(input, line, " ");
  6d:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
  73:	83 ec 04             	sub    $0x4,%esp
  76:	68 c4 0a 00 00       	push   $0xac4
  7b:	50                   	push   %eax
  7c:	56                   	push   %esi
  7d:	e8 ee 01 00 00       	call   270 <split>
			for (int argn = 0; argn < argc; argn++) {
  82:	83 c4 10             	add    $0x10,%esp
  85:	85 c0                	test   %eax,%eax
  87:	7e 29                	jle    b2 <main+0xb2>
  89:	8d 04 80             	lea    (%eax,%eax,4),%eax
  8c:	89 f7                	mov    %esi,%edi
  8e:	8d 1c 86             	lea    (%esi,%eax,4),%ebx
  91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
				fprintf(2, "%s\t\t", input[argn]);
  98:	83 ec 04             	sub    $0x4,%esp
  9b:	57                   	push   %edi
  9c:	68 c6 0a 00 00       	push   $0xac6
  a1:	83 c7 14             	add    $0x14,%edi
  a4:	6a 02                	push   $0x2
  a6:	e8 35 08 00 00       	call   8e0 <fprintf>
			for (int argn = 0; argn < argc; argn++) {
  ab:	83 c4 10             	add    $0x10,%esp
  ae:	39 df                	cmp    %ebx,%edi
  b0:	75 e6                	jne    98 <main+0x98>
			}
			
			fprintf(2, "\nEZ$ ");
  b2:	83 ec 08             	sub    $0x8,%esp
  b5:	68 c0 0a 00 00       	push   $0xac0
  ba:	6a 02                	push   $0x2
  bc:	e8 1f 08 00 00       	call   8e0 <fprintf>
  c1:	83 c4 10             	add    $0x10,%esp
  c4:	eb 8a                	jmp    50 <main+0x50>
		}
		
		
		exit();
  c6:	e8 a7 04 00 00       	call   572 <exit>
  cb:	66 90                	xchg   %ax,%ax
  cd:	66 90                	xchg   %ax,%ax
  cf:	90                   	nop

000000d0 <getLine>:
}

// gets line of input from "in", puts it in
// line and returns success signal
int getLine(int in, char line[], int max) {
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	57                   	push   %edi
  d4:	56                   	push   %esi
  d5:	53                   	push   %ebx
  d6:	83 ec 38             	sub    $0x38,%esp
  d9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  dc:	8b 7d 10             	mov    0x10(%ebp),%edi
  int len = strlen(line);
  df:	53                   	push   %ebx
  e0:	e8 bb 02 00 00       	call   3a0 <strlen>
  memset(line, 0, len);
  e5:	83 c4 0c             	add    $0xc,%esp
  e8:	50                   	push   %eax
  e9:	6a 00                	push   $0x0
  eb:	53                   	push   %ebx
  ec:	e8 df 02 00 00       	call   3d0 <memset>
  char c[1];
  int i;
  for (i = 0; i < max - 1; i++) {
  f1:	83 c4 10             	add    $0x10,%esp
  f4:	83 ff 01             	cmp    $0x1,%edi
  f7:	7e 77                	jle    170 <getLine+0xa0>
  f9:	8d 47 ff             	lea    -0x1(%edi),%eax
  fc:	31 f6                	xor    %esi,%esi
  fe:	8d 7d e7             	lea    -0x19(%ebp),%edi
 101:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 104:	eb 1d                	jmp    123 <getLine+0x53>
 106:	8d 76 00             	lea    0x0(%esi),%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if (read(in, c, 1) == 0) return strlen(line);
    if (*c == '\n') break;
 110:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 114:	3c 0a                	cmp    $0xa,%al
 116:	74 38                	je     150 <getLine+0x80>
    line[i] = *c;
 118:	88 04 33             	mov    %al,(%ebx,%esi,1)
  for (i = 0; i < max - 1; i++) {
 11b:	83 c6 01             	add    $0x1,%esi
 11e:	39 75 d4             	cmp    %esi,-0x2c(%ebp)
 121:	74 45                	je     168 <getLine+0x98>
    if (read(in, c, 1) == 0) return strlen(line);
 123:	83 ec 04             	sub    $0x4,%esp
 126:	6a 01                	push   $0x1
 128:	57                   	push   %edi
 129:	ff 75 08             	pushl  0x8(%ebp)
 12c:	e8 59 04 00 00       	call   58a <read>
 131:	83 c4 10             	add    $0x10,%esp
 134:	85 c0                	test   %eax,%eax
 136:	75 d8                	jne    110 <getLine+0x40>
 138:	83 ec 0c             	sub    $0xc,%esp
 13b:	53                   	push   %ebx
 13c:	e8 5f 02 00 00       	call   3a0 <strlen>
 141:	83 c4 10             	add    $0x10,%esp
  }
  line[i + 1] = '\0';
  return 1;
}
 144:	8d 65 f4             	lea    -0xc(%ebp),%esp
 147:	5b                   	pop    %ebx
 148:	5e                   	pop    %esi
 149:	5f                   	pop    %edi
 14a:	5d                   	pop    %ebp
 14b:	c3                   	ret    
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 150:	8d 56 01             	lea    0x1(%esi),%edx
  line[i + 1] = '\0';
 153:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
}
 157:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
 15a:	b8 01 00 00 00       	mov    $0x1,%eax
}
 15f:	5b                   	pop    %ebx
 160:	5e                   	pop    %esi
 161:	5f                   	pop    %edi
 162:	5d                   	pop    %ebp
 163:	c3                   	ret    
 164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 168:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 16b:	83 c2 01             	add    $0x1,%edx
 16e:	eb e3                	jmp    153 <getLine+0x83>
  for (i = 0; i < max - 1; i++) {
 170:	ba 01 00 00 00       	mov    $0x1,%edx
 175:	eb dc                	jmp    153 <getLine+0x83>
 177:	89 f6                	mov    %esi,%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000180 <find>:
	substr(dest[count++], line, prevpos, strlen(line));
	return count;
}

// finds nth beginning of delim in str, otherwise -1
int find(char* str, char delim[], int nth) {
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	57                   	push   %edi
 184:	56                   	push   %esi
 185:	53                   	push   %ebx
	int i, j;
  for (i = 0; i < strlen(str); i++) {
 186:	31 ff                	xor    %edi,%edi
int find(char* str, char delim[], int nth) {
 188:	83 ec 1c             	sub    $0x1c,%esp
    if (str[i] == delim[0]) {
			for (j = i + 1; j < (i + strlen(delim)); j++) {
				if (str[j] != delim[j - i]) goto out;
 18b:	8b 45 0c             	mov    0xc(%ebp),%eax
int find(char* str, char delim[], int nth) {
 18e:	8b 5d 08             	mov    0x8(%ebp),%ebx
				if (str[j] != delim[j - i]) goto out;
 191:	83 c0 01             	add    $0x1,%eax
 194:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for (i = 0; i < strlen(str); i++) {
 197:	eb 0a                	jmp    1a3 <find+0x23>
 199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1a0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 1a3:	83 ec 0c             	sub    $0xc,%esp
 1a6:	53                   	push   %ebx
 1a7:	e8 f4 01 00 00       	call   3a0 <strlen>
 1ac:	83 c4 10             	add    $0x10,%esp
 1af:	39 f8                	cmp    %edi,%eax
 1b1:	76 5d                	jbe    210 <find+0x90>
 1b3:	8d 47 01             	lea    0x1(%edi),%eax
 1b6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if (str[i] == delim[0]) {
 1b9:	8b 45 0c             	mov    0xc(%ebp),%eax
 1bc:	0f b6 00             	movzbl (%eax),%eax
 1bf:	38 04 3b             	cmp    %al,(%ebx,%edi,1)
 1c2:	75 dc                	jne    1a0 <find+0x20>
				if (str[j] != delim[j - i]) goto out;
 1c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
			for (j = i + 1; j < (i + strlen(delim)); j++) {
 1c7:	8d 57 01             	lea    0x1(%edi),%edx
 1ca:	89 d6                	mov    %edx,%esi
				if (str[j] != delim[j - i]) goto out;
 1cc:	29 d0                	sub    %edx,%eax
 1ce:	89 45 e0             	mov    %eax,-0x20(%ebp)
 1d1:	eb 14                	jmp    1e7 <find+0x67>
 1d3:	90                   	nop
 1d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d8:	8b 45 e0             	mov    -0x20(%ebp),%eax
 1db:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
 1df:	38 04 33             	cmp    %al,(%ebx,%esi,1)
 1e2:	75 bc                	jne    1a0 <find+0x20>
			for (j = i + 1; j < (i + strlen(delim)); j++) {
 1e4:	83 c6 01             	add    $0x1,%esi
 1e7:	83 ec 0c             	sub    $0xc,%esp
 1ea:	ff 75 0c             	pushl  0xc(%ebp)
 1ed:	e8 ae 01 00 00       	call   3a0 <strlen>
 1f2:	01 f8                	add    %edi,%eax
 1f4:	83 c4 10             	add    $0x10,%esp
 1f7:	39 f0                	cmp    %esi,%eax
 1f9:	77 dd                	ja     1d8 <find+0x58>
			}
			if (nth-- == 0) return i;
 1fb:	8b 45 10             	mov    0x10(%ebp),%eax
 1fe:	8b 55 10             	mov    0x10(%ebp),%edx
 201:	83 e8 01             	sub    $0x1,%eax
 204:	85 d2                	test   %edx,%edx
 206:	74 0d                	je     215 <find+0x95>
			out:;
 208:	89 45 10             	mov    %eax,0x10(%ebp)
 20b:	eb 93                	jmp    1a0 <find+0x20>
 20d:	8d 76 00             	lea    0x0(%esi),%esi
		}
	}
  return -1;
 210:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
 215:	8d 65 f4             	lea    -0xc(%ebp),%esp
 218:	89 f8                	mov    %edi,%eax
 21a:	5b                   	pop    %ebx
 21b:	5e                   	pop    %esi
 21c:	5f                   	pop    %edi
 21d:	5d                   	pop    %ebp
 21e:	c3                   	ret    
 21f:	90                   	nop

00000220 <substr>:

void substr(char* dest, char* str, int start, int end) {
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
 225:	53                   	push   %ebx
 226:	83 ec 18             	sub    $0x18,%esp
 229:	8b 7d 14             	mov    0x14(%ebp),%edi
  int len = strlen(str);
 22c:	ff 75 0c             	pushl  0xc(%ebp)
void substr(char* dest, char* str, int start, int end) {
 22f:	8b 5d 10             	mov    0x10(%ebp),%ebx
 232:	8b 75 08             	mov    0x8(%ebp),%esi
  int len = strlen(str);
 235:	e8 66 01 00 00       	call   3a0 <strlen>
 23a:	83 c4 10             	add    $0x10,%esp
 23d:	39 f8                	cmp    %edi,%eax
 23f:	0f 4e f8             	cmovle %eax,%edi
  if (end > len) end = len;
  int s = 0, i = start;
  while (i < end)
 242:	39 df                	cmp    %ebx,%edi
 244:	7e 1c                	jle    262 <substr+0x42>
 246:	8b 45 0c             	mov    0xc(%ebp),%eax
 249:	29 df                	sub    %ebx,%edi
  int s = 0, i = start;
 24b:	31 d2                	xor    %edx,%edx
 24d:	01 c3                	add    %eax,%ebx
 24f:	90                   	nop
    dest[s++] = str[i++];
 250:	83 c2 01             	add    $0x1,%edx
 253:	0f b6 44 13 ff       	movzbl -0x1(%ebx,%edx,1),%eax
  while (i < end)
 258:	39 fa                	cmp    %edi,%edx
    dest[s++] = str[i++];
 25a:	88 44 16 ff          	mov    %al,-0x1(%esi,%edx,1)
  while (i < end)
 25e:	75 f0                	jne    250 <substr+0x30>
 260:	01 d6                	add    %edx,%esi
  dest[s] = '\0';
 262:	c6 06 00             	movb   $0x0,(%esi)
 265:	8d 65 f4             	lea    -0xc(%ebp),%esp
 268:	5b                   	pop    %ebx
 269:	5e                   	pop    %esi
 26a:	5f                   	pop    %edi
 26b:	5d                   	pop    %ebp
 26c:	c3                   	ret    
 26d:	8d 76 00             	lea    0x0(%esi),%esi

00000270 <split>:
int split(char dest[MAXARGS][ARGLEN], char line[], char delim[]) {
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	57                   	push   %edi
 274:	56                   	push   %esi
 275:	53                   	push   %ebx
  int pos, prevpos = 0, count = 0;
 276:	31 db                	xor    %ebx,%ebx
int split(char dest[MAXARGS][ARGLEN], char line[], char delim[]) {
 278:	83 ec 3c             	sub    $0x3c,%esp
  int pos, prevpos = 0, count = 0;
 27b:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 282:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
	while ((pos = find(line, delim, count)) > 0) {
 289:	eb 50                	jmp    2db <split+0x6b>
 28b:	90                   	nop
 28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		substr(temp, line, prevpos, pos);
 290:	8d 45 d4             	lea    -0x2c(%ebp),%eax
 293:	56                   	push   %esi
 294:	ff 75 c4             	pushl  -0x3c(%ebp)
 297:	ff 75 0c             	pushl  0xc(%ebp)
 29a:	50                   	push   %eax
 29b:	e8 80 ff ff ff       	call   220 <substr>
		substr(dest[count], line, prevpos, pos);
 2a0:	56                   	push   %esi
 2a1:	ff 75 c4             	pushl  -0x3c(%ebp)
 2a4:	ff 75 0c             	pushl  0xc(%ebp)
 2a7:	57                   	push   %edi
 2a8:	e8 73 ff ff ff       	call   220 <substr>
		if (strlen(dest[count]) != 0) count++;
 2ad:	83 c4 14             	add    $0x14,%esp
 2b0:	57                   	push   %edi
 2b1:	e8 ea 00 00 00       	call   3a0 <strlen>
 2b6:	83 c4 10             	add    $0x10,%esp
 2b9:	85 c0                	test   %eax,%eax
 2bb:	74 0b                	je     2c8 <split+0x58>
 2bd:	8b 45 c0             	mov    -0x40(%ebp),%eax
 2c0:	89 c3                	mov    %eax,%ebx
 2c2:	83 c0 01             	add    $0x1,%eax
 2c5:	89 45 c0             	mov    %eax,-0x40(%ebp)
		prevpos = pos + strlen(delim);
 2c8:	83 ec 0c             	sub    $0xc,%esp
 2cb:	ff 75 10             	pushl  0x10(%ebp)
 2ce:	e8 cd 00 00 00       	call   3a0 <strlen>
 2d3:	01 f0                	add    %esi,%eax
 2d5:	83 c4 10             	add    $0x10,%esp
 2d8:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	while ((pos = find(line, delim, count)) > 0) {
 2db:	83 ec 04             	sub    $0x4,%esp
 2de:	53                   	push   %ebx
 2df:	ff 75 10             	pushl  0x10(%ebp)
 2e2:	ff 75 0c             	pushl  0xc(%ebp)
 2e5:	e8 96 fe ff ff       	call   180 <find>
 2ea:	8b 55 08             	mov    0x8(%ebp),%edx
 2ed:	89 c6                	mov    %eax,%esi
 2ef:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 2f2:	83 c4 10             	add    $0x10,%esp
 2f5:	85 f6                	test   %esi,%esi
 2f7:	8d 3c 82             	lea    (%edx,%eax,4),%edi
 2fa:	7f 94                	jg     290 <split+0x20>
	substr(dest[count++], line, prevpos, strlen(line));
 2fc:	83 ec 0c             	sub    $0xc,%esp
 2ff:	ff 75 0c             	pushl  0xc(%ebp)
 302:	e8 99 00 00 00       	call   3a0 <strlen>
 307:	50                   	push   %eax
 308:	ff 75 c4             	pushl  -0x3c(%ebp)
 30b:	ff 75 0c             	pushl  0xc(%ebp)
 30e:	57                   	push   %edi
 30f:	e8 0c ff ff ff       	call   220 <substr>
}
 314:	8b 45 c0             	mov    -0x40(%ebp),%eax
 317:	8d 65 f4             	lea    -0xc(%ebp),%esp
 31a:	5b                   	pop    %ebx
 31b:	5e                   	pop    %esi
 31c:	5f                   	pop    %edi
 31d:	5d                   	pop    %ebp
 31e:	c3                   	ret    
 31f:	90                   	nop

00000320 <strcpy>:
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	8b 45 08             	mov    0x8(%ebp),%eax
 327:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 32a:	89 c2                	mov    %eax,%edx
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 330:	83 c1 01             	add    $0x1,%ecx
 333:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 337:	83 c2 01             	add    $0x1,%edx
 33a:	84 db                	test   %bl,%bl
 33c:	88 5a ff             	mov    %bl,-0x1(%edx)
 33f:	75 ef                	jne    330 <strcpy+0x10>
 341:	5b                   	pop    %ebx
 342:	5d                   	pop    %ebp
 343:	c3                   	ret    
 344:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 34a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000350 <strcmp>:
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	53                   	push   %ebx
 354:	8b 55 08             	mov    0x8(%ebp),%edx
 357:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 35a:	0f b6 02             	movzbl (%edx),%eax
 35d:	0f b6 19             	movzbl (%ecx),%ebx
 360:	84 c0                	test   %al,%al
 362:	75 1c                	jne    380 <strcmp+0x30>
 364:	eb 2a                	jmp    390 <strcmp+0x40>
 366:	8d 76 00             	lea    0x0(%esi),%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 370:	83 c2 01             	add    $0x1,%edx
 373:	0f b6 02             	movzbl (%edx),%eax
 376:	83 c1 01             	add    $0x1,%ecx
 379:	0f b6 19             	movzbl (%ecx),%ebx
 37c:	84 c0                	test   %al,%al
 37e:	74 10                	je     390 <strcmp+0x40>
 380:	38 d8                	cmp    %bl,%al
 382:	74 ec                	je     370 <strcmp+0x20>
 384:	29 d8                	sub    %ebx,%eax
 386:	5b                   	pop    %ebx
 387:	5d                   	pop    %ebp
 388:	c3                   	ret    
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 390:	31 c0                	xor    %eax,%eax
 392:	29 d8                	sub    %ebx,%eax
 394:	5b                   	pop    %ebx
 395:	5d                   	pop    %ebp
 396:	c3                   	ret    
 397:	89 f6                	mov    %esi,%esi
 399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003a0 <strlen>:
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3a6:	80 39 00             	cmpb   $0x0,(%ecx)
 3a9:	74 15                	je     3c0 <strlen+0x20>
 3ab:	31 d2                	xor    %edx,%edx
 3ad:	8d 76 00             	lea    0x0(%esi),%esi
 3b0:	83 c2 01             	add    $0x1,%edx
 3b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3b7:	89 d0                	mov    %edx,%eax
 3b9:	75 f5                	jne    3b0 <strlen+0x10>
 3bb:	5d                   	pop    %ebp
 3bc:	c3                   	ret    
 3bd:	8d 76 00             	lea    0x0(%esi),%esi
 3c0:	31 c0                	xor    %eax,%eax
 3c2:	5d                   	pop    %ebp
 3c3:	c3                   	ret    
 3c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003d0 <memset>:
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	8b 55 08             	mov    0x8(%ebp),%edx
 3d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3da:	8b 45 0c             	mov    0xc(%ebp),%eax
 3dd:	89 d7                	mov    %edx,%edi
 3df:	fc                   	cld    
 3e0:	f3 aa                	rep stos %al,%es:(%edi)
 3e2:	89 d0                	mov    %edx,%eax
 3e4:	5f                   	pop    %edi
 3e5:	5d                   	pop    %ebp
 3e6:	c3                   	ret    
 3e7:	89 f6                	mov    %esi,%esi
 3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003f0 <strchr>:
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	53                   	push   %ebx
 3f4:	8b 45 08             	mov    0x8(%ebp),%eax
 3f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 3fa:	0f b6 10             	movzbl (%eax),%edx
 3fd:	84 d2                	test   %dl,%dl
 3ff:	74 1d                	je     41e <strchr+0x2e>
 401:	38 d3                	cmp    %dl,%bl
 403:	89 d9                	mov    %ebx,%ecx
 405:	75 0d                	jne    414 <strchr+0x24>
 407:	eb 17                	jmp    420 <strchr+0x30>
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 410:	38 ca                	cmp    %cl,%dl
 412:	74 0c                	je     420 <strchr+0x30>
 414:	83 c0 01             	add    $0x1,%eax
 417:	0f b6 10             	movzbl (%eax),%edx
 41a:	84 d2                	test   %dl,%dl
 41c:	75 f2                	jne    410 <strchr+0x20>
 41e:	31 c0                	xor    %eax,%eax
 420:	5b                   	pop    %ebx
 421:	5d                   	pop    %ebp
 422:	c3                   	ret    
 423:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000430 <gets>:
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
 436:	31 f6                	xor    %esi,%esi
 438:	89 f3                	mov    %esi,%ebx
 43a:	83 ec 1c             	sub    $0x1c,%esp
 43d:	8b 7d 08             	mov    0x8(%ebp),%edi
 440:	eb 2f                	jmp    471 <gets+0x41>
 442:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 448:	8d 45 e7             	lea    -0x19(%ebp),%eax
 44b:	83 ec 04             	sub    $0x4,%esp
 44e:	6a 01                	push   $0x1
 450:	50                   	push   %eax
 451:	6a 00                	push   $0x0
 453:	e8 32 01 00 00       	call   58a <read>
 458:	83 c4 10             	add    $0x10,%esp
 45b:	85 c0                	test   %eax,%eax
 45d:	7e 1c                	jle    47b <gets+0x4b>
 45f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 463:	83 c7 01             	add    $0x1,%edi
 466:	88 47 ff             	mov    %al,-0x1(%edi)
 469:	3c 0a                	cmp    $0xa,%al
 46b:	74 23                	je     490 <gets+0x60>
 46d:	3c 0d                	cmp    $0xd,%al
 46f:	74 1f                	je     490 <gets+0x60>
 471:	83 c3 01             	add    $0x1,%ebx
 474:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 477:	89 fe                	mov    %edi,%esi
 479:	7c cd                	jl     448 <gets+0x18>
 47b:	89 f3                	mov    %esi,%ebx
 47d:	8b 45 08             	mov    0x8(%ebp),%eax
 480:	c6 03 00             	movb   $0x0,(%ebx)
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
 49a:	c6 03 00             	movb   $0x0,(%ebx)
 49d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4a0:	5b                   	pop    %ebx
 4a1:	5e                   	pop    %esi
 4a2:	5f                   	pop    %edi
 4a3:	5d                   	pop    %ebp
 4a4:	c3                   	ret    
 4a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004b0 <stat>:
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	56                   	push   %esi
 4b4:	53                   	push   %ebx
 4b5:	83 ec 08             	sub    $0x8,%esp
 4b8:	6a 00                	push   $0x0
 4ba:	ff 75 08             	pushl  0x8(%ebp)
 4bd:	e8 f0 00 00 00       	call   5b2 <open>
 4c2:	83 c4 10             	add    $0x10,%esp
 4c5:	85 c0                	test   %eax,%eax
 4c7:	78 27                	js     4f0 <stat+0x40>
 4c9:	83 ec 08             	sub    $0x8,%esp
 4cc:	ff 75 0c             	pushl  0xc(%ebp)
 4cf:	89 c3                	mov    %eax,%ebx
 4d1:	50                   	push   %eax
 4d2:	e8 f3 00 00 00       	call   5ca <fstat>
 4d7:	89 1c 24             	mov    %ebx,(%esp)
 4da:	89 c6                	mov    %eax,%esi
 4dc:	e8 b9 00 00 00       	call   59a <close>
 4e1:	83 c4 10             	add    $0x10,%esp
 4e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4e7:	89 f0                	mov    %esi,%eax
 4e9:	5b                   	pop    %ebx
 4ea:	5e                   	pop    %esi
 4eb:	5d                   	pop    %ebp
 4ec:	c3                   	ret    
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
 4f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 4f5:	eb ed                	jmp    4e4 <stat+0x34>
 4f7:	89 f6                	mov    %esi,%esi
 4f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000500 <atoi>:
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	53                   	push   %ebx
 504:	8b 4d 08             	mov    0x8(%ebp),%ecx
 507:	0f be 11             	movsbl (%ecx),%edx
 50a:	8d 42 d0             	lea    -0x30(%edx),%eax
 50d:	3c 09                	cmp    $0x9,%al
 50f:	b8 00 00 00 00       	mov    $0x0,%eax
 514:	77 1f                	ja     535 <atoi+0x35>
 516:	8d 76 00             	lea    0x0(%esi),%esi
 519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 520:	8d 04 80             	lea    (%eax,%eax,4),%eax
 523:	83 c1 01             	add    $0x1,%ecx
 526:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 52a:	0f be 11             	movsbl (%ecx),%edx
 52d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 530:	80 fb 09             	cmp    $0x9,%bl
 533:	76 eb                	jbe    520 <atoi+0x20>
 535:	5b                   	pop    %ebx
 536:	5d                   	pop    %ebp
 537:	c3                   	ret    
 538:	90                   	nop
 539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000540 <memmove>:
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	56                   	push   %esi
 544:	53                   	push   %ebx
 545:	8b 5d 10             	mov    0x10(%ebp),%ebx
 548:	8b 45 08             	mov    0x8(%ebp),%eax
 54b:	8b 75 0c             	mov    0xc(%ebp),%esi
 54e:	85 db                	test   %ebx,%ebx
 550:	7e 14                	jle    566 <memmove+0x26>
 552:	31 d2                	xor    %edx,%edx
 554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 558:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 55c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 55f:	83 c2 01             	add    $0x1,%edx
 562:	39 d3                	cmp    %edx,%ebx
 564:	75 f2                	jne    558 <memmove+0x18>
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
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	57                   	push   %edi
 624:	56                   	push   %esi
 625:	53                   	push   %ebx
 626:	89 d6                	mov    %edx,%esi
 628:	83 ec 3c             	sub    $0x3c,%esp
 62b:	85 c0                	test   %eax,%eax
 62d:	79 71                	jns    6a0 <printint.constprop.1+0x80>
 62f:	83 e1 01             	and    $0x1,%ecx
 632:	74 6c                	je     6a0 <printint.constprop.1+0x80>
 634:	f7 d8                	neg    %eax
 636:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 63d:	31 c9                	xor    %ecx,%ecx
 63f:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 642:	eb 06                	jmp    64a <printint.constprop.1+0x2a>
 644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 648:	89 f9                	mov    %edi,%ecx
 64a:	31 d2                	xor    %edx,%edx
 64c:	8d 79 01             	lea    0x1(%ecx),%edi
 64f:	f7 f6                	div    %esi
 651:	0f b6 92 d4 0a 00 00 	movzbl 0xad4(%edx),%edx
 658:	85 c0                	test   %eax,%eax
 65a:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
 65d:	75 e9                	jne    648 <printint.constprop.1+0x28>
 65f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 662:	85 c0                	test   %eax,%eax
 664:	74 08                	je     66e <printint.constprop.1+0x4e>
 666:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 66b:	8d 79 02             	lea    0x2(%ecx),%edi
 66e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 678:	0f b6 06             	movzbl (%esi),%eax
 67b:	83 ec 04             	sub    $0x4,%esp
 67e:	83 ee 01             	sub    $0x1,%esi
 681:	6a 01                	push   $0x1
 683:	53                   	push   %ebx
 684:	6a 01                	push   $0x1
 686:	88 45 d7             	mov    %al,-0x29(%ebp)
 689:	e8 04 ff ff ff       	call   592 <write>
 68e:	83 c4 10             	add    $0x10,%esp
 691:	39 de                	cmp    %ebx,%esi
 693:	75 e3                	jne    678 <printint.constprop.1+0x58>
 695:	8d 65 f4             	lea    -0xc(%ebp),%esp
 698:	5b                   	pop    %ebx
 699:	5e                   	pop    %esi
 69a:	5f                   	pop    %edi
 69b:	5d                   	pop    %ebp
 69c:	c3                   	ret    
 69d:	8d 76 00             	lea    0x0(%esi),%esi
 6a0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 6a7:	eb 94                	jmp    63d <printint.constprop.1+0x1d>
 6a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006b0 <vprintf.constprop.0>:
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	56                   	push   %esi
 6b5:	53                   	push   %ebx
 6b6:	89 d6                	mov    %edx,%esi
 6b8:	83 ec 2c             	sub    $0x2c,%esp
 6bb:	0f b6 10             	movzbl (%eax),%edx
 6be:	84 d2                	test   %dl,%dl
 6c0:	0f 84 cd 00 00 00    	je     793 <vprintf.constprop.0+0xe3>
 6c6:	8d 58 01             	lea    0x1(%eax),%ebx
 6c9:	31 ff                	xor    %edi,%edi
 6cb:	eb 31                	jmp    6fe <vprintf.constprop.0+0x4e>
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
 6d0:	83 f8 25             	cmp    $0x25,%eax
 6d3:	0f 84 c7 00 00 00    	je     7a0 <vprintf.constprop.0+0xf0>
 6d9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6dc:	83 ec 04             	sub    $0x4,%esp
 6df:	88 55 e4             	mov    %dl,-0x1c(%ebp)
 6e2:	6a 01                	push   $0x1
 6e4:	50                   	push   %eax
 6e5:	6a 01                	push   $0x1
 6e7:	e8 a6 fe ff ff       	call   592 <write>
 6ec:	83 c4 10             	add    $0x10,%esp
 6ef:	83 c3 01             	add    $0x1,%ebx
 6f2:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 6f6:	84 d2                	test   %dl,%dl
 6f8:	0f 84 95 00 00 00    	je     793 <vprintf.constprop.0+0xe3>
 6fe:	85 ff                	test   %edi,%edi
 700:	0f b6 c2             	movzbl %dl,%eax
 703:	74 cb                	je     6d0 <vprintf.constprop.0+0x20>
 705:	83 ff 25             	cmp    $0x25,%edi
 708:	75 e5                	jne    6ef <vprintf.constprop.0+0x3f>
 70a:	83 f8 64             	cmp    $0x64,%eax
 70d:	8d 7e 04             	lea    0x4(%esi),%edi
 710:	b9 01 00 00 00       	mov    $0x1,%ecx
 715:	0f 84 9a 00 00 00    	je     7b5 <vprintf.constprop.0+0x105>
 71b:	83 f8 6c             	cmp    $0x6c,%eax
 71e:	0f 84 8c 00 00 00    	je     7b0 <vprintf.constprop.0+0x100>
 724:	83 f8 78             	cmp    $0x78,%eax
 727:	0f 84 a3 00 00 00    	je     7d0 <vprintf.constprop.0+0x120>
 72d:	83 f8 70             	cmp    $0x70,%eax
 730:	0f 84 ca 00 00 00    	je     800 <vprintf.constprop.0+0x150>
 736:	83 f8 73             	cmp    $0x73,%eax
 739:	0f 84 39 01 00 00    	je     878 <vprintf.constprop.0+0x1c8>
 73f:	83 f8 63             	cmp    $0x63,%eax
 742:	0f 84 68 01 00 00    	je     8b0 <vprintf.constprop.0+0x200>
 748:	83 f8 25             	cmp    $0x25,%eax
 74b:	0f 84 9f 00 00 00    	je     7f0 <vprintf.constprop.0+0x140>
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
 77d:	31 ff                	xor    %edi,%edi
 77f:	e8 0e fe ff ff       	call   592 <write>
 784:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 788:	83 c4 10             	add    $0x10,%esp
 78b:	84 d2                	test   %dl,%dl
 78d:	0f 85 6b ff ff ff    	jne    6fe <vprintf.constprop.0+0x4e>
 793:	8d 65 f4             	lea    -0xc(%ebp),%esp
 796:	5b                   	pop    %ebx
 797:	5e                   	pop    %esi
 798:	5f                   	pop    %edi
 799:	5d                   	pop    %ebp
 79a:	c3                   	ret    
 79b:	90                   	nop
 79c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7a0:	bf 25 00 00 00       	mov    $0x25,%edi
 7a5:	e9 45 ff ff ff       	jmp    6ef <vprintf.constprop.0+0x3f>
 7aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7b0:	8d 7e 04             	lea    0x4(%esi),%edi
 7b3:	31 c9                	xor    %ecx,%ecx
 7b5:	8b 06                	mov    (%esi),%eax
 7b7:	ba 0a 00 00 00       	mov    $0xa,%edx
 7bc:	89 fe                	mov    %edi,%esi
 7be:	31 ff                	xor    %edi,%edi
 7c0:	e8 5b fe ff ff       	call   620 <printint.constprop.1>
 7c5:	e9 25 ff ff ff       	jmp    6ef <vprintf.constprop.0+0x3f>
 7ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7d0:	8b 06                	mov    (%esi),%eax
 7d2:	8d 7e 04             	lea    0x4(%esi),%edi
 7d5:	31 c9                	xor    %ecx,%ecx
 7d7:	ba 10 00 00 00       	mov    $0x10,%edx
 7dc:	89 fe                	mov    %edi,%esi
 7de:	31 ff                	xor    %edi,%edi
 7e0:	e8 3b fe ff ff       	call   620 <printint.constprop.1>
 7e5:	e9 05 ff ff ff       	jmp    6ef <vprintf.constprop.0+0x3f>
 7ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7f0:	83 ec 04             	sub    $0x4,%esp
 7f3:	88 55 e1             	mov    %dl,-0x1f(%ebp)
 7f6:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 7f9:	6a 01                	push   $0x1
 7fb:	e9 77 ff ff ff       	jmp    777 <vprintf.constprop.0+0xc7>
 800:	8d 46 04             	lea    0x4(%esi),%eax
 803:	83 ec 04             	sub    $0x4,%esp
 806:	8b 3e                	mov    (%esi),%edi
 808:	6a 01                	push   $0x1
 80a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
 80e:	be 08 00 00 00       	mov    $0x8,%esi
 813:	89 45 d4             	mov    %eax,-0x2c(%ebp)
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
 840:	89 f8                	mov    %edi,%eax
 842:	83 ec 04             	sub    $0x4,%esp
 845:	c1 e7 04             	shl    $0x4,%edi
 848:	c1 e8 1c             	shr    $0x1c,%eax
 84b:	6a 01                	push   $0x1
 84d:	0f b6 80 d4 0a 00 00 	movzbl 0xad4(%eax),%eax
 854:	88 45 e5             	mov    %al,-0x1b(%ebp)
 857:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 85a:	50                   	push   %eax
 85b:	6a 01                	push   $0x1
 85d:	e8 30 fd ff ff       	call   592 <write>
 862:	83 c4 10             	add    $0x10,%esp
 865:	83 ee 01             	sub    $0x1,%esi
 868:	75 d6                	jne    840 <vprintf.constprop.0+0x190>
 86a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 86d:	31 ff                	xor    %edi,%edi
 86f:	e9 7b fe ff ff       	jmp    6ef <vprintf.constprop.0+0x3f>
 874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 878:	8b 3e                	mov    (%esi),%edi
 87a:	8d 46 04             	lea    0x4(%esi),%eax
 87d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 880:	85 ff                	test   %edi,%edi
 882:	74 50                	je     8d4 <vprintf.constprop.0+0x224>
 884:	0f b6 07             	movzbl (%edi),%eax
 887:	84 c0                	test   %al,%al
 889:	74 df                	je     86a <vprintf.constprop.0+0x1ba>
 88b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
 88e:	66 90                	xchg   %ax,%ax
 890:	83 ec 04             	sub    $0x4,%esp
 893:	83 c7 01             	add    $0x1,%edi
 896:	88 45 e3             	mov    %al,-0x1d(%ebp)
 899:	6a 01                	push   $0x1
 89b:	56                   	push   %esi
 89c:	6a 01                	push   $0x1
 89e:	e8 ef fc ff ff       	call   592 <write>
 8a3:	0f b6 07             	movzbl (%edi),%eax
 8a6:	83 c4 10             	add    $0x10,%esp
 8a9:	84 c0                	test   %al,%al
 8ab:	75 e3                	jne    890 <vprintf.constprop.0+0x1e0>
 8ad:	eb bb                	jmp    86a <vprintf.constprop.0+0x1ba>
 8af:	90                   	nop
 8b0:	8b 06                	mov    (%esi),%eax
 8b2:	83 ec 04             	sub    $0x4,%esp
 8b5:	8d 7e 04             	lea    0x4(%esi),%edi
 8b8:	6a 01                	push   $0x1
 8ba:	89 fe                	mov    %edi,%esi
 8bc:	31 ff                	xor    %edi,%edi
 8be:	88 45 e2             	mov    %al,-0x1e(%ebp)
 8c1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 8c4:	50                   	push   %eax
 8c5:	6a 01                	push   $0x1
 8c7:	e8 c6 fc ff ff       	call   592 <write>
 8cc:	83 c4 10             	add    $0x10,%esp
 8cf:	e9 1b fe ff ff       	jmp    6ef <vprintf.constprop.0+0x3f>
 8d4:	bf cb 0a 00 00       	mov    $0xacb,%edi
 8d9:	b8 28 00 00 00       	mov    $0x28,%eax
 8de:	eb ab                	jmp    88b <vprintf.constprop.0+0x1db>

000008e0 <fprintf>:
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	83 ec 08             	sub    $0x8,%esp
 8e6:	8b 45 0c             	mov    0xc(%ebp),%eax
 8e9:	8d 55 10             	lea    0x10(%ebp),%edx
 8ec:	e8 bf fd ff ff       	call   6b0 <vprintf.constprop.0>
 8f1:	c9                   	leave  
 8f2:	c3                   	ret    
 8f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000900 <printf>:
 900:	55                   	push   %ebp
 901:	89 e5                	mov    %esp,%ebp
 903:	83 ec 08             	sub    $0x8,%esp
 906:	8b 45 08             	mov    0x8(%ebp),%eax
 909:	8d 55 0c             	lea    0xc(%ebp),%edx
 90c:	e8 9f fd ff ff       	call   6b0 <vprintf.constprop.0>
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
 921:	a1 88 0e 00 00       	mov    0xe88,%eax
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
 95f:	a3 88 0e 00 00       	mov    %eax,0xe88
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
 99a:	a3 88 0e 00 00       	mov    %eax,0xe88
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
 9bc:	8b 15 88 0e 00 00    	mov    0xe88,%edx
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
 a01:	39 05 88 0e 00 00    	cmp    %eax,0xe88
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
 a2b:	8b 15 88 0e 00 00    	mov    0xe88,%edx
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
 a57:	89 15 88 0e 00 00    	mov    %edx,0xe88
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
 a70:	c7 05 88 0e 00 00 8c 	movl   $0xe8c,0xe88
 a77:	0e 00 00 
 a7a:	c7 05 8c 0e 00 00 8c 	movl   $0xe8c,0xe8c
 a81:	0e 00 00 
    base.s.size = 0;
 a84:	b8 8c 0e 00 00       	mov    $0xe8c,%eax
 a89:	c7 05 90 0e 00 00 00 	movl   $0x0,0xe90
 a90:	00 00 00 
 a93:	e9 44 ff ff ff       	jmp    9dc <malloc+0x2c>
 a98:	90                   	nop
 a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 aa0:	8b 08                	mov    (%eax),%ecx
 aa2:	89 0a                	mov    %ecx,(%edx)
 aa4:	eb b1                	jmp    a57 <malloc+0xa7>
