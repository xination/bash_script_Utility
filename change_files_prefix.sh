#!/bin/bash
# to avoid we miss arguments.
if [ "$1" = "" ] || [ "$2" = "" ]; then
    echo " we need 2 arguments" 
    exit
fi

# set arg1 = old prefix, and arg2 = new prefix.
old=$1
new=$2
tmpFile=".found_file.txt"


# to find the match file with old prefix.
# and save to a file
find -iname "${old}*" > $tmpFile



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
