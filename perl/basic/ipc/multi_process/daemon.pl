#!/usr/bin/perl -w
=comment
A process that usually starts when the system boots
  and shuts down when the
  system is shut down is called a daemon( Disk And Execution MONitor )
  . If a daemon process has a configuration file which is modified after the
  process has been started,
  there should be a way to
  tell
  that process to reread its configuration file without stopping the process
  . Many daemons provide this mechanism using a SIGHUP signal handler
  . When you want to tell the daemon to reread the file,
  simply send it the SIGHUP signal
  .

  Not all platforms automatically reinstall their(native)
  signal handlers after a signal delivery
  . This means that the handler works the first time the signal is sent,
  only . The solution to this problem is to use POSIX signal handlers
  if available;
their behavior is well-defined .

  The following example implements a simple daemon,
  which restarts itself every time the SIGHUP signal is received
  . The actual code is located in the subroutine code(),
  which just prints some debugging info to show that it works;
it should be replaced with the real code .
=cut

use POSIX          ();
use FindBin        ();
use File::Basename ();
use File::Spec::Functions;
$| = 1;

# make the daemon cross-platform, so exec always calls the script
# itself with the right path, no matter how the script was invoked.
my $script = File::Basename::basename($0);
my $SELF = catfile( $FindBin::Bin, $script );

# POSIX unmasks the sigprocmask properly
my $sigset = POSIX::SigSet->new();
my $action = POSIX::SigAction->new( "sigHUP_handler", $sigset, &POSIX::SA_NODEFER );

POSIX::sigaction( &POSIX::SIGHUP, $action );
sub sigHUP_handler {
    print "got SIGHUP\n";
    exec( $SELF, @ARGV ) || die "$0: couldn't restart: $!";
}

&code();

sub code {
    print "PID: $$\n";
    print "ARGV: @ARGV\n";
    my $count = 0;
    while ( ++$count ) {
        sleep 2;
        print "$count\n";
    }
}
