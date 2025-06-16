# LXC Container Templates

Manages LXC container templates and configurations for Proxmox.

## Features
- Ubuntu-based templates
- Monitoring container template
- SSH key management
- Secure password handling

## Usage

1. Set required variables:
```hcl
container_password = "your-secure-password"
container_ssh_keys = [
  "ssh-rsa AAAA...",
  "ssh-rsa BBBB..."
]
```

2. Create containers:
```bash
terraform apply
```

## Templates
- Basic Ubuntu template (8GB storage)
- Monitoring template (16GB storage)