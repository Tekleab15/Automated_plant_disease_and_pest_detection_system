# 🌿 Automated Plant Disease and Pest Detection System
> **Bridging the Digital Divide with Offline-First AI for Indigenous Highland Crops**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Paper Status](https://img.shields.io/badge/Paper-Submitted-blue)](https://arxiv.org/)
[![Framework](https://img.shields.io/badge/Framework-PyTorch%20%7C%20TensorFlow-orange)](https://pytorch.org/)
[![Flutter](https://img.shields.io/badge/Mobile-Flutter-02569B)](https://flutter.dev/)

A robust, offline-first deep learning system designed to diagnose plant diseases in resource-constrained environments (Tigray, Ethiopia). This project introduces the **first machine-learning-ready dataset for Cactus-fig (*Opuntia ficus-indica*)** and benchmarks hybrid architectures to balance accuracy and efficiency on low-end hardware.

---

## 🚀 Key Innovations

### 1. **Indigenous Dataset Curation**
We curated a novel dataset of **3,587 field-verified images** of *Opuntia ficus-indica*, capturing complex pathologies like **Cochineal Infestation** and **Fungal Rot** in real-world conditions (dust, shadows, occlusion).

### 2. **Dual-Architecture Strategy (The Trade-off)**
We benchmarked two distinct architectures to solve the "Accuracy vs. Efficiency" dilemma:
* **🏎️ Efficiency Champion:** A **Custom Lightweight CNN** (3.1 MB, 42ms latency) for real-time video scanning on legacy Android devices.
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
| **Proposed Custom CNN** | 89.5% | 0.89 | **3.1 MB** | **42 ms** |

> *Note: Benchmarks performed on a held-out test set of 1,195 indigenous cactus images.*

---

## 🛠️ System Architecture

![System Overview](https://via.placeholder.com/800x400?text=Insert+Your+System+Diagram+Here)

The system consists of three core modules:
1.  **Training Pipeline (PyTorch/Keras):** Implements Stratified K-Fold Cross-Validation, AdamW optimization, and LIME explainability.
2.  **Backend (Django REST Framework):** Handles model versioning, user authentication, and (optional) cloud sync for epidemiological data collection.
3.  **Mobile Client (Flutter):** Runs the TFLite interpreter locally, mapping predictions to agronomic advice stored in a local SQLite database.

---

## ⚙️ Installation & Setup

### 1. Clone the Repository
```bash
git clone [https://github.com/Tekleab15/Automated_plant_disease_and_pest_detection_system.git](https://github.com/Tekleab15/Automated_plant_disease_and_pest_detection_system.git)
cd Automated_plant_disease_and_pest_detection_system
