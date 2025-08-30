import 'package:antelope/features/auth/domain/entities/app_user.dart';
import 'package:antelope/features/auth/domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
        UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

        AppUser user = AppUser(
          uid: userCredential.user!.uid,
          email: email,
        );
        return user;
    }
    catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword(String name, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
      );
      return user;
    }

    catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('No user logged in');
      }
      await user.delete();
      await logout();
    }
    catch (e) {
      throw Exception('Deletion failed: $e');
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser == null) {
      return null;
    }
    return AppUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
    );
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return 'Password reset email sent, check inbox';
    }
    catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }

  @override
  Future<AppUser?> signInWithGithub() {
    // TODO: implement signInWithGithub
    throw UnimplementedError();
  }

  @override
  Future<AppUser?> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

}