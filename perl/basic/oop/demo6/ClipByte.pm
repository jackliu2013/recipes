#
# overload 重载 overload用法
#
package ClipByte;

use overload
  '+' => \&clip_add,
  '-' => \&clip_sub;

sub new {
    my $class = shift;
    my $value = shift;
    return bless \$value => $class;
}

sub clip_add {
    my ( $x, $y ) = @_;
    my ($value) = ref($x) ? $$x : $x;
    $value += ref($y) ? $$y : $y;
    $value = 255 if $value > 255;
    $value = 0   if $value < 0;
    return bless \$value => ref($x);
}

sub clip_sub {
    my ( $x, $y, $swap ) = @_;
    my ($value) = ( ref $x ) ? $$x : $x;
    $value -= ( ref $y ) ? $$y : $y;
    if ($swap) { $value = -$value }
    $value = 255 if $value > 255;
    $value = 0   if $value < 0;
    return bless \$value => ref($x);
}

1;
