module "upload_files" {
  source      = "git@github.com:sadasystems/terraform_modules.git//gcp/gcs_bucket_object/v1"
  bucket_name = "${var.bucket}"
  object_list = "${var.object_list}"

  role_entities = "${var.role_entities}"
}

module "dataflow" {
  project_id        = "${var.project_id}"
  source            = "git@github.com:sadasystems/terraform_modules.git//gcp/dataflow/v1?ref=feature/NG-60-tf-module-bigquery"
  job_name          = "${var.job_name}"
  template_gcs_path = "${var.template_gcs_path}"
  temp_gcs_location = "${var.temp_gcs_location}"

  job_parameters = "${var.job_parameters}"

  max_workers = "${var.max_workers}"
  on_delete   = "${var.on_delete}"
}

