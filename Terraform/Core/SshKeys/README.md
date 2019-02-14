# Terraform Component

SshKeys

## Description

This component provisions SSH public keys into Google metadata.  This is later used by Google compute instances that allow global public keys.

NOTE: The public keys themselves should optimally be set in Enviroment/<ENV FILE>.tfvars
NOTE2:  We did not create a separate module in https://github.com/Agilone/agilone_gcp_tf_modules.git for this.

---
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project_id | The name of the project | string | - | yes |
| ssh_pub_keys | A group of ssh public keys to apply globally to all instances in a project, that don't have project-wide ssh keys disabled. | string | - | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
