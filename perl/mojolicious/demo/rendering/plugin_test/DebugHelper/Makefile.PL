use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Mojolicious::Plugin::DebugHelper',
  VERSION_FROM => 'lib/Mojolicious/Plugin/DebugHelper.pm',
  AUTHOR       => 'A Good Programmer <nospam@cpan.org>',
  PREREQ_PM    => {'Mojolicious' => '4.18'},
  test         => {TESTS => 't/*.t'}
);
