variable "notify_emails" {
  type        = list(string)
  description = "List of emails to notify"
}

variable "function_names" {
  type        = list(string)
  description = "List of lambda functions by name which to monitor"
}
