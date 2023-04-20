# cp-access-log.sh
# This script downloads the file 'web-server-access-log.txt.gz'
# from "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/".
echo "downloading the data"
wget  https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz
echo "unzip the data"
gunzip -f web-server-access-log.txt.gz  
# The script then extracts the .txt file using gunzip.
echo "extract the data"
cut -d"#" -f1-4 web-server-access-log.txt > extracted_data.txt
 
# The .txt file contains the timestamp, latitude, longitude 
# and visitor id apart from other data.

# Transforms the text delimeter from "#" to "," and saves to a csv file.
echo "transforming the data"
tr "#" "," <extracted_data.txt> tranformed_data.csv
# Loads the data from the CSV file into the table 'access_log' in PostgreSQL database.
echo "Loading data"
echo "\c postgres;\COPY access_log  FROM '/mnt/c/Users/chand/ubuntu_apps/tranformed_data.csv' DELIMITERS ',' CSV HEADER;" | sudo -u postgres psql 