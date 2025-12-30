import 'package:flutter_bloc/flutter_bloc.dart';

import 'keo_tha_state.dart';

enum DropTarget { first, second, result }

class KeoThaCubit extends Cubit<KeoThaState> {
  KeoThaCubit() : super(KeoThaState.initial());

  /// Kéo số vào ô đích
  void dropNumber(int number, DropTarget target) {
    // Xóa số khỏi vị trí cũ nếu đã được đặt
    var newState = state;

    if (state.firstNumber == number) {
      newState = newState.copyWith(clearFirst: true);
    }
    if (state.secondNumber == number) {
      newState = newState.copyWith(clearSecond: true);
    }
    if (state.resultNumber == number) {
      newState = newState.copyWith(clearResult: true);
    }

    // Đặt số vào vị trí mới
    switch (target) {
      case DropTarget.first:
        // Nếu ô đã có số, trả số đó về
        newState = newState.copyWith(firstNumber: number, clearIsCorrect: true);
        break;
      case DropTarget.second:
        newState = newState.copyWith(
          secondNumber: number,
          clearIsCorrect: true,
        );
        break;
      case DropTarget.result:
        newState = newState.copyWith(
          resultNumber: number,
          clearIsCorrect: true,
        );
        break;
    }

    emit(newState);
  }

  /// Xóa số khỏi ô (trả về danh sách kéo)
  void removeFromSlot(DropTarget target) {
    switch (target) {
      case DropTarget.first:
        emit(state.copyWith(clearFirst: true, clearIsCorrect: true));
        break;
      case DropTarget.second:
        emit(state.copyWith(clearSecond: true, clearIsCorrect: true));
        break;
      case DropTarget.result:
        emit(state.copyWith(clearResult: true, clearIsCorrect: true));
        break;
    }
  }

  /// Kiểm tra đáp án
  bool submit() {
    // Kiểm tra đã điền đủ 3 ô chưa
    if (!_isAllFieldsFilled()) {
      return false;
    }

    // Kiểm tra xem phép toán có đúng không
    final isCorrect = _validateEquation();

    if (isCorrect) {
      // Nếu đúng, chỉ lưu trạng thái đúng
      emit(state.copyWith(isCorrect: isCorrect));
    } else {
      // Nếu sai, trước tiên hiển thị sai (các số sẽ chuyển sang màu đỏ)
      emit(state.copyWith(isCorrect: isCorrect));

      // Sau đó delay một chút để người dùng thấy các số bị sai
      // Rồi tự động rơi xuống (xóa khỏi ô)
      Future.delayed(const Duration(milliseconds: 700), () {
        emit(
          state.copyWith(
            clearFirst: true,
            clearSecond: true,
            clearResult: true,
            clearIsCorrect: true,
          ),
        );
      });
    }

    return isCorrect;
  }

  /// Kiểm tra xem đã điền đủ 3 ô chưa
  bool _isAllFieldsFilled() {
    return state.firstNumber != null &&
        state.secondNumber != null &&
        state.resultNumber != null;
  }

  /// Kiểm tra xem phép toán có đúng không: firstNumber + secondNumber == resultNumber
  bool _validateEquation() {
    final expectedResult = _calculateExpectedResult();
    return state.resultNumber == expectedResult;
  }

  /// Tính toán kết quả đúng: firstNumber + secondNumber
  int _calculateExpectedResult() {
    return (state.firstNumber ?? 0) + (state.secondNumber ?? 0);
  }

  /// Reset game
  void reset() {
    emit(KeoThaState.initial());
  }
}
