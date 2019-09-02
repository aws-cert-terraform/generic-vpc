

variable "vpc_cidr" {
    description = "Passed in cidr map"
}

variable "azs" {
    default = {
        "us-east-2" = "us-east-2a,us-east-2b"
        # use "aws ec2 describe-availability-zones --region us-east-1"
        # to figure out the name of the AZs on every region
    }
}

variable "max_subnets" {
  default     = "6"
}

variable "subnets" {
    default = 1
}

variable "tags" {
    description = "Inherited tags. Cannot be empty for enforcement."
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

