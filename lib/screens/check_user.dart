// lib/screens/check_user.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_auth_methods.dart.dart';
import 'auth/signin_screen.dart';

class CheckUser extends StatelessWidget {
  const CheckUser({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        // Show loading spinner
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If user is logged in
        if (snapshot.hasData) {
          // Use a FutureBuilder to figure out *where* to redirect
          return FutureBuilder<String>(
            future: AuthService().getRedirectRoute(),
            builder: (context, routeSnapshot) {
              if (routeSnapshot.connectionState == ConnectionState.done) {
                // We have the route, now navigate.
                // We use addPostFrameCallback to navigate *after* the build
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacementNamed(context, routeSnapshot.data!);
                });
                // Return a loading indicator while navigation happens
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              // While waiting for the route, show loading
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            },
          );
        }

        // If user is not logged in
        return const SigninScreen();
      },
    );
  }
}