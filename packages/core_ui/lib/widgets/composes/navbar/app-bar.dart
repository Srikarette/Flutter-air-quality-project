import 'package:core_ui/theme/theme_provider.dart';
import 'package:core_ui/theme/theme_state.dart';
import 'package:core_ui/widgets/elements/input/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final TextEditingController? searchController;
  final Function(String)? onSearchSubmitted;

  const CustomAppBar({
    Key? key,
    this.searchController,
    this.onSearchSubmitted,
  }) : preferredSize = const Size.fromHeight(80.0); // Increased preferred size

  @override
  Widget build (BuildContext context, WidgetRef ref) {

    final themeNotifier = ref.read(appThemeProvider.notifier);
    final themeProvider = ref.watch(appThemeProvider);
    return AppBar(
      backgroundColor: const Color.fromRGBO(29, 196, 250, 1),
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  CustomSearchInput(
                    placeHolder: 'Search city',
                    controller: searchController,
                    onSubmitted: onSearchSubmitted,
                  ),
                  const Spacer(),
                   IconButton(
                onPressed: themeNotifier.switchTheme,
                icon: Icon(
                  themeProvider.selectedTheme == Themes.light
                   ? Icons.dark_mode
                   : Icons. light_mode,
                  size: 40,
                  color: themeProvider.selectedTheme == Themes.light
                  ? Colors.black
                 : Colors.white,
                )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
