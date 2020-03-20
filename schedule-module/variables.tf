variable "jenkins_instance_type" {
  default = "t3.small"
}
variable "jenkins_ami_id" {
  default = "ami-0d847e65d96c3eebd"
}
variable "start_schedule_expression" {
  default = "cron(0 8 * * ? *)"
}
variable "shutdown_schedule_expression" {
  default = "cron(0 16 * * ? *)"
}
