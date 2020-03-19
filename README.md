# download_AWS_pricing
This simple script helps to download prices for all AWS services in CSV format

#how to run
1. Login to your Linux
2. Install zip
(on ubuntu / debian) sudo apt -y install zip
(on redhat / centos) sudo yum -y install zip

3. Download this script to any Linux
wget https://github.com/piotrbod/download_AWS_pricing/blob/master/download_prices.sh

4. Make it executable
chmod +x download_prices.sh

5. Run it
./download_prices.sh

6. The zip file containing all services CSV files is created
ls -l

allservices.zip

7. When you open the zip you will see one CSV file per each AWS service
