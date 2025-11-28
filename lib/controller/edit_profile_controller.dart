import 'package:get/get.dart';
import '../model/users.dart';
import '../services/database_helper.dart';

class EditProfileController extends GetxController {
  var email = ''.obs;
  var username = ''.obs;
  var isLoading = false.obs;
  var userID = 0.obs; 
  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

 
  Future<void> loadUserData() async {
    try {
      isLoading.value = true;
      var allUsers = await DatabaseHelper().getAllUsers();
      
      if (allUsers.isNotEmpty) {
     
        var lastUser = allUsers.last;
        userID.value = lastUser['id'];
        email.value = lastUser['email'];
        username.value = lastUser['username'];
      }
    } catch (e) {
      print('Error loading user data: $e');
    } finally {
      isLoading.value = false;
    }
  }


  Future<bool> updateProfile(String newEmail, String newUsername) async {
    try {
      isLoading.value = true;
      
      
      if (newEmail.isEmpty || newUsername.isEmpty) {
        Get.snackbar('Error', 'Email dan Nama tidak boleh kosong!');
        return false;
      }

      UserModel updatedUser = UserModel(
        id: userID.value,
        username: newUsername,
        email: newEmail,
        password: '', 
      );

   
      int result = await DatabaseHelper().updateUser(updatedUser);
      
      if (result > 0) {
        email.value = newEmail;
        username.value = newUsername;
        
        Get.snackbar('Sukses', 'Profil berhasil diperbarui!');
        
        return true;
      } else {
        Get.snackbar('Error', 'Gagal memperbarui profil');
        return false;
      }
    } catch (e) {
      print('Error updating profile: $e');
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
