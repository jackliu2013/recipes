package ScalarFile;
use Carp;                  # 很好地传播错误消息。
use strict;                # 给我们自己制定一些纪律。
use warnings;              # 打开词法范围警告。
use warnings::register;    # 允许用户说"use warnings 'ScalarFile'"。
my $count = 0;             # 捆绑了的 ScalarFile 的内部计数。

#	CLASSNAME->TIESCALAR(LIST)
#	每当你 tie 一个标量变量,都会触发该类的 TIESCALAR 方法。可选的 LIST 包含
#	任意正确初始化该对象所需要的参数。(在我们的例子里,只有一个参数: 该文件的
#	名字。)这个方法应该返回一个对象,不过这个对象不必是一个标量的 引用。不过
#	在我们的例子里是标量的引用。
sub TIESCALAR {            # 在 ScalarFile.pm
    my $class    = shift;
    my $filename = shift;
	my $fh;
    if ( open $fh, "<", $filename or open $fh, ">", $filename ) {
        close($fh);
        $count++;          # 一个文件范围的词法,是类的私有部分
        return bless \$filename, $class;
    }

    carp "Can't tie $filename: $!" if warnings::enabled();
    return;
}

sub FETCH {
    my $self = shift;
    confess "I am not a class method" unless ref $self;
    return unless open my $fh, $$self;
    read( $fh, my $value, -s $fh );    # NB: 不要在管道上使用 -s
    return $value;
}

sub STORE {
    my ( $self, $value ) = @_;
    ref $self or confess "not a class metod";
    open my $fh, ">", $$self or croak "cannot clobber $$self:$!";
    syswrite( $fh, $value ) == length $value
      or croak "can't write to $$self:$!";
    close $fh
      or croak "can't close $$self:$!";
    return $value;
}

sub DESTROY {
	my $self = shift ;
	confess "wrong type" unless ref $self;
	$count --;
}

sub COUNT {
	# my $invocant = shift ;
	$count ;
}


1;
