import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
// Run `flutter pub run build_runner build` to generate this file
part 'expense.g.dart';

const uuid = Uuid();
@HiveType(typeId: 0)
enum Category {
  @HiveField(0) food,
  @HiveField(1) travel,
  @HiveField(2) leisure,
  @HiveField(3) work,
  @HiveField(4) other
}

const Map<Category, IconData> categoryIcons = {
  Category.food: Icons.fastfood,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.other: Icons.category,
};

@HiveType(typeId: 1)
class Expense {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final Category category;
  @HiveField(4)
  final DateTime date;

  Expense({
    String? id,
    required this.title,
    required this.amount,
    required this.category,
    DateTime? date,
  }) : id = id?? uuid.v4(), date = date?? DateTime.now();

  String getDateString() {
    const monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return "${date.day} ${monthNames[date.month - 1]} ${date.year}";
  }
}

class ExpenseBucket {
  final List<Expense> expenses;
  final Category? category;
  final String? monthYear;

  ExpenseBucket(this.expenses, this.category, this.monthYear);
  ExpenseBucket.forCategory(Category category, List<Expense> allExpenses) 
    : expenses = allExpenses.where((expense) => expense.category == category).toList(), category = category, monthYear = null;
  ExpenseBucket.forMonthYear(int month, int year, List<Expense> allExpenses) 
    : expenses = allExpenses.where((expense) => expense.date.month == month && expense.date.year == year).toList(), category = null, monthYear = "${month.toString().padLeft(2, '0')}/$year";

  double get totalAmount {
    return expenses.fold(0, (sum, expense) => sum + expense.amount);
  }
}