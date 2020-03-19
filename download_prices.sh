#!/bin/bash

allservicesdir="allservices"

if [ -f "index.json" ]; then

	echo "" && echo "You have an index file in this directory. Do you want to replace it with a new one?"
	echo "Press Y if you want to proceed and press Enter" && echo ""


	read newindex

	if [ "$newindex" == "y" ] || [ "$newindex" == "Y" ]; then

		rm -rf index.json

	else

		echo "ok - run me in a different directory then...exiting now"
                exit 0

	fi

fi
wget https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/index.json

if [ -d $allservicesdir ]; then

	echo "The $allservicesdir directory exists. We will clean it and replace a content with new prices."
	echo "Press Y if you want to proceed."

        read cleandir

        if [ "$cleandir" == "y" ] || [ "$cleandir" == "Y" ]; then

		rm -rf $allservicesdir/*

	else

		echo "ok - run me in a different directory then...exiting now"
                exit 0

        fi

else

	mkdir $allservicesdir

fi

url1="https://pricing.us-east-1.amazonaws.com"

cat index.json | grep currentVersionUrl | cut -d '"' -f4 | sed 's,.json,.csv,g' > services.txt

cd $allservicesdir

input="../services.txt"

while IFS= read -r line
do

	service=`echo $line | cut -d '/' -f5`
	wget -O $service.csv $url1$line

done < "$input"


cd ..

zip -r $allservicesdir.zip $allservicesdir

