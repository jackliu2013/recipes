#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <signal.h>
#include <sys/mman.h>
#include <pthread.h>

/*	 全局变量	*/
int *fds;
int serverfd;
int cfd;	//客户描述符，存放客户端连接描述符号
int idx=0;	//指示客户的个数

/*  线程处理函数--处理连接请求	*/
void *getconn_run(void *data)
{
				char buf[256];
				int r;
				//线程死循环处理 6 7 一旦跳出循环则退出线程
				int ccfd=*(int *)data;
				while(1)
				{

					/*	6.线程接收客户数据	*/
					r=read(cfd,buf,sizeof(buf)-1);
					if(r==0)
					{
						*(int *)data=-1;
						close(ccfd);
						printf("有客户退出!\n");
						/* 线程退出	*/
						pthread_exit("exit");
						break;
					}
					if(r == -1)
					{
						printf("网络故障!\n");
						//close(ccfd);
						close(*(int *)data);
						*(int *)data=-1;
						break;
					}
					if(r>0)
					{
						/*	7.子进程广播数据	*/
						buf[r]=0;
						printf("::%s\n",buf);
						int i;
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

}


main()
{

		/* 允许100个用户连接	*/
		fds=mmap(0,getpagesize(),
						PROT_READ|PROT_WRITE,
						MAP_ANONYMOUS|MAP_SHARED,0,0);;

		int i;
		//bzero(fds,sizeof(fds[100]));
		/* fds[100]初始化为-1	*/
		for(i=0;i<100;i++){
			fds[i]=-1;
		}
		

		/*	1.建立socket	*/
		serverfd=socket(AF_INET,SOCK_STREAM,0);
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

		/* 创建线程ID		*/
		pthread_t tid;
		// 开始处理			（死循环保证主程序能一直运行）
		while(1){
			/*	4.接收客户连接	*/
			/* 定义结构体来存放请求客户端的IP地址	*/
			struct sockaddr_in cdr={};
			socklen_t soc_len=sizeof(cdr);
			
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
			fds[idx]=cfd;			
			printf("有人连接:%s\n",inet_ntoa(cdr.sin_addr));
			
		/*	5.建立线程		*/
			/* 把fds[idx]客户连接传给线程*/
			pthread_create(&tid,0,getconn_run,&fds[idx]);
			idx++;
			pthread_join(tid,(void **)0);
		
		}
	
}
