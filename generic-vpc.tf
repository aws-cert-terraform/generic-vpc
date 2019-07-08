
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
