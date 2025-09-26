import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

class GroceryList extends StatelessWidget {
  final List<GroceryItem> items;

  const GroceryList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (ctx, index) => ListTile(
        title: Text(items[index].name),
        leading: Icon(Icons.square, color: items[index].category.color),
        trailing: Text(items[index].quantity.toString()),
      ),
    );
  }
}
