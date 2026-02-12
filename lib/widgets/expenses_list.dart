import 'package:flutter/material.dart';
import 'package:spending_tracker/models/expense.dart';
import 'package:spending_tracker/widgets/expense_item.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> _addedExpenses;
  final void Function(String) deleteExpense;
  const ExpensesList(this._addedExpenses, {super.key, required this.deleteExpense});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _addedExpenses.length,
      itemBuilder: (context, index) {
        final expense = _addedExpenses[index];
        return ExpenseItem(expense: expense, deleteExpense: deleteExpense);
      },
    );
  }
}