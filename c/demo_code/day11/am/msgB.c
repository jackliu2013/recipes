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
	
	/* 得到消息队列	*/
	key_t key=ftok(".",200);
	int msgid = msgget(key,0);

	//printf("msgid:%x\n",msgid);

	//读取字符串消息
	struct charmsg cmsg={};
	int i;
	for(i=0;i<10;i++)
	{
		msgrcv(msgid,&cmsg,sizeof(cmsg.data),0,0);
		printf("%s\n",cmsg.data);
	}

	
	// 读取 整数消息
	struct intmsg imsg={};
	for(i=0;i<10;i++)
	{
		msgrcv(msgid,&imsg,sizeof(imsg.data),0,0);
		printf("%d\n",imsg.data);
	}
}
