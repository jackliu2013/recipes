#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/socket.h>
#include <linux/un.h>
#include <netinet/in.h>
#include <arpa/inet.h>

main()
{

	/* 1.建立socket	:socket		*/
		//	int fd=socket(AF_FILE,SOCK_STREAM,0);	//以本地文件形式的socket
		int fd=socket(AF_INET,SOCK_STREAM,0);	//以网络形式的socket
		if(fd==-1)
		{
			perror("socket"),exit(-1);
		}
		printf("建立socket成功!\n");

	/* 2.绑定地址	:bind		*/
		int r;

		// 以本地文件格式
		/* 本地文件格式
		struct sockaddr_un addr={};
		addr.sun_family=AF_FILE;
		sprintf(addr.sun_path,"%s","s.socket");
		*/

		//以网络形式的socket
		struct sockaddr_in addr={};
		addr.sin_family=AF_INET;
		addr.sin_port=htons(11111);
		inet_aton("192.168.1.188",&addr.sin_addr);

		r = bind(fd,(struct sockaddr *)&addr,sizeof(addr));
		if(r==-1)
		{
			perror("bind"),close(fd),exit(-1);
		}
		printf("绑定socket成功!\n");

	/* 3.监听连接	:listen		*/
		r=listen(fd,10);
		if(r==-1)
		{
			perror("listen"),close(fd),exit(-1);
		}
		printf("启动监听成功!\n");

		while(1)
		{
	/* 4.返回监听到的客户连接	:accept		*/
			int cfd;//连接描述符号
			cfd=accept(fd,0,0);
			if(cfd==-1)
			{
				break;
			}
			printf("有客户请求连接:%d\n",cfd);
	/* 5.通过返回的连接,只与该客户交换数据	:read/write	系列函数	*/
			write(cfd,"Hello",5);	
	/* 6.关闭客户连接	:close		*/
			close(cfd);
		}

	/* 7.关闭socket		:close		*/
		close(fd);

}
