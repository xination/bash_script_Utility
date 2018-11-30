# General guide
After you download a bash script,and you may need to grant the script 'run' permission. <br>
To do this, you can type: <br>
$ chmod 755 script.sh <br> 
In the following, I use 'script.sh' for my short-handed notation.


# File description  
## replace_strings_in_multiple_files
a simple bash script for replacing string1 to string2 in multiple files. ( using sed ) <br>
usage: ./script.sh old_string new_string <br>
or just ./script.sh  (the prompt will guide you to input strings) <br>
then it will pop up the found files and the corresponding lines. <br>
It wait a user to confirm, then old_string is replaced by new_string. <br>
The script also create backup, just in case you want to redo. <br>
You can freely change the script name. <br>

## change_files_prefix.sh
a simple bash script that allows you to change the prefix of multiple files in the current folder and subfolders. <br>
usage: ./script.sh old_prefix new_prefix <br>
or just ./script.sh (the prompt will guide you to input strings) <br>
For example, you have B1xxx.txt, B1yyy.txt and ./test/B1zzz.txt, <br>
and you want to change the 'B1' prefix to 'A1'. You can type in <br>
./script.sh B1 A1 <br>


## replace_space_in_filename.sh
This script allows you to change the spaces to underscores in filenames. 
The script will search the files which contain spaces under the current folder.
It will pop up information for the found files for a user to confirm the 
change of filenames.

