# Ubuntu Cloud Templates

Manages Ubuntu cloud-init templates for VM deployment.

## Features
- Automated template creation
- Cloud-init integration
- Custom sizing options
- SSH key management

## Usage

1. Configure template:
```hcl
ubuntu_version = "22.04"
template_name = "ubuntu-cloud-template"
template_disk_size = "32G"
```

2. Create template:
```bash
terraform apply
```

## Template Details
- Base OS: Ubuntu Server
- Cloud-init enabled
- Virtio networking
- SCSI storage