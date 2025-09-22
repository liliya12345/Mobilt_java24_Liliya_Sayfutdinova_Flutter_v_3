// lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyDN6mpz-Eo1z-VTSGDyERfaskzEQFvfNb8",
    authDomain: "schema-23b69.firebaseapp.com",
    databaseURL: "https://schema-23b69-default-rtdb.europe-west1.firebasedatabase.app",
    projectId: "schema-23b69",
    storageBucket: "schema-23b69.firebasestorage.app",
    messagingSenderId: "157010188500",
    appId: "1:157010188500:web:d1f6d78a16ed5624c20341",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyDN6mpz-Eo1z-VTSGDyERfaskzEQFvfNb8",
    appId: "1:157010188500:android:your_android_app_id",
    messagingSenderId: "157010188500",
    projectId: "schema-23b69",
    databaseURL: "https://schema-23b69-default-rtdb.europe-west1.firebasedatabase.app",
    storageBucket: "schema-23b69.firebasestorage.app",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyDN6mpz-Eo1z-VTSGDyERfaskzEQFvfNb8",
    appId: "1:157010188500:ios:your_ios_app_id",
    messagingSenderId: "157010188500",
    projectId: "schema-23b69",
    databaseURL: "https://schema-23b69-default-rtdb.europe-west1.firebasedatabase.app",
    storageBucket: "schema-23b69.firebasestorage.app",
    iosBundleId: "com.example.weatherApp",
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "AIzaSyDN6mpz-Eo1z-VTSGDyERfaskzEQFvfNb8",
    appId: "1:157010188500:ios:your_ios_app_id",
    messagingSenderId: "157010188500",
    projectId: "schema-23b69",
    databaseURL: "https://schema-23b69-default-rtdb.europe-west1.firebasedatabase.app",
    storageBucket: "schema-23b69.firebasestorage.app",
    iosBundleId: "com.example.weatherApp",
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: "AIzaSyDN6mpz-Eo1z-VTSGDyERfaskzEQFvfNb8",
    appId: "1:157010188500:web:your_windows_app_id",
    messagingSenderId: "157010188500",
    projectId: "schema-23b69",
    databaseURL: "https://schema-23b69-default-rtdb.europe-west1.firebasedatabase.app",
    storageBucket: "schema-23b69.firebasestorage.app",
  );
}