#!/bin/bash
# replace string1 to string2 in multiple files.
# usage ./replace_string_multi_files.sh string1 string2

# to show which file in the current location has the string1
echo "we have $1 in the following file"
echo "_______________________________"
grep -r "$1" * --color 
echo "_______________________________"
echo "replace $1 to $2? (y/n)" 
read ans

#########################################

if [ "$ans" = "y" ];
then
    # the string1 and string2 are case sensitive.
    # but exclude this script.
    find ./ -type f \( ! -iname "replace*.sh" \) -exec sed -i 's|'"$1"'|'"$2"'|g' {} \;
fi
