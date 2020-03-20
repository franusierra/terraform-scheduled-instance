data "aws_iam_policy_document" "lambda_role_assume" {
  statement {


    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

  }
}
data "aws_iam_policy_document" "lambda_policies" {
  statement {
    sid = "1"

    actions = [
      "ec2:Start*",
      "ec2:Stop*"
    ]

    resources = [
      "${aws_instance.jenkins.arn}"
    ]

  }
}
resource "aws_iam_role" "schedule_lambda_role" {
  name               = "schedule_lambda_role"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_role_assume.json}"

}
resource "aws_iam_role_policy" "schedule_lambda_role_policy" {
  name   = "schedule_lambda_policy"
  role   = "${aws_iam_role.schedule_lambda_role.id}"
  policy = "${data.aws_iam_policy_document.lambda_policies.json}"
}
