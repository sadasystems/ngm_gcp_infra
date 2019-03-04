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
    paths = ["../GoogleApiServices","BigQuery"]
  }
}

#
# Module Parameter Values
#

#
# Dataflow
#
job_name = "ngm-dataflow-bp"
max_workers = 1
on_delete = "cancel"
template_gcs_path = "gs://gplerma-sada-test/templates/TextToBigQueryStreaming"
temp_gcs_location = "gs://gplerma-sada-test/tmp"
job_parameters =
    {
      inputFilePattern = "gs://gplerma-sada-test/ingest/bp_transactions*",
      JSONPath = "gs://gplerma-sada-test/bp_transactions/files/bp_transactions-schema.json",
      javascriptTextTransformGcsPath = "gs://gplerma-sada-test/bp_transactions/files/csv-to-bq.js",
      javascriptTextTransformFunctionName = "transform",
      bigQueryLoadingTemporaryDirectory = "gs://gplerma-sada-test/tmp",
      outputDeadletterTable = "gplerma-sada-test:transactions.bp_transactions_errors",
      outputTable = "gplerma-sada-test:transactions.bp_transactions"
    }


#
# GCS Bucket
#
bucket = "gplerma-sada-test"

object_list = [
  {
    source = "files/bp_transactions-schema.json",
    destination = "bp_transactions/files/bp_transactions-schema.json"
  },
  {
    source = "files/csv-to-bq.js",
    destination = "bp_transactions/files/csv-to-bq.js"      
  }
]

# append these additional users object permissions.
role_entities = [
    "OWNER:user-george.lerma@sadasystems.com"
]


#
# BigQuery
#
dataset_id = "transactions"
friendly_name = ""
dataset_description = ""
delete_contents_on_destroy = true
dataset_labels = {
  data_type = "transactions"
}

time_partitioning = []
view = {}
