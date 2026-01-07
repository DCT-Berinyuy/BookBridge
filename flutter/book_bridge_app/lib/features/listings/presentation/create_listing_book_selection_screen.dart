import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:book_bridge_app/features/books/domain/book_model.dart';
import 'package:book_bridge_app/features/books/state/book_provider.dart';

class CreateListingBookSelectionScreen extends ConsumerStatefulWidget {
  const CreateListingBookSelectionScreen({super.key});

  @override
  ConsumerState<CreateListingBookSelectionScreen> createState() =>
      _CreateListingBookSelectionScreenState();
}

class _CreateListingBookSelectionScreenState
    extends ConsumerState<CreateListingBookSelectionScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final books = ref.watch(booksStreamProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Sell a Book',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          SizedBox(width: 48), // Spacer to balance the layout
        ],
      ),
      body: Column(
        children: [
          // Search section
          Container(
            padding: const EdgeInsets.all(16),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search Title, Author, or ISBN',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.qr_code_scanner),
                  onPressed: () {},
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          // Popular categories
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Popular Categories',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    letterSpacing: 1.2,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                  textScaler: TextScaler.noScaling,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _CategoryChip(label: 'Calculus'),
                      _CategoryChip(label: 'Biology'),
                      _CategoryChip(label: 'Computer Science'),
                      _CategoryChip(label: 'Economics'),
                      _CategoryChip(label: 'History'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Recent scans and results
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Scans & Results',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: 1.2,
                      textBaseline: TextBaseline.alphabetic,
                    ),
                    textScaler: TextScaler.noScaling,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: books.when(
                      data: (bookList) {
                        final filteredBooks = bookList
                            .where(
                              (book) =>
                                  book.title.toLowerCase().contains(
                                    _searchQuery,
                                  ) ||
                                  book.author.toLowerCase().contains(
                                    _searchQuery,
                                  ) ||
                                  (book.isbn?.toLowerCase().contains(
                                        _searchQuery,
                                      ) ??
                                      false),
                            )
                            .toList();

                        return ListView.builder(
                          itemCount: filteredBooks.length,
                          itemBuilder: (context, index) {
                            final book = filteredBooks[index];
                            return _BookListItem(book: book);
                          },
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stack) =>
                          Center(child: Text('Error: $error')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;

  const _CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: false,
        onSelected: (bool selected) {},
        backgroundColor: Theme.of(context).cardColor,
        side: BorderSide(color: Colors.grey[300]!),
      ),
    );
  }
}

class _BookListItem extends StatelessWidget {
  final Book book;

  const _BookListItem({required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          // Navigate to the next step in creating the listing
          context.push('/listings/create/details', extra: book.bookId);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              // Book cover
              Container(
                width: 60,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                ),
                child: const Icon(Icons.book),
              ),
              const SizedBox(width: 16),
              // Book details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.author,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            book.edition ?? '',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'ISBN: ${book.isbn ?? ''}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
