import 'package:flutter/material.dart';

class CustomSearchInput extends StatelessWidget {
  final String? placeHolder;
  final TextEditingController? controller;
  final Function(String)? onSubmitted;

  const CustomSearchInput({
    super.key,
    this.placeHolder,
    required this.controller,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 270,
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: placeHolder,
              icon: Icon(Icons.search, color: Colors.grey[700]),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller?.clear();
                },
              ),
            ),
            onSubmitted: onSubmitted,
          ),
        ),
      ],
    );
  }
}