// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:math/features/activities/models/activities_response.dart';
// import 'package:math/features/activities/repositories/activities_repository.dart';

// sealed class ActivitiesState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class ActivitiesInitial extends ActivitiesState {}

// class ActivitiessLoaded extends ActivitiesState {
//   final ActivitiesResponse activitiesResponse;

//   ActivitiessLoaded(this.activitiesResponse);

//   @override
//   List<Object?> get props => [activitiesResponse];
// }

// class ActivitiesError extends ActivitiesState {
//   final String message;

//   ActivitiesError(this.message);

//   @override
//   List<Object?> get props => [message];
// }

// class ActivitiesCubit extends Cubit<ActivitiesState> {
//   final ActivitiesRepository getAllActivitiess;

//   ActivitiesCubit({required this.getAllActivitiess})
//     : super(ActivitiesInitial());

//   Future<void> getActivitiess() async {
//     try {
//       final res = await getAllActivitiess.getActivities();

//       res.fold(
//         (failure) => emit(ActivitiesError(failure.message)),
//         (data) => emit(ActivitiessLoaded(data)),
//       );
//     } catch (e) {
//       emit(ActivitiesError(e.toString()));
//     }
//   }
// }

//   b
