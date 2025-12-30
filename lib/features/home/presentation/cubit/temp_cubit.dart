import 'package:flutter_bloc/flutter_bloc.dart';

class TempState {}

class TempInitial extends TempState {}

class TempLoader extends TempState {
  final int lessonId;
  final bool isLoading;

  TempLoader(this.lessonId, {this.isLoading = false});
}

class TempCubit extends Cubit<TempState> {
  TempCubit() : super(TempInitial());

  void showLoader(int lessonId, bool isLoading) {
    emit(TempLoader(lessonId, isLoading: isLoading));
  }

  void initializeList() {
    emit(TempLoader(0)); // Emit TempLoader with a default lessonId
  }
}
