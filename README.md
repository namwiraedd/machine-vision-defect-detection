Multi-camera acquisition with synchronous or near-real-time triggering
Device management interface (add/remove cameras)
Dual detection core: Traditional: edge/texture/pattern detection (OpenCV), AI module: CNN-based classifier/detector for subtle defects (PyTorch/TensorFlow)
Unified results: (coordinates, defect_type, confidence)
Continuous thread-safe processing pipeline
Local API / Message Queue output (FastAPI + RabbitMQ supported)
Project Structure
machine-vision-defect-detection/
│
├── README.md
├── requirements.txt
├── setup.sh
├── config/
│   ├── cameras.yaml
│   ├── system_config.yaml
│   └── model_config.yaml
│
├── src/
│   ├── acquisition/
│   │   ├── camera_manager.py         # Manage camera connections
│   │   ├── multi_camera_trigger.py   # Sync or async acquisition
│   │   └── image_buffer.py           # Thread-safe buffer for captured frames
│   │
│   ├── processing/
│   │   ├── traditional_module.py     # Edge, texture, contour analysis
│   │   ├── ai_module.py              # CNN/DL-based defect detection
│   │   ├── fusion_module.py          # Combine traditional + AI results
│   │   └── postprocessing.py         # Filtering, formatting, and output
│   │
│   ├── integration/
│   │   ├── api_server.py             # FastAPI server for local endpoints
│   │   ├── message_queue.py          # RabbitMQ / Kafka producer
│   │   └── results_logger.py         # Store detection logs and metrics
│   │
│   ├── utils/
│   │   ├── config_loader.py
│   │   ├── logger.py
│   │   └── performance_timer.py
│   │
│   └── main.py                       # Entry point for the whole pipeline
│
├── models/
│   ├── trained_model.pt
│   └── training_script.py
│
├── data/
│   ├── sample_dataset/
│   │   ├── good/
│   │   └── defective/
│   ├── annotations.csv
│   └── test_images/
│
└── docs/
    ├── deployment_guide.md
    ├── user_manual.md
    └── performance_report.pdf
    Installation & Setup
    # 1. Clone the repo
git clone https://github.com/<your-username>/machine-vision-defect-detection.git
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
requirements.txt
opencv-python
numpy
pandas
torch
torchvision
tensorflow
fastapi
uvicorn
pika          # RabbitMQ client
pyyaml
scikit-learn
matplotlib
tqdm
workflow
Cameras are initialized and synchronized (multi_camera_trigger.py)
Each frame enters a thread-safe queue (image_buffer.py)
Traditional and AI modules process the image in parallel
fusion_module.py merges the detections
Unified results are sent to the API endpoint or message queue
Logs and inference metrics are stored locally

