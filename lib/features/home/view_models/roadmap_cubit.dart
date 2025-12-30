import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math/features/home/models/roadmap.dart';
import 'package:math/features/home/repositories/roadmap_repository.dart';

sealed class RoadmapState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoadmapInitial extends RoadmapState {}

class RoadmapLoading extends RoadmapState {}

class RoadmapsLoaded extends RoadmapState {
  final Roadmap roadmap;

  RoadmapsLoaded(this.roadmap);

  @override
  List<Object?> get props => [roadmap];
}

class RoadmapError extends RoadmapState {
  final String message;

  RoadmapError(this.message);

  @override
  List<Object?> get props => [message];
}

class RoadmapCubit extends Cubit<RoadmapState> {
  final RoadmapRepository getAllRoadmaps;

  RoadmapCubit({required this.getAllRoadmaps}) : super(RoadmapInitial());

  Future<void> getRoadmaps({required String chapterId}) async {
    emit(RoadmapLoading());

    try {
      final res = await getAllRoadmaps.getRoadmap(chapterId: chapterId);

      res.fold(
        (failure) => emit(RoadmapError(failure.message)),
        (data) => emit(RoadmapsLoaded(data)),
      );
    } catch (e) {
      emit(RoadmapError(e.toString()));
    }
  }
}
