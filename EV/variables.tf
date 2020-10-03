variable "PATH_TO_PUBLIC_KEY" {
  type        = string
  description = "path to ssh public key i.e., mykey.pub"
  default     = "mykey.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
  type        = string
  description = "path to private key i.e., mykey"
  default     = "mykey"
}

variable "user_name" {
  type        = string
  description = "user name for ssh"
  default     = "ubuntu"
}

variable "sg_ports" {
  type        = list(number)
  description = "ports for SG inbound rules"
  default     = [22, 443, 80]
}

variable "instance_type" {
  type        = map
  description = "instance type based on region"
  default = {
    us-east-1 = "t2.medium"
    us-west-2 = "t2.micro"
  }
}

variable "region" {
  type        = string
  description = "aws region"
  default     = "us-east-1"
}
