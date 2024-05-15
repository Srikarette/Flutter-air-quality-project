import 'package:core/layouts/navbar.dart';
import 'package:go_router/go_router.dart';
import 'package:product/features/home/screen/home_screen.dart';
import 'package:product/features/map/home/screen/map_screen.dart';

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
          builder: (context, state) => const MapScreen(title: 'Map Screen'),
        ),
        GoRoute(
          path: '/ranks',
          name: 'ranks',
          builder: (context, state) => const MapScreen(title: 'Rank Screen'),
        ),
      ]),
]);
