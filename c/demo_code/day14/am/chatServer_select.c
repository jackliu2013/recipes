#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/select.h>
#include <sys/socket.h>
#include <string.h>
#include <netinet/in.h>
#include <arpa/inet.h>

main()
{
	int serverfd;	//服务器socket描述符
	int r;		//存放函数返回值

	int allfds[100];	//存放所有连接的客户描述符号
	int idx;		//连接的最大数

	int maxfd;	//最大描述符号
	fd_set fds;		//监视的描述符集合与有数据的描述符集合
	char  buf[1024];	//读取客户传递的聊天信息


	/*	1.建立socket								*/
	serverfd=socket(AF_INET,SOCK_STREAM,0);
	if(serverfd==-1)
	{
		perror("socket"),exit(-1);
	}
	printf("socket ok!\n");

	/*	2.绑定地址									*/
	struct sockaddr_in addr={};
	addr.sin_family=AF_INET;
	addr.sin_port=htons(9999);
	addr.sin_addr.s_addr=inet_addr("192.168.1.188");
	r=bind(serverfd,(struct sockaddr *)&addr,sizeof(addr));
	if(r==-1)
	{
		perror("bind"),close(serverfd),exit(-1);
	}
	printf("bind ok!\n");

	/*	3.监听										*/
	r=listen(serverfd,10);
	if(r==-1)
	{
		perror("listen"),close(serverfd),exit(-1);
	}
	printf("listen ok!\n");


	int i;
	//先清空
	for(i=0;i<100;i++)
	{
			allfds[i]=-1;
	}
	idx=0;
	/*	4.循环调用select来监视描述符号的改变		*/
	while(1)
	{
		/*	4.1 初始化需要监视的数据*/
		maxfd=-1;	//初始化	
		FD_ZERO(&fds);	//清空fds
			/*加入serverfd到监视的描述符集合*/
		FD_SET(serverfd,&fds);
		maxfd=serverfd>maxfd?serverfd:maxfd;
			/*加入连接描述符到监视集合*/
		for(i=0;i<100;i++)
		{
			if(allfds[i]!=-1)
			{
				FD_SET(allfds[i],&fds);
				maxfd=allfds[i]>maxfd?allfds[i]:maxfd;
			}
		}
		/*	4.2 监视				*/
		r=select(maxfd+1,&fds,0,0,0);	
		if(r==-1)
		{
			break;//中断跳出循环
		}
		printf("改变数:%d\n",r);

	/*	5.判定serverfd是否在里面*/
		/*	5.1如果serverfd在，就接收新连接的客户 */
		if(FD_ISSET(serverfd,&fds))
		{
			allfds[idx]=accept(serverfd,0,0);	
			idx ++;
		}

	/* 	6.判定哪些连接描述符在返回的改变的集合中	*/
		for(i=0;i<100;i++)
		{
			if( (allfds[i]!=-1) && (FD_ISSET(allfds[i],&fds)) )
			{
				/*	6.1 如果在，则读取数据	*/
				bzero(buf,sizeof(buf));
				r=read(allfds[i],buf,sizeof(buf)-1);
				if(r==-1){
					printf("有人故障退出!\n");
					close(allfds[i]);
					allfds[i]=-1;
				}
				if(r==0){
					printf("有人关闭退出!\n");
					close(allfds[i]);
					allfds[i]=-1;
				}
				if(r>0){
				/*	6.2 广播数据			*/
					buf[r]=0;
					printf("来自客户的信息:%s\n",buf);
					int j;
					for(j=0;j<100;j++)
					{
						if(allfds[j]!=-1)
						{
							write(allfds[j],buf,r);	
						}
					}
				}

			}
		}
	}
	close(serverfd);

}
