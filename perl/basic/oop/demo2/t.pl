#!/usr/bin/env perl
use strict;
use warnings;
use Horse;

use Data::Dump;

my $ed = Horse->new;    # 四腿湾马
Data::Dump->dump( \$ed );

my $stallion = Horse->new( color => "black" );    #四腿黑马
Data::Dump->dump( \$stallion );

my $steed = Horse->new( color => "dun" );         #
Data::Dump->dump( \$steed );

my $foal = Horse->new( owner => "jackliu" );      #
Data::Dump->dump( \$foal );
