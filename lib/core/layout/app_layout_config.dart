import 'package:flutter/material.dart';

class AppLayoutConfig {
  final double titleSize;
  final double descriptionSize;
  final double iconSize;
  final EdgeInsets padding;
  final double maxWidth;

  const AppLayoutConfig({
    required this.titleSize,
    required this.descriptionSize,
    required this.iconSize,
    required this.padding,
    required this.maxWidth,
  });

  // 📱 Mobile
  factory AppLayoutConfig.mobile() => const AppLayoutConfig(
    titleSize: 24,
    descriptionSize: 16,
    iconSize: 20,
    padding: EdgeInsets.all(16),
    maxWidth: double.infinity,
  );

  // 📱 Tablet
  factory AppLayoutConfig.tablet() => const AppLayoutConfig(
    titleSize: 28,
    descriptionSize: 18,
    iconSize: 40,
    padding: EdgeInsets.symmetric(horizontal: 32),
    maxWidth: 600,
  );

  // 🖥 Desktop
  factory AppLayoutConfig.desktop() => const AppLayoutConfig(
    titleSize: 52,
    descriptionSize: 30,
    iconSize: 50,
    padding: EdgeInsets.symmetric(horizontal: 48),
    maxWidth: 720,
  );
}
// MỞ RỘNG
// class SliderGameLayoutConfig extends AppLayoutConfig {
//   final double sliderSize;

//   const SliderGameLayoutConfig({
//     required super.titleSize,
//     required super.valueSize,
//     required super.iconSize,
//     required super.padding,
//     required super.maxWidth,
//     required this.sliderSize,
//   });

//   factory SliderGameLayoutConfig.mobile() {
//     final base = AppLayoutConfig.mobile();
//     return SliderGameLayoutConfig(
//       titleSize: base.titleSize,
//       valueSize: base.valueSize,
//       iconSize: base.iconSize,
//       padding: base.padding,
//       maxWidth: base.maxWidth,
//       sliderSize: 20,
//     );
//   }

//   factory SliderGameLayoutConfig.tablet() {
//     final base = AppLayoutConfig.tablet();
//     return SliderGameLayoutConfig(
//       titleSize: base.titleSize,
//       valueSize: base.valueSize,
//       iconSize: base.iconSize,
//       padding: base.padding,
//       maxWidth: base.maxWidth,
//       sliderSize: 40,
//     );
//   }

//   factory SliderGameLayoutConfig.desktop() {
//     final base = AppLayoutConfig.desktop();
//     return SliderGameLayoutConfig(
//       titleSize: base.titleSize,
//       valueSize: base.valueSize,
//       iconSize: base.iconSize,
//       padding: base.padding,
//       maxWidth: base.maxWidth,
//       sliderSize: 60,
//     );
//   }
// }
