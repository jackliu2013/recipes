#!/usr/bin/env perl
use Data::Dump;
use ClipByte;

package main;
$byte1 = ClipByte->new(200);
$byte2 = ClipByte->new(100);
$byte3 = $byte1 + $byte2;      # 255
$byte4 = $byte1 - $byte2;      # 100
$byte5 = 150 - $byte2;         # 50

Data::Dump->dump($byte1);
Data::Dump->dump($byte2);
Data::Dump->dump($byte3);
Data::Dump->dump($byte4);
Data::Dump->dump($byte5);
