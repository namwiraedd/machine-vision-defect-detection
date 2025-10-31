# Deployment Runbook (Single-server GPU)

This document explains how to deploy the MV Production stack on a single Ubuntu 22.04 server with an NVIDIA GPU.

## Prerequisites
- Ubuntu 22.04 LTS
- NVIDIA GPU (recommended RTX A2000/A4000 or better)
- 32+ GB RAM, NVMe storage
- 1 Gbps or 10 Gbps network (GigE cameras need isolated NIC)
- Ports: 8000 (API), 5556 (ZMQ pub), other internal ports

## Steps
1. Clone repo to `/opt/mv-production`
2. Copy config: `cp config/app_config.example.yml config/app_config.yml` and edit values.
3. Run `deploy/install-cuda-ubuntu.sh` as root to install Docker + nvidia-docker.
4. `cd docker && docker-compose up --build -d`
5. Tail logs: `docker-compose logs -f api`

## Systemd service
- Copy `deploy/setup-systemd.service.template` to `/etc/systemd/system/mv-production-api.service` and replace `USER`.
- Enable: `systemctl enable --now mv-production-api.service`

## Monitoring & Logging
- Use `docker stats` and `nvidia-smi` for GPU monitoring.
- Forward logs to Prometheus/Grafana in prod via exporters (not included in this repo).
