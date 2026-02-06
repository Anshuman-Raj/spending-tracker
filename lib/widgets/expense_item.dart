import 'package:flutter/material.dart';
import 'package:spending_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {

  const ExpenseItem({super.key, required this.expense});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.purple.shade100,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(127, 156, 39, 176),
              blurRadius: 4,
              offset: const Offset(5, 2),
            ),
          ],
        ),
        child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(6),
            ),
            // Icon based on the category of the expense with color grey
            child: Icon(
              categoryIcons[expense.category],
              color: const Color.fromARGB(255, 179, 171, 171),
              semanticLabel: expense.category.name,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name of the expense with bold font and size 16
                Text(
                  expense.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                //expense amount with 2 decimal places
                Text(
                  '£${expense.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Text(
            expense.getDateString(),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
            ),
          ),
        ],
      ),
      ),
    );
  }
  
  
}