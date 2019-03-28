module "bucket" {
  source           = "git@github.com:sadasystems/gcp_tf_modules.git//gcp/gcs_bucket/v1?ref=master"
  project_id       = "${var.project_id}"
  name             = "${var.name}"
  region           = "${var.region}"
  storage_class = "${var.storage_class}"
  lifecycle_rules = "${var.lifecycle_rules}"
  role_entities = "${var.role_entities}"
  force_destroy = "${var.force_destroy}"
}

module "create-dirs" {
  source      = "git@github.com:sadasystems/terraform_modules.git//gcp/gcs_bucket_object/v1"
  bucket_name = "${var.bucket}"
  object_list = "${var.object_list}"
  role_entities = "${var.object_role_entities}"
}