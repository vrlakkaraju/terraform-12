data "aws_ip_ranges" "from_us-east" {
  regions  = ["us-east1", "us-east-2"]
  services = ["ec2"]
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "allow 443 from all us-east AWS IPs"
  vpc_id = "${aws_vpc.vpc1.id}"

  ingress {
    description = "access to 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${data.aws_ip_ranges.from_us-east.cidr_blocks}"
  }
  ingress {
    description = "allow ssh access for this instance to run boot script"
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["18.222.121.197/32"]
  }
  tags = {
    CreateDate = "${data.aws_ip_ranges.from_us-east.create_date}"
    SyncToken  = "${data.aws_ip_ranges.from_us-east.sync_token}"
  }
}
