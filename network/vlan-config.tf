# Network and VLAN configuration

# Variables for network configuration
variable "vlan_ids" {
  type = map(number)
  default = {
    management = 10
    storage    = 20
    vm_network = 30
    dmz        = 40
  }
}

# Network bridge configuration
resource "proxmox_network_bridge" "vmbr0" {
  node     = "pve1"
  name     = "vmbr0"
  bridge_ports = "eno1"
  bridge_stp   = true
  bridge_fd    = 0
}

# VLAN aware bridge
resource "proxmox_network_bridge" "vmbr1" {
  node     = "pve1"
  name     = "vmbr1"
  bridge_ports = "eno2"
  bridge_vlan_aware = true
  bridge_stp   = true
  bridge_fd    = 0
}

# VLANs configuration
resource "proxmox_network_vlan" "management" {
  node     = "pve1"
  bridge   = "vmbr1"
  vlan_id  = var.vlan_ids["management"]
  comment  = "Management Network"
}

resource "proxmox_network_vlan" "storage" {
  node     = "pve1"
  bridge   = "vmbr1"
  vlan_id  = var.vlan_ids["storage"]
  comment  = "Storage Network"
}

resource "proxmox_network_vlan" "vm_network" {
  node     = "pve1"
  bridge   = "vmbr1"
  vlan_id  = var.vlan_ids["vm_network"]
  comment  = "VM Network"
}

resource "proxmox_network_vlan" "dmz" {
  node     = "pve1"
  bridge   = "vmbr1"
  vlan_id  = var.vlan_ids["dmz"]
  comment  = "DMZ Network"
}
