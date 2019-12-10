resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"
  tags                 = "${merge(var.tags, map("Name", format("%s", var.name)))}"
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags   = "${merge(var.tags, map("Name", format("%s-igw", var.name)))}"
}

resource "aws_route_table" "public" {
  vpc_id           = "${aws_vpc.vpc.id}"
  propagating_vgws = ["${var.public_propagating_vgws}"]
  tags             = "${merge(var.tags, map("Name", format("%s-rt-public", var.name)))}"
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gateway.id}"
}

resource "aws_route_table" "private" {
  vpc_id           = "${aws_vpc.vpc.id}"
  propagating_vgws = ["${var.private_propagating_vgws}"]
  count            = "${length(var.azs)}"
  tags             = "${merge(var.tags, map("Name", format("%s-rt-private-%s", var.name, element(var.azs, count.index))))}"
}

resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.private_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"
  count             = "${length(var.private_subnets)}"
  tags              = "${merge(var.tags, map("Name", format("%s-subnet-private-%s", var.name, element(var.azs, count.index))), map("Tier", "private"))}"
}

resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.public_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"
  count             = "${length(var.public_subnets)}"
  tags              = "${merge(var.tags, map("Name", format("%s-subnet-public-%s", var.name, element(var.azs, count.index))), map("Tier", "public"))}"

  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
}

resource "aws_route_table_association" "private" {
  count          = "${length(var.private_subnets)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnets)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}
