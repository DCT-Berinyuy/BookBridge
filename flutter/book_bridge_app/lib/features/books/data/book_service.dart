import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_bridge_app/features/books/domain/book_model.dart';

class BookService {
  final FirebaseFirestore _firestore;

  BookService(this._firestore);

  Future<void> createBook(Book book) async {
    await _firestore.collection('books').doc(book.bookId).set(book.toJson());
  }

  Future<Book?> getBook(String bookId) async {
    final doc = await _firestore.collection('books').doc(bookId).get();
    if (doc.exists) {
      return Book.fromJson(doc.data()!);
    }
    return null;
  }
}
