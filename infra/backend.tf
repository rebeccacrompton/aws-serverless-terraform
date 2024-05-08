terraform {
  # The s3 bucket  and dynamodb table were created outside of this terraform project
  backend "s3" {
    bucket  = "demo-terraform-state-eu-west-1"
    key     = "serverless-backend/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true

    dynamodb_table = "demo-terraform-state-lock"
  }
}
