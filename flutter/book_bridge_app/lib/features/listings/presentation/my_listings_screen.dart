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

class _MyListingsScreenState extends ConsumerState<MyListingsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authStateChangesProvider).asData?.value;

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Listings',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: 80,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'Please sign in to see your listings',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Your listings will appear here once you\'re signed in',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
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
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.of(context).pushNamed('/listings/create');
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.green,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: 'Active'),
                Tab(text: 'Inactive'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Active listings tab
          listings.when(
            data: (listingList) {
              final activeListings = listingList.where((listing) {
                return listing.status == Status.available ||
                       listing.status == Status.reserved;
              }).toList();

              if (activeListings.isEmpty) {
                return const _EmptyState(
                  title: 'No active listings',
                  subtitle: 'You don\'t have any active listings yet.\nStart by creating your first listing!',
                  icon: Icons.book_outlined,
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  // Refresh the listings
                },
                child: ListView.builder(
                  itemCount: activeListings.length,
                  itemBuilder: (context, index) {
                    final listing = activeListings[index];
                    return _ListingCard(
                      listing: listing,
                      isSold: false,
                    );
                  },
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
          // Inactive listings tab
          listings.when(
            data: (listingList) {
              final inactiveListings = listingList.where((listing) {
                return listing.status == Status.sold;
              }).toList();

              if (inactiveListings.isEmpty) {
                return const _EmptyState(
                  title: 'No inactive listings',
                  subtitle: 'Your sold listings will appear here.',
                  icon: Icons.sell_outlined,
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  // Refresh the listings
                },
                child: ListView.builder(
                  itemCount: inactiveListings.length,
                  itemBuilder: (context, index) {
                    final listing = inactiveListings[index];
                    return _ListingCard(
                      listing: listing,
                      isSold: true,
                    );
                  },
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _EmptyState({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/listings/create');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Create Listing',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListingCard extends ConsumerWidget {
  final Listing listing;
  final bool isSold;

  const _ListingCard({
    required this.listing,
    required this.isSold,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(bookProvider(listing.bookId));

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSold
              ? Colors.grey.shade300
              : listing.status == Status.reserved
                  ? Colors.orange.shade200
                  : Colors.grey.shade200,
        ),
      ),
      color: isSold ? Colors.grey[50] : null,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Navigate to listing details
          Navigator.of(context).pushNamed('/listings/${listing.listingId}');
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book cover image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 80,
                  height: 112,
                  child: listing.imageUrl != null
                      ? Image.network(
                          listing.imageUrl!,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.book, size: 40),
                            );
                          },
                        )
                      : Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.book, size: 40),
                        ),
                ),
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
                                        color: listing.status == Status.available
                                            ? Colors.green[300]!
                                            : listing.status == Status.reserved
                                            ? Colors.orange[300]!
                                            : Colors.grey[400]!,
                                      ),
                                    ),
                                    child: Text(
                                      listing.status.name,
                                      style: TextStyle(
                                        color: listing.status == Status.available
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
                        PopupMenuButton<String>(
                          onSelected: (String result) {
                            _handleMenuSelection(result, context);
                          },
                          itemBuilder: (BuildContext context) => [
                            const PopupMenuItem<String>(
                              value: 'edit',
                              child: Text('Edit Listing'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'share',
                              child: Text('Share'),
                            ),
                            if (listing.status == Status.available)
                              const PopupMenuItem<String>(
                                value: 'deactivate',
                                child: Text('Deactivate'),
                              ),
                          ],
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
                            flex: 2,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // Edit listing
                              },
                              icon: const Icon(Icons.edit, size: 16),
                              label: const Text('Edit'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey[700],
                                side: BorderSide(color: Colors.grey[300]!),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 3,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Share listing
                              },
                              icon: const Icon(Icons.share, size: 16),
                              label: const Text('Share'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[100],
                                foregroundColor: Colors.grey[800],
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
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
                              onPressed: () {
                                // Mark as sold
                              },
                              icon: const Icon(Icons.check_circle, size: 16),
                              label: const Text('Mark Sold'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
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
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green[200]!),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle, color: Colors.green[700]),
                            const SizedBox(width: 4),
                            Text(
                              'Sold',
                              style: TextStyle(
                                color: Colors.green[700],
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

  void _handleMenuSelection(String value, BuildContext context) {
    switch (value) {
      case 'edit':
        // Handle edit action
        break;
      case 'share':
        // Handle share action
        break;
      case 'deactivate':
        // Handle deactivate action
        break;
    }
  }
}
