#!/usr/bin/env perl

=comment

$dbh = DBI->connect($data_source, $username, $password) or die $DBI::errstr;
$dbh = DBI->connect($data_source, $username, $password, \%attr) or die $DBI::errstr;

Establishes a database connection, or session, to the requested $data_source. Returns a database handle object if the connection succeeds. 
Use $dbh->disconnect to terminate the connection.

If the connect fails (see below), it returns undef and sets both $DBI::err and $DBI::errstr. (It does not explicitly set $!.) You should 
generally test the return status of connect and print $DBI::errstr if it has failed.

Multiple simultaneous connections to multiple databases through multiple drivers can be made via the DBI. Simply make one connect call for 
each database and keep a copy of each returned database handle.

The $data_source value must begin with "dbi:driver_name:". The driver_name specifies the driver that will be used to make the connection.
(Letter case is significant.)

As a convenience, if the $data_source parameter is undefined or empty, the DBI will substitute the value of the environment variable DBI_DSN. 
If just the driver_name part is empty (i.e., the $data_source prefix is "dbi::"), the environment variable DBI_DRIVER is used. 
If neither variable is set, then connect dies.

Examples of $data_source values are:

   dbi:DriverName:database_name
   dbi:DriverName:database_name@hostname:port
   dbi:DriverName:database=database_name;host=hostname;port=port

There is no standard for the text following the driver name. Each driver is free to use whatever syntax it wants. 
The only requirement the DBI makes is that all the information is supplied in a single string. 
You must consult the documentation for the drivers you are using for a description of the syntax they require.

It is recommended that drivers support the ODBC style, shown in the last example above. It is also recommended that 
they support the three common names 'host', 'port', and 'database' (plus 'db' as an alias for database). This simplifies 
automatic construction of basic DSNs: "dbi:$driver:database=$db;host=$host;port=$port". Drivers should aim to 'do something 
reasonable' when given a DSN in this form, but if any part is meaningless for that driver (such as 'port' for Informix) it 
should generate an error if that part is not empty.

If the environment variable DBI_AUTOPROXY is defined (and the driver in $data_source is not "Proxy") then the connect request 
will automatically be changed to:
$ENV{DBI_AUTOPROXY};dsn=$data_source
DBI_AUTOPROXY is typically set as "dbi:Proxy:hostname=...;port=...". If $ENV{DBI_AUTOPROXY} doesn't begin 
with 'dbi:' then "dbi:Proxy:" will be prepended to it first. See the DBD::Proxy documentation for more details.

If $username or $password are undefined (rather than just empty), then the DBI will substitute the values of the DBI_USER 
and DBI_PASS environment variables, respectively. The DBI will warn if the environment variables are not defined. However, 
the everyday use of these environment variables is not recommended for security reasons. The mechanism is primarily intended 
to simplify testing. See below for alternative way to specify the username and password.

DBI->connect automatically installs the driver if it has not been installed yet. Driver installation either returns a valid 
driver handle, or it dies with an error message that includes the string "install_driver" and the underlying problem. 
So DBI->connect will die on a driver installation failure and will only return undef on a connect failure, in which case 
$DBI::errstr will hold the error message. Use eval { ... } if you need to catch the "install_driver" error.

The $data_source argument (with the "dbi:...:" prefix removed) and the $username and $password arguments are then passed to 
the driver for processing. The DBI does not define any interpretation for the contents of these fields. The driver is free 
to interpret the $data_source, $username, and $password fields in any way, and supply whatever defaults are appropriate for
the engine being accessed. (Oracle, for example, uses the ORACLE_SID and TWO_TASK environment variables if no $data_source is specified.)

The AutoCommit and PrintError attributes for each connection default to "on". (See "AutoCommit" and "PrintError" for more information.) 
However, it is strongly recommended that you explicitly define AutoCommit rather than rely on the default. The PrintWarn attribute 
defaults to on if $^W is true, i.e., perl is running with warnings enabled.

The \%attr parameter can be used to alter the default settings of PrintError, RaiseError, AutoCommit, and other attributes. 
For example:

$dbh = DBI->connect($data_source, $user, $pass, {
    PrintError => 0,
    AutoCommit => 0
   });

The username and password can also be specified using the attributes Username and Password, in which case they take precedence 
over the $username and $password parameters.

You can also define connection attribute values within the $data_source parameter. For example:

dbi:DriverName(PrintWarn=>1,PrintError=>0,Taint=>1):...

Individual attributes values specified in this way take precedence over any conflicting values specified via the \%attr parameter to connect.

The dbi_connect_method attribute can be used to specify which driver method should be called to establish the connection. The only useful 
values are 'connect', 'connect_cached', or some specialized case like 'Apache::DBI::connect' (which is automatically the default when 
running within Apache).

Where possible, each session ($dbh) is independent from the transactions in other sessions. This is useful when you need to hold cursors 
open across transactions--for example, if you use one session for your long lifespan cursors (typically read-only) and another for your 
short update transactions.

For compatibility with old DBI scripts, the driver can be specified by passing its name as the fourth argument to 
connect (instead of \%attr):

$dbh = DBI->connect($data_source, $user, $pass, $driver);

In this "old-style" form of connect, the $data_source should not start with "dbi:driver_name:". (If it does, the embedded driver_name will 
be ignored). Also note that in this older form of connect, the $dbh->{AutoCommit} attribute is undefined, the $dbh->{PrintError} attribute 
is off, and the old DBI_DBNAME environment variable is checked if DBI_DSN is not defined. Beware that this "old-style" connect will 
soon be withdrawn in a future version of DBI.

=cut                                                            

use strict;
use warnings;

use DBI;
use Data::Dump;

# connect to db

my $cfg = {
    dsn    => "dbi:DB2:$ENV{DB_NAME}",
    #dsn    => "dbi:DB2:zdb_test",
    user   => "$ENV{DB_USER}",
    pass   => "$ENV{DB_PASS}",
    schema => "$ENV{DB_SCHEMA}",
};

Data::Dump->dump( @{$cfg}{qw/dsn user pass/} );

#
# 第一种连接 db 方法 不设置连接时的属性
#
## my $dbh = DBI->connect( $cfg->{dsn}, $cfg->{user}, $cfg->{pass} )  or die $DBI::errstr;
#my $dbh = DBI->connect( @{$cfg}{qw/dsn user pass/}, )  or die $DBI::errstr;

#
# 第二种连接 db 方法 设置或修改连接时的默认属性
#
=comment
PrintError Type: boolean, inherited

The PrintError attribute can be used to force errors to generate warnings (using warn) in addition to returning error codes in the normal way. When set "on", any method which results in an error occurring will cause the DBI to effectively do a warn
("$class $method failed: $DBI::errstr") where $class is the driver class and $method is the name of the method which failed. E.g.,

    DBD::Oracle::db prepare failed: ... error text here ...

By default, DBI->connect sets PrintError "on".
If desired, the warnings can be caught and processed using a $SIG{__WARN__} handler or modules like CGI::Carp and CGI::ErrorWrap.


RaiseError Type: boolean, inherited

The RaiseError attribute can be used to force errors to raise exceptions rather than simply return error codes in the normal way. 
It is "off" by default. When set "on", any method which results in an error will cause the DBI to effectively do a die
("$class $method failed: $DBI::errstr"), where $class is the driver class and $method is the name of the method that failed. E.g.,

  DBD::Oracle::db prepare failed: ... error text here ...

If you turn RaiseError on then you'd normally turn PrintError off. If PrintError is also on, then the PrintError is done first (naturally).

Typically RaiseError is used in conjunction with eval { ... } to catch the exception that's been thrown and followed by an 
if ($@) { ... } block to handle the caught exception. For example:

    eval {
        ...
        $sth->execute();
        ...
    };
    if ($@) {
        # $sth->err and $DBI::err will be true if error was from DBI
        warn $@; # print the error
        ... # do whatever you need to deal with the error
    }

In that eval block the $DBI::lasth variable can be useful for diagnosis and reporting if you can't be sure which handle triggered the error. For example, $DBI::lasth->{Type} and $DBI::lasth->{Statement}.
See also "Transactions".
If you want to temporarily turn RaiseError off (inside a library function that is likely to fail, for example), the recommended way is 
like this:

{
   local $h->{RaiseError};  # localize and turn off for this block
   ...
}

The original value will automatically and reliably be restored by Perl, regardless of how the block is exited. The same logic applies to other attributes, including PrintError.

=cut

my $dbh1= DBI->connect(
    @{$cfg}{
        qw/dsn user pass/},
        {
            AutoCommit => 0, #默认属性是on , 此处关闭
            PrintError => 0, #
            RaiseError => 1, # 

        }
    );

   if ($dbh1) {
        warn "connect to db this is 1st dbh \n";
    }
    else {
        warn "cannot connect 1st dbh $DBI::errstr\n";
    }

my $dbh2= DBI->connect(
    @{$cfg}{
        qw/dsn user pass/},
        {
            AutoCommit => 0, #默认属性是on , 此处关闭
            PrintError => 0, #
            RaiseError => 1, # 

        }
    );

   if ($dbh2) {
        warn "connect to db this is 2st dbh \n";
    }
    else {
        warn "cannot connect 2st dbh $DBI::errstr\n";
    }


my $rv = $dbh1->disconnect();
warn "the return value of succeed disconnect is :$rv";
my $rc = $dbh2->disconnect();
warn "the return code of succeed disconnect is :$rc";
exit ;


=comment

使用connect_cached

connect_cached

  $dbh = DBI->connect_cached($data_source, $username, $password) or die $DBI::errstr;
  $dbh = DBI->connect_cached($data_source, $username, $password, \%attr) or die $DBI::errstr;

connect_cached is like "connect", except that the database handle returned is also stored in a hash associated with the given parameters. 
If another call is made to connect_cached with the same parameter values, then the corresponding cached $dbh will be returned if it is still 
valid. The cached database handle is replaced with a new connection if it has been disconnected or if the ping method fails.

Note that the behaviour of this method differs in several respects from the behaviour of persistent connections implemented by Apache::DBI. 
However, if Apache::DBI is loaded then connect_cached will use it.

Caching connections can be useful in some applications, but it can also cause problems, such as too many connections, and so should be used 
with care. In particular, avoid changing the attributes of a database handle created via connect_cached() because it will affect other code 
that may be using the same handle. When connect_cached() returns a handle the attributes will be reset to their initial values. This can 
cause problems, especially with the AutoCommit attribute.

Where multiple separate parts of a program are using connect_cached() to connect to the same database with the same (initial) attributes 
it is a good idea to add a private attribute to the connect_cached() call to effectively limit the scope of the caching. For example:

   DBI->connect_cached(..., { private_foo_cachekey => "Bar", ... });

Handles returned from that connect_cached() call will only be returned by other connect_cached() call elsewhere in the code if those 
other calls also pass in the same attribute values, including the private one. (I've used private_foo_cachekey here as an example, 
you can use any attribute name with a private_ prefix.)

Taking that one step further, you can limit a particular connect_cached() call to return handles unique to that one place in the code 
by setting the private attribute to a unique value for that place:

  DBI->connect_cached(..., { private_foo_cachekey => __FILE__.__LINE__, ... });

By using a private attribute you still get connection caching for the individual calls to connect_cached() but, by making separate 
database connections for separate parts of the code, the database handles are isolated from any attribute changes made to other handles.

The cache can be accessed (and cleared) via the "CachedKids" attribute:

  my $CachedKids_hashref = $dbh->{Driver}->{CachedKids};
  %$CachedKids_hashref = () if $CachedKids_hashref;

=cut
