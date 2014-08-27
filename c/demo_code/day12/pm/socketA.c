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

	/*	1.建立socket	*/
		int fd=socket(AF_INET,SOCK_DGRAM,0);
		if(fd == -1)
		{
			perror("socket failure"),exit(-1);
		}
		printf("建立socket成功!\n");

	/*	2.绑定地址		*/
		struct sockaddr_in addr={};
		addr.sin_family=AF_INET;
		//	对应的端口
		addr.sin_port=htons(8888);

		// 把IP地址进行转换并且存放到结构体对应的变量中
		inet_aton("192.168.1.188",&(addr.sin_addr));

		// 绑定
		int r = bind(fd,(struct sockaddr *)&addr,sizeof(addr));
		if(r==-1)
		{
			perror("bind failure\n"),close(fd),exit(-1);	
		}
		printf("地址绑定成功!\n");
		
	/*	3.循环接收客户数据，并返发一个信息		*/
		char buf[256]={};
		struct sockaddr_in caddr={};
		socklen_t len=sizeof(caddr);
		while(1)
		{
			// 读取数据 来判断是否有连接请求	
			//r = read(fd,buf,sizeof(buf)-1);

			r=recvfrom(fd,buf,sizeof(buf)-1,0,(struct sockaddr *)&caddr,&len);
			if( r<= 0)
			{
				break;
			}
			buf[r]=0;
			printf("来自%s:%u的数据::%s\n",
					inet_ntoa(caddr.sin_addr)		
					,ntohs(caddr.sin_port)
					,buf);

			//返发数据
			sendto(fd,"Cow Boy",strlen("Cow Boy"),0,
					(struct sockaddr *)&caddr,sizeof(caddr));
		}
		
	/*  4.通过信号关闭socket连接		*/
		close(fd);	

}
