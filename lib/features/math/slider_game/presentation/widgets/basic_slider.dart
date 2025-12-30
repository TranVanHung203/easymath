import 'package:flutter/material.dart';
import 'package:math/core/utils/theme/app_color.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class BasicSlider extends StatelessWidget {
  final double current;
  final ValueChanged<double> onChanged;
  final double size;
  final double textSize;

  const BasicSlider({
    super.key,
    required this.current,
    required this.onChanged,
    required this.textSize,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SfSliderTheme(
      data: SfSliderThemeData(
        activeTrackHeight: size + 8,
        inactiveTrackHeight: size + 8,
        activeTrackColor: AppColor.primary600,
        inactiveTrackColor: AppColor.primary600.withValues(alpha: 0.3),
        thumbColor: Colors.white,
        thumbStrokeColor: AppColor.primary600,
        thumbStrokeWidth: 3,
        activeTickColor: Colors.blue,
        inactiveTickColor: Colors.grey,
        activeLabelStyle: TextStyle(
          fontSize: textSize + 2,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        inactiveLabelStyle: TextStyle(
          fontSize: textSize + 2,
          color: Colors.grey,
        ),

        tooltipBackgroundColor: Colors.blue,
        tooltipTextStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        thumbRadius: size + 10,
      ),
      child: SfSlider(
        thumbIcon: Image.asset('assets/train.png', fit: BoxFit.contain),
        min: 0.0,
        max: 100.0,
        value: current,
        interval: 10,
        showTicks: true,
        showLabels: true,
        stepSize: 10,
        enableTooltip: true,
        minorTicksPerInterval: 1,
        onChanged: (dynamic value) => onChanged(value as double),
      ),
    );
  }
}

class TrainCarsOverlay extends StatelessWidget {
  final double value;
  const TrainCarsOverlay({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    // mỗi 10 đơn vị = 1 toa
    final int carCount = (value ~/ 10);

    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double maxWidth = constraints.maxWidth;
          final double trainX = maxWidth * (value / 100);

          return Stack(
            children: List.generate(carCount, (index) {
              final double offsetX = trainX - ((index + 1) * 45);

              if (offsetX < 0) return const SizedBox();

              return Positioned(
                left: offsetX,
                top: 0,
                child: Image.asset('assets/train.png', width: 40, height: 40),
              );
            }),
          );
        },
      ),
    );
  }
}
