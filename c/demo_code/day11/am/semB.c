#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/sem.h>
#include <signal.h>

key_t shmkey,semkey;
int shmid,semid;

main()
{

	/* 1.得到共享内存和信号量	*/
		shmkey=ftok(".",10);
		semkey=ftok(".",11);
		//得到共享内存
		shmid=shmget(shmkey,100,0);
		//得到信号量
		semid=semget(semkey,1,0);
	
	/* 2.定义阻塞操作		*/
		//挂载共享内存
		char *buf=shmat(shmid,0,0);

		struct sembuf op;
		op.sem_num=0;
		op.sem_op=-1;
		op.sem_flg=0;

	/* 3.阻塞等待信号量够减		*/
	while(1)
	{
		semop(semid,&op,1);
		//读取内存
		printf("::%s\n",buf);

	}

}
