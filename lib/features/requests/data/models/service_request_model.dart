class ServiceRequestModel {
  final String id;
  final String craftName;
  final String description;
  final double latitude;
  final double longitude;
  final String status;
  final String? technicianName;
  final DateTime createdAt;

  ServiceRequestModel({
    required this.id,
    required this.craftName,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.status,
    this.technicianName,
    required this.createdAt,
  });

  factory ServiceRequestModel.fromJson(
      Map<String, dynamic> json,
      ) {
    final assignedTechnician =
    json['assignedTechnician'];

    final craft = json['craft'];

    return ServiceRequestModel(
      id: json['id']?.toString() ?? '',
      craftName: craft is Map<String, dynamic>
          ? craft['name']?.toString() ?? 'Unknown Service'
          : 'Unknown Service',
      description:
      json['description']?.toString() ?? '',
      latitude:
      (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude:
      (json['longitude'] as num?)?.toDouble() ?? 0.0,
      status:
      json['status']?.toString() ?? '',
      technicianName:
      assignedTechnician is Map<String, dynamic>
          ? assignedTechnician['name']?.toString() ??
          assignedTechnician['fullName']?.toString()
          : null,
      createdAt:
      DateTime.tryParse(
        json['createdAt']?.toString() ?? '',
      ) ??
          DateTime.now(),
    );
  }
}