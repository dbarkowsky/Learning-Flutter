import 'package:uuid/uuid.dart';

final uuidGen = Uuid();

enum Category {
    FOOD,
    TRAVEL,
    LEISURE,
    WORK
}

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  // Can initialize properties with this following colon syntax
  Expense({required this.title, required this.amount, required this.date, required this.category})
    : id = uuidGen.v4();
}
