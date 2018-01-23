#!/bin/bash
# replace string1 to string2 in multiple files.
# usage ./replace_string_multi_files.sh string1 string2

# to avoid we miss arguments.
if [ "$1" = "" ] || [ "$2" = "" ]; then
    echo " we need 2 arguments" 
    exit
fi

# we also avoid to change this script.
thisScript=$0
thisScript=${thisScript#"./"}

# to show which file in the current location has the string1 in it.
echo "we have $1 in the following file"
echo "_______________________________"
grep -r "$1" * --color --exclude=$thisScript 
echo "_______________________________"
echo "replace $1 to $2? (y/n)" 
read ans

#########################################

if [ "$ans" = "y" ];
then

    # redirect filenames to a temp file.
    grep -lr "$1" * --exclude=$thisScript > .fileList.txt

    # read in each line and assign it to fileName	
    # and then we do the substitution. 
    while read -r fileName; do

	echo "edited $fileName" 

	sed  -i 's|'"$1"'|'"$2"'|g' "${fileName}"

    done < .fileList.txt
   
    rm .fileList.txt
fi


