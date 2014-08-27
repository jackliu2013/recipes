#!/usrbin/env perl

use strict;
use warnings;
use JSON::XS;
use Data::Dump;
use utf8;
use Encode;
binmode(STDOUT, ":utf8");

##################### demo 1 ######################
#my $json = new JSON::XS;
#my $obj = $json->incr_parse ($text)
#or die "expected JSON object or array at beginning of string";
#Data::Dump->dump($obj);
#my $tail = $json->incr_text;	# $tail now contains " hello"
#Data::Dump->dump($tail);

##################### demo 2 ######################
my @str  = qw/hello world 你好/;
my $text = \@str;
## JSON::XS->new->utf8->encode($text) 对perl引用变量$text用encode进行utf8编码
my $json_text = JSON::XS->new->utf8->encode($text);
# Data::Dump->dump($json_text);
warn $json_text;

## JSON::XS->new->utf8->decode($json_text) 对$json_text用decode进行utf8解码
my $perl_scalar = JSON::XS->new->utf8->decode($json_text);
# Data::Dump->dump($perl_scalar);
warn $perl_scalar;

##################### demo 3 ######################
#my $tmp = JSON::XS->new->ascii(1)->encode( [ chr 0x10401 ] );
#Data::Dump->dump($tmp);
#my $tmp = JSON::XS->new->latin1->encode( ["\x{89}\x{abc}"] );
#Data::Dump->dump($tmp);
