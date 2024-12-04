import '../database/database_helper.dart';
import 'package:uuid/uuid.dart';

class BillService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Create a new bill
  Future<int> createBill({
    required String id,
    required String userId,
    required String category,
    required double amount,
    required String date,
    required String type, // Add type parameter
  }) async {
    final db = await _dbHelper.database;
    return await db.insert('Bills', {
      'id': id, // Use provided id
      'userId': userId,
      'category': category,
      'amount': amount,
      'date': date,
      'type': type, // Store type (income/expense)
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
  Future<List<Map<String, dynamic>>> getBillsByType({
    required String userId,
    required int year,
    required int month,
    required String type, // Filter by type
  }) async {
    final db = await _dbHelper.database;

    // Format date pattern as YYYY-MM
    final datePattern = '$year-${month.toString().padLeft(2, '0')}%';

    return await db.query(
      'Bills',
      where: 'userId = ? AND date LIKE ? AND type = ?',
      whereArgs: [userId, datePattern, type],
    );
  }

  Future<void> addBill({
    required String userId,
    required String category,
    required double amount,
    required DateTime date,
    required String type, // Add type parameter (income/expense)
  }) async {
    final db = await _dbHelper.database;

    // Generate a unique ID for the bill
    final String id = Uuid().v4();

    await db.insert('Bills', {
      'id': id, // Insert the unique ID
      'userId': userId,
      'category': category,
      'amount': amount,
      'date': date.toIso8601String().split('T').first, // Format as YYYY-MM-DD
      'type': type, // Insert the type (income/expense)
    });
  }
  // Delete a bill by billId
  Future<int> deleteBill(String id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'Bills',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
