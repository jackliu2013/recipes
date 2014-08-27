#这段代码是有BUG的，
#!/usr/bin/perl

use strict;
use warnings;
use Data::Dump;

my $href;
while (<DATA>) {

	#BUG1
    next unless s/^(.?)\s*//;
    my $who = $1;

    #Data::Dump->dump($who);

    for my $fld (split) {

        # XXX_x=9999
        next unless s/(\w+)\_(\w+\=\d+)//;	#BUG2不能进行严格匹配
        my $k1 = $1;

        #Data::Dump->dump($k1);
        my ( $k2, $value ) = split /=/, $2;

		
        #Data::Dump->dump($k2);
        if ( exists ${ $href->{$who}->{$k1} }{$k2} ) {
            $value += ${ $href->{$who}->{$k1} }{$k2};
        }
        $href->{$who}->{$k1}->{$k2} = $value;

        #Data::Dump->dump(${$href->{$who}->{$k1}}{$k2});
    }
}
Data::Dump->dump($href);

__END__
A	BUS_x=1  BUS_y=2  BUS_z=3  BUS_t=1
B	BUS_x=1  BUS_y=2  BUS_z=3
A	BUS_x=1  BUS_y=2  BUS_z=3
