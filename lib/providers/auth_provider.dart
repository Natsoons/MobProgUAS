import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:mobprog_uas/model/users.dart';
import 'package:mobprog_uas/services/db_helper.dart';

class AuthProvider extends ChangeNotifier {
  final DBHelper _db = DBHelper();
  User? _user;

  User? get user => _user;

  bool get isLoggedIn => _user != null;

  Future<bool> register(String name, String email, String password) async {
    if (name.trim().isEmpty || email.trim().isEmpty || password.isEmpty) return false;
    final existing = await _db.getUserByEmail(email);
    if (existing != null) return false;

    final hashed = _hashPassword(password, email);
    final id = await _db.insertUser({'name': name, 'email': email, 'password': hashed});
    if (id > 0) {
      _user = User(name: name, email: email);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> login(String email, String password) async {
    final hashed = _hashPassword(password, email);
    final row = await _db.getUserByEmailAndPassword(email, hashed);
    if (row != null) {
      _user = User(name: row['name'] ?? '', email: row['email'] ?? '');
      notifyListeners();
      return true;
    }
    return false;
  }

  String _hashPassword(String password, String salt) {
    final bytes = utf8.encode(password + salt);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  Future<bool> updateProfile({required String name}) async {
    if (_user == null) return false;
    final email = _user!.email;
    final rows = await _db.updateUserByEmail(email, {'name': name});
    if (rows > 0) {
      _user = User(name: name, email: email);
      notifyListeners();
      return true;
    }
    return false;
  }
}
