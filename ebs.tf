resource "aws_ebs_volume" "ext-vol1"{
  availability_zone = "us-east-1a"
  size = "20"
  type = "gp2"
}

resource "aws_volume_attachment" "ext-vol1-attach"{
  device_name = "var.DEVICE_NAME"
  volume_id = "aws_ebs_volume.ext-vol1.id"
  instance_id = "aws_instance.my-instance.id"
}
