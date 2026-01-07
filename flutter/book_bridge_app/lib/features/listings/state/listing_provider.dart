import 'package:riverpod/riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_bridge_app/features/listings/data/listing_service.dart';
import 'package:book_bridge_app/features/listings/domain/listing_model.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final listingServiceProvider = Provider<ListingService>((ref) {
  return ListingService(ref.watch(firestoreProvider));
});

final listingsStreamProvider = StreamProvider<List<Listing>>((ref) {
  return ref.watch(listingServiceProvider).getListings();
});

final listingsProvider = StateNotifierProvider<ListingsNotifier, List<Listing>>(
  (ref) {
    return ListingsNotifier(ref.watch(listingServiceProvider));
  },
);

final listingsBySellerProvider = StreamProvider.family<List<Listing>, String>((
  ref,
  sellerId,
) {
  return ref.watch(listingServiceProvider).getListingsBySeller(sellerId);
});

class ListingsNotifier extends StateNotifier<List<Listing>> {
  final ListingService _listingService;

  ListingsNotifier(this._listingService) : super([]);

  Future<void> createListing(Listing listing) async {
    await _listingService.createListing(listing);
  }

  Future<void> updateListing(Listing listing) async {
    await _listingService.updateListing(listing);
  }
}
