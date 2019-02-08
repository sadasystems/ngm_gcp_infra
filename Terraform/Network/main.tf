module "network" {
  source           = "git@github.com:sadasystems/gcp_tf_modules.git//network"
  project_id       = "${var.project_id}"
  network_name     = "${var.network_name}"
  subnets          = ["${var.subnets}"]
  secondary_ranges = "${var.secondary_ranges}"
  region           = "${var.region}"
}
