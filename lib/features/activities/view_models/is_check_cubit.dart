import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math/features/activities/repositories/activities_repository.dart';

class IsCheckCubit extends Cubit<int> {
  final ActivitiesRepository activitiesRepository;

  IsCheckCubit({required this.activitiesRepository}) : super(0);

  Future<void> checkProgress({
    required String progressId,
    required String videoId,
  }) async {
    try {
      final res = await activitiesRepository.postActivities(
        progressId: progressId,
        videoId: videoId,
      );
      res.fold(
        (failure) {
          emit(0);
        },
        (data) {
          if (data.isCheck == false) {
            if (data.isDone == true) {
              emit(3);
            } else {
              emit(2);
            }
          } else {
            emit(1);
          }
        },
      );
    } catch (_) {
      emit(0);
    }
  }
}
