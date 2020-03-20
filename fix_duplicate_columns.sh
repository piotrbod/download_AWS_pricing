#!/bin/bash

allservicesdir="allservices"
loadfiles="../allfiles.txt"

cd $allservicesdir
ls -Al | tail -n +2 | tr -s ' ' | cut -f9- -d' ' > $loadfiles

### Remove redundant comments from each file ###
allfiles="../allfiles.txt"

input="$allfiles"
while IFS= read -r line
do

        echo "$line"

        servicename=`echo $line | cut -d "-" -f2 | cut -d "." -f1`
        colvalue=`head -n 1 $line | cut -d "," -f1 | sed s/\"//g`

        if [ "$colvalue" == "SKU" ]; then

                echo ""
                echo "You did run this script before. Run download_prices.sh first and let it clean working directories."
                echo ""
                exit 0

        fi

        sed -i -e 1,5d $line

        columnno=`cat $line | sed -n '1p' | awk -F',' 'NR==1{print NF}'`

        x=1
        while [ $x -le $columnno ]
        do

                colvalue=`head -n 1 $line | cut -d "," -f$x | sed s/\"//g`

                ### if there are more duplicates while crawling in Glue add more exceptions after storage\|deployment below ###

                isitstorage=`echo $colvalue | grep -i 'storage\|deployment'`

                if [ ! -z "$isitstorage" ]; then

                        echo "isitstorage value is: $isitstorage"

                        sed -i -e "1s|$colvalue|$servicename-$colvalue|1" $line

                fi

                x=$((x+1))

        done

done < "$input"
