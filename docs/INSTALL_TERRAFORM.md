# Installing Terraform

This guide covers the installation of Terraform and the Proxmox provider.

## Prerequisites
- Linux, macOS, or Windows system
- Internet connection
- Administrative privileges

## Installation Steps

### Linux (Ubuntu/Debian)
```bash
# Add HashiCorp GPG key
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

# Add HashiCorp repository
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# Install Terraform
sudo apt update
sudo apt install terraform
```

### macOS
```bash
# Using Homebrew
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

### Windows
```powershell
# Using Chocolatey
choco install terraform

# Or download installer from:
# https://www.terraform.io/downloads.html
```

## Verify Installation
```bash
# Check version
terraform version

# Initialize working directory
terraform init
```

## Proxmox Provider Setup

1. **Create Provider Configuration**
   ```hcl
   # main.tf
   terraform {
     required_providers {
       proxmox = {
         source = "telmate/proxmox"
         version = "2.9.14"
       }
     }
   }

   provider "proxmox" {
     pm_api_url = "https://proxmox-server:8006/api2/json"
     pm_user = "root@pam"
     pm_password = "your-password"
     pm_tls_insecure = true
   }
   ```

2. **Initialize Provider**
   ```bash
   terraform init
   ```

## Environment Variables (Recommended)
```bash
export PM_API_URL="https://proxmox-server:8006/api2/json"
export PM_USER="root@pam"
export PM_PASS="your-password"
```

## Troubleshooting
- Ensure Proxmox API is accessible
- Verify credentials are correct
- Check firewall settings
- Validate TLS/SSL certificates

For more information, visit:
- [Terraform Documentation](https://www.terraform.io/docs)
- [Proxmox Provider Documentation](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs)
