import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:book_bridge_app/features/listings/domain/listing_model.dart';
import 'package:book_bridge_app/features/listings/state/listing_provider.dart';
import 'package:uuid/uuid.dart'; // For generating unique IDs

import 'package:book_bridge_app/features/auth/state/auth_provider.dart';

class CreateListingScreen extends ConsumerStatefulWidget {
  const CreateListingScreen({super.key});

  @override
  ConsumerState<CreateListingScreen> createState() =>
      _CreateListingScreenState();
}

class _CreateListingScreenState extends ConsumerState<CreateListingScreen> {
  final _formKey = GlobalKey<FormState>();
  String _bookTitle = '';
  double _price = 0.0;
  Condition _condition = Condition.good; // Default condition

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Listing')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Book Title'),
                  onSaved: (value) {
                    _bookTitle = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a book title.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    _price = double.tryParse(value!) ?? 0.0;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number.';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<Condition>(
                  initialValue: _condition,
                  decoration: const InputDecoration(labelText: 'Condition'),
                  items: Condition.values
                      .map(
                        (cond) => DropdownMenuItem(
                          value: cond,
                          child: Text(cond.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _condition = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
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
                        bookId:
                            'placeholder_book_id', // TODO: Implement book selection
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
                        context.pop();
                      }
                    }
                  },
                  child: const Text('Create Listing'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
