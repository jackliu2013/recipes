#include <curses.h>
main()
{
	initscr();
	/* boot color */
	start_color();

	/*define color_pair  */
	init_pair(1,COLOR_RED,COLOR_GREEN);
	init_pair(2,COLOR_YELLOW,COLOR_BLUE);
	init_pair(3,COLOR_BLACK,COLOR_RED);
	/* define backgroud color */	
	bkgd(COLOR_PAIR(3));

	/***********************/
	/* addch('A');	 */
	move(10,20);
	addch('A'|COLOR_PAIR(1));

	move(20,20);
	addch('A'|A_BOLD|COLOR_PAIR(2));
	
	move(20,30);
	addch('A'|A_STANDOUT);
	addch('A'|A_REVERSE);

	addch('A'|A_BLINK|A_BOLD|A_UNDERLINE);

	/***********************/
	
	getch();
	endwin();
}
