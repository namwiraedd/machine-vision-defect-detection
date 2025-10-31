#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# 1. Check config
if [ ! -f "$ROOT_DIR/config/app_config.yml" ]; then
  echo "Missing config/app_config.yml — copy config/app_config.example.yml and edit values."
  exit 1
fi

# 2. Build & run
cd "$ROOT_DIR/docker"
docker-compose pull || true
docker-compose build
docker-compose up -d

echo "Deployed. Check logs with: docker-compose logs -f"
