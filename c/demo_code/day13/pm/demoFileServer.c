#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#define BUF_LEN 1024

// 本程序还是处理 单客户连接
main()
{

	/* 	1.建立socket		*/
		int fd=socket(AF_INET,SOCK_STREAM,0);
		if(fd==-1)
		{
			perror("socket");
			exit(-1);
		}
		printf("socket ok!\n");

	/*  2.绑定地址			*/
		struct sockaddr_in addr={};
		addr.sin_family=AF_INET;
		addr.sin_port=htons(9998);
		inet_aton("192.168.1.188",&addr.sin_addr);
		int r;
		r = bind(fd,(struct sockaddr *)&addr,sizeof(addr));
		if(r==-1)
		{
			perror("socket");
			close(fd);
			exit(-1);
		}
		printf("bind ok!\n");
	/* 3.监听				*/
		r = listen(fd,10);	
		if(r==-1)
		{
			perror("socket");
			close(fd);
			exit(-1);
		}
		printf("listen ok!\n");	

	/* 4.接收一个客户		*/
		int cfd;
		cfd=accept(fd,0,0);
		if(cfd==-1)
		{
			perror("socket");
			close(fd);
			exit(-1);
		}
		printf("开始接收传送文件!\n");

	/* 5.循环接收客户传递的文件		*/
		/* 5.1	接收文件名长度		*/
		  int len;	
		  r=recv(cfd,&len,sizeof(int),MSG_WAITALL);
		  printf("文件名长度:%u\n",len);

		/* 5.2 接收文件名		*/
			char buf[BUF_LEN];	//接收数据的缓冲
			bzero(buf,BUF_LEN);
			recv(cfd,buf,len,MSG_WAITALL);
			printf("传递的文件名:%s\n",buf);
			int filefd = open(buf,O_RDWR|O_CREAT,0666);
			//异常处理此处忽略

		/* 5.3 接收文件长度		*/
			recv(cfd,&len,sizeof(int),MSG_WAITALL); 	
			printf("文件长度是:%d\n",len);	

		/* 5.4 接收文件内容		*/
			int count = len/BUF_LEN ;
			int remainder = len%BUF_LEN ;
			int i;
			for(i=0;i<count;i++)
			{
				recv(cfd,buf,BUF_LEN,MSG_WAITALL);
				//把接收到的数据写入文件
				write(filefd,buf,BUF_LEN);
			}
			if(remainder>0)
			{
				recv(cfd,buf,remainder,MSG_WAITALL);
				write(filefd,buf,remainder);
			}
			close(filefd);
	/* 6.关闭客户			*/
			close(cfd);	
			
	/* 7.关闭socket			*/
			close(fd);

}
