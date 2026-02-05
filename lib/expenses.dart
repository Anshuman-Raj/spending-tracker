import 'package:flutter/material.dart';
import 'package:spending_tracker/expenses_list.dart';
import 'package:spending_tracker/model/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _addedExpenses = [
    Expense(
      title: 'Lunch',
      amount: 9.99,
      category: Category.food,
    ),

    Expense(
      title: 'Cinema',
      amount: 15.00,
      category: Category.leisure,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spending Tracker'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: ExpensesList(_addedExpenses),
    );
  }
}
