
user/_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 04             	sub    $0x4,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      11:	eb 0a                	jmp    1d <main+0x1d>
      13:	90                   	nop
      14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	7f 76                	jg     93 <main+0x93>
  while((fd = open("console", O_RDWR)) >= 0){
      1d:	83 ec 08             	sub    $0x8,%esp
      20:	6a 02                	push   $0x2
      22:	68 eb 12 00 00       	push   $0x12eb
      27:	e8 26 0d 00 00       	call   d52 <open>
      2c:	83 c4 10             	add    $0x10,%esp
      2f:	85 c0                	test   %eax,%eax
      31:	79 e5                	jns    18 <main+0x18>
      33:	eb 1f                	jmp    54 <main+0x54>
      35:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      38:	80 3d 62 19 00 00 20 	cmpb   $0x20,0x1962
      3f:	74 7a                	je     bb <main+0xbb>
int
fork1(void)
{
  int pid;

  pid = fork();
      41:	e8 c4 0c 00 00       	call   d0a <fork>
  if(pid == -1)
      46:	83 f8 ff             	cmp    $0xffffffff,%eax
      49:	74 3b                	je     86 <main+0x86>
    if(fork1() == 0)
      4b:	85 c0                	test   %eax,%eax
      4d:	74 57                	je     a6 <main+0xa6>
    wait();
      4f:	e8 c6 0c 00 00       	call   d1a <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
      54:	83 ec 08             	sub    $0x8,%esp
      57:	6a 64                	push   $0x64
      59:	68 60 19 00 00       	push   $0x1960
      5e:	e8 9d 00 00 00       	call   100 <getcmd>
      63:	83 c4 10             	add    $0x10,%esp
      66:	85 c0                	test   %eax,%eax
      68:	78 37                	js     a1 <main+0xa1>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      6a:	80 3d 60 19 00 00 63 	cmpb   $0x63,0x1960
      71:	75 ce                	jne    41 <main+0x41>
      73:	80 3d 61 19 00 00 64 	cmpb   $0x64,0x1961
      7a:	74 bc                	je     38 <main+0x38>
  pid = fork();
      7c:	e8 89 0c 00 00       	call   d0a <fork>
  if(pid == -1)
      81:	83 f8 ff             	cmp    $0xffffffff,%eax
      84:	75 c5                	jne    4b <main+0x4b>
    panic("fork");
      86:	83 ec 0c             	sub    $0xc,%esp
      89:	68 74 12 00 00       	push   $0x1274
      8e:	e8 bd 00 00 00       	call   150 <panic>
      close(fd);
      93:	83 ec 0c             	sub    $0xc,%esp
      96:	50                   	push   %eax
      97:	e8 9e 0c 00 00       	call   d3a <close>
      break;
      9c:	83 c4 10             	add    $0x10,%esp
      9f:	eb b3                	jmp    54 <main+0x54>
  exit();
      a1:	e8 6c 0c 00 00       	call   d12 <exit>
      runcmd(parsecmd(buf));
      a6:	83 ec 0c             	sub    $0xc,%esp
      a9:	68 60 19 00 00       	push   $0x1960
      ae:	e8 9d 09 00 00       	call   a50 <parsecmd>
      b3:	89 04 24             	mov    %eax,(%esp)
      b6:	e8 b5 00 00 00       	call   170 <runcmd>
      buf[strlen(buf)-1] = 0;  // chop \n
      bb:	83 ec 0c             	sub    $0xc,%esp
      be:	68 60 19 00 00       	push   $0x1960
      c3:	e8 78 0a 00 00       	call   b40 <strlen>
      if(chdir(buf+3) < 0)
      c8:	c7 04 24 63 19 00 00 	movl   $0x1963,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      cf:	c6 80 5f 19 00 00 00 	movb   $0x0,0x195f(%eax)
      if(chdir(buf+3) < 0)
      d6:	e8 a7 0c 00 00       	call   d82 <chdir>
      db:	83 c4 10             	add    $0x10,%esp
      de:	85 c0                	test   %eax,%eax
      e0:	0f 89 6e ff ff ff    	jns    54 <main+0x54>
        fprintf(2, "cannot cd %s\n", buf+3);
      e6:	50                   	push   %eax
      e7:	68 63 19 00 00       	push   $0x1963
      ec:	68 f3 12 00 00       	push   $0x12f3
      f1:	6a 02                	push   $0x2
      f3:	e8 88 0f 00 00       	call   1080 <fprintf>
      f8:	83 c4 10             	add    $0x10,%esp
      fb:	e9 54 ff ff ff       	jmp    54 <main+0x54>

00000100 <getcmd>:
{
     100:	55                   	push   %ebp
     101:	89 e5                	mov    %esp,%ebp
     103:	56                   	push   %esi
     104:	53                   	push   %ebx
     105:	8b 75 0c             	mov    0xc(%ebp),%esi
     108:	8b 5d 08             	mov    0x8(%ebp),%ebx
  fprintf(2, "\n>> ");
     10b:	83 ec 08             	sub    $0x8,%esp
     10e:	68 48 12 00 00       	push   $0x1248
     113:	6a 02                	push   $0x2
     115:	e8 66 0f 00 00       	call   1080 <fprintf>
  memset(buf, 0, nbuf);
     11a:	83 c4 0c             	add    $0xc,%esp
     11d:	56                   	push   %esi
     11e:	6a 00                	push   $0x0
     120:	53                   	push   %ebx
     121:	e8 4a 0a 00 00       	call   b70 <memset>
  gets(buf, nbuf);
     126:	58                   	pop    %eax
     127:	5a                   	pop    %edx
     128:	56                   	push   %esi
     129:	53                   	push   %ebx
     12a:	e8 a1 0a 00 00       	call   bd0 <gets>
  if(buf[0] == 0) // EOF
     12f:	83 c4 10             	add    $0x10,%esp
     132:	31 c0                	xor    %eax,%eax
     134:	80 3b 00             	cmpb   $0x0,(%ebx)
     137:	0f 94 c0             	sete   %al
}
     13a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(buf[0] == 0) // EOF
     13d:	f7 d8                	neg    %eax
}
     13f:	5b                   	pop    %ebx
     140:	5e                   	pop    %esi
     141:	5d                   	pop    %ebp
     142:	c3                   	ret    
     143:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <panic>:
{
     150:	55                   	push   %ebp
     151:	89 e5                	mov    %esp,%ebp
     153:	83 ec 0c             	sub    $0xc,%esp
  fprintf(2, "%s\n", s);
     156:	ff 75 08             	pushl  0x8(%ebp)
     159:	68 e7 12 00 00       	push   $0x12e7
     15e:	6a 02                	push   $0x2
     160:	e8 1b 0f 00 00       	call   1080 <fprintf>
  exit();
     165:	e8 a8 0b 00 00       	call   d12 <exit>
     16a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000170 <runcmd>:
{
     170:	55                   	push   %ebp
     171:	89 e5                	mov    %esp,%ebp
     173:	53                   	push   %ebx
     174:	83 ec 14             	sub    $0x14,%esp
     177:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     17a:	85 db                	test   %ebx,%ebx
     17c:	74 3a                	je     1b8 <runcmd+0x48>
  switch(cmd->type){
     17e:	83 3b 05             	cmpl   $0x5,(%ebx)
     181:	0f 87 06 01 00 00    	ja     28d <runcmd+0x11d>
     187:	8b 03                	mov    (%ebx),%eax
     189:	ff 24 85 04 13 00 00 	jmp    *0x1304(,%eax,4)
    if(ecmd->argv[0] == 0)
     190:	8b 43 04             	mov    0x4(%ebx),%eax
     193:	85 c0                	test   %eax,%eax
     195:	74 21                	je     1b8 <runcmd+0x48>
    exec(ecmd->argv[0], ecmd->argv);
     197:	52                   	push   %edx
     198:	52                   	push   %edx
     199:	8d 53 04             	lea    0x4(%ebx),%edx
     19c:	52                   	push   %edx
     19d:	50                   	push   %eax
     19e:	e8 a7 0b 00 00       	call   d4a <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     1a3:	83 c4 0c             	add    $0xc,%esp
     1a6:	ff 73 04             	pushl  0x4(%ebx)
     1a9:	68 54 12 00 00       	push   $0x1254
     1ae:	6a 02                	push   $0x2
     1b0:	e8 cb 0e 00 00       	call   1080 <fprintf>
    break;
     1b5:	83 c4 10             	add    $0x10,%esp
    exit();
     1b8:	e8 55 0b 00 00       	call   d12 <exit>
  pid = fork();
     1bd:	e8 48 0b 00 00       	call   d0a <fork>
  if(pid == -1)
     1c2:	83 f8 ff             	cmp    $0xffffffff,%eax
     1c5:	0f 84 cf 00 00 00    	je     29a <runcmd+0x12a>
    if(fork1() == 0)
     1cb:	85 c0                	test   %eax,%eax
     1cd:	75 e9                	jne    1b8 <runcmd+0x48>
      runcmd(bcmd->cmd);
     1cf:	83 ec 0c             	sub    $0xc,%esp
     1d2:	ff 73 04             	pushl  0x4(%ebx)
     1d5:	e8 96 ff ff ff       	call   170 <runcmd>
    close(rcmd->fd);
     1da:	83 ec 0c             	sub    $0xc,%esp
     1dd:	ff 73 14             	pushl  0x14(%ebx)
     1e0:	e8 55 0b 00 00       	call   d3a <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     1e5:	59                   	pop    %ecx
     1e6:	58                   	pop    %eax
     1e7:	ff 73 10             	pushl  0x10(%ebx)
     1ea:	ff 73 08             	pushl  0x8(%ebx)
     1ed:	e8 60 0b 00 00       	call   d52 <open>
     1f2:	83 c4 10             	add    $0x10,%esp
     1f5:	85 c0                	test   %eax,%eax
     1f7:	79 d6                	jns    1cf <runcmd+0x5f>
      fprintf(2, "open %s failed\n", rcmd->file);
     1f9:	52                   	push   %edx
     1fa:	ff 73 08             	pushl  0x8(%ebx)
     1fd:	68 64 12 00 00       	push   $0x1264
     202:	6a 02                	push   $0x2
     204:	e8 77 0e 00 00       	call   1080 <fprintf>
      exit();
     209:	e8 04 0b 00 00       	call   d12 <exit>
    if(pipe(p) < 0)
     20e:	8d 45 f0             	lea    -0x10(%ebp),%eax
     211:	83 ec 0c             	sub    $0xc,%esp
     214:	50                   	push   %eax
     215:	e8 08 0b 00 00       	call   d22 <pipe>
     21a:	83 c4 10             	add    $0x10,%esp
     21d:	85 c0                	test   %eax,%eax
     21f:	0f 88 b0 00 00 00    	js     2d5 <runcmd+0x165>
  pid = fork();
     225:	e8 e0 0a 00 00       	call   d0a <fork>
  if(pid == -1)
     22a:	83 f8 ff             	cmp    $0xffffffff,%eax
     22d:	74 6b                	je     29a <runcmd+0x12a>
    if(fork1() == 0){
     22f:	85 c0                	test   %eax,%eax
     231:	0f 84 ab 00 00 00    	je     2e2 <runcmd+0x172>
  pid = fork();
     237:	e8 ce 0a 00 00       	call   d0a <fork>
  if(pid == -1)
     23c:	83 f8 ff             	cmp    $0xffffffff,%eax
     23f:	74 59                	je     29a <runcmd+0x12a>
    if(fork1() == 0){
     241:	85 c0                	test   %eax,%eax
     243:	74 62                	je     2a7 <runcmd+0x137>
    close(p[0]);
     245:	83 ec 0c             	sub    $0xc,%esp
     248:	ff 75 f0             	pushl  -0x10(%ebp)
     24b:	e8 ea 0a 00 00       	call   d3a <close>
    close(p[1]);
     250:	58                   	pop    %eax
     251:	ff 75 f4             	pushl  -0xc(%ebp)
     254:	e8 e1 0a 00 00       	call   d3a <close>
    wait();
     259:	e8 bc 0a 00 00       	call   d1a <wait>
    wait();
     25e:	e8 b7 0a 00 00       	call   d1a <wait>
    break;
     263:	83 c4 10             	add    $0x10,%esp
     266:	e9 4d ff ff ff       	jmp    1b8 <runcmd+0x48>
  pid = fork();
     26b:	e8 9a 0a 00 00       	call   d0a <fork>
  if(pid == -1)
     270:	83 f8 ff             	cmp    $0xffffffff,%eax
     273:	74 25                	je     29a <runcmd+0x12a>
    if(fork1() == 0)
     275:	85 c0                	test   %eax,%eax
     277:	0f 84 52 ff ff ff    	je     1cf <runcmd+0x5f>
    wait();
     27d:	e8 98 0a 00 00       	call   d1a <wait>
    runcmd(lcmd->right);
     282:	83 ec 0c             	sub    $0xc,%esp
     285:	ff 73 08             	pushl  0x8(%ebx)
     288:	e8 e3 fe ff ff       	call   170 <runcmd>
    panic("runcmd");
     28d:	83 ec 0c             	sub    $0xc,%esp
     290:	68 4d 12 00 00       	push   $0x124d
     295:	e8 b6 fe ff ff       	call   150 <panic>
    panic("fork");
     29a:	83 ec 0c             	sub    $0xc,%esp
     29d:	68 74 12 00 00       	push   $0x1274
     2a2:	e8 a9 fe ff ff       	call   150 <panic>
      close(0);
     2a7:	83 ec 0c             	sub    $0xc,%esp
     2aa:	6a 00                	push   $0x0
     2ac:	e8 89 0a 00 00       	call   d3a <close>
      dup(p[0]);
     2b1:	5a                   	pop    %edx
     2b2:	ff 75 f0             	pushl  -0x10(%ebp)
     2b5:	e8 d0 0a 00 00       	call   d8a <dup>
      close(p[0]);
     2ba:	59                   	pop    %ecx
     2bb:	ff 75 f0             	pushl  -0x10(%ebp)
     2be:	e8 77 0a 00 00       	call   d3a <close>
      close(p[1]);
     2c3:	58                   	pop    %eax
     2c4:	ff 75 f4             	pushl  -0xc(%ebp)
     2c7:	e8 6e 0a 00 00       	call   d3a <close>
      runcmd(pcmd->right);
     2cc:	58                   	pop    %eax
     2cd:	ff 73 08             	pushl  0x8(%ebx)
     2d0:	e8 9b fe ff ff       	call   170 <runcmd>
      panic("pipe");
     2d5:	83 ec 0c             	sub    $0xc,%esp
     2d8:	68 79 12 00 00       	push   $0x1279
     2dd:	e8 6e fe ff ff       	call   150 <panic>
      close(1);
     2e2:	83 ec 0c             	sub    $0xc,%esp
     2e5:	6a 01                	push   $0x1
     2e7:	e8 4e 0a 00 00       	call   d3a <close>
      dup(p[1]);
     2ec:	58                   	pop    %eax
     2ed:	ff 75 f4             	pushl  -0xc(%ebp)
     2f0:	e8 95 0a 00 00       	call   d8a <dup>
      close(p[0]);
     2f5:	58                   	pop    %eax
     2f6:	ff 75 f0             	pushl  -0x10(%ebp)
     2f9:	e8 3c 0a 00 00       	call   d3a <close>
      close(p[1]);
     2fe:	58                   	pop    %eax
     2ff:	ff 75 f4             	pushl  -0xc(%ebp)
     302:	e8 33 0a 00 00       	call   d3a <close>
      runcmd(pcmd->left);
     307:	58                   	pop    %eax
     308:	ff 73 04             	pushl  0x4(%ebx)
     30b:	e8 60 fe ff ff       	call   170 <runcmd>

00000310 <fork1>:
{
     310:	55                   	push   %ebp
     311:	89 e5                	mov    %esp,%ebp
     313:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     316:	e8 ef 09 00 00       	call   d0a <fork>
  if(pid == -1)
     31b:	83 f8 ff             	cmp    $0xffffffff,%eax
     31e:	74 02                	je     322 <fork1+0x12>
  return pid;
}
     320:	c9                   	leave  
     321:	c3                   	ret    
    panic("fork");
     322:	83 ec 0c             	sub    $0xc,%esp
     325:	68 74 12 00 00       	push   $0x1274
     32a:	e8 21 fe ff ff       	call   150 <panic>
     32f:	90                   	nop

00000330 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     330:	55                   	push   %ebp
     331:	89 e5                	mov    %esp,%ebp
     333:	53                   	push   %ebx
     334:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     337:	6a 54                	push   $0x54
     339:	e8 12 0e 00 00       	call   1150 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     33e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     341:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     343:	6a 54                	push   $0x54
     345:	6a 00                	push   $0x0
     347:	50                   	push   %eax
     348:	e8 23 08 00 00       	call   b70 <memset>
  cmd->type = EXEC;
     34d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     353:	89 d8                	mov    %ebx,%eax
     355:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     358:	c9                   	leave  
     359:	c3                   	ret    
     35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000360 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     360:	55                   	push   %ebp
     361:	89 e5                	mov    %esp,%ebp
     363:	53                   	push   %ebx
     364:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     367:	6a 18                	push   $0x18
     369:	e8 e2 0d 00 00       	call   1150 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     36e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     371:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     373:	6a 18                	push   $0x18
     375:	6a 00                	push   $0x0
     377:	50                   	push   %eax
     378:	e8 f3 07 00 00       	call   b70 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     37d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     380:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     386:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     389:	8b 45 0c             	mov    0xc(%ebp),%eax
     38c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     38f:	8b 45 10             	mov    0x10(%ebp),%eax
     392:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     395:	8b 45 14             	mov    0x14(%ebp),%eax
     398:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     39b:	8b 45 18             	mov    0x18(%ebp),%eax
     39e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     3a1:	89 d8                	mov    %ebx,%eax
     3a3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3a6:	c9                   	leave  
     3a7:	c3                   	ret    
     3a8:	90                   	nop
     3a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003b0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     3b0:	55                   	push   %ebp
     3b1:	89 e5                	mov    %esp,%ebp
     3b3:	53                   	push   %ebx
     3b4:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3b7:	6a 0c                	push   $0xc
     3b9:	e8 92 0d 00 00       	call   1150 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3be:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     3c1:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3c3:	6a 0c                	push   $0xc
     3c5:	6a 00                	push   $0x0
     3c7:	50                   	push   %eax
     3c8:	e8 a3 07 00 00       	call   b70 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     3cd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     3d0:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     3d6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     3d9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3dc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     3df:	89 d8                	mov    %ebx,%eax
     3e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3e4:	c9                   	leave  
     3e5:	c3                   	ret    
     3e6:	8d 76 00             	lea    0x0(%esi),%esi
     3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003f0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     3f0:	55                   	push   %ebp
     3f1:	89 e5                	mov    %esp,%ebp
     3f3:	53                   	push   %ebx
     3f4:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3f7:	6a 0c                	push   $0xc
     3f9:	e8 52 0d 00 00       	call   1150 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3fe:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     401:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     403:	6a 0c                	push   $0xc
     405:	6a 00                	push   $0x0
     407:	50                   	push   %eax
     408:	e8 63 07 00 00       	call   b70 <memset>
  cmd->type = LIST;
  cmd->left = left;
     40d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     410:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     416:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     419:	8b 45 0c             	mov    0xc(%ebp),%eax
     41c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     41f:	89 d8                	mov    %ebx,%eax
     421:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     424:	c9                   	leave  
     425:	c3                   	ret    
     426:	8d 76 00             	lea    0x0(%esi),%esi
     429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000430 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     430:	55                   	push   %ebp
     431:	89 e5                	mov    %esp,%ebp
     433:	53                   	push   %ebx
     434:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     437:	6a 08                	push   $0x8
     439:	e8 12 0d 00 00       	call   1150 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     43e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     441:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     443:	6a 08                	push   $0x8
     445:	6a 00                	push   $0x0
     447:	50                   	push   %eax
     448:	e8 23 07 00 00       	call   b70 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     44d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     450:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     456:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     459:	89 d8                	mov    %ebx,%eax
     45b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     45e:	c9                   	leave  
     45f:	c3                   	ret    

00000460 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     460:	55                   	push   %ebp
     461:	89 e5                	mov    %esp,%ebp
     463:	57                   	push   %edi
     464:	56                   	push   %esi
     465:	53                   	push   %ebx
     466:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     469:	8b 45 08             	mov    0x8(%ebp),%eax
{
     46c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     46f:	8b 7d 10             	mov    0x10(%ebp),%edi
  s = *ps;
     472:	8b 30                	mov    (%eax),%esi
  while(s < es && strchr(whitespace, *s))
     474:	39 de                	cmp    %ebx,%esi
     476:	72 0f                	jb     487 <gettoken+0x27>
     478:	eb 25                	jmp    49f <gettoken+0x3f>
     47a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     480:	83 c6 01             	add    $0x1,%esi
  while(s < es && strchr(whitespace, *s))
     483:	39 f3                	cmp    %esi,%ebx
     485:	74 18                	je     49f <gettoken+0x3f>
     487:	0f be 06             	movsbl (%esi),%eax
     48a:	83 ec 08             	sub    $0x8,%esp
     48d:	50                   	push   %eax
     48e:	68 40 19 00 00       	push   $0x1940
     493:	e8 f8 06 00 00       	call   b90 <strchr>
     498:	83 c4 10             	add    $0x10,%esp
     49b:	85 c0                	test   %eax,%eax
     49d:	75 e1                	jne    480 <gettoken+0x20>
  if(q)
     49f:	85 ff                	test   %edi,%edi
     4a1:	74 02                	je     4a5 <gettoken+0x45>
    *q = s;
     4a3:	89 37                	mov    %esi,(%edi)
  ret = *s;
     4a5:	0f be 06             	movsbl (%esi),%eax
  switch(*s){
     4a8:	3c 29                	cmp    $0x29,%al
     4aa:	7f 54                	jg     500 <gettoken+0xa0>
     4ac:	3c 28                	cmp    $0x28,%al
     4ae:	0f 8d c8 00 00 00    	jge    57c <gettoken+0x11c>
     4b4:	31 ff                	xor    %edi,%edi
     4b6:	84 c0                	test   %al,%al
     4b8:	0f 85 d2 00 00 00    	jne    590 <gettoken+0x130>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     4be:	8b 55 14             	mov    0x14(%ebp),%edx
     4c1:	85 d2                	test   %edx,%edx
     4c3:	74 05                	je     4ca <gettoken+0x6a>
    *eq = s;
     4c5:	8b 45 14             	mov    0x14(%ebp),%eax
     4c8:	89 30                	mov    %esi,(%eax)

  while(s < es && strchr(whitespace, *s))
     4ca:	39 de                	cmp    %ebx,%esi
     4cc:	72 09                	jb     4d7 <gettoken+0x77>
     4ce:	eb 1f                	jmp    4ef <gettoken+0x8f>
    s++;
     4d0:	83 c6 01             	add    $0x1,%esi
  while(s < es && strchr(whitespace, *s))
     4d3:	39 f3                	cmp    %esi,%ebx
     4d5:	74 18                	je     4ef <gettoken+0x8f>
     4d7:	0f be 06             	movsbl (%esi),%eax
     4da:	83 ec 08             	sub    $0x8,%esp
     4dd:	50                   	push   %eax
     4de:	68 40 19 00 00       	push   $0x1940
     4e3:	e8 a8 06 00 00       	call   b90 <strchr>
     4e8:	83 c4 10             	add    $0x10,%esp
     4eb:	85 c0                	test   %eax,%eax
     4ed:	75 e1                	jne    4d0 <gettoken+0x70>
  *ps = s;
     4ef:	8b 45 08             	mov    0x8(%ebp),%eax
     4f2:	89 30                	mov    %esi,(%eax)
  return ret;
}
     4f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     4f7:	89 f8                	mov    %edi,%eax
     4f9:	5b                   	pop    %ebx
     4fa:	5e                   	pop    %esi
     4fb:	5f                   	pop    %edi
     4fc:	5d                   	pop    %ebp
     4fd:	c3                   	ret    
     4fe:	66 90                	xchg   %ax,%ax
  switch(*s){
     500:	3c 3e                	cmp    $0x3e,%al
     502:	75 1c                	jne    520 <gettoken+0xc0>
    if(*s == '>'){
     504:	80 7e 01 3e          	cmpb   $0x3e,0x1(%esi)
    s++;
     508:	8d 46 01             	lea    0x1(%esi),%eax
    if(*s == '>'){
     50b:	0f 84 a4 00 00 00    	je     5b5 <gettoken+0x155>
    s++;
     511:	89 c6                	mov    %eax,%esi
     513:	bf 3e 00 00 00       	mov    $0x3e,%edi
     518:	eb a4                	jmp    4be <gettoken+0x5e>
     51a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  switch(*s){
     520:	7f 56                	jg     578 <gettoken+0x118>
     522:	8d 48 c5             	lea    -0x3b(%eax),%ecx
     525:	80 f9 01             	cmp    $0x1,%cl
     528:	76 52                	jbe    57c <gettoken+0x11c>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     52a:	39 f3                	cmp    %esi,%ebx
     52c:	77 24                	ja     552 <gettoken+0xf2>
     52e:	eb 70                	jmp    5a0 <gettoken+0x140>
     530:	0f be 06             	movsbl (%esi),%eax
     533:	83 ec 08             	sub    $0x8,%esp
     536:	50                   	push   %eax
     537:	68 38 19 00 00       	push   $0x1938
     53c:	e8 4f 06 00 00       	call   b90 <strchr>
     541:	83 c4 10             	add    $0x10,%esp
     544:	85 c0                	test   %eax,%eax
     546:	75 1f                	jne    567 <gettoken+0x107>
      s++;
     548:	83 c6 01             	add    $0x1,%esi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     54b:	39 f3                	cmp    %esi,%ebx
     54d:	74 51                	je     5a0 <gettoken+0x140>
     54f:	0f be 06             	movsbl (%esi),%eax
     552:	83 ec 08             	sub    $0x8,%esp
     555:	50                   	push   %eax
     556:	68 40 19 00 00       	push   $0x1940
     55b:	e8 30 06 00 00       	call   b90 <strchr>
     560:	83 c4 10             	add    $0x10,%esp
     563:	85 c0                	test   %eax,%eax
     565:	74 c9                	je     530 <gettoken+0xd0>
    ret = 'a';
     567:	bf 61 00 00 00       	mov    $0x61,%edi
     56c:	e9 4d ff ff ff       	jmp    4be <gettoken+0x5e>
     571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     578:	3c 7c                	cmp    $0x7c,%al
     57a:	75 ae                	jne    52a <gettoken+0xca>
  ret = *s;
     57c:	0f be f8             	movsbl %al,%edi
    s++;
     57f:	83 c6 01             	add    $0x1,%esi
    break;
     582:	e9 37 ff ff ff       	jmp    4be <gettoken+0x5e>
     587:	89 f6                	mov    %esi,%esi
     589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  switch(*s){
     590:	3c 26                	cmp    $0x26,%al
     592:	75 96                	jne    52a <gettoken+0xca>
     594:	eb e6                	jmp    57c <gettoken+0x11c>
     596:	8d 76 00             	lea    0x0(%esi),%esi
     599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(eq)
     5a0:	8b 45 14             	mov    0x14(%ebp),%eax
     5a3:	bf 61 00 00 00       	mov    $0x61,%edi
     5a8:	85 c0                	test   %eax,%eax
     5aa:	0f 85 15 ff ff ff    	jne    4c5 <gettoken+0x65>
     5b0:	e9 3a ff ff ff       	jmp    4ef <gettoken+0x8f>
      s++;
     5b5:	83 c6 02             	add    $0x2,%esi
      ret = '+';
     5b8:	bf 2b 00 00 00       	mov    $0x2b,%edi
     5bd:	e9 fc fe ff ff       	jmp    4be <gettoken+0x5e>
     5c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005d0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     5d0:	55                   	push   %ebp
     5d1:	89 e5                	mov    %esp,%ebp
     5d3:	57                   	push   %edi
     5d4:	56                   	push   %esi
     5d5:	53                   	push   %ebx
     5d6:	83 ec 0c             	sub    $0xc,%esp
     5d9:	8b 7d 08             	mov    0x8(%ebp),%edi
     5dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     5df:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     5e1:	39 f3                	cmp    %esi,%ebx
     5e3:	72 12                	jb     5f7 <peek+0x27>
     5e5:	eb 28                	jmp    60f <peek+0x3f>
     5e7:	89 f6                	mov    %esi,%esi
     5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    s++;
     5f0:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     5f3:	39 de                	cmp    %ebx,%esi
     5f5:	74 18                	je     60f <peek+0x3f>
     5f7:	0f be 03             	movsbl (%ebx),%eax
     5fa:	83 ec 08             	sub    $0x8,%esp
     5fd:	50                   	push   %eax
     5fe:	68 40 19 00 00       	push   $0x1940
     603:	e8 88 05 00 00       	call   b90 <strchr>
     608:	83 c4 10             	add    $0x10,%esp
     60b:	85 c0                	test   %eax,%eax
     60d:	75 e1                	jne    5f0 <peek+0x20>
  *ps = s;
     60f:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     611:	0f be 13             	movsbl (%ebx),%edx
     614:	31 c0                	xor    %eax,%eax
     616:	84 d2                	test   %dl,%dl
     618:	74 17                	je     631 <peek+0x61>
     61a:	83 ec 08             	sub    $0x8,%esp
     61d:	52                   	push   %edx
     61e:	ff 75 10             	pushl  0x10(%ebp)
     621:	e8 6a 05 00 00       	call   b90 <strchr>
     626:	83 c4 10             	add    $0x10,%esp
     629:	85 c0                	test   %eax,%eax
     62b:	0f 95 c0             	setne  %al
     62e:	0f b6 c0             	movzbl %al,%eax
}
     631:	8d 65 f4             	lea    -0xc(%ebp),%esp
     634:	5b                   	pop    %ebx
     635:	5e                   	pop    %esi
     636:	5f                   	pop    %edi
     637:	5d                   	pop    %ebp
     638:	c3                   	ret    
     639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000640 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     640:	55                   	push   %ebp
     641:	89 e5                	mov    %esp,%ebp
     643:	57                   	push   %edi
     644:	56                   	push   %esi
     645:	53                   	push   %ebx
     646:	83 ec 1c             	sub    $0x1c,%esp
     649:	8b 75 0c             	mov    0xc(%ebp),%esi
     64c:	8b 5d 10             	mov    0x10(%ebp),%ebx
     64f:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     650:	83 ec 04             	sub    $0x4,%esp
     653:	68 9b 12 00 00       	push   $0x129b
     658:	53                   	push   %ebx
     659:	56                   	push   %esi
     65a:	e8 71 ff ff ff       	call   5d0 <peek>
     65f:	83 c4 10             	add    $0x10,%esp
     662:	85 c0                	test   %eax,%eax
     664:	74 6a                	je     6d0 <parseredirs+0x90>
    tok = gettoken(ps, es, 0, 0);
     666:	6a 00                	push   $0x0
     668:	6a 00                	push   $0x0
     66a:	53                   	push   %ebx
     66b:	56                   	push   %esi
     66c:	e8 ef fd ff ff       	call   460 <gettoken>
     671:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     673:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     676:	50                   	push   %eax
     677:	8d 45 e0             	lea    -0x20(%ebp),%eax
     67a:	50                   	push   %eax
     67b:	53                   	push   %ebx
     67c:	56                   	push   %esi
     67d:	e8 de fd ff ff       	call   460 <gettoken>
     682:	83 c4 20             	add    $0x20,%esp
     685:	83 f8 61             	cmp    $0x61,%eax
     688:	75 51                	jne    6db <parseredirs+0x9b>
      panic("missing file for redirection");
    switch(tok){
     68a:	83 ff 3c             	cmp    $0x3c,%edi
     68d:	74 31                	je     6c0 <parseredirs+0x80>
     68f:	83 ff 3e             	cmp    $0x3e,%edi
     692:	74 05                	je     699 <parseredirs+0x59>
     694:	83 ff 2b             	cmp    $0x2b,%edi
     697:	75 b7                	jne    650 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     699:	83 ec 0c             	sub    $0xc,%esp
     69c:	6a 01                	push   $0x1
     69e:	68 01 02 00 00       	push   $0x201
     6a3:	ff 75 e4             	pushl  -0x1c(%ebp)
     6a6:	ff 75 e0             	pushl  -0x20(%ebp)
     6a9:	ff 75 08             	pushl  0x8(%ebp)
     6ac:	e8 af fc ff ff       	call   360 <redircmd>
      break;
     6b1:	83 c4 20             	add    $0x20,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     6b4:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     6b7:	eb 97                	jmp    650 <parseredirs+0x10>
     6b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     6c0:	83 ec 0c             	sub    $0xc,%esp
     6c3:	6a 00                	push   $0x0
     6c5:	6a 00                	push   $0x0
     6c7:	eb da                	jmp    6a3 <parseredirs+0x63>
     6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  return cmd;
}
     6d0:	8b 45 08             	mov    0x8(%ebp),%eax
     6d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6d6:	5b                   	pop    %ebx
     6d7:	5e                   	pop    %esi
     6d8:	5f                   	pop    %edi
     6d9:	5d                   	pop    %ebp
     6da:	c3                   	ret    
      panic("missing file for redirection");
     6db:	83 ec 0c             	sub    $0xc,%esp
     6de:	68 7e 12 00 00       	push   $0x127e
     6e3:	e8 68 fa ff ff       	call   150 <panic>
     6e8:	90                   	nop
     6e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006f0 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     6f0:	55                   	push   %ebp
     6f1:	89 e5                	mov    %esp,%ebp
     6f3:	57                   	push   %edi
     6f4:	56                   	push   %esi
     6f5:	53                   	push   %ebx
     6f6:	83 ec 30             	sub    $0x30,%esp
     6f9:	8b 75 08             	mov    0x8(%ebp),%esi
     6fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     6ff:	68 9e 12 00 00       	push   $0x129e
     704:	57                   	push   %edi
     705:	56                   	push   %esi
     706:	e8 c5 fe ff ff       	call   5d0 <peek>
     70b:	83 c4 10             	add    $0x10,%esp
     70e:	85 c0                	test   %eax,%eax
     710:	0f 85 92 00 00 00    	jne    7a8 <parseexec+0xb8>
     716:	89 c3                	mov    %eax,%ebx
    return parseblock(ps, es);

  ret = execcmd();
     718:	e8 13 fc ff ff       	call   330 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     71d:	83 ec 04             	sub    $0x4,%esp
  ret = execcmd();
     720:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = parseredirs(ret, ps, es);
     723:	57                   	push   %edi
     724:	56                   	push   %esi
     725:	50                   	push   %eax
     726:	e8 15 ff ff ff       	call   640 <parseredirs>
     72b:	83 c4 10             	add    $0x10,%esp
     72e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     731:	eb 18                	jmp    74b <parseexec+0x5b>
     733:	90                   	nop
     734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     738:	83 ec 04             	sub    $0x4,%esp
     73b:	57                   	push   %edi
     73c:	56                   	push   %esi
     73d:	ff 75 d4             	pushl  -0x2c(%ebp)
     740:	e8 fb fe ff ff       	call   640 <parseredirs>
     745:	83 c4 10             	add    $0x10,%esp
     748:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     74b:	83 ec 04             	sub    $0x4,%esp
     74e:	68 b5 12 00 00       	push   $0x12b5
     753:	57                   	push   %edi
     754:	56                   	push   %esi
     755:	e8 76 fe ff ff       	call   5d0 <peek>
     75a:	83 c4 10             	add    $0x10,%esp
     75d:	85 c0                	test   %eax,%eax
     75f:	75 67                	jne    7c8 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     761:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     764:	50                   	push   %eax
     765:	8d 45 e0             	lea    -0x20(%ebp),%eax
     768:	50                   	push   %eax
     769:	57                   	push   %edi
     76a:	56                   	push   %esi
     76b:	e8 f0 fc ff ff       	call   460 <gettoken>
     770:	83 c4 10             	add    $0x10,%esp
     773:	85 c0                	test   %eax,%eax
     775:	74 51                	je     7c8 <parseexec+0xd8>
    if(tok != 'a')
     777:	83 f8 61             	cmp    $0x61,%eax
     77a:	75 6b                	jne    7e7 <parseexec+0xf7>
    cmd->argv[argc] = q;
     77c:	8b 45 e0             	mov    -0x20(%ebp),%eax
     77f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     782:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
     786:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     789:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
     78d:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
     790:	83 fb 0a             	cmp    $0xa,%ebx
     793:	75 a3                	jne    738 <parseexec+0x48>
      panic("too many args");
     795:	83 ec 0c             	sub    $0xc,%esp
     798:	68 a7 12 00 00       	push   $0x12a7
     79d:	e8 ae f9 ff ff       	call   150 <panic>
     7a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     7a8:	83 ec 08             	sub    $0x8,%esp
     7ab:	57                   	push   %edi
     7ac:	56                   	push   %esi
     7ad:	e8 5e 01 00 00       	call   910 <parseblock>
     7b2:	83 c4 10             	add    $0x10,%esp
     7b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     7b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7be:	5b                   	pop    %ebx
     7bf:	5e                   	pop    %esi
     7c0:	5f                   	pop    %edi
     7c1:	5d                   	pop    %ebp
     7c2:	c3                   	ret    
     7c3:	90                   	nop
     7c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     7c8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     7cb:	8d 04 98             	lea    (%eax,%ebx,4),%eax
  cmd->argv[argc] = 0;
     7ce:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     7d5:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     7dc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7df:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7e2:	5b                   	pop    %ebx
     7e3:	5e                   	pop    %esi
     7e4:	5f                   	pop    %edi
     7e5:	5d                   	pop    %ebp
     7e6:	c3                   	ret    
      panic("syntax");
     7e7:	83 ec 0c             	sub    $0xc,%esp
     7ea:	68 a0 12 00 00       	push   $0x12a0
     7ef:	e8 5c f9 ff ff       	call   150 <panic>
     7f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     7fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000800 <parsepipe>:
{
     800:	55                   	push   %ebp
     801:	89 e5                	mov    %esp,%ebp
     803:	57                   	push   %edi
     804:	56                   	push   %esi
     805:	53                   	push   %ebx
     806:	83 ec 14             	sub    $0x14,%esp
     809:	8b 5d 08             	mov    0x8(%ebp),%ebx
     80c:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parseexec(ps, es);
     80f:	56                   	push   %esi
     810:	53                   	push   %ebx
     811:	e8 da fe ff ff       	call   6f0 <parseexec>
  if(peek(ps, es, "|")){
     816:	83 c4 0c             	add    $0xc,%esp
  cmd = parseexec(ps, es);
     819:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     81b:	68 ba 12 00 00       	push   $0x12ba
     820:	56                   	push   %esi
     821:	53                   	push   %ebx
     822:	e8 a9 fd ff ff       	call   5d0 <peek>
     827:	83 c4 10             	add    $0x10,%esp
     82a:	85 c0                	test   %eax,%eax
     82c:	75 12                	jne    840 <parsepipe+0x40>
}
     82e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     831:	89 f8                	mov    %edi,%eax
     833:	5b                   	pop    %ebx
     834:	5e                   	pop    %esi
     835:	5f                   	pop    %edi
     836:	5d                   	pop    %ebp
     837:	c3                   	ret    
     838:	90                   	nop
     839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    gettoken(ps, es, 0, 0);
     840:	6a 00                	push   $0x0
     842:	6a 00                	push   $0x0
     844:	56                   	push   %esi
     845:	53                   	push   %ebx
     846:	e8 15 fc ff ff       	call   460 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     84b:	58                   	pop    %eax
     84c:	5a                   	pop    %edx
     84d:	56                   	push   %esi
     84e:	53                   	push   %ebx
     84f:	e8 ac ff ff ff       	call   800 <parsepipe>
     854:	89 7d 08             	mov    %edi,0x8(%ebp)
     857:	89 45 0c             	mov    %eax,0xc(%ebp)
     85a:	83 c4 10             	add    $0x10,%esp
}
     85d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     860:	5b                   	pop    %ebx
     861:	5e                   	pop    %esi
     862:	5f                   	pop    %edi
     863:	5d                   	pop    %ebp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     864:	e9 47 fb ff ff       	jmp    3b0 <pipecmd>
     869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000870 <parseline>:
{
     870:	55                   	push   %ebp
     871:	89 e5                	mov    %esp,%ebp
     873:	57                   	push   %edi
     874:	56                   	push   %esi
     875:	53                   	push   %ebx
     876:	83 ec 14             	sub    $0x14,%esp
     879:	8b 5d 08             	mov    0x8(%ebp),%ebx
     87c:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parsepipe(ps, es);
     87f:	56                   	push   %esi
     880:	53                   	push   %ebx
     881:	e8 7a ff ff ff       	call   800 <parsepipe>
  while(peek(ps, es, "&")){
     886:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     889:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     88b:	eb 1b                	jmp    8a8 <parseline+0x38>
     88d:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     890:	6a 00                	push   $0x0
     892:	6a 00                	push   $0x0
     894:	56                   	push   %esi
     895:	53                   	push   %ebx
     896:	e8 c5 fb ff ff       	call   460 <gettoken>
    cmd = backcmd(cmd);
     89b:	89 3c 24             	mov    %edi,(%esp)
     89e:	e8 8d fb ff ff       	call   430 <backcmd>
     8a3:	83 c4 10             	add    $0x10,%esp
     8a6:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     8a8:	83 ec 04             	sub    $0x4,%esp
     8ab:	68 bc 12 00 00       	push   $0x12bc
     8b0:	56                   	push   %esi
     8b1:	53                   	push   %ebx
     8b2:	e8 19 fd ff ff       	call   5d0 <peek>
     8b7:	83 c4 10             	add    $0x10,%esp
     8ba:	85 c0                	test   %eax,%eax
     8bc:	75 d2                	jne    890 <parseline+0x20>
  if(peek(ps, es, ";")){
     8be:	83 ec 04             	sub    $0x4,%esp
     8c1:	68 b8 12 00 00       	push   $0x12b8
     8c6:	56                   	push   %esi
     8c7:	53                   	push   %ebx
     8c8:	e8 03 fd ff ff       	call   5d0 <peek>
     8cd:	83 c4 10             	add    $0x10,%esp
     8d0:	85 c0                	test   %eax,%eax
     8d2:	75 0c                	jne    8e0 <parseline+0x70>
}
     8d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8d7:	89 f8                	mov    %edi,%eax
     8d9:	5b                   	pop    %ebx
     8da:	5e                   	pop    %esi
     8db:	5f                   	pop    %edi
     8dc:	5d                   	pop    %ebp
     8dd:	c3                   	ret    
     8de:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     8e0:	6a 00                	push   $0x0
     8e2:	6a 00                	push   $0x0
     8e4:	56                   	push   %esi
     8e5:	53                   	push   %ebx
     8e6:	e8 75 fb ff ff       	call   460 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     8eb:	58                   	pop    %eax
     8ec:	5a                   	pop    %edx
     8ed:	56                   	push   %esi
     8ee:	53                   	push   %ebx
     8ef:	e8 7c ff ff ff       	call   870 <parseline>
     8f4:	89 7d 08             	mov    %edi,0x8(%ebp)
     8f7:	89 45 0c             	mov    %eax,0xc(%ebp)
     8fa:	83 c4 10             	add    $0x10,%esp
}
     8fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
     900:	5b                   	pop    %ebx
     901:	5e                   	pop    %esi
     902:	5f                   	pop    %edi
     903:	5d                   	pop    %ebp
    cmd = listcmd(cmd, parseline(ps, es));
     904:	e9 e7 fa ff ff       	jmp    3f0 <listcmd>
     909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000910 <parseblock>:
{
     910:	55                   	push   %ebp
     911:	89 e5                	mov    %esp,%ebp
     913:	57                   	push   %edi
     914:	56                   	push   %esi
     915:	53                   	push   %ebx
     916:	83 ec 10             	sub    $0x10,%esp
     919:	8b 5d 08             	mov    0x8(%ebp),%ebx
     91c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     91f:	68 9e 12 00 00       	push   $0x129e
     924:	56                   	push   %esi
     925:	53                   	push   %ebx
     926:	e8 a5 fc ff ff       	call   5d0 <peek>
     92b:	83 c4 10             	add    $0x10,%esp
     92e:	85 c0                	test   %eax,%eax
     930:	74 4a                	je     97c <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     932:	6a 00                	push   $0x0
     934:	6a 00                	push   $0x0
     936:	56                   	push   %esi
     937:	53                   	push   %ebx
     938:	e8 23 fb ff ff       	call   460 <gettoken>
  cmd = parseline(ps, es);
     93d:	58                   	pop    %eax
     93e:	5a                   	pop    %edx
     93f:	56                   	push   %esi
     940:	53                   	push   %ebx
     941:	e8 2a ff ff ff       	call   870 <parseline>
  if(!peek(ps, es, ")"))
     946:	83 c4 0c             	add    $0xc,%esp
  cmd = parseline(ps, es);
     949:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     94b:	68 da 12 00 00       	push   $0x12da
     950:	56                   	push   %esi
     951:	53                   	push   %ebx
     952:	e8 79 fc ff ff       	call   5d0 <peek>
     957:	83 c4 10             	add    $0x10,%esp
     95a:	85 c0                	test   %eax,%eax
     95c:	74 2b                	je     989 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     95e:	6a 00                	push   $0x0
     960:	6a 00                	push   $0x0
     962:	56                   	push   %esi
     963:	53                   	push   %ebx
     964:	e8 f7 fa ff ff       	call   460 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     969:	83 c4 0c             	add    $0xc,%esp
     96c:	56                   	push   %esi
     96d:	53                   	push   %ebx
     96e:	57                   	push   %edi
     96f:	e8 cc fc ff ff       	call   640 <parseredirs>
}
     974:	8d 65 f4             	lea    -0xc(%ebp),%esp
     977:	5b                   	pop    %ebx
     978:	5e                   	pop    %esi
     979:	5f                   	pop    %edi
     97a:	5d                   	pop    %ebp
     97b:	c3                   	ret    
    panic("parseblock");
     97c:	83 ec 0c             	sub    $0xc,%esp
     97f:	68 be 12 00 00       	push   $0x12be
     984:	e8 c7 f7 ff ff       	call   150 <panic>
    panic("syntax - missing )");
     989:	83 ec 0c             	sub    $0xc,%esp
     98c:	68 c9 12 00 00       	push   $0x12c9
     991:	e8 ba f7 ff ff       	call   150 <panic>
     996:	8d 76 00             	lea    0x0(%esi),%esi
     999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009a0 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     9a0:	55                   	push   %ebp
     9a1:	89 e5                	mov    %esp,%ebp
     9a3:	53                   	push   %ebx
     9a4:	83 ec 04             	sub    $0x4,%esp
     9a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     9aa:	85 db                	test   %ebx,%ebx
     9ac:	74 20                	je     9ce <nulterminate+0x2e>
    return 0;

  switch(cmd->type){
     9ae:	83 3b 05             	cmpl   $0x5,(%ebx)
     9b1:	77 1b                	ja     9ce <nulterminate+0x2e>
     9b3:	8b 03                	mov    (%ebx),%eax
     9b5:	ff 24 85 1c 13 00 00 	jmp    *0x131c(,%eax,4)
     9bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
     9c0:	83 ec 0c             	sub    $0xc,%esp
     9c3:	ff 73 04             	pushl  0x4(%ebx)
     9c6:	e8 d5 ff ff ff       	call   9a0 <nulterminate>
    break;
     9cb:	83 c4 10             	add    $0x10,%esp
  }
  return cmd;
}
     9ce:	89 d8                	mov    %ebx,%eax
     9d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     9d3:	c9                   	leave  
     9d4:	c3                   	ret    
     9d5:	8d 76 00             	lea    0x0(%esi),%esi
    nulterminate(lcmd->left);
     9d8:	83 ec 0c             	sub    $0xc,%esp
     9db:	ff 73 04             	pushl  0x4(%ebx)
     9de:	e8 bd ff ff ff       	call   9a0 <nulterminate>
    nulterminate(lcmd->right);
     9e3:	58                   	pop    %eax
     9e4:	ff 73 08             	pushl  0x8(%ebx)
     9e7:	e8 b4 ff ff ff       	call   9a0 <nulterminate>
}
     9ec:	89 d8                	mov    %ebx,%eax
    break;
     9ee:	83 c4 10             	add    $0x10,%esp
}
     9f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     9f4:	c9                   	leave  
     9f5:	c3                   	ret    
     9f6:	8d 76 00             	lea    0x0(%esi),%esi
     9f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for(i=0; ecmd->argv[i]; i++)
     a00:	8b 4b 04             	mov    0x4(%ebx),%ecx
     a03:	8d 43 08             	lea    0x8(%ebx),%eax
     a06:	85 c9                	test   %ecx,%ecx
     a08:	74 c4                	je     9ce <nulterminate+0x2e>
     a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     a10:	8b 50 24             	mov    0x24(%eax),%edx
     a13:	83 c0 04             	add    $0x4,%eax
     a16:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     a19:	8b 50 fc             	mov    -0x4(%eax),%edx
     a1c:	85 d2                	test   %edx,%edx
     a1e:	75 f0                	jne    a10 <nulterminate+0x70>
}
     a20:	89 d8                	mov    %ebx,%eax
     a22:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a25:	c9                   	leave  
     a26:	c3                   	ret    
     a27:	89 f6                	mov    %esi,%esi
     a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    nulterminate(rcmd->cmd);
     a30:	83 ec 0c             	sub    $0xc,%esp
     a33:	ff 73 04             	pushl  0x4(%ebx)
     a36:	e8 65 ff ff ff       	call   9a0 <nulterminate>
    *rcmd->efile = 0;
     a3b:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     a3e:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     a41:	c6 00 00             	movb   $0x0,(%eax)
}
     a44:	89 d8                	mov    %ebx,%eax
     a46:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a49:	c9                   	leave  
     a4a:	c3                   	ret    
     a4b:	90                   	nop
     a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a50 <parsecmd>:
{
     a50:	55                   	push   %ebp
     a51:	89 e5                	mov    %esp,%ebp
     a53:	56                   	push   %esi
     a54:	53                   	push   %ebx
  es = s + strlen(s);
     a55:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a58:	83 ec 0c             	sub    $0xc,%esp
     a5b:	53                   	push   %ebx
     a5c:	e8 df 00 00 00       	call   b40 <strlen>
  cmd = parseline(&s, es);
     a61:	59                   	pop    %ecx
  es = s + strlen(s);
     a62:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     a64:	8d 45 08             	lea    0x8(%ebp),%eax
     a67:	5e                   	pop    %esi
     a68:	53                   	push   %ebx
     a69:	50                   	push   %eax
     a6a:	e8 01 fe ff ff       	call   870 <parseline>
     a6f:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     a71:	8d 45 08             	lea    0x8(%ebp),%eax
     a74:	83 c4 0c             	add    $0xc,%esp
     a77:	68 63 12 00 00       	push   $0x1263
     a7c:	53                   	push   %ebx
     a7d:	50                   	push   %eax
     a7e:	e8 4d fb ff ff       	call   5d0 <peek>
  if(s != es){
     a83:	8b 45 08             	mov    0x8(%ebp),%eax
     a86:	83 c4 10             	add    $0x10,%esp
     a89:	39 d8                	cmp    %ebx,%eax
     a8b:	75 12                	jne    a9f <parsecmd+0x4f>
  nulterminate(cmd);
     a8d:	83 ec 0c             	sub    $0xc,%esp
     a90:	56                   	push   %esi
     a91:	e8 0a ff ff ff       	call   9a0 <nulterminate>
}
     a96:	8d 65 f8             	lea    -0x8(%ebp),%esp
     a99:	89 f0                	mov    %esi,%eax
     a9b:	5b                   	pop    %ebx
     a9c:	5e                   	pop    %esi
     a9d:	5d                   	pop    %ebp
     a9e:	c3                   	ret    
    fprintf(2, "leftovers: %s\n", s);
     a9f:	52                   	push   %edx
     aa0:	50                   	push   %eax
     aa1:	68 dc 12 00 00       	push   $0x12dc
     aa6:	6a 02                	push   $0x2
     aa8:	e8 d3 05 00 00       	call   1080 <fprintf>
    panic("syntax");
     aad:	c7 04 24 a0 12 00 00 	movl   $0x12a0,(%esp)
     ab4:	e8 97 f6 ff ff       	call   150 <panic>
     ab9:	66 90                	xchg   %ax,%ax
     abb:	66 90                	xchg   %ax,%ax
     abd:	66 90                	xchg   %ax,%ax
     abf:	90                   	nop

00000ac0 <strcpy>:
     ac0:	55                   	push   %ebp
     ac1:	89 e5                	mov    %esp,%ebp
     ac3:	53                   	push   %ebx
     ac4:	8b 45 08             	mov    0x8(%ebp),%eax
     ac7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     aca:	89 c2                	mov    %eax,%edx
     acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ad0:	83 c1 01             	add    $0x1,%ecx
     ad3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     ad7:	83 c2 01             	add    $0x1,%edx
     ada:	84 db                	test   %bl,%bl
     adc:	88 5a ff             	mov    %bl,-0x1(%edx)
     adf:	75 ef                	jne    ad0 <strcpy+0x10>
     ae1:	5b                   	pop    %ebx
     ae2:	5d                   	pop    %ebp
     ae3:	c3                   	ret    
     ae4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     aea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000af0 <strcmp>:
     af0:	55                   	push   %ebp
     af1:	89 e5                	mov    %esp,%ebp
     af3:	53                   	push   %ebx
     af4:	8b 55 08             	mov    0x8(%ebp),%edx
     af7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     afa:	0f b6 02             	movzbl (%edx),%eax
     afd:	0f b6 19             	movzbl (%ecx),%ebx
     b00:	84 c0                	test   %al,%al
     b02:	75 1c                	jne    b20 <strcmp+0x30>
     b04:	eb 2a                	jmp    b30 <strcmp+0x40>
     b06:	8d 76 00             	lea    0x0(%esi),%esi
     b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     b10:	83 c2 01             	add    $0x1,%edx
     b13:	0f b6 02             	movzbl (%edx),%eax
     b16:	83 c1 01             	add    $0x1,%ecx
     b19:	0f b6 19             	movzbl (%ecx),%ebx
     b1c:	84 c0                	test   %al,%al
     b1e:	74 10                	je     b30 <strcmp+0x40>
     b20:	38 d8                	cmp    %bl,%al
     b22:	74 ec                	je     b10 <strcmp+0x20>
     b24:	29 d8                	sub    %ebx,%eax
     b26:	5b                   	pop    %ebx
     b27:	5d                   	pop    %ebp
     b28:	c3                   	ret    
     b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b30:	31 c0                	xor    %eax,%eax
     b32:	29 d8                	sub    %ebx,%eax
     b34:	5b                   	pop    %ebx
     b35:	5d                   	pop    %ebp
     b36:	c3                   	ret    
     b37:	89 f6                	mov    %esi,%esi
     b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b40 <strlen>:
     b40:	55                   	push   %ebp
     b41:	89 e5                	mov    %esp,%ebp
     b43:	8b 4d 08             	mov    0x8(%ebp),%ecx
     b46:	80 39 00             	cmpb   $0x0,(%ecx)
     b49:	74 15                	je     b60 <strlen+0x20>
     b4b:	31 d2                	xor    %edx,%edx
     b4d:	8d 76 00             	lea    0x0(%esi),%esi
     b50:	83 c2 01             	add    $0x1,%edx
     b53:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     b57:	89 d0                	mov    %edx,%eax
     b59:	75 f5                	jne    b50 <strlen+0x10>
     b5b:	5d                   	pop    %ebp
     b5c:	c3                   	ret    
     b5d:	8d 76 00             	lea    0x0(%esi),%esi
     b60:	31 c0                	xor    %eax,%eax
     b62:	5d                   	pop    %ebp
     b63:	c3                   	ret    
     b64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b70 <memset>:
     b70:	55                   	push   %ebp
     b71:	89 e5                	mov    %esp,%ebp
     b73:	57                   	push   %edi
     b74:	8b 55 08             	mov    0x8(%ebp),%edx
     b77:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b7a:	8b 45 0c             	mov    0xc(%ebp),%eax
     b7d:	89 d7                	mov    %edx,%edi
     b7f:	fc                   	cld    
     b80:	f3 aa                	rep stos %al,%es:(%edi)
     b82:	89 d0                	mov    %edx,%eax
     b84:	5f                   	pop    %edi
     b85:	5d                   	pop    %ebp
     b86:	c3                   	ret    
     b87:	89 f6                	mov    %esi,%esi
     b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b90 <strchr>:
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	53                   	push   %ebx
     b94:	8b 45 08             	mov    0x8(%ebp),%eax
     b97:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     b9a:	0f b6 10             	movzbl (%eax),%edx
     b9d:	84 d2                	test   %dl,%dl
     b9f:	74 1d                	je     bbe <strchr+0x2e>
     ba1:	38 d3                	cmp    %dl,%bl
     ba3:	89 d9                	mov    %ebx,%ecx
     ba5:	75 0d                	jne    bb4 <strchr+0x24>
     ba7:	eb 17                	jmp    bc0 <strchr+0x30>
     ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bb0:	38 ca                	cmp    %cl,%dl
     bb2:	74 0c                	je     bc0 <strchr+0x30>
     bb4:	83 c0 01             	add    $0x1,%eax
     bb7:	0f b6 10             	movzbl (%eax),%edx
     bba:	84 d2                	test   %dl,%dl
     bbc:	75 f2                	jne    bb0 <strchr+0x20>
     bbe:	31 c0                	xor    %eax,%eax
     bc0:	5b                   	pop    %ebx
     bc1:	5d                   	pop    %ebp
     bc2:	c3                   	ret    
     bc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bd0 <gets>:
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
     bd3:	57                   	push   %edi
     bd4:	56                   	push   %esi
     bd5:	53                   	push   %ebx
     bd6:	31 f6                	xor    %esi,%esi
     bd8:	89 f3                	mov    %esi,%ebx
     bda:	83 ec 1c             	sub    $0x1c,%esp
     bdd:	8b 7d 08             	mov    0x8(%ebp),%edi
     be0:	eb 2f                	jmp    c11 <gets+0x41>
     be2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     be8:	8d 45 e7             	lea    -0x19(%ebp),%eax
     beb:	83 ec 04             	sub    $0x4,%esp
     bee:	6a 01                	push   $0x1
     bf0:	50                   	push   %eax
     bf1:	6a 00                	push   $0x0
     bf3:	e8 32 01 00 00       	call   d2a <read>
     bf8:	83 c4 10             	add    $0x10,%esp
     bfb:	85 c0                	test   %eax,%eax
     bfd:	7e 1c                	jle    c1b <gets+0x4b>
     bff:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     c03:	83 c7 01             	add    $0x1,%edi
     c06:	88 47 ff             	mov    %al,-0x1(%edi)
     c09:	3c 0a                	cmp    $0xa,%al
     c0b:	74 23                	je     c30 <gets+0x60>
     c0d:	3c 0d                	cmp    $0xd,%al
     c0f:	74 1f                	je     c30 <gets+0x60>
     c11:	83 c3 01             	add    $0x1,%ebx
     c14:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     c17:	89 fe                	mov    %edi,%esi
     c19:	7c cd                	jl     be8 <gets+0x18>
     c1b:	89 f3                	mov    %esi,%ebx
     c1d:	8b 45 08             	mov    0x8(%ebp),%eax
     c20:	c6 03 00             	movb   $0x0,(%ebx)
     c23:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c26:	5b                   	pop    %ebx
     c27:	5e                   	pop    %esi
     c28:	5f                   	pop    %edi
     c29:	5d                   	pop    %ebp
     c2a:	c3                   	ret    
     c2b:	90                   	nop
     c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c30:	8b 75 08             	mov    0x8(%ebp),%esi
     c33:	8b 45 08             	mov    0x8(%ebp),%eax
     c36:	01 de                	add    %ebx,%esi
     c38:	89 f3                	mov    %esi,%ebx
     c3a:	c6 03 00             	movb   $0x0,(%ebx)
     c3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c40:	5b                   	pop    %ebx
     c41:	5e                   	pop    %esi
     c42:	5f                   	pop    %edi
     c43:	5d                   	pop    %ebp
     c44:	c3                   	ret    
     c45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c50 <stat>:
     c50:	55                   	push   %ebp
     c51:	89 e5                	mov    %esp,%ebp
     c53:	56                   	push   %esi
     c54:	53                   	push   %ebx
     c55:	83 ec 08             	sub    $0x8,%esp
     c58:	6a 00                	push   $0x0
     c5a:	ff 75 08             	pushl  0x8(%ebp)
     c5d:	e8 f0 00 00 00       	call   d52 <open>
     c62:	83 c4 10             	add    $0x10,%esp
     c65:	85 c0                	test   %eax,%eax
     c67:	78 27                	js     c90 <stat+0x40>
     c69:	83 ec 08             	sub    $0x8,%esp
     c6c:	ff 75 0c             	pushl  0xc(%ebp)
     c6f:	89 c3                	mov    %eax,%ebx
     c71:	50                   	push   %eax
     c72:	e8 f3 00 00 00       	call   d6a <fstat>
     c77:	89 1c 24             	mov    %ebx,(%esp)
     c7a:	89 c6                	mov    %eax,%esi
     c7c:	e8 b9 00 00 00       	call   d3a <close>
     c81:	83 c4 10             	add    $0x10,%esp
     c84:	8d 65 f8             	lea    -0x8(%ebp),%esp
     c87:	89 f0                	mov    %esi,%eax
     c89:	5b                   	pop    %ebx
     c8a:	5e                   	pop    %esi
     c8b:	5d                   	pop    %ebp
     c8c:	c3                   	ret    
     c8d:	8d 76 00             	lea    0x0(%esi),%esi
     c90:	be ff ff ff ff       	mov    $0xffffffff,%esi
     c95:	eb ed                	jmp    c84 <stat+0x34>
     c97:	89 f6                	mov    %esi,%esi
     c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ca0 <atoi>:
     ca0:	55                   	push   %ebp
     ca1:	89 e5                	mov    %esp,%ebp
     ca3:	53                   	push   %ebx
     ca4:	8b 4d 08             	mov    0x8(%ebp),%ecx
     ca7:	0f be 11             	movsbl (%ecx),%edx
     caa:	8d 42 d0             	lea    -0x30(%edx),%eax
     cad:	3c 09                	cmp    $0x9,%al
     caf:	b8 00 00 00 00       	mov    $0x0,%eax
     cb4:	77 1f                	ja     cd5 <atoi+0x35>
     cb6:	8d 76 00             	lea    0x0(%esi),%esi
     cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     cc0:	8d 04 80             	lea    (%eax,%eax,4),%eax
     cc3:	83 c1 01             	add    $0x1,%ecx
     cc6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
     cca:	0f be 11             	movsbl (%ecx),%edx
     ccd:	8d 5a d0             	lea    -0x30(%edx),%ebx
     cd0:	80 fb 09             	cmp    $0x9,%bl
     cd3:	76 eb                	jbe    cc0 <atoi+0x20>
     cd5:	5b                   	pop    %ebx
     cd6:	5d                   	pop    %ebp
     cd7:	c3                   	ret    
     cd8:	90                   	nop
     cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ce0 <memmove>:
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
     ce3:	56                   	push   %esi
     ce4:	53                   	push   %ebx
     ce5:	8b 5d 10             	mov    0x10(%ebp),%ebx
     ce8:	8b 45 08             	mov    0x8(%ebp),%eax
     ceb:	8b 75 0c             	mov    0xc(%ebp),%esi
     cee:	85 db                	test   %ebx,%ebx
     cf0:	7e 14                	jle    d06 <memmove+0x26>
     cf2:	31 d2                	xor    %edx,%edx
     cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     cf8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     cfc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     cff:	83 c2 01             	add    $0x1,%edx
     d02:	39 d3                	cmp    %edx,%ebx
     d04:	75 f2                	jne    cf8 <memmove+0x18>
     d06:	5b                   	pop    %ebx
     d07:	5e                   	pop    %esi
     d08:	5d                   	pop    %ebp
     d09:	c3                   	ret    

00000d0a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     d0a:	b8 01 00 00 00       	mov    $0x1,%eax
     d0f:	cd 40                	int    $0x40
     d11:	c3                   	ret    

00000d12 <exit>:
SYSCALL(exit)
     d12:	b8 02 00 00 00       	mov    $0x2,%eax
     d17:	cd 40                	int    $0x40
     d19:	c3                   	ret    

00000d1a <wait>:
SYSCALL(wait)
     d1a:	b8 03 00 00 00       	mov    $0x3,%eax
     d1f:	cd 40                	int    $0x40
     d21:	c3                   	ret    

00000d22 <pipe>:
SYSCALL(pipe)
     d22:	b8 04 00 00 00       	mov    $0x4,%eax
     d27:	cd 40                	int    $0x40
     d29:	c3                   	ret    

00000d2a <read>:
SYSCALL(read)
     d2a:	b8 05 00 00 00       	mov    $0x5,%eax
     d2f:	cd 40                	int    $0x40
     d31:	c3                   	ret    

00000d32 <write>:
SYSCALL(write)
     d32:	b8 10 00 00 00       	mov    $0x10,%eax
     d37:	cd 40                	int    $0x40
     d39:	c3                   	ret    

00000d3a <close>:
SYSCALL(close)
     d3a:	b8 15 00 00 00       	mov    $0x15,%eax
     d3f:	cd 40                	int    $0x40
     d41:	c3                   	ret    

00000d42 <kill>:
SYSCALL(kill)
     d42:	b8 06 00 00 00       	mov    $0x6,%eax
     d47:	cd 40                	int    $0x40
     d49:	c3                   	ret    

00000d4a <exec>:
SYSCALL(exec)
     d4a:	b8 07 00 00 00       	mov    $0x7,%eax
     d4f:	cd 40                	int    $0x40
     d51:	c3                   	ret    

00000d52 <open>:
SYSCALL(open)
     d52:	b8 0f 00 00 00       	mov    $0xf,%eax
     d57:	cd 40                	int    $0x40
     d59:	c3                   	ret    

00000d5a <mknod>:
SYSCALL(mknod)
     d5a:	b8 11 00 00 00       	mov    $0x11,%eax
     d5f:	cd 40                	int    $0x40
     d61:	c3                   	ret    

00000d62 <unlink>:
SYSCALL(unlink)
     d62:	b8 12 00 00 00       	mov    $0x12,%eax
     d67:	cd 40                	int    $0x40
     d69:	c3                   	ret    

00000d6a <fstat>:
SYSCALL(fstat)
     d6a:	b8 08 00 00 00       	mov    $0x8,%eax
     d6f:	cd 40                	int    $0x40
     d71:	c3                   	ret    

00000d72 <link>:
SYSCALL(link)
     d72:	b8 13 00 00 00       	mov    $0x13,%eax
     d77:	cd 40                	int    $0x40
     d79:	c3                   	ret    

00000d7a <mkdir>:
SYSCALL(mkdir)
     d7a:	b8 14 00 00 00       	mov    $0x14,%eax
     d7f:	cd 40                	int    $0x40
     d81:	c3                   	ret    

00000d82 <chdir>:
SYSCALL(chdir)
     d82:	b8 09 00 00 00       	mov    $0x9,%eax
     d87:	cd 40                	int    $0x40
     d89:	c3                   	ret    

00000d8a <dup>:
SYSCALL(dup)
     d8a:	b8 0a 00 00 00       	mov    $0xa,%eax
     d8f:	cd 40                	int    $0x40
     d91:	c3                   	ret    

00000d92 <getpid>:
SYSCALL(getpid)
     d92:	b8 0b 00 00 00       	mov    $0xb,%eax
     d97:	cd 40                	int    $0x40
     d99:	c3                   	ret    

00000d9a <sbrk>:
SYSCALL(sbrk)
     d9a:	b8 0c 00 00 00       	mov    $0xc,%eax
     d9f:	cd 40                	int    $0x40
     da1:	c3                   	ret    

00000da2 <sleep>:
SYSCALL(sleep)
     da2:	b8 0d 00 00 00       	mov    $0xd,%eax
     da7:	cd 40                	int    $0x40
     da9:	c3                   	ret    

00000daa <uptime>:
SYSCALL(uptime)
     daa:	b8 0e 00 00 00       	mov    $0xe,%eax
     daf:	cd 40                	int    $0x40
     db1:	c3                   	ret    

00000db2 <cpuhalt>:
SYSCALL(cpuhalt)
     db2:	b8 16 00 00 00       	mov    $0x16,%eax
     db7:	cd 40                	int    $0x40
     db9:	c3                   	ret    
     dba:	66 90                	xchg   %ax,%ax
     dbc:	66 90                	xchg   %ax,%ax
     dbe:	66 90                	xchg   %ax,%ax

00000dc0 <printint.constprop.1>:
     dc0:	55                   	push   %ebp
     dc1:	89 e5                	mov    %esp,%ebp
     dc3:	57                   	push   %edi
     dc4:	56                   	push   %esi
     dc5:	53                   	push   %ebx
     dc6:	89 d6                	mov    %edx,%esi
     dc8:	83 ec 3c             	sub    $0x3c,%esp
     dcb:	85 c0                	test   %eax,%eax
     dcd:	79 71                	jns    e40 <printint.constprop.1+0x80>
     dcf:	83 e1 01             	and    $0x1,%ecx
     dd2:	74 6c                	je     e40 <printint.constprop.1+0x80>
     dd4:	f7 d8                	neg    %eax
     dd6:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
     ddd:	31 c9                	xor    %ecx,%ecx
     ddf:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     de2:	eb 06                	jmp    dea <printint.constprop.1+0x2a>
     de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     de8:	89 f9                	mov    %edi,%ecx
     dea:	31 d2                	xor    %edx,%edx
     dec:	8d 79 01             	lea    0x1(%ecx),%edi
     def:	f7 f6                	div    %esi
     df1:	0f b6 92 3c 13 00 00 	movzbl 0x133c(%edx),%edx
     df8:	85 c0                	test   %eax,%eax
     dfa:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
     dfd:	75 e9                	jne    de8 <printint.constprop.1+0x28>
     dff:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     e02:	85 c0                	test   %eax,%eax
     e04:	74 08                	je     e0e <printint.constprop.1+0x4e>
     e06:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     e0b:	8d 79 02             	lea    0x2(%ecx),%edi
     e0e:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
     e12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e18:	0f b6 06             	movzbl (%esi),%eax
     e1b:	83 ec 04             	sub    $0x4,%esp
     e1e:	83 ee 01             	sub    $0x1,%esi
     e21:	6a 01                	push   $0x1
     e23:	53                   	push   %ebx
     e24:	6a 01                	push   $0x1
     e26:	88 45 d7             	mov    %al,-0x29(%ebp)
     e29:	e8 04 ff ff ff       	call   d32 <write>
     e2e:	83 c4 10             	add    $0x10,%esp
     e31:	39 de                	cmp    %ebx,%esi
     e33:	75 e3                	jne    e18 <printint.constprop.1+0x58>
     e35:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e38:	5b                   	pop    %ebx
     e39:	5e                   	pop    %esi
     e3a:	5f                   	pop    %edi
     e3b:	5d                   	pop    %ebp
     e3c:	c3                   	ret    
     e3d:	8d 76 00             	lea    0x0(%esi),%esi
     e40:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     e47:	eb 94                	jmp    ddd <printint.constprop.1+0x1d>
     e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000e50 <vprintf.constprop.0>:
     e50:	55                   	push   %ebp
     e51:	89 e5                	mov    %esp,%ebp
     e53:	57                   	push   %edi
     e54:	56                   	push   %esi
     e55:	53                   	push   %ebx
     e56:	89 d6                	mov    %edx,%esi
     e58:	83 ec 2c             	sub    $0x2c,%esp
     e5b:	0f b6 10             	movzbl (%eax),%edx
     e5e:	84 d2                	test   %dl,%dl
     e60:	0f 84 cd 00 00 00    	je     f33 <vprintf.constprop.0+0xe3>
     e66:	8d 58 01             	lea    0x1(%eax),%ebx
     e69:	31 ff                	xor    %edi,%edi
     e6b:	eb 31                	jmp    e9e <vprintf.constprop.0+0x4e>
     e6d:	8d 76 00             	lea    0x0(%esi),%esi
     e70:	83 f8 25             	cmp    $0x25,%eax
     e73:	0f 84 c7 00 00 00    	je     f40 <vprintf.constprop.0+0xf0>
     e79:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     e7c:	83 ec 04             	sub    $0x4,%esp
     e7f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
     e82:	6a 01                	push   $0x1
     e84:	50                   	push   %eax
     e85:	6a 01                	push   $0x1
     e87:	e8 a6 fe ff ff       	call   d32 <write>
     e8c:	83 c4 10             	add    $0x10,%esp
     e8f:	83 c3 01             	add    $0x1,%ebx
     e92:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     e96:	84 d2                	test   %dl,%dl
     e98:	0f 84 95 00 00 00    	je     f33 <vprintf.constprop.0+0xe3>
     e9e:	85 ff                	test   %edi,%edi
     ea0:	0f b6 c2             	movzbl %dl,%eax
     ea3:	74 cb                	je     e70 <vprintf.constprop.0+0x20>
     ea5:	83 ff 25             	cmp    $0x25,%edi
     ea8:	75 e5                	jne    e8f <vprintf.constprop.0+0x3f>
     eaa:	83 f8 64             	cmp    $0x64,%eax
     ead:	8d 7e 04             	lea    0x4(%esi),%edi
     eb0:	b9 01 00 00 00       	mov    $0x1,%ecx
     eb5:	0f 84 9a 00 00 00    	je     f55 <vprintf.constprop.0+0x105>
     ebb:	83 f8 6c             	cmp    $0x6c,%eax
     ebe:	0f 84 8c 00 00 00    	je     f50 <vprintf.constprop.0+0x100>
     ec4:	83 f8 78             	cmp    $0x78,%eax
     ec7:	0f 84 a3 00 00 00    	je     f70 <vprintf.constprop.0+0x120>
     ecd:	83 f8 70             	cmp    $0x70,%eax
     ed0:	0f 84 ca 00 00 00    	je     fa0 <vprintf.constprop.0+0x150>
     ed6:	83 f8 73             	cmp    $0x73,%eax
     ed9:	0f 84 39 01 00 00    	je     1018 <vprintf.constprop.0+0x1c8>
     edf:	83 f8 63             	cmp    $0x63,%eax
     ee2:	0f 84 68 01 00 00    	je     1050 <vprintf.constprop.0+0x200>
     ee8:	83 f8 25             	cmp    $0x25,%eax
     eeb:	0f 84 9f 00 00 00    	je     f90 <vprintf.constprop.0+0x140>
     ef1:	8d 45 df             	lea    -0x21(%ebp),%eax
     ef4:	83 ec 04             	sub    $0x4,%esp
     ef7:	88 55 d4             	mov    %dl,-0x2c(%ebp)
     efa:	6a 01                	push   $0x1
     efc:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
     f00:	50                   	push   %eax
     f01:	6a 01                	push   $0x1
     f03:	e8 2a fe ff ff       	call   d32 <write>
     f08:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
     f0c:	83 c4 0c             	add    $0xc,%esp
     f0f:	8d 45 e0             	lea    -0x20(%ebp),%eax
     f12:	6a 01                	push   $0x1
     f14:	88 55 e0             	mov    %dl,-0x20(%ebp)
     f17:	50                   	push   %eax
     f18:	6a 01                	push   $0x1
     f1a:	83 c3 01             	add    $0x1,%ebx
     f1d:	31 ff                	xor    %edi,%edi
     f1f:	e8 0e fe ff ff       	call   d32 <write>
     f24:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     f28:	83 c4 10             	add    $0x10,%esp
     f2b:	84 d2                	test   %dl,%dl
     f2d:	0f 85 6b ff ff ff    	jne    e9e <vprintf.constprop.0+0x4e>
     f33:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f36:	5b                   	pop    %ebx
     f37:	5e                   	pop    %esi
     f38:	5f                   	pop    %edi
     f39:	5d                   	pop    %ebp
     f3a:	c3                   	ret    
     f3b:	90                   	nop
     f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f40:	bf 25 00 00 00       	mov    $0x25,%edi
     f45:	e9 45 ff ff ff       	jmp    e8f <vprintf.constprop.0+0x3f>
     f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f50:	8d 7e 04             	lea    0x4(%esi),%edi
     f53:	31 c9                	xor    %ecx,%ecx
     f55:	8b 06                	mov    (%esi),%eax
     f57:	ba 0a 00 00 00       	mov    $0xa,%edx
     f5c:	89 fe                	mov    %edi,%esi
     f5e:	31 ff                	xor    %edi,%edi
     f60:	e8 5b fe ff ff       	call   dc0 <printint.constprop.1>
     f65:	e9 25 ff ff ff       	jmp    e8f <vprintf.constprop.0+0x3f>
     f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f70:	8b 06                	mov    (%esi),%eax
     f72:	8d 7e 04             	lea    0x4(%esi),%edi
     f75:	31 c9                	xor    %ecx,%ecx
     f77:	ba 10 00 00 00       	mov    $0x10,%edx
     f7c:	89 fe                	mov    %edi,%esi
     f7e:	31 ff                	xor    %edi,%edi
     f80:	e8 3b fe ff ff       	call   dc0 <printint.constprop.1>
     f85:	e9 05 ff ff ff       	jmp    e8f <vprintf.constprop.0+0x3f>
     f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f90:	83 ec 04             	sub    $0x4,%esp
     f93:	88 55 e1             	mov    %dl,-0x1f(%ebp)
     f96:	8d 45 e1             	lea    -0x1f(%ebp),%eax
     f99:	6a 01                	push   $0x1
     f9b:	e9 77 ff ff ff       	jmp    f17 <vprintf.constprop.0+0xc7>
     fa0:	8d 46 04             	lea    0x4(%esi),%eax
     fa3:	83 ec 04             	sub    $0x4,%esp
     fa6:	8b 3e                	mov    (%esi),%edi
     fa8:	6a 01                	push   $0x1
     faa:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
     fae:	be 08 00 00 00       	mov    $0x8,%esi
     fb3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     fb6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     fb9:	50                   	push   %eax
     fba:	6a 01                	push   $0x1
     fbc:	e8 71 fd ff ff       	call   d32 <write>
     fc1:	8d 45 e7             	lea    -0x19(%ebp),%eax
     fc4:	83 c4 0c             	add    $0xc,%esp
     fc7:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
     fcb:	6a 01                	push   $0x1
     fcd:	50                   	push   %eax
     fce:	6a 01                	push   $0x1
     fd0:	e8 5d fd ff ff       	call   d32 <write>
     fd5:	83 c4 10             	add    $0x10,%esp
     fd8:	90                   	nop
     fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fe0:	89 f8                	mov    %edi,%eax
     fe2:	83 ec 04             	sub    $0x4,%esp
     fe5:	c1 e7 04             	shl    $0x4,%edi
     fe8:	c1 e8 1c             	shr    $0x1c,%eax
     feb:	6a 01                	push   $0x1
     fed:	0f b6 80 3c 13 00 00 	movzbl 0x133c(%eax),%eax
     ff4:	88 45 e5             	mov    %al,-0x1b(%ebp)
     ff7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
     ffa:	50                   	push   %eax
     ffb:	6a 01                	push   $0x1
     ffd:	e8 30 fd ff ff       	call   d32 <write>
    1002:	83 c4 10             	add    $0x10,%esp
    1005:	83 ee 01             	sub    $0x1,%esi
    1008:	75 d6                	jne    fe0 <vprintf.constprop.0+0x190>
    100a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    100d:	31 ff                	xor    %edi,%edi
    100f:	e9 7b fe ff ff       	jmp    e8f <vprintf.constprop.0+0x3f>
    1014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1018:	8b 3e                	mov    (%esi),%edi
    101a:	8d 46 04             	lea    0x4(%esi),%eax
    101d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1020:	85 ff                	test   %edi,%edi
    1022:	74 50                	je     1074 <vprintf.constprop.0+0x224>
    1024:	0f b6 07             	movzbl (%edi),%eax
    1027:	84 c0                	test   %al,%al
    1029:	74 df                	je     100a <vprintf.constprop.0+0x1ba>
    102b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
    102e:	66 90                	xchg   %ax,%ax
    1030:	83 ec 04             	sub    $0x4,%esp
    1033:	83 c7 01             	add    $0x1,%edi
    1036:	88 45 e3             	mov    %al,-0x1d(%ebp)
    1039:	6a 01                	push   $0x1
    103b:	56                   	push   %esi
    103c:	6a 01                	push   $0x1
    103e:	e8 ef fc ff ff       	call   d32 <write>
    1043:	0f b6 07             	movzbl (%edi),%eax
    1046:	83 c4 10             	add    $0x10,%esp
    1049:	84 c0                	test   %al,%al
    104b:	75 e3                	jne    1030 <vprintf.constprop.0+0x1e0>
    104d:	eb bb                	jmp    100a <vprintf.constprop.0+0x1ba>
    104f:	90                   	nop
    1050:	8b 06                	mov    (%esi),%eax
    1052:	83 ec 04             	sub    $0x4,%esp
    1055:	8d 7e 04             	lea    0x4(%esi),%edi
    1058:	6a 01                	push   $0x1
    105a:	89 fe                	mov    %edi,%esi
    105c:	31 ff                	xor    %edi,%edi
    105e:	88 45 e2             	mov    %al,-0x1e(%ebp)
    1061:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1064:	50                   	push   %eax
    1065:	6a 01                	push   $0x1
    1067:	e8 c6 fc ff ff       	call   d32 <write>
    106c:	83 c4 10             	add    $0x10,%esp
    106f:	e9 1b fe ff ff       	jmp    e8f <vprintf.constprop.0+0x3f>
    1074:	bf 34 13 00 00       	mov    $0x1334,%edi
    1079:	b8 28 00 00 00       	mov    $0x28,%eax
    107e:	eb ab                	jmp    102b <vprintf.constprop.0+0x1db>

00001080 <fprintf>:
    1080:	55                   	push   %ebp
    1081:	89 e5                	mov    %esp,%ebp
    1083:	83 ec 08             	sub    $0x8,%esp
    1086:	8b 45 0c             	mov    0xc(%ebp),%eax
    1089:	8d 55 10             	lea    0x10(%ebp),%edx
    108c:	e8 bf fd ff ff       	call   e50 <vprintf.constprop.0>
    1091:	c9                   	leave  
    1092:	c3                   	ret    
    1093:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010a0 <printf>:
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
    10a3:	83 ec 08             	sub    $0x8,%esp
    10a6:	8b 45 08             	mov    0x8(%ebp),%eax
    10a9:	8d 55 0c             	lea    0xc(%ebp),%edx
    10ac:	e8 9f fd ff ff       	call   e50 <vprintf.constprop.0>
    10b1:	c9                   	leave  
    10b2:	c3                   	ret    
    10b3:	66 90                	xchg   %ax,%ax
    10b5:	66 90                	xchg   %ax,%ax
    10b7:	66 90                	xchg   %ax,%ax
    10b9:	66 90                	xchg   %ax,%ax
    10bb:	66 90                	xchg   %ax,%ax
    10bd:	66 90                	xchg   %ax,%ax
    10bf:	90                   	nop

000010c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    10c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10c1:	a1 c4 19 00 00       	mov    0x19c4,%eax
{
    10c6:	89 e5                	mov    %esp,%ebp
    10c8:	57                   	push   %edi
    10c9:	56                   	push   %esi
    10ca:	53                   	push   %ebx
    10cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    10ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    10d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10d8:	39 c8                	cmp    %ecx,%eax
    10da:	8b 10                	mov    (%eax),%edx
    10dc:	73 32                	jae    1110 <free+0x50>
    10de:	39 d1                	cmp    %edx,%ecx
    10e0:	72 04                	jb     10e6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    10e2:	39 d0                	cmp    %edx,%eax
    10e4:	72 32                	jb     1118 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    10e6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    10e9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    10ec:	39 fa                	cmp    %edi,%edx
    10ee:	74 30                	je     1120 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    10f0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    10f3:	8b 50 04             	mov    0x4(%eax),%edx
    10f6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    10f9:	39 f1                	cmp    %esi,%ecx
    10fb:	74 3a                	je     1137 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    10fd:	89 08                	mov    %ecx,(%eax)
  freep = p;
    10ff:	a3 c4 19 00 00       	mov    %eax,0x19c4
}
    1104:	5b                   	pop    %ebx
    1105:	5e                   	pop    %esi
    1106:	5f                   	pop    %edi
    1107:	5d                   	pop    %ebp
    1108:	c3                   	ret    
    1109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1110:	39 d0                	cmp    %edx,%eax
    1112:	72 04                	jb     1118 <free+0x58>
    1114:	39 d1                	cmp    %edx,%ecx
    1116:	72 ce                	jb     10e6 <free+0x26>
{
    1118:	89 d0                	mov    %edx,%eax
    111a:	eb bc                	jmp    10d8 <free+0x18>
    111c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1120:	03 72 04             	add    0x4(%edx),%esi
    1123:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1126:	8b 10                	mov    (%eax),%edx
    1128:	8b 12                	mov    (%edx),%edx
    112a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    112d:	8b 50 04             	mov    0x4(%eax),%edx
    1130:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1133:	39 f1                	cmp    %esi,%ecx
    1135:	75 c6                	jne    10fd <free+0x3d>
    p->s.size += bp->s.size;
    1137:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    113a:	a3 c4 19 00 00       	mov    %eax,0x19c4
    p->s.size += bp->s.size;
    113f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1142:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1145:	89 10                	mov    %edx,(%eax)
}
    1147:	5b                   	pop    %ebx
    1148:	5e                   	pop    %esi
    1149:	5f                   	pop    %edi
    114a:	5d                   	pop    %ebp
    114b:	c3                   	ret    
    114c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001150 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	57                   	push   %edi
    1154:	56                   	push   %esi
    1155:	53                   	push   %ebx
    1156:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1159:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    115c:	8b 15 c4 19 00 00    	mov    0x19c4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1162:	8d 78 07             	lea    0x7(%eax),%edi
    1165:	c1 ef 03             	shr    $0x3,%edi
    1168:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    116b:	85 d2                	test   %edx,%edx
    116d:	0f 84 9d 00 00 00    	je     1210 <malloc+0xc0>
    1173:	8b 02                	mov    (%edx),%eax
    1175:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1178:	39 cf                	cmp    %ecx,%edi
    117a:	76 6c                	jbe    11e8 <malloc+0x98>
    117c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1182:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1187:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    118a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1191:	eb 0e                	jmp    11a1 <malloc+0x51>
    1193:	90                   	nop
    1194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1198:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    119a:	8b 48 04             	mov    0x4(%eax),%ecx
    119d:	39 f9                	cmp    %edi,%ecx
    119f:	73 47                	jae    11e8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    11a1:	39 05 c4 19 00 00    	cmp    %eax,0x19c4
    11a7:	89 c2                	mov    %eax,%edx
    11a9:	75 ed                	jne    1198 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    11ab:	83 ec 0c             	sub    $0xc,%esp
    11ae:	56                   	push   %esi
    11af:	e8 e6 fb ff ff       	call   d9a <sbrk>
  if(p == (char*)-1)
    11b4:	83 c4 10             	add    $0x10,%esp
    11b7:	83 f8 ff             	cmp    $0xffffffff,%eax
    11ba:	74 1c                	je     11d8 <malloc+0x88>
  hp->s.size = nu;
    11bc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    11bf:	83 ec 0c             	sub    $0xc,%esp
    11c2:	83 c0 08             	add    $0x8,%eax
    11c5:	50                   	push   %eax
    11c6:	e8 f5 fe ff ff       	call   10c0 <free>
  return freep;
    11cb:	8b 15 c4 19 00 00    	mov    0x19c4,%edx
      if((p = morecore(nunits)) == 0)
    11d1:	83 c4 10             	add    $0x10,%esp
    11d4:	85 d2                	test   %edx,%edx
    11d6:	75 c0                	jne    1198 <malloc+0x48>
        return 0;
  }
}
    11d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    11db:	31 c0                	xor    %eax,%eax
}
    11dd:	5b                   	pop    %ebx
    11de:	5e                   	pop    %esi
    11df:	5f                   	pop    %edi
    11e0:	5d                   	pop    %ebp
    11e1:	c3                   	ret    
    11e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    11e8:	39 cf                	cmp    %ecx,%edi
    11ea:	74 54                	je     1240 <malloc+0xf0>
        p->s.size -= nunits;
    11ec:	29 f9                	sub    %edi,%ecx
    11ee:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    11f1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    11f4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    11f7:	89 15 c4 19 00 00    	mov    %edx,0x19c4
}
    11fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1200:	83 c0 08             	add    $0x8,%eax
}
    1203:	5b                   	pop    %ebx
    1204:	5e                   	pop    %esi
    1205:	5f                   	pop    %edi
    1206:	5d                   	pop    %ebp
    1207:	c3                   	ret    
    1208:	90                   	nop
    1209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1210:	c7 05 c4 19 00 00 c8 	movl   $0x19c8,0x19c4
    1217:	19 00 00 
    121a:	c7 05 c8 19 00 00 c8 	movl   $0x19c8,0x19c8
    1221:	19 00 00 
    base.s.size = 0;
    1224:	b8 c8 19 00 00       	mov    $0x19c8,%eax
    1229:	c7 05 cc 19 00 00 00 	movl   $0x0,0x19cc
    1230:	00 00 00 
    1233:	e9 44 ff ff ff       	jmp    117c <malloc+0x2c>
    1238:	90                   	nop
    1239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1240:	8b 08                	mov    (%eax),%ecx
    1242:	89 0a                	mov    %ecx,(%edx)
    1244:	eb b1                	jmp    11f7 <malloc+0xa7>
