import 'package:equatable/equatable.dart';

class SliderGameState extends Equatable {
  final int target;
  final double current;
  final bool? isSuccess; // null = no submission yet, true/false = result

  const SliderGameState({
    required this.target,
    required this.current,
    this.isSuccess,
  });

  factory SliderGameState.initial() {
    return SliderGameState(target: _randomTarget(), current: 50.0);
  }

  SliderGameState copyWith({int? target, double? current, bool? isSuccess}) =>
      SliderGameState(
        target: target ?? this.target,
        current: current ?? this.current,
        isSuccess: isSuccess,
      );

  static int _randomTarget() =>
      DateTime.now().millisecondsSinceEpoch.remainder(101);

  @override
  List<Object?> get props => [target, current, isSuccess];
}
