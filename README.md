# download_AWS_pricing
This simple script helps to download prices for all AWS services in CSV format.

# How to run
## 1. Login to your Linux
## 2. Install zip

--- (on ubuntu / debian) sudo apt -y install zip

--- (on redhat / centos) sudo yum -y install zip


## 3. Download this script to any Linux

--- wget https://github.com/piotrbod/download_AWS_pricing/blob/master/download_prices.sh


## 4. Make it executable

--- chmod +x download_prices.sh


## 5. Run it

--- ./download_prices.sh


## 6. The zip file containing all services CSV files is created

--- ls -l

--- allservices.zip


## 7. When you open the zip you will see one CSV file per each AWS service

## 8. You can also create one huge file if you need. To do it run:
--- chmod +x fix_duplicate_columns.sh
--- ./fix_duplicate_columns.sh

## 9. It will change the files so they don't have unnecessary comments at the top

## 10. Upload all of those files to S3
--- aws s3 cp --recursive allservices s3://your-s3-bucket/and-directory/

## 11. Open AWS Console and go to Services -> Glue -> Crawlers and add a Crawler

## 12. Point it to your S3 so it can crawl your data. It will create a table for you

## 13. Open Athena service and query that table
--- SELECT * FROM "your-database-name.your-table-name"

## 14. You can download the result. It will be also available in your S3 soon.#

