import 'package:flutter/material.dart';
import 'package:mobprog_uas/services/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:mobprog_uas/providers/auth_provider.dart';

class PaymentPage extends StatefulWidget {
  final Map<String, dynamic>? hotel;
  final int nights;
  final int guests;
  final String? checkin;
  final String? checkout;
  
  const PaymentPage({super.key, this.hotel, this.nights = 0, this.guests = 1, this.checkin, this.checkout});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedMethod = 0;
  final DBHelper _db = DBHelper();

  @override
  Widget build(BuildContext context) {
    final double total = _computeTotal();
    final double pricePerNight = _getPricePerNight();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Order Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.hotel?['name'] ?? 'Hotel', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 5),
                        Text('${widget.nights} Night(s), ${widget.guests} Guests', style: const TextStyle(color: Colors.grey)),
                        Text(
                          '${_formatPrice(pricePerNight)} x ${widget.nights} nights', 
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 12)
                        ),
                      ],
                    ),
                    Text(_formatPrice(total), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              const Text("Payment Method", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildPaymentOption(0, "Credit / Debit Card", Icons.credit_card),
              _buildPaymentOption(1, "Bank Transfer", Icons.account_balance),
              _buildPaymentOption(2, "E-Wallet", Icons.account_balance_wallet),
              const SizedBox(height: 25),

              if (_selectedMethod == 0) ...[
                const Text("Card Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Card Number",
                    prefixIcon: const Icon(Icons.numbers),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Expiry Date (MM/YY)",
                          prefixIcon: const Icon(Icons.calendar_today),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "CVV",
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        keyboardType: TextInputType.number,
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Cardholder Name",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    _showSuccessDialog(total);
                  },
                  child: const Text("Pay Now", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(int index, String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: _selectedMethod == index ? Colors.blue : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
        color: _selectedMethod == index ? Colors.blue.withOpacity(0.05) : Colors.transparent,
      ),
      child: RadioListTile(
        value: index,
        groupValue: _selectedMethod,
        onChanged: (value) {
          setState(() {
            _selectedMethod = value!;
          });
        },
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        secondary: Icon(icon, color: _selectedMethod == index ? Colors.blue : Colors.grey),
        activeColor: Colors.blue,
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }

  void _showSuccessDialog(double totalAmount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Column(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 50),
              SizedBox(height: 10),
              Text("Payment Successful!"),
            ],
          ),
          content: const Text("Your booking has been confirmed.", textAlign: TextAlign.center),
          actions: [
            TextButton(
              onPressed: () async {
                final auth = Provider.of<AuthProvider>(context, listen: false);
                final email = auth.user?.email ?? '';
                final booking = {
                  'email': email,
                  'hotel_name': widget.hotel?['name'] ?? '',
                  'hotel_id': widget.hotel?['id']?.toString() ?? '',
                  'checkin': widget.checkin ?? '',
                  'checkout': widget.checkout ?? '',
                  'nights': widget.nights,
                  'guests': widget.guests,
                  'total': totalAmount,
                };
                await _db.insertBooking(booking);
                if (!mounted) return;
                Navigator.pop(context); 
                if (!mounted) return;
                Navigator.pushReplacementNamed(context, '/bookings');
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  double _getPricePerNight() {
    var rawPrice = widget.hotel?['price'];
    if (rawPrice == null) return 0.0;
    String cleanString = rawPrice.toString().replaceAll(RegExp(r'[^0-9.]'), '');    
    return double.tryParse(cleanString) ?? 0.0;
  }

  double _computeTotal() {
    return _getPricePerNight() * widget.nights;
  }

  String _formatPrice(double v) {
    final symbol = widget.hotel?['currency'] ?? '\$';
    return '$symbol${v.toStringAsFixed(2)}';
  }
}
