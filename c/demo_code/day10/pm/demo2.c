#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <curses.h>
#include <signal.h>
#include <string.h>
#include <math.h>
#include <time.h>

/* 4个任务：
* 1.显示时间，随机数
* 2.产生随机数
* 3.获取时间
* 4.处理按键
*/

WINDOW *wtime,*wnumb;

main()
{
	/* 初始化窗体	*/
	initscr();
	int id=0;

	//创建3个子进程
	for(id;i<3;id++)
	{
		if(fork())
		{
			//父进程	
	
		}
		else
		{
			//子进程	
			switch(id)
			{
				case 0:
					while(1)	//负责随机数
					{

					}
					break;
				case 1:
					while(1) 	//负责时间
					{

					}
					break;
				case 2:
					while(1)	//负责按键
					{

					}
					break;
			}
	
		}
	}

	//循环处理刷屏 显示随机数，时间


	/* 清除窗体		*/	
	endwin();
}

