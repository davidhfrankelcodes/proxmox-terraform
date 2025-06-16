# Monitoring Stack

Deploys Grafana and Prometheus for cluster monitoring.

## Features
- Grafana dashboard
- Prometheus metrics
- Automated deployment
- Docker integration

## Usage

1. Set versions in variables:
```hcl
grafana_version = "9.5.2"
prometheus_version = "2.44.0"
```

2. Deploy stack:
```bash
terraform apply
```

## Components
- Grafana UI
- Prometheus server
- Node exporters