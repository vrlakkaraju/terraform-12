locals {
  tags = {
    Owner       = "SRE"
    Source      = "Terraform"
    name_prefix = var.name != "" ? var.name : var.default
  }
}

resource "aws_instance" "dev" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.type["us-west-2"]
  tags          = local.tags

  #  tags = {
  #    Name = "myec2-${count.index}"
  #  }
}

data "aws_ami" "ubuntu" {
  most_recent = "true"

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}
