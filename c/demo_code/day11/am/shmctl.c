#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <unistd.h>

main()
{
	/*	1.得到key	*/
	key_t key=ftok(".",2);

	/* 	2.根据key得到ID */
	int shmid = shmget(key,4,0);

	/*  3.根据ID得到共享内存的状态	*/
	struct shmid_ds ds={};

	//int r = shmctl(shmid,IPC_STAT,&ds);
	int r = shmctl(shmid,IPC_RMID,&ds);
		
	printf("%d\n",r);

	/*
	printf("key:%x\n",ds.shm_perm.__key);
	printf("nattach:%d\n",ds.shm_nattch);
	*/

}
