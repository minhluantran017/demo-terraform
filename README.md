# Demo Terraform
A demo Terraform usage and templates.

![](https://github.com/minhluantran017/demo-terraform/workflows/Check%20syntax/badge.svg)

## 1. Installation

```shell
TERRAFORM_VER=`curl -sS https://releases.hashicorp.com/terraform/ | grep href | head -2 | tail -1 | awk -F/ '{print $3}'`
curl -o terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip
unzip terraform.zip
sudo mv terraform /usr/local/bin/terraform
rm -f terraform.zip
terraform version
```

## 2. Getting Started

Check out source code:
```shell
git clone https://github.com/minhluantran017/demo-terraform.git
cd demo-terraform
```

Code structure:
```shell
.
|____<provider>             # Each provider is a directory
|    |____provider.tf       # Contains general configurations for this provider
|    |____<...>.tf          # Contains TF plans for components
|    |____<...>.tfvars      # Contains variables for plans 
|____scripts                # Contains shell/python/powershell scripts
|    |____*.sh
|    |____*.py
|____files                  # Contains other files 
|    |____*.txt
|    |____*.cfg
|____LICENSE                # Contains licenses
|____README.md
```

### Create a simple AWS environment

```shell
# Define the build number for your build:
export BUILD_NUMBER=$(date)

# Define the AWS region for the infrastructure:
export AWS_REGION=us-east-1

# Define the Amazon S3 bucket for storing TF states. It must be in same region above:
export S3_BUCKET=devops-minhluantran017-com

# Define your environment description: demo, dev, staging, prod
export ENVIRON=demo

# If you want to enable NAT gateway deployment (default to 'false'):
export ENABLE_NAT=true

# If you want to deploy EKS cluster (default to 'false'):
export CREATE_EKS=true

cd aws
envsubst <templates/terraform.tfvars.tpl >terraform.tfvars

terraform init
terraform plan
terraform apply -auto-approve
```

### Create a simple vSphere environment

Go to `vsphere` folder:
```sh
cd vsphere
```

Replace value in `templates/terraform.tfvars.tpl` with proper values.

```sh
envsubst <templates/terraform.tfvars.tpl >terraform.tfvars
```

Then proceed with Terraform commands:
```sh
terraform init
terraform plan
terraform apply -auto-approve
```

### Create a simple KVM environment

Go to `kvm` folder:
```sh
cd kvm
```
Simple CentOS VM creation can be found here.
Just proceed with Terraform commands:
```sh
terraform init
terraform plan
terraform apply -auto-approve
```

For using module, please use example format as follow:
```hcl
module "ubuntu-vm" {
    source          = "git::https://github.com/minhluantran017/demo-terraform.git//kvm/module-vm?ref=v0.1.4"
    base_image_url  = "https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img"
    libvirt_pool    = "devops"
    create_pool     = true
    vm_name         = "ubuntu-vm"
    vm_count        = 1
    vm_vcpu         = 4
    vm_memory       = 8096
    vm_disk         = 100000000000
    ip_addresses    = [
        "10.250.200.191"
    ]
    gw_address      = "10.250.200.1"
    dns_address     = "10.250.200.2"
    ssh_public_key  = "ssh-rsa AAAA..."
}
```

### Create aa simple OpenStack environment

TODO

## 3. Code of Conduct

- Create branch for each component from `master` with convention: `dev_<provider>`.
For example: `dev_aws`.

- Please always create Pull Request to merge it to `master`. Only merge if all the tests pass.

## 4. Licenses

Terraform is under MPL2 licence. See [LICENSE](LICENSE)

## 5. TODO

* N/A