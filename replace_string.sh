#!/bin/bash
# replace string1 to string2 in multiple files.
# usage ./replace_string_multi_files.sh string1 string2

# when user doesn't input arguments, we should prompt message
# for user to input the old and new string.
if [ "$#" = "2" ] ; then
    old_string=$1
    new_string=$2
 
else
   
    printf  "(1)replace text or (2)redo previous action? (1/2) "
    read -r ans

    if [ "$ans" = "1" ]; then
	printf 'Enter old string : '
    	read -r old_string
 
    	printf 'Enter new string : '
    	read -r new_string
    elif [ "$ans" = "2" ]; then


	while read -r fileName; do
	    
	    echo "apply redo for ${fileName}"
	   
	    # apply patches
	    patch < .${fileName}.patch 1>/dev/null;

	    rm .${fileName}.patch

	done < .fileList.txt
	
	exit
    fi
fi

 


# we also avoid to change this script.
thisScript=$0
thisScript=${thisScript#"./"}

# to show which file in the current location has the string1 in it.
echo "we have $old_string in the following file(s)"
echo "_______________________________"
grep -r "$old_string" * --color --exclude=$thisScript 
echo "_______________________________"
echo "replace $old_string to $new_string? (y/n)" 
read ans

#########################################

if [ "$ans" = "y" ];
then

    # redirect filenames to a temp file.
    grep -lr "$old_string" * --exclude=$thisScript > .fileList.txt

    # read in each line and assign it to fileName	
    # and then we do the substitution. 
    while read -r fileName; do
	   
	   cp $fileName ${fileName}.orig

	   echo "edited $fileName" 

	   sed  -i 's|'"$old_string"'|'"$new_string"'|g' "${fileName}"
	
	   # make patches for backup.
	   diff -u $fileName ${fileName}.orig > .${fileName}.patch

	   # now we are save to remove .orig file
	   rm ${fileName}.orig

    done < .fileList.txt
   
    # rm .fileList.txt
fi



