import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle whitetextstyle(double size){
    return TextStyle(
      color: Colors.white, 
      fontSize: size, 
      fontWeight: FontWeight.w500
    );
  }
  static TextStyle headlinetextstyle(double size){
    return TextStyle(
      color: Colors.black, 
      fontSize: size,
      fontWeight: FontWeight.bold,
    );
  }
  static TextStyle normaltextstyle(double size){
    return TextStyle(
      color: Colors.black, 
      fontSize: size,
      fontWeight: FontWeight.w500,
    );
  }

    static TextStyle whiteTextStyle(double size){
    return TextStyle(
      color: Colors.white,
      fontSize: size,
      fontWeight: FontWeight.w500
    );
  }

  
  static TextStyle blueTextStyle(double size){
    return TextStyle(
      color: Colors.blue.shade600, 
      fontSize: size,
      fontWeight: FontWeight.w500
    );
  }

  static TextStyle headlinestyle(double size){
    return TextStyle(
      color: Colors.black,
      fontSize: size,
      fontWeight: FontWeight.w500
    );
  }
}