package	Bestiary;
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(camel);	# 缺省输出的符号
our @EXPORT_OK = qw($weight);	# 按要求输出的符号
our $VERSION = 1.00;		# 版本号

### 在这里包含你的变量和函数
sub camel { 
	print "One-hump dromedary";
}
$weight = 1024;


1;
