resource "aws_security_group" "publicSG" {
  name        = "public_sg"
  description = "public SG"

  dynamic "ingress" {
    for_each = var.sg_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["54.245.14.80/32"]
    }

  }

}
