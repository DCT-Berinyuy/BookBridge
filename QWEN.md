# BookBridge Project - QWEN Context

## Project Overview

BookBridge is a Flutter application designed as an online classified marketplace that enables students to discover, buy, and sell used physical books within their locality. The project follows a feature-driven architecture with clean separation of concerns and uses Firebase as the backend for authentication and data storage.

## Architecture

The project follows a strict feature-driven architecture as defined in the ARCHITECTURE.md document:

### Core Entities
- **User**: Represents a student using BookBridge (owns listings)
- **Book**: Represents book metadata (system-owned, shared across listings)
- **Listing**: Represents a specific physical copy of a book offered for sale (core entity)
- **Location**: Represents a normalized locality (campus/town/area)

### Project Structure
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

## Technology Stack

- **Frontend**: Flutter with Dart
- **State Management**: Riverpod (with strict rules for provider types)
- **Routing**: GoRouter
- **Backend**: Firebase (Firestore for data, Firebase Authentication for user management)
- **Authentication**: Google Sign-In
- **Serialization**: `json_annotation` and `json_serializable`
- **Unique IDs**: `uuid` package

## Key Implementation Patterns

### State Management (Riverpod)
- **Provider**: For services and repositories
- **FutureProvider**: For one-time reads
- **StreamProvider**: For live Firestore streams
- **StateNotifierProvider**: For user-initiated actions
- All providers are feature-scoped, not global

### Data Layer Architecture
- **Domain Layer**: Contains immutable models with JSON serialization
- **Data Layer**: Contains services that interact with Firebase
- **Presentation Layer**: Contains UI widgets
- **State Layer**: Contains Riverpod providers that manage state

### Authentication Flow
- Uses Google Sign-In via `google_sign_in` package
- AuthGate widget manages authentication state
- All access requires authentication

## Building and Running

### Prerequisites
- Flutter SDK (version 3.10.1 or higher)
- Firebase project configured with Google Sign-In
- Android Studio/VS Code with Flutter plugin

### Setup Instructions
1. Clone the repository
2. Navigate to the flutter/book_bridge_app directory
3. Run `flutter pub get` to install dependencies
4. Configure Firebase for your platform (Android, iOS, Web) following the official Firebase documentation
5. Run the application with `flutter run`

### Development Commands
- `flutter pub get` - Install dependencies
- `flutter run` - Run the application
- `flutter test` - Run tests
- `dart run build_runner build` - Generate code for JSON serialization
- `dart run build_runner watch` - Watch for changes and generate code

## Development Conventions

### File Naming Rules
- `*_model.dart` - Data models
- `*_service.dart` - Data services
- `*_provider.dart` - Riverpod providers
- `*_screen.dart` - UI screens

### Architecture Rules
- Models are immutable
- Services handle data operations
- Providers manage state
- Widgets render UI
- No business logic in UI layer
- All Firebase access through services/providers, not directly from UI

### Security Rules
- All access requires authentication
- Users can only read/write their own documents
- Books are read-only for users
- Listings can only be created/updated by the seller
- Sold listings are immutable

## Project Directories

- `/flutter/book_bridge_app` - Main Flutter application
- `/firebase` - Firebase-related files (functions, rules)
- `/web` - Web application (Svelte/SvelteKit - separate project)
- `/ARCHITECTURE.md` - Main architectural specification (single source of truth)

## Important Notes

- The application currently has issues with Google Sign-In due to environment configuration problems
- The architecture document (ARCHITECTURE.md) is the single source of truth for the project
- All changes must follow the architecture rules and require approval if they deviate
- The project focuses on local book exchange only, with no plans for online payments, delivery, or chat systems