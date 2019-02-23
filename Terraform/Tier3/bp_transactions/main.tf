resource "google_storage_bucket_object" "json" {
  name   = "bp_transactions/files/bp_transactions-schema.json"
  source = "files/bp_transactions-schema.json"
  bucket = "${var.bucket}"
}

resource "google_storage_bucket_object" "csv" {
  name   = "bp_transactions/files/csv-to-bq.js"
  source = "files/csv-to-bq.js"
  bucket = "${var.bucket}"
}

module "dataflow" {
  source            = "git@github.com:sadasystems/terraform_modules.git//gcp/dataflow/v1"
  job_name          = "${var.job_name}"
  template_gcs_path = "${var.template_gcs_path}"
  temp_gcs_location = "${var.temp_gcs_location}"

  job_parameters = "${var.job_parameters}"

  max_workers = "${var.max_workers}"
  on_delete   = "${var.on_delete}"
}
