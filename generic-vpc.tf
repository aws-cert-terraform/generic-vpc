
resource "aws_vpc" "generic" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = var.tags
}

resource "aws_internet_gateway" "generic" {
    vpc_id = "${aws_vpc.generic.id}"
}


/*
  Public Subnet
*/
resource "aws_subnet" "us-east-2a-public" {
    vpc_id = "${aws_vpc.generic.id}"

    cidr_block = "${cidrsubnet(var.vpc_cidr, 4, 1)}"
    availability_zone = "us-east-2a"

    tags = var.tags
}


resource "aws_subnet" "us-east-2b-public" {
    vpc_id = "${aws_vpc.generic.id}"

    cidr_block = "${cidrsubnet(var.vpc_cidr, 4, 2)}"
    availability_zone = "us-east-2b"

    tags = var.tags
}


resource "aws_route_table" "us-east-2a-public" {
    vpc_id = "${aws_vpc.generic.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.generic.id}"
    }

    tags = {
        Name = "Public Subnet"
    }
}

resource "aws_route_table_association" "us-east-2a-public" {
    subnet_id = "${aws_subnet.us-east-2a-public.id}"
    route_table_id = "${aws_route_table.us-east-2a-public.id}"
}
