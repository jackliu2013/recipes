#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/shm.h>
#include <signal.h>

/* 全局变量声明	*/
union semun{
		int val;
		struct semid_ds *ds;
		unsigned short *array;
		struct seminfo *_buf;
};

int shmid,semid;
key_t shmkey,semkey;

//char buf[50];//输入的缓冲
int r;

main()
{

	/* 1.创建共享内存 信号量	*/
		shmkey=ftok(".",10);
		semkey=ftok(".",11);	
		//创建100字节的共享内存
		shmid=shmget(shmkey,100,IPC_CREAT|IPC_EXCL|0666);
		if(shmid == -1)
		{
			perror("共享内存失败"),exit(-1);
		}
		//创建1个信号量
		semid=semget(semkey,1,IPC_CREAT|IPC_EXCL|0666);
		if(semid == -1)
		{
			perror("信号量失败"),exit(-1);
		}
		// 初始化信号量
		union semun v;
		v.val=0;
		semctl(semid,0,SETVAL,v);

	/* 2.挂载共享内存区域		*/
		char  *buf=shmat(shmid,0,0);

	/*	3.定义信号量的操作，并且进行操作	*/
		struct sembuf op;
		op.sem_num = 0;
		op.sem_op=1;
		op.sem_flg=0;

		while(1)
		{
			//从标准输入里面读取数据
			r = read(0,buf,49);
			if(r<=0)
			{
				break;	//ctrl+d
			}
			buf[r]=0;

			//修改信号量(对信号量+2，保证其他的进程不阻塞)
			semop(semid,&op,1);

		}

	//卸载共享内存
	shmdt(buf);

	//删除共享内存
	shmctl(shmid,IPC_RMID,0);

	//删除信号量
	semctl(semid,0,IPC_RMID,0);
	
}
