import 'package:riverpod/riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_bridge_app/features/books/data/book_service.dart';
import 'package:book_bridge_app/features/books/domain/book_model.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final bookServiceProvider = Provider<BookService>((ref) {
  return BookService(ref.watch(firestoreProvider));
});

final bookProvider = FutureProvider.family<Book?, String>((ref, bookId) {
  return ref.watch(bookServiceProvider).getBook(bookId);
});

final booksStreamProvider = StreamProvider<List<Book>>((ref) {
  return ref.watch(bookServiceProvider).getBooks();
});
