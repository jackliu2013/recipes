#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

=p
##############
print "111111111111111\n";
sub aysetenv { my ($key, $value) = @_;
	$ENV{$key} = $value unless $ENV{$key};
	print "$key => $value\n"
}

my %hoh=(
	"hello" => "world");
aysetenv(%hoh); 
###############
print "222222222222222\n";
my $max;
sub max {
	$max = shift(@_);
	for my $item (@_) {
		$max = $item if $max < $item;
	}
	return $max;
}
my $mon=21;
my $tue=120;
my $wed=143;
my $thu=914;
my $fri=1015;
my $bestday = max($mon, $tue, $wed, $thu, $fri);
print "$bestday\n";
###############
print "333333333333333\n";
sub configuration {
	my %options = @_;
	print "Maximum verbosity.\n" if $options{VERBOSE} == 9;
}
configuration(PASSWORD => 'xyzzy', VERBOSE => 9, SOCRE => 0);


##################################
#1#my $v1="helo";
#1#my $v2="world";
#1#my $v3;
#1#my $v4;
#1#($v3, $v4) = upcase($v1, $v2);
sub upcase {
my @parms = @_;
for (@parms) { tr/a-z/A-Z/ }
# 检查我们是否在列表环境中被调用的
return wantarray ? @parms : $parms[0];
}
#print "$v3\t$v4\n"
#2#my @list1="hello world";
#2#my @list2="you are welcome";
#2#my @newlist = upcase(@list1,@list2);
my $var="hello:world:hello:baby";
my @newlist = upcase( split /:/, $var);
print "@newlist\n";

######################
splutter(\*STDOUT);
sub splutter {
	my $fh = shift;
print $fh = "her um well a hmmm\n";
}
=cut

my $rec = get_rec( \*STDIN );
print "$rec\n";

sub get_rec {
    my $fh = shift;
    return scalar <$fh>;
}
