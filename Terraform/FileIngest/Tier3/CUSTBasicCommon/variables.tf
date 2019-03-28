variable region {
  description = "Region for cloud resources."
  default     = "us-central1"
}

variable project_id {
  description = "The name of the project"
}

variable zone {
  description = "The regional zone"
}

variable "job_name" {
  description = "A unique name for the resource, required by Dataflow"
}

variable "template_gcs_path" {
  description = "The GCS path to the Dataflow job template."
}

variable "temp_gcs_location" {
  description = "A writeable location on GCS for the Dataflow job to dump its temporary data."
}


variable "job_parameters" {
  description = "(Optional) Map of key/value pairs to be passed to the Dataflow job (as used in the template)."
  type        = "map"
  default     = {}
}

variable "max_workers" {
  description = "(Optional) The number of workers permitted to work on the job. More workers may improve processing speed at additional cost."
  type        = "string"
  default     = 1
}

variable "on_delete" {
  description = "(Optional) One of [drain] or [cancel]. Specifies behavior of deletion during terraform destroy.  If cancelled, the job terminates - any data written remains where it is, but no new data will be processed. If drained, no new data will enter the pipeline, but any data currently in the pipeline will finish being processed.i The default is cancelled, but if a user sets on_delete to drain in the configuration, you may experience a long wait for your terraform destroy to complete."
  type        = "string"
  default     = "cancel"
}

variable "bucket" {
  description = "The name of the bucket to copy file objects to"
  type = "string"
}

variable "object_list" {
  description = ""
  type        = "list"
  default     = []
}

variable "role_entities" {
  default     = []
  description = "List of role/entity pairs to assign to the object in the form ROLE:entity. See [GCS Bucket ACL documentation](https://cloud.google.com/storage/docs/json_api/v1/bucketAccessControls) for more details."
  type        = "list"
}

