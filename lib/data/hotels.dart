final List<Map<String, dynamic>> hotels = List.generate(50, (i) {
  final id = i + 1;
  final cities = ['Jakarta', 'Bali', 'Bandung', 'Surabaya', 'Yogyakarta', 'Semarang', 'Makassar'];
  final images = List.generate(50, (j) => 'https://picsum.photos/seed/hotel${j + 1}/600/400');
  return {
    'id': id,
    'name': 'Hotel ${id.toString().padLeft(2, '0')}',
    'price': 10 + (id % 40),
    'currency': 'USD',
    'city': cities[id % cities.length],
    'image': images[id % images.length],
    'rating': 3.5 + ((id % 5) * 0.3),
  };
});
