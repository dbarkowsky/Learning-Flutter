import 'package:flutter/material.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
      ),
      body: const Center(
        child: Text('Your grocery list is empty.'),
      ),
    );
  }
}
