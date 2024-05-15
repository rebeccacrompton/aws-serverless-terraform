# Create S3 bucket to store survey data

resource "aws_s3_bucket" "raw_survey_data_bucket" {
  bucket = "raw-survey-landing-data"
}

# S3 bucket configuration: ownership controls, ACL, and event notifications

resource "aws_s3_bucket_ownership_controls" "bucket_ownership_controls" {
  bucket = aws_s3_bucket.raw_survey_data_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.bucket_ownership_controls]

  bucket = aws_s3_bucket.raw_survey_data_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket      = aws_s3_bucket.raw_survey_data_bucket.id
  eventbridge = true
}