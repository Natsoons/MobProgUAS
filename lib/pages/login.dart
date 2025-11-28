import 'package:flutter/material.dart';
import 'package:mobprog_uas/services/widget_support.dart';

// Halaman Login untuk pengguna
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController useremailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              Text(
                "Selamat Datang Kembali!",
                style: AppWidget.headlinestyle(30.0).copyWith(fontWeight: FontWeight.bold, color: Colors.blue.shade800),
              ),
              SizedBox(height: 10.0),
              Text(
                "Masuk ke akun Anda untuk melanjutkan",
                style: AppWidget.headlinestyle(18.0).copyWith(color: Colors.grey.shade600),
              ),
              SizedBox(height: 50.0),

            
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blue.shade100),
                  ),
                  child: TextField(
                    controller: useremailcontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.email_outlined, color: Colors.blue.shade400),
                      hintText: "Email",
                      hintStyle: AppWidget.headlinestyle(18.0).copyWith(color: Colors.grey.shade400, fontWeight: FontWeight.w400),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
              SizedBox(height: 20.0),

            
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blue.shade100),
                  ),
                  child: TextField(
                    controller: passwordcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.blue.shade400),
                      hintText: "Password",
                      hintStyle: AppWidget.headlinestyle(18.0).copyWith(color: Colors.grey.shade400, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.0),

            
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Lupa Password?",
                    style: AppWidget.blueTextStyle(16.0).copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 40.0),

              GestureDetector(
                onTap: () {
                 
                  print("Tombol Login ditekan");
                },
                child: Center(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "MASUK",
                          style: AppWidget.whiteTextStyle(20.0).copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),

              // Teks Daftar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum punya akun? ", style: AppWidget.headlinestyle(16.0)),
                  GestureDetector(
                    onTap: () {
                     
                      print("Navigasi ke Daftar");
                    },
                    child: Text(
                      "Daftar Sekarang",
                      style: AppWidget.blueTextStyle(16.0).copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}