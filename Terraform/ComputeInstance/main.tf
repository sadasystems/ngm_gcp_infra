data "google_compute_image" "disk1" {
  name    = "${var.project_id}-disk1-image"
  project = "${var.project_id}"
}

data "google_compute_image" "disk2" {
  name    = "${var.project_id}-disk2-image"
  project = "${var.project_id}"
}

module "instance-workflow" {
  source       = "git@github.com:sadasystems/gcp_tf_modules.git//compute_instance"
  amount       = "${var.amount}"
  project_id   = "${var.project_id}"
  network      = "${data.terraform_remote_state.network.name}"
  subnetwork   = "${var.subnetwork}"
  region       = "${var.region}"
  zone         = "${var.zone}"
  name_prefix  = "${var.instance_name_prefix}"
  machine_type = "${var.machine_type}"
  target_tags  = ["${var.target_tags}"]

  // Boot Disk
  disk_type  = "${var.boot_disk_type}"
  disk_size  = "${var.boot_disk_size}"
  disk_image = "${var.boot_disk_image}"

  // Secondary Disk
  disk1_source_img = "${data.google_compute_image.disk1.self_link}"
  disk1_size_gb    = "${var.disk1_size_gb}"
  disk1_disk_type  = "${var.disk1_disk_type}"

  // Tertiary Disk
  disk2_source_img = "${data.google_compute_image.disk2.self_link}"
  disk2_size_gb    = "${var.disk2_size_gb}"
  disk2_disk_type  = "${var.disk2_disk_type}"
}
