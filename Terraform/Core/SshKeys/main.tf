terraform {
  backend "gcs" {}
}

resource "google_compute_project_metadata" "ssh_keys" {
  project = "${var.project_id}"

  metadata {
    ssh-keys = "${var.ssh_pub_keys}"
  }
}
