import 'package:flutter/material.dart';
import 'package:mobprog_uas/pages/home.dart' as home_page hide Login;
import 'package:mobprog_uas/pages/login.dart' as auth_login;
import 'package:mobprog_uas/pages/signup.dart';
import 'package:mobprog_uas/pages/profile.dart';
import 'package:mobprog_uas/pages/detail_page.dart';
import 'package:mobprog_uas/pages/forgot_password.dart';
import 'package:mobprog_uas/pages/hotels_list.dart';
import 'package:mobprog_uas/pages/bookings.dart';
import 'package:mobprog_uas/pages/edit_profile.dart';
import 'package:mobprog_uas/pages/histori.dart';
import 'package:mobprog_uas/pages/booking_detail.dart';

class AppRouter {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case '/home':
        return MaterialPageRoute(builder: (_) => const home_page.Home());
      case '/login':
        return MaterialPageRoute(builder: (_) => const auth_login.Login());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUp());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const Profile());
      case '/detail':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(builder: (_) => DetailPage(hotel: args));
      case '/hotels':
        return MaterialPageRoute(builder: (_) => const HotelsListPage());
      case '/forgot':
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case '/bookings':
        return MaterialPageRoute(builder: (_) => const Wishlist());
      case '/edit_profile':
        return MaterialPageRoute(builder: (_) => const EditProfilePage());
      case '/booking_detail':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(builder: (_) => BookingDetailPage(booking: args));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
