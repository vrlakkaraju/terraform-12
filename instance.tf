resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("${var.PATH_TO_PUBLIC_KEY}")

}

resource "aws_instance" "my_instance" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.mykey.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  subnet_id = "${aws_subnet.public-1.id}"
  tags = {
    Name   = "TF_instance"
    Source = "Terraform"
  }

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo sed -i -e 's/\r$//' /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }

  connection {
    host        = "${coalesce(self.public_ip, self.private_ip)}"
    type        = "ssh"
    user        = "${var.INSTANCE_USERNAME}"
    private_key = file("${var.PATH_TO_PRIVATE_KEY}")
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.my_instance.private_ip} >> private_ip.txt"
  }
}

#output "public-ip" {
#  value = "${aws_instance.my_instance.public_ip}"
#}

#output "keyname"{
#  value = "aws_key_pair.mykey.key_name"
#}

