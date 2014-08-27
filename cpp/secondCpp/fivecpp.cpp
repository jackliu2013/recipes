#include<string.h>
#include<iostream>
using namespace std;
//此处包含例5.10中的CMyException类代码
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
class CTestClass
{//测试类，其构造函数可能抛出int型或char*型异常
public:
    CTestClass(int x) throw(int,char*);
    void print();
private:
    int a;
};
CTestClass:: CTestClass(int x) throw(int,char*)
{//可能抛出int型或char*型异常，但其本身不处理int类型异常
    try{
        if(x==0)
        	throw 0;
        if(x>1000)
        	throw "the value of x is too large.";
        a = 100/x;
    }
    catch(char* s)
    {
        cout<<"have dealed the char* type info:"<<s<<endl;
    }
}
void CTestClass::print()
{
    cout<<a<<endl;
}

void func8(int x) throw(CMyException, int)
{// 可能抛出CMyException, int类型异常
    CTestClass a(x);
    a.print();
    CMyException obj2("obj2");
    throw obj2;
}

void func9() throw(char*)
{// 可能抛出char*类型异常
    char *p = new char[20];
    try{//可能引起异常的代码 
        throw "error";
    }
    catch(...)
    {// 释放申请的空间p后将异常继续抛出
        cout <<"释放申请的空间"<<endl;
        delete p;
       	throw;
    }
}
int  main()
{
	cout<<"the program is begin!"<<endl;
    try{ //可能产生异常的代码
        throw new CMyException("obj1");
    }
    catch(CMyException *e)
    {
         cout<<"catch a CMyException type object ,the name is:"<<e->GetName()<<endl;
         delete e;
    }
    try{
        cout<<"please input an int type value:";
        int x=0;
        cin>>x;
        func8(x);
        func9();
    }
    catch(int x)
    {
        cout<<"have dealed the int type exception:"<<x<<endl;
    }
    catch(char *s)
    {
        cout<<"have dealed the char* type exception:"<<s<<endl;
    }
    catch(CMyException &e)
    {
        cout<<"have dealed CMyException type exception:"
            <<e.GetName()<<endl;
    }
    catch(...)
    {
        cout<<"have dealed the all type exception"<<endl;
    }
    cout<<"the program is end!"<< endl;
    
    return 0;
}
