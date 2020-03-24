
resource "aws_security_group" "allow_8080" {
  name        = "allow_8080"
  description = "Allow 8080 inbound traffic"
  ingress {
    description = "8080 from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_8080"
  }
}
resource "aws_instance" "jenkins" {
  ami             = "${var.jenkins_ami_id}"
  instance_type   = "${var.jenkins_instance_type}"
  security_groups = ["${aws_security_group.allow_8080.name}"]
  tags = {
    Name = "Jenkins"
  }
}

resource "aws_eip" "lb" {
  instance = "${aws_instance.jenkins.id}"
}
