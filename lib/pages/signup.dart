import 'package:flutter/material.dart';
import 'package:mobprog_uas/services/widget_support.dart';
import 'package:provider/provider.dart';
import 'package:mobprog_uas/providers/auth_provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "images/signup.png",
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 5.0,),
              Center(child: Text("Sign Up", style: AppWidget.headlinetextstyle(25.0),)),
              SizedBox(height: 5.0,),
              Center(
                child: Text(
                  "Please enter the details to continue.",
                  style: AppWidget.normaltextstyle(17.0),
                ),
              ),
              SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("Username", style: AppWidget.normaltextstyle(20.0),),
              ),
              SizedBox(height: 10.0,),
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                decoration: BoxDecoration(color: Color(0xFFececf8), borderRadius: BorderRadius.circular(10.0)),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person, color: Colors.blue),
                    hintText: "Enter Username",
                    hintStyle: AppWidget.normaltextstyle(18.0)
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("Email", style: AppWidget.normaltextstyle(20.0),),
              ),
              SizedBox(height: 10.0,),
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                decoration: BoxDecoration(color: Color(0xFFececf8), borderRadius: BorderRadius.circular(10.0)),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.mail, color: Colors.blue),
                    hintText: "Enter Email",
                    hintStyle: AppWidget.normaltextstyle(18.0)
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("Password", style: AppWidget.normaltextstyle(20.0),),
              ),
              SizedBox(height: 10.0,),
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                decoration: BoxDecoration(color: Color(0xFFececf8), borderRadius: BorderRadius.circular(10.0)),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.password, color: Colors.blue),
                    hintText: "Enter Password",
                    hintStyle: AppWidget.normaltextstyle(18.0)
                  ),
                ),
              ),
              SizedBox(height: 30.0,),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    final auth = Provider.of<AuthProvider>(context, listen: false);
                    final name = _nameController.text.trim();
                    final email = _emailController.text.trim();
                    final pass = _passwordController.text;
                    final ok = await auth.register(name, email, pass);
                    if (ok) {
                      Navigator.pushReplacementNamed(context, '/profile');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registrasi gagal / email sudah terdaftar')));
                    }
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width/2,
                    child: Center(child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),)),
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ", style: AppWidget.normaltextstyle(18.0),),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text("Login", style: AppWidget.headlinetextstyle(20.0),)),
                ])
            ],
          ),
        ),
      ),
    );
  }
}