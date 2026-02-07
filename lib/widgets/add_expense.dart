import 'package:flutter/material.dart';
import 'package:spending_tracker/models/expense.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key, required this.addExpenseMethod});

  final void Function(Expense) addExpenseMethod;

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  Category? _selectedCategory;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitExpense() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text.trim());
    final category = _selectedCategory;
    final date = _selectedDate;

    if (title.isEmpty ||
        amount == null ||
        amount <= 0 ||
        category == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields correctly')),
      );
      return;
    }

    final expense = Expense(title: title, amount: amount, category: category, date: date);

    widget.addExpenseMethod(expense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  // const Text('Expense Title:'),
                  // const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      maxLength: 50,
                      controller: _titleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter expense title',
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Row(
                children: [
                  // const Text('Expense Amount:'),
                  // const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      maxLength: 50,
                      controller: _amountController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter expense amount',
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  // Flexible(child: const Text('Expense Category:')),
                  // const SizedBox(width: 8),
                  Flexible(
                    child: DropdownButtonFormField<Category>(
                      hint: const Text("Select Category"),
                      initialValue: _selectedCategory,
                      items: Category.values.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  
                  
                  Flexible(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: [
                          const SizedBox(width: 32),
                          const Text("Select Date:"),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.calendar_today),
                            iconSize: 48,
                            onPressed: () async {
                              final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _selectedDate = pickedDate;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitExpense,
                child: const Text('Add Expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
