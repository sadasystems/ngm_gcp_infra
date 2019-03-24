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
name = "ngm-tier3-files"
force_destroy = true

lifecycle_rules = [
    {
      action = [
        {
          type = "SetStorageClass",
          storage_class = "COLDLINE"
        },
      ]

      condition = [
        {
          age = 30
        },
      ]
    }
  ]

# append these users to the permissions set.
role_entities = [
    "WRITER:user-ngclouddevp@northgatemarkets.com"
]


#
# GCS Bucket Objects
#
bucket = "ngm-tier3-files"

object_list = [
  {
    source = "files/dummyfile.txt",
    destination = "tier3/"
  },
  {
    source = "files/dummyfile.txt",
    destination = "powercheck/"      
  }
]

# append these additional users object permissions.
object_role_entities = [
]
