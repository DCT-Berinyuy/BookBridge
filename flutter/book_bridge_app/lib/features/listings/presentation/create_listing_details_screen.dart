import 'package:book_bridge_app/features/auth/state/auth_provider.dart';
import 'package:book_bridge_app/features/books/state/book_provider.dart';
import 'package:book_bridge_app/features/listings/domain/listing_model.dart';
import 'package:book_bridge_app/features/listings/state/listing_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class CreateListingDetailsScreen extends ConsumerStatefulWidget {
  final String bookId;
  const CreateListingDetailsScreen({super.key, required this.bookId});

  @override
  ConsumerState<CreateListingDetailsScreen> createState() =>
      _CreateListingDetailsScreenState();
}

class _CreateListingDetailsScreenState
    extends ConsumerState<CreateListingDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  double _price = 0.0;
  Condition _condition = Condition.good; // Default condition

  @override
  Widget build(BuildContext context) {
    final book = ref.watch(bookProvider(widget.bookId));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Listing Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Book summary card
            book.when(
              data: (bookData) => Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selected Book',
                            style: TextStyle(
                              color: Colors.green[600],
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                              textBaseline: TextBaseline.alphabetic,
                            ),
                            textScaler: TextScaler.noScaling,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            bookData?.title ?? 'Book Title Not Found',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${bookData?.author} • ${bookData?.edition}',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 64,
                      height: 96,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[300],
                      ),
                      child: const Icon(Icons.book),
                    ),
                  ],
                ),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),

            const SizedBox(height: 8),
            // Price input
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Set your price',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 64,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Text(
                          '\$',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '0.00',
                              border: InputBorder.none,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: Colors.grey[400]),
                            ),
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a price.';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter a valid number.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _price = double.tryParse(value!) ?? 0.0;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Divider
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 1,
              color: Colors.grey[200],
            ),
            const SizedBox(height: 16),
            // Condition selector
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Condition',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<Condition>(
                    initialValue: _condition,
                    items: Condition.values
                        .map(
                          (condition) => DropdownMenuItem(
                            value: condition,
                            child: Text(condition.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _condition = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              final currentUser = ref
                  .read(authStateChangesProvider)
                  .asData
                  ?.value;
              if (currentUser == null) {
                // Handle the case where the user is not logged in
                return;
              }

              const uuid = Uuid();
              final newListing = Listing(
                listingId: uuid.v4(),
                bookId: widget.bookId,
                sellerId: currentUser.uid,
                price: _price,
                condition: _condition,
                localityId:
                    'placeholder_locality_id', // TODO: Get current locality
                status: Status.available,
                createdAt: DateTime.now(),
              );

              await ref
                  .read(listingsProvider.notifier)
                  .createListing(newListing);
              if (context.mounted) {
                context.go('/');
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'List Book',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
