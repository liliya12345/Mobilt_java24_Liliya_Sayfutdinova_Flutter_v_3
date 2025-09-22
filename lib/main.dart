import 'package:flutter/material.dart';
import 'package:weather_app/pages/app.dart';
import 'package:firebase_core/firebase_core.dart';
const firebaseConfig = {
  "apiKey": "AIzaSyDN6mpz-Eo1z-VTSGDyERfaskzEQFvfNb8",
  "authDomain": "schema-23b69.firebaseapp.com",
  "databaseURL": "https://schema-23b69-default-rtdb.europe-west1.firebasedatabase.app",
  "projectId": "schema-23b69",
  "storageBucket": "schema-23b69.firebasestorage.app",
  "messagingSenderId": "157010188500",
  "appId": "1:157010188500:web:d1f6d78a16ed5624c20341"
};

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: firebaseConfig['apiKey']!,
        appId: firebaseConfig['appId']!,
        messagingSenderId: firebaseConfig['messagingSenderId']!,
        projectId: firebaseConfig['projectId']!,
        authDomain: firebaseConfig['authDomain']!,
        databaseURL: firebaseConfig['databaseURL']!,
        storageBucket: firebaseConfig['storageBucket']!,
      ),
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization error: $e');
  }


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherApp(),
    );
  }
}