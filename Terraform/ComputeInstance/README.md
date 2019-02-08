# Terraform Component

CdhWorkflow

## Description

This component provisions the Cloudera Workflow host.

---
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| amount | Number of Compute Instances to spin up. | string | - | yes |
| boot_disk_image | [Available OS images/templates](https://cloud.google.com/compute/docs/images) | string | - | yes |
| boot_disk_size | Primary disk size in GB | string | `20` | no |
| boot_disk_type | The GCE disk type. May be set to pd-standard or pd-ssd. | string | `pd-standard` | no |
| disk1_disk_type | The disk1 tmp disk type. Can be either pd-ssd, local-ssd, or pd-standard. | string | `pd-ssd` | no |
| disk1_size_gb | The size of the tmp disk in gigabytes. | string | - | yes |
| disk2_disk_type | The disk2  disk type. Can be either pd-ssd, local-ssd, or pd-standard. | string | - | yes |
| disk2_size_gb | The size of the disk in gigabytes. | string | - | yes |
| env | Used for referencing TF_VAR_env | string | - | yes |
| instance_name_prefix | Set the prefix name attached to each created compute instance. | string | - | yes |
| machine_type | Set the machine type desired: https://cloud.google.com/compute/pricing | string | - | yes |
| network | Name of the network to deploy instances to. | string | `default` | no |
| project_id | The name of the project | string | - | yes |
| region | Region for cloud resources. | string | - | yes |
| subnetwork | The GCP subnetwork to deploy compute instances into | string | `default` | no |
| target_tags | A list of network tags to attach to each created compute instance. | list | - | yes |
| zone | Zone for managed instance groups. | string | - | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->