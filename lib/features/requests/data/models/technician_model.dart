class TechnicianModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String craftName;
  final double rating;
  final bool isAvailable;
  final double latitude;
  final double longitude;
  final double distanceKm;

  TechnicianModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.craftName,
    required this.rating,
    required this.isAvailable,
    required this.latitude,
    required this.longitude,
    required this.distanceKm,
  });

  factory TechnicianModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return TechnicianModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      craftName: json['craft']?['name'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      isAvailable: json['isAvailable'] ?? false,
      latitude:
      (json['location']?['latitude'] as num?)
          ?.toDouble() ??
          0.0,
      longitude:
      (json['location']?['longitude'] as num?)
          ?.toDouble() ??
          0.0,
      distanceKm:
      (json['distanceKm'] as num?)?.toDouble() ?? 0.0,
    );
  }
}