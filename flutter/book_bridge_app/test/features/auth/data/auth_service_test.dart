import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:book_bridge_app/features/auth/data/auth_service.dart';

import 'auth_service_test.mocks.dart';

@GenerateMocks([
  FirebaseAuth,
  GoogleSignIn,
  GoogleSignInAccount,
  GoogleSignInAuthentication,
  UserCredential,
  User,
])
void main() {
  late AuthService authService;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockGoogleSignInAccount mockGoogleSignInAccount;
  late MockGoogleSignInAuthentication mockGoogleSignInAuthentication;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    mockGoogleSignInAccount = MockGoogleSignInAccount();
    mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();

    authService = AuthService(mockFirebaseAuth, mockGoogleSignIn);
  });

  group('AuthService', () {
    test('signOut', () async {
      when(mockFirebaseAuth.signOut()).thenAnswer((_) async => Future.value());
      when(mockGoogleSignIn.signOut()).thenAnswer((_) async => Future.value());
      await authService.signOut();
      verify(mockFirebaseAuth.signOut()).called(1);
      verify(mockGoogleSignIn.signOut()).called(1);
    });

    test('signInWithGoogle success', () async {
      when(
        mockGoogleSignIn.signIn(),
      ).thenAnswer((_) async => mockGoogleSignInAccount);
      when(
        mockGoogleSignInAccount.authentication,
      ).thenAnswer((_) async => mockGoogleSignInAuthentication);
      when(
        mockGoogleSignInAuthentication.accessToken,
      ).thenAnswer((_) => 'testAccessToken');
      when(
        mockGoogleSignInAuthentication.idToken,
      ).thenAnswer((_) => 'testIdToken');
      when(
        mockFirebaseAuth.signInWithCredential(any),
      ).thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);

      final user = await authService.signInWithGoogle();
      expect(user, isA<User>());
      verify(mockGoogleSignIn.signIn()).called(1);
      verify(mockFirebaseAuth.signInWithCredential(any)).called(1);
    });

    test('signInWithGoogle cancelled', () async {
      when(mockGoogleSignIn.signIn()).thenAnswer((_) async => null);

      final user = await authService.signInWithGoogle();
      expect(user, isNull);
      verify(mockGoogleSignIn.signIn()).called(1);
      verifyNever(mockFirebaseAuth.signInWithCredential(any));
    });
  });
}
