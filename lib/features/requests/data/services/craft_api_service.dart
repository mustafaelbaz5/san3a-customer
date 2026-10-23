import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';
import '../models/craft_model.dart';

class CraftApiService {
  final Dio dio;

  CraftApiService({
    Dio? dio,
  }) : dio = dio ?? DioClient.dio;

  Future<List<CraftModel>> getCrafts() async {
    final response = await dio.get('/crafts');

    final List<dynamic> data = response.data;

    return data
        .map(
          (json) => CraftModel.fromJson(
        json as Map<String, dynamic>,
      ),
    )
        .where((craft) => craft.isActive)
        .toList();
  }

  Future<CraftModel?> getCraftByName(String name) async {
    final crafts = await getCrafts();

    final normalizedName = name.trim().toLowerCase();

    for (final craft in crafts) {
      if (craft.name.trim().toLowerCase() == normalizedName) {
        return craft;
      }
    }

    return null;
  }
}