import 'package:flutter/material.dart';

class ExpenseHeader extends StatelessWidget {
  const ExpenseHeader({super.key, required this.monthYear, required this.onPreviousMonth, required this.onNextMonth});
  final String monthYear;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    List<String> monthYearList = [monthYear];
    if (width > 600) {
      monthYearList = monthYear.split('\n');
      return SizedBox(
      height: MediaQuery.of(context).size.height * 0.17,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(onPressed: onPreviousMonth, icon: const Icon(Icons.arrow_back_ios)),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(monthYearList[0], style: Theme.of(context).textTheme.labelLarge, overflow: TextOverflow.ellipsis),
                Text(monthYearList[1], style: Theme.of(context).textTheme.labelLarge, overflow: TextOverflow.ellipsis)
              ],
            ),
          ),
          
          IconButton(onPressed: onNextMonth, icon: const Icon(Icons.arrow_forward_ios)),
        ],
      ),
          );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: onPreviousMonth, icon: const Icon(Icons.arrow_back_ios)),
          Flexible(child: Text(monthYear, style: Theme.of(context).textTheme.labelLarge, overflow: TextOverflow.ellipsis)),
          IconButton(onPressed: onNextMonth, icon: const Icon(Icons.arrow_forward_ios)),
        ],
      ),
    );
  }
}
