#!perl
 
use POE qw(Filter::Line Wheel::FollowTail);
 
POE::Session->create(
  inline_states => {
    _start => sub {
      $_[HEAP]{tailor} = POE::Wheel::FollowTail->new(
        Filename => "/var/log/syslog",
        InputEvent => "got_log_line",
        Filter => POE::Filter::Line->new(),
      );
    },
    got_log_line => sub {
      print "Log: $_[ARG0]\n";
    }
  }
);
 
POE::Kernel->run();
exit;
