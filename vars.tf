variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-1"
}
variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-0a0ddd875a1ea2c7f"
    us-east-2 = "ami-04781752c9b20ea41"
    us-west-2 = "ami-0a4df59262c92cf19"
  }
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
variable "DEVICE_NAME"{
  default = "/dev/xvdh"
}



