
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
  NAT Instance
*/
resource "aws_security_group" "nat" {
    name = "${var.name}_vpc_nat"
    description = "Allow traffic to pass from the private subnet to the internet"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${aws_subnet.us-east-2a-private.cidr_block}"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${aws_subnet.us-east-2a-private.cidr_block}"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    egress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "${var.name}-vpc-${var.environment}"
    }
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

/*
  Private Subnet
*/
resource "aws_subnet" "us-east-2a-private" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${cidrsubnet(var.vpc_cidr, 4, 2)}"
    availability_zone = "us-east-2a"

    tags {
        Name = "Private Subnet"
    }
}
