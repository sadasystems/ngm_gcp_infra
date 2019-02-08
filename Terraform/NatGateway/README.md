# Terraform Component

NatGateway

## Description

This component provisions the Google NAT Gateway service. 
NOTE: The current terraform provisioner does not support creation of the NAT gateway. See https://github.com/terraform-providers/terraform-provider-google/issues/2249 for further reference.

---
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| env | Used for referencing TF_VAR_env | string | - | yes |
| network | Name of the network to deploy instances to. | string | `default` | no |
| project_id | The name of the project | string | - | yes |
| region | Region for cloud resources. | string | `us-central1` | no |
| zone | Zone for managed instance groups. | string | `us-central1-f` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->