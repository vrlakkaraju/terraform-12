resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("${var.PATH_TO_PUBLIC_KEY}")

}

resource "aws_instance" "my-instance" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.mykey.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  subnet_id = "${aws_subnet.public-1.id}"
  associate_public_ip_address = "true"
  tags = {
    Name   = "TF_instance"
    Source = "Terraform"
  }

  user_data = "data.template_cloudinit_config.vol-pkg-config.rendered"
  provisioner "file" {
    source      = "remote-exec-nginx.sh"
    destination = "/tmp/remote-exec-nginx.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/remote-exec-nginx.sh",
      "sudo sed -i -e 's/\r$//' /tmp/remote-exec-nginx.sh",
      "sudo /tmp/remote-exec-nginx.sh",
    ]
  }

  connection {
    host        = "${coalesce(self.public_ip, self.private_ip)}"
    type        = "ssh"
    user        = "${var.INSTANCE_USERNAME}"
    private_key = file("${var.PATH_TO_PRIVATE_KEY}")
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.my-instance.private_ip} >> private_ip.txt"
  }
}


