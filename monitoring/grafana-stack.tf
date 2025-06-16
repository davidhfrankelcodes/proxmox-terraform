# Grafana monitoring stack configuration

terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

# Variables for monitoring
variable "grafana_version" {
  default = "9.5.2"
  description = "Grafana version to deploy"
}

variable "prometheus_version" {
  default = "2.44.0"
  description = "Prometheus version to deploy"
}

# Monitoring VM configuration
resource "proxmox_vm_qemu" "monitoring_stack" {
  name        = "monitoring-stack"
  target_node = "pve1"
  clone       = "ubuntu-cloud-template"
  
  cores    = 2
  sockets  = 1
  memory   = 4096
  
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
  
  disk {
    type    = "scsi"
    storage = "local-lvm"
    size    = "32G"
  }

  os_type = "cloud-init"
  ipconfig0 = "ip=dhcp"

  provisioner "remote-exec" {
    inline = [
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "sh get-docker.sh",
      "docker-compose up -d"
    ]
  }
}

# Prometheus configuration
resource "proxmox_lxc" "prometheus" {
  target_node  = "pve1"
  hostname     = "prometheus"
  ostemplate   = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.gz"
  unprivileged = true
  
  rootfs {
    storage = "local-lvm"
    size    = "16G"
  }
  
  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }
}