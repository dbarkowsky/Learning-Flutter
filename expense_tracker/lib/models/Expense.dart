import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final uuidGen = Uuid();
final dateFormatter = DateFormat.yMMMd();

enum Category {
    FOOD,
    TRAVEL,
    LEISURE,
    WORK
}

const categoryIcons = {
  Category.FOOD: Icons.lunch_dining,
  Category.LEISURE: Icons.movie,
  Category.TRAVEL: Icons.flight,
  Category.WORK: Icons.work
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  // Can initialize properties with this following colon syntax
  Expense({required this.title, required this.amount, required this.date, required this.category})
    : id = uuidGen.v4();

  IconData getIcon(){
    return  categoryIcons[category] ?? Icons.error;
  }

  String getDate(){
    return dateFormatter.format(date);
  }
}
