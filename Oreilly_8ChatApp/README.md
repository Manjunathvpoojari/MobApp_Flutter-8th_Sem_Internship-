# 💬 FlutterChat — Real-Time Chat App

A real-time chat application built with **Flutter** and **Firebase**, developed as part of the 8th Semester Internship project.

---

## 📱 Screenshots

> Auth Screen → Chat Screen → Message Bubbles

---

## 🚀 Features

- 🔐 Email & Password Authentication (Firebase Auth)
- 💬 Real-time messaging (Cloud Firestore)
- 👤 Auto-generated user avatars (ui-avatars.com)
- 🔔 Push notifications (Firebase Cloud Messaging)
- 🌊 Stream-based live updates
- 📱 Android & iOS support

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Frontend | Flutter (Dart) |
| Authentication | Firebase Auth |
| Database | Cloud Firestore |
| Notifications | Firebase Cloud Messaging |
| Avatar Service | ui-avatars.com |

---

## 📁 Project Structure

```
lib/
├── main.dart                   # App entry point, Firebase init
├── firebase_options.dart       # FlutterFire generated config
├── screens/
│   ├── auth.dart               # Login & Signup screen
│   ├── chat.dart               # Main chat screen
│   └── splash.dart             # Loading screen
└── widgets/
    ├── chat_messages.dart      # Firestore stream message list
    ├── message_bubble.dart     # Individual message UI
    └── new_message.dart        # Message input bar
```

---

## ⚙️ Firebase Setup Required

### 1. Authentication
- Enable **Email/Password** provider in Firebase Console → Authentication

### 2. Cloud Firestore
- Create a Firestore database (region: `asia-south1` recommended for India)
- Set the following **Security Rules**:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{uid} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == uid;
    }
    match /chat/{message} {
      allow read, write: if request.auth != null;
    }
  }
}
```

### 3. Firebase Cloud Messaging
- Enable in **Project Settings → Cloud Messaging**

---

## 🔧 How to Run

### Prerequisites
- Flutter SDK installed
- Android Studio / VS Code
- Firebase project created

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/manjunathvpoojari/MobApp_Flutter-8th_Sem_Internship-.git

# 2. Navigate to project folder
cd Oreilly_8ChatApp

# 3. Install dependencies
flutter pub get

# 4. Add your chat image asset
# Place chat.png inside assets/images/

# 5. Run the app
flutter run
```

---

## 📦 Dependencies

```yaml
firebase_core: ^4.6.0
firebase_auth: ^6.3.0
cloud_firestore: ^6.2.0
firebase_messaging: ^16.1.3
cupertino_icons: ^1.0.8
```

---

## 🗂️ Firestore Data Structure

### `users` collection
```
users/
  {uid}/
    username: "John"
    email: "john@example.com"
    image_url: "https://ui-avatars.com/api/?name=John"
```

### `chat` collection
```
chat/
  {messageId}/
    text: "Hello!"
    createdAt: Timestamp
    userId: "uid123"
    username: "John"
    userImage: "https://ui-avatars.com/..."
```

---

## 🔔 Push Notifications

The app subscribes all users to the `chat` topic via FCM. A Cloud Function (`functions/index.js`) triggers on every new message and sends a notification to all subscribers.

> Note: Deploying Cloud Functions requires Firebase Blaze plan.

---

## ⚠️ Known Limitations

- No image upload (Firebase Storage requires Blaze plan)
- Avatars are auto-generated from username using ui-avatars.com
- Cloud Functions not deployed (notifications work only on physical devices with FCM)

---

## 👨‍💻 Developer

**Manjunath V Poojari**  
8th Semester — Mobile Application Development  
GitHub: [@manjunathvpoojari](https://github.com/manjunathvpoojari)  
Portfolio: [manjunathvpoojari.github.io/Portfolio](https://manjunathvpoojari.github.io/Portfolio/)

---

## 📄 License

This project is for educational purposes as part of internship coursework.