#include <stdio.h>
#include <sys/socket.h>
#include <netdb.h>

main()
{
	setprotoent(0);

	struct protoent *ent;

	while(1)
	{

		ent=getprotoent();
		if(!ent) break;
		printf("%s:%u\n",
					ent->p_name,
					ent->p_proto);
	}

	// 	根据协议名得到协议编号
	struct protoent *tent;
	tent=getprotobyname("tcp");
	printf("%u\n",tent->p_proto);

}
