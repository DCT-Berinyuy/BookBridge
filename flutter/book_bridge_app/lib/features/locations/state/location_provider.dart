import 'package:riverpod/riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_bridge_app/features/locations/data/location_service.dart';
import 'package:book_bridge_app/features/locations/domain/location_model.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService(ref.watch(firestoreProvider));
});

final locationProvider = FutureProvider.family<Location?, String>((
  ref,
  localityId,
) {
  return ref.watch(locationServiceProvider).getLocation(localityId);
});
