
resource "aws_security_group" "jenkins-sg" {
  name        = "security-group-jenkins"
  description = "Allow traffic to jenkins server"
  ingress {
    description = "8080 from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["47.62.69.116/32", "81.0.35.27/32"]
  }
  ingress {
    description = "8080 from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["47.62.69.116/32", "81.0.35.27/32"]
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
  security_groups = ["${aws_security_group.jenkins-sg.name}"]
  key_name        = "aws-keypair"
  tags = {
    Name = "Jenkins"
  }
}

resource "aws_eip" "lb" {
  instance = "${aws_instance.jenkins.id}"
}
