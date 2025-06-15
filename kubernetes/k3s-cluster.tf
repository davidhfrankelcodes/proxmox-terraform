# K3s Kubernetes cluster configuration

# Variables for K3s cluster
variable "k3s_master_count" {
  default = 3
  description = "Number of K3s master nodes"
}

variable "k3s_worker_count" {
  default = 2
  description = "Number of K3s worker nodes"
}

# K3s master nodes
resource "proxmox_vm_qemu" "k3s_master" {
  count       = var.k3s_master_count
  name        = "k3s-master-${count.index + 1}"
  target_node = element(local.proxmox_nodes, count.index)
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
}

# K3s worker nodes
resource "proxmox_vm_qemu" "k3s_worker" {
  count       = var.k3s_worker_count
  name        = "k3s-worker-${count.index + 1}"
  target_node = element(local.proxmox_nodes, count.index)
  clone       = "ubuntu-cloud-template"
  
  cores    = 4
  sockets  = 1
  memory   = 8192
  
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
  
  disk {
    type    = "scsi"
    storage = "local-lvm"
    size    = "64G"
  }

  os_type = "cloud-init"
  ipconfig0 = "ip=dhcp"
}
