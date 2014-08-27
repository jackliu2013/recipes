// brass.h  -- bank account classes
/* 程序清单13_7 brass.h
*	需要说明以下几点：
*	1.BrassPlus类在Brass类的基础上添加了3个私有数据成员和3个公有成员函数
*	2.Brass类和BrassPlus类都声明了ViewAcct()和Withdraw()方法，但BrassPlus对象和Brass对象的这些方法的
*		行为是不同的
*	3.Brass类在声明ViewAcct()和Withdraw()时使用了新关键字virtual。这些方法被称为虚方法（virtual method）
*	4.Brass类还声明了一个虚析构函数，虽然该析构函数不执行任何操作。
*
*/
#ifndef BRASS_H_
#define BRASS_H_
#include <string>
// Brass Account Class	基类Brass
class Brass
{
private:
    std::string fullName;	/* 客户姓名	*/
    long acctNum;	/* 账号*/
    double balance;	/*	当前结余（账户余额）*/
public:
    Brass(const std::string & s = "Nullbody", long an = -1,
                double bal = 0.0);
    void Deposit(double amt);	/* 存款	*/
    virtual void Withdraw(double amt);	/* 取款（虚方法）	*/
    double Balance() const;	/* */
    virtual void ViewAcct() const;	/* 虚方法	*/
    virtual ~Brass() {}	/* 虚方法	*/
};

//Brass Plus Account Class	派生类BrassPlus，公有继承Brass类
class BrassPlus : public Brass
{
private:
    double maxLoan;	/* 透支限额	*/
    double rate;	/* 利率	*/
    double owesBank;	/* 欠款额	*/
public:
    BrassPlus(const std::string & s = "Nullbody", long an = -1,
            double bal = 0.0, double ml = 500,
            double r = 0.11125);
    BrassPlus(const Brass & ba, double ml = 500, 
		                        double r = 0.11125);
    virtual void ViewAcct()const;
    virtual void Withdraw(double amt);
    void ResetMax(double m) { maxLoan = m; }
    void ResetRate(double r) { rate = r; };
    void ResetOwes() { owesBank = 0; }
};

#endif
