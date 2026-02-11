import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spending_tracker/widgets/add_expense.dart';
import 'package:spending_tracker/widgets/expenses_list.dart';
import 'package:spending_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  late final Box<Expense> _expensesBox;
  late List<Expense> _addedExpenses;

  @override
  void initState() {
    super.initState();
    _expensesBox = Hive.box<Expense>('expenses');
    _addedExpenses = _expensesBox.values.toList();
  }

  void _addExpenseInputOverlay() {
    showModalBottomSheet(context: context, builder: (ctx) {
      return AddExpense(addExpenseMethod: _addExpense,);
    });
  }

  void _addExpense(Expense expense) {
    // persist in Hive and update local list
    _expensesBox.add(expense);
    setState(() {
      _addedExpenses = _expensesBox.values.toList();
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
