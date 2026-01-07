import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_bridge_app/features/users/domain/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore;

  UserService(this._firestore);

  Future<void> createUser(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toJson());
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }

  Future<void> updateUser(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).update(user.toJson());
  }
}
