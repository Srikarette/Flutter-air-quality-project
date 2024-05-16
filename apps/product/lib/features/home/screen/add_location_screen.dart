import 'package:flutter/material.dart';

class AddLocationScreen extends StatelessWidget {
  const AddLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Location'),
        backgroundColor: const Color.fromRGBO(29, 196, 250, 1),
      ),
      body: const Center(
        child: Text(
          'This is the Add Location screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}