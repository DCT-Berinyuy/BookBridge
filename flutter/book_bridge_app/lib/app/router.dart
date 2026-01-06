import 'package:go_router/go_router.dart';
import 'package:book_bridge_app/features/auth/presentation/auth_gate.dart';
import 'package:book_bridge_app/features/listings/presentation/listings_feed_screen.dart';
import 'package:book_bridge_app/features/listings/presentation/listing_detail_screen.dart';
import 'package:book_bridge_app/features/listings/presentation/create_listing_book_selection_screen.dart';
import 'package:book_bridge_app/features/listings/presentation/create_listing_details_screen.dart';
import 'package:book_bridge_app/features/listings/presentation/my_listings_screen.dart';
import 'package:book_bridge_app/features/users/presentation/profile_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthGate(),
      routes: <RouteBase>[
        GoRoute(
          path: 'listings',
          builder: (context, state) => const ListingsFeedScreen(),
          routes: <RouteBase>[
            GoRoute(
              path: 'create',
              builder: (context, state) =>
                  const CreateListingBookSelectionScreen(),
              routes: <RouteBase>[
                GoRoute(
                  path: 'details',
                  builder: (context, state) =>
                      const CreateListingDetailsScreen(),
                ),
              ],
            ),
            GoRoute(
              path: 'my',
              builder: (context, state) => const MyListingsScreen(),
            ),
            GoRoute(
              path: ':listingId',
              builder: (context, state) => ListingDetailScreen(
                listingId: state.pathParameters['listingId']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);
