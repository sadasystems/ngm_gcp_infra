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
job_name = "ngm-dataflow-tier3-files"
max_workers = 1
on_delete = "cancel"
template_gcs_path = "gs://gplerma-sada-test/templates/TextToBigQueryStreaming"
temp_gcs_location = "gs://gplerma-sada-test/tmp"
job_parameters =
    {
      inputFilePattern = "gs://gplerma-sada-test/ingest/bp_transactions*",
      JSONPath = "gs://gplerma-sada-test/csv-bq-files/bp_transactions-schema.json",
      javascriptTextTransformGcsPath = "gs://gplerma-sada-test/csv-bq-files/csv-to-bq.js",
      javascriptTextTransformFunctionName = "transform",
      bigQueryLoadingTemporaryDirectory = "gs://gplerma-sada-test/tmp",
      outputDeadletterTable = "gplerma-sada-test:transactions.bp_transactions_errors",
      outputTable = "gplerma-sada-test:transactions.bp_transactions"
    }

bucket = "gplerma-sada-test"