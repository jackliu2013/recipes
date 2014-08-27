#!/usr/bin/env perl
#
# 测试 使用Autoloading(自动装载)生成指示器
#

use Person;
my $him = Person->new;
$him->name("Weiping");
$him->race("Man");
$him->aliases( [ "Laser", "BitBIRD", "chemi" ] );
printf "%s is of the race of %s. \n", $him->name, $him->race;
printf "His aliases are: ", join( ", ", @{ $him->aliases } ), ".\n";
printf "\n";
