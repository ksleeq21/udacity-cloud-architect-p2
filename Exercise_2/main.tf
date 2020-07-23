provider "aws" {
  access_key = "SOME-ACCESS-KEY"
  secret_key = "SOME-SECRET-KEY"
  region = "us-west-2"
}


resource "aws_iam_role" "role" {
  name = "lambda_role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [{
        "Action": "sts:AssumeRole",
        "Principal": {
            "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow"
    }]
}
EOF
}


resource "aws_iam_policy" "policy" {
    name = "lambda-policy"
    description = "Policy for lambda"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:*:*:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:*:*:*"
            ]
        }
    ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "policy-attach" {
  role = "${aws_iam_role.role.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}


data "archive_file" "lambda_zip" {
    type = "zip"
    source_file = "${path.module}/greet_lambda.py"
    output_path = "${path.module}/upload.zip"
}


resource "aws_lambda_function" "greet_lambda" {
    runtime = "python3.8"
    filename = "upload.zip"
    source_code_hash = data.archive_file.lambda_zip.output_base64sha256
    function_name = var.lambda_function_name
    handler = "${var.lambda_function_name}.lambda_handler"
    role = "${aws_iam_role.role.arn}"

    environment {
        variables = {
            greeting = "Good morning"
        }
    }
}