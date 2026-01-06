import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final String userId;
  final String name;
  final String role;
  final String localityId;
  final Contact contact;
  final DateTime createdAt;

  User({
    required this.userId,
    required this.name,
    this.role = 'student',
    required this.localityId,
    required this.contact,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Contact {
  final String? phone;
  final String? whatsapp;

  Contact({this.phone, this.whatsapp});

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
