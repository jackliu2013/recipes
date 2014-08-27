#! /bin/bash
 
echo "----------------------------------IFS test--------------------------------"
echo "default \$IFS is:(ASSII in hexadecimal value)"
echo -n "$IFS" | xxd -g 1 | awk -F":" '{print $2}' | awk -F" " '{print $1, $2, $3}'
echo "by default, IFS should be a SPACE, a HORIZONTAL TAB, or a LINC FEED."
 
function output_args_one_per_line()
{
    arg_list=$*
    echo "\$*='$*'"
    for arg in $arg_list
    do
       echo "[$arg]"
    done
}
 
echo "--------------------------------------------------------------------------"
echo "set IFS=' ' #dealing with SPACE in IFS is different with other chars."
echo "var=' a b c '"
IFS=' '
var=" a b c "
output_args_one_per_line $var
 
echo "--------------------------------------------------------------------------"
echo "set IFS=':'"
echo "var='::a:b::c:::'"
IFS=':'
var="::a:b::c:::"
output_args_one_per_line $var
 
echo "--------------------------------------------------------------------------"
echo "set IFS='+:-;' #but \$* just use 1st char in IFS as the separator."
echo "var='::a:b::c:::'"
IFS='+:-;'
var="::a:b::c:::"
output_args_one_per_line $var
 
echo "--------------------------------------------------------------------------"
echo "set IFS='-+:;' #but \$* just use 1st char in IFS as the separator."
echo "var='::a:b::c:::'"
IFS='-+:;'
var="::a:b::c:::"
output_args_one_per_line $var
 
echo "--------------------------The END of IFS test-----------------------------"
