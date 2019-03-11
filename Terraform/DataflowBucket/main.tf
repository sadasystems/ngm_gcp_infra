module "bucket" {
  source           = "git@github.com:sadasystems/gcp_tf_modules.git//gcp/gcs_bucket/v1"
  project_id       = "${var.project_id}"
  name             = "${var.name}"
  region           = "${var.region}"
  storage_class = "${var.storage_class}"
  lifecycle_rules = "${var.lifecycle_rules}"
  role_entities = "${var.role_entities}"
}