
module "big-query-dataset" {
  source                     = "git@github.com:sadasystems/terraform_modules.git//gcp/bigquery/v1"
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
