# ngm_gcp_infra

This repository contains the Terraform code for Northgate Markets Infrastructure as Code provisioning in Google Cloud Platform.

## TL;DR

Run the following commands from the top-level directly.

These commands assume you are already authenticated with your GCP user, or a service account.

Provision all infrastructure:
```bash
$ export TF_VAR_env=dev
$ export TF_VAR_bucket=northgate-markets-terraform-state
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
| Prod | northgate-data-lake | tfstate-northgate-data-lake | us-west1 |

## Requirements for Successful Execution

### Git Repo Access

This repository and the Terraform code housed here utilizes Terraform modules, which are stored in a separate Git repository:  https://github.com/sadasystems/gcp_tf_modules  Consequently, regardless of how this code is executed, or by whom, access to the `gcp_tf_modules` repository is required for successful execution.  Upon init of terraform, the modules will be downloaded automatically to this repo in special hidden directories.


### Execution Environment

Although the code was written and tested primarily from within a MacBook MacOS, it should be generally expected to still work on a Linux (CentOS/Ubuntu,etc.), however as is the case with other BSD-derived OS's, there can be differences with certain OS-supplied commands because they  don't use GNU-type.   Since we are primarly running things with Terraform and Terragrunt, which are both written in GO, they should be expected to run the same on any platform.

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
$ export TF_VAR_bucket=northgate-markets-terraform-state
```

### Required Software

The following is the list of required software needed to execute this code.  Instructions on how to install this software are outside the scope of this document, however, the following links will take you to the respective vendor sites for details on downloading and installing the necessary software:

* [Git]  - Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.

* [Google Cloud SDK] - The Cloud SDK is a set of tools (gcloud, gsutils,etc.) for Cloud Platform.

* [Terragrunt] - Terragrunt is a GO binary, used as as thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules.

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
$ export TF_VAR_bucket=northgate-markets-gcp
$ terragrunt plan-all
```

To provision the entire infrastructure, execute the `terragrunt` command with the `apply-all` command from the top-level directory.

Example:

```bash
$ export TF_VAR_env=dev
$ export TF_VAR_bucket=northgate-markets-gcp
$ terragrunt apply-all
```

#### Destroying the Entire Infrastructure

To destroy the entire infrastructure, execute `terragrunt` with the `destroy-all` command from the top-level directory.

Example:

```bash
$ export TF_VAR_env=dev
$ export TF_VAR_bucket=northgate-markets-gcp
$ terragrunt destroy-all
```

#### Ignoring Dependency Errors on Destroy 

Sometimes, when needing to destroy the entire infrastructure, you may run into errors with dependent resources not cleanly removed due to various reasons.  For example, if you only created certain resources at the compoonent-level, but then ran a `destroy-all`, terraform will attempt to destroy some resources that where never created, resulting in errors.  To get around this run `terragrunt destroy-all` with the `--terragrunt-ignore-dependency-errors` flag from the top-level directory.  This flag will ignore errors related to failed dependend resources.  

Example:

```bash
$ export TF_VAR_env=dev
$ export TF_VAR_bucket=northgate-markets-gcp
$ terragrunt destroy-all --terraform-ignore-dependancy-errors
```

#### Executing Terragrunt non-interactively

The `terragrunt` command will default to prompting the user before executing certain actions. To disable this feature, for example, using in a CI/CD job, use the `--terragrunt-non-interactive` flag.

Example:

```bash
$ export TF_VAR_env=dev
$ export TF_VAR_bucket=northgate-markets-gcp
$ terragrunt apply-all --terragrunt-non-interactive
```

#### Execution of partial or single components

To build a single component of the entire infrastructure, execute `terragrunt` with the `apply` command.

Example 1:

```bash
$ cd Terraform/Network
$ export TF_VAR_env=dev
$ export TF_VAR_bucket=northgate-markets-gcp
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

It is important to understand the function of Terraform state data. That topic is out of the scope of this document, but for this project, "terraform state" as is sometimes referred to, is stored in a GCP Bucket: `northgate-markets-terraform-state`.   It will not be stored locally on any filesystem.  One must never assume that data is stored encrypted in this bucket. *_IT IS NOT_*.  Therefore always protect access to this bucket to only authorized persons or service accounts!  And always take care to think about how a secret is accessed or stored for creation of new resources with Terraform.

[NOTE]:  The GCP bucket housing the terraform state file(s) is NOT created by this IaC code.  It must be created prior to running this code.

#### FAQ

[Q] - What kind of branching strategy was used for development of this repo?

[A] - We used a branching strategy called "git flow", which is pretty useful, for a single person, or up to many persons, working locally or remotely.  The key is that you don't typically don't work diretly int the master branch or develop branch.  In fact, in this repo, those branches are protected, and require a pull request to merge changes into. See: https://datasift.github.io/gitflow/IntroducingGitFlow.html for more detail on git flow.

### Troubleshooting

TODO

#### Uncompleted Items and (Tech Debt)

As of : [  ]

There were some issues or time-constrained features that were unable to be completed or accomplished:

