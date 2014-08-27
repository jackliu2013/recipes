
=comment
Be careful : qx(), system(), and some modules
  for calling external commands do a fork(), then wait()
  for the result . Thus,
  your signal handler( &REAPER in the example ) will be called
  . Because wait() was already called by system()
  or qx(), the wait() in the signal handler will see no more zombies
  and will therefore block
  .

  The best way to prevent this issue is to use waitpid(),
  as in the following example
  :

=cut

use POSIX ":sys_wait_h";    # for nonblocking read

my %children;
$SIG{CHLD} = sub {
    # don't change $! and $? outside handler
    local ( $!, $? );
    my $pid = waitpid( -1, WNOHANG );
    return if $pid == -1;
    return unless defined $children{$pid};
    delete $children{$pid};
    cleanup_child( $pid, $? );
};

while (1) {
    my $pid = fork();
    die "cannot fork" unless defined $pid;
    if ( $pid == 0 ) {

        # ...
        exit 0;
    }
    else {
        $children{$pid} = 1;

        # ...
        system($command);

        # ...
    }
}
