import 'package:flutter/material.dart';
import 'package:math/core/layout/app_layout_config.dart';
import 'package:math/core/responsive/responsive_widget.dart';
import 'package:math/features/math/slider_game/presentation/widgets/slider_game_content.dart';

class SliderGameResponsiveLayout extends StatelessWidget {
  const SliderGameResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: SliderGameContent(config: AppLayoutConfig.mobile()),
      tablet: SliderGameContent(config: AppLayoutConfig.tablet()),
      desktop: SliderGameContent(config: AppLayoutConfig.desktop()),
    );
  }
}
