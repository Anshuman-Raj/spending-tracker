import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

const uuid = Uuid();
enum Category {
  food,
  travel,
  leisure,
  work,
  other
}

const Map<Category, IconData> categoryIcons = {
  Category.food: Icons.fastfood,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.other: Icons.category,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final Category category;
  final DateTime date;

  Expense({
    required this.title,
    required this.amount,
    required this.category,
  }) : id = uuid.v4(), date = DateTime.now();

  String getDateString() {
    const monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return "${date.day} ${monthNames[date.month - 1]} ${date.year}";
  }
}