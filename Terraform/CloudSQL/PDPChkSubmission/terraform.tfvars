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
      connectionURL = "jdbc:mysql://35.235.78.167/mysql?cloudSqlInstance=gplerma-sada-test:us-west2:gplerma-mysql-0&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=6ihBH6GpPyhdcu47",
      username = "root",
      password = "6ihBH6GpPyhdcu47",
      query = <<EOF
SELECT cm.*, 
sm.store_name,
cust.first_name,
cust.last_name,
em.employee_name,
cjs.check_issuer_refno,
cjs.check_number,
cjs.check_date,
cjs.check_amount,
cjs.check_routing_number,
cjs.check_account_number,
cjs.iqa_status,
cjs.iqa_status_datetime,
cjs.item_status,
cjs.item_status_datetime,
cjs.processing_status,
cjs.processing_status_datetime,
cjs.transaction_status,
cjs.transaction_status_datetime,
cjs.settlement_status,
cjs.settlement_status_datetime,
cjs.batch_reference_number,
cjs.batch_reference_number,
cjs.transaction_reference_number 
FROM check_master AS cm 
INNER JOIN store_master AS sm ON cm.store_refno=sm.store_refno 
INNER JOIN customer_master AS cust ON cm.customer_refno=cust.customer_refno 
INNER JOIN employee_master em ON cm.teller_refno=em.northgate_employee_id 
LEFT JOIN check_jh_status AS cjs ON cm.check_master_id=cjs.check_master_id
EOF
,
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