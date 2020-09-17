<div align="center">
    <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-backup-by-tags/master/figures/binbash-logo.png" 
    alt="drawing" width="250"/>
</div>
<div align="right">
  <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-backup-by-tags/master/figures/binbash-leverage-terraform-logo.png"
   alt="leverage" width="130"/>
</div>

# Terraform Module: AWS Backup By Tags

## Overview
Terraform module to provision AWS Backup. At the moment of this modules creation, there were only 2 modules that
offered a similar functionality, the only difference was that they only allowed to pass specific resource IDs.
This module allows the use of tags to define which resources are selected for backups.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.28 |
| aws | >= 2.70.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.70.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Solution name, e.g. 'app' or 'cluster' | `string` | n/a | yes |
| selection\_by\_tags | A map that defines the key/value pairs that will be used for backup resources selection | `map` | n/a | yes |
| cold\_storage\_after | Specifies the number of days after creation that a recovery point is moved to cold storage | `number` | `null` | no |
| completion\_window | The amount of time AWS Backup attempts a backup before canceling the job and returning an error. Must be at least 60 minutes greater than `start_window` | `number` | `null` | no |
| delete\_after | Specifies the number of days after creation that a recovery point is deleted. Must be 90 days greater than `cold_storage_after` | `number` | `null` | no |
| kms\_key\_arn | The server-side encryption key that is used to protect your backups | `string` | `null` | no |
| schedule | A CRON expression specifying when AWS Backup initiates a backup job | `string` | `null` | no |
| start\_window | The amount of time in minutes before beginning a backup. Minimum value is 60 minutes | `number` | `null` | no |
| tags | Additional tags (e.g. `map('BusinessUnit`,`XYZ`) | `map(string)` | `{}` | no |
| vault\_name | The name of the Backup Vault that will be associated to the Backup Plan | `string` | `"Default"` | no |

## Outputs

| Name | Description |
|------|-------------|
| backup\_plan\_arn | Backup Plan ARN |
| backup\_plan\_version | Unique, randomly generated, Unicode, UTF-8 encoded string that serves as the version ID of the backup plan |
| backup\_selection\_id | Backup Selection ID |

## Binbash Leverage | DevOps Automation Code Library Integration

In order to get the full automated potential of the
[Binbash Leverage DevOps Automation Code Library](https://leverage.binbash.com.ar/how-it-works/code-library/code-library/)  
you should initialize all the necessary helper **Makefiles**. 

#### How? 
You must execute the `make init-makefiles` command  at the root context

     
```shell
╭─delivery at delivery-I7567 in ~/terraform/terraform-aws-backup-by-tags on master✔ 20-09-17
╰─⠠⠵ make
Available Commands:
 - init-makefiles     initialize makefiles

``` 

### Why? 
You'll get all the necessary commands to automatically operate this module via a dockerized approach, 
example shown below

```shell
╭─delivery at delivery-I7567 in ~/terraform/terraform-aws-backup-by-tags on master✔ 20-09-17
╰─⠠⠵ make
Available Commands:
 - circleci-validate-config  ## Validate A CircleCI Config (https
 - format-check        ## The terraform fmt is used to rewrite tf conf files to a canonical format and style.
 - format              ## The terraform fmt is used to rewrite tf conf files to a canonical format and style.
 - tf-dir-chmod        ## run chown in ./.terraform to gran that the docker mounted dir has the right permissions
 - version             ## Show terraform version
 - init-makefiles      ## initialize makefiles
``` 

```shell
╭─delivery at delivery-I7567 in ~/terraform/terraform-aws-backup-by-tags on master✔ 20-09-17
╰─⠠⠵ make format-check 
docker run --rm -v /home/delivery/Binbash/repos/Leverage/terraform/terraform-aws-backup-by-tags:"/go/src/project/":rw -v :/config -v /common.config:/common-config/common.config -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/etc/gitconfig -v ~/.aws/bb:/root/.aws/bb -e AWS_SHARED_CREDENTIALS_FILE=/root/.aws/bb/credentials -e AWS_CONFIG_FILE=/root/.aws/bb/config --entrypoint=/bin/terraform -w "/go/src/project/" -it binbash/terraform-awscli-slim:0.12.28 fmt -check
```

## Roadmap
* Add support to create/use a different Backup Vault
* Handle conditional backup selection by resource IDs

---

# Release Management
### CircleCi PR auto-release job

<div align="left">
  <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-backup-by-tags/master/figures/circleci-logo.png" 
  alt="circleci" width="130"/>
</div>

- [**pipeline-job**](https://circleci.com/gh/binbashar/terraform-aws-backup-by-tags) (**NOTE:** Will only run after merged PR)
- [**releases**](https://github.com/binbashar/terraform-aws-backup-by-tags/releases)
- [**changelog**](https://github.com/binbashar/terraform-aws-backup-by-tags/blob/master/CHANGELOG.md)
