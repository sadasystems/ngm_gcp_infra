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
# Dataflow
#
job_name = "ngm-dataflow-pdp-orders"
max_workers = 1
on_delete = "cancel"
template_gcs_path = "gs://ngm-dataflow/templates/PdpApiToBigQueryBatch"
temp_gcs_location = "gs://ngm-dataflow/tmp"
job_parameters =
    {
      urlString = "http://35.244.203.113/services/api/pronto/order/list",
      timestamp = "08/12/2015",
      username = "teamsada",
      password = "WAVfx19",
      outputTable = "northgate-data-lake:pdp.orders",
      bigQueryLoadingTemporaryDirectory = "gs://ngm-dataflow/tmp",
    }


#
# GCS Bucket Objects upload
#
bucket = "ngm-dataflow"

object_list = [
  {
    source = "files/order_schema.json",
    destination = "orders/files/orders-schema.json"
  },
]

# append these additional users object permissions.
role_entities = [
    "OWNER:user-george.lerma@sadasystems.com"
]