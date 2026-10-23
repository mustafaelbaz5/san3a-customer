import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';
import '../models/technician_model.dart';

class TechnicianApiService {
  final Dio dio;

  TechnicianApiService({
    Dio? dio,
  }) : dio = dio ?? DioClient.dio;

  Future<List<TechnicianModel>> getNearbyTechnicians({
    required String craftId,
    required double latitude,
    required double longitude,
    double radiusKm = 10,
  }) async {
    final response = await dio.get(
      '/technicians',
      queryParameters: {
        'craftId': craftId,
        'latitude': latitude,
        'longitude': longitude,
        'isAvailable': true,
        'radiusKm': radiusKm,
      },
    );

    final List<dynamic> data = response.data;

    return data
        .map(
          (json) => TechnicianModel.fromJson(json),
    )
        .toList();
  }
}