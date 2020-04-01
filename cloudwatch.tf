resource "aws_cloudwatch_event_rule" "schedule-instance-start" {
  name                = "${var.PREFIX}start-instance-schedule"
  schedule_expression = var.START_SCHEDULE_EXPRESSION
}

resource "aws_cloudwatch_event_target" "schedule-instance-start-target" {
  target_id = "${var.PREFIX}schedule-instance-start-target"
  rule      = aws_cloudwatch_event_rule.schedule-instance-start.name
  arn       = aws_lambda_function.scheduler_lambda.arn
}

resource "aws_cloudwatch_event_rule" "schedule-instance-stop" {
  name                = "${var.PREFIX}stop-instance-schedule"
  schedule_expression = var.STOP_SCHEDULE_EXPRESSION
}
resource "aws_cloudwatch_event_target" "schedule-instance-stop-target" {
  target_id = "${var.PREFIX}schedule-instance-stop-target"
  rule      = aws_cloudwatch_event_rule.schedule-instance-stop.name
  arn       = aws_lambda_function.scheduler_lambda.arn
}
