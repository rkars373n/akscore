import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final Logger _logger = Logger();

  // Get current user
  static User? get currentUser => _auth.currentUser;

  // Check if user is signed in
  static bool get isSignedIn => _auth.currentUser != null;

  // Auth state changes stream
  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  static Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      _logger.i('Attempting to sign in with email: $email');

      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _logger.i('Successfully signed in user: ${result.user?.uid}');
      return result;
    } on FirebaseAuthException catch (e) {
      _logger.e('Sign in failed: ${e.message}');
      rethrow;
    } catch (e) {
      _logger.e('Unexpected error during sign in: $e');
      rethrow;
    }
  }

  // Create account with email and password
  static Future<UserCredential?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      _logger.i('Attempting to create account with email: $email');

      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name if provided
      if (displayName != null && result.user != null) {
        await result.user!.updateDisplayName(displayName);
      }

      // Create user document in Firestore
      await _createUserDocument(result.user!);

      _logger.i('Successfully created user: ${result.user?.uid}');
      return result;
    } on FirebaseAuthException catch (e) {
      _logger.e('Account creation failed: ${e.message}');
      rethrow;
    } catch (e) {
      _logger.e('Unexpected error during account creation: $e');
      rethrow;
    }
  }

  // Sign out
  static Future<void> signOut() async {
    try {
      _logger.i('Signing out user');
      await _auth.signOut();
      _logger.i('Successfully signed out');
    } catch (e) {
      _logger.e('Error during sign out: $e');
      rethrow;
    }
  }

  // Reset password
  static Future<void> resetPassword(String email) async {
    try {
      _logger.i('Sending password reset email to: $email');
      await _auth.sendPasswordResetEmail(email: email);
      _logger.i('Password reset email sent successfully');
    } on FirebaseAuthException catch (e) {
      _logger.e('Password reset failed: ${e.message}');
      rethrow;
    } catch (e) {
      _logger.e('Unexpected error during password reset: $e');
      rethrow;
    }
  }

  // Update user profile
  static Future<void> updateUserProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('No user signed in');
      }

      _logger.i('Updating user profile for: ${user.uid}');

      await user.updateDisplayName(displayName);
      if (photoURL != null) {
        await user.updatePhotoURL(photoURL);
      }

      _logger.i('User profile updated successfully');
    } catch (e) {
      _logger.e('Error updating user profile: $e');
      rethrow;
    }
  }

  // Create user document in Firestore
  static Future<void> _createUserDocument(User user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName ?? '',
        'photoURL': user.photoURL ?? '',
        'createdAt': FieldValue.serverTimestamp(),
        'lastLoginAt': FieldValue.serverTimestamp(),
        'favoriteMatches': [],
        'favoriteTeams': [],
        'favoritePlayers': [],
      });

      _logger.i('User document created in Firestore for: ${user.uid}');
    } catch (e) {
      _logger.e('Error creating user document: $e');
      // Don't rethrow - this shouldn't block user creation
    }
  }

  // Get user data from Firestore
  static Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc.data();
      }
      return null;
    } catch (e) {
      _logger.e('Error getting user data: $e');
      return null;
    }
  }

  // Update user data in Firestore
  static Future<void> updateUserData(
    String uid,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        ...data,
        'lastUpdatedAt': FieldValue.serverTimestamp(),
      });
      _logger.i('User data updated for: $uid');
    } catch (e) {
      _logger.e('Error updating user data: $e');
      rethrow;
    }
  }

  // Delete user account
  static Future<void> deleteUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('No user signed in');
      }

      _logger.i('Deleting user account: ${user.uid}');

      // Delete user document from Firestore
      await _firestore.collection('users').doc(user.uid).delete();

      // Delete user account
      await user.delete();

      _logger.i('User account deleted successfully');
    } catch (e) {
      _logger.e('Error deleting user account: $e');
      rethrow;
    }
  }
}
