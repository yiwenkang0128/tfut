import '../database/database_helper.dart';
import '../services/category_service.dart';

class UserService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final CategoryService _categoryService = CategoryService();

  // Get user by ID
  Future<Map<String, dynamic>?> getUserById(int userId) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'Users',
      where: 'id = ?',
      whereArgs: [userId],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Get user by email
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'Users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Get user by email and password
  Future<Map<String, dynamic>?> getUserByEmailAndPassword(
      String email, String password) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'Users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Create a new user and initialize default categories
  Future<String> createUser(
      String username, String email, String password) async {
    final db = await _dbHelper.database;

    // Validate input parameters
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      throw Exception('Username, email, and password must not be empty.');
    }

    try {
      // Generate UUID for the user
      final userId = DatabaseHelper.generateUUID();

      // Insert user into the database
      await db.insert('Users', {
        'id': userId, // UUID as primary key
        'username': username,
        'email': email,
        'password': password,
      });

      // Initialize default categories for the user
      await _categoryService.initializeDefaultCategories(userId);

      print('User created successfully with ID: $userId'); // Debug log
      return userId; // Return the generated userId
    } catch (e) {
      print('Error creating user: $e'); // Debug log
      throw Exception('Failed to create user: $e');
    }
  }

  // Update user information
  Future<int> updateUser(int id,
      {String? username, String? email, String? password}) async {
    final db = await _dbHelper.database;
    Map<String, dynamic> updateFields = {};
    if (username != null) updateFields['username'] = username;
    if (email != null) updateFields['email'] = email;
    if (password != null) updateFields['password'] = password;

    return await db.update(
      'Users',
      updateFields,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete user by ID
  Future<int> deleteUser(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'Users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // List all users
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await _dbHelper.database;
    return await db.query('Users');
  }
}
