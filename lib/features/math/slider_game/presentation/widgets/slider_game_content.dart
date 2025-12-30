import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math/core/layout/app_layout_config.dart';
import 'package:math/features/math/slider_game/presentation/widgets/basic_slider.dart';
import 'package:math/features/math/slider_game/view_models/slider_game_cubit.dart';
import 'package:math/features/math/slider_game/view_models/slider_game_state.dart';

class SliderGameContent extends StatelessWidget {
  final AppLayoutConfig config;
  const SliderGameContent({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: config.padding,
          child: BlocBuilder<SliderGameCubit, SliderGameState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Target: ${state.target} ${config.titleSize}',
                    style: TextStyle(fontSize: config.titleSize),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Current: ${state.current.round()}',
                    style: TextStyle(fontSize: config.titleSize),
                  ),
                  BasicSlider(
                    size: config.iconSize,
                    textSize: config.titleSize,
                    current: state.current,
                    onChanged: (value) {
                      context.read<SliderGameCubit>().updateCurrent(value);
                    },
                  ),
                  _buildButtons(context),
                  _buildResult(state),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => context.read<SliderGameCubit>().reset(),
          child: const Text('Reset'),
        ),
        ElevatedButton(
          onPressed: () {
            final success = context.read<SliderGameCubit>().submit();
            final messenger = ScaffoldMessenger.of(context);
            messenger.showSnackBar(
              SnackBar(
                content: Text(success ? 'Correct! 🎉' : 'Wrong, try again ⚠️'),
                backgroundColor: success ? Colors.green : Colors.red,
              ),
            );
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  Widget _buildResult(SliderGameState state) {
    if (state.isSuccess == true) {
      return const Text(
        'You matched the number! Press Reset to play again.',
        style: TextStyle(color: Colors.green),
      );
    } else if (state.isSuccess == false) {
      return const Text(
        'Not matched, try adjusting the slider.',
        style: TextStyle(color: Colors.red),
      );
    }
    return const SizedBox.shrink();
  }
}
