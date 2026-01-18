# 📝 Task Manager App (Flutter)

A simple and modern **Task Management application** built using **Flutter** and **Riverpod**, with **Firebase Authentication**, **Cloud Firestore**, and **local session management** using `SharedPreferences`.

This app allows users to manage daily tasks efficiently with authentication, task CRUD operations, and persistent login sessions.

---

## ✨ Features

- 🔐 User Authentication (Firebase Email/Password)
- 📋 Create, Read, Update & Delete Tasks
- ✅ Mark tasks as Complete / Incomplete
- 📅 Due Date selection
- ⭐ Priority levels (Low / Medium / High)
- 🔄 Persistent Login Session
- 🚪 Secure Logout
- 📱 Clean & Responsive UI
- ⚡ Riverpod State Management

---

## 🛠️ Tech Stack

- **Flutter** (Dart)
- **Riverpod** – State Management
- **Firebase Authentication**
- **Cloud Firestore**
- **SharedPreferences** – Session Handling
- **Material UI**

---

## 📂 Project Structure

lib/<br>
├── controllers/ # Business logic & session handling<br>
├── services/ # Firebase & auth services<br>
├── views/ # UI screens<br>
├── providers/ # Riverpod providers<br>
├── models/ # Data models<br>
└── main.dart # App entry point<br>
assets/<br>
└── splash_screen.png<br>

---

## 🚀 Getting Started

### Clone the repository
```
https://github.com/Smiteshbhore21/Task.git
cd task_manager
```

### Install dependencies
flutter pub get

### Firebase Setup
Create a Firebase project

Enable Email/Password Authentication

Add Android app to Firebase

Download google-services.json

Place it in:
android/app/

### Run the app
```flutter run```

### Authentication Flow
Splash Screen checks login status using SharedPreferences
Logged-in users → Task List Screen
Logged-out users → Login / Register Screen
Logout clears Firebase session + local session

### Dependencies Used
flutter_riverpod
firebase_core
firebase_auth
cloud_firestore
shared_preferences
flutter_slidable
table_calendar
intl
flutter_svg

### Screenshot
<img src="https://github.com/user-attachments/assets/62d1d40d-bb91-46de-bb25-834715de4a1b" width="300"/>
<img src="https://github.com/user-attachments/assets/0de9369b-d54a-4afd-8efc-6b87ecf434f5" width="300"/>
<img src="https://github.com/user-attachments/assets/e21a2b8f-7268-4b67-ae90-a5ae20d01fdf" width="300"/>
<img src="https://github.com/user-attachments/assets/4d3b4f14-c798-4b1f-8756-d358ff6704de" width="300"/>
<img src="https://github.com/user-attachments/assets/0bf43fd1-3800-4f85-8c63-a1e03f9373a9" width="300"/>
<img src="https://github.com/user-attachments/assets/1f6a8585-064c-4622-9ba5-b51e9ae91c22" width="300"/>
<img src="https://github.com/user-attachments/assets/7ef8b692-38cf-4c63-903c-d29cd2f807fd" width="300"/>
<img src="https://github.com/user-attachments/assets/f4df54ee-6863-44b1-ac33-72c3c9159398" width="300"/>
