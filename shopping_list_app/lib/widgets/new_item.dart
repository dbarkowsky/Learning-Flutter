import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/category.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

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

  void _addItem() {
    // Manually trigger validation of entire form.
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      // Just triggers onSave function on form fields.
      _formKey.currentState!.save();
      // Return value to previous screen
      Navigator.of(context).pop(
        GroceryItem(
          id: DateTime.now().toString(),
          name: _formValues['name'],
          quantity: _formValues['quantity'],
          category: _formValues['category'],
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
                  ElevatedButton(onPressed: _addItem, child: Text('Submit')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
