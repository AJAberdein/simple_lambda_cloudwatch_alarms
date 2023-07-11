resource "aws_sns_topic" "cloudwatch_lambda_alert_topic" {
  name = "cloudwatch_lambda_error_alert_topic"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  for_each  = toset(var.notify_emails)
  topic_arn = aws_sns_topic.cloudwatch_lambda_alert_topic.arn
  protocol  = "email"
  endpoint  = each.value
}

resource "aws_cloudwatch_metric_alarm" "lambda_error_alarm" {
  alarm_name          = "lamdba_error_alert"
  alarm_description   = "Alarm triggered when Lambda errors"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 300
  threshold           = 1
  statistic           = "Average"
  dimensions = {
    FunctionName = "${join(", ", var.function_names)}"
  }
  alarm_actions = [aws_sns_topic.cloudwatch_lambda_alert_topic.arn]
}

