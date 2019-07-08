

variable "aws_access_key" {
    description = "The AWS access key."
    default = "<...>"
}

variable "aws_secret_key" {
    description = "The AWS secret key."
    default = "<...>"
}
#
variable "aws_region" {
    description = "The AWS region to create resources in."
    default = "us-east-2"
}

variable "vpc_cidr" {
    default = "172.30.0.0/20"

}

variable "azs" {
    default = {
        "us-east-2" = "us-east-2a,us-east-2b"
        # use "aws ec2 describe-availability-zones --region us-east-1"
        # to figure out the name of the AZs on every region
    }
}

variable "name" {
    default = "generic-vpc"
}

variable "project" {
    default = "aws-cert"
}


variable "owner" {
    default = "icullinane"
}


variable "environment" {
    default = "dev"
}

