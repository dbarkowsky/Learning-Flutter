import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/grocery_list.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  List<GroceryItem> _groceryItems = [];

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  void _getItems() async {
    // Get data from Firebase
    final response = await http.get(
      Uri.https(dotenv.env['FIREBASE_URI']!, 'shopping-list.json'),
    );
    // Set state with these items
    final Map<String, dynamic> listData = json.decode(response.body);
    List<GroceryItem> tempList = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere((cat) => cat.value.name == item.value['category'])
          .value;
      tempList.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }
    setState(() {
      _groceryItems = tempList;
    });
  }

  void _addItem() async {
    final newItem = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => const NewItem()));
    if (newItem == null) return;

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    _groceryItems.remove(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: _groceryItems.isNotEmpty
          ? GroceryList(items: _groceryItems, onRemoveItem: _removeItem)
          : const Center(child: Text('Your grocery list is empty.')),
    );
  }
}
