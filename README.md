# Proxmox Terraform Automation

Infrastructure as Code for my homelab Proxmox cluster. This repo demonstrates automated VM provisioning, network configuration, and container management using Terraform and Proxmox VE.

## 🚀 Features
- Automated VM deployment
- Custom cloud-init templates
- Network automation
- Container (LXC) management
- Backup automation
- Resource monitoring

## 📋 Table of Contents

| Script | Description |
|--------|-------------|
| `main.tf` | Core infrastructure configuration |
| `templates/ubuntu-cloud.tf` | Ubuntu cloud-init template for quick VM deployment |
| `kubernetes/k3s-cluster.tf` | Lightweight K3s cluster deployment |
| `containers/lxc-templates.tf` | LXC container templates and configs |
| `network/vlan-config.tf` | VLAN and network segregation |
| `storage/ceph-cluster.tf` | Distributed storage configuration |
| `monitoring/grafana-stack.tf` | Monitoring stack deployment |
| `backup/backup-jobs.tf` | Automated backup configuration |

## 🛠 Prerequisites
- Proxmox VE 7.0+
- Terraform 1.0+
- Valid Proxmox API credentials

## 🚦 Getting Started
```bash
# Clone repo
git clone https://github.com/username/proxmox-terraform

# Initialize Terraform
terraform init

# Review planned changes
terraform plan

# Apply configuration
terraform apply
```

## 📊 Architecture
```
Proxmox Cluster
├── Compute Nodes
│   ├── VM Templates
│   └── LXC Containers
├── Storage
│   ├── Local
│   └── Distributed (Ceph)
└── Network
    ├── VLANs
    └── Load Balancers
```

## 📝 License
MIT

## 🤝 Contributing
PRs welcome! Check CONTRIBUTING.md for guidelines.
