output "vpc_id" {
    value = "${aws_vpc.generic.id}"
}

output "public_subnet" {
    value = "${aws_subnet.us-east-2a-public.id}"
}
