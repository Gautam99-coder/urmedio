import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// ✅ Move this class OUTSIDE of FirebaseAuthMethods
class GoogleSignupData {
  final String email;
  final String name;
  final String? photoUrl;

  GoogleSignupData({
    required this.email,
    required this.name,
    this.photoUrl,
  });
}

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseAuthMethods(this._auth);

  // GET USER
  User? get currentUser => _auth.currentUser;

  // STATE PERSISTENCE STREAM
  Stream<User?> get authState => _auth.authStateChanges();

  // --- EMAIL/PASSWORD SIGN UP (CUSTOMER) ---
  Future<UserCredential> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await userCredential.user?.updateDisplayName(name.trim());

      // Create user document in Firestore
      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'name': name.trim(),
          'email': email.trim(),
          'photoURL': userCredential.user!.photoURL ?? '',
          'provider': 'email',
          'createdAt': FieldValue.serverTimestamp(),
          'userType': 'customer', // ✅ Set userType
        });
      }
      return userCredential;
    } on FirebaseAuthException {
      rethrow; // Let the UI handle the error
    }
  }

  // --- EMAIL/PASSWORD SIGN UP (PHARMACY) ---
  Future<UserCredential> signUpWithPharmacyEmail({
    required String pharmacyId,
    required String pharmacyName,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await userCredential.user?.updateDisplayName(pharmacyName.trim());

      // Create user document in Firestore
      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'name': pharmacyName.trim(),
          'email': email.trim(),
          'pharmacyId': pharmacyId.trim(),
          'photoURL': '',
          'provider': 'email',
          'createdAt': FieldValue.serverTimestamp(),
          'userType': 'pharmacy', // ✅ Set userType
        });
      }
      return userCredential;
    } on FirebaseAuthException {
      rethrow; // Let the UI handle the error
    }
  }

  // --- EMAIL/PASSWORD SIGN IN ---
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential;
    } on FirebaseAuthException {
      rethrow; // Let the UI handle the error
    }
  }

  // --- 🚀 GOOGLE SIGN IN (UPDATED LOGIC) 🚀 ---
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // 1. Force the account selector pop-up every time
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in process
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 2. Attempt to sign in/register with the credential
      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      // 3. Create or check Firestore user document
      if (user != null) {
        final docRef = _firestore.collection('users').doc(user.uid);
        final docSnap = await docRef.get();

        if (!docSnap.exists) {
          // **NEW ACCOUNT/EMAIL** -> Create user document
          await docRef.set({
            'uid': user.uid,
            'name': user.displayName ?? '',
            'email': user.email ?? '',
            'photoURL': user.photoURL ?? '',
            'provider': 'google',
            'createdAt': FieldValue.serverTimestamp(),
            'userType': 'customer', // ✅ Default new Google users to customer
          });
        }
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw FirebaseAuthException(
          code: 'account-exists-with-different-credential',
          message:
              'This email is already linked to another sign-in method. Please use that method or link accounts.',
        );
      }
      rethrow;
    } catch (e) {
      print("Google Sign-In General Error: $e");
      rethrow;
    }
  }

  // --- REDIRECT LOGIC ---
  Future<String> getRedirectRoute() async {
    if (currentUser == null) {
      return '/signup';
    }

    try {
      final doc =
          await _firestore.collection('users').doc(currentUser!.uid).get();

      String userType = 'customer';
      if (doc.exists && doc.data() != null) {
        userType = doc.data()!['userType'] ?? 'customer';
      }

      if (userType == 'pharmacy') {
        return '/pharmacyHome';
      } else {
      return '/home';
      }

    } catch (e) {
      return '/homePage';
    }
  }

  // --- ⭐️ PASSWORD RESET ⭐️ ---
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException {
      rethrow;
    }
  }

  // --- SIGN OUT ---
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
