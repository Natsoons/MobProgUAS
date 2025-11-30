import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobprog_uas/data/hotels.dart';
import 'package:mobprog_uas/providers/auth_provider.dart';

class AppWidget {
  static TextStyle headlinestyle(double size) {
    return TextStyle(
      color: Colors.black,
      fontSize: size,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle whiteTextStyle(double size) {
    return TextStyle(
      color: Colors.white,
      fontSize: size,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle blueTextStyle(double size) {
    return TextStyle(
      color: Colors.blue,
      fontSize: size,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filtered = [];

  @override
  void initState() {
    super.initState();
    filtered = hotels;
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    
    if (filtered.isEmpty && _searchController.text.isEmpty) {
       filtered = hotels;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Image.asset(
                    "images/home.jpg",
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      color: Colors.blue.shade100,
                      child: Center(
                        child: Text(
                          "Header Image",
                          style: AppWidget.headlinestyle(20),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: const BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.white),
                              const SizedBox(width: 10),
                              Text(
                                "Indonesia, Jakarta",
                                style: AppWidget.whiteTextStyle(20),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              if (auth.isLoggedIn) {
                                Navigator.pushNamed(context, '/profile');
                              } else {
                                Navigator.pushNamed(context, '/login');
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                auth.isLoggedIn ? "Profile Akun" : "LOGIN",
                                style: AppWidget.blueTextStyle(16).copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Hello, User ! Tell us where are we staying !",
                        style: AppWidget.whiteTextStyle(25),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (v) {
                            setState(() {
                              final q = v.toLowerCase();
                              filtered = hotels.where((h) {
                                final name = (h['name'] ?? '').toString().toLowerCase();
                                final city = (h['city'] ?? '').toString().toLowerCase();
                                return name.contains(q) || city.contains(q);
                              }).toList();
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.blue.shade400,
                            ),
                            hintText: "Search for hotel, city, etc",
                            hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                            contentPadding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20),
              child: Text(
                "Yang paling relevan",
                style: AppWidget.headlinestyle(22),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, '/hotels'),
                child: const Text('Lihat Semua'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 320,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20),
                children: hotels.take(10).map((h) => _buildHotelCardFromMap(h)).toList(),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20),
              child: Text(
                "List Hotel",
                style: AppWidget.headlinestyle(22),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 320, 
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20),
                children: (filtered.take(10).toList()).map((h) => _buildHotelCardFromMap(h)).toList(),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHotelCardFromMap(Map<String, dynamic> h) {
    final title = h['name'] ?? '';
    final price = '${h['currency'] ?? ''}${h['price'] ?? ''}';
    final location = h['city'] ?? '';
    final imagePath = h['image'] ?? '';
    
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: h);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20, bottom: 10),
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: imagePath != null && imagePath.toString().startsWith('http')
                  ? Image.network(
                      imagePath,
                      width: 250,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 250,
                        height: 180,
                        color: Colors.grey.shade300,
                        child: Center(
                          child: Icon(Icons.image_not_supported, color: Colors.grey),
                        ),
                      ),
                    )
                  : Image.asset(
                      imagePath,
                      width: 250,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 250,
                        height: 180,
                        color: Colors.grey.shade300,
                        child: Center(
                          child: Icon(Icons.image_not_supported, color: Colors.grey),
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppWidget.headlinestyle(20).copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    price,
                    style: AppWidget.headlinestyle(18).copyWith(color: Colors.redAccent),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue.shade400, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        location,
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}