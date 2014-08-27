#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dump;

use Config;
################# demo 1 #################
#my $s = pack( 'H2' x 10, 30 .. 39 );
#ata::Dump->dump($s);
#y ($hex) = unpack( 'H*', $s );
#ata::Dump->dump($hex);

################# demo 2 #################
#my $ps = pack( 's', 20302 );
#Data::Dump->dump($ps);
#my $vs = unpack( 's', $ps );
#Data::Dump->dump($vs);

################# demo 3 #################
#Data::Dump->dump( $Config{shortsize} );
#Data::Dump->dump( $Config{intsize} );
#Data::Dump->dump( $Config{longsize} );
#Data::Dump->dump( $Config{longlongsize} );

################# demo 4 #################
#my $msg = 'hello world';
#my $buf = pack( 'N', length($msg), $msg );
#Data::Dump->dump($buf);
#$buf = pack( 'NA*', length($msg), $msg );
#Data::Dump->dump($buf);

#my $data = unpack 's>*', $buf;
#Data::Dump->dump($data);

################# demo 5 #################
#my $byte = pack( 'B8', '10001100' ); # start with MSB
#Data::Dump->dump($byte);
#$byte = pack( 'b8', '00110001' ); # start with LSB
#Data::Dump->dump($byte);

################# demo 5 #################
#my $buf = pack( 'iii', 100, 20, 3 );

##my $buf = pack( 'i3', 100, 20, 3 );
##print unpack( '%i3', $buf ), "\n";    # prints 123
#print unpack( '%32i3', $buf ), "\n";    # prints 123

## \x01 十进制01 \x10 十进制16
#print unpack( '%32A*', "\x01\x10" ), "\n";    # prints 17

#my $mask = '775';
#my $bitcount = unpack( '%32b', $mask );
#print $bitcount, "\n";
#my $evenparity = unpack( '%1b', $mask );
#print $evenparity, "\n";

################# demo 6 #################
#my %UTF8;
#my %Unicode;
#$UTF8{Euro} = pack( 'U', 0x20AC ); # Equivalent to: $UTF8{Euro} = "\x{20ac}";
#Data::Dump->dump( $UTF8{Euro} ); # print "\xe2\x82\xac",which contain 3 bytes
#$Unicode{Euro} = unpack( 'U', $UTF8{Euro} );
#Data::Dump->dump( $Unicode{Euro} );

################# demo 6 #################
#my $berbuf = pack( 'w*', 1, 128, 128 + 1, 128 * 128 + 127 );
#Data::Dump->dump($berbuf);

################# demo 7 #################
#my @str = qw/how early low low open/;
#my $value = join( '', map( substr( $_, 0, 1 ), @str ) );
#my $value = pack( '(A)'.@str, @str );	# equals the upstairs line
#my $value = pack( '(A)*', @str );	# equals the upstairs line
#Data::Dump->dump($value);    # will print hello

################# demo 8 #################
my ( $src, $dst, $sm ) = qw/hello world china/;
my $msg = pack( 'Z*Z*CA*', $src, $dst, length($sm), $sm );
Data::Dump->dump($msg);
