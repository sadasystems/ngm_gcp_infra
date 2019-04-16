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
dataset_id = "powercheck"
friendly_name = ""
dataset_description = "Powercheck Transactions"
delete_contents_on_destroy = true
dataset_labels = {
  dataset = "powercheck"
}

time_partitioning = [
  {
    type = "DAY"
  }
]

table_list                 = [
  {
    table_name = "ck_transactions",
    table_description = "Powercheck Check Transactions",
    json_schema_file = "files/ck_transactions-schema.json"
  },
  {
    table_name = "cust_address_extract",
    table_description = "Powercheck Customer Address Extract",
    json_schema_file = "files/cust_address_extract-schema.json"
  },
  {
    table_name = "cust_basic_common",
    table_description = "Powercheck Customer Basic Common",
    json_schema_file = "files/cust_basic_common-schema.json"
  },
  {
    table_name = "cust_email_extract",
    table_description = "Powercheck Customer Email Extract",
    json_schema_file = "files/cust_email_extract-schema.json"
  },
  {
    table_name = "cust_ids_extract",
    table_description = "Powercheck Customer ID Extract ",
    json_schema_file = "files/cust_ids_extract-schema.json"
  },
  {
    table_name = "cust_phone_extract",
    table_description = "Powercheck Customer Phone Extract ",
    json_schema_file = "files/cust_phone_extract-schema.json"
  },
  {
    table_name = "iss_acct_extract",
    table_description = "Powercheck ISS Account Extract ",
    json_schema_file = "files/iss_acct_extract-schema.json"
  },
  {
    table_name = "iss_address_extract",
    table_description = "Powercheck ISS Address Extract ",
    json_schema_file = "files/iss_address_extract-schema.json"
  },
  {
    table_name = "iss_basic_common",
    table_description = "Powercheck ISS Basic Common",
    json_schema_file = "files/iss_basic_common-schema.json"
  },
  {
    table_name = "iss_phone_extract",
    table_description = "Powercheck ISS Phone Extract",
    json_schema_file = "files/iss_phone_extract-schema.json"
  },
  {
    table_name = "teller_extract",
    table_description = "Powercheck Teller Extract",
    json_schema_file = "files/teller_extract-schema.json"
  },
]
view = {}
