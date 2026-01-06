# BookBridge Application - Gemini Agent Details

## Application Overview

BookBridge is a Flutter application designed as an online classified marketplace for students to buy and sell used physical books within their locality. The primary goal is to facilitate local book exchange among students, focusing on simplicity and ease of use.

## Purpose

The main purpose of this application is to provide a platform for students to:
- Discover used physical books available for sale in their local area.
- Easily create listings to sell their used books.
- Connect with other students for transactions.

## Implementation Details

The application is built using Flutter and Dart, following a feature-driven architecture.

### Key Technologies:
- **Frontend:** Flutter with Dart
- **State Management:** Riverpod
- **Routing:** GoRouter
- **Backend (Firebase):** Firestore for data storage, Firebase Authentication for user management.
- **Serialization:** `json_annotation` and `json_serializable` for model serialization/deserialization.
- **Unique IDs:** `uuid` package for generating unique identifiers.

### Architecture Highlights:
- **Separation of Concerns:** The application adheres to a feature-driven architecture, organizing code by feature (e.g., `auth`, `listings`) with clear separation of data, domain, and presentation layers.
- **Immutable Models:** Data models are designed to be immutable, promoting predictable state management.
- **Provider-based State Management:** Riverpod is used for managing application state, offering compile-time safety and granular control.
- **Firebase as Backend:** Leverages Firebase for a scalable and robust backend, handling data persistence and user authentication securely.

## File Layout

The project structure is organized to promote modularity and maintainability:

```
bookbridge/
├── ARCHITECTURE.md       // The main architectural specification
├── firebase/             // Firebase-related files (e.g., functions, rules)
├── flutter/              // The Flutter application
│   ├── book_bridge_app/  // The main Flutter project directory
│   │   ├── lib/          // Dart source files
│   │   │   ├── app/      // Core application setup (main App widget, router, theme)
│   │   │   ├── features/ // Feature-specific modules
│   │   │   │   ├── auth/
│   │   │   │   │   ├── data/          // Authentication service
│   │   │   │   │   ├── presentation/  // Authentication UI (AuthGate, SignInScreen, HomeScreen)
│   │   │   │   │   └── state/         // Riverpod providers for authentication
│   │   │   │   ├── books/
│   │   │   │   │   ├── data/          // Book service
│   │   │   │   │   └── domain/        // Book model
│   │   │   │   ├── listings/
│   │   │   │   │   ├── data/          // Listing service
│   │   │   │   │   ├── domain/        // Listing model
│   │   │   │   │   ├── presentation/  // Listing UI (ListingsScreen, ListingDetailScreen, CreateListingScreen)
│   │   │   │   │   └── state/         // Riverpod providers for listings
│   │   │   │   ├── users/
│   │   │   │   │   ├── data/          // User service
│   │   │   │   │   └── domain/        // User model
│   │   │   │   └── locations/
│   │   │   │       ├── data/          // Location service
│   │   │   │       └── domain/        // Location model
│   │   │   └── main.dart // Entry point for the Flutter application
│   │   ├── pubspec.yaml  // Project dependencies and metadata
│   │   ├── README.md     // Project documentation
│   │   └── test/         // Unit and widget tests
│   │       └── features/ // Feature-specific tests
│   │           ├── auth/
│   │           │   └── data/ // AuthService tests
│   │           ├── books/
│   │           │   └── domain/ // BookModel tests
│   │           ├── listings/
│   │           │   └── domain/ // ListingModel tests
│   │           ├── locations/
│   │           │   └── domain/ // LocationModel tests
│   │           └── users/
│   │               ├── data/ // UserService tests
│   │               └── domain/ // UserModel tests
│   └── IMPLEMENTATION.md // Detailed implementation plan and journal
├── web/                  // Web application (Svelte/SvelteKit - separate project)
└── .gitignore            // Git ignore file
```
