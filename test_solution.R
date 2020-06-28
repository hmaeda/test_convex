# Main test solution

# Summary of the ask:
# Step 1: Based on a command line parameter(s), uses AWS credentials corresponding to a profile in `~/.aws/credentials`, or corresponding to the default credentials provider chain (e.g. to use IAM Role on an EC2 instance).
# Step 2: Reads a file from S3 (bucket & key from command line args) that is assumed to be in parquet format, and it's assumed access has been granted
# Step 3: Print the second row in TSV format to standard

# This solution should be run from the command line as follows:
# $ Rscript test_solution.R profile=test_profile bucket=test_bucket key=test_key/file.parquet

# The main solution code is below:

# Load libraries
suppressPackageStartupMessages(require(aws.signature))
suppressPackageStartupMessages(require(aws.s3))
suppressPackageStartupMessages(require(arrow))


# Step0: Read command line arguments, split by '=' and convert to list
args <- strsplit(commandArgs(TRUE),'=')
args_list <- sapply(args,function(y){y[2]})
names(args_list) <- sapply(args,function(y){y[1]})


# Run step 1: Use credentials

## Check if profile arugment is given
if(any('profile'==names(args_list))){
  ### profile is given, so it is used
  use_credentials(profile=args_list['profile'])
} else {
  ### No profile provided so default is used
  use_credentials()
}



# Run step 2: Read parquet file from S3

## Work out file name:
file_name_from_key <- strsplit(args_list['key'],'/')
file_name_from_key <- file_name_from_key[[1]][length(file_name_from_key[[1]])]

## Download parquet file from S3 and save to disk
response <- s3HTTP(verb='GET',bucket=args_list['bucket'],path=paste0('/',args_list['key']),parse_response=FALSE,region='eu-west-1',write_disk=httr::write_disk(file_name_from_key,overwrite=TRUE),verbose=FALSE)


## Read in parquet file from disk
data_from_file <- read_parquet(file_name_from_key)



# Run step 3: Print the second row in TSV format to standard

## make tab seprarted values (TSV) as a string for output
desired_output <- paste0(data_from_file[2,],collapse='\t')

## Send string to standard out
write(desired_output, stdout())

