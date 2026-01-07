import 'package:flutter_test/flutter_test.dart';
import 'package:book_bridge_app/features/users/domain/user_model.dart';

void main() {
  group('UserModel', () {
    test('fromJson/toJson', () {
      final userModel = UserModel(
        uid: '1',
        localityId: '1',
        whatsappNumber: '1234567890',
      );
      final json = userModel.toJson();
      final newUserModel = UserModel.fromJson(json);
      expect(newUserModel.uid, userModel.uid);
      expect(newUserModel.localityId, userModel.localityId);
      expect(newUserModel.whatsappNumber, userModel.whatsappNumber);
    });
  });
}
