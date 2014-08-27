#!/usr/bin/env perl

use strict;
use warnings;

=comment

Precision P

A fixed number of digits before (positive) or after (negative) the decimal point. For example, 123.45 has a precision of -2. 0 means an integer like 123 (or 120). A precision of 2 means two digits to the left of the decimal point are zero, so 123 with P = 1 becomes 120. Note that numbers with zeros before the decimal point may have different precisions, because 1200 can have p = 0, 1 or 2 (depending on what the initial value was). It could also have p < 0, when the digits after the decimal point are zero.

The string output (of floating point numbers) will be padded with zeros:

        Initial value   P       A       Result          String
        ------------------------------------------------------------
        1234.01         -3              1000            1000
        1234            -2              1200            1200
        1234.5          -1              1230            1230
        1234.001        1               1234            1234.0
        1234.01         0               1234            1234
        1234.01         2               1234.01         1234.01
        1234.01         5               1234.01         1234.01000

For BigInts, no padding occurs.
Accuracy A

Number of significant digits. Leading zeros are not counted. A number may have an accuracy greater than the non-zero digits when there are zeros in it or trailing zeros. For example, 123.456 has A of 6, 10203 has 5, 123.0506 has 7, 123.450000 has 8 and 0.000123 has 3.

The string output (of floating point numbers) will be padded with zeros:

        Initial value   P       A       Result          String
        ------------------------------------------------------------
        1234.01                 3       1230            1230
        1234.01                 6       1234.01         1234.01
        1234.1                  8       1234.1          1234.1000

For BigInts, no padding occurs.

=cut


use Math::BigFloat;

my $x = Math::BigFloat->new(2);
my $y = $x->copy()->bdiv(3);            # 2/3 
print $y->bround(5),"\n";               # will give 0.66667 给出5位有效数字


my $z = Math::BigFloat->new(2);
my $w = $x->copy()->bdiv(3,5);          # will give 0.66667     2/3 并且取5位有效数字
print "$w\n";
