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

variable zone {
  description = "The zone to use when creating the resource."
}

variable region {
  description = "Region for cloud resources."
}
