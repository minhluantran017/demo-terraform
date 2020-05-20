//# Create VPC
resource "aws_vpc" "vpc" {
    cidr_block  = lookup(var.vpc, "cidr")
    tags = merge(local.common_tags,
        map("Name", "${var.project}-vpc"))
}

//# Create public subnet
resource "aws_subnet" "public-subnet" {
    vpc_id     = "${aws_vpc.vpc.id}"
    cidr_block = lookup(var.vpc, "public_cidr")
    tags = merge(local.common_tags,
        map("Name", "${var.project}-public-subnet"))
}

//# Create private subnet
resource "aws_subnet" "private-subnet" {
    vpc_id     = aws_vpc.vpc.id
    cidr_block = lookup(var.vpc, "private_cidr")
    tags = merge(local.common_tags,
        map("Name", "${var.project}-private-subnet"))
}

//# Create internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id    = aws_vpc.vpc.id
    tags = merge(local.common_tags,
        map("Name", "${var.project}-igw"))
}

//# Create Elastic IP - Conditional
resource "aws_eip" "nat" {
    count   = "${var.enable_nat_gw == "true" ? 1 : 0}"
    vpc     = true
}

//# Create NAT gateway - conditional
resource "aws_nat_gateway" "nat-gw" {
    count           = "${var.enable_nat_gw == "true" ? 1 : 0}"
    //# Attach EIP to NAT GW
    allocation_id   = aws_eip.nat.id
    subnet_id       = aws_subnet.public-subnet.id

    tags = merge(local.common_tags,
        map("Name", "${var.project}-nat-gw"))
}

//# Create route table
resource "aws_route_table" "public-route-table" {
    vpc_id  = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = merge(local.common_tags,
        map("Name", "${var.project}-route-table"))
}
//# Associate to subnet
resource "aws_route_table_association" "a" {
    subnet_id      = aws_subnet.public-subnet.id
    route_table_id = aws_route_table.pulic-route-table.id
}

//# Create security groups
resource "aws_security_group" "public-sg" {
    Name        = "${var.project}-public-sg"
    vpc_id      = aws_vpc.vpc.id
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH access from internet"
    }
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSL access from internet"
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Web access (Apache, Nginx,..) from internet"
    }
    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Web access (Tomcat,...) from internet"
    }
    egress {
        from_port   = 0
        to_port     = 0
        //# "-1" equals all protocols
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = merge(local.common_tags,
        map("Name", "${var.project}-public-sg"))
}

resource "aws_security_group" "private-sg" {
    Name        = "${var.project}-private-sg"
    vpc_id      = aws_vpc.vpc.id
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        //# "self=true" allows itself as a source
        self        = true
        description = "Internal access"
    }
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        security_groups = ["${aws_security_group.public-sg.id}"]
        description = "Access from public subnets"
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(local.common_tags,
        map("Name", "${var.project}-private-sg"))
}

