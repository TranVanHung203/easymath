import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:math/core/constants/api_urls.dart';
import 'package:math/core/error/failure.dart';
import 'package:math/core/network/dio_client.dart';
import 'package:math/features/video/models/video.dart';

class VideoApiService {
  final DioClient _dioClient;

  VideoApiService({required DioClient dioClient}) : _dioClient = dioClient;

  Future<Either<Failure, Video>> getVideo({required String videoId}) async {
    try {
      final url = '${VideoApiUrls.getVideo}/$videoId';
      final response = await _dioClient.get(url: url);
      return Right(Video.fromJson(response.data));
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? e.message ?? 'Unknown error occurred';
      return Left(Failure(message: errorMessage));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
