#include "myslots.h"
#include <QApplication>
#include <QWidget>
#include <QPushButton>
#include <QLineEdit>
#include <QTextCodec>

int main(int argc,char **argv)
{

	/*	1.建立QT应用	*/
	QApplication app(argc,argv);	

	/* 使中文正常显示	*/
	QTextCodec *codec=QTextCodec::codecForName("gb2312");
	QTextCodec::setCodecForTr(codec);

	/*	2.建立窗体		*/
	QWidget win;

	/*	3.调用窗体方法控制窗体		*/
	//窗体大小400*300
	win.resize(400,300);		
	//居中显示
	win.move((1024-400)/2,(768-300)/2);	

	//添加button 在窗体中
	QPushButton btn("OK",&win);
	btn.resize(100,30);
	btn.move(100,100);

	// 	添加QLineEdit对象		在窗体中
	//	使中文正常显示
	QLineEdit le(QObject::tr("你好"),&win);
	le.resize(50,50);
	le.move(20,20);

	MySlots myslo;
	/* 点击按钮弹出一个messagebox
	QObject::connect(
		&btn,//信号发送者
		SIGNAL(clicked()),//发送的信号
		&myslo,//信号发送的槽函数的对象
		SLOT(handle())//槽函数
	);
	*/
	
	/* 点击按钮退出窗体	*/
	QObject::connect(
		&btn,//信号发送者
		SIGNAL(clicked()),//发送的信号
		&app,//信号发送的槽函数的对象
		SLOT(quit())//槽函数
	);

	win.setVisible(true);
	/*	4.等待所有窗体子线程终止	*/
	return app.exec();

}
