#include <stdio.h>
#include <netdb.h>
#include <sys/socket.h>
#include <sys/utsname.h>


main()
{

	//参数主要对域名查找设置有效,对本地/etc/hosts没有意义
	sethostent(1);

	struct hostent *ent;

	while(1)
	{
		ent = gethostent();
		if(!ent) break;
		printf(":%s:%hhu.%hhu.%hhu.%hhu\n",
		//printf(":%s:%u.%u.%u.%u\n",
				ent->h_name,
				ent->h_addr[0],
				ent->h_addr[1],
				ent->h_addr[2],
				ent->h_addr[3]);
	}

	endhostent();

	/////////////////////////////////
	struct utsname name;
	uname(&name);
	printf("%s\n",name.sysname);
	printf("%s\n",name.nodename);
	printf("%s\n",name.release);
	printf("%s\n",name.version);
	printf("%s\n",name.machine);
	//printf("%s\n",name.domainname);

	//////////////////////////////
	struct hostent *ipent;
	ipent=gethostbyname("www.baidu.com");	
	printf("%s:%hhu.%hhu.%hhu.%hhu\n",
			ipent->h_name,
			ipent->h_addr[0],
			ipent->h_addr[1],
			ipent->h_addr[2],
			ipent->h_addr[3]);
	
}
