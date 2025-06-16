# Ceph storage cluster configuration

# Variables for Ceph cluster
variable "ceph_mon_count" {
  default = 3
  description = "Number of Ceph monitor nodes"
}

variable "ceph_osd_count" {
  default = 3
  description = "Number of Ceph OSD nodes"
}

variable "ceph_network" {
  default = "192.168.1.0/24"
  description = "Network for Ceph cluster communication"
}

# Ceph monitor nodes
resource "proxmox_vm_qemu" "ceph_mon" {
  count       = var.ceph_mon_count
  name        = "ceph-mon-${count.index + 1}"
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

# Ceph OSD nodes
resource "proxmox_vm_qemu" "ceph_osd" {
  count       = var.ceph_osd_count
  name        = "ceph-osd-${count.index + 1}"
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
    size    = "32G"
  }

  # Additional disks for OSD storage
  disk {
    type    = "scsi"
    storage = "local-lvm"
    size    = "100G"
  }

  disk {
    type    = "scsi"
    storage = "local-lvm"
    size    = "100G"
  }

  os_type = "cloud-init"
  ipconfig0 = "ip=dhcp"
}

# Ceph pool configuration
resource "proxmox_storage_ceph_pool" "vm_storage" {
  name = "vm-storage"
  size = 3  # Replication factor
  min_size = 2
  pg_num = 128
  
  depends_on = [
    proxmox_vm_qemu.ceph_mon,
    proxmox_vm_qemu.ceph_osd
  ]
}

# Storage configuration for VMs
resource "proxmox_storage" "ceph_storage" {
  storage = "ceph-vm-storage"
  type    = "rbd"
  pool    = "vm-storage"
  nodes   = local.proxmox_nodes
  content = ["images", "rootdir"]
  
  depends_on = [
    proxmox_storage_ceph_pool.vm_storage
  ]
}
