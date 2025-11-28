import 'package:flutter/material.dart';
import 'profilebody.dart';



class  Profile extends StatelessWidget {
  const Profile({super.key});

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ('profil',
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.lightBlue,
          fontFamily: 'Poppins'
        ),
        ),
        leading: IconButton(
          onPressed: () {
             Navigator.pop(context); 
          }, 
          icon: const Icon(Icons.arrow_back), 
        ),
  

        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: const Profilebody(),

      
    );
  
  }
}

