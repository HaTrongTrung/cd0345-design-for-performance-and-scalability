provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

resource "aws_iam_role" "iam_role_lambda" {
  name = "iam_role_lambda"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_log_policy" {
  name        = "lambda_log_policy"
  path        = "/"
  description = "AWS IAM Policy for lambda log"
  policy      = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "arn:aws:logs:*:*:*",
        "Effect" : "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy_to_iam_role" {
  role       = aws_iam_role.iam_role_lambda.name
  policy_arn = aws_iam_policy.lambda_log_policy.arn
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/first_trunght_lambda"
  retention_in_days = 7
}

data "archive_file" "lambda_code_zip" {
  type        = "zip"
  source_file = "greet_lambda.py"
  output_path = "output.zip"
}

resource "aws_lambda_function" "first_trunght_lambda" {
  function_name = "first_trunght_lambda"
  filename      = "output.zip"
  role          = aws_iam_role.iam_role_lambda.arn
  handler       = "greet_lambda.lambda_handler"
  runtime       = "python3.8"
  depends_on    = [
    aws_iam_role_policy_attachment.attach_policy_to_iam_role
  ]

  environment {
    variables = {
      greeting = "First Lambda"
    }
  }
}