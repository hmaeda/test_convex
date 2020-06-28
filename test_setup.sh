!#/bin/bash

# This bash script setups R and installs the relevant libraries

# Update apt
sudo apt update -y

# Install python pip to install AWS CLI (to correctly setup credentials file, but not necessary to run R script)
sudo apt install -y python3-pip
pip3 install --upgrade --user awscli
sudo apt install -y awscli

# Use apt to install base R (and dev versions of XML, libcurl4-openssl and libssl for HTTP type connections)
sudo apt install -y r-base
sudo apt install -y libxml2-dev libcurl4-openssl-dev libssl-dev

echo 'R installed!'

# install R libraries from the CRAN mirror https://cloud.r-project.org (N.B. Installing the arrow package takes a while) 
sudo Rscript -e 'install.packages(c("aws.signature","aws.s3","arrow"),repos="https://cloud.r-project.org")'
echo 'R libraries installed'

echo 'test_setup.sh script Complete!'
