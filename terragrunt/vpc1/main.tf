# Create VPC
resource "aws_vpc" "vpc" {
    cidr_block  = lookup(var.vpc1, "cidr")
    tags = merge(local.common_tags,
        map("Name", "${var.project}-vpc1"))
}

# Create public subnet
resource "aws_subnet" "public-subnet" {
    vpc_id     = aws_vpc.vpc.id
    cidr_block = lookup(var.vpc1, "public_cidr")
    tags = merge(local.common_tags,
        map("Name", "${var.project}-public-subnet1"))
}

# Create private subnet
resource "aws_subnet" "private-subnet" {
    vpc_id     = aws_vpc.vpc.id
    cidr_block = lookup(var.vpc1, "private_cidr")
    tags = merge(local.common_tags,
        map("Name", "${var.project}-private-subnet1"))
}