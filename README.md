# BookBridge

A Flutter application for students to discover, buy, and sell used physical books within their locality.

![BookBridge App Icon](App_Icon.png)

## 📋 Project Overview

BookBridge is an online classified marketplace that enables students to discover, buy, and sell used physical books within their locality. The app follows a feature-driven architecture with clean separation of concerns and uses Firebase as the backend for authentication and data storage.

## 📷 Screenshots

![BookBridge Screenshot](Screenshot.png)

## ✨ Features

- Google Sign-In authentication
- Browse available book listings
- View detailed book information
- Create new book listings
- Manage your own listings
- User profile management
- Location-based book discovery

## 🛠️ Tech Stack

- **Frontend**: Flutter with Dart
- **State Management**: Riverpod
- **Routing**: GoRouter
- **Backend**: Firebase (Firestore for data, Firebase Authentication)
- **Authentication**: Google Sign-In
- **Serialization**: json_annotation and json_serializable

## 🏗️ Architecture

The project follows a feature-driven architecture:

```
lib/
├── app/                  // Core application setup (router, theme)
├── core/                 // Core utilities, constants, errors
├── features/             // Feature-specific code (auth, listings, books, users, locations)
│   ├── auth/
│   │   ├── data/
│   │   ├── presentation/
│   │   └── state/
│   ├── books/
│   │   ├── data/
│   │   └── domain/
│   ├── listings/
│   │   ├── data/
│   │   ├── domain/
│   │   ├── presentation/
│   │   └── state/
│   ├── users/
│   │   ├── data/
│   │   └── domain/
│   └── locations/
│       ├── data/
│       └── domain/
└── shared/               // Shared widgets and services
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (version 3.10.1 or higher)
- Firebase project configured with Google Sign-In
- Android Studio/VS Code with Flutter plugin

### Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/DCT-Berinyuy/BookBridge.git
   ```

2. Navigate to the project directory:
   ```bash
   cd BookBridge/flutter/book_bridge_app
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Configure Firebase for your platform (Android, iOS, Web) following the official Firebase documentation

5. To set up custom app icons:
   - Place your App_Icon.png (at least 1024x1024 pixels) in the project root
   - Add flutter_launcher_icons to dev_dependencies in pubspec.yaml
   - Run `dart run flutter_launcher_icons:main` to generate the icons

6. Run the application:
   ```bash
   flutter run
   ```

## 📁 Project Structure

- `/flutter/book_bridge_app` - Main Flutter application
- `/firebase` - Firebase-related files (functions, rules)
- `/web` - Web application (Svelte/SvelteKit - separate project)
- `/ARCHITECTURE.md` - Main architectural specification

## 🤝 Contributing

Contributions are welcome! Please read the [ARCHITECTURE.md](ARCHITECTURE.md) file to understand the project structure and architectural constraints before making any changes.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🚀 Releases

Check out the [releases page](https://github.com/DCT-Berinyuy/BookBridge/releases) to download the latest APK for Android devices.

## 🎯 Project Goals

- Enable students to buy and sell used books nearby
- Provide a simple, intuitive marketplace experience
- Focus on local book exchange only
- Maintain clean, maintainable codebase

## 🚫 Non-Goals

- Online payments
- Delivery / logistics
- Reviews & ratings
- In-app chat systems
- Digital books (PDFs)
- Global marketplace