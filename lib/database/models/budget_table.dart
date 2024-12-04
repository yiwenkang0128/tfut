import 'package:sqflite/sqflite.dart';

class BudgetTable {
  static const String tableName = 'Budgets';

  static Future<void> create(Database db) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        category TEXT NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        FOREIGN KEY (userId) REFERENCES Users (id)
      )
    ''');
  }
}
