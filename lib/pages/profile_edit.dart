import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/edit_profile_controller.dart'; 

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final EditProfileController controller = Get.put(EditProfileController());
    final emailController = TextEditingController();
    final usernameController = TextEditingController();

    return Obx(() {
      
      if (emailController.text.isEmpty && controller.email.value.isNotEmpty) {
        emailController.text = controller.email.value;
      }
      if (usernameController.text.isEmpty && controller.username.value.isNotEmpty) {
        usernameController.text = controller.username.value;
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                    
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(height: 20),

                     
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: "Nama",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 30),

                     
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () async {
                                  final bool success = await controller
                                      .updateProfile(
                                    emailController.text,
                                    usernameController.text,
                                  );

                                  if (success) {
                                    Future.delayed(const Duration(seconds: 1),
                                        () {
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "Simpan",
                                  style: TextStyle(fontSize: 16),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}