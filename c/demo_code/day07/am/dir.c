#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <dirent.h>

main()
{
	DIR *dir;
	struct dirent *d;

	/* 1.打开一个目录	*/
	/*
	dir = opendir(".");
	dir = opendir("~");
	dir = opendir("~ltl");
	*/
	dir = opendir("..");
	if(!dir)
	{
		perror("opendir error");
		exit(-1);
	}

	while(d=readdir(dir)) 
	{
		printf("%c\t%s\n",d->d_type,d->d_name);
	}
	closedir(dir);
}
