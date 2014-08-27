#!/usr/bin/env perl


=comment
here-document 

定界符是行而不是字符。起始定界符是当前行，结束定界符是一个包含你指定的字符串的行。

指定的用以结束引起材料的字符串跟在"<<"后面，所有当前行到结束行(不包括)之间的行都是字符串的内容。结束字符串可以是标识符号(单词)或某些引起的文本。如果它也被引起，引起的类型决定文本的变换，就像普通的引起一样，没有引起的标识符当作用双引号引起对待。

=cut



my $price = '10$' ;

print <<EOF;        # 
the price is $price.
EOF

print <<"EOF";        # 和上面一样，显式引起
the price is $price.
EOF

print  <<'EOF';     # 单引号引起 变量不内插
the price is $price.
EOF

print << x 10;     # 打印下行10次
the price is ten.


# print <<"" x 10;   # 实现上面内容的比较好的方法
# the price is soso.

print <<`EOC`;   # 执行命令
echo hi there
echo lo there
EOC

