#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/shm.h>

main()
{
	key_t key;
	int shmid;

	key=ftok(".",2);

	//µÃµ½shmid
	shmid=shmget(key,4,0);
	printf("key:%x,id:%d\n",key,shmid);
	
	int *p=shmat(shmid,0,0);
	printf("%d\n",*p);

	shmdt(p);
}
