#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/msg.h>

/* 
* 消息格式用户自己定义
* 下面定义了两个消息结构体
*/

struct charmsg
{
	long type;
	char data[100];
};

struct intmsg
{
	long type;
	int data;
};

main()
{
	key_t key=ftok(".",200);

	int msgid = msgget(key,IPC_CREAT|IPC_EXCL|0666);

	//printf("msgid:%x\n",msgid);

	//发送字符串消息
	struct charmsg cmsg={};
	int i;
	for(i=0;i<10;i++)
	{
		cmsg.type = 1;
		bzero(cmsg.data,sizeof(cmsg.data));
		sprintf(cmsg.data,"消息:%d",i);
		msgsnd(msgid,&cmsg,strlen(cmsg.data),0);
	}

	
	//发送整数消息
	struct intmsg imsg={};
	for(i=0;i<10;i++)
	{
		imsg.type = 2;
		imsg.data = i;
		msgsnd(msgid,&imsg,sizeof(imsg.data),0);
	}
}
