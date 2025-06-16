# Ubuntu cloud-init template configuration

terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

# Variables for Ubuntu template
variable "ubuntu_version" {
  default = "22.04"
  description = "Ubuntu version for the template"
}

variable "template_name" {
  default = "ubuntu-cloud-template"
  description = "Name for the template VM"
}

variable "template_disk_size" {
  default = "32G"
  description = "Disk size for the template"
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

# Download Ubuntu cloud image
resource "null_resource" "download_ubuntu" {
  provisioner "local-exec" {
    command = <<-EOT
      wget https://cloud-images.ubuntu.com/releases/${var.ubuntu_version}/release/ubuntu-${var.ubuntu_version}-server-cloudimg-amd64.img
      qm create 9000 --memory 2048 --cores 2 --name ${var.template_name} --net0 virtio,bridge=vmbr0
      qm importdisk 9000 ubuntu-${var.ubuntu_version}-server-cloudimg-amd64.img local-lvm
      qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0
      qm set 9000 --ide2 local-lvm:cloudinit
      qm set 9000 --boot c --bootdisk scsi0
      qm set 9000 --serial0 socket --vga serial0
      qm template 9000
    EOT
  }
}

# Cloud-init configuration
resource "proxmox_vm_qemu" "ubuntu_template" {
  name        = var.template_name
  target_node = "pve1"
  clone       = "9000"  # ID from the template creation above
  
  cores    = 2
  sockets  = 1
  memory   = 2048
  
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
  
  disk {
    type    = "scsi"
    storage = "local-lvm"
    size    = var.template_disk_size
  }

  os_type = "cloud-init"
  
  # Cloud-init settings
  ciuser     = "ubuntu"
  cipassword = var.container_password
  
  # SSH keys can be added here
  sshkeys = <<-EOT
    ${join("\n", var.container_ssh_keys)}
  EOT
  
  # Basic cloud-init config
  cicustom = "user=local:snippets/user-data"
  
  # Ensure this is treated as a template
  template = true
}

# Output template information
output "template_info" {
  value = {
    name = proxmox_vm_qemu.ubuntu_template.name
    id   = proxmox_vm_qemu.ubuntu_template.vmid
  }
}
