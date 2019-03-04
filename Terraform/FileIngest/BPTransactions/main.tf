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

module "big-query-table" {
  source                     = "git@github.com:sadasystems/terraform_modules.git//gcp/bigquery/v1?ref=feature/NG-60-tf-module-bigquery"
  dataset_id                 = "${var.dataset_id}"
  friendly_name              = "${var.friendly_name}"
  dataset_description        = "${var.dataset_description}"
  delete_contents_on_destroy = "${var.delete_contents_on_destroy}"
  geo_location               = "${var.geo_location}"
  dataset_labels             = "${var.dataset_labels}"
  time_partitioning          = "${var.time_partitioning}"
  view                       = "${var.view}"
  table_labels               = "${var.table_labels}"
  table_list                 = "${var.table_list}"
}
