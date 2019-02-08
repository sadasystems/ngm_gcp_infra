variable bucket {
  description = "The name of the backend tf state bucket"
  type        = "string"
}
variable env {
  description = "Used for referencing TF_VAR_env"
}

variable region {
  description = "Region for cloud resources."
  default     = "us-central1"
}

variable project_id {
  description = "The name of the project"
}

variable internal_source_ranges {
  description = "A list of source internal RFC-1918 CIDR ranges that this firewall applies to. Can't be used for EGRESS"
  type        = "list"
}

variable external_source_ranges {
  description = "A list of source internet-routable CIDR ranges that this firewall applies to. Can't be used for EGRESS"
  type        = "list"
}
