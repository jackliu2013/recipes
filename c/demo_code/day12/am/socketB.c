#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

main()
{
	/* 1.建立socket 	*/
		int fd=socket(AF_INET,SOCK_DGRAM,0);
		if(fd == -1)
		{
			perror("sock"),exit(-1);
		}
		printf("建立socket成功!\n");

	/* 2.连接到目标socket		*/
		struct sockaddr_in addr={};	
		addr.sin_family=AF_INET;
		addr.sin_port=htons(8888);
		inet_aton("192.168.1.188",&addr.sin_addr);
		int r;

		/*
		r=connect(fd,(struct sockaddr *)&addr,sizeof(addr));
		if(r==-1)
		{
			perror("connect失败!\n");
			close(fd);
			exit(-1);
		}
		printf("连接成功!\n");
		*/

	/* 3.输入数据并发送		*/

		while(1)
		{
			char buf[256]={};
		
			// 从标准键盘输入
			r=read(0,buf,sizeof(buf)-1);
			if(r<=0)
			{
				printf("输入失败\n");
			}
			else
			{
				//把数据写到socket
				//write(fd,buf,r);
				sendto(fd,buf,r,0,
						(struct sockaddr *)&addr,sizeof(addr));

				//从socket读取数据
				r = read(fd,buf,sizeof(buf));
				buf[r]=0;
				printf("::%s\n",buf);
			}
		}

	/* 4.关闭连接		*/
		close(fd);	
}
