import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_bridge_app/features/users/data/user_service.dart';
import 'package:book_bridge_app/features/users/domain/user_model.dart';

import 'user_service_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  DocumentSnapshot,
])
void main() {
  late UserService userService;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    userService = UserService(mockFirestore);

    when(mockFirestore.collection('users')).thenReturn(mockCollectionReference);
    when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
  });

  group('UserService', () {
    final user = User(
      userId: '1',
      name: 'Test User',
      localityId: '1',
      contact: Contact(phone: '1234567890'),
      createdAt: DateTime.now(),
    );

    test('createUser', () async {
      when(
        mockDocumentReference.set(any),
      ).thenAnswer((_) async => Future.value());
      await userService.createUser(user);
      verify(mockDocumentReference.set(user.toJson())).called(1);
    });
  });
}
