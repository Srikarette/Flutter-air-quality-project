import 'package:core_ui/widgets/elements/input/search_input.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
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
  Widget build(BuildContext context) {
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
                    icon: const Icon(Icons.info_outline, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
