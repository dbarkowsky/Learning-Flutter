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
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  void _getItems() async {
    try {
      // Get data from Firebase
      final response = await http.get(
        Uri.https(dotenv.env['FIREBASE_URI']!, 'shopping-list.json'),
      );
      // Error checking
      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch.';
          _isLoading = false;
        });
      }

      // Possible that no data in Firebase
      // It sends a string like this if so
      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

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
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Something went wrong';
        _isLoading = false;
      });
    }
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

  void _removeItem(GroceryItem item) async {
    final response = await http.delete(
      Uri.https(dotenv.env['FIREBASE_URI']!, 'shopping-list/${item.id}.json'),
    );
    if (response.statusCode >= 400) {
      _error = 'Failed to delete';
      return;
    }
    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      // Behold this horrible ternary mess.
      body: _error != null
          ? Center(child: (Text(_error!)))
          : _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _groceryItems.isNotEmpty
          ? GroceryList(items: _groceryItems, onRemoveItem: _removeItem)
          : const Center(child: Text('Your grocery list is empty.')),
    );
  }
}
