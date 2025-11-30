final List<String> hotelImages = [
  "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800&auto=format&fit=crop&q=60",
  "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=800&auto=format&fit=crop&q=60",
  "https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800&auto=format&fit=crop&q=60",
  "https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=800&auto=format&fit=crop&q=60",
  "https://images.unsplash.com/photo-1611892440504-42a792e24d32?w=800&auto=format&fit=crop&q=60",
  "https://images.unsplash.com/photo-1596436889106-be35e843f974?w=800&auto=format&fit=crop&q=60",
  "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800&auto=format&fit=crop&q=60",
  "https://images.unsplash.com/photo-1571896349842-6e53ce41e86a?w=800&auto=format&fit=crop&q=60",
];

final List<Map<String, dynamic>> hotels = List.generate(50, (i) {
  final id = i + 1;
  final cities = ['Jakarta', 'Bali', 'Bandung', 'Surabaya', 'Yogyakarta', 'Semarang', 'Makassar'];
  
  final image = hotelImages[i % hotelImages.length];

  return {
    'id': id,
    'name': 'Hotel ${id.toString().padLeft(2, '0')}',
    'price': 10 + (id % 40),
    'currency': 'USD',
    'city': cities[id % cities.length],
    'image': image,
    'rating': 3.5 + ((id % 5) * 0.3),
  };
});