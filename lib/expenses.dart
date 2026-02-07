import 'package:flutter/material.dart';
import 'package:spending_tracker/widgets/add_expense.dart';
import 'package:spending_tracker/widgets/expenses_list.dart';
import 'package:spending_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _addedExpenses = [
  ];

  void _addExpenseInputOverlay() {
    showModalBottomSheet(context: context, builder: (ctx) {
      return AddExpense(addExpenseMethod: _addExpense,);
    });
  }

  void _addExpense(Expense expense) {
    setState(() {
      _addedExpenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spending Tracker'),
        actions: [
          IconButton(
            onPressed: _addExpenseInputOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        verticalDirection: VerticalDirection.down,
        children: [
          const Text(
            'Total Expenses Chart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(child: ExpensesList(_addedExpenses)),
        ],
      ),
    );
  }
}
