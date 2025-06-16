# Backup configuration for Proxmox VMs and containers

terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

# Variables for backup configuration
variable "backup_schedule" {
  default = "0 2 * * *"  # 2 AM daily
  description = "Backup schedule in cron format"
}

variable "backup_retention" {
  default = "7"
  description = "Number of backups to retain"
}

# Backup storage configuration
# resource "proxmox_storage" "backup_storage" {
#   storage     = "backup"
#   type        = "dir"
#   path        = "/var/lib/vz/backup"
#   content     = ["backup"]
#   nodes       = local.proxmox_nodes
# }

# Backup job for VMs
# resource "proxmox_virtual_environment_backup" "vm_backup" {
#   schedule      = var.backup_schedule
#   selection     = "all"
#   storage       = "backup"
#   compression   = "zstd"
#   mode          = "snapshot"
#   retention     = var.backup_retention
#   
#   notification_target {
#     type    = "email"
#     address = "admin@yourdomain.com"
#   }
# }
