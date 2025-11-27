import 'package:flutter/material.dart';
import 'package:mobprog_uas/pages/login.dart'; // Import halaman login
import 'package:mobprog_uas/services/widget_support.dart';

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
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.asset(
                      "images/home.jpg",
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      fit: BoxFit.cover,
                      // Gambar placeholder jika "images/home.jpg" tidak ada
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        color: Colors.blue.shade100,
                        child: Center(child: Text("Header Image", style: AppWidget.headlinestyle(20))),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(100, 0, 0, 0), 
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
                                Icon(Icons.location_on, color: Colors.white),
                                SizedBox(width: 10),
                                Text("Indonesia, Jakarta",
                                    style: AppWidget.whiteTextStyle(20)),
                              ],
                            ),
                            // Tombol Login
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Login()),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text("LOGIN",
                                    style: AppWidget.blueTextStyle(16).copyWith(fontWeight: FontWeight.bold)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Text("Hello, User ! Tell us where are we staying !",
                            style: AppWidget.whiteTextStyle(25)),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          margin: EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                           
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.blue.shade400, 
                              ),
                              hintText: "Search for hotel, city, etc",
                              
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
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
              SizedBox(height: 20),
              
              
              Container(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 20), 
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
              SizedBox(height: 20),

             
              Container(
                height: 180, 
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 20),
                  itemCount: discoverPlaces.length,
                  itemBuilder: (context, index) {
                    final place = discoverPlaces[index];
                    return _buildDiscoverCard(place["title"]!, place["location"]!, place["image"]!);
                  },
                ),
              ),
              SizedBox(height: 30), 
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk membuat kartu hotel
  Widget _buildHotelCard(String title, String price, String location, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), 
          ),
        ],
      ),
      margin: EdgeInsets.only(right: 20),
      width: 300, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              imagePath, 
              width: 300,  
              height: 200,
              fit: BoxFit.cover, 
              errorBuilder: (context, error, stackTrace) => Container(
                width: 300,
                height: 200,
                color: Colors.grey.shade300,
                child: Center(child: Text("Hotel Image", style: AppWidget.headlinestyle(16))),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(title, style: AppWidget.headlinestyle(20).copyWith(fontWeight: FontWeight.bold)),
          ),
            Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(price, style: AppWidget.headlinestyle(18).copyWith(color: Colors.redAccent)),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Icon(Icons.location_on, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Text(location, style: AppWidget.whiteTextStyle(16)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  
  Widget _buildDiscoverCard(String title, String location, String imagePath) {
    return Container(
      width: 150, // Lebar lebih kecil
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              imagePath,
              width: 150,
              height: 100, 
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 150,
                height: 100,
                color: Colors.grey.shade200,
                child: Center(child: Icon(Icons.public, color: Colors.blue.shade400)),
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
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.pin_drop, size: 14, color: Colors.blue.shade400),
                    SizedBox(width: 4),
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