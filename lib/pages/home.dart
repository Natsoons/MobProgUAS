import 'package:flutter/material.dart';

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

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: const Center(child: Text("Login Page")),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, String>> discoverPlaces = [
    {"title": "Pantai Kuta", "location": "Bali", "image": "images/beach1.jpg"},
    {"title": "Gunung Bromo", "location": "Malang", "image": "images/mountain1.jpg"},
    {"title": "Candi Borobudur", "location": "Magelang", "image": "images/temple1.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Login()),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "LOGIN",
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
            const SizedBox(height: 20),
            SizedBox(
              height: 320,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20),
                children: [
                  _buildHotelCard("Hotel Elite", "\$20", "Jakarta", "images/hotel1.png"),
                  _buildHotelCard("Resort Mewah", "\$50", "Bali", "images/hotel2.png"),
                  _buildHotelCard("Hostel Murah", "\$10", "Bandung", "images/hostel1.png"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20),
              child: Text(
                "Jelajahi Tempat Baru",
                style: AppWidget.headlinestyle(22),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20),
                itemCount: discoverPlaces.length,
                itemBuilder: (context, index) {
                  final place = discoverPlaces[index];
                  return _buildDiscoverCard(
                    place["title"]!,
                    place["location"]!,
                    place["image"]!,
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHotelCard(String title, String price, String location, String imagePath) {
    return Container(
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
            child: Image.asset(
              imagePath,
              width: 250,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 250,
                height: 180,
                color: Colors.grey.shade300,
                child: Center(
                  child: Text(
                    "Hotel Image",
                    style: AppWidget.headlinestyle(16),
                  ),
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
    );
  }

  Widget _buildDiscoverCard(String title, String location, String imagePath) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 15, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              imagePath,
              width: 150,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 150,
                height: 100,
                color: Colors.grey.shade200,
                child: Center(
                  child: Icon(Icons.broken_image, color: Colors.blue.shade400),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppWidget.headlinestyle(14.0).copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.pin_drop, size: 14, color: Colors.blue.shade400),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: AppWidget.blueTextStyle(12.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}