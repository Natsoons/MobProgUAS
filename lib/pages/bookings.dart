import 'package:flutter/material.dart';
import 'package:mobprog_uas/services/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:mobprog_uas/providers/auth_provider.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Pemesanan')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _bookings.isEmpty
              ? const Center(child: Text('Belum ada riwayat pemesanan.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _bookings.length,
                  itemBuilder: (context, index) {
                    final b = _bookings[index];
                    return Card(
                      child: ListTile(
                        title: Text(b['hotel_name'] ?? 'Hotel'),
                        subtitle: Text('Nights: ${b['nights'] ?? 0} • Guests: ${b['guests'] ?? 0}'),
                        trailing: Text((b['total'] != null) ? b['total'].toString() : ''),
                      ),
                    );
                  },
                ),
    );
  }
}
