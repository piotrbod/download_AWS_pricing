#!/bin/bash

allservicesdir="allservices"

cd $allservicesdir

ls -Al | tail -n +2 | tr -s ' ' | cut -f9- -d' ' > "../allfiles.txt"

input="../allfiles.txt"

while IFS= read -r line
do

        columnno=`cat $line | sed -n '1p' | awk -F',' 'NR==1{print NF}'`
        servicename=`echo $line | cut -d "-" -f2 | cut -d "." -f1`

        x=1

        while [ $x -le $columnno ]
        do

                colvalue=`head -n 1 $line | cut -d "," -f$x | sed s/\"//g`


### if there are more duplicates while crawling in Glue add more exceptions after storage|\deployment below ###

                isitstorage=`echo $colvalue | grep -i 'storage|\deployment'`

                if [ ! -z "$isitstorage" ]; then

                        sed -i -e "1s|$colvalue|$servicename-$colvalue|1" $line

                fi

                x=$((x+1))

        done

done < "$input"
