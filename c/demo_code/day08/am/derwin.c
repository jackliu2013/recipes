#include <curses.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

WINDOW *wnum;

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

main()
{
		int num;
		int i;

		/* 初始化窗体	*/

		/* 把ctrl+c发出的信号与handle函数绑定	*/
		signal(2,handle);

		initscr();
		curs_set(0);	
		/* 创建子窗体	*/
		wnum = derwin(stdscr,3,9,(LINES-3)/2,(COLS-9)/2);


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
			refresh();
			wrefresh(wnum);
			usleep(100000);
		}

		/* 删除窗体	,释放curses */
		delwin(wnum);
		endwin();

}
