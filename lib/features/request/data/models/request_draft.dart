class RequestDraft {
  String serviceName;
  String craftId;

  String description;

  double? latitude;
  double? longitude;

  String addressDetails;
  String buildingDetails;

  RequestDraft({
    required this.serviceName,
    required this.craftId,
    this.description = '',
    this.latitude,
    this.longitude,
    this.addressDetails = '',
    this.buildingDetails = '',
  });
}