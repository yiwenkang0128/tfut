import '../database/database_helper.dart';
import 'package:uuid/uuid.dart';
import 'package:sqflite/sqflite.dart';

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

    // Generate a unique ID for the category
    final String id = const Uuid().v4();

    return await db.insert(
      'Categories',
      {
        'id': id, // Unique ID for the category
        'userId': userId,
        'name': name,
        'type': type,
      },
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace if conflict occurs
    );
  }

  // Delete a category by its ID
  Future<int> deleteCategoryById(String id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'Categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete a category by userId, name, and type
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
      await db.insert(
        'Categories',
        {
          'id': const Uuid().v4(), // Generate unique ID
          'userId': userId,
          'name': category,
          'type': 'Expense',
        },
        conflictAlgorithm: ConflictAlgorithm.replace, // Replace on conflict
      );
    }

    // Add income categories
    for (final category in incomeCategories) {
      await db.insert(
        'Categories',
        {
          'id': const Uuid().v4(), // Generate unique ID
          'userId': userId,
          'name': category,
          'type': 'Income',
        },
        conflictAlgorithm: ConflictAlgorithm.replace, // Replace on conflict
      );
    }
  }
}
