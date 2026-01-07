import 'package:riverpod/riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_bridge_app/features/users/data/user_service.dart';
import 'package:book_bridge_app/features/users/domain/user_model.dart';
import 'package:book_bridge_app/features/auth/state/auth_provider.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final userServiceProvider = Provider<UserService>((ref) {
  return UserService(ref.watch(firestoreProvider));
});

final userProvider = FutureProvider<UserModel?>((ref) {
  final authState = ref.watch(authStateChangesProvider);
  final userService = ref.watch(userServiceProvider);

  if (authState.asData?.value != null) {
    return userService.getUser(authState.asData!.value!.uid);
  }
  return null;
});
