/*
*此程序需要root才能执行
*/
#include <stdio.h>
#include <sys/socket.h>
#include <linux/if_ether.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <netinet/udp.h>
#include <arpa/inet.h>
#include <netinet/ip.h>

main()
{
	//vi /etc/protocols 查看raw原生包支持的协议
	int fd=socket(AF_INET,SOCK_RAW,6);		
	//int fd=socket(AF_INET,SOCK_RAW,17);		
	if(fd==-1){
		perror("socket"),exit(-1);
	}
	int b=0;
	setsockopt(fd,IPPROTO_IP,IP_HDRINCL,&b,sizeof(b));

	int r;
	char buf[1024];
	
	struct udphdr *udp;
	struct iphdr *hdr;
	
	while(1)
	{

		r=read(fd,buf,sizeof(buf)-1);	
	 	hdr=(struct iphdr *)buf;
	 	buf[r]=0;  
	
		udp=(struct udphdr *)(buf+sizeof(struct iphdr));
		printf(":%u,%u\n",udp->source,udp->dest);
		printf(":%u,%u\n",
				ntohs(udp->source),
		 		ntohs(udp->dest));	
		struct in_addr addr;
		addr.s_addr=hdr->daddr;
		printf("%s\n",inet_ntoa(addr));

	}

	
	close(fd);
}
