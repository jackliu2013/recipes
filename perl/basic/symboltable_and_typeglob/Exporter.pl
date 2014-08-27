package Exporter;

sub import {
    my $pkg = shift;
    my $callpkg = caller($ExportLevel);

    #...
    *{"$callpkg\::$_"} = \&{"$pkg\::$_"} foreach @_ ;
}

1;
