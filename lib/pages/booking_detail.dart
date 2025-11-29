import 'package:flutter/material.dart';
import 'package:mobprog_uas/data/hotels.dart';

class BookingDetailPage extends StatelessWidget {
  final Map<String, dynamic>? booking;
  const BookingDetailPage({super.key, this.booking});

  @override
  Widget build(BuildContext context) {
    final b = booking ?? {};
    final hotelId = int.tryParse((b['hotel_id'] ?? '').toString());
    final hotel = (hotelId != null) ? hotels.firstWhere((h) => h['id'] == hotelId, orElse: () => {}) : {};
    final hotelImage = hotel['image'];

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pesanan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hotelImage != null)
              SizedBox(
                height: 200,
                width: double.infinity,
                child: (hotelImage.toString().startsWith('http'))
                    ? Image.network(hotelImage, fit: BoxFit.cover)
                    : Image.asset(hotelImage, fit: BoxFit.cover),
              ),
            const SizedBox(height: 16),
            Text(b['hotel_name'] ?? 'Hotel', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Check-in: ${b['checkin'] ?? '-'}'),
            Text('Check-out: ${b['checkout'] ?? '-'}'),
            const SizedBox(height: 8),
            Text('Nights: ${b['nights'] ?? 0} • Guests: ${b['guests'] ?? 0}'),
            const SizedBox(height: 8),
            Text('Total: \$${(b['total'] ?? 0).toString()}'),
            const SizedBox(height: 20),
            const Text('Detail Tambahan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Booking ID: ${b['id'] ?? ''}'),
            Text('Email: ${b['email'] ?? ''}'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
