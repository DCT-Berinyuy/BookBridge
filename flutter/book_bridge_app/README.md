# BookBridge App

An online classified marketplace that enables students to discover, buy, and sell used physical books within their locality.

## Features

- User authentication (Google Sign-In - **currently blocked due to environment issues**)
- Displaying a list of book listings
- Viewing details of a single listing
- Creating new listings

## Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/BookBridge.git
    cd BookBridge/flutter/book_bridge_app
    ```

2.  **Get dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Firebase Setup:**
    This project uses Firebase. You need to set up a Firebase project and configure it for your Flutter app (Android, iOS, Web). Follow the official Firebase documentation for Flutter: [https://firebase.flutter.dev/](https://firebase.flutter.dev/)

    **Important:** Due to ongoing issues with `google_sign_in` package recognition by the Dart analyzer, the authentication flow is currently blocked. Please ensure your Flutter SDK and environment variables are correctly configured.

## Usage

To run the application:

```bash
flutter run
```

(Note: Application launch is currently blocked due to a `flutter` executable path issue.)

## Project Structure

The project follows a feature-driven architecture as outlined in `ARCHITECTURE.md`.

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

## Contributing

Contributions are welcome! Please follow the existing code style and guidelines.

## License

This project is licensed under the [MIT License](LICENSE).
