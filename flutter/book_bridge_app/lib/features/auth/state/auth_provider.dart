import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';
import 'package:book_bridge_app/features/auth/data/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn();
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(
    ref.watch(firebaseAuthProvider),
    ref.watch(googleSignInProvider),
  );
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});
