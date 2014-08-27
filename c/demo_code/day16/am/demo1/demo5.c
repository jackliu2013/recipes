/*
* 4个线程来实现摇奖程序，一个线程显示随机数，一个线程显示时间 
* 一个线程来刷新屏幕，一个线程来实现空格按键对随机数的控制
* 本程序使用pthread_kill + sigwait + 布尔值来实现空格按键对随机数的控制
*/
#include <stdio.h>
#include <math.h>
#include <pthread.h>
#include <curses.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <signal.h>

pthread_t th_time,th_num,th_winrefresh,th_signal;

/* 显示随机数和时间的窗体	*/
WINDOW *wnum,*wtime;
int num;
time_t tt;
struct tm *t;

/* 控制布尔值	*/
int flag=0;

/* 空格控制函数		*/
void *control(void *data)
{
	int ch;
	while(1)
	{
		ch=getch();
		if(ch==32)
		{
			if(flag==1)
			{
				flag=0;
			}
			else
			{
				flag=1;
			}
			usleep(10000);
			pthread_kill(th_num,34);
		}
	}

}

/* 刷新线程函数	*/
void *winrefresh(void *data)
{
	while(1)	/* 死循环防止线程死去	*/
	{
		/* 显示随机数		*/
		mvwprintw(wnum,1,1,"%07d",num);

		/* 	显示时间		*/
		mvwprintw(wtime,1,1,"%02d:%02d:%02d",
					t->tm_hour,t->tm_min,t->tm_sec);

		/*	刷新屏幕		*/
		refresh();
		wrefresh(wnum);
		wrefresh(wtime);
		usleep(10000);/* 休息10毫秒	*/
	}
}

/* 随机数线程函数	*/
void *num_run(void *data)
{
	sigset_t sigs;
	sigemptyset(&sigs);
	sigaddset(&sigs,34);
	int s;

	while(1)
	{
		if(flag)
		{
			sigwait(&sigs,&s);
		}
		/* 产生7位随机数	*/
		num=random()%10000000;
		usleep(10000);/* 休息10毫秒	*/
	}
}

/* 时间线程函数		*/
void *time_run(void *data)
{
	while(1)
	{
		/* 获取系统时间		*/
		tt=time(0);
		t=localtime(&tt);
		sleep(1);	/* 休息1秒	*/
	}

}

main()
{

	/* 1.初始化curses 	*/
	initscr();
	/* 隐藏光标			*/
	curs_set(0);
	wnum=derwin(stdscr,3,9,LINES/2,(COLS-9)/2);
	wtime=derwin(stdscr,3,11,0,COLS-11);
		/* 加边框	*/
	box(wnum,0,0);
	box(wtime,0,0);
		/* 刷新主窗口及两个小窗口	*/
	refresh();
	wrefresh(wnum);
	wrefresh(wtime);

	/* 2.创建线程		*/
	pthread_create(&th_time,0,time_run,0);
	pthread_create(&th_num,0,num_run,0);
	pthread_create(&th_winrefresh,0,winrefresh,0);
	pthread_create(&th_signal,0,control,0);

	/* 3.等待子线程结束	*/
	pthread_join(th_time,(void **)0);
	pthread_join(th_num,(void **)0);
	pthread_join(th_winrefresh,(void **)0);
	pthread_join(th_signal,(void **)0);

	/* 4.释放curses		*/
	delwin(wnum);
	delwin(wtime);
	endwin();

}
