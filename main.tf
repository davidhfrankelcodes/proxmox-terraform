terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

# Provider configuration
provider "proxmox" {
  pm_api_url      = var.proxmox_api_url
  pm_user         = var.proxmox_user
  pm_password     = var.proxmox_password
  pm_tls_insecure = true # Set to false in production
}

# Variables
variable "proxmox_api_url" {
  description = "The Proxmox API URL"
  type        = string
}

variable "proxmox_user" {
  description = "Proxmox user name"
  type        = string
}

variable "proxmox_password" {
  description = "Proxmox password"
  type        = string
  sensitive   = true
}

variable "container_password" {
  description = "Password for containers"
  type        = string
  sensitive   = true
}

variable "container_ssh_keys" {
  description = "SSH public keys to add to containers"
  type        = list(string)
  default     = []
}

# Local variables
locals {
  proxmox_nodes = ["pve1", "pve2", "pve3"] # Add your node names
  default_tags = {
    environment = "homelab"
    managed_by  = "terraform"
  }
}

# Module imports
module "ubuntu_templates" {
  source = "./templates"
  container_password = var.container_password
  container_ssh_keys = []
}

module "kubernetes" {
  source = "./kubernetes"
  proxmox_nodes = local.proxmox_nodes
}

module "containers" {
  source             = "./containers"
  container_password = var.container_password
}

module "network" {
  source = "./network"
}

module "storage" {
  source = "./storage"
  proxmox_nodes = local.proxmox_nodes
}

module "monitoring" {
  source = "./monitoring"
}

module "backup" {
  source = "./backup"
}

# Output important information
output "cluster_status" {
  description = "Status of the Proxmox cluster"
  value = {
    nodes      = local.proxmox_nodes
    templates  = module.ubuntu_templates
    kubernetes = module.kubernetes
  }
}
