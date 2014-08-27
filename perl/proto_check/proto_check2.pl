#!/usr/bin/env perl

use warnings;

use Data::Dump;

my $ref = do 'bip_60';

# Data::Dump->dump($ref);
while ( my ($idx, $grp) = each %{$ref->{gset}} ) {
    # Data::Dump->dump($grp);
    for my $rule (@{$grp->{rules}}) {
        for my $sect (@{$rule->{sect}}) {
           #  print $idx . "\t" . $sect->{begin} . "\n";
           if ($sect->{mode} eq '比例') {
               unless (defined $sect->{ratio} ) {
                  print "规则组$idx 规则条目 mode 比列 need match ratio\n";
               }
           }
           elsif ($sect->{mode} eq '定额') {
               unless (defined $sect->{quota} ) {
                  print "规则组$idx 规则条目 mode 定额 need match quota\n";
               }
           }
           else {
               print "mode 为未知类型\n";
           }
        }
    }
}
