//# Create groups
resource "aws_iam_group" "developers" {
    name = "developers"
}

resource "aws_iam_group" "devops" {
    name = "devops"
}

resource "aws_iam_group" "managers" {
    name = "managers"
}

//# Create users
resource "aws_iam_user" "dev" {
    count= length(var.dev_user) 
    name = element(var.dev_user, count.index)
}

resource "aws_iam_user" "devops" {
    count= length(var.devops_user) 
    name = element(var.devops_user, count.index)
}

resource "aws_iam_user" "manager" {
    count= length(var.manager_user)
    name = element(var.manager_user, count.index)
}

//# Create Jenkins Slave role
resource "aws_iam_role" "jenkins-slave-role" {
    name = "jenkins-slave-role"
    assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
            }
        ]
    }
    EOF
}

//# Create Jenkins Slave instance profile
resource "aws_iam_instance_profile" "jenkins-slave-profile" {
    name = "jenkins-slave-profile"
    role = "${aws_iam_role.jenkins-slave-role.name}"
}

//# Create policy for Developers
resource "aws_iam_group_policy" "dev-group-policy" {
    name    = "dev-group-policy"
    group   = "${aws_iam_group.developers.id}"
    policy  = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Action": [
                "ec2:*",
                "s3:*",
                "dynamodb:*",
                "lambda:*",
                "cloudwatch:*"
            ],
            "Effect": "Allow",
            "Resource": "*"
            }
        ]
    }
    EOF
}

//# Create policy for DevOps
resource "aws_iam_group_policy" "devops-group-policy" {
    name = "devops-group-policy"
    group   = "${aws_iam_group.devops.id}"
    policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Action": [
                "*"
            ],
            "Effect": "Allow",
            "Resource": "*"
            }
        ]
    }
    EOF
}

//# Create policy for Managers
resource "aws_iam_group_policy" "managers-group-policy" {
    name = "managers-group-policy"
    group   = "${aws_iam_group.managers.id}"
    policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Action": [
                "ec2:Describe*",
                "s3:List*",
                "s3:Get*",
                "dynamodb:Get*",
                "cloudwatch:List*",
                "cloudwatch:Describe*",
                "cloudwatch:Get*"
            ],
            "Effect": "Allow",
            "Resource": "*"
            }
        ]
    }
    EOF
}

//# Create policy for Jenkins Slave role
resource "aws_iam_role_policy" "jenkins-slave-role-policy" {
    name = "jenkins-slave-role-policy"
    role    = "${aws_iam_role.jenkins-slave-role.name}"
    policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Action": [
                "ec2:*",
                "s3:*",
                "dynamodb:*",
                "lambda:*",
                "cloudwatch:*"
            ],
            "Effect": "Allow",
            "Resource": "*"
            }
        ]
    }
    EOF
}

//# Attach users to groups
resource "aws_iam_user_group_membership" "developers" {
    count   = length(var.dev_user)
    user    = element(var.dev_user, count.index)
    groups = [ "${aws_iam_group.developers.name}" ]
}

resource "aws_iam_user_group_membership" "devops" {
    count   = length(var.devops_user)
    user    = element(var.devops_user, count.index)
    groups = [ "${aws_iam_group.devops.name}" ]
}

resource "aws_iam_user_group_membership" "managers" {
    count   = length(var.manager_user)
    user    = element(var.manager_user, count.index)
    groups = [ "${aws_iam_group.managers.name}" ]
}