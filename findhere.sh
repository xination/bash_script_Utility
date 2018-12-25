#!/bin/bash


searchString=$1
searchSuffix=$2
additionalString=$3


if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then     
    echo "-h or --help    : print help message"
    echo " usage:  ./script keyword1  "
    echo " usage:  ./script keyword1 suffix "
    echo " usage:  ./script keyword1 "" keyword2 "
    echo " usage:  ./script keyword1 suffix keyword2 "
    echo " keyword1 = red and keyword2 = blue color"
    
elif [ -z "$additionalString" ]; then
    # usage: ./script keyword1  
    find . -iname "*${searchString}*${searchSuffix}" 2>/dev/null | \
        grep -i --color=always ${searchString} 
else
    # usage: ./script keyword1 suffix keyword2
    # usage" ./script keyword1 "" keyword2 ( just search keyword1 and keyword2 )
    find . -iname "*${searchString}*${searchSuffix}" 2>/dev/null | \
        grep -i --color=always ${searchString} | \
        GREP_COLORS="mt=01;34" grep ${additionalString}
fi 
