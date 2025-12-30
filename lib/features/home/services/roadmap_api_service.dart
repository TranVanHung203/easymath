import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:math/core/constants/api_urls.dart';
import 'package:math/core/error/failure.dart';
import 'package:math/core/network/dio_client.dart';
import 'package:math/features/home/models/roadmap.dart';

class RoadmapApiService {
  final DioClient _dioClient;

  RoadmapApiService({required DioClient dioClient}) : _dioClient = dioClient;

  Future<Either<Failure, Roadmap>> getRoadmap({
    required String chapterId,
  }) async {
    try {
      final url = '${RoadmapApiUrls.getRoadmaps}/$chapterId/map';
      final response = await _dioClient.get(url: url);
      return Right(Roadmap.fromJson(response.data));
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? e.message ?? 'Đăng nhập thất bại';
      return Left(Failure(message: errorMessage));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
