#!/usr/bin/env perl 

=comment
    
把~/opt/zark/exprot中的所有的yspz的dat文件中的ssn，由32位改成64位

=cut

use strict;
use warnings;

use IO::File;


my @file = system("find -type f -name \"*dat\" | xargs grep -l -E \"ssn\\s+:\\s+char\"");

print "@file\n";

# my @file = qw/0032.dat/;

foreach ( @file ) {

    my $frd = IO::File->new("$_",'r+') ;
    my $fwd = IO::File->new("$_.bak",'w+');

    unless ( defined $frd ) {
        die "open $_ faild.";
    }

    while(<$frd>){
        if (/ssn\s+\:\s+char\(32\)/) {
            s/32/64/ ;
            print $fwd $_;
        }
        else {
            print $fwd $_;
        }
    }

    $frd->close();
    $fwd->close();

    # system("mv $_");
}

exit 0 ;
