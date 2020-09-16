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
Terraform module to provision AWS Backup. At the moment of this modules creation, there were only 2 modules that offered a similar functionality, the only difference was that they only allowed to pass specific resource IDs. This module allows the use of tags to define which resources are selected for backups.

## Roadmap
* Improve documentation
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
