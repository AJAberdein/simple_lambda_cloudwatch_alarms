terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.64.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "hello_world_lambda" {
  name               = "hello_world_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "./sample_function/index.js"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "hello_world_lambda" {
  filename         = "lambda_function_payload.zip"
  function_name    = "lambda_hello_world_function"
  role             = aws_iam_role.hello_world_lambda.arn
  handler          = "index.helloworld"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime          = "nodejs16.x"
}

module "simple_lambda_cloudwatch_alarm" {
  source         = "../."
  function_names = [aws_lambda_function.hello_world_lambda.function_name]
  notify_emails  = ["sample@example.com"]
}
