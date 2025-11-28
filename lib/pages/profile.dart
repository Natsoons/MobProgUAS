import 'package:flutter/material.dart';
import 'profilebody.dart';


class  Profile extends StatelessWidget {
  const Profile({super.key});

 
  @override
  Widget build(BuildContext context) {
    var scaffold3 = Scaffold(
      appBar: AppBar(
        title: const Text (
          'profil',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue,
            fontFamily: 'Poppins'
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        // removed top-right edit button as requested
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: const Profilebody(),

      
    );
    var scaffold2 = scaffold3;
    var scaffold = scaffold2;
    return scaffold;
  }
}

