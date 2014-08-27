#include <curses.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

main()
{

	initscr();
	mvprintw(8,10,"(%d,%d)",COLS,LINES);

	//border('A','B','C','D','E','F','G','H');

	/* 指定为0，采用系统指定的默认字符	*/
	//border(0,0,0,0,0,0,0,0);
	//box(stdscr,0,0);
	//box(stdscr,'A','B');
	box(stdscr,'A',ACS_BOARD);
	box(stdscr,'A',ACS_LARROW);

	mvhline(10,2,0,20);
	getch();
	endwin();

}
