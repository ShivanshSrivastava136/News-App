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

| Home                          | Category Filter                       | Search                            |
| ----------------------------- | ------------------------------------- | --------------------------------- |
| ![Home](screenshots/home.png) | ![Category](screenshots/category.png) | ![Search](screenshots/search.png) |

---

## 📁 Folder Structure (Frontend)

```
lib/
├── controllers/
├── models/
├── services/
├── views/
├── bindings/
└── main.dart
```

---

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
