import 'package:json_annotation/json_annotation.dart';

part 'listing_model.g.dart';

enum Condition { brandNew, good, fair, poor }

enum Status { available, reserved, sold }

@JsonSerializable()
class Listing {
  final String listingId;
  final String bookId;
  final String sellerId;
  final double price;
  final Condition condition;
  final String localityId;
  final Status status;
  final DateTime createdAt;

  Listing({
    required this.listingId,
    required this.bookId,
    required this.sellerId,
    required this.price,
    required this.condition,
    required this.localityId,
    required this.status,
    required this.createdAt,
  });

  factory Listing.fromJson(Map<String, dynamic> json) =>
      _$ListingFromJson(json);

  Map<String, dynamic> toJson() => _$ListingToJson(this);
}
