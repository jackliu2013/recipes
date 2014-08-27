#include <QApplication>
#include <QMainWindow>
#include <QPushButton>

int main(int argc,char **argv)
{

	QApplication app(argc,argv);

	QMainWindow mw;

	mw.resize(400,400);

	QPushButton btn1("OK",&mw);
	QPushButton btn2("Cancel",&mw);
	btn1.resize(100,30);
	btn2.resize(100,30);

	btn1.move(100,50);
	btn2.move(200,50);

	mw.setVisible(true);

	return app.exec();


}
