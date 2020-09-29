resource "aws_key_pair" "ec2key"{
  key_name = "ec2-key-pair"
  public_key = file("~/.ssh/id_rsa.pub")
}
