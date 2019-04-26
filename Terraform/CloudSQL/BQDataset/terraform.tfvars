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
# BigQuery
#
dataset_id = "db_pdp"
friendly_name = ""
dataset_description = "Direct DB Extracts "
delete_contents_on_destroy = true
dataset_labels = {
  dataset = "db_pdp"
}

time_partitioning = [
  {
    type = "DAY"
  }
]

table_list                 = [
  {
    table_name = "ck_disbursement",
    table_description = "PDP DB Check Disbursement",
    json_schema_file = "files/db_pdp_chk_disb.json"
  },
  {
    table_name = "ck_submission",
    table_description = "PDP DB Check Submission",
    json_schema_file = "files/db_pdp_chk_sbm.json"
  },
  {
    table_name = "cust_ofac_history",
    table_description = "Customer OFAC History",
    json_schema_file = "files/db_pdp_cust_ofac_hist.json"
  },
  {
    table_name = "cust_gpr_usg_hist",
    table_description = "Customer GPR Usage History",
    json_schema_file = "files/db_pdp_cust_ofac_hist.json"
  },
  {
    table_name = "ck_underwriting",
    table_description = "Check Underwriting Tracking",
    json_schema_file = "files/dp_pdp_chk_underwriting.json"
  },
  {
    table_name = "cust_gpr_card_load",
    table_description = "Customer GRP Card Load",
    json_schema_file = "files/dp_pdp_card_load.json"
  }
]

view = {}
