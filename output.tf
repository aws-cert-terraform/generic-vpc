output "vpc_id" {
    value = "${aws_vpc.generic.id}"
}

output "public_subnets" {
    value = {
        "2a": aws_subnet.us-east-2a-public.id,
        "2b": aws_subnet.us-east-2b-public.id
    }
}
