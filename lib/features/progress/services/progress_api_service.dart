import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:math/core/constants/api_urls.dart';
import 'package:math/core/error/failure.dart';
import 'package:math/core/network/dio_client.dart';
import 'package:math/features/progress/models/progress.dart';

class ProgressApiService {
  final DioClient _dioClient;

  ProgressApiService({required DioClient dioClient}) : _dioClient = dioClient;

  Future<Either<Failure, Progress>> getProgressApiService({
    required String progressId,
  }) async {
    try {
      final url = '${ProgressApiUrls.getProgress}/$progressId/content';
      final response = await _dioClient.get(url: url);
      return Right(Progress.fromJson(response.data));
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? e.message ?? 'Lấy dữ liệu thất bại';
      return Left(Failure(message: errorMessage));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
