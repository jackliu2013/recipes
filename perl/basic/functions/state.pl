#!/usr/bin/perl

use feature qw/state/;
# state perl 5.10以上版本才有，类似C/C++的局部静态变量static
# static 同时编译多个文件时，所有未加static前缀的全局变量和函数都具有全局可见性
# static的第二个作用是保持变量内容的持久。存储在静态数据区的变量会在程序刚开始运行时就完成初始化，也是唯一的一次初始化。共有两种变量存储在静态存储区：全局变量和static变量，只不过和全局变量比起来，static可以控制变量的可见范围，说到底static还是用来隐藏的
# static的第三个作用是默认初始化为0。其实全局变量也具备这一属性，因为全局变量也存储在静态数据区。在静态数据区，内存中所有的字节默认值都是0x00，某些时候这一特点可以减少程序员的工作量。比如初始化一个稀疏矩阵，我们可以一个一个地把所有元素都置0，然后把不是0的几个元素赋值。如果定义成静态的，就省去了一开始置0的操作。再比如要把一个字符数组当字符串来用，但又觉得每次在字符数组末尾加’\0’太麻烦。如果把字符串定义成静态的，就省去了这个麻烦，因为那里本来就是’\0’ 
sub use_state {
    state $state = 0;
    return ++$state;
}

warn &use_state;
warn &use_state;
warn &use_state;
warn &use_state;
warn &use_state;
warn &use_state;
