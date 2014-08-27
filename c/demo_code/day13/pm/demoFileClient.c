#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#define BUF_LEN 1024

main()
{

	/* 	1.建立socket		*/
		int fd=socket(AF_INET,SOCK_STREAM,0);
		if(fd==-1)
		{
			perror("socket");
			exit(-1);
		}
		printf("socket ok!\n");

	/*  2.连接服务器			*/
		struct sockaddr_in addr={};
		addr.sin_family=AF_INET;
		addr.sin_port=htons(9998);
		inet_aton("192.168.1.188",&addr.sin_addr);
		int r;
		r = connect(fd,(struct sockaddr *)&addr,sizeof(addr));
		if(r==-1)
		{
		    perror("connect");
		    close(fd);
		    exit(-1);
	    }
		printf("connect ok!\n");
		
	/*  3.1 发送文件名长度				*/
		char filename[]="file.txt";	
		char path[]="/home/ltl/linux_c_danei/day13";
		char file[256]; //文件的完整路径
		int len;
		len=strlen(filename);
		write(fd,&len,sizeof(int));
		printf("文件名长度:%u\n",len);

	/*  3.2 发送文件名 	*/
		write(fd,filename,len);

	/*  3.3 打开文件			*/
		sprintf(file,"%s/%s",path,filename);
		int filefd=open(file,O_RDONLY);
		if(filefd==-1)
		{
			perror("open file"),close(fd),exit(-1);
		}
		printf("file open ok!\n");

	/*  3.4 获取文件长度 	*/
		struct stat st;
		fstat(filefd,&st);
		//文件长度
		len = st.st_size;
		printf("文件长度:%u\n",len);

	/*  3.5 发送文件长度		*/
		write(fd,&len,sizeof(int));

	/*  3.6 发送文件数据		*/
		char buf[1024];
		while(1)
		{
			r = read(filefd,buf,sizeof(buf));
			if(r<=0) //读到文件尾
			{
				break;
			}
			write(fd,buf,r);
		}
	/*  3.7 关闭文件		*/
		close(filefd);
	/*  4.关闭socket			*/
		close(fd);


}
