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
    final userModel = UserModel(
      uid: '1',
      localityId: '1',
      whatsappNumber: '1234567890',
    );

    test('createUser', () async {
      when(
        mockDocumentReference.set(any),
      ).thenAnswer((_) async => Future.value());
      await userService.createUser(userModel);
      verify(mockDocumentReference.set(userModel.toJson())).called(1);
    });

    test('getUser', () async {
      when(mockDocumentReference.get()).thenAnswer(
        (_) async => MockDocumentSnapshot(
          {'uid': '1', 'localityId': '1', 'whatsappNumber': '1234567890'},
        ),
      );
      final fetchedUser = await userService.getUser('1');
      expect(fetchedUser?.uid, userModel.uid);
      expect(fetchedUser?.localityId, userModel.localityId);
      expect(fetchedUser?.whatsappNumber, userModel.whatsappNumber);
    });
  });
}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {
  final Map<String, dynamic> _data;
  MockDocumentSnapshot(this._data);

  @override
  bool get exists => true;

  @override
  Map<String, dynamic> data() => _data;
}
