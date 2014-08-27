#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

main()
{

	int fd=socket(AF_INET,SOCK_STREAM,0);
	
	/* 要抓取的网站的IP和端口 */
	struct sockaddr_in addr;	
	addr.sin_family=AF_INET;
	addr.sin_port=htons(80);
	/* 百度的IP 	*/
	addr.sin_addr.s_addr=inet_addr("192.168.1.107");

	/* 连接服务器	*/
	int r;
	r=connect(fd,(struct sockaddr *)&addr,sizeof(addr));

	/*	拼接HTTP的请求报文	*/
	char buf[1024];
	sprintf(buf,
			"GET /Default.htm HTTP/1.1\r\n"
			"Host: 192.168.1.107:80\r\n"	
			"User-Agent: Mozilla/5.0\r\n"
			"Accept: text/html,image/png\r\n"
			"Accept-Language: zh-cn,zh\r\n"
			"Accept-Charset: gb2312,utf-8\r\n"
			"Keep-Alive: 300\r\n"
			"Connection: keep-alive\r\n"
			"\r\n");

	write(fd,buf,strlen(buf));
	char recvbuf[4*1024];
	while(1)
	{
		r=read(fd,recvbuf,sizeof(recvbuf)-1);
		if(r<=0) break;
		recvbuf[r]=0;
		printf("%s\n",recvbuf);
	}

	close(fd);
}
