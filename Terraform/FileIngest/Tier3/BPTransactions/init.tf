terraform {
  backend "gcs" {}
}

provider "google" {
  region  = "${var.region}"
  project = "${var.project_id}"
  zone = "${var.zone}"
}
