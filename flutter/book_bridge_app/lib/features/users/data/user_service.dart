import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_bridge_app/features/users/domain/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore;

  UserService(this._firestore);

  Future<void> createUser(User user) async {
    await _firestore.collection('users').doc(user.userId).set(user.toJson());
  }

  Future<User?> getUser(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return User.fromJson(doc.data()!);
    }
    return null;
  }

  Future<void> updateUser(User user) async {
    await _firestore.collection('users').doc(user.userId).update(user.toJson());
  }
}
