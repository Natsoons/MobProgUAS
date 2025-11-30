import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB('app_v6.db');
    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 6,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          email TEXT UNIQUE,
          password TEXT,
          profile_image TEXT
        )
      ''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS bookings (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          email TEXT,
          guest_name TEXT,
          hotel_name TEXT,
          hotel_id TEXT,
          checkin TEXT,
          checkout TEXT,
          nights INTEGER,
          guests INTEGER,
          total REAL
        )
      ''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS reviews (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          email TEXT,
          hotel_id TEXT,
          name TEXT,
          rating INTEGER,
          comment TEXT,
          date TEXT
        )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 6) {
          await db.execute("ALTER TABLE bookings ADD COLUMN guest_name TEXT");
        }
      },
    );
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final res = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    if (res.isNotEmpty) return res.first;
    return null;
  }

  Future<Map<String, dynamic>?> getUserByEmailAndPassword(
    String email,
    String password,
  ) async {
    final db = await database;
    final res = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
      limit: 1,
    );
    if (res.isNotEmpty) return res.first;
    return null;
  }

  Future<int> insertBooking(Map<String, dynamic> booking) async {
    final db = await database;
    return await db.insert(
      'bookings',
      booking,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getBookingsByEmail(String email) async {
    final db = await database;
    final res = await db.query(
      'bookings',
      where: 'email = ?',
      whereArgs: [email],
      orderBy: 'id DESC',
    );
    return res;
  }

  Future<int> updateUserByEmail(
    String email,
    Map<String, dynamic> fields,
  ) async {
    final db = await database;
    return await db.update(
      'users',
      fields,
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  Future<int> deleteBookingById(int id) async {
    final db = await database;
    return await db.delete('bookings', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertReview(Map<String, dynamic> review) async {
    final db = await database;
    return await db.insert(
      'reviews',
      review,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateReview(
    String email,
    String hotelId,
    Map<String, dynamic> review,
  ) async {
    final db = await database;
    return await db.update(
      'reviews',
      review,
      where: 'email = ? AND hotel_id = ?',
      whereArgs: [email, hotelId],
    );
  }

  Future<List<Map<String, dynamic>>> getReviewsByHotel(String hotelId) async {
    final db = await database;
    return await db.rawQuery(
      '''
      SELECT 
        reviews.id, 
        reviews.email, 
        reviews.hotel_id, 
        reviews.rating, 
        reviews.comment, 
        reviews.date, 
        COALESCE(users.name, reviews.name) as name, 
        users.profile_image 
      FROM reviews 
      LEFT JOIN users ON reviews.email = users.email 
      WHERE reviews.hotel_id = ?
      ORDER BY reviews.id DESC
    ''',
      [hotelId],
    );
  }

  Future<double> getAverageRating(String hotelId) async {
    final db = await database;
    final res = await db.rawQuery(
      'SELECT AVG(rating) as avg_rating FROM reviews WHERE hotel_id = ?',
      [hotelId],
    );
    if (res.isNotEmpty && res.first['avg_rating'] != null) {
      return (res.first['avg_rating'] as num).toDouble();
    }
    return 0.0;
  }
}