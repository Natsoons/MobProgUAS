import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      child: Image.asset(
                        "images/hotel1.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 50, left: 20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hotel Beach", style: AppWidget.headlineTextStyle()),
                    Text("\$20", style: AppWidget.normalTextStyle()),
                  ],
                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Divider(thickness: 2),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "What this place offers",
                  style: AppWidget.headlineTextStyle(),
                ),
              ),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAmenity(Icons.wifi, "WiFi"),
                    _buildAmenity(Icons.tv, "HDTV"),
                    _buildAmenity(Icons.kitchen, "Kitchen"),
                    _buildAmenity(Icons.bathtub, "Bath"),
                  ],
                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Divider(thickness: 2),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "About this place",
                  style: AppWidget.headlineTextStyle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  "Best hotel you can't find anywhere in Delhi. Relax and enjoy the beautiful view of the beach.",
                  style: AppWidget.normalTextStyle(),
                ),
              ),

              SizedBox(height: 20),

              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$100 for 4 nights",
                        style: AppWidget.headlineTextStyle(),
                      ),
                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDateSelector(
                            Icons.calendar_month,
                            "Check-in",
                            "02 Apr 2025",
                          ),
                          SizedBox(width: 10),
                          _buildDateSelector(
                            Icons.calendar_month,
                            "Check-out",
                            "05 Apr 2025",
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      Text(
                        "Number of guests",
                        style: AppWidget.normalTextStyle(),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Color(0xFFececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "1",
                            hintStyle: AppWidget.normalTextStyle(),
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Book Now",
                            style: AppWidget.whiteTextStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmenity(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.black87),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildDateSelector(IconData icon, String title, String date) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                SizedBox(width: 5),
                Text(title, style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 5),
            Text(
              date,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class AppWidget {
  static TextStyle headlineTextStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle normalTextStyle() {
    return TextStyle(
      color: Colors.black54,
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle whiteTextStyle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
    );
  }
}
