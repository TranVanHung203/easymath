import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:math/core/constants/api_urls.dart';
import 'package:math/core/error/failure.dart';
import 'package:math/core/network/dio_client.dart';
import 'package:math/features/auth/models/auth.dart';

class AuthApiService {
  final DioClient _dioClient;

  AuthApiService({required DioClient dioClient}) : _dioClient = dioClient;

  Future<Either<Failure, Auth>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dioClient.post(
        url: AuthApiUrls.login,
        data: {'username': username, 'password': password},
      );
      return Right(Auth.fromJson(response.data));
    } on DioException catch (e) {
      final data = e.response?.data;
      final message = data is Map<String, dynamic>
          ? data['message']?.toString()
          : null;

      return Left(Failure(message: message ?? 'Đăng nhập thất bại'));
    }
  }

  Future<Either<Failure, String>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final response = await _dioClient.post(
        url: AuthApiUrls.refresh,
        data: {'refreshToken': refreshToken},
      );
      return Right(response.data['accessToken']);
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? e.message ?? 'Làm mới token thất bại';
      return Left(Failure(message: errorMessage));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
