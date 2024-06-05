module "landing_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = "demo-landing-data-2024"
  eventbridge = true
}

module "results_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = "demo-results-data-2024"
}
