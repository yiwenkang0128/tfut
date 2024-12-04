import '../database/database_helper.dart';

class CategoryService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Get categories by userId and type
  Future<List<String>> getCategoriesByUserAndType(String userId, String type) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'Categories',
      where: 'userId = ? AND type = ?',
      whereArgs: [userId, type],
    );
    return result.map((row) => row['name'] as String).toList();
  }

  // Add a new category
  Future<int> addCategory(String userId, String name, String type) async {
    final db = await _dbHelper.database;
    return await db.insert('Categories', {
      'userId': userId,
      'name': name,
      'type': type,
    });
  }

  // Delete a category
  Future<int> deleteCategory(String userId, String name, String type) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'Categories',
      where: 'userId = ? AND name = ? AND type = ?',
      whereArgs: [userId, name, type],
    );
  }

  // Initialize default categories for a user
  Future<void> initializeDefaultCategories(String userId) async {
    final db = await _dbHelper.database;

    final expenseCategories = [
      'Meals',
      'Clothes',
      'Travel',
      'Pets',
      'Daily Necessities',
      'Housing',
      'Medical',
      'Entertainment',
      'Others',
    ];

    final incomeCategories = [
      'Transfer',
      'Salary',
      'Refund',
      'Gift',
      'Others',
    ];

    // Add expense categories
    for (final category in expenseCategories) {
      await db.insert('Categories', {
        'userId': userId,
        'name': category,
        'type': 'Expense',
      });
    }

    // Add income categories
    for (final category in incomeCategories) {
      await db.insert('Categories', {
        'userId': userId,
        'name': category,
        'type': 'Income',
      });
    }
  }
}
