# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  access_key = "SOME-ACCESS-KEY"
  secret_key = "SOME-SECRET-KEY"
  region = "us-west-2"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity_T2" {
    count = "4"
    ami = "ami-0a243dbef00e96192"
    instance_type = "t2.micro"
    subnet_id = "subnet-7c03c419"
    tags = {
        Project = "Udacity Cloud Architect Project"
        Name = "Udacity T2"
    }
}


# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity_M4" {
  count = "2"
    ami = "ami-0a243dbef00e96192"
    instance_type = "m4.large"
    subnet_id = "subnet-7c03c419"
    tags = {
        Project = "Udacity Cloud Architect Project"
        Name = "Udacity M4"
    }
}