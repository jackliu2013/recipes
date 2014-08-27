#include "myslots.h"
#include <QMessageBox>

void MySlots::handle_ok()
{
	    QMessageBox::information(NULL,
		                "Information","OK");
}

void MySlots::handle_cancel()
{
	    QMessageBox::information(NULL,
		                "Information","Cancel");
}
