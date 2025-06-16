# Backup Configuration

This directory contains Terraform configurations for automated Proxmox backups.

## Features
- Scheduled VM and container backups
- Configurable retention policies
- Email notifications
- Compression support

## Usage

1. Configure backup variables in `terraform.tfvars`:
```hcl
backup_schedule = "0 2 * * *"  # 2 AM daily
backup_retention = "7"         # Keep 7 backups
```

2. Update email notification settings in `backup-jobs.tf`

3. Apply the configuration:
```bash
terraform apply
```

## Configuration Options
- `backup_schedule`: Cron format schedule
- `backup_retention`: Number of backups to keep
- Storage location: `/var/lib/vz/backup`