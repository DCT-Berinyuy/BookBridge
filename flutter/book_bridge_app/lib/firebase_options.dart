import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCv63ktbWbHJvc67YgkMWTpoWjNQ9P04l4',
    appId: '1:123456789012:web:1234567890abcdef012345',
    messagingSenderId: '123456789012',
    projectId: 'book-bridge-12345',
    authDomain: 'book-bridge-12345.firebaseapp.com',
    storageBucket: 'book-bridge-12345.appspot.com',
    measurementId: 'G-XXXXXXXXXX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCv63ktbWbHJvc67YgkMWTpoWjNQ9P04l4',
    appId: '1:123456789012:android:1234567890abcdef012345',
    messagingSenderId: '123456789012',
    projectId: 'book-bridge-12345',
    storageBucket: 'book-bridge-12345.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCv63ktbWbHJvc67YgkMWTpoWjNQ9P04l4',
    appId: '1:123456789012:ios:1234567890abcdef012345',
    messagingSenderId: '123456789012',
    projectId: 'book-bridge-12345',
    storageBucket: 'book-bridge-12345.appspot.com',
    iosClientId:
        '123456789012-abc123def456ghi789jkl012mno345pqr.apps.googleusercontent.com',
    iosBundleId: 'com.example.bookBridge',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCv63ktbWbHJvc67YgkMWTpoWjNQ9P04l4',
    appId: '1:123456789012:ios:1234567890abcdef012345',
    messagingSenderId: '123456789012',
    projectId: 'book-bridge-12345',
    storageBucket: 'book-bridge-12345.appspot.com',
    iosClientId:
        '123456789012-abc123def456ghi789jkl012mno345pqr.apps.googleusercontent.com',
    iosBundleId: 'com.example.bookBridge',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCv63ktbWbHJvc67YgkMWTpoWjNQ9P04l4',
    appId: '1:123456789012:web:1234567890abcdef012345',
    messagingSenderId: '123456789012',
    projectId: 'book-bridge-12345',
    authDomain: 'book-bridge-12345.firebaseapp.com',
    storageBucket: 'book-bridge-12345.appspot.com',
    measurementId: 'G-XXXXXXXXXX',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'AIzaSyCv63ktbWbHJvc67YgkMWTpoWjNQ9P04l4',
    appId: '1:123456789012:web:1234567890abcdef012345',
    messagingSenderId: '123456789012',
    projectId: 'book-bridge-12345',
    authDomain: 'book-bridge-12345.firebaseapp.com',
    storageBucket: 'book-bridge-12345.appspot.com',
    measurementId: 'G-XXXXXXXXXX',
  );
}
