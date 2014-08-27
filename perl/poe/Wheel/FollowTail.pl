#!/usr/bin/env perl

use strict;
use warnings;

use POE;
use POE::Wheel::FollowTail;
 
my @files_to_tail = qw( vsftpd.log mail.log );
 
foreach my $filename (@files_to_tail) {
  POE::Session->create(
    inline_states => {
      _start => sub {
        push @{$_[HEAP]{messages}}, POE::Wheel::FollowTail->new(
          Filename   => "/var/log/$filename",
          InputEvent => "got_input",
        );
      },
      got_input => sub {
        print "$filename: $_[ARG0]\n";
      },
    }
  );
}
 
POE::Kernel->run();
exit;
