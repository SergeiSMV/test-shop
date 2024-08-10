
import 'package:go_router/go_router.dart';
import 'package:test_shop/ui/account_screen.dart';
import 'package:test_shop/ui/favorites/favorite_screen.dart';

import '../ui/auth_screen.dart';
import '../ui/shop_screen.dart';
import 'shell_route_scaffold.dart';

final GoRouter router = GoRouter(
  initialLocation: '/auth',
  routes: <RouteBase>[
    ShellRoute(
      builder: (context, state, child) {        
        return ShellRouteScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => const NoTransitionPage<void>(child: ShopScreen()),
        ),
        GoRoute(
          path: '/auth',
          pageBuilder: (context, state) => const NoTransitionPage<void>(child: AuthScreen()),
        ),
        GoRoute(
          path: '/favorites',
          pageBuilder: (context, state) => const NoTransitionPage<void>(child: FavoriteScreen()),
        ),
        GoRoute(
          path: '/account',
          pageBuilder: (context, state) {
            return const NoTransitionPage<void>(child: AccountScreen());
          },
        ),
      ],
    ),
  ], 
);




