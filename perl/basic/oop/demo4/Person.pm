#
# 使用Autoloading(自动装载)生成指示器
#
package Person;
use Carp;

my %Fields = (
    "Person::name"    => "unnamed",
    "Person::race"    => "unknown",
    "Person::aliases" => [],
);

use subs qw/name race aliases/;

sub new {
    my $invocant = shift;
    my $class    = ref($invocant) || $invocant;
    my $self     = { %Fields, @_ };             # 类似 Class::Struct 的克隆
    bless $self, $class;
    return $self;
}

sub AUTOLOAD {
    my $self = shift;

    # 只处理实例方法,而不处理类方法
    croak "$self not an object" unless ref($invocant);
    my $name = our $AUTOLOAD;
    return if $name =~ /::DESTROY$/;
    unless ( exist $self->{name} ) {
        croak "Can't access `$name' field in $self";
    }
    if (@_) { return $self->{$name} = shift }
    else    { return $self->{$name} }
}

1;
