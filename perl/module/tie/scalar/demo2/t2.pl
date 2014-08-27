#!/usr/bin/env perl

no Underscore;

@tests = (
    "Assignment" => sub { $_ = "Bad" },
    "Reading"    => sub { print },
    "Matching"   => sub { $x = /badness/ },
    "Chop"       => sub { chop },
    "Filetest"   => sub { -x },
    "Nesting"    => sub {
        for ( 1 .. 3 ) { print }
    },
);
while ( ( $name, $code ) = splice( @tests, 0, 2 ) ) {
    print "Testing $name: ";
    eval { &$code };
    print $@ ? "detected" : " missed!";
    print "\n";
}
