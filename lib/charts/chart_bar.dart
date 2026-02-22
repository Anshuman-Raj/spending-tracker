import 'package:flutter/material.dart';
import 'package:spending_tracker/models/expense.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key, required this.category, required this.amount, required this.percentage});
  final Category category;
  final double amount;
  final double percentage;
  
  

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.15;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('£${amount.toStringAsFixed(2)}', style: Theme.of(context).textTheme.labelSmall),
          Container(
            width: 20,
            height: height * percentage,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 4),
          Icon(categoryIcons[category], color: Theme.of(context).colorScheme.primary, semanticLabel: category.name,),
        ],
      ),
    );
  }
}