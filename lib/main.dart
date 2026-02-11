import 'package:flutter/material.dart';
import 'package:spending_tracker/expenses.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:spending_tracker/models/expense.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Initialize Hive for Flutter
  await Hive.initFlutter();
  // Register Expense adapter so we can store Expense objects directly
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  
  // 2. Open a "Box" (like a table)
  await Hive.openBox<Expense>('expenses');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Expenses(),
    );
  }
}
