import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/category.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  // Creating key for form use.
  // Allows us to get the form values from other locations.
  // Also keeps form from being rebuilt, keeping internal state.
  final _formKey = GlobalKey<FormState>();

  bool _isSending = false;

  void _addItem() async {
    // Manually trigger validation of entire form.
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _isSending = true;
      // Just triggers onSave function on form fields.
      _formKey.currentState!.save();
      GroceryItem tempItem = GroceryItem(
        id: DateTime.now().toString(),
        name: _formValues['name'],
        quantity: _formValues['quantity'],
        category: _formValues['category'],
      );
      // Send to backend
      // NOTE: Firebase requires the .json ending.
      final response = await http.post(
        Uri.https(dotenv.env['FIREBASE_URI']!, 'shopping-list.json'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': tempItem.name,
          'quantity': tempItem.quantity,
          'category': tempItem.category.name,
        }),
      );
      // Return value to previous screen
      // Check if still mounted aka still visable first
      if (!context.mounted) {
        _isSending = false;
        return;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      Navigator.of(context).pop(
        GroceryItem(
          // This name is not the same as the GroceryItem name.
          // name is the property with the unique key created by Firebase
          id: responseData['name'],
          name: tempItem.name,
          quantity: tempItem.quantity,
          category: tempItem.category,
        ),
      );
    }
  }

  // For final form values
  final Map<String, dynamic> _formValues = {};

  // For dropdown state.
  // Initial value, but will be set below
  Category _selectedCategory = categories[Categories.vegetables]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Item')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: InputDecoration(label: Text('Name')),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1) {
                    return 'Item name required';
                  }
                  // This should be implicit, but the Dart compiler is concerned otherwise.
                  return null;
                },
                onSaved: (newValue) {
                  _formValues['name'] = newValue;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(label: Text('Quantity')),
                      keyboardType: TextInputType.number,
                      initialValue: '1',
                      validator: (value) {
                        if (value == null ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! < 1) {
                          return 'Quantity of 1 or more required';
                        }
                        // This should be implicit, but the Dart compiler is concerned otherwise.
                        return null;
                      },
                      onSaved: (newValue) {
                        // We already know validation has passed at this point.
                        _formValues['quantity'] = int.parse(newValue!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField(
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem<Category>(
                            value: category.value,
                            child: Row(
                              children: [
                                Icon(Icons.square, color: category.value.color),
                                const SizedBox(width: 6),
                                Text(category.value.name),
                              ],
                            ),
                          ),
                      ],
                      value: _selectedCategory,
                      onChanged: (newCategory) {
                        setState(() {
                          _selectedCategory = newCategory!;
                        });
                      },
                      onSaved: (newValue) {
                        _formValues['category'] = _selectedCategory;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Nice that this is built in to form.
                      _formKey.currentState!.reset();
                    },
                    child: Text('Reset'),
                  ),
                  ElevatedButton(
                    // Null will disable button
                    onPressed: _isSending ? null : _addItem,
                    child: _isSending
                        ? SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(),
                          )
                        : Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
