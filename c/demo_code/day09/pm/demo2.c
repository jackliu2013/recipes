#include <curses.h>
#include <unistd.h>
#include <stdlib.h>
#include <math.h>
#include <sys/mman.h>

WINDOW *wnumb;

/* 通过空格来控制 */
main()
{

	/* 指针P指向的数据来做控制量 */
	int *p;
	p=mmap(0,4,PROT_READ|PROT_WRITE,MAP_SHARED|MAP_ANONYMOUS,0,0);
	*p=0;

	//初始化curses		
	initscr();	
	noecho();
	//鼠标的隐藏
	curs_set(0);

	wnumb=derwin(stdscr,3,9,(LINES)/2,(COLS-9)/2);

	//窗体加边框
	box(wnumb,0,0);

	if(fork())
	{
		//父进程要做的任务
		//显示7位随机数

		int num;
		while(1)
		{

			//控制显示进程
			if( (*p)==0 )
			{
				/* 取7位随机数	*/
				num=random()%10000000;
				/* 输出	*/
				mvwprintw(wnumb,1,1,"%07d",num);
				/* 刷新屏幕	 原则从里到外 */
				refresh();
				wrefresh(wnumb);
			}	
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
				if(*p == 0)
				{
					*p=1;
				}
				else
				{
					*p=0;
				}
			}
		}

	}

	//释放cureses
	endwin();
}
