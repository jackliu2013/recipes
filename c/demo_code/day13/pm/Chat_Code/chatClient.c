#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/socket.h>
#include <signal.h>
#include <arpa/inet.h>
#include <netinet/in.h>

main()
{
	/*	1.建立socket	*/
	int fd=socket(AF_INET,SOCK_STREAM,0);
	if(fd == -1){
		perror("socket"),exit(-1);
	}
	printf("socket建立成功!\n");

	/*	2.连接服务器	*/
	struct sockaddr_in addr={};
	addr.sin_family=AF_INET;
	addr.sin_port=htons(9999);
	//inet_aton("192.168.1.188",&addr.sin_addr);
	addr.sin_addr.s_addr=inet_addr("192.168.1.188");
	int r;
	r=connect(fd,(struct sockaddr *)&addr,sizeof(addr));
	if(r == -1){
		perror("connect"),close(fd),exit(-1);
	}
	printf("连接服务器成功,可以聊天!\n");

	/*	3.建立子进程	*/

	if(fork())
	{
		//父进程
		char buf[256]={};
		while(1)
		{
			/* 4.1 输入数据		*/
			//从标准输入读取字符
			read(0,buf,sizeof(buf)-1);
			if(r<=0){
				break;
			}
			/*	4.2发送数据		*/	
			write(fd,buf,r);
		}

	}
	else
	{
		//子进程
		char rcvbuf[256]={};
		while(1)
		{
			/*	5.1	接收数据	*/
			r =read(fd,rcvbuf,sizeof(rcvbuf)-1);
			if(r<=0){
				printf("与服务器断开连接!\n");
				close(fd);
				exit(-1);	//退出子进程
			}
			printf(":%s\n",rcvbuf);
		}

	}

}
