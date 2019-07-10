
resource "aws_vpc" "generic" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "${var.name}-${var.environment}"
        Project = "${var.project}"
        Owner = "${var.owner}"
        Environment = "${var.environment}"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}

/*
  Public Subnet
*/
resource "aws_subnet" "us-east-2a-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${cidrsubnet(var.vpc_cidr, 4, 1)}"
    availability_zone = "us-east-2a"

    tags {
        Name = "Public Subnet"
    }
}

resource "aws_route_table" "us-east-2a-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "Public Subnet"
    }
}

resource "aws_route_table_association" "us-east-2a-public" {
    subnet_id = "${aws_subnet.us-east-2a-public.id}"
    route_table_id = "${aws_route_table.us-east-2a-public.id}"
}
