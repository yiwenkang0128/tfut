import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';

class BudgetService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<int?> getBudgetForMonth(int year, int month) async {
    final db = await DatabaseHelper.instance.database;

    // Format month to 2 digits
    final monthStr = month.toString().padLeft(2, '0');
    final yearMonth = '$year-$monthStr';

    final result = await db.query(
      'Budgets',
      where: "date LIKE ?",
      whereArgs: ['$yearMonth%'],
    );

    if (result.isNotEmpty) {
      return result.first['amount'] as int;
    }
    return null;
  }

  Future<int> setBudgetForMonth(int year, int month, int amount) async {
    final db = await _dbHelper.database;
    return await db.insert(
      'Budgets',
      {
        'year': year,
        'month': month,
        'amount': amount,
      },
      conflictAlgorithm: ConflictAlgorithm.replace, // 如果存在相同记录则覆盖
    );
  }
}
