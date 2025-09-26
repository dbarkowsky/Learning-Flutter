import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/data/sample_data.dart';
import 'package:shopping_list_app/widgets/grocery_list.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  final List<GroceryItem> _groceryItems = [...groceryItems];

  void _addItem() async {
    final GroceryItem? item = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => const NewItem()));
    if (item == null) return;
    setState(() {
      _groceryItems.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: _groceryItems.isNotEmpty
          ? GroceryList(items: _groceryItems)
          : const Center(child: Text('Your grocery list is empty.')),
    );
  }
}
