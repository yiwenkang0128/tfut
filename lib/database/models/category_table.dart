import 'package:sqflite/sqflite.dart';

class CategoryTable {
  static const String tableName = 'Categories';

  static Future<void> create(Database db) async {
    await db.execute('''
      CREATE TABLE $tableName (
      id TEXT PRIMARY KEY,
      userId TEXT NOT NULL,
      name TEXT NOT NULL,
      type TEXT NOT NULL,
      UNIQUE(userId, name, type) ON CONFLICT REPLACE,
      FOREIGN KEY (userId) REFERENCES Users (id)
      )
    ''');
  }
}
