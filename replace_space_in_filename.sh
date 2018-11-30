#!/bin/bash

# PURPOSE:
# replace spaces in a filename
# ex. abc def.txt to abc_def.txt

# search for the files containing space(s)
# and redirect results to a temp file.
find .  | grep " " > .tempfileXXX



# let user confirm the change.
echo " the following file(s) will be changed."
echo "_______________________________"
while read -r fileName; do
    echo "${fileName}" 
done < .tempfileXXX
# to let a user to double check the change.
echo "_______________________________"
echo "replace spaces to underscores ? (y/n)" 
read ans

if [ "$ans" != "y" ]; then
    exit
fi

 

while read -r fileName; do
   
   # replace a space to a underscore at each occurance.
   newfileName=${fileName// /_} 

   # replace a space to escape + space at each occurance.
   fileName2=${fileName// /\ }   
   
   echo "old:" ${fileName2}
   echo "new:" ${newfileName}
   mv "${fileName2}" "${newfileName}"

done < .tempfileXXX

rm .tempfileXXX


