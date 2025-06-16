# LXC container template configurations

terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

# Variables for container defaults
variable "container_password" {
  type = string
  sensitive = true
  description = "Default container root password"
}

variable "container_ssh_keys" {
  type = list(string)
  description = "SSH public keys to add to containers"
  default = []
}

# Basic Ubuntu container template
resource "proxmox_lxc" "ubuntu_template" {
  target_node  = "pve1"
  hostname     = "ubuntu-template"
  ostemplate   = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.gz"
  password     = var.container_password
  unprivileged = true
  
  ssh_public_keys = join("\n", var.container_ssh_keys)
  
  rootfs {
    storage = "local-lvm"
    size    = "8G"
  }
  
  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }
}

# Container template for monitoring
resource "proxmox_lxc" "monitoring_template" {
  target_node  = "pve1"
  hostname     = "monitoring-template"
  ostemplate   = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.gz"
  password     = var.container_password
  unprivileged = true
  
  ssh_public_keys = join("\n", var.container_ssh_keys)
  
  rootfs {
    storage = "local-lvm"
    size    = "16G"
  }
  
  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }

  features {
    nesting = true
  }
}
