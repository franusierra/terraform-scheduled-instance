
data "archive_file" "aws-scheduler" {
  type        = "zip"
  source_file = "${path.module}/functions/schedule-lambda.py"
  output_path = "${path.module}/aws-scheduler.zip"
}
resource "aws_cloudwatch_log_group" "scheduler-log-group" {
  name = "/aws/lambda/${aws_lambda_function.scheduler_lambda.function_name}"
}
resource "aws_lambda_function" "scheduler_lambda" {
  filename      = data.archive_file.aws-scheduler.output_path
  function_name = "schedule-ec2-instance"

  role             = aws_iam_role.schedule_lambda_role.arn
  handler          = "schedule-lambda.handler"
  runtime          = "python3.7"
  timeout          = 300
  source_code_hash = data.archive_file.aws-scheduler.output_base64sha256
  environment {
    variables = {
      START_TAG       = var.START_TAG
      STOP_TAG        = var.STOP_TAG
      START_EVENT_ARN = aws_cloudwatch_event_rule.schedule-instance-start.arn
      STOP_EVENT_ARN  = aws_cloudwatch_event_rule.schedule-instance-stop.arn
    }
  }
  vpc_config {
    subnet_ids         = var.SUBNET_IDS
    security_group_ids = var.SECURITY_GROUP_IDS
  }
}
