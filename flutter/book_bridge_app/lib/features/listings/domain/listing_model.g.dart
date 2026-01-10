// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Listing _$ListingFromJson(Map<String, dynamic> json) => Listing(
  listingId: json['listingId'] as String,
  bookId: json['bookId'] as String,
  sellerId: json['sellerId'] as String,
  price: (json['price'] as num).toDouble(),
  condition: $enumDecode(_$ConditionEnumMap, json['condition']),
  localityId: json['localityId'] as String,
  status: $enumDecode(_$StatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$ListingToJson(Listing instance) => <String, dynamic>{
  'listingId': instance.listingId,
  'bookId': instance.bookId,
  'sellerId': instance.sellerId,
  'price': instance.price,
  'condition': _$ConditionEnumMap[instance.condition]!,
  'localityId': instance.localityId,
  'status': _$StatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'imageUrl': instance.imageUrl,
};

const _$ConditionEnumMap = {
  Condition.brandNew: 'brandNew',
  Condition.good: 'good',
  Condition.fair: 'fair',
  Condition.poor: 'poor',
};

const _$StatusEnumMap = {
  Status.available: 'available',
  Status.reserved: 'reserved',
  Status.sold: 'sold',
};
