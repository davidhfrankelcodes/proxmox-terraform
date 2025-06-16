# Ceph Storage Cluster

Configures distributed storage using Ceph.

## Features
- Monitor nodes
- OSD nodes
- Storage pools
- Replication

## Usage

1. Set cluster parameters:
```hcl
ceph_mon_count = 3
ceph_osd_count = 3
ceph_network = "192.168.1.0/24"
```

2. Deploy storage:
```bash
terraform apply
```

## Components
- Monitor nodes (4GB RAM)
- OSD nodes (8GB RAM)
- Storage pools
- VM storage integration
