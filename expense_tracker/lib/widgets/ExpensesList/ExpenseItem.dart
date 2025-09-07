import 'package:expense_tracker/models/Expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense ex;

  const ExpenseItem(this.ex, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ex.title),
            const SizedBox(height: 4,),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${ex.amount.toStringAsFixed(2)}'),
                Row(
                  children: [
                    Icon(ex.getIcon()),
                    const SizedBox(width: 8,),
                    Text(ex.getDate()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
