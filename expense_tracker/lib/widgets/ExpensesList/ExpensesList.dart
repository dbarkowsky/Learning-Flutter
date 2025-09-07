import 'package:expense_tracker/models/Expense.dart';
import 'package:expense_tracker/widgets/ExpensesList/ExpenseItem.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpensesList({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    // Don't use Column for lists when you don't know the length. Not efficient
    // We use anonymous function to build the expense widget
    return ListView.builder(
      itemBuilder: (context, index) => ExpenseItem(expenses[index]),
      itemCount: expenses.length,
    );
  }
}
