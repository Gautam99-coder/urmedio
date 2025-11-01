import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SimpleGoogleAuth {
  static Future<User?> signInWithGoogle() async {
    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      if (kIsWeb) {
        // Web: Use signInWithPopup
        UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(googleProvider);
        return userCredential.user;
      } else {
        // Mobile: Direct authentication
        UserCredential userCredential = await FirebaseAuth.instance.signInWithProvider(googleProvider);
        return userCredential.user;
      }
    } catch (e) {
      print("Simple Google Sign-In error: $e");
      return null;
    }
  }
}