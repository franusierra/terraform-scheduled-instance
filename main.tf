provider "aws" {
  region  = "eu-west-1"
  profile = "terraform"
}
module "ScheduledJenkins" {
  source                    = "./schedule-module"
  jenkins_ami_id            = "${var.jenkins_ami_id}"
  jenkins_instance_type     = "${var.jenkins_instance_type}"
  start_schedule_expression = "${var.start_schedule_expression}"
  stop_schedule_expression  = "${var.stop_schedule_expression}"
}

resource "aws_ecr_repository" "JenkinsRepoTest" {
  name = "test-jenkins"
}
