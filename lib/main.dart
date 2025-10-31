import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:urmedio/app_routes.dart'; // Your routes file
import 'package:urmedio/services/firebase_auth_methods.dart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Add your Firebase options here if needed
    // options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        // ✅ 2. FIXED CLASS NAME: Use 'AuthService'
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        StreamProvider<User?>(
          // ✅ 3. FIXED CLASS NAME and STREAM NAME
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: const UrMedioApp(),
    ),
  );
}

class UrMedioApp extends StatelessWidget {
  const UrMedioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UrMedio',
      theme: ThemeData(primarySwatch: Colors.blue),
      // Use your defined routes
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}