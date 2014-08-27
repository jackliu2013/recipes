#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dump;

######### do BLOCK ########
#Not really a function. Returns the value of the last command in the sequence of commands indicated by BLOCK. When modified by the while or until loop modifier, executes the BLOCK once before testing the loop condition. (On other statements the loop modifiers test the conditional first.)
#do BLOCK does not count as a loop, so the loop control statements next, last, or redo cannot be used to leave or restart the block. See perlsyn for alternative strategies.



######### do EXPR ########
#Uses the value of EXPR as a filename and executes the contents of the file as a Perl script.
#my $ret = do '/home/liutailin/tmp/study/perl_demo/functions/hello';
my $ret = do 'test/hello2';
Data::Dump->dump($ret);
