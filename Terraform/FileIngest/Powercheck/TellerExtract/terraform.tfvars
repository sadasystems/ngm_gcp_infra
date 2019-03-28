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
job_name = "ngm-dataflow-powercheck-teller-extract"
max_workers = 1
on_delete = "cancel"
template_gcs_path = "gs://ngm-dataflow/templates/TextToBigQueryStreaming"
temp_gcs_location = "gs://ngm-dataflow/tmp"
job_parameters =
    {
      inputFilePattern = "gs://ngm-tier3-files/powercheck/teller_extract*",
      JSONPath = "gs://ngm-dataflow/teller_extract/files/teller_extract-schema.json",
      javascriptTextTransformGcsPath = "gs://ngm-dataflow/teller_extract/files/csv-to-bq.js",
      javascriptTextTransformFunctionName = "transform",
      bigQueryLoadingTemporaryDirectory = "gs://ngm-dataflow/tmp",
      outputDeadletterTable = "northgate-data-lake:powercheck.teller_extract_errors",
      outputTable = "northgate-data-lake:powercheck.teller_extract"
    }


#
# GCS Bucket Objects
#
bucket = "ngm-dataflow"

object_list = [
  {
    source = "files/teller_extract-schema.json",
    destination = "teller_extract/files/teller_extract-schema.json"
  },
  {
    source = "files/csv-to-bq.js",
    destination = "teller_extract/files/csv-to-bq.js"      
  }
]

# append these additional users object permissions.
role_entities = [
]