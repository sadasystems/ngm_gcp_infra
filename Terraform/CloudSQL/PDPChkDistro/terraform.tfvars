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
    paths = ["../../Core/GoogleApiServices"]
  }
}

#
# Module Parameter Values
#

#
# Dataflow Job Parameters
#
job_name = "ngm-dataflow-db-pdp-chk-disb"
max_workers = 1
on_delete = "cancel"
template_gcs_path = "gs://ngm-dataflow/templates/SqlToBigQueryBatch"
temp_gcs_location = "gs://ngm-dataflow/tmp"
job_parameters =
    {
      connectionURL = "jdbc:mysql://35.203.166.204:3306/pdp",
      username = "teamsada",
      password = "WAVfx19",
      query = "select * from some table",
      JSONPath = "gs://ngm-dataflow/cust_address_extract/files/db_pdp_chk_disb.json",
      outputTable = "northgate-data-lake:db_pdp.ck_disbursement",
      bigQueryLoadingTemporaryDirectory = "gs://ngm-dataflow/tmp",
    }

#
# GCS Bucket Objects upload
#
bucket = "ngm-dataflow"

object_list = [
  {
    source = "files/db_pdp_chk_disb.json",
    destination = "db_pdp_chk_disb/files/db_pdp_chk_disb.json"
  },
]

# append these additional users object permissions.
role_entities = [
    "OWNER:user-george.lerma@sadasystems.com"
]