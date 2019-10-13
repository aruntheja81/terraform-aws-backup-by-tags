# Terraform Module: AWS Backup By Tags

## Overview
Terraform module to provision AWS Backup. At the moment of this modules creation, there were only 2 modules that offered a similar functionality, the only difference was that they only allowed to pass specific resource IDs. This module allows the use of tags to define which resources are selected for backups.

## Roadmap
* Improve documentation
* Add support to create/use a different Backup Vault
* Handle conditional backup selection by resource IDs
