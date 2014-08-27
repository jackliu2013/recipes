// tabtenn1.h -- a table-tennis base class
// 基类TableTennisPlayer的Name()，HasTable()方法和派生类RatedPlayer的
// Rating()方法被称为类的const成员函数，因为它们不会修改调用对象
#ifndef TABTENN1_H_
#define TABTENN1_H_
#include <string>
using std::string;
// simple base class
class TableTennisPlayer
{
private:
    string firstname;
    string lastname;
    bool hasTable;
public:
    TableTennisPlayer (const string & fn = "none",
                       const string & ln = "none", bool ht = false);
    void Name() const;//const放在函数Name()后面，表明方法不修改调用对象
    bool HasTable() const { return hasTable; };//同上，HasTable方法不修改调用对象
    void ResetTable(bool v) { hasTable = v; };
};

// simple derived class 派生类RatedPlayer，公有继承TableTennisPlayer类
class RatedPlayer : public TableTennisPlayer
{
private:
    unsigned int rating;
public:
    RatedPlayer (unsigned int r = 0, const string & fn = "none",
                 const string & ln = "none", bool ht = false);
    RatedPlayer(unsigned int r, const TableTennisPlayer & tp);
    unsigned int Rating() const { return rating; }
    void ResetRating (unsigned int r) {rating = r;}
};

#endif
