#!/usr/bin/env perl 
# All constructors can die when invalid parameters are given.

use strict;
use warnings;
use DateTime;

=comment
This class method accepts parameters for each date and time component : 
"year", "month", "day", "hour", "minute", "second", "nanosecond" . 
It also accepts "locale", "time_zone", and "formatter" parameters .

  my $dt = DateTime->new(
    year       => 1966,
    month      => 10,
    day        => 25,
    hour       => 7,
    minute     => 15,
    second     => 47,
    nanosecond => 500000000,
    time_zone  => 'America/Chicago',
  );

DateTime validates the "month", "day", "hour", "minute", and "second", and "nanosecond" parameters . 
The valid values for these parameters are :

  month : An integer from 1 - 12. 

  day   : An integer from 1 - 31, and it must be within the valid range of days for the specified month . 

  hour  : An integer from 0 - 23. 

  minute: An integer from 0 - 59. 

  second: An integer from 0 - 61 ( to allow for leap seconds ) . Values of 60 or 61 are only allowed when they match actual leap seconds . 

  nanosecond : An integer >= 0. If this number is greater than 1 billion, it will be normalized into the second value for the DateTime object.

  Invalid parameter types( like an array reference ) will cause the constructor to die .

  The value for seconds may be from 0 to 61, to account for leap seconds . If you give a value greater than 59,
  DateTime does check to see that it really matches a valid leap second .

  All of the parameters are optional except for "year" . The "month" and "day" parameters both default to 1,
  while the "hour", "minute", "second", and "nanosecond" parameters all default to 0.

  The "locale" parameter should be a string matching one of the valid locales, or a DateTime::Locale object . 
  See the DateTime::Locale documentation for details (perldoc DateTime::Locale).

  The time_zone parameter can be either a scalar or a DateTime::TimeZone object . A string will simply be passed to 
  the DateTime::TimeZone->new method as its "name" parameter . This string may be an Olson DB time zone name("America/Chicago"),
  an offset string("+0630"), or the words "floating" or "local" . See the DateTime::TimeZone documentation for more details .

  The default time zone is "floating" .

      The "formatter" can be either a scalar
      or an object, but the class specified by the scalar
      or the object must implement a format_datetime() method
      . Parsing Dates

      This module does not parse dates !That means there is
      no constructor to which you can pass things like "March 3, 1970 12:34" .

      Instead,
    take a look at the various DateTime::Format:: * modules on CPAN
      . These parse all sorts of different date formats,
      and you're bound to find something that can handle your particular needs
      . Ambiguous Local Times

      Because of Daylight Saving Time,
    it is possible to specify a local time that is ambiguous . For example,
    in the US in 2003,
    the transition from to saving to standard time occurred on October 26,
    at 02
    : 00
    : 00 local time . The local clock changed from 01
    : 59
    : 59 ( saving time ) to 01
    : 00
    : 00 ( standard time ) . This means that the hour from 01
    : 00
    : 00 through 01
    : 59
    : 59 actually occurs twice, though the UTC time continues to move forward
      .

      If you specify an ambiguous time, then the latest UTC time is always used,
    in effect always choosing standard time . In this case,
    you can simply subtract an hour to the object in order to move to saving
      time,
    for example
    :

      # This object represent 01:30:00 standard time
      my $dt = DateTime->new(
          year      => 2003,
          month     => 10,
          day       => 26,
          hour      => 1,
          minute    => 30,
          second    => 0,
          time_zone => 'America/Chicago',
      );

print $dt->hms;    # prints 01:30:00

# Now the object represent 01:30:00 saving time
$dt->subtract( hours => 1 );

print $dt->hms;    # still prints 01:30:00

Alternately, you could create the object with the UTC time zone,
  and then call the set_time_zone() method to change the time zone
  . This is a good way to ensure that the time is not ambiguous
  . Invalid Local Times

  Another problem introduced by Daylight Saving Time is that certain local
  times just do not exist . For example, in the US in 2003,
  the transition from standard to saving time occurred on April 6,
  at the change to 2
  : 00
  : 00 local time . The local clock changes from 01
  : 59
  : 59 ( standard time ) to 03
  : 00
  : 00 ( saving time ) . This means that there is no 02
  : 00
  : 00 through 02
  : 59
  : 59 on April 6 !

  Attempting to create an invalid time currently causes a fatal error
  . This may change in future version of this module
  .

=cut

# This object represent 01:30:00 standard time
my $dt = DateTime->now(time_zone => 'local') ;
print "now is $dt\n";

print $dt->hms. "\n" ;
