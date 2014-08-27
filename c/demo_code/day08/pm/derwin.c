#include <curses.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/time.h>
#include <time.h>
#include <signal.h>

WINDOW *wnum;
WINDOW *wtime;	//增加一个显示时间的窗体 第1步

/* 信号处理函数	 */
void handle(int s)
{
	/* 删除窗体，释放curses */
	delwin(wnum);
	endwin();
	//for test
	printf("OK\n");
	exit(0);
}

void timehandle(int s) //设定定时时间的信号处理函数  第3步
{
	time_t tt;
	struct tm *t;

	//取得时间
	tt = time(0);
	t=localtime(&tt);

	//显示时间
	wclear(wtime);
	box(wtime,0,0);
	mvwprintw(wtime,1,1,"%02d:%02d:%02d",
			t->tm_hour,t->tm_min,t->tm_sec);
	//刷新屏幕
	refresh();
	wrefresh(wtime);
	wrefresh(wnum);
}

main()
{
		int num;
		int i;

		//定时器参数设定  第5步
		struct itimerval it={};
		it.it_value.tv_usec = 1;
		it.it_interval.tv_sec = 1;

		/* 初始化窗体	*/

		/* 把ctrl+c发出的信号与handle函数绑定	*/
		signal(2,handle);
		signal(SIGALRM,timehandle); //绑定定时器处理函数 第4步

		initscr();
		curs_set(0);	

		//定时器的添加
		setitimer(ITIMER_REAL,&it,0); //定时器添加 第6步

		/* 创建子窗体	*/
		wnum = derwin(stdscr,3,9,(LINES-3)/2,(COLS-9)/2);
		
		wtime = derwin(stdscr,3,10,0,COLS-10);//在最右边显示时间窗体  第2步

		/* 循环显示7位随机数	*/
		while(1)
		{
			num = 0;
			for(i=0;i<7;i++)
			{
				num = num *10;
				num +=random()%10 ;
			}

			// 子窗体clear
			wclear(wnum);
			// 加边框
			box(wnum,0,0);
			mvwprintw(wnum,1,1,"%07d",num);

			// 刷新窗体 
			refresh();
			wrefresh(wnum);
			wrefresh(wtime);
			usleep(100000);
		}

		/* 删除窗体	,释放curses */
		delwin(wnum);
		endwin();

}
