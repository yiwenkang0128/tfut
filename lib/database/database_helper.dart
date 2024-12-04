import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
import 'models/user_table.dart';
import 'models/bill_table.dart';
import 'models/budget_table.dart';
import 'models/category_table.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();
  static const _uuid = Uuid();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');
    await deleteDatabase(path);
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onConfigure: _onConfigure,
      onCreate: (db, version) async {
        await _createTables(db);
        await _createIndexes(db);
      },
    );
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _createTables(Database db) async {
    await UserTable.create(db);
    await BillTable.create(db);
    await BudgetTable.create(db);
    await CategoryTable.create(db);
  }

  Future<void> _createIndexes(Database db) async {
    await db
        .execute('CREATE INDEX idx_categories_userId ON Categories (userId)');
    await db.execute('CREATE INDEX idx_bills_userId ON Bills (userId)');
    await db.execute('CREATE INDEX idx_budgets_userId ON Budgets (userId)');
  }

  static String generateUUID() {
    return _uuid.v4();
  }
}
