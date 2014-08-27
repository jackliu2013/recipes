#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <signal.h>
#include <sys/mman.h>

main()
{

		/* 允许100个用户连接	*/
		int *fds=mmap(0,getpagesize(),
						PROT_READ|PROT_WRITE,
						MAP_ANONYMOUS|MAP_SHARED,0,0);;

		int i;
		//bzero(fds,sizeof(fds[100]));
		/* fds[100]初始化为-1	*/
		for(i=0;i<100;i++){
			fds[i]=-1;
		}
		
		int cfd;	//客户描述符，存放客户端连接描述符号
		int idx=0;	//指示客户的个数

		/*	1.建立socket	*/
		int serverfd=socket(AF_INET,SOCK_STREAM,0);
		if(serverfd == -1){
			perror("socket"),exit(-1);
		}
		printf("建立服务器socket!\n");

		/*	2.绑定地址		*/
		struct sockaddr_in addr={};
		addr.sin_family=AF_INET;
		addr.sin_port=htons(9999);
		inet_aton("192.168.1.188",&addr.sin_addr);
		int r;
		r = bind(serverfd,(struct sockaddr *)&addr,sizeof(addr));
		if(r == -1){
			perror("bind"),close(serverfd),exit(-2);
		}
		printf("服务器绑定地址成功!\n");
		
		/*	3.监听			*/
		r = listen(serverfd,10);
		if(r == -1){
			perror("listen"),close(serverfd),exit(-3);
		}
		printf("服务器监听成功!,开始等待客户连接.....\n");

		/* 定义结构体来存放请求客户端的IP地址	*/
		struct sockaddr_in cdr={};
		socklen_t soc_len=sizeof(cdr);

		// 开始处理死循环
		while(1){
			/*	4.接收客户连接	*/
			
			//接收客户连接，并存储客户端的IP
			cfd=accept(serverfd,(struct sockaddr *)&cdr,&soc_len);
			if(cfd==-1){
				//服务器崩溃
				close(serverfd);
				printf("服务器崩溃!\n");
				//使用信号通知子进程也结束关闭
				//卸载共享内存
				munmap(fds,getpagesize());
				exit(-1);

				break;
			}
			fds[Idx]=cfd;			
			printf("有人连接:%s\n",inet_ntoa(cdr.sin_addr));
			
			/*	5.建立子进程	*/
			if(fork())
			{
				//父进程
				Idx ++; 	// 比较重要，这一步最好放在fork后
				continue;	//continue 来使父进程一致做死循环
			}
			else
			{
				//子进程
				char buf[256];
				//子进程死循环处理 6 7 一旦跳出循环则退出子进程
				while(1)
				{

					/*	6.子进程接收客户数据	*/
					r=read(cfd,buf,sizeof(buf)-1);
					if(r==0)
					{
						fds[Idx]=-1;
						close(cfd);
						printf("有客户退出!\n");
						break;
					}
					if(r == -1)
					{
						close(fds[idx]);
						fds[idx]=-1;
						close(cfd);
						printf("网络故障!\n");
						break;
					}
					if(r>0)
					{
						/*	7.子进程广播数据	*/
						buf[r]=0;
						printf("::%s\n",buf);
						for(i=0;i<100;i++)
						{
							if(fds[i] != -1)
							{
								write(fds[i],buf,r);
								//这里其实也可以处理下异常
							}

						}
					}

				}
			
				exit(0);
			}

		}

}
