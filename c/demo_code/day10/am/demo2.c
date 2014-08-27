#include <curses.h>
#include <unistd.h>
#include <stdlib.h>
#include <math.h>
#include <sys/mman.h>

WINDOW *wnumb;

int flag=0;
void control(int s)
{
	if(flag==1){
	 flag=0;
	}
	else {
	 flag=1;
	}
}
main()
{

	//初始化curses		
	initscr();	
	noecho();
	//鼠标的隐藏
	curs_set(0);

	wnumb=derwin(stdscr,3,9,(LINES)/2,(COLS-9)/2);

	//窗体加边框
	box(wnumb,0,0);

	signal(34,control);

	if(fork())
	{
		//父进程要做的任务
		//显示7位随机数

		int num;
		while(1)
		{
			//控制显示进程
			//flag 为1，pause父进程
			if(flag)
			{
				pause();
			}
			/* 取7位随机数	*/
			num=random()%10000000;
			/* 输出	*/
			mvwprintw(wnumb,1,1,"%07d",num);
			/* 刷新屏幕	 原则从里到外 */
			refresh();
			wrefresh(wnumb);

			usleep(100000);
		}
	}
	else
	{
		//子进程要做的任务
		//处理按键
		int ch;
		while(1)
		{
			/* 当输入的是空格字符时 */
			ch=getch();
			if(ch==32)
			{
				//控制显示进程
				kill(getppid(),34);
			}
		}

	}

	//释放cureses
	endwin();
}
