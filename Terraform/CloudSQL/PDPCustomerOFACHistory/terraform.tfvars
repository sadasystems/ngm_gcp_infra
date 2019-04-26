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
job_name = "ngm-dataflow-db-pdp-cust-ofac-hist"
max_workers = 2
on_delete = "cancel"
template_gcs_path = "gs://ngm-dataflow/templates/SqlToBigQueryBatch"
temp_gcs_location = "gs://ngm-dataflow/tmp"
job_parameters =
    {
      connectionString = "jdbc:mysql://google/pdp?cloudSqlInstance=river-daylight-218321:us-west1:northgatepdp-stage-esb-db-mysql&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false",
      username = "teamsada",
      password = "WAV!fx19",
      query = "SELECT cm.first_name,cm.last_name, cm.customer_status, cm.ofac_status, cm.last_ofac_scan_datetime, cm.whitelist_status, coh.ofac_status,coh.ofac_result FROM customer_master AS cm LEFT JOIN customer_ofac_history AS coh ON cm.customer_refno=coh.customer_refno",
      outputTable = "northgate-data-lake:db_pdp.cust_ofac_history",
      bigQueryLoadingTemporaryDirectory = "gs://ngm-dataflow/tmp",
    }
