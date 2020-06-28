data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"] # Canonical
}

resource "aws_instance" "app-vm" {
    count = lookup(var.app_vm, "count")
    ami           = data.aws_ami.ubuntu.id
    instance_type = lookup(var.app_vm, "type")
    subnet_id   = aws_subnet.public-subnet.id
    security_groups = [ aws_security_group.public-sg.id ]
    user_data = "#!/bin/bash \necho Hello"
    ebs_block_device {
        device_name = "/dev/vda"
        volume_type = "gp2"
        volume_size = lookup(var.app_vm, "ebs_size")
    }
    tags = {
        Name = "${locals.base_name}-app-vm"
    }
}

resource "aws_instance" "db-vm" {
    count = lookup(var.db_vm, "count")
    ami           = data.aws_ami.ubuntu.id
    instance_type = lookup(var.db_vm, "type")
    subnet_id   = aws_subnet.public-subnet.id
    security_groups = [ aws_security_group.public-sg.id ]
    user_data = "#!/bin/bash \necho Hello"
    ebs_block_device {
        device_name = "/dev/vda"
        volume_type = "gp2"
        volume_size = lookup(var.db_vm, "ebs_size")
    }
    tags = {
        Name = "${locals.base_name}-db-vm"
    }
}

resource "aws_instance" "lb-vm" {
    count = lookup(var.lb_vm, "count")
    ami           = data.aws_ami.ubuntu.id
    instance_type = lookup(var.lb_vm, "type")
    subnet_id   = aws_subnet.public-subnet.id
    security_groups = [ aws_security_group.public-sg.id ]
    user_data = "#!/bin/bash \necho Hello"
    ebs_block_device {
        device_name = "/dev/vda"
        volume_type = "gp2"
        volume_size = lookup(var.lb_vm, "ebs_size")
    }
    tags = {
        Name = "${locals.base_name}-lb-vm"
    }
}