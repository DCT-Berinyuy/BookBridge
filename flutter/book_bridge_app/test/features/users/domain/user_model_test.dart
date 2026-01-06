import 'package:flutter_test/flutter_test.dart';
import 'package:book_bridge_app/features/users/domain/user_model.dart';

void main() {
  group('User', () {
    test('fromJson/toJson', () {
      final user = User(
        userId: '1',
        name: 'Test User',
        localityId: '1',
        contact: Contact(phone: '1234567890'),
        createdAt: DateTime.now(),
      );
      final json = user.toJson();
      final newUser = User.fromJson(json);
      expect(newUser.userId, user.userId);
      expect(newUser.name, user.name);
    });
  });
}
