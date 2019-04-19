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
  },
  {
    table_name = "cust_phone_extract",
    table_description = "Tier3 Customer Phone Extract",
    json_schema_file = "files/cust_phone_extract-schema.json"
  },
  {
    table_name = "iss_acct_extract",
    table_description = "Tier3 ISS Account Extract",
    json_schema_file = "files/iss_acct_extract-schema.json"
  },
  {
    table_name = "iss_address_extract",
    table_description = "Tier3 ISS Address Extract",
    json_schema_file = "files/iss_address_extract-schema.json"
  },
   {
    table_name = "iss_phone_extract",
    table_description = "Tier3 ISS Phone Extract",
    json_schema_file = "files/iss_phone_extract-schema.json"
  },
  {
    table_name = "iss_basic_common",
    table_description = "Tier3 ISS Basic Common Extract",
    json_schema_file = "files/iss_basic_common-schema.json"
  },
  {
    table_name = "isss_id_extract",
    table_description = "Tier3 ISS Basic Common Extract",
    json_schema_file = "files/isss_id_extract-schema.json"
  },
  {
    table_name = "mo_transactions",
    table_description = "Tier3 Money Order Transactions",
    json_schema_file = "files/mo_transactions-schema.json"
  },
  {
    table_name = "pin_transactions",
    table_description = "Tier3 PIN Transactions",
    json_schema_file = "files/pin_transactions-schema.json"
  },
  {
    table_name = "teller_extract",
    table_description = "Tier3 Tellers Extract",
    json_schema_file = "files/teller_extract-schema.json"
  },
 {
    table_name = "tu_transactions",
    table_description = "Tier3 TU Transactions",
    json_schema_file = "files/tu_transactions-schema.json"
  },
 {
    table_name = "wt_receive_transactions",
    table_description = "Tier3 WT Receive Transactions",
    json_schema_file = "files/wt_receive_transactions-schema.json"
  },
 {
    table_name = "wt_send_transactions",
    table_description = "Tier3 WT Send Transactions",
    json_schema_file = "files/wt_send_transactions-schema.json"
  }
]

view = {}
