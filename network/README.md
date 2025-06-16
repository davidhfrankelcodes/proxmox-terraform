# Network Configuration

Manages network bridges and VLANs for Proxmox cluster.

## Features
- VLAN segregation
- Bridge configuration
- Network isolation
- DMZ setup

## Usage

1. Configure VLAN IDs:
```hcl
vlan_ids = {
  management = 10
  storage    = 20
  vm_network = 30
  dmz        = 40
}
```

2. Apply network config:
```bash
terraform apply
```

## Network Segments
- Management VLAN
- Storage VLAN
- VM Network VLAN
- DMZ VLAN