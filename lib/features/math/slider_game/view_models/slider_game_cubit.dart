import 'package:flutter_bloc/flutter_bloc.dart';

import 'slider_game_state.dart';

class SliderGameCubit extends Cubit<SliderGameState> {
  SliderGameCubit() : super(SliderGameState.initial());

  void updateCurrent(double value) {
    emit(state.copyWith(current: value, isSuccess: null));
  }

  void reset() {
    emit(SliderGameState.initial());
  }

  bool submit() {
    final success = state.current.round() == state.target;
    emit(state.copyWith(isSuccess: success));
    return success;
  }
}
