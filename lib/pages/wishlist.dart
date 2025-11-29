import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobprog_uas/providers/auth_provider.dart';
import 'package:mobprog_uas/services/db_helper.dart';
import 'package:mobprog_uas/data/hotels.dart';

// Reuse this page as Riwayat Pemesanan (bookings history)

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
  final DBHelper _db = DBHelper();
  List<Map<String, dynamic>> _bookings = [];
  bool _loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final email = auth.user?.email ?? '';
    if (email.isEmpty) {
      setState(() {
        _bookings = [];
        _loading = false;
      });
      return;
    }
    final res = await _db.getBookingsByEmail(email);
    setState(() {
      _bookings = res;
      _loading = false;
    });
  }

  Future<void> _deleteBooking(int id) async {
    await _db.deleteBookingById(id);
    await _loadBookings();
  }

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
                      Icons.history,
                      color: Colors.blue,
                      size: 50.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Riwayat Pemesanan',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins'
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    '${_bookings.length} Pemesanan',
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

          if (_loading) const Center(child: CircularProgressIndicator()),

          if (!_loading && _bookings.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text('Belum ada riwayat pemesanan.'),
            ),

          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _bookings.length,
            itemBuilder: (context, index) {
              final item = _bookings[index];
              final hotelId = int.tryParse((item['hotel_id'] ?? '').toString());
              final hotel = (hotelId != null) ? hotels.firstWhere((h) => h['id'] == hotelId, orElse: () => {}) : {};
              final image = (hotel.isNotEmpty) ? hotel['image'] : null;
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
                    if (image != null)
                      SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: (image.toString().startsWith('http')) ? Image.network(image, fit: BoxFit.cover) : Image.asset(image, fit: BoxFit.cover),
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
                                item['hotel_name'] ?? 'Hotel',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text('Check-in: ${item['checkin'] ?? '-'}'),
                              Text('Check-out: ${item['checkout'] ?? '-'}'),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  '\$${(item['total'] ?? 0).toString()}',
                                style: TextStyle(
                                  color: Colors.blue.shade800,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text('Nights: ${item['nights'] ?? 0}'),
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
                                _deleteBooking(item['id']);
                              },
                              icon: const Icon(Icons.delete_outline, color: Colors.red),
                              label: const Text("Hapus", style: TextStyle(color: Colors.red)),
                            ),
                          ),
                          Container(width: 1, height: 40, color: Colors.grey.shade100),
                          Expanded(
                            child: TextButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(context, '/booking_detail', arguments: item);
                              },
                              icon: Icon(Icons.info_outline, color: Colors.blue.shade700),
                              label: Text("Detail", style: TextStyle(color: Colors.blue.shade700)),
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