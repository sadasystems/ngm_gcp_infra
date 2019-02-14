# Terraform Component

Network

## Description

This component provisions the Google VPC network and subnetworks.

## Network ranges in use or reserved

| Account | Environment | Network | Name | CIDR Range | Number of IPs | Purpose |
| ------| ------| ------ | ------ | ------ | ------ |  ------ |
| ngm-datalake-gcp | POC | ngm-datalake-vpc | mgmt-red | 172.16.1.0/24 | 254 | Management Subnetwork  |


---
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| network_name | The name of the network being created | string | - | yes |
| project_id | The name of the project | string | - | yes |
| region | Region for cloud resources. | string | `us-central1` | no |
| secondary_ranges | Secondary ranges that will be used in some of the subnets | map | - | yes |
| shared_vpc_host | Makes this project a Shared VPC host if 'true' (default 'false') | string | `false` | no |
| subnets | The list of subnets being created | list | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| gateway_ipv4 | The IPv4 address of the gateway |
| name | The unique name of the network |
| self_link | The URL of the created resource |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
