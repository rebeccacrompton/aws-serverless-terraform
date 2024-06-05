module "s3_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = "demo-landing-data"
  eventbridge = true
}

module "s3_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = "demo-results-data"
}
