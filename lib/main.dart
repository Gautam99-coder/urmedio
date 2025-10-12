import 'package:flutter/material.dart';
import 'package:urmedio/app_routes.dart'; // Import the new route generator
import 'package:firebase_core/firebase_core.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase.InitializeApp();
  runApp(const UrMedioApp());
}

class UrMedioApp extends StatelessWidget {
  const UrMedioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UrMedio',
      theme: ThemeData(primarySwatch: Colors.blue),
      // Set the initial route using the constant from AppRoutes
      initialRoute: AppRoutes.splash,
      // Use the onGenerateRoute callback to handle all navigation
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}