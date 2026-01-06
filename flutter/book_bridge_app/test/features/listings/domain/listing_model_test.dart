import 'package:flutter_test/flutter_test.dart';
import 'package:book_bridge_app/features/listings/domain/listing_model.dart';

void main() {
  group('Listing', () {
    test('fromJson/toJson', () {
      final listing = Listing(
        listingId: '1',
        bookId: '1',
        sellerId: '1',
        price: 10.0,
        condition: Condition.good,
        localityId: '1',
        status: Status.available,
        createdAt: DateTime.now(),
      );
      final json = listing.toJson();
      final newListing = Listing.fromJson(json);
      expect(newListing.listingId, listing.listingId);
      expect(newListing.bookId, listing.bookId);
    });
  });
}
