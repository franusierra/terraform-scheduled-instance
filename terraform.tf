provider "aws" {
  region  = "eu-west-1"
  profile = "terraform"
}
module "ScheduledJenkins" {
  source  = "./schedule-module"
  version = "0.0.1"

  jenkins_ami_id        = "${var.jenkins_ami_id}"
  jenkins_instance_type = "${var.jenkins_instance_type}"
}
