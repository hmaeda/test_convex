# Test solution

## Purpose:
Use AWS credentials to read a parquet file from S3 and then output the second row

## The ask:
Steps asked for in the test by Sam Savage

Initial test context: Write an R script that does the following. Step 1 is the crux of the test, 2 & 3 are just bonus.

* Step 1: Based on a command line parameter(s), uses AWS credentials corresponding to a profile in `~/.aws/credentials`, or corresponding to the default credentials provider chain (e.g. to use IAM Role on an EC2 instance).
* Step 2: Reads a file from S3 (bucket & key from command line args) that is assumed to be in parquet format, and it's assumed access has been granted
* Step 3: Print the second row in TSV format to standard output

## The solution:
* The solution provided will run all three steps sequentially in the same R script (`test_solution.R`)
* The 'Installing dependencies' setup described below needs to be run beforehand before the solution can be run on a Linux machine
* To run the solution, please run the following line in the commandline as an example, however replacing values for: `test_profile`, `test_bucket`, `test_key/file.parquet` with your own values for your: AWS credentials profile, the relevant S3 bucket and the relevant key respectively.
```
$ Rscript test_solution.R profile=test_profile bucket=test_bucket key=test_key/file.parquet
```
* The solution uses the credentials (in `~/.aws/credentials`) to sign an HTTP GET request to download the parquet file to disk which is then read into R before printing the second row as a TSV format to the standard output.



## Pre-requisits:
* Linux OS (Ubuntu or Debian)
* sudo rights on machine (for setup)
* bash

All of the above software are assumed to already be installed as they are standard in most EC2 instances

## Installing dependencies

* If not already installed, git needs to be installed first to collect correct version of files

```
sudo apt install git
```

* Then, this repo needs to be cloned to collect all relevant files. To do this please run the following command:

```
$ git clone https://github.com/hmaeda/test_convex.git
```

* Next, having moved into the directory just created (`test_convex`), run `test_setup.sh` to setup R and the relevant libraries. To do this please run the following commands:

```
$ cd test_convex
$ bash test_setup.sh
```

## Running the solution
* N.B. This solution script assumes that the standard AWS credentials file already exists in `~/.aws/credentials` and the correct credentials values are already there. If this file is not there then please create it first before running the R script
* Run the `test_solution.R` file as follows but repalcing values for: `test_profile`, `test_bucket`, `test_key/file.parquet` with your own values for your: AWS credentials profile, the relevant S3 bucket and the relevant key respectively.

```
$ Rscript test_solution.R profile=test_profile bucket=test_bucket key=test_key/file.parquet
```

* N.B. This script assumes that the standard AWS credentials file already exists in `~/.aws/credentials` and the correct credentials values are already there.
* If no profile argument is given then the default profile in `~/.aws/credentials` will be used. To do this, run the R script in the following way:

```
$ Rscript test_solution.R bucket=test_bucket key=test_key/file.parquet
```

## Testing:
This solution was tested on a pre-built AMI on AWS. The details of the AMI are as follows:
* Ubuntu Server 18.04 LTS (HVM), SSD Volume Type - ami-089cc16f7f08c4457 (64-bit x86) / ami-025d2a3daf21de4b8 (64-bit Arm)
* Instance type: t2.large
* N.B. This AMI has git already installed so the installtion step of git is not necssary



