
       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
[ec2-user@ip-10-0-0-121 ~]$ wget https://releases.hashicorp.com/terraform/1.0.1/terraform_1.0.1_linux_amd64.zip
--2022-08-01 09:06:59--  https://releases.hashicorp.com/terraform/1.0.1/terraform_1.0.1_linux_amd64.zip
Resolving releases.hashicorp.com (releases.hashicorp.com)... 151.101.54.49
Connecting to releases.hashicorp.com (releases.hashicorp.com)|151.101.54.49|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 33044548 (32M) [application/zip]
Saving to: ‘terraform_1.0.1_linux_amd64.zip’

 0% [                                                                                                                     ] 0           --.-K/s              
100%[====================================================================================================================>] 33,044,548  77.4MB/s   in 0.4s   

2022-08-01 09:07:00 (77.4 MB/s) - ‘terraform_1.0.1_linux_amd64.zip’ saved [33044548/33044548]

[ec2-user@ip-10-0-0-121 ~]$ 
[ec2-user@ip-10-0-0-121 ~]$ sudo unzip terraform_1.0.1_linux_amd64.zip -d /usr/local/bin/
Archive:  terraform_1.0.1_linux_amd64.zip
  inflating: /usr/local/bin/terraform  
[ec2-user@ip-10-0-0-121 ~]$ rm terraform_1.0.1_linux_amd64.zip
[ec2-user@ip-10-0-0-121 ~]$ terraform version
Terraform v1.0.1
on linux_amd64

Your version of Terraform is out of date! The latest version
is 1.2.6. You can update by downloading from https://www.terraform.io/downloads.html
[ec2-user@ip-10-0-0-121 ~]$ mkdir infra && cd infra
[ec2-user@ip-10-0-0-121 infra]$ cat > main.tf <<EOF
> terraform {
>   required_providers {
>     aws = {
>       source  = "hashicorp/aws"
>       version = "3.48.0"
>     }
>   }  
> }
> provider "aws" {
>   region = "us-west-2" # Oregon
> }
> EOF
[ec2-user@ip-10-0-0-121 infra]$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching "3.48.0"...
- Installing hashicorp/aws v3.48.0...
- Installed hashicorp/aws v3.48.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
[ec2-user@ip-10-0-0-121 infra]$ ls -A
main.tf  .terraform  .terraform.lock.hcl
[ec2-user@ip-10-0-0-121 infra]$ cat >> main.tf <<EOF
> resource "aws_vpc" "web_vpc" {
>   cidr_block = "192.168.100.0/24"
>   enable_dns_hostnames = true
>   tags = {
>     Name = "Web VPC"
>   }
> }
> EOF
[ec2-user@ip-10-0-0-121 infra]$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_vpc.web_vpc will be created
  + resource "aws_vpc" "web_vpc" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "192.168.100.0/24"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = true
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags                             = {
          + "Name" = "Web VPC"
        }
      + tags_all                         = {
          + "Name" = "Web VPC"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: 1

Apply cancelled.
[ec2-user@ip-10-0-0-121 infra]$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_vpc.web_vpc will be created
  + resource "aws_vpc" "web_vpc" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "192.168.100.0/24"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = true
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags                             = {
          + "Name" = "Web VPC"
        }
      + tags_all                         = {
          + "Name" = "Web VPC"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: 0

Apply cancelled.
[ec2-user@ip-10-0-0-121 infra]$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_vpc.web_vpc will be created
  + resource "aws_vpc" "web_vpc" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "192.168.100.0/24"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = true
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags                             = {
          + "Name" = "Web VPC"
        }
      + tags_all                         = {
          + "Name" = "Web VPC"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: 1

Apply cancelled.
[ec2-user@ip-10-0-0-121 infra]$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_vpc.web_vpc will be created
  + resource "aws_vpc" "web_vpc" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "192.168.100.0/24"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = true
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags                             = {
          + "Name" = "Web VPC"
        }
      + tags_all                         = {
          + "Name" = "Web VPC"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: 2

Apply cancelled.
[ec2-user@ip-10-0-0-121 infra]$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_vpc.web_vpc will be created
  + resource "aws_vpc" "web_vpc" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "192.168.100.0/24"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = true
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags                             = {
          + "Name" = "Web VPC"
        }
      + tags_all                         = {
          + "Name" = "Web VPC"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes 

aws_vpc.web_vpc: Creating...
aws_vpc.web_vpc: Still creating... [10s elapsed]
aws_vpc.web_vpc: Creation complete after 11s [id=vpc-09094391136b2616f]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
[ec2-user@ip-10-0-0-121 infra]$ aws ec2 describe-vpcs --region us-west-2 --filter "Name=tag:Name,Values=Web VPC"
{
    "Vpcs": [
        {
            "VpcId": "vpc-09094391136b2616f", 
            "InstanceTenancy": "default", 
            "Tags": [
                {
                    "Value": "Web VPC", 
                    "Key": "Name"
                }
            ], {
    "Vpcs": [
        {
            "VpcId": "vpc-09094391136b2616f", 
            "InstanceTenancy": "default", 
            "Tags": [
                {
                    "Value": "Web VPC", 
                    "Key": "Name"
                }
            ], 
            "CidrBlockAssociationSet": [
                {
                    "AssociationId": "vpc-cidr-assoc-067f8a10a4effd5b1", 
                    "CidrBlock": "192.168.100.0/24", 
                    "CidrBlockState": {
                        "State": "associated"
                    }
                }
            ], 
            "State": "available", 
            "DhcpOptionsId": "dopt-038a6aa0bcaa27626", 
            "OwnerId": "836633942344", 
            "CidrBlock": "192.168.100.0/24", 
            "IsDefault": false
        }
    ]
}
[ec2-user@ip-10-0-0-121 infra]$ aws ec2 describe-vpc-attribute --region us-west-2 --attribute enableDnsHostnames --vpc-id "VpcId": "vpc-09094391136b2616f"
Note: AWS CLI version 2, the latest major version of the AWS CLI, is now stable and recommended for general use. For more information, see the AWS CLI version 2 installation instructions at: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html

usage: aws [options] <command> <subcommand> [<subcommand> ...] [parameters]
To see help text, you can run:

  aws help
  aws <command> help
  aws <command> <subcommand> help

Unknown options: vpc-09094391136b2616f
[ec2-user@ip-10-0-0-121 infra]$ aws ec2 describe-vpc-attribute --region us-west-2 --attribute enableDnsHostnames --vpc-id "vpc-09094391136b2616f"
{
    "VpcId": "vpc-09094391136b2616f", 
    "EnableDnsHostnames": {
        "Value": true
    }
            "CidrBlockAssociationSet": [
                {
                    "AssociationId": "vpc-cidr-assoc-067f8a10a4effd5b1", 
                    "CidrBlock": "192.168.100.0/24", 
                    "CidrBlockState": {
                        "State": "associated"
                    }
                }
            ], 
            "State": "available", 
            "DhcpOptionsId": "dopt-038a6aa0bcaa27626", 
            "OwnerId": "836633942344", 
            "CidrBlock": "192.168.100.0/24", 
            "IsDefault": false
        }
    ]
}
[ec2-user@ip-10-0-0-121 infra]$ aws ec2 describe-vpc-attribute --region us-west-2 --attribute enableDnsHostnames --vpc-id "VpcId": "vpc-09094391136b2616f"
Note: AWS CLI version 2, the latest major version of the AWS CLI, is now stable and recommended for general use. For more information, see the AWS CLI version 2 installation instructions at: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html

usage: aws [options] <command> <subcommand> [<subcommand> ...] [parameters]
To see help text, you can run:

  aws help
  aws <command> help
  aws <command> <subcommand> help

Unknown options: vpc-09094391136b2616f
[ec2-user@ip-10-0-0-121 infra]$ aws ec2 describe-vpc-attribute --region us-west-2 --attribute enableDnsHostnames --vpc-id "vpc-09094391136b2616f"
{
    "VpcId": "vpc-09094391136b2616f", 
    "EnableDnsHostnames": {
        "Value": true
    }
}
