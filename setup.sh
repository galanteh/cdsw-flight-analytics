#!/bin/bash
echo "Creating a local data directory."
mkdir -p flight-analytics/data
cd flight-analytics/data

echo "Getting the tables in parquet format."
wget https://ibis-resources.s3.amazonaws.com/data/airlines/airlines_parquet.tar.gz
tar xvzf airlines_parquet.tar.gz

echo "Uploading parquet tables to hadoop file system."
hadoop fs -mkdir /tmp/airlines/
hadoop fs -put airlines_parquet/* /tmp/airlines/

echo "Getting the raw data in CSV."
wget http://stat-computing.org/dataexpo/2009/airports.csv

echo "Uploading the raw to hadoop file system."
hadoop fs -mkdir /tmp/airports
hadoop fs -put airports.csv /tmp/airports/
hadoop fs -chmod 777 /tmp/airlines /tmp/airports

echo "Removing local data directory."
rm -rf flight-analytics/data

echo "Installing R packages"
R -e "install.packages('maps', repos='http://cran.rstudio.com/')"
R -e "install.packages('DBI', repos='http://cran.rstudio.com/')"
R -e "install.packages('sparklyr', repos='http://cran.rstudio.com/')"
R -e "install.packages('ggplot2', repos='http://cran.rstudio.com/')"
R -e "install.packages('geosphere', repos='http://cran.rstudio.com/')"
