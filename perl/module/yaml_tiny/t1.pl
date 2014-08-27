#!/usr/bin/env perl

# In your program

use YAML::Tiny;

# Create a YAML file
my $yaml = YAML::Tiny->new;

# Open the config
$yaml = YAML::Tiny->read('file.yml');

# Reading properties
my $root = $yaml->[0]->{rootproperty};
my $one  = $yaml->[0]->{section}->{one};
my $Foo  = $yaml->[0]->{section}->{Foo};

# Changing data
$yaml->[0]->{newsection} = { this => 'that' };    # Add a section
$yaml->[0]->{section}->{Foo} = 'Not Bar!';        # Change a value
delete $yaml->[0]->{section};                     # Delete a value

# Add an entire document
$yaml->[1] = [ 'foo', 'bar', 'baz' ];

$yaml->[1]->[0] = { 'hello' => 'world' };
$yaml->[1]->[1] = { 'hello' => ['world','good', 'money' ],};

# Save the file
$yaml->write('file.conf');
