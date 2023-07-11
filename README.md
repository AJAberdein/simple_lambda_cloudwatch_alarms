# AWS Simple Cloudwatch Alarms for Lamdba functions Terraform module

Terraform module which triggers alarms for errors or timeouts in Lambda functions and alerts users via SNS topic.

## Usage

```hcl
module "simple_lambda_cloudwatch_alarm" {
  source         = "path/to/module"
  function_names = [aws_lambda_function.example_lambda.function_name]
  notify_emails  = ["ecample@test.com"]
}
```
