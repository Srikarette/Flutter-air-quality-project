import 'package:flutter/material.dart';

class ManageScreen extends StatelessWidget {
  const ManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage'),
      ),
      body: Center(
        child: Text(
          'This is the Manage screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}