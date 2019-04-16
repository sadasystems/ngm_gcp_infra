
module "dataflow" {
  project_id        = "${var.project_id}"
  source            = "git@github.com:sadasystems/terraform_modules.git//gcp/dataflow/v1"
  job_name          = "${var.job_name}"
  template_gcs_path = "${var.template_gcs_path}"
  temp_gcs_location = "${var.temp_gcs_location}"

  job_parameters = "${var.job_parameters}"

  max_workers = "${var.max_workers}"
  on_delete   = "${var.on_delete}"
}

