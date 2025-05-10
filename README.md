# 🗞️ News App

A Flutter-based mobile application that aggregates and displays news articles from various categories. Users can browse trending news, filter by category, search for specific topics, and save their favorite articles. Built using **Flutter**, **GetX**, **Node.js**, and **MongoDB Atlas**.

## 📱 Features

* ✅ View latest trending news
* ✅ Filter articles by category (e.g., Business, Sports, Technology)
* ✅ Search news by keywords
* ✅ View full news details
* ✅ Save articles to favorites (stored in MongoDB Atlas)
* ✅ View favorite articles offline
* ✅ Clean UI and smooth user experience
* ✅ Built with **GetX** for state management

---

## 🛠️ Tech Stack

### Frontend

* **Flutter** (Latest Stable Version)
* **Dart**
* **GetX** (State management, Navigation, Dependency Injection)

### Backend

* **Node.js** + **Express.js**
* **MongoDB Atlas** (for storing user-favorite articles)
* **News API** integration ([https://newsapi.org/](https://newsapi.org/))

---

## 🔧 Setup Instructions

### Prerequisites

* Flutter SDK
* Node.js + npm
* MongoDB Atlas account
* News API Key

## 📸 Video

| Video                          |
| ----------------------------- |
| ![Video](https://github.com/ShivanshSrivastava136/News-App/blob/main/User_Video/news%20app.mp4) |
---

## Project Structure

```
news_app/
├── android/                 # Android platform-specific files
├── assets/                  # Static assets (images, fonts, etc.)
├── build/                   # Build output directory
├── ios/                     # iOS platform-specific files
├── lib/                     # Dart source code
│   ├── controllers/         # GetX controllers
│   │   ├── favorites_controller.dart
│   │   └── news_controller.dart
│   ├── models/              # Data models
│   │   └── article_model.dart
│   ├── services/            # API and other services
│   │   ├── api_service.dart
│   │   └── local_storage_service.dart
│   ├── views/               # UI screens
│   │   ├── favorites_view.dart
│   │   ├── home_view.dart
│   │   └── news_detail_view.dart
│   ├── widgets/             # Reusable UI components
│   │   ├── article_card.dart
│   │   └── category_selector.dart
│   └── main.dart            # Application entry point
├── linux/                   # Linux platform-specific files
├── macos/                   # macOS platform-specific files
├── news-app-backend/        # Backend code for the application
├── test/                    # Test files
├── web/                     # Web platform-specific files
├── windows/                 # Windows platform-specific files
├── User_Video/              # User video assets or demos
├── pubspec.yaml             # Flutter dependencies and configurations
├── pubspec.lock             # Generated lock file for dependencies
└── README.md                # Project documentation
```

## 💡 Highlights

* Clean architecture & modular codebase
* Optimized API handling using GetX
* Persistent storage with MongoDB Atlas
* Responsive and intuitive UI

---
