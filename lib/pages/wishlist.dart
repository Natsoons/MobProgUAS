import 'package:flutter/material.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const WishlistBody(),
    );
  }
}

class WishlistBody extends StatefulWidget {
  const WishlistBody({super.key});

  @override
  State<WishlistBody> createState() => _WishlistBodyState();
}

class _WishlistBodyState extends State<WishlistBody> {
  final List<Map<String, String>> wishlistItems = [
    {
      "title": "Hotel Beach",
      "location": "Bali, Indonesia",
      "price": "\$20 / night",
      "rating": "4.8",
      "image": "images/beach1.jpg"
    },
    {
      "title": "Mountain Resort",
      "location": "Malang, Indonesia",
      "price": "\$45 / night",
      "rating": "4.9",
      "image": "images/mountain1.jpg"
    },
    {
      "title": "Grand Luxury",
      "location": "Jakarta, Indonesia",
      "price": "\$120 / night",
      "rating": "5.0",
      "image": "images/hotel1.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/beach.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
              
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white24,
                            ),
                            child: const Icon(Icons.arrow_back, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.pink,
                      size: 50.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'My Wishlist',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins'
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    '${wishlistItems.length} Tempat Impian Tersimpan',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20.0),

          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: wishlistItems.length,
            itemBuilder: (context, index) {
              final item = wishlistItems[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.asset(
                        item["image"]!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) => Container(
                          height: 150,
                          color: Colors.grey.shade200,
                          child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                        ),
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["title"]!,
                                style: const TextStyle(
                                  fontSize: 18, 
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 14, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    item["location"]!,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                item["price"]!,
                                style: TextStyle(
                                  color: Colors.blue.shade800,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 16),
                                  Text(
                                    item["rating"]!,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    Container(
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey.shade100))
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  wishlistItems.removeAt(index);
                                });
                              },
                              icon: const Icon(Icons.delete_outline, color: Colors.red),
                              label: const Text("Hapus", style: TextStyle(color: Colors.red)),
                            ),
                          ),
                          Container(width: 1, height: 40, color: Colors.grey.shade100),
                          Expanded(
                            child: TextButton.icon(
                              onPressed: () {
                                // Navigasi ke detail atau booking
                              },
                              icon: Icon(Icons.book_online, color: Colors.blue.shade700),
                              label: Text("Book Now", style: TextStyle(color: Colors.blue.shade700)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }
}