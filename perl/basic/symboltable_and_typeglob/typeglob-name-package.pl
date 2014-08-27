#!/usr/bin/env perl

# typeglob-name-package.pl

$foo = 'some value';
$bar = 'another value';

who_am_i( *foo );
who_am_i( *bar );


sub who_am_i {
    local $glob = shift;
    
    print "I'am from package " . *{$glob}{PACKAGE} . "\n";
    print "My name is "        . *{$glob}{NAME}    . "\n";
}

