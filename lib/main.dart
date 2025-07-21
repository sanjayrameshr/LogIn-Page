import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Only if you're using Firebase
import 'screens/login_screen.dart'; // Rename file to lowercase: login_screen.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (skip this line if you're not using Firebase)
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Optional key for best practice

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(), // Your main login screen
    );
  }
}
