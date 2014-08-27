#!/usr/bin/perl -w

#
#    bless REF,CLASSNAME
#
#    bless REF
#
#        This function tells the thingy referenced by REF that it is now an object in the CLASSNAME package. If CLASSNAME is omitted, the current package is used. Because a bless is often the last thing in a constructor, it returns the reference for convenience. Always use the two-argument version if a derived class might inherit the function doing the blessing. See perltoot and perlobj for more about the blessing (and blessings) of objects.

#        Consider always blessing objects in CLASSNAMEs that are mixed case. Namespaces with all lowercase names are considered reserved for Perl pragmata. Builtin types have all uppercase names. To prevent confusion, you may wish to avoid such package names as well. Make sure that CLASSNAME is a true value.

#                See Perl Modules in perlmod.
#

use strict;
use person;
use dog;

sub main() {
    my $object = { "name" => "tom" };

    # 先把"tom"变为人
   my $self = bless( $object, "person" );
    #$object->sleep();
    #$object->study();
    $self->sleep();
    $self->study();

    # 再把"tom"变为狗
    bless( $object, "dog" );
    $object->sleep();
    $object->bark();

    # 最后，再把"tom"变回人
    bless( $object, "person" );
    $object->sleep();
    $object->study();
}
&main();

# 程序运行时输出：
# tom is person, he is sleeping
# tom is person, he is studying
# tom is dog, he is sleeping
# tom is dog, he is barking
# tom is person, he is sleeping
