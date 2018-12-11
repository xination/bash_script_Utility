#!/bin/bash

### check whether we have ./src and ./include folder 
dirs=$@
if [ -z "$dirs" ]; then
    
    # if no input from user, then 
    # we search for  ./src and ./include     
    if [ -e "src" ]; then
        dirs=$dirs" ./src"
    fi

    if [ -e "include" ]; then
        dirs=$dirs" ./include"
    fi
fi

if [ -z "$dirs" ]; then  
    echo "Error no source folders are set"   
    echo "./this_script folder1 folder2 ... " 
    exit 1 
else

    echo " the following the sources will be into database"
    echo " all *.c* and *.h* will be in the cscope database"
    echo " all selected folders  in the ctags database"
    for dir in $dirs
    do
      echo $dir 
    done
fi

 
printf  "\npress y to continue : "
read -r ans
if [ "$ans" != "y" ]; then
  echo "bye~"
  exit
fi
 

#=====================================================
echo " "
echo " create database by cscope"
echo " search for *.c* and *.h* files "

echo "" > cscope.files # create an empty file.

for dir in "$@"
do
  find $dir -iname "*.c*" -or -iname "*.h*" >> cscope.files
done

cscope -q -R -b -i cscope.files 
echo "cscope done"


#=====================================================
echo " "
echo " create database by ctags"
ctags -R ${dirs}
echo "ctags done"
