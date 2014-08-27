#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

//	使用很大缓冲接收客户数据
//	每次只处理一个客户

main()
{

	/* 1.建立socket连接		*/
		int fd=socket(PF_INET,SOCK_STREAM,0);
		if(fd == -1)
		{
			perror("socket"),exit(-1);
		 }
		printf("scoket OK!\n");

	/* 2.绑定地址			*/
		struct sockaddr_in addr={};
		addr.sin_family=PF_INET;
		addr.sin_port=htons(9999);
		//addr.sin_addr.s_addr==inet_addr("192.168.1.188");
		inet_aton("192.168.1.188",&addr.sin_addr);	

		int r;
		r = bind(fd,(struct sockaddr *)&addr,sizeof(addr));
		if(r == -1)
		{
			perror("bind"),close(fd),exit(-1);
		 }
		printf("bind OK!\n");

	/* 3.监听				*/
		r = listen(fd,10);
		if(r == -1)
		{
			perror("listen"),close(fd),exit(-1);
		 }
		printf("listen OK!\n");

	/* 4.接收客户连接		*/
		// cfd连接描述符
		int cfd=accept(fd,0,0);
		if(cfd == -1)
		{
			perror("accept"),close(fd),exit(-1);
		}
		printf("accept OK!\n");

	/* 5.接收客户数据 		*/
		char buf[10*1024]={};
		while(1)
		{
			r = read(cfd,buf,sizeof(buf)-1);
			if(r==0)
			{
				printf("客户退出!\n");
				break;
			}
			if(r>0)
			{
				//buf[r]=0;
				printf("::%s\n",buf);
			}
			if(r==-1)
			{
				printf("网络故障!\n");
				break;
			}
		}
		
	/* 6.关闭客户(对应于第4步)	*/
		close(cfd);	
		
	/* 7.关闭socket			*/
		close(fd);	

}
