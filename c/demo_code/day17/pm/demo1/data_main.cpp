#include "userdata.h"
#include "mythread.h"
#include <cstdio>
#include <cstdlib>
#include <unistd.h>

#include <cmath>
using namespace std;

class MyData
{
	public:
		static UserData data;

};

/*		*/
UserData MyData::data;

/* 数据生产者		*/
class DataProductor : public MyThread
{
	public:
		void run()
		{
			int t;
			int num;
			while(true)
			{
				//随机时间之后产生一个数据，放入容器
				t=random()%10;
				printf("%d秒后产生数据\n",t);
				sleep(t);
				num=random()%100;
				MyData::data.push_data(num);
			}

		}

};

/* 数据消费者		*/
class DataCustomer : public MyThread
{
	public:
		void run()
		{
			int num;
			while(true)
			{
				//取数据并且打印到终端
				num=MyData::data.pop_data();
				printf("%d\n",num);
			}

		}
};

int main()
{
	DataProductor dp1,dp2,dp3,dp4,dp5,dp6;
	DataCustomer dc;

	dp1.start();
	dp2.start();
	dp3.start();
	dp4.start();
	dp5.start();
	dp6.start();

	dc.start();

	dp1.join();
	dp2.join();
	dp3.join();
	dp4.join();
	dp5.join();
	dp6.join();

	dc.join();

}
