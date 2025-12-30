import 'package:dartz/dartz.dart';
import 'package:math/core/error/failure.dart';
import 'package:math/features/progress/models/progress.dart';
import 'package:math/features/progress/services/progress_api_service.dart';

class ProgressRepository {
  final ProgressApiService _progressApiService;

  ProgressRepository({required ProgressApiService progressApiService})
    : _progressApiService = progressApiService;
  Future<Either<Failure, Progress>> getProgress({
    required String progressId,
  }) async {
    return await _progressApiService.getProgressApiService(
      progressId: progressId,
    );
  }
}
