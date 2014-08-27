=autoload goto
AUTOLOAD 子过程可以用 eval 或者 require 为该未定义的子过程装载一个定
义,或者是用我们前面讨论过的类型团赋值的技巧,然后使用特殊形式的 goto 执行该子
过程,这种 goto 可以不留痕迹地抹去 AUTOLOAD 过程的堆栈桢。下面我们通过给类型
团赋予一个闭合来定义该子过程:
=cut


sub AUTOLOAD {
	my $name = our $AUTOLOAD;
	*$AUTOLOAD = sub { print "I see $name(@_)\n"};
	goto &$AUTOLOAD;	# 重起这个新过程。
}
blarg(30); # 打印:I see main::blarg(30)
blarg(40); # 打印:I see main::blarg(40)
blarg(50); # 打印:I see main::blarg(50



#在把 AUTOLOAD 过程当作其他接口的封装器中获取许多乐趣。比如,让我们假
#设任何没有定义的函数应该就是拿它的参数调用 system。

sub AUTOLOAD {
	my $program = our $AUTOLOAD;
	$program =~ s/.*:://;		# 截去包名字
	system($program, @_);
}
date();
who('am', 'i');
is('-l');
echo("Abadugabuadaredd...");
