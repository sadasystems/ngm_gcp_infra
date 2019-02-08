# Terraform Component

Network

## Description

This component provisions the Google VPC network and subnetworks.

## Network ranges in use or reserved

| Account | Environment | Network | Name | CIDR Range | Number of IPs | Purpose |
| ------| ------| ------ | ------ | ------ | ------ |  ------ |
| agilone-gcp | POC | agilone-vpc | us-west1-red | 172.16.1.0/24 | 254 | Used by public-facing services such as load balancers and vpn endpoints.
| agilone-gcp | POC  | agilone-vpc | us-west1-pink | 172.16.3.0/24 | 254 | Used by backend database compute instances.
| agilone-gcp | POC  | agilone-vpc | us-west1-blue | 172.16.4.0/24 | 254 | Used by frontend web services or proxies compute instances.
| agilone-gcp | POC   | agilone-vpc | us-west1-green | 172.16.8.0/24 | 254 | Used by API service compute instances.
| agilone-gcp | POC   | agilone-vpc | us-west1-black |172.16.12.0/22| 1022| Used by CDH services compute instances.
| agilone-gcp | POC  | agilone-vpc | google-managed-services-agilone-vcp | 172.16.16.0/20 |4094 | RESERVED ip range used for vpc peering with google managed services.


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
