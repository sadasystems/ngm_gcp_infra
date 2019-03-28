# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------
terragrunt = {
  remote_state {
    backend = "gcs"

    config {
      bucket = "${get_env("TF_VAR_bucket", "default-bucket")}"
      prefix = "${get_env("TF_VAR_env", "default-env")}/${path_relative_to_include()}"
    }
  }

  terraform {
    # Set the required terraform version.
    required_version = "= 0.11.8"

    # Force Terraform to keep trying to acquire a lock for
    # up to 20 minutes if someone else already has the lock
    extra_arguments "retry_lock" {
      commands  = ["${get_terraform_commands_that_need_locking()}"]
      arguments = ["-lock-timeout=20m"]
    }

    # The arguments to call when performing a 'terraform init'
    extra_arguments "init_args" {
      commands = [
        "init",
      ]

      arguments = [
        "-var-file=${get_tfvars_dir()}/${path_relative_from_include()}/Environments/${get_env("TF_VAR_env", "default")}.tfvars",
      ]
    }

    # Load in the environment-based var files.
    extra_arguments "custom_vars" {
      commands = ["${get_terraform_commands_that_need_vars()}"]

      arguments = [
        "-var-file=${get_tfvars_dir()}/${path_relative_from_include()}/Environments/${get_env("TF_VAR_env", "default")}.tfvars",
      ]
    }
    /*
    before_hook "pre-flight-checks" {
      commands     = ["apply", "plan"]
      execute      = ["/Users/George/Dev/ngm_gcp_infra/pre-flight-checks.sh"]
      run_on_error = false
    }
    */
  }
}
