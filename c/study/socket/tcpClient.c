#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

//	

main()
{

	/* 1. create AF_INET socket	*/
	int fd=socket(AF_INET,SOCK_STREAM,0);
	if(fd == -1)
	{
		perror("socket"),exit(-1);
    }
	printf("socket OK!\n");

	/* 2. connect to server */
	struct sockaddr_in addr={};
	addr.sin_family=AF_INET;
	addr.sin_port=htons(11101);
	//addr.sin_addr.s_addr==inet_addr("192.168.1.188");
	inet_aton("192.168.100.202",&addr.sin_addr);	

	int r;
	r = connect(fd,(struct sockaddr *)&addr,sizeof(addr));
	if(r == -1)
	{
		perror("connect"),
        close(fd),
        exit(-1);
	}
	/* 3.begin send data */
	int i;
	for(i=0;i<10;i++)
	{
		write(fd,"Hello TCP Server\n",17);
	}
    printf("send data ok!\n");
		
	/* 4.close socket			*/
	close(fd);	

}
