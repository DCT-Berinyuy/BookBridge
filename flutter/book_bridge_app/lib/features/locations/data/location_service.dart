import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_bridge_app/features/locations/domain/location_model.dart';

class LocationService {
  final FirebaseFirestore _firestore;

  LocationService(this._firestore);

  Stream<List<Location>> getLocations() {
    return _firestore.collection('locations').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Location.fromJson(doc.data())).toList();
    });
  }
}
