module "s3_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = "demo-raw-survey-landing-data"
  eventbridge = true
}

module "survey_results_data_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = "demo-survey-results-data"
}
