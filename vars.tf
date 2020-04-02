variable "START_SCHEDULE_EXPRESSION" {
  default = "cron(0 7 ? * MON-FRI *)"
}
variable "STOP_SCHEDULE_EXPRESSION" {
  default = "cron(0 15 ? * MON-FRI *)"
}
variable "STOP_TAG" {
  default = "STOP_ME"
}
variable "START_TAG" {
  default = "START_ME"
}
variable "SUBNET_IDS" {
  default = null
}
variable "SECURITY_GROUP_IDS" {
  default = null
}
variable "PREFIX" {
  default = "dev-"
}
