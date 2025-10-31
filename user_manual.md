# User Manual (Operators)

## Overview
The system provides:
- Camera manager (add/remove cameras)
- Real-time screening (traditional CV)
- Deep learning inference service
- Local REST API `/result/{frame_id}` and optional ZMQ publishing

## Starting & Stopping
- Start: `deploy/deploy.sh`
- Stop: `docker-compose down`

## Add / Remove Cameras
- Edit `config/app_config.yml` -> `cameras` and add camera block.
- Restart camera service (or use rolling restart script in future).

## Querying results
- Health: `GET http://<host>:8000/health`
- Result: `GET http://<host>:8000/result/<frame_id>`
- Sample response:
```json
{
  "frame_id": "cam_01_20251031T120000Z_0001",
  "cam_id": "cam_01",
  "defects": [
    { "type": "scratch", "bbox": [100,50,40,60], "confidence": 0.93 }
  ]
}
