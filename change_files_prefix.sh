#!/bin/bash

# when user doesn't input arguments, we should prompt message
# for a user to input the old and new prefix.
if [ "$#" = "2" ] ; then
    # set arg1 = old prefix, and arg2 = new prefix.
    old=$1
    new=$2
else
    printf 'Enter old prefix :'
    read -r old

    printf 'Enter new prefix :'
    read -r new

fi
 

 


# to find the match file with old prefix.
# and save to a file
tmpFile=".found_file.txt"
find -iname "${old}*" > $tmpFile

echo " the following file(s) will be changed."
echo "_______________________________"
while read -r fileName; do
    echo "${fileName}" 
done < $tmpFile
# to let a user to double check the change.
echo "_______________________________"
echo "replace prefix from $old to $new? (y/n)" 
read ans

if [ "$ans" != "y" ]; then
    exit
fi

# read in each line from tmpFile 
# and assign its content to fileName.  
# we will change the prefix from old to new here.
while read -r fileName; do

    # Step1: to separate the path and file from fileName.

    # to deal with the files in the subfolders.
    # echo ${fileName}
    file=${fileName##./*/} # rmeove the path ex: ./xyz/abc/
    path=${fileName%$file}      
    

    # to deal with the files in the current folder.
    # their path should be ./
    if [ "$file" = "$fileName" ]; then
        file=${fileName#./}
        path="./"
    fi


    echo "move ${path}${file} "
    echo "to   ${path}${new}${file:${#old}}"
    # note:
    # ${file:${#old}} is to slice the string 'file'
    # and let it start from the ${#old}, which is the size 
    # of the old prefix.

    mv "${path}${file}"  "${path}${new}${file:${#old}}"
    echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - -"
done < $tmpFile

# we finish the task, and then
# we can remove the tmpFile which store the fileNames.
rm $tmpFile 
