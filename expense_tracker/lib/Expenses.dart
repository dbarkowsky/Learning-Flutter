import 'package:expense_tracker/models/Expense.dart';
import 'package:expense_tracker/widgets/ExpensesList/ExpensesList.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "vacation",
      amount: 122,
      date: DateTime(2023, 2, 5),
      category: Category.TRAVEL,
    ),
    Expense(
      title: "candy",
      amount: 344,
      date: DateTime.now(),
      category: Category.FOOD,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("My Expenses"),
          // Why Expanded? Column doesn't handle size of list otherwise.
          Expanded(child: ExpensesList(expenses: _registeredExpenses)),
        ],
      ),
    );
  }
}
