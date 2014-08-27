#ifndef MYSLOTS_H
#define MYSLOTS_H
#include <QObject>

class MySlots:public QObject
{
	Q_OBJECT
	public slots:
		void handle();
};

#endif
