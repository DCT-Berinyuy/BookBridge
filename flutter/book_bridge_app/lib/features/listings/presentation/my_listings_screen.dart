import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:book_bridge_app/features/auth/state/auth_provider.dart';
import 'package:book_bridge_app/features/books/state/book_provider.dart';
import 'package:book_bridge_app/features/listings/domain/listing_model.dart';
import 'package:book_bridge_app/features/listings/state/listing_provider.dart';

class MyListingsScreen extends ConsumerStatefulWidget {
  const MyListingsScreen({super.key});

  @override
  ConsumerState<MyListingsScreen> createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends ConsumerState<MyListingsScreen> {
  bool _showActive = true;

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authStateChangesProvider).asData?.value;

    if (currentUser == null) {
      return const Center(child: Text('Please sign in to see your listings.'));
    }

    final listings = ref.watch(listingsBySellerProvider(currentUser.uid));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Listings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Segmented control for tabs
          Container(
            margin: const EdgeInsets.all(16),
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _TabButton(
                    label: 'Active',
                    isActive: _showActive,
                    onTap: () {
                      setState(() {
                        _showActive = true;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: _TabButton(
                    label: 'Sold/Archived',
                    isActive: !_showActive,
                    onTap: () {
                      setState(() {
                        _showActive = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          // Listings list
          Expanded(
            child: listings.when(
              data: (listingList) {
                final filteredList = listingList.where((listing) {
                  final isActive =
                      listing.status == Status.available ||
                      listing.status == Status.reserved;
                  return _showActive ? isActive : !isActive;
                }).toList();

                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final listing = filteredList[index];
                    return _ListingCard(listing: listing);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isActive ? Colors.black : Colors.grey[600],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ListingCard extends ConsumerWidget {
  final Listing listing;

  const _ListingCard({required this.listing});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(bookProvider(listing.bookId));
    final isSold = listing.status == Status.sold;

    return Opacity(
      opacity: isSold ? 0.9 : 1.0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSold ? Colors.grey[100] : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book cover image
              Container(
                width: 100,
                height: 133,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                ),
                child: const Icon(Icons.book),
              ),
              const SizedBox(width: 12),
              // Book details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: listing.status == Status.available
                                          ? Colors.green[100]
                                          : listing.status == Status.reserved
                                          ? Colors.orange[100]
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color:
                                            listing.status == Status.available
                                            ? Colors.green[300]!
                                            : listing.status == Status.reserved
                                            ? Colors.orange[300]!
                                            : Colors.grey[400]!,
                                      ),
                                    ),
                                    child: Text(
                                      listing.status.name,
                                      style: TextStyle(
                                        color:
                                            listing.status == Status.available
                                            ? Colors.green[700]
                                            : listing.status == Status.reserved
                                            ? Colors.orange[700]
                                            : Colors.grey[700],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Posted ${DateTime.now().difference(listing.createdAt).inDays}d ago',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              book.when(
                                data: (bookData) => Text(
                                  bookData?.title ?? 'Book Title Not Found',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                loading: () => const Text('Loading...'),
                                error: (error, stack) => const Text('Error'),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${listing.price.toStringAsFixed(2)} • ${listing.condition.name} Condition',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Action buttons
                    if (listing.status == Status.available)
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.edit, size: 18),
                              label: const Text('Edit'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey[700],
                                side: BorderSide(color: Colors.grey[300]!),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.share, size: 18),
                              label: const Text('Share'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey[700],
                                side: BorderSide(color: Colors.grey[300]!),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    else if (listing.status == Status.reserved)
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.check_circle, size: 18),
                              label: const Text('Mark Sold'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    else if (listing.status == Status.sold)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(
                              'Sold',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
