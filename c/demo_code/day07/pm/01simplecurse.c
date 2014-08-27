#include <curses.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

main()
{
	char *str="Hello Curses编程";
	initscr();
	/* 输入/输出  */
	/*
	addstr(str);
	*/

	/* 输出到10行10列 */
/*	mvaddstr(10,10,str); */
	/* 居中 */
	mvwaddstr(stdscr,LINES/2,(COLS-strlen(str))/2,str); 
	
	/* 刷新屏幕	*/
	refresh();
	/* 阻塞，直到按任意键退出 */
	getch();
	
	/*
	sleep(20);
	*/

	endwin();

}
