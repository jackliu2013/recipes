=sub autoload
通常,你不能调用一个没有定义的子过程。不过,如果在未定义的子过程的包(如果是在对
象方法的情况下,在任何该对象的基类的包里)里有一个子过程叫做 AUTOLOAD,那么
就会调用 AUTOLOAD 子过程,同时还传递给它原本传递给最初子过程的同样参数。你可
以定义 AUTOLOAD 子过程返回象普通子过程那样的数值,或者你可以让它定义还不存在
的子过程然后再调用它,就好象该子过程一直存在一样

最初的子过程的全称名会神奇地出现在包全局变量 $AUTOLOAD 里,该包和
AUTOLOAD 所在的包是同一个包。下面是一个简单的例子,它会礼貌地警告你关于未定
义的子过程调用,而不是退出:
=cut

#sub AUTOLOAD {
#	our $AUTOLOAD;
#	warn "Attempt to call $AUTOLOAD failed.\n";
#}
#blarg(10);	# 我们的 $AUTOLOAD 将会设置为 main::blarg
#print "Still alive!\n";

sub AUTOLOAD {
	our $AUTOLOAD;
	return "I see $AUTOLOAD(@_)\n";
}
print blarg(20);	# 打印:I see main::blarg(20)

1;
