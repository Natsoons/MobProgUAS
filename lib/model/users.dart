class User {
  final String name;
  final String email;
  final String? profileImage;

  User({required this.name, required this.email, this.profileImage});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profileImage: map['profile_image'],
    );
  }
}