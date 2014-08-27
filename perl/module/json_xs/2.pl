#!/usrbin/env perl

use strict;
use warnings;
use JSON::XS;
use Data::Dump;

my $text = "[1],[2], [3]";
my $json = new JSON::XS;

# void context, so no parsing done
$json->incr_parse($text);

# now extract as many objects as possible. note the
# use of scalar context so incr_text can be called.
while ( my $obj = $json->incr_parse ) {

    # do something with $obj

    # now skip the optional comma
    $json->incr_text =~ s/^ \s* , //x;
	Data::Dump->dump($json->incr_text);
}
