
=p
This is a simple job server. It allows multiple clients to run jobs on the server simultaneously. Clients' input is sent to their jobs while they're running.
=cut

#!/usr/bin/perl
# http://poe.perl.org/?POE_Cookbook/Job_Server
use warnings;
use strict;

# Include POE, POE::Component::Server::TCP, and POE::Wheel::Run.
use POE qw(Component::Server::TCP Wheel::Run);

# The programs that are allowed to run, with their names.
my %programs = (
    time   => "/bin/date",
    uptime => "/usr/bin/uptime",
    ls     => "/bin/ls /var/games/*",
    echo   => "/bin/cat -",
);

# Start a TCP server.  The client will be presented with a list of
# valid commands.  They can enter one command: that will execute, and
# its output will be sent back to the client.  Then the server will
# close the connection.
POE::Component::Server::TCP->new(
    Alias => "job_server",
    Port  => 32080,

    # Send the client a list of available commands when it connects.
    ClientConnected => sub {
        $_[KERNEL]->yield("usage");
    },

    # Make sure the job is destroyed when the client exits.
    ClientDisconnected => sub {
        delete $_[HEAP]->{job};
    },

    # Process client input.  When no job is running, accept input and
    # try to spawn a new one.  While a job is running, however, pass
    # the client's input to it.
    ClientInput => sub {
        my ( $heap, $input ) = @_[ HEAP, ARG0 ];
        if ( $heap->{job} ) {
            $heap->{job}->put($input);
            return;
        }
        my $program = $programs{$input};
        unless ( defined $program ) {
            $_[KERNEL]->yield("usage");
            return;
        }
        $heap->{job} = POE::Wheel::Run->new(
            Program      => $program,
            StdioFilter  => POE::Filter::Line->new(),
            StderrFilter => POE::Filter::Line->new(),
            StdoutEvent  => "got_job_stdout",
            StderrEvent  => "got_job_stderr",
            CloseEvent   => "got_job_close",
        );
        $heap->{client}->put( "Job " . $heap->{job}->PID . " started." );
    },

    # Inline states are custom event handlers.  These add handlers for
    # job output, job status, and a convenient usage message.
    InlineStates => {
        got_job_stdout => sub {
            $_[HEAP]->{client}->put("out: $_[ARG0]");
        },
        got_job_stderr => sub {
            $_[HEAP]->{client}->put("ERR: $_[ARG0]");
        },
        got_job_close => sub {
            my ( $kernel, $heap ) = @_[ KERNEL, HEAP ];
            my $job = delete $heap->{job};
            $heap->{client}->put( "Job " . $job->PID . " stopped." );
        },
        usage => sub {
            my @commands = sort keys %programs;
            $_[HEAP]->{client}->put("Commands: @commands");
        },
    },
);

# Run the server until it's done.
$poe_kernel->run();

