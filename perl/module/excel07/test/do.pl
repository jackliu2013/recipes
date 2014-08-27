#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dump;


my $href = do "/home/jackliu/文档/sum/test/cfg.conf";

Data::Dump->dump($href);
