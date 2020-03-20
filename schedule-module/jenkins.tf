resource "aws_instance" "jenkins" {
  ami           = "${var.jenkins_ami_id}"
  instance_type = "${var.jenkins_instance_type}"
  tags = {
    Name = "Jenkins"
  }
}
