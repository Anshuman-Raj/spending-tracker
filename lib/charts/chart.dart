import 'package:flutter/material.dart';
import 'package:spending_tracker/models/expense.dart';
import 'package:spending_tracker/charts/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});
  final List<Expense> expenses;
  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(Category.food, expenses),
      ExpenseBucket.forCategory(Category.leisure, expenses),
      ExpenseBucket.forCategory(Category.travel, expenses),
      ExpenseBucket.forCategory(Category.work, expenses),
      ExpenseBucket.forCategory(Category.other, expenses),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalAmount > maxTotalExpense) {
        maxTotalExpense = bucket.totalAmount;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final chartBarWidgets = <ChartBar>[];

    for (final bucket in buckets) {
      final totalAmount = bucket.totalAmount;
      final double percentage = maxTotalExpense == 0 ? 0 : totalAmount / maxTotalExpense;
      chartBarWidgets.add(ChartBar(category: bucket.category!, amount: totalAmount, percentage: percentage));
    }
    final height = MediaQuery.of(context).size.height * 0.25;
    return Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    // Define a height so it doesn't take up half the screen
    height: height, 
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(6),
      boxShadow: [
        const BoxShadow(
          color: Color.fromARGB(127, 156, 39, 176),
          blurRadius: 4,
          offset: Offset(5, 2),
        ),
      ],
    ),
    // REMOVED Center widget here
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end, // Align bars to the bottom
      children: chartBarWidgets,
    ),
  );
}
}