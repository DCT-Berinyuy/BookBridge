import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListingDetailScreen extends ConsumerWidget {
  final String listingId;

  const ListingDetailScreen({super.key, required this.listingId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // In a real app, you would fetch the listing details using the listingId
    // For now, we'll display a placeholder
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listing Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Listing ID: $listingId'),
            const Text('Details for this listing would go here.'),
          ],
        ),
      ),
    );
  }
}
