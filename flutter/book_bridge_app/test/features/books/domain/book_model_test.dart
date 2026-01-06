import 'package:flutter_test/flutter_test.dart';
import 'package:book_bridge_app/features/books/domain/book_model.dart';

void main() {
  group('Book', () {
    test('fromJson/toJson', () {
      final book = Book(
        bookId: '1',
        title: 'Test Book',
        author: 'Test Author',
        category: 'Test Category',
        createdAt: DateTime.now(),
      );
      final json = book.toJson();
      final newBook = Book.fromJson(json);
      expect(newBook.bookId, book.bookId);
      expect(newBook.title, book.title);
    });
  });
}
