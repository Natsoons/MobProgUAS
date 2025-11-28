import 'package:flutter/material.dart';
import 'resetpassword.dart';
import 'profile_edit.dart';
import '../services/database_helper.dart';

class Profilebody extends StatefulWidget {
  const Profilebody({super.key});

  @override
  State<Profilebody> createState() => _ProfilebodyState();
}

class _ProfilebodyState extends State<Profilebody> {
 
  String username = "Loading...";
  String email = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadUserData(); 
  }

  
  void _loadUserData() async {
 
    var allUsers = await DatabaseHelper().getAllUsers();

    if (allUsers.isNotEmpty) {
     
      setState(() {
        username = allUsers.last['username'];
        email = allUsers.last['email'];
      });
      print('DEBUG: Username: $username, Email: $email');
    } else {
      setState(() {
        username = "Belum ada user";
        email = "-";
      });
      print('DEBUG: Tidak ada user di database');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
        
              Container(
                height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                   image: DecorationImage(
                    image: AssetImage('assets/beach.jpg'), 
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const CircleAvatar(
                      
                      radius: 60.0,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, size: 60, color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 15.0),

                
                  Text(
                    username, 
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 5.0),

               
                  Text(
                    email, 
                    style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w100,
                      fontSize: 16,
                    ),
                  ),
                  
              
                ],
              ),
            ],
          ),

          const SizedBox(height: 30.0),

         
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileEdit(),
                    ),
                  );
                
                  _loadUserData();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 4,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 18.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.person, color: Colors.blue),
                    SizedBox(width: 15),
                    Text(
                      "Edit Profil",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 15.0),

        
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 4,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 18.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.history, color: Colors.blue),
                    SizedBox(width: 15),
                    Text(
                      "Riwayat Perjalanan",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 15.0),

          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetPasswordPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 4,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 18.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.lock, color: Colors.blue),
                    SizedBox(width: 15),
                    Text(
                      "Reset Password",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 15.0),

          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  elevation: 4,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 18.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 15),
                    Text(
                      "Logout",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 30.0),
        ],
      ),
    );
  }
}