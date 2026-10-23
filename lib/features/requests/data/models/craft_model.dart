class CraftModel {
  final String id;
  final String name;
  final String description;
  final bool isActive;

  CraftModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
  });

  factory CraftModel.fromJson(Map<String, dynamic> json) {
    return CraftModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      isActive: json['isActive'] ?? false,
    );
  }
}