# 🌿 Automated Plant Disease and Pest Detection System

A real-time, AI-powered system for detecting plant diseases and pests in crops like cactus, apple, potato, and corn. Built with Convolutional Neural Networks (CNNs) and integrated into a Flutter mobile app with a Django backend, the system provides localized recommendations—including Tigrigna support—to empower farmers and improve food security.and finding best algorithms as well.

---

## 🚀 Key Features

- 🔍 **Multi-Crop Detection**: Supports cactus, apple, potato, and corn.
- 🧠 **Deep Learning Models**: Custom CNNs with plans for Vision Transformers
- 📱 **Mobile App**: Flutter-based app for real-time image-based diagnosis.
- 🌐 **Django Backend**: Manages data and serves model predictions.
- 🌍 **Localized Recommendations**: Includes Tigrigna and related local language support.
- 🧾 **Model Hosting**: Deployed on Hugging Face for easy access and integration.
- 🧪 **Expanding Dataset**: 26K+ images, with a focus on cactus disease and pest detection.

---

## 🛠️ Tech Stack

| Category     | Tools/Frameworks                          |
|--------------|-------------------------------------------|
| Languages    | Python, Dart                              |
| ML Framework | TensorFlow/Keras                          |
| Mobile       | Flutter                                   |
| Backend      | Django Rest Framework (DRF)               |
| Compute      | Kaggle Kernels (GPU)                      |
| Hosting      | Hugging Face                              |
| Tools        | Git, GitHub                               |

---

## ⚙️ Installation

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/Automated-plant-disease-and-pest-detection-system.git
cd Automated-plant-disease-and-pest-detection-system

### 2. Set Up Python Environment

```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt

### 3. Set Up Flutter App

```bash
cd mobile_app/flutter_app
flutter pub get
### 4. Set Up Django Backend

```bash
cd ../django_backend
python manage.py migrate
# Optional: python manage.py createsuperuser

### 📁 Dataset
- 26,394+ leaf images from public and local sources.
- Focused expansion on cactus diseases and pests.
- Augmentation: rotation, flipping, zooming.
- Preprocessing: resizing, normalization.

📲 Run App & Backend
```bash

# Django backend
cd mobile_app/django_backend
python manage.py runserver
# Flutter app
cd ../flutter_app
flutter run
