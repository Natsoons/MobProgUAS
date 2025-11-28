import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/users.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
   
    String path = join(await getDatabasesPath(), 'my_app.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
       
        return db.execute(
          '''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            email TEXT,
            password TEXT
          )
          ''',
        );
      },
    );
  }

  
  Future<int> registerUser(UserModel user) async {
    Database db = await database;
    return await db.insert('users', user.toMap());
  }

 
  Future<bool> login(String email, String password) async {
    Database db = await database;
    List<Map> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return maps.isNotEmpty;
  }

 
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    Database db = await database;
    return await db.query('users');
  }

  
  Future<int> updateUser(UserModel user) async {
    Database db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }
}