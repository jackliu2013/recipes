// brass.cpp -- bank account class methods
#include <iostream>
#include "brass.h"
using std::cout;
using std::endl;
using std::string;

// formatting stuff
typedef std::ios_base::fmtflags format;
typedef std::streamsize precis;
format setFormat();
void restore(format f, precis p);

// Brass methods

Brass::Brass(const string & s, long an, double bal)
{
    fullName = s;
    acctNum = an;
    balance = bal;
}

/* 存款	*/
void Brass::Deposit(double amt)
{
    if (amt < 0)
        cout << "Negative deposit not allowed; "
             << "deposit is cancelled.\n";
    else
        balance += amt;
}

void Brass::Withdraw(double amt)
{
    // set up ###.## format
    format initialState = setFormat();
    precis prec = cout.precision(2);

    if (amt < 0)
        cout << "Withdrawal amount must be positive; "

             << "withdrawal canceled.\n";
    else if (amt <= balance)
        balance -= amt;
    else
        cout << "Withdrawal amount of $" << amt
             << " exceeds your balance.\n"
             << "Withdrawal canceled.\n";
    restore(initialState, prec);
}
double Brass::Balance() const
{
    return balance;
}

void Brass::ViewAcct() const
{
     // set up ###.## format
    format initialState = setFormat();
    precis prec = cout.precision(2);
    cout << "Client: " << fullName << endl;
    cout << "Account Number: " << acctNum << endl;
    cout << "Balance: $" << balance << endl;
    restore(initialState, prec); // Restore original format
}

// BrassPlus Methods

/* 利用成员初始化列表方法来初始化基类的成员	*/
BrassPlus::BrassPlus(const string & s, long an, double bal,
           double ml, double r) : Brass(s, an, bal)	
{
    maxLoan = ml;
    owesBank = 0.0;
    rate = r;
}

BrassPlus::BrassPlus(const Brass & ba, double ml, double r)
           : Brass(ba)   // uses implicit copy constructor
{
    maxLoan = ml;
    owesBank = 0.0;
    rate = r;
}

// redefine how ViewAcct() works
void BrassPlus::ViewAcct() const
{
    // set up ###.## format
    format initialState = setFormat();
    precis prec = cout.precision(2);

    Brass::ViewAcct();   // display base portion
    cout << "Maximum loan: $" << maxLoan << endl;
    cout << "Owed to bank: $" << owesBank << endl;
    cout.precision(3);  // ###.### format
    cout << "Loan Rate: " << 100 * rate << "%\n";
    restore(initialState, prec); 
}

// redefine how Withdraw() works
void BrassPlus::Withdraw(double amt)
{
    // set up ###.## format
    format initialState = setFormat();
    precis prec = cout.precision(2);

		/* 调用基类的Balance()方法来获取当前账户结余
			因为派生类没有重新定义该方法，所以代码可以省略掉Balance()
			的作用域解析运算符
		*/
    double bal = Balance();	
    /* 取款金额amt小于当前账户结余时，调用基类的Withdraw()、
    	方法来更改当前账户结余	
    */
    if (amt <= bal)
        Brass::Withdraw(amt);
    /*	客户取款金额超过了结余，将安排贷款	*/
    else if ( amt <= bal + maxLoan - owesBank)
    {
    		/* 计算出要贷款的金额	*/
        double advance = amt - bal;	
        /*	所欠银行金额加上贷款额和贷款额的利息	*/
        owesBank += advance * (1.0 + rate);	
        cout << "Bank advance: $" << advance << endl;
        cout << "Finance charge: $" << advance * rate << endl;
        /* 1.把要贷款的金额调用基类Deposit()方法存入到账户 */
        Brass::Deposit(advance);
        /* 2.调用基类的Withdraw()方法取出要去的金额amt	*/
        Brass::Withdraw(amt);
    }
    else
        cout << "Credit limit exceeded. Transaction cancelled.\n";
    restore(initialState, prec); 
}

/*
	设置定点表示法并返回以前的标记设置
*/
format setFormat()
{
    // set up ###.## format
    return cout.setf(std::ios_base::fixed, 
                std::ios_base::floatfield);
} 

/*
	重置格式和精度
*/
void restore(format f, precis p)
{
    cout.setf(f, std::ios_base::floatfield);
    cout.precision(p);
}
