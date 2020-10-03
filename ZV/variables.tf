variable "name" {
  type    = string
  default = ""
}

variable "default" {
  default = "Temp"
}

variable "sg_ports"{
  type = list(number)
  description = "ports to be open"
  default = [22, 8300, 8301, 8302]
}

/*
variable "type"{
  type = list
  default = ["t2.micro", "t2.medium", "t2.large"]
}
*/

variable "type" {
  type = map
  default = {
    us-east-1 = "t2.large"
    us-west-2 = "t2.micro"
  }
}

variable "isdev" {
  type = string
}
