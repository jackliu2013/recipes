#include <stdio.h>
/*
#include <unistd.h>
#include <fcntl.h> 
#include <stdlib.h>
#include <string.h>
*/

main()
{
		char name[100]={0};

	/*
		writefile();
		readfile();
		*/

		printf("please input the authorname\n");
		scanf("%s",name);
		SelectInfoByName(name);
}
