import 'package:expense_tracker/models/Expense.dart';
import 'package:expense_tracker/widgets/ExpensesList/ExpensesList.dart';
import 'package:expense_tracker/widgets/NewExpense.dart';
import 'package:expense_tracker/widgets/chart/Chart.dart';
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

  void _addExpense(Expense ex) {
    setState(() {
      _registeredExpenses.add(ex);
    });
  }

  void _removeExpense(Expense ex) {
    // Track where expense was in case we want to undo
    int expenseIndex = _registeredExpenses.indexOf(ex);
    setState(() {
      _registeredExpenses.remove(ex);
    });
    // Another util from Flutter
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Expense removed"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(label: "Undo", onPressed: (){
          setState(() {
            _registeredExpenses.insert(expenseIndex, ex);
          });
        }),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return NewExpense(onAddExpense: _addExpense);
      },
      isScrollControlled: true,
      useSafeArea: true, // Determined by device
    );
  }

  @override
  Widget build(BuildContext context) {
    // For reactive main content
    Size screen = MediaQuery.of(context).size;

    Widget mainContent = Center(child: Text("No expenses found."));

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    // NOTE: Scaffold has default max height and width of screen size
    // So that constrains the Row and Column widgets inside it, that have infinite maximums in theory.
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: screen.width < 600 ? Column(
        children: [
          Chart(expenses: _registeredExpenses,),
          // Why Expanded? Column doesn't handle size of list otherwise.
          // Also restricts to available space. Otherwise list will be infinite height
          Expanded(child: mainContent),
        ],
      ) : Row(
        children: [
          Expanded(child: Chart(expenses: _registeredExpenses,)),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
