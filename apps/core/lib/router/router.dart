import 'package:core/layouts/navbar.dart';
import 'package:go_router/go_router.dart';
import 'package:product/features/home/screen/home_screen.dart';
import 'package:product/features/home/screen/test_get_keyword_location_screen.dart';
import 'package:product/features/map/screen/map_screen.dart';

final routes = ['home', 'maps', 'ranks'];

final router = GoRouter(routes: [
  ShellRoute(
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
            child: BottomNavigation(
          location: state.matchedLocation,
          child: child,
        ));
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/maps',
          name: 'maps',
          builder: (context, state) => const MapScreen(),
        ),
        GoRoute(
          path: '/ranks',
          name: 'ranks',
          builder: (context, state) => const KeyWordLocationTestScreen(),
        ),
      ]),
]);
