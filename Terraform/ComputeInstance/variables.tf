variable bucket {
  description = "The name of the backend tf state bucket"
  type        = "string"
}

variable env {
  description = "Used for referencing TF_VAR_env"
  type        = "string"
}

variable project_id {
  description = "The name of the project"
  type        = "string"
}

variable region {
  description = "Region for cloud resources."
  type        = "string"
}

variable zone {
  description = "Zone for managed instance groups."
  type        = "string"
}

variable network {
  description = "Name of the network to deploy instances to."
  type        = "string"
  default     = "default"
}

variable subnetwork {
  description = "The GCP subnetwork to deploy compute instances into"
  type        = "string"
  default     = "default"
}

variable "amount" {
  description = "Number of Compute Instances to spin up."
  type        = "string"
}

variable "instance_name_prefix" {
  description = "Set the prefix name attached to each created compute instance."
  type        = "string"
}

variable "machine_type" {
  description = "Set the machine type desired: https://cloud.google.com/compute/pricing "
  type        = "string"
}

variable "target_tags" {
  description = "A list of network tags to attach to each created compute instance."
  type        = "list"
}

variable "boot_disk_type" {
  description = "The GCE disk type. May be set to pd-standard or pd-ssd."
  type        = "string"
  default     = "pd-standard"
}

variable "boot_disk_size" {
  description = "Primary disk size in GB"
  type        = "string"
  default     = "20"
}

variable "boot_disk_image" {
  description = "[Available OS images/templates](https://cloud.google.com/compute/docs/images)"
  type        = "string"
}

variable disk1_disk_type {
  description = "The disk1 tmp disk type. Can be either pd-ssd, local-ssd, or pd-standard."
  type        = "string"
  default     = "pd-ssd"
}

variable disk1_size_gb {
  description = "The size of the tmp disk in gigabytes."
  type        = "string"
}

variable disk2_disk_type {
  description = "The disk2  disk type. Can be either pd-ssd, local-ssd, or pd-standard."
  type        = "string"
}

variable disk2_size_gb {
  description = "The size of the disk in gigabytes."
  type        = "string"
}
