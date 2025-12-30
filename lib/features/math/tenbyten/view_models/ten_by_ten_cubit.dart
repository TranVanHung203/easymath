import 'package:flutter_bloc/flutter_bloc.dart';

class TenByTenState {
  final List<bool> cells;
  final int target;
  final int nextIndex;
  final String? message;
  final bool success;
  final bool showGuide;

  TenByTenState({
    required this.cells,
    required this.target,
    required this.nextIndex,
    this.message,
    this.success = false,
    this.showGuide = false,
  });

  factory TenByTenState.initial() {
    return TenByTenState(
      cells: List<bool>.filled(100, false),
      target: 15,
      nextIndex: 0,
      showGuide: true,
    );
  }

  TenByTenState copyWith({
    List<bool>? cells,
    int? target,
    int? nextIndex,
    String? message,
    bool? success,
    bool? showGuide,
  }) {
    return TenByTenState(
      cells: cells ?? this.cells,
      target: target ?? this.target,
      nextIndex: nextIndex ?? this.nextIndex,
      message: message,
      success: success ?? this.success,
      showGuide: showGuide ?? this.showGuide,
    );
  }
}

class TenByTenCubit extends Cubit<TenByTenState> {
  TenByTenCubit() : super(TenByTenState.initial());

  void fillCell(int index) {
    if (index != state.nextIndex) return;
    if (state.cells[index]) return;

    final newCells = List<bool>.from(state.cells);
    newCells[index] = true;

    emit(
      state.copyWith(
        cells: newCells,
        nextIndex: state.nextIndex + 1,
        message: null,
        showGuide: false,
      ),
    );
  }

  void hideGuide() {
    if (!state.showGuide) return;
    emit(state.copyWith(showGuide: false));
  }

  void reset() {
    emit(TenByTenState.initial());
  }

  void submit() {
    final filled = state.cells.where((e) => e).length;

    if (filled == state.target) {
      emit(state.copyWith(success: true));
    } else {
      emit(state.copyWith(message: 'Bạn bôi $filled ô, cần ${state.target} ô'));
    }
  }
}
