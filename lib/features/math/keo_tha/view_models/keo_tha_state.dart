import 'package:equatable/equatable.dart';

class KeoThaState extends Equatable {
  final int? firstNumber; // Số thứ nhất (ô đầu tiên)
  final int? secondNumber; // Số thứ hai (ô thứ hai)
  final int? resultNumber; // Kết quả (ô thứ ba)
  final List<int> availableNumbers; // Các số có sẵn để kéo
  final bool? isCorrect; // null = chưa submit, true/false = kết quả
  final int correctFirst; // Đáp án đúng cho ô đầu tiên
  final int correctSecond; // Đáp án đúng cho ô thứ hai
  final int correctResult; // Đáp án đúng cho kết quả

  const KeoThaState({
    this.firstNumber,
    this.secondNumber,
    this.resultNumber,
    required this.availableNumbers,
    this.isCorrect,
    required this.correctFirst,
    required this.correctSecond,
    required this.correctResult,
  });

  factory KeoThaState.initial() {
    // Bài toán: 12 + 24 = 36
    return const KeoThaState(
      firstNumber: null,
      secondNumber: null,
      resultNumber: null,
      availableNumbers: [12, 24, 36],
      isCorrect: null,
      correctFirst: 12,
      correctSecond: 24,
      correctResult: 36,
    );
  }

  KeoThaState copyWith({
    int? firstNumber,
    int? secondNumber,
    int? resultNumber,
    List<int>? availableNumbers,
    bool? isCorrect,
    int? correctFirst,
    int? correctSecond,
    int? correctResult,
    bool clearFirst = false,
    bool clearSecond = false,
    bool clearResult = false,
    bool clearIsCorrect = false,
  }) {
    return KeoThaState(
      firstNumber: clearFirst ? null : (firstNumber ?? this.firstNumber),
      secondNumber: clearSecond ? null : (secondNumber ?? this.secondNumber),
      resultNumber: clearResult ? null : (resultNumber ?? this.resultNumber),
      availableNumbers: availableNumbers ?? this.availableNumbers,
      isCorrect: clearIsCorrect ? null : (isCorrect ?? this.isCorrect),
      correctFirst: correctFirst ?? this.correctFirst,
      correctSecond: correctSecond ?? this.correctSecond,
      correctResult: correctResult ?? this.correctResult,
    );
  }

  /// Kiểm tra xem một số đã được sử dụng chưa
  bool isNumberUsed(int number) {
    return firstNumber == number ||
        secondNumber == number ||
        resultNumber == number;
  }

  /// Lấy danh sách các số chưa sử dụng
  List<int> get unusedNumbers {
    return availableNumbers.where((n) => !isNumberUsed(n)).toList();
  }

  @override
  List<Object?> get props => [
    firstNumber,
    secondNumber,
    resultNumber,
    availableNumbers,
    isCorrect,
    correctFirst,
    correctSecond,
    correctResult,
  ];
}
