module "cloud-router" {
  source            = "git@github.com:sadasystems/gcp_tf_modules.git//cloud_router"
  cloud_router_name = "internet-nat-gateway"
  network           = "${data.terraform_remote_state.network.name}"
  project_id        = "${var.project_id}"
  region            = "${var.region}"
  asn               = "64512"
}

/*

@TODO:
You may be wondering why there is no nat gateway resource creation?

It's due to the time of this writing, Terraform google provider does not yet support creation
of Nat Gateway resources.
https://github.com/terraform-providers/terraform-provider-google/issues/2249

For now, creation of Nat Gateway is MANUAL-only.
*/

