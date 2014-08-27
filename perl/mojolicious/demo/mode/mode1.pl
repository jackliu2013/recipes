#!/usr/bin/env perl
use Mojolicious::Lite;

# Mode
#  You can use the Mojo::Log object from
#  "log" in Mojo to portably collect debug messages
#  and automatically disable them later in a production setup by changing the
#  Mojolicious operating mode,
#  which can also be retrieved from the attribute "mode" in Mojolicious


# Prepare mode specific message during startup
my $msg = app->mode eq 'development' ? 'Development!' : 'Something else!';

get '/' => sub {
    my $self = shift;
    $self->app->log->debug('Rendering mode specific message.');
    $self->render( text => $msg );
};

app->log->debug('Starting application.');
app->start;

# The default operating mode will usually be development and can be changed with command line options or the MOJO_MODE and PLACK_ENV environment variables. A mode other than development will raise the log level from debug to info.

#  $ ./myapp.pl daemon -m production

#  All messages will be written to STDERR or a log/$mode.log file if a log directory exists.

#  $ mkdir log

#  Mode changes also affect a few other aspects of the framework, such as mode specific exception and not_found templates.
