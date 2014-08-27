#!/usr/bin/env perl

# 流水处理

my %trasn=(
    lowercase            => sub { $_[0] = lc $_[0] },
    uppercase            => sub { $_[0] = uc $_[0] },
    trim                 => sub { $_[0] =~ s/^\s+|\s+$//g },
    collapse_whitespace  => sub { $_[0] =~ s/\s+/ /g },  # 去除多余空格
    remove_specials      => sub { $_[0] =~ s/[^a-z0-9\s]//ig },
);
