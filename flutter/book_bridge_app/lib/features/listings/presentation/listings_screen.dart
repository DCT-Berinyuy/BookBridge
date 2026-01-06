import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:book_bridge_app/features/listings/state/listing_provider.dart';

import 'package:go_router/go_router.dart';

class ListingsScreen extends ConsumerWidget {
  const ListingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsyncValue = ref.watch(listingsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Book Listings')),
      body: listingsAsyncValue.when(
        data: (listings) {
          if (listings.isEmpty) {
            return const Center(child: Text('No listings found.'));
          }
          return ListView.builder(
            itemCount: listings.length,
            itemBuilder: (context, index) {
              final listing = listings[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    context.go('/listings/${listing.listingId}');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listing.bookId, // Placeholder for book title
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Price: \$${listing.price.toStringAsFixed(2)}'),
                        Text('Condition: ${listing.condition.name}'),
                        Text('Status: ${listing.status.name}'),
                        Text('Seller: ${listing.sellerId}'), // Placeholder
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/listings/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
