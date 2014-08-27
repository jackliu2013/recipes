#include "myslots.h"
#include <QApplication>
#include <QDialog>
#include <QPushButton>

int main(int argc,char **argv)
{

	QApplication app(argc,argv);

	QDialog dg;

	dg.resize(400,400);

	QPushButton btn1("OK",&dg);
	QPushButton btn2("Cancel",&dg);
	btn1.resize(100,30);
	btn2.resize(100,30);

	btn1.move(100,50);
	btn2.move(200,50);

	MySlots myslo;
	QObject::connect(
		        &btn1,//信号发送者
				SIGNAL(clicked()),//发送的信号
			    &myslo,//信号发送的槽函数的对象
			    SLOT(handle_ok())//槽函数
				   );
	QObject::connect(
		        &btn2,//信号发送者
				SIGNAL(clicked()),//发送的信号
			    &myslo,//信号发送的槽函数的对象
			    SLOT(handle_cancel())//槽函数
				   );

	dg.setVisible(true);

	return app.exec();


}
