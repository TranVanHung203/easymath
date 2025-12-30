import 'package:dartz/dartz.dart';
import 'package:math/core/error/failure.dart';
import 'package:math/features/home/models/roadmap.dart';
import 'package:math/features/home/services/roadmap_api_service.dart';

class RoadmapRepository {
  final RoadmapApiService _roadmapApiService;

  RoadmapRepository({required RoadmapApiService roadmapApiService})
    : _roadmapApiService = roadmapApiService;
  Future<Either<Failure, Roadmap>> getRoadmap({
    required String chapterId,
  }) async {
    return await _roadmapApiService.getRoadmap(chapterId: chapterId);
  }
}
