class CustomerUser {
  final String id;
  final String name;
  final String email;
  final String role;
  final String status;
  final String profileImage;

  CustomerUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.profileImage,
  });

  factory CustomerUser.fromJson(Map<String, dynamic> json) {
    return CustomerUser(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
      profileImage: json['profileImage'] as String,
    );
  }
}