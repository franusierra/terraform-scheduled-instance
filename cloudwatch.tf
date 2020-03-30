resource "aws_cloudwatch_event_rule" "schedule-instance-start" {
  name                = "start-instance-schedule"
  schedule_expression = var.start_schedule_expression
}

resource "aws_cloudwatch_event_target" "schedule-instance-start-target" {
  target_id = "schedule-instance-start-target"
  rule      = aws_cloudwatch_event_rule.schedule-instance-start.name
  arn       = aws_lambda_function.scheduler_lambda.arn
}

resource "aws_cloudwatch_event_rule" "schedule-instance-stop" {
  name                = "stop-instance-schedule"
  schedule_expression = var.stop_schedule_expression
}
resource "aws_cloudwatch_event_target" "schedule-instance-stop-target" {
  target_id = "schedule-instance-stop-target"
  rule      = aws_cloudwatch_event_rule.schedule-instance-stop.name
  arn       = aws_lambda_function.scheduler_lambda.arn
}
