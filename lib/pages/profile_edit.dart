import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/edit_profile_controller.dart'; 

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController imageUrlController;
  late EditProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(EditProfileController());
    emailController = TextEditingController();
    usernameController = TextEditingController();
    imageUrlController = TextEditingController();
    
  
    _preFillData();
  }

  void _preFillData() {
    if (controller.email.value.isNotEmpty) {
      emailController.text = controller.email.value;
    }
    if (controller.username.value.isNotEmpty) {
      usernameController.text = controller.username.value;
    }
    if (controller.imageUrl.value.isNotEmpty) {
      imageUrlController.text = controller.imageUrl.value;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                     
                      Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                
                              },
                              child: Obx(() => CircleAvatar(
                                    radius: 60.0,
                                    backgroundColor: Colors.grey.shade300,
                                    backgroundImage: controller.imageUrl.value.isNotEmpty
                                        ? NetworkImage(controller.imageUrl.value) as ImageProvider
                                        : null,
                                    child: controller.imageUrl.value.isEmpty
                                        ? const Icon(Icons.person, size: 60, color: Colors.white)
                                        : null,
                                  )),
                            ),
                            const SizedBox(height: 8.0),
                            SizedBox(
                              width: 300,
                              child: TextField(
                                controller: imageUrlController,
                                decoration: InputDecoration(
                                  hintText: 'Image URL (http...)',
                                  prefixIcon: const Icon(Icons.image),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {

                                  controller.imageUrl.value = imageUrlController.text.trim();
                                },
                                child: const Text('Update Photo'),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    
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