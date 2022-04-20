
user/_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 10             	sub    $0x10,%esp
      11:	68 26 4b 00 00       	push   $0x4b26
      16:	e8 75 39 00 00       	call   3990 <printf>
      1b:	5a                   	pop    %edx
      1c:	59                   	pop    %ecx
      1d:	6a 00                	push   $0x0
      1f:	68 3a 4b 00 00       	push   $0x4b3a
      24:	e8 19 36 00 00       	call   3642 <open>
      29:	83 c4 10             	add    $0x10,%esp
      2c:	85 c0                	test   %eax,%eax
      2e:	78 12                	js     42 <main+0x42>
      30:	83 ec 0c             	sub    $0xc,%esp
      33:	68 a4 52 00 00       	push   $0x52a4
      38:	e8 53 39 00 00       	call   3990 <printf>
      3d:	e8 c0 35 00 00       	call   3602 <exit>
      42:	50                   	push   %eax
      43:	50                   	push   %eax
      44:	68 00 02 00 00       	push   $0x200
      49:	68 3a 4b 00 00       	push   $0x4b3a
      4e:	e8 ef 35 00 00       	call   3642 <open>
      53:	89 04 24             	mov    %eax,(%esp)
      56:	e8 cf 35 00 00       	call   362a <close>
      5b:	e8 c0 32 00 00       	call   3320 <argptest>
      60:	e8 2b 10 00 00       	call   1090 <createdelete>
      65:	e8 b6 18 00 00       	call   1920 <linkunlink>
      6a:	e8 c1 15 00 00       	call   1630 <concreate>
      6f:	e8 2c 0e 00 00       	call   ea0 <fourfiles>
      74:	e8 67 0c 00 00       	call   ce0 <sharedfd>
      79:	e8 82 2f 00 00       	call   3000 <bigargtest>
      7e:	e8 9d 21 00 00       	call   2220 <bigwrite>
      83:	e8 78 2f 00 00       	call   3000 <bigargtest>
      88:	e8 13 2f 00 00       	call   2fa0 <bsstest>
      8d:	e8 8e 2a 00 00       	call   2b20 <sbrktest>
      92:	e8 69 2e 00 00       	call   2f00 <validatetest>
      97:	e8 e4 02 00 00       	call   380 <opentest>
      9c:	e8 5f 03 00 00       	call   400 <writetest>
      a1:	e8 ea 04 00 00       	call   590 <writetest1>
      a6:	e8 75 06 00 00       	call   720 <createtest>
      ab:	e8 f0 01 00 00       	call   2a0 <openiputtest>
      b0:	e8 1b 01 00 00       	call   1d0 <exitiputtest>
      b5:	e8 56 00 00 00       	call   110 <iputtest>
      ba:	e8 51 0b 00 00       	call   c10 <mem>
      bf:	e8 0c 08 00 00       	call   8d0 <pipe1>
      c4:	e8 97 09 00 00       	call   a60 <preempt>
      c9:	e8 c2 0a 00 00       	call   b90 <exitwait>
      ce:	e8 1d 25 00 00       	call   25f0 <rmdot>
      d3:	e8 e8 23 00 00       	call   24c0 <fourteen>
      d8:	e8 23 22 00 00       	call   2300 <bigfile>
      dd:	e8 7e 1a 00 00       	call   1b60 <subdir>
      e2:	e8 39 13 00 00       	call   1420 <linktest>
      e7:	e8 b4 11 00 00       	call   12a0 <unlinkread>
      ec:	e8 6f 26 00 00       	call   2760 <dirfile>
      f1:	e8 5a 28 00 00       	call   2950 <iref>
      f6:	e8 75 29 00 00       	call   2a70 <forktest>
      fb:	e8 30 19 00 00       	call   1a30 <bigdir>
     100:	e8 ab 31 00 00       	call   32b0 <uio>
     105:	e8 86 07 00 00       	call   890 <exectest>
     10a:	e8 f3 34 00 00       	call   3602 <exit>
     10f:	90                   	nop

00000110 <iputtest>:
     110:	55                   	push   %ebp
     111:	89 e5                	mov    %esp,%ebp
     113:	83 ec 14             	sub    $0x14,%esp
     116:	68 cc 3b 00 00       	push   $0x3bcc
     11b:	e8 70 38 00 00       	call   3990 <printf>
     120:	c7 04 24 5f 3b 00 00 	movl   $0x3b5f,(%esp)
     127:	e8 3e 35 00 00       	call   366a <mkdir>
     12c:	83 c4 10             	add    $0x10,%esp
     12f:	85 c0                	test   %eax,%eax
     131:	78 4e                	js     181 <iputtest+0x71>
     133:	83 ec 0c             	sub    $0xc,%esp
     136:	68 5f 3b 00 00       	push   $0x3b5f
     13b:	e8 32 35 00 00       	call   3672 <chdir>
     140:	83 c4 10             	add    $0x10,%esp
     143:	85 c0                	test   %eax,%eax
     145:	78 70                	js     1b7 <iputtest+0xa7>
     147:	83 ec 0c             	sub    $0xc,%esp
     14a:	68 5c 3b 00 00       	push   $0x3b5c
     14f:	e8 fe 34 00 00       	call   3652 <unlink>
     154:	83 c4 10             	add    $0x10,%esp
     157:	85 c0                	test   %eax,%eax
     159:	78 4a                	js     1a5 <iputtest+0x95>
     15b:	83 ec 0c             	sub    $0xc,%esp
     15e:	68 81 3b 00 00       	push   $0x3b81
     163:	e8 0a 35 00 00       	call   3672 <chdir>
     168:	83 c4 10             	add    $0x10,%esp
     16b:	85 c0                	test   %eax,%eax
     16d:	78 24                	js     193 <iputtest+0x83>
     16f:	83 ec 0c             	sub    $0xc,%esp
     172:	68 04 3c 00 00       	push   $0x3c04
     177:	e8 14 38 00 00       	call   3990 <printf>
     17c:	83 c4 10             	add    $0x10,%esp
     17f:	c9                   	leave  
     180:	c3                   	ret    
     181:	83 ec 0c             	sub    $0xc,%esp
     184:	68 38 3b 00 00       	push   $0x3b38
     189:	e8 02 38 00 00       	call   3990 <printf>
     18e:	e8 6f 34 00 00       	call   3602 <exit>
     193:	83 ec 0c             	sub    $0xc,%esp
     196:	68 83 3b 00 00       	push   $0x3b83
     19b:	e8 f0 37 00 00       	call   3990 <printf>
     1a0:	e8 5d 34 00 00       	call   3602 <exit>
     1a5:	83 ec 0c             	sub    $0xc,%esp
     1a8:	68 67 3b 00 00       	push   $0x3b67
     1ad:	e8 de 37 00 00       	call   3990 <printf>
     1b2:	e8 4b 34 00 00       	call   3602 <exit>
     1b7:	83 ec 0c             	sub    $0xc,%esp
     1ba:	68 46 3b 00 00       	push   $0x3b46
     1bf:	e8 cc 37 00 00       	call   3990 <printf>
     1c4:	e8 39 34 00 00       	call   3602 <exit>
     1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001d0 <exitiputtest>:
     1d0:	55                   	push   %ebp
     1d1:	89 e5                	mov    %esp,%ebp
     1d3:	83 ec 14             	sub    $0x14,%esp
     1d6:	68 93 3b 00 00       	push   $0x3b93
     1db:	e8 b0 37 00 00       	call   3990 <printf>
     1e0:	e8 15 34 00 00       	call   35fa <fork>
     1e5:	83 c4 10             	add    $0x10,%esp
     1e8:	85 c0                	test   %eax,%eax
     1ea:	78 76                	js     262 <exitiputtest+0x92>
     1ec:	75 4a                	jne    238 <exitiputtest+0x68>
     1ee:	83 ec 0c             	sub    $0xc,%esp
     1f1:	68 5f 3b 00 00       	push   $0x3b5f
     1f6:	e8 6f 34 00 00       	call   366a <mkdir>
     1fb:	83 c4 10             	add    $0x10,%esp
     1fe:	85 c0                	test   %eax,%eax
     200:	0f 88 80 00 00 00    	js     286 <exitiputtest+0xb6>
     206:	83 ec 0c             	sub    $0xc,%esp
     209:	68 5f 3b 00 00       	push   $0x3b5f
     20e:	e8 5f 34 00 00       	call   3672 <chdir>
     213:	83 c4 10             	add    $0x10,%esp
     216:	85 c0                	test   %eax,%eax
     218:	78 5a                	js     274 <exitiputtest+0xa4>
     21a:	83 ec 0c             	sub    $0xc,%esp
     21d:	68 5c 3b 00 00       	push   $0x3b5c
     222:	e8 2b 34 00 00       	call   3652 <unlink>
     227:	83 c4 10             	add    $0x10,%esp
     22a:	85 c0                	test   %eax,%eax
     22c:	78 22                	js     250 <exitiputtest+0x80>
     22e:	e8 cf 33 00 00       	call   3602 <exit>
     233:	90                   	nop
     234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     238:	e8 cd 33 00 00       	call   360a <wait>
     23d:	83 ec 0c             	sub    $0xc,%esp
     240:	68 b6 3b 00 00       	push   $0x3bb6
     245:	e8 46 37 00 00       	call   3990 <printf>
     24a:	83 c4 10             	add    $0x10,%esp
     24d:	c9                   	leave  
     24e:	c3                   	ret    
     24f:	90                   	nop
     250:	83 ec 0c             	sub    $0xc,%esp
     253:	68 67 3b 00 00       	push   $0x3b67
     258:	e8 33 37 00 00       	call   3990 <printf>
     25d:	e8 a0 33 00 00       	call   3602 <exit>
     262:	83 ec 0c             	sub    $0xc,%esp
     265:	68 79 4a 00 00       	push   $0x4a79
     26a:	e8 21 37 00 00       	call   3990 <printf>
     26f:	e8 8e 33 00 00       	call   3602 <exit>
     274:	83 ec 0c             	sub    $0xc,%esp
     277:	68 a2 3b 00 00       	push   $0x3ba2
     27c:	e8 0f 37 00 00       	call   3990 <printf>
     281:	e8 7c 33 00 00       	call   3602 <exit>
     286:	83 ec 0c             	sub    $0xc,%esp
     289:	68 38 3b 00 00       	push   $0x3b38
     28e:	e8 fd 36 00 00       	call   3990 <printf>
     293:	e8 6a 33 00 00       	call   3602 <exit>
     298:	90                   	nop
     299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002a0 <openiputtest>:
     2a0:	55                   	push   %ebp
     2a1:	89 e5                	mov    %esp,%ebp
     2a3:	83 ec 14             	sub    $0x14,%esp
     2a6:	68 c8 3b 00 00       	push   $0x3bc8
     2ab:	e8 e0 36 00 00       	call   3990 <printf>
     2b0:	c7 04 24 d7 3b 00 00 	movl   $0x3bd7,(%esp)
     2b7:	e8 ae 33 00 00       	call   366a <mkdir>
     2bc:	83 c4 10             	add    $0x10,%esp
     2bf:	85 c0                	test   %eax,%eax
     2c1:	78 7a                	js     33d <openiputtest+0x9d>
     2c3:	e8 32 33 00 00       	call   35fa <fork>
     2c8:	85 c0                	test   %eax,%eax
     2ca:	0f 88 7f 00 00 00    	js     34f <openiputtest+0xaf>
     2d0:	75 2e                	jne    300 <openiputtest+0x60>
     2d2:	83 ec 08             	sub    $0x8,%esp
     2d5:	6a 02                	push   $0x2
     2d7:	68 d7 3b 00 00       	push   $0x3bd7
     2dc:	e8 61 33 00 00       	call   3642 <open>
     2e1:	83 c4 10             	add    $0x10,%esp
     2e4:	85 c0                	test   %eax,%eax
     2e6:	78 50                	js     338 <openiputtest+0x98>
     2e8:	83 ec 0c             	sub    $0xc,%esp
     2eb:	68 5c 4b 00 00       	push   $0x4b5c
     2f0:	e8 9b 36 00 00       	call   3990 <printf>
     2f5:	e8 08 33 00 00       	call   3602 <exit>
     2fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     300:	83 ec 0c             	sub    $0xc,%esp
     303:	6a 01                	push   $0x1
     305:	e8 88 33 00 00       	call   3692 <sleep>
     30a:	c7 04 24 d7 3b 00 00 	movl   $0x3bd7,(%esp)
     311:	e8 3c 33 00 00       	call   3652 <unlink>
     316:	83 c4 10             	add    $0x10,%esp
     319:	85 c0                	test   %eax,%eax
     31b:	75 44                	jne    361 <openiputtest+0xc1>
     31d:	e8 e8 32 00 00       	call   360a <wait>
     322:	83 ec 0c             	sub    $0xc,%esp
     325:	68 00 3c 00 00       	push   $0x3c00
     32a:	e8 61 36 00 00       	call   3990 <printf>
     32f:	83 c4 10             	add    $0x10,%esp
     332:	c9                   	leave  
     333:	c3                   	ret    
     334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     338:	e8 c5 32 00 00       	call   3602 <exit>
     33d:	83 ec 0c             	sub    $0xc,%esp
     340:	68 dd 3b 00 00       	push   $0x3bdd
     345:	e8 46 36 00 00       	call   3990 <printf>
     34a:	e8 b3 32 00 00       	call   3602 <exit>
     34f:	83 ec 0c             	sub    $0xc,%esp
     352:	68 79 4a 00 00       	push   $0x4a79
     357:	e8 34 36 00 00       	call   3990 <printf>
     35c:	e8 a1 32 00 00       	call   3602 <exit>
     361:	83 ec 0c             	sub    $0xc,%esp
     364:	68 f1 3b 00 00       	push   $0x3bf1
     369:	e8 22 36 00 00       	call   3990 <printf>
     36e:	e8 8f 32 00 00       	call   3602 <exit>
     373:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000380 <opentest>:
     380:	55                   	push   %ebp
     381:	89 e5                	mov    %esp,%ebp
     383:	83 ec 14             	sub    $0x14,%esp
     386:	68 12 3c 00 00       	push   $0x3c12
     38b:	e8 00 36 00 00       	call   3990 <printf>
     390:	59                   	pop    %ecx
     391:	58                   	pop    %eax
     392:	6a 00                	push   $0x0
     394:	68 1d 3c 00 00       	push   $0x3c1d
     399:	e8 a4 32 00 00       	call   3642 <open>
     39e:	83 c4 10             	add    $0x10,%esp
     3a1:	85 c0                	test   %eax,%eax
     3a3:	78 30                	js     3d5 <opentest+0x55>
     3a5:	83 ec 0c             	sub    $0xc,%esp
     3a8:	50                   	push   %eax
     3a9:	e8 7c 32 00 00       	call   362a <close>
     3ae:	58                   	pop    %eax
     3af:	5a                   	pop    %edx
     3b0:	6a 00                	push   $0x0
     3b2:	68 35 3c 00 00       	push   $0x3c35
     3b7:	e8 86 32 00 00       	call   3642 <open>
     3bc:	83 c4 10             	add    $0x10,%esp
     3bf:	85 c0                	test   %eax,%eax
     3c1:	79 24                	jns    3e7 <opentest+0x67>
     3c3:	83 ec 0c             	sub    $0xc,%esp
     3c6:	68 60 3c 00 00       	push   $0x3c60
     3cb:	e8 c0 35 00 00       	call   3990 <printf>
     3d0:	83 c4 10             	add    $0x10,%esp
     3d3:	c9                   	leave  
     3d4:	c3                   	ret    
     3d5:	83 ec 0c             	sub    $0xc,%esp
     3d8:	68 22 3c 00 00       	push   $0x3c22
     3dd:	e8 ae 35 00 00       	call   3990 <printf>
     3e2:	e8 1b 32 00 00       	call   3602 <exit>
     3e7:	83 ec 0c             	sub    $0xc,%esp
     3ea:	68 42 3c 00 00       	push   $0x3c42
     3ef:	e8 9c 35 00 00       	call   3990 <printf>
     3f4:	e8 09 32 00 00       	call   3602 <exit>
     3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000400 <writetest>:
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	56                   	push   %esi
     404:	53                   	push   %ebx
     405:	83 ec 0c             	sub    $0xc,%esp
     408:	68 6e 3c 00 00       	push   $0x3c6e
     40d:	e8 7e 35 00 00       	call   3990 <printf>
     412:	59                   	pop    %ecx
     413:	5b                   	pop    %ebx
     414:	68 02 02 00 00       	push   $0x202
     419:	68 7f 3c 00 00       	push   $0x3c7f
     41e:	e8 1f 32 00 00       	call   3642 <open>
     423:	83 c4 10             	add    $0x10,%esp
     426:	85 c0                	test   %eax,%eax
     428:	0f 88 4f 01 00 00    	js     57d <writetest+0x17d>
     42e:	83 ec 0c             	sub    $0xc,%esp
     431:	89 c6                	mov    %eax,%esi
     433:	31 db                	xor    %ebx,%ebx
     435:	68 85 3c 00 00       	push   $0x3c85
     43a:	e8 51 35 00 00       	call   3990 <printf>
     43f:	83 c4 10             	add    $0x10,%esp
     442:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     448:	83 ec 04             	sub    $0x4,%esp
     44b:	6a 0a                	push   $0xa
     44d:	68 bc 3c 00 00       	push   $0x3cbc
     452:	56                   	push   %esi
     453:	e8 ca 31 00 00       	call   3622 <write>
     458:	83 c4 10             	add    $0x10,%esp
     45b:	83 f8 0a             	cmp    $0xa,%eax
     45e:	0f 85 bd 00 00 00    	jne    521 <writetest+0x121>
     464:	83 ec 04             	sub    $0x4,%esp
     467:	6a 0a                	push   $0xa
     469:	68 c7 3c 00 00       	push   $0x3cc7
     46e:	56                   	push   %esi
     46f:	e8 ae 31 00 00       	call   3622 <write>
     474:	83 c4 10             	add    $0x10,%esp
     477:	83 f8 0a             	cmp    $0xa,%eax
     47a:	0f 85 b4 00 00 00    	jne    534 <writetest+0x134>
     480:	83 c3 01             	add    $0x1,%ebx
     483:	83 fb 64             	cmp    $0x64,%ebx
     486:	75 c0                	jne    448 <writetest+0x48>
     488:	83 ec 0c             	sub    $0xc,%esp
     48b:	68 d2 3c 00 00       	push   $0x3cd2
     490:	e8 fb 34 00 00       	call   3990 <printf>
     495:	89 34 24             	mov    %esi,(%esp)
     498:	e8 8d 31 00 00       	call   362a <close>
     49d:	58                   	pop    %eax
     49e:	5a                   	pop    %edx
     49f:	6a 00                	push   $0x0
     4a1:	68 7f 3c 00 00       	push   $0x3c7f
     4a6:	e8 97 31 00 00       	call   3642 <open>
     4ab:	83 c4 10             	add    $0x10,%esp
     4ae:	85 c0                	test   %eax,%eax
     4b0:	89 c3                	mov    %eax,%ebx
     4b2:	0f 88 8f 00 00 00    	js     547 <writetest+0x147>
     4b8:	83 ec 0c             	sub    $0xc,%esp
     4bb:	68 dd 3c 00 00       	push   $0x3cdd
     4c0:	e8 cb 34 00 00       	call   3990 <printf>
     4c5:	83 c4 0c             	add    $0xc,%esp
     4c8:	68 d0 07 00 00       	push   $0x7d0
     4cd:	68 00 84 00 00       	push   $0x8400
     4d2:	53                   	push   %ebx
     4d3:	e8 42 31 00 00       	call   361a <read>
     4d8:	83 c4 10             	add    $0x10,%esp
     4db:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     4e0:	75 77                	jne    559 <writetest+0x159>
     4e2:	83 ec 0c             	sub    $0xc,%esp
     4e5:	68 11 3d 00 00       	push   $0x3d11
     4ea:	e8 a1 34 00 00       	call   3990 <printf>
     4ef:	89 1c 24             	mov    %ebx,(%esp)
     4f2:	e8 33 31 00 00       	call   362a <close>
     4f7:	c7 04 24 7f 3c 00 00 	movl   $0x3c7f,(%esp)
     4fe:	e8 4f 31 00 00       	call   3652 <unlink>
     503:	83 c4 10             	add    $0x10,%esp
     506:	85 c0                	test   %eax,%eax
     508:	78 61                	js     56b <writetest+0x16b>
     50a:	83 ec 0c             	sub    $0xc,%esp
     50d:	68 39 3d 00 00       	push   $0x3d39
     512:	e8 79 34 00 00       	call   3990 <printf>
     517:	83 c4 10             	add    $0x10,%esp
     51a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     51d:	5b                   	pop    %ebx
     51e:	5e                   	pop    %esi
     51f:	5d                   	pop    %ebp
     520:	c3                   	ret    
     521:	83 ec 08             	sub    $0x8,%esp
     524:	53                   	push   %ebx
     525:	68 80 4b 00 00       	push   $0x4b80
     52a:	e8 61 34 00 00       	call   3990 <printf>
     52f:	e8 ce 30 00 00       	call   3602 <exit>
     534:	83 ec 08             	sub    $0x8,%esp
     537:	53                   	push   %ebx
     538:	68 a4 4b 00 00       	push   $0x4ba4
     53d:	e8 4e 34 00 00       	call   3990 <printf>
     542:	e8 bb 30 00 00       	call   3602 <exit>
     547:	83 ec 0c             	sub    $0xc,%esp
     54a:	68 f6 3c 00 00       	push   $0x3cf6
     54f:	e8 3c 34 00 00       	call   3990 <printf>
     554:	e8 a9 30 00 00       	call   3602 <exit>
     559:	83 ec 0c             	sub    $0xc,%esp
     55c:	68 3d 40 00 00       	push   $0x403d
     561:	e8 2a 34 00 00       	call   3990 <printf>
     566:	e8 97 30 00 00       	call   3602 <exit>
     56b:	83 ec 0c             	sub    $0xc,%esp
     56e:	68 24 3d 00 00       	push   $0x3d24
     573:	e8 18 34 00 00       	call   3990 <printf>
     578:	e8 85 30 00 00       	call   3602 <exit>
     57d:	83 ec 0c             	sub    $0xc,%esp
     580:	68 a0 3c 00 00       	push   $0x3ca0
     585:	e8 06 34 00 00       	call   3990 <printf>
     58a:	e8 73 30 00 00       	call   3602 <exit>
     58f:	90                   	nop

00000590 <writetest1>:
     590:	55                   	push   %ebp
     591:	89 e5                	mov    %esp,%ebp
     593:	56                   	push   %esi
     594:	53                   	push   %ebx
     595:	83 ec 0c             	sub    $0xc,%esp
     598:	68 4d 3d 00 00       	push   $0x3d4d
     59d:	e8 ee 33 00 00       	call   3990 <printf>
     5a2:	5b                   	pop    %ebx
     5a3:	5e                   	pop    %esi
     5a4:	68 02 02 00 00       	push   $0x202
     5a9:	68 c7 3d 00 00       	push   $0x3dc7
     5ae:	e8 8f 30 00 00       	call   3642 <open>
     5b3:	83 c4 10             	add    $0x10,%esp
     5b6:	85 c0                	test   %eax,%eax
     5b8:	0f 88 3c 01 00 00    	js     6fa <writetest1+0x16a>
     5be:	89 c6                	mov    %eax,%esi
     5c0:	31 db                	xor    %ebx,%ebx
     5c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     5c8:	83 ec 04             	sub    $0x4,%esp
     5cb:	89 1d 00 84 00 00    	mov    %ebx,0x8400
     5d1:	68 00 02 00 00       	push   $0x200
     5d6:	68 00 84 00 00       	push   $0x8400
     5db:	56                   	push   %esi
     5dc:	e8 41 30 00 00       	call   3622 <write>
     5e1:	83 c4 10             	add    $0x10,%esp
     5e4:	3d 00 02 00 00       	cmp    $0x200,%eax
     5e9:	0f 85 a9 00 00 00    	jne    698 <writetest1+0x108>
     5ef:	83 c3 01             	add    $0x1,%ebx
     5f2:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     5f8:	75 ce                	jne    5c8 <writetest1+0x38>
     5fa:	83 ec 0c             	sub    $0xc,%esp
     5fd:	56                   	push   %esi
     5fe:	e8 27 30 00 00       	call   362a <close>
     603:	5a                   	pop    %edx
     604:	59                   	pop    %ecx
     605:	6a 00                	push   $0x0
     607:	68 c7 3d 00 00       	push   $0x3dc7
     60c:	e8 31 30 00 00       	call   3642 <open>
     611:	83 c4 10             	add    $0x10,%esp
     614:	85 c0                	test   %eax,%eax
     616:	89 c6                	mov    %eax,%esi
     618:	0f 88 ca 00 00 00    	js     6e8 <writetest1+0x158>
     61e:	31 db                	xor    %ebx,%ebx
     620:	eb 1d                	jmp    63f <writetest1+0xaf>
     622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     628:	3d 00 02 00 00       	cmp    $0x200,%eax
     62d:	0f 85 8c 00 00 00    	jne    6bf <writetest1+0x12f>
     633:	a1 00 84 00 00       	mov    0x8400,%eax
     638:	39 d8                	cmp    %ebx,%eax
     63a:	75 6f                	jne    6ab <writetest1+0x11b>
     63c:	83 c3 01             	add    $0x1,%ebx
     63f:	83 ec 04             	sub    $0x4,%esp
     642:	68 00 02 00 00       	push   $0x200
     647:	68 00 84 00 00       	push   $0x8400
     64c:	56                   	push   %esi
     64d:	e8 c8 2f 00 00       	call   361a <read>
     652:	83 c4 10             	add    $0x10,%esp
     655:	85 c0                	test   %eax,%eax
     657:	75 cf                	jne    628 <writetest1+0x98>
     659:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     65f:	74 71                	je     6d2 <writetest1+0x142>
     661:	83 ec 0c             	sub    $0xc,%esp
     664:	56                   	push   %esi
     665:	e8 c0 2f 00 00       	call   362a <close>
     66a:	c7 04 24 c7 3d 00 00 	movl   $0x3dc7,(%esp)
     671:	e8 dc 2f 00 00       	call   3652 <unlink>
     676:	83 c4 10             	add    $0x10,%esp
     679:	85 c0                	test   %eax,%eax
     67b:	0f 88 8b 00 00 00    	js     70c <writetest1+0x17c>
     681:	83 ec 0c             	sub    $0xc,%esp
     684:	68 ee 3d 00 00       	push   $0x3dee
     689:	e8 02 33 00 00       	call   3990 <printf>
     68e:	83 c4 10             	add    $0x10,%esp
     691:	8d 65 f8             	lea    -0x8(%ebp),%esp
     694:	5b                   	pop    %ebx
     695:	5e                   	pop    %esi
     696:	5d                   	pop    %ebp
     697:	c3                   	ret    
     698:	83 ec 08             	sub    $0x8,%esp
     69b:	53                   	push   %ebx
     69c:	68 77 3d 00 00       	push   $0x3d77
     6a1:	e8 ea 32 00 00       	call   3990 <printf>
     6a6:	e8 57 2f 00 00       	call   3602 <exit>
     6ab:	83 ec 04             	sub    $0x4,%esp
     6ae:	50                   	push   %eax
     6af:	53                   	push   %ebx
     6b0:	68 c8 4b 00 00       	push   $0x4bc8
     6b5:	e8 d6 32 00 00       	call   3990 <printf>
     6ba:	e8 43 2f 00 00       	call   3602 <exit>
     6bf:	83 ec 08             	sub    $0x8,%esp
     6c2:	50                   	push   %eax
     6c3:	68 cb 3d 00 00       	push   $0x3dcb
     6c8:	e8 c3 32 00 00       	call   3990 <printf>
     6cd:	e8 30 2f 00 00       	call   3602 <exit>
     6d2:	50                   	push   %eax
     6d3:	50                   	push   %eax
     6d4:	68 8b 00 00 00       	push   $0x8b
     6d9:	68 ae 3d 00 00       	push   $0x3dae
     6de:	e8 ad 32 00 00       	call   3990 <printf>
     6e3:	e8 1a 2f 00 00       	call   3602 <exit>
     6e8:	83 ec 0c             	sub    $0xc,%esp
     6eb:	68 95 3d 00 00       	push   $0x3d95
     6f0:	e8 9b 32 00 00       	call   3990 <printf>
     6f5:	e8 08 2f 00 00       	call   3602 <exit>
     6fa:	83 ec 0c             	sub    $0xc,%esp
     6fd:	68 5d 3d 00 00       	push   $0x3d5d
     702:	e8 89 32 00 00       	call   3990 <printf>
     707:	e8 f6 2e 00 00       	call   3602 <exit>
     70c:	83 ec 0c             	sub    $0xc,%esp
     70f:	68 db 3d 00 00       	push   $0x3ddb
     714:	e8 77 32 00 00       	call   3990 <printf>
     719:	e8 e4 2e 00 00       	call   3602 <exit>
     71e:	66 90                	xchg   %ax,%ax

00000720 <createtest>:
     720:	55                   	push   %ebp
     721:	89 e5                	mov    %esp,%ebp
     723:	53                   	push   %ebx
     724:	bb 30 00 00 00       	mov    $0x30,%ebx
     729:	83 ec 10             	sub    $0x10,%esp
     72c:	68 e8 4b 00 00       	push   $0x4be8
     731:	e8 5a 32 00 00       	call   3990 <printf>
     736:	c6 05 00 a4 00 00 61 	movb   $0x61,0xa400
     73d:	c6 05 02 a4 00 00 00 	movb   $0x0,0xa402
     744:	83 c4 10             	add    $0x10,%esp
     747:	89 f6                	mov    %esi,%esi
     749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     750:	83 ec 08             	sub    $0x8,%esp
     753:	88 1d 01 a4 00 00    	mov    %bl,0xa401
     759:	83 c3 01             	add    $0x1,%ebx
     75c:	68 02 02 00 00       	push   $0x202
     761:	68 00 a4 00 00       	push   $0xa400
     766:	e8 d7 2e 00 00       	call   3642 <open>
     76b:	89 04 24             	mov    %eax,(%esp)
     76e:	e8 b7 2e 00 00       	call   362a <close>
     773:	83 c4 10             	add    $0x10,%esp
     776:	80 fb 64             	cmp    $0x64,%bl
     779:	75 d5                	jne    750 <createtest+0x30>
     77b:	c6 05 00 a4 00 00 61 	movb   $0x61,0xa400
     782:	c6 05 02 a4 00 00 00 	movb   $0x0,0xa402
     789:	bb 30 00 00 00       	mov    $0x30,%ebx
     78e:	66 90                	xchg   %ax,%ax
     790:	83 ec 0c             	sub    $0xc,%esp
     793:	88 1d 01 a4 00 00    	mov    %bl,0xa401
     799:	83 c3 01             	add    $0x1,%ebx
     79c:	68 00 a4 00 00       	push   $0xa400
     7a1:	e8 ac 2e 00 00       	call   3652 <unlink>
     7a6:	83 c4 10             	add    $0x10,%esp
     7a9:	80 fb 64             	cmp    $0x64,%bl
     7ac:	75 e2                	jne    790 <createtest+0x70>
     7ae:	83 ec 0c             	sub    $0xc,%esp
     7b1:	68 10 4c 00 00       	push   $0x4c10
     7b6:	e8 d5 31 00 00       	call   3990 <printf>
     7bb:	83 c4 10             	add    $0x10,%esp
     7be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7c1:	c9                   	leave  
     7c2:	c3                   	ret    
     7c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     7c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007d0 <dirtest>:
     7d0:	55                   	push   %ebp
     7d1:	89 e5                	mov    %esp,%ebp
     7d3:	83 ec 14             	sub    $0x14,%esp
     7d6:	68 fc 3d 00 00       	push   $0x3dfc
     7db:	e8 b0 31 00 00       	call   3990 <printf>
     7e0:	c7 04 24 08 3e 00 00 	movl   $0x3e08,(%esp)
     7e7:	e8 7e 2e 00 00       	call   366a <mkdir>
     7ec:	83 c4 10             	add    $0x10,%esp
     7ef:	85 c0                	test   %eax,%eax
     7f1:	78 4e                	js     841 <dirtest+0x71>
     7f3:	83 ec 0c             	sub    $0xc,%esp
     7f6:	68 08 3e 00 00       	push   $0x3e08
     7fb:	e8 72 2e 00 00       	call   3672 <chdir>
     800:	83 c4 10             	add    $0x10,%esp
     803:	85 c0                	test   %eax,%eax
     805:	78 70                	js     877 <dirtest+0xa7>
     807:	83 ec 0c             	sub    $0xc,%esp
     80a:	68 ad 43 00 00       	push   $0x43ad
     80f:	e8 5e 2e 00 00       	call   3672 <chdir>
     814:	83 c4 10             	add    $0x10,%esp
     817:	85 c0                	test   %eax,%eax
     819:	78 4a                	js     865 <dirtest+0x95>
     81b:	83 ec 0c             	sub    $0xc,%esp
     81e:	68 08 3e 00 00       	push   $0x3e08
     823:	e8 2a 2e 00 00       	call   3652 <unlink>
     828:	83 c4 10             	add    $0x10,%esp
     82b:	85 c0                	test   %eax,%eax
     82d:	78 24                	js     853 <dirtest+0x83>
     82f:	83 ec 0c             	sub    $0xc,%esp
     832:	68 45 3e 00 00       	push   $0x3e45
     837:	e8 54 31 00 00       	call   3990 <printf>
     83c:	83 c4 10             	add    $0x10,%esp
     83f:	c9                   	leave  
     840:	c3                   	ret    
     841:	83 ec 0c             	sub    $0xc,%esp
     844:	68 38 3b 00 00       	push   $0x3b38
     849:	e8 42 31 00 00       	call   3990 <printf>
     84e:	e8 af 2d 00 00       	call   3602 <exit>
     853:	83 ec 0c             	sub    $0xc,%esp
     856:	68 31 3e 00 00       	push   $0x3e31
     85b:	e8 30 31 00 00       	call   3990 <printf>
     860:	e8 9d 2d 00 00       	call   3602 <exit>
     865:	83 ec 0c             	sub    $0xc,%esp
     868:	68 20 3e 00 00       	push   $0x3e20
     86d:	e8 1e 31 00 00       	call   3990 <printf>
     872:	e8 8b 2d 00 00       	call   3602 <exit>
     877:	83 ec 0c             	sub    $0xc,%esp
     87a:	68 0d 3e 00 00       	push   $0x3e0d
     87f:	e8 0c 31 00 00       	call   3990 <printf>
     884:	e8 79 2d 00 00       	call   3602 <exit>
     889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000890 <exectest>:
     890:	55                   	push   %ebp
     891:	89 e5                	mov    %esp,%ebp
     893:	83 ec 14             	sub    $0x14,%esp
     896:	68 54 3e 00 00       	push   $0x3e54
     89b:	e8 f0 30 00 00       	call   3990 <printf>
     8a0:	58                   	pop    %eax
     8a1:	5a                   	pop    %edx
     8a2:	68 2c 5c 00 00       	push   $0x5c2c
     8a7:	68 1d 3c 00 00       	push   $0x3c1d
     8ac:	e8 89 2d 00 00       	call   363a <exec>
     8b1:	83 c4 10             	add    $0x10,%esp
     8b4:	85 c0                	test   %eax,%eax
     8b6:	78 02                	js     8ba <exectest+0x2a>
     8b8:	c9                   	leave  
     8b9:	c3                   	ret    
     8ba:	83 ec 0c             	sub    $0xc,%esp
     8bd:	68 5f 3e 00 00       	push   $0x3e5f
     8c2:	e8 c9 30 00 00       	call   3990 <printf>
     8c7:	e8 36 2d 00 00       	call   3602 <exit>
     8cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000008d0 <pipe1>:
     8d0:	55                   	push   %ebp
     8d1:	89 e5                	mov    %esp,%ebp
     8d3:	57                   	push   %edi
     8d4:	56                   	push   %esi
     8d5:	53                   	push   %ebx
     8d6:	8d 45 e0             	lea    -0x20(%ebp),%eax
     8d9:	83 ec 38             	sub    $0x38,%esp
     8dc:	50                   	push   %eax
     8dd:	e8 30 2d 00 00       	call   3612 <pipe>
     8e2:	83 c4 10             	add    $0x10,%esp
     8e5:	85 c0                	test   %eax,%eax
     8e7:	0f 85 37 01 00 00    	jne    a24 <pipe1+0x154>
     8ed:	89 c3                	mov    %eax,%ebx
     8ef:	e8 06 2d 00 00       	call   35fa <fork>
     8f4:	83 f8 00             	cmp    $0x0,%eax
     8f7:	0f 84 82 00 00 00    	je     97f <pipe1+0xaf>
     8fd:	0f 8e 33 01 00 00    	jle    a36 <pipe1+0x166>
     903:	83 ec 0c             	sub    $0xc,%esp
     906:	ff 75 e4             	pushl  -0x1c(%ebp)
     909:	bf 01 00 00 00       	mov    $0x1,%edi
     90e:	e8 17 2d 00 00       	call   362a <close>
     913:	83 c4 10             	add    $0x10,%esp
     916:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     91d:	83 ec 04             	sub    $0x4,%esp
     920:	57                   	push   %edi
     921:	68 00 84 00 00       	push   $0x8400
     926:	ff 75 e0             	pushl  -0x20(%ebp)
     929:	e8 ec 2c 00 00       	call   361a <read>
     92e:	83 c4 10             	add    $0x10,%esp
     931:	85 c0                	test   %eax,%eax
     933:	0f 8e a7 00 00 00    	jle    9e0 <pipe1+0x110>
     939:	89 d9                	mov    %ebx,%ecx
     93b:	8d 34 18             	lea    (%eax,%ebx,1),%esi
     93e:	f7 d9                	neg    %ecx
     940:	38 9c 0b 00 84 00 00 	cmp    %bl,0x8400(%ebx,%ecx,1)
     947:	8d 53 01             	lea    0x1(%ebx),%edx
     94a:	75 1b                	jne    967 <pipe1+0x97>
     94c:	39 f2                	cmp    %esi,%edx
     94e:	89 d3                	mov    %edx,%ebx
     950:	75 ee                	jne    940 <pipe1+0x70>
     952:	01 ff                	add    %edi,%edi
     954:	01 45 d4             	add    %eax,-0x2c(%ebp)
     957:	b8 00 20 00 00       	mov    $0x2000,%eax
     95c:	81 ff 00 20 00 00    	cmp    $0x2000,%edi
     962:	0f 4f f8             	cmovg  %eax,%edi
     965:	eb b6                	jmp    91d <pipe1+0x4d>
     967:	83 ec 0c             	sub    $0xc,%esp
     96a:	68 8e 3e 00 00       	push   $0x3e8e
     96f:	e8 1c 30 00 00       	call   3990 <printf>
     974:	83 c4 10             	add    $0x10,%esp
     977:	8d 65 f4             	lea    -0xc(%ebp),%esp
     97a:	5b                   	pop    %ebx
     97b:	5e                   	pop    %esi
     97c:	5f                   	pop    %edi
     97d:	5d                   	pop    %ebp
     97e:	c3                   	ret    
     97f:	83 ec 0c             	sub    $0xc,%esp
     982:	ff 75 e0             	pushl  -0x20(%ebp)
     985:	31 db                	xor    %ebx,%ebx
     987:	be 09 04 00 00       	mov    $0x409,%esi
     98c:	e8 99 2c 00 00       	call   362a <close>
     991:	83 c4 10             	add    $0x10,%esp
     994:	89 d8                	mov    %ebx,%eax
     996:	89 f2                	mov    %esi,%edx
     998:	f7 d8                	neg    %eax
     99a:	29 da                	sub    %ebx,%edx
     99c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     9a0:	88 84 03 00 84 00 00 	mov    %al,0x8400(%ebx,%eax,1)
     9a7:	83 c0 01             	add    $0x1,%eax
     9aa:	39 d0                	cmp    %edx,%eax
     9ac:	75 f2                	jne    9a0 <pipe1+0xd0>
     9ae:	83 ec 04             	sub    $0x4,%esp
     9b1:	68 09 04 00 00       	push   $0x409
     9b6:	68 00 84 00 00       	push   $0x8400
     9bb:	ff 75 e4             	pushl  -0x1c(%ebp)
     9be:	e8 5f 2c 00 00       	call   3622 <write>
     9c3:	83 c4 10             	add    $0x10,%esp
     9c6:	3d 09 04 00 00       	cmp    $0x409,%eax
     9cb:	75 7b                	jne    a48 <pipe1+0x178>
     9cd:	81 eb 09 04 00 00    	sub    $0x409,%ebx
     9d3:	81 fb d3 eb ff ff    	cmp    $0xffffebd3,%ebx
     9d9:	75 b9                	jne    994 <pipe1+0xc4>
     9db:	e8 22 2c 00 00       	call   3602 <exit>
     9e0:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     9e7:	75 27                	jne    a10 <pipe1+0x140>
     9e9:	83 ec 0c             	sub    $0xc,%esp
     9ec:	ff 75 e0             	pushl  -0x20(%ebp)
     9ef:	e8 36 2c 00 00       	call   362a <close>
     9f4:	e8 11 2c 00 00       	call   360a <wait>
     9f9:	c7 04 24 b3 3e 00 00 	movl   $0x3eb3,(%esp)
     a00:	e8 8b 2f 00 00       	call   3990 <printf>
     a05:	83 c4 10             	add    $0x10,%esp
     a08:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a0b:	5b                   	pop    %ebx
     a0c:	5e                   	pop    %esi
     a0d:	5f                   	pop    %edi
     a0e:	5d                   	pop    %ebp
     a0f:	c3                   	ret    
     a10:	50                   	push   %eax
     a11:	50                   	push   %eax
     a12:	ff 75 d4             	pushl  -0x2c(%ebp)
     a15:	68 9c 3e 00 00       	push   $0x3e9c
     a1a:	e8 71 2f 00 00       	call   3990 <printf>
     a1f:	e8 de 2b 00 00       	call   3602 <exit>
     a24:	83 ec 0c             	sub    $0xc,%esp
     a27:	68 71 3e 00 00       	push   $0x3e71
     a2c:	e8 5f 2f 00 00       	call   3990 <printf>
     a31:	e8 cc 2b 00 00       	call   3602 <exit>
     a36:	83 ec 0c             	sub    $0xc,%esp
     a39:	68 bd 3e 00 00       	push   $0x3ebd
     a3e:	e8 4d 2f 00 00       	call   3990 <printf>
     a43:	e8 ba 2b 00 00       	call   3602 <exit>
     a48:	83 ec 0c             	sub    $0xc,%esp
     a4b:	68 80 3e 00 00       	push   $0x3e80
     a50:	e8 3b 2f 00 00       	call   3990 <printf>
     a55:	e8 a8 2b 00 00       	call   3602 <exit>
     a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000a60 <preempt>:
     a60:	55                   	push   %ebp
     a61:	89 e5                	mov    %esp,%ebp
     a63:	57                   	push   %edi
     a64:	56                   	push   %esi
     a65:	53                   	push   %ebx
     a66:	83 ec 28             	sub    $0x28,%esp
     a69:	68 cc 3e 00 00       	push   $0x3ecc
     a6e:	e8 1d 2f 00 00       	call   3990 <printf>
     a73:	e8 82 2b 00 00       	call   35fa <fork>
     a78:	83 c4 10             	add    $0x10,%esp
     a7b:	85 c0                	test   %eax,%eax
     a7d:	75 02                	jne    a81 <preempt+0x21>
     a7f:	eb fe                	jmp    a7f <preempt+0x1f>
     a81:	89 c7                	mov    %eax,%edi
     a83:	e8 72 2b 00 00       	call   35fa <fork>
     a88:	85 c0                	test   %eax,%eax
     a8a:	89 c6                	mov    %eax,%esi
     a8c:	75 02                	jne    a90 <preempt+0x30>
     a8e:	eb fe                	jmp    a8e <preempt+0x2e>
     a90:	8d 45 e0             	lea    -0x20(%ebp),%eax
     a93:	83 ec 0c             	sub    $0xc,%esp
     a96:	50                   	push   %eax
     a97:	e8 76 2b 00 00       	call   3612 <pipe>
     a9c:	e8 59 2b 00 00       	call   35fa <fork>
     aa1:	83 c4 10             	add    $0x10,%esp
     aa4:	85 c0                	test   %eax,%eax
     aa6:	89 c3                	mov    %eax,%ebx
     aa8:	75 45                	jne    aef <preempt+0x8f>
     aaa:	83 ec 0c             	sub    $0xc,%esp
     aad:	ff 75 e0             	pushl  -0x20(%ebp)
     ab0:	e8 75 2b 00 00       	call   362a <close>
     ab5:	83 c4 0c             	add    $0xc,%esp
     ab8:	6a 01                	push   $0x1
     aba:	68 91 44 00 00       	push   $0x4491
     abf:	ff 75 e4             	pushl  -0x1c(%ebp)
     ac2:	e8 5b 2b 00 00       	call   3622 <write>
     ac7:	83 c4 10             	add    $0x10,%esp
     aca:	83 e8 01             	sub    $0x1,%eax
     acd:	74 10                	je     adf <preempt+0x7f>
     acf:	83 ec 0c             	sub    $0xc,%esp
     ad2:	68 d6 3e 00 00       	push   $0x3ed6
     ad7:	e8 b4 2e 00 00       	call   3990 <printf>
     adc:	83 c4 10             	add    $0x10,%esp
     adf:	83 ec 0c             	sub    $0xc,%esp
     ae2:	ff 75 e4             	pushl  -0x1c(%ebp)
     ae5:	e8 40 2b 00 00       	call   362a <close>
     aea:	83 c4 10             	add    $0x10,%esp
     aed:	eb fe                	jmp    aed <preempt+0x8d>
     aef:	83 ec 0c             	sub    $0xc,%esp
     af2:	ff 75 e4             	pushl  -0x1c(%ebp)
     af5:	e8 30 2b 00 00       	call   362a <close>
     afa:	83 c4 0c             	add    $0xc,%esp
     afd:	68 00 20 00 00       	push   $0x2000
     b02:	68 00 84 00 00       	push   $0x8400
     b07:	ff 75 e0             	pushl  -0x20(%ebp)
     b0a:	e8 0b 2b 00 00       	call   361a <read>
     b0f:	83 c4 10             	add    $0x10,%esp
     b12:	83 e8 01             	sub    $0x1,%eax
     b15:	74 18                	je     b2f <preempt+0xcf>
     b17:	83 ec 0c             	sub    $0xc,%esp
     b1a:	68 ea 3e 00 00       	push   $0x3eea
     b1f:	e8 6c 2e 00 00       	call   3990 <printf>
     b24:	83 c4 10             	add    $0x10,%esp
     b27:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b2a:	5b                   	pop    %ebx
     b2b:	5e                   	pop    %esi
     b2c:	5f                   	pop    %edi
     b2d:	5d                   	pop    %ebp
     b2e:	c3                   	ret    
     b2f:	83 ec 0c             	sub    $0xc,%esp
     b32:	ff 75 e0             	pushl  -0x20(%ebp)
     b35:	e8 f0 2a 00 00       	call   362a <close>
     b3a:	c7 04 24 fd 3e 00 00 	movl   $0x3efd,(%esp)
     b41:	e8 4a 2e 00 00       	call   3990 <printf>
     b46:	89 3c 24             	mov    %edi,(%esp)
     b49:	e8 e4 2a 00 00       	call   3632 <kill>
     b4e:	89 34 24             	mov    %esi,(%esp)
     b51:	e8 dc 2a 00 00       	call   3632 <kill>
     b56:	89 1c 24             	mov    %ebx,(%esp)
     b59:	e8 d4 2a 00 00       	call   3632 <kill>
     b5e:	c7 04 24 06 3f 00 00 	movl   $0x3f06,(%esp)
     b65:	e8 26 2e 00 00       	call   3990 <printf>
     b6a:	e8 9b 2a 00 00       	call   360a <wait>
     b6f:	e8 96 2a 00 00       	call   360a <wait>
     b74:	e8 91 2a 00 00       	call   360a <wait>
     b79:	c7 04 24 0f 3f 00 00 	movl   $0x3f0f,(%esp)
     b80:	e8 0b 2e 00 00       	call   3990 <printf>
     b85:	83 c4 10             	add    $0x10,%esp
     b88:	eb 9d                	jmp    b27 <preempt+0xc7>
     b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000b90 <exitwait>:
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	56                   	push   %esi
     b94:	be 64 00 00 00       	mov    $0x64,%esi
     b99:	53                   	push   %ebx
     b9a:	eb 14                	jmp    bb0 <exitwait+0x20>
     b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ba0:	74 65                	je     c07 <exitwait+0x77>
     ba2:	e8 63 2a 00 00       	call   360a <wait>
     ba7:	39 d8                	cmp    %ebx,%eax
     ba9:	75 2d                	jne    bd8 <exitwait+0x48>
     bab:	83 ee 01             	sub    $0x1,%esi
     bae:	74 40                	je     bf0 <exitwait+0x60>
     bb0:	e8 45 2a 00 00       	call   35fa <fork>
     bb5:	85 c0                	test   %eax,%eax
     bb7:	89 c3                	mov    %eax,%ebx
     bb9:	79 e5                	jns    ba0 <exitwait+0x10>
     bbb:	83 ec 0c             	sub    $0xc,%esp
     bbe:	68 79 4a 00 00       	push   $0x4a79
     bc3:	e8 c8 2d 00 00       	call   3990 <printf>
     bc8:	83 c4 10             	add    $0x10,%esp
     bcb:	8d 65 f8             	lea    -0x8(%ebp),%esp
     bce:	5b                   	pop    %ebx
     bcf:	5e                   	pop    %esi
     bd0:	5d                   	pop    %ebp
     bd1:	c3                   	ret    
     bd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     bd8:	83 ec 0c             	sub    $0xc,%esp
     bdb:	68 1b 3f 00 00       	push   $0x3f1b
     be0:	e8 ab 2d 00 00       	call   3990 <printf>
     be5:	83 c4 10             	add    $0x10,%esp
     be8:	8d 65 f8             	lea    -0x8(%ebp),%esp
     beb:	5b                   	pop    %ebx
     bec:	5e                   	pop    %esi
     bed:	5d                   	pop    %ebp
     bee:	c3                   	ret    
     bef:	90                   	nop
     bf0:	83 ec 0c             	sub    $0xc,%esp
     bf3:	68 2b 3f 00 00       	push   $0x3f2b
     bf8:	e8 93 2d 00 00       	call   3990 <printf>
     bfd:	83 c4 10             	add    $0x10,%esp
     c00:	8d 65 f8             	lea    -0x8(%ebp),%esp
     c03:	5b                   	pop    %ebx
     c04:	5e                   	pop    %esi
     c05:	5d                   	pop    %ebp
     c06:	c3                   	ret    
     c07:	e8 f6 29 00 00       	call   3602 <exit>
     c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000c10 <mem>:
     c10:	55                   	push   %ebp
     c11:	89 e5                	mov    %esp,%ebp
     c13:	57                   	push   %edi
     c14:	56                   	push   %esi
     c15:	53                   	push   %ebx
     c16:	31 db                	xor    %ebx,%ebx
     c18:	83 ec 18             	sub    $0x18,%esp
     c1b:	68 38 3f 00 00       	push   $0x3f38
     c20:	e8 6b 2d 00 00       	call   3990 <printf>
     c25:	e8 58 2a 00 00       	call   3682 <getpid>
     c2a:	89 c6                	mov    %eax,%esi
     c2c:	e8 c9 29 00 00       	call   35fa <fork>
     c31:	83 c4 10             	add    $0x10,%esp
     c34:	85 c0                	test   %eax,%eax
     c36:	74 0c                	je     c44 <mem+0x34>
     c38:	e9 8b 00 00 00       	jmp    cc8 <mem+0xb8>
     c3d:	8d 76 00             	lea    0x0(%esi),%esi
     c40:	89 18                	mov    %ebx,(%eax)
     c42:	89 c3                	mov    %eax,%ebx
     c44:	83 ec 0c             	sub    $0xc,%esp
     c47:	68 11 27 00 00       	push   $0x2711
     c4c:	e8 ef 2d 00 00       	call   3a40 <malloc>
     c51:	83 c4 10             	add    $0x10,%esp
     c54:	85 c0                	test   %eax,%eax
     c56:	75 e8                	jne    c40 <mem+0x30>
     c58:	85 db                	test   %ebx,%ebx
     c5a:	74 18                	je     c74 <mem+0x64>
     c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c60:	8b 3b                	mov    (%ebx),%edi
     c62:	83 ec 0c             	sub    $0xc,%esp
     c65:	53                   	push   %ebx
     c66:	89 fb                	mov    %edi,%ebx
     c68:	e8 43 2d 00 00       	call   39b0 <free>
     c6d:	83 c4 10             	add    $0x10,%esp
     c70:	85 db                	test   %ebx,%ebx
     c72:	75 ec                	jne    c60 <mem+0x50>
     c74:	83 ec 0c             	sub    $0xc,%esp
     c77:	68 00 50 00 00       	push   $0x5000
     c7c:	e8 bf 2d 00 00       	call   3a40 <malloc>
     c81:	83 c4 10             	add    $0x10,%esp
     c84:	85 c0                	test   %eax,%eax
     c86:	74 20                	je     ca8 <mem+0x98>
     c88:	83 ec 0c             	sub    $0xc,%esp
     c8b:	50                   	push   %eax
     c8c:	e8 1f 2d 00 00       	call   39b0 <free>
     c91:	c7 04 24 5c 3f 00 00 	movl   $0x3f5c,(%esp)
     c98:	e8 f3 2c 00 00       	call   3990 <printf>
     c9d:	e8 60 29 00 00       	call   3602 <exit>
     ca2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     ca8:	83 ec 0c             	sub    $0xc,%esp
     cab:	68 42 3f 00 00       	push   $0x3f42
     cb0:	e8 db 2c 00 00       	call   3990 <printf>
     cb5:	89 34 24             	mov    %esi,(%esp)
     cb8:	e8 75 29 00 00       	call   3632 <kill>
     cbd:	e8 40 29 00 00       	call   3602 <exit>
     cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     cc8:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ccb:	5b                   	pop    %ebx
     ccc:	5e                   	pop    %esi
     ccd:	5f                   	pop    %edi
     cce:	5d                   	pop    %ebp
     ccf:	e9 36 29 00 00       	jmp    360a <wait>
     cd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     cda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000ce0 <sharedfd>:
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
     ce3:	57                   	push   %edi
     ce4:	56                   	push   %esi
     ce5:	53                   	push   %ebx
     ce6:	83 ec 38             	sub    $0x38,%esp
     ce9:	68 64 3f 00 00       	push   $0x3f64
     cee:	e8 9d 2c 00 00       	call   3990 <printf>
     cf3:	c7 04 24 73 3f 00 00 	movl   $0x3f73,(%esp)
     cfa:	e8 53 29 00 00       	call   3652 <unlink>
     cff:	5b                   	pop    %ebx
     d00:	5e                   	pop    %esi
     d01:	68 02 02 00 00       	push   $0x202
     d06:	68 73 3f 00 00       	push   $0x3f73
     d0b:	e8 32 29 00 00       	call   3642 <open>
     d10:	83 c4 10             	add    $0x10,%esp
     d13:	85 c0                	test   %eax,%eax
     d15:	0f 88 35 01 00 00    	js     e50 <sharedfd+0x170>
     d1b:	89 c6                	mov    %eax,%esi
     d1d:	bb e8 03 00 00       	mov    $0x3e8,%ebx
     d22:	e8 d3 28 00 00       	call   35fa <fork>
     d27:	83 f8 01             	cmp    $0x1,%eax
     d2a:	89 c7                	mov    %eax,%edi
     d2c:	19 c0                	sbb    %eax,%eax
     d2e:	83 ec 04             	sub    $0x4,%esp
     d31:	83 e0 f3             	and    $0xfffffff3,%eax
     d34:	6a 0a                	push   $0xa
     d36:	83 c0 70             	add    $0x70,%eax
     d39:	50                   	push   %eax
     d3a:	8d 45 de             	lea    -0x22(%ebp),%eax
     d3d:	50                   	push   %eax
     d3e:	e8 1d 27 00 00       	call   3460 <memset>
     d43:	83 c4 10             	add    $0x10,%esp
     d46:	eb 0d                	jmp    d55 <sharedfd+0x75>
     d48:	90                   	nop
     d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d50:	83 eb 01             	sub    $0x1,%ebx
     d53:	74 27                	je     d7c <sharedfd+0x9c>
     d55:	8d 45 de             	lea    -0x22(%ebp),%eax
     d58:	83 ec 04             	sub    $0x4,%esp
     d5b:	6a 0a                	push   $0xa
     d5d:	50                   	push   %eax
     d5e:	56                   	push   %esi
     d5f:	e8 be 28 00 00       	call   3622 <write>
     d64:	83 c4 10             	add    $0x10,%esp
     d67:	83 f8 0a             	cmp    $0xa,%eax
     d6a:	74 e4                	je     d50 <sharedfd+0x70>
     d6c:	83 ec 0c             	sub    $0xc,%esp
     d6f:	68 64 4c 00 00       	push   $0x4c64
     d74:	e8 17 2c 00 00       	call   3990 <printf>
     d79:	83 c4 10             	add    $0x10,%esp
     d7c:	85 ff                	test   %edi,%edi
     d7e:	0f 84 fc 00 00 00    	je     e80 <sharedfd+0x1a0>
     d84:	e8 81 28 00 00       	call   360a <wait>
     d89:	83 ec 0c             	sub    $0xc,%esp
     d8c:	31 db                	xor    %ebx,%ebx
     d8e:	31 ff                	xor    %edi,%edi
     d90:	56                   	push   %esi
     d91:	8d 75 e8             	lea    -0x18(%ebp),%esi
     d94:	e8 91 28 00 00       	call   362a <close>
     d99:	5a                   	pop    %edx
     d9a:	59                   	pop    %ecx
     d9b:	6a 00                	push   $0x0
     d9d:	68 73 3f 00 00       	push   $0x3f73
     da2:	e8 9b 28 00 00       	call   3642 <open>
     da7:	83 c4 10             	add    $0x10,%esp
     daa:	85 c0                	test   %eax,%eax
     dac:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     daf:	0f 88 b3 00 00 00    	js     e68 <sharedfd+0x188>
     db5:	89 f8                	mov    %edi,%eax
     db7:	89 df                	mov    %ebx,%edi
     db9:	89 c3                	mov    %eax,%ebx
     dbb:	90                   	nop
     dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     dc0:	8d 45 de             	lea    -0x22(%ebp),%eax
     dc3:	83 ec 04             	sub    $0x4,%esp
     dc6:	6a 0a                	push   $0xa
     dc8:	50                   	push   %eax
     dc9:	ff 75 d4             	pushl  -0x2c(%ebp)
     dcc:	e8 49 28 00 00       	call   361a <read>
     dd1:	83 c4 10             	add    $0x10,%esp
     dd4:	85 c0                	test   %eax,%eax
     dd6:	7e 28                	jle    e00 <sharedfd+0x120>
     dd8:	8d 45 de             	lea    -0x22(%ebp),%eax
     ddb:	eb 15                	jmp    df2 <sharedfd+0x112>
     ddd:	8d 76 00             	lea    0x0(%esi),%esi
     de0:	80 fa 70             	cmp    $0x70,%dl
     de3:	0f 94 c2             	sete   %dl
     de6:	0f b6 d2             	movzbl %dl,%edx
     de9:	01 d7                	add    %edx,%edi
     deb:	83 c0 01             	add    $0x1,%eax
     dee:	39 f0                	cmp    %esi,%eax
     df0:	74 ce                	je     dc0 <sharedfd+0xe0>
     df2:	0f b6 10             	movzbl (%eax),%edx
     df5:	80 fa 63             	cmp    $0x63,%dl
     df8:	75 e6                	jne    de0 <sharedfd+0x100>
     dfa:	83 c3 01             	add    $0x1,%ebx
     dfd:	eb ec                	jmp    deb <sharedfd+0x10b>
     dff:	90                   	nop
     e00:	83 ec 0c             	sub    $0xc,%esp
     e03:	89 d8                	mov    %ebx,%eax
     e05:	ff 75 d4             	pushl  -0x2c(%ebp)
     e08:	89 fb                	mov    %edi,%ebx
     e0a:	89 c7                	mov    %eax,%edi
     e0c:	e8 19 28 00 00       	call   362a <close>
     e11:	c7 04 24 73 3f 00 00 	movl   $0x3f73,(%esp)
     e18:	e8 35 28 00 00       	call   3652 <unlink>
     e1d:	83 c4 10             	add    $0x10,%esp
     e20:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
     e26:	75 5d                	jne    e85 <sharedfd+0x1a5>
     e28:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     e2e:	75 55                	jne    e85 <sharedfd+0x1a5>
     e30:	83 ec 0c             	sub    $0xc,%esp
     e33:	68 7c 3f 00 00       	push   $0x3f7c
     e38:	e8 53 2b 00 00       	call   3990 <printf>
     e3d:	83 c4 10             	add    $0x10,%esp
     e40:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e43:	5b                   	pop    %ebx
     e44:	5e                   	pop    %esi
     e45:	5f                   	pop    %edi
     e46:	5d                   	pop    %ebp
     e47:	c3                   	ret    
     e48:	90                   	nop
     e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e50:	83 ec 0c             	sub    $0xc,%esp
     e53:	68 38 4c 00 00       	push   $0x4c38
     e58:	e8 33 2b 00 00       	call   3990 <printf>
     e5d:	83 c4 10             	add    $0x10,%esp
     e60:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e63:	5b                   	pop    %ebx
     e64:	5e                   	pop    %esi
     e65:	5f                   	pop    %edi
     e66:	5d                   	pop    %ebp
     e67:	c3                   	ret    
     e68:	83 ec 0c             	sub    $0xc,%esp
     e6b:	68 84 4c 00 00       	push   $0x4c84
     e70:	e8 1b 2b 00 00       	call   3990 <printf>
     e75:	83 c4 10             	add    $0x10,%esp
     e78:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e7b:	5b                   	pop    %ebx
     e7c:	5e                   	pop    %esi
     e7d:	5f                   	pop    %edi
     e7e:	5d                   	pop    %ebp
     e7f:	c3                   	ret    
     e80:	e8 7d 27 00 00       	call   3602 <exit>
     e85:	50                   	push   %eax
     e86:	53                   	push   %ebx
     e87:	57                   	push   %edi
     e88:	68 89 3f 00 00       	push   $0x3f89
     e8d:	e8 fe 2a 00 00       	call   3990 <printf>
     e92:	e8 6b 27 00 00       	call   3602 <exit>
     e97:	89 f6                	mov    %esi,%esi
     e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ea0 <fourfiles>:
     ea0:	55                   	push   %ebp
     ea1:	89 e5                	mov    %esp,%ebp
     ea3:	57                   	push   %edi
     ea4:	56                   	push   %esi
     ea5:	53                   	push   %ebx
     ea6:	be 9e 3f 00 00       	mov    $0x3f9e,%esi
     eab:	31 db                	xor    %ebx,%ebx
     ead:	83 ec 38             	sub    $0x38,%esp
     eb0:	c7 45 d8 9e 3f 00 00 	movl   $0x3f9e,-0x28(%ebp)
     eb7:	c7 45 dc e7 40 00 00 	movl   $0x40e7,-0x24(%ebp)
     ebe:	68 a4 3f 00 00       	push   $0x3fa4
     ec3:	c7 45 e0 eb 40 00 00 	movl   $0x40eb,-0x20(%ebp)
     eca:	c7 45 e4 a1 3f 00 00 	movl   $0x3fa1,-0x1c(%ebp)
     ed1:	e8 ba 2a 00 00       	call   3990 <printf>
     ed6:	83 c4 10             	add    $0x10,%esp
     ed9:	83 ec 0c             	sub    $0xc,%esp
     edc:	56                   	push   %esi
     edd:	e8 70 27 00 00       	call   3652 <unlink>
     ee2:	e8 13 27 00 00       	call   35fa <fork>
     ee7:	83 c4 10             	add    $0x10,%esp
     eea:	85 c0                	test   %eax,%eax
     eec:	0f 88 65 01 00 00    	js     1057 <fourfiles+0x1b7>
     ef2:	0f 84 df 00 00 00    	je     fd7 <fourfiles+0x137>
     ef8:	83 c3 01             	add    $0x1,%ebx
     efb:	83 fb 04             	cmp    $0x4,%ebx
     efe:	74 06                	je     f06 <fourfiles+0x66>
     f00:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
     f04:	eb d3                	jmp    ed9 <fourfiles+0x39>
     f06:	e8 ff 26 00 00       	call   360a <wait>
     f0b:	31 ff                	xor    %edi,%edi
     f0d:	e8 f8 26 00 00       	call   360a <wait>
     f12:	e8 f3 26 00 00       	call   360a <wait>
     f17:	e8 ee 26 00 00       	call   360a <wait>
     f1c:	c7 45 d0 9e 3f 00 00 	movl   $0x3f9e,-0x30(%ebp)
     f23:	83 ec 08             	sub    $0x8,%esp
     f26:	31 db                	xor    %ebx,%ebx
     f28:	6a 00                	push   $0x0
     f2a:	ff 75 d0             	pushl  -0x30(%ebp)
     f2d:	e8 10 27 00 00       	call   3642 <open>
     f32:	83 c4 10             	add    $0x10,%esp
     f35:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     f38:	90                   	nop
     f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f40:	83 ec 04             	sub    $0x4,%esp
     f43:	68 00 20 00 00       	push   $0x2000
     f48:	68 00 84 00 00       	push   $0x8400
     f4d:	ff 75 d4             	pushl  -0x2c(%ebp)
     f50:	e8 c5 26 00 00       	call   361a <read>
     f55:	83 c4 10             	add    $0x10,%esp
     f58:	85 c0                	test   %eax,%eax
     f5a:	7e 26                	jle    f82 <fourfiles+0xe2>
     f5c:	31 d2                	xor    %edx,%edx
     f5e:	66 90                	xchg   %ax,%ax
     f60:	0f be b2 00 84 00 00 	movsbl 0x8400(%edx),%esi
     f67:	83 ff 01             	cmp    $0x1,%edi
     f6a:	19 c9                	sbb    %ecx,%ecx
     f6c:	83 c1 31             	add    $0x31,%ecx
     f6f:	39 ce                	cmp    %ecx,%esi
     f71:	0f 85 bc 00 00 00    	jne    1033 <fourfiles+0x193>
     f77:	83 c2 01             	add    $0x1,%edx
     f7a:	39 d0                	cmp    %edx,%eax
     f7c:	75 e2                	jne    f60 <fourfiles+0xc0>
     f7e:	01 c3                	add    %eax,%ebx
     f80:	eb be                	jmp    f40 <fourfiles+0xa0>
     f82:	83 ec 0c             	sub    $0xc,%esp
     f85:	ff 75 d4             	pushl  -0x2c(%ebp)
     f88:	e8 9d 26 00 00       	call   362a <close>
     f8d:	83 c4 10             	add    $0x10,%esp
     f90:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
     f96:	0f 85 cd 00 00 00    	jne    1069 <fourfiles+0x1c9>
     f9c:	83 ec 0c             	sub    $0xc,%esp
     f9f:	ff 75 d0             	pushl  -0x30(%ebp)
     fa2:	e8 ab 26 00 00       	call   3652 <unlink>
     fa7:	83 c4 10             	add    $0x10,%esp
     faa:	83 ff 01             	cmp    $0x1,%edi
     fad:	75 18                	jne    fc7 <fourfiles+0x127>
     faf:	83 ec 0c             	sub    $0xc,%esp
     fb2:	68 e2 3f 00 00       	push   $0x3fe2
     fb7:	e8 d4 29 00 00       	call   3990 <printf>
     fbc:	83 c4 10             	add    $0x10,%esp
     fbf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fc2:	5b                   	pop    %ebx
     fc3:	5e                   	pop    %esi
     fc4:	5f                   	pop    %edi
     fc5:	5d                   	pop    %ebp
     fc6:	c3                   	ret    
     fc7:	8b 45 dc             	mov    -0x24(%ebp),%eax
     fca:	bf 01 00 00 00       	mov    $0x1,%edi
     fcf:	89 45 d0             	mov    %eax,-0x30(%ebp)
     fd2:	e9 4c ff ff ff       	jmp    f23 <fourfiles+0x83>
     fd7:	83 ec 08             	sub    $0x8,%esp
     fda:	68 02 02 00 00       	push   $0x202
     fdf:	56                   	push   %esi
     fe0:	e8 5d 26 00 00       	call   3642 <open>
     fe5:	83 c4 10             	add    $0x10,%esp
     fe8:	85 c0                	test   %eax,%eax
     fea:	89 c6                	mov    %eax,%esi
     fec:	78 57                	js     1045 <fourfiles+0x1a5>
     fee:	83 ec 04             	sub    $0x4,%esp
     ff1:	83 c3 30             	add    $0x30,%ebx
     ff4:	68 00 02 00 00       	push   $0x200
     ff9:	53                   	push   %ebx
     ffa:	bb 0c 00 00 00       	mov    $0xc,%ebx
     fff:	68 00 84 00 00       	push   $0x8400
    1004:	e8 57 24 00 00       	call   3460 <memset>
    1009:	83 c4 10             	add    $0x10,%esp
    100c:	83 ec 04             	sub    $0x4,%esp
    100f:	68 f4 01 00 00       	push   $0x1f4
    1014:	68 00 84 00 00       	push   $0x8400
    1019:	56                   	push   %esi
    101a:	e8 03 26 00 00       	call   3622 <write>
    101f:	83 c4 10             	add    $0x10,%esp
    1022:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    1027:	75 52                	jne    107b <fourfiles+0x1db>
    1029:	83 eb 01             	sub    $0x1,%ebx
    102c:	75 de                	jne    100c <fourfiles+0x16c>
    102e:	e8 cf 25 00 00       	call   3602 <exit>
    1033:	83 ec 0c             	sub    $0xc,%esp
    1036:	68 c5 3f 00 00       	push   $0x3fc5
    103b:	e8 50 29 00 00       	call   3990 <printf>
    1040:	e8 bd 25 00 00       	call   3602 <exit>
    1045:	83 ec 0c             	sub    $0xc,%esp
    1048:	68 3f 42 00 00       	push   $0x423f
    104d:	e8 3e 29 00 00       	call   3990 <printf>
    1052:	e8 ab 25 00 00       	call   3602 <exit>
    1057:	83 ec 0c             	sub    $0xc,%esp
    105a:	68 79 4a 00 00       	push   $0x4a79
    105f:	e8 2c 29 00 00       	call   3990 <printf>
    1064:	e8 99 25 00 00       	call   3602 <exit>
    1069:	50                   	push   %eax
    106a:	50                   	push   %eax
    106b:	53                   	push   %ebx
    106c:	68 d1 3f 00 00       	push   $0x3fd1
    1071:	e8 1a 29 00 00       	call   3990 <printf>
    1076:	e8 87 25 00 00       	call   3602 <exit>
    107b:	52                   	push   %edx
    107c:	52                   	push   %edx
    107d:	50                   	push   %eax
    107e:	68 b4 3f 00 00       	push   $0x3fb4
    1083:	e8 08 29 00 00       	call   3990 <printf>
    1088:	e8 75 25 00 00       	call   3602 <exit>
    108d:	8d 76 00             	lea    0x0(%esi),%esi

00001090 <createdelete>:
    1090:	55                   	push   %ebp
    1091:	89 e5                	mov    %esp,%ebp
    1093:	57                   	push   %edi
    1094:	56                   	push   %esi
    1095:	53                   	push   %ebx
    1096:	31 db                	xor    %ebx,%ebx
    1098:	83 ec 48             	sub    $0x48,%esp
    109b:	68 f0 3f 00 00       	push   $0x3ff0
    10a0:	e8 eb 28 00 00       	call   3990 <printf>
    10a5:	83 c4 10             	add    $0x10,%esp
    10a8:	e8 4d 25 00 00       	call   35fa <fork>
    10ad:	85 c0                	test   %eax,%eax
    10af:	0f 88 bd 01 00 00    	js     1272 <createdelete+0x1e2>
    10b5:	0f 84 0d 01 00 00    	je     11c8 <createdelete+0x138>
    10bb:	83 c3 01             	add    $0x1,%ebx
    10be:	83 fb 04             	cmp    $0x4,%ebx
    10c1:	75 e5                	jne    10a8 <createdelete+0x18>
    10c3:	8d 7d c8             	lea    -0x38(%ebp),%edi
    10c6:	be ff ff ff ff       	mov    $0xffffffff,%esi
    10cb:	e8 3a 25 00 00       	call   360a <wait>
    10d0:	e8 35 25 00 00       	call   360a <wait>
    10d5:	e8 30 25 00 00       	call   360a <wait>
    10da:	e8 2b 25 00 00       	call   360a <wait>
    10df:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    10e3:	90                   	nop
    10e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10e8:	8d 46 31             	lea    0x31(%esi),%eax
    10eb:	88 45 c7             	mov    %al,-0x39(%ebp)
    10ee:	8d 46 01             	lea    0x1(%esi),%eax
    10f1:	83 f8 09             	cmp    $0x9,%eax
    10f4:	89 45 c0             	mov    %eax,-0x40(%ebp)
    10f7:	0f 9f c3             	setg   %bl
    10fa:	85 c0                	test   %eax,%eax
    10fc:	0f 94 c0             	sete   %al
    10ff:	09 c3                	or     %eax,%ebx
    1101:	88 5d c6             	mov    %bl,-0x3a(%ebp)
    1104:	bb 70 00 00 00       	mov    $0x70,%ebx
    1109:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    110d:	83 ec 08             	sub    $0x8,%esp
    1110:	88 5d c8             	mov    %bl,-0x38(%ebp)
    1113:	6a 00                	push   $0x0
    1115:	57                   	push   %edi
    1116:	88 45 c9             	mov    %al,-0x37(%ebp)
    1119:	e8 24 25 00 00       	call   3642 <open>
    111e:	83 c4 10             	add    $0x10,%esp
    1121:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    1125:	0f 84 85 00 00 00    	je     11b0 <createdelete+0x120>
    112b:	85 c0                	test   %eax,%eax
    112d:	0f 88 1a 01 00 00    	js     124d <createdelete+0x1bd>
    1133:	83 fe 08             	cmp    $0x8,%esi
    1136:	0f 86 50 01 00 00    	jbe    128c <createdelete+0x1fc>
    113c:	83 ec 0c             	sub    $0xc,%esp
    113f:	50                   	push   %eax
    1140:	e8 e5 24 00 00       	call   362a <close>
    1145:	83 c4 10             	add    $0x10,%esp
    1148:	83 c3 01             	add    $0x1,%ebx
    114b:	80 fb 74             	cmp    $0x74,%bl
    114e:	75 b9                	jne    1109 <createdelete+0x79>
    1150:	8b 75 c0             	mov    -0x40(%ebp),%esi
    1153:	83 fe 13             	cmp    $0x13,%esi
    1156:	75 90                	jne    10e8 <createdelete+0x58>
    1158:	be 70 00 00 00       	mov    $0x70,%esi
    115d:	8d 76 00             	lea    0x0(%esi),%esi
    1160:	8d 46 c0             	lea    -0x40(%esi),%eax
    1163:	bb 04 00 00 00       	mov    $0x4,%ebx
    1168:	88 45 c7             	mov    %al,-0x39(%ebp)
    116b:	89 f0                	mov    %esi,%eax
    116d:	83 ec 0c             	sub    $0xc,%esp
    1170:	88 45 c8             	mov    %al,-0x38(%ebp)
    1173:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    1177:	57                   	push   %edi
    1178:	88 45 c9             	mov    %al,-0x37(%ebp)
    117b:	e8 d2 24 00 00       	call   3652 <unlink>
    1180:	83 c4 10             	add    $0x10,%esp
    1183:	83 eb 01             	sub    $0x1,%ebx
    1186:	75 e3                	jne    116b <createdelete+0xdb>
    1188:	83 c6 01             	add    $0x1,%esi
    118b:	89 f0                	mov    %esi,%eax
    118d:	3c 84                	cmp    $0x84,%al
    118f:	75 cf                	jne    1160 <createdelete+0xd0>
    1191:	83 ec 0c             	sub    $0xc,%esp
    1194:	68 03 40 00 00       	push   $0x4003
    1199:	e8 f2 27 00 00       	call   3990 <printf>
    119e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11a1:	5b                   	pop    %ebx
    11a2:	5e                   	pop    %esi
    11a3:	5f                   	pop    %edi
    11a4:	5d                   	pop    %ebp
    11a5:	c3                   	ret    
    11a6:	8d 76 00             	lea    0x0(%esi),%esi
    11a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    11b0:	83 fe 08             	cmp    $0x8,%esi
    11b3:	0f 86 cb 00 00 00    	jbe    1284 <createdelete+0x1f4>
    11b9:	85 c0                	test   %eax,%eax
    11bb:	78 8b                	js     1148 <createdelete+0xb8>
    11bd:	e9 7a ff ff ff       	jmp    113c <createdelete+0xac>
    11c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11c8:	83 c3 70             	add    $0x70,%ebx
    11cb:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    11cf:	8d 7d c8             	lea    -0x38(%ebp),%edi
    11d2:	88 5d c8             	mov    %bl,-0x38(%ebp)
    11d5:	31 db                	xor    %ebx,%ebx
    11d7:	eb 0f                	jmp    11e8 <createdelete+0x158>
    11d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11e0:	83 fb 13             	cmp    $0x13,%ebx
    11e3:	74 63                	je     1248 <createdelete+0x1b8>
    11e5:	83 c3 01             	add    $0x1,%ebx
    11e8:	83 ec 08             	sub    $0x8,%esp
    11eb:	8d 43 30             	lea    0x30(%ebx),%eax
    11ee:	68 02 02 00 00       	push   $0x202
    11f3:	57                   	push   %edi
    11f4:	88 45 c9             	mov    %al,-0x37(%ebp)
    11f7:	e8 46 24 00 00       	call   3642 <open>
    11fc:	83 c4 10             	add    $0x10,%esp
    11ff:	85 c0                	test   %eax,%eax
    1201:	78 5d                	js     1260 <createdelete+0x1d0>
    1203:	83 ec 0c             	sub    $0xc,%esp
    1206:	50                   	push   %eax
    1207:	e8 1e 24 00 00       	call   362a <close>
    120c:	83 c4 10             	add    $0x10,%esp
    120f:	85 db                	test   %ebx,%ebx
    1211:	74 d2                	je     11e5 <createdelete+0x155>
    1213:	f6 c3 01             	test   $0x1,%bl
    1216:	75 c8                	jne    11e0 <createdelete+0x150>
    1218:	83 ec 0c             	sub    $0xc,%esp
    121b:	89 d8                	mov    %ebx,%eax
    121d:	d1 f8                	sar    %eax
    121f:	57                   	push   %edi
    1220:	83 c0 30             	add    $0x30,%eax
    1223:	88 45 c9             	mov    %al,-0x37(%ebp)
    1226:	e8 27 24 00 00       	call   3652 <unlink>
    122b:	83 c4 10             	add    $0x10,%esp
    122e:	85 c0                	test   %eax,%eax
    1230:	79 ae                	jns    11e0 <createdelete+0x150>
    1232:	83 ec 0c             	sub    $0xc,%esp
    1235:	68 f1 3b 00 00       	push   $0x3bf1
    123a:	e8 51 27 00 00       	call   3990 <printf>
    123f:	e8 be 23 00 00       	call   3602 <exit>
    1244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1248:	e8 b5 23 00 00       	call   3602 <exit>
    124d:	83 ec 08             	sub    $0x8,%esp
    1250:	57                   	push   %edi
    1251:	68 b0 4c 00 00       	push   $0x4cb0
    1256:	e8 35 27 00 00       	call   3990 <printf>
    125b:	e8 a2 23 00 00       	call   3602 <exit>
    1260:	83 ec 0c             	sub    $0xc,%esp
    1263:	68 3f 42 00 00       	push   $0x423f
    1268:	e8 23 27 00 00       	call   3990 <printf>
    126d:	e8 90 23 00 00       	call   3602 <exit>
    1272:	83 ec 0c             	sub    $0xc,%esp
    1275:	68 79 4a 00 00       	push   $0x4a79
    127a:	e8 11 27 00 00       	call   3990 <printf>
    127f:	e8 7e 23 00 00       	call   3602 <exit>
    1284:	85 c0                	test   %eax,%eax
    1286:	0f 88 bc fe ff ff    	js     1148 <createdelete+0xb8>
    128c:	50                   	push   %eax
    128d:	50                   	push   %eax
    128e:	57                   	push   %edi
    128f:	68 d4 4c 00 00       	push   $0x4cd4
    1294:	e8 f7 26 00 00       	call   3990 <printf>
    1299:	e8 64 23 00 00       	call   3602 <exit>
    129e:	66 90                	xchg   %ax,%ax

000012a0 <unlinkread>:
    12a0:	55                   	push   %ebp
    12a1:	89 e5                	mov    %esp,%ebp
    12a3:	56                   	push   %esi
    12a4:	53                   	push   %ebx
    12a5:	83 ec 0c             	sub    $0xc,%esp
    12a8:	68 14 40 00 00       	push   $0x4014
    12ad:	e8 de 26 00 00       	call   3990 <printf>
    12b2:	59                   	pop    %ecx
    12b3:	5b                   	pop    %ebx
    12b4:	68 02 02 00 00       	push   $0x202
    12b9:	68 25 40 00 00       	push   $0x4025
    12be:	e8 7f 23 00 00       	call   3642 <open>
    12c3:	83 c4 10             	add    $0x10,%esp
    12c6:	85 c0                	test   %eax,%eax
    12c8:	0f 88 e4 00 00 00    	js     13b2 <unlinkread+0x112>
    12ce:	83 ec 04             	sub    $0x4,%esp
    12d1:	89 c3                	mov    %eax,%ebx
    12d3:	6a 05                	push   $0x5
    12d5:	68 4a 40 00 00       	push   $0x404a
    12da:	50                   	push   %eax
    12db:	e8 42 23 00 00       	call   3622 <write>
    12e0:	89 1c 24             	mov    %ebx,(%esp)
    12e3:	e8 42 23 00 00       	call   362a <close>
    12e8:	58                   	pop    %eax
    12e9:	5a                   	pop    %edx
    12ea:	6a 02                	push   $0x2
    12ec:	68 25 40 00 00       	push   $0x4025
    12f1:	e8 4c 23 00 00       	call   3642 <open>
    12f6:	83 c4 10             	add    $0x10,%esp
    12f9:	85 c0                	test   %eax,%eax
    12fb:	89 c3                	mov    %eax,%ebx
    12fd:	0f 88 09 01 00 00    	js     140c <unlinkread+0x16c>
    1303:	83 ec 0c             	sub    $0xc,%esp
    1306:	68 25 40 00 00       	push   $0x4025
    130b:	e8 42 23 00 00       	call   3652 <unlink>
    1310:	83 c4 10             	add    $0x10,%esp
    1313:	85 c0                	test   %eax,%eax
    1315:	0f 85 df 00 00 00    	jne    13fa <unlinkread+0x15a>
    131b:	83 ec 08             	sub    $0x8,%esp
    131e:	68 02 02 00 00       	push   $0x202
    1323:	68 25 40 00 00       	push   $0x4025
    1328:	e8 15 23 00 00       	call   3642 <open>
    132d:	83 c4 0c             	add    $0xc,%esp
    1330:	89 c6                	mov    %eax,%esi
    1332:	6a 03                	push   $0x3
    1334:	68 82 40 00 00       	push   $0x4082
    1339:	50                   	push   %eax
    133a:	e8 e3 22 00 00       	call   3622 <write>
    133f:	89 34 24             	mov    %esi,(%esp)
    1342:	e8 e3 22 00 00       	call   362a <close>
    1347:	83 c4 0c             	add    $0xc,%esp
    134a:	68 00 20 00 00       	push   $0x2000
    134f:	68 00 84 00 00       	push   $0x8400
    1354:	53                   	push   %ebx
    1355:	e8 c0 22 00 00       	call   361a <read>
    135a:	83 c4 10             	add    $0x10,%esp
    135d:	83 f8 05             	cmp    $0x5,%eax
    1360:	0f 85 82 00 00 00    	jne    13e8 <unlinkread+0x148>
    1366:	80 3d 00 84 00 00 68 	cmpb   $0x68,0x8400
    136d:	75 67                	jne    13d6 <unlinkread+0x136>
    136f:	83 ec 04             	sub    $0x4,%esp
    1372:	6a 0a                	push   $0xa
    1374:	68 00 84 00 00       	push   $0x8400
    1379:	53                   	push   %ebx
    137a:	e8 a3 22 00 00       	call   3622 <write>
    137f:	83 c4 10             	add    $0x10,%esp
    1382:	83 f8 0a             	cmp    $0xa,%eax
    1385:	75 3d                	jne    13c4 <unlinkread+0x124>
    1387:	83 ec 0c             	sub    $0xc,%esp
    138a:	53                   	push   %ebx
    138b:	e8 9a 22 00 00       	call   362a <close>
    1390:	c7 04 24 25 40 00 00 	movl   $0x4025,(%esp)
    1397:	e8 b6 22 00 00       	call   3652 <unlink>
    139c:	c7 04 24 cd 40 00 00 	movl   $0x40cd,(%esp)
    13a3:	e8 e8 25 00 00       	call   3990 <printf>
    13a8:	83 c4 10             	add    $0x10,%esp
    13ab:	8d 65 f8             	lea    -0x8(%ebp),%esp
    13ae:	5b                   	pop    %ebx
    13af:	5e                   	pop    %esi
    13b0:	5d                   	pop    %ebp
    13b1:	c3                   	ret    
    13b2:	83 ec 0c             	sub    $0xc,%esp
    13b5:	68 30 40 00 00       	push   $0x4030
    13ba:	e8 d1 25 00 00       	call   3990 <printf>
    13bf:	e8 3e 22 00 00       	call   3602 <exit>
    13c4:	83 ec 0c             	sub    $0xc,%esp
    13c7:	68 b4 40 00 00       	push   $0x40b4
    13cc:	e8 bf 25 00 00       	call   3990 <printf>
    13d1:	e8 2c 22 00 00       	call   3602 <exit>
    13d6:	83 ec 0c             	sub    $0xc,%esp
    13d9:	68 9d 40 00 00       	push   $0x409d
    13de:	e8 ad 25 00 00       	call   3990 <printf>
    13e3:	e8 1a 22 00 00       	call   3602 <exit>
    13e8:	83 ec 0c             	sub    $0xc,%esp
    13eb:	68 86 40 00 00       	push   $0x4086
    13f0:	e8 9b 25 00 00       	call   3990 <printf>
    13f5:	e8 08 22 00 00       	call   3602 <exit>
    13fa:	83 ec 0c             	sub    $0xc,%esp
    13fd:	68 68 40 00 00       	push   $0x4068
    1402:	e8 89 25 00 00       	call   3990 <printf>
    1407:	e8 f6 21 00 00       	call   3602 <exit>
    140c:	83 ec 0c             	sub    $0xc,%esp
    140f:	68 50 40 00 00       	push   $0x4050
    1414:	e8 77 25 00 00       	call   3990 <printf>
    1419:	e8 e4 21 00 00       	call   3602 <exit>
    141e:	66 90                	xchg   %ax,%ax

00001420 <linktest>:
    1420:	55                   	push   %ebp
    1421:	89 e5                	mov    %esp,%ebp
    1423:	53                   	push   %ebx
    1424:	83 ec 10             	sub    $0x10,%esp
    1427:	68 dc 40 00 00       	push   $0x40dc
    142c:	e8 5f 25 00 00       	call   3990 <printf>
    1431:	c7 04 24 e6 40 00 00 	movl   $0x40e6,(%esp)
    1438:	e8 15 22 00 00       	call   3652 <unlink>
    143d:	c7 04 24 ea 40 00 00 	movl   $0x40ea,(%esp)
    1444:	e8 09 22 00 00       	call   3652 <unlink>
    1449:	58                   	pop    %eax
    144a:	5a                   	pop    %edx
    144b:	68 02 02 00 00       	push   $0x202
    1450:	68 e6 40 00 00       	push   $0x40e6
    1455:	e8 e8 21 00 00       	call   3642 <open>
    145a:	83 c4 10             	add    $0x10,%esp
    145d:	85 c0                	test   %eax,%eax
    145f:	0f 88 1c 01 00 00    	js     1581 <linktest+0x161>
    1465:	83 ec 04             	sub    $0x4,%esp
    1468:	89 c3                	mov    %eax,%ebx
    146a:	6a 05                	push   $0x5
    146c:	68 4a 40 00 00       	push   $0x404a
    1471:	50                   	push   %eax
    1472:	e8 ab 21 00 00       	call   3622 <write>
    1477:	83 c4 10             	add    $0x10,%esp
    147a:	83 f8 05             	cmp    $0x5,%eax
    147d:	0f 85 8e 01 00 00    	jne    1611 <linktest+0x1f1>
    1483:	83 ec 0c             	sub    $0xc,%esp
    1486:	53                   	push   %ebx
    1487:	e8 9e 21 00 00       	call   362a <close>
    148c:	59                   	pop    %ecx
    148d:	5b                   	pop    %ebx
    148e:	68 ea 40 00 00       	push   $0x40ea
    1493:	68 e6 40 00 00       	push   $0x40e6
    1498:	e8 c5 21 00 00       	call   3662 <link>
    149d:	83 c4 10             	add    $0x10,%esp
    14a0:	85 c0                	test   %eax,%eax
    14a2:	0f 88 57 01 00 00    	js     15ff <linktest+0x1df>
    14a8:	83 ec 0c             	sub    $0xc,%esp
    14ab:	68 e6 40 00 00       	push   $0x40e6
    14b0:	e8 9d 21 00 00       	call   3652 <unlink>
    14b5:	58                   	pop    %eax
    14b6:	5a                   	pop    %edx
    14b7:	6a 00                	push   $0x0
    14b9:	68 e6 40 00 00       	push   $0x40e6
    14be:	e8 7f 21 00 00       	call   3642 <open>
    14c3:	83 c4 10             	add    $0x10,%esp
    14c6:	85 c0                	test   %eax,%eax
    14c8:	0f 89 1f 01 00 00    	jns    15ed <linktest+0x1cd>
    14ce:	83 ec 08             	sub    $0x8,%esp
    14d1:	6a 00                	push   $0x0
    14d3:	68 ea 40 00 00       	push   $0x40ea
    14d8:	e8 65 21 00 00       	call   3642 <open>
    14dd:	83 c4 10             	add    $0x10,%esp
    14e0:	85 c0                	test   %eax,%eax
    14e2:	89 c3                	mov    %eax,%ebx
    14e4:	0f 88 f1 00 00 00    	js     15db <linktest+0x1bb>
    14ea:	83 ec 04             	sub    $0x4,%esp
    14ed:	68 00 20 00 00       	push   $0x2000
    14f2:	68 00 84 00 00       	push   $0x8400
    14f7:	50                   	push   %eax
    14f8:	e8 1d 21 00 00       	call   361a <read>
    14fd:	83 c4 10             	add    $0x10,%esp
    1500:	83 f8 05             	cmp    $0x5,%eax
    1503:	0f 85 c0 00 00 00    	jne    15c9 <linktest+0x1a9>
    1509:	83 ec 0c             	sub    $0xc,%esp
    150c:	53                   	push   %ebx
    150d:	e8 18 21 00 00       	call   362a <close>
    1512:	59                   	pop    %ecx
    1513:	5b                   	pop    %ebx
    1514:	68 ea 40 00 00       	push   $0x40ea
    1519:	68 ea 40 00 00       	push   $0x40ea
    151e:	e8 3f 21 00 00       	call   3662 <link>
    1523:	83 c4 10             	add    $0x10,%esp
    1526:	85 c0                	test   %eax,%eax
    1528:	0f 89 89 00 00 00    	jns    15b7 <linktest+0x197>
    152e:	83 ec 0c             	sub    $0xc,%esp
    1531:	68 ea 40 00 00       	push   $0x40ea
    1536:	e8 17 21 00 00       	call   3652 <unlink>
    153b:	58                   	pop    %eax
    153c:	5a                   	pop    %edx
    153d:	68 e6 40 00 00       	push   $0x40e6
    1542:	68 ea 40 00 00       	push   $0x40ea
    1547:	e8 16 21 00 00       	call   3662 <link>
    154c:	83 c4 10             	add    $0x10,%esp
    154f:	85 c0                	test   %eax,%eax
    1551:	79 52                	jns    15a5 <linktest+0x185>
    1553:	83 ec 08             	sub    $0x8,%esp
    1556:	68 e6 40 00 00       	push   $0x40e6
    155b:	68 ae 43 00 00       	push   $0x43ae
    1560:	e8 fd 20 00 00       	call   3662 <link>
    1565:	83 c4 10             	add    $0x10,%esp
    1568:	85 c0                	test   %eax,%eax
    156a:	79 27                	jns    1593 <linktest+0x173>
    156c:	83 ec 0c             	sub    $0xc,%esp
    156f:	68 84 41 00 00       	push   $0x4184
    1574:	e8 17 24 00 00       	call   3990 <printf>
    1579:	83 c4 10             	add    $0x10,%esp
    157c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    157f:	c9                   	leave  
    1580:	c3                   	ret    
    1581:	83 ec 0c             	sub    $0xc,%esp
    1584:	68 ee 40 00 00       	push   $0x40ee
    1589:	e8 02 24 00 00       	call   3990 <printf>
    158e:	e8 6f 20 00 00       	call   3602 <exit>
    1593:	83 ec 0c             	sub    $0xc,%esp
    1596:	68 68 41 00 00       	push   $0x4168
    159b:	e8 f0 23 00 00       	call   3990 <printf>
    15a0:	e8 5d 20 00 00       	call   3602 <exit>
    15a5:	83 ec 0c             	sub    $0xc,%esp
    15a8:	68 1c 4d 00 00       	push   $0x4d1c
    15ad:	e8 de 23 00 00       	call   3990 <printf>
    15b2:	e8 4b 20 00 00       	call   3602 <exit>
    15b7:	83 ec 0c             	sub    $0xc,%esp
    15ba:	68 4a 41 00 00       	push   $0x414a
    15bf:	e8 cc 23 00 00       	call   3990 <printf>
    15c4:	e8 39 20 00 00       	call   3602 <exit>
    15c9:	83 ec 0c             	sub    $0xc,%esp
    15cc:	68 39 41 00 00       	push   $0x4139
    15d1:	e8 ba 23 00 00       	call   3990 <printf>
    15d6:	e8 27 20 00 00       	call   3602 <exit>
    15db:	83 ec 0c             	sub    $0xc,%esp
    15de:	68 28 41 00 00       	push   $0x4128
    15e3:	e8 a8 23 00 00       	call   3990 <printf>
    15e8:	e8 15 20 00 00       	call   3602 <exit>
    15ed:	83 ec 0c             	sub    $0xc,%esp
    15f0:	68 f4 4c 00 00       	push   $0x4cf4
    15f5:	e8 96 23 00 00       	call   3990 <printf>
    15fa:	e8 03 20 00 00       	call   3602 <exit>
    15ff:	83 ec 0c             	sub    $0xc,%esp
    1602:	68 13 41 00 00       	push   $0x4113
    1607:	e8 84 23 00 00       	call   3990 <printf>
    160c:	e8 f1 1f 00 00       	call   3602 <exit>
    1611:	83 ec 0c             	sub    $0xc,%esp
    1614:	68 01 41 00 00       	push   $0x4101
    1619:	e8 72 23 00 00       	call   3990 <printf>
    161e:	e8 df 1f 00 00       	call   3602 <exit>
    1623:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001630 <concreate>:
    1630:	55                   	push   %ebp
    1631:	89 e5                	mov    %esp,%ebp
    1633:	57                   	push   %edi
    1634:	56                   	push   %esi
    1635:	53                   	push   %ebx
    1636:	31 f6                	xor    %esi,%esi
    1638:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    163b:	bf ab aa aa aa       	mov    $0xaaaaaaab,%edi
    1640:	83 ec 68             	sub    $0x68,%esp
    1643:	68 91 41 00 00       	push   $0x4191
    1648:	e8 43 23 00 00       	call   3990 <printf>
    164d:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
    1651:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    1655:	83 c4 10             	add    $0x10,%esp
    1658:	eb 4e                	jmp    16a8 <concreate+0x78>
    165a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1660:	89 f0                	mov    %esi,%eax
    1662:	89 f1                	mov    %esi,%ecx
    1664:	f7 e7                	mul    %edi
    1666:	d1 ea                	shr    %edx
    1668:	8d 04 52             	lea    (%edx,%edx,2),%eax
    166b:	29 c1                	sub    %eax,%ecx
    166d:	83 f9 01             	cmp    $0x1,%ecx
    1670:	0f 84 aa 00 00 00    	je     1720 <concreate+0xf0>
    1676:	83 ec 08             	sub    $0x8,%esp
    1679:	68 02 02 00 00       	push   $0x202
    167e:	53                   	push   %ebx
    167f:	e8 be 1f 00 00       	call   3642 <open>
    1684:	83 c4 10             	add    $0x10,%esp
    1687:	85 c0                	test   %eax,%eax
    1689:	78 67                	js     16f2 <concreate+0xc2>
    168b:	83 ec 0c             	sub    $0xc,%esp
    168e:	83 c6 01             	add    $0x1,%esi
    1691:	50                   	push   %eax
    1692:	e8 93 1f 00 00       	call   362a <close>
    1697:	83 c4 10             	add    $0x10,%esp
    169a:	e8 6b 1f 00 00       	call   360a <wait>
    169f:	83 fe 28             	cmp    $0x28,%esi
    16a2:	0f 84 9a 00 00 00    	je     1742 <concreate+0x112>
    16a8:	83 ec 0c             	sub    $0xc,%esp
    16ab:	8d 46 30             	lea    0x30(%esi),%eax
    16ae:	53                   	push   %ebx
    16af:	88 45 ae             	mov    %al,-0x52(%ebp)
    16b2:	e8 9b 1f 00 00       	call   3652 <unlink>
    16b7:	e8 3e 1f 00 00       	call   35fa <fork>
    16bc:	83 c4 10             	add    $0x10,%esp
    16bf:	85 c0                	test   %eax,%eax
    16c1:	75 9d                	jne    1660 <concreate+0x30>
    16c3:	89 f0                	mov    %esi,%eax
    16c5:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
    16ca:	f7 e2                	mul    %edx
    16cc:	c1 ea 02             	shr    $0x2,%edx
    16cf:	8d 04 92             	lea    (%edx,%edx,4),%eax
    16d2:	29 c6                	sub    %eax,%esi
    16d4:	83 fe 01             	cmp    $0x1,%esi
    16d7:	74 2f                	je     1708 <concreate+0xd8>
    16d9:	83 ec 08             	sub    $0x8,%esp
    16dc:	68 02 02 00 00       	push   $0x202
    16e1:	53                   	push   %ebx
    16e2:	e8 5b 1f 00 00       	call   3642 <open>
    16e7:	83 c4 10             	add    $0x10,%esp
    16ea:	85 c0                	test   %eax,%eax
    16ec:	0f 89 11 02 00 00    	jns    1903 <concreate+0x2d3>
    16f2:	83 ec 08             	sub    $0x8,%esp
    16f5:	53                   	push   %ebx
    16f6:	68 a4 41 00 00       	push   $0x41a4
    16fb:	e8 90 22 00 00       	call   3990 <printf>
    1700:	e8 fd 1e 00 00       	call   3602 <exit>
    1705:	8d 76 00             	lea    0x0(%esi),%esi
    1708:	83 ec 08             	sub    $0x8,%esp
    170b:	53                   	push   %ebx
    170c:	68 a1 41 00 00       	push   $0x41a1
    1711:	e8 4c 1f 00 00       	call   3662 <link>
    1716:	83 c4 10             	add    $0x10,%esp
    1719:	e8 e4 1e 00 00       	call   3602 <exit>
    171e:	66 90                	xchg   %ax,%ax
    1720:	83 ec 08             	sub    $0x8,%esp
    1723:	83 c6 01             	add    $0x1,%esi
    1726:	53                   	push   %ebx
    1727:	68 a1 41 00 00       	push   $0x41a1
    172c:	e8 31 1f 00 00       	call   3662 <link>
    1731:	83 c4 10             	add    $0x10,%esp
    1734:	e8 d1 1e 00 00       	call   360a <wait>
    1739:	83 fe 28             	cmp    $0x28,%esi
    173c:	0f 85 66 ff ff ff    	jne    16a8 <concreate+0x78>
    1742:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1745:	83 ec 04             	sub    $0x4,%esp
    1748:	6a 28                	push   $0x28
    174a:	6a 00                	push   $0x0
    174c:	50                   	push   %eax
    174d:	e8 0e 1d 00 00       	call   3460 <memset>
    1752:	5e                   	pop    %esi
    1753:	5f                   	pop    %edi
    1754:	6a 00                	push   $0x0
    1756:	68 ae 43 00 00       	push   $0x43ae
    175b:	8d 7d b0             	lea    -0x50(%ebp),%edi
    175e:	e8 df 1e 00 00       	call   3642 <open>
    1763:	83 c4 10             	add    $0x10,%esp
    1766:	89 c6                	mov    %eax,%esi
    1768:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    176f:	90                   	nop
    1770:	83 ec 04             	sub    $0x4,%esp
    1773:	6a 10                	push   $0x10
    1775:	57                   	push   %edi
    1776:	56                   	push   %esi
    1777:	e8 9e 1e 00 00       	call   361a <read>
    177c:	83 c4 10             	add    $0x10,%esp
    177f:	85 c0                	test   %eax,%eax
    1781:	7e 3d                	jle    17c0 <concreate+0x190>
    1783:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1788:	74 e6                	je     1770 <concreate+0x140>
    178a:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    178e:	75 e0                	jne    1770 <concreate+0x140>
    1790:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1794:	75 da                	jne    1770 <concreate+0x140>
    1796:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    179a:	83 e8 30             	sub    $0x30,%eax
    179d:	83 f8 27             	cmp    $0x27,%eax
    17a0:	0f 87 48 01 00 00    	ja     18ee <concreate+0x2be>
    17a6:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    17ab:	0f 85 28 01 00 00    	jne    18d9 <concreate+0x2a9>
    17b1:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
    17b6:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    17ba:	eb b4                	jmp    1770 <concreate+0x140>
    17bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    17c0:	83 ec 0c             	sub    $0xc,%esp
    17c3:	56                   	push   %esi
    17c4:	e8 61 1e 00 00       	call   362a <close>
    17c9:	83 c4 10             	add    $0x10,%esp
    17cc:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    17d0:	0f 85 f1 00 00 00    	jne    18c7 <concreate+0x297>
    17d6:	31 f6                	xor    %esi,%esi
    17d8:	eb 48                	jmp    1822 <concreate+0x1f2>
    17da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    17e0:	85 ff                	test   %edi,%edi
    17e2:	74 05                	je     17e9 <concreate+0x1b9>
    17e4:	83 fa 01             	cmp    $0x1,%edx
    17e7:	74 64                	je     184d <concreate+0x21d>
    17e9:	83 ec 0c             	sub    $0xc,%esp
    17ec:	53                   	push   %ebx
    17ed:	e8 60 1e 00 00       	call   3652 <unlink>
    17f2:	89 1c 24             	mov    %ebx,(%esp)
    17f5:	e8 58 1e 00 00       	call   3652 <unlink>
    17fa:	89 1c 24             	mov    %ebx,(%esp)
    17fd:	e8 50 1e 00 00       	call   3652 <unlink>
    1802:	89 1c 24             	mov    %ebx,(%esp)
    1805:	e8 48 1e 00 00       	call   3652 <unlink>
    180a:	83 c4 10             	add    $0x10,%esp
    180d:	85 ff                	test   %edi,%edi
    180f:	0f 84 04 ff ff ff    	je     1719 <concreate+0xe9>
    1815:	83 c6 01             	add    $0x1,%esi
    1818:	e8 ed 1d 00 00       	call   360a <wait>
    181d:	83 fe 28             	cmp    $0x28,%esi
    1820:	74 7e                	je     18a0 <concreate+0x270>
    1822:	8d 46 30             	lea    0x30(%esi),%eax
    1825:	88 45 ae             	mov    %al,-0x52(%ebp)
    1828:	e8 cd 1d 00 00       	call   35fa <fork>
    182d:	85 c0                	test   %eax,%eax
    182f:	89 c7                	mov    %eax,%edi
    1831:	0f 88 7e 00 00 00    	js     18b5 <concreate+0x285>
    1837:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    183c:	f7 e6                	mul    %esi
    183e:	d1 ea                	shr    %edx
    1840:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1843:	89 f2                	mov    %esi,%edx
    1845:	29 c2                	sub    %eax,%edx
    1847:	89 d0                	mov    %edx,%eax
    1849:	09 f8                	or     %edi,%eax
    184b:	75 93                	jne    17e0 <concreate+0x1b0>
    184d:	83 ec 08             	sub    $0x8,%esp
    1850:	6a 00                	push   $0x0
    1852:	53                   	push   %ebx
    1853:	e8 ea 1d 00 00       	call   3642 <open>
    1858:	89 04 24             	mov    %eax,(%esp)
    185b:	e8 ca 1d 00 00       	call   362a <close>
    1860:	58                   	pop    %eax
    1861:	5a                   	pop    %edx
    1862:	6a 00                	push   $0x0
    1864:	53                   	push   %ebx
    1865:	e8 d8 1d 00 00       	call   3642 <open>
    186a:	89 04 24             	mov    %eax,(%esp)
    186d:	e8 b8 1d 00 00       	call   362a <close>
    1872:	59                   	pop    %ecx
    1873:	58                   	pop    %eax
    1874:	6a 00                	push   $0x0
    1876:	53                   	push   %ebx
    1877:	e8 c6 1d 00 00       	call   3642 <open>
    187c:	89 04 24             	mov    %eax,(%esp)
    187f:	e8 a6 1d 00 00       	call   362a <close>
    1884:	58                   	pop    %eax
    1885:	5a                   	pop    %edx
    1886:	6a 00                	push   $0x0
    1888:	53                   	push   %ebx
    1889:	e8 b4 1d 00 00       	call   3642 <open>
    188e:	89 04 24             	mov    %eax,(%esp)
    1891:	e8 94 1d 00 00       	call   362a <close>
    1896:	83 c4 10             	add    $0x10,%esp
    1899:	e9 6f ff ff ff       	jmp    180d <concreate+0x1dd>
    189e:	66 90                	xchg   %ax,%ax
    18a0:	83 ec 0c             	sub    $0xc,%esp
    18a3:	68 f6 41 00 00       	push   $0x41f6
    18a8:	e8 e3 20 00 00       	call   3990 <printf>
    18ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
    18b0:	5b                   	pop    %ebx
    18b1:	5e                   	pop    %esi
    18b2:	5f                   	pop    %edi
    18b3:	5d                   	pop    %ebp
    18b4:	c3                   	ret    
    18b5:	83 ec 0c             	sub    $0xc,%esp
    18b8:	68 79 4a 00 00       	push   $0x4a79
    18bd:	e8 ce 20 00 00       	call   3990 <printf>
    18c2:	e8 3b 1d 00 00       	call   3602 <exit>
    18c7:	83 ec 0c             	sub    $0xc,%esp
    18ca:	68 40 4d 00 00       	push   $0x4d40
    18cf:	e8 bc 20 00 00       	call   3990 <printf>
    18d4:	e8 29 1d 00 00       	call   3602 <exit>
    18d9:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    18dc:	51                   	push   %ecx
    18dd:	51                   	push   %ecx
    18de:	50                   	push   %eax
    18df:	68 d9 41 00 00       	push   $0x41d9
    18e4:	e8 a7 20 00 00       	call   3990 <printf>
    18e9:	e8 14 1d 00 00       	call   3602 <exit>
    18ee:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    18f1:	53                   	push   %ebx
    18f2:	53                   	push   %ebx
    18f3:	50                   	push   %eax
    18f4:	68 c0 41 00 00       	push   $0x41c0
    18f9:	e8 92 20 00 00       	call   3990 <printf>
    18fe:	e8 ff 1c 00 00       	call   3602 <exit>
    1903:	83 ec 0c             	sub    $0xc,%esp
    1906:	50                   	push   %eax
    1907:	e8 1e 1d 00 00       	call   362a <close>
    190c:	83 c4 10             	add    $0x10,%esp
    190f:	e9 05 fe ff ff       	jmp    1719 <concreate+0xe9>
    1914:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    191a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001920 <linkunlink>:
    1920:	55                   	push   %ebp
    1921:	89 e5                	mov    %esp,%ebp
    1923:	57                   	push   %edi
    1924:	56                   	push   %esi
    1925:	53                   	push   %ebx
    1926:	83 ec 28             	sub    $0x28,%esp
    1929:	68 04 42 00 00       	push   $0x4204
    192e:	e8 5d 20 00 00       	call   3990 <printf>
    1933:	c7 04 24 91 44 00 00 	movl   $0x4491,(%esp)
    193a:	e8 13 1d 00 00       	call   3652 <unlink>
    193f:	e8 b6 1c 00 00       	call   35fa <fork>
    1944:	83 c4 10             	add    $0x10,%esp
    1947:	85 c0                	test   %eax,%eax
    1949:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    194c:	0f 88 b8 00 00 00    	js     1a0a <linkunlink+0xea>
    1952:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1956:	bb 64 00 00 00       	mov    $0x64,%ebx
    195b:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
    1960:	19 ff                	sbb    %edi,%edi
    1962:	83 e7 60             	and    $0x60,%edi
    1965:	83 c7 01             	add    $0x1,%edi
    1968:	eb 20                	jmp    198a <linkunlink+0x6a>
    196a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1970:	83 fa 01             	cmp    $0x1,%edx
    1973:	74 7b                	je     19f0 <linkunlink+0xd0>
    1975:	83 ec 0c             	sub    $0xc,%esp
    1978:	68 91 44 00 00       	push   $0x4491
    197d:	e8 d0 1c 00 00       	call   3652 <unlink>
    1982:	83 c4 10             	add    $0x10,%esp
    1985:	83 eb 01             	sub    $0x1,%ebx
    1988:	74 3d                	je     19c7 <linkunlink+0xa7>
    198a:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1990:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    1996:	89 f8                	mov    %edi,%eax
    1998:	f7 e6                	mul    %esi
    199a:	d1 ea                	shr    %edx
    199c:	8d 04 52             	lea    (%edx,%edx,2),%eax
    199f:	89 fa                	mov    %edi,%edx
    19a1:	29 c2                	sub    %eax,%edx
    19a3:	75 cb                	jne    1970 <linkunlink+0x50>
    19a5:	83 ec 08             	sub    $0x8,%esp
    19a8:	68 02 02 00 00       	push   $0x202
    19ad:	68 91 44 00 00       	push   $0x4491
    19b2:	e8 8b 1c 00 00       	call   3642 <open>
    19b7:	89 04 24             	mov    %eax,(%esp)
    19ba:	e8 6b 1c 00 00       	call   362a <close>
    19bf:	83 c4 10             	add    $0x10,%esp
    19c2:	83 eb 01             	sub    $0x1,%ebx
    19c5:	75 c3                	jne    198a <linkunlink+0x6a>
    19c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19ca:	85 c0                	test   %eax,%eax
    19cc:	74 4e                	je     1a1c <linkunlink+0xfc>
    19ce:	e8 37 1c 00 00       	call   360a <wait>
    19d3:	83 ec 0c             	sub    $0xc,%esp
    19d6:	68 19 42 00 00       	push   $0x4219
    19db:	e8 b0 1f 00 00       	call   3990 <printf>
    19e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19e3:	5b                   	pop    %ebx
    19e4:	5e                   	pop    %esi
    19e5:	5f                   	pop    %edi
    19e6:	5d                   	pop    %ebp
    19e7:	c3                   	ret    
    19e8:	90                   	nop
    19e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    19f0:	83 ec 08             	sub    $0x8,%esp
    19f3:	68 91 44 00 00       	push   $0x4491
    19f8:	68 15 42 00 00       	push   $0x4215
    19fd:	e8 60 1c 00 00       	call   3662 <link>
    1a02:	83 c4 10             	add    $0x10,%esp
    1a05:	e9 7b ff ff ff       	jmp    1985 <linkunlink+0x65>
    1a0a:	83 ec 0c             	sub    $0xc,%esp
    1a0d:	68 79 4a 00 00       	push   $0x4a79
    1a12:	e8 79 1f 00 00       	call   3990 <printf>
    1a17:	e8 e6 1b 00 00       	call   3602 <exit>
    1a1c:	e8 e1 1b 00 00       	call   3602 <exit>
    1a21:	eb 0d                	jmp    1a30 <bigdir>
    1a23:	90                   	nop
    1a24:	90                   	nop
    1a25:	90                   	nop
    1a26:	90                   	nop
    1a27:	90                   	nop
    1a28:	90                   	nop
    1a29:	90                   	nop
    1a2a:	90                   	nop
    1a2b:	90                   	nop
    1a2c:	90                   	nop
    1a2d:	90                   	nop
    1a2e:	90                   	nop
    1a2f:	90                   	nop

00001a30 <bigdir>:
    1a30:	55                   	push   %ebp
    1a31:	89 e5                	mov    %esp,%ebp
    1a33:	57                   	push   %edi
    1a34:	56                   	push   %esi
    1a35:	53                   	push   %ebx
    1a36:	83 ec 28             	sub    $0x28,%esp
    1a39:	68 28 42 00 00       	push   $0x4228
    1a3e:	e8 4d 1f 00 00       	call   3990 <printf>
    1a43:	c7 04 24 35 42 00 00 	movl   $0x4235,(%esp)
    1a4a:	e8 03 1c 00 00       	call   3652 <unlink>
    1a4f:	58                   	pop    %eax
    1a50:	5a                   	pop    %edx
    1a51:	68 00 02 00 00       	push   $0x200
    1a56:	68 35 42 00 00       	push   $0x4235
    1a5b:	e8 e2 1b 00 00       	call   3642 <open>
    1a60:	83 c4 10             	add    $0x10,%esp
    1a63:	85 c0                	test   %eax,%eax
    1a65:	0f 88 da 00 00 00    	js     1b45 <bigdir+0x115>
    1a6b:	83 ec 0c             	sub    $0xc,%esp
    1a6e:	8d 7d de             	lea    -0x22(%ebp),%edi
    1a71:	31 f6                	xor    %esi,%esi
    1a73:	50                   	push   %eax
    1a74:	e8 b1 1b 00 00       	call   362a <close>
    1a79:	83 c4 10             	add    $0x10,%esp
    1a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1a80:	89 f0                	mov    %esi,%eax
    1a82:	83 ec 08             	sub    $0x8,%esp
    1a85:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    1a89:	c1 f8 06             	sar    $0x6,%eax
    1a8c:	57                   	push   %edi
    1a8d:	68 35 42 00 00       	push   $0x4235
    1a92:	83 c0 30             	add    $0x30,%eax
    1a95:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    1a99:	88 45 df             	mov    %al,-0x21(%ebp)
    1a9c:	89 f0                	mov    %esi,%eax
    1a9e:	83 e0 3f             	and    $0x3f,%eax
    1aa1:	83 c0 30             	add    $0x30,%eax
    1aa4:	88 45 e0             	mov    %al,-0x20(%ebp)
    1aa7:	e8 b6 1b 00 00       	call   3662 <link>
    1aac:	83 c4 10             	add    $0x10,%esp
    1aaf:	85 c0                	test   %eax,%eax
    1ab1:	89 c3                	mov    %eax,%ebx
    1ab3:	75 6c                	jne    1b21 <bigdir+0xf1>
    1ab5:	83 c6 01             	add    $0x1,%esi
    1ab8:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1abe:	75 c0                	jne    1a80 <bigdir+0x50>
    1ac0:	83 ec 0c             	sub    $0xc,%esp
    1ac3:	68 35 42 00 00       	push   $0x4235
    1ac8:	e8 85 1b 00 00       	call   3652 <unlink>
    1acd:	83 c4 10             	add    $0x10,%esp
    1ad0:	89 d8                	mov    %ebx,%eax
    1ad2:	83 ec 0c             	sub    $0xc,%esp
    1ad5:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    1ad9:	c1 f8 06             	sar    $0x6,%eax
    1adc:	57                   	push   %edi
    1add:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    1ae1:	83 c0 30             	add    $0x30,%eax
    1ae4:	88 45 df             	mov    %al,-0x21(%ebp)
    1ae7:	89 d8                	mov    %ebx,%eax
    1ae9:	83 e0 3f             	and    $0x3f,%eax
    1aec:	83 c0 30             	add    $0x30,%eax
    1aef:	88 45 e0             	mov    %al,-0x20(%ebp)
    1af2:	e8 5b 1b 00 00       	call   3652 <unlink>
    1af7:	83 c4 10             	add    $0x10,%esp
    1afa:	85 c0                	test   %eax,%eax
    1afc:	75 35                	jne    1b33 <bigdir+0x103>
    1afe:	83 c3 01             	add    $0x1,%ebx
    1b01:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1b07:	75 c7                	jne    1ad0 <bigdir+0xa0>
    1b09:	83 ec 0c             	sub    $0xc,%esp
    1b0c:	68 77 42 00 00       	push   $0x4277
    1b11:	e8 7a 1e 00 00       	call   3990 <printf>
    1b16:	83 c4 10             	add    $0x10,%esp
    1b19:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b1c:	5b                   	pop    %ebx
    1b1d:	5e                   	pop    %esi
    1b1e:	5f                   	pop    %edi
    1b1f:	5d                   	pop    %ebp
    1b20:	c3                   	ret    
    1b21:	83 ec 0c             	sub    $0xc,%esp
    1b24:	68 4e 42 00 00       	push   $0x424e
    1b29:	e8 62 1e 00 00       	call   3990 <printf>
    1b2e:	e8 cf 1a 00 00       	call   3602 <exit>
    1b33:	83 ec 0c             	sub    $0xc,%esp
    1b36:	68 62 42 00 00       	push   $0x4262
    1b3b:	e8 50 1e 00 00       	call   3990 <printf>
    1b40:	e8 bd 1a 00 00       	call   3602 <exit>
    1b45:	83 ec 0c             	sub    $0xc,%esp
    1b48:	68 38 42 00 00       	push   $0x4238
    1b4d:	e8 3e 1e 00 00       	call   3990 <printf>
    1b52:	e8 ab 1a 00 00       	call   3602 <exit>
    1b57:	89 f6                	mov    %esi,%esi
    1b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001b60 <subdir>:
    1b60:	55                   	push   %ebp
    1b61:	89 e5                	mov    %esp,%ebp
    1b63:	53                   	push   %ebx
    1b64:	83 ec 10             	sub    $0x10,%esp
    1b67:	68 82 42 00 00       	push   $0x4282
    1b6c:	e8 1f 1e 00 00       	call   3990 <printf>
    1b71:	c7 04 24 0b 43 00 00 	movl   $0x430b,(%esp)
    1b78:	e8 d5 1a 00 00       	call   3652 <unlink>
    1b7d:	c7 04 24 a8 43 00 00 	movl   $0x43a8,(%esp)
    1b84:	e8 e1 1a 00 00       	call   366a <mkdir>
    1b89:	83 c4 10             	add    $0x10,%esp
    1b8c:	85 c0                	test   %eax,%eax
    1b8e:	0f 85 9b 05 00 00    	jne    212f <subdir+0x5cf>
    1b94:	83 ec 08             	sub    $0x8,%esp
    1b97:	68 02 02 00 00       	push   $0x202
    1b9c:	68 e1 42 00 00       	push   $0x42e1
    1ba1:	e8 9c 1a 00 00       	call   3642 <open>
    1ba6:	83 c4 10             	add    $0x10,%esp
    1ba9:	85 c0                	test   %eax,%eax
    1bab:	89 c3                	mov    %eax,%ebx
    1bad:	0f 88 6a 05 00 00    	js     211d <subdir+0x5bd>
    1bb3:	83 ec 04             	sub    $0x4,%esp
    1bb6:	6a 02                	push   $0x2
    1bb8:	68 0b 43 00 00       	push   $0x430b
    1bbd:	50                   	push   %eax
    1bbe:	e8 5f 1a 00 00       	call   3622 <write>
    1bc3:	89 1c 24             	mov    %ebx,(%esp)
    1bc6:	e8 5f 1a 00 00       	call   362a <close>
    1bcb:	c7 04 24 a8 43 00 00 	movl   $0x43a8,(%esp)
    1bd2:	e8 7b 1a 00 00       	call   3652 <unlink>
    1bd7:	83 c4 10             	add    $0x10,%esp
    1bda:	85 c0                	test   %eax,%eax
    1bdc:	0f 89 29 05 00 00    	jns    210b <subdir+0x5ab>
    1be2:	83 ec 0c             	sub    $0xc,%esp
    1be5:	68 bc 42 00 00       	push   $0x42bc
    1bea:	e8 7b 1a 00 00       	call   366a <mkdir>
    1bef:	83 c4 10             	add    $0x10,%esp
    1bf2:	85 c0                	test   %eax,%eax
    1bf4:	0f 85 ff 04 00 00    	jne    20f9 <subdir+0x599>
    1bfa:	83 ec 08             	sub    $0x8,%esp
    1bfd:	68 02 02 00 00       	push   $0x202
    1c02:	68 de 42 00 00       	push   $0x42de
    1c07:	e8 36 1a 00 00       	call   3642 <open>
    1c0c:	83 c4 10             	add    $0x10,%esp
    1c0f:	85 c0                	test   %eax,%eax
    1c11:	89 c3                	mov    %eax,%ebx
    1c13:	0f 88 1a 04 00 00    	js     2033 <subdir+0x4d3>
    1c19:	83 ec 04             	sub    $0x4,%esp
    1c1c:	6a 02                	push   $0x2
    1c1e:	68 ff 42 00 00       	push   $0x42ff
    1c23:	50                   	push   %eax
    1c24:	e8 f9 19 00 00       	call   3622 <write>
    1c29:	89 1c 24             	mov    %ebx,(%esp)
    1c2c:	e8 f9 19 00 00       	call   362a <close>
    1c31:	58                   	pop    %eax
    1c32:	5a                   	pop    %edx
    1c33:	6a 00                	push   $0x0
    1c35:	68 02 43 00 00       	push   $0x4302
    1c3a:	e8 03 1a 00 00       	call   3642 <open>
    1c3f:	83 c4 10             	add    $0x10,%esp
    1c42:	85 c0                	test   %eax,%eax
    1c44:	89 c3                	mov    %eax,%ebx
    1c46:	0f 88 d5 03 00 00    	js     2021 <subdir+0x4c1>
    1c4c:	83 ec 04             	sub    $0x4,%esp
    1c4f:	68 00 20 00 00       	push   $0x2000
    1c54:	68 00 84 00 00       	push   $0x8400
    1c59:	50                   	push   %eax
    1c5a:	e8 bb 19 00 00       	call   361a <read>
    1c5f:	83 c4 10             	add    $0x10,%esp
    1c62:	83 f8 02             	cmp    $0x2,%eax
    1c65:	0f 85 38 03 00 00    	jne    1fa3 <subdir+0x443>
    1c6b:	80 3d 00 84 00 00 66 	cmpb   $0x66,0x8400
    1c72:	0f 85 2b 03 00 00    	jne    1fa3 <subdir+0x443>
    1c78:	83 ec 0c             	sub    $0xc,%esp
    1c7b:	53                   	push   %ebx
    1c7c:	e8 a9 19 00 00       	call   362a <close>
    1c81:	59                   	pop    %ecx
    1c82:	5b                   	pop    %ebx
    1c83:	68 42 43 00 00       	push   $0x4342
    1c88:	68 de 42 00 00       	push   $0x42de
    1c8d:	e8 d0 19 00 00       	call   3662 <link>
    1c92:	83 c4 10             	add    $0x10,%esp
    1c95:	85 c0                	test   %eax,%eax
    1c97:	0f 85 ba 03 00 00    	jne    2057 <subdir+0x4f7>
    1c9d:	83 ec 0c             	sub    $0xc,%esp
    1ca0:	68 de 42 00 00       	push   $0x42de
    1ca5:	e8 a8 19 00 00       	call   3652 <unlink>
    1caa:	83 c4 10             	add    $0x10,%esp
    1cad:	85 c0                	test   %eax,%eax
    1caf:	0f 85 12 03 00 00    	jne    1fc7 <subdir+0x467>
    1cb5:	83 ec 08             	sub    $0x8,%esp
    1cb8:	6a 00                	push   $0x0
    1cba:	68 de 42 00 00       	push   $0x42de
    1cbf:	e8 7e 19 00 00       	call   3642 <open>
    1cc4:	83 c4 10             	add    $0x10,%esp
    1cc7:	85 c0                	test   %eax,%eax
    1cc9:	0f 89 18 04 00 00    	jns    20e7 <subdir+0x587>
    1ccf:	83 ec 0c             	sub    $0xc,%esp
    1cd2:	68 a8 43 00 00       	push   $0x43a8
    1cd7:	e8 96 19 00 00       	call   3672 <chdir>
    1cdc:	83 c4 10             	add    $0x10,%esp
    1cdf:	85 c0                	test   %eax,%eax
    1ce1:	0f 85 ee 03 00 00    	jne    20d5 <subdir+0x575>
    1ce7:	83 ec 0c             	sub    $0xc,%esp
    1cea:	68 76 43 00 00       	push   $0x4376
    1cef:	e8 7e 19 00 00       	call   3672 <chdir>
    1cf4:	83 c4 10             	add    $0x10,%esp
    1cf7:	85 c0                	test   %eax,%eax
    1cf9:	0f 85 b6 02 00 00    	jne    1fb5 <subdir+0x455>
    1cff:	83 ec 0c             	sub    $0xc,%esp
    1d02:	68 9c 43 00 00       	push   $0x439c
    1d07:	e8 66 19 00 00       	call   3672 <chdir>
    1d0c:	83 c4 10             	add    $0x10,%esp
    1d0f:	85 c0                	test   %eax,%eax
    1d11:	0f 85 9e 02 00 00    	jne    1fb5 <subdir+0x455>
    1d17:	83 ec 0c             	sub    $0xc,%esp
    1d1a:	68 ab 43 00 00       	push   $0x43ab
    1d1f:	e8 4e 19 00 00       	call   3672 <chdir>
    1d24:	83 c4 10             	add    $0x10,%esp
    1d27:	85 c0                	test   %eax,%eax
    1d29:	0f 85 16 03 00 00    	jne    2045 <subdir+0x4e5>
    1d2f:	83 ec 08             	sub    $0x8,%esp
    1d32:	6a 00                	push   $0x0
    1d34:	68 42 43 00 00       	push   $0x4342
    1d39:	e8 04 19 00 00       	call   3642 <open>
    1d3e:	83 c4 10             	add    $0x10,%esp
    1d41:	85 c0                	test   %eax,%eax
    1d43:	89 c3                	mov    %eax,%ebx
    1d45:	0f 88 bc 04 00 00    	js     2207 <subdir+0x6a7>
    1d4b:	83 ec 04             	sub    $0x4,%esp
    1d4e:	68 00 20 00 00       	push   $0x2000
    1d53:	68 00 84 00 00       	push   $0x8400
    1d58:	50                   	push   %eax
    1d59:	e8 bc 18 00 00       	call   361a <read>
    1d5e:	83 c4 10             	add    $0x10,%esp
    1d61:	83 f8 02             	cmp    $0x2,%eax
    1d64:	0f 85 8b 04 00 00    	jne    21f5 <subdir+0x695>
    1d6a:	83 ec 0c             	sub    $0xc,%esp
    1d6d:	53                   	push   %ebx
    1d6e:	e8 b7 18 00 00       	call   362a <close>
    1d73:	58                   	pop    %eax
    1d74:	5a                   	pop    %edx
    1d75:	6a 00                	push   $0x0
    1d77:	68 de 42 00 00       	push   $0x42de
    1d7c:	e8 c1 18 00 00       	call   3642 <open>
    1d81:	83 c4 10             	add    $0x10,%esp
    1d84:	85 c0                	test   %eax,%eax
    1d86:	0f 89 5f 02 00 00    	jns    1feb <subdir+0x48b>
    1d8c:	83 ec 08             	sub    $0x8,%esp
    1d8f:	68 02 02 00 00       	push   $0x202
    1d94:	68 f6 43 00 00       	push   $0x43f6
    1d99:	e8 a4 18 00 00       	call   3642 <open>
    1d9e:	83 c4 10             	add    $0x10,%esp
    1da1:	85 c0                	test   %eax,%eax
    1da3:	0f 89 30 02 00 00    	jns    1fd9 <subdir+0x479>
    1da9:	83 ec 08             	sub    $0x8,%esp
    1dac:	68 02 02 00 00       	push   $0x202
    1db1:	68 1b 44 00 00       	push   $0x441b
    1db6:	e8 87 18 00 00       	call   3642 <open>
    1dbb:	83 c4 10             	add    $0x10,%esp
    1dbe:	85 c0                	test   %eax,%eax
    1dc0:	0f 89 fd 02 00 00    	jns    20c3 <subdir+0x563>
    1dc6:	83 ec 08             	sub    $0x8,%esp
    1dc9:	68 00 02 00 00       	push   $0x200
    1dce:	68 a8 43 00 00       	push   $0x43a8
    1dd3:	e8 6a 18 00 00       	call   3642 <open>
    1dd8:	83 c4 10             	add    $0x10,%esp
    1ddb:	85 c0                	test   %eax,%eax
    1ddd:	0f 89 ce 02 00 00    	jns    20b1 <subdir+0x551>
    1de3:	83 ec 08             	sub    $0x8,%esp
    1de6:	6a 02                	push   $0x2
    1de8:	68 a8 43 00 00       	push   $0x43a8
    1ded:	e8 50 18 00 00       	call   3642 <open>
    1df2:	83 c4 10             	add    $0x10,%esp
    1df5:	85 c0                	test   %eax,%eax
    1df7:	0f 89 a2 02 00 00    	jns    209f <subdir+0x53f>
    1dfd:	83 ec 08             	sub    $0x8,%esp
    1e00:	6a 01                	push   $0x1
    1e02:	68 a8 43 00 00       	push   $0x43a8
    1e07:	e8 36 18 00 00       	call   3642 <open>
    1e0c:	83 c4 10             	add    $0x10,%esp
    1e0f:	85 c0                	test   %eax,%eax
    1e11:	0f 89 76 02 00 00    	jns    208d <subdir+0x52d>
    1e17:	83 ec 08             	sub    $0x8,%esp
    1e1a:	68 8a 44 00 00       	push   $0x448a
    1e1f:	68 f6 43 00 00       	push   $0x43f6
    1e24:	e8 39 18 00 00       	call   3662 <link>
    1e29:	83 c4 10             	add    $0x10,%esp
    1e2c:	85 c0                	test   %eax,%eax
    1e2e:	0f 84 47 02 00 00    	je     207b <subdir+0x51b>
    1e34:	83 ec 08             	sub    $0x8,%esp
    1e37:	68 8a 44 00 00       	push   $0x448a
    1e3c:	68 1b 44 00 00       	push   $0x441b
    1e41:	e8 1c 18 00 00       	call   3662 <link>
    1e46:	83 c4 10             	add    $0x10,%esp
    1e49:	85 c0                	test   %eax,%eax
    1e4b:	0f 84 18 02 00 00    	je     2069 <subdir+0x509>
    1e51:	83 ec 08             	sub    $0x8,%esp
    1e54:	68 42 43 00 00       	push   $0x4342
    1e59:	68 e1 42 00 00       	push   $0x42e1
    1e5e:	e8 ff 17 00 00       	call   3662 <link>
    1e63:	83 c4 10             	add    $0x10,%esp
    1e66:	85 c0                	test   %eax,%eax
    1e68:	0f 84 a1 01 00 00    	je     200f <subdir+0x4af>
    1e6e:	83 ec 0c             	sub    $0xc,%esp
    1e71:	68 f6 43 00 00       	push   $0x43f6
    1e76:	e8 ef 17 00 00       	call   366a <mkdir>
    1e7b:	83 c4 10             	add    $0x10,%esp
    1e7e:	85 c0                	test   %eax,%eax
    1e80:	0f 84 77 01 00 00    	je     1ffd <subdir+0x49d>
    1e86:	83 ec 0c             	sub    $0xc,%esp
    1e89:	68 1b 44 00 00       	push   $0x441b
    1e8e:	e8 d7 17 00 00       	call   366a <mkdir>
    1e93:	83 c4 10             	add    $0x10,%esp
    1e96:	85 c0                	test   %eax,%eax
    1e98:	0f 84 45 03 00 00    	je     21e3 <subdir+0x683>
    1e9e:	83 ec 0c             	sub    $0xc,%esp
    1ea1:	68 42 43 00 00       	push   $0x4342
    1ea6:	e8 bf 17 00 00       	call   366a <mkdir>
    1eab:	83 c4 10             	add    $0x10,%esp
    1eae:	85 c0                	test   %eax,%eax
    1eb0:	0f 84 1b 03 00 00    	je     21d1 <subdir+0x671>
    1eb6:	83 ec 0c             	sub    $0xc,%esp
    1eb9:	68 1b 44 00 00       	push   $0x441b
    1ebe:	e8 8f 17 00 00       	call   3652 <unlink>
    1ec3:	83 c4 10             	add    $0x10,%esp
    1ec6:	85 c0                	test   %eax,%eax
    1ec8:	0f 84 f1 02 00 00    	je     21bf <subdir+0x65f>
    1ece:	83 ec 0c             	sub    $0xc,%esp
    1ed1:	68 f6 43 00 00       	push   $0x43f6
    1ed6:	e8 77 17 00 00       	call   3652 <unlink>
    1edb:	83 c4 10             	add    $0x10,%esp
    1ede:	85 c0                	test   %eax,%eax
    1ee0:	0f 84 c7 02 00 00    	je     21ad <subdir+0x64d>
    1ee6:	83 ec 0c             	sub    $0xc,%esp
    1ee9:	68 e1 42 00 00       	push   $0x42e1
    1eee:	e8 7f 17 00 00       	call   3672 <chdir>
    1ef3:	83 c4 10             	add    $0x10,%esp
    1ef6:	85 c0                	test   %eax,%eax
    1ef8:	0f 84 9d 02 00 00    	je     219b <subdir+0x63b>
    1efe:	83 ec 0c             	sub    $0xc,%esp
    1f01:	68 8d 44 00 00       	push   $0x448d
    1f06:	e8 67 17 00 00       	call   3672 <chdir>
    1f0b:	83 c4 10             	add    $0x10,%esp
    1f0e:	85 c0                	test   %eax,%eax
    1f10:	0f 84 73 02 00 00    	je     2189 <subdir+0x629>
    1f16:	83 ec 0c             	sub    $0xc,%esp
    1f19:	68 42 43 00 00       	push   $0x4342
    1f1e:	e8 2f 17 00 00       	call   3652 <unlink>
    1f23:	83 c4 10             	add    $0x10,%esp
    1f26:	85 c0                	test   %eax,%eax
    1f28:	0f 85 99 00 00 00    	jne    1fc7 <subdir+0x467>
    1f2e:	83 ec 0c             	sub    $0xc,%esp
    1f31:	68 e1 42 00 00       	push   $0x42e1
    1f36:	e8 17 17 00 00       	call   3652 <unlink>
    1f3b:	83 c4 10             	add    $0x10,%esp
    1f3e:	85 c0                	test   %eax,%eax
    1f40:	0f 85 31 02 00 00    	jne    2177 <subdir+0x617>
    1f46:	83 ec 0c             	sub    $0xc,%esp
    1f49:	68 a8 43 00 00       	push   $0x43a8
    1f4e:	e8 ff 16 00 00       	call   3652 <unlink>
    1f53:	83 c4 10             	add    $0x10,%esp
    1f56:	85 c0                	test   %eax,%eax
    1f58:	0f 84 07 02 00 00    	je     2165 <subdir+0x605>
    1f5e:	83 ec 0c             	sub    $0xc,%esp
    1f61:	68 bd 42 00 00       	push   $0x42bd
    1f66:	e8 e7 16 00 00       	call   3652 <unlink>
    1f6b:	83 c4 10             	add    $0x10,%esp
    1f6e:	85 c0                	test   %eax,%eax
    1f70:	0f 88 dd 01 00 00    	js     2153 <subdir+0x5f3>
    1f76:	83 ec 0c             	sub    $0xc,%esp
    1f79:	68 a8 43 00 00       	push   $0x43a8
    1f7e:	e8 cf 16 00 00       	call   3652 <unlink>
    1f83:	83 c4 10             	add    $0x10,%esp
    1f86:	85 c0                	test   %eax,%eax
    1f88:	0f 88 b3 01 00 00    	js     2141 <subdir+0x5e1>
    1f8e:	83 ec 0c             	sub    $0xc,%esp
    1f91:	68 8a 45 00 00       	push   $0x458a
    1f96:	e8 f5 19 00 00       	call   3990 <printf>
    1f9b:	83 c4 10             	add    $0x10,%esp
    1f9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1fa1:	c9                   	leave  
    1fa2:	c3                   	ret    
    1fa3:	83 ec 0c             	sub    $0xc,%esp
    1fa6:	68 27 43 00 00       	push   $0x4327
    1fab:	e8 e0 19 00 00       	call   3990 <printf>
    1fb0:	e8 4d 16 00 00       	call   3602 <exit>
    1fb5:	83 ec 0c             	sub    $0xc,%esp
    1fb8:	68 82 43 00 00       	push   $0x4382
    1fbd:	e8 ce 19 00 00       	call   3990 <printf>
    1fc2:	e8 3b 16 00 00       	call   3602 <exit>
    1fc7:	83 ec 0c             	sub    $0xc,%esp
    1fca:	68 4d 43 00 00       	push   $0x434d
    1fcf:	e8 bc 19 00 00       	call   3990 <printf>
    1fd4:	e8 29 16 00 00       	call   3602 <exit>
    1fd9:	83 ec 0c             	sub    $0xc,%esp
    1fdc:	68 ff 43 00 00       	push   $0x43ff
    1fe1:	e8 aa 19 00 00       	call   3990 <printf>
    1fe6:	e8 17 16 00 00       	call   3602 <exit>
    1feb:	83 ec 0c             	sub    $0xc,%esp
    1fee:	68 e4 4d 00 00       	push   $0x4de4
    1ff3:	e8 98 19 00 00       	call   3990 <printf>
    1ff8:	e8 05 16 00 00       	call   3602 <exit>
    1ffd:	83 ec 0c             	sub    $0xc,%esp
    2000:	68 93 44 00 00       	push   $0x4493
    2005:	e8 86 19 00 00       	call   3990 <printf>
    200a:	e8 f3 15 00 00       	call   3602 <exit>
    200f:	83 ec 0c             	sub    $0xc,%esp
    2012:	68 54 4e 00 00       	push   $0x4e54
    2017:	e8 74 19 00 00       	call   3990 <printf>
    201c:	e8 e1 15 00 00       	call   3602 <exit>
    2021:	83 ec 0c             	sub    $0xc,%esp
    2024:	68 0e 43 00 00       	push   $0x430e
    2029:	e8 62 19 00 00       	call   3990 <printf>
    202e:	e8 cf 15 00 00       	call   3602 <exit>
    2033:	83 ec 0c             	sub    $0xc,%esp
    2036:	68 e7 42 00 00       	push   $0x42e7
    203b:	e8 50 19 00 00       	call   3990 <printf>
    2040:	e8 bd 15 00 00       	call   3602 <exit>
    2045:	83 ec 0c             	sub    $0xc,%esp
    2048:	68 b0 43 00 00       	push   $0x43b0
    204d:	e8 3e 19 00 00       	call   3990 <printf>
    2052:	e8 ab 15 00 00       	call   3602 <exit>
    2057:	83 ec 0c             	sub    $0xc,%esp
    205a:	68 9c 4d 00 00       	push   $0x4d9c
    205f:	e8 2c 19 00 00       	call   3990 <printf>
    2064:	e8 99 15 00 00       	call   3602 <exit>
    2069:	83 ec 0c             	sub    $0xc,%esp
    206c:	68 30 4e 00 00       	push   $0x4e30
    2071:	e8 1a 19 00 00       	call   3990 <printf>
    2076:	e8 87 15 00 00       	call   3602 <exit>
    207b:	83 ec 0c             	sub    $0xc,%esp
    207e:	68 0c 4e 00 00       	push   $0x4e0c
    2083:	e8 08 19 00 00       	call   3990 <printf>
    2088:	e8 75 15 00 00       	call   3602 <exit>
    208d:	83 ec 0c             	sub    $0xc,%esp
    2090:	68 6f 44 00 00       	push   $0x446f
    2095:	e8 f6 18 00 00       	call   3990 <printf>
    209a:	e8 63 15 00 00       	call   3602 <exit>
    209f:	83 ec 0c             	sub    $0xc,%esp
    20a2:	68 56 44 00 00       	push   $0x4456
    20a7:	e8 e4 18 00 00       	call   3990 <printf>
    20ac:	e8 51 15 00 00       	call   3602 <exit>
    20b1:	83 ec 0c             	sub    $0xc,%esp
    20b4:	68 40 44 00 00       	push   $0x4440
    20b9:	e8 d2 18 00 00       	call   3990 <printf>
    20be:	e8 3f 15 00 00       	call   3602 <exit>
    20c3:	83 ec 0c             	sub    $0xc,%esp
    20c6:	68 24 44 00 00       	push   $0x4424
    20cb:	e8 c0 18 00 00       	call   3990 <printf>
    20d0:	e8 2d 15 00 00       	call   3602 <exit>
    20d5:	83 ec 0c             	sub    $0xc,%esp
    20d8:	68 65 43 00 00       	push   $0x4365
    20dd:	e8 ae 18 00 00       	call   3990 <printf>
    20e2:	e8 1b 15 00 00       	call   3602 <exit>
    20e7:	83 ec 0c             	sub    $0xc,%esp
    20ea:	68 c0 4d 00 00       	push   $0x4dc0
    20ef:	e8 9c 18 00 00       	call   3990 <printf>
    20f4:	e8 09 15 00 00       	call   3602 <exit>
    20f9:	83 ec 0c             	sub    $0xc,%esp
    20fc:	68 c3 42 00 00       	push   $0x42c3
    2101:	e8 8a 18 00 00       	call   3990 <printf>
    2106:	e8 f7 14 00 00       	call   3602 <exit>
    210b:	83 ec 0c             	sub    $0xc,%esp
    210e:	68 74 4d 00 00       	push   $0x4d74
    2113:	e8 78 18 00 00       	call   3990 <printf>
    2118:	e8 e5 14 00 00       	call   3602 <exit>
    211d:	83 ec 0c             	sub    $0xc,%esp
    2120:	68 a7 42 00 00       	push   $0x42a7
    2125:	e8 66 18 00 00       	call   3990 <printf>
    212a:	e8 d3 14 00 00       	call   3602 <exit>
    212f:	83 ec 0c             	sub    $0xc,%esp
    2132:	68 8f 42 00 00       	push   $0x428f
    2137:	e8 54 18 00 00       	call   3990 <printf>
    213c:	e8 c1 14 00 00       	call   3602 <exit>
    2141:	83 ec 0c             	sub    $0xc,%esp
    2144:	68 78 45 00 00       	push   $0x4578
    2149:	e8 42 18 00 00       	call   3990 <printf>
    214e:	e8 af 14 00 00       	call   3602 <exit>
    2153:	83 ec 0c             	sub    $0xc,%esp
    2156:	68 63 45 00 00       	push   $0x4563
    215b:	e8 30 18 00 00       	call   3990 <printf>
    2160:	e8 9d 14 00 00       	call   3602 <exit>
    2165:	83 ec 0c             	sub    $0xc,%esp
    2168:	68 78 4e 00 00       	push   $0x4e78
    216d:	e8 1e 18 00 00       	call   3990 <printf>
    2172:	e8 8b 14 00 00       	call   3602 <exit>
    2177:	83 ec 0c             	sub    $0xc,%esp
    217a:	68 4e 45 00 00       	push   $0x454e
    217f:	e8 0c 18 00 00       	call   3990 <printf>
    2184:	e8 79 14 00 00       	call   3602 <exit>
    2189:	83 ec 0c             	sub    $0xc,%esp
    218c:	68 36 45 00 00       	push   $0x4536
    2191:	e8 fa 17 00 00       	call   3990 <printf>
    2196:	e8 67 14 00 00       	call   3602 <exit>
    219b:	83 ec 0c             	sub    $0xc,%esp
    219e:	68 1e 45 00 00       	push   $0x451e
    21a3:	e8 e8 17 00 00       	call   3990 <printf>
    21a8:	e8 55 14 00 00       	call   3602 <exit>
    21ad:	83 ec 0c             	sub    $0xc,%esp
    21b0:	68 02 45 00 00       	push   $0x4502
    21b5:	e8 d6 17 00 00       	call   3990 <printf>
    21ba:	e8 43 14 00 00       	call   3602 <exit>
    21bf:	83 ec 0c             	sub    $0xc,%esp
    21c2:	68 e6 44 00 00       	push   $0x44e6
    21c7:	e8 c4 17 00 00       	call   3990 <printf>
    21cc:	e8 31 14 00 00       	call   3602 <exit>
    21d1:	83 ec 0c             	sub    $0xc,%esp
    21d4:	68 c9 44 00 00       	push   $0x44c9
    21d9:	e8 b2 17 00 00       	call   3990 <printf>
    21de:	e8 1f 14 00 00       	call   3602 <exit>
    21e3:	83 ec 0c             	sub    $0xc,%esp
    21e6:	68 ae 44 00 00       	push   $0x44ae
    21eb:	e8 a0 17 00 00       	call   3990 <printf>
    21f0:	e8 0d 14 00 00       	call   3602 <exit>
    21f5:	83 ec 0c             	sub    $0xc,%esp
    21f8:	68 db 43 00 00       	push   $0x43db
    21fd:	e8 8e 17 00 00       	call   3990 <printf>
    2202:	e8 fb 13 00 00       	call   3602 <exit>
    2207:	83 ec 0c             	sub    $0xc,%esp
    220a:	68 c3 43 00 00       	push   $0x43c3
    220f:	e8 7c 17 00 00       	call   3990 <printf>
    2214:	e8 e9 13 00 00       	call   3602 <exit>
    2219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00002220 <bigwrite>:
    2220:	55                   	push   %ebp
    2221:	89 e5                	mov    %esp,%ebp
    2223:	56                   	push   %esi
    2224:	53                   	push   %ebx
    2225:	bb f3 01 00 00       	mov    $0x1f3,%ebx
    222a:	83 ec 0c             	sub    $0xc,%esp
    222d:	68 95 45 00 00       	push   $0x4595
    2232:	e8 59 17 00 00       	call   3990 <printf>
    2237:	c7 04 24 a4 45 00 00 	movl   $0x45a4,(%esp)
    223e:	e8 0f 14 00 00       	call   3652 <unlink>
    2243:	83 c4 10             	add    $0x10,%esp
    2246:	8d 76 00             	lea    0x0(%esi),%esi
    2249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    2250:	83 ec 08             	sub    $0x8,%esp
    2253:	68 02 02 00 00       	push   $0x202
    2258:	68 a4 45 00 00       	push   $0x45a4
    225d:	e8 e0 13 00 00       	call   3642 <open>
    2262:	83 c4 10             	add    $0x10,%esp
    2265:	85 c0                	test   %eax,%eax
    2267:	89 c6                	mov    %eax,%esi
    2269:	78 7d                	js     22e8 <bigwrite+0xc8>
    226b:	83 ec 04             	sub    $0x4,%esp
    226e:	53                   	push   %ebx
    226f:	68 00 84 00 00       	push   $0x8400
    2274:	50                   	push   %eax
    2275:	e8 a8 13 00 00       	call   3622 <write>
    227a:	83 c4 10             	add    $0x10,%esp
    227d:	39 d8                	cmp    %ebx,%eax
    227f:	75 53                	jne    22d4 <bigwrite+0xb4>
    2281:	83 ec 04             	sub    $0x4,%esp
    2284:	53                   	push   %ebx
    2285:	68 00 84 00 00       	push   $0x8400
    228a:	56                   	push   %esi
    228b:	e8 92 13 00 00       	call   3622 <write>
    2290:	83 c4 10             	add    $0x10,%esp
    2293:	39 d8                	cmp    %ebx,%eax
    2295:	75 3d                	jne    22d4 <bigwrite+0xb4>
    2297:	83 ec 0c             	sub    $0xc,%esp
    229a:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    22a0:	56                   	push   %esi
    22a1:	e8 84 13 00 00       	call   362a <close>
    22a6:	c7 04 24 a4 45 00 00 	movl   $0x45a4,(%esp)
    22ad:	e8 a0 13 00 00       	call   3652 <unlink>
    22b2:	83 c4 10             	add    $0x10,%esp
    22b5:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    22bb:	75 93                	jne    2250 <bigwrite+0x30>
    22bd:	83 ec 0c             	sub    $0xc,%esp
    22c0:	68 d7 45 00 00       	push   $0x45d7
    22c5:	e8 c6 16 00 00       	call   3990 <printf>
    22ca:	83 c4 10             	add    $0x10,%esp
    22cd:	8d 65 f8             	lea    -0x8(%ebp),%esp
    22d0:	5b                   	pop    %ebx
    22d1:	5e                   	pop    %esi
    22d2:	5d                   	pop    %ebp
    22d3:	c3                   	ret    
    22d4:	83 ec 04             	sub    $0x4,%esp
    22d7:	50                   	push   %eax
    22d8:	53                   	push   %ebx
    22d9:	68 c5 45 00 00       	push   $0x45c5
    22de:	e8 ad 16 00 00       	call   3990 <printf>
    22e3:	e8 1a 13 00 00       	call   3602 <exit>
    22e8:	83 ec 0c             	sub    $0xc,%esp
    22eb:	68 ad 45 00 00       	push   $0x45ad
    22f0:	e8 9b 16 00 00       	call   3990 <printf>
    22f5:	e8 08 13 00 00       	call   3602 <exit>
    22fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00002300 <bigfile>:
    2300:	55                   	push   %ebp
    2301:	89 e5                	mov    %esp,%ebp
    2303:	57                   	push   %edi
    2304:	56                   	push   %esi
    2305:	53                   	push   %ebx
    2306:	83 ec 18             	sub    $0x18,%esp
    2309:	68 e4 45 00 00       	push   $0x45e4
    230e:	e8 7d 16 00 00       	call   3990 <printf>
    2313:	c7 04 24 00 46 00 00 	movl   $0x4600,(%esp)
    231a:	e8 33 13 00 00       	call   3652 <unlink>
    231f:	59                   	pop    %ecx
    2320:	5b                   	pop    %ebx
    2321:	68 02 02 00 00       	push   $0x202
    2326:	68 00 46 00 00       	push   $0x4600
    232b:	e8 12 13 00 00       	call   3642 <open>
    2330:	83 c4 10             	add    $0x10,%esp
    2333:	85 c0                	test   %eax,%eax
    2335:	0f 88 55 01 00 00    	js     2490 <bigfile+0x190>
    233b:	89 c6                	mov    %eax,%esi
    233d:	31 db                	xor    %ebx,%ebx
    233f:	90                   	nop
    2340:	83 ec 04             	sub    $0x4,%esp
    2343:	68 58 02 00 00       	push   $0x258
    2348:	53                   	push   %ebx
    2349:	68 00 84 00 00       	push   $0x8400
    234e:	e8 0d 11 00 00       	call   3460 <memset>
    2353:	83 c4 0c             	add    $0xc,%esp
    2356:	68 58 02 00 00       	push   $0x258
    235b:	68 00 84 00 00       	push   $0x8400
    2360:	56                   	push   %esi
    2361:	e8 bc 12 00 00       	call   3622 <write>
    2366:	83 c4 10             	add    $0x10,%esp
    2369:	3d 58 02 00 00       	cmp    $0x258,%eax
    236e:	0f 85 f8 00 00 00    	jne    246c <bigfile+0x16c>
    2374:	83 c3 01             	add    $0x1,%ebx
    2377:	83 fb 14             	cmp    $0x14,%ebx
    237a:	75 c4                	jne    2340 <bigfile+0x40>
    237c:	83 ec 0c             	sub    $0xc,%esp
    237f:	56                   	push   %esi
    2380:	e8 a5 12 00 00       	call   362a <close>
    2385:	58                   	pop    %eax
    2386:	5a                   	pop    %edx
    2387:	6a 00                	push   $0x0
    2389:	68 00 46 00 00       	push   $0x4600
    238e:	e8 af 12 00 00       	call   3642 <open>
    2393:	83 c4 10             	add    $0x10,%esp
    2396:	85 c0                	test   %eax,%eax
    2398:	89 c6                	mov    %eax,%esi
    239a:	0f 88 de 00 00 00    	js     247e <bigfile+0x17e>
    23a0:	31 db                	xor    %ebx,%ebx
    23a2:	31 ff                	xor    %edi,%edi
    23a4:	eb 38                	jmp    23de <bigfile+0xde>
    23a6:	8d 76 00             	lea    0x0(%esi),%esi
    23a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    23b0:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    23b5:	0f 85 8d 00 00 00    	jne    2448 <bigfile+0x148>
    23bb:	0f be 05 00 84 00 00 	movsbl 0x8400,%eax
    23c2:	89 fa                	mov    %edi,%edx
    23c4:	d1 fa                	sar    %edx
    23c6:	39 d0                	cmp    %edx,%eax
    23c8:	75 6c                	jne    2436 <bigfile+0x136>
    23ca:	0f be 15 2b 85 00 00 	movsbl 0x852b,%edx
    23d1:	39 d0                	cmp    %edx,%eax
    23d3:	75 61                	jne    2436 <bigfile+0x136>
    23d5:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
    23db:	83 c7 01             	add    $0x1,%edi
    23de:	83 ec 04             	sub    $0x4,%esp
    23e1:	68 2c 01 00 00       	push   $0x12c
    23e6:	68 00 84 00 00       	push   $0x8400
    23eb:	56                   	push   %esi
    23ec:	e8 29 12 00 00       	call   361a <read>
    23f1:	83 c4 10             	add    $0x10,%esp
    23f4:	85 c0                	test   %eax,%eax
    23f6:	78 62                	js     245a <bigfile+0x15a>
    23f8:	75 b6                	jne    23b0 <bigfile+0xb0>
    23fa:	83 ec 0c             	sub    $0xc,%esp
    23fd:	56                   	push   %esi
    23fe:	e8 27 12 00 00       	call   362a <close>
    2403:	83 c4 10             	add    $0x10,%esp
    2406:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    240c:	0f 85 90 00 00 00    	jne    24a2 <bigfile+0x1a2>
    2412:	83 ec 0c             	sub    $0xc,%esp
    2415:	68 00 46 00 00       	push   $0x4600
    241a:	e8 33 12 00 00       	call   3652 <unlink>
    241f:	c7 04 24 8f 46 00 00 	movl   $0x468f,(%esp)
    2426:	e8 65 15 00 00       	call   3990 <printf>
    242b:	83 c4 10             	add    $0x10,%esp
    242e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2431:	5b                   	pop    %ebx
    2432:	5e                   	pop    %esi
    2433:	5f                   	pop    %edi
    2434:	5d                   	pop    %ebp
    2435:	c3                   	ret    
    2436:	83 ec 0c             	sub    $0xc,%esp
    2439:	68 5c 46 00 00       	push   $0x465c
    243e:	e8 4d 15 00 00       	call   3990 <printf>
    2443:	e8 ba 11 00 00       	call   3602 <exit>
    2448:	83 ec 0c             	sub    $0xc,%esp
    244b:	68 48 46 00 00       	push   $0x4648
    2450:	e8 3b 15 00 00       	call   3990 <printf>
    2455:	e8 a8 11 00 00       	call   3602 <exit>
    245a:	83 ec 0c             	sub    $0xc,%esp
    245d:	68 33 46 00 00       	push   $0x4633
    2462:	e8 29 15 00 00       	call   3990 <printf>
    2467:	e8 96 11 00 00       	call   3602 <exit>
    246c:	83 ec 0c             	sub    $0xc,%esp
    246f:	68 08 46 00 00       	push   $0x4608
    2474:	e8 17 15 00 00       	call   3990 <printf>
    2479:	e8 84 11 00 00       	call   3602 <exit>
    247e:	83 ec 0c             	sub    $0xc,%esp
    2481:	68 1e 46 00 00       	push   $0x461e
    2486:	e8 05 15 00 00       	call   3990 <printf>
    248b:	e8 72 11 00 00       	call   3602 <exit>
    2490:	83 ec 0c             	sub    $0xc,%esp
    2493:	68 f2 45 00 00       	push   $0x45f2
    2498:	e8 f3 14 00 00       	call   3990 <printf>
    249d:	e8 60 11 00 00       	call   3602 <exit>
    24a2:	83 ec 0c             	sub    $0xc,%esp
    24a5:	68 75 46 00 00       	push   $0x4675
    24aa:	e8 e1 14 00 00       	call   3990 <printf>
    24af:	e8 4e 11 00 00       	call   3602 <exit>
    24b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    24ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000024c0 <fourteen>:
    24c0:	55                   	push   %ebp
    24c1:	89 e5                	mov    %esp,%ebp
    24c3:	83 ec 14             	sub    $0x14,%esp
    24c6:	68 a0 46 00 00       	push   $0x46a0
    24cb:	e8 c0 14 00 00       	call   3990 <printf>
    24d0:	c7 04 24 db 46 00 00 	movl   $0x46db,(%esp)
    24d7:	e8 8e 11 00 00       	call   366a <mkdir>
    24dc:	83 c4 10             	add    $0x10,%esp
    24df:	85 c0                	test   %eax,%eax
    24e1:	0f 85 95 00 00 00    	jne    257c <fourteen+0xbc>
    24e7:	83 ec 0c             	sub    $0xc,%esp
    24ea:	68 98 4e 00 00       	push   $0x4e98
    24ef:	e8 76 11 00 00       	call   366a <mkdir>
    24f4:	83 c4 10             	add    $0x10,%esp
    24f7:	85 c0                	test   %eax,%eax
    24f9:	0f 85 d7 00 00 00    	jne    25d6 <fourteen+0x116>
    24ff:	83 ec 08             	sub    $0x8,%esp
    2502:	68 00 02 00 00       	push   $0x200
    2507:	68 e8 4e 00 00       	push   $0x4ee8
    250c:	e8 31 11 00 00       	call   3642 <open>
    2511:	83 c4 10             	add    $0x10,%esp
    2514:	85 c0                	test   %eax,%eax
    2516:	0f 88 a8 00 00 00    	js     25c4 <fourteen+0x104>
    251c:	83 ec 0c             	sub    $0xc,%esp
    251f:	50                   	push   %eax
    2520:	e8 05 11 00 00       	call   362a <close>
    2525:	58                   	pop    %eax
    2526:	5a                   	pop    %edx
    2527:	6a 00                	push   $0x0
    2529:	68 58 4f 00 00       	push   $0x4f58
    252e:	e8 0f 11 00 00       	call   3642 <open>
    2533:	83 c4 10             	add    $0x10,%esp
    2536:	85 c0                	test   %eax,%eax
    2538:	78 78                	js     25b2 <fourteen+0xf2>
    253a:	83 ec 0c             	sub    $0xc,%esp
    253d:	50                   	push   %eax
    253e:	e8 e7 10 00 00       	call   362a <close>
    2543:	c7 04 24 cc 46 00 00 	movl   $0x46cc,(%esp)
    254a:	e8 1b 11 00 00       	call   366a <mkdir>
    254f:	83 c4 10             	add    $0x10,%esp
    2552:	85 c0                	test   %eax,%eax
    2554:	74 4a                	je     25a0 <fourteen+0xe0>
    2556:	83 ec 0c             	sub    $0xc,%esp
    2559:	68 f4 4f 00 00       	push   $0x4ff4
    255e:	e8 07 11 00 00       	call   366a <mkdir>
    2563:	83 c4 10             	add    $0x10,%esp
    2566:	85 c0                	test   %eax,%eax
    2568:	74 24                	je     258e <fourteen+0xce>
    256a:	83 ec 0c             	sub    $0xc,%esp
    256d:	68 ea 46 00 00       	push   $0x46ea
    2572:	e8 19 14 00 00       	call   3990 <printf>
    2577:	83 c4 10             	add    $0x10,%esp
    257a:	c9                   	leave  
    257b:	c3                   	ret    
    257c:	83 ec 0c             	sub    $0xc,%esp
    257f:	68 af 46 00 00       	push   $0x46af
    2584:	e8 07 14 00 00       	call   3990 <printf>
    2589:	e8 74 10 00 00       	call   3602 <exit>
    258e:	83 ec 0c             	sub    $0xc,%esp
    2591:	68 14 50 00 00       	push   $0x5014
    2596:	e8 f5 13 00 00       	call   3990 <printf>
    259b:	e8 62 10 00 00       	call   3602 <exit>
    25a0:	83 ec 0c             	sub    $0xc,%esp
    25a3:	68 c4 4f 00 00       	push   $0x4fc4
    25a8:	e8 e3 13 00 00       	call   3990 <printf>
    25ad:	e8 50 10 00 00       	call   3602 <exit>
    25b2:	83 ec 0c             	sub    $0xc,%esp
    25b5:	68 88 4f 00 00       	push   $0x4f88
    25ba:	e8 d1 13 00 00       	call   3990 <printf>
    25bf:	e8 3e 10 00 00       	call   3602 <exit>
    25c4:	83 ec 0c             	sub    $0xc,%esp
    25c7:	68 18 4f 00 00       	push   $0x4f18
    25cc:	e8 bf 13 00 00       	call   3990 <printf>
    25d1:	e8 2c 10 00 00       	call   3602 <exit>
    25d6:	83 ec 0c             	sub    $0xc,%esp
    25d9:	68 b8 4e 00 00       	push   $0x4eb8
    25de:	e8 ad 13 00 00       	call   3990 <printf>
    25e3:	e8 1a 10 00 00       	call   3602 <exit>
    25e8:	90                   	nop
    25e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000025f0 <rmdot>:
    25f0:	55                   	push   %ebp
    25f1:	89 e5                	mov    %esp,%ebp
    25f3:	83 ec 14             	sub    $0x14,%esp
    25f6:	68 f7 46 00 00       	push   $0x46f7
    25fb:	e8 90 13 00 00       	call   3990 <printf>
    2600:	c7 04 24 03 47 00 00 	movl   $0x4703,(%esp)
    2607:	e8 5e 10 00 00       	call   366a <mkdir>
    260c:	83 c4 10             	add    $0x10,%esp
    260f:	85 c0                	test   %eax,%eax
    2611:	0f 85 ae 00 00 00    	jne    26c5 <rmdot+0xd5>
    2617:	83 ec 0c             	sub    $0xc,%esp
    261a:	68 03 47 00 00       	push   $0x4703
    261f:	e8 4e 10 00 00       	call   3672 <chdir>
    2624:	83 c4 10             	add    $0x10,%esp
    2627:	85 c0                	test   %eax,%eax
    2629:	0f 85 14 01 00 00    	jne    2743 <rmdot+0x153>
    262f:	83 ec 0c             	sub    $0xc,%esp
    2632:	68 ae 43 00 00       	push   $0x43ae
    2637:	e8 16 10 00 00       	call   3652 <unlink>
    263c:	83 c4 10             	add    $0x10,%esp
    263f:	85 c0                	test   %eax,%eax
    2641:	0f 84 ea 00 00 00    	je     2731 <rmdot+0x141>
    2647:	83 ec 0c             	sub    $0xc,%esp
    264a:	68 ad 43 00 00       	push   $0x43ad
    264f:	e8 fe 0f 00 00       	call   3652 <unlink>
    2654:	83 c4 10             	add    $0x10,%esp
    2657:	85 c0                	test   %eax,%eax
    2659:	0f 84 c0 00 00 00    	je     271f <rmdot+0x12f>
    265f:	83 ec 0c             	sub    $0xc,%esp
    2662:	68 81 3b 00 00       	push   $0x3b81
    2667:	e8 06 10 00 00       	call   3672 <chdir>
    266c:	83 c4 10             	add    $0x10,%esp
    266f:	85 c0                	test   %eax,%eax
    2671:	0f 85 96 00 00 00    	jne    270d <rmdot+0x11d>
    2677:	83 ec 0c             	sub    $0xc,%esp
    267a:	68 4b 47 00 00       	push   $0x474b
    267f:	e8 ce 0f 00 00       	call   3652 <unlink>
    2684:	83 c4 10             	add    $0x10,%esp
    2687:	85 c0                	test   %eax,%eax
    2689:	74 70                	je     26fb <rmdot+0x10b>
    268b:	83 ec 0c             	sub    $0xc,%esp
    268e:	68 69 47 00 00       	push   $0x4769
    2693:	e8 ba 0f 00 00       	call   3652 <unlink>
    2698:	83 c4 10             	add    $0x10,%esp
    269b:	85 c0                	test   %eax,%eax
    269d:	74 4a                	je     26e9 <rmdot+0xf9>
    269f:	83 ec 0c             	sub    $0xc,%esp
    26a2:	68 03 47 00 00       	push   $0x4703
    26a7:	e8 a6 0f 00 00       	call   3652 <unlink>
    26ac:	83 c4 10             	add    $0x10,%esp
    26af:	85 c0                	test   %eax,%eax
    26b1:	75 24                	jne    26d7 <rmdot+0xe7>
    26b3:	83 ec 0c             	sub    $0xc,%esp
    26b6:	68 9e 47 00 00       	push   $0x479e
    26bb:	e8 d0 12 00 00       	call   3990 <printf>
    26c0:	83 c4 10             	add    $0x10,%esp
    26c3:	c9                   	leave  
    26c4:	c3                   	ret    
    26c5:	83 ec 0c             	sub    $0xc,%esp
    26c8:	68 08 47 00 00       	push   $0x4708
    26cd:	e8 be 12 00 00       	call   3990 <printf>
    26d2:	e8 2b 0f 00 00       	call   3602 <exit>
    26d7:	83 ec 0c             	sub    $0xc,%esp
    26da:	68 89 47 00 00       	push   $0x4789
    26df:	e8 ac 12 00 00       	call   3990 <printf>
    26e4:	e8 19 0f 00 00       	call   3602 <exit>
    26e9:	83 ec 0c             	sub    $0xc,%esp
    26ec:	68 71 47 00 00       	push   $0x4771
    26f1:	e8 9a 12 00 00       	call   3990 <printf>
    26f6:	e8 07 0f 00 00       	call   3602 <exit>
    26fb:	83 ec 0c             	sub    $0xc,%esp
    26fe:	68 52 47 00 00       	push   $0x4752
    2703:	e8 88 12 00 00       	call   3990 <printf>
    2708:	e8 f5 0e 00 00       	call   3602 <exit>
    270d:	83 ec 0c             	sub    $0xc,%esp
    2710:	68 83 3b 00 00       	push   $0x3b83
    2715:	e8 76 12 00 00       	call   3990 <printf>
    271a:	e8 e3 0e 00 00       	call   3602 <exit>
    271f:	83 ec 0c             	sub    $0xc,%esp
    2722:	68 3c 47 00 00       	push   $0x473c
    2727:	e8 64 12 00 00       	call   3990 <printf>
    272c:	e8 d1 0e 00 00       	call   3602 <exit>
    2731:	83 ec 0c             	sub    $0xc,%esp
    2734:	68 2e 47 00 00       	push   $0x472e
    2739:	e8 52 12 00 00       	call   3990 <printf>
    273e:	e8 bf 0e 00 00       	call   3602 <exit>
    2743:	83 ec 0c             	sub    $0xc,%esp
    2746:	68 1b 47 00 00       	push   $0x471b
    274b:	e8 40 12 00 00       	call   3990 <printf>
    2750:	e8 ad 0e 00 00       	call   3602 <exit>
    2755:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002760 <dirfile>:
    2760:	55                   	push   %ebp
    2761:	89 e5                	mov    %esp,%ebp
    2763:	53                   	push   %ebx
    2764:	83 ec 10             	sub    $0x10,%esp
    2767:	68 a8 47 00 00       	push   $0x47a8
    276c:	e8 1f 12 00 00       	call   3990 <printf>
    2771:	58                   	pop    %eax
    2772:	5a                   	pop    %edx
    2773:	68 00 02 00 00       	push   $0x200
    2778:	68 b5 47 00 00       	push   $0x47b5
    277d:	e8 c0 0e 00 00       	call   3642 <open>
    2782:	83 c4 10             	add    $0x10,%esp
    2785:	85 c0                	test   %eax,%eax
    2787:	0f 88 3f 01 00 00    	js     28cc <dirfile+0x16c>
    278d:	83 ec 0c             	sub    $0xc,%esp
    2790:	50                   	push   %eax
    2791:	e8 94 0e 00 00       	call   362a <close>
    2796:	c7 04 24 b5 47 00 00 	movl   $0x47b5,(%esp)
    279d:	e8 d0 0e 00 00       	call   3672 <chdir>
    27a2:	83 c4 10             	add    $0x10,%esp
    27a5:	85 c0                	test   %eax,%eax
    27a7:	0f 84 0d 01 00 00    	je     28ba <dirfile+0x15a>
    27ad:	83 ec 08             	sub    $0x8,%esp
    27b0:	6a 00                	push   $0x0
    27b2:	68 ee 47 00 00       	push   $0x47ee
    27b7:	e8 86 0e 00 00       	call   3642 <open>
    27bc:	83 c4 10             	add    $0x10,%esp
    27bf:	85 c0                	test   %eax,%eax
    27c1:	0f 89 e1 00 00 00    	jns    28a8 <dirfile+0x148>
    27c7:	83 ec 08             	sub    $0x8,%esp
    27ca:	68 00 02 00 00       	push   $0x200
    27cf:	68 ee 47 00 00       	push   $0x47ee
    27d4:	e8 69 0e 00 00       	call   3642 <open>
    27d9:	83 c4 10             	add    $0x10,%esp
    27dc:	85 c0                	test   %eax,%eax
    27de:	0f 89 c4 00 00 00    	jns    28a8 <dirfile+0x148>
    27e4:	83 ec 0c             	sub    $0xc,%esp
    27e7:	68 ee 47 00 00       	push   $0x47ee
    27ec:	e8 79 0e 00 00       	call   366a <mkdir>
    27f1:	83 c4 10             	add    $0x10,%esp
    27f4:	85 c0                	test   %eax,%eax
    27f6:	0f 84 3c 01 00 00    	je     2938 <dirfile+0x1d8>
    27fc:	83 ec 0c             	sub    $0xc,%esp
    27ff:	68 ee 47 00 00       	push   $0x47ee
    2804:	e8 49 0e 00 00       	call   3652 <unlink>
    2809:	83 c4 10             	add    $0x10,%esp
    280c:	85 c0                	test   %eax,%eax
    280e:	0f 84 12 01 00 00    	je     2926 <dirfile+0x1c6>
    2814:	83 ec 08             	sub    $0x8,%esp
    2817:	68 ee 47 00 00       	push   $0x47ee
    281c:	68 52 48 00 00       	push   $0x4852
    2821:	e8 3c 0e 00 00       	call   3662 <link>
    2826:	83 c4 10             	add    $0x10,%esp
    2829:	85 c0                	test   %eax,%eax
    282b:	0f 84 e3 00 00 00    	je     2914 <dirfile+0x1b4>
    2831:	83 ec 0c             	sub    $0xc,%esp
    2834:	68 b5 47 00 00       	push   $0x47b5
    2839:	e8 14 0e 00 00       	call   3652 <unlink>
    283e:	83 c4 10             	add    $0x10,%esp
    2841:	85 c0                	test   %eax,%eax
    2843:	0f 85 b9 00 00 00    	jne    2902 <dirfile+0x1a2>
    2849:	83 ec 08             	sub    $0x8,%esp
    284c:	6a 02                	push   $0x2
    284e:	68 ae 43 00 00       	push   $0x43ae
    2853:	e8 ea 0d 00 00       	call   3642 <open>
    2858:	83 c4 10             	add    $0x10,%esp
    285b:	85 c0                	test   %eax,%eax
    285d:	0f 89 8d 00 00 00    	jns    28f0 <dirfile+0x190>
    2863:	83 ec 08             	sub    $0x8,%esp
    2866:	6a 00                	push   $0x0
    2868:	68 ae 43 00 00       	push   $0x43ae
    286d:	e8 d0 0d 00 00       	call   3642 <open>
    2872:	83 c4 0c             	add    $0xc,%esp
    2875:	89 c3                	mov    %eax,%ebx
    2877:	6a 01                	push   $0x1
    2879:	68 91 44 00 00       	push   $0x4491
    287e:	50                   	push   %eax
    287f:	e8 9e 0d 00 00       	call   3622 <write>
    2884:	83 c4 10             	add    $0x10,%esp
    2887:	85 c0                	test   %eax,%eax
    2889:	7f 53                	jg     28de <dirfile+0x17e>
    288b:	83 ec 0c             	sub    $0xc,%esp
    288e:	53                   	push   %ebx
    288f:	e8 96 0d 00 00       	call   362a <close>
    2894:	c7 04 24 85 48 00 00 	movl   $0x4885,(%esp)
    289b:	e8 f0 10 00 00       	call   3990 <printf>
    28a0:	83 c4 10             	add    $0x10,%esp
    28a3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    28a6:	c9                   	leave  
    28a7:	c3                   	ret    
    28a8:	83 ec 0c             	sub    $0xc,%esp
    28ab:	68 f9 47 00 00       	push   $0x47f9
    28b0:	e8 db 10 00 00       	call   3990 <printf>
    28b5:	e8 48 0d 00 00       	call   3602 <exit>
    28ba:	83 ec 0c             	sub    $0xc,%esp
    28bd:	68 d4 47 00 00       	push   $0x47d4
    28c2:	e8 c9 10 00 00       	call   3990 <printf>
    28c7:	e8 36 0d 00 00       	call   3602 <exit>
    28cc:	83 ec 0c             	sub    $0xc,%esp
    28cf:	68 bd 47 00 00       	push   $0x47bd
    28d4:	e8 b7 10 00 00       	call   3990 <printf>
    28d9:	e8 24 0d 00 00       	call   3602 <exit>
    28de:	83 ec 0c             	sub    $0xc,%esp
    28e1:	68 71 48 00 00       	push   $0x4871
    28e6:	e8 a5 10 00 00       	call   3990 <printf>
    28eb:	e8 12 0d 00 00       	call   3602 <exit>
    28f0:	83 ec 0c             	sub    $0xc,%esp
    28f3:	68 68 50 00 00       	push   $0x5068
    28f8:	e8 93 10 00 00       	call   3990 <printf>
    28fd:	e8 00 0d 00 00       	call   3602 <exit>
    2902:	83 ec 0c             	sub    $0xc,%esp
    2905:	68 59 48 00 00       	push   $0x4859
    290a:	e8 81 10 00 00       	call   3990 <printf>
    290f:	e8 ee 0c 00 00       	call   3602 <exit>
    2914:	83 ec 0c             	sub    $0xc,%esp
    2917:	68 48 50 00 00       	push   $0x5048
    291c:	e8 6f 10 00 00       	call   3990 <printf>
    2921:	e8 dc 0c 00 00       	call   3602 <exit>
    2926:	83 ec 0c             	sub    $0xc,%esp
    2929:	68 34 48 00 00       	push   $0x4834
    292e:	e8 5d 10 00 00       	call   3990 <printf>
    2933:	e8 ca 0c 00 00       	call   3602 <exit>
    2938:	83 ec 0c             	sub    $0xc,%esp
    293b:	68 17 48 00 00       	push   $0x4817
    2940:	e8 4b 10 00 00       	call   3990 <printf>
    2945:	e8 b8 0c 00 00       	call   3602 <exit>
    294a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00002950 <iref>:
    2950:	55                   	push   %ebp
    2951:	89 e5                	mov    %esp,%ebp
    2953:	53                   	push   %ebx
    2954:	bb 33 00 00 00       	mov    $0x33,%ebx
    2959:	83 ec 10             	sub    $0x10,%esp
    295c:	68 95 48 00 00       	push   $0x4895
    2961:	e8 2a 10 00 00       	call   3990 <printf>
    2966:	83 c4 10             	add    $0x10,%esp
    2969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2970:	83 ec 0c             	sub    $0xc,%esp
    2973:	68 a6 48 00 00       	push   $0x48a6
    2978:	e8 ed 0c 00 00       	call   366a <mkdir>
    297d:	83 c4 10             	add    $0x10,%esp
    2980:	85 c0                	test   %eax,%eax
    2982:	0f 85 b9 00 00 00    	jne    2a41 <iref+0xf1>
    2988:	83 ec 0c             	sub    $0xc,%esp
    298b:	68 a6 48 00 00       	push   $0x48a6
    2990:	e8 dd 0c 00 00       	call   3672 <chdir>
    2995:	83 c4 10             	add    $0x10,%esp
    2998:	85 c0                	test   %eax,%eax
    299a:	0f 85 b3 00 00 00    	jne    2a53 <iref+0x103>
    29a0:	83 ec 0c             	sub    $0xc,%esp
    29a3:	68 5b 3f 00 00       	push   $0x3f5b
    29a8:	e8 bd 0c 00 00       	call   366a <mkdir>
    29ad:	58                   	pop    %eax
    29ae:	5a                   	pop    %edx
    29af:	68 5b 3f 00 00       	push   $0x3f5b
    29b4:	68 52 48 00 00       	push   $0x4852
    29b9:	e8 a4 0c 00 00       	call   3662 <link>
    29be:	59                   	pop    %ecx
    29bf:	58                   	pop    %eax
    29c0:	68 00 02 00 00       	push   $0x200
    29c5:	68 5b 3f 00 00       	push   $0x3f5b
    29ca:	e8 73 0c 00 00       	call   3642 <open>
    29cf:	83 c4 10             	add    $0x10,%esp
    29d2:	85 c0                	test   %eax,%eax
    29d4:	78 0c                	js     29e2 <iref+0x92>
    29d6:	83 ec 0c             	sub    $0xc,%esp
    29d9:	50                   	push   %eax
    29da:	e8 4b 0c 00 00       	call   362a <close>
    29df:	83 c4 10             	add    $0x10,%esp
    29e2:	83 ec 08             	sub    $0x8,%esp
    29e5:	68 00 02 00 00       	push   $0x200
    29ea:	68 90 44 00 00       	push   $0x4490
    29ef:	e8 4e 0c 00 00       	call   3642 <open>
    29f4:	83 c4 10             	add    $0x10,%esp
    29f7:	85 c0                	test   %eax,%eax
    29f9:	78 0c                	js     2a07 <iref+0xb7>
    29fb:	83 ec 0c             	sub    $0xc,%esp
    29fe:	50                   	push   %eax
    29ff:	e8 26 0c 00 00       	call   362a <close>
    2a04:	83 c4 10             	add    $0x10,%esp
    2a07:	83 ec 0c             	sub    $0xc,%esp
    2a0a:	68 90 44 00 00       	push   $0x4490
    2a0f:	e8 3e 0c 00 00       	call   3652 <unlink>
    2a14:	83 c4 10             	add    $0x10,%esp
    2a17:	83 eb 01             	sub    $0x1,%ebx
    2a1a:	0f 85 50 ff ff ff    	jne    2970 <iref+0x20>
    2a20:	83 ec 0c             	sub    $0xc,%esp
    2a23:	68 81 3b 00 00       	push   $0x3b81
    2a28:	e8 45 0c 00 00       	call   3672 <chdir>
    2a2d:	c7 04 24 d4 48 00 00 	movl   $0x48d4,(%esp)
    2a34:	e8 57 0f 00 00       	call   3990 <printf>
    2a39:	83 c4 10             	add    $0x10,%esp
    2a3c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2a3f:	c9                   	leave  
    2a40:	c3                   	ret    
    2a41:	83 ec 0c             	sub    $0xc,%esp
    2a44:	68 ac 48 00 00       	push   $0x48ac
    2a49:	e8 42 0f 00 00       	call   3990 <printf>
    2a4e:	e8 af 0b 00 00       	call   3602 <exit>
    2a53:	83 ec 0c             	sub    $0xc,%esp
    2a56:	68 c0 48 00 00       	push   $0x48c0
    2a5b:	e8 30 0f 00 00       	call   3990 <printf>
    2a60:	e8 9d 0b 00 00       	call   3602 <exit>
    2a65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002a70 <forktest>:
    2a70:	55                   	push   %ebp
    2a71:	89 e5                	mov    %esp,%ebp
    2a73:	53                   	push   %ebx
    2a74:	31 db                	xor    %ebx,%ebx
    2a76:	83 ec 10             	sub    $0x10,%esp
    2a79:	68 e8 48 00 00       	push   $0x48e8
    2a7e:	e8 0d 0f 00 00       	call   3990 <printf>
    2a83:	83 c4 10             	add    $0x10,%esp
    2a86:	eb 15                	jmp    2a9d <forktest+0x2d>
    2a88:	90                   	nop
    2a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2a90:	74 60                	je     2af2 <forktest+0x82>
    2a92:	83 c3 01             	add    $0x1,%ebx
    2a95:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2a9b:	74 43                	je     2ae0 <forktest+0x70>
    2a9d:	e8 58 0b 00 00       	call   35fa <fork>
    2aa2:	85 c0                	test   %eax,%eax
    2aa4:	79 ea                	jns    2a90 <forktest+0x20>
    2aa6:	85 db                	test   %ebx,%ebx
    2aa8:	74 14                	je     2abe <forktest+0x4e>
    2aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2ab0:	e8 55 0b 00 00       	call   360a <wait>
    2ab5:	85 c0                	test   %eax,%eax
    2ab7:	78 3e                	js     2af7 <forktest+0x87>
    2ab9:	83 eb 01             	sub    $0x1,%ebx
    2abc:	75 f2                	jne    2ab0 <forktest+0x40>
    2abe:	e8 47 0b 00 00       	call   360a <wait>
    2ac3:	83 f8 ff             	cmp    $0xffffffff,%eax
    2ac6:	75 41                	jne    2b09 <forktest+0x99>
    2ac8:	83 ec 0c             	sub    $0xc,%esp
    2acb:	68 1a 49 00 00       	push   $0x491a
    2ad0:	e8 bb 0e 00 00       	call   3990 <printf>
    2ad5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2ad8:	c9                   	leave  
    2ad9:	c3                   	ret    
    2ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2ae0:	83 ec 0c             	sub    $0xc,%esp
    2ae3:	68 88 50 00 00       	push   $0x5088
    2ae8:	e8 a3 0e 00 00       	call   3990 <printf>
    2aed:	e8 10 0b 00 00       	call   3602 <exit>
    2af2:	e8 0b 0b 00 00       	call   3602 <exit>
    2af7:	83 ec 0c             	sub    $0xc,%esp
    2afa:	68 f3 48 00 00       	push   $0x48f3
    2aff:	e8 8c 0e 00 00       	call   3990 <printf>
    2b04:	e8 f9 0a 00 00       	call   3602 <exit>
    2b09:	83 ec 0c             	sub    $0xc,%esp
    2b0c:	68 07 49 00 00       	push   $0x4907
    2b11:	e8 7a 0e 00 00       	call   3990 <printf>
    2b16:	e8 e7 0a 00 00       	call   3602 <exit>
    2b1b:	90                   	nop
    2b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00002b20 <sbrktest>:
    2b20:	55                   	push   %ebp
    2b21:	89 e5                	mov    %esp,%ebp
    2b23:	57                   	push   %edi
    2b24:	56                   	push   %esi
    2b25:	53                   	push   %ebx
    2b26:	31 ff                	xor    %edi,%edi
    2b28:	83 ec 68             	sub    $0x68,%esp
    2b2b:	68 28 49 00 00       	push   $0x4928
    2b30:	e8 5b 0e 00 00       	call   3990 <printf>
    2b35:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b3c:	e8 49 0b 00 00       	call   368a <sbrk>
    2b41:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b48:	89 c3                	mov    %eax,%ebx
    2b4a:	e8 3b 0b 00 00       	call   368a <sbrk>
    2b4f:	83 c4 10             	add    $0x10,%esp
    2b52:	89 c6                	mov    %eax,%esi
    2b54:	eb 0c                	jmp    2b62 <sbrktest+0x42>
    2b56:	8d 76 00             	lea    0x0(%esi),%esi
    2b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    2b60:	89 c6                	mov    %eax,%esi
    2b62:	83 ec 0c             	sub    $0xc,%esp
    2b65:	6a 01                	push   $0x1
    2b67:	e8 1e 0b 00 00       	call   368a <sbrk>
    2b6c:	83 c4 10             	add    $0x10,%esp
    2b6f:	39 f0                	cmp    %esi,%eax
    2b71:	0f 85 5c 02 00 00    	jne    2dd3 <sbrktest+0x2b3>
    2b77:	83 c7 01             	add    $0x1,%edi
    2b7a:	c6 06 01             	movb   $0x1,(%esi)
    2b7d:	8d 46 01             	lea    0x1(%esi),%eax
    2b80:	81 ff 88 13 00 00    	cmp    $0x1388,%edi
    2b86:	75 d8                	jne    2b60 <sbrktest+0x40>
    2b88:	e8 6d 0a 00 00       	call   35fa <fork>
    2b8d:	85 c0                	test   %eax,%eax
    2b8f:	89 c7                	mov    %eax,%edi
    2b91:	0f 88 3d 03 00 00    	js     2ed4 <sbrktest+0x3b4>
    2b97:	83 ec 0c             	sub    $0xc,%esp
    2b9a:	83 c6 02             	add    $0x2,%esi
    2b9d:	6a 01                	push   $0x1
    2b9f:	e8 e6 0a 00 00       	call   368a <sbrk>
    2ba4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2bab:	e8 da 0a 00 00       	call   368a <sbrk>
    2bb0:	83 c4 10             	add    $0x10,%esp
    2bb3:	39 f0                	cmp    %esi,%eax
    2bb5:	0f 85 07 03 00 00    	jne    2ec2 <sbrktest+0x3a2>
    2bbb:	85 ff                	test   %edi,%edi
    2bbd:	0f 84 fa 02 00 00    	je     2ebd <sbrktest+0x39d>
    2bc3:	e8 42 0a 00 00       	call   360a <wait>
    2bc8:	83 ec 0c             	sub    $0xc,%esp
    2bcb:	6a 00                	push   $0x0
    2bcd:	e8 b8 0a 00 00       	call   368a <sbrk>
    2bd2:	89 c6                	mov    %eax,%esi
    2bd4:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2bd9:	29 f0                	sub    %esi,%eax
    2bdb:	89 04 24             	mov    %eax,(%esp)
    2bde:	e8 a7 0a 00 00       	call   368a <sbrk>
    2be3:	83 c4 10             	add    $0x10,%esp
    2be6:	39 c6                	cmp    %eax,%esi
    2be8:	0f 85 bd 02 00 00    	jne    2eab <sbrktest+0x38b>
    2bee:	83 ec 0c             	sub    $0xc,%esp
    2bf1:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff
    2bf8:	6a 00                	push   $0x0
    2bfa:	e8 8b 0a 00 00       	call   368a <sbrk>
    2bff:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    2c06:	89 c6                	mov    %eax,%esi
    2c08:	e8 7d 0a 00 00       	call   368a <sbrk>
    2c0d:	83 c4 10             	add    $0x10,%esp
    2c10:	83 f8 ff             	cmp    $0xffffffff,%eax
    2c13:	0f 84 80 02 00 00    	je     2e99 <sbrktest+0x379>
    2c19:	83 ec 0c             	sub    $0xc,%esp
    2c1c:	6a 00                	push   $0x0
    2c1e:	e8 67 0a 00 00       	call   368a <sbrk>
    2c23:	8d 96 00 f0 ff ff    	lea    -0x1000(%esi),%edx
    2c29:	83 c4 10             	add    $0x10,%esp
    2c2c:	39 d0                	cmp    %edx,%eax
    2c2e:	0f 85 53 02 00 00    	jne    2e87 <sbrktest+0x367>
    2c34:	83 ec 0c             	sub    $0xc,%esp
    2c37:	6a 00                	push   $0x0
    2c39:	e8 4c 0a 00 00       	call   368a <sbrk>
    2c3e:	89 c6                	mov    %eax,%esi
    2c40:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2c47:	e8 3e 0a 00 00       	call   368a <sbrk>
    2c4c:	83 c4 10             	add    $0x10,%esp
    2c4f:	39 c6                	cmp    %eax,%esi
    2c51:	89 c7                	mov    %eax,%edi
    2c53:	0f 85 1c 02 00 00    	jne    2e75 <sbrktest+0x355>
    2c59:	83 ec 0c             	sub    $0xc,%esp
    2c5c:	6a 00                	push   $0x0
    2c5e:	e8 27 0a 00 00       	call   368a <sbrk>
    2c63:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    2c69:	83 c4 10             	add    $0x10,%esp
    2c6c:	39 d0                	cmp    %edx,%eax
    2c6e:	0f 85 01 02 00 00    	jne    2e75 <sbrktest+0x355>
    2c74:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2c7b:	0f 84 e2 01 00 00    	je     2e63 <sbrktest+0x343>
    2c81:	83 ec 0c             	sub    $0xc,%esp
    2c84:	6a 00                	push   $0x0
    2c86:	e8 ff 09 00 00       	call   368a <sbrk>
    2c8b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2c92:	89 c6                	mov    %eax,%esi
    2c94:	e8 f1 09 00 00       	call   368a <sbrk>
    2c99:	89 d9                	mov    %ebx,%ecx
    2c9b:	29 c1                	sub    %eax,%ecx
    2c9d:	89 0c 24             	mov    %ecx,(%esp)
    2ca0:	e8 e5 09 00 00       	call   368a <sbrk>
    2ca5:	83 c4 10             	add    $0x10,%esp
    2ca8:	39 c6                	cmp    %eax,%esi
    2caa:	0f 85 a1 01 00 00    	jne    2e51 <sbrktest+0x331>
    2cb0:	be 00 00 00 80       	mov    $0x80000000,%esi
    2cb5:	e8 c8 09 00 00       	call   3682 <getpid>
    2cba:	89 c7                	mov    %eax,%edi
    2cbc:	e8 39 09 00 00       	call   35fa <fork>
    2cc1:	85 c0                	test   %eax,%eax
    2cc3:	0f 88 76 01 00 00    	js     2e3f <sbrktest+0x31f>
    2cc9:	0f 84 53 01 00 00    	je     2e22 <sbrktest+0x302>
    2ccf:	81 c6 50 c3 00 00    	add    $0xc350,%esi
    2cd5:	e8 30 09 00 00       	call   360a <wait>
    2cda:	81 fe 80 84 1e 80    	cmp    $0x801e8480,%esi
    2ce0:	75 d3                	jne    2cb5 <sbrktest+0x195>
    2ce2:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2ce5:	83 ec 0c             	sub    $0xc,%esp
    2ce8:	50                   	push   %eax
    2ce9:	e8 24 09 00 00       	call   3612 <pipe>
    2cee:	83 c4 10             	add    $0x10,%esp
    2cf1:	85 c0                	test   %eax,%eax
    2cf3:	0f 85 17 01 00 00    	jne    2e10 <sbrktest+0x2f0>
    2cf9:	8d 7d c0             	lea    -0x40(%ebp),%edi
    2cfc:	89 fe                	mov    %edi,%esi
    2cfe:	eb 23                	jmp    2d23 <sbrktest+0x203>
    2d00:	83 f8 ff             	cmp    $0xffffffff,%eax
    2d03:	74 14                	je     2d19 <sbrktest+0x1f9>
    2d05:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2d08:	83 ec 04             	sub    $0x4,%esp
    2d0b:	6a 01                	push   $0x1
    2d0d:	50                   	push   %eax
    2d0e:	ff 75 b8             	pushl  -0x48(%ebp)
    2d11:	e8 04 09 00 00       	call   361a <read>
    2d16:	83 c4 10             	add    $0x10,%esp
    2d19:	8d 45 e8             	lea    -0x18(%ebp),%eax
    2d1c:	83 c6 04             	add    $0x4,%esi
    2d1f:	39 c6                	cmp    %eax,%esi
    2d21:	74 4f                	je     2d72 <sbrktest+0x252>
    2d23:	e8 d2 08 00 00       	call   35fa <fork>
    2d28:	85 c0                	test   %eax,%eax
    2d2a:	89 06                	mov    %eax,(%esi)
    2d2c:	75 d2                	jne    2d00 <sbrktest+0x1e0>
    2d2e:	83 ec 0c             	sub    $0xc,%esp
    2d31:	6a 00                	push   $0x0
    2d33:	e8 52 09 00 00       	call   368a <sbrk>
    2d38:	ba 00 00 40 06       	mov    $0x6400000,%edx
    2d3d:	29 c2                	sub    %eax,%edx
    2d3f:	89 14 24             	mov    %edx,(%esp)
    2d42:	e8 43 09 00 00       	call   368a <sbrk>
    2d47:	83 c4 0c             	add    $0xc,%esp
    2d4a:	6a 01                	push   $0x1
    2d4c:	68 91 44 00 00       	push   $0x4491
    2d51:	ff 75 bc             	pushl  -0x44(%ebp)
    2d54:	e8 c9 08 00 00       	call   3622 <write>
    2d59:	83 c4 10             	add    $0x10,%esp
    2d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2d60:	83 ec 0c             	sub    $0xc,%esp
    2d63:	68 e8 03 00 00       	push   $0x3e8
    2d68:	e8 25 09 00 00       	call   3692 <sleep>
    2d6d:	83 c4 10             	add    $0x10,%esp
    2d70:	eb ee                	jmp    2d60 <sbrktest+0x240>
    2d72:	83 ec 0c             	sub    $0xc,%esp
    2d75:	68 00 10 00 00       	push   $0x1000
    2d7a:	e8 0b 09 00 00       	call   368a <sbrk>
    2d7f:	83 c4 10             	add    $0x10,%esp
    2d82:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    2d85:	8b 07                	mov    (%edi),%eax
    2d87:	83 f8 ff             	cmp    $0xffffffff,%eax
    2d8a:	74 11                	je     2d9d <sbrktest+0x27d>
    2d8c:	83 ec 0c             	sub    $0xc,%esp
    2d8f:	50                   	push   %eax
    2d90:	e8 9d 08 00 00       	call   3632 <kill>
    2d95:	e8 70 08 00 00       	call   360a <wait>
    2d9a:	83 c4 10             	add    $0x10,%esp
    2d9d:	83 c7 04             	add    $0x4,%edi
    2da0:	39 fe                	cmp    %edi,%esi
    2da2:	75 e1                	jne    2d85 <sbrktest+0x265>
    2da4:	83 7d a4 ff          	cmpl   $0xffffffff,-0x5c(%ebp)
    2da8:	74 54                	je     2dfe <sbrktest+0x2de>
    2daa:	83 ec 0c             	sub    $0xc,%esp
    2dad:	6a 00                	push   $0x0
    2daf:	e8 d6 08 00 00       	call   368a <sbrk>
    2db4:	83 c4 10             	add    $0x10,%esp
    2db7:	39 d8                	cmp    %ebx,%eax
    2db9:	77 2a                	ja     2de5 <sbrktest+0x2c5>
    2dbb:	83 ec 0c             	sub    $0xc,%esp
    2dbe:	68 d0 49 00 00       	push   $0x49d0
    2dc3:	e8 c8 0b 00 00       	call   3990 <printf>
    2dc8:	83 c4 10             	add    $0x10,%esp
    2dcb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2dce:	5b                   	pop    %ebx
    2dcf:	5e                   	pop    %esi
    2dd0:	5f                   	pop    %edi
    2dd1:	5d                   	pop    %ebp
    2dd2:	c3                   	ret    
    2dd3:	50                   	push   %eax
    2dd4:	56                   	push   %esi
    2dd5:	57                   	push   %edi
    2dd6:	68 33 49 00 00       	push   $0x4933
    2ddb:	e8 b0 0b 00 00       	call   3990 <printf>
    2de0:	e8 1d 08 00 00       	call   3602 <exit>
    2de5:	83 ec 0c             	sub    $0xc,%esp
    2de8:	6a 00                	push   $0x0
    2dea:	e8 9b 08 00 00       	call   368a <sbrk>
    2def:	29 c3                	sub    %eax,%ebx
    2df1:	89 1c 24             	mov    %ebx,(%esp)
    2df4:	e8 91 08 00 00       	call   368a <sbrk>
    2df9:	83 c4 10             	add    $0x10,%esp
    2dfc:	eb bd                	jmp    2dbb <sbrktest+0x29b>
    2dfe:	83 ec 0c             	sub    $0xc,%esp
    2e01:	68 b5 49 00 00       	push   $0x49b5
    2e06:	e8 85 0b 00 00       	call   3990 <printf>
    2e0b:	e8 f2 07 00 00       	call   3602 <exit>
    2e10:	83 ec 0c             	sub    $0xc,%esp
    2e13:	68 71 3e 00 00       	push   $0x3e71
    2e18:	e8 73 0b 00 00       	call   3990 <printf>
    2e1d:	e8 e0 07 00 00       	call   3602 <exit>
    2e22:	50                   	push   %eax
    2e23:	0f be 06             	movsbl (%esi),%eax
    2e26:	50                   	push   %eax
    2e27:	56                   	push   %esi
    2e28:	68 9c 49 00 00       	push   $0x499c
    2e2d:	e8 5e 0b 00 00       	call   3990 <printf>
    2e32:	89 3c 24             	mov    %edi,(%esp)
    2e35:	e8 f8 07 00 00       	call   3632 <kill>
    2e3a:	e8 c3 07 00 00       	call   3602 <exit>
    2e3f:	83 ec 0c             	sub    $0xc,%esp
    2e42:	68 79 4a 00 00       	push   $0x4a79
    2e47:	e8 44 0b 00 00       	call   3990 <printf>
    2e4c:	e8 b1 07 00 00       	call   3602 <exit>
    2e51:	52                   	push   %edx
    2e52:	50                   	push   %eax
    2e53:	56                   	push   %esi
    2e54:	68 7c 51 00 00       	push   $0x517c
    2e59:	e8 32 0b 00 00       	call   3990 <printf>
    2e5e:	e8 9f 07 00 00       	call   3602 <exit>
    2e63:	83 ec 0c             	sub    $0xc,%esp
    2e66:	68 4c 51 00 00       	push   $0x514c
    2e6b:	e8 20 0b 00 00       	call   3990 <printf>
    2e70:	e8 8d 07 00 00       	call   3602 <exit>
    2e75:	51                   	push   %ecx
    2e76:	57                   	push   %edi
    2e77:	56                   	push   %esi
    2e78:	68 24 51 00 00       	push   $0x5124
    2e7d:	e8 0e 0b 00 00       	call   3990 <printf>
    2e82:	e8 7b 07 00 00       	call   3602 <exit>
    2e87:	53                   	push   %ebx
    2e88:	50                   	push   %eax
    2e89:	56                   	push   %esi
    2e8a:	68 ec 50 00 00       	push   $0x50ec
    2e8f:	e8 fc 0a 00 00       	call   3990 <printf>
    2e94:	e8 69 07 00 00       	call   3602 <exit>
    2e99:	83 ec 0c             	sub    $0xc,%esp
    2e9c:	68 81 49 00 00       	push   $0x4981
    2ea1:	e8 ea 0a 00 00       	call   3990 <printf>
    2ea6:	e8 57 07 00 00       	call   3602 <exit>
    2eab:	83 ec 0c             	sub    $0xc,%esp
    2eae:	68 ac 50 00 00       	push   $0x50ac
    2eb3:	e8 d8 0a 00 00       	call   3990 <printf>
    2eb8:	e8 45 07 00 00       	call   3602 <exit>
    2ebd:	e8 40 07 00 00       	call   3602 <exit>
    2ec2:	83 ec 0c             	sub    $0xc,%esp
    2ec5:	68 65 49 00 00       	push   $0x4965
    2eca:	e8 c1 0a 00 00       	call   3990 <printf>
    2ecf:	e8 2e 07 00 00       	call   3602 <exit>
    2ed4:	83 ec 0c             	sub    $0xc,%esp
    2ed7:	68 4e 49 00 00       	push   $0x494e
    2edc:	e8 af 0a 00 00       	call   3990 <printf>
    2ee1:	e8 1c 07 00 00       	call   3602 <exit>
    2ee6:	8d 76 00             	lea    0x0(%esi),%esi
    2ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002ef0 <validateint>:
    2ef0:	55                   	push   %ebp
    2ef1:	89 e5                	mov    %esp,%ebp
    2ef3:	5d                   	pop    %ebp
    2ef4:	c3                   	ret    
    2ef5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002f00 <validatetest>:
    2f00:	55                   	push   %ebp
    2f01:	89 e5                	mov    %esp,%ebp
    2f03:	56                   	push   %esi
    2f04:	53                   	push   %ebx
    2f05:	31 db                	xor    %ebx,%ebx
    2f07:	83 ec 0c             	sub    $0xc,%esp
    2f0a:	68 de 49 00 00       	push   $0x49de
    2f0f:	e8 7c 0a 00 00       	call   3990 <printf>
    2f14:	83 c4 10             	add    $0x10,%esp
    2f17:	89 f6                	mov    %esi,%esi
    2f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    2f20:	e8 d5 06 00 00       	call   35fa <fork>
    2f25:	85 c0                	test   %eax,%eax
    2f27:	89 c6                	mov    %eax,%esi
    2f29:	74 5d                	je     2f88 <validatetest+0x88>
    2f2b:	83 ec 0c             	sub    $0xc,%esp
    2f2e:	6a 00                	push   $0x0
    2f30:	e8 5d 07 00 00       	call   3692 <sleep>
    2f35:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f3c:	e8 51 07 00 00       	call   3692 <sleep>
    2f41:	89 34 24             	mov    %esi,(%esp)
    2f44:	e8 e9 06 00 00       	call   3632 <kill>
    2f49:	e8 bc 06 00 00       	call   360a <wait>
    2f4e:	58                   	pop    %eax
    2f4f:	5a                   	pop    %edx
    2f50:	53                   	push   %ebx
    2f51:	68 ed 49 00 00       	push   $0x49ed
    2f56:	e8 07 07 00 00       	call   3662 <link>
    2f5b:	83 c4 10             	add    $0x10,%esp
    2f5e:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f61:	75 2a                	jne    2f8d <validatetest+0x8d>
    2f63:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    2f69:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    2f6f:	75 af                	jne    2f20 <validatetest+0x20>
    2f71:	83 ec 0c             	sub    $0xc,%esp
    2f74:	68 11 4a 00 00       	push   $0x4a11
    2f79:	e8 12 0a 00 00       	call   3990 <printf>
    2f7e:	83 c4 10             	add    $0x10,%esp
    2f81:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2f84:	5b                   	pop    %ebx
    2f85:	5e                   	pop    %esi
    2f86:	5d                   	pop    %ebp
    2f87:	c3                   	ret    
    2f88:	e8 75 06 00 00       	call   3602 <exit>
    2f8d:	83 ec 0c             	sub    $0xc,%esp
    2f90:	68 f8 49 00 00       	push   $0x49f8
    2f95:	e8 f6 09 00 00       	call   3990 <printf>
    2f9a:	e8 63 06 00 00       	call   3602 <exit>
    2f9f:	90                   	nop

00002fa0 <bsstest>:
    2fa0:	55                   	push   %ebp
    2fa1:	89 e5                	mov    %esp,%ebp
    2fa3:	83 ec 14             	sub    $0x14,%esp
    2fa6:	68 1e 4a 00 00       	push   $0x4a1e
    2fab:	e8 e0 09 00 00       	call   3990 <printf>
    2fb0:	83 c4 10             	add    $0x10,%esp
    2fb3:	80 3d e0 5c 00 00 00 	cmpb   $0x0,0x5ce0
    2fba:	75 31                	jne    2fed <bsstest+0x4d>
    2fbc:	b8 01 00 00 00       	mov    $0x1,%eax
    2fc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2fc8:	80 b8 e0 5c 00 00 00 	cmpb   $0x0,0x5ce0(%eax)
    2fcf:	75 1c                	jne    2fed <bsstest+0x4d>
    2fd1:	83 c0 01             	add    $0x1,%eax
    2fd4:	3d 10 27 00 00       	cmp    $0x2710,%eax
    2fd9:	75 ed                	jne    2fc8 <bsstest+0x28>
    2fdb:	83 ec 0c             	sub    $0xc,%esp
    2fde:	68 39 4a 00 00       	push   $0x4a39
    2fe3:	e8 a8 09 00 00       	call   3990 <printf>
    2fe8:	83 c4 10             	add    $0x10,%esp
    2feb:	c9                   	leave  
    2fec:	c3                   	ret    
    2fed:	83 ec 0c             	sub    $0xc,%esp
    2ff0:	68 28 4a 00 00       	push   $0x4a28
    2ff5:	e8 96 09 00 00       	call   3990 <printf>
    2ffa:	e8 03 06 00 00       	call   3602 <exit>
    2fff:	90                   	nop

00003000 <bigargtest>:
    3000:	55                   	push   %ebp
    3001:	89 e5                	mov    %esp,%ebp
    3003:	83 ec 14             	sub    $0x14,%esp
    3006:	68 46 4a 00 00       	push   $0x4a46
    300b:	e8 42 06 00 00       	call   3652 <unlink>
    3010:	e8 e5 05 00 00       	call   35fa <fork>
    3015:	83 c4 10             	add    $0x10,%esp
    3018:	85 c0                	test   %eax,%eax
    301a:	74 3f                	je     305b <bigargtest+0x5b>
    301c:	0f 88 b2 00 00 00    	js     30d4 <bigargtest+0xd4>
    3022:	e8 e3 05 00 00       	call   360a <wait>
    3027:	83 ec 08             	sub    $0x8,%esp
    302a:	6a 00                	push   $0x0
    302c:	68 46 4a 00 00       	push   $0x4a46
    3031:	e8 0c 06 00 00       	call   3642 <open>
    3036:	83 c4 10             	add    $0x10,%esp
    3039:	85 c0                	test   %eax,%eax
    303b:	0f 88 81 00 00 00    	js     30c2 <bigargtest+0xc2>
    3041:	83 ec 0c             	sub    $0xc,%esp
    3044:	50                   	push   %eax
    3045:	e8 e0 05 00 00       	call   362a <close>
    304a:	c7 04 24 46 4a 00 00 	movl   $0x4a46,(%esp)
    3051:	e8 fc 05 00 00       	call   3652 <unlink>
    3056:	83 c4 10             	add    $0x10,%esp
    3059:	c9                   	leave  
    305a:	c3                   	ret    
    305b:	b8 40 5c 00 00       	mov    $0x5c40,%eax
    3060:	c7 00 a0 51 00 00    	movl   $0x51a0,(%eax)
    3066:	83 c0 04             	add    $0x4,%eax
    3069:	3d bc 5c 00 00       	cmp    $0x5cbc,%eax
    306e:	75 f0                	jne    3060 <bigargtest+0x60>
    3070:	83 ec 0c             	sub    $0xc,%esp
    3073:	c7 05 bc 5c 00 00 00 	movl   $0x0,0x5cbc
    307a:	00 00 00 
    307d:	68 50 4a 00 00       	push   $0x4a50
    3082:	e8 09 09 00 00       	call   3990 <printf>
    3087:	58                   	pop    %eax
    3088:	5a                   	pop    %edx
    3089:	68 40 5c 00 00       	push   $0x5c40
    308e:	68 1d 3c 00 00       	push   $0x3c1d
    3093:	e8 a2 05 00 00       	call   363a <exec>
    3098:	c7 04 24 5d 4a 00 00 	movl   $0x4a5d,(%esp)
    309f:	e8 ec 08 00 00       	call   3990 <printf>
    30a4:	59                   	pop    %ecx
    30a5:	58                   	pop    %eax
    30a6:	68 00 02 00 00       	push   $0x200
    30ab:	68 46 4a 00 00       	push   $0x4a46
    30b0:	e8 8d 05 00 00       	call   3642 <open>
    30b5:	89 04 24             	mov    %eax,(%esp)
    30b8:	e8 6d 05 00 00       	call   362a <close>
    30bd:	e8 40 05 00 00       	call   3602 <exit>
    30c2:	83 ec 0c             	sub    $0xc,%esp
    30c5:	68 86 4a 00 00       	push   $0x4a86
    30ca:	e8 c1 08 00 00       	call   3990 <printf>
    30cf:	e8 2e 05 00 00       	call   3602 <exit>
    30d4:	83 ec 0c             	sub    $0xc,%esp
    30d7:	68 6d 4a 00 00       	push   $0x4a6d
    30dc:	e8 af 08 00 00       	call   3990 <printf>
    30e1:	e8 1c 05 00 00       	call   3602 <exit>
    30e6:	8d 76 00             	lea    0x0(%esi),%esi
    30e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000030f0 <fsfull>:
    30f0:	55                   	push   %ebp
    30f1:	89 e5                	mov    %esp,%ebp
    30f3:	57                   	push   %edi
    30f4:	56                   	push   %esi
    30f5:	53                   	push   %ebx
    30f6:	31 db                	xor    %ebx,%ebx
    30f8:	83 ec 58             	sub    $0x58,%esp
    30fb:	68 9b 4a 00 00       	push   $0x4a9b
    3100:	e8 8b 08 00 00       	call   3990 <printf>
    3105:	83 c4 10             	add    $0x10,%esp
    3108:	90                   	nop
    3109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3110:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3115:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    311a:	83 ec 08             	sub    $0x8,%esp
    311d:	f7 e3                	mul    %ebx
    311f:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    3123:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    3127:	c1 ea 06             	shr    $0x6,%edx
    312a:	8d 42 30             	lea    0x30(%edx),%eax
    312d:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    3133:	88 45 a9             	mov    %al,-0x57(%ebp)
    3136:	89 d8                	mov    %ebx,%eax
    3138:	29 d0                	sub    %edx,%eax
    313a:	89 c2                	mov    %eax,%edx
    313c:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3141:	f7 e2                	mul    %edx
    3143:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3148:	c1 ea 05             	shr    $0x5,%edx
    314b:	83 c2 30             	add    $0x30,%edx
    314e:	88 55 aa             	mov    %dl,-0x56(%ebp)
    3151:	f7 e3                	mul    %ebx
    3153:	89 d8                	mov    %ebx,%eax
    3155:	c1 ea 05             	shr    $0x5,%edx
    3158:	6b d2 64             	imul   $0x64,%edx,%edx
    315b:	29 d0                	sub    %edx,%eax
    315d:	f7 e1                	mul    %ecx
    315f:	89 d8                	mov    %ebx,%eax
    3161:	c1 ea 03             	shr    $0x3,%edx
    3164:	83 c2 30             	add    $0x30,%edx
    3167:	88 55 ab             	mov    %dl,-0x55(%ebp)
    316a:	f7 e1                	mul    %ecx
    316c:	89 d9                	mov    %ebx,%ecx
    316e:	c1 ea 03             	shr    $0x3,%edx
    3171:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3174:	01 c0                	add    %eax,%eax
    3176:	29 c1                	sub    %eax,%ecx
    3178:	89 c8                	mov    %ecx,%eax
    317a:	83 c0 30             	add    $0x30,%eax
    317d:	88 45 ac             	mov    %al,-0x54(%ebp)
    3180:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3183:	50                   	push   %eax
    3184:	68 a8 4a 00 00       	push   $0x4aa8
    3189:	e8 02 08 00 00       	call   3990 <printf>
    318e:	58                   	pop    %eax
    318f:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3192:	5a                   	pop    %edx
    3193:	68 02 02 00 00       	push   $0x202
    3198:	50                   	push   %eax
    3199:	e8 a4 04 00 00       	call   3642 <open>
    319e:	83 c4 10             	add    $0x10,%esp
    31a1:	85 c0                	test   %eax,%eax
    31a3:	89 c7                	mov    %eax,%edi
    31a5:	78 51                	js     31f8 <fsfull+0x108>
    31a7:	31 f6                	xor    %esi,%esi
    31a9:	eb 07                	jmp    31b2 <fsfull+0xc2>
    31ab:	90                   	nop
    31ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    31b0:	01 c6                	add    %eax,%esi
    31b2:	83 ec 04             	sub    $0x4,%esp
    31b5:	68 00 02 00 00       	push   $0x200
    31ba:	68 00 84 00 00       	push   $0x8400
    31bf:	57                   	push   %edi
    31c0:	e8 5d 04 00 00       	call   3622 <write>
    31c5:	83 c4 10             	add    $0x10,%esp
    31c8:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    31cd:	7f e1                	jg     31b0 <fsfull+0xc0>
    31cf:	83 ec 08             	sub    $0x8,%esp
    31d2:	56                   	push   %esi
    31d3:	68 c4 4a 00 00       	push   $0x4ac4
    31d8:	e8 b3 07 00 00       	call   3990 <printf>
    31dd:	89 3c 24             	mov    %edi,(%esp)
    31e0:	e8 45 04 00 00       	call   362a <close>
    31e5:	83 c4 10             	add    $0x10,%esp
    31e8:	85 f6                	test   %esi,%esi
    31ea:	74 20                	je     320c <fsfull+0x11c>
    31ec:	83 c3 01             	add    $0x1,%ebx
    31ef:	e9 1c ff ff ff       	jmp    3110 <fsfull+0x20>
    31f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    31f8:	8d 45 a8             	lea    -0x58(%ebp),%eax
    31fb:	83 ec 08             	sub    $0x8,%esp
    31fe:	50                   	push   %eax
    31ff:	68 b4 4a 00 00       	push   $0x4ab4
    3204:	e8 87 07 00 00       	call   3990 <printf>
    3209:	83 c4 10             	add    $0x10,%esp
    320c:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
    3211:	be 1f 85 eb 51       	mov    $0x51eb851f,%esi
    3216:	8d 76 00             	lea    0x0(%esi),%esi
    3219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    3220:	89 d8                	mov    %ebx,%eax
    3222:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    3227:	83 ec 0c             	sub    $0xc,%esp
    322a:	f7 e7                	mul    %edi
    322c:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    3230:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    3234:	c1 ea 06             	shr    $0x6,%edx
    3237:	8d 42 30             	lea    0x30(%edx),%eax
    323a:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    3240:	88 45 a9             	mov    %al,-0x57(%ebp)
    3243:	89 d8                	mov    %ebx,%eax
    3245:	29 d0                	sub    %edx,%eax
    3247:	f7 e6                	mul    %esi
    3249:	89 d8                	mov    %ebx,%eax
    324b:	c1 ea 05             	shr    $0x5,%edx
    324e:	83 c2 30             	add    $0x30,%edx
    3251:	88 55 aa             	mov    %dl,-0x56(%ebp)
    3254:	f7 e6                	mul    %esi
    3256:	89 d8                	mov    %ebx,%eax
    3258:	c1 ea 05             	shr    $0x5,%edx
    325b:	6b d2 64             	imul   $0x64,%edx,%edx
    325e:	29 d0                	sub    %edx,%eax
    3260:	f7 e1                	mul    %ecx
    3262:	89 d8                	mov    %ebx,%eax
    3264:	c1 ea 03             	shr    $0x3,%edx
    3267:	83 c2 30             	add    $0x30,%edx
    326a:	88 55 ab             	mov    %dl,-0x55(%ebp)
    326d:	f7 e1                	mul    %ecx
    326f:	89 d9                	mov    %ebx,%ecx
    3271:	83 eb 01             	sub    $0x1,%ebx
    3274:	c1 ea 03             	shr    $0x3,%edx
    3277:	8d 04 92             	lea    (%edx,%edx,4),%eax
    327a:	01 c0                	add    %eax,%eax
    327c:	29 c1                	sub    %eax,%ecx
    327e:	89 c8                	mov    %ecx,%eax
    3280:	83 c0 30             	add    $0x30,%eax
    3283:	88 45 ac             	mov    %al,-0x54(%ebp)
    3286:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3289:	50                   	push   %eax
    328a:	e8 c3 03 00 00       	call   3652 <unlink>
    328f:	83 c4 10             	add    $0x10,%esp
    3292:	83 fb ff             	cmp    $0xffffffff,%ebx
    3295:	75 89                	jne    3220 <fsfull+0x130>
    3297:	83 ec 0c             	sub    $0xc,%esp
    329a:	68 d4 4a 00 00       	push   $0x4ad4
    329f:	e8 ec 06 00 00       	call   3990 <printf>
    32a4:	83 c4 10             	add    $0x10,%esp
    32a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    32aa:	5b                   	pop    %ebx
    32ab:	5e                   	pop    %esi
    32ac:	5f                   	pop    %edi
    32ad:	5d                   	pop    %ebp
    32ae:	c3                   	ret    
    32af:	90                   	nop

000032b0 <uio>:
    32b0:	55                   	push   %ebp
    32b1:	89 e5                	mov    %esp,%ebp
    32b3:	83 ec 14             	sub    $0x14,%esp
    32b6:	68 ea 4a 00 00       	push   $0x4aea
    32bb:	e8 d0 06 00 00       	call   3990 <printf>
    32c0:	e8 35 03 00 00       	call   35fa <fork>
    32c5:	83 c4 10             	add    $0x10,%esp
    32c8:	85 c0                	test   %eax,%eax
    32ca:	74 19                	je     32e5 <uio+0x35>
    32cc:	78 3b                	js     3309 <uio+0x59>
    32ce:	e8 37 03 00 00       	call   360a <wait>
    32d3:	83 ec 0c             	sub    $0xc,%esp
    32d6:	68 f4 4a 00 00       	push   $0x4af4
    32db:	e8 b0 06 00 00       	call   3990 <printf>
    32e0:	83 c4 10             	add    $0x10,%esp
    32e3:	c9                   	leave  
    32e4:	c3                   	ret    
    32e5:	b8 09 00 00 00       	mov    $0x9,%eax
    32ea:	ba 70 00 00 00       	mov    $0x70,%edx
    32ef:	ee                   	out    %al,(%dx)
    32f0:	ba 71 00 00 00       	mov    $0x71,%edx
    32f5:	ec                   	in     (%dx),%al
    32f6:	52                   	push   %edx
    32f7:	52                   	push   %edx
    32f8:	68 80 52 00 00       	push   $0x5280
    32fd:	6a 02                	push   $0x2
    32ff:	e8 6c 06 00 00       	call   3970 <fprintf>
    3304:	e8 f9 02 00 00       	call   3602 <exit>
    3309:	50                   	push   %eax
    330a:	50                   	push   %eax
    330b:	68 79 4a 00 00       	push   $0x4a79
    3310:	6a 02                	push   $0x2
    3312:	e8 59 06 00 00       	call   3970 <fprintf>
    3317:	e8 e6 02 00 00       	call   3602 <exit>
    331c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003320 <argptest>:
    3320:	55                   	push   %ebp
    3321:	89 e5                	mov    %esp,%ebp
    3323:	53                   	push   %ebx
    3324:	83 ec 0c             	sub    $0xc,%esp
    3327:	6a 00                	push   $0x0
    3329:	68 03 4b 00 00       	push   $0x4b03
    332e:	e8 0f 03 00 00       	call   3642 <open>
    3333:	83 c4 10             	add    $0x10,%esp
    3336:	85 c0                	test   %eax,%eax
    3338:	78 37                	js     3371 <argptest+0x51>
    333a:	83 ec 0c             	sub    $0xc,%esp
    333d:	89 c3                	mov    %eax,%ebx
    333f:	6a 00                	push   $0x0
    3341:	e8 44 03 00 00       	call   368a <sbrk>
    3346:	83 c4 0c             	add    $0xc,%esp
    3349:	83 e8 01             	sub    $0x1,%eax
    334c:	6a ff                	push   $0xffffffff
    334e:	50                   	push   %eax
    334f:	53                   	push   %ebx
    3350:	e8 c5 02 00 00       	call   361a <read>
    3355:	89 1c 24             	mov    %ebx,(%esp)
    3358:	e8 cd 02 00 00       	call   362a <close>
    335d:	c7 04 24 15 4b 00 00 	movl   $0x4b15,(%esp)
    3364:	e8 27 06 00 00       	call   3990 <printf>
    3369:	83 c4 10             	add    $0x10,%esp
    336c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    336f:	c9                   	leave  
    3370:	c3                   	ret    
    3371:	50                   	push   %eax
    3372:	50                   	push   %eax
    3373:	68 08 4b 00 00       	push   $0x4b08
    3378:	6a 02                	push   $0x2
    337a:	e8 f1 05 00 00       	call   3970 <fprintf>
    337f:	e8 7e 02 00 00       	call   3602 <exit>
    3384:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    338a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003390 <rand>:
    3390:	69 05 24 5c 00 00 0d 	imul   $0x19660d,0x5c24,%eax
    3397:	66 19 00 
    339a:	55                   	push   %ebp
    339b:	89 e5                	mov    %esp,%ebp
    339d:	5d                   	pop    %ebp
    339e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    33a3:	a3 24 5c 00 00       	mov    %eax,0x5c24
    33a8:	c3                   	ret    
    33a9:	66 90                	xchg   %ax,%ax
    33ab:	66 90                	xchg   %ax,%ax
    33ad:	66 90                	xchg   %ax,%ax
    33af:	90                   	nop

000033b0 <strcpy>:
    33b0:	55                   	push   %ebp
    33b1:	89 e5                	mov    %esp,%ebp
    33b3:	53                   	push   %ebx
    33b4:	8b 45 08             	mov    0x8(%ebp),%eax
    33b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    33ba:	89 c2                	mov    %eax,%edx
    33bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    33c0:	83 c1 01             	add    $0x1,%ecx
    33c3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    33c7:	83 c2 01             	add    $0x1,%edx
    33ca:	84 db                	test   %bl,%bl
    33cc:	88 5a ff             	mov    %bl,-0x1(%edx)
    33cf:	75 ef                	jne    33c0 <strcpy+0x10>
    33d1:	5b                   	pop    %ebx
    33d2:	5d                   	pop    %ebp
    33d3:	c3                   	ret    
    33d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    33da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000033e0 <strcmp>:
    33e0:	55                   	push   %ebp
    33e1:	89 e5                	mov    %esp,%ebp
    33e3:	53                   	push   %ebx
    33e4:	8b 55 08             	mov    0x8(%ebp),%edx
    33e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    33ea:	0f b6 02             	movzbl (%edx),%eax
    33ed:	0f b6 19             	movzbl (%ecx),%ebx
    33f0:	84 c0                	test   %al,%al
    33f2:	75 1c                	jne    3410 <strcmp+0x30>
    33f4:	eb 2a                	jmp    3420 <strcmp+0x40>
    33f6:	8d 76 00             	lea    0x0(%esi),%esi
    33f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    3400:	83 c2 01             	add    $0x1,%edx
    3403:	0f b6 02             	movzbl (%edx),%eax
    3406:	83 c1 01             	add    $0x1,%ecx
    3409:	0f b6 19             	movzbl (%ecx),%ebx
    340c:	84 c0                	test   %al,%al
    340e:	74 10                	je     3420 <strcmp+0x40>
    3410:	38 d8                	cmp    %bl,%al
    3412:	74 ec                	je     3400 <strcmp+0x20>
    3414:	29 d8                	sub    %ebx,%eax
    3416:	5b                   	pop    %ebx
    3417:	5d                   	pop    %ebp
    3418:	c3                   	ret    
    3419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3420:	31 c0                	xor    %eax,%eax
    3422:	29 d8                	sub    %ebx,%eax
    3424:	5b                   	pop    %ebx
    3425:	5d                   	pop    %ebp
    3426:	c3                   	ret    
    3427:	89 f6                	mov    %esi,%esi
    3429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003430 <strlen>:
    3430:	55                   	push   %ebp
    3431:	89 e5                	mov    %esp,%ebp
    3433:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3436:	80 39 00             	cmpb   $0x0,(%ecx)
    3439:	74 15                	je     3450 <strlen+0x20>
    343b:	31 d2                	xor    %edx,%edx
    343d:	8d 76 00             	lea    0x0(%esi),%esi
    3440:	83 c2 01             	add    $0x1,%edx
    3443:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    3447:	89 d0                	mov    %edx,%eax
    3449:	75 f5                	jne    3440 <strlen+0x10>
    344b:	5d                   	pop    %ebp
    344c:	c3                   	ret    
    344d:	8d 76 00             	lea    0x0(%esi),%esi
    3450:	31 c0                	xor    %eax,%eax
    3452:	5d                   	pop    %ebp
    3453:	c3                   	ret    
    3454:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    345a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003460 <memset>:
    3460:	55                   	push   %ebp
    3461:	89 e5                	mov    %esp,%ebp
    3463:	57                   	push   %edi
    3464:	8b 55 08             	mov    0x8(%ebp),%edx
    3467:	8b 4d 10             	mov    0x10(%ebp),%ecx
    346a:	8b 45 0c             	mov    0xc(%ebp),%eax
    346d:	89 d7                	mov    %edx,%edi
    346f:	fc                   	cld    
    3470:	f3 aa                	rep stos %al,%es:(%edi)
    3472:	89 d0                	mov    %edx,%eax
    3474:	5f                   	pop    %edi
    3475:	5d                   	pop    %ebp
    3476:	c3                   	ret    
    3477:	89 f6                	mov    %esi,%esi
    3479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003480 <strchr>:
    3480:	55                   	push   %ebp
    3481:	89 e5                	mov    %esp,%ebp
    3483:	53                   	push   %ebx
    3484:	8b 45 08             	mov    0x8(%ebp),%eax
    3487:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    348a:	0f b6 10             	movzbl (%eax),%edx
    348d:	84 d2                	test   %dl,%dl
    348f:	74 1d                	je     34ae <strchr+0x2e>
    3491:	38 d3                	cmp    %dl,%bl
    3493:	89 d9                	mov    %ebx,%ecx
    3495:	75 0d                	jne    34a4 <strchr+0x24>
    3497:	eb 17                	jmp    34b0 <strchr+0x30>
    3499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    34a0:	38 ca                	cmp    %cl,%dl
    34a2:	74 0c                	je     34b0 <strchr+0x30>
    34a4:	83 c0 01             	add    $0x1,%eax
    34a7:	0f b6 10             	movzbl (%eax),%edx
    34aa:	84 d2                	test   %dl,%dl
    34ac:	75 f2                	jne    34a0 <strchr+0x20>
    34ae:	31 c0                	xor    %eax,%eax
    34b0:	5b                   	pop    %ebx
    34b1:	5d                   	pop    %ebp
    34b2:	c3                   	ret    
    34b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    34b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000034c0 <gets>:
    34c0:	55                   	push   %ebp
    34c1:	89 e5                	mov    %esp,%ebp
    34c3:	57                   	push   %edi
    34c4:	56                   	push   %esi
    34c5:	53                   	push   %ebx
    34c6:	31 f6                	xor    %esi,%esi
    34c8:	89 f3                	mov    %esi,%ebx
    34ca:	83 ec 1c             	sub    $0x1c,%esp
    34cd:	8b 7d 08             	mov    0x8(%ebp),%edi
    34d0:	eb 2f                	jmp    3501 <gets+0x41>
    34d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    34d8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    34db:	83 ec 04             	sub    $0x4,%esp
    34de:	6a 01                	push   $0x1
    34e0:	50                   	push   %eax
    34e1:	6a 00                	push   $0x0
    34e3:	e8 32 01 00 00       	call   361a <read>
    34e8:	83 c4 10             	add    $0x10,%esp
    34eb:	85 c0                	test   %eax,%eax
    34ed:	7e 1c                	jle    350b <gets+0x4b>
    34ef:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    34f3:	83 c7 01             	add    $0x1,%edi
    34f6:	88 47 ff             	mov    %al,-0x1(%edi)
    34f9:	3c 0a                	cmp    $0xa,%al
    34fb:	74 23                	je     3520 <gets+0x60>
    34fd:	3c 0d                	cmp    $0xd,%al
    34ff:	74 1f                	je     3520 <gets+0x60>
    3501:	83 c3 01             	add    $0x1,%ebx
    3504:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    3507:	89 fe                	mov    %edi,%esi
    3509:	7c cd                	jl     34d8 <gets+0x18>
    350b:	89 f3                	mov    %esi,%ebx
    350d:	8b 45 08             	mov    0x8(%ebp),%eax
    3510:	c6 03 00             	movb   $0x0,(%ebx)
    3513:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3516:	5b                   	pop    %ebx
    3517:	5e                   	pop    %esi
    3518:	5f                   	pop    %edi
    3519:	5d                   	pop    %ebp
    351a:	c3                   	ret    
    351b:	90                   	nop
    351c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3520:	8b 75 08             	mov    0x8(%ebp),%esi
    3523:	8b 45 08             	mov    0x8(%ebp),%eax
    3526:	01 de                	add    %ebx,%esi
    3528:	89 f3                	mov    %esi,%ebx
    352a:	c6 03 00             	movb   $0x0,(%ebx)
    352d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3530:	5b                   	pop    %ebx
    3531:	5e                   	pop    %esi
    3532:	5f                   	pop    %edi
    3533:	5d                   	pop    %ebp
    3534:	c3                   	ret    
    3535:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003540 <stat>:
    3540:	55                   	push   %ebp
    3541:	89 e5                	mov    %esp,%ebp
    3543:	56                   	push   %esi
    3544:	53                   	push   %ebx
    3545:	83 ec 08             	sub    $0x8,%esp
    3548:	6a 00                	push   $0x0
    354a:	ff 75 08             	pushl  0x8(%ebp)
    354d:	e8 f0 00 00 00       	call   3642 <open>
    3552:	83 c4 10             	add    $0x10,%esp
    3555:	85 c0                	test   %eax,%eax
    3557:	78 27                	js     3580 <stat+0x40>
    3559:	83 ec 08             	sub    $0x8,%esp
    355c:	ff 75 0c             	pushl  0xc(%ebp)
    355f:	89 c3                	mov    %eax,%ebx
    3561:	50                   	push   %eax
    3562:	e8 f3 00 00 00       	call   365a <fstat>
    3567:	89 1c 24             	mov    %ebx,(%esp)
    356a:	89 c6                	mov    %eax,%esi
    356c:	e8 b9 00 00 00       	call   362a <close>
    3571:	83 c4 10             	add    $0x10,%esp
    3574:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3577:	89 f0                	mov    %esi,%eax
    3579:	5b                   	pop    %ebx
    357a:	5e                   	pop    %esi
    357b:	5d                   	pop    %ebp
    357c:	c3                   	ret    
    357d:	8d 76 00             	lea    0x0(%esi),%esi
    3580:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3585:	eb ed                	jmp    3574 <stat+0x34>
    3587:	89 f6                	mov    %esi,%esi
    3589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003590 <atoi>:
    3590:	55                   	push   %ebp
    3591:	89 e5                	mov    %esp,%ebp
    3593:	53                   	push   %ebx
    3594:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3597:	0f be 11             	movsbl (%ecx),%edx
    359a:	8d 42 d0             	lea    -0x30(%edx),%eax
    359d:	3c 09                	cmp    $0x9,%al
    359f:	b8 00 00 00 00       	mov    $0x0,%eax
    35a4:	77 1f                	ja     35c5 <atoi+0x35>
    35a6:	8d 76 00             	lea    0x0(%esi),%esi
    35a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    35b0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    35b3:	83 c1 01             	add    $0x1,%ecx
    35b6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
    35ba:	0f be 11             	movsbl (%ecx),%edx
    35bd:	8d 5a d0             	lea    -0x30(%edx),%ebx
    35c0:	80 fb 09             	cmp    $0x9,%bl
    35c3:	76 eb                	jbe    35b0 <atoi+0x20>
    35c5:	5b                   	pop    %ebx
    35c6:	5d                   	pop    %ebp
    35c7:	c3                   	ret    
    35c8:	90                   	nop
    35c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000035d0 <memmove>:
    35d0:	55                   	push   %ebp
    35d1:	89 e5                	mov    %esp,%ebp
    35d3:	56                   	push   %esi
    35d4:	53                   	push   %ebx
    35d5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    35d8:	8b 45 08             	mov    0x8(%ebp),%eax
    35db:	8b 75 0c             	mov    0xc(%ebp),%esi
    35de:	85 db                	test   %ebx,%ebx
    35e0:	7e 14                	jle    35f6 <memmove+0x26>
    35e2:	31 d2                	xor    %edx,%edx
    35e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    35e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    35ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    35ef:	83 c2 01             	add    $0x1,%edx
    35f2:	39 d3                	cmp    %edx,%ebx
    35f4:	75 f2                	jne    35e8 <memmove+0x18>
    35f6:	5b                   	pop    %ebx
    35f7:	5e                   	pop    %esi
    35f8:	5d                   	pop    %ebp
    35f9:	c3                   	ret    

000035fa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    35fa:	b8 01 00 00 00       	mov    $0x1,%eax
    35ff:	cd 40                	int    $0x40
    3601:	c3                   	ret    

00003602 <exit>:
SYSCALL(exit)
    3602:	b8 02 00 00 00       	mov    $0x2,%eax
    3607:	cd 40                	int    $0x40
    3609:	c3                   	ret    

0000360a <wait>:
SYSCALL(wait)
    360a:	b8 03 00 00 00       	mov    $0x3,%eax
    360f:	cd 40                	int    $0x40
    3611:	c3                   	ret    

00003612 <pipe>:
SYSCALL(pipe)
    3612:	b8 04 00 00 00       	mov    $0x4,%eax
    3617:	cd 40                	int    $0x40
    3619:	c3                   	ret    

0000361a <read>:
SYSCALL(read)
    361a:	b8 05 00 00 00       	mov    $0x5,%eax
    361f:	cd 40                	int    $0x40
    3621:	c3                   	ret    

00003622 <write>:
SYSCALL(write)
    3622:	b8 10 00 00 00       	mov    $0x10,%eax
    3627:	cd 40                	int    $0x40
    3629:	c3                   	ret    

0000362a <close>:
SYSCALL(close)
    362a:	b8 15 00 00 00       	mov    $0x15,%eax
    362f:	cd 40                	int    $0x40
    3631:	c3                   	ret    

00003632 <kill>:
SYSCALL(kill)
    3632:	b8 06 00 00 00       	mov    $0x6,%eax
    3637:	cd 40                	int    $0x40
    3639:	c3                   	ret    

0000363a <exec>:
SYSCALL(exec)
    363a:	b8 07 00 00 00       	mov    $0x7,%eax
    363f:	cd 40                	int    $0x40
    3641:	c3                   	ret    

00003642 <open>:
SYSCALL(open)
    3642:	b8 0f 00 00 00       	mov    $0xf,%eax
    3647:	cd 40                	int    $0x40
    3649:	c3                   	ret    

0000364a <mknod>:
SYSCALL(mknod)
    364a:	b8 11 00 00 00       	mov    $0x11,%eax
    364f:	cd 40                	int    $0x40
    3651:	c3                   	ret    

00003652 <unlink>:
SYSCALL(unlink)
    3652:	b8 12 00 00 00       	mov    $0x12,%eax
    3657:	cd 40                	int    $0x40
    3659:	c3                   	ret    

0000365a <fstat>:
SYSCALL(fstat)
    365a:	b8 08 00 00 00       	mov    $0x8,%eax
    365f:	cd 40                	int    $0x40
    3661:	c3                   	ret    

00003662 <link>:
SYSCALL(link)
    3662:	b8 13 00 00 00       	mov    $0x13,%eax
    3667:	cd 40                	int    $0x40
    3669:	c3                   	ret    

0000366a <mkdir>:
SYSCALL(mkdir)
    366a:	b8 14 00 00 00       	mov    $0x14,%eax
    366f:	cd 40                	int    $0x40
    3671:	c3                   	ret    

00003672 <chdir>:
SYSCALL(chdir)
    3672:	b8 09 00 00 00       	mov    $0x9,%eax
    3677:	cd 40                	int    $0x40
    3679:	c3                   	ret    

0000367a <dup>:
SYSCALL(dup)
    367a:	b8 0a 00 00 00       	mov    $0xa,%eax
    367f:	cd 40                	int    $0x40
    3681:	c3                   	ret    

00003682 <getpid>:
SYSCALL(getpid)
    3682:	b8 0b 00 00 00       	mov    $0xb,%eax
    3687:	cd 40                	int    $0x40
    3689:	c3                   	ret    

0000368a <sbrk>:
SYSCALL(sbrk)
    368a:	b8 0c 00 00 00       	mov    $0xc,%eax
    368f:	cd 40                	int    $0x40
    3691:	c3                   	ret    

00003692 <sleep>:
SYSCALL(sleep)
    3692:	b8 0d 00 00 00       	mov    $0xd,%eax
    3697:	cd 40                	int    $0x40
    3699:	c3                   	ret    

0000369a <uptime>:
SYSCALL(uptime)
    369a:	b8 0e 00 00 00       	mov    $0xe,%eax
    369f:	cd 40                	int    $0x40
    36a1:	c3                   	ret    

000036a2 <cpuhalt>:
SYSCALL(cpuhalt)
    36a2:	b8 16 00 00 00       	mov    $0x16,%eax
    36a7:	cd 40                	int    $0x40
    36a9:	c3                   	ret    
    36aa:	66 90                	xchg   %ax,%ax
    36ac:	66 90                	xchg   %ax,%ax
    36ae:	66 90                	xchg   %ax,%ax

000036b0 <printint.constprop.1>:
    36b0:	55                   	push   %ebp
    36b1:	89 e5                	mov    %esp,%ebp
    36b3:	57                   	push   %edi
    36b4:	56                   	push   %esi
    36b5:	53                   	push   %ebx
    36b6:	89 d6                	mov    %edx,%esi
    36b8:	83 ec 3c             	sub    $0x3c,%esp
    36bb:	85 c0                	test   %eax,%eax
    36bd:	79 71                	jns    3730 <printint.constprop.1+0x80>
    36bf:	83 e1 01             	and    $0x1,%ecx
    36c2:	74 6c                	je     3730 <printint.constprop.1+0x80>
    36c4:	f7 d8                	neg    %eax
    36c6:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    36cd:	31 c9                	xor    %ecx,%ecx
    36cf:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    36d2:	eb 06                	jmp    36da <printint.constprop.1+0x2a>
    36d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    36d8:	89 f9                	mov    %edi,%ecx
    36da:	31 d2                	xor    %edx,%edx
    36dc:	8d 79 01             	lea    0x1(%ecx),%edi
    36df:	f7 f6                	div    %esi
    36e1:	0f b6 92 d8 52 00 00 	movzbl 0x52d8(%edx),%edx
    36e8:	85 c0                	test   %eax,%eax
    36ea:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
    36ed:	75 e9                	jne    36d8 <printint.constprop.1+0x28>
    36ef:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    36f2:	85 c0                	test   %eax,%eax
    36f4:	74 08                	je     36fe <printint.constprop.1+0x4e>
    36f6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    36fb:	8d 79 02             	lea    0x2(%ecx),%edi
    36fe:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    3702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3708:	0f b6 06             	movzbl (%esi),%eax
    370b:	83 ec 04             	sub    $0x4,%esp
    370e:	83 ee 01             	sub    $0x1,%esi
    3711:	6a 01                	push   $0x1
    3713:	53                   	push   %ebx
    3714:	6a 01                	push   $0x1
    3716:	88 45 d7             	mov    %al,-0x29(%ebp)
    3719:	e8 04 ff ff ff       	call   3622 <write>
    371e:	83 c4 10             	add    $0x10,%esp
    3721:	39 de                	cmp    %ebx,%esi
    3723:	75 e3                	jne    3708 <printint.constprop.1+0x58>
    3725:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3728:	5b                   	pop    %ebx
    3729:	5e                   	pop    %esi
    372a:	5f                   	pop    %edi
    372b:	5d                   	pop    %ebp
    372c:	c3                   	ret    
    372d:	8d 76 00             	lea    0x0(%esi),%esi
    3730:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    3737:	eb 94                	jmp    36cd <printint.constprop.1+0x1d>
    3739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003740 <vprintf.constprop.0>:
    3740:	55                   	push   %ebp
    3741:	89 e5                	mov    %esp,%ebp
    3743:	57                   	push   %edi
    3744:	56                   	push   %esi
    3745:	53                   	push   %ebx
    3746:	89 d6                	mov    %edx,%esi
    3748:	83 ec 2c             	sub    $0x2c,%esp
    374b:	0f b6 10             	movzbl (%eax),%edx
    374e:	84 d2                	test   %dl,%dl
    3750:	0f 84 cd 00 00 00    	je     3823 <vprintf.constprop.0+0xe3>
    3756:	8d 58 01             	lea    0x1(%eax),%ebx
    3759:	31 ff                	xor    %edi,%edi
    375b:	eb 31                	jmp    378e <vprintf.constprop.0+0x4e>
    375d:	8d 76 00             	lea    0x0(%esi),%esi
    3760:	83 f8 25             	cmp    $0x25,%eax
    3763:	0f 84 c7 00 00 00    	je     3830 <vprintf.constprop.0+0xf0>
    3769:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    376c:	83 ec 04             	sub    $0x4,%esp
    376f:	88 55 e4             	mov    %dl,-0x1c(%ebp)
    3772:	6a 01                	push   $0x1
    3774:	50                   	push   %eax
    3775:	6a 01                	push   $0x1
    3777:	e8 a6 fe ff ff       	call   3622 <write>
    377c:	83 c4 10             	add    $0x10,%esp
    377f:	83 c3 01             	add    $0x1,%ebx
    3782:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    3786:	84 d2                	test   %dl,%dl
    3788:	0f 84 95 00 00 00    	je     3823 <vprintf.constprop.0+0xe3>
    378e:	85 ff                	test   %edi,%edi
    3790:	0f b6 c2             	movzbl %dl,%eax
    3793:	74 cb                	je     3760 <vprintf.constprop.0+0x20>
    3795:	83 ff 25             	cmp    $0x25,%edi
    3798:	75 e5                	jne    377f <vprintf.constprop.0+0x3f>
    379a:	83 f8 64             	cmp    $0x64,%eax
    379d:	8d 7e 04             	lea    0x4(%esi),%edi
    37a0:	b9 01 00 00 00       	mov    $0x1,%ecx
    37a5:	0f 84 9a 00 00 00    	je     3845 <vprintf.constprop.0+0x105>
    37ab:	83 f8 6c             	cmp    $0x6c,%eax
    37ae:	0f 84 8c 00 00 00    	je     3840 <vprintf.constprop.0+0x100>
    37b4:	83 f8 78             	cmp    $0x78,%eax
    37b7:	0f 84 a3 00 00 00    	je     3860 <vprintf.constprop.0+0x120>
    37bd:	83 f8 70             	cmp    $0x70,%eax
    37c0:	0f 84 ca 00 00 00    	je     3890 <vprintf.constprop.0+0x150>
    37c6:	83 f8 73             	cmp    $0x73,%eax
    37c9:	0f 84 39 01 00 00    	je     3908 <vprintf.constprop.0+0x1c8>
    37cf:	83 f8 63             	cmp    $0x63,%eax
    37d2:	0f 84 68 01 00 00    	je     3940 <vprintf.constprop.0+0x200>
    37d8:	83 f8 25             	cmp    $0x25,%eax
    37db:	0f 84 9f 00 00 00    	je     3880 <vprintf.constprop.0+0x140>
    37e1:	8d 45 df             	lea    -0x21(%ebp),%eax
    37e4:	83 ec 04             	sub    $0x4,%esp
    37e7:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    37ea:	6a 01                	push   $0x1
    37ec:	c6 45 df 25          	movb   $0x25,-0x21(%ebp)
    37f0:	50                   	push   %eax
    37f1:	6a 01                	push   $0x1
    37f3:	e8 2a fe ff ff       	call   3622 <write>
    37f8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    37fc:	83 c4 0c             	add    $0xc,%esp
    37ff:	8d 45 e0             	lea    -0x20(%ebp),%eax
    3802:	6a 01                	push   $0x1
    3804:	88 55 e0             	mov    %dl,-0x20(%ebp)
    3807:	50                   	push   %eax
    3808:	6a 01                	push   $0x1
    380a:	83 c3 01             	add    $0x1,%ebx
    380d:	31 ff                	xor    %edi,%edi
    380f:	e8 0e fe ff ff       	call   3622 <write>
    3814:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    3818:	83 c4 10             	add    $0x10,%esp
    381b:	84 d2                	test   %dl,%dl
    381d:	0f 85 6b ff ff ff    	jne    378e <vprintf.constprop.0+0x4e>
    3823:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3826:	5b                   	pop    %ebx
    3827:	5e                   	pop    %esi
    3828:	5f                   	pop    %edi
    3829:	5d                   	pop    %ebp
    382a:	c3                   	ret    
    382b:	90                   	nop
    382c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3830:	bf 25 00 00 00       	mov    $0x25,%edi
    3835:	e9 45 ff ff ff       	jmp    377f <vprintf.constprop.0+0x3f>
    383a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3840:	8d 7e 04             	lea    0x4(%esi),%edi
    3843:	31 c9                	xor    %ecx,%ecx
    3845:	8b 06                	mov    (%esi),%eax
    3847:	ba 0a 00 00 00       	mov    $0xa,%edx
    384c:	89 fe                	mov    %edi,%esi
    384e:	31 ff                	xor    %edi,%edi
    3850:	e8 5b fe ff ff       	call   36b0 <printint.constprop.1>
    3855:	e9 25 ff ff ff       	jmp    377f <vprintf.constprop.0+0x3f>
    385a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3860:	8b 06                	mov    (%esi),%eax
    3862:	8d 7e 04             	lea    0x4(%esi),%edi
    3865:	31 c9                	xor    %ecx,%ecx
    3867:	ba 10 00 00 00       	mov    $0x10,%edx
    386c:	89 fe                	mov    %edi,%esi
    386e:	31 ff                	xor    %edi,%edi
    3870:	e8 3b fe ff ff       	call   36b0 <printint.constprop.1>
    3875:	e9 05 ff ff ff       	jmp    377f <vprintf.constprop.0+0x3f>
    387a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3880:	83 ec 04             	sub    $0x4,%esp
    3883:	88 55 e1             	mov    %dl,-0x1f(%ebp)
    3886:	8d 45 e1             	lea    -0x1f(%ebp),%eax
    3889:	6a 01                	push   $0x1
    388b:	e9 77 ff ff ff       	jmp    3807 <vprintf.constprop.0+0xc7>
    3890:	8d 46 04             	lea    0x4(%esi),%eax
    3893:	83 ec 04             	sub    $0x4,%esp
    3896:	8b 3e                	mov    (%esi),%edi
    3898:	6a 01                	push   $0x1
    389a:	c6 45 e6 30          	movb   $0x30,-0x1a(%ebp)
    389e:	be 08 00 00 00       	mov    $0x8,%esi
    38a3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    38a6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    38a9:	50                   	push   %eax
    38aa:	6a 01                	push   $0x1
    38ac:	e8 71 fd ff ff       	call   3622 <write>
    38b1:	8d 45 e7             	lea    -0x19(%ebp),%eax
    38b4:	83 c4 0c             	add    $0xc,%esp
    38b7:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
    38bb:	6a 01                	push   $0x1
    38bd:	50                   	push   %eax
    38be:	6a 01                	push   $0x1
    38c0:	e8 5d fd ff ff       	call   3622 <write>
    38c5:	83 c4 10             	add    $0x10,%esp
    38c8:	90                   	nop
    38c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    38d0:	89 f8                	mov    %edi,%eax
    38d2:	83 ec 04             	sub    $0x4,%esp
    38d5:	c1 e7 04             	shl    $0x4,%edi
    38d8:	c1 e8 1c             	shr    $0x1c,%eax
    38db:	6a 01                	push   $0x1
    38dd:	0f b6 80 d8 52 00 00 	movzbl 0x52d8(%eax),%eax
    38e4:	88 45 e5             	mov    %al,-0x1b(%ebp)
    38e7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    38ea:	50                   	push   %eax
    38eb:	6a 01                	push   $0x1
    38ed:	e8 30 fd ff ff       	call   3622 <write>
    38f2:	83 c4 10             	add    $0x10,%esp
    38f5:	83 ee 01             	sub    $0x1,%esi
    38f8:	75 d6                	jne    38d0 <vprintf.constprop.0+0x190>
    38fa:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    38fd:	31 ff                	xor    %edi,%edi
    38ff:	e9 7b fe ff ff       	jmp    377f <vprintf.constprop.0+0x3f>
    3904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3908:	8b 3e                	mov    (%esi),%edi
    390a:	8d 46 04             	lea    0x4(%esi),%eax
    390d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    3910:	85 ff                	test   %edi,%edi
    3912:	74 50                	je     3964 <vprintf.constprop.0+0x224>
    3914:	0f b6 07             	movzbl (%edi),%eax
    3917:	84 c0                	test   %al,%al
    3919:	74 df                	je     38fa <vprintf.constprop.0+0x1ba>
    391b:	8d 75 e3             	lea    -0x1d(%ebp),%esi
    391e:	66 90                	xchg   %ax,%ax
    3920:	83 ec 04             	sub    $0x4,%esp
    3923:	83 c7 01             	add    $0x1,%edi
    3926:	88 45 e3             	mov    %al,-0x1d(%ebp)
    3929:	6a 01                	push   $0x1
    392b:	56                   	push   %esi
    392c:	6a 01                	push   $0x1
    392e:	e8 ef fc ff ff       	call   3622 <write>
    3933:	0f b6 07             	movzbl (%edi),%eax
    3936:	83 c4 10             	add    $0x10,%esp
    3939:	84 c0                	test   %al,%al
    393b:	75 e3                	jne    3920 <vprintf.constprop.0+0x1e0>
    393d:	eb bb                	jmp    38fa <vprintf.constprop.0+0x1ba>
    393f:	90                   	nop
    3940:	8b 06                	mov    (%esi),%eax
    3942:	83 ec 04             	sub    $0x4,%esp
    3945:	8d 7e 04             	lea    0x4(%esi),%edi
    3948:	6a 01                	push   $0x1
    394a:	89 fe                	mov    %edi,%esi
    394c:	31 ff                	xor    %edi,%edi
    394e:	88 45 e2             	mov    %al,-0x1e(%ebp)
    3951:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    3954:	50                   	push   %eax
    3955:	6a 01                	push   $0x1
    3957:	e8 c6 fc ff ff       	call   3622 <write>
    395c:	83 c4 10             	add    $0x10,%esp
    395f:	e9 1b fe ff ff       	jmp    377f <vprintf.constprop.0+0x3f>
    3964:	bf d0 52 00 00       	mov    $0x52d0,%edi
    3969:	b8 28 00 00 00       	mov    $0x28,%eax
    396e:	eb ab                	jmp    391b <vprintf.constprop.0+0x1db>

00003970 <fprintf>:
    3970:	55                   	push   %ebp
    3971:	89 e5                	mov    %esp,%ebp
    3973:	83 ec 08             	sub    $0x8,%esp
    3976:	8b 45 0c             	mov    0xc(%ebp),%eax
    3979:	8d 55 10             	lea    0x10(%ebp),%edx
    397c:	e8 bf fd ff ff       	call   3740 <vprintf.constprop.0>
    3981:	c9                   	leave  
    3982:	c3                   	ret    
    3983:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003990 <printf>:
    3990:	55                   	push   %ebp
    3991:	89 e5                	mov    %esp,%ebp
    3993:	83 ec 08             	sub    $0x8,%esp
    3996:	8b 45 08             	mov    0x8(%ebp),%eax
    3999:	8d 55 0c             	lea    0xc(%ebp),%edx
    399c:	e8 9f fd ff ff       	call   3740 <vprintf.constprop.0>
    39a1:	c9                   	leave  
    39a2:	c3                   	ret    
    39a3:	66 90                	xchg   %ax,%ax
    39a5:	66 90                	xchg   %ax,%ax
    39a7:	66 90                	xchg   %ax,%ax
    39a9:	66 90                	xchg   %ax,%ax
    39ab:	66 90                	xchg   %ax,%ax
    39ad:	66 90                	xchg   %ax,%ax
    39af:	90                   	nop

000039b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    39b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    39b1:	a1 c0 5c 00 00       	mov    0x5cc0,%eax
{
    39b6:	89 e5                	mov    %esp,%ebp
    39b8:	57                   	push   %edi
    39b9:	56                   	push   %esi
    39ba:	53                   	push   %ebx
    39bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    39be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    39c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    39c8:	39 c8                	cmp    %ecx,%eax
    39ca:	8b 10                	mov    (%eax),%edx
    39cc:	73 32                	jae    3a00 <free+0x50>
    39ce:	39 d1                	cmp    %edx,%ecx
    39d0:	72 04                	jb     39d6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    39d2:	39 d0                	cmp    %edx,%eax
    39d4:	72 32                	jb     3a08 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    39d6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    39d9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    39dc:	39 fa                	cmp    %edi,%edx
    39de:	74 30                	je     3a10 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    39e0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    39e3:	8b 50 04             	mov    0x4(%eax),%edx
    39e6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    39e9:	39 f1                	cmp    %esi,%ecx
    39eb:	74 3a                	je     3a27 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    39ed:	89 08                	mov    %ecx,(%eax)
  freep = p;
    39ef:	a3 c0 5c 00 00       	mov    %eax,0x5cc0
}
    39f4:	5b                   	pop    %ebx
    39f5:	5e                   	pop    %esi
    39f6:	5f                   	pop    %edi
    39f7:	5d                   	pop    %ebp
    39f8:	c3                   	ret    
    39f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3a00:	39 d0                	cmp    %edx,%eax
    3a02:	72 04                	jb     3a08 <free+0x58>
    3a04:	39 d1                	cmp    %edx,%ecx
    3a06:	72 ce                	jb     39d6 <free+0x26>
{
    3a08:	89 d0                	mov    %edx,%eax
    3a0a:	eb bc                	jmp    39c8 <free+0x18>
    3a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    3a10:	03 72 04             	add    0x4(%edx),%esi
    3a13:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3a16:	8b 10                	mov    (%eax),%edx
    3a18:	8b 12                	mov    (%edx),%edx
    3a1a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3a1d:	8b 50 04             	mov    0x4(%eax),%edx
    3a20:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3a23:	39 f1                	cmp    %esi,%ecx
    3a25:	75 c6                	jne    39ed <free+0x3d>
    p->s.size += bp->s.size;
    3a27:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    3a2a:	a3 c0 5c 00 00       	mov    %eax,0x5cc0
    p->s.size += bp->s.size;
    3a2f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3a32:	8b 53 f8             	mov    -0x8(%ebx),%edx
    3a35:	89 10                	mov    %edx,(%eax)
}
    3a37:	5b                   	pop    %ebx
    3a38:	5e                   	pop    %esi
    3a39:	5f                   	pop    %edi
    3a3a:	5d                   	pop    %ebp
    3a3b:	c3                   	ret    
    3a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003a40 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3a40:	55                   	push   %ebp
    3a41:	89 e5                	mov    %esp,%ebp
    3a43:	57                   	push   %edi
    3a44:	56                   	push   %esi
    3a45:	53                   	push   %ebx
    3a46:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3a49:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    3a4c:	8b 15 c0 5c 00 00    	mov    0x5cc0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3a52:	8d 78 07             	lea    0x7(%eax),%edi
    3a55:	c1 ef 03             	shr    $0x3,%edi
    3a58:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    3a5b:	85 d2                	test   %edx,%edx
    3a5d:	0f 84 9d 00 00 00    	je     3b00 <malloc+0xc0>
    3a63:	8b 02                	mov    (%edx),%eax
    3a65:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    3a68:	39 cf                	cmp    %ecx,%edi
    3a6a:	76 6c                	jbe    3ad8 <malloc+0x98>
    3a6c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    3a72:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3a77:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    3a7a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    3a81:	eb 0e                	jmp    3a91 <malloc+0x51>
    3a83:	90                   	nop
    3a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3a88:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    3a8a:	8b 48 04             	mov    0x4(%eax),%ecx
    3a8d:	39 f9                	cmp    %edi,%ecx
    3a8f:	73 47                	jae    3ad8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3a91:	39 05 c0 5c 00 00    	cmp    %eax,0x5cc0
    3a97:	89 c2                	mov    %eax,%edx
    3a99:	75 ed                	jne    3a88 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    3a9b:	83 ec 0c             	sub    $0xc,%esp
    3a9e:	56                   	push   %esi
    3a9f:	e8 e6 fb ff ff       	call   368a <sbrk>
  if(p == (char*)-1)
    3aa4:	83 c4 10             	add    $0x10,%esp
    3aa7:	83 f8 ff             	cmp    $0xffffffff,%eax
    3aaa:	74 1c                	je     3ac8 <malloc+0x88>
  hp->s.size = nu;
    3aac:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3aaf:	83 ec 0c             	sub    $0xc,%esp
    3ab2:	83 c0 08             	add    $0x8,%eax
    3ab5:	50                   	push   %eax
    3ab6:	e8 f5 fe ff ff       	call   39b0 <free>
  return freep;
    3abb:	8b 15 c0 5c 00 00    	mov    0x5cc0,%edx
      if((p = morecore(nunits)) == 0)
    3ac1:	83 c4 10             	add    $0x10,%esp
    3ac4:	85 d2                	test   %edx,%edx
    3ac6:	75 c0                	jne    3a88 <malloc+0x48>
        return 0;
  }
}
    3ac8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    3acb:	31 c0                	xor    %eax,%eax
}
    3acd:	5b                   	pop    %ebx
    3ace:	5e                   	pop    %esi
    3acf:	5f                   	pop    %edi
    3ad0:	5d                   	pop    %ebp
    3ad1:	c3                   	ret    
    3ad2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    3ad8:	39 cf                	cmp    %ecx,%edi
    3ada:	74 54                	je     3b30 <malloc+0xf0>
        p->s.size -= nunits;
    3adc:	29 f9                	sub    %edi,%ecx
    3ade:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3ae1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    3ae4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    3ae7:	89 15 c0 5c 00 00    	mov    %edx,0x5cc0
}
    3aed:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3af0:	83 c0 08             	add    $0x8,%eax
}
    3af3:	5b                   	pop    %ebx
    3af4:	5e                   	pop    %esi
    3af5:	5f                   	pop    %edi
    3af6:	5d                   	pop    %ebp
    3af7:	c3                   	ret    
    3af8:	90                   	nop
    3af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    3b00:	c7 05 c0 5c 00 00 c4 	movl   $0x5cc4,0x5cc0
    3b07:	5c 00 00 
    3b0a:	c7 05 c4 5c 00 00 c4 	movl   $0x5cc4,0x5cc4
    3b11:	5c 00 00 
    base.s.size = 0;
    3b14:	b8 c4 5c 00 00       	mov    $0x5cc4,%eax
    3b19:	c7 05 c8 5c 00 00 00 	movl   $0x0,0x5cc8
    3b20:	00 00 00 
    3b23:	e9 44 ff ff ff       	jmp    3a6c <malloc+0x2c>
    3b28:	90                   	nop
    3b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    3b30:	8b 08                	mov    (%eax),%ecx
    3b32:	89 0a                	mov    %ecx,(%edx)
    3b34:	eb b1                	jmp    3ae7 <malloc+0xa7>
