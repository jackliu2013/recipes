#!/usr/bin/env perl

use strict;
use warnings;
use Critter;	# 引入Critter包，即引入Critter类

my $pet = Critter->spawn ;	# 调用Critter包中的spawn方法，返回一个Critter对象的引用
$pet->my_pf ;	# 通过Critter对象的引用调用Critter类中的my_pf方法
