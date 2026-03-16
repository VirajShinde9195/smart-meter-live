# ⚡ Smart Energy Meter with IoT-Based Recommendation System

## 📌 Project Overview

**WattWise** is an IoT-based smart energy monitoring system designed to help users understand and control their electricity consumption in real time.

Traditional electricity meters provide readings only once a month, which makes it difficult for users to track their daily energy usage. Because of this, many users unknowingly exceed electricity limits and receive high electricity bills.

To solve this problem, we developed **WattWise**, a smart energy monitoring system that uses an **ESP32 microcontroller and energy monitoring sensors** to measure electrical parameters and send data to the cloud. Users can view their electricity usage through a **mobile application dashboard** and receive **SMS alerts and recommendations** to reduce power consumption.

---

# 🚀 Key Features

✅ Real-time energy monitoring
✅ Live voltage, current, power, and energy readings
✅ Daily, weekly, and monthly energy tracking
✅ Mobile dashboard for energy visualization
✅ SMS alerts for daily and weekly usage
✅ Notification when energy consumption approaches 100 units
✅ Smart recommendations for saving electricity
✅ Cloud data storage and analytics

---

# 🧠 Problem Statement

Most households and small businesses rely on **traditional electricity meters**, which only show total consumption once per month.

This causes several problems:

* Users cannot monitor **daily electricity usage**
* Many users unknowingly **cross 100 electricity units**
* Electricity tariffs increase after crossing certain limits
* Lack of awareness leads to **high electricity bills**

For example, electricity rates may increase from **₹4.43/unit to ₹9.64/unit** after crossing a limit.

Without real-time monitoring, users cannot control their consumption effectively.

---

# 💡 Our Solution – WattWise

WattWise provides a **real-time smart energy monitoring system** using IoT technology.

The system:

* Measures electrical parameters using **energy monitoring sensors**
* Sends real-time data to a **cloud database**
* Displays live readings in a **mobile application**
* Calculates daily and weekly energy consumption
* Sends **SMS alerts** to notify users about their usage
* Provides **power-saving suggestions**

This helps users **reduce electricity bills and improve energy efficiency**.

---

# ⚙️ System Architecture

```
Energy Load
     │
     ▼
PZEM-004T Sensor
(Voltage, Current, Power)
     │
     ▼
ESP32 Microcontroller
     │
     ▼
WiFi Communication
     │
     ▼
Cloud Database (Supabase)
     │
     ▼
Backend API (PHP / REST API)
     │
     ▼
Flutter Mobile Application
     │
     ▼
Dashboard + SMS Alerts + Energy Reports
```

---

# 🔌 Hardware Components

* ESP32 Development Board
* PZEM-004T Energy Monitoring Sensor
* Single Phase Power Supply
* USB Cable
* Connecting Wires
* Breadboard / Prototype Board

---

# 💻 Software & Technologies Used

## Embedded Programming

* Arduino IDE
* ESP32 Programming

## Mobile Application

* Flutter
* FL Chart (for graphs and reports)

## Backend

* PHP (REST API)
* Supabase (Cloud Backend)
* MySQL Database

## Networking

* WiFi Communication
* HTTP / HTTPS Protocol
* REST API Integration

---

# 📊 Data Monitoring & Analysis

The system monitors key electrical parameters:

* Voltage (V)
* Current (A)
* Power (W)
* Energy Consumption (kWh)
* Power Factor (PF)

The collected data is used for:

* Daily energy calculation
* Weekly energy reports
* Power consumption analysis
* Smart recommendations

---

# 📱 Mobile Application Dashboard

The Flutter application provides:

### 🔴 Live Readings

* Voltage
* Current
* Power
* Power Factor
* Energy Usage

### 📊 Energy Reports

* Daily energy usage
* Weekly energy report
* Monthly consumption tracking

### 📉 Graphical Visualization

* Weekly energy graphs
* Power factor monitoring
* Consumption analysis charts

---

# 📩 SMS Alert System

The system sends automated alerts to users.

### Daily SMS Report

* Total units used per day
* Date and usage summary

Example:

```
Daily Usage Report
Total: 2.71 units
Date: 15 Feb
```

### Weekly SMS Report

* Total weekly units
* Monthly consumption
* Remaining units before 100 limit

Example:

```
Weekly Usage Report
This Week: 13.65 units
This Month: 54.17 units
Remaining: 45.83 / 100 units
```

---

# 🔬 Prototype Features

* Low power consumption (5V DC)
* Low-cost hardware components
* Built using open-source technologies
* Easy installation in existing electrical systems
* Scalable for multiple users or buildings
* Suitable for real-world deployment

---

# 🌍 Applications

🏠 Smart homes for electricity monitoring
🏢 Offices and commercial buildings
🏙 Smart city energy management systems
⚡ Electricity consumption awareness systems
💰 Reducing electricity bills for households

---

# 📈 Impact on Users

✔ Helps users monitor daily electricity usage
✔ Prevents crossing electricity unit limits
✔ Reduces electricity bills
✔ Encourages energy-saving habits
✔ Improves awareness about power consumption

---

# 👨‍💻 Team

**Team Name:** WattWise Solution

**Team Members:**

* Viraj Shinde
* Rutuja Phalle

---

# 🔮 Future Improvements

* AI-based electricity bill prediction
* Automatic load classification
* Smart appliance recommendations
* Integration with smart home systems
* Web dashboard for advanced analytics

---
