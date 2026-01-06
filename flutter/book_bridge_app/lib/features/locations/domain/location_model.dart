import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
class Location {
  final String localityId;
  final String name;
  final String city;

  Location({required this.localityId, required this.name, required this.city});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
