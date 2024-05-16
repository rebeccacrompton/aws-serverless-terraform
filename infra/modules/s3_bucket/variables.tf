variable "bucket_name" {
  description = "The name for the S3 bucket."
}

variable "eventbridge" {
  description = "Flag to enable EventBridge for the S3 bucket."
  type        = bool
  default     = false
}
