import 'package:expense_tracker/models/Expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense ex) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // Used to save fields
  final _titleController = TextEditingController(text: '');
  final _amountController = TextEditingController(text: '');
  DateTime _selectedDate = DateTime.now();
  Category _selectedCategory = Category.FOOD;

  // Need to dispose the controllers specifically, otherwise could leak memory.
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      initialDate: _selectedDate,
    );
    setState(() {
      if (pickedDate != null) {
        _selectedDate = pickedDate;
      }
    });
  }

  void _submitExpenseData() {
    // Adding some validation
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty || amountIsInvalid) {
      // Show this dialog on failure then return.
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: Text("Must have a title and valid amount."),
          title: Text("Validation Error"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text("Close"),
            ),
          ],
        ),
      );
      return;
    }
    // Save the entry.
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.fromLTRB(16, 48, 16, 16),
      child: Column(
        spacing: 10,
        children: [
          TextField(
            decoration: InputDecoration(label: Text('Title')),
            maxLength: 50,
            controller: _titleController,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    label: Text('Amount'),
                    prefixText: '\$ ',
                  ),
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(dateFormatter.format(_selectedDate)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  ); // Remove current context from view-like stack
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: Text("Save"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
