import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math/features/math/keo_tha/view_models/keo_tha_cubit.dart';
import 'package:math/features/math/keo_tha/view_models/keo_tha_state.dart';

class KeoThaPage extends StatelessWidget {
  const KeoThaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => KeoThaCubit(),
      child: const _KeoThaView(),
    );
  }
}

class _KeoThaView extends StatelessWidget {
  const _KeoThaView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<KeoThaCubit, KeoThaState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Spacer(),
                // Phương trình: ○ + ○ = ○
                _buildEquation(context, state),
                const SizedBox(height: 48),
                // Các số để kéo
                _buildDraggableNumbers(context, state),
                const Spacer(),
                // Nút Submit và Reset
                _buildButtons(context, state),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEquation(BuildContext context, KeoThaState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Ô số thứ nhất
        _buildDropSlot(
          context: context,
          value: state.firstNumber,
          target: DropTarget.first,
          isCorrect: state.isCorrect,
          correctValue: state.correctFirst,
        ),
        const SizedBox(width: 16),
        const Text(
          '+',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 16),
        // Ô số thứ hai
        _buildDropSlot(
          context: context,
          value: state.secondNumber,
          target: DropTarget.second,
          isCorrect: state.isCorrect,
          correctValue: state.correctSecond,
        ),
        const SizedBox(width: 16),
        const Text(
          '=',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 16),
        // Ô kết quả
        _buildDropSlot(
          context: context,
          value: state.resultNumber,
          target: DropTarget.result,
          isCorrect: state.isCorrect,
          correctValue: state.correctResult,
        ),
      ],
    );
  }

  Widget _buildDropSlot({
    required BuildContext context,
    required int? value,
    required DropTarget target,
    required bool? isCorrect,
    required int correctValue,
  }) {
    // Xác định màu border dựa trên trạng thái
    Color borderColor = Colors.grey;
    if (isCorrect != null && value != null) {
      borderColor = value == correctValue ? Colors.green : Colors.red;
    }

    return DragTarget<int>(
      onWillAcceptWithDetails: (details) => true,
      onAcceptWithDetails: (details) {
        context.read<KeoThaCubit>().dropNumber(details.data, target);
      },
      builder: (context, candidateData, rejectedData) {
        final isHovering = candidateData.isNotEmpty;

        return GestureDetector(
          onTap: value != null
              ? () => context.read<KeoThaCubit>().removeFromSlot(target)
              : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: isHovering
                  ? Colors.blue.withValues(alpha: 0.2)
                  : Colors.white,
              border: Border.all(
                color: isHovering ? Colors.blue : borderColor,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: value != null
                  ? Draggable<int>(
                      data: value,
                      // feedback hiển thị theo tay
                      feedback: _buildDraggingNumber(value),
                      childWhenDragging: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        '$value',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: isCorrect == null
                              ? Colors.black
                              : (value == correctValue
                                    ? Colors.green
                                    : Colors.red),
                        ),
                      ),
                    )
                  : const Text(
                      '?',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDraggableNumbers(BuildContext context, KeoThaState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: state.availableNumbers.map((number) {
        final isUsed = state.isNumberUsed(number);

        if (isUsed) {
          return Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.withValues(alpha: 0.3),
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
          );
        }

        return Draggable<int>(
          data: number,
          // feedback hiển thị theo tay
          feedback: _buildDraggingNumber(number),
          childWhenDragging: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withValues(alpha: 0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDraggingNumber(int number) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.6),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Text(
            '$number',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context, KeoThaState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Nút Reset
        ElevatedButton.icon(
          onPressed: () => context.read<KeoThaCubit>().reset(),
          icon: const Icon(Icons.refresh),
          label: const Text('Làm lại'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        // Nút Submit
        ElevatedButton.icon(
          onPressed: () {
            final cubit = context.read<KeoThaCubit>();
            final currentState = cubit.state;

            // Kiểm tra đã điền đủ chưa
            if (currentState.firstNumber == null ||
                currentState.secondNumber == null ||
                currentState.resultNumber == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Vui lòng điền đủ 3 ô!'),
                  backgroundColor: Colors.orange,
                ),
              );
              return;
            }

            final isCorrect = cubit.submit();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isCorrect ? 'Chính xác! 🎉' : 'Sai rồi! Hãy thử lại ❌',
                ),
                backgroundColor: isCorrect ? Colors.green : Colors.red,
              ),
            );
          },
          icon: const Icon(Icons.check),
          label: const Text('Kiểm tra'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }
}
