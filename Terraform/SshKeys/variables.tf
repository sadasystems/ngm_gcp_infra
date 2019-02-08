variable "ssh_pub_keys" {
  description = "A group of ssh public keys to apply globally to all instances in a project, that don't have project-wide ssh keys disabled."
  type        = "string"
}

variable project_id {
  description = "The name of the project"
}
