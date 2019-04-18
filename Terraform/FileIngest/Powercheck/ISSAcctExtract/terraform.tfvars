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
    paths = ["../../../Core/GoogleApiServices"]
  }
}

#
# Module Parameter Values
#

#
# Dataflow
#
job_name = "ngm-dataflow-powercheck-iss-acct"

max_workers = 2

on_delete = "cancel"

template_gcs_path = "gs://ngm-dataflow/templates/TextToBigQueryStreaming"

temp_gcs_location = "gs://ngm-dataflow/tmp"

job_parameters = {
  inputFilePattern                  = "gs://ngm-powercheck-files/iss_acct_extract*"
  JSONPath                          = "gs://ngm-dataflow/iss_acct_extract/files/iss_acct_extract-schema.json"
  outputTable                       = "northgate-data-lake:powercheck.iss_acct_extract"
  bigQueryLoadingTemporaryDirectory = "gs://ngm-dataflow/tmp"
  outputDeadletterTable             = "northgate-data-lake:powercheck.iss_acct_extract_errors"
}
