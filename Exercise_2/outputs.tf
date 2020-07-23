output "function_name" {
    description = "The name of the Lambda function"
    value = "${aws_lambda_function.greet_lambda.function_name}"
}

output "function_invoke_arn" {
    description = "The Invoke ARN of the Lambda function"
    value = "${aws_lambda_function.greet_lambda.arn}"
}
