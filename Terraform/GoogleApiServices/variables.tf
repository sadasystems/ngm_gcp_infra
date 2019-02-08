
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

variable services_list {
  description = "A list of servies to activate."
  type        = "list"
}
