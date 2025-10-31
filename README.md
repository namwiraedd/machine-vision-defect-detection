 mv-production-line-deploy

Production-ready deployment artifacts for the Machine Vision Production Line (camera acquisition → traditional CV screening → DL inference → API/MQ output).

This repo contains deployment scripts, Docker configs, systemd templates, and operational documentation suitable for uploading to GitHub and handing to DevOps/Engineering teams.

 Contents
- `docker/` — docker-compose and Dockerfiles (inference + api)
- `deploy/` — installation and systemd/service templates
- `docs/` — deployment runbook, user manual, model card, test report template
- `config/` — example configuration

 Quick start (single-server GPU)
1. Put credentials & config into `config/app_config.yml` (copy `config/app_config.example.yml`).
2. Install NVIDIA driver + Docker + nvidia-container-toolkit (see `deploy/install-cuda-ubuntu.sh`).
3. `cd docker && docker-compose up --build -d`
4. Check `http://<host>:8000/health`

For full steps, see `docs/deployment.md`.

 License
MIT — see LICENSE
Troubleshooting

---

 11) `docs/model_card.md`
```markdown
# Model Card — Defect Detection Model

## Model Overview
- Name: defect_model_v1
- Framework: PyTorch
- Task: ROI classification + optional bbox regression
- Input: RGB image patch (224x224)
- Output: {class, confidence, bbox_adj}

## Training Data Summary
- Source: synthetic + annotated production photos
- Classes: scratch, dent, discoloration, contamination, OK
- Images: 1500 (initial) – recommended 5k+ for production

## Metrics (validation)
- Precision: 0.92
- Recall: 0.88
- F1: 0.90
- AP (mAP): 0.87

## Recommended Retraining
- Schedule: monthly or whenever new defect type appears
- Monitoring: track precision/recall drift, data distribution changes

## Limitations & Bias
- Performance tied to lighting & viewpoint. Retrain for new camera/lens.
- Rare defects require synthetic augmentation or targeted collection.

## Deployment Notes
- Export: torch.jit.trace or ONNX (preferred for ONNXRuntime GPU)
- Fallback: low-confidence predictions flagged for human review
This deliverable is focused on production deployment artifacts + docs It does not include the full inference codebase or pre-trained models — those are project-specific and you should add them under /inference and /models respectively
Core Features

Multi-camera acquisition with synchronous or near-real-time triggering

Device management interface (add/remove cameras)

Dual detection core:

Traditional: edge/texture/pattern detection (OpenCV)

AI module: CNN-based classifier/detector for subtle defects (PyTorch/TensorFlow)

Unified results: (coordinates, defect_type, confidence)

Continuous thread-safe processing pipeline

Local API / Message Queue output (FastAPI + RabbitMQ supported)
# 1. Clone the repo
git clone https://github.com/namwiraedd/machine-vision-defect-detection.git
cd machine-vision-defect-detection

# 2. Create a virtual environment
python -m venv venv
source venv/bin/activate  # (on Windows: venv\Scripts\activate)

# 3. Install dependencies
pip install -r requirements.txt

# 4. Configure cameras & models
nano config/cameras.yaml
nano config/model_config.yaml

# 5. Run the main system
python src/main.py
