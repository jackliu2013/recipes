#include "myslots.h"		/* ""的头文件是用户自定义的头文件	*/
#include <QMessageBox>

void MySlots::handle()
{

	QMessageBox::information(NULL,
				"Information","this is a test");

}
