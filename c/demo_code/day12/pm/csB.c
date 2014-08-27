#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <linux/un.h>
#include <netinet/in.h>
#include <arpa/inet.h>

main()
{

	/* 1.建立socket		*/
		//int fd=socket(AF_FILE,SOCK_STREAM,0);
		int fd=socket(AF_INET,SOCK_STREAM,0);

	/* 2 .连接socket	*/

		/*
		struct sockaddr_un addr={};
		addr.sun_family=AF_FILE;
		sprintf(addr.sun_path,"%s","s.socket");
		*/
		struct sockaddr_in addr={};
		addr.sin_family=AF_INET;
		addr.sin_port=htons(11111);
		inet_aton("192.168.1.188",&addr.sin_addr);

		connect(fd,(struct sockaddr *)&addr,sizeof(addr));

	/* 3.读取socket返回的数据	*/
		char buf[50]={};
		int r;
		r=read(fd,buf,sizeof(buf)-1);
		buf[r]=0;

		printf("::%s\n",buf);
		
	/* 4.关闭socket		*/
		close(fd);

}
