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
job_name = "ngm-dataflow-db-pdp-chk-sbm"
max_workers = 2
on_delete = "cancel"
template_gcs_path = "gs://ngm-dataflow/templates/SqlToBigQueryBatch"
temp_gcs_location = "gs://ngm-dataflow/tmp"
job_parameters =
    {
      connectionString = "jdbc:mysql://google/pdp?cloudSqlInstance=river-daylight-218321:us-west1:northgatepdp-stage-esb-db-mysql&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false",
      username = "teamsada",
      password = "WAV!fx19",
      query = "SELECT cm.*,sm.store_name,cust.first_name,cust.last_name,em.employee_name,cjs.check_issuer_refno,cjs.check_number,cjs.check_date,cjs.check_amount,cjs.check_routing_number,cjs.check_account_number,cjs.iqa_status,cjs.iqa_status_datetime,cjs.item_status,cjs.item_status_datetime,cjs.processing_status,cjs.processing_status_datetime,cjs.transaction_status,cjs.transaction_status_datetime,cjs.settlement_status,cjs.settlement_status_datetime,cjs.batch_reference_number,cjs.batch_reference_number,cjs.transaction_reference_number FROM check_master AS cm INNER JOIN store_master AS sm ON cm.store_refno=sm.store_refno INNER JOIN customer_master AS cust ON cm.customer_refno=cust.customer_refno INNER JOIN employee_master em ON cm.teller_refno=em.northgate_employee_id LEFT JOIN check_jh_status AS cjs ON cm.check_master_id=cjs.check_master_id",
      outputTable = "northgate-data-lake:db_pdp.ck_submission",
      bigQueryLoadingTemporaryDirectory = "gs://ngm-dataflow/tmp",
    }
