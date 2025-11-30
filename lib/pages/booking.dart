import 'package:flutter/material.dart';
import 'payment.dart';

class HotelBookingPage extends StatefulWidget {
  final Map<String, dynamic>? hotel;
  const HotelBookingPage({super.key, this.hotel});

  @override
  State<HotelBookingPage> createState() => _HotelBookingPageState();
}

class _HotelBookingPageState extends State<HotelBookingPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _guestCount = 1;

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    DateTime firstDate = DateTime.now();
    if (!isCheckIn && _checkInDate != null) {
      firstDate = _checkInDate!;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
          if (_checkOutDate != null && _checkOutDate!.isBefore(_checkInDate!)) {
            _checkOutDate = null; 
          }
        } else {
          _checkOutDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Details", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Dates", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildDateSelector(
                      label: "Check-in",
                      date: _checkInDate,
                      onTap: () => _selectDate(context, true),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildDateSelector(
                      label: "Check-out",
                      date: _checkOutDate,
                      onTap: () => _selectDate(context, false),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),
              const Text("Guests", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Number of Guests", style: TextStyle(fontSize: 16)),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (_guestCount > 1) setState(() => _guestCount--);
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        Text("$_guestCount", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        IconButton(
                          onPressed: () {
                            setState(() => _guestCount++);
                          },
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 25),
              const Text("Contact Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildTextField("Full Name", _nameController, Icons.person),
              const SizedBox(height: 15),
              _buildTextField("Phone Number", _phoneController, Icons.phone, isNumber: true),
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
                    if (_checkInDate == null || _checkOutDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please select check-in and check-out dates'),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }
                    
                    if (_nameController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please enter your name'),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }

                    String phone = _phoneController.text.trim();
                    if (phone.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please enter your phone number'),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }

                    if (!RegExp(r'^[0-9]+$').hasMatch(phone) || phone.length < 10) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please enter a valid phone number (min 10 digits)'),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }
                    
                    DateTime ci = _checkInDate!;
                    DateTime co = _checkOutDate!;
                    if (co.isBefore(ci) || co.isAtSameMomentAs(ci)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Check-out date must be after Check-in date!'),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }

                    int nights = co.difference(ci).inDays;
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentPage(
                        hotel: widget.hotel,
                        nights: nights,
                        guests: _guestCount,
                        checkin: '${ci.year}-${ci.month}-${ci.day}',
                        checkout: '${co.year}-${co.month}-${co.day}',
                        guestName: _nameController.text.trim(),
                      )),
                    );
                  },
                  child: const Text("Continue to Payment", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector({required String label, required DateTime? date, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 5),
            Text(
              date == null ? "Select Date" : "${date.day}/${date.month}/${date.year}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}