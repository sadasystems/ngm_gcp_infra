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

variable "dataset_id" {
  description = "A unique ID for the resource. Changing this forces a new resource to be created."
  type        = "string"
}

variable "friendly_name" {
  description = "(Optional) A descriptive name for the dataset."
  type        = "string"
  default     = ""
}

variable "dataset_description" {
  description = "(Optional) A user-friendly description of the dataset."
  type        = "string"
  default     = ""
}

variable "delete_contents_on_destroy" {
  description = "(Optional) If set to true, delete all the tables in the dataset when destroying the resource; otherwise, destroying the resource will fail if tables are present."
  type        = "string"
  default     = false
}

variable "geo_location" {
  description = "(Optional) The geographic location where the dataset should reside. Possible regional values include: asia-east1, asia-northeast1, asia-southeast1 australia-southeast1, europe-north1, europe-west2 and us-east4. Possible multi-regional values:EU and US."
  type        = "string"
  default     = "US"
}


variable "default_table_expiration_ms" {
  description = "(Optional) The default lifetime of all tables in the dataset, in milliseconds. The minimum value is 3600000 milliseconds (one hour)."
  type        = "string"
  default     = ""
}

variable "dataset_labels" {
  description = "(Optional) A mapping of labels to assign to the dataset resource."
  type        = "map"
  default     = {}
}


variable "time_partitioning" {
  description = "(Optional) If specified, configures time-based partitioning for this table."
  type        = "list"
  default     = []
}

variable "view" {
  description = "(Optional) If specified, configures this table as a view."
  type        = "map"
  default     = {}
}

variable "table_labels" {
  description = "(Optional) A mapping of labels to assign to the dataset resource."
  type        = "map"
  default     = {}
}

variable "table_list" {
  description = "A list of maps with two keys \"table_name\" and \"json_schema_file\", specifying which tables to create and the schema files denoting the table structure."
  type        = "list"
  default = []
}
