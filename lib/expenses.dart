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

  @override
  void initState() {
    super.initState();
    _expensesBox = Hive.box<Expense>('expenses');
  }

  void _addExpenseInputOverlay() {
    showModalBottomSheet(isScrollControlled: true, 
    context: context, 
    builder: (ctx) {
      return Padding(
        padding: const EdgeInsets.only(top: 48.0),
        child: AddExpense(addExpenseMethod: _addExpense,),
      );
    });
  }
  void _deleteExpense(String index) { 
    final deletedExpense = _expensesBox.get(index);
    _expensesBox.delete(index); 
    ScaffoldMessenger.of(context).showSnackBar( 
      SnackBar(
        persist: false,
        action: SnackBarAction(label: 'Undo', onPressed: () {
          _expensesBox.put(index, deletedExpense!);
        }),
        backgroundColor: Colors.red.shade400,
        behavior: SnackBarBehavior.floating,
        content: const Text('Expense deleted')
        ), 
    );
  }
  String _getTotalExpenses() {
    final expenses = _expensesBox.values.toList();
    double total = 0;
    for (var expense in expenses) {
      if (expense.date.month == DateTime.now().month && expense.date.year == DateTime.now().year) {
        total += expense.amount;
      }
    }
    return total.toStringAsFixed(2);
  }
  void _addExpense(Expense expense) {
    // persist in Hive - UI will update automatically via ValueListenableBuilder
    _expensesBox.put(expense.id, expense);
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
          Text(
            'Total Expenses Chart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ValueListenableBuilder<Box<Expense>>(
            valueListenable: _expensesBox.listenable(),
            builder: (context, box, _) {
              return Text(
          'This Month\'s Total: £${_getTotalExpenses()}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    );
            },
          ),
          Expanded(
            child: ValueListenableBuilder<Box<Expense>>(
              valueListenable: _expensesBox.listenable(),
              builder: (context, box, _) {
                final expenses = box.values.toList();
                return ExpensesList(expenses, deleteExpense: _deleteExpense);
              },
            ),
          ),
        ],
      ),
    );
  }
}
