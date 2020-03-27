
resource "aws_security_group" "jenkins-sg" {
  name        = "security-group-jenkins"
  description = "Allow traffic to jenkins server"
  ingress {
    description = "80"
    from_port   = 80
    to_port     = 80
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
  ami                  = var.jenkins_ami_id
  instance_type        = var.jenkins_instance_type
  security_groups      = [aws_security_group.jenkins-sg.name]
  iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name
  key_name             = "aws-keypair"
  tags = {
    Name = "Jenkins"
  }
}

resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins_profile"
  role = var.asume_role_jenkins
}

resource "aws_eip" "lb" {
  instance = aws_instance.jenkins.id
}
