module "firewall-internal-ssh" {
  source        = "git@github.com:sadasystems/gcp_tf_modules.git//firewall"
  name          = "allow-internal-ssh"
  network       = "${data.terraform_remote_state.network.name}"
  project_id    = "${var.project_id}"
  protocol      = "tcp"
  ports         = ["22"]
  source_ranges = ["172.16.0.0/15", "172.17.0.0/22"]
  target_tags   = ["allow-internal-ssh"]
}

module "firewall-internal-icmp" {
  source        = "git@github.com:sadasystems/gcp_tf_modules.git//firewall"
  name          = "allow-internal-icmp"
  network       = "${data.terraform_remote_state.network.name}"
  project_id    = "${var.project_id}"
  protocol      = "icmp"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-internal-icmp"]
}

module "firewall-external-ssh" {
  source        = "git@github.com:sadasystems/gcp_tf_modules.git//firewall"
  name          = "allow-external-ssh"
  network      = "${data.terraform_remote_state.network.name}"
  project_id    = "${var.project_id}"
  protocol      = "tcp"
  ports         = ["22"]
  source_ranges = ["104.3.119.210/32"]
  target_tags   = ["allow-external-ssh"]
}

module "firewall-openvpn" {
  source        = "git@github.com:sadasystems/gcp_tf_modules.git//firewall"
  name          = "allow-openvpn"
  network      = "${data.terraform_remote_state.network.name}"
  project_id    = "${var.project_id}"
  protocol      = "udp"
  ports         = ["1194"]
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-openvpn"]
}
