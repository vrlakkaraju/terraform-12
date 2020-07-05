output "public-ip" {
  value = "${aws_instance.my_instance.public_ip}"
}

output "keyname"{
  value = "aws_key_pair.mykey.key_name"
}

output "sgname"{
  value = "aws_security_group.allow_tls.name"
}

output "vpc-name"{
  value = "aws_vpc.vpc1.name"
}

output "public-subnet-name"{
  value = "aws_subnet.public-1.name"
}
