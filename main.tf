terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "${var.AWS_REGION}"
}

resource "aws_instance" "app_server" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${var.KEY_NAME}"
                
  tags = {
    Name = "AWS-Terraform-Python-Ansible"
  }
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_KEY}")}"
    host = "${aws_instance.example.public_dns}"
  }
}