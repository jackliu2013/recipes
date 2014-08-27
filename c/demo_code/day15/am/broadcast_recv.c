#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

/*
绑定广播地址
端口要统一
*/
main()
{
	int fd=socket(AF_INET,SOCK_DGRAM,0);

	/* 设置地址重用	*/
	/*
	int b=1;
	setsockopt(fd,SOL_SOCKET,SO_REUSEADDR,&b,sizeof(b));
	*/


	/*	绑定广播地址	*/
	struct sockaddr_in addr={};
	addr.sin_family=AF_INET;
	addr.sin_port=htons(8888);
	addr.sin_addr.s_addr=inet_addr("192.168.1.255");

	int r=bind(fd,(struct sockaddr *)&addr,sizeof(addr));	

	char buf[1024]={};
	int i=0;
	for(;i<100;i++)
	{
		recv(fd,buf,sizeof(buf)-1,0);	
		printf("::%s\n",buf);
	}
	
	close(fd);
}
