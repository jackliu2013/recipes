#!/usr/bin/perl -w
use strict;
 
use POE;  # Auto-includes POE::Kernel and POE::Session.
 
sub handler_start {
  my ($kernel, $heap, $session) = @_[KERNEL, HEAP, SESSION];
  print "Session ", $session->ID, " has started.\n";
  $heap->{count} = 0;
  $kernel->yield('increment');
}
 
sub handler_increment {
  my ($kernel, $heap, $session) = @_[KERNEL, HEAP, SESSION];
  print "Session ", $session->ID, " counted to ", ++$heap->{count}, ".\n";
  $kernel->yield('increment') if $heap->{count} < 10;
}
 
sub handler_stop {
  print "Session ", $_[SESSION]->ID, " has stopped.\n";
}
 
for (1..5) {
  POE::Session->create(
    inline_states => {
      _start    => \&handler_start,
      increment => \&handler_increment,
      _stop     => \&handler_stop,
    }
  );
}
 
POE::Kernel->run();
exit;
