# 🗞️ News Aggregator App

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

### Frontend (Flutter)

```bash
git clone https://github.com/your-username/news-aggregator-app.git
cd news-aggregator-app/flutter
flutter pub get
flutter run
```

### Backend (Node.js + Express)

```bash
cd news-aggregator-app/backend
npm install
# Create a .env file with your credentials
node index.js
```

`.env` file example:

```env
PORT=3000
MONGO_URI=mongodb+srv://<username>:<password>@cluster0.mongodb.net/newsapp?retryWrites=true&w=majority
NEWS_API_KEY=your_newsapi_key
```

---

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

## ⚙️ API Endpoints

**Base URL**: `http://<your-server-ip>:3000`

* `GET /news/trending` – Fetch trending news
* `GET /news/category/:category` – News by category
* `GET /news/search?q=keyword` – Search articles
* `POST /favorites` – Save article to favorites
* `GET /favorites/:userId` – Get user's favorites

---

## 💡 Highlights

* Clean architecture & modular codebase
* Optimized API handling using GetX
* Persistent storage with MongoDB Atlas
* Responsive and intuitive UI

---

## 📦 Submission

* ✅ [APK File Link](#) *(attach your actual link here)*
* ✅ [GitHub Repository](https://github.com/your-username/news-aggregator-app)

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Would you like a badge section or demo video link added to the README as well?
