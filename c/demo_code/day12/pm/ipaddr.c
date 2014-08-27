#include <stdio.h>
#include <arpa/inet.h>

main()
{
	char *ip="192.168.0.26";

	//ip的整数表示 
	struct in_addr sip={};
	//主机IP的整数表示
	struct in_addr hip={};
	//网络IP的整数表示
	struct in_addr nip={};

	//ip在计算机内部的整数表示 无符号整数
	sip.s_addr=inet_addr(ip);
	printf("%u\n",sip.s_addr);

	//ip在计算机内部的整数表示 无符号整数
	inet_aton(ip,&sip);
	printf("%u\n",sip.s_addr);

	//得到主机标识
	hip.s_addr=inet_lnaof(sip);
	//得到网络标识
	nip.s_addr=inet_netof(sip);
	

	printf("主机标识:%s\n",inet_ntoa(hip));
	printf("网络标识:%s\n",inet_ntoa(nip));

}
