#include <curses.h>
#include <unistd.h>

int x;
int y;

main()
{
	initscr();
	x = 0;
	y = LINES/2;

	/* “˛≤ÿπ‚±Í */
	curs_set(0);
	while(1)
	{
		/* «Â∆¡ */
		/* 	clear();  */
		erase(); 
		/* ∏ƒ±‰◊÷∑˚µƒŒª÷√œ‘ æ  */
		x++;
		if(x>=COLS)
		{
			x = 0;
		}
		move(y,x);
		addch('A'|A_BOLD);
		/*  À¢∆¡    */
		refresh();
		/* ‘›Õ£	*/
		/* ‘›Õ£∞Î√Î */
		usleep(500000);
	}
	endwin();
}
