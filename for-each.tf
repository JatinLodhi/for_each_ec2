# Provider information.

provider "aws" {
  region  = "us-east-1"
  profile = "KS-profile"
}

variable "aws_instance" {
  type = map(object({
    ami = string
    instance_type = string
    tags = string
    #instance_tenancy = string
    availability_zone = string
    #subnet_ids = string

  }))
  default = {
    "aws_ec2-1" = {
      ami = "ami-026b57f3c383c2eec"
      availability_zone = "us-east-1a"
      #instance_tenancy = "value"
      instance_type = "t2.micro"
      #subnet_ids = ""
      tags = "instance-1"
    }
    "aws_ec2-2" = {
      ami = "ami-026b57f3c383c2eec"
      availability_zone = "us-east-1c"
      #instance_tenancy = "value"
      instance_type = "t2.micro"
      #subnet_ids = ""
      tags = "instance-2"
    }
  }
  
  
}


resource "aws_instance" "server" {
  for_each = var.aws_instance
  ami           = each.value ["ami"]
  instance_type = each.value["instance_type"]
  availability_zone = each.value["availability_zone"]

  tags = {
    Name = each.value["tags"]
  }
}
