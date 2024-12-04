import '../database/database_helper.dart';

class OverviewService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<Map<String, dynamic>> getOverviewData(
      int year, int month, String view) async {
    final db = await _dbHelper.database;

    // Fetch expenditure, income, and categorized data from the database
    final expenditureResult = await db.rawQuery(
        'SELECT SUM(amount) as total FROM Bills WHERE type = "Expense" AND year = ? AND month = ?',
        [year, month]);
    final incomeResult = await db.rawQuery(
        'SELECT SUM(amount) as total FROM Bills WHERE type = "Income" AND year = ? AND month = ?',
        [year, month]);

    final categorizedResult = await db.rawQuery(
        'SELECT category, SUM(amount) as total FROM Bills WHERE type = "Expense" AND year = ? AND month = ? GROUP BY category',
        [year, month]);

    return {
      'expenditure': expenditureResult.first['total'] ?? 0.0,
      'income': incomeResult.first['total'] ?? 0.0,
      'balance': ((incomeResult.first['total'] as num?)?.toDouble() ?? 0.0) -
          ((expenditureResult.first['total'] as num?)?.toDouble() ?? 0.0),
      'categorizedExpenditure': {
        for (var item in categorizedResult)
          item['category'] as String: (item['total'] as num).toDouble()
      },
    };
  }
}
