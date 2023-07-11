output "cloudwatch_alarm" {
  value = aws_cloudwatch_metric_alarm.lambda_error_alarm
}

output "sns_topic_subscription" {
  value = aws_sns_topic_subscription.email_subscription
}
