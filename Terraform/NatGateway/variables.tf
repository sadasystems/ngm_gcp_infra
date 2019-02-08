variable bucket {
  description = "The name of the backend tf state bucket"
  type        = "string"
}
variable env {
  description = "Used for referencing TF_VAR_env"
}

variable project_id {
  description = "The name of the project"
}

variable region {
  description = "Region for cloud resources."
  default     = "us-central1"
}

variable zone {
  description = "Zone for managed instance groups."
  default     = "us-central1-f"
}

variable network {
  description = "Name of the network to deploy instances to."
  default     = "default"
}
