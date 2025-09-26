import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/data/sample_data.dart';
import 'package:shopping_list_app/widgets/grocery_list.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  final List<GroceryItem> _groceryItems = [...groceryItems];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
      ),
      body: _groceryItems.isNotEmpty ? GroceryList(items: groceryItems) : const Center(
        child: Text('Your grocery list is empty.'),
      ),
    );
  }
}
