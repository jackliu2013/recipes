#include <curses.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

main()
{
	char *title="图书管理系统";
	char *version="(v 1.0)";

	char *user="用户:";
	char *pass="口令:";

	char *inarea="           ";

	initscr();

	/* 输出登录界面 */
	/* 居中输出 */
	mvaddstr(3,(COLS-strlen(title))/2,title);
	mvaddstr(5,(COLS-strlen(version))/2,version);


	mvaddstr(7,(COLS-strlen(user)-strlen(inarea))/2,user);	
	attron(A_UNDERLINE);
	addstr(inarea);
	attroff(A_UNDERLINE);
	
	mvaddstr(9,(COLS-strlen(user)-strlen(inarea))/2,pass);	
	attron(A_UNDERLINE);
	addstr(inarea);
	attroff(A_UNDERLINE);

	/* 按任意键结束	*/
	getch();
	endwin();

}
