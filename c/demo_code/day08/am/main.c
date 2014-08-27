#include <curses.h>
#include <stdlib.h>
#include <string.h>

// 定义全局变量
char *struser="用户: ";
char *strpass="口令: ";
char *strblank="[           ]";

void init(); /* 完成curses初始化 */
void showLoginUI(int b);  /*	绘制登录界面 */
void input(char *user,char *pass);  /* 输入 */
int verify(const char *user,const char *pass);  /*  校验 */
void showMainUI(); /* 切换的主屏幕　*/
void destroy();  /* 结束curses  */
main()
{
	char user[11];
	char pass[11];

	int b;

	init();
	while(1)
	{
		showLoginUI(b);

		bzero(user,sizeof(user));
		bzero(pass,sizeof(user));

		input(user,pass);

		if(b = verify(user,pass))
		{
			break;
		}
	}
	showMainUI();
	destroy();
}

int verify(const char *user,const char *pass)
{
	if( memcmp(user,"tom",strlen("tom"))!=0 ||memcmp(pass,"123",strlen("123"))!=0 )
	{
		/* 表示失败	*/
		return 0;
	}
	/* 表示成功 */
	return 1;
}

void init()
{
	/* 初始化窗体 */
	initscr();
	/* 其他初始化工作，比如颜色 */

	keypad(stdscr,TRUE); /* 防止功能键乱码回显 */

}

void destroy()
{
	/* 按任意键退出 */
	getch();
	/* 结束win */
	endwin();
}

void showLoginUI( b)
{
	char *strheader="学生信息管理系统(SIMS) v1.0";

	/* 输出之前先清屏 */
	clear();

	mvaddstr(2,(COLS-strlen(strheader))/2,strheader);

	mvaddstr(6,(COLS-strlen(struser)-strlen(strblank))/2,struser);
	mvaddstr(6,(COLS-strlen(struser)-strlen(strblank))/2 + strlen(struser)+1,strblank);
	mvaddstr(8,(COLS-strlen(strpass)-strlen(strblank))/2,strpass);
	mvaddstr(8,(COLS-strlen(struser)-strlen(strblank))/2 + strlen(strpass)+1,strblank);
	if(!b)
	{
		mvaddstr(LINES-2,(COLS-strlen("登录失败"))/2,"登录失败");
	}
	
	/* 输出后要刷新屏幕　 */
	refresh();
}
void input(char *user,char *pass)
{
	/* 先移动到指定位置 */
	move(6,(COLS-strlen(struser) - strlen(strblank))/2+strlen(struser)+2);
	getnstr(user,10);

	move(8,(COLS-strlen(strpass) - strlen(strblank))/2+strlen(strpass)+2);
	getnstr(pass,10);
}
void showMainUI()
{
	char *strwelcome="欢迎使用学生信息管理系统SIMS(v1.0)";
	char *strinfo="按任意键退出!";

	clear();

	mvaddstr(LINES/2,(COLS-strlen(strwelcome))/2,strwelcome);

	mvaddstr(LINES-2,(COLS-strlen(strinfo))/2,strinfo);

	refresh();
}
