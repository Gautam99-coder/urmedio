// lib/services/firebase_auth_methods.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // --- GET CURRENT USER ---
  User? get currentUser => _auth.currentUser;

  // --- AUTH STATE STREAM ---
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // --- SIGN UP WITH EMAIL (Customer) ---
  Future<void> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    // 1. Create user in Auth
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;

    if (user != null) {
      // 2. Save user details to Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'role': 'customer', // <-- Set role for customer
        'uid': user.uid,
      });
    }
  }

  // --- SIGN UP WITH EMAIL (Pharmacy) ---
  Future<void> signUpWithPharmacyEmail({
    required String pharmacyId,
    required String pharmacyName,
    required String email,
    required String password,
  }) async {
    // 1. Create user in Auth
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;

    if (user != null) {
      // 2. Save pharmacy details to Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'pharmacyName': pharmacyName,
        'pharmacyId': pharmacyId,
        'email': email,
        'role': 'pharmacy', // <-- Set role for pharmacy
        'uid': user.uid,
      });
    }
  }

  // --- SIGN IN WITH EMAIL ---
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // --- GET REDIRECT ROUTE (The new logic) ---
  // This checks the user's 'role' in Firestore to decide where to go
  Future<String> getRedirectRoute() async {
    if (currentUser == null) {
      return '/signin'; // Should not happen if called after login, but safe
    }

    try {
      final doc = await _firestore.collection('users').doc(currentUser!.uid).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        final role = data['role'] as String?;

        if (role == 'pharmacy') {
          return '/phomePage'; // Go to Pharmacy Home
        } else {
          return '/homePage'; // Go to Customer Home
        }
      }
      // Default to customer home if role is missing
      return '/homePage';
    } catch (e) {
      // Handle error, default to customer home
      print("Error getting user role: $e");
      return '/homePage';
    }
  }

  // --- SIGN OUT ---
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
