import 'package:go_router/go_router.dart';
import 'package:book_bridge_app/features/auth/presentation/auth_gate.dart';
import 'package:book_bridge_app/features/listings/presentation/listings_screen.dart';
import 'package:book_bridge_app/features/listings/presentation/listing_detail_screen.dart';
import 'package:book_bridge_app/features/listings/presentation/create_listing_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthGate(),
      routes: <RouteBase>[
        GoRoute(
          path: 'listings',
          builder: (context, state) => const ListingsScreen(),
          routes: <RouteBase>[
            GoRoute(
              path: 'create',
              builder: (context, state) => const CreateListingScreen(),
            ),
            GoRoute(
              path: ':listingId',
              builder: (context, state) => ListingDetailScreen(
                listingId: state.pathParameters['listingId']!,
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);