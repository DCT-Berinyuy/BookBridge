// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
  bookId: json['bookId'] as String,
  title: json['title'] as String,
  author: json['author'] as String,
  isbn: json['isbn'] as String?,
  category: json['category'] as String,
  edition: json['edition'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
  'bookId': instance.bookId,
  'title': instance.title,
  'author': instance.author,
  'isbn': instance.isbn,
  'category': instance.category,
  'edition': instance.edition,
  'createdAt': instance.createdAt.toIso8601String(),
};
