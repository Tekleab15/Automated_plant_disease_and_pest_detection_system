import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'users.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create users table
    await db.execute(
      '''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL,
        password TEXT NOT NULL
      )
      ''',
    );

    // Create recommendations table
    await db.execute('''
      CREATE TABLE recommendations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        plantType TEXT,
        imagePath TEXT
      )
      ''');
  }

  // Handle database upgrade
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add the recommendations table if upgrading from version 1 to version 2
      await db.execute('''
        CREATE TABLE recommendations (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          plantType TEXT,
          imagePath TEXT
        )
        ''');
    }
  }

  // Insert user data
  Future<void> insertUser(String email, String password) async {
    final db = await database;
    await db.insert('users', {'email': email, 'password': password});
  }

  // Insert recommendation data
  Future<void> insertRecommendation(String plantType, String imagePath) async {
    final db = await database;
    await db.insert(
        'recommendations', {'plantType': plantType, 'imagePath': imagePath});
  }

  // Retrieve user data
  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    final db = await database;
    List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (users.isNotEmpty) {
      return users.first;
    }
    return null;
  }

  // Retrieve recommendation data
  Future<List<Map<String, dynamic>>> getRecommendations() async {
    final db = await database;
    return await db.query('recommendations');
  }
}
