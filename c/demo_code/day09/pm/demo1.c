#include <curses.h>
#include <unistd.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <sys/mman.h>

WINDOW *wnumb;
WINDOW *wtime;

main()
{

	int *p=mmap(0,4,PROT_READ|PROT_WRITE,MAP_SHARED|MAP_ANONYMOUS,0,0);
	*p=0;

	//初始化curses		
	initscr();	
	curs_set(0);

	/* 指定窗口的位置 */
	wnumb=derwin(stdscr,3,9,(LINES)/2,(COLS-9)/2);
	wtime=derwin(stdscr,3,10,0,COLS-10);

	/* 给窗口加边框	*/
	box(wnumb,0,0);
	box(wtime,0,0);
	
	/* 刷新窗体  由外到内 逐个刷新	*/
	refresh();
	wrefresh(wnumb);
	wrefresh(wtime);

	if(fork())
	{
		//父进程
		//显示7位随机数

		int num;
		while(1)
		{
			
			while( (*p) !=0 );
			*p =1;
			
			/* 取7位随机数	*/
			num=random()%10000000;
			/* 输出	*/

			/* 在窗体wnumb中的1行1列的位置显示7位随机数	*/
			mvwprintw(wnumb,1,1,"%07d",num);

			/* 刷新屏幕	*/
			refresh();
			wrefresh(wnumb);
			wrefresh(wtime);
			*p = 0;
			usleep(100000);

		}
		
		delwin(wnumb);
	}
	else
	{
		//子进程
		//显示时间
		time_t tt;
		struct tm *t;

		while(1)
		{
			tt = time(0);
			t=localtime(&tt);

			while( (*p) != 0);
			*p = 1;
			mvwprintw(wtime,1,1,"%02d:%02d:%02d",t->tm_hour,t->tm_min,t->tm_sec);

			refresh();
			wrefresh(wtime);
			wrefresh(wnumb);
			*p = 0;
			
			sleep(1);
		}
		delwin(wtime);
	}

	//释放cureses
	endwin();
}
