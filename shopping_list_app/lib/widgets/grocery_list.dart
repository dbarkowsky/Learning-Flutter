import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

class GroceryList extends StatelessWidget {
  final List<GroceryItem> items;
  final void Function(GroceryItem item) onRemoveItem;

  const GroceryList({super.key, required this.items, required this.onRemoveItem});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(items[index].id),
        onDismissed: (direction) {
          onRemoveItem(items[index]);
        },
        child: ListTile(
          title: Text(items[index].name),
          leading: Icon(Icons.square, color: items[index].category.color),
          trailing: Text(items[index].quantity.toString()),
        ),
      ),
    );
  }
}
