# Terraform Component

Firewall

## Description

This component provisions GCP network firewall rules.

---
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| env | Used for referencing TF_VAR_env | string | - | yes |
| external_source_ranges | A list of source internet-routable CIDR ranges that this firewall applies to. Can't be used for EGRESS | list | - | yes |
| internal_source_ranges | A list of source internal RFC-1918 CIDR ranges that this firewall applies to. Can't be used for EGRESS | list | - | yes |
| project_id | The name of the project | string | - | yes |
| region | Region for cloud resources. | string | `us-central1` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->