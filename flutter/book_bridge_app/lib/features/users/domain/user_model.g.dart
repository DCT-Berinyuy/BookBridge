// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  userId: json['userId'] as String,
  name: json['name'] as String,
  role: json['role'] as String? ?? 'student',
  localityId: json['localityId'] as String,
  contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'userId': instance.userId,
  'name': instance.name,
  'role': instance.role,
  'localityId': instance.localityId,
  'contact': instance.contact.toJson(),
  'createdAt': instance.createdAt.toIso8601String(),
};

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
  phone: json['phone'] as String?,
  whatsapp: json['whatsapp'] as String?,
);

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
  'phone': instance.phone,
  'whatsapp': instance.whatsapp,
};
