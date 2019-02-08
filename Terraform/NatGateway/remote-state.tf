data "terraform_remote_state" "network" {
  backend = "gcs"

  config {
    bucket = "${var.bucket}"
    prefix = "${var.env}/Terraform/Network"
  }
}
