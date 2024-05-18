import 'package:core/router/router.dart';
import 'package:core_ui/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation extends StatefulWidget {
  final String location;
  final Widget child;

  const BottomNavigation(
      {super.key, required this.child, required this.location});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  void onTap(BuildContext context, int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    context.goNamed(routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final color = ref.watch(appThemeProvider).themeColor;
      return Scaffold(
        body: widget.child,
        bottomNavigationBar: ClipRRect(
          child: Container(
            decoration: BoxDecoration(
              color: color.backgroundPrimary, // ใส่สีพื้นหลังตาม theme
            ),
            child: BottomNavigationBar(
              backgroundColor: color.backgroundSecondary,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                onTap(context, index);
              },
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.map_rounded),
                  label: 'Map',
                ),
              ],
              selectedItemColor: color.backgroundSky,
              selectedLabelStyle: TextStyle(fontSize: 15),
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: TextStyle(fontSize: 12),
            ),
          ),
        ),
      );
    });
  }
}
