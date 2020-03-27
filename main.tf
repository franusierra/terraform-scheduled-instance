provider "aws" {
  region  = "eu-west-1"
  profile = "terraform"
}
module "ScheduledJenkins" {
  source                    = "./schedule-module"
  jenkins_ami_id            = var.jenkins_ami_id
  jenkins_instance_type     = var.jenkins_instance_type
  start_schedule_expression = var.start_schedule_expression
  stop_schedule_expression  = var.stop_schedule_expression
  asume_role_jenkins        = aws_iam_role.jenkins_ecr_role.name
}

resource "aws_ecr_repository" "jenkins_repo_test" {
  name = "jenkins-test"
}
data "aws_iam_policy_document" "push_ecr_policy" {
  statement {
    sid = ""

    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = [
      "*"
    ]
  }

}

resource "aws_iam_role" "jenkins_ecr_role" {
  name = "jenkins_ecr_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_role_policy" "schedule_lambda_role_policy" {
  name   = "jenkins_ecr_role"
  role   = aws_iam_role.jenkins_ecr_role.id
  policy = data.aws_iam_policy_document.push_ecr_policy.json
}
