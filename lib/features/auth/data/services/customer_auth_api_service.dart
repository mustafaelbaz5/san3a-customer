import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../core/storage/token_storage.dart';
import '../models/customer_user.dart';

class CustomerAuthApiService {
  final Dio dio;

  CustomerAuthApiService({
    Dio? dio,
  }) : dio = dio ?? DioClient.dio;

  // =========================================================
  // REQUEST EMAIL OTP
  // =========================================================

  Future<Response> requestEmailOtp({
    required String email,
  }) async {
    try {
      final response = await dio.post(
        '/auth/email/request-otp',
        data: {
          'email': email,
        },
      );

      debugPrint(
        'REQUEST OTP STATUS: ${response.statusCode}',
      );

      debugPrint(
        'REQUEST OTP RESPONSE: ${response.data}',
      );

      return response;
    } on DioException catch (e) {
      debugPrint(
        'REQUEST OTP STATUS: ${e.response?.statusCode}',
      );

      debugPrint(
        'REQUEST OTP RESPONSE: ${e.response?.data}',
      );

      rethrow;
    }
  }

  // =========================================================
  // VERIFY EMAIL OTP
  // =========================================================

  Future<Response> verifyEmailOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await dio.post(
        '/auth/email/verify-otp',
        data: {
          'email': email,
          'otp': otp,
        },
      );

      debugPrint(
        'VERIFY OTP STATUS: ${response.statusCode}',
      );

      debugPrint(
        'VERIFY OTP RESPONSE: ${response.data}',
      );

      return response;
    } on DioException catch (e) {
      debugPrint(
        'VERIFY OTP STATUS: ${e.response?.statusCode}',
      );

      debugPrint(
        'VERIFY OTP RESPONSE: ${e.response?.data}',
      );

      rethrow;
    }
  }

  // =========================================================
  // REGISTER
  // =========================================================

  Future<Response> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      debugPrint(
        'REGISTER STATUS: ${response.statusCode}',
      );

      debugPrint(
        'REGISTER RESPONSE: ${response.data}',
      );

      return response;
    } on DioException catch (e) {
      debugPrint(
        'REGISTER STATUS: ${e.response?.statusCode}',
      );

      debugPrint(
        'REGISTER RESPONSE: ${e.response?.data}',
      );

      rethrow;
    }
  }

  // =========================================================
  // LOGIN
  // =========================================================

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final accessToken =
      response.data['accessToken'];

      if (accessToken == null ||
          accessToken.toString().isEmpty) {
        throw Exception(
          'Access token not found.',
        );
      }

      // Save token immediately after login.
      await TokenStorage().saveToken(
        accessToken.toString(),
      );

      debugPrint(
        'LOGIN STATUS: ${response.statusCode}',
      );

      debugPrint(
        'LOGIN TOKEN RECEIVED: true',
      );

      return response;
    } on DioException catch (e) {
      debugPrint(
        'LOGIN STATUS: ${e.response?.statusCode}',
      );

      debugPrint(
        'LOGIN RESPONSE: ${e.response?.data}',
      );

      rethrow;
    }
  }

  // =========================================================
  // GET CURRENT AUTHENTICATED USER
  // =========================================================

  Future<CustomerUser> getCurrentUser() async {
    try {
      final response = await dio.get(
        '/auth/me',
      );

      debugPrint(
        'CURRENT USER STATUS: ${response.statusCode}',
      );

      debugPrint(
        'CURRENT USER RESPONSE: ${response.data}',
      );

      return CustomerUser.fromJson(
        Map<String, dynamic>.from(
          response.data,
        ),
      );
    } on DioException catch (e) {
      debugPrint(
        'CURRENT USER STATUS: ${e.response?.statusCode}',
      );

      debugPrint(
        'CURRENT USER RESPONSE: ${e.response?.data}',
      );

      rethrow;
    }
  }
}