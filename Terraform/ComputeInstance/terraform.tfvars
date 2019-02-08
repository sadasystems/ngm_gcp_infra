# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------
terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  include {
    path = "${find_in_parent_folders()}"
  }

  dependencies {
    paths = ["../Network", "../CdhDisk"]
  }
}

#
# Module Parameter Values
#

// Number of Compute Instances to spin up.
amount = 1

// The GCP subnetwork to deploy compute instances into
subnetwork = "us-west1-black"

// Set the prefix name attached to each created compute instance.
instance_name_prefix = "workflow"

// Set the machine type desired
machine_type = "n1-standard-2"

// A list of network tags to attach to each created compute instance.
target_tags = ["workflow", "allow-internal-ssh"]

// The boot disk GCE disk type. May be set to pd-standard or pd-ssd.
boot_disk_type = "pd-ssd"

// The size of the image in gigabytes. 
boot_disk_size = "100"

// The image from which to initialize this disk
boot_disk_image = "ubuntu-1404-lts"

// Additional disk 1 GCE disk type. May be set to pd-standard or pd-ssd. 
disk1_disk_type = "pd-ssd"

// Additional disk 1 size of the image in gigabytes. 
disk1_size_gb = 75

// Additional disk 2 GCE disk type. May be set to pd-standard or pd-ssd. 
disk2_disk_type = "pd-ssd"

// Additional disk 2 size of the image in gigabytes.
disk2_size_gb = 500
