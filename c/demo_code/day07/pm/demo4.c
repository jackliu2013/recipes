#include <curses.h>

main()
{
	int x=1,y=5;
	int ch;
	initscr();
	curs_set(0);
	noecho();
	keypad(stdscr,TRUE);
	while(1)
	{
		clear();
		mvaddch(y,x,'A');
		refresh();

		/* 1.输入上下左右 */
		ch = getch();

		/* 2.根据按键控制字符的位置 */
		switch(ch)
		{
			case KEY_UP:
				y--;	
				break;
			case KEY_RIGHT:
				x++;
				break;
			case KEY_DOWN:
					y++;
					break;
			case KEY_LEFT:
				x--;
				break;
		}

		/* 3.在变动的位置显示字符 */
		/*
		clear();
		mvaddch(y,x,ch);
		refresh();
		*/
	}

	endwin();

}
