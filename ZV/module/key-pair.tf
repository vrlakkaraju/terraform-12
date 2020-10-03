resource "aws_key_pair" "ec2key"{
  key_name = "ec2-key-pair"
  public_key = "{file("/home/cloud_user/.ssh/id_rsa.pub")}"
}
