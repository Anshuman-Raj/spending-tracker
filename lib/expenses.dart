import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spending_tracker/widgets/add_expense.dart';
import 'package:spending_tracker/charts/chart.dart';
import 'package:spending_tracker/widgets/expense_header.dart';
import 'package:spending_tracker/widgets/expenses_list.dart';
import 'package:spending_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  late final Box<Expense> _expensesBox;
  final currentMonthYear = [DateTime.now().month , DateTime.now().year];

  @override
  void initState() {
    super.initState();
    _expensesBox = Hive.box<Expense>('expenses');
  }

  void _goToPreviousMonth() {
    if (currentMonthYear[0] == 1) {
      setState(() {
        currentMonthYear[0] = 12; // Set month to December
        currentMonthYear[1] -= 1; // Decrease year by 1
      });
    } else {
    setState(() {
      currentMonthYear[0] -= 1; // Decrease month by 1
    });
  }
  }
  void _goToNextMonth() {
    if (currentMonthYear[0] == 12) {
      setState(() {
        currentMonthYear[0] = 1; // Set month to January
        currentMonthYear[1] += 1; // Increase year by 1
      });
    } else {
    setState(() {
      currentMonthYear[0] += 1; // Increase month by 1
    });
  }
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
    ScaffoldMessenger.of(context).clearSnackBars();
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
    final expenses = ExpenseBucket.forMonthYear(currentMonthYear[0], currentMonthYear[1], _expensesBox.values.toList()).expenses;
    double total = 0;
    for (var expense in expenses) {
      total += expense.amount;
    }
    return total.toStringAsFixed(2);
  }
  void _addExpense(Expense expense) {
    // persist in Hive - UI will update automatically via ValueListenableBuilder
    _expensesBox.put(expense.id, expense);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;
    final Widget children; 
    if (isLargeScreen) {
      children = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ValueListenableBuilder<Box<Expense>>(
              valueListenable: _expensesBox.listenable(),
              builder: (context, box, _) {
                final expenses = ExpenseBucket.forMonthYear(currentMonthYear[0], currentMonthYear[1], _expensesBox.values.toList()).expenses;
                return Expanded(
                  child: Column(
                    children: [
                      Chart(expenses: expenses),
                      const SizedBox(height: 16),
                      ExpenseHeader(
                        monthYear: "${monthNames[currentMonthYear[0] - 1]} ${currentMonthYear[1]}\nExpense: £${_getTotalExpenses()}", 
                        onPreviousMonth: _goToPreviousMonth, 
                        onNextMonth: _goToNextMonth),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<Box<Expense>>(
              valueListenable: _expensesBox.listenable(),
              builder: (context, box, _) {
                final expenses = ExpenseBucket.forMonthYear(currentMonthYear[0], currentMonthYear[1], box.values.toList()).expenses;
                expenses.sort((a, b) => b.date.compareTo(a.date));
                return ExpensesList(expenses, deleteExpense: _deleteExpense);
              },
            ),
          ),
        ],
      );
    }
    else {
      children = Column(
        verticalDirection: VerticalDirection.down,
        children: [
          ValueListenableBuilder<Box<Expense>>(
            valueListenable: _expensesBox.listenable(),
            builder: (context, box, _) {
              final expenses = ExpenseBucket.forMonthYear(currentMonthYear[0], currentMonthYear[1], box.values.toList()).expenses;
              return Chart(expenses: expenses);
            },
          ),
          
            ValueListenableBuilder<Box<Expense>>(
              valueListenable: _expensesBox.listenable(),
              builder: (context, box, _) {
                return ExpenseHeader(
                          monthYear: "${monthNames[currentMonthYear[0] - 1]} ${currentMonthYear[1]} Expense: £${_getTotalExpenses()}", 
                          onPreviousMonth: _goToPreviousMonth, 
                          onNextMonth: _goToNextMonth);
              },
            ),
          
          Expanded(
            child: ValueListenableBuilder<Box<Expense>>(
              valueListenable: _expensesBox.listenable(),
              builder: (context, box, _) {
                final expenses = ExpenseBucket.forMonthYear(currentMonthYear[0], currentMonthYear[1], box.values.toList()).expenses;
                expenses.sort((a, b) => b.date.compareTo(a.date));
                return ExpensesList(expenses, deleteExpense: _deleteExpense);
              },
            ),
          ),
        ],
      );
  }
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
      body: children,
    );
  }
}
