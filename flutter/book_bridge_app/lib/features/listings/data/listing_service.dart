import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_bridge_app/features/listings/domain/listing_model.dart';

class ListingService {
  final FirebaseFirestore _firestore;

  ListingService(this._firestore);

  Future<void> createListing(Listing listing) async {
    await _firestore
        .collection('listings')
        .doc(listing.listingId)
        .set(listing.toJson());
  }

  Stream<List<Listing>> getListings() {
    return _firestore.collection('listings').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Listing.fromJson(doc.data())).toList();
    });
  }

  Future<void> updateListing(Listing listing) async {
    await _firestore
        .collection('listings')
        .doc(listing.listingId)
        .update(listing.toJson());
  }
}
