project         = "demo-terraform"
environment     = "${ENVIRON}"
uid             = "${BUILD_NUMBER}"

aws_region      = "${AWS_REGION}"
s3_bucket       = "${S3_BUCKET}"
vpc             = { "cidr"          = "10.69.0.0/16",
                    "public_cidr"   = "10.69.10.0/24",
                    "private_cidr"  = "10.69.20.0/24" }
enable_nat_gw   = ${ENABLE_NAT}

dev_user        = [ "developer1",
                    "developer2" ]
devops_user     = [ "devops1",
                    "devops2" ]
manager_user    = [ "manager1" ]


app-vm  = { "count"   = 1,
            "type"    = "t2.micro",
            "ebs_size"= 20 }
db-vm   = { "count"   = 1,
            "type"    = "t2.micro",
            "ebs_size"= 20 }
lb-vm   = { "count"   = 0,
            "type"    = "t2.micro",
            "ebs_size"= 20 }

create_eks      = ${CREATE_EKS}