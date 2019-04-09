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
# BigQuery
#
dataset_id = "tier3"
friendly_name = ""
dataset_description = "Tier3 Transactions"
delete_contents_on_destroy = true
dataset_labels = {
  dataset = "tier3"
}

time_partitioning = [
  {
    type = "DAY"
  }
]

table_list                 = [
  {
    table_name = "ck_transactions",
    table_description = "Tier3 Check Transactions",
    json_schema_file = "files/ck_transactions-schema.json"
  },
  {
    table_name = "bp_transactions",
    table_description = "Tier3 Bill Payment Transactions",
    json_schema_file = "files/bp_transactions-schema.json"
  },
  {
    table_name = "curc_transactions",
    table_description = "Tier3 Currency Exchange Transactions",
    json_schema_file = "files/curc_transactions-schema.json"
  },
  {
    table_name = "cust_address_extract",
    table_description = "Tier3 Customer Address Extract",
    json_schema_file = "files/cust_address_extract-schema.json"
  },
  {
    table_name = "cust_basic_common",
    table_description = "Tier3 Customer Basic Common Extract",
    json_schema_file = "files/cust_basic_common-schema.json"
  },
  {
    table_name = "cust_email_extract",
    table_description = "Tier3 Customer Emails Extract",
    json_schema_file = "files/cust_email_extract-schema.json"
  },
  {
    table_name = "cust_ids_extract",
    table_description = "Tier3 Customer IDs Extract",
    json_schema_file = "files/cust_ids_extract-schema.json"
  }
]

view = {}
