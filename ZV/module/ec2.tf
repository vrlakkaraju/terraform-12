locals {
  tags = {
    Owner       = "SRE"
    Source      = "Terraform"
    name_prefix = var.name != "" ? var.name : var.default
  }
}

resource "aws_instance" "dev" {
  depends_on = ["aws_key_pair.ec2key"]
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.type["us-west-2"]
  tags          = local.tags
  vpc_security_group_ids = ["${aws_security_group.sg1.id}"]

  #  tags = {
  #    Name = "myec2-${count.index}"
  #  }

  provisioner "local-exec" {
    command = "echo {aws_instance.dev.private_ip} >> ec2_private_ip.txt"
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
    private_key = "${file("../.ssh/id_rsa")}"
    host = "${self.public_ip}"
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
