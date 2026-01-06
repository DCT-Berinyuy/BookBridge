import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateListingBookSelectionScreen extends ConsumerWidget {
  const CreateListingBookSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    child: ListView(
                      children: [
                        _BookListItem(
                          title: 'Introduction to Algorithms',
                          author: 'Thomas H. Cormen',
                          edition: '3rd Ed.',
                          isbn: '9780262033848',
                          imageUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuB2zzhknAoRRcfrEi4tqlDtCCZSIZ9H1Um1JIRfbXdct01Bz8_ViCFgCPzjmmXXTxSHvE1rQshBOALo3g5AFt7kSabNFkrnPQwtDeDhVIKXEUdeb2hBx-Axo2aIlgdlUnEWuigIBSPbQ9IdgFeDTRAzJqr6VhB2NNL1jwOMtZz2hR4HReX-qI1_4pPq1pk8WVV5DRK5SXDcXhfMCsmzzrQt1lilH459dgErBZ2UYakzBHrFdxkOiSXpePxGC0AeDzpTkLP81OsNCaY',
                        ),
                        _BookListItem(
                          title: 'Calculus: Early Transcendentals',
                          author: 'James Stewart',
                          edition: '8th Ed.',
                          isbn: '9781285741550',
                          imageUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuCtcrZHG6vr4F_9DgtZ_9ecAqgWNwMFizp01IceFOZpPD4qFDDjOjzwUlnPukghfTvF0f8uR4Zd81_Ofn-7mFdu_mdsstGOsdy_rn0I3G12B4kBmLgAW67AY0ZgRJwFAoTZBbZLkvmX8jmRF_WWKGMXF4aMrJrxsvHgFZQ5qBj6TIP9BPc06V767cG_moJ-SBlUa8DRCHPCnRrwWnjSkKN4xy4N6gbgJ3avpoVrB3JpCcRKqQlPJ_2mCh4QbcYyHtLOhFzPNFO9j6c',
                        ),
                        _BookListItem(
                          title: 'Organic Chemistry',
                          author: 'Paula Yurkanis Bruice',
                          edition: '2016',
                          isbn: '9780134042282',
                          imageUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuA2yLaKY8ALYDYJSfEF4scQN35HEaqyeEO268EYTj_olEHWE-bu3x4RRMf9xhTS7TtFdUAsJWfcverqcEXD-ns1BQvVRpOutgM_6k5vsC9AdN2xNO2rk90KJRBK3a6OWrCuQHMtrLgkIZOt-p29CLUvUEGHNm9hCrr6rqQfFloCHjXoI9cFdB3CpclF7AqpsmJ2gLOu_z2wFOuuULIGT4Bqnv4IfkDxivPe59VT1fmB66sp_jV1SmeFN5AuMymSUcFG9Aj1s8Pw-D4',
                        ),
                        _BookListItem(
                          title: 'Clean Code',
                          author: 'Robert C. Martin',
                          edition: '1st Ed.',
                          isbn: '9780132350884',
                          imageUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuC82EC77UvK1qDME0rioJlzN7QidhhBSW9040-dHy368K1epupNMKKRVnpqNIqsI0tl60OZadzo7Yow-CxqIjPA1lKKdEc_p8E8lXy2TOS7NmPgp3pE1I9woST5oBhJ7OcR5JddSCEByBE66FFq0tC3R-llRd34vCpzbASBOFTgrwsfmVKUD8mS_ElSH5zrMKT4_FDr6doXIH_0ojDUDY2EAKfrt4XcJy5NBvkQabzpI07OCS4et2qsNgxno3Rssm14dAtNik0RH-s',
                        ),
                      ],
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
  final String title;
  final String author;
  final String edition;
  final String isbn;
  final String imageUrl;

  const _BookListItem({
    required this.title,
    required this.author,
    required this.edition,
    required this.isbn,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          // Navigate to the next step in creating the listing
          context.push('/listings/create/details');
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
                          size: 24,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Book details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      author,
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
                            edition,
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
                            'ISBN: $isbn',
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
