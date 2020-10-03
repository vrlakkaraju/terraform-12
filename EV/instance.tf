data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = lookup(var.instance_type, var.region)

  tags = {
    Name   = "web"
    Source = "Terraform"
    Owner  = "SRE"
  }


  provisioner "file" {

    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo ./tmp/script.sh"
    ]

  }

  connection {
    type        = "ssh"
    user        = var.user_name
    host        = coalesce(self.public_ip, self.private_ip)
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}
