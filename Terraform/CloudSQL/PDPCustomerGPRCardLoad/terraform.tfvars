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
job_name = "ngm-dataflow-db-pdp-cust-gpr-card-load"
max_workers = 2
on_delete = "cancel"
template_gcs_path = "gs://ngm-dataflow/templates/SqlToBigQueryBatch"
temp_gcs_location = "gs://ngm-dataflow/tmp"
job_parameters =
    {
      connectionString = "jdbc:mysql://google/pdp?cloudSqlInstance=river-daylight-218321:us-west1:northgatepdp-stage-esb-db-mysql&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false",
      username = "teamsada",
      password = "WAV!fx19",
      query = "SELECT cm.customer_refno, cm.first_name, cm.last_name, gc.gpr_card_number, gc.expiry_date, gl.gpr_amount FROM customer_master AS cm LEFT JOIN gpr_card AS gc ON cm.customer_refno=gc.customer_refno LEFT JOIN gpr_load AS gl ON gc.gpr_card_id=gl.gpr_card_id",
      outputTable = "northgate-data-lake:db_pdp.cust_gpr_card_load",
      bigQueryLoadingTemporaryDirectory = "gs://ngm-dataflow/tmp",
    }
