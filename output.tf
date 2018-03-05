output "public_subnets" {
  value = ["${aws_subnet.public.*.id}"]
}
output "private_subnets" {
  value = ["${aws_subnet.private.*.id}"]
}

output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "public_route_table_ids" {
  value = ["${aws_route_table.public.*.id}"]
}

output "private_route_table_ids" {
  value = ["${aws_route_table.private.*.id}"]
}

output "default_security_group_id" {
  value = "${aws_vpc.vpc.default_security_group_id}"
}

output "igw_id" {
  value = "${aws_internet_gateway.gateway.id}"
}
