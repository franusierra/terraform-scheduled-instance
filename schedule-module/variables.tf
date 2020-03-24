variable "jenkins_instance_type" {
  default = "t3.small"
}
variable "jenkins_ami_id" {
  default = "ami-054ea15034919700c"
}
variable "start_schedule_expression" {
  default = "cron(0 8 ? * MON-FRI *)"
}
variable "stop_schedule_expression" {
  default = "cron(0 16 ? * MON-FRI *)"
}
