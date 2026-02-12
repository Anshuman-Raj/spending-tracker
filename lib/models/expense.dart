import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
// Run `flutter pub run build_runner build` to generate this file
part 'expense.g.dart';

const uuid = Uuid();
@HiveType(typeId: 0)
enum Category {
  @HiveField(0) food,
  @HiveField(1) travel,
  @HiveField(2) leisure,
  @HiveField(3) work,
  @HiveField(4) other
}

const Map<Category, IconData> categoryIcons = {
  Category.food: Icons.fastfood,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.other: Icons.category,
};

@HiveType(typeId: 1)
class Expense {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final Category category;
  @HiveField(4)
  final DateTime date;

  Expense({
    String? id,
    required this.title,
    required this.amount,
    required this.category,
    DateTime? date,
  }) : id = id?? uuid.v4(), date = date?? DateTime.now();

  String getDateString() {
    const monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return "${date.day} ${monthNames[date.month - 1]} ${date.year}";
  }
}

// Hive TypeAdapter for Expense
// class ExpenseAdapter extends TypeAdapter {
//   @override
//   final int typeId = 0;

//   @override
//   dynamic read(BinaryReader reader) {
//     final id = reader.readString();
//     final title = reader.readString();
//     final amount = reader.readDouble();
//     final categoryIndex = reader.readInt();
//     final dateMillis = reader.readInt();
//     return Expense(
//       title: title,
//       amount: amount,
//       category: Category.values[categoryIndex],
//       date: DateTime.fromMillisecondsSinceEpoch(dateMillis),
//     );
//   }

//   @override
//   void write(BinaryWriter writer, dynamic obj) {
//     final Expense exp = obj as Expense;
//     writer.writeString(exp.id);
//     writer.writeString(exp.title);
//     writer.writeDouble(exp.amount);
//     writer.writeInt(exp.category.index);
//     writer.writeInt(exp.date.millisecondsSinceEpoch);
//   }
// }