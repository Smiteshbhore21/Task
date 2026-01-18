import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

class AuthController {
  AuthController(this._auth);
  final FirebaseAuth _auth;

  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> signup(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }
}

final authControllerProvider = Provider<AuthController>((ref) {
  return AuthController(ref.watch(firebaseAuthProvider));
});
