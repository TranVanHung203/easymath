import 'package:dartz/dartz.dart';
import 'package:math/core/error/failure.dart';
import 'package:math/features/video/models/video.dart';
import 'package:math/features/video/services/video_api_service.dart';

class VideoRepository {
  final VideoApiService _videoApiService;

  VideoRepository({required VideoApiService videoApiService})
    : _videoApiService = videoApiService;
  Future<Either<Failure, Video>> getVideo({required String videoId}) async {
    return await _videoApiService.getVideo(videoId: videoId);
  }
}
