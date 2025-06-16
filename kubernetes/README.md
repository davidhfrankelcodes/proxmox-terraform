# K3s Kubernetes Cluster

Deploys a lightweight Kubernetes cluster using K3s.

## Features
- Multi-master setup
- Worker node scaling
- Cloud-init integration
- Automated networking

## Usage

1. Configure cluster size:
```hcl
k3s_master_count = 3
k3s_worker_count = 2
```

2. Deploy cluster:
```bash
terraform apply
```

## Node Specifications
- Masters: 2 cores, 4GB RAM, 32GB storage
- Workers: 4 cores, 8GB RAM, 64GB storage