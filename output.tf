output "vpc_id" {
    value = "${aws_vpc.generic.id}"
}

output "public_subnets" {
    value = ["${aws_subnet.us-east-2a-public.id}", "${aws_subnet.us-east-2a-public.id}"]
}
