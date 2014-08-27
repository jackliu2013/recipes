#!/usr/bin/perl

open file,"product.txt";

while (<file>){
	print "$_";
}
