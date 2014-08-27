#include <curses.h>
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

main()
{
	time_t nowtime;
	struct tm *timenow;
	char *MyDate;
	char *MyTime;
	int len;

	time(&nowtime);
	timenow = localtime(&nowtime);
	sprintf(MyDate,"%d:%d:%d",timenow->tm_year+1900,timenow->tm_mon+1,timenow->tm_mday);
	initscr();

	mvwaddstr(stdscr,LINES/2,(COLS-10)/2,MyDate);

	refresh();

	getch();

	endwin();
}
