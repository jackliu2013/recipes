ref EXPR 
ref Returns a non-empty string if EXPR is a reference, the empty string otherwise . If EXPR is not specified,
    $_ will be used . The value returned depends on the type of thing the reference is a reference to  . Builtin types include
    :

      SCALAR 
      ARRAY 
      HASH 
      CODE 
      REF 
      GLOB 
      LVALUE 
      FORMAT 
      IO 
      VSTRING 
      Regexp

      If the referenced object has been blessed into a package, then that package name is returned instead . You can think
      of "ref" as a "typeof" operator.

      if ( ref($r) eq "HASH" ) {
          print "r is a reference to a hash.\n";
      }
      unless ( ref($r) ) {
          print "r is not a reference at all.\n";
      }

      The return value "LVALUE" indicates a reference to an lvalue that is not a variable . You get this from taking the 
      reference of function calls like "pos()" or "substr()" . "VSTRING" is returned if the reference points to a version string .

      The result "Regexp" indicates that the argument is a regular expression resulting from "qr//".

      See also perlref .

