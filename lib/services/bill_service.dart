import '../database/database_helper.dart';

class BillService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Create a new bill
  Future<int> createBill(
      String userId, String category, double amount, String date) async {
    final db = await _dbHelper.database;
    return await db.insert('Bills', {
      'userId': userId,
      'category': category,
      'amount': amount,
      'date': date,
    });
  }

  // Get all bills by userId
  Future<List<Map<String, dynamic>>> getBillsByUser(String userId) async {
    final db = await _dbHelper.database;
    return await db.query(
      'Bills',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  // Get bills by year and month
  Future<List<Map<String, dynamic>>> getBillsByDate({
    required String userId,
    required int year,
    required int month,
  }) async {
    final db = await _dbHelper.database;

    // Format date pattern as YYYY-MM
    final datePattern = '$year-${month.toString().padLeft(2, '0')}%';

    return await db.query(
      'Bills',
      where: 'userId = ? AND date LIKE ?',
      whereArgs: [userId, datePattern],
    );
  }

  // Get bills by month
  Future<List<Map<String, dynamic>>> getBillsByMonth(
      int year, int month, String userId) async {
    final db = await DatabaseHelper.instance.database;

    // Format month to 2 digits (e.g., 01, 02)
    final monthStr = month.toString().padLeft(2, '0');
    final yearMonth = '$year-$monthStr';

    // Query bills using LIKE to match the year and month
    final result = await db.query(
      'Bills',
      where: "date LIKE ? AND userId = ?",
      whereArgs: ['$yearMonth%', userId],
    );
    return result;
  }

  // Add a new bill
  Future<void> addBill({
    required String userId,
    required String category,
    required double amount,
    required DateTime date,
  }) async {
    final db = await DatabaseHelper.instance.database;

    await db.insert('Bills', {
      'userId': userId,
      'category': category,
      'amount': amount,
      'date': date.toIso8601String().split('T').first, // Format as YYYY-MM-DD
    });
  }

  // Delete a bill by billId
  Future<int> deleteBill(int billId) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'Bills',
      where: 'id = ?',
      whereArgs: [billId],
    );
  }
}
