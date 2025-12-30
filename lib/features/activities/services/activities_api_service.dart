import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:math/core/constants/api_urls.dart';
import 'package:math/core/error/failure.dart';
import 'package:math/core/network/dio_client.dart';
import 'package:math/features/activities/models/activities_response.dart';

class ActivitiesApiService {
  final DioClient _dioClient;

  ActivitiesApiService({required DioClient dioClient}) : _dioClient = dioClient;

  Future<Either<Failure, ActivitiesResponse>> postActivities({
    required String progressId,
    required String videoId,
  }) async {
    try {
      final url = ActivitiesApiUrls.postActivities;
      final response = await _dioClient.post(
        url: url,
        data: {
          'progressId': progressId,
          "videoId": videoId,
          'isCompleted': true,
        },
      );
      return Right(ActivitiesResponse.fromJson(response.data));
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? e.message ?? 'Unknown error occurred';
      return Left(Failure(message: errorMessage));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
