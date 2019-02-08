# agilone_gcp_infra

This repository contains the Terraform code for AgilOne Infrastructure as Code provisioning in Google Cloud Platform.

## TL;DR

If you just need to just go, you know how to execute this code already, and don't wish to read all the info below ( *strongly-recommended* ), simply run the following commands from the top-level directly.

First time image builds with Packer:
```bash
$ export TF_VAR_project_id=agilone-gcp
$ export TF_VAR_zone=us-west1-a
$ packer build ./Packer/BaseImage/template.json
...
$ packer build ./Packer/OpenVpn/template.json
...
```
Provision all infrastructure:
```bash
$ export TF_VAR_env=dev
$ export TF_VAR_bucket=agilone-terraform-state
$ terragrunt apply-all
```
##### Abbreviations

Throughout this document, certain abbreviations are used:

GCP - "Google Cloud Platform"

IaC - "Infrastructure as Code"

GNU - "GNU's Not Unix!"

BSD - "Berkeley Software Distribution"
## Google Cloud Platform (GCP) Information


### GCP Projects

| Environment | GCP Project | GCP TF State Bucket | Region | Notes |
| ------ | ------ | ------ |  ------ |   ------ |
| POC | agilone-gcp | agilone-terraform-state |  us-west1 | Proof of Concept Environment |
| Dev | TBD | - | TBD |
| UAT | gplerma-sada-test | agilone-terraform-state-gplerma-test | us-central1 | Temporary POC Test Environment. Not used anymore |
| Stage | TBD | - | TBD |
| Production | TBD | - | | |

## Requirements for Successful Execution

### Git Repo Access

This repository and the Terraform code housed here utilizes Terraform 'modules', which are stored in a separate Git repository:  https://github.com/Agilone/agilone_gcp_tf_modules  Consequently, regardless of how this code is executed, or by whom, access to the `agilone_gcp_tf_modules` repository is required for successful execution.  Upon init of terraform, the modules will be downloaded automatically to this repo in special hidden directories.


### Execution Environment

Although the code was written and tested primarily from a MacBook MacOS environment, it should be generally expected to still work on a Linux (CentOS/Ubuntu,etc.), however as is the case with other BSD-derived OS's, there can be differences with certain OS-supplied commands because they  don't use GNU-type.   Since we are primarly running things with Terraform and Terragrunt, which are both written in GO, they should be expected to run the same on any platform.

### Environment Variables

In order to keep separation between mutiple environments and terraform states, you are required to set the following environment variables in the shell session that Terragrunt is executing from:

1.  `TF_VAR_env` - REQUIRED: The name of the environment var file to load in when running terraform actions.
* This variable will be read by Terragrunt and allow for dynamic loading of the <TF_VAR_env>.tfvars file that is located in the `Environments/` directory.
    * File Example:
`Environments/dev.tfvars`
2. `TF_VAR_bucket` - REQUIRED: The name of the remote state bucket to write state to.

To set the variables at the shell, for example:

```bash
$ export TF_VAR_env=dev
$ export TF_VAR_bucket=agilone-terraform-state
```

### Required Software

The following is the list of required software needed to execute this code.  Instructions on how to install this software are outside the scope of this document, however, the following links will take you to the respective vendor sites for details on downloading and installing the necessary software:

* [Git]  - Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.

* [Google Cloud SDK] - The Cloud SDK is a set of tools (gcloud, gsutils,etc.) for Cloud Platform.

* [Terragrunt] - Terragrunt is a GO binary, used  thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules.

* [Terraform] - Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently.

### Optional Software

This software is optional, however strongly recommended to help maintain the code readability and documentation.

[pre-commit] - A framework for managing and maintaining multi-language pre-commit hooks.

[NOTE]:  A pre-installed yaml files: `.pre-commit-config.yaml` is included in this repo + .hooks directory, which contains helper scripts for pre-commit.  You simply need to install pre-commit to use it.

### Execution of Terragrunt

Instead of executing `terraform` directly, you will execute the IaC using `terragrunt`.  Terragrunt forwards all other commands directly to Terraform.  It will additionaly provide for extended feratures and options.  For this project, you will ALWAYS run using `terragrunt`.

### Terragrunt Execution Examples

#### Building the Entire Infrastructure

If you wish to simply run a plan or 'dry-run' on the entire IaC,  execute `terragrunt` with the `plan-all` command from the top-level directory.  This will not actually provision anything, so is considered safe.  No interactive prompts will occur.

Example:

```bash
$ export TF_VAR_env=dev
$ export TF_VAR_bucket=agilone-gcp
$ terragrunt plan-all
```

To provision the entire infrastructure, execute the `terragrunt` command with the `apply-all` command from the top-level directory.

Example:

```bash
$ export TF_VAR_env=dev
$ export TF_VAR_bucket=agilone-gcp
$ terragrunt apply-all
```

#### Destroying the Entire Infrastructure

To destroy the entire infrastructure, execute `terragrunt` with the `destroy-all` command from the top-level directory.

Example:

```bash
$ export TF_VAR_env=dev
$ export TF_VAR_bucket=agilone-gcp
$ terragrunt destroy-all
```

#### Ignoring Dependency Errors on Destroy 

Sometimes, when needing to destroy the entire infrastructure, you may run into errors with dependent resources not cleanly removed due to various reasons.  For example, if you only created certain resources at the compoonent-level, but then ran a `destroy-all`, terraform will attempt to destroy some resources that where never created, resulting in errors.  To get around this run `terragrunt destroy-all` with the `--terragrunt-ignore-dependency-errors` flag from the top-level directory.  This flag will ignore errors related to failed dependend resources.  

Example:

```bash
$ export TF_VAR_env=dev
$ export TF_VAR_bucket=agilone-gcp
$ terragrunt destroy-all --terraform-ignore-dependancy-errors
```

#### Executing Terragrunt non-interactively

The `terragrunt` command will default to prompting the user before executing certain actions. To disable this feature, for example, using in a CI/CD job, use the `--terragrunt-non-interactive` flag.

Example:

```bash
$ export TF_VAR_env=dev
$ export TF_VAR_bucket=agilone-gcp
$ terragrunt apply-all --terragrunt-non-interactive
```

#### Execution of partial or single components

To build a single component of the entire infrastructure, execute `terragrunt` with the `apply` command.

Example 1:

```bash
$ cd Terraform/Network
$ export TF_VAR_env=dev
$ export TF_VAR_bucket=agilone-gcp
$ terragrunt apply
```

This will run `terragrunt` and build just the Network component.

Example 2:

```bash
$ cd Terraform/OpenVpn
$ terragrunt apply
```

This will run `terragrunt` and build just the OpenVpn component.


[NOTE]: You should be aware that most components have dependencies built in, and that may require other components to be built first.  For example, you cannot build the LbHttpProxy component without building MigHttpProxy first, because LbHttpProxy will depend on certain resources from MigHttpProxy.

[Git]: <https://git-scm.com/>
[Google Cloud SDK]: <https://cloud.google.com/sdk/>
[Terragrunt]: <https://github.com/gruntwork-io/terragrunt/releases/>
[Terraform]: <https://www.terraform.io/downloads.html/>
[pre-commit]: <https://pre-commit.com/>
[pre-commit-terraform]: <https://github.com/antonbabenko/pre-commit-terraform/>

#### Security Considerations

##### Terraform State

It is important to understand the function of Terraform state data. That topic is out of the scope of this document, but for this project, "tfstate" as is typically referred to, is stored in a GCP Bucket: `agilone-terraform-state`.   It will not be stored locally on any filesystem.  One must never assume that data is stored encrypted in this bucket. *_IT IS NOT_*.  Therefore always protect access to this bucket to only authorized persons or service accounts!  And always take care to think about how a secret is accessed or stored for creation of new resources with Terraform.

[NOTE]:  The GCP bucket referred to is NOT created by this IaC code.  It must be created prior to running this code.

#### FAQ

[Q] - What kind of branching strategy was used for development of this repo?

[A] - We used a branching strategy called "git flow", which is pretty useful, for a single person, up to many persons, working locally or remotely.  The key is that you don't typically don't work diretly int the master branch or develop branch.  In fact, in this repo, those branches are protected, and require a pull request to merge changes into. See: https://datasift.github.io/gitflow/IntroducingGitFlow.html for more detail on git flow.

### Troubleshooting

TODO

#### Uncompleted Items and (Tech Debt)

As of : [ 21 Nov 2018 ]

There were some issues or time-constrained features that were unable to be completed or accomplished:

1.  Adding of SSL certs and private key to http LB

* We don't have the private key to their wildcard cert so cannot install the cert on to the LB.

2.  Find a way to make all internal and public IPs static/reserved for all instances, and re-usable by Terraform.

* The consequences to this are that if you re-provision any compute instances, they are likely to get a diffeent IP address assigned, not a reserved IP.

3.  Private DNS Zones

* This is a relatively-new feature of GCP, so we could not take advantage of this service at the time of writing of this code.

4.  Add way to create nat gateway via 'gcloud' command.  or wait for Terraform to support creation of the resource.

* There is a way to work around unsupported Terraform modules, by using "null_resource" and "local_exec".  We just ran out of time before we could get to it.

5.  Security Audit

* As the timeline did not allow for this, we were unable to perform extensive security auditing, vulnerability scanning, or general "productionization" with respect to information technology security.  However, we did utilize best practices throughout as much as practical.  In future iterations, especially, prior to moving to a "production" environment, it would be highly advisable to run throug a security audit and make adjustments to IaC as-necessary.


6.  Add Ansible to ensure /etc/hosts file on all CDH nodes are configured appropriately for Cloudera to properly resolve host names.

* There were odd issues we ran into with adding nodes to clusters, getting heartbeat failures.  The solution is to run some kind of post-provision correction or verification of /etc/hosts files or have a proper DNS.


7.  Cloudera Host Inspector reports the following: `"Cloudera recommends setting /proc/sys/vm/swappiness to a maximum of 10. Current setting is 60. Use the sysctl command to change this setting at run time and edit /etc/sysctl.conf for this setting to be saved after a reboot. You can continue with installation, but Cloudera Manager might report that your hosts are unhealthy because they are swapping. The following hosts are affected: "`

* Pretty much, all compute instances that are provisioned are affected. - This likely should be addressed via Ansible, or via Packer customized host image.

8.  Figure out why Packer-generated image did not get accepted during provision.

* We have provided Packer as a means to manage your compute images more easily, however during provisioning of the IaC, we ran into errors while attempting to use the generated images.  We did not have time to explore further what the root cause was.  

