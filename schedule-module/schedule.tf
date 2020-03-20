resource "aws_cloudwatch_event_rule" "schedule-jenkins-start" {
  name                = "start-jenkins-schedule"
  schedule_expression = "${var.start_schedule_expression}"
}
resource "aws_cloudwatch_event_rule" "schedule-jenkins-shutdown" {
  name                = "shutdown-jenkins-schedule"
  schedule_expression = "${var.shutdown_schedule_expression}"
}
