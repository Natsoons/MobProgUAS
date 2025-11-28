import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/database_helper.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late TextEditingController emailController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<bool> resetPassword(String email, String newPassword, String confirmPassword) async {
    try {
      setState(() => isLoading = true);

      if (email.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
        Get.snackbar('Error', 'Semua field harus diisi');
        return false;
      }

      if (newPassword != confirmPassword) {
        Get.snackbar('Error', 'Password dan konfirmasi tidak sama');
        return false;
      }

      // Cari user by email
      var users = await DatabaseHelper().getAllUsers();
      var matched = users.where((u) => u['email'] == email).toList();
      if (matched.isEmpty) {
        Get.snackbar('Error', 'Email tidak ditemukan');
        return false;
      }

      int userId = matched.first['id'];

      int updated = await DatabaseHelper().updatePassword(userId, newPassword);
      if (updated > 0) {
        Get.snackbar('Sukses', 'Password berhasil direset');
        emailController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        return true;
      } else {
        Get.snackbar('Error', 'Gagal mereset password');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
      return false;
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Reset Password"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Masukkan email dan password baru Anda",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 20.0),

                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        prefixIcon: const Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12.0),

                    TextField(
                      controller: newPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password Baru",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 12.0),

                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Konfirmasi Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                bool success = await resetPassword(
                                  emailController.text.trim(),
                                  newPasswordController.text,
                                  confirmPasswordController.text,
                                );

                                if (success) {
                                  Future.delayed(const Duration(milliseconds: 800), () {
                                    Navigator.pop(context);
                                  });
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text("Reset Password"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}