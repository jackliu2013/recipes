#include<string>
#include<iostream>
using namespace std;
class CMyException
{
	//异常类，该类的对象作为抛出异常时传递的异常参数。
public:
     CMyException (string n="none") : name(n)
     {//构造函数，根据参数n构造一个名字为n的异常类对象
          cout<<"Construct a CMyException object,the object's name is:"<<name<<endl;
      }
      CMyException (const CMyException &e)
      {//拷贝构造函数，根据参数e拷贝构造一个异常类对象
             name = e.name;
             cout<<"copy a CMyException type object,the object's name is:"<<name<< endl;
       }
      virtual ~ CMyException () 
      {
            cout << "delete a CMyException object,the object's name is:"<<name<< endl;
       }
      string GetName() {return name;} 
protected:
      string name; //异常类对象的名字
};
int main()
{
	  cout<<"the program is begin!"<< endl;
      try{
           // 构造一个异常对象，即会调用一次CMyException类
           //的构造函数。这是个局部变量。
           CMyException obj1("obj1");        //下面抛出异常对象。注意：这时VC编译器会复制
           //一份新的异常对象，即调用一次CMyException
           //类的拷贝构造函数。新拷贝的对象是个临时变量。
           throw obj1;
     }
     catch(CMyException e)
     {    //当异常参数传递给e时，由于是传值方式，因
               //此会调用一次拷贝构造函数
            cout<<"catch a CMyException type object,the object's name is："<<e.GetName()<<endl;
     }
     cout<<"the program is end!"<< endl;
     return 0;
}
