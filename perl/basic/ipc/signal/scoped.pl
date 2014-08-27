
=comment
Some signals can be neither trapped nor ignored, such as the KILL
  and STOP( but not the TSTP ) signals . One strategy
  for temporarily ignoring signals is to use a local () on that hash element,
  automatically restoring a previous value once your block is exited
  . Remember that values created by the dynamically-scoped local () are
  "inherited" by functions called from within their caller 's scope.
=cut

sub precious {
    local $SIG{INT} = "IGNORE";
    more_functions();
}

sub more_functions {

    # interrupts still ignored, for now...
}

=comment
Some signals can be neither trapped nor ignored, such as the KILL and STOP (but not the TSTP) signals. One strategy for temporarily ignoring signals is to use a local() on that hash element, automatically restoring a previous value once your block is exited. Remember that values created by the dynamically-scoped local() are "inherited" by functions called from within their caller's scope.
=cut

sub precious {
    local $SIG{INT} = "IGNORE";
    more_functions();
}

sub more_functions {

    # interrupts still ignored, for now...
}

=comment
Sending a signal to a negative process ID means that you
  send the signal to the entire Unix process group
  . This code sends a hang-up signal to all processes in the current process
  group,
  and also sets $SIG{HUP} to "IGNORE" so it doesn't kill itself
  :
=cut

# block scope for local
{
    local $SIG{HUP} = "IGNORE";
    kill HUP => -$$;

    # snazzy writing of: kill("HUP", -$$)
}

=comment
Another interesting signal to send is signal number zero
  . This doesn't actually affect a child process,
  but instead checks whether it's alive
  or has changed its UID
  .
=cut

unless ( kill 0 => $kid_pid ) {
    warn "something wicked happened to $kid_pid";
}

=comment
When directed at a process whose UID is
  not identical to that of the sending process,
  signal number zero may fail because you lack permission to send the signal,
  even though the process is alive
  . You may be able to determine the cause of failure using %!
  .
=cut

unless ( kill( 0 => $pid ) || $!{EPERM} ) {
    warn "$pid looks dead";
}

=comment
You might also want to employ anonymous functions for simple signal handlers :
=cut

$SIG{INT} = sub { die "\nOutta here!\n" };
