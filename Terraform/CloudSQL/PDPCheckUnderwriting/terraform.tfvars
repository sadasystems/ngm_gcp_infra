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
job_name = "ngm-dataflow-db-pdp-ck-underwriting"
max_workers = 2
on_delete = "cancel"
template_gcs_path = "gs://ngm-dataflow/templates/SqlToBigQueryBatch"
temp_gcs_location = "gs://ngm-dataflow/tmp"
job_parameters =
    {
      connectionString = "jdbc:mysql://google/pdp?cloudSqlInstance=river-daylight-218321:us-west1:northgatepdp-stage-esb-db-mysql&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false",
      username = "teamsada",
      password = "WAV!fx19",
      query = "SELECT chm.*,ut.status,ut.details,uw.* FROM check_master AS chm LEFT JOIN underwriting_tracking AS ut ON chm.check_master_id=ut.check_master_id INNER JOIN underwriting AS uw ON ut.rule_id=uw.rule_id",
      outputTable = "northgate-data-lake:db_pdp.ck_underwriting",
      bigQueryLoadingTemporaryDirectory = "gs://ngm-dataflow/tmp",
    }
