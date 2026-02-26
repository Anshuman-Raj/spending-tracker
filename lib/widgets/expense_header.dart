import 'package:flutter/material.dart';

class ExpenseHeader extends StatelessWidget {
  const ExpenseHeader({super.key, required this.monthYear, required this.onPreviousMonth, required this.onNextMonth});
  final String monthYear;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: onPreviousMonth, icon: const Icon(Icons.arrow_back_ios)),
          Text(monthYear, style: Theme.of(context).textTheme.headlineSmall),
          IconButton(onPressed: onNextMonth, icon: const Icon(Icons.arrow_forward_ios)),
        ],
      ),
    );
  }
}
