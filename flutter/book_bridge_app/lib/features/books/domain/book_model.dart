import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

@JsonSerializable()
class Book {
  final String bookId;
  final String title;
  final String author;
  final String? isbn;
  final String category;
  final String? edition;
  final DateTime createdAt;

  Book({
    required this.bookId,
    required this.title,
    required this.author,
    this.isbn,
    required this.category,
    this.edition,
    required this.createdAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}
