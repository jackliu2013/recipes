/*
1.获取所有接口
2.获取某个接口的地址，广播地址,MTU
*/

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <netinet/in.h>
#include <arpa/inet.h>

main()
{
	struct ifreq reqs[5]; /* 存放返回的接口	*/
	struct ifconf conf;

	conf.ifc_len=sizeof(reqs);
/*	conf.ifc_ifcu.ifcu_req=reqs;与下面行等价	*/
	conf.ifc_req=reqs;	

	int fd = socket(AF_INET,SOCK_STREAM,0);
	int r=ioctl(fd,SIOCGIFCONF,&conf);
	if(!r){
		printf("获取成功!\n");
	}

	int len=conf.ifc_len/sizeof(struct ifreq);
	printf("接口个数:%d\n",len);
	int i;
	for(i=0;i<len;i++)
	{
		printf("接口%d:%s\n",i+1,reqs[i].ifr_name);
	}

/* 获取eth0的IP地址与广播地址	*/
	struct ifreq req;
	/* 输入的是接口名字，输出接口的各种参数	*/
	memcpy(req.ifr_name,"eth0",5);
	ioctl(fd,SIOCGIFADDR,&req);
	
	struct sockaddr_in *addr=
	(struct sockaddr_in*)&req.ifr_addr ;
	
	printf("地址:%s\n",inet_ntoa(addr->sin_addr));

	close(fd);
}
