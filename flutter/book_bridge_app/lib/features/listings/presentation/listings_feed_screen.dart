import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:book_bridge_app/features/listings/domain/listing_model.dart';
import 'package:book_bridge_app/features/listings/state/listing_provider.dart';

class ListingsFeedScreen extends ConsumerWidget {
  const ListingsFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listings = ref.watch(listingsStreamProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header with search and filters
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: 180,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                alignment: Alignment.center,
                child: Text(
                  'BookBridge',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              background: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Location and notifications row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.green),
                            const Text('Near University'),
                            const Icon(Icons.expand_more),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Search bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search \'Biology 101\' or ISBN...',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.tune),
                            onPressed: () {},
                          ),
                          filled: true,
                          fillColor: Theme.of(context).cardColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Filter chips
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                children: [
                  FilterChip(
                    label: const Text('Recently Added'),
                    selected: true,
                    onSelected: (bool selected) {},
                  ),
                  FilterChip(
                    label: const Text('Price: Low to High'),
                    selected: false,
                    onSelected: (bool selected) {},
                  ),
                  FilterChip(
                    label: const Text('Condition: Like New'),
                    selected: false,
                    onSelected: (bool selected) {},
                  ),
                  FilterChip(
                    label: const Text('Subject: Math'),
                    selected: false,
                    onSelected: (bool selected) {},
                  ),
                ],
              ),
            ),
          ),
          // Listings list
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return listings.when(
                  data: (listingList) {
                    if (index >= listingList.length) {
                      return const SizedBox.shrink();
                    }
                    final listing = listingList[index];
                    return _ListingCard(listing: listing);
                  },
                  loading: () => const ListTile(title: Text('Loading...')),
                  error: (error, stack) =>
                      ListTile(title: Text('Error: $error')),
                );
              },
              childCount: 10, // Placeholder count
            ),
          ),
        ],
      ),
    );
  }
}

class _ListingCard extends StatelessWidget {
  final Listing listing;

  const _ListingCard({required this.listing});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          context.push('/listings/${listing.listingId}');
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Book cover image
              Container(
                width: 80,
                height: 112,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                ),
                child: const Icon(Icons.book, size: 40),
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
                          child: Text(
                            listing.bookId, // This should be the book title
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Author Name', // This should come from the book model
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.green[300]!),
                          ),
                          child: Text(
                            listing.condition.name,
                            style: TextStyle(
                              color: Colors.green[700],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '• 0.2 mi away',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${listing.price.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Colors.green[600],
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          'North Campus',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ],
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
