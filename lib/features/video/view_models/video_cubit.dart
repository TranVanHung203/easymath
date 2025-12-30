import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math/features/video/models/video.dart';
import 'package:math/features/video/repositories/video_repository.dart';

sealed class VideoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideosLoaded extends VideoState {
  final Video video;

  VideosLoaded(this.video);

  @override
  List<Object?> get props => [video];
}

class VideoDetailLoaded extends VideoState {
  final Video video;

  VideoDetailLoaded(this.video);

  @override
  List<Object?> get props => [video];
}

class VideoError extends VideoState {
  final String message;

  VideoError(this.message);

  @override
  List<Object?> get props => [message];
}

class VideoCubit extends Cubit<VideoState> {
  final VideoRepository getAllVideos;

  VideoCubit({required this.getAllVideos}) : super(VideoInitial());

  Future<void> getVideos({required String videoId}) async {
    emit(VideoLoading());

    try {
      final res = await getAllVideos.getVideo(videoId: videoId);

      res.fold(
        (failure) => emit(VideoError(failure.message)),
        (data) => emit(VideosLoaded(data)),
      );
    } catch (e) {
      emit(VideoError(e.toString()));
    }
  }
}
