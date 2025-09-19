import 'package:flutter/material.dart';
import 'package:urmedio/screens/home/home_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding1.dart';
import 'screens/onboarding2.dart';
import 'screens/signup_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/pharmacy_signup.dart';

void main() {
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
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding1': (context) => const Onboarding1(),
        '/onboarding2': (context) => const Onboarding2(),
        '/signup': (context) => const SignupScreen(),
        '/signin': (context) => const SigninScreen(),
        '/pharmacySignup': (context) => const PharmacySignup(),
        '/homePage':(context)=> const PharmacyApp(),
      },
    );
  }
}
