data "google_compute_zones" "available" {
  project = "${var.project_id}"
}

data "google_compute_image" "vpn" {
  family  = "mgmt-openvpn-centos-7"
  project = "${var.project_id}"
}

data "google_compute_subnetwork" "red" {
  name    = "us-west1-red"
  project = "${var.project_id}"
  region  = "${var.region}"
}

resource "google_service_account" "vpn" {
  account_id   = "vpnservice"
  display_name = "VPN Compute Service Account"
  project      = "${var.project_id}"
}

resource "google_compute_address" "vpn-static" {
  name    = "openvpn-0-ext-address"
  project = "${var.project_id}"
  region  = "${var.region}"
}

resource "google_project_iam_member" "compute" {
  project = "${var.project_id}"
  role    = "roles/compute.admin"
  member  = "serviceAccount:${google_service_account.vpn.email}"
}

resource "google_project_iam_member" "serviceaccount" {
  project = "${var.project_id}"
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.vpn.email}"
}

resource "google_compute_instance" "vpn_server" {
  project                   = "${var.project_id}"
  zone                      = "${var.region}-a"
  name                      = "ag-openvpn-0"
  machine_type              = "n1-standard-1"
  deletion_protection       = false
  can_ip_forward            = true
  allow_stopping_for_update = true

  metadata_startup_script = <<SCRIPT
 sudo bash /usr/local/bin/openvpn-install.sh ${var.zone} ${data.google_compute_subnetwork.red.ip_cidr_range} ${var.env} ${var.project_id}
SCRIPT

  tags = ["allow-external-ssh", "allow-internal-ssh", "allow-openvpn"]

  labels = {
    component   = "vpn"
    environment = "${var.env}"
  }

  boot_disk {
    initialize_params {
      image = "${data.google_compute_image.vpn.name}"
      size  = "100"
    }
  }

  network_interface {
    subnetwork = "${data.google_compute_subnetwork.red.self_link}"

    access_config = {
      network_tier = "PREMIUM"
      nat_ip       = "${google_compute_address.vpn-static.address}"
    }
  }

  service_account {
    email  = "${google_service_account.vpn.email}"
    scopes = ["userinfo-email", "compute-rw"]
  }

  lifecycle {
    ignore_changes = ["metadata_startup_script"]
  }
}

output "instance_id" {
  value = "${google_compute_instance.vpn_server.self_link}"
}

output "instance_ip" {
  value = "${google_compute_instance.vpn_server.network_interface.0.address}"
}

output "instance_public_ip" {
  value = "${google_compute_instance.vpn_server.network_interface.0.access_config.0.assigned_nat_ip}"
}
