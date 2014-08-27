package Bestiary;

@ISA = qw/Exporter/ ;
@EXPORT_OK = qw/$zoo/ ;

sub import {
	$Bestiary::zoo = "Menagerie";
}


# this has bug
#sub import {
#	$Bestiary::zoo = "Menagerie";
#	Bestiary->export_to_level(1,@_);
#}

1;
