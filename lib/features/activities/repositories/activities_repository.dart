import 'package:dartz/dartz.dart';
import 'package:math/core/error/failure.dart';
import 'package:math/features/activities/models/activities_response.dart';
import 'package:math/features/activities/services/activities_api_service.dart';

class ActivitiesRepository {
  final ActivitiesApiService _activitiesApiService;

  ActivitiesRepository({required ActivitiesApiService activitiesApiService})
    : _activitiesApiService = activitiesApiService;

  Future<Either<Failure, ActivitiesResponse>> postActivities({
    required String progressId,
    required String videoId,
  }) async {
    return await _activitiesApiService.postActivities(
      progressId: progressId,
      videoId: videoId,
    );
  }
}
