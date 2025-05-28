# terraform.tfvars

# Replace with your actual AWS credentials (do not share publicly)
#aws_access_key = "DO NOT NEED, using env variables for AWS credentials"
#aws_secret_key = "DO NOT NEED, using env variables for AWS credentials"

# Region to deploy in
region = "us-east-1"

# Public AMI ID (Amazon Linux 2023, as an example)
ami_id = "ami-0c2b8ca1dad447f8a" # This is the ID I got from my direct account
# backup_id "ami-0c2b8ca1dad447f8a" # This ID was recommended as being the valid ID

# Instance type
instance_type = "t2.micro"

# Key pair name (must already exist in your AWS account)
key_name = "project-key"