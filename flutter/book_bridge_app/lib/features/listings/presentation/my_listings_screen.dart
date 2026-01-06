import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyListingsScreen extends ConsumerWidget {
  const MyListingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    isActive: true,
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: _TabButton(
                    label: 'Sold/Archived',
                    isActive: false,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          // Listings list
          Expanded(
            child: ListView(
              children: [
                _ListingCard(
                  title: 'Calculus: Early Transcendentals',
                  author: 'James Stewart',
                  price: 45.00,
                  condition: 'Good',
                  status: 'Available',
                  daysPosted: 2,
                  imageUrl:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBM55xxsj-xKcWoJoUVTnp7zuMih_FEgLET6g0HHz1lXhyahpxt4L5fHJu8N6b3G8Irv_i5nOyFUxCTTNO69Ir524amBDAUDy65JICGNs67TaRgK3qrVudssNXODgsQcGRI8VQE0Cwoz2cRwVKvPSAhnhHpZnQoRshCm35AD6KMEf2WJ1PGpXtKfPz17yEyBz84OIMmyND5-WjEl4kmhI34hIjAJACQOX8ZBG8yEx0WZAOxNC62jrAbapl2NYKN_Odxm66vfQ3mZPg',
                ),
                _ListingCard(
                  title: 'Introduction to Psychology',
                  author: 'Dr. Charles Stangor',
                  price: 30.00,
                  condition: 'Like New',
                  status: 'Reserved',
                  daysPosted: 5,
                  offers: 1,
                  imageUrl:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuDRhxGfak-jekhY-dt2EnuzGeOmH-igySkRg0UmKDHde2Dy1VBP_HbZhu_Qio12bBzMD8S-efHcQLwNFh1WB-OJoQDFpe2hS64HGHqTMxb9gYboxIDxM_tpO7CLWCTuHBLteq3Fxm672LFPMpvr6fscXPkrbbwegw40aaSYbEEkAZyKr7AuufUj2En4a2Fyq5hnJS4uplmNwR-1-iOjjyI8NLUnMwwWHW5JVzgJZdIM3ojZTE0pFKmoZsdWGvGMA1KfScgZqEzPSMY',
                ),
                _ListingCard(
                  title: 'Organic Chemistry',
                  author: 'Paula Yurkanis Bruice',
                  price: 25.00,
                  condition: 'Fair',
                  status: 'Sold',
                  daysPosted: 10,
                  imageUrl:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuA2yLaKY8ALYDYJSfEF4scQN35HEaqyeEO268EYTj_olEHWE-bu3x4RRMf9xhTS7TtFdUAsJWfcverqcEXD-ns1BQvVRpOutgM_6k5vsC9AdN2xNO2rk90KJRBK3a6OWrCuQHMtrLgkIZOt-p29CLUvUEGHNm9hCrr6rqQfFloCHjXoI9cFdB3CpclF7AqpsmJ2gLOu_z2wFOuuULIGT4Bqnv4IfkDxivPe59VT1fmB66sp_jV1SmeFN5AuMymSUcFG9Aj1s8Pw-D4',
                ),
              ],
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

class _ListingCard extends StatelessWidget {
  final String title;
  final String author;
  final double price;
  final String condition;
  final String status;
  final int daysPosted;
  final int? offers;
  final String imageUrl;

  const _ListingCard({
    required this.title,
    required this.author,
    required this.price,
    required this.condition,
    required this.status,
    required this.daysPosted,
    this.offers,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    bool isSold = status.toLowerCase() == 'sold';

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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.error,
                          size: 30,
                          color: Colors.grey,
                        ),
                      );
                    },
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
                                      color: status == 'Available'
                                          ? Colors.green[100]
                                          : status == 'Reserved'
                                          ? Colors.orange[100]
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: status == 'Available'
                                            ? Colors.green[300]!
                                            : status == 'Reserved'
                                            ? Colors.orange[300]!
                                            : Colors.grey[400]!,
                                      ),
                                    ),
                                    child: Text(
                                      status,
                                      style: TextStyle(
                                        color: status == 'Available'
                                            ? Colors.green[700]
                                            : status == 'Reserved'
                                            ? Colors.orange[700]
                                            : Colors.grey[700],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Posted ${daysPosted}d ago',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                title,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
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
                      '\$${price.toStringAsFixed(2)} • ${condition} Condition',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Action buttons
                    if (status == 'Available')
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
                    else if (status == 'Reserved')
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
                    else if (status == 'Sold')
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
