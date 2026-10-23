import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';
import '../models/service_request_model.dart';

class RequestApiService {
  final Dio dio;

  RequestApiService({
    Dio? dio,
  }) : dio = dio ?? DioClient.dio;

  Future<List<ServiceRequestModel>> getMyRequests() async {
    final response = await dio.get(
      '/service-requests/me',
    );

    final List<dynamic> data = response.data;

    return data
        .map(
          (json) => ServiceRequestModel.fromJson(
        json as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  Future<ServiceRequestModel> createRequest({
    required String craftId,
    required String description,
    required double latitude,
    required double longitude,
  }) async {
    final response = await dio.post(
      '/service-requests',
      data: {
        'craftId': craftId,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
      },
    );

    return ServiceRequestModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}