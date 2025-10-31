# mv-production-line-deploy

Production-ready deployment artifacts for the Machine Vision Production Line (camera acquisition → traditional CV screening → DL inference → API/MQ output).

This repo contains deployment scripts, Docker configs, systemd templates, and operational documentation suitable for uploading to GitHub and handing to DevOps/Engineering teams.

## Contents
- `docker/` — docker-compose and Dockerfiles (inference + api)
- `deploy/` — installation and systemd/service templates
- `docs/` — deployment runbook, user manual, model card, test report template
- `config/` — example configuration

## Quick start (single-server GPU)
1. Put credentials & config into `config/app_config.yml` (copy `config/app_config.example.yml`).
2. Install NVIDIA driver + Docker + nvidia-container-toolkit (see `deploy/install-cuda-ubuntu.sh`).
3. `cd docker && docker-compose up --build -d`
4. Check `http://<host>:8000/health`

For full steps, see `docs/deployment.md`.

## License
MIT — see LICENSE

