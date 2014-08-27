#include <curses.h>

main()
{
	initscr();
	int ch;
	while(1)
	{
		/* 1.输入一个字符 */
		mvaddstr(4,10,"输入选择(Y/y)");
		refresh();

		ch = getch();

		/* 2.判定字符	*/
		if(ch == 'y' || ch == 'Y')
		{
			break;
		}
		/* 清屏 不清屏的时候可以看到输入 */
		clear();

		mvprintw(10,2,"你输入的字符是:%c",ch);
	}

	endwin();

}
