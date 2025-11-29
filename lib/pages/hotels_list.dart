import 'package:flutter/material.dart';
import 'package:mobprog_uas/data/hotels.dart';

class HotelsListPage extends StatelessWidget {
  const HotelsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Semua Hotel')),
      body: ListView.builder(
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          final h = hotels[index];
          return ListTile(
            leading: SizedBox(
              width: 60,
              height: 60,
              child: h['image'] != null
                  ? Image.asset(h['image'], fit: BoxFit.cover, errorBuilder: (c,e,s)=>Icon(Icons.hotel))
                  : Icon(Icons.hotel),
            ),
            title: Text(h['name'] ?? 'Hotel'),
            subtitle: Text('${h['city'] ?? ''} • ${h['currency'] ?? ''}${h['price'] ?? ''}'),
            trailing: Text((h['rating'] ?? 0).toString()),
            onTap: () => Navigator.pushNamed(context, '/detail', arguments: h),
          );
        },
      ),
    );
  }
}
