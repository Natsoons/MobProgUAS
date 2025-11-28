import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/users.dart';
import '../services/database_helper.dart';

class SignupController extends GetxController {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<bool> signup(String username, String email, String password) async {
    try {
      isLoading.value = true;

      // Validasi input
      if (username.isEmpty || email.isEmpty || password.isEmpty) {
        Get.snackbar('Error', 'Semua field harus diisi!');
        return false;
      }

      // Cek email sudah terdaftar atau belum
      var allUsers = await DatabaseHelper().getAllUsers();
      bool emailExists = allUsers.any((user) => user['email'] == email);

      if (emailExists) {
        Get.snackbar('Error', 'Email sudah terdaftar!');
        return false;
      }

      // Buat user baru
      UserModel newUser = UserModel(
        username: username,
        email: email,
        password: password,
      );

      // Simpan ke database
      int result = await DatabaseHelper().registerUser(newUser);

      if (result > 0) {
        Get.snackbar('Sukses', 'Signup berhasil! Silakan login');
        
        // Clear text field
        usernameController.clear();
        emailController.clear();
        passwordController.clear();
        
        return true;
      } else {
        Get.snackbar('Error', 'Gagal membuat akun');
        return false;
      }
    } catch (e) {
      print('Error signup: $e');
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
