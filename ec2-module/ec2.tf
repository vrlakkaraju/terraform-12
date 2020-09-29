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
  security_groups = ["${aws_security_group.sg1}"]

  #  tags = {
  #    Name = "myec2-${count.index}"
  #  }

  provisioner "local-exec" {
    command = "the server's IP address is {self.private_ip}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install nginx",
      "sudo service nginx start",
    ]
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("${aws_key_pair.ec2key}")
    host = "${self.private_ip}"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = "true"

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}
