# 🌵 Automated Plant Disease & Pest Detection System
> **Bridging the Digital Divide with Offline-First AI for Indigenous Highland Crops**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Paper Status](https://img.shields.io/badge/Paper-Submitted-blue)](https://arxiv.org/)
[![Framework](https://img.shields.io/badge/Framework-PyTorch%20%7C%20TensorFlow-orange)](https://pytorch.org/)
[![Flutter](https://img.shields.io/badge/Mobile-Flutter-02569B)](https://flutter.dev/)
[![Platform](https://img.shields.io/badge/Platform-Android-green)](https://www.android.com/)

---
📄 Paper: arXiv:2512.11871
https://arxiv.org/abs/2512.11871

## 📖 Overview
Agriculture supports major portion of the population in developing communities like Tigray, Ethiopia. This project introduces an **offline-first**, AI-powered diagnostic tool specifically designed for the indigenous **Cactus-fig (*Opuntia ficus-indica*)** crop.

By benchmarking hybrid architectures (**MobileViT-XS** vs. **Lightweight CNN**), we provide a solution that balances **clinical-grade accuracy (97.3%)** with **real-time performance (42ms)** on low-end Android devices.

---

## 🚀 Key Innovations

### 1. **Indigenous Dataset Curation**
We curated a novel dataset of **3,587 field-verified images** of *Opuntia ficus-indica*, capturing complex pathologies like **Cochineal Infestation** and **Fungal Rot** in real-world conditions (dust, shadows, occlusion).

### 2. **Dual-Architecture Strategy (The Trade-off)**
We benchmarked two distinct architectures to solve the "Accuracy vs. Efficiency" dilemma:
* **🏎️ Efficiency Champion:** A **Custom Lightweight CNN** (4.8 MB, 42ms latency) for real-time video scanning on legacy Android devices.
* **🎯 Accuracy Champion:** A fine-tuned **MobileViT-XS** (9.3 MB, 68ms latency) that achieves **97.3% accuracy**, using Self-Attention to resolve complex visual ambiguities.

### 3. **Human-Centric Deployment**
* **Offline-First:** Fully quantized TensorFlow Lite (Float16) models run without internet.
* **Inclusive UI:** A Flutter-based mobile application localized in **Tigrigna** to empower rural farmers.

---

## 📊 Performance Benchmarks

| Model Architecture | Accuracy | F1-Score | Model Size | Inference (ARM A53) |
| :--- | :---: | :---: | :---: | :---: |
| **MobileViT-XS (Hybrid)** | **97.3%** | **0.98** | 9.3 MB | 68 ms |
| EfficientNet-Lite1 | 90.7% | 0.90 | 19.0 MB | 55 ms |
| **Proposed Custom CNN** | 89.5% | 0.89 | **4.8 MB** | **42 ms** |

> *Note: Benchmarks performed on a held-out test set of 1,195 indigenous cactus images.*

---

## 📂 Dataset Access
The **Indigenous Cactus-Fig Dataset** is open-sourced to accelerate research in xerophytic crop pathology.

| **Class** | **Description** |
| :--- | :--- |
| 🐛 **Affected** | Cochineal infestation, fungal rot, lesions |
| 🌿 **Healthy** | Asymptomatic cladodes |
| 🚫 **No Cactus** | Background noise rejection |

👉 **[Download Dataset from Kaggle](https://www.kaggle.com/datasets/tekleabg/cactus-final)**

---

## 🛠️ Tech Stack
* **AI/ML:** PyTorch, TensorFlow, Keras, TFLite
* **Mobile:** Flutter (Dart)
* **Backend:** Django REST Framework (Python)
* **Tools:** Git, Kaggle Kernels

---

## ⚙️ Installation & Setup

### 1. Clone the Repository
```bash
git clone [https://github.com/Tekleab15/Automated_plant_disease_and_pest_detection_system.git](https://github.com/Tekleab15/Automated_plant_disease_and_pest_detection_system.git)
cd Automated_plant_disease_and_pest_detection_system

2. Set Up Python Environment (Training)
python -m venv venv
# Activate the environment
source venv/bin/activate  # Linux/Mac
# venv\Scripts\activate   # Windows

# Install Python dependencies
pip install -r requirements.txt

3. Run the Mobile App (Flutter)
cd mobile_app/flutter_app
flutter pub get
flutter run

3. Run the Mobile App (Flutter)
cd mobile_app/flutter_app
flutter pub get
flutter run


4. Run the Backend (Django Rest Framework)
cd back_end
python manage.py migrate
python manage.py runserver
