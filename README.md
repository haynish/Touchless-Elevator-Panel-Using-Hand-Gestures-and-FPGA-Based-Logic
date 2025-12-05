# Touchless Elevator Panel Using Hand Gestures and FPGA Logic  
### A Gesture-Controlled Floor Selection System Using Python + OpenCV + MediaPipe + Basys-3 FPGA

---

## 🚀 Project Overview

This project implements a **touchless elevator control system** using computer vision and FPGA logic.  
A webcam detects **hand gestures (0-10 fingers)** using Python + MediaPipe.  
The detected floor number is transmitted via **UART** to a **Basys-3 FPGA**, which displays the selected floor on a **4-digit 7-segment display**.

This system demonstrates modern, hygienic **Human–Machine Interaction (HMI)** by replacing physical buttons with gesture-based control.

---

## 📌 Features

- Real-time hand tracking using **MediaPipe Hands**
- Finger-count based floor selection (0–10)
- Stabilized gesture detection (reduces flicker)
- UART communication at 9600 baud
- FPGA-based:
  - UART Receiver  
  - 7-segment multiplexing driver  
  - Real-time floor number display  
- Optional voice feedback using **pyttsx3**

---

## 🛠️ Technologies Used

### **Software**
- Python 3.x  
- OpenCV  
- MediaPipe  
- PySerial  
- Pyttsx3  
- Vivado Design Suite  

### **Hardware**
- Basys-3 Artix-7 FPGA Board  
- Webcam  
- USB Cable  

---


---

## 🔧 How It Works

### **1️⃣ Python Side (PC)**
- Captures webcam frames  
- Detects hands + counts raised fingers  
- Stabilizes gesture (hold for 1.5 seconds)  
- Sends floor value via UART  
- Speaks out “Floor X” using text-to-speech  

### **2️⃣ FPGA Side**
- Receives UART data (8-bit)  
- Extracts lower 4 bits (0–15)  
- Computes:
  - Ones digit  
  - Tens digit  
- Updates rightmost two 7-segment digits  

---

## ▶️ Running the Project

### **PC Setup**
```bash
pip install opencv-python mediapipe pyserial pyttsx3
python gesture_control.py
