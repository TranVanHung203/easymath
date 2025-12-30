import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math/features/progress/models/progress.dart';
import 'package:math/features/progress/repositories/progress_repository.dart';

sealed class ProgressState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProgressInitial extends ProgressState {}

class ProgressLoading extends ProgressState {}

class ProgressLoaded extends ProgressState {
  final Progress progress;

  ProgressLoaded(this.progress);

  @override
  List<Object?> get props => [progress];
}

class ProgressError extends ProgressState {
  final String message;

  ProgressError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProgressCubit extends Cubit<ProgressState> {
  final ProgressRepository getAllProgresss;

  ProgressCubit({required this.getAllProgresss}) : super(ProgressInitial());

  Future<void> fetchProgress({required String progressId}) async {
    emit(ProgressLoading());

    try {
      final res = await getAllProgresss.getProgress(progressId: progressId);

      res.fold(
        (failure) => emit(ProgressError(failure.message)),
        (data) => emit(ProgressLoaded(data)),
      );
    } catch (e) {
      emit(ProgressError(e.toString()));
    }
  }

  void markItemCompleted({required String contentId}) {
    final currentState = state;

    if (currentState is ProgressLoaded) {
      final oldProgress = currentState.progress;

      final updatedContent = oldProgress.content.map((item) {
        if (item.id == contentId) {
          return item.copyWith(isCompleted: true);
        }
        return item;
      }).toList();

      final updatedProgress = oldProgress.copyWith(content: updatedContent);

      emit(ProgressLoaded(updatedProgress));
    }
  }
}
