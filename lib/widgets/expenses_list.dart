import 'package:flutter/material.dart';
import 'package:spending_tracker/models/expense.dart';
import 'package:spending_tracker/widgets/expense_item.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> _addedExpenses;
  const ExpensesList(this._addedExpenses, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _addedExpenses.length,
      itemBuilder: (context, index) {
        final expense = _addedExpenses[index];
        return ExpenseItem(expense: expense);
      },
    );
  }
}