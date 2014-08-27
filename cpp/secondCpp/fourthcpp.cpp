#include<string>
#include<iostream>
using namespace std;

//插入例5.10中CMyException类的定义
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
		 cout<<"the program is begin!"<<endl;
     try{// 动态在堆中构造的异常对象，调用一次构造函数。
          throw new CMyException ("obj1");
     		}
        // 注意：这里是定义了按指针方式传递异常对象
        catch(CMyException *e)
        {   // 此处传递给e的实际是上面动态对象的地址，
              //因此不调用任何构造函数。
              cout<<"catcn a CMyException* type object,name is:"<<e->GetName()<<endl;
              delete e; //动态创建的对象需要销毁
        }
        cout<<"the program is end!"<<endl;
      return 0;
}
