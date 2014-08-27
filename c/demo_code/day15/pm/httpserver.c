#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

main()
{

	int fd=socket(AF_INET,SOCK_STREAM,0);

	/* 绑定地址	*/
	struct sockaddr_in addr={};
	addr.sin_family=AF_INET;
	addr.sin_port=htons(10000);
	addr.sin_addr.s_addr=inet_addr("192.168.1.188");

	int r;
	r=bind(fd,(struct sockaddr *)&addr,sizeof(addr));

	r=listen(fd,10);

	int cfd;
	cfd=accept(fd,0,0);

	/* 定义8K 的缓冲	*/
	char buf[8*1024]={};

	/*
	while(1)
	{
		r=read(cfd,buf,sizeof(buf)-1);
		if(r<=0) break;
		printf("=================\n");
		printf("%s\n",buf);
	}
	*/

	char *pagebody="<html>"
				   "<body>"
				   "<font color=red size=27>"
				   "Hi Boy"
				   "</font>"
				   "</body>"
				   "</html>";

	sprintf(buf,
			"HTTP/1.1 200 OK\r\n",
			"Server: myserver\r\n"
			"Content-Type: text/html\r\n"
			"Content-Length: %u\r\n"
			"Connection: keep-alive\r\n"
			"\r\n"
			"%s",
			strlen(pagebody),
			pagebody);

	send(cfd,buf,strlen(buf),0);

	close(cfd);

	close(fd);
	/*
	协议://ip:port/资源路径
	http://192.168.1.188:10000/index.html
	*/

}
